Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619733;
	b=co74pB3kfHlepYN+pCnB2F9f+IAQTB1a1ZF5cT9mxbArt2bFbrBW8hbl5Hud7xyYBhLW
	 eZHgg6G+Kjf9C01BRu1LRDSqm0vq1yOZXavmskTfzhnfPLfpk6gp8JzepxBZGYRfAeVPn
	 l/y/kIludPjaLlVdNmkTCg7CsJJpssFjqr/us+XfBPQy+Rvyh2x+Z2/ZS1iG26QKGQL+5
	 0wpEhYQjvn5WZjzkQVSSTB7H6k2ANmwYVsWeuQo1IanQwVzWY737qwmWJ04zsKdvZrEx8
	 0gFCf2Sq3UPJzFs5Ad4TDn6ETi+ePzwq3FHBmTyuWtMrQD6AB2CcvGClFGVaOqeXfRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619733;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SdG6k/fm+cjC6ftUgRYpN6R8s8VTL7ygwpdINXwatvE=;
	b=TmcaQnkhdypgNp3lFF5mZULeiPKAMB43EB4kDalkwrhXNtnxvCHV/9dIPwfGhxahr22l
	 Pf/h53OhAixglVeb9qVHSoi0th+AoVV/qaBXq779OShyNatipAtQJrgXG2JnVkB3PdsHA
	 zsSdvyM4OHGQjvTQ11grzrqPQqRE9jx/3hAqGpGSwk9+wALE3n9Tor8t1PEInUg9v8dxp
	 leNnMmqIGJ3M94mp6X8UKduO+3bZfU1B4grKEbJ0k5rMrnZAWE2MMON9sKfA9KKzVmXvK
	 5hqQCVpfFH+ZWeBursG7kXnFBY4d1sEvWeoT9e9b9x03XvP7mCM9yK/pNel7cu/3aKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AAB60A2635;
	Mon,  2 Nov 2026 11:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AAB60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0D427243ADC;
	Mon,  2 Nov 2026 12:42:05 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joro@8bytes.org
Subject: [PATCH v3 7/8] KVM: selftests: Test the SNP APIC-ID-list GHCB request
Date: Mon,  2 Nov 2026 12:41:36 +0100
Message-ID: <20261102114137.1198982-8-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102114137.1198982-1-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
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

From: Joerg Roedel <joerg.roedel@amd.com>

Exercise the GET_AP_APIC_IDS NAE event from an SNP guest using a test-local
GHCB encoder.  Verify the exact count and APIC IDs, missing RAX validity,
zero-sized requests, invalid GPAs, and the 1024-vCPU descriptor boundary
when supported.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/sev_snp_apic_id_test.c  | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..9f2b15250a2a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -154,6 +154,7 @@ TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_dbg_test
 TEST_GEN_PROGS_x86 += x86/sev_init2_tests
 TEST_GEN_PROGS_x86 += x86/sev_migrate_tests
+TEST_GEN_PROGS_x86 += x86/sev_snp_apic_id_test
 TEST_GEN_PROGS_x86 += x86/sev_smoke_test
 TEST_GEN_PROGS_x86 += x86/amx_test
 TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
