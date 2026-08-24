Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8B347532;
	Mon, 24 Aug 2026 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547179; cv=none; b=V1ceV7hS+yPD/kszN9T6LO1QjL4H0uxsWNHAS9+mAV7P2zScnJ7G3xjCLTgo2KC2LhKmW5APcod2yQmKKJH3MTCWM/6s6S8eb73BRUY8NeCl4mvUGTu1vEDMSEFU/wSVgV9BNlkRR4IvpjvuPAMHqZLrCbCKAOegQsNBjxBmAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547179; c=relaxed/simple;
	bh=GqsVNYIZCfa4dKw2B7PoigOvKOQBjsKQ/Tl8vduZ2vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG/hsfENgQ2GWaITno8+83xXJpYarz4hB04wGjuCORVJLgTXQC3MkqaB/aqcBeKLCNghSKeQIWxnoLe9K7E8RSsVEE/roPWCTTXK+OUl3COYtQjdFUyQ0N8yGONX5wt7JbJf4Z3S5yExvidcCSh4CC1vdkH78WbxXjcMOM9ceVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMLUHDDj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMLUHDDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787547177; x=1819083177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GqsVNYIZCfa4dKw2B7PoigOvKOQBjsKQ/Tl8vduZ2vI=;
  b=UMLUHDDjkwPB3KvOc36BC7tn8J1pONt42sN/HKhXNaPpL7vZYIi3t9Nq
   bF3+n7BEjeNMbmBZqO6ZGTKBuHegtfHNuHvGb6iEnQAC0bV+J/ElKx8fc
   OFj441wRNj6au6inQauc4Opm1vHpWjEE2tQfYriISL0sIdIURmSaoijKb
   3QF9QRv5mnJRow+Dn3zRkr8/R/dLrl9XxRzEUYBSZUU8/q0kyDAjeu50D
   3gXgugGnOaWNg1WGhGRwWQmYTs7a8LDm+Z8RJoH+IX/7YNlMOkycN1Pjj
   m/j1p6mEPDyhStuVlxJpMWviTkEcL3oMT/w0EAqyP8/0YMNz47wJ8QBSk
   g==;
X-CSE-ConnectionGUID: TBRkzkqjQpeVTZLgwjcU0A==
X-CSE-MsgGUID: /fxnnmSVSg2tM3nYWKXSVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="99149059"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="99149059"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 21:52:57 -0700
X-CSE-ConnectionGUID: tYwJo0upRNi8Icv1qrlx6A==
X-CSE-MsgGUID: vybsLoUqTWSRL/y+CqMpaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="266935484"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa007.jf.intel.com with ESMTP; 23 Aug 2026 21:52:49 -0700
Date: Mon, 24 Aug 2026 12:52:48 +0800
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
Subject: Re: [PATCH 1/6] x86/virt/tdx: Wrap TDH.SYS.CONFIG/UPDATE operations
 in helpers
Message-ID: <aovOIJ8f7ONZxRw7@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-2-yilun.xu@linux.intel.com>
 <8fa5f9faf6ad6d432dcc2cf12f5bff03c17147a9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa5f9faf6ad6d432dcc2cf12f5bff03c17147a9.camel@intel.com>

On Fri, Aug 21, 2026 at 08:53:57PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-08-21 at 11:29 +0800, Xu Yilun wrote:
> > As part of the TDX module initialization, the kernel configures the TDX
> > module with several information
> > 
> 
> The tense is weird here around "several information". Should be "several pieces
> of information". For curiosity sake, I looked it up and found a new-to-me
> linguistic term:
> https://en.wikipedia.org/wiki/Mass_noun
> 
> > , such as TDX-usable memory regions
> > (TDMRs) and the global KeyID for protecting TDX metadata. During the
> > configuration, the kernel does 2 operations: constructing kernel data
> > types for the SEAMCALL leaf arguments and turning these data types into
> > u64's according to TDX ABI.
> 
> What do you mean by "constructing kernel data types for the SEAMCALL leaf
> arguments"? You are splitting the calculation of the pa via offset from setting
> it in a u64? If that is what you are saying, it makes it seem like a much bigger
> set of work.
> 
> > 
> > Both operations are implemented in one function - config_tdx_module().
> 
> Well I guess my guess above was wrong, because the construction of the pa kernel
> data type happens in tdmr_entry()

Yeah, the PA array is an in-memory ABI, which is not constructed in the
newly introduced helper. The construction of an in-memory ABI usually
involves allocating/freeing memory, I remember there was an objection to
allocate memory inside the SEAMCALL helpers.

> 
> > This blurs the boundary between kernel managed structures and TDX ABI
> > definitions.
> > 
> 
> In the code after this patch it is still setting a u64 in config_tdx_module()...
> so what is really changed with respect to this?

I think all the confusions come from the differences between "in-memory
ABI" and "register based ABI". The SEAMCALL leaf invoking is always the
register-based ABI. But Some registers reference some shared buffer
which contains the "in-memory ABI".

This patch introduces a helper to wrap the constructing of the
register-based ABI, but doesn't wrap the constructing of the in-memory
ABI, which should be the work of another helper if needed.

All helpers should take kernel data type as input. The previous
"u64 *tdmr_pa_array" is already a kernel data type to represent the
in-memory ABI that is referenced by the register-based ABI, but it is
easy to get confused (u64 * vs u64). So we define a named kernel
structure to clearly describe the in-memory ABI.

[...]

> The change looks good to me, but I'm wondering if it will need a better
> justification. How about something that hits these points:
> 
>    We have SEAMCALL wrappers mainly to not expose broad seamcall access, by
>    exporting only a selection of seamcalls, but also to abstract the seamcall
>    register ABIs. The latter improves readability and re-use for seamcalls that
>    are made multiple times.
>    
>    Some seamcalls leafs are not explicitly wrapped because the level of TDX ABI
>    details needed to perform the call is low enough that it can flow well enough
>    with the calling code. 
>    
>    For some of the currently unwrapped seamcall leafs, future changes will add
>    seamcall version selection that will adjust the ABI depending on TDX module
>    version support. This will result in more ABI details to surrounding caller
>    code and decrease readability of the other logic. To contain this, wrap the
>    functions that will get version selections in seamcall wrappers.

Yes, I'm good to the reason to wrap the register-based ABI.

>    
>    The cleanest separation would be to have kernel data types for the seamcall
>    wrapper args, and have them marshaled into SEAMCALL ABI types (often u64s)
>    inside the wrappers. But to avoid duplicating allocations and copies, don't
>    do this when creating the wrapper for TDH.SYS.CONFIG. Instead clarify that

My reading of this paragraph is that we shouldn't wrap both in-memory ABI and
register-based ABI constructions in one helper, cause that may duplicate
allocations and copies. Because otherwise the combined helper should receive
a kernel managed buffer that represents the in-memory ABI but doesn't conform
to its layout, resulting in the extra allocation and copies in the helper.

Do we need to talk about this register-based/in-memory ABI pattern in general?
Not just for TDH.SYS.CONFIG. We already have exsiting examples and more to come,
this is not special to TDH.SYS.CONFIG.

>    the u64's in the array passed are pa's with explicit naming of the helper
>    struct.
>    
> 
> It's a bit rough, but as a general argument for the change, does it seem better?
