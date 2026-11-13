Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538293;
	b=q9OknNfQMzBKP+QXIlAIYLzEXgLs3PAEtDS/EIBSiziYyIhdDrZUypZszj+yycygCf32
	 lr8l0hCtbveQGS+gtMrZBmN9h0De2XyZHvzWyzdtmz3oIRgw9lZmq5YB3bEBKps7vK8In
	 CFZ0qS1v6bH2+DYAUtwMVwhMhXQJbyyZ6NnNcCxjk6dPZVihFqh2I4tov5ngk4JmIRYr3
	 wdskRi8mbHXZ9J8kEgnbptnDQ0z4kTXu9XQ6II5O15H5Ha/ZhZGeAFubskN/ohZEDYnw2
	 UApcvUv1VaXq9ljcfHfuhhuvwt1c75eHxhvp8blN7JT5hfQPG3Q1w2zmflyRXc6kYJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=541U14IJrP2hrNeb4y3odC8xzLwDlMERY6cgBOIWeKs=;
	b=eRrmOogQakfdFq/qQzi6HPCyza5tKdEnkrWof2oQH482Q1B/cIIPL55IMyL6e5T9bywY
	 CcYgDAAmOGu85WBKHQivF5wr6z6UwUW24z0IYGQ6Uizg072qGuvH6YZNU6XniYERRVJrP
	 6nPtWwvnO+09PmHUY6ovz18NAFVXw16Kj0ZpugZ32j65P0MY9y5jcWgs9ZPycODRvSnfg
	 zQYBm33/8sOn5YP1tUSiS9dwsgZVpHvVO7VuYukOagvpRzuk1BagxlTJA955wWGxFVlzJ
	 ot6dJlgzk4bDvCnHTPM65vU3OOiV8xcvL6uzSzwKhv5YWvpH111zl6ZxstkXC1gQm9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxx1KhBZ;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA960606A8A7
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 02:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA960606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxx1KhBZ
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15dd124bbe7so324527c88.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 18:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794538292; x=1795143092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=541U14IJrP2hrNeb4y3odC8xzLwDlMERY6cgBOIWeKs=;
        b=hxx1KhBZ5kNK85X93vhYvOf4I14yypmH/xBSRRqfJ6IFE75ve48XEBJG6tP8845G3a
         6x6SKkOKRKjbZSSsj0pPmx22eH6tCsTGEUIgr+7tFh9MP5nMctc5Txm6Buo8VRvStdiI
         8D+pDcdBS3mNjLVz9uEudJ247No5HfZpv12dq0fRkfA953SURF1WGlnI3tMI5XLiAQlp
         Jo3BxN7w9oWa7Lcd1oYyu1rikWOJ15EqV7Oou3lLmvmaW3kE3SJS1rvNGcSRAm/gYTva
         ppbYVO7P+DtF83pKQcUVaC19XlYdZXbClSFC6lqsL5VafUzy+inwIjj+VvMl5BprRJSa
         CGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538292; x=1795143092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=541U14IJrP2hrNeb4y3odC8xzLwDlMERY6cgBOIWeKs=;
        b=DUiuYmPzaSWu8/AW5ET6tCh3RqRZIL7TA7HyFcpkGjqXjMx6ESoeYKbgHcaTanpZbJ
         pV1MVk4gGtnbjLe/wUfFKkj9MuOw5G63+Sf69PXRsYlwdc42+aAij2vL1uKwUktzAYcj
         bqOd/XXrQ0DG3TouqvvTQZazDO/Q50yalS8t1eIqwYJR+7wcxytUF0OidxYjO08tMxb8
         uL2/F2o7A7vrwS8i8GN2ldZUBfsKqrQH4ThJiL13+kyQhNfgZFh98YR/V7SlBVfGl2R3
         ajKAEKcNKJX3zZ28Ur4HIU67lSFMooJAvAcUZVrs7DCAsWXEDpitIKqYD11HG3flu5Nn
         u3Rw==
