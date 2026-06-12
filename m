Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025B23D7DF;
	Fri, 12 Jun 2026 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243256; cv=fail; b=InjI6TVxfd2pOvEEEWcbqro00XLJK9HzNIrhU6yZ14NvmKDXre7GsS9jWmXGa9aiqwQgLThjzjLe+BJ+Zr/y5naAi2t1lvCIqGPSY/P3GA8QC/bACNDwvNgW+rcmac+0AxHcWPXqnQQvucizzHA+wJERZZmMu7WwbafajYgvMWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243256; c=relaxed/simple;
	bh=lz6ywxlTLFYWELSThrGlXUNgijFyvn6nYxR4N1805Fs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OnCPqrZ754sCMCXE1kY5c0qg7P+X5pcPbWJ5MqVpVChbqIHqTiGi7CeB1tGaDYsYyjlB7KIMv+xCjMm/VgpFKesSREs3K28zXoR1KoLwMoV4y400iu1TX/WstI9YeMIn4Dakjr9PuS5tRFQZocdmhL7bO0Q/1nDPaXLwUPLK5XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJEAbJ4w; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJEAbJ4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781243255; x=1812779255;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lz6ywxlTLFYWELSThrGlXUNgijFyvn6nYxR4N1805Fs=;
  b=oJEAbJ4wl62Lwm0jhJuMALcB+oB2Ljy37z1LKg5AlDvOgSQxcsZNYMsL
   hXuiA2Q8xFI1tnlw1vtGqzuowllhj568izS1YRmEKwktiX4QkTJ5dS1Tu
   OLjF8ktT+kFD6jxFDqf5+Y9Bgecib4h4dcOmqjq6WM+0vL9UGwSgEaeqt
   eH+aJ8D2aZXxfoM8+5nDebi+QxYjIASVSFsldHIh67OVRGmfZIlR2YZDG
   Z+5/xLoOHlzaOQrN61gpJloOaI9vEyL5o72HSAfcbzTaW6eoxHOXdRI4W
   ih3srlQUMMaBoKlHlUwOWoC9DTUA0BMKOV9FG3556YmnjYydA2/+6GJMS
   A==;
X-CSE-ConnectionGUID: sjjurvtYTouzHNsmUQFOeQ==
X-CSE-MsgGUID: rVP46geuTb2MEjZ0CpryUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81976963"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81976963"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 22:47:35 -0700
X-CSE-ConnectionGUID: 2+c5D8cXQBaxIyMxE009/g==
X-CSE-MsgGUID: WfEu+xwKTi6mcM8GLvEjcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245835926"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 22:47:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 22:47:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 22:47:34 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 22:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnNkZ70eyHyHpz5k1lDWEAunMsQ+J8SXk0oBhadIR9y8nTmgrkslwdxPKQLWTZ6TjV2Nf90kcUofkAKj8r/8mXgQFSpNq7OrO634yHFJnJ0GYqnfV/fvUWSUbdioT/3huJ4Wyvu2eRohhhxYWDDtA7HfYN58fdHygJWweVBZavRWsiuwO3GsGoD59AYcf/1yDoGXDAguBarQd9cJiDpSppV08tuVYoYE+liwh5IYZu9jg3mNpD6ugsJn/IY3EkQhBdkwzHVpbPlHLeY2mipgA+fmd6PJJ+aOqxpIkbvbw5WOVjf5OHzvsZeRxWyenoMc+VtNnpk1Hn09PgWGhnwqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SphShfisgo2AbO8pKdArqZBBcyeBPZGzsVFt0FBB/Q=;
 b=oLrpw7CXCiNhthFAiWgtyJahpNPxnd8m79RYZdQBMg607h/qk3tiG5XbtxmTBxpZLh5BYFDVLYze1iVHqXogY3MXZ9wkDEXEu1man4WiB317fcDnp562tyoRR89louPWTgT87mgVg8ZDnkOIouJ2ms02zUbdTnWFzC2ljHj8xOPCa4x+EBZd0yMGP4Zr0TAhJU8P8SRY8S5XHqwiKdhZWD4Sc7en/W1IsS0pdAoQtRwCeaOlbfAxHQLLlWu5HBDtJi6TJJDQFGrjzcRx5JPu7pZOBqxSbVsKpfS8Coq0zPdMmPbamHvFX/YH1u3+qxBAYoWCCXFVLCZ4mkEokSUj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 05:47:32 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 05:47:31 +0000
