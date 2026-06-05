Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378CE39A7E5
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679331; cv=none; b=FoJziyOnLZeiBCi1gH/ILl0KGoOIA82LTNnB62AvDQS1htBvbVxR43kZ76go25yYU+5F0FHf9HaoMfHxw/PbLMBKK9GOslfY1GvCOCqyQbiH7dZGzDKnv+TnOJMPnInwGFL83o0TuRhQD7WCDVaA2zECdkaTScHf7a6zkQjeKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679331; c=relaxed/simple;
	bh=n228DZT65TwLTTfjFoMaX3cWUngcNkQKNDGZIIkw6j4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmKYBRafHOvCdQMkC/Uuq4J/+3WWJrXidYCu6s/tV+65jBMiyjTCWIRlQjd9bYAjs5tLvivfm4e0oWRgSN2j5exQR95qWaeo1tcPIRHfTupddMuxhznKllkYpb5jfGZcDQ17tNQmaXTkhc+2ZguWp1dOrbPIe3FUEhaeSgh3VIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTjd3I1z; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTjd3I1z"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-beefe797002so25040466b.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679328; x=1781284128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1s9Gl9n+JDRxm+uLKvGaoj9Iw7+lf3bKjXDLeITLpkQ=;
        b=cTjd3I1z8ucZsFug3zmwZkeROVPtVMg+f+/tihny2YmT1gLoJz/1PVzn/pPGra7R8J
         xzKf6fHpL8Z5o2wJNf2ORZmxhHOL/dyLzcNhy66X7+OkVkFoThTRb5tlDqAMlQYIS5n1
         2ky34YxmxeqmmZMN9SS+E7y4DnItEKlAKqrUM+bp4r3P4bnXWH+RVQfAhMSp4y2sloim
         yhGyaeWBc5/rAUdnoG336PHzW4OIG36yglDAaedwF4Stxnk/yCDyLzAPiJlxwmT9VQ69
         VXkNtnJUNu/Yz7dDyHvG19/8eeLZws26ZntUdvlMTiqzYD0WjuagXDuEtLVGBL3cKEs2
         PGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679328; x=1781284128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s9Gl9n+JDRxm+uLKvGaoj9Iw7+lf3bKjXDLeITLpkQ=;
        b=SGLu5Lt6EXjN7gIY7Kz9TEvutul7FhZaeVLVVieK8+oXkxaXYsiYn+Ku3H4swHkCbB
         Y5wMiCsiyap6oysILr/jtsXmqfI7DSMmAfnfPh9SuZ8/d98kP4ojmVhmyAetmxgtMIC4
         9l3JZHhdo7uFG49bjc1uYpb7C11gn3jeebO8XK7Jxp/bLoUMdQiCIFb4DpxM8Re7Jw4x
         UtmQPRNKREp960DHzUbqSjvQuFCPKG9qjlMceBpjqvSV+Grjf77pgfquAZDBMfeo/TQH
         3o4RufOIh2lGFhBML4B1rCfcAkj7GP0jdo+M7il5NHEfPXizePBBdQlZ3gFMXO0wQ5C4
         oqkw==
X-Forwarded-Encrypted: i=1; AFNElJ+a0ERB2gTlduv3z4pN5P270qfwEugcrp2JKb1fWx8wvtS4L520bPoUTWhDYCi8RcNHuGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnPqs5V6KzR/VUkmmXpco2RAHI7jtojFmhbj5wQ/zP0jsXyMvs
	KpEd9xp4ag+BH9kiuIWlqAIS39hgpT61xVwUcylA7pVsdVUq+rD2hqNjaWF41k9ygdsr7+RFPA6
	8Ql2lASupELm5C2K7bQ==
X-Received: from edty21.prod.google.com ([2002:aa7:ccd5:0:b0:691:5097:3e07])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f59b:b0:bed:6e53:bb1a with SMTP id a640c23a62f3a-bf3749d1646mr252719466b.48.1780679327271;
 Fri, 05 Jun 2026 10:08:47 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:30 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <769d0adac847d638fceb3fce093755a74e686582.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 05/10] kvm: guest_memfd: Move internal definitions and
 helper to new header
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
2.54.0.1032.g2f8565e1d1-goog

