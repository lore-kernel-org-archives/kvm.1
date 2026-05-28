Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B571305669
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992007; cv=none; b=HY41ZhphpExWrqYRGROTjXngdUaVcH1KcIDOcLNgo3ASK4QUxiyo3yRqBHx2qOtnuxSrhyNb80olHThGnRQGweDfoS9Bp9o7Osy24yif2+iScHqHHgacVcHTApn1/9bPkDWxs1OUtD25luOUL35E6EOHmj064h9UioU7qlf/jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992007; c=relaxed/simple;
	bh=5j2sJUYj905ZYCpGHja6+/wgUl4hi14Fk24VF9g3Yhg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfBwa0d5UVrJtmNGOpKqNM4FWzSoIh+U3jpECSD5jie/Zz3RMixiwmt/Cpkh+Y3eMlYl7sT98BDWt82Nb4lGVgc+n/dZkccapUZP3+MUsz2E64I0YYR+0KjJfhjB087tTWZFZ5fOJwuYyAXjX2WF8rjGCWdHVdKR07XBxZ7vVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqN/UZir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqN/UZir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D980A1F000E9;
	Thu, 28 May 2026 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992006;
	bh=gi2JNGIG/jJAN75Qckkmw5RT/OojAFc1WmcEx3LfWwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iqN/UZirTc5wQM5DLZiEpoUnkh2oTyXk3NA/bZT5DMVreLVhsiWCCDNdbgmQ98OHa
	 8TAAzdXcjbDY8onvD4Mp90Eez7eQXlPM1KBJXuRoj7Wvfwvtxbves56Twifm9D/ozs
	 4OSqQ5hz+nGOcggQcSXG7BOGLPfMYzQMYDVyoE3wvTT1atiXr1+1zJZmvrIkKOQKFR
	 pfry0KDhllKd6ZWP78codHWgqBrAOGd34ldVIE0LMaf893TxWVbWpd8bPZxv00MvZV
	 SLKZSim8a11PRj/WGXacWBIUt87AjjarLJlCGMXl3AFq2QpqLo3fw07fySP7rpFoiO
	 3szPp45myyH0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] KVM: s390: Prevent memslots outside the ASCE
 range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528114727.142178-8-imbrenda@linux.ibm.com>
References: <20260528114727.142178-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:13:25 +0000
Message-Id: <20260528181325.D980A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Accessing `kvm_memslots(kvm)` without holding `kvm->slots_lock` or=
 the KVM SRCU read lock triggers an unconditional lockdep warning.
- [Medium] Asymmetrical memory limit checks can cause false-positive `-EBUS=
Y` errors when re-applying the exact same memory limit.

Pre-existing issues:
- [Critical] A data race on `kvm->created_vcpus` allows the memory limit to=
 be modified concurrently with VCPU creation and execution, leading to hard=
ware use-after-free or host panic.
--

commit d947d07a1de4770a70d881cc020678eb270baac3
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Prevent memslots outside the ASCE range

This commit introduces checks to prevent creating memslots beyond the
configured maximum guest address and prevents lowering the limit below the
highest existing memslot.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e09960c2e6ed1..875f6e2a4a52a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1015,8 +1015,26 @@ static int kvm_s390_set_mem_control(struct kvm *kv=
m, struct kvm_device_attr *att
>  			return -EINVAL;
> =20
>  		ret =3D -EBUSY;
> -		if (!kvm->created_vcpus)
> -			ret =3D gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
> +		if (!kvm->created_vcpus) {

[Severity: Critical]
This is a pre-existing issue, but is it safe to check kvm->created_vcpus
locklessly here?

A concurrent KVM_CREATE_VCPU ioctl, which holds kvm->lock, could increment
created_vcpus and allow the newly created VCPU to start running via KVM_RUN.
If that happens, gmap_set_limit() might mutate the gmap->asce value
concurrently with the VCPU running in SIE.

Because gmap_set_limit() can free top-level page tables, the running VCPU
could read a torn asce.val or continue using the old ASCE while its tables
are freed. Could this block be protected by kvm->lock, similar to how
KVM_S390_VM_MEM_ENABLE_CMMA handles it?

> +			struct kvm_memslots *slots;
> +			struct kvm_memory_slot *ms;
> +			int bkt;
> +
> +			ret =3D 0;
> +			mutex_lock(&kvm->slots_arch_lock);
> +			slots =3D kvm_memslots(kvm);

[Severity: High]
Does this trigger a lockdep warning?

The kvm_memslots() accessor invokes srcu_dereference_check(), which expects
either kvm->slots_lock or the KVM SRCU read lock to be held. Since only
slots_arch_lock is acquired here, an unprivileged user calling
KVM_S390_VM_MEM_LIMIT_SIZE might deterministically hit a lockdep assertion.

> +			if (slots && !kvm_memslots_empty(slots)) {
> +				kvm_for_each_memslot(ms, bkt, slots) {
> +					if (gpa_to_gfn(new_limit) < ms->base_gfn + ms->npages) {

[Severity: Medium]
Will this check cause false-positive -EBUSY errors if the exact same memory
limit is re-applied?

KVM_SET_USER_MEMORY_REGION allows creating memslots up to the rounded
hardware ASCE limit. If a user sets a limit and creates a memslot that gets
rounded up beyond the requested limit (which succeeds), and then tries to
re-apply the same limit, it appears this check would evaluate to true and
fail.

> +						ret =3D -EBUSY;
> +						break;
> +					}
> +				}
> +			}
> +			if (!ret)
> +				ret =3D gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
> +			mutex_unlock(&kvm->slots_arch_lock);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528114727.1421=
78-1-imbrenda@linux.ibm.com?part=3D7
