Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8C517BCA;
	Tue, 29 Sep 2026 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678435; cv=fail; b=lU6yrxZI6Ky3CFwcQ3lMm6F3lYSibzttMzaLJ1u4OOtQkmnh5+GRhBt6SDr8RXkJZ7oCOa9gzBY+kHZilIE0IrCAhn+sVUbwSWBYVtwmDX/aky44eKn4fM5G4n1YkZorpuVBeX19SRhxyQc+e6K92g/3OqPbQnQkpyzGt6o/2sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678435; c=relaxed/simple;
	bh=B5ZD1HjcRzbGNIH0D7ALfe6RCGlhH6SbC9Q34SuUGkM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmYOiqHRciCpNgCuooO7C9/ZoCpaW/EtZS3dup2+2hwc84H/XkwBtEqQDFcv4ucm24TNDyqPjg424GhrnyTP8+W0AkHXE++/WG3N65WHFtI/yQxcxFKoVLNm28UpD+AH203FoSA/yZTjt98edIkWeWIz2Ke2MWjRPNhy7n/yoSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSXf3KGo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSXf3KGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790678426; x=1822214426;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B5ZD1HjcRzbGNIH0D7ALfe6RCGlhH6SbC9Q34SuUGkM=;
  b=HSXf3KGo/VWBEaDNG1b0kdPeDyLVPeTMqdBX+SeQkCo577Mgfb4ow7q1
   TKh6+C0udBeULKRKc4iJc+on7rA7SZxqFfymrXIgCjkWwgBDFGM9DrwbM
   fB3V/jwQ/Db11iGeXcbVUAa4PH4AryzKlRg71zQFzOoqZo0lLJf9dEI6/
   u9HO+dZwHU8+arX1+WULwV88aPgCx91YcA11P/y7O2TxQDEEJqRGh3Bxt
   Hbo++y1QJPMJpcIreXyUmb79uGsNAXAayo7eul4tiAnUP+eoIOhab8rMZ
   vpO47tN/hQhkBUSadZibCNf0bCjy1dnG9HlWktzBui/zvYJGyhXcP9cDV
   g==;
