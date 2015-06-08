require "pry"

class Ingredient

  attr_reader :quantity, :unit, :name

  VALID_INGREDIENTS = [
    "brussels sprouts",
    "spinach",
    "eggs",
    "milk",
    "tofu",
    "seitan",
    "bell peppers",
    "quinoa",
    "kale",
    "chocolate",
    "beer",
    "wine",
    "whiskey"
  ]

  def initialize(quantity, unit, name)
    @quantity = quantity
    @unit = unit
    @name = name
  end

  def self.parse(string)
    array = string.split(" ")
    amount = array[0].to_f.to_s
    number = array[1]
    title = array.delete_if { |val|
      val.include?(".") ||
      val.include?("(") ||
      val.include?(")") ||
      val.start_with?("1") ||
      val.start_with?("2") ||
      val.start_with?("3") ||
      val.start_with?("4") ||
      val.start_with?("5") ||
      val.start_with?("6") ||
      val.start_with?("7") ||
      val.start_with?("8") ||
      val.start_with?("9")
    }
    title = title.join(" ")

    # Ingredient.new(amount, number, title)
    "#{amount} #{number} #{title}"
  end

  def allowed?
    VALID_INGREDIENTS.include?(name.downcase)
  end

  def summary
    "#{@quantity} #{@unit} #{@name}"
  end
end

class Recipe

  attr_reader :name, :ingredients

  def initialize(name, ingredients, instructions )
    @name = name
    @ingredients = ingredients
    @instructions = instructions
  end

  def printed_name
    "Name: #{@name}"
  end

  def printed_ingredients
    parts = ""
    ingredients.each do |ingredient|
      parts << "- " << ingredient.summary << "\n"
    end
    parts
  end

  def can_have_dish?
    killer_foods = []
    ingredients.each do |ingredient|
      killer_foods << ingredient.allowed?
    end
    if killer_foods.include?(false)
      false
    else
      true
    end
  end

  def instructions
    instructions = ""
    step = 1
    @instructions.each do |instruction|
      instructions << "#{step}. #{instruction} \n"
      step += 1
    end
    instructions
  end

  def summary
    <<SUMMARY
#{printed_name}

Can Client have this dish? #{can_have_dish?}

#{printed_ingredients}
#{instructions}
SUMMARY
  end
end

name = [
  { horizons: "Roasted Brussels Sprouts" },
  { danelsons: "Peanut Butter and Jelly Sandwich" }
]

ingredients = [
  {
    horizons: [
      Ingredient.new(1.5, "lb(s)", "Brussels sprouts"),
      Ingredient.new(3.0, "tbspn(s)", "Spinach"),
      Ingredient.new(0.75, "tspn(s)", "chocolate"),
      Ingredient.new(0.5, "tspn(s)", "seitan")
    ]
  },
  {
    danelsons: [
    Ingredient.new(1.0, "lb(s)", "Bread"),
    Ingredient.new(3.0, "tbspn(s)", "Peanut Butter"),
    Ingredient.new(0.75, "tspn(s)", "Jelly"),
    ]
  }
]

instructions = [
  {
    horizons: [
    "Preheat oven to 400 degrees F.",
    "Cut off the brown ends of the Brussels sprouts.",
    "Pull off any yellow outer leaves.",
    "Mix them in a bowl with the olive oil, salt and pepper.",
    "Pour them on a sheet pan and roast for 35 to 40 minutes.",
    "They should be until crisp on the outside and tender on the inside.",
    "Shake the pan from time to time to brown the sprouts evenly.",
    "Sprinkle with more kosher salt ( I like these salty like French fries).",
    "Serve and enjoy!"
    ]
  },
  {
    danelsons: [
    "Get bottom-layer of bread",
    "Get peanut butter",
    "Get jelly",
    "Spread peanut butter on bottom-layer bread",
    "Spread jelly on top of peanut butter",
    "Place top-layer bread on top of peanut butter and jelly"
    ]
  }
]

horizons_recipe = Recipe.new(
  name[0][:horizons],
  ingredients[0][:horizons],
  instructions[0][:horizons]
)
danelsons_recipe = Recipe.new(
  name[1][:danelsons],
  ingredients[1][:danelsons],
  instructions[1][:danelsons]
)

puts horizons_recipe.summary
puts danelsons_recipe.summary

puts Ingredient.parse("47 lb(s) Brussels sprouts")
