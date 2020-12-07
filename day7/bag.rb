class Bag

  attr_accessor :name, :points_to, :points_from


  def initialize(name)
    @name = name
    @points_from = []
  end

  def add_points_to(contents)
    # [
    #   [number, node],
    #   ...
    #   [number, node],
    # ]
    @points_to = contents
    @points_to.each do |node_pair|
      next if node_pair.nil? || node_pair[1].nil?
      node_pair[1].points_from(self)
    end
  end

  def points_from(node)
    @points_from << node
  end

  def get_nodes_up
    @points_from.map {|pf| pf.get_nodes_up }.flatten << self.name
  end

  def get_bags_down
    return 1 if @points_to.nil? || @points_to.compact.empty?
    @points_to.map { |pt| pt[0].to_i * pt[1].get_bags_down }.inject(:+) + 1
  end
end
