# Container for building the app
FROM alpine:3.11.0 as build
WORKDIR /build
# Visit https://pkgs.alpinelinux.org/packages?name=nodejs to identify the
# version available. Different versions of the alpine image have different
# versions of nodejs available.
RUN apk add --update git make nodejs nodejs-npm jq sassc \
    && adduser -DSu 999 builder \
    && chown -R builder /build
USER builder
# See .dockerignore for what is excluded
COPY . .
RUN make build

FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY docker-files/etc/nginx/conf.d/static.conf /etc/nginx/conf.d/static.conf
COPY --chown=nobody --from=build /build/public ./public
RUN nginx -t
EXPOSE 80/tcp
CMD ["nginx", "-g", "daemon off;"]
