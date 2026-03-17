Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24D30E0C0
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764320; cv=fail; b=PZRX1qMhkdATmNH0Kx5XXxv+zo9y4c/ADVlUk5xULglJ5fNhJaaVi7DLHlCcwkmn8PD6IK7lDHmsuSF15d/6OSI9OFXxXZXS7TpYF2sR+/CCF0Abl7X0FRNl5s6t13kY6PiqXaQLeVmbutMN5pbi5YWz6xrusuP5otQSM7Y1O1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764320; c=relaxed/simple;
	bh=JBP+d64DbzRX9NKSsyduxQojC78hnwud7hhIqdrIJvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXjIfB8ZJGozH6pQx8upvw9OkjThBo08EVffnOk1yVnwIFcuJRygolf7IdqUFuxL4A97vGbUCdTEQYnjSTH8dRH2DL8DdC8+hfIFItMOLHQHHiVgyTzZkOZv0t+VecA8sYI0hkeFKPML1m2629BRWbfvkhUczfeD4I6h3vS71Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKK9yMhF; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKK9yMhF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsWgYFnNkTvaybRfTA67DqV49SgRIPV4AOV+x1ux3v7GB9Cna+sf2dCLwmzLHRxKMusJfv8zIxgK65sKWtdQ7nkFYu5VMUlfWxtabQGqCio9UMgwsGXwdAEGntQGCSnQeqAwQsELVLz/mxwnkU3WU1St72amsUCpvLtY3fbKfG/KNn9G3nppWRD+LEvspdXGwL8dZKEsOb/s738lgXmOkOZxgjjNKTk7Hg+OkFIlGyo9OTCT9YuxEa9jAEFxPWSzQe1fD3+7D/a1/3dtswyUxbg6Um1c/JAi2sXx7DwJSbV9Y7XTll6lIvGHM47jJhygH48m2PTSf9k2lc0xuAbUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ifna/X2YIA8r2w6tqjmeBGeFEE7HZ1Dc5amqvGry4M=;
 b=paLI9oHKVkuTzYqV8T9y+srZ4P9LrlPOs/qtU58+aXv+qowPSeQ3SG6xeNlaD59ve1Q2YpGWu1+7muSzLJ8DwFutsPisxJUpl0BR5L9wL7VlIQYSVlxvYG9sni+Te1MWRB6obkpAKF2RebrwBm6H7L4fHQIVU64atgzQAZ0cv83jfwxMjYQfuTrEBE4F9ZnM6b48RW/wSBAtV/3X+DGFzC3xT3++dEIIT6LjqAGHueUz4Qk7DZod7q4amzKbu4YYI0z8Mq3Vgl7uVaP7RurkUWWzUrfIQuYSdj8TkBjQVBDXOTtUAi76CKtRADExvdQE4Sv7ULm3+v7wDS6mYcrtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ifna/X2YIA8r2w6tqjmeBGeFEE7HZ1Dc5amqvGry4M=;
 b=pKK9yMhFNgNAmv+yOfZHLnTPPD5cEilnhsrB6mf9ul9eWMssbk1sXwVhcVxGgmwUWL3ELOHH0uYwVYFA6KJj+vRHuxV7MhH83gMStBhW6+uYe0rTX8g9P2Oc9oqc3vrM/LSk8rvd75A7GO3vjTXqi1Y/RwU+stvRMKEydEMYcgslw1UFlYl0ll2IJCJ7rBeR8wsyzI+noPcZXHj4g3koPvuVv4Umd1bY10+0dFtzrcW03nnqq3geqtCSsyp/x6z6aqHUr2lskd5/X6jTVdatzcuDwEpcfk8B/B64SzBr/DOXcqrEwhpduVWgrcSrplM+8jkyZ5Pap/n3N560Uwi+HA==
Received: from SA1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::26)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:18:33 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::45) by SA1P222CA0024.outlook.office365.com
 (2603:10b6:806:22c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 16:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:18:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 09:18:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 09:18:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 09:18:13 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V2 vfio 1/6] vfio: Define uAPI for re-init initial bytes during the PRE_COPY phase
