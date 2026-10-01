Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD45226A0;
	Thu,  1 Oct 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867550; cv=fail; b=p7jfdCl+pMAhbQrx0OuLs1s6d3RIEGoC3HeqfPnYG3G11hYP7zBDWeKm3+j94XOTVzLfXx9vBkND9F8B9TG58lFGn7s+ClXUsHHmLBUAkd6Bbzr39k1nKO+aXrq7+GXDjlpusweSGdGZRKI4iAqvmQmP1iZjxFK/a1QMl3XMBXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867550; c=relaxed/simple;
	bh=RM9CMrwFKN0SLEm6EPHCVb66OGA3n5i0NSkGlCaRhGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdj1b3WZTVjmaggcsotzX7Vk1ZooAi6ZJIzTO8iEIylXhsq9giYVpQRwt2p0m12guVu738LH51xun6NDHOgC2hG3DaFNQXzP4Uw+EY9ZkyAp22zI8y66Ol1er0GlrR9vT6qi+f7MTNP45HVcsTddCdTRjgjp2gJ70K1zOhhF468=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G8BWNUCS; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G8BWNUCS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie9tBIoDDOnfBDK6U5DfcjBPIBUbrzu/jjy6Z964RKRdrm1UNZ0SnYfC1w76v+trgPfiLqAfu1R26PMUHxmBfcvqQYPgXCaaT9iCfbFets6qYWgwKn6tKiSRUGAERH82cGUK7/SaGWvGaQDTpmtTmy1wfVV1mlRyoaeLLkP9s0ebK9tfIxDECFYQa34U4zqLmhLemHljxWo5W6YpDVQye2nUrM1RvYGA1xjFRkYaxpNkze5DkcQJqdIY9E2FeMq5osr9vVAhU8wlhOoojFRtWDMh765BNRHvbkRnoEehNIEKq3hKx3onShGdIfTxX77demuSvInNnlJYlDqJx1cl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTkkiUWEtbDO8Dg+3qPV/A9cc5IRzQGk4aQ39xUNijM=;
 b=CeY5sXVmzTx851P7biukl6HWaEvtoYbFo+VW4AjlbNHf/Eo/8wAFlQKhCrFP7sNlQL7owcLLoHkOo64no4Sm15wSAc6/KwSCrh69eHPXmOcdjhr8f3xiPskklkRBe6D06/2O6lpTDd6oezxlFjgj1/rjqeRbFQ1LxWWXfBt78fVjK4QBEuhPfsqS8UYWBqx8D2RCgb3J2F+fuHpPNDgmNgp22sAORh6lNZMls0sD70a0NGI+WMCy1carkfhqI4aWIq2A3xZTxaYPCNNSGDAy1huE13gepgB4ecFvPFQnwCJwchlgeb/q/Mj6skh+ObocaWxXLCFL7m8qDcI/nSb85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTkkiUWEtbDO8Dg+3qPV/A9cc5IRzQGk4aQ39xUNijM=;
 b=G8BWNUCSSI1geNfsvj8oIexzvOZnVtb8ROHKMBOTc/zg4ZUlDx5XYk3+NfaDZvtTveejbXHyp+T6x4rgRlkFOF+K2tvRNMB0ZZsw8lz2Ht2vLtmABewynts1IgBTuiVR681MTRNXlSuztJ+ehmqqovAvA/haMZuzIb2nZEHMVs4=
Received: from BN9PR03CA0865.namprd03.prod.outlook.com (2603:10b6:408:13d::30)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 15:12:23 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::65) by BN9PR03CA0865.outlook.office365.com
 (2603:10b6:408:13d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:12:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:12:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:12:13 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <fenghuay@nvidia.com>,
	<kas@kernel.org>, <rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dapeng1.mi@linux.intel.com>, <elver@google.com>,
	<enelsonmoore@gmail.com>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <seanjc@google.com>, <ewanhai-oc@zhaoxin.com>,
	<binbin.wu@linux.intel.com>, <peterz@infradead.org>, <ashish.kalra@amd.com>,
	<superm1@kernel.org>, <chang.seok.bae@intel.com>,
	<prathyushi.nangia@amd.com>, <kim.phillips@amd.com>,
	<ackerleytng@google.com>, <elena.reshetova@intel.com>, <naveen@kernel.org>,
	<darwi@linutronix.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v6 10/18] fs/resctrl: Add support for hidden resource group files
