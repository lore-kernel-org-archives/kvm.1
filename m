Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D02E737E
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435038; cv=none; b=l1j0l0+n++gO8ZoZFrdekxf4RE/IiCGY6vf5qOnt7vADrhO1Jjm/is5kWAGk0BRq+tmQX4Ct5oFFBeqisradLYJKZRxvYeCMurIhisLrQr085d9txqXXrW10YVqxTdybg2HGgoERMtIayfGxILUqrSOSHIkT3HkZ1MLIH081+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435038; c=relaxed/simple;
	bh=Z76tiW69ipyaA7hRTqZ4bVGpxzBDDtQECbj3RvxDu+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS3lPV1fJ8aRiyoDXL7VyWy9NzU/Mm+vFqlNSmpj4DdL3Ezz46jRTW3gWXcji83NJgNhdXhAtKSoIu9+bnf+Qz9hTEm0ZZjSicaUNIWAsbmann9JGQOndCnGkmxX7uj99xpNJlNimm8RAD2hEGnqHSPm6sq59gIEB/s/TYenE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvewzRkk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvewzRkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791435037; x=1822971037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z76tiW69ipyaA7hRTqZ4bVGpxzBDDtQECbj3RvxDu+s=;
  b=EvewzRkkzBpnsnVFB6Auzu3wjGrvK/6ldgFuwmsRDNV0+MmPfIr3af/r
   oVnuOes9ViKrozQmNjqIImIWDBPU1rQ7FweIItYbnfTZ+ub8Et6XF3FL7
   0yiYy8n2Rb/gyEEEC5SajFh1o99X5djcCv5tWQSnIWTCVghcDphr9kgGk
   wHCD4YNyTjj6suwpmRa1h5AwIWLxXzSBLc4MJsWnA7Zn5fJIejefBDZGf
   lDVwhD8RSoizU7OsQCvT1bTeP/PlwJv2MoGLfoAe/vVXtlK1zkhHMOx7O
   Hu1Vn6pLAPCUJATtFfj5shvkOdForHY22pOpxgxPQWKPArbAAVJrEF5+4
   g==;
X-CSE-ConnectionGUID: +Hb9DVP+TUK3a7lhltUZdQ==
X-CSE-MsgGUID: QNXNbL0FS5GSLdBtloOfUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="318300"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="318300"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 21:50:36 -0700
X-CSE-ConnectionGUID: fNpJ04j5RJWA6rtcUMOb+g==
X-CSE-MsgGUID: AhCmGqyDRGG4n8yBDMJ2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="10626"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2026 21:50:35 -0700
Date: Thu, 8 Oct 2026 12:47:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <ascgXatheZH3WYqe@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
 <20261005175840.1F2D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005175840.1F2D81F000FF@smtp.kernel.org>

On Mon, Oct 05, 2026 at 05:58:39PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] virt/tdx: stale boot metadata breaks TDX extension initialization
> --
> 
> commit c0a5cf03ba530712949cf538278d0905890ebf56
> Author: Xu Yilun <yilun.xu@linux.intel.com>
> 
> x86/virt/tdx: Re-initialize the extensions on runtime TDX module update
> 
> This commit introduces a mechanism to re-initialize TDX module extensions
> during a runtime update. It intentionally skips memory reallocation, expecting
> the TDH.EXT.INIT call to fail if the updated extensions require more memory
> than what was originally allocated at boot.
> 
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> 
> [ ... ]
> 
> > +/*
> > + * Don't update the memory requirement metadata or try memory allocation in
> > + * stop_machine(). If an incompatible update requires more memory, let the
> > + * extensions re-initialization fail.
> > + */
> > +static int reinit_tdx_module_extensions(void)
> > +{
> > +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> > +		return 0;
> > +
> > +	return tdx_ext_init();
> > +}
> 
> [Severity: High]
> Will this logic use stale boot-time metadata to skip a mandatory
> initialization step for updated modules that introduce extension support?
> 
> reinit_tdx_module_extensions() unconditionally reads from
> tdx_sysinfo.features.tdx_features0. This struct is populated during boot
> initialization.
> 
> If an administrator installs a TDX module update where the new firmware
> introduces extension support, this check will incorrectly evaluate to 0 and
> skip tdx_ext_init().

Skipping tdx_ext_init() is fine, cause we didn't enable/use the
extensions at boot-up and we shouldn't enable/use them after update.

> 
> When a new module adds extension support, it transitions to a pending
> initialization state after TDH.SYS.UPDATE and explicitly requires
> TDH.EXT.INIT. By returning 0 (success) here, the kernel proceeds as if
> the module is fully initialized.
> 
> The hardware is left trapped in an intermediate state, which will cause all
> subsequent SEAMCALLs to fail and active or new TDs to crash.

No, the basic TDX module functionality can fully work without extensions.

> Conversely,
> if an update removes extension support, the kernel will incorrectly attempt
> TDH.EXT.INIT and fail the update.

This is the incompatible update. Failing it is the intended behavior.

> 
> Should the kernel dynamically read the new module's feature bit via
> TDH.SYS.RD after the update to accurately determine if TDH.EXT.INIT
> is required?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com?part=5
