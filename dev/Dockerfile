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

# Expose default hugo port
EXPOSE 1313

# Automatically build site
RUN mkdir /usr/share/site
WORKDIR /usr/share/site
COPY djherbis.com/ .
RUN rm -rf themes/hugo-theme-pixyll
RUN git clone https://github.com/azmelanar/hugo-theme-pixyll themes/hugo-theme-pixyll
ENV HUGO_BASE_URL http://localhost:1313
RUN hugo -d public -b ${HUGO_BASE_URL}

# By default, serve site
CMD hugo server -d public -b ${HUGO_BASE_URL} --bind=0.0.0.0