extensions [table]

globals [txt freq-table probabilty-table word-count Max-Word-Count result heads-count tails-count list-outcomes]

to setup
  ca
  set list-outcomes ["1" "2" "3" "4" "5" "6"]
  set roll-results ""
  set Max-Word-Count 1000
  set heads-count 0
  set tails-count 0
  crt 1 [set shape one-of list-outcomes set size 10 set color gray set heading 90]
end

to go
  set txt roll-results
  build-frequency-table list-of-words
  build-probability-table
  sort-list
end

to-report list-of-words
  let $txt txt
  set $txt word $txt " "  ; add space  for loop termination
  let words []  ; list of values
  while [not empty? $txt]
  [ let n position " " $txt
    ;show word "n: " n
    let $item substring $txt 0 n  ; extract item
    if not empty? $item [if member? last $item ".,?!;:" [set $item butlast $item ] ] ; strip trailing punctuation
    ;carefully [set $item read-from-string $item ][ ] ; convert if number
    carefully [if member? first $item " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890" [set words lput $item words]][]  ; append to list, ingnore cr/lfs
    set $txt substring $txt (n + 1) length $txt  ; remove $item and space
  ]
  report words
  print ""
end

to build-frequency-table [#word]
  set freq-table table:make
  set probabilty-table table:make
  set word-count 0
  foreach #word [ ?1 ->
    set word-count word-count + 1  ;; find total count of words
    if word-count >= Max-Word-Count [stop]
    ifelse table:has-key? freq-table ?1  [let i table:get freq-table ?1 table:put freq-table ?1 i + 1 ] [table:put freq-table ?1 1]
    ]

end

to build-probability-table
  foreach table:keys freq-table [ ?1 -> table:put probabilty-table ?1 table:get freq-table ?1 * (1 / word-count) ]

  ;print freq-table
  ;print probabilty-table
end


to-report H
  let sum-plogp 0
  foreach table:keys probabilty-table
   [ ?1 ->
     let p table:get probabilty-table ?1
     set sum-plogp  sum-plogp  + -1 * p * log p 2
   ]
   report sum-plogp
end

to sort-list
  let freq-list []
  foreach table:keys freq-table [ ?1 -> set freq-list lput list ?1 table:get freq-table ?1  freq-list  ] ;builds a list version of the table.
  set freq-table table:from-list sort-by [ [?1 ?2] -> last ?1 > last ?2 ] freq-list ;sort list by frequency counts and recreates table.
end

to roll-die
  set result one-of list-outcomes
  show-roll
end

to show-roll
  if result = "1" [ask turtles [repeat 4 [set shape one-of list-outcomes wait .4] set shape "1"]]
  if result = "2" [ask turtles [repeat 4 [set shape one-of list-outcomes wait .4] set shape "2"]]
  if result = "3" [ask turtles [repeat 4 [set shape one-of list-outcomes wait .4] set shape "3"]]
  if result = "4" [ask turtles [repeat 4 [set shape one-of list-outcomes wait .4] set shape "4"]]
  if result = "5" [ask turtles [repeat 4 [set shape one-of list-outcomes wait .4] set shape "5"]]
  if result = "6" [ask turtles [repeat 4 [set shape one-of list-outcomes wait .4] set shape "6"]]
  set roll-results (word roll-results " " result)
end
@#$#@#$#@
GRAPHICS-WINDOW
415
14
756
356
-1
-1
10.1
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

INPUTBOX
9
155
395
267
roll-results
 3 5 4 5 1 6 4
1
0
String

BUTTON
78
337
295
387
Calculate Information Content
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
101
400
262
445
Information Content (H)
H
4
1
11

TEXTBOX
11
20
395
64
Shannon Information Content of Dice Flips
18
95.0
1

BUTTON
103
64
238
97
Roll Fair Die
roll-die
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
110
133
278
175
NIL
11
0.0
1

BUTTON
13
65
86
98
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

This model calculates the Shannon information content of a set of coin flips.

