Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45B37F8C6;
	Wed, 26 Aug 2026 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787721363; cv=none; b=IL5r0dyvCujATA36I64fE5ozHLecd1bxwuH9vm2DpAHh8QZwGc/rZZ0GjXt2phjkKgwtdOprLIQwkABmndlbQCU9vP+1nDKxLyM4yFJiZf3UVQBENJNnIGbPYlrP+HYpIjJMVQBngGkfOEfF6aDTxTWoZHGufJP+cemGDjV176o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787721363; c=relaxed/simple;
	bh=uPWJuun6vFpFa13LZ6XYfM6yyh8KXvFmJDkJm3tIu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE7fLUuy3TFY6fxJ6PawJdJDshOefpO1ay0R/mMYXuzaKifnumJd88y9wxBCj0KdIYpN8HhSSR79RwQyMw8JPeZX4xz+IzRjVkewH8cWJKPVOb0N63dTZJkDrTBBJmxKjCsFN0f5htCCrZzhmTEaKbdjwu6yYmBN4DLBMgPR6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKL8CkfO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKL8CkfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787721359; x=1819257359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uPWJuun6vFpFa13LZ6XYfM6yyh8KXvFmJDkJm3tIu/I=;
  b=kKL8CkfOPMltdP+JAGvuPW5u8R0I2hg/zqwmv5CW1ARW9ksW0UMGSpLY
   TQ3KqUE+TFnIfybqVSn3RxiEHgDWgzMn20i2DWXjadKaXW3ZlEOX60QOI
   6hf9GRD2N8PRlklE0tFJJ4boTKJHEL0OqEUrZX90YYYV3nnVwWSphN6v2
   in6fP1hvLi2fG6v9OGWbZbaOnX5PMFRqnzzDhT7H+vFZvJdCvI65cXKIh
   Qbba6FLnK8xmNZX2ixoT5RvXOZpQa+IlE84as4+bKRD8ukWjN48sNqy8x
   rkgP/SsNcHCF70X+KAOIMcoF3/hzfF2WgBCU+ZF2Cqz/l1McN1e5+wZNI
   A==;
X-CSE-ConnectionGUID: zdCETRFFSviLD+W9U1ymSQ==
X-CSE-MsgGUID: 10wRCNguSXGGTxFVaeMIvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="110978988"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="110978988"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 22:15:54 -0700
X-CSE-ConnectionGUID: z86n+etHRM2Bbbvwl+Lohg==
X-CSE-MsgGUID: whN8yuBJTims4t8/NY44xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="267499437"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa007.jf.intel.com with ESMTP; 25 Aug 2026 22:15:51 -0700
Date: Wed, 26 Aug 2026 13:15:49 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <ao52haB5N3dnSzr8@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-3-yilun.xu@linux.intel.com>
 <41f5a558ca67e2895fcb114c418f0e453e933974.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f5a558ca67e2895fcb114c418f0e453e933974.camel@intel.com>

On Fri, Aug 21, 2026 at 10:01:16PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-08-21 at 11:29 +0800, Xu Yilun wrote:
> > The TDX architecture identifies some features that must be explicitly
> > enabled when the kernel supports them. 
> > 
> 
> It sounds like this is saying that TDX module is demanding that the kernel
> enable these features if it can. I think it's not true.

The TDX architecture identifies some features that are off by default
but can be enabled by the host during TDX module initialization or
update.

> 
> > These add-on features affect
> > existing TDX systems: they may change existing feature behavior, reserve
> > more memory, or impact TDX initialization performance.
> > 
> 
> What are you trying to get at by saying they affect existing TDX systems? It's
> important that if a new module gains these features, an upgrade *doesn't* affect
> existing TDX systems. Are you trying to say instead that they *would* affect
> existing systems, so they are add-ons?

Yes. Previously Xiaoyao asked "why only these bits are add-on features
while the rest in TDX_FEATURES01 are not" [1], so I added these words.

[1] https://lore.kernel.org/lkml/823bf577-51a1-4a8a-b240-ef4a0d5573be@intel.com/

