Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693101;
	b=eXtk65J1DpH2bsWotM3iK52oJJd994YuuGj54NwputeBXwpCcty2NBWzLUL5+uJS4Kb1
	 8zzOKtV/I+6hjgr7GZAlBX4ttvMx8byQUjbEnd7koXgJoM/RHvao1jP70WxbcoM9a+jy6
	 P48aYtpoN+NRHINlaFSBOeZV/u2M7d63+BcQSAGeW6eczP8+ckSPaYAr1w+RHYoqZ/tAE
	 RuxoiQbPb9hRruTqHiouLv9nCMQ+W2RG2ygb6GsgZ+Hv4Q31OyO1+9L7M4Sh80Oe0xJbN
	 5lW73H0f4DheddMlosMXMcOBdKa9lhw+CVa/b9shR7XY6/d9VGbPiLnmr1jJBu9FyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gA1AUubl9m6fHOyzeOfDMgK8SFqgm8VvX00DyQ47ihk=;
	b=vqnQbXdudRoyegh/mD6sRYqUwWIdG3ndTgQs1HT7HT/0P7MySzgdrIA8/OcVjvQt2tz1
	 SV/b+0QkANQs/hrMWKcAQ/UyqQrDweuXQCCRHCwgh8es4BiezBgpQiD2Kc6KjJFqXpoQp
	 VUC+99xaC2cUJoqDW+87RG5cfnXq1cMLrj8Hfy92BfLIMRCW/+rLjwM4gpN3W5YyV12Of
	 2jHMAQ+9sW5mGsZ1GJIkkLarcjCz03D0AEVncAqc33x77ZwW2XKdWUvZyTe9PThEoUDN+
	 G5PyGVz1L+w1ZvOZ3FS/GvQhWHa1AKoLvc1mdfBV3RW6N43rGa12hqyN9Bplnz5MJ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TA60Awwl;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6215606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 18:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6215606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TA60Awwl
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so126993a12.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792693100; x=1793297900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gA1AUubl9m6fHOyzeOfDMgK8SFqgm8VvX00DyQ47ihk=;
        b=TA60Awwlh9FiPRH3OLzggHhy88D6w+X/wbdhaTppSyY69zDzorfhPPBS35LxloPTQV
         /12zlS/wCHoSGl37M2mR5wEIqBcxtfw9wcwpCWKabB4Fq4J5v8n8BqeVX9Ok0dIAlS9R
         /SAzW9g6fLeTRlykHA3hJ+LwgX3ZGCD9cW9or8hRP9HZn8pYKqHx9sUyG6Dbq3arZkMp
         IjoEH0ja4TORFk7PkRb2GFKF7MlKp37jNXcu/WwC/oCu7rOPrdFxFDK9t58ESAx6Yqgj
         2RIrx8jEma6AygFKsD3gfusGWvAZ3085W74F+Y3kz3+5yJ1n32gQFA6BLxMG8UUqfBYv
         tiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693100; x=1793297900;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gA1AUubl9m6fHOyzeOfDMgK8SFqgm8VvX00DyQ47ihk=;
        b=sLvhz63JdV7Eg9sAr9KEz3Rxkssmnil7Sv68dPHyOc36IuNnvWmGsxE3LcfmanyoN4
         WOZ4YKiU3b5RYpc9mUFfc5YxVoYRlwMW3ayk+6Sukxx0AFuGrJd1GHDq4xwmeMS5eKLb
         qCG4586bPsQ35OwAZISojd2LbYWHQShXKxR0oUo3cBYUlW0lmqfs3c0nPLzAZ9iI1BVU
         ugJNSqKj0tFmPVK6no5CbNtOBo9OiGEKObbssnowXPgKCJ/09EjiYxdbLpD2LulAJvkT
         6anhfRa8WJjxm9AAgUGxN6ojX6lXJOuFSud44wQNrRo3pzYJF1Xfk+6sob9k89uatNYj
         5HtA==
X-Forwarded-Encrypted: i=1; AKwUvBykTgJeBlzI9yq4X36FInlUGtWy0vAJnhC5dnwNMhTAGYVqVJTi8kXWEVhAjK2zeTj1pVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFplGkFYqUWiJTIZNS2PgHc07ViBJJXBbqTwhBB2SG6zgwZI5b
	Whwaxb7mkuzPuNZgtdC5Tv+qNnyXMl4X6kXSp81Q/ufAQ2nfe0bOQmyJ+xrRGuprat4TkvGujdE
	2npw9VA==
