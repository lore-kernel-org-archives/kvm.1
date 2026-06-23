Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACF28C874
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258106; cv=pass; b=aZKElOVpWS9aoGADbPi+TwABNZpZWQnBpWj4HXKFhVWiOxnXX6nUb/cV4v0Fq5apqyCXQhgdw9MjN9riA4rJV6yZAKMkX+Dq55r/bMG6EV5S56y529pU8GXU/7FvJ/GleyBcZXUMIy/BuQ4G1IW9Ddo7sJ7f4CjmRAXcZfMmFag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258106; c=relaxed/simple;
	bh=0o2TLZAQfupxDW1DGh5utshxlDAHM+yJodjjXz1Q8ok=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2Z0oJLuG7n7bZxWPIQFyrZ/XbIvJJWxdizOfA8rvnLp46ao6/GFc2gNLgLMiWWd8Se5y1d9VmCyLlMZr1SM9XYJQm/Q0EPDY/4GxdIqmKhUPpmKZbA2CekzNcMAWAsVO9GORgBDaWncE0f8mK/c+AqpTZ3oMJRB8dMui+XkH/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dH+5PCRn; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dH+5PCRn"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b6dad2382so746091eec.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 16:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782258104; cv=none;
        d=google.com; s=arc-20240605;
        b=FiuS74egq249bFJCDowF37k+GpT02TdZMIo3JNZVALXyalUdLammOuappQT02gGbou
         WZu+hapr4qZutnUgKzhKAo40C8Lat6plXq9sO8DCJVMs5sOy3U0htPqjYR9Y3k/pbkDr
         BIm3ZAL2SX5HM8npK0+cDrZwLRh/Ek7jsz0w7JcYbgQQGGmwtZCoQS1Qam+K0Z1mZfgC
         ZqFwzhGi8cPsyHkAnLILVuXY6mg9wXbyk6Ihi4DBqcYnXfigDqgimaVEOZu8iO1lGfLn
         AHSYX9FFyZZ6ginrcHajqu1gybbZ6IDXSwfEwBrAuDd95A21ED37ZSqvLh6O6AjQTlHn
         lGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5R4jJVdiiD97J3GTz0Op+QXJSLTSXOE5UM4tQq8YjrM=;
        fh=2zob5bhyYvsfNBIlBsoaBkrN+jX20JG1zdqaXcS5LHc=;
        b=e5D1N8KHSTJBLKrlMZ30T8SWcX9RM9lwy6dlvTn3zIhRnZYI5cfiVh2pqelRmauF/n
         C5j/OMzFI8MniCzsB+e6mo0YvYy/TjKtU+AIi2zfL56fpIswJUDihouaBnXCOfMaUiXw
         v5z0MMjw6zJ/3hWA2sTGW3yQQ0Ubes1V2ui2PeH1UCHBokmdrzJ1+rVelJhNqp2OSnoJ
         xT9Kj8GrCTKHNB1CInywMAzUG1MOVm42iR0mcpYQYEzK7qoC50w1ejbs9Nsa2NcmGj/1
         y4c0wqtGhwB4aId7NFpNC+k7O6yBYil34d/5VRc40R2i/SNACt0xMwieVbtvyevMseV2
         QWgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782258104; x=1782862904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5R4jJVdiiD97J3GTz0Op+QXJSLTSXOE5UM4tQq8YjrM=;
        b=dH+5PCRnVqCGmryzL0cw4GJNLaKmD9kqUv1x3R72ipuJ4bMihhObuvTs0fieE+UyGX
         gHHsqzsh/jA9gbiwuuDX03k47yMbC6LQdyGz4RApq9+lyDQWzqycWwKhNZ3onjM7vI4j
         kS9kYsivzUWirJmhylmczOx6Hq5qDy4FEOo8GFcp6YlE+9CRmcZ2EU0awta574V8Y5CZ
         T4l20V7M0xPj5Ac69gbXdg7NwxxQHeeYhtN2ZY3A4IkuFhpcR9Rh7qsf4R4xmQLB3QVd
         jmQmnaELGZy8DcysAmfU7qUWPZKD4OWoStim/n/8Mfpt+EJnjWc3393qey6jDtJpN2g7
         /XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782258104; x=1782862904;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R4jJVdiiD97J3GTz0Op+QXJSLTSXOE5UM4tQq8YjrM=;
        b=daqwUbN4eVtCbnCUCikhpHko92LCwvdWjRXBfGBb+ro6XIc/d72DPLa/lGdZjpXcX3
         mhJBl+qa4aP5wzSW+nmy8OcGFM4X9teKIUwPRRvf/EeOsx+6o2Viz99KGUKQbva/HROt
         0i4JDSi3iTdlwAp1h3ek9W3cd6XiT6fGaTxdDdYYMTKPTZ2WCEvwIEXLlltiPgAh0VBE
         ggk1fmpPSJzeLAQ8VzRcdRh8YpFqNiMrsoSvKNdSgVHhSyNS5b0or54WPVHih9qV+I8O
         1s0L8pWI/mlWRJZdk7sheWyONUod/tZf3HKFpx0RiqIvKoo+Urhrf2mhbcgQ646Ml5fI
         nNWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6k1QcjedDsDPiRna/StIEARypvgAl1ffwk+9ZvZk6yWijSiPFXN2nX0Jd+lW8NFej+OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEt73rPsdfWBflw9XAiQ9PNRfQdcDvWwwVsff/5qXlhpeTcyp
	L7nppHA+zBmk0qiBjRXy/k0+1waxykjtpVpp/bJ/z3Hh0ii39GtKi22m3MMdvImo4cbCrKzIoI0
	Ml10WSaYQWkhOh3806oEf/+zdsiRg3ekjhDL4xZxs
