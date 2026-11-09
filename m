Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259377;
	b=Bhp1u0Z+Tt0aWyuSGg05ojY5tsDKqRujOuX3Mwzy4IK/3nkdtp58YBPjggzEMl1+zYna
	 arBGkOgeMIRp9HXI1IFE13cm9mJ7gO/6OsQ1PhDNU05hJU4/q1xt/wzbdTAM5ieFmqEqP
	 DarFiGcpyOL+HOw5BYp3vpun0uz8Ltg56I11bwgpYTT1FRJFAISD2nW7HPeF11zbNOZcJ
	 pKIpfA9kedcB5LIIabt2Z3+UgRs2NHIgxr58gQaDf3nwGvOYsgCVdho/KvuKy0uvn5Tku
	 ufCJh3x7A3396es/Z9f6el+dGiapgcyVM7tKNLoRl1Yz2F+uONIWIexl6lJTjQPlxhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=AHrKcHvKxmKBcKqar2+I9Jzb282iFMlFO6YNjB363vY=;
	b=k18IaxITOymM4yOKRO0Yav4OooZ4JEojNuXWBFveVg7JAX6hdC1azKhIWmHNAC2Fi8Ki
	 Q77ZJ3BbAhJzTl89d60TZ4mRibEJ5klPUEyV2rSzUN75rHqYzyMbOFoQ8cSFrrjL63STO
	 IM1g16PX8S8ddO+ALOWYmSfk+S0Os6F91rLOwwZp6GnSQTpCVb1XZFbo1Kb0oPA8c35xP
	 hyf9vytb13aCa8I/bUJURWSbh2CiiOzLSp3sIp8jrnbABht6Ug3P+Biy+CBEZ/9RbblY8
	 jfVANfoO6A10wv6wFCObCzBD9EiYaFkanF3PYitpW3V2aFcD0KvIMUC1ID6AbIttcCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=LCXlmTEn;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E8606A325;
	Mon,  9 Nov 2026 21:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841E8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=LCXlmTEn
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9EJIKN619456;
	Mon, 9 Nov 2026 21:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=AHrKc
	HvKxmKBcKqar2+I9Jzb282iFMlFO6YNjB363vY=; b=LCXlmTEnrTi4QAnsxwdcb
	kd4Adj5i9Weq0E+TfVHLaDzWRb4SZvjelaqBL27/GIp1FtVlSPCKmadPF9bg3pfR
	4AMOjJaUi9FKMbLKaUgi+XYsur+QPe5hlnsww13VF+HO1aban/lGveVgtX2VSQxM
	KMzn735yapWGZwvHfDtxfWAkVt+xO1N03Dvi8LX4e9d9uOT48g+HgPpIVUEbnnXX
	5oJ4fJ6oJH24UBJFROE2U88xcRKFlBGFMrK1RVpBHU0uG8H8bo21p7cuSe2Q63AI
	stVXTxsIv9FApnMZHoRPtGTNDpJ8+cIdgvqHB71pZCDcH3ibWdppUmrKuVyV2GEy
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hstjy36d0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 09 Nov 2026 21:22:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9L86bX3131987;
	Mon, 9 Nov 2026 21:22:51 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.206])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4humgdtyrh-3;
	Mon, 09 Nov 2026 21:22:50 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
        partha.satapathy@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 2/2] KVM: selftests: Test exact vCPU ID matching for aliased xAPIC IDs
Date: Mon,  9 Nov 2026 21:22:48 +0000
Message-ID: <20261109212248.996736-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109212248.996736-1-alejandro.j.jimenez@oracle.com>
References: <20261109212248.996736-1-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NCBTYWx0ZWRfX3OVLsG25jKG3
 gBDkVi4HCGyOY81GYCIp6Hshziti2yKGELG+G2ueGct61gFbpFKNqVgYmClHbkK1PXhY+RiGOS+
 FklVdjhPUlL0PaGhIuLk58xH+3Q4bi65+U38ypxRp37Ao/1kG3KZXvBGsr+T0bT+S/qYcdy0L8I
 mf47O1chpFPJSLYCHNOIxwVJKOH4xJM5kXC+WZQ1poRZ/3SjSvG8+oM03GLqAjs4Qeqd+cSi263
 qq94x/oR09fwitX3ZujUnwkjzQnxS3X34u+FkOP4y/SILSIRwgfHeUIWbr0s67av+9yj3Vu+G7B
 HbA4P8GurC4FVTBgvaZ0w1XQCGkhr9614M/DBghPkOTRM3eBSii6rqZwYNm8WDMbm+8lEHOpazy
 Ca7Oxj/Rj9DXQMosQhx/4R05CvsUN7JaJlg3R3pZp1KO8wT9Jm6rOrxeyuh8SHRMzN1EZ/BS66T
 Jc8eOWnJmOXZrTbOo2g==
