Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0F2D8DB5;
	Thu, 20 Aug 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215626; cv=fail; b=PUrGpsI1j50dKvri7FnSZlVIWbmTD8nfdRegi6EFEAEIMj6IAS17Pafk0EavGHu0CnBi2a6c7vHyBSL3MaoBhVvixv3MLaKsdmcpS6qiDDxBC5RF3HJrPA5I7cvdE2SPafnwaM6RwriVrfmApdYBx6SmKfme9NVwWZq1WbRXcTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215626; c=relaxed/simple;
	bh=6XeHcIgr+akGmtZUo+NinJerdDkiwm+FodB+yriM9A0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iJYDpmxh74a/GTLz6nzaNTnj9PVn392K9szES9H5v1Mk6AXQNOLrv/KGf7wikb6PKLrW9ucWwOtWkSgf8FlvVUBwVXmxiCpLTLoGHamg3mLXvrOjWyLfmABPue+Vac7U2l3ecH9YAPtmwC7lQh/knNNHkb0RlCT0C5xYHjTXlhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2WHkb0I; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2WHkb0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787215625; x=1818751625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6XeHcIgr+akGmtZUo+NinJerdDkiwm+FodB+yriM9A0=;
  b=c2WHkb0I9SiVD3mcjFYw8NerghZIuln1nST1q/+haUoKFpHyfBSlwboW
   KlruRnvKdiqilwP4wQRAoAhJzU/KO758tXL/cqU6sp8bkIM0BuXme5VLw
   f3CsKw2O3CEvk+2b/A6aihbrVkaDUT8nX3/3ASwRyp9mXFRIQNERz+sdz
   eR4KhHbDFdqSEnAu+g79h2WWjTCweR8OasdcTjYhi3H2QnfUcNkTBG7TH
   MwJv8GwvRiLgrxlS/4XTaifFcWyvqMhnubQrN4gRNgf4qmj8cUSjDEFPq
   uryo3LlPnnQgj6kbSKnJPKPUkpd/r0ecbbXAym4iN5S9OvAKig1/Aksor
   Q==;
