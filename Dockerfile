FROM nexus.devops-e.de:8090/ema/docker-rails:3.0

RUN apt-get install libicu-dev

ENV APPDIR=/app \
  RAILS_PORT=3000 \
  RAILS_ENV=development \
  RAILS_LOG_TO_STDOUT=true

WORKDIR $APPDIR

# Rails Dependencies
COPY Gemfile* $APPDIR/
RUN bundle config set deployment 'true'
RUN bundle --without="development test"

# Yarn Dependencies
COPY package.json $APPDIR/
# COPY yarn.lock $APPDIR/

COPY . $APPDIR/

RUN bundle exec rake decidim:webpacker:install

RUN RAILS_ENV=production NODE_ENV=production \
  bundle exec rake assets:precompile \
  && mkdir -p $APPDIR/log \
  && mkdir -p $APPDIR/tmp \
  && chown -R daemon:daemon $APPDIR/log \
  && chown -R daemon:daemon $APPDIR/tmp \
  && chown daemon:daemon $APPDIR/db/schema.rb

USER daemon:daemon

VOLUME $APPDIR/public

CMD bundle exec rake db:migrate && bundle exec puma -C config/puma.rb
