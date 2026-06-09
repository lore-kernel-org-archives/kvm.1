Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36898480974;
	Tue,  9 Jun 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018080; cv=fail; b=rxL3NtPeg/iXHhZS1AQs1+8IPJAPrXHRy6LQZbO/iF5IUJqBQIsmFBqYGuJb2mwBQMvlATnRihewvi8zytgm0HEa3Gd6H6PuUk9wG3MSEEKSWdOQgfjG5T18m+82aods2OarR9u5wgpGeU07vETF6pve621StwN3ADGf1Z+qoEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018080; c=relaxed/simple;
	bh=FEjzZuDDnDBZgQyhROHkw4XVnqoieNdKRvzCZRPqYk8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BE1SojzoQYKBf7+zXniQwQY+tw3BuX2VXq0Z7bSiYWBRdXzuU9uecqiwWu+PYeSCVlpFnj3vwsU40CqrLNCKMNiQUPikV7IPLNmCQkCYaKj3JmGsxz0RIJJg6Ta8BhFx59VQzlcE9Z4Ii6D2in7UbZ0w5vG7EVSXsnx83SDdIms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAo0BSG2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAo0BSG2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781018074; x=1812554074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FEjzZuDDnDBZgQyhROHkw4XVnqoieNdKRvzCZRPqYk8=;
  b=hAo0BSG23uARSrxkV0sZ2vzVldh1x6O3GCjteff5PC9LEzYnQ2eKjTID
   yZH44upEOL4TilvwB7K5lDF0pjVeszaAVXuBSd3eLelo98DWVAdVZOGqM
   mtrnkM4OIHSHTmzB0xv0PTZtlL5sJa4jaDm08i8E+GikbLuDFXhp4zycY
   t97TAchzDf/VrnuGv2oSlf9D9wwU09GY1Tu5hcVeqI4OXqYJb5XM6w0zU
   gwqWVsjuOy6/vQGmpDENOcLHmK9zeaWWFuUMeJCJtYyOgHXdSSkOcCOnK
   bp3wiPQHwJVG7gMwlf2H419hdaCNXzz1Abt9CALIFAfDt1G8SF9AIgLpI
   g==;
X-CSE-ConnectionGUID: bSnGdQW6QneotK/5l7SKUw==
X-CSE-MsgGUID: yF1RpHKYSaG1gEVMGcdfew==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99199281"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99199281"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:14:33 -0700
X-CSE-ConnectionGUID: JymmbYXsSZOb6vzIb3joww==
X-CSE-MsgGUID: sFqS/7AVSQW+l5W1lmWSgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="243428776"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:14:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 08:14:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 08:14:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 08:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdLLCjxedIuCjVNw7gPxdX0dZe/sacoDjOVXIAksoQyyZIuE/vjybrBocSxnLlqbgsfVR5VNyL5Al8XV4eSVDB5H1QsFxj7u9sWtd0ZgdqchxZyJoQm4tWf3ge5i8j4nd+s7PV7a2bsNPRRtdXz+gAILjovrrQRtHj5e7/1mfSQ5qZf+/GD5Fouw/mZOk6TCmddw0m4Wbm43rMJ6dYTZ53GgZcs5zfjt/AC2htzKfUGYHM7UU4TTepHmpdNw19kv8aFMnX/ULLdl2jdrpcJUvdjtXbNkuuRsaCPz+RbMDWu8epm1APdenDNhgDeix6W2KzbDOVlU92Yv+K1KzHLWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL4WsDcIQ4yRh8MnVD/DEFzpcW0yEPri5G1U1dWlFus=;
 b=pS9/UxcGPNc/rI3P6GK7RYPhmSwvvoXVNThfgly/TFUGZUwbmUb9AszaxQkshAHP1j170P6+7wFg/rjEd5fM14LF9BiLgIVDGuIlaCyiyPXUwulT0bIcZVs9YjnGVi7kG4fACoIRYM8qX8HXmncKQVOU/Bj5YtDya+HXuI1inFL1PteNA4tXIEaTRvKnpa95oKmtRrwqF1KLjvHoC5GEkCBnA8eXtEWLQM+aCvjoxeDaHhlNHAJyL+tlCsgcSg0WyVvLoD9TfKs7lSpsnWZvA/12V3TGYUoyrQq92gnoTQDHz0hynKg7ABTu/oVfYw37mfQEzRSeyhUtfR3+4OcRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 15:14:29 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:14:28 +0000
