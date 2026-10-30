Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395286;
	b=uxkVa1yVC2gQ9oO1mRME+Wkud0nJD7VRkYz+KhP1bJddzHndC/CcChvHSz5kBJ5aA9y6
	 87QsmCvB3KDaY1xovx1kRcs29yewihjpmnGGgzyQDYvdpubUkOAdVWs+/wEWmh0YjQpCp
	 abJkQuBwfFSbrT8Sx0l7yTx4BY2DhRhGNp/slVnT7A1RR6H8gZ9j/gd/LJP94oZOIi18V
	 /DJZ4voLcCwWwJxY21vu6TvxgQQWPNlpMxtfl/vzKE3jCAr0uFipdrFjMUsFUHw4vli1A
	 Sbs5C0ojyz969pFBKmbruJaPotuj1Vdi8Gk3Avkff0k0UMQ16M1NqcXWRyqlsrLQIeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=tBGgI/GpDCr73Zv/DH70VbcIjXcJZddwPYNf2j30K9E=;
	b=lqbLj0OQ0JLIVOv2V0K0EwYYU/lQLq+WVkYDJJp0z/SiP6Bh61x6FZ5yvl/I14IGbnWS
	 qT3UsuAE6Ak/A3j0AMTru1jVQxJxgR5ZPO5jvi49rjoyt7BjZzPrbhdpDw0KjOyZMlVMj
	 KKyuwwWGR7qRigIG962bk+IpieU7K3BZ1OKQC9FqTEvUL+rJqvpuwuuaMWznNl5OsjPhh
	 4mMmlpx3EeVi5x8/QLkM4pdco1mVnYU3vunAuPD5IG3bk2QW9bZpHqqCBK1YbtwFaD8Cn
	 PRCAh4RyO/kjutH0txsVuGVRiw59SzFPgApPHJaJ2O30hLyUIFGRZkaG8CxbW1v6D1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Or8lqyHp;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1E606A98C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C1E606A98C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Or8lqyHp
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so801146a12.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395286; x=1794000086; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBGgI/GpDCr73Zv/DH70VbcIjXcJZddwPYNf2j30K9E=;
        b=Or8lqyHpDTwaUmnx+jbte7Sg3LBwkN8quZglAlXwjR+32f451jJcymVlR+UWA7hrun
         LoCDKRe2EoHTCHMWi5njwRaVl3XJZn6PqGOXaHmEymT7vsnIUvHZJHJV3accDkvg2cqh
         VpEF3D3CQe8/mesCWW7mLWhCzDtvpXHIb7ENqME8p6hYikLb+F9VQ/S/+9Wz7CnJ+m/t
         DbtgHbQPBm/CS/CXOmMo4P8jjTeOkG98je2Zma3x8v77AgL32V/4kVOgWtl8oUsuRmP4
         zGFWCnsPB0XlwP39Zm4l6rMYbxJ7zssnwTJIZMnTrBHuLU5PMx96jiyv2iXglPsMlz+P
         he/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395286; x=1794000086;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBGgI/GpDCr73Zv/DH70VbcIjXcJZddwPYNf2j30K9E=;
        b=H6rxJbWLIQVfZvetsI9fVO8Q3MxQpJqeI/4AIQTbmcvC8p77F+dBVw/Bty/GqS7bQz
         g9JpNJKt8Jfp0lE8fu3m974V4FyJjOP6oAwzP+rIkQx2BYZXAZzTMvdxsVlUNPOaRf0L
         YHDvCWd62hjMAxw65vmrthMoFcSHqE8L3tIcZ/pD6BcunY+tB6rBlHS2uVv7LNtA0muW
         XDwnssf1Q3yM88q8dJRuVmVk5IjZTsAvesIIskMmEWGon8BRbDQ1q7ckR2jUPWl4JhAj
         QnBYfuQk5/4NfPuOBAXQPapN55WARbuyNssX+NDNQkiWvU5qJl3+Ib0q7rRGz1+qvSx+
         Js8w==
X-Forwarded-Encrypted: i=1; AKwUvBzdQ5RiHXmBN+rtFnLLo3cHVptJ1rkteOZOjbN207XZGYfRlkQnZ6IQQ3/KZ95ms7+kKZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/W1j2wJRfBbsK+LxhN/Xd8L589Febs3Ec2cPRKYzY5EhYdYlf
	PYnF3eThTsZHgvxwn/fqn1gGtnSelKNzWB48rLYDNuxQtNQ65Ibjz7jhuW7a5XZInh+xyoe+OZd
	AgHbofg==
