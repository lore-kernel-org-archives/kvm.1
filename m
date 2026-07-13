Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768A389114
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981686; cv=pass; b=rN1vAj1CWHlaIUCrb0V+VqJ0CZJiXTXyMV3Sy1ru6lHb7YA9Tm7QM2rq/rxkXByGqw9s+rX2eW90Jgv7QCj/H7lVSCUXBS6q4e7XHoBetLDtM76+PgOzOVFtkJJxpBcQS2mhxwoaj6E2UQcjNOkiVvTaos90NHKq700mV5eRE5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981686; c=relaxed/simple;
	bh=Y2G6D0xBuJDnIZoJYZyPtR5Ib3z7vap95aV3/VTRtgE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kkk2/+ZTRzT66NpZBDinLSrUmLhixooXNgLE4oDnB0hFB4igSAAd3qzfcaW8m5Yo8hU/6tb8S56sohaTuPChViQHe9f/sJ8Mr7eKfN1I91gTGrbzEKJrq9mTmLGEANQeKu60+Pxev7ypdslJyLSFTUoLM6jELatnvWcyqppHsE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bU5/rsxY; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bU5/rsxY"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2611585a12.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 15:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783981684; cv=none;
        d=google.com; s=arc-20260327;
        b=l5oCJWHJRkbisnH/QaeHT7sE56eQrpwzmJcL+kTg9EJoxtFPbq4tztNIwDoXA7Q6QM
         FZSUUrL0cB6ow33mQPRhy6rY8PskTDfg4LLZ5vctI3k1K33dJcvuOCQmZdYKG/PLx9Kj
         TEtbrfoOwxrvuhd6a8zmIz0mxDknaU0oUQwUO73jHjToJPyk8rakZrjG11pqJQ1VXnPW
         xgnxNPg7YxiMiSwVmcCH35Hws2SnyfxZwonNFyvNWLzqJ9vw4LLR3DK9ibSTsvrjquEd
         9/snlPn4WGMQOh5VvQSo6fP/LU/PVFyxcctyHTZpJmmMkXq/G/I/NVszH+F0Vax5U/F/
         Hhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Q5LYLVL62YwmWrP9M4PDowBB20EbwGKgz8ANGmr1cLo=;
        fh=KZvBFyQ/R/yLaqL7VI0PMI6+CLTcK+qIHiQwJPVrmX0=;
        b=naHKxstOQOPIsy4GXFmEiOdvoqGR9DkEWskfgLK5hLEF4CK5ThBA6YQuN/ZkXXGjWQ
         YpqaCM/aKpRWT/cO3mDmjqxcIhXOVRKQCF737ZEQXNKR5iO1dduLAaj0N0Gun8Wl89SW
         g5MmGSsHO3BRzDqJvdaTY8Rp31hGPJnMikfmjuKGhsJ2IZEPP3fHK+S8pVeiKlfHbWhs
         raOrV6toBw50LrbTX7D2PNlmgXPvcS7s2OZJCvTrmYQEwCix+/JWTdBGIHGgxV4GsuEO
         kGZlqJMiK2duPPMRy/E1vToVf0+Naa9TtCqNPeOxJkik24USqL+DX5x8FvQTuvsIgAuu
         5Egw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783981684; x=1784586484; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5LYLVL62YwmWrP9M4PDowBB20EbwGKgz8ANGmr1cLo=;
        b=bU5/rsxYHeHWVTZERolcwPx/lQQLeJNYGDflvjn1AOA+J6kok19OD/09776I1f5OCs
         w3bHXicgRfuXT7qOSmHdn0CyqS7Jxnf5B7nGSU6tsOPc6dpr7amZnZl/ZsZLvNfv/3Ik
         ZkzrwHDOa1OiMTkXmB2kUgv8Yh7nPP7U9itwAoJRizcyq2Q25cvJXF/ImnMXNCp0Jt38
         sS2RsIcjFHUG9W0XIk62pmgZmGPU1sKcZUtObUBr65/zVNZARbNI84A0O82c66DjHWCQ
         /Ofo+uv+/u/6IOiOEIFsS9TIXNt37CQ9QN0yP/VZ7bFxNXTkHBwxviC2q/Q7rl5UKK54
         Ih3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981684; x=1784586484;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5LYLVL62YwmWrP9M4PDowBB20EbwGKgz8ANGmr1cLo=;
        b=QXXOkucn00ibtIoumYR0wDG5dNmVEqLx3xswu68c4O9eKosuhjqRFAnvOxRO8hIUEM
         qn7dgU0cm4cj0CXXrq4AM/+He3RumYZtWnC0cEBattBy12cLE1muyikfVrkycc+eEaoA
         EVSDT2/wuAR9n1uLujxugtabx4EKhP+pFyiwfL6foGuuoRn45+j4h4B7kI76xxQ7uPXK
         Y5+gcwJj06Z+jYe8AWGvoxaMgs23DoFWLg8Ld3zZUfP+w+PM2J5wmJpcVb6AGN0tVxd7
         8p3yP3zFX69appVj/lOaIvu/DWNUitThhVYU7+rdFteAm5ADlC2pok+SdacohzDWVVJO
         W3eg==
