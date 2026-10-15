Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AF3890F8;
	Thu, 15 Oct 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075246; cv=fail; b=cNaVRSfafcCjkbCrJtiUxOdWnv1O3XB5baorIKK9XxXV23T2dodQo1+Vd/LydZIjTEAEI3S0e3Ar6xO0iDby5m5GHVy3m+UfuhkvAX9TpMa4i0xcTQGmzqVvnVKhqqT9uSVufleiMts/ihRVBLPm+QFWW+OOx9l3wU7k8uisZnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075246; c=relaxed/simple;
	bh=bu3FqYzHkomHJ6vYRrBRKjVTasztBY6pNoVK005+3o0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VuIfFQP4fTMYwyuugr71JNcjsrCSdBxScS0TqXQ278tvVv+frr1d3Fdek4kUuOtJqC8e31EWNUoHXyw8u0mb/iQeGbqRgrBpw2uEdwlJnzwoK3rjiERkDo1QQv5rkQ7m3iN2tA9EPoWwVsKTcFzilqJwZw8vPEKNH/x+g+gb8gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjgwiUjS; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjgwiUjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792075245; x=1823611245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bu3FqYzHkomHJ6vYRrBRKjVTasztBY6pNoVK005+3o0=;
  b=KjgwiUjSnfxselkK6H06HjRQ9yb/A+AxFuVQ4IUv6BedOM0ju1X3FXrm
   vf7maCRagD6cNhj/yscrVK6KxJJ0Suwd3RmhxI9ibEDUtNcmXpDRBCXPu
   Tt1cg7dFfkyLXTLWBPfBgVQrqXiSYSbmRuwKA/8qFqaKiVJlW+xhxbHEx
   WEneoq4Y10beZyMWaFGWl6HIi1UUgNQxTn+/N49CLwpZNfnxBH2WebVfU
   i9wVsWNQO/xQpb1s4kyo+Fy1obPdmlXhFiXRyL32Dq5AJNtJItsK59h01
   7RdJ6344Nf75rf6Ld6Nzs0+2uOvmTqZdzQ48iVCyQfT+Xk93lyeD3+A0J
   g==;
