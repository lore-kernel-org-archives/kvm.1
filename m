Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071595;
	b=wlIcjjyCi1u+iARFCSphFavuRGI543zkwd2F89qSEOmBoxvMOk8nv+RMxVki06E/M7fD
	 KrPvJB+4MnK2AVHuMbeG3dtTi6AU+IgpOK9ENmzP7Hmm3nxB4229zVGclXBVJi4LiA/+H
	 6w7GxO9Oc8MRqx0oQM16bPjAxZAYMzduY9Ea/0T40CC/6gSXanttYQdh6QmjbWBp6wy9O
	 yn/hZmRx6CQvlYhasPHjvuPIg2Yl6P4cvLg0QPwRaYl9EbxTd0Zl1jPfKp7vdQsgXuCo5
	 MHVbwtyXOvkaV20plmw4VcuJCEO6jAV7R6Otmx4icAGxz0W/bwcbO84wVJ7V8hhd6Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
	b=IlJ2v0jJ6chzXpgILaH2aiIEYhIy1uSHvk4ppxJK0xsAox9UarBzw+tt0WLp+7V7zsv2
	 dHuUvbK2/BlT7L+eesxXbinrXp81WwKWYaAywidA0vSKMNdXIkCGkoqCjCwvxIISlme9V
	 l2idQAn99Egs6Gidkax4Q9qLGQcLon939gJ5oJxdcWfrgcfkwt5qtSeAs90zdYNBLw6Rc
	 VVq9a5mfJTdBJ1j/mXePLD+ZRHgrUm9VEqr+G650wqU3dXiTGFT4botcotfAeTI+eIrCn
	 qOLRARcig5Fq0YndBzPbW4pLdidJZsN3dwKAWl9jCgU+7DRFzgnJa4uE6pAY7eJFMQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ctJlfWTF;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC7606A325
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 03:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EC7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ctJlfWTF
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ea7190aea1so16744445ad.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793071594; x=1793676394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
        b=ctJlfWTFSAAkxOyoCbcKoCYm5sa7PQkArlEMktHuP2e1Z/TnvR6B2Eci7g7zR2OP/a
         z0ftTAM8q4BPpA9mLqA7HjdTBvZ884W5DhsbdTWH3vGa/U34pPpFF6m6vA7CT7hUTsDE
         EsLODOrMJPN2eHtZKvdn0E4isOhcUZnygqt4dpaj92LFqIJK5CWBhDAgNImVyZDizUUs
         rq7cdrDg/cEa1tu2hYIjPpmenPe4O39G2U5GiueFTlIFLOa3FxrtMMGNsascOXMjvg1L
         ynwndpzHxdBStfN0SD4wcz9ESDOBFHh48Zs79R+0rBSX9WtRnYmpf0wOG+HDjrNwStrQ
         y0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071594; x=1793676394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
        b=BAy99KwHOn2G3maWwZ92jv9iE0+fo5VUs/PmYTskY5sh20xC1MtGpbi41dPLs7AKQm
         RN3kH9C+kTCssaAJkGfBBvatr2I0ORHgPArOteMs562+odc3eESlhiwPy4Gc7uyozsql
         Gq/UFB0ZPJjiiSjBCup9sE5ZCsc2QcJ4X2IDD2Is7goPgN9AtXKhNElRIK2r60JX/duj
         Amf7vztx2vl8R4XpOym+VkM0JI1w2ZwLBBEzgHJUvwwi3SmhVSWAMg1A+mRMtQkj380o
         cP4++s+clDKLCHYi3OmNZBxYU1W3Vuwk7ScrOKcD+CpfDX/AOokzcZmU4CQn6y5IJR8q
         0NeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzd9WbA/fGSuz21YUx+eK2XI8CY6CmfJ4u8lRDbiJ9rD607tcaJcNhNM/9/1ql3Dctr1Rk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwvYGjRMy26bO5OhKrWbhImgEoV2eQ8dVhaAPP/O88eZkAqdA2
	48aOI6pHT+WxhZNvsUzM/mWNwDeXI7KUnGU3y84xEE9Y6GppHwMDnVeH/b1vblU3Fg==
