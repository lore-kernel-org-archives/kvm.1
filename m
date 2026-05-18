Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A33E929C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097011; cv=none; b=UfOdtEoKuHb8/oG/pBafWkSZNdZMdr8N6/xUU8d9ZnGufaUstZr9XdPW02C8QTnUkAU4DAeATgDwSxYFVkMi5zwb6nff0u2S/xTRSO524ufTmh2UUZqN5Jhf47a9h1RerrATe0+j1ZjU7mUexqr++Z7qNwLs670wx/GJ0zlSi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097011; c=relaxed/simple;
	bh=rX9trZHLhIabH8PpO+YhRR+xBUlfsUPyON5NVc6GASM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tHSMdUSDF6vbhmjUJL3nYNrpJouxjJ6xtt7e2PIwT91hl0mkVUznqrtrAPEmn0NVKKVO+1M1JgDVsb9b3or9AoN/Tia/Pv4zl+riYDJ23jvvHOmOSb7b9cDnBYdQu3Okq/qAvjooLddZLHtkCJ7YNmKkm/6ZmJUiw/ccpWW2o4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKBPVs20; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKBPVs20"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fd64c32e8so14662825e9.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097008; x=1779701808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKCrM2P1AyKOpet4Lptlcq4TPub3FnQxmPnAQcRZa6A=;
        b=JKBPVs20Ne8L2Epqc+3Pn249xehI2ez8ToL/CHThnwJmCdxuz+FztnFfCIWAlNmhfw
         qEPJT6oxATK0vx8fnTnrpA/8NqZXyGAR5+RTNWwwydMNvQ1hIQz7HARe56u4rvGLZb2N
         8B8d2anwMUHl1lO7jzNTMM1ZiAnV5BIfCGYSy/4UBQVHP0Um7eyq+eZXwIeoC4iWO68K
         Hrpc0/HQ10vSDOLjXA5T0T8t0v+//s80aInqpaM5N2/PMzHzz6qKVClRCLcnS+CFU4IZ
         ZG4smFzcPWWDcf68g0nShpiRWHjek59lYUGxrQe4GfwRyadyuRSaGPjudoXZxY2xN3Yd
         gkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097008; x=1779701808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKCrM2P1AyKOpet4Lptlcq4TPub3FnQxmPnAQcRZa6A=;
        b=dYbQQeIoSPbnwf77UAdSeSrnErBCs8bIq/KQaYg4yHos09oYzjrADiAkz8zaIiU/Zu
         81/6yOp/+SOQ4Eif1RbGngWGYDbBhijEsjd9RsED2PwkmqlHHlf0aI2EkSHz9mcAOk1E
         FkeDdWwOt+0syTbgFlOA3JMndRehtBWYbuetSwhcZFWyBiHHLzcmUJvt7SfXGcBTUkt2
         Xfm/hgRMicWrT/sNgAtjGKP/M+VQ/URgIQT8T96hV1SFdiO5LJ7Em1KyMnN224BoQlyy
         YYNjok62Ms+SbdxHsb2n/O3MopxK3SQPpkivHB2GFYkU1/KzlJJZXkYXJgXrbYvqSWgO
         x5hw==
X-Forwarded-Encrypted: i=1; AFNElJ9LAgQR8DcWflvEXlDTb6BydYDnnEQSY5hhasHk8ybbVyI/8gJnyj9+KOkayfV/dU613kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDa+8NF0Y+semrOx0DG9yEN2oklsmeuBXxN/rzQ2m1rRxKgGl
	uwvUGbXpcoqWLtIlemgX8qb8jQTkeojR4BEK7iAgfO9gBU9k6Kd4bZcGlheYRftjQraFyVf2Qkg
	YahDq67/nnHnA+YIkOA==
X-Received: from wrbdw3.prod.google.com ([2002:a05:6000:dc3:b0:43c:fe6b:f318])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe60eb0ebmr237233615e9.10.1779097007184;
 Mon, 18 May 2026 02:36:47 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:35 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <7ffc1fb8962fd27428ac3e2f3d8950492597e03b.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 5/9] kvm: guest_memfd: Move internal definitions and
 helper to new header
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

