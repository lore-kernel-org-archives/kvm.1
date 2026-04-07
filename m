Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF501264A65
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543617; cv=fail; b=j5DGcQftsjUoM8tc0B777uMixy1UVDFIX+qWYq8T2vKkUpve/83nxXyQ/oC7CF23AGs/DdpJmPBrvQZwCaVvmcbG79wwHf0cCtYLawemSLovqGFb9xOB1HcXtf5j9ox0m8+j50rmn2fA2WOyVvDn2E1fBTtRDALFLvC5GjLbpqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543617; c=relaxed/simple;
	bh=WB08PVU8ikC/Hg1Sxhq7Tav97RDEoENl+q7Smkd/kLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSCPevTjTRwDZyRaSJz4Dii1tX3Ss3FsyyYXyyXMzL8cQc11f6mbithtK/HcWiYK1OxAQ2VbBCYA7AnIPIXmHps0kT13MDKoQ4ywaLIbtH9T9pjCkntSpioakNsHUGKDN3AcFTKGdyO6B7RRP9xMzUPK/uX8n49EL3PCOAE8K6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JyVeMMsU; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JyVeMMsU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCGmFJRFingjrKUJIMps2gBG/yW4dLnxSTPgs0cNKX8aROnYTZzYgY3gLUlX8fkCfk+SArKw14fmeGf7XTlGQRjEWJub973TlZ4EWLotGddBTLlN6rn4Q64XyOIXLZeNBo2nEr1rVH2NkPBUDQa60qABedTfR380cSFyVXXGRPo1bMnkzIMAHSQgic0gye3uDU7GfIeJ7apkmxcTGYnzMo7j6JnD5sv/iN/y2YhzS7K6nyoCqPDHcQMYbBO3/85XFaaroIl9I6nATuJ49w3zH0665sE2dOvoG2U0N8ctY/Tbh5EnH4aGvURl9MBiWb1KjPaK/2O/cYkmv2lOE10A7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfWsdvF+HRxi7pPbwxo5K7iayXoIBkshG7Inf+8lggo=;
 b=dmsiPWeoVR/m1A5liDZHTdz69kgDWv9zMPFpSxxbGZGHFg7kB5PjHovxxAdwRg4l/IP6wPphUwZDC4GWeaPLDyFLBSqe3sHnvz3SIFEd7bXRHuB/Xs191qk1wGNcf2z2HADH+yprRhSjXYijN7km/J4dxBdkURhDtlzx5zYtK+VYi+anaAHxNXlvNQTH2Pi5m6B/DgyW0iywT3OBXOFt+xYyMZ6ZYryexRn0fVXke7ErlVZVMu75d6gIB5c0luvnva5WAusv4CicQdrIk5h6NVofhe6K+0Dnq7nEa7hhJy7JOYqrgH12rAdpeSPCQqWRd+kJq64o4YUbeAz2IuxHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfWsdvF+HRxi7pPbwxo5K7iayXoIBkshG7Inf+8lggo=;
 b=JyVeMMsU98dFADrV8Ke4qOg4+2mR0WZt7vKCp3Z6og4t+1pEvXrP1kxtcVNNDt6cL98tSaVwqvN2E/yV0Ay3E0lUCkCdl38BaYbwpPMt9TNjr5jlm9LF42daxrV/8GRrYi2b1JScjg5tkfTf7FhAT1LSuVt4T6dIwjo/dUr+KUA=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 06:33:32 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::ed) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:32 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:29 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>
Subject: [PATCH v6 5/7] KVM: SVM: Use BIT_ULL for 64-bit nested_ctl bit definitions
Date: Tue, 7 Apr 2026 06:32:43 +0000
Message-ID: <20260407063245.2755579-6-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c15996-cef6-48f3-8a56-08de946f96b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0jI7A/HhLDP6JJpzNsxwVeBxySucSldx52Uz4YqV3n2rx1933AJglBf9UaHd3uTGEqq/PcWn4KbTLHV5vxvPemJOht97chxVYmBwhQoEotN/Vf4SKZTQwTmc8hGkR7AHqjh+Bc9drqwGtaRY/2IhvKCCKPHxjlfL/UnW7vXN2Wrp1jBhJeJGC83HnYF6gLUA24zz/0uJscp70oOdZxn0DmsFo9+F1dEwN0Lq7X0Wys5AJBFfZWhx4njLiRYgBcXCFx42oV/veVsj73zj9P7Kvo5Z2AtCDselsCPccxSsohJNeLsw+2VeVR+ffl7crN9sDrZXcSp+FzBMP5XLwNlANiz9R6aEPIC8C/9A3307eoLyFeMIEP6ciBFtbTj/I+u18L26096RNVPCZHUOMxX+aLDcRC1VBy1/pPRVzYaSj6vPasBpo4ClKLPiP8JFvQiNNpESSdV5pt2udeSA9X7tsmyP4x6ZhkxI77NEXqFvkPMg1yh67mr8DRsZf27sBGOkcbG5ghRBq6Z5EFyXN36GROhiagYcoqeNoIAE5LC7Hha2QQgQDIKueMNh1e3L2a34HzXw1Bi2lW6qqb+ubIHWMv9wh1s45DH4tDDUqk6NC9cVBWHl/Xsiz4EqrsWHWzQEzGrUfZEdov6nYSLs7DYfbHcMg2J43XmYZBxtCZoEp6q/5qJwCa+RyhGgYfaB7wNUtyLnwDBoT2T2S64B/b+4N7igdeU8NmrZYLgXn+4IeY5G0K6uCxASXIqVgq76ooHxnI3LIkWpFTBNL2GIDapKfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QpFXd1+x238rhVZQH64+QJ+84mHALo4MMdjctuKtAxMnk8y1UK35rwAglqKaOr8Yo4s/LVRQ/8iRKqxgnJVgBb/dQ5fGo/ZomCnmsE/aecSj6QT6tG4Sjjm422XfM7SX/zhDK6c4WjoC7rxXfPJ0iZcJnpEfKhkfTCVUXIqu0/LpUlFO586tyOQzIzTGQSdfdyOoGYjCRzqk3jE5+qBhuRi3SNMzQiOerq0IGzs3QtBuKA7R+zxTw1blTufE7UtwD6Sp8yyT/Gd3OWbcts4klI6hQjbvKOluXZpKnJDiHHv5k6Yk8j3fGGO78ophLXI3Axt6dcyhYIhGltaVuHCGEZbnXnYpNUGw93e0TpdPOcAOiHYcPpNpflVhNB810gX8qlC0xju+Maei/efxrWxYs9LrQ/9pJFvxzudRHpKqfgVRU3yCe5pg+SqH324r2aU2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:32.2513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c15996-cef6-48f3-8a56-08de946f96b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932

Replace BIT() with BIT_ULL() for SVM nested control bit definitions
since nested_ctl is a 64-bit field in the VMCB control area structure.

No functional change intended.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/svm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index edde36097ddc..8fe91a0651bc 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -239,9 +239,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_IOIO_SIZE_MASK (7 << SVM_IOIO_SIZE_SHIFT)
 #define SVM_IOIO_ASIZE_MASK (7 << SVM_IOIO_ASIZE_SHIFT)
 
-#define SVM_NESTED_CTL_NP_ENABLE	BIT(0)
-#define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
-#define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
+#define SVM_NESTED_CTL_NP_ENABLE	BIT_ULL(0)
+#define SVM_NESTED_CTL_SEV_ENABLE	BIT_ULL(1)
+#define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT_ULL(2)
 
 
 #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
-- 
2.48.1

