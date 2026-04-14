Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8738B7A5;
	Tue, 14 Apr 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175174; cv=fail; b=sHRzIfaYS7aaT65pr+V/hIPs9zbIeBaydnRigcvkhuCd+sSLFoRe0Fj91beIsyy1njoKkL/K9YSLEvfthrEaAmf4N6PnkGihrWd32J6IFyI3xH4HY2nG3G8AYOiiLl1KEaxHX/U+oGKfOsY5MVPjDTjhpb8vIbQdl1lHcbarlrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175174; c=relaxed/simple;
	bh=Iv1/gtgkVgG4yxv2Clb6FuzkHcnZP/w5Foengv00Znc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/nJswrCOPPGUkM09bn42Sp/6UEv0Pkj6lI8JU2LBiHkbWLpDwS1hJDrgsI1KCHv7SabAIZe/vytJHHCl9AwaQZqpNtZ3umLCVat7iTctvFityTZKrfLHvXKTih3Zb5tA7vNAkZzOsDmaT2LemPjxTObvl2/xl7Q0j6q0jsO23g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOIsZ0VK; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOIsZ0VK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776175173; x=1807711173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Iv1/gtgkVgG4yxv2Clb6FuzkHcnZP/w5Foengv00Znc=;
  b=gOIsZ0VKS3miVB3K0VmQXJZcso0AgT2O9N6sMOsADzwqVfRfLMNeCK87
   uaNGw1L7s2VR9BvHMnLZhwciBb8+CYaUTyRYViSlhkUTcZq3l7FH6Z7z9
   ASwrtMw5jRUZuTt2iov3lcZhUsU7R09GO2QCMm0tP0+GkSZfn5QNnl4SV
   msr67rLX/NFrBOiM80cDXo2b1jMrdQ0fHxg3rtuqeZyypGBn0cXLioQDL
   HkQyZgFxVCKT8vuJzDGp4h1XYhB1I90auRB+akNrSyzedzK61Jpxiajmh
   efUqjDkX3d1+ue4HduDScHE91Vis44c4Oysvnz17C4mI66/FptqTMGdJC
   A==;
X-CSE-ConnectionGUID: +4+a6UULRSi1CmfSLbDt3w==
X-CSE-MsgGUID: KfngxIgCSayZuO9DJZFjhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94530649"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94530649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:59:33 -0700
X-CSE-ConnectionGUID: jFF992ORTau3AGBBha8SUQ==
X-CSE-MsgGUID: 6b1kUk34Q0CP7dWzyJcfYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235060490"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:59:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 06:59:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 06:59:32 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 06:59:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7VslNiaxoUIeme1CFtdz7R2KmmWDIDC9U/7GT0wJzUdjvwL7iggkKCSieQpWJZX0TZudLLrg+ZrJvTMvOrrHmVh4cOGeTTfbpMla2T1DGEtOXLLT3jfo8e76h150mAy7UUxsKmSWwTPQ3ascYtf6QI3DRBrrWFT4JbRb8b3hMuHOPsI4hRdtfoOp4YjaD+EozkKwLISQexaNd5bRduIA8XoHlMx0sx1XS7jr2NJvHmCKxD6YlV1llRcF1c9Qx7xTNsfvwSoDlELBp18gyz0+424b1mSIfQ/g47nxMktPh2wBXnGPnzeeWxYGr25PZhH3pKnGBzhAj80jlzZ3JpDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MGWcUTF8QZo5RSOdI5v+Cu3aWiWbjHaj1oAypXHpw0=;
 b=nK5KDXOC23nw4csKHEYOC6PvbIeOCqQ8Qoei9cSOqX2+WwX8uRz18DryWDXercZOBOJPt2kifC0RkWVGkIYtaZCAXj+Lbx+GL5oT6iEnUqpXmOhfoRBPE8FkjQIxeIuxFiywPeEcyxJMVYp58krRIE4Y+f0rIM8hF8KBtMpbRUZs64nUHsY6hgX6Vw51TfC+XWbnDpZnIjjho2dfIGjocIc3Ou+WP1ueCGdqGQ3PxFQnvzR/AdqsCvc2Posgj6DMqIUoY5k1UwG3+hF37gUZxkVq3sUBj5vzURaYYdMcrP0DAkQ5XjfeuC4N2jP9l+GOhU3PgfzvCnF3u/t903n74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 13:59:27 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 13:59:27 +0000
