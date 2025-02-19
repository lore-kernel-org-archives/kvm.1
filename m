Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1878F7D;
	Wed, 19 Feb 2025 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936310; cv=none; b=E3DDSI34rZlk4zwiTQbqVwarCJoblN9IVDyXjdYJRYoYP6XvP7/CcK+2bh0UYaW4GBqyi60eGrB0q4zIWCz1wmrxkx2Xhrx5CZl3gD5q8vy8vIz1hwc9J/B2sSuS9La5iPadM/uHKPnXW+EaRDMoPufYjHDkcP8yiZgWoCnukF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936310; c=relaxed/simple;
	bh=8LeYU8TRZ/6/0DNIAyLKTCzyrZ3iB53h6wHlDKuLiUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFHLifv+m+XDdz+4sbNTotZf2x7nH3pSu4WguvM4kAlnZ3azspzqemeHGFCdmMjNqLVAFRkoB0Hh/euLsenWEL+H/2tl/QCcf1mqM16qSboOtiy90sScJq1/wAcrCiaKHmWLXfGKr2AoaNdmIfjmUPAvpnwxXD+Tg6zpokDtgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxyuAwUrVn54p6AA--.14892S3;
	Wed, 19 Feb 2025 11:38:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMAxj8UwUrVnRnAbAA--.39192S2;
	Wed, 19 Feb 2025 11:38:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] LoongArch: KVM: Enhancement about PGD saving
Date: Wed, 19 Feb 2025 11:38:21 +0800
Message-Id: <20250219033823.215630-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxj8UwUrVnRnAbAA--.39192S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There is enhancement about PGD saving about KVM hypervisor. Register
LOONGARCH_CSR_PGDL is shared between host kernel and KVM hypervisor.
For host kernel it is for user space pgd of VMM threads, secondary mmu
for KVM hypervisor. Both are not changed after VM is created, so it
can be saved as host_pgd and kvm_pgd in advanced.

Also it fixes GPA size typo issue, it should cpu_vabits rather than
cpu_vabits - 1. And inject data abort error to VM if it exceeds maximum.
GPA size. For example there will be data abort when executing command:
 # busybox devmem 0xc00000100008
  Bus error (core dumped)
Previous it is treated as MMIO address and let VMM handle this.

---
  v1 ... v2:
    1. Use name kvm_pgd rather than host_second_pgd for PGD of
       hypervisor.
    2. Fix GPA size typo issue and add page fault address checking.

---
Bibo Mao (2):
  LoongArch: KVM: Remove PGD saving during VM context switch
  LoongArch: KVM: Fix GPA size issue about VM

 arch/loongarch/include/asm/kvm_host.h |  2 ++
 arch/loongarch/kernel/asm-offsets.c   |  4 +---
 arch/loongarch/kvm/exit.c             |  6 ++++++
 arch/loongarch/kvm/switch.S           | 12 ++----------
 arch/loongarch/kvm/vcpu.c             |  8 ++++++++
 arch/loongarch/kvm/vm.c               |  7 ++++++-
 6 files changed, 25 insertions(+), 14 deletions(-)


base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
-- 
2.39.3

