Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFA2F1FD0
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073491; cv=none; b=RaBpfYAf7J9pLq4Ofw48wxwMiVp9+IG6usmp9mrZrY0BOZSoSDdJwRQ0JR45COcRytqZRhmSoh+XfvMjbcOT7XeUXAz8iU9NH6T5FLr1OLAjp937BoF4dXx5oDogbVWjwXXhmpf72/Y1qk0JEPaDoJgzcLQa1v4UdEOIcmHEdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073491; c=relaxed/simple;
	bh=Wqoar2unzDoT2DyLSBYD980RM/oTqjHcs0ISRny8uF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jGg1mQmE3MkXlckAMnxoGVH3xXasQAvbxnWlnlJO5FgTUiGBK+n1hJnZ4AbpflrknoNHOf5SRk52qyD3f8A3humtQkUrW2tyas0rejZqqlPum2g5cDX85Ga07OHg2Csl7wHmjezUoFRDPJfjrrG9ydFusWObxe6Jwa3zsWmXidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgxjLfI3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgxjLfI3"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cf084fe58so54016b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775073489; x=1775678289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqH8DHhTLq1D+fFWiyEUoVviy2/FTguWqWJAhYHEYnY=;
        b=qgxjLfI3zD9KKk8FrUrQPmgYWEKwSTg9r/HhCZPeH2JP65BR1pE6P28IEiC2I4nLkZ
         VjeM2tkICoYbDG1WXToatPkWffyCzEAJrsC2GNu59xNMr0ElS1oVodk9+sXFdRV4Fzqh
         tDVflqwEuP35oUsFZpDMIPh1v8DCnKOqHVbDyfcX94ci32Ha3l40vtwNuONYHiOfH3BY
         Fjels6ToCzofv9WAMV6/aufkw9WT/C4393GJbyrgrecUtZ/G7wvAfTue+tjzLRq+XT0l
         B4XPw16hGh6zqg79mOWvLh9uX8h0HZv8AJi1YAy11ZS2H4XMNxfA+mNQCVZ9y+2ZkTCx
         HWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775073489; x=1775678289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqH8DHhTLq1D+fFWiyEUoVviy2/FTguWqWJAhYHEYnY=;
        b=Adq7oK+LXgZ39i7s4SqcCUwuV3b42JCqLHiMGiHb/ljg9KPgyiv+MNuXXb6fAigbCd
         tgD3J86+qjllcWJWeVjB2N8+5zaWnbK1+XaFPnO+3Md9ZQmU70ZXZA6zOLTvDbUHsaJj
         zenkGX9EDnFCKqtQ1+3cMI/DfSVsahgYr5WQABZp/nBy43QGeut3+Egpp5y2UrQIdPhp
         Qwdx/hu8PeR53OvZ21fuC0+CbCFvXQFNnVm6noIvdKIeUQqSfcQRO2TwXgoxfbN0qQyI
         R6kW4h48rNvjtsDOrX19UBCoSYOzhC2nioMr88qv/k9kYSOp1pqp/4fi3l56aptBNKZs
         q4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUul3mZhNcgzmg/PWRWeOktKZsz9efVQ86genh+7Ux/bVj1cifus3q+EzQMAZoG+0oo7js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqRioJwd2+kMjrDHx7VjAOfrjiBtzfu7F6heQonAj1GdhvGaK
	eAIATbPBF8wPZTy8+L+6rB9m7klsv+WZTO5HWfnqKdLVviuLKuuDJqMYRkxHNmQH1LHMBjiYM3T
	vHQ5wig==
X-Received: from pfbil4.prod.google.com ([2002:a05:6a00:8d44:b0:82a:ea7:3561])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d82:b0:82c:e816:4135
 with SMTP id d2e1a72fcca58-82cfb9c0d13mr716399b3a.47.1775073489293; Wed, 01
 Apr 2026 12:58:09 -0700 (PDT)
