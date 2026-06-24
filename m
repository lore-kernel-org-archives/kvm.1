Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58E3624D7;
	Wed, 24 Jun 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288594; cv=none; b=Y4WVVjnI1KsGcSEcbrbFPhJzyofmkY7Ni+WS7uj9D75pb6qGkIrGhzTIeJt0TfuPh8/KlYJqWdw5iy+TRsjPty96IwIMa8pe1lN1S8Cu6a7KahPA8wNEgA/8dy3L1MFRUdhLhjsCl0rjgykgVgoQFLfHbZ8f/cZbAiCZo4xNdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288594; c=relaxed/simple;
	bh=8nlqzFvBUk4skNvu+ukAgV3XS35MmadXMQP16BFdbn0=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=P/pcz8+L97AT9qrzNWSG0C62mKbJKUyUN/jesuG6YipBJuJ3S5tyjVRub7JsforRGv+S3Sigk6fuJl0dIfbNfbBFCOlyKnMCyt+SlEqPfu6d84jWJDS/kqOPz9B22sIK7pzJ/HR7NUxf/TY/gaOyczoUUET1gUkwOKxUPK9YSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4glZBf3yFMzCh5m;
	Wed, 24 Jun 2026 16:01:14 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4glZBX1x2vz5TCG0;
	Wed, 24 Jun 2026 16:01:08 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4glZBR49Ywz8Xrrf;
	Wed, 24 Jun 2026 16:01:03 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 65O80qZY088369;
	Wed, 24 Jun 2026 16:00:52 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 24 Jun 2026 16:00:54 +0800 (CST)
X-Zmail-TransId: 2b046a3b8eb661b-fd032
X-Mailer: Zmail v1.0
Message-ID: <20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn>
Date: Wed, 24 Jun 2026 16:00:54 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atish.patra@linux.dev>, <alex@ghiti.fr>, <wang.yechao255@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIFJFU0VORCAwLzVdIEltcGxlbWVudCBFYWdlciBQYWdlIFNwbGl0dGluZyBmb3IgUklTQy1W?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 65O80qZY088369
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.35.20.165 unknown Wed, 24 Jun 2026 16:01:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3B8EC9.001/4glZBf3yFMzCh5m

From: Wang Yechao <wang.yechao255@zte.com.cn>

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

Changes in v3 resend:
 - Fix patch format to ensure emails reach the linux-riscv and kvm-riscv
   mailing lists.
 - Move the free pgd_split_page_cache into kvm_arch_destroy_vm().

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
 arch/riscv/kvm/gstage.c                       | 21 +++--
 arch/riscv/kvm/mmu.c                          | 91 ++++++++++++++++++-
 arch/riscv/kvm/vm.c                           |  6 ++
 6 files changed, 116 insertions(+), 16 deletions(-)

-- 
2.43.5
