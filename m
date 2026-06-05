Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBF48B37D;
	Fri,  5 Jun 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646430; cv=none; b=E5zxlEjYsuX9rFwV2qqYLCD6T2ky1OSqMsv63TQBaArt9gyt3+7wc2TplgQGQ6kmwrJdcco/aRCWkYJjlR7jgoFqfQJhjb0UNIbfSpSkRv7f/UYxwNfKOuSLc3VTf+sloXBR7SoEFu+J6CnbfxWTjsu8OEKL4CXkHlr5yB14NO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646430; c=relaxed/simple;
	bh=NWLICiL6E1ziDdfmuJzvQYOKdBKzxww6SlAcKIkw1Vw=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=XLg+/r0w2uUgoz2ebIyO5nkEE5p2mINluRn0qCiA01JKsZufpB4LucjgNg6aKO22+IZtCllW+wnI5I7BVGSlRvl18DNszxB2l09A22K7IC8F51lVM9EbRcjsPSX3nt/jEpDQIO0AofMaNM5tZQLsUdsA71Oan1UIA2YWIQFGgSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gWv4T0CLgz8XrrM;
	Fri, 05 Jun 2026 16:00:25 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl1.zte.com.cn with SMTP id 65580Hva031765;
	Fri, 5 Jun 2026 16:00:17 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid12;
	Fri, 5 Jun 2026 16:00:19 +0800 (CST)
X-Zmail-TransId: 2b066a228213591-1cae8
X-Mailer: Zmail v1.0
Message-ID: <20260605160019772GJy5SDmWQQF7sSqvJ0JtC@zte.com.cn>
Date: Fri, 5 Jun 2026 16:00:19 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wang.yechao255@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0ggdjMgMC8zXSBSSVNDLVY6IEtWTTogSHVnZSBwYWdlIHJlY292ZXJ5IGR1cmluZyBkaXNhYmxlLWRpcnR5LWxvZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65580Hva031765
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 05 Jun 2026 16:00:25 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A228219.000/4gWv4T0CLgz8XrrM

From: Wang Yechao <wang.yechao255@zte.com.cn>

When dirty logging is enabled, the gstage mappings are split into
4K pages to track dirty pages. If the migration fails or is canceled,
in order to keep the VM's performance consistent with that before
dirty logging was enabled, we need to recover the gstage huge page mappings
when dirty logging is disabled.

With this series, dirty_log_perf_test shows a decrease in the number of
vCPU faults:

$ perf stat -e kvm:kvm_page_fault \
/dirty_log_perf_test -s anonymous_hugetlb_1gb -v 1 -e -b 1G

Before: 524,819      kvm:kvm_page_fault
After : 263,211      kvm:kvm_page_fault

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

Changes in v2:
 - Rebased on Linux v7.1-rc1.
 - Skip recovering huge pte if the first child pte is not leaf.
 - Link to v2:
 https://lore.kernel.org/linux-riscv/20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn/

 - Link to v1:
 https://lore.kernel.org/linux-riscv/20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn/

Wang Yechao (3):
  RISC-V: KVM: Refactor kvm_arch_commit_memory_region()
  RISC-V: KVM: add tracepoint for guest page faults
  RISC-V: KVM: Recover gstage huge page mappings during
    disable-dirty-log

 arch/riscv/include/asm/kvm_gstage.h |   4 +
 arch/riscv/kvm/gstage.c             |  61 +++++++++++++++
 arch/riscv/kvm/mmu.c                | 112 +++++++++++++++++++++++++++-
 arch/riscv/kvm/trace.h              |  25 +++++++
 arch/riscv/kvm/vcpu_exit.c          |   3 +
 5 files changed, 204 insertions(+), 1 deletion(-)

-- 
2.43.5
