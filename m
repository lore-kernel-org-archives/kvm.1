Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DEB3A3E82;
	Wed,  8 Apr 2026 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688945; cv=fail; b=NAUK22zVajHIUgmbax5drF0E/7ImXlt3tFB8j/tD+H4DfP4nPnZ0cQKSIvEUxKUn5GoYpUh7ULuBhv1D3xkYfGhTDSfNdUDN5jJjZ2s7vZCZJWKPNXzmROdrxvm0rJvvBs7PF0nii2VzUTA84RdftfbRIw44zmHl/lG/+2Pc6HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688945; c=relaxed/simple;
	bh=C0wvUrdZ7Iwub8idWe7G0+R++LVXBtz1kWsq3occGJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/gz0HsWPnJZ/u+6TFQ0yO8xHDyB5u8BYCVGOQlOvJuPo1gl3GpYwDoy84y94q7xkKLhjQ2F8VdbJqKJVAIoSKiUz6ZA4R2nIYwzYdZmW+WwrvO4K+Hhgu2Nrj3lKsvDMCi3Pa9QfGnPd/hN3LPpo1Pk8AFCWGNlANZhGRmbLis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uv1T6tEa; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uv1T6tEa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pb+syMN8CS0tJvqQMlYVDgq+ZubAfx28XbHophpkE6JUbP/086qrGUeYFVquUcHVNBmmYcNo2h+s0NAveJG4zU/0jT1qT0xv8sDp7cOsAtd7Z68Ry1YQT3Y1tptXB2Eho1rvnvGbunojMv0xWTkkfX98yaVxn1Asu+HNCi4d0UuZ1NDY4jqhFEbFzuY2anntPddFciUYNmbvmKqke8UwSndH5n46zAEMimJQZedJYag//VS8f7P5NOwmtBSJZXaYw68d9gqiXCwuxs6C4/iy+U2GJlNlnUbx85d0rhIesEAcEtOJ31Dy+O3EIQX6RubIdJ5U5NN1MG0YzMEnP3I0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSxRnigLbDvpZ6yOB/i7LN2bGI2WD3jTC/oqI0r8qZY=;
 b=fQh9ku+QA45hL8/Keuj9a6tq3EN6ibqvwE2+WYGgtztbY3TQy4KJQ7EJi9by+x3Y7JNWZbOm7n0uEgrk9wLvV72n2POx+8xPpuTMxHBLIj8N1zw3ff8ZYgnCilHLbtRPCvoCyJ/XMCzKZO3pMepVfqHCHp70NSZ4Vfhj1SJFD+1RHWy54D6sGIt28G5NKqV4oGMkOIOa4LHW4PmiIJOMtqYKiKM/nKjv70D20NZMmloPWV+8Dgg7ziQDluqlNMMjIRYT34xCvSIq/m4bqX/W1I/AtqGbnVxnqqCwnCU28zoucbIFR7lIJx7tWrDlI7sUPH2ST8b8lzwPui26vWCrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSxRnigLbDvpZ6yOB/i7LN2bGI2WD3jTC/oqI0r8qZY=;
 b=Uv1T6tEa2bXhl7bnIbDr3+Au6fz1H8uAMjK48RjM+Qo4weGY0oo48QkgTb+TsJvexTdgxKen4RHH/TNVeYgNBgsdPjniOtBg9VzjFYXYnVnuCpV2PF9tz/OAPFfuaVj7mIQUPY6bQ8i2qkiyxreVyixpZdIZFb7jywU8W5jyD1HBM51bH/IvEQDGUnjF46cMfX+oUmorc6ksq4Di3bAcMidUQH0vNtCZTVT07VJa+XcqfKnpJkgxRn6SN9fcUnEx9mIpZBn5swbQpBPB+YPkCN6pqpoUK2WAS/SyLD8Q2HsZnnCBGj5mvj3luAAfwulyNwyAZQoAQI+uuY9kg5Tn9Q==
