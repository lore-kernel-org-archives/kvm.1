Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764A4AA027;
	Wed,  2 Sep 2026 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378442; cv=fail; b=uhavMxsLQG3dU/DUOd1boXk+nDOoUSNGhkFSDljO5Gq4ugx0UW28O/jb/6gWFVmoC3c4TuQXySwJEXgxnX1JTCFTUaHXhhQN4JT22So51OB53vwRXLk5GMcogcDJtfEpdcMaG8O9Z7m4dNIt8x83UzkN3TB/PrigKJgO1d5dLCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378442; c=relaxed/simple;
	bh=3TWowdNprgEzm7ST8mTgcrZplnBDWX0EFx2yr8ZE4f8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oHxXWcIj1UHjETW/nbPZbjknzgJKKfnvvRVcoKja8rxxEpCl8tr5bs6HdEvjEQA+sYWRlGkcbPFX7AbJA3VhpNsvPDKNAYP3AeLzFcZjp5VTLfWc7ztzd0slWm59W44qezCIHQYQ8gcgzTb8GofSNTW09rjO0jXVKW7c/GY954A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzRTV4P3; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzRTV4P3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788378436; x=1819914436;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3TWowdNprgEzm7ST8mTgcrZplnBDWX0EFx2yr8ZE4f8=;
  b=MzRTV4P3dhNkbMAxlaKUDPR/O4E3EkFygr/rlwZFuave7ETJnJOMbG4u
   uD/AhYefYaV7M34ftl4o/PpHlLIuRc+wAGJzAMsKwZNYiKpiA3WAJbOsb
   B+w0M6W5vgXmIbIJhsK3rW2MGc3fnfbTpADXKzvYsEPy0xy2Mw/YVN82J
   q6EDM1qEbOjMRNvc24L4ErAwnrMADJp3/dgE80xJRYDos6ur8xa9Mch+I
   S9cHNnrPb2sE8Ijxah3bGs2CPRiu/c9JtSPXfyK22LqNF87EtDwKKpSQk
   UulRzZPwiPIh9y2e4kYUb0rK00Y4OrQaS1jhURjWT+Z/DxZgw83qLCKad
   Q==;
X-CSE-ConnectionGUID: 0yT/fx+0TC6Z4bQSnJwXyw==
X-CSE-MsgGUID: lVwZPyE1QjuiqwWfeOtIWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="111623036"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="111623036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 12:47:11 -0700
X-CSE-ConnectionGUID: OMnS8m09R3uPeDon7Wl2Ag==
X-CSE-MsgGUID: 6+50hmiUSZOo+pk0s1Htsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="266264055"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 12:47:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 12:47:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 12:47:09 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 12:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9rr4ZN0teDG0BnrZYpGg5clXmmQ4m7Mo55PfYYku/nxKTpjVZHtq32ZG4ni+25F0NLZVnHMu+IjqI+WOMJU4f3ssqgHHpnrcYufiImX62UQAso+1rDoqJvLBheWCuYzReeOYrvNAnCu3VhKOTmS0rS0qVpsPNSF6eyDf1rUvJgRWL1wbdOOeN2rxvrBcGiwlKgMWCnad06xbVFcb1YSi7fhzMVT+98fioMRkXlwXTjUSUhLKAEUa306msjAmjPZIN0VXMlpJe34AU6Ml0FxVBt7wof6lmthrQxTin88PqV1FuBMfzH9I3B8gq+jdQVvyeYieFEUdERQ9BfJgL6wIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwTI+AVoRZtPrzt8PfVJ1WVjMLQ9qzHndbu/GwjMWn4=;
 b=LZmT3RM6GOumwW5BTrL8P9FMz5W5IdkkessFctDgR/WQl0LDh4qZeVR06cNDPbctxeLv54+loiz183ldGRq263dqveZGkKhPNYYlLX9Kz6sdV726xVQGTK4JyjhOF6U1MOEi5eQb4Xjtuf8UqdIjEEvkL0iZ9ieKS6qN4rxOmPlvHHkQjUmCyflqxLry9FCrxGWfM08IZl0Hl0c40xXud5dOBlstMEtapFbStTfuJ/WmaaBEayFEzGal7sbJa0b553oJYA5jNOTDogjsDJeTV7n8XuJ5SmlSl75hFD1v5SMc9mw7N5bHEKGsJ/LOYOztG9RoADVYOfr7L5JJcWQP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 19:47:07 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 19:47:06 +0000
