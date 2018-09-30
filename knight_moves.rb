class Knight

  attr_reader :coords, :parent, :valid_moves

  @@transforms = [[-1, 2], [-2, 1], [-2, -1], [-1, -2],
                  [1, 2], [2, 1], [2, -1], [1, -2]]
  
  def initialize(coords, parent = nil)
    @coords = coords
    @parent = parent
    @valid_moves = []
  end

  def transform
    @@transforms.each do |t|
      coords = [t[0] + self.coords[0], t[1] + self.coords[1]]
      if valid?(coords) 
        @valid_moves << Knight.new(coords, self)
      end
    end
  end

  # Validates the possible moves; coordinates between 1 and 8 inclusive; can't be own parent
  def valid?(coords)
    case 
    when coords[0].between?(1,8) == false || coords[1].between?(1,8) == false
      return false
    when coords == self.parent
      return false
    else
      return true
    end
  end
    
  def find_lineage
    current = self
    path = []
    path << current.coords
    while current.parent.nil? == false
      path << current.parent.coords
      current = current.parent
    end
    puts "You made it here in #{path.length - 1} move(s)! Here is your route: "
    path.reverse!
    path.each {|pos| print pos; puts ""}
  end
  
end

def knight_moves(start, goal)
  unless (start.map {|i| i.between?(1,8)}).all?(true) && (goal.map {|i| i.between?(1,8)}).all?(true)
    puts "Try again! Coordinates must be between 1 and 8."
    return nil
  end
  root = Knight.new(start)
  queue = []
  queue << root
  loop do 
    current_knight = queue.shift
    if current_knight.coords == goal
      current_knight.find_lineage
      break
    else
      current_knight.transform
      current_knight.valid_moves.each {|knight| queue << knight}
    end
  end
end

#knight_moves([0,0], [7,7])
#knight_moves([1,1], [8,8])
#knight_moves([2,1], [2,2])
#knight_moves([6,7], [3,2])