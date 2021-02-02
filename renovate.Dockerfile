#--------------------------------------
# renovate rebuild trigger
#--------------------------------------

FROM ubuntu:bionic@sha256:ea188fdc5be9b25ca048f1e882b33f1bc763fb976a8a4fea446b38ed0efcbeba as latest
FROM ubuntu:bionic@sha256:ea188fdc5be9b25ca048f1e882b33f1bc763fb976a8a4fea446b38ed0efcbeba as bionic
FROM ubuntu:focal@sha256:703218c0465075f4425e58fac086e09e1de5c340b12976ab9eb8ad26615c3715 as focal
