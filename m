Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5144A0935
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886418; cv=fail; b=g0mrmJaMwNa4qHpkh075PzLofrLi9+VoEo4zMrwqc0jJLiRT7NV19JLgN9/RkjQL1dZsdqlR0pV19afuV9YtOq/Zs51cfKMSe8R0xGXz4Y6rjsUGBNdy9TqtsyvzN5zNAYiKSAiH33Te2d6QR88Y4w/CRiV2TmOz8INGTW1aGR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886418; c=relaxed/simple;
	bh=pRqU618KChwNdZQCywopP/E1Nnjv9eGLjdnWJloxDr4=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bArQAtYpLTYeKE91Ng7gBviaP401FnPaOObo+3O5aaLWvHEpdivaL9/CGrLCZusM8HgDC5p39EQ7MwPPzd926Zl7ikluRibEwHbgA90TEGa2Auc6bp2XpcrFy7uDb8l42H7ZzvRRXmF8MxoOg/Jb6UBSNpgKG+5wt422jmeOH04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqKjSmsZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqKjSmsZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886416; x=1822422416;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pRqU618KChwNdZQCywopP/E1Nnjv9eGLjdnWJloxDr4=;
  b=AqKjSmsZGjFEE9EmbB/JKUt0+mNO+son9f2HkIH4M1317tnBE6kw51Ck
   uRNVkAbPwSCFmsQXE9BaDN2M8hHmH4gggsnTuecW66BmfOYPy3FvOYndw
   CovzXNFwFJHicZhx8Okw020yumfeiYLuu4yAMAg3oP1VVr+WgusKGlda5
   ugx15AJRYpVTOcETp8qpn/6YMHo79Su9A7siLjSzoMVVCYDTxEf7VEtB6
   hHBg18rBTW1G0q+yF+Yqix3+OBk+ng6/UkvtcW7QTt/1PUuwbk2VGS1N3
   jqXtcEK2a7WTNpNSQ0E0OipJ2ox1zJ5AvVK8JXOa0wUWnfCjd+bCwt6AK
   A==;
X-CSE-ConnectionGUID: 17a7gc1XS+ykMAkDhWaB5w==
X-CSE-MsgGUID: PgAZwEWXQheKAoyYQWt7MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90516347"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90516347"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:26:56 -0700
X-CSE-ConnectionGUID: 9/LqQIRJTrazAHDrE+zzqA==
X-CSE-MsgGUID: 1TpGyPVgRl6N3Ci28RMmrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275199822"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:26:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:26:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:26:54 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:26:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYJYZGSsu1o/Nx/qorOCy2rnxtgxIKboHXvYBjHctvCL6gg9w82zPmzWkpVyRsuntxxxy7y63KtK32vZbVCUTS6soXLbHTFMMCjhX8nSXyFY6T6bpYAaPLn0lnhDDdC7Rj74eW3XclIRahXsOZ/NSy/yHq/nKlEYcdfYQsgQOZUo271fDOj7LOAnKuuyPNdsKa82nhhfe3UesLLYo8wXw4RzpC5Ue6adpmOUksMCgXSbRX6Q0F0yYgzVaq3rUZWU3m2SwZnInYz80YxXDI0/A+fYxLtFDvURPT8W5EZ3r50SvHQ+qa8KcyY/8DErg09JwPxxzFOjJgg0jNaUd0gL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjsJ3t72fzBWKZZ4jV95Dnc+LwAvEDmdA4wLvvtAliQ=;
 b=ElbnlOe9NADDy1P3FUzavb0vlW0HNTWOuVR75lsjRZu1jEEnpdf1K/UaYfDD+Ry5mt8zrGZvbVBGuqjXP2UkSOqNz06OdKYT2/kjHsmc6KyETS78Cpvya+Wy7eE2DteVu1MudDmNkw4UXHKbFjdDFyDQDSx8kqWf5rvsL2Yq99JodKy70Xxem5/PDGqPHHvLcZyPAz9DdQYTo8one5dY25MPtTHWQ/kW/0Yz/irD3kUHvQa/E3Q4GownRN5a5uaqw0iV4L8S6v2mispl7ztPDnBBBvk9YjM4czNGPjLTeNTa6BFYI6XwIhxfoZ9gf75JeJa2oO2qCe+G7xLF3XkjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Thu, 1 Oct 2026 20:26:51 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:26:50 +0000
