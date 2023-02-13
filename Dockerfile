FROM nexus.devops-e.de:8090/ema/docker-rails@sha256:b51e6b7935aec20b640aff3e89378a5391b0f6e1bac3811d7de6815bd5bdfcbf

RUN apt-get install libicu-dev

ADD https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb /tmp
RUN apt install -y /tmp/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb

ENV APPDIR=/app \
  RAILS_PORT=3000 \
  RAILS_ENV=development \
  RAILS_LOG_TO_STDOUT=true

WORKDIR $APPDIR

# Rails Dependencies
COPY Gemfile* $APPDIR/
RUN bundle config set deployment 'true'
RUN bundle --without="development test"

# NPM deps
COPY package.json $APPDIR/
COPY package-lock.json $APPDIR/

RUN npm install

COPY . $APPDIR/

RUN RAILS_ENV=staging NODE_ENV=staging \
  bundle exec rake assets:precompile \
  && mkdir -p $APPDIR/log \
  && mkdir -p $APPDIR/tmp \
  && mkdir -p $APPDIR/storage \
  && chown -R daemon:daemon $APPDIR/log \
  && chown -R daemon:daemon $APPDIR/tmp \
  && chown -R daemon:daemon $APPDIR/storage \
  && chown daemon:daemon $APPDIR/db/schema.rb

USER daemon:daemon

VOLUME $APPDIR/public

CMD bundle exec rake db:migrate && bundle exec puma -C config/puma.rb
