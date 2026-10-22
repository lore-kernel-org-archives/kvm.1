Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792632406;
	b=TbwKZiwIvpeE1kSXe6dQ58AghXeVDY+SFJU7+hqGaZsd+ob//dErXfBo7K2ezPO8Z+gK
	 d+BYodF4u2RgiWd40Y30giQeEYoBw0sQryR+b30pLzHrJj3SgLIxqnJqASG3qMXGj75Bj
	 pBu5Rc6QdRm88sY6UVJF4AgiBjAjqD3mktYJ9Tr4GUg2S+myypVXSrKMupQCZxvNaNYj2
	 5ZcI2254KRSJpGoOeghdiAO3I64RZUE+jxDYIJ81Zr1xFUllLUY8UVeknc83z/aAiqG2f
	 BK8wI+Bs4ee8LLQgEY7BRM4mtdZXstbiXovq+PUhIJ9vT3HBt0wRXfS0S7mbwzO5TWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
	b=M4OOfAA6g98pwlmIxWxtVZBEPt1OPnCtS5jyHF5LTVJmZIwa2kGpPby5gJuEICneB1+8
	 YQ+pYkADoE9Z2iv2p2dqbf2ymPhGhKvZp1O0z55yKFCaJ3DFpQoEPICt9GC2rp8a4K0Kg
	 /s0F6DTNPa9gKKdO9rrZblULKkZFdvA1LBVXC/8vn+Xb5bSKGU8v27gz69tUtLnHml05p
	 +/OkZxkHMqKrYtiA0yZUuyOSODPtFfYzGZGem96F0lmQKnWd8QPRZNe4XAns3AQYsKj6f
	 2tehQQ+7Vu6G8LsHFMl6soHkKiSl+dRi/kL1at0Pwqy56fYSu/8XH1WtQiDrWejZu4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UjasCW3N;
	arc=fail smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFB606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 01:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34AFB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UjasCW3N
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso1961047a12.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 18:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632405; cv=none;
        d=google.com; s=arc-20260327;
        b=EjZJyuBHXpaJjO1PdAeg58HD+9p8YS2NpdDuzcCWJuZrnZfAA3WaXX4/wNIPwubXnC
         XiD+eILPwIr4zmN9HrqjpVTPzh3Dcfq4Vk3YEhYQPzGl9gQ8QUAwBDZpt5k6atuxSd9v
         BD/MEFvp/3TRorhbHzcdzhmEfpedMblU4uwEViEgWqUEdmruwbyXR2+G0GgDyv0zR6m5
         IXm/5wUu0JyPe2jYFl0g80mOhYfnIi4W5fAqX86t+IfvWk2QJhxKYqdLThO3QbITtcOs
         uXIUionT3WMlrojzFzNgAyuKKtqp1pGgbaFB5fpUfeyf9rVLzbu+QFolQ9yaCeL3MEbz
         fySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        fh=gdIhExe4VlWt8iJxty0PdlbUH8S6iHAf8tiRAMPfePg=;
        b=EjxuUdrfEshQg+TVBOhyImVMD5Tsj2Pnxstz9vZDXTHw9qcipUyXPrRYV14e4jWM0X
         U45L0qQYmdUbNSaRm2w4NvZeh3ZMIea3YNR8K8jqrEqlObbKWQM7ZMfuoBH6lw3vVxfn
         6v7IdjqBu59a8ORCClWRYv0Onp/Qt2OjHkOE3mSq51BeeKPTgoMhKPADWtz8fXg7Ox2r
         G4HtJpQIAlccmsq+/HA/ounXmRxzxrXKB7w/PqdlsaYlvfcxBqLZi/U8EuGWCMkYSy7a
         1NczzYKv61LW+vpuSzdwa3Gc/7o9e8oM/F9KK/2dovVo7GRNr9tTx81jyEK4OQF6ACZj
         3xQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792632405; x=1793237205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=UjasCW3NpozzrrA3uptNAoyxN3DqKW8HmkXQNxzRnN/JTz/QnCPODSFsuQp+CU15iz
         1LkOjKGsHN11814MpjY+/WDEGC7whEmqGfcFHZilFU92hVZmd0P/jDJQsz1R1tiY1v22
         QEJjzFYaVhhlpS7AL3b9a9Eh15m7QtFtTO0PXMi0cpCfJWXwrmO20D3TU8B5QgOQt69/
         SNKIxNxzV23JLqHMuIqF+Rxhbp4ACGvPlVLutcB6tch3U6K8bn3cBIdJedvQXqJoWms3
         LTcsARGJuNIIBF49+wPKcY+NHi+T9ZqJmZfG7n2YznT0MSfnTRXZ9Wu7/w8UUAK2YMpN
         qYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632405; x=1793237205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=VKCTWR48SHr3ct8LDrASWX5kkf2yGhvgUyMCspb4iJu7JobKuLEev9fu8+QRgPz6F5
         FMlt5yx1aPyTpP3iGbAqg0kHDQPqHrLEsiogrJU2Kv/FLm5zhhPSMfsgBtKteVj8ZetQ
         80ipNGap+52DOzyR6kN4WzScl68GjO4dTd/nfAiliEgIkuR0AdCDAgUDorCg1otWJicN
         a7qczxVQBvINt08i2oas2pMpnzeVrApB/L3MCbi6YhLOAGPf7dMdvhvaj13GAd8L8mYJ
         vmnNvem36G8p29tlksP0zC2hcL2qQLpE78vy4M4/GtNntQcmxVr9HOWKJ5NJeaS1Q3c3
         ynPg==
