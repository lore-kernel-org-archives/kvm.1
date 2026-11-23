Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420058;
	b=ryTJQO8bIPcqNUxLngzWPcKAL7bpqfCN1RXfci4FW2XWRAzbn8sahafBuNDuComblSXX
	 +caAMC9NpDPTkUdviRi+CmigwLQv6VnSBiTou3X7RwbIORJ0M6f5xDiW+tpZGQMMjQlGZ
	 Ej/CHCa0v4aLr4VlAIPcFG1olfNQeGNjcYHmDNLECkepaRsIwsgEHnx5bB2MoEdlPDpEq
	 kZXGCiJUxi0pbkJSnsulycLp/bZjzRRN8MnhB7c8m+KpNUds9BTYiYq2elzbNT6ycdd6X
	 RDQgzvODHdhIDKst347C4s+7nz/zxUF7+m4wyAlNauuNyfSHmhzeZhp08FEonY3QeHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420058;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=IMHR1UHlaSkYXvI5f6seP3SqRyBf4Dtza4yGLxiVPJk=;
	b=m/zAPlIN7PnpADApe8EGd2g/0U+QitldcBCC7SEULI1Y9tww7JBFgHCYdiHyid0pbLsa
	 +K63EubYCnTLaoGARI4II9ZRJK+6/tBYunSAWm+wQz+f0Z65IucfvLHNKgIjxSWEyftKZ
	 sopJf21eTO9QGGFrQ29K6pjP1CNDI196z2TWtVUeAvcgtHLNR5bY7o1ytwyFhgDK4rpwi
	 7GVCUt7JXCdyVTya3ok5zIkCn2EuvF11edKwtWarIGFllKqn1416sp36sIps0HyyrukPg
	 c2mQGjA1Ek6kv3LzaJuJG4HTNzRB/IwKCpUH5AKrRdqImAhRWlQSJNhRiOlTARCdc6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n6KT8gsm;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125E606A31A;
	Mon, 23 Nov 2026 07:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6125E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n6KT8gsm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795420058; x=1826956058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v1D4E2zzMlccfi2a2QCIuXxcWfSFz5vqwAawLHwyTco=;
  b=n6KT8gsmCcp+qsMGwIIlUsQusEA53MT1FhgUB2E9xMtQxvICegnRIedl
   PqrXFWoSc1WdqnKnURKUA8ZT+JynkutQ4yIrxCR6HPuloODbjMSwofeZd
   zhiOiOlrZSC5CXISX2WHiBp+JuGuoryTlXvo1uNultdXGpPxsgFzxpoSG
   nhffuLxBsWYVTJAPd7QUqjYkBbZgn36ao2Ut/HjDxB7zE4ihAUb+iQIng
   si45RZuxTdyhwIYM/K5Pk+YDUkekoTc4QRiG0pVd4lTnb2lEi0g+gFXwR
   FSUgP2g7O6DwFYDywZ+act9ALcT4vqba3Az+3n84WrBPXqoUOW5LEJDx/
   A==;
X-CSE-ConnectionGUID: +8UgUA2aRues3WtxT18cmg==
X-CSE-MsgGUID: UEvgIfXASj6DDBM9z/VO3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4104621"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4104621"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:47:37 -0800
X-CSE-ConnectionGUID: HSICQss7TA+aU/+uM2riVA==
X-CSE-MsgGUID: 7mBmUESYSOCdnWkF0sg3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11139912"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 22 Nov 2026 23:47:32 -0800
Date: Mon, 23 Nov 2026 15:37:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com,
	kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com,
	sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, chao.gao@intel.com, nik.borisov@suse.com
