Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55927FD6D;
	Thu, 12 Feb 2026 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893114; cv=none; b=HPXDkEKbEpqqRQGlKxsmhndEXBmLMGTdnr1GVDJVNwrWKOs0WvxCoceHZjwbdYHmtwEhI0oPpmxNe722T+3dhIv36wCfwIF5dUwm9dEJ0zMD55zOv3W4jX1svClR1K5e52paYwWck/fCcRF5fTH6gCqNdW5uHtw5xslCu3js/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893114; c=relaxed/simple;
	bh=P5J39lKA/VzRth6H4G22jnjhoe/bSb3I9NEm33ls58w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2k5x+ByECZgspXYy6GES+kgcNWkflvWB3/JrBI+3lhFpV3lZa7B1ioS0GZVAAN0odXqruVVnVmSzPqOL25aD+PwhE8wyDotR7bkUuauj4o9zJ1quoKuY/Q+eAfWbRgQX8H27ov+kxG3zrWwJO0Ux5FNUdu1Mgyg1IsPaqbngzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QqpASybd; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QqpASybd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CQ
	PSHzYoMoCwOMGLgwIkUsfIfCnL7xVuvDZ2rAf7ONo=; b=QqpASybdHYPjhKM9fd
	Lzot8PBLUCpWcnU66FkFOQzoNI6U6quhNixKdXbbLQ9+WPrgc8QVRr0itUuwaSMc
	fiuxk46k6/Svi9733P+fyEyyI2gPUGZOaR0TtLZMi9n2/cpqlDN8zryLzAm6GK6k
	Reb4QWx4WaQes9xl+PyoKtPOk=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA38f4Tr41pL2eqLA--.10527S4;
	Thu, 12 Feb 2026 18:44:40 +0800 (CST)
From: Zhiquan Li <zhiquan_li@163.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan_li@163.com
Subject: [PATCH v2 2/4] KVM: x86: selftests: Add a flag to identify AMD compatible test cases
Date: Thu, 12 Feb 2026 18:38:39 +0800
Message-ID: <20260212103841.171459-3-zhiquan_li@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212103841.171459-1-zhiquan_li@163.com>
References: <20260212103841.171459-1-zhiquan_li@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA38f4Tr41pL2eqLA--.10527S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWrKF1rZw4kJr18Jr1UKFg_yoWxGFyDpa
	4kAr1F9F1xXFnIya4xJw4vqF18CFZ7ua18t34jvry3ZF18Ja4xXrs7K3WjyFZ3uFWrXw13
	Aa4xKF4DCanrJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRdhL8UUUUU=
X-CM-SenderInfo: 52kl13xdqbzxi6rwjhhfrp/xtbC6hmvmGmNrxna0QAA3d

Most of KVM x86 selftests for AMD are compatible with Hygon
architecture (but not all), add a flag "host_cpu_is_amd_compatible" to
figure out these cases.

Following test failures on Hygon platform can be fixed:

* Fix hypercall test: Hygon architecture also uses VMMCALL as guest
  hypercall instruction.

* Following test failures due to access reserved memory address regions:
  - access_tracking_perf_test
  - demand_paging_test
  - dirty_log_perf_test
  - dirty_log_test
  - kvm_page_table_test
  - memslot_modification_stress_test
  - pre_fault_memory_test
  - x86/dirty_log_page_splitting_test

Hygon CSV also makes the "physical address space width reduction", the
reduced physical address bits are reported by bits 11:6 of
CPUID[0x8000001f].EBX as well, so the existed logic is totally
applicable for Hygon processors.  Mapping memory into these regions and
accessing to them results in a #PF.

Signed-off-by: Zhiquan Li <zhiquan_li@163.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h  |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c      | 12 ++++++++----
 tools/testing/selftests/kvm/x86/fix_hypercall_test.c |  2 +-
 tools/testing/selftests/kvm/x86/msrs_test.c          |  2 +-
 tools/testing/selftests/kvm/x86/xapic_state_test.c   |  2 +-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 1338de7111e7..40e3deb64812 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -22,6 +22,7 @@
 extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
 extern bool host_cpu_is_hygon;
