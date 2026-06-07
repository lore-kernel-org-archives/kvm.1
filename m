Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD526E165;
	Sun,  7 Jun 2026 04:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780807281; cv=fail; b=Ns49bMayHNGNJ9xj+asu4knU1n78Hxwx21D2OHBLCv8DeRnKb6GeaRJDf4U1EPV0y7q0L2YwuGWv3rT9oySGNmjs4imMxsGeGZtrqCeBFTU1Ljw5PzQYH6Zp7IP1o1Xt0CmfLp5DvWXkTJSc7DyPKdffWFqLQSsdwjSPGTStXh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780807281; c=relaxed/simple;
	bh=BPgw/lAO3yGCiwM+CYdO+dHrstObDQcjHIR6fRp1s6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sju3cJQRP4tDG7Ycc93xK9kQ8TltW8J1RG6USLznEPwTEbVfKwlCfxOhT3y67hkwXvnuOG1LGtALZeQnWRc/+XeFPfkzBGXl6p+iFeZkhF/zVRA1Sn7mV2m/KSDei9fHLRUscZ6wAtodYHlLY70otdSRLxjVEaDpgXLNn7qybQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJEPaQc1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJEPaQc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780807280; x=1812343280;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPgw/lAO3yGCiwM+CYdO+dHrstObDQcjHIR6fRp1s6U=;
  b=KJEPaQc1FEPVDd3sFnyfKljG5bapvBnklK3TWMbUUlp/poPm+bUDICOA
   S2vtmGN80vJ0E6sqtg9Qt2A8z9ff7XRGLPceXcnKuMpDSVQoJbsT5I3/x
   TD+1rmUI/lLM+eoMa6JEMpvlQMGQj9iyn3V8S+DIsfB30G8dZCc6wczUe
   PpppmQP8MDSQz+x4Mz+QQvPki+TpwdyM7rs1nDeyjJAIUxzzIo6r+A/nB
   4vTH0Zabpd45wjZ16N3lB70KnRa/YOjv5317mu77YpS4QJuZJQ4aNDcuI
   K13t6o5zuN3wx7fY+8seg/fewm2agrn+GlRpNuZOG4OfInvjuC8oc8sNN
   g==;
X-CSE-ConnectionGUID: LPGEzbC0RV2VOz9rf8d9XA==
X-CSE-MsgGUID: qnEGpHZ4Rwuti0zGRk9tsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="104241401"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="104241401"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:41:19 -0700
X-CSE-ConnectionGUID: XQumVsqPR1G/QiWuF85iCw==
X-CSE-MsgGUID: 2VAKSE0wSZaOnpUeYJ1jYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="244352945"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:41:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:41:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 6 Jun 2026 21:41:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AATgGL07C0W4ToChglFsoR8T/tMOHYkO1yik1LaROJQ5ALID1+rM7QyGYyA7ig5q2FNA+0JTMFop8M+bl+20npXOL03TgdfpU6Bx9JVLruYg9u3ftZaniIYVtyauOggmVTdqEwAWwgH9C/LaIsN0Xto5weazoSIJaF0s8yuT33UIUg9dQv5Kiy6KPeR5jn9pRmSQzBNinUrzMDD8XdJfSQjdaWJhY60OC7Flqtb4sSkc2q5HEsjt5eiwvnWy82ukeDmlNSoXH5hgjvcy4vg27nKSezZ22kbuvKitbMgClusShzDujsQfe9EFdLMI9pybFQUYgvbkxYjMtCkuM9NeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5zTWQWrvdgaJvL6F4U0Qk1x8WpleDZ5m3PbzbKT0fc=;
 b=i3qvIVfUNDinF07m3KkPBJcPfipn1ndUqRnWgU+HxnRpxTgKtOpTDquYZ2WYSjKXBe1M2v1NJCzGGXb+1DoGfCFyjMGYdB4naGOLYQ2OSJghyEqb9HS1nRGqDP1lKaYi/l25gbfm9NmdZ7e97lcrK3rwxgLB+fSqzeNXRHQanosFoQdnFJqQkwEBBec2i/yRPlb6K6/KT9QpeAbzkw6mlgoZeEoThoA26qtpPbqob6b3GGSGuIP0EpmcjNRhn1HgrFHc0rAzjNtgUydxGE5LJnMJdU1D7RXx1W/YLw0aGDh9ezFYYFd/m+P0k1NGOV4jFEuMdanIPLB1RuIcexH0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.11; Sun, 7 Jun 2026 04:41:15 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0092.007; Sun, 7 Jun 2026
 04:41:15 +0000
