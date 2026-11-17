Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901483;
	b=HSk0PKS8nAnAJePsE39kgA3vXLnk9aOHe8iUyzZP55aTjz8ZmaSot3PKUptP8jfaem8N
	 rIPXdo+933auAAOkbEKga01pGhFMrn8px8Pgq3ScVDNWmEyoeF4DKTQnvMypZoPSA8bnU
	 eLt+1I6YwScQVUuDl6mEoQw2MpLVR5edG3s9aMQC0yBktLS+oiXnN+f3Fit6RjPwUsBC8
	 Uc/Z5yaDYe4k0kgEzGD+f12YJihXOJY1kI6QwX+A0jOjtudsc/bDIwY6rxz/Km4g47B/Y
	 K7QXpzlvPZYBwQWXK9Qts3JeXjHxSOphF4j+fdg0dVnrTgJ43tCt6jllh60V75GvCpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901483;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tXiO5EarY27CkofXoR84oUPiSJOHxCIl3llp7XgcGS4=;
	b=WiUt7AxqfD7fDswYwfekz/skx9T/Y7L68evpU+mCsduz/CBT8FidYz0u6V2UNoDwbcfN
	 gGKRuAiMbyCaQbThNZqazBuCX4fLAWOdnUJymbYrJ5LWQuvZYjvOE5O0HVMgPfHPEaEZn
	 71TMJpMF5/E4iVm8uvwx30SqPsvdQHYunxnMcCkv5R8CRDsDcOAwl9mKKkpkcGCV7F3jD
	 qrZk/wvuGjcB3//8atChvqJZ3MfMkm8zwOxS86Qn68eLZInjDdbOeAXZ+yFmC7ow0qPKi
	 AmOe48/lMpmK1XXfGJkftY1pyKISN9ZNvNkflVCJ9bd/k5JBbEQ+haQA5DBXDm5241g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EyRArXIN;
	arc=none smtp.remote-ip=91.218.175.189
Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579C606A329
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 07:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D579C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EyRArXIN
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IW5ynYIfi6Xr6T0cE9YbEpif7QMM3ckaJbRURkeLx6M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794901479; v=1; x=1795506279;
 b=EyRArXINeSswu1l1XnoTJArpiAVzjsKXhAXbde9QyZ1UVAR+AttMBN8hPWF1Gn6277d8MUz7
 VvTR4NmlN29of7IY4od3MQjS2+WvPwbVTXxVIuNryuCEKPdHwLDZlnnPylMFmhL4+m4h7u7Xu9G
 hNPLilohDyarlu96UqDqzOkE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9a9bc6f3d3d80109;
	Tue, 17 Nov 2026 07:44:39 +0000
X-Mizu-Trace-ID: 9a9bc6f3d3d80109
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v2 2/2] KVM: selftests: Test KVM_PRE_FAULT_MEMORY against a full dirty ring
Date: Tue, 17 Nov 2026 07:44:28 +0000
Message-ID: <20261117074428.7544-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117074428.7544-1-fuad.tabba@linux.dev>
References: <20261117074428.7544-1-fuad.tabba@linux.dev>
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

Pre-fault more populated, dirty-logged pages than the vCPU's dirty ring
holds, and check that each call stops before the ring overflows, that a
retry returns ENOSPC without progress, and that each page is reported
exactly once. A read pre-fault can map a page read-only, or
access-tracked on x86 without EPT A/D bits, so skip the case if
pre-faulting doesn't dirty any page.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 .../selftests/kvm/pre_fault_memory_test.c     | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 3082fe09b95fa..72c501afc873b 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -5,6 +5,9 @@
  * Author:
  * Isaku Yamahata <isaku.yamahata at gmail.com>
  */
+#include <asm/barrier.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/sizes.h>
 
 #include <test_util.h>
@@ -17,6 +20,8 @@
 /* Arbitrarily chosen values */
 #define TEST_BASE_SIZE		SZ_2M
 #define TEST_SLOT		10
