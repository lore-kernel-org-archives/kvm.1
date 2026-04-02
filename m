Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5F1D6BB
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088827; cv=none; b=VIDLfOy4G5Ep/hV2aLGCFAZ+Nxv7dKX9gvKkhHn5IIxsx2JAMs6J/AZzqh0bW0d+VNjOjaBBSBmaG3/cRQ94cjgeluttDhZ6Eb12K9r/KBTuVkn+uXwOwwcvo0GkHul720TgGtqF3P7ifETf0m3zsmT8sicEedR7VEx8KXW9SF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088827; c=relaxed/simple;
	bh=X1v92SDRcvpdWw/IeaShlZyc2bXhBjCmK9NVXU3gPyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umHFyleLkJAN9ySFyxVVVKFMPpBnTnRfC/plZ2GltI0XB+D/oXjsbi4zjwxXsKCPxCFpNeVI9R253+o+5qzo2AdGvP8TUmkIFqpkYpmy70902zJnyHMV51IG4mysvFubid2n3APPvT3XegBPwTBOtx/FRIOU7+0BgQwkDw/+cmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/zbi08M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/zbi08M"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0c12be0ecso29385ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775088825; x=1775693625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZrBJB7ASmpmsEjwTEVnjnz6/XyMFuqhmqnvnWrK2eQ=;
        b=s/zbi08MEtQs9M5Cj6IDeDWmGOxz0AVFdDH+d5vvTY9vhWx0jUBg37BDijd/OvF4bM
         4RBFllhaDjTLdZBWhRtDBRbR9DijDJ5fRLKSbcAjZOrsfZM8fz7F8Zg6sGrMsrCawk3z
         DpDgG+OIpO6kfWoVZIUWkvs/Fy1isGePdYSUtdW7ldDVEV7inQeVDJyLG0G1cScC0ZAb
         Pe1j5u6OkgpsunqO+LvdJiUZfW5KZlx9+HFJufZLGMzV6wRGVd8ebCVClGcD9q3lTePB
         ygfxBZGhNA5dq07VBEjUsw+oYEYJIW80jXERt/KXcMCZSo5IU/6pU0SY5/wdtilGUm8O
         cqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775088825; x=1775693625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZrBJB7ASmpmsEjwTEVnjnz6/XyMFuqhmqnvnWrK2eQ=;
        b=j43Zqhi/ffXQb3R6fxkx3Fmu3xW0qWp7AYm7X3U0UGHVNoYmcZ4Q4Zb+HMfUhOyFlv
         O6ymXfApOWMzMK4BuGfUxAAjX8yJh/aLvvpSLUMKcsZSBpRJeWRgIyTg3Y5oOuNwSPRi
         u2OhdrqxbGE3Q5Bbbm8v5aRLMSBEfjEpqjLTrL5J8ZLf9WaNumFEud/shJ2VQt/XmHpn
         SBpIdj4xFAqWAkSo8KZdfar1U5siOygqdgctIHZ675yTNVhrfIoM0LLBMjfz/vfDU2iE
         oAWEhtkJz/he83T/Yz3ochCd8ZlsCiZ3TCY9zbvTl8xvHaH54T+gsZb954mL9a02Wnuq
         v90A==
X-Forwarded-Encrypted: i=1; AJvYcCVhKB2vU91tmpzi3d/DAxvw4hL4FYSSQxJ3eKjDZnE5lfA+XoPq+Q6+IPTx9xMXKcv2lWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXcA/dvsxkt+H7w545xZDSE0W4V+URzGSXzxIuQBaY1XUnG/c
	CGXIUdXnsH5xycGM4aPIFlFYeec4eTue9CqGViWzp3IE+NVJxS0pmKinWFI6BhUo
