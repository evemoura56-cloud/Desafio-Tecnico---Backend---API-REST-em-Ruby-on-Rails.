puts "Limpando banco..."
CartItem.destroy_all
Cart.destroy_all
Product.destroy_all

puts "Criando produtos..."

products = [
  { name: "Notebook Dell Inspiron 15", price: 3499.99 },
  { name: "Mouse Logitech MX Master 3", price: 489.90 },
  { name: "Teclado Mecânico Keychron K2", price: 599.00 },
  { name: "Monitor LG UltraWide 29", price: 1299.00 },
  { name: "Webcam Logitech C920", price: 399.90 }
]

products.each { |p| Product.create!(p) }

puts "✅ #{Product.count} produtos criados!"
