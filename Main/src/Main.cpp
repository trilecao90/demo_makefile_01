#include "test.h"
#include "LibDynamic_01.h"
#include "LibDynamic_02.h"
#include "LibStatic_01.h"
#include "LibStatic_02.h"

int main() {
    func();
    funcDynamic_01();
    funcDynamic_02();
    funcStatic_01();
    funcStatic_02();
    return 0;
}