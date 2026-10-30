Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341616;
	b=5ol1AMmTYJEMBmqmIz+DbfqeUCYiUFX1pdYzqFBhlEdkQXIl+B6uwUrANohWEEwRxSFQ
	 ZAWAKRMCvhGZ6WtPtBn5dpmxuvtcw/Rt3Od2oIYyc/1An/iEd3NA2VYwa0V0dt2+o3Red
	 f7SJnUzuIRmzDcZL+cxwlWotwr6Obu+qlBccB31kglYMkJqE/rCvetLQYRuyhL8LJiZFC
	 fhtAcAqZ7MF/hA7OXhDS5JVYii20DjIsaXV88/SAvYChNqeL1JP0q2RsV7BE8+RSuFjkb
	 pKyJDCWxAfxSbklUTyOp1qM6Qtxsj88bE4R8P8sqfkjwKVWYg/v5WQXb3DDIn9yc52A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341616;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JhYw9FXiZxPgqbrRz8FwW05sr+6zeX/Zi44jK4zh720=;
	b=I9UOukFuv1TGe27Zg6U0C45s339YrVikINeDrJmltWdO9XM23RwnFdbKJZFTfOEVJ3J7
	 ASemmpZYjlj7w+WogBZ+Kig3CuVcKFdoocBYGRpPjA7PIi3E6awcQuE6OHmSPc9rkGyYd
	 ry0Oi6a9TEUEz6VNl8ra6Xbi21kLfED7KSFbcQXrrgiZMFjaCx4RrVUGZhMjZmoKQLHLk
	 tFHDLgmbVNfX0l7arHUoPKxYRM6HcJPe3kk+0fJ0dnulla7BFJ9UNs100bS1LE45fewvV
	 CbP4Fcw6kdG+vB8hTTmkU8mpumnqaucgUICsHBqwhy0Is1iNwNNBXbWwR8dFeKIjUQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DVe9g82l;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6C606A325;
	Fri, 30 Oct 2026 06:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE6C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DVe9g82l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793341615; x=1824877615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s7eqgc/SI1p9gYahWBt/ttGTws+dbHZkxYII3GftDTc=;
  b=DVe9g82lHVrCRAFvUgpWOiYjVHyRCz//SF4Z+udQt6LP0RKvmtCE5hTs
   mKiH2EZ610DBu/zrCvANx8au4Q/sT5rIe1agXZX6Vh+XIC6MRbxGAOVoS
   6M+dbqEKfRdyDin62x7WBIlRzIZmhqENjpdM96vopw0PSP7BDH3MDNG1g
   nmNqOsHBwhryj0ksLUFWJn8zTNGa3vqwrbGh3wD109P+cK05hEGgXcndc
   d5/wdED+EX3skz1tDaS69LCAOnp58HwTyzyRlurz3HVt5T03yFlVv252Y
   9g/SFVMj4RLEPTcECxJXs32D/M1lju/BwCquVnpGBZ7AvKsmaygZra4rR
   Q==;
X-CSE-ConnectionGUID: sjm9i6OnQ+q8ZCOLiPt+SQ==
X-CSE-MsgGUID: LsIdoM9VSPiPNLaXZbHXtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1977121"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1977121"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 23:26:54 -0700
X-CSE-ConnectionGUID: MYMGFIjwQnmnjmZ+puUUkg==
X-CSE-MsgGUID: BzZNzsrZTIKFodwhqLiUMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5268597"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 23:26:46 -0700
Message-ID: <8fd0bb21-c273-4f43-8c08-5e82ea1ed8e5@linux.intel.com>
Date: Fri, 30 Oct 2026 14:26:41 +0800
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
Subject: Re: [PATCH v10 15/28] KVM: x86: Include CR4.FRED in the emulator CR4
 write mask
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
 <20260911213659.2025974-16-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-16-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: Xin Li <xin@zytor.com>
> 
> Add CR4.FRED to the emulator's CR4 write mask.  Historically, CR4 was
> restricted to its lower 32 bits in the x86 architecture.  With the
> introduction of FRED, CR4 is expanded to use its higher 32 bits to
> accommodate the FRED enablement bit at position 32.  Update the mask
> to ensure the emulator correctly handles FRED initialization and
> prevents the inadvertent truncation of high-order bits.
> 
> Signed-off-by: Xin Li <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v10:
>  - New patch
> ---
>  arch/x86/kvm/regs.h |  2 +-
>  arch/x86/kvm/x86.c  | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index 4e641a6c20f9..ef46918daf43 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -8,7 +8,7 @@
>  #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
>  	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
>  	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE \
> -	 | X86_CR4_CET)
> +	 | X86_CR4_CET | X86_CR4_FRED)
>  
>  #define X86_CR0_PDPTR_BITS    (X86_CR0_CD | X86_CR0_NW | X86_CR0_PG)
>  #define X86_CR4_TLBFLUSH_BITS (X86_CR4_PGE | X86_CR4_PCIDE | X86_CR4_PAE | X86_CR4_SMEP)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e10ac6b280f6..f264bc9c35f9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5552,11 +5552,17 @@ static int emulator_set_dr(struct x86_emulate_ctxt *ctxt, int dr,
>  	return kvm_set_dr(emul_to_vcpu(ctxt), dr, value);
>  }
>  
> -static u64 mk_cr_64(u64 curr_cr, u32 new_val)
> +static u64 mk_cr0_64(u64 curr_cr, u32 new_val)
>  {
>  	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
>  }
>  
> +static u64 mk_cr4_64(struct kvm_vcpu *vcpu, u64 curr_cr, u64 new_val)
> +{
> +	u32 shift = guest_cpu_cap_has(vcpu, X86_FEATURE_FRED) ? 33 : 32;
> +	return (curr_cr & ~((1ULL << shift) - 1)) | new_val;
> +}

It's a bit weird to do it based on specific features.

Also, I am not sure this is needed to do the special handling to preserve
the higher bits.
emulator has zero extended the higher bits in fetch_register_operand() if
in non-64bit mode. I think we can just take the full 64-bit new value?
Did I miss anything?

And also for CR0, is the special handling needed?

> +
>  static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
>  {
>  	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
> @@ -5593,7 +5599,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
>  
>  	switch (cr) {
>  	case 0:
> -		res = kvm_set_cr0(vcpu, mk_cr_64(kvm_read_cr0(vcpu), val));
> +		res = kvm_set_cr0(vcpu, mk_cr0_64(kvm_read_cr0(vcpu), val));
>  		break;
>  	case 2:
>  		vcpu->arch.cr2 = val;
> @@ -5602,7 +5608,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
>  		res = kvm_set_cr3(vcpu, val);
>  		break;
>  	case 4:
> -		res = kvm_set_cr4(vcpu, mk_cr_64(kvm_read_cr4(vcpu), val));
> +		res = kvm_set_cr4(vcpu, mk_cr4_64(vcpu, kvm_read_cr4(vcpu), val));
>  		break;
>  	case 8:
>  		res = kvm_set_cr8(vcpu, val);

