Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE983351C27;
	Tue,  1 Sep 2026 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299656; cv=fail; b=TZGJzMZwq7MepnxI16+EYKJnNtlYM2FFpMR3OLq2cpt6Cfaw7N5lGreLMqMEWgfhdJUZ9Yw8wFAYGyqA7fm+nMYM15E61u6i3Ket4XesiRW1+6e6WC1UJGQCc8kw3y7iL68NU4naTP3C9T25tm3U62vMaiKBhjFfHBFpGOtiv/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299656; c=relaxed/simple;
	bh=Tudn/Uc3KXXyBHyneQfMJTDtfXmT2ybqIznXua3HVZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNlkWrN9fqJ1rn5Tgz6xiy+rvBIBPey0aPpCUcUYx+Uk9C6ThqoLQLQ4Vn5eie8JnKm2kgFGNtBGCUiReVSO4VuNnRF6cxxN4qIu2WgdTczy/S5FKMKyGCs8wj4+ZEyayG0DDNtjzBI9VzKLIe497toWvVh0rH+l1Bbud6e0stg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BN1n7JjW; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BN1n7JjW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg7WgOp5yIlmn2JN57uDVikLIqYP3kQmmpRndATEAD+Nq/09929QLMVAN+OiTnNvNNBVeck2DTbj46fG+Q3AHJpSALJu74dpKkD+Za9GI0iugabkqwKr7B2h2G1sxy2Gy8WMwzFX62gkxk+p6de+AAwwg2ryib/zOtJGN6NKCQkHj8chKe3Op6ozaNwpUj5Ssv+2DaOd0rqS7Gi8xH9s622jnuJvYGpxS7/IoPIUh6irT/5ADTJeuJ6LnMjrrt9PB3iMKq9QdomCrAdnorXf74iPaKMI1DGi/7JNuJcJWKJSch5RVU0xBjLEeDbv6/ScLEQFiwIlhpKPQ0umgyXFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6TX4JTTfVw2ZTfoDJ3uBaysxkPBf7L5Lmo+AkmboSQ=;
 b=IhIcaEPcSsSxjRmTs+JVHlSjKkxxb1gj4YW1UA2jOKksVx3WIJ1Oq9a3+RqkbXzPhPXmGlasr+TNiGDHrzn+XLfEepJLfEqYQl6o7H5+h4jR+pSKxVXgPSbbeBsR0ufGY8eOd3ZTACKoRJ8ba9slv38wm34fg5v/hc3P1BYa+rkqlkTumfd8IODsYMGwUEEnTAtRH6iiWFQx+xP7EpFuzhM59cs11seAoM982VKHcxz6Xbzg+lz8uBSXatg0Z2RnXQjBNw3Oaqx4foypHqZSxvuXAbo1gp0w2qV5nq7mAaEHHShDqiicrLxAZ3UZ0xRCtxlAkr/gEyLE+rx4FRslyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6TX4JTTfVw2ZTfoDJ3uBaysxkPBf7L5Lmo+AkmboSQ=;
 b=BN1n7JjWFh/DjpY8hf2TxowvTGzg/T56ggwxsnAWzKPV64w79LOF53zbdfdyovpzgywU2jxa7wd0GTqL/2FROz6RNJPJLVCTlA+0uMpvZMJtYYDGxqDg7ZxpRHui1ZXAt4sNnA+1REEcGS992IvePXxyX2QtEdWbG4mTPTc/cypGaecZFZv4gBiBc+gnuuaeZ3sspMj/raFOP8U7Y9de5WEQIpgcdDvFCSJsfv+5j8R255/alV102nd0H4LP5sPEJo2Glm4AHlGhrMQIXtNY5NNgWuOsbRY4G9bTxLTLUKdTWRUs7avxAa3b5FmwzWDp5OVG9D7tglTxAZALZOYjBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:54:10 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:54:10 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH 1/4] vfio: Reject a second cdev open before mutating shared device state
