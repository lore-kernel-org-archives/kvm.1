Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E33E95B2
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097012; cv=none; b=PqwpRM2dW5UZVUDOofY2wRGDDL0JaXki1zmlqRZVXC326MIJ7Ojp6OX8YkUlPNOY4f1MKdeHZbFpoz9JVDuQR/9FeAQJwJyBPP268ytPCL4x7BIoWpaYyZFpW50bkuCUclUUxzb9ldxdDEy2fEnjvcdJaQ2ow1OihckutZmhyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097012; c=relaxed/simple;
	bh=ic5RMPuUuwa4YJTZl2LkoEhRdzsDY9wDUPw1tfyW2LU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1oWNhFj3eD7Sjjgbuw9MYXYjW00Z7SkIhks0fYRSP/K4+BVoamp4iSly/oI9AJhe3ZAnYqw5slIN0IYjrHUu4cwH3n1mwK9BDtLPzeO2uvX6yphCoFcBslCwxSu9Zr54Mhkl5HCsdD5cjrhJckEhX4Be3sBdA5hdqANYjTRVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3TnTnsE; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3TnTnsE"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bcc22a042b1so265149666b.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097009; x=1779701809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yB4XsnS5O2tJ5kB+OIL7J7kvYCLgSP2Q9yHfNFYen64=;
        b=u3TnTnsEXMB+wdEo4Y2oM+P3/Z72AGIMGfUSY+AJbBs4eg3Ue7SQW8DDpBGkVcHXSu
         NU8oj5fZr2eJeryc+540xWiUAMygGQKY/Enzhycu8YFpqx1g+36N5Rr0a02PQD8D0Qrr
         y1hs3JigQO+02nKk3/Ei753Jp2Jf/O95Ita/V1TxcvIEsUMyRuB+5iz96nTMMIDXfspr
         PT6z9wyFxEOHtW3X9KL4WMzSRcLLEPh/7JEhpbaVFh/A778HfGoVh+TxHDdPT8gPyPka
         g377iCrMj9tip/8NZ17JXhLGgJdgxBtLIqmul+trc++pbxHjpy9A1FDD1Ou7ENxO3vGB
         60Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097009; x=1779701809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB4XsnS5O2tJ5kB+OIL7J7kvYCLgSP2Q9yHfNFYen64=;
        b=WYG+0hzG913QPWXByF2SAG0OPqmxP3wntfu46RSZ8yjGbMBBVa8EOFbiOXxRy8mGob
         oCSmfwfv6uiDKrNO7pJRlGI7sRE5yfrxT7MGf121Fo0u0bKDyD2bl4jq2DtSb8bepOjY
         +6pXoZk4Qe9zElL+2OX2ATqQVh6DBk0wKMpi+T3qvBzMNUlqoc+xveAa3UOXsJNHdjon
         YkxhLPb+AhOsPp73ul2irixhT6JuOvNB/znU1VzMLyDxZaptzNoouQnfbrH2fuQFPM9e
         xQLED6A7Yp630BERKQ2Mxp0lTLbGiunoPBaoPXSDfwE7e9jYZeXHjgg1bqp7PBzxmasw
         knGg==
X-Forwarded-Encrypted: i=1; AFNElJ9TwaBXy0y81VVCt+rqI3k31TJVExWHdlCFC1WGtQGkrA1uT0mg8IFkK4iOJe+cnxWfQIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLHRUBi2BoxZkYiLRqLT7F6pwpqMafl1XcFCsobolSNWq+Z4I
	73xXx9d3PDFRTEIeFy3+10fbq1smznBm7Q+w7lGNTUdq1lS7bJp3pgNtfyR49c87fhRUjWrVwHF
	oNbWsh0aOgDVXZ1RSag==
X-Received: from edj17.prod.google.com ([2002:a05:6402:3251:b0:66f:cd9f:9fd7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d1d:b0:bb9:36dd:cd3d with SMTP id a640c23a62f3a-bd51776c98bmr687818166b.4.1779097008430;
 Mon, 18 May 2026 02:36:48 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:36 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <823a5f2af1d794c61560d0bad96863c4c851f29b.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 6/9] kvm: guest_memfd: Add support for freezing and
 unfreezing mappings
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

This patch introduces the freeze on gmem_inode which prevents
the fallocate call. This will avoid gmem file modification when it is
being preserved

Used srcu lock to synchronise the freeze call, where write blocks
until all the reads are free. And reads are re-entrant.

This can be extended to freeze the fault path as well. But currently
the fault failure due to sudden freeze might be fatal to the running
guest.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 virt/kvm/guest_memfd.c | 112 +++++++++++++++++++++++++++++++++++++----
 virt/kvm/guest_memfd.h |   5 ++
 2 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 6740ae2bf948..91e42f717286 100644
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
@@ -273,16 +276,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
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
@@ -291,6 +308,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!ret)
 		file_modified(file);
+
+out:
+	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
 	return ret;
 }
 
@@ -944,7 +964,9 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 
 static void kvm_gmem_free_inode(struct inode *inode)
 {
-	kmem_cache_free(kvm_gmem_inode_cachep, GMEM_I(inode));
+	struct gmem_inode *gi = GMEM_I(inode);
+
+	kmem_cache_free(kvm_gmem_inode_cachep, gi);
 }
 
 static const struct super_operations kvm_gmem_super_operations = {
@@ -1001,12 +1023,21 @@ int kvm_gmem_init(struct module *module)
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
@@ -1014,5 +1045,64 @@ void kvm_gmem_exit(void)
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
+ * NOTE: Currently It is only checked at fallocate path. Page fault path NOT
+ * touched.
+ *
+ * Synchronization Strategy (Sleepable RCU):
+ * To avoid high-contention VFS locks (like inode_lock or filemap_invalidate_lock)
+ * on the vCPU page fault hot paths, this subsystem implements a lightweight,
+ * system-wide Sleepable RCU (SRCU) mechanism (`kvm_gmem_freeze_srcu`):
+ *
+ * Though currently, the freeze is checked only in fallocate, but it might be needed
+ * to the fault path as well in future to completely freeze the inode.
+ *
+ * Global vs. Per-Inode SRCU:
+ * A single system-wide global static `srcu_struct` is used instead of a per-inode
+ * SRCU structure to completely prevent unprivileged users from exhausting the
+ * host's per-CPU memory allocator. Because `init_srcu_struct()` allocates per-CPU
+ * memory via `alloc_percpu()`, which is not accounted by memory cgroups (memcg),
+ * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
+ * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
+ * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
+ *
+ * Flag Modification Note:
+ * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in `GMEM_I(inode)->flags`
+ * that is mutated dynamically at runtime (all other flags are creation-time flags
+ * which remain strictly read-only), there is no possibility of concurrent bit-
+ * modification races. Therefore, a standard `WRITE_ONCE` is fully safe and
+ * does not require complex `cmpxchg` synchronization loops.
+ *
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
index c528b046dd69..028c348a1023 100644
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
2.54.0.563.g4f69b47b94-goog