Message-ID: <87e767b6-0324-44e6-92cb-f933002dec43@intel.com>
Date: Tue, 14 Apr 2026 06:59:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: x86: Add dedicated storage for guest RIP
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau
	<kas@kernel.org>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260409224236.2021562-1-seanjc@google.com>
 <20260409224236.2021562-2-seanjc@google.com>
 <20b82b65-b156-4a2c-8094-b86dccfb3025@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20b82b65-b156-4a2c-8094-b86dccfb3025@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7735bc-a608-45e4-a1a5-08de9a2e0a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PkiGLbDcSSS/80e1fu9sKfGlV3yYVE2I7Y7MX74rabZLyta2uegu1n1jQ+oYs74zHPS4HvQ7qgmCC7aFWrm1YFeZCW2kY/S6WKMJWvpZwTQhl7rzRU/LY82cbC6SwkFNxNY4bFKyXLxxPDk7TjFF+m6xWQxvu3jSdoPNggtWzyjwlqmfJ55hPICloZUfKk3WNb8TQto3TiEuKeC3YMMy8/xKghOmYwZD4IyM4i0Z+A5LM+A08k2eIZzfMJ6J5gLUeKFtoiqznoa13+xm9T/4sT5KFlPQ3+k/nd4qXNHYMGKRRol5++a1CUxObG+GScjNi23q6K1zk/NM+ZAHODp3fi5493/xCKp5OeKkGcx2GPMBdt30HyZB/VyLt00TbsOET2AgvYJ4eE80hoRkD1yo1K0q3IKxBN7BG/76Rl/CpsfEYUJCA8h1FjxgKDp/hkktCv6LXZIJgBKY1B9HlAI/G/7ptvkH2dLAibat/IlcAbvLmODXcf22NOCtMxw1ZreMwUKK69Kc9MPk49mebgzFel9WhW9fD1v0LalkbpA60Y31QyU3R3wdlIU7Z0vH64l6DGy31hM5g73tI3kpTLeSonZq9/pRJxoRe0lUKyu/WHPRKgYK7gScOp85o58Ug3PrtOkDJslaXuLnrmQ0AT2+sJBxXyw9x52HJmr7BgH9D+6we7i0glEXYuThuMZpMcMBFMOlKdg3XCzNsr/NvtE92DyUHZTkYcS2QkZmbhIpGwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJ1dnU4bUxmQ3QzWXFIZS9HMXdTNTcyR0hlZUpSRVNSMEJIL1E2QjI0Q3Zt?=
 =?utf-8?B?WXdteExKZWNNQ1Z5ejVtc3hzYVpBYkpJaGI0bmRMNDRWS3dRdXZSYjU0R01E?=
 =?utf-8?B?NWNCdjVyM1h2THV4cDNLTFprTU5ldnZPRTRUaENtNXFSSHAxSFpIVFdGWmhD?=
 =?utf-8?B?WDRxc1BRUE1mTGRuZW5MYkxlbXNzRXNETWdFQXdRUFFGRldEck1xaUpTbHpi?=
 =?utf-8?B?OWUwQlhBMy95bU5SdGdNTnVnWC9TU0U2NVhSNFVWbjVPTHh1MUoraHpsN1Ny?=
 =?utf-8?B?cmIyRDAvTFRBK0QvWFBoYWgwZ1ZTL0JOcGluZkhTSklkeDR6c3cyVGZPR3RY?=
 =?utf-8?B?Y0FDVSt1ejd4aW1BaFVpUVluMHd0dnpnT0FHenowRHNISFVLdzBnT21WSVJN?=
 =?utf-8?B?YThSVUY4UUx2cW5WMW1LcGdKVTF3WHFkWmVicjN4MUkrejVPTmMrck4zZnJt?=
 =?utf-8?B?c291QlErL0oxTTF6aVJSSGlmRGRWV0ZsUWhpclF0RW1ScXQ4QmFMZ0JoYUJF?=
 =?utf-8?B?OFpoT1dENXp0T3lNYXVTQ2xjU0xPU01QWWRha1cyMzZYUkI2L1FKT1JHZXRy?=
 =?utf-8?B?bUpDMmEzb1B4V2xpak1jUFI3eTNCdVUzM0pyRHI0VDRJY3FOS1ZlTE04a0V2?=
 =?utf-8?B?QVhNQVZ2dmdWNzhpSHhMbjNLbVBRcFpxeVpQTG5MaUdVckk2V0crM3VyQnla?=
 =?utf-8?B?VENTYVVPbXpURHNOT1h3eFNyTXpzeVBUS2ptdWZBZ3lKRzNNditsVE9FVmNq?=
 =?utf-8?B?d29XMWEvVmNLeFdPd09rdGx3d3lkNEFQZTBkVFpibVJZYURweG1jTDZCNTBs?=
 =?utf-8?B?eU5iU0RSNGZBMUxTUmM4eDBMSVp1MU0vb0txU3Z3N3RSSm1VNU9qdzlISFU3?=
 =?utf-8?B?SXQ3RmY4ZGtzNmFLZmV5WWxkazdXemZlRHRVelpxOWhLbDV4K0VjVzgySko1?=
 =?utf-8?B?aEliRVk5VUpxTmtDSjIyaWtGNWt1NzV5YkJmMG5LeHZPMGxsUWRBb0VCc2NT?=
 =?utf-8?B?MVJzT2cyMnRoaUYxWWtnTG0wcE5uOEdhZzFra0lSNWhHOUM5b2RrdEZCK0Vo?=
 =?utf-8?B?cjJwUUI4VVIxVDQvdmtEV3YraVAxeS9HOG9qSkJBcHJwandQWmxGNlAydkRi?=
 =?utf-8?B?Q29pQjdwWmllU0RWc1ZaSS9OOGNEcWdWYSsxSDRzRjY1RFpqQ3kySWo0NVBV?=
 =?utf-8?B?R0kzTWwzOHYrTTBUWmhTYXg3QU96OXljdUJnTkhBbjhERFA2TVVBL05VS3Qz?=
 =?utf-8?B?ZTRGR0I4RGw3ZEg4OFBmNm5zeHlycWdrcTc5Q2pwemxNZTVzYUVMSUh2SjND?=
 =?utf-8?B?UmRhN0JmeFBwTjlWSk5zRzlHWnBGSERWdzNMWWd2Mmp0ZXZlRlRZWjA0VEto?=
 =?utf-8?B?YkZGbEZNUS9INVFkanFid01ydmhrTTRZeTgzc3hWVkl0U3g5OHBoM2NGbmpr?=
 =?utf-8?B?ZmVncThCbWhtS1d1SDFScXB2c1JyN2xUbU13RU1iQk9SbVBkL1BldHZ5OEJh?=
 =?utf-8?B?K0VpQ2F1WTU0bS9HUTJBazVvQXRsVkY0WE05Q3hERmJZZUgvS1g5bzlXcTdP?=
 =?utf-8?B?QTVESzdRbnpsUzRpYUQ5RjRDMklhampQbWxrVWU3UVdXR0xKTlZDaCsydUpa?=
 =?utf-8?B?WHZOZTZkeW9GOTY1bGFScVRlRzIvL05CbGtEc09sTGJHa2Jna2UzNFBMQzBJ?=
 =?utf-8?B?MlF5d3F2bGJDRGJYTlhBRVlPNmlNMFo1VERzWVl3Q21uRVVReFF6MEtzVUVO?=
 =?utf-8?B?cmJYc2dGeTRIWmtBWnMrdi84ZlZKcEV5WXVDUk5EdUk0eWtFdmxodWRldWVp?=
 =?utf-8?B?TkdkaXRiVGNMelhCNUVQQ21VVFpUalJka1NXUmE3M2F0VXpSSU9hOUVxZXFm?=
 =?utf-8?B?M0kvaUdHdEtiY1dQUno3Qk44bTE4RS9hZURNUkN3R0cveHYxZFNtdC94QUNH?=
 =?utf-8?B?MDJTQk5RUUJ3WGRWZDE2MGdaaUpucEtleXdSeERKZWJBajBKNThkZ1FEM1ph?=
 =?utf-8?B?VFVXVVBRWVZlTGFKYmVyeWU4ck8yMnpZaUhsd2F4N2VvZmZvUnBiclRGd01i?=
 =?utf-8?B?RlJnUUR0Vm1wM1lRaGltLzlJaDZTWWFwdEdOOUpWQmhqTEtBb3E5K1Jic2Rn?=
 =?utf-8?B?RTRGZWlBNTBIQUlCYm84NDk2RWVPdDJOVFBLTUd4eE5WdmVidzloNnJLRHh2?=
 =?utf-8?B?V3RKS3BGVjJOZ2ppclFNRlp1VlF5SEN6N0hRV2NZSWlXekZVMXFzbGRIVW9R?=
 =?utf-8?B?VzBJdU1ENkF0S1FTbGFrVWgwSys4WnVXMHg1YlYyUllpbDA1WmlNV3NOeU5l?=
 =?utf-8?B?TmhZdlpucjFTRERjZzJnOUVBWWtpYk90NGk4VDVFZzQwWVRSVEpsdz09?=
