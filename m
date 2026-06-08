Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB652EEE9C
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883978; cv=none; b=QFGf/zRoSbh+T6N8kodzjYiyEl/6rphRRBJaT23BJGm+63D8p0hlnOGAqytwKEYFdTLQrR+bkjOXtqwSX/rXlxZvmznBJPEdzxVeUbj+H2a6Hq+bzhO6KKmHVg2UKtplPTHm04NnKM5njLN4TerxGYizpO2K8v+nou2Qu2/yz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883978; c=relaxed/simple;
	bh=CEqWa6Oj/EpugL/F90T6M0Ba9vKcQkdcXKD7gLrQFr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gw0lJnIxyCrJNuPH2c/3shrbbDz5sU3tl/AbWCkDRvYyLL6HbDvWmoSx6U73irfViCQaRUxi4GrDy9xtTvsSaxjnJO+Ap7LDsAngK3yefG6V17gb+HjQfbxFUWQUyRiKOBA97hCETtclRVKGCndyzZMRh01d2+AbtyyUFqfDvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnce5V2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnce5V2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782A51F00893;
	Mon,  8 Jun 2026 01:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883976;
	bh=0Uz1OtZ+L2Glg2G6pHRVP4z33bG8UpmLZrUPTCrVDEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fnce5V2GBfqMpvlHHHdsdP5emktBzQY0kY9Pt973c4HUc7dAx0HpofUPCMjIuL7kN
	 g6WB1diup6FiFBxqN0LsOXjdi5aapNaK7pApd4h8ZvsESLiOO12TKZzvN6bIAT6hWy
	 x2y6KqoliuFcziwovOrJm541+eMgcZv6GJvw30f2h9w6prUzpcUjf6WXNGro3EQIW7
	 vGEO+hf+HQ7+zMtmDDih3aFhBHU0pwLmK2dHnPgDyUpq7u6qWSetEAJkXBW/4Qf2Bw
	 6i5wl/CXS7J/6c7ndkd2G1ChY54Nd7Se+paBrzrOFqr7OuOe2BV7MBMW1Ao39L6nCG
	 oqNLhhuD1DEDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] LoongArch: KVM: Remove some middle FPU states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608013222.375257-4-maobibo@loongson.cn>
References: <20260608013222.375257-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:59:36 +0000
Message-Id: <20260608015936.782A51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] KVM get/set FPU ioctls only copy 4 bytes per register instead =
of the full 32-byte register width, silently discarding most of the FPU sta=
te.
- [High] Guest-triggerable WARN_ON in kvm_handle_fpu_disabled() leads to ho=
st dmesg spam and KVM_EXIT_INTERNAL_ERROR.
--

commit fd0d91860653b1098410a55d70cf4bc567a40acd
Author: Bibo Mao <maobibo@loongson.cn>
LoongArch: KVM: Remove some middle FPU states

This commit removes intermediate FPU states, such as FPU to LASX or LSX to
LASX, in the kvm_own_lsx() and kvm_own_lasx() functions. This simplifies
the transitions when the VM supports the maximum FPU type (LASX).

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 7f55875d8b3bb..53abf7aa61f86 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1389,21 +1389,7 @@ int kvm_own_lsx(struct kvm_vcpu *vcpu)
[ ... ]
>  	kvm_restore_lsx(&vcpu->arch.fpu);
> =20
>  	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
>  	vcpu->arch.aux_inuse |=3D KVM_LARCH_LSX | KVM_LARCH_FPU;

[Severity: High]
This is a pre-existing issue, but since this code manages FPU state
flags, is there a risk of a guest-triggerable host denial of service?

If KVM sets KVM_LARCH_FPU here, and a malicious guest manually clears
the FPEN bit in its own GCSR_EUEN register (a hardware-managed CSR), the
guest executing an FPU instruction will trap with EXCCODE_FPDIS.

When KVM intercepts this in arch/loongarch/kvm/exit.c:

kvm_handle_fpu_disabled() {
    if (WARN_ON(vcpu->arch.aux_inuse & KVM_LARCH_FPU)) {
        kvm_err("%s internal error\n", __func__);
        ...
    }
}

Since aux_inuse still has KVM_LARCH_FPU set, the WARN_ON will fire,
dumping a stack trace to the host dmesg and terminating the VM. Does
this allow unprivileged guests to intentionally spam host kernel logs?

[Severity: Critical]
This is a pre-existing issue, but while looking at FPU handling in
arch/loongarch/kvm/vcpu.c, there appears to be a state truncation bug
during FPU get and set operations.

Looking at kvm_arch_vcpu_ioctl_get_fpu():

arch/loongarch/kvm/vcpu.c:kvm_arch_vcpu_ioctl_get_fpu() {
    ...
    for (i =3D 0; i < NUM_FPU_REGS; i++)
        memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], FPU_REG_WIDTH / 64);
    ...
}

Since FPU_REG_WIDTH is defined as 256 bits, FPU_REG_WIDTH / 64 evaluates
to 4. Because memcpy takes the size in bytes, does this only copy 4 bytes
per register instead of the intended 32 bytes (which would be
FPU_REG_WIDTH / 8)?

A similar pattern exists in kvm_arch_vcpu_ioctl_set_fpu():

arch/loongarch/kvm/vcpu.c:kvm_arch_vcpu_ioctl_set_fpu() {
    ...
    for (i =3D 0; i < NUM_FPU_REGS; i++)
        memcpy(&vcpu->arch.fpu.fpr[i], &fpu->fpr[i], FPU_REG_WIDTH / 64);
    ...
}

Could this silently discard the upper 28 bytes of every FPU register
during KVM_GET_FPU and KVM_SET_FPU operations, potentially causing
guest data corruption during live migration or state save and restore?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013222.3752=
57-1-maobibo@loongson.cn?part=3D3
