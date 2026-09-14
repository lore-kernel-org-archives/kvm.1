Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465F49BD91;
	Mon, 14 Sep 2026 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409429; cv=fail; b=C4eHoYCC44YBL/si8wjELbkmkyQqSvBazGib8+ddLHPLvrtx8zirth+XdRkITTi5UX3NAsOvsq9lTi+hFTeim8jTENJvZClYep12ZqyEFgUqvjrKLc/HiQvcauwfREewBg9YrOsLC4B2jFU9VvHe172STSt/uHxlnz4WnGoif5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409429; c=relaxed/simple;
	bh=2Vp1cSstBcy/dsf1S4XKvO3FOntuMxUpyXVl4Bo+wrw=;
	h=Content-Type:Message-ID:Date:From:Subject:To:CC:References:
	 In-Reply-To:MIME-Version; b=q4pfSqX3pSo9X9x9/V9aLgMaPx51c8IsQHR6d2Ywn/Xft2lsajqjKueQvtf7RO61S1W+gEF9NWCBjz/9jKfjSH50MKl/A6MA3Kpdi+3b0X2D92i+Z55EZtnveGQzb5f2pgug3ck1IeOf4FwrP3hU1Uoq1nuy6yp9l4oCDVufNLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5NS0a57; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5NS0a57"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789409425; x=1820945425;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:mime-version;
  bh=2Vp1cSstBcy/dsf1S4XKvO3FOntuMxUpyXVl4Bo+wrw=;
  b=d5NS0a5790BVBArsCN6/d8ssNtDjMq/wiz/GuUSeEpBYvoHkNd06xDyJ
   l6DF5nao7lcUbWNItpkFyiasoS8eOzUL1TkshRZ7uW6avXWSvfR9gCXIx
   sgAw3rXfQW40dgDwNYfcPNwM0L8doORTg3ZdsnPrxOe+LqQi8qP2z5lnp
   PodsniF8txD/KRIk0+Yo0+xPC8YFw9ncrGMg+WGMvLTJI1z0f65i+IkjI
   +RQ24z7we4X12rcKcx8J3KMwB1cT7ADc24RO/H7HRwm8LufLWpb+7X8UN
   4Y3g8/8lgRy1aKcNKiY31XyfMQ6odtZaKncJ10mnbLa1SyiI0CoZS/oEg
   A==;
