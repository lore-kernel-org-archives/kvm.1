Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822120;
	b=EAlBBphDUEU5hfsqF9jMeVZ+suUAe8gBb7Lrps/ePCAANYOQIg933SzyzTTnEs02UHXJ
	 uC+AvMSl8vpAUqX9yxsBVuCnAdDeAgQVrFzWp+/TJXNwmfBvjb/Vgm8j8ac1dEyEZfU9r
	 Wc3XXiU1ywhVNsrqdwZuhI1meS/2W+4P5LWoSbYu/ziN9jJ2hEbLalWhJb7RY6h92C87a
	 YAvFbshsGC1lKCUipqe9q7aKnz0Bt5a7oRm+lE8412yn6HpDzmumspQAxR41+07wbbGup
	 3f/Kzj783y4i2+uXJHAP0ZUSEs8WIupM/rUSwf1wJJBXl0Ol07mvr0nL4QPM3xxLJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=xIP0152tlzbCKzuF2/YHtRaLIY4BcChV/EzqFd0BfRg=;
	b=rK1BVpAp+WibU7TiHAF41QQi1jWJJYF7jqVO2mbueENvJEcfGD4dlbHVNb1/HehIBZbB
	 uoagCjT0MgxO7Je1NAbV3xdQYpGDxjAa1EZVyiKPBWufo82lI9mplODKeUNOYhNvjSeq1
	 l4nFRi6u70tKB8JRvxHeMap5tDitaXBWjPrsBrX2x2/E/DUCB1UTkGKDfE5GN6BmcN1dj
	 LfK3iUwvpsBisDFJfjc8Uu9Zz4uwGg0duWmIPKuxRveUtZIGuLMZtzhkdVZ7mwYCWUCW4
	 w35dKuvtCtNfhtj7rmD6TOkduqaGK7fpnh6Y+DACjGzWyDoyZmRyr/cQub9d0v6OqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kbE2wqxY;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB90607844E
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FB90607844E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kbE2wqxY
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e94f72fb9fso10696165ad.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793822120; x=1794426920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xIP0152tlzbCKzuF2/YHtRaLIY4BcChV/EzqFd0BfRg=;
        b=kbE2wqxYpPOPvYLN6MYCwEHXLGNtfvFJPaftsxTsX58YJ+WwlbYrRZU1Dwwhwqg7rG
         lM5Fp6Krsm5Op3vdTLXGy0CT8n4LybobKyn+d1usLVBR4BBTbtBim9anmarJFKeFCxhc
         0j2+cJDkBOhY6ZDzhtgpeOaZkWi4shDSut+XcoU/susJkqCJnwadsXKC7xl/lS9BSzxl
         TFUmYZCKGkT0q/Ole95F4e8QrRPsvSnObR/RZIO3RUOy3rGqkKb/CFyfAoOV0G5Nqjhc
         E/YNW3bA8aIGuWKVS2EXpUexSP3TeRv+ip++rD/OBtECH6XZfQ4O8JUrpc9ha2dN/nTs
         JmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822120; x=1794426920;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIP0152tlzbCKzuF2/YHtRaLIY4BcChV/EzqFd0BfRg=;
        b=MrZZFAEcamsZQxb0kG1gmg0lrURmrX+GsmcBMZMsIshXok2DX2kRoCJ/EVAGhV1G5a
         pSWesjMmXNRNzWWcwdu7MG93ZAF9ZSHSg5QSxd8fEy72wg2LdRiukVOfKeQbNUqIe0Cc
         x+PHcYZkkekSTeXjXcgmnewK2ChA+ZjqlyYVz/g8eSVefkO5Klt+7Kidddht0pEM60Md
         Oihc/FNeyPUQSFrlmrnS1fyr67DOvGneMTv6ArvsS/JPnCuLjm3HRxjkWL2GAdXG19ha
         Zk7gM7JQpAseAaZrdCiNg1CigPyVqic0LZa/HPcaif+rh3RpHEgqr4a9yQ7NC0IhksYN
         rPhQ==
X-Gm-Message-State: APuU4Z/fowbX4mXHaZkbON3Z/f839TCGqBL9/yFHeVVuhwsY6dUP52zu
	/iGf4cV464Oi/W5AyHKt4pHGDLLlb+HXuNVfKwCxav11BBmIwyqLr1q4VXz7b4UgHbj8ciNh6eH
	DLd2G7g==
X-Received: from plwg3.prod.google.com ([2002:a17:902:f743:b0:2ea:a5c1:240f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebcb:b0:2ed:18cc:d3b3
 with SMTP id d9443c01a7336-2ed18cce0demr13596215ad.6.1793822119521; Wed, 04
 Nov 2026 11:55:19 -0800 (PST)
Date: Wed, 4 Nov 2026 11:55:18 -0800
In-Reply-To: <ac6b1891d6bdf3a855a5b840c462a6e7d464a146.camel@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019162445.37219-1-dwmw2@infradead.org> <ac6b1891d6bdf3a855a5b840c462a6e7d464a146.camel@infradead.org>
Message-ID: <auuNplHvOT0XL1fZ@google.com>
Subject: Re: [PATCH v4 00/12] KVM: x86/xen: Don't drop event deliveries which
 race memslot updates
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026, David Woodhouse wrote:
> On Mon, 2026-10-19 at 17:24 +0100, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >=20
> > Sashiko analysis and torture testing of the upcoming conversion of the
> > gfn_to_pfn_cache from rwlock to atomic SRCU=C2=B9 highlighted a pre-exi=
sting
> > problem: refreshing a cache can fail while a memslot is briefly marked
> > KVM_MEMSLOT_INVALID during a memslot update, causing kvm_gpc_refresh() =
to
> > return -EFAULT. The Xen event channel and timer delivery paths silently
> > dropped events when this happened.
>=20
> Meh, it isn't even just GPC that's affected by this =E2=80=94 anything th=
at
> uses kvm_write_guest() can get a spurious -EFAULT if it happens during
> a memslot update.
>=20
> I just think that until I started torture-testing the GPC SRCU
> conversion, nobody ever cared because in practice we *don't* delete or
> split the memslots which KVM is actually trying to write to.
>=20
> I'm tempted to drop the whole -EAGAIN part of the series and the retry
> attempts, and continue our historical stance of not caring.
>=20
> I'll just keep the other incidental bugfixes I've found along the way
> (especially the SCHEDOP_poll vs. srcu one).
>=20
> The Xen use case is actually the easy one, as userspace really ought to
> be using KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA for that anyway and
> shouldn't be affected by memslots at all. I can update the GPC-SRCU
> torture testing to do that, and pretend I never spotted the transient
> invalidity...

Apparently I suck extra hard at reading today.  I responded to the cover le=
tter
with basically the same response, and _then_ I saw this.  /facepalm

At least we're in general agreement.  I've got patch 1 earmarked, so no nee=
d to
resend that one.
