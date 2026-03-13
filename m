Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D236C0DC;
	Fri, 13 Mar 2026 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390773; cv=fail; b=jQhvTOZs2h12gHTIoyHzoXExaPfqx9GpSOPR1sL272COZDrfjzLnU6J+tHZGndCm37cJyT5+Ms8ZY1TL85EQpXkmh/cWaqwF+/wHz1q4OVWdKYiNdqJi8l+jK94Btuu4Pwf0ePSTNgkPK4of/PpACCsn3TgWJeArTieRrkGMwhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390773; c=relaxed/simple;
	bh=vJbjIO0pQ6EQzd0zXqAeqfgAG9MDk4PJoVTJrt+Q/s8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+hKDeONmha5nm44R9S87SHKQ8FnRlSjxIJgECA/iB64SPesKRQjE/v1OlOX2GT0ZRC6o2YrNcovw8G8JnBvHsAJCAB4l0ImPi1BIbHbiNWHQTmSJ5j1ADKMNDAFpLHegTOYM6DEtih0fjUtxCTE/pnybnxIhqSxzgu3g4W19b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKgPtGMn; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKgPtGMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773390773; x=1804926773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vJbjIO0pQ6EQzd0zXqAeqfgAG9MDk4PJoVTJrt+Q/s8=;
  b=SKgPtGMnpF4cJEqcEW1XtB8Z3FGKOrrbuyZq7l5902Wh2hyyVmF63f7N
   Ukm828yXM8ULALtrG+CMVZlILqNBSR76HSZyA7G5L4QPbRJliMHWiMY2W
   U3YVzpTicj/qGFfruYpSzgoqKiW5WyoJ+0+T5Nwsr+4hTuh33bazEn/eX
   dlH720CGngEH2FlvmpbaLi1yMURr94riEYatIMHZq5pWeF3AH89hg13zA
   R6B2S7P8/hzXyCql/wk0HtbtnRcypUWtTr5E50fusOPZLebcaiebcXV8t
   Rvi3dHXHuy1rSxBz5RTVBzuAwBR0swqHx/ZkY3oq0QOAKEfPxS+P0WU55
   Q==;
X-CSE-ConnectionGUID: QlXCEQZWShG7vE56JKeOCA==
X-CSE-MsgGUID: nvOtiHfjQJCL2hKkt5PQsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74377087"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="74377087"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:32:52 -0700
X-CSE-ConnectionGUID: sLHyX2tyRkOTVSqZdjg+4Q==
X-CSE-MsgGUID: OQLCHgagSjukrUz9BQ+MQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="217127092"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:32:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:32:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 01:32:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNcoxnxH27+x4v9Mj3vrw2LD669iPXXItgTbEnmYccaNW8ZbKuRSitoJ3mYS5Il9PcN5vFVhSD3RAgXl1ofXfVyoq7CUwe5mAEiqsww0LmokdDst7XqHxrIJM3XS5iE0oq/3SOdI6lcExgoJx/gNsyxTdGXP69e4MDvrK7NvR4jqZQYOcgHc5MyqbgRxMCHn/TFmOCLCCyjaqv6xo9cg93tdk/KIfImuaL7Uu6u71PDvG6HNsfwdUqKh4HZ0Ks119k6RdiyOxxzHPOWZZfEGytFbporauAgYNKmfVRh34qTm/BFfLmyaj70rjm0SSbJdKEyLexK5/+mc96UADAMURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJbjIO0pQ6EQzd0zXqAeqfgAG9MDk4PJoVTJrt+Q/s8=;
 b=Oy65CW8ClCV7sTf3ggP3mWd6Dwxg2JrAJdgeHdZvpFvpVDkpxK/XUSZm5lsGeRl+98oq7Ikpb7JA69hHVzpfe8MwFNEsqoMUGUgKni3MTMb/NUaOMKzEZtuTKfRAtYwrc1GGhgm/smI8LJuGBIGvbsGN2kY7YK8oCOXK2pRdDJNEzm65no8CgjkcyF5B7hP9wlHL5yTTOHUTACOmwV48tTi1bQmE72teLCQ0stdHOonY4fc5xpA9FxpVxCWdt2+ZlxPA5GR+PFNO6iInl/EgHrV7ZxleIhaoZB5LAKyCFqVDvMG2NtcRmoMoocM61lvy1Ms8lEKqucTxTE2TbKnyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SN7PR11MB6749.namprd11.prod.outlook.com (2603:10b6:806:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 08:32:44 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 08:32:44 +0000
Date: Fri, 13 Mar 2026 16:32:28 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/24] x86/virt/seamldr: Check update limit before TDX
 Module updates
