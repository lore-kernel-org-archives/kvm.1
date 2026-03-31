Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3944E037
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988728; cv=fail; b=dKJGlxg+asFpWUH6Nl3EaY0V+JDQ7npVfNORc/E1ohLZXpmOGSPbJxGwLkHeI3PLwxYWF0W0AIp34k4nAjvQFL/eByoFE8+BpKBd6otKrN9zB6sOItcmk5iePdgDTJy+Tl7PPdLgcmawA1DL/OLpTV98LsVtMRu8KSNX4RdxiVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988728; c=relaxed/simple;
	bh=kJp6MIRptGEcK7ZRCPhNN1zn81APs3amdwnaErY0ZIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wa4YNDXpaiyiTMyL22X4ItknaFW8NtLy62JanP5UcnVnRlNxz4XFn019TPlARbwdgJdShFBO6yFAk2BBYdyUDWENAExYjpsht70nzeZf7wdf8HMHx0p4qvW2if+HJz2fuZY6UTlWkBBOUjDo0id1wN5RbewnBBI+N224GAtRYSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YLg6eUzV; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YLg6eUzV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMV/NUX2pehTRzEILYWVsIN+xtFlNz2IHvDdeZ4JH9hM+r/3wuo1hAPmpvsoMBOE3FGajaFoFbesq8PFCx9pnp1gGdi/7sCbgq7jVgyEUyg8RppAxNyvi9IJ7i9+i3Dcwy5EMQghSqXUNWE9L1SCRO1G2J22mDBRoFQf38VpZk+0VAKoi6hIYPfbKouCokmAckEbjxDbq5hx16J5+PwWL8t9nOwbkrXN0oVo3TJEnL3NIsTOicDNEzA08mrzFkL1se3YA45q9JKlISMFNhjIVBrB/dFdMDDf6+4a1naJwY+X7sJyJmSx82oTQZQ9WBS8EOTjaS0QcspDxXRtImZwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Zd/cd6rll2+11fazEj2aP98Ncg3cKzPX/AVFY2460=;
 b=hcVmT8hJFn/KcIxSw7UmMcihVdo1C0RVGD8vgEJg7FwPQkLHtDQZzre9IoANiHPau/mEmPa1yN9KwsdYECgVMZZDjDapD1oYZF4By0+6sGFnsehSuOynW6+15U+K0SkHd/PHRebGNZuMQ4mVRJbNk4LHopjmrOdF2ZOHgW2m9fv74rC/4aya7zw9douVl44hMoZhgLLyvcryNaklCMISUOlpkz0rdEeXJdnyTJpsBMM55ysA6WzNIDAom/tz/C4TNWLcD3xHFF8IcF/u79oZIG5JnFHBk1EmwYEu8kNFRRmlh8bo9ocVl4i9O1wuYREJMCOfsuVTZtsGJBIGNiFvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Zd/cd6rll2+11fazEj2aP98Ncg3cKzPX/AVFY2460=;
 b=YLg6eUzV+sgCcZZ/qDYu/R6LJzTzKyUyhFIRIKAYHxDKYDiimvXh4fM56xLyF8WQnkx7i4ubuadnAAR4WN+4TBmJs5uJdjNCf7IglLLVmXRv6EI2iOkPGeRq5DL+NsKqeH8atMX6BFGpxjUk35OuDYs+5W4Q4dx3lJrfvpZ+7ambO/YCOMmBuiysszPgpXWrURLFEI0Z1Og6G1DVqrvMhcMaNhNpnA+A49rKM5x1DlC3PlNTEYGMFrEow7yCxEGZJGIfY73Sb/D7pPr5qacRKNEpIAcxCHHgi9jdg9NohmOv4Rd5D+moIOSiouiYxHtzlFAEoVwYNxOrU5F5hxuK2Q==
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 20:25:22 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::23) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 20:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 20:25:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 13:25:03 -0700
Received: from meforce.lab.shazbot.org (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 13:25:02 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <kvm@vger.kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] vfio/pci: Require vfio_device_ops.name
Date: Tue, 31 Mar 2026 14:24:41 -0600
Message-ID: <20260331202443.2598404-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 924ef455-b95e-4dc6-6b26-08de8f63a274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nNqxsRV6zC2RPKMN9JbI47wloBwjGigKHWYkepw9xK15xz/0dt7elP9XAadJdL0nuaEjWgdMNgVIv6hM5FCYEo3jQKhEUbGtKvLqZolmFKYe65bomBTHLE2oBSuFb6c+BYylf/QwyqJMIgJmuHRRtCe83VbSG3uXIiRdB5PzFZFF9rs74vUIHEWtvEME8IVvfnBwbCDSVb+QFv3cXIZCTE2fbNkIoNY8yLWkO261HXuqYNWzIr+3N4aX9EC3lrk7kGjYH/lZVDzpL1aFIzQJfJc9nryN9fvlOxd50WZwwzEJqWCU6JOcEeWVaEQSIM72kZt8fe8vy8e0gRowVUc3fvUuvfxTDNm6Uh5y4BPhwTyBL63en2Ro3mwobDc6htSBiF6K3P6u+0LpDueZWhknSRiUS6cqoD3qBoiZYYfuUffgSnb72hRkHBsBwR4zIAm4zw3GydIn2FHx8Vu6xPuMLXZ/Hg31mV9Vm/U17JFT3plCigE44oqDyQTJfMW0R5MClDFWhuVZlCZWt5vigATRTZUAjTcEzYRrVSkqawM2ZMlgLKLTYN/91bSo6JH0d6B9RlI6x40qKp4CjppPHBql0OpJfd5cXVt1q14O3xK+GwofzuJIQpOB3TeScRx9SlYEuR266XpuBbdrOQwcIzLgbc3BHDzLLg5RZJ0cF8ZZMr6FvHRWA9yAXAAQ3/AUNOgnYLIR0ZKCbJ6gU1Iur/IH4lIlB/O2+cBCmm5fvHmSTVwS1CnmKh9lGs9RC5nnORqCaRwmBiFXMLtvf0VwPzo3tA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xsq1pJeC8SYLHXeJNV4JxiVh6ekLoAUDmPPAk3j3sayeQNBgOhG5AnOBicED8HPCDgoVz1i3blzXJ7yGe8RAIFjpHbSlpxDdWqGmjIsRyKiFB9hvZIInUdi0dAw5INFnvtduSxq5UpccLwENLQ3f4XQISOanKZNAH/Tm9cN+f73pORSzdMVdneL1tZ+iUVG2Irrt6JranXxLGfOuvL8buLDRcx7tOjlphB6CtsFlVc+A/N62AV+AzZ228YMCIfxkINk5TbAsVuTzbrsTAOLIK4fIOPj6x/iNGx1R/1pgCqdB9TVqUebcSlJQKmQ0W6lPRr00km/yUZMpxSMHhk3x34OvOrYbJl05bjCzJ/b4AGBLw8tgmmlnbRxAoBMZiTfs7wCjyxK3AJmCXf49C/jl5ZHFS/5TEpJmgvbK4DthcUZK5/i39y0TuLWsdJSyOmmz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:25:22.1876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924ef455-b95e-4dc6-6b26-08de8f63a274
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

vfio-pci-core code makes use of the vfio_device_ops.name field in order
to set a default driver_override for VFs created on a user-owned PF.
This avoids default driver matching, which might otherwise bind those
VFs to native drivers.

The mechanism for this currently uses kasprintf(), which will set
driver_override to the literal "(null)" if name is NULL.  This is
effective in sequestering the device, but presents a challenging debug
situation to differentiate driver_override being set to "(null)" versus
being NULL and interpreted as "(null)" via the sysfs show attribute.

There's also a tree-wide effort to convert to generic driver_override
support, where passing NULL will generate an error, resulting in a
WARN_ON without setting any driver_override.

All drivers making use of vfio-pci-core already set a driver name,
therefore by requiring this behavior, all of these corner cases are
rendered moot.  This is expected to have no impact on current
in-kernel drivers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d43745fe4c84..84d60689d386 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2139,6 +2139,10 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (WARN_ON(vdev != dev_get_drvdata(dev)))
 		return -EINVAL;
 
+	/* Drivers must set a name.  Required for sequestering SR-IOV VFs */
+	if (WARN_ON(!vdev->vdev.ops->name))
+		return -EINVAL;
+
 	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
 		return -EINVAL;
 
-- 
2.51.0

