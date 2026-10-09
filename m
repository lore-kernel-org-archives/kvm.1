Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27C38E12B;
	Fri,  9 Oct 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532977; cv=none; b=Bzih5/fPB0nPaNU/smlqMqal1Ct+/21O1VP+86wtbyHvdPx61rhZGB17rpsTzNTuFwvEk0JRKE//L2KEdvEHPbUxVoqWyknSuH3QJmycQNjNvuCdxaEFlGbshuinC3H7cxk4j//hh0M8SSLWNRWReYiSzN7QBfNnBLPLfOuvTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532977; c=relaxed/simple;
	bh=K0Rujk12uAeKYeS3MopyyDkqIWwp9f+QzTngzNoCAWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8svlbdlGfkBgymV1tFfR60ppvzzNE7dXmkBUL/1pB1RvyRptwIrifzUB1WwUhgmwpEi5J0F+86Meia6ZPQirSOAAV9PkhYpZCGhGagAuplUC6ay06dflaz+3qM0v5Hzj2oEc20QvYjz+LB0r/X+MunhWOhZbBcH4a7oQldjlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3abN+T0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3abN+T0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791532975; x=1823068975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K0Rujk12uAeKYeS3MopyyDkqIWwp9f+QzTngzNoCAWg=;
  b=i3abN+T0AP3DhVLk2j8Ucw3hgI4VoVy7WBm/JZY5Afkx3xEJFTeqkteo
   mT3Y9901QrqM8u2LgfMlG0e7jViW2ZQWIfWzbDGdsj2f6Ur+4E+FehhUD
   oATVrXHEaagc1BdOtQ8aaAvaHT0vnp338L+YDKNVjbcm/5liBLZX0DNF/
   jJ/jXyaZvmW02QAf2lBTe19jq9G9XTMGHVjkEOy3OuEHXdG5he4J+x9Rz
   qzcfKqVGf58L53xWMqxLozb0LKKGmibXDh3GrW/I/YJoLiA+5yiF9haw1
   0lTX44I15okarMazyCJLJFjMTxAiK3d1+TrXnlDlRt8NohEJTaPmsZI+O
   g==;
X-CSE-ConnectionGUID: 2f89ipiVQa22o3zAN/AKtw==
X-CSE-MsgGUID: eqzGHS2XS9OlPc4RATZGCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="224327"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="224327"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:02:54 -0700
X-CSE-ConnectionGUID: wSz6PIOQSKmk9kFJq0Hu6g==
X-CSE-MsgGUID: EjOPerSgTzyC0rzXyiu/TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="201120"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:02:46 -0700
Message-ID: <59ec42fd-56db-47e4-a4e1-632b692cf60e@intel.com>
Date: Fri, 9 Oct 2026 16:02:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 15/23] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-15-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-15-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
> +{
> +	struct kvm_mp_state mp_state;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_regs regs;
> +

rebase mess up due to the previous patch.

>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
> -	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> -	vcpu_init_sregs(vm, vcpu);
> -	vcpu_init_xcrs(vm, vcpu);
>  
> -	/* Setup guest general purpose registers */
> -	vcpu_regs_get(vcpu, &regs);
> -	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = kvm_allocate_vcpu_stack(vm);
> -	vcpu_regs_set(vcpu, &regs);
> +	/*
> +	 * Both kvm_get_supported_cpuid() (for legacy VMs) and KVM_TDX_GET_CPUID
> +	 * (for TDX VMs) return VM-scoped CPUID. e.g. the APIC ID isn't
> +	 * populated per vCPU. This is fine because KVM selftests don't
> +	 * currently test CPUID topology enumeration.
> +	 */
> +	if (is_tdx_vm(vm)) {
> +		tdx_vcpu_init(vm, vcpu);
> +	} else {
> +		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> +
> +		vcpu_init_sregs(vm, vcpu);
> +		vcpu_init_xcrs(vm, vcpu);
> +
> +		/* Setup guest general purpose registers */
> +		vcpu_regs_get(vcpu, &regs);
> +		regs.rflags = regs.rflags | 0x2;
> +		regs.rsp = kvm_allocate_vcpu_stack(vm);
> +		vcpu_regs_set(vcpu, &regs);
> +	}
>  
>  	/* Setup the MP state */
>  	mp_state.mp_state = 0;

