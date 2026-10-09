Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEAD4D599A;
	Fri,  9 Oct 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550902; cv=none; b=n8+yYrbmedyACEfdKbBSMGp9QVZ/QS4UP+R8uTmfxwhsPpF26Y6OiOW+Crqz6lldRW+nREiCwdij0qabQzWaLFYS6TIA4iM4YQXe4K0Y9S/i6j6FZYJNVY3dEQkGxEe5XGIxXbs+5J06iRGZdkCQfNMGvWDVXK/zFFwgWjSv9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550902; c=relaxed/simple;
	bh=PXJdufiWMCSUm8zA2CdKB5H2OME78FSRxNg/eA2FYEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeKFwSfG2v6no4j36USJJw08nRJ3nVJvo8FVtidlX2IQjBgNQYvn9Kdmd/0yytSNG701RJwjYBsp+ST8SqAqy3LUCHnIuQGoKasDIX6iWPg9EqObm9e10dOqqic+LxB4N7zrkh09noQ1toX+Wos1X5PYt6DzNCHdPmP67mR9Y98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WHUZUhGb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WHUZUhGb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF621D31;
	Fri,  9 Oct 2026 06:01:35 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D0623F66F;
	Fri,  9 Oct 2026 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791550898; bh=PXJdufiWMCSUm8zA2CdKB5H2OME78FSRxNg/eA2FYEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHUZUhGb6+qSohOWCNGyO0P2cx46fia6pzqtsnHA2jmu0WZk04tILxsRv6UD/c2wG
	 rNFSqa36/v2MF52VYKZc095p03jfbtbLEjWp+jCyOoY387bqtapKIOJQW/HwAJ1IzP
	 PThvpZpPebFSZvTCu+j+0uNZQj25KJnL37newhIw=
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
Subject: [PATCH v2 1/5] KVM: selftests: memstress: Add struct memstress_params, make memstress_create_vm() use it
Date: Fri,  9 Oct 2026 14:00:46 +0100
Message-ID: <20261009130054.3312154-3-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009130054.3312154-2-leo.bras@arm.com>
References: <20261009130054.3312154-2-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15491; i=leo.bras@arm.com; h=from:subject; bh=PXJdufiWMCSUm8zA2CdKB5H2OME78FSRxNg/eA2FYEE=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJOPK33U2oX0J6/sCdVds0d++2hyfovV0X9knNo2Xz+6 8JJs1d86ChlYRDjYpAVU2SRfTR/Fc/3KRlHrvxYADOHlQlkCAMXpwBMZFkwI8N8dfNMhto9JzvW JziLr3/oc2pa7USfi/4mSyZtmnZ0pf1lRoYjX0T5D6qU/nwuK83PZndH8u2BK4VFn7Z7BOzmdki Zt44bAA==
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

memstress_create_vm() already takes 6 parameters, and adding an extra one
for a new feature doesn't look a good idea.

Introduce "struct memstress_params" which contains all it's current
parameters and change memstress_create_vm() to take only that struct as a
parameter. This will be helpful for adding new features in the future, as
they can be introduced in the struct and only set when used, not requiring
to rework every user.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 .../testing/selftests/kvm/include/memstress.h | 14 ++++--
 .../selftests/kvm/access_tracking_perf_test.c | 12 ++++-
 .../selftests/kvm/demand_paging_test.c        | 12 ++++-
 .../selftests/kvm/dirty_log_perf_test.c       | 13 ++++--
 tools/testing/selftests/kvm/lib/memstress.c   | 45 ++++++++++---------
 .../kvm/memslot_modification_stress_test.c    | 14 ++++--
 .../kvm/x86/dirty_log_page_splitting_test.c   | 12 ++++-
 7 files changed, 84 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/memstress.h b/tools/testing/selftests/kvm/include/memstress.h
index 0d1d6230cc05..cea2062e1dcb 100644
--- a/tools/testing/selftests/kvm/include/memstress.h
+++ b/tools/testing/selftests/kvm/include/memstress.h
@@ -46,26 +46,32 @@ struct memstress_args {
 	bool pin_vcpus;
 	/* The vCPU=>pCPU pinning map. Only valid if pin_vcpus is true. */
 	u32 vcpu_to_pcpu[KVM_MAX_VCPUS];
 
  	/* Test is done, stop running vCPUs. */
  	bool stop_vcpus;
 
 	struct memstress_vcpu_args vcpu_args[KVM_MAX_VCPUS];
 };
 
+struct memstress_params {
+	enum vm_guest_mode mode;
+	int nr_vcpus;
+	u64 vcpu_memory_bytes;
+	int slots;
+	enum vm_mem_backing_src_type backing_src;
+	bool partition_vcpu_memory_access;
+};
+
 extern struct memstress_args memstress_args;
 
-struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
-				   u64 vcpu_memory_bytes, int slots,
-				   enum vm_mem_backing_src_type backing_src,
-				   bool partition_vcpu_memory_access);
+struct kvm_vm *memstress_create_vm(struct memstress_params *params);
 void memstress_destroy_vm(struct kvm_vm *vm);
 
 void memstress_set_write_percent(struct kvm_vm *vm, u32 write_percent);
 void memstress_set_random_access(struct kvm_vm *vm, bool random_access);
 
 void memstress_start_vcpu_threads(int vcpus, void (*vcpu_fn)(struct memstress_vcpu_args *));
 void memstress_join_vcpu_threads(int vcpus);
 void memstress_guest_code(u32 vcpu_id);
 
 u64 memstress_nested_pages(int nr_vcpus);
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 4415c94b2866..2e262a1982eb 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -401,22 +401,30 @@ static void mark_memory_idle(struct kvm_vm *vm, int nr_vcpus)
 	iteration_work = ITERATION_MARK_IDLE;
 	run_iteration(vm, nr_vcpus, "Mark memory idle (page_idle)");
 }
 
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
 	struct test_params *params = arg;
 	struct kvm_vm *vm;
 	int nr_vcpus = params->nr_vcpus;
 
-	vm = memstress_create_vm(mode, nr_vcpus, params->vcpu_memory_bytes, 1,
-				 params->backing_src, !overlap_memory_access);
+	struct memstress_params ms_par = {
+		.mode = mode,
+		.nr_vcpus = nr_vcpus,
+		.vcpu_memory_bytes = params->vcpu_memory_bytes,
+		.slots = 1,
+		.backing_src = params->backing_src,
+		.partition_vcpu_memory_access = !overlap_memory_access,
+	};
+
+	vm = memstress_create_vm(&ms_par);
 
 	/*
 	 * If guest_page_size is larger than the host's page size, the
 	 * guest (memstress) will only fault in a subset of the host's pages.
 	 */
 	test_pages = params->nr_vcpus * params->vcpu_memory_bytes /
 		      max(memstress_args.guest_page_size,
 			  (u64)getpagesize());
 
 	memstress_start_vcpu_threads(nr_vcpus, vcpu_thread_main);
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index f8b3d0b68830..4181c2c4ca40 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -154,22 +154,30 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct memstress_vcpu_args *vcpu_args;
 	struct test_params *p = arg;
 	struct uffd_desc **uffd_descs = NULL;
 	u64 uffd_region_size;
 	struct timespec start;
 	struct timespec ts_diff;
 	double vcpu_paging_rate;
 	struct kvm_vm *vm;
 	int i, num_uffds = 0;
 
-	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
-				 p->src_type, p->partition_vcpu_memory_access);
+	struct memstress_params ms_par = {
+		.mode = mode,
+		.nr_vcpus = nr_vcpus,
+		.vcpu_memory_bytes = guest_percpu_mem_size,
+		.slots = 1,
+		.backing_src = p->src_type,
+		.partition_vcpu_memory_access = p->partition_vcpu_memory_access,
+	};
+
+	vm = memstress_create_vm(&ms_par);
 
 	demand_paging_size = get_backing_src_pagesz(p->src_type);
 
 	guest_data_prototype = malloc(demand_paging_size);
 	TEST_ASSERT(guest_data_prototype,
 		    "Failed to allocate buffer for guest data pattern");
 	memset(guest_data_prototype, 0xAB, demand_paging_size);
 
 	if (p->uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
 		num_uffds = p->single_uffd ? 1 : nr_vcpus;
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 7c5abe1ae9e0..173f750344f4 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -110,23 +110,30 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	u64 host_num_pages;
 	u64 pages_per_slot;
 	struct timespec start;
 	struct timespec ts_diff;
 	struct timespec get_dirty_log_total = (struct timespec){0};
 	struct timespec vcpu_dirty_total = (struct timespec){0};
 	struct timespec avg;
 	struct timespec clear_dirty_log_total = (struct timespec){0};
 	int i;
 
-	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
-				 p->slots, p->backing_src,
-				 p->partition_vcpu_memory_access);
+	struct memstress_params ms_par = {
+		.mode = mode,
+		.nr_vcpus = nr_vcpus,
+		.vcpu_memory_bytes = guest_percpu_mem_size,
+		.slots = p->slots,
+		.backing_src = p->backing_src,
+		.partition_vcpu_memory_access = p->partition_vcpu_memory_access,
+	};
+
+	vm = memstress_create_vm(&ms_par);
 
 	memstress_set_write_percent(vm, p->write_percent);
 
 	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm->page_shift;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
 
 	bitmaps = memstress_alloc_bitmaps(p->slots, pages_per_slot);
 
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 2864562f57b4..880657df65e9 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -114,67 +114,66 @@ void memstress_setup_vcpus(struct kvm_vm *vm, int nr_vcpus,
 		}
 
 		vcpu_args_set(vcpus[i], 1, i);
 
 		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
 			 i, vcpu_args->gpa, vcpu_args->gpa +
 			 (vcpu_args->pages * args->guest_page_size));
 	}
 }
 
-struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
-				   u64 vcpu_memory_bytes, int slots,
-				   enum vm_mem_backing_src_type backing_src,
-				   bool partition_vcpu_memory_access)
+struct kvm_vm *memstress_create_vm(struct memstress_params *params)
 {
 	struct memstress_args *args = &memstress_args;
 	struct kvm_vm *vm;
 	u64 guest_num_pages, slot0_pages = 0;
-	u64 backing_src_pagesz = get_backing_src_pagesz(backing_src);
+	u64 backing_src_pagesz = get_backing_src_pagesz(params->backing_src);
 	u64 region_end_gfn;
 	int i;
 
-	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
+	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(params->mode));
 
 	/* By default vCPUs will write to memory. */
 	args->write_percent = 100;
 
 	/*
 	 * Snapshot the non-huge page size.  This is used by the guest code to
 	 * access/dirty pages at the logging granularity.
 	 */
-	args->guest_page_size = vm_guest_mode_params[mode].page_size;
+	args->guest_page_size = vm_guest_mode_params[params->mode].page_size;
 
-	guest_num_pages = vm_adjust_num_guest_pages(mode,
-				(nr_vcpus * vcpu_memory_bytes) / args->guest_page_size);
+	guest_num_pages = vm_adjust_num_guest_pages(params->mode,
+				(params->nr_vcpus * params->vcpu_memory_bytes) /
+			 	args->guest_page_size);
 
