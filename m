Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0163803C6;
	Sat,  5 Sep 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595915; cv=fail; b=a1AaK6w9bVP7Z3Vr9YqlybSNia7TxkhbOsJn/5XsCG4inXVj6YzltUCuh0e99+J87WvqGNHCxgenQw6Kt92pXj4IZsHM3/MkwyK1EWgBP8EkMgkZZzcEq1XItxmHJw4wkj8x4hM7K/qDIy7DeMbBWUlRDqMPxI9fO7ugv+z2JsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595915; c=relaxed/simple;
	bh=1RTsMVVz5bwry7IPWVIJ+nali1kcwakEp2C1GNZbzFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uihUKsneTzMIrQHAfqXrlnbbZ8ukIZ96UkVZWhfzMA9DMi9qbbQ3Ax5uEGGP2NE2AJtELkc6zZj/ZI+c31rbM51zfVjgs7feoRYEiCfxR7ce5/izvCDEcG7dX0i7IWVg38PGDgxSz15qnHRhfSJa1HikFsRbWLvpXIZN2QiwWpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkz//qOP; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkz//qOP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNjBq3nVqEq8cBXVyhtLFDYY0lV0GXDSPA7Krq84i1gdcLKuySITMQmzKPNpIUBzZZgaUc++S9TthIclemiN353pD/y8qCT1mn6rAnvTG8OzVU6YwUUJZkz1RdAJtYEMy77Z1/Dxy6phTNQY07oRDPGM9QkBkCk4RKXtNjRmGD1QaTv8PgNNkfgDj+f4/yXRAidZ+QlFOOhRfobUZHqWB51m5dGB0OAHQwNsiINsHHIknsLoInLx9IRJYNk4a3F2hIjgCfYX10c/zpcFkzhpblk5mEXZ6AGcald2hFxWxmew+nLwl2vpdnTYHo1couULa2AAc4qtcb8fBWzLkgdkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x0ZxjM04nmcfxveJGPnB0BieElsgaSxEj/8CExm6cs=;
 b=eiBSB1a6jZg9971d+OTpS0ilgoLPBxmbzJQkVjsfzYVf+P3aP2uwiYYDyiM03Qc+tBz6m+FrpekPEYtVBttx3/VOyZmemxhHWHvN8thXUCx/XN11aQzlQ5XFIlVNx/m5krXlvrnsryX4mfXic4u3XhXPd/YsG1bsGOZzsDwgrSxFPr+FyV0tt6kChX00do+/zk3P/DE/MvteBSP7F4SZxfiJsiwJi3FGhmmru2KLZP0sZeEe8/xA1wKlwmjNIcNBAY8b59jesJUmqme0bmHYgEuSPWEYESDBqPlAGSMIPDQuA/SutPsn1+w5Qj18u5YHWcDlJNqo+MOfWdPXjofPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x0ZxjM04nmcfxveJGPnB0BieElsgaSxEj/8CExm6cs=;
 b=fkz//qOPqc0lo6etQWJEKnVUd01rKdM4xcvixfgT43ESWufpoy5qp4m67IJawuGWeByiD4SK1//W/eO1mmW0nup0WtmHRlL0DESzujNwb0wDfXc8KidWwAOqFgqJV3Afe7bq7FfdTsou+iNQk9YI2NOjEJA02DgMq/WEgANyu9hxjqElTIYCp3lADXNjEjFSWfQCTq9NsbWwJWCk9xLKGTemRiLC9AC5DrcC7tzsKVhssMD4efCAue8+AJUexHVWnQKBhlwFGbqAWJ3Rmbgq85CNPVMuRA3/L2hlh/MB0Yj1ZJcigFiEj4liTPk5Z7Kjc1yPFb6S1TJHON45K6sK9A==
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 08:11:37 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::2b) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 08:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 08:11:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 01:11:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 01:11:26 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.46 via Frontend Transport; Sat, 5 Sep
 2026 01:11:17 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, <kvm@vger.kernel.org>
