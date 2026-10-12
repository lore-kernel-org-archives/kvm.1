Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270C10F2;
	Mon, 12 Oct 2026 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830876; cv=fail; b=QtYRtzeQxuIZ88rkU+98pjnMGcB7CI5tlhYCe8mF5hTbU5BFkotGzsYOIca8UBtf2CpEB7gCskD64Dko0Z3ZsUD8AikBwUhOUoKqCBeSvG3EQTulZSD9vPqeUgXD/jeCktIHlTOeaiPZmqhsqr1emKgedn+igDfpRIOncl5750Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830876; c=relaxed/simple;
	bh=GdS7NHfrZMPOI1jpfFb7hQ0T/I4THd8C2gT9jcIc2wA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OuZyDv9rn5Y7Zi/vQFX8mRfVAmbq8xe1ZhABDG5LmsnYFoymgWG+OUN7o4U64LQ1iDxasCRjrguOH4tr1wXzut1qOzFephf+B9a01h6QHD1zl//eMV1aNvsXIUrPmkhtZ3X43CZEDxbJWPc91bt8eH9KrlWMzVk7G2UKuRmOu0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXYZLNZb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXYZLNZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791830875; x=1823366875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GdS7NHfrZMPOI1jpfFb7hQ0T/I4THd8C2gT9jcIc2wA=;
  b=HXYZLNZbWbN9MzscMfEbUi5BJJUsvB0Yp1YxbC3YD/cN2xwt7wsAmeNI
   4FG2o69R/zRewiHzPWf/i04ybUxff2EjHn2GNMHNL2KSjb7M+J05Ka+UA
   Jb2hN9glsVHbSkQY3Wt/7dn0V/mlY4pSibtSA0LOhk/dlVbNQgepgfrtV
   yebD4TcP+iDRIXQ6P3eZWwRA7b8ZGm1XxsCOwEu4zWrC1ucycJeIF15Z9
   SZk1zqF87vk5Ea+kke7vJIa+/x0YIwQOCA5MSKdojRpDTaSeT3mzd0/Vf
   H2knFZ0IpKfzHehgAZhk+tqAOpQog0nwuBaU/seCWXmc2DBauJiTmCMqA
   A==;
X-CSE-ConnectionGUID: GUw9OXzSTtugxIxaP4Azew==
X-CSE-MsgGUID: HqscFFHeTKSLR9rseq1dMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="443269"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="443269"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:47:54 -0700
X-CSE-ConnectionGUID: rNongLyqQKyp6NiWrxDYAw==
X-CSE-MsgGUID: eIx6oxaJTHO53aLyKmZPyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1299742"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:47:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 11:47:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 11:47:52 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 11:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ+L3uuPQUPFWQxNrvapPwyaSbRrhxLt2MnSrZXoh5iSvZNtL1Emf9UixXi/QSDxKMXSPT3sxCXkK17j1TXyzmtgvI3NxxAjMC8Huh0OSiDCZu2we7w72+0EIhWGCydjbYvz211HgVxR0XreTH7HsheIQK7xXUX1TLL9HBQQpSWQSa2LZ33RDZeUlK2qHLfZCAjP3c7Uay0hOU4n+WQNlGYvojIkAdCxqngq+Gn33MWUutG+pOMPhXKrXFWxdfVkvNIAkioiCeRCVcAGe06D5OnShYDon61UhPRk2Z4fmXtkjBaj8FHiiok9cXW5MRN8NXUEizpwXV8ZBe3jd0Yx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8lnsj7fz01MMiRQMoyMYG5AtXppCgEuG5aKWUrsFEA=;
 b=S60rLEvJ1SDFqyEdmHadQerwqyJXC9cFaePeRYT2miaEHqBqS/uooDO/FAr7hX0J84REI+4qr+7ZYd1AcDSinhBOeTdlMmAZXr9INgEaqmnitR3BAlVpwpwMutGofojcSkWc/2HwAg1J/EF3d0W/aF5ypXcdfzPtKk7867ob7kbfhnqc/ReXNCkVHut/rW+D5C+QnbEoMCE/TgNgDjrdlNTkOHSn4UgU93iAOIKPMk+ql4CmJNbBACnnRtLysIDD3tlBtKsatLw/KBMa83+T6IXN2n2JvDAe484XD3RSOeDIL1tWllAc4A+0cDglNlnGrw+9MAvSCb3xlfYuCs5yGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 12 Oct
 2026 18:47:47 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 18:47:47 +0000
