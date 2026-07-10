Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B9224F3
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643567; cv=none; b=jWWHE67wsbF2RYhQ3i2xpOFqtJj1y6FlBRyPeaJ2NfRxzgyOkX88CryfFAJp9i3/cnU8XLf1/9e2FJCSBvDzocWAhY4EDlaPgLa6zA4ZbEat1jYf7q/bLCAZAtsdfsckUCkP47e7kGIi3qk74fNsGRCuc9ZutuUmPednIZVcFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643567; c=relaxed/simple;
	bh=+bTWA5hnGpiQxtS2T9bX9sGL7iC1eSy6311oxdmEM2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WmwPX/SsJ3VP0t755/OajGLs1PKYzWqUGhvqe/2ftaplBYnHS+9kHAZY2Ve4ZIMy481ytdAirzIkEDAIiDmKgV5xoGVc0vz9kTg68rnzCdO5gW0B3SGsZJ5WDhluL2sT2djYwguQIKLdclselELgoGhUN90DyUhenq0ojZIoOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amvL7340; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amvL7340"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a298cd62so342490a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643566; x=1784248366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8xU1EYHsasAehLSIMgUsqKDLz4v33CnWDNqy3BlS09M=;
        b=amvL7340VWWGHjKeG64WT/aQYHMpz8l+5weohjHu0q1J9rbHpJ3LENBPgebIv0XO3d
         XPSOgEfTx9/TGPY5YTtghoUudDVF64fEapQElaF2iew8atqMPb29rnFMnoz7g2myokz3
         +HlLZZnPTqCurwbHXlVSYiGp7ryY4kKS3tckRtBPCyzeH9wONB5ny3KODlSUbQzeZJvh
         lgyHX85tRagoNOygfjaUDcTxOTo67gCXi+dyBBKKsvh3o0Il+0ulwkHQ+ilen8j7gXym
         9/1LD9cIt0UlIeKUV/FI0qFUx+3Jx2Q60RwQ/6M2Xz1gP76SigWpL9RcUa9EA7dlnAty
         qTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643566; x=1784248366;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xU1EYHsasAehLSIMgUsqKDLz4v33CnWDNqy3BlS09M=;
        b=h8BZdBb6Xsede5hn+7VMLudhoDBc74T5VhD7TYWnPDpDLDxrhpdS6yOVzKXHLgqshB
         3oJp2fjsEE29ILewyH5l1pfDan9B6GdYYR7ApZEHenNv5rzZ7JyKkrDP8rVdHEb54cJA
         1n882exlAmSFgCa9SuZ0TnpqKwbKmoE1KqPNAfcGTcoF8cq8O+ZtQQ4BtXjuj844hMCN
         P4PtK1BfXCfjL55qsxMbOpM21Nsk0yu5yACCLV1HEFNz79MUwix99QUfpuDOeQLdZO0q
         /xUPFByajxEVEHhWKQbCP5w9Yodcq+HAv6kbCrELFjKsbjvHl/cNaivCybIIBN45ddaP
         M76Q==
X-Gm-Message-State: AOJu0YzYaQDWsr+iZALlX5Mc7BczcxD3YZFeHm7iIDEekOG1HssY3fDv
	OkgSAxDghV6xkJU8uIfFhdfu2N2WGVCiHwgy6V5tsfDNgVtv4pI0jPM5RbyFhZArESRCs3+yYuU
	b2PVXfA==
X-Received: from pggg11.prod.google.com ([2002:a63:200b:0:b0:c7b:b2bd:6cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e8a:b0:3c0:9c19:65a2
 with SMTP id adf61e73a8af0-3c0bd276af6mr10032774637.74.1783643565720; Thu, 09
 Jul 2026 17:32:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:32:45 -0700
In-Reply-To: <20260709211123.C97C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-16-seanjc@google.com>
 <20260709211123.C97C91F000E9@smtp.kernel.org>
Message-ID: <alA9rQSsMmfTfrTX@google.com>
Subject: Re: [PATCH v4 15/18] KVM: guest_memfd: Fold __kvm_gmem_prepare_folio()
 into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
>=20
> [ ... ]
>=20
> > @@ -82,6 +69,7 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, =
struct kvm_memory_slot *slo
> >  static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_s=
lot *slot,
> >  				  gfn_t gfn, struct folio *folio)
> >  {
> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> >  	pgoff_t index;
> > =20
> >  	/*
> > @@ -101,7 +89,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, =
struct kvm_memory_slot *slot,
> >  	index =3D kvm_gmem_get_index(slot, gfn);
> >  	index =3D ALIGN_DOWN(index, folio_nr_pages(folio));
> > =20
> > -	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
> > +	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
> > +				     folio_file_pfn(folio, index),
> > +				     folio_order(folio));
>=20
> [Severity: Medium]
> When folding this helper, did we lose the GFN alignment for huge folios?

Ugh, I totally missed that, obviously.  Aligning the index in the caller us=
ing
a gfn, and then subtly computing a new gfn is just mean.  I'll fix this by
squashing in "Align the gfn as well as the pfn when "preparing" a folio"

> In the old __kvm_gmem_prepare_folio() helper, the gfn was recalculated fr=
om
> the aligned index:
>=20
> 	gfn_t gfn =3D slot->base_gfn + index - slot->gmem.pgoff;
>=20
> By passing the original, unaligned faulting gfn to kvm_arch_gmem_prepare(=
)
> alongside the aligned base PFN from folio_file_pfn(), does this create a
> mismatch between the unaligned GPA and the aligned base PFN for huge foli=
os?
>=20
> While guest_memfd currently restricts allocations to order-0 folios, this=
 would
> pass an offset GPA with a base PFN to the architecture hooks once huge fo=
lios
> are supported, violating the API contract and potentially corrupting the =
guest
> mapping (e.g., if a backend like SEV-SNP falls back to 4K mappings for a =
huge
> folio).
>=20
> > +#else
> > +	return 0;
> > +#endif
> >  }
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.19=
88414-1-seanjc@google.com?part=3D15