Date: Thu, 1 Oct 2026 10:10:33 -0500
Message-ID: <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e5233e-104b-4e49-5710-08df1fce6593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|7416014|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	tfu4GzfSSW66OEdWQ8r4PkPQHJLdO4+qWkTeoUTwVI8wdFyJaFabs+KZByCBwxMtMzDMzn0Dm6NKMfKqz6rtlfAE+4NWoIFqw4vIZ8VpMSOkzdRq1t/OE5vDZBcEesqNFyixrD0BUjGmUwPEQiBLqhD+Xiqj6LF/sDBvkMgKrDE8CnBSyAcuTxn1Tw37Hr2GTzHk3VRhExLL/JYdxBkByx7s4n5WeSM8lqwBlHrHNDOB8jGyz8i3UMGfFUlguJUYkDVmRcV2VSgTT/JZo8IWeS6SqArQPnQaPXm7s3f6Xx4faX7cyimSmdnGf8MtDBku12SzS01PaqbHQZS50fJOzSVg8DdpA3ShuH/N6iEGwuAystHjLpYbI8KPdD/eutIpJSY3+YM/O9lT/gbtSoTbTTeH6wWBKIu07iTM1wPOg49+UkgYS+dp5p8F5reGDYBAuRSCHQzI0iZhEBs0PfXzawbFub9VlCMcE8OegkykYr1S4bQe9GM5i9Mf0jdCwPAlJ4n5OCcGTSbTDzkFavfaLT1Y+pTPCOp8pXc0hzDheqNOJDy7kQQ6vEGgfAnBn+THqDG7bFxPy/B/hacNjZ30HDG3FLAQG4inMN4HNwzIe1X62ZR48tJXMrlwo1f16FaVv+kR7grWvK5JQmbhKb4B9cYkr7mzq61xQuIq+Jse8+pesoTQElgLw2kPWfx3QMIQceUS5fBccHzIxcIoy+YsSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(7416014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mVAPXyWiRMQC/nYSUR6aW6dThGozTPE15fZJAo6o+K1V1/zCPUKQdtaoC2N09N3b539PhieADfMRWQLg4ZMO7rjd+FA9ehsoFTqIwW2ojlzV9gXPQlaAH05ZO7mm7G0C12u8Eg1j38/Uhpko8TpF9O5vK3XeJYt1MXp+mDEld93ib2+psbqNMa82PbBgC3NLzzx+P9+xJLA7rawFr97VOVlMoxfrO/x0lgd7lHCwzI/3I05We82Gr4B7KYeT6pEpco1FEZMG6L3SbkFYeOwgaPvKs5tSHDuPffpyDAyK/SFHDk/+U8enkpqec1EQOR++b15KnVFlhvgiIJ8KiFgT4QkWaF5bD9uJIko1FzgvgReVn2genMwzh3eNA1VzVEBYM2y2SZWdoqCoZg8dm/AEsGnOj4eRU8nDq2GneIZCyk58THiSZWhlkCGENSeQl/nE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:12:23.7329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e5233e-104b-4e49-5710-08df1fce6593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

Some per-group resctrl files are only meaningful once a resource group
has an active kernel mode association.

Creating them only at activation would complicate group setup and
teardown, while exposing them on every group would show empty files
with no clear purpose.

Add a hidden property to struct rftype to hide files at creation.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Removed resctrl_hidden_files_set_visible() from the patch.
    It will be separate patch.
    Re-wrote the changelog.

v5: New patch to add support for creating hidden files.
---
 fs/resctrl/internal.h | 2 ++
 fs/resctrl/rdtgroup.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 98f04a2a762b..986b9c942fb2 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -283,6 +283,7 @@ extern int max_name_width;
  * @kf_ops:	File operations
  * @flags:	File specific RFTYPE_FLAGS_* flags
  * @fflags:	File specific RFTYPE_* flags
+ * @hidden:	Hide file at creation; visibility may be restored later
  * @seq_show:	Show content of the file
  * @write:	Write to the file
  */
@@ -292,6 +293,7 @@ struct rftype {
 	const struct kernfs_ops	*kf_ops;
 	unsigned long		flags;
 	unsigned long		fflags;
+	bool			hidden;
 
 	int (*seq_show)(struct kernfs_open_file *of,
 			struct seq_file *sf, void *v);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index e82709d64a00..46b2cafd9411 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -308,6 +308,9 @@ static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
 		return ret;
 	}
 
+	if (rft->hidden)
+		kernfs_show(kn, false);
+
 	return 0;
 }
 
-- 
2.43.0

