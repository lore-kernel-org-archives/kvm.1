Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E13603D8
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917949; cv=none; b=eqaZXGfDBfZ6DJPe4pDSi/3bNaPpBoEHvqY2iezIpXchFZcEkvUrK8jxd1T2x0eiir3HemmuD1HmUvqDvikTXo1j3coAdhfQKdLri3umti33FhBbo+a5PmLK4AQAZNtNIFWRIsDyzFnnekCP0vV4Fa6TWzDCzyefddkGN5d2HUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917949; c=relaxed/simple;
	bh=s7fFFa2eJMQ3eN2H7XJtrr9mTMWELH78gjwCpiFzx3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4f5cINvkDHYXa5UwLNyK7AD1sSJbXSRIJ4STbpmd/1R/iSqDy2Ierxq4N8Y6leuttKBfVEZITxmaLyXGdoo6Zq2NvhJWHzItYA7Ggvk3NuSmgwSdrnmBNX5QGAieVsayMmaojADz6EnUp5c+LLXqEeJt2vsK/gl802V2H5EQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1XsV2NV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1XsV2NV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca5d2474c7so15895915ad.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782917947; x=1783522747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdTrJVjmaGZK4bIS2S2vPN6p/bM+L67mDpK1aprSBRM=;
        b=d1XsV2NVNpvgiiZOftRjlonlqNWGvlk3QGIytCpZtxNSv3qnQdcc4i7X47Qr+0lDxc
         0M5/+loCbnr5iJxTOvS8BffTgTDcFCRI7gpkScZGxxFAjBdaHRFO99l+w4H1YlcELVOc
         f8mEFKUPG6lCNb452SPlVL32hK4h2Gs38SGP0MQfJwoqbTdfAvx+DYG43Aonx01L3JV6
         rSoUn7o5dzcb8i+mtKjHgcOe0pR9AMrT+CQGzfrC1Q84+1tbT9K7UzwulWlPVSUUS62A
         q4/0E6lCQyiT8lGy1oqBbifj+4MUEU8JlckP251BbsPFelEadEa1IhOs6mY90Ql4vPCT
         dCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782917947; x=1783522747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdTrJVjmaGZK4bIS2S2vPN6p/bM+L67mDpK1aprSBRM=;
        b=ShLWWaod52CSk5OL2nqO0HpTZXCHwBMNVU14HOJgo+O1EYByX9s0YCgSczyiVRW+fc
         yIYDj7B3AAj1Si33Otn44Vrez4jJxcD/0UYXs3f3yV+abOwse4u6mn1LRaWX5st5CER7
         5sPDjQnNH6nKYCrsqiDo7DZsaa3pqtdcnUe2ng74322bM8R1x9/VadjpBY8d6MQfq4Ax
         HZyL4tLI4SpYXISQ8V2lkwLSkF1tuD4c9HgX0KyGtAD82sfUvGxUFMGWWyTnqUBpC8H2
         eOgEffUEMlnTA25sMLq5r5lDwDr2USm5cTP7gvgdYTqn4STC9JxPmYEAjtftE/BGMH31
         mNew==
X-Forwarded-Encrypted: i=1; AHgh+RrPlxVnBYnj2vT84B9iRkySn9/u0rTMWVJc8/jbFPqAOZcmuk5vdGfGdPLm+S3llhVxcWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd8+8d236+0YlgB6viAeNINOiGWA4hZTgDrfnk5/kHUSluH4tM
	Cn8V4NT3EG6dk95e+/fxU5yomtGeBcFEVsbPN9uwVrsXpk7N595z6h91vDtzgNjJEy2m48V74wY
	ukbKExQ==
