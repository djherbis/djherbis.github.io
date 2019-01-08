FROM debian:jessie
LABEL maintainer="me@djherbis.com"

# Install pygments (for syntax highlighting) 
RUN apt-get -qq update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends python-pygments git ca-certificates asciidoc \
	&& rm -rf /var/lib/apt/lists/*

# Download and install hugo
ENV HUGO_VERSION 0.48
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb

ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb \
	&& rm /tmp/hugo.deb

# Install themes
RUN mkdir /usr/share/themes
WORKDIR /usr/share/themes
RUN git clone https://github.com/azmelanar/hugo-theme-pixyll hugo-theme-pixyll

# Move to site dir
WORKDIR /usr/share/site