Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DE44B696;
	Wed, 27 May 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901796; cv=fail; b=m2Quhvy9y4qyXONknmCzxbA+HBqOAzfxUmu8+Ql8vcN8mh758CmG4Dy9Ioi5qr68p9HZXKwGer5BayjnGToTGEmefC+UL1tPO0dLwZNBV/P8iDawYvKFg+O/YDH63OKz02gaUynnuz6HwTLmf6GJ9yNUOq0s4yskyzUXfcnCUcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901796; c=relaxed/simple;
	bh=ehT2dUo1gl3HGrbcKEDA3/U8W4NAGhNDIzKo+0lSdbs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q5N097L6c9Due3frWJkjEggdnhwIDwWr99PCyPHqCZeUgCG/g3OdLgvUYst3xu0fukVzUoP5sXxNWNS58ZmxmddnraA9pw1Vs8JqNtO+a/oAFuoJDCELjy4ZfTovGdTNw+/vrB1PNSckcY1PUK7XnG4lWm2+JpozDo0qpWgYnoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3m6B7Ud; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3m6B7Ud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779901796; x=1811437796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ehT2dUo1gl3HGrbcKEDA3/U8W4NAGhNDIzKo+0lSdbs=;
  b=l3m6B7UdtYIA7pyFns5NDGP/46V4XscnESfBOIA+iYVt5Q9uac16hqCT
   cMqoPqTbX99mz7Ri7u+zOlQPV9SmnkcucGgmmsvCxWvxgfbeeVRR030yV
   abLsyvWxOyXWzwfWXgoW0geyR49sxti/HHRcKXSdgDYyK/AMYk7VX3qte
   gUc8qsseVZ/R2svc8fC/60NZVDmQ/PckXRrcECWb3NOfcMvKk5EYaVchi
   43w+GezLF2u45Kw2Lvuo2vJ58mUcDSRnZ8s4+oMLnvmP06+i4CHN4NvV8
   mTRaBVfLWdfrm2WO7KRaZBy8JzXNov0E8nwPDzRTiVNMnXku5w6avhK0k
   g==;
