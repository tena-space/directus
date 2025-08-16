FROM ghcr.io/hazmi35/node:22.14.0-dev-alpine as build-stage

WORKDIR /tmp/build

RUN corepack enable && corepack prepare pnpm@latest

RUN apk add --no-cache build-base git python3

RUN pnpm add @directus-labs/collaborative-editing \
    @directus-labs/seo-plugin \
    @directus-labs/card-select-interfaces \
    @directus-labs/ai-image-generation-operation \
    @directus-labs/experimental-m2a-interface \
    @directus-labs/super-header-interface \
    @directus-labs/inline-repeater-interface \
    directus-extension-wpslug-interface \
    @directus-labs/simple-list-interface \
    directus-extension-group-tabs-interface \
    @directus-labs/command-palette-module

RUN mkdir -p /tmp/build && \
    cp -r node_modules/* /tmp/build/

FROM directus/directus:11.10.2
COPY --from=build-stage /builder/extensions /directus/extensions