X-Forwarded-Encrypted: i=1; AHgh+RrLYseqrEJAMNA81Iw4mM1PTcEbqbBEtqV4RROhuLYYuqwyyuUMCoDJXmrFgNf/SVXll28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMI2ALpxqzQq0Cn3RRcmXFxBKqR0VVuk2gt/Ly0i4GZ7+jdq+v
	s6KBa0fvWISTI9M82FAWpi28/QYQqOkTDs1AsyIGt5L+JDKdFArL5X//XTcf3G9CFXHFxol+RuM
	LrKAr8dacgy3fOOTgXj750f664s8yc470fIGS0lLD
X-Gm-Gg: AfdE7cmumWqFKNn7FlAF6qFq6ox273xNxfUbFtI2o9Svy9/9+B1yXCHSes39HIVkIAn
	s7g+yoYhETus+h9XKV9/cCNMbs9kpBmw+EMiE/BTBGxAe4HPiWWieCY5yqpzNZRotuhe29BH02J
	7eTAha3ic5mIAzMmhBB1VR+sUU/l77yCuWTnC7x51i10GrECqLgavnxFKWcoAzNFpOOpHnYgVGX
	kO+30IlZT3JlrLI9HKfNzl3NVAnUc2bCZx8NwIsgVMVAOGwWJIrXNDLhBRv6Ew9lgOnhSDsUyba
	ywjlB/WWhCcdTTzOKQvJ7ynoOHFIMBGIt9mBoYBOkrPogs8IFQjWCDvZg3Y=
X-Received: by 2002:a05:6a21:10b:b0:3c0:9c19:6589 with SMTP id
 adf61e73a8af0-3c110cea187mr12656025637.67.1783981683888; Mon, 13 Jul 2026
 15:28:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:28:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:28:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <alGDwp9rJh23iz5D@google.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-14-seanjc@google.com>
 <CAEvNRgGz4hWw+p90JPgmP29dMKjVcamfH57Hz=k15VYEypSfEQ@mail.gmail.com>
 <alFtXYztr_Ic04bb@google.com> <CAEvNRgHF1wybj7tHWMgBtnfb0W5AzyjhL45PzF3e2BVxrBUe7A@mail.gmail.com>
 <alGDwp9rJh23iz5D@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 15:28:02 -0700
X-Gm-Features: AVVi8CeUDho5OLOsd5SyP-1vmscasnXw6OrNKsqfr1BWfP4K8lEwzt3sJR4prgs
Message-ID: <CAEvNRgEJrq4RXyKDOKMaubHHcbhkh1Rpu3p_6w4X0D0KDjzhcw@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] KVM: guest_memfd: Pass GPA, not GFN, to
 prepare() hook
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jul 10, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Thu, Jul 09, 2026, Ackerley Tng wrote:
>> >> Sean Christopherson <seanjc@google.com> writes:
>> >>
>> >> > Pass a GPA instead of a GFN to kvm_arch_gmem_prepare() so that the GFN/GPA
>> >> > can be made optional in the future, i.e. so that guest_memfd can pass
>> >> > INVALID_GPA.  This will allow reworking the hook into a general .convert()
>> >>
>> >> How about defining a INVALID_GFN instead of using gpa just so
>> >> INVALID_GPA can be passed? The SNP side takes a gfn, so it seems like
>> >> the 2 PAGE_SHIFTs are extra work.
>> >
>> > They are, but I am very hesitant to define INVALID_GFN as I'm worried about the
>> > potential for subtle bugs if both INVALID_GPA and INVALID_GFN exist.  E.g. I
>> > almost made a goof in this exact series where I was going to do:
>> >
>> > 	gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_guest_vmsa_gpa);
>> >
>> > 	...
>> >
>> > 	if (gfn == INVALID_GFN)
>>
>> When you did this check INVALID_GFN was defined as (~0) too I suppose...
>
> Ya.  I didn't actually get that far, because INVALID_GFN didn't exist, but that
> was my plan.
>
>> > 		return;
>> >
>> > Where snp_guest_vmsa_gpa is set to INVALID_GPA.
>> >
>> > I suppose we could define INVALID_GFN to gpa_to_gfn(INVALID_GPA), but that feels
>> > weird, and I feel more comfortable having magic invalid values in only one domain.
>>
>> Maybe INVALID_GPA and INVALID_GFN should be defined such that both
>> gpa_to_gfn and gfn_to_gpa are correct for both.
>
> Oh, _that_ was actually what I almost broke.  I was going to track the gfn instead
> of the gpa, and then do:
>
> 	svm->sev_es.snp_guest_vmsa_gfn = INVALID_GFN;
>
> 	...
>
> 	gpa = gfn_to_gpa(svm->sev_es.snp_guest_vmsa_gfn);
>
> 	if (gpa == INVALID_GPA)
> 		return;
>
> That would have failed miserably, because even if if INVALID_GFN is -1ull, the
> lower bits would be zero after the shift, i.e. wouldn't match INVALID_GPA.
>
> I _think_ make that work, by doing something like:
>
>   #define INVALID_GFN	((~(gfn_t)0) >> PAGE_SHIFT)
>   #define INVALID_GPA	((gpa_t)INVALID_GFN << PAGE_SHIFT)
>
> Which I actually don't mind conceptually, but I'm still not sure it's a good
> idea in practice.  For whatever reason, converting between INVALID_GFN and
> INVALID_GPA just feels wrong.
>

