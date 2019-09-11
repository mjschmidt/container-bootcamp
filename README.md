# Kubernetes Basics
> Getting up and running and learning Kubernetes from an end user perspective

<img src="images/Kubernetes-training-in-Hyderabad.jpg" width="600" height="300" align="center" />

## Purpose
There is a lot for me to learn about go, operators and more about how they work in kubernetes. It is important for me to keep my techincal skills strong as I don't know if management is the right track for me. The purpose of this project is for me to develop as a technical individual in a field that interests me.

### The definition of done is as follows:
- [ ] Recreate the OperatorSDK sdk example project and successfully fire that off into a minikube cluster
- [ ] Create an operator off the example that can dynamically scale out some nginx containers based on a config file
- [ ] Learn what the next steps would be to have that operator scale the nginx out based on web requests (aka, if I have <1 request a second over a period of 10 seconds run 1 pod, if more run 2)
- [ ] Implement the operator code to handle this simple logical feed back (aka operator keeps a counter or something? and time based can do some simple scaling)
