Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8860254B1F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847857; cv=none; b=T2YcyWUDzLrLfYn1qNF1MgfdpgyHK2V3bzq+lVVAyX/vM1nE6uchS5T4HLNS1cn8dqsOAhBpNycTEQ7PV8xK8c7RK4AXOu1YSHkBzHyYC/hdo5Qo3FI6oNkUj0Fr7Q2O4go1VSpU1W0Lvi8sfFA4jTS1p5qTCIWeY7LttVugPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847857; c=relaxed/simple;
	bh=A5v+rp1zJ8QMdWdNRkGOpqgiIrLRDvScqS5IyRqJO5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F+rXbCbLj2p+w7IOzs7J2jDnG5JQX4KVtHNVVAnyabs4C9DuF21Yvpqpid8DWgerC+MATtZU5wSYPsEKVBeMB1//q1V1s1HYPYPW5TdPgkI3RERT7aX08zCq369h55iAx09FjF2glupluZ0MUulZePQ+tQ6gdXY5YDwoVbZXtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NK+i9ypG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NK+i9ypG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba3245a43dso125101445ad.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779847855; x=1780452655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=usLgBsk1MTpojgcmDN5woxxk3XIXmztD/WjCi7CXZoQ=;
        b=NK+i9ypG34it4gzj0r21CQWZd/RgqonZlCsB+AcggKr22MmrVJPwwu5muxEgpqi8Q2
         9lBEr+auv3EmumlTQmZ6nXscNBu4UQQZafR+jNP11TZKChvJRIGDeqlfoypIiylNUKtw
         XWa+Q4zHyJ6Nrs4Vnneow2iIWwKkYqTrqUwYIilE1X/I4VxL2rFH8CsuCQNl9jBlXAfC
         MtTYJijFFS/zAYjYQnV0POV2a4O7Ixk6PQ3sS7KXr7J+XsrIYU+Yc9fFoCQnhrh7zSTU
         jCSFhh31C7dYnSRqqePNu6vjfsBxUE+A3NuJFYo33UsaA/olF7u3BLZpetoo6l9wIzVd
         P07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779847855; x=1780452655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usLgBsk1MTpojgcmDN5woxxk3XIXmztD/WjCi7CXZoQ=;
        b=L6sPy10j2K8N29LZ4h1kNAHsSlTk7y64KL7SIAfiXCFrZBQQuNjHJW8dokvkz0x2rx
         6wTpoFq8R0iGqeXBSQVwXHn7mHlOUQS+sgyzhA5pJe9O6xd08IInSgVsoU7w3/Nxkdr2
         tVtr62sw+wfdZiRrXHxUikcTrhW1OQbqNdNU50Fn2BYBqtpvAsYtahEKMVnRBcjtBAhw
         mtLZwl3SXhVN3WgIv7Q9eQJVvWf9+9nlJoMWJihLUEgFWTnjJJ/9RDQQ+Vy5Mnm9HkIi
         7anVI7ugEGiZdpdT9LOSRyAOmQ3MDgkpgxRjYQlbPJXlVRcQmdv/lwmQ3fnI3QOIuezP
         +5zQ==
X-Forwarded-Encrypted: i=1; AFNElJ86wlezERt8j8raZhqltb5ND0+JHGrGT+Ny47mZei0YXDpcmk0Jlf6Zcj1/4B0ld1iX3Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWkS/m+DyzIyAcjAnJlia/GQ87PXzTwwBXY5sLqD6ndV6vOoi
	pQPsovascSiuXiHOISf2Hi8sB6/xy9NoH8+Lr7MRwJbEgyxYNX6DRgiJElbuhU/bpXBGsLj2EpD
	jDmcZLw==
X-Received: from plsq18.prod.google.com ([2002:a17:902:bd92:b0:2be:f629:a2cd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78e:b0:2bd:657f:3a1b
 with SMTP id d9443c01a7336-2beb065d2b3mr220172815ad.40.1779847854980; Tue, 26
 May 2026 19:10:54 -0700 (PDT)
Date: Tue, 26 May 2026 19:10:54 -0700
In-Reply-To: <20260421231557.1254270-7-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-7-jrhilke@google.com>
Message-ID: <ahZSrlqWwe77HWw6@google.com>
Subject: Re: [PATCH v3 06/16] KVM: selftests: Add IRQ injection test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Josh Hilke wrote:
> +	for (i = 0; i < nr_irqs; i++) {
> +		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
> +		struct timespec start;
> +
> +		kvm_route_msi(vm, gsi, vcpu, vector);
> +
> +		for (j = 0; j < nr_vcpus; j++)
> +			TEST_ASSERT(

Thou hast committed the cardinal sin of leaking the demonic influence of Google3
into the kernel.

Never, ever wrap immediately after the opening '('.

> +				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpus[j]->id]),

Hmm, give how many times this shows up, maybe add a wrapper macro?

#define GUEST_RECEIVED_IRQ(__vcpu)	\
	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_irq[(__vcpu)->id])

Then this becomes:

			TEST_ASSERT(GUEST_RECEIVED_IRQ(vcpus[j]),
				    "Blah blah blah");

> +				"IRQ flag for vCPU %d not clear prior to test",
> +				vcpus[j]->id);
> +
> +		/* Trigger interrupt */
> +		eventfd_write(eventfd, 1);
> +
> +		clock_gettime(CLOCK_MONOTONIC, &start);
> +		for (;;) {
> +			if (SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpu->id]))
> +				break;
> +
> +			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns)
> +				TEST_FAIL(
> +					"vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",

Best get to reading Dante's Inferno.

> +					vcpu->id, gsi, vector);
> +		}
> +
> +		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
> +	}
> +
> +	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
> +
> +	for (i = 0; i < nr_vcpus; i++)
> +		pthread_join(vcpu_threads[i], NULL);
> +
> +	printf("Test passed!\n");
> +
> +	return 0;
> +}
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 
