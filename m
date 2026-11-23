Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795466572;
	b=iJ5ob+eEToQ7yKSvzDtuqLFfTlJxQ311u4sFWEYC5DBGCUqUPwNXA6vAtK5t1fBpMWRR
	 SavgJWOLsj4DT0tZuR9PPtLm1wVGpSRffT/0lmWSNUiywOOeEELDzXSI6sap5uZ9xKkW1
	 ZaVNI16zdOi5X48kE7yBQAI6WqtFudZiqKifXIevBHhqo9HM/prMc94sz8uyxTYacCn4z
	 Gt17kURikd0obfLKUhWvKq02JbPsKibBlZGbv6bPDi7Zyfkopha3h016DjjKoHEdLApQm
	 0IHzQa+3I0WIZXhh8xOVTdBRD9nEu+OC+G33Qevpg6j66RGSDt3OLQYFEFg/6jsfl5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466572;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:From:To:CC:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=MoO30SCMjC6Mkkqhy+UYQB598lwX2YKoaIcsmKegYNw=;
	b=qeMGFcb2NXn+P9JVIEJT+fUu/Y/RQ4M3TMDDFKTxgXWQLV2JvjVnj5xTS+OO62q+LJyD
	 qkteqKO2Hqe7JUfpbrCrGdfnSQS6O4Mxa9XYhgD77FJrVjoF9oBe8h3S9dhAN/v2ZH3Ug
	 VDM8J4Qoreon+ZHuMXrgrk19LVQB3lRZua0p40epnLRXctUtKKK7L700ygT7WBxn8VxFq
	 BKOIkCThQ0ruvgiZWQH5XCn5bIJKqrQbpo2O03EbK59cQoF6iUBHYNCifZ9sxrzvEiYQm
	 CswdpQg2V0FlgLiq2SIfhtgiOYxCP4jP7d1ghdKLKZfTvbI91b5Ug5XVlR//vM2Dbig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I1PrnOK8;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZPuieLPW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAA3606A321;
	Mon, 23 Nov 2026 20:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEAA3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I1PrnOK8;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZPuieLPW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795466572; x=1827002572;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YijKGz3zC6ui+M6Rs8xeRAwEg0ULmYljKsLvtKQRMew=;
  b=I1PrnOK8peYT5PUKzvFiWCe5rwhEzIXlhuRY3/mXQ4GZIAATvFa7LS4h
   piEubFRzBK+zYPVpVG0LTs6mObap+s9VkrqPCRniollF5JO4InEEecCV2
   GKm0LKsUDVxSswQB3JeedVk1FzYQdZpGYIMkHnDd0wv4X2FT3YlDyY91C
   S82EGc3UYs3hF/T0RjZSUR0R8M2QX1DrqeWXQ898bdaiUVZnQBKJShfZW
   GwydzFDkLLFDkyoz79fJfDdQoGnbzPQYttjODpWUwy6CgtmDvfLals4yg
   4nzeECVysPEjZg2P0K/Tbf3qXTmYaJiKWncruoNeF7tu78XPC44YOY8Dh
   g==;