Message-ID: <1f6bf040-6a90-47f8-93dd-0e36d4f256dc@intel.com>
Date: Tue, 9 Jun 2026 18:14:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] x86/virt/tdx: Make TDX Module initialize Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-4-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b9e4b7-582e-42ad-10ab-08dec639ccd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: raLlir7UqSKuvKs9IByrkZjyDBH/vbpWp6TAIJzwxhq0JhZbZkQagCcPGGKbK6qNDUCPaphcFSnU6RkIlOwb3rW4Cnhx86O25ufWOpp09lBhY/a7pBzogcbNhCnKwbxjbf10ldBFhkGwzyy85GpsMoPFyDIFx5fvjkVEs77Xe6lQiNqLTtkaq1s7BjuMbsdeAEG+AV3PESeU1vRv3mmaqUcFXomUuWunaIwwgetG157HiB7F0vnxQObLxtbEhzm0xxqOdTKwgucptW6c6In1YpR0HdLOs27R11LkPpCp6Hmi8gGazB96JL8Xz4rNBBeY8kheuravIHvrDYjNUfrFClQnUT1lPQ+WykYZCyhPN3qYdlTusruwlW6sILmmS3wlDCeOeMF0yrkZzxl1zVwcj0fZZ5T4sNdFaDcWw+hGnYb/pgPli9jZlnmwKkGQr9QtUMSpoqFo38MN78pozpHZXqwSIlh3ST+G2r50K/2qxWJb75wQF4sQtJER+9u9AjWwrpDhT/Y6MtaWlXfsot9KKLrk2vujXmbd/9YsRf+byRQZSvCR0RoKe0+ks+K6wybX7aHlxE+cAvyGBMlJMHh6km6yXqWTe2fgPxkyzzKDPd18z4KsKNb3akbQE3LC/wefkOaeOM5PGxSlPUC2hPXsLTVfEQG7QDeCYzr62qfj+hHuXENfGmhqb6sDDAjaIZQl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpTZUNja3E5eVNZMXhWK05rTkx1VCtLV0V1VGx5bXpHWGNTOS94N3BNMmN1?=
 =?utf-8?B?N3dFWW5UZ1FOZVpCYzVOZDlvWGMxOHlFbmUrRVBXdk1GYW5zRFBSYzB1WDds?=
 =?utf-8?B?UlJPZncvUWF5d1RIUHVUc2JYYXgyN1BiWkwvVm5lWlA3YWttU1JOd0ZvZGsy?=
 =?utf-8?B?dWx5UkJTQUxGNzZmVFZwZlE4OW1IRFNjMytJaDBRa3hIUTVJVVEyYWFhZStW?=
 =?utf-8?B?NUI3S3ZHZWt1VUtHMUZNVElrT3l2Q2RRcm5tN25Obi9UbzVpLzk2dGUwcUFx?=
 =?utf-8?B?dy9SeEthazJtZ0FmekR6RGVLaFlzQXBFQ3lSZkRLL3FCYUV1YldwNVFrVHNT?=
 =?utf-8?B?L1NEenpINEtPdGl2TVNWQnB0Z3dtNkJaRlhlMXdkY25vRGVwVTJwN0dxZEc2?=
 =?utf-8?B?eXViOGQzM3liaGdpdmpqS1RENFNmT3UrMkdyWUFCNE1HRUM2eXlXR3JDcVlO?=
 =?utf-8?B?V2tiMXVYS2JCTmFndDRkcjh1bndGT09rVStFMFJZRDhhQU1WZTRYeCt3NFVi?=
 =?utf-8?B?bHlZQjFhMHArbm54anRQcjJJaHgvblhTOFJtSFpjbzJEMVBXQzdWNGhBbFNJ?=
 =?utf-8?B?WnFUc1VkZUNOai96S21QcGJxZDhmcEZ6eDVRTFZzOHk3b0hLVGFIUUxxeXFq?=
 =?utf-8?B?anp4aGlWZnlweXhRS0MzYW9TMUlqVVg4TWpGL0ZSN1gxY3JTN3BCbk9mdmVJ?=
 =?utf-8?B?Sm93am1La0M3R2daQ3hCKzF3TnAvU2tjZVVQZE5sZklPUlB3aDhqaVdDTVFz?=
 =?utf-8?B?eGpoTzNWc0NVTjZUcVJhT2JMWEw5VkVvNlR6ZjJ5QTh2TFUzZk9udEpTdDcv?=
 =?utf-8?B?MUJqTDE4RTZyL3dyTGJpVzVOajVSWGRydFZpTm9kcDh4UDhkOWVRWW9LVFU0?=
 =?utf-8?B?ZGFoQWdIbjlZZjRiV0xONEQwWnVlNjdZclhXMEhjOTNOSlJqVnhXZGc3a2x0?=
 =?utf-8?B?MHdKZXZBczZNRXBGVjJkS3pheW5hd3dFNG5UbzFHUVBxKzBEaHFodkhaWFVJ?=
 =?utf-8?B?NTBqQ0grUldnYk1IT1p4QTBmZFZDREZBNTBudXdXWDRhelFTZHJVL2FiU0Uw?=
 =?utf-8?B?bHI1djJabVpsTW9pV1dhTTFPK0pHNkJCcTZxaHdOZzlmUHJUNFNLZlFSc0Vt?=
 =?utf-8?B?RkhtV2FVMHc2R0RTdlcwNWhuOG4vRGkxelJqdWZFa0lWaFViRzRlT3h6Y1Fa?=
 =?utf-8?B?emlaS1Q3UVQ0WXFQd1lGUW1GN09YQlZWYVpCK0RwL3Rkb0d6eUJ3eXZjN3J2?=
 =?utf-8?B?NHZWZUtNYXNDMGgzQ1VaTGVWMDBPd05OblZwVFA1QTh1SEJaeFF6WjVrV09l?=
 =?utf-8?B?MXRSaURSNVNEbVJSMG9HNFNyVlZvYW44MmdxdTVGazhSWlkrdVRhV0NsRWI2?=
 =?utf-8?B?Mm9zaTg0TzFBTnRUdWhSUzVubUU5TmM4VHRIYkk0UHZkTkdpaGk1bjhJaXBG?=
 =?utf-8?B?VkJRYW82TlV1RVhMb3U5ZGhZVWlRajZWTTg5SXYrbk1wclVmWGRQVWtudmt1?=
 =?utf-8?B?ODNQWnBYeEJSQ1QwMDhMdHNOQ2g0ZzFxSG04eGlTbXpUKyszdDFaa0p3bHZ4?=
 =?utf-8?B?ZXhKaFo4Y3U4SGpBVGhrNGxIbndacFpsTHBHRWNzbkF0b1ozRTRoYVc1bldD?=
 =?utf-8?B?a1FGaWVEL0NhSlZyNnFadFJqQlVlYVFMNXBOVlBOTDZQbllxUGFHQzVaUkhV?=
 =?utf-8?B?UkhlRXk0MVpWUDRuMkw2ZFVOMm10U2tiemdyTXk5dWhQb2ZEeVJXMW9KemlZ?=
 =?utf-8?B?RWZYSWs5VkNFRTZ6OElrMGhMZXJTbk5LZ3ZyNUdXR1F6dTdCbFlDUGRncGsv?=
 =?utf-8?B?WlZBOTYwdDFTSlJ2YS84cUFTQUhnTGpwS3NicTVjUUIxbmpDZlZzNVJ4cmZL?=
 =?utf-8?B?bG9TZ0U0ZkJCK3dxS3FvekpsbFRCQU1TYWN3TG9vU3Nra2xlN0htM0hnVkpQ?=
 =?utf-8?B?cHc4b3VmWWQvSHZEeFV1UFViM25LNXBoVHZZbUdBRUYrbTgyTlVWWHI2eHNL?=
 =?utf-8?B?VS8vWGd6eVZ0WjZrK0ZUdWY0MkZCMnorbDhZU0lxT1ZFMlZxa0cyS0Z4cVhZ?=
 =?utf-8?B?VGFnNVRYVEU0c2NwVFZEWlNlb2FpRXczWmJrTVF1U2VDZlY2YXFXYWNqUmd1?=
 =?utf-8?B?RFZjUVNoQUNrMUY2akZIL0dzMEdHQm8vVXZqR21uM3ZpdW9namtFN0dBQWJT?=
 =?utf-8?B?U0NlOXcyVXF5MGY5c2tQNURGQjhpYkovNnFqN1BmMUIxK0EvcVl3bTQ5VUds?=
 =?utf-8?B?NlErUlFobjFrK0tLOTkxR05LeW5oOC9NVXVHck1IVjZsbFE2ZDFTZUVybzBY?=
 =?utf-8?B?UWtlSzI3aXJNb05jd0NmVDFUcG5FVnhCVzhCR2hyc3V2UzR6OEY0emZLeXht?=
 =?utf-8?Q?QbwUb+9mxTKK+sRg=3D?=
