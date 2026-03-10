Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6693C9EF4
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160895; cv=fail; b=bGCQaidNNw0zswoBWLxpEdIL+FNd5IrKwuPqvutSpJCadxvrc3fCSpc6qA1oNrybPPgPlgVAFuCvs/7z3fA0Fxc/9tUHwj/A3rFGKnqpF3BX0c5yR4ntaqimQ3fPboGRwgeoS9jIRgj61imGvBF5vt9H9oWxi0DNiH5pNsqn5b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160895; c=relaxed/simple;
	bh=AkzlrcPM0cju9otixYf8GDK/gg6rPSQH3/blI70KIjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mijnldRVMBjI77GM0Fzx/pFTE2vLpUdspfOkthPs17p8xsRlSsi3fi0Jikj+JdSF2foo9Gcnt+J7JIGBxMr2TUJzKG8IRf/fQ6ywgCMMBzmqPYE26b6gUXxkizI8O7Icr6fJmiH3v4weXFfL4BxB/n08uySHanpmX6zEmc5IMq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LG51VcRw; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LG51VcRw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKQnach6K0gr+4f4e+CmYv+rM9gUpWNQoGJM5/we6K7gVcIFcNeKYRW5peNSuDRufG1ji4JVt5dp8BFu7dP1guBRftlaZzn4Sc9OrvARuTpajroEHikrqXeVWc+aEqZ5/O/tvRiVOkxEjUlzJo3BX65E3g4se22PMzTqfwGon7Sps0mrpBMNWTB/aBAlQGiGcTpt4OupavoxVoGDUTTc6h6md6/SjVrAjaz+a49tFFvZGmxSQl7cSjxo6QPHbQLCq9THP2Fbu/zzluHi4ch48sUB0xm0z2RNB/RO9MHLGdvTN8+J030l6aPOqceCoNq34ShRlUkTqbaBVJgrAtAbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PsgkAPD7bopNVkBU8kxxWc0dnm/RYb+2mn8564OmtI=;
 b=H0ydK4FD7tbeoIXkhv+eg5hpRzxhhZ0mgdffZk/Ut3BqoOXv1Z11SHmNupU07ZOt6iGgpKRU/n2xDERcFqzZ4K7d2+focnQyurHRM961WiddaKVfu+y/0oE3FPY1tH15V8BJwqCdO9NiZc0HefRJIQsFt2EMZQ94Ig5h/+tiLY7tZakwW/jXGtf0B/fHPQ8mplq9keKQwMK6g28fBrxBO9bQvWKkob8WuArDVrZHkmRbJxJnTobeMXc4FqO8QmY3Kuj+YpXZFvaniRiDZD5214u/kTPncbA8FLQpEc2rDbz/ngoBBeANZ7Vc0R53IXCaMGAtLcEQJdtjlFGZMTLnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PsgkAPD7bopNVkBU8kxxWc0dnm/RYb+2mn8564OmtI=;
 b=LG51VcRwtZUpGGUehqYbGG2+EIGppW0NFmqbTpN7xElFmvc56/IRaeH5MuxgAzfprn5tz3b+0lhIvmaDdzCU/qN/XDPNVSxu6nJk+XgXtb/f2PBhcZOaUUFI8YuPAGYVfYC6FxdxUpGX0LjL9hL2HPLLqW6KMhx6eQjcT7qFw+iYVjz0yVQwypz/425PHVg5I0G4+rwtSCI5stN1z9OA2oKHedtvw0EJk9ft8A+H0zsf98PZBb/WM8sl3/+Z7TV2AB/Eah0IMCr0Bu3sJ+tGRdd4prhdDZHc7qqt+vnTpxtxbLR3FVo/VaResXg/ftnchAtenHzLLj+FNj2YYXwX7A==
Received: from SA0PR12CA0013.namprd12.prod.outlook.com (2603:10b6:806:6f::18)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:41:28 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::9c) by SA0PR12CA0013.outlook.office365.com
 (2603:10b6:806:6f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 16:41:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 09:41:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 10 Mar 2026 09:41:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 09:41:01 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V1 vfio 4/6] net/mlx5: Add IFC bits for migration state
Date: Tue, 10 Mar 2026 18:40:04 +0200
Message-ID: <20260310164006.4020-5-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0843e631-eeb8-4c5d-8ec2-08de7ec3e064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Flb7l97ZEVYatzw0b3J2wdCBcZ1TDLQEleeVDjYUhYTYydKY7KCDlxHj697dZBHTQ11Ot6n+9BxlMfGx/H07qGycc0OSxnUFpX9naVQiy9dca/3FC4YY3Zoj7GtyNiL1aPwiUqq9VItwFuoj/t8HUwYY1aL6CI2Pnw66NtDp4KJeXW16kjjeQ6eP0YE+gnMIs+9sgZqQPlbZdirTPmhAo/SEhrWxwkuvJ3zekdTnZhqCNrmReQ2EKqajzqzos6bGuzZbMp1TNkQyn9e1Ff4/cuDh5UzdxtjUJ1O+PxOXiwcZz09PdP79ZG+kTDTEQJveBl1/yBojqW7ucymVUkB9h/I+qindj91+2/5JwTRFiaQud+KKG1hKHTvCKHHpJefE+IEZBBx/R6WYnpmDL35kGb5V2L3vELlOZvFcjLokGxk7I6q6uoiQh2U4TtsL4uMAvDx4YhTasP+lsOMU803+PGgAth7WkxVGecVrDz/LuzIoFNOa4Odinsa53a487IeUHQJCM3E8s1LbZdCaDD04/KIN5Av1ariZAoXVsJryS6uatc21A6fcnhSDrFoTBqb8q3qbvIEC6zWNWTVLYZRdFnIbx9+0ED3gI/pguId7J4gUP9hDYHoWltTEs0k5w/yF6MmJ8DF0GeVi4L99bR8VR/67Nzq/hGk6DqbE02QU5mTTuAfoVVdTcxUnLckN6bq7VOaLuAHOnNIXK3EXDNQyts4UKMr8KN54Nb9ANC2sR4rE5ynK+Ek85cGDAOk0gN+xbr2PBlhfwTsXDPY6GJw8vw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rz9e/pQQrpTSqzPmlCE4RUuRsGppD5C3BoZOgOq6BltPE9J9xOe3IeGrvyJuJ3RHn5cJJWr/J+ulDSLDCBRRxp/reARJAD82l//tvm6vwOnA0dJLrlYq9Of6hsXbLaYsx9JSoWrl5zfWvQ0HEhRw0DLsH0d61HkLC4LBK0TxY6TuX3XoxGAk6jSex0Zc3Up0lu+U7hBj0kwxIYnKNED0ozl+O1nP7ouRHCwXGMV1Pxf/AKE7kqE+dpqR3lmCwjdOChMUe8x8irpG/3D4gnW/YdWQhjMKcrZVAMgWqJPBWWMNeRD4cj1EfSX3Cr+CEgbAaXUI8R9P8MmJnFIHFIRSCzFBQ5JWnHcV6umCXT8Xn2WmsVKmP/NBwdPwBfXteTvCitre3O07wPqomy5Y0mi5489F3P38LWKx2d17e9jXUh4dJzxPTimZ9s5p351KoHQa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:41:28.0282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0843e631-eeb8-4c5d-8ec2-08de7ec3e064
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

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

