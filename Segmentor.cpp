//
//  Segmentor.cpp
//  iosjieba
//
//  Created by yanyiwu on 14/12/24.
//  Copyright (c) 2014年 yanyiwu. All rights reserved.
//

#include "Segmentor.h"
#include <iostream>

using namespace CppJieba;

CppJieba::MixSegment * globalSegmentor;

void init(const string& dictPath, const string& hmmPath, const string& userDictPath)
{
    cout << __FILE__ << __LINE__ << endl;
}

void cut(const string& sentence, vector<string>& words)
{
    cout << __FILE__ << __LINE__ << endl;
}