X-Exchange-RoutingPolicyChecked: fdOEASVg8Fmc9BS6nKMjd5OZ2Skkg1XsNvl4eGB1m4vwkoxkXKEPfMWRGpQ9Q4rsnHStYJwgq5puT0WixFvykfZa07IPl2boUxP3ROBM0TBLQAr3gFMkB7k05saDf1aBZ64Wsx0SkIPRGS66MkoC7zP7Ggvld1mJfcYNUTtqbOiIGkCsxPxOq4mfbiw50TX6n/Og9XehUiENW9nt8mkSs3v7m8xGr/aBWK1WiotEKqEKfwrwjvyAEMRAnAaZjJeKwQ7rtTDG2mRd14CLz0m9lzgyTipZhRWl5CGleaIHIbk3bWMDJG2K8cE7kVAZ45mttts3zoCSeTjPZ+G5WIwP2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b9e4b7-582e-42ad-10ab-08dec639ccd9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:14:28.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJ0DTcNEKO68HZnjkH6wWirqUCsMbpiiNcPi3yX3NLIWxikUWNwxItHMe714dbaSzmuCJWXq4BmMyZ5nY+kdJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> +/* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */

Reads slightly better without "the", so taking Tony's suggestion
one word less:

"Initialize TDX Module Extensions for Extension-SEAMCALLs"

> +static int tdx_ext_init(void)
> +{
> +	struct tdx_module_args args = {};
> +	u64 r;
> +
> +	do {
> +		r = seamcall(TDH_EXT_INIT, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r != TDX_SUCCESS)

There seems to be TDX_PREV_FEATURES_ENABLED which is unused,
but could it turn up here?

> +		return -EFAULT;
> +
> +	return 0;
> +}
Otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