X-Forwarded-Encrypted: i=1; AL+hErHaO3448DWxneAEK8fYpoWn7TFt0FkS4TUWsKGxI8PfErPytmnyG06JU3+oYQUFUVXlC/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AL75wL5Z1epxQdp0aSy8VBQoT6Drmpw46SFuyzsudt63DeRhQ
	poPqBYksuvSx0QQ1W+bYS7Pu+dibx1rPOuHQGxCrgYegjRZOFFxPU7sJ
X-Gm-Gg: AYBFou0Z9pFKuUvtwCoeK4fWc/BphXd+nJQcXCzU6Bx8Exv5O9C9x2PhwFR+rk9y7O7
	U5C3NkkUFJGBlXp9E8hel1oUJ6l1u0XdvKe1NmuibhRmw0Qu+zaXL9Y4V57V+UxnVdYQSMWtmH4
	M+FkTJd/6iQ+GxCnRPtOrRlJ4E6iGM0kyX3/AH1119Pk0aMpXaLz5h5pO31j4h7J5GdB8gRX0lr
	Q5VAiDmtsQcULC8dUWC7wWAUb+IQ1p76OhsWxJKru+kbhzerntLNOWegOQehmPPaq3lkbAQGbtZ
	UMfgGbstP1WStqIQMDxpqoGFnxtQYvH8E2KkCu0CMxD30DU2xUxYocewn+hg6zrquDhSrrfusgI
	DbJzKcWPLwlGUB88yhm+bexVwZAqUk6m1nXcJW7df610VKm+4RGpw0bUXvgjK6aXU9TTjJ1cUGB
	r8rPX7QTons/pfsNaEVGp/V1Ygcp/y/lmDCydx0UC60BkWpm2YP9261DJ4D3DQl4SPm3BnFZWXI
	Y7C7OJKWZB+jS3MiKu670nwwHn66weaGhQeKHMAt3C6bRZaLfs9snIGtyBbPhErYpsha2K9nxtT
	waY7R8ZVNkdE2lyuNz3zzjlWQ9ZdsHp0KA==
X-Received: by 2002:a05:7022:3a82:b0:1b2:6855:998a with SMTP id a92af1059eb24-1b503199e7cmr1303894c88.34.1794538291748;
        Thu, 12 Nov 2026 18:51:31 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm2853771c88.11.2026.11.12.18.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:51:31 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-mm@kvack.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 2/2] KVM: PPC: BOOK3S HV: Use ksm_disable() for secure guests
Date: Fri, 13 Nov 2026 08:21:14 +0530
Message-Id: <0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <7510ddb55a34e8a669eb7c2624d652264701bfba.1794537345.git.ritesh.list@gmail.com>
References: <7510ddb55a34e8a669eb7c2624d652264701bfba.1794537345.git.ritesh.list@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pages of a secure guest are moved to device private memory with
migrate_vma_*(), which can't be done for a KSM page. So, when a guest
wants to switch to secure mode, kvmppc_memslot_page_merge(), walks the
VMAs backing each memslot and calls for ksm_madvise(MADV_UNMERGEABLE) on
them. It does the reverse if the H_SVM_INIT_START fails or when the
memslot is getting deleted.

Instead of using ksm_madvise(), one can use ksm_disable() on the mm.
IIUC, ksm_disable() was introduced for this purpose itself in commit
  2c281f54f556e ("mm/ksm: move disabling KSM from s390/gmap code to KSM code").

Also, it seems there are other existing issues in current code.
For e.g. The current code can turn KSM on for the memory the VMM never
marked mergeable. This can happen say for a guest whose H_SVM_INIT_START
fails and therefore the cleanup routine ends up setting VM_MERGEABLE on
it's memory.

