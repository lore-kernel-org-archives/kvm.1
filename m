Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE03370AED
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307228; cv=none; b=bj7SneTISjQ/o14JBg+ZKqp88IJL/GcVSpytq7dmmQPGV6d0uQCDBgtY04IMEeII9mW6X6Vgjjg3p0qC6/HTtpP0LQXFEGbJIKZSHnlOa3nmSvz6qL8mZB5c4l5IbuG5ZjbRn47UcPA+T042TkxSemDpIm2lawivrGz8aMoa8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307228; c=relaxed/simple;
	bh=PoZvuekzofMG7Iv4c5NZ9bcXL3xbYuTNNXmvU01YQtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LIu8FIqY5YrBJCvVn/AHay8KXDRFYUJHR2EF588dTf0lcUqWiNd7YpTyySLVa7gZmor3SLsWRRoq5y+Ec5k7qqpgBd9pveA1M70luswTyN/m1agKIXZgSSOrjXrTH+MK88JCGQogg4gqKc6B796ypNr77HsF6EreMRzox+JysyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFPJ2At9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFPJ2At9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5461F000E9;
	Wed, 24 Jun 2026 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307227;
	bh=S2GigpP+nSz65fKB/xc3CM5jHxk28+fTbj/L77QAuVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFPJ2At9ixKrzgFEwUJUvtJlu40p88jYxg/F54AzbLUXoClNPMhdGVRp6ngU7zLtx
	 IAd0Y8Jt5MvHsBgbdYPArMbmVmm6hrfKnNTU8fMDonsguL0YSHC8A58mfWbTnkjYpv
	 trFnz/xmOkx7MHKWY1GLWHIqorvft9+zo9Q7kqY/OY7pVPH1sAGIQlwRQlp83Y6FZ3
	 DgEf5dUqnK8FMF6iOVvtdbpZOdhfQWP/rM74HIaav+aG7Mj7aLwfKGD9dgskVO+rCP
	 WeV1Bef8TThQAxgj54zT/FmFnjsk9JezbAuYv7KPhL93pZCdnGiLUY39N69UTfDQh0
	 apKiYmrriBYhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: SBI FWFT: Apply LOCK flag only on
 successful set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeungJu Cheon" <suunj1331@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624130238.524706-1-suunj1331@gmail.com>
References: <20260624130238.524706-1-suunj1331@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:20:26 +0000
Message-Id: <20260624132027.2A5461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] SBI FWFT sub-features are enabled by default if supported by the h=
ost, violating KVM API architectural rules and breaking live migration.
- [High] Modifying FWFT features via KVM_SET_ONE_REG fails to set vcpu->arc=
h.csr_dirty, which can cause the hardware CSRs to remain out of sync with t=
he vCPU configuration.
- [High] Hardware feature probe in try_to_set_pmm() can be preempted, leadi=
ng to false negatives and host CSR corruption.
- [High] Direct hardware CSR modifications in FWFT set handlers break neste=
d virtualization (nacl) and are vulnerable to preemption.
--

commit 599bb2245d648d414e424da52cb50ced8f5d755b
Author: SeungJu Cheon <suunj1331@gmail.com>

KVM: riscv: SBI FWFT: Apply LOCK flag only on successful set

kvm_sbi_fwft_set() applies the caller's flags to conf->flags before
invoking the set() callback. If the callback returns an error, the LOCK
bit persists and the feature becomes permanently locked without its value
ever being changed.

Move the flags assignment after the callback so LOCK takes effect only
on success.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694f..a9b5bffc0e572 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -303,9 +303,11 @@ static int kvm_sbi_fwft_set(struct kvm_vcpu *vcpu, u=
32 feature,
>  	if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
>  		return SBI_ERR_DENIED_LOCKED;
> =20
> -	conf->flags =3D flags;
> +	ret =3D conf->feature->set(vcpu, conf, false, value);
> +	if (ret =3D=3D SBI_SUCCESS)
> +		conf->flags =3D flags;
> =20
> -	return conf->feature->set(vcpu, conf, false, value);
> +	return ret;
>  }
> =20
>  static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long feature,

While reviewing this file, I noticed a few pre-existing issues in
arch/riscv/kvm/vcpu_sbi_fwft.c:

In kvm_sbi_ext_fwft_init():

    if (feature->supported)
        conf->supported =3D feature->supported(vcpu);
    else
        conf->supported =3D true;

    conf->enabled =3D conf->supported;

[Severity: High]
This isn't a bug introduced by this patch, but it appears FWFT sub-features
are unconditionally enabled by default if the hardware supports them. Does
this violate the KVM architectural rule that new guest-visible features must
default to OFF?

Could this break live migration if a VM is moved to a host lacking support
for a feature that was silently exposed?


In kvm_sbi_ext_fwft_set_reg():

    case 2:
        ret =3D conf->feature->set(vcpu, conf, true, value);
        break;

[Severity: High]
This is a pre-existing issue, but does modifying FWFT features via
KVM_SET_ONE_REG fail to set vcpu->arch.csr_dirty?

When vcpu_load() runs on the same physical CPU, it bypasses
kvm_riscv_vcpu_config_load(). Can this leave the hardware CSRs (like
CSR_HEDELEG or CSR_HENVCFG) out of sync with the vCPU configuration?


In try_to_set_pmm():

    csr_set(CSR_HENVCFG, value);
    return (csr_read_clear(CSR_HENVCFG, ENVCFG_PMM) & ENVCFG_PMM) =3D=3D va=
lue;

[Severity: High]
This is a pre-existing issue, but is it safe to modify and read back the CSR
here without disabling preemption?

If the thread is migrated between csr_set() and csr_read_clear(), could this
result in false negatives and corrupt the original CPU's CSR_HENVCFG by
persistently leaving ENVCFG_PMM bits set?


In kvm_sbi_fwft_set_misaligned_delegation():

    if (!one_reg_access)
        csr_set(CSR_HEDELEG, MIS_DELEG);

And in kvm_sbi_fwft_set_pointer_masking_pmlen():

    if (!one_reg_access)
        csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);

[Severity: High]
This is a pre-existing issue, but do these direct hardware CSR modifications
break nested virtualization? By bypassing nacl_shmem(), the L0 hypervisor
might not observe L1's FWFT changes.

Also, since SBI_EXT_FWFT_SET exits are handled with preemption enabled,
could preempting or migrating these calls corrupt CSR_HEDELEG or CSR_HENVCFG
on a random CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624130238.5247=
06-1-suunj1331@gmail.com?part=3D1
