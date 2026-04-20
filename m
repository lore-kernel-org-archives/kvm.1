Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609063D16E4
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720034; cv=none; b=VXikxZgZBKCveNEtPE4g9GbeqQEXcgSe9+0MkSLDEGG1QvX8yjOYOfdwOoDUjpVri+vW2NZAiIIiYAnPqD6HD7XDkyGRmh8icXFR0iPe7NQj0QrU9XQCyPS2h9UMVwWjszwb4cAFNyxHuKvIedHQ9j1SthFEi/394l86cFG86zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720034; c=relaxed/simple;
	bh=mb+Nn3p0Uzuy35nGrZapWWOFGcfhqDSHDi2T03ag70g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dGJFA2oH9u6OqSYOmsxguLExTojSdujVm+gqHd6ym3l6gJZswBymgqVb5AlgwLSONHfnvfyf8Qa6tLEtsZOVhuklRR6zNDgwfyLfNd6JdnGjybfCVYXAOkWAgXL6hoOQQM/kcTMerx7wzgB0ZalFRCAgqO/kDwSJGCJwlhzKnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgu7vYUX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgu7vYUX"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so2455395a12.1
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776720029; x=1777324829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/wqyOTzheuJxJ8S4g/++8igtrJuOvPAFVCvhgsDhrq0=;
        b=dgu7vYUX2SWBhoRxpeUws96LPbZghjmTy6ax5H399WRsiw1W6dFkIBAZx/S7iuLmMH
         I2mfxmbhbbV7fWff4MvPkKwyjF4ByjTPghbkRxAlXuhJTmZk8E/ytSI2Rxd+NZKaH4c9
         OTdlFOIn+p2hXCr7SvzWhHw6N2/Oef8CceFe0ZHSKegXYNXi1yF8TByoIXiXvLycbsRP
         eL/L1eZNYYe3G92F0dNwJQ5IX0f2rFDpiF/MexU7i1oa05WSyTbyv/BW7IZZGHn+GMb7
         UCDM+cCNSBXunTSeLH18tEZstrZCYHmFR3l7vWcXE3Pz1IWfDymgZRVvm0LXys3xizC2
         29MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720029; x=1777324829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wqyOTzheuJxJ8S4g/++8igtrJuOvPAFVCvhgsDhrq0=;
        b=Gzq9q0th8l0bAfiEScxln01sIL6HyCyLCLDX/PLJ/Tghw12Hk51m3G7Xa9/cobHhuy
         FqG4LHyiuo+St3yvxef1SFHCFKe2ovjBu1HYx6dETkXS4PjQbmnCMmsHTi75tHSnKqJY
         2YBm0/ETKR8j94THXkP9gJF7eH9etwsTp6OeWlLGzhlTeQAtEHqhnzdCSDBT1GZPiDmO
         3coMUXqlVic+CDweephGJwgD1ic28PhCAaWGfKEzIGkkXvqotP/fhEVEsaVliri5L/IL
         w3KYSFfZadoJcmXQZGS6BXVxySf1P9xlD/iJ5vIevEqa5YeqkkHndDVZHoC2hEkLyaad
         6eeg==
X-Gm-Message-State: AOJu0Yy1Vh7A5R6FoqjoLHaUldcpUDk49+cHI0YNa2LyV57hWaOYqiSk
	05WEygcqOhI7e9ARWkt4xI2hq3QsELY8d2v2jMTEZ2+ZqPXvmQohyNyg3+PbVmpvLlDxpMJG1rf
	XDEQ9+A==
