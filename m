Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C215187F3
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907777; cv=none; b=dncyBcXt4ryb75+SxTgUGhYfSF7aGFv6cefw+Wdt/mil7b07mCi2qM0MLcL6sb1tPsPTkvTWZYT0/c3l1SAGkP1iUHg/a3XTeQjSPMzXwWG2PugIr/5uvnkmmdAXGoFYlgLWKEHkUW/nqcIDT1OAVk/w5u4vLZD6pZnWnxROlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907777; c=relaxed/simple;
	bh=I68o5gYKqjJpVpdOoELHe4gv1tpEBm64YlxoXNgYMNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr3ZFQBrOf7geQnTrbDGJI6hDnVWXuY6iWTLeh8B18DurUpE/I1+9bJ1DMKkAPyC0/3iSCDqr0ClfLbmze136/+iaBgfZvXxyjeR0uYR3M0zPVzg/Ps4Tby8iZjRSYvXEPI7ikG3NLQY+93Vph9YmE9QbKBRR6pPZKNXQMlCgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clQMuYyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clQMuYyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522A01F0089B
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907776;
	bh=I68o5gYKqjJpVpdOoELHe4gv1tpEBm64YlxoXNgYMNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=clQMuYyChATPUv0Ba5ud7nNEnbaMLyii6+fbiLgbmEdsmozHDx1FKcArNXd/lgY/0
	 oMPxmen/5yHBir4rVc+4gwBfaEhg1cf47I3di4q3eO+kSHDxI2hhF3Hc9xvQ3L0W40
	 nO8el0241VpmNMrKBcSpAinRbOS7ZD4X4W5Bs5e4ayUjM2R5kiwvojzfmE+Mu6BFMZ
	 WTNqygghaWeqf2LDt+N4TUSE+ct6fvqzS6tJy8TvaUcfP1s/T8yPOptWLUZ+5t700u
	 sIgiKTcGswHwPIdr8StEWzfIJQh8d8+t9INZMXDcdE+oGBY6SVYBYXFl4xsma0V6cV
	 wXRSDqZiD3/LA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c20ce3c118aso416784966b.0
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 09:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxmx6b61CoWdNLl/LJ7XJ+dg/Qzt+J7TP/2hJQ0TtpU8mGUreaPmrSvoxBD423dWqm+xCI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2YgKIfXmrV/RQeXGpeg4RcmV8tW7k+ARb7Z5yC+RcaYCae1t2
	zlsLFzTYQg3+OzTzx4qi2u8nrBIO1xyNaUR3X/MvNlM7eXGI101ag+7f6CpQiqIRkvuyJBFceH0
	TgBJnKDqc2RlZN+M9BAD6avI2iqIrop8=
X-Received: by 2002:a17:907:3f8e:b0:c31:6c9b:5069 with SMTP id
 a640c23a62f3a-c31a9d6f597mr1316896466b.13.1791907775104; Tue, 13 Oct 2026
 09:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zPOkuRGv0X=nBbAzTUjUyaB7zAJLUigetSXEVPxWpyGxw@mail.gmail.com>
 <20261013160557.54828-2-itazur@amazon.com>
In-Reply-To: <20261013160557.54828-2-itazur@amazon.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 13 Oct 2026 09:09:21 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN5bDJLvQiyfNZX2Z2W+sL_txT8c6WhfwyXci19rHsJeA@mail.gmail.com>
X-Gm-Features: AclHuK9_C_4IWAq2FQn6XicUwnHvllAJw9Hr13X655JabnYqdZ6oL3GbW7fxP2M
Message-ID: <CAO9r8zN5bDJLvQiyfNZX2Z2W+sL_txT8c6WhfwyXci19rHsJeA@mail.gmail.com>
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
	Kevin Brodsky <kevin.brodsky@arm.com>, Gregory Price <gourry@gourry.net>, kvm@vger.kernel.org, 
	Derek Manwaring <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:06=E2=80=AFAM Takahiro Itazuri <itazur@amazon.com=
> wrote:
>
> On Tue, 13 Oct 2026 08:36:54 -0700, Yosry Ahmed <yosry@kernel.org> wrote:
> > > 3. ALLOC_UNMAPPED and the mermap
> > >
> > > AS_NO_DIRECT_MAP itself works without them, by zapping the direct map
> > > of each folio. However, guest_memfd will eventually need a temporary
> > > kernel mapping to populate guest memory via write() [2], because
> > > folios are already unmapped once they are added to the page cache.
> [...]
> >
> > FWIW, I think the mermap can still be used without ALLOC_UNMAPPED, and
> > I did have a newer version of the x86 patches repurposing the LDT area
> > for the mermap, and simplifying the mermap implementation a bit. I can
> > share them privately if you want to take a look.
>
> Yes please, that would be very helpful. Thanks!
>
> Agreed that the mermap can be used without ALLOC_UNMAPPED. To give a
> bit more context from the guest_memfd side: I can't say anything
> definite until I've gone through the use cases, but as far as I can
> see now, guest_memfd needs the mermap only for write() support.
> write() is an optimization for populating guest memory (e.g. when
> restoring a snapshot) and isn't functionally required, because
> userspace can also populate guest memory through its own mapping of
> guest_memfd. So I currently plan to keep write() support, and with it
> the mermap, out of the guest_memfd direct map removal series itself.
> Since ALLOC_UNMAPPED is the main user of the mermap, it may make more
> sense for the two to land together later.
>
> One thing I'd like to look into is arm64. Firecracker also runs on
> arm64, so write() needs to work there too, but the mermap currently
> relies on the x86 mm-local region, and it sounds like your newer
> version relies on the LDT area. Kevin, do you happen to have any
> ideas on how something similar could be done on arm64?

Small correction: Brendan's version already reworked the LDT area, I
just reshuffled things and simplified the implementation.

>
> Thanks,
> Takahiro