Message-ID: <f56b02c9-0954-4d53-9e51-f9b7cfc5baf4@intel.com>
Date: Thu, 1 Oct 2026 19:59:56 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 19/20] KVM: x86: selftests: Add APX state and ABI test
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-20-chang.seok.bae@intel.com>
 <20260930214824.158FB1F00898@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930214824.158FB1F00898@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::12) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 305ba978-7f50-41da-7be0-08df1ffa531f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uzXSgd+5K7fzUT3ICg2aKlxVVhIET7pjQb+DDBpxT4ip++I+ldnPe4tXb4fqaJq0MSZsvuXUGA6qiZI7N/bUvp0tpysyUHXNn7IvnRkD8+kcg7x56O4Z2PjnHV3zJqDa3mJZgg9rNVruAaIVqU0r+Q1bAUYmg3Ggx1huEfqTnvDDOX9jcOnse3237580OjI7U9OdD9REQEKyhtnxqmmJFbawIJoQvpwAb51t2cgFZRLWvCtdl9uUQQiqC2ZjNON0CsPl1290IMsP+4rZzs8Wk55TGjYuL3xGDYVcpdDMog0L8Kl8laKe4KdLm0YAxgXke51y0Mmtzeu87kd9P1K1xFq/gezcpAf1FcFGmHAhbQD6sr4cRy2IjjHnk5M4TFWF7qK4TLT0BVJ/P8SgyLSxNNby6Z+9sQ6H1PctnR3F8ttkKz7nQJe/z2+hdZURic7yHApEzf4vSavaZ4l9GVWE/nmhRVKRxBe7Lay1pYccO4uXs/FiviKvTJ+gKci7yVA88PVF4D+vwc/+ZnteJNfaQ3KPN86ett0EXTbnuv+ZCw7SBQv7DPgMfbYcD4c72b4vYrBJxA9/ZX1hSM5lXT2PuTzRCME1GgSqhc4fxU9QqzAd0sQ094opXQdIS7LYy+inImWJTpV8ADgWNnJ1ICW+vZPaBUoQM31l2KnBTZm9qME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRNcG9yUEN1TlZQLzJxemRScjRxNElXenFzSUROMTRJSmRBT0syUlI5QlVQ?=
 =?utf-8?B?bHFZS3llOHczSS80Z3orOFpPYUJRRW1HS1ZHelBlQVhsazh0R29tTkZTSHpX?=
 =?utf-8?B?R0NUKy9ROG96TDl3QVNnTytjUW5RdzFuci82VGdaRnBjK3RLbHB3QmdqYWd5?=
 =?utf-8?B?KzdjQzlkY1JuU1JqaEdDajdsUU5PcUEzeGZJZDVmeWxFN3Q4M1RabDBvdzNs?=
 =?utf-8?B?aXR1Rk53RW5oYm16REJKQVlHbmlkZy8rZHgyRFljVjQxcE54Nk93ZEM3Z1Na?=
 =?utf-8?B?ZjVaaXQ3S1ZBOU1DWHU3V2tmZ1dnbUs2dHkxMmZWTXlRTDRKTnN2WVJxWDQ0?=
 =?utf-8?B?NnovR1hDMERaamRjREUydkNmaUp1SDVIU0ZONFpZbkRYY3h4TU9ZRHFlL0d3?=
 =?utf-8?B?b25tcWx1WW9nTis1WWoxL1NnNmpxZWllZFJUTnFyM1pSTnZuUzN1ZkJPMVZ1?=
 =?utf-8?B?ZWVMeFZ4VmhkTC9mNHVnUXZ4ejJQUlNod2IwR3RFSzZnNnI0cFVKKzhxdHZ2?=
 =?utf-8?B?UkdNK1BzcHYrTERUendBdE5rYjd1V2hmUUR4Tk1DTC9ZcW0ySXpRSHZUUHlr?=
 =?utf-8?B?QW1CN3NnVkZ4anNscHdtSHF3Sm5vb1BiM3UzdGlpSDJTZSt3c0pXd2k4R1VG?=
 =?utf-8?B?WmFJMmFodWQwaW5iRXo0OGlGa294SXFuUmVFUWo4S2dUTlVqbnFYRUZOMytE?=
 =?utf-8?B?NzFXNFlUWXNpcDFVNm5USmczbVBaT0RXKy84UVNkY3cwSnJaNzZUNit5WE1M?=
 =?utf-8?B?b1BwcjQzVlV5alEvaWllMm5jbmpaYVFZRHRySUVKNUx3Y25EbS9QckRxQUND?=
 =?utf-8?B?U2laSGxrV1RJS0Z1aHQxcTRhUnhsQmQ3VlUrbGVQM1EyS2tuMFlOWFVQY0x6?=
 =?utf-8?B?L0VHamdiVzhPZFp6d1plMFlzNWlpeHFGNURsQWd5Y0xvVDN3V1hjRExhZUZR?=
 =?utf-8?B?dUpobUlPMDdlV0hlYkVJRmxSSzcrQSsxZFVPdThpUFFubmFSSGZIam1GdHJJ?=
 =?utf-8?B?MVFkSmZGUFRnSDJZekRkckh6YXhJWFNhTjZDalNzOWdtV2dQZ1BGdEcrdW1h?=
 =?utf-8?B?aHVGYVk3dGxOYkp2L2ZpSkJDUmZXVjhFUkRFRGFvNkpXaXk4MmpGTE5KdGNo?=
 =?utf-8?B?eUowTTRrOWcwb0FjYUJ1SitIc21LUkxuMm80THFnR3VZY04vQ3N0Q1Arc0Q2?=
 =?utf-8?B?b3VYS3d6RWtMcFFTZGVUOHBOdDlJdmVYN0ZDQy9yNXcrRkZJTmI1VUNsbEMx?=
 =?utf-8?B?ZnM4YmhwNURiSzFZZUtsaWxhUUJzUHZvdDhseTZSZ25iSCt6ZDNvSmVjTWZX?=
 =?utf-8?B?WE1xUlM2dU40R1VCN3ByZHZsMVpHaUxzbjZzYm04ZVlPTUVMSUJwUVlUYTdj?=
 =?utf-8?B?YlFTMVc2TS82bCtmZFhuamdTUmtQR0gwTFhVTW80MVRZNXNaYVMyWU1xTjhk?=
 =?utf-8?B?L1NSSEJxNCs0YUFtaFZuQzRiQ1h4a0l2NFBBcGs0ZFJCd1E1WU9TMU9NVWcz?=
 =?utf-8?B?Q1IxeS9oWCt2ZFdYNHJzL1hyQmNzUUdwMjVhQXR0MW15VVNZNlJ2dnEwMUox?=
 =?utf-8?B?VkIxczY0ZUQzZ05XbDV1cDVqd1Q5WWQ3VVdlanpYODRZUGs2aUthZnZPdUll?=
 =?utf-8?B?VlNlK0ZKVEJmQ043WEU2aFhpbmtLS0NsK0ZOZ2dJeHJDdy9WWnJER0NrNnhm?=
 =?utf-8?B?YjVXbDFpTFlPK3B3N0RnSmFHR0dJNFVpYUEvNWZEUXoxUGpUR2NVRWZGRm4x?=
 =?utf-8?B?bWxEMW9tSzBUa0ZoQlBjcVZwQ09pemdkOGVoQTEzOHR3ZE1qTnZIOTJ1QXhO?=
 =?utf-8?B?T0pBWitWUDI1Z3diTnhBQlVSMHFLcVhvVEpXSlJEc3AwZjI3Mm1BdVJCN3Rn?=
 =?utf-8?B?UXJ3clViUE9PUHRVY01WVHVRRnRKYVFGQ05DOTVLWnlNb3N6TkY1Q3UzbjJm?=
 =?utf-8?B?SWx2eUE1UWFNZ2dRYitBK1R5VUk4cG53TExkODJWQXZkQ1hKZ1d4cWxPSldu?=
 =?utf-8?B?eEw2amNCTkFWeUtYQVFBQ01zUjdDZis3K3NPamZIRWxHbnlrcDlEdG9ZaWY1?=
 =?utf-8?B?cEdFUmJWckcyNFFKNFNlMmY5anpYSkJud1hJVjhvaVhOWmh6TGZ5ZlVFYzJM?=
 =?utf-8?B?R0lWcXBYWE9aT1hTeGlGWjhoN3phQTA5ZW5mYVlIVzc0OXNYRG1XeWJkRHVB?=
 =?utf-8?B?emRpdE9melVrTzRTRVlxL2JKVEtTZ0xhRmd5bnNGVzA0SmgyWStWLzNDQTFW?=
 =?utf-8?B?REI5SWp1aER6bFNVZWxDRmVKQ1czUmNodmpOL3RBRGNhREFGRE83SUY1NUp2?=
 =?utf-8?B?Z1VMVUQ4WEdBeW50aUNyT0k5a1I0MkFhQU4wSC9tYU5meGdHcUxWUT09?=
