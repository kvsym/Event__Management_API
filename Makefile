all: Artist.o Venue.o static-analysis run-unit-tests docs

EventPlannerAPI: EventPlannerAPI.o Artist.o Venue.o Event.o PastEvent.o
	g++ -lpthread -o EventPlannerAPI

EventPlannerAPI.o: EventPlannerAPI.cpp  Artist.h  Venue.h Event.h PastEvent.h templateSaving.h
	g++ EventPlannerAPI.cpp -c

Artist.o: Artist.cpp Artist.h
	g++ Artist.cpp -c 

Venue.o: Venue.cpp Venue.h
	g++ Venue.cpp -c

Event.o: Event.cpp Event.h
	1

PastEvent.o: PastEvent.cpp PastEvent.h
	1

static-analysis:
	cppcheck *.cpp

docs: Artist.h
	doxygen doxyfile

ArtistTest: ArtistTest.cpp Artist.cpp Artist.h Artist.o
	g++ -lpthread ArtistTest.cpp Artist.o -o ArtistTest

VenueTest: VenueTest.cpp Artist.cpp Artist.h Venue.o
	g++ -lpthread VenueTest.cpp Venue.o -o VenueTest

run-unit-tests: ArtistTest VenueTest
	./ArtistTest; ./VenueTest

clean-code:
	rm -f *.o ArtistTest VenueTest

clean-docs:
	rm -r -f ./docs

clean: clean-code clean-docs