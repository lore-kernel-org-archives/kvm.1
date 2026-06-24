Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBA3DD52B;
	Wed, 24 Jun 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321450; cv=none; b=B8JUCBbsLf+I4QY+il3nXKq+0W3YJA2G7iEPq9ALEKinNkbNseqk9+6QtqfLEDK8VNZWifmNqbPFpRE1CaF5LShima5QXtcPOte3N6KCEAXIJluktuebCQFpAA3v86iBCo83OYE4WPaqxmn0WgAY760FmwcIutyRJrxcKVnCxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321450; c=relaxed/simple;
	bh=vD5t4myi9oJDJdNcFVXUTZXWYgyBoCs4Pw49UWZH2P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV1I2ftNuKRedU8fvH1cuq2zPvBhcNvNWndDjbMabIbNRboiBct95gWbNqqYgEFvtjieaeLrrxQzCVDEyMSWNqYvXG5TUi/MmbcMdZNpfba/PPvTmdFkRiiO4HVtz4cDQnJ8vNLTsU5m4XfT9so8ddzI7Vl8x8NGqicnu5uI5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dXPMPGL9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dXPMPGL9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C119027DC;
	Wed, 24 Jun 2026 10:17:23 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0733F905;
	Wed, 24 Jun 2026 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782321448; bh=vD5t4myi9oJDJdNcFVXUTZXWYgyBoCs4Pw49UWZH2P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXPMPGL90s3NoHDQUYrfiOx6mvmPsz2eDZt3fgombhkOijFLqu+XAtcqY2EyRXHMq
	 8r2mpCZ3hhNPG41+iWTzeLYc9gP9FAia9NAxazfhmCe5vyAyZU2QIOFAmWJuymhtII
	 oVTV/FQ0bwuouxJL0igDf2HjyE6kHR7jJbInao58=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] KVM: selftests: memstress: Add option to enable dirty-ring on VM creation
Date: Wed, 24 Jun 2026 18:16:47 +0100
Message-ID: <20260624171656.1737580-2-leo.bras@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624171656.1737580-1-leo.bras@arm.com>
References: <20260624171656.1737580-1-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10663; i=leo.bras@arm.com; h=from:subject; bh=vD5t4myi9oJDJdNcFVXUTZXWYgyBoCs4Pw49UWZH2P4=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJsBG7eWLQ4/VeHck7Yzt9auXd/ylVM2H9oe0HKuYhCn f+qC08LdJSyMIhxMciKKbLIPpq/iuf7lIwjV34sgJnDygQyhIGLUwAmMrmckaFP+6n/r5efLyey fX1W/of/hDAD04sTgg5c+V6RdoxSX0MZ/mfse3JwpvajCyHra6RSNY2CmaalXJXPnizgGHQx3LL 7KgsA
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Dirty-ring should be enabled after the VM is created, but before the
creation of any cpu. To to so, add an option on memstress_create_vm() that
takes dirty-ring size, and enables it at the correct moment.

This required a new function memstress_vm_create_with_vcpus() to be
created based on the previously used __vm_create_with_vcpus();

Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 .../testing/selftests/kvm/include/memstress.h |  3 +-
 .../selftests/kvm/access_tracking_perf_test.c |  2 +-
 .../selftests/kvm/demand_paging_test.c        |  2 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  2 +-
 tools/testing/selftests/kvm/lib/memstress.c   | 34 ++++++++++++++++---
 .../kvm/memslot_modification_stress_test.c    |  2 +-
 .../kvm/x86/dirty_log_page_splitting_test.c   |  2 +-
 7 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/memstress.h b/tools/testing/selftests/kvm/include/memstress.h
index 0d1d6230cc05..e17f344978af 100644
--- a/tools/testing/selftests/kvm/include/memstress.h
+++ b/tools/testing/selftests/kvm/include/memstress.h
@@ -51,21 +51,22 @@ struct memstress_args {
  	bool stop_vcpus;
 
 	struct memstress_vcpu_args vcpu_args[KVM_MAX_VCPUS];
 };
 
 extern struct memstress_args memstress_args;
 
 struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 				   u64 vcpu_memory_bytes, int slots,
 				   enum vm_mem_backing_src_type backing_src,
