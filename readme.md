# Easily empty or delete buckets/containers from Rackspace Cloudfiles

Since Rackspace are run by troglodytes who thinks the ability to destroy/empty buckets is an unnecessary feature that no developer would ever need, this tool comes in handy to help you do that.

It's still going to take a while to delete hundreds of thousands of files, but it's still way faster than doing it by hand.

It relies on the Fog library and it will use a thread pool to speed things up.

Before you can start flushing with `flush.rb`, you will need to define a `config.rb` file with your credentials and the bucket you want to clear out.

After doing that, it's as easy as

    bundle install
    bundle exec ruby flush.rb

Lean back and enjoy the show.

## Performance

I have only used it once and was able to clear a bucket with 150.000 files in about an hour.
