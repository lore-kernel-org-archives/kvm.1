Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C033E833C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097009; cv=none; b=FW4xI7IAwn17zujBBDy7rD9xCmVcMEZZEkkCoAjHaa5LCor37qL7QIcKfeAvaZsep68CMyknsIgNfy+Rje57ZKoU3iEY9QFCRsX98m5wP6qBhRwbm/cbjyN6Sne1lb/W6RXWBcsxY1Tub1YNMqLfFSt3uyT+ls0/TzQkpSKgHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097009; c=relaxed/simple;
	bh=V8f3kDEJqJZh7MK3ij24Zg4qD5ZSK/hWmoGv8D34y/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aY/jrL1/Dpr8wi23wyKbTETOC4bz9WEWOBtBupB27oafapBAsqc/ea1y760U5gXzoYswYXTE6eGXz/Sc8dm9pHFeQUg564p7I55SLB1fzupbiJRy7I9ZQRzUxdn/xaSopLt5ao9cCBtPVriI5ZGJ+DzFNwt73ijZodLGEgbthNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5ZjyEsQ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5ZjyEsQ"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bd548eb1008so187757066b.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097005; x=1779701805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu2thktJGs003PTp9eiJKgCeu3f066a/QrblnMWAnz8=;
        b=n5ZjyEsQRRnUm8aBaTesVGsuzMtGQKFzf5msV3pCOkL4QaYZJ4qZpQFQa/tB0r+yZr
         IMJkjxvmy2r5n7SQ9U6qtVahUKHjzkL2mE8RGW0cy5GTVUpGlhb4NMwhkqQEzb1P4axq
         o8alTK1hJwdQ0wF5mDa60D3kRP6Icpf8kN1gGHvAz7aK+q7NCcSuqTgLpvjt0cuOK47H
         zykUih7BYSd4cGyghJ/SApMW5+sgb825m+4MGAb6O6eB+yP9DT/yF0icFasAPlYwF3MH
         58/TQtTuk5O/RoT8gvqvfP5WycTXBu4DmuB5Skjn1KyqLlHBLAk3rkxU54TbPTcl9oVr
         OsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097005; x=1779701805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu2thktJGs003PTp9eiJKgCeu3f066a/QrblnMWAnz8=;
        b=ohPO1AZBuD2jFAY0wOA/4t0dhte9fqhHrIAxtXo++D5FkINtX2mdN5Gh5r3ZJDh3Pj
         sutYt1TqGP+qX2vusB5X24cUZhnIUkuRJ3+T+JKsRyYNSX/Nr2XcdDFTIeYqN2PnJgn6
         KQSxB9aMdpjKah2xvJf/XX+7imxs6XaApOysd+emNmg5wBdkJnG1M7jJSsqQyqIUPuPx
         1zmTQw5XGNdhb8XI+y3scGwbUiCdpRVH7sgnhJQfmGet90Dfw+g/5Xtv6LmaaZ3PzNoa
         ULRyLQbl937d2njhQzbsR6d4wFHTGKUDnJDBlxaJF/t2rTODFc2VwP3EnX8RLlVeN8YE
         qszw==
X-Forwarded-Encrypted: i=1; AFNElJ+oFhS2MfHGqi5OJxg1BCWLOGHUIFkHZysn8+ygZNc6w/JaEQLk2nOMb4u1bqjl30hVgPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDUFTbsVSdtqCRBCF6JCWaz3G/oIoVhik91HEXOOyYrd3gHA4
	n40BMo+coMKev0m4OxJncz1oy0biqqmzZyxddcFZr44Qy7CV4pKE1pOqLtYIjZ++XeO1sOKuWR3
	r5P4wR7wCXLnqMeHdeQ==
X-Received: from edbck27.prod.google.com ([2002:a05:6402:1c1b:b0:672:bd1d:a465])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:8e0e:b0:bae:d29c:4e28 with SMTP id a640c23a62f3a-bd51785f36amr758368766b.12.1779097005099;
 Mon, 18 May 2026 02:36:45 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:33 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <24e13c0679157302f0d8385c341169b0ddd4ea40.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 3/9] kvm: Prepare core VM structs and helpers for LUO support
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

Introduce core infrastructure to support VM preservation with LUO.

First two changes are just refactoring, no functional change, third
change introduces a new member in struct kvm.
- Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
- Add a public kvm_create_vm_file() helper wrapping kvm_create_vm()
  and anon_inode_getfile() to provide a unified VM file creation API.
