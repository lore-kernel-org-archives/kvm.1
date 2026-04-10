Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD733E6386;
	Fri, 10 Apr 2026 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775846646; cv=fail; b=tUFpT9JZmMLnnDsrhn06QY7lYBwm27pW6iZDQ3xY7drP5vTrlLZMAXehjApSvMjqOO4djfVNyAfzjr01uLbtw66SsrgD/qIQHBdxAS7AYZLXUUUFDPv3O8jAhCoJR8oN3BHddwzx6Eitdkx3hO8InGXEErogINpaeFlNxVs/dtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775846646; c=relaxed/simple;
	bh=9ticlyfRVh+73Zk+lC1EB3YkGx3H5xgARb3Q0HxC138=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gDhQgqOfpsRDfxHSlKtENmnrtFAS8meRLo+FRt7vZgF+qIPrObv5qNsSO30DLx5Jd6f6lMt3G5+15F5wlhWBansFI8Clv+0ESTFH6p1aFsIRX7GQwkxnsPEiRE42HGGlrR3X4O0si/nUyGZroXq8+p5nwZV2CCdAzir4MiwrW0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1IzZsA8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1IzZsA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775846646; x=1807382646;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9ticlyfRVh+73Zk+lC1EB3YkGx3H5xgARb3Q0HxC138=;
  b=n1IzZsA8+Y7B5eqAVqmaBKd4VjL4XNELSKD/9mqmCP8/Pth9pMtzpivc
   PWe0tK+qRbbmh6LEiMzN6EwrihAregLnSo95trKqetywSSXEeqWYpNbc0
   AmdvKFmJH5RIjocDPkjFsV5JDJ6H2qHHcmrawhU9NHzrv9or+oGb6/Smd
   LBb/87/6n3PgqnYrTMgJtjBEPAh7A5VpJVYp9cUBfc9+08rD1cr4Vm4dG
   lGHYkYe/iKy2BF5dERnRcPLPXLJ4yNbOLKZ3KNloxgLYZHvEsUxEM8VNe
   zTC0BzRjm8OfM2EnpYjZ2QwlPvuHYFIA5uO7pFEj+fPx41RMqBlF0tRsv
   w==;