X-CSE-ConnectionGUID: 2+eC+LZXRX+kGpe4ERD91w==
X-CSE-MsgGUID: 505HWV+cTgK3h8dPDGcVDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79774847"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="79774847"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:09:55 -0700
X-CSE-ConnectionGUID: 3T2KtWatQ7Sr2uLAjQMO3g==
X-CSE-MsgGUID: eOqg755jSsewB9XjALyyOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="242365408"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:09:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 10:09:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 10:09:53 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 10:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/rFX99MgTzicLWKHJ5LS4zGK6RAOkDmwL1CbmGESqvElnDtuAn/ubaEa/K9SXqgGwHqSJEfD9qBa+3OUMgPVU796bU0PUoKqWgE4iwXKaFwJ2QRCu635dbeBigK31wlfD3+5mUeEjvYTZq6wreIFx4aHgxMozYAoqwaC67RfJfkSY2RFTsn68b76ch1slpKDrcRdaqHpU9OYn0n51o7g3Eqk2hJNNWIz3HGqQrGNuafHgKv0Z6O02SS9zjsNubN+crpYYahdm3lgIXEkEcPDgOud1tnxNpTs7yv+PZgzZ+/mUehW6pmFRH/WC/eXTD+5mQKzrfwf7gT0I7IEoLX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNIthXf7wxA0PpUQ4uhROFsV4kIG6rr9qfVCyLzRF70=;
 b=LU3uo1ITn1XiaMDb21RvUA/vkN7kAxi3BIQvctTTl0IMYotTSaUf6Q+V2wtoNyUUnCuBNghSKYyoOmAM7mh5IRrGtREBJ+/UwTm/6+LhC0s9x0Ds2pS/dHN6LDRYqTuS3/9XeB6tTQGssvc+HpAXNYg3VmfMCQmH2es0VinQOGCbMeyGz1H3OtHzfoufuKSeByHGgUa6OSnDWGRO396UtACkj7epDdSwKTiv4+QS6QKotpdI6exbBJPhsdsuR4W2JhepSDi7v0Bx2HCO96uEquJqyhG9Dz2fkVgYOiT9Qg46fiGQn30XlLIiWGfDG0zpN3Ze9rNdYX0hFte2ssOuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS4PPFEE549A404.namprd11.prod.outlook.com (2603:10b6:f:fc02::60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:09:43 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 17:09:43 +0000
Message-ID: <e9b8083b-6747-4adf-9e48-ffae70dc6508@intel.com>
Date: Wed, 27 May 2026 10:09:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <kas@kernel.org>, <djbw@kernel.org>, <rick.p.edgecombe@intel.com>,
	<x86@kernel.org>, <peter.fang@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
 <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS4PPFEE549A404:EE_
X-MS-Office365-Filtering-Correlation-Id: 237c0ad4-facf-4da1-e12e-08debc12beea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|5023799004|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ceIajPTqGa/BYho1RqzTiA09AzS1iAOOb84lNFPCfok6dzsaXTYYu1DfvqlgiqjzOu8GNUVByHIT7yUw28e8yxMAOvLyVKthvmfJ0lVHVRTMSj/5y6AmeC3BxsS309RjsHveiL+BMpSx6kyDjGi8/zk7LK4WO9Ft9wPARkMdDngATjmG4Y26KyJ59TiRCJym0Rypzrf4yOJ36cWk0Le4mrjSfQ1bp6l8vEUBCWEBY6qnqzjKLIXwbSV6+EfyX6mAkcLb2ni9e0JpaaLF8D7yNiuuYQI8+ZpX7tXs5w3JRNpHQd2AIpStY7B81TUle6pN0svD42EhylQoas28CMrQlvXsEjoxoXa7T5qhZhfitkRx8jfZukAxCAQzVchvxqYiYpIP7O0Ukyj2Dta+9elmZQHQGdOEL7VeGPD07YdrjOOq9qW3asaMryOltAU35W4QUjNGikyWcy6RbvkZguw9M6xGFZSZoqkpRtOyYM0qZe++OBfjzXRT2QP/8H/Dx3EkjVzJNB3O+LBEF1IwAavbdu6lP8AeMT5Pa5cXWjqWhx+F1IuYQmgYlV1UN7KLrqj/lseLgPalJPm8ZzyZE+1K85R8IZ7SEbwVP6sRPbCGDpPlBOm391UewXUKlbgBk0Ugl+M5NvMEa47QFvElUrvtr3zRc6lTtEb52BVCuEXqYQeT/Z91R54Q/fW7pj2qrf0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBCZVF5TXhtVlJQekxNM1pWMngvS3hhb3RHNkNSeFhFRU5iY2Nld2VhdWpo?=
 =?utf-8?B?b1FXN0E4Vmw3UG5lV3d2eHFhTEQ0bzVvOXd1M2ZnNG9XamtZRlV5MmZKMUg1?=
 =?utf-8?B?OEViaVlhelBwZk5KcEh5QXVBTCsrR0UwTWloMEVjbGM3ck01NzlCeW9ZYzZO?=
 =?utf-8?B?bVpnMW51SlhQa0lONi9pQjJyMklDbFpFQzdMTHJ0a0dBOVZBK2NSVHdITXBr?=
 =?utf-8?B?SEcreFNBRkJVTXErOHRwVTQwVUhwdWVuYjc4SUtuOXh3dG5RWlQ5bGFwOHlU?=
 =?utf-8?B?SGxZWTFrdFBRa0U0VnEvTzlHdkZhTE0zQS9yOUF3aFh5ZXRxcWNGNmdqdVhM?=
 =?utf-8?B?VHR3SWlTcldGUmtzNUhtOERucURPNlY5NEVQRlpKT1VLVkU2elhZcUh0OXQ1?=
 =?utf-8?B?RWVGVXVOUG9rYWFwMXFBU0dlL2tZOWxNZEM4NlZ1cTRvd09SV2FCWXlCOUlZ?=
 =?utf-8?B?TWd0REJSbXlDVjlCejZXMGM3YTVoc1FmTmFMb2M0bkptRmNENzBQN25pL2tr?=
 =?utf-8?B?ZjdJUklvZGVHZDJNRCswK2h3eS9ITGw0ZkVodXRMa1VhUXJIY0JBL25FQWpF?=
 =?utf-8?B?bUVCM3lDSzZMSkZBNWcrSXdlbzNtc2hJVHp0djNvS1hOTHUxT2k1QzR4ZURR?=
 =?utf-8?B?ZURVSVVqakc0RWkrNXRYT1ltVDhHTU9OZ1BmcDA4UXBkVUVLelVWVm9uVlhX?=
 =?utf-8?B?OStKL3hKUnNOdjRhd0c5OXBpeWM3N2pxWUpOVjJMVWxBZUpVOWU4STFreDNY?=
 =?utf-8?B?bk0wKzVQZjJKS1NpamQ1Q3hzZHBqWi9OejU2SC9TK0owQ1Z2c2hGZTN4bGJN?=
 =?utf-8?B?YktpMzZGQ0w2aUJzKzhVWktjdWdtcXRmc2QwZEhZWE5MNkxSZUljbklKZDAx?=
 =?utf-8?B?UzlydldjdHRXcExyQVVLNVdVbDVJWFcwejFvbCtXZkpOWkRnWEZUS2RoOHlL?=
 =?utf-8?B?dTVrcWdQVVhlblJwSW4zNmJJV01DUzBxV2F6NG03blBONUgwcnRWTHNWZ0F0?=
 =?utf-8?B?ZTh3bGxXN3RaVHRsWW5LbDJPVEFVaTlSbjYvRmVPRFRkdEtpMmZFa2JaOHZn?=
 =?utf-8?B?RVp2cG5PdDJKOExyS0Z2QVRGclRBM0VTcE1GY1pwN2V6WW5jOEZnRGluWW1q?=
 =?utf-8?B?c2pvY1dLZnhVdEx2azBVVzFrdDlxUWdLU2NVSjZMZDJ2c1dZb0R1WXNCL0NE?=
 =?utf-8?B?cXk5Zzdwak1DT1BNOHJ2ZUFUVzhLUFZpVXBkTmFsSys5QXhmNUxrWG9SNVZK?=
 =?utf-8?B?OGUvRytzTFp3UU5NZThBUGJkbnI2NGZ3bDhWT0FqRlZjRkUrQjZrUzhxVXV1?=
 =?utf-8?B?TEpoblJQNW5teVgrby90M0ZJQTJxdHB6eXZVVHl4dU1WUUlIbkl4U0hNWUJP?=
 =?utf-8?B?bEM5V2J4VVc1QmpzVStJOWRVaVNiMGhXa2RpNGhJYWlSdE1EY0hFUEs1UFJW?=
 =?utf-8?B?K3JhYk9memRXV3lwTzJPcGlXY0VNYytraFdacjNYS2VtTzJRbTZ1VXliRmJV?=
 =?utf-8?B?azRweDBMTVFBMGJ4K3dSNnlrNC96VG1XcUFibnR6cTRnS2FsQkxRcEVjNDF2?=
 =?utf-8?B?WkFlSjkwRjMzQ2tHOExNNWszK2JoRkRIeDUvWEZoZktXMlF0b3dieEtqQlV6?=
 =?utf-8?B?OVdYQWY2cXdNWHZMaDdETkQ1NUFDSkdEL0hKSzBObXdwaGdhaStTZm1EQTNu?=
 =?utf-8?B?OU1RaDFWTkJnSDRpM3pDNFF3dUVPSjdLRUk3blRCK3l2Q3g2d1ZhMDZrVVFP?=
 =?utf-8?B?VkFuV1Avb1FiVFhiRlRzb0g2UTlYQTRiQVM5czMxNXdxcHRWSWxlbFhxZE8z?=
 =?utf-8?B?TFpkTkZMUFJEVEFDeGhLUEM3dmx3blFPYmpjcmlOa2dQNDYzODY3V2RkVmdW?=
 =?utf-8?B?aGpXVUtDZzJ5SGRPYWRac2drSUNYaG15cXdXdHo3NW5ST0RrdUprUlBwME93?=
 =?utf-8?B?azBjaTNraWZiZTJiTW12QjVpaENjTlVkTGlzQXZpMk44SXMxZCtFSXQ5WmJT?=
 =?utf-8?B?a3pPS2FSZk56Y3lhdXhlL3NlbEZGTFQvcmZ0aHhGdUd4RU9MeUl1UlVEb1Zm?=
 =?utf-8?B?dkYzVkNyM1Irc2NZUFhHbDdqWFV0RDNqem9IdHBwanBzZU16bktSVUVpL2tS?=
 =?utf-8?B?anBFZTYvdnpocDFJZHRuU095ajl3dmdXdWVHb01ERmZUeWN3cVVYbm93cVFt?=
 =?utf-8?B?dzE4ZHFXakQyYVNIazlMU3JQYncrY1ZHd0hqK0l3ZnlVWmx1RVhpU0FrN1Vw?=
 =?utf-8?B?K21BVXZBS0dDOXAwbHhqSUI4ZFVxVVB6UVFrWldaYzh1dmJFQktQU0NrR2tO?=
 =?utf-8?B?azdaSnc3WjAvVC9lTExtQlM0dlMxVDBzaFVCbE40dFNiQjRLVVVKdz09?=
X-Exchange-RoutingPolicyChecked: lXodTcGbZmDNFq9ZW5IVZXdWpdz0J18hhsjPUvlFmOQYu70uUJhlyrHt6AkmiGJjkJlMtO65kT0XpwMciWxmoY/Z+oG7aaVUXM8PrRY5XYN0ObH1jIOU9UGo1GuRDAeQ8U6cPsAmSByJ5wj2lqjC0vcPZR7I2EEgteYPkbR/56QUnyc0a/5tKD9Ood2LY9DG9+f/xkF2eWlVONabjqZe9lHdDBMoNx2fCGMzHknzC31tYCSISw3b/fgfEzQGRkQeTp9uAWRdwblXYhM80HBnI9VSDzMulWwGEOV+ZISHaP9Fm7NKE1ETjU0o9/WZs8L6wfEluFthXlyk9A/rF/AVxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 237c0ad4-facf-4da1-e12e-08debc12beea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:09:43.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x27CGwOXVcLXWvmHx6fwUtTFZHsn+0ccUMEiPj2qxThT59JboUEEXsGfJxtEaJqpMqrdzvoc+rjxjAe1AzvBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEE549A404
X-OriginatorOrg: intel.com

On 5/27/2026 3:38 AM, Xu Yilun wrote:
> 
> Because for security purpose, these add-on features are always needed,
> even if not all of them, so Extensions will most likely be enabled.
> 

A cover letter is a good place to explain such nuances, alternate
approaches, and tradeoffs.

> And even if someone switched them off all and saved the memory, compared
> to the memory of a typical TDX capable system (lets say 1TB), the saving
> is still little (0.001%).
> 

In this case percentages make it harder to understand. Does it need a
fixed amount of memory (~50MB) irrespective of the feature or the number
of features? If so, it would be good to mention that.


>> In addition, could you briefly describe the complexity we are trading off?
> 
> If we delay the Extensions initialization to the first Extension
> SEAMCALL, we need to maintain additional TDX state machine for
> lifecycle, and we need mechanisms to synchronize parallel Extension
> enabling request from multiple callers.

This would be good to include in the cover as well.