- Track a weak reference to the backing file in struct kvm under
  CONFIG_LIVEUPDATE_GUEST_MEMFD to enable reverse file resolution
  without circular lifetime dependencies.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kvm_host.h | 14 +++++++
 virt/kvm/kvm_main.c      | 79 +++++++++++++++++++++++++++++-----------
 virt/kvm/kvm_mm.h        |  3 ++
 3 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb06..9111a28637af 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -874,6 +874,18 @@ struct kvm {
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	/* Protected by slots_lock (for writes) and RCU (for reads) */
 	struct xarray mem_attr_array;
+#endif
+#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
+	/*
+	 * Weak reference to the VFS file backing this KVM instance. Stored
+	 * without incrementing the file refcount to prevent a circular lifetime
+	 * dependency (since file->private_data already pins this struct kvm).
+	 * Used exclusively to resolve the file pointer back from struct kvm.
+	 *
+	 * Written/cleared via rcu_assign_pointer() and read locklessly under
+	 * RCU (e.g. via get_file_active() to prevent ABA races).
+	 */
+	struct file *vm_file;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
@@ -1074,7 +1086,9 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
+void kvm_uevent_notify_vm_create(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 89489996fbc1..65f0c5fb353e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -67,9 +67,6 @@
 #include <linux/kvm_dirty_ring.h>
 
 
-/* Worst case buffer size needed for holding an integer. */
-#define ITOA_MAX_LEN 12
-
 MODULE_AUTHOR("Qumranet");
 MODULE_DESCRIPTION("Kernel-based Virtual Machine (KVM) Hypervisor");
 MODULE_LICENSE("GPL");
@@ -1349,6 +1346,19 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 {
 	struct kvm *kvm = filp->private_data;
 
+#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
+	/*
+	 * Clear the weak reference of the vm file.
+	 * In case vm file is closed by userspace, but kvm still has
+	 * other users like vCPUs, clearing this pointer ensures
+	 * that we don't have a dangling pointer to a closed file.
+	 *
+	 * Cleared via rcu_assign_pointer() to ensure proper memory visibility
+	 * for concurrent lockless readers under RCU.
+	 */
+	rcu_assign_pointer(kvm->vm_file, NULL);
+#endif
+
 	kvm_irqfd_release(kvm);
 
 	kvm_put_kvm(kvm);
@@ -5476,11 +5486,47 @@ bool file_is_kvm(struct file *file)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 
+struct file *kvm_create_vm_file(unsigned long type, const char *fdname)
+{
+	struct kvm *kvm = kvm_create_vm(type, fdname);
+	struct file *file;
+
+	if (IS_ERR(kvm))
+		return ERR_CAST(kvm);
+
+	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
+	if (IS_ERR(file)) {
+		kvm_put_kvm(kvm);
+		return file;
+	}
+
+#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
+	/*
+	 * Weak reference to the file (without get_file()) to prevent a circular
+	 * dependency. Safe because the file's release path clears this pointer
+	 * and drops its reference to the VM.
+	 *
+	 * Written via rcu_assign_pointer() because the pointer can be read
+	 * locklessly under RCU (e.g., in kvm_gmem_luo_preserve() via
+	 * get_file_active() to prevent lockless ABA races).
+	 */
+	rcu_assign_pointer(kvm->vm_file, file);
+#endif
+
+	/*
+	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
+	 * already set, with ->release() being kvm_vm_release().  In error
+	 * cases it will be called by the final fput(file) and will take
+	 * care of doing kvm_put_kvm(kvm).
+	 */
+
+	return file;
+}
+
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];
 	int r, fd;
-	struct kvm *kvm;
 	struct file *file;
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
@@ -5489,31 +5535,17 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 
 	snprintf(fdname, sizeof(fdname), "%d", fd);
 
-	kvm = kvm_create_vm(type, fdname);
-	if (IS_ERR(kvm)) {
-		r = PTR_ERR(kvm);
-		goto put_fd;
-	}
-
-	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
+	file = kvm_create_vm_file(type, fdname);
 	if (IS_ERR(file)) {
 		r = PTR_ERR(file);
-		goto put_kvm;
+		goto put_fd;
 	}
 
-	/*
-	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
-	 * already set, with ->release() being kvm_vm_release().  In error
-	 * cases it will be called by the final fput(file) and will take
-	 * care of doing kvm_put_kvm(kvm).
-	 */
-	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
+	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, file->private_data);
 
 	fd_install(fd, file);
 	return fd;
 
-put_kvm:
-	kvm_put_kvm(kvm);
 put_fd:
 	put_unused_fd(fd);
 	return r;
@@ -6341,6 +6373,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	kfree(env);
 }
 
+void kvm_uevent_notify_vm_create(struct kvm *kvm)
+{
+	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
+}
+
 static void kvm_init_debug(void)
 {
 	const struct file_operations *fops;
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..7aa1d65c3d46 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -3,6 +3,9 @@
 #ifndef __KVM_MM_H__
 #define __KVM_MM_H__ 1
 
+/* Worst case buffer size needed for holding an integer as a string. */
+#define ITOA_MAX_LEN 12
+
 /*
  * Architectures can choose whether to use an rwlock or spinlock
  * for the mmu_lock.  These macros, for use in common code
-- 
2.54.0.563.g4f69b47b94-goog