X-CSE-ConnectionGUID: 3oc7SvEUS2SAqHOsGy82AQ==
X-CSE-MsgGUID: t+th19JkRPCjYvc3WdOgsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4266839"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4266839"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:42:25 -0800
X-CSE-ConnectionGUID: 0+rC4EUvTWCoD4vWBXep6A==
X-CSE-MsgGUID: zyMfaiJKRqyyjVjwC8Pl8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11411467"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:42:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 12:42:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 12:42:23 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 12:42:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lllwJWLyTQE7QizwtGjenriNTqyJw/A3zYsRrw0ev8BIJbuuc0pN2jwki6Z8Tj0AmOFVb0L1MbC0O2ODvIh29TXnoVdCW8CHsUkhvZ3E56Je8rgS7el5k/+QL/py3xVa2KmhvEy9DeR0MhldOJwdLzxcndaMDX05DKM2ms0ghnWQIyiFj2/A1mElH3DsNrNW4SwoeHJjmZVZVnyzpxlDaS11dbZMQa95NjvaYm49pzRvs01q1XtZ8Gk+E6U7L3Soc/nZXpqPtXEld/2otw4fC0e8i1mnhosmNr2fMlJgFFwmEkVpdBlM3AyjWCTJMPceDbedmVD2kZW1MhBv8Nsu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoO30SCMjC6Mkkqhy+UYQB598lwX2YKoaIcsmKegYNw=;
 b=KTUd47vSOqeflqPL9CWoOdviCu9Ryf6iF+4HUkcboBpmw+l6IOOZG8KotQ03XHmMm/+875Ms1XJuVuE+SftXN01RjjcuyqX4AcPAmonj8QxTuK2osmiF2w881WUfxEkZW8KvhzOgwCHQa4E5T75UUeAaPvPaglVPDVtoxqnGx2FcRqm8KOwx1w2D75cKNUifVzLVlgdL/q2+jOtCc8KKsyWsBDf62SZRzVat7Ur+uHapeQzio17HzmTjFz++ObObtfR2l31GodDt4hZJvVNOCMWg9MQbUtXg3SmKdN3rbc8jnaxmm/DA3TxyFUgEkwYDFJ32IKX2+Y26T0PcPCePlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoO30SCMjC6Mkkqhy+UYQB598lwX2YKoaIcsmKegYNw=;
 b=ZPuieLPW06s91FwBFLrY7MclTYtbmPUIipLCL0po8ujOtK6FHKZ5BIoWZSW39xGB8xNPIEMUwm6Knczb+NW/Vt2p8dMl2k0FKQrYRHAyK/kBNPTRNvemU5vxCwDMkllkWlRYWmn3HUNwsvppGegEy6+Qsd1w3V9MESQsx8d+f6c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by PH9PR11MB724247.namprd11.prod.outlook.com (2603:10b6:510:415::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 20:42:01 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 20:42:00 +0000
Message-ID: <a0e3b75f-899d-4f80-b307-887a007e74b5@intel.com>
Date: Mon, 23 Nov 2026 12:41:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/cea: Index exception stacks by the ordering enum
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Binbin Wu <binbin.wu@linux.intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Chang S . Bae" <chang.seok.bae@intel.com>, "Chao
 Gao" <chao.gao@intel.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261120235025.2809042-1-sohil.mehta@intel.com>
 <20261120235025.2809042-3-sohil.mehta@intel.com>
 <4c51d4e3-2628-4b51-94ef-60c941c09dd4@intel.com>
 <5cb0a2d8-d9bb-4464-848b-4e83d1ae2eda@intel.com>
In-Reply-To: <5cb0a2d8-d9bb-4464-848b-4e83d1ae2eda@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|PH9PR11MB724247:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b1e9da-92d4-4751-9c83-08df49a23965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|261022075727099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: Nhd7ahJ8UBBRPRyKncfQ8s95m/PTPOtMNKaERiCbDkofIhW1d3iMPMWEXH55tjHnP/4pasuXdzEce7wbd+rt1EWP5dxoWrPrYF1N/FwUqAH0g+A3boglmofv9lLw8vqrOMBLWCHSP/xRTvqVJnx9SN+FdJJ+oi5lC+tExE1Zr8i0VBWhbMyzcYLPztQlAZCmgqNTZJ+WUEzOh6RsTQ4IElKY8bbwZMyQ+ugthW9oYhqVW4aTLsgh0+4mz98JNM9KBVmEe375bwd/FF15fQxrmK+T3nCOr5aB+V21Q+Ws+VPg2v2qK2UxxivUxOElziqPcabtq0kBGsXhWkMKsuwQfimmDzVVsQ/Md9BVHnBnM6gPHRqfd4sRL2CQv7fjA/k2IsCZ/xscdwNbr4CErCf5Hoy3seooAYr7/Op8ttPq8VW4ZTRK3mivbOn2H2jFYHiY6jPTUzpKQEPqeBhrcXf+Mja85+e03PsNYe8Pgg2HJUwvCu7AioeQoU94AUBbeVU8wN3OFxSKkO0Kz0TGFk29iXGDfiFIgIibQf5/aUziiOuyEesQILobNjR+8wWVR+GcLtzZuVxfe/DG6BIBVmBl3vg5+YNxPNT991GXBs8+T9YH7N2vfq5d43nitp2qbNFoWHyO7Pu1X6rxGpG16qOBebsS4V4C/SdFDvPAIwK3QVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261022075727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBEYXhudUJFak9lRWY5NG5uU0V5VmRsWTF0M1doK0huTVhMKzNpVllNK0t4?=
 =?utf-8?B?NjJZeVRnZHdsWVZvZ3R6R0FiL0R5bVJDNU0rMDdZeVJEZW1FL0Q4UjRRUFBJ?=
 =?utf-8?B?ZTVPV0F6aSt1YmhuYWUxbm9ZM29aMittNWs4YlIwaEpOQzV1MHEvSzJRNm10?=
 =?utf-8?B?TmQyOGs2bjlqT0hxUUtrQ2p0b2I5b3NHekpLUVZBS1MxZzZLR3ZKOFNLQ2ts?=
 =?utf-8?B?dldiL256TEMwR0RMWGVFb1A4aE5KRjEySmFadG5GQVhQRkhZdWloeVJHMjNK?=
 =?utf-8?B?ZGtpbkxSV3VLNy9wOGdPeFpKOTBPVUtSMjBRWjRZQUpwNkx3LzdTTnJjbUxu?=
 =?utf-8?B?VHd5Qm14OG1Hd2pjUDJzR0Q0TjJUWkZOWW9kUmhkemxwc24rT1o2ZTZ0eGtw?=
 =?utf-8?B?ZHRiUUsxUGJ1RW5OTU5HUU1vcG44aGdCYUtkL0YvV1o4VnlrWGNOZ21KOTZz?=
 =?utf-8?B?dDNBVlhtcUJ2cnhSajFOWTRZWGVCTngzUVRTaDNLOFBPUVNVb2Zza1BmNi9r?=
 =?utf-8?B?a0ZmMkk3YXR2TGptTVhXR1NXdHFrUzZWUDlydmdTa2JtUEkvVTJWNWlVc2tT?=
 =?utf-8?B?MVY2TGloM0RLUFJnZ1dNSm5rTlQrRTRGMWxkVjlpWXh4Ym9nRGhsYlJEaUQy?=
 =?utf-8?B?a2RFRHZ1WXIvTTZpME4wZW5SWkRCWGN5Zmc5TzFRSlptTWpDTFlyMU9oWkpP?=
 =?utf-8?B?bEtlOXR2RE9HbXR4VmxNQXVyNS9wMUVwRlJUUEVlOEFOemxiSlNNbWNPOExW?=
 =?utf-8?B?YUpheWFoYy9wbjl2OEdieTBHRDVPZXhjSGNGOFF6N0ZoeTI2ajhNS3ZEYVdu?=
 =?utf-8?B?S3QzanpsSkN1K3lnUEtnRkNjS2FkYVhhZXVZYWJTTXdxUGZ6ZXlTOTBFeU05?=
 =?utf-8?B?Mno1NTdmeVhmYkI0ZlR5S1FSTlJMRlBmd29jcllJMkVaT0Z3Nld3ZHFQZ0wy?=
 =?utf-8?B?MlFOOFdqY3VBWjNwS2RvWDlEc0FyZlJVcjJOTXlqNnlIL3luM1pZZGM0ajRj?=
 =?utf-8?B?aEVQcGs1RE9La3dIellFQjRvVlFteVB0MHgza1VwMnpCTVVTRFYxUWFKZ2xB?=
 =?utf-8?B?djFqQ2ZiWnZuZEhNMnl6UUp0Syt2SlRranhpVEd6czZFcThrSmtRTFNtRU9k?=
 =?utf-8?B?MVhRdlNVK1FwVThPSm4xQU9McDBlaW40MDk2R0FNcngrY0VaemI3bEpFbmxu?=
 =?utf-8?B?Z0hhekszcjAzbzRBVHp2YVZtQWZDekFqVzcvU20zaWdLVEZXeUNoS0lEeTVu?=
 =?utf-8?B?ODhOVmxLckRDRklRaW9rZnlJNXQvZHJKNEJ6Mkc5czhrVCtFa1RWZU9pZ1hY?=
 =?utf-8?B?VEN4Q1YxSW11NjBpMzhJUFZsYWN0MTA1OEc2ZE1MMW0zamdMNU9FTVJicWdK?=
 =?utf-8?B?RkRDVVlzdGN5Tzd4cHpPYkt2bExwQ1g4dmtTdnNUeXEvVDArVjVTK1hxQUtG?=
 =?utf-8?B?WUlBS2dMZmlVUVFlbkU5RElKNnh0YUZUWXpXUjV1V2dJenJ0cTVlVSt6bGFY?=
 =?utf-8?B?bU5aWWlBbDdxcUZHVmxPcjlVWXFjYUlzR0VUUnFxOVo2MEJxZmNDc256aDdH?=
 =?utf-8?B?ZEJTK2JEQzd1VFlYRW5DVWM1OXVSb0wwNHptTVhEc1FQNHExZ2dROTJnZ21O?=
 =?utf-8?B?cDNMVCszZS9Sd0tGMVpUZ045WWQrWDl4eGdjbENpQW9McEI2amtDOWwydm1u?=
 =?utf-8?B?T3RiT2NlbFRESTNZVkl3UkIxVE5QUnZxdktNVitVeHRvN1dsUTJtRGYwcmY5?=
 =?utf-8?B?TGZmc2xHQ3dPNXNxaEJESWNERGtDdUxuSmF1bmJQcW9SRm5NdVhyc2RjeEpX?=
 =?utf-8?B?VmVQWDltU1ZSOUR6WjIyT2VUVkRMZzdMQXRRem9SVzVwNDBSNEdxdlZZL2dh?=
 =?utf-8?B?M0ZWanBJaU8xdHoyVmRiRVdudHo2M3MyN1pzK3RCK2RNeVJkUkQ0WTd6WjBF?=
 =?utf-8?B?L2ZlTEE2blo4MkdvRFFCMjRwaFB2NCtXdmtTalhDYk9aeldEejFSSzVZNXdZ?=
 =?utf-8?B?U1pNcDBsKy9kRzBpTjBQTlBpRFJRQ29pMjBpaEZkT2NJRWV4b3U3YWtMVmZ0?=
 =?utf-8?B?OHhlZDFWZEpDeW5teTVyWVFFQklLSHFoWE4xbU5BTGFiV01qdTk4UnFxVmFz?=
 =?utf-8?B?N2NCSU4zNWhKYWl2UlBHWGlqbWRkR0Q2Nmh6dVFVeUJYVms3L2dKY3FldmUr?=
 =?utf-8?B?Y21mdFRJNVZnR0V4SGJCWnZLZVlpbFlOekJvTkhEd0NocGllZ0Vla1QrdFhp?=
 =?utf-8?B?aStSZlM0OEdnM2hZRXZEeUFta05pb1dzd01sSGVoalJpMlRubDNDQmRmc2Rn?=
 =?utf-8?B?OFU1Ym1hRkdBSW1sQlMzUlZ5aG9TdXV2aTNLZ25qdkF3Q1l5VVpKdz09?=
X-Exchange-RoutingPolicyChecked: VcltfshwsPhfRJ4SIbVF7nPY6lHxXxOjwoXB5Qc5gQOOanYcMiE1rLBv+cBAtVrIhZ8qb7TIDASOH9v+RnZejhTkKT3wzaIYUQMpSXesk5NGh6t6IpVtWxLXmCbsfnBQKuCpqH+kulzhxUCamQxs+iiruMOzSbUJkDnf2QS+OrU+qwkMfjB5yvp9p9JFEuVLbQpgfYKgtr2D7w5Z1s6zDaqRsEnj5xBL1mZNsKKDUHh4pgN8SXShwavJ4VNwquNSzx75qFPzRKRtzl0ICAepvYcrMPE3NPGxG5BXXrDnRIqxvt8E9TFR7xun2hAdlqMihzRtC5fzYp4BbKC+L8NlcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b1e9da-92d4-4751-9c83-08df49a23965
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 20:42:00.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hExXyunK8ExTrDxeORHasGh4l4E74sJEVJis2gHgRq/V3IVGQISMGtVWqhp1xCTGkqQSCKK9MiwVRYWaVTHRMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB724247
X-OriginatorOrg: intel.com

On 11/23/2026 10:34 AM, Sohil Mehta wrote:

>> Also, please add some kind of comment about why the VC stacks need to
>> be different.
>>
>> Honestly, though, looking at this, two #ifdefs would be perfectly
>> readable here.
>>
> 
> I think commit 541ac97186d9 ("x86/sev: Make the #VC exception stacks
> part of the default stacks storage") added the #ifdefs in the header

I meant 					^ VC_EXCEPTION_STKSZ

> file to avoid the #ifdefs in percpu_setup_exception_stacks().
> 
>> struct exception_stacks {
>> 	char ESTACK_DF_stack [EXCEPTION_STKSZ];
>> 	char ESTACK_NMI_stack[EXCEPTION_STKSZ];
>> 	char ESTACK_DB_stack [EXCEPTION_STKSZ];
>> 	char ESTACK_MCE_stack[EXCEPTION_STKSZ];
>> #ifdef CONFIG_AMD_MEM_ENCRYPT
>> 	char ESTACK_VC_stack [EXCEPTION_STKSZ];
>> 	char ESTACK_VC2_stack[EXCEPTION_STKSZ];
>> #endif
>> };
>>
>> Because, without it, we have to explain VC_EXCEPTION_STKSZ anyway.
>>
> 
> 

...

>> This also begs the question but doesn't offer an answer about
>> why it's OK to have EXCEPTION_STKSZ vs. VC_EXCEPTION_STKSZ in the
>> "exception_stacks" but have EXCEPTION_STKSZ for all in
>> "cea_exception_stacks".
> 
> 
> The exception_stacks tracks to real storage so it uses
> VC_EXCEPTION_STKSZ to save space in case CONFIG_AMD_MEM_ENCRYPT isn't
> enabled. The cea_exception_stacks only reserve a slot with no PTEs so
> they are using EXCEPTION_STKSZ for simplicity.
> 

Ah! This isn't just for simplicity. The EPAGERANGE(ESTACK_VC/VC2) usage
in dumpstack has a compile issue if the CEA_ESTACK_SIZE is zero.

Overall, Patch 1 was the most useful (Thanks for merging that). The name
pasting macros have been working fine for a few years. I am not seeing a
lot of value in disturbing the status quo with Patch 2 especially since
we want to keep the two structs symmetric.

Maybe some clarifying code comments would be useful, but I can't think
of anything beyond that. Please let me know if you feel otherwise.


