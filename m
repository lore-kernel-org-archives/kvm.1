Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A11312832
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934196; cv=none; b=A5fPIygD+GInu5tF2Tnxwp75ha0vlUY/KeE5Ro805hQclgzMTb9Fc+pVfZoWvJJezu8A8pgUYrjSlkIDJP3pi7gjLalf7m5mUEu9Xp/Q1Ahr1vVtf6TK3awd0IaC8isyprrZHN/7u3VcAYudrjL9nl5muyq0NG5S5P2LARWt7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934196; c=relaxed/simple;
	bh=bg62r0hNcvqP8s3AcvfQDhJsyq0NJ2Y39pxeGHySIXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=og9+vpDxjE8KVh1eMlR7DqOr0TPye7c51EfB9dVOOBryGUpGWRz7x4+EHPoFqyhMrYaVb02Wvxgw7QrPfEr9bp5Fl+rN+D0NVpS7FdHV2KVuEjnHvaB5RUBYCE8ECuYs33TDahh251wPGEXWCxUp3CL4GYR8o74PCy2FRBKb/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4ogS2GX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4ogS2GX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E921F00893;
	Mon,  8 Jun 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934195;
	bh=Z+ybRhnJKvLaBzzLjl/eWXCKnf4E3TuscKiJk4LlaHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4ogS2GX+fvghRKiRuSMHBlORh0vum2AGQ/EGfMwjdHVx98aUpEff64j2CNCfUmnk
	 HEVb1uPIJf7lH/Kbm+zyEZhDeIAahH0VhdPjoshkCylU/9IBjxJzf2bRYdZDhiz46h
	 aFdWUlYuQMs0oqHIDG0OFjg4RWMl2th1Np2d2m832rC1QE+9EXqgC9Tvn6YsvRwIfP
	 U3vaCi63jVQTyDQfIObwhgIGj2K2CJb6LneF/tGeHHrjee6IOnEPJymdgzKc63oJ+P
	 oxRDqF9FNnLkMbGutEhIa1tpPSrS7qQCBR5FpmgWWFaHDn81uKsL8hI3KQJdmjQcge
	 r4HCYdJtmdZFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/60] kvm: Add read accessors for kvm_vcpu scheduling
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-14-joro@8bytes.org>
References: <20260608144252.351443-14-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:56:34 +0000
Message-Id: <20260608155635.46E921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] LoongArch's `kvm_vcpu_set_pv_preempted()` calls `unsafe_put_user()=
` in an atomic context without disabling page faults, which can lead to a '=
scheduling while atomic' panic.
--

commit 3087f4d4153f32bcbd70753c3a4b6b003d538bfa
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Add read accessors for kvm_vcpu scheduling state

Introduce accessor functions for the scheduling state in struct
kvm_vcpu to make it easier to move these fields to struct
kvm_vcpu_common.

[ ... ]

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e682..bde8b68b82738 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1847,7 +1847,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  	int cpu, idx;
>  	unsigned long flags;
> =20
> -	if (vcpu->preempted && kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEM=
PT)) {
> +	if (kvm_vcpu_preempted(vcpu) &&
> +	    kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
>  		/*
>  		 * Take the srcu lock as memslots will be accessed to check
>  		 * the gfn cache generation against the memslots generation.
>  		 */
>  		idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>  		kvm_vcpu_set_pv_preempted(vcpu);

[Severity: High]
This is a pre-existing issue, but this path appears to call unsafe_put_user=
()
in an atomic context without disabling page faults, which can lead to a
'scheduling while atomic' panic.

kvm_arch_vcpu_put() is called with preemption disabled (via vcpu_put() or
the scheduler's kvm_sched_out() preempt notifier). From this atomic context,
it calls kvm_vcpu_set_pv_preempted(), which does the following:

arch/loongarch/kvm/vcpu.c:kvm_vcpu_set_pv_preempted() {
    ...
    st =3D (struct kvm_steal_time __user *)ghc->hva;
    unsafe_put_user(KVM_VCPU_PREEMPTED, &st->preempted, out);
    ...
}

Because unsafe_put_user() does not implicitly disable page faults (unlike
x86's copy_to_user_nofault()), a page fault on a valid but swapped-out
userspace page will cause the kernel's fault handler to proceed to
handle_mm_fault().

Since handle_mm_fault() can sleep, could this trigger a 'scheduling while
atomic' BUG and crash the system under memory pressure?

Additionally, is unsafe_put_user() improperly used here without the required
user_access_begin() and user_access_end() wrappers?

>  		srcu_read_unlock(&vcpu->kvm->srcu, idx);
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D13