Message-ID: <caf5de99-bce3-4dc6-8757-cf2b4aaf85c9@intel.com>
Date: Sat, 6 Jun 2026 21:41:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20260522034128.3144354-16-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9d1d1c-48b9-476f-158a-08dec44f0277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|11063799006|6133799003|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: d8B9VLvbXpuHOHOA0B2xLo9gXlZrPrY8P9gfzLEDvghHnljTx/oGe32YAaGLU+xAJw6WJcVkc41ve6IuOeewuOg4lKRoREXtF+b4q6ibnRJnfijO/PevpjChPRy9P0jV8gKpHelIxmwc+K9nKGziwElcTwxtTiPYuIHYKQViaiuQsBb6wjy2QHNca2F5sDJ2rybqihj0pMauCJihc12UXbUGlHE8JpdmTZFVTknBA8KJ7nqvXWCRT9KqcXW0VlQz4OonHSthlG52M+uD9iRZeWtospqQq9BvmV2l2+iaec5gn/9aKVhJhkTDthAoSQx+wuRANSfPOaSmbfe9cKx7KhcxIptWs084EElKHj1Xvpz1C7JC4ny+NUl55ujbLOdjNLz06rMbpHVlhh0M0Pj8Ar8Zg98p3TJgh3x6cwwsfA4MDZHvOzowMSnxsn3W7Gqxtt39VCnyzLB87lFvja0PFV0b8Fn+wsA/Wt3sUO11aikHqHCfES69EVk+GpFIQ8xuuZQ3G/uOiSQd+TVTE1Lk3gXY52NHWyvozGh9VLMX7DqCEsj0RMyEui46raXO4VwZCCjos/7LbSdN4rKYW/D5JKg1ZKF4FIcefV67O6Y3x6lKKkt0gT+ryEJr99N1BXnpi6YnfdhKtzssizYhovkE4f/ZzxA8wz6SaHu2dyiqTs3Oq9d6r5Bh5xoMlXHiBD1r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RllrbGVHUFV0Q0lsVjdJK0swbGZGWUFMQjVrZjh2SkNhZVhaMTFUc1F1cjVl?=
 =?utf-8?B?a1FuelVaN2FkejU5Tkg1QW40SnVLVXVIWHpLcmpzaDBDTlQ4bC9kSFZvNy9t?=
 =?utf-8?B?elF2cENuZ2NWTy80SWpkcDNJeWhQYVpzYk9PeVo3dEJGclZnZE01OE4vWkkz?=
 =?utf-8?B?RWtSdFhGSGdmODZFWGxCbDlIK0Uxc0F4c0hSaC9MVmU5aytKS2ZudjZNTXUv?=
 =?utf-8?B?NHNKVEk5YytvdlRWam1OSGtPOCtvZk9ZMjJ0bVEyUGFOY2l0RnpJckFqK2dU?=
 =?utf-8?B?MVh4NnNZdHJUWi9JVkxrNTQ5RFczL3o5b0RhUHJ5NzlwRjdiaGRubklzZk9h?=
 =?utf-8?B?SjEzZzlPaDYrS3dsc3pNbVBIays4QUF4d2tGY3VobGtUeisyWGpjL2dXN0ZV?=
 =?utf-8?B?MlNHQTU0ZWkwYjFjazBZTDk4ZnAwOTl4RDlWSWlDNisrcnNvWWk4T2JlV3pT?=
 =?utf-8?B?MS91SGlpQkRQZXFkMW9UZjhFOEVxV21zazhueVNBdlNydk5BdU52RWJWMlNk?=
 =?utf-8?B?MVdRV2NmUVJBcTRPRVhPcE53OTd2L2tGYWJXYmRIbnZUMzhIdjhJalNVRk1r?=
 =?utf-8?B?NnRoV2dkbnZXUUc1UUZLMyszRjdNa2ZNa2V6cUEwWHBVak5wOWI3K3AvTldJ?=
 =?utf-8?B?bmZkeTZMUVVKdk93d2grV004NEpUUTlYcEN0aWtmNVZmN0tsT0hTNWFXWFRw?=
 =?utf-8?B?OHpmTkxmV1E4N3krUmxkWHFlUVA2QWJRT2xOeVR1KzRKOXU1UFladWozdGhY?=
 =?utf-8?B?M3RKNFFxUER1NUg5VjY3VitUZGxrVW1iMXg1VlhBWHZlY1N2QTBjR3dVMVFJ?=
 =?utf-8?B?QUZBdmYwUnAvYmNvTEtnd2pka3o3N2UyTHkxaE90YmtzN284U3hoWjRoMFJz?=
 =?utf-8?B?eDRJbmVuR0hzVytXRGcySHFUdlBIRFBiK0Y5YzFFZitQMUFVbm13ZHh1dzZH?=
 =?utf-8?B?eVIyQVl1Y0ZURERRZW4xVG40eG8rMGNGcFIvblFSbUZ3RlRXSWEwS1BjVEZp?=
 =?utf-8?B?MFpvNEtWTEh1N01wN29SNlgyWDRNbFVBQ3YzSXR2V1huY0ErdzM4TVJqRmRR?=
 =?utf-8?B?eFlYOFoyY2xZMCt1Y0NweFN2MlpDSGdPaGNyZHBrdHJ2d2kwaGxNUVhnakxV?=
 =?utf-8?B?YnVmS0tQbHZjVmN4dnZ2cStuenhkcU9lZkpJaHZoV3AyMEpQS05XanNVVHZ5?=
 =?utf-8?B?RFJWbUFYdU13dE9yVWFYcmcxM1k1Qm5GMnBCQzgrUmdvakNGUnRLTHlwTG5B?=
 =?utf-8?B?RlNGWE92cUZaSzFkSnllSGxpUEN0WEk1ZzI2ZWhVSjVFelkvRFZlWjgzeWQ5?=
 =?utf-8?B?dEkxSlNGd3FDMy9HbW9BVE5DSkxMWGtKRkNkODNVOE1iM0hiVEswcGx6L2pm?=
 =?utf-8?B?TVFFU0lIL1VDODdNUE9VclpDSHZUV2pxK055ZkRmK2tLMXc1UG9OTTllbTJD?=
 =?utf-8?B?RzlDVXFVRkQrWUNpd0NndlorcVVIZmc4Ym82aVIxcWJMdDZRa3pXRkV1UFdp?=
 =?utf-8?B?akpJT1lERzBtNHNHQW1sOHBCOUNYUk42YUFTc3Q4YzFoVjJmMW02U2VET1Uy?=
 =?utf-8?B?N0lGaUxoU3dWRTJ0ODB6RVFoZTVrMk5oaUxHaExBRmF2RVJYR0hTTEhEcDZq?=
 =?utf-8?B?OUduMWJaYlpyc1BjQmlDQWJuMjZ3OTdMeEpzMDNYZElncTlxRWxCa2xwR29U?=
 =?utf-8?B?c2QwdXlYT2lMSFIwTHF5dXZaYUw5dUxpYmM2WUUwZ2pXRXlvMEErcFFBZjFE?=
 =?utf-8?B?NEZ0cThmYWJ0c3hPVHdhVDhuZUFOeTZvcG9EeVd4YTlERXZHZGhsYk5Wb3FR?=
 =?utf-8?B?YU9XVUJKUFBIWEpDR09yaldMVWpObVd3d3ZWNnlQYS9kNndtQkZ1eEg3K2Zs?=
 =?utf-8?B?WW14aFhIV1IrZ0lSWlNRTDhOKzV3Zk5UZFZuSjdRQjFKeVJtWHgwTFV5dDVh?=
 =?utf-8?B?enZwQ1RucDhCUEN6WDVlR0FNd0Z0dEYvZ3k1eVV0WTh6U1U1bXhRVi9mY05R?=
 =?utf-8?B?elBWQUxjR2hqM3R0WWpPQmlmemN3NWpWcmJrODlObE9MYUhKSXpxM3Joa280?=
 =?utf-8?B?QTA2Z05mcDdYM29sdlhuMzArVUc5Wi9mRUlHM0ZPTlUwdkRnajFBTFU0bjRD?=
 =?utf-8?B?QWcvU3htcDV6Z3AxMFk5QmgzTUVISVBTV3F2S1dNMTdNMUFKUTcwOHBtWHE2?=
 =?utf-8?B?ZE04Q2FidFNTL0lRWFZDNWl6RE1YQmpkR1lNdll3S1N4cXRhQnpZcTQvSTBa?=
 =?utf-8?B?OXdvU1lVRHo5NWE4VFovd2Z0cHdMb1ZIblYzUUhwTFBlaFlYclJiNVZZdmx1?=
 =?utf-8?B?VDIyNGdLZ0hva3dHRFdMWWxXb2RpZ0VTQ04rbys2bFF6Znl2OGQxUT09?=
