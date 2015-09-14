# starkiller

Starkiller is a commandline Ruby application for generating filled PDFs of character sheets.

## Setup

Starkiller is built against Ruby 2.0 and requires Bundler and RVM. Once you have all three installed, do the following to set up the app:

```
> bundle install
```

## Running

To run Starkiller, type `bin/generate`. Note that I cannot distribute any fonts with this project without breaking their licenses. As such, you’ll need to make sure the following environment variables are set the paths of TTF fonts you’d like to use:

* `FONT_HEADING` - Used for the character sheet heading
* `FONT_MAJOR_TEXT` - Used for rendoring significant text and most labels
* `FONT_MAJOR_NUMBER` - Renders large numbers like the characteristic values
* `FONT_MINOR_LABEL` - Renders smaller labels like table headings
* `FONT_MINOR_TEXT` - Renders paragraph text and small form values

I usually specify this as follows:

```
> FONT_HEADING=fonts/ComicSans.ttf FONT_MAJOR_TEXT=… bin/generate
```

## License

All work within this repo is released under a [Creative Commons Attribution-NonCommercial 3.0 United States](https://creativecommons.org/licenses/by-nc/3.0/us/) license. Essentially you are welcome to do what you like with this as long as you provide attribution and don't charge for it.

Star Wars, Edge of the Empire, and all associated works remain the copyright of their respective copyright holders.