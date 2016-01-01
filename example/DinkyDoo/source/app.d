import std.array;
import std.stdio;
import std.conv;
import std.random;
import DuckDuckGo;
int main(string[] args) {
	if(args.length <= 1)
		return -1;
	
	writeln(randomGreeting());
	string searchString = join(args[1 .. $], " ");
	DuckDuckGo ddg = new DuckDuckGo(searchString);
	if(ddg.Results.length == 0) {
		writeln("There is no results for ", searchString,". Check syntax and try again!");
	} else {
		writeln("I found ", ddg.Results[0].Text, " at ", ddg.Results[0].FirstURL);
		for(ulong i = 1; i < ddg.Results.length; i++) {
			writeln("and ",ddg.Results[i].Text, " at ", ddg.Results[i].FirstURL);
		}
	}
	
	if(ddg.RelatedTopics.length > 0) {
		writeln("Maybe you wanna see related topics like:");
		writeln(ddg.RelatedTopics[0].Text, " at ", ddg.RelatedTopics[0].FirstURL);
		for(ulong i = 1; i < ddg.RelatedTopics.length; i++) {
			writeln("and ",ddg.RelatedTopics[i].Text, " at ", ddg.RelatedTopics[i].FirstURL);
		}
	}
	writeln(randomParting());
	return 0;
} 

string randomGreeting() {
	string[] greetings = [
		"Hello!",
		"Hi!",
		"Hi there!",
		"Hey!",
		"What's up?",
		"Hey-Hey-Hey, stay out of... Uhm... Hello?"
	];
	return greetings[uniform(0, greetings.length)];
}

string randomParting() {
	string[] partings = [
		"Goodbye",
		"Have a good day",
		"Farewell",
		"Take care",
		"Bye",
		"Cheers!",
		"See you later"
	];
	return partings[uniform(0, partings.length)];
}
