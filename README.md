# blue-prince-numeric-cores
This is a short code I wrote based off a puzzle in the late-game sections of Blue Prince.

If you aren't yet familiar with this concept and want to discover it in the game, don't read any further.

<details> <summary> SPOILERS for late-game Blue Prince puzzles </summary>
  In the video game Blue Prince, a concept known as "Numeric Cores" is introduced for some of the late-game puzzles. The idea is this:

  Take a number that is at least 4 digits long, and break it into 4 sections. If the number is 1234, the sections would be 1, 2, 3, and 4. If the number is 12345, the sections could potentially be 12, 3, 4, 5, or 1, 2, 34, 5, etc. The number of characters in the section is not restricted, but the order of the sections must stay the same. If the number is 1234, the order cannot be 4, 1, 3, 2.

  Next, using addition, subtraction, multiplication, and division once each, find the lowest possible positive whole integer from the sequence given. (The normal order of PEMDAS is ignored, and we can simply read from left to right.) The game gives the example of 86455, which, broken into 8, 6, 45, and 5, then becomes + 8 - 6 * 45 / 5 = 18. If the sequence is longer than 3 digits, then we repeat the process again.

  This idea can also be applied to words. By converting the letters in a word into their positional values within the alphabet, we can create numeric cores from 4-letter words. For example, A = 1, B = 2, etc., and we can convert a word like BLUE into 2, 12, 21, 5. Further, the number that we get from this can be turned back into a letter, spelling out a secret code from a seemingly meaningless list of 4-letter words.

  After finding this puzzle in the game, I wondered how many real 4-letter English words had numeric cores that realized into a number from 1-26, so I wrote this code here. I use the Scrabble TWL06 to determine which words are real English words.

  First, I removed any words that did not contain exactly four letters. Then I created variables for each position in a word (first, second, third, fourth) and stored the corresponding positional values in the alphabet for each letter in each word.

  Next, I ran all possible combinations of addition, subtraction, multiplication, and division on each word according to the rules listed above. (Note: Addition is always required first, as otherwise it would nearly always be possible to get a small numeric core, and the multiplication and division would be largely ignored.) I have categorized the possibilities using S for subtraction, M for multiplication, and D for division, as SMD, SDM, MSD, MDS, DSM, and DMS.

  After this, I compiled a list of words where at least one of the possible orders above resulted in a positive whole integer value between 1 and 26. I then replaced all negative values, non-integer values, and 0s with NAs. Since the only relevant value for the numeric core is the minimum whole integer, I found the minimum value from each of the six possibilities.
  
  Finally, I created a sorted word list containing each word with its numeric core, and a table showing the total counts of numeric cores with values from 1 to 26.
</details>