Message-ID: <f979d477-9beb-4e24-8e51-4a5cbaf75aa4@intel.com>
Date: Mon, 12 Oct 2026 11:47:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1791589412.git.babu.moger@amd.com>
 <fb62d29c027514fbd371bd932f098d119625acfd.1791589412.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fb62d29c027514fbd371bd932f098d119625acfd.1791589412.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|IA1PR11MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e5abe9-a9fe-46a0-2787-08df28914f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|4143699003|11063799006|260925021911599003|5023799004|56012099006|261009223027099003|260925021311599003|260925022911599003|10067099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: JvHyNSODfF6ijMxJJcSA6fD22Bh/UkdykneYT4ea6D4tmxhUEn30n6XZl0vFw4RV/YYNzFHoavEngaAIja3YOfvrADrVScCHkYb4fx0nddBcXh1MhIXOsTd8it9Zz5f9ISaoXrzUPGKG3qVqmsXfn1G2h2HfUzRJLjXj7mtrvILKamXSG9/E3PKtwJtHyerEORMuJzQ1NDDESrvNg84DBr1t8MBmc5czhos9iKQeZhbuZf9/3t2g+XoO2O4yWpEcmD+wW8YYB8uLQv3YQdMBo5R5DqYfCZI5fcarXeeVf62g53eovN6+Kv0ATzJEeQLWP9/5QavLVRVFUQ8jAznu4VT8rubBBvkn6Bi1yMYW7W7ycK3i8tXIfWtXJgGqqsJcMS0hM//G13YfoD/ouKqqIWrmaqMqSLnXgefwxfdkB+XVxyWQc5tqmGCNN+yNt3+hE8yE2MhMt617pnkep2zIoQ2dwcAyg3xUjWTytQh6c4pf5S0yLaceKcikNK30qo1L4EnANc3xRfqGWou9VVYNP2rg0TqdOHp5J0r3aAXg5gWyTxMbd22s22z2w1uMB/U0mFaTJvdvDtnYo0C9bJVk2eMhYlqnOdroVjrQeijK+4KwqmGeGDnoqJuxAPPZpNRcEtjd/KTyqLDSqxV7YxaV1Cou0czrwz0jT/tNSxZZwTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(4143699003)(11063799006)(260925021911599003)(5023799004)(56012099006)(261009223027099003)(260925021311599003)(260925022911599003)(10067099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzVtcUFmNzVCdElIcGtNdUsvdjZqdWZ6TEQyTm9KUEI5VDJ1U2VVZ3kzb25z?=
 =?utf-8?B?Y1FKeXRMbmF0VUxobXNPUk5xR1lPMDd6TnVKaE9helZseHJBbysxRVRaSER1?=
 =?utf-8?B?MUc5ZVhwdXNUUGtnbEV6RC9oSi9DcUJZa1I1aFpyRTN4cUNHUHp5M0Q5UVpp?=
 =?utf-8?B?NjhLSkZobUt3Z2dsQ1RiZUJTeXEwdjhkeXFhNVNJYnhzbGppTDUvZzZ4b2VF?=
 =?utf-8?B?SXZpdmExUjFwYXZBNXZIcG9GRXFVQmhHQ05hWk5OMWhEaDFBT1owL3NJOEpy?=
 =?utf-8?B?cEJmaHphK29WSnBuOWhydmk1bGVmNG0zSXJnazliUGJZVEJaNFhQS3REd21I?=
 =?utf-8?B?WWVPeXlndnp6M1lNUzh1VlNKd0x6N1ZUUjRNZnJpWTdhWTNCQnlKV0ZYdU1M?=
 =?utf-8?B?MDR1MW03UllidFlkSkhNRnFCU3BGWWt5c01paGR2WE1HRHllU2RYMzZ5aW5I?=
 =?utf-8?B?RW1lMHdwRkRTUVI4aFRsaE9WRE5mWGdiUC81S2o5T2lLNG9NMjBwdkpwMHVW?=
 =?utf-8?B?a3EyaUpCemsyWGNKMjg0V01wYzNUNlk0R29CU05LRTllSmJVajVtSEpEM0U3?=
 =?utf-8?B?SVBPbkZRRXBJTXgyeVB6clpxbTZmZGg4MjlmS282MVhBS25IbmFsNTZWMURr?=
 =?utf-8?B?ZGJqYnZsdUJGMGU3UDMvYVVLNElSVmZPVkEyOHd3SU1BYTVQRkxJOGJzVE1H?=
 =?utf-8?B?M2Z6VkNVR1RDS0hpT1hobnZKVFlNMWpIcHI4eEZVN1FzVE1RTHpoa0NITVVJ?=
 =?utf-8?B?Q01YSi82cWoyZHBZditMRTJiSURxYzhHNFg5SHFnOGw4ZTVUd3VlVC9RYllx?=
 =?utf-8?B?b2VVRitVWkdzT2lmUnA3cW8rYUYvVmNERkhWRTEwcDhwejhvcmx1a25nYUVP?=
 =?utf-8?B?c2xBSWdVZWZYUjA1UGp0ZGtjYXZHL3BNNE5NUkhaeSsrUUxUL09jYkovWEhY?=
 =?utf-8?B?WDMyUUJTTG5WNmFYSHM5blZmRHJiZVJNSmtQRWlWM3UrdHMwVEtBMjdMYU9C?=
 =?utf-8?B?RnF6UFZSa1k5T0o5OFZqUTZmeXQ3ZzJmdkFHNVVIUWcrWDd2SXpxMFFYaHZo?=
 =?utf-8?B?REtpZ2ZFY2FPRHJQaVNBL05BWkxsRVRRZURVaHZQN0poYXFOdHhUTkFMOS94?=
 =?utf-8?B?Q1RTUkV1alNodDRSUUF5dDVmN0syS0I3NnptUGljakdyVEYvaHFmM0VUYW12?=
 =?utf-8?B?WGRybkp1Umg5WjhKSm5CTm9SSW9ZbHNBdnJ6Tzh3c3luMkdJeHloTElCSXNT?=
 =?utf-8?B?NjlXd2FJZC9nMDVHRS95eVN4STZTeUVkSjMvVlM0dHRHSVNYdXJUakZESVpj?=
 =?utf-8?B?MUlnN2w2OGpZQkM5TGF5NWIrL05JZnZxV0NUaHAzN2RJQWpubUZtNC90b2tX?=
 =?utf-8?B?Q0R1V3pWYUdnc0h4eDM3dmJueWhNQURJeVl4MUJVNlpZL3pVdEFRQ3BSY2FX?=
 =?utf-8?B?aXNYazMvVjU1aWRpdUZsSEZoYjJWTk5lZGtFUUNpSVdBamRaUUJvcVIyaVJS?=
 =?utf-8?B?NXBpZEl4NDB0L2hHZzhrRHlXT3VJYnNqd09oc0FmY3VxMDBnek9ROHJ1YWkv?=
 =?utf-8?B?THdwRGNBZHA2aWQ2blZWSENzRzJLbWZJdGtqMTZUMTVIYjVWWlRwb0x4Z3V4?=
 =?utf-8?B?eTFGdmJqQzVVN2k1TjU5V1Jkbk54U3ZFcFJtK2g0QTRPMW40RnhFdkMxRDFF?=
 =?utf-8?B?V1JOczdDYkZlWms1YnpDR3RjZEd3bnowVnMvMDAxTVdkeGFROXFnMmhtY2Zv?=
 =?utf-8?B?R1Q1UkZFWXZoZ3hEQUUyZTN1eDRtYjh4ckx0d3N3dW5mclpKVU1Fa1Zjc0Za?=
 =?utf-8?B?KzlIWWg4VzV1NmV2SGRmRk5veE9CYjJmYzB1akZBeXBpUnNoU1ljVDlzK3ZJ?=
 =?utf-8?B?bFZrQ0Rnb3k3RHQ0MTZQVnl5Uis2Y0xIa3VmRkNVMTlGanZ1MG9zTmFtdDU1?=
 =?utf-8?B?eThoRHdXY1EvZkZLKytzMVQ2RUhiOUxLL3NmY1U4WEIrNlMrUlBwMXpETWlo?=
 =?utf-8?B?SCtyS2V0aStyczByS1cvMVdjVE50VWpEdEV2UExVc05EL0RnMThPZE5YVDlS?=
 =?utf-8?B?TnpwSEgwRkpadnJ6eE5hc1oxOHA3SHdKTVdxWGdaWDdOMWhaLzRmSTF6Qk5y?=
 =?utf-8?B?a0VZeDA0dENrWVlrajYrZ3Y4aXkxeit1Umd0RHFjbEJqaWNia21EMVNDZjEz?=
 =?utf-8?B?WDVCMmE4NmlaT1NuM0hRczhrcDNZK1FJekxnRzNnYVhuRjBUcFpwWkxEdG1y?=
 =?utf-8?B?QlRVY1R2RkN5Z1hBL0FwUDBFTENHNkovL0graEdzNkNmenlSa3VUWjd2YWZC?=
 =?utf-8?B?WmdXOWNlaDIwbEx3MDVXRUdzOHZzQzY4Z2ZsNVhLeGhtODJhZC9HZFU0bTlR?=
 =?utf-8?Q?hjACO6UUPRC06E8Y=3D?=
