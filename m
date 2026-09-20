Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A333D8902;
	Sun, 20 Sep 2026 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941983; cv=none; b=gzP9G/f4hRQEJlwvruWzNfmKrKlYkYpq6smc8+Iq+azoOO38GWfNL9Ck0VuXyCvKaAcUiyIfYTYqvSgFvelCw0InAgp3d+/9DixFBYwd9atK0B7ZgvMIHGi9PISxWhSyMSuyWik81g+A8FLRRpYQ4GUmuP1igj1KLZJVvcKDClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941983; c=relaxed/simple;
	bh=7KsZAiziTOOr/DbU04KxKAm/6Gd7N6oiNCv7Tb22eUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hq1hY84qtviXJzRgTddjbGcaLeZ/uf12RFesLX8uowDMQdpFJjDsETow+anupJ3g97HLZQEupA8ccJxwUOMvwrel1hw2XGEE/v47hZrn+CIUysV4jn+lPNc0/E/Q8sMnKwCBNqJJbCX+3cSZ0ALA/Ip+ssye1rrSssVGAp/+rqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGboTFOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGboTFOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7D21F000FF;
	Sun, 20 Sep 2026 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941977;
	bh=g/qaINeHiqA2KhUtssNRdjMI4ZVktcT4zFMvhkMkS+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGboTFOtgHX4iHMo5u+5INK3e5RDc7rGYOrjN/Lg9HM0hkugm2uS+8KKvPhmdvgp1
	 VZSvwqyWUE0bEIxUB+HXbPksDXHMcxEeSdSYmss01De/f4X05FSPIpn9CPJ4T59PGQ
	 nXKcQVh1K/GMllZvO7sdY810zA3N0K1RVstysgTPcNxoL5mepk2z7xeEcp5H7N+Jt2
	 3T1nLSYJPDApEoOBMpArGeELGoxA9wYlMzWmENFFduTwgvsiCgZJruoqaVMPvnMH6Z
	 qNFdByspTf61lE/WcrNuw83UQ/FWuRHphGUKJIvEeYpmm8Na/4tRYFshA5MjQG5V4j
	 eWGN1GpbWIcdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/17] KVM: x86: Use gfn_to_pfn_cache for steal time /
 preempted status
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260920211920.928306-7-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 22:06:16 +0000
Message-Id: <20260920220616.AC7D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: Missing definitions for srcu_read_lock_atomic and synchroniz=
e_srcu_atomic
--

commit 73f7f7addf4a338b749e65de38df63e40795698c
Author: Carsten Stollmaier <stollmc@amazon.com>

KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status

This largely reverts commit 7e2175ebd695 ("KVM: x86: Fix recording of
guest steal time / preempted status"), which dropped the use of the
gfn_to_pfn_cache because it was not integrated with the MMU notifiers
at the time. That shortcoming has long since been addressed, making
the GPC work correctly for this use case.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3db1855aba798..116932e13d595 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2065,42 +2064,27 @@ static void record_steal_time(struct kvm_vcpu *vc=
pu)
>  	if (WARN_ON_ONCE(current->mm !=3D vcpu->kvm->mm))
>  		return;
> =20
> -	slots =3D kvm_memslots(vcpu->kvm);
> +	/* We rely on the fact that it fits in a single page. */
> +	BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
> =20
> -	if (unlikely(slots->generation !=3D ghc->generation ||
> -		     gpa !=3D ghc->gpa ||
> -		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
> -		/* We rely on the fact that it fits in a single page. */
> -		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
> +	idx =3D srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
> +	while (!kvm_gpc_check(gpc, sizeof(*st))) {
> +		srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);

[Severity: Low]
Are the definitions for srcu_read_lock_atomic(), srcu_read_unlock_atomic(),
and synchronize_srcu_atomic() missing from the kernel tree? Compiling this
patch results in an implicit declaration or undefined reference linker erro=
r.

[ ... ]

> @@ -2657,20 +2632,31 @@ static void kvm_steal_time_set_preempted(struct k=
vm_vcpu *vcpu)
>  	if (unlikely(current->mm !=3D vcpu->kvm->mm))
>  		return;
> =20
> -	slots =3D kvm_memslots(vcpu->kvm);
> -
> -	if (unlikely(slots->generation !=3D ghc->generation ||
> -		     gpa !=3D ghc->gpa ||
> -		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
> -		return;
> -
> -	st =3D (struct kvm_steal_time __user *)ghc->hva;
> -	BUILD_BUG_ON(sizeof(st->preempted) !=3D sizeof(preempted));
> -
> -	if (!copy_to_user_nofault(&st->preempted, &preempted, sizeof(preempted)=
))
> +	/*
> +	 * This is called from the scheduler path (via kvm_sched_out), so
> +	 * the cache cannot be refreshed here.  Setting 'preempted' is
> +	 * best-effort anyway; the old HVA-based code used
> +	 * copy_to_user_nofault(), which could also silently fail.  If the
> +	 * cache is invalid, it will be refreshed from task context by
> +	 * record_steal_time() before the vCPU next enters the guest, since
> +	 * kvm_arch_vcpu_load() unconditionally raises KVM_REQ_STEAL_UPDATE.
> +	 */
> +	guard(srcu_atomic)(&vcpu->kvm->gpc_srcu);

[Severity: Low]
Does the guard(srcu_atomic) definition in include/linux/srcu.h also referen=
ce
the undefined srcu_read_lock_atomic() function, which breaks the build?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D6
