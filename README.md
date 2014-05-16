# Quadeight

## __BETA__
This gem is under active development and while certain functionality is
working, it is not complete.

Gem to allow interaction with the 8tracks api.

Check the specs to see whats currently working.

## Installation

    $ gem install quadeight

## Usage

This will be updated in the (hopefully) near future, for now, check the specs.
They have a lot of code that can help you get off the ground.

### Things to note
It reads your api key out of environment variables, so before using you should ensure that the environment variable `EIGHT_API_KEY` is set.
ex. `export EIGHT_API_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`

## Dev Notes

`Mix`s cache the tracks in a single mix, so the original order is preserved.  According to 8tracks documentation their license requires subsequent playback in a different order. Its left to the user to comply with this.

When iterating through `track`s in a `mix`, if the track comes from soundcloud, there is a length header in the http response, so it will wait the actual length of time for a song. If its served from 8tracks cdn, they are m4a files and they do not have this header, so I try to request the initial bytes of the file and read the length information from the m4a tags, but this is not currently working as far as I can tell. I think the structure of these m4as differs in some fundamental way from the standard. So it will just wait 240 seconds if it can't calculate a valid time from the m4a tags.


## Contributing

1. Fork it ( http://github.com/scottopell/quadeight/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Contributing Notes
Make sure any contributions add new tests and pass the existing tests.

I am using my own fork of mp4info, and you can't specify a gem from the gemspec, only from the Gemfile.
So this leads to an awkward process of commenting out the line `gemspec` from the Gemfile, bundling (`bundle install`), then uncommenting that line, and then re-bundling(`bundle exec bundle install`). This is my first real gem, so hopefully I'm just doing something wrong and the process isn't really this awkward, but its what I've been doing.
