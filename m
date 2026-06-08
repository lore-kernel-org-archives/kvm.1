Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B70148850
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935397; cv=none; b=cpmhlf9VywMO2UJZjq/JAQmpLAUepZEGK30QLBU9q4IPRH/WWcY0AVVp8Ml0UFgCvfQRBY+yw1emjYC64WI32Z6g8OZHJwkLXGlCRsBmbdmZeFlbsGYAcmttUy1elAdDNl2A4uLdjuH/eWpQVSScShxfoKvus8LG6jxWwfCCyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935397; c=relaxed/simple;
	bh=rScWtZM9oIu+trzB/s88zJGkmIVmKE5gCgAemCVD/E4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XrSbVUPUje6gTu2B5qHDcPhksBFXQv6Zn5ENJKB3dlR/kLUe0MOQrjxWpIozkqhd0z/bGAeSkzOKemITwogCtqHWN6LpPHW6ynW+/R8RmxrLPSkljJP008s8Tq/qboBmfsK1tFa02VDqQc0FHQUYglyhDIXwyBvHcdfdwZhNvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dggctimj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dggctimj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB6D1F00893;
	Mon,  8 Jun 2026 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935396;
	bh=+2Ia/M/IWUwgY0RO9n26XX0Ry1008/5zSpJO2vschmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DggctimjdQpy24MRF7LT3Sqh2668j3NM9cqqUVY1zyWSM9dfgZsmAwIWP/nHYv/SH
	 eGMBsHS6fzea0d09ZBWjEtvQrmerxcf7UfJj6KqMPTbICC2dgKq7p2VUP6vGa7Qv3/
	 lPQ3yKkdvYOqNasmQD1SZ8AbJEP3up74n/8OqDwDcr0njRXegFAdOWEJmslxeuEdLw
	 dwZ+P163TPu85bOxXThjv7zZzcgAMN27DjGrIT78vy2y7lBnH0MNMR2J/Hiac++e9D
	 5caT+f27ucnfPTF0UUwubzeIj8/+URA/n+8DInR+/NLYoZUJlp/a1MCdLh5Z/3itr/
	 6LKe7VcKStAbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/60] kvm: Introduce accessors for kvm_vcpu->mode
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-20-joro@8bytes.org>
References: <20260608144252.351443-20-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:16:35 +0000
Message-Id: <20260608161636.3FB6D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly introduced accessors `kvm_vcpu_mode()` and `kvm_vcpu_set=
_mode()` perform plain memory accesses, which causes the inadvertent remova=
l of `READ_ONCE()` and `WRITE_ONCE()` annotations from existing concurrent =
code paths.
--

commit e412a3aa4c759d9d7837663a68f8f88fd426f534
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Introduce accessors for kvm_vcpu->mode

Introduce accessors to make it easier to move this member of struct kvm_vcp=
u.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -2272,7 +2272,7 @@ static inline bool kvm_vcpu_exit_request(struct kvm=
_vcpu *vcpu)
>  {
>  	xfer_to_guest_mode_prepare();
> =20
> -	return READ_ONCE(vcpu->mode) =3D=3D EXITING_GUEST_MODE ||
> +	return kvm_vcpu_mode(vcpu) =3D=3D EXITING_GUEST_MODE ||
>  	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
>  }

[Severity: High]
Does the removal of READ_ONCE() here expose this to compiler optimization
issues?

Because kvm_vcpu_mode() is implemented as a plain read, this change silently
drops the data race prevention annotation. The vcpu->mode variable is acces=
sed
locklessly and concurrently by multiple threads.

Without READ_ONCE(), could the compiler perform unsafe optimizations like
load-hoisting that lead to missed exit requests or KCSAN warnings?

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -3959,8 +3959,8 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wa=
it)
>  	 * within the vCPU thread itself.
>  	 */
>  	if (vcpu =3D=3D kvm_get_running_vcpu()) {
> -		if (vcpu->mode =3D=3D IN_GUEST_MODE)
> -			WRITE_ONCE(vcpu->mode, EXITING_GUEST_MODE);
> +		if (kvm_vcpu_mode(vcpu) =3D=3D IN_GUEST_MODE)
> +			kvm_vcpu_set_mode(vcpu, EXITING_GUEST_MODE);
>  		goto out;
>  	}

[Severity: High]
Can this plain write cause store-tearing or dropped wakeups?

Similar to the read in kvm_vcpu_exit_request(), replacing WRITE_ONCE() with
kvm_vcpu_set_mode() in __kvm_vcpu_kick() drops the compiler annotation since
the new setter performs a plain write.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D19
