Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AB3E834D
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097010; cv=none; b=I99NcLaDUPANpsTu1d4sPvzUHCpeNzEzKt+Iax5tm64d1q3uAOPKOeY6vryFpypJp1BO5cH1d/JROpUGV1adQ08/anSGu9RStZazRN5ClIzXmzfl6zZq2fr6rCI0jrAGx4HroOyX+fExCGu9ld0CPYp6DIuAEOMJj49ziVtUWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097010; c=relaxed/simple;
	bh=9QmMIEFTjxCYy9aGb8fw2FvVntyLSsRH/CgUauEVkjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xk6nGxFlX11Jan6n7XNgYK0DZr8pLUGjzaeoLAaemnUstLN/iIbQBwWKpqLoAoCSzE8HPKlDzGPb/zosK+8vw8bs7rJkrTzWZlUASyx+2gHCZ7qsVty/6pH5CFjUZhdCt7HpnIspuOWIF7BStAj1p+ATEpEMYhszilPHWQIHxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Di9L+kOc; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Di9L+kOc"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-676fb54c0cdso1623679a12.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097006; x=1779701806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOz8gAJuYfKjn0utZUC84bAY67+CiHezioPS6ecopLg=;
        b=Di9L+kOcUroxtM/rnsDrN4p16DtEOktBu9jUf+GT9g54BeYlS9yrpqCPsZ2OgmoE3Z
         bAERvc/VkyRoolx11vgOhT5Bn3yqawJ6RkeFq5sBTrWFRZlXZW1Kok0AWiNa+iScklx7
         vgYHyGoVa4k0ixq/aBGd+YeSq7sy68LjUsK+BML44EJ/rVk8lrZ04z2/pnMZu/yZ97cz
         J4lMILd33tif7mZXTrXzmCszO2LGWFtCAdR5gJ5v9Gag7bak6lzjeLg3xjTCmpR9yuwm
         /9TT5KJIAeeRq9T60ZCZbd/jSqV7gGE0iuDxp+5cCezslAHC2vdRxxz09Un8v+4Py+yH
         JZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097006; x=1779701806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOz8gAJuYfKjn0utZUC84bAY67+CiHezioPS6ecopLg=;
        b=Vv2VrDq5rlSpw1JKIDrltcQYa4jEHljN0nclBsq4dNvs3bqGo+HtZq9kBEqQ5/mA+P
         qLKP+JYH2biDsmAtaNlpUerGIBk1wVnO8s8HcQMaO2GuIm1Srhgt1cBnwD7gcbGWVbdk
         /76c3xNUEh4H/LpiHeqZPw59+mqC0yiqD3C6kY0au8DZd/7bNUHoTIqKjwZKTId3xuVA
         4MhjhOmjfdzGN3sMUpEV6T/fgQLuCcWWx3AL6BM349Nlg5OdgXCY4fJM/nLhTrxjEy+X
         8ajaw9lA9TQhgpdFKo5hDo1WrsOYicThtI/xvzmUwOnlxOdfS2SWixLetUVhw7e33R4S
         FZeg==
X-Forwarded-Encrypted: i=1; AFNElJ/R9nZrvqoh9uRgoa7+8g38eM9OrUY6poJoxi5+pAOefO6OVRbS5TjohV0M5FUquo4tpcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAaAejnX2U2r+l6sRhAKyy05pNIU8tutfmj6QQgrR/ks1I1m1u
	lizkCDOWck+3NTHrGBYhySqAUU280riPIactt69cGXVsc0eBw8eBWKppXZEmzJbJBVtQnF7VxRF
	XingvSJbP6oNg7Tvl7g==
X-Received: from edtc13.prod.google.com ([2002:aa7:c98d:0:b0:67b:7d11:72ff])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:46d6:b0:678:ce1e:a5cb with SMTP id 4fb4d7f45d1cf-683bd193662mr6858854a12.21.1779097005896;
 Mon, 18 May 2026 02:36:45 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:34 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <b489ff0ab6edef9723778bd0018e209fe410e05d.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 4/9] kvm: kvm_luo: Allow kvm preservation with LUO
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce KVM VM preservation support for Live Update Orchestrator.