Date: Wed, 1 Apr 2026 12:58:08 -0700
In-Reply-To: <20260331194033.3890309-4-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-4-jrhilke@google.com>
Message-ID: <ac140E1-ZeVg9mq_@google.com>
Subject: Re: [PATCH v2 03/14] KVM: selftests: Add vfio_pci_irq_test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> +int main(int argc, char **argv)
> +{
> +	/*
> +	 * Pick a random vector and a random GSI to use for device IRQ.
> +	 *
> +	 * Pick an IRQ vector in range [32, UINT8_MAX]. Min value is 32 because
> +	 * Linux/x86 reserves vectors 0-31 for exceptions and architecture
> +	 * defined NMIs and interrupts.
> +	 *
> +	 * Pick a GSI in range [24, KVM_MAX_IRQ_ROUTES - 1]. The min value is 24
> +	 * because KVM reserves GSIs 0-15 for legacy ISA IRQs and 16-23 only go
> +	 * to the IOAPIC. The max is KVM_MAX_IRQ_ROUTES - 1, because
> +	 * KVM_MAX_IRQ_ROUTES is exclusive.
> +	*/
> +	u32 gsi = 24 + rand() % (KVM_MAX_IRQ_ROUTES - 1 - 24);
> +	u8 vector = 32 + rand() % (UINT8_MAX - 32);

Ahh, now I see why you included "Reproduce tests that rely on randomization" in
this series.

I think I'd prefer to tweak guest_random_state() to drop the "guest" in favor of
"kvm", and then use that framework in host code as well.  Then you wouldn't need
to open code the % fun.

> +	/* Test configuration (overridable by command line flags). */
> +	int nr_irqs = 1000;
> +	int nr_vcpus = 1;
> +
> +	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> +	pthread_t vcpu_threads[KVM_MAX_VCPUS];
> +	u64 irq_count, pin_count, piw_count;
> +	struct vfio_pci_device *device;
> +	struct iommu *iommu;
> +	const char *device_bdf;
> +	int i, j, c, msi, irq;
> +	struct kvm_vm *vm;
> +
> +	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> +
> +	while ((c = getopt(argc, argv, "h")) != -1) {
> +		switch (c) {
> +		case 'h':
> +		default:
> +			help(argv[0]);
> +		}
> +	}
> +
> +	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> +	vm_install_exception_handler(vm, vector, guest_irq_handler);
> +
> +	iommu = iommu_init(default_iommu_mode);
> +	device = vfio_pci_device_init(device_bdf, iommu);
> +	msi = setup_msi(device);
> +	irq = get_irq_number(device_bdf, msi);
> +
> +	irq_count = get_irq_count(irq);
> +	pin_count = get_irq_count_by_name("PIN:");
> +	piw_count = get_irq_count_by_name("PIW:");

I'm *very* skeptical of blindling printing PIN/PIW.  They're Intel specific and
are global to the entire system.  Outside of debugging specific issues, I don't
see them providing much value, while on the other hand, they could easily confuse
readers.  And unlike the IRQ counts, the data won't be lost when the test exits.

As for the get_irq_number() and get_irq_count(), those need to be much more clearly
scoped to /proc/interrupts.  E.g. "irq" in KVM context most often refers to the
guest IRQ vector, not the host Linux make-believe IRQ number.

> +	printf("%s %s MSI-X[%d] (IRQ-%d) %d times\n",
> +               "Notifying the eventfd for",

Where's the rest of this line?  Oh, this is the first %s.  LOL, that's ridiculous.

	printf("Notifying the eventfd for BDF %s, MSI-X[%d] (IRQ-%d) %d times\n",
	       device_bdf, msi, irq, nr_irqs);
	       
> +	       device_bdf, msi, irq, nr_irqs);
> +
> +	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
> +
> +	for (i = 0; i < nr_vcpus; i++)
> +		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
> +
> +	for (i = 0; i < nr_vcpus; i++) {
> +		struct kvm_vcpu *vcpu = vcpus[i];
> +
> +		while (!READ_FROM_GUEST(vm, guest_ready_for_irqs[vcpu->id]))
> +			continue;
> +	}
> +
> +	/* Set a consistent seed so that test are repeatable. */
> +	srand(0);

And using a pRNG instead of rand() should make this unnecessary.

> +	for (i = 0; i < nr_irqs; i++) {
> +		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
> +		struct timespec start;
> +
> +		kvm_route_msi(vm, gsi, vcpu, vector);
> +
> +		for (j = 0; j < nr_vcpus; j++) {
> +			TEST_ASSERT(
> +				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
> +				"IRQ flag for vCPU %d not clear prior to test",
> +				vcpu->id);
> +		}
> +
> +		send_msi(device, msi);
> +
> +		clock_gettime(CLOCK_MONOTONIC, &start);
> +		for (;;) {
> +			if (READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]))
> +				break;
> +
> +			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
> +				printf("Timeout waiting for interrupt!\n");
> +				printf("  vCPU: %d\n", vcpu->id);
> +
> +				TEST_FAIL("vCPU never received IRQ!\n");

Which vCPU?  What BDF+MSI?  Some of that is available in earlier messages, but
failure messages should be standalone.

> +			}
> +		}
> +
> +		WRITE_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
> +	}
> +
> +	WRITE_TO_GUEST(vm, done, true);
> +
> +	for (i = 0; i < nr_vcpus; i++) {

Unnecessary curly braces.

> +		pthread_join(vcpu_threads[i], NULL);
> +	}
> +
> +	printf("Host interrupts handled:\n");
> +	printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
> +	printf("  Posted-interrupt notification events: %lu\n",
> +	       get_irq_count_by_name("PIN:") - pin_count);
> +	printf("  Posted-interrupt wakeup events: %lu\n",
> +	       get_irq_count_by_name("PIW:") - piw_count);
> +
> +	vfio_pci_device_cleanup(device);
> +	iommu_cleanup(iommu);
> +
> +	return 0;
> +}
> -- 
> 2.53.0.1118.gaef5881109-goog
> 
