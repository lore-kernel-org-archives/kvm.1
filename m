Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7603DB64B;
	Tue, 25 Aug 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645699; cv=fail; b=u0WU5EotowdSsIXdcqPfXlJHPhCfQLrRdcd2y/eUVxAm6wKlWRyaKoSdo0v+HZzI8cSaxRBWFvIkHnBAWyRicDFgXjwqDHeANGvBr8FGQXfa/KpgI/Y+xNx9yoKTtoDf3xtIc0/NmtK+rWMXpHY3SJZraV/LtWJHmxjzjfbMvQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645699; c=relaxed/simple;
	bh=Mub6cNhwFx964tMc5R+8qcGZg4TZJS2koX4UN66PBWk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WC0PKCgi3UiJfZF8cuIbI+D3Q1wN6M2/P1TcZC9qCk0XTPwl1UHJxZ7hZ4w/yBjdlc6WTQJYTvE9zjNMGKsDLaK6RH3EXICPWjTFbKZoSkyN3IbMub5KhdJrZfMoxaXJK+nVkahoqKawq9R0q9Quy/iRA9IEXA3M6Fjq1cOn/TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVXKiJjo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVXKiJjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787645697; x=1819181697;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mub6cNhwFx964tMc5R+8qcGZg4TZJS2koX4UN66PBWk=;
  b=FVXKiJjoSPxuJApuEpJFRXYxwfqN7JmT9bucXnxPCZ4U0kAcNfHm9I8k
   Z48qanZmnqBSzwUxFE0JzP7J+pXqdJYAfgrOInnjMelXpJrNk4nGG6cwg
   xM51kQ1pO/E8shjRXTVjgd9c2NvpSxYsdHU3WuvOnRM0pI02+BQhduN19
   nx615809nLxW84z2F6xsCiUmj7+/lHngoXSI8sXHF/L41CuuV/2Amx9qE
   dO8XJYMSwbMOuqQv59I/xMzGkLm8u6YAqTTAAddyjxzga1bcJ1daJcNYe
   9zNR0YfMoCYDFEqMTK+koAweX5r0QJIy6i6xg/Syi4cjciOaXNSz0tfyz
   w==;
X-CSE-ConnectionGUID: UiemII6NRbOWufJo2YrBxQ==
X-CSE-MsgGUID: VVYYfoZuQAOnAsgKyCXZxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88308753"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88308753"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:14:56 -0700
X-CSE-ConnectionGUID: eNZAQh2eQayoIj2m2nHcJw==
X-CSE-MsgGUID: fEnpI2iiQWK1Gv7nuJHDJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="265450704"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:14:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 01:14:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 01:14:56 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 01:14:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU3ibQiTeSuN8kaFjUtv0NBnOvQEfMuY8bq6s/2NAhFPHOXSuf5fksKL5RiVqnyJD5XSPAgYAFpphRzyT92/iU9odslLTee15Ms0ojiBdeyd7Okg9WfchQYamqsExWGHq5iC/ln1pf+qjs53UlWuhgmupZtU/DtdBvOmQwX3Br/X9dmvVjM2hIPlwnGzhcw/UxqTPoVSawlO9llDLu0eBAJpIBSdl/Qpr6WSbXjdUWWDHfGGi2Ni0Vtf3AjRqZi8pZmsPUDCnA1TwUqgV9wjKldMC9Q3I8LjQW+FK+cXYhwz87F5SuKSdtKVc8D3i9tjeaLXhHR64WIog/AmX34RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z5MG7DHyxDIyX/eRq/oVpP9hw58l7O0s+oLqyib/GE=;
 b=mH6rF19f1EqG3ir/YBKeZSrCBieOZaSelMMow0Var5KZyUUuNa86oOCWiGdXtIv9pYoMzNkOPE46dfIG1nbgHkAII5gB8qdreTNq9Y04JVdB/KXWqHILArA0J5cFkgp5qSvG7IJTb8iMxzrwnyiqA+/yxuwOZKvbtx6wUgCj7jSgQroDj4M9mSe+Ex/NOFZVFIWkNlPm3zeWhTHs1uQjNrhgKHVN61tSMa2HDI1c93O8vDXT0Gw1vPY3DRRTxJXmaxuKn7CuNipNKSnQiIFxfz7CrJ5ozQWh06hN1l7fqzU6XqllPp08jY0Rp4WIZb0SDpIDtHTIJ3nB/k2SanRnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:14:52 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 08:14:52 +0000
Date: Tue, 25 Aug 2026 01:14:48 -0700
From: Peter Fang <peter.fang@intel.com>
To: Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 11/22] KVM: selftests: Set up TDX boot parameters
 region
