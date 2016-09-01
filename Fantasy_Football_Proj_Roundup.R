
#Read from html (website)
library(XML)
espn.qb <- readHTMLTable("http://games.espn.go.com/ffl/tools/projections?&slotCategoryId=0&startIndex=0&leagueId=744483", skip=1)
espn.qb <- espn.qb$playertable_0
head(espn.qb)
str(espn.qb)

espn.rb <- readHTMLTable("http://games.espn.go.com/ffl/tools/projections?&slotCategoryId=2&startIndex=0", skip.rows=1)$playertable_0
espn.rb <- rbind(espn.rb,readHTMLTable("http://games.espn.go.com/ffl/tools/projections?&slotCategoryId=2&startIndex=40", skip.rows=1)$playertable_0)

espn.wr <- readHTMLTable("http://games.espn.go.com/ffl/tools/projections?&slotCategoryId=4&startIndex=0", skip.rows=1)$playertable_0
espn.wr <- rbind(espn.wr,readHTMLTable("http://games.espn.go.com/ffl/tools/projections?&slotCategoryId=4&startIndex=40", skip.rows=1)$playertable_0)



write.csv(espn.qb, file = "C:/Users/z030757/Desktop/QB2016.csv", row.names = FALSE, na = "")
write.csv(espn.rb, file = "C:/Users/z030757/Desktop/RB2016.csv", row.names = FALSE, na = "")
write.csv(espn.wr, file = "C:/Users/z030757/Desktop/WR2016.csv", row.names = FALSE, na = "")
