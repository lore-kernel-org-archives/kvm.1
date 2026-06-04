Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF447B413;
	Thu,  4 Jun 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579478; cv=none; b=ny9yAn3tFCXNkL2XJgSz+tg/VBlWQ535LztCZpmDMQzU7/DMfApkWID6qngUkHOh1+1fUzmTHqGOgtxuU9Qy7oR5NoDrJvHHlkWRTHjcWnC3cnN5ExSfSDXB9kS/GZMkrUxD3NwdhaF7pFUtRDzrZsqtwlFbBhETEY8Jk68idHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579478; c=relaxed/simple;
	bh=Q3AeNW+w7NzWKj9M3jWoHysRapmY5TxDY1ssUqTZShw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p43vc0TYlMR+1aNAmmN1OBA+LIiNQNSJj8WRPzkFMYqZUgPJd3bjROK9hhDkMBzPIgip9aVpY50+DgkAStOVkYqTe1Nyz6kyyRB9BcRNWckM7tGctPHnvgJSXfvpErS2p0tuFE9Lkb8S7ZIaSy+MUj0FfNwgH8FHUndBT1M61t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WdZFzXr6; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WdZFzXr6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579464; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z8aT4Za5Qhsy8uIIRwj+ts//dCl77c8YOPDnJ67EKYk=;
	b=WdZFzXr6/L8DXZvTlQvEKb0CbYZLg0EDLDYMXgpbfppB7Ju5e95ec1c+eViUyTUfSoUzuhU2GQqRNdWhxzteSggwblqSu/VkK2cyR8j9rRIz7wJ8P26bo/2Hrs+Wu6yASAOOm5KgspN9rUDsxFF8gk4beZ0bpuzIMoffgeMKR58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnWJ_1780579461;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnWJ_1780579461 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:23 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Nick Kossifidis <mick@ics.forth.gr>
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Lyu <richard.lyu@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v3 0/9] riscv: kexec: Make kexec/kdump robust under VS-mode
Date: Thu,  4 Jun 2026 21:24:09 +0800
Message-Id: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

In a RISC-V kernel, both kexec and crashdump need to hand off execution
to the next kernel after tearing down the current kernel address space.
However, under virtualization the guest uses two-stage address
translation, and pc does not jump to stvec after setting satp to zero,
so the legacy single-step "csrw satp,0 + stvec redirect" sequence
traps with "kvm run failed Operation not supported" and the VCPU dies.

This patch set introduces a dedicated kexec trampoline text section and
builds a minimal trampoline page table for it. Both handoffs are then
reworked into a two-pass trampoline:

    1. First enter via the kernel VA, install the trampoline page table,
       and jump to the trampoline VA(=PA) of the entry stub;
    2. Continue execution with PC already on a PA, drop SATP with
       csrw satp,0 (now safe because PC re-anchoring is moot), and
       jump directly to the target -- either the crash kernel entry
       (crash path) or the per-image control_code_buffer that runs
       the relocate body with SATP=0 throughout (normal path).

With this, both kexec and crashdump in RISC-V guests become robust
against the two-stage translation.

Tested on QEMU virt under two configurations:

  * HS-mode bare (QEMU TCG) -- regression check
      - normal kexec: kexec -l/-e succeeds, second kernel boots and
                      prints the userspace SECOND BOOT marker.
      - crash kdump: panic triggers crash kernel boot, /proc/vmcore
                     opens cleanly in crash(1) and shows the panic
                     backtrace.

  * VS-mode (L0 x86 + QEMU TCG -> L1 riscv64 + KVM -> L2)
      Before this series, both paths die with
          kvm run failed Operation not supported
      and an all-zero M-mode register dump on the SATP transition.
      After this series, both paths succeed end-to-end and the
      vmcore opens cleanly in crash.

---
Changes in v3 (Sashiko AI review):
    - Add two new Fixes: patches at the start of the series:
      #1: machine_kexec_cleanup() was empty, so the set_memory_x()
          call in prepare() leaked an executable direct-map page back
          to the buddy allocator on kexec -u (W^X bypass). Fix: add
          set_memory_nx() in cleanup.
      #2: machine_kexec_prepare() FDT search checked
          memsz <= sizeof(fdt) but read sizeof(fdt) bytes from
          segment[i].buf, which can be smaller than memsz. Fix: check
          bufsz instead.
    - Inline the .kexec.tramp.text section definition directly into
      vmlinux.lds.S instead of using a macro in image-vars.h.
    - Rewrite map_tramp_page() to share a single set of lower-level
      page tables between the VA and PA mappings (5 BSS pages instead
      of 9), with a collision-safe walker that only populates entries
      still zero. Add Sv32 support.
    - Link to v2:
      https://lore.kernel.org/linux-riscv/20260526125009.2404-1-fangyu.yu@linux.alibaba.com/
    - Link to v1:
      https://lore.kernel.org/linux-riscv/20260324114527.91494-1-fangyu.yu@linux.alibaba.com/


Fangyu Yu (9):
  riscv: kexec: Reset executable bit on the control code page in cleanup
  riscv: kexec: Bound FDT search by source buffer size, not destination
  riscv: Add kexec trampoline text section to vmlinux.lds.S
  riscv: kexec: Place norelocate trampoline into .kexec.tramp.text
  riscv: kexec: Build trampoline page tables for crash kernel entry
  riscv: kexec: Switch to trampoline page table before norelocate
  riscv: kexec: Always build the trampoline page table
  riscv: kexec: Add the relocate-trampoline wrapper
  riscv: kexec: Route normal kexec through the trampoline page table

 arch/riscv/include/asm/kexec.h     |   5 +
 arch/riscv/kernel/kexec_relocate.S |  92 +++++++++++-----
 arch/riscv/kernel/machine_kexec.c  | 171 +++++++++++++++++++++++++++--
 arch/riscv/kernel/vmlinux.lds.S    |  10 ++
 4 files changed, 241 insertions(+), 37 deletions(-)

-- 
2.50.1