X-Exchange-RoutingPolicyChecked: HMED5c1nuR/ycKPrPQTgMYFDOjcDE9inI36BSNGZwai9+SQJ8os6E6ZoGNxzAwdluQz6kiic/4/rLm1oSePsnRNOH9pxyL9GBrq345UDWaBFTrQcqbmRYyl1keJYuQqzLnZDxprVigdgbhHeLFzD9TQwlhuT5JPbDXItqVsKCsq+AObZ90tHTmMJnAJXwmezm/grtrx4psr4Dol79gFeLRJLNMNO46GOHzwWqxX9phBr0AmqRfOeiDxHML3D/zeCzYmfCbz0dnRXqir97qMJXvIiMMEFn2JEezMuUfhJKAYnR/ditmGgMhebUxwk7Tw9bcvK78SXQ6cnBvNaRnM46g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7735bc-a608-45e4-a1a5-08de9a2e0a5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:59:26.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voUuK1cIIZPrikiB2Uiq5cno/q7LOcTP1xSyIkb0MVIgooag8mNjDQlVlu849jmcSyafq06MZOkVIV4EE5fwtKm+54hPqchWitd/rAGtqYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com

On 4/14/2026 5:31 AM, Xiaoyao Li wrote:
> Even leave RIP in regs[], what is the problem by just allocating the 
> index 16-31 to R16-R31 and making RIP the index 32?

But why?

Even though the array isn't explicitly labeled as GPRs, that's 
effectively how it's being used, and RIP isn't part of that set.

I don't think there is any benefit of leaving it in regs[]. Instead, It 
can be stored like that simple, period.

Thanks,
Chang
