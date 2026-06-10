Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557932E1F06
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114767; cv=none; b=qvAgAlku6wrufjuXevO4de+E8SoB5cpALFT5a1KxedUkV+YYQ2+h/7BENLExCjSp0Ld+3I3CrZsbnEz+hOfkhYm7340r6Ltrp8Gsvw/5vGC4rr++BCtGNQ0qefPDkntvxH2BaecUne1b/62hJpK55Fj5q7vGsxKbVTQDbXcoeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114767; c=relaxed/simple;
	bh=k6GjeYxgByZDSIuzADvt///QHoQS2Zd6HyjRvMqVz9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U4MluhGkACseYkHqtN1jRIWrJWGz/QhDabw1Hoh3nTPi9RbbmyYbi4xpDQ7mOpbOY79cSfWOpB/rYkiXMUwOU9gCQH/b++cGI4itDipIQagaJiwJ4Bd/GIOZco9fxSmTUdO9nuBxpl9SLH3L5FmTc4BjuWEEs3g3L4/I80NaMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPDEuxoV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPDEuxoV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8428419982eso6125146b3a.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781114766; x=1781719566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkFkBgd+xuByNIegpgrKJZN9LP1SaVEtSyMl1cJUNS0=;
        b=uPDEuxoVQ6yPs0FGagoTsDLJvp1mYlq3025SwMzEtUnubH+8kFxxvXtM6s0byKbLwf
         Wyc7yhMrkrg8+/lNRrqzSg/MYobSqLG0+zPUQ83sRrqIPaCe4cdz7SiXj7uGkZvVqE/r
         LqnO2wS7G7AJmRVsGupkKVgx8lHdNIkfU5BqvfAGiW2ZflF310tx/ac8tdXSgGEIk7zH
         H84XG5soQNVURQOa17DOBv5+easX2aIxhT6irClbM8hyHNO0aqBbB6lGsqwHUIdZguIy
         cLZ3my3OJSrYMBjjyt4msG2Rde2tbweyixUdUcUPjvqpJ5uQlJLKxCBmAji70KCMIoe9
         plKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114766; x=1781719566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkFkBgd+xuByNIegpgrKJZN9LP1SaVEtSyMl1cJUNS0=;
        b=Yzy5z9hf7LM+Qt4UnrCRgvcipKrVPiikAwQuOGe2+gPW86CaiNDN12ei0HQl8fqm7N
         LVtONFUy4B0Wne4q3+2ODZiGkum3uFKQVmLYSWLRt52sy8tayRAJ8dEYrG9lUbIKZm5h
         bnTifi6vf/vT+kZBeI6Q4O/LcidojEB7TPwty/iBjdJR4usTU3qo4/0pQEVn91XLouNX
         LYH/+IsvZgvcxngXeiwhhpidBEOs6CsiOzXuTfw/KLxsoGv2WU8Sw2cUNiMBCbv4PRd+
         q1mcYomBaJ4BVRJECUlpUM2gj2PSAqJ+zOH7nTNIQEwkX7ZPjLxOB0slTEhKydeSQjjn
         ucjA==
X-Gm-Message-State: AOJu0Yz0Z2tdE117Bs9xdCJ26lNpfvzfaXvEfTiEEuNxuH/T3cqDYQRc
	yupmWPxRbKkPY+M4TUx4lJXnWGZnX5GfZnfd5hUwgMJcdZ6tjgPerwTUJv0HKMhKYJcyPbufKg/
	yybBTcA==
X-Received: from pfob8.prod.google.com ([2002:aa7:8708:0:b0:842:47f8:d51d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2303:b0:842:3be7:4d55
 with SMTP id d2e1a72fcca58-842b0e588c9mr27119419b3a.11.1781114765452; Wed, 10
 Jun 2026 11:06:05 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:06:04 -0700
In-Reply-To: <20260610010517.1333F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-8-seanjc@google.com> <20260610010517.1333F1F00893@smtp.kernel.org>
Message-ID: <aimnjHurnYPMI5ii@google.com>
Subject: Re: [PATCH v6 07/18] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> > index 9f8895b898214..6888be54ee4a9 100644
> > --- a/tools/testing/selftests/kvm/irq_test.c
> > +++ b/tools/testing/selftests/kvm/irq_test.c
> 
> [ ... ]
> 
> > @@ -74,11 +107,29 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
> >  	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);
> >  }
> >  
> > +static const char *probe_iommu_type(void)
> > +{
> > +	int io_fd;
> > +
> > +	io_fd = open("/dev/iommu", O_RDONLY);
> > +	if (io_fd >= 0) {
> > +		close(io_fd);
> > +		return MODE_IOMMUFD;
> > +	}
> > +
> > +	io_fd = __open_path_or_exit("/dev/vfio", O_RDONLY,
> > +				    "Is VFIO (or IOMMUFD) loaded and enabled?");
> > +	close(io_fd);
> 
> [Severity: Medium]
> The commit message states that the test will auto-probe IOMMUFD vs legacy
> VFIO and skip the test if neither is available. However, probe_iommu_type()
> calls __open_path_or_exit() on /dev/vfio.
> 
> Because /dev/vfio is a directory, open() with O_RDONLY will succeed if the
> directory exists (e.g., created by udev or left over after a module unload),
> even if the VFIO module is not loaded and the character device is absent.
> Opening a directory does not trigger the kernel's character device module
> autoloading.
> 
> If this occurs, probe_iommu_type() incorrectly assumes VFIO is available and
> returns MODE_VFIO_TYPE1_IOMMU. The test then calls iommu_init(), which attempts
> to open /dev/vfio/vfio and will fatally abort, resulting in a test crash rather
> than a clean skip.
> 
> Additionally, using __open_path_or_exit() will cause the test to exit rather
> than skip if the path does not exist.
> 
> Should this probe instead check for the /dev/vfio/vfio character device and
> use open() instead of __open_path_or_exit() to allow the test to gracefully
> skip and trigger module autoloading?

No, "probe" here means guessing which flavor of VFIO vs. IOMMUFD, it doesn't
mean probing a kernel module.
