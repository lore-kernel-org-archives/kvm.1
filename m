Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2D453A50;
	Tue,  4 Aug 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887806; cv=fail; b=mfjYO2kakiJT4qbeURvAvhF4IUYLeXA5RVOq2t52/Eh7nckpxRJ/nIBDnKW09NqPxV5qHFudNzHKho7Zo3ghPXaIjAzcgBAD8wn5Q1rJyThOb2CwIiElK0B28jO+8zPMr5o2ruo8vKPPrmtMZiKj02EBm6GQrtQDFKNks7Zq60k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887806; c=relaxed/simple;
	bh=A5RCLZfrXGW3M42kVjxbgfzvQqXToOkmcOv9VKC/74g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGNeRqN0+dJrm9siX862LU1MRIZwRLK1u2BRKb6mD1RxSn/i3DITpXALZY92GrsNyZSWj7RlbKkSFQLOG505QgDGnBzFMyRATNMESmLxVPQohfe2TieWnKs6Tc5adnFOvRKMd7DshM7nvFmZABveFeYuytK5RN7vYBkY0IQtS70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HMC2YIno; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HMC2YIno"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wmfx+IZt7VGhcj1qXAb4Ef6+6ohSvAJMnHz3WpLizFQ9K4x+6jKssNy68ZRBkxKBiZmv0fN2J0Ea5V69VN5w+KVsLmKVSt5DojdHVMHyfXo6gk/UUY0Ja9DtCRlttZMxuPmSE4scNFrG5VBzo4QtsMlGWLgA3K7f0Bo+eOVhWg1RVgWKCCKMiG+21E7VkGmaXCK4QOk0Om1mGlr/zBgEuw5OAjJ+AO3zT3wFytV43EkJv09n3s9TX6FpFYQ0hi1F/FXIDFmr4rUOt2cFmOMo5ZBvXPjTNOADLueEXyDBxCDSG5DW43lQnlCcEXtgVDd9ZV5mY9OdQKhPQpU6ejE1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3usWa9zQ085RG8edttr2oNUJq1JJZlRDZ7ZIKIcgpLE=;
 b=w61wGBPW9v4NOJznXg/audcFeINfGbYbfqdlnepp+sAojZRm7HEcV3RMCxT8pRCBjWkwRyD7DV+u4H7uQjDgUPMzlB0Xy+87mgp0a+L9m71mTi9IPoOB574qiY+bMwmkFKPsa5tqgRzk00uaUckzOxnUiUc+mOMLXLvfOF1w2mS8hqYGO4V3XKSIOHYWeyD++fjBJubyeq6Bp1qgNGEyynJzSwz+Vo3TUQMCq9S2OMRDxVsvLJE/bqT3wO64vs7y7FiRZwnNY0nVN5esOyOAhQwNaLt2XGXG/Lll0bRkfb3lJQqhLOBbi6MCwmBUODUZoDhPzobEp0VU/RameFuIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3usWa9zQ085RG8edttr2oNUJq1JJZlRDZ7ZIKIcgpLE=;
 b=HMC2YInoXWTNaLVne4vKZMF/2i4hpVPhvMxYCCWBC9D7rT2stXnQKhC7Q0vdR/xJfuYM2iUI/9tFCRgbEJar57HZhK52AIH/3SmnICNd+4eqHixX+N0vNj6cWKSHNjU2IQ2Sz9TyGbrNYNZQ1az1r1XQ2EwmmBWA6sNvp60YdTo=
