Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09236997C;
	Mon,  2 Feb 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041256; cv=none; b=E7sjgyOEDtzPnA3Q8HOJhC1WudmB4zf3nAPpA+JkJuViK6LGF3ZTqiILeBxudEU1n2EDuJDa/iTYFNwwzTvoERF9+za4NiiruImrNMLfjkLV07JrCk5PsS8FjRctmGgTCHpDjKSljQ1OaCP6M0uEaYcRzjtIx8UMcJ/zHQKmFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041256; c=relaxed/simple;
	bh=fDw/Q6MfdsFkb17soopXpbynKsHQ7sbc5JpCA1qVJas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TW6sOIY+JoAjJ0SYEQbcBxDbJhzMj7PKZLAuBF7AKolaFJURXlgcYaxkBGkT+n6FOpu+vlmQGFi3OjcUCh3pEOz+7lVVedKHrkNnHh3CisJ9SH1rXggpCP9Ln4cKO2SVMWvJj5G97NOSj9ES5zDGRu8g9Vrxda/0UYqsy3BRfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cg6Ojxy/; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cg6Ojxy/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770041249; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VDIX3268l+YnDqz51gXsg22RmUvUWaRiFAyIjnTGOWE=;
	b=cg6Ojxy/4B28n1hzMD0+Z3wGhYByOufXenGFWfkfRY1NXFanznYLeDLhPQvE+gq++CWk4osFbV/ahtzExCFEoJyCyw229O/gQuYbDyX4swju1XakbkSewW89MRGed7TMpFp7+NGaVe8Y71wNRVxukSWG3FU3J4kMn6K/ij7zRqg=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WyO62Sp_1770041246 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 22:07:27 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: guoren@kernel.org,
	ajones@ventanamicro.com,
	rkrcmar@ventanamicro.com,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v4 0/4] Support runtime configuration for per-VM's HGATP mode
Date: Mon,  2 Feb 2026 22:07:12 +0800
Message-Id: <20260202140716.34323-1-fangyu.yu@linux.alibaba.com>
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

This patch introduces per-VM configurability of the G-stage mode via a new
KVM capability: KVM_CAP_RISCV_SET_HGATP_MODE. User-space can now explicitly
request a specific HGATP mode (SV39x4, SV48x4, or SV57x4 on 64-bit) during
VM creation.

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

Fangyu Yu (4):
  RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
  RISC-V: KVM: Detect and expose supported HGATP G-stage modes
  RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE
  RISC-V: KVM: Define HGATP mode bits for KVM_CAP_RISCV_SET_HGATP_MODE

 Documentation/virt/kvm/api.rst      | 27 ++++++++
 arch/riscv/include/asm/kvm_gstage.h | 57 ++++++++++++++---
 arch/riscv/include/asm/kvm_host.h   | 19 ++++++
 arch/riscv/include/uapi/asm/kvm.h   |  3 +
 arch/riscv/kvm/gstage.c             | 98 ++++++++++++++---------------
 arch/riscv/kvm/main.c               | 12 ++--
 arch/riscv/kvm/mmu.c                | 20 +++---
 arch/riscv/kvm/vm.c                 | 22 ++++++-
 arch/riscv/kvm/vmid.c               |  3 +-
 include/uapi/linux/kvm.h            |  1 +
 10 files changed, 188 insertions(+), 74 deletions(-)

-- 
2.50.1

