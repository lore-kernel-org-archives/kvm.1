Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07303FF882;
	Tue, 11 Aug 2026 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434158; cv=fail; b=bLeLmoe3kdLMYflmhtbUpEan0ayezfulc4OFQQ7aICE44sF2Cqjjk3+KFm/T+zMcWlJNUDBJNbKNHZDtLhG4Qc5RSYc2TxnGORcyRli5NkqDfr3AFz9bKu+Yv343O4A1qADoOZGbrP+19iK/qWFpUl69LmqTX3ptVqkH4wCaRi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434158; c=relaxed/simple;
	bh=32rhGJ86j4Ls4XZUm/iVctL7wFqFk8SDs9Z1ZDWccPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tdZ9KHqoppZu8FtXM5oC4/YjfntshuWVoAJGt95admcpyA521z7edf8tizycOldC9dqrJ+9P5CoPRBGXSI37al1jOewEymyBTlX7acgdQou4o0c3FOy9jI7fjEIvQ02s4vh+sKbDLYB1F8r97FwkZ7jroTO5iklCO69bQfh2uSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7kD4ByP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7kD4ByP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786434157; x=1817970157;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=32rhGJ86j4Ls4XZUm/iVctL7wFqFk8SDs9Z1ZDWccPM=;
  b=X7kD4ByPD8y5Vkpcg+Q7iQhkns2AIu4NI8QVg8vBJy/Vi/ibuJLSlL8L
   /gQ3WAfeF62ILaEc3Vj79OADcHXwvhV/Dv70I6p3BVN+L8CGluvmD/iEM
   PA0D4wLgSGw478Dy9lSj7XKYN7ddLviGSP+f6zAtSsYLkO1y1QUnajkQW
   CVMoLVfLrqseCH4o8ePn6M0aqI1zPY8pzDJkwK9YUoENUtE9ZBT3xPSoE
   xcsMzmLjQfm3A7To7cmeWs8cCFhfJGHbzkwHbzUbbgiNxSR1XWWBUdjF6
   SrtNcTfeauq2iIcKFaX53HgiKhqvGmFUQJLaVXY5/4PAx8eDU14PoiGST
   Q==;
X-CSE-ConnectionGUID: CMAHo+nMQvmAVzP4i75tjQ==
X-CSE-MsgGUID: 4H0IZOQrRuikTrPKpV7v8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86813065"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86813065"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:42:36 -0700
X-CSE-ConnectionGUID: 17B8ekmuRbOb2auP0KkQsQ==
X-CSE-MsgGUID: 5sHRRukoRWOnvRKNZLQR0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="268422421"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:42:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 00:42:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 00:42:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 00:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWK6vtyIMeDEy+WeA6Ff/PHCNgQAwYj4xFqJexnPtLfxjwKOxIKfuIj82xKbeG14l5WMZuhRDGaiV36MpwUpYIr4tNH2O3kvFQAaVXuXbFFvQnzvbCEMlOexU+4HnXPjV02sEGwG/KaImc93mDOQyj8cEgU7PSP83k/lapbGgN/yI9R8AtSFDc4IW6fXbLekKyM6fAn7+jPV9mqAa5xJ/kVuAaq4ny5PWtd15RI+MJ5umeNlsy43gHSf9rNk8uP17jgHG7oQIh3CJsAJ6Vm1SUkJTuBVQxU42wuVDEelfRsOHFEp0WusZUJcqst1Dh1DiKC0+n7db2Pj9lSNo1DuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oh2RiQTLDJrh27NjWnwgAlkYHSm9VvxQtesgplXMtp0=;
 b=pfxBtEBwidly2UI4NB/JNcERtkYIQUAxENqZ6SFuZJnfwnV6nXTUijoerk/h6LXurB2Wb4LtgYzCjmyrQO60wdGKgY3N8YP8SqT3dAWZHbFpLtK0ZLkyjptBMp8A5gG5y4tZGurJ2jy08b2RI3ROLsBR6c2nX/xcIL1/9Kc84+QgB2LmIeLVB+3Wx04Jb+IyUhsfIm85TKRYkqqYMiqu6Dvdy2i9jjo0b38wvD0qyL4OgiNF9cNQd7tDUNhi0nSGxR+7RdPi3aesFjVq0SJb6gRB2jOk/NTGOPHHWQBHa6gnZEh7jKqAbjad2Vvw913D8CabfkcN6rfiOGUhvh2XAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by SJ5PPF162366726.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::813) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:42:26 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:42:26 +0000
Date: Tue, 11 Aug 2026 15:01:37 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Message-ID: <anrI0WZ3rA0q6X+Z@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-3-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806214050.78058-3-seanjc@google.com>
X-ClientProxiedBy: TPYP295CA0013.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::7)
 To DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|SJ5PPF162366726:EE_
