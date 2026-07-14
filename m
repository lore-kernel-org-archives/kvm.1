Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBC3CAA55
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052857; cv=none; b=TIv0nN/gLGvT2uhKpDkmSOtNwZqcKcodvEMpg2fsLS6vAhiuAcMc7WGo5NNg5FB9W3D0eNayZzXyWslb5pYB/Wy7jl+vvN7he7b96EzPu6GiX/h/pgwKkCPBZ1DG+cts99nA/LFbnKx+4CebMBzkLR9IrUbuoJy1JjtQpq3505U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052857; c=relaxed/simple;
	bh=eT//DqQoTtDcHwvlqXerr1xOn9oACvuaPsXO5Ek3wrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WE4Jke5smtTsLwJjis3/MSppElxMyY5tJgJf6MB9mOfk3SGdIQjuWLYBQoUc765uG541KQBfDs5XhecRgjhxdI5xUXx7yJcIUsOM4lvzi7ViqIkgvx7PjBAnZ0bKuuUiBPh4nLMG1ekIYZhWEDtk51M9aH+jmssZ/q6AyrHALBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3k8hsMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3k8hsMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF05F1F000E9;
	Tue, 14 Jul 2026 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052856;
	bh=s/en7QsU9rQ33bEzkc4NZ//o9B9ROWJVcSBJce/7NoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3k8hsMpV5wD1IMKSBhpG06do7FHKULFzGdyNTPRY6GqBq1lzI6tlOpRhpho00M+e
	 k2kCaxBDYWlWK8o952WtwUPLQcVuyDB5j69NSN62p25ORXuHzwRd2BmzpX4gNC0xeg
	 CZBYhsUQ+JiwDh9C1bQ+9Z91K9qiyOKNbTku+a+E6At7Ad0wkBLP4+5u/j1lPPCFL0
	 7v2WAh5htBNcLo7cfLEshUT8mMUXBIBGNaqjmCHAwc2HcaC2YzRvCfk4oWw835PlMD
	 SBQ1aUE3OgLqHZ7DeMPrVcuWqvUtFYTauX6rBSDUZAH0uRjRsrGQhOT7UvQBuBDns1
	 IRi598OoLVIcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714175432.86388-1-amachhiw@linux.ibm.com>
References: <20260714175432.86388-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:14:15 +0000
Message-Id: <20260714181415.DF05F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Destructive API failure corrupts shared vcore state (`arch_compat`=
, `pcr`) but only updates the per-vCPU `sane` flag, desynchronizing sibling=
 vCPUs.
- [Medium] Lockless read of the shared `vcore->arch_compat` in `kvmppc_sani=
ty_check()` causes a data race.
--

--- Patch [1]: [PATCH v5] KVM: PPC: Book3S HV: Validate arch_compat against=
 host compatibility mode ---
commit 3439effb1356334e2a4fa14fb4f8e03f83d0556d
Author: Amit Machhiwal <amachhiw@linux.ibm.com>
Date:   Tue Jul 14 17:54:32 2026 +0000

KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode

This patch introduces early validation of arch_compat during guest
initialization. When an unsupported arch_compat is requested, it detects the
mismatch, sets arch_compat to PVR_ARCH_INVALID, and prevents the vCPU from
running.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..f9380ef657500 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
[ ... ]
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
>  }

[Severity: High]
Does this error path corrupt the shared vcore state for sibling vCPUs?

If userspace requests an unsupported arch_compat on one vCPU, the shared
vcore state (arch_compat and pcr) is poisoned. However, kvmppc_sanity_check=
()
only updates the per-vCPU sane flag for the calling vCPU:

arch/powerpc/kvm/powerpc.c:kvmppc_sanity_check() {
    ...
out:
    vcpu->arch.sane =3D r;
    return r ? 0 : -EINVAL;
}

Because the sanity flag is cached per-vCPU, sibling vCPUs would not get
updated. If userspace ignores the error on the first vCPU and attempts to r=
un
a sibling vCPU, could that sibling bypass the validation in
kvmppc_vcpu_run_hv() since its individual flag is still true? This would
allow it to enter the guest with the corrupted vcore state (raw mode).

Conversely, if userspace later fixes the vcore via a valid request on a
sibling vCPU, does the first vCPU remain permanently dead because its cached
sane flag is not re-evaluated?

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..b6b83fe3233f3 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -258,6 +258,12 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
>  	if (!vcpu->arch.pvr)
>  		goto out;
> =20
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	if (vcpu->arch.vcore &&
> +	    vcpu->arch.vcore->arch_compat =3D=3D PVR_ARCH_INVALID)
> +		goto out;
> +#endif
> +

[Severity: Medium]
Is there a data race when accessing the shared vcore->arch_compat here?

In kvmppc_set_arch_compat(), the modification to vcore->arch_compat is done
while holding vc->lock:

arch/powerpc/kvm/book3s_hv.c:kvmppc_set_arch_compat() {
    ...
    spin_lock(&vc->lock);
    vc->arch_compat =3D arch_compat;
    ...
}

However, the read in kvmppc_sanity_check() occurs locklessly.

If a concurrent operation like KVM_SET_SREGS on a sibling vCPU calls
kvmppc_sanity_check() under its own per-vCPU mutex, could it race with
a KVM_SET_ONE_REG updating the compatibility mode on the first vCPU?

Since lockless access to shared variables usually requires at least READ_ON=
CE()
and WRITE_ONCE() to prevent compiler optimizations like tearing or stale
caching, should this read be protected or use READ_ONCE()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714175432.8638=
8-1-amachhiw@linux.ibm.com?part=3D1
