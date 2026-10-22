Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792642342;
	b=P7IXZ1R/GZbXxfiBoNmuy/9WSf35lnml1RdDtMe9kJcEyqV+iNeoZGNrb2rY0eIPflqC
	 dGlSyCL2AViXL1xrxjY3LI5Ke2ke0gaWWzRv6itw/c5fpvRBc4Sh9AJKsSdjWKf3By8ds
	 f9jlUaNNEf/06/7QMjnA58J8R3HX/WUh+HbGboluOXCWK1hBDyYJNOY21nGrHpmViwtHo
	 sywF5snmvZhoGFztCtBtkE4KrKbDvvupbnRlX4oMXYC+j4xHfAcqA299HHHjPOrfvwXWo
	 vR6vMaxsmN7hKqPviUgYRjh2fOTkWNZpkao7vd6RWbcycyGKjvx5Sj393OJtryv2Wcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792642342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=;
	b=VH7E/MbwhPV0zOcvXSojfUHE8w7hozqYmv+9dGM6snMK2Bfcz39x/TeHoxoUHHuGHmwy
	 7MQOLiU/8I27cZX5SggCyUHxle2cP4HrJLPIbeapY2WvaT9C+a56vYknXJMfF433NhiT/
	 qczwJXL7xPargZeWZQgPefHXWYYkayVQiCChmgHfE2rMm2WdfiZ78O73Og2xvJI34xgGf
	 Uz1lAfTq6vUpPQ4P8lNubUcXMMCbPbZ14uhOVwRx5b326gOGNTjcKEIuPLLYKDNASGIeq
	 y8wbfs9pGWVvLAL+ODHBBMi0KfNxBqm4Yu+frvyj+GpYBF8l5IOW4JjaGsAO0M8fu8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=OkJDOj81;
	arc=fail smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF1606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 04:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81FF1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=OkJDOj81
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so1781216a12.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 21:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792642336; cv=none;
        d=google.com; s=arc-20260327;
        b=lAjnhhRJskWovaQxzmL9/pCFN5//guURCIQO8Sa1lhFXdDg6jJN+JqAwB9NOwFuEVF
         UFgNTSZO9drsSBkQo5+rtwnq9tSPErqKpps3fWN/7IQYEsi/dt0712iRhSMQxgmEJqCM
         WHl6s7Mtj3niSHXTwideOwWhNPv3mP5k73ZqEHYarIM/sUiV3yJ0+98pMHUoyEkXIg9L
         2eXzfSby3JMMhnozwMsIPhMevXWRWZZl+uyor5E0WXmN1o3McjhyBsbeqknFcjMdzdrg
         8FVnfiAydqB2ffhDdJKbIIb+nqSBogTNKRkamUsl4CE4hswtNN3AiFYso737udQFeIcK
         j95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=;
        fh=tZh0GITtQxaAZpCwjVkj83/8ORYRlUT0xq05a10UByo=;
        b=abstKsO7i4neXJ3mMcUMPLgyvxRDKnGTOMq4sRflf9CEGjSrCdx4DeyRT5KvTiAR5/
         O4PcXNz5/kXKe5ZFtnsvvOYOFc7QvsCfrPaIkWucrFFmeTpYd86wZ/MfQsNOOYwQuyzv
         uufrWxUARTXkuC1HKpmJLRO1kSXplsu+Gx9YIVdR2XTGoHj1y31fxtL1zpAIwn/QXnME
         wM3qtcSvHMN5xtjHGKTfeB2PhDYJRXATHR3PvygAUvD7i1x1t+g8nNUPnRdWxPVlW2eb
         z8+nY3x6iBokgtcLeWJ9DjXeUA33n05+NHhC4ApixljdTk93havwnYFPSGqUvhbU62nP
         q0Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792642336; x=1793247136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=;
        b=OkJDOj81ZAWZ9Kr8qFhitQXfop4rm4TJiDLxXB5ybMVTNC3hFUsHpqZbi1moDwloUa
         L+uYlcrs3ZwE+OjbHgizdVN+yMMil6H47NosW0L9eyjQOKm5HYJ5bMTbrXCy4jEr8omh
         8oDxUqmc3XL65fCrOpQx/EvlDtZNhkntKfDYnifoCE7UQtleeLHZzrDoGrO6OPrYj9s5
         V8BWUHbUOovEmj7ETLT1YrtuT4exXqnJraHcwrQ+iyyGu3uuUPg38xUSaZi7SGoh+8dj
         SM7I57E3BvYwIut858pVzNxBPzFcVowCDjDVG8Zri8Crp2bzyMjHIs43KaqEU6lMV8Jc
         e/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792642336; x=1793247136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=;
        b=1ugd/Tnqpo31Qh6P/FG2EH6Hf53MgkkHBMdJXDyjE3BKns2j0WC/YnRzIWSzLGG2Gk
         34sSsokyMMZfnKQ7KlNAxsqvYwZUkoeCeCkNXBpJMABebApcrZN22Ivl34rY8sP8f27W
         FR92MbOkNh3wXTDeFFfmq7nLkGkppimtwoalWi9uq3hwYwhNu6nnN9cFQ7vqu+GGeuAW
         GQU9SYHoVDkRov8N9J/ZMOHe/iSAjDmHk9lSLFpXXOkYdX2Oc8axN3urOc8XKO8WqlBQ
         RY8HQSfkmGGUQzGi1+fLp0ggvMhuv7pFoW0CaBoubHrgope/S0CyhgaYDtO/G596g/t6
         0qOQ==
