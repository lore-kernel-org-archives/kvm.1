Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39922F6560;
	Tue,  7 Jul 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466537; cv=fail; b=De3ksigdpkhubQa4zvUtgV4cLRWAp8Ykjiyqm/F2ReaSfukG91CFt/F1QO9QfrYJzDVsNcSiRrkodnfp96zjTFUKCspCpyQ4lXLkqZv6BTd7Y1kyJf9sqnTchV2HI1z1/AGmLLXjfK4pbqGq7//o9Ne4FdtZfdgbE3E1nLtn9Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466537; c=relaxed/simple;
	bh=DCwAsLkdtRO4IeENQ2U2dKNM/Wlpz9Plbme15kup0wg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WHwGlpEzBJ7PVNmVAyLfReggbsZjRCqLodgs7C+BMlHDwVIr2DHUpTcwzFvBLFjemvxruTvqWGmOaJ00UyxIWd6ZZxfj0VfYd5S6Lube5I2PtqVvFy//uiTJkk0SJtC1/JJdNxWnlArGXUX2O79QdUPp46u4J32ubkT/zL9bDEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a28hCZuk; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a28hCZuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783466536; x=1815002536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DCwAsLkdtRO4IeENQ2U2dKNM/Wlpz9Plbme15kup0wg=;
  b=a28hCZuk++CNPcEe9a2xVOskOLoZzrJOw/VefSTqjb22h6wsa91eraIj
   sqEMSSaAn9r75S/e2w8iS8stU86RbCL6iRutYNPaH77B0o11uzSfMUXSv
   7btyb3OUMUjBunSCPuiw1r9wx2sasfuJAhGSCK9J8DlOhOjmxUof2v1pK
   wlqrGHubKDWsGCW5kzI9KDVE0yZgw372Lu2zsrXTZlLGYS+jhLC6QbI25
   yS0CgBcUScBdMNjG4eweCw13jiXmMY2jgXUMiCDpD9qD586MNQlR6EDaH
   VB2l1W8HzAy94679w5zz1BCu/W224plZeGEWNl/NeRMx6Y7R85yMMvY5w
   g==;
X-CSE-ConnectionGUID: 4mYRKG/PRBykNHt+JatZRg==
X-CSE-MsgGUID: 9aOPRpZsS/qt9gTOnQojqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83901385"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83901385"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 16:22:15 -0700
X-CSE-ConnectionGUID: VSZpEIFWRouLlrn13PKEeQ==
X-CSE-MsgGUID: K41rsuUgRg2uik1PoGTN6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250138238"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 16:22:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 16:22:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 16:22:14 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 16:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7Z3+uInn2b8BZ2pUNqITo1+0rQnYZeMj6x4sYqTqRFVh99xjaiIavO1vqpqA7eCQYjI9lPL38jJfAzs+eTI7DqCLbkrAfLHhNj9dYW/aTjsMy8OM/PzYHbUupnJBw/hffgnuux4H36NILycejpjA93J+pHzPP+OT69nHaCPi5j0B6o64xLlVCdAZk0cbrVLT4H4PVCRpc6wie8Vh7Y1YACHa1PHxqWEPeA1oTdSmoShCnuXg+Ni6WRWx9GNEjtBCfEjoH4SictiF+iDDHRgO8UOZzE3XE7m+BiaQnaVduwvxNFMG67DTpxNHkI8WUBOEh6+BlaH9QK2DCQjzlCxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnMBTkGujLZSVbx9g6Jlhdvhj1Isr0aFED5Js3GtQNA=;
 b=wGHxewr1k06AyVwPFNroQrJqctp4nQ8TNT+BmMiOfvSDVXchbtUbqYfKR7zdqxTVvNkw6FlXlAx3Pq49U2pYIZ5AKdK4iDxn6gZFQooM7VBxu1wOtRKEs++GHFZg6vmrs6FRjviYTHMHklpLI+0lQz0FsUO4gEK6W1+ET5qSxKOa47ykaNvm2XchAF5YEe95s1NW1ybSpOrCgW+rFsouS3ho4ntX8ExZJ086/Rn+u3MevfdkC56Ac6pKBu3h4ImyRT4zLBJ1aA/HlWRbA73rmRR+mAC7f4QrxA6OFHQYHwULLwQ0y4kJ+7LONcgU0W+3cB3I/cu55ysWgm9taXFzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 23:22:12 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 23:22:11 +0000
