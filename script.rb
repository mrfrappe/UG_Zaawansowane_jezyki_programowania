require 'ruby2d'
puts "Plantacja ślimaków"

class Board 
    def initialize(w, h)
        @@width = w
        @@height = h
    end

    def getWidth
        @@width
    end

    def getHeight
        @@height
    end

    def self.info()
        # draw board
        puts "Boardgame (w: #@@width, h: #@@height )"
    end
end

class Snail
    def initialize(x, y)
        @@xCord = x
        @@yCord = y
    end

    def self.info()
        #put snail on a board
        puts "Create new snail on (x: #@@xCord, y: #@@yCord )"
    end
end

ary = Array.new 
$i = 0
$howManySnails = 5

board = Board.new(300,300)
Board.info()

while $i <= $howManySnails do
    xRand = Random.new()
    yRand = Random.new()
    snail1 = Snail.new(xRand.rand(board.getWidth),yRand.rand(board.getHeight))
    ary.push(snail1)
    Snail.info()
    $i += 1
end

# puts ary