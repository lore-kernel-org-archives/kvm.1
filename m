Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525F1EFFA1;
	Tue, 11 Aug 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410388; cv=fail; b=dPfD2orow+6PCTD6nLQ0vJcTXnkn87FuF8y6iV5kAFOgaYJoImNTU2Tbm24yESGMmSA/nTZ9A4z0lKxv1vSo/pz3bM4oueMc+HonAQKVYox7MKfXuOg2g3y50b6QzUEt4P0HnlRw5O2C7kCYepu0mffe2nD/KOIEGPv84uLoKw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410388; c=relaxed/simple;
	bh=HgDDKSWjJNHKFFeEpFmszHLGApdszZ1hhG/kzk0Pnpw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IiWbQJV8hGPhBNy2mgzc40QrWLH7x7RhmbrJVKbS/l2Mxn5X/f0lyhUm02jM0aXfPRxTZvK2ieUSX870EKRQ/tS81zwuii69CbWHPP7jCtYouxLsRngTzHkr8qHATQzIScdH4y/VLKdr6sowQ5s0LEKinJMRcHPW5l39H7bt2m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOzlxOeE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOzlxOeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786410386; x=1817946386;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=HgDDKSWjJNHKFFeEpFmszHLGApdszZ1hhG/kzk0Pnpw=;
  b=cOzlxOeESunSjAIai8M/CWYF9JxeWgLaRjMKdxXgx4A1mIxL8a9cWopF
   R4xzm7XaYSCqnJOt09HfAje/34J7skJuO7jF9rqObPm/1uFK/oG60nDt7
   1q/di5c6zLBOoC5hufyjxlV/87/khMc4Gf3wddcEFBltOHh7aeR+0o69A
   rh/tnfKCeKTBiEjedMa1Q66LfJgx7Ao3MCrfqCxGC1Q1UMEHd8RowTeCM
   VDdunBH2V0aQbC8dxlKfWHrb6VgYRyOb+YnfhIMJ5WuXOHQ4PsvbbYrdz
   Wbqf9mJ+iPN8/zjKjBcdk4PjTgznIvuyttaPDIAhOT2/AtJcjx09NsXJ+
   Q==;
X-CSE-ConnectionGUID: mVTkVl5OQh+3RaamkrjTIQ==
X-CSE-MsgGUID: LE3PUTGURKiGaL9guXyxvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98085395"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98085395"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:06:26 -0700
X-CSE-ConnectionGUID: 6scZskawTVWoGI61ZAEkoQ==
X-CSE-MsgGUID: pv8KE1WRSoe954YrbIp32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="263784517"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:06:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 18:06:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 18:06:24 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 18:06:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpAim8zoJ7rBG0C4TzChzF3BNEhMdFUv/nSRK6+4H2hMw+u/GndBV6C5c/RZfSs79V+zw3bbhCWGDamobiXIcuhts1mzGWDcwX76EfIdofsZw2KFO0Mu91tFsbS1BeJQfwiSlwpPobOY/aOCtpfQjYvJXLT3weXEKjItnwx0dzeXNf+xTI1O3OT3y3YAk+JgMi3/RIGeFFTCD9QLyX6GDhmXdgWxTSad9+70oGApbicdJo/9HbzEKDLnsMw89MTmI9khjINka3cWJnzYJuQktIWI7TURsUD8FiOEKXzdTIHOb3xp9tCnqAaSpZ/IbqfwjVgDCDc4j0bY2R9ibT7dnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvR7FqSrjpMCJyziXSB3lfxyHvnd1WT1mIY/1p+jRwA=;
 b=j/e90/n1w3LaBY8NE40ZjftEckmigZDhzF4OkUpGJAQRktIV2/7hB+EwqNcbSDPOPL+I4C4bRtqAw1DY8Nn8TwFWvK8B3ItnhsbdOS3s7rFrox2znmQf0GrSj0LU30auWwAFd9qU2MXvaolz3Trdblxe5lti0OSQDeofdRcZUyzbHd61wyRbsLj/eHY+a4Yrgt4poTbtrUWuNtuBWfbcIj3KCwTKTPi18a0wLnle3f9r8EGL/dYQljxe9M4g3FoFTV7oFFT0VMfKQc08NMksDnq94vsm9VLeF73tptcMP1YJzrsYgNMkWYxKxycS/tRbB89eYUM9GGDquWRDod7VsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 01:06:22 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 01:06:21 +0000
