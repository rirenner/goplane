# gobgp (part of Ryu SDN Framework)
#

FROM osrg/quagga

MAINTAINER FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

RUN apt-get update
RUN apt-get install -qy --no-install-recommends wget lv tcpdump emacs24-nox

ENV HOME /root
WORKDIR /root
WORKDIR /root

RUN go get github.com/rirenner/gobgp/gobgp
RUN go get github.com/rirenner/gobgp/gobgpd
RUN ln -s /go/src/github.com/rirenner/gobgp .

# goplane (part of Ryu SDN Framework)
#

ENV GO15VENDOREXPERIMENT 1
RUN curl https://glide.sh/get | sh
COPY . $GOPATH/src/github.com/rirenner/goplane/
RUN cd $GOPATH/src/github.com/rirenner/goplane && glide install
RUN go install github.com/rirenner/goplane
RUN go get github.com/socketplane/libovsdb
RUN cd $GOPATH/src/github.com/rirenner/goplane/vendor/github.com/rirenner/gobgp/gobgpd && go install
RUN cd $GOPATH/src/github.com/rirenner/goplane/vendor/github.com/rirenner/gobgp/gobgp && go install
