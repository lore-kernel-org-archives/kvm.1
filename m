Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637867;
	b=fft6bEgZyC3TcdEkoyGhJcY6or1gQF5eYOdEkTZaKDMsB7x376lmZh5pI1/Uce56ZVK6
	 eYDmEbH8y5GcPnfBdPzdSXK8pXASV/8ulnIQH9cBR3/8kQ66dM4Cru3jOBU6tvyFGXtUe
	 463KP3yLjlus6aw+W4Q3P5LRBpFUsSnbdX2P/9RqnJxsDkkenT8RL9j3AtHjtkdxChnnz
	 RBcwRVdZ/6kMIRSSanJxkrv/nCLphHO4ARvYYJ/EnDbd+uesQr3RHQP0kptbmcD6e1NeB
	 ZZj7ROx6uAPXQmNJx+CoUzr0crUXLBSoRRnloWDke8wnlb5axYw6h49ku32vgdOcoMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
	b=JQpLHMp6sY8X/D9NEg7aiFBXXmAE6Bsi+QwRyVjVQ6RFuPpE6+NxNi3LYL8BzocnspTs
	 IFOxwJ2rB3huUJB7zzn8B43LkkItQlw5FvoyGMVynqAWal5NJgprTfaaqUNDQIViLMy3J
	 9rvZ/mrnPzr4IAv43dMoax3LguN9Q6Za2ZNpM2Na+H7luN4r2fEr3Qs/cyHNAHx230Cj3
	 u/4RnDbs5QQVdTQVm2AJBMxcLcGxMDP2KQbCP7G9BFfez/JrdDCmwe7QM+3yz8TvtPkD7
	 sWcxH6CmQBk3fk4AORmHFZbA0gwV1qum+3ojR413EnsxHykvSTYaMAp0Fzuo2/ZbCZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dRoWI2O9;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE4606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EE4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dRoWI2O9
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9eb579c0eso7798175ad.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792637866; x=1793242666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
        b=dRoWI2O9b4O92k+WOpxwi565DGBEPYlPq0ghfq07r2y3WRvZEDPJ7i0ROgbY6wUSuS
         AdNT2jZT04waQarxGzpsFOkuGkcLz6ztwEZzLkyCgXet2o61a5dXghq9VTZ92NNNcMrf
         /+LGCpmWuIP1Aagyq4YfMSLq+WSt92yoZPw+QaI762w393JWkg6u8G3V17ksbFYBBVzI
         gHiGvVlcABlRMpDhSMkjjrVx/XmdpP/fklOi0VmZNnNnWKpmuvwaR2vQUOrwKNF2oWcT
         QYXdnfSlN1Fdfqf3CrBxt7gsbSBeCL3AcwfNBYU/Go70bECwqrn8/zbZOHnb2Tq4F2CH
         jQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637866; x=1793242666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9EhJunI31x30V5twb29p5JvXR/ZnOh8avGc16eTeBG0=;
        b=Xq/93mwLdoexaho3Y/OFYW1flZuKPfEck+T/pZTEbIKUXuBPXDKkE9i3aT/6nYGf0w
         q4kEgbsJM+27kK+1Ul0BeVUUdLAHj7ono1C90shYKJVUI1B5caovHU4mgPFWRigArYx0
         nao5MvSuE8SLN9ETR4Q4jOEzsq/Up3Ev8DOkgu4a4nYy4CMNMMIm5LxQEaLL7YLiF1ee
         w6jCB/VQZactsWU2WodmQ9NkbDo5ZEqu/Wic8cDoPRNmHXoWbI3BAoWWQEW0LtSMyHLW
         /pSC0L2rfEm/2Ae7001kw4IydpOluvHq+HcC5Yb19AdwFapIIatT/bSiSjJNLFb1hSBG
         gCuQ==
X-Forwarded-Encrypted: i=1; AKwUvByYjBCbpKSIwtWH33/WjvGMGz1ZJinzvAdXUu8A4DFuwQXIhRVFxY0P1MZSRJbMarMOc/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYK24hBLRS67Wowb92DTuMWqCJVMDnhNQlGTu8EEQekw/KtmS8x3
	PZ8S/M1EojSpbFXMlOt/kABb3poeJrDN4GKl+jIZdabaNevgfnmC/Ej5N3ZZgeNOkQ==
