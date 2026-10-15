Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DA459AE9;
	Thu, 15 Oct 2026 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044781; cv=fail; b=rJIYMV2U4BwTwP1YWGXDmrgQU4z/n4yeoH6eCwUggGO6LuH+k4q8tAwdkReHQRPHvI50bnL0iWW+TFKg+np57x65ZJMnNinaAjVAwd/65w/5Qvz3WayB/qi/BO0baXO8NCFef892it+BckOW0HR61uZ3quVU4pqddrPpvPjIlOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044781; c=relaxed/simple;
	bh=Rg8IgaOcQXLM/pkU8YXc/E2+fVzOUT/uOZUsigW7xNs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=me/8P3TaabXEoFchf3rauUSvqSvINbanTvredvP16cd8AbMt0/S9kG77vjBj1XyDeD/584nJCqvanD5ADBgXkSFHSnu+KoJpXll93nbIkpB8Yc5q6l6CuSgY8RWbjae2cRa1zYZNw3ZgNizkTOsksaWH39ZDfkLv8K0GG7M0PAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9vydDlA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9vydDlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792044770; x=1823580770;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Rg8IgaOcQXLM/pkU8YXc/E2+fVzOUT/uOZUsigW7xNs=;
  b=Y9vydDlAxakEEqBa/z3ar/SzZps7P5U6NZEHnuM3fog68nOdhUKOA98T
   XvkQM5miCBSiM39QGY2ok5XyexEXSlfwmakcOw3VxVtP6u5SRdki5zqTK
   G18KFB4PU8YjxgCvBvmB7rN53EhZ9mhmd18bIV04sDSaYMoB7dgTvUdng
   /PkKprdcgWDK4BlCKGL15WFtuIM/3bwxir6v4J8x/sKiX6GBHmGlyDI/0
   kJlA/gW15gaXJDw2j5lvzCwc3fb4eZUOb+Bb98+F2ox2V8dkwViff6fnj
   /ySjWSkuRWRYm0r/wW8O9x269EwHmBhNqLrn8Z5AaQPm5ouGg0GjAhr0e
   w==;
