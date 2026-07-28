Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C5430309
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240713; cv=none; b=GwV2JyeaCmdCwe3DQioV0HjM/RulAWXa+NjlzensOlup5MmUPKEGXLOON60kCsDYAotQV/tmF/nr5KheC4IyjlbKsR6BwpkOqXvk+HB5Eb7oSvs1TFr74EbwjmCZ1K9eTNES4b2+fUhMKqrW0wA8d5GYcR0sh1/MjiPvroAhBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240713; c=relaxed/simple;
	bh=rlFszFir3fZ/7nA8kOoWcyM1b9QDMhaiFmW7sKDk2/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EhLWCQGVypkpd5eFdicrWh1U0a+jKrWGYRtXBnB7055DqNekvKhgBi2s9hhCm27neC//SLfeHWc2AUGQNdMOFeaDVwDa05d65U+Dec/ctoZKnK7R09GVoiPch8s6upgkGd8yi76UI/ElMWKUmHinvVuBNARfD/QeiFTfxYCPlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJqaKqsm; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJqaKqsm"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15cec1ccb6so410269566b.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240708; x=1785845508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9jjs1g4NvcQ3GQcie84Y49TXK0CTcsSbKyhpxDCGHo=;
        b=vJqaKqsmTryotowgNDsny8791BZDiM3kNzTt2t+8Au5EqNvipNeXSAKZFzIn8Fz1WV
         WTZLwQUMKLPbUIDWRiqrtcDAoBRtMiT7Jk0ugIASSS8fYsnW8tHvSV/FLcDBQ5D1liTw
         gAuIkKUmUYfyahJ5VymaFTEQLKX33oht/SZQ1KJzMEtdQpfAS+qYDJ+UX8S3s+IrJGG+
         +ot9us+0lal8GcWUvluL4mv84RCr9gWo8+8NdN3iMCpaQG9EdCZnpA9v7KxO7jMKqmqY
         3vqTCpkeeQb8wKHZm29VfmRz0O14ESlsXhq/hbd6lHoQmrJQ75k3k5Oyj7dhjuIqt1iy
         MgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240708; x=1785845508;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c9jjs1g4NvcQ3GQcie84Y49TXK0CTcsSbKyhpxDCGHo=;
        b=k4oJElJXU5tU7aPCr3ZVfxvgYWsjsALoEFTa4bnz626HPYrjFLtjC/4QnvSVogEesS
         mK3B06m//7honIUAHcLj25iEQzIEDaatIQckw/dRObszQpxLHfIKeSWwhkiLZN/7MlL8
         Xky6HuYTU+z81zbXTA5/77U9I4MBCCSWxoHgn7PMRhPH7rwLVi7XxeI6x8ZU9f4KL1hY
         RWeAAxh/+CADzniavxv9CSdLb7IBYfANYdNh/BYel1+DRe++mm5/mIoBPEWYs4iQjs9P
         QeBhWlR5RyIqHsrWW9KytniLcpd5v99QNF7B6xvvh7CeybLftbIoaA33DASkht+UeEmi
         2tag==
X-Forwarded-Encrypted: i=1; AHgh+Rp1PKNTyB8LT+t4Ti7lQRVgw1vZ30Jjezfo4Zj3FsMeDxgLcyxf36n4WPJbyELx/x/y0Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHCe1O16K7nvNEvRt36MmV3hgeGW1OT1iau/ekcv6OY3zCv+R
	ptHGZ/BwR9PNYXm+wv3sPOD4lvfgO4yAsCmic5vLB8GskLpEKE6e9g7wToaxSVYmeOdG9EIyo8F
	FL9TzkBv5DWlfQ1PUiA==
X-Received: from ejph19.prod.google.com ([2002:a17:906:7cd3:b0:c12:8c27:d430])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b82:b0:c15:d6c8:2816 with SMTP id a640c23a62f3a-c1f71e1ea91mr103051766b.27.1785240707658;
 Tue, 28 Jul 2026 05:11:47 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:33 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-7-tarunsahu@google.com>
Subject: [PATCH v4 06/11] KVM: guest_memfd: Move internal definitions to
 internal header
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

Extract 'struct gmem_file', 'struct gmem_inode', and GMEM_I() from
virt/kvm/guest_memfd.c into a new internal header virt/kvm/guest_memfd.h.
Also split __kvm_gmem_create() to expose a non-static
__kvm_gmem_create_file() helper that returns a 'struct file *' instead of
an fd.

These internal definitions and helpers allow upcoming guest_memfd Live
Update Orchestrator (LUO) preservation code to access guest_memfd
internals and reconstruct guest_memfd file instances from preserved state
without installing them into a file descriptor table up front.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 virt/kvm/guest_memfd.c | 68 +++++++++++++++++-------------------------
 virt/kvm/guest_memfd.h | 39 ++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 40 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index db57c5766ab6..dd84bba8974b 100644
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
2.55.0.229.g6434b31f56-goog

