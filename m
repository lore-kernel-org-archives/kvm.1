Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD12446056
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225726; cv=none; b=OBZHMe297GJv7D3snaEANAavKEtChvI3x4Om34ifrhevBqQUA2E8eFZTBZzIn3pXdZoG0MwYDbqujy4XHkhXVfnisHnoJ7t7LlgI7GXJLTXR1X8u3Hf2KfNIE7x4hAm52Ixg+JISc2HDJFRXp/zjY5gRCVKGxgX7HSWtHXg6Rwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225726; c=relaxed/simple;
	bh=X2Mp5tqWG/hlLXxMeFeNp6AJ24Jm10L1p4PmCQnTdF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPeRxrdA7D5VxspWj3I/2R7ooIiAmrxAhTycN44c9fEsg2o4DJ4ojmKsNBhasjoOl13CEsQjoYRh3F1XjXX7m2LwvYTAu1Skn7spjt5ZmG1yhbfsW0XqWkdtalPw1VKKHw/4yM7S893OTQGWzvflLLhpJnx3914WNg4RYlqqEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLRYTpGQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLRYTpGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf+r9m213uUwsm4gz+90/tHgCey5uMsxmGmIjXRW02Q=;
	b=FLRYTpGQ+skqg2Kttf19XZA+e7Vnzi9C8GJzH0udwROd1+4QNI0Ysz0Mtw+ALka/HXnqPq
	tWyxIxfrMPWv4ZRmJHl6NBu9n06dGlFqKLXLFtE2DUf7jdh2XxsXSAIjml9fBkOOdWxSM0
	BwynHZOcx2DhnDM+S2JB7zt0dFFqNT4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-oXL4oLieOqeyirX-Tcubsw-1; Thu,
 16 Jul 2026 14:15:14 -0400
X-MC-Unique: oXL4oLieOqeyirX-Tcubsw-1
X-Mimecast-MFC-AGG-ID: oXL4oLieOqeyirX-Tcubsw_1784225713
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 597B31955E75;
	Thu, 16 Jul 2026 18:15:13 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB946195604E;
	Thu, 16 Jul 2026 18:15:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 23/24] KVM: x86: selftests: Introduce memory attributes PTE test
Date: Thu, 16 Jul 2026 14:14:55 -0400
Message-ID: <20260716181456.402786-24-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Introduce the memory attributes PTE tests. This test confirms the
behaviour of memory attributes access restrictions when installed on a
page that holds guest page table entries. Notably two cases are taken
into account:
- The page is made non-accesible. In such case the next access to a
  virtual memory address translated by that paging structure should
  fault.
- The page is made read-only. In such case the next access to a virtual
  memory address translated by that paging structure should either fault
  or succeed yet not perform any writes into the PTE (accessed and
  dirty bits).

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../testing/selftests/kvm/memory_attributes.c |  38 +++++-
 .../selftests/kvm/x86/memory_attributes.c     | 126 ++++++++++++++++++
 2 files changed, 162 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/testing/selftests/kvm/memory_attributes.c
index 7066ae791b99..c66d5d085a9c 100644
--- a/tools/testing/selftests/kvm/memory_attributes.c
+++ b/tools/testing/selftests/kvm/memory_attributes.c
@@ -22,11 +22,16 @@
 #define MMIO_GPA	0x700000000
 #define MMIO_GVA	MMIO_GPA
 
+#define PT_WRITABLE_MASK	BIT_ULL(1)
+#define PT_ACCESSED_MASK	BIT_ULL(5)
+#define PTE_VADDR		0x1000000000
+
 enum {
 	TEST_OP_NOP,
 	TEST_OP_READ,
 	TEST_OP_WRITE,
 	TEST_OP_EXEC,
+	TEST_OP_INVPLG,
 	TEST_OP_EXIT,
 };
 
@@ -35,6 +40,7 @@ const char *test_op_names[] =
 	[TEST_OP_READ] = "Read",
 	[TEST_OP_WRITE] = "Write",
 	[TEST_OP_EXEC] = "Exec",
+	[TEST_OP_INVPLG] = "Invplg",
 	[TEST_OP_EXIT] = "Exit",
 };
 
