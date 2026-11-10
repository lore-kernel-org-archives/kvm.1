Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299444;
	b=WWuBXm9cJRn6JofjzQc544Xj19Q/ixep9NDgGhNoTk1x5s2Qo8cnRb3YX3g9pOenaIY/
	 4mKhUyUItYv9Y9JwiusTIkjFrUTb/If+Pvzm5qzqoEcEofqVdU+YaP1PxV1oldwM27eX7
	 RoaQ4sUjaqMkWhTnOi6LBEM1o3yr1JX9JvOliS+Fy62VCnNvWQlfd2dUWkWqw0/EHW9Ld
	 0C1s26VjBfboVKB4HVZsgo0hMV5CUwUjoD3watO7+LjVllCKg6L6WgrXOPxZ7LXWt9Fla
	 mQc08gz221qh6jmvhRN9VjsUU6MUWel/X+HqenYjsLhlXtrnqD3SOk3+AN+ekGn9/9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299444;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ANnotLWAPOVdLUd8UpezWnqnBB6q4KfSBuZJKP5OJHc=;
	b=38l6Kw57h66f8pYVskQ1ITwqrCdEvnS+Cr7NW5XVV/acA3s501NNCjGi6AZpYy8uRRQs
	 iYHd4MKW8MCaaCYcaxlDefvInO+3h9ay9TQUi2ZnnsRZ2pWkhZQHc903uo7uOGpIgt4N+
	 CXvQPm+cAkNy4V+HSaka6D72qeiyRzmETQN7CbSiNuILMXAES/+DmfUI0/W+/shDU09ax
	 AMShMuhGS3YdguQC18ExwDgoeradMhUw8MKGpJ1CGmP8YQzEn9hmhv++67TX7n/hMSgGD
	 A66zBAI6z6utFZ2qkq0pzbDN3UFWcMoKfeLLWEUmNaxybgGRA2uoFi0OO1fLT6jUXVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Uv7o7kAe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.30
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468E606A9B1;
	Tue, 10 Nov 2026 08:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B468E606A9B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Uv7o7kAe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENr7xULuDe7pNBMgGp77HWgA4X+MXIx8gZ+fp8idg3pf1VhtUZyr4f4JUUrfYCgBl8JJgvZq9ohfY9sdpTg2Zhlsci5GYGv/M3bmj2128bqZ1yDZ1hmJhjXRga5kO30R/qAL3chrT8ZbjsJgQ3HVwxpmXFx2uDgZtUttLYbiWbztQC1ju1JMFTZai/Fa/SwriT0d3S9gqdReizgA29BemXrT4tJK/MZ7CzuWS6umji59vwujD0pMxRYNe5k5ZKGtyyKPeAbsCFL2gNuxUe+Lnly6Vu4WcsjhQB9beKsVijDQBfWqFbVkhDYrPmOyWSRrfCvxehypuMsu5oqyMjUVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANnotLWAPOVdLUd8UpezWnqnBB6q4KfSBuZJKP5OJHc=;
 b=PTRB+VCmO3kcDfwoyVomZuhSFLou45ZzW2TLZr8OjuEP/baI8B/BpV1cEd2vHPnsWqQqld5pKZWv8Qv9XA5jfEhh1zCsSIqoXto3J4v3cdYfp+imT7PcfqKO0AvraKz66yJgrKDMbJ1iDBCfFx46/p1YW7j9PACZFco1tq0EOOljaHbnl4+QKn0hMFVoZB/9YFLavC7sM3zBlyDGW9h6DUbAE2vGvWYCCTP+gvzMVQsrakWCvQ1ZeZGNOHBNu+O9bviovOQ9A+SfSLElQTNDHHlqXqdD0+cVHPTtS6SNKJalFruJ0yJA7kG1395W3z5uAWI2QGRyOiCYeb3Bjqy/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANnotLWAPOVdLUd8UpezWnqnBB6q4KfSBuZJKP5OJHc=;
 b=Uv7o7kAeBSvZzu+j17jR7GZzMhJW7ZdRbDP3E4JX8cRr4k3ehLsw1hKVY3KU13DfYgCPmvzx7y0+U39ADiE8zu6D6owNyAZjpLH9DGUbG8hmRH4ZcWDoOgw6AdzZqDSFK8tPQ2qRLcKZx3EHpzpc8116uKgpvUrf2RLOlH5yEMQ=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:30:37 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::a) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 08:30:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:30:37 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:30:35 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  7/9] KVM: SVM: Notify the SVSM an intercept happened during interrupt delivery
