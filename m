Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321A34753F
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154146; cv=none; b=TmNUFx0tDD1E/Ybu6YQdiM/dyzV4SnCHB5VmvdFVYGNUIpj9QL0FCT2PQ9Yg5dXRcuA2Il1Jkpj69FnZGr7KhXwQo9D6oJMM2AxhRoKAQ5LjlfDVCR8uA8mXkUyVoBB+y4aRmXProe3a8sHRpPeOtb+zjSxtvG2fVkb3zEzWIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154146; c=relaxed/simple;
	bh=ZHjCn1pY331+hIUP4SUOz5v4zvcSMll9BdLgLIc/XoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g5mIOeq0JuIMstskEL88QFEdA4dgqLSYKka+sUN2InZxp6xU9+YUyyRDEeivcczZCGUo7u6duFuaCPoBOklRdNuZGp+8LRdRo3sp/Yu1dIPVSNWJ2W5hpjPCG6skK5SYN4G++zR436S5GapKWVw4Ys8r/eUQ2usV3q8LwkGvWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UE5sW5fM; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UE5sW5fM"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c0793772071so543248866b.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154143; x=1782758943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YDKxILlnDw+5iaEcF38F4xHpKQ3yBx+LqMsoNxfSVAA=;
        b=UE5sW5fMm3z+r0ekPkzK4YdZkOcp/FRPTrURjELNbxMKCWz8YHgxEBnr134duv4RRw
         GFON0gcLpDun6cftwhYejubYNkfhzS5x2HN2Y15Qqt8dRZCTnImsmQc5plwx9T8wi1h0
         gMPeqFsuADkegNDG+QyZmbD7K54VjEJtp8Bw/b+Gx2lJi7x/tKbKD1c0mWxonyfqd6ZW
         zzXFI0u8Tq2522jWiRIGMx+cEpuQYKrGc5v02UHQWaYFpHd7MsRpx0iOzvmP9JFeQyQx
         rWhz6tt9QIS/N5+Hanu/gh4BRTUQ8ZvM9IBDPsmUTydwER5CyuM6pGKbzhu062ARuRpe
         dGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154143; x=1782758943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDKxILlnDw+5iaEcF38F4xHpKQ3yBx+LqMsoNxfSVAA=;
        b=pnPBhhrdtwBuhuu4BkBbmYkg9pnR5BCbFOjQlv3ZSEOOOqj29aT5lccSm2I1IdCPIH
         9I2NNVXIJmu8D/2iqZilfimX1Lk8BsG8+REfkg6mgUkaWaMNUNi+CPUJi6Gwd1+/MkGE
         vhaWMtYW1fXgg9JgzQj0NeVpwMCX14iYSdlid8a6JmAxSPv84xv+HC7SvPb4ScWUZDVP
         2tJi01OKp+DjAouzrSWAcw8BgXPgPyEG4EdtSlxPMnXyHj3qaZYZwtztqVeW8sCiKWj0
         ZnTyq3mKJndeWOod1vddYykmcc0/7Y15pyDN544e8QdAHemzzMlNjYk4/BDZAnYvvKYY
         rNgQ==
X-Gm-Message-State: AOJu0Yy5xQAze1LxHkhyFMwasPe0qvAjN6KuZuwp9MGodlR0UJsEKvyz
	/zzSpuh+qgbYp1WE/Me0YOhk/jpMqpDaPRST+qckUwjxUoFXUNktQTG4i4j3UEMjTr2vwlUAAwQ
	6VDZoXhld/OPoydiBew==
X-Received: from ejbbw14.prod.google.com ([2002:a17:906:c1ce:b0:c04:8986:1578])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:3583:b0:c10:1030:fffb with SMTP id a640c23a62f3a-c1010310402mr69033166b.12.1782154142415;
 Mon, 22 Jun 2026 11:49:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:44 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-3-tarunsahu@google.com>
Subject: [PATCH v3 2/9] kvm: Prepare core VM structs and helpers for LUO support
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index ab8cfae..cbb5eb9 100644
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
index e44c20c..14c3254 100644
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
@@ -5477,11 +5487,47 @@ bool file_is_kvm(struct file *file)
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
@@ -5490,31 +5536,17 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 
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
@@ -6342,6 +6374,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
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
index 7510ca9..6241617 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -6,6 +6,9 @@
 #include <linux/kvm.h>
 #include <linux/kvm_types.h>
 
+/* Worst case buffer size needed for holding an integer as a string. */
+#define ITOA_MAX_LEN 12
+
 /*
  * Architectures can choose whether to use an rwlock or spinlock
  * for the mmu_lock.  These macros, for use in common code
-- 
2.55.0.rc0.786.g65d90a0328-goog

