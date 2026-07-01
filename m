Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86723224AF2
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939298; cv=none; b=mN4lUzU2ACvDP7E3BzMO7gArZvtY++P+moBABWus/MAQpSpseyi82ZW2NVUlM8NrGLP7IUggI8LRq1abtKsL4SzKpueCvLgy6++mGDMDLVDWKORy79WDnV5N2qGKkrx8DwihwK15PfDuooa60CCWE/IpPp4X08OuYQKj5jeKKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939298; c=relaxed/simple;
	bh=vrG7DV3XMjvehaBvAHY3d6fzypEbpc6iWjoNWIjk38c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2cEObA3PFETxx/1WJijuYok3l6BazUNNT7ask6HkfyzJMTbeItN/RLe5fQQnVV0TC2Qb6KXfYE4zEzNKT2E8pQ2i9LCjYTrKs8sCyAxujFZHxZd4/gmeX/uqgznhUeuRkTxQDC92sgnJUOPqjLnbeH75Qu10T7smm9smd1fu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mqpv++Hj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mqpv++Hj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85798977dcso949134a12.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782939297; x=1783544097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0jRX7NnLp+Ssuusck8PUjzqP7NAa84Kcqnt+k1PSlo=;
        b=Mqpv++HjWndsVxYEU5VjfddtrIwiwlDDeexYF/tY+QD1Ib0UtkmtNE1phbsOUxooj6
         30cciFAUrtNsajVm6+azcKgT6Pd4raIxjs+lDfzCJVrkWHrrXX8MVHTkrWv6diDW+slC
         UMjCD5ZdhXZnxysNIfUBQnmeLU0A6XYFFYpdJYpzo+H29ILlaqV4vFisdKt0lXJVfK1i
         ugMsaXsTqztYuTGkSTzfdDFT6c3KwaPa2hwyL7yhoELNvuAslIuEW2zuMmUP0iMpiMcL
         GmL6ebKc+oxcvFJ8Ps854XkQUzCJMSq8yzwUBz4Eb1TtER+ECUgioFTtnWPikfFALwZK
         pzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782939297; x=1783544097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0jRX7NnLp+Ssuusck8PUjzqP7NAa84Kcqnt+k1PSlo=;
        b=evtZKfpx4PpS6fU0gd+AaHqLExRAycDt3BzVwmNo9QOIekitzW3Qn/Ug3/bbBwIIM7
         Z9RWcxMika7AN82VfWKOGFfic+xWIV7ipInFCz9G5od3ywDWUwVuus6rnQ63pl2qnpYr
         PQZjfzV5eiggD1T56cXJX1C0YDAzZvFEPmrbC+vqDUDG1AjB3cGg3Rv++4MuiC+tbg+N
         l3bQ+qgzk6UXloMJ1ekQLJ6vS+u68AhBSNdP2JOEhq2iCQ4GtYBKtIGtVrZD2CUzlt2K
         KERBpx8bzYSBPWqusEezPW9BSNxI3b0+Nr4+CiIkbQq4VlWuUo+HwUtYhjwFOL80Pzhh
         pK4w==
X-Forwarded-Encrypted: i=1; AHgh+Rpbk6eoxPlleDXHWXST1udJ0JeMuXGDBTPs8ugT2CjDWzmZbRvxlWW3MPHq0mYQ7ocJDek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8H16js5kYAIkZbkFmEyd6qeC5ojfvWKCvDKRy5Ji2hWiK7Z57
	6jkzHH2FXH6hcPB/BNGeDUOzO8kY4uIUTyXcBl9Fpr9lyeYxvZNV9Ea8Jsf58ivcPOXVd94EjZN
	LZ1ME3Q==
X-Received: from pfwp10.prod.google.com ([2002:a05:6a00:26ca:b0:847:a740:48f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:27ac:b0:842:2ae0:968d
 with SMTP id d2e1a72fcca58-847c098651fmr2693616b3a.32.1782939296527; Wed, 01
 Jul 2026 13:54:56 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:54:55 -0700
In-Reply-To: <CAEvNRgHt1F28iDegRxtYDfy95iQysLkFW=7YPruwky_stf5TLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630213711.479692-1-seanjc@google.com> <20260630213711.479692-3-seanjc@google.com>
 <20260630214952.98C851F000E9@smtp.kernel.org> <CAEvNRgHt1F28iDegRxtYDfy95iQysLkFW=7YPruwky_stf5TLA@mail.gmail.com>
Message-ID: <akV-ny84UPMpsnez@google.com>
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Ackerley Tng wrote:
> sashiko-bot@kernel.org writes:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] The `region.nr_pages << PAGE_SHIFT` calculation can overflow a 64-bit integer, bypassing GPA boundary validation and leading to a host denial of service.
> > --
> >
> > commit a54da29c3e4be3226e4ebf9df2f4182c350df998
> > Author: Sean Christopherson <seanjc@google.com>
> >
> > KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION source
> >
> > Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
> > pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
> > consistent between TDX and SNP.
> >
> >> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> >> index ffe9d0db58c59..b0ec054732b90 100644
> >> --- a/arch/x86/kvm/vmx/tdx.c
> >> +++ b/arch/x86/kvm/vmx/tdx.c
> >
> > [ ... ]
> >
> >> @@ -3247,8 +3244,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
> >>  	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
> >>  		return -EFAULT;
> >>
> >> -	if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
> >> -	    !region.nr_pages ||
> >> +	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> 
> Since we're changing this, how about separating/grouping conditions so
> that adding validation is clearly different from alignment changes?
> Perhaps like
> 
>     if (!region.source_addr)
> 	return -EINVAL;
> 
>     if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa))
> 	return -EINVAL;

I'd rather not do that as part of this patch.  I'm not opposed to refactoring
this code, but I don't want to make the diff harder to read by throwing in
non-trivial changes.

> And this one might need more code if we're fixing the issue Sashiko
> pointed out.
> 
>     if (overflow)
> 	return -EINVAL;
> 
> >> +	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
> 
> Looking at this again, why should region.nr_pages == 0 be -EINVAL? Why
> not do an early exit and return 0?

Because nr_pages == 0 is nonsensical.  And as a general rule, don't return success
for uAPI unless it's necessary, because it's much, much harder to extend
functionality if a path can succeed than if a path is guaranteed to fail.

E.g. very hypothetically, if we want to repurpose '0' to mean "delete this page"
or something, then returning -EINVAL now provides a more viable route to supporting
such an operation.
