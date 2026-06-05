Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5238C437
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679328; cv=none; b=A8kRcleJL5SJY7TlZh6QitTDScODjEAXnKtjfsg4v0DQKUhzWNPkfvvPr8rU7B6xDTDWrkm3/xAICfPklG+5V5eqsBxefYu+IOWTYsJWhlRa+F1UV3j0vx7btBmnm/gfr4Oyuh9jq5NO+qDbgbHooc1GC+vdWbtA0OrlVKDTdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679328; c=relaxed/simple;
	bh=ZDkZisz/SCM7cfoig9oCpVLGaToIDe+n31ttxDTGTRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jekHKSaVKieF1GJu+5AwSJttiwMXzT6obLToUb8uV3eo7xJ1nScXsNww6yarjktQV3wmddlj8AklO2X7Rk4TGSrO54JiuAjmyKMDHufQ3u/xEWYL0UNgAI3Zh9THDZVuX/6M4ZQBooeiSSVPS3pyKx95UnjdKEXJRHvRkgtUNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0UJ4kLZ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0UJ4kLZ"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68cef9a44f4so2392658a12.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679325; x=1781284125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3ys0qD9usDIPXN1Rh1z7yLfiAE5vSm04coRPqmRTQw=;
        b=L0UJ4kLZK+zb2WNvFNr1OYsfofc6Q00OqpOxnedpL6dVfe1BLgrI6QzayejEDXXKga
         bm2/GYnNgZKTvimDaLGTxWk77jx3R1deqxeyqf+c+hQS4LwJCtKlJabHa3L41RhBWmRM
         FPCOnwV024C3QdCoNQwcol3D3Wj9gvifkcn8TUfiK5f8qSBZ/q6NQmyqJcilu4iRfplb
         n0dtxrwppjKNW/ckiXMxE/zzmI+mRnhUvcZ0qy7omeDM9kxXwU5fdFlz5SVTtuNZUW7J
         U/+JJt2mZKmicyw0EEK0ZlFXGP2Ze9UUqRmPOma0wxxhmKK6ZJpUeFrvOFZGCGuRCnrb
         SxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679325; x=1781284125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3ys0qD9usDIPXN1Rh1z7yLfiAE5vSm04coRPqmRTQw=;
        b=NlSVOS8ArpbR5ycCS7JbHgrluR+Z7xitv5J+dP1rZ1xFdv/XUJMjpJ1/nljSD68OI2
         ICsm0P6bHODxVGk2zJ5SksWY+8T+eVeG4ezUVWq8r8cEfbOQ/dPIZF1bzjkQ3TCW1gFt
         Goa4vZuKxOyQ+UbKo1nvj8c4DVKDIEG4YkhElVbuvsgQhKQiaACqhBDMoiXx9zCG25rN
         FjYh7kdTthvg8AJFpELvjZfx0a7Lqy4xOfWClA3+RTVbkoiQM4FxC9qLfconjbM2hC0x
         warV7eHZ5n8bx/27NcfLZC+iKkiaqgGPPYj3JTxjdZ8bVUvbQ+F5kbYVEtp47oEwn90N
         vBWg==
X-Forwarded-Encrypted: i=1; AFNElJ/0+/a0Syjd6Jld4RNjyoRPCDemh1iWod12MtahDA6maUprGyHX7/Brqnn0uQIAeEsa3jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHAzZytmjtyBf2SZUm3PeyLTp+3i3e/V7cv8ruOK9PG7ttbpW
	XjpJKm0b4vnIx4LBmSzVGd7erDe+LkWk8rSzgMSglZi+q5X7y1Aj58OK4hDwO+OPiJl1/Ys8OKl
	DxC7fxlE3Q4ZohXUoQQ==
X-Received: from edsj20.prod.google.com ([2002:a50:ed14:0:b0:689:61c8:cf62])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3492:b0:68d:7c10:a46e with SMTP id 4fb4d7f45d1cf-68fa5047543mr2499655a12.14.1780679325050;
 Fri, 05 Jun 2026 10:08:45 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:28 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 03/10] kvm: Prepare core VM structs and helpers for LUO support
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
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
2.54.0.1032.g2f8565e1d1-goog

