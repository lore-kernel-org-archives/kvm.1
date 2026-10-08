Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2D48F825;
	Thu,  8 Oct 2026 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453600; cv=fail; b=MqFfDOxTzMHAZdXl0iIz3P9/tGg7ghcSQv27sVm63bYtxu5VYNXm0o1T4hbE5X7aaYUylvL498as2TizVu4OwQocdYJQgJd+yu+xLn5+hdAp3Q9npk4mkxBse5xjQXdgFDnYV6BB6C1GtaBfpUaQJug68ICciYu6dd02plbyuOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453600; c=relaxed/simple;
	bh=axgRTAQOk96PfEwH7j1B2Zx4cLiqo/jTHxZQw9m7yJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KF+ftLkNZld6wi1m3vqpOncTatUwEzKNMwfXvj3n1pkSwyU9ILtqub/9ylLQFwxczQvTks1pbJuyD5vzkQNdDnVYkSsn9qVQX8dP8+iuFxKPu7G2QVrn/S4xw8VyhillRyZ0KciNopFiWsxWksP/sGY2t0+efYurHmohelgEbS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h3lQnUli; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h3lQnUli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTgwK1ig4BMLFi8bXzV/0uN7xX+pQbU4ZMEVviWpdOxbIAKC5bpyWMX0gRCO3+ez4qIwpu6VmtgXe+2ytxgmUCDhFae9cldtxE3pBcPWAxKvYYehsVbSFVdBUA7UT0t4jAOWujEZFjaAwwMPmx6RrIGibBo5Y/H/NE35h4XMaREs0vO6+4csKhUKUluy37jqTwWqxlCW0nTei2oBgIJic4q/tDXvqoJltfftSt+nduvWSgor2mpDKVObJZ4Ac5GAXSXDFqdNj+Or5BLn6iskbKpg0eEHlVllWA9Y2ng6t7brI5cyP1t1gfotIiqN1/WJnJUu0u7YlJ0/eEZRPbLODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoB9+8XVJHzGyCna6cDgDNU0VLG0oGZB/qwoVR0qCIg=;
 b=KJQGOpct3tWzp2SitSpGpNacjWf9p1myqarK4TRIqrv3m5Gu+jfrLUXvD2xZQm3XdyGltxq6oUkbq4r7dWQa9ZAP3zUHjRUvLZeGADM2548B/Qofq4ikXbLcTDYsSotkErkwxBMaYjtM+lgsqefN3Z1ukKBKenmgPli4VqWEYniNo9dhHC3nBGT1AFWBWjZptMF4wnuP1X/1nLPuftsJwPrPmyJwWTwh+obWyfOFjpiSwSca3ePT8j/ExKA2O5Ayio0+wQSIJfjp6TxDkQ6yKaNsL7yPpVIqeab2KLqcAq+fHA07gHq/g7JbJ+RLlkSbhqmZjaFqR4xyiDA4M6y0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoB9+8XVJHzGyCna6cDgDNU0VLG0oGZB/qwoVR0qCIg=;
 b=h3lQnUliaslh1x65zk+mb8vFtiMBvzqNOE+N6lxcNDF3Rr0a7PKitC1VNS9jel6zPnH7n4sHIpy84FCDf86WP+eBmt8CdBjAHv/Hj9UWR31ie5gWNmVSroQ8OAu+z0u7Kp+wHpVsGOLPHjU6jgHLvdBh8JhAkcp6aDv/sBq7bUk=
Received: from BN9PR03CA0153.namprd03.prod.outlook.com (2603:10b6:408:f4::8)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:59:54 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::37) by BN9PR03CA0153.outlook.office365.com
 (2603:10b6:408:f4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 09:59:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 09:59:53 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 04:59:46 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<nikunj.dadhania@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH] Documentation: KVM: x86: Update nested live migration status on AMD
