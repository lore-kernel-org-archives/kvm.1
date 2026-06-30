Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CADF477980
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851311; cv=none; b=dZv7HNZUatM76ICnaxanTKnsLf+58uphJfAmJ6ioLPnA/xIyKXcFc9VyVr8npU631qREn0EMc3vg7woXRMgxHb0DVOxG402LWr81KwW+QH68Z9dt5oKjXrWjT1UxUvKjQrxDRVcr6XDL6n+UewYQVoqEqSGk/8u8tZxZ70c72fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851311; c=relaxed/simple;
	bh=rxamu2rGGGx9QZ6hKUuDCTsNwZOhfsUKNwH4GKdQsZY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lo5u9nYNfOpOLnnRKy4iWNVf7L1xn4B8Gw9gqqWibVM/0MGNpjrY/IvsWLfr8N+LyyenhF7nVIGKPIKu+DMVAv5PcCEl6zPI7O7pJsYbCxbjjARzcl/TtUIM3ZHKC24zvpwROlP+6Y/4a4iRNZJ6DvLYm3vOQ7613O4JIWuREv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRdY4HBd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRdY4HBd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c891ed872ddso2785724a12.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782851309; x=1783456109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MR186Hoh2470tDoen5ZaEyYedsfWXOSEhT3KgJ08AU=;
        b=WRdY4HBdVj/vYUoPl+7PBQhR0IIEiRxdTqAska5vJSmkyes4E7UYCIxFUzvAkdUVwr
         72Md7uAVqkadKoqqFiRd2S7VyMRImZ0dceAsg384T6SSSQmcy2zLhOD1RioXbqV2OthY
         hAFR5WCOfZD9ocONusA3Q0i6NB7YDKJXfEHJmHKdLMzKwV0YM/11Trizln38BWswR7Yy
         IAARpJ6gsygWLSxJTPBl8pC03880do3wNL/i0cUVT/Ousi8YCBigzHafd6ET6hZjMu9q
         rth2Igs+PrLLOQABrOoP0JGlJbVQIQPojKMiNq7rtehRKxQqsfAlOq2/xlectET60aTt
         UppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851309; x=1783456109;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MR186Hoh2470tDoen5ZaEyYedsfWXOSEhT3KgJ08AU=;
        b=FILV4iuMKsSb+mDIUS8vIVjSgE4Y2FLmPJLqk39jXoUI4jwBxqDGz1MET7Z3kbH7BC
         6iDkTqdxcjwa630IvbifyvankoW1AxFzw1UYs9vlGOaCQJ7u48I76DZzxkZ0beuA3xLt
         at+boaebjrS02+U6fZnodCIgHX4Mt5WyYo9rbMLKP+05eowheHZS/DnPIWX819IX6cQZ
         81QCIaFtDdE0NPWEvZAlmKB1Br6Maghk+PmkPXVWMOofk9PdorNsKf2lyVo+PoI9joVw
         1/RO1HKlq7xkDDTgq3rwL5xzZOzWMFy1Edatl1XPo1j8RVNAjmd+q6HGeqkwy2EHqbmt
         sdvg==
X-Gm-Message-State: AOJu0YxhHDaeSUjv0T1rHKJoGNXe7fJ1nLND8r4gF3Afu78rVJFZt8g5
	8aoqOI6Lz4uMjoKfR1zfBlWrNrwNjttVAsFRXnPcRSX4s2e03ZeLhipKTn3RX1c35U7r08sc/YN
	6Ph2CSQ==
X-Received: from pgid18.prod.google.com ([2002:a63:ed12:0:b0:c93:5d65:8f45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a11:b0:3bf:a36c:5496
 with SMTP id adf61e73a8af0-3bfc54d0addmr4419957637.55.1782851309353; Tue, 30
 Jun 2026 13:28:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 13:28:25 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630202828.440724-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: x86: Convert nested ops to static calls
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert nested_ops to use static calls, mainly because the nested ops are
bizarrely different than the x86 and PMU ops, and the kvm_x86_ops.nested_ops->
code is an eyesore (IMO).  I haven't bothered to do any performance testing.

v2: In patch 1, keep the get_evmcs_version != NULL check in kvm_get_hv_cpuid(),
    then convert it to a RET0 call in patch 2. [Sashiko]

v1: https://lore.kernel.org/all/20260625233846.3407303-1-seanjc@google.com

Sean Christopherson (3):
  KVM: x86: Reject nested CAP enablement if nested virtualization is
    disabled
  KVM: x86: Add static calls for nested virtualization ops
  KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_ops

 arch/x86/include/asm/kvm-x86-nested-ops.h | 36 +++++++++++++
 arch/x86/include/asm/kvm_host.h           | 14 ++++-
 arch/x86/kvm/hyperv.c                     |  6 +--
 arch/x86/kvm/mmu.h                        |  5 +-
 arch/x86/kvm/mmu/paging_tmpl.h            |  2 +-
 arch/x86/kvm/svm/nested.c                 |  2 +-
 arch/x86/kvm/svm/svm.c                    |  4 +-
 arch/x86/kvm/vmx/main.c                   |  3 +-
 arch/x86/kvm/vmx/nested.c                 |  2 +-
 arch/x86/kvm/vmx/vmx.c                    |  1 +
 arch/x86/kvm/x86.c                        | 66 +++++++++++++++--------
 arch/x86/kvm/x86.h                        |  2 +-
 12 files changed, 104 insertions(+), 39 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

