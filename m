Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA953C8732;
	Wed, 29 Apr 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455038; cv=none; b=e7XmXw2FWa/IrUs75/iv3F6c/veMTvXGh3PTi07RfyBTfesoqU69B+YBiEq/tahUbZtCn805PKdsqIDPOJ/lJyf+x1QkQqR9glSvsvuQqB0Bmec4YBd7In8TfrxYpwV02nQscvA/qwWkgvyFH9/Va45eUlB7O0wi/+3ogWBfixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455038; c=relaxed/simple;
	bh=i12dJVJeoC9r4Nnt28ZuQRVCr9MPie70raPqffp5U9M=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=GpzxOcQ/T2OD9Szcva9ChO+ssY+h1Q8RXlJUUUuOwPh3A++UfBEm6pY1IqSqSFRQDKTWiPoI7BnqBuXVOcnl8mg6JtbUWltW0RwE2BiDcmXPZ97jhxdsJ1p54FhoHJo4eTG0MF+YM9VHazqeF+3ktcae1cw2bhw+bcKc9g16q2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4g5BqD4HWzz51SWV;
	Wed, 29 Apr 2026 17:30:16 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl2.zte.com.cn with SMTP id 63T9U0DW026223;
	Wed, 29 Apr 2026 17:30:00 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 29 Apr 2026 17:30:02 +0800 (CST)
X-Zmail-TransId: 2b0569f1cf9a10b-91c9b
X-Mailer: Zmail v1.0
Message-ID: <20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn>
Date: Wed, 29 Apr 2026 17:30:02 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvM10gUklTQy1WOiBLVk06IEh1Z2UgcGFnZSByZWNvdmVyeSBkdXJpbmcgZGlzYWJsZS1kaXJ0eS1sb2c=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 63T9U0DW026223
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 29 Apr 2026 17:30:16 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69F1CFA8.001/4g5BqD4HWzz51SWV

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

Changes in v2:
 - Rebased on Linux v7.1-rc1.
 - Skip recovering huge pte if the first child pte is not leaf.

 - Link to v1:
 https://lore.kernel.org/linux-riscv/20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn/T/#t

Wang Yechao (3):
  RISC-V: KVM: Refactor kvm_arch_commit_memory_region()
  RISC-V: KVM: add tracepoints for guest page faults
  RISC-V: KVM: Recover gstage huge page mappings during
    disable-dirty-log

 arch/riscv/include/asm/kvm_gstage.h |  4 ++
 arch/riscv/kvm/gstage.c             | 42 ++++++++++++++++++++
 arch/riscv/kvm/mmu.c                | 59 ++++++++++++++++++++++++++++-
 arch/riscv/kvm/trace.h              | 25 ++++++++++++
 arch/riscv/kvm/vcpu_exit.c          |  3 ++
 5 files changed, 132 insertions(+), 1 deletion(-)

-- 
2.43.5
