Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61833B6D1;
	Mon, 14 Sep 2026 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366056; cv=none; b=t9lMZw1JGgRfVS23yho/+Oc/Rsw7N9Dwq5EWxepBybPr9gpifCrQf3uo/GN3JhjuYXVDPtq43GCJWSnSsXizsI3f7S0oEiWQP/hx98KOHOlUY4O0P8eWK3lTNTavvtePOZ/hZh6P451z+fpEEb0ooa5XfZ9MoGkJ4DDer4EVHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366056; c=relaxed/simple;
	bh=3vV5UG8QFjh4Dm1S1r/OtpPm8SRLyhLBFww29dIygQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAIt9Clku900JZ7s5/9osHgekHVcFMWJvOuJ9uMRoRh4pFPHHHDtMZJgY5igNBDwug/v0AdDhtmN0ZFSgqPMa7KFYhAhyjyfKiS320yWyocyeO40LeYXJwOMDePfIt6YlArnfNNog1jI/+VNjwgVqk1V2f9cB/payncWNyZuV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hjvnP1Szpz8XrrJ;
	Mon, 14 Sep 2026 14:07:21 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 68E67Do5009983;
	Mon, 14 Sep 2026 14:07:13 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Mon, 14 Sep 2026 14:07:15 +0800
X-Zmail-TransId: 3e816aa78f1201c-a0873
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
Subject: [PATCH v5 0/2] RISC-V: KVM: Huge page recovery during disable-dirty-log
Date: Mon, 14 Sep 2026 13:59:16 +0800
Message-ID: <20260914055936.3672758-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 68E67Do5009983
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 14 Sep 2026 14:07:21 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AA78F19.000/4hjvnP1Szpz8XrrJ

When dirty logging is enabled, the gstage mappings are split into
4K pages to track dirty pages. If the migration fails or is canceled,
in order to keep the VM's performance consistent with that before
dirty logging was enabled, we need to recover the gstage huge page mappings
when dirty logging is disabled.

With this series, dirty_log_perf_test shows a decrease in the number of
vCPU faults:

$ perf stat -e kvm:kvm_page_fault \
/dirty_log_perf_test -s anonymous_hugetlb_1gb -v 1 -e -b 1G

Before: 1,574,460    kvm:kvm_page_fault 
After : 788,048      kvm:kvm_page_fault

Changes in v5:
 Fix the issues reported by sashiko
 - Use _PAGE_PFN_SHIFT instead of pfn_pte to make huge pte.
 - Validate host size via hugetlb_mapping_size() before recovery.
 - Skip bad advancement after mmu_recover_huge_pages_range.

Changes in v4:
 - Rebased on Linux v7.3-rc2.
 - Squash Patch01 into Patch03.
 - The 1G mapping recovery is performed only after all 2M leaf recover succeed.
 https://lore.kernel.org/linux-riscv/20260913070352.3626956-1-wang.yechao255@zte.com.cn

Changes in v3:
 - Rebased on https://github.com/kvm-riscv/linux/tree/riscv_kvm_queue
 - Add support to recover 1GB mappings for gstage.
 - Refactor kvm_arch_commit_memory_region to be identical to arm64.
 (sashiko AI Reviews)
 - Scan the child page table for the first valid leaf PTE to recover.
 - Add the memslot boundaries check when recover hugepages.
 - Move the cond_resched_lock to the start loop iteration.
 - The kvm_page_fault tracepoint be placed before the conditional block.
 - Remove the fault_supports_gstage_huge_mapping check.
 https://lore.kernel.org/linux-riscv/20260605160019772GJy5SDmWQQF7sSqvJ0JtC@zte.com.cn/

Changes in v2:
 - Rebased on Linux v7.1-rc1.
 - Skip recovering huge pte if the first child pte is not leaf.
 - Link to v2:
 https://lore.kernel.org/linux-riscv/20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn/

 - Link to v1:
 https://lore.kernel.org/linux-riscv/20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn/

Wang Yechao (2):
  RISC-V: KVM: add tracepoint for guest page faults
  RISC-V: KVM: Recover gstage huge page mappings during
    disable-dirty-log

 arch/riscv/include/asm/kvm_gstage.h |   4 +
 arch/riscv/kvm/gstage.c             |  67 +++++++++++++++
 arch/riscv/kvm/mmu.c                | 123 +++++++++++++++++++++++++++-
 arch/riscv/kvm/trace.h              |  22 +++++
 arch/riscv/kvm/vcpu_exit.c          |   2 +
 5 files changed, 217 insertions(+), 1 deletion(-)

-- 
2.27.0

