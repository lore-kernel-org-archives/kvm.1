Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864527FB37;
	Wed, 27 May 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861958; cv=fail; b=drngHRq3RaGEO47LeKNxgj9N7mp3g+pnjBW1Mr4H6b7vcU91ZFxxOo/Y3HclxOAPCnZc3zXWlWLwfd+mbC3/OOWpad3E+hgU12ytQD4eT6bFBdaptF42DIfi2jWN8003r3qiJyGKJsVYT2AykFE1JE0wCCDq1MQCscBzJR0u580=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861958; c=relaxed/simple;
	bh=FOifYwSNaq62ELJFmkNtK4yf7uCaTkU3H6Oy3niLJHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7rZyKE988qNK1Pi1I8VZQkZzz/L7HXO+wUdcge6eWRkoAeED59js/jlQpMMmqmYJ0sm/CTqdAng50VkyZO/tFEj//YQBhoiMwv3WoUycnbi7T3i2s7+3op0TkSO5PBWIVwH5XD3INzKqOMB/KV6lq/fGIhejoGiHH7uZrreWJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irdguoJx; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irdguoJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779861956; x=1811397956;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FOifYwSNaq62ELJFmkNtK4yf7uCaTkU3H6Oy3niLJHA=;
  b=irdguoJxRBKshxuwTbHAQx7+JnolbBLXqSX8n4dy/iFH7Eer4WaAW+lb
   OpHNNLqExnwX5xRtvb8jSr+5R6UqyURp4Q2W6sGja4W3OR3kxma5hg55k
   hzIwoCgRxNWSdEWsLwBPSwX6uJW6DpBcAXiGkWmS2rUzhAdRBUQIEQL17
   syUXlskT+MWuibYoHGp9ijWg0BQ921sRCUd4vGqABgePF+42GviiZMs1T
   Wb5V0gUQPGtox9iAa9YczvfiCkC+Z6F2hCR9nsZ2qSpMCmH57gDDcWFDp
   S7lbre1JnrWRiM5RG4Sp4/3tD0yd/9n2/4Cz+bcZ8cZ8Ym2ea9RyTHAvo
   A==;