X-MS-Office365-Filtering-Correlation-Id: 807f2e38-17b6-4648-e3ae-08def77c1694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1oASPWVNGQ8KqbTh8No7gfyHhnyEKYWsDzPCRSL+q0Epb3ypGri3/I3GsbUZ7XNgPN74X9HxfxQrVyEX53B6ty61eZXGK7ccDhSeLKwlUoD3xTTbVl7vRI5Zxe0ckyi6AGksJ2DDL9+bwYdwtl6ei2j4tSI2DZHZ+1cJ0Hilk0ohxbrxwND3cxWm+OCgEUPj3mjT22kKXW3NoCilviHVNb+2biY+xraZspQPmGsfzoGMpM7YxuHveQ8VZ/VB39/Y1VOasg3sMTVDVRRK+UPLD61SWFEFiRZHzcBapGqoE6xYwxiZDPbJCiQbE5waxl9RMImUzpyItXxZFx9cFRuDaf5xWtNd1cSeQUW9lDUuSO+q/DD5F0x039JEHymroprHXLn4/pYK2mLCdVUL2VjgcuxvGdhkkfe6mw9p4qgeelYNA0ttzHK+kIypoAi5fXqQDosrQJcWhTJtELC/GrlACaLcmlsxLzuucXi3w2pWjmJQHiO6NYipS28oYbtx7/RhMuXG4Rqr692vw0BUcrvkxgN/K+1rHi5pS/VltF3TUg0mChXKX3XnZmW/7moV6ooBj6gesz21qCSdPrlM9Fg1reLWQR+UXrhwVq5JCeUXP+mYxRkXgq7OT7QJvuU05GTJqOTbJ8YywfXQKKjNRgAEmhQtXP71Py/qrHQ2kso90gc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kIbEuYvdNrfSmDp0yAxVsONMcHQUBh6Bo9z7q2rMVSDQ0a83bq1WRuIkHUpg?=
 =?us-ascii?Q?wxIKPB6yjbDRM2MvfXIDvLFgFxmg7CTzai7XzCc6jbYHYCjrlQR4FS10vnkF?=
 =?us-ascii?Q?nPqqcbUs4kS8EaX9sEGUitrGFOaQNy9d3TlQaFKdCZJ71ah+rvjbPxHp4ajp?=
 =?us-ascii?Q?leL7R+Q1s228HW0Mv2dWBtFB1pie2biUbdatANOPj/Rx6hP8sns2aHNXMz2Z?=
 =?us-ascii?Q?95iDR1ThxARwSJNGKqx1aVet8XuN+Bwb66Km5X28ku1tZ6Q9pewNh+7zTSO5?=
 =?us-ascii?Q?7yqyg9lx6CPv3yiQzvtszEDuFmQnvECXJNo2iPPZtofj51mwsSYCRTMQA7+S?=
 =?us-ascii?Q?Io3X3xqNAWOYJAcFHmeN7pMk7raH+Mm1Ec43u/F6LwndWDaUklbfeAAGEEre?=
 =?us-ascii?Q?vcD34GM+e21dWTH349HvosPK++iY/h6XzbsX96nuYG/UlW1wnSA63vUSgIM9?=
 =?us-ascii?Q?gV9DVI6ts3kboDxUjW7qujABo0DTN6xj9S4RJBSkEjc8qWgn0qNfMPu/HOQ7?=
 =?us-ascii?Q?1gCLG2CfyKJFx9cqVmgBXAVyGEzvhBMO8O9FdORj23+a/tklQ1XmQUr7ynVu?=
 =?us-ascii?Q?DGL/WxfOKjinx0O1zco8oW1j5Yr+aCOwMVogmVGeee61sqUrgENQClpouCNY?=
 =?us-ascii?Q?KWom79F/ojzN8Jr6tKGHn0MNWbJeY8FdLmnNqALTkEyi9i3C1hsJDUe+RMPH?=
 =?us-ascii?Q?/iuIfL297DzHvbywxFBsN27VyPLSXyCp4vcOOSGLyi6qNLlpAIHsG8y76FSG?=
 =?us-ascii?Q?uHNbSjx+17cD6WgXx3pS/Opy7XRUyJY236nJlRmlnllBGKW4fK0xsNNMIbcw?=
 =?us-ascii?Q?9z/Y+V7l3At0DjTrXA/Ot5ljPS5GZWFPGZ7r+OZe3RvXzgjisJ2iq8TMjREC?=
 =?us-ascii?Q?YfPscPj+LNdkNODJVUZCWCA9yhy+vRBjNsjNHyPr22xBeT1lliOkTXlfEf20?=
 =?us-ascii?Q?les02+KcEnz6C/rdpJO9NJTEoN0+L9nHEAh896nkreqKrW6KwD/9tqDgo8LF?=
 =?us-ascii?Q?mm8filrAVtbWSRPO/HTk3Nl5I/cyGN5DErUHIva6NAUVu+WxK277CC6zob9s?=
 =?us-ascii?Q?vpxLIvY642UizA0lWGRFLjI30xIMR8K6JTat/EfPxyiz7+Kn0CzDljz9haAn?=
 =?us-ascii?Q?taqSTGjKH4EHRkxtLAUnkUAwTCxGp/mHCmcSYKsUBzI2bAMcb5fbOSUT53Hz?=
 =?us-ascii?Q?ZiR9Z3OEH8Mu7zFla3SQTqYunQus12vuXXKsKhj3lQnBGjmYPOyKubTsIGlm?=
 =?us-ascii?Q?JDV/QEWYw8A0da2sRqSABz4xoXN60n8u3EbXw9EDOA4itHcSIg/RTmxbsJTM?=
 =?us-ascii?Q?30lY1nuo2LOhgQ7Gxg0hzViV1WmCBrpKtDpFFGRXIK7brjvzgOzhdlHqqe8m?=
 =?us-ascii?Q?4eoA8WQQWZIC93uXGwLeV4ZPBkbG2Ap+lhQV5PmeeQRM6TXIKTw+ScV/3NHv?=
 =?us-ascii?Q?AG//QPi0nQs+2s41hdS5+wAHzBA8O1kIGI9R4JlprPCC0xQvTyWU6v3QDlcf?=
 =?us-ascii?Q?GuGq1LM4sQf3DG/R88NYTmEdrwYtEpm5e6m8bg9BeTvl6NP6Ro6RvA9/lCoW?=
 =?us-ascii?Q?2ZrChffmwjnc+m74bbq4ED69CHckpOl2ZUyAU+iZOTnn64eDBJuveR6kCGiP?=
 =?us-ascii?Q?tLBI9eIEMhMsnEeHNjkFKi4lsH+SiP8JdP0ev/C4OKhsCtU4eA5W2Zoam0f+?=
 =?us-ascii?Q?kTroyo04v8lXARtKmYcDZx8JHvlGXO2KtueKHd1NelX+xO8bpxXpZD/erKt2?=
 =?us-ascii?Q?UmAGyJHusw=3D=3D?=
