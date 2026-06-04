Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C947DD49
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590130; cv=none; b=mkybA/NTe3J+g+ifyPqWoSlIvSmUsoVGli4sNh9h0/0useUTTxUj+0XyHJFYyH+TVLbDSIbrNqM7K2WisLqdOQzkpDm3XrL/EhOGmLON1X1e1KwXmupGio7KRb/AlFyRP6oLrUyualCm+rc0mtrj/tjhRrRKMngqw7vXCQUCdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590130; c=relaxed/simple;
	bh=Qf12anfXZHVei4NpYKSpA3SylBx4/ak3323rQUawtTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DLwTHstq9KeU/dJS3Z2VDqtfjGvhz+qAM1iuG7HC9uOiYNq2iIE2WQNb3dPVuX1Fn766xHbbf2RUizW7wUbFoPWFNseaNFZIiWIqz9GKk7NxWaCK3Ad2aQZxF7q0ro9aDMuSmugtzhDH7uuQsGUkvtbZO7QWXyWRVB00538y7rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGVXUKuW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGVXUKuW"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423970cb30so607277b3a.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780590128; x=1781194928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TsI8RQzieUlpAHmgKxaAY5YLOW99x/YNL0it4/gpkw=;
        b=UGVXUKuWKwKI6E42P8JUFAdv8EEdq27oDTThHHOpBhNO/+6TGTdYL6H9tW4fXJ/gJ/
         GFX9E6MGJXGnIS8nMBjze3ljOxYi9dLxU5eXrrqaZULW3+32RorkjEBR3xSye17Qsf0M
         kMJT+IsuE4ljmuBz3+zKgJRKtZ2vq90C6NZcRerD/K/oIONmOyPsO/zmQ6VlAnZ86ZDV
         XH0FqzAbUYmIrZUWdx2Wg18T47hmnr93xUZ3co8c5EDM8r32s/9dSbs8bDXv5hpkeHwC
         3izHrdvvPNhWw9BOPIJACC6BULQ6TDha+33iBXkhIx6zQ5GwNpAbv5y23qphvCp+SXVw
         rZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590128; x=1781194928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TsI8RQzieUlpAHmgKxaAY5YLOW99x/YNL0it4/gpkw=;
        b=OBNNpI2SxseKiyVmlRYn1e6oqt1Pkqwkhq1Ucvdq3tnC7mRSjrCNht43TnvbML5FIm
         0PmxHtf4cw0U97B2MDJWsEKt36mdIbxkdnPBLE5rRYba+3wSX8k7QRJ43y3tCeSFIXoF
         y5WR8OH96eDI8JKGdGOxbzbrYndQnsOrZ2heA8L/JJlpWtRnEpabztPxo5Vk1tt5gTY2
         px4oqz1p5HU36LW/m87wMkAJQ1GjGfJe1De3FM27fPlSFX1LWVf/1+++PaFv1DLwx48Q
         w5UQ3m9os5aT+Ok0y7kr9AEdXfcGLLp9RQc4EchRt95KAm52ZnD+NgZ5KaAO2r25NN3Q
         kclw==
X-Forwarded-Encrypted: i=1; AFNElJ8ICRgQl4R0BWkAbFf4y5ChS0wgsRWvJLHNKhXoviwPCbtUkZeKjLzgZiY1KnwCD+ybDmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWI2zR8XDwqgn0y3k76QZCTx/+a/YW2DYYl/6U/HN42BUZ5Yq
	U4Xt+yzCQTEtg8zeqAhVI26oM48V8csZDzrxbceJinpVQ3iGx1CqT/v/SiGMfOGU5bQevlljmmR
	zyhFj8g==
X-Received: from pfbcz3.prod.google.com ([2002:aa7:9303:0:b0:83e:e011:246b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288c:b0:82c:d9d0:f482
 with SMTP id d2e1a72fcca58-84284fa6647mr8332841b3a.46.1780590128023; Thu, 04
 Jun 2026 09:22:08 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:22:07 -0700
In-Reply-To: <20260604020143.748245-8-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-8-jrhilke@google.com>
Message-ID: <aiGmL-8RKlVPbBwZ@google.com>
Subject: Re: [PATCH v5 07/21] KVM: selftests: Verify IRQ bypass works in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> @@ -76,9 +109,10 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
>  
>  static void help(const char *name)
>  {
> -	printf("Usage: %s [-h]\n", name);
> +	printf("Usage: %s [-d <segment:bus:device.function>] [-h]\n", name);
>  	printf("\n");
>  	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
> +	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");


	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");

>  	printf("\n");
>  	exit(KSFT_FAIL);
>  }
> @@ -100,14 +134,21 @@ int main(int argc, char **argv)
>  	u32 gsi = kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - 1);
>  	u8 vector = kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
>  
> -	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
>  	pthread_t vcpu_threads[KVM_MAX_VCPUS];
> +	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> +	struct vfio_pci_device *device = NULL;
>  	int nr_irqs = 1000, nr_vcpus = 1;
> -	int i, j, c, eventfd;
> +	const char *device_bdf = NULL;
> +	int i, j, c, msix, eventfd;
> +	struct iommu *iommu;
>  	struct kvm_vm *vm;
> +	unsigned int irq;

I think it makes sense to track "irq" as a signed int, so that the !device path
can set it to -1.  Then it can be printed somewhat blindly without being outright
wrong.

> -	while ((c = getopt(argc, argv, "h")) != -1) {
> +	while ((c = getopt(argc, argv, "d:h")) != -1) {
>  		switch (c) {
> +		case 'd':
> +			device_bdf = optarg;
> +			break;
>  		case 'h':
>  		default:
>  			help(argv[0]);
> @@ -119,7 +160,17 @@ int main(int argc, char **argv)
>  	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
>  	vm_install_exception_handler(vm, vector, guest_irq_handler);
>  
> -	eventfd = kvm_new_eventfd();
> +	if (device_bdf) {
> +		iommu = iommu_init(default_iommu_mode);
> +		device = vfio_pci_device_init(device_bdf, iommu);
> +		msix = vfio_setup_msi(device);
> +		irq = vfio_msix_to_host_irq(device_bdf, msix);
> +		eventfd = device->msi_eventfds[msix];
> +		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
> +		       irq);
> +	} else {
> +		eventfd = kvm_new_eventfd();
> +	}
>  
>  	printf("Injecting interrupts for GSI %d (Vector 0x%x) %d times\n",
>  	       gsi, vector, nr_irqs);
> @@ -147,8 +198,7 @@ int main(int argc, char **argv)
>  				    "IRQ flag for vCPU %d not clear prior to test",
>  				    vcpus[j]->id);

Print the IRQ in the assert.  Ditto for the pCPU in the future.  Providing more
debug information is nice, but it should *always* be secondary to providing info
in the assert/error itself.

		TEST_ASSERT(GUEST_RECEIVED_INTERRUPT(vcpu, do_use_nmi),
			    "vCPU %d timed out waiting for %s (vector 0x%x) from GSI %d (via CPU %d)\n",
			    vcpu->id, do_use_nmi ? "NMI" : "IRQ",
			    do_use_nmi ? NMI_VECTOR : vector, gsi, irq_cpu);


>  
> -		/* Trigger interrupt */
> -		eventfd_write(eventfd, 1);
> +		trigger_interrupt(device, eventfd);
>  
>  		clock_gettime(CLOCK_MONOTONIC, &start);
>  		for (;;) {
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 
