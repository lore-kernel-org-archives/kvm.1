Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E232B13E;
	Mon,  8 Jun 2026 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900785; cv=none; b=duKBYLM19mX0c1UZVJQ+AL/DVshG2A1VmXwqIy34BxtdJ2ZhnSfibkwwHXBkURtADOACcBo3oX86C/rFz7bk6RJAVJngUzcT0MUhINcyZ00pKm028b//zZjiBioTvGKY5S9lBISjFHN8H3F4BEKlBZSyIrdtncFAX0BCwHJ9/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900785; c=relaxed/simple;
	bh=JSZR6YWwP1pjGlAWZNtGwhG442oO6kXXgltFMncpprU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMjlYFHnjrqj+nJ8uzA6/zCnwxFJEmaOFQidC50KN5Hp1dHNaP/zgySxnJGBRKgsWBDFb3W6CvD6AvPLFoA5NR6XZHxbYAdpI1gNiNVdJLyRJtwksqJUaqpPmrzkc3kGqvlxxIb8UV5tbekMuRz4ITeWKfyNtW4RJYO3cIMnehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFzZFwk5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFzZFwk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780900783; x=1812436783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSZR6YWwP1pjGlAWZNtGwhG442oO6kXXgltFMncpprU=;
  b=GFzZFwk5uZV1GYZmplXPgnX0R3pTM9s2FI0fGcqCjDs5NUxg/ObcTn1f
   kgfW/v57Si+AanjMi7y84saylKbrA8vKQGldAb/Mhh56J/tlNAx7nGWAd
   fqbOX+nBvIGdXJTHC5mxjaNOuoI9zBCU2GL8DY46j8GEhlIm/OEgN9hao
   zNf0L5Y2kILRHEA8wwo8a+b/aGb90mYOrmBldZBwA15MAQ7DD7WIf6VZ9
   bRF1LcKq4E7lYrkWUfJHXM90s5RsCZl718H47mnYDXYx6LsaoSnzXA2VG
   STxKOzWpLBV2/SX/5sHH2ievyHiXUvZjhR/u76beU+8w6KfvGykAY89hn
   w==;
X-CSE-ConnectionGUID: KKfk3xwnTY+E4r7M7DCmEg==
X-CSE-MsgGUID: a9vfmogYR8eQp5F4BrmGTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="91954247"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="91954247"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 23:39:43 -0700
X-CSE-ConnectionGUID: e2l6zHFUQeuMY+41Cy5rWg==
X-CSE-MsgGUID: zyNpXL2DRhK/zqOnLvFwcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="283543446"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 23:39:38 -0700
Message-ID: <434e7f9a-5f64-4488-bf9d-5be8c3f9eefe@linux.intel.com>
Date: Mon, 8 Jun 2026 14:39:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/22] KVM: selftests: Expose functions to get default
 sregs values
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-9-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-9-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:

[...]

> +
> +static inline u64 kvm_get_default_cr4(void)
> +{
> +	u64 cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
> +
> +	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> +		cr4 |= X86_CR4_OSXSAVE;
> +	return cr4;
> +}
> +

[...]

> @@ -647,16 +643,12 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  	vcpu_sregs_get(vcpu, &sregs);
>  
>  	sregs.idt.base = vm->arch.idt;
> -	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +	sregs.idt.limit = kvm_get_default_idt_limit();
>  	sregs.gdt.base = vm->arch.gdt;
> -	sregs.gdt.limit = getpagesize() - 1;
> -
> -	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> -	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> -		sregs.cr4 |= X86_CR4_OSXSAVE;
> -	if (vm->mmu.pgtable_levels == 5)
> -		sregs.cr4 |= X86_CR4_LA57;

I guess the 5-level paging thing is dropped unexpectedly during rebase?


> +	sregs.gdt.limit = kvm_get_default_gdt_limit();
> 
> +	sregs.cr0 = kvm_get_default_cr0();
> +	sregs.cr4 |= kvm_get_default_cr4();
>  	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
>  
>  	kvm_seg_set_unusable(&sregs.ldt);
> 

