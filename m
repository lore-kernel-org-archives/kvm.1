Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF72F25F3
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764336; cv=fail; b=TBmO/6BDHc71leZ6v9DJzt5raLXX5piTzGfx/p9v9F7oWjcSF6TQ7anWnU44EGKhf00phxgKbhSu36J8lHRtaxUjPrksBAQCOd1KqKj6f2cwSZGwFqpBk1hUJqndTzqAdUxu5xoui8ljYGKLC9vyLm0EkUSl2RFUyXSYDgbZHJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764336; c=relaxed/simple;
	bh=AkzlrcPM0cju9otixYf8GDK/gg6rPSQH3/blI70KIjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXNZAhDFgBJAhx8cvYjAPyWS/xS1EXVRNpIXuTiuUlsDnIbCvJJEKm8vghN9TaQHba+rrIlh42SCtKkNEX5LjIAGpH+dKSGJtMSV4OksrS+zA57l2vqwunmewhQoiGc6Ue0503KiBuCjzckm3OwNoMPdGhAs9sBN2/hs4jCR2L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0w32RXk; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0w32RXk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBhsOldL5aI3h2tmIwBROQjRuDbFk+yZSP8nji5pTzyoql1G175TbfnDkCRDWZ/M9E+R6gIVpLSGiuA3vDZfokSM3RcUoOuK/ma53isWVQdNYxai4/YQ4QcTAyFeG+p4EdDg0DD588G3evNBNV+qeKb0f/lLuwWixzSJ7vyZ0FU0ZRichQZB+tcX5E0w639cbRVUkzljqwEKmZi2EiL3xDLL+ZEnvjLvl+YblW8RTZ1YcSCPnF8CPDOFiXlB8nAm2NyNaNZgFbdLYWSCAZCR45xcbiqd6BvqEqXqOTp/PTPUz1T+kx+juFRr4TE6VqnuaCp9nZS3cvRvmX/1r9kCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PsgkAPD7bopNVkBU8kxxWc0dnm/RYb+2mn8564OmtI=;
 b=LV91mPs559X4zBbLeZCuXivpt8QBFpUqZqQgqBo2IcBX6d9qiH0iV6iVWecnPpjUK70MoGuqoHxyVRto/q1WBVxlqy6nOEjxbYihHwYU1soGpZiXJJZwKxb2IFIb7DZAUUZDgZkqi/DZ2nsn1zkQorGnm163UsHmu02zZ0xrXnnL8pCU+hlYrt1NdpV4gXh0robNXtqWyVaJydD+Ml4idfdu0Rs2xjx6VwkY+IunTNLj8tQiUoaR2NK8pwA11on6LkEPbKLJ10GOa7oFn9WvoVkcm8Mccw0SkLVe09SGaCje/52hQMepwN5VkcGmr4vNbFY4BeAwVC59cYXph3EHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PsgkAPD7bopNVkBU8kxxWc0dnm/RYb+2mn8564OmtI=;
 b=U0w32RXktx+qqQHrERhmLjTg8gDnwiJLPrU2RAOTn5Mf0OkL9iUGu51fS2Q+wSS+i4lLrIPFVLdxNJCn/R3nXvq2K0UJub2b5BJkFsBJliZ20gW6NZewqNLl4Y4ax4HGad2V/NgGfv3P4obfxA8QtzWxqx43PSZ0jgEQZ8bHWJDpWANraSeySVWkFSqnXtAPU6elRaoZIGlmqPvi84wBedNpggfSM9Im8qXsll/7UNYUB38i/FDvaoEmhlo8BiIVmvSh0HJWLjHfUi3WSvC8J5j7V4MAGGlC0ykFjo/kxW6QTG804wCCaZ5xyKN4EJath/WP5qnI12jzF6GZSmAM5g==
Received: from BN0PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:143::10)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 16:18:48 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::50) by BN0PR10CA0012.outlook.office365.com
 (2603:10b6:408:143::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 16:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:18:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 09:18:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 09:18:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 09:18:24 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V2 vfio 4/6] net/mlx5: Add IFC bits for migration state
