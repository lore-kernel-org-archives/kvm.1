Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925F3B635E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160898; cv=fail; b=ck0w6FKyaagPhrCU8jNxVIL0BxG5rkpdLlfDCmb049K0qKOkFcImyylu7MOMxFa9yZIw15JqKi90SYXN1uL+gbMeKbO78ZDfZuRD+d62nU4809epd94UfNRl0A1OhOF+RjawKnclmpG6W2MxnKvp2FJK7/jXBPwQu5iZ6hND+Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160898; c=relaxed/simple;
	bh=T4TEdl+5HHL+w9des0apKoRFbjeu3Zk2+MKE34J0Q5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx13SWk8q68s33TNQgT4uhR9WN3YkYe/ery6gea3XZ4JYi7GuQVxtZWta+vYovslU6pGC+y08s70GVeEwmJTcv77ATeNgXY6Q8a6WTMdTjORYsxDjw/ZKKDHyUUGJIztGF2IKVkienI78ZHOhyyHQIMv6VahKZAV7/Pe073Uuog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxeW/T/P; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxeW/T/P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up4og/IMMKVGIUjoCl5FSgZm5kqpC1yU7YaVzzRWm3WEnHNQer1A1zx0Ejr1EZQEJP/blCWZ0mWtqUafqehZH2NxwUj9xBVUcBF7llvvwZjt8QhCFy0FXQDLRDzabpQ8iDpQ3NfQk1ludevtCS3z4J+zFB7e0+SuzRa1yzdUiv5iV3QX4YY0O5TPtaK3K1g4sNlxw6KLmfqlsE3fPnLgt+xUk+sWNWre0GdXwHDbhjWIBzjtgoX2YZ/fAGd6/MJ0QrCljg3Sr2NNjwRalJ82Yk+bvsUxhBxX/EA3NIs/Cx/cvefVWEoL4IfM2dl6wb0tLloIk1N8py0aH/9TOXI0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMwO5lrBCf1qSCFOr0RrOI+d2B28hJuMa6YpJcqsYiU=;
 b=Ekb+sWTmNxcDC/jBbnDAMUKvgfYDQTOFzgOPtUVwdO9g0evWXeS5NIKKAoXUl2EACZYZr/1FpGPYA7ouXGg/O1vw6VhuvB0H2D9KpWnhOHw6Zq5+avPP8y09a+r2/i9lbnc+HWOasMXO9S8/Xxr3s4VP1Mqn8gJ7LihG6ouBLHixZpizVTxbNfcwJWdw2USq08PR/Q4TEqaVsKam0grYfBWll26Dflrh27NuE6OA78rfuJMBpTD67JnsbzYDAFMJTuD4j5knqqs5lvWMO5PwDgbDw64Ktb4KQu4zSzDPK17f3nr0PyUgQOOfdZz7j7zTGA1whhLDa2Bk4JVlPdvowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMwO5lrBCf1qSCFOr0RrOI+d2B28hJuMa6YpJcqsYiU=;
 b=VxeW/T/PB3shnoXtSUSfKK8tgILDrRSVSUms3hby63uzYYIdUIV/Za5d3OdwQ5EhK6GzBcnp6pQ0C2ggLn9Wwo9zMwou5HrFZsztKUniOBko10HEEuR7GVmg0gsCsa29fvAgSbTAZFTebkj607eHjdZLjugNS3HrCCsc6F70EAj5V0xCB+26/NU8DmZu9FlC0Q9C9lhrULxSiKUAksqIrIWrQN+hFL1w7GsNPht7WGc4XMvfYVAORGL0lJpipzmym4ZpIGzG7pt++nK3oSjqYTRWucJc2Wlso6O32pz24NpXX9u+m9mhFtqYl6BDPG/H9/X0JYPbrrZwrZMqk+k6ag==
Received: from SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::24)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:41:32 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::70) by SN7P222CA0026.outlook.office365.com
 (2603:10b6:806:124::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 16:41:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 09:41:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 10 Mar 2026 09:41:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 09:41:05 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V1 vfio 5/6] vfio/mlx5: consider inflight SAVE during PRE_COPY