X-Forwarded-Encrypted: i=1; AKwUvBytdFkLTD8Efy2/QGtU7mpefAa1nl725IsYUVvYesqDHUp/yPPbV1AHQxZml0unwoDti6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjJdacC8KCeacZssV5jjHhPtfJTqGNq43KWe23YFqVcSrou28v
	Wu+jZmUzJ3ZpXzV4naJdPlQaP2YBBLYTl7QYXHBawHeUPBCeiohR4Yyf7a0D+whONBua3yHiVHE
	sEop/pgZnQtNNqB5YHwPUJ6meSED60hZd0ZaVkDWmoA==
X-Gm-Gg: AYBFou1YvNl81MV5xKhQThGl+FkgiJOzmMmAfOQ+ZOmQU8Mf+KJVHBb9qoTxOW69ZMx
	/qWLW4evRInSCQUrsZhc6/mN9idKOA7XGgoTcscUQZLq821qCZv+h4zatGOuJoTGQxwUiExwhpI
	Vb9oenhehigZ0QJeOwLy5afwsitAzuyPqMSOXg2e2vC/n6Qwetk5Ww3G6Vg7TwMiBM8Y1rdui+8
	amtL5W7pEb0FqL7H+xxLbO+/sZC+NNEWJlgswNTUYRCcYX0MY7nptjW9uf6U3PCrqzSs5vXobEY
	IpiFn+aDJ4VqBqExbWu+kol3RFAEpizscDLbhKdkXzwhJFCjh2dS3k4xICLe8/Q1NbZd6X1hWeQ
	Y7vl7uYIk+OLqM30+eCxH5zgCl4KmZpbazsZR9k82ZUEiIx/6atgWu5zKb21U9ndY+s9TMb5ENM
	Wh0wA/SzjqTDkKEigfEOTp1Z8rI5Y=
X-Received: by 2002:a05:6402:5d4:b0:6ab:e30:c9a7 with SMTP id
 4fb4d7f45d1cf-6b408e80bddmr3221542a12.10.1792642335878; Wed, 21 Oct 2026
 21:12:15 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
In-Reply-To: <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 00:11:39 -0400
X-Gm-Features: AclHuK_pCDHndbxcQ4IiuuWok4wCO_ZxudIta9yn_V-W6vImOs3uvaPF1BC9RHM
Message-ID: <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
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

On Wed, Oct 21, 2026 at 11:53=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On Wed, Oct 21, 2026 at 8:32=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Wed, Oct 21, 2026 at 10:57=E2=80=AFPM David Matlack <dmatlack@google=
.com> wrote:
> > >
> > > On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> > > > On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@goo=
gle.com> wrote:
> > > > >
> > > > > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > > > > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack=
@google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.co=
m> wrote:
> > > > > > > >
> > > > > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > > > > >
> > > > > > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <taru=
nsahu@google.com> wrote:
> > > > > > > > >>
> > > > > > > > >> LUO and its file handlers validate handed-over state wit=
h monolithic
> > > > > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change=
 to a serialized
> > > > > > > > >> structure, even an optional additive one, must bump the =
string, which
> > > > > > > > >> breaks live update between adjacent kernels. Replace the=
 string in
> > > > > > > > >> struct luo_ser with a feature header, so that the target=
 kernel can
> > > > > > > > >> accept or reject the source kernel state per feature.
> > > > > > > > >>
> > > > > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the s=
erialized
> > > > > > > > >
> > > > > > > > > This patch is all wrong; 128 bytes is far too large. For =
every _ser
> > > > > > > > > struct, we only need 8 bytes instead.
> > > > > > > >
> > > > > > > > NOO, It is not. It is intended to avoid complex mess with u=
nnecessary
> > > > > > > > over-engineering.
> > > > > >
> > > > > > 128-byte per serialized struct is not starter.
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > The first 4 bytes are the size, and the next 4 bytes are =
flags (i.e.,
> > > > > > > > > 30 feature flags + 2 reserved bits for flags extension). =
The last two
> > > > > > > > > bits of the flags indicate whether an extended flags fiel=
d is present.
> > > > > > > > > Each extended flags field is 8 bytes, and its last two bi=
ts indicate
> > > > > > > > > that yet another extended flags field follows.
> > > > > > > >
> > > > > > > > If we will have dynamic extension of flags, Think about thi=
s.
> > > > > > >
> > > > > > > To support dynamic extensions in a backward compatible way yo=
u want
> > > > > > > something like this:
> > > > > > >
> > > > > > > struct luo_feature_hdr {
> > > > > > >    size
> > > > > > >    flags
> > > > > >
> > > > > > __u32 size
> > > > > > __u32 flags
> > > > > >
> > > > > > >    extensions  // offset of first luo_feature_extensions (or =
0)
> > > > > >
> > > > > > __u64 extensions[0]  --> but the size should be specificed in
> > > > > > declaration macro that I showed in the next patch.
> > > > >
> > > > > I think you may have misunderstood what I meant. In my proposal,
> > > > > extensions is an offset to the first extension, not an array of
> > > > > extensions that immediately follow the header.
> > > > >
> > > > > If the extensions immediately follow the header, then the number =
of
> > > > > extensions is baked into the struct layout. Every field after the=
m sits
> > > > > at an offset that depends on how many extensions there are. If we=
 ever
