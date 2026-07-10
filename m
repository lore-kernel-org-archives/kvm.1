Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104B23EAA0
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727045; cv=none; b=OaKTLrz7YNzOfXxhkjIaK6J3OkUjqedWNayojzZy3aWeWQ83UxZwSXp4F7lrXYnwHNENuSP1sa6irgVDq0NdSmTEHIoGU7IdhtFf8fdMeryhM5ZDyPGP5OxcAZQ/cUgDbSY4NAIE2JRz80ojy6Ujf/CJ31Bxs12vNu0DFSpAg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727045; c=relaxed/simple;
	bh=fIHQ4IkKCY/4sYZwr6kv8yioERqcoRrxAhbG/HFKaSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eISa+QisqOzv4cE/sHMYWrHuCF7R3nGRRuV6qJpDgwCkO4sr8BLgw3mdjqpV4y3P72MS/U87QHaAuw4W5Y16igwLPRS/PO4pVWYUBXf5a42T3azIfYh4Bej+fjRmptHD2AGeBJ0J0IoPvxq7T2hcI3IkxBPlLqUXw7pbeF3d23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwlwFnya; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwlwFnya"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6bbd0afffso26593465ad.0
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783727043; x=1784331843; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyrrQw0uIF796ixgP0OmI0yh6HHwdaLC/9zfXBgsUHg=;
        b=EwlwFnyaQFGAoDiRMU6GCaPNowP8VwMm5AeeqUXRn6nJYfzrwAA53O1feKihi6Itus
         cQCraULAaoxB+Wwy8BopQ/PHzo+HE8jUXCRnYh0qI9ER98xmVdmJYPbhkyzL5ny4Zbq3
         a92e7ivh0N9MK6un7jSmm4XGogGck+sJqdtxta0IdUJMHiPVnzKZyDhBDMPI4Is7Chno
         PcbJ1z9+FXtWn7petdNK/Ter6uBWjWTzXZThsa33R1OI/fvT9ZczBObawlaQ2ZgDVtqT
         eEdkBhRn5QgD0gbX9pmfG/Rzgl3C9SRKehUnP7t/oTw+O4xghaMJ0vHoERV79TOU0XR+
         xRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783727043; x=1784331843;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VyrrQw0uIF796ixgP0OmI0yh6HHwdaLC/9zfXBgsUHg=;
        b=in8wvbBx0dmQHwcbte/1cSscqe82umgX5hUrHkmV+ONTO9LEb8KSrFHZVFWMEJNlbQ
         HNFeiCcYpffLIdzBh+3kKkgNse1SqD/+Ma5mzhdDGL9UNsOGs5owY0qvHG1tQwkyZOhA
         yhf5W5/ke3t8HDPZ1jHOh953AkajF5+8VK69ESIoCdyWLG9lAOM/e0uwrWkeG8BETWp7
         oCuS75fSRE0BOzC2HtLsvYHAMSqBpxYMkesABrEWV1+EgmhlV4fJDoYocx7iKm5LU6hd
         txTCVlsI2I9RPEpXizDyK0wWCqXoOEJd2Fw2TqU2j4kCOb84jKRBMKG1ylY4cGQdUX9o
         sOeA==
X-Forwarded-Encrypted: i=1; AHgh+RrEiDXjpaUq6vqeSrzLt0qeGVZv6s6rHY1MJtl2EkUcHj0tu/f5LWND5owV6SQ3vCVC9P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwdvSORCJ47Nr46q2zw0ajmYfOvf58TvmnvF5/wHdIgbXHr6h
	6WJPqphEuxkQ+u4/Z9PBthhzkx0FLbxPmLnSFKpaG54qHlV/0Zn/l3poedsZoHM6dWf36RzRdDh
	82ST2OA==
X-Received: from plou16.prod.google.com ([2002:a17:903:1af0:b0:2cc:8021:ae87])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2410:b0:2cc:f43b:fa4a
 with SMTP id d9443c01a7336-2ce9f029899mr10018765ad.24.1783727043184; Fri, 10
 Jul 2026 16:44:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:44:02 -0700
In-Reply-To: <CAEvNRgHF1wybj7tHWMgBtnfb0W5AzyjhL45PzF3e2BVxrBUe7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-14-seanjc@google.com>
 <CAEvNRgGz4hWw+p90JPgmP29dMKjVcamfH57Hz=k15VYEypSfEQ@mail.gmail.com>
 <alFtXYztr_Ic04bb@google.com> <CAEvNRgHF1wybj7tHWMgBtnfb0W5AzyjhL45PzF3e2BVxrBUe7A@mail.gmail.com>
