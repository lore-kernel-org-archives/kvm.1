Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6625B088
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097354; cv=fail; b=UuOnvcBREdaeWaCba0i2ZOHqNFsyrR1SxecV09BE+x6f77IH6JuIZB0O7+J1BAntSyuwDrfmf1BnB2TJBsRSHBjg0+ckFgz93M7cu4ctDZo3IP2Zj+IiTZv+LQwRJLzAbzkN2MmPG5+x+uvjITdsiQlOsrCvPzG8wmIp3TUVxC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097354; c=relaxed/simple;
	bh=rxZNkFhofRsHCPD/NhAJW+y79r4K+j33+r5CVeHv/Sw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOrfkVcIof4iiVnLgr/kedU2I2Kv/7GeawWzxhCU/ENFS4IvXZYjSX0NgdoP3pt5sgFcHDb5j5w7vw0Ck/EB17Tcyq1eKlEWQDxNVbL/weHsUXUb3wjxNODN4bYjsRjkwuQ+qbXpkTJGO4WPMApRJyEjf0oJ4p3ekgD0QVkHKQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iumqQnyd; arc=fail smtp.client-ip=52.101.57.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iumqQnyd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eeloq/GWVu1RNUcIzjnPfRe44jhrfNrZI+URCcnh8JoLesgIGS3s70vm3K5phaA7mvBJN1Jqd7q3ttOis1Y504akD3IjJqvnjPz8MF3ntd1ZQGc6M7Xez7T+Al/+m4omvg73pe18fznuEyhzp0E3FsTZz6yx0xBPkrfwO5L7bYke0BgSu1TvYhfBCnqsgcK735fmUwyeREOfwm6fEJqpM9cSlcOWOX///x1AMPeZVYFyQTLMhcMKUJ1aeQkWUmAwiYrypyDkWgt9EI0ClLHSuMDSNd3WahxXBINU79d8arrRRAr8V6lUwk32tyuWAd+j8vkwUQrwvx6sy8YuEwiWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8+hgVV3ycAB0Gjc35M/C1jFJsFr7hwXcQkaafAc4Xg=;
 b=l/ge6DlnYGExo4awlJLS1GdUFjuiZ2cGUSF6Uq8pLMjU9I9r8BwPSrf1aDhnqaYOOtL8xZO5p3T7bJRUqvwZgFjWhhJaOJPx7A/YBmYYRRnuB/fqXmLSfm9yUKGmsxb4au+URs2QB6GYa/Lks9nAJBqBgqTjlbd5wehuK+9BEVHdcTmTNW4881g8b0BqDjnUmMqUKhGabnzrjraOi/kHR0we5sxbpq1RbqVMRtN6GFz/ORFw7STK8H4yo3+Msry678Gdvcv/xId5fyo5aOl5Di+vkYJ/un8Y3BLUWWsxap6BxXBYYoOOpGKOJuoEC/3FF0VX5L9XrFCqS7DZDtRbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8+hgVV3ycAB0Gjc35M/C1jFJsFr7hwXcQkaafAc4Xg=;
 b=iumqQnydN6sRMO2ruR4pPi704rVor/cso82rUt9Wx3E1kGGy+4G6RlPLk+jXYJQIvJxEL72znvPsFBMKJDIB/3F0IgiUtGfLf6YWHhAbDEBYD1cDV+aq0OeuB7yF6TFZ32SFvO2ufpBjBEXvUpVhIPU2Q1GTt46vGh3cBeJvLSg=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 06:35:48 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::9a) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 06:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 06:35:48 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:35:45 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <yosry@kernel.org>, <naveen.rao@amd.com>, Nikunj A Dadhania
	<nikunj@amd.com>, Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>,
	Srikanth Aithal <Srikanth.Aithal@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] KVM: SVM: Bump asid_generation on CPU online to avoid ASID collision after hotplug
