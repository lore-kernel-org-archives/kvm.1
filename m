Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243419;
	b=t1piXUZaj1uj6ZD+HQwjbglOWEjQc5BrHsgWD8tidCmFa+uhHyvuOFFNxMtxyY/lfJpB
	 Ah8jeaJt2JP0ddNI8vB5bB7DnU+mMMYNbHLD31capUq1LnvlEF03FYT30Z3vu5y1pWNcd
	 hj/u9krMc2FugdWPD2hXpx/FFzcy3Sqb/NX7Fd+KGn/4bhyZNhVydlDW/gZBB0SguI96G
	 BVhb/oL26ZIxxL6VY3xl1XQB0xE53FzB4Z+58O12ndbGE7FF8gLmwJxfJX1Je+sKC0K0A
	 b9n8fD0LlOtfFPL/uSYCC7406BHYVXNCpfdbdy1eHpGORt1rhrsNYHgMbiQF/OpB6pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MLa59GNuE4juE8aN6EX7h5PeHDU2LrSedK/KeGwmNGM=;
	b=Rf/sSiTFP46ozsKcQFDn6fgXHgLUEyBEKVr+AYFog/atJXr/Kq1PwKDVyebuZGHHxNhV
	 oqNffcWsosLbr8JfpE4kW8CUjJa3rRpSQLx3f7VeW78iUCW1vgFZswWf6tZWrI5Eqp1M8
	 D09LGfnQ3uK8o+OFBvTsogEnUprH0dC+k2LPE0tcIaSb031x2UgXmkT9mT4121kJsXaln
	 kYr2J0Oszjek4y2yC9xTC1j1HH/tB3CNryyFJleHff2lPgj87sXrUggcGW9UGmwkBxljy
	 RU48Uz744F8WPA5hz5/uYDXBYOtCdv1l7a6rsTgILO/rgYC0xHNG5QKcaK/yCyoiOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K7bZGsuf;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C73606A31C;
	Thu, 29 Oct 2026 03:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C73606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K7bZGsuf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793243419; x=1824779419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ceg5b+r+S6lzEGiE3ja6DSXp3wyBHztec6OG3XWuy30=;
  b=K7bZGsufPYXYw1rnk8s0ShY2yIVprgR/0AfrwgQ8azefK55uauxFoVwl
   bMD7l480sCWjp70P9Z4jItrMHPtY0JdYnQIl5jsE96ViJun5W4tDtroKK
   Hrf+jyY33E54BbzuuJGI967D0pZ71fnFa/fd3VJIW7f59Y27vSIwbBmXm
   gVlizgNSVH5XuIqlxoJAWYvBHhfJrsintjNUfQHoBvAaaEByu41BPI8MW
   4w+Dykp59/I8ZZIrzyq1Dx9PyUo9qu8lfW2BGfgR84Rn26UIXK+2M6PJ1
   ZY5k02rWsAepSta7GKjHMCajDxQw+wibAs3vRv6x3/VYYyb7/cvRhBzrq
   g==;
X-CSE-ConnectionGUID: K5oOxdmDQMykITNdBiA6dA==
X-CSE-MsgGUID: dqce/ISjS1qhJ9vOP2cn4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1865185"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1865185"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 20:10:17 -0700
X-CSE-ConnectionGUID: rH0eiIP9TJSNft78hODM4g==
X-CSE-MsgGUID: uO8hNBAuTECKIyqLspmhMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5136821"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 20:10:11 -0700
Message-ID: <dce3875c-d590-4539-b19a-324cbfa6d4e9@linux.intel.com>
Date: Thu, 29 Oct 2026 11:10:09 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/28] KVM: x86: Add a new save/restore flag for FRED
 metadata
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-13-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-13-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: Xin Li <xin@zytor.com>
> 
> Introduce a new save/restore flag for FRED metadata (specifically, the
> event nested flag and data) being saved and restored during VM save/
> restore and live migration.

Nit:
Would it be more natural to move this patch after patches 13 and 14?
The commit message and the document reference changes introduced
in later patches.

