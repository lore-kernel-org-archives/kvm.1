Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422248BD4E
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912362; cv=none; b=aLHWU/LCLqKg4++qAWqkkbKPKnIGI+CEVimy8rvRz8Qbp+oBflPh0Q0JdnddRkSYUvc3deH8e0fvUndLdahdOr3EvRvZqssuKELkpDPYt+CxRWVNB+Qt7/g+M8X+ZJbhhV2MCSE4+qcRIIRD6l6gzmgauCkDDIi+snZrkAxvXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912362; c=relaxed/simple;
	bh=8nfXIomqSXgIICZsYr/d0hMEYIbWZJBgkVXniOZmk9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pvTjL0p0sYmcPbQy8Q9qKej9FrhkYair4ABhDDzs/C6VY8wKCdQIADBDLLk2Sakbu8pzrLjaFMZu3Efze2gshcgceONrORCPbEik6Ei9W7M11kZfbYQU7Mn8yHjZPY2BpU8s7YbNhgOHIrglYiZNVHbv6p2hTjutSx+2troZx+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1viAvHr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1viAvHr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8952346bb9so510026a12.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782912359; x=1783517159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfLgJd4SFiMfB5hvCG5v1jWKkuB92AfQ/vUitXihKB8=;
        b=V1viAvHryc1TSZPv37EeHNjCvE40FuZ05ykMLd+yTu9QmnX/iXij3UaxUqY0GjJ654
         m3VXBDlCNnSjH21+JaCO+Wf4PdmbflQ6+oSOn1V47f1l9z7graEv0Wh/ZZ39assGFhdk
         pe1Oz2LlowsgxO3e9K+6ubTkIvV0zsJ2zAqDW7ytefH7eRzQskpfsz7s757V4Cb90sIg
         DDrbfJbmQ2d/oefWCPDVUUD+phkIWD5SCnOJrW7FTFI5F5NXAJtLyv3FRdtZbEjT67dW
         CyZV55d7KN5sfxC3fcprPikWakhrb6ZjznxEidABSmBF/YJ0VRD6VTvfjiwNMQBslE/Z
         Sbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912359; x=1783517159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfLgJd4SFiMfB5hvCG5v1jWKkuB92AfQ/vUitXihKB8=;
        b=Jih18SgDMT5Exxwbz/kopymKPfJOnTuYlZuhz+9GFZNGTc+IsnqLizLGlZXm5BNXWw
         OWEIN/Ot0QU+L8NWoP7FJE03cQNgxnh3rOYAGzHyR6p9eiR2SPnYZHHbrw8Mtzrjz/VP
         Tm6/RyoEYDo3l9Hd03MdJg2lcIykPV5nxFP/XqTnmEnTdld0liGrU/tIEhqY2ZdkJvgK
         iLJ+sArKp2evC/8GLl7e0PhY+vx89CiKx1cKBbZcrLEN86Tdnfh7NhDuqFQJ5IuQp+Dh
         w0hLvC9/7BqEtMOBJQhh3/w81+9GdDjPNsrUGaSPtvI+rCXCpbGdA3EQEpP14/R3Vrnx
         TWkw==
X-Forwarded-Encrypted: i=1; AFNElJ/xm9RJ1VW6r5kyOT5gCtTmPnV5ySbRvcgM99UuNeuuQE5Q221RTonvVL4yuXKOaMhiNTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNroGF+WTb06jGwDI85AZgj2YBejBDD2keghc+sneJovwzG0d
	ujwTQ44QxAsQZqZW8PLz/oRz6PrYe0za5PmtQtWuMq2hbPjho9h4sbZSmJ0ycdAmBS14MQshXkC
	bW6cJPg==
X-Received: from pgcv24.prod.google.com ([2002:a05:6a02:5318:b0:c9a:c533:8316])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3944:b0:38d:fad1:cf2a
 with SMTP id adf61e73a8af0-3bfed1b2b94mr1854511637.13.1782912359138; Wed, 01
 Jul 2026 06:25:59 -0700 (PDT)
Date: Wed, 1 Jul 2026 06:25:57 -0700
In-Reply-To: <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780584300.git.kas@kernel.org> <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
Message-ID: <akUVZQ6SgK8wRetj@google.com>
Subject: Re: [PATCH v4 2/3] x86/insn-eval: Add insn_assign_reg() helper
From: Sean Christopherson <seanjc@google.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, rick.p.edgecombe@intel.com, 
	david.laight.linux@gmail.com, ak@linux.intel.com, djbw@kernel.org, 
	tsyrulnikov.borys@gmail.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

In the shortlog, please capture that code is being moved out of KVM.  This isn't
"adding" a helper, it's moving and renaming an existing helper.   The misleading
shortlog is quite literally why I didn't look at this for a ~month, I thought it
was entirely outside of my normal scope.

On Thu, Jun 04, 2026, Kiryl Shutsemau (Meta) wrote:
> KVM's instruction emulator has a small helper, assign_register(), that
> writes a value into a sub-register with x86 partial-register-write
> semantics: 1- and 2-byte writes leave the upper bits of the destination
> untouched, 4-byte writes zero-extend to 64 bits, 8-byte writes overwrite
> the full register.
> 
> The TDX guest #VE handler needs the same logic for port I/O emulation
> to get 32-bit zero-extension right. Rather than copy-pasting the helper,
> lift it to <asm/insn-eval.h> as insn_assign_reg() so both can use it.
> 
> Rewrite the body using arithmetic instead of pointer punning so the
> helper does not depend on -fno-strict-aliasing 

Meh, building with -fno-strict-aliasing is 100% mandatory for the kernel.  IMO,
even so much as suggesting that strict aliasing is something worth shooting for
is a misleading and wrong.

https://lore.kernel.org/all/CAHk-=wh921g_+TJ33JRxRGFM2uruMdqG-SONfFOD9UOsLQJ_uw@mail.gmail.com

> or little-endian byte order,

Oh come on, this is low level x86 code used to write registers.

> and add <asm/insn.h> to the header's includes so it builds standalone in
> callers that have not pulled it in transitively.
> 
> No functional change.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>  arch/x86/include/asm/insn-eval.h | 25 +++++++++++++++++++++++++
>  arch/x86/kvm/emulate.c           | 26 ++++----------------------
>  2 files changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> index 4733e9064ee5..85251e718a77 100644
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
> @@ -46,4 +47,28 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
>  
>  bool insn_is_nop(struct insn *insn);
>  
> +/*
> + * Write @val into *@reg with x86 partial-register-write semantics: a 1-
> + * or 2-byte write leaves the upper bits of the destination untouched; a

Careful with the "upper bits" wording.  As Sashiko pointed out, this is used for
{A,B,C,D}H sub-registers as well, in which case the *lower* bits are also left
untouched.

> + * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]
> + * etc.); an 8-byte write overwrites the full register.
> + */
> +static inline void insn_assign_reg(unsigned long *reg, u64 val, int bytes)
> +{
> +	switch (bytes) {
> +	case 1:
> +		*reg = (*reg & ~0xfful)   | (val & 0xff);

Sashiko's feedback aside, I strongly prefer KVM's approach as I find it much more
intuitive.  And its far, far more consistent with respect to the 4-byte and 8-byte
cases.

> +		break;
> +	case 2:
> +		*reg = (*reg & ~0xfffful) | (val & 0xffff);
> +		break;
> +	case 4:
> +		*reg = (u32)val;
> +		break;
> +	case 8:
> +		*reg = val;
> +		break;
> +	}
> +}
