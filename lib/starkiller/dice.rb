module Starkiller
  module Dice
    PROFICIENCY_SCALE = 3.0
    PROFICIENCY_BASE_WIDTH = 2
    PROFICIENCY_POLYGON_POINTS = [
      [0.5, 0],
      [1.5, 0],
      [2, 0 - Math.sqrt(3) / 2.0],
      [1.5, 0 - Math.sqrt(3)],
      [0.5, 0 - Math.sqrt(3)],
      [0, 0 - Math.sqrt(3) / 2.0]
    ]

    ABILITY_SCALE = 3.0
    ABILITY_BASE_WIDTH = 1
    ABILITY_POLYGON_POINTS = [
      [0.5, 0],
      [1, 0 - Math.sqrt(3) / 2.0],
      [0.5, 0 - Math.sqrt(3)],
      [0, 0 - Math.sqrt(3) / 2.0]
    ]

    DIE_BUFFER = 0.7

    def draw_dice(pdf, opts)
      horizontal_offset = opts[:right]

      opts[:proficiency].times do
        horizontal_offset -= PROFICIENCY_BASE_WIDTH * PROFICIENCY_SCALE

        pdf.polygon(*PROFICIENCY_POLYGON_POINTS.map { |x,y = a| [ horizontal_offset + PROFICIENCY_SCALE * x, opts[:top] + PROFICIENCY_SCALE * y] })
        pdf.fill_color "ffff00"
        pdf.fill_and_stroke

        horizontal_offset -= DIE_BUFFER
      end

      opts[:ability].times do
        horizontal_offset -= ABILITY_BASE_WIDTH * ABILITY_SCALE

        pdf.polygon(*ABILITY_POLYGON_POINTS.map { |x,y = a| [ horizontal_offset + ABILITY_SCALE * x, opts[:top] + ABILITY_SCALE * y] })
        pdf.fill_color "00ff00"
        pdf.fill_and_stroke

        horizontal_offset -= DIE_BUFFER
      end
    end
  end
end
