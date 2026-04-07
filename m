Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50252351C09
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543622; cv=fail; b=Tni7UADVfr7etlCu579GMP94lBrhY4y3a3uH2AClJhE62N7aOCoqOcUY7phFrRMPpxZ6s6b1zGR93QIvYmLCO7vc9ZW29Aq+7EOa91WP1k3mar1Vx7PvoJ60/CW3Ryyn7uhL93plJdMJo1I/tzE111mlpJ2b8E6O5V+PVY8QyuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543622; c=relaxed/simple;
	bh=VJGHIasMWkcR5JxVtYWOki7znoz1Iv+vSRZ8MktYRHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBMTXFJDib+ymXXM17KgdvBRcp+nwM1IdVR273yBSYDSa/5ti/H9Y6ZU+Fikth9TBSBlHzEuyhqzN2UgLUezCtkds3+pCHTWFn3oA/MNuBeK1YyblhsH6YAVjzpkRxEkYHDaY0EdzfD4aXAY1cj6l/liCf9OEL3O0BC5lFGRScU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4X3MM0mx; arc=fail smtp.client-ip=40.93.194.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4X3MM0mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNtov/WKCeFxF873s5E1oVvxT38uIcofgxz+CInlyHKEI6ZIiWIHRO/yrABgwtI3W8uk5dhsq3GT5fm65JPlQb2ULC+j9Pt/JERo31GUU2kGV4o4xzQjuNrLrZiiQbqkqDX79mZMmhSMkPIyTn8UNmv4TiBGKBBuaMj3Jrl7mXpz1WAaoeIMZgoJZGKnLL9YPhkilFh8UmUnVIgBohS21S9LA/6bFUOWo9IfOfIEWBILWFc977mTwmUsycWjPpAserVMNexKz4KPHUFu0zicKFl+GSwIDcKozdgPzPpPxHpbcQlYzGNMj3thTmW3fyzoC1l5hNiXS3iWnK0kK9+9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrSjx498qqzxEwMUQBYFfApvrTzLlTg+KXvqeYIKEq8=;
 b=DgCHk/vmaia1aDED03WNIfRT4rGo0DGf+DCEm6M+psC8UL33kr32N1CeXp4sjyZ/xK/kcvS360cSZpukAQ0DKk8JnaP1YjjJO/vzcuSxqVu01oST98jrZsgAmqKPN2zpw+Dp1yxPK7COXepBYLCJlTQr5I80SfA6uaFqC81HPvQuQUjBFqO6siF26/mRY8HryaEQ1aU+e6Vy7gshwJpwgwxhGHKwM0PKjzPsBPXvGjRoPWKC97FSu9245JqkGfCWErRO9yM5Hd2sqQ3E2CSjruDSBVGqOjFZUoFn+wevpUThDDI18WST07jh29GqYb10CcqXzXmj5uedUWMVHZXkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrSjx498qqzxEwMUQBYFfApvrTzLlTg+KXvqeYIKEq8=;
 b=4X3MM0mxt8QEFXyz+iOlwFjpQAw8BktO1KFrIXB7ZkODNvyPk6SN63f7lPYGvW3IsNyharHISPKyhIDKqepuAzaCN0aS9+3M2hp/r8IK2DjDMLOaimB0+49t4Ta5Ahs8RTebaCtQhStXxObHBspu+DYk5un2SJQ0zoCIMzalaW0=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 06:33:35 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::6b) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:35 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:31 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>
