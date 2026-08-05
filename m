Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851E3A4F50
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895056; cv=none; b=Wb4VNFBcU91oLg0lZBP9Nka/rvbsS/lLhYn1o0trwqANe5EVcvdFyNY6FzSPaMeyNlVPSvdphIRXmkEb18hJoP+PvWbn8vH42S4qI6MOUkGaEdyisgq3eaj392vla681gS+m2m3COwgeiJDibcO0jaNtu1G+zaeA/3DzQZA5g8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895056; c=relaxed/simple;
	bh=TzNCLU6iZoJ9RIkpyqTkubtXhiHs02wHdvoMIBwwk5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uFYh3PpQvJUuZlS+LU5r9/2Fp1uNOaJLtqi4pqn4uvyfxPyKA+fEodKI6OW/E2mxVWifzJxfcJd17fMSgsnTqADR4TeOZK52S5CtjsWdeEH4hfSA0m+WSed/EN0rTqRjhy5zKP1MfH+dvZg+rgasdRRWQq55xOn/Vc9CSMhDsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq243A5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq243A5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6D31F00A3A;
	Wed,  5 Aug 2026 01:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895054;
	bh=Nuzc2n+QIRveMvSIonts8BKS+TdA8T+fmX//3YggpMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kq243A5PbsvoNE2TPXdnCPn5ypD6WiyPv8iXKwDg0RKMJP6AVDVuQFt87S35X+SgC
	 SDgIhJ+vdIsRUPU0wXdJVaJck4tHnC0U9TBKXOKwkv0LIv5UixjOcdihXcffODz/2P
	 geiBB6GSWvpZ7BC0SwCt1wbKN7zyAHnD5MLVwWl0oPum7+dzhf7XwhD21FRv2UrlCY
	 7lj7FTGWxGrSadnblxM4Z9GRowNPbk5lHELhLhG3d51dj3QyjuxjBVuDwCp7IREuWC
	 uXiyv5hEUcmZXFV/daZSv06lMKtiaiUgT1hiibEdtXvkXDST5x8+wvPqGERJGIGwX0
	 xEuKcREe1VfTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v14 1/5] tun/tap: add IFF_BACKPRESSURE flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Schippers" <simon.schippers@tu-dortmund.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803183641.96882-2-simon.schippers@tu-dortmund.de>
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
 <20260803183641.96882-2-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:57:33 +0000
Message-Id: <20260805015734.9D6D31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] UAPI Bit Collision between IFF_NO_PI and IFF_NOFILTER causes silen=
t failure to re-attach socket filters.
--

--- Patch [1]: [PATCH net-next v14 1/5] tun/tap: add IFF_BACKPRESSURE flag =
---
commit a863b69cf20b684debe10f1f06a9f4273abcd009
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

tun/tap: add IFF_BACKPRESSURE flag

This commit adds the IFF_BACKPRESSURE flag to the TUN/TAP UAPI headers.
The flag acts as an opt-in switch for qdisc backpressure logic.

> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 79d53c7a1ebdc..a0ddc50a75342 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -69,6 +69,10 @@
>  #define IFF_NAPI_FRAGS	0x0020
>  /* Used in TUNSETIFF to bring up tun/tap without carrier */
>  #define IFF_NO_CARRIER	0x0040
> +/* Stop the queue instead of dropping when the internal ring is full, so=
 an
> + * attached qdisc applies backpressure instead of being bypassed.
> + */
> +#define IFF_BACKPRESSURE	0x0080
>  #define IFF_NO_PI	0x1000

[Severity: High]
This is a pre-existing issue, but I noticed that IFF_NO_PI shares the same =
bit
value (0x1000) as IFF_NOFILTER in this header.

Does this bit collision cause a silent failure when re-attaching socket fil=
ters
on persistent TUN/TAP devices?

When userspace creates a persistent device and sets IFF_NO_PI, and later
re-attaches to it via TUNSETIFF, tun_set_iff() in drivers/net/tun.c evaluat=
es
the flags:

		err =3D tun_attach(tun, file, ifr->ifr_flags & IFF_NOFILTER,
				 ifr->ifr_flags & IFF_NAPI,
				 ifr->ifr_flags & IFF_NAPI_FRAGS, true);

Since ifr_flags & IFF_NOFILTER matches IFF_NO_PI (0x1000), it seems this wo=
uld
pass skip_filter =3D true to tun_attach(), silently bypassing the BPF filte=
rs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803183641.9688=
2-1-simon.schippers@tu-dortmund.de?part=3D1
