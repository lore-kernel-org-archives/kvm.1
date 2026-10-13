Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535C5221DA
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905830; cv=none; b=b7Z5yPDt8C0J7RDSSk9SI0C7+NqPnJQpKtzFiRAbier7q3uaz9FN2JXiM/otgW9dGH5HxDwqNuz5XYCmVTq285WcJWKFMGNVqBGIart6vacZ6YBsxBj38cJHxZ1VvIZhdi29ve1GEzSOTHb4lKqvfGHulWd8Ue91TsjjrjVB8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905830; c=relaxed/simple;
	bh=QYvG7iTN6X/wcWZUdqZr19eVWyZZhBJ5WBory4f4au8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKaZMZK79LkEicO79qSoaevQHX0u2hxQgj3w7Wws96lP3AWKjsmX8Co+3qweBrjsZwxzj93ZunHcTKuj0blkzO77W3U/Qy6LrJB2N9iZZiG9gZdw0nPl1YGgXColkJ8Qw6I/QS2S/o8iVg/WKCtgCBoVKbVjgaB0Cyz659Zj+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5d7/Nkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5d7/Nkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8CE1F0089B
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905829;
	bh=QYvG7iTN6X/wcWZUdqZr19eVWyZZhBJ5WBory4f4au8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c5d7/NknAqQkscAXjYsKWSLW1InoTYxtvvKcrA9qHPQdH/cguFfwCMEUHvOz1K4VQ
	 3S+c+/Dyn2O5jxRr9hFzPYa6czWp6nXpHBBCmcYZndSwpT3hWX7kuF3mqWOItxwtwO
	 E9M4ujUiiuFiK8o45Z8+41g0x0FXzvfbvWVPhvE5ytAIPqdOOi+r/yqvYd1xuj1pZx
	 P5QVJlAr9zB4qvn99lamxY3OR+vP9jljxXmYTtUmiF/EBzqCMdYlw70UajMxmZhDbQ
	 RGw6vV3Kh9ef+mgbsXfBvuSFIPua0ZYkwsOtnwHB2Z59GhBX0S/ZNl9BzQYWepMJ31
	 7ehaR3/xqz6Yg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c315869241fso8931466b.0
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 08:37:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzzJpZPG20RA4BMZYoRmBrkkg4AWsZrFsSMTT4ZSqMMlrlLTJxrYy4E917396iqMk3mdX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsWWsRAM2MxBBpHjYmXCNssBPMLUvIRM/Jp6D8Qrd3r6mgm5f9
	K5PLfD+xB/JHHyyS4HXDfp/zWRN1DtnWLKA3oo7sfY42gt2sr2qizQPnHlNV02miY7LirM37Uic
	GbWdT5AJoTUJKORYikWmd34BGQOJNx7Y=
X-Received: by 2002:a17:907:7246:b0:c26:19de:9adb with SMTP id
 a640c23a62f3a-c31a9d56575mr1180906166b.26.1791905827546; Tue, 13 Oct 2026
 08:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zMxdg2BTFguwcRQn8n-2CPaEJJfg+T8dWcgO2eV4uNaHQ@mail.gmail.com>
 <20261013152553.39287-2-itazur@amazon.com>
In-Reply-To: <20261013152553.39287-2-itazur@amazon.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 13 Oct 2026 08:36:54 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPOkuRGv0X=nBbAzTUjUyaB7zAJLUigetSXEVPxWpyGxw@mail.gmail.com>
X-Gm-Features: AclHuK-W6f4ZhQh9ueCOMp1_eyaIikFGHa4dIFgdih2WgfTC8_TU_5ph5Rmf9m0
Message-ID: <CAO9r8zPOkuRGv0X=nBbAzTUjUyaB7zAJLUigetSXEVPxWpyGxw@mail.gmail.com>
Subject: Re: [PATCH v3 03/26] mm: introduce AS_NO_DIRECT_MAP
To: Takahiro Itazuri <itazur@amazon.com>
Cc: Sean Christopherson <seanjc@google.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
	rientjes@google.com, Roy Patrick <patrick.roy@linux.dev>, 
	Andy Lutomirski <luto@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Thomas Gleixner <tglx@kernel.org>, Patrick Bellasi <derkling@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Nikita Kalyazin <nikita.kalyazin@linux.dev>, 
	Ackerley Tng <ackerleytng@google.com>, Takahiro Itazuri <zulinx86@gmail.com>, cc-open-source@amazon.com, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Gregory Price <gourry@gourry.net>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:26=E2=80=AFAM Takahiro Itazuri <itazur@amazon.com=
> wrote:
>
> On Thu, 3 Sep 2026 07:06:02 -0700, Yosry Ahmed <yosry@kernel.org> wrote:
> > > If that work is not already underway,
> > > I would like to respin the AS_NO_DIRECT_MAP introduction and secretme=
m
> > > adoption as a standalone MM series, separate from ALLOC_UNMAPPED and
> > > mermap.
> [...]
> > Perhaps wait until I send the new version, then we can discuss if we
> > want to split it based on how the feedback looks like. Does this work
> > for you?
>
> Following up on this with an update. Yosry let me know off-list that
> ALLOC_UNMAPPED is on hold for now (quoted with permission):
>
> > I wanted to give you an update. I was working on v4 of the
> > ALLOC_UNMAPPED series while our team was simultaneously working on
> > integrating that design without internal ASI implementation.
> > Unfortunately, there were multiple complications with that
> > integration, and we will be holding off on sending new versions of the
> > ALLOC_UNMAPPED series until we have higher confidence that this
> > approach will meet ASI's requirements (ideally in a production
> > experiment).
>
> Since the integration with Google's internal ASI implementation needs
> more time, Yosry also agreed that I pick up the AS_NO_DIRECT_MAP work
> for guest_memfd, separate from ALLOC_UNMAPPED. Here is how I plan to
> proceed. Feedback is very welcome, especially from Sean on section 2
> below.

Thanks for the update, Takahrio!

> 3. ALLOC_UNMAPPED and the mermap
>
> AS_NO_DIRECT_MAP itself works without them, by zapping the direct map
> of each folio. However, guest_memfd will eventually need a temporary
> kernel mapping to populate guest memory via write() [2], because
> folios are already unmapped once they are added to the page cache.
> The cost of TLB flushes and direct map fragmentation also matters for
> performance, so I'd like to keep discussing these with folks
> upstream, building on the direct map fragmentation discussion that
> Kevin led at LPC [3].

FWIW, I think the mermap can still be used without ALLOC_UNMAPPED, and
I did have a newer version of the x86 patches repurposing the LDT area
for the mermap, and simplifying the mermap implementation a bit. I can
share them privately if you want to take a look.
