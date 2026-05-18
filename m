Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF62405C30
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080398; cv=fail; b=ojR+b5YwSFJFsGkwMRMVQqhzGCkLglc3CGauFyN2H13RvMqdtMNK5aE1zcrL6LPg+lzWfyrim9QK334dwPDSvzvCs9ZVlXo5Pa3168p5rj1ObgCHM7yNs3uhpC8ZScwLBzQGgOwg88s/ABeP38Oo2pzVYXtPe3OY3XGMg1SoEgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080398; c=relaxed/simple;
	bh=gxHitI9PxbXSJFmoPZ/ZCC0P/2T4kLXoSEmtrdLTRpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoG20vDHfP1uiu1BqXB4pydESIZMh8FGfqwNuITLAXRhVzo6V9CH6qb+w6eF9BazTgm1Pa2wkCq1dPNzRQC+gUW6jR5/+OnzX8fsNVLJ/n/QRHSjnPd7lokfA8/f0p9DFhVt/urMo4GqMRMbOUZhQU5QActz721nRf8YWIM++Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sm3WfAdH; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sm3WfAdH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvMShihXdKXW9dDIpbTNJR9FbrJ2PCeSem0wOUZfwVacqeJRW4pQns8044ghB390L2RgGQfm74IshfJvIpgwZka/KjhsUw1oUxOZduB9rwk6cgttDR5ACoXxl9kAXmPC4nB8dhwvt3rtn60TTEHgGCgpkSBlgtPS7/iJ/2VqMKGV/ApKW2nKL2FQWyhvi+fqgCT2KjQJ4kT1bIqiZ9MPeIuEalBVye9XWpP5vIQwrQRgCsJGzoolROID9w32PBSyIJyT/p4fnYVk1kHpPEUmU89TwFW5NYvdf0NRB0Wl3532odeshb+b6YW6mGEzd+YX8f38vFIj86it2AgcvOqwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GcLcJ+p9ZfBdGjZualdXlKgXhy34O7lB9GGGqyt1I4=;
 b=LDw/FHTuzrnqmmbIpz06oxaqz7hPxhSf36s5z6x+vMLcLIJEwjF1jRSvtNf193aszj8Q7cx2RHcURqBBHtWEaDSncNQiUApkoP7qo4Sx26PkeRbjzMR+P/MYVUwTGkAZGJWrGYhg0pGXOYq8thKEi5tZJZuh0FPt4YLQABlLhC6iv/2QQj2iGcE6mVvio0Ty4l333nPK9YAh7GhsKUOAlQJcn4AgvyOGmElPsmao3IqzuV69+rR9ctPRnx3mcRzp84MyezVCRIloxdm7aP8lz5lreH/cbtXGq+4snHzr8L5i9I+Vo5F4T1iLgOwkqkg1zJG71efZwmLKGyq7GbhMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GcLcJ+p9ZfBdGjZualdXlKgXhy34O7lB9GGGqyt1I4=;
 b=sm3WfAdHp3etq72wp6f7Km937mIIrtfF1PDqlzYEBXNt6I6jJ6OUw+fbIMRPZlR+sQLdV0CG1w+EKVcHCEylx32C7tY95uZiAZRf+ySBRrbeefHiTJp49MtGWgrWuam28s8zvwqCQDM0B/h0vUSy8tlXfSPOQvoNEk1+jwrAIdg=
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 04:59:53 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::7a) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 04:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 04:59:53 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:49 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>, Pankaj Gupta
	<pankaj.gupta@amd.com>
Subject: [PATCH v7 4/7] KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
Date: Mon, 18 May 2026 04:59:13 +0000
Message-ID: <20260518045916.2988667-5-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518045916.2988667-1-nikunj@amd.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3c98de-5799-4476-7783-08deb49a4c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	tSKVwmp5+DXMrHlEHr20vKN33LrKvUxM6G3zoxwIqu2eNuvk7mkwPL83mD0xTmvOxptYlq/mA0AfDKPfc7mdkpo961yPCKKuC5cxhEA5yWIVaaYl7cbUFXGfsUcP8M9lo9n1BSIYtyHFqhhBCm9uo9qRD5468T6AgvLG6GDHJ5uoxmuot0uhWIA0QDHqvO2mu3ob94JJseHB6dqJr19iD6c+a7tqX7QZAG7HBo8fIoTSljfGb16yHu95nYmGsD8pap69VdU6IXfQXuimpbxQwXU1J2ff+rKHAcTo+E3m9rPjJN2sU83QzRXyOy9noBPhyv1tvzYBuygd8mijcb6ONmyXu6gGmIBxzr3QQOcOUd5T8xe/YWjlfO3RyybYNQDgXwu8kNTbvsfGIzFqMyyO6nKnaDSoWEIwUZpZNkC8lSQtX2pehxN3qrxKNKKugnSbt6XwebiRC32txiS3q4uRPZe39RsqYufKppRppUm7zMRXIRr4zukZk004vDOsQ4lv4REsfts1YCxoRgQEfMuXdKrxCYyxy+Jn3MoV3CdkORx2Ez1zhbexLIkpUS+H7mx56P0oizhs98KU3igJBLFa/xdJ9gJCpddLkaBdk7NNfsfaT2XACZOtXyaUu/qcBWP5Kne0P3aPZazIuPRBXEvod5Mh8EC9QwTg3JFqYNLysCcr0Okrsvw7fHxIpgT94ZMkC50SW9bdP9ME3IOKRyeAepbsi1VBqJ6Z5jFrZsZFDcw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qPY2CQ+T6EG4EkLBUTllwGWRRvHL4p2cVq9VzNm/jNlrMj2Mq2TmV5yrg4xOKhlaeucmnGhnomCxAYHlDDB0LTHdYmlBFUALUCrpE/UktPepqr1AXjOkC5Pk+2XIP4zsrG54oF+Q3pNdfmep2VGv8oUI/l/Ckm8JA8XjKPMoCH9UPerhiPNePUU94rkWlZwbvM+qUfViGxLhNI4n6Jot5tIZ9BfTaJGJ0f+mcMm0uNwXM5ked+GE8+F8kwLYTTYJJyPoUYhyZAEAQ3XdoWz7ijjNz0p6NSuy5L1LC/Ctzy+HizgknixIx/Oky0eLAO9jwC/J4sgtJZcbX7KAchr+IY31OmE52qDGGStmy6EYxCMi5N+/9mmdfGnkM3zDw832TDizuNmJjteI9E0op0QM+js1QcLQN9MgAMftbe5X9YOrKvVJE1vYZ7v9AHn7XmQJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 04:59:53.1726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3c98de-5799-4476-7783-08deb49a4c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073

Replace the enable_pml check with cpu_dirty_log_size in VMX PML code
to determine whether PML is enabled on a per-VM basis. The enable_pml
module parameter is a global setting that doesn't reflect per-VM
capabilities, whereas cpu_dirty_log_size accurately indicates whether
a specific VM has PML enabled.

For example, TDX VMs don't yet support PML. Using cpu_dirty_log_size
ensures the check correctly reflects this, while enable_pml would
incorrectly indicate PML is available.

This also improves consistency with kvm_mmu_update_cpu_dirty_logging(),
which already uses cpu_dirty_log_size to determine PML enablement.

Suggested-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e6fc374302f79..4df8af02e3a2a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8359,7 +8359,7 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (WARN_ON_ONCE(!enable_pml))
+	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
 		return;
 
 	guard(vmx_vmcs01)(vcpu);
-- 
2.48.1

