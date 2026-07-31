Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19B446821
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513796; cv=none; b=EZeSk+RgFh41DZamnFN9Vl9Y3sFd60o8zz3bOENVu5Alnhug36OrFCb3cEb8JQKrQjBEuZvAsaGxcTA/xE+bOPa7Sa7hlMDit8JVUZuOkajgJsp6hOXqg5p4wSmCEm7a1/xTUAM8wh1qXW3nubQS3r200ItRCRC6fHqMdfWS88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513796; c=relaxed/simple;
	bh=u9Davee5jFiswlNbcoaGtA170sZ3bUH0duryUAj/cpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4iZcaaCG6PSwIkvbKazZQmMFP1SSULauYac7Ck0U4p8V+wb9sR+yDkRtW0bJr4yezX6AMZHbm9fzTMxxLBkHvabtht5SeVIUWH5ipDeB4v0e+8e2roZI57uQ99jBhKEiOQFjbQkjp3ks8nFeR28UGely89rsDgeiVig1DSjIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnDB9mxh; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnDB9mxh"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6823efcso9502045ad.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785513794; x=1786118594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEYbd8TAWmmMUBeZ9IrKbK+p5wVI9/TTz658UxtH1do=;
        b=bnDB9mxhjuWRSP/s73T4mwnHUipPpAPMZrQZZzkVpW2IXwbYQwmhiLTGjSvmwhl260
         h8VyeGik/1AQ9yUZ0MHPDyISXACKcYqhCjUvZuYEgmq/47tFBcC5AJKTcJi6POp9G2Xr
         8Ocl2xzFicktLBamge1Y4sPedrBNsUuSIc/JvlCeJf5/rt7nYLtNtk+tKdwA1EX6JkgT
         IgdpPYMptVT4Mt8WmK9WOBYJiMYRGwZy8CR3eMrS8NqY6/3hqXOB0d47ULAq4BEbEUEO
         rTbAl4HAx4u50/ntdwOhc8Zp+mryKKc2EjlDCvQL1uVIgiB5RYGGcGAPBM8YHdOnwmOI
         zCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513794; x=1786118594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEYbd8TAWmmMUBeZ9IrKbK+p5wVI9/TTz658UxtH1do=;
        b=MzgQgBFANypFlMQEzVcalcttu6whgMB1RpIslcXUz0mh7/B/vRq/mg4UBG+WdwDmf3
         iItkgGZuEXs4j/KPbB7AJfGbP8QfFq99TLqQK6LnKELCguowSq5eyNHI6d8gB8t6vCem
         yIp22spIle8Bz+uiaOMH1Pp7FBWogvq3v1AV3UqDjXfBeKciAz5F8yisaLX2d/nEtURd
         Hav0RnZibgyl4yuSXDMUUTNnkPLKabzdltdFe3AknkuqdhBFW3BUTKSqOs2LdeugjGd4
         zXL6UU99PuREyDtiKkxtJpuSUNC3o207e5XNqFMvR5lpgTfe0TQscAxqxqJFVqk0e3Lq
         2RMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxTleZWPpamHE/PE8bUz+rwJ+MVe0GxhYtoCEBm29dLIhftLTTwliD0q4SdDtzmffq2Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJF9lmEzWOH61kqGWnlL6JIJ4d61Vl6teRL+PMPxq4Os7EvPY
	bfEXVCSQUERAgDsh+4KS/Iq50i85xOc5AZqBHLM6pFV1yHQYJCLd8JodAnsYjEJ8z2ybr4m7tyH
	I2/hVVg==
X-Received: from plhz17.prod.google.com ([2002:a17:902:d9d1:b0:2ce:ab97:2844])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:184d:b0:2cc:a853:1311
 with SMTP id d9443c01a7336-2d05247edd2mr4778715ad.47.1785513793428; Fri, 31
 Jul 2026 09:03:13 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:03:12 -0700
In-Reply-To: <amzFnPEikFTHhW9X@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com> <20260730191908.2084803-4-seanjc@google.com>
 <20260730193350.60B801F000E9@smtp.kernel.org> <amzFnPEikFTHhW9X@google.com>
Message-ID: <amzHQKmGxFf3aeYp@google.com>
Subject: Re: [PATCH 3/9] KVM: selftests: Affine child tasks to other pCPUs in
 hardware disable test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 31, 2026, Sean Christopherson wrote:
> On Thu, Jul 30, 2026, sashiko-bot@kernel.org wrote:
> > > diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> > > index 3147f5c97e943..1bcbd13e99947 100644
> > > --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> > > +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> > [ ... ]
> > > @@ -84,16 +85,11 @@ static void run_test(u32 run)
> > [ ... ]
> > >  		check_create_thread(&threads[i], NULL, run_vcpu, vcpu);
> > > -		check_set_affinity(threads[i], &cpu_set);
> > > +		check_set_affinity(threads[i], &child_cpu_set);
> > >  
> > >  		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
> > >  			check_create_thread(&throw_away, NULL, sleeping_thread,
> > >  					    (void *)NULL);
> > > -			check_set_affinity(throw_away, &cpu_set);
> > > +			check_set_affinity(throw_away, &child_cpu_set);
> > >  		}
> > >  	}
> > [ ... ]
> > > @@ -147,12 +143,30 @@ void wait_for_child_setup(pid_t pid)
> > [ ... ]
> > > +static void setup_child_cpu_set(void)
> > > +{
> > > +	int cpu;
> > > +
> > > +	kvm_sched_getaffinity(0, sizeof(child_cpu_set), &child_cpu_set);
> > > +
> > > +	if (CPU_COUNT(&child_cpu_set) < 2)
> > > +		return;
> > > +
> > > +	cpu = pin_task_to_random_cpu(pthread_self(), &child_cpu_set);
> > > +	CPU_CLR(cpu, &child_cpu_set);
> > > +
> > > +	while (CPU_COUNT(&child_cpu_set) > VCPU_NUM)
> > > +		CPU_CLR(kvm_pick_random_cpu(&child_cpu_set), &child_cpu_set);
> > > +}
> > 
> > [Severity: Medium]
> > Since setup_child_cpu_set() pins the parent thread to a single random CPU
> > prior to spawning children, won't the newly created threads in run_test()
> > inherit this single-CPU affinity upon creation?
> > 
> > Because check_create_thread() spawns the threads before their affinity is
> > explicitly updated to child_cpu_set, they might immediately begin executing
> > on the exact same CPU as the parent.
> 
> Yeah, I was trying to avoid this since pthread_attr_setaffinity_np() is only
> available with __USE_GNU.
> 
> > Could this result in the child threads starving the parent on that single CPU
> > before the parent gets a chance to execute check_set_affinity()? This seems
> > like it might heavily delay the migration and trigger the same CPU contention
> > that this patch aims to fix.
> 
> After far too much testing, the problem isn't direct CPU contention, AFAICT it's
> due to incurring cross-node NUMA penalties, and presumably scheduler contention
> when the pool of possible CPUs to run on is huge.
> 
> I tried a bunch of fancy approaches, e.g. making parent, child, and grandchildren
> all mutually exclusive, and while the fanciness can provide marginal benefits when
> pthread_attr_setaffinity_np() isn't available, all that really matters is that the
> worker threads get affined before they start doing work.

Oh, and I also ruled out wakeup latency, i.e. this isn't the same underlying cause
that prompted 0297cdc12a87 ("KVM: selftests: Add option to rseq test to override
/dev/cpu_dma_latency").
