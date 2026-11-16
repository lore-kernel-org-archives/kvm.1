Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794870233;
	b=aHpbjmg7P1B98jvlBQenQdGRc5swRItN8fGHvCst8Rjedn8DpZJwKko/ayu2ITzfZAlS
	 jguUnHbZS7YFVSf4BoZbiJ+riZhzyerp7wE6H+J5NnA1VpJ619BEO3pUe1P87EgyHkDoK
	 I+VFgX1s6BY205iOT/+R1rxzSK4kD3iQXJ2wW5/NHOpiHWMuKeNd/zZxiQf9B3NGc0lOn
	 sjt9f8+gqVWnk4lwDqMC3yx306EpeqOpZS+YKwBD7W5IzwzmLWy4WLDLjNsTihk+dZo8J
	 yQMhcLo4NiA96OYgROWTwIQO6wwIvG/Mt4Igwf2NhZ0LQm6Oktso+CSAGl53vztkCWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870233;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=7Sqqz4CUK9FM2c8iI8rMI9qqDHGwnTjEE3CtPNueviM=;
	b=ybpOLm7jF4oMHVRKPICIsx2Mk5mQwIX0XsmysYtQeaFSQ7j5dkfJ1mkI58Wz1oTs49HA
	 J84JVKicA0FwLQjGnQA4n1eOGjv1rnPABKYsZ6QDLO3X1tKMfiqSBQS9ZVUSAoGPuCntJ
	 bw9SGWvN7ei6pIp8V4ntFWBzhrJ4MzuTyt59kU1bUp1Wae/q9SkawzNETD6UTEaBCDsf1
	 fizw2D9B68+FO0b4VZAiK/m4C0De8r5KxNLnzJwMXwnIqXJw+aD8e1NpRlKeDNxm7qk//
	 nAeuXFGgURS3niiBPw1wUVE3FU+rjoECyrFbQ7k6O7WoZgg4liaSDzX5HAIWDOHbQAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="zkQ2/nRv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.70
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A885606A323;
	Mon, 16 Nov 2026 23:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A885606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zkQ2/nRv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBaYLhfVlHsbf5CGC5MUsbqlD/ePYvnWdQs7DiHtdoGUX/3cKRsaPrwbB7fnMjk7Q3tH9d/89GLSNK9p+xUYPt7JUHtqFpBoR6kjSWplNfDnafizV/Gdd3zK+yIFg+ACL/+0SWM6PwMsYKNhcTFxhSjJ6ZMhSEsEx7fGxAdGAQL/sbj2OQPR58wks2KVsoai7tPyI+R7Twb47xThEASBwbagXml6q2fVb3yxop3ybTaPb7wXKZ8xge/blpAD95VzQdA2LOLYsfUTA8MZNb6Lc2tmiPBrJ5YzDtzfcmp2G+3Z053PFtZdBajZ4ru+sovyepKIrUxEEM8u4gXCwxdydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sqqz4CUK9FM2c8iI8rMI9qqDHGwnTjEE3CtPNueviM=;
 b=rgjbEaj/j+73vcjdJm5vYmz+/Qsc55l+jH/49C801cdJ++5Hea3nlSxeYEBuZeTHDOpbb7u2zawynhpOdcgYf3/KeI4NHKbq7Y4mw+tAZeQ5SeihKJjZvU685BBjqiRWYBsIjPCH3i13bOoWx6ErVaYU9Dmog5g/MfIV1XSht5xwK6EZ4tjQU0GzKh4wHaTANsWIlhdH6h96gzc1ZIsxWboi42pZ1ZXhluGtR06VVTDlc1tZCrwYAGkQcHe8qQW//hrbRUK1hECbHAvAXTwdvKtoR9giRHxPiDZ/ZF4JtpSRsxnBRQSFbMRVvGmJ2Y3dN97O49wsyeqKDVN5qOc26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sqqz4CUK9FM2c8iI8rMI9qqDHGwnTjEE3CtPNueviM=;
 b=zkQ2/nRvxwNDil5oXC+cOus3awtFifyHrKrOkuSECejavYlLAxBx4BsZEJAdesfyDEJYBveMLcuO5kbwTqugxSgukaVR31/SQf3bGeNWHE3E7NO//aEzQh2LYc+zQ3Wph655c97mhn/sZi1EJ/CvTFTZ4+OYbItGXXY3seyTBP8=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 23:03:46 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::28) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Mon, 16
 Nov 2026 23:03:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 23:03:45 +0000