Message-ID: <abPLnDLEaXDaEE4v@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-10-chao.gao@intel.com>
 <63082cd1-15ab-4aaf-83ad-f72d94b9bb8e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63082cd1-15ab-4aaf-83ad-f72d94b9bb8e@intel.com>
X-ClientProxiedBy: KL1P15301CA0053.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::15) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SN7PR11MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9a07d3-07e2-4c81-3e9c-08de80db1903
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: R+4kGfrzHU2wKrJSvRsFlCNaPiIZCK69MRdIaS0bUjY8iCM9bCLsicahv3pfwhlh+01NDzYD/1yzYdloGEf7s7pODPm2RZPUBXDp1NoFgMAzqZwWR9zUqWd5t8IMD7R1kgA6g6i6dB9xXsc0rmBa9eB2wQua7GL+dGG/4ArW1Y+oyPMqjUpeoGCY566u+hYB1x7YzGgVNUaaSp5nJ4E4oQhq8473oRvVezdFlorMtCdMJOYgEMJtYKD/nIAwf2Pwdjm+yeH9haRxBLvG7y3CDWOc2rDGB9ks05yfJVaBIwu7GG3CJ1OTxjxg5oehNhyMG2WjDvNSMq2Jh+Lh1gTmL2MqRtqlbOy4/L8sGkPmtDFN8cJbYf749ygaeiAuMqP970Z5JTdsvYEImQp8GNOoWN/Q1UgOdlQxjRjkqL9c9oIEcuKA//ydrNumsMVsabA83I30vXO28qnVKptlHpV3RIozPwZqVVk1UrDECZgDoG1nuVlLYAO280jzwkQ5NdT4wvRBYGKYaJgRXa5ByhnFT63vnPUttej4MhNMXKeeLFyWsCnoWZAMeUhn6Vm2mbLnmCYu8Z25SR5m2d1pZG4Lz17rDYdCRDx05AULrAKxELl1Q3s3D6TdokVQF6AmQvywWtFwGo5Eni8phcvFCUq2E9tBNO1vFcmIeuY49RRMom57EUp+nyQ/SFMuJtXpLVB+dDuP38GTnWMie1DNBRB6v6URZSFuiO1lwU9Vp8mgKEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6mKkk5n/axIBwZ7HtnA96b8gLgYSz+qVAy5KyOUKaViigJTMIRzJ521s2jo?=
 =?us-ascii?Q?1DsKyNPG/NwCvKcJpFYuqIgjOBbzt+P6Gkpfgm5l72jx/RGQ1wu70c9Z1quH?=
 =?us-ascii?Q?JJ9FgwHpkI0ro+4tG7my9nzXf143eZtdPKP+meVlOBh0x90PYx+NZ/OpQfV4?=
 =?us-ascii?Q?mewZ4yUEjizDDoGh40MHYqreNb4RR+/LEK2Tqj42R+P4u9jVENv272hXMsF5?=
 =?us-ascii?Q?R2DLELDSzJpibxT47fyZ4i4OJKm2WTkA3Ju/vTMgGL4DMRJ8c3YqDANn7tdG?=
 =?us-ascii?Q?Jv7aXUzBC1dmY5gW5/tsCezrmdFrvXFgta6MO9biREnp8eb1Jn4yldCEHtpc?=
 =?us-ascii?Q?bXrFlc83dPj58TE0Dfl4siBmVE/1hBhdM4DLjFGZrXrusAXaYV0/VsKYcdNn?=
 =?us-ascii?Q?xDtT/9YBT7XvFmxPhRRLq5Huu5gVVSoBIU++o55VcECSHr//bpKRud7kDCk2?=
 =?us-ascii?Q?tXTlfoXoWKDLJP2ojcyNLWpvcjm0fvI2i06T4lXtAbnIjQcUPnxyL9pZwxT9?=
 =?us-ascii?Q?0kwEOKa7Urn4bIf7ixdQ+kEj6ce34dhuxbpxNPs86lX8H1bC08UYnVxkckrN?=
 =?us-ascii?Q?6FoJ3Ro8aZqc+cJN9C17vd4TBqUOjx4egr7UPqYCN0z6sguTACo5zww5w4jv?=
 =?us-ascii?Q?b/lrAjkN0hOpaiCOVRPI/6ml2fyUz44nc+eC2kqeuFJeTYK3MrkRde1vwGf3?=
 =?us-ascii?Q?wjDK7DtUAo/vd+Og5dPXyCGglBy2ShSxykjFMGeGW1RwXRp6gwFlmwpZ/S7o?=
 =?us-ascii?Q?PdMoCKTGesMHsehp7aanpKR0+EGJXZBnmz9YSgzdXiUPKJ01xoTJJFu2uaZD?=
 =?us-ascii?Q?S4zwaAk/CZUCS/lDDare5E63rC/zVT7m7a6FwuyqpesH3NImRgE6ZowibwUu?=
 =?us-ascii?Q?gEQW+5MutMYqJy1OY0jEimMeevZqzGiROA76RUfK+FCPaFXCuGX9hSHnSlIK?=
 =?us-ascii?Q?0oyeXk6bAOm0hKaavI1NodJZSaMJ4bjkj6yZiRBQHcEiVtMP725xBXSff3Lm?=
 =?us-ascii?Q?WirEtgLKMBQc+vaFwYdfX/FVhslEfpSliyykt0ZdfkvadXCBvTi03hpVNcVf?=
 =?us-ascii?Q?hxvYuK2pkebhbiv8ZxXAndpigAjtQDIDM35XuJH4O+ZFkJD+4XwZm4IAKT03?=
 =?us-ascii?Q?DLrwVsEERLLK6wXhehwLEUFKIVhaKzasQwQk6Y1wVHELxzXcWGs/GWmrUj28?=
 =?us-ascii?Q?KM9WlwK/GP44Xqgaezyc1hai2uRp4K2c49O9u05ziM8VxsSzG0m2kM/GI+/V?=
 =?us-ascii?Q?i6sWYuhZ+WaK84XZhsy/G2HokQ2+GBIKDIe3Gwdeufg09lHevqsHanRQgNR0?=
 =?us-ascii?Q?apzGbK6bdcWy0M705lP5KfqQnXAii/8bDHEyYZg1zyymh/Cxm0IyljgvxcLE?=
 =?us-ascii?Q?rIe3XKbMde5XEC6N1C0UNdE1Ay8UBEv9B7gQpEVaYZMJU7ByKUqa6Eshazhv?=
 =?us-ascii?Q?RihCJvWVEW3UKeagB23HH6FD35exrURSMI986nl5DTMdHsmhbMETQgZE2qXw?=
 =?us-ascii?Q?bre64zuN5vJvyhjBIV8TxkghM4706r7DlOwvlKcPSM2fwbS6C7OCCBOYMn/3?=
 =?us-ascii?Q?FRwd1pYZGRUTIxHf9HWYQ1KXqBSUMgIufQL35CT8OXmeSBrM+q4PNNLwRson?=
 =?us-ascii?Q?vY1/64bjwiiaJTwDZkY3IXFmJhQEgPE0Nhx8CxOWczF+01PqMDNv+S2HfPY0?=
 =?us-ascii?Q?fNDdqnNQpmw3CuzG08T4Cd6R2npiQqOnTd8s/lSM2ryABmVfKgo4r3WP2+r8?=
 =?us-ascii?Q?PqeNsrLoXA=3D=3D?=