diff --git a/tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c b/tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c
new file mode 100644
index 000000000000..8ad9c15091c2
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <stdint.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "sev.h"
+#include "svm_util.h"
+
+#define GHCB_SAVE_RAX_OFFSET		0x1f8
+#define GHCB_SAVE_SW_EXIT_CODE_OFFSET	0x390
+#define GHCB_SAVE_SW_EXIT_INFO_1_OFFSET	0x398
+#define GHCB_SAVE_SW_EXIT_INFO_2_OFFSET	0x3a0
+#define GHCB_SAVE_VALID_BITMAP_OFFSET	0x3f0
+
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_RESP		0x013
+#define GHCB_MSR_INFO_MASK		GENMASK_ULL(11, 0)
+
+#define GHCB_HV_RESP_MALFORMED_INPUT	2
+#define GHCB_ERR_MISSING_INPUT		4
+#define GHCB_ERR_INVALID_INPUT		5
+
+struct apic_id_desc {
+	u32 nr_entries;
+	u32 apic_ids[];
+};
+
+struct apic_id_results {
+	u64 missing_info1;
+	u64 missing_info2;
+	u64 zero_info1;
+	u64 zero_info2;
+	u64 zero_rax;
+	u64 invalid_info1;
+	u64 invalid_info2;
+	u64 valid_info1;
+	u64 valid_info2;
+	u32 nr_entries;
+	u32 first_apic_id;
+	u32 last_apic_id;
+};
+
+static void ghcb_set_field(void *ghcb, size_t offset, u64 value, bool valid)
+{
+	u8 *valid_bitmap = ghcb + GHCB_SAVE_VALID_BITMAP_OFFSET;
+
+	*(u64 *)(ghcb + offset) = value;
+	if (valid)
+		valid_bitmap[(offset / sizeof(u64)) / 8] |=
+			BIT((offset / sizeof(u64)) % 8);
+}
+
+static u64 ghcb_get_field(void *ghcb, size_t offset)
+{
+	return *(u64 *)(ghcb + offset);
+}
+
+static void do_get_apic_ids(void *ghcb, gpa_t buffer_gpa, u64 pages,
+			    bool rax_valid)
+{
+	memset(ghcb, 0, PAGE_SIZE);
+	ghcb_set_field(ghcb, GHCB_SAVE_SW_EXIT_CODE_OFFSET,
+		       SVM_VMGEXIT_GET_APIC_IDS, true);
+	ghcb_set_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_1_OFFSET, buffer_gpa, true);
+	ghcb_set_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_2_OFFSET, 0, true);
+	ghcb_set_field(ghcb, GHCB_SAVE_RAX_OFFSET, pages, rax_valid);
+	vmgexit();
+}
+
+static void guest_code(void *ghcb, gpa_t ghcb_gpa, void *list,
+		       gpa_t list_gpa, struct apic_id_results *results,
+		       u64 expected_vcpus)
+{
+	struct apic_id_desc *desc = list;
+	u64 msr;
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB,
+	      (ghcb_gpa >> PAGE_SHIFT) << PAGE_SHIFT | GHCB_MSR_REG_GPA_REQ);
+	vmgexit();
+	msr = rdmsr(MSR_AMD64_SEV_ES_GHCB);
+	if ((msr & GHCB_MSR_INFO_MASK) != GHCB_MSR_REG_GPA_RESP)
+		goto terminate;
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+
+	do_get_apic_ids(ghcb, list_gpa, 1, false);
+	results->missing_info1 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_1_OFFSET);
+	results->missing_info2 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_2_OFFSET);
+
+	do_get_apic_ids(ghcb, list_gpa, 0, true);
+	results->zero_info1 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_1_OFFSET);
+	results->zero_info2 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_2_OFFSET);
+	results->zero_rax = ghcb_get_field(ghcb, GHCB_SAVE_RAX_OFFSET);
+
+	do_get_apic_ids(ghcb, BIT_ULL(52), 2, true);
+	results->invalid_info1 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_1_OFFSET);
+	results->invalid_info2 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_2_OFFSET);
+
+	do_get_apic_ids(ghcb, list_gpa, 2, true);
+	results->valid_info1 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_1_OFFSET);
+	results->valid_info2 = ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_2_OFFSET);
+	results->nr_entries = desc->nr_entries;
+	results->first_apic_id = desc->apic_ids[0];
+	results->last_apic_id = desc->apic_ids[expected_vcpus - 1];
+
+terminate:
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+	vmgexit();
+}
+
+static void run_apic_id_test(unsigned int nr_vcpus)
+{
+	struct apic_id_results *results;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gva_t ghcb_gva, list_gva, results_gva;
+	gpa_t ghcb_gpa, list_gpa;
+	unsigned int i;
+
+	kvm_set_files_rlimit(nr_vcpus);
+	vm = vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code, &vcpu);
+	for (i = 1; i < nr_vcpus; i++)
+		__vm_vcpu_add(vm, i);
+
+	ghcb_gva = vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+				   MEM_REGION_TEST_DATA);
+	list_gva = vm_alloc_shared(vm, 2 * PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+				   MEM_REGION_TEST_DATA);
+	results_gva = vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+				      MEM_REGION_TEST_DATA);
+	ghcb_gpa = addr_gva2gpa(vm, ghcb_gva);
+	list_gpa = addr_gva2gpa(vm, list_gva);
+	results = addr_gva2hva(vm, results_gva);
+
+	vcpu_args_set(vcpu, 6, ghcb_gva, ghcb_gpa, list_gva, list_gpa,
+		      results_gva, nr_vcpus);
+	memset(addr_gva2hva(vm, ghcb_gva), 0, PAGE_SIZE);
+	memset(addr_gva2hva(vm, list_gva), 0, 2 * PAGE_SIZE);
+	memset(results, 0, PAGE_SIZE);
+	vm_sev_launch(vm, snp_default_policy(), NULL);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
+
+	TEST_ASSERT_EQ(results->missing_info1, GHCB_HV_RESP_MALFORMED_INPUT);
+	TEST_ASSERT_EQ(results->missing_info2, GHCB_ERR_MISSING_INPUT);
+	TEST_ASSERT_EQ(results->zero_info1, 0);
+	TEST_ASSERT_EQ(results->zero_info2, 0);
+	TEST_ASSERT_EQ(results->zero_rax,
+		       DIV_ROUND_UP(sizeof(struct apic_id_desc) + nr_vcpus * sizeof(u32),
+				    PAGE_SIZE));
+	TEST_ASSERT_EQ(results->invalid_info1, GHCB_HV_RESP_MALFORMED_INPUT);
+	TEST_ASSERT_EQ(results->invalid_info2, GHCB_ERR_INVALID_INPUT);
+	TEST_ASSERT_EQ(results->valid_info1, 0);
+	TEST_ASSERT_EQ(results->valid_info2, 0);
+	TEST_ASSERT_EQ(results->nr_entries, nr_vcpus);
+	TEST_ASSERT_EQ(results->first_apic_id, 0);
+	TEST_ASSERT_EQ(results->last_apic_id, nr_vcpus - 1);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int max_vcpus;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SNP_VM));
+	run_apic_id_test(2);
+
+	/* 1024 IDs cross the one-page descriptor boundary. */
+	max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	if (max_vcpus >= 1024)
+		run_apic_id_test(1024);
+	else
+		pr_info("Skipping vCPU-count boundary test (max vCPUs: %u)\n", max_vcpus);
+
+	return 0;
+}
-- 
2.53.0

