Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4A3F39D8
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829887; cv=fail; b=JmOlzwGAtPQcTIIq0o/IAep++dP6t3dg3ZvFko5OU/xtwpRZoFPDU2qaM9PAAR346eXMlkSYgGCE5x9zMJQ6jY/WNqbUigJa+KfcBcOoU38za/p2rX+f6aLAu1bfE2PcAxdBELNDUzXRcHM3YtfQqa9FKhnCLvNGfxeQQFfGGd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829887; c=relaxed/simple;
	bh=grS4Sfml01YfZUOJ1X1hxXpuvGbOBAH6KghQ8A3eYDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww7vX39fKsr6OXcLfiLMEvCx7PA39c6idyHojWBbUR/Zoyb0xxZ2p17R4b0EwnjaU+dpkEnS8S8qJrLggoa1ObsyGYWmwNVy1kABM0KAgER91iy5KNxMMgOxB5R6MNohAl0bLcEM7fqzJvQPT1v3Y9tt3f7R55PkdHMrDGfrhiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gl3vsO7K; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gl3vsO7K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8LYxW+KB0tBFuodPxXHrgaC7fy4SWq0qzRAMEJf3ii2KoiWyZOZ5H34uBQ1o9K4o3ubOFICvTU4avXvtbQKEKm4clajIL2HmIVAxkM4KGLefGH7Wu0qBq8QQgXFlJ9Xng15PaVT26NEmdBZcDykdlb0hg4ExMKmc4S1PRwYUxYKXRzHKW5Cvvde+WGcXuiVeyFd+91m7mlE7YHHvVuopz9u+bZVLLzG0eAiRTrr9Cuq1L9VWB5IOyVONIoPw7Q1EPCSn4Ra9Zcr3i3fwfolvKNQzu1hvgl23rDrThi5quYZWmq2/aZy/BQN5yvYzcF8Q7MX49HyDwTrMD8NrmuPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDwdymIMsGihSDkoG179BOrfDOz6snNBkQp3kbGH7+I=;
 b=UoRNTrHwFsgn2+ZXJliAJB1WmHtnCxxYD39g0+d8x+hcTPwH4vHgJ1GyHnYA3t5ruyMzonlxMqwaiaXczP/DXlosrwnpENbA/xPq8+SZx5YnvQTNc8jJjuYbCHxF/puiWf9hCjFSgvDjOKF+Anxm0gVRBHcGnj6lQWenx5UbWBmDKJQK7qz6hTpOqjB6YbeI/S4T4NBdTNAp9NF9oh3FbHaIp3kHOeO9zbLDL8KlqOeedSTImHnYOBkgmRyFBPuJal7ezjUfB6cqjYX3M8Vd0AAxFgssFqpNtYPtA2MEyQTdPxjFXLFJD6XrJA68wUWsHVFI+C+vlzCzU9QvXe06SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDwdymIMsGihSDkoG179BOrfDOz6snNBkQp3kbGH7+I=;
 b=Gl3vsO7Ky1yi9vVk1NMYRGG8SSkuiaT/ycfCv3UO89WxyXgmiShc3xqqFf3tJQWWgI2A81G71TW9xLuVhujwYsU014gCZ4rLKv/ayxfXDOkbc77fEXy6kd67Zf4k1xquzlfyIYE8uNQx+BHQCC3io/pM7F69APfIxUbEHl8TVQY=
Received: from BN9PR03CA0905.namprd03.prod.outlook.com (2603:10b6:408:107::10)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 04:44:41 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::50) by BN9PR03CA0905.outlook.office365.com
 (2603:10b6:408:107::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 04:44:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:41 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:28 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 6/7] KVM: SEV: Disallow hardware-assisted PMC filtering
Date: Thu, 1 Oct 2026 04:43:50 +0000
Message-ID: <20261001044351.50535-7-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001044351.50535-1-manali.shukla@amd.com>
References: <20261001044351.50535-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: bd208535-2d88-4e58-35ec-08df1f76b4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	snUiiouAamzlF4BPEegKEqWIg5sHz1fNNrKbXNL8Z8O9ThTJ6m6F7bOP2Q0w5BFTqt/clZkDGGSOFPm7v+ID61pJEV4bpqj3EjEZ+mV1MdCTs/YwEKC2Njbs4UIWbG96UEW6y3LU8k3hdWwL092k+6JRADIRkpe6lR25XpY0PQQ7NsgR+Q8+C4ImPvkTWLXhdAebVexuOr6VTduV0xbUinbWQQtyCYkEv0WhFKjeVtH+krWndJpRaskzbbVoWdB4XJ/hd8wkVsjaKjkAp96fMWUrP5j7TuvxScIYko9veUQN730BWa6b/E470C98tkgnPlFEW7IZUmcuuwvvhD7SkAnW7jU+n4mxMq7td5XWtSgJf94DyfYDZeiLecSKQCgQEXs1iZFVgj3B2ufWnu1/WOxLJHm1e1zQsB0A43+cNI0+isSHPHRrGiZx7vVSF1mf4F856jFnsUgnSmKGyGx/19/yjjH1PsDDZ7RW9dVpY0rl1CCFsc5kqCoVX+EDzaIivFaw2aPiOkTeGgyZOmil4hHfZRPg7s2ybIJIbAhIoqt0MBHvt5AELv5pBOVWH54Qf6DwE2xTrmxzfGZ6BPTRUPwFvkmDPENk9Q4yWCHcSZY7aPPQKNaDfXtfjszkjBmq1NTjWrt9BSzKaQshsF7jOXhco8DySyRFDUQgk/lWYEduLjhCDQrEm2ivlFD2UWZeBqXxXgNSjQBg/LvqgHvztg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vE1cZ87k5x/No0KRIG0oPh6q/m5Fr5XMGY0cN3YxwQUMks4ZHEgefxps243D26e03PNpz66FqnB++PbOQfvX+MiDN81yg/fwFTxDISYnh1N9U0/QBzC8ZWvOTq6cq38SuBWjnTMmRncb9mN6ENsa71gm2gtHaBKbwf/8XTzs5Y5u0QP8yc3ojE+e5jGpFkdU4hFdB73A0vTCol7eibg66aoimnXVuD2WlULmxAoI3j3NmCOqDLSsY0YX7cyDIhkCuguUHOhtJiVs+IlIK+bB5AetfXBr0j7Y72C78VNa0fBVgU9xykpdOmmWpCl9SUdY0fY8piagLs/w1n2nSwvApVtKdE7AyzBZn9haV3u76PpuuFixFxXp2fpnFBE58qjK1upCp+Zqmtn4Dsse03MANJwbv0nbtX/hPIDwYTKLMeUe87mA4Hi6Wq9VxwhnS8Ly
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:41.0326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd208535-2d88-4e58-35ec-08df1f76b4db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

Maintaining the hardware allow list requires KVM to read and write the
guest's event-selects, which live in the encrypted VMSA for SEV-ES and
SEV-SNP guests.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/svm/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8e8cd4feb16a0..28bc15def6a2c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -535,7 +535,8 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		sev->vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
 
 	if (es_active)
-		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED);
+		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED |
+					       KVM_MEDIATED_PMU_CAP_HW_FILTERED);
 
 	ret = sev_asid_new(sev, vm_type);
 	if (ret)
-- 
2.43.0

