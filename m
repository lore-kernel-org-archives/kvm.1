Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9A38E8A2;
	Thu, 11 Jun 2026 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161104; cv=none; b=RBb23Vw71wgMcLEZfSgA8dJygoVNtd7NSV4WzKocFLB219oij/r9csCySlFcaix3VCAds9AuGYffp0PuAvMYhYNQHhH/YFpEoKwBRgXeQU1Gdxt+LuEd+IqEqp7VHcisscNHyS4VvUr8w6cwM5+xWE4YVJfqbuJtu7oxL5bbueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161104; c=relaxed/simple;
	bh=UtB17CvQmlkx4aQA4bz3mbEsDxDVyo7OQ5HxgDOrag4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X6B5jGbf4etaHZErnA4i0tt6oHlVG/atmLdecoJQMwa/9xJp17JPBnt4CV/S0nJd39PvxJut+VtMqqayGPK2MEt4Bkp8134U6mPaHEeMo63qGqdJ0erW89pIzEX+SwEKRDy1UDliNguQh9OoLRXxhSXLWSStjZ0y/Oo/6mtMVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx3sCJXCpq4PsSAA--.26662S3;
	Thu, 11 Jun 2026 14:58:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxPMKIXCpq0KeiAA--.44793S2;
	Thu, 11 Jun 2026 14:58:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] LoongArch: KVM: Small enhancement about interrupt injection
Date: Thu, 11 Jun 2026 14:58:09 +0800
Message-Id: <20260611065815.1439154-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPMKIXCpq0KeiAA--.44793S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here add illegal parameter check in kvm_vcpu_ioctl_interrupt() since this
function is called from user mode. Also interrupt inject is handled with
batch method, rather one by one.

---
v5 ... v6:
  1. Remove INT_SWI0 interrupt injection in kvm_vcpu_ioctl_interrupt()
     since there is no corresponding INT_SWI0 interrupt clear. Here keep
     the smallest modification.
  2. Rename macro KVM_VIP_DELTA with VIP_DELTA, KVM_ESTAT_IRQ_MASK with
     KVM_ESTAT_INTI_MASK, and KVM_ESTAT_HWI_MASK with KVM_ESTAT_EXTI_MASK
     in patch 3.

v4 ... v5:
  1. Replace constant 2 with macro GINTC_VIP_DELTA in patch 4.
  2. Keep register CSR_GINTC bits unchanged except CPU_IP0 - CPU_IP7 in
     function _kvm_setcsr().
  3. Add new patch 6 which moves function call with kvm_deliver_intr()
     after smp_store_mb(vcpu->mode, IN_GUEST_MODE).

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
Bibo Mao (6):
  LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()
  LoongArch: KVM: Check msgint feature in interrupt post
  LoongArch: KVM: Use existing macro about interrupt bit mask
  LoongArch: KVM: Inject interrupt with batch method
  LoongArch: KVM: Add valid bit check when set ESTAT CSR register
  LoongArch: KVM: Deliver interrupt after IN_GUEST_MODE is set

 arch/loongarch/include/asm/kvm_vcpu.h |  43 +++++++----
 arch/loongarch/kvm/interrupt.c        | 100 ++++++++------------------
 arch/loongarch/kvm/vcpu.c             |  35 ++++++---
 3 files changed, 82 insertions(+), 96 deletions(-)


base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
-- 
2.39.3

