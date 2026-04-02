Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B45247295;
	Thu,  2 Apr 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161579; cv=fail; b=Il8JkaHXknNOEubFVFsBBVBEDO/4PbIgBgK35ZPGPojsAz9HebKoHRQp4Fxbb/Kch0FpBPQMEbAFD8kR+Ezq1I9UU21nN1qL/UPZ8XOs3TPSSqJ+J1KbisOpcN0/N3McV9ysF2Ez/h4pm42Mx31gWNYlUoT+8JkB1HOw1nB1cNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161579; c=relaxed/simple;
	bh=DZTxomfENSPpBfOhLkqs+x/oKeWTwcltT792eqY3lfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j3xNOgFl/XSAsmWDbTMdGmQXo7nwFzDY6wjNMMivoFbOCoIBUCO7rmPEi0r9OGWQbcS6VmkWoOgLpcTqfCTT9kMUssCAnolvaAHUp+gs9szioNU62AeZP0lqvxtB4qyD9Cqo4rP1+NE+s4GmcTcz5+nP/LYlM2eTaIyVeIQb/zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yipze0SC; arc=fail smtp.client-ip=40.107.209.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yipze0SC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptp9I8R/3PgsdmCR0VJANhWO9psRJ/cZzGp2LOiCxwFTOfjbMjGEq9u9icrMUteof3A0W74Q/HOtq1zHeRx5jOYnAnh2OtdEtPbyIFBx9VTIpLZiefKCOPqPfvgMJGf2mjl68dDjdmuJjBLslahJ11HIZvr2jgyeNhfI6eb2fXU7iAXTuwEYaUE0ooSL9Rph2Rr9qxDxCwJKOjV3sHlDFBzTTpap8lb57d9GGv2oWqyS3+loESlzMR/vBrAz3qDglieyS/J8B3fNobhtJU0PPPSzyTMDCQO3kmL0KlJJ6KZkX7BWrKCC/9Wl5nVCqLxyHBTvKVsnYIy9nw0bi4L9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ/Qd0l943QZF29LXb3Nc7xySiFtp3BJ1ndnxIsKPo0=;
 b=sxYnJsVKr/uxcfE6I7q/ZCFTyS50gjEcuCmhKum3NRCDZWac775Xcdl/tv6JcP6/1nIr2tO+3ivVor+tGSvFphZZ6Xsxg52LsQ7Hev+TQAKGcBCCE6JiWUGTxMhy2oRJUpU6O8G1wYFkydgFiGeh9Om4JYZJodKasoqVLW/AAHBe7SG7I1Ze0Xe6+KIodQptcAknyfsBPYhDn18MXkaczc/g9es8gb6e0nnAdrvMAK2MGvRdpoBmZoNTErXOxxYJnkZSwxIbxrhmhUwHmloVGFfWSONpWl3CUHSc/lMcCXgR2of5+jhtOTG7N1vrt0CIyn6G/iv8yZ2Cwuh0G3SwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ/Qd0l943QZF29LXb3Nc7xySiFtp3BJ1ndnxIsKPo0=;
 b=Yipze0SCYEdyfoyeVlxJ7PaUu2OKruI/k+3WfNgnfF8rtTNamcesueIjXJ6Ac/7XnBpCO4/L2Q2f/e/IN7BRBsYcYVfOllP8QNDvTo6FTKQPKFAO1Qu3K9cdlQQ5Or6pN0Mdattwa8K/cL5i1MR0lutPzYcOnnRFOhuSgpyZ6+E=
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 20:26:13 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::43) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 20:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 20:26:13 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:26:12 -0500
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
Subject: [PATCH v3 0/6] KVM: SEV: Add support for IBPB-on-Entry and BTB Isolation
Date: Thu, 2 Apr 2026 15:25:52 -0500
Message-ID: <20260402202558.195005-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 55550131-5f48-430b-ad16-08de90f615ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FyspzHbxt3MYO7PMvrut+K2AAjHFm3qQBwCjDETXooKUBLYhTSLyJ9d2TBiaWYNVi9mhfOs6BT2PON033KiumAYTzMT8x/yX9CL/e10GZiO+mDkzfPrPuUbr5kq6+Pow8pWSm5rO9NZcTJiiFmArcyXe2lPkCx/3ZEyvb+NG831MytKfj+j7sQwZB7k/SgEdP+G+byG2hglXNJHg4W7tD7L5INlAfDuoSHQTbOH9aNK2V87oioGx4aV4jAosAsTuAxtR9RP728Hgm7MjPy3IUPHN16Ak/oyjnqO0+bsAQhsctwt6c/hjQcDsG0n+7PgvQgWsMJdrG1Xl2/55i92KwI64orlxueKSGY4vD8hoBpTPekJxqYvmTnqIg4gEX8sK6B62x5sB7SO/aik7f5loPmYCa/5ujeZJI2XE4+P+7HNHZuVp2YYkkVtWhKbNqlujPHwX8CR9VPNRQrodp/Uu8AYmNQcXNcC+zMe5Ua+4HnCcU9IaSy+205CesT6R6umwG5GAj6Knc5lh9EIaVeHK+0MxSbgYOhmHE3AbeCVfCGYcZXNai/wa74jLQaZOogwrDu0/Y/cqlf5NXsScJjhdJPciEE9rwSk0e5BVFgq+6x8CKp+NVctwdXweISq/bMwzxyopKxqISUpQrtClykiInCV/+9RVU/BA5GBjyXHFB8Zh57ASIl7fOHOzHpyoLBpWLSHm0wmiTpHJZo1/w76jy+ioTAAhhZgUfyrTgjcdqAokCgoR7GxljHBkYxuKgmp/jdokpRDypZeTrdB3QywXYPqIM6u9b4kIqB8NxgmJ+t4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FkpgBGXUgtTGpkx1GptQ4p9I+IMKc1U+F59SF4dq1PKVcc8FAnu/AaVhwMkxFi4E3qbxoYA0zr5Gk8iYGp1IOY+6JKgjbEmkB7Foe3nb7UAiozUyUCgyAHOXQUea5eGF1JyEwUjCpXKB9Yk7bcXgS0MjtlyG96ryyoilcL7kkxbA3cFLr29fv660IbDJ3XyoUvLakzdwTWFchHTRoObInyRFBTLJDv79B5HkP+Vq0KoKIvkuI+YZq1lQoc2ai6dmqNgBYhsT3aRcGhJzbTgN75jH2+h6i04o/9h5TXBU/4Ulm6PqG8cwC0LjYTP89NzXZ8hClYK64GihXH+YYzyCrRuVJ3Z1DP8wZDhFspMLnpJ5BlSon6CTBhFfceyDrASxaX+bk3DZ13ehK0q+2EUoyqhA0TRo+LCioV3F2qFEs8qCTiJPjbR/vQ0IeGFIQPET
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:26:13.6026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55550131-5f48-430b-ad16-08de90f615ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

