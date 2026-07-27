Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CA1F91D6;
	Mon, 27 Jul 2026 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137350; cv=none; b=dxXvMHmkvnGEMawoehy2v0W7bV/pn6SAw1lXBN5/JWXOCn2CwUJApv+KobAh1VPHs0wMHcMZhFY/AlrNcTwATru3frKrf2dizGKG2rNSbKzw2YV+9MXMcv7QC22ljeUXYAxzWdpx0ZbKHmtWczgnUhv85XCrsxdvXOaoxXx+62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137350; c=relaxed/simple;
	bh=JI3ByRaXDwvPX2HdoIVbFTjzgLG3tFY7TEZptfZD30w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJP3DClrBrRrb1baii6bRvKUMu0xNmGJWu9LYCkCRX2a4uz5srDQL9zhKTNimtX01XS3bMbHR8B+LtJeoOw/g2GcPwQOgPmZF5NluO9kCGVwLD+/AYPQLD73DPSzS+W4MmYuGSHw+PaKQaytjF7Orql9TuNb7NDKSpaWl0gnicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxturACGdqLqkHAA--.27205S3;
	Mon, 27 Jul 2026 15:29:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxKcSYCGdq8j0aAA--.1000S2;
	Mon, 27 Jul 2026 15:28:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] LoongArch: KVM: Add separate vmid support
Date: Mon, 27 Jul 2026 15:21:03 +0800
Message-Id: <20260727072109.2151675-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxKcSYCGdq8j0aAA--.1000S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

LoongArch KVM hypervisor supports two-level MMU, vpid index is used
for stage1 MMU and vmid index is used for stage2 MMU.

On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
may separate from vpid. There are such advantages if separate vmid
is supported.
  1. One VM uses one vmid, vCPUs on the same VM can share the same vmid.
  2. If one vCPU switch between different physical CPU, old vmid can be
     still useful if the old vmid is not expired
  3. For remote tlb flush, it is to flush TLBs which are mapping
     GPA --> HPA, only vmid need update and vpid need not.

Here add separate vmid feature support, vmid feature detecting method
comes from LVZ version with 2 and LVZ is enabled.

Bibo Mao (6):
  LoongArch: KVM: Add vmid support for stage2 MMU
  LoongArch: KVM: Add separate vCPU and VM id update function
  LoongArch: KVM: Add separate vmid feature support
  LoongArch: KVM: implement vmid updating logic
  LoongArch: KVM: Add remote tlb flushing support
  LoongArch: KVM: Enable separate vmid feature

 arch/loongarch/include/asm/kvm_host.h  | 10 ++++
 arch/loongarch/include/asm/loongarch.h |  2 +
 arch/loongarch/kernel/asm-offsets.c    |  1 +
 arch/loongarch/kernel/cpu-probe.c      |  7 ++-
 arch/loongarch/kvm/main.c              | 76 ++++++++++++++++++++++++--
 arch/loongarch/kvm/mmu.c               | 16 ++++++
 arch/loongarch/kvm/switch.S            |  5 +-
 arch/loongarch/kvm/tlb.c               | 19 ++++++-
 arch/loongarch/kvm/vcpu.c              |  7 ++-
 9 files changed, 133 insertions(+), 10 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.39.3

