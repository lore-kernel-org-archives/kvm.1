Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFA3E559A
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379205; cv=none; b=TW8/2kC9fu2oOF2IqE9WVk0nH7wCvzkBozLAmuDBaarHnTmF81cB0sq5uGLaxeB1RTKWmfaVoJRhWo655b2H3gWIjFyj+s1bIOqsLdu+BI3GSYXaTZ/Iy7UPRT4IDVRDJd0WB4F378PDa+FollYxNgIh1djfDJ883dFmY/JvkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379205; c=relaxed/simple;
	bh=mcYrt5VznRv8xtuGmmz9RZEWNXtS2yxga0xjjsgK9vQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uxywCTSUB5KvECsEMQq9fVge1MtTriYuDoWwcKXRrnBoruRFLP/G/sxr0hNYoODSDg/p7MbGqNlFdd11o/x5OlVA/ke8qIZA3C11aAHpwwzMxSo9Psf53IUmwknHRsFSiYHpN7ODBbEWMvmChMIHz0OwLM0PE7Olw+rz8V78dMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMM/BXio; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMM/BXio"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so765460a12.3
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790379203; x=1790984003; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4sLdZTMrez8W3xJ+o5SfezWJjq5FwH6Cki+1HKf74k=;
        b=rMM/BXioOnsMK33TlBbDO+tKNTx8/P2ckEk1Tv84HSBlzJ7Usyn57bQDllc7WeK4dj
         A8h5zLTwfxXxuqK3+T10hhJbHJn60YIg8zQ6yQ+fBypxR3byBVhhdtrbNJx4LV/kLB1n
         Q0yrlU9Lz4Ac+pDc6IbQZ/Sz407cY26XgR1Klh2JpzIoolfkJuI0MmhgjdqchpfuE8Hl
         ayl2p99a2P5sjOsz8Y4fTE1dfbJ0plWPBwWBUPBj5GnYWTjKavDThu4ascgUpAo/XL+3
         9GdKIrpL3twJeORpn/EFmFSimg/YlF4aj6+XGXNbaUxr8xbQIE7OJYVzl2KteasKr9Ea
         ZRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379203; x=1790984003;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T4sLdZTMrez8W3xJ+o5SfezWJjq5FwH6Cki+1HKf74k=;
        b=ZLPEAtnYb1YCfMCuafOKUEyhhOLeSTWjoBh0YSpSNXZinjlMY+AaY5+NxDJlCUs8S7
         a7uVqbW+q8Ul28xV3KEadRoeOM6KI17cPr60k7D3flTGfDhs6M3ExXeTgxsPIfrxeBpL
         KYOSjAZYRN5F+BSkaW1oc/Oz3ekAKvYjS9zoKyatXZ12NDaOu0Ivm8JxA3sj2tVwJSau
         YYcyY5Mz84Jpaub9gjf5QpSknPyXmTno8CsLq6KMycw8UebpD25w14aEVwZqe2X5/BEW
         7kdRk5dTJV4eQIlCqIr00Cz2LeWT3nsVvlrVttPIyiZyYd4UaqiBeBmlNrdYIc2u6p3t
         Qt8Q==
X-Gm-Message-State: AFuF++nObjMthznbAtZJYFHY4v4GkRJ+FQiPrwsX8p+iygujgehcW19C
	pybE8YHima62oz3iXPSAfMcDAIWD3qVK0u+PdUNUEgsGUZ58BBeHLlhbJZLSO2xHJAHTwOYf7LB
	iVAwM3g==
X-Received: from ploc16.prod.google.com ([2002:a17:902:8490:b0:2df:a4d3:2d98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8d0:b0:2dd:c100:7cb8
 with SMTP id d9443c01a7336-2df7dc55ffemr64340045ad.52.1790379202896; Fri, 25
 Sep 2026 16:33:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Sep 2026 16:33:21 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925233321.2381319-1-seanjc@google.com>
Subject: [GIT PULL] KVM: Fixes for 7.3-rcN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a variety of fixes.  Nothing is super urgent, but all of these can
be fatal to the host and/or guest (except for the selftest change, which fixes
a regression that was introduced in 7.3).

The following changes since commit d599822bdb66aeec5ec76297b0fc6efaaeefe07c:

  Merge tag 'kvm-s390-master-7.3-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2026-09-04 17:34:28 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.3-rc5

for you to fetch changes up to 119e9db233ad0f4cbd4cfb9f9385a7bca378b37d:

  KVM: Don't pre-reserve xarray entries when storing empty/NULL attributes (2026-09-22 08:36:16 -0700)

----------------------------------------------------------------
KVM fixes for 7.3-rcN

 - Fix a brown paper bag bug where KVM would incorrectly treat Intel PMU MSRs
   as valid on AMD.

 - Fix a regression in the hardware disable selftest where it checked the wrong
   macro when detecting glibc support (breaks at least musl).

 - Never clear KVM_REQ_VM_DEAD so that dead VMs stay dead, which is especially
   important for KVM_BUG_ON() flows, which often guard more dangerous bugs.

 - Re-pend GET_NESTED_STATE_PAGES if getting the pages fails, to fix a bug
   where KVM would let userspace run a broken setup with stale vmcs12 pages.

 - Fix a class of bugs where KVM would fail to fill kvm_run exit fields if
   getting nested pages failed.

 - Treat reserved entries in the memory attributes xarray as "no attributes",
   to fix false positives when checking for mixed attributes.

 - Fix memcg accounting for the memory attributes xarray (the xarray library
   subtly requires the xarray to be configured for accounting upfront; the gfp
   flags taken at runtime are used only rarely).

 - Don't pre-reserve xarray entries when storing empty attributes, as storing
   NULL must not require memory allocation (KVM and other subsystems heavily
   rely on this behavior).

----------------------------------------------------------------
David Ballesteros (1):
      KVM: Ensure memory attributes xarray nodes are accounted to the caller's memcg

Jim Mattson (1):
      KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()

Sean Christopherson (4):
      KVM: selftests: Use __GLIBC__, not _GNU_SOURCE, to detect actual glibc
      KVM: Never clear KVM_REQ_VM_DEAD from a vCPU's requests
      KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
      KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths

Zeng Chi (2):
      KVM: Don't treat reserved xarray entries as having memory attributes
      KVM: Don't pre-reserve xarray entries when storing empty/NULL attributes

 arch/arm64/kvm/arm.c                               |  2 +-
 arch/x86/kvm/mmu/mmu.c                             |  2 +-
 arch/x86/kvm/pmu.c                                 |  8 -----
 arch/x86/kvm/svm/nested.c                          |  7 +----
 arch/x86/kvm/vmx/nested.c                          | 15 ++++------
 arch/x86/kvm/vmx/pmu_intel.c                       |  3 ++
 arch/x86/kvm/vmx/tdx.c                             |  2 +-
 arch/x86/kvm/x86.c                                 |  6 +++-
 include/linux/kvm_host.h                           |  9 ++++--
 .../testing/selftests/kvm/hardware_disable_test.c  |  6 ++--
 virt/kvm/kvm_main.c                                | 35 ++++++++++++++++++----
 11 files changed, 56 insertions(+), 39 deletions(-)