Date: Tue, 11 Aug 2026 08:25:32 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
Message-ID: <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-5-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806214050.78058-5-seanjc@google.com>
X-ClientProxiedBy: TPYP295CA0045.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::6)
 To DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 367649a9-c5c7-4592-89da-08def744c1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eca1WbBz4pP6Y5JCm4PeZZKwf5TLp8NU1KElRrU/e3w+xhJ8gt8wp40WiqbtmAlUOcrlvTxOTjajoDJLkaDN/BFJmtZT73RGCq+rypvVI+qHuPEPl5XBZSKmKFGlQipS+ij1VgCWc3M4Q9Qmxbz7E47VJCfXY464YA4Fa9BRbRhe3j6WF3HW+/Ce8i1zDExFwF3mQX6yABTKbcfkEN0e3iaZEYF/p+1/LKh8eRSD5OSCB2Ew6xp3GNHftxBNMifkyx4uHn9sEl9+RumCaBivolKCWfeibbFtYMyFWIYc1RuPqxufeyVl32YoL0HNHbWGDbsQPZc4kLKs3foNitiKJWNSZUyaUkhQ8JxR1069DNxxlF4ZxeuwPkf1TxKsgMWKA5kOKxMIOrW7PZPsNJ6F2JG6hV4ZQOPmuajSp+tF0JhBxi3QNzt/84vBF4KGWu3beinD21Cn6yK+5j5k3MOkyA7DTQPVex8j0z51xhALfM3KRTY/1jXkaKOp3FcdCYixH+rSsPTfsx+Pil7whKRL87j/P4+kGJWWr3I3aI8WDzVVp90unSMuqDf7uioaQ0ax3Q9JlMC//oKmUWRAJlEFxnQkz2FiFTsffZYJcS3hjIagPUHG7xttaAuA+LBqxgnnVWhrHyzaaSWr+KCLHrGkyDeM1IYV0ign2bKYaemGAvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f+/FE951PZ0PeMspc/du4PMP8u0/gbZZUuLr268MXU34KedyDHf0FHu9XMGQ?=
 =?us-ascii?Q?q6Hk/tSTuPHtjWynOfsh54sPEVr1r2HWaMRcID4lJpYiAaeV+9SmwQKJWkDm?=
 =?us-ascii?Q?B/VUmh9fAR5/FgXq5C8KSVD/KcRzdhk02vagE4iJf6jtEx/AqqyC7puUknOP?=
 =?us-ascii?Q?QdqD9vrd6GBI+l6BYzfdWQHZ8BWi7dwh4pabmN7nH7zkLHjh/dvU2iuLLhYO?=
 =?us-ascii?Q?H/XBuK9LTPhF/lTd2rAXLhoHgmv6g11a69baIz4i/aDyEqqXfyb4V+1G98Ne?=
 =?us-ascii?Q?vjAqU41nguJ7YVvgVnEPlbndc85lW0xKgzotaLuZxl9IDX7G6/gncaTnYL7x?=
 =?us-ascii?Q?twpTBalBZOWY6SVeWLYA96bAGZOvd1gW9wlA7S+8MpldxjHzx51KorC54Tu0?=
 =?us-ascii?Q?y12uBjWVTUjIJ76hFIDF2wDxaSBYCwV621K4sj4WaGZNAJX8v51XzExJzu0D?=
 =?us-ascii?Q?LC2P73GruDY45Y9CN4s7EwqtKll4XwwTR88M15EyXcQUJfFdW0kWpj/faIMt?=
 =?us-ascii?Q?q66jeBF5RflOgFzismw7lW6Y06sXJZKL+/pi0s4mFDjLsjDtIOY8tYqMmcde?=
 =?us-ascii?Q?IgdznFCqNLHuh7BWxN+kcfKAJ3M0BmnTJvQvN1N22w1pxwMQy2QGnWtmP4X0?=
 =?us-ascii?Q?ABV/9l/DNUyRAu7hH9D0gPt64HtPkd1hLWPFt2VHt+394+FBjKHZmJyKAGUw?=
 =?us-ascii?Q?McgGstQeaSmMv302nqvicAQyyhosAxEfVCJ0VpOtaDSV4jdxilHK5csnbZyK?=
 =?us-ascii?Q?MtmPWxlBsjTLEqzNCnV5AAIDLflxWGS4LgOO9Gr4X56vjpXzZPTIrK38sVQG?=
 =?us-ascii?Q?3JPqz2kXnUDtlDxvdGpafUP1T/FG1nyM8JpawxgFg+p8B1f5o81OJlUb3pTC?=
 =?us-ascii?Q?1pn/F2NF/guRBEipdNXV2U7pY096A3DpsfLf1p5ewMSxZJQZfTNYPmvcatzN?=
 =?us-ascii?Q?p1KSEpnPCb22VdNlmKOM75+qY3VjR0nuw2p9WODRCfDdThU0U5BM4Pp1+BaY?=
 =?us-ascii?Q?ETtGU+KEVslBBWDYBFVD+0A06Luykskey5uxTFk/5OKoHBY9dMtHa+6Cn6AI?=
 =?us-ascii?Q?Rejc0JMi1k0qO4OoL9DWOWNLDV5i47HbTKylqSXoIXtRrODH387+aqf7BItO?=
 =?us-ascii?Q?QcLeciD88BfCLuznVpM+EASZRKWyVkpshethCs5z8ccN9+Puia3acdTUxoK3?=
 =?us-ascii?Q?Ftg2KH9bWzyXdbEeLuVUpEe1qjf2xrNhLQIn1/dA+drpn1PTzJAAgzHMi+d/?=
 =?us-ascii?Q?e5sNbA4FNu6wKWuPtkIPptQBYau4aBQ4GnZ7LeLANO3Pc7QwxlBga9qJ6ptJ?=
 =?us-ascii?Q?D+U9eKDrAkRBCsu2E6uQOYoGchfeIpUAVkNCbD0WGcGEX1qwWYoGDR2RSfb3?=
 =?us-ascii?Q?C2g95Fi6a/lYOMEJg2+f0IXAARfglGaSMMry0RsASl9EUE4vor/m99tTUyUI?=
 =?us-ascii?Q?wpbnceBIL/IzRBgYn8YpsVFlKqKCV23dtxqHpgez0iqb7iVUDVzQNqv5vWI4?=
 =?us-ascii?Q?BcrGOJSEmn4w5iX8zoI/uMF1lTn4xVm80chYIOC0yXAUrePGGboKYcpxzDGG?=
 =?us-ascii?Q?Ubi/ewHg7F20MqhGmB5/EoS0nAMx0as2swkWZTYyW29EYPrEwUytwkQAsrTQ?=
 =?us-ascii?Q?fXeNKVlvTsXGWJEK9Ti7BJg1P1x4cFOZJN4a51o4+OyjjeEuVJfn4PaIRLgT?=
 =?us-ascii?Q?FaeSylIVvdbZKIc6LAfy6RR2NjfvhY9wcaJHsrOWFJUyc1cgjnyxBhHlDzm/?=
 =?us-ascii?Q?Xelq1asd3Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: glThSV+sjIId3uG7+lqwj7tYHz2WvyfZVVrKpPgo3aBfzDCGD5WMEJroHzCkj9G+1Zqm3fvjasTjLb5vB9FbJyGQjrb9UXcHpYsTrsOfWQiwOycMgFn4mX4ZWV42ZIyuE4MrZef/Z+WmJCN+ighU5mbzA7Pq3fb5CL0M+bf8k2dGesrjkci/kIwBUENatR1fP1PbiaUHWTi9h+SGDCMZ8OpU5XpUHRmGCPpVLVsU5EJIFVLPNak8rJrrlMbzBKTl+GYsoXdCpzLLqbimCn/if3/jrXI6/6rB3t9eij0M7aGZBxKU+brxlHKxY6+n1o/zx7nRpKfzb5c++yAkdtwBvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 367649a9-c5c7-4592-89da-08def744c1c9
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 01:06:21.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx74+ViBRb0eBpv/d42Wyvh4EzjtCL4yZOF6PdhRoE1O4S8JocmIGQwUWP3WYi2oVavtCK4Gi49WROFdosEj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 02:40:50PM -0700, Sean Christopherson wrote:
> Harden the "map private PFN" flow against potentially-fatal bugs or future
> KVM changes by checking for a stale "fault" prior to actually mapping the
> PFN into the guest.  While it should be impossible for the "page fault" to
> become stale, the sanity check is cheap, whereas a broken assumption would
> have a high probability of leading to a guest-expoitable use-after-free.
> 
> Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
> positives, even though doing so completely voids anys and all protection
> against unexpected invalidations.  Pretty much the entire point of
> kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
> gifted by the caller, i.e. the caller would have to mess up its one and
> only responsibility.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 379f570ef04f..76e3cd717324 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  		 */
>  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
>  
> +		/*
> +		 * Snapshot the invalidation sequence counter after acquiring
> +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> +		 * i.e. any concurrent invalidations are guaranteed to be
> +		 * irrelevant.
> +		 */
> +		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
Could you explain more about the conditions under which a fault is stale while
guest_memfd guarantees the validity of the pfn?

Given that kvm_tdp_mmu_map_private_pfn() already asserts holding slots_lock and
invalidate_lock, I can't think of one. If we add the sanity check because it's
cheap, why don't we save fault.mmu_seq before getting the pfn to guard against
stale pfn as well?

> +		if (is_page_fault_stale(vcpu, &fault))
> +			continue;
> +
>  		r = kvm_tdp_mmu_map(vcpu, &fault);
>  	} while (r == RET_PF_RETRY);
>
