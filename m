Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562786;
	b=CKOY/2yUWZMHo/eYFluHv2OF2mmwx/2Oxa2/tbDtMUmmx+6kaYhIU38MVPGaSQRVZYa9
	 LaOToN5ilrs8930Wg26rpDgaPdjveNEINdMM4KMVXkGfG4dlw4Eg9jn3sNDZVjKGVDXl7
	 gZFXLuBsYWv8951fvzHnuxlRnsjfmRhRyN6S0mx8inlq3lDyQKSyFqnhNogsrzO41jC7F
	 uI/G3FqmALVZpOv4Bn//I/t7Qil+Hdh+jI1W1oeqemlDekTF2vOGWCQDE03Ij1ZXLAn2/
	 5a4S3WoxIA1eAJglDXLYt7wNTGGW7txgSz0uWGNAujbC1f5Pl4BxC4Ema4g9+DS2lSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562786;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1aMYR07iulX/q2HjmPhnjor6ImYvEJ4db7QZjz9vL2k=;
	b=rr4dOm3S2gcicPMg61gc3ONRWETbiUOmoVkLJ14KnW97I1BHeB65YHmaOBHgt/lxuaX2
	 7eunZgbivr0QYeEqJ8ajdmoIr1E2rPKRcodtdaut64AUMUy33/dFL4t0DzSal/4KxkKHS
	 wFmN4OHZEyjoUWlNkQTsAeftLufUs324KHLnR668KFZ6KybWEOuIjVL80TlzdW9ylIkGK
	 BX7l4cQIBVk9yYyBLWT9u2jkeLbM8pK4uZaP0Bm8uR70woO0GkSGdL/f5/ytS6JHwPxQB
	 SxZCHHmwY9dtBdoALhZE82MnSuervwWcHHjOiJCij0nZlvtZSTZFAZG+gm7ZI/Mo35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YVVx8dDG;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A70606A32C;
	Tue, 24 Nov 2026 23:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A70606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YVVx8dDG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795562785; x=1827098785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XudFIJ4qjIRGp+5BoEx7/NsN5wwOqLkOlqRH3VosJIw=;
  b=YVVx8dDGC9viDI7gbw5t6znw1lkktI81dwMVa1902zVS+v/+dCz/0XoK
   jes49YdigeEdcMWJo2y7p6XUzbP/gClcHE7PLZi4RLAbj/ZBohqAffHSJ
   66Cs0lnIKqt5nvB2oLZMH1dyyGAKxOSwOhYD4F8V6dRKtyOyZRI2wEIgX
   t8Q9vUGl0CfXkl3gQsGlbgHSTDHSBzkGO3mpWKt8+TMPGRkMh6HRlTM98
   ExwGCZnG2Pl3qGJWXnxBD+2uYAlE8XbDZOa1aWBUWOd7XtJWrQaeqGi6G
   wnhNeYPGfUQ2IAfs5Fs541uTF2Rvsjqx6dRcFZUkFfJorU8eEZTRD8waN
   g==;
X-CSE-ConnectionGUID: iqjE76xiTwClah/Clf41Rw==
X-CSE-MsgGUID: 2Of5lzrpQdix7yNx3ARNLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4351824"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4351824"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 15:26:25 -0800
X-CSE-ConnectionGUID: /cz2aPxkQE6eN2WNsqR0tg==
X-CSE-MsgGUID: GJsUReGxSiqXGLo7vrAdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="13483793"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 15:26:24 -0800
Date: Tue, 24 Nov 2026 15:26:16 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: seanjc@google.com, pbonzini@redhat.com, brendan.jackman@linux.dev, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amirmohammadeftekhar@gmail.com
Subject: Re: [PATCH] KVM: VMX: Don't disable FB_CLEAR when doing the MMIO
 Stale Data VERW
Message-ID: <5mzyxsk3mwmalhaf4ep563cirvdjiu5g6phuz7l4k5p4z4qjok@36kzwzaumhzn>
References: <20261124180613.1693632-1-amirmohammad.eftekhar@cispa.de>
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
In-Reply-To: <20261124180613.1693632-1-amirmohammad.eftekhar@cispa.de>

On Tue, Nov 24, 2026 at 07:06:13PM +0100, Amirmohammad Eftekhar wrote:
> Don't set FB_CLEAR_DIS for a VM-Enter that does the MMIO Stale Data VERW.
> VERW doesn't overwrite the fill buffers while FB_CLEAR_DIS is set, so the
> buffer clear that is meant to protect the host from a guest with access
> to host MMIO currently does nothing.  Keep using FB_CLEAR_DIS for vCPUs
> that can't access host MMIO, which are the guests it was added for.

Thanks for the patch, the problem is real. I believe the affected use case
is a guest with MMIO device on ICX, and none of MDS_NO/TAA_NO/FB_CLEAR
exported to guest.

...
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 68fa251dda60..490cad070c13 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -482,11 +482,24 @@ static const struct kernel_param_ops vmentry_l1d_flush_ops = {
>  };
>  module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, NULL, 0644);
>  
> -static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
> +/*
> + * VERW doesn't overwrite the fill buffers if FB_CLEAR_DIS is set, so leave
> + * FB_CLEAR enabled for a VM-Enter that does the MMIO Stale Data VERW.  The
> + * unconditional VERW is already handled by vmx_update_fb_clear_dis().
> + */
> +static __always_inline bool vmx_should_disable_fb_clear(struct vcpu_vmx *vmx,
> +							unsigned int flags)
> +{
> +	return vmx->disable_fb_clear &&
> +	       !(flags & KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO);

This doesn't seem right, FB_CLEAR_DIS's main use case is FOR_MMIO.

The ideal fix would be to set FB_CLEAR_DIS after VERW in KVM-entry. But,
thats quite late in the entry path, moving the MSR-write past that is
non-trivial.

I believe it is best to restore the earlier order just for the MMIO case,
i.e. do VERW for CLEAR_CPU_BUFFERS_FOR_MMIO before setting FB_CLEAR_DIS
like:

vmx_disable_fb_clear()
{
	if (!vmx->disable_fb_clear)
		return;

	if (flags & KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO)
		x86_clear_cpu_buffers();                    <-------- here

	msr = native_rdmsrq(MSR_IA32_MCU_OPT_CTRL);
	...

Sean, would you agree?
