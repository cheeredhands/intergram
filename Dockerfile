FROM node:alpine

RUN apk update && apk upgrade && \
    apk add --no-cache git

ENV HOME=/opt/intergram
ENV PORT=3000
RUN mkdir -p $HOME
WORKDIR $HOME

RUN git clone https://github.com/cheeredhands/intergram.git ${HOME}

RUN apk del git

RUN npm install
RUN npm run build

HEALTHCHECK CMD curl --fail http://localhost:${PORT} || exit 1

CMD npm run start
EXPOSE ${PORT}