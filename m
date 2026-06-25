Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4E24CEEA
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370874; cv=none; b=Ja9G0NytH2fJFMJ8wV9BZD+8c+r1lFcKOhbiOwcNH61xdgDZvwkCyG8p5xgEWcwUhDgOEKgheuwU+swphawqNkZroGPXOsESEYY8sic3HzrXQ+ndnA0OCE0xfJeTjHE2jC9w3czlgU5FBsnTa7mx3u9QjYPPCsUP/FWaBitmRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370874; c=relaxed/simple;
	bh=FrJ+LoUd6SBQpLfHYdEsasboBY+X3lvEa8doR43M6/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtRlLjR+k1Wpu6ZOlnu5QUX15KpdoKVm6GxVv7YMAWQhaI7jsAsw+uConVqCNHbarlg8vMJhTFyMWr0hgikxNPLb900Hlkk9+/+rTcOhe6vgVZG/QaBIp9bgiijUoZbl6mPuSZGh1XAKVcOBJrezePqoNFtuj48lavO2lacfB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIrypn0z; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIrypn0z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782370874; x=1813906874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FrJ+LoUd6SBQpLfHYdEsasboBY+X3lvEa8doR43M6/o=;
  b=GIrypn0z/CNsuV7X9iHbJrD6k/fQ6mhdKzTv2lkUchfFJ19Lf48GqHGs
   hbLJHALIrvOY31MNR6/c7REk28qj7t4s+4HU5lXvQG00qUXLuAa/y1wMP
   or5nYa2/cTa4OQb7NRfRvASysNS0Tn+GtjDGvOiM3EvbBik77qM4z/a21
   z+BwVGELKdiVi9dXanQV4Wv/mOBu2UgBD3yvfLUCY2HhjonldipO3O5mK
   emPxUwgOCYgFsEZtMw4rp+nM9Hm/Er5wCdCYQKVTOyIpHOyLNSSXlHyBj
   mItW2MFoATt8wjLjCV7gCUi0t4xyt0MjgiWF4hplCc89B4QT2jXZyUF6Z
   g==;
X-CSE-ConnectionGUID: iUEoq3moRAGlXv1S5STaLQ==
X-CSE-MsgGUID: kx3cmfAkSwSKdnrTIYPVqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82261075"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="82261075"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:01:13 -0700
X-CSE-ConnectionGUID: JFe2EMe8RviKcwVQkYVERg==
X-CSE-MsgGUID: sG7MqyM+T/ihlXZ1WaQC5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246422616"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2026 00:01:12 -0700
Date: Thu, 25 Jun 2026 15:01:11 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <ajzSNyvVsvPzs/94@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
 <20260618085835.98A041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618085835.98A041F000E9@smtp.kernel.org>

> > +	return tdx_ext_init();
> 
> [Severity: Critical]
> Could this result in an infinite loop during a runtime update?
> 
> The tdx_module_run_update() function runs under stop_machine(), meaning
> local interrupts are explicitly disabled. When this calls tdx_ext_init(), 
> it executes the following polling loop:
> 
>     do {
>         r = seamcall(TDH_EXT_INIT, &args);
>     } while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> If an external hardware interrupt becomes pending during the update, the TDX
> module exits to the host and returns TDX_INTERRUPTED_RESUMABLE. Because the
> host CPU has interrupts disabled, it cannot service the interrupt and simply
> continues execution.
> 
> Does this mean the loop condition evaluates to true, immediately re-executing
> the seamcall, and permanently deadlocking the system?

No, According to TDX module SPEC [1], 5.4.1. SEAMCALL Instruction (Common),
RAX[bit 24] == 0 shows "Pending interrupts are detected only if the host
VMM’s RFLAGS.IF is 1."  Linux now doesn't set this bit for any SEAMCALL.

That means SEAMCALLs will keep on executing if host disabled interrupts
so will not deadlock the system.

[1] https://cdrdv2.intel.com/v1/dl/getContent/795381
