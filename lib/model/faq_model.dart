class FAQModel{
  String question;
  String answer;
  bool isExpanded;

  FAQModel({required this.question, required this.answer,this.isExpanded = false});
}
List<FAQModel> data = [

  FAQModel(answer: '''Please sign up using the link below or contact dylan.lacey@xpresshealth.ie''', question: 'How do we join Xpress Nursing?'),
  FAQModel(answer: '''Xpress Nursing is transparent with the payrates. You will receive your payrates on the first email from us after completing sign up.
We one of the fastest in processing payroll, turning around in 4 days.

Payroll related issues, please email hr@xpresshealth.ie and we will resolve it immediately. ''', question: 'How much we pay?'),
  FAQModel(answer: '''Submit your timesheet by 5pm every Monday to get paid on the following Friday . ''', question: 'When do we get paid ?'),
  FAQModel(answer: '''
Once you complete your sign up, we will send you the unifrom and ID card.
''', question: 'How can I get unifrom and ID card ?'),
  FAQModel(answer: '''
Yes, Xpress Nursing is always supporting our staff. We provide free uniforms, ID cards and also pay for Garda Vetting.
''', question: 'Do we pay for Uniform, ID Card and Garda Vetting?'),
//   FAQModel(answer: '''
// Yes, Xpress Nursing is always supporting our staff. We provide free uniforms, ID cards and also pay for Garda Vetting.
// ''', question: 'How do I complete my sign up sheet?'),

];