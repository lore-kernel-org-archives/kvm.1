Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DAB1FD4
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873100; cv=none; b=RNw2aL+MH5vfGk61Ar30tiOlPftGQ5GurjXoZO3+K2O9Vq8dwQV7gKirXcu7XvocryYxcO6nz/ydlqeDBr8UomWojN7tr7SRnzkj8tGGAZQa4+wuClcgRHPU2/r5wC8su5Ta91DisGwAz9ikye2MJZKyOWDV2Gdnw/BBZujQuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873100; c=relaxed/simple;
	bh=5V1aUYHCtujYgQVLp68iSC4uG0qx/QzUrRFkmqLdWw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L950uKE1zBLNsSqJ+cbck8UFbTZlCkongt4FfrPZuPGiyo4ufvkUW336CnIn86zKZqDhfOswSz0mXacgKvlDcXmAmOaCBPhOdX3vBaB3EdZfU6dJUot7OE+zaJdylZDh/diEoCpLl9CVi4HfqMXHwnteGDtHZo37dJWT81jtZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei6yoGuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei6yoGuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAC91F000E9;
	Wed,  1 Jul 2026 02:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782873099;
	bh=SteZcpf2CJUQJBPqbCnuT9UDbfGdg2E+KZ2H/dy7o7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ei6yoGuH9x30X+vihK552U3kbg/qLmPVeia4f7Lav0abkS1wtxQtFQ9lygMNGr50W
	 Nke12Q+MZo4btHAYP9QnSmEvy+sNQw5zO1TySDi2zGu3QyAvP8ZkE2cMxo55cT9mmO
	 otLFhI2ueCVAWmOX6AFcJZS3ENr8VPhO3K/iNXR3Z5Rj5Re+g0ckkpYUkWkY53o1kk
	 VntaCrmqNNqQzaBaPxeMb0DJfVJMGfOuCcU8J/1qapWRL5dREkNC0XBGo+xT+YJDTI
	 9FmrNGOXCbmrKfKO8b3x1SQKHQQ1/TGkp4zZi7pTLx499D8y9xrcjo464iNdivZrpm
	 83JdXi7TZdgBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] RISC-V: KVM: Handle software-check exits for
 VCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701020746.170157-6-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
 <20260701020746.170157-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:31:38 +0000
Message-Id: <20260701023138.DBAC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `vcpu_redirect` unconditionally sets `VSSTATUS.SPP` to 1 and fails=
 to set `HSTATUS.SPVP` to 1, causing guest user-to-kernel privilege escalat=
ion or fatal guest crashes.
--

commit b591989d8fd2e996d0f963c15186f3a08e706f56
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Handle software-check exits for VCPU

The patch introduces handling for EXC_SOFTWARE_CHECK in RISC-V KVM to suppo=
rt
Zicfiss/Zicfilp extensions. It delegates these exceptions to VS mode via
vcpu_redirect().

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 0bb0c51e3c890..12eebeabdf146 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
[ ... ]
> @@ -243,6 +243,10 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struc=
t kvm_run *run,
>  		run->exit_reason =3D KVM_EXIT_DEBUG;
>  		ret =3D 0;
>  		break;
> +	case EXC_SOFTWARE_CHECK:
> +		if (vcpu->arch.cfg.henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
> +			ret =3D vcpu_redirect(vcpu, trap);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but using vcpu_redirect() here exposes an
underlying architectural flaw in KVM RISC-V's exception redirection logic.

When KVM redirects a trap to the guest, kvm_riscv_vcpu_trap_redirect() atte=
mpts
to copy the host's sstatus.SPP bit into the guest's VSSTATUS.SPP:

arch/riscv/kvm/vcpu_exit.c:kvm_riscv_vcpu_trap_redirect() {
    ...
	/* Change Guest SSTATUS.SPP bit */
	vsstatus &=3D ~SR_SPP;
	if (vcpu->arch.guest_context.sstatus & SR_SPP)
		vsstatus |=3D SR_SPP;
    ...

Since taking a trap from V=3D1 to HS-mode always sets the host's sstatus.SP=
P to 1,
VSSTATUS.SPP is unconditionally set to 1. This falsely tells the guest OS t=
hat
the exception originated in supervisor mode, even if it actually occurred in
user mode (VU-mode).

Additionally, kvm_riscv_vcpu_trap_redirect() fails to update HSTATUS.SPVP:

    ...
	/* Set Guest privilege mode to supervisor */
	vcpu->arch.guest_context.sstatus |=3D SR_SPP;
}

Because sret from HS-mode uses HSTATUS.SPVP to determine the return privile=
ge
mode for the guest, the guest will resume in VU-mode at the supervisor
exception vector (vstvec).

Does this enable guest user space to execute the kernel's trap handler with
user privileges, leading to privilege escalation or fatal guest crashes?

> +		break;
>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020746.1701=
57-1-inochiama@gmail.com?part=3D5