X-CSE-ConnectionGUID: d5SaT6jEQ3eWJB4Tf5R4aw==
X-CSE-MsgGUID: 1O0abGf1QMS3T9yDIUBkxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="949487"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="949487"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:40:44 -0700
X-CSE-ConnectionGUID: ou39cY6ORDeDrFUb76aXHw==
X-CSE-MsgGUID: t2Z3Uh7ITdq1P6h8fOeSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1782233"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:40:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:40:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:40:43 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvwBUjw9cZVM7FVfAmiZZOkadKTNwer2CYOLwIy4Vj4DGH2iRrIt/IJIDJvC2AibiHsou4ZBod/bww5njBmiWS1S4uNPu25yaJbr3cIaLerIqYIwtfx8q0eaRq7Y2UTERfTyeEiVfZkvL8vd/vJFVpm664Ci32nl+4cNDy68UXRXdwmuT81NOGmrWLLXYbhFN05pc9v490w3nY4VjItTE0R915fnsUR0RAJAFBC7JSZmi5Mz3mjKyqAl4NPa0fBqpSAVbo8spkJ91BzD08x+/9Ct7OcNUZoDjpaNRkAWm1+sH7RfAlaMy+8YTDvos2xd/kcUekqbuynXycA6m8sOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m95yrw2TbB4ree9qtjYPYxSH4aMi5vscL/G7jYczJvg=;
 b=ad1Z84eMUxkKaWpHEJoZXF3ZGQuWODHP0N634XkrYvdeutUZnpCCEtRrK8kRnKwECpyLDezC29+rf5VGLYeivSiYJ8on9zK5R3dSGp+v0U875FQ3VOm5d/n1sqnWaDnpgQbxaTCYiJi2LxvShVRV28mdRyAuPfHfoDNHyGx6oD6l+7cM5586LUbxf/oiLNRkdXxb446BwUrDEa4lUWxWEXgRGfkCwTSzGBjxE3184zmhM2s9/CkDcm1O4D9dd2XaMjfGVaVvThDuJ4gNdAY00Kjy9py/cC1zHAT3TWrbZbE8gNumm+C+X4bkLeyVBwwPU1kkiMcMBPqykVMkuQOsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by PH8PR11MB9952.namprd11.prod.outlook.com (2603:10b6:510:3d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 15 Oct
 2026 14:40:40 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:40:40 +0000
Message-ID: <0b633c57-2938-42c9-a6ed-863d88d2be63@intel.com>
Date: Thu, 15 Oct 2026 07:40:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/18] fs/resctrl: Introduce
 resctrl_set_kmode_support() to register supported modes
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <50333925a56037a0ea82c49f25e76be6271d299a.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <50333925a56037a0ea82c49f25e76be6271d299a.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:303:2b::18) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|PH8PR11MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d06742-708b-4eed-2185-08df2aca489b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|56012099006|10067099003|4143699003|11063799006|5023799004|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: wEout50Rpcb6AFIpv7wyBkZEdBgogcY3mE8VtpfPvD1ZShnaPh8InfJdVpIC2pK+7SB0Z3v00Ok1indBwZxCCr3r92v8G1He34hzitgh3CIebLq/JDWUqgjkBSEuBzL5QSyPtznZEPi8u5r4/hxn/Gxh/tr19DWvp0de8yQuLGDJCfcRhuTJMsa8fhvdg0GfybZFIAPSMmn8GrK3tnpBMg+YZ0jYVAMOcaREK2213NAqxLZsLXF4Ya2NupsbJtoPfDrGgMKD5xRk2EWL2PioqcmN79y91+JRIt+2lu1S40I1FsHwuwvIOa2kuHmaFrO0aN8J8oxoW1Oo3KcADXy10wqZEa25lu2mNjaSTY+b+2IKancb2goQFEcIAOJJox+3cl/sv3eRmD9csT7Cee2TEukl88cdv2ao/p5rRwXNw2cBVHwG+UNO0ZA6Dvnj05nHiDCswOkN85MoJJ6RRnZvvtXkAiD6LTFUaz+S8BJPOEYz3zJSa7cedtFBwV5YxDiTEv1jr+PaT1e9TVWZJqaBCimp3fWBxd+l0NeaLJtalIZyjOuNiPLOgt8yfbGv+yC/q9PH7hsJsi/BTpu0IceoR1LX1x8k2npervYfpKBWHkoKjPflZmr7jRf6UrrA1Zkn5RQ1LczIbA4OmMa6G2BbkhhX2Pec5I2u/phCuXLn3XE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVjb25HazlTaHlHN0o5Q2o0U0Z1ekovZEVTOGFUMDl4NjdOa0MwRHg4NjZn?=
 =?utf-8?B?NUhiWnFESGM1YmE4Y20wNUhQT3dYcnZNVFFSTC9UeldFaVRPTVpvN0FsOUov?=
 =?utf-8?B?SkFyaTFJWFRaSGlHNDJrNnRsZ2h5MGVwWVNHYjVQeDVtQklLenEzNjlJd2Jo?=
 =?utf-8?B?NjF4T1VHZ1ZycW5JaEJXUXZkNlBicjhZYUVUaWhWSGFvQlBXTk9pOUdTMEp6?=
 =?utf-8?B?UjFhQkU5ZlhJVDJKZUo4MTBrR3gyWXVYTlErWVpwVXI0emxsSmx6bUtGbnJG?=
 =?utf-8?B?Z0pYZ1JQLzJ1TTl2dzA1OXhnbzdjcDI2Y1VyWUw5U3VreGhMc1c0OEh1Nmps?=
 =?utf-8?B?djdtejFEQjg0RHBXVVdUQ05zYWRsL29SdnVLWUhvaXk2bVhUTjJoV1pCdVM3?=
 =?utf-8?B?dG9URDZNZkVueDYxb3FXaTYwcHN3VDJJZm1aTnJpL0xYR2dudlRaQ3gyVTl3?=
 =?utf-8?B?WStNamRyamNGVlFKSjhHclMvcmFxWldPVjBUbDVQeDE1NTA5aHNpamE3QWNn?=
 =?utf-8?B?MVZMdVA0dEFzT0ZZOTdVbW01c2tRWStwZk1ZMkJOREExV0ZUOHlCTS9lbk1n?=
 =?utf-8?B?OFBPTUc5QUY0Z2w3MGhTYVdXb05GQktqSjhNRlh1ek96LzErZGlVajZ2SE9F?=
 =?utf-8?B?VUxIV202N1BLOGkxM0NLbEFLdGRBZldXUDFyS0Y0c1RKTXkxVzFoSUJqcWM1?=
 =?utf-8?B?UHZjTVcvYklSZGlwRjVrcVE3clV4LzgxTTI4RU0wQjRnRFlLRk40dnF5NVZW?=
 =?utf-8?B?bE9wQUhlVGN0V3hJb1pTR2dBNmJIdm5BRE5HN3J3VVVKZ2l5SDJINktwbkFR?=
 =?utf-8?B?NnpvVWt5TWFCY05rZEorbWdZY01UVzFCaEFjbzIxUTlEcFArUXRmZ0k4MVND?=
 =?utf-8?B?b0F2UEkrUjZPUHc5L1FMQkl0cnY4OUlYRkpQbk9JVjQvbHlNNjhjTjZZRFQy?=
 =?utf-8?B?SVJSR21JbFIyS25rZyt3UzBwRlZ5anBveWVySVU4VkI2NlQ4OGJ2b2N5WWZt?=
 =?utf-8?B?a1lab2hWV3FYMW9MY0s4NGczSEhvK0Y3TWhjUDF2OHZFaDlnR0JsUUE3OGVt?=
 =?utf-8?B?ZGNEY05XTGFuZXg5d0xHaTQwd20xOWRDM3BaMGdkdGkvdi8zUitUekNhNDlV?=
 =?utf-8?B?YURjeEhvYTJPbUhZa1hSenJORXVsZUlGM3U0c2l6MGN5MnlJU3gyMFlBUjJo?=
 =?utf-8?B?UFVUVmxRankwZzZDVGE1a2tHUEFSUm5IakR6TjUreHhjUU1HTm8rTkdhMEs4?=
 =?utf-8?B?elVUWVlqd0VQK0h6dE90K0ZwbTJwSTcxS2YxclhPQldpQlVwUXpiYjNjbWps?=
 =?utf-8?B?QU4vYzZnb2hNUUNBY1RBdXR6MEFFU09CMzNFRkMvZXpoN3lCNXlucTBLb0F3?=
 =?utf-8?B?eDZ0bTlWTGRIdGZZUE9KMzl4VDlrMHVmSkZuL0FHNnZsK3k5eVYxSE5QSGxX?=
 =?utf-8?B?VEFzcHBIc3VhdjBFL1BBQy9WczlyTDRjd3BmSHBxeEFUT05STlQzQlh1UHFK?=
 =?utf-8?B?ekkwZHpXODVoS1lFNlJqakNLMGVGNCtBNmVFOC9oY3E1TGRscWljL3lmREhV?=
 =?utf-8?B?aFV5MDlHencxUFFhckNuR1N1enpwUW5XazJRNTZwMHZTOGdnOFJqMDQzUVA4?=
 =?utf-8?B?V3JYZGFQRWFzZXZ2MGFOaDRiVGx0Ylp5OTJZeUdJWUI1SlRvVytrMU0zYmdG?=
 =?utf-8?B?OXE0YnRQVkRWOHpZWVBUeFpOalNFOHJqUWI4SXF2bXJkbnZsb1FOYWxqczlW?=
 =?utf-8?B?Mm1YaHh0QWN2N1pzdzRKQklYbWFWL2pjUVE5WkxvVzRrakQvYWwzbEdySmI2?=
 =?utf-8?B?K1M5ZGVhZXYyVzFhYUE4bXh2S0lLOGNCT0JDT3hqcXJrOTg3Ky9ueXg4U3Jq?=
 =?utf-8?B?S21KRENycDFFWnBDQjhiT3A2RWNtZ2tYK2crd2htUEVPWmE0aVlBcm40TFZZ?=
 =?utf-8?B?KzZoZjVBNmhTTHhIMzZLdnQ0NGJNS25GL0hJSURaUHNMbllYM0k3NjEramRP?=
 =?utf-8?B?NDNtL3RoVlNGZlVqOCtLOHNaenFxUVBPUm1WY1lKUUt2MDVwbnQ0a2FrWnZj?=
 =?utf-8?B?Q0pJcjMzcFVUYStoV2NodHo0SVRRYjJZb3MwZDZWcGZXWXoyMUN1UnpGeTN1?=
 =?utf-8?B?THJGNkJGSys3SkZuQVNIVm5Tb2I4eU1zRXNVVlZUY1J5QTd4WmFERklqWVFR?=
 =?utf-8?B?UXdzL055NW5FTnJ6RGp5NW5NVWFiOE90eVkzU3RJMGxraFhUYUZDWHZoUUV3?=
 =?utf-8?B?bjdqVEJzKzdSalRCWUUrcms2cEY5Z1h0bnBwMUx0NGF3TDdtZ0xjZkVvYjZn?=
 =?utf-8?B?aW15NjFUdXcvUFFhdm9raFkvVG0xb2l3eGU5S0x1Mi9TK21lMG4zalY4YWE1?=
 =?utf-8?Q?SafycrppGwykKiqk=3D?=
