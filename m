Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D02F5324
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049477; cv=fail; b=OVXc057VwCFaB/tyXzxBPTBJiKMMV+o0M2kGcW0z1Er3ykVyLwKJTvNOamSB6gxqhd+6I4Okz/Rmlt2F2pmWG64w307N3ufby/D8uEedVvrCcvR/a+s96nDuKBEx76aJIm/raH7xWR+28tgOvJZJ6mRTOKwgngE2jDR4BwAZ6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049477; c=relaxed/simple;
	bh=70CFgGRGlYY7yYV2aLOPg1W4JXaJ2y3dZ39yEUFAwEs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYzNbzpDBd8XVpSgNYjidSCROgclNGWpqRZC6NNgOCZ9ZJIQA8fIinVgLUVNiaAqiF0sHgXWs/8kq8zTSfNlraVl9CAkFKAKqbitiypkQ/icLALjnfeGrwMtyiEPxJKkOPaSBcKlXoagkCFs4TnEoZbM+WkN8g0cCGktWtTxdyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfRFLYII; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfRFLYII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790049476; x=1821585476;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=70CFgGRGlYY7yYV2aLOPg1W4JXaJ2y3dZ39yEUFAwEs=;
  b=RfRFLYIIy0Y8M28xBa4PtvkgEUqg92BSxwvWE4lKPPoyrJgru91P2wxr
   ZJ/MXyAKlMyLOg0v6BELtP6G8ikLbDiYUOEVOflGLgE7otCpHVuO3dCyy
   +rZOOmEzSyupq66IH74v+zENKUdZZ5v13YA0k4ZYQajEDgGRKrnFgnkIb
   vnvxmi86W0So1GiCr89ugB699zhEEWimPjHehJIs0tUQJLn69kZUsHb97
   UhOfy4XbP93TAegyXBzhwDNIBKtPHWQkQE9Elr28NO6EY9zaPOyw1/Ii6
   Cs0ZhDwES44obx4nT8pHwxiaLSib2KMHMWu7apniVHbNJnlOiRgF+pBm8
   A==;
X-CSE-ConnectionGUID: 1F5Hmp+CTu6IZjVXnP8+iw==
X-CSE-MsgGUID: N7WSbifIRyeVf/0nHcaImQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101966964"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101966964"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:57:55 -0700
X-CSE-ConnectionGUID: utvyJGyxSEK2TPe7YA1ZtQ==
X-CSE-MsgGUID: R+S95dXwR82NNI6bHue2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="281010098"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:57:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:57:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 20:57:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbOpJmTG8nEK6wcqwnyd6Umvs/qCzcDH8TpC7XKNpUAxdddlhD2QugCX+qbOVXsYcRjJjfvqUfRHSRtVnmexDU6+UqQpgaaEe8zWYd2TDNCbvMiWczxfOPqI0vaYp0KBJ9qM7ek/IKrGsQhDqrjJM0tE5C7q9SEO5vofwr9vOaVxWEnNzRrCq1ex/nZt7Ii28gjgJPj8pnnNzcXb5GNYuSR36TfMqlG9t8ed/T2v01N/M7TizPqW5FAbAqS6KTeVaS2TW/7s32PUvEI15Tsgm1d5nDZWOKz+08LzOnfDDD3RDA2uUiPCait+W68vZYHvQejigYvq3vNV8bu0cd+wMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukQDxq+irVAw1V28hssXFqObh8qt+SH3CtBOeOht8ng=;
 b=V8WlY/eSDSSPa2qRMH1zaU7s5x7iKLgJUAfDYBeW+++PdaOCQ8eJBEdmCulBCiR8RrJlMrAkUFaWOz9ukFRe/KknHKKcg+lStpVkjq/0hYQKsis/vLpDM0+YLIdYt1YJH72gDpSYezFBuNU/GEzUeKaR1eEKK8jRbxmzULpZE4VNRNALW7BRwAVP9cdkv/w49iWA7uo1OW/oGrmX9IPrtWpOjdoM2jbgdQOk4dSEn8/7ELjnntaM1m7nu1mjfwvS8YFPSsHm9g7wx9PyD1KkSquaxA8xD/774EXly1je58q3B1i1v9Wjoc4SpZBvn6XzUp7IHrndBdAM7tmdAAbXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SJ5PPFF330187AB.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::860) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:57:48 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 03:57:48 +0000