Date: Tue,  1 Sep 2026 15:53:54 -0600
Message-ID: <20260901215358.2421359-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901215358.2421359-1-alex.williamson@nvidia.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::27) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: d70cbf66-321d-4f94-33f4-08df08738ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qmEOpaPPFjxxZaa1Zw4SlT8m/QmA83zDYDNdk93shxcEsA4e5YgZT0XgHTuy84kQ/Vm8sXjwOxDSqPqWvGUUnmD3EgKvtXbUbqUQNeLgFuSG7Y/rreUzmzgfVAtRTrMAVGl62nLWJLGL1Dj0H4tOmlMeug9omIoYkk8VeC2BfG38yiidNAfIsy+dYR0GpCqFP7gpO3fZhY1evZcpMfIXQu8XJSvo5M8f5qula8mfL5a1gz65/MeSPAvgUsALu8qYwuvMkxYR5SMQFFpkE6LcSga8vIwQ2UrV+wXl/UkoSREXSjEaW7VLtGbUKjN/UqGZMKmDc6GKPbA3tNi4JrqL9MyqjNKZCxAlR6ZvMhNUg4o8pgm8/tt/HdOtq2HPwf23k5BdU4iee5wQ4z+Uvf53inAdEmRiQ+aBBhOcXKbAprxzUpFtKPQXHu3LTn6BuvBZ0y8DDpOcpsc7okigr7DkNN1BvxP3Lmtk+0TS3oJfHodWfIp5Q7seMclloSLoP21EbKHYfu2wd7x4RPBz2Mlme7+7gv3ZQqjOf2XsBm+gtReZ0zMSxWL7OCNJrK7wHTNBXdgJQizcacJSwsRV5zFo5DLRFjVDK+gIw5+RzBWjkjyo99XP+VyTduzzhZPaMjvY3yQrrEBuZwd3DKQr04k4Ye3d5QF/tuA6E+ZOfRf8ht8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JAwxp86rjP2ts4cDTjOWtEtHtSCdSm5GKpKXpJ5yjhBYvkeBiCLMyaF7/nA?=
 =?us-ascii?Q?2EDL55OzbxgDZ1vCZnP3fKEc4luyVGq19kRjHr+6bQgN1zmYXYjuaMT7XGha?=
 =?us-ascii?Q?UwNcYKa9GkwrJ+A7EEuWCWWFZdY//ckeChgssYYkW20z87OnDeT1P3bhH1Pt?=
 =?us-ascii?Q?C5lxldFqGjAOV3ssjgDILs/87/obkPqGtfMYeiMV5WG5ZD1oY4TZj68O3j4P?=
 =?us-ascii?Q?QY79dq0Lqdh0WIH3CFV00R/cxF9enpjyqxPpYjnmuno0rp7/wtBwd/YKDWUn?=
 =?us-ascii?Q?b2jQbvOYZRF4LuLJ7VMvGVdd4ZiMhzCP3jtHLLLNkkzqdbJFWXQLPJ8uycP8?=
 =?us-ascii?Q?R59Rmfq4iIHTIrfAXAg4ed1GV1GQPgJcasJmdVXAwXZ6+XrGwCWya6xmRXGV?=
 =?us-ascii?Q?9RjlkVjZM6hoLpu0G87FR8ZHlra7zmbDN+614feVRwH0TXcrHs/oxRDL+uWC?=
 =?us-ascii?Q?k3wYhaN5U2nhxgp0y3OL9BQf6TQaIYVEL4tOzXxrGMlYc60nCS3AeBQqXclU?=
 =?us-ascii?Q?FEuV0l+Vm9g8xGw/WLIB9Tw1LYhQp4cxsT9dNP5UD9SH3ktPTtiatb7bqzPQ?=
 =?us-ascii?Q?uNtLQlASZCyHOqanFl4Fzd1gK8iosUtaydU31mVypEstJit/CiWrO3Coew2m?=
 =?us-ascii?Q?8jnIfFsZm0BozkqrVEXicLgasc5JvkeHM941lZ2LvfVXunFaX7WJj6g5MrPn?=
 =?us-ascii?Q?nK/R1vYfWpWhOpdq/CIr/VT8trkiCQxDmdjfjBXGkWPXwo2nW0/wOH2EqZt6?=
 =?us-ascii?Q?Nky6TJvJ7+eVVRtvc4Aw7c35u7tBXHiHK8WfkvQkFFSM5slxDwHDAi2ba9+X?=
 =?us-ascii?Q?rAJgC11GCpb4smrIo+j3uvm/xe1BktRDst4D1QyWV9oUbrzUhQb6erPN1n9f?=
 =?us-ascii?Q?7ivd5wx2Bc/cAuEv6PHvz88i8AozUuY9IJ67p9ytXFrH3S6w0IAwUPLeKr8o?=
 =?us-ascii?Q?VWynL6MU+hp7BeSBFQbHbti2sqcOIT4SRw6UFs7olP7QYM41wSibA3qMWxHS?=
 =?us-ascii?Q?yMet8eO2u1qvo6Nue6fLFlrF1g1O9OwEJ/LNlqNM7jdl2ZVnUoj1gc6gyE/v?=
 =?us-ascii?Q?iFvnMbrKV5kO6EscztS17aGpSATfPJvUcBRMKb6xGzCWsf3cxJUNic4ej0tG?=
 =?us-ascii?Q?QGX2R6dbBHPPwuPJ1UcOUJkCEIpiy112PpHaxpwkHfbkgADQg0+IL1v16kLh?=
 =?us-ascii?Q?RyJPWArd5X2oJt0f2fdf+6IP4ynDd/gNoWZN7R8qs3UCjoOUkVNW0b0B7xdr?=
 =?us-ascii?Q?kcXSZBANBOvXpkgNKbskPd4xjpqpsk1oM7ijQOCmu8nnpEHabqHEInecMoxF?=
 =?us-ascii?Q?eNRBdhoCP/vk4dJCFSsc0/qSHqXy/RoixuG4IkM37rDNPR20VackNZQ5SgdR?=
 =?us-ascii?Q?VRZkTzLteoUnYqztQoitPGTAWmce/ixBg9ia5EE8bm9E0yvhoYjb1lbWKHsM?=
 =?us-ascii?Q?waWrQS3MD8LiGkQzzvPpuuc6CyXl5+SJYNrrCnAxI9IHqO0bWVKVMy+I54bX?=
 =?us-ascii?Q?wr/2bL6t7km/qxYDesC7//elS1zWLVgAiEIZxWsH6fS5LM4iwQDc96sIWeVk?=
 =?us-ascii?Q?eyXBC/SEDSARb9KGapPL/DKI/nNMoFKLGvdErmxr8nFO5lgbW8Wd6RBmV/+P?=
 =?us-ascii?Q?meQz5SJgkYqQ+Ss5t9VynvI6BTOhnzVS5LpiSSoP+zQwkJUMKCS1nfX8hLHm?=
 =?us-ascii?Q?cI8RreeBA1qkJSnhrFT1CV8BMvM9fazzgSyng2pROiBwI1ImYC5uvfw7kR7w?=
 =?us-ascii?Q?GQ4yZVWJtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70cbf66-321d-4f94-33f4-08df08738ddc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:54:10.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TDz8p4WiKdfrcFap6RVbpJPk/LDWNgLji9DtTamYj0piFEmL0r0zT8Akmn5XyzcmTYapAM9PKvqmlyw3tYHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

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
Assisted-by: claude-opus-4-8
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