+extern bool host_cpu_is_amd_compatible;
 extern uint64_t guest_tsc_khz;
 
 #ifndef MAX_NR_CPUID_ENTRIES
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index f6b1c5324931..f4e8649071b6 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -24,6 +24,7 @@ vm_vaddr_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;
 bool host_cpu_is_hygon;
+bool host_cpu_is_amd_compatible;
 bool is_forced_emulation_enabled;
 uint64_t guest_tsc_khz;
 
@@ -794,6 +795,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 	sync_global_to_guest(vm, host_cpu_is_intel);
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, host_cpu_is_hygon);
+	sync_global_to_guest(vm, host_cpu_is_amd_compatible);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 	sync_global_to_guest(vm, pmu_errata_mask);
 
@@ -1350,7 +1352,8 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 		     "1: vmmcall\n\t"					\
 		     "2:"						\
 		     : "=a"(r)						\
-		     : [use_vmmcall] "r" (host_cpu_is_amd), inputs);	\
+		     : [use_vmmcall] "r" (host_cpu_is_amd_compatible),	\
+		       inputs);						\
 									\
 	r;								\
 })
@@ -1390,8 +1393,8 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 
 	max_gfn = (1ULL << (guest_maxphyaddr - vm->page_shift)) - 1;
 
-	/* Avoid reserved HyperTransport region on AMD processors.  */
-	if (!host_cpu_is_amd)
+	/* Avoid reserved HyperTransport region on AMD or Hygon processors. */
+	if (!host_cpu_is_amd_compatible)
 		return max_gfn;
 
 	/* On parts with <40 physical address bits, the area is fully hidden */
@@ -1405,7 +1408,7 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 
 	/*
 	 * Otherwise it's at the top of the physical address space, possibly
-	 * reduced due to SME by bits 11:6 of CPUID[0x8000001f].EBX.  Use
+	 * reduced due to SME or CSV by bits 11:6 of CPUID[0x8000001f].EBX.  Use
 	 * the old conservative value if MAXPHYADDR is not enumerated.
 	 */
 	if (!this_cpu_has_p(X86_PROPERTY_MAX_PHY_ADDR))
@@ -1427,6 +1430,7 @@ void kvm_selftest_arch_init(void)
 	host_cpu_is_intel = this_cpu_is_intel();
 	host_cpu_is_amd = this_cpu_is_amd();
 	host_cpu_is_hygon = this_cpu_is_hygon();
+	host_cpu_is_amd_compatible = host_cpu_is_amd || host_cpu_is_hygon;
 	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	kvm_init_pmu_errata();
diff --git a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
index 762628f7d4ba..00b6e85735dd 100644
--- a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
@@ -52,7 +52,7 @@ static void guest_main(void)
 	if (host_cpu_is_intel) {
 		native_hypercall_insn = vmx_vmcall;
 		other_hypercall_insn  = svm_vmmcall;
-	} else if (host_cpu_is_amd) {
+	} else if (host_cpu_is_amd_compatible) {
 		native_hypercall_insn = svm_vmmcall;
 		other_hypercall_insn  = vmx_vmcall;
 	} else {
diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index 40d918aedce6..4c97444fdefe 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -81,7 +81,7 @@ static u64 fixup_rdmsr_val(u32 msr, u64 want)
 	 * is supposed to emulate that behavior based on guest vendor model
 	 * (which is the same as the host vendor model for this test).
 	 */
-	if (!host_cpu_is_amd)
+	if (!host_cpu_is_amd_compatible)
 		return want;
 
 	switch (msr) {
diff --git a/tools/testing/selftests/kvm/x86/xapic_state_test.c b/tools/testing/selftests/kvm/x86/xapic_state_test.c
index 3b4814c55722..0c5e12f5f14e 100644
--- a/tools/testing/selftests/kvm/x86/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_state_test.c
@@ -248,7 +248,7 @@ int main(int argc, char *argv[])
 	 * drops writes, AMD does not).  Account for the errata when checking
 	 * that KVM reads back what was written.
 	 */
-	x.has_xavic_errata = host_cpu_is_amd &&
+	x.has_xavic_errata = host_cpu_is_amd_compatible &&
 			     get_kvm_amd_param_bool("avic");
 
 	vcpu_clear_cpuid_feature(x.vcpu, X86_FEATURE_X2APIC);
-- 
2.43.0

