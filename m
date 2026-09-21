Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2748E0D2
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989276; cv=none; b=LsFjhC/XyG102RJ4IGC0zJzT/xpBpAUWiRgDeynTQRVab4KsHyNogk6QgH72WzWDMHTyXMTUUM2x8uWWJNwLFHxJtAas33NrEFAFZhDGlEwfr5M7g02zniM+LqGkoBVimPmnTeVrtgT6STam0ox6u6QxnKCtNPwdDXm+dJrj2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989276; c=relaxed/simple;
	bh=JcBuvM3CVeR3tUQ0SEU79f7AefJbf/1Y11q/0iXbWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTMhQRxXYDxgxlbiCRDc9VTPVxfisGtt5Khj/AR52VKBf+/xpSofI7ZD1LQtAFeg7KAmR3zNzr6SSvFHuSJz16HYX9IT/Qw6TyRRJd1xA1qm/F7Y+BhRClXCk6A9pVcDRdxsB3zSja8MG1FCD15Pov0dYPDAcfYOAXPNDhtJFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLxUfYhs; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLxUfYhs"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so28118555ad.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789989273; x=1790594073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ef3phNMqqlA8Z4yqCL8AgS9AIUhshDlKUByQ4fToEc=;
        b=YLxUfYhsrMlNPeXWO0F8mcHAQzu9dds3x6IdHH//Lba5mk2MKySIAQo8p8HY7cKVvm
         SwxfBFE0367uswsJNCSlUX1nVmN86YxleKpWf8ACOHUFLjBVbznYWpV2YPBHkyq6300z
         uwi86vWfVtlN0CqHtpvhr2eMWVx/DRNGaic84bS+Pwp2xgmputYOdAhL51Hhe7HUWf8L
         6ieRd4TRWU1XJClbk8judMp1JkP8Q9NDJbVghud3KR5uIWp93sM4AukMnMvH+JjzHlgV
         Sz1duqw2rrhzJg0MYXTPlaDhlJbMO8+orcqKrAR6/HEHsoEI337oJPND5W9CZOnwf2+g
         xP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989273; x=1790594073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ef3phNMqqlA8Z4yqCL8AgS9AIUhshDlKUByQ4fToEc=;
        b=VxU1ZInZb7yyxTqG6n6YmwafPOmTlk/WbCGGIgZypW9VDYadVUD76MCked7QkqMJ9Q
         TG/MRzSAa3j5u2dx6r6M60MzbOuxIWTJ/UCr5OlIdLlv8IsXL+CssWgoIZC68ah7N596
         7zgQXKQrEQEr/7ON42joBbgaakGIhBbX+SnVn1Fc4WFUKD3PMqKk9hc85wLaBN4PRqhk
         CA0SO1xp9MFDanyUHt6fpnxp5zK2glLzsmC2hDxRssdInYpubWssiClEi50ql7bo7okR
         f4avRVSQqWgnFenFVaU+80c42oAWKF1n2P7HZsUCR3ikN2hsAm2EFUmKzHC5xwWwYvLk
         3Gxg==
X-Forwarded-Encrypted: i=1; AKwUvBwZ2MY/MJlMi8f7ZVLB0EIDKHG0WwMD3NE2TSLGxE94kJxNEQ9f2Y5bzwJkavovGhmae00=@vger.kernel.org
X-Gm-Message-State: AFuF++n16o/pzkDCA+VbGj9f6o/pgRI/tPHCcbRcZ2FQrIBfhrGyHFsT
	2dF5k00FtdJh/ZLpWNYiOjmb/V+V+joYR0BqIgu1MYoeNn0efFfob/vkmrAlxA==
X-Gm-Gg: AYBFou1HriW7kObnWr87+8mNb7a5xWYNztY3tjSHhLgGjdk6aXqoANfILz+/QNabRW1
	ZVE1euXoytmBFlaoAq3d4E3mMDoaNtQViYCyuSEzQw0lZNM34tAjkwRHKkPbO+xz8PhCC5bTi9F
	GCASaPA9L0F6xE+tzs6jXwF3LqP3bdFrBGEDKW5ZWfy20CAKv74lMSH8CYABlr6zfAyc4heH8uJ
	vN98HfIxqTabHu2mzkf327dXFOBbogzWfYvNg6CuKIdoYGI8fGI3Nb6llk76TcymCK3R28E/n7o
	AQ0p0mA9HyI1jCx9m8qK6SP+qaLmV2qdsp3/NHUSUDkB2/uy7azXXwgZdNengupbQx54jbpCZjj
	V/fQ8iNmYjF0CNwttTU7ba+DB3+bfPJQ5ES1z4ebLdkxcuHvpPah3ebqA0xVjVVsv2KxniEE+IX
	Z+AyykokBknek7LRxo6gDjtYLB21hoWTI1oUW7Y0Ncfiln2ZytAnEq3WlzedbuEIo8vXemuUudX
	qs9QahgCcBWZs9EG+lDrA==