Note: This was spotted and reported in one of the series which was
converting legacy vm_flags_t to vma_flags_t, showing concern around why
powerpc has to call into an mm internal functions. Besides, this is the
only remaining user of ksm_madvise(), outside of mm.

Let's fix the existing issues and also address the reported concern.

Reported-by: David Hildenbrand (Arm) <david@kernel.org>
Closes: https://lore.kernel.org/linuxppc-dev/1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s_uvmem.h |  1 +
 arch/powerpc/kvm/book3s_hv_builtin.c        | 26 ++++++++
 arch/powerpc/kvm/book3s_hv_uvmem.c          | 69 ++++-----------------
 mm/ksm.c                                    |  1 -
 4 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_uvmem.h b/arch/powerpc/include/asm/kvm_book3s_uvmem.h
index 0a6319448cb6..c8cc11325639 100644
--- a/arch/powerpc/include/asm/kvm_book3s_uvmem.h
+++ b/arch/powerpc/include/asm/kvm_book3s_uvmem.h
@@ -27,6 +27,7 @@ int kvmppc_uvmem_memslot_create(struct kvm *kvm,
 		const struct kvm_memory_slot *new);
 void kvmppc_uvmem_memslot_delete(struct kvm *kvm,
 		const struct kvm_memory_slot *old);
+int kvmppc_uvmem_disable_ksm(struct mm_struct *mm);
 #else
 static inline int kvmppc_uvmem_init(void)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fa0e3a22cac0..e39fc28a27a7 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -14,11 +14,14 @@
 #include <linux/sizes.h>
 #include <linux/cma.h>
 #include <linux/bitops.h>
+#include <linux/ksm.h>
+#include <linux/mmap_lock.h>

 #include <asm/cputable.h>
 #include <asm/interrupt.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
+#include <asm/kvm_book3s_uvmem.h>
 #include <asm/machdep.h>
 #include <asm/xics.h>
 #include <asm/xive.h>
@@ -627,3 +630,26 @@ void kvmppc_check_need_tlb_flush(struct kvm *kvm, int pcpu)
 	}
 }
 EXPORT_SYMBOL_GPL(kvmppc_check_need_tlb_flush);
