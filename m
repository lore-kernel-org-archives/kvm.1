Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1F2F0673
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163472; cv=none; b=WL/ceTMBjb2YTbalTufC2rSx4+vtDe/K3J9QLeXzUFqv2WpiprJbyZkO9ptbxKhC5pJ9FoMcIfXcD0eDhl67VyWiHo+8ufoW7MsqxlD9pxtUl23XTWIfSGE0Li3b/wWZ5xz51IzRmPTccwYUPzMKLllojVJtrDQKZMdO6c2eTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163472; c=relaxed/simple;
	bh=ppNJmLV6658tWDojYFm+06hvuFLjE/mOdiawFhGCRrk=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=mQI/2tS1bwyVlwV4jNwyqduG/rWInViSYu1IJaWl0I1t+iItjVdYmuI1TXGtJpclyecRiKubKYscDTp8iqqWas3BYBB6IHqJ/mVA/VuFGSv3WVWHrjYHhfPXYGTDPjdA9ag01lA0KT+1DmiouV1Cb0UPNHFhwEfM/dFQdVaWGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVMMkspZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVMMkspZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8526C1F000C4;
	Fri, 16 Oct 2026 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792163470;
	bh=tfoYwHGpWoob9j79eePlF/8vDEDpbRjaid40f/a/wpU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FVMMkspZZBDWYpULlDBv+MRgpIdCOf6rH66NpyGXoFGkRFiQpN+wwZFzIxamLfb4T
	 JhUrVVbfOQnCF3EYql8CxWD0jsARgKh3bc7m44TqzvU+qKHPYzMjnKlL87hKGRYQQh
	 kEsAkfduJD4YkS1FoRGIYLr2sMTBmaeEFSO3JNX0bUyXqVGlSJ3iwrU/VAP6BNQ05t
	 mrFYjaDX1Cz9zX3CjhW6x+xCQD+RuKKW1KM0Cuea7o8/dVhuf22TnEZCrdSumLxz4w
	 WammSaxNpTrlLGwRE/NaT8xTjIiHWlEelMbaQvd24uAOEOG5+lye+e1wU/TzPyocS2
	 BNjh1W2kRyOaw==
Message-ID: <sashiko-outbox-174534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] KVM: x86/xen: Wait out memslot updates in the
 Xen attribute ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261016145646.579369-4-dwmw2@infradead.org>
References: <20261016145646.579369-1-dwmw2@infradead.org>
 <20261016145646.579369-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 15:11:10 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: x86/xen: torn guest wallclock read due to concurrent writers
--

commit dd1c2ed3d111f222bc79a42aa91b7852c3e338f8
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls

This commit updates Xen attribute ioctls to wait out memslot updates. To
prevent deadlocks, the waiting is performed without holding the xen_lock,
explicitly allowing some operations to run concurrently.

> This also means two kvm_xen_shared_info_init() calls can publish the
> wallclock concurrently, no longer excluded by xen_lock. That is
> harmless: concurrent writers compute the same epoch, modulo
> nanoseconds of jitter, and each re-reads long_mode to pick the
> destination, so the location for the final mode is always freshly
> written.

[Severity: Medium]
While the computed epochs are nearly identical, could concurrent writers
cause a torn read for the guest if the clock readings straddle a second
boundary?

If thread A and thread B compute the time concurrently, they might obtain
readings on opposite sides of a second boundary:
  Thread A: sec =3D 100, nsec =3D 999999999
  Thread B: sec =3D 101, nsec =3D 0

Because they both write to the shared structure non-atomically, their
updates can interleave:
  Thread A writes wc->sec =3D 100
  Thread B writes wc->nsec =3D 0

This would produce a time shifted by a full second (sec =3D 100, nsec =3D 0=
).

Because both threads increment the version counter using the same
read-modify-write pattern, the seqlock ends up in a valid, even state.
Would the guest then accept this torn time since the writers are not
serialized?

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -44,17 +44,24 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
>  	u32 wc_version;
>  	u64 wall_nsec;
>  	int ret =3D 0;
> -	int idx =3D srcu_read_lock(&kvm->srcu);
> +	int idx;
> =20
> -	read_lock_irq(&gpc->lock);
> -	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
> +	/*
> +	 * kvm_gpc_check() consults the memslots, so take kvm->srcu around
> +	 * each check and the write through the mapping =E2=80=94 but not across
> +	 * the refresh, which may wait for a memslot update to complete.
> +	 */
> +	for (;;) {
> +		idx =3D srcu_read_lock(&kvm->srcu);
> +		read_lock_irq(&gpc->lock);

[Severity: Medium]
Is using an rwlock for reading here what directly enables the concurrent
writes to the guest wallclock? Since multiple CPUs can acquire the read lock
simultaneously, the seqlock in the guest is no longer protected by serializ=
ed
writers.

[ ... ]

> @@ -98,9 +105,9 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
> =20
>  	wc->version =3D wc_version + 1;
>  	read_unlock_irq(&gpc->lock);
> +	srcu_read_unlock(&kvm->srcu, idx);
> =20
>  out:
> -	srcu_read_unlock(&kvm->srcu, idx);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016145646.5793=
69-1-dwmw2@infradead.org?part=3D3
