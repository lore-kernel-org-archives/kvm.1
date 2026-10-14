Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB23D0BED
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956112; cv=fail; b=VfeBxCQqoZJLlLI0KjJm/a3LNRuvoHrMU4nxRRqzPgGPuDrtnABtH41Nj3nHN9HZcVyT4evq/Jq2Xb4znf1KTicdW3x34ZGZluR1efDtrjGobf4qSwtPWknRW+jICr/Ca9o94HPFp3tJzIdYMtoe1HNxWroOpvEqQ5s8VA3iO/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956112; c=relaxed/simple;
	bh=0Sxaf6I0+fkB9YnacW83kB60QLPmqqwwSkMlI6tA/7w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WbgGHiOOneQWMom6/1apW0ep3/PDOpeF1ondH25xNBdJ7fL4pspSav+JEXZcTXfSh1UfQrJFCmIIcDu5e/SI9hEaGgSh9CoY2bUnMQQ3FynurwfJvdihgn5sq16ik4eKi9R9AWgtpyzJX0QNmoaXxdgqmLLpJLJyj34hQRPD99U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ri3i00H9; arc=fail smtp.client-ip=52.101.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ri3i00H9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7IOEy6Z+Eg06nyvRmUKHamNBrZzRtB+go4xtbzAq+ApKOVWfQj/2TryFc2hTo+vpkkTwidgNr37wXrE9bEFYAsFQE+VKjmT7L/UybelS9RT4Gk2BUsY0LwIP6bjRPtVwU018g0NnSBbL/fGITr+GN0GyZ1e9lawRIpvWD9B2tAQqvrmZjVCdebdE1fG4d/UvwyFzsiI2LfqSGgfGO6lubDSGRrmxap+taG4M9x7c/ESR+O2rJxFTODjbW07F+P6WT3Ou00Ybp0atdR9/Si0Z+0CExAZfyFIZdkEnwYp10Rbua+ERDEoEcFLBKPuWbRc9VclgWgLdxl+Xt9RKNCt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH06QNvOp46mrAYT4Bcpq3HzFwL2takZF7n3/59pCP4=;
 b=WQKJMGnK0AzzBFHVNfWUh8jN9zAeonw20awRgFRQ6St8PSWHO2D7qjBXA4OmE8i4OFhTrAXsH4yEDUeaYW6XEegGpvTRFPF/MrSIhvEfkSWmHXlmG2DiNGUcKKlOlVpO1YnkoVtvrj0qjrfXRO3zhOJQx6dmTrYfzRfPY8WbqePGp2+xNDKk7l+mM49wFabpr4rJuXxPtG5Axq3TfZ6K4ZcfjLsoYt2xL0Gz8lVd0Ggl2gI1dj1p6qVSGOfkcBaQ+CtCOOPnFmMMO4Km3M/tcRIoYGeLFiRcgXYOMwQI8KJG8Jh0jtYdpCNK5ceygVf6ph3UB+utwKQJFmQb3DuQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH06QNvOp46mrAYT4Bcpq3HzFwL2takZF7n3/59pCP4=;
 b=ri3i00H9HEI3DPgftCQ6Bea7okLL3EMuZjZLG2Tld1Enw0Il5owYCvDMa1BfNrEAdRveKsIB4gkfBaKb3xUGmM9sJ4coeEcngDUXiHTGT0hcLOVZiIoe0qpeQeNVAwjwLBLroRMGInEjSpJaPWpcJEKj6/Q0oLCxa5R9kVQo1N4=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Wed, 14 Oct
 2026 05:35:06 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4c) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 05:35:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:35:05 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:34:53 -0500
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
Subject: [PATCH 0/8] amd_iommu: Allow IOMMU to attach on non system bus
Date: Wed, 14 Oct 2026 11:04:25 +0530
Message-ID: <20261014053433.24564-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 569ad490-071c-443c-7d9e-08df29b4e6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|11063799006|56012099006|261009223027099003|921020|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FT0Y7M+fIHFdBxMwSfhNgIdjVBKI7kauFTqAkvHd8nqsTZ6k6wTejCZNr4EPuDrUTZUn6Xqp50hRJlysfknMSW6898FrrJQ4aD1zUZXm+T33HeOX06G2Ni+GLTK4RcPY+XEPWLXIY/grmCEekujZBX13PsDUaVKhqS/HBXiM7ZSBkAT1yo4j6AOUVZzMO1zX1B5urM5/eIaS+ryvIASa6mbsCewtrDeYjjEbLA0mDCF/JrLqLkWd0g+K4qZ/qeW91LRK2BVlCMrjbKf+WGTAoZCo2CZ+yT/ADGJH9oEMvopxsUj7eJw57KoY9wNxBYN7KBpMvSPNWnKE40k5h+fXz+/YdG0vhBJlvjwGLb9+2pBOUXkKBXkgYAod/PmkyWQ+bcirMp4r0NDBuJSpzTFrAPWPOzPP/G+JZ16gR7/h+hQK15SeTddbUjP6PB7ZI/0ASKrRLLymqG9KNvl7bEqPlG3oBRvoXWB3BPj6Zl/Xte+Eyww4GdN13NJNCbqNp7Lo8hOuO/dLnU97AOrh7ZEPljrDXTRoABr2E1wjYpmlWosb+PMKR171prvVeHoqyRUiLxmdM9LsceR6lfMFQr7G9vyFq88vkPWSPG8kZIP72VfU85D+xTdgZQvR10uiVF/tX/YPBCe1T8mHPssRWf/DFsMyJQfZbJTroLXDa63oNEyaiI+cFqTu2HYeWAi7gA4QJRC3WpmShmPT6TBAH+HsI1c+AxfcBpNYY96Ub3QkGhTaen0MiELN36dzNlDwqsM1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(921020)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wvjh0rpXjCKbOn+llGemvkwa1KBYMLU6HkEGR0UptmTsOl+2XWoRGSd4DyNnEIBUq+q3KknIT49aoFqYJYn0V75tCnqqab1RPN9ZQE/49JA4qifHAUKvCiSBn2i2tN+ng75Rh1oKRQ0iXYZ2LfoKlwb0WgEdGSsmwxg6DG+BDeqENW+X1W/ZCXBBkOFAJK6xzWHRC69KiJXoTNLwk8JpWdg6dKm9XvYjl1TYrStAqtkfrvgjZUb80wm5NyH1w5XuV1YJWysj0QQpYWOzpqjHEP0sqi3nqeTogr3a0ZWhdEEs9FDFUWn3KN97uGKdUC9UCAJluSWIfF9NuZ3mp+OkhpbsGTPCYo4/lLVZ6lXKPtxpdt4iKzP6QW9vdOJiGBnbhvNPvo+38hrixMKy1WC5ZY5PgfveAz8+KR0fZtCmCuDvT+hjuSPJbjo1ffT8ejgv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:35:05.2683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569ad490-071c-443c-7d9e-08df29b4e6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

