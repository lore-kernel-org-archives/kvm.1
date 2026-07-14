Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1579CD
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783987249; cv=none; b=RlYOq4dn3B+z22iMiAdbm0taOiVA8SbggbeamndIRtiiW2xY8pcYDbN3hKqxmKQj1xZ+Xc/GRpIj+s0ROm5vvrFea0u30mv21kA7SfORlDLLZu5jJjVLJtGyFFBjfyZGXEm/iq3CxQxcpfp1Z50R1r2PWC/JQ8GwXj1oyZCUv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783987249; c=relaxed/simple;
	bh=vK4nNF8Lxnnc8+sU1oNbH/TKkIaPhrbmZP8aTjmmElg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=smAPbmtT0r0Cb2bfYyzo+2l41b6SIeYMteqIfEVOhZ3JsA5YkYqie8JZft8SR+mQmnVa56ZvfcXrIPwIv14Hj/UQkjb7IDmg76OQsoRrrYSG2gs67+1cvmd9R0r4kCTEw7YR5gE5aFEb3tvWWk0aJWmr2+9vmhHzp8MzPWU0nKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9CV34n8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9CV34n8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso446849a91.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783987248; x=1784592048; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60sX/LZIAI/vlaGiF0cYOJmfISm4IQZoYeFxliNrCPA=;
        b=q9CV34n8lnGwbU2rDX/DeAbWR/BeyG35rWlOYSfrgTBcsVbyBWlkRiXFU05w85T8ez
         +h+R+YUqWF2KdPBy8fXdizLWHtUVfiebhVXi5h7KjBujn2cTEjlBB7lxwix7UmDdOUGX
         1AsuEITnjlYgohl1J8P2TE6ydluMz5WZgKMldVSA/D5kjTHsmBkzuzO78p/hxuCenMwg
         HyhzvUqhAERsjUqmNHwEtKyFw7fnqq80J6Y+YwkoszNTxIrgOC3/mEFJMC39Tht4P8Gq
         qlLsTizTiltgNZOIn9swp7wn9adD/7EUpOUGSn115f5qI5VnwWxiZDlC60vBrIk5fmYD
         TVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783987248; x=1784592048;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60sX/LZIAI/vlaGiF0cYOJmfISm4IQZoYeFxliNrCPA=;
        b=BjCx8siO9DqXoT/fnj/Kdi8GthRa8sgs7Vjosnn35oPwsi6sHc9hxJEuHIgXFi5nMv
         naO7+PrLvTiHQZfZgv5hJE5yE7rklMONmjMs8TyGnndR+MxEY74Irm3c+wcgm0ZSQoXN
         qnv8RvPwAvQLIl48v0dwz6kkRl87MmC1Bq7rGIK9qkozs9A76H7Y01/4XT9qIz44vEkD
         593ROA7cJ/DoLNWXc6rt/XdUJiou4gli2VDUCP31oAAY1i/lgn8PprSRsIPYGqY2D2I7
         b+4t4MZyp0sLJ+fWqQqg3wEb7T0FUjVzNFo9jE5sfBXjYRWLAhcoh8ZgBZLqlxwyxHyX
         EwPw==
X-Forwarded-Encrypted: i=1; AHgh+RpLgASh0CW46FPwSZOUhBKn+JSYLdJJI47olPMnl59cZs+rf8/9QdS1ze0z9X4QWefttGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0U9kraU7+I1/NgSVmRQ5HQfDZ3lB3P4qIo1jkbzq/yVR4UC0w
	Ec0kf8aQw+g3sLScOEEarGukTQy9trJQ/I3DD8ErZt9DTTQ7oYR5/gMepbOJL83cujUIah7Ca/1
	goUYcdg==
