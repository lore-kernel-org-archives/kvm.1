Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D681607A4
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416961; cv=none; b=aSs3cVW/kU+MKfmuEF7qtwMESRNqNZWUSl/NGlHsEPO3uAyKUgOrav7gBdd6xSZTp3Mkz5dQKl9lL07liI1H7pPWbL/KYBqHLXRaTc0Rw6Nr2Cjs7TnStl39LNx87FWAeg7g0dFgdsvA2qM9AkbGjLxA29VqBrpVAwieELsMCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416961; c=relaxed/simple;
	bh=At83/cghfWi1VsBnlQ/4MIFkZPRUi+DWw7oy6UwRAgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j7Dhn7zxoGK3GgOAGtrcv3mryWNGFeFgo5MtykG3XUKNuGmkyS3FmM+i8LealvusmcZhleK9PJs6J7KWoctwyQE85ec5iOuT3pVpJP4fODb5r+bc4esaHQbVZFdKQuvmcBwM0Mzt/q4O/9Y2xRJqpP+R2S2p0zDa3n4ltvfAr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByTW3q0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByTW3q0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197FF1F00893;
	Tue,  2 Jun 2026 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780416960;
	bh=BqLOSPwuHREPOxzgRSPqOZOjBfWmOhGaPPxlV19oHdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ByTW3q0YZmyaajvQK904nGu2JclbK7/J4LOJAv2pWHF6XFP50lrYxLzEpyflNYrCl
	 elUohXWi2WgTCac+Z2r1xfBDAM155TJuW2fNZLcrJ8IITt+wKGd+gal093yPdS+vkL
	 efaJHHFSdzMp4zjd+VkKIP8cqh72/gGwI/fvprpA1nO7tPk0cYslDMk7g4+1FosglT
	 WezKJ9QdM6KjyRUqBUtPy4LvSstmyS7EowDUEHn/CZTxlZ4jpkzHY6wG8lg0oFQzHa
	 0FS69ZQ9WRbrq8KHJr6DZfLflNv8GY0hLDEHzmUbpGT9+t6wOGYNRw7IPA48SFc1x9
	 PIbj2m4Zdzopw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: arm64: Key CPTR_EL2.E0POE propagation on
 FEAT_S1POE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Zyngier" <maz@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602155430.2088142-2-maz@kernel.org>
References: <20260602155430.2088142-2-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 16:15:59 +0000
Message-Id: <20260602161600.197FF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM fails to set CPACR_EL1_E0POE in hardware CPTR_EL2 for normal (=
non-nested) guests, causing all guest EL0 accesses to POR_EL0 to unexpected=
ly trap to KVM and result in injected UNDEF exceptions.
- [High] KVM breaks host Permission Overlay Extension (POE) usage upon retu=
rning from a VHE guest because __deactivate_cptr_traps_vhe() strips CPACR_E=
L1_E0POE.
--

commit d1828ccf84b404181eed585a3aaf208b36c6b88e
Author: Marc Zyngier <maz@kernel.org>

KVM: arm64: Key CPTR_EL2.E0POE propagation on FEAT_S1POE

We propagate CPTR_EL2.E0POE from a L1 into the L0 configuration, but
we key this on the L1 guest supporting FEAT_S2POE. This is obviously
wrong, as this bit is solely concerned with Stage-1 translation.

Fix this by making the update depend on FEAT_S1POE.

> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp=
/include/hyp/switch.h
> index 98b2976837b11..4d814ae90613d 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -141,7 +141,7 @@ static inline void __activate_cptr_traps_vhe(struct k=
vm_vcpu *vcpu)
>  	if (!(SYS_FIELD_GET(CPACR_EL1, ZEN, cptr) & BIT(0)))
>  		val &=3D ~CPACR_EL1_ZEN;
> =20
> -	if (kvm_has_feat(vcpu->kvm, ID_AA64MMFR3_EL1, S2POE, IMP))
> +	if (kvm_has_feat(vcpu->kvm, ID_AA64MMFR3_EL1, S1POE, IMP))
>  		val |=3D cptr & CPACR_EL1_E0POE;

[Severity: High]
This isn't a bug introduced by this patch, but does this logic apply to
normal guests?

Looking at __activate_cptr_traps_vhe(), normal (non-nested) guests bypass
this nested trap propagation via:

	if (!vcpu_has_nv(vcpu))
		goto write;

As a result, CPACR_EL1_E0POE is never added to the val written to cpacr_el1,
so CPTR_EL2.E0POE is 0. Any guest EL0 access to POR_EL0 will then trap to
EL2.=20

Because SYS_POR_EL0 lacks an access callback in sys_reg_descs[] in
arch/arm64/kvm/sys_regs.c, kvm_handle_sys_reg() injects an undefined
instruction exception into the guest, crashing guest applications that rely
on POE.

[Severity: High]
This is a pre-existing issue, but does host POE remain active after running
a VHE guest?

Looking at __deactivate_cptr_traps_vhe() in the same file, the host's
cpacr_el1 is restored with a hardcoded bitmask (FPEN, ZEN, SMEN), and
CPACR_EL1_E0POE is unconditionally stripped:

	u64 val =3D CPACR_EL1_FPEN;
=09
	if (cpus_have_final_cap(ARM64_SVE))
		val |=3D CPACR_EL1_ZEN;
	if (cpus_have_final_cap(ARM64_SME))
		val |=3D CPACR_EL1_SMEN;
=09
	write_sysreg(val, cpacr_el1);

Since the E0POE bit enabled by the host kernel is overwritten, when the host
returns to userspace, EL0 tasks executing POE instructions will trap to EL2.

Because the host kernel has no hook for POR_EL0 in sys64_hooks, do_el0_sys()
falls back to do_el0_undef(), sending SIGILL and crashing the userspace
task.

>  	val |=3D cptr & CPTR_EL2_TCPAC;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602155430.2088=
142-1-maz@kernel.org?part=3D1
