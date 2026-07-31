Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176084399DE
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513376; cv=none; b=aZ6tnIk19vQo13fBVFSBhOA4EixBf0zWYiyQWuUfVthdXdq/PDt9GANtGssmT/mZpP2VeI2+z/x9GKPxyHS0HVx8QAtkherbBC1hWp7HsWU/VGMfc9jBY1Tqkr6uzImoAmdbPTtKbMd9KGrIxSiks0ziI84F63SThtay3Qk3z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513376; c=relaxed/simple;
	bh=WGhV3M5EiiSM57qbmHhxLbuYTAc4xNJTox/ibDHaE4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BI9FNmeRqCGLcXfFMIhLhKduLwzYxoO5Wee4OKoXIqmzW3o3VwX1vgBtFkvw6nfYiwp1icvWubMk6aQvDQ7l8PdeImPLnbw1Rk5nf13l1zYtaatXSAZ0Xpkxdsetdvc2ZJjvYmEbw7q3KH9+sDI8PNFJ6acpjDqYhhStJZ091kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxS3naGQ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxS3naGQ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfa4e4684bso27465415ad.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785513373; x=1786118173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MeH8PMDYJdhxZAkOjUCN37GF4BiM7iUBixl+LFEnzM=;
        b=oxS3naGQACBqPpnIFgx8b/cmkfNV+6r7G0BilGnuKnWr+2u5isEzABSv50FK5InIHY
         d04FPeEUt6qwvvUlmnbh9kkZYcl5HSjxBnCRGCf0VwF8T/vjMeKLf2WqBhNKpfSs4bo4
         +wotMRKzw0ZQKhKwt12c9Y9w01TbywP1LSb+cTUilrrpQUNBXAHsQiQWUBLLauNp3Kp7
         p8hcWuQXNpgMbU+y6v+p7CzWCw4dTsz77vpGjw3cBQ89ZN36/5RaFftb7m+4lqaGSD4Q
         FvYZZD4xXpoaCbQeHhQ36wx8KwT5RmyxE0JOk7tMrUrTX1Ndd6FcRN59D57bV6WwrmfH
         Dikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513373; x=1786118173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2MeH8PMDYJdhxZAkOjUCN37GF4BiM7iUBixl+LFEnzM=;
        b=inIi/DWvqsuJpKM31JEvO73N92378tO4glzb5+kKQoQa4C7SnzU4nBuQJOp88p7f40
         lHmBzoGIfXhxocnfJlnmruanu/6hvguW9QbS2UOV3AgwyzDapxwhKgO1qGigMSoEoEaX
         QapvBfXsXJw6hoJSg68rx8hjqgIQTvOEMctgKcc6kfgfGSdpcthMW95DRoZubpdUPUDD
         VPM5BsHcpgLbPrC2Qfa8lIkI3JPapit33smIP+lNeZ/4Qd+RYRkB2dfwgKe1BKjfxviA
         ddrScnp/UPLHyukiDsUk7q+CMKIgzJHoJmSAL3Fk6o8EayCoLLmCOLTyeC29VvyqeCky
         X7iQ==
X-Forwarded-Encrypted: i=1; AHgh+RqC5uf8zn17tcjeNkUt2p1xFovdZRPkzR9N5kXU1paJwjHgwbSsPswV+p0tYBelOPdFosM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylyjcNTU5inQFSQkZWemWp0sWrSxpaN58M1TMmwfO31aPSAKIy
	XxHLwNJF0HNPXgSqnkUBGgfL5QTI3857PDrCSPMmWulSo1twdK1R+mioELKpeq64vuPI4GGRjxw
	aiN/9UQ==
X-Received: from plbml11.prod.google.com ([2002:a17:903:34cb:b0:2ca:d246:c7c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f45:b0:2cc:77f3:a934
 with SMTP id d9443c01a7336-2d05242c56fmr4444575ad.46.1785513373143; Fri, 31
 Jul 2026 08:56:13 -0700 (PDT)
Date: Fri, 31 Jul 2026 08:56:12 -0700
In-Reply-To: <20260730193350.60B801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com> <20260730191908.2084803-4-seanjc@google.com>
 <20260730193350.60B801F000E9@smtp.kernel.org>
Message-ID: <amzFnPEikFTHhW9X@google.com>
Subject: Re: [PATCH 3/9] KVM: selftests: Affine child tasks to other pCPUs in
 hardware disable test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> > index 3147f5c97e943..1bcbd13e99947 100644
> > --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> > +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> [ ... ]
> > @@ -84,16 +85,11 @@ static void run_test(u32 run)
> [ ... ]
> >  		check_create_thread(&threads[i], NULL, run_vcpu, vcpu);
> > -		check_set_affinity(threads[i], &cpu_set);
> > +		check_set_affinity(threads[i], &child_cpu_set);
> >  
> >  		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
> >  			check_create_thread(&throw_away, NULL, sleeping_thread,
> >  					    (void *)NULL);
> > -			check_set_affinity(throw_away, &cpu_set);
> > +			check_set_affinity(throw_away, &child_cpu_set);
> >  		}
> >  	}
> [ ... ]
> > @@ -147,12 +143,30 @@ void wait_for_child_setup(pid_t pid)
> [ ... ]
> > +static void setup_child_cpu_set(void)
> > +{
> > +	int cpu;
> > +
> > +	kvm_sched_getaffinity(0, sizeof(child_cpu_set), &child_cpu_set);
> > +
> > +	if (CPU_COUNT(&child_cpu_set) < 2)
> > +		return;
> > +
> > +	cpu = pin_task_to_random_cpu(pthread_self(), &child_cpu_set);
> > +	CPU_CLR(cpu, &child_cpu_set);
> > +
> > +	while (CPU_COUNT(&child_cpu_set) > VCPU_NUM)
> > +		CPU_CLR(kvm_pick_random_cpu(&child_cpu_set), &child_cpu_set);
> > +}
> 
> [Severity: Medium]
> Since setup_child_cpu_set() pins the parent thread to a single random CPU
> prior to spawning children, won't the newly created threads in run_test()
> inherit this single-CPU affinity upon creation?
> 
> Because check_create_thread() spawns the threads before their affinity is
> explicitly updated to child_cpu_set, they might immediately begin executing
> on the exact same CPU as the parent.

Yeah, I was trying to avoid this since pthread_attr_setaffinity_np() is only
available with __USE_GNU.

> Could this result in the child threads starving the parent on that single CPU
> before the parent gets a chance to execute check_set_affinity()? This seems
> like it might heavily delay the migration and trigger the same CPU contention
> that this patch aims to fix.

After far too much testing, the problem isn't direct CPU contention, AFAICT it's
due to incurring cross-node NUMA penalties, and presumably scheduler contention
when the pool of possible CPUs to run on is huge.

I tried a bunch of fancy approaches, e.g. making parent, child, and grandchildren
all mutually exclusive, and while the fanciness can provide marginal benefits when
pthread_attr_setaffinity_np() isn't available, all that really matters is that the
worker threads get affined before they start doing work.
