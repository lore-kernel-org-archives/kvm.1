Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC0435ABE
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240711; cv=none; b=I8swGrp7BAEgSO4EI2J7UxNe1mvJ/p/A930xW0r5jd1GYdSSYl3tAaoiVihl/7gvGHAl32w7KbUs+qOERiu2LRFnQb7F+WooXG0oYGCfMFJpf3mfnyLv0j6xvBkeUAT8+NJUw/tJKpd3kJB4XdF9QlWCv5aZPbM+IdjFG7lZyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240711; c=relaxed/simple;
	bh=WzbdxxejJD4UzE/jBcUzEPTbdvCqTHGg5mzMwpZ6Yz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bXRpsyZi+Ma0hZs7S+Vgvul65RoJXSs4z2YtNsM8Yqvt1iw9Haq5f3rNZJvfIsSEY2nbhiX4uX/gT0XbSYirvfPEPL8eWvUMy862wSRnV3/TdHclQfmuLmt5VR8oqgwdi8D4umkHpSMmQEtvqmd+EjcnKVbcNwwtko3brrcsElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1PPmMp2; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1PPmMp2"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-69fc66f110eso877376a12.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240707; x=1785845507; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hQr+6fiwmjAuN9/wTMWLnl7iWSgvc3fwt3jZTZM3qPg=;
        b=h1PPmMp2/5KTx2v1hDB3c45i/oxHJvIOX6QaDCMBTrw+j3kYDjIkkfk8l8ETttD5O2
         ySzCtLVHcCu95reFjW3BuJPbfQgc6VUJl8DtqreAmFKkmO2nEeRokb9jL6UfKAnbZh53
         GmVx3mJdP93wQyAGSQR3cH/8WOuUwok6b+kDO3ZgFYX0oIVeBox8EQKNE/abS+y7c23I
         HFzHyzd+ah9OhNIYACHpCMh5XiWuGavWlkbQ8QSeQczIU1Kadyg8oHK2Ima5nD554QSg
         BB5+RIiGN0v09EEaJnJiCpkiM06aG2rfXHLmhVbwcoSJ4ZDhnQ2CWIUWcbY/KssGVESy
         O5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240707; x=1785845507;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hQr+6fiwmjAuN9/wTMWLnl7iWSgvc3fwt3jZTZM3qPg=;
        b=gplB4+HTLRw4Ky/sfYv/FVwKlM9eEEai21xDgBPuH3mEnMq+3C7lFSjL6sENOL6UuI
         xLROG7E5bXm0PWALUlTqnHcsQ7kHBf9smrnkTspkxF4iaUf6j68jBZRIKrt95WBqcebl
         41b2jUpVVK6VdPw0oqwhSp0TRhNvyzf1rko9PMqQFL7jUSYJqwoLND7VxEloxwwvbU5S
         D6RJzLPrIZsGzY6mHi8ZtQvYTukRYCG2Cu0Hcyz4yoUgzWQQU1BUTSURrMlYHNo8honM
         kBR+r2VSx9mYJU5laqsaQr+ZRwR0osnkXfSekQP3/EwkJindgOyj65LUwL9CmyK5iLnJ
         1Tig==
X-Forwarded-Encrypted: i=1; AHgh+RoqFgzJzDYwAORTNvYKabr+uOtCR1TVvPtfk9zWfRiGjDAjcoOuqKKp2HT4UJaA+uAhKdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wByhgXwsIemaO3DcHs3oAjECvciBFzCmxbq997EpaM63ydx8
	tmM5GkN5pgc6fxbprQZ6oG85cfcVzaNU6lLhcqldOK+jYcXIpvEhc+lYqA5njms2bOr5dckTUs2
	BYo59bcDxUDV66MPO5A==
X-Received: from edgc8.prod.google.com ([2002:a05:6402:a608:b0:697:e97f:2f91])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3604:b0:69f:c929:b88 with SMTP id 4fb4d7f45d1cf-6a0349ec474mr1201988a12.5.1785240706549;
 Tue, 28 Jul 2026 05:11:46 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:32 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-6-tarunsahu@google.com>
Subject: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live updates
From: Tarun Sahu <tarunsahu@google.com>
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Register a Live Update Orchestrator (LUO) file handler for KVM VM files
to serialize and deserialize VM state across kexec live updates.

