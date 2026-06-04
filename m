Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AF4CA290
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595782; cv=none; b=UI7Kht9PSempbp9Xd8w+kwZhT8V/A3eflVNhEI/GdvNVS+Q1IdBjMkPGNqW50xQCgrg3AXXcTzYapFkhRQAmM5BFntL2iJPYc2O+AoflJjWVxW4iIyotf8sygAOyb5xzC3sL1fEi1D4Eo0DoNUfTZgXTl4JUrTOp4rTB0RrJ6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595782; c=relaxed/simple;
	bh=BJKSJ0f1ghLKefz3RvJxRJoHhEprzQsxYPHdnQCwk0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CbrMMaAT/vAUDOvTy0rV6FbtkxRVRVZC4HqyPf0OSlf90je01RfGyA1fKWTqzA5NK4uCg/D11vkr8GzW8BoN44oJJXDcP2wJG8f3NylDyvWIp0uRLuWNwnx0DMdoV8f6UrQAQPcsSEmM0AqjAT62DwAQfpH9VUgoN3PjXDcxwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OREm1alv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OREm1alv"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8428384f31fso744606b3a.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780595780; x=1781200580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gT0auPM73vpy21EPQcsi9jdaJb4vCSUAPDWuR3ICNLE=;
        b=OREm1alvflHAvccs15J9+KSUt9Kd2n87lT9D8LydQlI1E5exB1+yCGUckcaTQCe1uM
         QCFnmZXZRTzcjlDK+omGCddSZi41zmCfCGNLGOp3zuMzAWHxDU0YzZjHzBp1eYKE1xj4
         nYrmRDVnSB57n12CLoEw3Mg9FzMZmrEeo8pGwIdY/BWszbLoZxjsyVBXvZS3mZAjfZiz
         jjxNy9Rr6KqIOscK+NAj1tEXg9KeOUXIf7P2eIU4P8rtbNw6H28KrAOfTfudPkgOaW4q
         MwbLGQ227FxdvbxkenswA9dHgfumz7eI8joBwFrH4AZeJNVOySkJ9nsEe6sM05a28HSm
         KnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595780; x=1781200580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gT0auPM73vpy21EPQcsi9jdaJb4vCSUAPDWuR3ICNLE=;
        b=G8zbqJayiqJ7eyds/oluOiujG6P0uiM01dcJ7pbxpwzXYgl1JdcqTFg0hsyyUg5MaO
         fLUYWRyPmgWcGlvaPkK77OauI3nyCrYMSSMIY2xnAaACWjLnt4WfpuQQ8mvR1ZVZhtFp
         cjSM+eYC0BhihuRgJgWps+l5+KoMswvMO45pFVdqolxwkFyHSFnHn/Ps4ZatAK6ugJZw
         BttTun/CVj57hd0vQZACgaXgZmphexODkU47haJbMmwt/pXqEuhkmuLgKgV0ua3lHCjV
         fGNivnx7Ohul2S/2DbW20CMM/3j+7lddyVWARTt7gSm2z21ITelUi+C1SWEHL6mGwsu9
         +rHg==
X-Forwarded-Encrypted: i=1; AFNElJ+YRGS8TnXn2Tk66k5pd0Yn1UXI9cOuyK7MUj5lUh7sxILyBJ4YWJq5dDCuxcdCUv/jk38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWlXgLtlJNxupW7O2FhiDHA6+3abVmQ5iaZY8tv116TKjniUzj
	/ynONkL3WPCSpJ4yMWogpq2DvtiIwK3ZT8XCryInn+TT5bkfKCLG9LY50sY8nBGLvVExwWFiAk+
	LFZhj8Q==
X-Received: from pfbcz12.prod.google.com ([2002:aa7:930c:0:b0:83e:c835:edc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d20:b0:842:21f0:5113
 with SMTP id d2e1a72fcca58-84284f790c2mr8883901b3a.24.1780595780380; Thu, 04
 Jun 2026 10:56:20 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:56:19 -0700
In-Reply-To: <20260604020143.748245-8-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-8-jrhilke@google.com>
Message-ID: <aiG8Q31nF2L1gNwa@google.com>
Subject: Re: [PATCH v5 07/21] KVM: selftests: Verify IRQ bypass works in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

The shortlog is at best misleading.  There are zero guarantees that IRQ bypass
is supported and enabled.

On Thu, Jun 04, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Trigger interrupts from a VFIO device instead of emulating interrupts

It's not emulating, it's synthesizing.  Emulating implies there's a device of
some kind that the test is mimicking.

> using KVM eventfds. This verifies that guests receive interrupts via IRQ
> bypass.

No, it verifies that delivery of a VFIO MSI-X through VFIO=>KVM works, and *may*
verify IRQ bypass.  And all of that very much relies on the eventfds to be in
place.

> @@ -119,7 +160,17 @@ int main(int argc, char **argv)
>  	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
>  	vm_install_exception_handler(vm, vector, guest_irq_handler);
>  
> -	eventfd = kvm_new_eventfd();
> +	if (device_bdf) {
> +		iommu = iommu_init(default_iommu_mode);

This needs:

diff --git tools/testing/selftests/kvm/irq_test.c tools/testing/selftests/kvm/irq_test.c
index cf4568718cee..2e7e100d4815 100644
--- tools/testing/selftests/kvm/irq_test.c
+++ tools/testing/selftests/kvm/irq_test.c
@@ -235,6 +235,8 @@ int main(int argc, char **argv)
        }
 
        if (device_bdf) {
+               __open_path_or_exit("/dev/iommu", O_RDONLY, "Is IOMMUFD available?");
+
                iommu = iommu_init(default_iommu_mode);
                device = vfio_pci_device_init(device_bdf, iommu);
                msix = vfio_setup_msi(device);

So that the test skips instead of failing, and to provide a helpful message:

  1..0 # SKIP - Cannot open '/dev/iommu': No such file or directory.  Is IOMMUFD available?

Because bluntly, the assert from the VFIO infrastructure is awful:

  tools/testing/selftests/vfio/lib/iommu.c:448: Assertion Failure

  Expression: iommu->iommufd > 0
  Observed: 0xffffffffffffffff > 0
  [errno: 2 - No such file or directory]