Subject: [PATCH v6 6/7] KVM: nSVM: Add helpers to temporarily switch to vmcb01
Date: Tue, 7 Apr 2026 06:32:44 +0000
Message-ID: <20260407063245.2755579-7-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dd4106-1f19-47c1-a832-08de946f9866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qTXmT/a0kgLmtrLBU40P6nK3TSW2E9xVM4BHMmb7zrJmPHG8GFiaASGFIorbpZVTJhUmjZG7zZNcV7QAAjKqxGp+A4J5sF0EGoZDmz+H8DUjtg7AFG0n/bh/4gnqhzMRR5oCONFLW6yFpo0pYWci+w2gChPlTbSeqdtoYIteZlkSS2YOz2upiZd9cLcju+G96U/1JFYhxpbVT92vN/WzzC3hCbb830XwI9pTjvs2L5tju4IQ2Qlfgat8EBGBf1GQBkEuyxwRfzBzDrj/dXm416asF7qCsaXPXIYBOPvWZM1HVB7c6L6V8OymiuXXMoEFG9W3BNgZYM/Ni/QBKHBlmGywvpieuYVe7K9uKKHV4bQS3EAYPUG0MPVcDUpcyYM9LCaEoImycrtvAgIEOcRnu5tK6xl0lR6OYV+1gfmz8eXGC11SSjAeiWjzEtEAS5U2n6QKB6k2TeCABh/Q6s+Th6mqZfXuBJBIh8FiXbavaM8r7kj/MKa1aoUnyb6sRLA9zzPG65qC3qC8gf8/2WzWPVz2EWDFQVVFvFx8/SKkNIYYAXxDh6nnzdy+tc/nSWo/O8qtuLmzpTyMnLOgUjE+LeyQukB4mliNbHYTCS2q2Mpj2BSSXjRLbR5CNPdqMWW4XVCpiFlE44BzPCzK2f93KlVI8QkLHyFK69IFN/6YraTj0tTYB1PFwsH3IRh/MayqWM3dBDJUAkMgL/+06Y26gFxdRtVTGxZsugIjOIoy+fUJhgvknCz3DmlzM3ck22StDNFujbdcTo5fjdhHFHJCpw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gvK5wuaN8jY/rNg5zM79yOgxZ/jctWGYpmLwKJQPCmh+hrh4hq3EiOP+EtnCK1uXdOYkPEhLA49/Otoll6VcHaCK5uui3A238aJU7uempkO7bIbvOxhMssrEWz7ryibaaNbHMSrSp5QQ5mYp+hF6e2hCJFAym8T7fa+wtbbVaCuX6XkjKH/9T3UaosvAmhXaGMHmNz+xFzlWelH1XZRIGtCyLX7BZ00WLNzTkh12C7oe8bGUjOq9qVUBlfP30IxXwKg367H43p+EU0x+/TULl/umfOzFNVb9liNmH+yegZZm7TMi71E2lyIYi1vYgkpiANmszcpLq5dmGzm6+Of37Q4eXQWF/hdE99h85xwbuJzZ3IQlW70n2tQgmRT/DWIlxhz+p/ZMSrL7MPEtFpG438NTdImvJHynmgV5BVK6DGR2x/gtKtdOxrvVRKzgdpXi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:35.1233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dd4106-1f19-47c1-a832-08de946f9866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

If KVM needs to update controls that belong in vmcb01 while L2 is active,
it must switch to vmcb01 and update immediately instead of deferring until
the next nested VM-Exit. Deferring updates creates ordering and state
consistency problems, e.g. KVM thinks a control is enabled while vmcb01
still has stale state.

Add helpers to temporarily switch to vmcb01 to ensure updates happen
on-demand.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/svm/svm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6477affac9a..32b002f92528 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1251,6 +1251,30 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
 	svm->vmcb = target_vmcb->ptr;
 }
 
+static void svm_load_vmcb01(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!is_guest_mode(vcpu)) {
+		WARN_ON_ONCE(svm->vmcb != svm->vmcb01.ptr);
+		return;
+	}
+
+	WARN_ON_ONCE(svm->vmcb != svm->nested.vmcb02.ptr);
+	svm_switch_vmcb(svm, &svm->vmcb01);
+}
+
+static void svm_put_vmcb01(struct kvm_vcpu *vcpu)
+{
+	if (!is_guest_mode(vcpu))
+		return;
+
+	svm_switch_vmcb(to_svm(vcpu), &to_svm(vcpu)->nested.vmcb02);
+}
+
+DEFINE_GUARD(svm_vmcb01, struct kvm_vcpu *,
+	     svm_load_vmcb01(_T), svm_put_vmcb01(_T))
+
 static int svm_vcpu_precreate(struct kvm *kvm)
 {
 	return avic_alloc_physical_id_table(kvm);
-- 
2.48.1

