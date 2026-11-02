Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641536;
	b=se1GwkqndRe1aLU4LgP+AO28Dqb7APLnVr0AqtdHWMczu3Mwmhyy+47bwAhA+rA+Tm5v
	 5y8rtU8xKl8rgOI4Sp3jVfItbTr1TKlIX1sFHHEY//CkEhvt9LX/+hNJDyoN95HI57QGj
	 OSnv8b44Kc91A1D+DYEaE5QHhanAP6SBepyny3XjtfH5tK9sAXgzgkWCOZkvY5nKhj78O
	 cH2l7ssJ7gN6aCul3Y1f+c8TRkD8vSXeNww7RQ6mNbkLr76efTRdALjs+CWWpc554nSSg
	 Q0yv5OPyHdo01lkFr9/cgZyxpl/+Zp8sACNOnuqrg0RWOFKfajDjXi4MCR1w/G7iDjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641536;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ffmcrLPSQBc8LZq3N2iNF6jPSXHVkE7QzH/ZeXvH5Jk=;
	b=oMQtzqNkaKsj3n7Jxs/BNT3MeHk0n4ukrhIPV8ELV+ic5+VsyrXYs5JWL27nTG+L0avs
	 bdXEsaYY1mXg0WHDHDHFg9wfDQp20z/x5GE04XvlO+8sNoxHwYCTSa0APTYyd4Ytg2lYG
	 m1kJw1LJvk6BR3QsAPajIGoViB+8z1mvmsevOfOfYtHQbk7KlnCffnaxDjednNrXyRUcB
	 IlDVVQsFNw2NFxxzPT2+sPPzHN1w1YjIlgnIizwiBX9+yyswk0p01I//9c929LIBaAJq9
	 8cjUZD1EyPSYWpZMrKlY69JXIp9plRshi6Ga1tsKPT7eiRGqr0PTqe7Ubvotc/p0GTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KOQps1KF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E82607DA8B
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E82607DA8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KOQps1KF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffmcrLPSQBc8LZq3N2iNF6jPSXHVkE7QzH/ZeXvH5Jk=;
	b=KOQps1KFgPQdV/MZhmkHvxDs8B19QqdD5so1X0ZEC1A6ltbX5Iatf0ySVIF8VqjoURlJJ5
	a0AcGqr/4o57q/rcsNCE7ZyqguoWU+k85Wutiun+Pm2F08ThZGNAxlkhMzQ78Vj5bTcitS
	ZPrngke1aCrIOWgjZoauMXVZoQgK9Ds=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-v8HilWD9MMuLLP6l3GG-0w-1; Mon,
 02 Nov 2026 12:45:32 -0500
X-MC-Unique: v8HilWD9MMuLLP6l3GG-0w-1
X-Mimecast-MFC-AGG-ID: v8HilWD9MMuLLP6l3GG-0w_1793641531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B32D1956051;
	Mon,  2 Nov 2026 17:45:31 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD1431800347;
	Mon,  2 Nov 2026 17:45:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 43/45] KVM: x86: selftests: Introduce memory attributes PTE test
Date: Mon,  2 Nov 2026 12:45:10 -0500
Message-ID: <20261102174512.8903-27-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add more memory attributes tests to check that memory protection
restricts accesses even when installed on a page that holds guest page
table entries. Notably two cases are taken into account:
- The page is made non-accesible. In such case the next access to a
  virtual memory address translated by that paging structure should
  fault.
- The page is made read-only. In such case the next access to a virtual
  memory address translated by that paging structure should either fault,
  or succeed yet not perform any writes into the PTE (accessed and
  dirty bits).

Co-developed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-31-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../testing/selftests/kvm/memory_attributes.c |  39 ++++-
 .../selftests/kvm/x86/memory_attributes.c     | 144 +++++++++++++++++-
 2 files changed, 177 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/testing/selftests/kvm/memory_attributes.c
index 81ec59382f55..c5305b4f3dbe 100644
--- a/tools/testing/selftests/kvm/memory_attributes.c
+++ b/tools/testing/selftests/kvm/memory_attributes.c
@@ -25,11 +25,16 @@
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
 
