#define BOOST_TEST_MODULE test_demo
#include <boost/test/included/unit_test.hpp>
#include "addition.hpp"

BOOST_AUTO_TEST_CASE(test_demo0)
{
  BOOST_TEST(1==1);
}

BOOST_AUTO_TEST_CASE(test_demo1)
{
  BOOST_TEST(add(1,1) == 2);
}
