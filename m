Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2737B3F9;
	Fri, 10 Apr 2026 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816604; cv=none; b=hk+lm7j+x2r/lPZhiBcwGQct0uMe9DpxIVmmHHWaUiLH7NRuT91Vdnan2Uc5LhZRigjr6EGdFEb/zVj90x93zUlKxqY9N0GE4TXI1ApyINWIJlucUBTDg8qnWa8nZ69iT9QE7old5guNgt41hsTctPcUl39eLwDfNe6kmwT4S1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816604; c=relaxed/simple;
	bh=yBZaykq8NceUyGXJ09ciRntxCq5vrz2Gky5gYr1KgLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yd2ysVfgyV/1aakHG1CePMhgwbsZuD5SjaH47saF/KUofWIB6klo6PJ+51vdLWuVvOckYGMTsQKpI8IAnAYW9ObPtJKy1IzK55mZrLtU2WPeLIWLe6GQcpaT9mZM4xGQioI1+36zq3p9+XjzSAE0gudc4iUtxvS6SETsyJ8LlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.17])
	by gateway (Coremail) with SMTP id _____8Cx_6qRz9hpIfYjAA--.1171S3;
	Fri, 10 Apr 2026 18:23:13 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.17])
	by front1 (Coremail) with SMTP id qMiowJCxdcCEz9hpUkpqAA--.37300S2;
	Fri, 10 Apr 2026 18:23:10 +0800 (CST)
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
Subject: [GIT PULL] LoongArch KVM changes for v7.1
Date: Fri, 10 Apr 2026 18:22:45 +0800
Message-ID: <20260410102245.2749691-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdcCEz9hpUkpqAA--.37300S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw1DArWDXr4DCFWxtFyfKrX_yoW5WF4kpF
	W3urn3Gr48GFyfJrn7Ka4DurnrJF1xGr1IqF1ayFy8Ar42vF18Xry8GrykXFy5Gay8Jr1F
	vr1fG3WYgF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUc0eHDUUUU

The following changes since commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2:

  Linux 7.0-rc7 (2026-04-05 15:26:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-kvm-7.1

for you to fetch changes up to e47b8e1db9a9bbef6765e85b11e87f48e6b56846:

  KVM: LoongArch: selftests: Add PMU overflow interrupt test (2026-04-09 18:56:38 +0800)

----------------------------------------------------------------
LoongArch KVM changes for v7.1

1. Use CSR_CRMD_PLV in kvm_arch_vcpu_in_kernel().
2. Let vcpu_is_preempted() a macro & some enhanments.
3. Add DMSINTC irqchip in kernel support.
4. Add KVM PMU test cases for tools/selftests.

----------------------------------------------------------------
Bibo Mao (4):
      LoongArch: KVM: Check kvm_request_pending() in kvm_late_check_requests()
      LoongArch: KVM: Move host CSR_EENTRY save and restore in context switch
      LoongArch: KVM: Move host CSR_GSTAT save and restore in context switch
      LoongArch: KVM: Make vcpu_is_preempted() as a macro rather than function

Song Gao (5):
      LoongArch: KVM: Add DMSINTC device support
      LoongArch: KVM: Add DMSINTC inject msi to vCPU
      KVM: LoongArch: selftests: Add cpucfg read/write helpers
      KVM: LoongArch: selftests: Add basic PMU event counting test
      KVM: LoongArch: selftests: Add PMU overflow interrupt test

Tao Cui (1):
      LoongArch: KVM: Use CSR_CRMD_PLV in kvm_arch_vcpu_in_kernel()

 arch/loongarch/include/asm/kvm_dmsintc.h           |  27 +++
 arch/loongarch/include/asm/kvm_host.h              |   3 +
 arch/loongarch/include/asm/kvm_pch_pic.h           |   3 +-
 arch/loongarch/include/asm/qspinlock.h             |  26 ++-
 arch/loongarch/include/uapi/asm/kvm.h              |   4 +
 arch/loongarch/kernel/paravirt.c                   |  16 +-
 arch/loongarch/kvm/Makefile                        |   1 +
 arch/loongarch/kvm/intc/dmsintc.c                  | 182 ++++++++++++++++++
 arch/loongarch/kvm/intc/pch_pic.c                  |  15 +-
 arch/loongarch/kvm/interrupt.c                     |   2 +
 arch/loongarch/kvm/irqfd.c                         |  10 +-
 arch/loongarch/kvm/main.c                          |  14 +-
 arch/loongarch/kvm/vcpu.c                          |  29 +--
 include/uapi/linux/kvm.h                           |   2 +
 tools/testing/selftests/kvm/Makefile.kvm           |   3 +-
 .../testing/selftests/kvm/include/loongarch/pmu.h  |  66 +++++++
 .../selftests/kvm/include/loongarch/processor.h    |  15 ++
 .../selftests/kvm/lib/loongarch/processor.c        |  15 +-
 tools/testing/selftests/kvm/loongarch/pmu_test.c   | 205 +++++++++++++++++++++
 19 files changed, 593 insertions(+), 45 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
 create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/pmu.h
 create mode 100644 tools/testing/selftests/kvm/loongarch/pmu_test.c