X-Received: from pjyv8.prod.google.com ([2002:a17:90a:e988:b0:37d:f943:23a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f42:b0:37f:c28a:de61
 with SMTP id 98e67ed59e1d1-38dc75fa2d0mr11368740a91.17.1783987247527; Mon, 13
 Jul 2026 17:00:47 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:00:46 -0700
In-Reply-To: <CAEvNRgEJrq4RXyKDOKMaubHHcbhkh1Rpu3p_6w4X0D0KDjzhcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-14-seanjc@google.com>
 <CAEvNRgGz4hWw+p90JPgmP29dMKjVcamfH57Hz=k15VYEypSfEQ@mail.gmail.com>
 <alFtXYztr_Ic04bb@google.com> <CAEvNRgHF1wybj7tHWMgBtnfb0W5AzyjhL45PzF3e2BVxrBUe7A@mail.gmail.com>
 <alGDwp9rJh23iz5D@google.com> <CAEvNRgEJrq4RXyKDOKMaubHHcbhkh1Rpu3p_6w4X0D0KDjzhcw@mail.gmail.com>
Message-ID: <alV8LlCuRQ1aDv5O@google.com>
Subject: Re: [PATCH v4 13/18] KVM: guest_memfd: Pass GPA, not GFN, to
 prepare() hook
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 13, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> >> Maybe INVALID_GPA and INVALID_GFN should be defined such that both
> >> gpa_to_gfn and gfn_to_gpa are correct for both.
> >
> > Oh, _that_ was actually what I almost broke.  I was going to track the gfn instead
> > of the gpa, and then do:
> >
> > 	svm->sev_es.snp_guest_vmsa_gfn = INVALID_GFN;
> >
> > 	...
> >
> > 	gpa = gfn_to_gpa(svm->sev_es.snp_guest_vmsa_gfn);
> >
> > 	if (gpa == INVALID_GPA)
> > 		return;
> >
> > That would have failed miserably, because even if if INVALID_GFN is -1ull, the
> > lower bits would be zero after the shift, i.e. wouldn't match INVALID_GPA.
> >
> > I _think_ make that work, by doing something like:
> >
> >   #define INVALID_GFN	((~(gfn_t)0) >> PAGE_SHIFT)
> >   #define INVALID_GPA	((gpa_t)INVALID_GFN << PAGE_SHIFT)
> >
> > Which I actually don't mind conceptually, but I'm still not sure it's a good
> > idea in practice.  For whatever reason, converting between INVALID_GFN and
> > INVALID_GPA just feels wrong.
> 
> The above isn't a conversion, it's picking/defining sentinel values that
> are dependent on each other :)

My point is that the entire reason the sential values need to be dependent on
each other is that if we add INVALID_GFN, then KVM will inevitably convert
INVALID_GFN to a gpa and check the result against INVALID_GPA.

> > 	if (to_private) {
> > 		if (WARN_ON_ONCE(!kvm || gfn >> (kvm_host.maxphyaddr - PAGE_SIZE)))
> > 			return -EIO;
> >
> > 		return sev_gmem_make_private(kvm, gfn, pfn, nr_pages, order);
> > 	}
> >
> > Then in kvm_gmem_free_folio(), open code -1ull for the gfn:
> >
> > 	WARN_ON_ONCE(kvm_arch_gmem_convert(NULL, -1ull,
> > 					   folio_file_pfn(folio, 0),
> > 					   folio_nr_pages(folio),
> > 					   folio_order(folio), false));
> >
> > Which is all a little gross?  But I think it's less gross than passing a gpa, and
> > we don't risk delaying this and the in-place conversion series trying to find the
> > perfect answer.
> 
> Yes thanks, we should go ahead with the GFN version, we can definitely
> update this later, if at all.
> 
> I have some more questions, though not blocking:
> 
> + I didn't notice that NULL was passed here. Is this kind of leaking SNP
>   details into guest_memfd, that SNP doesn't need to know which kvm it
>   is to convert a page to shared? Or is it that in principle converting
>   to shared means "removing from ANY VM" and hence kvm = NULL?

Neither?  It's saying "there's no VM at this point", because there's not.  And
I wouldn't consider that an SNP detail, because any CoCo implementation has to
work that way in practice.  Requiring an active VM to reclaim memory for host
usage would be unusable.

> + Is the purpose of checking for the bit being set to set up a contract?

No, it's to harden against against screwing things up in the futures.  And the
check isn't against the C-bit, it's against the max legal gfn KVM supports, which
just so happens to have implications with respect to the C-bit.

>   It's better than passing gpa, but TDX has the opposite definition for
>   the bit, with 1 == shared. TDX doesn't use this callback so that's
>   fine, but it's hard even for SNP to check since IIUC with VTOM 1 ==
>   shared? What if we just not check and depend only on kvm == NULL?

Because the to_private path requires a valid gfn

> How about this: as a lifecycle callback, guest_memfd calling this
> function should be saying "guest_memfd is doing a conversion of nr_pages
> beginning at this pfn to shared/private, and by the way here's the kvm
> and gfn since I have the information." (all arguments presented if
> available) and SNP says "I'll take action, for to_shared I don't need
> kvm or gfn" (just ignore kvm and gfn for to_shared conversions)

No?  That's more or less what I proposed, except I guess for "by the way, here's
the kvm and gfn" for to_shared.  Because I do NOT think we should walk all bindings
to find the kvm+gfn pairs, and because I think we should firmly establish that
to_private requires a kvm+gfn pair, and to_shared does not.  As above, in pracitce,
that needs to hold true for any CoCo VM.
