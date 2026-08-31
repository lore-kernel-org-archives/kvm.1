Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E43C73CC;
	Mon, 31 Aug 2026 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170086; cv=none; b=OkUPITqjurgMa3Myaz05MAL0so1hITHNNGKk6tl3Rr5Hs4eyE3CH2okwzr3MHkYfz2INJAnQiApe4ExdKHBSqy1NWDkHbV+BSUgy9cUADLWs3SPWayZemLu6tx5G0tYWblYm80ZcT7FP35MFMRIK000iL/n1Ys7YBvxbRajj0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170086; c=relaxed/simple;
	bh=afxTLShJ7HbvlaiQDC+SJ5sRlK4jyr+zi2Xy9YGfat4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/tk2x2oVZsk1OqMpU7G48n8VnCqIWckhzO8bKK6zIj9yGZJP1mmPFiPgm6aknSgEHOliCX0xF0jfnCURA1+3iBSJExffHTQTgB/NvSZjCzgrcAtLkmrxEpdv0UhoIJoeuXKBt2W+Ekbxmnqeoyqf28Sy1kg5eu1v3OUggq17u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Ax29FgT5VqvN0GAA--.19306S3;
	Mon, 31 Aug 2026 17:54:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxKs5eT5VqDTYYAA--.20453S2;
	Mon, 31 Aug 2026 17:54:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3]  LoongArch: KVM: Add separate vmid support
Date: Mon, 31 Aug 2026 17:47:13 +0800
Message-Id: <20260831094716.4016652-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKs5eT5VqDTYYAA--.20453S2
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
v2 ... v3:
  1. Merge patch 1-2 into one and patch 3-4 into one.
  2. Return directly and do not update vmid in function __kvm_check_vmid()
     if feature cpu_has_guestid is disabled by AI agent review.
  3. In function kvm_arch_disable_virtualization_cpu disable feature
     CSR_GTLBC_USES2TGID, similiar with enable cpu virtualization,
     the same from AI agent review.
  4. Rename USEVMID with USES2TGID, VMID is KVM software word and S2TGID
     is hardware word.
  5. Set cpu bit with vcpu->kvm->arch.tlb_flush_pending with
     KVM_REQ_TLB_FLUSH, similiar with request KVM_REQ_TLB_FLUSH_GPA.

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
Bibo Mao (3):
  LoongArch: KVM: Add vmid support for stage2 MMU
  LoongArch: KVM: Implement vmid updating logic
  LoongArch: KVM: Enable separate vmid feature

 arch/loongarch/include/asm/kvm_host.h  | 10 ++++
 arch/loongarch/include/asm/loongarch.h |  5 ++
 arch/loongarch/kernel/asm-offsets.c    |  1 +
 arch/loongarch/kernel/cpu-probe.c      |  6 +++
 arch/loongarch/kvm/main.c              | 71 ++++++++++++++++++++++++--
 arch/loongarch/kvm/mmu.c               | 30 +++++++++--
 arch/loongarch/kvm/switch.S            |  5 +-
 arch/loongarch/kvm/tlb.c               | 19 ++++++-
 8 files changed, 135 insertions(+), 12 deletions(-)


base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
-- 
2.39.3

