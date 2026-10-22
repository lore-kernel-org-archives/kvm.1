Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792702448;
	b=guPAtDLMUecQH668FTb1sX1zCyDGCcQS4K4ojjL+j8KkCXqZ+ZE3XMIwZdawLk7tOrUw
	 ytyYptvofahJZ32FR7lxqxYWE64OaFgUlguxEGqIliTPSp9frDb6zPtAaVg0ObPy4iAUR
	 a/8cn3YG8sEbNVllAx9PI8Y1KxzKBMcMbFe+QhxU7pMtvar2xOzCSsyLX8vnBrGaXFoeD
	 VwhA/4X9UrNJn5hDqDPdeB1TGPqCsoDaoiRB8dy6X39wtqAOQ0U2v2zrCGFolXtu4O5l8
	 h8/JDpbD6PzhWHe40MY9Sf0nZcaHlcIqGKgeFmmfyQWugvPBVJqjws66zwuhPHWWbCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
	b=vErWq0R3dYwlZVoYFpma0EcX/Tlo3RpebhwBlLeO0WPbG+W3BeCbHzPbowDAiq0X73yU
	 usJlXZVKlgAs/X4NUb1YDVKmFFd6kKvqy+ra+8sieUuRRaaDUgExnAHlc1uVc89xU2iZM
	 dPioRVKg+jFOBg2JQhjlXbk5RKRK8EidO/p1Ktb0twKj3yBaqisiknzdKTeE4NlczX5+l
	 KwWcm2qvXpGDrmISuknZGVWyFSpXnYv+FjkvkbtDbhbNACQPpgxRXafJT+D5foCNEJ2SX
	 d9drXkMjBn95hSUw73h98pv84+eCHtK+3nYmyO03ZM7spMuGcjpurw+UP08nwKI9whA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=LgLPlGNx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E7606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 20:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B92E7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=LgLPlGNx
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so235840a12.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 13:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792702446; cv=none;
        d=google.com; s=arc-20260327;
        b=PjUGjR7UIKfjnCVPWPo11+vLOypXe1725bIE7Ntngqqkh76bOPnYIDpOBrTelBfrj6
         NoqAO086S1GBrofgNpuqc6lGmZdMOkMSg8eQDnPvrdLEi4m8sFVTDbH7mqbBGZ9y/p+b
         bb63DxD1/+K4HnQCQjrCEVSRJn48Fw7UzV+mtRI5nri0o/jS6WouSsUuHGIlw9+Ui5u/
         M9vCrVgf+hGdorHiF2ZiLmx8PDjGAc9HB3M7ceypCrUSCChmRGvXSeaM97lD/iuMEbN4
         LAFj87R/epkC4PzEuhIuDtKh86F1QrHT4NfMneQ6eXVX5lxruARtWw/sXrSUun01GI2W
         1PSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        fh=3Q8DSXC+zzJONc6I4gsoavWvAXi+G7YqZCjJhowRIX4=;
        b=mBHDLsjCZo/jVd92B/dkAp0efTsuTj9Q9KBWMpFv+zRoyK06LwiVyz0c1E4v5rHziF
         tKDn3iYUZc11RngCa0JCmhW/ILEt6mHpARz7gY5kemZoYu6kBw/7Ad+OsE75B7J3ILJK
         2ev2DCAP2iUizCp/AozrbgXHAKYEOXoJqJBCvOBJ3WaA3thy+CzrEbseZ/SCHes2Plgo
         IjCv2STjLj7UH5CXzp7RbY94EF7R9V8ZVxmsgmyrxKPcswBYgPDcpZcQZpOCRKlQIYvA
         2Wx4GdN3XVehk68tmTUuYt4WGN2HSCdCy1XCbvDV5NxJgOuQmoMDtJ417EOrbV5kiUFQ
         1dzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792702446; x=1793307246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        b=LgLPlGNxToMEl/ridbTJTA9mcX1vYVoh8xUituNiM0UbmUD0nXff79LqiFdiLv8de1
         Kox6RiUxupB1lujhPIT3B0aiITEpEk6N99NPSjkfPJWhzcuMkVFpYQev6Cg+PztUZXBV
         VlvxMQJk9EfxWnEZI74hJP11wV8xjmiVEOOF0R4/yJ4lgucsrpfm3oRJEqSwn5bMjLNS
         EuGPsCH3c+umjsomEkN5X8f9bsvlArA/yy9zhQlko7rg7KGq2aUfMmIoIZWh5IhC1Gzk
         Lf9qNByAGhaOolLCRMCievViqkndKOL7DUWmCft43w+LenxcxtqlDQv796K2pUbSc+pQ
         rtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702446; x=1793307246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        b=KJ5kn2u/DLb0q2dSptxb5stx/qJN0h+viGiowo1OMRsJ+HcTqnY/7WoRiwmINp74tt
         SsTzSqSHkeZh7xK1T4QawAjtkAvdnIn/UcICOv9VhbgCI44Bkb81Rmt2gTbIeu2HQQ53
         GfWemBBeu02bmVQcFjUmBqxw53V5/PGoA0RoE2UPLHynSxEKWZlKgvyej3yFvABW1EP9
         ekdNvNILcd+qkNdjdphlXNJydnUdN1aRFcBV2Fm9hbyp0Qi12BONFfoS+1ZgVm+TkkQT
         g0CEd1gxqA0y2rG+LEl4ocXuC0m0OvBR8PN0ZoYyrrADJyCgxCAfCxc7kBsushWsjMZ8
         qHwg==
