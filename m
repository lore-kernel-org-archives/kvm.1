Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B26347FEE
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154154; cv=none; b=LL1rb4G1ZDYGzZSjIrA4OvN1rkUGk7msOYrv9bKtTvyzA4TR51X5MDRh0+7h9FJPu6H5ljoruX1BPEKAlwFgQi2FaJREIYAuYv6VEK8KynJTD14mSVZLQUkZexT1vGf8nurxZ8nizCjoVT1yg54VKVlGgK3IFkd9PFDGi80zrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154154; c=relaxed/simple;
	bh=4fd32wwOqp1b2rzLONIyTMattuNYJq7jZ/FwvBa61es=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eeO4SngES1TQX3Pwy5pRlJgvVSVESAL/zdV2pKYfgJ5YGLduAYv1qK5xcefPiRWUMTJDZOkVupKwuhOdbuVRPJOZ89kIhSInwCzQ9iUg41gUlpmmSrypIXleUHbnlEq2EmHQLUynUQikl0JRug5sF/wjmFSlGZ9An3HqrYIdcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALpeShOB; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALpeShOB"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c0cb08b20b2so236127666b.3
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154147; x=1782758947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUJD/qDxfrMv3GVCezTN8Ddb/ezsPEksCOi1qF1OubI=;
        b=ALpeShOBkkhEaJ2y9v9T7hVROo/EoxbQGsGU/zXzbg3ykOHcHKKt5wGDPEqxsyYoMy
         U+B5ziR/0v3nIMHrKMI+y8nsMzvTJBb7EmheeFYOPM8lOCcEn8N8EpGGzuUbKaMHfkPU
         i5PWPcIkLUmCctsBylYfS+yLSOD4B+lc/UZh0Hqnic8rYCKDwSMv6EJwWiUCkoFhyCg4
         06McQKJkUeJ/FHQJR+w86MQjHu6sBeEJH23hTIA+s3pk/w4VVx1Mo1r7PAr7q+A9rMml
         MbCy3tkEAFLGvDiCK7IWknE0nT2qiYTiXo+hLhNXXlx4p7rm1sFiNvBBKJM8U1k6/Txs
         Gx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154147; x=1782758947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUJD/qDxfrMv3GVCezTN8Ddb/ezsPEksCOi1qF1OubI=;
        b=E8DqqdPG/G+rwY+ebic4Bd1XiFsGJsiqE7qiJKtU2iBi2MJAxTnRsGT4liv21lVYxm
         ri8BpbSxrEOuRA7U5ZH/agP8g64OI1q77ybEo3ApdZDrDiTOAnrkaIMlWU4DEj0w4aVk
         VLT6LKmxkQ3IOwaiTVZjY9hMALiE07Zqmq/B/RVxbV/Mrr6mWd6SoPB1WuNxSkOjtxNS
         ff5vd72kEDxNm46extJA2yHZASCb0Picz9sQQ3UjnAtlR0LHPKdmS9HjiGtQfQdXHJo3
         9mpKGanisWuDAVwl7rdplfdOWdFhd16QH1LSSLkOq5K+joytqwiyw5nB4kRbGrQwTF0K
         DdzQ==
X-Gm-Message-State: AOJu0Yya1z+79bYQrn+ajyuOUXcbyLLhe2ABmpF27tPqsHiq3WSgXZIo
	fGR4O10FWtrNtIzM3DpXyS7r9fMxzTnee6xwyPslQakokQmwiSMDgtQQ0eD6jS0pPY2Hdbb3TUI
	/+1INnWcdC6SSLH6LOA==