Subject: [PATCH 00/13] Introduce NVIDIA vGPU manager and VFIO variant driver
Date: Sat, 5 Sep 2026 11:11:03 +0300
Message-ID: <20260905081116.106613-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 916a1aa8-8c1b-4af8-8354-08df0b254ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|3023799007|11063799006|6133799003|10067099003|5023799004|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	DQ1BJAT4sUfpkUfuk6KowBx7Md2jIb8gcpWz6WOiGJ1ERAiA3h4jPZaThDJGxJ6vyFIEOs2d6CAD6pAHETkPs2KD+VBFeIdXC83lzI3th9t+NCBei2HiVyWWNLJs4n0its+cb8sWlNcUdKPG/n1sPDzG+Ic12HfcljcD3/Xasj9Dd/mAnE/SBavQqtJn5y4lW8C0/NTsxK2rMBh5T58tAF31nrM5gUk5920+p1tHKeJcCAv4zLjkTehtjOSE7oBQWP1dSF+2cpyupjvdQPpLuExpIoZFwNgFk2A1mShybflpFcbjkHfjLS8vG1vJ7uVSGAyUZnVDKFTWM0Fn7LqtaZF5pPfGF5H8d++y5DT77dZAlYHtRpWYXOcjqrl8a1Pp523qRu3IyNf6EbOVmJHvOaTqQNDBYtL9Q8IgNZcIzZcw207DfS7uCfZTgzrJkjaqZAzaqz656dq7ve7g7LKDedLftKcj0GkWSMVVSzDoxEUM3zl953VLKM9YAQ3wMuW3BH7F4xFvK1xTYPibs9K3IRTDKls54U7cY1tyX2Ike1C26MwA+oRMrV1YOAv6VTVSqLYccSF082QNmfATTFf2MpLshbUrGSm9QcUji9p/oyZwbIJDJRFZgRa5CKdZFw/3zwsKt2v+iNkY7MzdBruPi0ppsZPfWERefudW4HMxEd3+Kk1SW6ujYkjV25Kq72Q6wFT0XygNgyAsSsKh4wG5+w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(3023799007)(11063799006)(6133799003)(10067099003)(5023799004)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ns61973I2qBsf+6NxITVjuejcboAbVjq2dDUGOYTHjk+SJlsVNfbdM05aR0WOu0NTqv+Qu/lGDlBBaTdp9Ri04bEH9vYcJ9OJphQHB41amz+BLTgySyOtTT8xjblbLMUfOW95WIpWFRPj7X8usRFlIggh7I06Nwjq38kDnoPvlXoyvU0u94xX4yQOralTi6l18DYNuR2sFin+U5KEVaTCm5Rz0Q8WHJuYEpATxmSWHWtzn7R2y0H6YN+RQRPbZqVTpvoFW+iHyGzBrEHTnHMNdJag9PkZraIh9N31RjS2jVcVPEn1pyFUqCtakr7oSoC4kHWazewRV1OHYxqlv3yV/pcerZ6CSW7Kn5n1FO+LNZ4bfwoqySgRIiRxrLIuW5ZNVcXYpPWwlqgFYyiXLUtUs3SKk9umu6jeVPx2ZkepHZGfBWbwv5+uSLG1mhmclf7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 08:11:37.1634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916a1aa8-8c1b-4af8-8354-08df0b254ecb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

Add the nova-core support needed to create and manage NVIDIA vGPU
instances, together with the NVIDIA vGPU VFIO variant driver that consumes
the lifecycle interface.

The control path introduced by this series is:

 +-----------------------+         +-----------------------+
 | Linux guest           |         | Windows guest         |
 | NVIDIA guest driver   |         | NVIDIA guest driver   |
 +-----------+-----------+         +-----------+-----------+
             |                                 |
 +-----------v-----------+         +-----------v-----------+
 | QEMU (VFIO user)      |         | QEMU (VFIO user)      |
 +-----------+-----------+         +-----------+-----------+
             +----------------+----------------+
                              |
                      +-------v-------+
                      |   VFIO core   |
                      +-------+-------+
                              |
        +---------------------v---------------------+
        | NVIDIA vGPU VFIO variant driver           |
        +---------------------+---------------------+
                              |
              +---------------+----------------------+
              | binds PCI VF                         | PF lifecycle API
              |                                      | open / close / reset
              v                                      v
     +--------+--------+               +-------------+-------------+
     |    PCI VF(s)    |               | nova-core (PF driver)     |
     |  (virtual GPU)  |               |       vGPU Manager        |
     +--------+--------+               |     VRAM / channels ...   |
              |                        +-------------+-------------+
              |                                      |
+-------------v--------------------------------------v----------------+
|                      NVIDIA physical GPU                            |
|            VF resources                 PF / GSP / VRAM             |
+---------------------------------------------------------------------+

