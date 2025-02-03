
### Workflow Critique Presentation Assignments ###

# load packages
library(tidyverse)
library(here)
library(usethis)

# load csv file
roster <- read_csv("259-roster/roster.csv")

# let's view the data file now to make sure it looks ok
view(roster)

# variable type?
class(roster$Student)

# remove one student who dropped the class
roster <- roster %>% 
  filter(!(Student == "Martinez, Anais"))

# randomly assign each Student to 1 Group
# and create a new variable in the data frame that indicates which group each student is in 
# there are ways you can write a function to do this! (more on this in automation lecture)

# Set a seed for reproducibility; I used today's date
set.seed(02032025)  
## What is a seed?
  # if we are randomizing and we want someone else to be able to reproduce that same randomization, we can set a seed which helps them to achieve the same randomization
  # without a seed, we will randomize assignments but would not be able to reproduce that same random assignment again in the future...

# Then we can create a new variable that gives each person a random ID number from 1:24
roster <- roster %>%
  mutate(random_id = sample(n())) %>%
  arrange(random_id) # then, we will sort by random ID numbers

# Then we can create a group variable and loop through 1, 2, 3 based on this randomized order, given the length of observations
roster <- roster %>%
  mutate(group = rep(1:3, length.out = n())) %>% 
  select(-random_id)

# Then, if we wanted to see who was assigned to which groups more easily, we can group the data by the group column and then use summarise to list which students are in each group
roster %>%
  group_by(group) %>%
  summarise(Student = paste(Student, collapse = "; "), .groups = "drop") %>%
  print()

# Now, let's save this revised version of the roster.csv to a GitHub repo and then commit and push to GitHub
# I'm going to put it in the syllabus folder, which is already cloned from GitHub

write_csv(roster, file="259-syllabus/roster.csv")

# so, if I go to the 259-syllabus folder/repo, I should be able to see the roster.csv there

# Yep, I do!

# So, now let's commit/push these changes to GitHub (259-syllabus is already cloned)
# I need to open up that project now in a new session



