Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36861395AD8;
	Wed, 19 Aug 2026 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125489; cv=fail; b=Zyshh7eV/DmZpeRUiSEogmKfc7lfy3x3vG+ra2zEBF+oqdYQ4bJqK7051jyyUQPmf7+5XEIRWM3AG7hdk0Rm3CE1feumOAJmIUn2hH5gEF6RkWvR0UZMs40Ai9sJHISTUX51T2UjrmXcHO1u9JNSPMcMl6P3FLY3QiPw4EGTQPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125489; c=relaxed/simple;
	bh=Qnjw0X4iC0Az0GIpuSw9FMMB2DhQdFujzoK2ogA75+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cYogMxnG8P4KsxZ+kZ1tj12jrc7zprtYx+XgPhj4bLwiQXuvJA/MT5K5GWapC5I5TimAzPnftVHiI5ewiahlO51Ox4VtvdR+jL9P9FGB5gdd5MdnDiayXZlp1yXy0kZYkKIbUS+Pk6ee1BXZpg07prk/K7wmQEV/PaAAvI+9na0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzJM8L1u; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzJM8L1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787125486; x=1818661486;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qnjw0X4iC0Az0GIpuSw9FMMB2DhQdFujzoK2ogA75+w=;
  b=JzJM8L1updFDhAx6OjUVPFdEFmlJ8HtbXOcrTZjIP/YJSWmQDomTAm5f
   Tj6+C1CoopBWJvaOqLK8IHVzmC1dJcaVeYekziV2DemYDjxcvygYkqdjx
   MT9WdC4T4Q4fVAw91VkHDBnf77anLgITLEMJ4HH9mNLpMrfv/7iI3ShD6
   hOxiLLvhxaKYDu/cVnBLkpBRhWO93PaQB3uHhlPVVyaZjklOOjsbFZ3Ky
   FA95A7b8bMY3iNdlHOR8+yizrbn10a30BLN8TDcoBvpLmkGhXQZcpq/HF
   CsSc6Uf2/wHZwoT29hupuiRHmSSL5GA+Bd2RRd3sp6/l9J1/+F/nY0PLN
   A==;