X-CSE-ConnectionGUID: wpqvWVUrSxm48/HvDJWm9g==
X-CSE-MsgGUID: qgRn2U4zQem3t3elhp4gSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98259729"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="98259729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:05:55 -0700
X-CSE-ConnectionGUID: yUQyI46xQl+wnVSW3to4jw==
X-CSE-MsgGUID: bBto7EZjQIibhnXlx2QKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="266011829"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:05:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:05:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 23:05:54 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:05:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9XCs6qjDe6e/0JbV+OXufujhg9othJOMvz+H4TO5aP+vVZYsS8N+f1srF8zt5RLibWCh/3XiRUPO4qx1MimUxQzoBQOjivfux9BOeikirlwN+7eS5VTLSELDMxuRmTbKEO5K1QuauNUER4yQB3j60p6lY4PbEBMqe3CZIZXrlkQhV9212d3VwmyW9sPOl3UmB76+OGqjvaM/71nm6//DGEFIhe5+3ZiapV14tUcvNrf/hQZ6NFQDt9IhyIRHkb2fKqEMW6j7f4/9UytvIVqzIPlrjUQR/V1eG0nGSul46cDptgYF2zBoWkHBvBsaqw1qb2psfRk1WUkRhMxxiVAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4mUl1zmsgMRwvcZKMsX2JUdLgjpcv1oDUKxuB1Zn14=;
 b=nCWTtcBrWo09eN93Xb85oW/baTYIM96c4yIDmdicuufM6czTUD4r4xuVmUu6s6Hpx7PJfa7gJTNfxwPNn4kQDNAg5ErMYKSgskucuHz9mXlJHb5S4FOS25psqoZ52LVtBLlALGRvO8grcn1ilqe/l0hpP/D+bmj7IjF98m1yOTJAp5s6zPrYNgFnIT1a9dDTJOFTVMvxEbLdNU2et9cSpDuuEbOLONIg/o5WK+MLsaI5bVRYVFg+AoNIqQMT6OjK+TDcRGQuHEKaauzIP66hHkA/VuSlrsELKdHSlYZvITtgoMtk2E1PujDipYwsozmkPUF8wPrOicMTa/yh8/7LUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM4PR11MB7277.namprd11.prod.outlook.com (2603:10b6:8:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:05:50 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 06:05:50 +0000
Message-ID: <b25e03ad-0bf4-482f-86ec-eebc6ac03d95@intel.com>
Date: Tue, 26 May 2026 23:05:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM4PR11MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bf6342-ecd3-494a-0b55-08debbb60090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8Ylro6c3fjwyvGP8vXy9OwJjmcWjHN8uskTjvlOnFpBE5bGZQ5yXtSPiKDPIarsxVs4eye3zmSfjU6zxztB5ybUEU5ksW8CB8ZE9WVXxqF11AclPw3borOyDZNHEMtPbzELu/fV6PNdgPj7KE4t0jl4NQHhrI3kzQrzyq2WfJTXFMhHIlL0jifJ3xKL5bXA1EUWtLjQRnRZs2DOoEHPOva92fYglif7TPVpZ1S9EGWhbdrAqFh0lKzCKm4rcBJbWoRKv5rnW43GhTuhP9JE+RV74Z4d9O2+xkkK7KWc3S+S06GVaIVcjGgGqCnZedWwNyrbpPABhmEvIgJYb53cdhXN5V4qJNoIXdk3Xvgm7MHErD8kC2xtuOeloy+t1qVYLq05Mq1wsSz22VQchyrsei4JI9J8rxxIP3HtNPQOEgNEiz/zfGB8DtTU2x2LCJwcBV4I9vNw/AoBW02Dj6yQ/IUMkHILpKTTnRkJrP1Wc4NYuWN3rMtcKxLmmLApTgn+j2DzHL9xBtheHlHjP8t1jY/K0FmG/olhmXCNbrWlsdhBoqEa4L/oMmqroBbd1HvkrzJ2+PxNmx0n9h1dGF1PfDMj3z4zqHvvLuKgm0xIkxsA+X0GZAev2cPNbC89nwUKv53lY1mMK65BZ8BoBFkLkYlbUull2lcnSIjWAJo7DYGCHv/RAKB0gbTg7rut0tWJK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTIrRUwwMUhXQ1M1UkVVV3pjSUQvL1pvTi9vZkFPTkFLWFlxb3gvcGFTU2lP?=
 =?utf-8?B?QWZwakhCUSs4VCtieE8yRzBaR1phWHFhTndBMWVHYzZUSzBXUFJxd0w5T1RK?=
 =?utf-8?B?L3hJMzlvNG1BVmFWTnJhakxEUDlORW5Ncmd6VTc3T2JIVEY3TXBzTnJzblJV?=
 =?utf-8?B?dzhybFFUUVV3S3ZtZHN6a2VkMlcxNGlEVElkTzgzVFExWXB6R0QxcjFhdnJz?=
 =?utf-8?B?Szd2Nmx1NVF4Mm1zYTd2VDVXYUhpTDliOTNYOEZEeHJlMVAxTVpHNE13RlJD?=
 =?utf-8?B?Y1VDZnF3ZlJJYjlBUEUwYjJJaG0rNzRLMmZwTjlINXBCRUgybFhJK2ptUkVQ?=
 =?utf-8?B?ZnBtdkZ0TWFJa0hGeG5sbTFYYzh2WXpXMVVENHNTTldCbnRUOFZ0cmxOQzZm?=
 =?utf-8?B?UFZsZ0UyZi9ZSUhXVFZENThES0o3Zmt0Z0t3N3FLdEtqMkhyRzIrWElVRExT?=
 =?utf-8?B?SkUvZ0UwSFg3NnFwL25UM2hqZjBucSt6a0hFL3J5MHFOankvcFBxa2NlOEZk?=
 =?utf-8?B?WnJjeCtjeU9sYU9RRldBVXdhNnlRc29ITytrT1dMS0ZoejZCRC91YVVYZEY5?=
 =?utf-8?B?VDZoM2V1ZWs5TFBkUll6ZGdwY1NlYno4Zm1ZdTAwTG5MVXFwMWcvRUpFRVlD?=
 =?utf-8?B?SXlLblZtVHlyTUhzNlpSTVA3U0xUWGdLL3JyK3VkNElWS2liMzlOdDdTb052?=
 =?utf-8?B?K1R0VWJBQXVMZ3BRZjdZZ2JFRFNWR1hXNlVmVFNtSGlDSDA4aFRHa3RXRkdW?=
 =?utf-8?B?UUV3YTVsTGx4TG9rWmxIczRMYnlGckpPRFRCald4dzIrdi9BaTFFKzZUN3Yv?=
 =?utf-8?B?S0tRa0dFVUtJVXgyakdqQTdPS24rQ2VLUFkvRTRJcEJsZWM4L3p5djV0WU1G?=
 =?utf-8?B?SW93MFVTRTlpWUpBcEtjZTA3alp6T0xkN3VrUHdkOVlXcWxyZnR4VXlxMm1Y?=
 =?utf-8?B?QTJjSmpldDNOVkhXZ1dZSGNTdEhVa3V2S1NIdUVUbnhWbkdpbzFIWVhzUTVu?=
 =?utf-8?B?N2ZFUUlMQnJkSkpUWE0xRFFJRWpneUJITFdnUFZsY0M5SW5oYlJPSC93M2Zv?=
 =?utf-8?B?MkFzS1RVTVBsR1JNZjg0dklLKy91aTZPUW5JZmNwT05CSUp2Q3oweFlmRTFt?=
 =?utf-8?B?RXFFRDMrVHk3dE1SNzZBWHFFdXhpR0p2d1hCZ1JydzhFckJOSC9BVllxaUJH?=
 =?utf-8?B?Vllkc2N0SzJiaDJMK241R3ZrOFQvckdxK2lmR1Y4V204ZkYvUlArQTM0eEZQ?=
 =?utf-8?B?TjkyT1dIRmJsR1VQWTlucndnUHhuY0x4QktEOTE1MkhKNTBDbkIyR0kyT1VC?=
 =?utf-8?B?bEFnbk5uRndLbnpmSVZvT1JYQmt0VWNwU1dhSzF0VWVXbmdNNmJKYkkxY2cw?=
 =?utf-8?B?VjcwaXhxbGt1K3YxNDZvdDgybm5lREN6THNIT215VFpCNm80K1FiRXNGK2JX?=
 =?utf-8?B?UTN0amdmL251V0o0WG95dTN0RlRwcytpODYwaEY4cUNicU1tTnpzOGJ2WE9X?=
 =?utf-8?B?bmxSYlRxQmFJclUvdW01aTJNMlpjRU10RHl3Wmg3bUFIdEVCcEdSL3cwUGtF?=
 =?utf-8?B?VWpVSzcxNUlDVW91VWpkZ0pzVm1xdjZsdkJTZ2ZDT1ZrT1NDMlpsYllpblB3?=
 =?utf-8?B?WHBTREpOYnpka29tSHdnU2FWUkNLN1F4Qy8yVGZGSW5kQms3R1dBL1VjV1BS?=
 =?utf-8?B?T1ozT1lvbVpKRjduQjRpSmJzeWRXbFJUVWhHSmFUMzlwc3BWMXcwZHhvbU5O?=
 =?utf-8?B?cndHQjBSdWMvMUNZWldScm43RThVRmJnVitjSlZzZFphNEJrOGd4R0pvcVlN?=
 =?utf-8?B?WGdnQUc2dm1ucUdlSG1xTkFCaTVPekZxelVJeTJhZ0tzZFFaQWRJbU5hckg4?=
 =?utf-8?B?ZXdpWFppWXBCRWtPbnk5MytaMmFtM29hbTVuWmVMLytWRm8xL05mTzVoclpW?=
 =?utf-8?B?YWtVUG0zUWR5dXJOdVVyME9ldDJCZWYwbEQ3WXdUT3RFS2dTYjY3bjZZaFZv?=
 =?utf-8?B?UUlXeFlsUThmT2JyMmV0UHZlSC81VGY2RUtKN1o3S1UwVXBjSWxLRXYrSXp2?=
 =?utf-8?B?TXdkeUJmWG5YQWU5ZjVIVERqaWI2MVlqb0dtUWR1MGJpRStSWkpGUTk3Z3E5?=
 =?utf-8?B?TUlnOVJqcERpYzFMUzFKUXMvcHpiMDIxNTI3UnVFTVExSlpSdFNEbHBGQnBQ?=
 =?utf-8?B?dzFXQlltRldBSE0yblpzYkxiVUJ0dWVORUs4VSs3VlNsRVIzUGszVXRTR3pv?=
 =?utf-8?B?dEZPVjBpQ0NON2VOR0pKN29mU1Y5QUcrQkdoaTgzcjFmcnpITUo2dWJ2WWt6?=
 =?utf-8?B?b1hNMGg5aUIwUFdxYjA0dmgrRTcrcVBXNm9XWlR2NW4vQnlnbHlJQT09?=
X-Exchange-RoutingPolicyChecked: m8upDpMZ46kOUhueiQ3LEZWRgqpgGeJpohAuxQ+W1bJeEZ6btpYMuSz3mmHAo9OI2bkrMEOToNXJRSWTIP++aVV/VfG1Rb9IVdA0af5TjZfq26FpSAK8RGuecIxgJadSTHMKKPfbEuBMC8TWBAAdPVdHm77M1flDvX5jcqGqFBiieGamgrGbz/mCqwdw8Ml1rnSW2Y+sJzrxeMkvjBcrKdtIn6i000aiEJUPKOy7eZeW0SXUF0mtBI/ggz74ep2NVxW9ygmo63ZEVCRZP862KxzuB4aaRZt+pnp0tV3Eumsq1TYKKqdejUUlCnwrfoLWQusDTa3oii1RRNTKu7Hcuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf6342-ecd3-494a-0b55-08debbb60090
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:05:50.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59Wk5HPVXl2PHGs5wB9hsrcLHZfduxhkf8Wo+D2XbyVyiTBrqYPvuAoIHmOHYHzGd8D9KLKOncGZEGEJzYIk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7277
X-OriginatorOrg: intel.com

On 5/21/2026 8:41 PM, Xu Yilun wrote:
> Add reading of the global metadata for TDX Module Extensions.
> 
> TDX Module Extensions is an add-on feature enumerated by TDX_FEATURES0.
> But for the Module's integrity, Linux requires that all features that a
> Module advertises must have a complete, valid set of metadata, and the
> validation must succeed at core TDX initialization time.
> 
> Check TDX_FEATURES0 before reading these metadata. If a feature is
> advertised, a failure in reading associated metadata causes the entire
> TDX initialization to fail, otherwise skip.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  arch/x86/include/asm/tdx_global_metadata.h  |  6 ++++++
>  arch/x86/virt/vmx/tdx/tdx.h                 |  1 +
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 16 ++++++++++++++++

The top comments in tdx_global_metadata.h and tdx_global_metadata.c say
that these files are autogenerated. I believe the script lives outside
the tree. Is there a plan to merge the script?

The generated code is optimized for space instead of readability. Also,
I see odd uncommented assignments u64 => u8/u16 all over the file. I am
assuming the upper bits are expected to be zero.

The patch is hard to review without the script. Can you post a link to
the updated script that led to this patch?


>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index 40689c8dc67e..533afe50a3f1 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -40,12 +40,18 @@ struct tdx_sys_info_td_conf {
>  	u64 cpuid_config_values[128][2];
>  };
>  
> +struct tdx_sys_info_ext {
> +	u16 memory_pool_required_pages;
> +	u8 ext_required;

The name ext_required seems like a boolean. It is also used like a
boolean later.
	if (!tdx_sysinfo.ext.ext_required)
		return 0;

But, IIUC, is it actually a mask that lists any feature that needs
extensions to work correctly? If so, it would be good to give it a name
that reflects its usage. Maybe:
features_requiring_ext or something better

As Xiaoyao mentioned, the struct requires a better explanation in the
commit log.

> +};

...

>  static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  {
>  	int ret = 0;
> @@ -116,5 +129,8 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
>  	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
>  
> +	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)

Other metadata reads aren't gated on feature checking. Is this check
manually added or autogenerated. If manually added, it should have a
code comment clarifying that.

> +		ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
> +
>  	return ret;
>  }

