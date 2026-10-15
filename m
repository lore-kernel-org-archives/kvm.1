Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B5518136
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060805; cv=fail; b=KccHAV1+hM9PEtBLLjnikx85vZbFOGhBvNNIEtp/eiYL2ABaueAfzA8XeS75A6moxOas7ExbfzA5Z3bNjljVzipCCxtB6tkJd519BlTl4swZXZjc8vKgEAHGpgmFkK7Uc15lGamnFT6Q2gjF2/BK2E+xgRhyyKfPlZ/k5sSoBow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060805; c=relaxed/simple;
	bh=9HnXlr+jYiLPw3kVpdt2jJZGRr9NBtVJNI7VG6iOq7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUbaOhL3XFpqBAZsfQL1gSQx4KpSYz9fsybp9u3QbIguLlGyV8+mfuA+llaAz5JnCKl8QGkBpJziwps/slSljTMQ/8aT+5iO3h53iMCjh7Slo9jvzE50YzFiLeOvKBvVlHt8gycFNjl9r2XKLwIwgkzVOm38yAeF2mSjOxG0pVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X8u9xstW; arc=fail smtp.client-ip=40.107.209.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X8u9xstW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klVHYeFgmZK3rRp7ORpOLb9Eesbd/1RYiAnN3sS/l8otRlWJD/cOeTecXlkVM3TwQkpy5rtVhhk7pnYJDpFMAKi9vrDWvTCNm9phPF8cU3qZca6KDPebwEqFYUtUcPcNj9gjIzVKXccoWHdjJn+2DJMjmWgtEq3o/FWI3/VexPbDKUdbkqrZCwF3V0Bwkapa0g89sdLE9hdmLu/VnkRLVSwV7Qu1yo1ZikDJCoImT6wEY/gWeeqcgissFeB/KDkvWSOWYu4bCYDH9mr3cn8DTMo10xjzAsYnkywK4D6lLWSQcsxPu5p7qrUl1WmEa/GXLhdCeu4NbH+Q51SAzihQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2a887pYl4riinri2F7vS75Tl4fbrrimN7KJlKSD7MU=;
 b=usnu9TK64K0Q1icSCHiI+KP20H0NvRdBocIHKG+68Dh7tQV383Rs7ccILKyHj62hdlerkZBV2eG2UH/ucxe9Y3lXX/rPBEDm9oEaxSFYfwiQYyqHljR08NxyJhSogtMVZTZ1kTu81iiAdAMB2TWpjZtjSoFa/K/g0Rgnl8SHrs2i4cTbpvVSY87F5Y6XXc4fGBigQtnBblkWf4ASFY3vYxJN6xSDOQf6v1JNWu2xGvHK3YzQRPEP8xcPUxcOBUNnQePvxpINBTmHvZJ7BHa1l+oEJp6hITZuIOVS8p9Qm6IDf3sWlPOMggjhocVPNwrY49vJgbLw6qcMLhDDtl1FeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2a887pYl4riinri2F7vS75Tl4fbrrimN7KJlKSD7MU=;
 b=X8u9xstW5AbBAX27JbK9trGNQpZXQpeYyPe3faFDf3OkxkkbbqQjpOER4XLUoDIRVO2UWV+Mj3xtY0bUpIrpYVwguxBFNOYsp4Oxz+WCEWO6OWsMaHNDzbup8xwfhBA9EcxpaTa1tEN1zfy563sbBjw4CEup7wasUomY1eVX4Nk=
