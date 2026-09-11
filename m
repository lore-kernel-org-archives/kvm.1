Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA272415F17;
	Fri, 11 Sep 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146291; cv=fail; b=tWmDmJTMHA26O6ULagR3DkK7SrpL7hHPoGZ03GZIv0vw5OZ0Ov6vAzEBuG4qMNhbPiL6xmGS/i4/fB1kYghjAJdN/183ObbzzZrVXC47MfC4djwN/UiVLN7dZPPx4EemOeilMlcBFKcP5MF/2BnsblOuyspVwB1znLbLbEG/ePs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146291; c=relaxed/simple;
	bh=KlTu/UqXHHro6lIeWxFzXf04Q/CalY775DOp58oxLtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oy2zs2a/SHOLCOld8JqNdy5TJlqEBp3TxBj1mwpE0rK1BR+FTiCDtvfLPApt9bL/V2gNzMjIAaIllQwyW2L/TUgPL7IbFfDZjEAymTG6TxvpdcfvgXzJnDWs8YGH6x6cwx7CvXASTsZSJ35N5jXzZfYCSNZdFBpnN2G7YyB49zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJ19yhcm; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJ19yhcm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpabSjEwwjiTjKTpoS2ZhGdx38r4mLoLAGeBNhu7JEL/pBM4nmHxeh1B/eqxWV0D/WXB799hvsaTQ0Dmo/Xcjuo1jbwgMCNqhXzHRLmCB+2Sr6hlI1Dgzwqc3o7K4yf1V/Vx4isqjGWhKQJ/PlrpdSQbsZpDYN3Dq2l4TEp+PioWyE4HEAi0tLiDSlc5uRqrrAYI6rlgVrqy18wUMgT55vpEEn9Ow1MJ2vuBxhO1NIVF6zQi6s9Ywpbjd7RUdidVMboNbHNgAmptUJFb1gnshmztEO3pw/kAJ8Kk8VkNY2UeHUkBiZLunwytTFGkPDPVZUNHoZ4hsE64Spe6L3f8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqeG5HuMsAMpMKKRnHAelWMD6AvkY0hokZ0mTlcCgjY=;
 b=n7VJV1aWOVps/WnD7OSxEQD39TgsDB7EznOnU/yASwr0og3Ba6G6PN9xbag84/JuGMPFaPzhlQz2WsoM6+qh+2BXsrNK4BEXKtlozH4wSbinNu12XMvoOSD2lsyz+buKpJiCcQFvnFusbREaihYCTUSEt0Srana3t61F6nRd8kwphXD9uO5uK5wiHN54viNleb3B/jxhOIYdZEHuwE7LrL1Yy2Q5KYmpaP3aosXG2wJexcdWL2IOObbExe1n2kudEyFP+WoWOYsE/YXNqgawF66hoADcZCQ4EvDDnx2surhb+h32W9GChQphvWCVjj08PV9TWpSfIS97UZ8I+nKWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqeG5HuMsAMpMKKRnHAelWMD6AvkY0hokZ0mTlcCgjY=;
 b=sJ19yhcmSqk5mVjp+DAbFTWAkPATygqGFvWwzNMdTCpVdoc5TYYN8y97P8k47oUFTIUUQx8+Q2jW/khzYQdX/aHgEU5yJi+i583IBOPiAESpdv2lWDSy9rxSZG4HEMeqXW9izLdG5lTvETCRr97iT1PMBjXyzctbSwL0imx4HQi+H4APxPisOTkcSgWX975HYjmKTPXHOXnL69+KbSdptgfrC70KQ4YEuIY1ghEOe5FDzuydH4YoLC9U3oBnvjtHCK0R+fsmLaE48LpavDCvVm3pBS1KT/fRelWoE+3wCLzMNHy9ZKKYxyK5aN522FQySJtIdSVTiyOOt/4kHx2ZGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:04:41 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:04:41 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/4] vfio: Reject a second cdev open before mutating shared device state