Message-ID: <649c7d7a-f042-4fe2-a3e8-eb15e4d76a46@intel.com>
Date: Wed, 2 Sep 2026 12:47:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/26] KVM: nVMX: Enable support for secondary VM exit
 controls
Content-Language: en-US
To: Emily Ehlert <ehemily@amazon.de>, <xin@zytor.com>
CC: <andrew.cooper3@citrix.com>, <bp@alien8.de>, <chao.gao@intel.com>,
	<corbet@lwn.net>, <dave.hansen@linux.intel.com>, <hch@infradead.org>,
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luto@kernel.org>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <peterz@infradead.org>, <seanjc@google.com>,
	<tglx@linutronix.de>, <x86@kernel.org>, <nh-open-source@amazon.com>
References: <20251026201911.505204-19-xin@zytor.com>
 <20260902142336.9955-1-ehemily@amazon.de>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260902142336.9955-1-ehemily@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 10704fa3-0c37-4cf3-b1b2-08df092af813
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3IiMK2R5TdsYN8E/UhJFxrNCnGDcGQpoKSTESrK++kPFTZwcomeiondGdQc1XQVGrULFAcG3323UycXjEtoUR3H7NwfxBjprFzsCX0e+VWb2ttuteUoWXGdP26sECEyo42RG1+Yxo+n12kzAPB6st5F8CMujM/71mPrcLZncpQjuIZwqTp6v9t2jDTdQ2uK+a5+gjBuWiqZC92FISwk3zSnV9ZiS58BG5MWrGDzS69mQSs/1gZigr6pUjdnKW3BBC5n7kFhknQLJyb6ouRiCHN79vJHDSsHVILy6t/d4Uy+Kh9iBvInQBmaDkWYdbPtUj/w8VZk2Z/U8h3lI32pX62OhcvVx7of3rMgovaH0++EClaRkuoYq+QkI6x6ra+YxT+272Et9ik21FUm9nAm3nLLUhYjr0OOoNrpa65nHBbbeK5A3gAOWI5FYtEJDwoSMUWtvx4UBSRMEVcxIFG0Utxg1+v57tqM5H7gVX9jqSa0UKEj2vOTDo0yIUXZxzOjWiXKg/Ea1VbpDApUa3tbhtHzrrDUmGNitRwOzXu7Gfnnu4ZFxgaomze7pgtU4rzgj9xSpEe35g13K9Xa/Exr9TfjIi0e1qw67oPghOlH1JbtilLxkqAKCXbDHpbFcXuR3M6Yz6OqFibGq+SICjSq0t8MFdKP8HdfcO14/8ffAIec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blU0Z3FjWlRpcmJqd3ZjN0EwMmlSckNLNmdTbjFjV1cra2VFTDZjR2pWNEhl?=
 =?utf-8?B?MWFINkFaNDlvdnphZVNWdzl0YmhlQmZmcldOVzM3QkZyTXArZ1NlbEl1MEt1?=
 =?utf-8?B?Sm80R2dTL1ZnUWNDSGpMYVhXME1Da3JJQ2J1aXEvRGhwNVoyL2M2RmpNdWU5?=
 =?utf-8?B?QWJKOGNZSXgrRThXSXVQUHBxbEJUOE8zQ0RRVFc0eTloVWVEM2E2UW1tdzU1?=
 =?utf-8?B?bEN3Zm8wNXJMV2VhcGw4eCs0dG45UE84RDV2SE1xYnlQUWNJdWVuOXhqL21R?=
 =?utf-8?B?ZDUwSDEzOGdWTm9wRi9LYmMwS251QXdKUXMxS3Bwd3lIbXFkTTNJQ0xDSmhY?=
 =?utf-8?B?YVl3eEExaGtvUGFxWnFBTzhLeHVqWU94WWp1ZDNpdXZQY3k1K0pTVmRKRVll?=
 =?utf-8?B?cXlkaE5hcEEyaEFWc2MyaWl2TFpxQ1RudzJ5dU9Ub2xtQUQ0WndPVzQvM1J1?=
 =?utf-8?B?d242d3dVU3hzMzVWOW1YWkJBVHlJRWIwNnJ4OVBqdlpYbTFJcTVUK1JtWkxs?=
 =?utf-8?B?cHc4TzFWRDUzZXNwUVpjQXdVU0lRemVNNm1hdlBlWGJwelkzRVN3R3E4VkQ0?=
 =?utf-8?B?U2RINUNKM3o4dERVb0tpOUM5T2kxYk9DOTI1UW92L0w1VFJIZkVHZnBJZVY5?=
 =?utf-8?B?RnNSRVZsNnJnU1o2S3BkOURzQnRYbW1iWmtXWDJVQXV0UzRRWFl1ZGlPSmIy?=
 =?utf-8?B?bW4yYlFZRlYwT0tLc2NQUHZHejRLWEl5WXQxT3c2L0hZVWZ4ZDNRa1lWa3pz?=
 =?utf-8?B?dzhTTlorRmkxUEthcUpzYUs3UnJDK3BaZzc4eUNvWnZSVnhhSG5PajlPbzNE?=
 =?utf-8?B?WTB6MG1TZnZ2WGwrMndncVh4Y1VkZVBqeTA1VEFtbTBxYmhvcFJmSVdmKytN?=
 =?utf-8?B?NXpGMTZRamgyejNham9YSU1lODBEYW1QRGs3V1JucWNZUWhmM25TdEljT0o3?=
 =?utf-8?B?NWRIcVRRdFBLZ2piMUZEL3h0TGhBVHN5NloyMStTeW8wMVRCeXM0UGc5d2pN?=
 =?utf-8?B?RDdXZGd5aHlONEREY0tFTEFhZlU5TVk4czNBbkU2OGZKTlI1Z3hUNDdNYmtF?=
 =?utf-8?B?REhDcjNWc3Uwc3N1MmEvMk9XNTI4R1d6YmduV0NTUFI1Y1lnWVZwWTlrZkZC?=
 =?utf-8?B?U2VEZnNHaDBaci94RXo5K3liR0s1V3RLUVVlTnQwaDVTNllLeDRSQzVacEJB?=
 =?utf-8?B?ZW5sRHRhNmc5NXZqNnhLcDRMMERKVEJXZms0NFJMemkwdWgvY011dnNWRzFE?=
 =?utf-8?B?eVc5c0NZN1Q5bC9TOElvS1VQUWNLTURocTJEMkcwTFZSSWExcUMvcjFObU1O?=
 =?utf-8?B?T1VuaHF4Y0dmL0gwSDBEb0tnNVlWYzN1eUdlblVZTHlqSFEwS2h6Q0syZHdL?=
 =?utf-8?B?TUo1VVI1Y2EyajlmYTdlcS9lWlBpaGs5WWZQV1NYcTF5TGI2RUJDNjVGd3k5?=
 =?utf-8?B?dU96NDdlejJlSFRKWlgxbGd6ek8rT1V3eTJXS3lJN2hRS2duTnQ0UDd6bEwz?=
 =?utf-8?B?ZDBDaGJmNm0rV29NdWZYZERUeTVsZ25EbGdsaWhJNzdpa1cya3JUWUF6YXcz?=
 =?utf-8?B?VTRzakgrSU1KVE9odHQ0eWFyZXhXZi9Dcmc0YXVuUWJSVzhMSmFEMno1SlRQ?=
 =?utf-8?B?UVhKcXZFT1pRemk1LzFDMWxNSTBqNnBnR25FRmtUZksrL0VEV0tWVGVGY21q?=
 =?utf-8?B?YXF3OHFjV25JcFh6SnVpbTkrNHVjWjhyZXZ1R0JrZGxTK25Iam9EUmtDRGdV?=
 =?utf-8?B?azNkUjdnVThWZmk2MWpXdjlGb1ZaKzUvVTRWWjJkUmpFS2x3RlQwQU5OS0xQ?=
 =?utf-8?B?K2FMNXhEYXZnOHo1YVhMZm43TUM3RzlMK1crOUxmR1g1MXJJblRnOFBLZEk0?=
 =?utf-8?B?Mkt6TFFrTk9Db1pPK1QzMzJSVVI2OVBXTlVaZjk5VTVzbERmRkVYZGtxV1lW?=
 =?utf-8?B?WG1WaktOR1EvNURVS1YzMFJPdTE5bS9vNDBuMi8rZkorczUrMUpDLzhVd21W?=
 =?utf-8?B?WUNuRmhJSmd0aVFNZHJsdzI3M3phQndNU0xiSE55ZVVRUGd1MFFTUkNoM2w4?=
 =?utf-8?B?dHp3Ry9OQVh6Qk1qWlZsS05sQzRZVnFOWTd0a3dhcVNYMFRkUU1jUTVlU25G?=
 =?utf-8?B?MXJrd2lYaVg4bk5zV2daMkhUY0liMW8xVVRtd0ZVditrL3R0TmhoNVk5bksr?=
 =?utf-8?B?d3VQc1llc3RhdlNaYWNnanlQMzFuV0RzM1ErVzR5VFZnWDFaSmhoK0VCeWg4?=
 =?utf-8?B?ZEgwTUdiay8yUXFMamcwdUNsbFJFV1JKWW1aUzNuWVQraS8yZFVLcEhMeEQw?=
 =?utf-8?B?RXRYUjFLbVZHWURnRjJLWlpqeUZyOTVNZG9TR3pqN1JHRUxWR1NCZz09?=