Message-ID: <a4b596d1-c0c7-4674-b5c4-dd565a6fd3ec@intel.com>
Date: Tue, 7 Jul 2026 16:22:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Content-Language: en-US
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <yan.y.zhao@intel.com>,
	<kai.huang@intel.com>
CC: Binbin Wu <binbin.wu@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260526023515.288829-2-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b64ee3-7243-406a-b575-08dedc7e923f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|11063799006|18002099003|22082099003|56012099006|4143699003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: S9rAyECK57KVYNtDZKeNUVp89Qlml5XhDi905bHR4T2JOs5+E2sIS9y13m9Rtf0w85zKGc/HiHz8/LKRLC9B77KJ85uui/0meSbwwvRQWucSlEDMtQBwgknLqXoHGgetXvsENN2sJFA/PTEec0pPmLkTS6rPkoA2GmnnzLR3wVCr7BfDu3qMi/hwzjC6O6QxwjpoZHhcZzmYjfJCOoJAMBxFq/K6Hl0Fuldaco26fEv9sDSn0+e2Qgh+8xyTtY5RIVdxCwqkJ/zZSDCmm5UXvdeu6tlGwMctPcq07MnEECNOIEf8Hqu4bhxMowZsarI3ZAWVx1tG1efEaoFWNx4/2ncjHF1t3IUouNlq69PkDkB24qTkK6DL8ZLdwzopD1lyfQrEMcC5EJ+jh+1EpWm2ZgiMOMlbcOehiZVTZHgBR0sxjkSjsJPYSKAZubZLGZ/PHtel5+xLLarKuaDcZ51PysCG2tTRcONt27CRQB3GwsrEioOnh6WGS4Yl1ymSmspkNYAlTcm21+TyjyP+QP/iuYNPCaRBICZttdtdQ4QbPhbC50xD5zwFqybfCGi94wTkmTnS7b+8lmO5fIRFFjF50/aFZmgPUJkMbPNOjXZ614JZHj0tkB28krChyovEc/ZwKRXPX8XpLbZRjyMRkulYL3eGJir/u3wcEyErZ3I169J4d7vj9kN0d0jzDhUgiM6ZYGYyUF2URQpr/N8v1t8TIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxoZmsvU0dXYWNwc3ZQUHhkUHpxQUQ3RU95SEZacWlORUxieXgvZmFEc250?=
 =?utf-8?B?WDVVQzltSUJVbE0xczhCbzFwcUo5V3lUZXE3azRSWGIzS0xiTDJybHIzVWxW?=
 =?utf-8?B?ck5yczNFNGcvMi9velJEVWJkOVl4Yk56NitlYU40NTZnMFB3MTBoeVVJSHVw?=
 =?utf-8?B?Rk1CRXJ0VTBCYXByWW5La1hVZjNZeFFBZ28vbmdDRFlKcmNJMmFqR2w0eDFw?=
 =?utf-8?B?WXR4bmZpeFFjM3ZOUlFJNXFQeU1FN1diTWgyaVlkTWx3Z2FEbzdteGFadjc5?=
 =?utf-8?B?NXE2OWNGakdKV0dTQ2cySFRPM2R4ZG1wV1N1RTVhNlBZVEcyZjErR3R3TURn?=
 =?utf-8?B?MXl5SVhNYkd5bFlzSDdOMGFxRmt6eFFJcG5uOW82eHVmdmtNcmkwbmFES0c3?=
 =?utf-8?B?clBGR0VDRVdWbkVXOFdGZXlaNzlaOS9iTHJSL1JOQkNlUlB5WHdOTWNJRFZG?=
 =?utf-8?B?UzhmVzNwZitCTnBsWDBlc09iQ2dIdUR1RjVaNWx1aWQvUVdHeFFvaWJjYUxv?=
 =?utf-8?B?YXpvSHdpYkpQUXlHejZXTEtoN0lHellmSlNIS3ljUWNSNnBwcXV3elJmdm9q?=
 =?utf-8?B?U3VVQjRRWk5uTHVPOHNpNHdKOUJETTluK051Unp3Q0h2ZEpvWUhIRUJ0Z2lE?=
 =?utf-8?B?ODZpejJqQmdITHp5aCt5M1JPZFRUaTZoOExhQWFudXhudFJHcmxyWkNiaVNt?=
 =?utf-8?B?aTZDNTdTSUZ2Sk5sd0J1NUxxN1NPMk5uY3dpNWhoRnFwODYzcHVUNDc1aERx?=
 =?utf-8?B?cGFTOG1Xd1p4ak51OURhTDZMbVhRNjcrZ2FPVk9nRWROQlFTWWl1WE5zYVhs?=
 =?utf-8?B?eEg4ZEFIR29VdDJ5eS80RkFKaU0yWDAwWDdFdFU3VHZnTVhiaXljT3VGS3M1?=
 =?utf-8?B?NTN0ZXBNNDJ2L1BzTE1WczVxcGljeW9CMWdheHVndzFzZzBVOS9POHhzWTJi?=
 =?utf-8?B?VFZVZFlHUVNyci9pWUlJSnZNRjZIeWFOQ21PZEFkdDl5Vk5CTklmSWx6a1ZR?=
 =?utf-8?B?dDBhbHRxMzFVd0wwQUFwZk5SemZ3R3JqSmxKZzM2QXNjOUJTaWRNL2svUysv?=
 =?utf-8?B?QVc4bEdUcnZ0cjNEbE15NlJzdk5QRjdSbWxaOWE0akRUaW9Yd0pNZDJaWGhv?=
 =?utf-8?B?RWEzODl2ZlVOTm1LMzcvMUc1My9HbEtLQXV3a2FHVHpuaFdzbm5Qb0x6S1RW?=
 =?utf-8?B?YjRFSkQ5VmM4T2JENnIzeU5kOWJiUE93UVM2Z0VlM2xwMVNQWDFIV1ZRUGxP?=
 =?utf-8?B?RnlINWxHaWpCNFNuOUdRdXNmQWJVVUlSK0hKUUVxZnhiQW5GN2xCOEo1Z0c3?=
 =?utf-8?B?MmFHMVFGN05lZDFkSHVEcWozeHN2b1lrWU5wSW9TYko5WnVKTDk5alI2RFhG?=
 =?utf-8?B?WEZBbWNXdC9KNkphZ0dsV2FxNGJNTFJNUElIMU4ycVlnUHNLM2VEdkFnbnhD?=
 =?utf-8?B?bGRRRVFId2oxREk5NTNEVS82ZUVTdisrTkEzbllzazRUYzl1WXpuY21sZzds?=
 =?utf-8?B?aFRYSG5lL1h4M2krRFIyNVJyNXVqWWtMTXVSdXRPRnMyejVoNnhVdjA1ZDFQ?=
 =?utf-8?B?ckhZZkcxZEpRQlIzeTlGbWpsL0hoWlNMYnVSSnJicFFlckZidm1MUXdqbEMx?=
 =?utf-8?B?QVdZVlVvdWpYbkY2Ym9vUEJhSVZIT0dZNytBNmJjbTlXS0tUYmdmSWZSL0NV?=
 =?utf-8?B?QWluRFBiMFRSMVNXSm55YVhTQklQNDhIQlV0MWlFcitadmdiQ3IwVlVlL1dx?=
 =?utf-8?B?L2RwS1ZDcUoxYzNNclUzY2dUWG5hcXZWc09QR29tMEtVbEduM1FiSnBHSVB3?=
 =?utf-8?B?amJlUjJaMXVKV0dUcW80M1RxYnJhREQzNGNqaGhyMWhHVGE5STNxR2Y2YnFT?=
 =?utf-8?B?Y0RVL1NkSmhsdWJmZVBNVi82Mllqb01WUDk0cWw1TDVTNGRTWkZvek5JRFlp?=
 =?utf-8?B?Q3JSYWtIN1pyT2dpdDI2Yzd0KzdPWGZ3NTBWcjJHd1pPY2hiS2JlUnBBQXM0?=
 =?utf-8?B?Q0VJcUg3SmExTFJwRnBvd0JrTGNlL0h0Y3VjS21nenoxL2FLVW1ZR05RMGlE?=
 =?utf-8?B?UWo0S0lpS3VuZHZtNEJsZzNXWEVtaUZFaEo4b2l1ZW11U0lyczFMUlJaZ3VJ?=
 =?utf-8?B?UnlUWm1ISGFvdVhoYXBzY1ZJU3pYQlBhRURUYVUyRGhQVVB5NzUzYUVMbTRI?=
 =?utf-8?B?WlB2dU1vVTJuL1d3eU9ydElvNEFtai9QOVBqdGtsOFY3QTZZdHpPRkhpRzBp?=
 =?utf-8?B?VDVva1R0S2xlOU9BeDFhUmM4NHkrNGZxZ0J3Z3lJbnhSS1FzeGozZ2NGeWR4?=
 =?utf-8?B?QjJEVER6d2swbHdlUEdIc1pCQUxzMWMrdFBjWVBtVm5Vano1RWJQUT09?=