X-Exchange-RoutingPolicyChecked: Ilqc2CPtoSwT/kEFxadR7lih/V/gk04m/k+c4rBKHjYCWMEP49KMro/EswwWcy+oixeM+fn533+8ti+BAkZ79+whoRWBBP8/8t3MeZ2m/wqUAPSn1/6SG7KJsqlCVMjobqeCSv+U4/uoTEYPoQhmwF2NQzxfhTz/dr/zNK7DiZycYMbOx3gpyBDbXH/wvJTN8DKgKp0oBAOi6d7VGZMIw0UbpuiOao6hnwuasfHC1o0K2MFbuaxEDVx97d3NEAY3VRIAmbsnhSh16U1pQSiQpeNwcApcQw7WYtilqb968qHZPTXsGchxascuL4aqiuc0OKcV5y6GAGvmZlYdy9r4JA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9d1d1c-48b9-476f-158a-08dec44f0277
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 04:41:15.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKDKFhfXChwUvOF+ntW2hHc/ntNr6gHrOpWqQyiGwO3Le7tyLRIrIpxTEC7gKsLo3tt3y86RPKrvEt+qinca7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com

On 5/21/26 8:41 PM, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Enable the TDX Quoting feature via TDH.SYS.CONFIG when supported by the
> TDX module.
> 
> The TDX Quoting extension generates TDX attestation Quotes via a
> SEAMCALL, without using a discrete Quoting engine.
> 
> TDX Module supports add-on TDX features (e.g. TDX Quoting & TDX Module
> Extensions) that should be manually enabled by host. It extends
> TDH.SYS.CONFIG for host to choose to enable them on bootup.
> 
> Call TDH.SYS.CONFIG with a new bitmap input parameter to specify which
> features to enable. The bitmap uses the same definitions as
> TDX_FEATURES0. But note not all bits in TDX_FEATURES0 are valid for
> configuration, e.g. TDX Module Extensions is a service that supports TDX
> Quoting, it is implicitly enabled when TDX Quoting is enabled. Setting
> TDX_FEATURES0_EXT in the bitmap has no effect.
> 
> TDX Module advances the version of TDH.SYS.CONFIG for the change, so
> use the latest version (v1) for add-on feature enabling. But supporting
> existing Modules which only support v0 is still necessary until they are
> deprecated. In fact, it is unlikely that TDH.SYS.CONFIG ever needs to
> change again and the code would stay in v1. So there is little value
> in worrying about deprecating v0 to save a couple lines of code in 5-7
> years when these original TDX platforms sunset.
> 
> TDX Module updates global metadata when add-on features are enabled.
> Host should update the cached tdx_sysinfo to reflect these changes.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.h |  4 +++-
>   arch/x86/virt/vmx/tdx/tdx.c | 24 ++++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 10aff23cd01f..524a14c01aa6 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -58,7 +58,8 @@
>   #define TDH_PHYMEM_CACHE_WB		40
>   #define TDH_PHYMEM_PAGE_WBINVD		41
>   #define TDH_VP_WR			43
> -#define TDH_SYS_CONFIG			45
> +#define TDH_SYS_CONFIG_V0		45