-				   bool partition_vcpu_memory_access);
+				   bool partition_vcpu_memory_access,
+				   u32 dirty_ring_size);
 void memstress_destroy_vm(struct kvm_vm *vm);
 
 void memstress_set_write_percent(struct kvm_vm *vm, u32 write_percent);
 void memstress_set_random_access(struct kvm_vm *vm, bool random_access);
 
 void memstress_start_vcpu_threads(int vcpus, void (*vcpu_fn)(struct memstress_vcpu_args *));
 void memstress_join_vcpu_threads(int vcpus);
 void memstress_guest_code(u32 vcpu_id);
 
 u64 memstress_nested_pages(int nr_vcpus);
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 4415c94b2866..f78d56265d89 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -402,21 +402,21 @@ static void mark_memory_idle(struct kvm_vm *vm, int nr_vcpus)
 	run_iteration(vm, nr_vcpus, "Mark memory idle (page_idle)");
 }
 
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
 	struct test_params *params = arg;
 	struct kvm_vm *vm;
 	int nr_vcpus = params->nr_vcpus;
 
 	vm = memstress_create_vm(mode, nr_vcpus, params->vcpu_memory_bytes, 1,
-				 params->backing_src, !overlap_memory_access);
+				 params->backing_src, !overlap_memory_access, 0);
 
 	/*
 	 * If guest_page_size is larger than the host's page size, the
 	 * guest (memstress) will only fault in a subset of the host's pages.
 	 */
 	test_pages = params->nr_vcpus * params->vcpu_memory_bytes /
 		      max(memstress_args.guest_page_size,
 			  (u64)getpagesize());
 
 	memstress_start_vcpu_threads(nr_vcpus, vcpu_thread_main);
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 302c4923d093..92246e27ef74 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -155,21 +155,21 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct test_params *p = arg;
 	struct uffd_desc **uffd_descs = NULL;
 	u64 uffd_region_size;
 	struct timespec start;
 	struct timespec ts_diff;
 	double vcpu_paging_rate;
 	struct kvm_vm *vm;
 	int i, num_uffds = 0;
 
 	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
-				 p->src_type, p->partition_vcpu_memory_access);
+				 p->src_type, p->partition_vcpu_memory_access, 0);
 
 	demand_paging_size = get_backing_src_pagesz(p->src_type);
 
 	guest_data_prototype = malloc(demand_paging_size);
 	TEST_ASSERT(guest_data_prototype,
 		    "Failed to allocate buffer for guest data pattern");
 	memset(guest_data_prototype, 0xAB, demand_paging_size);
 
 	if (p->uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
 		num_uffds = p->single_uffd ? 1 : nr_vcpus;
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index ef779fa91827..69b38791440e 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -112,21 +112,21 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct timespec start;
 	struct timespec ts_diff;
 	struct timespec get_dirty_log_total = (struct timespec){0};
 	struct timespec vcpu_dirty_total = (struct timespec){0};
 	struct timespec avg;
 	struct timespec clear_dirty_log_total = (struct timespec){0};
 	int i;
 
 	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
 				 p->slots, p->backing_src,
-				 p->partition_vcpu_memory_access);
+				 p->partition_vcpu_memory_access, 0);
 
 	memstress_set_write_percent(vm, p->write_percent);
 
 	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm->page_shift;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
 
 	bitmaps = memstress_alloc_bitmaps(p->slots, pages_per_slot);
 
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 6dcd15910a06..c9f85533ffff 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -114,24 +114,49 @@ void memstress_setup_vcpus(struct kvm_vm *vm, int nr_vcpus,
 		}
 
 		vcpu_args_set(vcpus[i], 1, i);
 
 		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
 			 i, vcpu_args->gpa, vcpu_args->gpa +
 			 (vcpu_args->pages * args->guest_page_size));
 	}
 }
 