X-Exchange-RoutingPolicyChecked: QoaSk97mflK2aY6NVa/payY5MGKkKJAAQziMedL0xLfktRYXeyWjw2cBWpfH4vDTp8xJg7vwMV7q40xvrsWOshdlDTMlxqRnAm9xRoGXqGNWZ8VVyCcbZR4gj3fizqxN02oq5efAzGnv/WrFJf2E+z/wtFNwxvPRZuu9DUv/+HIEc5lKRHJnr6CSh0bwCBpWc0aDHCPsX7BKd4CHE7x71wckgk3d6tJXunq/5oJkYA0y45TMkTdswQbvCb/BBS2JfuIZ9wFLWwm/77GgD32691nklgXTw7JBrbcbdErosPvBLSetgXLgxdRQyUoa/sp+a2JehM9jO+DsWA1srk3T5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9a07d3-07e2-4c81-3e9c-08de80db1903
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:32:44.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cebABUZ4e7Ps+7DZeaL/9eY4zSH/QCZPzCtXwMH4cRli3mzmWFLQHzcdzSxSCfJYADAQFjhHgDRaWwaEaG+cgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6749
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 01:23:04PM -0700, Dave Hansen wrote:
>On 2/12/26 06:35, Chao Gao wrote:
>> Note that userspace should perform this check before updates. Perform this
>> check in kernel as well to make the update process more robust.
>
>How many of these patches are to be "more robust"?
>
>If you don't need it to "turn the lights on", I say kick it out.

Only patch 8 and this patch fall into this category. I'll drop them.
