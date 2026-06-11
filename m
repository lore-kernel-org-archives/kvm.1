Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B648B399;
	Thu, 11 Jun 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198164; cv=fail; b=omOtQtDNjdx09SUcy5n8AoQibjpELm6e8Blf5+n2OFQEuZInhD2geEfCDAh9Rz0FFTcwSdg29w4s3SqpA2bXPfmc+i75ti1UZsXjTXR4qoBqsGHloO7BD1nz8oKszGm5cyro6f0TQSyeU8mTncLyG3XGlfRDk8XfpKWUoL4IWWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198164; c=relaxed/simple;
	bh=BLFoPxl2cS3zNa1a8qxRL6jYkGC08OJX8k/rnMRAstc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Buyow5lqiDGyiDPyisFwt6tDiI6rxxM/Wl+vLHJK0OPZVsBdKsPrpp6YpnvfmVyl7Kkpt3nhIoz8PgRwJCcGCmYrUS1f/WI7v+Wy4K8E29AwOmYWVdbjOJ/NhMh6a6mSxk02CSEP3Bmtdr7TQwM9NpKvAm5NKxT2VZGGlA812i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5SsPJyS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5SsPJyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781198161; x=1812734161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BLFoPxl2cS3zNa1a8qxRL6jYkGC08OJX8k/rnMRAstc=;
  b=m5SsPJySnyDhkVCi0ONgQFmtJSo6f48fmdh/cCUG8Q73/ixLBl0Clk83
   dDxsrtBxOOYudk53oKOkpCjw4zkb3cauGh4FUVbpxE4CTQKGbcDJCqbWd
   0SSFeAJS5w9FGYVVRxvEbiYS7FSe3GkoNboN25HGNvtX/g1IXYVURAmX3
   ckUINKIe/qHvqblIXTFVQ5tqxDZ0CuKhanwCA7CoXeebpHGAmRUGWhxe0
   Paq5b4Q3qPoDg2bKj8vcOFbFudj6eA03LvoVjJdDGEHSUzd4E/dZ4Glv6
   TAqg7i0VOCwN1IQIh1uuMRFOKa33oB7WJa3GfHfR6zjtebi6fLLOf/dL0
   A==;
X-CSE-ConnectionGUID: KyxFv9DQR02ETYwvW48LtQ==
X-CSE-MsgGUID: CFsMD1FlTl2ZcMUQHa3PUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81759900"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81759900"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:16:00 -0700
X-CSE-ConnectionGUID: tQ5tTvjASielOIYl4GOpAA==
X-CSE-MsgGUID: NAzXdaYKTbCcZNYkDzwmnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="245456024"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:16:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:15:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 10:15:59 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHd0yAU414gYLhqim8jFoupDQKEMzw/IGLDQcgmoU654z8r3+0odfEqZEBWuysucF+moJG7t5YhEpemn9wVpyV4pS0bww2ZoOLIgPmJB7OmuPyu+6a7WtGF26ajrQSkeMbLXBJfMZCtAeIsFemhWcF34C3yI8CRBoQ70hthRhKUZEGg+fru4w28XQefwKn5FdBIKIkHC82+xdF7vDiB8UqdCaRj84eemB2vMCndQjATXcEWsB5dUJV2yy0S2TFZYLrAgyx8G07FWCjdX/PQN9BLS7bql8dxbGxVkhURJR3KU4nNFeKSZU9R3I+SH9K4IRfX4hwJChsoGL8sXMCJ11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGmzmXa4cKtw3pknRMQSui/ot9F9kEr0pCX4yrlHPvI=;
 b=HeqegXchzu9/DZgignf3tj9A5gfJcU3NM8AJCIIRrawylPfUpVMejJJNULuvj1KhxuB1ZCSWaJ+fMTnOzy+fEpVV2IuvuFP6ofEfX3ZgPO5bl851oX/98bjQjOLZ0DkneAVcgzeoxBjC5sDD/7ecKAPu31W+b2oCv33SekHyfkI8bct+8qwkPywJCgD4N/DR4vHTW+13+W4bwtkQwX9+rGZEd47cmUUAobFbxPjDkyLWNBWNpECaYcdx2l3OyTDnEWjbUV5Et6jLkVTE+gSI6Gnx5Z72y8ovMYA7moqZ2R98/7SawAVgkkIUVcvVpcP6wkMVbxOxxS3FZ8VFzobD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Thu, 11 Jun
 2026 17:15:56 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 17:15:56 +0000
