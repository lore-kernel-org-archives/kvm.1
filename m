Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD082F5485;
	Thu,  2 Apr 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136210; cv=none; b=Ro9ZEwGmUXLXJ2mK03V/BMhIEfk3381c/4F7q4qAHagmU8ym6OHU7rhn4ikLc9oHKLbYNgOV7IXqOheQo9y0Czr2CFnGm2iZ4Dw+j3mNW44K47Ru2zh6XhQk9yfNjq3HSnUkq5rxBJ+e/nauxITG3a2UPcUfzR+IxJghNtFtv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136210; c=relaxed/simple;
	bh=sp9+vg7wwwJ605P8pPTe5UaAYU/ySz90REDSGMwh8gs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SLxrZwdda/Ok8ACdjs3qdPfuFRxIZay7VfsqHVmb4DDooyID4pp/fSxREV6bIhnyxai8RdGa6kWkUAaix1MLBgfwuytQH5rqpe+YqrPrejEXvohunw2UQ4MLU1fKFvwxfcnGhSkRFhGY/njtEfYuDgmLFl4bDQ46rwCndlaKNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W4vBdvZa; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W4vBdvZa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775136203; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=L0+vAMwC3IiugLJKhUSRlglaj83UWioIkkheO8aLeaM=;
	b=W4vBdvZalY35fWDI88AzGdBjPNqmKmQQRCYHS+sHYoLo3tJ7ZvIlMSqz5uYsj07VecfaG94suRb9DQ1GWWGC+JswDxnDBCuAKM6ZZ3DWiseSmPLjOA8vSNR7NbGbS6olRYdB2I5DYovEJ5jvzMtXOYCoFfnK+0lL5KNbTliTAgQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0HNDCg_1775136200;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0HNDCg_1775136200 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 21:23:22 +0800
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
Subject: [PATCH v7 0/4] Support runtime configuration for per-VM's HGATP mode
Date: Thu,  2 Apr 2026 21:22:59 +0800
Message-Id: <20260402132303.6252-1-fangyu.yu@linux.alibaba.com>
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
request a specific HGATP mode (SV39x4, SV48x4, SV57x4 or SV32x4) during
VM creation.

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

Fangyu Yu (4):
  RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
  RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
  RISC-V: KVM: Detect and expose supported HGATP G-stage modes
  RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE

 Documentation/virt/kvm/api.rst      | 27 ++++++++++
 arch/riscv/include/asm/kvm_gstage.h | 58 ++++++++++++++++++---
 arch/riscv/include/asm/kvm_host.h   |  1 +
 arch/riscv/kvm/gstage.c             | 78 ++++++++++++++++-------------
 arch/riscv/kvm/main.c               | 12 ++---
 arch/riscv/kvm/mmu.c                | 70 ++++++++------------------
 arch/riscv/kvm/vm.c                 | 20 ++++++--
 arch/riscv/kvm/vmid.c               |  3 +-
 include/uapi/linux/kvm.h            |  1 +
 9 files changed, 169 insertions(+), 101 deletions(-)

-- 
2.50.1

