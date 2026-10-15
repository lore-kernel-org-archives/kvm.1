Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32703B14CE;
	Thu, 15 Oct 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035086; cv=none; b=PfNSTucElimaZI2aVNn3Wjk+6yfFBRuB3QkFZUt18MAI8Qz24QBv5NCczdphLjm6oBRFISX3nBqNrNx9jsB4fg1L3F4ori6AFOKs9dX3cOP+4KStUimcr1NoWNpUsBnjF6uakl6ZLNdzR0GYE7ZoCdQGraPIYUQQPWvjXNhXx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035086; c=relaxed/simple;
	bh=04c5bitre1jwMNdFPu2a2/rAKLw7zw6NjctxHNPYtpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWp3fMYT0demTGMTtzYByqUHlJ0d40ab6RPex1D5GyzdSCfUlu8xNX0YQ4U8k+dm+WnxmL1yKF58b71I9KCIQukoEkRfonbRJzpZaDIwEsfC25PrAf33U9i+t4ZDcCP6QagPnz5Sa30d4pxCz7HsA5wmPTmt98do1dzPe/mWxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nreiwERV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nreiwERV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792035085; x=1823571085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=04c5bitre1jwMNdFPu2a2/rAKLw7zw6NjctxHNPYtpo=;
  b=nreiwERVm31iIXVjPq6iaPNCHca/5W8nhmJAQoYx0Jdl+Eks+QZJRicX
   7dBMia+fD9q3tooq4T/MFqpPVHaR8A5N9joaX91hl5+sWXsvFtrMuwQVN
   GvO2KsoKjXjFyaxlFwH7v+g/tUADtj3I+atCfa9Gqiquz+LCcEjyweoT9
   wpT6k9J6Vs/5m8SuLXUQp6PgwFhmX6xt+Px4ZAWyhZMMLG92PJf8fCioB
   zieizkXVO0APXRYI6fpwdEOEM76Ee+CQJVla68zu54EKVsdMC2tfzevEJ
   AQfi4GRUMtnpE4vIxA8gcmJhJ5C/OXxwz/c30qZwXWK3MT7sPIJhGA/ui
   w==;
X-CSE-ConnectionGUID: p5wxb9PMRGKn5HZ4MhRipg==
X-CSE-MsgGUID: LBshTBYmTVyZ4W0lfS9tag==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="692999"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="692999"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 20:31:24 -0700
X-CSE-ConnectionGUID: 4CszLugyRkmKKw6eZoRe3A==
X-CSE-MsgGUID: tJmg9RiPRYmMMEy275mgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2025226"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa010.jf.intel.com with ESMTP; 14 Oct 2026 20:31:07 -0700
Date: Thu, 15 Oct 2026 11:26:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
	yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	nik.borisov@suse.com
Subject: Re: [PATCH v4 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Message-ID: <atBIA+hCnDGXDbsb@yilunxu-OptiPlex-7050>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
 <20261013-tdx-module-ext-v4-1-de5ffac65470@linux.intel.com>
 <c74922f6-7d74-43c1-9780-ce09eeb02b44@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c74922f6-7d74-43c1-9780-ce09eeb02b44@intel.com>

On Wed, Oct 14, 2026 at 08:59:32AM -0700, Dave Hansen wrote:
> On 10/13/26 08:28, Xu Yilun wrote:
> > SEAMCALL wrappers are introduced to avoid broad SEAMCALL access by
> > exposing only a selection of SEAMCALL leafs, but also to abstract the
> > SEAMCALL register ABIs. The abstraction improves readability and reuse
> > for SEAMCALL leafs that are called multiple times.
> > 
> > Some SEAMCALL leafs are not explicitly wrapped because the level of TDX
> > ABI details needed to perform the call is low enough to flow well with
> > the calling code.
> > 
> > For some of the currently unwrapped SEAMCALL leafs, the TDX architecture
> > has evolved the ABI to introduce new leaf versions. The host can select
> > the version to call based on what is supported by the loaded TDX module.
> > When future kernel implements this version selection, more ABI details
> > will leak into the surrounding caller code, which decreases the
> > readability of the caller logic. To keep the ABI details contained, move
> > the SEAMCALL leaf that will need version selection into a wrapper.
> > 
> > When defining the wrapper, the cleanest separation would be to have
> > kernel data types for the SEAMCALL wrapper arguments, and have them
> > marshaled into SEAMCALL leaf ABI types (often u64s) inside the wrapper.
> > This works for many SEAMCALL leafs but becomes cumbersome when the
> > register ABI type is a physical address which points to a buffer for an
> > in-memory ABI. If the SEAMCALL wrapper only accepts kernel data types,
> > it may need duplicate buffer allocation and copies to match the
> > in-memory ABI. Another solution is to define a named helper structure
> > that mirrors the in-memory ABI, populate it in a separate flow, then
> > pass it to the SEAMCALL wrapper. struct seamldr_params is an existing
> > example of this pattern.
> > 
> > TDH.SYS.CONFIG requires a list of TDMR information in the form of a PA
> > array. The PA array is the in-memory ABI. Create a structure for the PA
> > array, use it as the argument when creating the wrapper for
> > TDH.SYS.CONFIG.
> > 
> > For readability, adjust a bit of the existing PA array size calculation:
> > use the new PA array structure's element type instead of hardcoding u64.
> > 
> > AI was used under supervision to review code and workshop logs.
> 
> I'm wondering if this is a case of AI gone wild. There's a *LOT* of info
> there, but I'm not seeing the thing I really want to see: Why is it
> worth creating this helper _now_?

The leaf version of TDH.SYS.CONFIG will be selected based on what
features are supported by the loaded TDX module. We think this is a
lower level knowledge than the surrounding code. So does the existing
r8 tweak for DPAMT.

We have r8 tweak now, and in next patch, we will set "leaf version=1" as
a second case. So we think it's time to make a lower level abstraction
for these selection logic.

Some early discussion:
https://lore.kernel.org/lkml/2d138a8acb685385016e0bb0535e7213952e44e5.camel@intel.com/

> 
> Also, the move to tdmr_info_pa_array seems 100% orthogonal to me. Why is
> it here?

The change is motivated by the wrapping. Now the type of tdmr_pa_array
is u64 *, which is a local detail of config_tdx_module(). Once we have a
wrapper, it would look like:

  int tdx_sys_config(u64 *tdmr_pa_array, unsigned int nr_tdmr_pa,
		     u64 global_keyid)

"u64 *" would become a vague argument type.

Is it better to split the wrapper & the new struct into 2 patches, the
new struct first, then the wrapper?
