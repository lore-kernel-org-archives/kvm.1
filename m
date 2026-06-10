Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B14374A0A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095659; cv=none; b=NJknxudKsli6V7UYLnSmmMXtQ8UaS3FUk2lxnpoxj+zqnpqH0eQfL6OzYFFNKIL33OgTRXvidxymQDWVqSH2n72Zbxl4MGRMCyfqVnsmSrlnksXd89K6KiM1PADpUgEDfv5ZGr00C78mv+kTkfMA4ZCfXWDSNFGDJVvkGG61OBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095659; c=relaxed/simple;
	bh=vWq6EpsUz0r+AfsrwCl3YJ8mko7vHsYFpnJkUHCv8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uT6EtzWF9CawgGAn121MmxIH2jf8/y9eV9pJOTh+XeML4ul9aODRvF9y+2qk1jJtjIzVwmCp08qUESqQFKyT7vx2rCJqyckDO9A03gPjQqMDgF9Gvl+80N5zr+hQpr2lZz+Vrs68ymHQWPr5xtcQAxualeYJGr/v7HRmACSCCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6L0yVYH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6L0yVYH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so4670049a91.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095658; x=1781700458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcdeH8OHqrmoZ9G8aHs4z2njcN7/wilme/JI0goiWUg=;
        b=Q6L0yVYHcaZwSUYMwxsVBbCDmQSLNv6kXYECkZWKZdaSqS9vhz9/aZRXYgyozKve6n
         dO1RFebq+Xa2dJV5WSBnp6b19Mpga6XoB3ZheL3CAkSnepwschN+z3RlpKbIvQLzXurL
         v/uJO2QZs8OZJYkmYyfLLndQpOHZC8lTyCmuRXfRqkXDDNEPvfna8e+u+9xVDqQ/bqFO
         GOVZLelz2GJhCkZMUoGQWnyUd2uF2cl9Mo4DTMG62LeS8WF+FfbeDO2ep+H0DfqQDLln
         NBSOdPOzKEGcKt2EStCBAvyMNl2nQDVO4/MkC42lgoL/i64rkgdX5O7mqrkgGfuCLep8
         sBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095658; x=1781700458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcdeH8OHqrmoZ9G8aHs4z2njcN7/wilme/JI0goiWUg=;
        b=J3UQAf3WXaThz2ixx69HyASnb5iVNfUKL6VbCCURAjhM2lijDl/zrESMABBunaDyF1
         x+zmskkFbXNDzMahffBXiusCsW0+OInRalx8RE/VqUNWkF0TudXIpDnUEzfuWJgK1Tcz
         zjpMbP6FUOdS3x/VinrVSqBP0iCvQYr/lWN6NgBKGL+lA60KmSSpP0yrbFQyuMp8WEkR
         E9eC0BI30c0MXoYOOvsPj4a75WybPnUVSOYpNzk770l3QwKVHXJqh2O7reRyPOhinGeL
         ZcAiLkW1V7Hce7FQLoiKACxQBQXENMIDBwyKKImjBnuCFJOp8QxTtxi8ATLIIKvArMPR
         2Rww==
X-Gm-Message-State: AOJu0YxPmXmTa9bc47vwCsM7c1eCx6MDKDhhcqcPGIbl86J6mZVEZWF2
	YMHBw9CjzcIl44pF1A+gA4yEYL8NRtVoY/WYk/WyQKykYSMNJ1kyUa5hW2JTKA==
X-Gm-Gg: Acq92OFi8Lc2ggS3Pc4D/6LzT9ykFNTleIHwOt8fWOo0RCQgaQVs70Dqxpqpd5dNj3R
	QuvBEZ7YESdhnbWugHv8iyfHYS65+tFPI4R5OgdZX5m+UNEKw5VWvQjBoMNaAihfgLw0zVsVXPK
	bArwFQwQmsVXG/XmPsnn5GJgKJ9FNfMkWPxce5PC9aexeAtmxJpAN1opN/PQDbnP7pJUNVEu1Yf
	BWFF4B/WQ2vvB5iXLatu55wQbkukSk8R/iOiAjtDRsnFhXIzhUSMZ+LB+koTacHXiq806Y5r82Y
	E8aPMJXQ+ijqI66xR8OvkxYTngTB+Xw3YUjJ8sUl2bWL4JRjzzjr2KS4F6H+gLHrxQ+B8SiTRRB
	JLHRkzsE6hM2x9ZV9c89nMH7aD6Fw1Ut7ppUmc9JqAgF2yRQO5sJd6LSNj/EDG0mAH7BrvNg0iW
	mo6+++bac/GPbyXwj6CvUQoovnEU2VRMi9gwm7/p1XIIobOzix2/jKzHuHWvpgxQ==
