Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC99353A8A
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081317; cv=none; b=tc3IPexmqkqbYuZoy0CycEDfhmP6fHJExG5J+1IyUd47wX4yjAQb7aCT3d3+6o4p1uKV/q1zSPkD6YttmDwKKIxu5X6YsWloNUpgoQQd29/8qsexrlS/wWOuo2DNPN/id5wGMhQy6iVIbcW2HFG6Asgwn8rrbizwNGRx0km3mng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081317; c=relaxed/simple;
	bh=pGvL+r9yd0UjdhtGaZSmH62uoyKHVNe7h32F5utFz+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h8gow3si1fB/u1xAI5jFEhqUUhSR2bMk6xyzX85Fg5Xl9hmnKcoCAIwngTutnyS+4t+dbEShCY5mgZwZAf7O7IgCE1tVoxjA+mntcN3O020Uo+yhXXzM7xO2/aBc6WMO9qYFtIriwe4uy2p3uxHsmKzQ7nh8O7fh3lBG6TFO4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7LV1wIj; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7LV1wIj"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848568a6f62so345857b3a.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787081315; x=1787686115; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=toqDoqaZ7664JCi45UayITxDmXVJU8MQDeCDLsKOJnQ=;
        b=u7LV1wIjiC283uldP9z9/GabJNzIi2gXAD5b0cnKdPjgaXuVP1U8WS5Mh5UEMowrLM
         GejRsuAgVggLWPPhzeUDLj/JKqF4+VZI0Burqxv1m6vraCw4HnEWB8/pqCr/iTAFdHoq
         Aer2EHgsPBvkQ9JwfpfJRakYhhmvJlYoY7b0ma2zAX8Tmxw/Th32HcwbSB1dL/uzDye7
         Ql4Vj0mehOBx3G30VbidIGXMqeVRyRyrfqjqD098BlAwUyUd8cxbOyomwTAfIzWjyhSM
         GOA8XddyHLq2O/EpksGZuy4sCTYUC6AV+pbjf+9mfcxXMOXfD/px9ordZHzfTUnS8bin
         AMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081315; x=1787686115;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=toqDoqaZ7664JCi45UayITxDmXVJU8MQDeCDLsKOJnQ=;
        b=ZLr3f6jgzRYFNBqSKq+2AEHZfPm1CrqxttX24BifWp5mbQAcROq9oXqCg7NzrL1VJN
         GdXmW5llexp2BMpzlAqP31EgWdSkW0fHVii28xxdZ3BOQoXcU1h9VHHA8J5ZFYm6pAN0
         9tbhVaHlkuhxWz3pXG8ojaKdhUqssx2Hg+byA9lVY83E0t0yVnda3P8XWVHDhHSIzmT1
         dESke2I05STSdnfHyCA1wynjuyGvHgu8Yi4Ns7WE8MSFnapHJCJD5SC895CzRhEKY4Aq
         p0w+fIeecweVfeYo3RZjnFbeombq7YcOPh6oUxAxMeCmBGwaK9UMUQCSbWEwM2lAhkR3
         U6gQ==
X-Gm-Message-State: AOJu0YwAmiSiwVUw7mZ4or0V6+WYH67/5RiS24U0cCmajcm+P9mDil15
	ihWeiMnrg7ITEPxRYcvRqcMRzsIuopqq+DjcV094GoZ+j13eOzlLQyuj7K8H5QdrTYQhQi6Mjy8
	w2htHFQ==
X-Received: from pfbko19.prod.google.com ([2002:a05:6a00:4613:b0:847:926b:dc17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a219:b0:84e:e741:174f
 with SMTP id d2e1a72fcca58-851cd76efe7mr982877b3a.7.1787081314954; Tue, 18
 Aug 2026 12:28:34 -0700 (PDT)
Date: Tue, 18 Aug 2026 12:28:34 -0700
In-Reply-To: <c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803170825.925561-4-hisamshar@gmail.com> <20260817220457.554823-3-hisamshar@gmail.com>
 <aoOKMeua-cNeTxXT@google.com> <8d069fe1-a5b6-4a86-9604-26aebe2dc243@gmail.com>
 <aoSIBnFfy4osa6wt@google.com> <c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com>
Message-ID: <aoSyYtxBpEaoBwGY@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
From: Sean Christopherson <seanjc@google.com>
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

+David for the VFIO thing

On Tue, Aug 18, 2026, Hisam Mehboob wrote:
> On 8/18/26 21:27, Sean Christopherson wrote:
> 
> > Oh, so on top of "https://github.com/kvm-x86/linux.git next", this *is* the last
> > blocker?  If so, then I'll grab this for 7.3.
> 
> Not quite -- I tested kvm-x86/next + this patch with musl-gcc, and the
> build still fails. On top of the steal_time fix already in your tree,
> two more musl blockers remain, both from code that is only in
> kvm-x86/next so far:
> 
> 1. hardware_disable_test.c, from 496779b54943 ("Pre-set threads affinity
>    in hardware disable test when possible"):
> 
>      hardware_disable_test.c:75: error: implicit declaration of function
>      'pthread_attr_setaffinity_np'
> 
>    The call sits under #ifdef _GNU_SOURCE, but lib.mk defines _GNU_SOURCE
>    unconditionally, so the path is always taken and musl (which lacks the
>    function) breaks.

Heh, Sashiko flagged that as problematic, and I was trying to figure out which
macro to key off of[*], but was (obviously) unsuccessful.  I don't suppose you
know the canonical way for checking for support of glibc-only functionality of
this nature?

[*] https://lore.kernel.org/all/am0KqJOD-FiC9BXs@google.com

> 
> 2. The libvfio wiring from a262fc49e0aa ("Build and link
>    selftests/vfio/lib into KVM selftests"):
> 
>      vfio_pci_device.c:25: fatal error: uuid/uuid.h: No such file or
> directory
>      sysfs.c:31: error: implicit declaration of function 'basename'
> 
>    The former adds a hard libuuid dependency (its headers aren't visible
>    to musl-gcc here);

Can you elaborate on what you mean by "its headers aren't visible to musl-gcc"?

>    the latter because musl declares basename only in
>    <libgen.h>, while glibc exposes it via <string.h> under _GNU_SOURCE.

IIUC, sysfs.c just needs to explicitly include libgen.h?

> The rseq __GNUC_PREREQ failure is already covered by my patch in
> linux-next. With the above sorted, the musl build passes.
