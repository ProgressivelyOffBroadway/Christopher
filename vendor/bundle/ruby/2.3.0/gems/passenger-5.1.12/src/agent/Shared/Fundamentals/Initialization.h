/*
 *  Phusion Passenger - https://www.phusionpassenger.com/
 *  Copyright (c) 2010-2017 Phusion Holding B.V.
 *
 *  "Passenger", "Phusion Passenger" and "Union Station" are registered
 *  trademarks of Phusion Holding B.V.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */
#ifndef _PASSENGER_AGENT_FUNDAMENTALS_INITIALIZATION_H_
#define _PASSENGER_AGENT_FUNDAMENTALS_INITIALIZATION_H_

/** Common initialization code for all agents. */

#include <cstddef>
#include <Utils/VariantMap.h>
#include <Shared/Fundamentals/AbortHandler.h>

namespace Passenger {
namespace Agent {
namespace Fundamentals {


struct Context {
	ResourceLocator *resourceLocator;
	unsigned int randomSeed;
	int origArgc;
	char **origArgv;
	bool feedbackFdAvailable;
	AbortHandlerConfig abortHandlerConfig;
};

typedef void (*OptionParserFunc)(int argc, const char **argv, VariantMap &options);
typedef void (*PreinitializationFunc)(VariantMap &options);

extern Context *context;


VariantMap initializeAgent(int argc, char **argv[], const char *processName,
	OptionParserFunc optionParser = NULL, PreinitializationFunc preinit = NULL,
	int argStartIndex = 1);
void shutdownAgent(VariantMap *agentOptions);

bool feedbackFdAvailable();
void restoreOomScore(VariantMap *agentOptions);


} // namespace Fundamentals
} // namespace Agent
} // namespace Passenger

#endif /* _PASSENGER_AGENT_FUNDAMENTALS_INITIALIZATION_H_ */
