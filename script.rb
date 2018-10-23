require 'ruby2d'
puts "Plantacja ślimaków"

class Board 
    def initialize(w, h, n)
        @@width = w
        @@height = h
        @@name = n
    end

    def getWidth
        @@width
    end

    def getHeight
        @@height
    end
    def getName
        @@name
    end
    def self.info()
        # draw board
        puts "Boardgame (w: #@@width, h: #@@height )"
    end
end


class Snail < Rectangle
    def self.info()
    end
    def setXCord(x, value)
        x = Random.new().rand(x - value...x + value)
#        puts "X: #@x"
    end   
    def setYCord(y, value)
        y = Random.new().rand(y - value... y+ value)
#       puts "Y: #@y"
    end
    def eat 
        #eat fun
    end
    def copulation
        #copulation
    end
end

ary = Array.new 
$i = 1
$howManySnails = 100
tick = 0

board = Board.new(500,500, "Boardgame")
Board.info()
set title: board.getName
set background: 'green'
set resizable: false
set diagonostics: true
set width: board.getWidth
set height: board.getHeight

while $i <= $howManySnails do
    ary.push(Snail.new(x: Random.new().rand(board.getWidth), y: Random.new().rand(board.getHeight), width: 10, height: 10, color: 'black', z: 20))
    Snail.info()
    $i += 1
end


update do
  if tick % 10 == 0
      for j in 0..ary.length-1 
          ary[j].remove
          ary[j].x = ary[j].setXCord(ary[j].x, 10)
          ary[j].y = ary[j].setYCord(ary[j].y, 10)
          ary[j].add
          j += 1
      end

  end
  tick += 1
end
puts ary[0]
show