Message-ID: <20260825081448.GB3694338@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SJ0PR11MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a0fcd6-2036-4618-18cf-08df0280f023
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|6133799003|56012099006|11063799006|10067099003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1r3FUlULPUt47YpIHZ0yhc4UzvXOCjAONKdSiAKpNavcKA09fFQK43kakA+U3+Ia1DbfJAY7zrIKRI0PbHiRLBowL+Ggy7okp4RddRtWpewxEZiOXmCXjlHuoY4k5BlTlkr/H4aso+6GqnFBKfYDlQnI9+q8txkm2Slv475rK49snDgWHJFcKeh+1TEJfrnF7smrSDCrb0NkXicGA+ooU89ivCRGINU8y0aszNlE9QIbqfBoUV3rtybpAScZbOBnzK/1S/LB6RvDwSChlFPJmLqoBUMPEzGmcMKeqsmQE97mkJY4ebsjY9FUPqieukjO9ns44luMd+jNo1dHO6ZSa8dA0yk0VyIojUtgReNAAWQcLuILzf4Sofvv2LLgv0x/E2KpDTIEVnHxRxavqqw8XrNTS5PjzOc6GUNftZrqo2YM+o9zhdhi8qQh399rAZZU1udscHPIFszqjmOL9bhv52AgNMXufgFncttj3WfESriyJmFsM2j0PYJwPCHcbpKySS5cHkCeTdl2XPSe6ljB9Dky1lIQ9hWDO02DOZIyZ/bE1TT81XrY7dDVj/l9sKMl2bNqZWvfor4XH7Sdyuur2cIJ4FNG2/cttUZWR75BJuOUm36OsDodglmf7l1e3okPT6A82YfZW5gM9Gxx3EkLHEaTrtskbtzLe0FuLlaUGxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0CbnxFhXpb1hz3AIm5HyWlKvaVfvY5n1mIMxGUOj1K8yVHWEua9bc9aP057?=
 =?us-ascii?Q?NnmX92c7SduMOeoQ5yxM7cHq5UF+3dHpDV70itfcWNp66MYCOkoFeQ6e+4Ql?=
 =?us-ascii?Q?FTG4Qb5fWT9ebioL1wDdU0lvziuVXC3OCdMM2QwAWJjhYtPC2gUCkov7u+TW?=
 =?us-ascii?Q?gcNUZJg00VvJMI5eYBfBlaw8xkAUyA1rg4N8DVQwUWqfGDuGgSixiRirFw0U?=
 =?us-ascii?Q?wU1nC99kSC0ZyrtD205IGR0KURmVJPc1iy6jLnzDA0Q6v++jWaNAe+XzO8Ln?=
 =?us-ascii?Q?vuk1w8C408LMpF6KhtdiV0BDmPfF7SF1xfQFwK0fTTLBSVZHR6zqN2I+/JqX?=
 =?us-ascii?Q?znkmUn4Lh/nrw/KN+bCKBGGLmbgDfa5Z0hOsgi7GWbKRzAHRSpA8+0Dwgeq9?=
 =?us-ascii?Q?b6RimJwufke7oOLkOOiwDDWR4ISB1KbecS8TBZR0jwhgGyjmKOT+Ajs3tRT+?=
 =?us-ascii?Q?f15pHXzzQ6rkzRhP/DN1GAsD5EoLhA3Arg3eRMfe85/TZgWU+fA1fg5LlpcR?=
 =?us-ascii?Q?9Fww5CJuskQTQ0bcuK3o49nGN84Io+mB1NhIHJ7te9MWtCo4wwCQEKJEeV4C?=
 =?us-ascii?Q?pwnjGbwJmEtyngsYzow8nyed0/EGv7WEqvufaYEr3N4QDF3jbhF8L8OKM71m?=
 =?us-ascii?Q?ATW9booeTjoTsSUhTY9ISDhNfWyQ+oI/33PeOFlS6nK5/kAcm+NiOM1olm/O?=
 =?us-ascii?Q?C3HEPIzaweM+eAS8P50V7cvRT8OXcFPznUWf4X+pc6XbrYUeqLxvle5FRC8E?=
 =?us-ascii?Q?ZOt6aeHIiiJmH1Wn6RrzKFvAhOIIANDxr5WWS+cHRSG1FkgyuoWgg5ye/4Wa?=
 =?us-ascii?Q?55xabxXEZdEPDnfWSQgj3M5su+uEHQq3+G7Q9FDlPv20xBFclCtkEHhyQs6t?=
 =?us-ascii?Q?V9e+P4jRikKvBIYaT7ykBXY9N/WhMpCbHPOAZSEciKLSlImJNoYQp8GWEexJ?=
 =?us-ascii?Q?MvBqu7crRVdkGO+Jg8DIG/sAas983HUporNDdK2aW08J2ehgce9u2+xqd63L?=
 =?us-ascii?Q?OHON9xMhNUvL41PEydjndUvn5RX6cYte+FXT72625Mco2NHePMhhcU7pD80+?=
 =?us-ascii?Q?TICnuOLKRiim73g4sKemvgcWrRjRboWsYyJdt0XOKYCI6gWBkdEdL6mFLmA+?=
 =?us-ascii?Q?7TsU0crrAS5IlhwX8D91fp/1BteFw71rih9nKsShFo04It0nvH+TzSiDcZAt?=
 =?us-ascii?Q?/MNNedbKQBSyd8UdOJk8mFjVlzcqHEnk8IhDfCzdcOPCH8vnrujs0SGaNH7P?=
 =?us-ascii?Q?5fogA31zU2hdGHcjzRZ2Z0IqmSwmVkMZNS26cWzhiN1fWNacNOX5D4p795oq?=
 =?us-ascii?Q?ULZfIu6EufrQhxNtl6u+FZQWEW1I2N2zRkO0WUIRNZTtSO8svYxvu0I3lXqL?=
 =?us-ascii?Q?GF6y7MJoz+bFyMRVJWmLiJ17S8127ltjNw5bKyOi9qH///oUGYGObj9+1FZY?=
 =?us-ascii?Q?sNblcBdv8lPE/5SI3UciytcRiNmrgwhrLVOu5AvA1xRC8jVQxkzMyXFyWX05?=
 =?us-ascii?Q?U+O4R97xYiNnb9sO+VjDvvBS5VAa5kFCoifOWAm7cJxf7KW5eE6F5SPtd/Ak?=
 =?us-ascii?Q?Ws9C1P+wmLtu4rtaZl6gO0tDzmKT/y2nsXAfphen2mySo1vJ1Nz7YWmPzIgx?=
 =?us-ascii?Q?KRpgAk9R1WnSKqD/g2XO6KV2HzVToeYv4H2qy89XI+J4GtHpzSJr4YWOt2l3?=
 =?us-ascii?Q?iR29rCh2U7sWhnjefsryNQ6gxeD4DZVS8RGy37gyHwI8sBRsyaPoHaKz8cud?=
 =?us-ascii?Q?uiRSTbFE8A=3D=3D?=
