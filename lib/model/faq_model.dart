class FAQModel{
  String question;
  String answer;
  bool isExpanded;

  FAQModel({required this.question, required this.answer,this.isExpanded = false});
}
List<FAQModel> data = [
  FAQModel(answer: '''It stands for frequently-asked questions, and it’s a page on a website that gives quick answers to customer questions. The idea is to keep the answers short and direct so that people find info quickly. We write it as “an FAQ”…(“an eff-ay-cue”) instead of “a FAQ” (a “fack”).''', question: 'What does FAQ mean?'),
  FAQModel(answer: '''It saves you time. If you spend a lot of your time answering emails or social media queries, an FAQ can be a real timesaver. It can also help prevent costly and time-consuming returns in your online store. 
It brings new website traffic and new customers. Google’s goal is to deliver answers to questions. If you put your text in a Q&A format, you’re doing half the work already. Even better, if you have a good answer to a question, you might get featured in one of Google’s answer boxes or feature snippets, which will give you a big traffic boost.
It builds trust and shows that you get it: A well-written FAQ page shows experience. You know what customers are thinking and you’ve already got an answer. It’s a great way to increase the trust and professionalism of your website.''', question: 'What is the purpose of FAQs on your website?'),
  FAQModel(answer: '''How do you decide what questions to answer? Here are some ideas:

Look at your customers’ questions
The first is pretty obvious: What do your customers ask you? Look at your email inbox or social media account and see which questions keep popping up. What usually makes people hesitate before purchasing? What doubts might they have? The more you can automate the answers to these questions, these easier you’ll make it for your customers to buy with confidence. And you’ll save yourself time too.

Look at your competitors’ websites
If you’re a new business or don’t have a lot of customer queries yet, take a look at similar websites for ideas. Bonus points if you can answer the question better than they can.

Look at Google and Quora
Use Google’s Autosuggest feature to start typing a question about your business into the search bar. You’ll see the commonly asked questions people search for. This can be a jumping off point to figure out what questions to put on your own FAQ page.

Another idea is to browse Quora—a site built to answer people’s questions. Just type in a topic, select More Options and then choose All Questions. You’ll get a list of the most recent questions related to that topic.''', question: 'What questions belong on an FAQ page?'),
  FAQModel(answer: '''Animal testing is an issue that we have considered deeply in our mission statement and business practices. We are part of the Leaping Bunny Certification programme, the gold standard for cruelty-free certification… ← boring, not a clear answer.''', question: 'Do you test on animals?'),
  FAQModel(answer: '''8. Show some personality: Just because an FAQ section is direct doesn’t mean it has to be boring. Use it as a chance to write in your brand’s voice (humorous, casual, dignified, etc.) and even share some behind-the-scenes information about your company to add some color to your content. It’s a great chance to show that there’s a real human behind the website (you!) who is thinking about your customers and answering their questions personally.

Example: Include some questions about your company’s quirks''', question: 'Do you issue pre-paid money cards to be used as an alternative to cash for purchases within your store?'),
  FAQModel(answer: '''It stands for frequently-asked questions, and it’s a page on a website that gives quick answers to customer questions. The idea is to keep the answers short and direct so that people find info quickly. We write it as “an FAQ”…(“an eff-ay-cue”) instead of “a FAQ” (a “fack”).''', question: 'What does FAQ mean?'),
  FAQModel(answer: '''It saves you time. If you spend a lot of your time answering emails or social media queries, an FAQ can be a real timesaver. It can also help prevent costly and time-consuming returns in your online store. 
It brings new website traffic and new customers. Google’s goal is to deliver answers to questions. If you put your text in a Q&A format, you’re doing half the work already. Even better, if you have a good answer to a question, you might get featured in one of Google’s answer boxes or feature snippets, which will give you a big traffic boost.
It builds trust and shows that you get it: A well-written FAQ page shows experience. You know what customers are thinking and you’ve already got an answer. It’s a great way to increase the trust and professionalism of your website.''', question: 'What is the purpose of FAQs on your website?'),
  FAQModel(answer: '''How do you decide what questions to answer? Here are some ideas:

Look at your customers’ questions
The first is pretty obvious: What do your customers ask you? Look at your email inbox or social media account and see which questions keep popping up. What usually makes people hesitate before purchasing? What doubts might they have? The more you can automate the answers to these questions, these easier you’ll make it for your customers to buy with confidence. And you’ll save yourself time too.

Look at your competitors’ websites
If you’re a new business or don’t have a lot of customer queries yet, take a look at similar websites for ideas. Bonus points if you can answer the question better than they can.

Look at Google and Quora
Use Google’s Autosuggest feature to start typing a question about your business into the search bar. You’ll see the commonly asked questions people search for. This can be a jumping off point to figure out what questions to put on your own FAQ page.

Another idea is to browse Quora—a site built to answer people’s questions. Just type in a topic, select More Options and then choose All Questions. You’ll get a list of the most recent questions related to that topic.''', question: 'What questions belong on an FAQ page?'),
  FAQModel(answer: '''Animal testing is an issue that we have considered deeply in our mission statement and business practices. We are part of the Leaping Bunny Certification programme, the gold standard for cruelty-free certification… ← boring, not a clear answer.''', question: 'Do you test on animals?'),
  FAQModel(answer: '''8. Show some personality: Just because an FAQ section is direct doesn’t mean it has to be boring. Use it as a chance to write in your brand’s voice (humorous, casual, dignified, etc.) and even share some behind-the-scenes information about your company to add some color to your content. It’s a great chance to show that there’s a real human behind the website (you!) who is thinking about your customers and answering their questions personally.

Example: Include some questions about your company’s quirks''', question: 'Do you issue pre-paid money cards to be used as an alternative to cash for purchases within your store?'),
  FAQModel(answer: '''It stands for frequently-asked questions, and it’s a page on a website that gives quick answers to customer questions. The idea is to keep the answers short and direct so that people find info quickly. We write it as “an FAQ”…(“an eff-ay-cue”) instead of “a FAQ” (a “fack”).''', question: 'What does FAQ mean?'),
  FAQModel(answer: '''It saves you time. If you spend a lot of your time answering emails or social media queries, an FAQ can be a real timesaver. It can also help prevent costly and time-consuming returns in your online store. 
It brings new website traffic and new customers. Google’s goal is to deliver answers to questions. If you put your text in a Q&A format, you’re doing half the work already. Even better, if you have a good answer to a question, you might get featured in one of Google’s answer boxes or feature snippets, which will give you a big traffic boost.
It builds trust and shows that you get it: A well-written FAQ page shows experience. You know what customers are thinking and you’ve already got an answer. It’s a great way to increase the trust and professionalism of your website.''', question: 'What is the purpose of FAQs on your website?'),
  FAQModel(answer: '''How do you decide what questions to answer? Here are some ideas:

Look at your customers’ questions
The first is pretty obvious: What do your customers ask you? Look at your email inbox or social media account and see which questions keep popping up. What usually makes people hesitate before purchasing? What doubts might they have? The more you can automate the answers to these questions, these easier you’ll make it for your customers to buy with confidence. And you’ll save yourself time too.

Look at your competitors’ websites
If you’re a new business or don’t have a lot of customer queries yet, take a look at similar websites for ideas. Bonus points if you can answer the question better than they can.

Look at Google and Quora
Use Google’s Autosuggest feature to start typing a question about your business into the search bar. You’ll see the commonly asked questions people search for. This can be a jumping off point to figure out what questions to put on your own FAQ page.

Another idea is to browse Quora—a site built to answer people’s questions. Just type in a topic, select More Options and then choose All Questions. You’ll get a list of the most recent questions related to that topic.''', question: 'What questions belong on an FAQ page?'),
  FAQModel(answer: '''Animal testing is an issue that we have considered deeply in our mission statement and business practices. We are part of the Leaping Bunny Certification programme, the gold standard for cruelty-free certification… ← boring, not a clear answer.''', question: 'Do you test on animals?'),
  FAQModel(answer: '''8. Show some personality: Just because an FAQ section is direct doesn’t mean it has to be boring. Use it as a chance to write in your brand’s voice (humorous, casual, dignified, etc.) and even share some behind-the-scenes information about your company to add some color to your content. It’s a great chance to show that there’s a real human behind the website (you!) who is thinking about your customers and answering their questions personally.

Example: Include some questions about your company’s quirks''', question: 'Do you issue pre-paid money cards to be used as an alternative to cash for purchases within your store?'),
  FAQModel(answer: '''It stands for frequently-asked questions, and it’s a page on a website that gives quick answers to customer questions. The idea is to keep the answers short and direct so that people find info quickly. We write it as “an FAQ”…(“an eff-ay-cue”) instead of “a FAQ” (a “fack”).''', question: 'What does FAQ mean?'),
  FAQModel(answer: '''It saves you time. If you spend a lot of your time answering emails or social media queries, an FAQ can be a real timesaver. It can also help prevent costly and time-consuming returns in your online store. 
It brings new website traffic and new customers. Google’s goal is to deliver answers to questions. If you put your text in a Q&A format, you’re doing half the work already. Even better, if you have a good answer to a question, you might get featured in one of Google’s answer boxes or feature snippets, which will give you a big traffic boost.
It builds trust and shows that you get it: A well-written FAQ page shows experience. You know what customers are thinking and you’ve already got an answer. It’s a great way to increase the trust and professionalism of your website.''', question: 'What is the purpose of FAQs on your website?'),
  FAQModel(answer: '''How do you decide what questions to answer? Here are some ideas:

Look at your customers’ questions
The first is pretty obvious: What do your customers ask you? Look at your email inbox or social media account and see which questions keep popping up. What usually makes people hesitate before purchasing? What doubts might they have? The more you can automate the answers to these questions, these easier you’ll make it for your customers to buy with confidence. And you’ll save yourself time too.

Look at your competitors’ websites
If you’re a new business or don’t have a lot of customer queries yet, take a look at similar websites for ideas. Bonus points if you can answer the question better than they can.

Look at Google and Quora
Use Google’s Autosuggest feature to start typing a question about your business into the search bar. You’ll see the commonly asked questions people search for. This can be a jumping off point to figure out what questions to put on your own FAQ page.

Another idea is to browse Quora—a site built to answer people’s questions. Just type in a topic, select More Options and then choose All Questions. You’ll get a list of the most recent questions related to that topic.''', question: 'What questions belong on an FAQ page?'),
  FAQModel(answer: '''Animal testing is an issue that we have considered deeply in our mission statement and business practices. We are part of the Leaping Bunny Certification programme, the gold standard for cruelty-free certification… ← boring, not a clear answer.''', question: 'Do you test on animals?'),
  FAQModel(answer: '''8. Show some personality: Just because an FAQ section is direct doesn’t mean it has to be boring. Use it as a chance to write in your brand’s voice (humorous, casual, dignified, etc.) and even share some behind-the-scenes information about your company to add some color to your content. It’s a great chance to show that there’s a real human behind the website (you!) who is thinking about your customers and answering their questions personally.

Example: Include some questions about your company’s quirks''', question: 'Do you issue pre-paid money cards to be used as an alternative to cash for purchases within your store?'),

];