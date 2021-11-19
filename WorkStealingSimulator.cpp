#include <iostream>
#include <vector>

typedef int tick_t;

class Task {
    private :
        tick_t ticksRequired;
        tick_t spawnTick;
        tick_t startTick;
        tick_t endTick; // -1 if task is not completed
    public :
        Task(tick_t ticksRequired, tick_t spawnTick) 
        : ticksRequired(ticksRequired) 
        , spawnTick(spawnTick)
        , startTick(-1)
        , endTick(-1) {}

        int addToDeq(tick_t currentTick) {}
        int execute(tick_t currentTick) {
            this->endTick = currentTick + this->ticksRequired;
        } 
};

class Core {
    private :
    public :
        int processTask();
        std::set<Task> spawnTask();

};