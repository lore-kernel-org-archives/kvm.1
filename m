Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F749E5D2
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303366; cv=none; b=c4CsgUoEOLliu6bePQDunkHC40t8lzBxAKZPOBqU9YYKtRBn7YMWaHl1bwNw2y5+Mwbwt0v2PqbCDCnTUo2Fg52GfyAevKFMyxyR7KMGlhVDZcnGl+kTKDmzzcWjf16SslX4K1zBECw4nlahR5Ahyl7D61WNLnDMr5SPh9HAv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303366; c=relaxed/simple;
	bh=HKk6ziAXN1Ypc99k3IKDs5ke0WrgufeEXm7jTYiCOgM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DM7gZDowhCcgRvULrBb0gUSEqSc0OBcEB+mIYRDs2vzdJfHHOqHJU1mv61m0xzXL3hH4IwOu38XJmD2Wo2PnzDJR4rNY0TFJ5mRTd1j0lfsbbGPgDH4wnVAwv6VX2B0HC9I10xnmFu03mrl5DNQQn5vrKvo9wO0ShZY8RYu5TGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN1FCvhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN1FCvhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA0E1F0089B;
	Tue,  6 Oct 2026 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303364;
	bh=L6/yKBCd7cMj2Zv3CRFNGBRR+U4fCvYTjxawzfBiPqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kN1FCvhRr4g3QADRz8yH7GuQmoEFERpdnrzkCuCkJaKou9Nw+HuRFnGkSGF4hK0fI
	 JJmWiUmcZi82dPW4BQRI1fl1mr17+BfcbtXZ43oIfW8zx3ZV9DaDbFnqN52lwtTsZr
	 XI8w89dPVC3JKPkyAhwjpIgho6hkBS3nyITJpakcHYsvx7B552Y3c4Cf9yrbxR9Gpd
	 5is7dcHcIpJjnOhJT4meDnBwXC8mhWszDAMCBDBNQO6N+foqfNoxFHGCCnaSAz6Vih
	 xVlYzDQExoHH+mDeIEODxfnmzgID+481xcCU5N57w0k5qy0E1UfhI9ApgG/nK7+6/L
	 aag2U91fQT1cg==
Message-ID: <sashiko-outbox-162228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/8] KVM: selftests: Only warn for idle-page checks
 on powerpc pseries LPAR
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <0227000da4e6fe69b278dc971b74b3f65b73ead9.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
 <0227000da4e6fe69b278dc971b74b3f65b73ead9.1791280439.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:16:03 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: typo 'explicitely' in comment
--

commit 87fed9598d0ceb8998ad38373e71f38a0d2446ab
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: selftests: Only warn for idle-page checks on powerpc pseries LPAR

This commit updates the access tracking selftest for KVM to only warn on
idle-page checks when running nested on powerpc pseries LPAR. It uses a new
kvm_is_ppc_pseries_lpar() check to detect this condition because nested KVM
on powerpc does not explicitly flush the TLB for access bit updates.

[ ... ]

> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/to=
ols/testing/selftests/kvm/access_tracking_perf_test.c
> index 4415c94b28660..eb6939065e793 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -471,6 +471,16 @@ static int access_tracking_unreliable(void)
>  		return 1;
>  	}
>  #endif
> +	/*
> +	 * PowerPC: Nested KVM (pSeries LPAR) can hide accessed/idle, since KVM
> +	 * doesn't explicitely flush the TLB for access bit update. L0 keeps

[Severity: Low]
This isn't a bug, but there appears to be a typo here. Should explicitely be
spelled explicitly?

> +	 * translations cached so the guest won't see the idle bit cleared.
> +	 */
> +	if (kvm_is_ppc_pseries_lpar()) {
> +		puts("Skipping idle page count sanity check, because the test is run n=
ested");
> +		return 1;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791280439.gi=
t.ritesh.list@gmail.com?part=3D7