-	TEST_ASSERT(vcpu_memory_bytes % getpagesize() == 0,
+	TEST_ASSERT(params->vcpu_memory_bytes % getpagesize() == 0,
 		    "Guest memory size is not host page size aligned.");
-	TEST_ASSERT(vcpu_memory_bytes % args->guest_page_size == 0,
+	TEST_ASSERT(params->vcpu_memory_bytes % args->guest_page_size == 0,
 		    "Guest memory size is not guest page size aligned.");
-	TEST_ASSERT(guest_num_pages % slots == 0,
+	TEST_ASSERT(guest_num_pages % params->slots == 0,
 		    "Guest memory cannot be evenly divided into %d slots.",
-		    slots);
+		    params->slots);
 
 	/*
 	 * If using nested, allocate extra pages for the nested page tables and
 	 * in-memory data structures.
 	 */
 	if (args->nested)
-		slot0_pages += memstress_nested_pages(nr_vcpus);
+		slot0_pages += memstress_nested_pages(params->nr_vcpus);
 
 	/*
 	 * Pass guest_num_pages to populate the page tables for test memory.
 	 * The memory is also added to memslot 0, but that's a benign side
 	 * effect as KVM allows aliasing HVAs in meslots.
 	 */
-	vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus,
+	vm = __vm_create_with_vcpus(VM_SHAPE(params->mode),
+				    params->nr_vcpus,
 				    slot0_pages + guest_num_pages,
 				    memstress_guest_code, vcpus);
 
 	args->vm = vm;
 
 	/* Put the test region at the top guest physical memory. */
 	region_end_gfn = vm->max_gfn + 1;
 
 #ifdef __x86_64__
 	/*
@@ -185,47 +184,49 @@ struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 		region_end_gfn = min(region_end_gfn, (1UL << 48) / args->guest_page_size);
 #endif
 	/*
 	 * If there should be more memory in the guest test region than there
 	 * can be pages in the guest, it will definitely cause problems.
 	 */
 	TEST_ASSERT(guest_num_pages < region_end_gfn,
 		    "Requested more guest memory than address space allows.\n"
 		    "    guest pages: %" PRIx64 " max gfn: %" PRIx64
 		    " nr_vcpus: %d wss: %" PRIx64 "]",
-		    guest_num_pages, region_end_gfn - 1, nr_vcpus, vcpu_memory_bytes);
+		    guest_num_pages, region_end_gfn - 1, params->nr_vcpus,
+		    params->vcpu_memory_bytes);
 
 	args->gpa = (region_end_gfn - guest_num_pages - 1) * args->guest_page_size;
 	args->gpa = align_down(args->gpa, backing_src_pagesz);
 	args->size = guest_num_pages * args->guest_page_size;
 	pr_info("guest physical test memory: [0x%lx, 0x%lx)\n",
 		args->gpa, args->gpa + args->size);
 
 	/* Add extra memory slots for testing */
-	for (i = 0; i < slots; i++) {
-		u64 region_pages = guest_num_pages / slots;
+	for (i = 0; i < params->slots; i++) {
+		u64 region_pages = guest_num_pages / params->slots;
 		gpa_t region_start = args->gpa + region_pages * args->guest_page_size * i;
 
-		vm_userspace_mem_region_add(vm, backing_src, region_start,
+		vm_userspace_mem_region_add(vm, params->backing_src, region_start,
 					    MEMSTRESS_MEM_SLOT_INDEX + i,
 					    region_pages, 0);
 	}
 
 	/* Do mapping for the demand paging memory slot */
 	virt_map(vm, guest_test_virt_mem, args->gpa, guest_num_pages);
 
-	memstress_setup_vcpus(vm, nr_vcpus, vcpus, vcpu_memory_bytes,
-			      partition_vcpu_memory_access);
+	memstress_setup_vcpus(vm, params->nr_vcpus, vcpus,
+			      params->vcpu_memory_bytes,
+			      params->partition_vcpu_memory_access);
 
 	if (args->nested) {
 		pr_info("Configuring vCPUs to run in L2 (nested).\n");
-		memstress_setup_nested(vm, nr_vcpus, vcpus);
+		memstress_setup_nested(vm, params->nr_vcpus, vcpus);
 	}
 
 	/* Export the shared variables to the guest. */
 	sync_global_to_guest(vm, memstress_args);
 
 	return vm;
 }
 
 void memstress_destroy_vm(struct kvm_vm *vm)
 {
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index 9c7578a098c3..d834f5a7560d 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -81,23 +81,31 @@ struct test_params {
 	u64 nr_iterations;
 	bool partition_vcpu_memory_access;
 	bool disable_slot_zap_quirk;
 };
 
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
 	struct test_params *p = arg;
 	struct kvm_vm *vm;
 
-	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
-				 VM_MEM_SRC_ANONYMOUS,
-				 p->partition_vcpu_memory_access);
+	struct memstress_params ms_par = {
+		.mode = mode,
+		.nr_vcpus = nr_vcpus,
+		.vcpu_memory_bytes = guest_percpu_mem_size,
+		.slots = 1,
+		.backing_src = VM_MEM_SRC_ANONYMOUS,
+		.partition_vcpu_memory_access = p->partition_vcpu_memory_access,
+	};
+
+	vm = memstress_create_vm(&ms_par);
+
 #ifdef __x86_64__
 	if (p->disable_slot_zap_quirk)
 		vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2, KVM_X86_QUIRK_SLOT_ZAP_ALL);
 
 	pr_info("Memslot zap quirk %s\n", p->disable_slot_zap_quirk ?
 		"disabled" : "enabled");
 #endif
 
 	pr_info("Finished creating vCPUs\n");
 
diff --git a/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c b/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c
index 388ba4101f97..fffef5243ad8 100644
--- a/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c
+++ b/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c
@@ -93,22 +93,30 @@ static void run_test(enum vm_guest_mode mode, void *unused)
 	u64 host_num_pages;
 	u64 pages_per_slot;
 	int i;
 	struct kvm_page_stats stats_populated;
 	struct kvm_page_stats stats_dirty_logging_enabled;
 	struct kvm_page_stats stats_dirty_pass[ITERATIONS];
 	struct kvm_page_stats stats_clear_pass[ITERATIONS];
 	struct kvm_page_stats stats_dirty_logging_disabled;
 	struct kvm_page_stats stats_repopulated;
 
-	vm = memstress_create_vm(mode, VCPUS, guest_percpu_mem_size,
-				 SLOTS, backing_src, false);
+	struct memstress_params ms_par = {
+		.mode = mode,
+		.nr_vcpus = VCPUS,
+		.vcpu_memory_bytes = guest_percpu_mem_size,
+		.slots = SLOTS,
+		.backing_src = backing_src,
+		.partition_vcpu_memory_access = false,
+	};
+
+	vm = memstress_create_vm(&ms_par);
 
 	guest_num_pages = (VCPUS * guest_percpu_mem_size) >> vm->page_shift;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / SLOTS;
 	TEST_ASSERT_EQ(host_num_pages, pages_per_slot * SLOTS);
 	TEST_ASSERT(!(host_num_pages % 512),
 		    "Number of pages, '%lu' not a multiple of 2MiB", host_num_pages);
 
 	bitmaps = memstress_alloc_bitmaps(SLOTS, pages_per_slot);
-- 
2.55.0

