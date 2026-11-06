Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793944646;
	b=pTGzvXdnSRQ7WX975iD+G74sW7eWzWmnyzw/syFqG6kxsigA2WNHLjeo0P0CprFOCtFT
	 oJ8jd7nE+NpMEoItbKNRVt/qgw2s1KOUe21wE25NWhp4x7PdEGQ3jixcObhEU7aKBIW8k
	 FTxG8HGWjO088IwKeH2E1iqPY6MndXoINQWcRMYlW7Ti/tzOtXLH2W1fMf/PokeAPiv+O
	 KAT2AlIF/LMHu4Kf7Jtala2d6f13MXzDcKRg1sP+1q159B+fQNjVZffEndAvxFPMp/2WP
	 G2G+gtKvwYw6t6Bre/2uHkxUTE1Wn8iDNCA4ETpsYCc47A+YU4iJiKDJsu4Zy4L7vqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944646;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=okEJHyBklvhwLv1I/MFYxDmBSn0YvfX3XOLhJlkgOtU=;
	b=JmYViNgfKYh0bp4/aXoWa2YIHFIa4yOiu+PCLpNqhXsfAQeu7Xe2T2aGOTq/GsSi3hi9
	 OkiDNXOV1yCayyK/syiar01jva+g8bdzUIe+IvMOqr4fzcq3B1kw1R+ePWOXT5k/sE2D7
	 q5t4b2OHL50jBalreXNIvNS5VKShWX+vkqJV/Up/rgwjRJST5/kXmYfsFpoVbp9fpdD1g
	 eO8315NB7kI3N55il8PdFoc1S9vlid7Rs4TpZYV3oih6u3AzlsrElN+NxX3ZdMzRj/yLZ
	 /AtUbUc44MluIlCdJc3M+fg+rtBO/UCLKTkB0xyIXMHcOjwawXs5c9SN9VFN2l266+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WP9dkWhf;
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0644606A336;
	Fri,  6 Nov 2026 05:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0644606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WP9dkWhf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793944645; x=1825480645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LSjH7zqIrYz1sKeeLH2JoyhrtJ7sCMsL7NdsLNJxq2o=;
  b=WP9dkWhff4bo3RMeVXQNi1v44LiFqstKFxn7Cscv+QftyKVnPPzC0sh9
   iFS+f+FIqfKr8u4bplDTMyAsUns+sB+6kZw7yJK5eA8yhLx9eTN+7lvBS
   n01mLpjjqCItvJh413GDDbn8YAwep1QeT5CgfwfGl/DVrkkxnXXosqQNO
   b2vFUlHLrQLd6rxsXQfBeqqzSmzixeLjkI9wMG7NGHHIWy7PizVTyOdnr
   eRN6mM2Z99FTvx9EpUdzdRhJd8VSzCWYhpGPEVxNQoRvuLwSKLvtt0ROt
   IDfa7eKZECU/mqq9uwJFGxOivS4Ekdd3ttTkMbtGLKzIpJPIaG49FWJYd
   g==;
X-CSE-ConnectionGUID: Z1pMhdmMQLKWnp8pSPHZfw==
X-CSE-MsgGUID: UpzltiuWR/CdiExH39yhRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2630455"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2630455"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 21:57:21 -0800
X-CSE-ConnectionGUID: Utj/g7EATQWg7vd0ZUJ/rw==
X-CSE-MsgGUID: yzIWdbIGRG6cf3KiXyQFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7323212"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 21:57:18 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:57:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 21:57:18 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:57:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2O2z1c0W9wVM6+3LKi/saZnX7DVWAKWpRyWB4xSHGISDUFIuHWayvUqm32pdeO6gaviwfxcYrdhN5/DdYL2Ofyf5DR2lGG+uocseNsxtzt9Ty2MA5bPT7ggee6uCKZLWOSIeCeLjazY5/dJlu+fqzKYV8TQTrAPWQZMybMr7EQQVcGSe20rlhOV/wr+po4+RzH+yA1tgGpvG/7FNK8Rq6S7mzW5I2Qwi71n4DJbQMLmU+Xb1NSFnfO7F6WBbrA/lNfagefKXi0U8+5diRhCabSNejxbmJvkOPm9BUwn7jeoIWaT9L+OS975sNKDbUMlEXwFyndooWlvkOmAXThlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okEJHyBklvhwLv1I/MFYxDmBSn0YvfX3XOLhJlkgOtU=;
 b=vOcOnnGtKiG8dhdcNnsN9EJSqp6W7/mFkdyzHdc82Mvmsv7bj9luO6z0G7vNbpdWOLd+xgdjYT+S+wuGEn3kvMBnSVDblrhaxqASM4ZFrJmKsvBY/SZue/TqewPOxXMxiiwuBErrc1X2ZlXbyawxYCFvydJThYSxisLC9xDH/jOmPyqyOjUkwqJBueATPzIocHKxzXOT6IE+UedBatw8zo+ThYSz1Ow0zDLxxnOKxmkueP7TY6pTHTW7xzNPNL9JaCUctOfoigbGA83zt3PYmzVk4jR7AbLtIr2m67YCMinAI4YvRbXD7EZJuGlXcIXbCrteT2iEAM3Zr4L7bzOoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:57:09 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 05:57:09 +0000
