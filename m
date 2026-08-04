Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46575456E0C;
	Tue,  4 Aug 2026 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887874; cv=fail; b=O73cL3fUfNFyupIDjiWBeONlrx61z94oLmC/tuvIcDtp7N8MjdC7g3lA3gx7zvayd7h6l7PtP6KpTSOU0DDdsIFtWq6UFuIZc+r1mWeudE1Ne/cOLc3uZCIHxAK2p+O3T70ZF4fKmEg+hQXjWTMeJpbiyhpG26KJWhsbb1cbhGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887874; c=relaxed/simple;
	bh=CbNPk4evOHMWMjMwkpMr0RjynU1BI8Py5AE/OIoCeLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRbDboeoXN26rILljFm+6aR1gTH+7f/jf9Q73BZU4r0A6z80ozJB9mbVLzwf79fatf7s8CBgFpE+c5QujPR1LUK0cusJiVF3vS6BuJldYi4vOQlzMp0seJO19ihUWaEXoJ33W/rb1EBuYDe4deaQos2gfg8Np8EGbrtcVBjVz2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YitRQz6v; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YitRQz6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzhljX6sVaweR4GJAE/dsSFXOi8/7iBpJ2k0IesuIkeSDkAsoTS9azB0gUEKz4jOQRjzrOVTUwwjZRvlKO+gqIoIGlaHftm+BrwaSjcfW3QSC8Cgt/eian521xHZJYvN1KEJupgkDe38uuMPFmMNsfb+cu0+ywVsOzRd4VRwacUSxEaoRvKAFsmM5rVFWWsC+2Fud7z3w6WMZj1pzdbjH5cHa2K7XCrA+OJOP/l9JIyROhgGa4AxWj34zC/1A5B4mAq2s0RbK4HawprgFfGPpYxTyGivS+YD/Q3Xo3BfN+UOim5+W7C2hSOiacnCu95IDGNvzQ345FNT5QfyoqlQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjbAwErg66wpFPoED/qfCl1bsMq/IJ54Dn73rA86eSI=;
 b=TTwfKQB/SBJdOxnT+a8UgMH8RMW438nkmD5nVZAW9zLIon3AHnmGvWol0kDoJqV/srLn95zQ26vCRHq0Ln5YNUGE+/a3DJNOjaNLg8lY1fjAdz8tf4oVywdJjTzYLj1VNH15aqYPgUfrrtRm6+pgtkvDV1QETvKSckfLcKEEk+LKtgd89aIdDHFRS/8LxqHkL07PTE6kTOTj775ZmXkVGiN3090s0TSoXuX42QV2TVTegPoZ9v3fN4jbie4PgsT7sKtEChNT/r1ZBQ3hfEHMhGjuGRjIFSnDCGAQX7BNuhVNrHDmzIie5OQcCiUvJxbe2KMiDefcNS8HxFmoX4trJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjbAwErg66wpFPoED/qfCl1bsMq/IJ54Dn73rA86eSI=;
 b=YitRQz6vJdEWV/nk4xqcaUt08Jgnq7IxqrOwYOKOGxGO7J0Ov3n1CIOathUm32UZ3MkF6KcXdYH6zDKX9mYggZaPRki3QAzBhtmOWXU2uyCT/wyP5BvSCpN17bzpTTBNUZRTP62+VT+viMxi/z6zWdE32RRh4exFNo/vTVrQ9pI=
