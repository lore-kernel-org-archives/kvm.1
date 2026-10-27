Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078318;
	b=DMwHaUmG0c97/UocyC75RgKzRlOrhDOYoc1j+HGjloz/FQ7QhPs4oriEWjnQ20EOuZUs
	 kosiY42NJHFLq2/1x1qKgFIwB+NTbhxplFcWnvXctj2ibQEKC10rr/0ulJOi2PepGEpr4
	 592J7pxIpBwTh6ahvRJX20dDkv3aiW4r8m8enqB6noqOwnFGgeBg24TFwXKxM3WBK93Iu
	 Uc2U7SuHLzUHi4zDCkvIzmmG7seY+XVUSNx3bhscdDp7f/LgmnYxfp8/BHx5zOqtKUpEK
	 vAqD3e7Tq4KF9p4AhsiYhPATkDtDCs24ECReQnHXnAFcP/Y0ufqosFRVdNwJyUu9UTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078318;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc;
	bh=KUJ9mlNmlf30JwpEjhAeYkYv57hqIjAOSPS8ZtwYsSc=;
	b=lbBB9tn+fie679dPYRwciI/k/axexqpMAohKwBmmfPLeEneTUDghzLJkSGp4ocOgI96+
	 e2j+bmKTq8vuGcetKJ23RbrSyZK83HFGQklZ3CJw7j3pRnU5LSt0QL742WuqkOSBbb6N8
	 nK2Ge9Xw1606bd6+0VMwmxI2pM69rt0B5nMTp8mHR1KPn5Tuv5PKIcfe9LElm+EUaz3hT
	 47FyuqFIjcb8cEasSgEAg3s4iS2uvHF+2BYZYS4TeK+wrN6sVitbaCkyvM002zCA8azWd
	 JlnrvDRkZOBt5bozObDyr50aMmHi2goN1XmzLp0KCtCID5aortM2HaavO1hidp5uFfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hPAAUBDR;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88F606A31B;
	Tue, 27 Oct 2026 05:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D88F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hPAAUBDR
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QIfZ4X328518;
	Tue, 27 Oct 2026 05:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KUJ9m
	lNmlf30JwpEjhAeYkYv57hqIjAOSPS8ZtwYsSc=; b=hPAAUBDRI3rrtTdN6qUdT
	8Z2WYknsdEFXrz1XbEQ7eSb27CNsAVV71DwtgFVIW6S15wADPC9CqfTSs0KToaRN
	vyh7qeV8bvI5RaDD4hNY9l+JRvkKw58RFJWmJpmLdmyaToK4M9dpIcn1f335LOVy
	htEk5La6geKXfoXoAN8ehOKIcs8gWmnYZwAxRazOyiN+G1KL1ui+s1ZNB2nqYQ4r
	Da28F83tHgSZZQ67h+/H0ywqaQK1VDDRjv2y3m3SavZTu4RSVAIRHrtJPzVqfcJ1
	ADduSF9pEJT57mRWVdwZeisPSF+Kr/2hF5iU9L/tzOrYCEO+gO0hiG6bLEdLI3ak
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgmqbkh1s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 05:18:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69R576jJ4037703;
	Tue, 27 Oct 2026 05:18:21 GMT
