Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18861F30AD;
	Sun, 25 Jan 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769353519; cv=none; b=fWJzE/6B4Xf3Y0rAwheZRYTcR+9IMhZpydnUuy5TZG99RqIXAmYVkmpmV/RU3Nf0OJvoO7U2CQmqhGarXntWomCv7hU54KQ7ZmgZo8BmjrWaCf5jMhvgRRnrNQvcKrP7K9YzXatlSXZNLdD711XFzXUour4TQrq7XQRju/Ceewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769353519; c=relaxed/simple;
	bh=2fBFkeQBU9zukgW+AXe+T9hXDqSUi67vwkqFMZjz4gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FgkCt+xQFOxs2JBZ3ZND+mBfbqv4cxSS06QXVp62s6S5MXQg2KLvIDPowGG02kpPLbT+ChsRxnfpK2GyjOMCmY+vshwRFfz+LVVUN0/brOzvU6OmLdiRJDS9LzrBhnAiAxEArNBZjCCt+3gVNolYABPuvLNEz8lKNOXnAjp6bm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rulDVYHX; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rulDVYHX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769353507; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PMCCCq1cM6dVorAxjoEzFrWStzc4ERTOWpMKDxiriBk=;
	b=rulDVYHXF5CKwFHVkfUa/Y0ohApgpEqekKkCV458MEpOq4mwHLLdWjd4UW2xf4S9i+g8zL6VI6UIyqiK4jUpBHiBK8KP1lrq21MFpmnP0C9kKNh0DgKvGsdGtg8mxnsS0WweFq2PZsIyx1RPiUxbZZHHjQnz1r62dU1g/8fMdJw=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WxlpgTJ_1769353503 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 25 Jan 2026 23:05:06 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com
Cc: guoren@kernel.org,
	ajones@ventanamicro.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v3 0/2] Support runtime configuration for per-VM's HGATP mode
Date: Sun, 25 Jan 2026 23:04:48 +0800
Message-Id: <20260125150450.27068-1-fangyu.yu@linux.alibaba.com>
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
---

Fangyu Yu (2):
  RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode
  RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE

 Documentation/virt/kvm/api.rst      | 18 +++++++
 arch/riscv/include/asm/kvm_gstage.h | 11 ++---
 arch/riscv/include/asm/kvm_host.h   | 19 +++++++
 arch/riscv/kvm/gstage.c             | 77 ++++++++++++++++-------------
 arch/riscv/kvm/main.c               | 12 ++---
 arch/riscv/kvm/mmu.c                | 23 ++++++---
 arch/riscv/kvm/vm.c                 | 28 +++++++++--
 arch/riscv/kvm/vmid.c               |  3 +-
 include/uapi/linux/kvm.h            |  1 +
 9 files changed, 133 insertions(+), 59 deletions(-)

-- 
2.50.1