Date: Tue, 10 Nov 2026 08:28:52 +0000
Message-ID: <ba18342e0dd2249eb81c77f418125deada1e26d0.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
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
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: c992f425-b837-43d1-9740-08df3f04e57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006|5023799004|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261009223027099003|261022075727099003|261021123027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	686evL1AhELzEIu9iwgFpfmyqjqiqq46HJtx4T9IziUN+18mp6YOlgB1yMiKXj4jm614UdPgLGtWKQGYZWTQYxJuUWlyc7x4EHfUydjrxBrxVcFqs94KwnlsdoZwcnpmBe8bWk1fGpduoeOzMKiCa01V8nLRyHiHHn0eKkIBMI6sGlDYq2azoFi3ixhC9ScUP+t8ZDBxpgZXSGw6tMkdYiaIResv7QPEzy6/OWTR3xmU4ByfvfYH7Lrjzo9vQJ9K03a4mpvpevFMYkZ69EwDD+UE6jSHNCkUCo5EGOWiztJtq0wuBUoS+k7XFBNuz0y2FqmU/QAetMrnSeZHFz+TXrFLYfTOPbuRHTu9iFSoy+wi+R88dr4SwqTglbxbSjX2wXibEpwEI5hI8u0wUDgGHri/7wzNnA5YnFpUNnDZyEUvpBmJnNb2gbSL3Hmw2lWh81q9/UE5N13e1XrnEH62GU7VuTdqzVRMd7lX5TLRY68cIlrD6EYr/Xhe6zsUuwDUfmmiB6XemIZZDu4dFbATFWJdELJugobieFjHQ2jghjNfqP0ztjJm4YdWAOZPnHSw05IXWSmhkjls5jxxXFTbOlyolO8VqOZQgzjv1Jy+J4jHHtcfFbdmVyM+xVgOVLvw7O3m7GcGTIrvohqn0VT8nRo/g+YZ0KHt2XxdhM6pKSWxhfU/BYC7MTq2GEe4MnW0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fNzsR0aUvvDWOw9U2KYwarhUNdsSyYC0rBmb8t07BHlaaR5QCxIasACs230654nVyU/Qx5SqP72lJr4S9zk1796E9lD+pG3O8TMw4kRmsXhagtPktsZgonCquXg9rVnUbF5A6nWQcmA2PYkh0WUP9N7XuXZjXFX+noeCe9czZoqiC24+Zjfmw5oG8WTyW/4KXrm4snVcgg6kGQ5IU9UmqPWABFGVdo4DnWhX76ZvRM9VUNnJN0RDsH3AZRw0Gqq4VgWBM6kicD77w6patbtirdHnRrqKM1Y0aQ4YuAXVyfowsPx480/DbAGQBuV5i5/Hmov6f7hYu0U3MFzoDrGByLrvM+6Q1DLj6bbX9LDg3AKD0WCTobAskoimWO3HcM8M1KT+QHlhuEmZJTnNuRFwA/JNMC8AU7cmticTYh7E5izitDeockEMcX5cPRNfRSNa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:30:37.2048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c992f425-b837-43d1-9740-08df3f04e57c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

When the guest VMEXITs with EXITINTINFO.V=1 (valid bit) is set, that
means an intercept happened during the interrupt delivery.

When the hypervisor sees the valid bit, it should queue the interrupt so
it does not get lost.

However, with Alternate Injection, the hypervisor can not queue the
interrupt directly but the SVSM needs to do that. Notify the SVSM when
the intercept happened.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/kvm/svm/sev.c |  2 +-
 arch/x86/kvm/svm/svm.c | 11 ++++++++++-
 arch/x86/kvm/svm/svm.h |  2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 40f55e7a78e3..019412173062 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4618,7 +4618,7 @@ static void sev_get_apic_ids(struct vcpu_svm *svm)
 	kvfree(desc);
 }
 
-static int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl)
+int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct kvm_vcpu *target = vcpu->common->vcpus[vmpl];
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 756b11bebb5a..6d3d9debe5e8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3663,6 +3663,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_run *kvm_run = vcpu->run;
+	int ret;
 
 	/* SEV-ES guests must use the CR write traps to track CR registers. */
 	if (!is_sev_es_guest(vcpu)) {
@@ -3698,7 +3699,15 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	if (exit_fastpath != EXIT_FASTPATH_NONE)
 		return 1;
 
-	return svm_invoke_exit_handler(vcpu, svm->vmcb->control.exit_code);
+	ret = svm_invoke_exit_handler(vcpu, svm->vmcb->control.exit_code);
+
+	if (sev_snp_is_ai_active(vcpu)) {
+		if (svm->vmcb->control.exit_int_info & SVM_EVTINJ_VALID)
+			__sev_snp_run_vmpl(svm, SVM_SEV_VMPL0);
+	}
+
+	return ret;
+
 }
 
 static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1ec0a045b1ea..d5f42fa31565 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,6 +1009,7 @@ bool sev_snp_ai_update_doorbell(enum inject_type type, struct kvm_vcpu *vcpu, in
 void sev_snp_cancel_ai_injection(struct kvm_vcpu *vcpu);
 bool sev_snp_ai_blocked(enum inject_type type, struct kvm_vcpu *vcpu);
 bool sev_snp_ai_inject(struct kvm_vcpu *vcpu);
+int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl);
 
 static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
 {
@@ -1082,6 +1083,7 @@ static inline void sev_snp_cancel_ai_injection(struct kvm_vcpu *vcpu) {}
 static inline bool sev_snp_ai_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
 static inline bool sev_snp_ai_inject(struct kvm_vcpu *vcpu) { return false; }
 static inline bool sev_snp_is_ai_active(struct kvm_vcpu *vcpu) { return false; }
+static inline int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl) { return -EINVAL; };
 #endif
 
 /* vmenter.S */
-- 
2.43.0

