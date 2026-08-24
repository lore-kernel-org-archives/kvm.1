Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803C3806C9;
	Mon, 24 Aug 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610711; cv=fail; b=tkg47RzdSnJVbNCXawCEt6lNuBTOGTQYpfUO0vo9yTwTDS++itppw+HZP+NtKlPCB4avnmshcA04R7uPhurn3bLw5kyurBsvkP6f6kGf3UIzhdkFTGOpd3pbvPsZ7KWk9DLsZmgU/qtUbA5zv/Rd6PiVoSPAHJ5DPQgZji0vX74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610711; c=relaxed/simple;
	bh=0FHPUOTD5Jq66k5f9LKu1inAnCZ8qSeQT5TKL2oUnh0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ll7O0ty8FFblqV3xNYmYmHreAuaGAuN1Ez0EyiqBI1lLB3E1l7vzZ6bSB4qOYW+7na++BAIX1TLMZl1wh0jX743jxMlPPtvx6onO/iibUdfehbOlFliYWoNTNUH3AqBTcdrfUcz5PoHC53ZF7InPEgf62u+p7TmJwmEL6QTq5Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ukjmp+y6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ukjmp+y6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787610710; x=1819146710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0FHPUOTD5Jq66k5f9LKu1inAnCZ8qSeQT5TKL2oUnh0=;
  b=Ukjmp+y6Y3tTYQoxCh09Gg58cA+gI1JK0jubVTqq6Ee9gRRPU/F27Gsy
   /ptfpJVpj18uwfdL1EV436fgfLnAPw1bYIzgkk2OXRhgSPSYgK8lLL/fP
   /xyr8vfV7EMx+SdO4EgywUHKV3lpcZkEzI7/vYRuAWqZ/jbHO8rKvKQYw
   ea8fwZcHlYMDSrSxIaWy9MA7aqDQI37F00P1j9T0VLg7l/09wjju2ip55
   idNtAtV5IDNFlYfU055/656RkaIj3m39TgL6TNNPChquRzD/nnzBfZx1o
   DizPFaFYUjNnm2uJbSPuNbQ5HViu57ht0EIbp+lFeeNJq0upOhct0mhAg
   g==;
