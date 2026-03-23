Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11339DBF5;
	Mon, 23 Mar 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268781; cv=none; b=gHoJgOmeOwYQBnoYf1Zt0O5ncIsoHQspt1VjDN8zD+7jH4Q4LBvYLgfFmg7Wp6ryAy8uAbMyu75M8PWImA33Pz7e0inhrqfFf8zCbRWsjFFf4YFwduTKYvemwyo6Gjb5IWTnbV17fo0YI9ezaFNfgSCwmV4O8+nejNZfsYBZ/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268781; c=relaxed/simple;
	bh=02CW1zo3VtJ+LkKlJtXh2NPLViguBJf3ls1bJM/IMsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elwQI+IZfAd+KOe7KY2zfjVxOKa2A16LWQtXG3DMmW9x4XiIg21uwzs65TBaWGn+3jeAEueIZZ7DphBJbVwBPvBWUgeuavbvwnZxllyQXQXxHtb2ZZkemniO5ae9/XVe3G9acNmca0sq6bTRdALPZWs4MVYK8V1lNg0KwhabCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LAWPTfws reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LAWPTfws"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C1A5C40E015C;
	Mon, 23 Mar 2026 12:26:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sOHSPL23_WBj; Mon, 23 Mar 2026 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774268773; bh=TlbpZ/IDr1EIxN7Gg8vmtmglEcJA+ZrxgWpbVKQ9Trw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAWPTfwsrQxMKAHdzU6o1X/Xj/r4a2a6O1Ittg9gZDn5mVOI9wRO/QWP5igLlh9kR
	 QkQmFye7jej7duenP0/4fmqvTiXnLaXP4wUIKm/VC65xZ6EbJvEX+jzhkQBJjPwwHG
	 O/mD2y/+ufYj1OrCqHZZ3Dr9nAZw2l+86N3RYeDtinKNDRjgYcXmqx1f3KJ6SXEn7P
	 R1p3oQXmZS/RGRPKJKpm4ZFPgRVSMSG0T+cIYwqxh38XzHFS6DLTGR+A0bbk31IV6L
	 X/FctvZJFSfZTKzVcwTR1LjYGL5pjdPKOlWV3Yi3VWqdtCtiWGhu5V1hWGFw1BBdN5
	 I1ZKyoWfKgTpJGoZQoi84/l7a96mwRbT1qUzItMfNxMcfZquCbq5YoWvtQZQ1FNxKy
	 C+Is8BXunQsm8f6bQ+bCh31xVCn5LiOlvRYs6ld3cyi5pXxCju8JUqAiS52hSSKSFY
	 RNsSCAVeojpGZx5OEwIVJY0L7CLU+wRwmZYqCWYXEynW8ENvJpYIFDvR97XvOWxmxZ
	 jJHVifJt7QGw4c7p6IcKEpZf6B9y6azAhoEqs6qrYAy3TebNUGVp1ZhuAQ7hxNb9qc
	 +UCo4XErYN8phImP3ihqNaJlBYfOkGNQkhkqJyNIOJ8BLiJkuAcKEZkfzmCn+e69R2
	 njTBpsup6zlBo8Jr3qEq8h9M=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C720A40E0194;
	Mon, 23 Mar 2026 12:26:05 +0000 (UTC)
Date: Mon, 23 Mar 2026 13:26:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
	kvm <kvm@vger.kernel.org>, Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
Message-ID: <20260323122603.GCacExW2F6WrBcuhBX@fat_crate.local>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-19-pbonzini@redhat.com>
 <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local>
 <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>
 <20260321154219.GEab68W-ln67dqTB5x@fat_crate.local>
 <CABgObfYHtUJtw4pykQ=cw3aJrc_KneG92GgG0dyaXhhKw4qHSQ@mail.gmail.com>
 <20260323121708.GAacEvRNp0sFRf8dA-@fat_crate.local>
 <CABgObfYsNhfCpzoNP3bZaaS_AfhRwk9B2K0j55U_GMzLnvJ5TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfYsNhfCpzoNP3bZaaS_AfhRwk9B2K0j55U_GMzLnvJ5TQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 01:22:10PM +0100, Paolo Bonzini wrote:
> On Mon, Mar 23, 2026 at 1:17=E2=80=AFPM Borislav Petkov <bp@alien8.de> =
wrote:
> > This is the key question: what in userspace is going to parse /proc/c=
puinfo
> > and look for "gmet"?
>=20
> To be honest probably not. They can open /dev/kvm and call
> KVM_GET_SUPPORTED_CPUID to get the same information.
>=20
> The difference is that /proc/cpuinfo will always have gmet even if the
> module parameter is zero, while /dev/kvm won't. Based on your other
> message, it seems like you want this to be a bug rather than a
> feature, so let's shelve this, can you ack it with "" instead?

Right, you don't need to add any "" anymore - just a normal comment and t=
hat's
it. Lemme reply to the patch.

And *if* we ever decide that we need to show it to userspace, we can alwa=
ys do
that later but then we'll actually have a proper justification for doing =
so.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