X-Received: from pglv12.prod.google.com ([2002:a63:150c:0:b0:cd8:bb6a:e38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1bc1:b0:3e2:1a3e:395c
 with SMTP id adf61e73a8af0-3e928a51d5dmr3526269637.59.1793395285754; Fri, 30
 Oct 2026 14:21:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:58 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-11-seanjc@google.com>
Subject: [PATCH v4 10/23] KVM: x86: Map a separate VMA for each address space
 for internal memslots
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use a separate VMA for each address space when installing internal memslots,
i.e. mmap() a separate VMA for the SMM memslot, and delete the TODO along
with the hack to only unmap() the SMM memslot when freeing memslots.  Use
an explicit shmem file (as opposed to the implicit shmem file created for
an anonymous MAP_SHARED mapping) so that both memslots' VMAs point at the
same backing page.

Note, using shmem_kernel_file_setup() directly is more or less equivalent
to shmem_zero_setup(), which is used for "MAP_SHARED | MAP_ANONYMOUS"
mappings; the only practical difference is the dentry name.

Return the virtual address of the non-SMM memslot mapping, as that memslot
is guaranteed to exist.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 62 +++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b94f981a2e1..8cb58040dd81 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -59,6 +59,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
+#include <linux/shmem_fs.h>
 #include <linux/mem_encrypt.h>
 #include <linux/suspend.h>
 #include <linux/smp.h>
@@ -10007,9 +10008,19 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 }
 
 static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
-				    gpa_t gpa, unsigned long hva, u32 size)
+				    gpa_t gpa, struct file *f, u32 size)
 {
 	struct kvm_userspace_memory_region2 m;
+	unsigned long hva;
+	int r;
+
+	if (f) {
+		hva = vm_mmap(f, 0, size, PROT_READ | PROT_WRITE, MAP_SHARED, 0);
+		if (IS_ERR_VALUE(hva))
+			return (long)hva;
+	} else {
+		hva = 0;
+	}
 
 	if (!size && !id_to_memslot(__kvm_memslots(kvm, as_id), id))
 		return 0;
@@ -10019,7 +10030,11 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 	m.guest_phys_addr = gpa;
 	m.userspace_addr = hva;
 	m.memory_size = size;
-	return kvm_set_internal_memslot(kvm, &m);
+
+	r = kvm_set_internal_memslot(kvm, &m);
+	if (r && f)
+		vm_munmap(hva, size);
+	return r;
 }
 
 /**
@@ -10047,7 +10062,8 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
-	unsigned long hva;
+	struct file *f __free(fput) = NULL;
+	struct kvm_memory_slot *slot;
 	int i, r;
 
 	lockdep_assert_held(&kvm->slots_lock);
@@ -10055,37 +10071,31 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
 		return ERR_PTR_USR(-EINVAL);
 
-	if (size && id_to_memslot(kvm_memslots(kvm), id))
-		return ERR_PTR_USR(-EEXIST);
-
 	if (size) {
-		/*
-		 * MAP_SHARED to prevent internal slot pages from being moved
-		 * by fork()/COW.
-		 */
-		hva = vm_mmap(NULL, 0, size, PROT_READ | PROT_WRITE,
-			      MAP_SHARED | MAP_ANONYMOUS, 0);
-		if (IS_ERR_VALUE(hva))
-			return (void __user *)hva;
-	} else {
-		hva = 0;
+		if (id_to_memslot(kvm_memslots(kvm), id))
+			return ERR_PTR_USR(-EEXIST);
+
+		f = shmem_kernel_file_setup("kvm_memslot", size, EMPTY_VMA_FLAGS);
+		if (IS_ERR(f))
+			return (void __user *)f;
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		r = x86_set_internal_memslot(kvm, id, i, gpa, hva, size);
+		r = x86_set_internal_memslot(kvm, id, i, gpa, f, size);
 		if (!r)
 			continue;
 
-		if (size) {
-			for (i--; i >= 0; i--)
-				x86_set_internal_memslot(kvm, id, i, gpa, 0, 0);
+		for (i--; i >= 0 && size; i--)
+			x86_set_internal_memslot(kvm, id, i, gpa, NULL, 0);
 
-			vm_munmap(hva, size);
-		}
 		return ERR_PTR_USR(r);
 	}
 
-	return (void __user *)hva;
+	slot = id_to_memslot(kvm_memslots(kvm), id);
+	if (WARN_ON_ONCE(!!size != !!slot))
+		return ERR_PTR_USR(-EIO);
+
+	return (void __user *)(slot ? slot->userspace_addr : 0);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
 
@@ -10158,12 +10168,8 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	 * unless the memory map has changed due to process exit or fd copying.
 	 * Leak the mapping on failure, e.g. if the task is killed.  Worst case
 	 * scenario, the page(s) will be reclaimed when the process exits.
-	 *
-	 * TODO: Allocate VMAs for each address space and drop the check on the
-	 *       as_id, which depends on freeing memslots from 0=>N-1.
 	 */
-	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
-	    slot->as_id == (kvm_arch_nr_memslot_as_ids(kvm) - 1))
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS)
 		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
-- 
2.56.0.385.gac671c819a-goog