Date: Tue, 17 Mar 2026 18:17:48 +0200
Message-ID: <20260317161753.18964-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260317161753.18964-1-yishaih@nvidia.com>
References: <20260317161753.18964-1-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c767d16-7863-4c77-f5ac-08de8440d5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yly6zasVfShlAWiirzdcCszuDlygAUNvNaM6EcNr22uw2zeIDx30UosAz0dZEx23aF/aYb3DApXbgSAdBgtK9f2aqon4TZKrj3eZcQP5XIc/nTh/9I1z4RadspnSnUUS3B0uXFeL/6lqseFB3RxSnJXT3SXRNZ8NzwDY+kEAuJ2c9vC+veyE95LmTHB9w7DfzxDh33F6pMosTRPKH+sbI6rIbjMM5qvEAwYzFtzPA1TbVjatvelNVoqoymDVM/gLH6V1+bWs+rGz43shrKBhP0sma6Z71SeBwkQt2dEaP+cbneJqnCLp0+YpZREiv4e2FKx4Tx4L2cCtcgYO4frXM40IPeQhYA0olACz3P3QssEIH9DZ7W+EjAvT/pS6S9X3124vwyO6vuqlsqYoqffsUC16t7Uzicat60/XbpTGjnyOc6eZyArYRmiffbnnyIwl9wJozT3M/LQZ3D9sPhny5taIx3NEbV0ybxtm7ugpPYeNYsyjpa2qFKZolf1UuLOhSS7aV/SkhVXTARchPW6NZjbp22y9RfG+zJNgUL1t8rFM4tSGX18y4aQTkfm+h0ecnmUpGeK/ZjX7KmNfp/E0yFQzGNSz1E+YKOgXNgfyUfWiCYM7362+/OCtateRn7kZ1qTpVweASDF4SD3zu2SIyG8jMw+ly+XCTMoc97cgWnEp5zzaF/k9Io6jMgD78SMCP7iAGRYXbxDVOnm6E8rmEpSb6JkuZaIOvKp25XGoSPwKYOiv5ea+pOlvM8AtClSV7TYFAeyLphPsI80A9BZ+NA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nZ8fkegzFcBW2uCpvyczTVGQNtBtBJ2kX4Z7B1mn1qvEY83hSfwFVvsLsvTNBZC8e2k1j8hBsb+suSG8j6geVNuLdg1n+gabas+uM7BDeDbPy8ueWqLqyFBg0K2YSanI2t/gzxdy4MIaz997Y7A48uDoFnSC4E7Oc8YibbnDCbTlYpAFlXJRDo4JvhDpirSIlXPD/aBJ4ShKJSP7pVbjy/OjcToHw4gUJF6E/uQeK7Wkyydcf2+PG81CXlplq0AW3T4Pabst7dygMtZxGdFrRec5ZU9N7/J+3+FxaolMNGuwqmqqNZV3IDhz03R+xZ3MF2GuROOEqkMbtr3my7QztMRlq7+a9rYkcpaiVGj+KzaeYY+muhZYAksHUsUYfz+2IbdNFlrwSLv7+LDyYLASUhQ74fM3rhxsbhhdx1+8BBWmo8j2P5AdNExz7sbmZ26r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:33.4237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c767d16-7863-4c77-f5ac-08de8440d5ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

As currently defined, initial_bytes is monotonically decreasing and
precedes dirty_bytes when reading from the saving file descriptor.
The transition from initial_bytes to dirty_bytes is unidirectional and
irreversible.

The initial_bytes are considered as critical data that is highly
recommended to be transferred to the target as part of PRE_COPY, without
this data, the PRE_COPY phase would be ineffective.

We come to solve the case when a new chunk of critical data is
introduced during the PRE_COPY phase and the driver would like to report
an entirely new value for the initial_bytes.

For that, we extend the VFIO_MIG_GET_PRECOPY_INFO ioctl with an output
flag named VFIO_PRECOPY_INFO_REINIT to allow drivers reporting a new
initial_bytes value during the PRE_COPY phase.

Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations don't
assign info.flags before copy_to_user(), this effectively echoes
userspace-provided flags back as output, preventing the field from being
used to report new reliable data from the drivers.

Reliable use of the new VFIO_PRECOPY_INFO_REINIT flag requires userspace
to explicitly opt in by enabling the
VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 device feature.

When the caller opts in, the driver may report an entirely new
value for initial_bytes. It may be larger, it may be smaller, it may
include the previous unread initial_bytes, it may discard the previous
unread initial_bytes, up to the driver logic and state.
The presence of the VFIO_PRECOPY_INFO_REINIT output flag set by the
driver indicates that new initial data is present on the stream.

Once the caller sees this flag, the initial_bytes value should be
re-evaluated relative to the readiness state for transition to
STOP_COPY.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 include/uapi/linux/vfio.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index bb7b89330d35..bb4a2df0550d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1266,6 +1266,19 @@ enum vfio_device_mig_state {
  * The initial_bytes field indicates the amount of initial precopy
  * data available from the device. This field should have a non-zero initial
  * value and decrease as migration data is read from the device.
+ * The presence of the VFIO_PRECOPY_INFO_REINIT output flag indicates
+ * that new initial data is present on the stream.
+ * The new initial data may result, for example, from device reconfiguration
+ * during migration that requires additional initialization data.
+ * In that case initial_bytes may report a non-zero value irrespective of
+ * any previously reported values, which progresses towards zero as precopy
+ * data is read from the data stream. dirty_bytes is also reset
+ * to zero and represents the state change of the device relative to the new
+ * initial_bytes.
+ * VFIO_PRECOPY_INFO_REINIT can be reported only after userspace opts in to
+ * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2. Without this opt-in, the flags field
+ * of struct vfio_precopy_info is reserved for bug-compatibility reasons.
+ *
  * It is recommended to leave PRE_COPY for STOP_COPY only after this field
  * reaches zero. Leaving PRE_COPY earlier might make things slower.
  *
@@ -1301,6 +1314,7 @@ enum vfio_device_mig_state {
 struct vfio_precopy_info {
 	__u32 argsz;
 	__u32 flags;
+#define VFIO_PRECOPY_INFO_REINIT (1 << 0) /* output - new initial data is present */
 	__aligned_u64 initial_bytes;
 	__aligned_u64 dirty_bytes;
 };
@@ -1510,6 +1524,16 @@ struct vfio_device_feature_dma_buf {
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };
 
+/*
+ * Enables the migration precopy_info_v2 behaviour.
+ *
+ * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
+ *
+ * On SET, enables the v2 pre_copy_info behaviour, where the
+ * vfio_precopy_info.flags is a valid output field.
+ */
+#define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.18.1

