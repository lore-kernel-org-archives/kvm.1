Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBE3B28D
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764346; cv=fail; b=ljaTaHfpMAcdnwNs+0AjLnFpiLSveKGVMsxj9urXelDbqBcUcrJXmHDJyi0XqwGPv+YUwVA5sJDcs88unDoznfAdLNH7RX4WgKAa/n+ygVoiIYkS03lKo1DQDpO9WGpXYzymOiDkxQBeFaX8bUl0rCXK8SsALJ56OiuWDxBHp6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764346; c=relaxed/simple;
	bh=XIl/9uCkEd52LMRVhUjPTQnvKnvf3paMc63ydizaXmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVDaOZPXKZFunYRjaHf2Ojj27QUXruP03cHMYHki+NBoRynO3HoqV1SIXNuszp6u/B8PRmjm4Zim+7brSwz07yRoSr/R6mZ/RR/4bDuORSQduGVZsIXx/NFPVjjaJ52SMeuyq0/nPkfvM/NIv0pAx07KRzKPH8ovGzXCXig6A88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ukiy/lKG; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ukiy/lKG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4BJgTQcu9p65gCvp/gwkSmStPSGWlXa+oPmFyR7ZNv8cxh0FV7slc45DXRul+tlsRXFwbzn005o1yA7znp0Rt6YU0c4P5pt/wLpF6dSMKKa7UImuV1sQBmgtHo6krNsnhy7zpOK+KgGXRyCiQA53rvKnH31pBjV/PbA1xhU3Nm6PSYVKwTsAdg7PADNr/0rbBsXNlnpKbbaB01NptCNnhtr2e/Iggd9UjiaVDPRzzCvmbyERfWLSQOZ+/zjHmQg9ybnri9YeRV/6hx2AVKTkZjGS1FCOvjvZfcpsWhxlcgMduFbPD83PRPKj6S5WJ1AvtMAO+TSoOZD6lGV4Aq3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I46VlMJYnWKTnK67ymkcrnUnV5Js3wXdc/WafTdT1RQ=;
 b=r1pfNZEslj1HoSoFqlfFRcdDnHZvfecNZRjqCVurRsp4a7pN2/hdpvjU+DgqsHb/nadYs3c+aPRDiZWIrkZ38djXypaawkG+Uor22QUNTyHJGJezWG0kHd/Y3XjoKHgLwmt06ope/nQp7NSTEwlNiCJ/Tn/9Qh9iw9E38wbrqCEpsDNN9RGeypLEowEDhRZwHldxFraWCnrqvYn1YX345D32fWZihSVoPrIfnjm0DMCJ8vGobJYfBvkFFnB6Gh/26NMo5GtMomZ+yPHuvq8+p+V+btudzNWVyKNfzpxPeIgeH+99jC3yAoIv/LTCOVBUMOs+M0x3u5kKrdQ+z2NrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I46VlMJYnWKTnK67ymkcrnUnV5Js3wXdc/WafTdT1RQ=;
 b=Ukiy/lKGB6nclXjA7n7GhPnE+H6atZVpVgI17biZu9W+HOUn+DsYAVNeIddUm0jU6V5XwRi4k9B0y8Au3UHPGs5Z/mzDNWx/JIjtaueJKToerz1fsn+GUrRXm5ya5wEFHbuMUwsmHWPb4cmzHn0zfrC9o8i8lsjZMDvdyUZnaPqGNg2VWWGtaAbfoNlkWl8ZqHiIOmccpGWOrYQY2ej7nMr8tHGOZ202paKgw7Ls70muZrvY+HHGOeolx1/q1w1UBBnG8hyJFcsZs2GHafmM8ZwlepCHDEkVxHhSvd8DvOgHve9qpN7j3QS8Vrno4mk4CLyfA6V75MPPDlmsltCi4g==
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:18:56 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::34) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 16:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:18:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 09:18:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 09:18:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 09:18:31 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V2 vfio 6/6] vfio/mlx5: Add REINIT support to VFIO_MIG_GET_PRECOPY_INFO
Date: Tue, 17 Mar 2026 18:17:53 +0200
Message-ID: <20260317161753.18964-7-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8950a2e5-0765-494d-843b-08de8440e1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JWV1g8kUKWTs0Fil3zLZ6BIwT5rfQod3DG+QC21yUMxKXjz2GmvJKt1kGeTGERfGPdz2V5BOrtmSFUXIb4NJUWzDPRTSsIuVr5zedlJLFGCWboCB2+8rD+q/AiGFz6lpnURrcf5WIWSVbxxWyHL27vO56ku6flf45c4ilrkeiwVVSLpvlVF8Hb8TN55oWWjC6r77GHyNq0qT0OTREV20+f+it++a3yspu2nYw1eJbSCcgbpeqeq+H21OBuPHSf4h7XovK5IxJ7Mo/+CbijxTgdXJ7YMnHoSWFbgE0E0qY6dV9PeLipngcOl6V17iZCwDklGXuh9vXPX8yqVgrumnLfT7S/c2PN60DKzAbTXUJzFNVgoAWZd6fgvFQ/kZ19yNrnuKUedm9J/2mTaUswksKJZa9uvshjJD/3bv+PNsiop/raluitXbwQ2aPE0G3KHxxEJ/L+BwsnDU5AJ1zUS/7S8I50G8JXqzdQ8bpfxvzJceDMBBMlFseQ33/qojKtgD31gASv0jFdNOSLs+lG2hSoX7H9vXn1o8SQjIZGaTD4Yr8cpbHYn+Y1oNcTk1/fsUGgB0VN5SkHWTAPq1ZiNIGuis1bji9jwYqJAMOYE3GHX0YJzUJMZdQeVshJeN7ogBaO/Yg2H0WDsAVyk1s4PNQYLnMmv+nX1wtLOo/9eW0w5fDydKU41LIIReUPdxRPLuhmfpq36dOEKEbqbRns5EQT5pSALXuMjf3fT6DtkBigxL7AUCzTIxLIfqhFflJ5HNwa+M3KLX6GvTRsuKWyp/Xg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8u+GI388pxzm2dvKc2QkzkkSBTkUVjw9uckkTA0wuqsM6uuTS5vIEbl+VAlHUIRIdotegoc9uo+lrYXMk5vZsP2PkbQ/vvL49og2SjltIYp/KlPftmL67sw8I3PHjklLt8mXl82DvtIbEWp/McxM8adLWkqS/WuihAFxTMxWxrjNGArML97kJwXWtLiYRkA9rkfRPKvyeozt4Re1q6UmPjtfXx8f5Lg625gC3cd+wNLmwhmvo5n3Vnb77l1jOazGxWiazxXgpZuuKjbC2+zeFdK1kxZq26UEPRjNd9zldK9lHuKDTv4eyq+yD9+T3N7BSDPzvpqiP10EkFLKwCFvRA1I7OZwsydliaNC9GRATQf+WNQscbgjugbInLK+4wX+rtxQGupLmTrKq2Acua+/uDKRCGFPLczwelcZxYufV1WYjKMTVcV/XNpgrTLJ10JP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:53.2773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8950a2e5-0765-494d-843b-08de8440e1d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