X-CSE-ConnectionGUID: fASeqwRzQCKaWl7/51CwuA==
X-CSE-MsgGUID: yVEDzHn5R2ihGb1ZbRSkMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="277198"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="diff'?scan'208";a="277198"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 11:10:19 -0700
X-CSE-ConnectionGUID: uNwj/2XJT+G76EXZkjFnYw==
X-CSE-MsgGUID: g48XJsvXTCO/MjEra/UnHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="diff'?scan'208";a="266502735"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 11:10:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 11:10:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 11:10:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 11:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRJM0aKGcPMoFZhNv6+6HzYYqHOtbcPd4Lmye6B4kAiGRjcuTrVXbqqmgrxZjBHm/BpLlO7ndiKU15UL+QJB4J5zqQTEHv24zWuBTgUTgKDw2aDqnelcQnKDUYSeJemleh3T3dOLXONtzLhAi2d3n92izbXjVCamMUfvFKymzNfIcqKjrK1P67Um7K6Bg0+06ucpiHfXelEMtFRwY4p6t8tbeQkfqCTclpyy6tD2jRt9Jd5ewYFdT1D+jInMSGYG4mXAeO1FpO+nHznjpLeplRzA8v3x+nZml8rIRzbpOM0EQwf70ezFQ4/FQ7PUPWWVe9iYBzwsB89vlyn10jI3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxv5sh+Ls2KOCzluIeZbN9B1rJK4scKqo3GduotlrHw=;
 b=EOAAzrwpG9jXO/ot4wDj6mDYwsvKjoScx43RL4pQTsylMxZLIi5xo0+H41xPp4S5ebQm0SnhtbhrgVKcl4+hiI30c5mAW14NODP49hQng4DJC+Z4IDG5FhoGX0ZAHYFupAEbaKJB78dYBXEM32i7ZtrVmiG8cs0Qe9Uo3/LwapaqltYQrfI9REAXpO9BhVz1BzD7q2bgEZP+KF588Bha9MDs5MrZ8/4gtxmlfl8QhtvS5YBBJGPFSbl2eHgK/bp+8CSYuzyQ1Pr5+SBIt+AvcdAm02B3MkshjPmqXJgqUBNpSo2XdCo4qeSD0e1JGJ02qwpXOZuEJfPo1/ehKa3TRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA3PR11MB9373.namprd11.prod.outlook.com (2603:10b6:208:57f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Mon, 14 Sep 2026 18:10:11 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:10:11 +0000
Content-Type: multipart/mixed;
	boundary="------------YbDS0kCkoMt40GBAU4DJsL1y"
Message-ID: <e6220b0e-0f5c-435f-823e-318b527eee8a@intel.com>
Date: Mon, 14 Sep 2026 17:43:28 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
To: Sohil Mehta <sohil.mehta@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Kai Huang <kai.huang@intel.com>, Fuad Tabba
	<fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, David Matlack
	<dmatlack@google.com>, Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com>
Content-Language: en-US
In-Reply-To: <20260806011536.4172258-5-sohil.mehta@intel.com>
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA3PR11MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: de737558-13b6-4bcd-9b9e-08df128b6ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|6049299003|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|4053099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: i3vppJECHKNeQyB56/YTs1Tm+y4wT9kWF8q9EVQj5o91Akvy7dHU4XPxtPGzGVtlHHDzkD7Bj6jN3xc9aHSSA4EmNmz6KbTSf7hHA7iKDrhGxE1ynuG+WNsJI48BXC+BOYP+zRw/ctrQeQUS15baziCUww0qDrD3XE8W79pBxVArN8q1dhLvJ/u0jNjihgZH+Wgs9++4dLKAOhSOEmmnvByOOWWOkANR+tDjScV1Zr12P5NSvKpR/icx+uMxdLRs9GShmeEk+mof7ekV/IerrdsdurkcHyC0Dd7loGd7GBvU6ybf2UTLMY3/HJgMAA8SSIIoPnIQK413BYoK/7GaPumyL+VQjun1ah5UOXxjYeZRBhVapnYEV6sXggKVJGUfQCNM00t6gHQVaKnIyXLhVO8+WSnffS2PYqQ4owwOAI243q2PeheZ6EGjLRwC7W74Ki3qZtXLPbFkItkVmVXDOmw+8BHyIAf3Wh6LwUNBQzR9MLT8aD0ZKFJYqo6nMo1tNpr+vAP6KGV2b4kBZdMpNgmtNEhsKLKYc+dTpxA8FBUlV7RY2OhwyaQTb+zg1T9z0Zcb2khL8fXFGv+ZCnoCzfwrL0Jac7ChCfcjtHoXnpmMaJ4vR6m5ZERmmNqhilrJphhpi9lyJ42LIguIag0ewrQR3JlS/3gB80LU5HyGlUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(4053099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2locURQUXBla0tJeU94VHU3TzZ2V1hKTFVTU2lBKzBHZkpEakNveW9DcWZ4?=
 =?utf-8?B?VlNUOEE2TlduTy8zcnVaVmpEK2VlWGNUTGRZWStUOFhSVTh1NnZneEt3Z2xY?=
 =?utf-8?B?cEdQd0FTOHJnN0VFRDh2L1Q2cXBXYTBRQk5raEJrZHh4REJQcjA4eEZKZWpk?=
 =?utf-8?B?WHRlUlVKNGxBb0RaQURycFVKTEo2aWNkKzY1cWQra0thZTBydUV2eG9OMkZh?=
 =?utf-8?B?T3J5YTYxQVpqbjBZZFY2ckluM3Z2R3BINkdQS1RrY1RnQXdiM0VPdlRDa2p4?=
 =?utf-8?B?VzZKNWhvNnQxM3BPODhpbVZ0MUlHbk9yUWhrbHR6VGk3ckZ0SHRyMEJvWm9Y?=
 =?utf-8?B?VGJtaHZpcVJTekZGSU9PKzY4QkZ6NlFpWitQRmEvWHNETnlnTEVSYXZoT2JZ?=
 =?utf-8?B?L1RPVmYwS0lwajc5MVVCN2x2YW14M1Z5R2gwV3F0bUFpSnY3WDFBQXVubjhM?=
 =?utf-8?B?aTlJWGxaUzQxTFJNTEE3R0NlRi9XaTdXMkpOS0V3M0pxamJtV2htQm9PQVR6?=
 =?utf-8?B?OUhXMW1FTUxvUUJKanpJbFNWY0lDOVhqN3A2dzhnSUVjV1h6K2JFMTcwc0Y4?=
 =?utf-8?B?NWpvUHgyY3UrTHBES3VBeWQ2OGJ4NWR5UXBreFNFL0ttdTdzbWlseHNNV2pK?=
 =?utf-8?B?dzhpbUVwc0g3Y1ptTmVJVXZMT0VBYXltd3pmOElhODFWTVNKUHJjbDE5VHBX?=
 =?utf-8?B?a212eFNOOFZxSjJvRWkvZFp5ZlVsNVlBbWtmc2IyTjROYUF6L1d6Smxjazl1?=
 =?utf-8?B?eGZLL1M4N1BSRkpCY0UrTUpwd1lyOWdiUk9ITlVpT3BlbVJGVFp3d3VveE00?=
 =?utf-8?B?YUJvekdvUXYwMWZVdFIyYW9Ld2trd3dkblpZOG1YTDU4TTJoR3Z1aWhDOTFu?=
 =?utf-8?B?b2tsMXpRa3Vtb1kwSHR1V2YxSGUwTEFIUFJxbmRqTmlXNFRRK25xUjdxR2Jv?=
 =?utf-8?B?dEMwQ1FsZCs1aU84OGx0enBmdVRQVU5CRFY3YW5EakdGSTFmeGx2MEpGZXJ4?=
 =?utf-8?B?MjJhQ3BtQjR1Z2ZvU1dNRmdHZWVoQy9IOEowaDdFUmtQdW93cHJLcWNOYUZZ?=
 =?utf-8?B?RkJkQTNldTU5Q1pKaGdVcXFuYnhvRStySFUzdFdlVWdzZjU0VktTM0NBWTVI?=
 =?utf-8?B?QkE2dENkNmhqTllTTURCaVAyNE9lSC9oS2E2MHRURCtnWmJxV2lOSEk4TDF4?=
 =?utf-8?B?T0dZYktpOEl2WGxCbGY4dENqL29tTWJGY3BVVklUTGtmeXRObXUzN0ZkVHFo?=
 =?utf-8?B?clRXNTl0OVh5SGRiSlg0YzhBMktJNkpwSFUvUzlxdlp2dUJZSzlnZi9pTEVz?=
 =?utf-8?B?QjBRZUxMUndlcDdGTHJpYk5Kdzc4NzVyS0lMZ2s3ZCtUZ0VWRGFHSTFFRFh4?=
 =?utf-8?B?RDlqY296MDExdFhjVjM4RnF4bmZLMTNKSXNsbm4zR3hpaTZENGhaS3FLWmxt?=
 =?utf-8?B?OFNIYk84RkJhMW9VM3BlY1E5a3BIODdDR3UrbWU1L1ZxVTNOV3RUeitsdDVn?=
 =?utf-8?B?Qlo2RmpKQ3o3L3RvVmViS2NtVURaSldrRHJLbnhkdEV2WFFEL1VEQlp4M0dz?=
 =?utf-8?B?N1dlaEo4dWRHcWdqUitsSDg2OTkybldhRnFjazNmQlc2emJzVHpDL3pLRnFE?=
 =?utf-8?B?RzQvcjlpWWdMNnk0SW15dEFBREtqK1J1Q3J0eWdvbkp4QitKTVRlWVNoZ1dC?=
 =?utf-8?B?UjlMbnpwejlobmd0ZVRlYUZseFdaL01BaCtrRUF1UTRldVFUYnJ5MjFiY2ps?=
 =?utf-8?B?cjFUbFNxYkMxdnRyTFAvRnFoa1V3VEJWeXdibHdRejVtUHQwODFsMmhsMlNC?=
 =?utf-8?B?aERsR3g0b2hmdHgrUlZJT1QrbmxQVFNxN3p1OFQ2c3FKRHZyci9nUmlBVG9a?=
 =?utf-8?B?ZS9ObkdNWG9vOU5nazVYRXRyTUJmdGg2RUtxMldvVjcxZVQraElzSW15Mkhm?=
 =?utf-8?B?UWRubEVGZ00ycEFHYXZhd3didW03UlZSMjZLZmttQUVtRVBLR2RXSWd2aWJt?=
 =?utf-8?B?Q3VvcEQ2bm9USE5nazhxNFE2VzRxY3BpRGpJVnE3YWN0bit5bC9SblNqbnJX?=
 =?utf-8?B?czZMS0UwRUhhR3NzOWZPeHYzQzFVcHdUc3VpWVh5RVFTeCt6WHlNRzJaL25l?=
 =?utf-8?B?QmU0Y3N3S0UvWm1OQlQrNjgrbStmcWJyU2dwcmZkRGJDdmwrYVZPRU9rdnlo?=
 =?utf-8?B?MXRlc3BHanJXUkNIaWllZWk2VEJNMVllUUtzQWlaNmFKYmVpZTIyMXdyVHk1?=
 =?utf-8?B?Z3BiMG1MNTVTODlNNzJlRk9NeVNWUCtFeXE5Q1ZJV2FIQ0EyUWNQalpUZC93?=
 =?utf-8?B?TWpkUVRzQzdZYlNqSHowcE9xdmJiYkxOSnZnMDVjUTVYRFZQUU9sdz09?=
X-Exchange-RoutingPolicyChecked: zJIHwrUx95d4ykmXH/4kVEjkUFQkcsQbN+q1AeEBXCI7lMWFxTwACcEtFmkvrSAIM5HefQFYNAGGm3jWxHEbJqjeKJTBJD++hwvmXhIboMTb7ywlNjDDCZhnASflrq2AMMXMpLNOZSab46vic5Hbirb6FHPln0lW2DYAyITP+j8iXe0fld8Hsu0Yl8EsyTAhsT0KhdP2FSwQxTq5N3nhpB/nWR4MH6/EivsyCcGlwK2oZSfdnSp7oihE3k6tBO9OGmpvWCYxnkHHEQNykXN/HeMUO6WDTxuAMyheHSLWYzgt59bzhIgFLvPNKFxagCUsQ4LbYae98rLmUavf3W+xuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: de737558-13b6-4bcd-9b9e-08df128b6ab2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:10:11.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrHWzRSWQE6kXbNAAV8atoS5ByrnEBQgm/65XndWVhu2ELNXuH2lsdf/RGJg2JoHdAAwPPbgoa//qqgc3i/hZFyCe6j8hnf/ylQqcGvhudw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9373
X-OriginatorOrg: intel.com

--------------YbDS0kCkoMt40GBAU4DJsL1y
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/2026 6:15 PM, Sohil Mehta wrote:
> 
> +bool vmx_is_lass_violation(struct kvm_vcpu *vcpu, gva_t gva,
> +			   unsigned int size, unsigned int flags)
> +{
> +	const bool is_supervisor_address = !!(gva & BIT_ULL(63));
> +	const bool implicit_supervisor = !!(flags & X86EMUL_F_IMPLICIT);
> +	const bool fetch = !!(flags & X86EMUL_F_FETCH);
> +
> +	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_LASS) || !is_long_mode(vcpu))
> +		return false;
> +
> +	/*
> +	 * INVLPG isn't subject to LASS, e.g. to allow invalidating userspace
> +	 * addresses without toggling RFLAGS.AC.  Branch targets aren't subject
> +	 * to LASS in order to simplify far control transfers (the subsequent
> +	 * fetch will enforce LASS as appropriate).
> +	 */
> +	if (flags & (X86EMUL_F_BRANCH | X86EMUL_F_INVLPG))
> +		return false;
> +
> +	if (!implicit_supervisor && vmx_get_cpl(vcpu) == 3)
> +		return is_supervisor_address;
> +
> +	/*
> +	 * LASS enforcement for supervisor-mode data accesses depends on SMAP
> +	 * being enabled, and like SMAP ignores explicit accesses if RFLAGS.AC=1.
> +	 */
> +	if (!fetch) {
> +		if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_SMAP))
> +			return false;
> +
> +		if (!implicit_supervisor && (kvm_get_rflags(vcpu) & X86_EFLAGS_AC))
> +			return false;
> +	}
> +
> +	/*
> +	 * The entire access must be in the appropriate address space.  Note,
> +	 * if LAM is supported, @gva has already been untagged, so barring a
> +	 * massive architecture change to expand the canonical address range,
> +	 * it's impossible for a user access to straddle user and supervisor
> +	 * address spaces.
> +	 */
> +	if (size && !((gva + size - 1) & BIT_ULL(63)))
> +		return true;
> +
> +	return !is_supervisor_address;
> +}