@@ -42,6 +48,7 @@ struct test_data {
 	uint8_t op;
 	int stage;
 	gva_t vaddr;
+	uint64_t expected_val;
 
 	struct kvm_vcpu *vcpu;
 };
@@ -59,6 +66,7 @@ static void guest_code(void *data)
 	int stage = 1;
 
 	while (true) {
+		uint64_t expected_val = READ_ONCE(test_data->expected_val);
 		gva_t vaddr = READ_ONCE(test_data->vaddr);
 
 		switch(READ_ONCE(test_data->op)) {
@@ -67,13 +75,20 @@ static void guest_code(void *data)
 			GUEST_SYNC(stage++);
 			break;
 		case TEST_OP_WRITE:
-			arch_controlled_write(vaddr, 1);
+			arch_controlled_write(vaddr, expected_val);
 			GUEST_SYNC(stage++);
 			break;
 		case TEST_OP_EXEC:
 			arch_controlled_exec(vaddr);
 			GUEST_SYNC(stage++);
 			break;
+#ifdef __x86_64__
+		case TEST_OP_INVPLG:
+			asm volatile("invlpg (%0)"
+				     :: "b" (vaddr): "memory");
+			GUEST_SYNC(stage++);
+			break;
+#endif
 		default:
 			goto exit;
 		};
@@ -106,6 +121,21 @@ static void vcpu_run_and_inc_stage(struct kvm_vcpu *vcpu)
 	test_data->stage++;
 }
 
+static int test_page(struct kvm_vcpu *vcpu, int op, gva_t vaddr)
+{
+	int rc;
+
+	test_data->op = op;
+	test_data->vaddr = vaddr;
+
+	rc = _vcpu_run(vcpu);
+
+	if (rc >= 0)
+		test_data->stage++;
+
+	return rc < 0 ? -errno : rc;
+}
+
 static void test_page_restricted(struct kvm_vcpu *vcpu, int op,
 				 gva_t vaddr, gpa_t fault_paddr,
 				 uint64_t fault_reason)
@@ -122,7 +152,8 @@ static void test_page_restricted(struct kvm_vcpu *vcpu, int op,
 		    test_op_names[op], rc, errno);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MEMORY_FAULT);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, fault_paddr);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, fault_reason);
+	if (fault_reason)
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, fault_reason);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, vm->page_size);
 }
 
@@ -355,6 +386,9 @@ int main(int argc, char *argv[])
 	test_input_validation(vm);
 	test_memory_access(vcpu, test_mem, size);
 	test_memattrs_ignore_mmio(vcpu);
+#ifdef __x86_64__
+	arch_test_memory_access_pte(vcpu, test_mem);
+#endif
 	test_finalize(vcpu);
 
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/testing/selftests/kvm/x86/memory_attributes.c
index 2e1148f5146d..3d2bcfe71884 100644
--- a/tools/testing/selftests/kvm/x86/memory_attributes.c
+++ b/tools/testing/selftests/kvm/x86/memory_attributes.c
@@ -41,3 +41,129 @@ void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr)
 {
 	memset(addr_gpa2hva(vm, vaddr), 0xc3, 1);
 }
