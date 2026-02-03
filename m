Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47A495E5
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149859; cv=none; b=Jz9+nDbOaN4dinM5Y9ykgfA1/QlXW7N56NzMmVPuVTX845MxRwHS5Xg7qkYmyPGOgEmR6RaXC31J2x4gOULVLLG9IOF8Q+FOMO8T5CW2VUylx52OiIpNTZgZsZasUeRJWmmkX/TZVypCtxleIq+z6n4zrxwIaSi5nhFnv9FTu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149859; c=relaxed/simple;
	bh=FkCJM6ueNs7FqOzKfJS3PcbT/ZLZ/g8y/UzMew7y1Rw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+RNgdS7mXam/sMU5TTzKolNbTzzWNbBwyCBDgEr9C6rsoV+ufp5Jyi1xFl2Yz9y2TK8+jxsXV5NnUdvw49iYr0qSyKCxfHSn5wspxtemCC9YSERlEZOUC7By7jDDHBH3V1U8JO/fYBg72929yzLXhF7c0oVLDprn4ubnSALHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhiDbNLl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhiDbNLl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso10604281a91.3
        for <kvm@vger.kernel.org>; Tue, 03 Feb 2026 12:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770149856; x=1770754656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4mt8h2gjWj7DXhBKRKL7wFsuvXhNdmeJu1raWnSkac=;
        b=AhiDbNLlFBlOxpgJR7N7hFLM0DyLG6mL13+8KlLR2AenJ/JyWLoAtIm/o6IEIIVR9z
         JJbHOnjezlP06qXlmaOsG+HsyEbnqKN+n3DwIFSV2XpO0K8v1gRo0+zwxFfFT3Ui2uTj
         0dfPyOYQ0Y6AeTgh+IC739kycY87NY917cgE8dUK7Yv7+mBaTLbdAaeo8R5CT8z60D4Q
         Vjvrev/D6XkAJHSbuVtRvphQ6EEXPZeaj4sJrA7cpqseNK417lEWPGuEVPp4zIoO8AYR
         wwydZ4rWWjwdRBBTLEWuh4d/hKOPdQ/pSSvPnq+h2vIqSXoJ3vymQ0Q4rIT3Ozup9Mht
         gbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770149856; x=1770754656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4mt8h2gjWj7DXhBKRKL7wFsuvXhNdmeJu1raWnSkac=;
        b=cihdjvkAaOpigIkDPySfGgGP+CsLVJwx+Rwem35YPOib+Ly3mOQ3yV/PMeQbz/Jav5
         HtORykl2i9mzYKAbDoa8Pi1haAibSye7XPOnyLCUNqNQHGzUV3uVQFJEYFtB3U+0/2xy
         6095hV+ELSQVHn7gNOUtUewlkcoBO8LPluLbdna6v0I+TcsC29U/YkCOu0TjuqZKt6WJ
         5zJC/5KkTD1zWBSEk5lpHbzZSppo7hoFqseR78DB5aineicsUkYO19mYsN5iF1LVFbje
         W21Enqy24lkHgAEtzZQIm9Twq620W2ye07WZe7DBxiugBWkw6hzYj+MdVvReCTac966o
         /jMA==
X-Forwarded-Encrypted: i=1; AJvYcCVrE0wZFvioebq2Vdmwne3+zqqCqoIBUFOEZZC7UZqA92gPH4uQHfKGekD1MVPcORdh71s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ULPVEcyoq7IouFFzkSm68no0BB5ainmleD66Vq7JQyJkVG4U
	dNycSgC3A79XFCKySx1eyRdjUoQ+kh5wLc4Da3jpL+yfBW4urSINBSanX9G2tmSWb1BTlCompnK
	d0jYgqg==
X-Received: from pjqf2.prod.google.com ([2002:a17:90a:a782:b0:351:b6a:a36b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b45:b0:352:ccae:fe65
 with SMTP id 98e67ed59e1d1-354870ab6aamr390303a91.4.1770149856475; Tue, 03
 Feb 2026 12:17:36 -0800 (PST)
Date: Tue, 3 Feb 2026 12:17:34 -0800
In-Reply-To: <4fae16cdcc368d33f128c3a79c788b905b83ffe7.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129011517.3545883-1-seanjc@google.com> <20260129011517.3545883-21-seanjc@google.com>
 <4fae16cdcc368d33f128c3a79c788b905b83ffe7.camel@intel.com>
Message-ID: <aYJX3usu7FzPrFWa@google.com>
Subject: Re: [RFC PATCH v5 20/45] KVM: x86/mmu: Allocate/free S-EPT pages
 using tdx_{alloc,free}_control_page()
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "sagis@google.com" <sagis@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 03, 2026, Kai Huang wrote:
> On Wed, 2026-01-28 at 17:14 -0800, Sean Christopherson wrote:
> >  	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
> >  				 u64 mirror_spte);
> > -
> > -	/* Update external page tables for page table about to be freed. */
> >  	void (*reclaim_external_sp)(struct kvm *kvm, gfn_t gfn,
> >  				    struct kvm_mmu_page *sp);
> > -
> > -	/* Update external page table from spte getting removed, and flush TLB. */
> 
> The above two comments are still useful to me.
> 
> Not sure why do you want to remove them, especially in _this_ patch?

My intent was to replace the individual comments with a more generic comment for
all of the "external" hooks.  For things like "and flush TLB", IMO those comments
belong at the call sites, not at this point.  E.g. _KVM_ doesn't require a TLB
flush in all cases.  And so for the definition of the hooks, I would prefer a more
generic comment, so that if there are details that matter to the usage, they are
documented there.

> >  	void (*remove_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
> >  				     u64 mirror_spte);
> >  
> > +
> 
> Unintentional change?

Ya.

> 
> >  	bool (*has_wbinvd_exit)(void);
> >  
> >  	u64 (*get_l2_tsc_offset)(struct kvm_vcpu *vcpu);
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 3911ac9bddfd..9b5a6861e2a4 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -6690,11 +6690,13 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
> >  	vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
> >  	vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
> >  
> > -	vcpu->arch.mmu_shadow_page_cache.init_value =
> > -		SHADOW_NONPRESENT_VALUE;
> > +	vcpu->arch.mmu_shadow_page_cache.init_value = SHADOW_NONPRESENT_VALUE;
> >  	if (!vcpu->arch.mmu_shadow_page_cache.init_value)
> >  		vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
> 
> Ditto.  Not sure this adjustment is intentional?

Heh, I'm pretty sure it was intentional, but yeah, doesn't belong here.
