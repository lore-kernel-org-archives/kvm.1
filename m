Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434D329E44
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890074; cv=none; b=F0090YrabOnGSOzHW47DrQ8nisiVB3jo11zAeRTPC2XWmhQcoHjO/rfQocmotV5bPXnBwu15RNnrwydRO6a7++6y8MsB7i3i9dwxG8m+O24nEkkutAA9HzvF0yU32AiTfFf/MyGEsbTuR5+S0snM9RXtpGEFc08BHdsHAo5/8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890074; c=relaxed/simple;
	bh=pwSDZnuvS1XtjUG7bpT846TmDeZH4c/r+oypjJGBte8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKjIOHAMdGXEbdHA/NJQkKElC715RXhqLjvJAoVR8y/dHs7uEIFGsiNaKQCnyBd9+H3aOkvthP7lajA6VFWVyjgjCy3nBJgmURGGL6l7HVEm1Hh0wUDDe7U+5BeWL3EwkIqiFRJi5vmVMnucmQXBiJGtcCmcP/fVTmx1fcppmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQSLU2Iy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQSLU2Iy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso7327721a91.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776890071; x=1777494871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6cKYb2nrrVr10xS0LVArs9DazD2S5XwOnl2A2OaOrk=;
        b=BQSLU2IyxjnhDdDge3AOzlrhzrjkOkORlwOKY/i0QoPlRHzodgSksUa3JXardQMfxY
         EfQMHw7WdPQ/BMkohRZXiro3dGeQW6eYpvFVXraBBMEMK7xdEyNlaRHTdraJAjqW2dBR
         y6N5x8Q7Y+Fh9obuN5dKu3G/WJOEAqjwu0bXvxRGCIONDYxbU5/fnC0tbRpG8XPmtzgj
         OJUaeL0q0WKuE15Uz/4eZ3pqoK4O7qMrRq3UFdD92LSNRojFqzysoJdCLTeCr5XTrP1y
         MygCdsUk06zhFupEhyVKuPbsGDhKs/jT0UBqsHRTxFo2lFootts9cP47784jO4KaWLTb
         Gnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776890071; x=1777494871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6cKYb2nrrVr10xS0LVArs9DazD2S5XwOnl2A2OaOrk=;
        b=Z45jFSrJaUTxoEyco50RhyKK6/vpDXJvAzN7eUQ5AjoMLXlvUvrJP+PoeAFl9T1Lnx
         lKJ89d5St4NIdfVNhsVVgfVaWx97BfFepMzbxrxpyCxnB8oT9V/iWjGUIHneB9jAG3JJ
         5SGFBVxexHHhzV1FSrldwqG7UQhdA9RSy1pg2kBGsLVvtkdVF93w8kGt59A+I8ZKTg4M
         dgNtwtT/vCrE1e1zH+R158bw7Jh99MIQwzZnvr0Sl6hFN/dH9DRbeZAVrs394V4bsbmI
         ao+9yHTXk3nEINXr5OtfTEQmMjSSr0Ar6ogAoUfO16/0/sL9RZln9dSbBKqGmt1Vtw0W
         zlug==
X-Forwarded-Encrypted: i=1; AFNElJ958NrvJt/PxTauyB0wQ/g/QIzrKAvjGrD6xU/E7CPm1HERafQB5bDnVVn+sCCJgXp29lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEREUfJh90ObxZfwMpZTRVri266i6LOeWDWbbdK8Us2kh8clyE
	RMKJ41hAV1+Kao05rvtscyOarGd4RIVfWILerhzGXNAUloqjFt30wjXUr9x5A7jXqpPr1PbMWmN
	sfoVmmA==
X-Received: from pjvi16.prod.google.com ([2002:a17:90a:dc10:b0:35e:591b:3591])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec5:b0:35f:b4c1:91ea
 with SMTP id 98e67ed59e1d1-361402ee818mr18770329a91.13.1776890070624; Wed, 22
 Apr 2026 13:34:30 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:34:29 -0700
In-Reply-To: <aekrJrSRoclZoBo9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com>
Message-ID: <aekw1S5Gdkyx8teC@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > Perhaps we just need to rename the functions (e.g.
> > > kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
> > > checking.
> > 
> > Definitely the latter.  Or both I guess, but probably just the latter.
> 
> I think both. I think renaming to kvm_vcpu_map_page() (and similar for
> others) would further clarify things, especially with the introduction
> of kvm_vcpu_map_ptr() below.

I don't like "page" it's too easy to incorrectly assume "page" means "struct page".
There are KVM APIs that do use "page" generically, e.g. kvm_read_guest_page(),
but for this particular case I'd like to stay away from "page; there's a _lot_
of ugly history around mapping "struct page" vs. "other" memory in KVM.

> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 9093251beb39..e8d2e98b0068 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3114,9 +3114,10 @@ struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write)
> >  }
> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(__gfn_to_page);
> >  
> > -int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> > -		   bool writable)
> > +int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
> > +		   struct kvm_host_map *map, bool writable)
> >  {
> > +	gfn_t gfn = gpa_to_gfn(gpa);
> >  	struct kvm_follow_pfn kfp = {
> >  		.slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn),
> >  		.gfn = gfn,
> > @@ -3124,6 +3125,10 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> >  		.refcounted_page = &map->pinned_page,
> >  		.pin = true,
> >  	};
> > +	kvm_pfn_t pfn;
> > +
> > +	if (WARN_ON_ONCE(offset_in_page(gpa) + len > PAGE_SIZE))
> > +		return -EINVAL;
> 
> Maybe do the bounds checking after initializing 'map', then
> kvm_vcpu_map_ptr() wouldn't need to explicitly set the pointer to NULL
> on failure? 

Hmm, no.  I don't want to encourage the caller to rely on the state of @map if
the call fails.

> There is already possibility of failure after initialization anyway.

Sure, but the caller shouldn't rely on that.
