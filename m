Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC642E007
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613455; cv=pass; b=XBWpbIUp61sOesRIbtLry+5pzZPd6ZoaI8zEAxOon+7TtwiRk/MPTnhMvbCRzc0Z4URmhbeNOlWbLwUfjG/XaqAwU2zFg40gGbR0wDgcOKZPG30DTqSyMgZygTnvzNYDRNbBc4Uqqta8NeOsedFnaBqggRddxhMrGq+I3eKLwrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613455; c=relaxed/simple;
	bh=wv3vHTCWuihF/zgcXlJsLynv1NiR9V/s2dlAW+MVfR4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5vf6PdnKSBmAD3REUJb9QtP+Arv6V2jkLuaYpv1jFNXhPpCfGORv5oIZeWBaCq1nDJn+6LJRJuanB3rkhcCLsm/0PODAD0kzoYTaWcgA7z4QW3/Sbkc1PPQyhGbLDS9niOLJiP29PilQTxbLMdi4wAEPaHwwSKsUaqejsg9zYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JP8QqHTs; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JP8QqHTs"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c96c92c0980so512a12.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 09:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783613452; cv=none;
        d=google.com; s=arc-20260327;
        b=X0HTURDo8jHDagWrJ7S6uvy7YwGD3fiblWqlfhkt3D/cUvI+bZsRLfRbpFH9/lEL90
         SeG0c2OQqMVqGpx2BwDNOkJgF5cOAaSx61RkBxoq/0JjKuxUnXYH5BUryNsZhDaV61Ke
         tRRywfOS+xO9bLYLs5uWAC71R8m0MJZ2T0RK9vZTBNxwYbOXlJn6Iw/5Mz08p5JPhpNj
         em4JNUyNRza8yYXsgAsIUL891/hxBTX3zFeqNsQqUqHN82pAPBUg2bohzIP7OIyZzXqi
         QAEkAT5yvIz7GqkngBj863WaiumGy6zVHmJOKNjmPD7uYIRmXUbpd1F7tOF0b056IHOl
         Ovog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dRgPKkc6EWAkS4dcj/kLS195vv0DhLEmOtUeDj6PlGI=;
        fh=AzyHLOCn/pJQNjl0QkZxqYRGK8d2WsiPkPxK5bKmCbY=;
        b=RQQKS+pFfpC5BgDSkUgBwMItL4/oMGA7JmYw7fZ15sFNHBFl9GTzXMfQX3SpAc+q+i
         svm6cBwXAUQgM8xGUKbG+LTp/uGhx3oENe37MbXEu2A1lcZ9clgv7lZ2j47Y2EtssLqR
         cSM99GCrghlSjFOFoIrdd9rlsB17t1wOjIuBSogS+us4nGWpSeXNljhReMYpEjCW/x1C
         ZIj+s2f4ug3rHYB4vkgDGlFvTvEDiJ0M7Bj7QDVaXwdrnyxnANCPDFrxFb7Hr5ulZX/X
         HHwYNQL/mFk/BOqEIu3ZaGVkcgu2qD39yAPxLrgJ4SBcN/2fQCWrdk5arzgv4AfqYCn9
         G40Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783613452; x=1784218252; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRgPKkc6EWAkS4dcj/kLS195vv0DhLEmOtUeDj6PlGI=;
        b=JP8QqHTs3VxKYHn9BwGAcPvvJGMBqcINtLiRaXjleE7QqXrPI2kP0So/ENNXBo9lEu
         eC7FLqH7GfHWmPx+Nf/D1WPDKb4GeHOHRo9QgPtBxucbxIJthVvnUR7n1/W2zcafiPnz
         T77GxNsAqjkFzmVmUevi8bX3gMIGfKTgGSqs4egw4m2CCbtvoTtw2AXTlb3Uy8mVAPrT
         Nh3cb2bBQgrSMp0mQ5zfoWoyG+69CrwXavH+UowAZvrPiJJjCn4QVUPtkkswBZy1D+Qr
         D1TR/bnlyrHhm2+R9LjXti/BYV8AEDqB5+UhyuQkSUGsB529q8edhlDnwYUD5P1blqf8
         E8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613452; x=1784218252;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRgPKkc6EWAkS4dcj/kLS195vv0DhLEmOtUeDj6PlGI=;
        b=mGxEudyuRtJ4rQI3r9vJPnp/KwqHVHMpXzGF6dQtDZYwF+qM7Fkaikyd1URplSnQoF
         4Wx66JjSJZIINphhW9zdbzd+yxxbi7hPJvqXGmca0DvlmVtRlmAWbChj32eNnEZRUVfF
         Zm/AeuN4BlOJr5udf/uPkPDlU6pURT1bBFu909bhAXemBTcYvm+YW1jmeLPApLejek2c
         9aGbwbaMDWppU0uEtdbPNEUKFCy8bWnTBMMeE8ZMYPZzNsk8o7OJXs8IfmeZjNPVaOMQ
         ZYF68dFxBDtB8BiYoSvVSPdtwCuh91B9JkH+gxdpSE/w538XuRJMs3pTpOqT8R98af+C
         XJhg==