To support guest_memfd memory preservation with LUO, guest_memfd luo
code needs to access guest_memfd internals and reconstruct guest_memfd
file instances from a preserved state.

Extract gmem_file, gmem_inode, and the GMEM_I() helper from guest_memfd.c
into a new internal header virt/kvm/guest_memfd.h.

Additionally, split __kvm_gmem_create() to expose a non-static
__kvm_gmem_create_file() helper. This helper returns a struct file
instead of a file descriptor, enabling file creation and initialization
without installing it into a file descriptor table.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 virt/kvm/guest_memfd.c | 68 +++++++++++++++++-------------------------
 virt/kvm/guest_memfd.h | 39 ++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 40 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..6740ae2bf948 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -7,38 +7,12 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include "guest_memfd.h"
 
 #include "kvm_mm.h"
 
 static struct vfsmount *kvm_gmem_mnt;
 
-/*
- * A guest_memfd instance can be associated multiple VMs, each with its own
- * "view" of the underlying physical memory.
- *
- * The gmem's inode is effectively the raw underlying physical storage, and is
- * used to track properties of the physical memory, while each gmem file is
- * effectively a single VM's view of that storage, and is used to track assets
- * specific to its associated VM, e.g. memslots=>gmem bindings.
- */
-struct gmem_file {
-	struct kvm *kvm;
-	struct xarray bindings;
-	struct list_head entry;
-};
-
-struct gmem_inode {
-	struct shared_policy policy;
-	struct inode vfs_inode;
-	struct list_head gmem_file_list;
-
-	u64 flags;
-};
-
-static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
-{
-	return container_of(inode, struct gmem_inode, vfs_inode);
-}
 
 #define kvm_gmem_for_each_file(f, inode) \
 	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
@@ -556,23 +530,17 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags)
 {
 	static const char *name = "[kvm-gmem]";
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
-	int fd, err;
-
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
+	int err;
 
 	f = kzalloc_obj(*f);
-	if (!f) {
-		err = -ENOMEM;
-		goto err_fd;
-	}
+	if (!f)
+		return ERR_PTR(-ENOMEM);
 
 	/* __fput() will take care of fops_put(). */
 	if (!fops_get(&kvm_gmem_fops)) {
@@ -611,8 +579,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
-	fd_install(fd, file);
-	return fd;
+	return file;
 
 err_inode:
 	iput(inode);
@@ -620,7 +587,28 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	fops_put(&kvm_gmem_fops);
 err_gmem:
 	kfree(f);
-err_fd:
+	return ERR_PTR(err);
+}
+
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+{
+	struct file *file;
+	int fd, err;
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		return fd;
+
+	file = __kvm_gmem_create_file(kvm, size, flags);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	fd_install(fd, file);
+	return fd;
+
+err_put_fd:
 	put_unused_fd(fd);
 	return err;
 }
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
new file mode 100644
index 000000000000..c528b046dd69
--- /dev/null
+++ b/virt/kvm/guest_memfd.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_GUEST_MEMFD_H__
+#define __KVM_GUEST_MEMFD_H__ 1
+
+#include <linux/kvm_host.h>
+#include <linux/fs.h>
+#include <linux/mempolicy.h>
+
+/*
+ * A guest_memfd instance can be associated multiple VMs, each with its own
+ * "view" of the underlying physical memory.
+ *
+ * The gmem's inode is effectively the raw underlying physical storage, and is
+ * used to track properties of the physical memory, while each gmem file is
+ * effectively a single VM's view of that storage, and is used to track assets
+ * specific to its associated VM, e.g. memslots=>gmem bindings.
+ */
+struct gmem_file {
+	struct kvm *kvm;
+	struct xarray bindings;
+	struct list_head entry;
+};
+
+struct gmem_inode {
+	struct shared_policy policy;
+	struct inode vfs_inode;
+	struct list_head gmem_file_list;
+
+	u64 flags;
+};
+
+static inline struct gmem_inode *GMEM_I(struct inode *inode)
+{
+	return container_of(inode, struct gmem_inode, vfs_inode);
+}
+
+struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags);
+
+#endif /* __KVM_GUEST_MEMFD_H__ */
-- 
2.54.0.563.g4f69b47b94-goog

