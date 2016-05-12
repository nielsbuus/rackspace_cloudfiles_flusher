# Easily empty or delete buckets/containers from Rackspace Cloudfiles

Before you can delete a container at Rackspace, it needs to be empty and Rackspace doesn't have any operation in their web interface to empty a whole container. Instead they force you to delete one file at a time or resort to third party tools. This is a questionable position to take, considering that you have to pay for every byte of data you store there, basically making it difficult to stop paying them for hosting files you no longer want hosted.

Anyway, here you get the tool that Rackspace should be offering out of the box.

It's still going to take a while to delete hundreds of thousands of files, but it's still way faster than doing it by hand.

It relies on the Fog library and it will use a thread pool to speed things up.

Before you can start flushing with `flush.rb`, you will need to define a `config.json` file with your credentials and the buckets you want to clear out.

After doing that, it's as easy as

    bundle install
    bundle exec ruby flush.rb

Lean back and enjoy the show.

## Example output

    Welcome to rackspace_cloudfiles_flusher - getting ready to flush old_project_uploads with 50 workers!
    Setting up queue with all those damn files...
    Queue contains: 0
    Queue contains: 25000
    Queue contains: 50000
    Queue contains: 75000
    Preparation completed - we are ready to delete 94596 objects from old_project_uploads!
    Deleted 3 out of 94596. We are 0.0 % done - estimated time left: 1 minutes.
    Deleted 542 out of 94596. We are 0.6 % done - estimated time left: 44 minutes.
    Deleted 1045 out of 94596. We are 1.1 % done - estimated time left: 46 minutes.
    Deleted 1580 out of 94596. We are 1.7 % done - estimated time left: 45 minutes.
    Deleted 2072 out of 94596. We are 2.2 % done - estimated time left: 46 minutes.
    Deleted 2511 out of 94596. We are 2.7 % done - estimated time left: 47 minutes.
    ...

## Performance

I have only used it once and was able to clear a bucket with 150.000 files in about an hour.


## Alternatives

If you prefer to use Python, there is also a tool called [turbolift](https://community.rackspace.com/products/f/25/t/1796), which does the same thing - and maybe faster, but with no progress output.