Message-ID: <alGDwp9rJh23iz5D@google.com>
Subject: Re: [PATCH v4 13/18] KVM: guest_memfd: Pass GPA, not GFN, to
 prepare() hook
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 10, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, Jul 09, 2026, Ackerley Tng wrote:
> >> Sean Christopherson <seanjc@google.com> writes:
> >>
> >> > Pass a GPA instead of a GFN to kvm_arch_gmem_prepare() so that the GFN/GPA
> >> > can be made optional in the future, i.e. so that guest_memfd can pass
> >> > INVALID_GPA.  This will allow reworking the hook into a general .convert()
> >>
> >> How about defining a INVALID_GFN instead of using gpa just so
> >> INVALID_GPA can be passed? The SNP side takes a gfn, so it seems like
> >> the 2 PAGE_SHIFTs are extra work.
> >
> > They are, but I am very hesitant to define INVALID_GFN as I'm worried about the
> > potential for subtle bugs if both INVALID_GPA and INVALID_GFN exist.  E.g. I
> > almost made a goof in this exact series where I was going to do:
> >
> > 	gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_guest_vmsa_gpa);
> >
> > 	...
> >
> > 	if (gfn == INVALID_GFN)
> 
> When you did this check INVALID_GFN was defined as (~0) too I suppose...

Ya.  I didn't actually get that far, because INVALID_GFN didn't exist, but that
was my plan.

> > 		return;
> >
> > Where snp_guest_vmsa_gpa is set to INVALID_GPA.
> >
> > I suppose we could define INVALID_GFN to gpa_to_gfn(INVALID_GPA), but that feels
> > weird, and I feel more comfortable having magic invalid values in only one domain.
> 
> Maybe INVALID_GPA and INVALID_GFN should be defined such that both
> gpa_to_gfn and gfn_to_gpa are correct for both.

Oh, _that_ was actually what I almost broke.  I was going to track the gfn instead
of the gpa, and then do:

	svm->sev_es.snp_guest_vmsa_gfn = INVALID_GFN;

	...

	gpa = gfn_to_gpa(svm->sev_es.snp_guest_vmsa_gfn);

	if (gpa == INVALID_GPA)
		return;

That would have failed miserably, because even if if INVALID_GFN is -1ull, the
lower bits would be zero after the shift, i.e. wouldn't match INVALID_GPA.

I _think_ make that work, by doing something like:

  #define INVALID_GFN	((~(gfn_t)0) >> PAGE_SHIFT)
  #define INVALID_GPA	((gpa_t)INVALID_GFN << PAGE_SHIFT)

Which I actually don't mind conceptually, but I'm still not sure it's a good
idea in practice.  For whatever reason, converting between INVALID_GFN and
INVALID_GPA just feels wrong.

> Isn't the relationship between gpa and gfn always supposed to be always a
> fixed shift apart?

For valid GPAs, yes.  But if a value is completely bogus, is there really any
relationship?

> When a GPA is passed to the arch function, it almost feels like now the
> arch should be validating PAGE_ALIGNED(gpa).

Not sure I follow this.

> Mentioned this off-list, another thing that seems incongruent is that
> one parameter is in the address domain (gpa) and the other is in the
> page frame domain (pfn).

Yeah, I definitely don't love this either.  Hrm.

Aha!  Idea!  What if we just kinda sorta punt on the INVALID_GFN concept for the
moment?  This series doesn't actually _need_ to detect an INVALID_GFN, the only
"usage" is in a sanity check:

       if (to_private) {
               if (WARN_ON_ONCE(!kvm || gpa == INVALID_GPA))
                       return -EIO;

               return sev_gmem_make_private(kvm, gpa, pfn, nr_pages, order);
       }

and that can very easily be this, which is even better from a safety perspective,
and is actually somewhat sensible given that it also ensures KVM isn't trying to
assign a gfn with the C-bit set.  (Untested, i.e. I may botched the math, but the
idea is sound).

	if (to_private) {
		if (WARN_ON_ONCE(!kvm || gfn >> (kvm_host.maxphyaddr - PAGE_SIZE)))
			return -EIO;

		return sev_gmem_make_private(kvm, gfn, pfn, nr_pages, order);
	}

Then in kvm_gmem_free_folio(), open code -1ull for the gfn:

	WARN_ON_ONCE(kvm_arch_gmem_convert(NULL, -1ull,
					   folio_file_pfn(folio, 0),
					   folio_nr_pages(folio),
					   folio_order(folio), false));

Which is all a little gross?  But I think it's less gross than passing a gpa, and
we don't risk delaying this and the in-place conversion series trying to find the
perfect answer.