Shannon information content is usually expressed by the average number of bits needed to store or communicate one symbol in a message. This information content quantifies the uncertainty involved in predicting the value of a future event (or random variable). For example, the ability to correctly guess the outcome of a fair coin flip (one with two equally likely outcomes) provides less information (lower entropy, less surprising) than specifying the outcome from a roll of a die (six equally likely outcomes). Using this method we are able to precisely measure this  "surprise value" in different contexts.

## HOW IT WORKS

You can either flip a fair coin (probability of heads = 1/2) or a biased coin (probability of heads set by a slider).    Flip the coin several times to get a number of samples, and then click on "Calculate Information Content".

## CREDITS AND REFERENCES

This model is part of the Information Theory series of the Complexity Explorer project.

Main Author: John Balwit

Contributions from:  Melanie Mitchell

Netlogo:  Wilensky, U. (1999). NetLogo. http://ccl.northwestern.edu/netlogo/. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.


## HOW TO CITE

If you use this model, please cite it as: "Coin-Flip Information Content" model, Complexity Explorer project, http://complexityexplorer.org

## COPYRIGHT AND LICENSE

Copyright 2016 Santa Fe Institute.

This model is licensed by the Creative Commons Attribution-NonCommercial-ShareAlike  International  ( http://creativecommons.org/licenses/ ). This states that you may copy, distribute, and transmit the work under the condition that you give attribution to ComplexityExplorer.org, and your use is for non-commercial purposes.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

1
false
0
Rectangle -7500403 true true 30 30 270 270
Circle -1184463 true false 122 120 57

2
false
0
Rectangle -7500403 true true 30 30 270 270
Circle -1184463 true false 182 120 57
Circle -1184463 true false 62 120 57

3
false
0
Rectangle -7500403 true true 30 30 270 270
Circle -1184463 true false 197 180 57
Circle -1184463 true false 47 180 57
Circle -1184463 true false 122 45 57

4
false
0
Rectangle -7500403 true true 30 30 270 270
Circle -1184463 true false 197 180 57
Circle -1184463 true false 47 180 57
Circle -1184463 true false 122 45 57
Circle -1184463 true false 122 135 57

5
false
0
Rectangle -7500403 true true 30 30 270 270
Circle -1184463 true false 197 195 57
Circle -1184463 true false 47 195 57
Circle -1184463 true false 122 45 57
Circle -1184463 true false 167 135 57
Circle -1184463 true false 77 135 57

6
false
0
Rectangle -7500403 true true 30 30 270 270
Circle -1184463 true false 197 195 57
Circle -1184463 true false 47 195 57
Circle -1184463 true false 182 45 57
Circle -1184463 true false 152 120 57
Circle -1184463 true false 92 120 57
Circle -1184463 true false 47 45 57

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

coin-side
true
0
Line -7500403 true 150 0 150 300
Rectangle -7500403 true true 135 0 165 300

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cube
false
15
Polygon -7500403 true false 150 285 285 225 285 75 150 135
Polygon -7500403 true false 150 135 15 75 150 15 285 75
Polygon -7500403 true false 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

heads
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 33 33 234
Circle -7500403 true true 90 105 30
Circle -7500403 true true 180 105 30
Polygon -7500403 true true 135 150 150 180 165 150
Polygon -7500403 true true 120 210 180 210 165 225 135 225

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
0
Rectangle -7500403 true true 151 225 180 285
Rectangle -7500403 true true 47 225 75 285
Rectangle -7500403 true true 15 75 210 225
Circle -7500403 true true 135 75 150
Circle -16777216 true false 165 76 116

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

tails
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tmp
false
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15
Circle -1 true false 111 106 78

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -7500403 true true 135 285 195 285 270 90 30 90 105 285
Polygon -7500403 true true 270 90 225 15 180 90
Polygon -7500403 true true 30 90 75 15 120 90
Circle -1 true false 183 138 24
Circle -1 true false 93 138 24

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
