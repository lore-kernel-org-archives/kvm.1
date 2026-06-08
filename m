Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7E3016FC;
	Mon,  8 Jun 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882357; cv=none; b=qKeTME4uItCJ704FG7fHB4Mw2wN9Xtnzc/qPgATDA6NNDmmQ5JjUZalJ35XOQFpZby+0s+3WFL2rbUmEKOObLSJctnLwGPVxS0AA1SIqCR3HS49ztT+AACdeoLagCaQoMtBUh91CvEXm2Dd1uowCr/56Wwdx5w/SlbnExA1+cDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882357; c=relaxed/simple;
	bh=bqxgKNTa5EAAcgNhUkAHlSDoJo3rS58cZ9vy9ZyYrUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P55R2bmV+arh94PEOD0r96n3liRwRs59mdrjyQMQgZnHcNY9ohRiJcaTRHALZUOh8HFmewZUOAnRju7uMyY83i49EemE1/u9GfyfjlAIj7FAgnHz/tLjHwPVCLf0O0RaXcOV1W8pu450MPVoC1EK9D06/jKX3LttHwcvizHg+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxRemqGyZqJ5kRAA--.41137S3;
	Mon, 08 Jun 2026 09:32:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMKoGyZqNTafAA--.39164S2;
	Mon, 08 Jun 2026 09:32:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] LoongArch: KVM: Set max VM supported FPU type with FPU exception
Date: Mon,  8 Jun 2026 09:32:18 +0800
Message-Id: <20260608013222.375257-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKoGyZqNTafAA--.39164S2
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
v3 ... v4:
  1. Fix one issue on patch 4 with function kvm_lose_fpu(), where flag
     KVM_LARCH_FPU is checked too early so that LBT disabling is
     skipped, since API kvm_lose_fpu() implies kvm_lose_lbt().

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
 3 files changed, 31 insertions(+), 74 deletions(-)


base-commit: c10130c234c81f4a7a143edbf413080235f8d8ce
-- 
2.39.3

