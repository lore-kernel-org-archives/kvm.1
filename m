Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8B367F3A
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402993; cv=fail; b=DD5GQUc4eN7yK+CBxwWyj/HW6m1jtA4osEdFRX6lzM3QaeVaWrhS3b1pMJ9KNNuwN9Mpx9TrzA6a8KRSftn5MOfl2iuRy6BDGUAQYHz4Ih6kbEEVePGVj1R7bkmOtjMG66RyZ4oxczQ5q9PraFyW2UBwcLUdjss8nPpAg6uJuW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402993; c=relaxed/simple;
	bh=ZW4k2v/rCHQMLvjdk9LSzcjiQZCAF6qXhb4tgO+ZHsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGdxf5aq62Gg5syspzkl4jYTew3nZCAxCPFQRa/UIiCcFj93aaKMWtY9YqU/nf1BXlf6KHS1nCUGSrRHaPJc0s06WyaCUX9rqaFcIuUn3kKEROq/0ouD9n2tjEu0Fs81Jk8TJmLaRJh96ZDmLMnMZsoD2ioh8cRDmWM1xc2Srb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BpemcmWg; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BpemcmWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqBOcE5sfevQOIkRh4ZOBODjgHw35/2FyumOHY6MoQLHQHJAOHYcRZW4Vu0gFtQaIhi77JL5xldwFzU/8XWXb8x/fKveizoDE7EhDY+9FpNpNQ1JV55+sl/rkRyBCME674wLyk9n2RhjCbwRXPhT2ujZGabHqp6Pm3xB83dAYnVDd8dJ/yqL/Mtqi0TIqnJIwirDRJHxwIUi4H259qceDAgMqZhVS6WvvUDbHWgmDm4JLr+tVI2ASmwh/NVK2ig7HLqSBl5Bki0w0pMI2jV7Towv0jXDHMVqXoPiu0aMyxxUR2bHSAJgtojIO2lwQZDGc4RN82lJLWjiO3bwvqDE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJQLQZClHL+ncNIYxtkuP85ZkOPqMq4ELLElU8u9H7U=;
 b=t1nmXK4WtdCJ3MJqcCB3dPDQ8LRAhngkKJz4skeYGgPICay4kKChc0awtE59A7Xt72NPZ5C3hLdJqo56knh9r57wZpXURENF3k5gcuBPRB/A+xs7PvMPzACDzU/w9HF90wQMYuf0mwDumq4T7ip8+liM8zzGGJJxejvlY9j1VP21o1BRQQoub1ScKnlyYAniF6kTf3/g8urumyesx/tpLEjMISFRlysZmEhrSKNAbZuAcYc03YRCcLTwylTL0cO1sgbE8lSLn9P6nf9u16XIWKXO4jfu4zRNMO18gJnAkOac0N8+HEJSQIB7Gyz3aAc9QvyRQEZTMhvTeMjKYw0xVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJQLQZClHL+ncNIYxtkuP85ZkOPqMq4ELLElU8u9H7U=;
 b=BpemcmWgRoUkqY65tJDrsWMgXixO8PIwLHHhFi+DMavF4MOSIXQrNk5pZeUrWYdCmrMEII+sDpmXSdBgefRI6/rm27fw0TFApboQn8mOYUeFP+G24LxLiRmbYIJ3zZgxn/9q6K4O7K7OmFJRTxuO2TGf9Og7Iy280xKq3Oy2Rjc=