Message-ID: <da65fe89-e7cf-461b-88bc-4f40f81a6ec1@intel.com>
Date: Mon, 21 Sep 2026 20:57:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
	<farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven Price
	<steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel Ortiz
	<sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
	<jakub.ruzicka@matfyz.cz>, Vishal Annapurve <vannapurve@google.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Xiaoyao
 Li" <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kvm@vger.kernel.org>
References: <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SJ5PPFF330187AB:EE_
X-MS-Office365-Filtering-Correlation-Id: 874485c5-fe27-4f80-8781-08df185daa89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: ibAmtKCvEt/MhX2kMznzeQjORgaKX/RUVKGwrNYW8fBxcmffvKRoN0/V8vzQpFS/2QACHWvpd++2MVg9HjWzfq4U12YSGuWG26cFd/ZNhkFH2H40ZOnD9TdGfBMiEahujLVSMOc4i8RPvLlxdz87ner0r/wR7erJasamLHMMFpzoGtN69Ljr1suTOj7AGcz2mAH5NXDSeyJ9ED24cunG6Noti/JT31EWxe4AFqmLka728wrRmNhHzDw9DYOpK3Dr3ERt4DgoOReJkhy4CAF6ai2I91aqoWvWZlKymFBkfN2FaDQjFSv9sKaMnjWpeD1U4thqY8lveaO4m0HTSmQWGXltbg5ndbJIkAVYoGfSkJaKydwBRzqqWHyMoZw0vHvCqjE/SI1rn9H8+SCz1yK+BpCYjjNND9E0qh7Q/dDTheh/lm59HHNpA3ik9rdFI1+cQWMwHYHnBR6HxaPGc0SjVZlwB8ceghwbQtyA4QGKQ2T4HADISI5CGrrYfnCDLyCdQbLKpunELMsRpuP0KKD7puRpL5N5yzYRlsXG5jQSFGwCJQgLWna/Inpvq4FJL78kLKA4j5ZAY5IxJsqWCPmApLDb7BoycC0YU1EdYGReBpNGw6qXDIOs0/aDz5Eog1fb3Gz9SDBYkh0El05YwgcFa5Km8XGi8Sk8I4G1v8g7bBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1F0Rm1OSUpKenYzK0NMUTVtNkx4SGVaSktsSGhJczdrV0tMa1plRFNDa0tF?=
 =?utf-8?B?cVkvaVdHN0lPWW56OHRYems2Mk5pSWpxWmhjRlZTdVZ4TnBmT2dtc2xkN1ZR?=
 =?utf-8?B?T0FIZEJRVXc1NFJoMUZtcVhlNkNWdzNyYmdiWEM1S0h3RE4xK25DdEhOWndC?=
 =?utf-8?B?b2tVRStMbkkxYjNxbzdYRnlPd0Z1a0tyU29mMHJRZ0VLOEhPa0twWEJIM3du?=
 =?utf-8?B?TnlmTkNDclpBUk1XL0Q2VlZKV2p2Wks2a243QzZKbktLRHJNNVZqMjV4dG1h?=
 =?utf-8?B?VTJSRmVGbjdha1hTb2lucmkxQTNyL3c1K0Nkd0JiY1Z4NHQzR2tKSmhkVHI1?=
 =?utf-8?B?UVI3OVcxZTJHUmczYk1EODdXNW5uWDJzWXhUVXExYmdEN1AweUVyUTJMTDV3?=
 =?utf-8?B?YjhWQmJHRnQvclV0RmJqZHdWYjhFUHdrUFQ0TWJqTDRveTRVUGp2elZPNjl3?=
 =?utf-8?B?Y3Z2cThsZE5KSDFGbFFHMkk1ejVQeVN3b3FKZllCQ3pCTE5KVjMyOTh1akRR?=
 =?utf-8?B?cW1XdmNsWC9KSThGc2F5cGY1QXFDK08welZDSmlBek1RUUlQL2t2NG96MnRU?=
 =?utf-8?B?Tm9uYlEySTVId0tObWljM01JOXRCUWlwVFdlZTh5YXR4SElKMnRuSHRnZG1p?=
 =?utf-8?B?UHBWVklQN01aVWhERHBodmI0WUFkZWNMZk1DMDVhRkVUTW9XRHBQZjJoSnB4?=
 =?utf-8?B?YlFoMCtzRjM0YkYvUnA4bWw4UVlqNUtieE1DNFpSR3NBWlVidXBLMkh0dDk2?=
 =?utf-8?B?c3I3VFFzQUZWdFRBRnkrMExKZmpOKzluVkZmNE41eXg1TUNKd2g4YXJpalJr?=
 =?utf-8?B?ZWFyRXB3V2NpdmROM1NOTjJvcDVza2ZsYlYxZm5GR1hXTXQ3WVlRZDlUM1NL?=
 =?utf-8?B?aENQbDEyVFNLWWhYMTlsVXhOWDlxV1c3ZUFEOUhwY1M4M3g5cXJZTXE4aTNF?=
 =?utf-8?B?dnorWWJ5dXV0NlNka2FaQ2xzSUwyTXFDengrYnpCdlRmTFJXZVVubWRrcVp3?=
 =?utf-8?B?NlcwZ3NXc0JrUG9vdmhjTWt6ekJReTRnNXBuY25UNFRwTU9ISDFESVErZTVa?=
 =?utf-8?B?NzRKRWN5cC9RNjRqc0NoSDBLRnFHOFlrdFp2UEZSazdTZXBFVnBhdXdyOWdR?=
 =?utf-8?B?V2swWDRITXpaaWJWVzFGSlordkZEbkRWRlNlc2JwMHF6cjBxMFBGc0JaVzNr?=
 =?utf-8?B?UUJaeUxKdllsb2srUmszc1Y0MzN4L1VkNlZVYUJlcDFjRmtuem1CY0dMcTNN?=
 =?utf-8?B?WnhXSGFMS09sMzhmUGMvdG5vVmszc2kwaFhpQTRna0dWUkN3R0lzek1KUWZH?=
 =?utf-8?B?cDdSOXRoSllKVEd0TElQM3FhUVdweVlZS1VLUEpqT2hJNCtWdnRsOXR5UXhU?=
 =?utf-8?B?V1JSbE0wa0VqSUNydmROUGxnVW5oblFnNjJORy9PU1hFU3E0WTZodVVPSG0x?=
 =?utf-8?B?aHNaQUNYU3NzR2pBTnZVcXhESGk3V3FKcEV1Z3hCMVNIK29hL0JzbG1IZlVt?=
 =?utf-8?B?cmZ5Tm1GcGhybzJDaUxwNk84ekJ5TGFZUkVEcjhsMUVWaTl6Z3R0NTQwZHgw?=
 =?utf-8?B?OHptbzdFZWpFam1aZWxhdVpjOUdOUkk0Mm1lN1ZWRVp1L2FCdXhTN0pQUldY?=
 =?utf-8?B?aDFxMmY2RkR2ZEhFVUR2RkNpQ21iRENkbFBYUCs1RnpJUkQ5RVdMbTFaR2Vr?=
 =?utf-8?B?ZVN4cmxOUkxFNWV6dkJwaWVCNTNQODhKSExSNzBpc3MvMDRkYVZxbWljRlly?=
 =?utf-8?B?Uk94SmFiMWdpbUY4WjdTcllTSUJyR05meWhoOGVaQWxrSDRIc3JpVWlkaGRQ?=
 =?utf-8?B?UkE1M3ZqaGVGK1lrOHgvTUhSdFkyOUtTU0haZHgwd2M5WDVCRUVCQVpsODls?=
 =?utf-8?B?WUYvcUdoRkJUMkN3b1NUUCtPRjlrVmJKTURTTmdkclhtUm1CMkZKakVCWW81?=
 =?utf-8?B?dHYycGlxcHVPbDlKL0FZZGJxejRuRUg3dlJyOWF4alJjamJpM1ZNSk1XVytV?=
 =?utf-8?B?c0JCb3Fxd24xMVNrek1zRXJTT0dNTjRLcDVKZmo3eHRoK0pIMXlITWoyYXYv?=
 =?utf-8?B?RmlxUFNMSU9ScitDblU1QlYrZC96cFpPOTRyM01ZdFJkT0tLbXo4bktCdjhl?=
 =?utf-8?B?M1dwWTFQRHhTbnplby9wK1diNlIyeUNtaS9sVTR6TEliMWMxQ3YxZENoMU5D?=
 =?utf-8?B?OWVyd2h2dTJOOEtVU3lHT1dWbmFZRnlXWUoyR3B2NGhsTXpqVzI0Rk9takFN?=
 =?utf-8?B?WHl6QzZucWtBOTY2dGdEaVozMm5Xalg5N2pVRjBOZ2c2QVZtNkE3ZHVvMUk5?=
 =?utf-8?B?Wk5XVzZNTzE2ZE9wNEFaVEhlVEJOTDZVS3lsamZDb0lJRktJbkE2dz09?=
