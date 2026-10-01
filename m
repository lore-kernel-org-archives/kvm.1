Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C948A8C6
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886412; cv=fail; b=EfbwohBAGv3gN/HEJS7RdLVDG7UUelT+rWt/+mpV3VHYUv4njfla0HDWXKzyCYbHCFuNnZVGbf4pbkf+QxlbGwe/ZvaGStKMKDkEgCn76aWuMmlt/nigQc/nzMCFNd4sOTx1Az8cNKkaSGwsmLGNE+dky3MRtOx7Vu8GigpERJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886412; c=relaxed/simple;
	bh=LqWennPkLHrJeE0YCYMgKnrURZnbAI2bb96oGP38MmI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8XAf3fp/4NDkNInRYCe5c2rpItzjTQQhTlH0jPM0W3x9imkhOrVdRyDPVHrF1od0J8txES4sJ8C+m6oYmehm5l0zAcmqehw+TsY/gOJXNRLNRL5k+AhvpiCUN8RMyiteBTuVw/dX5Tc33rM1lVWVYLEM88livKtRRdpEVBSNy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeMKy1Xk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeMKy1Xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886410; x=1822422410;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LqWennPkLHrJeE0YCYMgKnrURZnbAI2bb96oGP38MmI=;
  b=IeMKy1XkAjJSdAVYChtyBZEuinF4RXwyO7XV38SpPgRq+EY3CK7kAMMf
   Qsf9aHGrY44xsdXXsUq96ljCY7W4uQsBWOUb+UHA76yUvGY0BXAOyUYPD
   CxUOZBJcpqR8XEU4LODeNYUePD+6qIs4oHkPy2gnyCbkx5476H4NwvBGm
   Kj5L2i+fnQOVsbDZY6pRltp0VuoB90iwBJ93Ntpg6hKMmPv8mDY6eehdk
   wShlxDgYcTKRmrPDqPGzlOAro8n7FuMOQE4o/M36wZbRvDckGkfrIVJgv
   Zpzv6lyBZEyv23j/EDS+MnTyvxvdu3PKEyAuqfdMWWmPn0fxEyT7D+5LP
   g==;
X-CSE-ConnectionGUID: ofSu0LVqTK2J92XZaZ+A+A==
X-CSE-MsgGUID: pondrkCHQ+2JN3mQB2BDfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95467269"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95467269"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:26:49 -0700
X-CSE-ConnectionGUID: J8X13ShtR9a0vwXXn0C9Vg==
X-CSE-MsgGUID: mXKiCsVQSC6TkIVF6opixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275637197"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:26:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:26:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:26:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtUjHuWw2R63HyItWhUGkZ4mjXh97IB/7cqj9hxMeCTDd9FxKytHoxeNeuzv5CgaCyi+sOg01LI0sGieydPwCXDGnivJSldFF3pgy87ncB2gKz/WS/KcaT4+HB0L38sKbJX1wbNHQakdKtWen1yCj4Qt+CI/Q4UJ4A2hKkTwottek7NugunbZyY4xeP2KAFSRmYAKwFSqGaYBMpwMbm878+yt4+MSyWGaRq41KQGZ1prfE4cSbLtqiGfwVMbG54BOlOV9J9l3trbWSRqPqRJbL65jPf1UyWDRD5O0Fxk7kaub2+y2QV5gLbof0iIfPvIZnt1o3X//WFeAxUODw7QiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvYKABNBVxJh2mYP/xU0J+TUf+X1SiuOjy/UrDzHV8k=;
 b=v65Xt05fBeNUJIFVObZvHIlXoaPL15jbMdZC0cwVIwhWUa+PIJ+ovqghLSQTCzCMaa1CDS6ZRPkTHidHMZjQjmRwUgDKMPOiI0OjrN6o27EDDcNBhFndUOs5XHttFK8szb+GcDiRVaxdv/lr0IABtLXs+4bD+G+FbsdqPDUj1eX/JthIzuUNP6HbFRhLb/9gOV3BIZX/O35DPxysIGS9cK9eiapI/tba1RIECMAsTFOBlXFXv67Qp2Dc2YZYvipzZncdTFQ01FGebe0r8Q6aoOv9sDX9K7skRHqj0/vUe8GRayOSqamjeAVim/qEKLht/DeFukA7G7w/EevopegE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Thu, 1 Oct 2026 20:26:40 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:26:40 +0000
