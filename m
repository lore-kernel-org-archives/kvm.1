Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692F25E469
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066971; cv=fail; b=q6niCLUFy+ZFUX+o+Vey06//s2EA1cJcoJ6T28iD5iKRZfMunrZM9zDfw0X1PhFeigqQ5yYPleADOqBNGqr15hTiJGrcYF1GxFHVbYyPBX6MWAjJERc8Hn6Bq/JpjKgFx7PklGY00B/aae6X1nvmlA/pu/ve6511nMc74QcYeEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066971; c=relaxed/simple;
	bh=cHmKed1G5x+2TApfhUurKVjca4RAp/+RsjKGynTpzYo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TxmKwh0mLfIshJQnB9kAcIKxu7He/jtbg6sr0e/bMQhpz8manZ4rTDyt5FXKyfT39BSgxFepVNQyy1MugCKtGD2t6TqE44S1vMgkezqwHYoIhSi6ClD0yJhl17Zi+xV3s+MXcJG5YEG8Wofc3Uj2dKvH83DeVhppiAkFCuIQ7os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLqD7NWo; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLqD7NWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786066966; x=1817602966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cHmKed1G5x+2TApfhUurKVjca4RAp/+RsjKGynTpzYo=;
  b=nLqD7NWoKCY0YU8Ba1cgqHDrR2LCDJKe5dUeJ1FRVCQyPXbJ1gQ44UQ3
   phK/GsCw/sLhzDV8xCScbePj6s1A7PE1tHuwdN1rwoKTCPjA+U9rvr9NN
   DH1/Ln8rNugZfqmLLbwFL99oa+WA6t7ytLA+bHc46yokCAXjBw0fP7fGX
   /0CZUkv2R/lklpB/CP2fmuAPwoCkJMk7AN/c1rkr99NLC47N1YYyfUOdk
   rO8zEoviQxZZ3xXzZfh/bRkSw7gq8EGN2OnyfKk4cb3VUlzHLOLM/fazL
   Azz4t/DGvOzYMJ1sSbw3IQpZ+EJ9L9IpdFR9JVFkm+Desv+KB5ecVBkYX
   Q==;
X-CSE-ConnectionGUID: 8WGzlvPhRVWCAF9h+/vk8A==
X-CSE-MsgGUID: yHGGv4NvTBSls7yRW4B10g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85795745"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85795745"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:42:42 -0700
X-CSE-ConnectionGUID: iSVifBmAQ4yhIHCMBzV36Q==
X-CSE-MsgGUID: 8dDfv8/fSjK6c/5tjfnjbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286938734"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:42:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 18:42:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 18:42:31 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 18:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZsYkB+rphPjcYrPVHJVLyc4OHdp/d0V3UonP7fx8l8yuWJUeQ7w2kl2G1At8RpWiZSKv95yy4F1c9LEj3A8NkYuchw8CsP10VAXWTOigsxWWad9CTpBY15SLZ5EkMRMyWX8N7o+NVyyzz1WlCa7KAn7eVpPM809eWvX4vonFo7PYNLU7EtfC0SfD2mpbPrWQBZPXrWYdUuLnnR5R+qsX4h9UYK2d1eGcL0i9/qv42kilkb+2Fa+sHfDpFcR3fnOnQtVZzth4088NUh7fBp6oydWASCxUk/1NH6s+wwFo5GKEbYvfM/L1sahrsUJk8vIOXfycR1hv8rwF9CRNUYDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/rzKixfhi49EHtspCRiGsI1KOjcz/j2fh8f2pkRfvo=;
 b=R4Nq3quWEzBs1m0lpGmhizy9itu5LkWAn2aIa0AzNLrzAxaN69pbXqMnBYRPJrsQhMZQufVfbkTsTiQLXbDbMa5AxG5QClNjG9z5D6sQ1u5DFr0V/77bxZRZAqkKWTaG7Yiz8HnqfUO/pWut2LIynmn2D0AxpJ9LoWR5EU9ohigKEoMT3Hhq3iAeg1y4EFPTqudVJmHm9WFNrRU36qvZrn2WaT8JjVTHi5Zu22vDmXmoTcBE9bVrmpbRRGox02AWuNAhent3il2t1ZAsTn/b9W0W9N9p4Keuk/hL+ufLmZmgrlL2VczKXurYLZ9tdGSc+K1lnIoqM7EmoF4ybzmwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 01:42:23 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 01:42:23 +0000
