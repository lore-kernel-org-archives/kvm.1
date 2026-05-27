Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA03FF8B5
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886262; cv=none; b=Y/6HCosMlmagzQfDot5AxR/Z9F7UQFIZtoCU7XPKfIB5Dme/eOczKA15G4MsxFdDJo7QYgQ/Ln94bmiRjj243rxY9qSudoxQmgn1Dg3usV9hrQcb3XBw+aSZJnAIIjPfxN7ey54Fs87Nj4x0wqqgCWeKIAGTo1kVwFj1qOjYS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886262; c=relaxed/simple;
	bh=837FnyDbpS/a1PEWC/Inqc4NqRHxMIbFt3S85zcWWtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umOU9rGWgAOyWMmdqVKIHTpVoJxz63wLR3ha2dzT1TahU/yRZ2z70dcUxGxq/r+bm1yboawRNPZe/Bp2AFbehDwm8fp2MvYx9YCMN4yHfkkAtH/gRsy1MUP07weK8rkRzgBQyeZFE/pDnd3X7PFJqhqKMo8i7hIjihBHyBQPBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FujwVX6l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FujwVX6l"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2be1dd4af34so104202895ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886261; x=1780491061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/w1Ny+GkWjJd36xIuiCWajcu8GK6fBsl49miGPD7vg=;
        b=FujwVX6lvoZq3VWsWSMMOYE8JF7piHSep9OjK5sU4X1CJpM1hG9rMNTrwGTj3Ew9/V
         1YI0jNc9lZQbXpyTwACdrmn/QyQJzaey8A4lcgk1KrxcNUoU4njV7UnHElU5R87xxcQu
         Ig1ND6BJiYTeAzV7jCcUsEqdVu+aCDTNQl9PpHWoF7ulBTYmVmYd62fkRWi6LkqhKpwt
         cWpnUadDNYZAFxdVpfwQlB+MXYdtwrevYAPcAAGnTUxNEfeN3iVS7Tvj6ZBeXOYEe6US
         QeGf81Ujqh8z35gSZsABTDalbBC7FG9I0LVenM7HXi42pEc7hcGQWCiBCMjzGkoFo4cm
         NgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886261; x=1780491061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/w1Ny+GkWjJd36xIuiCWajcu8GK6fBsl49miGPD7vg=;
        b=gmLS+LoWLexW+eEKyauSI7aHaWwfMI0vqjIx8gAihNsMtT6BLcq8DRHprQkNQt9LDo
         BsPj5ZveqbqFioP87EV5R/m3H/6sVBEUaCnzoDsWR1Ntmr+s/MPcHZC3/P+/NusLCiw5
         YATciJ3bkxZrhKiBDkYHxCt1TVqtS/tSRM5vdnt75Nbtw2F050V1wWrLPcvaoh7XKXwR
         X7Yu/NabffN+Iud4fCBDM1VHf8/R1p4qUqVkRoxIzE0c7ewMqbUbzqhr0LgULFkTZNsJ
         iRLlzDDfQWL7oseUzc9j3ntr3UnIBoSedTC7mp10ytdcvHzg6osqORB1mMxHGXlrhvmC
         2DJA==
X-Gm-Message-State: AOJu0YyC84/0DOUJRmCbNXatR/8Bid6gblzpbcu/gvnPCkPdJoFK1aRS
	U+Tu9C/+xBVUzpjIL6wkm6WS2tOXsf1EeJ8rzHLMu9yYvsTXxA6WQOxA0HaEmg==
X-Gm-Gg: Acq92OGz5Pi3vA/4D+0Cssm1GP5FEHgD+38qd+M9dbRrd6U4d1Jnqq41nKubuSqb+7D
	Jm6xH//rCv9vimVBi4KM05W5XuFSigCo+aMMbcsPjGRAvt9euIFkTxh5AGaATN/INeLS9w3Qa+h
	fb+w4onwaIkqwfN6nR0+OyGRlFkBnPX0N16/VpuRrqItDCOP8n8TOQxKyyXDTESztG4w9YM+mx8
	YXHh8W8mtvZvLT90M43o+M3R0G6q3vtJAJ+ENCdXua6zCFqz427olDgf2sy3ns1+1rXjcMwZt5O
	qk82fd+OyShbqcL4CQ3qc89wBy5pDdIVxX8eBzuqzVnYWbNdPuS2CW2Z2KIQQbggotUWccSktwc
	4G2BWcGikN0KDiWWXP3KwFqSMOpJk0Z9C0iSpDk7CogU6a+tABmcrmuthDOoXS/YDuuoKIaat90
	WIsmYBZlbToe6mHqJrtGMQn98Vl37oifXyRl4lb6g=