Received: from pssatapa-ol8-test.osdevelopmeniad.oraclevcn.com (pssatapa-ol8-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hjja0x17s-2;
	Tue, 27 Oct 2026 05:18:20 +0000 (GMT)
From: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Cover aliased xAPIC physical IDs
Date: Tue, 27 Oct 2026 05:18:08 +0000
Message-ID: <20261027051808.243000-2-partha.satapathy@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261027051808.243000-1-partha.satapathy@oracle.com>
References: <20261027051808.243000-1-partha.satapathy@oracle.com>
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
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270020
X-Authority-Analysis: v=2.4 cv=HM1WhYtv c=1 sm=1 tr=0 ts=6ae0341e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=vYnsLoF1qZxj3ZoKGw8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX9lPbJTAmsm1+
 6o52RepyR5Z2iYymQsdZlSi6WblZT9SWmShdCaWkVh48B1nQ5SjrMwLaqQV1Sgqf+EPa2p6A/kd
 7DCkw4tq5CFXEEwuTeQfsZMasA4CtvIu4+h63fr6B/agnRQ8lwLv
X-Proofpoint-ORIG-GUID: 6p43hpH8uyZGQ6c8LKvMrquQb8epEOQU
X-Proofpoint-GUID: 6p43hpH8uyZGQ6c8LKvMrquQb8epEOQU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX3oS16cplf+C2
 yXA8UXYtqElpsN6urRvvldDjF3lKnGnbXopwjVLxZFsFkGjmdb3dCc7H/3mAegpkEEo6e3LbL1H
 SXcX6P2eJmx3+Io/vKbvPzgMIE9FunIcUt0/8MCHyCby7BJyYZpxD0b/yYPWAWyvLWXSvdQ2taF
 f5demB2u3zoBzJp5bcGWhsKc7YIYQp3xIv6Eac5V+D67mD+iWD4gqVcYqogmHGIz7pfKBIAffJn
 rn7kGknTuZfcttDaRV5r5n1LLdfJd7TS6xTn++RqB+gLUAXmP/0xPpoz/Wjgl1iCEMh8QaLFwqw
 LGmdwNLMJ3XWolFylz4aYYbGYrNptzDlVrZv30sZ3robCI+WaGy9hzBEhBIQ+O3PpJ65fC65A14
 RluNY/6sGJ6lY1+Zs7QeS2NQwy/5hGed/0GqOEsQnP4sHA6MRiaJiQMda8q8ON1FcLVHwEjep7q
 mezJ/YaCtAMA+gt45+A==

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The optimized physical APIC map must select the lowest vCPU ID
when multiple xAPIC-mode vCPUs share an effective physical APIC ID.

Extend recalc_apic_map_test with a regression test that enables
KVM_X2APIC_API_USE_32BIT_IDS and creates vCPU 285 before vCPU 29.
Keep both LAPICs in xAPIC mode, where their physical APIC IDs alias
to 0x1d.

Inject an MSI to destination 0x1d and verify that its vector is
pending only in vCPU 29's IRR. This checks lowest-ID selection when
the higher-ID alias is created first.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
Signed-off-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
---
 .../selftests/kvm/x86/recalc_apic_map_test.c  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c b/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c
index cbc92a862ea9..88959adde14d 100644
--- a/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c
+++ b/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c
@@ -18,6 +18,100 @@
 #define LAPIC_X2APIC	(MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE)
 #define MAX_XAPIC_ID	0xff
 
+#define ALIAS_LOW_VCPU_ID	29
+#define ALIAS_HIGH_VCPU_ID	(ALIAS_LOW_VCPU_ID | 0x100)
+#define ALIAS_VECTOR		0xe1
+#define X86_MSI_BASE_ADDRESS	0xfee00000
+
+static void assert_lapic_xapic_mode(struct kvm_vcpu *vcpu)
+{
+	u64 apicbase = vcpu_get_msr(vcpu, MSR_IA32_APICBASE);
+
+	TEST_ASSERT(apicbase & MSR_IA32_APICBASE_ENABLE,
+		    "vCPU %u local APIC is not enabled, APICBASE=%#lx",
+		    vcpu->id, (unsigned long)apicbase);
+	TEST_ASSERT(!(apicbase & X2APIC_ENABLE),
+		    "vCPU %u unexpectedly entered x2APIC mode, APICBASE=%#lx",
+		    vcpu->id, (unsigned long)apicbase);
+}
+
+static void lapic_sw_enable(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic_state lapic;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	*((u32 *)&lapic.regs[APIC_SPIV]) |= APIC_SPIV_APIC_ENABLED;
+	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &lapic);
+}
+
+static bool lapic_irr_has_vector(struct kvm_vcpu *vcpu, u32 vector)
+{
+	struct kvm_lapic_state lapic;
+	u32 irr;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	irr = *((u32 *)&lapic.regs[APIC_IRR + APIC_VECTOR_TO_REG_OFFSET(vector)]);
+
+	return irr & (1u << APIC_VECTOR_TO_BIT_NUMBER(vector));
+}
+
+static void signal_msi(struct kvm_vm *vm, u32 dest_id, u8 vector)
+{
+	struct kvm_msi msi = {
+		.address_lo	= X86_MSI_BASE_ADDRESS | (dest_id << 12),
+		.address_hi	= 0,
+		.data		= vector,
+	};
+	int r;
+
+	r = __vm_ioctl(vm, KVM_SIGNAL_MSI, &msi);
+	TEST_ASSERT(r == 1, "KVM_SIGNAL_MSI should deliver 1 IRQ, got %d", r);
+}
+
+static void test_xapic_alias_lowest_vcpu_id(void)
+{
+	struct kvm_vcpu *high, *low;
+	struct kvm_vm *vm;
+	bool high_has_irq;
+	bool low_has_irq;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_X2APIC_API) &
+		     KVM_X2APIC_API_USE_32BIT_IDS);
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SIGNAL_MSI));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MAX_VCPU_ID) > ALIAS_HIGH_VCPU_ID);
+
+	vm = vm_create(2);
+	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS);
+
+	/*
+	 * Reproduce hotplug ordering where the vCPU with x2APIC ID 0x11d is
+	 * created before the vCPU with x2APIC ID 0x1d.  In xAPIC mode they
+	 * alias to physical APIC ID 0x1d.  With KVM_X2APIC_API_USE_32BIT_IDS,
+	 * KVM's ABI says aliased physical APIC events are delivered only to
+	 * the lowest vCPU ID.
+	 */
+	high = vm_vcpu_add(vm, ALIAS_HIGH_VCPU_ID, NULL);
+	low = vm_vcpu_add(vm, ALIAS_LOW_VCPU_ID, NULL);
+
+	assert_lapic_xapic_mode(high);
+	assert_lapic_xapic_mode(low);
+
+	lapic_sw_enable(high);
+	lapic_sw_enable(low);
+
+	signal_msi(vm, ALIAS_LOW_VCPU_ID, ALIAS_VECTOR);
+
+	high_has_irq = lapic_irr_has_vector(high, ALIAS_VECTOR);
+	low_has_irq = lapic_irr_has_vector(low, ALIAS_VECTOR);
+
+	TEST_ASSERT(!high_has_irq && low_has_irq,
+		    "Aliased xAPIC IRQ delivered to wrong vCPU: high vCPU %u IRR=%u, low vCPU %u IRR=%u",
+		    ALIAS_HIGH_VCPU_ID, high_has_irq,
+		    ALIAS_LOW_VCPU_ID, low_has_irq);
+
+	kvm_vm_free(vm);
+}
+
 static void *race(void *arg)
 {
 	struct kvm_lapic_state lapic = {};
@@ -42,6 +136,10 @@ int main(void)
 	int i;
 
 	kvm_static_assert(KVM_MAX_VCPUS > MAX_XAPIC_ID);
+	kvm_static_assert(ALIAS_HIGH_VCPU_ID > MAX_XAPIC_ID);
+	kvm_static_assert((ALIAS_HIGH_VCPU_ID & MAX_XAPIC_ID) == ALIAS_LOW_VCPU_ID);
+
+	test_xapic_alias_lowest_vcpu_id();
 
 	/*
 	 * Create the max number of vCPUs supported by selftests so that KVM
-- 
2.43.7

