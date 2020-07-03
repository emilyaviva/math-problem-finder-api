categories = [
  "Ratio and Proportion",
  "Division",
  "Laws of Math"
]

categories.each do |category|
  Category.create(name: category)
end

ratio_category = Category.find_by(name: "Ratio and Proportion")
division_category = Category.find_by(name: "Division")
laws_of_math_category = Category.find_by(name: "Laws of Math")

lessons = [
  { name: "Ratio", summary: "This lesson teaches about ratio", category: ratio_category },
  { name: "Proportion", summary: "This lesson teaches about proportion", category: ratio_category },
  { name: "Racks and Tubes", summary: "Division by sharing", category: division_category },
  { name: "Group Division", summary: "Division by grouping", category: division_category },
  { name: "Commutative Law", summary: "Commutative Law", category: laws_of_math_category },
  { name: "Proportion Passages to Abstraction", summary: "This will mean something to Montessorians", category: laws_of_math_category }
]

lessons.each do |lesson|
  Lesson.create(lesson)
end

foo_task = Task.create(name: "Foo", source: "Dan Meyer", link: "https://example.com", commentary: "Lorem ipsum")
foo_task.lessons << Lesson.find_by(name: "Proportion")
foo_task.lessons << Lesson.find_by(name: "Racks and Tubes")

bar_task = Task.create(name: "Bar", source: "Dan Meyer", link: "https://example.com", commentary: "Dolor sit amet")
bar_task.lessons << Lesson.find_by(name: "Commutative Law")
