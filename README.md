# Lunch time FUN with JRuby

## Goal
Produces a list of pairs of artists which appear TOGETHER in at least
fifty different lists.

## Runtime
- Java (it's just a JAR)

`time java -Xmx1g -Xms1g -jar lastfm.jar`

## Space complexity
- Builds a large Hash when reducing, consuming heap, which is a
limiting factor.
