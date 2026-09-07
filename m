Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2E403EB9
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763191; cv=fail; b=p5PB7rZqT70n6uh4pV/moLexfh3P2jJVB1CWboO1DSxqQVs7bf4co77Nl+haMOy3dZTXLyxkXcnMv4Bph1SWSPCW/0luIxzjjsAjIOQf87nsbRf5MKnD9mxozhYvwiFJEqCrzywmwNGqdyk3SZuzEUfhgFxzDV/+nHN1+7D8KVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763191; c=relaxed/simple;
	bh=r02ykoALAr6B4EKp0tVx6PnaXo+pA9q44osyR8uwoXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ju7/moW8cFxAtMgAAr8nRQoFg5scewEJdxEcmS+hP9FdDQhAWytdIo0GlzP/mkv6v1U91T6qpv2AUKG1lUzzjfcE+7vGK4xrNXR8tLrVb5aDrgo32Yvzh2WSXg9Lxu/vGGRqKI+vovbJkXjWB+vdmlwMfcYb9+263iQBWLE2KnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7LyL6ER; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7LyL6ER"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erZhiN+MSbyKOp1JskMGNlMYrI+2jTpamdHz/OGWymj5v4PutnQdnbUGjzp8ZITA0KxfEsWGKTv61KfiA2jzfax45GYJ7CDc50KYyO6WjL3rbLgwGUUl07I2zd5cjv6LWowVtvuiOw/LwpTSbG0WL8oKPziX8hc8vFB5A0g+QHsDszQK3uAZJViOfYgEtKJXdEx5WNveFS4SP6qm7xntknajOejoZiA0zMl3qaJiRzwT3Q9rU9E+dVnVvJUCqN/gfzkKwMIzv38d4qG98W/uKH3NxDS5FWBbG7CUMbFrsnih/Uxqm+vTiBdNzXkOjnb35xvHCR4hboP7NWs8u56/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nhR86Ti296mjRaKn0KrRAt143G+8Yxzb1iKEPbf364=;
 b=df200PzDFlyKFHmQA0DruczGy4tFjvcIh1Eh0Vky9gJu6z8LND4t+e4KuSe0bDvZMTn+SNg4B5DjfmrMr1y1gLgWK4UQWCKUDElydf57zXAZQ1J9NY/k0p5Utt/9XO6RrnlJDZ59GtcKIbC3Wb1m8IsXuSVOSZ9DYODQbbYQIsxoz3o4wDAdVEIaDMs5XVxQDLtrY6eETefrMFIjchdN8YLDw9K+DBkFtHgvhCBl8MIvM5gK5ANdjomvMO4trWshrS0grVfBKjf58fcns9PnNx4L0jN+udi/lfieDRXU3EBdbCiK/Nyw3xIzdAHNpE9TwHYk4wIlLYFKgGNhN1zFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nhR86Ti296mjRaKn0KrRAt143G+8Yxzb1iKEPbf364=;
 b=g7LyL6ERtOSvqLhgIh/1YQeCd+ispnK751hjtA0v6DjBKxjiKYuGarbD9vliz1EoIuA74rQVSazXY/gCtu6kah6qln0nnHjE2cyUYrVdNXIfqpzKPz5ECXaQi/b0gC+X3VuwJ9tci8AV1aSWidfFiKE3ANGy7S7VLOVi+vHwmgo=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by LV2PR12MB707735.namprd12.prod.outlook.com (2603:10b6:408:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:47 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::86) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 06:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:46 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:43 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 7/8] KVM: SVM: Use BIT_ULL for 64-bit misc_ctl bit definitions
