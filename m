Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4F3F7AA8
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886433; cv=fail; b=cSm8C65UQkqZmTaHrsXHCIb7Y4D6s6zwHNK5L4lVYQTfQhWBUi0yUv1Qi8hKXkJQjEp/l6Gx5ACzIzIJfb8whUQ/OKeqstAwU/NBOBADentzk4H1tOhOEnmONbLhBJC4Rq9kDXgYCQwj/N+xBfs9ZOkXqXSvtPX6Ij8f+S2nGyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886433; c=relaxed/simple;
	bh=FKe/AnD7rGW5tIcYKq7vazGqkhPDVsX8qZ1JZPoUROE=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PHULn9TIyY1WUEaPyrc731VMvSL+UBBn4Wf47aMz2HJ/I2j9ax0rR5Obp0F6gyIDVG4DTYD/MVYourmSZ4xIknjhhcJYk2UbbjXh1B8dW0ZWqHLU8vu2rq8A9xMRqP96pXJwDKNOIxo1VmwBGRluDD3xDKSWbQ7Jdz4gkJ1G0Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxyTcNJJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxyTcNJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886431; x=1822422431;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FKe/AnD7rGW5tIcYKq7vazGqkhPDVsX8qZ1JZPoUROE=;
  b=dxyTcNJJqHaES+Eac1KY07rqK8BqCV6RpCCiqvn0zSZMSTisSPyWGmOP
   P/TTEX8CvIsvl+UColygtbFpBK+bf7BplETFRFTBVOLbkboSvL0J4+z31
   wlBPyw6CcUPIwfaVIHTo+b/+2K3MtPL1LkNsji8mViJZ7VbKuhTU/Ticg
   SXpDjKoRQeyVC7VandnhfiaGHSQt0ijPhEki6o2tO5cuC1sMS/h98jQLC
   GC6QmcsMvxGXDo28sIMNTMQyZ89DCMUP4utbZXsmxXys5exykYtkpaWMY
   vCGOpFkgBtHZa1wmptxxg/g1oUjzeYsdgHVMDVj+J/T/6H1TdSJE9ChOV
   Q==;
X-CSE-ConnectionGUID: zQOoSzAvSiO7fZYtz11ExQ==
X-CSE-MsgGUID: ReAtjhYoQtCfRSmEJyrtKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95467296"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95467296"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:27:10 -0700
X-CSE-ConnectionGUID: nUSKHPf+RuOplHUSDR8lHQ==
X-CSE-MsgGUID: Qyt00bazStqNA2mPxBv5mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="273900791"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:27:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:27:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:27:09 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAYt87AzT+hv7t50WaZYgPzl+KNMhEcGnTeNysWFjRz6uxF5N+LgP6CjLlviyzkkRovfaaWY2aC1//BYk5IrEp7pXmNwTZV/r7wWROOmjUCuoKsn25TGXUyu534xVhnZnalKIUcE5mJMfRfFxSmHG1PIfUq6hPV4QdeLn55p/hsb9mijRuGpCtqgu9cZqtcQETiJJiWUGFl9dh+mK2ho+vvP5C4ETgu/M7cwdYA2WRdWmOYOgdL/P+Gvf8bBSUHq8cp3fj6HDeua9wisijHeUbbhfV1FvA+6oxp3HHurKsqSGN2p+tMzyq+OuKeu259JnjP2x+UMHN8DB6OP2RBBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejZ3MGQ4M9JrYcqBHcNEyU4SUIES+KP8vhk1ttwSvC8=;
 b=ngPsTCFZeZ1VtULdpB/hX9pmOOYx6IbxDmnzKBKERXVJzw7jsPgWyN1TX4BBeTl8mkPMG1HAIG37sJzUw7ijE91TRiZYNAIan49emU2Nj9cdTq9mWArHfzjWUtKd/ZdYeNF1/ufmSHRdzLTtQyXRHccuPQ3kXNsZBWaBowMpG0ZAYjjA7UPBJYP2TynAoWtnDcllBPi+fftRtFHmv0sqx+jw4nrIZyO27N1aEHlYUIimcbDzpjYV0P4S94zCUFzZB221XEEzlgzWjB0z9XW5x3eV8hmgNqSm4l4AiPMc47GSY4ZTnJZFqk6qTbX2c8d56jgZIf0isOcTfftK3MXmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Thu, 1 Oct 2026 20:27:07 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:27:07 +0000
