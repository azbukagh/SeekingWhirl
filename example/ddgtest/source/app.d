import std.array;
import std.stdio;
import std.conv;
import SeekingWhirl;

int main(string[] args) {
	if(args.length <= 1)
		return -1;
	string searchString = join(args[1 .. $], " ");
	SeekingWhirl ddg = new SeekingWhirl(searchString);
	writeln("DDG.Abstract=", ddg.Abstract);
	writeln("DDG.AbstractText=", ddg.AbstractText);
	writeln("DDG.AbstractSource=", ddg.AbstractSource);
	writeln("DDG.AbstractURL=", ddg.AbstractURL);
	writeln("DDG.Image=", ddg.Image);
	writeln("DDG.Heading=", ddg.Heading);
	
	writeln("DDG.Answer=", ddg.Answer);
	writeln("DDG.AnswerType=", ddg.AnswerType);
	
	writeln("DDG.Definition=", ddg.Definition);
	writeln("DDG.DefinitionSource=", ddg.DefinitionSource);
	writeln("DDG.DefinitionURL=", ddg.DefinitionURL);

	for(ulong i = 0; i < ddg.RelatedTopics.length; i++) {
		writeln("DDG.RelatedTopics[",i,"].Result="
			, ddg.RelatedTopics[i].Result);
		writeln("DDG.RelatedTopics[",i,"].FirstURL="
			, ddg.RelatedTopics[i].FirstURL);
		writeln("DDG.RelatedTopics[",i,"].Text="
			, ddg.RelatedTopics[i].Text);
		writeln("DDG.RelatedTopics[",i,"].Icon.URL="
			, ddg.RelatedTopics[i].Icon.URL); 
		writeln("DDG.RelatedTopics[",i,"].Icon.Height="
			, ddg.RelatedTopics[i].Icon.Height);
		writeln("DDG.RelatedTopics[",i,"].Icon.Width="
			, ddg.RelatedTopics[i].Icon.Width);
	}
	for(ulong i = 0; i < ddg.Results.length; i++) {
		writeln("DDG.Results[",i,"].Result="
			, ddg.Results[i].Result);
		writeln("DDG.Results[",i,"].FirstURL="
			, ddg.Results[i].FirstURL);
		writeln("DDG.Results[",i,"].Text="
			, ddg.Results[i].Text);
		writeln("DDG.Results[",i,"].Icon.URL="
			, ddg.Results[i].Icon.URL);
		writeln("DDG.Results[",i,"].Icon.Height="
			, ddg.Results[i].Icon.Height);
		writeln("DDG.Results[",i,"].Icon.Width="
			, ddg.Results[i].Icon.Width);
	}

	writeln("DDG.Type=" , ddg.Type);
	writeln("DDG.Redirect=" , ddg.Redirect);
	return 0;
} 
