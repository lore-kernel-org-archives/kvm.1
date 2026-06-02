Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B348380FE2;
	Tue,  2 Jun 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386210; cv=none; b=aABKH3nJ/ir0IJ8BM4If8b7jXDqtYhblZFgKL9Bk5AFG9a1ZrtG3U7oA3mjiYHTZUqouppN9IQ26HUhV6NydrG3uzPZXbbJUiXbzwqGoJaDmdrPCwR9xO27ML5c8aXYnunZdeK0V+6y+yw1J9KwYxtGx4GgiDNMIWdiBVL6fWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386210; c=relaxed/simple;
	bh=H6SS0eNn+lEsqlacp1BnRDW02fJeAgo6cPDewTepxn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvpwlwsyuUwUSKixQoBdExMjnvfrMtdn/VHUkWNtNY0f7JFVKoTjxzsK0/FiREdVNqS6anMOKCNpXOuqAtI03SN5UjNiO/xfc3+9qQ/r5LdQZ48d/331kNVNg/yoWZYatHGqNdzJ315qqAXUDl32Q8XwT1TJ0IWB0S31uZ/lXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxvsCdiR5q3qYPAA--.19976S3;
	Tue, 02 Jun 2026 15:43:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxSeCUiR5qGRCZAA--.27953S2;
	Tue, 02 Jun 2026 15:43:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] LoongArch: KVM: Set max VM supported FPU type with FPU exception
Date: Tue,  2 Jun 2026 15:43:12 +0800
Message-Id: <20260602074316.1647373-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeCUiR5qGRCZAA--.27953S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With FPU save and restore, the cost is the same with different FPU width
8/16/32 bytes, whatever from CPU cycle and cache line impaction.

Here is to enable FPU with max VM supported type, for example if
VM supports LASX instrction, enable FPU with LASX type with all FPU
exceptions including FPU/LSX/LASX exception. So if LASX is enabled with
FPU exception, it can avoid potential LSX/LASX exception in future.

With context switch microbench which touches FPU and LASX, there is 9%
improvement when halt_poll_ns is disabled. The command is
"./context --test=pipe" and source code located at:
  https://github.com/bibo-mao/context_switch/blob/main/context.c

Original     Wih patch      improvement
75232        82440          9%

---
v2 ... v3:
  1. Merge patch 1 and patch 3 together, patch 1 adds KVM_REQ_LBT_LOAD
     type, patch 3 renames KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD.
  2. Merge patch 5 and patch 6 together, which remove aux flags
     KVM_LARCH_LSX and KVM_LARCH_LASX

v1 ... v2:
  1. Enable FPU with max VM supported FPU type, rather than max used type.
  2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
  3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
  3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
  4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_lasx(),
     directly enable LSX or LASX from FPU none state.
---
Bibo Mao (4):
  LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
  LoongArch: KVM: Enable FPU with max VM supported FPU type
  LoongArch: KVM: Remove some middle FPU states
  LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX

 arch/loongarch/include/asm/kvm_host.h |  6 +--
 arch/loongarch/kvm/exit.c             | 21 +++-----
 arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------------
 3 files changed, 30 insertions(+), 75 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.39.3