X-Exchange-RoutingPolicyChecked: HeLHSBSIg0iDQ7e5zpsAcqSp2W0YpktcsydZ4mmWknVNLf2NK2gcuAilmmVpYg7HIRuDWc27lofQGPVD/lUVBLr/He/bkcilEgKfa7m3C/UHOBNvR3qZlmaQdWNlEaKyooq9DdgZQWx5gksQ6WHEoHHYfNFI/ITqQ8cG7PXOcwGbJb4LzONNgfWA61A1O5YWxZYaT8va43XcJa3NB/zky8094xX8JB9zlE6HGmWb3W97vJzCpsFnrX7GoumCKzvNiQwx9cqAyi4rdA+q0oHJyXIcsmFuGmtY05M1PmBlgXRF0hJoeTS6VtQlHisFpYXmb86M9IQ5TJna9eu0Zq1g3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b64ee3-7243-406a-b575-08dedc7e923f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 23:22:11.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/YD5A5gqQ9W0TgkelcZWCiNRIPTvK5ClB7TdBVhcZBloDef0/dds9ZDnFTOZRFWN2+s0rHb//i5gIVukKkpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com

On 5/25/2026 7:35 PM, Rick Edgecombe wrote:
> For each memory region that the TDX module might use (called TDMR), three
> separate traditional PAMT allocations are needed. 