X-Received: from plbbi9.prod.google.com ([2002:a17:902:bf09:b0:2bf:195a:2b9d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74b:b0:2c7:fc03:fcf0
 with SMTP id d9443c01a7336-2ca91151163mr8962085ad.17.1782917946247; Wed, 01
 Jul 2026 07:59:06 -0700 (PDT)
Date: Wed, 1 Jul 2026 07:59:05 -0700
In-Reply-To: <20260701110547.764083-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701110547.764083-1-kirill@shutemov.name> <20260701110547.764083-3-kirill@shutemov.name>
Message-ID: <akUrORhAmRur-lHP@google.com>
Subject: Re: [PATCH v5 2/3] x86/insn-eval: Add insn_assign_reg() helper
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Laight <david.laight.linux@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	Dan Williams <djbw@kernel.org>, Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> KVM's instruction emulator has a small helper, assign_register(), that
> writes a value into a sub-register with x86 partial-register-write
> semantics: 1- and 2-byte writes leave the upper bits of the destination
> untouched, 4-byte writes zero-extend to 64 bits, 8-byte writes overwrite
> the full register.
> 
> The TDX guest #VE handler needs the same logic for port I/O emulation
> to get 32-bit zero-extension right.  Rather than copy-pasting the
> helper, lift it to <asm/insn-eval.h> as insn_assign_reg() so both can
> use it.
> 
> Add <asm/insn.h> to the header's includes so it builds standalone in
> callers that have not pulled it in transitively.
> 
> No functional change.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Cc: stable@vger.kernel.org # prerequisite for the following 32-bit port I/O zero-extension fix
> ---
>  arch/x86/include/asm/insn-eval.h | 30 ++++++++++++++++++++++++++++++
>  arch/x86/kvm/emulate.c           | 26 ++++----------------------
>  2 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> index 4733e9064ee5..0c87759816d3 100644
> --- a/arch/x86/include/asm/insn-eval.h
> +++ b/arch/x86/include/asm/insn-eval.h
> @@ -9,6 +9,7 @@
>  #include <linux/compiler.h>
>  #include <linux/bug.h>
>  #include <linux/err.h>
> +#include <asm/insn.h>
>  #include <asm/ptrace.h>
>  
>  #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
> @@ -46,4 +47,33 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
>  
>  bool insn_is_nop(struct insn *insn);
>  
> +/*
> + * Write @val into *@reg with x86 partial-register-write semantics: a 1-
> + * or 2-byte write leaves the upper bits of the destination untouched; a
> + * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]

The placement of the "(matching IN[BWL], MOV[BWL] etc.)" blurb is confusing.  I
*think* you're trying to say this behavior matches that of MOVB, MOVW, and MOVL
instruction mnemonics, but the blurb is buried in the snippet that specifically
describes the 4-byte write behavior.

FWIW, I think giving examples does more harm than good, because the behavior isn't
instruction specific, it's architectural behavior that applies to all writes to
GPRs, as defined in "3.4.1.1 General-Purpose Registers in 64-Bit Mode".  E.g. for
a MOV instruction that sign-extends a 32-bit immediate to a 64-bit registers, it's
not that the instruction is exempt from the normal GPR semenatics, it's that the
instruction performs a 64-bit write to the destination even though the source is
only 32 bits.

And the B/W/L terminology isn't architectural, it's AT&T syntax.  E.g. trying
to encode "movl" with NASM yields "error: instruction expected, found `movl dword'".
Yes, the kernel uses AT&T syntax for assembly, but I think this helper should very
explicitly document that it's emulating architectural behavior.

> + * etc.); an 8-byte write overwrites the full register.
> + *
> + * @reg need not be 8-byte aligned: KVM's instruction emulator points
> + * into the middle of a register slot to address the high-byte
> + * registers (AH, CH, DH, BH).  Use narrow stores for the sub-word
> + * cases so that the access width matches @bytes.
> + */
> +static inline void insn_assign_reg(unsigned long *reg, u64 val, int bytes)
> +{
> +	switch (bytes) {
> +	case 1:
> +		*(u8 *)reg = (u8)val;
> +		break;
> +	case 2:
> +		*(u16 *)reg = (u16)val;
> +		break;
> +	case 4:
> +		*reg = (u32)val;

IMO, it's worth keeping a short comment here, because even with the explanation
above, I suspect most people will think the code is buggy.  E.g.

		/* As above, zero-extend 4-byte writes on 64-bit CPUs. */
		*reg = (u32)val;

> +		break;
> +	case 8:
> +		*reg = val;
> +		break;
> +	}
> +}