X-CSE-ConnectionGUID: wS1Wr4VVScqcgI6ZeettLQ==
X-CSE-MsgGUID: MauVroXkQQGefxEiL8jyfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98749289"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98749289"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 15:31:49 -0700
X-CSE-ConnectionGUID: Odz6teZyShqV/o399TKkKw==
X-CSE-MsgGUID: 0JBZcsnHQ6KCZCF/Fh7Afg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="263384410"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 15:31:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 15:31:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 15:31:48 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 15:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2P1T5V9hXmXm+BkPjECNLvNo/eOIVmDh0Vt1qnJM+Wtk3bx0es+mjRpNSzG7z6UiAnkgyZfZM7g8iI4s996pE8YqzIhhaoteODMwGxfQ1rKZv7leQd00kfBM4U8EC2wUgH4ceM0No3+qgZ+6pOqQN+B/XMuLpNAFudW4zClzL8x76qc+LTXO0HJ5xUJAQZ38fsaGUy9XkDel+4yv82ekin+Y+SlrolJeb4z3f2ri/Cg6gVMY06OUP3Hcw2LKpw3FJJw9mZXfDiLqWSkv7DQtMGNhTU1WB0M+b4Ki6PmvCS7Xz+V0VmBHTTDRtmV3G4w2kgkdjBeJ1/Xh6IHq2pcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0O1SK2qGvQ73hzMAHuTjSLBn5H8KXWWnClvs47uQnQ=;
 b=ynN2nNMX6iudy/RJjqV3ZPo61RyowjJn/TD/efyOhdCSQHradcDFWDSPHVUcCzpCwkYtJmZoxIS/rwFeYpiMVX8G6nsUIbKePh7K9oWkZLsSnncze4yuEdJrN4AYlCaLq2z8ZU+FVoTan0UhBzwCh0I6ISd0h6bSyQ9mGZj1W8pv21QcoGLXCEfIkSEstQ2cz8MAKmGQRkmmTg2JJUtlWKBF9dYsxqCyq7UdxjAkA+Rv/EhqTcm8cn4uoHV8oMaAFga5luDyLssvcNi/LYtWMW9eLhWfKVjB78hxdYNdPPa4ToV1LH2+56gdtNZzqVT5O8npHpUg5It2SpCXDLHZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CY8PR11MB7060.namprd11.prod.outlook.com (2603:10b6:930:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:31:46 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 22:31:46 +0000
Message-ID: <bed0bce4-1438-439a-9db3-79ac29467e5b@intel.com>
Date: Mon, 24 Aug 2026 15:31:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Content-Language: en-US
To: Shivansh Dhiman <shivansh.dhiman@amd.com>, "Xin Li (Intel)"
	<xin@zytor.com>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <andrew.cooper3@citrix.com>,
	<chao.gao@intel.com>, <hch@infradead.org>
References: <20251026201911.505204-1-xin@zytor.com>
 <930eccc8-23ca-44c8-b91d-3567708e317f@amd.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <930eccc8-23ca-44c8-b91d-3567708e317f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CY8PR11MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: c74356e9-c1c7-43c7-fda1-08df022f7aea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: rHCwSfZq+LxObu4OAPFIQiqJa6FYfmeLqo5QjX5kDQoC7HitGKRuo6GzxMl/tAUdIUN9rbTfoPsOgIFMkAnimJll5bgMoTmfH025iuDk7wAJbMTJG4JUCHRKCKKkBOyYUiNZyuWrG9QBgdjmmmZslKr0lWFqbo+A+6GatMcS+R2jGkYKQeqvNmqLKWwAqimLc0KwOIQ3aw5riAfBNiJuMgYoNrYSN1zHkmTa445cdt0pBVQJZ3tuf3tNo7fXDvb4ztXQgWg8yIlyIwuRyN91SKM1dgYviJXl7a8rwtbp23fahdgMdoPnq/hHk6LEeJ7d9wAp2OGkLDMAeKAglDRecSf/dA8W1sygJnQ7wHeGli6ZYKOVmUHtBZlPpV6nf+UrLzokUHTHYg9WCMPayxU+WFymyH1dO1UkN4vbV7Q2lUWtgvnUu18iz7/Zl097Z9pj/LMV7o+PYv06cZcNNaUvVFaOBA+368kmBwOcTEvFaM37U4ek8U+zUhZr66lnZuTYGJyFNMa0sVOQBv5Wx4/6mMlgOZwYGHdZ5EhS6ENM2JckxAiAUJsPQkWeO9xrIoWQTYrk+Ihah9uCtbc5SBqK9GzsH7pn4jYmokLFhkA4JIK0AO/OWW3sNaJinU0NQVr9O5stuTpU90WbjYZB22gI9kpO1TTf9QClnRLom3g3oN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2hhZUt0elh4SzNZY1h0bXh4TGtSeFBEbERzSkg3cEU2L0Z3NU1MMklzdHZy?=
 =?utf-8?B?OTB2dlFKcEEvYlhSdkpqVTFMRk1UK0E3dXFBU3NnOFZFdkNxZWdmOWZYYUZ6?=
 =?utf-8?B?SzdNMUJUUWZ2THVJZUhWK0RJSVRmc3BnQ0tudFFNa1IyK3JGc1Z5UmY4RC9m?=
 =?utf-8?B?RURzSmovQjRUZ1llRmlJRG5icjdXeEZhamoxbE9XNmhMSXNXQ2JrK3BQK0I3?=
 =?utf-8?B?RDh4SjRFaWx5cEcxZ0lhTkhIZDFzRDI5L0ROZlFpTGwrcG1tNEZuYmpGQWVD?=
 =?utf-8?B?Z2prTmtlR2RLbUpiZE1SeDVXZ1lSeEJtUmJMbnp1cmFZVjFPSmFEa09kTWw5?=
 =?utf-8?B?QXJlSVc2UFpJK1o2YW02c0g2MHlxZVdBUW5mSzk1Rm9OLytEdkxONU40VlJJ?=
 =?utf-8?B?MmxNMXIzM0N3WEJCeU5Xc2FwQThSaVVMMnpGZGhLeFQwQXQzL21LcHUzNCti?=
 =?utf-8?B?cWJJQ3JXVFpiR2NrS0NJNTNoS3NoemFBa3pjYkdONjI4Y2ZlUTNHZ1BSM2Jn?=
 =?utf-8?B?UWVkeldUMjF6S3N3ZmRDSmVOVXAzVXdvOTdnZFFYYzFtN0ltaTc3Tis3OHRE?=
 =?utf-8?B?TjZSWmg0RzRJV3ZubmN6bHIrQnFEaUp3VjVybWZDdTN2eEpJaVZYeUZNK0x5?=
 =?utf-8?B?Tm81TUJFOGZaMWdRanlPWjNuaUh0NXpUWTIvZDlEVVluUjBzZmRvdURHK1dM?=
 =?utf-8?B?MlRCd3FwNDBDcHpJMUxaVkUzeFRCYzdZUnVGbXRZRW9hb0t1M0x4U285azFZ?=
 =?utf-8?B?WXlya2YzdWZZZVIxc0dGdE1OTHU0RkUxdWtoVW9wSnVYODdic3RxNUNOT091?=
 =?utf-8?B?N2dzc3BPc2JtdkxUalNFcjVFSGNKZS9hZjJTN0phTVdiaGE4MmpLVkRlL1Iv?=
 =?utf-8?B?Qk5aUEZiaTc1NElxbHgzaDMzZmpVMFZySldIRzI2d21wejExeDZYRWZpTnVH?=
 =?utf-8?B?NTlGTTlqTmFuY1NwY0FJVCsrSVNuWDNmTXFSY21VZ0I0OERjMUQ2V2drWUJO?=
 =?utf-8?B?WlJvSm1VdkhSNGlCNjdNRmxxaGFnYU8rZ2lGTld2WDQxWDYvNStoT2puOFlF?=
 =?utf-8?B?Uko3dCt3YzhuZ3JxN2lrRlZTZ1N4U21ZMjlnUmJxZERJZ1cxSUhpRThpU2JY?=
 =?utf-8?B?Lyt3aE9GYkpFRWgwb0p6WEFPSllpYUNZeEYrdEJMSFpLZFJNWk15WS9rYmdS?=
 =?utf-8?B?dmpOWGtlcGJHU3J5UUNGek81b042S0gwYUhLMDJaRWpjSTdzR2g1bW9pV29E?=
 =?utf-8?B?Wm1VaGFsZ0prSVlUNVA3U1RuVGV3M2FRdGdqM080aFJ3cnVrV1BiR1NKQXFr?=
 =?utf-8?B?dmVLQkVwVXBWYnlZRzVINUhib1lpVEpUc0NKNVJWR3k0RytDK3gxU1NiVGxo?=
 =?utf-8?B?cktMMGczb2l2cG9qT3prYWI1YXpnU1FlMTRaYzhEVnV6SFREMTRaVHE4TkhJ?=
 =?utf-8?B?VitDcjZoNHc3Yk1Gd0laNHpkSlVVdFYzZ1ZaelU0UElSY3o1NnV1TGoyMENw?=
 =?utf-8?B?SWxQOHk4THhwUW5lYTM5bTRPZm5JMjF1aHN2MUp0UnFoTVpnR1Jub1Q1ek4x?=
 =?utf-8?B?aHRKVkRTeGxuVzJxS1IzaEpPalgxSTdrQjVTZ3BrRkhtVUNYbGhLVWk1SjBJ?=
 =?utf-8?B?ZjNLTTh3S3RhZktJeWJPSis2R3FOUk1IN2U3RU53VTVCdVUyMlBwRTNDTXRj?=
 =?utf-8?B?eE55MkJMUjd0YVlLUW1yemVFN2JDWmF3UUVhNWNUSHhqRUw2RTM2VHJYODQx?=
 =?utf-8?B?YWFMcHRYSWFkUHc2b1pXNFUzQ3pHNis4OEljdTVIcHRLU3ZyQXNnSnQxZzZG?=
 =?utf-8?B?TDd5dFJYQlMwclNEZ1VDUnYyNUpOampEN0kySWxmeHQ4Tk9WRFhjRkNBWmxW?=
 =?utf-8?B?RWcycWI3eXovMXJrS1dMSC81ZE1FVHJka0k3VUYrNHEweU1maFV2d0FNZjIx?=
 =?utf-8?B?R2NyOHhkaTdmOU1NWnBKMk9rS1ZkZTgwU2RYL3RHU1ZsN2l3a0tiUHFHcWxh?=
 =?utf-8?B?bnVydHdNQ3Q5aUx2dGt6KzR3MmhHV3pzOU9vNERpSWQ3aHNrMDNyRTIveWlF?=
 =?utf-8?B?bHg2eTFFUE50d09HdWhvV2dCQ24vYlNRQXVnU0paanFqd2VSd0RPVXlaQmY5?=
 =?utf-8?B?MC9Ba3JYckNyVmNkUzFLVEQ0Vi9FUFY3eUtGM3JUSFhyQ2VzajllWXhOcDNM?=
 =?utf-8?B?M29WRzRoMkd4ZjU5UU5SK2hPeVJaV1ladmJWeCtadXpnYmdMbWNpT2NoV2w3?=
 =?utf-8?B?M1krR1V2ZjBTVU1OYTVDdmpVQ1kvMjYwRlpSRmpreVg2VGNWeFN1YzIwOVox?=
 =?utf-8?B?LzFTQjZtdEErdFRDSjd3OExGUEtZcmNQYVlFSllVZ2wyeXhTaGZtQT09?=
X-Exchange-RoutingPolicyChecked: 2LxKcMa2Ym63FRMVSHkWBzJmhKhqLQ/v7esESq4rHSbNTq+YVZ3dx8L8/uYj0E6Mc+M6NxFfmbO5FvkrAeQngMGXwJje1UOJBR4Py4P922en2ro5bFrJ0DMLk1d4K+q5RUVKlAk6G04teur5ji9qh4y2r2+WWbCQR0VkkhWTmLfkRjCZzyL9R/JqmjfqMHP7fL66ufhnPe0ZsROPPlIWQ+syCgfmPpAqFmm+sgADc0TqHX3an5sFbh7876gZWlqceNzH4Mm0ANeizxdV0hILl+IGIsrOzGcVeVSHUuiAOd6zqlSAsfq5IhbIs44sP5eFd6Lng48kRTfVa06GoviN+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c74356e9-c1c7-43c7-fda1-08df022f7aea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:31:46.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR5DRqywAsLJwh+kNsrnlbISVFlRCwFlDc/gROWpQDLpRA7IOjJbgkZJ+ItWB/Nt6uz/96GK8YJZ8QeKu/kU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7060
X-OriginatorOrg: intel.com

Hi Shivansh,

On 8/23/2026 11:21 PM, Shivansh Dhiman wrote:

> Any rough idea when v10 might go out? I'm about to post v3 of the SVM side
> and would rather base it on your latest than on v9, so happy to wait if
> it's close.
> 

I am planning to send the v10 patchset soon after the merge window
closes. Recently, I received a set of updated patches from Xin
(offlist). I am in the process of resolving some minor issues based on
internal testing and AI reviews.

Barring any last minute hiccups, I am hoping to post the series around
the 7.3-rc1/rc2 timeframe. If you want an early look, the
work-in-progress patches are located at:
https://github.com/sohilmeh/linux-dev/tree/fred-kvm-next.

Sohil