+static struct kvm_vm *memstress_vm_create_with_vcpus(struct vm_shape shape,
+						     u32 nr_vcpus,
+						     u64 extra_mem_pages,
+						     void *guest_code,
+						     struct kvm_vcpu *vcpus[],
+						     u32 dirty_ring_size)
+{
+	struct kvm_vm *vm;
+	int i;
+
+	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
+
+	vm = __vm_create(shape, nr_vcpus, extra_mem_pages);
+
+	if (dirty_ring_size)
+		vm_enable_dirty_ring(vm, dirty_ring_size);
+
+	for (i = 0; i < nr_vcpus; ++i)
+		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
+
+	kvm_arch_vm_finalize_vcpus(vm);
+	return vm;
+}
+
 struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 				   u64 vcpu_memory_bytes, int slots,
 				   enum vm_mem_backing_src_type backing_src,
-				   bool partition_vcpu_memory_access)
+				   bool partition_vcpu_memory_access,
+				   u32 dirty_ring_size)
 {
 	struct memstress_args *args = &memstress_args;
 	struct kvm_vm *vm;
 	u64 guest_num_pages, slot0_pages = 0;
 	u64 backing_src_pagesz = get_backing_src_pagesz(backing_src);
 	u64 region_end_gfn;
 	int i;
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
@@ -160,23 +185,24 @@ struct kvm_vm *memstress_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 	 * in-memory data structures.
 	 */
 	if (args->nested)
 		slot0_pages += memstress_nested_pages(nr_vcpus);
 
 	/*
 	 * Pass guest_num_pages to populate the page tables for test memory.
 	 * The memory is also added to memslot 0, but that's a benign side
 	 * effect as KVM allows aliasing HVAs in meslots.
 	 */
-	vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus,
-				    slot0_pages + guest_num_pages,
-				    memstress_guest_code, vcpus);
+	vm = memstress_vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus,
+					    slot0_pages + guest_num_pages,
+					    memstress_guest_code, vcpus,
+					    dirty_ring_size);
 
 	args->vm = vm;
 
 	/* Put the test region at the top guest physical memory. */
 	region_end_gfn = vm->max_gfn + 1;
 
 #ifdef __x86_64__
 	/*
 	 * When running vCPUs in L2, restrict the test region to 48 bits to
 	 * avoid needing 5-level page tables to identity map L2.
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index 9c7578a098c3..3a1be9b75e01 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -83,21 +83,21 @@ struct test_params {
 	bool disable_slot_zap_quirk;
 };
 
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
 	struct test_params *p = arg;
 	struct kvm_vm *vm;
 
 	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
 				 VM_MEM_SRC_ANONYMOUS,
-				 p->partition_vcpu_memory_access);
+				 p->partition_vcpu_memory_access, 0);
 #ifdef __x86_64__
 	if (p->disable_slot_zap_quirk)
 		vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2, KVM_X86_QUIRK_SLOT_ZAP_ALL);
 
 	pr_info("Memslot zap quirk %s\n", p->disable_slot_zap_quirk ?
 		"disabled" : "enabled");
 #endif
 
 	pr_info("Finished creating vCPUs\n");
 
diff --git a/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c b/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c
index 388ba4101f97..661e9abfb439 100644
--- a/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c
+++ b/tools/testing/selftests/kvm/x86/dirty_log_page_splitting_test.c
@@ -94,21 +94,21 @@ static void run_test(enum vm_guest_mode mode, void *unused)
 	u64 pages_per_slot;
 	int i;
 	struct kvm_page_stats stats_populated;
 	struct kvm_page_stats stats_dirty_logging_enabled;
 	struct kvm_page_stats stats_dirty_pass[ITERATIONS];
 	struct kvm_page_stats stats_clear_pass[ITERATIONS];
 	struct kvm_page_stats stats_dirty_logging_disabled;
 	struct kvm_page_stats stats_repopulated;
 
 	vm = memstress_create_vm(mode, VCPUS, guest_percpu_mem_size,
-				 SLOTS, backing_src, false);
+				 SLOTS, backing_src, false, 0);
 
 	guest_num_pages = (VCPUS * guest_percpu_mem_size) >> vm->page_shift;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / SLOTS;
 	TEST_ASSERT_EQ(host_num_pages, pages_per_slot * SLOTS);
 	TEST_ASSERT(!(host_num_pages % 512),
 		    "Number of pages, '%lu' not a multiple of 2MiB", host_num_pages);
 
 	bitmaps = memstress_alloc_bitmaps(SLOTS, pages_per_slot);
-- 
2.54.0