On the nova-core side, the PF driver owns the GPU firmware-facing part
of vGPU management. It already detects vGPU mode before GSP boot and
supplies the SR-IOV topology to the GPU System Processor firmware
(GSP-RM). This series extends it to:

  - Retain the firmware-reported VMMU segment size and FIFO engine
    ordering after GSP_INIT, together with nova-core's channel capacity.
  - Add VramBlock and VramRegion ownership plus Bar1Map for bounded CPU
    mappings of VRAM-backed control structures.
  - Query GSP-RM through its command queue for the vGPU type already
    assigned to a VF and its properties.
  - Build a layout-validated, profile-wide pool of paired framebuffer and
    management-heap slots, reserve contiguous channel ranges, and keep
    live allocations in a per-PF instance registry.
  - Use the typed r000 firmware bindings for control and response layouts,
    message IDs, and firmware-defined region sizes.
  - Handle GMC transactions over the GSP queues, match GMC replies by
    command and sequence, dispatch interleaved RM RPCs from the shared
    GSP-to-CPU message queue, and consume stale GMC messages.
  - Implement the GMCAPI bootload, shutdown, and cleanup operations with
    typed channel and resource maps for each plugin instance.
  - Establish the BAR1-backed PluginRpc channel, negotiate its protocol,
    and send the VM configuration and plugin BME-state update.
  - Use per-instance CeUtils channels to scrub guest framebuffer memory
    on allocation, reset, and shutdown. If ownership or completion is
    uncertain, keep the affected VRAM and channels out of the allocators.
  - Expose the three per-instance plugin log buffers through debugfs with
    the header needed by nvlog_decoder.
  - Keep resource locking, teardown, and rollback inside nova-core.
  - Select the firmware-defined 48-VM WPR2 heap when a device advertises
    more than 32 VFs.

On the VFIO side, the NVIDIA vGPU VFIO variant driver:

  - Binds only to an NVIDIA VF explicitly selected through
    driver_override.
  - Derives the guest function ID (GFID) from the SR-IOV VF index and
    registers a vfio-pci-core device.
  - Presents the vGPU PCI device and subsystem IDs returned by nova-core,
    and limits the reported framebuffer BAR size.
  - Delegates the remaining PCI and VFIO operations to vfio-pci-core and
    uses the standard VFIO physical-device helpers for IOMMUFD.

The ownership boundary between the two drivers is visible at these
lifecycle points:

  - Open: after vfio_pci_core_enable(), the variant driver passes the PF
    returned by pci_physfn(vf), the GFID, the VF's PCI
    domain/bus/device/function (DBDF), and the calling process TGID to
    nvidia_vgpu_open(). nova-core validates the PF and GFID, creates and
    activates the instance, and returns the guest-visible PCI IDs and
    BAR1 size. On failure, the variant driver disables the vfio-pci-core
    device; on success, it calls
    vfio_pci_core_finish_enable().
  - Reset: the variant driver first calls nvidia_vgpu_reset(). nova-core
    sends the plugin reset RPC and scrubs the guest framebuffer. Only
    after that succeeds is VFIO_DEVICE_RESET passed to vfio-pci-core for
    the PCI function reset.
  - Close: the variant driver invokes the void nvidia_vgpu_close()
    interface to request plugin shutdown, framebuffer scrubbing, and
    resource release from nova-core, then closes the vfio-pci-core
    device.

The cross-module interface is therefore limited to three GPL-only
symbols in NOVA_CORE_VGPU: nvidia_vgpu_open(), nvidia_vgpu_close(), and
nvidia_vgpu_reset().

This is a ground-up rework of the earlier vGPU RFC [1]. In particular,
the vGPU manager has been moved from the VFIO driver into the nova-core
implementation, and the VFIO side no longer carries copies of RM firmware
headers. The VFIO driver attaches to the VF and uses its PF's nova-core
state for management, as discussed in that thread.

The patches are organized as follows:

  1-4   Initialize VgpuManager and add the memory and firmware building
        blocks.
  5-8   Allocate instances and implement GMC, plugin boot, and RPC.
  9-10  Scrub guest framebuffer memory and expose plugin diagnostics.
 11-12  Export the lifecycle API and add its VFIO consumer.
 13     Select the larger WPR2 heap for 48-VF devices.