Message-ID: <2b4779f4-c3d9-4b58-bc97-f31dba58fc7f@intel.com>
Date: Thu, 1 Oct 2026 20:00:13 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 18/20] KVM: x86: Expose APX sub-features to userspace
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-19-chang.seok.bae@intel.com>
 <20260930214337.90CD51F0089A@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930214337.90CD51F0089A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e1f0f2-6fdb-46ef-0a96-08df1ffa5ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NuyDwDJNUWxaa1tBvsiG6ve7MEkET9GZptbvmMEKaPOKPIIiAQ3hlZWTq4Z9VeVzlpku2O1mMLz2ycsanSt+SipXxNB+ik3u3TPlanHwyHqXedY8vIqo4bi5zT4pGNVoSw0quSGeJGWqwpkE5bIfQPYcVEcJ1oKc4Ao7lB3pgpD3b2PqKJTGdAswMxcn0CfarSpd6wtsRWlyyL4wbuTIGjtfhVcwh9xrATHBav4ITDECS07y2vxZ8QkLfYd6KNTvWsEltTx6WgQAoDTnsHbRHKXrmk+NG9g1Enx8lF7z8An2A0vQjkhJYVt0Yg/UpGSuWrp4YU8BVB+GyAhcmTkth0O7lyuEAqrg6muvoQbHyBCpgOUU34aABoWZyc+gKHREV7kZHC+uITF52FYj1GZO6IziqP+U7ruU177R8hHOiGWzj68BGRB9XqGAEnikXu0bR2OHDw0B0T5h5ZJBVz0MefrVp70lGd89phUjkDHEfYM25MrqgxG1DF1aGdwIrzQjStfISLR5WG+Os6RYckeFu7yPuPybmA7+bz17R8JjqeswYqqcKMSyDWrykG5FHDNRspFyT6gJsk0xI4Q6/3uS+ETg/RSdgvyekLH4R8/9kB3NoIn/eiKeoiCRi3UCkXzp/8ACrpbQu3Uzts5tAKKQFIXAvQjwHbw32EyytqbpyfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dQSVR0VitrazVTck9GRUZhM1o3Wk5lT0lxdm4wZmptYmtNQWdYbnBCWlZM?=
 =?utf-8?B?VFM1NjZUR3hwNmhqa3lwM3FhMU5TeGxJbExQNTh3aW5hUyt3VDZmTjl6YzE2?=
 =?utf-8?B?blpxRS96T1h2ZjVzb2xwdmRRa3lsQ1RlZkkwT25PVktFendXRGtFeVFoTWNw?=
 =?utf-8?B?MFVEbnA5SGFIZWRvb000NzhwQ3lXMVBEeFBpVnJHRGw3Z3R0ZVYxOGlMWnk2?=
 =?utf-8?B?R3Z0by8xaGlkUWJTYXNHWTNoOGdjZVNWUHZ2Y0VIK2kzS3JwU0V0RUthKzFs?=
 =?utf-8?B?cnZLd1FLaFRZZXJvNEFRQzJFUjEza1Fpd2doNk1QdDJORnN5czZFaWVHdEtj?=
 =?utf-8?B?RUw0RWlsZHhGN3J1aEdwcGV3c1N2UU1yQWUzdFFIZTJ6U3FMQ0M1RWR3NXdk?=
 =?utf-8?B?ZU44TFdEQmNzTWUzTEd3Wmlwc1pGVkZSRFBSZllzTEdCelV1RWxxeFMxeEE1?=
 =?utf-8?B?UE1RVlE1QW9FOSt6d1hKZXdMcTZ5bVN5N1h0UmlHZmdtelhDYVNjOUlnYWlO?=
 =?utf-8?B?eWFVUlI2NlBtMkRYTC91UnJ4UDJYRGp3a1pha3piSXcweE5UZlJRNGlHRm81?=
 =?utf-8?B?OFB5S1FSRkZ1OUVNc1U4WHkveTJTeVVlQ2ZuTFlUVzJKV2RZaVBVVWI1ZzMy?=
 =?utf-8?B?TXVPQktaRTF5Vkl3K25nRVRHN3hEY3l1QUpxOXJJbjNqcHZ5Y1RJcm5vYzFt?=
 =?utf-8?B?YXhlWEx3ZmlKZjhsMVNJQUVwS1pYOTdzbnVVc3Z4WkNITEZlZnEwbW1zNHBz?=
 =?utf-8?B?YkVIeGgzMlVENnQxMnNMMFczL1ltakNjMm1HSXlpOTcvQkJzZXRQbXVrVUVi?=
 =?utf-8?B?dEcrZU5HUDdmWXErVzBGbjBxYlRybXNWc0NzY0VzUS8vY0Yxekt1NFBmMnNK?=
 =?utf-8?B?Z1ZiUDFKa2F4Tk02ekNUY2lhWHhJd3NOazBPcjcrZnRudkRlMnZLK2pldmZo?=
 =?utf-8?B?eHdXRmJyaHVTc1M5c0I2b21ncU1FdXpSUWVGWnI1VmtqeW9Yc0M0SGswdG9V?=
 =?utf-8?B?SlAxREhSTXgzcDJ1WUhrUVRCeFJFWUorMmRWR0RsVUp3R2dIaDBZc0RYSXpy?=
 =?utf-8?B?b3lVNmVZUEhXTUdXWUp6bmpSV2RrSmEwQnVIR3R1YWRlVWlIV0E1K2JSK2Qv?=
 =?utf-8?B?d2ozd3FGODhXeXplSlF0VWF3OEl1VjRlMFdBdmRoVVJLeE9PT2NRdFJGQ2c3?=
 =?utf-8?B?RVhmZW81VERkYUY2NGk4RWk4K0tUNWZaQ0hRTXhYS3QwVUpLeHJMRytoT2dj?=
 =?utf-8?B?UVdzN0RLUnkyM0ZYTGEwR29Oc2tCSFpuL1BoTmhUa3UxRGFYSlZrcTZ6VzJz?=
 =?utf-8?B?SWZwTkpya29yYlhqU3ZvOFppMC9IRlNuTmVMK29zaElRZTIzS3ErUU1JaWhX?=
 =?utf-8?B?a0NzNHlzUUJNOEdCUU1DV0dXemRLcS9xbU9vRDh4UU5GaGNuRmQwWkJ2S1Fa?=
 =?utf-8?B?MkFoWkl5RWpVMWpLalUyVzFoMW1mazBwbzdmQXdMeEJLVGF1c25CTE9ZK3da?=
 =?utf-8?B?NnJDemlSaHl6WkZSRzdKT1AwR29XVTBVamF6b3llSFFDdm9ad3UxUmFPYjRI?=
 =?utf-8?B?UGdzNjh3VzJRRjFjc1Bzcy9HdFd6WDlNWXd6ZW5RZldGb0F5dWhyL2NEanpY?=
 =?utf-8?B?Y0hveXFMVkFCNEhPYjN0N2VkS083Y2I1QzFGam1udWMweHE4QmRLRFhtL1c3?=
 =?utf-8?B?TVZJTUtiMFhpdkxacGJHSmRHd1pHMGc1STZVUGNNS0NCV0htUTQ4NS9MSm5R?=
 =?utf-8?B?cjBOT0ExZGo1YUpWMWo3aE0zeC9laFF6eUpvTzArTFpwWTBmM3JYeGd4Y0pO?=
 =?utf-8?B?bFBXeWxyWFlhOEo2eXhOMzVBb1puMURvc1o1eFlUaUorNzUrY1hQbVNEdFdj?=
 =?utf-8?B?SGVNOGpBL2MzUE05dXdjWHFIcUs3Szh5ejB0ZE1JOUd0U3hOT3NDYlNFY1FB?=
 =?utf-8?B?WmxHaHcwNnh2UEtsZW1GeStTT1AwaWcrZ2VUODFsMEczOHRqZitPRHN0bVRZ?=
 =?utf-8?B?ajFmdE4wcTRYUDJsWDhvcmE1ZElxeWFhYUlhUjVKTTlLQmtaZ3ZhblJORGlp?=
 =?utf-8?B?R3BvUzVoZHlicERweFRSTE9XTGg1cCtQd1VWM2RuNE5uL1FqMzc2TkhhaW1z?=
 =?utf-8?B?ZjI5UDRLMkJjMTBVM3FLeUdOOUI5UXZ2YmhoMG0yaTJKQ1N4MTJkaWNiekNj?=
 =?utf-8?B?UjJOYXprTFgrQWU4RHJ6UXd6RjNBZ1laTlE4T0pDRWtpQkttQjgxOThrcEVI?=
 =?utf-8?B?WERjemlVZUExeFJJd3lUcnZSYWs1eFhKS0luQ3VoRkxiSFFub3lvN3M0emtJ?=
 =?utf-8?B?NUVVdTNzbGsydjJmclZaQTA4aWxBTXdoTTZRMmRrOExCWUlvbUMydz09?=
