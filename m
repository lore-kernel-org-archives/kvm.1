Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792725925;
	b=2mpZkuj0zII3VTJnxAuqIjQSfBXKr40tRgZR2SqX/uaZeH8NArSyYlbEM9N2D8s5MsWu
	 NGIbHaJh+hAQ3kj9M7Fg2k0SlWP7dBoHqE+N08Cr3WrnTYVS65WuwyXfw6DfHUqm/Jwld
	 xbfLRDODM/loYeujgGQ1K+7RUvntpjtPltQJW8W+f0CfBTH7hZAiseo8Bqmc8TOtYd5OZ
	 /YkMRE2h1FkHf2aaFFBcVMlIuERhwT6GLe+yloUR6GAZFTWnMP6EnIWCSr1s1m5OVZXek
	 +/Sp+FZA7fHf6vQogZjKYp74dX6tA/8CCqy1w9bJnr5bClFXSRcUw4AACsD2yBklXgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725925;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=DfUacEkvembd7nOUjZxEcOvW8vT53T3Nr2UPql+gqbM=;
	b=RKhAqvZV3aUiys/sRntw6l21+aSXbtutQPVgsUKiHXYkriHwe+YpeDVL70B+QxJqxyKx
	 tJjJJX6lEIqd3/UTdY8VZM9u1vNu3T6Q4hlazi1AmO9uPH4bFrGlGulpq4IcjD4HmVuFw
	 Ez09IzxOHOa/dZIFqwNoE1WcqFMmfGqZn2Gi29taKadKpZZCqyuHp6uLYbxvWm63cSoUZ
	 bDAERyf04Y9OnugkGFMqOIStCJAYSz+jqrEfUV8G5w0Ywh5PoEidl0/TusnnKLJpXRMmQ
	 L/zDdps6QDxQYJTVjUNN9H1ULFqqEBagi2m7k5K3e9UJLHMKgY5DIIAnFS7H5Qislag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=URYHez3c;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE1606A31D;
	Fri, 23 Oct 2026 03:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78CE1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=URYHez3c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792725923; x=1824261923;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uE5Kni8aRpj1jN+dIIEHGJLq+itmDkEKIINv6cMIav8=;
  b=URYHez3cOJdYwA+yiPB+6fttBjkTet0bITATj+9bsUNlx7JgGdU80FGH
   8gqk5DryUYdfciOZJ/+72vbyCAm6I9Wi8/2wpqdx2yYVr1rceDDRA5jh5
   f9w0SECJnsVhT/r0/oiSYWxxhy0ab3oq985SrHY6Rr0XL7fptU5dHPm0L
   lwzxW/yJ86xCT4ucMQgu0PloXle71HcUmizffWfwZaGniT14ilXyzqc3u
   9+NR7iqCo7PPfmjEYXur3uoHFO4PXSxkLUDi2vctzNgDQrDeganFMs1qP
   qGJaaRNe8FMVy3V3FknRBY0wisLyvRISpSE8OqCW0Vdnu0hnfUG6gch7b
   g==;
X-CSE-ConnectionGUID: NbbsBzXaToazNsBiRgp4kQ==
X-CSE-MsgGUID: wMrEhq+PQM+Euog6qWdyMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1494771"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1494771"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:25:23 -0700
X-CSE-ConnectionGUID: 5+5UggE6R2eL+WcF/VqfOA==
X-CSE-MsgGUID: bgbBMhtMSmeOvPCWfL+TAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="4003828"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:25:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:25:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 20:25:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VElNXdkhbm1woC1SOH9BMrhF2sU+UPg7K2/vZpDZh2mV8egbzTubognpgMUXgNZfivQ4vxB4zxLgNlEIwHDq3sJkvxugxK6sy+743KxGZdiy4VWiOUUg4jUq8q+Trou3cDDJufwCbsif9mhpCAReup7a7sLHV2NmRJrQteOVI7hNxjFEV7hqaRqSjJ1s3lFUkCw88fOfAGC6IFb14Ih3G3DVxQ+5xck40HJ6BNN7tRI+SxdP1b1ktzoxSpI7iwxp5T04x08emQlRv33xkQ9X4X77OG6fidq1bcTrMRwnRIRhMlgNkJL3vI64KKr8BjjuDBdal4v444ts9DUt5s1I+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfUacEkvembd7nOUjZxEcOvW8vT53T3Nr2UPql+gqbM=;
 b=gInanqAvYJjuEsgUgL3/bi8nIhtN3e33iM2e1q7WKxQ7WLuVYTOWukWzDjdw2SknCtmSg1RnKYj0Zzhicj8HPG9/pxHT/j9mmfuAthAaET63OiBit+yZggRFYjyThpIsC0LCeGZONmEdSs4nxAR39jZxbO3hNuRadqc7eGOiwakMyzXzs/3fl6u40T4v1ovidY+fELWUlb+8akEMSV1kWQPdRA+ztyLN95yWbyonLfq9lyT6VQtSa6BoxrI/Bkkiu7d8n1FOhVCmT+4DSwOEgoFRWleT1E370LJpFJAuVSPeCc0ZvDjgifWP2ZQNYhy6xRWFxPkTO+YNPYi/Q4e2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ5PPF20F246184.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::819) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:25:13 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:25:13 +0000