Message-ID: <7c7d21c6-1f8a-42c6-a950-8fd61d702679@intel.com>
Date: Thu, 11 Jun 2026 20:15:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-10-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::29) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ2PR11MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d669a7-409b-4130-0f48-08dec7dd1941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e5b9giK62g//2wwYAJ9B3Y9XJ9Fq665RND1y5AJbcAe7us+BUnp3dGaBDsUKY/qkmAtVUidTnT/3X6IVcLzRMQXaMZ5xjc9NpxNNn/cicHmjXxa5X0aQdmeTXnHTVYPGzExqy3L+U106kkcB9c4tzpKTquetZ9tN6hkIjNaAIuynv/hXEcxVNg9ZisvzbmR+emD4e5grJQ6s01VXefL8tTYyHttDzxEwXmFnRODzcv2X0uWazjx00AkJJ3Oa9PR/8Xc6wPUok2w/FamCz/3TZVIi4tJYrppwZt0tVp4cfKzuoxddU4Oom/bRGQJ/rF02xegNjCli5gN76FT2E+3Xy0sLBnSApFafmY0JoQGNcf/CzbjzFvMVdWHLQ/Sm2KBUcyo3hF8tv35fPK0htwTvi+JBrT9NU7Nl7jS6ZbzGj+LjakE2TA7jxBAaWYjSw18gOQnJGPpq/JB+B+tK8JNfX5oaSFezxgqfYQZoDiffiIHL0DqBPn8oTrjKAWlPR4dx93c8ujpHcAgFzljEbdIGZviopa49k/yBre/DNy28ri9E+gOKAU83kZsWVNk1RACow9B2lLILrV+W7rnlvj8vwins7OzHgCpWkg7d6w83CTPc8cSlT/octaqwhdmJ9qnDeY9ey6quU8wFkOJO8ZTTAsBFJ3N8NF1skKmsrDOivGRC9KB4JIy2LQax2q1+xRa4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dMZlVZVERKNEVpbDlOa1pzUWVYZDFQSTRaMWFjaWdxamlRRmFTWHZvUzFQ?=
 =?utf-8?B?Rk9td0REcEh4VjFuZXdOZkZLd3g1UGwwbDNBaWlTVDk2RkJaS0R3VXdwcm1h?=
 =?utf-8?B?bVdjVktlQjIwcmU3UEV3dGZyZ2hIa0NwOWlYYTNYRTVxNHlGeGtJckxVU04y?=
 =?utf-8?B?MEdsb01qQUYxUENpWkVwVmtGaVdLSXF5Z0pQbDFhQjdsb0hWNWtNbHdKeEVu?=
 =?utf-8?B?RmF3ZU84Ui9MemZ6SURGYzZ3Q2w4WDlnUWZYOGtXOVJET25SWWR4TDFnYmhr?=
 =?utf-8?B?T1ViTjlGaXBFMFNhVHBIVmRLQXdXN3RaQnJ6U1Rud0doZitWOC9lUDVHZzhX?=
 =?utf-8?B?bkY4MHo3elZpRThoYjNvRTlweTJIZU8vUy9DeUE5RzEwZm44ZVlGSjR0L3ZV?=
 =?utf-8?B?R3NWZ0o2WEZPa1FNZFAyemxvcW5UczkxWERja0JEaVN3QlVWa1RNZHFDb3By?=
 =?utf-8?B?VHhleGdMaXlRbEg3VnUyY21BUjZIV2pGalgySTF5dUZ2VVJ1S1lDWWpWaWcx?=
 =?utf-8?B?MlNXVWlTRlpZL0o0b2VibDdKK1k1bnB3cVU5WGJ4a2s1TVdISUVKU3hXZWU2?=
 =?utf-8?B?ei82a1BzWThEaWFFTFN5SXZkcFN0OGo2Z3JxeGpGYzYrWHprL2ptRXB2Vkt1?=
 =?utf-8?B?RzdiSW00ZExkMnhOQ0JZZjVTVWNidURzOEt6NFg5ekN3MStNcmJCQ2FPelR0?=
 =?utf-8?B?Y3Zyc2R1QzQwSjB2a0hqK3BWMWFXaEZqNnFSZFJUcGZob2d1L1VUQ1g2MVNh?=
 =?utf-8?B?cEo0OUp1UktJZDhHMUJ3czZzaGtiRmdVTmdMY2NWZm40RXhJM3FmRTJzZ2xM?=
 =?utf-8?B?T2RZWlhWWUlpSGtuWE9aV3RFTU1QTlRYT2JYVU1FN3V6T1Rwa2RBWnhrSHNN?=
 =?utf-8?B?NERnK0RyQlNOYTNqYitYY1Z2NEg3YnE2dU1vemYwMElydzdyVkQzVHZpaU1G?=
 =?utf-8?B?M2lZOVNHNVNYelFGc21wb3NXcXJlSVBJUktvdk9JYTBIdFFDZ1FIODRLNnRn?=
 =?utf-8?B?NHhwaFJIVGxkUVBrUFlNbnNVRGFjZWtLZnZaU1FvY0xWYkV3NlhheS95MS8x?=
 =?utf-8?B?RDlORGQyRWxsejAxUnJxTVFMOWF1WlhpS29tdGJUMW01QjVGV3Y4WXBDaGN3?=
 =?utf-8?B?a2VTdVRsKzVNZUQxNVZybmlaVW50cVRmaWxyOVU1bVZDLzhDNVZBRG0yb3lJ?=
 =?utf-8?B?a3RJYTJBYm9YSGFwSUNKT1hqeCtTRW5wenJDTHRNOEVvMUdGeGJLV091R3Iz?=
 =?utf-8?B?QUtmRWZ1aFREVnEzN3JzNVZPT1ZpYjhXMkRUU1JqU2ZrV0c1ZytzdGpMUWNl?=
 =?utf-8?B?dzJ0c2hBTnNnTlBtUUp1cnVSUEtubEhaQ3kzUkpVUXlMaWlUb0gyKzZFLzc0?=
 =?utf-8?B?QlhVRlFpOHRkaGhKRkE1Q1MrQVVFaTc0NDdPN3BUQ1VYOWsyWmtPTUUvdmRh?=
 =?utf-8?B?SWJBaEtZdm93RktxNkJ5WGt0eWNmT2F3MzYrQS93Qy9iQTBqUVB3cG1lNi9F?=
 =?utf-8?B?WVRmRXdKVzFHdGkvZFR4T3YxYmo3Z1pqaFFwRTNkQ3p6M0h0OC9KUFpyOG5M?=
 =?utf-8?B?YUJpR2wrVnBIOXFtanpsSmpiamNaVE5MUzRVa2lWZXl0SzRsQ296KzZMK3Av?=
 =?utf-8?B?emt2cXJzRVE3dDJ0REgyRmxmVHk2bEJOdkxDYXBPSnU3MWs2MXFVK1kwTkds?=
 =?utf-8?B?TVlHUFVEalFvS2xYTmdueGxPWGxPRDc5QUpMQVF2ZGtOTHl6QzROTkNzcnMy?=
 =?utf-8?B?RzVtenFmSnVURkpTcXVuVStwOGEzbGc1d1pxRkExRTJ0cXZ2eTdlUks2cFla?=
 =?utf-8?B?SXFMckFTaXc2VW85Y2xHNEZZTlFEYjA1R2diOU9Ba0VMOWYvelhUZ0dMMXp5?=
 =?utf-8?B?bXFxV3djZzJNSEVGVVlVRHRxcGZXVVpBMk1rWGVoTFMyb0F6T0EyN21nejAz?=
 =?utf-8?B?S25Lb0Q4U1ZNT2VXNUgxNFRGQlY2YmFyNFpYMHR0dHd3ektzVzBEbnBXU2Vo?=
 =?utf-8?B?Wngzc3hLekdaV3JXZG1XZHFDZEhnYzZSdWxXMTVGck41Q0RUb3NhZ2k2eFF2?=
 =?utf-8?B?b0EyZ2RCdW04cTI1Q1FYVnNQSFdrSHZaOFkzUUNvbkhvMjhtUkYxSDNIQm5k?=
 =?utf-8?B?ekNFK0JWUDNITUZReVNOV2VtamNMZ3pNeEZ0TTRxcUlmdm9nY3N2K0xHazZj?=
 =?utf-8?B?OXRTRjFzK09BQndEZGpiSUw5bUVtNHVscHhQeGZld0dZSGhVc05uTE1TQTE1?=
 =?utf-8?B?eVRlQjBORU8zN1dLcXFkT0VZTXlndTJKcnV1TXJsYVF2eXlqSWh2VEZkczE5?=
 =?utf-8?B?dGlzWFRaVkZEQWk3c2tNdUFtY1R5L1FoNHNyQTh2dTkyNm9UMlFTdTk2aEtk?=
 =?utf-8?Q?LUJvOeqwL9gfpqtU=3D?=