When userspace opts into VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2, the
driver may report the VFIO_PRECOPY_INFO_REINIT output flag in response
to the VFIO_MIG_GET_PRECOPY_INFO ioctl, along with a new initial_bytes
value.

The presence of the VFIO_PRECOPY_INFO_REINIT flag indicates to the
caller that new initial data is available in the migration stream.

If the firmware reports a new initial-data chunk, any previously dirty
bytes in memory are treated as initial bytes, since the caller must read
both sets before reaching the end of the initial-data region.

In this case, the driver issues a new SAVE command to fetch the data and
prepare it for a subsequent read() from userspace.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c  | 20 ++++++--
 drivers/vfio/pci/mlx5/cmd.h  |  5 +-
 drivers/vfio/pci/mlx5/main.c | 97 +++++++++++++++++++++++-------------
 3 files changed, 83 insertions(+), 39 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 18b8d8594070..5fe0621b5fbd 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -87,7 +87,7 @@ int mlx5vf_cmd_resume_vhca(struct mlx5vf_pci_core_device *mvdev, u16 op_mod)
 
 int mlx5vf_cmd_query_vhca_migration_state(struct mlx5vf_pci_core_device *mvdev,
 					  size_t *state_size, u64 *total_size,
-					  u8 query_flags)
+					  u8 *mig_state, u8 query_flags)
 {
 	u32 out[MLX5_ST_SZ_DW(query_vhca_migration_state_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(query_vhca_migration_state_in)] = {};
@@ -152,6 +152,10 @@ int mlx5vf_cmd_query_vhca_migration_state(struct mlx5vf_pci_core_device *mvdev,
 			MLX5_GET64(query_vhca_migration_state_out, out,
 				   remaining_total_size) : *state_size;
 
+	if (mig_state && mvdev->mig_state_cap)
+		*mig_state = MLX5_GET(query_vhca_migration_state_out, out,
+				      migration_state);
+
 	return 0;
 }
 
@@ -277,6 +281,9 @@ void mlx5vf_cmd_set_migratable(struct mlx5vf_pci_core_device *mvdev,
 	if (MLX5_CAP_GEN_2(mvdev->mdev, migration_in_chunks))
 		mvdev->chunk_mode = 1;
 
+	if (MLX5_CAP_GEN_2(mvdev->mdev, migration_state))
+		mvdev->mig_state_cap = 1;
+
 end:
 	mlx5_vf_put_core_dev(mvdev->mdev);
 }
@@ -555,6 +562,7 @@ void mlx5vf_put_data_buffer(struct mlx5_vhca_data_buffer *buf)
 {
 	spin_lock_irq(&buf->migf->list_lock);
 	buf->stop_copy_chunk_num = 0;
+	buf->pre_copy_init_bytes_chunk = false;
 	list_add_tail(&buf->buf_elm, &buf->migf->avail_list);
 	spin_unlock_irq(&buf->migf->list_lock);
 }
@@ -689,7 +697,8 @@ static void mlx5vf_save_callback(int status, struct mlx5_async_work *context)
 				!next_required_umem_size;
 		if (async_data->header_buf) {
 			status = add_buf_header(async_data->header_buf, image_size,
-						initial_pre_copy);
+						initial_pre_copy ||
+						async_data->buf->pre_copy_init_bytes_chunk);
 			if (status)
 				goto err;
 		}
@@ -708,9 +717,12 @@ static void mlx5vf_save_callback(int status, struct mlx5_async_work *context)
 			}
 		}
 		spin_unlock_irqrestore(&migf->list_lock, flags);