Currently, Only VM type (e.g. arch.vm_type on x86) is preserved as part
of VM preservation. On retrieval, kvm_luo_retrieve() recreates the KVM VM file
via kvm_create_vm_file() and use an atomically incremented ID for the internal
fdname, as the final fdname assigned by userspace is not yet known during
retrieval. As this fdname is only used in debugfs infra, This will not
break any UAPI.

This infrastructure establishes the foundation for preserving guest_memfd
instances across live updates, and can be expanded in the future to
preserve additional VM state.

Also updates MAINTAINERS to include virt/kvm/kvm_luo.c and
include/linux/kho/abi/kvm.h.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 MAINTAINERS                 |  11 ++
 include/linux/kho/abi/kvm.h |  39 ++++++++
 virt/kvm/Makefile.kvm       |   1 +
 virt/kvm/kvm_luo.c          | 195 ++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c         |   8 ++
 virt/kvm/kvm_mm.h           |   8 ++
 6 files changed, 262 insertions(+)
 create mode 100644 include/linux/kho/abi/kvm.h
 create mode 100644 virt/kvm/kvm_luo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a3ed337e827d..0283f0fd6ef4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14539,6 +14539,17 @@ S:	Maintained
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
index 000000000000..718db68a541a
--- /dev/null
+++ b/include/linux/kho/abi/kvm.h
@@ -0,0 +1,39 @@
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
+ * struct kvm_luo_ser - Main serialization structure for a KVM VM.
+ * @type:         The type of VM.
+ */
+struct kvm_luo_ser {
+	u64 type;
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
index 000000000000..025b53151b6a
--- /dev/null
+++ b/virt/kvm/kvm_luo.c
@@ -0,0 +1,195 @@
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
+static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
+{
+	struct kvm *kvm = args->file->private_data;
+	struct kvm_luo_ser *ser;
+
+	if (kvm->vm_dead || kvm->vm_bugged)
+		return -EINVAL;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+#if defined(CONFIG_X86)
+	ser->type = kvm->arch.vm_type;
+#elif defined(CONFIG_ARM64)
+	ser->type = kvm_phys_shift(&kvm->arch.mmu);
+	if (kvm_vm_is_protected(kvm))
+		ser->type |= KVM_VM_TYPE_ARM_PROTECTED;
+
+#else
+	ser->type = 0;
+#endif
+
+	args->serialized_data = virt_to_phys(ser);
+	return 0;
+}
+
+static atomic_t restored_vm_id = ATOMIC_INIT(0);
+
+static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
+{
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
+	args->file = file;
+	kho_restore_free(ser);
+
+	kvm_uevent_notify_vm_create(kvm);
+	return 0;
+
+err_free_ser:
+	kho_restore_free(ser);
+	return err;
+}
+
+static void kvm_luo_unpreserve(struct liveupdate_file_op_args *args)
+{
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
+	kho_unpreserve_free(ser);
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
+
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
+int kvm_luo_init(void)
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
+
+void kvm_luo_exit(void)
+{
+	liveupdate_unregister_file_handler(&kvm_luo_handler);
+}
+
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 14c32541ae34..d9c3dd1afb05 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6577,6 +6577,10 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (r)
 		goto err_virt;
 
+	r = kvm_luo_init();
+	if (r)
+		goto err_luo;
+
 	/*
 	 * Registration _must_ be the very last thing done, as this exposes
 	 * /dev/kvm to userspace, i.e. all infrastructure must be setup!
@@ -6590,6 +6594,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	return 0;
 
 err_register:
+	kvm_luo_exit();
+err_luo:
 	kvm_uninit_virtualization();
 err_virt:
 	kvm_gmem_exit();
@@ -6619,6 +6625,8 @@ void kvm_exit(void)
 	 */
 	misc_deregister(&kvm_dev);
 
+	kvm_luo_exit();
+
 	kvm_uninit_virtualization();
 
 	debugfs_remove_recursive(kvm_debugfs_dir);
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 624161793fec..87198715fb01 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -100,4 +100,12 @@ static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 }
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
+#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
+int kvm_luo_init(void);
+void kvm_luo_exit(void);
+#else
+static inline int kvm_luo_init(void) { return 0; }
+static inline void kvm_luo_exit(void) {}
+#endif /* CONFIG_LIVEUPDATE_GUEST_MEMFD */
+
 #endif /* __KVM_MM_H__ */
-- 
2.55.0.229.g6434b31f56-goog

