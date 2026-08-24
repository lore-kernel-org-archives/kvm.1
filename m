Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20B423E9D
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577563; cv=fail; b=T+mFo1abQhqd8F/EP1U6mXLO9j91aFH+enaL+8XnlUYzLhoKjz4zge85C01F2+fxj9zYi6PndakkrtJNj8h0+Yg/b/nDiS9LEHLN0NCj3dXCSnNV817xGIVWSS9BEw8x9rke2r7svnctfMHm5fV4jAM1o6yuLqg/nIs14iiqK3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577563; c=relaxed/simple;
	bh=5WKGzXF60mYbgC5a4EicnIJd+ULJvynJcUOVTHlKI34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGaUNVCQaG8mQFRrrzp6Yj/RgC4LaomKDG/dX7XN9pF+AkYBroY8tXomRDeQDEW9Lh+EWnyDqYhsqh6olqvNQUMeW4z+9Ecjleq5J3ObJZpNgId4Fpk5Z6nSRXabCw3qj3X65feDAx/I1rQZawKTPu90RgK2UdA9AYtvGDDJYT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z0OedAKN; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z0OedAKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDBiSBDHWM1rR52bYdSlXEhj5AYSJH6SQorhPlxts26w+Svl+NFcJwzKBHixhU7zeK08UaIjW46Lzr9S+7Q5fVHf08FmLyDjEzEMvYFQ55On1rtDuzDhIec44khobqNlj7Olg07HLbzmcjidRIE9QyXIizHrB5pGN8D4cGCUJWou7yLmD2/2nQcOXfzn0IM/IvDOM9rDQobSvQ7s6flIEOotik/LBlDQaVQ06gl+FzJEh24UhaO+pNHDEYmpvqaTeSnfHi2CPKRa8cRZQsla5r5TFMEy2Iusok79vjcBZuofZQOm3JUAMMmEGIMlu4JvOO07YHGsQKpBIfKvJIKpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf2Vp2Y/xoPLo9SG9kOHUiJ42GiccEh94qhQkQ/oPI0=;
 b=w2E31XEjgEbA4kHQpBpxHa/TqQ+2XlY4PefFEhU5BCp4fO8btCDqNaHj3HL6sqGKcWTRJOpwO7bumpHJDJLEYzc++Fk2HsoSZLE2jINix4R1l4m1N14QcO458hONuYi7A/u6dAXrkRhU5+WSIJAB32mmTaY3h6IDj3N6lIDyFfB5LxqRKa0AvJyS8BuIeaAeYlXc81HTEldnaZc2ff4YRUrn0xzPh9KmJca9UY4KuEq0/g96aZFTGns2wEz4/eTd3f5aUUJafO22NOSPPVXOWMikQUAoWa7AYfZTo5n7ouaGQIVK44URHzFee7ZZuaMl2YnZl0UMmcRxjnCgByvwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf2Vp2Y/xoPLo9SG9kOHUiJ42GiccEh94qhQkQ/oPI0=;
 b=Z0OedAKN22VnJR9UV+cOdQxsD7JCsVyfAcD44gNI3Xdci8Q7zWPJaztkMW9AQ5sFHflLcsziaCHFIORlJpewrPjt0tflWUN0p9rgH9EpV8op0ra9o/cKhJAGrDHoAkYgaUi9Tlvvf0iaT1C2NafZwE0aqUWWGozdDXbVMwrY9O4=