-		if (initial_pre_copy) {
+		if (initial_pre_copy || async_data->buf->pre_copy_init_bytes_chunk) {
 			migf->pre_copy_initial_bytes += image_size;
-			migf->state = MLX5_MIGF_STATE_PRE_COPY;
+			if (initial_pre_copy)
+				migf->state = MLX5_MIGF_STATE_PRE_COPY;
+			if (async_data->buf->pre_copy_init_bytes_chunk)
+				async_data->buf->pre_copy_init_bytes_chunk = false;
 		}
 		if (stop_copy_last_chunk)
 			migf->state = MLX5_MIGF_STATE_COMPLETE;
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 7d2c10be2e60..deed0f132f39 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -62,6 +62,7 @@ struct mlx5_vhca_data_buffer {
 	u32 *mkey_in;
 	enum dma_data_direction dma_dir;
 	u8 stop_copy_chunk_num;
+	bool pre_copy_init_bytes_chunk;
 	struct list_head buf_elm;
 	struct mlx5_vf_migration_file *migf;
 };
@@ -97,6 +98,7 @@ struct mlx5_vf_migration_file {
 	u32 record_tag;
 	u64 stop_copy_prep_size;
 	u64 pre_copy_initial_bytes;
+	u64 pre_copy_initial_bytes_start;
 	size_t next_required_umem_size;
 	u8 num_ready_chunks;
 	/* Upon chunk mode preserve another set of buffers for stop_copy phase */
@@ -175,6 +177,7 @@ struct mlx5vf_pci_core_device {
 	u8 mdev_detach:1;
 	u8 log_active:1;
 	u8 chunk_mode:1;
+	u8 mig_state_cap:1;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
@@ -199,7 +202,7 @@ int mlx5vf_cmd_suspend_vhca(struct mlx5vf_pci_core_device *mvdev, u16 op_mod);
 int mlx5vf_cmd_resume_vhca(struct mlx5vf_pci_core_device *mvdev, u16 op_mod);
 int mlx5vf_cmd_query_vhca_migration_state(struct mlx5vf_pci_core_device *mvdev,
 					  size_t *state_size, u64 *total_size,
-					  u8 query_flags);
+					  u8 *migration_state, u8 query_flags);
 void mlx5vf_cmd_set_migratable(struct mlx5vf_pci_core_device *mvdev,
 			       const struct vfio_migration_ops *mig_ops,
 			       const struct vfio_log_ops *log_ops);
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 68e051c48d40..de306dee1d1a 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -464,8 +464,10 @@ static long mlx5vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 	struct mlx5_vhca_data_buffer *buf;
 	struct vfio_precopy_info info = {};
 	loff_t *pos = &filp->f_pos;
+	u8 migration_state = 0;
 	size_t inc_length = 0;
-	bool end_of_data = false;
+	bool reinit_state;
+	bool end_of_data;
 	int ret;
 
 	ret = vfio_check_precopy_ioctl(&mvdev->core_device.vdev, cmd, arg,
@@ -492,7 +494,8 @@ static long mlx5vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 		 * As so, the other code below is safe with the proper locks.
 		 */
 		ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &inc_length,
-							    NULL, MLX5VF_QUERY_INC);
+							    NULL, &migration_state,
+							    MLX5VF_QUERY_INC);
 		if (ret)
 			goto err_state_unlock;
 	}