Register an LUO file handler for KVM files to serialize and
deserialize necessary VM state across live updates. Currently, this
preserves the VM type and generic memory attributes. This
implementation provides the necessary infrastructure and dependencies
for the upcoming guest_memfd preservation support. And it can be
extended to preserve more vm state in future.

To preserve the kvm file it is necessary that the attributes that we
are preserving must not change while or after preservation. The memory
attribute change request is triggered by Guest to KVM and exit to VMM.
VMM is aware that liveupdate is in progress and is expected to cancel
this request Or pause the VM. This ensures that no change in memory
attributes from guest are introduced while/after preservation of kvm.

Retrieve is simply creating the kvm and populate the retrieved data.
Only catch here is there is no way to know which fd is going to be
assigned to this kvm file hence I am using atomically incremented id
for the fdname.

This change also updates the MAINTAINERS list for kvm_luo.c.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>

---
My only worry is if userspace strictly depends on the fdname, that it
needs to be consistent with vm_fd. Discussed more details in the
cover letter. Would really appreciates the alternatives/other approaches.
---
 MAINTAINERS                 |  11 ++
 include/linux/kho/abi/kvm.h |  54 ++++++
 virt/kvm/Makefile.kvm       |   1 +
 virt/kvm/kvm_luo.c          | 346 ++++++++++++++++++++++++++++++++++++
 4 files changed, 412 insertions(+)
 create mode 100644 include/linux/kho/abi/kvm.h
 create mode 100644 virt/kvm/kvm_luo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d79275c6..2c26eb17bc0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14404,6 +14404,17 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
 F:	drivers/video/backlight/ktz8866.c
 
+KVM LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Mike Rapoport <rppt@kernel.org>
+M:	Pratyush Yadav <pratyush@kernel.org>
+R:	Tarun Sahu <tarunsahu@google.com>
+L:	kexec@lists.infradead.org
+L:	kvm@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	virt/kvm/kvm_luo.c
+
 KVM PARAVIRT (KVM/paravirt)
 M:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Vitaly Kuznetsov <vkuznets@redhat.com>
diff --git a/include/linux/kho/abi/kvm.h b/include/linux/kho/abi/kvm.h
new file mode 100644
index 000000000000..31bd39588bdd
--- /dev/null
+++ b/include/linux/kho/abi/kvm.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Tarun Sahu <tarunsahu@google.com>
+ *
+ * KVM Preservation ABI for Live Update Orchestrator (LUO)
+ */
+#ifndef _LINUX_KHO_ABI_KVM_H
+#define _LINUX_KHO_ABI_KVM_H
+
+#include <linux/types.h>
+#include <linux/kho/abi/kexec_handover.h>
+
+/**
+ * DOC: KVM Live Update ABI
+ *
+ * KVM uses the ABI defined below for preserving its state
+ * across a kexec reboot using the LUO.
+ *
+ * The state is serialized into a packed structure `struct kvm_luo_ser`
+ * which is handed over to the next kernel via the KHO mechanism.
+ *
+ * This interface is a contract. Any modification to the structure layout
+ * constitutes a breaking change. Such changes require incrementing the
+ * version number in the KVM_LUO_FH_COMPATIBLE compatibility string.
+ */
+
+/**
+ * struct kvm_luo_mem_attr - GFN memory attribute serialization.
+ * @gfn:        Guest Frame Number.
+ * @attributes: Memory attributes associated with this GFN.
+ */
+struct kvm_luo_mem_attr {
+	u64 gfn;
+	u64 attributes;
+} __packed;
+
+/**
+ * struct kvm_luo_ser - Main serialization structure for a KVM VM.
+ * @type:         The type of VM.
+ * @nr_mem_attrs: The number of memory attributes in the array.
+ * @mem_attrs:    KHO vmalloc descriptor pointing to the array of
+ *                struct kvm_luo_mem_attr.
+ */
+struct kvm_luo_ser {
+	u64 type;
+	u64 nr_mem_attrs;
+	struct kho_vmalloc mem_attrs;
+} __packed;
+
+/* The compatibility string for KVM VM file handler */
+#define KVM_LUO_FH_COMPATIBLE	"kvm_vm_luo_v1"
+
+#endif /* _LINUX_KHO_ABI_KVM_H */
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index d047d4cf58c9..c1a962159264 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -13,3 +13,4 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
 kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
