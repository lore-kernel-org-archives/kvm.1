Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792743193;
	b=o+iNKtGt5dCwrwIvW9LZKaaUhd+hqOdLDwEYbC8+h9MDn5VHFUkJ77hbCmYH8mrhb6GW
	 qrRRE61gILarSYMmmNjf4knswkLZlBvsXDvB5s51Guape74I2e8mhgnrcoEs23k995mDz
	 PyHFuHciN4Xt1vTHlL+uQEJVrd7ClLyWau0aBre8q7QV8Q+Ago1G07pNy0ud+Cx2V0DY6
	 AS4l20+6Rdp/n0zDn4nmyseiFdvDeYXihAXdtgbBnQGZwcBtxtdMUQfXf0m1jRPTHmxAd
	 g1vve8R+hn6vm/KShfQvajA9OrcGDLqfBOsclkzsLh/JrDjsYaRjedsvSEYSQFQSSfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743193;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 Reply-To:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=HRvlTNWTpQA56NlrWc2ebZOY3RMg1qna1nQOG1PL5i4=;
	b=rDHHfc+gGKjOqnZhf6EY2I+DveUKbhIfK8YMPtMTvgYbjoiOVgXmke6yAddno+rfASSD
	 U9goEXL74xz+HO0LQ9jouUlb16t5gJROK9VnpEoXwPu+0y3FQf8MV8maNggSqb6HjPT4l
	 SOyDZeQZNjAWBvdfgkaHddDBKcPo0ztrW+7DY2e5hZDot6pZYXnyfHSyxJBiKeTkAHupQ
	 6D1fom5/DJrWD33Mqu4h7FugVWu+UytxPujB7kW7DGXvBhtlrtrO+gbjsTdqf3gAEiS2k
	 8xR8PJHwc82O/QlCr+S4XR8DMtolhkZZW6x2JII5NnqU2BDHIObzJ8fryF3hFbrsJig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kilbzR68;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DFB606A323;
	Fri, 23 Oct 2026 08:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62DFB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kilbzR68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792743192; x=1824279192;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZQiGSue//ClFe5+GLHEogCxLV8cImUxj0CUn55Ki2oc=;
  b=kilbzR68LBf2aj3rD4v+3JRToTP5jDNJMWQO/aFqHNHmIyK7SdWwXfN/
   +zYwCc5Kl/J7MptfVyPxxt81vvR5dGJPKBOclkYmxFmOXg5kXPJt6dw7Y
   hrUckUOMRjpEzn0gG0EirYdBQDpZy1CZpcd3yjWc+i1HZkzbo6b+kkJ4t
   WpjdxbaMQ/KOrEFjYH4EQwMFpJ4RmWwp7/sIo6tErTAFX9wqrTweYDN9E
   W0CSI/s77wqKYAOkMZ5b+qKPw+qhFJESVSbrC92zcjbdaXTium2cHrVv3
   U2MUEN/X3BdxhFP84d3g/pe4bvWcjVLxeuOWZQFMoUS7sV/Oxl6K9uiFQ
   w==;
