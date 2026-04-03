Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346226B2DA;
	Fri,  3 Apr 2026 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230235; cv=none; b=lzhxHBLuvNcCX55Q9hJfPM7AKjNdPlqMn3j5w9obdsUHrMSLWMuae9SC4j4w46Od+mQWViWMCA2dvXLkQYIkGSwfcS2NBQjGvJP0LjJhMRZwdqPxe4sfPh0qFBdO1CSwDRTXqipSHGKt1yOvzYvkE0rdJfeTvemqwrzImPkv8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230235; c=relaxed/simple;
	bh=nYvUfd++y5DOIe4IR6nAO8wSfwXNqSBoWrNch8hgDS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S90hgRJFd0Ofe3Mf+XDAYsfyezQKiyUKXHuLDhGPD/wZJVeV/JJaPo4SsbzTibWGh0llvSnKW4PLcAXcZc3S8LLRPhiYSQx2m6R2djtC3s24JW8uWSi+24oNif6EkcFi9GBPq5z5X4VxOYN03IJsroVZ2KJdFpOsDQmmk4NGelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nihzHD1C; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nihzHD1C"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775230225; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pe6t8LzmwGI0uq4dXwZrBkDc+BEZT75JPPz4oWsgqjA=;
	b=nihzHD1CsSca7Omqefj1cnxpueRSkwV4vWgPcy9HcC7NepRtxO81DmMzkRW3lAgHe2jD9jGk2r9OPHGfm5LWCqqjMKVqWhq0GGwJx3VJ6aW6pWu007IhFgyzTtky3lhBLPDEXSlzV4hlsdStzO+OevE2nLPNrw2aheVvXSvY70w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0KbxT5_1775230221;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0KbxT5_1775230221 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 23:30:23 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	skhan@linuxfoundation.org
Cc: guoren@kernel.org,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v8 0/3] Support runtime configuration for per-VM's HGATP mode
Date: Fri,  3 Apr 2026 23:30:15 +0800
Message-Id: <20260403153019.9916-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Currently, RISC-V KVM hardcodes the G-stage page table format (HGATP mode)
to the maximum mode detected at boot time (e.g., SV57x4 if supported). but
often such a wide GPA is unnecessary, just as a host sometimes doesn't need
sv57.

This patch reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE. User-space can
now explicitly request a specific HGATP mode (SV39x4, SV48x4, SV57x4 or
SV32x4) during VM creation.

---
Changes in v8:
    - Reuse KVM_CAP_VM_GPA_BITS to advertise and select the effective GPA width
      for a VM (Anup's suggestion).
    - Handle the kvm == NULL case and task kvm->lock and kvm->slots_lock to serialize
      against concurrent vCPU creation and memslot updates (Radim's suggestion).
    - Link to v7:
      https://lore.kernel.org/linux-riscv/20260402132303.6252-1-fangyu.yu@linux.alibaba.com/
---
Changes in v7 (Anup's suggestions):
    - Keep the original HGATP mode probing logic.
    - Link to v6:
      https://lore.kernel.org/linux-riscv/20260330122601.22140-1-fangyu.yu@linux.alibaba.com/
---
Changes in v6 (Anup's suggestions):
    - Reworked kvm_riscv_gstage_gpa_bits() and kvm_riscv_gstage_gpa_size() to
      take "unsigned long pgd_levels" instead of "struct kvm_arch *".
    - Moved kvm_riscv_gstage_mode() helper from kvm_host.h to kvm_gstage.h.
    - Renamed kvm->arch.kvm_riscv_gstage_pgd_levels to kvm->arch.pgd_levels.
    - Added pgd_levels to struct kvm_gstage to avoid repeated
      gstage->kvm->arch pointer chasing.
    - Link to v5:
      https://lore.kernel.org/linux-riscv/20260204134507.33912-1-fangyu.yu@linux.alibaba.com/
---
Changes in v5:
    - Use architectural HGATP.MODE encodings as the bit index for the supported-mode
      bitmap and for the VM-mode selection UAPI; no new UAPI mode/bit defines are
      introduced(per Radim).
    - Allow KVM_CAP_RISCV_SET_HGATP_MODE on RV32 as well(per Drew).
    - Link to v4:
      https://lore.kernel.org/linux-riscv/20260202140716.34323-1-fangyu.yu@linux.alibaba.com/
---
Changes in v4:
    - Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE values
      supported by the host and record them in a bitmask.
    - Treat unexpected pgd_levels in kvm_riscv_gstage_mode() as an internal error
      (e.g. WARN_ON_ONCE())(per Radim).
    - Move kvm_riscv_gstage_gpa_bits() and kvm_riscv_gstage_gpa_size() to header
      as static inline helpers(per Radim).
    - Drop gstage_mode_user_initialized and Remove the kvm_debug() message from
      KVM_CAP_RISCV_SET_HGATP_MODE(per Radim).
    - Link to v3:
      https://lore.kernel.org/linux-riscv/20260125150450.27068-1-fangyu.yu@linux.alibaba.com/
---
Changes in v3:
    - Reworked the patch formatting (per Drew).
    - Dropped kvm->arch.kvm_riscv_gstage_mode and derive HGATP.MODE from
      kvm_riscv_gstage_pgd_levels via a helper, avoiding redundant per-VM state(per Drew).
    - Removed kvm_riscv_gstage_max_mode and keep only kvm_riscv_gstage_max_pgd_levels
      for host capability detection(per Drew).
    - Other initialization and return value issues(per Drew).
    - Enforce that KVM_CAP_RISCV_SET_HGATP_MODE can only be enabled before any vCPUs
      are created by rejecting the ioctl once kvm->created_vcpus is non-zero(per Radim).
    - Add a memslot safety check and reject the capability unless
      kvm_are_all_memslots_empty(kvm) is true, ensuring the G-stage format is not
      changed after any memslots have been installed(per Radim).
    - Link to v2:
      https://lore.kernel.org/linux-riscv/20260105143232.76715-1-fangyu.yu@linux.alibaba.com/

Fangyu Yu (3):
  RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
  RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
  RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE

 arch/riscv/include/asm/kvm_gstage.h | 47 ++++++++++++++++---
 arch/riscv/include/asm/kvm_host.h   |  1 +
 arch/riscv/kvm/gstage.c             | 65 +++++++++++++--------------
 arch/riscv/kvm/main.c               | 12 ++---
 arch/riscv/kvm/mmu.c                | 70 +++++++++--------------------
 arch/riscv/kvm/vm.c                 | 49 ++++++++++++++++++--
 arch/riscv/kvm/vmid.c               |  3 +-
 7 files changed, 148 insertions(+), 99 deletions(-)

-- 
2.50.1

