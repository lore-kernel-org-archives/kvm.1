Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6830C37C
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764336; cv=fail; b=XIEgU8SScwAtXQG+igyVjLTIdgkgzbDJQl4tGzlqrVpdj0rdX1yqEQ2Qo8YNmUSDrAMlnWWE2bDIYK0rEBvQVA9/1YSxrt7Ydky7dmSdQMp4DoSD361IExGo0LpBrAgr9YOQB7qBzPL/bPPOZAHBLpArwjXBs4NPmIka9szpykg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764336; c=relaxed/simple;
	bh=T4TEdl+5HHL+w9des0apKoRFbjeu3Zk2+MKE34J0Q5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KohxKVOvfAFtZhWETlLKdalrBD/jGU0WvQQmR5KDv92ITQ5jkFSJklNzQXEhQsYzd03exlN48gnrt9INsXQxWupDuBjFQpmeZIRUDC6ioSWUvs8J5ek9Jdv29rWYPequcf7QlG+hWXshSf9K1XPWuH+uu7FlNhN6VBSikqY1ac8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yjzn95SY; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yjzn95SY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuZxRIPOVcS8Duf6AIZcS2eI4f5w2GtypPHYiAsXEHVQk6Yt9Vfzls1DPrbh3CAW4HzMHmWn8XP7lyUsOf9XY5YS+Fz+A5Ir0gSAWqMzY7/dJp5bPQ8mnmbZoy3qu9zyjJoEX3pjzbFalIyqhG9WDXeK12a/lHytJzzMtRmDcCxwVcyrUF0ZQuloDCW9jCt0MC9+3j89nFSd8wT6UFx10Fymz+NXT+ENMhHRrFj7yEw113rQOhf4+ijvR3hsjzY0UVYX0k6YUvy1MTyMA30TiOVAgpNuKjg7cGJEwt1gmmstbuGiAcRMia5ZAYRaI3fPMXQYwElRbDXUvu6Z8Paz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMwO5lrBCf1qSCFOr0RrOI+d2B28hJuMa6YpJcqsYiU=;
 b=AR1r+3f8joKePnbkeWf0Mm1ep+WE6wt/K56GwliMIayEplP/zJVc/YS+RzQBzPguqxT//A0zsX/oSIybTgCVX4BFRiHzx9fFktbavI1Oe0i19A2E1nDZZXUec86/PaeVgq0XwqT7L2EppRY9+bDYdgqkm4EXIW4vVmNRlryWHEmkHTImKlOdK5sSpaD3++YbrpIkYQhpVH2+DY74wzoQIQ4NLPrny6IINoExYfqXSpcI6GMDieDzgWVWqwo/Sp+4ik+Eyc7XX8kq+scfVhjLDRWriCrZ7bcWD4lAVbveQlrGk5lesaTLNnnGCk4A2zZkiAh8pcO4v0+wakjaf56kCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMwO5lrBCf1qSCFOr0RrOI+d2B28hJuMa6YpJcqsYiU=;
 b=Yjzn95SYhiCNb+FsurPot+5eU3Qpt/VhkyLez47ucynU289Omgud/a1GqG+y7GWbqGA0PNNlooXkt7OGPFaBaStHSnx08SFsuirVNZpxlWcjldzytxwSQXw/aQfMsneNCzSlbwXgOnMGXNHRo7NKeFtR94LBCNDaKmuu71HR4bTH575QA0WG+SWh2RREwzMDC1YoLnOxAFCQgyYsiPzgG0te3DbLCsEuTc8rZvmpLQyEUi1c/2lcU2PNWBeXMjFejU8cWMkTMTKGGXG2LWdoTGJgpdYbLeA0xqMfGzk4JQZRdOGRkXRN7Ko5CAbGAD3erDpWMn7rZF/fSdyPPsMFZQ==
Received: from SA0PR11CA0163.namprd11.prod.outlook.com (2603:10b6:806:1bb::18)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 16:18:48 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::af) by SA0PR11CA0163.outlook.office365.com
 (2603:10b6:806:1bb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 16:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:18:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 09:18:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 09:18:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 09:18:28 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V2 vfio 5/6] vfio/mlx5: consider inflight SAVE during PRE_COPY
Date: Tue, 17 Mar 2026 18:17:52 +0200
Message-ID: <20260317161753.18964-6-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 182a17c8-e74b-4bc8-c42e-08de8440debf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Rh71xWMDV6jH3Xjex3itQBczeWa3TbDekzBlcRyktwFGyxDbXJC7Vathkar4LE6wRyKQmkskWRYe/HlC3LNXcZv2wrcXb7LBx8zpbXsmLpJV5QMRaB3r86OEj5SIl7Dyrh4yzOckb7GA0XnI8BqZx43jsgrUpSYoDmkFqrAg11BhIO3VToQ0mitfBlOzuWx7rFOnkUvY3v1yC5h0egfUCMEGqLTpdLTu1AJf8bi5qV1McUULo/0IY+JF2iT25GMIJXWSugBKhSmfzkN4dUsgWHasbZemQsOuflLuJKpd31ob53rBfNUS76pRm67Z0htbqUPcYMKyjj/DmsBN2qsVT1zKMa3uH2uCEABQbvKsG9R0wKAYcxYVI4F6zLdQF2wLAcK7GAlaqq46p2UXHN2I9QVb8C1HueTnIB3fXNdv972xIbxh+Suysu33xQ+vzhJkbb5aWArIpg8eNKpVxN9+e397p/tL1k9ZLgQgEsj2svdXIOI4yuluK7ASuWcz7RTto+fP5Ypt85jv4jdrs1es67FpDF84Wth10iKBbfFVGSHL+upQpDS9kAvYAGBqSdfGtMFh4PdWoX+OK1ebufIkqtpzDlS0ZinkqtuYa4cYlK0KyKk+hmIBJFDwR+QLHkpn+GB00lKYuVwZ2Z4UjoNzM3n9RWX5cHRfL0qkXDxRW4+0uQVM/OQjKEiemyDCr++hWeaWhLWIU8s+1SMYDhZQ8/rGTJBblXVnIQfyJZCe96zP3Y53DvA3wAoZLWSHszDtF78iuXDGzz1NLhX3ffuHHg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vyq1Nun9+zNCET2WKug3NWam/DNUBaWbpgFptAi/LtJveWn6a63JDrJGMg7480hbR4SfOMjgzhh2TaoleLOS0Z6pxmRpr+Lq3Jh/kuMnTMxKN3PHPGMAXihZfjNRtrjN8v9HK9d4/LWBf0q/kgdtYmkvjhsEAIblCT+I12IAfTjFjSzOgVwtirQ4uLoa/8dh6mBt8LPN+hcBK8exhQRXBT2FaweCeW4e6gPxG0aEvW6qGhlAQJ059lViGyiz81TjxRRnWvaLD/SgfBx+bVWcWd3OP010bQEFJt7t7HkIKHpkO7Q6w6eJ1bQODPOaRagfF98l3uKPvPWkSxb96BqDPJ5gt+0ry74/EHZa+Frsk1Ir35ENtedZtpYQ12Ghn8XSYh7J/yCrpiwxGnMRLVbqNWAVo2V3oc2eai6J8Mo/7aZsl8tZa95sjRW9Moz40HE7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:48.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182a17c8-e74b-4bc8-c42e-08de8440debf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

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

