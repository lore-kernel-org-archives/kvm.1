Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788D3D47C0
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901168; cv=fail; b=onm+NBg7tJPb1+vpy6e4azxqh9P+TMRSa6v2ljv/uiOousVpm/wwy9CXolGNxUKoTqz37iY5P6RxCiowJzHigE+K9T5M6icpCJfWt5D2DTn8AYksn5ad8ZlupRpi4pbHKC7jdVkOOGak092VUKubAIQc+OmpkpZm+lUl/Jtx1bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901168; c=relaxed/simple;
	bh=ribhAP2QSwloddeqcglYNxcNY2+a/TM77dQoowT4zFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzb8fvbmQ3TCGXghN7R2lDBqbDz24gGhL1W7p4BB7/YkHsiiXTb8AaP6a9hVcojdYTDbAYHU24KXyGBZrzMEwcn0IGNe5XdvJ9eyzjK8dkvA0kAcST1fIOuYQZCc0BQW2uX4gQR4u6aT4NvXYe56WPwr4n85keWW4MW3b0McUMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YHO3nCVs; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YHO3nCVs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DucgAek6GYmmOAlvq9IUCxApju+xHVHOrOwDQMQ/ihdCH0b8WntXhmjOlLO2MLE3mRDGr1+eCLb9KkrAm9seanLnqpcVm3Gs59swtRUgB7fLpRQ/yIjMmoW8VrPtddUB+ka7d1YxDKSICvjS0gE2Vb2O0oO+bqy/apTBVhLJdqX9dEPa28BIyzXo4peELx+MqZRizP7RGAbRgJZ2aKVIY/aLuZvIzNKhYpxI/frgwdOjA9YPIpc0F3DOZSgYB5ojg7upvSt9kBBiKN8OvgoXmFbmZhhcuCx4sO7jBeyZHhjy40/qJCA8ROpg8KUYnXTgi0G7SHYuO/lGeStpmlx9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlSu85XI3tQEstsSjY4QnuegcV971Zs1czDNebFmRdg=;
 b=hp407Ife74h5DP1tyvHYDn8Xfm4VetNnXknO4PH4zQB+ohTjZA/QcmLD9zoLKizksbKXTMFwqJfKcZuzV2gL73Xw9mHTRYmrJzDDsPMwFQylVn1xhcbjoSrn1oeYgkPrZX6ATo4py9Yox3dAhDTT/BY8pHNAzkLHawK0R5HTs9/ZY6yqlcOiz+Sj5BteGI5EgKc0HdxRuR8IpX9i9KMOfshEhGXyRD3md+88zUqm7iUcTRWNPm8WzbrXw1ZsiptCNDPqVMcys0MsmXpeVDBs9WnV4rVuzkvhY9bAU7x87uLJMwasa6TYHxRKhw42OykHWgChkecuhMnvClU14ayplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlSu85XI3tQEstsSjY4QnuegcV971Zs1czDNebFmRdg=;
 b=YHO3nCVs7h0O+7syMoj1AGxNDMcU5Uzdv6gRZXH8TmxsXCPtWEEdvILVJT2HPVkbma1+5rpWP+pYAnbGL4Kp/SUssj5aYspgvkrBQycGl+iSfCfY8NXWx+d5P/iHpyiyvby530klLiPWmRXOIiu2l3FBmk8ijOm4DKH7uVCcvjM=
Received: from DS7P220CA0099.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::18) by
 IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 20:59:20 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:8:25d:cafe::2e) by DS7P220CA0099.outlook.office365.com
 (2603:10b6:8:25d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:59:18 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:59:11 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 06/19] linux-headers: Update headers for v12 of in-place conversion kernel support
Date: Tue, 8 Sep 2026 15:48:26 -0500
Message-ID: <20260908205236.838281-7-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccd7109-dffe-49a0-7fe9-08df0dec0cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|23010399003|10067099003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	o1u8Re7bEIp8naVaSDJ9tRM414D5ENYOexLKjN3x2ORDv1EUbvtGl34ZV59gh6Q9zkxM6yyW34N8q11TZWo/uR8v1xorKBNXrw/p8V1dDK9SkljmR7uZb67QERUULDkefgCnbj1s/u7dmxbyUzn2pG/6tw2X0uxuGcc84PPPZ14KtvgmTQqobslQq2ioFRu2kqbNeWvBOkpnmjbRhbgxoD0tGOu8IMThwDpYXdl7r8cgJsZdTSQoDx6Wg9sOPn4uS23KaRJxgRUMNORkXmmlHoGSSXtxOMDhLEatAK+kMWoxBtpNKaoOUgovZuoMbU6qFgovvBk3T9auIyAqy9CM8qyYiZtDq3kqAAofvvv9OctmJkRTr4RbrDOD0Tpwnf7RsZZ3Ba1I9Cu1RbY3FqcwouccG0ILu67K3W9EB5XzSCy6NCkMuBQINcgYcfA46I3gcQoN/jiCz45Gyon/SshFEEGxQ0lisGke6QRp0kUHxGSFLSHfiduxgDmTnK60A2bAWaQOSNQF2ZCsEWDLc8amKRyBo90zKj+X77Un4nLphx/DtqC9Ga28SLcazp07Kf7aRiY887Gj8ugxjLCQ9snktJEyFi9LyCLb7/wGknOu1lUJxgbdleaLQSH9qGJcIE2yTStIUXw254BJDmJSRTJrk7Aq2glqXk2Jd+WiOQWp9L3pCrQ1ZX6K2Na9NWFwMXUAqRCRMZfwjLrdU89IaH5+sg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(23010399003)(10067099003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s790iD5dwNr05h+g9AhI08f8X0thJRdVdAjckGRiHwSPojQFPLCaDy3a9LaY2d2zQmj+fmOa2mumSJ7YeXzdK3JkCromSzsdfB3Tk2pPS0n0SrnGs0NJSpg4cf1TUsVUf7W09mETyH+ncNn0Y9d7VgM4zWqqgOc4e+lMDkDp6HbvkJRHXtPNGKFYLqyA5YFHFE8X3jukOrpCqPzvHvDAFUI5n5lQ3gZvjIP2CE8q+petxbRgy7rgiJOZHBDeS/pnKMLM5DBtZIwgpKRgFRPZJ53HYGsNyrwaUizh/bGgKynqJrjltqu3fJNA47+QvEY607IEr1N5rggplooG6jDkaF6kTO21uoroMYc/wOKFKd3eRmSjfdy9m2WAJ8OtHzZiGtJr8qzrnZUkWmNOs/KqEB83CAGOfM9zxiphid1C1l2EoEZj9Tept3CqECmRwWrS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:59:18.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccd7109-dffe-49a0-7fe9-08df0dec0cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694

The kernel support is not yet upstream, so pull in the latest headers
for v12. This patch should be replaced with a full kernel header sync
once the kernel support lands.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 linux-headers/linux/kvm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index aea4ab5c69..7850bd4642 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -987,6 +987,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1637,6 +1638,21 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+/* Available with KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES */
+#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
+
+struct kvm_memory_attributes2 {
+	union {
+		__u64 address;
+		__u64 offset;
+	};
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 error_offset;
+	__u64 reserved[11];
+};
+
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
-- 
2.43.0