X-Exchange-RoutingPolicyChecked: yYCJ7RNlEfKfCSpau9aGohLhwSSFY4MujPF8tTzVtd6VGMSijItboBn1AM2Eq/QIgM+S8e8mg5TICM91G8NuMZg+1Tl99WfgxyMFbvVVu0Dw7zEpQHmQiqE4v9wmuyTQJqher5WZvqA6sqj8FJRx/RFVpEfCAUXCtjGnj79j9hH82h1QfNRnWXLdh0MEJ55JHvTg1XaUYRtXsx4J7QjgPoTcTEjDt9eqwA+rVMy4qXyNDlM9TYV8GHTZeY4g7Nn/h6GilVKeCdUg64Lt249QjExT87URLgPP4oRu2DTslF3S/3wkW7VIZXJDEH5r4wZJ/VwAhpXvlfB1GJCfTRysXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a0fcd6-2036-4618-18cf-08df0280f023
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:14:51.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N834YhrqSXW0R1TjFyobm8M/OzFrdOmKzme7Tetk+TNXTzRww9OckJc2QjrcFIMqT6DIHY1XJWVvJR9x+eFnbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:16PM +0000, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Allocate memory for TDX boot parameters and define the utility functions
> necessary to fill this memory with the boot parameters.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
>  tools/testing/selftests/kvm/lib/x86/processor.c    |  2 +
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 51 ++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
> 

[ ... ]

> +
> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	u32 cr4;
> +
> +	cr4 = kvm_get_default_cr4(vm->mmu.pgtable_levels);
> +
> +	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
> +	cr4 |= X86_CR4_MCE;
> +
> +	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */

        This is now out of date (11.9.2 as of today)...
        I wonder if it's better to just say something like: "Per the TDX
        spec, ..."

> +	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
> +
> +	/* Set parameters! */
> +	params->cr0 = kvm_get_default_cr0();
> +	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
> +		    "PGD must be within 32-bit address space for 32-bit boot code");
> +	params->cr3 = vm->mmu.pgd;
> +	params->cr4 = cr4;
> +	params->idtr.base = vm->arch.idt;
> +	params->idtr.limit = kvm_get_default_idt_limit();
> +	params->gdtr.base = vm->arch.gdt;

        vm->arch.{idt,gdt} must also be 32-bit addressable here, just
        like vm->mmu.pgd.

> +	params->gdtr.limit = kvm_get_default_gdt_limit();
> +
> +	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
> +	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
> +	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
> +	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
> +	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");

        Making sure that cr0/cr4 are simply non-zero feels kind of odd
        to me. And cr3/gdtr/idtr all came from memory allocators with
        non-zero minimum addresses.

> +}
> +
>  static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>  {
>  	static struct kvm_tdx_capabilities *tdx_cap;
> 
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
> 
