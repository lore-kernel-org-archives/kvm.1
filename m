Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494056;
	b=X0opwpWhauKkJFSSR7U/VsGv7othT9ZQSPZ+II+XqqhJhgKGKpdxm63zxcwo17Leltey
	 ET7dD4Nbhbe5VMUQVS9eSrShIEKwOC0+tGwH1LK1SXjGFgHqYqrfj2egaZO1cvJJArqFu
	 kzlvpDOKzU8ZR3miCxwbMw9nX1aQ3peVnJk0VPHIebj3HQybe4oxZSO8tAP66u72IhD6L
	 E7sm9Z3NFcWVTuPFYQFdpY31MqJwpGuE+OkmHQB0litmM0jXeV4lmCLi4snOpbEPOhtZJ
	 YHGL8H4yaUlCP57y1+5o0sx9tHA5Psoyr2SgLTUfzJw00AssEnLhOnWtLWkaFx5V7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494056;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vSoBJw3bJU+XayjzczxzT9tLb1CSLP3d3fwCLBfTU4o=;
	b=PbDC86SkDRvEO+L90x2wEMolSFXs1ocxwsZgACl4U0H8SqCnzAniOgwnDgv5J2B1qjOx
	 Izyoy8w7Mi/LFNra41w03xAu1Cr4LW9Y7NSwCV0oVtWBDuugacBMyW3q/xEdzlZjpxYT4
	 KHnSQWFfpQRP7BG+eaLtlipE2HCRrveRCLklj882xjj76s6IMm6lnbUD0qKb+1677vbXQ
	 I/SuPDev6VnlsRpdlWJGybwkfuux7gjxFfbB5MJt/nju5A4jU0KgNBT2aCLKojs8x+wNC
	 s9ushLitSddlV+rj4gV/V1U5ufADrj0IsuMA1rGjDYOj7UqID06imPxRPQr5ooORjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gnKD+AWY;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12F606A31A;
	Tue, 20 Oct 2026 11:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A12F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gnKD+AWY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792494057; x=1824030057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f1gIxStBvvTnb8FUgZjxNH2u6l0XyPghXfOpb0RB0J4=;
  b=gnKD+AWYQBJLN2CFNfugIj0cQrpBio0AMf0kx/rENFTAaj4lZDv9bF+X
   KOEarHC8VW/dWlIGdizt/OhAX1h8dpUwtgchYsf8fp2fLQ0Ed/oDJ+Zne
   bBZ0m/gg4fZ2Abb2XQKxpr1oZe+w4JlJyaqraOlMyUvMRLoWrFlldlPaZ
   V4NF/6Q/pxF6fWoXUK6iUU8jJHBOri1ERwfFv6SC3L+k0bjZbTh2/Mc+x
   SlLdiG/4XZ/OKiOc7wPfJlOu+zUvLCamCqa1DsoT+vIhAaxQLi6uIrHrR
   dnpwkisqKv3ULrZOlmwl85JtEKelJ2z86rFNn26FtfIAC0b+oNee+ZOuB
   w==;
X-CSE-ConnectionGUID: /Jpwnj3tRHKs2b3k9RWjEQ==
X-CSE-MsgGUID: uECbREtNRqG9IkLYLFPjRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1083344"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1083344"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:00:56 -0700
X-CSE-ConnectionGUID: GDanXnDXRsyEl3uWTadSJg==
X-CSE-MsgGUID: 6tz/75haS3yne8QlpbGpww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4571442"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 20 Oct 2026 04:00:52 -0700
Date: Tue, 20 Oct 2026 18:55:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com,
	x86@kernel.org, kas@kernel.org, adrian.hunter@intel.com,
	yan.y.zhao@intel.com, binbin.wu@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, nik.borisov@suse.com,
	tony.lindgren@linux.intel.com
Subject: Re: [PATCH v2 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Message-ID: <atdIv8UNaqJ+9Vf6@yilunxu-OptiPlex-7050>
References: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
 <20261015191710.3632302-3-rick.p.edgecombe@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015191710.3632302-3-rick.p.edgecombe@intel.com>

> KVM previously needed to call different types of tdh_phymem_page_wbinvd_*()
> helpers for different types of reclaim. So it had a stack of helpers and
> some open coded logic to use them in the rarer TDR reclaim case. Now that
> the wbinvd is gone, the steps for each operation are logically equivalent.
> So collapse the helpers and just call tdx_reclaim_control_page() from the
> TDR reclaim path.
> 
> This unification brings TDR reclaim in line with the behavior of the other
> reclaim paths, by handling TDH.PHYMEM.PAGE.RECLAIM failure by leaking the
> page and setting the TDR page pointer to NULL. This results in reclaim not
> being tried a second time, which is reasonable because the first reclaim
> failing suggests a problem with the TDX module.

Ah, it really is bigger than expected: Removing __tdx_reclaim_page();
unconditionally nullify kvm_tdx->td.tdr_page;

Personally, I would split the helper collapsion into the 3rd patch in
this series. But I'm also good this way.

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
