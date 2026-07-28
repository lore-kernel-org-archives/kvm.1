Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDE43031F
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240707; cv=none; b=rlLvdKb7W+8Iz2h7I+T8qSUSdocfpqop7v7oGtYdjDFdMnaiFPX4529rRHTjNxzLldCnS2Blg3JqkT9x5FonEAmZq3BnHiE0rxqaT51YBmomtEt+0fWiodRzRvPGhjyQiMBXwDz0/uOlBkqKmAV6u97N1eBeYH7VOfTA54OBkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240707; c=relaxed/simple;
	bh=1b1wF5pCQZEXkCKxFeZcA3OkhQHKENJj3Kks+0iWkbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7+NZvAL4kXS3TM8hPaPeQoiFgbTPLDcRX9ZjQEPIkHG70RM7fDyxy7BbjbqqcmOSHmDwBRRQNfNcmF2OttZkE6iWL4JxfhIMsUpDnvcXt5qEqAoJ3QGKG+ZocEeZHp1R28GAv+GQ+FvTTCrAP4JrKFW/6IJHESMqmaC6r/xEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5p6WryQ; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5p6WryQ"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69e97ea7b5bso4372357a12.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240704; x=1785845504; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzckiEC4GSPBVnzwnF4qvKlP6HAv3vDKnOlfEZZeHDM=;
        b=s5p6WryQFxWOkfc12pFxWGC+Be0qHG8NLcFiZv5UZU+d1lrCK847VvjbZM7PiUlhV9
         DfBAsK2LQmUKNDJRU35JROFvoTUY8kIJ7DmFq7y59Q2tH3pe6wGmhDoD1zL/+dlGmgCp
         auOQA6oYcC+fZTDUeP7d583ye+oOc5VQ+KNMvPPL2bzvYfP/HuHNmEGoIF11L8Q0R75q
         Bavbs7UNoQH6LE+a1ytP/bFUGRKud8Q/qSNGo1U6ZPXajyY0kuDYWgSHWZlnbFnZolox
         cNkpstJAQhCi7pvuXFOaKJOHF/+Yd0noxpudPfHlCOYLAlVMYXFZV6Jq38k+w4k72pF+
         bZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240704; x=1785845504;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzckiEC4GSPBVnzwnF4qvKlP6HAv3vDKnOlfEZZeHDM=;
        b=OCZpdCKWvK1RebmIQYj08E1hN56mzq3cN+BQkEGbQO6w1Y8OSrTePU1qo8Ll/1UzMP
         EDBseDB84aEwxNP5BN6vClaqdhWIvZ7dY72Tj1lVum07Gi73wnlt1rzZJH0NhpR0ncQ4
         pUPHiz9dcHAzL1AzhZIGhUn0aJErxTVhKfZXUWmq/nwFVR9gZwEoYllmnJk0Jv2pkZq5
         cYSSv5iAqt0wqYlquacMe74usKUMDrIIl2wPj0lBkR4+4csHA+kX6s9bQR8K/Jb6zZGc
         VquW4t1mu9N5WlvzL2fzhF7JpCtQZTji1hICP2S66WQYFGS/t/5izKRZPjuliNAZpi28
         TcUw==
X-Forwarded-Encrypted: i=1; AHgh+RokG6YBjVpSqQb8X45XdiIkDvcn/HXU6piYI4S0TL0oJm87sVUyWCz+czefsqE9aKk19N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLyc/WRbgVUORIXr+/0RO/fGOxMAU3Oja0SyQ9CPjkJiOTWgGu
	wNnkfP7zGiuiNmz5o1qEJWZcH0nznly/p7IPOupWCrVn+A5eUfT7xkMRLFDyBTFsyREy6xiIgQE
	mgqSol2znuSv9JR34pQ==
X-Received: from edwv27.prod.google.com ([2002:aa7:cd5b:0:b0:69a:306f:a69])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:194e:b0:691:7054:8c6b with SMTP id 4fb4d7f45d1cf-6a034a9e9demr1065056a12.19.1785240703362;
 Tue, 28 Jul 2026 05:11:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:29 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-3-tarunsahu@google.com>
Subject: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
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

- Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
- Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
  anon_inode_getfile(), providing a unified VM file creation API.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 48 ++++++++++++++++++++++------------------
 virt/kvm/kvm_mm.h        |  3 +++
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..79b084887cdb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1074,6 +1074,7 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..3339b8fcd59f 100644
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
@@ -5477,11 +5474,34 @@ bool file_is_kvm(struct file *file)
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
@@ -5490,31 +5510,17 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 
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
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 7510ca915dd1..624161793fec 100644
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
2.55.0.229.g6434b31f56-goog

