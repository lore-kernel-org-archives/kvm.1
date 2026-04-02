Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2D3090D5;
	Thu,  2 Apr 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155496; cv=fail; b=dTgXUvzl8PFZMhbTLOwuRK/Pt+eGTgQyfBGGhTXmCe5ELTHjcjiSdup3LK8uKqRVZMEOcOV1hx6TeWXsVX3UsIfwvsq+p233mbhUPSl/Z77Zz+zboBs1kY8QG2sunHvECZmnvt70SZ/UkVNtahDLPK6p6OYEuAr0AY/zL6IcWzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155496; c=relaxed/simple;
	bh=pNN1e0Sx2Zar64oW/bmNsKVv1AEiDBqFIyLiAsTxjVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4JGOVjsjYQzOgUTVcmznlnA+YazJNSBxe+/FOyXu92gB2CrYtb8yH/9T+G+uSQwyHknSboM968/gg+9Y3t14iIZvsfNfeEMnwHuH7vAorApQYC+vGbBbo4go0ySr6awC2N2rlDiaLdIl4soirNoXg3jyRP/B3c//dFzty5ClSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNi/jDoi; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNi/jDoi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he/+mAKbzNGtukX8fIpU5ApsHuDU/SVNIpCspqaT38PUu2FNQf/TaecHIO/n9OVXqNuUDK4ybkgo1ryXZ5s4MZC9BJMSkaOz+CoTyXhzXTSskZeeHVwe1EWvNK1UCzQr3ZcIEfF8ILWbm53eRZBIh/sVWdrwmTthLyT9awtNSCcSp5n8s+6QBKYp2ssDR8VCLMCy8gmhp2a6t6Z8i63l1VGEb6rHZ36dh/L8MqmNRnUrrz3E4Q9H5DgqI1HQdFbgjksORXrimxSSE7Hc67u7C4Mb0ATG0ZE7eFeQ+VRCi/7LU9ap762cP9tr4LImDCxeuW2BF4yOBMDDBDkHWKIRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGAB1FvkNDqsN+ePPcYqmnld2LbbrRnB8XkCZyIUjJQ=;
 b=PWot06zEU82e/jj3P4r6G2bpEf1x8i5iekMhqTIhue32DksuDCkdgg7Wk8Ni541Zer4lJzQlSqw6Lc8DWO8JuA6ISFfayAETc27u8Pc2uGwTyhtJYb4fKWhw2ms2ARZHCyucUJrNSFHX9q9YEUt2HXdkb505SZADoE4MstUtOA+5raIaPs4U/qoMq7hCFnc8L0hmntkXJrxm7acZOs2gesiF37FrUBDArkRad9u2EN5xjxKvGLyOy7Np36bgvr1tHX9EGhdg/4JTXJZ7YZONhGLrSEZdSNhfHpwy9VkWwKiY3zKLchr1T96QmbsamOxiTdlFcuWIaJJWdIqPLU84rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGAB1FvkNDqsN+ePPcYqmnld2LbbrRnB8XkCZyIUjJQ=;
 b=YNi/jDoiDXhbCJsHuHFafIFVWsQuh3VEKo4tqHsv+84Dond7C5h1JY49ywwz42OOPt4fmhrIRgWyjADEBRBZS5rVaJZwh55T1ZKivu1Bo+p7sgNgJ+2H3Hjw94IlFiA9BvG9tHQO5Ea7ERaURtOtOQbZnU+PGiwvT6PP6k2xNUA=
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 18:44:47 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::17) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 18:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:44:47 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:44:42 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 6/7] KVM: SVM: Dump FRED context in dump_vmcb()
Date: Thu, 2 Apr 2026 18:42:39 +0000
Message-ID: <20260402184240.1939480-7-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
References: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 943c973c-69df-46bc-02a6-08de90e7e9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2ZGzD7iLGrIxxc8TCpnTS7QJasjQCI2Efc/xzT5RipxmxcppGrF0OkbfWNoUguYfXTNCQKTQsSi9VJY5Ut47v4tCdbP0pXVfOAtEiGTgkNiQjZm636KT4dpMHlLfEIU/f5SAVbHqDSExtuHyw3Pe6RLtLVPhZyNtT7lO2dvFKC83WXNmkd02+CZwq6PJzxooAiJU+fPlc334SeSvF1ocZXyL1KlxOFpAatTsmLbUSqBHfouviAikBY3qD91/Kjozzg1RnNmD9k0SflfPXKs8Cy1B08jJps0+PnY8+kapqSROpUyx6GxpJjjZlY0WI7OIcUQWvEJ4G8I2pCb7ZcfQSs+hsLs0kZjYP8X/jwuLfoM7RyPsv7qR5qstmQcyRmY1vSp5QnKTY86Wo2BdBoPDjBBtvwumfArPWscE3SbliQKHTP+c1K7oRRIltyVNC+6RfIc+h34cQXyESfvpgaHDFrdPS2Uw0HPf33+4TgGQWePn1TvYx3Nd/BWPeMrS1d04LMAlD46IOe29dIiJd4DP14Vp4cwQErWmtDkqG1RLhvhttYZp162N5H6RiH4VgohU/Y6ZqMxFfKCb5H+/pqzCQTIECkHsF0ctCftX5PeBYeYgHeJpOiyH/fHYaJr1nina8lPeqhkPmVIfUSc9tdf3mSLoTQCGNqUNPQbBvNRJ7AdZxEuSW82+6H3Qawr2tocQJTjHadfx/7g6irikS2X7oLS9Zd/xUdTlIyqFYMjSgCSYGTZGaJyUJ/jya3ADQpd4fXte4zXDEmE+xXJLkp5q/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h0q8boJTyvU6OwNQYjwEmqhXVqCoe2UToUB01HuizsIBHHrPyp4CIVYo3wWBcYjF4HSNSrc7eoSZYn0OvGsQQdagi2WZQy87RT6QgNNl7A97nkACQ7VyqOoXx8SiotRCn7U11dXEraagkXkrjG5ldvqdiE/rtOK4EFc1GSYcPGifsIzIv4SXa+OSy5HLBJEwtBpc5+KDWcUJJRpp3uWLTUHcaj2mTjadkRH/6FghQbpEZ1s9oo8lUo8uqDTbPhGuU9GxJ5OmruGsAltnBWI1CwU35dZAQs6z0YNvMLNht8RnxNaDWFY65imAhS3uUZ6jRWr1/M95OKNxdd5+JLAjAHnnRNG9UWYJJuE2ezjYDHJ0EJBZdfY+QmIHS4jD9CSYz7MBB9NUme069wVRuNP9UXkVv+OpuPYbbIgVxO0NLuEjfb4PQKhIjS5UevuLX9Q0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:44:47.0332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943c973c-69df-46bc-02a6-08de90e7e9fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