X-Exchange-RoutingPolicyChecked: uGiuQ7JNgmsjMry1Kd8Spx3i0LAKwrHMVRvwPyaMaDrLJNf2fh8z1t1coorIMqNQ/56v29kAV8U6sJd5oAHoPwr4DyOAeL5LbK+NI0l9NFpw4X/OLeXxhbQKYyK5f53Bl5ep1b3BVajcJygiWc5iOu9OQTqWBgsKclVaTBZR/Ot1DCBIJH6YCrMWWfzCafqqW4yIi1MohrLVurrCfVKmUgMWwUy70qSwfQ8e0XUBiFGr+tbr1xLF9gPEL+aH19e4Q2YIj/9unfh0Z3Pp/AbuVjUMhc09FXZz86F2u9Xxz5r7mg3s3m37y68w24uKUZyqNxgXKJVY4jxH4NiziIXmFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ba978-7f50-41da-7be0-08df1ffa531f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:26:50.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pf68/Rc4XVuvWxYyIq9NEWKzk/QgTpzFqylfXQm1aCEmBCWR+n4qchqaw2T26y7Sdt5JVxEhb2wDYIb96kuUn9HOFqNrW440Il89EheaSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

On 9/30/2026 2:48 PM, sashiko-bot@kernel.org wrote:
> 
>> +static inline unsigned long read_egpr(int reg)
>> +{
>> +	unsigned long data = 0;
>> +
>> +	/* mov %r16..%r31, %rax */
>> +	switch (reg) {
>> +	case 16:
>> +		asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=a"(data));
> 
> [Severity: Medium]
> Does read_egpr() need the volatile qualifier on its inline assembly
> statements?
> 
> Since the asm statements only have an output operand, standard compiler
> optimizations can treat them as pure computations. When called multiple
> times, the compiler might cache the result of the first read and skip
> subsequent executions, leading to stale register reads.

Without the EGPR option, the compiler shouldn't include EGPRs in the
optimization options. These tests are built without it.

Thanks,
Chang