Date: Mon, 7 Sep 2026 06:39:05 +0000
Message-ID: <20260907063906.1964557-8-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907063906.1964557-1-nikunj@amd.com>
References: <20260907063906.1964557-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|LV2PR12MB707735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eaadc53-406e-44c2-59fe-08df0caacef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QUp5t5nLYzXbpmgjN3SY0yShCIztw/+Fh/55lWiR6M/Kkw3+ot8v8Gl8EDEq2WVk3UALbfgJSqjr+SGSgKU4Xk9iTC5fjRmyNkYEfGHOzHCnw0Zof7iY8g0do+is6By6buEfKFrVmo/8zFbrRAWnwVqdeV0unooc/zS4v5Q2+gh3S7pOGTSznE+QKUkCfrs6NT8jdJpDUMlBUjvUi9B+4Nij5hSpzifBIdx3GI1ZNbaBAIBbMXBGtaCSiNZjzIcQHYe/3TtdpotvkTi00OrKWV/Ye4ouXUOu6V6qwBygZIMOKdhZsAUKV7w53p+/lOyiWSMhHEMlgxtghV7nvYj66thUl0GNKfKODodBAA5bZPlk0yzxFnZD1nDhbVBPbtiJZjmRxzKzroQ2uWlRLSojEnie81yvyTX3gPOajiOoVg+9WFtKYEeKdX1SV4YBkbnCIIbwKkYccc2ixcDnkb6mR4Tcs9efOQJ9fIjkScvskL3J9X9KjWYpvgFDVrM3KZmu0PdOpLPwk+8B2621CdzOfkF22EuzpjZdk/7C56Tig2Samd71uIhwDfJOfhQnp1E4Z/87nZeOdksfHCDQ75NnEqXEYWfycPacKMb6v5RqLIt/xwGVYasRO6UxndysEWkogQtSTvVTMM3HDSM6lK9cMu1ds9I99bYzX2j8vR3JyoUiEg2xgIMcwpINFUdrLxitA1Qmwv4Ob8Si6rG/mEtCTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kokwm9aKmIM+Y2b6TXSCU9+0pV8TDt/O5Kr/4pVeN9FWJOY0lyxnQbo2LTH7KoeEb8GM9v4mPudTCmLyA89x/E8pyW9jypw73XCKJYhkynqxepR2EUvUU+krUMqTKl6UClyPx0iP1zJJz3f9x7XlKvhdGlOgmqSPvW/m77djwNaq9VT8vK4qpXbgwTdUReQ57l/wkTU+61tX4crEh3qgocFBvYHcKMyoBO4F/uPRry9AVnMChSNJrtBrzwDz+tE03XmhajaacN5aTtWUq6G2gU9n4QKmraH/DbTUSPIvCoxZRYOoxEPRnUaEf+bi7+BQ9onmEgzKeEr4hnVQjOM2p4SpMWOfvNa+EaxkjJLZdIKe0JK78VdlzYUuZY+ccRYvt5li4GG9QRNLK3081CAcONgVRMSbcvxB/hJu1zLF9n97ZzeBjJG56OLcup4jtA1K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:46.4786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaadc53-406e-44c2-59fe-08df0caacef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB707735

Replace BIT() with BIT_ULL() for SVM misc control bit definitions
since misc_ctl is a 64-bit field in the VMCB control area structure.

No functional change intended.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/svm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..f199c52709df 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -240,10 +240,10 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_IOIO_SIZE_MASK (7 << SVM_IOIO_SIZE_SHIFT)
 #define SVM_IOIO_ASIZE_MASK (7 << SVM_IOIO_ASIZE_SHIFT)
 
-#define SVM_MISC_ENABLE_NP		BIT(0)
-#define SVM_MISC_ENABLE_SEV		BIT(1)
-#define SVM_MISC_ENABLE_SEV_ES	BIT(2)
-#define SVM_MISC_ENABLE_GMET	BIT(3)
+#define SVM_MISC_ENABLE_NP		BIT_ULL(0)
+#define SVM_MISC_ENABLE_SEV		BIT_ULL(1)
+#define SVM_MISC_ENABLE_SEV_ES		BIT_ULL(2)
+#define SVM_MISC_ENABLE_GMET		BIT_ULL(3)
 
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
-- 
2.48.1