+
+#ifdef CONFIG_PPC_UV
+/*
+ * Pages of a secure guest are moved to device private memory one by one with
+ * migrate_vma_*(). This cannot be done to a KSM page, so the VM is not allowed
+ * to have any and neither get new ones. This functions stops KSM for the
+ * whole mm.
+ *
+ * This lives here and not with the rest of the secure guest code, because
+ * that can be built as a module and ksm_disable() is not exported.
+ */
+int kvmppc_uvmem_disable_ksm(struct mm_struct *mm)
+{
+	int ret;
+
+	mmap_write_lock(mm);
+	ret = ksm_disable(mm);
+	mmap_write_unlock(mm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvmppc_uvmem_disable_ksm);
+#endif
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 190f64d992d8..fa50c103a9ee 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -47,7 +47,7 @@
  * Locking order
  *
  * 1. kvm->srcu - Protects KVM memslots
- * 2. kvm->mm->mmap_lock - find_vma, migrate_vma_pages and helpers, ksm_madvise
+ * 2. kvm->mm->mmap_lock - find_vma, migrate_vma_pages and helpers, ksm_disable
  * 3. kvm->arch.uvmem_lock - protects read/writes to uvmem slots thus acting
  *			     as sync-points for page-in/out
  */
@@ -89,11 +89,9 @@
 #include <linux/pagemap.h>
 #include <linux/migrate.h>
 #include <linux/kvm_host.h>
-#include <linux/ksm.h>
 #include <linux/of.h>
 #include <linux/memremap.h>
 #include <asm/ultravisor.h>
-#include <asm/mman.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s_uvmem.h>

@@ -388,78 +386,30 @@ static bool kvmppc_next_nontransitioned_gfn(const struct kvm_memory_slot *memslo
 	return ret;
 }

-static int kvmppc_memslot_page_merge(struct kvm *kvm,
-		const struct kvm_memory_slot *memslot, bool merge)
-{
-	unsigned long gfn = memslot->base_gfn;
-	unsigned long end, start = gfn_to_hva(kvm, gfn);
-	vm_flags_t vm_flags;
-	int ret = 0;
-	struct vm_area_struct *vma;
-	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
-
-	if (kvm_is_error_hva(start))
-		return H_STATE;
-
-	end = start + (memslot->npages << PAGE_SHIFT);
-
-	mmap_write_lock(kvm->mm);
-	do {
-		vma = find_vma_intersection(kvm->mm, start, end);
-		if (!vma) {
-			ret = H_STATE;
-			break;
-		}
-		vma_start_write(vma);
-		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
-		vm_flags = vma->vm_flags;
-		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-			  merge_flag, &vm_flags);
-		if (ret) {
-			ret = H_STATE;
-			break;
-		}
-		vm_flags_reset(vma, vm_flags);
-		start = vma->vm_end;
-	} while (end > vma->vm_end);
-
-	mmap_write_unlock(kvm->mm);
-	return ret;
-}
-
 static void __kvmppc_uvmem_memslot_delete(struct kvm *kvm,
 		const struct kvm_memory_slot *memslot)
 {
 	uv_unregister_mem_slot(kvm->arch.lpid, memslot->id);
 	kvmppc_uvmem_slot_free(kvm, memslot);
-	kvmppc_memslot_page_merge(kvm, memslot, true);
 }

 static int __kvmppc_uvmem_memslot_create(struct kvm *kvm,
 		const struct kvm_memory_slot *memslot)
 {
-	int ret = H_PARAMETER;
-
-	if (kvmppc_memslot_page_merge(kvm, memslot, false))
-		return ret;
+	int ret;

 	if (kvmppc_uvmem_slot_init(kvm, memslot))
-		goto out1;
+		return H_PARAMETER;

 	ret = uv_register_mem_slot(kvm->arch.lpid,
 				   memslot->base_gfn << PAGE_SHIFT,
 				   memslot->npages * PAGE_SIZE,
 				   0, memslot->id);
 	if (ret < 0) {
-		ret = H_PARAMETER;
-		goto out;
+		kvmppc_uvmem_slot_free(kvm, memslot);
+		return H_PARAMETER;
 	}
 	return 0;
-out:
-	kvmppc_uvmem_slot_free(kvm, memslot);
-out1:
-	kvmppc_memslot_page_merge(kvm, memslot, true);
-	return ret;
 }

 unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
@@ -482,6 +432,9 @@ unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
 	if (!kvm->arch.svm_enabled)
 		return H_AUTHORITY;

+	if (kvmppc_uvmem_disable_ksm(kvm->mm))
+		return H_STATE;
+
 	srcu_idx = srcu_read_lock(&kvm->srcu);

 	/* register the memslot */
@@ -1107,8 +1060,12 @@ int kvmppc_send_page_to_uv(struct kvm *kvm, unsigned long gfn)

 int kvmppc_uvmem_memslot_create(struct kvm *kvm, const struct kvm_memory_slot *new)
 {
-	int ret = __kvmppc_uvmem_memslot_create(kvm, new);
+	int ret;
+
+	if (kvmppc_uvmem_disable_ksm(kvm->mm))
+		return H_STATE;

+	ret = __kvmppc_uvmem_memslot_create(kvm, new);
 	if (!ret)
 		ret = kvmppc_uv_migrate_mem_slot(kvm, new);

diff --git a/mm/ksm.c b/mm/ksm.c
index d24b129932bf..9d3db831ac87 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3058,7 +3058,6 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,

 	return 0;
 }
-EXPORT_SYMBOL_GPL(ksm_madvise);

 int __ksm_enter(struct mm_struct *mm)
 {
--
2.39.5