X-Forwarded-Encrypted: i=1; AKwUvBw8Fu3fUWd5Fi5BmluWpd3I+2EG8mT+7KKuMx91SHP+NPzrn8maHoziV6gQLwXdqff7HpA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXaEKonvTVBYonlEWCJO1ExbdSlXzaHWzcrz8n///bKxBk/rRc
	JSvXij64aCRoKZJVolMoARMgbJ98S3ChaiafoLjADhjtUr2mant6VvSQ2djQN3VP4dk3JCn8CNL
	2AB8V2ouWypowwVWnpp3t24londQWkP/lgKly2wH/hw==
X-Gm-Gg: AYBFou1omzms7yDPXeSUCAa/d7qqNYYwZx+CHsbJjklbSwRUYSM87J4+vjY4W9XirOk
	K82bCWlFtsVe1U66L4EB/vxVF5W9eQNo1erPVGE2BL/B/1GseKU5Ae24nn2j7zcZBVErbbn3woZ
	N7al8C5JdKW9RO4PBgsHDKjFPL5Kn6l4OpVNcU+jmmOQp9KQEYf47jSrmJcfpjrW1zYQ45gxpSL
	AuEAZp2V3CXwfFg+1lbBgtMjQ2aP2YcItbsJIk4nkF8hZHM22ASyrS3rQ7Rs04qoyi/aKwxW+hP
	0Ox7g8SBdsbejFRxRwPKAhWKWkvHzD4PiQUWKAY2NkH1AEPVS0Ggs0nIIjZNz4hSUbAPZ9ySAyZ
	bsI6tSJnzIOdgM+dAzlQOPjIsEouC+OWerDdTDeDD5bwNO/9F2bXCrhBQi0iPJZFRQFc=
X-Received: by 2002:a05:6402:2801:b0:6b3:a1ad:ef6d with SMTP id
 4fb4d7f45d1cf-6b408dcce19mr2969744a12.6.1792632404378; Wed, 21 Oct 2026
 18:26:44 -0700 (PDT)
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
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com> <atlKsD-aJB3mJr2j@google.com>
In-Reply-To: <atlKsD-aJB3mJr2j@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 21:26:06 -0400
X-Gm-Features: AclHuK8Appp8OBdUFGLxu0V1hBTCm-a-9f142JZiexa4wOQOsDrRrU21F_J0R34
Message-ID: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
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

On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote=
:
> > > >
> > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > >
> > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@go=
ogle.com> wrote:
> > > > >>
> > > > >> LUO and its file handlers validate handed-over state with monoli=
thic
> > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a se=
rialized
> > > > >> structure, even an optional additive one, must bump the string, =
which
> > > > >> breaks live update between adjacent kernels. Replace the string =
in
> > > > >> struct luo_ser with a feature header, so that the target kernel =
can
> > > > >> accept or reject the source kernel state per feature.
> > > > >>
> > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialize=
d
> > > > >
> > > > > This patch is all wrong; 128 bytes is far too large. For every _s=
er
> > > > > struct, we only need 8 bytes instead.
> > > >
> > > > NOO, It is not. It is intended to avoid complex mess with unnecessa=
ry
> > > > over-engineering.
> >
> > 128-byte per serialized struct is not starter.
> >
> > > >
> > > > >
> > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i=
.e.,
> > > > > 30 feature flags + 2 reserved bits for flags extension). The last=
 two
> > > > > bits of the flags indicate whether an extended flags field is pre=
sent.
> > > > > Each extended flags field is 8 bytes, and its last two bits indic=
ate
> > > > > that yet another extended flags field follows.
> > > >
> > > > If we will have dynamic extension of flags, Think about this.
> > >
> > > To support dynamic extensions in a backward compatible way you want
> > > something like this:
> > >
> > > struct luo_feature_hdr {
> > >    size
> > >    flags
> >
> > __u32 size
> > __u32 flags
> >
> > >    extensions  // offset of first luo_feature_extensions (or 0)
> >
> > __u64 extensions[0]  --> but the size should be specificed in
> > declaration macro that I showed in the next patch.
>
> I think you may have misunderstood what I meant. In my proposal,
> extensions is an offset to the first extension, not an array of
> extensions that immediately follow the header.
>
> If the extensions immediately follow the header, then the number of
> extensions is baked into the struct layout. Every field after them sits
> at an offset that depends on how many extensions there are. If we ever
> need one more extension, all the fields shift and old and new kernels
> can no longer read each other's struct. That is the problem Tarun

We can structure it cleanly by nesting the payload: something like
struct { struct header {...}h; struct serialize_data { ... }p; };
That way, the header can expand dynamically at the front, while all
fields inside `serialize_data` stay at fixed offsets relative to the
start
of the payload.

Since the header size is self-describing via continuation bits (e.g.,
the last two bits indicating whether another flag word follows), LUO
can
easily compute where the payload begins in the incoming blob. This
keeps the implementation simple, avoids linked lists of offsets.