X-Received: from ejet16.prod.google.com ([2002:a17:906:1790:b0:c08:3cd3:d05f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7951:b0:bf1:1df7:3e50 with SMTP id a640c23a62f3a-c0c63dba03amr559821466b.3.1782154146145;
 Mon, 22 Jun 2026 11:49:06 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:47 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-6-tarunsahu@google.com>
Subject: [PATCH v3 5/9] kvm: guest_memfd: Add support for freezing and
 unfreezing mappings
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch introduces the freeze on gmem_inode which prevents
the fallocate call and any new page fault allocation. This will avoid
gmem file modification when it is being preserved

Used srcu lock to synchronise the freeze call, where write blocks
until all the reads are free. And reads are re-entrant.

Incase fault fails, It return -EPERM and VM_EXIT to userspace. userspace
must handle this properly as every new fault will fail.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 virt/kvm/guest_memfd.c | 117 +++++++++++++++++++++++++++++++++++++----
 virt/kvm/guest_memfd.h |   5 ++
 2 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fe1adc9b..a4d9d34 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -7,11 +7,13 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/srcu.h>
 #include "guest_memfd.h"
 
 #include "kvm_mm.h"
 
 static struct vfsmount *kvm_gmem_mnt;
+static struct srcu_struct kvm_gmem_freeze_srcu;
 
 
 #define kvm_gmem_for_each_file(f, inode) \
@@ -96,6 +98,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	/* TODO: Support huge pages. */
 	struct mempolicy *policy;
 	struct folio *folio;
+	int idx;
 
 	/*
 	 * Fast-path: See if folio is already present in mapping to avoid
@@ -105,12 +108,20 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	if (!IS_ERR(folio))
 		return folio;
 
+	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
+	if (kvm_gmem_is_frozen(inode)) {
+		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
+		return ERR_PTR(-EPERM);
+	}
+
 	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
 	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
 					 FGP_LOCK | FGP_CREAT,
 					 mapping_gfp_mask(inode->i_mapping), policy);
 	mpol_cond_put(policy);
 
+	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
+
 	/*
 	 * External interfaces like kvm_gmem_get_pfn() support dealing
 	 * with hugepages to a degree, but internally, guest_memfd currently
@@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 			       loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	int ret;
+	int idx;
 
-	if (!(mode & FALLOC_FL_KEEP_SIZE))
-		return -EOPNOTSUPP;
+	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
+	if (kvm_gmem_is_frozen(inode)) {
+		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
+		return -EPERM;
+	}
 
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
-		return -EOPNOTSUPP;
+	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
-	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
-		return -EINVAL;
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
@@ -291,6 +316,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!ret)
 		file_modified(file);
+
+out:
+	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
 	return ret;
 }
 
@@ -948,7 +976,9 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 
 static void kvm_gmem_free_inode(struct inode *inode)
 {
-	kmem_cache_free(kvm_gmem_inode_cachep, GMEM_I(inode));
+	struct gmem_inode *gi = GMEM_I(inode);
+
+	kmem_cache_free(kvm_gmem_inode_cachep, gi);
 }
 
 static const struct super_operations kvm_gmem_super_operations = {
@@ -1005,12 +1035,21 @@ int kvm_gmem_init(struct module *module)
 	if (!kvm_gmem_inode_cachep)
 		return -ENOMEM;
 
+	ret = init_srcu_struct(&kvm_gmem_freeze_srcu);
+	if (ret)
+		goto err_cache;
+
 	ret = kvm_gmem_init_mount();
-	if (ret) {
-		kmem_cache_destroy(kvm_gmem_inode_cachep);
-		return ret;
-	}
+	if (ret)
+		goto err_srcu;
+
 	return 0;
+
+err_srcu:
+	cleanup_srcu_struct(&kvm_gmem_freeze_srcu);
+err_cache:
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
+	return ret;
 }
 
 void kvm_gmem_exit(void)
@@ -1018,5 +1057,61 @@ void kvm_gmem_exit(void)
 	kern_unmount(kvm_gmem_mnt);
 	kvm_gmem_mnt = NULL;
 	rcu_barrier();
+	cleanup_srcu_struct(&kvm_gmem_freeze_srcu);
 	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
+
+/**
+ * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
+ * @inode: The guest_memfd inode.
+ * @freeze: True to freeze, false to unfreeze.
+ *
+ * This API is used strictly during the live update / preservation transition
+ * window to prevent host userspace and guest-side faults from making any
+ * mapping modifications (such as fallocate or page fault allocation)
+ * to the guest_memfd page cache.
+ *
+ * Synchronization Strategy (Sleepable RCU):
+ * To avoid high-contention VFS locks (like inode_lock or
+ * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
+ * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
+ * (`kvm_gmem_freeze_srcu`):
+ *
+ * Global vs. Per-Inode SRCU
+ * ======================
+ * A single system-wide global static `srcu_struct` is used instead of a
+ * per-inode SRCU structure to completely prevent unprivileged users from
+ * exhausting the host's per-CPU memory allocator. Because
+ * `init_srcu_struct()` allocates per-CPU memory via `alloc_percpu()`, which
+ * is not accounted by memory cgroups (memcg),
+ * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
+ * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
+ * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
+ *
+ * Flag Modification Note:
+ * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in
+ * `GMEM_I(inode)->flags` that is mutated dynamically at runtime (all other
+ * flags are creation-time flags which remain strictly read-only), there is
+ * no possibility of concurrent bit-modification races. Therefore, a standard
+ * `WRITE_ONCE` is fully safe and does not require complex `cmpxchg`
+ * synchronization loops.
+ */
+void kvm_gmem_freeze(struct inode *inode, bool freeze)
+{
+	u64 flags = READ_ONCE(GMEM_I(inode)->flags);
+
+	if (freeze)
+		flags |= GUEST_MEMFD_F_MAPPING_FROZEN;
+	else
+		flags &= ~GUEST_MEMFD_F_MAPPING_FROZEN;
+
+	WRITE_ONCE(GMEM_I(inode)->flags, flags);
+
+	if (freeze)
+		synchronize_srcu(&kvm_gmem_freeze_srcu);
+}
+
+bool kvm_gmem_is_frozen(struct inode *inode)
+{
+	return READ_ONCE(GMEM_I(inode)->flags) & GUEST_MEMFD_F_MAPPING_FROZEN;
+}
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
index c528b04..028c348 100644
--- a/virt/kvm/guest_memfd.h
+++ b/virt/kvm/guest_memfd.h
@@ -29,11 +29,16 @@ struct gmem_inode {
 	u64 flags;
 };
 
+/* Internal kernel-only flags (must not overlap with UAPI flags) */
+#define GUEST_MEMFD_F_MAPPING_FROZEN	(1ULL << 63)
+
 static inline struct gmem_inode *GMEM_I(struct inode *inode)
 {
 	return container_of(inode, struct gmem_inode, vfs_inode);
 }
 
 struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags);
+void kvm_gmem_freeze(struct inode *inode, bool freeze);
+bool kvm_gmem_is_frozen(struct inode *inode);
 
 #endif /* __KVM_GUEST_MEMFD_H__ */
-- 
2.55.0.rc0.786.g65d90a0328-goog

