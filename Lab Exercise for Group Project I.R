options(digits = 4)

#1

# Microsoft: X ~ N(0.05, (0.10)^2
mu.r = 0.05
sd.r = 0.10
x.vals = seq(-0.25, 0.35, length=150)*sd.r + mu.r
plot(x.vals, dnorm(x.vals, mean=mu.r, sd=sd.r), type="l", lwd=2, 
     col="blue", xlab="x", ylab="pdf")
pnorm(-0.5, mean=0.05, sd=0.1)
pnorm(0, mean=0.05, sd=0.1)
1 - pnorm(0.5, mean=0.05, sd=0.1)
1 - pnorm(1, mean=0.05, sd=0.1)

a.vals = c(0.01, 0.05, 0.95, 0.99)
qnorm(a.vals, mean=0.05, sd=0.1)


# Starbucks: R ~ N(0.025, (0.05)^2)
mu.r = 0.025
sd.r = 0.05
x.vals = seq(-0.25, 0.35, length=150)*sd.r + mu.r
plot(x.vals, dnorm(x.vals, mean=mu.r, sd=sd.r), type="l", lwd=2, 
     col="blue", xlab="x", ylab="pdf")
pnorm(-0.5, mean=0.025, sd=0.05)
pnorm(0, mean=0.025, sd=0.05)
1 - pnorm(0.5, mean=0.025, sd=0.05)
1 - pnorm(1, mean=0.025, sd=0.05)

a.vals = c(0.01, 0.05, 0.95, 0.99)
qnorm(a.vals, mean=0.025, sd=0.05)


# risk-return tradeoff
mu.r = 0.05
sd.r = 0.1
x.vals = seq(-3, 3, length=150)*sd.r + mu.r
plot(x.vals, dnorm(x.vals, mean=mu.r, sd=sd.r), type="l", lwd=2, 
     ylim=c(0, max(dnorm(x.vals, mean=0.025, sd=0.05))),
     col="black", xlab="x", ylab="pdf")
points(x.vals, dnorm(x.vals, mean=0.025, sd=0.05), type="l", lwd=2,
       col="blue", lty="dotted")
segments(0.05, 0, 0.05, dnorm(0.05, mean=0.05, sd=0.1), lwd=2)
segments(0.025, 0, 0.025, dnorm(0.025, mean=0.025, sd=0.05), lwd=2, 
         col="blue", lty="dotted")
legend(x="topleft", legend=c("Microsoft", "Starbucks"), lwd=2,
       col=c("black", "blue"), lty=c("solid","dotted"))
# Microsoft has a high mean but a large standard deviation.
# Therefore, the Microsoft's risk is high.
# Starbucks has a lower mean than Microsoft's, but a smaller standard deviation.
# Therefore, the Starbuck's risk is low.




#2

# Value-at-Risk calculations
#
# R(t) ~ N(0.04, (0.09)^2)
# W = 100000
w0 = 100000
# plot return and wealth distributions
mu.R = 0.04
sd.R = 0.09
R.vals = seq(from=(mu.R - 3*sd.R), to=(mu.R + 3*sd.R), length = 100)
mu.w1 = 104000
sd.w1 = 9000
w1.vals = seq(from=(mu.w1 - 3*sd.w1), to=(mu.w1 + 3*sd.w1), length = 100)

par(mfrow=c(2,1))
# plot return density
plot(R.vals, dnorm(R.vals, mean=mu.R, sd=sd.R), type="l", 
     main="R(t) ~ N(0.04,(0.09)^2)", xlab="R", ylab="pdf",
     lwd=2, col="blue")
# plot wealth density
plot(w1.vals, dnorm(w1.vals, mean=mu.w1, sd=sd.w1), type="l", 
     main="W1 ~ N(104,000,(9,000)^2)", xlab="W1", ylab="pdf",
     lwd=2, col="blue")
par(mfrow=c(1,1))

# Pr(W1 < 90000)
pnorm(90000, mu.w1, sd.w1)
qnorm(pnorm(90000, mu.w1, sd.w1), mu.w1, sd.w1)

# compute 5% quantile of return and wealth distributions
q.R.05 = qnorm(0.05, mu.R, sd.R)
q.R.05
q.w1.05 = qnorm(0.05, mu.w1, sd.w1)
q.w1.05

# compute 5% VaR using return quantile
w0*q.R.05

# compute 5% VaR using wealth quantile
q.w1.05 - w0

# compute 1% quantile of return and wealth distributions
q.R.01 = qnorm(0.01, mu.R, sd.R)
q.R.01
q.w1.01 = qnorm(0.01, mu.w1, sd.w1)
q.w1.01

# compute 1% VaR using return quantile
w0*q.R.01

# compute 1% VaR using wealth quantile
q.w1.01 - w0

# plot return and loss distributions with VaR
loss.vals = w0*R.vals
mu.loss = w0*mu.R
sd.loss = w0*sd.R
par(mfrow=c(2,1))
# plot return density
plot(R.vals, dnorm(R.vals, mean=mu.R, sd=sd.R), type="l", 
     main="R(t) ~ N(0.04,(0.09)^2)", xlab="R", ylab="pdf",
     lwd=2, col="blue")
abline(v=q.R.05, lwd=2, col="red")     
abline(v=q.R.01, lwd=2, col="green")
# plot wealth density
plot(loss.vals, dnorm(loss.vals, mean=mu.loss, sd=sd.loss), type="l", 
     main="R*W0 ~ N(4,000,(9,000)^2)", xlab="W0*R", ylab="pdf",
     lwd=2, col="blue")
abline(v=q.R.05*w0, lwd=2, col="red")       
abline(v=q.R.01*w0, lwd=2, col="green")
par(mfrow=c(1,1))

# VaR example
mu.R = 0.04
sd.R = 0.09
w0 = 100000
q.01.R = mu.R + sd.R*qnorm(0.01)
q.05.R = mu.R + sd.R*qnorm(0.05)
VaR.01 = abs(q.01.R*w0)
VaR.05 = abs(q.05.R*w0)
VaR.01
VaR.05


# 3

w0 = 100000
# monthly VaR
mu.r = 0.04
sd.r = 0.09
q.01.R = exp(mu.r + sd.r*qnorm(0.01)) - 1
q.05.R = exp(mu.r + sd.r*qnorm(0.05)) - 1
VaR.01 = abs(q.01.R*w0)
VaR.05 = abs(q.05.R*w0)
VaR.01
VaR.05

# annual VaR
mu.r = 0.04*12
sd.r = 0.09*sqrt(12)
q.01.R = exp(mu.r + sd.r*qnorm(0.01)) - 1
q.05.R = exp(mu.r + sd.r*qnorm(0.05)) - 1
VaR.01 = abs(q.01.R*w0)
VaR.05 = abs(q.05.R*w0)
VaR.01
VaR.05
