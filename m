Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDD3F8EB9;
	Mon, 27 Jul 2026 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149325; cv=none; b=cWZMHflUSxhlCMziWnJt1ubzmrCZVTTXtb2VKhNNHGCLuwmhRQA6v4a3MkXWCn1hxRfJNw/asmhG5xBHTq8bvoqNeWzj1RmnytKDbtSa9+nbAbj1ia14FzkEywIFkmrUGAPKvvnC8I6cvlHuDeeNZfp8tBxmQDsjjVh2GyMZsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149325; c=relaxed/simple;
	bh=FL8PEeJ6vnuU/NVIWM6q9AZv1YhvI5xh7/FEsDbvS1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrUS0Fkf67ME2jqJqJ3Z80VeHVUhwfSM+O+wFsxYmcx51bfFmoRDhWvVl5YQf0DtF5sOtPLecZ8XM6pZOBiyXunKoXKliyMy1IZVFRB1VJ0knKEW6JtNdiVCNut3dfYmCPp0HHvlQSZkMhXOVSWaEnZZy7E3c1hv7S7PA1+rSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOYLpySU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOYLpySU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785149324; x=1816685324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FL8PEeJ6vnuU/NVIWM6q9AZv1YhvI5xh7/FEsDbvS1k=;
  b=iOYLpySUIZmXdzLLg1YPCjL3A9r21+IJG+Hr+ThUBKGv8FyGpRLTKLw0
   W9mEqSow+Kl4B/I3dgX5YpxUe7BHRgY7q7RY3JmTrkax0Q1L4WPOMmjKR
   TKajP1o1xLGzcSlhUd10VE8a914rqB0vx/V+ob7hm9XiHM14reHn3VJ3/
   KfeVwsye6X7TU6PMOxtUWD3O2iIKbJEkB0Ja1OMtFHIlwlwi8Hg9yjavb
   cJdeoGSUYtFojXdLjtq3Lz2dlj4IzFch4ksgRqck8Qdc9LR6ijFABOXO3
   0DCCaiTFG5/zFshNRGlNFqyvJegKrV4x/lGY9ksYgjpJCf97Gk7UM24W0
   w==;
X-CSE-ConnectionGUID: es4kg08hRzCWQsajqL8kdw==
X-CSE-MsgGUID: vpslP7SLTwqbdOfKEzP/+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="73253834"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="73253834"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 03:48:43 -0700
X-CSE-ConnectionGUID: eZpc649kQau/7g/exXZJsQ==
X-CSE-MsgGUID: duayf3k6Qeue9hgC8Wsj9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="264377032"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 27 Jul 2026 03:48:39 -0700
Date: Mon, 27 Jul 2026 18:48:38 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <amc3hgkK0LzJ3i4N@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
 <823bf577-51a1-4a8a-b240-ef4a0d5573be@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823bf577-51a1-4a8a-b240-ef4a0d5573be@intel.com>

On Fri, Jul 24, 2026 at 04:15:21PM +0800, Xiaoyao Li wrote:
> On 6/18/2026 4:13 PM, Xu Yilun wrote:
> > In addition to basic TDX functionalities, TDX module provides add-on
> > features that can be progressively enabled as the kernel supports them.
> 
> "add-on features" looks like a new term introduced by this sereis for TDX.
> So what is add-on features? all the features defined in TDX_FEATURE0/1? Or
> only the features needs to be explicitly enabled by R9 and R10 of
> TDH.SYS.CONFIG? ...
> 
> > The kernel should explicitly configure these features at boot or
> > post-update initialization time.
> 
> ... So the answer is the latter. Then why only these bits are add-on
> features while the rest in TDX_FEATURES01 are not?

I think from TDX arch POV they impact the existing TDX system in some
ways, either changes the behaviors of the existing features, or impact
the performance.

> 
> btw, s/should/needs/ is better?
> 
> > Configuring an add-on feature, such as
> > TDX Quoting, that uses extension SEAMCALLs is the prerequisite for
> > initializing TDX module extensions.
> 
> Though the statement is right, it leads to the impression that the reason we
> are configuring the add-on feature is to initialize the TDX module
> extensions.
> 
> However, the truth is kenrel wants to enable/use an add-on feature and the

mm... yes it is somewhat misleading. Is it better we only talk about the
add-on features' enabling in the first paragraph, then in next paragraph
explain why we put the patch at the first one for TDX module Extension
enabling?

