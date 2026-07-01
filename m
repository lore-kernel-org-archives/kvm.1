Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5642DFEC;
	Wed,  1 Jul 2026 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907844; cv=none; b=byOp+OLAsZwjy1RPhJwKZn2AJVoQ1O9tnWxqK60wHHDr+OU/N/+Gtcn8Albyu4UVeiFtTuTv3ce9stqSQupP8tqFuisT/IFLh9W8u9acct/OIbrCkraO4YTxI5wS23NgZrQA33J3e1mI9DRXsREfkqFLxZn/Hup7hslL3V9QVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907844; c=relaxed/simple;
	bh=QB6pV/t0N+Y2X40l0uM/wHYlwLY/kId2JrE8EAhE0a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IWeCTRhLKjzSpaEtdtQ5pYhietIbZPoBStxZJmIDtXG58vCUwKx3I7QvenuTxNzk4rEVIX7/Hm/XkDWWXIfjpVHvHm8QARvfCYa4ErSUjJ/kW/UP6vMrwApOqt9IMzL3RiSbkuYGcimfIJtlnyAAS7F+njf4T7kooX7Cb1fEHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gqzP543Gzz5B108;
	Wed, 01 Jul 2026 20:10:33 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 661CAON0076947;
	Wed, 1 Jul 2026 20:10:24 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Wed, 1 Jul 2026 20:10:26 +0800
X-Zmail-TransId: 3e816a4503b2008-1d59b
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v4 0/5] Implement Eager Page Splitting for RISC-V
Date: Wed,  1 Jul 2026 20:09:43 +0800
Message-ID: <20260701120954.129873-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 661CAON0076947
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 01 Jul 2026 20:10:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4503B9.001/4gqzP543Gzz5B108

Eager Page Splitting is implemented on x86 and ARM. It improves the
performance of dirty logging (used in live migrations) when guest memory
is backed by huge pages.

This series implement Eager Page Splitting for RISC-V. The Implementation
similar to x86 and ARM. It provides two ways to split huge pages in ioctl
context instead of on fault in vCPU context:

- Split huge pages when dirty logging is enabled when
  KVM_DIRTY_LOG_INITIALLY_SET is not set. This happens when enabling the
  KVM_MEM_LOG_DIRTY_PAGES flag of a memslot, and splits the whole memslot
  into 4K mappings.

- Split huge pages during KVM_CLEAR_DIRTY_LOG when
  KVM_DIRTY_LOG_INITIALLY_SET is set. This happens when enabling dirty log
  in small chunks. It does not split the whole memslot, but only the
  requested chunk range.

Changes in v4:
 - Rebase on v7.2-rc1 version.
 sashiko-bot AI review
 (https://sashiko.dev/#/patchset/20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn)
 - Add the rwlock_needbreak() check when toup split cache.
 - ALIGN_DOWN the start addr to PMD_SIZE.

Changes in v3 resend:
 - Fix patch format to ensure emails reach the linux-riscv and kvm-riscv
   mailing lists.
 - Move the free pgd_split_page_cache into kvm_arch_destroy_vm().
 https://lore.kernel.org/kvm-riscv/20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn/

Changes in v3:
 - Rebase on v7.1 version.
 - Add patch03 to remove the redundant TLB flush operations.
 
 sashiko-bot AI review
 (https://sashiko.dev/#/message/20260603104847.9692C1F00893%40smtp.kernel.org)
 - Check the kvm->arch.pgd before split huge pages.
 - Align the start address to PMD_SIZE before split.
 - Flushing remote TLBs before Dropping mmu_lock.

Changes in v2:
 - Rename the split_page_cache.
 - Rename the kvm_riscv_split_huge_pages and
   kvm_riscv_split_memory_region.
 - Add lockdep_assert_held check before split huge pages.
 - Update Documentation/admin-guide/kernel-parameters.txt.
 - Link to v2
 https://lore.kernel.org/linux-riscv/20260603175256408L0jnqGs1cJGc0ijCdujci@zte.com.cn/

 - Link to v1:
 https://lore.kernel.org/linux-riscv/20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn/

Wang Yechao (5):
  RISC-V: KVM: Add the split page cache for ioctl context
  RISC-V: KVM: Split huge pages when dirty logging is enabled
  RISC-V: KVM: Remove redundant TLB flush operations
  RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
  RISC-V: KVM: Add the eager_page_split module parameter

 .../admin-guide/kernel-parameters.txt         |  7 +-
 arch/riscv/include/asm/kvm_gstage.h           |  6 +-
 arch/riscv/include/asm/kvm_host.h             |  1 +
 arch/riscv/kvm/gstage.c                       | 23 +++--
 arch/riscv/kvm/mmu.c                          | 93 ++++++++++++++++++-
 arch/riscv/kvm/vm.c                           |  6 ++
 6 files changed, 119 insertions(+), 17 deletions(-)

-- 
2.43.5

