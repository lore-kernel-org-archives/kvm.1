Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE253D9025;
	Thu, 15 Oct 2026 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046836; cv=none; b=Cp/LSN6pfacgWtz31AEiDXbz2wbY1pznRskC70Zkw7gHWh5WzsaYpM3M0rc7Xe7uesImfjprtYPLLQcWFOHX3aipt1GVWmMNagD3xaCKtPifoRVM2++ANJ111H2NuGoIpHIU0hq+vRna3ZTWzbG6xmTyqFbD+ibzGBmNFcMNPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046836; c=relaxed/simple;
	bh=HzhBr8+hGnC8+QpQfpW4tkxgtK9VVNSpeBW+/1bD83Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tngmHCFwnwAR/oE/tVrKfCiIAwvy69qVKZlaBnC+EwDhkG5g7nR0clGMiIjNkAqgqU2NNc9zaIfctsQvwa4jBdLvdYFkp/ecMb/Xut2FJdQfabWLFUQXQovRqvDCX3jlfeMy9M9NngAt68zfhNgQkgVaTPM+FxldiOG7iTBm5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.109])
	by gateway (Coremail) with SMTP id _____8DxTNLwdtBqKgUWAA--.63793S3;
	Thu, 15 Oct 2026 14:47:12 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.109])
	by front1 (Coremail) with SMTP id qMiowJAx3c7sdtBqKI4sAA--.28417S2;
	Thu, 15 Oct 2026 14:47:11 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch KVM changes for v7.4
Date: Thu, 15 Oct 2026 14:46:56 +0800
Message-ID: <20261015064656.1525830-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c7sdtBqKI4sAA--.28417S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4fAF1kGr1DCw47GrWDZFc_yoW5JFWkpF
	y3urnxJr4rGr93Ar9Fg34kur1DJr1xGr1aqa4akFyxCr43Zr1UXry8Gr1kXFy5J3yrJry0
	qr1fGw1agF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07jepB-UUUUU=

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-kvm-7.4

for you to fetch changes up to 34f4ce22cf25802d8026c60c13c2db81f8c8e3a0:

  KVM: LoongArch: selftests: Enable HW PTW by auto detection method (2026-10-13 16:49:05 +0800)

----------------------------------------------------------------
LoongArch KVM changes for v7.4

1. Add separate vmid support.
2. Simplify MSI intterupt injection.
3. Add hypercall crash support.
4. Allow to set pv_feature until vCPU run.
5. Enable HW PTW automatically in selftests.

----------------------------------------------------------------
Bibo Mao (8):
      LoongArch: KVM: Add vmid support for stage2 MMU
      LoongArch: KVM: Implement vmid updating logic
      LoongArch: KVM: Probe & enable separate vmid feature
      LoongArch: KVM: Remove parameter "level" when injecting MSI
      LoongArch: KVM: Remove duplicated checking with DMSI irq injection
      LoongArch: KVM: Add hypercall crash support
      LoongArch: KVM: Allow to set pv_feature until vCPU run
      KVM: LoongArch: selftests: Enable HW PTW by auto detection method

Chaithanya Lagisetty (1):
      LoongArch: KVM: Return the actual error code in kvm_ipi_create()

 arch/loongarch/include/asm/kvm_dmsintc.h           |  3 +-
 arch/loongarch/include/asm/kvm_host.h              | 15 ++++-
 arch/loongarch/include/asm/kvm_para.h              |  3 +
 arch/loongarch/include/asm/kvm_pch_pic.h           |  2 +-
 arch/loongarch/include/asm/loongarch.h             |  5 ++
 arch/loongarch/include/uapi/asm/kvm.h              |  1 +
 arch/loongarch/include/uapi/asm/kvm_para.h         |  1 +
 arch/loongarch/kernel/asm-offsets.c                |  1 +
 arch/loongarch/kernel/cpu-probe.c                  |  4 ++
 arch/loongarch/kvm/exit.c                          | 11 ++++
 arch/loongarch/kvm/intc/dmsintc.c                  | 36 +++--------
 arch/loongarch/kvm/intc/ipi.c                      |  7 +--
 arch/loongarch/kvm/intc/pch_pic.c                  |  6 +-
 arch/loongarch/kvm/irqfd.c                         |  4 +-
 arch/loongarch/kvm/main.c                          | 71 ++++++++++++++++++++--
 arch/loongarch/kvm/mmu.c                           | 25 +++++++-
 arch/loongarch/kvm/switch.S                        |  5 +-
 arch/loongarch/kvm/tlb.c                           | 19 +++++-
 arch/loongarch/kvm/vcpu.c                          | 15 ++++-
 arch/loongarch/kvm/vm.c                            |  2 +
 .../selftests/kvm/include/loongarch/processor.h    |  3 +
 .../selftests/kvm/lib/loongarch/processor.c        | 16 ++++-
 22 files changed, 194 insertions(+), 61 deletions(-)