X-Gm-Gg: AYBFou3OtGHwUvEpP1cG7cEd2skQAtzotM/QVqXL/S+RIxWtzdcpSiqTB6X4sMZbHS9
	h0+EzfEsTONTLlkgMVxhulqmR/OgaBO/NrHYShgMJ5ddz4Ag3hONS+GZZqRa+48IRdID7EFvCY5
	RIhOWeGcLLDLw1xT5voxWf6rw6Hp0ip1Exeq2uioKSldfBgC9D7REIMNmn0bZumSrVaIJyhKGKr
	QSBcHeWXS8c69LdY54mM0B+euEP/lF8hyzmHR2OKLURgoyHWj0jLZrAtyuDkLykAhdSnjo1XBFF
	1ikQaHpzMDBGQ3Lr1PHUnX2LVoD6weVWWjaXcNWOsfTfhUuTIaZ883PDRqTDSOgtbcdeweZev3O
	tNoGLLj26bv2aPW+ZO92BxYFAbmp+jaRWV9suXrdNQGMXMBWfk4qBy3qOvyRdhI/esGn5j0Hv2T
	Qc0e+jMoPex59bR6sCvx/aY3Vn0F9Qoq28DjtZff9+8eRJjaupsZmVfHGKddiEsaX4Dv4u2N+Fc
	568Br5rYTVup0M7cYvLWkP8V4MkvltFoIhCSb1XkXADd56ya0MMyBU9eZSpUJS0m/lD43ew3t9P
	AV2yXNIV3fuSN2Er8cJW+MRKhsAq4FCMtk6RlSmANVek3WKXeCfWpAVSuM17Dsg33oi4pkw=
X-Received: by 2002:a17:902:d548:b0:2df:ad58:cf54 with SMTP id d9443c01a7336-2ea9c81ab95mr64373815ad.34.1793071593614;
        Mon, 26 Oct 2026 20:26:33 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce0f45sm2398915ad.70.2026.10.26.20.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:26:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 03:26:29 +0000
From: David Matlack <dmatlack@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auAZ5agR1xBo3RLN@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
 <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com>
 <at_pxoULR1Tp5anN@google.com>
 <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>
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
In-Reply-To: <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>

On 2026-10-27 01:55 AM, Tarun Sahu wrote:
> On Tue, Oct 27, 2026 at 1:01 AM David Matlack <dmatlack@google.com> wrote:

> > Right, whether a feature is required is a static property of the
> > feature.  That's exactly why it's redundant to send it in every header.
> 
> I meant the different thing.I was saying if a Feature in a kernel will have
> constant value either required or optional which is fixed at compile time.
> But the same feature can have different values in two different kernels.

Those would just be 2 separate features. One optional feature, and one
required feature. They might use the same fields in the struct, that is
fine.

> Maybe a seal added in kernel version M. Later in kernel  version N this seal is
> deprecated and replaced by a new seal.

I think this example works fine. The old seal is still a required
feature. The kernel just stops marking it present and marks the new seal
present instead. Retiring a feature doesn't change whether it is
required, only whether the source sets it.

The only thing this split doesn't allow is changing the whether a
feature is required or optional after it has been introduced. But for
that case we just introduce a new feature of the desired type.

> > I think you misunderstood the proposal. I'm not proposing to pack only
> > the set bits, and I'm not proposing that each feature have a bit in both
> > ranges.
> >
> > In my proposal, there is no such thing as "feature N", there is
> > "required feature N" and "optional feature N".  Required feature N can
> > be found at bit position flags[N]. Optional feature N can be found at
> > flags[nr_required + N].
> >
> > In more detail:
> >
> >  - Each feature is defined as either required or optional, once, when
> >    the feature is added. That choice is permanent.
> >
> >  - Each feature gets exactly one bit, in its range, and that bit is
> >    always at the same position whether or not it is set. Required
> >    feature N is bit N. Optional feature N is bit nr_required + N.
> >
> >  - nr_required and nr_optional are the number of features of each kind
> >    the source kernel knows about, not the number of bits set. They tell
> >    the target where the optional range starts and how long flags[] is.
> >
> >  - A set bit means the feature is present in this file's payload. A clear
> >    bit means it is absent.
> 
> So For #NR number of features, We will end up using 2*NR bits which
> is exactly same number of bits, V3 [2] uses. So this is just a different
> way of encoding in implementation perspective.

No, it's NR bits. I think this is the core misunderstanding.

Let's say you have 3 features. 2 are optional. 1 is required. That gets
encoded in 3 bits:

  nr_required = 1
  nr_optional = 2
  flags[0] = Required-Feature-0
  flags[1] = Optional-Feature-0
  flags[2] = Optional-Feature-1

> >  - There is no invalid or reserved encoding to define. Each bit just
> >    means "present".
> 
> What if a buggy source sets both required and optional for a feature?
> That is an invalid case here. Same as 0b10 is an invalid value set by
> buggy kernel.

That cannot happen. A feature is either required or optional. If you
have a "logical feature" that is sometimes optional and sometimes
required then you would have 2 feature bits for that in flags[]. But
that should be an unusual case.

> >  - The target doesn't need a supported table. Required features are only
> >    ever appended, so it rejects any required bit at or beyond its own
> >    MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
> >    just checks the ones it knows about.
> >
> 
> As I explained above, incase a feature is replaced by another feature,
> new kernel
> can support it deserialization but it will not be required from there on. So
> The supported table will still be needed.

The one case where a count isn't enough is if a newer kernel drops
support for an old required feature entirely (e.g. removes the code
that translates the old seal). That can be handled with an explicit
check in the handler, or we can keep a supported bitmap. Either way, that
question is independent of how the header encodes required vs.
optional.

Certainly in the immediate-term we can just use a count.
