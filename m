Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792960747;
	b=EHpnDZYD48hqOS9ZL1W3hmFFd7+r3USjy8//ey+qgUsXgLoRsbPy+S4ngO/lvoIdlP8m
	 IW+759F4xo/GC41AgxLJOvXOtd9qj221HQ7g9YFd/PjmS5t4iOYUy7V1UWAgqZFEfM+LO
	 /23Ao4dE0GDRspyHlQu7BBRcLhagmDYA0BYRXD4jxuLPi1vQPuOTGopT44Ko2jVYkW2zW
	 QduHMsFW9Xl0h6SyKdE+SD7nWvD60mv2d7NEKI+3piigsKAxr+tqZ4WltwxGGGAaT/a/j
	 IrEqPJ2cdrhkT/L0Vn7gyZxGmMwLGyPSIZo+wGyMH+xK9iiayTNrrLwjGtdhSnv5xGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
	b=AwyEsz4NRNcEA2/T+5wjv7We0xK+pgsKkcsb4DSIuS5jGyBWWfy+oQ4fKjY6XRrwYBpZ
	 xp6lDPrv7xH7pPcLO2sYBZaOaVTOzrbJZ1mQY9908zJo7l1HqSrnXxnJnL1xSCKGhbt8w
	 I2+ORQCkyddzgIbMafuiOOYXhhx22WVpElyD1hx6lmPqomhywmWyRo7hA7EwKWl6VYiuB
	 DOenZtZFEJVMW+kXjHg/6xZYA8rOLiuNSJIVlXKitq3n4ByQXqiVKJct1rXzGMHSB0qiL
	 JnRVuUjuuhwYLqr1YaCZMwWYtUS0NcjE/B3PJ29ITHHZ1WEATb7nWs3cbI3JgcjqnDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="DV/IgpGJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F62606A31A
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 20:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=DV/IgpGJ
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so3340104a12.1
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 13:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792960740; cv=none;
        d=google.com; s=arc-20260327;
        b=Uy62LTQ08NlqiwfkApb1CsEsYAgZf77nk06ZiRWJnGB+dbIEJwKH++dF922ZHZc4e/
         F4AqhpwD0xR3rXb1X6TaGqr4UW6Eoyeu5/HFZcEkM4eiCzALZm8KqBSmUCUJjqwowIF8
         sGSeHjoay1FQn5TsEwnuG6w1OqweL+RjJwIhzHfgWHaxX1/IdgD+Ni+zPiL67iNGLWm3
         ujsh7HKHUNOCQB0AxVJMjV8no0ha9WylYYMXVyOXFJkGufSII/TvVWqU4QpLMVzs4TLj
         tjr4hZNJhOWLTiAjz+RbJiiikXXkR1HjRkQ3ycWj5rJlKi2Rdb7Gx2FstIwnvdb2OQKr
         Hs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        fh=GNVpMaT7g/da9XJIyK7YmnDm36cdBWE3VXsS9QqkN6s=;
        b=JLrP+At9zbMTuI+3C1TEXf0NrLZE2u7zFNMss0xJ800DU8uhQpoJ+mYF/X9qi0OG/E
         smeJIgVRVFkLAmPCDa9HUvdfvnJem1/4tQHmxOT1SASk/wtf90TJeHVk+03K49sUqdwQ
         lxceX3dO+eyfndFJDVnarxzKm07ehcabtLStKaakWtuVlYltfl4OO8ZNxOkPRCem885+
         XDwvUtNNI5io7DUzb/moWRnavA4d8CyGuokNy/SrsJ+zpcIar+jC8TQZNeDpnuEXEaPK
         D4NX2L5SzIj6qIJfAYU5qBDh8sbhp4wHWGXyGj+r4G5zwwXjmyyAZbyvOhsxLZC+TMrt
         rWiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792960740; x=1793565540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=DV/IgpGJYzHRXuQDz7DQM0HJY1y2UrWNoj0k9X7vIPdFhTzYbG2hBmzcVoIVY2rS9p
         NRs++i25KutZdEuCIAHKRbFKGEPBoSjokCvm08oMI3dF54EWKUpwXkAFFzWufQVPOsA+
         Gtzn4u8LSb4Fyrciu2eYaaDF1hjmKE0IoXlwpgptO1gt/8O+qxvWxkOIloKbw/bwrMTh
         4pDHCTEIr5/B+DddD3Mdiiu6NgkrFH1jIcgPur2TUw4F6knSq50Qdjy08mHwVUwvH8pH
         KfG5oA5zgGEOmHdXHrATFd2caZEt+SauSD57pYnn8BwZhbAxA0eC5Sr8CrRMjnKrM/LF
         txUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960740; x=1793565540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=GRpRLko+XnNXyXdlQiXD2OmN881oHWMXRminKYLIn/PZ4Aeq1IsmuFMvumbEztxoap
         MgV2/aDN1Ia33hJkPb7Alc7BEHVNVohJTvo4M96kQENupiVKOWuqewtQKtYoBEg5HyJ9
         /jaU0pZadfpJffciUKAKfj6PWcwjWep6Eeq8heS1sRAloPJEdSpExKrBq5nuTelj7K6w
         sv9ODfgCOfgWlShG7GlmXSpv2Y2HQp74Iw6SXcY4jpHk7/NIAXIrbcyt/nCa8MOG5Z/e
         wHgf7FPM1+d3POpWmtxdpv1Y6spWupfR1C1d9B2ptTcyZbLd/7/ZM0H0aiZti7w01lZc
         tWiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBGRi1TPySDrNrOJNBDYN2DQvLVxfLbmKlrNEWeCS8AYbKpGeQSKLL69VGQk9FJUDLI5o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZo1p/cJe4Odprsfzem1X8hRDmstxRVfSCNe+AdtGfHyQNLnm3
	IwBTr/cc5wt4RHyAeSZGhUPjjw2km8nBZR7Z01ImwvWXov+SLSPLl10SipT2YIQcl4vOZ3tFUey
	YRo+RaMDLdG+VE19h8RGqisoAoPnV8e4Kok03BDhrnw==
