
Add this field and apply the change:
```json
    {
      "default": null,
      "doc": "time that the event occurred (epoch time in ms).",
      "name": "timestamp",
      "type": [
        "null",
        "long"
      ]
    },
```

# Surprises

One that gets me regularly is that the kafka broker and the schema registry require different API keys.

You can have one service account that has access to both, but the API keys required are not the same.

# Good ideas

Start simple, then build from there. This project is a simple example of a CC environment that can be used as a starting 
point to learn how to do things better.

Make modules, because they make you life simpler. It won't seem like it at first, but being able to inject a provider 
into a module where you are creating topics and not needing to provide the `kafka_cluster`, `rest_endpoint`, and 
`credentials` attributes every time will make things much easier to read and maintain.

Use terragrunt, because you will have more than one environment eventually, and while it is a bit more work to start 
with, the payoff is tremendous later.

Do not use the CC web UI unless you absolutely have to, and it is a crisis. With apologies to the people that work on 
it, it is not an effective tool to use for managing anything more than a very simple demonstration. If you DO have to 
use it, once the crisis is averted, be diligent to go back to your TF setup and reconcile it.

Get opinionated. The confluent TF provider will let you do almost anything. That is a blessing and a curse, because 
there are not many guardrails to keep you from doing things you maybe should not do. After several months of wrestling
with a 12-foot oiled snake, we finally have some good patterns and practices. I will share as much as I can and 
hopefully my opinions are not too far from yours, and they will be of use to you. If you see something that sucks, tell 
me, and tell me why. There might be a reason for it that applies in my environment that does not in yours. Or one of us 
might just be thinking about it incorrectly. Either way, I want to know. Discussions like that are super valuable for 
everyone involved.

Try it. That sounds silly, but one great thing about TF is that you can apply and destroy changes pretty quickly and 
easily. If you create a basic ephemeral environment that you can use to try stupid things in, you can learn a lot.

Plan for mistakes, you will make them. Refine your patterns and iron out the wrinkles. Time spent in this stage will 
make life easier for everyone.

