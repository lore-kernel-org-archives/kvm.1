Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D6327C18
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096876; cv=none; b=tTNHAHWO9lUJBVoPgxD7mFHA/02nFbj1mYNEgawl09+vWvhWm19m3pGdhvs2MTJ90g/K/dcDVuhUeq9i5PHB5X0Vd9O581Dqsnui9TIjFD1EgGs/isMZF9v0YfIHZbU5u93s2NiPcWWixz1+N6Dpe4pxeV4Z+hBmvmkSgJAtXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096876; c=relaxed/simple;
	bh=QG7cznZ0AjZjBno/rgpRPnZxy/zYLa4V/UispCvCWyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AcvyWnm4Sltw1VpP98S2btVnCBfTT3uhddwWd1hpw6wW4/BbOQDzNkbbuVa/2qs+b7OP42/bQi8YeFr8PEq7C/hGUjP+jY/fiUwUg2jph7L74qXw6Y9GhVqszx2LCJezvpxXOPWh/Sz4xJ9UBVp3XX4QeWlpwT+ApVRYu7c/rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayDsuljd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayDsuljd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D7A1F00893;
	Fri, 29 May 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096875;
	bh=LvykK717vNRykOTvnIlgBuDMoCLenZtCWZfG5KeysxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ayDsuljdLhpz4QFQ7ze54+GXY0CYBdazdIq37JTdWy961inuI5jQG6G5bQDRNbYyW
	 ZIJgElEiK0YMGzf9yVKttaASqSBogwXLpFxKPBWXkv+0NfC4Rupjg8GPUjLyDA6rlw
	 mtfLNXX+QT0dHSz/SqFjbMTCykyBnVUL2JO846Kee5qUEl9+0S0wTglvoOEfZF2TBe
	 1PLV/twbhHd7z8DcePxSoLJECRc+0seYkUOspFGR1i2T8hXtw9tNytVrOEiFlvZvpL
	 3hrNMgSbWW/r6LULd0wAwfuFbb06DEe1pWKaz0l1F436C1/KJ/JNMT9hr29K05aCt5
	 tmlc82YbahLHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/24] KVM: SEV: Make it more obvious when KVM is
 writing back the current PSC index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-12-pbonzini@redhat.com>
References: <20260529183549.1104619-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 23:21:14 +0000
Message-Id: <20260529232114.F1D7A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious guest can cause an infinite kernel loop and a soft loc=
kup by concurrently modifying the GHCB scratch area during unsupported PSC =
operations.
--

commit 7f37f8948c706d884d14a7c69279c900524daced
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Make it more obvious when KVM is writing back the current PSC ind=
ex

This commit moves the guest-visible "cur_entry" index increment outside the
inner for-loop. It also adds a comment to clarify which code modifies trust=
ed
versus guest-accessible data.

Message-ID: <20260501202250.2115252-12-seanjc@google.com>

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3947,7 +3947,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  	}
> =20
>  	/* Find the start of the next range which needs processing. */
> -	for (idx =3D idx_start; idx <=3D idx_end; idx++, hdr->cur_entry++) {
> +	for (idx =3D idx_start; idx <=3D idx_end; idx++) {
>  		entry_start =3D READ_ONCE(entries[idx]);
> =20
[ ... ]
> @@ -3974,6 +3974,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
> =20
>  		if (npages)
>  			break;
> +
> +		/*
> +		 * Increment the guest-visible index to communicate the current
> +		 * entry back to the guest, e.g. in case of failure.  No need
> +		 * for READ_ONCE() as KVM doesn't consume the field, i.e. a
> +		 * misbehaving guest can only break itself.
> +		 */
> +		hdr->cur_entry++;
>  	}
> =20
>  	if (idx > idx_end) {

[Severity: High]
This is a pre-existing issue, but since we're examining how a misbehaving=20
guest affects the PSC processing loop, is it possible for a guest to trigge=
r=20
a soft lockup here?

Looking at snp_begin_psc(), if the guest submits an unsupported PSC operati=
on,
we hit the default case and loop back:

next_range:
    idx_start =3D READ_ONCE(hdr->cur_entry);
    ...
    switch (entry_start.operation) {
    ...
    default:
        __snp_complete_one_psc(svm);
        goto next_range;
    }

If a malicious guest concurrently resets hdr->cur_entry back to 0 in the
GHCB shared memory, could the host get trapped continuously reading an
index of 0 and re-processing the same unsupported entry?=20

Since there is no yield or exit to userspace in this default case, it seems=
=20
this might trap the host thread in the kernel while holding vcpu->mutex,
leading to a persistent soft lockup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D11