Overview
--------
This patch series enables AMD IOMMU to be attached to non-system root buses
(e. g. , pcie-pxb, pci-root-bus), allowing device isolation between VFIO
passthrough devices and emulated devices.  This is a prerequisite for
hardware-accelerated virtual IOMMU (vIOMMU) support. 


Problem Statement
-----------------
The current AMD IOMMU implementation has the following limitations:

1. Only supports attachment to the default pcie.0 system bus

2. Builds IVRS (I/O Virtualization Reporting Structure) by iterating over
   all system buses, preventing device isolation

3. Cannot separate VFIO passthrough devices from emulated devices on
   different buses

This creates a fundamental issue for hardware-accelerated vIOMMU, which
requires VFIO devices to be isolated from emulated devices, as the vIOMMU
can only operate on passthrough devices. 


Solution Approach
-----------------
This series introduces the following changes:

1. Allow AMD IOMMU to be attached to arbitrary root buses using the "bus="
   parameter, while Maintaining the backward compatibility by selecting the
   pcie.0 by default if this parameter is missing.

2. Implement root bus discovery by traversing the parent hierarchy to find
   the first root bus

3. Register IOMMU operations on the discovered root bus

4. Modify IVRS generation to build IVHD (I/O Virtualization Hardware
   Definition) entries based on the specified root bus, traversing child
   buses and devices in a top-down manner