Date: Tue, 17 Mar 2026 18:17:51 +0200
Message-ID: <20260317161753.18964-5-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc77d05-46fa-499b-ab28-08de8440ded7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8Quqgs0LK5w5wjs3M+9BQOm6ebbwOL7AkP/Rjz/0Nn2MmHypL4hXOT/sO0s6Fyiy9pq3arYFGhOVIoE9lnjCxN3RxTsWf6rCIwhfFbH9C2sEgkCgE58R3zReka+WiyiViY80tuaY0vzZXi7RaK10ERHUszEg2Ws6jx6NLAEmjwtYtVWxrMOnA2yeQscfuuP46GLYSG6m0BUnMSY7eMIDuCxra5Nh2jjXqudQRb2KEn8/bUC/Z73r83eG5oiuWglFtfitC5EfBjPgyAuBexIG0CYxiRkUT4pSEfW3EIbgqVb1zzJAZE/vCPHMysA637jTBLjyqXyQQk04x8l6KphnivzdymCO0aho/4t9oajyoJSmvjqES602/u++VHWv8q0a4PCB3/5WC5jJXhl4F25wzaiqbr5wwxX2PKI9vIEvi/VvcYm+s9TwvvaOagMUtKe5DWhAJ88OC8D7UFYa6x9de/2+wtN/O3ZIDHdbsI33z43tsZ6x0GPFuKKx6DuzrH7xiqVe0uvEwpKXPVj5R+0sVJMunpbTEfqceANkLyzB5irw12YObG30GRiknpp/BD4qI/B1hFa7XEeYXK2SPpW136RTUyQAj/WXZda2u63rxTKetSryu6MXuYzangCxQn+VjujEAMEKPnnn/RO0sYNd/iSubg0GjeDRPX5BM65VuGay+1ZZ0ULguD2CRegNX+++k+X3XCJBa/5EEQd47AbwHI7ru/bu4ejcWbdCeXFwV9iHQpfziQ1vZ2Ls6ydikNGGhok9UPcpSmXNI1u+NsGu9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jh9c1f/kpgmshHEzL4gJFvnnj/tXDJtzyQQPNv3o+m6Io2FENFIYg4Mo+BuHj43OYz8XV3TExilx1+K+puiSWnUg8eqtm517IW3rH3udhXPWsyxuz3ProqEusWaIsQpS+8pdHiUNZLhAKGduVEXTlRajP7CiLCJFwB66neKpu75DWMFcTfUA8JPTD1wAvbjCIl/qaRB0BCWqsipOh1MYw4LOTUedOfcB81COe3uZExox+o0ShPJjagXzrLdDcRPrHDXu4MemeLYG3ykR3Fuk0BefaiTD/W6nbUkDKTgXSzjuOzl/Fbj6nc1ZpHrd82JvbwQzI+kdqF2kejc+R0Xz1ycZAZsm9BAytNNUdPJW2aZ/oXCmFIaWcVCVtpFAZR2lXUqQQ99bS/H7/3ERr9h/JV/CpWc4rkE1Pq18/jHfC8EZgxkV+5NMLe5EZ/+swzs4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:48.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc77d05-46fa-499b-ab28-08de8440ded7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273

Add the relevant IFC bits for querying an extra migration state from the
device.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 775cb0c56865..1c8922c58c8f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2173,7 +2173,8 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   sf_eq_usage[0x1];
 	u8	   reserved_at_d3[0x5];
 	u8	   multiplane[0x1];
-	u8	   reserved_at_d9[0x7];
+	u8	   migration_state[0x1];
+	u8	   reserved_at_da[0x6];
 
 	u8	   cross_vhca_object_to_object_supported[0x20];
 
@@ -13280,13 +13281,24 @@ struct mlx5_ifc_query_vhca_migration_state_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+enum {
+	MLX5_QUERY_VHCA_MIG_STATE_UNINITIALIZED = 0x0,
+	MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_IDLE = 0x1,
+	MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_READY = 0x2,
+	MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_DIRTY = 0x3,
+	MLX5_QUERY_VHCA_MIG_STATE_OPER_MIGRATION_INIT = 0x4,
+};
+
 struct mlx5_ifc_query_vhca_migration_state_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
 
 	u8         syndrome[0x20];
 
-	u8         reserved_at_40[0x40];
+	u8         reserved_at_40[0x20];
+
+	u8         migration_state[0x4];
+	u8         reserved_at_64[0x1c];
 
 	u8         required_umem_size[0x20];
 
-- 
2.18.1

