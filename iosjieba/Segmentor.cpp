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

void JiebaInit(const string& dictPath, const string& hmmPath, const string& userDictPath)
{
    if(globalSegmentor == NULL) {
        globalSegmentor = new MixSegment(dictPath, hmmPath, userDictPath);
    }
    cout << __FILE__ << __LINE__ << endl;
}

void JiebaCut(const string& sentence, vector<string>& words)
{
    assert(globalSegmentor);
    globalSegmentor->cut(sentence, words);
    cout << __FILE__ << __LINE__ << endl;
    cout << words << endl;
}