X-Authority-Analysis: v=2.4 cv=XNql2ghE c=1 sm=1 tr=0 ts=6af239ab cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=5r-PD7aOuWtwVV6pXN4A:9
X-Proofpoint-GUID: P8nEEVGTVXEC-NbOCC3v8Hpy5pKEvkBT
X-Proofpoint-ORIG-GUID: P8nEEVGTVXEC-NbOCC3v8Hpy5pKEvkBT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NCBTYWx0ZWRfX/9cNUjBY7FDl
 9tpG4+2thjivTRMGHXgU803J2aTI+OW/8fvqUwyKB2K4UGpRogkg2h4gJODaR3k64En1j9MHfj9
 R2LX6eRGLbUBq1g8HcK3Z39qPSo9P5FtsUiZ9htJH1EmK+lFfpNo

When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's documented behavior has
the side effect of delivering events targeting an aliased physical APIC ID
only to the vCPU whose vCPU ID matches the aliased x2APIC ID.
This behavior should be consistent regardless of vCPU creation order.

Add a test using two vCPU IDs that alias to the same xAPIC ID e.g. vCPU IDs
29 and 285, which both resolve to xAPIC ID 29. Exercise both creation
orders in separate VMs to detect selection based on creation order instead
of vCPU ID.

Inject a physical, fixed-delivery MSI and verify that only the vCPU with
the ID matching the destination xAPIC ID has the vector pending.
The LAPIC state is retrieved without running either vCPU, so the interrupt
is not consumed before the check.

Additionally, target the higher-ID vCPU using its full x2APIC ID to verify
that it remains reachable in xAPIC mode.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/apic_id_routing_test.c  | 217 ++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/apic_id_routing_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..4c0bd5da170f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -141,6 +141,7 @@ TEST_GEN_PROGS_x86 += x86/vmx_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_invalid_nested_guest_state
 TEST_GEN_PROGS_x86 += x86/vmx_nested_la57_state_test
 TEST_GEN_PROGS_x86 += x86/apic_bus_clock_test
+TEST_GEN_PROGS_x86 += x86/apic_id_routing_test
 TEST_GEN_PROGS_x86 += x86/xapic_ipi_test
 TEST_GEN_PROGS_x86 += x86/xapic_state_test
 TEST_GEN_PROGS_x86 += x86/xapic_tpr_test