+
+/*
+ * This test validates that, during a page walk, if the page a PTE is placed in
+ * is read-only the accesss and dirty bits will not be written. Note There's a
+ * slight variation in behaviour between TDP and non-TDP VMs:
+ *  - With TDP enabled, KVM issues a fault exit upon observing the non-writable
+ *  page.
+ *  - With non-TDP, the access bit is not set, but the walk succeeds.
+ *
+ *  This is aligned with read-only memslots' behaviour.
+ */
+static void test_memory_access_pte_ro(struct kvm_vcpu *vcpu, gva_t vaddr)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gpa_t paddr;
+	u64 *pte;
+	const u64 accessed_mask = PTE_ACCESSED_MASK(&vm->mmu);
+
+	pte = vm_get_pte(vm, vaddr);
+	paddr = addr_hva2gpa(vm, pte) & GENMASK(61, vm->page_shift);
+
+	*pte &= ~accessed_mask;
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NW);
+	if (test_page(vcpu, TEST_OP_READ, vaddr) < 0) {
+		test_page_restricted(vcpu, TEST_OP_READ, vaddr, paddr,
+				     /* write PTE's accessed bit */
+				     KVM_MEMORY_EXIT_FLAG_WRITE);
+
+		vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+		test_page_accessible(vcpu, TEST_OP_READ, vaddr);
+		TEST_ASSERT_EQ(*pte & accessed_mask, accessed_mask);
+
+		/* Re-run the test, now vaddr is backed by an EPT. */
+		*pte &= ~accessed_mask;
+		vm_set_memory_attributes(vm, paddr, vm->page_size,
+					 KVM_MEMORY_ATTRIBUTE_NW);
+		test_page_restricted(vcpu, TEST_OP_READ, vaddr, paddr,
+				     /* write PTE's accessed bit */
+				     KVM_MEMORY_EXIT_FLAG_WRITE);
+		vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+		test_page_accessible(vcpu, TEST_OP_READ, vaddr);
+	} else {
+		TEST_ASSERT_EQ(*pte & accessed_mask, 0);
+		vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+	}
+}
+
+/*
+ * This test validates that, during a page walk, if the page a PTE is placed in
+ * is maked as non-accesible, KVM issues a fault exit.
+ */
+static void test_memory_access_pte_nr(struct kvm_vcpu *vcpu, gva_t vaddr)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gpa_t paddr;
+	uint64_t *pte;
+
+	pte = vm_get_pte(vm, vaddr);
+	paddr = addr_hva2gpa(vm, pte) & GENMASK(61, vm->page_shift);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size,
+				 KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
+
+	test_page_restricted(vcpu, TEST_OP_READ, vaddr, paddr, 0);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+	test_page_accessible(vcpu, TEST_OP_READ, vaddr);
+
+	/* Re-run the test, now vaddr is backed by an SPTE. */
+	vm_set_memory_attributes(vm, paddr, vm->page_size,
+				 KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
+	test_page_restricted(vcpu, TEST_OP_READ, vaddr, paddr, 0);
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+	test_page_accessible(vcpu, TEST_OP_READ, vaddr);
+}
+
+static void test_memory_access_sync_spte(struct kvm_vcpu *vcpu, gva_t vaddr)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gpa_t paddr = addr_gva2gpa(vm, vaddr);
+	uint64_t *pte, old_pte, new_pte;
+
+	pte = vm_get_pte(vm, vaddr);
+	gpa_t pte_paddr = addr_hva2gpa(vm, pte);
+	gpa_t pte_page_paddr = pte_paddr & GENMASK(61, vm->page_shift);
+	int pte_offset = pte_paddr - pte_page_paddr;
+	virt_pg_map(vm, PTE_VADDR, pte_page_paddr);
+	old_pte = *pte;
+
+	/* Set vmaddr as non-executable */
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NX);
+
+	/*
+	 * Make sure SPTEs are populated as previous op might have destroyed
+	 * them. We new have a non-executable SPTE.
+	 */
+	test_page_accessible(vcpu, TEST_OP_READ, vaddr);
+
+	/*
+	 * Update PTE, make it non-writable and flush TLBs to make sure we go
+	 * through the sync_spte path. This should update the SPTE and make it
+	 * read-only.
+	 */
+	new_pte = (old_pte & ~PT_WRITABLE_MASK) | PT_ACCESSED_MASK;
+	test_data->expected_val = new_pte;
+	test_page_accessible(vcpu, TEST_OP_WRITE, PTE_VADDR + pte_offset);
+	TEST_ASSERT_EQ(*pte, new_pte);
+	test_page_accessible(vcpu, TEST_OP_INVPLG, vaddr);
+
+	/* The not executable attrs remain valid */
+	arch_write_return_insn(vm, vaddr);
+	test_page_restricted(vcpu, TEST_OP_EXEC, vaddr, paddr,
+			     KVM_MEMORY_EXIT_FLAG_EXEC);
+
+	/* Cleanup */
+	*pte = old_pte;
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+	test_page_accessible(vcpu, TEST_OP_EXEC, vaddr);
+}
+
+static void arch_test_memory_access_pte(struct kvm_vcpu *vcpu, gva_t vaddr)
+{
+	test_memory_access_pte_nr(vcpu, vaddr);
+	test_memory_access_pte_ro(vcpu, vaddr);
+	test_memory_access_sync_spte(vcpu, vaddr);
+}
-- 
2.52.0