The above isn't a conversion, it's picking/defining sentinel values that
are dependent on each other :)

We could also go all the way where gfn_t is always retrieved with a
getter, and the getter always checks for the sentinel value, and then
maybe the compiler will optimize out the check sometimes, but this is
probably just C's way, where when invalid values are not possible
they're not checked (pre-optimized out).

No strong opinions, I do prefer passing gfn over gpa though.

>> Isn't the relationship between gpa and gfn always supposed to be always a
>> fixed shift apart?
>
> For valid GPAs, yes.  But if a value is completely bogus, is there really any
> relationship?
>
>> When a GPA is passed to the arch function, it almost feels like now the
>> arch should be validating PAGE_ALIGNED(gpa).
>
> Not sure I follow this.
>

If sev_gmem_convert() was handed a gpa, it seems to imply that the
caller could have passed in an unaligned gpa, which means
sev_gmem_convert() should do

  if (WARN_ON_ONCE(!PAGE_ALIGNED(gpa)))
  	return -EIO;

which is even more extra work in addition to the conversion from gfn to
gpa in the caller and back within sev_gmem_convert().

>> Mentioned this off-list, another thing that seems incongruent is that
>> one parameter is in the address domain (gpa) and the other is in the
>> page frame domain (pfn).
>
> Yeah, I definitely don't love this either.  Hrm.
>
> Aha!  Idea!  What if we just kinda sorta punt on the INVALID_GFN concept for the
> moment?  This series doesn't actually _need_ to detect an INVALID_GFN, the only
> "usage" is in a sanity check:
>
>        if (to_private) {
>                if (WARN_ON_ONCE(!kvm || gpa == INVALID_GPA))
>                        return -EIO;
>
>                return sev_gmem_make_private(kvm, gpa, pfn, nr_pages, order);
>        }
>
> and that can very easily be this, which is even better from a safety perspective,
> and is actually somewhat sensible given that it also ensures KVM isn't trying to
> assign a gfn with the C-bit set.  (Untested, i.e. I may botched the math, but the
> idea is sound).
>
> 	if (to_private) {
> 		if (WARN_ON_ONCE(!kvm || gfn >> (kvm_host.maxphyaddr - PAGE_SIZE)))
> 			return -EIO;
>
> 		return sev_gmem_make_private(kvm, gfn, pfn, nr_pages, order);
> 	}
>
> Then in kvm_gmem_free_folio(), open code -1ull for the gfn:
>
> 	WARN_ON_ONCE(kvm_arch_gmem_convert(NULL, -1ull,
> 					   folio_file_pfn(folio, 0),
> 					   folio_nr_pages(folio),
> 					   folio_order(folio), false));
>
> Which is all a little gross?  But I think it's less gross than passing a gpa, and
> we don't risk delaying this and the in-place conversion series trying to find the
> perfect answer.

Yes thanks, we should go ahead with the GFN version, we can definitely
update this later, if at all.

I have some more questions, though not blocking:

+ I didn't notice that NULL was passed here. Is this kind of leaking SNP
  details into guest_memfd, that SNP doesn't need to know which kvm it
  is to convert a page to shared? Or is it that in principle converting
  to shared means "removing from ANY VM" and hence kvm = NULL?

+ Is the purpose of checking for the bit being set to set up a contract?
  It's better than passing gpa, but TDX has the opposite definition for
  the bit, with 1 == shared. TDX doesn't use this callback so that's
  fine, but it's hard even for SNP to check since IIUC with VTOM 1 ==
  shared? What if we just not check and depend only on kvm == NULL?

How about this: as a lifecycle callback, guest_memfd calling this
function should be saying "guest_memfd is doing a conversion of nr_pages
beginning at this pfn to shared/private, and by the way here's the kvm
and gfn since I have the information." (all arguments presented if
available) and SNP says "I'll take action, for to_shared I don't need
kvm or gfn" (just ignore kvm and gfn for to_shared conversions)