Received: from BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 16:23:02 +0000
Received: from BN1PEPF0001854B.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::33) by BL1PR13CA0407.outlook.office365.com
 (2603:10b6:208:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 16:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854B.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 16:23:02 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 11:23:00 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <michael.roth@amd.com>, <thomas.lendacky@amd.com>,
	<ashish.kalra@amd.com>, <pbonzini@redhat.com>, <prsampat@amd.com>
Subject: [PATCH 1/2] i386/sev: Introduce Enhanced SMT Protection for SEV-SNP
Date: Mon, 14 Sep 2026 16:22:43 +0000
Message-ID: <771196a9b02a0b7d33265b574894cdd99c33cc96.1789399242.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789399242.git.prsampat@amd.com>
References: <cover.1789399242.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854B:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a6b20b-5de9-4c3c-f3bd-08df127c72e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GJSTSsKCuhrATMPlnJDJARm6qUrpfGpOyb+hrjr6EMUXRQHRayu2/GUkTgiLv5ins8xYQothPm3DpkHKYrftaRX6W4+yEiACYdTM3WQFN5KXmOpwRHKrE1fYlJVPkt08Nz2jxqDRru8pcdy0NIcyMbbUAs9ATXrIPHAxu/1nHkUqNcPmSpfxq2hy2O2oA6nKuETNR36/2Gi0Ys6vgfkXP1kbEzHrdy5KPJYhu5zTW2NWEsEGYIgIPQtfNU3F3pnjjCnG0laqilasYKozanjqQl3Wz6hMMpXU6kvniQizxwR/OO6iXIOJudH+Mr9PmsxLjlA8JxkRqjhwvXcAwAVWDFqSE51YD4UmC/vSI2wCHL1+2ulAohUs2wNPY+5yMM/JOl2DnXIwwPlw9Ka29ZOWEYRh96Kk/GnAkpQaKtgZl5aGde4gv+gumimdCvuhQKLw9wblVH9FVx8UpuG90oR+uXhidJufwRhsoKmXwTGR9bjxvvbqNa2fqMCGw9pLhXvwvstf51m81wxadEbsKSjSW4GtwCX9PGP8WsXur/dxMYDk1eF4x2HE2QswbwVJpnFrtmkKH06Tog282zg/03E9ga8WUTElzcmrHsrha0vj4qof6nflqh5g0MjEPmE53zi8IYeqLLMs05tha/qYyQYnfgh1nERT4MMdFqiBCOanzfmgi2oxhw+0gjzV+/85WqiUaZiCdpxuvqvpO+DmCDVx7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VHxNu7Pwh5rK4D6AtanlovGX4UkQ3Bmxu1DgUPf5ha3JRrhtP4BeVPURutEVEX3zFcUHq2s2p91GgOFps2FGMezeTmWgxlPqAWoDcbGIjk3huFb2aXR6Fv9hLnfxbZDNOqBoK8YC8I2+VZ3EeXi0oGkzIgKyZHLG0zpmiMcZ2yR2U1xpmEdZyo6Xf9Kl3+HFjf0KWCa8aCG/s3gs/uWGx1lTqFBoX6ucBZAvWBBpKsxKrGcaVtVvh6K9n3GrlgFj1eXRMdc7LmM4VrDC4wgmHPHMNtRZ2YVQXqW1kJHSS9DHG0FmH+IWVGYZDrp3/97oloRzVkHHmZgWPoabFOvWRLGOjXOgH+K1TsfLrJ+IQ1vyY0ZqgU+DZtd7LipWfxly7Mm8mGITnkbBMwmlQjB22VoDaztRbdVCutd6/QSRwUJNGKxfjz2EIkmUAxOo2Fec
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:23:02.2583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a6b20b-5de9-4c3c-f3bd-08df127c72e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001854B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

Enhanced SMT Protection (ESMTP) protects an SEV-SNP guest from sibling
side channels by requiring that, while a vCPU is in guest mode, its SMT
sibling thread is either idle in host mode or executing a vCPU the guest
has declared to be a legal sibling.

Add an "esmtp" property to request and use it to advertize this feature
for KVM to write it into the launch-time VMSAs.

Sample command-line:
  -object sev-snp-guest,id=sev0,policy=0xb0000,cbitpos=51,reduced-phys-bits=1,esmtp=on

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 qapi/qom.json     |  9 ++++++++-
 target/i386/sev.c | 15 +++++++++++++++
 target/i386/sev.h |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4a9b7f908844..010c5cc2bb82 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1119,6 +1119,12 @@
 # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
 #     is enabled (default: zero) (since 11.1)
 #
+# @esmtp: Enable Enhanced SMT Protection support for the guest.  Adds
+#     corresponding VMSA feature bit to KVM_SEV_INIT2 vmsa_features so
+#     the host applies it to each vCPU's VMSA.  Opt-in feature as it
+#     provides additional protection but with runtime overhead.
+#     (default: false) (since 11.2)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1132,7 +1138,8 @@
             '*host-data': 'str',
             '*vcek-disabled': 'bool',
             '*secure-tsc': 'bool',
-            '*tsc-frequency': 'uint32' } }
+            '*tsc-frequency': 'uint32',
+            '*esmtp': 'bool' } }
 
 ##
 # @TdxGuestProperties:
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b07123..0b5767057175 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3255,6 +3255,18 @@ sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
     SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
 }
 
+static bool
+sev_snp_guest_get_esmtp(Object *obj, Error **errp)
+{
+    return is_sev_feature_set(SEV_COMMON(obj), SVM_SEV_FEAT_ESMTP);
+}
+
+static void
+sev_snp_guest_set_esmtp(Object *obj, bool value, Error **errp)
+{
+    sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_ESMTP, value);
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
@@ -3296,6 +3308,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add(oc, "tsc-frequency", "uint32",
                               sev_snp_guest_get_tsc_frequency,
                               sev_snp_guest_set_tsc_frequency, NULL, NULL);
+    object_class_property_add_bool(oc, "esmtp",
+                                   sev_snp_guest_get_esmtp,
+                                   sev_snp_guest_set_esmtp);
 }
 
 static void
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 7725f92e1959..6b4128dea4ae 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -49,6 +49,7 @@ bool sev_snp_enabled(void);
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC     BIT(9)
+#define SVM_SEV_FEAT_ESMTP          BIT(17)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
-- 
2.43.0