X-Exchange-RoutingPolicyChecked: EKFK0U1yAq6dxx0lwEN91B/Qk5BRUcePwquGHWQElqC3ufvxvRD9xoNPng39q8fvvtY0+sLruCLaC8Z+1l+xGt0EUDBTyrrH0UzbqIaxhT9KU+7ml/zfulmgAErQ4P4cUhGQHGKOB/5z7TA1Gy/QyExc6DQF/7XkprkmG0rAAg3EWeS1Qtzf63/XAU94oFvek7mMnyph+FmpLmMeKRj8XkAI2tfX373lI0YSacTI4V+N8Qv1AjfzC6WX/taIIheUtyoig6gHQRBvJQTK1WYwuVvP4J+ZisNXvvo2N5lTNGaVF+iVOhj4woeUg5hmmkbk306Wa3+H1dS92/3ul6dHvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e1f0f2-6fdb-46ef-0a96-08df1ffa5ced
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:27:07.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apm3ClIpbtIAXzzota4avLfYGpRn7k3UB9zOO+IitnY1IYoqZ9TOqMEgyZXEZqg8X4H3Fq8x1rW7fOgrx7D0Tt8oiBk7+qCgICL0g43waX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

On 9/30/2026 2:43 PM, sashiko-bot@kernel.org wrote:
> 
>> @@ -1733,7 +1737,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>   	}
>>   	/* APX sub-features */
>>   	case 0x29:
>> -		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +		if (!kvm_cpu_cap_has(X86_FEATURE_APX))
>> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>>   		break;
> 
> [Severity: Medium]
> Does this code leak unfiltered host CPUID capabilities for leaf 0x29 to the
> guest?
> 
> If the host supports X86_FEATURE_APX, KVM fails to apply
> cpuid_entry_override(entry, CPUID_29_0_EBX) or explicitly clear the
> unvirtualized registers (eax, ecx, edx) for leaf 0x29 in __do_cpuid_func().
> 
> This could bypass the capability mask initialized in
> kvm_initialize_cpu_caps(), violating the KVM invariant that new
> guest-visible features must default off and be explicitly enumerated.
> This might break capability negotiation and live migration between hosts
> with varying hardware support.
> 

Leaf 0x29 currently defines only one sub-feature bit, which comes when
APXF presents. Additional filtering may be necessary when more feature
bits are introduced and then filtering becomes more necessary in
practice.

Thanks,
Chang
