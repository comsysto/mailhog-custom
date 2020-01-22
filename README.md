# mailhog-custom

:bangbang: PUBLIC REPO :bangbang:

### Why and What?

We needed a [mailhog](https://github.com/mailhog/MailHog) docker image that can be deployed WITHOUT the use of a Volume.
Most of mailhog is already in-memory but the auth-file to secure the WEB GUI still needs a
file on disk. The aim of this custom-image is to provide ALL settings needed for us
via ENV vars.

### Build

```
docker build . -t mailhog-custom-auth
```

### Use

We support all [config env vars](https://github.com/mailhog/MailHog/blob/master/docs/CONFIG.md) BUT do not use `MH_AUTH_FILE` but use `MH_AUTH_FILE_CONTENT` instead which will be written to the `/opt/mailhog-auth`. It should contain bcrypted password hash and username as described in the [auth docs](https://github.com/mailhog/MailHog/blob/master/docs/Auth.md)

So basic usage would be for user `admin` with password `admin`:

```
docker run -i -t \
   -e MH_AUTH_FILE_CONTENT='admin:$2a$04$Yd3LV1RChuFwGeWS8dGrO.V1l7MkTztbVJi3vB7LKFD.gVxhkpdAq' \
   -e MH_HOSTNAME=mysuperhost \
   -p 1025:1025 \
   -p 8025:8025 \
   mailhog-custom-auth
```

### Code of Conduct

You can use this if you want. Fork it. But do not open issues or pull requests. We are not interested
in feature requests or can give you support. We simply share our solution with the world.

### License

[MIT](./LICENSE)