@@ -503,41 +506,67 @@ static long mlx5vf_precopy_ioctl(struct file *filp, unsigned int cmd,
 		goto err_migf_unlock;
 	}
 
-	if (migf->pre_copy_initial_bytes > *pos) {
-		info.initial_bytes = migf->pre_copy_initial_bytes - *pos;
+	/*
+	 * opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 serves
+	 * as opt-in for VFIO_PRECOPY_INFO_REINIT as well
+	 */
+	reinit_state = mvdev->core_device.vdev.precopy_info_v2 &&
+			migration_state == MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_INIT;
+	end_of_data = !(migf->max_pos - *pos);
+	if (reinit_state) {
+		/*
+		 * Any bytes already present in memory are treated as initial
+		 * bytes, since the caller is required to read them before
+		 * reaching the new initial-bytes region.
+		 */
+		migf->pre_copy_initial_bytes_start = *pos;
+		migf->pre_copy_initial_bytes = migf->max_pos - *pos;
+		info.initial_bytes = migf->pre_copy_initial_bytes + inc_length;
+		info.flags |= VFIO_PRECOPY_INFO_REINIT;
 	} else {
-		info.dirty_bytes = migf->max_pos - *pos;
-		if (!info.dirty_bytes)
-			end_of_data = true;
-		info.dirty_bytes += inc_length;
+		if (migf->pre_copy_initial_bytes_start +
+		    migf->pre_copy_initial_bytes > *pos) {
+			WARN_ON_ONCE(end_of_data);
+			info.initial_bytes = migf->pre_copy_initial_bytes_start +
+				migf->pre_copy_initial_bytes - *pos;
+		} else {
+			info.dirty_bytes = (migf->max_pos - *pos) + inc_length;
+		}
 	}
+	mutex_unlock(&migf->lock);
 
-	if (!end_of_data || !inc_length) {
-		mutex_unlock(&migf->lock);
-		goto done;
-	}
+	if ((reinit_state || end_of_data) && inc_length) {
+		/*
+		 * In case we finished transferring the current state and the
+		 * device has a dirty state, or that the device has a new init
+		 * state, save a new state to be ready for.
+		 */
+		buf = mlx5vf_get_data_buffer(migf, DIV_ROUND_UP(inc_length, PAGE_SIZE),
+					     DMA_FROM_DEVICE);
+		if (IS_ERR(buf)) {
+			ret = PTR_ERR(buf);
+			mlx5vf_mark_err(migf);
+			goto err_state_unlock;
+		}
 
-	mutex_unlock(&migf->lock);
-	/*
-	 * We finished transferring the current state and the device has a
-	 * dirty state, save a new state to be ready for.
-	 */
-	buf = mlx5vf_get_data_buffer(migf, DIV_ROUND_UP(inc_length, PAGE_SIZE),
-				     DMA_FROM_DEVICE);
-	if (IS_ERR(buf)) {
-		ret = PTR_ERR(buf);
-		mlx5vf_mark_err(migf);
-		goto err_state_unlock;
-	}
+		buf->pre_copy_init_bytes_chunk = reinit_state;
+		ret = mlx5vf_cmd_save_vhca_state(mvdev, migf, buf, true, true);
+		if (ret) {
+			mlx5vf_mark_err(migf);
+			mlx5vf_put_data_buffer(buf);
+			goto err_state_unlock;
+		}
 
-	ret = mlx5vf_cmd_save_vhca_state(mvdev, migf, buf, true, true);
-	if (ret) {
-		mlx5vf_mark_err(migf);
-		mlx5vf_put_data_buffer(buf);
-		goto err_state_unlock;
+		/*
+		 * SAVE appends a header record via add_buf_header(),
+		 * let's account it as well.
+		 */
+		if (reinit_state)
+			info.initial_bytes += sizeof(struct mlx5_vf_migration_header);
+		else
+			info.dirty_bytes += sizeof(struct mlx5_vf_migration_header);
 	}
 
-done:
 	mlx5vf_state_mutex_unlock(mvdev);
 	if (copy_to_user((void __user *)arg, &info,
 			 offsetofend(struct vfio_precopy_info, dirty_bytes)))
@@ -570,7 +599,7 @@ static int mlx5vf_pci_save_device_inc_data(struct mlx5vf_pci_core_device *mvdev)
 	if (migf->state == MLX5_MIGF_STATE_ERROR)
 		return -ENODEV;
 
-	ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &length, NULL,
+	ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &length, NULL, NULL,
 				MLX5VF_QUERY_INC | MLX5VF_QUERY_FINAL);
 	if (ret)
 		goto err;
@@ -636,7 +665,7 @@ mlx5vf_pci_save_device_data(struct mlx5vf_pci_core_device *mvdev, bool track)
 	if (ret)
 		goto out;
 
-	ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &length, &full_size, 0);
+	ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &length, &full_size, NULL, 0);
 	if (ret)
 		goto out_pd;
 
@@ -1123,7 +1152,7 @@ mlx5vf_pci_step_device_state_locked(struct mlx5vf_pci_core_device *mvdev,
 		enum mlx5_vf_migf_state state;
 		size_t size;
 
-		ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &size, NULL,
+		ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &size, NULL, NULL,
 					MLX5VF_QUERY_INC | MLX5VF_QUERY_CLEANUP);
 		if (ret)
 			return ERR_PTR(ret);
@@ -1248,7 +1277,7 @@ static int mlx5vf_pci_get_data_size(struct vfio_device *vdev,
 
 	mutex_lock(&mvdev->state_mutex);
 	ret = mlx5vf_cmd_query_vhca_migration_state(mvdev, &state_size,
-						    &total_size, 0);
+						    &total_size, NULL, 0);
 	if (!ret)
 		*stop_copy_length = total_size;
 	mlx5vf_state_mutex_unlock(mvdev);
-- 
2.18.1

