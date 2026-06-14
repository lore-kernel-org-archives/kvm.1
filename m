Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07C2772E
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395834; cv=none; b=s6/dLSKvUUz2QDTWFhZmDoTIKJQK0EALP6AXwGxtDMMKrPc3Aj9IICIlegpY5WqRducqzzG1VPSgpyhGD0NPM3/ufrv1ZJVSWGh5OQDxe9+6rkGENVT10X/sqWjcoXedbpAf80kqaokAUnetdnUgzyWve6Ni2bONlyXDMgXYH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395834; c=relaxed/simple;
	bh=xGUors3c7Ng2SEnzZKboJfHrS8KqBcGkUG+KekV1JpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ukPObYTiw7eVKLlX5ftfaU7xxeL0wqXYkkG0xSYHbTODPIOOr2Twg6JuPPkjwlH7GnU3Y64iZBKlAmeDD2lh/rSdVrcDLjeaeY3Ig82soujsTr7zuVMofbbH5S/9y/J3cCQIQ6MlPr1UKN+Fm8UMytDkgN12d7g+q367e7rse+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK+dQej8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK+dQej8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CCD1F000E9;
	Sun, 14 Jun 2026 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395833;
	bh=PL9U9B0fi6+q/ib0vIaoVgGyAje6t2c3XAJ+EFrwYy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YK+dQej8Rv5NDymw+6aaLc7mC9fjZwDEWlUaus46UHK5x3+fMTmqPLETJopSNAxGH
	 KM6b6MRzBYhPelopcfb2jJMgyLpXuVxZHxkS3de9zzwsLzi9N/KewkjeKxKPgT3MSf
	 i3tw7uHgsxxXyXtedA4LsNHgeYrcRdZjWFYZiQciS3pM6569YBI5OWu96E8QWBcRmp
	 jud/lqr5NMP4c6750j7R3txGqBqLrQi+ia2X0fJbruU1TqQpS/HKl30rsy9s6tRr7e
	 3cFmMsW/bKs2Nuvj9NOWFWLe32zy9zVK63NkEnuplgdlozq5s8V5Ek00ykWJDqqqM2
	 LhhzG5ymyBY4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Octavian Purdila" <tavip@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260613000953.467473-2-tavip@google.com>
References: <20260613000953.467473-2-tavip@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 00:10:32 +0000
Message-Id: <20260614001033.09CCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Exporting iov_iter_restore() and using it for generic transports i=
s unsafe, as it fundamentally lacks support for modern iterators (ITER_FOLI=
OQ, ITER_XARRAY) and corrupts state.

Pre-existing issues:
- [High] iov_iter_restore() contains a parenthesis error in its WARN_ON_ONC=
E condition, causing it to spuriously emit a kernel warning when called wit=
h an ITER_KVEC iterator.
--

commit 169d794e6c649159c82a4c128f4edf768368df54
Author: Octavian Purdila <tavip@google.com>

iov_iter: export iov_iter_restore

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1469,28 +1469,29 @@ void iov_iter_restore(struct iov_iter *i, struct =
iov_iter_state *state)
>  {
>  	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
>  			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
>  		return;

[Severity: High]
This is a pre-existing issue, but does the WARN_ON_ONCE condition have a
misplaced closing parenthesis?

If an ITER_KVEC is passed, the first three checks evaluate to true, so
WARN_ON_ONCE(true) is executed, triggering a spurious stack trace dump. The
function proceeds correctly because the overall condition evaluates to fals=
e,
but exporting this makes the bug accessible to generic users.

[ ... ]

>  	if (iov_iter_is_bvec(i))
>  		i->bvec -=3D state->nr_segs - i->nr_segs;
>  	else
>  		i->__iov -=3D state->nr_segs - i->nr_segs;
>  	i->nr_segs =3D state->nr_segs;
>  }
> +EXPORT_SYMBOL(iov_iter_restore);

[Severity: High]
Is it safe to export iov_iter_restore for generic socket transports?

The struct iov_iter_state lacks the fields necessary to track list traversal
or state for complex iterators, such as the folioq pointer in ITER_FOLIOQ.
Because of this, iov_iter_restore() silently returns without doing anything
for these types.

If a generic transport receives an ITER_FOLIOQ or ITER_XARRAY iterator, the
state will not be reverted on failure, which could lead to data corruption =
or
desynchronization upon retry. Should transports save and restore the full
struct iov_iter by value instead, or use iov_iter_revert()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613000953.4674=
73-1-tavip@google.com?part=3D1
