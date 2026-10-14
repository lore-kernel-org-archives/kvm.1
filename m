Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C20348C75
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956208; cv=fail; b=IIypCYu9yV1CQl1xctOd9/ccJmF5KeJRB8rduG93ykob0yBTWX9LjAQjhc5lan9GFo8h7SAGzpnufUie7tFcBnHN0J5y7nIYGUXg22m6pON8tO8LSFEU1xe8xSyja927SN3K9tbrExa/Csc8CvAnb17BCaUnad5/yyHgcDOVb8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956208; c=relaxed/simple;
	bh=KzMrcYwqUII3vL/YYDaOeLrzf+iCrx55E2yWoynPUuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps2qZg6W8VekisZNArqcVmfD3b5AoYO0/xtqW7fQrc7aDK79KdRgFAGZ1IVW9ynPwsM5LKyPeV3rqvFP6vTd1c8m0UuGQwnc1iC0lyu2ExIu3kX7W+ZlwnkZ2xIl+uMJBJIfJDdqDM3GmoVHj4h/Um2ElP4FoAR8EEDmlHUjJbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0odFjei6; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0odFjei6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvSbPw/CftoF4Xbbu6t9jNEOw8NcPb/tKVh4yumlkPWl+Cey/LhcjdDW5ijun63M7HfTzHQ1m5jAZ5lCuP+t28EkRGGqsp7ZGg3whIa6XJsrwczsRrXS1TJ6Wknaw2Np2YXwvqXqGYU5DVyRS+wDW0tmiaKxSH6o4lT3A9uOWh/6icvra9urEfY+IYmX2+dj3O5Rb58ATHAkRqN5mppy62AiQ5p03bTZZLKXpw9rLO8b3456oF9n8a6wxbbo9F0h74aUQR4XidZvCfIwmeE0jKCczC/EoSiTv4sK7cue/4t1US1/csrlB7tTSkAvBQvg1l7Oov2szLLJmJbJjNhP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szdG2KVV44VJcELJe30wyoqNi6hNS666q6YLRFOFK2s=;
 b=vgv4Y5WaNyTsTsJDkjLfw0jwnkIrM02LU1wWNbaLpsJqOfBXrJ9Sxn1J/JleloVqDCzmeqBTLpC0/8rs7Jx6STsHb7ztCjhzmP02G6PwJgHt7TP5L+pCx6YI14rnlaImwmLUiu1dBKJgnWUYJEhO5F9Wy0qhTzVG1OwmUa9xATU97ED3FYeDHRIQjVNXwO4NqxJFfdIDwp0kSez6LKPuWZXGOXmCB+prUY39uBhGtcz+mKQVyUBU49FmlGaZjkny35JqTxzXpish8GINhIt6+0rvN4N5sCqnbdITTble4CRKeHVSlwexkMlyi8xp98wuJsNfiDa2NF8EntcluiNhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szdG2KVV44VJcELJe30wyoqNi6hNS666q6YLRFOFK2s=;
 b=0odFjei6WqhNK/DxIw7G3+h7ucUZarBKgERsYuKFUgGk12+4IprZ2au0gk7rft0MzZ56b4AZEQ8CkRy17HxGIoOI/mHYyMUVMalNI4rIqYsmpXMg7vpd7a9PWGysezvND5Qkw8/zRpvUbSaCinLEle5gdvOI8riol8sHdeb56AQ=
