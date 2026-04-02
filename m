Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB238C43A;
	Thu,  2 Apr 2026 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161612; cv=fail; b=F7t5+SWlGwL4lbf7S1rbTgAKBYDnR1BuW/4E7FfRZkxb/merzGBxDQRb9ZXvF8I12oYIPCrM1UVehapFChb/FFvx6si7sQmeYpqqOqkOgdv9AauwNhEWgr8odKbzeR4w3D1rIHeley/6wT04vAT+1h3HOemMm6mng/Qp03MA3KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161612; c=relaxed/simple;
	bh=f+KVPsWcd+kA8nBaVaSzHWSeBR+s6M0YkHriF2lu3Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhHO8GTkACz0i3AjFxRLpLL0vMS+oFtw4T7D6rhl+8XgHiGOCadCFdItbj6R9W02laoZhwpXE3248BvnH2gK+tz38j9gy2hi2X6J/rp8GQH+Lvxecc8E+2btc76NEMWply0lPns30h8FWmNnK+gW8Mt9l6CrD5MidvejLUi1z7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pF/LE5ui; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pF/LE5ui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1ospXz5/xbbCbeW0+d9XsNKp+8qKkuC6uiuTOOfJuBUWxftGsZ/WynSbIGTtXWEx18dwnGmHBcw19OmrS8G+GBwH8VgOsbvH1lTLbwopvmYWkK/VVaFTgtjq/WKsFE73kOAKWI0OL8jWI0ftEo9/Vuk6Nn6JSRnFLsQ+CbPUGynbabJlmyGuEbYQvGeVTlqKAIkobRleSs9sMNP6I6/W3E5MRwpwz180asxDuNVg/2S4RB9dxlZetU9rnakQ9ExBjVbDyJwO+TBsYjyZSpVeaC8LSuljF1DIJ+foELnHwU+9k10hB02J3uKZfbQINVzhxYf7ueaoKQYSWt9BvfyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG1Qe65iI3pxNftN0aHj+9K+eUE/N5crIQpu5JWTokY=;
 b=wZZYFKwPHlvw3kSGq6AvL4qjDlrBhE65DgkbfjijIOMZ5WmL9A3REz1b1xACRkpan9uq4jAK3tSMg8LxoHPgQgN7Lj6S7jYeWeBtyNSZ5QG2cSIjeU2C8t6x5cgMv68vsBP4LlgcnaHWP2Wa8/RVVM2bbJt/91q/G30MuZTtn87SoKcKk61R50VowaFSCLsmv84MpuUcweJPbMuSWeCsrKqdWwxDb6rB7G8TOopqNkLuyDuxqdRsq/Xu3fIpaoQri6It6KoyZVQz5zagmTRnwrAI1T7r1O8ZogWEKjKbyAwM2IgY5YC5o2qcIawWUuavYa/ybeY9/ypl9vu8W8zJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG1Qe65iI3pxNftN0aHj+9K+eUE/N5crIQpu5JWTokY=;
 b=pF/LE5uisH+fsuY5qfO2XGxkRXRLXywHwkSTZDuDtLUeNlmBCXn6RQGNtark+eakvgbFSHYiQKwg6MZXkjWdDfMdhNGJoSJJDcsRzItq9eQs7j51b06MqXWlvwmPttPprpJNExkkOZY46vqdJPb6OY4AnIWwIebMNXlGmsIrBmU=
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 20:26:47 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::da) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 20:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 20:26:47 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:26:46 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>
Subject: [PATCH v3 3/6] KVM: SEV: Disallow setting SNP-only features for non-SNP guests via a single mask
Date: Thu, 2 Apr 2026 15:25:55 -0500
Message-ID: <20260402202558.195005-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402202558.195005-1-kim.phillips@amd.com>
References: <20260402202558.195005-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee69840-97d9-4c39-46b1-08de90f62a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sl1Qr/31L4NUMG/3F6eXo4uW1wzUYX0XAqvoTQRLygS3wrqf60QqBGPGQ/ZoOSHUejwyKJQJJrxhN5dBYiJbd97O188YcY7RczgJG4FicSSy6mzQkRW0s/VK/saq6Lv35+djhRq/ZMbPvcRujP59D8B4ONLphypreDBThTJrFE7abgn1AZhfWciSXXiPSBn8kdjzg6SEZ9bMIz0Gv0pgcL2KKk/mJJ6Cji13P9tfYvrvWKrJvVT4URTKAwRz5d754KoLExY9IZjpH/HXt6odRqd/HHXthdDL/u1e1rCw5T2+w+8yKTUiE9PpCZyq7aVFk7Daa5D4oI82PfVhS+E0A33iILk74iroViCeWhDeAn5Uz/GJ1W4GbF9F+qrLneb1jjpZq2ja+oF6Q8N+R4VovAJf9skUaFTgHN/n8HtvBywsPRMqSWIfGuTr4+hBryn/GNc3ialhQeCmFdTsV7bgCL1FHMN0A49Gweo4nV3I1Ki6ESepPZbSSpc1uBOy8ouswynR8vNP6nni1CWRQTlDXsFFB2Y62v1RwCwoZzBgRDYpE5KUWmUdFRgfeEpWOtcUVHFfwRylyyTnr3JaXCS+jwuSVse1floTFKCs0A3icsNYfQMmGjMFoq6xhhH6QntJqCy9vvcDzPsFR512KsLt4gWCVjg2G7d/nECdBM7+0nSJUFOhTSI7pfd/ZnWeU5tuDlWQRqCp/a6KGQPP5V+0a+tuTt2MebK/6DRdJcKIs1vgFich4Wg+/Hx9is4leHZLQFA5XK3XU+uEfwH/SzdMwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cnrYVD8bdw/vfozPFf9hjIN0RTvZUZ2WbAhGnJvWFB5V6HEZ5A4IsRke6OIY510y+EzFM9oebiN0iDQ2meNahrBRAdmcjO/at0SZZC+TUe0UOTcWmwGQzj2WyQ76oXe8QoRJXzrMSiJsf+jKrHJ3QUYRAgxQ2AnlIp+FDlPXRDanW94pNIXVgB9+xWx5iyheRFK6G7sVUBVSV/cKqFLLT+4oAMdDF7BtgX9bD/sPP4PpcgtJhhyH0l947q3AiQJCI2K3B5KnjEs+vWTAC7E3F+hARImxXxeeIIcJD/PC/cf89c804kUlq6kZLmhnY2Vp2EkYDahnC4hzaQVDc0cjLsBLOvOpB1ievw96a3fMYnQQJFc57NDEKPX78PUAxTVHDMdmGnUUbdRHs/CP6XgYF2sl/BNa/gbn1gNLkXSIK52SQaA71O2huUEsksVdNUnE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:26:47.6292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee69840-97d9-4c39-46b1-08de90f62a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

As SNP-only features get added, adding them to the valid_vmsa_features mask
in __sev_guest_init() often gets neglected.  Add SVM_SEV_FEAT_SNP_ONLY_MASK
to help group these common features together.

Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/kvm/aaWog_UjW-M3412C@google.com/
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v3: new

 arch/x86/include/asm/svm.h | 2 ++
 arch/x86/kvm/svm/sev.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index edde36097ddc..7e3f9d92351a 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -307,6 +307,8 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
 
+#define SVM_SEV_FEAT_SNP_ONLY_MASK	SVM_SEV_FEAT_SECURE_TSC
+
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
 struct vmcb_seg {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f9c1aa39a0a..2b4f3c05e282 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -456,7 +456,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		return -EINVAL;
 
 	if (!snp_active)
-		valid_vmsa_features &= ~SVM_SEV_FEAT_SECURE_TSC;
+		valid_vmsa_features &= ~SVM_SEV_FEAT_SNP_ONLY_MASK;
 
 	if (data->vmsa_features & ~valid_vmsa_features)
 		return -EINVAL;
-- 
2.43.0

