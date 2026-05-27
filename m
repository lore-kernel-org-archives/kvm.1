Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADF37B03A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886215; cv=none; b=kro87iBTPSNcHqGrKwrZrC0A8txuSyByuCfgyoFP/DihrbvYofHI3b2Tjbne2NtjVjoBfdsMRHrXpDMtoMVU9cwkd6zRfzNyDJt09Qjfq5cqCgeIn9KCwCPJQm1d1DkDtBeUk2YxJZY/b2IhXqXieIT949xLI6o+0sFYx92OYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886215; c=relaxed/simple;
	bh=tt4sYcd3U16so3mMAh4T+xTLSOlm3M/ufYOMU2VqK/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQRdiVbbLXE3hH21oulhYFXKrN5w9p5wRJc3ZelxhPlgXAowolIKGsAZxzU+UDrmdKrxA78IBdK+Trig976MOjnQpiYzo+7SLf2wNEhP6hRlveKdAWcpZfF6nfQXKUCo7rP1NtJTZex2TYN3nBCQgsVTplgYa2/boaB91XjAlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdTDyeNs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdTDyeNs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bd2c147abaso70626565ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886213; x=1780491013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgRAhqYKkBvWITllYhRchMYpKWP7IS+SkRga7Dolm/U=;
        b=ZdTDyeNsL5ye1hkCvzbfZ/Le6vVDqENevdCkugR8ODI+8Pn+DlI+vxu9mtpkUKvj0Q
         +H9gFf1i4FbId+JK6pHKKwBKoGKTW42FT0BfILJvemEsCCltJT3Z/nVL9F1htQUzIwVS
         zJVIklRG5PIta5yKM8Eri3XCY9RgCV6ZS1piv22oQ3QerdQmSOfQaYwyuNY9uh101L0/
         3CF0TtJ3/znyQ2MT2IOQC8YvgtKq/Tr0yex6smzzDX5clSUUhuhP+PPH+z+BdLijn0+5
         WFbrqJmuunBs1nI3brH07eDAIP6oVXoSKJBr43Eonil0Tl8tw4wuAP/naaplCvjwtHvX
         bNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886213; x=1780491013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgRAhqYKkBvWITllYhRchMYpKWP7IS+SkRga7Dolm/U=;
        b=RERgJOHTLY4NlC4Rm4R0VaM1gUg8oDDcMtVHhB6IM55kwi5RtR6LRVJCqcTTcI7ZCI
         wsGlnz11wgwm7HGb5u8QHWypTzB9sUxJtOPWCv5MFzsN0P2rsA1/1sgbsNhanOZ+xXUY
         m4ueAOA72ipqBCbEx2Sb6MXi0VJejnIu7eEUzLHomxYKDlvYvwkrdWDDQlE1A80taJ6N
         Qc4ots42l9Sn8P0olljjFktVC5fK647/ZjGrJwWS67XH9rHR++BmSL7Ng/T2QZJ1Vn50
         FdEZ6hZfrEGa0xf3ev2m/tgYWbNk8SWwnhpXQxF/gb1vj9k4SN+M0zlpAxOHYLkHUs1N
         L/Dg==
X-Gm-Message-State: AOJu0Yyw6M/A7F9j+kzORfZD9pd/iZSHDlyBWgjEQN5qrzbXcAKk462o
	WeU29ja7uLmzOHwRv9htvcWutZ8fuSfcYAArGUMLhSeZxuUjHM3W41pNYu71bg==
X-Gm-Gg: Acq92OFVJbiq6FvQ925YLFsvLMaZCUrkTwQ0q0kNANtMI8sUTp+mJjxK5qYtlX8/CXT
	6GLzROkJFQ/sBMHlHuZGtLcimttp7DYN6ebsA05oDfiM+iCPAPAbTw2ihGyQTEKCvAkJrkYae6T
	2fgt0lNtQ5EBG1xEcsmtzvmu2YVqef4RMH5hItMw6hQafYQsA5r4nqU11RHkR7IImu9USpgvdI1
	8JkBcO66Gvtg9A3wa7OzQR3VBMVf7HBERfWnaNfQTwK/5giYLtfi/+LM6v5GDpF8mXjUSHVYxq6
	RJ6FZQ/FPlKPhTVtbKRHUumt/DH4M5MbCEr4fwdA92XOqyQq8ZKnhQfHyh8Cw8PUHgoc4aQn89t
	bgStpLCwpvD8pumpTjxzY389DtBe+fUoUfKQolbm7dI7n9oqgcF06pQyiPRjGsJXlQwfM5rf2D5
	ogTe8RybxYTFH1SEX9WyeDqJ7wwqinzPi4VOZmjUdagDlCwbhv0w==
X-Received: by 2002:a17:903:2a8f:b0:2b9:e82f:bfef with SMTP id d9443c01a7336-2beb05b5133mr252771035ad.21.1779886212801;
        Wed, 27 May 2026 05:50:12 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 00/10] KVM: selftests: add powerpc support
Date: Wed, 27 May 2026 18:19:49 +0530
Message-ID: <cover.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and gva_t

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
2.39.5