X-Exchange-RoutingPolicyChecked: v5b71Dgxxc/Y3x3Cc3q2DUQtOlyXOW04UK/M8gpE0gbBvs6aHtFTRnzRikj06j4TTXHA/9dOji2zZUiaBlebNYiUiylyGM/TWfwxCMlT2MG8BnNjx2VXPgRHzQRepZBukYkfYea9Moqwb1UpUwG23oeud2u83qhdVrZqBuFtf9F/co2NFSYSjF9HhRwE0jDyRDmRqpn1wZkfsFnTNKmi60VKEE6S5iR54DUX5WtqP7tbYToHNljvSTCKDalWp0UfhNcsIZpjDn32mTFN/nsphUKJzYZNZPbRzmN6q7nIieRvDkz2herP1i3snJF5wz1yxnklwwVRlWjYqytC88+mgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e5abe9-a9fe-46a0-2787-08df28914f01
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:47:47.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE+G1R3T3TYC7yUfk2wBIsLgZDN/F2KJMD0PN4Wyeb5Lhusav4KVZQMOkEZT6IPoHtnYuPuqVujwfLuFbFYqHa0dx/+O1jKTAz0Gp724bYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/26 4:44 PM, Babu Moger wrote:
> The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
> It is intended for deployments that need to manage counter assignment
> on platforms where the number of monitoring groups exceeds the available
> hardware counters. Hardware counters are scarce on these platforms, so
> mbm_event mode suits workflows that monitor a subset of groups at a time
> and rotate assignments as needed.
> 
> resctrl enables the mbm_event mode by default on hardware that supports
> it. This breaks the pqos tool [1], which assumes the historical default
> mode. It creates 16 or more monitoring groups and uses two counters per
> group. On a platform with 32 counters per domain, that exhausts the
> mbm_event counters pool, causing additional groups to read "Unassigned".
> pqos interprets a non-numeric event read as zero bandwidth and reports 0
> MB/s for those groups:
> 
>   $sudo pqos -m all:0-4
>   CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>      0        0.69         16k       192.0         0.0         0.0
>      1        0.40          3k         0.0         0.0         0.0
>      2        0.44          1k        64.0         0.0         0.0
>      3        0.39          1k        64.0         0.0         0.0
>      4        0.43          1k         0.0         0.0         0.0
> 
> Leave mbm_assign_mode in default mode during initialization. Default mode
> uses one counter per monitoring group. On existing AMD platforms, the
> default active counters pool is 64 and may be larger on newer hardware.
> The active counters pool is the number of counters that the hardware can
> actively track in default mode.
> 
> Deployments within the active counter pool receive accurate bandwidth