Date: Fri, 11 Sep 2026 11:04:24 -0600
Message-ID: <20260911170429.1642480-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911170429.1642480-1-alex.williamson@nvidia.com>
References: <20260911170429.1642480-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e125f5-cf38-4169-a8b1-08df1026c534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9+ixrzU6Pi2dApwQIklLqpsREY57dVoFpSk7nhKxv9DUTnirJPHCm/j2oaC57gvZeboEIlqnkwYRjZYp83AHlOFpew88e1kvwaWZ6nj6yQtXeJKpYS5bH/WOjBevpLLZDIH9Yj2PaH0J8Rp9EeC5KJOdIDEy1mceTbv+ISvpceBV8uyHUrPIZ6O6CAgKKFVN7VCAT89xLgRRgOmqjHGiuA8ke48J1hZvoIYUyNa1Kh087qwm2M60rJbsYavV7nKhCfhXqm/I7QDVFIWjjBLqFylNGtdUxXGhb83lBC92B1bNjruqSXXXMp1nmfTLseC4uWP5NvWnz1+mvP8tIrIGUDzEsQVLOktsXMkI4caC5ray292a57y5/K1Vbgkh/3kcatAeLFZLXDOTFLd05vj9lRfSgwrl59epCuB9ZGFoa4Qjyuk8G3u97ZKh93E35tNpEpSY+B/zYGTPam64gUKnPj5SWlKPYR/92belQd1V/vQmNkJ5RLvI1DSJsIb6fTOSaUp9nnnuHz6n58Znp3cJfJaB/X7vLpli1jD2didIPknCOHneCiTjRaBtdoxVuc5FKIoyXZ04dPj84aTstdsaWCEUb6OBenrQ+8juIMr+3Xwf+1bI7iYe90HQXm1aSNGwAOBwv/mEL9Q4p1TvJYGW9ONb8YiXXo0W7VSSe9xL4Qo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7k8qLkd4nOrcIMWydKBEqYcvKgjRrG56G0S8O47LPN0RvmZAD+OLRmdKfOJc?=
 =?us-ascii?Q?ByX/hr1CSvUZVl7imf+nyxXSLtyMzizyIQCkBg2cMLnm5Cl4qUepbi5doOih?=
 =?us-ascii?Q?vRqss8qVYDUnxXFWhrWEZkeBD8JWcE8O52Dc2MK4bYmvkPaSHlWkKCcpp+98?=
 =?us-ascii?Q?4QVDe8HovtOO9jZRc7RdaSWiNQp+X5mXF5miLF30IvXjOpODZQLwoifAcgpn?=
 =?us-ascii?Q?EYY/kSpprai82ETThq+IUp7OeTm4BbVu7zxt9v122QnLEuFIRGuWfww3soil?=
 =?us-ascii?Q?f067w+q97JgmXo5kta5CgRRKxgjuWYwvc4Iq9hHQaoi/qDsnhV6El8ae4ZwB?=
 =?us-ascii?Q?bLabL74t2iiDoHWRfEAf+WwJE8CllnzbYNsf1eRg6xbh4WEJg0kSyGDJ1CBG?=
 =?us-ascii?Q?W7UTlfH69YVUF0fvWTrr9H8lXlVgwlsG3iv6jL8YzJciSHWEKkohEz7th4Fd?=
 =?us-ascii?Q?FbJP9092HACTnZY2kqM1pRdA9DVe/6dfxyACAoNUxxOIZYLkrEoCU52NyCkW?=
 =?us-ascii?Q?OTtak6c35dnAn+ACalCcOGuBNvv4/bhd4AIKaZsCKq/YBvMSZl3bik/2vPOx?=
 =?us-ascii?Q?4ju/g8+5DXX/oRaGDNI8pwqi34MXMMG6UqraBUyTFg99VV399lT7Y257l5nY?=
 =?us-ascii?Q?8rAvMHLfOohhO1lkLHDUV+b69kHwvkcSwmjwb+ssg9BQbOhyqLxyk1Yt9iI1?=
 =?us-ascii?Q?KQTYX37VUh9TKU6of0ftP02YrYZvCmBsKgc8UGr+5tyBZajyBBAx3Jw+J5UR?=
 =?us-ascii?Q?jpFAonm2kbjsakYpZXqTSwITAxodItxwxrfnsKI9TgZqgPh9DkKoQFmcJvnm?=
 =?us-ascii?Q?hRfQLwC19Fo4nYmvK36POPzTm5bPzb3uZgdYO3r2O42bG11ewimc6wJl8EbL?=
 =?us-ascii?Q?0bO8PVFtReyolYuwyViX/Q3JSpGrJ2MpDnGSn55B0zm/EH2/LM4xQW0xgg6s?=
 =?us-ascii?Q?GeHDm4iYxU9/anzFQWuU4XuHVPLcfLHXDVQY0lETnmpgNEKeAODnujNSYuKq?=
 =?us-ascii?Q?dZx+7bJkUbn6WvqQTiJNe+lNFHyvQOaBIFxAYh7qbhEEd/Q4PVm5i0R7HiBL?=
 =?us-ascii?Q?Gn2rCbVRBkWHNmJ3lkmwjIyTZe/2QcvDbaKDIHbC/IIuCuth8Z2FbVMRkOKN?=
 =?us-ascii?Q?/8HToItWi3e4f1ZCSS/meiITWBCpbdsd0QffP6EmaUZpxUcVRzWsMwn8Yg8V?=
 =?us-ascii?Q?o+s2sgzDAU5xqStXYyiJfXG5L8QHPC7vly53/MWG+TogT2VX//7fcYUZMRYq?=
 =?us-ascii?Q?JkfkRizv60Xf3DTAsT1NFpCYHeTuYf9S2TuwvkNqc7skE6GUOezFavqSfy1n?=
 =?us-ascii?Q?YE9gGhhNBhfEHiqIrm+Muutd7JYBSLgafey6YgiHNxkEKB5WMGEUe2A97JXi?=
 =?us-ascii?Q?TX8YUKCxN0S72VgLsYGIHx4tCvJ04cNk0NjyGvAo9+w72uKW+x7I/0Wi2yUU?=
 =?us-ascii?Q?AG/fHPokR3e0kRlWxIrgR3HQU2aCxLkGvKyxH3/ej0L4ACcDEY+QoYFfum1O?=
 =?us-ascii?Q?JowYwty3oXN6b0dSooPQflbfov9J4cJjvA2+RUBXMBt/Saxj/Ucml7i2DwP0?=
 =?us-ascii?Q?cI6LopxIAW1qiD6Y1d04CAP5LUBVSDi3biBk+iGZHHneEglgREIj8ufqzyLO?=
 =?us-ascii?Q?Qgw0yfYf37tBhgb73q+UBzCJcmvNsvLqP8JB53ItqYqBK3Qt0IRtxPSapy6N?=
 =?us-ascii?Q?cBCZQhlfzbXdeMr+RwFeG8jhjIyxS80Q0x5zw3LeY+XT1T7yLQehRWWVzcls?=
 =?us-ascii?Q?eG6o2ciCRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e125f5-cf38-4169-a8b1-08df1026c534
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:04:41.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSSH/30aMscy+CJjoZTUpeujNvRh4wIyHowG1Hh6vCRaJjK0XGC2muZnmFq8Gi7aepkF6oSlUqoqljkbeL02tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

