Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908D395D9D;
	Mon, 30 Mar 2026 03:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843129; cv=none; b=Xv0mVy5p92Tw6b8HXQPYlajMXYRHTGptKIc1CWNCtfWAnv6v0crvnoQaWH6GcLOTSVWMd4n8+ypEBRXkHlz5GmxHi0pyu21IrBTP+Mx0hU1Z0K2aJZTWlPbDsa3Lv9kirqe5A+yjaQAQAmYUNIfjMW/4V30QIpsY1JFa0XVTpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843129; c=relaxed/simple;
	bh=Q/Qqosef7fd+GnpzML4D9oYplAc7kKtnLiWwgG1E/ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBSLLe3lJ1FZfVAP/T8Di6n3YK3v+eVODBxXACsisUxCF7/DLjEa4GUu45zvGH3i49k9HO9CnG/GBr3O4xvZbbrib1C71Iwjyg7uUg3lPxLqzIgF+syAeuk1FUTRB2ht7g8LJlYWhCY/dU/QGcsFtKg8fIM3/+jy7es5Vv1SfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxD6rr9MlpO9IfAA--.31458S3;
	Mon, 30 Mar 2026 11:58:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCx_8Lq9MlpwXFgAA--.53173S2;
	Mon, 30 Mar 2026 11:58:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with FPU exception
Date: Mon, 30 Mar 2026 11:58:26 +0800
Message-Id: <20260330035832.2204720-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx_8Lq9MlpwXFgAA--.53173S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With FPU save and restore flow, the cost is the same with different
FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impaction.

Here is to enable FPU with max VM supported type, for example if
VM supports LASX instrction, enable FPU with LASX type even with FPU
exeception. So it can avoid possible LSX/LASX exception in future.

With context switch microbench which may touch FPU and LASX, there is 9%
improvement when halt_poll_ns is disabled. The command is
"./context --test=pipe" and source code located at:
  https://github.com/bibo-mao/context_switch/blob/main/context.c

Original     Wih patch      improvement
75232        82440          9%

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Enable FPU with max VM supported FPU type, rather than max used type.
  2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
  3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
  3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
  4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_lasx(),
     directly enable LSX or LASX from FPU none state.
---
Bibo Mao (6):
  LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
  LoongArch: KVM: Enable FPU with max VM supported FPU type
  LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
  LoongArch: KVM: Remove some middle FPU states
  LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
  LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX

 arch/loongarch/include/asm/kvm_host.h |  6 +--
 arch/loongarch/kvm/exit.c             | 21 +++-----
 arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------------
 3 files changed, 30 insertions(+), 75 deletions(-)


base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
-- 
2.39.3