X-Forwarded-Encrypted: i=1; AHgh+RpMHJZbezEAb/8eORxTF9SOw9ZY0fgc59qtU038SwqIIUTTxbomT4ofwatrahB+S04unKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUZzFM03j6hWL1SP/8B6pxEWUETTreIm4p+un2mXZGDaz7bEo
	sRY+GTEoSs5RCNeNVPY7z+4Xf2POMTCdk5fe31DIgOyf8XkhhCNAykpRlgBtjeFd0n4kticfQAV
	Yphl/Q5KR9tUpevMhXlLQS+L181mAWT4k/iY3YjUT
X-Gm-Gg: AfdE7cklKE+7q5axOsRlXrGTn6NPdkOGUr0dhmkxW+i6rUvKnEkAuzPjquiWjoYyy74
	NGPJnKe7ohgDos72b/xFBIs7QUgDpCiROFNQkBjqpeV2ueJxjaDVZ2HqOwCfNejo3CHgckBcpkf
	6ZKFzT/JruXHkoyRd9P069FsKgB3Hrf6+2qpIDl+ppsCOSpioVC4+nq+3TWUxk3RRNpsvTHP+WO
	9pntT2QDBnFUbuyeNuu8xZoHaWon/k/juc4zrZfKznN3F+NDrMew4oHG64Dz6mI20hY5l3Kr5bB
	AjsbMKkfRGyYZl2YJ6+N8Ru8XgXHlR7pUzU0Fu3skbntmVlzQmYjo1JXbSyUmWgiy+Njkg==
X-Received: by 2002:a05:6a20:430e:b0:3b3:2703:110 with SMTP id
 adf61e73a8af0-3c0bc8aa628mr10014470637.4.1783613451372; Thu, 09 Jul 2026
 09:10:51 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 09:10:50 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 09:10:50 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ak-mgRaezT7gSJ1P@google.com>
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-11-seanjc@google.com>
 <CAEvNRgEFvh8T=v9jzxyYcc3NQzS2-uJctNuZix+mNQO8gwc-RQ@mail.gmail.com>
 <ak7rOdtcYyZ4zpN7@google.com> <ak-mgRaezT7gSJ1P@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 09:10:50 -0700
X-Gm-Features: AVVi8Ce07ifYOUcVsvCnOAllnWsqT2wEUeMxIOOv5G6X8GlsmCwR68ZK9ajESXk
Message-ID: <CAEvNRgGyPU+x75CR2eL5KqiujZoWSU3zf_NFSJa_2LdbUTTJ-w@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jul 08, 2026, Sean Christopherson wrote:
>> On Wed, Jul 08, 2026, Ackerley Tng wrote:
>> > Sean Christopherson <seanjc@google.com> writes:
>> >
>> > >
>> > > [...snip...]
>> > >
>> > > @@ -1902,6 +1905,7 @@ struct kvm_x86_ops {
>> > >  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>> > >  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>> > >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> > > +	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>> > >  	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
>> > >  #endif
>> >
>> > I suggested CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY before looking at
>> > this patch.
>> >
>> > Considering this, it seems like gmem_invalidate_range is a true
>> > invalidation request and .gmem_reclaim_memory is too late for
>> > invalidation as you explained in the commit message of the renaming
>> > patch.
>> >
>> > Perhaps the new .gmem_invalidate_range should take over
>> > CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE, and .gmem_reclaim_memory should
>> > use a new CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY?
>> >
>> > Are they both invalidations in your opinion?
>>
>> No, definitely not, I just didn't want to add another Kconfig.  And I still don't,
>> but I agree that lumping .gmem_reclaim_memory() into GMEM_INVALIDATE doesn't work,
>> because the behavior of sev_gmem_reclaim_memory() and sev_gmem_invalidate_range()
>> are completely unrelated.
>>
>> > If we're clumping SNP configs together,
>> > CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE is also only enabled by SNP...
>>
>> Yeah, but while I don't like a Kconfig explosion, I don't really want to end up
>> with CONFIG_HAVE_KVM_ARCH_GMEM_SNP_HOOKS either.
>>
>> Oh, wait, isn't CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE going away?  I was going to say
>> we could bundle .prepare() and .reclaim() together, because conceptually they are
>> two bookends for updating out-of-band metadata, but that doesn't make a whole lot
>> of sense if .prepare() is going to disappear.

Notes from guest_memfd biweekly today:

1. .gmem_prepare() is not going away! Preparation tracking within
   guest_memfd already went away.

2. Prepare/reclaim can be combined into a single function, taking pfn,
   size (or order, order is preferred since it also communicates the
   order at which to prepare/reclaim) and whether guest_memfd needs the
   pfn to become private or shared.

3. Having prepare/reclaim take private/shared also removes leaking some
   arch-specific details into guest_memfd, like "why only
   .gmem_prepare() on conversion to private?"

>
> For consistency with .gmem_prepare(), what about going with .gmem_reclaim() instead
> of .gmem_reclaim_memory()?  E.g.
>
> #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> static void kvm_gmem_free_folio(struct folio *folio)
> {
> 	struct page *page = folio_page(folio, 0);
> 	kvm_pfn_t pfn = page_to_pfn(page);
> 	int order = folio_order(folio);
>
> 	kvm_arch_gmem_reclaim(pfn, pfn + (1ul << order));
> }
> #endif