Received: from BN9PR03CA0918.namprd03.prod.outlook.com (2603:10b6:408:107::23)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:40:01 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::50) by BN9PR03CA0918.outlook.office365.com
 (2603:10b6:408:107::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 10:40:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 10:40:00 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 05:39:51 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <mlevitsk@redhat.com>,
	<joao.m.martins@oracle.com>, <nikunj@amd.com>, <kai.huang@intel.com>,
	<yosry@kernel.org>
Subject: [RFC PATCH 1/5] KVM: x86/mmu: Log dirty GPAs only for the nested GPA walk
Date: Thu, 15 Oct 2026 10:39:29 +0000
Message-ID: <20261015103933.2088307-2-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015103933.2088307-1-nikunj@amd.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: d166e774-b875-43ab-5d41-08df2aa8a9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2gv/S4cqUus+QmH96yk+uLXMN50TpD4RnrQYbq6QhW7Xk/2+UC31NTQfJakFwHhRsPV3cua4yMVBHUu2x4WOPl2X507w5ZQc49qCYBeV2gCEnKEjNftsPWS3rERGvAlB+EWxQXJ0Yw2tUC09uBeeF7ZkjfuR+47WBj242xYd5/qE0cmtv2ZcbHnm40IE2RPxIhIF61+iBnGEBQG4Ygt7QYgn3v05mgE8clzyqu5gtBR+cuXiEH282+uqYl6lSYr7DVPkYsg1wJeAghiJAueXn1hntUWpJWEz5qHJC1OvwKbGvXx0j1OTH3YQkbb479I18YzT0FGgh0ihICeuXwFCinrkk2CPP8s4pF0kbQslF2i629+6ooX7pFyaxoVcaSzHDUOm8QdDgcoECbIytQysMcJf525csMuZAFkosO5hj6UcGMUtRVIUpzIC/a1anDdQcF+vjbxO0I1QV5yNGw2zfcq25x/ETQYoMnl29OfohpiN2hVeYi2ZfXT1W62PJZHDTAJEsTZHGgGdHkwvvc/kdY2/YrsyeFCb8qvYfIWamATsa0U5QvkLDektPopPOzK64ijPpEuffuxh1OkS/llKQvZMxdQJThqqGvBkp9iph9JCGDu2Q537uhQzbFYN8gwSd6FpGOKhyJ8Q1olBM3LjWfEh2kSw59BuglEEULqlE2kx48+5/RZtG7y+OIxMjO/aKOA8nKn8nAr75gIqh/yXYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b4WPOWeKuJyDwXdi9tpCMY/0TKqWRVaM+7jmstYPznycUZdolw7wOJw+sO77dypIbST6p6X5CcW+yKxqQd828e7ef+iBAu1o8p/ZMz+BoAtiNxYTdjvisQeTopfPKdJWJ/nXWmkSsl1A9xKKIDkM9BylyPgzqVuFBo0L1tEqWRtBt8MbCv8N23jgFpLylpV+XoVn1f3AgBwvs9YogGhxVnaVZUZWHBnRJr7QAbTaLBpnTSoNjLDF3YhrCH/49MC+QcUUU/YZkYPGbuDihR40QK9XVD+5itXkpIB+ctHPmHac9Z2iEqCvxXW0oh6Pdk45KDGCN3aRgmrd1bKb4JPdnXMFFgA4301pWPPRFKkgdsKBNxTCRNJQnjitYC8mMW9Z+RtL/bfGnl8tUKWjSkk+z1jfAgkm7trpo6DUfP24anUEx1cGf20OitIDEhUe9uuQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:40:00.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d166e774-b875-43ab-5d41-08df2aa8a9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

Gate PML logging on the walk being the nested GPA walk, as only that walk
yields an L2 GPA.

No functional change intended, as the EPT template only backs the nested
GPA walk.  The upcoming nested SVM PML support runs this code for PTTYPE
64, which other walks reach too.

Assisted-by: LLM
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8e350095508c..043d0ec02b27 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -235,7 +235,9 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 				!(pte & PT_GUEST_DIRTY_MASK)) {
 			trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
 #if PTTYPE == PTTYPE_EPT
-			if (kvm_nested_call(write_log_dirty)(vcpu, addr))
+			/* Only the nested GPA walk yields an L2 GPA to log. */
+			if (w == &vcpu->arch.ngpa_walk &&
+			    kvm_nested_call(write_log_dirty)(vcpu, addr))
 				return -EINVAL;
 #endif
 			pte |= PT_GUEST_DIRTY_MASK;
-- 
2.48.1