X-CSE-ConnectionGUID: LDInR3f1RACfmrQHT4OHug==
X-CSE-MsgGUID: O//2rVaPQxO6Xb8n1pi7LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="99514696"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="99514696"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:44:05 -0700
X-CSE-ConnectionGUID: 32eNLehhT6+m4tohCfMb7w==
X-CSE-MsgGUID: sbKfbZqQSwuEE2PVcJu4vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="252535169"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:44:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 11:44:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 11:44:03 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 11:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0JQGXx6NmXCYMOZDAyyATlWojE0GHyhVJZS1MKUQLDmnYZHfA15VhcQi+ClDq+Hph3eeUIjrSuyEbFPV1r8b3632L8kDA7RM38qq6Ny7RM93wKqVuewdVUkgvnnhqqVMI2E2rorhTzxbyTEl8NpSHKDJ6A3CBiwTPBFkkYNCCUcAO7SyU9SXjAG0UFUPOkX7n1LqjyiMi+sjLerqr/5Rngtbo5BtMLI7dDaE9z4c/PBcydogc5d48wA2Fs0mZRqAqhiCErA86cJTAyN5ovRSn//IblgTvk4RMMjH3bbSj7N6aI+vt6JMLg4LOb7K/mgGfpAcCELIsKZfJQaGSS4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I2IGrg84dDS5r2y/3GJK9ud6v++iTV4tyRFEkYMaOQ=;
 b=NGyLpp9By6zMBUmx6NDj7k08MrksMDHoaUDRME1arNefWxVfvY4u6c5aPKBua91MyY+OzD1+480fOr7IQ5DfkRDoscq03UNa9mAj2Js7p6FEzv6qhZkudyMPwzPKRU6/JEVh6QHBuKF0EHZplxMhno2nsnkmBFR3QKRpS7dAGjHUmMEN7lmJdxVQC4FO95A0dFUEE9lu/oRsD7s7eO3HT4pXitnmYQ6kF5307n94DJPxk0n+4OC5TrcLPtD+VSo0dmiK/Qd7GPU2Jj2Uq5ISV46CuLDc4aWkU4otQuFjC+OuBopggDdR0LwQ1ODk5vLzZ8gGWn3Evr6QAGH/5Tkn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA1PR11MB7919.namprd11.prod.outlook.com (2603:10b6:208:3fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 18:44:01 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 18:44:01 +0000
Message-ID: <c0a35da1-c613-4b13-958e-2e09419b4300@intel.com>
Date: Fri, 10 Apr 2026 11:43:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: x86: Add dedicated storage for guest RIP
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260409224236.2021562-1-seanjc@google.com>
 <20260409224236.2021562-2-seanjc@google.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260409224236.2021562-2-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA1PR11MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 626c8ecd-2691-43d7-593e-08de973121fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C07sWRGU5/ohPIiEMjwkAVcB66DXrQy9MfW05C+Cm1b3GyYQ0Lt/zphKz5DlZk2wcospJT4g8mrigUsP3YUamcTAJfY79NqcFCyjkuJcqGTHmhl4WeeuSmxM1u/IIw9IXhD/xEj9J4NXC34ohVl91P6OvzhItdaJa1l5xKGzPKOYwDeEO30vZu2N5qZQ7ujjLJ3xhC7zX8TKIYczCORgKIPGdI48w6jusimecSxGZdCyt5tqiGWUkXuHDGMgxcBxd3VY1sMbQxDVsT+xeL1iV05xbCrAAAY5mVdOTbkDKOoESbKMbIiMLsPg5AE7IbXHggCCNEujo1dKqhl40n7Lgwe4h6IV9Sue9E0Pm3UJfszTWcpAJT2FzMGvTGMmnhAkfDfVvel5zIX0mDWcUsQBWILRQUq5DDc6BAjHPph2nzntNwIkFexMJb7fU+V139eY4YNHYKl+8DsldFVfiQv2A/azlPiB/T68S/vW7kmL9FQZ9AZfWgg1FAIEMGJ06L5AqB+Q5rgukSIDjro+ZYOVFgft+cRXamFvBx7adANMGeW20o/JvTZqRgCaMNn9mYyewrft8JHsmLku+BksYi6z+GajliW2qXkLqeK5vQpj612H4/4hODBWh/ACTaapHJtw+YffKhQpeDLee4SUR/o82reMzG+OIAKVYkpuVbcW6t/07xUNjpeXYWmeTuDE5+jBJXRIQLX0XllEEnXeTXNodNCp6L8dsU/iP11p1t2XPog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNOS1RkZ21vZHl2L2NmTHgrSHlUZWJXaGdvbXdmdWgxcGRNWkZqMHhDQTNU?=
 =?utf-8?B?cFkvdWhvSktJNExVNmZSZVByOHZBVUo4bG1pQ2h1eVRjMEo1Y3BRR0EycW5n?=
 =?utf-8?B?d0tpM2JyYU1SdmlzOW9mWEZJZFduRGl6S3NqS2FxWVAzR25pSUlkL0R6ZzVs?=
 =?utf-8?B?b1dKR1FpNVVzQm53SXhwS0d3K25wSnk3S2g3a1Q4TG9KQVBpeU1wS1B5bmdQ?=
 =?utf-8?B?b3BYalBsaTFvNExoZ1E3ZnM3V0VKdEtTSVlBWDNVN2pLTXA3eFN5SmtpbTNK?=
 =?utf-8?B?K3FhODdyVm4vVU1OckxJeFdjYzIzYVlyOWtRUklwOTVmVzBnSHUvTXFjNVht?=
 =?utf-8?B?azcvU2RHdkN6Sk9OQzlFd3lhUjhiZmhnRXRDMmtGYnJkZ3FiQ0lKOTI2Ymdn?=
 =?utf-8?B?aDROUDJ3TTNsOVM3QWVDbjVzbUhySkJReWp4MmZES0s4N0hvQW9rL2FSaEs3?=
 =?utf-8?B?U28xNUZPcXh3V2IwZ1l2QVRnZmdXNTBsMEZNdUUydGpxU0xJcXVweUlaZGN5?=
 =?utf-8?B?Q3I3cDlIbkl0MmZsbjNkRGQ5bVRJYmdtSFVDb2wwU1hkeXZRNUorNHBtRTB1?=
 =?utf-8?B?eDJiZXNSUG9kS2M5c2lsbzRNSU9RQThXVW9sZUxzV1VMclQvTHlWN2loZkhV?=
 =?utf-8?B?MFdpZ055S0hycU9qNVBXdGtjVXgwQmk4UnlxNnlUekEzOHNzV1F3a3djaFZH?=
 =?utf-8?B?WWhEak9PR2tXVXlqR1JoOWtxeUFOV0VNWFJkTWhsR0ZLaTVVZUtTVDVCVVJM?=
 =?utf-8?B?TXcybTdmOFcycE04L2hQM0ZmWEhQb2J5NUpLaWlVek5UZmczV3hZdStqak9C?=
 =?utf-8?B?UmNOMUcvVjljYUpiSVh3YkM3YWprRHZCdEg2dGRRTHU3QnJjSCtzbUcvSDU3?=
 =?utf-8?B?NkMxTmYzcWJTbFAxajZPckZzeW5zZEQxU200ajF6djF1UEp1cHJoMmFNeS9L?=
 =?utf-8?B?NEtKSGwvV0ZSQ1ovbW5MSExMTDdrYVpTemUvU3JZalFKZ2ZFNnBSejJOYWNC?=
 =?utf-8?B?ekdOM0JZbTRyNEQ0L3hmRjJpTWhjbWZuUmtmMGRZL3hZRHp0cGlKMFIwMDRv?=
 =?utf-8?B?d0JYejRyNHlySDd4U1Vqc1hXU3MzZTJpSitIVkd6WVZ4L1NSTkJTQ2dNcW1u?=
 =?utf-8?B?dTlHNFlkd2Z4bGRkbjgyYzlZRWxKWGg0WUlYYUNTT2lBWHQzQitjRWhibmZV?=
 =?utf-8?B?MHJ6a21WUUtWSi8weTcxM1dINkR3bUZCRzcrdlV3NzVUV1IxTUlNbE9jdS9P?=
 =?utf-8?B?V0tnK0xyZit1T0VtWVlWOGVaWnVwT2hNTlJ0dys2VktxdXM0T3hYR3Q4b0wv?=
 =?utf-8?B?WDdGZjZCTk5DRnVvbHlGem9iZlBlRXNLQ0VHWEVnUDM4OWpQMDNsVGsxYmlM?=
 =?utf-8?B?M1NVc204WTdOR1ZFMDd1cjU1VXprdm52RFl5SUJmMVQxV3crZkdMNkZ2blU4?=
 =?utf-8?B?djdFUkJodUFIZ1Q3aFdMazB5OXRCQ0kvWlJlRHRFL0gzdnJRbVYyM215L2pF?=
 =?utf-8?B?cDEwbURCbUVaTzd3WENZandWMnBRSGUxU3JBL3lsRFBpa3I4VWxkV2dMTmNN?=
 =?utf-8?B?dC82WHBGcWF6Z1NuZGltOVVTcVgvakxIWGFUVGpxZXVLM3Nzc1VFYmZLaWto?=
 =?utf-8?B?NWJETzREbW9nWERMY1Vkc1ZtaDA1bEYvdVlZTm9XVVNUemFTd0toTitPdHI3?=
 =?utf-8?B?cUl4UXFmVDZOeVVxTkc3UW1vcEdsRTZyWTZsMlJpSndGSmNUNVQvWEIyVlln?=
 =?utf-8?B?SHZ5cmtyakdZd3BwUVY0K2VIV2doZ0hQblo5bmpFajdDc3ByZTJLL1NTYnRx?=
 =?utf-8?B?aFpEOFlLRWdOMnEwemtLU1lGRDJaNWpQOFRvRHo2QkV5alRiWGpLV3VuTFlE?=
 =?utf-8?B?RW5KSnRrNWhuUEpJc2JicXBjS1p6OE1mVXRWT1ozMklyNkc5MUp1UzFWblI3?=
 =?utf-8?B?RFJEVUVuZzdTdGVxZ00wZ3pHeGhYSi9rc25BbXVuak1YL281ZWl5NkFseTE5?=
 =?utf-8?B?cytqOGs0Y0NobmZhUnE2U3R4MHZXTWpBbVFGTG9DeThaRzVEc0xsbERqMlVo?=
 =?utf-8?B?M1Z0WUFubDNTRGlkVWY0akRwNjR6YWlvZmVGODZqeWxVQXNZWDlOR25mS0tI?=
 =?utf-8?B?OW40SjBwYnFqd3hsRDdEb1kvMFVCSTQ4d3ZSNW4wVWxiYWRINkl5UzBHL2tu?=
 =?utf-8?B?dUdGVkFzZnJzWk5BKzZUanlLLzBUWWhFM25kaHNuTEhiaGdyUGNLMEJWVUlF?=
 =?utf-8?B?RUxXODlKd012OVRQRnUrYkM1ekwzWnpoZWVTN1ZKR20zZHZVS1gwdWdUQTh2?=
 =?utf-8?B?SllnUm9WVVlIT1BWT3dIemMzcmpKWXpvMzdSbXBtdmIwVFVOOXppZz09?=
X-Exchange-RoutingPolicyChecked: IuuF5WQd/byDf0sTeYdzF3ZDGOJXk1zKtdD+8LERp3LlsuRckUsRN8T59Q9V/qq44HqqS0sIlpol544PLdfQiTVZ0VXeiQggZfU6iqSJp1TGgDLj+pB2aFzTbA04YKndd7ecDS6hYezkO/rhBIlafsjkbTsMtTEiKFpkcClTCr80LM3lDyqN9MnOp6FMb+heG7nzhJ3jredEqbhuN7Q/fvRRmxzPnKeBe1qC7TGtZqyKpE+wqym1sDOZGKdHecS82NfUSuNvue7+k6eeeOdV1YW+KETevMQHIDhH0V8YCdVHWe6w/6KD2zmqqUz333ZOKn5POYp1V1nu6mIg78u2wA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 626c8ecd-2691-43d7-593e-08de973121fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:44:01.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKJIcNgycxIPB5nKHhTOUqHFnUGbSvP/Ytpl/tugDx2OsB8H9rYNzzHu1uA3yhsjHMlEx8k6FyHmT5KVNlqubO4YkeYY9NBRdtY7yCRz+5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7919
X-OriginatorOrg: intel.com

On 4/9/2026 3:42 PM, Sean Christopherson wrote:
> Add kvm_vcpu_arch.rip to track guest RIP instead of including it in the
> generic regs[] array.  Decoupling RIP from regs[] will allow using a
> *completely* arbitrary index for RIP, as opposed to the mostly-arbitrary
> index that is currently used.  That in turn will allow using indices
> 16-31 to track R16-R31 that are coming with APX....
> -	unsigned long regs[NR_VCPU_REGS];
> +	unsigned long regs[NR_VCPU_GENERAL_PURPOSE_REGS];
> +	unsigned long rip;

Digging the history, this effectively reverts part of changes in

   commit 5fdbf9765b7b ("KVM: x86: accessors for guest registers")

which had

-       unsigned long regs[NR_VCPU_REGS];
-       unsigned long rip;      /* needs vcpu_load_rsp_rip() */
+       /*
+        * rip and regs accesses must go through
+        * kvm_{register,rip}_{read,write} functions.
+        */
+       unsigned long regs[NR_VCPU_REGS];

But its changelog didn't go into much detail about this change. I could 
only relate to vcpu_load_rsp_rip() which might establish perception 
coupling RSP with RIP back then.

In any case, it doesn't matter. I think this patch makes a clear 
improvement - for example, now aligns with _regs[NR_EMULATOR_GPRS] in 
struct x86_emulate_ctxt for general consistency.

Indeed, this and the whole series paves the way for APX. Appreciate for 
the time and effort!

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

