Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844493A874C;
	Mon, 29 Jun 2026 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719798; cv=fail; b=eUvzf7/ucQqHt4WngeeTXmzMDsWDKCWHexR227+tGsKCFZCuJd7ICbIlBzLQoDpRFTsxMgs0NL6r9Fbgr/f3kM3GnOJYydIed5HpYKbiTliMwYyP5MAHo5MwvwrEhxF1BmhFIVBZeofV2wzxmaSTMmVwvx4hEentVwtixQn4Ees=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719798; c=relaxed/simple;
	bh=oseWHzE2yctQ8NZdlYC7szAUZmyAkhucMCa6PtNxtyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O7XdoMSMqOjdo7kR0H/rvjaMNgJQI7JONfJiQPWxJOJLniXmXOJ45uPPxk+cOXpuvkBgnwvo3bmZgTowc53SSK3fjeDMG9WTNwtPvpJAEcJhp+ZV/6T4JxbZ1c0wLFDrxeUtDWguKMX/uYL0+6DRICKMybtOUBSUEPBQZwSkIKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7sd8bTg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7sd8bTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782719796; x=1814255796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oseWHzE2yctQ8NZdlYC7szAUZmyAkhucMCa6PtNxtyE=;
  b=k7sd8bTgAI1XjZ1bGKKh6dMFXV02tN+bGsJng1Q7lWeZ9SSs5s3r5f2H
   FeTtmqMPf+MbJlF6sIt5RtY0c9Lx8oFVRIlEL1tV8L2UlJsGuRhZ+tmxF
   Cy+am/oF3o3b5mn+Dsr1jxTS11jCxnpHStsWfxEg6RaQdfwapIov9Uvyy
   c3NjW9lVR728IKhy1uanHEkyDH3vVPYFpuMDgY6Z2yFEPJSoSABMJ2Xfs
   Pra2ifqhtZ/SnlYd/vtm1UxDkQQPhpEbgSYMhVlithgBJNjJqsgVucnBE
   nNuyM8CORA/T+sswK3mw2c+1Pm7OBebcEDPEGnEpKZtBP3NT0EYyc1EPI
   w==;
X-CSE-ConnectionGUID: 0A7TGwP9SPuTRTLAMdr9hQ==
X-CSE-MsgGUID: 0ay4FZlqTbq5oGHhiXuIUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="100837816"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="100837816"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:56:35 -0700
X-CSE-ConnectionGUID: KDkfxJIoRjW+TVQCdIQjQw==
X-CSE-MsgGUID: BdZkgGk/TA6oQ8eCxAEocQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="290008306"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:56:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 00:56:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 00:56:34 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 00:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiKkRj05AKJCsvOaR8X/+u9OQJ5IrCj5qdL+Uj3SqjH/VIqOk+IDbG6sMPlw5WVkDYWalBx5s5sDUu23WgLL7/fV2E2bUYih160rxKmi2JjpVG/0+tNCR/BfGGEl9MqmvqwAon34DYio+BLMRoFdwGd1HvQhXKbFa3AtbDyQtWstuzIf+SOV24TBeIe1xFCgBcFprNiTZD7qoNmhs0bvFmIkf+PWZbbKlfqXqO0AJvSOxAxpwTo9sp4lCLefE/ADauofSI/pbEaB7+ACsBp3btJT7quLYLjOWYFmq9z3xIqLLxhkQhvjV5+Q5rv5ZAR59MzKIACNXRpdsM8M58HDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7byLpCcgDzq3n43poHyLumkGtYMCtCkzMvwavRrlMGo=;
 b=QH6P6bmPJs8M3CeIVopQeLUu+5ssRor/QSnCiikrI4DKiX/yrVo89LxOpu7USw7N+40QC5CxpHHIBoLIqhPZPeglgJgrbrjYC51VLXNbhR65W3Kz7ZQSLJSDqfDcNfp1VNsrrsVzcPFxlWidp9WMfkigHyBrXWoB6l3PlFEu+dl1kwwU6JXjxXzj5QhYULPnP+g1/sstSOL8tjrJ7/BxtZq/PiKrgVYQB73HVbwWTzo4bOkjcbyUT8l3c7PB6Nmrq21HyohbE1Ub1mvbSFEkjrprfXl9Uw9WeuG1g0keVSocuPeVLNnlyYsaKm+LXIfrQYi5lr7AhkcC2HT4N+69YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SJ0PR11MB4878.namprd11.prod.outlook.com (2603:10b6:a03:2d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 07:56:30 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:56:30 +0000
Date: Mon, 29 Jun 2026 15:56:14 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<peter.fang@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <dave.hansen@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 04/17] x86/virt/tdx: Add extra memory to TDX module
 for the extensions