Received: from nigeria-2635-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 17:03:44 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thomas.lendacky@amd.com>, <nikunj@amd.com>, <Srikanth.Aithal@amd.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would trigger an unserviceable #VC
Date: Mon, 16 Nov 2026 23:03:35 +0000
Message-ID: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec4c501-696f-4fb1-3b86-08df4435de0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261009223027099003|18002099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|261028144727099003|261022105027099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8A8wAHtWIMFitVyEEmVkq09zPlYVYGfk3llvlGdsrW3EzA2pjuhoIihRUG8Gb5v3+FFpRzQcqa9dOZVR1GvSTVmpi+QjWy/lj1138VsPCONwSloTbp44vSEX+jF0cnt9Un118Q1KXS0ot4n45PPP67NAdu3obJRdTmL6YXypODQKDgniWv81rhsf7kq+qt0tBQNO3i0jz35/lmtHuWCWBRUZk5DjP/1GsAbWab744ms1BFnYmvE7R1ed1/43vxE+vqxRWe04ENjgJqTgy+AW2h1UdJcOEDALQAtg1FWazyLYqO/gZNU1kE7SDGj0AQKswCI2mANar5kebcVo3WNMCXOgtioc0I537TOWZ64wY8ju4BNVYd3lPncqAW6Cbm7M81yMJO96gvr+QMl7+AGvtS8kwErbwm1ZTBAt7s9Zgm33eukJB+V4oO5fjF5kOq4UvuW7bAYAUWlBfWVK0LqyNaXgpBmOODF4KMsgHGRE4liA/cVkDUjBEKVmFJhDnjLzqWTRI43t76/YtrNW95l0B+agvT7AXkhiUUIjeI8OA3DY0tvTQDIWnY/EdrofTN54Su0RITybmb3jCQg4baYR9qI7J4/p/9GrQ2IxwJQX8y6qHsInGSCRYBpDVWKnR+YzJucWLcJ/agHdBxGkrT+9raxHCLU0ocanNmIPzVLkZ+WfWzw2MIyQhl0TFKVNEkJVMECVK6zon1nkOap8T/54Rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261009223027099003)(18002099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(261028144727099003)(261022105027099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gn9mr77+VPsqRcQkoTNER21mWN2DOCUF4a77Vt9AM2pEnse3ljEdvv6aQ7GICqQscUrpP+/QZCkU/Jwwm/ADRFvx6mL465RhbOUyG9vFRtDcVCvtOdpPOPeNcwVYLhjTNU1Ap7s5d6T1/nVcFJ+nCN2D+kQpoLUlZZMPEz0izoZapcpZEw+18p+JwgHQvyNLoNUEGMrtAAdAEmvtQEBy6Ex4IjeAVXkonkEBlPfG/3HhyDmwHvpX9uiF/TWI1V/pdVPhpGffWAyGQQYOBxThang8me0gJnuz8c4pmv+wCNOhPsRNfyVtk+Sxs8+NqkDMo51VJ6AfPGpYL8X/cve5o3efbB8lgDEtmG1QgpSWdEUTjQ/A0T6QAJdpbYR9obnprNTOqCuzsXm8vZ+3y1CLF/KhBkmE9JJAlF7Lkjhb4VJsA1tiUskIxfBNO+i4d0OY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 23:03:45.7985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec4c501-696f-4fb1-3b86-08df4435de0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569

From: Ashish Kalra <ashish.kalra@amd.com>

machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
intercepted and delivered to the guest as a #VC exception, which must be
serviced through the GHCB.

By the time machine_kexec() runs, snp_kexec_finish() (called from
native_machine_shutdown()) has already converted the per-CPU GHCBs and
the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
GHCB infrastructure. The DR7 write therefore raises a #VC that
dereferences a NULL GHCB pointer, causing a page fault and the kexec to
fail.

The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
Fix early boot failures on SEV-ES/SNP guests"): that change makes
__sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
the previously-benign teardown-window #VC (a bogus VMGEXIT the host
rejected but survived) into a NULL dereference.

Skip the DR7 write once the GHCBs have been torn down; the kexec'ed
kernel re-initializes DR7.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Cc: stable@vger.kernel.org
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
v2:
 - Move the check into hw_breakpoint_disable() through a new
   snp_hw_breakpoint_disable() helper, so the SNP-specific logic lives in
   SEV code (Borislav Petkov).
 - Drop CC_ATTR_GUEST_DEBUG_VIRT and read DebugSwap from sev_status.
 - Skip only once the GHCBs have been torn down, so use_temporary_mm()
   keeps disabling breakpoints at runtime.
 - Trim the commit message (Borislav Petkov).

 arch/x86/coco/sev/core.c        | 16 ++++++++++++++++
 arch/x86/include/asm/debugreg.h |  4 ++++
 arch/x86/include/asm/sev.h      |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index eb2e853e950a..64a5a037a9c8 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -723,6 +723,22 @@ void snp_kexec_finish(void)
 	}
 }
 
+/*
+ * Without DebugSwap, a DR7 write raises a #VC, which can no longer be serviced
+ * once snp_kexec_finish() has torn down the GHCBs.  The kexec'ed kernel
+ * re-initializes DR7, so skip the write in that case.
+ */
+bool snp_hw_breakpoint_disable(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return false;
+
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return false;
+
+	return !sev_cfg.ghcbs_initialized;
+}
+
 #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
 #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
 #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 854d82b88ff4..af15e2c928db 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -8,6 +8,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
+#include <asm/sev.h>
 
 /*
  * Define bits that are always set to 1 in DR7, only bit 10 is
@@ -108,6 +109,9 @@ static __always_inline void native_set_debugreg(int regno, unsigned long value)
 
 static inline void hw_breakpoint_disable(void)
 {
+	if (snp_hw_breakpoint_disable())
+		return;
+
 	/* Reset the control register for HW Breakpoint */
 	set_debugreg(DR7_FIXED_1, 7);
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c7ea9845351e..f38bb521987d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -522,6 +522,7 @@ int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 void snp_kexec_finish(void);
 void snp_kexec_begin(void);
+bool snp_hw_breakpoint_disable(void);
 
 int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id);
 struct snp_msg_desc *snp_msg_alloc(void);
@@ -632,6 +633,7 @@ static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
 static inline void snp_kexec_finish(void) { }
 static inline void snp_kexec_begin(void) { }
+static inline bool snp_hw_breakpoint_disable(void) { return false; }
 static inline int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id) { return -1; }
 static inline struct snp_msg_desc *snp_msg_alloc(void) { return NULL; }
 static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }

base-commit: 9f74092fda91ef93c2b07585785c1dc83cd7971f
-- 
2.43.0

