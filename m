Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A132F75B
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225289; cv=none; b=t+r6LSW0nciqNVPOvTh6EDGKh30ySr8h5tAJInErOq27Iihs6OPnnT8oH3TBQDtmQAXBV7TaxNnlFrS7eP50asCSDbKa+B7jCDE36d+7jXO+O0j2QXJGREKnEedFaacEI5dStJVVhxzmsUzlJVpbTHUjFxR4NegD5G4noYTnO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225289; c=relaxed/simple;
	bh=DpsQMnJ29rjtYhPoULcb/5II+mn0hNZQJmuCR8fl5zs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Beru1lCykbuXnF2gYHdXxd78poQaaFPu6KcfJPmEfYTqdrpalPj2a75pOJulAh3f6RKoYvcbWfCvNkG0oq8oMdAbKH5wUMqITMDUkYwnbZEOplhqUhwDgvex9tELrBLYtYZ64ld2BBQXrYXQpZmjqmsD0WhvpKEheocxr41NxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpYJWKXI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpYJWKXI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf08c2a24bso3857525ad.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225288; x=1781830088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5uMTRBUAHX2h9Xnpzcg/c5KtHyftJn9OFmu9FfNpZ0I=;
        b=ZpYJWKXI+K5L4oc4wznsdn4G9jqwgAwa+wJuUP7L/MHs62oIOd3CKMOx0davR9gyWF
         JA6SBYHZdLPMgKx3du3DfgeeqmiXrnsE3PNEF7vGj0/cgFi9w0LhZEMLp8Iiy2X9dhlA
         nox2gfOYzymDJcXnenxyKIuNgcqzgkuSNBQyQjpHfHZjvv5bHqM3loQ0+KXkmdbmIP9C
         OJ7apmvweI3Xaq3Qpt8T/aK5xKYU8YZd2K+CaNMLlKvmd6Gp9uCI1rqGdOwOqiNflkaL
         PJt/aFlXimmFAaHW5B/p03GbZwq0POKVJzvbybI2u93LtxOwy/AB9eF3J2RsGlq/PO/y
         8tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225288; x=1781830088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uMTRBUAHX2h9Xnpzcg/c5KtHyftJn9OFmu9FfNpZ0I=;
        b=BNi7Cga2/NwTFxOxyp8WJQAKzOJw1FfX9fMndRJXP7IQSJ1sI+Xzne9JTT/EMDD/8I
         ZAmt6SU0XQMh/9FT4cew0p/CC5HVQDiHJFEWeJm79gw8RMu7Y7R/oW882wRb1QSG2oEb
         x2i5dFn2dHWSuacpsrLdsdly/w+7rkLa4KazqPkQKvfu0ck6oiSm/oKzlhddBHufBdte
         hKLWkcmjnbAg7F4hN85fzuO2viYHALkaJCkISQfuP0P3dqTFdLWlw+2+o6LpRczVMrB2
         Kgq8nQ7zntnf2XuYr1RB2y/5m3W8gh4coS/hUU/6Q7asIUY9M0ET4hYxstLLQrMrAnWx
         LB0A==
X-Gm-Message-State: AOJu0YyaBNxAznJOShUpQyLFOzK7CsEbLqDwyQ1CjxnxWh97U8cGTBg2
	wOJxHSaTMvHU8kkqrvJYhtWmhLpglqX/w6unODxFmZD0+Ojxw88/NRVJD9STee3EHomvi53wYhI
	Rv2SMyQ==
X-Received: from pgch24.prod.google.com ([2002:a05:6a02:5098:b0:c86:4cc6:2efd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:139a:b0:3b3:bf0f:2737
 with SMTP id adf61e73a8af0-3b783f237acmr701916637.21.1781225287972; Thu, 11
 Jun 2026 17:48:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:51 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SEV changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Teach KVM not to advertise VM types that the system can't actually support,
rewrite the {de,en}crypt memory code, and fix two pre-existing bugs found by
Sashiko.

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-sev-7.2

for you to fetch changes up to 97cd21d57e9bd2da79845178d9250cfd19289cd4:

  KVM: SEV: Mark source page dirty when writing back CPUID data on failure (2026-05-26 09:56:36 -0700)

----------------------------------------------------------------
KVM SEV changes for 7.2

 - Don't advertise support for unusuable VM types, and account for VM types
   that are disabled by firmware, e.g. to mitigate security vulnerabilities.

 - Rewrite the SEV {en,de}crypt debug ioctls as they were riddle with bugs and
   unnecessarily complicated, and add comprehensive tests.

 - Clean up and deduplicate the SEV page pinning code.

 - Fix minor goofs related to writing back CPUID information after firmware
   rejects a CPUID page for an SNP vCPU.

----------------------------------------------------------------
Ackerley Tng (2):
      KVM: SEV: Unmap local kmaps in LIFO order, per highmem requirements
      KVM: SEV: Mark source page dirty when writing back CPUID data on failure

Ashutosh Desai (1):
      KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Sean Christopherson (9):
      KVM: SEV: Set supported SEV+ VM types during sev_hardware_setup()
      KVM: SEV: Consolidate logic for printing state of SEV{,-ES,-SNP} enabling
      KVM: SEV: Don't advertise support for unusable VM types
      KVM: selftests: Add a test to verify SEV {en,de}crypt debug ioctls
      KVM: SEV: Explicitly validate the dst buffer for debug operations
      KVM: SEV: Add helper function to pin/unpin a single page
      KVM: SEV: Rewrite logic to {de,en}crypt memory for debug
      KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers
      KVM: SEV: Pin source page for write when adding CPUID data for SNP guest

Tycho Andersen (4):
      crypto/ccp: hoist kernel part of SNP_PLATFORM_STATUS
      crypto/ccp: export firmware supported vm types
      KVM: SEV: Don't advertise VM types that are disabled by firmware
      KVM: selftests: Teach sev_*_test about revoking VM types

 arch/x86/kvm/svm/sev.c                             | 469 ++++++++++-----------
 arch/x86/kvm/vmx/tdx.c                             |   2 +-
 drivers/crypto/ccp/sev-dev.c                       | 101 ++++-
 include/linux/kvm_host.h                           |   3 +-
 include/linux/psp-sev.h                            |  37 ++
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 tools/testing/selftests/kvm/include/x86/sev.h      |  24 ++
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     | 118 ++++++
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |  14 +-
 .../testing/selftests/kvm/x86/sev_migrate_tests.c  |   2 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |   4 +-
 virt/kvm/guest_memfd.c                             |   6 +-
 12 files changed, 521 insertions(+), 260 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_dbg_test.c
