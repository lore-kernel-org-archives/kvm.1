Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71B7262E
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443066; cv=none; b=PKm0174CMJTmL/Y3RV8hII/UgWfPR+9nND+VRTuo4qWh9ILa2NYgQluteaSen8luezp2Qzq50bzcM5Rv8sRTEKQPMZyKh1baQcDmErAfx79oM3sxO7HcDARsYMLePA5BrKSa7gfWK8NMjWAWPUUoYiJODRTfc96xEU95dNps/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443066; c=relaxed/simple;
	bh=gXSPYdsXecirkIEGeu3WOkr+wc9b/nFJSCR/RoTgme4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ieHXlU4eRbSGt5kl/O7NCfWSfYlCGcIMRN0JNZ4/szvVtK4KuaLaXsz0ltkyljsTBVFTomRkW0TUqyBVm1B84uzXJwDpR8GRKoCFSbvuc08aS1KZyiW2YK0DPpx37TLRF43iY36y/fFD0f/3Pwyn160VqSMeU5HC5QeLg8Dy9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bseR2YiD; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bseR2YiD"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84870e7f498so260790b3a.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785443063; x=1786047863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrtiBmboLLsPIIH2ER5IgQHpTzlTWLaZtWKiYKxuQYo=;
        b=bseR2YiD4GFemxhaOWJuIaVv31hJwMopU+YKQHxfkW+sI0CxYdpFX0GX2YCXV9ulnh
         wP1bSmFpyPMZrGe24go0FMUvAz7MU/85+IbV2Q3/Vc25ShpikbcZya6vVNi0bAPXILdj
         iEiSmmNsjQw1qL+goGYkhaL3v4upCimBpKu1ANFrjQUGpv2n/1uZG0TS7jKlAmvR31ND
         XhvlgF125jL2dAish0xlGdgS26xTxZPgl+LUk2dG7hmUuR6m5TDwhwEqKlm7DpSIHpJi
         8lKt3C9kzVFTOW22TdUtSB/E1Mkdu67hMnsz+hxrHZkOEf5sDgEQiSv1hKuhZJLXyU3z
         S4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785443064; x=1786047864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrtiBmboLLsPIIH2ER5IgQHpTzlTWLaZtWKiYKxuQYo=;
        b=mjRJTE9G/hCYjzI71piHuN+/6pWTX4PKIGTuWW3pV1BixNKM1oqrNyZbdQd+NzAE4v
         baDAO4EeLBnEgg+2lTF+NWKQJwiFbdOSnubIFoTiyF/jPPKUfz8P9kHw6gTyilLgHaQ1
         qZe4zGsoKmYpqsGKagny0Is5nnJNb7aY9R69GjkBjOdFP95C8AGuwOs+RsKwyBPmwPCi
         pYsg2IXVRVeAP1j12UxVVh7QBpzRaGXybqWe6En11y9g3bFaxPpx2TGGAhDwDaDTy6Vi
         FEMOyFAlTyrTy/ikZA92yr9ZFtulw/pBmrScJnKrYnu71O2moOlU95jM3XIVQlN6b9CW
         YzGg==
X-Forwarded-Encrypted: i=1; AHgh+RrtWqUVOiEq07yYOzbos1GtE3UecxoiqEYgw2yhl1VWvbMyBPPoyn1FLcjAgvOqB1yNskU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bIc0eZULpgQIuODZNxMcDS8wdDyOSo+V2edD8g313CBFHT1w
	uIYWz5OahLvyk3WRZ8tDYJYbEGOlzLhJB0X4V1TdrsHXZCxgkGJ7Ipe+PlPb12BIkp9MdmoecJc
	JQrCOTg==
X-Received: from pfx52.prod.google.com ([2002:a05:6a00:a474:b0:84a:6b32:7768])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:929e:b0:848:82f0:679a
 with SMTP id d2e1a72fcca58-84ebc3e247dmr3708347b3a.52.1785443063292; Thu, 30
 Jul 2026 13:24:23 -0700 (PDT)
Date: Thu, 30 Jul 2026 13:24:22 -0700
In-Reply-To: <20260730192929.ACE681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com> <20260730191908.2084803-9-seanjc@google.com>
 <20260730192929.ACE681F000E9@smtp.kernel.org>
Message-ID: <amuy9j7XHfyAXMac@google.com>
Subject: Re: [PATCH 8/9] KVM: selftests: Add KVM syscall wrappers for pthread_{g,s}etaffinity_np()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KVM syscall wrappers for pthread functions produce misleading error messages on failure.
> --
> 
> --- Patch [8]: [PATCH 8/9] KVM: selftests: Add KVM syscall wrappers for pthread_{g,s}etaffinity_np() ---
> commit 9fc7623d339b95135fb5ecb9685356bc8dff9829
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Add KVM syscall wrappers for pthread_{g,s}etaffinity_np()
> 
> This commit adds KVM wrappers for pthread_getaffinity_np() and 
> pthread_setaffinity_np() to simplify selftest code. It removes the need 
> to manually check for success or supply the size of cpu_set_t in the tests.
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
> > index 002b5a4e59eb2..3d82351bef92e 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
> > @@ -97,6 +97,22 @@ __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
> >  __KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
> >  __KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
> >  
> > +__KVM_SYSCALL_DEFINE(pthread_getaffinity_np, 3, pthread_t, thread,
> > +		     size_t, cpusetsize, cpu_set_t *, cpuset);
> > +__KVM_SYSCALL_DEFINE(pthread_setaffinity_np, 3, pthread_t, thread,
> > +		     size_t, cpusetsize, const cpu_set_t *, cpuset);
> 
> [Severity: Medium]
> Will these pthread wrappers print misleading error messages on failure?
> 
> The pthread_* functions return positive error codes directly on failure 
> rather than returning -1 and setting errno. If __KVM_SYSCALL_DEFINE formats 
> its failure messages assuming errno is set, failing to set affinity could 
> result in printing a stale or unrelated error string (such as "Success") 
> alongside the return code, which might impede debugging.

Empirically, no.  Just because they _also_ return an exact error code doesn't
make errno invalid.

==== Test Assertion Failure ====
  include/kvm_syscalls.h:117: !r
  pid=155681 tid=155681 errno=11 - Resource temporarily unavailable
  pthread_create failed, rc: 11 errno: 11 (Resource temporarily unavailable)