X-CSE-ConnectionGUID: SwoNZ8JCR+SRuN9p1dzEog==
X-CSE-MsgGUID: cdEifgTAR4SsHA4LoplC6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1594548"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1594548"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:13:12 -0700
X-CSE-ConnectionGUID: 0jzAUrIfQG+DdI9ePZoqwA==
X-CSE-MsgGUID: OFmdT+oMQ7+N7lQuCk4CIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3922189"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:13:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 01:13:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 01:13:11 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 01:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLq7k1B/cSc938sn+l2yB2fqrOk3dZReg3XYmTHWUXjALfSLURqZbtw/5adRT0dDK/HCfitOglKZnZeVSbl0hnzy6OyHP/LSD3gW0KPPUMeGLM0PT3eno7gDfEYqMP7bwJ6vE95GNHiup6n1wANQwfXMet3imwjDlLHGywE0Vht39pLcdxYjTgSGEaqFclUwjPdmrlYTxM4p0akkiE8Y+0anv0qwp9NVWO3d6JX7zELZeuaXva3nKh4BXhinn4pRaAOj/5MhXHdvF/vCbHCR7QQwIVzLneqYaUMHoFMJKSLMvjZ93KY7YJwnbMxHLzp/zORwESsHLcQKQ8VVwTARDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qv8PqmQnDMhIhIxAlkmwZ49iIHOhDTNDw/pLgAAoqE=;
 b=h+7SJrhjbGhsmNiq8tx1pR3zqMKhhvc9CvSkCww4f6O6Le2T6zygWrBBO7WAxgdC/ja1t59xK2XMSamfkAYZmYoo5ufmCsiAKhhf8yRwE6beWZZKUzqwUqKUAaS4rxUPAt36qjvloCVH0AHaNmZTnkBlCGNnUdWIL2YswGY7Cbw0AM9jcKZ9/4ThJBaJIvbIW/h30vxOPa5uZyHFjaQwoD9PQizBSoEzKnwXDhkFDtS8dKHGe5A8yAZ8pxFFfyx3Y+7y6lQLlgWLxKE7skk8v/zgvFOVEcT8D/0uQIj4iPLOaLFaoEVEw/GciemtR7UpJEWSATIGjvATRYauwwrdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by IA4PR11MB847830.namprd11.prod.outlook.com (2603:10b6:207:150::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 08:13:08 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 08:13:08 +0000
Date: Fri, 23 Oct 2026 16:12:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Message-ID: <atsW2OJJXUPEKh5L@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
 <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
 <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
 <ce6a1dde0089b0d357b11e58d2771596943c1239.camel@intel.com>
 <atX5JpdqDJIrue4v@yzhao56-desk.sh.intel.com>
 <19661a3ed2089304fd69ab4ca117eca7ceba425c.camel@intel.com>
 <atnNZWj1t9aiOF84@yzhao56-desk.sh.intel.com>
 <830974c6774c59048c04e1cdf7b7b007a40f97db.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <830974c6774c59048c04e1cdf7b7b007a40f97db.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
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
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|IA4PR11MB847830:EE_
X-MS-Office365-Filtering-Correlation-Id: 72194203-8d1e-4cfb-1ebc-08df30dd785e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|261022105027099003|261022075727099003|11063799006|4143699003|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8H9OSxx+BoPKFIVWhxkxD4nIWtMwd9Fs2ofzDQa4Uy4JTbrQNdsoRFzu+nmGxbKZG+S9NSrYfUymWAsSXDMffMdquoUTdnhnvL+kdNv+oV1hutGdRUWfQW7m0mbjOzA6doQfXKsyAQFbyK0tqnK5zTdVp16J7GLWh8LGbc0PB132y/iWPsNupaXs4uiz2IuobBm+ewbHamS2xrjJWL1eDIPaVy8utf4pIs2pqdmMcySWcmbKJWzxY9W7feVZn2r3XGJtUPjFa46UqMm9y8Ni/99YpS0E0jJCpbHFRxgMAXS/i8atcn/uC/xbv7fYOhlZHEM07UzC3uVH971qbJ2yfaA8sT3Zso99hM+fCVX4EXaKCSsK/iycCAANdF3K4148mbv1unDfWuNAqRDYhFw5D2dDzMTa3pp6mx4aKzOhqgqkPJy2gp3TaLXimFo1W4mln9YZXct0LpUK9RWK7xhB07/NvzCe4KDU6bqJe2UzoCdFDHx44yzOiJCMdy+64Z/habw87OCp6/dUIhcWR7Pcx5P40eGoRHDAMn9NCEPDdNjVRmnETA1eB5VOqJBRBQXg56qoJnnAkuLJ010vO2eBbJ6Moo2U+jDpTqY50NyN4nu3S08dVPoawtM+hmPcmrlXk3zNFEzR4qB306la8qPtRMzoT9H9yjN9w2kqz7sWeu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wYofjiij1j1o716k3kbXJy7/j8udlV9n6nn+E2N4chRt1i7KgTGiVOuMGb?=
 =?iso-8859-1?Q?w09/IztZ6BjLFra2b0UB32g4u4qnjL1Ti73jDqzzGWcElHfgevOij8CWyy?=
 =?iso-8859-1?Q?bjPXQLG1SdKmli4VH5NWVLjeZFrrD/NTCql08EpZLopTgYsX86TqrYvCqp?=
 =?iso-8859-1?Q?eLHOMrO8bCsbikHHflNSvuC2FS9EquuXQgxkj1nqJWPViVARnEXXRV4Jmy?=
 =?iso-8859-1?Q?0wpXcBSNLGiNP76g5bHqmS6qoQLJiWnSTPcjMRZzncJSJtRGa4+vzTi3TL?=
 =?iso-8859-1?Q?zK6znrGP7trD9q/8oFgQi+2+cKXCiGNBOmaol21cKXqURD4ji3QhnG79YR?=
 =?iso-8859-1?Q?Oj1LAjRgIbkDG20UqXBYLsx1jRxfrPnTf06QyhEwQv/oFS/41rKiHF5Usf?=
 =?iso-8859-1?Q?UwVukXusTK09G1nLeNqBJBc7xkJ2RI6OnlOUpum4HKRSmDzWxs1Xe7Pcpx?=
 =?iso-8859-1?Q?giitAGWxzSy1aFUqSCTE4sx4Sh4Th84e+gVbokCU6PsQUKzHVQ7i17WECo?=
 =?iso-8859-1?Q?O+/kCG57Qga0F0OnvEp73qrEjjdagXMJUjndcQHpefODlq8KR6iBS5AbCD?=
 =?iso-8859-1?Q?MJJ/jOUPu5MILtFgRsuvLoGdMU+T6ZI6OfmI9u+7rbnaYUpSa8BjpAb3Hf?=
 =?iso-8859-1?Q?LTXie4+fegQ2cKQcKF8Z7eiMJ6a1V1WmzOthaGwhHDRsSWRmI3QocpQz/B?=
 =?iso-8859-1?Q?OkiNqH07nkSSID+TAnG58eE2bsZxRLgEI8JRXq4H5grvfV78e5mTB4/uJE?=
 =?iso-8859-1?Q?Lmk5j/s/axxOijn1u7ALyT3Vrh92gR31f97uQZRJw0L+5Tz+br7cR9JQQ5?=
 =?iso-8859-1?Q?PUnpasTHD3Hw85uAUDKe+NPwBdeRf8pldQCAWqp1cWFuAw1a+RrqThv3MO?=
 =?iso-8859-1?Q?r1/0fDX1GJ46hwMEuyD2Sg2ggftiSorUo2C6M/eylgg3kwY2q0p48u0RLP?=
 =?iso-8859-1?Q?3sNY+04LbKXUenSriU1/W+cWNbl7PA471B9mRGsP2R59dSiE9ZISMm6E9v?=
 =?iso-8859-1?Q?Fb/S/WU4L78txsAzpCvEt2/CK+KRPHkMk53J/ksP3N6DmQ/RIlj8vBSOVF?=
 =?iso-8859-1?Q?rvbel8R40G8Fn6klaRR3//GOr5Bn2kEzPlVZI1tsHkcVrlNGHOErxGQ3+W?=
 =?iso-8859-1?Q?R8Qn73bZC7ZLqI3Q97V/Uw/2ASPUMcr4JlsXkazFWiIKNgYjss+gP0X3kc?=
 =?iso-8859-1?Q?nI5HsSGRrDHRXGr+T0KspFpGPUtnZLKz+zuqY0abgnO2tQDV/0fT1RLGFt?=
 =?iso-8859-1?Q?WTzZziAG2Ycwi13gRdf8rtnnxxrtq+rHOhjwQR3GD7/Zg/PdFhMM3aLiYM?=
 =?iso-8859-1?Q?4BaoFbov9HZV34wUi6aV9eTLUNV405GX9j3UTbrlNaVNnKwFJsbSQZhOSZ?=
 =?iso-8859-1?Q?z1IAkH9tVhG4VNC6kcO10+zgFWSKdf/cUx1Jb+e/BeSDC2P1W5SZH5PtW3?=
 =?iso-8859-1?Q?4yya31JKtJwlRYWHdRMxUKJTGp8sQ6TlfaSi78gaTxGM8jOG0wwPvbVEn7?=
 =?iso-8859-1?Q?HAV03xnpIupncf5CIRhJZPstT6VFWuyqKWKpYIOFe3pX/Vfs4epsNJvS+C?=
 =?iso-8859-1?Q?PesENjc7bXKJFkOL39uhrqkbHYHo2+mpLzZ9PEPgRGGehuAuvmR73tPpo7?=
 =?iso-8859-1?Q?64hlqMY8kCJWNPB7Bci1OAnWxQBaZ79jTA5hAufA6zlPsofM3j7Pq0Gwl7?=
 =?iso-8859-1?Q?SnfbWk968SOaW6fJAjqSGT2+xPNa6orKnTy4BclnAsUN3XTCb8pM+JAT1Z?=
 =?iso-8859-1?Q?zVjwgdIxzwaHoWhdGGY3JcfR1bAxLjwLOMUirQVEvca2hYw52BDKqElj1C?=
 =?iso-8859-1?Q?GB2ESueHeg=3D=3D?=
X-Exchange-RoutingPolicyChecked: mmlR3r6lZ7s5vhHkc8pBjNYQIf/tissJ3xNhX5WYNfRGZUiNBdG4sZfszyvW1XutW5I3Gtjia5qLdpR5mAZKzlKdJPAVafotATP/bW9OAflcx1Nqe81KLEDuAa4S7b3lBOAHo3yr6auq7lI+pJq1j49WLdTw/7HLrVE4F/TSSxf8xalGdZ+U9dO7An1mZ9zE/3hUJ31H/jKn8MZIcR7vlsNsSF9inz5POoNU6GNHLrwPryLlQ7dRxY/Mo+bpp4FF+hZAJJX4vSlDZitI4IpaGXdahH+4af1lAKxMq0Iwub5pPyWUf8RunMN72LFmoa9ZQNHaiQ4ptRfavP0w6kNYfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72194203-8d1e-4cfb-1ebc-08df30dd785e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:13:07.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng5kxrMZgom7v9q2d5HhwLksEu5MCuTIks2MItw5e4NlrBjpeuChtLOtrRruUOCei00BaJDRYBYM+vu8NnCwPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB847830
X-OriginatorOrg: intel.com

On Thu, Oct 22, 2026 at 11:51:48PM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-10-22 at 16:46 +0800, Yan Zhao wrote:
> > u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct
> > page *new_sept_pt,
> >                             struct tdx_pamt_cache *pamt_cache, u64 *ext_err1,
> > u64 *ext_err2)
> > {
> >         struct tdx_module_args args = {
> >                 .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
> >                 .rdx = tdx_tdr_pa(td),
> >                 .r8 = page_to_phys(new_sept_pt),
> >         };
> >         struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> >         atomic_t *dpamt_refcount;
> >         u64 ret;
> > 
> >         /*
> >          * For implementation simplicity, only support demotion when
> >          * DPAMT is enabled.
> >          */
> >         WARN_ON_ONCE(!tdx_supports_dynamic_pamt(&tdx_sysinfo));
> > 
> >         /* A NULL pamt_cache is unexpected, so failure indicates a software
> > error */
> 
> On the edge of unnecessary to me, but ok.
I'll remove this comment then :)

> >         ret = alloc_pamt_array(dpamt_pages, pamt_cache);
> >         if (ret) {
> >                 *ext_err1 = 0;
> >                 *ext_err2 = 0;
> >                 return TDX_SW_ERROR;
> >         }
> > 
> >         dpamt_refcount = tdx_find_dpamt_refcount(pfn);
> > 
> >         args.r12 = page_to_phys(dpamt_pages[0]);
> >         args.r13 = page_to_phys(dpamt_pages[1]);
> > 
> >         /*
> >          * The dpamt_lock is used to avoid contention between the
> >          * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
> >          */
> >         spin_lock(&dpamt_lock);
> > 
> >         ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
> >         *ext_err1 = args.rcx;
> >         *ext_err2 = args.rdx;
> > 
> >         if (WARN_ON_ONCE(ret != TDX_SUCCESS))
> >                 goto out_free;
> > 
> >         atomic_set(dpamt_refcount, PTRS_PER_PMD);
> >         spin_unlock(&dpamt_lock);
> > 
> >         return TDX_SUCCESS;
> > 
> > out_free:
> >         spin_unlock(&dpamt_lock);
> >         free_pamt_array(pamt_cache, dpamt_pages);
> > 
> >         return ret;
> > }
> 
> LGTM
Oops, I accidentally included changes for the workaround for a TDX module that
does not support uninterruptible demote, and forgot that the busy error is valid.

