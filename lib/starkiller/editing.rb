module Starkiller
  module Editing
    DOCUMENT_HEIGHT = 720
    DOCUMENT_TOP = DOCUMENT_HEIGHT
    DOCUMENT_WIDTH = 540
    DOCUMENT_LEFT = 0
    COMPONENT_FULL_WIDTH = DOCUMENT_WIDTH

    LINE_WIDTH = 0.4
    TABLE_HEADER_INDENT = 4

    FONT_HEADING = ENV["FONT_HEADING"]
    FONT_MAJOR_TEXT = ENV["FONT_MAJOR_TEXT"]
    FONT_MAJOR_NUMBER = ENV["FONT_MAJOR_NUMBER"]
    FONT_MINOR_LABEL = ENV["FONT_MINOR_LABEL"]
    FONT_MINOR_TEXT = ENV["FONT_MINOR_TEXT"]

    COLOR_TABLE_BACKGROUND = "fcfffc"
    COLOR_TABLE_FOREGROUND = "324357"

    def within(pdf, opts, &block)
      @width = opts[:width]
      @height = opts[:height]

      pdf.translate(opts[:left], opts[:top]) do
        yield block
      end

      @width = nil
      @height = nil
    end

    def full_width
      @width
    end

    def full_height
      @height
    end

    def draw_rectangle(pdf, opts)
      if(opts[:stroke_color])
        pdf.stroke_color = opts[:stroke_color]
        pdf.line_width = opts[:line_width] || LINE_WIDTH
      end

      if(opts[:fill_color])
        pdf.fill_color = opts[:fill_color]
      end

      if(opts[:centered])
        origin = [(DOCUMENT_WIDTH - opts[:width]) / 2.0, opts[:top]]
      else
        origin = [opts[:left], opts[:top]]
      end

      if(opts[:stroke_color] && opts[:fill_color])
        pdf.fill_and_stroke_rectangle(
          origin,
          opts[:width],
          opts[:height]
        )
      elsif(opts[:fill_color])
        pdf.fill_rectangle(
          origin,
          opts[:width],
          opts[:height]
        )
      elsif(opts[:stroke_color])
        pdf.stroke_rectangle(
          origin,
          opts[:width],
          opts[:height]
        )
      end
    end

    def draw_line(pdf, opts)
      pdf.stroke_color = opts[:stroke_color] || "000000"
      pdf.line_width = opts[:line_width] || LINE_WIDTH

      origin = [opts[:left], opts[:top]]

      if(opts[:direction] == :vertical)
        destination = [origin[0], origin[1] - opts[:length]]
      else
        destination = [origin[0] + opts[:length], origin[1]]
      end

      if(opts[:dashed])
        pdf.dash(1, space: 2)
      end

      pdf.line origin, destination
      pdf.stroke
      pdf.undash
    end

    def write(pdf, text, opts)
      return if text.nil?

      pdf.fill_color = opts[:color] || "000000"

      factor = opts[:character_width] || 1.0
      # translation adjusts for the page margins, which is 72 / 2
      translation = opts[:character_width] ? 72.0 / 2.0 * (1.0 - factor) : 0

      pdf.transformation_matrix(factor, 0, 0, 1, translation, 0) do
        pdf.font(opts[:font] || "Helvetica") do
          pdf.text_box(
            text,
            overflow: :shrink_to_fit,
            single_line: true,
            at: [(opts[:left] + (opts[:padding] || 0)) / factor, opts[:top] - (opts[:padding] || 0)],
            width: opts[:width] / factor,
            height: 1000, # since this method always assumes a pre-sized font and width, we never want to shrink because of height.
            size: opts[:size] || 14,
            align: opts[:align] || :left
          )

          if(opts[:debug])
            pdf.fill_rectangle(
              [(opts[:left] + (opts[:padding] || 0)) / factor, opts[:top] - (opts[:padding] || 0)],
              opts[:width] / factor,
              10
            )
          end
        end
      end
    end

    def table_header(pdf, text, opts)
      middle = opts[:vertical_center]
      width = opts[:width]
      left = opts[:horizontal_center] - width / 2.0

      pdf.polygon(
        [left, middle],
        [left + TABLE_HEADER_INDENT, middle + TABLE_HEADER_INDENT],
        [left + width - TABLE_HEADER_INDENT, middle + TABLE_HEADER_INDENT],
        [left + width, middle],
        [left + width - TABLE_HEADER_INDENT, middle - TABLE_HEADER_INDENT],
        [left + TABLE_HEADER_INDENT, middle - TABLE_HEADER_INDENT]
      )

      pdf.fill_color COLOR_TABLE_FOREGROUND
      pdf.fill

      write(pdf, text,
        left: left + TABLE_HEADER_INDENT,
        top: TABLE_HEADER_INDENT - 1.2,
        width: width - TABLE_HEADER_INDENT * 2,
        align: :center,
        size: 7.0,
        font: FONT_HEADING,
        color: "ffffff",
     )
    end
  end
end