Message-ID: <akIlHqh0/Rna7aYY@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-5-yilun.xu@linux.intel.com>
X-ClientProxiedBy: KUZPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:d10:24::12) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|SJ0PR11MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 15312401-4791-41ca-ecb8-08ded5b3edf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|3023799007|4143699003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: l9ApBKTnoVBo6RDV088My7CYqLgXNx4MYUUXyacVIAqVBUi+WyP7y/o9LLlawpfKKdyxi5cEIROxVcKt4eLcLByVVZku0r3P/2rwlipIuoDV4P7lGBH/sthKfIkb3eP7klcHyzknWVgfcnGrxP6xVOlczi9MCgAT5u+xLcGI5tsEL+2EEhL6o6WPHCPRiy9lrUGStR1cjPCEQ5Hf1hjb2gbpfZIftygfxsdYkwH46NZQAMW6c8u4DLsl1fFedgq/Gs7VEJ5IvJ0r9a/FhpXQIT2dgth5g2cX/SGl/M09/Yv8gGjNzo9e8dm0Et1D3Lg4j7dLra8+wyEImtvtKcuzxZNmpt4HRASeyZuCubagLKh1b5vT0mcThMvCEoefWZfe4J3yihWP7N34DNgxnzaKmi6dNjzmVpR+sf8LWvD7HuBu7dwrOqHdumcOdk52QcdAcL5DT7WrhRxUaV6ciXYwGlpNRXk+3VoeY5kfDTvL4qElSzwiUMZvdDQexj8bL/tEjGRxlCgedvBQVf5WrQ6X/Aqez608iVGj+iIUpoxCcF6P3B20cuubrQ7pMKogOS3mAP/g+fKxI1ggfU0pXG8Y8Qr7Yl3yS5DId29beR8+5WadJJvnKqTpEp6Xp67a81gsE3H00vBcAtWuLDnhbeXSxw4/QkxSDhppbG96t3jsSiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(3023799007)(4143699003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aipbHJQ1iWXTvQ+vtsD61M/xixfUaA+ssgzOVl6Eh7UphWhLZiVbAcTnMO7f?=
 =?us-ascii?Q?H7iJ5pIHPC+dhuAq4R1twjieYWPeJS91+oAi+Ufw2hdEzLgUSg/oVOdyYJaA?=
 =?us-ascii?Q?wIKrjAkJ7kTv6XKz54Juw5gTYixRINO7TmufApL+9K4zP2m/u9KRa0FHllGo?=
 =?us-ascii?Q?q7WlupPAg6nSNCUFXizwySndu7z5BZSOcHvgW6BMyrV5pUncegN4Zs0ByvH0?=
 =?us-ascii?Q?A+z9jM4a6/Y/GvMlvy/8Ij328zomBpzQMBHkJvd1Bv5wlsg4SMNiTkKaeICg?=
 =?us-ascii?Q?2yrtCNbNHLbk5qVUcKaR9cLUi5yRYrxx4eryLsxH9GC43XAINgjTR7FwPwP8?=
 =?us-ascii?Q?IiafaGrG4z7vu6rHl9ZHwkqfiXwtnegAxqFWf+zHyltYsrQpkJqAyMC5VC3d?=
 =?us-ascii?Q?QREoIH7djNqElzH1XIYzSv6V8B5Y2oUAq45pUZuW+8yz3IHVxNGs63dr0zcB?=
 =?us-ascii?Q?MEyd3n7O5rvNPqkF148NXGZ0CCAX/m1qAjRuuBj72DxEHIFXa80NP/YExGcV?=
 =?us-ascii?Q?7hOyi0gwIiKL2bXVQprxhOhY3ExjUWHUAshnddw23qWm9VVukFGbgYlU6VgO?=
 =?us-ascii?Q?BSxgfanArsq92HZ7NDKsfG1NVhLzF9+bj312R2ujFSgHPWqI+U8es9KhRxEb?=
 =?us-ascii?Q?mdcf5ZE3w0gWW5oqf7s2vLU4zxXuuppnskcKDR2RyxT+fQ39q9uFB6Zmh2zZ?=
 =?us-ascii?Q?97nRdBtvzr56umCPEksgriSPTwODZ/BvN7neBGFd+iJ9ltXgb+wzPgLtpNPE?=
 =?us-ascii?Q?QpJbWJDJiFrXHi2wqLzvWekDHm4dtIndlaEKoCXn8jwkOGbaBWfdx1hH7qql?=
 =?us-ascii?Q?IxrxZZcTkYyraCyMDl58dBvK6le6dpIbylVpGDSwyjtGkPc48Wr2aqvXwLJG?=
 =?us-ascii?Q?ibGf4zmtgWauXZlaGLgQxMt0VEIrElz2pvDjNWpDp45btxUZ12o0h4C+AVPS?=
 =?us-ascii?Q?hJyQ8eT02tJG20LLnNCvYd387sWnbJp8Ace77nu+9+FsrCZHfPYugDAUp5kH?=
 =?us-ascii?Q?1XWfFH44Xf/ipbh1t7AYMIlHfOfJr6FMCPGRusyMO+a15wk4NSg5LF4UERQM?=
 =?us-ascii?Q?lQt1po3FbhwSCOWK/gXf6NouSdrYlZHTt6O5pDnbpRhRhPwOANXCam74TFTb?=
 =?us-ascii?Q?pS0knEEs6n2TGAcF0VcpVb+MJ4IaqEZsIvBj+j+gyd9JyKgIV9AAf3RBJueI?=
 =?us-ascii?Q?b3wJir/P5OnN+nSAH6Bhq5z5CNlLQDCJp09SPYFs3wVGB9j3jwV4r61XWpED?=
 =?us-ascii?Q?ihfjn/hTE3hMy+o5ZZzlQMu7798BTlNBYHsdm3U8Y7VkT053HYeKWbZH91gW?=
 =?us-ascii?Q?iyum00HgAlzVcj67jJ0l4Dzz/Ml8sFlHOVlXdceq1m4po+jtonc6oCq6A7Ic?=
 =?us-ascii?Q?NmZ3Ms0h8n3RUSoXC+sPXbNnsQx6wGPqW+Xn9nm07y/zsy+1Ew40j7dhIxsE?=
 =?us-ascii?Q?pf2wtAVcGpfiuk0fQRq9XA5ITUIOP4758y0aG/HpqGSomTK8xobfGOlc70qV?=
 =?us-ascii?Q?PJr3vvAOqbD83uHH6nvO2CWkweon9N/0YS6fyem21XDjjlwLpQSbThAxSi7o?=
 =?us-ascii?Q?4f27EbVqAYiyfTn4IGAJ09yQYR9pDFKJ3Sutymkkglx3L0XTwcohg8/n5kSR?=
 =?us-ascii?Q?VPeLBTvPXPej8qcb9lyGhSSxTTFXQN57uIiISgfOXCS/my1UH92nJeuDEmoc?=
 =?us-ascii?Q?p4DUv/olzTLxvkfsTpmkaiaa212NAEod2nRqFL5RkQvyLuIkKf9dnnGiWXzp?=
 =?us-ascii?Q?3o2NL9LqTg=3D=3D?=
X-Exchange-RoutingPolicyChecked: VHG4UDH83wK+CMdNl8n+Rj2khuRT1qxPqXm+NPDFT5GePm7rhXLpWXXZzgSPM7F8EWaePbAhZL3jIoOAJLRrIKduRDdjpPcTHjN6UUd4qZKwidz50sLozQPGF/UCAgvMBHJY0qbN5YZRpo15zzsHILAl7zEW1DB2NQou2J2r0YX3/EOVoFFyr8KMmPsrBB2UzzPvhdRsyt2udgq5dO1PN9jqenY0RUHrCXp1ChahPr8fbAHYc3AMs+Igy98c1jEwSS4y/POD5nsuS5q0pEz9yDkcETvX94vab0yttxhRaW1UAcUPdbpaMpU7Jg9rE+AavB029eTK/gF8HDzhcverBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 15312401-4791-41ca-ecb8-08ded5b3edf3
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:56:30.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClL0RnRoP5Pu31evTVbLiViRw0oqmtfziKFzBow7KC7BrOumAjaqLGBezwfJJgFMT5zeWP3OHol6Td8vLguzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4878
X-OriginatorOrg: intel.com

>+#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
>+#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
>+#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
>+
>+static __init u64 to_hpa_list_info(struct page *hpa_list_page,
>+				   unsigned int nr_pages)
>+{
>+	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
>+	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(hpa_list_page)) |
>+	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
>+}
>+
>+static __init int tdx_ext_mem_add(struct page *hpa_list_page,
>+				  unsigned int nr_pages)
>+{
>+	struct tdx_module_args args = {
>+		.rcx = to_hpa_list_info(hpa_list_page, nr_pages),
>+	};
>+	u64 r;
>+
>+	do {
>+		/*
>+		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
>+		 * override/update input parameter RCX, so the caller doesn't
>+		 * have to do manual parameter update on retry call.
>+		 */

I am not sure about the "manual parameter update" part.

how about:
		/*
		 * The TDX module overwrites RCX to track progress when
		 * this SEAMCALL is interrupted. Use seamcall_ret() to
		 * save and pass the updated value back on retry.
		 */

>+		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
>+	} while (r == TDX_INTERRUPTED_RESUMABLE);
>+
>+	if (r != TDX_SUCCESS)
>+		return -EFAULT;

why -EFAULT?

In sc_retry_prerr(), most SEAMCALL errors are mapped to EIO. Maybe
we should use EIO here.

>+
>+	return 0;
>+}
>+
>+struct tdx_hpa_list {
>+	u64 phys[PAGE_SIZE / sizeof(u64)];
>+};
>+
>+static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);
>+
>+static __init int tdx_ext_mem_setup(unsigned int required_pages)
>+{
>+	struct tdx_hpa_list *hpa_list;
>+	struct page *page;
>+	unsigned int i;
>+	int ret;
>+
>+	/*
>+	 * memory_pool_required_pages == 0 means no need to add pages,
>+	 * skip the memory setup.
>+	 */

There is no "memory_pool_required_pages" here.

>+	if (!required_pages)
>+		return 0;
>+
>+	hpa_list = kzalloc_obj(*hpa_list);
>+	if (!hpa_list)
>+		return -ENOMEM;
>+
>+	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
>+				  &node_online_map);
>+	if (!page) {
>+		ret = -ENOMEM;
>+		goto out_free_hpa_list;
>+	}
>+
>+	i = 0;
>+	while (i < required_pages) {
>+		unsigned int nents = min(required_pages - i,
>+					 ARRAY_SIZE(hpa_list->phys));
>+		unsigned int j;
>+
>+		for (j = 0; j < nents; j++)
>+			hpa_list->phys[j] = page_to_phys(page + i + j);
>+
>+		ret = tdx_ext_mem_add(virt_to_page(hpa_list), nents);
>+		/*
>+		 * No SEAMCALLs to reclaim the added pages. For simple error
>+		 * handling, leak all pages.
>+		 */
>+		WARN(ret, "Fatal: TDX module rejected (%d) memory for extensions, stranded all pages\n",
>+		     ret);

Printing 'ret' is useless since it's always -EFAULT.

The real reason to WARN here isn't "no SEAMCALL to reclaim". It is "this
SEAMCALL shouldn't fail, and if it does, things are broken enough that
complex error handling isn't worth it".

>+		if (ret)
>+			break;
>+
>+		i += nents;
>+	}
>+
>+	/*
>+	 * Memory for extensions can't be reclaimed once added, print out the
>+	 * amount, stop tracking it and free the hpa_list page, no matter
>+	 * success or failure.
>+	 */

This doesn't explain why it should be print. How about:

	/*
	 * Memory for TDX module extensions is never reclaimed and can be
	 * tens of megabytes. Print the amount so users know the cost.
	 */

>+	pr_info("%lu KB consumed for TDX module extensions\n",
>+		required_pages * PAGE_SIZE / 1024);
>+
>+out_free_hpa_list:
>+	kfree(hpa_list);
>+
>+	return ret;
>+}