Message-ID: <cc0d6b41-7e5e-438a-9129-b71cd16be354@intel.com>
Date: Thu, 6 Aug 2026 18:42:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com>
 <20260806015225.3A1641F000E9@smtp.kernel.org>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260806015225.3A1641F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CY8PR11MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a3ec6d-266b-4ae4-cef3-08def4252075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 4NEBye4ag/zHboaXXTYx7TxD5DV/aXXnH9cntjmPQf2iVoMRtRD9OdK0ZGtEiE0WZRBkfql0YryzOah6u4VqP3Ad2OKccYTADf6xyuLhXMoEea2RdogRij6O6B5+AaUmW9VPZ/b9KNZ3bfvYHL+SrwZhjZOCl3HIVlNy+1AavmsArKwxXoXbQWx1nFZThxqXhUFnJ1s0dxfajmWrqN0rgrifzLHcXeI7HjyaDjKS1QxCr9uvSSMHNEDRhdoYP8e5wH3/RtkW73Etihv/loc4u5fPGMJIU0Bu5iTzbUePUbDsrs968XkW8OwFNVav7111wUuaLhmDlc685uTyjFgtRWngj6F+XTFt7qXvxHmLngVbI4BXAv6EGuz+qUZhdww3DSpzk+BO1ac5+MZRsqqLsMIey8qc2TnCbIOYhPCz+GFgd29159j1WghDrO2/NMhDXadyWUFBQlBWNgAzBzHGRbYBusF31WnHZ1u87gVIERRdehHT69eT9viPxgCJy8CeHQGmmRtlxDpXouaItxzHIgM+P/Y04jc/t3yV0x/heSwefbWNHWEWfyi0u3yAtVOjcv1GuYiUJUK7VNrAi3oxjFP+FYploLTQORPvfOjETh3f135jiFGRt/Iz1oOcIJCXbhdWbi8I1XmsfqBfzQVRIw1cHeFa5HtWi8q33s3HMJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBJZTN1K3pPYU8wRDdqSG9JR1JNL3daMy9YSTJSb2hzNGlKby9Gd3lhUzdD?=
 =?utf-8?B?VlRMeDlZNDJybGIwendYb0F1NFN3TmsvY3ltUVJQWHpRbkh0Y0NKVUplbVh3?=
 =?utf-8?B?elZZaVZVZGJWaUJZQ3lOVWNuMWtZcGlubUN2c3dSU2dqMFdpY3hWcTFmaEli?=
 =?utf-8?B?bHFidW9JTjBGL3pjMjVoTEYwQkllQnYvRFV2b3N0QitPZ1hCZ2VmK3J5NEZF?=
 =?utf-8?B?dnFobUZacEJSR1p4Yy9tT090WlZOZDNpNFJBREFIYnpPNmFsQ3lQUHE2YmRo?=
 =?utf-8?B?MVhhYjJXTjVjWTU2OVp3aC9vUm1EN1ErT0VYWVRESWlTVTNSNmtQYXJVOWtk?=
 =?utf-8?B?WkJ6K1V2UHc3Z1NhMkxpVkhKYnhtWnpxQTVMS1ZhRGJuNkV5ajh0eTRTOUpl?=
 =?utf-8?B?Mys1MmZnZHJ5bkRqbEY2TjZUMmlkaytkeHRlS05sQlVnVkVySEpaWGhla1Na?=
 =?utf-8?B?ZVVZWXFIazJMQStoOXJadXlMbVZGUmpETG85RHZ2TWtHNWM1UzRWMjJBdDRh?=
 =?utf-8?B?Ym1QMTVPc3BjVlEvUFZTZUxLR1czbG9nSVVHZUNBMjV2eXpYbjduaVdNak94?=
 =?utf-8?B?TWZxdGVmT1lWNHk4TXVlbkQ0WFBHZkpJdS9PR3pqeEt1c2RXREtFNG1NSi9M?=
 =?utf-8?B?aFFucUJvZHZ2WlMvS1RyRUt0YjlUNXFEb0RvYXQwMG1GSE1kVElhaHJpTWg1?=
 =?utf-8?B?RzhCWXUwUk84S2N2bHNWeEN3WCtpRTB5QzZ2R29JQVF4LzBWZlhHZTMzMzVi?=
 =?utf-8?B?RmtOWGZra1FQMXFOK3JCRDhaV21jM2loTEtnc2VXZjlUYTdPWk5rUHNnSkVB?=
 =?utf-8?B?RmNOOGZJQkxSZndYVXhJVGhWbDJDRWxyc3VGQWxlT2lGOVpOeEs1Q1I5dUEy?=
 =?utf-8?B?eEdQdWFqaVJoQURBQnF2dWsrQnRRcTIyWm5YQXhDdHNMYVhGYnNTQnp4UGVm?=
 =?utf-8?B?WUJyRWNpNHV2NGowTWVZemsvc0diVlhxQ2RSdE9uaWpYM2VueTUwVmRDQ0k0?=
 =?utf-8?B?RWllOTRaRUlvK3hSYjlMQUlUNk1mK0x6aEM5MmRScVdzNlV3SlJUa1BzdVpR?=
 =?utf-8?B?SVBySkZoMUVpaW5DOC9zKzhQdm8wVk5GZDJ1WjAyYlJJRUJmKzNYS2NiZjZI?=
 =?utf-8?B?V0o2V2xXa3djUE8vdE1aRkFOQXZ6cmJUdDhHM1BENkJWWHFKMEdTNjVNelRt?=
 =?utf-8?B?cjl0TEErZFk4NFFaeFIwa3pIam5yOE5BRnJNS0ZHYTRzWW04ZnZNS0ZrbVdq?=
 =?utf-8?B?L25STHBRMmRrSUJCWjhzRWRYUDhzZEtpa1llbjMrMUt2cUJ6U3lrVHB2MUtu?=
 =?utf-8?B?RkY1V0FHUjVWWXBvMG0yRFI3S1hzMzFsdFZFb3l1OTUrZ0pVRUlyem1GZnd6?=
 =?utf-8?B?cEdrMGVkamdkSjArcFlRRjVtNFhMeENOUzFrblBHYnFsVk9sR0dmK0pSQzha?=
 =?utf-8?B?RnJKaDNKTFgxM1B2cHNabHEzSFliNHNkQnBpaE1BWHdDak5sdGFJazR1eVhS?=
 =?utf-8?B?VURFSW0yeVI1N2duQ2l3NzMvTWswU2lQYU1BaWVGY3M0dGZIblRQQ3ZMRVdV?=
 =?utf-8?B?K2E0dG9aSUVVbXdtN0RIWkEwUk84TnBaMzNWakJXdnZ1OUxtVDFKYjAwVTRp?=
 =?utf-8?B?UWdNeG1vT1AzUVlwbUE0bkFKc04xbys1UHVFUjVFdE45RlpxYU5VVGhiV2ts?=
 =?utf-8?B?aWpTR2JFT2Q5ZVg5QTIxTTFNOVFUSXVySEVGdmZnRStVdDFjZVF3QVVCNTdl?=
 =?utf-8?B?T3ZlY2FFSnEvc0I5SjlhUDJoaGNBUWR4QWtmL3RzREdSNC9zbS9aOGVQbWpz?=
 =?utf-8?B?RGdTSm5NK2JyS2tVenJvYVpPV1Y2ZDIzZXJXekJzeU9FMmhoU0NaQ00wNmE3?=
 =?utf-8?B?VlNIc1hQcnUwY29XNVFXWjNra1Q2eHRwZlNzVlFtZmo2RUxlaUJIOGIxeDE0?=
 =?utf-8?B?a2tjajhJakxvN3FqUGpZUk84V2NFT1JtYXpXQXo3SWpLV0pjVXk4cDl3ektE?=
 =?utf-8?B?bjVlL1pRY2dFa3hrNnBtc01aQU8zRW5zYXJKSytUNkZFc2pldndHRnZLUFR4?=
 =?utf-8?B?TnFiZkJVZXBPbjhGNVVaNUMyYUt1V2taaFZDenJGaXJYN2NtRUZQZkp5c0lP?=
 =?utf-8?B?dFdKVDZiMWQ4bHNUVnFFTy80a1psYjVmaHU3aUhWRnF6MS9JMm9pYzJXUWlo?=
 =?utf-8?B?UGMwUG5HbGljaVpRNTRiVUZIaVg4V3BLcTYvNXFPQ1MrUGdFMVY5Tkp4REYv?=
 =?utf-8?B?bEN1MG1URHNyT1U4Tmh6TXhXRVlJcW96WGRxQTc5Z29MT0ZOTjJPN0xQbDdK?=
 =?utf-8?B?NXMwRXB2dWRXV2dFZ0dWbnk0SlBEaVhQc25Uc1djT1JyaTFmQlh3UT09?=
