Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E51471D14
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250722; cv=none; b=okoQXp8vudB33QTg6wWBZkTT2LSyfXnj05USOuwC75dxoxHK6MQKLqws0e7CVCbSJReHqiHAoKNzPFcZhr4p47XOFiRUrF58eYHNoWMjogy2J5apzWs5FsYc5QD/FyuiiuHlr/iCtLNunceNM/n4hzwCiV07Mlh0VVk6OTPCiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250722; c=relaxed/simple;
	bh=i5SXab0FT5yKdSm4FwBxFNU2I1ujSC/RQwuwsfanqDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6o/2RktGJ/VC3kb4H35FT4kVJbgnSYkODbUG0qMrDNuhXSvrP1FSBkFZAUOe4SdEtdFPZFpJ2W/3p9BILizBDg8KYcJ0rq9JdKjJwv1eEN2VkwrngjMikLsqHl5Am/eQZpqgvU06LUtujY1LavsuWYQHKy2yZ4xxoYz8HOLRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTRsHRx4; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTRsHRx4"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484ba00601so4480127b3a.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785250721; x=1785855521; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zwyb+el8v/e1IaO44wZKPtX8yTaJIH7qCY9kcVnLb4o=;
        b=VTRsHRx4Z7n6fKm6os5IgIx5/taNha1wGSJlqAgsjJ6N/MinMtQ4dCviuzVoQmXTHV
         E8wtlzWbmHmpLrwzI+4v5L1/acQP+N1HQk1D6jbY4X0HQA3OqPvIdzgEJFxmbSitIgoe
         z5R0+H3iULRV9ffYf3CPExljidPnc48ujS6V+kmOvGETa1R6TT+KuxQEKL3di8QYcT3/
         LWLjE19BNaRRptAUeDmI3kiZXEU5eQ1YVIgOSjKUFMUDQGU447AG3C/l98UWd5M70yeb
         NktM8nK/EknXqS0Da6dyotDGlXQrPx7EigHXuoEy4tDiC8gVr5/imx+UN5Y565NAX+WY
         uqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250721; x=1785855521;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zwyb+el8v/e1IaO44wZKPtX8yTaJIH7qCY9kcVnLb4o=;
        b=LeIU5vunn0VtKswsxIAlu6k13KNZ6fobD9ADDH9T4oenoNwb1jrJK5R+fHWaM6zEVT
         C4/198LdrYJKw0yUy8kjEIDP/X9kFlvy4Oz9Isow3DEi7Kq3VTOK7fVwM7ZFG9fGBm6U
         6y1zxq5FQ6F5bkUu3okvgfbv9/cv3Eka+JBBCSCCA2ntoKnUeUb+nhsB0CHQkY8T+SzM
         OJ8pFruIZfQDzJJWvM0aBlxU2bcN+cHyo47M5v6fUWi9782c+CQPhGyT+W9/t/yM3F3s
         uhexHSEiXIwvuoNxAUR+7niXuM00AljBKOlRRcT9lRbyNG9j4FWul/VyX9mY7VaitbQS
         7wWQ==
X-Forwarded-Encrypted: i=1; AHgh+RohCW82/AmeydxEIHBhNf7Myl8S6TCco98+wP/2SWj7qabwlxp0rIEPdk/Ct93sqnGpExU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6Paq5BxYZ8yZ6+8QMUt4qn2Ckkn/kMPyCP9t4WbFg2nLm6qp
	sSHN1DhzDhyEE9sR3mOp6J7Q2hjF8FKtQA6dtAPLN7J1x98vfPu5C2DNDhhamygxVmvRPylJvRk
	dCvDH2A==
X-Received: from pgbcz7.prod.google.com ([2002:a05:6a02:2307:b0:ca2:10cf:5d95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a14:b0:847:9b9b:8981
 with SMTP id d2e1a72fcca58-84e93328759mr3013733b3a.33.1785250720364; Tue, 28
 Jul 2026 07:58:40 -0700 (PDT)
Date: Tue, 28 Jul 2026 07:58:39 -0700
In-Reply-To: <20260727235228.1007324-11-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org> <20260727235228.1007324-11-yosry@kernel.org>
Message-ID: <amjDn6fy8lgftsrE@google.com>
Subject: Re: [PATCH v4 10/12] KVM: selftests: Trigger save+restore randomly in
 the #PF stress test
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Yosry Ahmed wrote:
>  int main(int argc, char *argv[])
>  {
>  	struct kvm_x86_state *state;
>  	int r, i, level;
> +	pthread_t sigusr_thread;
>  	gpa_t gpa, pgtable_gpa;
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
> @@ -128,18 +156,30 @@ int main(int argc, char *argv[])
>  		pgtable_gpa = PTE_GET_PA(pte);
>  	}
>  
> +	/* Initialize the thread sending SIGUSR and install the handler */
> +	vcpu_sigusr_ignore();
> +	r = pthread_create(&sigusr_thread, NULL, sigusr_thread_fn,
> +			   (void *)pthread_self());
> +	TEST_ASSERT(!r, "pthread_create() failed: %d", r);
> +
>  	for (i = 1; i <= NR_ITERATIONS; i++) {
> +		/*
> +		 * Only handle SIGUSR while the vCPU is running, otherwise
> +		 * ignore it to avoid interrupting other ioctls/syscalls.
> +		 */
> +		vcpu_sigusr_listen();
>  		r = __vcpu_run(vcpu);
> -		TEST_ASSERT(!r, "vcpu_run failed");
> -		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> -
> -		get_ucall(vcpu, &uc);
> -		if (uc.cmd == UCALL_ABORT) {
> +		if (r == -1)
> +			TEST_ASSERT_EQ(errno, EINTR);

		TEST_ASSERT(!r || errno == EINTR, "Expected success or SIGUSR1");

> +		vcpu_sigusr_ignore();
> +
> +		/* The guest only exits due to a signal or failed assertion */
> +		if (!r) {
> +			TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +			TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_ABORT);
>  			REPORT_GUEST_ASSERT(uc);
>  			break;
>  		}
> -		TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
> -		TEST_ASSERT_EQ(uc.args[1], i);
>  
>  		state = vcpu_save_state(vcpu);
>  
> @@ -153,8 +193,11 @@ int main(int argc, char *argv[])
>  	pr_info("\n");
>  
>  	sync_global_from_guest(vm, guest_faults);
> +	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");

Since guest_faults is an unsigned value, the kernel's preferred style is:

	TEST_ASSERT(guest_faults, "No guest page faults triggered");

>  	pr_info("Guest page faults: %lu\n", guest_faults);
>  
> +	pthread_cancel(sigusr_thread);
> +	pthread_join(sigusr_thread, NULL);
>  	kvm_vm_free(vm);
>  	return 0;
>  }
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