X-CSE-ConnectionGUID: GOzwFYTTRkOpc77yl/XN1g==
X-CSE-MsgGUID: 4HDtbPDeQXCtv06kUXOM5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="75275232"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="75275232"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 01:47:04 -0700
X-CSE-ConnectionGUID: 5Y83kY3pQ3KD8rZIMnDdhQ==
X-CSE-MsgGUID: WKFOs7VFTKqLGTXSjnHG2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="267871898"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 01:47:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 01:47:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 01:47:03 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 01:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc3lxE/qOXb/VAsWSYBkaNoDrpvhdoQtyfGPHuCmVjRuEn/b05RbzRiXWqO05GiDh5RdTYCSue2nfAuK1hlqnO3U2GaprfitkkImVMyXB5vjYf5KP/dDmx7slN0GUZXUjjEtTBJUwF6J2d72DlpO6NdJicxZ2UVlw+52NrKnZdnz1L2iiaHZ18pseVp33uLplgzUSZWF9tcfLzS1OamJLLvHVKNYGIlEiYzjAeTU/AzghT4R/TwmGJI3dtM1o/S04RE9iMzj+Zdd2GN1aGv3GO3tqkISOq8TfNoDxm2tNXPmS0i3TR/mf4y0G2iL9w9ekteLmkC8lJkz8sVxMb8AiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL33hk5BtrZuq+4i3d8/4HmS2gX5NKcrpYd5UrGQfhQ=;
 b=vbweAY2pZELYHQ9n+bpfDeq4E3Sy4wGIi5/PPWORe3Fu9YM9QTM7IoLxvqqDAfz7dCK3MpdksNZNKB9le74A0xE5Y6r4uSFvcAQzVWv3pPFEMmT2wh8Jmbd2SYOLLL35PKWXkPohboU5TVj3llkyIFC8UICMMxxjz0yo+IBspZzGzVoIxhwEhqB68zwOeeMZtbs3EL3LHB3poWSKqlo0c0MSLB2nNDrLin49mUyi/vZ+uvdBD6klxEGx/4c2NrWSGz3N4Vofs9NGvR6XiRsNLb5kxZNsmE6Ge2D8MNTICycP96lQ5RsxWdeGyZm4GyF30QhR6JLY9U4fIrjzA50oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DSVPR11MB9915.namprd11.prod.outlook.com (2603:10b6:8:45d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:46:51 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:46:51 +0000
Date: Thu, 20 Aug 2026 01:46:48 -0700
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
Subject: Re: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
Message-ID: <20260820084648.GB3290799@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DSVPR11MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 58454d8b-8c94-472d-1013-08defe979355
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|56012099006|3023799007|6133799003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: uLVxSTbzQ/uzf3VYuCMQd813o9N7fzbqYHcrmbbA1C8b8KO1yWusqM08+mtL8X4Hf6WXYqv3bFOSzg1NXo00m39k5oZ1lDYZia7KAS5l36eE97Go2I5macx9i7Eqa0go8brewfv4Zb06bC8+SlVp2f7CWkcEH4cumV7Cm/Bj5Feya78U0gKkN3g1Rtniz+quq/cN9i08F7Rc/4fLvpkeaPMiJEm33XuOm3VMwQJKo5y5MQQSlS2HYosLs7hmn6aJb5xowm+QWETfw6adRjenQgmUoXGi9NlEW/kSWNMIte3BnaAdP5JxcxZmLHuqpvN5UT+1nwDfJuQcNrkzAGMpn+Js3KjdfUaeCHGaUeQV/q2qx5IWxPSwtWWD3qBpkouedNpJqIEqPkl1U9jpoTj4o2tW9zAezAwVvEBTfWjsjFn7frio5QqMtdYargQbuoB2Ec1JSXsXtYGUu0REcR/9AYknw/v7lO22tqfyblDQ1L7jnMhOt6X97mHXiHBb9C5EgbCaGsCKSw8TXeaOzJ2NHUd0wrNaz92wMrhMYFmrTgZOJjFPwP1EefdzcKpu0VyfuR+Yc6JxnBHWlYJB86hzXGmcSTs7h/zRbtuatMSu4fWC4XyBxGI5LeYuMO3vlqOnwtK2cIZQfYnBBV/OWu85ZUfegvy44sxlQ7l0v4Shty4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lXNw7hkbIZieo42/fNIUUuV+YLfFTCPTizSiroRYOQ1UBCWKyI1Zjao/j8iF?=
 =?us-ascii?Q?2mZLPzg62wo0X9nGMmWx8NsB8uIeFmoMXQNIduyJJwX54MHaSzrPrjB+WkNM?=
 =?us-ascii?Q?8PkCNubmuWoYRRfKPZnkChwciiAkDZyF/ExB6GLirM9VJNiinQFJiQvKyI0x?=
 =?us-ascii?Q?q6NlhfsaAddBezvBc1S4uGEmVFvJzoqYfCuAXRjFW+qaOFR2t+6blVXUfSM4?=
 =?us-ascii?Q?MBoz7E5Ek2pC6uUoysjgtIiUS/gy3sBBQVnOC4J5V22xoUhK6v0nxKVdFuPz?=
 =?us-ascii?Q?28G/5eHriHPpTaE8boqq/8pCEBuIBC8HwMoXEupfmodxyfAp4wv0JMav2fAQ?=
 =?us-ascii?Q?nMFKUeOlypEbbtW4UMmLHhxVn9WC76lM3ha5dhOZGj9Vq65THerKDa9U5XdO?=
 =?us-ascii?Q?59S0A5iKwppPHsWTSTlEgj0itHDjJHP9KoDJygFKEC3yowSojOA+GdH2Cowe?=
 =?us-ascii?Q?HkfJCNL3fX1njw9u866g7JOFxl4hecptJIn8myj3qbnG9KR41Lkr/fSUqitw?=
 =?us-ascii?Q?XPxvgZOjyYPEoLUqAdrpXV0BT9gDrH8Rsp/BfGlRqEhm0lkLrTobq3CHJFij?=
 =?us-ascii?Q?Q6S/dHqZFfgkKwET0uDijuEGmxinzQPu6+0X37qpkAlKZcsKf2vpur50bqJ7?=
 =?us-ascii?Q?a7i39F6A7hUi8G2uAL0IseKPqFOMrweT8aTqVpbVB6XaREi+5hy9zB6Genvd?=
 =?us-ascii?Q?balTevt2t63JEndylN9qxwbWZekV5lJSHpegvK/JkCONI/mdrqDyg4TUi32X?=
 =?us-ascii?Q?j6BYDStpFPPvuytfbE5Jo7B1lsSbHHCeANoYlwQwbozMdTRAUAyr8BpVfe3/?=
 =?us-ascii?Q?hDIfvQXpP7KaaYQjG08lIOUdVUHVTDtjY/ZUDefP8xJLYY/Mp7wvs1PgVLD6?=
 =?us-ascii?Q?E7BrZAJfQtQU7sei7cPJ2xgiaQYb1+qTrWzOy24T/6hJZA14Df/k3gw0g/+p?=
 =?us-ascii?Q?HIPfUab8VNlMMdc4qfoJkpn57FM4tKwtmIxPyz4ETIBONmlHCQxvry3cvjR+?=
 =?us-ascii?Q?+f9ULURy1Fq5egt0ay31dpPUFxIex0s5pVtlUMcLF3gxQzUstzJW4I7SodRB?=
 =?us-ascii?Q?ATgihzavkesym77LzsK7teiTcLvJ/2GnCFm14GyUXUbkmtF9RQL8E1y4ODtG?=
 =?us-ascii?Q?a0AnOm3/tM1c/qpRaUlCEyjqsOFKyUjElo7gicjSHbm/li/Z19JZev6qMgyF?=
 =?us-ascii?Q?vBO9H6zN999CXa8WsuyH4/5oH0EbKQyD7Cq3RMeprR3o7STY3fAAvse04uyc?=
 =?us-ascii?Q?bqJS5BdtBdpAn1elAJm+KFi4CbUYo+maGyLnRogLhYpnCXxSeJZQoGM0z2I1?=
 =?us-ascii?Q?yEEseDHAHGABkzvFt63N68OPalvVIff6dNQcAXaO0m86HA7sXaxQg4BASTCi?=
 =?us-ascii?Q?sQqRSwVTarqz5AIgkvstnNd6x6YMa6XOLjGz8r78w7w1gVVX5YtY32ocd3Dy?=
 =?us-ascii?Q?uh1MXAFgzldfBaRHziopJvNbaDNTDR9rrTFythkcXAJXICrKFuErPk/vtB0F?=
 =?us-ascii?Q?2tXiNdEyKV0XXIoq5HpTmaByX9koQ2iw3I1X0Y7KWBvze6xKTppM8tn3VW8E?=
 =?us-ascii?Q?a2Tcr+pu1zaDA08/kPf3J6kXIHgJ2OLDDvZkpHeOEuOi3TZL+P1QN2Y77zbx?=
 =?us-ascii?Q?IK15M755kDSUb7TzBd9J1kOn5Yv8yN/v7zSJUaPgHDoSVVhlpcey+3SSQW9d?=
 =?us-ascii?Q?IARU3EflC16r+ZZZOOhypUwbEbxUNgG8NbDBLXACL8QsAw9unFBr0pEuh2nv?=
 =?us-ascii?Q?FXHaSAcPSg=3D=3D?=
X-Exchange-RoutingPolicyChecked: nKyBfCcLWjTuLZpupOw0KRtY8qQ2xwSyij8j5pyA9Wsk8AclM4f+DWNVlAcsklhcxlIbW8EjYXuxPnLtvYtFZ+ux3CmcMEE9mjeB5ira8S2MfxswQqLy1CKxAwP2AYLT9fFru5y49327YJD4jXFjA28lQBkbcfRbYd5ed2jBTWCbRSsw6KD8yX9kpQGFqpmtEEW7bO9ay7jQFaaVc1y5R3yluofCqUyEe1uxS8OmvsMBD56WaELK0Q8YUAZTxTAT2o7/g4UHJr0J2NdSvtp2vXSq+O2+af0nHLCs4uXGhsvgk3S7tu7ZqgTyzUsKXazVH+wXT8OkRtJBenIuqS9f5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58454d8b-8c94-472d-1013-08defe979355
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 08:46:50.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qli/K9FdJrAraF9NZmch9W31A/HTqFI68vBMwm7xajSbGKdjLeQeTkXYi3GzUOrLpZrTUyFnlU04Kf+IPxjmSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9915
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:08PM +0000, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add tdx_init_vm() to handle the mandatory VM-level initialization
> sequence required for Intel TDX.
> 
> For TDX, the guest's CPUID configuration must be "sealed" during
> KVM_TDX_INIT_VM before any vCPUs are created. This is necessary because
> the TDX hardware directly virtualizes CPUID and includes the
> configuration in the guest's initial security measurement.
> 
> The helper calculates the required CPUID values by filtering the host-
> supported bits (kvm_get_supported_cpuid) against the "directly
> configurable" bits reported by KVM_TDX_CAPABILITIES, ensuring
> compliance with the strict requirements of the TDH.MNG.INIT SEAMCALL.
> 

[ ... ]

> +
> +/*
> + * Filter CPUID based on TDX supported capabilities
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   cpuid_data - CPUID fields to filter
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * For each CPUID leaf, filter out unsupported bits based on the capabilities
> + * reported by the TDX module
> + */
> +static void tdx_filter_cpuid(struct kvm_vm *vm,
> +			     struct kvm_cpuid2 *cpuid_data)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +	const struct kvm_cpuid_entry2 *config;

Nit: reverse fir tree order i.e. declaring "config" first?

> +	struct kvm_cpuid_entry2 *e;
> +	int i;
> +