X-Exchange-RoutingPolicyChecked: d/5D//PFCNEtbXvE3SBR8IIGdkLcNeLaeOODk/KK2JZH8uc75KIYIB1/tFQt1d4c8XFHS7JOieN16jw1hS8VnM/M94h1KeokiSpuVrF+L7yamum00E4k/NPDKpFDaKYAJi91XhU+60IduS6XRukHxYDTqA9L9c6DUUJQKqkQkaKZoIKXEnAzWhmp/u+K2rOVS5FSwC29M7yvB3NUzqc++9M8lpzO4MYcZs8mg4qkQZB5LCYcV8rw58yVOmfrpLxYwR9ARexpUAtKfY2ABBKK6XFNNpWSxC55PRSxG60I6hhwKcfuKkmEgjSmO4F9Ed7McLU3MzC9ZNlpi94LZYhJqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d06742-708b-4eed-2185-08df2aca489b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:40:40.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0KLodzOHscB6fKzJQmb+2cth/y07VQLAbU/kYX5MM6b4juQfyZOFj+qWmHAqg2yzH+ol6uinapKq1wKK9Efh2nVauMLuOMvZ4bxcyZgSyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9952
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> The resctrl subsystem tracks kernel mode configuration. Architectures need

resctrl tracks nothing at this point. This is preparatory work to enable resctrl
to do so.

