Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4D1A6805;
	Tue,  5 May 2026 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941180; cv=none; b=oDBrK4MrgC4YlFJkihBD6x5c8TJUljuIN8gKOZ8P4CnKlNim9JPH6xcknHoJCYsW2o1pEtdKRJXg2nEPXh+eAy+zjLKgw+3dOKtKGmPcBhwATFo/w9HMOSendb4qQ7QwT9JeCLu3Z6hRwFBR/vHaXUUp9Z7QOrSa9XwYxggPu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941180; c=relaxed/simple;
	bh=Z7YWePrTbeEh16xgB5YSPCgPJWgSm+/yd1oPdhzTw8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHfFWj95GBILsriZ9X190QjzJ0ddNLzTNkdnSaEikj5eWNN7OfaBVcYzXLQs/z2Ml3tjKuPvHfDrfyBenK3HpTBNtLWIl7vXWVnTU2MnjxHTK8huygzJm3aCb644J1C5rsK6rW5qz1jYZ89zA8x5EFr/qf/5p05ywh7Q1DAy+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nZLRruEV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nZLRruEV"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6450U1Uu3288796;
	Tue, 5 May 2026 00:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=w8XSJ
	gd7KyDaLxZBuE54FiSR/eytGRSnZf8NWkQlVoQ=; b=nZLRruEV0v/V1oJnNRgub
	vnnsjX3YxezDzh4PGHf76W9y/1SNaUfa13EkSPMnmQpwWPZ6Cr9Wd0duhzfNlhmr
	9+7kNUPzDr5AxmLUX48RdoRWxkCLaN7LWQ0oPkLlkbMERA7nJriUQAlHUd0JNJB1
	aahbwoz7FZcMCLquBHkoQ52o9gERDpHU9g2g/Oj/M4ys8jqi+nINkhA1zqEjPoF7
	m/3dUrbrdI44rrrk5Rc0xMyPX1raO8HxULZ1i2ew8MTPHsanGyEOI9refB4teZsG
	FGpojLSkSRbvTQ/Mh8qtTi3gnZrvrF/daukUPK8i5gNIJ4VGBCErQ//Zjo65zXE9
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9frbytf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6450VGC0007049;
	Tue, 5 May 2026 00:32:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5e9yjm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:32 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6450Tr5f001260;
	Tue, 5 May 2026 00:32:32 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx5e9yjfe-6;
	Tue, 05 May 2026 00:32:32 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, hpa@zytor.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, jgross@suse.com,
        dwmw2@infradead.org, joe.jin@oracle.com
Subject: [PATCH 5/5] KVM: selftests: Test KVM_SET_CLOCK downtime in steal time
Date: Mon,  4 May 2026 17:30:18 -0700
Message-ID: <20260505003044.78693-6-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260505003044.78693-1-dongli.zhang@oracle.com>
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605050003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX9Yjg7bQr8A6i
 xEcEmvALdE1RzQ2fNlNPqncz2nO817R4mjqefWwJLNHsVDAeF2m1WjCwuwDSeM8U8Hl5pIU7scp
 3Wmk+9NL0pG9fVGDD5G7OynZgpBpMlf54PYN3wuP6BRUVTySaNKXAEF+HKumbr9shBnFP1xAls+
 KViClOr8A490fQuJjFMH9p+Zv+gORO69jbSLe8iRNfORt9h3VID4+jaRgXx8fpv/zdxB9MUyJcR
 pOFqr/+FuuKhQBNhIAtuWhqb0Hr/cWzVrHJc7MXchzl4HKXlFX+8oioMDAXmS41MhFgv1O0eLVF
 IFJGWjVYZz2mIDL3KuEc0r4LfH/K474gNTVXFv1lVCbkWaDckYBEEmXeKR478oT1XcJyHRBbxUe
 G3VIuGt7UNnJ0fkY9H0mbZInBUWpU3UxPc4D5hE3gIuJs6tffI9sN1/33HgwYp+CylRlnVEahu9
 r/ZdwrN1k7OAOW/W+Xg==
X-Authority-Analysis: v=2.4 cv=TZ6mcxQh c=1 sm=1 tr=0 ts=69f93aa1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=X2VEMh_bFGul9R-VGUYA:9
X-Proofpoint-ORIG-GUID: NZA0nQaBLcXJutPBHKXNtCD3nGxMZ3QJ
X-Proofpoint-GUID: NZA0nQaBLcXJutPBHKXNtCD3nGxMZ3QJ

Extend kvm_clock_test to enable KVM steal time and verify that a
KVM_SET_CLOCK adjustment with KVM_CLOCK_REALTIME also advances the
guest's steal time when the realtime value is in the past.