Date: Thu, 8 Oct 2026 09:59:35 +0000
Message-ID: <20261008095935.1237325-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: b40dc215-ba48-42f0-ccbb-08df2522e682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rqx1QGT3npT+YAAfGvHe0F9GDYbjfSbRYcRlzk8VYSh4iS43MOieHjKRIZ8ZyNF4bqWXYZUVrvH/My3ac1vPPiU1TNgyIx2BLXhHWCNkn7Kbsp3FHq0qWM1jJ8RrOfRYMC1ZdMhUESPWJs7lxg22+CT10V20LdV36jAb6/Rps3zTgc01lbie3IkYxdyAMLk0dZ8qo0VpiN3cK9/oWdY6DkqS3SJGRCfAnRxJPyrfyeyytousdWbqdUuqR4aWOTA5zOtNEpvTHqRhUemcs2z6xmTj/x/wzwarrO2iYonKZsdHhlVaMN6+es+EqB374a6bq3eTJchq5EjoFSSnkzbA6lJHzhlYipH5ziNDqEtXj7R55VgCtUiXLpyuhS0v64pqmvKW+mAEfw0uzYqL9e6rf5qFIKNRU+91aWrfiqMNvfhupxuRUxKqSguBfDknUeRJ8mD7lwoI55yY326YETowiExihz9j2aKpmwFh+7/n2lPOIS47NO/A9lFY9xUBXQj2xRQb/4cX2eZTjG4g7Wj5/TFhDDG+xgKBN8LQebGzmtKKOiNeRBeO+d3xf50iYKHWANQW8UOJ8Z6mFeJyNOcr1YL4GzfQrVX3gGRhSNVyEeHekNiWsoJl4JFUYzoFEY+NqBudxezYcrFi48j9mTPC4feCn3U7+xy6X5Vz6GGqOBxc62j8bsjSodOwPrfMpKhQmFkJ4V7xfPkGLB0/p2nL1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J2A0hIy85GjcUR8afnD7haFfSjRA7wyrxfXcKR7iCAVFOiz2ksYc4JZJN3y12J+D0H4qpdbykFGEPODkHYwIuapUmCq1ROHVRjHZjIIQVrzgvi19l1wAK1E6d/d6btc9tKvyt07id2LeI3V7OTZBXVclLC/TExcsyoXq8WUU/NA4FYj1YvFFwZGug1/03XKxSDqQmdmL0CatFJhITej8gB+WvBDjJb2tTgVD2AJ3iw+uso7FEV342PGCImV4eSyqJHyVQ1qL6gBqa2e1NPoaxwzdXkCwzN3GitjaclpXXAHXbj5IFJqVJgNiiH81DLhRJX0iSVmivQ4/VPqkO6PcwJlg4l4YDeCQ4c/GpuU02reRiT7/wpeC/h92tURpI9LBeEIgLa2lopHiXzy/bWCTXkioJBtAzN0Q2emUCmgBTAMooHJSXWELHBfmJ3JeDemD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:59:53.5924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40dc215-ba48-42f0-ccbb-08df2522e682
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121

The "Live migration with nested KVM" section is stale for AMD systems
and needs an update.  Migrating an SVM L1 guest with a live L2 guest in
it works, and has been tested with Linux 7.2 and QEMU 11.1.0.  So,
replace the AMD-specific caveats accordingly.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 .../virt/kvm/x86/running-nested-guests.rst       | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/Documentation/virt/kvm/x86/running-nested-guests.rst b/Documentation/virt/kvm/x86/running-nested-guests.rst
index 87326413d5c7..e41a50816058 100644
--- a/Documentation/virt/kvm/x86/running-nested-guests.rst
+++ b/Documentation/virt/kvm/x86/running-nested-guests.rst
@@ -186,21 +186,11 @@ Live migration with nested KVM
 
 Migrating an L1 guest, with a  *live* nested guest in it, to another
 bare metal host, works as of Linux kernel 5.3 and QEMU 4.2.0 for
-Intel x86 systems, and even on older versions for s390x.
-
-On AMD systems, once an L1 guest has started an L2 guest, the L1 guest
-should no longer be migrated or saved (refer to QEMU documentation on
-"savevm"/"loadvm") until the L2 guest shuts down.  Attempting to migrate
-or save-and-load an L1 guest while an L2 guest is running will result in
-undefined behavior.  You might see a ``kernel BUG!`` entry in ``dmesg``, a
-kernel 'oops', or an outright kernel panic.  Such a migrated or loaded L1
-guest can no longer be considered stable or secure, and must be restarted.
-Migrating an L1 guest merely configured to support nesting, while not
-actually running L2 guests, is expected to function normally even on AMD
-systems but may fail once guests are started.
+Intel x86 systems, and even on older versions for s390x.  On AMD x86
+systems, it works with Linux kernel 7.2 and QEMU 11.1.0, or later.
 
 Migrating an L2 guest is always expected to succeed, so all the following
-scenarios should work even on AMD systems:
+scenarios should work:
 
 - Migrating a nested guest (L2) to another L1 guest on the *same* bare
   metal host.

base-commit: 6bd2905303c58679e303941b7d8ae8c074cd95ce
-- 
2.43.0