Message-ID: <dd9027c7-ea84-4cee-9484-4e464a766b0d@intel.com>
Date: Fri, 12 Jun 2026 08:47:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/15] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-15-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-15-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0228.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::23) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7f287a-0909-4a7e-2bda-08dec8461858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hSNOfbufU+MphBu6VaKkiVegdVn2sMK1HHc2QRWfcZF2tBGfK1k3elPAVvh6XcmjAooxmESj5a7h5+Eam04IbEDI5cCbrhSOfHkBxIMeTYb+P15vTT2L4awkY3IlNIyU01EKWDtUBquKEVFQjF8mg7lztjCHf/EGGpZFJxBSMFxOLFnDJn8u9NujNAPU77U+vQFDrCTatmalzI8xZYoTs9pJVlnkHIzH5ZitP1BypYxJwN2UMDV0tfGKcgCZtUHflKgblH6W1YvMADfilTFY1XE9pIMefNUveDdsJXUGpkXVWlVIBd5+RCcVoIwrWg0O9iur2jnGp/VXjDPZzh1cdJQ6uHtLt6hRVyKavvm9XtuCASGp6876cVkm7O91UJyyvIw/Pl8AfiDv/HBNjGbxksbUxg+Ve/o3gwizSd5lOpPbXdhTqdrQefZImK4V1UlSa7kIVU1KkWYP4KnzG9w32f1OPKwERW62llIRDSHMtTfsdZlAv2Td+K3TslC7V7K26mn06B9/PBIc80XdjX/863u2Wq5PEh7uv/MQsSTPv5CwqEfA0x04KJuCjFr7oeKBiqQaiKAw/JSkqjqOTAJhjN9M0N+8/pV+0M3aOBA4ljfqQ/3GTQwdXG/M8N1wpHZSId/s+xObBnqzwqpHfI7U3u7lTSJ95tQ3GYuLHHjcW58ru4snrqjHl/yGOp4BSpdq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFqNzI3YnF2cHRlV3MxNUcwM3Nwc3hvZzd2SWZjaEd5U1hyU1REWEFpL1NI?=
 =?utf-8?B?S1ArT0ltL1grMjVaWUpxVC9SbVFwcm12QXdObXRWblV1RDNJc2k2amxqZEtS?=
 =?utf-8?B?OG5KMkhzMHRPVWFTeFJqVEFQSm5hejU1Mk9EOHErb0pxZDFaUHhrbSsvbFR0?=
 =?utf-8?B?NjlJWUQ3c2U1OHc3OU5nRmVUNnVKWERGbjNCNDhzeDlwclN2Yk5vbEc2dlJn?=
 =?utf-8?B?M2dTNXYxRXNocXRLeVlPb252ei9Cc3gwTnRwOW5tOVphaXRieFNHdG5taGlO?=
 =?utf-8?B?SEhIdXp6Y3ppeFUxM2x3QVZUYWx2Wkp6QXp6Z1UvYWQwUmRyODRCQlZoODdv?=
 =?utf-8?B?ZC8raUV2OVAraW9PRTJ0Yk9zM3llTU1qcmhnblc1WVorSjh2QlZjS2NoK1Ux?=
 =?utf-8?B?cEFXQy9ROXBxUnUvZWZIUUJWS2xvdVZwcDMxRHFZOEpiT3UxTHpxOENJUDYr?=
 =?utf-8?B?SGMzOVhpeFAzUEhkSVVwMDMxQ1MxN3RtdVpIOWZxcnlhZmpkcHI4MmN6Y3dI?=
 =?utf-8?B?cWJqQktQMzFFWmF3UktLeENvNnJEd1VucktndU01NTNjcXY4TklmdTQ5ckRi?=
 =?utf-8?B?OUZQQzE5VlJCTVpVZ1A2Z2VJcHZCOWNCR05KT1FxZUREU2V2dVBqRU54ZHNW?=
 =?utf-8?B?ZVNNL0xuTEd2ZUFvdU4zdk42dnUvejVFOE1SRFM1aktLd2dmRGNROEk3dVow?=
 =?utf-8?B?OG9Eckd4QlFCNWtxYTl4NUJNM0JuMG1aYkY3MTlwZUdMWFF5OGcrOUIva1No?=
 =?utf-8?B?OGNKaDR6RlZyQkpLUmJsVDlWQkM4MGw5eGZuQ2hhRGl5bHo3aDVMVmhzOTMv?=
 =?utf-8?B?bkdwd2VOZFhpRkxObjJFUEdRenM3dTRvaDFtOWloZG00emlzSWE5UnI5eEpB?=
 =?utf-8?B?Y0M1RTJhZGprbERSSmxLNnY3TlN1VzdzTHN2UElsaW9GaGwvazdNTm1HSFN0?=
 =?utf-8?B?S2R0VmxZTFRVS2c1a2locmlETVF2RHdxcFExQnpqYm9nVTFmZDFzKzV3MU9W?=
 =?utf-8?B?aTFKZXZkM2FOQVJzSkNkNDc0MXNDRGw3c2JYU3A0cHpRT0M2QmFYM3VRL0ZX?=
 =?utf-8?B?QVRDdHVLdlVuRzRFREhvVDB0Z21jR2c0RkNLNlQySEdtZVZrUzNHZkxOdmUw?=
 =?utf-8?B?U3lnbE8wamxRWjBqZ3JmV2Z6Zml1U1o4emkyRXZKMXJlTHNqWDk0STg3SC9j?=
 =?utf-8?B?SFlGaGt0NmY0SWExdmxTNlFMNGkyMXFyVi93Znd3OTNTQVIxL0RwVE5meHIz?=
 =?utf-8?B?WnFOTWV4WTRnaVNJSkxkR0dyM1lHcmU1eWNTaVZxOFJqdGdyMUtWZk0rcGFv?=
 =?utf-8?B?QUc1L2xrZGpSMVp5VUNvOEcxZlFaU3RGS1k2OEZhaitrUXRXTTVzNEZaeDRw?=
 =?utf-8?B?QzB3N1BKUDhjSHBabUtmQ3FFL09OTVdNaENzeDE5aUxNeTFFYVdoSWlVeTlo?=
 =?utf-8?B?emNHSkpmR1ppMXYxam1sWlFZOG5ENFlwcXIzdWtJUFNDVUhzZ1NrVE9hQnZU?=
 =?utf-8?B?RXNFQzlZbFRtOHdDc3Z0cUI2aXVscFJucGFYVXQvdTArTXdxWjc3djFRNTFO?=
 =?utf-8?B?QTQxWHRaelE4VGUrWjdqWTlaRTlMdzQyTTNjQmo3U3N1VTJscnc1UGNZV05D?=
 =?utf-8?B?QXhGWXJUdmh1RUNubFkzQ1hQNkdTZ2l2OXROU3RLNkliaW9SdXZ4NlNxVlN1?=
 =?utf-8?B?OFpMVVlBSDUvZ3RJZC84M1Z3Qm4wdGhwWkpjMEp3cGVhdnlYMDRVMDhWOG1Z?=
 =?utf-8?B?UGM0dzJHb2pCN2ZoMXQ5MGJ3QVhrcS9PWExaQktvU2Y1Q3ZGSjFvZk1mazdC?=
 =?utf-8?B?QVZLSjRDZGFySVYrTUp3bUs3ZVRtVlA3emtBZHkzcG5LYnlYQ1RrSWM3bWpX?=
 =?utf-8?B?ZGhjVUtJaFZYZzZTaUp4NmdweCtid3FnOGZieE5TWExUbFNncTlIUm80SkRR?=
 =?utf-8?B?eGF1QXRIWU5SbWhUdVVaSlMzaXJwNEF0UXhGY1F2U2p4TXRDVW56Sk1SLzJC?=
 =?utf-8?B?SU1FZmRScmw3bVg5MEdBRFBFd0lyaklkQ2xUS05zeEdDRnlmN292TitmRFZS?=
 =?utf-8?B?dHNRTFNueVJDOFhnRE9QOVRBTkw3bVZaZnpmWUhUSWpvRklLTmJqVGZPRWN6?=
 =?utf-8?B?S2VUL2pOUitPZU5UM1pRcksxZHhoR2RmbzZ5blFZUnNFcFB5ZWdPNk44V0pt?=
 =?utf-8?B?MmVtcWFpNkRTbzFrNEhHYkFsVlhFbnd0RlgreHMrK3E3NS9oVGFsME0yMVNu?=
 =?utf-8?B?NFBuaWdTdjJ3bDNrUXRnUjZ4OEUxSjBYbGdVQTduWExsSXNOeVFaNTh1T1d4?=
 =?utf-8?B?bGY2QVlkWHB2Q3VoV0REZTdHQVlaV1hYNFZmMm1MWU11WC8vbEs4VmZlSmtn?=
 =?utf-8?Q?K2xn5idXZbTN7V4g=3D?=