> to register the supported kernel modes.
> 
> Add resctrl_set_kmode_support() so an architecture can register supported
> kernel modes.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  fs/resctrl/rdtgroup.c   |  6 ++++++
>  include/linux/resctrl.h | 15 +++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 7c39792be1fa..75b81d07a247 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -2320,6 +2320,12 @@ static void resctrl_kmode_init(void)
>  	resctrl_kmode.mon = KMODE_ASSIGN;
>  }
>  
> +void resctrl_set_kmode_support(enum resctrl_kernel_mode kmode)
> +{
> +	if (kmode < RESCTRL_NUM_KERNEL_MODES)
> +		__set_bit(kmode, resctrl_kmode.kmode_sup);
> +}
> +
>  void resctrl_file_fflags_init(const char *config, unsigned long fflags)
>  {
>  	struct rftype *rft;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index dcb0beb847b6..5553f6301bd4 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -752,6 +752,21 @@ enum resctrl_kernel_mode {
>  
>  #define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
>  
> +/**
> + * resctrl_set_kmode_support() - Register a supported kernel mode
> + * @kmode:	Kernel mode supported by the architecture.
> + *
> + * RESCTRL_INHERIT_USER is registered by resctrl_kmode_init() and does
> + * not need to be registered again.
> + *
> + * Architectures use this interface during resctrl initialization to
> + * advertise supported kernel modes. Registration of a mode indicates
> + * architectural support only. The final decision to expose and enable
> + * a mode is made by resctrl based on system capabilities and
> + * configuration.

The last sentence is not clear to me. There is no filtering of any modes
before it is exposed to user space. It is the architecture that sets the
modes based on the "system capabilities", this is not something the filesystem
decides?

> + */
> +void resctrl_set_kmode_support(enum resctrl_kernel_mode kmode);
> +
>  /**
>   * resctrl_arch_configure_kmode_global() - Program RESCTRL_GLOBAL_ENABLE_PER_CPU
>   *

Reinette
