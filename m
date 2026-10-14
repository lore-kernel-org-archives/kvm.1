Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D134D93C
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956271; cv=fail; b=LPcbRnuD8nkaarOjIHUu8PdEB5qisFojTf+VaJ3EidsRChHqFmcZZq87oqR5LJmrv2iuw8/gAeTpZ8WKcnrcotlzVK6Ag7dgVEz4oezO3fg9dgw8yGheN9nPotQnQpX0WQVGSuw2VLqK3bezGx+2VUVSo6OMQuFjICcQbJOnsaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956271; c=relaxed/simple;
	bh=e/4wXejBHAd3aSH/O5lWvOUm77mMhZieNkznmfv6aRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thMR5jQWMs7Gv19MtWQ31dMedz8/XwuZP7bzC9p8vqJvYsohcNsMOQtOtwFzNE8DqTwRQ2d8tOklGm6U2ZbMokv1ENssInDxe1Rerz2ChN/Rn5lALqiZpwU30sIzVeCcwQTHR1voWzfI4qkh01sDUj1XrdJ84Rtd0oZmf2YDBIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CN9wwSmp; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CN9wwSmp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvxWM/xvGAn3Ww38SKJGmcubfiKlB2xJDdeM7FBXRxLZ7B57zoydsZWU6csJp/XcQMsdVAwQzBX+SfkLetEoRdEH8gv1tbs64gvSfnW5LHjWk8HmSxk2D160FbondNrpjSXm9dZ1UKNEKVedDwQJk81cjyBCcs/l0hXZ+kFKLsYi8kgI13Y8QYynBvn5lxZKiw6wmaqa0lSW/OKKvqjc73EI5p2Eqv65+UDwK+QIxb1xG8ioly8T/fPNFj630WSVjp1lD1GtBawJNFQ95TwyLI9cdQhoH7PkLsdU4/JERuBSzrED8Eg/zqTJxgRRg36nE2ncxJT2Hd0M5L7sjSJ9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adCJF4Ir1FFXeODu2tSlCdD8xnte7Ip4+5SIK5jk33A=;
 b=IFIpPsHq8DnjbmGoT4b4gPRNXwkFHpLLdCQMrwzcW6iuoQumqiNSCh9oPJt9bSCtIlusWF+b7ttFZclg3g/SaFBwaxKxAukGvjRp4B9VhC+V/fLqd5j+rzS64v/IUW2xfv9NSV/4iL1gnqE2zk+BR5X0zGxl6aqTHn2KnbRe8pF7Gd2uaz3XUt/iir/Cg7U2sLjiIGeE0OC6Nb+JzEdkVYtW/ogpUuCqFcW7qImrNAQsec+2CCQ5X3hN3WW8FfOrXz1Dqzm/xIxShPxxxlUijTSIF1kCnY0SOHqw03neNo0ZF519ChPykJDwbyxnDUNb4UovGB7VJCvggrRE6F2SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adCJF4Ir1FFXeODu2tSlCdD8xnte7Ip4+5SIK5jk33A=;
 b=CN9wwSmpnAHNXzja1es550raM0Xh3wWNlZaB3s6csfn1eGjAy61dFfVGzkBdYbdTp5grNqMriJioskwcmPuZrCRUwg2yI30jp4KZVWMrO9TpEi0QIeiS4H09r4XE12rlty10FJFR0QxHbFYkKIrs1visTgreo1g9XhZr/uzuO+A=
Received: from SJ0PR05CA0120.namprd05.prod.outlook.com (2603:10b6:a03:334::35)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 14 Oct
 2026 05:37:43 +0000