X-Exchange-RoutingPolicyChecked: I8OY2tf4FnabXl18JdeVVXYb1S+ck8dh3B67cxfHP1hS75EhIMID+BK/r5AhhJ0NKfR95or65gj4J9bgZQOZpXP3MP73xJD9pDxs94l/P2ZzorTUP9w3YVhiZs6shdSLHPISMhdW8LatwdCk6cyNJxjdmtOSP9ZMo+IqJiIYxSyhTW0bo5q2vsKFDM8rGMgaU+VncbBKfIMNPvJB6du05vwMShyrP0ti8/wuDoflvppivzvape2SKHyoWlUnKRZNrU5aF7gPw0mJhW9Of+qgCvFi2nyFWfDEfPkF9HwLIPED86N6RT349FXOaPZeVRVjz1hg7pFRJl+98keb4aummg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 807f2e38-17b6-4648-e3ae-08def77c1694
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:42:26.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30BH5yTdmhSjPRo5e2b3abgD+8BEpvpisoUneumtVyRAX0Pp6iy50JsgU46nVLlEAoTClviGfj2CE/FyvjVQ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF162366726
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 02:40:48PM -0700, Sean Christopherson wrote:
> Move kvm_tdp_mmu_map_private_pfn()'s reload of the MMU into its tight loop
> so that an unexpected root invalidation has a better chance of being
> handled gracefully, even though it should be impossible for the vCPU's root
> to be invalidated after the initial reload.  As is, encountering an invalid
> root is *guaranteed* to put the task into an infinite loop (albeit a
> breakable loop that honors NEED_RESCHED).
Note: without the newly added is_page_fault_stale() check in patch 4, an invalid
root would not put the task into an infinite loop :) 

BTW: As noted in [1], is_page_fault_stale() only checks !mirror roots, and
kvm_mmu_reload() reloads mirror roots only when !mirror roots are also invalid,
since an invalid mirror root was considered impossible. (up to now, no?)

[1] https://lore.kernel.org/all/anrD8nI8RfYoNvbf@yzhao56-desk.sh.intel.com
> Add a WARN to try and detect bugs that break KVM's expectations, along with
> a comment to explain why it should be impossible for the root to be
> invalidated.
And there's already a warning in kvm_tdp_mmu_map():
"KVM_MMU_WARN_ON(!root || root->role.invalid);".
So the warning also seems redundant.


> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 621b0a42f2a1..c6cac893cbad 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
>  		return -EPERM;
>  
> -	r = kvm_mmu_reload(vcpu);
> -	if (r)
> -		return r;
> -
>  	r = mmu_topup_memory_caches(vcpu, false);
>  	if (r)
>  		return r;
> @@ -5199,10 +5195,21 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
>  			return -EIO;
>  
> +		r = kvm_mmu_reload(vcpu);
> +		if (r)
> +			return r;
> +
Since kvm_mmu_reload() is moved inside the loop, should we also move
kvm_gfn_is_write_tracked() inside the loop to prevent unexpected bugs?

>  		cond_resched();
>  
>  		guard(read_lock)(&kvm->mmu_lock);
>  
> +		/*
> +		 * Because slots_lock is held, it should be impossible for roots
> +		 * to be invalidated after the initial MMU reload.  WARN, but
> +		 * continue and re-reload the MMU to try and keep the VM alive.
> +		 */
> +		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
>
>  		r = kvm_tdp_mmu_map(vcpu, &fault);
>  	} while (r == RET_PF_RETRY);
>  
> -- 
> 2.55.0.679.g6767b8d81c-goog
> 
