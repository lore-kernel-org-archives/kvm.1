Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1714201278;
	Tue, 22 Sep 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043190; cv=none; b=tjxrLnQQHTaI0BXNjPibiNZ+l8tiW+iSIDNIGjmE+kSqJQljdcVaTkjbAoxxb0XQfNCTJJ4XqfB50R0bMcv43JSjs/21MJa/0s/cUR/77NZps0QDjmpZkcIAxTyeZEGtKwpmX2urnUnVjXU0slKsaD6pof1fzigF2xDwA7KjasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043190; c=relaxed/simple;
	bh=MWdlY+uGG8yD79147C8VttozeTqIra4ztcFEY3Z3YKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxvRRVQuXbqFX23jmEji3+ZFax9G5a1L+f1W5v0oL8EFEgIx+K6NPryWL2tesQos3btTTg/f1cWoo5FHXPiuHZaYfYLxh7syWAzyMSl8hJ2Oq9efC+i5bb9xAmJTUfobCXwLw0GYGjjGzH+42z/9Qi7URaWoWa7sP8/Vm+HApd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMkOO2ih; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMkOO2ih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790043188; x=1821579188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MWdlY+uGG8yD79147C8VttozeTqIra4ztcFEY3Z3YKs=;
  b=kMkOO2ihSgGHeMGw2Hk3fg4oXJqCz3VLZ8YKwWk15hhGtsWQr1A3zf1z
   x8AaR2ZjXrdcvbs/VNJ4k7k72Iv2LaGxO2DUGiGub5AYOXrgzG2/hH/hJ
   g9r/kGS4g7b+0R6ivjajqiuSRqd+XRH1DHSbmipSqtXPsbHQpM9Zon9bk
   JmF+Nw9aR3+YAQFCCg/aevsiKN59NghjlooHnuYQC+hTmNHLwRgTKOGEb
   gIBpy2WmwA9DM5G1GM1ah8OpEUEOt2Uz1rt2MD1jAtMciJKI8NekU5GRI
   YKa1uRbd6s9PzienX9D2qYdYktcxFdRbGrajp+BygqgG36vRbyRUs8XKc
   w==;
X-CSE-ConnectionGUID: 9NCnzin/Sw2E+rGYb2XCyQ==
X-CSE-MsgGUID: RYVfAFLYSyqAvIxz8hxeXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1113339"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1113339"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:13:06 -0700
X-CSE-ConnectionGUID: sZSDNPtRTQOC4RlkQ00MfQ==
X-CSE-MsgGUID: Ic7wktafSeq3KJgk4b9T9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272113751"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:13:04 -0700
Message-ID: <14db958c-be80-4a91-b79d-1775fc058daf@linux.intel.com>
Date: Tue, 22 Sep 2026 10:13:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used
 for failed VM-Enter
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260921235656.1107929-1-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260921235656.1107929-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 7:56 AM, Sean Christopherson wrote:
> Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
> to stuff the exit reason on a failed VM-Enter so that the magic can be
> reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
> defined value (though the whole "dead" thing makes it pretty darn obvious).
> 
> Opportunistically add a compile-time assert to ensure the KVM-defined exit
> reason never collides with a "real" exit reason.
> 
> No functional change intended.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/include/asm/vmx.h | 8 ++++++++
>  arch/x86/kvm/vmx/vmx.c     | 4 +++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 3f1b3096ff04..e49b836c7313 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -20,6 +20,14 @@
>  #include <asm/trapnr.h>
>  #include <asm/vmxfeatures.h>
>  
> +/*
> + * UNDEFINED is a KVM-defined value used to indicate that the basic exit reason
> + * is undefined/invalid, e.g. on VM-Fail or if TDX never attempted VM-Enter.
> + * The value itself is arbitrary, it just needs to not collide with a real exit
> + * reason.
> + */
> +#define EXIT_REASON_UNDEFINED			0xdead
> +
>  struct vmcs_hdr {
>  	u32 revision_id:31;
>  	u32 shadow_vmcs:1;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 612ab07d4100..c897dbf0e954 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6388,6 +6388,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  static const int kvm_vmx_max_exit_handlers =
>  	ARRAY_SIZE(kvm_vmx_exit_handlers);
>  
> +static_assert(EXIT_REASON_UNDEFINED >= ARRAY_SIZE(kvm_vmx_exit_handlers));
> +
>  void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>  		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
>  {
> @@ -7474,7 +7476,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  	vmx_enable_fb_clear(vmx);
>  
>  	if (unlikely(vmx->fail)) {
> -		vmx->vt.exit_reason.full = 0xdead;
> +		vmx->vt.exit_reason.full = EXIT_REASON_UNDEFINED;
>  		goto out;
>  	}
>  
> 
> base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94