5. Introduce x86_iommu_device_get() and the get_x86_iommu() callback so the
   KVM layer can determine which IOMMU serves a given device.

   kvm_arch_fixup_msi_route() and kvm_arch_add_msi_route_post() call
   x86_iommu_get_default() for every MSI route. That returns the single
   machine IOMMU and is correct only when that IOMMU is attached to pcie.0
   and serves every device.

   Once the IOMMU is attached below another root bus, it serves only the
   devices under that bus. The KVM layer must program interrupt-remapping
   routes through that IOMMU and leave devices outside its scope untranslated.
   The PCI core can already find the bus that owns a device, but PCIIOMMUOps
   cannot return the corresponding X86IOMMUState. get_x86_iommu() provides
   that link. x86_iommu_device_get() uses it, and both AMD and Intel IOMMU
   implement the callback because this KVM path is shared.


Command line
------------
qemu-system-x86_64 \
-enable-kvm -m 10G -smp 8 \
-netdev user,id=USER0,hostfwd=tcp::3333-:22 \
-cpu EPYC-Genoa,x2apic=on,kvm-msi-ext-dest-id=on,+kvm-pv-unhalt,kvm-pv-tlb-flush,kvm-pv-ipi,kvm-pv-sched-yield  \
-machine q35,kernel_irqchip=split \
-global kvm-pit.lost_tick_policy=discard \
-nographic \
-blockdev node-name=drive0,driver=qcow2,file.driver=file,file.filename=<IMG> \
-device virtio-blk-pci,num-queues=8,drive=drive0 \
-device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x50 \
-device pcie-root-port,id=rp1,bus=pcie.1,chassis=3,slot=1 \
-device AMDVI-PCI,id=iommupci1,bus=rp1 \
-device amd-iommu,intremap=on,dma-remap=on,xtsup=on,pci-id=iommupci1 \
-device pcie-root-port,id=rp2,bus=pcie.2,chassis=4,slot=1 \
-device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=rp2 \


Example
-------
Example1, for below PCI configuration, IOMMU will serve all the devices
under pxb-pci (i.e. Device1 and Device2) since its a first root bus,
but will not serve Device3 and Device4, effectively isolating the
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

Example3, Below three PCI topologies will cause failure as AMD IOMMU can
only attach to **PCIE** hierarchy.

[A]
pcie.0 -+- pcie-pci-bridge --- AMD IOMMU
        \- Device1

[B]
pcie.0 -+- pci-bridge --- AMD IOMMU
        \- Device1

[C]
pcie.0 -+- pci-bridge --- pcie-root-port --- AMD IOMMU
        \- Device1

Sairaj Kodilkar (8):
  amd_iommu: Assign ioapic_as only when interrupt remapping is
    supported.
  x86-iommu: Introduce x86_iommu_device_get() for x86-iommu retrieval
  amd_iommu: Add support for get_x86_iommu callback
  intel_iommu: Add support for get_x86_iommu callback
  i386/kvm: Use x86_iommu_device_get() for per-device IOMMU lookup
  amd_iommu: Introduce root bus
  acpi-build: Create PCI topology using amd iommu root bus
  amd_iommu: Allow IOMMU to attachment on non-system (pcie.0) bus

 hw/i386/acpi-build.c        | 142 +++++++++++++++++++-----------------
 hw/i386/amd_iommu.c         |  75 +++++++++++++++++--
 hw/i386/amd_iommu.h         |   3 +
 hw/i386/intel_iommu.c       |   8 ++
 hw/i386/x86-iommu-stub.c    |   5 ++
 hw/i386/x86-iommu.c         |  16 ++++
 hw/intc/ioapic.c            |   3 +-
 include/hw/i386/x86-iommu.h |   6 ++
 include/hw/pci/pci.h        |  12 +++
 target/i386/kvm/kvm.c       |  15 +++-
 10 files changed, 208 insertions(+), 77 deletions(-)


base-commit: 562bae590f194fb590beb5c65da44fc35ab9f64a
-- 
2.34.1

