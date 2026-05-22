Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF7B23AB9D;
	Fri, 22 May 2026 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432591; cv=none; b=tDg15yLMgU7hQw+uKh6D8obCUogbSFNJ9Vg6FVlmllhc4Il1p5g5tiCc+APJd7tp+LA2kpAd6/DIyewj5sc4ieHpdPN1Gn7R+yFxTGHq7g1ddz6DwZNTZrZ3fiESspaRZRUJY0c4NCf5A2iLW6rgWnYPFvbyI1JO364O+GztYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432591; c=relaxed/simple;
	bh=7aUGVhxJ8KUI6+DqQ5S9ORhmmSzCY5GipPsgPPOYLCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GPJLqbFC8ZLllXNDUSvmsMDf0N5FAVOZxQpwZJI0bHd3WlYqoQQDnkrR74npxR40q7vDca1hJLcSTi4YKAcSIQ6mPLaVj1QKQh24W4lHWEOF0eVJYvJT2aDxe3PxtO9XDGnckcDr8pFJOiAMABicMD8rQ/SRuvAQ9AO01zM6HgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxhumL_A9qS0sMAA--.35909S3;
	Fri, 22 May 2026 14:49:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxpsCL_A9qKU6MAA--.34947S2;
	Fri, 22 May 2026 14:49:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] LoongArch: KVM: Small enhancement about interrupt injection
Date: Fri, 22 May 2026 14:49:40 +0800
Message-Id: <20260522064945.614486-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsCL_A9qKU6MAA--.34947S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here add illegal parameter check in kvm_vcpu_ioctl_interrupt() since this
function is called from user mode. Also interrupt inject is handled with
batch method, rather one by one.

---
v3 ... v4:
  1. change type of local variable vector with unsigned int rather than
     int, and use abs() macro.
  2. Remove last patch since kvm_vcpu_sync_intr() does not sync cached
     AVEC interrupt to SW CSR_ISR state.
  3. Replace kvm_set_sw_gcsr() with kvm_write_sw_gcsr() in patch 5,
     since kvm_set_sw_gcsr() is ORed cached ESTAT interrupt bits,
     kvm_write_sw_gcsr() is to overwrite the whole SW ESTAT register.
  4. Modify typo issue about title and log message in patch 5, replace
     GSTAT with ESTAT

v2 ... v3:
  1. Split patch 1 into two smaller patches, one is smaller bugfix patch
     with irq validility check in kvm_vcpu_ioctl_interrupt(), so that it
     is easy to porting to old kernel.

v1 ... v2:
  1. Add irq validility check in function kvm_vcpu_ioctl_interrupt().
  2. Add valid bit check when set ESTAT CSR register.
  3. Merge two patches about interrupt clear and set with batch method into
     one.
---
Bibo Mao (5):
  LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()
  LoongArch: KVM: Check msgint feature in interrupt post
  LoongArch: KVM: Use existing macro about interrupt bit mask
  LoongArch: KVM: Inject interrupt with batch method
  LoongArch: KVM: Add valid bit check when set ESTAT CSR register

 arch/loongarch/include/asm/kvm_vcpu.h |  43 +++++++----
 arch/loongarch/kvm/interrupt.c        | 100 ++++++++------------------
 arch/loongarch/kvm/vcpu.c             |  41 +++++++----
 3 files changed, 85 insertions(+), 99 deletions(-)


base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
-- 
2.39.3

