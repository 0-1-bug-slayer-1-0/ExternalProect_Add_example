#include <iostream>
#include "unity.h"
//#include "unity_config.h"

#define RUN_TEST_CUSTOM(TestFunc, TestLineNum) \
{ \
  Unity.CurrentTestName = #TestFunc; \
  Unity.CurrentTestLineNumber = TestLineNum; \
  Unity.NumberOfTests++; \
  if (TEST_PROTECT()) \
  { \
      setUp(); \
      TestFunc(); \
  } \
  if (TEST_PROTECT()) \
  { \
    tearDown(); \
  } \
  UnityConcludeTest(); \
}

template<typename T>
T add(T a, T b)
{
    return a + b;
}

void setUp(void)
{

}

void tearDown(void)
{

}

void TEST_addFunction(void)
{
    TEST_ASSERT_EQUAL(10, add(5,5));
    TEST_ASSERT_EQUAL(0, add(-5,5));
    TEST_ASSERT_EQUAL(-8, add(-9,1));
}

void TEST_addFunctionFloat(void)
{
    TEST_ASSERT_EQUAL_FLOAT(3.5f, add(2.5f, 1.0f));
    TEST_ASSERT_GREATER_THAN(5.5f, add(2.5f, 1.0f));
}


int main() {
    std::cout << "TEST STARTED..." << std::endl;
    UnityBegin("test/main.cpp");
    RUN_TEST_CUSTOM(TEST_addFunction, 38);
    RUN_TEST_CUSTOM(TEST_addFunctionFloat, 45);
    return (UnityEnd());

}