X-Received: from pgjs24.prod.google.com ([2002:a63:f058:0:b0:cc9:f7f0:57ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cf85:b0:3e1:1db7:7608
 with SMTP id adf61e73a8af0-3e287eae778mr4848932637.54.1792693099812; Thu, 22
 Oct 2026 11:18:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:18:19 -0700
In-Reply-To: <20261020175818.375700-3-borntraeger@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020175818.375700-1-borntraeger@linux.ibm.com> <20261020175818.375700-3-borntraeger@linux.ibm.com>
Message-ID: <atpTa2FMU19UGitv@google.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Christian Borntraeger wrote:
> Add a test in which the guest writes to a shmem-backed memslot beyond
> the end of the file.  KVM_RUN must fail with -EFAULT.
> 
> On x86 the guest enables interrupts, and on s390 the test sets up
> pfault, so that KVM could handle the fault with an asynchronous page
> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
> retries the access forever, and the test fails after a timeout.
> 
> The test is not built for LoongArch, which handles a failed mapping as
> an MMIO access.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/faultin_sigbus_test.c       | 169 ++++++++++++++++++

The "sigbus" part of this is confusing, because there is never actually a sigbus.
Kinda silly, but maybe faultin_efault_test?

> +static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{

...

> +}
> +#else
> +/* x86 needs guest interrupts on, see guest_code(); nothing to do elsewhere. */
> +static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)

Nit, maybe arch_enable_host_async_pf()?  Because x86 has PV async #PFs, where
instead of scheduling a worker task in the host, KVM (conditionally) reflects
the #PF into the guest so that the guest can schedule in a different task.  A
lot of people, myself included, see "async #PF" and think of the PV version first,
e.g. I initially was looking for the PV side of things here.


> +#endif
> +
> +static void guest_code(u64 gva, u64 size)
> +{
> +#ifdef __x86_64__
> +	/* KVM does async #PF, or its halt fallback, only with IRQs enabled. */
> +	sti_nop();
> +#endif
> +	/* Within EOF: must work, proves that the mapping is set up right. */
> +	WRITE_ONCE(*(u64 *)gva, 1);
> +	GUEST_SYNC(0);
> +
> +	/* Beyond EOF: KVM_RUN must fail with -EFAULT. */
> +	WRITE_ONCE(*(u64 *)(gva + size - sizeof(u64)), 1);
> +	GUEST_FAIL("Store beyond EOF succeeded");
> +}
> +
> +static void sig_alarm(int sig)
> +{
> +}

...

> +	TEST_ASSERT(!sigaction(SIGALRM, &sa, NULL), "sigaction() failed");
> +	alarm(TIMEOUT_SECS);
> +	r = __vcpu_run(vcpu);
> +	alarm(0);
> +
> +	TEST_ASSERT(!(r == -1 && errno == EINTR),
> +		    "KVM_RUN did not return within %d seconds: the fault on the SIGBUS page is retried forever",
> +		    TIMEOUT_SECS);

Rather than assert on EINTR, what if we have sig_alarm() explicitly TEST_FAIL()?
That way readers don't have to piece together that the EINTR is coming from the
alarm, and there's less chance of the test somehow getting a false pass because
KVM manages to morph the signal into EFAULT.  That would also allow using the
single-underscore _vcpu_run(), though I don't know if that's actually a good idea.

E.g.

diff --git a/tools/testing/selftests/kvm/faultin_sigbus_test.c b/tools/testing/selftests/kvm/faultin_sigbus_test.c
index 9394b04efcd6..9d90c32f3c6a 100644
--- a/tools/testing/selftests/kvm/faultin_sigbus_test.c
+++ b/tools/testing/selftests/kvm/faultin_sigbus_test.c
@@ -106,6 +106,7 @@ static void guest_code(u64 gva, u64 size)
 
 static void sig_alarm(int sig)
 {
+	TEST_FAIL("%d second timeout expired before KVM_RUN hit -EFAULT", TIMEOUT_SECS);
 }
 
 int main(void)
@@ -154,12 +155,9 @@ int main(void)
 
 	TEST_ASSERT(!sigaction(SIGALRM, &sa, NULL), "sigaction() failed");
 	alarm(TIMEOUT_SECS);
-	r = __vcpu_run(vcpu);
+	r = _vcpu_run(vcpu);
 	alarm(0);
 
-	TEST_ASSERT(!(r == -1 && errno == EINTR),
-		    "KVM_RUN did not return within %d seconds: the fault on the SIGBUS page is retried forever",
-		    TIMEOUT_SECS);
 	TEST_ASSERT(r == -1 && errno == EFAULT,
 		    "Expected KVM_RUN to fail with EFAULT, got r = %d, errno = %d (%s), exit reason %s",
 		    r, errno, strerror(errno), exit_reason_str(vcpu->run->exit_reason));