Add fields related to FRED to dump_vmcb() to dump FRED context.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
- Gate all the FRED MSRs through guest_cpu_cap_has() (Sean Christopherson).

---
 arch/x86/kvm/svm/svm.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 39d1177a24f0..7d411df3dd78 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3343,6 +3343,11 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	pr_err("%-20s%016llx\n", "allowed_sev_features:", control->allowed_sev_features);
 	pr_err("%-20s%016llx\n", "guest_sev_features:", control->guest_sev_features);
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)) {
+		pr_err("%-20s%016llx\n", "exit_int_data:", control->exit_int_data);
+		pr_err("%-20s%016llx\n", "event_inj_data:", control->event_inj_data);
+	}
+
 	if (sev_es_guest(vcpu->kvm)) {
 		save = sev_decrypt_vmsa(vcpu);
 		if (!save)
@@ -3457,6 +3462,27 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 		       "r14:", vmsa->r14, "r15:", vmsa->r15);
 		pr_err("%-15s %016llx %-13s %016llx\n",
 		       "xcr0:", vmsa->xcr0, "xss:", vmsa->xss);
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)) {
+			pr_err("%-27s %d %-18s%016llx\n",
+			       "is_fred_enabled:", is_fred_enabled(vcpu),
+			       "guest_evntinjdata:", vmsa->guest_event_inj_data);
+			pr_err("%-12s %016llx %-18s%016llx\n",
+			       "fred_config:", vmsa->fred_config,
+			       "guest_exitintdata:", vmsa->guest_exit_int_data);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp0:", vmsa->fred_rsp0,
+			       "fred_rsp1:", vmsa->fred_rsp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp2:", vmsa->fred_rsp2,
+			       "fred_rsp3:", vmsa->fred_rsp3);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_stklvls:", vmsa->fred_stklvls,
+			       "fred_ssp1:", vmsa->fred_ssp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_ssp2:", vmsa->fred_ssp2,
+			       "fred_ssp3:", vmsa->fred_ssp3);
+		}
 	} else {
 		pr_err("%-15s %016llx %-13s %016lx\n",
 		       "rax:", save->rax, "rbx:",
@@ -3484,6 +3510,26 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 		       "r14:", vcpu->arch.regs[VCPU_REGS_R14],
 		       "r15:", vcpu->arch.regs[VCPU_REGS_R15]);
 #endif
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)) {
+			pr_err("%-26s %d %-18s%016llx\n",
+			       "is_fred_enabled:", is_fred_enabled(vcpu),
+			       "guest_evntinjdata:", save->guest_event_inj_data);
+			pr_err("%-12s%016llx %-18s%016llx\n",
+			       "fred_config:", save->fred_config,
+			       "guest_exitintdata:", save->guest_exit_int_data);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp0:", save->fred_rsp0,
+			       "fred_rsp1:", save->fred_rsp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp2:", save->fred_rsp2,
+			       "fred_rsp3:", save->fred_rsp3);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_stklvls:", save->fred_stklvls,
+			       "fred_ssp1:", save->fred_ssp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_ssp2:", save->fred_ssp2,
+			       "fred_ssp3:", save->fred_ssp3);
+		}
 	}
 
 no_vmsa:
-- 
2.43.0

