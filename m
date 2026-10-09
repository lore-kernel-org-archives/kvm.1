Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9364DD3B2;
	Fri,  9 Oct 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550903; cv=none; b=NzRocYFHiQ2p1njqDH2Daa7S8YJAvD2O6skyhxa3TI6sfFbeL20zq6lldcfFsqKDXusLDi3QU2ZRMJJ/2lzSnHhR2hIFnPuZqEKEpavHDKb6TDpCrZKOnS4GnM+Ub86O60Ig/bHcx98Uk2Dc8uexwTHp27NBEXZAIgZ1CMD59B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550903; c=relaxed/simple;
	bh=7DhDalLRf0Om9ztXgIiupgy+hgrqmBQ0LPI+xLkiCLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbvRc254yLUULo9XdfrUFE9oKkUIPpqqBaSe2GsCo3A5vCcFh36LtncdRhd5lyiwhaSFPVZDu0favOdSpgzHLUxcd+js+6cK/AGeoK1lDmASPuTbZrXDGGRImyJ+0cAGNKEGj2rGkFK6bJyWSA7/V3WNQHroJMg7l5wixQ7J8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I2xvQSTe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I2xvQSTe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25F71E2F;
	Fri,  9 Oct 2026 06:01:37 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08EFA3F66F;
	Fri,  9 Oct 2026 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791550901; bh=7DhDalLRf0Om9ztXgIiupgy+hgrqmBQ0LPI+xLkiCLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2xvQSTe9LSn95JZrySYUPzp2CxaydmfgnLR4/uJTaNNxj8k4p7DhiyjYivPl8Tvp
	 +hiUTy8fXZ/scR9eSSJ16omzVtxULcemgYrK4Pk1JEDJaoExH94Gp7PazvxqxR+azK
	 S9c/XOlshTFBsJ8yoxasJ04zBOKxz1aUjUNbxGbE=
From: Leonardo Bras <leo.bras@arm.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Josh Hilke <jrhilke@google.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] KVM: selftests: memstress: Add option to enable dirty-ring on VM creation
Date: Fri,  9 Oct 2026 14:00:47 +0100
Message-ID: <20261009130054.3312154-4-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009130054.3312154-2-leo.bras@arm.com>
References: <20261009130054.3312154-2-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3982; i=leo.bras@arm.com; h=from:subject; bh=7DhDalLRf0Om9ztXgIiupgy+hgrqmBQ0LPI+xLkiCLs=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJOPG2Qyjvw3/BXZmDvzrS8HQpH3/7P+3DWIH4+9+J77 w3912c+6ShlYRDjYpAVU2SRfTR/Fc/3KRlHrvxYADOHlQlkCAMXpwBMpGoCI0Or3ka1TwKzvrhf 2ffv2yT5oNvxff7dTCf+zHaeMVGpPkWB4b/7n/17l5Una+cEVLks31NtJecyKSus4MgCacV7txl 8W9gA
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Dirty-ring should be enabled after the VM is created, but before the
creation of any cpu. To to so, add an option on memstress_create_vm() that
takes dirty-ring size, and enables it at the correct moment.

This required a new function memstress_vm_create_with_vcpus() to be
created based on the previously used __vm_create_with_vcpus();

Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 .../testing/selftests/kvm/include/memstress.h |  1 +
 tools/testing/selftests/kvm/lib/memstress.c   | 27 +++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/memstress.h b/tools/testing/selftests/kvm/include/memstress.h
index cea2062e1dcb..465edf0da8f3 100644
--- a/tools/testing/selftests/kvm/include/memstress.h
+++ b/tools/testing/selftests/kvm/include/memstress.h
@@ -53,20 +53,21 @@ struct memstress_args {
 	struct memstress_vcpu_args vcpu_args[KVM_MAX_VCPUS];
 };
 
 struct memstress_params {
 	enum vm_guest_mode mode;
 	int nr_vcpus;
 	u64 vcpu_memory_bytes;
 	int slots;
 	enum vm_mem_backing_src_type backing_src;
 	bool partition_vcpu_memory_access;
+	u32 dirty_ring_size;
 };
 
 extern struct memstress_args memstress_args;
 
 struct kvm_vm *memstress_create_vm(struct memstress_params *params);
 void memstress_destroy_vm(struct kvm_vm *vm);
 
 void memstress_set_write_percent(struct kvm_vm *vm, u32 write_percent);
 void memstress_set_random_access(struct kvm_vm *vm, bool random_access);
 
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 880657df65e9..b1f13499e85f 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -114,20 +114,41 @@ void memstress_setup_vcpus(struct kvm_vm *vm, int nr_vcpus,
 		}
 
 		vcpu_args_set(vcpus[i], 1, i);
 
 		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
 			 i, vcpu_args->gpa, vcpu_args->gpa +
 			 (vcpu_args->pages * args->guest_page_size));
 	}
 }
 
+static struct kvm_vm *memstress_vm_create_with_vcpus(struct memstress_params *params,
+						     u64 extra_mem_pages)
+{
+	struct kvm_vm *vm;
+	int i;
+
+	TEST_ASSERT(params->nr_vcpus > 0, "Invalid number of vCPUs (%d)",
+		    params->nr_vcpus);
+
+	vm = __vm_create(VM_SHAPE(params->mode), params->nr_vcpus, extra_mem_pages);
+
+	if (params->dirty_ring_size)
+		vm_enable_dirty_ring(vm, params->dirty_ring_size);
+
+	for (i = 0; i < params->nr_vcpus; ++i)
+		vcpus[i] = vm_vcpu_add(vm, i, memstress_guest_code);
+
+	kvm_arch_vm_finalize_vcpus(vm);
+	return vm;
+}
+
 struct kvm_vm *memstress_create_vm(struct memstress_params *params)
 {
 	struct memstress_args *args = &memstress_args;
 	struct kvm_vm *vm;
 	u64 guest_num_pages, slot0_pages = 0;
 	u64 backing_src_pagesz = get_backing_src_pagesz(params->backing_src);
 	u64 region_end_gfn;
 	int i;
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(params->mode));
@@ -158,25 +179,21 @@ struct kvm_vm *memstress_create_vm(struct memstress_params *params)
 	 * in-memory data structures.
 	 */
 	if (args->nested)
 		slot0_pages += memstress_nested_pages(params->nr_vcpus);
 
 	/*
 	 * Pass guest_num_pages to populate the page tables for test memory.
 	 * The memory is also added to memslot 0, but that's a benign side
 	 * effect as KVM allows aliasing HVAs in meslots.
 	 */
-	vm = __vm_create_with_vcpus(VM_SHAPE(params->mode),
-				    params->nr_vcpus,
-				    slot0_pages + guest_num_pages,
-				    memstress_guest_code, vcpus);
-
+	vm = memstress_vm_create_with_vcpus(params, slot0_pages + guest_num_pages);
 	args->vm = vm;
 
 	/* Put the test region at the top guest physical memory. */
 	region_end_gfn = vm->max_gfn + 1;
 
 #ifdef __x86_64__
 	/*
 	 * When running vCPUs in L2, restrict the test region to 48 bits to
 	 * avoid needing 5-level page tables to identity map L2.
 	 */
-- 
2.55.0