@@ -38,6 +43,7 @@ const char *test_op_names[] =
 	[TEST_OP_READ] = "Read",
 	[TEST_OP_WRITE] = "Write",
 	[TEST_OP_EXEC] = "Exec",
+	[TEST_OP_INVPLG] = "Invplg",
 	[TEST_OP_EXIT] = "Exit",
 };
 
@@ -45,6 +51,7 @@ struct test_data {
 	uint8_t op;
 	int stage;
 	gva_t vaddr;
+	uint64_t expected_val;
 
 	struct kvm_vcpu *vcpu;
 };
@@ -54,7 +61,8 @@ static struct test_data *test_data;
 static uint64_t arch_controlled_read(gva_t addr);
 static void arch_controlled_write(gva_t addr, uint64_t val);
 static void arch_controlled_exec(gva_t addr);
-static void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr);
+static void arch_write_return_insn(struct kvm_vm *vm, gpa_t paddr);
+static bool arch_test_op(struct test_data *test_data);
 
 static void guest_code(void *data)
 {
@@ -62,6 +70,7 @@ static void guest_code(void *data)
 	int stage = 1;
 
 	while (true) {
+		uint64_t expected_val = READ_ONCE(test_data->expected_val);
 		gva_t vaddr = READ_ONCE(test_data->vaddr);
 
 		switch(READ_ONCE(test_data->op)) {
@@ -70,7 +79,7 @@ static void guest_code(void *data)
 			GUEST_SYNC(stage++);
 			break;
 		case TEST_OP_WRITE:
-			arch_controlled_write(vaddr, 1);
+			arch_controlled_write(vaddr, expected_val);
 			GUEST_SYNC(stage++);
 			break;
 		case TEST_OP_EXEC:
@@ -78,7 +87,10 @@ static void guest_code(void *data)
 			GUEST_SYNC(stage++);
 			break;
 		default:
-			goto exit;
+			if (!arch_test_op(test_data))
+				goto exit;
+			GUEST_SYNC(stage++);
+			break;
 		};
 	}
 
@@ -109,6 +121,21 @@ static void vcpu_run_and_inc_stage(struct kvm_vcpu *vcpu)
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
@@ -125,7 +152,8 @@ static void test_page_restricted(struct kvm_vcpu *vcpu, int op,
 		    test_op_names[op], rc, errno);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MEMORY_FAULT);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, fault_paddr);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, fault_reason);
+	if (fault_reason)
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, fault_reason);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, vm->page_size);
 }
 
@@ -337,6 +365,9 @@ int main(int argc, char *argv[])
 
 	test_input_validation(vm);
 	test_memory_access(vcpu, test_mem, size);
+#ifdef __x86_64__
+	arch_test_memory_access_pte(vcpu, test_mem);
+#endif
 	test_finalize(vcpu);
 
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/testing/selftests/kvm/x86/memory_attributes.c
index 2e1148f5146d..12395feb6ac7 100644
--- a/tools/testing/selftests/kvm/x86/memory_attributes.c
+++ b/tools/testing/selftests/kvm/x86/memory_attributes.c
@@ -37,7 +37,147 @@ void arch_controlled_exec(gva_t addr)
 		     : "memory", "rax");
 }
 
-void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr)
+void arch_write_return_insn(struct kvm_vm *vm, gpa_t paddr)
 {
-	memset(addr_gpa2hva(vm, vaddr), 0xc3, 1);
+	memset(addr_gpa2hva(vm, paddr), 0xc3, 1);
+}
+
+bool arch_test_op(struct test_data *test_data)
+{
+	gva_t vaddr = READ_ONCE(test_data->vaddr);
+
+	switch(READ_ONCE(test_data->op)) {
+	case TEST_OP_INVPLG:
+		asm volatile("invlpg (%0)"
+			     :: "b" (vaddr): "memory");
+		return true;
+	default:
+		return false;
+	}
+}
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
+	arch_write_return_insn(vm, paddr);
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
 }
-- 
2.52.0


