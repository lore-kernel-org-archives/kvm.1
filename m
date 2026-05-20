Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D722E2F1F
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240605; cv=none; b=J1Ga5KsyEN0ZqKy9emP32Sw6ALutmtDL9ePoY4LhUq9tPbMcb/dB92vk8DvlyAZFmCaUPR9jo/l5gNUWRK6ZLdeWB+x8nVTZSJyoEwV6CVHfkSv6Y8eGCIivDX4mdyhl9SETaWBD2f5/pgs1c1vbo9w50ts4rotACHqdmoAH2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240605; c=relaxed/simple;
	bh=ubOodUSKcJ1/y9oow6uWeFYJFtZ2QnqrWJTE+k9m+Ok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bazYHRgZSIl6BlwP3zpYb/r1hjSajawMLVRSVaZNvwK+drCWTw7Rlgan0W15LrD7nIQWXdXqEknKL+V8cWaMhGB7m5H/1y62D+eKsbR8eBQibSO7JUeycC0zDGntgzgp+0EcE5UNgZhXuhdaWGF0lX0MkmMGsetm0j7Nb4LuryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAbolx47; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAbolx47"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba3245a43dso44123905ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 18:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779240604; x=1779845404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qp54c/4wUTftii6XW1KYYbLhBO3nSriCnGC/yZkGmWM=;
        b=SAbolx47UsdZgqVObRmPFlHvXXIMZTwYQ/WtDdqdvV47WC5JMXFgroU6rcRkXFyAOt
         HfJKFcjajnY1FoULSfeHxHM5nL0k0vdTZKB2frgaXXK51oq9faDer/1e+DMyxK6ZaXGU
         CPvJFNf5hCH3Iu7XogaqLEUTs+NIB1E7sFTb9QJ9nX5iw8PuXF4lygXejd+Gl/R4WeYu
         jZJNxiOlbMnegmqpPbtpVINUK8v84v2d+0a43uh3iFam2AoxRsLfjvfKRFIxMj4EQlnS
         +umi++eIDGDSMnwWwdu6BkKnnnDex5v/NuexmMTZ7ae4cauoPfe6S5SgXSqxcaKSuTJ8
         2YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779240604; x=1779845404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qp54c/4wUTftii6XW1KYYbLhBO3nSriCnGC/yZkGmWM=;
        b=Y+B8YiyXeclJij8Q+A84SMElKDQn8MuJhlVFJOgLfwdQmlM7hy1VL9CEq8agTTX+YI
         EdLZOMbWC7gxOhBC85VbrrrcAAIv/A5fL/zA5g1uFTGDSTTcQqZKLQqOfO28lfTnTwBB
         ZF8UIJSbaUdNs3lMm+FJNOQI4euzEjeDuQRllE3rUbeJp4q/5nrZi1dhyQJeP6xFsAg2
         lY9spzHfDr4aDnMFD01JhnJiNT+rzKt7nVOSraw8HInm2SiFqNVwakCooKDqFyyLOSVI
         BFHuoWUD9jKzhOlT1oyfIY7y2mjMlIq73vYbuLaJaaOT5E4xRAFM5fop+ixVmfqmfWoM
         EVLg==
X-Gm-Message-State: AOJu0YwkHCIlXb3sqIwFFxU2xKWS0FXGgScShl/NVxclNhnW2lAQyBIJ
	kAIQ2jYqk0bl4CObpZLgpkD2Tf4PPmklMuipqzNE92UQraWHc337y/rHrWfq8FQtvkcDwa0wAfD
	FC6ORSQ==
X-Received: from pllo21.prod.google.com ([2002:a17:902:7795:b0:2bc:bb0f:91a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a87:b0:2ba:4eee:6c1e
 with SMTP id d9443c01a7336-2bd7e8214d5mr231898115ad.15.1779240603599; Tue, 19
 May 2026 18:30:03 -0700 (PDT)
Date: Tue, 19 May 2026 18:30:02 -0700
In-Reply-To: <3d357a67-b1e0-4204-8748-a926ced24c5c@grsecurity.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com> <20260514210500.1626871-5-seanjc@google.com>
 <3d357a67-b1e0-4204-8748-a926ced24c5c@grsecurity.net>
Message-ID: <ag0OmjV_1q9D5QAQ@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 04/20] x86: Dedup guest/host context
 switch of registers across SVM and VMX
From: Sean Christopherson <seanjc@google.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 19, 2026, Mathias Krause wrote:
> On 14.05.26 23:04, Sean Christopherson wrote:
> > Deduplicate the context switching of registers across VM-Enter<=>VM-Exit
> > between SVM and VMX.  The required functionality and implementations are
> > practically identical, literally the only difference is that SVM doesn't
> > need (or want) to manually swap RAX as SVM automatically swaps RAX at
> > VMRUN and #VMEXIT.
> > 
> > Opportunistically rename the structure to "guest_regs" to clarify its
> > purpose, and to avoid conflicts, e.g. with realmode's "struct regs".
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  lib/x86/virt.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  x86/svm.c      |  4 ++--
> >  x86/svm.h      | 47 ++++-----------------------------------------
> >  x86/vmx.c      |  8 ++++----
> >  x86/vmx.h      | 42 +---------------------------------------
> >  5 files changed, 63 insertions(+), 90 deletions(-)
> >  create mode 100644 lib/x86/virt.h
> > 
> > diff --git a/lib/x86/virt.h b/lib/x86/virt.h
> > new file mode 100644
> > index 00000000..ccc90c25
> > --- /dev/null
> > +++ b/lib/x86/virt.h
> > @@ -0,0 +1,52 @@
> > +#ifndef _x86_VIRT_H_
> > +#define _x86_VIRT_H_
> > +
> > +#include "libcflat.h"
> > +
> > +struct guest_regs {
> > +	u64 rax;
> > +	u64 rcx;
> > +	u64 rdx;
> > +	u64 rbx;
> > +	/*
> > +	 * Use RSP's index to hold CR3, as RSP isn't manually context switched
>                                    ^^^ that should be CR2...

This one should be CR2.  CR2 isn't context switch via the VMCS.  Ugh, but looking
at the usage, I think this has been dead code since it was introduced in commit
9d7eaa29 ("kvm-unit-tests : Basic architecture of VMX nested test case").  I was
just reverse engineering the intent when writing the comment, and didn't actually
check to see if KUT does what someone intended it to do.

nVMX likely works because no test takes page faults in both L1 and L2, i.e. either
L2 doesn't care about CR2, or L1 never clobbers it.

Hrm.  I'm leaning towards deleting my comment and maintaining the status quo, for
now.  As tempting as it is to fix the bug, nSVM doesn't need the help, there's
zero reason to context CR2 in assembly code, and I doubt a test will ever rely on
CR2 being context switched.  

> > +	 * by software in any relevant flows.
> > +	 */
> > +	u64 cr2;
>             ^^^ or this one cr3?
> 
> > +	u64 rbp;
> > +	u64 rsi;
> > +	u64 rdi;
> > +	u64 r8;
> > +	u64 r9;
> > +	u64 r10;
> > +	u64 r11;
> > +	u64 r12;
> > +	u64 r13;
> > +	u64 r14;
> > +	u64 r15;
> > +	u64 rflags;