For the negative realtime-offset case, verify that the observed steal
time delta is at least the downtime injected through KVM_SET_CLOCK.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 .../selftests/kvm/x86/kvm_clock_test.c        | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/kvm_clock_test.c b/tools/testing/selftests/kvm/x86/kvm_clock_test.c
index 5ad4aeb8e373..7e0f00f21144 100644
--- a/tools/testing/selftests/kvm/x86/kvm_clock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_clock_test.c
@@ -28,16 +28,20 @@ static struct test_case test_cases[] = {
 	{ .kvmclock_base = 0, .realtime_offset = 180 * NSEC_PER_SEC },
 };
 
-#define GUEST_SYNC_CLOCK(__stage, __val)			\
-		GUEST_SYNC_ARGS(__stage, __val, 0, 0, 0)
+#define GUEST_SYNC_CLOCK(__stage, __clock, __steal)		\
+		GUEST_SYNC_ARGS(__stage, __clock, __steal, 0, 0)
 
-static void guest_main(gpa_t pvti_pa, struct pvclock_vcpu_time_info *pvti)
+static void guest_main(gpa_t pvti_pa, struct pvclock_vcpu_time_info *pvti,
+			gpa_t st_pa, struct kvm_steal_time *st)
 {
 	int i;
 
 	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
+	wrmsr(MSR_KVM_STEAL_TIME, st_pa | KVM_MSR_ENABLED);
+
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
-		GUEST_SYNC_CLOCK(i, __pvclock_read_cycles(pvti, rdtsc()));
+		GUEST_SYNC_CLOCK(i, __pvclock_read_cycles(pvti, rdtsc()),
+				 READ_ONCE(st->steal));
 }
 
 #define EXPECTED_FLAGS (KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC)
@@ -50,11 +54,13 @@ static inline void assert_flags(struct kvm_clock_data *data)
 }
 
 static void handle_sync(struct ucall *uc, struct kvm_clock_data *start,
-			struct kvm_clock_data *end)
+			struct kvm_clock_data *end,
+			struct test_case *test_case, u64 *last_steal)
 {
-	u64 obs, exp_lo, exp_hi;
+	u64 obs, exp_lo, exp_hi, obs_steal;
 
 	obs = uc->args[2];
+	obs_steal = uc->args[3];
 	exp_lo = start->clock;
 	exp_hi = end->clock;
 
@@ -67,6 +73,18 @@ static void handle_sync(struct ucall *uc, struct kvm_clock_data *start,
 
 	pr_info("kvm-clock value: %"PRIu64" expected range [%"PRIu64", %"PRIu64"]\n",
 		obs, exp_lo, exp_hi);
+
+	if (test_case->realtime_offset < 0) {
+		u64 min_downtime = -test_case->realtime_offset;
+
+		TEST_ASSERT(obs_steal >= *last_steal &&
+			    obs_steal - *last_steal >= min_downtime,
+			    "unexpected steal values: obs=%"PRIu64
+			    " last=%"PRIu64" min_downtime=%"PRIu64,
+			    obs_steal, *last_steal, min_downtime);
+	}
+
+	*last_steal = obs_steal;
 }
 
 static void handle_abort(struct ucall *uc)
@@ -106,6 +124,7 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 {
 	struct kvm_clock_data start, end;
 	struct kvm_vm *vm = vcpu->vm;
+	u64 last_steal = 0;
 	struct ucall uc;
 	int i;
 
@@ -121,7 +140,8 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 
 		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
-			handle_sync(&uc, &start, &end);
+			handle_sync(&uc, &start, &end,
+				    &test_cases[i], &last_steal);
 			break;
 		case UCALL_ABORT:
 			handle_abort(&uc);
@@ -137,6 +157,8 @@ int main(void)
 	struct kvm_vcpu *vcpu;
 	gva_t pvti_gva;
 	gpa_t pvti_gpa;
+	gva_t st_gva;
+	gpa_t st_gpa;
 	struct kvm_vm *vm;
 	int flags;
 
@@ -144,12 +166,16 @@ int main(void)
 	TEST_REQUIRE(flags & KVM_CLOCK_REALTIME);
 
 	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_KVM_STEAL_TIME));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
 	pvti_gva = vm_alloc(vm, getpagesize(), 0x10000);
 	pvti_gpa = addr_gva2gpa(vm, pvti_gva);
-	vcpu_args_set(vcpu, 2, pvti_gpa, pvti_gva);
+	st_gva = vm_alloc(vm, getpagesize(), 0x20000);
+	st_gpa = addr_gva2gpa(vm, st_gva);
+	memset(addr_gva2hva(vm, st_gva), 0, getpagesize());
+	vcpu_args_set(vcpu, 4, pvti_gpa, pvti_gva, st_gpa, st_gva);
 
 	enter_guest(vcpu);
 	kvm_vm_free(vm);
-- 
2.39.3