nit: "active counter pool" -> "active counters pool"
(to be consistent with all the other instances)

> measurements in the default mode. Users can create more monitoring groups
> (4096) than there are active counters in the pool. Beyond that pool,

Unexpected where the hardcoded 4096 comes from. Could this be "(for example,
4096 on current hardware)"?

> readings may be misleading or report as "Unavailable", with no user-visible
> indication.
> 
> Default mode is still limited once the number of monitoring groups exceeds
> that active counters pool. After hardware re-allocates a counter, a read
> may return "Unavailable". pqos still treats "Unavailable" as zero.
> Successive reads can be a count, "Unavailable", then another count. pqos
> treats those jumps as wraparound and can report an inconsistent rate:
> 
>   $sudo pqos -m all:0-4
>   CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>   0        0.76         60k        32.0         0.0         0.0
>   1        0.45          1k        32.0         0.0         0.0
>   2        1.57        107k        64.0         0.0 17592186044184.9
>   3        1.62        276k      4928.0         3.2         0.5
> 
> Users that need stable measurements beyond the active countes pool should

"countes" -> "counters"

> use mbm_event mode and rotate assignments as needed. Enable it with:
> 
>   $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
> Closes: https://github.com/intel/intel-cmt-cat/issues/311
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://github.com/intel/intel-cmt-cat # [1]
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 43 +++++++++++++++++----------
>  arch/x86/kernel/cpu/resctrl/monitor.c |  1 -
>  2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c8507580474a..a896bcae3319 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -354,8 +354,8 @@ with the following files:
>  	::
>  
>  	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> -	  [mbm_event]
> -	  default
> +	  [default]
> +	  mbm_event
>  
>  	"mbm_event":
>  
> @@ -376,20 +376,35 @@ with the following files:
>  	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
>  	assignment states of all monitoring groups.
>  
> -	The mode is beneficial for AMD platforms that support more CTRL_MON
> -	and MON groups than available hardware counters. By default, this
> -	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
> -	Monitoring Counters) capability, ensuring counters remain assigned even
> -	when the corresponding RMID is not actively used by any processor.
> +	It is intended for deployments that need to manage counter assignment on
> +	platforms where the number of monitoring groups exceeds the available
> +	hardware counters. Hardware counters are scarce on these platforms, so
> +	mbm_event mode suits workflows that monitor a subset of groups at a time and
> +	rotate assignments as needed. The mbm_event mode ensures counters remain
> +	assigned even when the corresponding RMID is not actively monitored.
>  
>  	"default":
>  
>  	In default mode, resctrl assumes there is a hardware counter for each
> -	event within every CTRL_MON and MON group. On AMD platforms, it is
> -	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
> -	events between reads resulting from hardware re-allocating counters. This can
> -	result in misleading values or display "Unavailable" if no counter is assigned
> -	to the event.
> +	event within every CTRL_MON and MON group. This mode is enabled by default.
> +
> +	On AMD platforms that support more CTRL_MON and MON groups than hardware
> +	counters, hardware dynamically shares a smaller pool of counters among
> +	RMIDs. One counter from this pool is used per monitoring group and counts
> +	every MBM event of that group's RMID. The size of the pool is not
> +	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
> +	much larger. For example, 64 counters in this pool monitor 64 groups.
> +	Newer hardware may provide a larger pool.
> +
> +	While the number of monitoring groups does not exceed that pool, a counter
> +	stays attached to each RMID and readings remain accurate. Creating more
> +	groups than the pool can cause hardware to re-allocate those counters
> +	between successive reads of an event. Bandwidth values may then be
> +	misleading, or a read may return "Unavailable" if no counter is allocated
> +	to the RMID. There is no user-visible indication when this begins.
> +	Users who need stable readings beyond that pool should switch to mbm_event
> +	mode, if supported, and assign counters to the groups of interest
> +	(rotating assignments as needed).
>  
>  	* To enable "mbm_event" counter assignment mode:
>  	  ::
> @@ -1787,11 +1802,9 @@ View the llc occupancy snapshot::
>  Examples on working with mbm_assign_mode
>  ========================================
>  
> -a. Check if MBM counter assignment mode is supported.
> +a. Check if MBM counter assignment mode is supported and enabled.
>  ::
>  
> -  # mount -t resctrl resctrl /sys/fs/resctrl/
> -
>    # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>    [mbm_event]
>    default

After the above doc changes the mbm_assign_on_mkdir description still reads
"Enabled by default on boot". This is still technically accurate, but this patch
makes it unobservable by user space. Fine with me if you intentionally decide to
keep it but I would just like to confirm that you considered it?

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 5d0d3b18f9b8..a6a9090c4808 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -472,7 +472,6 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
>  		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>  		/* cntr_id is 12 bits and can only encode 4096 counters. */
>  		r->mon.num_mbm_cntrs = min((ebx & GENMASK(15, 0)) + 1, BIT(12));
> -		hw_res->mbm_cntr_assign_enabled = true;
>  	}
>  
>  	r->mon_capable = true;

Reinette