The series is based on the nova-core r000 GSP, memory-management,
SR-IOV, Rust bitmap/id-pool, and PCI abstraction work. The exact base
commit is recorded below, and the complete prerequisite stack is
available in [2].

[1] https://lore.kernel.org/kvm/20250903221111.3866249-1-zhiw@nvidia.com/
[2] https://github.com/zhiwang-nvidia/nova-core/tree/zhi/nova-vgpu-wip-nova-gsp-20260902

Alok Kumar (1):
  gpu: nova-core: vgpu: add VRAM slot allocator

Zhi Wang (12):
  gpu: nova-core: vgpu: add post-GSP-boot vGPU initialization
  gpu: nova-core: mm: add VramBlock and Bar1Map
  gpu: nova-core: vgpu: add r000 plugin bindings
  gpu: nova-core: vgpu: add instance create/destroy
  gpu: nova-core: gsp: add GMC transaction helpers
  gpu: nova-core: vgpu: add vGPU bootload
  gpu: nova-core: vgpu: implement PluginRpc channel and config params
  gpu: nova-core: vgpu: scrub guest framebuffer memory with CeUtils
  gpu: nova-core: vgpu: export plugin log buffers via debugfs
  gpu: nova-core: vgpu: export lifecycle operations to VFIO
  vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO variant driver
  gpu: nova-core: reserve the 48-VM WPR2 heap

 drivers/gpu/nova-core/driver.rs               |  42 +-
 drivers/gpu/nova-core/fb.rs                   |   2 +-
 drivers/gpu/nova-core/gpu.rs                  | 184 +++--
 drivers/gpu/nova-core/gpu/channel.rs          |   3 +
 drivers/gpu/nova-core/gsp.rs                  |  29 +-
 drivers/gpu/nova-core/gsp/boot.rs             |  13 +-
 drivers/gpu/nova-core/gsp/cmdq.rs             | 356 +++++++--
 drivers/gpu/nova-core/gsp/commands.rs         |  78 +-
 drivers/gpu/nova-core/gsp/fw.rs               |  63 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs      | 185 ++++-
 .../gpu/nova-core/gsp/fw/r000_00/bindings.rs  | 175 +++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |   2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs        |   2 +-
 drivers/gpu/nova-core/mm.rs                   |   6 +-
 drivers/gpu/nova-core/mm/bar_user.rs          | 183 ++++-
 drivers/gpu/nova-core/mm/vram.rs              | 187 +++++
 drivers/gpu/nova-core/nova_core_exports.c     |   5 +
 drivers/gpu/nova-core/vgpu.rs                 |  91 ---
 drivers/gpu/nova-core/vgpu/bootload.rs        | 162 ++++
 drivers/gpu/nova-core/vgpu/consts.rs          |  33 +
 drivers/gpu/nova-core/vgpu/fw.rs              | 490 ++++++++++++
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |  28 +
 drivers/gpu/nova-core/vgpu/instance.rs        | 705 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/log.rs             | 167 +++++
 drivers/gpu/nova-core/vgpu/mod.rs             | 170 +++++
 drivers/gpu/nova-core/vgpu/plugin_rpc.rs      | 274 +++++++
 drivers/gpu/nova-core/vgpu/scrubber.rs        | 474 ++++++++++++
 drivers/gpu/nova-core/vgpu/vfio.rs            | 282 +++++++
 drivers/gpu/nova-core/vgpu/vram.rs            | 140 ++++
 drivers/vfio/pci/Kconfig                      |   2 +
 drivers/vfio/pci/Makefile                     |   2 +
 drivers/vfio/pci/nvidia-vgpu/Kconfig          |  16 +
 drivers/vfio/pci/nvidia-vgpu/Makefile         |   2 +
 drivers/vfio/pci/nvidia-vgpu/main.c           | 253 +++++++
 include/drm/nvidia_vgpu.h                     |  28 +
 rust/bindings/bindings_helper.h               |   1 +
 36 files changed, 4536 insertions(+), 299 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/vram.rs
 delete mode 100644 drivers/gpu/nova-core/vgpu.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/bootload.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/consts.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/commands.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/instance.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/log.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/mod.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/plugin_rpc.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/scrubber.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/vfio.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/vram.rs
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/main.c
 create mode 100644 include/drm/nvidia_vgpu.h


base-commit: a1dc9fdea9ab15e5df1bd6af1f6de2e40079f02d
-- 
2.53.0
