Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C1346E74
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154557; cv=none; b=XxCwuizD5cJ68PfdDXdu2Izoji9J9qbtkvOmIR9mGZClNW3Fjjz2i4W/+Zqbvs4phKE1L+elWAVMd01NEnPyISPxbC1sgN5+owsT2pumhoy2PoFhVHRPaXgHwocqdpMJkoZVR+TRofQQYlZC3E2onDdr3GFEEOIfRLz5CpPVpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154557; c=relaxed/simple;
	bh=Lq9Vsdtmw9mWQ8fpK2xIbVncRHl92ljreJitSqndqng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZoIgCYBBCF3Lw8utskYI3ltEEwp/PD6E5k66cGdraL7z/zOkzsxq46DHksKxEO7FAOaEFKJ0OVGo2I4r1qW9oIT+Ti5d6WZdWTppTJAjWZLnAmwT9g+ueEX8pz7Q6amelXujgPMBCjJ0J5+7/bCDCL2N2CHDqbycpibf+sipSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6Hmr2xB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6Hmr2xB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49245e10b73so17294235e9.3
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154555; x=1782759355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nac52aGX3C1Hx+TvqYDuAOPnfxayVFA5kQK+3l4OkYQ=;
        b=S6Hmr2xBTY1BpgDDwcStkzbIak+eG/e9ZXsQsdQtXL7isoBIJBpsNEcxdhb/f9HvjW
         QOkWxnBWKQq34Q4UuKHAGgFT4B++TwRAIt6BpO3KebvOCLj+Cq8UAkVlcod8xuOdKW4i
         uyxaAsHMiWDJt3woRO5N7Ur1JTi+XuA/ZYIuPpHlgpHzdlG+0SOrjp7dLShpHa4LTeDS
         tOr0c5sF8eKYqVJG+K3RRydLZ5gnttfzJLnduaEnHm8iOyodejPZCFb2j95Ne/WbdJz2
         45jsqQRj8q69w2OcMDbITBQo3Oxm/IWg2DF5hkU1hZUmxiFt2x3OrmU68vp8J2huwG/s
         I58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154555; x=1782759355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nac52aGX3C1Hx+TvqYDuAOPnfxayVFA5kQK+3l4OkYQ=;
        b=rNOxmhel8l3h9bCDLQ/S++M+SttPnL9kmbGgE6J4xZVaieuuW4KTad3b6FLrA3/hlK
         suFEXqTD4WM5BEznKwx68enQ8oz/WmENaCAr4wzLBaePQ7YkFCmo1mfHGgTrzdFIpOS7
         Ufbd/koZ+3qEBwJ+pquUDtjJpymlZmc35qkaBqxbKKsLww3ASFR3Zd86PZQ8iTF2s21a
         KxAwyOB4+KdrLJIR2a8+AlJP7YugBqeLhg6rIaS9yEktezxK0WZyIalVyFelBcNC5wG1
         6UQGWHqJSOaFgVUnqL+aHKIxIbIWeLl/BIh9Z+p10MqhBzxy67uDR/CrOider8gybese
         CHvg==
X-Gm-Message-State: AOJu0YwQE4CvbYJK0VKtn9Z3YjWkSXAx43usfvXC0rrZTR5lQVA/8uAP
	WWoh+wQxjiAvOFI2Eodx5VnUY6s5pTE/je7PucP/O2YOKc42iUxVn+cP5qtaAkuYCMBgPxG+lYx
	N5uVZfO95I16rf0O6bw==
X-Received: from wmbg28.prod.google.com ([2002:a05:600c:a41c:b0:492:413d:b354])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3516:b0:490:c2a2:e91c with SMTP id 5b1f17b1804b1-4924258fbbdmr240564905e9.34.1782154554506;
 Mon, 22 Jun 2026 11:55:54 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:55:53 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
Message-ID: <9huzwlvqqu9y.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 0/9] liveupdate: kvm: guest_memfd preservation
From: tarunsahu@google.com
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, seanjc@google.com, 
	ackerleytng@google.com, aneesh.kumar@kernel.org, fvdl@google.com, 
	sagis@google.com, david@redhat.com, dmatlack@google.com, mark.rutland@arm.com
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"


+ Adding More people to the series (To:) which I missed in my original message.

~Tarun

Tarun Sahu <tarunsahu@google.com> writes:

> Hello,
> This is Non-RFC patch series for guest_memfd preservation. After
> having multiple discussion across hypervisor liveupdate meeting,
> guest_memfd bi-weekly meeting, the design for the basic support of
> guest_memfd preservation is final. This series is going to include
> guest_memfd which are fully shared and does not support private mem
> and backed by PAGE_SIZE pages.
>
> Steps to test:
> 1. Compile Kernel with CONFIG_LIVEUPDATE_GUEST_MEMFD=y
> 2. boot kernel with command line: kho=on liveupdate=on
> 3. run the following kselftest
> 	$ .selftests/kvm/guest_memfd_preservation_test --stage 1
> 	$ <kexec> --reuse-cmdline
> 	$ .selftests/kvm/guest_memfd_preservation_test --stage 2
>
> NOTE: Assert the following:
> 	$ ls /dev/liveupdate
> 	$ ls /dev/kvm
> 	$ dmesg | grep liveupdate # (should have kvm_vm_luo &&
> 		# guest_memfd_luo handler registered)
>
> The changes are rebased on:
> 	kvm/next + liveupdate/next (merge) + [3] + [4] + [5]
> 	Where,
> 	[3]: luo: conversion of serialized_data to KHOSER_PTR
> 	[4]: luo: APIs to retrieve file internally from session
> 	[5]: selftests: liveupdate sefltests library
> Here is the github repo:
> 	https://github.com/tar-unix/linux/tree/gmem-pre
>
> V3 <- RFC V2 [2]
> 1. Finalize the design
> 2. resolve sashiko reported bugs
> 3. Use of KHOSER_PTR instead of raw serialized_data as per [3]
>
> RFC V2 [2] <- RFC V1 [1]
> 1. Removed mem_attr_array as it is not needed for fully-shared
> 2. Removed pre-faulted condition
> 3. Added vm_type preservation for ARM64.
> 4. Removed liveupdate_get_file_incoming api patch as it is sent
>    separately [4] by Samiullah.
>
> [1] https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/
> [2] https://lore.kernel.org/all/c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com/
> [3] https://lore.kernel.org/all/20260622111215.4157974-1-tarunsahu@google.com/
> [4] https://lore.kernel.org/all/20260613012521.835490-1-skhawaja@google.com/
> [5] https://lore.kernel.org/all/20260612214512.464146-1-vipinsh@google.com/
>
> Tarun Sahu (9):
>   liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
>   kvm: Prepare core VM structs and helpers for LUO support
>   kvm: kvm_luo: Allow kvm preservation with LUO
>   kvm: guest_memfd: Move internal definitions and helper to new header
>   kvm: guest_memfd: Add support for freezing and unfreezing mappings
>   kvm: guest_memfd_luo: add support for guest_memfd preservation
>   docs: add documentation for guest_memfd preservation via LUO
>   selftests: kvm: Split ____vm_create() to expose init helpers
>   selftests: kvm: Add guest_memfd_preservation_test
>
>  Documentation/core-api/liveupdate.rst         |   1 +
>  Documentation/liveupdate/vmm.rst              | 107 ++++
>  MAINTAINERS                                   |  14 +
>  include/linux/kho/abi/kvm.h                   | 106 ++++
>  include/linux/kvm_host.h                      |  14 +
>  kernel/liveupdate/Kconfig                     |  15 +
>  tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
>  .../kvm/guest_memfd_preservation_test.c       | 236 +++++++++
>  .../testing/selftests/kvm/include/kvm_util.h  |   2 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  26 +-
>  virt/kvm/Makefile.kvm                         |   1 +
>  virt/kvm/guest_memfd.c                        | 185 +++++--
>  virt/kvm/guest_memfd.h                        |  44 ++
>  virt/kvm/guest_memfd_luo.c                    | 497 ++++++++++++++++++
>  virt/kvm/kvm_luo.c                            | 195 +++++++
>  virt/kvm/kvm_main.c                           |  94 +++-
>  virt/kvm/kvm_mm.h                             |  15 +
>  17 files changed, 1477 insertions(+), 81 deletions(-)
>  create mode 100644 Documentation/liveupdate/vmm.rst
>  create mode 100644 include/linux/kho/abi/kvm.h
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c
>  create mode 100644 virt/kvm/guest_memfd.h
>  create mode 100644 virt/kvm/guest_memfd_luo.c
>  create mode 100644 virt/kvm/kvm_luo.c
>
> -- 
> 2.55.0.rc0.786.g65d90a0328-goog