> One for each supported page size (1GB, 2MB, 4KB).
Missing verb in this sentence. Maybe use a '-' to merge it with the
previous sentence.


> There are some commonalities in the math needed to calculate the base and
> size for each smaller allocation, and so an effort was made to share logic
> across the three. Unfortunately doing this turned out unnaturally tortured,
> with a loop iterating over the three page sizes, only to call into a
> function with cases statement for each page size. 

Did you mean "..with a case statement for each.."?



> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 967482ae3c801..487f389f52f4b 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -516,31 +516,21 @@ static __init int fill_out_tdmrs(struct list_head *tmb_list,
>   * Calculate PAMT size given a TDMR and a page size.  The returned
>   * PAMT size is always aligned up to 4K page boundary.
>   */
> -static __init unsigned long tdmr_get_pamt_sz(struct tdmr_info *tdmr, int pgsz,
> -					     u16 pamt_entry_size)
> +static __init unsigned long tdmr_get_pamt_sz(struct tdmr_info *tdmr, int pgsz)
>  {
>  	unsigned long pamt_sz, nr_pamt_entries;
> +	const int tdx_pg_size_shift[] = { PAGE_SHIFT, PMD_SHIFT, PUD_SHIFT };

Both of these consts go hand-in-hand, right? I would write it as
tdx_pg_size_shift[TDX_PS_NR] to make the connection obvious.

Just curious, why is TDX_PS_NR defined as (TDX_PS_1G + 1)? I don't think
we are planning to add TDX_PS_256G anytime soon. But, should
TDX_PS_4K..TDX_PS_NR be an enum?

> +	const u16 pamt_entry_size[TDX_PS_NR] = {
> +		tdx_sysinfo.tdmr.pamt_4k_entry_size,
> +		tdx_sysinfo.tdmr.pamt_2m_entry_size,
> +		tdx_sysinfo.tdmr.pamt_1g_entry_size,
> +	};
>  
