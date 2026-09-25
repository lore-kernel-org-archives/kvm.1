Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF2485CEF;
	Fri, 25 Sep 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336597; cv=fail; b=NMzADVVFhaASSE70v76HGmnDu5NG39Fsd18lQm6P9GLNWcMQM+MKEKhTGybMEszXxAYAq/lWmU65ZyRiboW6Ws76WycWcHkQ8uUwQ56rj5au0J+tJjwKmgpqSFBGcy1CDRe9RNYypxak6QGOCs9+09+YlxEUyMnEEdlzuBNfGX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336597; c=relaxed/simple;
	bh=Uve9eFoXoPfBSriJwtZ4kbqEQPsU/yz7kzkScGv4ACo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzULWjXN3Rnej+iJz6zbp7Kyo/ZB/Pzgx/Pgh9BTtXLXKMfoVOAeh8ymGjQjePuBV7qq6g8rw6EfDRe1SmdNqRI/71lnqdLXJis8fFFexg7Z1q9hUrWWFiYSQBIH4BRQKvKNX/2jGeMQjLQKJyDSzFzdhNbLff8jPHbztY/OnxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JeQcP/cY; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JeQcP/cY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHVzi/aCGCBEchCTsXTRrPKyJt0s6wAzQbUjTYT3RtARvOig7u15vRcvtDgsmxinUXq0AeZk5aCVL7nx3Aln5cvBvMvqy4gohJUwYYZhZvQGtGggbNzOoGeCa9MVDfYcbv3fG6kwCN/wJuTOFA1an1aLWUrxFfrgXW9VFSTatgpXLrQM8c+PEsixCNjt6h1vEqLd8pJ1ABfM1Rk0Rnuv44Oj8U9LTyrYVKtdD6o4fiCDFju133QsO1XSZbf3t0bhNUmj7ECApE/OCi6pp3m3a/EoqWtXIcA1VAESGz7N1SLAUPw/LtVJMakOax+4zgGhKqhTosEispSFwJ5KklMHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImR7X0mz27PVQqlI/YDJ5aCucLtacAy+fYsoLftsMMQ=;
 b=Da2o/Kjr7AWcG5CT8U3c5dXKunmcLPeswSx0yiNC5xYcp08H07t7mL9RVXdaARB4P82t6IJmqhHmCG4/Xl8zPWAQY6iVPyl0o+I6fMI8+TdMmRFBtL4PwVSlDqFEHC8amj7xZirRsaPiBDs+v9rW+Kxp875Iz5qFO72uTAeo1aeme2v9pi3NtT9HRuaTPTVt8oqeIV4nzBB7y3LRDjOX1FdJjE9sbmSVGHZHdeaoU1AvEq3HB9VQxnPPgDtyDK0TLiEm9f1c0hXujMKhXVdUCn2q8zJM7gPj6vr+dqWB11zTFtNqThK6eTXe+R7Zfzy82Q2HHGj+J1BduLHGVU3Euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImR7X0mz27PVQqlI/YDJ5aCucLtacAy+fYsoLftsMMQ=;
 b=JeQcP/cYa7hThoY1RAFFsg7hlb60z0cObkT9lfA8TGX5IxCS5s+0Aue0JMYa46zYh9PeYNyqM6c1LRxE42SudLFQSMJA9qb5K7XwDs5W8FcOzLTNAhMp+g8CM8F72CjUcvkxvkTQidDvRQzASlyE/MPAm1BuXA+lRpoJ/WVANvY=
Received: from SJ0PR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:332::18)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:43:12 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::1a) by SJ0PR05CA0073.outlook.office365.com
 (2603:10b6:a03:332::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.5 via Frontend Transport; Fri, 25
 Sep 2026 11:43:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:43:12 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:43:06 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 2/9] KVM: SVM: Disable interception of FRED MSRs for FRED supported guests