diff --git a/tools/testing/selftests/kvm/x86/apic_id_routing_test.c b/tools/testing/selftests/kvm/x86/apic_id_routing_test.c
new file mode 100644
index 000000000000..ac51d849e33e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/apic_id_routing_test.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test physical APIC ID routing for xAPIC-mode vCPUs with aliased IDs.
+ */
+
+#include <sys/ioctl.h>
+
+#include "processor.h"
+#include "test_util.h"
+#include "kvm_util.h"
+#include "apic.h"
+
+#define MAX_XAPIC_ID		0xff
+
+#define ALIAS_LOW_VCPU_ID	0x1d	/* i.e. a non-broadcast xAPIC ID */
+#define ALIAS_HIGH_VCPU_ID	(ALIAS_LOW_VCPU_ID | 0x100)
+#define ALIAS_VECTOR		0xe0
+#define FULL_ID_VECTOR		0xe1
+
+static void assert_lapic_xapic_mode(struct kvm_vcpu *vcpu)
+{
+	u64 apicbase = vcpu_get_msr(vcpu, MSR_IA32_APICBASE);
+
+	TEST_ASSERT(apicbase & MSR_IA32_APICBASE_ENABLE,
+		    "vCPU %u local APIC not in ENABLED state at vCPU RESET",
+		    vcpu->id);
+	TEST_ASSERT(!(apicbase & X2APIC_ENABLE),
+		    "vCPU %u local APIC not in xAPIC mode at vCPU RESET",
+		    vcpu->id);
+}
+
+static void assert_lapic_xapic_id(struct kvm_vcpu *vcpu, u32 expected_id)
+{
+	struct kvm_lapic_state lapic;
+	u32 apic_id;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	apic_id = *(u32 *)(lapic.regs + APIC_ID);
+	apic_id = GET_APIC_ID_FIELD(apic_id);
+
+	TEST_ASSERT(apic_id == expected_id,
+		    "vCPU %u: expected xAPIC ID %u, read %u",
+		    vcpu->id, expected_id, apic_id);
+}
+
+/* Set APIC Software Enable bit in SPIV to allow fixed interrupt delivery */
+static void lapic_sw_enable(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic_state lapic;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	*(u32 *)(lapic.regs + APIC_SPIV) |= APIC_SPIV_APIC_ENABLED;
+	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &lapic);
+}
+
+/* Determine if @vector is marked pending in @vcpu's LAPIC IRR register */
+static bool lapic_irr_has_vector(struct kvm_vcpu *vcpu, u8 vector)
+{
+	struct kvm_lapic_state lapic;
+	u32 irr;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	irr = *((u32 *)(lapic.regs + APIC_IRR +
+		APIC_VECTOR_TO_REG_OFFSET(vector)));
+
+	return irr & BIT(APIC_VECTOR_TO_BIT_NUMBER(vector));
+}
+
+static void inject_msi(struct kvm_vm *vm, u32 dest_id, u8 vector)
+{
+	struct kvm_msi msi = {
+		/*
+		 * On x86, address_lo bits [31:20] contain the MSI address
+		 * prefix (0xfee), and bits [19:12] encode destination ID bits
+		 * [7:0].
+		 * destination mode (bit 2) is clear for physical addressing.
+		 */
+		.address_lo = APIC_DEFAULT_GPA | ((dest_id & 0xff) << 12),
+		/*
+		 * On x86 with KVM_X2APIC_API_USE_32BIT_IDS feature enabled,
+		 * address_hi bits [31:8] encode bits [31:8] of the destination
+		 * id. Bits [7:0] of address_hi must be zero.
+		 */
+		.address_hi = dest_id & 0xffffff00,
+		/*
+		 * Data bits [7:0] contain the vector. delivery mode bits [10:8]
+		 * and trigger mode (bit 15) are set to 0 for fixed,
+		 * edge-triggered delivery.
+		 */
+		.data = vector & 0xff,
+	};
+
+	TEST_ASSERT(__vm_ioctl(vm, KVM_SIGNAL_MSI, &msi) == 1,
+		    "KVM_SIGNAL_MSI ioctl failed");
+}
+
+static void report_irq_delivery(bool test_passed, bool high_first,
+				u32 dest_id, u8 vector,
+				bool high_has_irq, bool low_has_irq)
+{
+	const char *first_id_type = high_first ? "Higher" : "Lower";
+	u32 first_vcpu_id = high_first ? ALIAS_HIGH_VCPU_ID : ALIAS_LOW_VCPU_ID;
+
+	ksft_test_result(test_passed,
+			 "Destination %#x: %s-ID vCPU %u created first.\n",
+			 dest_id, first_id_type, first_vcpu_id);
+	ksft_print_msg("Expected IRQ only on vCPU %u.\n", dest_id);
+	ksft_print_msg("Higher-ID vCPU %u: IRQ vector %#x %s.\n",
+		       ALIAS_HIGH_VCPU_ID, vector,
+		       high_has_irq ? "delivered" : "not delivered");
+	ksft_print_msg("Lower-ID vCPU %u: IRQ vector %#x %s.\n",
+		       ALIAS_LOW_VCPU_ID, vector,
+		       low_has_irq ? "delivered" : "not delivered");
+}
+
+static void test_apic_id_routing(bool high_first)
+{
+	struct kvm_vcpu *low_vcpu, *high_vcpu;
+	struct kvm_vm *vm;
+	bool high_has_irq;
+	bool low_has_irq;
+
+	/* Create a VM with two vCPUs and enable 32-bit APIC IDs */
+	vm = vm_create(2);
+	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS);
+
+	/*
+	 * Create two vCPUs which alias to the same physical xAPIC ID.
+	 * With KVM_X2APIC_API_USE_32BIT_IDS enabled and vCPUs in xAPIC mode,
+	 * interrupts must be delivered to the vCPU whose vCPU ID matches the
+	 * xAPIC ID, regardless of vCPU creation order.
+	 */
+	if (high_first) {
+		high_vcpu = vm_vcpu_add(vm, ALIAS_HIGH_VCPU_ID, NULL);
+		low_vcpu = vm_vcpu_add(vm, ALIAS_LOW_VCPU_ID, NULL);
+	} else {
+		low_vcpu = vm_vcpu_add(vm, ALIAS_LOW_VCPU_ID, NULL);
+		high_vcpu = vm_vcpu_add(vm, ALIAS_HIGH_VCPU_ID, NULL);
+	}
+
+	/* Ensure local APICs are enabled and in xAPIC mode */
+	assert_lapic_xapic_mode(high_vcpu);
+	assert_lapic_xapic_mode(low_vcpu);
+	lapic_sw_enable(high_vcpu);
+	lapic_sw_enable(low_vcpu);
+
+	/* Verify both LAPICs expose the shared physical destination ID. */
+	assert_lapic_xapic_id(high_vcpu, ALIAS_LOW_VCPU_ID);
+	assert_lapic_xapic_id(low_vcpu, ALIAS_LOW_VCPU_ID);
+
+	/* The vector to be tested must not be pending at this point */
+	TEST_ASSERT(!lapic_irr_has_vector(high_vcpu, ALIAS_VECTOR),
+		    "vCPU %u: vector %#x already pending before MSI injection",
+		    high_vcpu->id, ALIAS_VECTOR);
+	TEST_ASSERT(!lapic_irr_has_vector(low_vcpu, ALIAS_VECTOR),
+		    "vCPU %u: vector %#x already pending before MSI injection",
+		    low_vcpu->id, ALIAS_VECTOR);
+
+	/*
+	 * Inject an MSI message to the shared xAPIC ID. The vCPUs are not
+	 * yet running, so KVM_GET_LAPIC can be used later to check for pending
+	 * interrupts in IRR, and confirm interrupt was delivered to expected
+	 * vCPU.
+	 */
+	inject_msi(vm, ALIAS_LOW_VCPU_ID, ALIAS_VECTOR);
+
+	high_has_irq = lapic_irr_has_vector(high_vcpu, ALIAS_VECTOR);
+	low_has_irq = lapic_irr_has_vector(low_vcpu, ALIAS_VECTOR);
+
+	report_irq_delivery(!high_has_irq && low_has_irq,
+			    high_first, ALIAS_LOW_VCPU_ID, ALIAS_VECTOR,
+			    high_has_irq, low_has_irq);
+
+	/*
+	 * The higher-ID vCPU must remain reachable by its full x2APIC ID
+	 * while in xAPIC mode, to allow vCPU hotplug. Use a different vector
+	 * to avoid conflicts with the previous aliased test case.
+	 */
+	TEST_ASSERT(!lapic_irr_has_vector(high_vcpu, FULL_ID_VECTOR),
+		    "vCPU %u: vector %#x already pending before MSI injection",
+		    high_vcpu->id, FULL_ID_VECTOR);
+	TEST_ASSERT(!lapic_irr_has_vector(low_vcpu, FULL_ID_VECTOR),
+		    "vCPU %u: vector %#x already pending before MSI injection",
+		    low_vcpu->id, FULL_ID_VECTOR);
+
+	inject_msi(vm, ALIAS_HIGH_VCPU_ID, FULL_ID_VECTOR);
+
+	high_has_irq = lapic_irr_has_vector(high_vcpu, FULL_ID_VECTOR);
+	low_has_irq = lapic_irr_has_vector(low_vcpu, FULL_ID_VECTOR);
+
+	report_irq_delivery(high_has_irq && !low_has_irq,
+			    high_first, ALIAS_HIGH_VCPU_ID, FULL_ID_VECTOR,
+			    high_has_irq, low_has_irq);
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	kvm_static_assert(ALIAS_HIGH_VCPU_ID > MAX_XAPIC_ID);
+	kvm_static_assert((ALIAS_HIGH_VCPU_ID & MAX_XAPIC_ID) ==
+			  ALIAS_LOW_VCPU_ID);
+
+	ksft_print_header();
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_X2APIC_API) &
+		     KVM_X2APIC_API_USE_32BIT_IDS);
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SIGNAL_MSI));
+	/* Ensure max vcpu id is enough to hold high aliased ID */
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MAX_VCPU_ID) > ALIAS_HIGH_VCPU_ID);
+
+	ksft_set_plan(4);
+
+	test_apic_id_routing(false);
+	test_apic_id_routing(true);
+
+	ksft_finished();
+}
-- 
2.47.3