Is it necessary to add _Vx macros when multiple versions can co-exist?

Just wondering if it would be cleaner in the following way?

- Leave the macros set at the current (non-deprecated) baseline version.
- Select vX using SEAMCALL_LEAF_VER() in config_tdx_module() when a vX feature
   is enabled.

u64 seamcall_fn = TDH_SYS_CONFIG;
...
if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE) {
...
     seamcall_fn = SEAMCALL_LEAF_VER(TDH_SYS_CONFIG, 1);

> +#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
>   #define TDH_EXT_INIT			60
>   #define TDH_EXT_MEM_ADD			61
>   #define TDH_SYS_DISABLE			69
> @@ -97,6 +98,7 @@ struct tdmr_info {
>   /* Bit definitions of TDX_FEATURES0 metadata field */
>   #define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
>   #define TDX_FEATURES0_EXT		BIT_ULL(39)
> +#define TDX_FEATURES0_QUOTE		BIT_ULL(50)
>   
>   /*
>    * Do not put any hardware-defined TDX structure representations below
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index f7600f930c6e..86e5b7ad19b3 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1049,6 +1049,7 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
>   static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
>   				    u64 global_keyid)
>   {
> +	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
>   	struct tdx_module_args args = {};
>   	u64 *tdmr_pa_array;
>   	size_t array_sz;
> @@ -1074,8 +1075,22 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
>   	args.rcx = __pa(tdmr_pa_array);
>   	args.rdx = tdmr_list->nr_consumed_tdmrs;
>   	args.r8 = global_keyid;
> -	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
>   
> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE) {
> +		args.r9 |= TDX_FEATURES0_QUOTE;
> +		/* These parameters require version >= 1 */
> +		seamcall_fn = TDH_SYS_CONFIG;
> +	}
> +
> +	ret = seamcall_prerr(seamcall_fn, &args);
> +	if (ret)
> +		goto free_tdmr;
> +
> +	/* enabling TDX Quoting may change tdx_sysinfo, update it */
> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE)
> +		ret = get_tdx_sys_info(&tdx_sysinfo);
> +
> +free_tdmr:
>   	/* Free the array as it is not required anymore. */
>   	kfree(tdmr_pa_array);
>   
> @@ -1384,12 +1399,17 @@ static void tdx_quote_init(void)
>   	unsigned int nr_quote_pages;
>   	u64 r;
>   
> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE))
> +		return;
> +
>   	do {
>   		r = seamcall(TDH_QUOTE_INIT, &args);
>   	} while (r == TDX_INTERRUPTED_RESUMABLE);
>   
> -	if (r)
> +	if (r) {
> +		pr_err("Failed to enable quoting extension: 0x%llx\n", r);
>   		return;
> +	}
>   
>   	/* Quoting metadata is valid only after initialization */
>   	if (get_tdx_sys_info_quote(&tdx_sysinfo.quote))

