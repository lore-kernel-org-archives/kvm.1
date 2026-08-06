Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C63D3B5846;
	Thu,  6 Aug 2026 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982499; cv=none; b=AJe6GZ+WJVwoXfQ48sDrpzYs/kolPrOH3r+cgPaLWjzshDtxYdHGalREL4cE0ieqoEVAJLw0hO5uS/s5qcLMjaZ785MqnJmBNxgiVsjYzgBTwsAUSsa1AA6H6GfG6oCJIpe2qRsJkdC69dXVnPWBMHlsMsnAUoiW+5q8j0iv9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982499; c=relaxed/simple;
	bh=2y6DKdnpk46DwcJ/wOTrAwxMUmzapUufbLW6cc2v8VU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XymghRPda+GN+KTcHMvLpN21lf04JP4DY5LaNO5NKKxkZK4W1NrxQ8Rc+G0N2TCCL9sXdCBZgyJRSLgyyM8VXe4/+Lr1wS+gLN1TrhIsFSAx/nX7QgMGZOABXRF4+nFIHeprv7Qa4Agl9AtoreC5tPF1DM90EoBoWtNHjNyZTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxg+gf7nNqHtsKAA--.12003S3;
	Thu, 06 Aug 2026 10:14:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx3wce7nNqB1QlAA--.7102S2;
	Thu, 06 Aug 2026 10:14:54 +0800 (CST)
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
Subject: [PATCH v2 0/5] LoongArch: KVM: Add separate vmid support
Date: Thu,  6 Aug 2026 10:07:34 +0800
Message-Id: <20260806020739.2149268-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx3wce7nNqB1QlAA--.7102S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

LoongArch KVM hypervisor supports two-level MMU, vpid index is used
for stage1 MMU and vmid index is used for stage2 MMU.

On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
may separate from vpid. There are such advantages if separated vmid
is supported.
  1. One VM uses one vmid, vCPUs on the same VM can share the same vmid.
  2. If one vCPU switch between different physical CPUs, old vmid can be
     still useful if it is not expired.
  3. For remote tlb flush, it is to flush TLBs which are mapping
     GPA --> HPA, only vmid need update and vpid need not.

Here add separate vmid feature support, vmid feature detecting method
comes from CPUCFG8 capability when LVZ is enabled.
---
v1 ... v2:
  1. Move vmid together with vpid in patch1, rename it with hw_vmid.
  2. Rename kvm_check_vcpuid() with __kvm_check_vpid(), and function
     kvm_check_vmid() with __kvm_check_vmid().
  3. Merge part of patch 2, patch 3/4 together.
  4. Use bit8 of CPUCFG8 as guestid capability rather than LVZ version,
     since it is hard to decide whether this feature exists with high LVZ
     version in future.
  5. Set cpu bit with vcpu->kvm->arch.tlb_flush_pending rather than
     using add request KVM_REQ_TLB_FLUSH_GPA, it needs flush TLB on CPU
     where page fault happens and vCPU maybe migrates to other CPUs.
---
Bibo Mao (5):
  LoongArch: KVM: Add vmid support for stage2 MMU
  LoongArch: KVM: Add separate vCPU and VM id update function
  LoongArch: KVM: Add separate vmid feature support
  LoongArch: KVM: Implement vmid updating logic
  LoongArch: KVM: Enable separate vmid feature

 arch/loongarch/include/asm/kvm_host.h  | 10 ++++
 arch/loongarch/include/asm/loongarch.h |  5 ++
 arch/loongarch/kernel/asm-offsets.c    |  1 +
 arch/loongarch/kernel/cpu-probe.c      |  6 +++
 arch/loongarch/kvm/main.c              | 70 ++++++++++++++++++++++++--
 arch/loongarch/kvm/mmu.c               | 23 ++++++++-
 arch/loongarch/kvm/switch.S            |  5 +-
 arch/loongarch/kvm/tlb.c               | 19 ++++++-
 arch/loongarch/kvm/vcpu.c              |  3 +-
 9 files changed, 131 insertions(+), 11 deletions(-)


base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.39.3

