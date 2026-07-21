Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20305320CD1
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651978; cv=none; b=I5drSt9hckJNHj0zIzJCKuy6xdUq5hYIxud8MuuSnSdTARrZdekViwk6o4DVGml5WlAdpQE0D7bZhtkTotFS8YmCJ/1FGvy8wytom+K8hZHNbqDxmlshvXrOqW+x9Z+9XfYQK8wY1et6KS3tz2ypL+drRcDDA2wTnUdL9L36xXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651978; c=relaxed/simple;
	bh=u79rtOZuHU9fhHI1eJojsAnaCP3KVVdtgAkn5GMAHPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OpV+1jeG1nqsD+pFM12ZWi8NkIZBG32C2Qgd+YNNiX1v+3kjCcahnCXPDc0FsILwl7xUfb15drODxlti+xSJPeq3XZ8BFxaeb4weBG876mNZGk/cNkOsSDgZrZ8kfTeWOIAvJczSNoOM3hhXEG814210pkx1Gz4uX/RbLvjL9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpzcAmXA; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpzcAmXA"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84870e7f498so12014256b3a.3
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784651976; x=1785256776; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KDWEMLe5spxz07k0KAAgejR73JFog/eLghsGR6BCdA=;
        b=LpzcAmXAX7Ymg8qEaoZt9KGLfaCmeQ2Zplh0js49SItPviM36fdcZmnPOceafmVGfK
         PJ/7HBeynPB92DSPhtCrxFOguRoXUQQ44ni2imNeeHaLGfDxwuB2/fwdJO++OlvF1vy4
         zuF/ikRxqmntfVD5mLR96JQJFvv2Q3QmlmTMj1CaP38lQJBlLZFpdz9jvFZMGf3wM251
         UGereWilDjtjHcFAFI5cT6vehLgvxp+OHaKCsqh0fuFsxc1v+epYqfaPCo3UxMGK80IB
         gE+Vaf81qJXu4y2HsuJY3/aSJ8K5vukusWIEMnZW/vM35HvE0Yjre7KXCYDP1X2OXxEa
         MSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651976; x=1785256776;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1KDWEMLe5spxz07k0KAAgejR73JFog/eLghsGR6BCdA=;
        b=JZcSdYnmoqmEGj9jxYJHd739Dxg8OtrOJBMCs9X4GeNUW92O1CoIv6Apzn8Pw1rYpc
         6Ud26AuoNkAubzcSLM1EZvMlCwIVtuq9EFoKWiMQtQy8LrMGPrNW8S1RRxstxjpAMHio
         q08sTGmGjANv3QcLkulmIF0bZbyYyuAlh8+9CR1E4v2TYc6v5L75eGtKuCuyG47D64LK
         68KPkMm0aEn187wgI3t9ConvXBlFozK3+GIvrZShyGYMznBcoKim37SI/ja+MRRbi5dz
         Pg8oozf0SWaAdM8jDeqJoCC5jevcuYaF/kKBVNp2PCSdrN+MPy76kVXPwk9nyntPGcyj
         gyag==
X-Forwarded-Encrypted: i=1; AHgh+RpHdQlUYbREkmksjo+9uEigtSCDbqziCwWq2IBXXSqW0QOMPYlBXG5EAOsmG3FfbyjWCIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ep6cAWUZlJcL8NUhG8tuZk3BPCxZ6gUqLZpLKwvw1wMoVfeD
	rWbp802KOTVA/u4rqkH/DCqZjE/Oxm0Zenfp7HdW6XR7MgM5y14yHo0OVs1lf7IfJD+YQofiu5Q
	bnsbADA==
X-Received: from pfbbj7.prod.google.com ([2002:a05:6a00:3187:b0:847:8e58:df6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f89:b0:848:584f:7e41
 with SMTP id d2e1a72fcca58-84c2959418cmr19412972b3a.78.1784651975980; Tue, 21
 Jul 2026 09:39:35 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:39:35 -0700
In-Reply-To: <CAEvNRgEuTG3k_iKFMLtqGXXQ5tW6X6+8BsCB=Z1WGgqOcPV5Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-5-seanjc@google.com>
 <CAEvNRgEuTG3k_iKFMLtqGXXQ5tW6X6+8BsCB=Z1WGgqOcPV5Vg@mail.gmail.com>
Message-ID: <al-gx47Cc33uCJra@google.com>
Subject: Re: [PATCH v5 4/7] KVM: guest_memfd: Fold __kvm_gmem_prepare_folio()
 into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 14, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> >
> > [...snip...]
> >
> > @@ -97,11 +85,15 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	 * The order will be passed when creating the guest_memfd, and
> >  	 * checked when creating memslots.
> >  	 */
> > -	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> > +	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> > +	gfn = ALIGN_DOWN(gfn, folio_nr_pages(folio));
> >  	index = kvm_gmem_get_index(slot, gfn);
> > -	index = ALIGN_DOWN(index, folio_nr_pages(folio));
> >
> > -	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
> > +	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
> 
> Could this just be folio_pfn(folio) since this function is
> kvm_gmem_prepare_folio() and guest_memfd will always try to prepare the
> entire folio?

No?  Maybe?  For this patch, I'm just trying to shuffle code araound.  Even for
this series, I'd prefer not to make any more semantic changes than are needed to
get to a sane state, and to prepare for in-place conversion.  If there's a need
and/or a good reason to use folio_pfn(), by all means, send a patch.
