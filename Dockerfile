FROM ruby:2.3

WORKDIR /var/www

RUN groupadd -r gemstash --gid=9999 && \
      useradd -r -g gemstash --uid=9999 gemstash && \
      mkdir -p /home/gemstash/.gemstash && \
      mkdir -p /var/gemstash && \
      chown -R gemstash:gemstash /home/gemstash /var/gemstash

USER gemstash

ADD Gemfile* ./
RUN bundle install

ADD config.yml.erb /home/gemstash/.gemstash/

CMD ["bundle", "exec", "gemstash", "start", "--no-daemonize"]
