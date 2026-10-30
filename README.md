# MATH319-Data-Visualization
Data Visualization assignment for MATH 319 - Data Science II.  

## Description of the Data
This data was sourced from <https://ebird.org/top100> and cleaned in my MATH319 Data Cleaning project.  In its final state, it is a csv of 10 years of the 100 top eBirders in Cumberland County, PA, a total of 1000 observations.  

eBird is a citizen science project by Cornell University that allows users to submit checklists of birds they see in a single birdwatching outing.  Each checklist contains a time, location, and list of bird species with their counts, among other things.  As a user submits checklists, eBird keeps track of the total number of species and checklists that person has recorded in a particular region and time period (e.g., Cumberland County, 2025, or Pennsylvania, this August, or World, lifetime).  

The top 100 eBirders are ranked by the number of species that they observe in the county in a given year.  This is not restricted to local people, and those who visit the county and submit a few checklists can get on the leaderboard.  

Each observation contains 11 variables.  The rank is that person's rank for that year, so there are 10 number ones, 10 number twos, and so on.  There is the name of the account.  Then three numbers:  the number of species he/she observed, the number of "complete" checklists, and the percentage of species that person observed out of all the species observed in the county that year.  eBird distinguishes complete checklists from incomplete ones for quality; a user marks his checklist as complete if he made a genuine effort to identify all species in a given area and time, whereas an incomplete checklist is a convenience (e.g., for incidental observations) where the user doesn't make that promise.  Incomplete checklists don't count towards the total seen in this dataset, but the birds observed are still counted in the species total in this dataset; thus, it is possible to have multiple species yet no checklists, but this is discouraged.  The remaining variables in the dataset relate to the last new species a birder added to their year list.  

Every time an eBirder "discovers" a species they haven't yet seen that year, eBird updates variables relating to this last observation.  The species (including the genus name) and common name of the bird are recorded as well as the date.  I also pulled the number of days into the year this observation was (Jan 1st = 1) and marked the year.  

## Description of the Application and its Insights
The web application was written in R making use of the Shiny and GGPlot packages.  It is divided into three tabs.  

### Number of Checklists and Species
The first tab contains a dotplot of the number of checklists eBirders on the leaderboard submitted and the number of species they found.  The user can choose a subset of the points with the slider, selecting a particular year or all years.  

This graph had a few interesting insights.  As expected, there is a positive correlation between the number of checklists and the number of species; as one spends more time watching birds, he will tend to find more types.  The graph seems to have an upper bound that is roughly logarithmic.  As a birder who is trying to find as many species as possible, you can expect to get diminishing returns on your efforts.  The more you search a specific area, the more you find, but as you find the more common birds, it gets increasingly difficult to find additional species.  

However, there isn't as much of a lower bound on the graph.  Some people have over 100 or 200 checklists and still haven't found a hundred species of birds despite others who have done so with fewer than 50 checklists, and this I suspect is due to people birdwatching in a smaller area.  E.g., someone who watches birds several times a week in their own backyard will probably see the same dozen or so species with occasional other visitors that slowly drive the total species up, high enough to be on the leaderboard at a low position.  

Another interesting feature that can be seen on the graph is the leaderboard cutoff at the bottom.  In recent years, one must find at least 50 or 60 species to make it onto the leaderboard.  In the first few years shown, the bar was only at 25 or 30 species.  You could argue that it has gotten more competitive and/or that more people are using eBird.  The top of the graph is more variable and doesn't have a clear trend over the years.  


### Genera and Species
These two graphs are bar charts of the most common last-observed species and genera.  This is particularly interesting because it is a bit of a contradictory metric.  The last bird a birder finds is typically a tricky bird to find, but these are the most common tricky birds.  The most common birds, like American robin, are among the first that birders find and thus won't make it to this list, and the rarest birds don't have enough numbers to make it to the list either.  

I examined the individual species on the right and the genera, groups of one or more species, on the left.  I cut the charts off at at least 8 observations.  A few interesting notes:  

 - The top 3 species as well as numerous others on the right graph are somewhat common but elusive winter woodland birds.  You won't find many sapsuckers, creepers, or kinglets in Southcentral PA in the summer; these birds may be among the first found in January or February or the last in November/December as seen here.  
 - Birds of prey are well-represented, including Falco (falcons), Buteo (hawks), Astur (hawks), Bubo (owls).  These tend to be infrequent but widespread, and many are year-round.  
 - Genera Coragyps (black vulture) and Cathartes (turkey vulture) both show up on the left chart, but Coragyps, the less common vulture, is slightly more frequent.  
 - Setophaga is a well-represented genus (2nd on the left), but no particular species is shown on the right chart.  These are many of the wood-warblers, summertime birds of many different types; many are uncommon.  
 - Sparrow genera are spread across the genus graph, e.g., Zonotrichia, Spizella, Junco, and Melospiza.  Each includes a one or a small handful of local winter or year-round species.  

It is worth mentioning that the birds in checklists are sorted in taxonomic order.  If a birder adds multiple to his/her year list in a single checklist, only the highest bird will be shown.  Thus, there is a bias towards some birds, such as ducks, against others, such as songbirds, especially among people with fewer checklists compared to species.  Also, these numbers are subject to random variability, so the observations I made shouldn't be taken conclusively.  There are only 1000 observations spread over 200 species.  The first few entries in these graphs show clear patterns, but the lower you look, the more likely the counts are due to random variability.  


### Timeline
These two graphs plot the day of the year that each birder's last checklist with a new species was submitted.  The first graph includes also the percentage of total birds each birder observed (of all the birds observed in the county in that year, how many did this birder observe?) as a dotplot; the second graph is just a histogram to show frequencies of dates.  These effectivly show when birders stopped discovering new species in each year.  These graphs show some interesting properties.

 - There are very few points in the first 3-4 months out of the year.  This makes sense, as most people don't stop birding that early, and even if a person does stop that early (or is just visiting the county), there aren't relatively many species available to observe until the spring migration begins.  
 - The spring migration can be clearly seen after 100 days.  It is probably the easiest/fastest time to add birds to your year list because they keep showing up.  Some people might reach a goal here and stop, or a visitor can easily get on the leaderboard after making a few checklists during this time.  This partly can explain the abundance of Setophaga observations in the aforementioned Genus chart.  
 - Things slow down in summer before the fall migration, but the total numbers of species observed in the dotplot reach new heights.  
 - Both graphs peak during the fall migration as birders capture a few more species that they didn't see in the spring; this is the commonest time to find your last bird of the year.  A lot of birders keep it up until the last couple weeks of the year.  This shouldn't be mistaken for birders discovering species faster than they did in the spring; rather, more birders (and the most "successful" birders) are finishing out their year lists in Cumberland County.  


