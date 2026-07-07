Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E131280D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433057; cv=none; b=VWAIloojC+nANRxjOhPXAtn4j2VNtJXJjIn5TTugdQSy4Boecr/v3eabaeHGjEiLjw7QIke5tkwd5PLWFZK0GU3RurwajJGtszkBsPmdeuVqmSKw5QsooBDdMM8e5U1F69ogV34GHUcejpqgjaJPxlsaGDnlxllpcdtlxTNvVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433057; c=relaxed/simple;
	bh=IJJeqWWOz8cYTacN6NYsMTZL3vplCvTu/9nq4A9sIOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YnlNfz/3DtrBFpXUxz1BLbtwMT3YG61RV1UeIJYZoI5CrGn04sZOGW+37DRCwJNQXKKOBOxoHNzcggYnipihAQ3rYZ2oEYjV7bCWrRxvt6ttQVeLN2G+pnRwB5dtKj9fh2D6I5d2ZAaB60sLvHlZ2BaMuOAi1g93iQ5G5BViEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2fIJ0Gy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2fIJ0Gy"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ccd1958e8fso6733725ad.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783433054; x=1784037854; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaRRPm7rRenJCz4WhvXhn/Su3WW8BYkGJwkilHjufHw=;
        b=h2fIJ0GySce2E0H0xWqTmytTVaFyLwbYQbfY8uTMPw2ep8QOgyEw1oZtkvtFB70NNi
         zvTdte1pUIp6HkBijBdnqS7ykP7SRL5kLrwGNSPQg2biiDfhk4UugUe5DGzM24mXc167
         x2R5mWCkpyzfAGc+8W8zbjqlidBXyKg+U+sQJpBsW4SKblIuU+bIvtvYqey/xZb0Zx+W
         OONynNDHOu/DUHIpBbqKmr4uGY37ndDjvUY8ueceKDGWA1mJsW/CcZTlfw+Bv/YKjrJs
         sT1CT+nd28Ozn1CkGc7dBiZSB81IcSp/zdB+lR9x4eNRON1prOx0w0mqzvnVPXGJZ6fh
         pIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783433054; x=1784037854;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TaRRPm7rRenJCz4WhvXhn/Su3WW8BYkGJwkilHjufHw=;
        b=d+gC2J06U+Y+6Y7nI0Nl98hBj+tQJQrikXJGbWtPBmiSEbwLX0VbG78DoKgYoMQUWw
         mROHrWvbHjbMeDP28MGfKPKYrrl6+M6oo+T0EYbdUyvmEwC0YqdparT8vM1LVzudtAYo
         ou8nBlD2Q7eamrVnG+yTXn693Y40BMEgpTbvJXMSWkhQ8v/dDLvCHz6rI/4XafKCu9sW
         5zELjark6FZ+Y2c9dPEeuAzQf2luCqmYUGRYh0mbcoG4v1gHziNuHmyoxEPYyHMs8pYD
         yimZ2qE4UMhUrvXvKTpzfeqn+2+XMKqpjiXmVAIzh4iTSRVKlZCiY9wqaOEaBy+mAVpj
         cE6g==
X-Forwarded-Encrypted: i=1; AHgh+Rr3MfiUXgcwKzO31Givyg0q0L3RH0gckYw7ALOeE76Lp/R06WoXTk0hob0eohAa2aFhtNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wne0wq9a5eZYJ0ik9eeRI3xtpga3ej1RykcoEWYC1XD2ceP8
	g2FfphCrPKeVdOMEJkRtUCUSXOmul2AEiBW5EKLhqbXymDDCgVklVCDsKBHwM3OlGr0KxPGC+7K
	2mSu8gQ==
X-Received: from plrf2.prod.google.com ([2002:a17:902:ab82:b0:2ca:bb5b:3c6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec85:b0:2c6:a012:6241
 with SMTP id d9443c01a7336-2ccbe3f7d69mr56668875ad.6.1783433054149; Tue, 07
 Jul 2026 07:04:14 -0700 (PDT)
Date: Tue, 7 Jul 2026 07:04:13 -0700
In-Reply-To: <20260706164913.3A7A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706163649.155548-1-hisamshar@gmail.com> <20260706164913.3A7A91F000E9@smtp.kernel.org>
Message-ID: <ak0HXd8HMyKDCU1U@google.com>
Subject: Re: [PATCH] KVM: selftests: Use KVM's task pinning APIs in steal_time
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Hisam Mehboob <hisamshar@gmail.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Race condition causing intermittent test failure (ESRCH) due to late thread pinning
> --
> 
> commit 27b6bbfae99d5564cda41cbc7b8c36c7b9a4ed64
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Use KVM's task pinning APIs in steal_time
> 
> This commit updates the steal_time test to use KVM's task pinning APIs
> (pin_self_to_cpu and pin_task_to_cpu) to pin the vCPU and stealer threads
> to pCPU0. This removes the use of pthread_attr_setaffinity_np, allowing
> the test to build against non-glibc C libraries.
> 
> Link: https://lore.kernel.org/all/aLIroyJSWQ26wnY4@google.com/
> 
> > diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> > index 76fcdd1fd3cb4..19a97d6a36076 100644
> > --- a/tools/testing/selftests/kvm/steal_time.c
> > +++ b/tools/testing/selftests/kvm/steal_time.c
> [ ... ]
> > @@ -558,7 +552,9 @@ int main(int ac, char **av)
> >  
> >  		/* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
> >  		run_delay = get_run_delay();
> > -		pthread_create(&thread, &attr, do_steal_time, NULL);
> > +		pthread_create(&thread, NULL, do_steal_time, NULL);
> > +		pin_task_to_cpu(thread, 0);
> 
> [Severity: Medium]
> Could this introduce a race condition that causes intermittent test failures?
> 
> Since pthread_create is called before pinning, there is a small window
> where the child thread (do_steal_time) could execute and complete its very
> brief 200us run before the parent thread executes pin_task_to_cpu.
> 
> If the child thread exits before pin_task_to_cpu attempts to set its
> affinity, it will return ESRCH and trigger the TEST_ASSERT inside
> pin_task_to_cpu, abruptly aborting the test.
> 
> Is the explicit pin_task_to_cpu call necessary here?

Nope, which means we can simply drop the problematic pthread_attr_setaffinity_np(),
though I think it makes sense to add a sanity check that the worker did indeed
inherit the affinity, if only to document what's happening.

I'll send a v2.

Thanks for posting this Hisam!

> Since the main thread already called pin_self_to_cpu(0) earlier, the new
> thread created by pthread_create should automatically inherit the parent's
> CPU affinity mask.