+/* Large enough for the entries every architecture reserves. */
+#define TEST_RING_SIZE		SZ_64K
 
 /* Storage of test info to share with guest code */
 struct test_config {
@@ -281,6 +286,101 @@ static void test_pre_fault_memory(unsigned long vm_type, enum vm_mem_backing_src
 	for_each_guest_mode(__test_pre_fault_memory, &p);
 }
 
+/*
+ * Pre-fault more dirty-logged pages than the ring holds: each call has to stop
+ * before the ring overflows, and no entry may be lost.
+ */
+static void test_pre_fault_dirty_ring(void)
+{
+	const u64 entries = TEST_RING_SIZE / sizeof(struct kvm_dirty_gfn);
+	const u64 npages = entries + entries / 4;
+	struct kvm_pre_fault_memory range, left;
+	struct kvm_dirty_gfn *gfns, *cur;
+	u64 harvested = 0, size;
+	struct kvm_vcpu *vcpu;
+	unsigned long *seen;
+	int ret, stops = 0;
+	struct kvm_vm *vm;
+	u32 fetch = 0;
+	gpa_t gpa;
+
+	if (!kvm_has_cap(KVM_CAP_DIRTY_LOG_RING) && !kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL)) {
+		pr_info("Skipping the dirty ring test: no dirty ring\n");
+		return;
+	}
+
+	vm = vm_create(1);
+	vm_enable_dirty_ring(vm, TEST_RING_SIZE);
+	vcpu = vm_vcpu_add(vm, 0, NULL);
+	gfns = vcpu_map_dirty_ring(vcpu);
+
+	/* A ring entry is a host page. */
+	size = npages * getpagesize();
+	gpa = align_down(vm->max_gfn * vm->page_size - size, SZ_2M);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa, TEST_SLOT,
+				    vm_num_guest_pages(vm->mode, npages), KVM_MEM_LOG_DIRTY_PAGES);
+
+	/* Populate the pages, so that pre-faulting can map them writable. */
+	memset(addr_gpa2hva(vm, gpa), 1, size);
+
+	seen = bitmap_zalloc(npages);
+	TEST_ASSERT(seen, "Failed to allocate the bitmap of reported pages");
+
+	range = (struct kvm_pre_fault_memory) { .gpa = gpa, .size = size };
+	while (range.size) {
+		u64 n;
+
+		vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
+
+		if (range.size) {
+			left = range;
+			ret = __vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
+			TEST_ASSERT_VM_VCPU_IOCTL(ret == -1 && errno == ENOSPC,
+						  KVM_PRE_FAULT_MEMORY, ret, vm);
+			TEST_ASSERT(range.gpa == left.gpa && range.size == left.size,
+				    "KVM_PRE_FAULT_MEMORY made progress on a full ring");
+			stops++;
+		}
+
+		for (n = 0; ; n++) {
+			cur = &gfns[fetch % entries];
+			/* Pairs with the smp_wmb() in kvm_dirty_ring_push(). */
+			if (smp_load_acquire(&cur->flags) != KVM_DIRTY_GFN_F_DIRTY)
+				break;
+
+			TEST_ASSERT(cur->slot == TEST_SLOT && cur->offset < npages,
+				    "Ring entry %u: slot %u offset 0x%llx, expected slot %u offset < 0x%lx",
+				    fetch, cur->slot, cur->offset, TEST_SLOT, npages);
+			TEST_ASSERT(!__test_and_set_bit(cur->offset, seen),
+				    "Ring entry %u: offset 0x%llx reported twice",
+				    fetch, cur->offset);
+			/* Pairs with kvm_dirty_gfn_harvested()'s smp_load_acquire(). */
+			smp_store_release(&cur->flags, KVM_DIRTY_GFN_F_RESET);
+			fetch++;
+		}
+
+		/* A read pre-fault can map a page read-only, or access-tracked on x86. */
+		if (!n && !harvested && !range.size) {
+			pr_info("Skipping the dirty ring test: pre-faulting dirtied no pages\n");
+			bitmap_free(seen);
+			kvm_vm_free(vm);
+			return;
+		}
+		TEST_ASSERT(n, "KVM_PRE_FAULT_MEMORY pushed nothing to the ring");
+		TEST_ASSERT(kvm_vm_reset_dirty_ring(vm) == n,
+			    "KVM_RESET_DIRTY_RINGS didn't reset %lu entries", n);
+		harvested += n;
+	}
+
+	TEST_ASSERT(harvested == npages, "%lu ring entries for %lu pages", harvested, npages);
+	TEST_ASSERT(stops, "KVM_PRE_FAULT_MEMORY never stopped for a %lu-entry ring", entries);
+	pr_info("Pre-faulted %lu pages through a %lu-entry ring, stopping %d times\n",
+		npages, entries, stops);
+
+	bitmap_free(seen);
+	kvm_vm_free(vm);
+}
+
 static void help(char *name)
 {
 	puts("");
@@ -320,5 +420,6 @@ int main(int argc, char *argv[])
 	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, backing, false);
 	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, backing, true);
 #endif
+	test_pre_fault_dirty_ring();
 	return 0;
 }
-- 
2.47.3