The cdev single-open check lives in vfio_df_open(), which runs at the
end of the bind ioctl, after vfio_df_ioctl_bind_iommufd() has already
updated state shared across all opens: vfio_df_check_token() can set
the PF vf_token and vfio_df_get_kvm_safe() records the caller's KVM
pointer in device->kvm and takes a reference.

A second cdev bind of an already-open device runs both, only to be
rejected in vfio_df_open().  The error path clears device->kvm and
drops the reference, tearing down the current opener's KVM association
and potentially resulting in an unbalanced reference on close or
premature release, while the vf_token remains clobbered.

Move the single-open check into vfio_df_ioctl_bind_iommufd() ahead of
both mutations, so a bind that cannot complete leaves the current
opener's state untouched.  df->group is NULL on this path, so a
non-zero open_count is exactly what vfio_df_open() rejected.  The test
in vfio_df_open() becomes redundant and is removed.

Return -EBUSY rather than -EINVAL here.  The arguments are not invalid,
the device is in use, which could be a transient condition due to a
delayed fput if the prior user is terminated.  This provides
compatibility with the group path, where a group open returns -EBUSY,
and users may choose bounded polling to detect such a transient
condition.

Fixes: 839e692fa4eb ("vfio: Make vfio_df_open() single open for device cdev path")
Fixes: 5fcc26969a16 ("vfio: Add VFIO_DEVICE_BIND_IOMMUFD")
Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
Assisted-by: LLM
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/device_cdev.c | 12 ++++++++++++
 drivers/vfio/vfio_main.c   |  7 -------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 1d9515c967b0..30362936c7b5 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -130,6 +130,18 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 		goto out_unlock;
 	}
 
+	/*
+	 * The cdev path allows only a single open.  Reject a second open here,
+	 * before the VF token and device->kvm updates below would clobber the
+	 * current opener's state on a bind that cannot complete.  Return -EBUSY
+	 * rather than -EINVAL since a delayed release of the prior opener can
+	 * make this transient.
+	 */
+	if (device->open_count) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	ret = vfio_df_check_token(device, &bind);
 	if (ret)
 		goto out_unlock;
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..cb3deb5a4857 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -603,13 +603,6 @@ int vfio_df_open(struct vfio_device_file *df)
 
 	lockdep_assert_held(&device->dev_set->lock);
 
-	/*
-	 * Only the group path allows the device to be opened multiple
-	 * times.  The device cdev path doesn't have a secure way for it.
-	 */
-	if (device->open_count != 0 && !df->group)
-		return -EINVAL;
-
 	device->open_count++;
 	if (device->open_count == 1) {
 		ret = vfio_df_device_first_open(df);
-- 
2.53.0

