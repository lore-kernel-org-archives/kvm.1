Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6541DDF5
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057322; cv=none; b=BmUhU+UhlW2M1kRvqFsGTz1cbM+gEOwxGHRCZ6nfyJj08iOVq2w8kEH3kbQkiAcPgFRgpsJuSP/KUOj0ziqmbXYHLTRgM0sbjwqdcucdCLzb+Hw2MWCqQeer2vTaHGmED/uk0KefRJGBYj7QivVLVGy967+ZbOc0Pd9ZzquVANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057322; c=relaxed/simple;
	bh=omY+XeqIxQR3XGclZjHyVvEQfVAPStHcPBHt1VCngx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kfH+NBgtorVRdCijggYvBDINRFkPl/zbbwTm/++dD2L5cKUMwA9fLlPRJtKNTJOeETDpFEki3mFaepMe1//O8WiCgNtmX4SfbBWJlKUR7NmXAcqiICjE9AxWVX0E1jSYYevFyHHvajfi2FFsfpqxNxcohX6pFKiw5wqTfNDRtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1lSkbFc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1lSkbFc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8486ffba174so7752764b3a.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057319; x=1784662119; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBGhEX4vBKM8MPYzbmWcF5BLvWSJh5ejL+Gu8q+yPyk=;
        b=g1lSkbFcJNQ6HlD/3Yltp9dv0Wa2D7EMGSi7ecWK8oe7QkSzMvbtwd7qLKK8Bmnnkv
         xp+EGQh8exazxWGvA4+fZDy/JliRhOPWZyeWw3egxvJv01188yVNpTfuPbuLyraqLHm5
         07fVKi0updbVh9xcyAstRCbyZtMsjyo3W58ANYzVMLYHd9d03ZLVB+oiJtbW0RAT3sDz
         ErfnxM92n3G6f4gyw1UbIPtqY5/BNOwCvUT9rdM4T30SxHxERNVI6GB7N0M3iUfrU8U+
         /7073z8MYpzxLIDI0nLDC3RDw+81znE14Tpipm2dhMaNsoDgDRWfN4XTKfeYHCo0zR36
         fERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057319; x=1784662119;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBGhEX4vBKM8MPYzbmWcF5BLvWSJh5ejL+Gu8q+yPyk=;
        b=WDFyWaRBzqvKJnws6CReExjM4EndnFrJJcuH9cgYZHedRa3PzCJzhZ6MwPzibubOvu
         7wLqamJiOXR02tbdFAaHaa6wfHbTZN7Dk8U3VjQuaVAQepvW3aXffZtdGMs1x6/46V9P
         51//uhDi68GUdYvzV1zlnVMbrzAv2zl3e9ixFyR/qvymviZf8ik981IAKid5YhPWrIuU
         2j773ZYZWAw8HGAuart0kY/Bdw6IcWvIGfVetNYTJrmhuvXLXf+XwJ+jgzMyhIvmeU1i
         ZGdbdXlp9azo7VB7OcroZbuq+9UaAdsjTNdGhJ1ptP+Dfho8S5KO1KlDj3+IuCsBhpUr
         yKNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2fJJdDrWNKcTUy7eMa0X+VvSBmcVaddqVXeBbV/FQXX3a/r9rKFR89yuXx7qgSRpyIHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1NP+N87TKYy2yUgvPb+AO3uvL9oBixppvl3DDC+DvmLaCY8M
	s0RXxjT79A+LhzvOMekcVNG0Id3CAQNaxMitsl/kmZspd7uUmv4iEobPgtKo+DTBAr2JhZ1rsSI
	HsiYcXQ==
X-Received: from pfbfo5.prod.google.com ([2002:a05:6a00:6005:b0:848:40f5:a538])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c95:b0:848:3fe2:c88b
 with SMTP id d2e1a72fcca58-84a554fa556mr3829342b3a.6.1784057318776; Tue, 14
 Jul 2026 12:28:38 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:17 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405411600.3133617.3225227983277758474.b4-ty@google.com>
