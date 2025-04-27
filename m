Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A01FC11F;
	Sun, 27 Apr 2025 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745721912; cv=none; b=IuPdzjyLi8n8r3t2etspa9H5gCg7csmttEVIO7FAjCXBkndhFYIczlYohdPos3Zsm8AivbX/Yh7JPf9d1j96t8+rluKsasRwZ4uCXerHdMVXpzGx7wbBk9KatMAOD3ZLVkd6+4DZsCaJlbsbSsehHwrSx0y1IAFClMNqBwGoU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745721912; c=relaxed/simple;
	bh=wt2ehID0VmzHa28pTGB8TF3NGycrDvdXJ9lz8qF+OJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ci4KK+0nuUKXhRO46HDnCuqiapRjL5cIsaUdWnUr8zw0PKUvjPFyhK3nZWponR8Xa5sBUCmKZVcJhr1LWilATCZO+M9KDsiW57CFSF1TJSmnCDzIXMemuNvEJqhHLZoMYzP9WeOqRQwEcaBAU9UAcXEvx1dCtHD5a3o+t4wvA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxOGoymg1oxArHAA--.4065S3;
	Sun, 27 Apr 2025 10:45:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMCxLcUxmg1oz+WXAA--.49302S2;
	Sun, 27 Apr 2025 10:45:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] LoongArch: KVM: Do not flush tlb if HW PTW supported
Date: Sun, 27 Apr 2025 10:45:03 +0800
Message-Id: <20250427024505.129383-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLcUxmg1oz+WXAA--.49302S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With HW PTW supported, stale TLB is not added if page fault happens. With
EXCCODE_TLBM exception, stale TLB may exist because last read access, tlb
flush operation is necessary with EXCCODE_TLBM exception, and not necessary
with other memory page fault exceptions.

With SW PTW supported, invalid TLB is added in TLB refill exception.
TLB flush operation is necessary with all page fault exceptions.

---
  v1 ... v2:
    1. Add kernel doc notation since new parameter ecode is added, which is
       reported from LKP.
---

Bibo Mao (2):
  LoongArch: KVM: Add parameter exception code with exception handler
  LoongArch: KVM: Do not flush tlb if HW PTW supported

 arch/loongarch/include/asm/kvm_host.h |  2 +-
 arch/loongarch/include/asm/kvm_vcpu.h |  2 +-
 arch/loongarch/kvm/exit.c             | 37 ++++++++++++++-------------
 arch/loongarch/kvm/mmu.c              | 18 ++++++++++---
 4 files changed, 35 insertions(+), 24 deletions(-)


base-commit: 5bc1018675ec28a8a60d83b378d8c3991faa5a27
-- 
2.39.3