X-Gm-Gg: AfdE7cmGWpLEy6vorNR6YqsZplNAyVMHIOzAhcqyXNNZo0TkNoTrgINWt1sJieOOGPB
	WXram0y6uC8GeuBqmBVak74EWXVjTBEhhrdl+z42FLZg6mPKtZsOkzhE1Zjqd+QWWHRYQKc9w+n
	Ev0l83AvYq5KsXVoY4r4x+4Y8Ft5hbOJQbTd7gpgjsON5ycVssDLHbkNMPEy0LYZYT7+F49mSXO
	MO7YGHvMfMeO3xZGv8SjkA46n4D2KNwarf8Ycp5h8P8Ch0CXzL4wayw1VL4jX2xUOFr8k9Svf3f
	hjITz+aBwDL2De5EgKDVq2Ac0xwBBf1fmalCvK9XR75UG0PKnWwJXCdyiBo=
X-Received: by 2002:a05:7300:4314:b0:30c:41df:3734 with SMTP id
 5a478bee46e88-30c58c1760dmr5223426eec.22.1782258103394; Tue, 23 Jun 2026
 16:41:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 16:41:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 16:41:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajMPvgA2eHQCj-B0@google.com>
References: <20260615155244.183044-1-alexandru.elisei@arm.com>
 <20260615160901.9A1A61F000E9@smtp.kernel.org> <ajA6ogaNiI3KDv5i@google.com>
 <ajKcDRqT5m069PXK@raptor> <ajMPvgA2eHQCj-B0@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 16:41:42 -0700
X-Gm-Features: AVVi8Ce0E01zo3uw2YUeY9tYq73kkPJeDmWeesJXGCOlSxxJ-xDfRo5Fdwxu5EY
Message-ID: <CAEvNRgE9cLfjDbXuR5wq3fEWZyHxYPxdExxNjXUFO1nT5m==1A@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: Ignore MMU notifiers for guest_memfd-only memslots
To: Sean Christopherson <seanjc@google.com>, Alexandru Elisei <alexandru.elisei@arm.com>
Cc: sashiko-reviews@lists.linux.dev, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>>
>> The KVM_MEMSLOT_GMEM_ONLY flag is set if the backing guest_memfd has been
>> created with GUEST_MEMFD_FLAG_MMAP. The documentation for the flag says
>> that '[..] the fault will always be consumed from guest_memfd, regardless
>> of whether it is a shared or private fault'.  As far as I can tell, this
>> means that, absent a fallocate(FALLOC_FL_PUNCH_HOLE) call, the page is
>> still in the page cache for the guest_memfd file after userspace has
>> unmapped it, so the guest will not be accessing a freed page.
>
> KVM_MEMSLOT_GMEM_ONLY is somewhat misleading, it only applies to the KVM's MMU.
> For other cases where KVM accesses guest memory, KVM still follows the host virtual
> address, e.g. so that copy_{to,from}_user() Just Works.  But userspace isn't
> strictly *required* to keep the userspace mapping coherent with guest_memfd, nor
> is userspace required to make the userspace mapping fully RWX.  And so if
> userspace modifies the VMA, KVM needs to react accordingly.
>
> When in-place conversion comes along, KVM will also rely on userspace mappings
> being torn down before allow a SHARED page to become PRIVATE (for all intents

Conversions explicitly unmaps the pages being converted from userspace
page tables, then checks for users other than guest_memfd. Unmapping
does invoke the MMU notifier stuff, but conversions doesn't rely on MMU
notifiers to unmap from stage 2 page tables, since conversions directly
calls kvm_gmem_invalidate_start().

On a shared to private conversion, if the page was mapped in stage 2
page tables, we'd have tried to unmap it twice (the second time doesn't
actually unmap, but still tells guest vCPUs trying to fault to retry.

So we're good! With this, the first unmap will notify through MMU
notifiers but actually do no unmapping. Thank you for working on this!

> and purposes, we're conceptually treating conversions as free()+re-alloc().  So
> while the page might still be in the page cache, it's effectively been "freed".
> So in that case, KVM really does need to ensure it handles mmu_notifier events
> correctly to avoid UAF.

Just making sure: "handle mmu_notifier events" here refers to
gfn_to_pfn_cache and other parts of KVM that works with memory. There's
no issue with a UAF between mmu_notifier invalidations and conversions,
right?
