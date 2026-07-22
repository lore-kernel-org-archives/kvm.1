Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175EA476058
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706256; cv=none; b=saPCXmmHFr68GOYJ2G1L0imASR9qSIyQe4fTiAap/qMZkMcRWC3cz9i1VA86P4kHdb5vSsMJEWEFr8xKQOrV+ISoIhsU1vM4tM6T2XWIgjCZYJiF6X29OpUnOvc+ou4sOZKda7AkEdHgxKNYjXV+OEWT0APeAmRl3LUD0EgC60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706256; c=relaxed/simple;
	bh=FPrvqleZZkxly92bR/CLY5uc81tEF64gprLeaxY5lPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UbvNeE35FGneZeG2ghf3BG4d09U9ukBwWRrZlPx7MKQUP7n/qhvvpOSaHJsxTk4Z2HaldwyddtWcSmnYmH4ZO1EjDA9FsBCqmVNVpKgkQGo3fVfep81JwqSLKTarLmF+pJD2VQTXul5lqLRJOBUraLisa+/1gX7lRlI2qlX9nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sb+Rxirg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sb+Rxirg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784706249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sG2NOsOTZ2REpCl2D4kAYmK3b1M/9AA8FLqbpmvwIek=;
	b=sb+RxirgFN/teVJcTc5OMKD1ZKz8l6zXaic1PhVwBC8hgdoZiOUeenHQf+nWhBI9ezgTBL
	2U88JqJ/d9h7WRqVu/liHNVF6w2C8qCB1GxXT68rjgjg3Pe+XMJgeSt2FcNisdaADL93ij
	56y8QY2deor8dlGB0aft/o1rrfnum0Y=
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
Subject: [PATCH v2] LoongArch: KVM: Add KVM_LOONGARCH_GET/SET_CSR for bulk CSR migration
Date: Wed, 22 Jul 2026 15:43:46 +0800
Message-ID: <20260722074346.239507-1-cui.tao@linux.dev>
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
break no userspace.

On a Loongson 3A6000, snapshotting one vCPU's core CSR range (0x0-0x183)
drops from 388 KVM_GET_ONE_REG calls (~2 ms) to a single
KVM_LOONGARCH_GET_CSR ioctl (~6 us).

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/uapi/asm/kvm.h | 13 +++++
 arch/loongarch/kvm/vcpu.c             | 73 +++++++++++++++++++++++++++
 include/uapi/linux/kvm.h              |  4 ++
 3 files changed, 90 insertions(+)

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
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..9b411c694718 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1009,6 +1009,73 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs
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
+		if (get_gcsr_flag(id) & INVALID_GCSR) {
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
@@ -1266,6 +1333,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..aade65751721 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1670,4 +1670,8 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+/* LoongArch: bulk CSR get/set for migration */
+#define KVM_LOONGARCH_GET_CSR	_IOWR(KVMIO, 0xd6, struct kvm_loongarch_csrs)
+#define KVM_LOONGARCH_SET_CSR	_IOW(KVMIO,  0xd7, struct kvm_loongarch_csrs)
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0

