Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040C47884C
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628703; cv=none; b=VZaHnrfzwqgKYYdB8khClw9B+xjaWrwmisNynxGsuKw1/+fYSnxVAIzU93FLdpO6R77Y/oFdtcL0MJOHLqT9er/dQax+iOqcyxip4u2bMCGiDUSEwcj2onlu9e886BqkOU2V1T2dvW58eU4yLIcJBZZRxj8FJdho7WUjrqET/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628703; c=relaxed/simple;
	bh=Kxn5M/7aXFMW75dhYOOhkf7y79XCez+uaidewunoxjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZTzQ2ZjPVuxSO9PZA7SMO2g/eSSk6/vpN9R3GXEcbiTqIyX9Ow5B6pPJ55IknC0oDz+UjaxGNnUVnANK6i6BSUteRR5YCgvPbNk/CM2ZCs/1ouxYP5/rU+f4kopL8hjHCvshUH2pZyYrWJPTkv9G5uIm4Zlv37CWamhS38qjUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2nzjLcJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2nzjLcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FBC1F000E9;
	Tue, 16 Jun 2026 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628702;
	bh=oODNAQZZY6LjoQySJ4fPZYmno90Q0v/5if8IorZAKXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2nzjLcJ0lSJ+o9gxvmZ+hblvSERrle9HeSLlSsCo9KvOcUi5wQ/Kg1XR3tZTeC/h
	 JxMwPEPXbPBWZBYxV5sH4sJQAGhIZX6ATdDIox7XRQzzokE+oDjn6luUo63A+mf6S5
	 kKeoKlGB+frXG9/WI4PPObB927XE+19ssmc2RrOU7SRQrD9iX89PJqzQ81BjjWwdJ7
	 hruJI6QLaIhyBPSSnvvMmnG+uQ/PhFvSrUJVpq58EnP2RYu6waTLvUZz+96Gd6W2s2
	 U8A5YXGBrFW/fs1qMaH7Bz5Zf5v5xJ0HUn4ILeI9JQgHT/5+BKeBM3eo67WjHCDxVS
	 k5oaZLf7WkhFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616163405.96962-1-amachhiw@linux.ibm.com>
References: <20260616163405.96962-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:51:42 +0000
Message-Id: <20260616165142.71FBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Setting an invalid arch_compat bypasses capability checks and pois=
ons the shared vcore state, but only marks the calling vCPU as insane, allo=
wing sibling vCPUs to exploit the invalid state.
- [High] The patch breaks the KVM kernel build for BookE and non-Book3S Pow=
erPC configurations by dereferencing an incomplete type `struct kvmppc_vcor=
e`.
--

commit c3e328e2b42077592c9f8abacefc77f063b6a36c
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode

This commit introduces a validation mechanism to detect and reject
unsupported arch_compat values during guest initialization on PowerPC
Book3S HV. It uses a sentinel value to mark mismatched compatibility
configurations and updates kvmppc_sanity_check() to prevent the vCPU
from running.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..f9380ef657500 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
[ ... ]
> @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *v=
cpu, u32 arch_compat)
[ ... ]
>  		case PVR_ARCH_31_P11:
> +			/*
> +			 * Need to check this for ISA 3.1, as Power10 and
> +			 * Power11 share the same PCR. For any subsequent ISA
> +			 * versions, this will be taken care of by the guest vs
> +			 * host PCR comparison below.
> +			 */
> +			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
> +				arch_compat =3D PVR_ARCH_INVALID;
> +				goto out;
> +			}
>  			guest_pcr_bit =3D PCR_ARCH_31;
>  			break;
>  		default:
> @@ -469,6 +481,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vc=
pu, u32 arch_compat)
>  			return -EINVAL;
>  	}
> =20
> +out:
>  	spin_lock(&vc->lock);
>  	vc->arch_compat =3D arch_compat;
>  	kvmhv_nestedv2_mark_dirty(vcpu, KVMPPC_GSID_LOGICAL_PVR);
> @@ -479,7 +492,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vc=
pu, u32 arch_compat)
>  	vc->pcr =3D (host_pcr_bit - guest_pcr_bit) | PCR_MASK;
>  	spin_unlock(&vc->lock);
> =20
> -	return 0;
> +	return kvmppc_sanity_check(vcpu);

[Severity: High]
If we set arch_compat to PVR_ARCH_INVALID and take the goto out path, does
this bypass the guest_pcr_bit > host_pcr_bit check and persist the sentinel
value into the shared vc->arch_compat?

Since kvmppc_sanity_check() is only called for the current vcpu, could
sibling vCPUs sharing the same vcore bypass the sanity check and run with
this corrupted vcore state?

>  }
> =20
>  static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..98de68379b18d 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -258,6 +258,10 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
>  	if (!vcpu->arch.pvr)
>  		goto out;
> =20
> +	if (vcpu->arch.vcore &&
> +		vcpu->arch.vcore->arch_compat =3D=3D PVR_ARCH_INVALID)
> +		goto out;
> +

[Severity: High]
Does this break the build for BookE and non-Book3S configurations?=20

kvmppc_sanity_check() is common code located in arch/powerpc/kvm/powerpc.c,
but struct kvmppc_vcore is only defined in asm/kvm_book3s.h.

If a BookE environment compiles this, won't dereferencing
vcpu->arch.vcore->arch_compat result in an incomplete type error?

>  	/* PAPR only works with book3s_64 */
>  	if ((vcpu->arch.cpu_type !=3D KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616163405.9696=
2-1-amachhiw@linux.ibm.com?part=3D1
