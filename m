Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94683546DF
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730504; cv=none; b=XzaK98A1Xre2dP1fyrAj//d6RYmjp8wZg9famnRzfEEmKDCepDvVgcAj91Zd5Odp7DGERRUA7mNEc0S32FieNL3fy9K2JbEnhJG+Xvr4EtR5m6PtFRxz/Hw1OoEsWmlwnSfE4V6jDgDY9q9yJRQISfYY54kGuh5U5FUdvSzSrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730504; c=relaxed/simple;
	bh=ixMwHZ47HGXENRxXri6xY/LEinEZSkTYaah0z6PePds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhO1/+QXJSK9qJz5vNbJqR+IWRSuFhogA92akmtnWe6JkU0JqGhXZSpTOksYKTnyP7RoXhVhj1vFUDFSUUX9xzdr/UGSo1rQ3AC3GgQsaa7YDpfvILG8csC7G8O95zg8XMs5A7EUUvE45qiuNrD/VCSx/NvxbQKVqQ/9547eyYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZKqehc8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZKqehc8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784730499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P8Ix8reVveZHfHEhLYG0PtOZEEt7xDip8rzqk215UCI=;
	b=tZKqehc8ZHeJjhVcmYIcju3EV5MnhUqSy0ih9G+gtBUast/ZCkvfQ4F0387BKDiA4MItKy
	d2LxPdPCt26JSVW0F0FkZjts4pJAd4L88U4ZpEyl5HLiGyPWcGfJkPrQnihuJW7DW4Dz60
	JXGv2oyrkh09DoogmBtbYzP+EenCLFE=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn
Cc: chenhuacai@kernel.org,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH v3] LoongArch: KVM: Add KVM_LOONGARCH_GET/SET_CSR for bulk CSR migration
Date: Wed, 22 Jul 2026 22:28:05 +0800
Message-ID: <20260722142805.278325-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Migrating a vCPU's CSR state takes one KVM_GET/SET_ONE_REG ioctl per
register, thousands of syscalls for a large VM.

Add a bulk pair, KVM_LOONGARCH_GET_CSR / KVM_SET_CSR.  Userspace passes
an array of {index, data} entries; the kernel fills entries[].data on
GET and applies them on SET, both in a single call:

- KVM_LOONGARCH_GET_CSR does a single vcpu_load/put with
  kvm_deliver_intr(), which pulls pending interrupts into ESTAT,
  avoiding the per-register load/put side-effect that made ONE_REG
  snapshots of ESTAT order-sensitive.
- KVM_LOONGARCH_SET_CSR writes all CSRs via _kvm_setcsr in one pass,
  propagates _kvm_setcsr errors, and clears KVM_LARCH_HWCSR_USABLE up
  front so a mid-loop failure still forces the next vcpu_load() to
  reload from SW, matching KVM_SET_ONE_REG.

Entries are {index, data} rather than a positional array, so future CSRs
can be added without resizing the struct or changing the ioctl number.
CSRs above the core range (debug, breakpoint, PMU) stay on
KVM_GET/SET_ONE_REG; struct kvm_sregs is left empty, so the new ioctls
break no userspace, and userspace probes them via KVM_CAP_LOONGARCH_CSR.

The ioctl hands get_gcsr_flag() a user-controlled index, so switch that
helper (and the set_gcsr_sw_flag/set_gcsr_hw_flag init helpers) to an
unsigned index; the csr < CSR_MAX_NUMS bound check is then robust against
a sign-extended value regardless of the caller.

On a Loongson 3A6000, snapshotting one vCPU's core CSR range (0x0-0x183)
drops from 388 KVM_GET_ONE_REG calls (~2 ms) to a single
KVM_LOONGARCH_GET_CSR ioctl (~6 us).

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---

Changes since v2:
  - Bound-check the CSR index (< CSR_MAX_NUMS) and make
    get_gcsr_flag()/set_gcsr_*_flag() take an unsigned index.  An index
    with bit 31 set was implicitly converted to a negative signed int,
    bypassing the csr < CSR_MAX_NUMS check and causing an out-of-bounds
    read/write into the SW CSR shadow.
  - Reject non-zero pad/reserved fields with -EINVAL so they stay reserved.
  - Add KVM_CAP_LOONGARCH_CSR for userspace feature detection.

 arch/loongarch/include/asm/kvm_host.h |  2 +-
 arch/loongarch/include/uapi/asm/kvm.h | 13 +++++
 arch/loongarch/kvm/main.c             |  6 +--
 arch/loongarch/kvm/vcpu.c             | 77 +++++++++++++++++++++++++++
 arch/loongarch/kvm/vm.c               |  1 +
 include/uapi/linux/kvm.h              |  5 ++
 6 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..aacf5d84217f 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -362,7 +362,7 @@ extern struct kvm_world_switch *kvm_loongarch_ops;
 #define HW_GCSR		(1 << 1)
 #define INVALID_GCSR	(1 << 2)
 
-int get_gcsr_flag(int csr);
+int get_gcsr_flag(unsigned int csr);
 void set_hw_gcsr(int csr_id, unsigned long val);
 
 #endif /* __ASM_LOONGARCH_KVM_HOST_H__ */
diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
index cd0b5c11ca9c..59b3b7efa039 100644
--- a/arch/loongarch/include/uapi/asm/kvm.h
+++ b/arch/loongarch/include/uapi/asm/kvm.h
@@ -127,6 +127,19 @@ struct kvm_sync_regs {
 struct kvm_sregs {
 };
 
+/* bulk CSR entries for VM migration */
+struct kvm_loongarch_csr_entry {
+	__u32 index;
+	__u32 reserved;
+	__u64 data;
+};
+
+struct kvm_loongarch_csrs {
+	__u32 ncsrs;	/* number of csr entries */
+	__u32 pad;
+	__DECLARE_FLEX_ARRAY(struct kvm_loongarch_csr_entry, entries);
+};
+
 struct kvm_iocsr_entry {
 	__u32 addr;
 	__u32 pad;
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 3e1005526f4b..d802d393cd44 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -19,7 +19,7 @@ struct kvm_world_switch *kvm_loongarch_ops;
 static int gcsr_flag[CSR_MAX_NUMS];
 static struct kvm_context __percpu *vmcs;
 
-int get_gcsr_flag(int csr)
+int get_gcsr_flag(unsigned int csr)
 {
 	if (csr < CSR_MAX_NUMS)
 		return gcsr_flag[csr];
@@ -27,13 +27,13 @@ int get_gcsr_flag(int csr)
 	return INVALID_GCSR;
 }
 
-static inline void set_gcsr_sw_flag(int csr)
+static inline void set_gcsr_sw_flag(unsigned int csr)
 {
 	if (csr < CSR_MAX_NUMS)
 		gcsr_flag[csr] |= SW_GCSR;
 }
 
-static inline void set_gcsr_hw_flag(int csr)
+static inline void set_gcsr_hw_flag(unsigned int csr)
 {
 	if (csr < CSR_MAX_NUMS)
 		gcsr_flag[csr] |= HW_GCSR;
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..2bb6a7e0ea87 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1009,6 +1009,77 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs
 	return -ENOIOCTLCMD;
 }
 
+/* max CSR entries handled per ioctl */
+#define KVM_LOONGARCH_MAX_CSR_REGS	0x400
+
+/* Bulk get/set of CSR state for VM migration. */
+static int kvm_loongarch_csr_io(struct kvm_vcpu *vcpu,
+				struct kvm_loongarch_csrs __user *ucsrs,
+				bool write)
+{
+	int i, ret = 0;
+	unsigned long size;
+	struct kvm_loongarch_csrs csrs;
+	struct kvm_loongarch_csr_entry *entries;
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	if (copy_from_user(&csrs, ucsrs, sizeof(csrs)))
+		return -EFAULT;
+
+	if (csrs.pad)
+		return -EINVAL;
+
+	if (csrs.ncsrs > KVM_LOONGARCH_MAX_CSR_REGS)
+		return -E2BIG;
+
+	size = array_size(csrs.ncsrs, sizeof(*entries));
+	entries = memdup_user(ucsrs->entries, size);
+	if (IS_ERR(entries))
+		return PTR_ERR(entries);
+
+	if (write) {
+		vcpu->arch.aux_inuse &= ~KVM_LARCH_HWCSR_USABLE;
+	} else {
+		preempt_disable();
+		vcpu_load(vcpu);
+		kvm_deliver_intr(vcpu);
+		vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
+		vcpu_put(vcpu);
+		preempt_enable();
+	}
+
+	for (i = 0; i < csrs.ncsrs; i++) {
+		unsigned int id = entries[i].index;
+
+		if (entries[i].reserved || id >= CSR_MAX_NUMS ||
+		    (get_gcsr_flag(id) & INVALID_GCSR)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (write) {
+			ret = _kvm_setcsr(vcpu, id, entries[i].data);
+			if (ret)
+				break;
+		} else if (id == LOONGARCH_CSR_ESTAT) {
+			unsigned long estat, gintc;
+
+			/* ESTAT IP0~IP7 come from GINTC */
+			gintc = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) & KVM_GINTC_IRQ_MASK;
+			estat = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) & ~KVM_ESTAT_EXTI_MASK;
+			entries[i].data = estat | (gintc << VIP_DELTA);
+		} else {
+			entries[i].data = kvm_read_sw_gcsr(csr, id);
+		}
+	}
+
+	if (!write && copy_to_user(ucsrs->entries, entries, size))
+		ret = -EFAULT;
+
+	kfree(entries);
+	return ret;
+}
+
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
@@ -1266,6 +1337,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			r = kvm_get_reg(vcpu, &reg);
 		break;
 	}
+	case KVM_LOONGARCH_GET_CSR:
+		r = kvm_loongarch_csr_io(vcpu, argp, false);
+		break;
+	case KVM_LOONGARCH_SET_CSR:
+		r = kvm_loongarch_csr_io(vcpu, argp, true);
+		break;
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
 
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..785f2fa0d164 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_SET_GUEST_DEBUG:
+	case KVM_CAP_LOONGARCH_CSR:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..45d9eb06cb8a 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -997,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_LOONGARCH_CSR	250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1670,4 +1671,8 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+/* LoongArch: bulk CSR get/set for migration */
+#define KVM_LOONGARCH_GET_CSR	_IOWR(KVMIO, 0xd6, struct kvm_loongarch_csrs)
+#define KVM_LOONGARCH_SET_CSR	_IOW(KVMIO,  0xd7, struct kvm_loongarch_csrs)
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0