X-Gm-Gg: ATEYQzzFC4nui3uBRxzf/2r9bG/LRaP9g56CZO9hzJn35FQhab/4ZcTaCAwVQR+38Nq
	Cz99k7ufvFsEstrK2iHh4/oyR4KCv1u83oHhbQeKqzpsO+CJxndGuxdTYe3p2qyX+EhsNA2O8NM
	BUE/fLfv83UQ5sdjj+e3wUcL3mbrLdvtVbg4Qw2vuWw/wg/883i3R2QUlisk9WMmHlS3Y4UR13s
	yd0bZXrAOq8H7Phuzsdz/6s1bJDu/vzIH7y1JUGwnFpiplq7Ci8PbMNfNPj8Tu409FWlfknSjmC
	Eh7vdyIjZBaSa+2w/dKe8bSWIJTc7eC5xeM/OwktIBziJfee2Gin36k0WyI8WjZPLleWvIKrZ/J
	0xMVwPkVh+FirKvsX0iQBXzNWP4WNWXmMHU5n/ln6rvMIxKqU1y5SH3KtHufLddcunDyXhoUVoJ
	Ix1JNSxzWY6ycew9Rio1GwAC89utepU+5+iV8Z5cMogNV+2jAxHWarUzmKKlLFcA==
X-Received: by 2002:a17:903:3806:b0:2b2:4663:abe0 with SMTP id d9443c01a7336-2b27844a367mr272315ad.7.1775088824441;
        Wed, 01 Apr 2026 17:13:44 -0700 (PDT)