X-CSE-ConnectionGUID: msrm1X0nQcSGYrIC6/RGtQ==
X-CSE-MsgGUID: u7Xc1NDATFeipyIaCMImuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105011837"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105011837"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:44:43 -0700
X-CSE-ConnectionGUID: euOAV78GTIGqOPZXEgBo2g==
X-CSE-MsgGUID: GuQ/sr+uQOeDt7NZ9H65jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="259277775"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:44:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 00:44:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 00:44:42 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 00:44:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxtrxO6g4dIgC+vTIwR6CagAe0QgWQ7WfrefW6CWkcpEu7ANRgEdMr+b+J/4WfTkoxwMEQHqkXZr5/T9DFTzTKHpt9P5Y7CFQ65cJ7Pbo/6Lt0wuGzGW5H3OSeysn3XvN4MneaoNl+IrKnEHkS8UzSo3O8jXoUrY47zKHKQctf1upss5vL03nvd6LmwSxPsrmX6UTbbmAUGRCSVZ8PxXpQwmiYFqclw0nwlNNX0xBbZvMCW2Vw4QlByQSc4bIvKekEv6ZGu5ZdkwKvnQnYlJqa1mDqtMsArKiYHmrHxLKbqog4EC4k1aoVdqchCWyfR11B1qamOkQri3ZyXtOS9yKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmA84hhwMS/hzw5iXtS9yYlbmf3Arx/bUh8LfrJgcOE=;
 b=V5fAirit/o9eFMRV+T/p0RYQwSS9D4ezgDHH7+K+po8w0yfJqo1jqvYjIoHzIGQYQRrJD/eipv/Mjq6CfGqcsLD4tKHGV3odtq/4bHnJhnDtyQW58inZxEIiJvyT4P1kJxEvjFI8CmgoevR2ZP+9nTBU8pFvnGUHh98UGBYCNJOsX8xTujoLWCq71kWHtG9WbGU4QkHzG5ZmM6a/3aB4RxK+Hn9IxRUIBO7VUz4aRxqdpIfVKJHwSn+R/Hc9SOAzcdC04sz/ex7CCWZoYf6CjrVrWtJnOhDIs1x18s0noTXWNLtAIoJMR2GOGbprUBb4eLBDZfEJCXioyxNWruqbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH3PPF957B3B2A8.namprd11.prod.outlook.com (2603:10b6:518:1::d39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 07:44:38 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 07:44:38 +0000
Date: Wed, 19 Aug 2026 00:44:33 -0700
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
Subject: Re: [PATCH v14 01/22] KVM: selftests: Add macros to simplify
 creating VM shapes for non-default types
Message-ID: <20260819074433.GA3290799@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-1-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-1-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH3PPF957B3B2A8:EE_
X-MS-Office365-Filtering-Correlation-Id: 493987dc-1514-4a46-b709-08defdc5b87a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /YW+Y1kFOcNewDwt2uWyo9VW47sLcthenLfK1Iu9Uz/is1s+jJUwTiDkCzif2NW75KqUFppOyawEKPLZKm8Ggk+W6+Z6VPDEZUn45ZOAAjsIFf49AkZZ3r+Q4eA8+4TIpkVpP+Xfn+x70ABmFp1hH4pcCgG1gqxKoPZGC4SacGtlol4LalVl6RpPZsgJKWrrNXTTYd3GArA1byoL/tLqj5E3peLAlf+iAZrcnDK9dMqWGasOHtKNcnKXlYKWyAnvcwbEwUyoNvCug422KxFHtr3HInkS1QvOdlNfS2Q1j4T4ZP2Eg0R49VEANbtQtFp5mWtu52/bjScaInE7Vx7tke1kudrbVz6y3zW9n2Jx9gM7iygqpdoj8Wl5xRxHKnNxDnEF6EL2uHRmdsqckeGgmLbSCv9zQuz7DYW4v8WtI6ZGRZziNB7hEcYd/JVqfnukrWWCwflg1YOxBot6rDeCwb51ROUEKsJ/9NDtO+gbG7Elt/H5sMgfbOFtyYmqHm/KOLti9Cvwhl6z4D5ZEmt+8iriobcNqyH1eBR+k+8ev/9F04b/dsG/GJWxKQKHiz9QS9iNjeFdEkVdfmZ3b2ovY2yDU/aUAgxwUxCcJYiiPsG9KNupthJiiu2jqgnKCOXhgBdg/2epETbjOwoRjPBNLSJd8HLU+DONCqVsIv36g0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+t/j//iTAQF1X/kliuJgJVYKcMLehISYxaQFGrb0GJlBUM1o2jEYzNCw+1j?=
 =?us-ascii?Q?634DoYgN2VTk//eIC1+k+aQ4Z/rD9yVrzykM+A7n5D9qDGp71NhYDg4zL0hZ?=
 =?us-ascii?Q?Wyr2qbGGqM27LYi4h6MLWpeb2NfmihUnE13aKlK3CYXimb4kkR762acKOBEG?=
 =?us-ascii?Q?2AzgR1EvTERIuOlD0nqzSFnnVc4uA8E9+DAnJ5ttVRU9OIPDyCiyboTcOi0M?=
 =?us-ascii?Q?zxZVf5ggk8HFKj7/f92aoLAkBDfu2+BNJx8k6WKaP2DTO/jLuySVArEJXy+D?=
 =?us-ascii?Q?KOYUATBQEivTHLFdjdk6RnYc7M2/FIzEYaWjFlrNGDP5NEo8ujF1J3zohcU5?=
 =?us-ascii?Q?sgK8osMat/JooL4X5bIII7SWw6s5ppubtcZs4S/cEKG5iJlT6Uvd5gr75IsL?=
 =?us-ascii?Q?x8Uy/Po9UMQU2TVqhHQxq/WlRTsmFHY9DpaMx45gqnyusF/gIwIujYp+t348?=
 =?us-ascii?Q?gdEUDN4lv0nbjf1JsOd64l14/TPEWkSUPNvCbs5xf7XemNuOiDibBn2zX5vj?=
 =?us-ascii?Q?+bU50eqSacfNA5ULC3A6VXfXVvvNr7b/Q1Z9BEOyEUJoxMDUuAZ2tPxFGNjR?=
 =?us-ascii?Q?DanzGrEJdiGq94inMvha8w3JgKMcsCjc6PXRD2tRndvlhlddn7gRC6f6ymhI?=
 =?us-ascii?Q?FL9JymfaoR7ZA+fZz2SKTTFu9n3PfaHJ2Wjw14fTVVIO8WFQT28Q8BW0pjT9?=
 =?us-ascii?Q?cslYxiVFXqgCACCJRsPbouRifwM2zXtl7SsVN5X0xpTpJHAMIX08W3KANydf?=
 =?us-ascii?Q?8VCcqmo3kEbKrT5O5r+XVtsIPW0Yw2aPEYzde8USGf8hMURgJ6EPmDVbsqX3?=
 =?us-ascii?Q?x/O44SQ5R3JInF/LwzGAWYhGxu4NjGsfIkkmt/zHSDHW1x4UN5AjvcScs08h?=
 =?us-ascii?Q?tZ+QP9s7oEaSwVLCZ+WDz4ykRk/HcupE+yDT949kBqFeC2HZBfUfaEQVkm5S?=
 =?us-ascii?Q?cv5fxIqEt6/M4wVhd4TSeaCR2dwB3+soNvFAE1LUCVy6HPkahSQi75ViaeI7?=
 =?us-ascii?Q?ro/w/yCyQJX7a4TTQ/fex1WVS8BgXp0qWLUbT7Avu5ggdFThGSyCOAspygUx?=
 =?us-ascii?Q?kzJ3V9BkHwGP9qkaAi/naA0TAUjzr4sQiuqjyKaAS8Y7+aq1xp+YLLWTAigw?=
 =?us-ascii?Q?MdpJp7LAjNur1tTaEVQ2zLmO2a17P1OHS6ffJtCoHAoFN8J+zJBimcMuT2BF?=
 =?us-ascii?Q?6cP5Xk7/L3++EuihhYRk9zkhslRFR5HBcvDvuvBllkEuUXVI8r84KH/EfpB1?=
 =?us-ascii?Q?Yp4AfhS8TLQ7fKoyhNfbilJIh/auvZ0+/ULe9y/2IYMZ3ywZzNFhPheaFrig?=
 =?us-ascii?Q?s1YL4CXxxW14H+kJhidnYAFRWVNXzwHhJk3/OoxQWyGs0HLzbCTvMZg8gbJp?=
 =?us-ascii?Q?HcdMvEhye/hPb3J7lTgIe+CLdIowiFdiAF72hepIMHxdwpqUwNdFdee4xl8Z?=
 =?us-ascii?Q?roI7/WD7M5De0v6LFBGcwgDi1EXHV2gdp+QByj3Fv4F6gKa3X+B3kBge3FrY?=
 =?us-ascii?Q?jPMRjSmu5a+KCJmltzZmg1F2ljrEwfczy7oLIHM1x8yvgDK/0q02v9q16jQX?=
 =?us-ascii?Q?wJnS2Q77QIt5nSCvZmzK4AgjMSkWqGCaJssOnUwBv+4I7f43R9IJjoL0qJ5T?=
 =?us-ascii?Q?K752kbNADaX/xg+ClNQu1wqxINblWl4XfXtNu+DG3oJb228DpFf7CqsCMMbz?=
 =?us-ascii?Q?3BoaSzlLkO/MqpFadsMdE+Y1Zwr3LNPVPu7JyNvvv66HurrhlIDze1G9+gzY?=
 =?us-ascii?Q?Dpdg3KpzYg=3D=3D?=
X-Exchange-RoutingPolicyChecked: VJcRC1BApz9OpPt3vTyZye4Iucvc2MqIeJYiyqSisvCkW1rYKeqZ5n1O5acFPB7zSNWX/YJCXqcq1ORlPdX/RYZeydctMglNRRtuPLeFVQT9l7UkHjKZMoyH4eKL/AUuVtiGyokimb2W2BqZnmWAphA3OrvB/hPcHoeTHA4NBoTisMCPR/nRCrzDKvQaYqHAVYxjX6baIwRhmXO1IEeVsZlgX7cAEVStmJdshl8ttmHqVMDnAjkZnZqk1/02i6Kq1D6KHObMa7R6NldHJlH8RNXmHczF2aRD6sN9Ftz9V5IIqlkjo4QR7UnfCEsZoawkR07Ehar3YjmsXKWiZhr/ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 493987dc-1514-4a46-b709-08defdc5b87a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 07:44:38.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvmc+46ylHURmKonbkd+UC3OVUglKdKFfL5W7VFNGqTXJOt8PDLFZKBTTaDt9BKwusFsu37Oqu/MdKejD9jaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF957B3B2A8
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:06PM +0000, Lisa Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Add VM_TYPE() and __VM_SHAPE() macros to create a vm_shape structure given
> a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
> shapes for x86's SEV family of VM shapes.  Providing common infrastructure
> will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.
> 
> Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().
> 
> Opportunistically move the existing VM_SHAPE() (now __VM_SHAPE()) macro
> below the definitions of VM_MODE_DEFAULT so that all of the SHAPE/TYPE
> macros are bundled together.
> 
> No functional change intended.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Missing the submitter's SOB?

> ---
>  tools/testing/selftests/kvm/include/kvm_util.h     | 27 ++++++++-------
>  .../testing/selftests/kvm/include/x86/processor.h  |  4 +++
>  tools/testing/selftests/kvm/include/x86/sev.h      |  2 --
>  tools/testing/selftests/kvm/lib/x86/sev.c          | 16 ---------
>  tools/testing/selftests/kvm/x86/sev_smoke_test.c   | 40 +++++++++++-----------
>  5 files changed, 39 insertions(+), 50 deletions(-)
> 