X-Received: by 2002:a17:90a:e18f:b0:39d:f5ef:b1d5 with SMTP id 98e67ed59e1d1-39e54aa347dmr15111936a91.7.1789989272818;
        Mon, 21 Sep 2026 04:14:32 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm13438703a91.0.2026.09.21.04.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:14:32 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jinyu Tang <tjytimi@163.com>,
	Wang Yechao <wang.yechao255@zte.com.cn>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 4/5] KVM: riscv: Free G-stage page tables after an RCU grace period
Date: Mon, 21 Sep 2026 20:14:01 +0900
Message-ID: <20260921111402.120911-5-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260921111402.120911-1-suunj1331@gmail.com>
References: <20260921111402.120911-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

G-stage page tables are currently freed immediately after being
unlinked under mmu_lock. This is safe while all walkers hold mmu_lock,
as a table cannot be freed while a walker is using it. A subsequent
change will allow aging walks without mmu_lock, where a walker may
obtain a child table pointer just before a concurrent unmap unlinks
and frees the table.

Defer freeing unlinked page-table pages with call_rcu(). The parent
entry is cleared before the child table is retired, so new walkers
cannot acquire it while existing RCU-protected walkers can safely
finish using it.

Apply the same lifetime rule to the root PGD. Unpublish the root with
WRITE_ONCE() and defer its free with call_rcu(). Keep pgd_levels
unchanged so a walker that observed the old root continues to use
matching page-table metadata.

Wait for pending G-stage page-table callbacks with rcu_barrier() when
the RISC-V KVM module exits so that they complete before the module is
unloaded.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 arch/riscv/include/asm/kvm_gstage.h |  2 +-
 arch/riscv/kvm/gstage.c             | 16 +++++++++++++++-
 arch/riscv/kvm/main.c               |  3 +++
 arch/riscv/kvm/mmu.c                | 16 +++++++++++++---
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index a03db1a10095..caeed6de6dbe 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -111,7 +111,7 @@ static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *
 	gstage->kvm = kvm;
 	gstage->flags = 0;
 	gstage->vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage->pgd = kvm->arch.pgd;
+	gstage->pgd = READ_ONCE(kvm->arch.pgd);
 	gstage->pgd_levels = kvm->arch.pgd_levels;
 }
 
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index f7e4756ce15b..fc39d188b20a 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -22,6 +22,20 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
 #define gstage_pte_leaf(__pte)	\
 	(pte_val(__pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
 
+static void gstage_free_page_table_rcu(struct rcu_head *head)
+{
+	put_page(container_of(head, struct page, rcu_head));
+}
+
+/*
+ * Defer freeing an unlinked page table until lockless walkers
+ * that may have observed it have exited.
+ */
+static void gstage_free_page_table(pte_t *table)
+{
+	call_rcu(&virt_to_page(table)->rcu_head, gstage_free_page_table_rcu);
+}
+
 static inline unsigned long gstage_pte_index(struct kvm_gstage *gstage,
 					     gpa_t addr, u32 level)
 {
@@ -406,7 +420,7 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 			flush |= kvm_riscv_gstage_op_pte(gstage, addr + i * next_page_size,
 							 &next_ptep[i], next_ptep_level, op);
 		if (op == GSTAGE_OP_CLEAR)
-			put_page(virt_to_page(next_ptep));
+			gstage_free_page_table(next_ptep);
 	} else {
 		if (op == GSTAGE_OP_CLEAR) {
 			set_pte(ptep, __pte(0));
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 89568ccce01d..5fcf425f7150 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -262,6 +262,9 @@ static void __exit riscv_kvm_exit(void)
 {
 	kvm_exit();
 
+	/* Wait for pending G-stage page-table RCU callbacks. */
+	rcu_barrier();
+
 	/* Unregister CPU PM notifier */
 	if (IS_ENABLED(CONFIG_CPU_PM))
 		cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 342f606399e5..8aed69abf814 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -761,6 +761,13 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
 	return 0;
 }
 
+static void kvm_riscv_mmu_free_pgd_rcu(struct rcu_head *head)
+{
+	struct page *page = container_of(head, struct page, rcu_head);
+
+	__free_pages(page, get_order(kvm_riscv_gstage_pgd_size));
+}
+
 void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 {
 	struct kvm_gstage gstage;
@@ -773,9 +780,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 		flush = kvm_riscv_gstage_unmap_range(&gstage, 0UL,
 			kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), false);
 		pgd = READ_ONCE(kvm->arch.pgd);
-		kvm->arch.pgd = NULL;
+		/*
+		 * Keep pgd_levels unchanged for lockless walkers that already
+		 * observed the old root.
+		 */
+		WRITE_ONCE(kvm->arch.pgd, NULL);
 		kvm->arch.pgd_phys = 0;
-		kvm->arch.pgd_levels = 0;
 	}
 	write_unlock(&kvm->mmu_lock);
 
@@ -783,7 +793,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 		kvm_flush_remote_tlbs(kvm);
 
 	if (pgd)
-		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
+		call_rcu(&virt_to_page(pgd)->rcu_head, kvm_riscv_mmu_free_pgd_rcu);
 
 	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }
-- 
2.52.0

