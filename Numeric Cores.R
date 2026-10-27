# Numeric Cores Finder
rm(list=ls())
library(tidyverse)

# Create list of all 4-letter English words
{
  dictionary <- read.csv("/Users/jimmystluka/Downloads/Coding Projects/Scrabble_TWL06.csv")
  
  # Calculate word length
  {
    charcount <- dictionary %>%
      mutate(length = nchar(word))
  }
  
  # Filter dataset to only contain words of length 4
  dict_4 <- filter(charcount, length == 4)
}

# Calculating possible numeric cores
{
# Find the positional value of each character in each word, store by placement in word
dict_4 <- dict_4 %>% 
  mutate(first = match(tolower(str_sub(word, 1, 1)), letters)) %>%
  mutate(second = match(tolower(str_sub(word, 2, 2)), letters)) %>%
  mutate(third = match(tolower(str_sub(word, 3, 3)), letters)) %>%
  mutate(fourth = match(tolower(str_sub(word, 4, 4)), letters)) %>%

# Calculate all possible orders of operations (Subtract/Multiply/Divide)
  mutate(SMD = (((first - second) * third) / fourth)) %>%
  mutate(SDM = (((first - second) / third) * fourth)) %>%
  mutate(MSD = (((first * second) - third) / fourth)) %>%
  mutate(MDS = (((first * second) / third) - fourth)) %>%
  mutate(DSM = (((first / second) - third) * fourth)) %>%
  mutate(DMS = (((first / second) * third) - fourth))

# Store any whole number values between 1 and 26
SMD_dict_4 <- dict_4 %>% filter(SMD %in% 1:26)
SDM_dict_4 <- dict_4 %>% filter(SDM %in% 1:26)
MSD_dict_4 <- dict_4 %>% filter(MSD %in% 1:26)
MDS_dict_4 <- dict_4 %>% filter(MDS %in% 1:26)
DSM_dict_4 <- dict_4 %>% filter(DSM %in% 1:26)
DMS_dict_4 <- dict_4 %>% filter(DMS %in% 1:26)
}

# Combine all possibilities
possibilities <- unique(bind_rows(SMD_dict_4, SDM_dict_4, MSD_dict_4, MDS_dict_4, DSM_dict_4, DMS_dict_4))

# Replace negative possibilities, non-integer possibilities, zeroes with NA
possibilities_na <- possibilities %>%
  mutate(across(!word, ~ ifelse(.x %in% 1:26, .x, NA)))

# Find the smallest numeric core for each word, ignoring NAs
possibilities_na$numeric_core <- pmin(possibilities_na$SMD, possibilities_na$SDM,
    possibilities_na$MSD, possibilities_na$MDS, possibilities_na$DSM, possibilities_na$DMS, na.rm = TRUE)

# Create list of words with a real numeric core, sort by numeric core value
numeric_cores <- subset(possibilities_na, select = c(word, numeric_core)) %>%
  arrange(numeric_core)

# Table with word counts by numeric core
numeric_core_counts <- table(numeric_cores$numeric_core)
numeric_core_counts
