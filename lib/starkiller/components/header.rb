module Starkiller
  module Components
    module Header
      include Starkiller::Component

      # The header contains the character name, career, species, specializations, and owner

      PADDING = 3.0

      class << self
        def render(pdf, character)
          within(pdf,
            top: DOCUMENT_TOP,
            left: DOCUMENT_LEFT,
            width: COMPONENT_FULL_WIDTH,
            height: 32
          ) do
            header(pdf, character)
          end
        end

        def header(pdf, character)
          # Bounding Box
          draw_rectangle(pdf,
            top: 0,
            left: 0,
            width: full_width,
            height: 32,
            fill_color: "ffffff",
            stroke_color: "000000"
          )

          # Character Name
          write(pdf, "Name: #{character[:name]}",
            top: 0,
            left: 0,
            padding: PADDING,
            width: 520,
            size: 22.0,
            font: FONT_MAJOR_TEXT
          )

          # Player Box
          draw_rectangle(pdf,
            top: 0 - (LINE_WIDTH / 2.0),
            left: 490,
            width: full_width - 490 - LINE_WIDTH/2.0,
            height: 13,
            fill_color: "ADAEB1"
          )

          # Name / Player separator
          draw_line(pdf,
            top: 0 - (LINE_WIDTH / 2.0),
            left: 490,
            length: 32,
            direction: :vertical
          )

          # Player Label
          write(pdf, "PLAYER",
            top: 0 - PADDING,
            left: 490,
            width: full_width - 490,
            align: :center,
            size: 9.0,
            font: FONT_HEADING,
            color: "ffffff",
            character_width: 0.8
          )

          # Player Name
          write(pdf, character[:owner],
            top: -20,
            left: 490,
            width: full_width - 490,
            align: :center,
            size: 9.0,
            font: FONT_MAJOR_TEXT,
          )

          # Species
          write(pdf, "Species: #{character[:species]}",
            top: -23,
            left: PADDING,
            width: 130,
            size: 8.0,
            font: FONT_MAJOR_TEXT
          )

          # Career
          write(pdf, "Career: #{character[:career]}",
            top: -23,
            left: PADDING + 135,
            width: 130,
            size: 8.0,
            font: FONT_MAJOR_TEXT
          )

          # Specializations
          write(pdf, "Specializations: #{character[:specializations]}",
            top: -23,
            left: PADDING + 130 + 135,
            width: 220,
            size: 8.0,
            font: FONT_MAJOR_TEXT,
            align: :right
          )
        end
      end
    end
  end
end
