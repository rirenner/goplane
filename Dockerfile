# goplane (part of Ryu SDN Framework)
#

FROM osrg/gobgp

MAINTAINER ISHIDA Wataru <ishida.wataru@lab.ntt.co.jp>

ENV GO15VENDOREXPERIMENT 1
RUN curl https://glide.sh/get | sh
ADD . $GOPATH/src/github.com/rirenner/goplane/
RUN cd $GOPATH/src/github.com/rirenner/goplane && glide install
RUN go install github.com/rirenner/goplane
RUN go get github.com/socketplane/libovsdb
RUN cd $GOPATH/src/github.com/rirenner/goplane/vendor/github.com/rirenner/gobgp/gobgpd && go install
RUN cd $GOPATH/src/github.com/rirenner/goplane/vendor/github.com/rirenner/gobgp/gobgp && go install
