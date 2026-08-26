Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DB3B0ADC
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729523; cv=none; b=PzwsSr6tX5jLaED3nro+KJMhpeLL5qfybY5QJKFPuylaDh8vGuE+HBqozET4RGMYyx3gU+Q038Kp2bsAHbmPO7lIeqEKkaj14BcFG5Eqrv5uzyAD+9Qjop9euISte+MAXBjhVByEg1be5a2SBFpRSEEG0fybZw+G3vI3oc9zeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729523; c=relaxed/simple;
	bh=y4e9un53IvbiPbaRsKYh/kxSBRxtzdsZG7PDcgijAEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ilYvVXX/a/3bwqIXqXz5VXULigzkFhfip264Ko7YGf0fnUgkG5hpBDWkjEbmXyx+e6lcxr2dF/LQECOOmZCB9FX7O1+hAgxn4ftzOgB61BYxTE2Om4LKMvKPw4j11FNBj2XwYfvbH6erhHsnHhAXNGCJeyuRhTCoYcYQww5WaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRT2z8ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRT2z8ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37641F000E9;
	Wed, 26 Aug 2026 07:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787729519;
	bh=nYwyHTdSDgaYCi+yX4YyPwiQKCgyrIt6zMQ5p1MEKHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRT2z8NDngZMh+2zfcwbYPXX6ByE3y9+ZrZnHmuWRQteFUJozroW85Nb2meII6O6o
	 y1AxceQ/EpOtI0ZwToxkZ1TLYmi2aRqfb/RKbjPnWPV0LAdlShGlPmNBMHi69KygyZ
	 Gmw2RBld85L5iu5b5SZii0QMolSVxQsGx420YFn+JhOQnujhftqDU0ovhgNr/8Bg21
	 q43VLZEvpCtaBHRdX836TlwBr20x5465SI6IaPJ8O7nuzHz0m7j94ksBvxcYEITWsb
	 vxJh1ZJ+XDIkhYlfOIxvgVOFnZ01t2UWVRT8gmfohq3by/N8Lt8XSjnxlHeSw3j7aq
	 woBBusjp+Y3Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] KVM: x86: Add support for cmpxchg16b emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826070004.8100-3-sarunkod@amd.com>
References: <20260826070004.8100-1-sarunkod@amd.com>
 <20260826070004.8100-3-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:31:59 +0000
Message-Id: <20260826073159.B37641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Emulation of CMPXCHG16B lacks the mandatory 16-byte alignment chec=
k, leading to a guest-triggerable VM crash.
- [Low] The macro `em_cmpxchg8b_16b` incorrectly captures the variable `ctx=
t` from the surrounding scope instead of solely using its argument `__c`.

Pre-existing issues:
- [Critical] TOCTOU vulnerability in atomic CMPXCHG emulation leads to sile=
nt data corruption in the guest when a native compare fails.
--

commit f6a8a67f38b03c4522f119ac54d63d97691e1289
Author: Sairaj Kodilkar <sarunkod@amd.com>

KVM: x86: Add support for cmpxchg16b emulation

This patch adds support for emulating cmpxchg16b when the destination memory
is 128-bit and REX.W =3D 1. This prevents QEMU guests from hitting emulation
failures during 256-bit device table entries accesses on AMD vIOMMU.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c1b21282187f3..f38c4f1a99c31 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c

[ ... ]