Date: Tue, 10 Mar 2026 18:40:05 +0200
Message-ID: <20260310164006.4020-6-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260310164006.4020-1-yishaih@nvidia.com>
References: <20260310164006.4020-1-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0800a40e-f105-481b-90cc-08de7ec3e263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ykIXDrYvUpXyclbBJB2rpTtRKTho3Dl2OF2dIcUS4sFRXb6i/Ticdfd2FRsqDH/lJPeymuLRkKvpcTumBvmlPg3xAxxjzU8WuImBFka1WR1jL509mx7aM3et75IGk3iBVYhIIoSCccQNneuKjeh+08L7hyVbfwLyadQYBmPvzrBVt70hmj3pGxvzHje9BALAYNDqQAIVPYFXEajSBM5zRLEAskDjD3yiqbb608FTNJe7T4oKVsyRjvhzvjvJVZWBJnaJNPHjxRrwrNZs/nlRfL0CCyhpzkiltr6TF3TPXAhJiDHdf1SgvRV8YWHT7NshniGbky0xwZSBn6ZHOgsg7UgYwLNu5urnw3uoJuuOvi9s6hKzUSxSdVlxevr5Q0hJDhs9KuZ6H7v0+TIQyMSfH+kWQUkcKpJdE8i3pgMdZMNrLqI2xv+j8w6aIRc1BFxuAwYZ3RRRAq62m5TBRE92vqrYO1YuGwCrTCKJze3K5ewPlqBI3OKql+uEfs9Y36tnVuWUMYPXAPLVgFHCoqvrq8PI8YRUQbg5RxPXmkK8iQeCJ4g+d/gSosczez04chRGhMqJbhnfrQk3IVM/BYS1QIYPbooqjjPalBPelxDl00e3yNo9SnNjXAF0sPE+9U/HgU7VKlqZGikqnj7uATHJM34eM4YW/hHB+Rq6btI0qewbO28j3dccT13Ys+B8aAtZpkDzYxNhlEjJxCA9NI6gQ6jglFk0ewSg5HyPoaEHAyWUxQeh9XPJUnDGelGM5Vu8NJPXWjSg9Ne4ahVV31XCFQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+8OxOfaDxgi46se25/CSOK1d823XFYguOdM1zmAEqwfFsGXGct8NVVUigZS4L6UsuL4obhJV1XAAgMSp1UP0x1ajdO0C/Sf1c5cTL8xy434c6F6SbQekru2gc/UzKcC7NwN1Id0CNMVVJ3cUkVnW/MH8ftXDDknEa0+Yxuaj3cfeMuuvi1N+8mwzy0Y7Sj47lHsGueAGAgIzyPLbqB028iJjp2qjJg2Gh96Q17VBhbm/WYmxHjc4A7dLgGM9a+VP3gE1IUFD/+vfGvz3NhL7O8XHHkDYNQZ6zsg34j1OAu/RURFDdQkQ8fIQBRuonnTToQTcR2bAMquVhw9+pENE2ujQyzQKptz6fohS9Im4sTzizNTeoW7iFC/nbw9mgu4M6uGjZ36P8UXnMdLDlxqhnCg572dveH/D0kFq0ilgh1Ft8tjG+T6kbduRHA6wq0BI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:41:31.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0800a40e-f105-481b-90cc-08de7ec3e263
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505

Consider an inflight SAVE operation during the PRE_COPY phase, so the
caller will wait when no data is currently available but is expected
to arrive.

This enables a follow-up patch to avoid returning -ENOMSG while a new
*initial_bytes* chunk is still pending from an asynchronous SAVE command
issued by the VFIO_MIG_GET_PRECOPY_INFO ioctl.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c  | 5 +++++
 drivers/vfio/pci/mlx5/cmd.h  | 1 +
 drivers/vfio/pci/mlx5/main.c | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index ca6d95f293cd..18b8d8594070 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -606,6 +606,8 @@ static void
 mlx5vf_save_callback_complete(struct mlx5_vf_migration_file *migf,
 			      struct mlx5vf_async_data *async_data)
 {
+	migf->inflight_save = 0;
+	wake_up_interruptible(&migf->poll_wait);
 	kvfree(async_data->out);
 	complete(&migf->save_comp);
 	fput(migf->filp);
@@ -809,6 +811,7 @@ int mlx5vf_cmd_save_vhca_state(struct mlx5vf_pci_core_device *mvdev,
 
 	async_data->header_buf = header_buf;
 	get_file(migf->filp);
+	migf->inflight_save = 1;
 	err = mlx5_cmd_exec_cb(&migf->async_ctx, in, sizeof(in),
 			       async_data->out,
 			       out_size, mlx5vf_save_callback,
@@ -819,6 +822,8 @@ int mlx5vf_cmd_save_vhca_state(struct mlx5vf_pci_core_device *mvdev,
 	return 0;
 
 err_exec:
+	migf->inflight_save = 0;
+	wake_up_interruptible(&migf->poll_wait);
 	if (header_buf)
 		mlx5vf_put_data_buffer(header_buf);
 	fput(migf->filp);
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index d7821b5ca772..7d2c10be2e60 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -111,6 +111,7 @@ struct mlx5_vf_migration_file {
 	struct completion save_comp;
 	struct mlx5_async_ctx async_ctx;
 	struct mlx5vf_async_data async_data;
+	u8 inflight_save:1;
 };
 
 struct mlx5_vhca_cq_buf {
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index fb541c17c712..68e051c48d40 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -179,7 +179,8 @@ static ssize_t mlx5vf_save_read(struct file *filp, char __user *buf, size_t len,
 				!list_empty(&migf->buf_list) ||
 				migf->state == MLX5_MIGF_STATE_ERROR ||
 				migf->state == MLX5_MIGF_STATE_PRE_COPY_ERROR ||
-				migf->state == MLX5_MIGF_STATE_PRE_COPY ||
+				(migf->state == MLX5_MIGF_STATE_PRE_COPY &&
+				 !migf->inflight_save) ||
 				migf->state == MLX5_MIGF_STATE_COMPLETE))
 			return -ERESTARTSYS;
 	}
-- 
2.18.1

