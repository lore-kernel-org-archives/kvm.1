Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046A3DDDC1
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138156; cv=none; b=aU+mybPoFcS191d/Bpfdxo9GNazDgZW62hbvaCwVMkheEZ97s30caIDmD/QKsXE6MBl/TZdCUdkuZ42yL6eltoUuX66BeMst5YcBLo7j/VFjql9mCK8pSBSP44VlWXrJWfsYBHJG4ZJMUeo+NE88Rn+ldWf4CY/iuGUr3JqPUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138156; c=relaxed/simple;
	bh=cQO2W4qahTeK8ReNqmWaxhXrxnBpw81ZOBucVdFBh6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3PDtAfHr3JS8gkDj/pJyeGO40WoPTdusaoqwM/3KfUjSRCR3Fvrlnmwb0ptTDoOYmQBnQEFmr/jGWdvYCC9ESa0bagiKYCAOWpzlohGGQlCltXzRen+RYm6EJ+fYm9BfJGFKsta/+Dsgah8KyRHVGNBfxYKti9WQAtzal7eF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5padguI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5padguI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECCD1F000E9;
	Mon, 27 Jul 2026 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138155;
	bh=LvHCf5wLigLXFZhUF8epNDByWOxRrKv/7yMC5VUgfg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5padguINC0mgm63iLvS6389Vjjo6opwJAcoQ2J2OIUfvE8Cl84zbYoZ/Z6fdHdSu
	 U7wE0s3L+qbJbn2AL7QR0KWuNxVINJKmUm14jmR0TniK3TzMCrd5D8Wct0BRsqeFHm
	 kLh8QdONnQ9umy6K5B8Hvhk3+FX6YZXaencvl+PSeWCnGfUgm5P8Rx8tX3einoVr8F
	 qaVgIS5pT75tZN33Y6svj+73cE4iZbaFs0RaxDV1vhLxAAyXOYA/g1lRsdOjFfYvWe
	 wmjL55+c6Gf0TAgSDxLrLRuVPoAYdUW9GerAVyqqFcULXr9byi1VnaBCaVlB3NcTlg
	 S7tkq+zUJhpug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] LoongArch: KVM: Add separate vmid feature support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727072109.2151675-4-maobibo@loongson.cn>
References: <20260727072109.2151675-1-maobibo@loongson.cn>
 <20260727072109.2151675-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 07:42:34 +0000
Message-Id: <20260727074235.1ECCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing VMID updating logic when `cpu_has_guestid` is true bre=
aks stage-2 MMU isolation.
--

--- Patch [3]: [PATCH 3/6] LoongArch: KVM: Add separate vmid feature suppor=
t ---
commit a0b8bed9027bd243aca0ea026c90d7c9e7dd4d26
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Add separate vmid feature support

This commit introduces support for a separate VMID feature on LoongArch
by checking the cpu_has_guestid flag. It adds different VMID update logic
and new stage-1 and stage-2 TLB flush functions.

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index c1e1d8424fa7e..3df46e02594f4 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c

[ ... ]

> @@ -282,10 +285,15 @@ static void kvm_check_vmid(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long vmid;
> =20
> -	vmid =3D vcpu->arch.vpid & vpid_mask;
> -	if (vcpu->arch.vmid !=3D vmid) {
> -		vcpu->arch.vmid =3D vmid;
> -		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +	/* On some machines like 3A5000, vmid needs the same with vpid */
> +	if (!cpu_has_guestid) {
> +		vmid =3D vcpu->arch.vpid & vpid_mask;
> +		if (vcpu->arch.vmid !=3D vmid) {
> +			vcpu->arch.vmid =3D vmid;
> +			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +		}
> +
> +		return;
>  	}
>  }

[Severity: Critical]
Does this bypass VMID assignment when cpu_has_guestid is true?

If cpu_has_guestid is true, the function falls through and returns without
assigning vcpu->arch.vmid. Since vcpu->arch.vmid is zero-initialized, doesn=
't
it remain 0 (which is reserved for the root/host environment)?

When kvm_switch_to_guest() in arch/loongarch/kvm/switch.S loads
vcpu->arch.vmid and writes it to hardware GTLBC.TGID:

	/* Set VMID for gpa --> hpa mapping */
	ld.d		t1, a2, KVM_ARCH_VMID
	csrrd		t0, LOONGARCH_CSR_GTLBC
	bstrins.w	t0, t1, CSR_GTLBC_TGID_SHIFT_END, CSR_GTLBC_TGID_SHIFT
	csrwr		t0, LOONGARCH_CSR_GTLBC

Will this cause guests to run with VMID 0 and break stage-2 MMU isolation?

> diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
> index 38daf936021d1..1d95e2208e82e 100644
> --- a/arch/loongarch/kvm/tlb.c
> +++ b/arch/loongarch/kvm/tlb.c

[ ... ]

> +/* Invalidate all stage2 TLB entries including GPA-->HPA  mappings */
> +void kvm_flush_tlb_all_stage2(void)
> +{
> +	lockdep_assert_irqs_disabled();
> +	invtlb_all(INVTLB_ALLGID_GPA_TO_HPA, 0, 0);
> +}

[Severity: Critical]
Is this function reachable?

Because the VMID updating logic appears to be omitted from kvm_check_vmid()
when cpu_has_guestid is true, is this stage-2 TLB flush function ever called
during VMID wraparound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727072109.2151=
675-1-maobibo@loongson.cn?part=3D3