X-Exchange-RoutingPolicyChecked: IEiVl9615CH6o0JEvoHqlmQcqY9dQeTM8yic7ESnrMhtTHYa3bRgcKGjdJJbnA0iTlavncr78rZJXrJSUr82UOkLUXvZdgmiNMl0PP1Lh1P4OJUTsSHviIVcEAJLRRKNP73qqGhpG7vgva1mK/RFLhNTepuqoh0+MEetPX6q5amxLUCIOQCqWhe/cVKjUVoBIpZKQgAJfd7nL9KrOJ0262fCUwrBx6OyQGs4MMbqR39RqDviXFWHQQdrkywgPze/OYL715A+Gk95yCfb+GhD3Xo/WjA/DS6AryXS0G+k534H2ht+tO7fqXCevmMHaVPhf4M0AytV9u/4mFCL0eQXMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 874485c5-fe27-4f80-8781-08df185daa89
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:57:48.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ogk3K82wMxMSqvpVX8xGG/HbxYcCJIKtfMfh5n0VyVAf8C9PFVFaTBxO9wVdhxKlSAS+iAcfJpBJGTubLy7Tng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF330187AB
X-OriginatorOrg: intel.com

On 9/20/26 11:52 PM, Tony Lindgren wrote:
> On Sun, Sep 20, 2026 at 05:13:10PM -0700, Kishen Maloor wrote:
>> On 9/17/26 10:58 PM, Tony Lindgren wrote:
>>> On Thu, Sep 17, 2026 at 09:32:23PM -0700, Kishen Maloor wrote:
>>>> On 9/16/26 11:42 PM, Tony Lindgren wrote:
>>>>> On Wed, Sep 16, 2026 at 08:31:32PM -0700, Kishen Maloor wrote:
>>>>>> On 9/15/26 10:09 PM, Tony Lindgren wrote:
>>>>>>> So trying to summarize the common flags for the role and separate vendor
>>>>>>> flags:
>>>>>>>
>>>>>>> struct kvm_migrate_cmd {
>>>>>>> 	__u16 command;
>>>>>>> 	__u16 flags;
>>>>>>> 	__u16 vflags;
>>>>>>> 	__u16 reserved;
>>>>>>> 	__u32 reserved;
>>>>>>> 	struct kvm_transfer_buffer buf;
>>>>>>> };
>>>>>>>
>>>>>>> Is the above along the lines what you were thinking?
>>>>>>
>>>>>> No, I was suggesting a 'role' field carved out of the 'reserved' space,
>>>>>> like this:
>>>>>>
>>>>>> struct kvm_migrate_cmd {
>>>>>>       __u16 command;
>>>>>>       __u16 flags;
>>>>>>       __u8  role;     /* 0 = unset, 1 = source, 2 = destination */
>>>>>>       __u8  reserved[3];
>>>>>>       struct kvm_transfer_buffer buf;
>>>>>> };
>>>>>
>>>>> OK yes thanks for clarifying, that works for me.
>>>>>  
>>>>>>> Ah OK, yes that would also tell "the hardware has been initialized to a
>>>>>>> certain migration role". That seems like a usable common feature.
>>>>>>
>>>>>> Not quite. It tells us that userspace asserted a role for this VM's migration
>>>>>> session. Whether a TD was created for import is a separate, vendor-level detail.
>>>>>> The generic layer only needs the role to reject a session that never stated one,
>>>>>> and to pick the export or import callback. That callback then knows which side
>>>>>> it's on and can reject an incorrect role (e.g., if SETUP asserted dst for a src TD).
>>>>>
>>>>> That's a good point, the hardware role may not be set yet.
>>>>>
>>>>> I'm still wondering if there is a need to stash the userspace set role in
>>>>> KVM though. Likely only the hardware specific code can properly track the
>>>>> state of the hardware and adjust to the userspace requests. Seems just
>>>>> being able to pass the role in struct kvm_migrate_cmd should be enough?
>>>>
>>>> Passing it in kvm_migrate_cmd is enough for SETUP itself, but the commands
>>>> after SETUP like memory/vcpu transfers still have to reach the right
>>>> callback. So KVM would need to remember what was asserted so that the
>>>> generic layer can dispatch to the export or import facing callbacks.
>>>> We've been sketching (on this thread) an alternative UAPI set
>>>> (3 vs 5 ioctls) for consideration which this stored role enables:
>>>>
>>>> Proposed in the RFC              Alternative
>>>> KVM_MIGRATE_CMD                  KVM_MIGRATE_CMD
>>>> KVM_EXPORT_MEMORY                 
>>>> KVM_IMPORT_MEMORY                KVM_TRANSFER_MEMORY       
>>>> KVM_EXPORT_VCPU
>>>> KVM_IMPORT_VCPU                  KVM_TRANSFER_VCPU
>>>>
>>>> It's just a record (1 byte) of what userspace asserted for the current session 
>>>> at SETUP. Vendor code still owns the hardware state and remains free to reject a 
>>>> role that doesn't match it. It is also what lets the generic layer reject a 
>>>> command to a VM that never set up a session.
>>>
>>> For the TRANSFER style operations, I would assume the direction is passed
>>> for each transfer, just like the Linux does for the dmaengine. It's
>>> possible that there may be transfers going both directions without the
>>> role changing.
>>>
>>> So looks like we have tree things to consider: userspace set migration
>>> role, the hardware state, and transfer direction.
>>
>> Two of those three I agree with: userspace passes the role at SETUP, and
>> the vendor implementation tracks the hardware state. It's the per-transfer
>> direction I don't think we need.
> 
> Ack on the userspace passing the role at SETUP and vendor implementation
> tracking the hardware state.
> 
> Then for KVM tracking the role, I don't think we need it with the two
> above. The role tracking can always be added if really needed. Any other
> opinions on this one?