Received: from MW2PEPF00014673.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::59) by SJ0PR05CA0120.outlook.office365.com
 (2603:10b6:a03:334::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 05:37:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014673.mail.protection.outlook.com (10.167.249.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:37:42 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:37:31 -0500
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
Subject: [PATCH 8/8] amd_iommu: Allow IOMMU to attachment on non-system (pcie.0) bus
Date: Wed, 14 Oct 2026 11:04:33 +0530
Message-ID: <20261014053433.24564-9-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014673:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9e4376-61c6-41c1-b124-08df29b544cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|36860700016|1800799024|6133799003|18002099003|22082099003|261009223027099003|10067099003|11063799006|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	gVACFz8W9Ffs47GVCGoYFWoLl3aMWqPv48K/LOnsKwCINepXih/2xg/wd8uxK4F0WVkVglgeUfAT2DZJT0Z9CI0lbMmuzQ3nvNR7RpmHKBIWXPS4AjXJTlsOqQeWbo9dAOZaNWTsdMp1XHMVGYEblPtmdwDlK7jkMa5URCX4FtsoqyjzTL9hpFlQQV+T4odRZRDOx5P09NB/TxLEl7kXJ1Au6LGVriw0YfH41bwz5FV26uI6ylCiHK6/C+lmbogu11A9tPzuhvyFmX3TnPuexHMbbCsr6xiScGhxnudHVx2CHs2SA0RYWOuNfOROKWipAkuksEbWuuYOpBu8wvXiNNH8Rpzndoaet1tCKHl25izDh2OE5r2Xja8V1ANFiNl+GyCGJZn1z6F5G4OCdSp+CAphCjDiW8OWe/7VMlbYTyK2bKdZ0H3r1NqwISX5/q5baTmGuoEG1uPHmJa/WVmz5Q7X7vavrl0ichJl+nFpF8sVj42g377+cM5fdLkYWPZgNUFSyEuOK4ePDtgxOnEdwSDCh7ieVELqLyT+C4o3hj02c3FtChpE80HGuXb8+6lt0DtC+MscpeRJDS0cTHdofX1qKibqJAt4TYWAV8T5cg8zKAR3BEUbnBs+e7VxcUtZ9gTM5jf+WwrWPSw+cPTX2DILAmmgGFq4HP2BcARbZyDHZeppbBjRmsSAzc4chbzdqSCulnBLKe6F3TMDbGrQpKtttUfDTMC+Pl/fIJui/A4KoZEdMHwrmlu7RLt91gUg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(261009223027099003)(10067099003)(11063799006)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4QgSeKxdte3ECzbOwOorI2FLkwIB6wKKd58s6gWpr0bQP65j5feNxWnsMrobieLYO1J9OS7E+1l2BzpmABajglWkkEZ2oqlTOVBY6mak9ZkknAVCeHpSccVwpnRs2DmCNN9n1MlF0J6fLfQr9/8Qgelt09qpGG1swiWz6acFGiGkYtX+WJMyhzb46hntnrGpE3o23VJCnVGt3MmmYLYXy53yIbdDzT0kA62LauvaBtN3QVyPQNnmMY/WcszHd/pzN1BYccp/mZmb8eBRZMe7PFtr9YaguVrsU6Sypuc5CpobCRlxaDfNqT41/0q+FpPgi/8nHP6eSJqysGhOux0XOKumA3V4QMBRJKPhFBOyzKgl5lRnuQB4StKUfkQZqP0xVvSZdeWXftx6UuVPeeK0giyLVhUx4oKlfD9oYKYOlVQ+1u1j4VpbkiMTyG8cTs8D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:37:42.8832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9e4376-61c6-41c1-b124-08df29b544cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014673.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

Allow the AMD IOMMU to attach on the pcie-root-port using pci device's "bus"
property. This helps in isolating the set of devices by creating a pcie
hierarchy under the pci expansion bus (pxb-pci). The IOMMU always tries
to find the first root bus by traversing up the PCI hierarchy and serves
all the devices under that bus.

Example1, for below PCI configuration, IOMMU will serve all the devices
under pxb-pci (i.e. Device1 and Device2) since its a first root bus,
but will not serve Device3 and Device3, effectively isolating the
devices under pxb-pci bus.

pcie.0 -+- pxb-pci -+- pcie-root-port1 --- AMD IOMMU
        |           +- pcie-root-port2 --- Device1
        |           \- pcie-root-port3 --- Device2
        +- Device3
        \- Device4

Example2, for below PCI configuration, IOMMU will serve all the devices
Device[1-4], since first root bus in the parent hierarchy is pcie.0

pcie.0 -+- pcie-root-port1 --- AMD IOMMU
        +- pcie-root-port2 --- Device1
        +- pcie-root-port3 --- Device2
        +- Device3
        \- Device4

AMD IOMMU uses this root bus to register pci IOMMU ops and build the IVRS
table.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 55 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5e4d5d1f1fcd..e0968127ec40 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -24,6 +24,7 @@
 #include "hw/i386/pc.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
 #include "migration/vmstate.h"
 #include "amd_iommu.h"
 #include "qapi/error.h"
@@ -2680,6 +2681,50 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
      }
 };
 
+/* Go up in the PCI hierarchy and find the root bus pcie.0 or pxb-pci */
+static PCIBus *get_root_bus(struct PCIBus *bus)
+{
+    while (bus) {
+
+        if (!pci_bus_is_express(bus)) {
+            error_report("attached to non PCI express bus %s",
+                         bus->qbus.name);
+            goto err_out;
+        }
+
+        if (bus->iommu_ops) {
+            error_report("different IOMMU already serves bus %s",
+                         bus->qbus.name);
+            goto err_out;
+        }
+
+        if (pci_bus_is_root(bus) &&
+            object_dynamic_cast(OBJECT(bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
+
+            if (bus->parent_dev &&
+                !object_dynamic_cast(OBJECT(bus), TYPE_PXB_PCIE_BUS)) {
+
+                    error_report("only supports PXB-PCI as extra root bus");
+                    goto err_out;
+            }
+            /* We found the valid root bus so return it to the user*/
+            goto out;
+        }
+
+        if (bus->parent_dev) {
+            bus = pci_get_bus(bus->parent_dev);
+        } else {
+            error_report("could not find valid PCIE bus");
+            goto err_out;
+        }
+    };
+
+err_out:
+    exit(EXIT_FAILURE);
+out:
+    return bus;
+}
+
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 {
     DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
@@ -2687,7 +2732,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
     X86MachineState *x86ms = X86_MACHINE(ms);
-    PCIBus *bus = pcms->pcibus;
+    PCIBus *iommu_bus;
 
     if (s->pci_id) {
         PCIDevice *pdev = NULL;
@@ -2703,17 +2748,19 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
             return;
         }
 
+        iommu_bus = pci_get_bus(pdev);
         s->pci = AMD_IOMMU_PCI(pdev);
         dc->vmsd = &vmstate_amdvi_sysbus_migratable;
     } else {
+        iommu_bus = pcms->pcibus;
         s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
         /* This device should take care of IOMMU PCI properties */
-        if (!qdev_realize(DEVICE(s->pci), &bus->qbus, errp)) {
+        if (!qdev_realize(DEVICE(s->pci), &iommu_bus->qbus, errp)) {
             return;
         }
     }
 
-    s->root_bus = bus;
+    s->root_bus = get_root_bus(iommu_bus);
 
     s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
                                      amdvi_iotlb_equal, g_free, g_free);
@@ -2767,7 +2814,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    pci_setup_iommu(bus, &amdvi_iommu_ops, s);
+    pci_setup_iommu(s->root_bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
 
-- 
2.34.1