> > > > > need one more extension, all the fields shift and old and new ker=
nels
> > > > > can no longer read each other's struct. That is the problem Tarun
> > > >
> > > > We can structure it cleanly by nesting the payload: something like
> > > > struct { struct header {...}h; struct serialize_data { ... }p; };
> > > > That way, the header can expand dynamically at the front, while all
> > > > fields inside `serialize_data` stay at fixed offsets relative to th=
e
> > > > start
> > > > of the payload.
> > > >
> > > > Since the header size is self-describing via continuation bits (e.g=
.,
> > > > the last two bits indicating whether another flag word follows), LU=
O
> > > > can
> > > > easily compute where the payload begins in the incoming blob. This
> > > > keeps the implementation simple, avoids linked lists of offsets.
> > >
> > > Oh interesting. I agree a dynamically sized header at the front can w=
ork
> > > and is simpler than a linked list.
> > >
> > > So the header and the payload need to be separate, and the payload is
> > > located with pointer arithmetic on the header. For example:
> > >
> > > struct luo_ser_hdr {
> > >     u32 size;    /* Size of the payload in bytes */
> > >     u32 flags;    /* Bits [31:30] indicate an extension word follows =
*/
> > >     /* u64 extension words follow while the continuation bits are set=
 */
> > > };
> > >
> > > /* Size of the header, including any extension words. */
> > > size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);
> > >
> > > static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> > > {
> > >     return (void *)hdr + luo_ser_hdr_size(hdr);
> > > }
> > >
> > > On preserve:
> > >
> > >     hdr =3D kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(=
*ser));
> > >     luo_ser_hdr_init(hdr, sizeof(*ser), ...);
> > >     ser =3D luo_ser_payload(hdr);
> > >     ...
> > >     args->serialized_data =3D virt_to_phys(hdr);
> > >
> > > On retrieve:
> > >
> > >     hdr =3D phys_to_virt(args->serialized_data);
> > >     err =3D luo_ser_hdr_validate(hdr, ...);
> > >     if (err)
> > >         return err;
> > >
> > >     ser =3D luo_ser_payload(hdr);
> > >
> > > What would size mean in luo_ser_hdr? The size of the payload or the s=
ize
> > > of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing=
 so
> > > maybe it's just the size of the payload?
> >
> > > What would size mean in luo_ser_hdr? The size of the payload or the s=
ize
> > > of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing=
 so
> > > maybe it's just the size of the payload?
> >
> > Either works, but having size cover the combined hdr + payload
> > provides a few extra guarantees:
> >
> > 1. A single static_assert validates the entire serialized struct at
> > compile time, including the header and the number of ext_flags
> > elements.
> > 2. Bounds checking while traversing the header continuation bits on
> > retrieve: we can sanity-check that luo_ser_hdr_size(hdr) <=3D hdr->size
> > so we never walk past the end of the serialized blob if there is
> > memory corruption.
> >
> > If we declare the payload struct separately and pass it into the
> > macro, handlers also get a clean type for luo_ser_payload(hdr):
> >
> > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, payload_t=
ype) \
> >     struct name {                                                      =
     \
> >         __u32 size;                                                    =
     \
> >         __u32 flags;                                                   =
     \
> >         __u64 ext_flags[ext_flags_count];                              =
     \
> >         payload_type payload;                                          =
     \
> >     };                                                                 =
     \
> >     static_assert(sizeof(struct name) =3D=3D (expected_size),          =
         \
> >                   "LUO struct " #name " size mismatch!")
> >
> > For example:
> >
> > struct luo_memfd_payload {
> >     __u64 pos;
> >     __u64 size;
> > };
> >
> > DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
>
> This looks pretty reasonable but I would name the payload
> luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
> should never be used directly since the offset of the payload in that
> struct is only valid in the current kernel. So I would give that
> struct a special name that makes it obvious you shouldn't be using it.

Lets drop the fourth macro argument and generate the combined struct name:

#define DECLARE_LUO_SER(name, expected_size, ext_flags_count)              =
\
    struct name##_hdr {                                                    =
\
        __u32 size;                                                        =
\
        __u32 flags;                                                       =
\
        __u64 ext_flags[ext_flags_count];                                  =
\
        struct name payload;                                               =
\
    };                                                                     =
\
    static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),        =
    \
                  "LUO struct " #name " size mismatch!")

For example:

struct luo_memfd_ser {
    __u64 pos;
    __u64 size;
};

DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
