Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CB3DAAB5
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916930; cv=none; b=n67EeR/np0flTAjjRbyDLzAGRKbdBYvUiVa826it5C6UONGq1Pjg2/NbGybYl2zS4JnAZH2YeCQCf3E3pHG5PQyB5jbD5Dae1pw2GkPk/2imJ5FNOnJtQu8A9XMnoYHgua1eapK/7BhGrxfsc1EauSzI1kzT8ZAbHLkvcNbnPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916930; c=relaxed/simple;
	bh=Jbkq6IUB3XRiIRYESGpIET3fntf8Ju1FestoHD4q2uQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o5v/4heSAU/UxD80kmd66yZgHnMGhuVUXIicioc6lspk80zhbJJmwZJMdMJBkTdhNT5SMGaQjWPuw8BR9ZHt3mI5A1sQNcZhGSLueLjmv6Y5pPVVe+tXnP9M16s5v7wh77MMp0XkLsvOeVedxo9hmQazgsHaZX2FoBDEaNlq918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bI+kOdN9; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bI+kOdN9"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc6dd43737so13304905ad.2
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784916928; x=1785521728; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X27LjpKO4ftZNWNG1RaZsHwa9Yt3DydhUzCU4IEwxJ4=;
        b=bI+kOdN9Rj6GMF9RylEwYemKYoYCEw9ouei8CwwCCoynGS/5BAyV7AEp7OMIFh55mY
         rEvdRrf1iPb/xQ9+n/YX3IOSSfh3R3fnVBviJ5wqkarmrQslb963jWcJ9/iCkfyDcFFx
         /ELjIOaTicY67bvKDJm8gwWmdU/cez8gImhenpYwxNpaVa0u8aLbxpCni9/mhlJMqbEY
         AsBrBZq6J0uYXoyFfIi6Kkv5fqFQgr0JvQtT8oJmhbuD7CmiqNRZPeTbyLj2kO59YQLs
         /GQwdSknBHdeawu33VP3LTzbYbeK2NFk9bLdhRkKOfDQ556NSgUn6mCFaSOpS+paPkg6
         E81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784916928; x=1785521728;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X27LjpKO4ftZNWNG1RaZsHwa9Yt3DydhUzCU4IEwxJ4=;
        b=SBSOLovqLgMxG2vACUXw7jQaUNs7q+w7b3FItjl5NfizOUVdByyT5XqCg/+RPi49Vl
         W4FsXXXCKH5ru2YfoMVLB1AkJl8zphIsWOY2vhkVD7PzOH7ZkVz0eTmpPFSLyI4JxZFU
         OUYpyy4uFZVnGvv8FnktDRqJOJwb7evirxuw5inyxf2P0u+JdKZCSIOrdkY1RN0x3oRc
         HhVUMyoWjZJXdBpX3S/acBisPZxBsrq0LwifnsPbvIdPrMW8ZbjPoD0t4Ghkto9cPVRQ
         PM8T39djKpB/KlIYTZPF+6cTX6ojfWoolEq5ULcXJwn2g+RDECsyvQEwfSwqYTN8y0xM
         a8MQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAGXt1CJUGHlOOVEfcZ2E9Z8bIBdcrRtxndadVpmLKrDCfQNDfjm8x3+49bBYgRHyU7D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDHO0aFZHOG0lhoH+g+SydzTRTgZXAX9MsOVGNzHhEIHxVPwM
	oHYRcz8CnmocQiy5BSA5TJO2NF7SlHAcgk3amuGNomtSiGRzm0t8VBa+rwNmgTpa3jiY/CSkSwg
	Y7xGTVw==
X-Received: from plhn12.prod.google.com ([2002:a17:903:110c:b0:2cc:79e3:95e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e885:b0:2cc:f5aa:9513
 with SMTP id d9443c01a7336-2cfa730e9a1mr88122085ad.10.1784916928061; Fri, 24
 Jul 2026 11:15:28 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:15:27 -0700
In-Reply-To: <CAEvNRgGhzjA07-0jwJNLbg6tBN9EJYXpSeGJsfBvs8Hc1Sv3GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
 <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com> <al_BAjCNRQUvuX2c@google.com>
 <amAoijqis2Gn/K2Z@yzhao56-desk.sh.intel.com> <amJhzgyQMVNVD1S3@google.com>
 <amLLoRkCCaK1EHuM@yzhao56-desk.sh.intel.com> <CAEvNRgGhzjA07-0jwJNLbg6tBN9EJYXpSeGJsfBvs8Hc1Sv3GA@mail.gmail.com>
Message-ID: <amOrvxQQd5D17F9-@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Roth <michael.roth@amd.com>, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 24, 2026, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Thu, Jul 23, 2026 at 11:47:42AM -0700, Sean Christopherson wrote:
> >> On Wed, Jul 22, 2026, Yan Zhao wrote:
> >> > On Tue, Jul 21, 2026 at 11:57:06AM -0700, Sean Christopherson wrote:
> >> > > > Asking this also because there is a .gmem_convert() for TDX huge pages [1].
> >> > > > In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
> >> > > > kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
> >> > > > convert may not be shared after the punch hole. Is it acceptable?
> >> > > > (To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).
> >> > >
> >> > > Ya, these concerns got raised by others.  pKVM on arm64 in particular wants to
> >> > > hook reclaim but not conversion.  The plan is to keep the reclaim and end up with
> >> > > this implementation for x86:
> >> > >
> >> > > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> >> > > 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >> > > 				kvm_pfn_t nr_pages, int max_order)
> >> > > 	{
> >> > > 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
> >> > > 	}
> >> > > 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> >> > > 				bool to_private)
> >> > > 	{
> >> > > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> >> > > 		return 0;
> >> > > 	}
> >> > For TDX huge pages, if we want to trigger private huge page splitting before
> >> > converting to shared, should we invoke the hooks like this?
> >> >
> >> > __kvm_gmem_set_attributes(to shared)
> >> > 	|->kvm_arch_gmem_make_shared
> >> > 		|->kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> >> >
> >> > But TDX needs kvm pointer, and splitting pages may fail.
> >>
> >> Ya, but those are very solvable problems.  They just don't need to be addressed
> >> today, because SNP is the only user of the conversion APIs.
> > Ok. I'm ok with the change for today's usages. My concern is regarding future
> > TDX huge page support, as I am currently preparing TDX huge page v4. :)
> >
> > Sorry for the confusion -- I should have stated my intention more clearly.
> >
> > Previously, for TDX huge pages, you suggested introducing .gmem_convert() to
> > trigger splitting before zapping S-EPT.
> > With this new direction, should TDX huge pages instead leverage the
> > .gmem_make_shared() op for that purpose?
> >
> > If so, should we introduce a CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP guard around the
> > .gmem_make_shared() invocation to serve TDX's splitting purpose, in order to
> > keep the two use cases (SNP and TDX) clearly separated?
> >
> 
> Another thing we need to figure out is the ordering... You mentioned
> that the S-EPT splitting can fail, and I remember you were suggesting
> that we merge the S-EPTs back on error, something like that?
> 
> We'd have to figure out either a point-of-no-return, or some rollback
> mechanism anyway, so that kind of depends on conversions and the
> guest_memfd hugepage series. Probably good to defer this discussion to
> later, when we have more certainty of how it looks like. :)

+1.  Even with my series, I'm getting a wee bit too far into trying to predict
the future.