X-Gm-Gg: AYBFou2vdNfvHoYmdoMjvpZRCB81QzAWIINyRQc3zXoQRY5L8l5SDaWbSr/QAJpr/B1
	IRdNeQPMyamOrsudsSTJW7JNE56l9Q9WZ9RuLK1zEADakc5nj1+6KRsg2f9eoettIDSDrQmF6GU
	QnrQJcFIR16PXK5zLGfM98UwnmS3yjoJgfk7a4h4LWociEGKBRBrPtgdijBl3JKs0P8WGLV0iGa
	1HmLjuZzSwJk8uUGHazGuj7Frvq5wnZpeRwwOdNjpQi0DJq//76hNWOLM8RbprcpDe4yCMrV/kD
	bSzJ+i6gkyc/DqmbZCJNKakzqAP/l5FNxLDMcbcxLSNThm64VrnwOXdkT3XdeUF7IlgjJRmeXc/
	NS2/5qwbN7QECl3h6xKgmngYN70sr6T3M3LRSkHzkFt4mKkRXphcu/w1wlBpro6dWKttvmtWHC0
	vHzc6JHmqB0ysboSch7e2MuYp8TshS7zulYmxCSs+m2bnXIuUyBW5k6FAB7nDaFOSxTuECcerhq
	xMpRB0y0gg7ipeLXePokqE5q1D+JMYJEhen+waVIR8kiTITe5Iv1BBaT2YkQKI4+euwojHHsX2N
	SsRf+FSBpj9eNqtJ
X-Received: by 2002:a17:90b:3ec8:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3ad86e96c9emr2886416a91.22.1792637865925;
        Wed, 21 Oct 2026 19:57:45 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada495315dsm2092370a91.15.2026.10.21.19.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:57:45 -0700 (PDT)
Date: Thu, 22 Oct 2026 02:57:41 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atl7peoVHdP5hz7z@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>

On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 7:28 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > On Wed, Oct 21, 2026 at 2:47 PM David Matlack <dmatlack@google.com> wrote:
> > > >
> > > > On Wed, Oct 21, 2026 at 11:40 AM <tarunsahu@google.com> wrote:
> > > > >
> > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > >
> > > > > > On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> > > > > >>
> > > > > >> LUO and its file handlers validate handed-over state with monolithic
> > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> > > > > >> structure, even an optional additive one, must bump the string, which
> > > > > >> breaks live update between adjacent kernels. Replace the string in
> > > > > >> struct luo_ser with a feature header, so that the target kernel can
> > > > > >> accept or reject the source kernel state per feature.
> > > > > >>
> > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > > > > >
> > > > > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > > > > struct, we only need 8 bytes instead.
> > > > >
> > > > > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > > > > over-engineering.
> > >
> > > 128-byte per serialized struct is not starter.
> > >
> > > > >
> > > > > >
> > > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > > > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > > > > bits of the flags indicate whether an extended flags field is present.
> > > > > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > > > > that yet another extended flags field follows.
> > > > >
> > > > > If we will have dynamic extension of flags, Think about this.
> > > >
> > > > To support dynamic extensions in a backward compatible way you want
> > > > something like this:
> > > >
> > > > struct luo_feature_hdr {
> > > >    size
> > > >    flags
> > >
> > > __u32 size
> > > __u32 flags
> > >
> > > >    extensions  // offset of first luo_feature_extensions (or 0)
> > >
> > > __u64 extensions[0]  --> but the size should be specificed in
> > > declaration macro that I showed in the next patch.
> >
> > I think you may have misunderstood what I meant. In my proposal,
> > extensions is an offset to the first extension, not an array of
> > extensions that immediately follow the header.
> >
> > If the extensions immediately follow the header, then the number of
> > extensions is baked into the struct layout. Every field after them sits
> > at an offset that depends on how many extensions there are. If we ever
> > need one more extension, all the fields shift and old and new kernels
> > can no longer read each other's struct. That is the problem Tarun
> 
> We can structure it cleanly by nesting the payload: something like
> struct { struct header {...}h; struct serialize_data { ... }p; };
> That way, the header can expand dynamically at the front, while all
> fields inside `serialize_data` stay at fixed offsets relative to the
> start
> of the payload.
> 
> Since the header size is self-describing via continuation bits (e.g.,
> the last two bits indicating whether another flag word follows), LUO
> can
> easily compute where the payload begins in the incoming blob. This
> keeps the implementation simple, avoids linked lists of offsets.

Oh interesting. I agree a dynamically sized header at the front can work
and is simpler than a linked list.

So the header and the payload need to be separate, and the payload is
located with pointer arithmetic on the header. For example:

struct luo_ser_hdr {
    u32 size;    /* Size of the payload in bytes */
    u32 flags;    /* Bits [31:30] indicate an extension word follows */
    /* u64 extension words follow while the continuation bits are set */
};

/* Size of the header, including any extension words. */
size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);

static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
{
    return (void *)hdr + luo_ser_hdr_size(hdr);
}

On preserve:

    hdr = kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(*ser));
    luo_ser_hdr_init(hdr, sizeof(*ser), ...);
    ser = luo_ser_payload(hdr);
    ...
    args->serialized_data = virt_to_phys(hdr);

On retrieve:

    hdr = phys_to_virt(args->serialized_data);
    err = luo_ser_hdr_validate(hdr, ...);
    if (err)
        return err;

    ser = luo_ser_payload(hdr);

What would size mean in luo_ser_hdr? The size of the payload or the size
of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing so
maybe it's just the size of the payload?