Subject: Re: [PATCH v8 00/20] KVM: selftests: Add eventfd+VFIO IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 26 Jun 2026 14:35:13 -0700, Sean Christopherson wrote:
> David and Josh's series to add a selftest for verifying interrupt delivery
> via eventfd (via KVM_IRQFD), and also from a real device, wired up via VFIO.
> 
> Gory details in the patches, and in the v5 cover letter.
> 
> v8:
>  - Explicitly include <time.h>. [Sashiko]
>  - Use iova_allocator instea of hardcoding the IOVA. [Sashiko, David]
>  - Add a comment explaining why DMA needs to be allocated. [David]
>  - Probe /dev/vfio/vfio, not /dev/vfio. [Sashiko, David]
> 
> [...]

Applied to kvm-x86 irq_test, thanks!

[01/20] KVM: selftests: Build and link selftests/vfio/lib into KVM selftests
        https://github.com/kvm-x86/linux/commit/a262fc49e0aa
[02/20] KVM: selftests: Add macros to read/write+sync to/from guest memory
        https://github.com/kvm-x86/linux/commit/ac050f2adcdf
[03/20] KVM: selftests: Rename guest_rng to kvm_rng
        https://github.com/kvm-x86/linux/commit/e0bd29eddf7e
[04/20] KVM: selftests: Initialize the default/global pRNG during kvm_selftest_init()
        https://github.com/kvm-x86/linux/commit/bae85cd758fe
[05/20] KVM: selftests: Seed libc's RNG before using it to generate a seed for KVM's pRNG
        https://github.com/kvm-x86/linux/commit/5506feb24282
[06/20] KVM: selftests: Add helper to generate random u64 in range [min,max]
        https://github.com/kvm-x86/linux/commit/c772591d279e
[07/20] KVM: selftests: Add an irqfd send+receive (and later IRQ bypass) test
        https://github.com/kvm-x86/linux/commit/3ceab37ac973
[08/20] KVM: selftests: Add helper to get host IRQ from device MSI-X for IRQ bypass test
        https://github.com/kvm-x86/linux/commit/362cc0016249
[09/20] KVM: selftests: Add VFIO device support to eventfd IRQ test
        https://github.com/kvm-x86/linux/commit/3902e8b02dce
[10/20] KVM: selftests: Add a helper to set proc IRQ affinity for IRQ test
        https://github.com/kvm-x86/linux/commit/380b0e5e0e30
[11/20] KVM: selftests: Verify interrupts are received when IRQ affinity changes in IRQ test
        https://github.com/kvm-x86/linux/commit/197b0cd9ac66
[12/20] KVM: selftests: Add option to set empty routing between IRQs in eventfd IRQ test
        https://github.com/kvm-x86/linux/commit/ec333e3ace25
[13/20] KVM: selftests: Make number of IRQs configurable in IRQ test
        https://github.com/kvm-x86/linux/commit/38950af64a1c
[14/20] KVM: selftests: Verify non-postable IRQ remapping in IRQ test
        https://github.com/kvm-x86/linux/commit/25e268b76e77
[15/20] KVM: selftests: Add kvm_gettid() wrapper and convert users
        https://github.com/kvm-x86/linux/commit/4512b2776631
[16/20] KVM: selftests: Add kvm_sched_getaffinity() wrapper and convert users
        https://github.com/kvm-x86/linux/commit/76703ca0cbab
[17/20] KVM: selftests: Add a utility to pin a task to a random CPU, given a CPU set
        https://github.com/kvm-x86/linux/commit/26fd1fb4737a
[18/20] KVM: selftests: Verify vCPU migration during IRQ delivery in IRQ test
        https://github.com/kvm-x86/linux/commit/6b9470baea6c
[19/20] KVM: selftests: Make number of vCPUs configurable in IRQ test
        https://github.com/kvm-x86/linux/commit/0315713a1938
[20/20] KVM: selftests: Add xAPIC support in eventfd IRQ test
        https://github.com/kvm-x86/linux/commit/2708ecca4dbd

--
https://github.com/kvm-x86/linux/tree/next