> 
> Signed-off-by: Xin Li <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v10:
>  - Advertise KVM_CAP_X86_FRED_EVENT only when KVM can virtualize FRED, and
>    return -EINVAL from KVM_ENABLE_CAP otherwise.
>  - Document the new return value in api.rst.
> ---
>  Documentation/virt/kvm/api.rst  | 22 ++++++++++++++++++++++
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/x86.c              | 18 ++++++++++++++++++
>  include/uapi/linux/kvm.h        |  1 +
>  5 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 4eb7e75a7473..22ef94f3eb3a 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -1199,6 +1199,10 @@ The following bits are defined in the flags field:
>    triple_fault_pending field contains a valid state. This bit will
>    be set whenever KVM_CAP_X86_TRIPLE_FAULT_EVENT is enabled.
>  
> +- KVM_VCPUEVENT_VALID_FRED_STATE may be set to inform that the exception
> +  state includes FRED state (specifically, the event nested flag and data).
> +  This bit will be set whenever KVM_CAP_X86_FRED_EVENT is enabled.
> +
>  ARM64:
>  ^^^^^^
>  
> @@ -1301,6 +1305,11 @@ If KVM_CAP_X86_TRIPLE_FAULT_EVENT is enabled, KVM_VCPUEVENT_VALID_TRIPLE_FAULT
>  can be set in flags field to signal that the triple_fault field contains
>  a valid state and shall be written into the VCPU.
>  
> +If KVM_CAP_X86_FRED_EVENT is enabled, KVM_VCPUEVENT_VALID_FRED_STATE can be set
> +in the flags field to inform that the exception state contains FRED state
> +(specifically, the event nested flag and data), which shall be written into the
> +VCPU.
> +
>  ARM64:
>  ^^^^^^
>  
> @@ -8979,6 +8988,19 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
>  interpretation are disabled. If cmma has already been enabled or the
>  hpage_2g module parameter is not set to 1, -EINVAL is returned.
>  
> +7.48 KVM_CAP_X86_FRED_EVENT
> +---------------------------
> +
> +:Architectures: x86
> +:Parameters: args[0] whether feature should be enabled or not
> +:Returns: 0 on success; -EINVAL if KVM cannot virtualize FRED.
> +
> +With this capability enabled, KVM allows exception save and restore operations
> +to include FRED event context (specifically, the event nested flag and data).
> +When injecting a FRED exception during VM entry, FRED event delivery relies
> +on this information to select the correct event stack level and apply proper
> +event data.
> +
>  8. Other capabilities.
>  ======================
>  
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 0fd5d4edeebb..dd68db17fdae 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1286,6 +1286,7 @@ struct kvm_arch {
>  	bool has_mapped_host_mmio;
>  	bool guest_can_read_msr_platform_info;
>  	bool exception_payload_enabled;
> +	bool exception_fred_state_enabled;
>  
>  	bool triple_fault_event;
>  
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 1585ec804066..6a67832c59bb 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -331,6 +331,7 @@ struct kvm_reinject_control {
>  #define KVM_VCPUEVENT_VALID_SMM		0x00000008
>  #define KVM_VCPUEVENT_VALID_PAYLOAD	0x00000010
>  #define KVM_VCPUEVENT_VALID_TRIPLE_FAULT	0x00000020
> +#define KVM_VCPUEVENT_VALID_FRED_STATE	0x00000040
>  
>  /* Interrupt shadow states */
>  #define KVM_X86_SHADOW_INT_MOV_SS	0x01
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4b3681796c75..01198aba27cf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2288,6 +2288,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_PRE_FAULT_MEMORY:
>  		r = tdp_enabled;
>  		break;
> +	case KVM_CAP_X86_FRED_EVENT:
> +		r = kvm_cpu_cap_has(X86_FEATURE_FRED);
> +		break;
>  	case KVM_CAP_X86_APIC_BUS_CYCLES_NS:
>  		r = kvm ? kvm->arch.apic_bus_cycle_ns : APIC_BUS_CYCLE_NS_DEFAULT;
>  		break;
> @@ -3022,6 +3025,8 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
>  			 | KVM_VCPUEVENT_VALID_SMM);
>  	if (vcpu->kvm->arch.exception_payload_enabled)
>  		events->flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
> +	if (vcpu->kvm->arch.exception_fred_state_enabled)
> +		events->flags |= KVM_VCPUEVENT_VALID_FRED_STATE;
>  	if (vcpu->kvm->arch.triple_fault_event) {
>  		events->triple_fault.pending = kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>  		events->flags |= KVM_VCPUEVENT_VALID_TRIPLE_FAULT;
> @@ -3036,6 +3041,7 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
>  			      | KVM_VCPUEVENT_VALID_SHADOW
>  			      | KVM_VCPUEVENT_VALID_SMM
>  			      | KVM_VCPUEVENT_VALID_PAYLOAD
> +			      | KVM_VCPUEVENT_VALID_FRED_STATE
>  			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT))
>  		return -EINVAL;
>  
> @@ -3051,6 +3057,11 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
>  		events->exception_has_payload = 0;
>  	}
>  
> +	if (events->flags & KVM_VCPUEVENT_VALID_FRED_STATE) {
> +		if (!vcpu->kvm->arch.exception_fred_state_enabled)
> +			return -EINVAL;
> +	}
> +
>  	if ((events->exception.injected || events->exception.pending) &&
>  	    (events->exception.nr > 31 || events->exception.nr == NMI_VECTOR))
>  		return -EINVAL;
> @@ -4038,6 +4049,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		kvm->arch.exception_payload_enabled = cap->args[0];
>  		r = 0;
>  		break;
> +	case KVM_CAP_X86_FRED_EVENT:
> +		r = -EINVAL;
> +		if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
> +			break;
> +		kvm->arch.exception_fred_state_enabled = cap->args[0];
> +		r = 0;
> +		break;
>  	case KVM_CAP_X86_TRIPLE_FAULT_EVENT:
>  		kvm->arch.triple_fault_event = cap->args[0];
>  		r = 0;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 9fc8dfdfd65f..c5ffc4e7ddb1 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -998,6 +998,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
>  #define KVM_CAP_ARM_PMU_V3_STRICT 250
> +#define KVM_CAP_X86_FRED_EVENT 251
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;