X-Gm-Gg: AYBFou1G2wfT/npcQNPrSVXU69WkbmAPwZEVivJqMiopzN9GxIGpVg3oEYsxrlDFIwd
	Hhi8bdhGLIKBq9CQwuwJVoyb15A0Id3dUZhdX5OeW2BxDx7DARlzsvqxa09ZEsp4SsPLgMf83s3
	R9+vSXIvQG239SQCVU2L+Y3vDATcQQ40Ud4poPnRPMySe3UzN4EfVGtoPGZqkpyRnUmhRi06JZm
	apK3gW6HJFS+jScBNF6rLqAEgy0UZeNRDmU9d2apQwDDD2xywNISYgc5g5GgAB0fHrey7uMEV3J
	fDV7EnOjTaH+YNrvr0VlU8nin+CxYHPkJzLKyJBQKnsES05xcUPZig9yDbfCs0eeYTYB9s+0h0P
	lBcrKWm8+9x0C84nTcIPXWBL8HM71RwDWSNlaeJy26opZe/fMU8qZ409PBjmOJu3XyBud
X-Received: by 2002:aa7:dd0f:0:b0:6b2:2339:370d with SMTP id
 4fb4d7f45d1cf-6b443000b00mr4543991a12.39.1792960740017; Sun, 25 Oct 2026
 13:39:00 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
In-Reply-To: <attmFVIFU_mS0Y7p@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 25 Oct 2026 16:38:23 -0400
X-Gm-Features: AclHuK80OiwlBnY6tUr3jZ6atHcY2MdRSOFYk5-Bhewn5rIfzUZ_oGQw-LNyjus
Message-ID: <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-22 04:53 PM, Pasha Tatashin wrote:
> > On Thu, Oct 22, 2026 at 1:51=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > > On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
>
> > > > Lets drop the fourth macro argument and generate the combined struc=
t name:
> > > >
> > > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)      =
        \
> > > >     struct name##_hdr {                                            =
        \
> > > >         __u32 size;                                                =
        \
> > > >         __u32 flags;                                               =
        \
> > > >         __u64 ext_flags[ext_flags_count];                          =
        \
> > > >         struct name payload;                                       =
        \
> > > >     };                                                             =
        \
