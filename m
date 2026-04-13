Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B22BE03B;
	Mon, 13 Apr 2026 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076610; cv=none; b=oNrIag9tSUPnKpClGoq9hNv4tdMC5HVwAS60JRBlX2oEK65m7u1KawH5Nvuwgvbk9m9lZZvULBfz4TCFqOXaVOt8SG4YaEmGKePzqEN8qK1MPaY46mftt8Ceg+ce4Mm1pZ+Zi0kmxcM1aL22OLDWzMARpfNdqg8Dhi1gim/PvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076610; c=relaxed/simple;
	bh=8IYNUspJP7g1yOCbfehJOYsg0HdaJpYtBJxuMXAYG1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dldskX9ZhR1vGbnMEWdVUAYIivP+95w9DiEv2Yr0sWMu0oeI0wIrJ+VXwmwN/y46yxeEo6d3Mx7cHTRVzpAqZwWkRkJI4EhrGEaJkYFjj2W3E4MQpoPg9Ym+6JrwyjydUfZkmf93mBPsW0/c9iKV0acBT26UO+Ft3x/VG2HjH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlkMbaZQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlkMbaZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776076609; x=1807612609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8IYNUspJP7g1yOCbfehJOYsg0HdaJpYtBJxuMXAYG1I=;
  b=MlkMbaZQbPSnJYfc8durIpjAj0rnCbpPz8ZcbK3qoNWDIIboaGQZAv1+
   0pbNpwDn4mJPqjszOR/vGeQtE7Bp1V4rMSi9qd6MlKT+TQZ6ORmz/h23w
   AUfCzMEgwkUvYiQCkBR8bjvigJW5ITyMta15ft3ShXyACkvuQDEKiDOco
   uVYUwUEpJvY0IBRq4kOxDb8NXL4JsMpdjjB67FMUV68rvFTWhQFCroTeA
   556l+nfDpyhQnfDrG14DEfckyTmSwlO8fbl5Jb7amjUUoTwsicAUUmaAS
   gb9ca0bdD6V6Y1h92MqZiRg7vIjGp1jaYzTzlXifi6ev5ojdnDjzeVypr
   A==;
X-CSE-ConnectionGUID: 4X7e/ybZSL+Gi9+S7TR0IQ==
X-CSE-MsgGUID: DM4ntBBCSCmcp9WYeGHYcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="87303411"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="87303411"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:36:48 -0700
X-CSE-ConnectionGUID: XEQpySpPStiR9sm/miGY3w==
X-CSE-MsgGUID: QLwKnDJsQ9OeNfseHudsrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="234672428"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:36:45 -0700
Message-ID: <38309411-b86c-43cc-8451-cfdf43d84302@linux.intel.com>
Date: Mon, 13 Apr 2026 18:36:42 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
References: <20260409235622.2052730-1-seanjc@google.com>
 <20260409235622.2052730-4-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260409235622.2052730-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/2026 7:56 AM, Sean Christopherson wrote:
> Don't truncate RAX when handling a Xen hypercall for a guest with protected
> state, 

It sounds like KVM supports Xen hypercalls from a guest with protected state
normally, but it seems that a warning would still be triggered by kvm_rax_read() for
checking whether it's a Hyper-V hypercall even after the whole patch set when the userspace
enables KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL for the guest.


> as KVM's ABI is to assume the guest is in 64-bit for such cases
> (the guest leaving garbage in 63:32 after a transition to 32-bit mode is
> far less likely than 63:32 being necessary to complete the hypercall).
> 
> Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/xen.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 6d9be74bb673..895095dc684e 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1678,15 +1678,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>  	bool handled = false;
>  	u8 cpl;
>  
> -	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
> -
>  	/* Hyper-V hypercalls get bit 31 set in EAX */
> -	if ((input & 0x80000000) &&
> +	if ((kvm_rax_read(vcpu) & 0x80000000) &&

Should this function call be replaced with kvm_rax_read_raw() in patch 7/11 if KVM allows the
Xen hypercalls from a guest with protected state to avoid triggering the warning?

>  	    kvm_hv_hypercall_enabled(vcpu))
>  		return kvm_hv_hypercall(vcpu);
>  
>  	longmode = is_64_bit_hypercall(vcpu);
>  	if (!longmode) {
> +		input = (u32)kvm_rax_read(vcpu);
>  		params[0] = (u32)kvm_rbx_read(vcpu);
>  		params[1] = (u32)kvm_rcx_read(vcpu);
>  		params[2] = (u32)kvm_rdx_read(vcpu);
> @@ -1696,6 +1695,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>  	}
>  	else {
>  #ifdef CONFIG_X86_64
> +		input = (u64)kvm_rax_read(vcpu);
>  		params[0] = (u64)kvm_rdi_read(vcpu);
>  		params[1] = (u64)kvm_rsi_read(vcpu);
>  		params[2] = (u64)kvm_rdx_read(vcpu);