IBPB-on-Entry and BTB Isolation are supplemental Spectre V2 mitigations
available to SNP guests.

Patch 1 fixes a longstanding bug where users weren't able
to force Automatic IBRS on SNP enabled machines using spectre_v2=eibrs.

Patch 2 fixes another longstanding bug where users couldn't
select legacy / toggling SPEC_CTRL[IBRS] on AMD systems.  Users of
the BTB Isolation feature may use IBRS to mitigate possible
performance degradation caused by BTB Isolation.

Patches 3 and 4 deal with a minor code refactoring as a result of
Sean's review of the v2 IBPB-on-Entry series.

Patch 5 adds support for IBPB-on-Entry.

Patch 6 adds support for BTB Isolation.

Based on current tip/master v7.0-rc6-423-g8726fc6dc93c
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

This v3 series now also available here:

https://github.com/AMDESE/linux/tree/btb-isol-latest

Advance qemu bits (to add feature on/off switches) available here:

https://github.com/AMDESE/qemu/tree/btb-isol-latest

Qemu bits will be posted upstream once kernel bits are merged.
They depend on Naveen Rao's "target/i386: SEV: Add support for
enabling VMSA SEV features":

https://lore.kernel.org/qemu-devel/cover.1761648149.git.naveen@kernel.org/

v3:
   - Merged IBPB-on-Entry and BTB Isolation into single patchseries
   - Addressed comments from Sean Christopherson, Pawan Gupta, kernel test robot
   - Simplified unnecessarily complicated logic in spectre_v2=eibrs-with-SNP fix
   - Reworded, rebased features on top of new SNP_ONLY_MASK etc. changes

v2:
[IBPB-on-Entry]
     - https://lore.kernel.org/kvm/20260203222405.4065706-1-kim.phillips@amd.com/
     - Change first patch's title (Nikunj)
     - Add reviews-by (Nikunj, Tom)
     - Change second patch's description to more generally explain what the patch does (Boris)
     - Add new, third patch renaming SNP_FEATURES_PRESENT->SNP_FEATURES_IMPL
[BTB Isolation]
     - https://lore.kernel.org/kvm/20260311130611.2201214-1-kim.phillips@amd.com/
     - Patch 1/3:
       - Address Dave Hansen's comment to adhere to using the IBRS_ENHANCED
         Intel feature flag also for AutoIBRS.

v1:
[IBPB-on-Entry] https://lore.kernel.org/kvm/20260126224205.1442196-1-kim.phillips@amd.com/
[BTB Isolation] https://lore.kernel.org/kvm/20260224180157.725159-1-kim.phillips@amd.com/

Kim Phillips (6):
  cpu/bugs: Allow forcing Automatic IBRS with SNP active using
    spectre_v2=eibrs
  cpu/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
  KVM: SEV: Disallow setting SNP-only features for non-SNP guests via a
    single mask
  KVM: SEV: Advertise SVM_SEV_FEAT_SNP_ACTIVE
  KVM: SEV: Add support for IBPB-on-Entry
  KVM: SEV: Add support for SNP BTB Isolation

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/svm.h         |  7 +++++++
 arch/x86/kernel/cpu/bugs.c         | 18 +++++++++++-------
 arch/x86/kernel/cpu/common.c       |  6 +-----
 arch/x86/kvm/svm/sev.c             | 18 +++++++++++++++---
 5 files changed, 35 insertions(+), 15 deletions(-)


base-commit: 8726fc6dc93c62232fa625c1c91b97e21fff02b6
-- 
2.43.0