X-Exchange-RoutingPolicyChecked: opNHT0DixQY4rHjuNqyXn/ira20AlpVcM0D/R9bQCPa0g/emyBVvJsu6mrgMAlZ0c7ULN2sOLo3geae+Dp4d2WCjvGZM8Rz7Qn4utdcUKpmWKZBo4J6/S5PPT0M43mRWrJUZERh7XIzjSXrUkRMUdWGqyfBf+yrAM42dTu8HrAjb6fA5mZ0g9iHYcYR7o3sliyC+DbReufIi/revhLrwGfUueIeF8QAhly8qLQ57pQZVMN/7il+XV1Hr+OKXrRLsLPrXP7hOrJCLbecsFyDYrFLTSu8D1FwkskhYwcE911tXuKEJK/DNHob+5Wr8ftkyqmhIvi7vSUbXxKPQdGVyTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d669a7-409b-4130-0f48-08dec7dd1941
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 17:15:56.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7uvtkhMjr2d9JvVRfkeC7GJKSRRTGlu9TKX7HksCN+AsGPs4CHhuqcDm8u+OGrG69+qY2JZY93QPUGvI2vq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7648
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Use the TDX Quoting extension's TDH.QUOTE.GET SEAMCALL to generate a
> Quote. Since the interface is shared across all KVM instances,
> serialize access to the SEAMCALL buffer with a mutex.

Isn't the concurrency configurable, so supporting only 1 instance
is a decision of the software implementation, not a TDX limitation?

> +static u64 tdx_quote_get(struct tdx_td *td, u64 in_data_pa, u64 in_data_len,
> +			 u64 hpa_list_pa, u64 total_len, u64 *quote_len)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = tdx_tdr_pa(td),
> +		/* Don't bother specifying the quote id */

Need to explain why

> +		.rdx = QUOTE_ID_MASK & (u64)-1,
> +		.r8 = in_data_pa,
> +		.r9 = in_data_len,
> +		.r10 = hpa_list_pa,
> +		.r11 = total_len,
> +	};
> +	u64 r;
> +
> +	do {
> +		r = seamcall_ret(TDH_QUOTE_GET, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> +
> +	*quote_len = args.rcx;
> +
> +	return r;
> +}

...

> +	r = tdx_quote_get(td, quote_data.hpa_list[0], (u64)in_data_len,
> +			  quote_data.hpa_list_pa, quote_data.buf_len, &out_len);
> +	if (r || !out_len || out_len > quote_data.buf_len)

Is r != TDX_SUCCESS more consistent

> +		goto out;
