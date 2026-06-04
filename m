Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F047AF75
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589964; cv=none; b=HgyE3OCHOIcXj/a/w6wumw13CIwMaE8ow/WjGIxfrVPDF+YxwYGyK0yDHIdiQc+yfHJtJN7yX+wAVRrqfUmJKx6CWhN+rEV5gHf1KKJ+CDm9JheaY/k3NiRC9x7UnC74RXWa0HxZjmLTHiaXTLhf6Z6pDSdbvsrHk5s4qbLa2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589964; c=relaxed/simple;
	bh=mSAlB/ZJEHzJokY06lBmWHH2DUghgbJcmBUwqUTVEe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U4JHYffOKKNrEnOjvp+osyp5EuybxljZybrlvKQociNCQ8odeGR2l4G7lMtFwAnFFgOO+PXnuVfNi25lESzpjMo9FETcK2RiBIO3RRYTiqA10I0UhIbXIDwIAldYR/uVVzxY4sEXgOzjwv2o4nipJp55sLtdtzWcYKt89GJibw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6K0GpwX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6K0GpwX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso93925ad.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780589962; x=1781194762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEXZwERRVG++EEqLpkUS4X9sASjjX126u3AEsoy82KY=;
        b=B6K0GpwXD3U0cHVnTmhxW/tFBoVoNq07c5HIRMV1hVZx3Pf2mYdDajChT9SLRSluUr
         zlDPAnnRcPv9XsP7gzvc2mC4BerlMp9sxUp5bhctEUWFTp9pz8xlDyZ2PTUCDauYrsTn
         IxpU5mLXlJz5WaCE9L7FgJg0Hi1h450ZJ+LV/KcaKZFgc5oNQqQ4Ko71wUwaWnIPRKkp
         q4XVE/FwqKnqRK63uxJubwMvLov4pDHAZDAmpKcXn9Reqq0LuvxvsleZI1XN/0T+k2eH
         Z510mFnO7PISIlRGzN+6vQOqjoONgzKX32GVYfTn427HjMMLOezpoW9H/BFAdT09SXCe
         UHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589962; x=1781194762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEXZwERRVG++EEqLpkUS4X9sASjjX126u3AEsoy82KY=;
        b=F03ekfQGM6iJXjGu94AE3wAR6RDVrVj3UdHD7yB480HcZPxt6YOOFScJsUpmN38Pp2
         GDzg+JJUQ9M5+/m8jvGLRjr9YpQN1zbsfgATcqxNqeVoEAyHmmdpqjyG02IWLy4Mc/WU
         tfY1ewZAHQmdYTKnCvI5WYCAyw3kI6r0If7OK/hkcpi3mz+iUx61uqXg/EEnRYSm6OS1
         0MZKhCLIwjUyngwnKBDM6eMl8ldWUZpT7FZ8R1zf23FHYQwAyH0PtkzSUxfv/WUQlkYs
         cXUCUQ5UnZ4FZFDrEVLf0yUmh3Um36dZX+68OIkAI2X5tDtiNA2/NngAIHrHEY0i5TNd
         130A==
X-Forwarded-Encrypted: i=1; AFNElJ+gc9s4XuvaRpVCVZ+BYQzvaE+odDWx6CPMsN+hAJrE6y0ILKlNX1fFSOUHz/TnivoGhfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7F8RQYeDkrpeJcfR025LkdwLgomXVAyhSyRQiE7RF+Loxk8g
	XfQ326Nm+Sm1ynTaVSwqMbTxKp974lE9v10ele+dVvPNoq0TJqBMXIfST9Ynk4xygGDqdKXFLv7
	bwUTDFg==
X-Received: from pgsb24.prod.google.com ([2002:a65:67d8:0:b0:c85:7233:bedf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d92:b0:36d:b680:3041
 with SMTP id 98e67ed59e1d1-36e2eee1147mr8520732a91.4.1780589961985; Thu, 04
 Jun 2026 09:19:21 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:19:21 -0700
In-Reply-To: <20260604020143.748245-6-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-6-jrhilke@google.com>
Message-ID: <aiGlib6tvRkyNCIA@google.com>
Subject: Re: [PATCH v5 05/21] KVM: selftests: Add IRQ injection test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> +static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
> +			  u8 vector)
> +{
> +	struct {
> +		struct kvm_irq_routing head;

s/head/header, because I read this as "head entry", not "header of the struct".

> +		struct kvm_irq_routing_entry entry;
> +	} routing_data = {};
> +
> +	struct kvm_irq_routing *routes = &routing_data.head;
> +
> +	routes->nr = 1;
> +	routes->entries[0].gsi = gsi;

This is silly (and confusing), just initialize the information in the struct
declaration:

	struct {
		struct kvm_irq_routing header;
		struct kvm_irq_routing_entry entry;
	} routing = {
		.header.nr = 1,
		.entry = {
			.gsi = gsi,
			.type = KVM_IRQ_ROUTING_MSI,
			.u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12),
			.u.msi.data = use_nmi ? NMI_VECTOR | (4 << 8) : vector,
		},
	};

	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);

> +	routes->entries[0].type = KVM_IRQ_ROUTING_MSI;
> +	routes->entries[0].u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12);
> +	routes->entries[0].u.msi.data = vector;
> +
> +	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
> +}
> +
> +static void help(const char *name)
> +{
> +	printf("Usage: %s [-h]\n", name);
> +	printf("\n");
> +	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");

This is all kinds of misleading and wrong.  IRQ *injection* is not guaranteed.
KVM will use CPU-to-CPU posted interrupts to deliver the interrupt, if supported.
And it's not an "emulated eventfd"; the test isn't emulated anything.  It's
manually *signaling* the eventfd but there's no emulation of any kind.  And that
becomes stale when the test adds support for VFIO devices.

	Tests KVM interrupt routing and delivery via irqfd.

> +	for (i = 0; i < nr_irqs; i++) {
> +		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
> +		struct timespec start;
> +
> +		kvm_route_msi(vm, gsi, vcpu, vector);
> +
> +		for (j = 0; j < nr_vcpus; j++)
> +			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
> +				    "IRQ flag for vCPU %d not clear prior to test",
> +				    vcpus[j]->id);
> +
> +		/* Trigger interrupt */

Meh, not helpful.  And it goes away in a few patches.

> +		eventfd_write(eventfd, 1);
> +
> +		clock_gettime(CLOCK_MONOTONIC, &start);
> +		for (;;) {
> +			if (GUEST_RECEIVED_IRQ(vcpu))
> +				break;

This is a kludgy and confusing way of writing:

		clock_gettime(CLOCK_MONOTONIC, &start);
		while (GUEST_RECEIVED_INTERRUPT(vcpu, do_use_nmi) &&
		       timespec_to_ns(timespec_elapsed(start)) <= timeout_ns)
			cpu_relax();

> +
> +			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns)
> +				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
> +					  vcpu->id, gsi, vector);

Don't do an if-statement and then TEST_FAIL(), just TEST_ASSERT().  And with the
above, hoist this out of the loop:

		TEST_ASSERT(GUEST_RECEIVED_INTERRUPT(vcpu, do_use_nmi),
			    "vCPU %d timed out waiting for %s (vector 0x%x) from GSI %d (via CPU %d)\n",
			    vcpu->id, do_use_nmi ? "NMI" : "IRQ",
			    do_use_nmi ? NMI_VECTOR : vector, gsi, irq_cpu);

And as above, this should cpu_relax().

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

This is redundant, the return code provides this information.

> +
> +	return 0;
> +}
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 