Message-ID: <c673cc8a-876b-4b70-a00e-81063241515d@intel.com>
Date: Thu, 1 Oct 2026 19:59:46 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 12/20] KVM: x86: Support REX2-prefixed opcode decode
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-13-chang.seok.bae@intel.com>
 <20260930215450.B8DF01F00899@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930215450.B8DF01F00899@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::19) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a4985f-ff5c-473e-f891-08df1ffa4cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6G1sFuumLZ0XhNr6WWcbTtYGQGBojVNdTaWCLOi0+JY9AMicI/ujmMBcRUKTSksyajDfJAmPIvi3jvgd9UAEW7mKNEZrQY1IY4r2l8L4r9mp4BTGAb1qvq9NT+DUvzYKdA6P1mLQsVOx3BraE2hmxmFYF8E3kqwX6pWZDorf2N+3XXYcVulkjxmEnPpHHs2i8CkZLb7t+KNhdeIIwL3EQ59tWhXQ5oEPxUWSXCgDhuNV0j/Qy8t6XE7n8EZcHPKX0ptnj4//P/sH0Tg+Wd0W2Gra0rfEs88T0Huhg88H4zZYagA8Ah9kFebgaw1DmJI7tLp0pSMgx1F7sWklNE3xROlbQY73uUKmRSHAAtAowEcV7yU9C1XrhxXJ9lmJlnYNPECvW4QDxsLP3p39wTTyVOXSgS/HGU3XY0/XGIo+Jf3m04Cc1ONBmWoDWMKhCRLzVfqGmE/N3bGpOrCqsy/UWMDnkVVd6fBQb4plsksrRHkTF/99dTzKsg77J5W9mC5FFBzmpWlly9hTddJmKu6tvVxQnkMHoaYxINtEVKMRhpEinqpM5bYIP9DAXKUpzk8lMjT5UbqTpRA2AYnnNZlQfitcX2VDJPL6EtyXYCVyFo5S4gP9ZZsl7ieDx9azFRcqzEs26FBLU99D8UXIYvx3HrHbcLtiqkAA3lLRC6k0jb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FqYUNoSGkrdjl0SFNTQkZnOEMwTzRRYkxnNG9oZ2FIYmFvRFFpemprM2JD?=
 =?utf-8?B?YWpTVVpwZEM5SGcyRS9HUXRNNUh2VVBJL3duY3VGL1FrNmFZeXBlamxxTWh6?=
 =?utf-8?B?YzNyc2RmVEZrRllJNHZhQmJtbHcvK0NWNS8vZkYrSlBBNnRPNUFQYUd5Zjdm?=
 =?utf-8?B?V3Ura3o4UndBSTlGMWd6RzBTbkhDVHFkOWRPeHppSUE3Q2h0ZWpHWWRNa3M5?=
 =?utf-8?B?TUtOYmNMSnJ3OUVuL3lCT1ZNeDFDTzEwQTE0ZGE4bVAvT0VuQlBPUXNnOUhy?=
 =?utf-8?B?TG10cE5iR29KdFI5N0xjblk1Ky9WVHFpd0V4Q0huUytaUzJJN2hCaS9WeU11?=
 =?utf-8?B?aFVOV3hSTmoyeVd1VmN4WjRZMy9MUFc1QXVuOFQ2QzdlcjNnTCtnY1R4MFMy?=
 =?utf-8?B?V0hJZEx6Yzcxc011QzhyNFF2Y04zaThKaXVBYTltTkpQRHVJclVXVWd3TjdZ?=
 =?utf-8?B?SXJNUExzWG1LcVRORjhvMjBtRk9tME1kWFFZb3Ezb0tKbGlYcmVQVmIyd3Y2?=
 =?utf-8?B?OGJnUUo0WUl3NWdVVFQ3cmJwMG1WU2h1eWhFUUZQYmhKMDk5YUd1TjZqR3dP?=
 =?utf-8?B?aG1yeGVyRkJDV0xONU5hdGxvR1M3Mm5YU3BXeXFGQTRZTk50a2JaM2Q1ZFE1?=
 =?utf-8?B?eUZ4TjhuSWZzQ0pQWS83R2tFZDdVKzZYTllWTnZuUy8xZmlTbkllVzVoSzBC?=
 =?utf-8?B?YzRIQXZDMDFVVlg2K3ptYlJ3Vnd6ZDZzRU9kTkdTczl4OEE1VFg3c1g1NGd6?=
 =?utf-8?B?Vkc0SHkyZ2EvbWc1YkE1NFRGdzJUckd4YitlMVE1em9rbVBMMk1kVGhmQ0xm?=
 =?utf-8?B?WjIwdVIwV0ZxVG5pbFVTQkpkaGJEZzQ1aWJSdWxyU3pZVmppZXRKc3lVN0xy?=
 =?utf-8?B?V3UyRDdzL1JCRnRPbEk1SUhEWkFldEZtVmZRNHRpNWR4K0FJVTdOeFZVMVBJ?=
 =?utf-8?B?NmFHcG9HdUY1d29SNHd1bGxDVWFOM290SXlDaU5WRTJGN3J0NGNyWHNXSTZU?=
 =?utf-8?B?UXJ5eFBxeG5rSlFGWEg2ZGdaM1NyZngwS0x1U3BVa2tsNEFlY3hIMjA0c0U5?=
 =?utf-8?B?YjJNUnhEZ3RQbVo5RDFlaDdQcDFEWDFRVnk3ZWlxR0dMT1l0emNoK1RaZzFk?=
 =?utf-8?B?ZkNTd1ZpcndBb0wvZGp1dHE1R3ZhZy9uaGxUN21lbVFMdW9ZcnVqdEV1WDFU?=
 =?utf-8?B?TzExWUxIM0JqL1NYYVh5SkJXWmZLa3V2VVBjYWM5Ti91SjZSZFFkWkoyVTdV?=
 =?utf-8?B?emZ6MFh5WTRCTUdjSHBIYWcwTzMxTGJMYVB0Q3dUdVN3bElVeHUvVXhwbHR0?=
 =?utf-8?B?VDY4a1FXWmYxUGkxZGFIVUtBM25SamFKZllDU0tLNXV4SU8zNlBFNTZUeGxO?=
 =?utf-8?B?STdhd2FpNmxrVUxnS09ML0hyelo2TXpsVk5sT1lsclRQdUFHRXRvVmIvd3ZV?=
 =?utf-8?B?NlpPdDNBeGhubDhZZm8veFlsTzJTT2ZqS2x5b096M2hqYlp5WjlocFg0bVg1?=
 =?utf-8?B?cmlYcVkwRlJhQlBkcUh1Ky9RNGV6cVRTaHZOSUlWMzN4MzRFa2NUalFlalpk?=
 =?utf-8?B?VWRmaUVrOEpUR3lxQ2lmTDllalFQaFpkNFEraVF5S3FqbUtVM0UrSW5MTC81?=
 =?utf-8?B?WGpqZW92RERKWkREMGJVemxZZ3VwZlNkL1k1b1Y2UDVaQXMrbVdtUGJhNTZq?=
 =?utf-8?B?aWwxYXFKNUdaVXNIaUVnV2t6REFCWkQxbUFMZ0oveVRTRjRKMjBHNzMwemlq?=
 =?utf-8?B?UGNYSEdIT2hEMTZoTXd4WUJ6cUxWbmt5OEN4YmNKZmcvWm9mSVVxaWJJN0FM?=
 =?utf-8?B?TG9kR3ZVZUhicXF4OFlLV0txd2txUmhQbFdCbm9ERGV5Wnk1dHp4QXNoQTZJ?=
 =?utf-8?B?Zm51c0N2RWR5RDZpMUdGWTB2dnEwVzM1dEJpQkYvZDM4c01INnZKVkRGOXN1?=
 =?utf-8?B?bHZsbFFTR2FUSDFIOHNiQ28zOEhzTGZGNzNkTlM3elFQWVkyRWo5VnRaSU50?=
 =?utf-8?B?ci9EWkNUR2UwWk13bEtGQmd4YnhHV09Ya09PZXBhTnVIN2ViYTdkSDZteXMx?=
 =?utf-8?B?THlxaUxnUmNxNjZUbVVzRHNDYitZR1RtMEZIcFQwWjhvWWdaOWwraExzNG9K?=
 =?utf-8?B?ZXU4ZldBQld2OVVqZklTcDBBai9XRzF6RWtFYjZpcjlxZi9kc01QcUphb3Jz?=
 =?utf-8?B?NmMwc0pXRjNreUtQS1pyVE16NkRYdmVoNEg3YWh0WWlTSythV2ZpdFh1dXNV?=
 =?utf-8?B?OEl4ZG92bVVlOHVERkpmZXpUV0gvREVoTENlMG1mZHNsSjJUaGlyNFhtZElw?=
 =?utf-8?B?dmtHYWRFd0paaTJmUWVveTVWRlVIN1l5WEw1enFrOXFSUE5GYnduQT09?=
