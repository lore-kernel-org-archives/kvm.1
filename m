Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0734F275
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543617; cv=fail; b=fsCxrACj802wQxPyiN0WU4dSxQlMKeHU33Ouh9gyBJwJqDIHRZB6iXY46AqCsBsI1ODn95z0QOXEn5AT4QMGP95xdwguMuWfKH2xy4rfmEsDEQQS8m9IvsdbnxBS8w/vCt9z2g2OiFunoFzLPM6Wm0QtHcw4TDFjObz9IXmVEIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543617; c=relaxed/simple;
	bh=/uSBaYqZ4iHJDW/b9PzeyifqjkyYAvrnEKhUoy5tHvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBfzu/N+MhSQRURCpOESu981zXOe+I2Kc9/gU4GEYheSJUL7V6zsDjrKOBxf62HWCBJ+pt0wFelFlgodzE5tIwgDOiZ+hcaWv81VOxAEPmUS1o9n6DPWlNW9+AdME8Z7/3YqO9zI7qKG0NrvTO0pDOyOpghKqxPeit2IQWaxiS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W7ye88jd; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W7ye88jd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG31KuvuNLmRh42Kf3W+d/m+GGPq3MekLEeHhMNUUyRTTw5+eDLsXcsLxzFKkzO4hD7+XKgSx4hxlSIJTaDd8Lr/StG4s5tCWzC080HZcdMhbgMzirf7b+MEH4jQOTExbxQtp9XDef6jM52SzqBHIPWsH8yqSh5VPUEvtcY614Zk3RWPF8I6RUkdrQKE5Z4kAcKoCyg1RGj81L3/WbUVm3VS2RKg2xuCNyA6kOkL13Nh4BY+G1rSdOy0OdhOy3tYXJ8x2MWI9cQj5cDxPALnnDnY1vQCAcno1yofF6dfubgo8z310SjcERcR/rjUVPBQ0uN3bXe3Ip/6SCf+QzUAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnsVUkxrBOHlkSWWeLiCt93WJV+dPAJZ6mAJ64nuw8M=;
 b=IDELMI8fNKpOI5lJx3+96vz+HNc4Ox87BfY1vnWyds1jYewM/DDEaqajZ+bLrL6wPDnCpG8MZ4FdCKdkr/YUdzW/k7MdzWhyTb/4stnwnhhyeLIWIq5HPXK8uoo1t0EffY4GUZJIHbbJnVVPN9MNI8rkVosejl31I2+Xa89jB1e+1S3ZffdSFtVGywSDLGKMSUzJjj5DuST/vUea7tgk4dPc5XR2a0lHP1oKW7m10UekqJ3BSEiaPLPlhY6leQJhVmdQXVql2sjE+PAVKjAzKq6loPmMtvfEqJ9Ici4BbpajI7aex4Cnbk98I/MBfIPm0nzlqPXZ97JucE+zS1CTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnsVUkxrBOHlkSWWeLiCt93WJV+dPAJZ6mAJ64nuw8M=;
 b=W7ye88jd+FxlAcnniwL4P4oaWUmwQ2gyFiq+pZwMXckPYSBv3M6H8h3dJvi8tKVwA+fR2hC42xYLl7KtSlinBQzisRNDaIyKv2mu+aO8mU3cZG4Jb1XYdmzm7wqPhErEpVllu2Yjjtj/Gaq7uZHUBVOrEsaEWrLke4QM5xESH1o=
Received: from SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 06:33:30 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::dc) by SJ0PR03CA0128.outlook.office365.com
 (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:29 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:26 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>
Subject: [PATCH v6 4/7] x86/cpufeatures: Add Page modification logging
Date: Tue, 7 Apr 2026 06:32:42 +0000
Message-ID: <20260407063245.2755579-5-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5d2c7f-f9c3-4b99-8113-08de946f9532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MZCfaCbplCRwPqojFeg7O+O9SoVrAV9+n1FW5vjkZXHfWvJ+fD8UYZ9HxnSxcfVnR8bLe4RXuLg7vaaVFfsuYOaogpDcGVw7y0FPDtyOY7ydjVlx7ZIGel99+VeVgzREuRqZD+8C6UPMqIJ+V3lNvmX+5w5vSDe8d5JO0uOF1EQlXipQo0hQMku+3XmdOMlGHJJJLJHN/Nx9/eVyUZuL9Nu3X8tSCKNDrZ+B0kCXAk/pvDEwhl/GkD07ZAYDGCmaNi7fiBt/wyNqJSg0KvixV5HmNSBrOwW9t2+324jNp8CaZaMha/uqN6o+R+Is2cVXD5sBK7sz6FjawQs20qDkRP/qCbw4A55JMrjmA+aIWfgLl9oj8st+Pa0tWugnTF2opa7Al0x2NpAH9OOGHqZpffyk+tLQiEJJZ4d5wKxxgutbE6r54Ka/3jdCfu485zrL2aEVxS0uN00++uv72SdPrS6dhkYS4bItXwnPncKayy5KzJGOBU3yxXmOdOmGY4ESaPy18VjZYdDFmMyuc4j38XGL4c+ztZOZmBxfqa65RF2/BotLq1NrO8btB5W9bMcWs9WXAHc+m7IIWu9LgiBvEINpgjSmoeVlOK4ReSC2rixmvgWNooCwpVYW8gMwByxFGGn1xOarEmvudmiNKuawM4ZyJDgVnZ63JW/FUllayVw3hBNTO/jOSefSQenvbU8NtkFfnh93Tan0hFxOjNzTyG+3v9bicujBIp58na1frCdugO+x+oqa45Wq85EroUNtoizEQ0K/zS96kJqJE3Krkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2jX2ywWxI+khjv41OHuG05Gt6ZdBMr1lhPSPBTnNfbixKcMDWixGIhgjVdWk4OHAviGAJaWYhhvWQQ4gZxcnk2a1th+8gOPD7XPM+2APNJgwZduIMcPbmCTOjAzKrWCkDKRS/yILBco3UrUM5YLHA0tzg5+aZANKrTJ0brX/OX3vB/KaVSyY9XINXv53Bm9/ObbLYGiiE5g/bzZlPpwsoV3sDo0EPdZBMjILTU5K2Rb5a8ph0uaGgXZLlmyggrDlmKojooDNHwVq8qS/OVmkNvLB/r9gC8ney7Es/huBuNj87oG9kPWtYAL4zty5ILwYNeJeOnXY3eB3PLfakQMFkVwIgrjXYn5TXjJd2jJCerozMTusSVDuu3sNUuIk6P6pct2siNrPCNs25VuHrgvmdA92f+HlecoTaJjpAukhh6eSpQ2jCiTWimw1PHRXnFW/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:29.7238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5d2c7f-f9c3-4b99-8113-08de946f9532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013

Page modification logging(PML) is a hardware feature designed to track
guest modified memory pages. PML enables the hypervisor to identify which
pages in a guest's memory have been changed since the last checkpoint or
during live migration.

The PML feature is advertised via CPUID leaf 0x8000000A ECX[4] bit.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..8c669c9b11d0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -228,6 +228,7 @@
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
+#define X86_FEATURE_PML			( 8*32+23) /* AMD Page Modification logging */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 42c7eac0c387..cdda4e72c5e6 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -53,6 +53,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_PML,                      CPUID_ECX,  4, 0x8000000a, 0 },
 	{ X86_FEATURE_X2AVIC_EXT,		CPUID_ECX,  6, 0x8000000a, 0 },
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
-- 
2.48.1