Received: from PH0PR07CA0066.namprd07.prod.outlook.com (2603:10b6:510:f::11)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 05:36:42 +0000
Received: from MW2PEPF00014678.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::9f) by PH0PR07CA0066.outlook.office365.com
 (2603:10b6:510:f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 05:36:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014678.mail.protection.outlook.com (10.167.249.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:36:41 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:36:31 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
	<sarunkod@amd.com>, Yi Liu <yi.l.liu@intel.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 5/8] i386/kvm: Use x86_iommu_device_get() for per-device IOMMU lookup
Date: Wed, 14 Oct 2026 11:04:30 +0530
Message-ID: <20261014053433.24564-6-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014053433.24564-1-sarunkod@amd.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014678:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: dda4cd70-cad7-4992-326d-08df29b52042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|82310400026|921020|56012099006|11063799006|261009220027099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oAuFSwr3738t68Vbn+7z5j4FE0v7QFecVdlmH60iqPHk39Xa2zwLzsFeN6RdhtjPynbkp7LZqXHx0eY0vAs5JSt/tHyUqAHUOKHLpXI+ZGTq+/vZ9Tmhu+eHIDGGb4od262W9x83YZMeWldCtnFPwn4l/ccE/W7/tUF+hXMX1D9ARR0AiK+D39dfcujgV/4hrO3/Uupp9P/akQNP4Fkv8kEyemyAD7yU50FlThaim/QKk5rJHDcisbwnN/lAy5heeIrGj++VJfR3CfGsesHH7wDdIudJEpdOulmkmlRV9VjKgBmf4eGEPECmuSdwzL1AKamgTDxw0jR95wstWl85Tiywy036+AvFNMJCOsQ73ZAU/ccGouGeX1ygDbsjD7Ge3XstP7wZX5HChh6LxCneBFTSRj/oW5vlTSI2EB4CX3fJsvCWoD1U4m2khEgk+PcTmWN+eJSDch3KUP+bM6bJf8EkhE4/EcKQeBaUMNrtdYunylNpFB7VreGOBa4/gNjoy2JHSavncVgq66w5T2fN1fcm3GmDV0VkXYWzIzxKH3rfrm8YJ0ZAxKIsTQdXH45KrjtJKHPJsddPR4zVRFiZe5qgEql52JUlRMqt1FyNTeZJU7OM4nDDcF9sZ281R+LuyX7xB0fY1diWXzNQoyyBFtKTZ95HypF8rQLaCsIsh8RXmM5NdANgePJTEtIITlfpNhAMfWQu/HAIG6TVLncYVsyOcpNYTypEGoVUUWCnqxCoCKCzIU6Wu6mbCEcr60n1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009220027099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yD4t1i60Nu0fd8uXfpsW8ag9RC+ppqZIjORdwBc5MpqjaMZ+rJ/XfjT20CK/iwkUXf1bWRn5W8LWbJph+5xYrYTjnCbAFxJc6BAUDkWa99jp3QtlWEItHQSMrt353Cd2r1++GWnBFB4BYKyqNS+zB2ouQw1qaHywExBtNXHEQGJP6Mbqy4H8UqdSszhqP4ZXVWpiD1R7ovPQSNccY+d3r31XVCbChq7Ls/HQXtEpNxcoJucIhWagceFe4XlwMZUxOtntcg86HEXr+0ZooW/PIRXV3LEb2mH5ibXiBAGIq9A80W8+gu3pZwAxxC35/67lByK7PfEli9ehesaqKu5PKqreRRc7XoELNtYLAG9H4rOHk//msyt+Hi4hBa+O4p3CALVBZK5sg6sPDr18LRCvKbmxtFfOHVpxscrBb9a7DH7/Uz9kk8l0augad3W/ZYRv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:36:41.6237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda4cd70-cad7-4992-326d-08df29b52042
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014678.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

Currently, kvm_arch_fixup_msi_route() unconditionally uses the default
system IOMMU for interrupt remapping when IOMMU is present. This
approach fails when an IOMMU is attached to a non-system bus and serves
only a subset of devices, because the kernel does not program IRT
(Interrupt Remapping Table) entries for devices outside the IOMMU's
scope.

This patch changes the behavior to perform per-device IOMMU lookup:
- For PCI devices: Use pci_device_get_x86_iommu() to find the specific
  IOMMU serving that device, if any
- For non-PCI devices (IOAPIC): Fall back to the default IOMMU
  only if interrupt remapping is enabled (ioapic_as != address_space_memory)

This ensures MSI route translation occurs only for devices actually
managed by an IOMMU, enabling proper interrupt remapping in configurations
where IOMMUs are attached to arbitrary buses.

NOTE: This patch assumes that only non-PCI device calling is IOAPIC and
checks ioapic_as to determine interrupt remapping.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/intc/ioapic.c      |  3 ++-
 target/i386/kvm/kvm.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1b3f1e824ac4..f1b881ee6118 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -438,8 +438,9 @@ static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 #ifdef ACCEL_GSI_IRQFD_POSSIBLE
     IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
                                         machine_done);
+    X86MachineState *x86ms = X86_MACHINE(qdev_get_machine());
 
-    if (accel_irqchip_is_split()) {
+    if (accel_irqchip_is_split() && x86ms->ioapic_as != &address_space_memory) {
         X86IOMMUState *iommu = x86_iommu_get_default();
         if (iommu) {
             /* Register this IOAPIC with IOMMU IEC notifier, so that
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a02..ffe977ceb418 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6746,7 +6746,15 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-    X86IOMMUState *iommu = x86_iommu_get_default();
+    X86IOMMUState *iommu = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    X86MachineState *x86ms = X86_MACHINE(ms);
+
+    if (dev) {
+        iommu = x86_iommu_device_get(dev);
+    } else if (x86ms->ioapic_as != &address_space_memory) {
+        iommu = x86_iommu_get_default();
+    }
 
     if (iommu) {
         X86IOMMUClass *class = X86_IOMMU_DEVICE_GET_CLASS(iommu);
@@ -6848,6 +6856,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
 {
     static bool notify_list_inited = false;
     MSIRouteEntry *entry;
+    X86IOMMUState *iommu = NULL;
 
     if (!dev) {
         /* These are (possibly) IOAPIC routes only used for split
@@ -6867,13 +6876,13 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
     if (!notify_list_inited) {
         /* For the first time we do add route, add ourselves into
          * IOMMU's IEC notify list if needed. */
-        X86IOMMUState *iommu = x86_iommu_get_default();
+        iommu = x86_iommu_device_get(dev);
         if (iommu) {
             x86_iommu_iec_register_notifier(iommu,
                                             kvm_update_msi_routes_all,
                                             NULL);
+            notify_list_inited = true;
         }
-        notify_list_inited = true;
     }
     return 0;
 }
-- 
2.34.1