X-Exchange-RoutingPolicyChecked: EfPx48kn+t5BGRdckobhVmc+NiT36Jw9IRE1lzHUczugECEOt9S4Jza0bxNKH5yv+cocxSsefVy9+Vby42rDSJvgvLUG2hG4QvF41Le1m7FVSc/lGUMqc2KiiiIzP9g3huUaPHSJVPJpecsBNWEOoHNe1NvKJOl7ujT/4UJPF8T7Bg4UFi8hN2HsoTRtGsyRazhNwTDu6cW081lEd4KsenefoP/b7NK+qZoR2Jsp/wZFzoJBdu0gL85VS9zAhfeL7DyKUKnrJPmBbHbmpiaoRyEwaa3BkWztMhz1UZ1UVHpSAx+NM8oV1aDaoCuhehNatwy6tCVrx5jg16/gyeucAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10704fa3-0c37-4cf3-b1b2-08df092af813
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 19:47:06.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEwtS0Wzc7/ysHwY60hTXzb1xz1z1Ih1TVU1QIu6A5HgUi87ltjsZis7Tvv1+JcPyik1QPPJy6lJ7vpPbG+PVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com


> 
> The write side already validates against
> 
> vmcs_config.nested.secondary_exit_ctls; the read side should likewise gate
> 
> on the control being advertised:
> 
> 

You are right, the read can be gated on the control being advertised.
Looking at the rest of the read function, it doesn't seem to have any
other equivalent check. I think there might be others that have similar
behavior.

But, I don't see any harm in adding the below check to match the bare
metal behavior for the new code. I'll add it to v10 unless someone objects.

> 
> 	case MSR_IA32_VMX_EXIT_CTLS2:
> 
> +		if (!(msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS))
> 
> +			return 1;
> 
> 		*pdata = msrs->secondary_exit_ctls;
> 
> 		break;
> 

