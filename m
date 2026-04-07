Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D362351C09
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543611; cv=fail; b=ZPr+mY5FVEeOuhgUdK/Gj2GStgPPxiC6TLelBdjpcq2BztJTPFtuE/8DRzGgMDsBCX+56IXsx2+t4CVTvX4yIKP5L95hnfVc4F43t8iXChPQmu7Tibhb3sCFiZRpX0GmvC006/7Y54qPGcq3Ugp5Rmawdq27mrBhcIMHONZytvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543611; c=relaxed/simple;
	bh=fisS9SMPTQ11Hte6GlSz89ly3Amwlt8ao911xND8bUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrgkOILa8RiBub36VxXoVJr+ZRsp0aNXQSXgRyXSD3CqQxHTUdwSkrBEZkTtafZiKL8RST0oCPF6m2ywHneBeypxg++CD83LXKXSDktgUf8Usr4JWf/JilbatiyiVty08/ZvqT5iifxamfgdmfeZDq2oCrTJI01Rz7bP6ATwJi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fR9+KtJc; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fR9+KtJc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoulnBJm3cVlsgrG/uJL0WEqPNxHOLZhinD5FYk07kETm2vWj6sk7xgHK/qeKH3o428cwqVlSLibBSqsFLthEzhuwMQwEWYW8R+ldPsi/S88kYzmdL+N1oTq0sucael64v1bde9SvTQSLhFz5PAM4HAa69LhPfpUbMU43LtcrzTodIRe9DGB6GFvlzbnJjSdr+9Gj6ALLFdxv6tauzPmR9KDCZTtgEz8uO/gCImupopf+HvxAP6TdxXkDlY25adoJcnnTvddUFMjrigjrUOLKCvfBtMC+Gl8m7i1snxg2XyjUlmIslGW5VpYq1FRwEx7U92feeYz0uJxbwxOIvgjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhWC5Vp2PxtjocIujPqu0GdOEyEz1BEESyEJ764WZZ8=;
 b=mWT/TKzb0MucyrLYcDLR2iTPJMDVVVLEF6+XbIKJMMUFuHFPNIUUOof6hXc4d2VoMLrJnAdO2PFKm7vachPStyTDkqhoUJao8fcDtRIwUmP//q4wHtpbzLhwX1D6ByMkzvdSQ07bpFoK8SZP4qPVKx5ghqZJUribatN2nASpYx3W2oN7GtodwChxmbGo1Cg9rCe2Ew46gATjglSG4cpcqUNZHFWAn3SN833Kgmj882RMURzEG9Sf5U88nZvE5llI6fDab7EF6yMxw0DQUypWgqcUaUhlXeVUixnAuExes3voICUc0Bg3pzf+yZTUtl7ouktSTXV0TxuOg3lN8dJ1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhWC5Vp2PxtjocIujPqu0GdOEyEz1BEESyEJ764WZZ8=;
 b=fR9+KtJcuSgZodJnG1LUUDJxdlKFjs6/SnHd/7Iu+tyFFnKVDR0XpHSBT3rRKRMSEX00pb1iBb/u36w4dxCvYjp+KkneAIKdiGtP8H+vBI79L80ca5Y+KI2971bMrTdxV0jiIqvtgBsJ65fmHG5UX5hw9UUkqw+9/h//7nnE2pg=
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 06:33:26 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4d) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:26 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:23 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PATCH v6 3/7] KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
Date: Tue, 7 Apr 2026 06:32:41 +0000
Message-ID: <20260407063245.2755579-4-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260407063245.2755579-1-nikunj@amd.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b14d00-ef0e-442c-f247-08de946f9366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Mm0XrIbw1XeFJjZjU+yvdY0/cpRVNsaqCIVA9MEf+8ZUreMc86YYtCqmHMSVr81CjL1/vAz4dafwdE44wB4O5rguN3aEZoFgsswOHytlPW9d33nMlJqEDRVgNcAb44AbzaZH+2buk0XdhUlzSZY/v+MwckNWYYqM+JQgD5GeSZLqX71iTSERPT0zDvFBJlRqBkWxZXNSKgi/CEZgXotpUiOhrFN7oDkT1lFXWqDPx97U4QOoX279d4vUVmQxvU8McdUCECbPOSTFUt2OD89ffqrq7vtlBAWgXbfNfPnCo5wIT34MqzUubWGf8rV5d5Sa3tFXW8Ho2kYXD8So5kDgHLPALgEimp7FQKJEqIHmm/UdKOo89bE0JezgGoMqj5I7bavwHjbO7FGlhcyLJYdMcgYGFmGzbPHo5QQJxlElhYqdHUywcW1yOaUJamt6wFJ74dsHIOQ7HHPeK+ADrJmjNasUd0OND6734LNwfIxjLSjxtWUzCZHOY0gfUJwCsjGh9gG0DU0ClMHsYDJzruiD2mwsRVenXN2d1Sa5UmfqYaw9OuOxOqXP2gcmW/GpMJ5CyLJkVBX00NO39LxSpnd8gkRjKNkrxWqJ0DFF3fzhJihCW4Q7dBRelRmQdgiZY/KloHq/AdxmaLfOpSLSn0vzXG0wL2nVnPyFKpjB2VpQRscZbN/qOE1VRYwotDvvVZjhRaq5tv3Yx4xYe+Orjx5pWMOfnojM97whvbKPj/RA/zujxqXpDjtLIRMaTWUJmLXybTqkbE7TYfFpVDlUaERh1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vmGbe4E/DAAlgj29CjFGYagrGVpP5JzZJXiGB72sXHhLawjcKHjgwfo9Q3OucPUHl5pAOF7doUxvbusnJ7Yybs0ruM9yBXRz6Z4zyWxPCANKUoHtrfYIyMGqnXVtjcWum3bObJwDKqmqArEKBYU3RccZiFX/6KoniR1qyKeoTXlA6Ydjtud5t+6lIgSy0wdRPjRbVVu0LjANxyqE8CENZo4GWihJQOjI9Xpb5G5oegfCRhCqIW6N8jJShE7zoAVCYKWHNJZetsArSw/D//ReaGGIvttXxUw4ci7Y8WWrTJJb0w1AHZj51OIhQhoF5lzoeCE1IF7uDANRsnTOag1nMmUeNi+dWi6TR3/1S9d1Gsnh4AvGkrVERnotr464jwuLjpRlro2QhvA3sIdxhAKc0wKjn9jN4HGxkH/rTRj4oBMzuo+hvSJWleXVOpl16kIC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:26.7110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b14d00-ef0e-442c-f247-08de946f9366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220

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
index 909085a5dfb3..a5a8bb5a7020 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8439,7 +8439,7 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (WARN_ON_ONCE(!enable_pml))
+	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
 		return;
 
 	guard(vmx_vmcs01)(vcpu);
-- 
2.48.1

