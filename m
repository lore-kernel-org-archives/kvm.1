Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987A37AA81;
	Fri, 15 May 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829699; cv=none; b=BK8Uo/EaWRERht9l7XKkez81W+OJ/VYH2rhESJ99R/O7tdvUHd1Vobp9SWDhOJYKfG/Rly5RKYQf+y0AFMO4e7SlkyZfEgauY9qF79FuK/1In2yRjn8tIwAAllWMM/LOc6F0AhSGVOO6Nqr3ICFfLHdJsTMasGq0+8gQ1N0Gf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829699; c=relaxed/simple;
	bh=mgpcXY8MpZsAqdbg6wVmZI9RBOOoisAdBW+jsjLBSvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcthH46vwVDqZX6RgSY1Qed98Tp2TxTNAFA6WWlXkKqGAhKc9+1dwzJZTU4y4Mhj0OgLT+CrWEOcqADyFs1KYr+bvxzrgqQC48EBQ0Bliqg/BKGkwD7bBv4qqZcAuUQgEAfAH6PFzwv/HKwZTTLdsJ9Z10jR7r8tKKfPOv79vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCT7nDPL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCT7nDPL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778829697; x=1810365697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mgpcXY8MpZsAqdbg6wVmZI9RBOOoisAdBW+jsjLBSvk=;
  b=kCT7nDPL6XZCcK+8T1f2zR6Vy6uad9ORXpnOtLbvIG0J7rSPzZHHDuN8
   b9VMtr/gaAQDn/fawtEMbVdy0/YtWXGwo1Co5g6N0sGRvZJtz4G6FgjJB
   UhY5OYcZ3b2fGfvhLXhgx6AgnRNgwcyS/Rl4rI3N4/tX0cJ4B1n9ics+T
   CeOJQoSWmGjNBfatuPLH0XOUhUk4Zgq7Dgbr7YB41NRoj96BEKy9XTXIk
   dARsc+b+UFu6rRp5MRnDKntV8y5whuyQ5j4zvKp85VdO0mshaqpzOB3yt
   o7B06FLbsV+4fjgSPUF83C8kTZXQz/U6VYfVFIzhsvZyb/E/qBkz4mQ5U
   Q==;
X-CSE-ConnectionGUID: uAu2a4hfTgilVU6L3SmfvQ==
X-CSE-MsgGUID: Ft6MaqBwQbyvUPUGfOr3EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83638797"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83638797"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:21:35 -0700
X-CSE-ConnectionGUID: T6uPfZ90Re23hn4r9NbY1Q==
X-CSE-MsgGUID: sVfu8f8lQdqQcXAfj4Wc5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238501880"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:21:32 -0700
Message-ID: <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
Date: Fri, 15 May 2026 15:21:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-4-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Don't truncate RAX when handling a Xen hypercall for a guest with protected
> state, as KVM's ABI is to assume the guest is in 64-bit for such cases
> (the guest leaving garbage in 63:32 after a transition to 32-bit mode is
> far less likely than 63:32 being necessary to complete the hypercall).
> 
> Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

The patch looks good to me, but one question below.

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
>  	    kvm_hv_hypercall_enabled(vcpu))
>  		return kvm_hv_hypercall(vcpu);
>  
>  	longmode = is_64_bit_hypercall(vcpu);

Is the variable name misleading?
If the vcpu is in compatible mode (when guest state is not protected),
it's in long mode, but the code goes to !longmode path.

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