> 
> >  The kernel must
> > enable these add-on features at boot or post-update time.
> > 
> > TDISP, DICE-based quoting and TD migration are among those add-on
> > features, as their SEAMCALL leaves depend on a SEAMCALL execution
> > context built by the TDX module extensions. On the other hand, the TDX
> > architecture doesn't allow the extensions to be initialized if none of
> > these features are enabled.
> > 
> 
> So we have add-ons features and extensions. Some add-on features depend on
> extensions. And also, the extensions can't be initialized if the add-on features
> are not enabled? I'm not sure what you are trying to get at. That the kernel
> doesn't have the option to blindly initialize all extensions?
> 
> >  Add support for configuring add-on features,
> > as the prerequisite for enabling the extensions.
> 
> I kinda know how this stuff works and I'm still struggling to understand what
> you are trying to say...

I just try to explain why the add-on feature configuration patch appears
in this extensions series, because it is the prerequisite for extensions
enabling.

From your comment below, seems we don't have to explain this
prerequisite here. Maybe I should delete this part.

> 
> I think optional features are pretty common pattern that will be generally
> understood. So the only thing that needs explanation is that some optional (or
> add-on) features need extra memory to save state, etc. But actually, this patch
> doesn't deal with this, just turning on optional features.
> 
> > 
> > The TDX module extends TDH.SYS.CONFIG and TDH.SYS.UPDATE with new bitmap
> > parameters to specify which add-on features to enable. 
> > 
> 
> Because some other VMM was passing garbage in r9?

I think yes. On version0, r9 is ignored meaning architecturally VMM is
OK to fill any value in r9.

> Hmm, how does this work with other features0 bits?
> Like for dynamic PAMT is a feature0 bit, but we pass it in
> r8. But for add-on features that use extensions we pass it in r9?

I feel this is historical baggage in the ABI design.

> Or do we pass
> all features0 bits in r9 for when using v1 of TDH.SYS.CONFIG? The docs say:
> 
>    If the requested version in RAX is 1 or higher, R9 specifies TDX Module
>    feature enabling flags, formatted similarly to TDX_FEATURES0, readable by
>    TDH.SYS.RD*. A bit may be set to 1 if the corresponding TDX_FEATURES0 bit is
>    1.

No, there are two more rows in the table to specify: 

According to SPEC, for other feature0 bits whose value is in TDX_FEATURES0,
they must be 0. for bits not in TDX_FEATURES0, they are ignored.

> 
> I wonder why they didn't just use the many reserved bits 63:17 of r8 for new
> features instead of this new seamcall version...

I guess they want to re-use TDX_FEATURES0, they don't want to make new
definition of every bit for each add-on feature. But let me check with
module team.

> 
> > The bitmap
> > uses the same feature bits as TDX_FEATURES0. Add a
> > get_tdx_addon_features0() helper to return the bitmap of the add-on
> > features that the module & kernel both support. Initially, this helper
> > returns 0. It will be updated to return specific feature bits as full
> > kernel support lands. Pass this extra bitmap to TDH.SYS.CONFIG helper.
> > 
> > The TDX module requires SEAMCALL leaf version 1 for TDH.SYS.CONFIG and
> > TDH.SYS.UPDATE when passing the new bitmap parameter. A previous
> > change [1] supports the versioned SEAMCALL leaves by adding a "version"
> > field in struct tdx_module_args. Set the version field to 1 if any bit
> > is set in this bitmap.
> > 
> > Compatible updates keep the reported features unchanged across updates,
> > so that existing TDX users can continue to operate without disruption.
> > To adhere to this
> > 
> 
> Compatible updates keep from disturbing the kernel. So the kernel shouldn't need
> to adhere to anything. Just say the kernel doesn't need to re-fetch it.

Good to me.

> 
> > , provide TDH.SYS.UPDATE with the same bitmap returned
> > by get_tdx_addon_features0(). This works because the module supported
> > feature bits are cached at boot and never refreshed after updates, so
> > the returned bitmap always matches the initial TDH.SYS.CONFIG input.
> 
> 