Received: from BL1PR13CA0395.namprd13.prod.outlook.com (2603:10b6:208:2c2::10)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Tue, 4 Aug
 2026 23:57:46 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::9c) by BL1PR13CA0395.outlook.office365.com
 (2603:10b6:208:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.13 via Frontend Transport; Tue, 4
 Aug 2026 23:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:57:46 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:57:44 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>
Subject: [PATCH v4 06/10] KVM: selftests: sev_init2: Use BIT_ULL for VMSA feature bit definition
Date: Tue, 4 Aug 2026 18:56:07 -0500
Message-ID: <20260804235611.4053375-7-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804235611.4053375-1-kim.phillips@amd.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a751dd-4ea6-4b9e-5d96-08def2842e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|22082099003|18002099003|6133799003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	v7/cq28MGLbr7l/UbSmaLBbtF5D4PJEi7ZSCVHNoPImlZ+82fkdy7IE3rR1rCwDxariVLz05Hhw4060/DmDxJoZFHfnS37vnk7U4Yn0NkflTGRfkK0S0PVCVaRVI9UFz3QtFH+VcPbwYQ0YWw2gHtZdQIujrw7JJfXiTvgF/7o6xIDH/xCMKilv0I5HMeGLwp2Vk5g/owQfT+YKL/vOF5P9qbQRm8yP/aJb4K2jmXFb/U1+UrRK8pUrz7Yp8Db2qAmHovGQwh+DPDEab1IRgaPWbd3PDHoZQlNsVcIBhEvsLFm/pj1+C3nQziX2IWacR9GsFSgQSTWKV7ip4eGukouRugavtlUUJUzMBwQxLzwEVsIpMsJhEZnTgpGw1FtamuzAaTEB0lpvXXzy1NC+yFIPdVe3iRx/EUL8PH1oeY3hwgVBv5FWmo3oqDm3lRIm/fy7+cMaXQTFZ6+4290meOIEqWzkSWyXgVaee2tQ1MuL3b6SjQD+IT3QrzlXbl/8dJudsCKGQgxf70XBoqb6zeMgL05FuYPw6Cal58WyNkDhTyXgPd72lXI05UR48uK491Ymol1ODrSeZVA5teIxsr2NfZRQRRsoOYzxT0+gDYQnGbI4O7e2tdm1eMVfyOJ08D8ZHvUam/pznosXBQxP+zZddemt1pVFl6eYt/SemVNPw8kL4JbwN6RrCYFrvOM4vXKZ5mklEt8G/nzmLJTasEw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wy7wm0AjmpbAJKNMXLbJ/z085yMp7a3keUbGZa+iG7loWhhQjoFnJFAGdyYD+pcm+dLyvnaPm0MEFwqH3xcjIG84paJV88ZguI9h36EW1QeefjC5g0/vmeq3fQnjWCTr3nx8r+oO9Mp47J3HVD96d170bioZkzzoG99GZ4IqokHUOQWX4+XK63v5OVbGCKU+PZgwEsv5eORCn59r7iZsnk4Jb8ummdlUo99WpLt7g1OLHM7O1ul0zjThSNhZMNJpTPR6wTqAWAGdyUrr+yYfYp7TIyiSleS6H2BLKG+XGKRgurvASxl09khTJOKTnij8UWlxntHmRlMxj4rA/mFFIH3mqWktSm9UwmMB7GlwsCbjGw6z7jIH80VMOLAqRHtdEZNMBx9ZPZnyv1SFiGFMsv0ZY4HEp11Bdy/kthEyni7zXlFJySwFYQu7GYc/NnFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:57:46.2871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a751dd-4ea6-4b9e-5d96-08def2842e86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

SVM_SEV_FEAT_DEBUG_SWAP was defined as 32u, a 32-bit unsigned literal.
The kernel's supported_vmsa_features is a u64 and uses BIT(5) for this
feature. Redefine the selftest macro with BIT_ULL(5) to match that
64-bit semantic and the BIT_ULL(n) form used by the additional feature
bits introduced later in this series, so every feature-bit definition in
the file is uniformly 64-bit wide. The value is unchanged (0x20); this
is a width/consistency cleanup only.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 689390c10f7c..7b0643bf7ca1 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -13,7 +13,7 @@
 #include "svm_util.h"
 #include "kselftest.h"
 
-#define SVM_SEV_FEAT_DEBUG_SWAP 32u
+#define SVM_SEV_FEAT_DEBUG_SWAP		BIT_ULL(5)
 
 /*
  * Some features may have hidden dependencies, or may only work
-- 
2.43.0