Date: Wed, 15 Jul 2026 06:35:06 +0000
Message-ID: <20260715063506.672432-1-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 745e9c8c-83dc-4642-06bc-08dee23b4eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|11063799006|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	sgZVsEh6tKBvp2XDaNGdSWvHzpZPgaWXGPdWHFVDpdcxw3XuKDf2cuni0Je5TZBXd3VHe3MVpNzqxqvjANt4qlOzsqeL0uJ+CeSEJ8HEUvMfmIcyjn9LodyR0eYmlQPLWs35J3aeF4KxrkNtKJtyZB5/Cyo3fuwDaq5/odEWdaK+I7VmMTTDR5tIrrEqjg9hNTxDOvWJdEq12RukNAR/2eCdTr49HmjNg4ta9C5KDz9oNJ1s4hOwRx5s4w1FUk6uCq33IGt612R1/H8cVsHQWS02qR7pHoq803dmvMPciIxkMMqaCL8F17gHxWUePNcEdBcqcf4Pdza+lVarYfzgpKOMQg11kvhJ5gvANjGAeQ3FHU+bNOTdzTPPecwu+bfn3bXWUbvHKu16cRBpBgB7T9OYG6WyLy5qzxiu3z21K+Kxsn/ThG7BK8qXMS/3MDmUMs8OZbZIoMukjrZNthQabWI1fiwEpzOmegugbjs0WMpl2vQd4IUUOPpucYhsJ9orBMVLOII0rO1bOhNzLv/Wain92TI8zPVqMG/4bI49zxqlwvIKSadhQcelL7bh1tyYfwceb819jlQZCU8VlzD5BSd0DY0dV05d9yYXa6E36PBA6Y6/d8it/b6hw1H1ls6uDRmmjRoy0JPbUdeCbzDLRwMlJJ738R52HEkuF6EqZJzMvc5N/wlXZ9C8pnoPqsS8VNIwerdy36/obDOoj28e0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(11063799006)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0zWViswvvJ+tfepWeIYIIcxBxXpExGnVzlaBHyHU6xVvzuJtYdBClKTlfm5vYKqBzA2orfX8lYToQmRk+YMSO1QDtoIJDT6xtfQgMLOAXvAJjK8UD2eGOjrJXcXx/PBCELbDZF86ZMKox3C3DKjhj4XLrj++bggKwG8g1aeAr2ng8fpnyvl+uNlYaSHxBxpFVUcxC6hz6210Jzw0SkQpQkHlhASpo4LW6SITbDQ4r+8hgNB5xFH0AamgfJsKw3uOzAebe9/wflDhAxvRHbt10AxW2q5wvWykj3lTl2gHcGVyzGSJXNZ8NBOMlCzQfhmf1ZrvtpJ3VQ12IRDzkJnKkG4io6/+NJVnvQRvcQ7NB1U/VtDCLn99lS4HpDqRHhNtC3NM5CztES/bq00PmXhqSOLw8XcZd0BZ7gBEgYjFmSD8cJSwe7O/ndPLzWWnd/E7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:35:48.3486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745e9c8c-83dc-4642-06bc-08dee23b4eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900

If a vCPU stays scheduled out (or blocked) while the last pCPU it ran
on goes through a hotplug cycle (online->offline->online), and the vCPU
then resumes execution on the same pCPU, then it is possible for it to
run with an ASID that has now been assigned to a different vCPU,
resulting in stale TLB translations being used.

svm_enable_virtualization_cpu() resets asid_generation to 1 and sets
next_asid to max_asid + 1 on every CPU online event, including hotplug
cycles.  Because next_asid starts beyond the pool boundary, the first
call to new_asid() after an online event always wraps the pool,
incrementing asid_generation to 2 and assigning ASIDs starting from
min_asid.

Consider two vCPUs from different VMs, vCPU-A pinned to CPU-X holding
asid_generation=2 and ASID=N from before the hotplug event:

  1. CPU-X goes offline and back online: asid_generation resets to 1,
     next_asid = max_asid + 1.

  2. One or more vCPUs migrate to CPU-X and call new_asid(), wrapping
     the pool and consuming ASIDs starting from min_asid.  Eventually
     vCPU-B from a different VM is assigned asid_generation=2, ASID=N
     — the same ASID that vCPU-A held before the hotplug.

  3. vCPU-A enters pre_svm_run() on CPU-X: current_vmcb->cpu is
     unchanged so the migration branch is skipped.  Its saved
     asid_generation=2 matches sd->asid_generation=2, so the generation
     check silently passes and vCPU-A continues running with ASID=N —
     the same ASID just freshly assigned to vCPU-B.

Both vCPUs from different VMs now run on CPU-X with the same ASID,
causing them to share NPT TLB entries and producing stale translations.

The collision manifests as a KVM internal error (Suberror: 1, emulation
failure).  The NPT page fault reports a faulting GPA far outside the
VM's physical memory range — a sign of stale TLB translations being
used.  KVM falls back to instruction emulation, which fails on
FPU/XSave instructions (XRSTOR, STMXCSR) that the emulator does not
implement.

Fix this by incrementing asid_generation instead of resetting it to 1
in svm_enable_virtualization_cpu().  On module load, asid_generation
starts at 0 (memset) and the increment produces 1, identical to the
old behaviour.  On subsequent hotplug cycles the generation advances
beyond any value a vCPU previously observed on this CPU, so the
generation check in pre_svm_run() reliably forces new_asid() on every
vCPU after every hotplug cycle.

Fixes: 774c47f1d78e ("[PATCH] KVM: cpu hotplug support")
Reported-by: Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>
Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/svm/svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 91286d46d13ad..c2c6487bd5bd1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -571,7 +571,12 @@ static int svm_enable_virtualization_cpu(void)
 		return r;
 
 	sd = per_cpu_ptr(&svm_data, me);
-	sd->asid_generation = 1;
+	/*
+	 * Bump the current asid_generation value to ensure any vCPU that
+	 * previously ran on this CPU sees a stale generation and is forced
+	 * to acquire a new ASID, preventing a latent ASID collision.
+	 */
+	sd->asid_generation++;
 	sd->max_asid = cpuid_ebx(SVM_CPUID_FUNC) - 1;
 	sd->next_asid = sd->max_asid + 1;
 	sd->min_asid = max_sev_asid + 1;
-- 
2.48.1