This looks like an essential piece for the check introduced in the 
series. I could follow the logic, and it looks sane to me. If allowed,

   Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

The code also looks to be written according to Sean's comment in:

   https://lore.kernel.org/kvm/ZNwOYdy3AC12MI52@google.com

Yes, this could be a matter of taste as taking and going to maintain the 
code. But as a reader looking at this, the logic was not that easy to 
capture at a high level.

So what the the bottom half code does seems to be something like:

   if in user mode,
       violated if gva is a supervisor address

   if in supervisor mode,
       if LASS enforcement is applicable,
           violated if either gva or its access end is an user address

Maybe the high-level logic could be highlighted first. Attached a diff 
to help figuring out that option just in case. Feel free to ignore if it 
doesn't matter that much.

Thanks,
Chang
--------------YbDS0kCkoMt40GBAU4DJsL1y
Content-Type: text/x-patch; charset="UTF-8"; name="tmp.diff"
Content-Disposition: attachment; filename="tmp.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvbWFpbi5jIGIvYXJjaC94ODYva3ZtL3ZteC9t
YWluLmMKaW5kZXggNGM1MmFiOGQwNzg2Li41ZTJhNzAzZTRiZTYgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L2t2bS92bXgvbWFpbi5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvbWFpbi5jCkBAIC0xMDMx
LDYgKzEwMzEsNyBAQCBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgdnRfeDg2X29wcyBfX2luaXRkYXRhID0g
ewogCS52Y3B1X2RlbGl2ZXJfc2lwaV92ZWN0b3IgPSBrdm1fdmNwdV9kZWxpdmVyX3NpcGlfdmVj
dG9yLAogCiAJLmdldF91bnRhZ2dlZF9hZGRyID0gdm14X2dldF91bnRhZ2dlZF9hZGRyLAorCS5p
c19sYXNzX3Zpb2xhdGlvbiA9IHZteF9pc19sYXNzX3Zpb2xhdGlvbiwKIAogCS5tZW1fZW5jX2lv
Y3RsID0gdnRfb3BfdGR4X29ubHkobWVtX2VuY19pb2N0bCksCiAJLnZjcHVfbWVtX2VuY19pb2N0
bCA9IHZ0X29wX3RkeF9vbmx5KHZjcHVfbWVtX2VuY19pb2N0bCksCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rdm0vdm14L25lc3RlZC5jIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYwppbmRleCAx
NTE4NzM0MDdhYmQuLjNhZDUzNzRkNDVmYyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC9u
ZXN0ZWQuYworKysgYi9hcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jCkBAIC01MzA4LDExICs1MzA4
LDEyIEBAIGludCBnZXRfdm14X21lbV9hZGRyZXNzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5z
aWduZWQgbG9uZyBleGl0X3F1YWxpZmljYXRpb24sCiAJCQkqcmV0ID0gb2ZmOwogCiAJCSpyZXQg
PSB2bXhfZ2V0X3VudGFnZ2VkX2FkZHIodmNwdSwgKnJldCwgMCk7Ci0JCS8qIExvbmcgbW9kZTog
I0dQKDApLyNTUygwKSBpZiB0aGUgbWVtb3J5IGFkZHJlc3MgaXMgaW4gYQotCQkgKiBub24tY2Fu
b25pY2FsIGZvcm0uIFRoaXMgaXMgdGhlIG9ubHkgY2hlY2sgb24gdGhlIG1lbW9yeQotCQkgKiBk
ZXN0aW5hdGlvbiBmb3IgbG9uZyBtb2RlIQorCQkvKgorCQkgKiBMb25nIG1vZGU6ICNHUCgwKS8j
U1MoMCkgaWYgdGhlIG1lbW9yeSBhZGRyZXNzIGlzIGluIGEKKwkJICogbm9uLWNhbm9uaWNhbCBm
b3JtLCBvciBpZiB0aGUgYWNjZXNzIHZpb2xhdGVzIExBU1MuCiAJCSAqLwotCQlleG4gPSBpc19u
b25jYW5vbmljYWxfYWRkcmVzcygqcmV0LCB2Y3B1LCAwKTsKKwkJZXhuID0gaXNfbm9uY2Fub25p
Y2FsX2FkZHJlc3MoKnJldCwgdmNwdSwgMCkgfHwKKwkJICAgICAgdm14X2lzX2xhc3NfdmlvbGF0
aW9uKHZjcHUsICpyZXQsIGxlbiwgMCk7CiAJfSBlbHNlIHsKIAkJLyoKIAkJICogV2hlbiBub3Qg
aW4gbG9uZyBtb2RlLCB0aGUgdmlydHVhbC9saW5lYXIgYWRkcmVzcyBpcwpAQCAtNjExNyw3ICs2
MTE4LDcgQEAgc3RhdGljIGludCBoYW5kbGVfaW52dnBpZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUp
CiAJaWYgKHR5cGUgIT0gVk1YX1ZQSURfRVhURU5UX0FMTF9DT05URVhUICYmICFvcGVyYW5kLnZw
aWQpCiAJCXJldHVybiBuZXN0ZWRfdm14X2ZhaWwodmNwdSwgVk1YRVJSX0lOVkFMSURfT1BFUkFO
RF9UT19JTlZFUFRfSU5WVlBJRCk7CiAKLQkvKiBMQU0gZG9lc24ndCBhcHBseSB0byBhZGRyZXNz
ZXMgdGhhdCBhcmUgaW5wdXRzIHRvIFRMQiBpbnZhbGlkYXRpb24uICovCisJLyogTEFNIGFuZCBM
QVNTIGRvbid0IGFwcGx5IHRvIGFkZHJlc3NlcyB0aGF0IGFyZSBpbnB1dHMgdG8gVExCIGludmFs
aWRhdGlvbi4gKi8KIAlpZiAodHlwZSA9PSBWTVhfVlBJRF9FWFRFTlRfSU5ESVZJRFVBTF9BRERS
ICYmCiAJICAgIGlzX25vbmNhbm9uaWNhbF9pbnZscGdfYWRkcmVzcyhvcGVyYW5kLmdsYSwgdmNw
dSkpCiAJCXJldHVybiBuZXN0ZWRfdm14X2ZhaWwodmNwdSwgVk1YRVJSX0lOVkFMSURfT1BFUkFO
RF9UT19JTlZFUFRfSU5WVlBJRCk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3NneC5j
IGIvYXJjaC94ODYva3ZtL3ZteC9zZ3guYwppbmRleCA3NzFjNzVhNTgzNDMuLjRhYzMwNWVkNmRl
YSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC9zZ3guYworKysgYi9hcmNoL3g4Ni9rdm0v
dm14L3NneC5jCkBAIC0zOSw3ICszOSw4IEBAIHN0YXRpYyBpbnQgc2d4X2dldF9lbmNsc19ndmEo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBsb25nIG9mZnNldCwKIAkJZmF1bHQgPSB0
cnVlOwogCX0gZWxzZSBpZiAobGlrZWx5KGlzXzY0X2JpdF9tb2RlKHZjcHUpKSkgewogCQkqZ3Zh
ID0gdm14X2dldF91bnRhZ2dlZF9hZGRyKHZjcHUsICpndmEsIDApOwotCQlmYXVsdCA9IGlzX25v
bmNhbm9uaWNhbF9hZGRyZXNzKCpndmEsIHZjcHUsIDApOworCQlmYXVsdCA9IGlzX25vbmNhbm9u
aWNhbF9hZGRyZXNzKCpndmEsIHZjcHUsIDApIHx8CisJCQl2bXhfaXNfbGFzc192aW9sYXRpb24o
dmNwdSwgKmd2YSwgc2l6ZSwgMCk7CiAJfSBlbHNlIHsKIAkJKmd2YSAmPSAweGZmZmZmZmZmOwog
CQlmYXVsdCA9IChzLnVudXNhYmxlKSB8fApkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC92
bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKaW5kZXggYjY2MzQ2MzdmMWNhLi4wYTQ5ZGM5
MmViNDkgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMKKysrIGIvYXJjaC94ODYv
a3ZtL3ZteC92bXguYwpAQCAtODYwNCw2ICs4NjA0LDY5IEBAIGd2YV90IHZteF9nZXRfdW50YWdn
ZWRfYWRkcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGd2YV90IGd2YSwgdW5zaWduZWQgaW50IGZs
YWdzCiAJcmV0dXJuIChzaWduX2V4dGVuZDY0KGd2YSwgbGFtX2JpdCkgJiB+QklUX1VMTCg2Mykp
IHwgKGd2YSAmIEJJVF9VTEwoNjMpKTsKIH0KIAorc3RhdGljIGJvb2wgaXNfdXNlcl9tb2RlKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgaW50IGZsYWdzKQoreworCXJldHVybiAhKGZs
YWdzICYgWDg2RU1VTF9GX0lNUExJQ0lUKSAmJiB2bXhfZ2V0X2NwbCh2Y3B1KSA9PSAzOworfQor
CitzdGF0aWMgYm9vbCBpc19zdXBlcnZpc29yX2FkZHJlc3MoZ3ZhX3QgZ3ZhKQoreworCXJldHVy
biBndmEgJiBCSVRfVUxMKDYzKTsKK30KKworLyoKKyAqIFRoZSBlbnRpcmUgYWNjZXNzIG11c3Qg
YmUgaW4gdGhlIGFwcHJvcHJpYXRlIGFkZHJlc3Mgc3BhY2UuICBOb3RlLCBpZiBMQU0gaXMKKyAq
IHN1cHBvcnRlZCwgQGd2YSBoYXMgYWxyZWFkeSBiZWVuIHVudGFnZ2VkLCBzbyBiYXJyaW5nIGEg
bWFzc2l2ZSBhcmNoaXRlY3R1cmUKKyAqIGNoYW5nZSB0byBleHBhbmQgdGhlIGNhbm9uaWNhbCBh
ZGRyZXNzIHJhbmdlLCBpdCdzIGltcG9zc2libGUgZm9yIGEgdXNlcgorICogYWNjZXNzIHRvIHN0
cmFkZGxlIHVzZXIgYW5kIHN1cGVydmlzb3IgYWRkcmVzcyBzcGFjZXMuCisgKi8KK3N0YXRpYyBi
b29sIGlzX3VzZXJfYWRkcmVzcyhndmFfdCBndmEsIHVuc2lnbmVkIGludCBzaXplKQoreworCXJl
dHVybiAhaXNfc3VwZXJ2aXNvcl9hZGRyZXNzKGd2YSkgfHwgKHNpemUgJiYgIWlzX3N1cGVydmlz
b3JfYWRkcmVzcyhndmEgKyBzaXplIC0gMSkpOworfQorCisvKgorICogTEFTUyBlbmZvcmNlbWVu
dCBmb3Igc3VwZXJ2aXNvci1tb2RlIGRhdGEgYWNjZXNzZXMgZGVwZW5kcyBvbiBiZWluZyBlbmFi
bGVkLAorICogYW5kIGxpa2UgU01BUCBpZ25vcmVzIGV4cGxpY2l0IGFjY2Vzc2VzIGlmIFJGTEFH
Uy5BQz0xLgorICovCitzdGF0aWMgYm9vbCBpc19sYXNzX2VuZm9yY2VkKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgdW5zaWduZWQgaW50IGZsYWdzKQoreworCWlmIChmbGFncyAmIFg4NkVNVUxfRl9G
RVRDSCkKKwkJcmV0dXJuIHRydWU7CisKKwlpZiAoIWt2bV9pc19jcjRfYml0X3NldCh2Y3B1LCBY
ODZfQ1I0X1NNQVApKQorCQlyZXR1cm4gZmFsc2U7CisKKwlpZiAoIShmbGFncyAmIFg4NkVNVUxf
Rl9JTVBMSUNJVCkgJiYgKGt2bV9nZXRfcmZsYWdzKHZjcHUpICYgWDg2X0VGTEFHU19BQykpCisJ
CXJldHVybiBmYWxzZTsKKworCXJldHVybiB0cnVlOworfQorCitib29sIHZteF9pc19sYXNzX3Zp
b2xhdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGd2YV90IGd2YSwKKwkJCSAgIHVuc2lnbmVk
IGludCBzaXplLCB1bnNpZ25lZCBpbnQgZmxhZ3MpCit7CisJaWYgKCFrdm1faXNfY3I0X2JpdF9z
ZXQodmNwdSwgWDg2X0NSNF9MQVNTKSB8fCAhaXNfbG9uZ19tb2RlKHZjcHUpKQorCQlyZXR1cm4g
ZmFsc2U7CisKKwkvKgorCSAqIElOVkxQRyBpc24ndCBzdWJqZWN0IHRvIExBU1MsIGUuZy4gdG8g
YWxsb3cgaW52YWxpZGF0aW5nIHVzZXJzcGFjZQorCSAqIGFkZHJlc3NlcyB3aXRob3V0IHRvZ2ds
aW5nIFJGTEFHUy5BQy4gIEJyYW5jaCB0YXJnZXRzIGFyZW4ndCBzdWJqZWN0CisJICogdG8gTEFT
UyBpbiBvcmRlciB0byBzaW1wbGlmeSBmYXIgY29udHJvbCB0cmFuc2ZlcnMgKHRoZSBzdWJzZXF1
ZW50CisJICogZmV0Y2ggd2lsbCBlbmZvcmNlIExBU1MgYXMgYXBwcm9wcmlhdGUpLgorCSAqLwor
CWlmIChmbGFncyAmIChYODZFTVVMX0ZfQlJBTkNIIHwgWDg2RU1VTF9GX0lOVkxQRykpCisJCXJl
dHVybiBmYWxzZTsKKworCWlmIChpc191c2VyX21vZGUodmNwdSwgZmxhZ3MpKSB7CisJCXJldHVy
biBpc19zdXBlcnZpc29yX2FkZHJlc3MoZ3ZhKTsKKwl9IGVsc2UgeworCQlpZiAoIWlzX2xhc3Nf
ZW5mb3JjZWQodmNwdSwgZmxhZ3MpKQorCQkJcmV0dXJuIGZhbHNlOworCQlyZXR1cm4gaXNfdXNl
cl9hZGRyZXNzKGd2YSwgc2l6ZSk7CisJfQorfQorCiBzdGF0aWMgdW5zaWduZWQgaW50IHZteF9o
YW5kbGVfaW50ZWxfcHRfaW50cih2b2lkKQogewogCXN0cnVjdCBrdm1fdmNwdSAqdmNwdSA9IGt2
bV9nZXRfcnVubmluZ192Y3B1KCk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5o
IGIvYXJjaC94ODYva3ZtL3ZteC92bXguaAppbmRleCBkYzg1MTdmMTViYzQuLjQzZGY3MjVhNzdm
MCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguaAorKysgYi9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5oCkBAIC0zOTcsNiArMzk3LDkgQEAgdTY0IHZteF9nZXRfbDJfdHNjX211bHRpcGxp
ZXIoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIAogZ3ZhX3Qgdm14X2dldF91bnRhZ2dlZF9hZGRy
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ3ZhX3QgZ3ZhLCB1bnNpZ25lZCBpbnQgZmxhZ3MpOwog
Citib29sIHZteF9pc19sYXNzX3Zpb2xhdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGd2YV90
IGd2YSwKKwkJCSAgIHVuc2lnbmVkIGludCBzaXplLCB1bnNpZ25lZCBpbnQgZmxhZ3MpOworCiB2
b2lkIHZteF91cGRhdGVfY3B1X2RpcnR5X2xvZ2dpbmcoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsK
IAogdTY0IHZteF9nZXRfc3VwcG9ydGVkX2RlYnVnY3RsKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
Ym9vbCBob3N0X2luaXRpYXRlZCk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9h
cmNoL3g4Ni9rdm0veDg2LmMKaW5kZXggNzY2MmY2OTAxYTk1Li5jZDIxZGRhMjdjMDMgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2t2bS94ODYuYworKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMKQEAgLTEw
NzU4LDcgKzEwNzU4LDcgQEAgaW50IGt2bV9oYW5kbGVfaW52cGNpZChzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsIHVuc2lnbmVkIGxvbmcgdHlwZSwgZ3ZhX3QgZ3ZhKQogCXN3aXRjaCAodHlwZSkgewog
CWNhc2UgSU5WUENJRF9UWVBFX0lORElWX0FERFI6CiAJCS8qCi0JCSAqIExBTSBkb2Vzbid0IGFw
cGx5IHRvIGFkZHJlc3NlcyB0aGF0IGFyZSBpbnB1dHMgdG8gVExCCisJCSAqIExBTSBhbmQgTEFT
UyBkb24ndCBhcHBseSB0byBhZGRyZXNzZXMgdGhhdCBhcmUgaW5wdXRzIHRvIFRMQgogCQkgKiBp
bnZhbGlkYXRpb24uCiAJCSAqLwogCQlpZiAoKCFwY2lkX2VuYWJsZWQgJiYgKG9wZXJhbmQucGNp
ZCAhPSAwKSkgfHwK

--------------YbDS0kCkoMt40GBAU4DJsL1y--