X-Exchange-RoutingPolicyChecked: HHIsb1aJWS7sA9Q+sirfpY02YIOGlsfZdC3ae6uRNN4qoumtfImQJ2faPLxehEWXn7KlP/EO3fySF/rzjB2ucfyi73Y+dtsLNYNf8U97jpcaUzDgIsNwKSdWzNVHVAUz162m+Znd/TJPUWhNLGmXc8S+3Y2+snU+HyoMmPN1uURizNuopjcojkxicoicz2VHAe76b6l6fHFX/UUTZNQaOMKdJBR7R6rcm7GAcXwT+3h1mtX2i/i1eHPa8aBrbT4G7qtIgjk/4bzqlA8g6tNvHVs44R2d6/HZdBJtUW5bOXXMScanjsCrCLOrMF7/1On9ZPaZuZJuDDiwqK38AyMGnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7f287a-0909-4a7e-2bda-08dec8461858
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:47:31.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7aTiVJbaVEiX7ean42Hs2bHliyV0HH1+M7rup1thK78djOSGPGtxH/h7Spp/rWCQvkZZqfAgpGLUXfE0ZKdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> Embed version information in SEAMCALL leaf function definitions rather
> than let the caller open code them. For now, only TDH.VP.INIT is
> involved.

> @@ -31,7 +44,7 @@
>  #define TDH_VP_CREATE			10
>  #define TDH_MNG_KEY_FREEID		20
>  #define TDH_MNG_INIT			21
> -#define TDH_VP_INIT			22
> +#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)

FWIW I find the macro a bit ugly, and hiding the version number in
the leaf number macro a little counter-intuitive compared with setting
it at the call site.  It anyway needs some explanation at the call site.

> @@ -2217,8 +2217,8 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
>  		.r8 = x2apicid,
>  	};
>  
> -	/* apicid requires version == 1. */
> -	return seamcall(TDH_VP_INIT | (1ULL << TDX_VERSION_SHIFT), &args);
> +	/* apicid requires version == 1. See TDH_VP_INIT definition.*/
> +	return seamcall(TDH_VP_INIT, &args);

Now the reader has to go look at TDH_VP_INIT.