X-CSE-ConnectionGUID: EJzfUnfLTGuawv/IsrL90Q==
X-CSE-MsgGUID: M1dfSizZRaqj76SdcIq6SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="703783"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="703783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 23:12:49 -0700
X-CSE-ConnectionGUID: XRzVFECoQy+ATigZrMfJqQ==
X-CSE-MsgGUID: aOxUSEK9TFu0flyEOT78Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1939803"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 23:12:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 23:12:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 23:12:49 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 23:12:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh1C11JWwjccS5iaI1JtiN9Aja6/0IVJfVIoVNIXwQ8tPB+cJzhQYE4lxwqi2fz43M6Uiyzc5DtfX3ux7gnAya5OD5v5KaWU9BFY8XD6R1X80c/qK+3BXLqo6TN+2kDnh4ByJ32+OFGM5o0ekRTs/72EkivW0zpQUZNM4+r9KGnDQR0hXHuKBcAw3+lWthNmVRXdVi3qGKHjY2Y2iyrOkia29opMCWcDNO2ZA+6HIPfLtNFCvnXfNYsVfVVp3BisnKejhiQV85AmTbduLHmy1SMB6+kW2tKQ7EXcRBjDSU1JpmFBXMVXvY0nUoQClUnjXaTKfoqMu4qY1wIfKUIJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhHABlpxnGJewmynJkj4pIlhl9kTXMHg0uNk+begWs8=;
 b=KZ5xvQxDETeeSm1PQgevmTbDHvDTsK7pRmqqCAvj2MRYyWzl528Yf2qskwvxdAaA+FYaxwwpwg7MoDGPhQ1Ljmlipki2pWlgnz2QOBgde4ZkRTxsAltPgZHEU9jc965hp0Bjp4RQDaLC2okGGR5KD3jxG06ChK7LU0O2iUX4VpHdOZswOt0RDrwhf3M91pG2/d6VfxDmaUdgMxgF3jqzDUPdbpzCMFu8bb84df33v2uiRo/CBaxWNEfkC9bYW2zYwm8MDrghnisTkNC9od2+LZT6KlxwJsYjRTQXL1Ecbh3kR3xWWQtAGr518YPHe80vq/fVwClQfxhivMv9gjIH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS0PR11MB9501.namprd11.prod.outlook.com (2603:10b6:8:28e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 06:12:45 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:12:45 +0000
Date: Thu, 15 Oct 2026 14:11:51 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Message-ID: <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090831.15502-1-yan.y.zhao@intel.com>
 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS0PR11MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d15965-88a2-425f-7bcc-08df2a835422
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|5023799004|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: MRwRmwqS6NinVbfxfYHK84CUC632ZhL05v7oYvGOmBpOEd4F9yefCvbY3Dalp0oxH4E+T5+mOjlOYNlKpT0ceJusNIZfcqOP0vEzCZgoTq9pOEw13MCyFEwt8jg3pYaB+FvXNTxWL1aD2ADI8GE34aWl7vjTaFjj9Ipx42kQ3AX2LyBvzsOEt0WldsiJ43t3XYolQbqxUm/bq3kSYGXtRoONcWoTwVDU/tnlk3wL/5sSArKc6OIBcGq81fokwozXQEytb9OcP5VL48xRukdGrayDCxSkyntmMYMBU8wKGv8ZWYYpfN3M3M5SSEf0QWaejkubLLYFx+IVuWB11Tmdt2Ezo0FdjI9/iyh5/Y0Q56Vr/y3oNgG1b5s2RvfYA0VAphzUT1GVHsvIZd4y7Drb5Hw13SUzioKJO9x9OsXAkT7BV/3S2e2uZkh/hFrhedDvBkDMm3DnRz+PupuwHsF5qtV1tE8Xymrp5dw3QLOKCbU2821WjiGqLmEISYhub3J1zjZMGCXFsRmzqzBl4V5NqdEg4BAMh1CoLX5gEc97L/tBlab5VoZn/fE3XdR/v6BmgM5VH7+xxqBek0VrJ8dEMcEIBfkYlii9UASTft6xaEANnC8eJRson2SzaEDoWFxq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(5023799004)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lh5OWsJvxkd6fxpB5p1VXSmuGurT8fXftVxIH+qpdtdQ5m5sSttMvxcR2R?=
 =?iso-8859-1?Q?P4QqBt0OLVa4waDhOjGY32S1NGrnYlvkjeAOf6+ZX2y5Ovw5W2UCjN/f43?=
 =?iso-8859-1?Q?c0BHTC6S1eVu2nos4q+0THUaTDfMYFI8O6iahYoHh6JaGdHtd1kk+c1W+5?=
 =?iso-8859-1?Q?/+Jhjb7qJwTivezx0dMkZaQsqTl+I1SwE+d99+9qNGFYo7zpARqRkgIAjf?=
 =?iso-8859-1?Q?hGTUDi8HttUIrgxP45y8fXYdnSzdT+ocPzplcFWFdjBBaV8tjXoc2eSvKy?=
 =?iso-8859-1?Q?A9dAeSBWBX4ubwELfDh6SjPD+xvEkQMPDcd0onKv8RaiTjTdHMuxH2ot6u?=
 =?iso-8859-1?Q?fUr4d4bAUzMm1NbwdE+5wQP8qyE9H3x3wU/V+XS/S68eOccDCStOoDiw3N?=
 =?iso-8859-1?Q?GfQFVwPvtsaycMLemNGEDfd0IeDqpykn8y61SJ4wkkpTVZUdCMpx3RYrH2?=
 =?iso-8859-1?Q?V4I7CkbQJhoxF1te+yJ0GwxyicrLYq7Gm00b+V0YppDDvmrHYABcvhoPg+?=
 =?iso-8859-1?Q?RjpSBc4iOc0Tx9mY7+KzxpelzGpaxopLFALPLg23b9g8furpe9naDG8ss8?=
 =?iso-8859-1?Q?jo5yaCx9bvCDhcDhz5oJoPmxoQrcK5cVHKFHD7AYUByGPoGSls1KsE90iG?=
 =?iso-8859-1?Q?r+AiUX4JFsHjJse4El/H31eAaN/2ZPh+8KrIPWBczcM/W3JUGkPwGw4lSQ?=
 =?iso-8859-1?Q?YwRcxmrtIcAFwXO5kecWd1Ti+p6m+7TOtumld1Aum7jRxJTwAMnkwPc78k?=
 =?iso-8859-1?Q?DN2nONDGMgWQzHKErjAHOLXFB9xVQv9ngh5o1fdSAPsd9x5EZP9BCdspmL?=
 =?iso-8859-1?Q?rCY6E6TpVyL8sfn09PRFlQL3odvlNtKIAueX1CGKIcmCFZibVQv/dx0dgf?=
 =?iso-8859-1?Q?1xfF3B9cFkAm+r5sVtgKv7+BB6TeQBD2tyfW936p0wvkQ7XOkTlZUgIAZc?=
 =?iso-8859-1?Q?+4slx4evgeVDqp9DN7RUzTCr7N5th0etdAmaxL7Ggw+9DXwOTa5KfguF37?=
 =?iso-8859-1?Q?Kx8njGKMdI7yadTaUffKk5fEyMSd+j0B9UgMtNNVQzyNPChz+t98jImBY1?=
 =?iso-8859-1?Q?0JZ662uw6Y6YpEStoQBTqrm5cwxbw06hVH9zldy86q3xYGR8XVZEhOd1/d?=
 =?iso-8859-1?Q?Y1xR08MzD+Ll1pYNZIgBwhefpQn70Koe7pYC7oux87b2dwkN+AGJCEekyo?=
 =?iso-8859-1?Q?NXhnebZDlbS4uj6PRFfcY0S12bSXTjsvQ87OgKnqwqGtIDSEfg3tzpmlek?=
 =?iso-8859-1?Q?dmEW/IzWO2kyOMrubeEnWSrROMXzvAjpiz0J+YeXgc7LD9aV2JO9N9vXEn?=
 =?iso-8859-1?Q?/6QZ6RelQQFib6McRa97NIzv+13lhxGw7Wup6LL8nMcJ19c+Q/qkE5jibR?=
 =?iso-8859-1?Q?bC8kPSjLdORthMyJqq4VLc0EHqTc8IuU/hMWmnfKMl6eGa4SRor8QlF94D?=
 =?iso-8859-1?Q?W6TKTaWZhw+TDymw+UN2EFQcc73Xc7Wq9r0DtPG31xJMBgu/Jyi485n1hj?=
 =?iso-8859-1?Q?Iw+JZDyE5j6jyQzOxU48zG5mEPAtP50rGYOhiGfV4/KbiDDwGARys1va9J?=
 =?iso-8859-1?Q?fEsOMILIsMBasbEN8tYquL+ECy4MNP6Q6mdDmqreaRr2P54eGVsaQeOuZc?=
 =?iso-8859-1?Q?Hh5kOpFpRCSONWMxouAADKTxFPJQ5NQmIi3BBFZ1z/Ht/EyUGQT2mQ/dJz?=
 =?iso-8859-1?Q?106V+fu+ETNxq1WMfvdhvMuWsamUKt0rdPJwbsME1XfBAvvUwi5hPpG2wc?=
 =?iso-8859-1?Q?cRhvwXmYkU2GEGQQ57TN+55KQoMEyuCZDG6MOvI2Q5nu0aBjVDil9cAVET?=
 =?iso-8859-1?Q?nkm9Nslz/Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: hTVm3n/N2KSP0oE/bcN1tH9i3GWIBkrhPFYVjCz0aDR2EDGhV5hZ+3JzHoKZ0SPBp0q0X5k65txioPOl+auG9+rkM2Tosge9onX/SxBLoRIXkjhjH/jOt7Iq6e4lN1m95bcYdi1gra65/C3kv+qiKpf/mYLakZT3eY4jc7x6Sw4bA9r1NvopBk0eK//bSxVn4U2QR4ixvP4xCiNXciYm73afAvjAiROGUh74KHzOR85OP4BnbQuCo7rjSn5sv86JfNricRPWnm8VfCQI5VHcBA2SYYR0aQA675jZjNMdgFva3DX5uR+mdGzPDracMj08EfgUN1W/lXxisJz5je7e8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d15965-88a2-425f-7bcc-08df2a835422
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:12:45.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aObX/QkVn/XJOjfipI6cL7Mik977EqlLP7nSyjaHy2bJo+J2CJ5R+OykIr68gK8sGLxSeoToWOzzuLa+nUVHUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9501
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 02:32:46AM +0800, Edgecombe, Rick P wrote:
> > Ok. Will do.
> > (I took the easy way out by only listing the major ones, as the changes from v3
> > to v4 involved Sean's v5,  many internal review versions, and changes due to
> > rebasing to the latest DPAMT).
> 
> Then just say:
>  - Lots of minor changes from AI review (Sashiko)
> 
> The serious problem is something that implies that it is unchanged but actually
> is changed.
I see. Thanks!
I'll avoid it next time.

> > > > Should I also add a comment such as "The caller must ensure there are enough
> > > > pages in the pamt_cache"?
> > > 
> > > I think it's obvious. That is the whole point of the cache.
> > So, are you suggesting just propagating the error to KVM without the warning in
> > demote()?
> 
> Maybe instead you can answer why do anything different here than the other
> alloc_pamt_array() callers? Is there something special? Then you can justify it.
> 
> Otherwise, it looks like trying to change the norms of the existing code.
> Regardless of whether it is even a good idea, I think you have enough on your
> hands to get this series upstream.
> > > > Link: https://lore.kernel.org/all/aYoS45AZNY0rUJQD@google.com [5]
> > > 
> > > It looks like Sean was saying to warn about subtle contract breaking. He also
> > No argues. Just want to ensure I can write the code correctly in the future:
> > 
> > If KVM invokes DEMOTE without topup enough pages in cache, is it a subtle
> > contract breaking?
> 
> Doesn't seem that subtle to me? It is not too different than passing NULL
> because your allocation failed.
Hmm, ok. Now I see the difference:
tdx_pamt_get() can't trigger WARN_ON_ONCE() when alloc_pamt_array() fails,
because cache is allowed to be NULL, so alloc_pamt_array() in tdx_pamt_get() is
possible and allowed to fail due to out of memory. So,
- in the NULL-cache paths, KVM handles the error and fails the ioctl;
- in the !NULL-cache case, KVM triggers KVM_BUG_ON().

However, the cache should always be !NULL in demote() and alloc_pamt_array() is
never expected to fail for demote(), so I added WARN_ON_ONCE() to catch this
contract violation.

So, does this difference justify the WARN_ON_ONCE() on alloc_pamt_array()
failure in demote()?

Besides, I noticed there's a WARN_ON_ONCE() in tdx_pamt_get() when
tdh_phymem_pamt_add() fails:
    "if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))",
Should I also add this when TDH_MEM_PAGE_DEMOTE() fails? 

> > > says in that thread:
> > >    Document what exactly?  Most of this should be common sense.  E.g. we don't
> > >    generally document that pointers must be non-NULL, because that goes without
> > >    saying 99.9% of the time.
> > Here are more background:
> > 1. I asked in https://lore.kernel.org/all/aW3G6yZuvclYABzP@yzhao56-desk.sh.intel.com:
> >    "
> >    BTW, I have another question about the SEAMCALL wrapper implementation, as Kai
> >    also pointed out in [2]: since the SEAMCALL wrappers now serve as APIs available
> >    to callers besides KVM, should the SEAMCALL wrappers return TDX_OPERAND_INVALID
> >    or WARN_ON() (or WARN_ON_ONCE()) on sanity check failure?
> > 
> >    By returning TDX_OPERAND_INVALID, the caller can check the return code, adjust
> >    the input or trigger WARN_ON() by itself;
> >    By triggering WARN_ON() directly in the SEAMCALL wrapper, we need to document
> >    this requirement for the SEAMCALL wrappers and have the caller invoke the API
> >    correctly.
> > 
> >    So, it looks that "WARN_ON() directly in the SEAMCALL wrapper" is the preferred
> >    approach, right?
> > 
> >    [1] https://lore.kernel.org/all/d119c824-4770-41d2-a926-4ab5268ea3a6@intel.com/
> >    [2] https://lore.kernel.org/all/baf6df2cc63d8e897455168c1bf07180fc9c1db8.camel@intel.com
> >    ".
> > 
> > 2. Sean replied:
> >    "Why not both?  But maybe TDX_SW_ERROR instead of TDX_OPERAND_INVALID?".
> > 
> > 3. I said:
> >    "The reason for 'not both' is that there's already TDX_BUG_ON_2() in KVM after
> >    the SEAMCALL wrapper returns a non-BUSY error. I'm not sure if having double
> >    WARN_ON_ONCE() calls is good, so I intended to let the caller decide whether to
> >    warn."
> > 
> > 4. Sean said "Two WARNs isn't the end of the world.  It might even be helpful in
> >    some cases, e.g. to more precisely document what went wrong."
> 
> Let's just mirror the existing, very recently discussed and agreed code unless
> we can say there is a new different problem with demote.
Please check if the difference mentioned above can justify the warning.


> > > But besides that we are trying to get Dave's ack here. So I don't think
> > > extrapolating a comment Sean made is going to suffecient for having code that is
> > > different than the rest without explanation. So let's think about how to get
> > > that ack. Obviously we should take Sean's input as well. But while we are on the
> > > maintainer boundary, we can't call it settled.
> > Hmm, yes.
> > Not sure if Dave likes "two WARNs" or not as Sean suggested in
> > https://lore.kernel.org/all/aXzPIO2qZwuwaeLi@google.com.
> > He was in that thread, but maybe he didn't see Sean's mails.
> > 
> > To avoid extrapolating, what about suppressing most WARN_ON_ONCE() in demote()
> > in the next version? (see the code at tail of this mail).
> >  
> > > > Patch 2: - PTRS_PER_PMD to PMD_SIZE / PAGE_SIZE,
> > > >          - atomic_cmpxchg_release() to atomic_set() due to the spinlock
> > > > 	   protection.
> > > 
> > > Can you explain more on this one? I missed it.
> > There was no spin lock to protect DEMOTE SEAMCALL execution, so
> > atomic_cmpxchg_release() was used to ensure the original refcount is 0 while
> > updating new refcount to 512.
> > 
> > Now, with the dpamt_lock protection, atomic_set() is used to align with the way
> > of updating refcount in tdx_pamt_get() and tdx_pamt_put(), though the atomic_*()
> > version is actually unnecessary.
> > 
> > Or since the atomic_*() version is anyway unnecessary, what about adding the
> > asserting of 0 like this?
> > 	WARN_ON_ONCE(atomic_cmpxchg_release(dpamt_refcount, 0,
> > 					    PTRS_PER_PMD));
> 
> We want this patch to make the most sense on top of the existing code. Try to
> make it as simple as possible. Don't worry as much about if the code is 100%
> optimal. To get the code into a the desired state, it is way, way easier if 99%
> of it is already upstream. So keep in mind we can continue to develop it.
> 
> Doing everything inside a giant lock is pretty simple pattern so I don't see a
> giant risk. Do you?
Yeah, I'm not concerned about code optimization here, so, I used atomic_set() in
v4.
My question is if atomic_cmpxchg_release() would look better to you, since it
implicitly checks that dpamt_refcount is 0 before setting the value, allowing me
to drop 

	if (WARN_ON_ONCE(atomic_read(dpamt_refcount))) {
		ret = TDX_SW_ERROR;
		goto out_free;
	}

But from your later comment, it seems you prefer atomic_set()?

> > > >          - added a helper __tdh_mem_page_demote().
> > > 
> > > why?
> > To make the helper focused on invoking the DEMOTE SEAMCALL, without dealing with
> > locks, refcounts, page retrieval, etc.  similar to how tdh_phymem_pamt_add()
> > relates to tdx_pamt_get().
> > Do you think the helper is unnecessary?
> > 
> > Does the following implementation look good to you?
> > changes from v4:
> > - dropped __tdh_mem_page_demote() helper
> > - dropped "if (WARN_ON_ONCE(atomic_read(dpamt_refcount)". Used
> >   atomic_cmpxchg_release() and WARN_ON_ONCE() on 0 original refcount.
> > - used PTRS_PER_PMD.
> > - invoke reinsert_pamt_array() on failure.
> > - renamed to tdh_mem_page_demote_2mb() and dropped 2MB checking.
> > - dropped WARN_ON_ONCE() for DPAMT is not supported, alloc_pamt_array() failure
> >   and SEAMCALL failure.
> > 
> > u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
> >                             struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
> > {
> >         struct tdx_module_args args = {
> >                 .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
> >                 .rdx = tdx_tdr_pa(td),
> >                 .r8 = page_to_phys(new_sept_pt),
> >         };
> >         atomic_t *dpamt_refcount = tdx_find_dpamt_refcount(pfn);
> >         struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> >         *ext_err1 = 0;
> >         *ext_err2 = 0;
> >         u64 ret;
> > 
> >         if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> >                 return TDX_SW_ERROR;
> 
> Do we need to handle this logically? The below will return some error in any
> case, I'd think. I'd make it a warning with no conditional. The comment of the
> limitation is important and the warning does that.
>
> In general DPAMT maintenance is also verified by the TDX module when the pages
> it covers get used. So if we get things wrong, there are already duplicate
> checks to catch things.
Ok. So like this?

	/* 
	 * For implementation simplicity, only support demotion when
	 * DPAMT is enabled.
	 */
	WARN_ON_ONCE(!tdx_supports_dynamic_pamt(&tdx_sysinfo));

> > 
> >         ret = alloc_pamt_array(dpamt_pages, pamt_cache);
> >         if (ret)
> >                 return ret;
> > 
> >         args.r12 = page_to_phys(dpamt_pages[0]),
> >         args.r13 = page_to_phys(dpamt_pages[1]),
> > 
> >         /*
> >          * The dpamt_lock is used to avoid contention between the
> >          * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
> >          */
> >         spin_lock(&dpamt_lock);
If you prefer using atomic_set() to adjust dpamt_refcount, what about inserting
           WARN_ON_ONCE(atomic_read(dpamt_refcount);

here,

> >         ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
> > 
> >         *ext_err1 = args.rcx;
> >         *ext_err2 = args.rdx;
> > 
> >         if (ret != TDX_SUCCESS)
> >                 goto out_free;
> > 
> >         atomic_set(dpamt_refcount, PTRS_PER_PMD);
> >         WARN_ON_ONCE(atomic_cmpxchg_release(dpamt_refcount, 0,
> >                                             PTRS_PER_PMD));
> 
> As discussed above.
then invoke 
	atomic_set(dpamt_refcount, PTRS_PER_PMD);           
here ?
 
> >         spin_unlock(&dpamt_lock);
> > 
> >         return TDX_SUCCESS;
> > 
> > out_free:
> >         spin_unlock(&dpamt_lock);
> >         reinsert_pamt_array(pamt_cache, dpamt_pages);
> > 
> >         return ret;
> > }
> > EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);
> > 
> 