X-Received: by 2002:a17:90b:6c3:b0:36d:6308:12fa with SMTP id 98e67ed59e1d1-370f0386f18mr26940920a91.18.1781095657850;
        Wed, 10 Jun 2026 05:47:37 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:47:36 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
Date: Wed, 10 Jun 2026 18:17:16 +0530
Message-ID: <cover.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFCv3 -> PATCH v3:
==================
- resend and dropped RFC tag.


Hi All,

This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
radix MMU).

This patch series is originally Nick's work. I have mainly only rebased it on
the latest upstream tree. Since the rebase required few changes to all the four
patches (Patch 1-4), I have dropped the earlier Acked-by from Michael Ellerman.

Since the last series was posted three years ago [1], I am resetting the version
to RFC. This rebase was done as part of a larger effort to improve the selftests
infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy for their
help on this.


Testing Updates:
================
1. Tested this on PowerNV P9 with Radix mode. (all selftests passes)
2. Tested this on LPAR (KVM on PowerVM) case. (all selftests except-1 passes).
   The failed testcase (kvm_create_max_vcpus) is because H_GUEST_CREATE_VCPU
   (PAPR HCALL) only supports vcpu_ids 0-2047 i.e. max 2048 vcpus.
   However, kernel always returns NR_CPUS for the KVM_CAP_MAX_VCPUS extension.
   So if the LPAR kernel is built using NR_CPUS=8192, then kvm_create_max_vcpus
   can fail in __vm_vcpu_add(). This failure needs to be handled separately,
   mostly as fix in kernel.
3. Tested these selftests changes inside x86 kvm guest  - no new failures seen.


RFCv2 -> RFC v3:
===============
1. Relaxed strict pte permission checking in patch-3 (Sashiko)
2. Fixed errno from getting clobbered in patch-5 (Sashiko)
3. Added PATCH 6-9 to handle the type conversion (e.g. uint64_t to u64) as was
   done earlier with other kvm selftests. Kept these patches separate to keep
   the review & changelog simpler.
4. Added PATCH 10, which replaces u64 gpa/gva to use gpa_t and gva_t and
   converts the vaddr variable to gva as done by some previous commits for other
   kvm selftests. Kept this patch separate to keep the review & changelog
   simpler.


RFC v1 -> RFC v2
================
(mostly Sashiko review comments)
1. Fixed x86's stage-2 mmu handling in patch-1 - commit msg has more description
2. Added "cc" into the clobber list for hcalls in patch-3
3. Fixed the size calculation in kvm_arch_vm_post_create in patch-3 for
   allocating 2 pages for 4K pagesize
4. Added patch-5 which prints vcpu_id in case of an error

[RFCv2]: https://lore.kernel.org/all/cover.1779524962.git.ritesh.list@gmail.com/
[RFCv1]: https://lore.kernel.org/linuxppc-dev/cover.1778857539.git.ritesh.list@gmail.com/
[1]: https://lore.kernel.org/all/20231120122920.293076-1-npiggin@gmail.com/


Nicholas Piggin (4):
  KVM: selftests: Move pgd_created check into virt_pgd_alloc
  KVM: selftests: Add aligned guest physical page allocator
  KVM: PPC: selftests: add support for powerpc
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test

Ritesh Harjani (IBM) (6):
  KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
  KVM: PPC: selftests: Use u64 instead of uint64_t
  KVM: PPC: selftests: Use s64 instead of int64_t
  KVM: PPC: selftests: Use u32 instead of uint32_t
  KVM: PPC: selftests: Use u8 instead of uint8_t
  KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and
    gva_t

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 .../testing/selftests/kvm/include/kvm_util.h  |  34 +-
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  39 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |   9 +
 .../selftests/kvm/lib/arm64/processor.c       |   4 -
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  48 +-
 .../selftests/kvm/lib/loongarch/processor.c   |   4 -
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 483 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../selftests/kvm/lib/riscv/processor.c       |   4 -
 .../selftests/kvm/lib/s390/processor.c        |   4 -
 20 files changed, 876 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c

--
2.50.1 (Apple Git-155)

