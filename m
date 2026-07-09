Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756E329E6A
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604868; cv=none; b=SetLHiL/Bv/ZLpSF0Z0/hlhYPdrSBAkN0ZhnYsxHeVHIDQymrarls5YjyRA0iJRggsp4HaBK1svRD1r+qiAAk25Dy16TWPkcWTCFrsPfIp7rkuw18LThFQ3+cbSXGAxenrreRWMGvC5CPCeqRSyg92KKHIxHF7KR6KOU1zDupXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604868; c=relaxed/simple;
	bh=XoH5mVpmWCbnjzT5WUIHUJi/Q5/RUTdcN3spkq+i7v4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p5ocyG55Ua2PgcXcoaE7M4moLNlZf8+es9Orehzd4NiUKrpRfHvcjkC5a5qZCQ43/YmoF5AoK1ujJSJyPH6Ee3OzjEH4W+CyZt0U/ygLaPOVcFb5eN5LDD/bMcWxPIjLXTfX+1jiiWVi9+ocpSH25/yhiaEHMLkPx63DTJ4KKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RgbPT9+J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgbPT9+J"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cae455cf6dso30550115ad.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783604867; x=1784209667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DC960oAiUla/XOLJDmjhiObLoRrA64cIRimX+CJcXns=;
        b=RgbPT9+JoHX5e6e96EoukjDPPDBPerjaF2oacYrcJpbVACrV1rYfNADnmFPcYCDzt5
         sxBbIeNzItz4Q+W2TMRb4B8TznvXYBHaoHyLjSqE6zb/j7JEMPC8Sol6AUCUtduoRGu4
         QlqosiduPzDorDT4NOtbuuM0V554wl6ADAb8O00DRtGF9jeeYZsOairxDfSEdIi5YICU
         e64bJdtvjI6enhXxvysHyi0MDnY1nbEfGQiMBUtTzCvt6V1ynGOV/DW7+UZxrm46Lmy1
         qNAM9a5APniFCNkGPRXYuf2b/qNv8WIveEOHhGZGOL0tAQvTORg0/egfE/GH9GB/GPuS
         JBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604867; x=1784209667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DC960oAiUla/XOLJDmjhiObLoRrA64cIRimX+CJcXns=;
        b=ErOnqV79tzRYPkroZgIyXm1vaZCyP2RIH/pj2BTACxv3Iy9SMYptrd8NXRdOc25IDI
         pOLnCAHH/D4pXC2QasH9a8axavMvp4mk7e7bOj0ZO4y4svIK2wKzwtFCxEmSlZLvU3nZ
         Cdx8ceZYNiqPo2GvS9ikVC9ExX3Xj7zqIMrSlQ4dtncKgZg6cMTjbosPBYyYB+SszsYx
         TlWbfdtf98TH1nt2lohXNiGEUdIJkCFi/TR5mkQs2PWIo8LWlyZEtBjo+IJ/mDg2IjeF
         ZdFQfcQfVRuSJtlHuSfzsQSyghRF14o9MZPip+s5XW/tqW+THzOv4WfUSNXzMCctWOLW
         IcrA==
X-Forwarded-Encrypted: i=1; AHgh+RoBMiPL9x6KOybEhsKMPzgOQgaQylFrMfFkr9ud+l695qnkAUfXYH5C7sV0og19Hj6x9cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+Pcf1rSmyr4UmBeH11Sa5mkogq4asIAB7NS3ovCrcx3jhk3c
	nR2cfLt+vxzK1vWfCQ7+2vQ2Kfs8zEZZxrmlH79JIFIDAPWLNBawu0WqxYl0YHpHcgrYtgLNbjs
	WZAxjJg==
X-Received: from plfp17.prod.google.com ([2002:a17:902:e751:b0:2bc:ac01:8af8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d487:b0:2cc:d807:369c
 with SMTP id d9443c01a7336-2ccea3e6988mr80125385ad.45.1783604866442; Thu, 09
 Jul 2026 06:47:46 -0700 (PDT)
Date: Thu, 9 Jul 2026 06:47:45 -0700
In-Reply-To: <ak7rOdtcYyZ4zpN7@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-11-seanjc@google.com>
 <CAEvNRgEFvh8T=v9jzxyYcc3NQzS2-uJctNuZix+mNQO8gwc-RQ@mail.gmail.com> <ak7rOdtcYyZ4zpN7@google.com>
Message-ID: <ak-mgRaezT7gSJ1P@google.com>
Subject: Re: [PATCH v3 10/12] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 08, 2026, Sean Christopherson wrote:
> On Wed, Jul 08, 2026, Ackerley Tng wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > 
> > >
> > > [...snip...]
> > >
> > > @@ -1902,6 +1905,7 @@ struct kvm_x86_ops {
> > >  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> > >  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> > >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > > +	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
> > >  	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
> > >  #endif
> > 
> > I suggested CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY before looking at
> > this patch.
> > 
> > Considering this, it seems like gmem_invalidate_range is a true
> > invalidation request and .gmem_reclaim_memory is too late for
> > invalidation as you explained in the commit message of the renaming
> > patch.
> > 
> > Perhaps the new .gmem_invalidate_range should take over
> > CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE, and .gmem_reclaim_memory should
> > use a new CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY?
> > 
> > Are they both invalidations in your opinion?
> 
> No, definitely not, I just didn't want to add another Kconfig.  And I still don't,
> but I agree that lumping .gmem_reclaim_memory() into GMEM_INVALIDATE doesn't work,
> because the behavior of sev_gmem_reclaim_memory() and sev_gmem_invalidate_range()
> are completely unrelated.
> 
> > If we're clumping SNP configs together,
> > CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE is also only enabled by SNP...
> 
> Yeah, but while I don't like a Kconfig explosion, I don't really want to end up
> with CONFIG_HAVE_KVM_ARCH_GMEM_SNP_HOOKS either.
> 
> Oh, wait, isn't CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE going away?  I was going to say
> we could bundle .prepare() and .reclaim() together, because conceptually they are
> two bookends for updating out-of-band metadata, but that doesn't make a whole lot
> of sense if .prepare() is going to disappear.

For consistency with .gmem_prepare(), what about going with .gmem_reclaim() instead
of .gmem_reclaim_memory()?  E.g.

#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
static void kvm_gmem_free_folio(struct folio *folio)
{
	struct page *page = folio_page(folio, 0);
	kvm_pfn_t pfn = page_to_pfn(page);
	int order = folio_order(folio);

	kvm_arch_gmem_reclaim(pfn, pfn + (1ul << order));
}
#endif