Date: Fri, 25 Sep 2026 11:40:10 +0000
Message-ID: <20260925114017.2208531-3-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
References: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f47357f-87aa-4178-02f9-08df1afa2dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	w8oMxHG2KUnRwJnWxUCPhJwYD1boYNYVKW7Ufjrwmb8qPi/boze0aooHTLRbzikXU+b2YuZTimJCzfn7ty9Fv8K0BqGVeAgcOZDgH5LascPOzYhqIZnPWrEHdQw4A02I8JOSoHPtDIS75yc+9r6wGu57jR9t18pWzStrTGSGU18ZBNKACBvLgNUDsgPYL6TlzpykEsrT5bwLahQroigYAzGHVkxIHmLXqNp0NrSJUBZVuSfMVTF7G+fBg1JTP+Nr0tb/5XEXDmR8jh56mXYBfPuzItUTfH6rT19pjo0ckELXLJuK1fIJ64h3zBX61OO+UdNPQKrOQ3wiK/uhSjE3gdHOuc8JjBetZFhap9BJa5drxIVqYO1eU4G8ZgXmm4kfXXtyuhOHPxS60aPI2uwJ7XJc4LSAybg98CLztVwzEMwmsvZk9dlgpEfZFmOKQ02m+TKVYILcgRaVtsamPyVch5T7xGUHDl6+Fh6ZobuLnRmC7D4qsxv07kEhJTv4xL6LfIBZ69K40+wvBfmN+3kfytluLDVV+v/pUXITurjGZI89IpKgEVKxxfp7qVfa0/npUTku3V5T7iCrDfkFjCrQSWUq4ssNOSXXvF+OQxQCwZpVDGmtP/cAe6k4tOytCTJbCcEGauGJMJO4fU9wV1WeK75kbXL7U912xE0fKj0gv3ApakdjwqXDWuKAWVGv2dPLE5FDadPbv18ut4iDtEU0uA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2OJCzggrnFFUG/h+v5+gVaj6Z7gD1YDb3azrnyHfOn3mxpe74OhrjYcQVdzIJYZKZW8klJeW7WpaP5dGEmdP9TQMR05QN+Pza//3ISk7gDIFIcYIT8UVgoVIuc+MJ/RvOKLvJMhr/kOZBVhCMeIohg1uU7/EMARqwNBIdHqWcB1h6aq/p3koMpWooiBBIi6U2HL6cHzJysy0uPK7guK+QxakiJbNzfqMfTBTxT3L/gFTipcRpWZ0Jxm97i6ocf0jp0fwVqXhGK30/fYZxUH9vwASv1KAzbyS7bzlqIbp/tiWaDMUFEqAWoDjfkFjJp+e7kYGLNuEY5AFi54Ih9qy8y5vwZNrqRHJyYOLO0Sleb7aqmvwuTpYJ6jU8s8XBsIyRmR06gCsbD+ILOzHoq7GsvbpSeYMjJYzUg7SdRRJcPqA0WlkGx1QKLev/kgq7P51
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:43:12.2296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f47357f-87aa-4178-02f9-08df1afa2dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

The FRED (Flexible Return and Event Delivery) feature introduces a new set
of MSRs for managing its state, such as MSR_IA32_FRED_CONFIG and the
various stack pointer MSRs.

For a guest that has FRED enabled via its CPUID bits, the guest OS
expects to be able to directly read and write these MSRs. Intercepting
these accesses would cause unnecessary VM-Exits and performance overhead.
In addition, the state of the MSRs at any point should always correspond
to the context (host or guest) which is running. Otherwise, the event
delivery could refer to wrong MSR values.

Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v3:
* Rebased, no functional changes.

Changes in v2:
* Used guest_cpu_cap_has() instead of checking VMCB bit (Sean Christopherson).
* Variable rename from 'fred_enable' to 'intercept' (Sean Christopherson).

---
 arch/x86/kvm/svm/svm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6d55b0a576d9..e212f53d262a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -788,6 +788,21 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 }
 
+static void svm_recalc_fred_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	bool intercept = guest_cpu_cap_has(vcpu, X86_FEATURE_FRED);
+
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !intercept);
+}
+
 static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -857,6 +872,7 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		sev_es_recalc_msr_intercepts(vcpu);
 
 	svm_recalc_pmu_msr_intercepts(vcpu);
+	svm_recalc_fred_msr_intercepts(vcpu);
 
 	/*
 	 * x2APIC intercepts are modified on-demand and cannot be filtered by
-- 
2.43.0

