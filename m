Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA01A6819
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845073; cv=none; b=D6wYx88FMZQOltvbXAqXVCzXqvR6cLf1cSJL4KZVPrLYCQuaJI0TtkbqIfkPnQuQGRIOpnAfaZ/egw01Lf4Ym8fDIYvDhIH0O4r5f+9D10/hoyDYoq9WSInDKMteZdW3cCKy1WYxoRWbwZhCNbJ7+4V6CFSnlOLs6Ds6AtrA0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845073; c=relaxed/simple;
	bh=Yz8iskg8XrvH8zht98Z9Xue2l61E2u+0pLn94aBTjCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fpxfr5jYSmkkWjIXYxuOh1XlPpuQErq2NGSiSH+SB0myom1kvfsXUi/OSKqlF7BXCZ/rhYxdiq2dsqC7QF0iQ/U8SciXA0psjgrnPvs8PDDViTGJRzyXe3QQ4zWfsI4KDfRx07q9eZotJ4lQghxs712nFYzOhH1PJ3P1WskB1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dILOrnGH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dILOrnGH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8531d89e59so2364302a12.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779845071; x=1780449871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFIl8jD03qcpfdb58Bma0Y2iIu1xFf/+T8XEkiPDXfI=;
        b=dILOrnGHaTBD5BN2ASIlreuR7dy+n/NI1Wj+S3HHbw+N4OoXXXQpfkmFUM777x6xfH
         JvjLacmDRlFx/Lq8IwBwbSAEsqOX2lzN48lW4q0hyuy+SXwlJe1KwgN+QIHPN/MfR5Q1
         V7AmRoCWXdHebrWgWo5CR1sb1ybLPgHrNgPU9cQevdz259PwstE2W6yfFBqNDxB0uibA
         hecyeC9yThzB3Zqlm3kTwGLmmPiRhTy8JyVBwKZp/7xPo27wjY4IzrH2TVukDCnbO6CX
         lYlooko33nSRxHshwzXxRMVU+sqJe/EGTlbHrwFUYgK7bzRMVyjw1sINNksgJluuXzMw
         /6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779845071; x=1780449871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFIl8jD03qcpfdb58Bma0Y2iIu1xFf/+T8XEkiPDXfI=;
        b=bEYYZYqoqO4s/rdDcSTR4J1HzByrVz4a8U3ixLgj8rQyFu+FRRAJMpU0N/rORg2fwa
         OIUzhhmHQ7SKvfEjL87nPiU7QAUKpDwGWgTXOQAd8ODP4UgTyOCkc/XOH6hvtLs6Q6/e
         /owse9BoPy5CaMlNc0iOsX6H0r47cC+ThVtQhsymHCR800l9CLhCNnOCsTpjggjVzrZv
         aYT0/CD0j9hkamBlCKgJISlT2dpyi44MPV9KQympfJ+zgyu1U4xHLyU/TdOMGuzsS43S
         bdKWCf5DEjF74+CIaFiB2bfFHxmnA8HIOq/ktFVZI0hj7UgvjHR4Gis1e0wrv2femsyT
         oVpA==
X-Gm-Message-State: AOJu0Yyen5QXFUZE2TVTogWacLlK+u24WlIASrtQLxXnJrXAmrez3LOZ
	kcY5B+LAaaepTOXJRzCk+6BTPoSwWXPsCs+xZE6ZwA3BmZ/VWCZFrxbiclAvOtJatY5ENqBtPKa
	MOoEeSw==
X-Received: from pgbbk8.prod.google.com ([2002:a05:6a02:288:b0:c82:cd84:79d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1518:b0:3a2:edff:2975
 with SMTP id adf61e73a8af0-3b3297b0e28mr15979655637.25.1779845071015; Tue, 26
 May 2026 18:24:31 -0700 (PDT)
Date: Tue, 26 May 2026 18:24:30 -0700
In-Reply-To: <20260527004457.3F0B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527002910.3931382-1-seanjc@google.com> <20260527004457.3F0B81F000E9@smtp.kernel.org>
Message-ID: <ahZHzqfVJmwV8wzY@google.com>
Subject: Re: [PATCH] KVM: Delete guest-triggerable (in theory) BUG_ON() in
 ioeventfd datamatch
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> > --- a/virt/kvm/eventfd.c
> > +++ b/virt/kvm/eventfd.c
> > @@ -779,9 +779,6 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
> >  		return true;
> >  
> >  	/* otherwise, we have to actually compare the data */
> > -
> > -	BUG_ON(!IS_ALIGNED((unsigned long)val, len));
> > -
> >  	switch (len) {
> >  	case 1:
> >  		_val = *(u8 *)val;
> >  	case 2:
> >  		_val = *(u16 *)val;
> >  	case 4:
> >  		_val = *(u32 *)val;
> >  	case 8:
> >  		_val = *(u64 *)val;
> 
> [Severity: High]
> With the alignment check removed, can val now be an unaligned pointer when
> it reaches these casts?

Obviously.

> Because dereferencing an unaligned pointer directly is undefined behavior
> in C,

Ugh, C99 ruins all the fun.

> could this lead to alignment faults on architectures with strict
> alignment requirements, given that this is in architecture-independent code?
> 
> If a system is configured with CONFIG_UBSAN_ALIGNMENT=y and panic_on_warn,
> wouldn't an unaligned access still allow a guest to trigger a host panic,
> leaving the original issue partially unresolved?

LOL, good luck booting with CONFIG_UBSAN_ALIGNMENT=y and panic_on_warn=1.

> Does it make sense to use the get_unaligned() helpers here instead of direct
> casts?

That does seem like the easiest solution, as this generates identical code
before and after, at least on x86.  The other easy fix would be to use memcmp(),
but I like not actually changing the functionality in any meaningful way.

diff --git virt/kvm/eventfd.c virt/kvm/eventfd.c
index 0e8b8a2c5b79..93ad2ebc963f 100644
--- virt/kvm/eventfd.c
+++ virt/kvm/eventfd.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/seqlock.h>
 #include <linux/irqbypass.h>
+#include <linux/unaligned.h>
 #include <trace/events/kvm.h>
 
 #include <kvm/iodev.h>
@@ -779,21 +780,18 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
                return true;
 
        /* otherwise, we have to actually compare the data */
-
-       BUG_ON(!IS_ALIGNED((unsigned long)val, len));
-
        switch (len) {
        case 1:
-               _val = *(u8 *)val;
+               _val = get_unaligned((u8 *)val);
                break;
        case 2:
-               _val = *(u16 *)val;
+               _val = get_unaligned((u16 *)val);
                break;
        case 4:
-               _val = *(u32 *)val;
+               _val = get_unaligned((u32 *)val);
                break;
        case 8:
-               _val = *(u64 *)val;
+               _val = get_unaligned((u64 *)val);
                break;
        default:
                return false;