X-Exchange-RoutingPolicyChecked: boMqk1/4l8htHsgPCsQTarp54fcqI7BH+fJGedgsVnn5VMXbXy2/0uclXhruupIA2TNT2mjjqBs6ZpTMO3T+VLeZzRm7n/xIberFcKWtoUOConTtHioZgH7nWHU5bK4V88s7uqF1T9ychfIkIjU3vkUDPfmNCsO7znRh/RxO48jsI3q0y8fCzczbCNE+qiZNAVbjIpBymJ86ieGMU00kJJfuc9p3uAzi52Xpub4PkMpfm6SI+aAwcURhKAPOcaYIp8CxfQvMEi8GT1wClkCfirA+Hv1AW/+OquCSY6BNRPwmdfi5j4ZDrQ85cX5bC95y3N4vFTCGEPl8GIXoPn+6Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a3ec6d-266b-4ae4-cef3-08def4252075
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 01:42:23.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKPEAAF+BS6+oTe/vnqYbeHT74RneIiHutHYQukyRFwsl8gj4O3dqltgqKXqLqMxOXpLeiEGGzqJhX6dyJXJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
X-OriginatorOrg: intel.com

On 8/5/2026 6:52 PM, sashiko-bot@kernel.org wrote:
>> @@ -8604,6 +8604,53 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags
>>  	return (sign_extend64(gva, lam_bit) & ~BIT_ULL(63)) | (gva & BIT_ULL(63));
>>  }
>>  
>> +bool vmx_is_lass_violation(struct kvm_vcpu *vcpu, gva_t gva,
>> +			   unsigned int size, unsigned int flags)
>> +{
>> +	const bool is_supervisor_address = !!(gva & BIT_ULL(63));
>> +	const bool implicit_supervisor = !!(flags & X86EMUL_F_IMPLICIT);
>> +	const bool fetch = !!(flags & X86EMUL_F_FETCH);
>> +
>> +	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_LASS) || !is_long_mode(vcpu))
>> +		return false;
> 
> [Severity: High]
> Should this check use is_64_bit_mode() instead of is_long_mode()?
> 