Received: from SJ0PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:33f::20)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:19:09 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::80) by SJ0PR05CA0045.outlook.office365.com
 (2603:10b6:a03:33f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 13:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 13:19:08 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 08:19:03 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept
Date: Mon, 24 Aug 2026 13:18:24 +0000
Message-ID: <20260824131824.6040-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: e9872827-6656-45ae-56dd-08df01e2478a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	NsZ0GiWp4RKqEohrS5Q91W9CsCavs29mN1s9yb+AeS2Bc4MF3whf2tIUfMVOnTJQrQk/hzflso1EupweHp925lm8ChQV1NyBwLzeW6Oe3oHuMR9FjHSoXIGcIgQcqQUdyDjD/m0zoCnBU7is/9k3vTpiS4yM1l9rJkuthB7q6K4O8NeBoyoCrugrybaSCeBEraZkxl0FRqSqRGLX9DSnZniofzx3letiaT/o7a7yRMvtwvpozU49dB7quvHrh9TUWThzx/gTRAb0yaIJ80J+vDseTrh3LPwqQ5NZfsKkJK3XDs+aXOmql/FOkNytbI6HpGhV3mzgAukGQUoQHAioTLi+UvdyXxhLWKmn+FYtKGwAKMhzUDaDkx/ljorwhfVm+C9xcDMDh8zfTrT5HHVJXkSrrbU3hpkrafPiiiwBGDIap3aS4UXjjOiqwvLfUs3ABHdKepsE8TXLqIS1lfaUZoCyXWATNPqWgpgjZE/FEYZUYpkTELUXW7NBpZA2sHxe/0X5nn5ZI0rXcIucpH/dVy9tBeukmsma1LhD3qD+Wu3nuY+i/hWEMEWDzAgYX6vVk1gWFDlkWQURTRUL0ttI/JS6Sj9bbMIQ5wp4sajBvKw3v9YGGEfSgH54IEjJLZB/dBWhis1Ml1Z9kDNMe+rPAcOIC+y13SuDm9rUZ9lti41SqCucAlX+QpMg1I1fe3RMzVkmMtstiK1O/oSATmrW3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FLxMc6/WJQwNSLbFwboY/2/ZFnKLjPK676hgxYbP8fZKg7bRMjJiDhXR7gwHdyovADRuHKdg5WKsYHRK5ODcwM/MLacTn6XULq5YnaxvgBY4tPYrDWAE/8do01S/l9a6/U0zfeSOsdgxSMtpq9LDIv4vpT5vtBqmaSjZkBu0X4rcKYf4/FKXe2lfaKerlN2GR6r3z2Xjc1sri/TrbtBfiUfhZAIQJKHXYl+mRTKGlWJNcbI9nKgfAb2khRJAg9/QAMdZqVRymof/MnsUjrNKpHTrZBm01zpccfDdnCnQF+vhphzQnXSae7r0ngv8jf1QB2Nia/4N2TLcR5Am6XyjNyYsGZApwem6nVws4Pif9OQt6od8YILvvlUG4c6CyhVdF8JCyHc9KODj3sKuLuaeQGuGNC0EGg+NmWEmeJjcvZHvoq5X8LNngaMrQTX+w3BF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:19:08.3118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9872827-6656-45ae-56dd-08df01e2478a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

The AMD APM previously stated that after an intercepted shutdown, the
entire VMCB state is undefined. In practice, only the save area is
undefined and most of the control area remains valid. Revision 3.45 of
the APM now makes this explicit:

  "After an intercepted shutdown, the VMCB control area is valid (with
   the exception of offsets 60h, 61h, and 68h) and the VMCB state save
   area is undefined."

KVM zeroes the entire VMCB before INITing the vCPU based on the old
wording, discarding control area state that hardware preserves.

Clear only the save area and the three undefined control area fields
(int_ctl[15:0] and int_state) in line with the updated APM.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/kvm/svm/svm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9d607b98bd06..cb5e04fd518f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2164,18 +2164,23 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 
 
 	/*
-	 * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU to put
-	 * the VMCB in a known good state.  Unfortuately, KVM doesn't have
-	 * KVM_MP_STATE_SHUTDOWN and can't add it without potentially breaking
-	 * userspace.  At a platform view, INIT is acceptable behavior as
-	 * there exist bare metal platforms that automatically INIT the CPU
-	 * in response to shutdown.
+	 * The VMCB save area is undefined after a SHUTDOWN intercept, as are
+	 * control area offsets 60h, 61h, and 68h (int_ctl[15:0] and int_state).
+	 * INIT the vCPU to put the VMCB in a known good state.  Unfortuately,
+	 * KVM doesn't have KVM_MP_STATE_SHUTDOWN and can't add it without
+	 * potentially breaking userspace.  At a platform view, INIT is
+	 * acceptable behavior as there exist bare metal platforms that
+	 * automatically INIT the CPU in response to shutdown.
 	 *
 	 * The VM save area for SEV-ES guests has already been encrypted so it
 	 * cannot be reinitialized, i.e. synthesizing INIT is futile.
 	 */
 	if (!is_sev_es_guest(vcpu)) {
-		clear_page(svm->vmcb);
+		struct vmcb_control_area *control = &svm->vmcb->control;
+
+		memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
+		control->int_ctl &= ~GENMASK(15, 0);
+		control->int_state = 0;
 #ifdef CONFIG_KVM_SMM
 		if (is_smm(vcpu))
 			kvm_smm_changed(vcpu, false);

base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.43.0

