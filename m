Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882D349AE6
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154153; cv=none; b=iwVKzOjQLde0UCjc/R2rS7b4xvKSkmqlhLxYsHx2CFdi2XZSz5pyvjk/F6lLnrhnx7PBxxp6ZpWPB7ElISif+uYII2KBt0YCTQQRQ0HnCOhnzBoW1TwCcVlcJ6OdWVMtkB/+fRELll9tCjhLA67agQnTt1dH5lYG/9vte0TpUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154153; c=relaxed/simple;
	bh=eSsWjg7+Xo0AyadgQytCuqK0tjsGOi6I8g06Sl8yFn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PsN2Rzcq3vBl6+qbSaVqhYKquK74CCd5Rj6PPZ4QfZI/SKctUdxrLKdspntBK9Q4TnQQ/fEmN7TnQqh2mVNH2DHUvS62Z8czF+mfnnvb4mKoXosAtx6nPOyk2ADEd2xB1f3AX6b3T4RjXCdajxJqTyMuwurufKPsB9ZLXdoso9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7eXFR4i; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7eXFR4i"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-697bd22237dso1143772a12.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154145; x=1782758945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrCK2iLTFuPkCKKXsEtILhMjhO8cYkJcRVq4TpiCh/Y=;
        b=u7eXFR4i9Xzw5O+9U+9FegGZfV5ObPFeB+fziH1eAPW7iDSiZoVnuS2MUVTGeRht6Q
         Fxb8xOzJFboveSoJapPHPpZnWXc2nvECkvqXK22QrWb3kpzAw7dfbCb1zd/+hVvprwl+
         iysGW5dB0CJMjrHWnY97EQm3kwh9D5O8bwnG4GL0Wb53C16FRYL0sy/vgh8hVV00xwl8
         Fqg6M6lWvfx8yntkF5Kvo5Ls9NX6Z1dXOBCFptjZKYcq1KlJXbRmmSY+VM3tZ27Fbn2/
         ILg89W3QVd2BbRdjuBpDbfQlqAcCYBUA6vCvjbNInyLZ2LKT5YRwV2G+gtmsSTSSCh1v
         Sl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154145; x=1782758945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrCK2iLTFuPkCKKXsEtILhMjhO8cYkJcRVq4TpiCh/Y=;
        b=LdkzHOcSU6tex3OsaxP0EHqJt7NT9aozjaKlCa0tj64zDGOJqjlLTLGzT52SWTZuwU
         JEC4K0fOirBnxQYDxgskLvDwBgUkz5UQPxA73MX4zSjvwMPyNzQJabn7zIMtPcXqEFmh
         pR84z26IyFeI/5gRc5Yl8pCG+gWUK42nt3ag8O8I2k7VhovVwuUhe/pSleCmiOc2yCtM
         nHmjOMk+l/bhDtcEPJ/F4k0jOrTCaU+KBmijN7kxcaElJ6EDyVTZFEiStm3O5BO2GEiT
         1p3aIVJ49qAzytnqnOCqjQdvrgdL/NKXTsihHBgB7KkTWBltQ7b7DKVCA0Y6i3OAAyeG
         2oVQ==
X-Gm-Message-State: AOJu0YyNZcrMusXZvizqyh9u3XVqV7mwHpzU2ltxl1cF3pFHkbCPBDh1
	0BcgbByc7mSrhaKfRzHuhgJMxxwkVbR7PteUvxLlpGSrsHnzzolW3nIzu2UhRmg1zoktDBI6UPe
	HJnW81iz0QD1gZnLO+w==
X-Received: from edsl17.prod.google.com ([2002:aa7:d951:0:b0:695:f6a4:adb4])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:35ca:b0:697:bd1d:116d with SMTP id 4fb4d7f45d1cf-697bd1d14acmr2221698a12.27.1782154145133;
 Mon, 22 Jun 2026 11:49:05 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:46 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-5-tarunsahu@google.com>
Subject: [PATCH v3 4/9] kvm: guest_memfd: Move internal definitions and helper
 to new header
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index 8669068..fe1adc9b 100644
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
@@ -557,23 +531,17 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
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
@@ -612,8 +580,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
-	fd_install(fd, file);
-	return fd;
+	return file;
 
 err_inode:
 	iput(inode);
@@ -621,7 +588,28 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
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
index 0000000..c528b04
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
2.55.0.rc0.786.g65d90a0328-goog