X-Forwarded-Encrypted: i=1; AKwUvBzrXTeWEzOAcps2HQXLqW7VR7kLNvxjpWblKF4CYbs2ET35R9jLL7xGruZqmF/N4R8Nc8w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSzE8OYe693qzZKCJ0PXVfVa6dG/JIqZTGPV0brWLhYqbuxGHc
	bp/+ZRfqThIUwxD/OGELtyxC3HRwL6PMYIlBDFS7m8EvICKbEnFD+/tlYDJ13y/O6O3AdsU5XWo
	SY/EQNL2ZMSOQrzu1jjm53270SrorjFjGE9DYGsxezw==
X-Gm-Gg: AYBFou1+fTcGqE5ECvo0uIxm09xKwZaB2LzVSPW6ndVZcv7TBtTmgdPmPfrVFEtWbUm
	zu5wzb+hRnL/BwzRP0Sv9L0OP6LJIUJ9jkenzohTNlKJiFLjWwiM74y+ZxVFuctzUcWiBwAaRJM
	UfZHry97oAd7FIuPAg7exLKi1Zhn5iqVyQOC0e1e/SZCCVJ0+H0ytALCYMAatFZAql0py5pio9i
	0JWAuswc9Cv30WXiz3aTm7m9iA13BG4rK1+MNpDNiG0xKopupaKxtkbZPwY/Z4CpyUVxBi5RVUW
	1os6UKVoAiusdSA8g9UyOPi/TLL48n8uzBiFsBs5yEcQyhLuemzLfq69GNZ78Yioc+mhiYWbGu2
	3eR2r+tVAAbzFlYmssMXJvKj+kJpUM8gN4SpV8Q+U5V9WgXi296cnQjkyXnVfhXu5hhlE
X-Received: by 2002:a05:6402:321c:b0:6b1:c299:b3f8 with SMTP id
 4fb4d7f45d1cf-6b432c1a486mr859420a12.33.1792702445990; Thu, 22 Oct 2026
 13:54:05 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com> <atpNFEFIlqAoYIwH@google.com>
In-Reply-To: <atpNFEFIlqAoYIwH@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 16:53:28 -0400
X-Gm-Features: AclHuK_o-bcMo-_bEmG9OJEk39HO6mWdZ96jtolFahfwsqDnw1LYQXgLWQ4gcJk
Message-ID: <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
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

On Thu, Oct 22, 2026 at 1:51=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:53=E2=80=AFPM David Matlack <dmatlack@google=
.com> wrote:
>
> > > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, paylo=
ad_type) \
> > > >     struct name {                                                  =
         \
> > > >         __u32 size;                                                =
         \
> > > >         __u32 flags;                                               =
         \
> > > >         __u64 ext_flags[ext_flags_count];                          =
         \
> > > >         payload_type payload;                                      =
         \
> > > >     };                                                             =
         \
