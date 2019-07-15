# Code to populate the database ...

# Seed categories table

Category.create(
    category_name:"For Sale")


    



# Seed sections table
Section.create([
{section_name:"bikes",  category: Category.find(2) },
{section_name:"jewelry",  category: Category.find(2) },
{section_name:"education",  category: Category.find(1) },
{section_name:"medical/health",  category: Category.find(1)}
])


# # Seed users table
# user1=User.create(name: "Taghreed",  email: "Taghreed.alqubati@gmail.com")
# user1.password = "tg12345"
#    user.save

# Seed items table
Item.create(
    {user_id: user1,item_title:"tiger bike", price: "1000", city: "Kuala", description: "very fast",image_url:"",section_id:Section.find(1) }
           )
   