Received: from google.com (128.161.199.35.bc.googleusercontent.com. [35.199.161.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274735633sm9297555ad.6.2026.04.01.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:13:43 -0700 (PDT)
Date: Thu, 2 Apr 2026 00:13:39 +0000
From: Josh Hilke <jrhilke@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 03/14] KVM: selftests: Add vfio_pci_irq_test
Message-ID: <ac20s-AAvqIreILG@google.com>
References: <20260331194033.3890309-1-jrhilke@google.com>
 <20260331194033.3890309-4-jrhilke@google.com>
 <ac140E1-ZeVg9mq_@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac140E1-ZeVg9mq_@google.com>

On Wed, Apr 01, 2026 at 12:58:08PM -0700, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Josh Hilke wrote:
> > +int main(int argc, char **argv)
> > +{
> > +	/*
> > +	 * Pick a random vector and a random GSI to use for device IRQ.
> > +	 *
> > +	 * Pick an IRQ vector in range [32, UINT8_MAX]. Min value is 32 because
> > +	 * Linux/x86 reserves vectors 0-31 for exceptions and architecture
> > +	 * defined NMIs and interrupts.
> > +	 *
> > +	 * Pick a GSI in range [24, KVM_MAX_IRQ_ROUTES - 1]. The min value is 24
> > +	 * because KVM reserves GSIs 0-15 for legacy ISA IRQs and 16-23 only go
> > +	 * to the IOAPIC. The max is KVM_MAX_IRQ_ROUTES - 1, because
> > +	 * KVM_MAX_IRQ_ROUTES is exclusive.
> > +	*/
> > +	u32 gsi = 24 + rand() % (KVM_MAX_IRQ_ROUTES - 1 - 24);
> > +	u8 vector = 32 + rand() % (UINT8_MAX - 32);
> 
> Ahh, now I see why you included "Reproduce tests that rely on randomization" in
> this series.
> 
> I think I'd prefer to tweak guest_random_state() to drop the "guest" in favor of
> "kvm", and then use that framework in host code as well.  Then you wouldn't need
> to open code the % fun.
> 

How would using the guest_random_state() library remove the need to calculate the appropriate ranges using %? 
The library (tools/testing/selftests/kvm/include/test_util.h) only provides:

uint64_t guest_random_u64(struct guest_random_state *state);
uint32_t guest_random_u32(struct guest_random_state *state);

I could avoid using % by adding a new library function that picks a
random number within a range:

uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min, uint64_t max);

> > +	/* Test configuration (overridable by command line flags). */
> > +	int nr_irqs = 1000;
> > +	int nr_vcpus = 1;
> > +
> > +	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> > +	pthread_t vcpu_threads[KVM_MAX_VCPUS];
> > +	u64 irq_count, pin_count, piw_count;
> > +	struct vfio_pci_device *device;
> > +	struct iommu *iommu;
> > +	const char *device_bdf;
> > +	int i, j, c, msi, irq;
> > +	struct kvm_vm *vm;
> > +
> > +	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> > +
> > +	while ((c = getopt(argc, argv, "h")) != -1) {
> > +		switch (c) {
> > +		case 'h':
> > +		default:
> > +			help(argv[0]);
> > +		}
> > +	}
> > +
> > +	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> > +	vm_install_exception_handler(vm, vector, guest_irq_handler);
> > +
> > +	iommu = iommu_init(default_iommu_mode);
> > +	device = vfio_pci_device_init(device_bdf, iommu);
> > +	msi = setup_msi(device);
> > +	irq = get_irq_number(device_bdf, msi);
> > +
> > +	irq_count = get_irq_count(irq);
> > +	pin_count = get_irq_count_by_name("PIN:");
> > +	piw_count = get_irq_count_by_name("PIW:");
> 
> I'm *very* skeptical of blindling printing PIN/PIW.  They're Intel specific and
> are global to the entire system.  Outside of debugging specific issues, I don't
> see them providing much value, while on the other hand, they could easily confuse
> readers.  And unlike the IRQ counts, the data won't be lost when the test exits.
> 

I'll remove PIN/PIW in v3.

> As for the get_irq_number() and get_irq_count(), those need to be much more clearly
> scoped to /proc/interrupts.  E.g. "irq" in KVM context most often refers to the
> guest IRQ vector, not the host Linux make-believe IRQ number.
> 

How about I rename these to get_proc_irq_num() and get_proc_irq_count()?
And then rename the library irq_util.h/c to proc_util.h/c?

> > +	printf("%s %s MSI-X[%d] (IRQ-%d) %d times\n",
> > +               "Notifying the eventfd for",
> 
> Where's the rest of this line?  Oh, this is the first %s.  LOL, that's ridiculous.
> 
> 	printf("Notifying the eventfd for BDF %s, MSI-X[%d] (IRQ-%d) %d times\n",
> 	       device_bdf, msi, irq, nr_irqs);
> 	       

Will fix in v3.

> > +	       device_bdf, msi, irq, nr_irqs);
> > +
> > +	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
> > +
> > +	for (i = 0; i < nr_vcpus; i++)
> > +		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
> > +
> > +	for (i = 0; i < nr_vcpus; i++) {
> > +		struct kvm_vcpu *vcpu = vcpus[i];
> > +
> > +		while (!READ_FROM_GUEST(vm, guest_ready_for_irqs[vcpu->id]))
> > +			continue;
> > +	}
> > +
> > +	/* Set a consistent seed so that test are repeatable. */
> > +	srand(0);
> 
> And using a pRNG instead of rand() should make this unnecessary.
> 

We shouldn't even need a pRNG if we follow your suggestion above and use
the guest_random_state() framework for the host, as it would provide the
guest_random_u64() function.

> > +	for (i = 0; i < nr_irqs; i++) {
> > +		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
> > +		struct timespec start;
> > +
> > +		kvm_route_msi(vm, gsi, vcpu, vector);
> > +
> > +		for (j = 0; j < nr_vcpus; j++) {
> > +			TEST_ASSERT(
> > +				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
> > +				"IRQ flag for vCPU %d not clear prior to test",
> > +				vcpu->id);
> > +		}
> > +
> > +		send_msi(device, msi);
> > +
> > +		clock_gettime(CLOCK_MONOTONIC, &start);
> > +		for (;;) {
> > +			if (READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]))
> > +				break;
> > +
> > +			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
> > +				printf("Timeout waiting for interrupt!\n");
> > +				printf("  vCPU: %d\n", vcpu->id);
> > +
> > +				TEST_FAIL("vCPU never received IRQ!\n");
> 
> Which vCPU?  What BDF+MSI?  Some of that is available in earlier messages, but
> failure messages should be standalone.
> 

Got it, I'll add that info in v3.

> > +			}
> > +		}
> > +
> > +		WRITE_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
> > +	}
> > +
> > +	WRITE_TO_GUEST(vm, done, true);
> > +
> > +	for (i = 0; i < nr_vcpus; i++) {
> 
> Unnecessary curly braces.
> 

Will remove in v3.

> > +		pthread_join(vcpu_threads[i], NULL);
> > +	}
> > +
> > +	printf("Host interrupts handled:\n");
> > +	printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
> > +	printf("  Posted-interrupt notification events: %lu\n",
> > +	       get_irq_count_by_name("PIN:") - pin_count);
> > +	printf("  Posted-interrupt wakeup events: %lu\n",
> > +	       get_irq_count_by_name("PIW:") - piw_count);
> > +
> > +	vfio_pci_device_cleanup(device);
> > +	iommu_cleanup(iommu);
> > +
> > +	return 0;
> > +}
> > -- 
> > 2.53.0.1118.gaef5881109-goog
> > 