> > > >     static_assert(sizeof(struct name) =3D=3D (expected_size),      =
             \
> > > >                   "LUO struct " #name " size mismatch!")
> > > >
> > > > For example:
> > > >
> > > > struct luo_memfd_payload {
> > > >     __u64 pos;
> > > >     __u64 size;
> > > > };
> > > >
> > > > DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
> > >
> > > This looks pretty reasonable but I would name the payload
> > > luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
> > > should never be used directly since the offset of the payload in that
> > > struct is only valid in the current kernel. So I would give that
> > > struct a special name that makes it obvious you shouldn't be using it=
.
> >
> > Lets drop the fourth macro argument and generate the combined struct na=
me:
> >
> > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)          =
    \
> >     struct name##_hdr {                                                =
    \
> >         __u32 size;                                                    =
    \
> >         __u32 flags;                                                   =
    \
> >         __u64 ext_flags[ext_flags_count];                              =
    \
> >         struct name payload;                                           =
    \
> >     };                                                                 =
    \
> >     static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),    =
        \
> >                   "LUO struct " #name " size mismatch!")
> >
> > For example:
> >
> > struct luo_memfd_ser {
> >     __u64 pos;
> >     __u64 size;
> > };
> >
> > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
>
> I think we are getting close, bu I have two remaining concerns:
>
>  * Reserving bits in each flags word for continuation leaves gaps
>    in the flag space that users have to know to skip.

Yes, but callers should never manipulate the raw flag words directly,
and we can provide simple accessor macros or inlines that take a
contiguous feature ID (0, 1, 2, ...)

enum luo_memfd_feats {
    LUO_MEMFD_FEAT_HUGETLB =3D 0,
    LUO_MEMFD_FEAT_SEALS   =3D 1,
    /* ... */
    LUO_MEMFD_FEAT_FOO     =3D 15, /* Automatically lands in
ext_flags[0] bits 0:1 */
    LUO_MEMFD_NR_FEATS
};

if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
    /* handle hugetlb */
}

>  * struct name##_hdr only matches structs written by the current kernel
>    (in terms of length of array and offset of payload).

This is not an issue on the incoming path, we never cast incoming data
to struct name##_hdr or access ->payload directly. Instead, we parse
the incoming buffer, dynamically compute the header size from the
continuation bits, and cast the payload offset to "struct name *"
based on the negotiated feature flags.

>
> How about this instead:
>
> struct luo_ser_hdr {
>     __u32 size;        /* Size of header + payload in bytes */
>     __u32 nr_flags;    /* Number of features encoded in flags[] */
>     __u64 flags[];
> };
>
> Each feature occupies 2 bits of flags[], so feature N is always bits
> [2N+1:2N] of flags[N / 32], with no gaps:
>
>   00: Feature not present
>   01: Feature present, safe to ignore if not supported
>   11: Feature present, must be supported by the next kernel
>   10: Invalid
>
> The length of flags[] and the header size are computed directly rather
> than by walking continuation bits:
>
> static inline u32 luo_ser_nr_flag_words(const struct luo_ser_hdr *hdr)
> {
>     return DIV_ROUND_UP(hdr->nr_flags, 32);
> }
>
> static inline size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr)
> {
>     return struct_size(hdr, flags, luo_ser_nr_flag_words(hdr));
> }
>
> static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> {
>     return (void *)hdr + luo_ser_hdr_size(hdr);
> }
>
> and bounds checking is just luo_ser_hdr_size(hdr) <=3D hdr->size. The
> payload is always 8-byte aligned.
>
> Payload structs are then declared on their own, with no header:
>
> struct luo_memfd_ser {
>     __u64 pos;
>     __u64 size;
> };
> LUO_SER_ASSERT_SIZE(luo_memfd_ser, 16);
>
> The static_assert covers the payload to catch embedded structs changing
> size.  Asserting the header doesn't add anything since its size varies
> by kernel. And because flags[] is a flexible array, the header can't be
> embedded in front of a payload in a combined struct; it can only be
> reached through luo_ser_payload().
>
> I think the only downside is that the header increases to 16-bytes when
> there is at least 1 flag. But I don't think we need to be so concerned
> about an 8 byte difference...

I would prefer to keep the default header at 8 bytes. With 15 features
fitting directly inside the base __u32 flags word, adding the first 15
features to a struct keeps the header at 8 bytes and does not shift
the payload.

Computation-wise it is also very similar: for the 99% of structs that
have <=3D 15 features, LUO_FLAGS_CONT is 0, so computing the header size
is just a single bit test with no loop. Even if a struct ever needs
ext_flags, the loop will walk at most one or two extra words.

Pasha
