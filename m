Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382493002D8
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922861; cv=fail; b=YmeXQaSpWbCRtGfzp/z0qtFiOB7gIRwasV431Tj7byY7JIx9yclsYuQO/j3xdQQ8BlKppQ869RWhVVax5IPlfMBt1pXfe58c0NXQY351qyD9tz5owqKzimQTMSkGBluU9H1l/BIC+UBjXGNjfbkczL1XUZIdgfD73Bn7fWJ9EzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922861; c=relaxed/simple;
	bh=9/AXaQuQiXdwCino39U0w/gVHYyFDSWIdWZbgN1aHqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7+atMu9cpIQPT9SEx3y8eIwSytZr3WGX82O5sdIjt+w9TiCqUXy/lSfu00L9xUAkexmEL1PU1lql++C8hQWD+5N55bQu9C5FSgaI1ZBW5ovKGH6LJgr7KHGGIwUmg3Nlj9U5mWgAlYEYO63Nl9S2ienGzIl+aGp0BRgKPKPtPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QYrmgdr9; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QYrmgdr9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzGbCNkYnWu3loNvqFUZYIdwfnmHuEwlnu8Gurl9bGhGDLqHQaEdmlwq/BWp33DlnjrunFz6bwtSkcCTtWuj1+SI06RDZ2lVUe8JHOzWrOCOVIWf3Of118y0R1qKVFgzdsIT+1z+LH9hxh3hRH9Zj6lVPJBtaiM2hpIEgctEluRsvNs7wUx7MubtsvKO9mxvznQM2ZiNtbetlryBIQ4FRMwmBpkSy5VTcmRfVwIq27wT6O90wdFst92f2cKoj/hhuMUBFV/x2Sc38sIgcAbcrfVrrq4W1R4ccTFXHv/F+wRrSCafuwg169QHAr4wkm5I27s20a2ggnpDch7uWzOplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixl6XQpWfXxmaPvbte3qtYS+XnG271JLTdEk6um7Qoo=;
 b=D1wdcc/HvRCcxZZhkCnO4boubBwgkAijXhG6QKf4FT2T0N021aT2Hb2/0LjqzdMihjRUGFkr5Sq/3e6dSHzDxHqSNFPln8aCFMp1tSVnIkSgIJlhPI5LD+al4IL43zuzYaB2OB66Zx2w8qlIYkFbBctepy1h11cCn++2gggeVZ57PFaE/mzpcS7sHO3gLECWv/46g9JJ/lV6wFHmX9dmIqIteq8pQpDcL95VHPIRS0wX+vQT7ApoGMG5TNchfDi20ZKa7FndJRnlDOkqZ/vvXGpoJaCpixWtxe6mXCRyWlUlEf578dt/ihfi4MwD+rMVK9ywkWm91Keo8+7JUAYgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixl6XQpWfXxmaPvbte3qtYS+XnG271JLTdEk6um7Qoo=;
 b=QYrmgdr9OUb+XI19eM29vg0D+UVvYqxexnjUiqnuIfQiDF0cr/9hx0y4PXm/pqzE9Rxq7Llzb22r031tvaPec83xq9sPiudyL3g/RQkfMQATRotyfa80HXqlMGxTdnLpSIQeXp3mJmNmELa24FUqvzj8iaSLNlIa/XKGWrRRWq4=
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 19:54:16 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::76) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 19:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:54:15 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:54:12 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 7/7] KVM: x86: Use SCATTERED_F() for PERFMON_V2
Date: Fri, 24 Jul 2026 19:50:40 +0000
Message-ID: <20260724195040.630468-8-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724195040.630468-1-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfa5935-32b8-420d-14aa-08dee9bd5789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KpACsrulG2AsNu6WTxohAuY6UzIRi0nuXIRTTnWOIj+kTu69IUaxeg3dVYX/yVlQCKfetv9eRi1C1Z6hmXcvowNan2bnxwDcf6P0znj4g3hnlrVj240jFpRtto8LOQq9/titDcH5jInTi468bBR8dKZ+19OvqsYtpqyVub9F5unTq0o4nWYNpEy7cOXtdIHsWLphL8SIq3ASFX0CAgHYHgUaEaI7br9t0O9FuWsUjc45Nq3r1slVHyEWtW16teSNUnaHMgrdOI+5S3FNiu0UM52sC3G9kOkuD2Z7UoPUrHSncg5x81t7NTasMfVR7S1KmixkhWyv569sI3h2nIMR02bBxRyAsdtNTBC95Dldua1jK0QPjd9e+IFU5vcpjrFTz2kmfQWsIc9nd9JIGPTvKu+rMULCMOAQV8I0ZGhEFnwM+YfiTXkYQUeaI2po1tzJHzoIMjB3L5mqEt+U6XvqCeMu7swRLTWJHFa9DN/QcwREr65WkIkM4UH7go/fuH4Zxc/DYgwEArxABsSmggG+pHcx/ide0NtdGWk1x82JOHQzWFx44uQ4CRlIpef1TWdv0zBhmO5mwi4qrzWTqEV68km+5bfD5sqYakZnSCjZsSK5Gi4nS/l2A5sCHSz2AK5btuamdufHieTUM95ndh5fTdgrubbnME4gzbLYM9ymGhv+9aPAFHReWCfnFC+HAPVkNaAcb4BYQy3Zcl8NP2ESxg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vPqlQaFLH9MXqdalurfy5dL1v/XOVAn11Onx2ueb9DtaejjM0XHCSbyUtbNDvQIK7zoombjMVd67xAj+0kECRgrGV55PWuJOvhRPRM7NF2FBeo5aPjsi7k9OXOZ9nX4bhB9tihfo7+CacHYou/hgPWHPLw4moO37ZoGGcKof5R9H1F45umD7g5RMYqynONlkI4iH3QHN7Ui1Zeu81xN/IeFczLgAuaJ0cxoGvOXTTaeGXuH4sAjuy03StQOikNmM40MXZ8MzhgcJrkuRiubocAdDTr3BV/vy8ZMME0SQPrQiWKpdzSrATEuc8IXJVzKDyGJ3U4IcvMbxCArHaczRgaUGahm1aAXRWHvXZIWv/skR0qhxKEiUruKCW3bfkZ6W09PvtPZlSxzZBqOZIKdMT4SwIZZZAbv7GpfPqJaWRlfemhWWrH6ruy68kIoKqFRc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:54:15.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfa5935-32b8-420d-14aa-08dee9bd5789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078

PERFMON_V2 is a scattered feature, so enumerate it with SCATTERED_F()
instead of F(). No functional change intended.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 03501b3145eb..51b691f91442 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1266,7 +1266,7 @@ void kvm_initialize_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
-		F(PERFMON_V2),
+		SCATTERED_F(PERFMON_V2),
 		SCATTERED_F(AMD_LBR_V2),
 		SCATTERED_F(AMD_LBR_PMC_FREEZE),
 	);
-- 
2.43.0

