Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B83C1411
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253712; cv=none; b=bIi/bTt1lgTgxmolIFtsJoSHX0TasJMaU08EkZxi4hLPTJdI00O01ZBBh72NQy/Fu6eWbhG0oeXIgPI4UotZJ0X/CodveADsjO/13R4TVUcJUFHiPg0X8arNhLniynl3wMZQMILMHHYr9Pj8FdUqDMP6b4P8CgsQBDbNphSs9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253712; c=relaxed/simple;
	bh=rgP8Tqmd9PYeAKiD749qsCytgtvgwZlrHNsxYWKuq3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ut7S+G0rFAiPjCUCD1ocVYgQD0EwMfZyuJkT655g3kDl/5yS+BnXw2vZEYnYXTOwJAw/SXJCQZPNPVMFHj2PxMnWubjnAxLfyybTu1mhUb7PXPffAfCYc7yRiWou3hsUAxDZbd9EfSNMi0OGUPzyTwfLhZ9NZSkzBbMlxYdmOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqJGYCN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqJGYCN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755ED1F000E9;
	Tue, 23 Jun 2026 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782253711;
	bh=sQh2X2KVbLC76/V5DqE0dzxsSn1srlGayn9HPwwquUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GqJGYCN4hJsALLbL7ynOJ+4INjRRRo0QlDA0lxecGKMeP2SkIZtx/D3zamEBgOBvd
	 /QMyecNJal8nsiFxJKZdfWp/Fkzb5iSqBUyrZNoa4o40enuCOUPWACJwdQRdEZIF5j
	 itKjElguxopXEWTLfKAAMz6jD3ahWzcoyVz8CAcDZy4jDA+elSfEDcc163BZiArJjT
	 /zgyFg0BRqwpGysYAXEJK6kTkQci4/74/xwuPWOh0yxI9gOyZUY3U8i4x461Lo2tsL
	 gxO2NCdF1C86gKCbiu5Rc5yqum+1qpnCQgEfZBGJT52Q0Udz5C+IiKWbUPIU7vY3Zr
	 6r93zbKuQ5sRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] iov_iter: export iov_iter_restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Octavian Purdila" <tavip@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622222757.2130402-2-tavip@google.com>
References: <20260622222757.2130402-1-tavip@google.com>
 <20260622222757.2130402-2-tavip@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:28:30 +0000
Message-Id: <20260623222831.755ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Exporting `iov_iter_restore` exposes a pre-existing logic error wh=
ere restoring an `ITER_KVEC` iterator falsely triggers a `WARN_ON_ONCE`.
--

commit b7b5854a768fd37654ad61552651a21df8d14c8f
Author: Octavian Purdila <tavip@google.com>

iov_iter: export iov_iter_restore

Export iov_iter_restore so that it can be used by modules. This is needed by
the virtio vsock transport to restore the msg_iter state when transmission
fails.

> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 273919b161617..f5df63961fb24 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct io=
v_iter_state *state)
>  		i->__iov -=3D state->nr_segs - i->nr_segs;
>  	i->nr_segs =3D state->nr_segs;
>  }
> +EXPORT_SYMBOL_GPL(iov_iter_restore);

[Severity: High]
This isn't a bug introduced by this patch, but exporting this function to
modules exposes a pre-existing issue when restoring an ITER_KVEC iterator.

Looking at iov_iter_restore() in lib/iov_iter.c:

void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
{
	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
		return;

Because !iov_iter_is_kvec(i) is placed outside the WARN_ON_ONCE() parenthes=
es,
restoring an ITER_KVEC evaluates to WARN_ON_ONCE(true) && false. This safely
skips the early return, but still incorrectly triggers the warning, which c=
an
lead to a panic on systems with panic_on_warn enabled.

Since ITER_KVEC is often used for kernel-originated network and storage dat=
a,
does exporting this to modules like virtio vsock create a risk of falsely
triggering warnings or a denial of service condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622222757.2130=
402-1-tavip@google.com?part=3D1