I do think it's useful for generic KVM to track this role (1 byte).
- It lets _TRANSFER_ style calls dispatch directly to import or export 
  callbacks based on the role.
- Even if we don't adopt the _TRANSFER_ style, it enables generic KVM to
  reject mismatched calls, e.g., KVM_EXPORT_MEMORY on a destination.

> 
> The transfer direction is there with the EXPORT/IMPORT naming. Maybe
> just let's keep that naming for easier readability rather than try to 
> switch to TRANSFER style naming. No transfer direction flag needed.

I can't say I have a clear preference between EXPORT/IMPORT vs _TRANSFER_.
If we keep the EXPORT/IMPORT naming, then consistency would arguably call for
splitting MIGRATE_CMD too, which makes it 6 vs 3 (or 5 vs 3 against the RFC
as posted):

EXPORT/IMPORT style              _TRANSFER_ style
KVM_EXPORT_CMD                   KVM_MIGRATE_CMD
KVM_IMPORT_CMD
KVM_EXPORT_MEMORY                KVM_TRANSFER_MEMORY
KVM_IMPORT_MEMORY
KVM_EXPORT_VCPU                  KVM_TRANSFER_VCPU
KVM_IMPORT_VCPU            

I guess the main benefit of the _TRANSFER_ style is reduced duplication. 
Each EXPORT/IMPORT pair takes the same struct and differs only by the role
that the session already knows. Merging them gives one entry point per call
type and lets userspace drive both ends from the same call site which could
be considered a win. It doesn't reduce kernel code though as the top-level
handler still branches internally on the role.