X-Received: from pgiz3.prod.google.com ([2002:a63:c043:0:b0:c79:65cb:1f76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2584:b0:39f:c93e:c7f7
 with SMTP id adf61e73a8af0-3a08c626f18mr12869336637.0.1776720029334; Mon, 20
 Apr 2026 14:20:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 Apr 2026 14:19:57 -0700
In-Reply-To: <20260420212004.3938325-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420212004.3938325-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420212004.3938325-13-seanjc@google.com>
Subject: [PATCH v3 12/19] KVM: selftests: Rename vm_vaddr_unused_gap() => vm_unused_gva_gap()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM selftests use gva_t instead of vm_vaddr_t, rename the API
for finding an unused range of virtual memory to drop the defunct
terminology and use "vm" for the scope.

Opportunistically clean up the function comment to drop superfluous
and redundant information.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
 tools/testing/selftests/kvm/lib/arm64/ucall.c |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++---------------
 .../selftests/kvm/lib/loongarch/ucall.c       |  2 +-
 .../selftests/kvm/x86/hyperv_tlb_flush.c      |  2 +-
 5 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8f7afc34ea8d..0239e89320e5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -715,7 +715,7 @@ void vm_mem_region_move(struct kvm_vm *vm, u32 slot, u64 new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, u32 slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id);
 void vm_populate_vaddr_bitmap(struct kvm_vm *vm);
-gva_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, gva_t vaddr_min);
+gva_t vm_unused_gva_gap(struct kvm_vm *vm, size_t sz, gva_t vaddr_min);
 gva_t vm_alloc(struct kvm_vm *vm, size_t sz, gva_t vaddr_min);
 gva_t __vm_alloc(struct kvm_vm *vm, size_t sz, gva_t vaddr_min,
 		 enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/arm64/ucall.c b/tools/testing/selftests/kvm/lib/arm64/ucall.c
index 8257dc4ae106..e0550ad5aa75 100644
--- a/tools/testing/selftests/kvm/lib/arm64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/arm64/ucall.c
@@ -10,7 +10,7 @@ gva_t *ucall_exit_mmio_addr;
 
 void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
 {
-	gva_t mmio_gva = vm_vaddr_unused_gap(vm, vm->page_size, KVM_UTIL_MIN_VADDR);
+	gva_t mmio_gva = vm_unused_gva_gap(vm, vm->page_size, KVM_UTIL_MIN_VADDR);
 
 	virt_map(vm, mmio_gva, mmio_gpa, 1);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b304c0e54837..8c82b40a7448 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1366,26 +1366,12 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 }
 
 /*
- * VM Virtual Address Unused Gap
- *
- * Input Args:
- *   vm - Virtual Machine
- *   sz - Size (bytes)
- *   vaddr_min - Minimum Virtual Address
- *
- * Output Args: None
- *
- * Return:
- *   Lowest virtual address at or above vaddr_min, with at least
- *   sz unused bytes.  TEST_ASSERT failure if no area of at least
- *   size sz is available.
- *
- * Within the VM specified by vm, locates the lowest starting virtual
- * address >= vaddr_min, that has at least sz unallocated bytes.  A
+ * Within the VM specified by @vm, locates the lowest starting guest virtual
+ * address >= @vaddr_min, that has at least @sz unallocated bytes.  A
  * TEST_ASSERT failure occurs for invalid input or no area of at least
- * sz unallocated bytes >= vaddr_min is available.
+ * @sz unallocated bytes >= @min_gva is available.
  */
-gva_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, gva_t vaddr_min)
+gva_t vm_unused_gva_gap(struct kvm_vm *vm, size_t sz, gva_t vaddr_min)
 {
 	u64 pages = (sz + vm->page_size - 1) >> vm->page_shift;
 
@@ -1464,7 +1450,7 @@ static gva_t ____vm_alloc(struct kvm_vm *vm, size_t sz, gva_t vaddr_min,
 	 * Find an unused range of virtual page addresses of at least
 	 * pages in length.
 	 */
-	gva_t vaddr_start = vm_vaddr_unused_gap(vm, sz, vaddr_min);
+	gva_t vaddr_start = vm_unused_gva_gap(vm, sz, vaddr_min);
 
 	/* Map the virtual pages. */
 	for (gva_t vaddr = vaddr_start; pages > 0;
diff --git a/tools/testing/selftests/kvm/lib/loongarch/ucall.c b/tools/testing/selftests/kvm/lib/loongarch/ucall.c
index eb9f714a535c..cd49a3440ead 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/ucall.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/ucall.c
@@ -13,7 +13,7 @@ gva_t *ucall_exit_mmio_addr;
 
 void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
 {
-	gva_t mmio_gva = vm_vaddr_unused_gap(vm, vm->page_size, KVM_UTIL_MIN_VADDR);
+	gva_t mmio_gva = vm_unused_gva_gap(vm, vm->page_size, KVM_UTIL_MIN_VADDR);
 
 	virt_map(vm, mmio_gva, mmio_gpa, 1);
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
index 6adf76574921..15ee8b7bfc11 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
@@ -617,7 +617,7 @@ int main(int argc, char *argv[])
 	 * Get PTE pointers for test pages and map them inside the guest.
 	 * Use separate page for each PTE for simplicity.
 	 */
-	gva = vm_vaddr_unused_gap(vm, NTEST_PAGES * PAGE_SIZE, KVM_UTIL_MIN_VADDR);
+	gva = vm_unused_gva_gap(vm, NTEST_PAGES * PAGE_SIZE, KVM_UTIL_MIN_VADDR);
 	for (i = 0; i < NTEST_PAGES; i++) {
 		pte = vm_get_pte(vm, data->test_pages + i * PAGE_SIZE);
 		gpa = addr_hva2gpa(vm, pte);
-- 
2.54.0.rc1.555.g9c883467ad-goog