Received: from SA1PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:2ce::18)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 22:55:40 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::64) by SA1PR04CA0011.outlook.office365.com
 (2603:10b6:806:2ce::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 22:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 22:55:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 15:55:26 -0700
Received: from meforce.lab.shazbot.org (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 15:55:25 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>, <dmatlack@google.com>, <shuah@kernel.org>
CC: Rubin Du <rubind@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@nvidia.com>
Subject: [PATCH v13 2/4] vfio: selftests: Add generic PCI command register helpers
Date: Wed, 8 Apr 2026 16:54:55 -0600
Message-ID: <20260408225459.3088623-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408225459.3088623-1-alex.williamson@nvidia.com>
References: <20260408225459.3088623-1-alex.williamson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: a97798d5-ef18-4d3f-4175-08de95c1f4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9tuiNGeWdsZELCDUTwtrfC+Jsx0fxnRf4sdj8ZpFjzCRtrED6T05EGen4hZtMoQYOvITvUnh2KUqtyP146fe66ytqiQqQae/VwlJ6oRjfMVgKd8tVi/FRF5HucZMVgNX7ArhAhGT34k3RicKPxXfPY+OH8KHrMHVCi96p70Qc2QtZJJ0692nes5Nv6vQMU9Kpi4+ty/3gkSX7M7SEGoQ28J6G3/onabeXe49Vz0bwZmqG29+Fvl5gLuVutNz5ph5Zlm8/dYnoCgC/L8bR8xBKt6byUtg7CANdLOm3xTOTkdcwxRz573G2f3eAvsHXCRY1+fq253QFsPq4dFLoS3u3MTHG4KgmpNKzLyinVPGBx3VszW5MEmp8Yji3uwnaYIKEZWlEcwGvTTM72Tveft+6PMZyzwYy7iGcmJzPTugUT5mMjk4llpoYCuKUePfRqQa6JIMZk1pp9T5jwnH1wY29gx1Fmar0PJkh/ow5/cVCDxNbG2ciFbRN2eKY6FP85R2K1PDMBJPfYMIwv5EH5ARbfn/+3pPNRLYLWguy6VQlGUzvIP3bKscW6olACpsl+flmEuC9gqU0/hamWeDnIS0p6s4HGVKd+wD0vm+pvOnFwitk57egZgCrl2ZSt3RLZ3cGHc31BDGLU1LhOvdDTxzSsUuPCpAUZfD9c9H31a5tonUgWD5YcZQd/IfFcjTjCSjRvQeXVntvQMkt5dnsdD0VA6IN3vqirT+13yxdVSb0gxIpEygxHq2N5zNDUKGdDjP2tll6zUgRbZQNqbDYLk7Bw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C75TDecNlQMS7/UcfEE1Gt4kzpMskzCslnVOhb+7YE56n17SBHknu851547Jy8bHTHuouP/i9MC0DPbSd7Z/k2SG65nOIk55xoiPa/eSq0K2w64yHCDeFddSaEID5sU/Wf/MtGaK4fvfUGEhGBb37ZstwlYC/zHgm8Jy+RZQsp5RsOat248DJbf1k2VBfoxGUGqA0U4wG1PBPzP7TqixGK5XmtvQXz4NgcEAAxWgJtZDj8K+6DZMC7Gqh+K2P+AmvsqoSAEVdjCaxD1QdG0pwMs7fFgCMFMv/erE/H3GUQz8ZdAJUpOOgadfBTcFGiEJiUY0c0NCfOxXSyF/nwY0E/iUsWcfNwMRKRMBrCevpv1ZzHtK9R9765ZoXuL2nSfLiLwCHN3iozNaWkAB7IgnMx2+kExpONk59Ct83EYT/nfpSNv4wWK79I9X33ADATlv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 22:55:40.1475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97798d5-ef18-4d3f-4175-08de95c1f4e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

From: Rubin Du <rubind@nvidia.com>

Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() read-modify-write macros
for PCI_COMMAND in vfio_pci_device.h.

Signed-off-by: Rubin Du <rubind@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..bb4525abd01a 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -65,6 +65,20 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+static inline void vfio_pci_cmd_set(struct vfio_pci_device *device, u16 bits)
+{
+	u16 cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+
+	vfio_pci_config_writew(device, PCI_COMMAND, cmd | bits);
+}
+
+static inline void vfio_pci_cmd_clear(struct vfio_pci_device *device, u16 bits)
+{
+	u16 cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+
+	vfio_pci_config_writew(device, PCI_COMMAND, cmd & ~bits);
+}
+
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
-- 
2.51.0

