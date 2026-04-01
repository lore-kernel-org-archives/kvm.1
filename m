Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870B2D949F
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073705; cv=none; b=KBnQANIukzeTl4wYAbT0b95GrP9KCD+kLjemBaLNp3yvP5XRHFbbyVdU2jyXIBmjEaDixj4ktEtoSR3rakPWWckJGt+Z550KqbocLh8kEScvfx9YjpWjyhx+LG4NhBkgc6xBCR0H5Vm5pOGgI6aRz/WasS77rTpp1fFxqAVKXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073705; c=relaxed/simple;
	bh=CZgx0JejwE7NgurrKSqgFzWPZHvpZv9biaV1Z5O7GEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WkXsAmtGPUIgbCFUjvXUcXDU6qb71C3y6WlAn3hNmMPFDfPYAED6HG6Vccx2nqT+ffEP5L5Ev5c+So5cCx70BsfWHRwj9U64Du+C9mueEI6U9swYY1XzoQ8jZIxFVQQUroizmFgxdLXvU4cqrlqpkdVjozzmU9zxI1OzciRFwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMRsmfLV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMRsmfLV"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce0a9e558so91291b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775073704; x=1775678504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAGsjAtFGI4mevurwA8BXN49dLMjGu7yR+99d3RZzbc=;
        b=SMRsmfLVvEEUqTsmUjB/NFqSygdtMmKiyeTd1nJEw3yvbt143aQQ4EzARgZq6rK4um
         CIlqHA5o4mQXL2jfqfmd38ga3zEG/kjT5/WjIqX/l1oXSDLHWX39J1PFD6sjAdw9ZKVW
         De9YODYUU2iR71w6ykhG+xYgn+u/T0SFCkVr1jRRHOXPQ1XXQJM82PJB9IGX3fJYVlt1
         ZHvUpnazSm/PrQykzqy5VljvJZHA5soKo6Xc1LFL5mgqxizUPS2lHPRm1VeJZe9vdx+A
         Hp5hp9BZ2dcaNccAcELpF//OTmEBhLJsHqoAeCuwbW6Er5ksJqWJZnnuMcCy+nXpQFvv
         GokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775073704; x=1775678504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAGsjAtFGI4mevurwA8BXN49dLMjGu7yR+99d3RZzbc=;
        b=guJwtvtpZKa4W4lZ2VfJ8jeiYpKm8EkoEB1a76L6qTG+vKICVUN005AO33Eru4QsgP
         72fvWkdamBDWei0Ah0VmsQhvUTcyvCC1fgsyG6/6yBNoviYSUWN62YLQvyOv5sfCrhEb
         CkfrkpeDx+HhNipiohS/Svb7c36IKdqReJEY7mj3x1PLmHbj+0ylLEvUA0IQ7/2QbGbX
         zScl44icqTHULySH8jPLzDSWKpqyiN9Ut4wbNVIYfobLdFA6WMMHIutvVUdaKJFayBME
         I2QxlHUs940fQ0lFPqxgtXPy7exNndRc4PGSQJwAjvNp3aTXlHPNjjsoOnFJDkxgriy8
         /RNg==
X-Forwarded-Encrypted: i=1; AJvYcCWgHhzPpRFyWGWn0rZG8vKWfaM5LQ5vVT+oC6Zu2cLPLlHDxL8+pVrNOvu/p0JZ+L13m2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgiK1jsdV1JU8YCtOjMEVh9g2je4Cgnx9s5MqQu8pf7by4vXgQ
	z/gFiYpWWkhPxYHYmTmTkhgrt9hotk+QoThJ5bRk/PC0z5WWebAqhnlyr2YoasKy3rO+B4e1O69
	pY0cjGA==
X-Received: from pfjj21.prod.google.com ([2002:a05:6a00:2355:b0:827:4734:567])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2395:b0:82a:8030:f574
 with SMTP id d2e1a72fcca58-82ce8ae4d5dmr4938201b3a.33.1775073703674; Wed, 01
 Apr 2026 13:01:43 -0700 (PDT)
Date: Wed, 1 Apr 2026 13:01:42 -0700
In-Reply-To: <20260331194033.3890309-6-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-6-jrhilke@google.com>
Message-ID: <ac15psZs2_EGAVt6@google.com>
Subject: Re: [PATCH v2 05/14] KVM: selftests: Add support for random host IRQ affinity
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add the '-a' flag to vfio_pci_irq_test to randomly affinitize the
> device's host IRQ to different physical CPUs throughout the test.  This
> stresses the kernel's ability to maintain correct interrupt routing and
> delivery even as the underlying hardware IRQ affinity is changed
> dynamically via /proc/irq/.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Co-developed-by: Josh Hilke <jrhilke@google.com>

Please run checkpatch, the order here is wrong.

> @@ -122,13 +125,19 @@ int main(int argc, char **argv)
>  	struct vfio_pci_device *device;
>  	struct iommu *iommu;
>  	const char *device_bdf;
> +	FILE *irq_affinity_fp;
>  	int i, j, c, msi, irq;
>  	struct kvm_vm *vm;
> +	int irq_cpu;
> +	int ret;

Use the existing "int" declaration.

>  	device_bdf = vfio_selftests_get_bdf(&argc, argv);
>  
> -	while ((c = getopt(argc, argv, "h")) != -1) {
> +	while ((c = getopt(argc, argv, "ah")) != -1) {
>  		switch (c) {
> +		case 'a':
> +			irq_affinity = true;
> +			break;
>  		case 'h':
>  		default:
>  			help(argv[0]);
> @@ -163,6 +172,14 @@ int main(int argc, char **argv)
>  			continue;
>  	}
>  
> +	if (irq_affinity) {
> +		char path[PATH_MAX];
> +
> +		snprintf(path, sizeof(path), "/proc/irq/%d/smp_affinity_list", irq);
> +		irq_affinity_fp = fopen(path, "w");
> +		TEST_ASSERT(irq_affinity_fp, "fopen(%s) failed", path);
> +	}

This plus setting the affinity is begging for a library function, probably
provided by what's currently called get_irq_number() and friends.

> +
>  	/* Set a consistent seed so that test are repeatable. */
>  	srand(0);
>  
> @@ -172,6 +189,13 @@ int main(int argc, char **argv)
>  
>  		kvm_route_msi(vm, gsi, vcpu, vector);
>  
> +		if (irq_affinity && vcpu->id == 0) {
> +			irq_cpu = rand() % get_nprocs();
> +
> +			ret = fprintf(irq_affinity_fp, "%d\n", irq_cpu);
> +			TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%d to CPU %d", irq, irq_cpu);
> +		}
> +
>  		for (j = 0; j < nr_vcpus; j++) {
>  			TEST_ASSERT(
>  				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
> @@ -189,6 +213,8 @@ int main(int argc, char **argv)
>  			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
>  				printf("Timeout waiting for interrupt!\n");
>  				printf("  vCPU: %d\n", vcpu->id);
> +				if (irq_affinity)
> +					printf("  irq_cpu: %d\n", irq_cpu);
>  
>  				TEST_FAIL("vCPU never received IRQ!\n");
>  			}
> @@ -203,6 +229,9 @@ int main(int argc, char **argv)
>  		pthread_join(vcpu_threads[i], NULL);
>  	}
>  
> +	if (irq_affinity)
> +		fclose(irq_affinity_fp);
> +
>  	printf("Host interrupts handled:\n");
>  	printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
>  	printf("  Posted-interrupt notification events: %lu\n",
> -- 
> 2.53.0.1118.gaef5881109-goog
> 