Could you please check if the following version looks good to you?
Changes vs the last version:
- Added WARN on !tdx_huge_page_demote_uninterruptible() and updated the comment
  above the warning.
- Do not warn on TDX_OPERAND_BUSY.
- Removed the comment above alloc_pamt_array().

Thanks a lot!

u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn,
			    struct page *new_pt, struct tdx_pamt_cache *pamt_cache,
			    u64 *ext_err1, u64 *ext_err2)
{
	struct tdx_module_args args = {
		.rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
		.rdx = tdx_tdr_pa(td),
		.r8 = page_to_phys(new_pt),
	};
	struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
	atomic_t *dpamt_refcount;
	u64 ret;

	/*
	 * For simplicity, only support demotion when DPAMT is enabled and when the
	 * TDH_MEM_PAGE_DEMOTE SEAMCALL does not return TDX_INTERRUPTED_RESTARTABLE.
	 */
	WARN_ON_ONCE(!tdx_huge_page_demote_uninterruptible(&tdx_sysinfo) ||
		     !tdx_supports_dynamic_pamt(&tdx_sysinfo));

	if (alloc_pamt_array(dpamt_pages, pamt_cache)) {
		*ext_err1 = 0;
		*ext_err2 = 0;
		return TDX_SW_ERROR;
	}

	dpamt_refcount = tdx_find_dpamt_refcount(pfn);

	args.r12 = page_to_phys(dpamt_pages[0]);
	args.r13 = page_to_phys(dpamt_pages[1]);

	/*
	 * The dpamt_lock is used to avoid contention between the
	 * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
	 */
	spin_lock(&dpamt_lock);

	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
	*ext_err1 = args.rcx;
	*ext_err2 = args.rdx;

	if (ret != TDX_SUCCESS) {
		WARN_ON_ONCE((ret & TDX_SEAMCALL_STATUS_MASK) != TDX_OPERAND_BUSY);
		goto out_free;
	}

	atomic_set(dpamt_refcount, PTRS_PER_PMD);
	spin_unlock(&dpamt_lock);

	return TDX_SUCCESS;

out_free:
	spin_unlock(&dpamt_lock);
	free_pamt_array(pamt_cache, dpamt_pages);
	return ret;
}
EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);



