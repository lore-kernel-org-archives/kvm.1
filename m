Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C623033C6
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290847; cv=none; b=fMHxOQ14K2SBRF2wRrK9aHaPRDu6IfF2g6m9Dyad5UnqMgD0jCveBHIPNs/GQ26YXgBMi9dmswVFiOIR/FsPgfGPUXBQFzZ7uQOg1FhSLsbO4fWVKiZ9cYPOE3+INcWGVTO0DolmTTp7foqhZfnh6wpz3x3teTLxwL7emE5oRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290847; c=relaxed/simple;
	bh=tweE/B5iRx4WqCmZC5jUJFMzY9zDXaqivSkzvGtJbn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qc0F5Kl/Q+awUmY/P5UeJZdOv8YvwRifY5FG/CU2qrx6VJqB/45Satt+IjP9yMMSEn0ocJLXkkBgYfxZLewVVn1lKUbDaUlKPopExpldrUz5/t+repMDIuMmMxG/F3VQYUYqm640tAxESLYingLchMMWSuWEyujmZpYgJImZeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jl75T6B6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jl75T6B6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so3888121a91.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779290845; x=1779895645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhkgzLIvh7n8FBkLDCvvyoRLLy05jqAaJJsIAGt7tN0=;
        b=jl75T6B6IX1JoAbAqro0d025vtLPgZ14owh3pQapzTDfGVO2G3FwRjt4BM2yDF2yVG
         SKFSQY/UDRvxrHvCvnIlfdkeuE16jX548emLlFaqCZytPiRw0cU2vS3jU3xAMdQ0BvMR
         rGNV7Q5wfOUNsu6PZgWfzIJxQPKhe3cbYnHpQ0z8dHOaQlIiLYH9YS6cb+2pygvZ1TyU
         dN/EE1UYFf4QPlj85M75tCtIj8g9okNKSYPAsFNuo0VQrzwR3b4bYPZiqKATWFJCgyb5
         PvYNFFyszPF/lQmWEVYhb5yWQjpbE7KqhtyNqXtMALHW5Qy7hdBvvrsl7dtdEJWuscw7
         sX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290845; x=1779895645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhkgzLIvh7n8FBkLDCvvyoRLLy05jqAaJJsIAGt7tN0=;
        b=gy6xT8IjnV10Zb6moA9020O79s0Ka6axasV5thfOOSGXjiaYP23UFA3Tbyd1yzmnzT
         RTp1Eqme9p/FP+ZN7ET35Me/k11v6zd2nW/ouMP0cmP0y2lX90kKkWR3/wlaYfcrDbC4
         7Lh73bvOaAyY9DJMvsz/EfGrKKYLueUmqjULHMv/ASUEoNmpXLZbTxPX1lK3LbLa0JlE
         2NCWn3JNqOPY6Qznp/vA98Z0mE2PYQ7zM6nNpXhgDZHVyVcjlwIBf5IgoTtyIBo3Dq/r
         FNUT70+6Y7E/xBKpDPPSl6ge6b1MaA8AU/GXnXwsWEvfzbTtDGzQetC7Sk8QhjHvQsSC
         K1rA==
X-Forwarded-Encrypted: i=1; AFNElJ8Jdt253L0HZ8/PfQYHzhCC1CCvM6wnxJhAX9f8Adf21NSYi6Ey2ielnpI/PM1Xexp5dWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeW8cWoIjcJKQyc8NqmVUz66Xy/hNi3e5Hatx9TNXw0DQyu22/
	FvX0Td/sPf2uEVj8kDqdqCbNCavr2adHw67TNPsvCPYiI1R2YpF8w0jX7RoRp8x89aQAttb6I+S
	Cm3e4Ag==
X-Received: from pgct24.prod.google.com ([2002:a05:6a02:5298:b0:c82:73de:68e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e04:b0:368:ed26:15b2
 with SMTP id 98e67ed59e1d1-369519fe820mr25179766a91.8.1779290845382; Wed, 20
 May 2026 08:27:25 -0700 (PDT)
Date: Wed, 20 May 2026 08:27:24 -0700
In-Reply-To: <20260520151710.231788-4-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520151710.231788-1-imbrenda@linux.ibm.com> <20260520151710.231788-4-imbrenda@linux.ibm.com>
Message-ID: <ag3S3MjXHW4AeW_6@google.com>
Subject: Re: [PATCH v1 3/4] KVM: selftests: Fix pre_fault_memory_test to run
 on s390
From: Sean Christopherson <seanjc@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, 
	david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com, 
	schlameuss@linux.ibm.com, gra@linux.ibm.com, pbonzini@redhat.com, 
	yan.y.zhao@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 20, 2026, Claudio Imbrenda wrote:
> Add a missing #include <ucall_common.h> which is needed and otherwise
> not included on s390.
> 
> Fence the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  so that it
> is only checked on x86. On s390 the UCALL will return with a different
> code.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/pre_fault_memory_test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> index fcb57fd034e6..42794892e902 100644
> --- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
> +++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> @@ -11,6 +11,7 @@
>  #include <kvm_util.h>
>  #include <processor.h>
>  #include <pthread.h>
> +#include <ucall_common.h>
>  
>  /* Arbitrarily chosen values */
>  #define TEST_SIZE		(SZ_2M + PAGE_SIZE)
> @@ -167,7 +168,6 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
>  		.type = vm_type,
>  	};
>  	struct kvm_vcpu *vcpu;
> -	struct kvm_run *run;
>  	struct kvm_vm *vm;
>  	struct ucall uc;
>  
> @@ -193,10 +193,11 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
>  	vcpu_args_set(vcpu, 1, gva);
>  	vcpu_run(vcpu);
>  
> -	run = vcpu->run;
> -	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> +#ifdef __x86_64__

I'd say just delete this assertion entirely.  It's an extra layer of paranoia to
guard against stale ucall data, but x86's ucall_arch_get_ucall() already has
sufficient guards.

> +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO,
>  		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
>  		    run->exit_reason, exit_reason_str(run->exit_reason));
> +#endif
>  
>  	switch (get_ucall(vcpu, &uc)) {
>  	case UCALL_ABORT:
> -- 
> 2.54.0
> 
