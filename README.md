# reddit-chatbot
A chat bot based on reddit comments, slow to respond and difficult to hold a conversion with.

```
> talk('Sup dog?')
Guess who!
> talk('How are you?')
Not bad. yourself?
> talk('Do you like deer?')
I'm assuming that was a question, and no, most likely I wouldn't eat veal.
> talk('do you eat meat')
No officer I do not.
> talk('you must like eating vegetables')
Cooked in animal fat.
> talk('That does not sound good.')
It does...
> talk('Who do you love')
Jessica Alba
> talk('Why did the chicken cross the road?')
To use a functional programming language!
```

This chatbot uses a small subset of the [comments](https://www.reddit.com/r/datasets/comments/3bxlg7/i_have_every_publicly_available_reddit_comment), made available by /u/Stuck_In_the_Matrix, as its dataset.
Specifically, all of the reddit comments for the months 10/2007 - 02/2008. The chatbot uses a string-distance calculation ([stringdist](https://cran.r-project.org/web/packages/stringdist/stringdist.pdf) with [osa](https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance#Optimal_string_alignment_distance) to find similar strings. Performance depends on your computer's processor.

The bot works by finding the similarity between the text given to it and all the comments in its dataset.
It then finds the most similar comment that has replies and prints out the highest rated reply.
The larger the dataset the better the replies, but the longer the response time.