Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569632DECD3
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515662; cv=none; b=ckDvMiWJTrap+hDNSeQf5N/w+E8iev6yDiS3oce5v/tY5QdTNNPc4Vq0KwXLqJiqi4tsYu/7cbkFOtwGki98yQFzjWmbQEjVhskKkHMzWIsVqfMdWkjzvch85vx7cp1kihoNe7G/bSNoyQZsA+gUbdRAp5mBiVdqAjXjWpY6aZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515662; c=relaxed/simple;
	bh=WI6EEV7DkYcS4010cYThLDi+CUB1ZZRYSLAEfPYAzSM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aYoiVkKtS5sdYgV394kCq8LT1IzqL2E5dBFu0j9pT8Adn+IAs/D+S3VIKsRDUiaMdMAfcJv/pURvB4xwYVfh6z4/aCYbxKlACEWUsfpzKmHmlXxZVVEPJUv807VZldGMyRF2TN+UyqTV8qC4fnLSGfKcWeMQXWI88lWsl507hEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8Ht9bFM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8Ht9bFM"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845c9b303b4so865746b3a.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515660; x=1783120460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6oeuLIgIp8Ap/tdPEY25lL0kvoDgAnckkPY4D/+jCk=;
        b=S8Ht9bFMXEU2uMfT3AJy0+qN63HOjxEYWPzTjWBMq+IR7yOQqUw6ToAFoUK7RvZ1WR
         Mg/dkixrnNeP662L0zjQ8aT7R2fGHWjRCb7a0baKM5X5xb4vvh6oAIdZrQjjVNMIaZCv
         x6ld2lzmN8a66e46GM9/qaA5+57941V0X9nDNrkDmhCf8arlg9zHbqZycdj6RPRxsB3w
         YECFKiLPLPAvqWWo/6Fl3dr0EI294XJeWQHUf7oF7bIAsL0iR3OwQ1QOKCGbkVMO/QPp
         A8aDmVdBorEeanG3AkRA1MEZIEVt94imH85haKpNrFJbjW17Xq1r54NQ5p2mcppy3yF9
         Lyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515660; x=1783120460;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6oeuLIgIp8Ap/tdPEY25lL0kvoDgAnckkPY4D/+jCk=;
        b=auZz87OTvDcDpLJeAdJfUXNkc1qhVGuORg39IyKOCzGcSzRPtNOgmVOVDHEDHvFhdp
         pt4+0IG2bPHfVw67evvYrpkRo9l2Ar7nshH0zs5EqZ7+3ZuSUEqzeq6ka3ulKkYNZpze
         +WnqB2DiOHmgvG4dJynPpObsN6SbwB29ToT1IjLkrzNK7nvN+/gioK6QsJc73DxLWIW+
         IuHIt3oUBlo5IGhs0YMSBhnrXJkRt8PWimJbuwmsgQqXIM3oke3AYqh9kujYNGyj+Jx5
         XKQSg7hhBguEhQyjnyO1iWbMd06rncs6XD9+Sf7AWb8l+SUbvnZfwRj8niUXVj6Od3lk
         gOyQ==
X-Gm-Message-State: AOJu0Yy4I4/xYf56BdU0t9rjQe3oX9IIDh8VEzmpz8WMxPu+fWW4fgl5
	m2eMdQRezgND2Rjr+wwRaDNjWQAIAxHM6YUH1OKZ7mhWS8qT4s4SLSiBXY7hOnhJj5Yt7ZI7LIc
	JmO58VA==
X-Received: from pfbgx4.prod.google.com ([2002:a05:6a00:1e04:b0:842:3bd7:f2bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8c11:b0:842:672e:7b5d
 with SMTP id d2e1a72fcca58-845b39f9acdmr8960486b3a.17.1782515659388; Fri, 26
 Jun 2026 16:14:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:07 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-1-seanjc@google.com>
Subject: [PATCH v2 0/9] KVM: SEV: Fix RMP #PF due freeing in-use VMSA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework KVM's handling of guest-provided (and always guest_memfd-backed) VMSAs
to forcefully reclaim VMSA pages when the pages are being freed from their
backing gmem instance, e.g. in response to PUNCH_HOLE.  In the worst case
scenario, marking the page SHARED in the RMP will fail due to the page being
IN_USE, ultimately leading to RMP #PF violations due to guest_memfd freeing
the memory back to the kernel while it's still assigned to a VM.

Note, the implementation nearly identical to that used by KVM for VMX's APIC
access page (which isn't guest controlled, but is migratable and whose PA is
shoved directly into a vCPU control structure).

v2:
 - Invalidate VMSAs if the memslot is DELETED or MOVED. [Sashiko]
 - Limit stable@ patches without a Fixes to 6.12+.

v1: https://lore.kernel.org/all/20260625222229.3367197-2-seanjc@google.com

Sean Christopherson (9):
  KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP
    guests
  KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
  KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
  KVM: Rework .gmem_invalidate() into .gmem_free_folio()
  KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into
    kvm_arch_flush_shadow_memslot()
  KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back"
    halves
  KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is
    zapped
  KVM: x86: Guard .gmem_prepare() declarations with
    HAVE_KVM_GMEM_PREPARE=y
  KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid

 arch/x86/include/asm/kvm-x86-ops.h |   8 +-
 arch/x86/include/asm/kvm_host.h    |  10 +-
 arch/x86/kvm/mmu/mmu.c             |  76 +++++++++------
 arch/x86/kvm/svm/sev.c             | 152 +++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.c             |   6 +-
 arch/x86/kvm/svm/svm.h             |   8 +-
 arch/x86/kvm/x86.c                 |  10 +-
 include/linux/kvm_host.h           |   3 +-
 virt/kvm/guest_memfd.c             |  17 +---
 9 files changed, 197 insertions(+), 93 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

