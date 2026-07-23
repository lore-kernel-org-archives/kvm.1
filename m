Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E57369D66
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829877; cv=none; b=af4djoXnmclLSAcixgySzbdEq/raVNogsRL1OKZmYjyrfHxKwo7IWuef9dN/DdHuVZSak8KaoLssrnF5pBbCmqWEmP6BbfCkUsIvspNWUmzP87vqZe2imJF5YNwRCrXs7WaK66Gz9cpJcFaPz3+MOYfVI3sEPBPBnV6U6wf6pMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829877; c=relaxed/simple;
	bh=FA8+57wcob+MTE9XfqIzqO6YaSWzXTaxb3eQ5Poz4N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G0eu8Rp+Q/p0Fy1M0mZh8+IU+fCCuQer0/5Eac2EF9VZy848JacKKwcTRC2A0HTP/eBkuvthBKqS5wpslp2MtgQd348oXKVecCK8tk3L1RrovbnzMbp/UpRa9FD8vgKbmTHWYDOxp+XAXGnhW+qkbHP3Md8uvCKRv9Nl5N4YKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qISaaorR; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qISaaorR"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2237bc43so1870793a91.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784829875; x=1785434675; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMh/62kafhHoFqv8DTLKCjWgXtXQT4BcRTSx3NgtOZw=;
        b=qISaaorRn4x6mALglXYa7lb1udanD9ZaAeYPpaG3uFmc5Emm6AyQQjWFdoHw9K/mkY
         /68fqaNIfzbcuo5vGTNtWyvDu1f1rSUhUOFg9gVxxvN5wLB3Q6jHaNhln/H06pfyNvkH
         g3CE0UmK8MMJrlbeS3g8Ub+U19vPDNWi7yO5gyaA3/c2hTW7W3nBrci/lZfKdaC47zTy
         mFvCh4S9ArPtRrRdHvnNHXd5Stc8kUAUkI0UN17m8Umnx3lZX8eUjrI9okq0SRocSArg
         s0fiWkhxsXRPcVO4U3iTc5HiAIBp3NVJMhELS7byw+ivE2MTtSUbMdMXsEP5tuc7EXnj
         6nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829875; x=1785434675;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMh/62kafhHoFqv8DTLKCjWgXtXQT4BcRTSx3NgtOZw=;
        b=dejoIngjjWuEQSQmk0IR4SxGnEODr9V4PhAN7TXg+0HLy96r4/zB66ndjLiNygMC1t
         5hh2Xk+kABp6OiQZn+LgxN/aYB/sYEx5kj1xVp5ougaOhsMELx7tm3OxEdTIu7xfZDMn
         yANTJZL12H6yI6qUPEccm2y1F+yt6ubT1XO28c71FKND7TvMS4v1j8BPGOI+yqUM1xWR
         YMird3G7NFTfszJGVXWNcVOZ18RMhiU26uoAepOCoQHeK/RH5vBYrY3o6sNhCaCWvuZR
         rVIrhrwfFZCt1h2Piz2HyKsj+Uefi7OmiTJpaMH345ZVViFCThCgwVIAzOLHG+w2SPKo
         CzYg==
X-Forwarded-Encrypted: i=1; AHgh+RoB9VFlFSTJFhIdSNDgCscsxiVjhfWeMHkPo/k9q0geX1k8kGn9B+totaA3Y2HGDznhSiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GV7eV+9a4vT0FHzJllyY6FwyPGi9/CbkMW6+ICZVf8oF2Kuk
	In4E30BcpxYNAynXKlVK++PuUZorRxppqaaLAJQUm518K6qnWWAwlDgQrg3ECwM691sAaI2Yh9K
	GSca4oQ==
X-Received: from pjd6.prod.google.com ([2002:a17:90b:54c6:b0:381:224:393a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5146:b0:38e:6f72:9be4
 with SMTP id 98e67ed59e1d1-38ec6495a15mr4529269a91.3.1784829874614; Thu, 23
 Jul 2026 11:04:34 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:04:33 -0700
In-Reply-To: <20260720205208.519622-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720205208.519622-1-chang.seok.bae@intel.com>
Message-ID: <amJXsVGv3xe7GKu1@google.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Chang S. Bae wrote:
> AMX-TF32 enumeration was added based on the Intel documentation [1]. The
> recent update removed the feature, indicating that the feature is no
> longer planned for hardware implementation.
> 
> [1] Intel Architecture Instruction Set Extensions and Future Features
> 
> Note: The feature first appeared in the September 2025 revision of the
> document and was removed in the June 2026 revision.
> 
> Cc: stable@vger.kernel.org # v6.20+

6.20 isn't a thing.  And given that this is clearly associated with a specific
commit, just do:

  Fixes: 58cbaf64e653 ("KVM: x86: Advertise AMX CPUIDs in subleaf 0x1E.0x1 to userspace")

and let script magic sort out the rest.  No need for another version, if we
agree that ripping out support is the way to go, I'll fixup when applying.

> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> V1 -> V2: Collect tags (Zhao, Binbin), put note (Binbu), and cc @stable
> ---
>  arch/x86/kvm/cpuid.c         | 1 -
>  arch/x86/kvm/reverse_cpuid.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 591d2294acd7..759a1c557080 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1082,7 +1082,6 @@ void kvm_initialize_cpu_caps(void)
>  		F(AMX_COMPLEX_ALIAS),
>  		F(AMX_FP16_ALIAS),
>  		F(AMX_FP8),
> -		F(AMX_TF32),
>  		F(AMX_AVX512),
>  		F(AMX_MOVRS),
>  	);
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 2ad25781cefb..1bb13903c5b2 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -56,7 +56,6 @@
>  #define X86_FEATURE_AMX_COMPLEX_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 2)
>  #define X86_FEATURE_AMX_FP16_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 3)
>  #define X86_FEATURE_AMX_FP8		KVM_X86_FEATURE(CPUID_1E_1_EAX, 4)
> -#define X86_FEATURE_AMX_TF32		KVM_X86_FEATURE(CPUID_1E_1_EAX, 6)

I'm not convinced that yanking out support is the right move.  By publishing the
feature, for several years, Intel pretty much burned that CPUID bit.  E.g. it's
not impossible that someone other than Intel has implemented TF32 instructions.

The opcodes are fair game in the future, because their use can be qualified and
guarded, but the same doesn't hold true for enumeration.  E.g. similar to how
MPX got ripped out and its XSTATE assets got reused for APX, but the CPUID feature
enumeration is forever reserved for MPX (I hope).

If the argument is that "Intel Architecture Instruction Set Extensions and Future
Features" isn't binding documentation, i.e. that Intel can do take backs until a
feature is documented in the SDM, then I honestly don't see any option but to
refuse to accept new features until they land in the SDM.  Which I don't think
any of us want.

>  #define X86_FEATURE_AMX_AVX512		KVM_X86_FEATURE(CPUID_1E_1_EAX, 7)
>  #define X86_FEATURE_AMX_MOVRS		KVM_X86_FEATURE(CPUID_1E_1_EAX, 8)
>  
> -- 
> 2.53.0
> 