> add-on feature requires the functionalities provided by some TDX module
> extension. So kernel needs to enable the TDX module extensions.
> 
> > TDX Quoting is the target feature to
> > enable but defer it for now until full kernel support is in place.
> > 
> > TDX module extends TDH.SYS.CONFIG and TDH.SYS.UPDATE with new bitmap
> > input parameters to specify which add-on features to configure. The
> > bitmap uses the same definitions as TDX_FEATURES0.
> > 
> > For runtime update, Linux applies a policy that no newer features should
> > be added after update to avoid disrupting live TDX operations. To adhere
> > to this, TDH.SYS.UPDATE must configure the same features as the
> > TDH.SYS.CONFIG. Record the kernel required add-on feature bitmap in a
> > global var so that both phases can use it.
> > 
> > TDX module advances the version of TDH.SYS.CONFIG and TDH.SYS.UPDATE for
> > the change, so use the latest version (v1) for add-on feature enabling.
> > But supporting existing modules which only support v0 is still necessary
> > until they are deprecated. In fact, it is unlikely that TDH.SYS.CONFIG
> > ever needs to change again and the code would stay in v1. So there is
> > little value in worrying about deprecating v0 to save a couple lines of
> > code in 5-7 years when these original TDX platforms sunset.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >   arch/x86/virt/vmx/tdx/tdx.h |  6 ++++--
> >   arch/x86/virt/vmx/tdx/tdx.c | 28 ++++++++++++++++++++++++++--
> >   2 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> > index fbb520704662..a47e872480c7 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.h
> > +++ b/arch/x86/virt/vmx/tdx/tdx.h
> > @@ -58,9 +58,11 @@
> >   #define TDH_PHYMEM_CACHE_WB		40
> >   #define TDH_PHYMEM_PAGE_WBINVD		41
> >   #define TDH_VP_WR			43
> > -#define TDH_SYS_CONFIG			45
> > +#define TDH_SYS_CONFIG_V0		45
> > +#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
> >   #define TDH_SYS_SHUTDOWN		52
> > -#define TDH_SYS_UPDATE			53
> > +#define TDH_SYS_UPDATE_V0		53
> > +#define TDH_SYS_UPDATE			SEAMCALL_LEAF_VER(TDH_SYS_UPDATE_V0, 1)
> >   #define TDH_SYS_DISABLE			69
> >   /* TDX page types */
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 2a03152796e6..92305b5ea90d 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -57,6 +57,7 @@ static struct tdx_module_state tdx_module_state;
> >   static u32 tdx_global_keyid __ro_after_init;
> >   static u32 tdx_guest_keyid_start __ro_after_init;
> >   static u32 tdx_nr_guest_keyids __ro_after_init;
> > +static u64 tdx_addon_feature0 __ro_after_init;
> >   static DEFINE_IDA(tdx_guest_keyid_pool);
> > @@ -1004,9 +1005,18 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
> >   	return ret;
> >   }
> > +static __init void set_tdx_addon_features(void)
> > +{
> > +	/*
> > +	 * To add DICE-based TDX Quoting feature bit in tdx_addon_feature0 when
> > +	 * kernel is ready.
> > +	 */
> > +}
> > +
> >   static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
> >   				    u64 global_keyid)
> >   {
> > +	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
> >   	struct tdx_module_args args = {};
> >   	u64 *tdmr_pa_array;
> >   	size_t array_sz;
> > @@ -1032,7 +1042,15 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
> >   	args.rcx = __pa(tdmr_pa_array);
> >   	args.rdx = tdmr_list->nr_consumed_tdmrs;
> >   	args.r8 = global_keyid;
> > -	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
> > +
> > +	set_tdx_addon_features();
> 
> Maybe move the set_tdx_addon_features() out of config_tdx_module()? how
> about putting it after check_features(). config_tdx_module() looks like just
> a wrapper to invoke TDH.SYS.CONFIG, while the params of it are determined
> outside of it.

I'm going to take Chao's advice [1] to remove the global var
tdx_addon_feature0, so will also delete this global step -
set_tdx_addon_features() - to setup this global var.

Instead I'll use a "static u64 get_tdx_addon_features0(void)" for
TDH.SYS.CONFIG/UPDATE.

The reason is that I've found this extra TDX status - tdx_addon_feature0 -
makes the feature supporting judgement unnecessary complex, so don't
make it long live.

[1]: https://lore.kernel.org/all/ajpHRNaq+z5bdn+R@intel.com/