Date: Fri, 23 Oct 2026 11:25:02 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<andrew.cooper3@citrix.com>, <nik.borisov@suse.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <xiaoyao.li@intel.com>,
	<tony.lindgren@linux.intel.com>, <kishen.maloor@intel.com>,
	<dedekind1@gmail.com>, <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 3/5] KVM: TDX: Add CORE_CAPABILITIES to the allowlist
Message-ID: <atrTjltXoQ6EAyTO@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-4-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016091422.3182216-4-binbin.wu@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ5PPF20F246184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6ef60f-bc87-4c7d-8f46-08df30b54014
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|261022075727099003|4143699003|11063799006|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: wh4clCHIbrQiqxF35adUZyXGwbeX79WucXOnbINbnF/QtQF1iWeI5Tqa67f6wCpEsTnfo3q/S5ze+CmwUT2DS6RnzHNZy/37pFa+Q//SNX/QzPbuscJMaoMRaP0gThgUNUZTcKhdEDhBNXF2MGYcgyyXtPjSwh85bR+44gzZG/D9RxgdVGo0lYbjxwm16QUlljzdS5dtrRgx1S8sBWKk8XXfxS4e52sraInqBefYiUoG8j3UAV1JSu+ieScc3riedcADsPSt8YWwrKNXILhE5hYXFn8yqqX/28ZG2rWJs8A7Dmw5lj81oH+rujT8AOwMl5D7of58j0y47c++futmGypI12RtzdmJdHj2zuRT0SbqfPrffIz9pQhBDdPN4hMwBLS83EwqunA1e4gEDF+0jKLsR2STCxkm+WfPA86nKFqDYXZ6pEHf1HiS6Sm7huwnek3nWIun7U498ztHC+IJmbWy/g94OFsuzLMca/WDmU5PA1qahL7my0UFehlFRUtfO2PNZIIJ+GDzhtMXMRqGEwT7lzDeX7SYht2IP8phOpX+4qQ+DAhp5qohIfB1MIovSChzat7f7r/R5TOUKoTIbaabT4rH83IpRC0Wzp1hp6mJlKtL3CN1dgKG1jSvidBNdATCxQBl/cq4hFnDJlB229lziaC6BTsciXT13ixhtus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(261022075727099003)(4143699003)(11063799006)(261021121427099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vLUnl5qOxnM+HGZp4rsUvSctldXFgslUu3Vgkg1ghIZkU/cpbijkFj+cYbt?=
 =?us-ascii?Q?Ok6djoqTJCWT2yM1UvSZjrgBNhZGYpy1or1HWs7gMxfYmdaOUau1td43ba2x?=
 =?us-ascii?Q?rbiSi/z/TFn5OejLSCRFByuis3D533cITIYkoYb3bcyYNHYXa9u6ibB5jx/U?=
 =?us-ascii?Q?koSVTS0sKvN/0OOV3kI1s298fNK5DDZjwQKNiMqYDfM75Ed7fxyCwM3iMdAQ?=
 =?us-ascii?Q?+qxyTuFCk5JItTbqtc9edAhJ6r6CZU2+7/QAXaw3lVAkIpksSFRNtZi0CZxe?=
 =?us-ascii?Q?POCQxFh+EMMuVDBaxK34Hv/gVuwDgTB4oc9cA7VwFmpZFVr1GOqJ0j6V74Wy?=
 =?us-ascii?Q?3z3wqG1T/lY6BO7SN+nrhCsIZdC9Q7a41XLhJbZUrYDUhYQs+Bf5RS95CLjD?=
 =?us-ascii?Q?yHHxzsT3Bi+eCcC0XG2Vk5lQRs6CzKSwmolYDHsgnxAPU8bkY6A0kCV3cRsS?=
 =?us-ascii?Q?FFH7QLBopSpvQM9MBwM7Ebsz5kHFzQQAo5bLNdvlriXcl04vHqAOBonW6eUD?=
 =?us-ascii?Q?bArxcjSTyYZ9DoS71/4U2VpiNP0Ed34mvwklf2/T+wSybghr9iRX2Iwp/nhL?=
 =?us-ascii?Q?HR8eTMV1OfnN6Qkke8Dh1y4ohQTMNmuY7cZ097FhZmky9wlVSCS44XoxImKS?=
 =?us-ascii?Q?Ho6NaXnNjkjA1cnA5LlY69BCv/KsV3rU8FW6wSFdyeZc71aBSfzwBM5nVbRc?=
 =?us-ascii?Q?HWmbfqrgRPX9EdcrSfMvkHnVkj44TReBPuZdyHAl3Vrqfwc0KuAG1ihGrRXn?=
 =?us-ascii?Q?RMRAJdkceNwL8sf/Q+8F/JszKzmGYw38S1apDIvNwnBvw1PdNixqHqeX4FM1?=
 =?us-ascii?Q?5er57EgZMOZ6AZdU+oamkfTdohbgWlkBBaXSs/q9Z/CR6v8vz7IB9bqrLiYT?=
 =?us-ascii?Q?QvQwGtNa0vEOAf5XU/jy44mU1UUNOVrRecSAAGlSMcQTqJV0ehNa1Y86yrgl?=
 =?us-ascii?Q?A5gGH7xh2zi9aDlOIQVDZ7kUMIfg+RWObKUhRimc/gDFaDR97XAg5ykY7sa9?=
 =?us-ascii?Q?Jcjqd6x/lJFSr9CSTOgB98QUofcvDzMeIfoS/oY5Hm2VbKE1x3jUkKJHGtqF?=
 =?us-ascii?Q?yHRSTE274iOYoJSxigRWocNEh70ydssHwfav4YvJYO3AkDJQi9+504HUgpsn?=
 =?us-ascii?Q?cGfvVrKtsHL1+J+z9UC5jMeyJTGERgzBjZVMndB5wbyeESwLp/RwMDD+t5vQ?=
 =?us-ascii?Q?hLIjw5rVU8dvDGgpOjbH/WeEA4EGvDH2tWkf2b8DfaLVD/Odri88sCXvmDdZ?=
 =?us-ascii?Q?F+pbzvbuVPXVxwhJIbkwd2GY7R3j9MOT/cvB3A7jNCeRQwcG1Lhmzr7LPxpV?=
 =?us-ascii?Q?SDcCXbEuk5bOMx2KU01SKzLjOMpr8NhUkD7yoE3fsRSVzOo1hQoJTVSlrztG?=
 =?us-ascii?Q?XcCJS8Mp146T1NGAe7AsJzK5guVNRa+12K0JU36JALXzIK92RKrGb2Kt9jdK?=
 =?us-ascii?Q?dUzPjqPT2lOw0WaWr4Ukvf9ixTffNJ5TPBxH5whzHatQeEBV85K8olU0Zot9?=
 =?us-ascii?Q?aKfY26ejBXcaVNGW/Pd/NUPJFODKY3ZgM1asHjvJuFOvF1Gw7rr007PwN7yK?=
 =?us-ascii?Q?tGQnf91G+3UdkGibfW8aUjkQUtIOvk1KQuI8wje6h0UTgDMJLcM7pPKg5Xq/?=
 =?us-ascii?Q?u3wH50D6d/8g8xltZVNPlEZUyVXBZ+D6ASOfyLWhibhUw1T+aRSEloseR3+6?=
 =?us-ascii?Q?yY3oCa9CNJ/MqVEYXd6YOQ1SKEs4Ptfcja+Psenb3NwT2QnzRLROXJdvPdi0?=
 =?us-ascii?Q?L9RZzRt7/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: uFOeVWSOAFEikoik+5czsfxSu1lafXjkaRtoljqMiACut35y2ZR/ItqQPzv7MxBHiASDegwHUn1YzY10M28uQrerBv4VRN2gg/UK6OmN8NhgL1JCbaGO48R71KTYE9yFNJJr3USYfJYNPb/BxYjRSxDlF6Q25tQB3KUELew7HwEpw5BKyFGN0KhG5X51iHDGHEjBsU5XbGLR96hVN1RRgFvUrK3uHNg9J5h/ZmO8nRGj+/xpf3OIU6qpzNyHShYhKuSSLuTSBEt9b9PvoMe5dwXSc4zb0aHWBRGZtt35xfp3oaueImzDFeumSQ/JHYDANY+CyOG2M+JcOOW7nLuJYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6ef60f-bc87-4c7d-8f46-08df30b54014
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:25:13.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAUrrre/wzba4VKMNxgaoyvgLJdCu9HYUgiLuBySvevPTbT1lkOmEx4jal6Nt/eUABxv3/DlsAJAPHHEdiJqhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 05:14:20PM +0800, Binbin Wu wrote:
>Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
>directly configurable CPUID feature bits to accommodate the legacy TDX
>module definition of the bit, even though KVM doesn't support
>MSR_IA32_CORE_CAPS for TDs.
>
>Older TDX module specs define CORE_CAPABILITIES as fixed-1, so userspace
>may expect the bit to be set for TDs.  The bit is redefined as directly
>configurable due to #VE reduction.  Leaving it out of the allowlist would
>prevent userspace from setting it once KVM starts validating the CPUID
>input to KVM_TDX_INIT_VM, which would be an unexpected behavior change for
>such userspace.
>
>Reporting CORE_CAPABILITIES as directly configurable also lets userspace
>detect that the bit is no longer fixed-1, and thus update its stale
>knowledge.
>
>Keep MSR_IA32_CORE_CAPS unsupported for TDs, as no existing TDX user needs
>guest access to the MSR.
>
>Note, CORE_CAPABILITIES is the only bit that is both unsupported by KVM
>*and* redefined from fixed-1 to directly configurable due to #VE
>reduction, and no further #VE reductions are expected.
>
>Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
>Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
