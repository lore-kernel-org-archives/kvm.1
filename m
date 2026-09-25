Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054604A1E00
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376309; cv=none; b=UpxB/HRtjaLpz+KgfYVb8p3kZHsbAY9bckY/gumH4QTis6rcBiJrYukMwYN9LOwBgpc3vhQofSInoB8Lmzv8MsjMLSo3baZO+d/i9jrDnFo52MjX1KhA4OWCxMlGrKH+Ny1wIfUPujYu2taefHEmn5eUGiiaaxcEEq67hW9oArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376309; c=relaxed/simple;
	bh=z6JThd3aqFFh8fa5B8pc8rqv1B/ffmCOoZi8YXrb7Rw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gb2zU1Rv9lrT0FSQG+SFA380SCkP5He4GUEPrAKgv+3uWr9KKMI+kfD4AfsU/8CZVikvytja+WR85nO305vY5kQh2IxvIovI75IBGrBCm15vK5rx4EhdIkgYBaXlQwHohPr4s7RN/HbSYRiZl51i19VKhxl0KefsuV8ObbLqDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAHAiFC5; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAHAiFC5"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd188e16a2so11246655ad.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790376307; x=1790981107; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUufA7Nzcf7y1+qvhpU7DrvMHG5vRD3HmEG3zED0/vY=;
        b=wAHAiFC5lUYTTGK77SVl4bd3jjoQWRBZFcYxaT8EBfxLoLtZUYzxCSUBEWKAazMNsl
         41EIhEDt0N36WHoE7ATE3WU5Q049E31npw03QBmxBxQtqCTpeVoSYYjXKkARZPTM608W
         lHvxb9uSkW0jr5BZLOVmteOXfnOxDBMAJws3qTmjlsnrsauVMT+Li4gZvAvxWCeHW2rc
         j1XTMnpVZ0jg0B6tlpL2oCjEx2vVpY/PBPu4L0XCKyjXTJgyC+H3KGfC8PZzuWVYLKmw
         arzrYQ94KLkiM4e0nUCN1nca6W9C7/RIkXl2NL8nozBFIcaXBK1QVxe7FToCDkXVCUm6
         hhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376307; x=1790981107;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUufA7Nzcf7y1+qvhpU7DrvMHG5vRD3HmEG3zED0/vY=;
        b=olg5TG646zmhwKfM/SIlAOdT/cdYZRHENsd/UcoyfiBMifFuUZUrjfcFOos7OxXJvS
         w3UxVwWQ/XrtvKhaJCZT0h0Ii+Bd/nJVhODCRAlrIe2hiNrxZm32FlhxatXofbp13e6n
         CH+W3K1nbD6/JAdsq5zmpHAbfu5Ps2DccVIF2/BnJo+mX7A3w/bj5DitvsUCkWF6XaAl
         uMxy4X5pyMPHohclbkrjeLhUoVzTpRwCaMM7koJ0Ri5bqXjNKBnl9iCEDOy/Nriocp95
         ++WUGzldYhpghqNqrndaESta5a/06nffu6s3tf1ygLw+QJ5ZqfvbJ6CUli2AyrgoT+4e
         VxvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCg6uBoC0phS6EEGNb+WWsdOmJW+MiHQ/vr45VDsPh0sWvPSxpwcQnxqZLN0GDNX0ji88=@vger.kernel.org
X-Gm-Message-State: AFuF++k70rWHCmRDWcatVfmM90EFyFsZidHQP+4eM/WBMPvnrBO+olm9
	27r1qiHrQ5qD04EI0U5geLmsLNarOHRTxzj8Vk0PzENdyPVED/c5o8yHpbookqegT2wfpnBpiZR
	7zezGuA==
X-Received: from plem9.prod.google.com ([2002:a17:902:e409:b0:2de:a2e4:f48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1acc:b0:2db:210f:c104
 with SMTP id d9443c01a7336-2df7da60bc5mr58208995ad.10.1790376307053; Fri, 25
 Sep 2026 15:45:07 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:44:51 -0700
In-Reply-To: <20260619152006.3684428-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179037626663.2353544.9535219829036462834.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH 0/5] x86/apic: PV IPI robustness and
 subtest selection
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 19 Jun 2026 08:19:23 -0700, Jim Mattson wrote:
> This series improves the robustness of the APIC test suite, introduces
> generic subtest selection, and adds a new test case for a PV IPI boundary
> condition.
> 
> 1. Robustness: Skip the PV IPI test if KVM PV IPI features are not
>    supported or if not running under KVM, preventing false failures and
>    potential #UDs on bare metal or non-KVM hypervisors.
> 2. Code Reuse: Hoist the command-line test selection helper from
>    x86/vmexit.c into the common library (lib/argv.c) as
>    argv_test_wanted().
> 3. Subtest Selection: Refactor x86/apic.c to use this library helper,
>    allowing users to run a subset of APIC tests (e.g., via QEMU's
>    -append option).
> 4. Refactoring: Extract the KVM PV IPI hypercall inline assembly into a
>    shared pv_ipi() helper.
> 5. New Test: Add test_pv_ipi_sparse() to verify PV IPI delivery to a
>    vCPU with APIC ID 255. APIC ID 255 is a key boundary condition (the
>    xAPIC/x2APIC transition point, and the MSB of the 64-bit cluster
>    bitmap used by KVM's PV IPI hypercall). A sparse topology is used
>    to verify KVM's handling of sparse APIC ID maps.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/5] x86/apic: Skip PV IPI test if feature is not supported
      https://github.com/kvm-x86/kvm-unit-tests/commit/6d3b20008057
[2/5] lib: Hoist test selection logic to library for code reuse
      https://github.com/kvm-x86/kvm-unit-tests/commit/8ba01c764a8e
[3/5] x86/apic: Support subtest selection via command line
      https://github.com/kvm-x86/kvm-unit-tests/commit/6389f4189d27
[4/5] x86/apic: Introduce pv_ipi()
      https://github.com/kvm-x86/kvm-unit-tests/commit/160394cff670
[5/5] x86/apic: Add a test for a PV IPI boundary condition
      https://github.com/kvm-x86/kvm-unit-tests/commit/1a50e4fc12cc

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