Received: from BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::22)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 23:56:39 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::39) by BL1P222CA0017.outlook.office365.com
 (2603:10b6:208:2c7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 23:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:56:38 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:56:37 -0500
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
	<kim.phillips@amd.com>, <stable@kernel.org>
Subject: [PATCH v4 01/10] x86/bugs: Only log missing retpoline when it's actually the missing mitigation
Date: Tue, 4 Aug 2026 18:56:02 -0500
Message-ID: <20260804235611.4053375-2-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c09c6c-7c47-4ccd-5198-08def284064b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BU8l6iNaW9tr2eIJ7YmrnC4Gs7BfOhWvDBsTApl4L4296bbm7Cv14BpWEuKlJ+EMn0/MC7QQFgyn+epBFD+d7NlurCkq2ciLVr8cgNlJzGWjjgX4gDkpBBeoWdVQ7TaliUMjvftsGlpzlMiFcngFq0OXqLx/8fXfET0j5+ST/verP9OekEz5Mbdx4m1PLd7SbPSfhvtSIsT1xe1v/NuT1BT3jNVTGgiUgdfq4GWKF9fZCLr4Sqy2svSTsO5n3yAwYVcf9n2eQ/Zp149Q6I9NMEJp/NitsE5BU9FJmjzR28VPdY8LpYaiRy3DL5FbwvWGLNPGogFYd9guqB5tjfRj7XRrROqrmoK5vrdX6q2UdiPEOEf3SweyZISwSfHkfV41MZ0jlgVf2sKCZALmfe8iE8kccZ2Woy6qzMn0Vmr71Qd7Ryx10XNrgmFQhu/aYJbjCKzQz05vMM/JEsBWVvpt4T4f2wF4gzWj2W4rDwAy7hhAZo2ANzBkCUOdFqTkIBVzqPNT2aw2T3q716YEza0X9D2KbnUSmN0W1T+IFRnazc2OQldFEe6S7tBamp3Psn+08lZRBlPK7Ta3XDEA3McM8yBprtFEgiZ0uGB8JNVD9Cjt6OjIu+h1QXSALMDGg1gCY+bkO1YIkMmRrXaR+FQPbXv3HFvKbWZN3uAnxwKEjICKAXYqkzNiSfVBz2d3u7n+VPgypGyOubh4eNoWq5TG0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LYL4l2i7g9WTb0lzA3X4bKc/YH9iruqX6FBJG/D039g8iwfBJlesUWbKjRwk+fIqML6VpbpQdi6jqsQCWQCXj+bj4ALgzVRD1WOBlf264bvNa+FIoeQ5MPWvM2RPl10mi1B6YF5uTdyynQDaMql3fej6RD6elUArU/npQchSt5LvIOI7D2ERmQygiV+g1fw13xWB3+D+wEjQZ6AJJV/FddW8WB9v49u1/72uSx616FY0DZvuJjZtQgwsl0VDe6m8sZ7DO/edkQz5XMx/saRmLJjEU2hlbfdBqCRCrx9+UUCyvhziRsLfq2HyEHLuk2Z6g0FXTYGmHKCKmoDmjOFOt47dbEXEonlXND0YYfeBp2MJ97oqmDD/21F7fURZHooZPRZcwZlijT6spNkQv4TakdxxBTPNL4+soo5VlMpYm+t9RIvEZPcsapNgilFspe8R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:56:38.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c09c6c-7c47-4ccd-5198-08def284064b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

spectre_v2_select_retpoline() unconditionally emits a pr_err when the
kernel lacks retpoline support before returning SPECTRE_V2_NONE to its
callers.  A caller may then select an alternative mitigation, making the
"no mitigation available!" message alarming and misleading to
administrators on a system that is actually mitigated.

Drop the pr_err from the helper and emit it once from
spectre_v2_update_mitigation().  Guard it on
!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) so it only fires when retpoline
truly cannot be built in, and restrict it to the cases where retpoline
was the implied choice: SPECTRE_V2_CMD_FORCE, or SPECTRE_V2_CMD_AUTO
when should_mitigate_vuln(X86_BUG_SPECTRE_V2) indicates we actually
intended to mitigate.  This avoids the spurious error on a
CONFIG_MITIGATION_RETPOLINE=n kernel where a caller of
spectre_v2_select_retpoline() selects an alternative mitigation, leaving
the system protected while the old message claimed otherwise.

Cc: stable@kernel.org
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/kernel/cpu/bugs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ddf0db5326fa..b345f64f4258 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1956,10 +1956,8 @@ early_param("spectre_v2", spectre_v2_parse_cmdline);
 
 static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 {
-	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
-		pr_err("Kernel not compiled with retpoline; no mitigation available!");
+	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE))
 		return SPECTRE_V2_NONE;
-	}
 
 	return SPECTRE_V2_RETPOLINE;
 }
@@ -2247,6 +2245,13 @@ static void __init spectre_v2_update_mitigation(void)
 		}
 	}
 
+	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) &&
+	    spectre_v2_enabled == SPECTRE_V2_NONE &&
+	    (spectre_v2_cmd == SPECTRE_V2_CMD_FORCE ||
+	     (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO &&
+	      should_mitigate_vuln(X86_BUG_SPECTRE_V2))))
+		pr_err("Kernel not compiled with retpoline; no mitigation available!");
+
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
-- 
2.43.0