X-CSE-ConnectionGUID: AVOvXbdsSKKxbV0tMYgBTw==
X-CSE-MsgGUID: NDRT8txDQ+2UtWGOqKNGdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="93883403"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="93883403"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:40:20 -0700
X-CSE-ConnectionGUID: F2mESkusTmKjqXTIgcCy+A==
X-CSE-MsgGUID: N6sfaBzqSlOLf6lZzbWyMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280065237"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:40:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:40:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 03:40:19 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfA86CWMmhE1wu0du1fFuhTzTCSrqpRJ1gwYOwwVybTTnPAd70pNmhaIxzKimGp/7ZY3qvvAGJ8YXjgOxKt8garKM1oQyvx2oZjfhzi2KiC6Yr2ICGzmcpLWMt8Cp/MhmYs4Rp3wtMOrMIbSQz8zgduxelrynOZxTGWtkkZqR5S8C/NZdqb/oJxSsUb130IUy9HpxQHzp6394CM//qqKCxdVr0zD2P2QdwJUCuByIo3fjoxyU6Q4P1n4pXKAbJgoIBJhQy70339+J3GGYdEj9VFsNOUmFHvi/8eEQbJBrlILPLLnWY9kosItvMEIIZb+dRuovCCp7Us71b+zwWlteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLbL55tnvBwWvHbgpBEYncIXHsnrH1xxSPabmyX/9ic=;
 b=t/hVDTwk/mE3h9+VdQqr6Thij62z++jpmttuMcxAWCAZMpnagRci1o/UmZlALkDNBIS81KiNhT0BxCs7szlOZcmHZyzWGwBDt/sUFrRclqjo8X7S7bMyv7xqEHh3o0no5upLIwZUOcu77PzeZ+sn453Sg9sRG2qvZn38/tHc0NiDR/Rrv8u9PgzXhDxHSWSWToarytvupqeCe3Hay2syWu4Tv8scNcbZSDcRSuQOfvDau7OFSEYGYI6l1uGO6ZXFETBuL5hLdITJT9VjnZbj/KeaZF2nTNxwRO92IPAVdLVVY2ShJM4UYmp6AvZfLHJ2c+aopHAZrpFcaXO+g6HEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MW5PR11MB5882.namprd11.prod.outlook.com
 (2603:10b6:303:19e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 10:40:15 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 10:40:15 +0000
Date: Tue, 29 Sep 2026 03:40:12 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Message-ID: <aruVjKHg0ZF0udox@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-6-peter.fang@intel.com>
 <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
 <arrYlnkCq4GDIG9M@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arrYlnkCq4GDIG9M@intel.com>
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc73480-599d-41de-a7c1-08df1e160c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Nb3sK+kY+V/hiHxgQKk50UaGxQNAEPr8yIdw1Ib6Gb7FTvDjnLIHND9CLJghPQr5X7A5d2XfL6j42tG/e+ig+dcGBA0hLNdaQBeH+5fiJtKSyA+hGhCZDmFOc1oD9agKPWVfYm7gPLElXjY8Ez9nxAweHeArnC6/XGKqM1YPYT54u0DAXuiMpRQAFjqjqz0yZyhMOlZ/CckS9SttBHhm5ucxU4NezmaYXLhvYt4y7XntAcnRDgamY6KuGtVMrlWs6uQB6sAh9XDHL3buxYkLMAyLO2LOfBIuKd4KyiCQatmq1Vbl+QeZ4M9qKiLNIbywKUaRYSfYvK+VsjAPhtM/mG8Ocv4hRe9swh8yMdaFno33SrgJKKeCtCv1KQkRUx7P/tJ/U7UWHDZerKaK4ykYCQTd1poyvMQNI1m35wkjmgUYn+CD++t3tvmTBto1Upff6YUnjJEieuU98jcSELHqLLm4RTjZ/JjsfALNB1KGxxj9bJH7ThQZwg5FxF3P95a5LSxBi/fMAkPLIaFKn/30tY2SW8yiv+My4WnllMlwxTYL5/3hsKDKdpPrs51s1PeurLB830IoDmI+PAot528VaBy2spR2B6uN2/bKp/IZ9xc3mj26HAT2NRivt/Q6N9Ju+bn5udHdg5B5R4K9/QjxU1t2WL3H8RRerCbHg/AKVf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1cRbkkpNg3ZFq4bnaJwXi5T0JLbGUM6pEaM5sOIyW6MNtkK0gfFYYNcQDDac?=
 =?us-ascii?Q?LZFrhUyf0YzFaWJlL6EWTPfgmHyi6U0DBdcrrztXeAzrM9PLGKIsT5R/JqtX?=
 =?us-ascii?Q?7fkj2afWStJgj7enFVkbMVgk59NtJTmBqo/cIzgjHodpdigXW9mGZpYG6XBg?=
 =?us-ascii?Q?4zMRIGx+5yOzR2mLiUlIZ4utbFQW0aY3ab+FlfPEVN4mhN4aOHtyheMQJaSU?=
 =?us-ascii?Q?mtdOOthXpaQeDXZtl82R1xpTvCOT8f9zjokDPuLhwgFeTPzZ8f4ozDE268lW?=
 =?us-ascii?Q?c14hiIWMPiEky5bpk64kSgNm0sDFsGzuR4F4lyLIr8cOnT+CFxc2VIhNh0C/?=
 =?us-ascii?Q?nvSCDqOl6TRI42d7UhB4FBevzxdtKbuTgB7BBmdw1R6y/N7CdvFazxIVGPfc?=
 =?us-ascii?Q?8/E18ZmQAS8jCDXfv6eAeguasTVh2XccO8BwiGwXlxev9dI8pXO0Wpt0RiJl?=
 =?us-ascii?Q?qF3Ue5VKW3phFcgdSP/gQqCYgwBo+772oVS4ff6XjFAPkmsA699i9agIQ6uI?=
 =?us-ascii?Q?CKHuhKEwqhb6htlCKClKdJxpcp2NDOVQT+XfVASH5u4PcgrN2ttcbxR/KoLg?=
 =?us-ascii?Q?LVlk6LszWgEIrdvtojT/3csqKBW1kS/YjwyVVcs7+6Go4cgn3+UOrQK+57k+?=
 =?us-ascii?Q?G/eIpTEYN+rn3lgLvCfNSCYZyDNPYtMlXnDrdVY3gEGaytmJ2pjnrePWKhEF?=
 =?us-ascii?Q?pc1vBRy3EFUGV956JF1nDBa26pIFrI1uZ0rR9S9VArB2txlLPOZwn8WPi8K3?=
 =?us-ascii?Q?L8vWR192WXbKiYgZT1D8wuzITWYN0U3KrUpSW4Ms89F1jXpLxxkfLfD0mmNp?=
 =?us-ascii?Q?B0YOrZJpHrJQcEtdaCDVjwy0eYMlycoHP9BUZiKLWhjUaWJI0L/hT3/f0RuC?=
 =?us-ascii?Q?TaGgzwdcZu0ik01owkyPP+Y4h2K0hNG4hm1/d+P1t/rpoKb+G9smCWjTMn3X?=
 =?us-ascii?Q?Lph97/dBOgezVXxcLdDF+QHR6CrtX7I42ZaV9hMZe7NibfrqjOpX7ik8NSo6?=
 =?us-ascii?Q?/bhFa+7S+tQ034Wf+V+IdpA8K+ufmhzNn6qz9VH88I3VTrmuJagsVFjtw0OC?=
 =?us-ascii?Q?dtv+arSw/LDtgOD2Q5PvwbGWw7x/KmSN+FKB+3cLW4YTMaL8Fh+xE1AvVmk9?=
 =?us-ascii?Q?tR4hfmsLoKv0+UzFOuJyFZcBNNvC72CBWIQr99UGyHeih0tVikq54r4Wo+0s?=
 =?us-ascii?Q?vC/9Lu2JcKPIWBdVJrfnzsUIaAZbwr+pLlZKY4wnX7f/zjCsXrUY6ht0dtC/?=
 =?us-ascii?Q?jvxjG8lnY8q33iAJ1zYS6DZq/ctz0uxLQD5Qb4A3b4c7awj6m1haubrb+tmZ?=
 =?us-ascii?Q?Nke6gyM62dEBx3iUFOXIlGQdXAtSm7ay0Ebm14qLfDlir4KYrFtME42WEWZ2?=
 =?us-ascii?Q?bEd/KlKAdmAb3JN+5feoaC0LSbpnoCVaIEkw8YvaLL0qFM42924BEKHkpxzx?=
 =?us-ascii?Q?m3auN7A2w7KX4cw5Gs0pGx2olCYzN/Xe760ylH+IG78aqFBFY79axwBS7wPF?=
 =?us-ascii?Q?ekMVhSIv+hasrSXldg6zjUaf3OaMk68Mg8erVLGZG2UXTGyO4YwDdUrReqtq?=
 =?us-ascii?Q?aX2lGRjbyPS7f0J3y0HDqcMy32f28x37jg2AwzmftNbWCXT6RG7dveIRLoSj?=
 =?us-ascii?Q?hC8ikMwEKuOAwlHnMo+AywW37R0WtPdY9/slwzZXh18MT+gm+xa2lvSjyRqY?=
 =?us-ascii?Q?i/OyFvDq/mS7Zm6T7Qg/096A4q5BMWUojCbzsdY1AwKxCUCXTVxVGiV0jK+y?=
 =?us-ascii?Q?5aD+Y/getw=3D=3D?=
X-Exchange-RoutingPolicyChecked: j3qTQkcMT2cssBgJiNaf515A7orHEp/MdfLr9H1Z3yx5l9ujVqAzJa1ScncLE37Y53r7nOJg7wPNf8WMseo1tBcuOrxIlw+sQFEM7Q56QQXeBwUTv47yE88OKJOO4Ik6/WuXAHFi8nnOEALkVQNQ8+BPkzmjzpmuh6VsJYZdY7MrwxmE9ByzNPOgeZBHvlPcF2lzPDeBdJA97Vnnq9XP51wqgZwnetfYvGNCoCa6S0tqzVTD+xDWyZoqT2Tr/M+rkomtYycj7rc4sqUl9jFWbDRbJEkLD7PiETLeXFZFr8d5FujKPFtKaLoPFjrf/SROYGHAa4Uij0eusGAx20CGww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc73480-599d-41de-a7c1-08df1e160c11
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:40:15.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwrSciRx2pYY44bcI8AjG5VYXVk6CZ9FJjvxRoHNwCuQ04fusuAuDs0Rk1repMkC/3g25Wv/B70g2xw7ZS0TGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 02:13:58PM -0700, Peter Fang wrote:
> 
> In the pdf the wording is "Maximum size of the buffer that must be
> allocated to contain the TDX Quote received from TDX Module". It doesn't
> say anything about page alignment. I can confirm with the TDX module
> folks.

This metadata field currently does not guarantee page alignment. I'll
raise it again if this becomes a problem for Linux.
