Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8EB84039
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389782; cv=none; b=tOsFcpi743PPNzScoVK+iVT3m9F133VO++G+oa2kz3j9RMylxwnPQJHiTIc5+0u3SQjmeJgNcgMFeSn81b5q0sEj7sXJ0lo5nUUfkWzw7zNvIOpbgOyS7kZcEtKetd/M7gfFgmN55l15dPpMg9E3sV7TfH2dPywvQSg9faH98XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389782; c=relaxed/simple;
	bh=M6ybgq7AMAYdxyEkB6ts2UBfpdNDgV6oCDQtwAmA6k0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qA67ckfHNoeVPMog1c6Sz6RtwnRhfzRf3RjCfTTfsh61phfLlbEa+RaDwRMsIaDp/CtlbDYUJDOYqM/TiuroFbW2EhxB7uMsDM6hgYEFeDRlbvCrxFBsiwoLHIB7/Rx5E/ioNcm0v2kZoT5c/mvr3+D0xzw03em5mqPiZPszrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Hw+XGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4Hw+XGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D216C1F00893;
	Tue,  2 Jun 2026 08:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780389781;
	bh=c8swZnlRMT715mTL7BNieLw6Nv67NxSLEBlb6g75v6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4Hw+XGXMWS3mTILwo1hFZRL1S57k26FJT1YKOf5UX7SS6nYDBSpg6lx19Gf0YC0b
	 JKdWsomICN0oIDGpFUlDLoHN4o6HWiwn9EcOTET7nDqeRuo0PCTBGguVpi6+daAUco
	 sF8zUynI7RPWiM45yRDYTR/XspOjGSR0rVp7OqyRgU3OFHziBiDlUUQaPWP96sdFxK
	 Fu0ahxwH0r+58dEbJjzxAKRvXrgWpPbmnVS7ktNkICvqvqpkzLw+DwfZ2Qc8VFVwZu
	 IPmPNS4exib8vW0CCCGtn4en70/9w3tSoG5LVXgbGKi0KRbTHYI/y+cWxcV1ccpG+/
	 2MndZN/fa06vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] LoongArch: KVM: Remove KVM_LARCH_LASX and
 KVM_LARCH_LSX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602074316.1647373-5-maobibo@loongson.cn>
References: <20260602074316.1647373-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 08:43:00 +0000
Message-Id: <20260602084300.D216C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The early return in `kvm_lose_fpu()` skips `kvm_lose_lbt()`, causi=
ng Loongson Binary Translation (LBT) state corruption, host `CSR_EUEN_LBTEN=
` leaks, and an unresolvable infinite loop of `EXCCODE_BTDIS` exceptions.

Pre-existing issues:
- [High] The KVM_GET_FPU and KVM_SET_FPU ioctls only copy 4 bytes per FPU r=
egister instead of the full 32 bytes (256 bits), breaking FPU state save/re=
store.
--

commit 15c9f849326e6c0a579e3f423cef163f4caaa1a2
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX

This commit removes KVM_LARCH_LASX and KVM_LARCH_LSX from vcpu->arch.aux_in=
use,
relying instead on the existing kvm_guest_has_lasx() and kvm_guest_has_lsx()
helpers. It simplifies the FPU state saving logic in kvm_lose_fpu().

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 53abf7aa61f86..523d4cf883439 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1417,31 +1417,32 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
>  /* Save context and disable FPU */
>  void kvm_lose_fpu(struct kvm_vcpu *vcpu)
>  {
> +	if (!(vcpu->arch.aux_inuse & KVM_LARCH_FPU))
> +		return;
> +

[Severity: High]
If a guest executes an LBT instruction without using the FPU, KVM's kvm_own=
_lbt()
sets KVM_LARCH_LBT in aux_inuse but leaves KVM_LARCH_FPU unset.

Will this early return bypass the kvm_lose_lbt() call at the end of the fun=
ction?

If kvm_lose_lbt() is skipped, does this leak the guest's LBT hardware state=
 to
the host CPU and leave KVM_LARCH_LBT permanently set in aux_inuse?

If the vCPU resumes on another physical CPU where LBTEN is disabled,
kvm_own_lbt() would see KVM_LARCH_LBT already set and do nothing,
potentially causing an unrecoverable infinite loop of EXCCODE_BTDIS excepti=
ons.

>  	preempt_disable();
> =20
>  	kvm_check_fcsr_alive(vcpu);

[ ... ]

>  		/* Disable FPU */
>  		clear_csr_euen(CSR_EUEN_FPEN);
>  	}
> +	vcpu->arch.aux_inuse &=3D ~KVM_LARCH_FPU;
>  	kvm_lose_lbt(vcpu);
> =20
>  	preempt_enable();
>  }

While reviewing this, I noticed a pre-existing issue in the same file:

arch/loongarch/kvm/vcpu.c:kvm_arch_vcpu_ioctl_get_fpu() {
    ...
	for (i =3D 0; i < NUM_FPU_REGS; i++)
		memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], FPU_REG_WIDTH / 64);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does the FPU_REG_WIDTH / 64 =
size
argument evaluate to 4 bytes instead of the full 256 bits (32 bytes)?

Because FPU_REG_WIDTH is 256, it seems this memcpy only copies 32 bits per
register. Will this cause a short read/write during KVM_GET_FPU and KVM_SET=
_FPU,
corrupting the guest's vector state during live migration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602074316.1647=
373-1-maobibo@loongson.cn?part=3D4