X-Exchange-RoutingPolicyChecked: tm9Akq3T+FYp7etv7ryCbzzDsT9rk5ZXbQyb45THhl1T8NFYR6h1RKbc4nGMhKMPVVwruFmJeECEBi2uLPxDUpmJ34ulIJCsD/2YxGD52WKXHfL9UcQaHhvIP0AY+FNy+u2yF3eU3s4kDwgnjLTsVoU+2NOqynjNjpPiLO+n6ThG3oxkL6ZzY8Z7SRX6zYc8yWGyQfwonAWMy+9U+96VHdzKx34RwunCWKf3q1Eu+mp7vH90pxlnzQvCNEuM65ZGS7JCwaSDxkSpRnFJb554uvKTjyIlQJSwNql52eE1UcOxmRl5aj64R/GNRdn3tP4mVyJB1SLUvJQ00yTyOhZc6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a4985f-ff5c-473e-f891-08df1ffa4cbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:26:40.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDWwm0y6gP0eUpyAlFKhOB83JobSBCrIOYWgOH0Kx6wRGtK7U8pQH9vO6bqGx2YVOWULGNNbmy7S2fvTdvqUxHQpjoevChL1ncvWz/mL58c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

On 9/30/2026 2:54 PM, sashiko-bot@kernel.org wrote:
> 
>> @@ -4980,6 +5002,12 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
>>   	if (ctxt->rex_bits & REX_W)
>>   		ctxt->op_bytes = 8;
>>   
>> +	/* REX2 opcode is one byte unless M-bit selects the two-byte map */
>> +	if (ctxt->rex_bits & REX_M)
>> +		goto decode_twobytes;
> 
> [Severity: Critical]
> Could this jump to decode_twobytes allow a malicious guest to trigger a host
> kernel panic?
> 
> If a guest constructs an SSE or vector instruction (such as MOVUPS in the
> 0x0F map) prefixed with a REX2 byte (0xD5) where the REX2 payload sets the
> M-bit and an extended register bit like R4, this will jump to
> decode_twobytes and look up the opcode in twobyte_table.
> 
> Because vector instructions in twobyte_table lack the NoRex2 flag, the
> validation check for NoRex2 further down in x86_decode_insn() will pass
> instead of raising #UD.
> 
> The payload bit R4 causes the register index to be >= 16. When evaluating
> the Sse flag:
> 
> arch/x86/kvm/emulate.c:__decode_register_operand() {
> ...
> 	if (ctxt->d & (Avx|Sse)) {
> 		op->type = OP_XMM;
> 		op->bytes = 16;
> 		op->addr.xmm = reg;
> 		kvm_read_sse_reg(reg, &op->vec_val);
> 		return;
> 	}
> ...
> }
> 
> It unconditionally calls kvm_read_sse_reg() with this extended index. The
> index >= 16 falls into the default case in KVM's fpu handling:
> 
> arch/x86/kvm/fpu.h:_kvm_read_sse_reg() {
> ...
> 	case 15: asm("movdqa %%xmm15, %0" : "=m"(*data)); break;
> #endif
> 	default: BUG();
> }
> 
> Does the NoRex2 flag need to be added to vector instructions in twobyte_table
> to prevent this BUG() from being reachable?
> 
>> +	else if (ctxt->rex_prefix == REX2_PREFIX)
>> +		goto decode_onebyte;
>> +
>>   	/* Opcode byte(s). */
>>   	if (ctxt->b == 0xc4 || ctxt->b == 0xc5) {
>>   		/* VEX or LDS/LES */
> 

Patch13 explicitly rejects EVEX instruction, so this path cannot expose
EGPR accesses through VEX instructions.

A similar concern was raised previously, and I gave the same response:
https://lore.kernel.org/kvm/6bdc1a64-0304-4845-a36c-5f309b0b40e0@intel.com/

Thanks,
Chang