+kvm-$(CONFIG_LIVEUPDATE_GUEST_MEMFD) += $(KVM)/kvm_luo.o
diff --git a/virt/kvm/kvm_luo.c b/virt/kvm/kvm_luo.c
new file mode 100644
index 000000000000..1cf3941c16b7
--- /dev/null
+++ b/virt/kvm/kvm_luo.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Tarun Sahu <tarunsahu@google.com>
+ *
+ * KVM VM Preservation for Live Update Orchestrator (LUO)
+ */
+
+/**
+ * DOC: KVM VM Preservation via LUO
+ *
+ * Overview
+ * ========
+ *
+ * KVM virtual machines (VMs) can be preserved over a kexec reboot using the
+ * Live Update Orchestrator (LUO) file preservation. This allows userspace
+ * to preserve KVM VM state across kexec reboots.
+ *
+ * The preservation is not intended to be fully transparent. Only specific
+ * VM configuration and state are preserved, while other aspects of the VM
+ * must be re-established or re-configured by userspace after retrieval.
+ *
+ * Preserved Properties
+ * ====================
+ *
+ * The following properties of the KVM VM are preserved across kexec:
+ *
+ * VM Type
+ *   The VM type (e.g., on x86 architecture, the vm_type parameter) is
+ *   preserved.
+ *
+ * Memory Attributes
+ *   All entries in the memory attributes array are preserved.
+ *
+ * Non-Preserved Properties
+ * ========================
+ *
+ * The preservation does not cover:
+ *
+ * - vCPUs and vCPU states
+ * - Memspots / Memory slot layout (memslots)
+ * - Interrupt controllers and IRQ routings
+ * - Coalesced MMIO zones
+ * - Device bindings (VFIO/Eventfds)
+ * - Active paging or guest registers state
+ * - etc
+ */
+#include <linux/liveupdate.h>
+#include <linux/kvm_host.h>
+#include <linux/pagemap.h>
+#include <linux/file.h>
+#include <linux/err.h>
+#include <linux/anon_inodes.h>
+#include <linux/magic.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/kvm.h>
+#include "kvm_mm.h"
+
+static bool kvm_luo_can_preserve(struct liveupdate_file_handler *handler,
+				 struct file *file)
+{
+	return file_is_kvm(file);
+}
+
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static int kvm_luo_preserve_mem_attrs(struct kvm *kvm, struct kvm_luo_ser *ser,
+				struct kvm_luo_mem_attr **mem_attrs_ptr)
+{
+	struct kvm_luo_mem_attr *mem_attrs = NULL;
+	unsigned long index;
+	void *attributes;
+	u64 count = 0;
+	int err;
+
+	mutex_lock(&kvm->slots_lock);
+
+	xa_for_each(&kvm->mem_attr_array, index, attributes) {
+		count++;
+	}
+
+	if (count == 0) {
+		mutex_unlock(&kvm->slots_lock);
+		ser->nr_mem_attrs = 0;
+		*mem_attrs_ptr = NULL;
+		return 0;
+	}
+
+	mem_attrs = vcalloc(count, sizeof(*mem_attrs));
+	if (!mem_attrs) {
+		mutex_unlock(&kvm->slots_lock);
+		return -ENOMEM;
+	}
+
+	count = 0;
+	xa_for_each(&kvm->mem_attr_array, index, attributes) {
+		mem_attrs[count].gfn = index;
+		mem_attrs[count].attributes = xa_to_value(attributes);
+		count++;
+	}
+
+	mutex_unlock(&kvm->slots_lock);
+
+	ser->nr_mem_attrs = count;
+	err = kho_preserve_vmalloc(mem_attrs, &ser->mem_attrs);
+	if (err) {
+		vfree(mem_attrs);
+		return err;
+	}
+
+	*mem_attrs_ptr = mem_attrs;
+	return 0;
+}
+
+static int kvm_luo_retrieve_mem_attrs(struct kvm *kvm, struct kvm_luo_ser *ser,
+				bool *mem_attrs_restored_ptr)
+{
+	struct kvm_luo_mem_attr *mem_attrs;
+	u64 i;
+	int err = 0;
+
+	if (!ser->nr_mem_attrs)
+		return 0;
+
+	mem_attrs = kho_restore_vmalloc(&ser->mem_attrs);
+	*mem_attrs_restored_ptr = true;
+	if (!mem_attrs)
+		return -EINVAL;
+
+	for (i = 0; i < ser->nr_mem_attrs; i++) {
+		err = xa_err(xa_store(&kvm->mem_attr_array, mem_attrs[i].gfn,
+				      xa_mk_value(mem_attrs[i].attributes),
+				      GFP_KERNEL_ACCOUNT));
+		if (err)
+			break;
+	}
+	vfree(mem_attrs);
+	return err;
+}
+
+static void kvm_luo_retrieve_mem_attrs_cleanup(struct kvm_luo_ser *ser,
+					bool mem_attrs_restored)
+{
+	struct kvm_luo_mem_attr *mem_attrs = NULL;
+
+	if (ser->nr_mem_attrs && !mem_attrs_restored)
+		mem_attrs = kho_restore_vmalloc(&ser->mem_attrs);
+	vfree(mem_attrs);
+}
+
+static void kvm_luo_unpreserve_mem_attrs(struct kvm_luo_ser *ser)
+{
+	if (ser && ser->nr_mem_attrs)
+		kho_unpreserve_vmalloc(&ser->mem_attrs);
+}
+
+static void kvm_luo_finish_mem_attrs(struct kvm_luo_ser *ser)
+{
+	struct kvm_luo_mem_attr *mem_attrs;
+
+	if (ser && ser->nr_mem_attrs) {
+		mem_attrs = kho_restore_vmalloc(&ser->mem_attrs);
+		if (mem_attrs)
+			vfree(mem_attrs);
+	}
+}
+#else
+static inline int kvm_luo_preserve_mem_attrs(struct kvm *kvm,
+					struct kvm_luo_ser *ser,
+					struct kvm_luo_mem_attr **mem_attrs_ptr)
+{
+	ser->nr_mem_attrs = 0;
+	*mem_attrs_ptr = NULL;
+	return 0;
+}
+
+static inline int kvm_luo_retrieve_mem_attrs(struct kvm *kvm,
+					struct kvm_luo_ser *ser,
+					bool *mem_attrs_restored_ptr)
+{
+	if (ser->nr_mem_attrs)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static inline void kvm_luo_retrieve_mem_attrs_cleanup(struct kvm_luo_ser *ser,
+						bool mem_attrs_restored)
+{
+}
+
+static inline void kvm_luo_unpreserve_mem_attrs(struct kvm_luo_ser *ser)
+{
+}
+
+static inline void kvm_luo_finish_mem_attrs(struct kvm_luo_ser *ser)
+{
+}
+#endif
+
+static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
+{
+	struct kvm *kvm = args->file->private_data;
+	struct kvm_luo_mem_attr *mem_attrs = NULL;
+	struct kvm_luo_ser *ser;
+	int err = 0;
+
+	if (kvm->vm_dead || kvm->vm_bugged)
+		return -EINVAL;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	err = kvm_luo_preserve_mem_attrs(kvm, ser, &mem_attrs);
+	if (err)
+		goto err_free_ser;
+
+#ifdef CONFIG_X86
+	ser->type = kvm->arch.vm_type;
+#else
+	ser->type = 0;
+#endif
+
+	args->serialized_data = virt_to_phys(ser);
+	args->private_data = mem_attrs;
+
+	return 0;
+
+err_free_ser:
+	kho_unpreserve_free(ser);
+	return err;
+}
+
+static atomic_t restored_vm_id = ATOMIC_INIT(0);
+
+static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
+{
+	struct kvm_luo_mem_attr *mem_attrs = NULL;
+	bool mem_attrs_restored = false;
+	char fdname[ITOA_MAX_LEN + 1];
+	struct kvm_luo_ser *ser;
+	struct file *file;
+	struct kvm *kvm;
+	int err = 0;
+
+	if (!args->serialized_data)
+		return -EINVAL;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	snprintf(fdname, sizeof(fdname), "%d",
+		 atomic_inc_return(&restored_vm_id));
+
+	file = kvm_create_vm_file(ser->type, fdname);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_free_ser;
+	}
+
+	kvm = file->private_data;
+
+	err = kvm_luo_retrieve_mem_attrs(kvm, ser, &mem_attrs_restored);
+	if (err)
+		goto err_destroy_file;
+
+	args->file = file;
+	kho_restore_free(ser);
+
+	kvm_uevent_notify_vm_create(kvm);
+	return 0;
+
+err_destroy_file:
+	fput(file);
+err_free_ser:
+	kvm_luo_retrieve_mem_attrs_cleanup(ser, mem_attrs_restored);
+	kho_restore_free(ser);
+	return err;
+}
+
+static void kvm_luo_unpreserve(struct liveupdate_file_op_args *args)
+{
+	struct kvm_luo_mem_attr *mem_attrs = args->private_data;
+	struct kvm_luo_ser *ser;
+
+	/*
+	 * in case preservation failed, args->serialized_data will
+	 * be NULL and kvm_luo_preserve takes care of cleaning up.
+	 * If preserve succeeds, this condition fails and unpreserve
+	 * function takes care of cleaning up.
+	 */
+	if (WARN_ON_ONCE(!args->serialized_data))
+		return;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	kvm_luo_unpreserve_mem_attrs(ser);
+	kho_unpreserve_free(ser);
+	vfree(mem_attrs);
+}
+
+static void kvm_luo_finish(struct liveupdate_file_op_args *args)
+{
+	struct kvm_luo_ser *ser;
+
+	/*
+	 * If retrieve_status is true or set to error, nothing to do here.
+	 * Already cleaned up in kvm_luo_retrieve().
+	 */
+	if (args->retrieve_status)
+		return;
+
+	if (!args->serialized_data)
+		return;
+
+	ser = phys_to_virt(args->serialized_data);
+	kvm_luo_finish_mem_attrs(ser);
+	kho_restore_free(ser);
+}
+
+static const struct liveupdate_file_ops kvm_luo_file_ops = {
+	.can_preserve = kvm_luo_can_preserve,
+	.preserve = kvm_luo_preserve,
+	.retrieve = kvm_luo_retrieve,
+	.unpreserve = kvm_luo_unpreserve,
+	.finish = kvm_luo_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler kvm_luo_handler = {
+	.ops = &kvm_luo_file_ops,
+	.compatible = KVM_LUO_FH_COMPATIBLE,
+};
+
+static int __init kvm_luo_init(void)
+{
+	int err = liveupdate_register_file_handler(&kvm_luo_handler);
+
+	if (err && err != -EOPNOTSUPP) {
+		pr_err("Could not register kvm_vm_luo handler: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	return 0;
+}
+late_initcall(kvm_luo_init);
-- 
2.54.0.563.g4f69b47b94-goog