Subject: Re: [PATCH v5 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <awPtUgf+YZ0xfD6v@yilunxu-OptiPlex-7050>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-2-c74f764abc3d@linux.intel.com>
 <d012c58931efa38a782ac3484ea930d05a6407a9.camel@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d012c58931efa38a782ac3484ea930d05a6407a9.camel@linux.intel.com>

On Sun, Nov 22, 2026 at 05:50:41AM +0200, Artem Bityutskiy wrote:
> Hi Yilun,
> 
> The patch looks good, but its framing can be improved.
> 
> Remove references to enabling all add-ons to improve it. This patch adds
> plumbing, it should not dictate/discuss whether all or only some add-ons
> should be enabled. See comments below.

The get_tdx_usable_addon_features0() in this patch is enabling all
add-ons that *the kernel supports*. And this policy definitely needs
explanation.

The current kernel code highly depends on tdx_sysinfo.features.tdx_features0
to decide if a feature is available. So if we enable *some* add-ons, the
contract no longer holds. So I do think we need clear words on the
policy.

But yes, maybe the word "all" reads like we enable all add-ons that the TDX
module supports. I'll see how to avoid that.

> 
> On Wed, 2026-11-11 at 11:48 +0800, Xu Yilun wrote:
> > The TDX architecture identifies some features that are off by default.
> > They are classified as add-on features because enabling them affects
> > existing TDX systems: they may change existing feature behavior, or
> > reserve more memory.
> > 
> > However, the impact of the first add-on features will be low enough to
> > pursue a simple approach - the kernel just enables them when supported.
> > If a feature with a very high overhead appears in the future, this can
> > be revisited.
> 
> This sounds like all supported add-ons will be enabled for simplicity.

Maybe the first sentence is not clear. I want to say we enable add-on
features when *the kernel* supports them. I'll change it.

> 
> The reviewer keeps this in mind now.
> 
> ... snip ...
> 
> > Pass the bitmap of features that are supported by both kernel & TDX
> > module to TDH.SYS.CONFIG. Initially, the bitmap is 0. It will be updated
> > to contain specific feature bits as full kernel support lands.
> 
> But this says that it enables no add-ons. Now reviewer needs to spend
> brain cycles to process the contradiction, unnecessarily.

I see the concern. There is actually no contradiction, we enable all
kernel-supported add-ons, but for now kernel supports no add-ons, so
nothing is enabled.

v4 explains this point in one paragraph, I split it in v5 which may
causes the disconnection. I'd like to roll back:

    Although add-on features can introduce overhead to TDX runtime, the
    impact of the first features will be low enough to pursue a simple
    approach - just enable them when kernel support lands. Pass the bitmap
    of features that are supported by both kernel & TDX module to
    TDH.SYS.CONFIG. Initially, the bitmap is 0; it will be updated to
    contain specific feature bits as subsequent kernel changes support them.
    If a feature with high overhead appears in the future, this can be
    revisited.

> 
> ... snip ...
> 
> >  arch/x86/virt/vmx/tdx/tdx.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index c7bd0b01786d..3bfe78b4b538 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1033,9 +1033,19 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
> >  
> >  #define TDX_SYS_CONFIG_DYNAMIC_PAMT	BIT(16)
> >  
> > +/* List all kernel-supported add-on features0 bits here */
> > +#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
> 
> Suggested comment:
> 
> /* Specify add-on feature bits to enable” instead */
> 
> I think that this patch should not dictate "all" vs "some", no need.

Yes, will do.

> 
> ... snip ...
> 
> > +	/*
> > +	 * Use SEAMCALL version 1 that supports add-on features if any are
> > +	 * requested. Otherwise use version 0 for backward compatibility.
> > +	 */
> > +	if (addon_features0) {
> > +		args.r9 = addon_features0;
> > +		args.version = 1;
> > +	}
> 
> Separate nitpick for the comment.
> 
> Suggested comment:
> 
> /*
>  * Avoid unnecessarily requiring version 1 when no add-on features to
>  * request.
>  */
> 
> I was confused by "for backward compatibility”, which sounds like the
> kernel or the seamcall falls back to version 0 if version 1 is not
> supported.

It is for backward compatibility, but we don't try v1 then fallback to v0.

How about the following. I want to keep the compatibility statement but
still fit in 2 lines.

	/*
	 * Avoid unnecessarily using version 1 when no add-ons to request. This
	 * retains compatibility with older modules that don't recognize v1.
	 */

> 
> Thanks, Artem.