X-Received: by 2002:a17:903:2f4f:b0:2b4:5f69:715d with SMTP id d9443c01a7336-2beb05d9d8emr260493225ad.25.1779886261058;
        Wed, 27 May 2026 05:51:01 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:51:00 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 10/10] KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and gva_t
Date: Wed, 27 May 2026 18:19:59 +0530
Message-ID: <bfac43765a97ea184a1bc7e7ab51e322b41401a2.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit df079910f9814 ("KVM: selftests: Replace "u64 gpa" with "gpa_t" throughout")
commit 014dfb7b9bf3f ("KVM: selftests: Replace "vaddr" with "gva" throughout")

Similar to above 2 commits, this patch makes the relevant changes to
powerpc kvm selftests code to make use of gpa_t and gva_t types instead
of u64 throughout the code.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../selftests/kvm/include/powerpc/processor.h |  3 ++-
 .../selftests/kvm/lib/powerpc/processor.c     | 20 +++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index 95ec3debc83c..f0ee21a8e2d4 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -7,6 +7,7 @@
 
 #include <linux/compiler.h>
 #include "ppc_asm.h"
+#include "kvm_util_types.h"
 
 extern unsigned char __interrupts_start[];
 extern unsigned char __interrupts_end[];
@@ -24,7 +25,7 @@ struct ex_regs {
 	u64	xer;
 	u32	cr;
 	u32	trap;
-	u64	vaddr; /* vaddr of this struct */
+	gva_t	gva; /* gva of this struct */
 };
 
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 2c1e95c8aa9c..009a0859ba05 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -97,17 +97,17 @@ static u64 pt_entry_coverage(struct kvm_vm *vm, int level)
 	return size;
 }
 
-static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
+static int pt_idx(struct kvm_vm *vm, gva_t gva, int level, u64 *nls)
 {
 	switch (level) {
 	case 1:
 		if (nls)
 			*nls = 0x9;
-		return (vaddr >> 39) & 0x1fff;
+		return (gva >> 39) & 0x1fff;
 	case 2:
 		if (nls)
 			*nls = 0x9;
-		return (vaddr >> 30) & 0x1ff;
+		return (gva >> 30) & 0x1ff;
 	case 3:
 		if (vm->mode == VM_MODE_P52V52_4K) {
 			if (nls)
@@ -116,12 +116,12 @@ static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 			if (nls)
 				*nls = 0x5;
 		}
-		return (vaddr >> 21) & 0x1ff;
+		return (gva >> 21) & 0x1ff;
 	case 4:
 		if (vm->mode == VM_MODE_P52V52_4K)
-			return (vaddr >> 12) & 0x1ff;
+			return (gva >> 12) & 0x1ff;
 		else /* vm->mode == VM_MODE_P52V52_64K */
-			return (vaddr >> 16) & 0x1f;
+			return (gva >> 16) & 0x1f;
 	default:
 		TEST_ASSERT(false, "Invalid page table level %d\n", level);
 		return 0;
@@ -129,9 +129,9 @@ static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 }
 
 static u64 *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
-			  u64 vaddr, int level, u64 *nls)
+			  gva_t gva, int level, u64 *nls)
 {
-	int idx = pt_idx(vm, vaddr, level, nls);
+	int idx = pt_idx(vm, gva, level, nls);
 	u64 *ptep = addr_gpa2hva(vm, pt + idx * 8);
 
 	return ptep;
@@ -189,7 +189,7 @@ static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
 	return pt;
 }
 
-void virt_arch_pg_map(struct kvm_vm *vm, u64 gva, u64 gpa)
+void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
 {
 	gpa_t pt = vm->mmu.pgd;
 	u64 *ptep, pte;
@@ -331,7 +331,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 				       MEM_REGION_DATA);
 	ex_regs_paddr = addr_gva2gpa(vm, ex_regs_vaddr);
 	ex_regs = addr_gpa2hva(vm, ex_regs_paddr);
-	ex_regs->vaddr = ex_regs_vaddr;
+	ex_regs->gva = ex_regs_vaddr;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 
-- 
2.39.5