No, LASS applies only to IA-32e mode. So, I think the is_long_mode()
check here is correct.

> If a guest is in compatibility mode with LASS and SMAP enabled, a compatibility
> mode application might trigger an interrupt resulting in an implicit supervisor
> access to the IDT or TSS. Since compatibility-mode linear addresses are 32-bit,
> bit 63 is always 0.
> 

AFAIU, in IA-32e compatiblity mode, all the bases (GDTR, IDTR, LDTR, and
TR) hold the full 64-bit address. So, there isn't any truncation and an
implicit supervisor access should have bit 63 present (set as 1).


> Does using is_long_mode() cause the hypervisor to erroneously flag these as
> LASS violations for supervisor mode, breaking 32-bit execution?
> 

...

>> +
>> +	/*
>> +	 * LASS enforcement for supervisor-mode data accesses depends on SMAP
>> +	 * being enabled, and like SMAP ignores explicit accesses if RFLAGS.AC=1.
>> +	 */
>> +	if (!fetch) {
>> +		if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_SMAP))
>> +			return false;
>> +
>> +		if (!implicit_supervisor && (kvm_get_rflags(vcpu) & X86_EFLAGS_AC))
>> +			return false;
>> +	}
> 
> [Severity: High]
> Does LASS enforcement for supervisor-mode instruction fetches require a check
> for SMEP being enabled here?
> > According to the architecture specification, LASS applies to supervisor
> instruction fetches only if SMEP is enabled, similar to how it requires
> SMAP for data accesses.
> 

No, an SMEP check is not needed during LASS enforcement. The SDM
specifically states that:

"LASS enforces the equivalent of supervisor-mode execution prevention
regardless of the setting of CR4.SMEP[bit 17]"

"A supervisor-mode instruction fetch causes a LASS violation if it would
accesses a linear address of which bit 63 is 0. (Unlike paging, this
behavior of LASS applies regardless of the setting of CR4.SMEP.)"

So, an SMEP check would actually be wrong.

> If a guest OS running in 64-bit mode with CR4.LASS = 1 and CR4.SMEP = 0
> performs a supervisor-mode instruction fetch from a user-mode address,
> will omitting a kvm_is_cr4_bit_set(vcpu, X86_CR4_SMEP) check when fetch
> is true cause a spurious #GP fault to be injected?
> 


