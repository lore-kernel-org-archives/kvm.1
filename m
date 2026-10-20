Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494086;
	b=zVc0WoWGLoEqUs4FK6cysGG9vQrL3MQ5dvznsGjyQ08O3oZ3yV6dTQHTADtIq5S6OrjU
	 pOOIVoMSequWw1dCDoHvMPyA51SeFol//V5xEIiF7ikAHZn8y/jkgm05sCWmagOpEPlQ8
	 6kIHABadiAfQx3Bph5/niYwP/tUmTfiEMwck6WZkUBtW2lYk5sVqnYAru5JIe358xYcOm
	 B3nv3Rv4ZBub1NlZy71zMc9X0xMC5JC084eFytHj5xbO9frYs/S9fs7caaqFnmbv3eGMv
	 S6OcfMaqXHRk3vo4VOiKnFNHr2VdII2sxfBqUagmHKab0VA6Q/rdXT0qvcX3fXzyRRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494086;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bIGv/nhTaqbLWpQj+w2fP5/8t32IudmW4UzVTxZzMFc=;
	b=A1kZwL7dz+/MQY402RdXLiWOBp8GJFR0QqjIpe3bPNGgfnWtNoAjsdDmcVqf9aPBE0n4
	 o3KvQMKH09eM8cIOH2uJKuggpGbMEFK8o/GxXQJaR08Hpi6jDTNh7ogfEnRXHQbfISG99
	 J+pjDNKn5Nv63x94HO5HBRU2FyxPIaDsviHeOFTMW+9sTeIW3qOWP5hNDfTsOBv9iYs9M
	 37gnKe/HPF3xnRFjm0d58AoHiDp0NW7cAsj2jsBWOj/C/Jc8q9PF2qDZeJGfdG5T0ggep
	 i4m1rd3QPCflxB0VlARFlyFomHvz+wwRj4mw/WvkKT8M590MXlXUX2Yn7jVhWD0iHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxIBiwd9;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE9606A31A;
	Tue, 20 Oct 2026 11:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DAE9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxIBiwd9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792494086; x=1824030086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WJqxCu589AI+TD59k3g3v3r9ySXn6/OYJL/OB2v4Z4k=;
  b=CxIBiwd9PEWi7tbxCv7DT8O3vtv8fggA9XRBqSdggY0zjqutVvW9HV2p
   KyaX8AhZGPQ7Ux+QsAPJvyitUm0rnfzxtyiKy7biq7t0Aj4rQbdjpEu0s
   +X9Y+NZFWnLl5i3d2GPR+/8uFFxq1sa+ZQRZdGM4yjSictvolFBrDEhyO
   LcdAna8FjD9nU/lRJuVgY1h1akNokMFO4VN/yVBMYkIJBw1bg/gNCKPn7
   YNmPwcHWm0dhSdkNeIqs2gp97RBmi7reOqwZvctqL03/HZDLOIiNAHv/9
   CibaRMjGc5RsZvRKNPCrOUpjJlYq2zXHH8366M1IeOWFTlIQXHU/5wUkc
   w==;
X-CSE-ConnectionGUID: vERJ9F2VTqCeLbJQoUgRzg==
X-CSE-MsgGUID: 6X2AVpjcQLqGd5QXtAxnpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1204638"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1204638"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:01:22 -0700
X-CSE-ConnectionGUID: iWEd7grjRNaa5vRx+MzUuw==
X-CSE-MsgGUID: F8Mq7umbRKuFikuw0iesCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2741692"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa002.jf.intel.com with ESMTP; 20 Oct 2026 04:01:19 -0700
Date: Tue, 20 Oct 2026 18:56:26 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com,
	x86@kernel.org, kas@kernel.org, adrian.hunter@intel.com,
	yan.y.zhao@intel.com, binbin.wu@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, nik.borisov@suse.com,
	tony.lindgren@linux.intel.com
Subject: Re: [PATCH v2 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Message-ID: <atdI2mPV8HfcSr0I@yilunxu-OptiPlex-7050>
References: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
 <20261015191710.3632302-2-rick.p.edgecombe@intel.com>
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
In-Reply-To: <20261015191710.3632302-2-rick.p.edgecombe@intel.com>

On Thu, Oct 15, 2026 at 12:17:09PM -0700, Rick Edgecombe wrote:
> The TDX module exposes a bit (CLFLUSH_BEFORE_ALLOC) to say whether it
> requires certain types of memory to be flushed from the cache before being
> handed to the TDX module.
> 
> During the initial TDX upstreaming, it was decided it would be simplest
> to just always flush rather than checking for the bit and having
> conditional logic. So based on the TDX docs:
>   When allocating a memory page to be used as TD private memory or TD
>   control structure page, the host VMM is required to ensure that none of
>   the cache lines associated with the page is in a MODIFIED state.
> 
> ...currently the kernel flushes before handing over private memory and TD
> control structure pages.
> 
> The CLFLUSH_BEFORE_ALLOC bit has never been set by any TDX module, so this
> flushing has yet to be needed in practice. Going forward, the TDX docs will
> be updated to clarify that actually CLFLUSH_BEFORE_ALLOC will *never* be
> set in any future TDX module either.
> 
> So make code even simpler by just deleting all the CLFLUSH_BEFORE_ALLOC
> handling.
> 
> AI was used to review the change.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