> > > >     static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),=
            \
> > > >                   "LUO struct " #name " size mismatch!")
> > > >
> > > > For example:
> > > >
> > > > struct luo_memfd_ser {
> > > >     __u64 pos;
> > > >     __u64 size;
> > > > };
> > > >
> > > > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
> > >
> > > I think we are getting close, bu I have two remaining concerns:
> > >
> > >  * Reserving bits in each flags word for continuation leaves gaps
> > >    in the flag space that users have to know to skip.
> >
> > Yes, but callers should never manipulate the raw flag words directly,
> > and we can provide simple accessor macros or inlines that take a
> > contiguous feature ID (0, 1, 2, ...)
> >
> > enum luo_memfd_feats {
> >     LUO_MEMFD_FEAT_HUGETLB =3D 0,
> >     LUO_MEMFD_FEAT_SEALS   =3D 1,
> >     /* ... */
> >     LUO_MEMFD_FEAT_FOO     =3D 15, /* Automatically lands in
> > ext_flags[0] bits 0:1 */
> >     LUO_MEMFD_NR_FEATS
> > };
> >
> > if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
> >     /* handle hugetlb */
> > }
>
> Sure but why deal with all the complexity just to save 8 bytes? All of
> these structs are allocated on folios and there are kilobytes of unused
> space to fit this header. And even if we optimize that we are talking
> about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
> sub-structs like the KVM ones.

The reason I care about keeping the header compact is that we are
defining a foundational kernel ABI and want to use this header across
almost every serialized data structure so we can evolve them later
without breaking compatibility. While some top-level structs are on
sparse folios today, other serialized structs are tightly packed, and
we are looking to add KHO slab support in the future where tightly
packed allocations will be common.

That said, in your proposal, as long as nr_flags =3D=3D 0 is allowed when
a struct has no feature flags yet, luo_ser_hdr_size(hdr) is already 8
bytes and only grows to 16 bytes on the first feature flag. I am OK
with that.

> > >  * struct name##_hdr only matches structs written by the current kern=
el
> > >    (in terms of length of array and offset of payload).
> >
> > This is not an issue on the incoming path, we never cast incoming data
> > to struct name##_hdr or access ->payload directly. Instead, we parse
> > the incoming buffer, dynamically compute the header size from the
> > continuation bits, and cast the payload offset to "struct name *"
> > based on the negotiated feature flags.
>
> How?
>
> This is the only data structure that describes the header. Are you
> saying the incoming path will parse the header purely with a void *? Or
> use this header but just be careful not to access payload?
>
> We should have one header structure that can be used on the incoming and
> outgoing path. We should not have one header data structure that can be
> used on the outgoing path and one that can be used on the incoming
> path.
>
> Also we need a standard header that can be shared across all structs,
> not a per struct header. Otherwise you will need to do weird casting and
> overlays to implement the shared helper routines that parse it.

Having DECLARE_KHO_SER_WRAP() in include/linux/kho/abi/ makes it
immediately clear just by looking at kho/abi/ which serialized structs
have the versioned header and which do not, while also enforcing the
header when preserving and static-asserting the combined struct size a
compile time.

So with your header (and let's use KHO as we want to version KHO
structs as well):

struct kho_ser_hdr {
        __u32 size;        /* Size of header + payload in bytes */
        __u32 nr_flags;    /* Number of features encoded in flags[] */
        __u64 flags[];
};

The wrapped struct will look like:

#define DECLARE_KHO_SER_WRAP(name, expected_size, nr_feats)                =
\
        struct name##_wrap {                                               =
\
                __u32 size;                                                =
    \
                __u32 nr_flags;                                            =
    \
                __u64 flags[DIV_ROUND_UP(nr_feats, 32)];                   =
    \
                struct name payload;                                       =
    \
        };                                                                 =
\
        static_assert(sizeof(struct name##_wrap) =3D=3D (expected_size),   =
    \
                "struct " #name " size mismatch!")

On the incoming kernel we don't use struct name##_wrap, but we use
struct kho_ser_hdr for the wrapped data, validate the flags, and
unwrap it via kho_ser_payload(hdr) to get back the struct name *
payload type.

Pasha