Message-ID: <4b8e0f1b-266c-490c-8a95-008d936d0d6a@intel.com>
Date: Thu, 5 Nov 2026 21:57:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/20] KVM: x86: Support APX state for XSAVE ABI
To: Jim Mattson <jmattson@google.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <zhao1.liu@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-4-chang.seok.bae@intel.com>
 <CALMp9eT1Wza=7s53Pu7ODcBRkYSbpv4A_y58xJNEhQeaJ6r1Rg@mail.gmail.com>
 <24be20bc-4089-4cf9-899b-8da1b2ee2825@intel.com>
 <CALMp9eQOkFJrzN_ws-CKLj5BaDhXgLbHGDF9g6t8_gNTQvsU2A@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CALMp9eQOkFJrzN_ws-CKLj5BaDhXgLbHGDF9g6t8_gNTQvsU2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d8c540-817a-4a95-25f4-08df3bcacb52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|4143699003|11063799006|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: c3G0h0kpNGPawZ6LNThANLimO/0KvEE7mTKaBCCT9k/tR1zDJFw5YOZKM1YUgdYGNsaISpRquN2CQ7FMeOYxB9kTzOSdkl2WXgrh6XMk4JeVO+ETQ4Y1XXno9wCjCfUtZVF1+u18G/wJfrJmaj/HYoLQi5PXN9PST8fPCPoJ5wotMzQE4L2bYMNwClQ9EOu/bWOP6zeG2qXExitY6rOgtZLQMTbpSRMbDg+eF0bHqgzwBvcyOjiEm8SMJ26cK6P3gocU6g69UvXc/VXBaHEBduHDADqFDvm60OEI/zV/SBh76moahg/PKOBzTUxJj8wDPKpPho95iCvIK9mY0bG6Y06LVQ5YMrR+rLjfdcJ0NDuy95/0ZcLBS8Rvfo2jnwrzB2BjchQi0MoFGsghPjQ/XtNI72NkX6s2FgkgRaougE9QXmrXIqJtiW2ieNXRXL4HqowzokRQyRYXYllpBHMMbzklQKVTMiJEKwTtWC3xkdEkBan4R72b1K6h0i/AoItKdhKCI2QU5S3TiZCgMumHqxjz0FU1AKKFCHYTUmUKk7VyWXXMQAYi3DHs0+ZHrD3ZnmEz2YCzL9x5eUcO3c8yqAKJQyZkp+wUwCF2+pYXciHiAxHumDnyHcQ8OLvITShXSiS/txRlTmxGm6IDyQUChNmRStyJiX61Gh+gyAHC/LE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(4143699003)(11063799006)(56012099006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFvdnJHWEo2eDRRbTYzZjM4aWFUbkdhV0Q1eVBZQkoyUytPL1BJNTZJZUli?=
 =?utf-8?B?RGhQRGEvNUd1b1lqTXR1cDI3M2dzSHRxdXN2L2E1WTV4bnJGa1labjltVDNn?=
 =?utf-8?B?ZmY0ZTVkTkROOG9NUHk3LzZ2bWNSQUg3QjdFaEt3MENWWnMvd1ZoOU9RRFBw?=
 =?utf-8?B?T25WZmlWU2dwRDVRVm9Pa2tSMmgyenVTUXlYaWZtM1U1Sk96ZG15SlBBQmgv?=
 =?utf-8?B?N0QrRVQ5blpzUldFWXBoc1o2WkZhRHZDdWkxa1l3eUFNR0xkcHpsV0JYZkJo?=
 =?utf-8?B?T2VKQ2ZPVjlqMlBIWDRhK3U1T0xHWDl5cy9jQVZRYWlyTjdNRkQ2c1ZuQXVj?=
 =?utf-8?B?WTdjMXFCRkpLSEIySjNTV2pqZTdpbCtRUGZib0d6cG02RWJLZE9JR2lDbTRB?=
 =?utf-8?B?LzFVSlV0QXAwcXVUdGMwRm4wRytqbVE4OTgvclZMakMyOXk1L25xdTFjOUdl?=
 =?utf-8?B?VW41WnZ6cjlmRnFQZjI2YnByUWM2QTM5ODg2eGwwcmkzZ0V0dmNoZ2hkNGQy?=
 =?utf-8?B?WTkxU3ZucnI5cExqL1I1Mk1peXNNTTczay9CTWxDUURlOTVFVC8yUWVJRlZJ?=
 =?utf-8?B?bkVQS2RhNm51Z3BkSGJKbGh3N3lrTFRxbFdKY1lHaFhGWXFiZTdSa01uMjhp?=
 =?utf-8?B?RUN0RS9EZzd6ZjExL1RKaFVQUlZNNWQ3TVZSRUVZbWV6Y3p4dDJ5T3ZmamJO?=
 =?utf-8?B?TVZjVjNKOUp3eWtXWUR6aXQ4MFFBanNybDRacHhpWGtuRWFQUHlCTGwzOTBV?=
 =?utf-8?B?N21oVEpGc1ZySFN2TFcrY3paMXdYN0hiZ1k1cXFnM2V0dUZ5WkZ4L2s5ZTBT?=
 =?utf-8?B?RHpiRE5RQnNURVoyYmtLYXpOTTRSUVNaaUNYUWFEc0VJZCtVZ0dkMHM5dmd0?=
 =?utf-8?B?eVQ2cmFqNjV6Q0c4SklyR2YzTitKQ3g4UkVwWi9ueVlIRjRHdGdIUUVlcEwr?=
 =?utf-8?B?MUVTdUxRTmFpR3ZVbmNpNkNQRENuZEprcDlBenpGTUFzcmYya1dSYk9iemdq?=
 =?utf-8?B?SFRsQ2ZXZ0xqbnc5a2RjRWdYa1lRWTUxcFE3czkyYStsdjR6NUROR3l3UjBy?=
 =?utf-8?B?UzRvSHR1dlJ5cWs1Slpsb0VEcmRnQzVhVGdmQUVXUThIbzMvSGV0SDlFS2tR?=
 =?utf-8?B?WkQ1Zkx6dEZNbmR4cVRmcFl5amxkQkJaRUM1eHY0OE9zbUJWUDh0cTlIaUcr?=
 =?utf-8?B?YUpPMXVmSlZOUStGYmJaSUJRcHNEZ1JQZjEzQVAxeWdwczRGbit0Q3FjOUdm?=
 =?utf-8?B?N0lUNnBrTEVqN1REUHo4TEU2OVk4TUZJZjR3Y2tHTjNjYThxS2FFb1RHcDdE?=
 =?utf-8?B?WENaRWxUUk5seFE1bktZaXdhNnBMZ1dGTTBXaHR6VE82R3U3cFFSMGJQaGhY?=
 =?utf-8?B?czFzUVN5ZmFrcHhISU5vcDVPMW00K1lvZEtFYzA2UTVLMlNDOTJsdFl4eDhq?=
 =?utf-8?B?L3RvaHZjSTEwQmRyRFUzb0ZSNzg5b1NTRXVSQ2tkVkNtMWFEOVlwR3B1WHVT?=
 =?utf-8?B?RXZCUTNVM1Y5eUR0TkdlUENoWVFLb2lmUzlibUl2cVVEYTRRY0cvTDZmL2xl?=
 =?utf-8?B?cmd2MXNlWG9FT09oSk9iVXFTRkRTbnlZZzdtOUVrUjBYbVVVMGhGN2VDcFY2?=
 =?utf-8?B?bFN1WlFvRjUzM2JTVHg5MUJBZi9DVmdjL05BT2hScTRQVFR5dlhMWmR2cnFn?=
 =?utf-8?B?cUVOL3kwSEsweXArclVVL1VtaFppc1g0aW5oRDVkUVQyZis3Vk5Md0YwZXlT?=
 =?utf-8?B?RkxhcTRZTkkzVDNNazlUOUdLaWFMNXQ1cnNKVmJkenJETHBMa1dKMnBJN1p1?=
 =?utf-8?B?R2JraGVKNkhLSnkxN0phcHlhaUFILzdxd08zTVdYbmxaaEV1R3NlNnNTR3Vl?=
 =?utf-8?B?L0JWTjlUS3ZmY25ieWVLeEg3WnVWS3NBdU0ycGozTEpVWGVVRU9HWnRDN1RN?=
 =?utf-8?B?dkRlemhrU1JNekJQMUNETis1RVJEdmFnekdqYWt5NU5BcE1IRm8yVmo5TkJM?=
 =?utf-8?B?MkxNQnlQRkFVeUd4Y29neDhjc1VSanZLcHR2M2ZvODVTSFAyU2hhdXZnaXRs?=
 =?utf-8?B?NEF6TEd3ejhFNUpjSTV1VlAreGpkbEYwNndKRWR6NlBRb3VYRG9XQmp1UFI3?=
 =?utf-8?B?ejVMYlVXT3lQZkJXczlDektqQS9TQ0tnczMrT0d2T3lqTFh3OG12VUxQbVl5?=
 =?utf-8?B?TitEbUVrcHJjL25vbUZaVFVVbVZJcDZuVGFtaUNzVDZEUWhjM0szZmZxeGlU?=
 =?utf-8?B?elRHbTY3S2ttUG5uMGwvQjd3dDhrcnlpRnJ5UTdPOFQ0K3dBWkhjbmQ5QzNz?=
 =?utf-8?B?U1l5THRMRXZ4RWswTTUzTXRSV0MreXk2RFdLRzAzN1U4bm5QbWlFQT09?=
X-Exchange-RoutingPolicyChecked: gBueP7VfiNrR0sjqk0Tl0AuOT9XJ965l+zoMEJ8x1gjunpUBEV1ISTg7nQjWax4LS2qayHiJOtioeLLF+6RF2hEqg4aA04i5BVripzBD9kGWblOWic9Pe1HxZ9SObDpRk7iI22UYrdc8w1nJsG8j5AmHs+hSZRs5iBliNxHBi9SXPKu5FgpqIk2b66sYaW4Cx+OMXk8UpsmTvRho8JpRa+6mzK26WSocZ5QGMncaDtE8x64nqYdsOvwR+lsewNyswG1NgETuj2ruEYn7mkF0PUpymWYp9c54pL1JTY4wY3bkCR1oVAs1Gki3j/p0KpfwS0FZtekfBLfHlyh1a8XfIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d8c540-817a-4a95-25f4-08df3bcacb52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:57:09.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyNC31FQUP5O3SK4K5LCokiYenATpqWDJhWg5Lvso97Zn56cYp+/LXRVb9MI8kd0okE70ASelWrCS2BW4SuZl8aTh2ExWBM1FcxQnsWkmkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com

On 11/5/2026 9:46 PM, Jim Mattson wrote:
> 
> Look at the lines immediately preceding the ones you quoted in
> copy_uabi_to_xstate():
> 
>      /*
>       * The state that came in from userspace was user-state only.
>       * Mask all the user states out of 'xfeatures':
>       */
>      xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
> 
>      /*
>       * Add back in the features that came in from userspace:
>       */
>      xsave->header.xfeatures |= hdr.xfeatures;
> 
> All user-state bits in xsave->header.xfeatures are cleared before
> hdr.xfeatures is ORed in. If userspace clears bit i for any user state
> component in hdr.xfeatures, bit i in xsave->header.xfeatures is cleared,
> and the component is reset to its initial state.

Ah, right. Looks like sticking to what I thought before...