> @@ -2184,24 +2184,36 @@ static int em_call_near_abs(struct x86_emulate_ct=
xt *ctxt)
>  	return rc;
>  }
> =20
> +#define em_cmpxchg8b_16b(__c, rbits, mbits)\
> +do {												\
> +	u##mbits old =3D __c->dst.orig_val##mbits;						\
> +												\
> +	BUILD_BUG_ON(rbits * 2 !=3D mbits);							\
> +												\
> +	if (((u##rbits) (old >> 0) !=3D (u##rbits) reg_read(ctxt, VCPU_REGS_RAX=
)) ||		\

[Severity: Low]
Does this macro intentionally reference the unpassed variable ctxt instead =
of
the provided argument __c?

This uses ctxt to read registers, which makes the macro rely on the specific
variable name ctxt in the caller's scope instead of its parameter.

> +	    ((u##rbits) (old >> rbits) !=3D (u##rbits) reg_read(ctxt, VCPU_REGS=
_RDX))) {		\
> +		*reg_write(ctxt, VCPU_REGS_RAX) =3D (u##rbits) (old >> 0);			\
> +		*reg_write(ctxt, VCPU_REGS_RDX) =3D (u##rbits) (old >> rbits);			\
> +		ctxt->eflags &=3D ~X86_EFLAGS_ZF;							\
> +	} else {										\
> +		ctxt->dst.val##mbits =3D ((u##mbits)reg_read(ctxt, VCPU_REGS_RCX) << r=
bits) |	\
> +					(u##rbits) reg_read(ctxt, VCPU_REGS_RBX);		\
> +												\
> +		ctxt->eflags |=3D X86_EFLAGS_ZF;							\
> +	}											\
> +} while(0)
> +
>  static int em_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
>  {
> -	u64 old =3D ctxt->dst.orig_val64;
> -
> -	if (ctxt->dst.bytes =3D=3D 16)
> +	if (WARN_ON_ONCE(8 + !!(ctxt->rex_bits & REX_W) * 8 !=3D ctxt->dst.byte=
s))
>  		return X86EMUL_UNHANDLEABLE;
> =20
> -	if (((u32) (old >> 0) !=3D (u32) reg_read(ctxt, VCPU_REGS_RAX)) ||
> -	    ((u32) (old >> 32) !=3D (u32) reg_read(ctxt, VCPU_REGS_RDX))) {
> -		*reg_write(ctxt, VCPU_REGS_RAX) =3D (u32) (old >> 0);
> -		*reg_write(ctxt, VCPU_REGS_RDX) =3D (u32) (old >> 32);
> -		ctxt->eflags &=3D ~X86_EFLAGS_ZF;
> -	} else {
> -		ctxt->dst.val64 =3D ((u64)reg_read(ctxt, VCPU_REGS_RCX) << 32) |
> -			(u32) reg_read(ctxt, VCPU_REGS_RBX);
> -
> -		ctxt->eflags |=3D X86_EFLAGS_ZF;
> -	}
> +	if (!(ctxt->rex_bits & REX_W))
> +		em_cmpxchg8b_16b(ctxt, 32, 64);
> +#ifdef CONFIG_X86_64
> +	else
> +		em_cmpxchg8b_16b(ctxt, 64, 128);
> +#endif

[Severity: High]
Are we missing a 16-byte alignment check for the destination memory when
executing CMPXCHG16B here?

The x86 architecture strictly mandates that the memory operand for CMPXCHG1=
6B
must be 16-byte aligned. If it is not, a #GP(0) exception is generated
unconditionally.

Without this check, KVM will later attempt a native unaligned lock cmpxchg1=
6b,
which will raise a host #GP(0). The host exception table catches this and
returns -EFAULT, translating to X86EMUL_UNHANDLEABLE, which immediately
crashes the VM via KVM_EXIT_INTERNAL_ERROR. Can this regression be used by a
guest to trigger a denial of service?

>  	return X86EMUL_CONTINUE;
>  }

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..60be16f05d794 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -5311,6 +5311,11 @@ static int emulator_cmpxchg_emulated(struct x86_em=
ulate_ctxt *ctxt,
>  	case 8:
>  		r =3D emulator_try_cmpxchg_user(u64, hva, old, new);
>  		break;
> +#ifdef CONFIG_X86_64
> +	case 16:
> +		r =3D emulator_try_cmpxchg_user(u128, hva, old, new);
> +		break;
> +#endif

[Severity: Critical]
This is a pre-existing issue, but does the emulation of atomic CMPXCHG suff=
er
from a TOCTOU race leading to silent data corruption in the guest?

When emulator_try_cmpxchg_user() fails due to concurrent memory modificatio=
n,
emulator_cmpxchg_emulated() returns X86EMUL_CMPXCHG_FAILED.

However, in x86_emulate_insn(), this failure appears to be silently swallow=
ed:

arch/x86/kvm/emulate.c:x86_emulate_insn() {
    ...
    if (rc =3D=3D X86EMUL_CONTINUE)
        writeback_registers(ctxt);

    return (rc =3D=3D X86EMUL_UNHANDLEABLE) ? EMULATION_FAILED : EMULATION_=
OK;
}

Because rc is not X86EMUL_CONTINUE, writeback_registers() is skipped and the
guest registers are not updated. Because EMULATION_OK is returned, KVM reti=
res
the instruction as successful, advancing RIP and leaving the guest with a
stale ZF=3D1 flag. Doesn't this cause the guest to mistakenly believe it
acquired a lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826070004.8100=
-1-sarunkod@amd.com?part=3D2
