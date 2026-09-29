Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDF347FC0;
	Tue, 29 Sep 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714575; cv=fail; b=p55xOw0pZoSqNa6VtEQ2Ma0Do2tVBWLyRuKlyKvGTJn3+8icjjqv+mBlJ9lZJmsa48QjPdL1sGo1esOPa5fcymCeamPVjb5X5HZZQPTCVfK7Vwto07fUV6aPTFSHUqhwfI2IRxtntALdWAVXqKc+qp8R0IZNw7/Be7uXmFYiZng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714575; c=relaxed/simple;
	bh=3pULpQULL+L58JuxasDKmEOm+Xp4aBZGd2fI9NBvry8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1JPY/W4JXHY7pQvbcubSs4X9uxczmsU/SrMoM+RQMfRf04shWrlGkdmuC4Q+K50EknPmI4J0hbzpdAR14dBAF8hIfsbS4qlxhjebC8S4K++6Nus/aQ12gSkJfk+tnKrqX2mX70rGW8Agy+6VSPSBbjlQ7b+nROwlpg/3mtZpjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pvj6dCSl; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pvj6dCSl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/IlFj8sywFIeCEwMU3DvokNEPSUvRyhWshudME/05fM00owcwbZ6TAwTVLF9ll7AefQbNc+p1rgOZS/NJC4jeXoYXBVPUvXHP8yxSJdG7ktg5RpGPsCgYwSphwDwa6T/solCIrGq994c+mJnvzkXcSNCRyp+IwQzPn0C89QpsbRnGyoHiyl0oD2wB5b4tgs03DViIKM/eaDMMIvBQ3wYU6l7iCF59zpjbY7xlGKRWUgjhkmRd60hp1o6aQl+tLTrc+D8+Tte1uF6mBEi5rZi8YXVTjD1wEJ3U8hPQOjmdGFVaA+A+hpPP8pQCukNHQFtNN+D7vPXBTa38lMTR0Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiThAk746w7RI0vAl7OG0C03cB4YkA8R+E/7z0828Kc=;
 b=NG7LaLiAwO6UqzOLUYZsySiYU53xPMPoBx8bPsEnYGQpKgBNuRYeCCY/l+d/InLMG8FWaDx4X8B6gm0UB3FM3f8HJFxySeOz2csO+fODj0GDK07ujmqZJXF7+RnrnfixXfT+tPZN9kgSKgV62PmJifRmjV7g2HbrZ/w/r0oF9z39gwGOqPeci4k53UYQPi/c25UjoON6yQmU0+Yutq8CZj2hJ8GOa7KExP0qTfYZJ34lv9s9bq3n2Ub52fkWtlq1YFIwMceToNSmisMygaj66t9wwBbHbqRxfxfcJ/cX65qEoiwyQS0Nq4/eX/YNlV5KQsd76AjdnPg9Ud1MJCTdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiThAk746w7RI0vAl7OG0C03cB4YkA8R+E/7z0828Kc=;
 b=Pvj6dCSlx1fElVyuD0ZdlbWcvmylkkW8JrCw1vunylhYWML9j1t74BWSh0V2T7o9dNTsY8SSDMMvkZzhZlrtBiXauFyNxBc789XHxFKISaOPWfwDAgfq0+jZVAFHfaU4DZTr1Ga1fEH+QMiG/2SArg3V1La7pDwKz6fQC/sc59kFTSBIyOUIpkd2FhfW7KweYoUqeyC1zd+j46+5EePOgobn6ZuRM16tGj4Q6aT5FpiaZtJtL/9wb28eaW9aRySc4Mgy0EMuJMoXkCyVL4ZHF30hrGYGbAdSJqk7/iIWTpmvnQ5uQAWlo0/8CLafM7Pf5/Z6nXDmbT5saJLl0bMwtw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by LV1PR12MB999281.namprd12.prod.outlook.com (2603:10b6:408:3bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 20:42:47 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 20:42:47 +0000
Date: Tue, 29 Sep 2026 14:42:43 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Simon Song <xinmengs@nvidia.com>, dakr@kernel.org, acourbot@nvidia.com,
 yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
 smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, zhiwang@kernel.org,
 zhiw@nvidia.com, Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 1/1] vfio/pci: Remove the core dependency on driver data
Message-ID: <20260929144243.5cb913a0@nvidia.com>
In-Reply-To: <20260929194325.GP1616761@nvidia.com>
References: <20260929173102.3544151-1-xinmengs@nvidia.com>
	<20260929173102.3544151-2-xinmengs@nvidia.com>
	<20260929194325.GP1616761@nvidia.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:806:28::6) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|LV1PR12MB999281:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bde652-692a-4318-3910-08df1e6a387e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|6133799003|3023799007|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RRpDtsbb8hElLromogHN88GcCLr3fDbvKeraCT3uFByRLnv5g9Nw9EQ/3jF546Ni32qh1ESzNhXk5ZgFFyQi7b+GTIUAY+TqsVZa9w5OvMUZ1ldEXt0cXBAJ4ygNdN3aXD6i5SQwOb9hDJBPZCY+G/xg3QPVX5/6gR21XcLDYlOz9x4pRBqUdq/XK39foCVLmDU5+kyAWzFTy2ZfCl71kDdP5cSS6RiG4CyZ3gsdLsINOlqy+pXP1/shFTZXJQnCnUi1jCVzyjhYpFlj2JnnVbxbP/oddlf1R4aSiBp3D5PiiQag6PqJQS3dyGP9nnQ215tz96H3drIdC6UaAkOg6ikUPpgZZgfe3f7B6WfYkuAgH5N+pFx1L+fiH71JyswbSB45/zEwnfY7fgeSBy2mLYB3bNXvSj9AuF8TU+GM0KttJ02HszPrMsqDcszT6Ccu8Az/lj6zZSMe7kuur05S1SltdWNdHzg/VOSxjn8yICSgRIPEniYMgTirut/og7fg4mJZK5FZ5HoAkxNqlEDBbCxTGRHOjChtMd8GS/WUa84Lm1Agv/saoXHihEtZNhoAauC+3q9lnp1PLTvAG68C9A4p4hF5F/qvpUwVEjNTKoR1azrm1ahnUExJLb+CSypNJ+U7WEIl3kpqdHGZaEMDIfgAJWcmDlj46w5lIQ/ssVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(6133799003)(3023799007)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6z4OZeiciDybX3/Fq7UnI1wY0/PlzRTkK6dMPI9e2hJbhFowWU0oZF2ZX1q?=
 =?us-ascii?Q?sLgIBepHT91vUsFshr8RjNcaFnGamNOJ8WjE5+kKev53lCEUydeqQ6y2QD3V?=
 =?us-ascii?Q?tkl+js5cZRCgsOWKhW10YwRERurszljL++miA/QvcKSV/Bt60p9uTNCwIuIQ?=
 =?us-ascii?Q?y/D44d2JWqjBxLFFbv0ynvP8mtRPCcldw+EcrVDzOiF23voKum8GJL010KfW?=
 =?us-ascii?Q?LlfEsKLC6UYIazfWGIp7xjRMYSTyy1cDFm/KFyDM+L1Y+pOqAqugfCRLfTuf?=
 =?us-ascii?Q?S7oPrpSM9h8/U11bygDJ8Tv+bWUyGBovbDqW8hpGX+rFYlBujk6G+26b+55v?=
 =?us-ascii?Q?POD0cuNSNTksDysLL+AStgLXOTxrT5wxpJV4Eq58VBAa92ijp1YrUFccK06H?=
 =?us-ascii?Q?eAvMkZe0IFlv/oNeLinpwdAsmAt8eH2ioEpPf3QrYYC4SUsxe7B2G3tkHD3D?=
 =?us-ascii?Q?8bTzotG7H+2hT28fl5FEIe3/MDOV93d5FzLI3ywRoeODNtXjacLAgod5jhE2?=
 =?us-ascii?Q?StJK7gm+oQ2DSHhCMo0JgugDrQqlnV4houaBFxV3Eq6GAGwP+m4I8+rf3BxJ?=
 =?us-ascii?Q?/3687hsP2PfLnDvNpD17K0tW92pKBM1oPvJOWbz/r8rhEVq09gkGwggZ4UVB?=
 =?us-ascii?Q?H6/62R4+5upiERoPKYkyH6mCHGbWsHkK7hA/qPcI3wTpFdySVBAkWj9Y42hP?=
 =?us-ascii?Q?3IdN9NgVvtkXwPqwjFDNtFs40fpIhPL9/NAUzfOf1KePoJWuIzCAPMt1HuZw?=
 =?us-ascii?Q?CMKgBIw2VGA215+jepcL+7UmADIY0FxCHh+9SusBEbfjywVYwHCYoPkxhhG5?=
 =?us-ascii?Q?yhos/e7Aj9bBC9GV4kV8dztKVvExFqYlC2qKQwA2yNw4nftApPD9dI4/Tf/E?=
 =?us-ascii?Q?wPyDhzehwQnIJ4wWQcwdOEzgwZX/u+Ceiu9yWb/uSzURjx242QhomDuqqu6H?=
 =?us-ascii?Q?yymMz9eBzXi4LRpAzaR2A42u6cMysi1z0CxM0W4ZsY4gwJEH6w/odgCcRDsn?=
 =?us-ascii?Q?LixJSXuEK1so9TiTQ/yZilP4Q8o965k0w/56iHmM+IqR4pvTdlnO3/q+CLw2?=
 =?us-ascii?Q?Zss6D18Y+aJrYIUzkiy9uE9oGXuZS65CyNPmJfa5orMJcThSSxeoMYtm1xDN?=
 =?us-ascii?Q?D1HEmgN0DY4rI66EQlecz39laYD1kvm3F9KwSnkGrVVo+GIRS0ZDc3B6Ftjm?=
 =?us-ascii?Q?9cCbMHyhaxcI1D8H1zCe5FfydYBN9o4knNUFU0gSN918cF8qlwoqJxWv4Tpz?=
 =?us-ascii?Q?Ia5pC9bI69Y6l/igqDSriYRwVPwFYINbm6ULTsQuVZ7vvOi2TzKiO+rdrCP6?=
 =?us-ascii?Q?BnQdwt148H0EAght9b8UIuCGSp0hpKuZ+0GqPyPd4/wEfHKcBIuu4eI4ck+L?=
 =?us-ascii?Q?DAs0NfBqu22heIQ8jYsSmdd/rZfMQVPea6WMh/nGkUmo/x2EupqeJ4cVJr1X?=
 =?us-ascii?Q?OAV7NJF78h9VaxPmrAFfEIWN1/t7gU6xmuraGjC5cNe9Be2cTKdRHBz1bt/k?=
 =?us-ascii?Q?fwuoYWq1x5gVUY4ATS/qDYwaHPZX+BAEY8pVPs8dNBHFPOdq+R5iBWvlTSRX?=
 =?us-ascii?Q?S9nQIH9RCDqg+tqnGkH8RHabsz52JVJ/RL5cqRrf2b/46YtWmxcm6tEY0HB0?=
 =?us-ascii?Q?+VTqLmiq5PLiNWsAxS64e8NTfpvBpTDnRrbvRv3LztpRtXG+ZLcMPhIVV5XJ?=
 =?us-ascii?Q?J2VS1mvEvd76/aIpLW06vXVIqTUoXV4yIOlULM93k3232r9jk0xbQU1+QJrR?=
 =?us-ascii?Q?qEWrpDgd0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bde652-692a-4318-3910-08df1e6a387e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 20:42:47.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeFMMpZCNWMRfUQ0Zy67LGznRB/wG9ukUzE5A/B97gWwMSt0HisMd5YfcH4JgB49dJGGW8vo0R80YMBQXhRoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999281

On Tue, 29 Sep 2026 16:43:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 29, 2026 at 10:31:01AM -0700, Simon Song wrote:
> 
> > +#define VFIO_PCI_CORE_DEFINE_CALLBACKS(name)                                  \
> > +static int __maybe_unused name##_pm_suspend(struct device *dev)               \
> > +{                                                                             \
> > +	return vfio_pci_core_runtime_suspend(dev_get_drvdata(dev));           \  
> 
> That's completely not the point, these macros need to cast it to the
> drivers struct first and then dereference the core struct by member
> name.

It's maybe half the point, it removes the drvdata dependency from the
core functions and the core doesn't require variant drivers to use the
macro, but use of the macro still depends on the drvdata convention.

The macro should instead be passed a driver struct name and field to
extract the reference so that it can be used universally.

For the rest of the audience, there was a technical glitch in posting
this so it didn't get out to the lists.  Including the original below.
Thanks,

Alex
---

vfio/pci: Remove the core dependency on driver data

vfio-pci-core currently has runtime functions that interpret pci
driver_data as a pointer to vfio_pci_core_device, and enforce vfio
variant drivers must set vfio_pci_core_device to their pci driver_data.
This constrains variant drivers' private-data layout, including the
typed driver data used by the Rust PCI infrastructure.

Added VFIO_PCI_CORE_DEFINE_CALLBACKS marcos to generate wrapper code for
each vfio variant driver, these wrapper code allowes each vfio variant
driver to retrieve its own
vfio_pci_core_device from pci driver_data and pass it to the shared vfio
core helper codes.

Assisted-by: LLM
Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
Co-developed-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  7 ++-
 drivers/vfio/pci/ism/main.c                   | 11 +++-
 drivers/vfio/pci/mlx5/main.c                  |  7 ++-
 drivers/vfio/pci/nvgrace-gpu/main.c           |  7 ++-
 drivers/vfio/pci/pds/pci_drv.c                |  7 ++-
 drivers/vfio/pci/qat/main.c                   |  7 ++-
 drivers/vfio/pci/vfio_pci.c                   | 18 +++++-
 drivers/vfio/pci/vfio_pci_core.c              | 57 ++++++-------------
 drivers/vfio/pci/virtio/main.c                |  7 ++-
 drivers/vfio/pci/xe/main.c                    | 24 ++++++--
 include/linux/vfio_pci_core.h                 | 40 +++++++++++--
 11 files changed, 127 insertions(+), 65 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..f3c29a36ac9e 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -16,6 +16,8 @@
 
 #include "hisi_acc_vfio_pci.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(hisi_acc_vf)
+
 /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
 static int qm_wait_dev_not_ready(struct hisi_qm *qm)
 {
@@ -1688,7 +1690,7 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 		return PTR_ERR(hisi_acc_vdev);
 
 	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
-	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
+	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device, NULL);
 	if (ret)
 		goto out_put_vdev;
 
@@ -1721,7 +1723,7 @@ MODULE_DEVICE_TABLE(pci, hisi_acc_vfio_pci_table);
 static const struct pci_error_handlers hisi_acc_vf_err_handlers = {
 	.reset_prepare = hisi_acc_vf_pci_reset_prepare,
 	.reset_done = hisi_acc_vf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = hisi_acc_vf_aer_err_detected,
 };
 
 static struct pci_driver hisi_acc_vfio_pci_driver = {
@@ -1729,6 +1731,7 @@ static struct pci_driver hisi_acc_vfio_pci_driver = {
 	.id_table = hisi_acc_vfio_pci_table,
 	.probe = hisi_acc_vfio_pci_probe,
 	.remove = hisi_acc_vfio_pci_remove,
+	.driver = { .pm = &hisi_acc_vf_pm_ops },
 	.err_handler = &hisi_acc_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
index f83e09b915ed..5efe5d02daf6 100644
--- a/drivers/vfio/pci/ism/main.c
+++ b/drivers/vfio/pci/ism/main.c
@@ -8,6 +8,8 @@
 #include <linux/slab.h>
 #include "../vfio_pci_priv.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(ism_vfio)
+
 #define ISM_VFIO_PCI_OFFSET_SHIFT   48
 #define ISM_VFIO_PCI_OFFSET_TO_INDEX(off) ((off) >> ISM_VFIO_PCI_OFFSET_SHIFT)
 #define ISM_VFIO_PCI_INDEX_TO_OFFSET(index) ((u64)(index) << ISM_VFIO_PCI_OFFSET_SHIFT)
@@ -365,7 +367,7 @@ static int ism_vfio_pci_probe(struct pci_dev *pdev,
 
 	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
 
-	ret = vfio_pci_core_register_device(&ivpcd->core_device);
+	ret = vfio_pci_core_register_device(&ivpcd->core_device, NULL);
 	if (ret)
 		vfio_put_device(&ivpcd->core_device.vdev);
 
@@ -392,12 +394,17 @@ static const struct pci_device_id ism_device_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, ism_device_table);
 
+static const struct pci_error_handlers ism_vfio_err_handlers = {
+	.error_detected = ism_vfio_aer_err_detected,
+};
+
 static struct pci_driver ism_vfio_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = ism_device_table,
 	.probe = ism_vfio_pci_probe,
 	.remove = ism_vfio_pci_remove,
-	.err_handler = &vfio_pci_core_err_handlers,
+	.driver	= { .pm = &ism_vfio_pm_ops },
+	.err_handler = &ism_vfio_err_handlers,
 	.driver_managed_dma = true,
 };
 
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index de306dee1d1a..d813e68252b3 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -21,6 +21,8 @@
 
 #include "cmd.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(mlx5vf)
+
 /* Device specification max LOAD size */
 #define MAX_LOAD_SIZE (BIT_ULL(__mlx5_bit_sz(load_vhca_state_in, size)) - 1)
 
@@ -1416,7 +1418,7 @@ static int mlx5vf_pci_probe(struct pci_dev *pdev,
 		return PTR_ERR(mvdev);
 
 	dev_set_drvdata(&pdev->dev, &mvdev->core_device);
-	ret = vfio_pci_core_register_device(&mvdev->core_device);
+	ret = vfio_pci_core_register_device(&mvdev->core_device, NULL);
 	if (ret)
 		goto out_put_vdev;
 	return 0;
@@ -1443,7 +1445,7 @@ MODULE_DEVICE_TABLE(pci, mlx5vf_pci_table);
 
 static const struct pci_error_handlers mlx5vf_err_handlers = {
 	.reset_done = mlx5vf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = mlx5vf_aer_err_detected,
 };
 
 static struct pci_driver mlx5vf_pci_driver = {
@@ -1451,6 +1453,7 @@ static struct pci_driver mlx5vf_pci_driver = {
 	.id_table = mlx5vf_pci_table,
 	.probe = mlx5vf_pci_probe,
 	.remove = mlx5vf_pci_remove,
+	.driver	= { .pm = &mlx5vf_pm_ops },
 	.err_handler = &mlx5vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index d07dcacb76bd..9b02f71f380a 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -14,6 +14,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/memory-failure.h>
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(nvgrace_gpu)
+
 /*
  * The device memory usable to the workloads running in the VM is cached
  * and showcased as a 64b device BAR (comprising of BAR4 and BAR5 region)
@@ -1358,7 +1360,7 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 		nvdev->core_device.pci_ops = &nvgrace_gpu_pci_dev_core_ops;
 	}
 
-	ret = vfio_pci_core_register_device(&nvdev->core_device);
+	ret = vfio_pci_core_register_device(&nvdev->core_device, NULL);
 	if (ret)
 		goto out_put_vdev;
 
@@ -1416,7 +1418,7 @@ static void nvgrace_gpu_vfio_pci_reset_done(struct pci_dev *pdev)
 
 static const struct pci_error_handlers nvgrace_gpu_vfio_pci_err_handlers = {
 	.reset_done = nvgrace_gpu_vfio_pci_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = nvgrace_gpu_aer_err_detected,
 };
 
 static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
@@ -1424,6 +1426,7 @@ static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
 	.id_table = nvgrace_gpu_vfio_pci_table,
 	.probe = nvgrace_gpu_probe,
 	.remove = nvgrace_gpu_remove,
+	.driver = { .pm = &nvgrace_gpu_pm_ops },
 	.err_handler = &nvgrace_gpu_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
index 4923f1823126..d25db7ea0c25 100644
--- a/drivers/vfio/pci/pds/pci_drv.c
+++ b/drivers/vfio/pci/pds/pci_drv.c
@@ -16,6 +16,8 @@
 #include "pci_drv.h"
 #include "cmds.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(pds_vfio)
+
 #define PDS_VFIO_DRV_DESCRIPTION	"AMD/Pensando VFIO Device Driver"
 #define PCI_VENDOR_ID_PENSANDO		0x1dd8
 
@@ -120,7 +122,7 @@ static int pds_vfio_pci_probe(struct pci_dev *pdev,
 
 	dev_set_drvdata(&pdev->dev, &pds_vfio->vfio_coredev);
 
-	err = vfio_pci_core_register_device(&pds_vfio->vfio_coredev);
+	err = vfio_pci_core_register_device(&pds_vfio->vfio_coredev, NULL);
 	if (err)
 		goto out_put_vdev;
 
@@ -173,7 +175,7 @@ static void pds_vfio_pci_aer_reset_done(struct pci_dev *pdev)
 
 static const struct pci_error_handlers pds_vfio_pci_err_handlers = {
 	.reset_done = pds_vfio_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = pds_vfio_aer_err_detected,
 };
 
 static struct pci_driver pds_vfio_pci_driver = {
@@ -181,6 +183,7 @@ static struct pci_driver pds_vfio_pci_driver = {
 	.id_table = pds_vfio_pci_table,
 	.probe = pds_vfio_pci_probe,
 	.remove = pds_vfio_pci_remove,
+	.driver = { .pm = &pds_vfio_pm_ops },
 	.err_handler = &pds_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index 60ff907b6a67..fcdf976dd040 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -16,6 +16,8 @@
 #include <linux/vfio_pci_core.h>
 #include <linux/qat/qat_mig_dev.h>
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(qat_vf)
+
 /*
  * The migration data of each Intel QAT VF device is encapsulated into a
  * 4096 bytes block. The data consists of two parts.
@@ -652,7 +654,7 @@ qat_vf_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return PTR_ERR(qat_vdev);
 
 	pci_set_drvdata(pdev, &qat_vdev->core_device);
-	ret = vfio_pci_core_register_device(&qat_vdev->core_device);
+	ret = vfio_pci_core_register_device(&qat_vdev->core_device, NULL);
 	if (ret)
 		goto out_put_device;
 
@@ -686,7 +688,7 @@ MODULE_DEVICE_TABLE(pci, qat_vf_vfio_pci_table);
 
 static const struct pci_error_handlers qat_vf_err_handlers = {
 	.reset_done = qat_vf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = qat_vf_aer_err_detected,
 };
 
 static struct pci_driver qat_vf_vfio_pci_driver = {
@@ -694,6 +696,7 @@ static struct pci_driver qat_vf_vfio_pci_driver = {
 	.id_table = qat_vf_vfio_pci_table,
 	.probe = qat_vf_vfio_pci_probe,
 	.remove = qat_vf_vfio_pci_remove,
+	.driver	= { .pm = &qat_vf_pm_ops },
 	.err_handler = &qat_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..6caded7b1470 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -27,6 +27,8 @@
 
 #include "vfio_pci_priv.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(vfio_pci)
+
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
 #define DRIVER_DESC     "VFIO PCI - User Level meta-driver"
 
@@ -173,6 +175,12 @@ static const struct vfio_pci_device_ops vfio_pci_dev_ops = {
 	.get_dmabuf_phys = vfio_pci_core_get_dmabuf_phys,
 };
 
+static unsigned int vfio_pci_vga_set_decode(struct pci_dev *pdev, bool single_vga)
+{
+	return vfio_pci_core_vga_set_decode(dev_get_drvdata(&pdev->dev),
+					    single_vga);
+}
+
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct vfio_pci_core_device *vdev;
@@ -188,9 +196,10 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_set_drvdata(&pdev->dev, vdev);
 	vdev->pci_ops = &vfio_pci_dev_ops;
-	ret = vfio_pci_core_register_device(vdev);
+	ret = vfio_pci_core_register_device(vdev, vfio_pci_vga_set_decode);
 	if (ret)
 		goto out_put_vdev;
+
 	return 0;
 
 out_put_vdev:
@@ -223,13 +232,18 @@ static const struct pci_device_id vfio_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, vfio_pci_table);
 
+static const struct pci_error_handlers vfio_pci_err_handlers = {
+	.error_detected = vfio_pci_aer_err_detected,
+};
+
 static struct pci_driver vfio_pci_driver = {
 	.name			= "vfio-pci",
 	.id_table		= vfio_pci_table,
 	.probe			= vfio_pci_probe,
 	.remove			= vfio_pci_remove,
 	.sriov_configure	= vfio_pci_sriov_configure,
-	.err_handler		= &vfio_pci_core_err_handlers,
+	.err_handler		= &vfio_pci_err_handlers,
+	.driver		= { .pm = &vfio_pci_pm_ops },
 	.driver_managed_dma	= true,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 362c375a0579..465b49a5e6f5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -161,9 +161,10 @@ static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
  * has no way to get to it and routing can be disabled externally at the
  * bridge.
  */
-static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
+unsigned int vfio_pci_core_vga_set_decode(struct vfio_pci_core_device *vdev,
+					  bool single_vga)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+	struct pci_dev *pdev = vdev->pdev;
 	struct pci_dev *tmp = NULL;
 	unsigned char max_busnr;
 	unsigned int decodes;
@@ -191,6 +192,7 @@ static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
 
 	return decodes;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_core_vga_set_decode);
 
 static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
 {
@@ -486,11 +488,8 @@ static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int vfio_pci_core_runtime_suspend(struct device *dev)
+int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
-
 	down_write(&vdev->memory_lock);
 	/*
 	 * The user can move the device into D3hot state before invoking
@@ -515,11 +514,10 @@ static int vfio_pci_core_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_core_runtime_suspend);
 
-static int vfio_pci_core_runtime_resume(struct device *dev)
+int vfio_pci_core_runtime_resume(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
-
 	/*
 	 * Resume with a pm_wake_eventfd_ctx signals the eventfd and exit
 	 * low power mode.
@@ -536,7 +534,7 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
+EXPORT_SYMBOL_GPL(vfio_pci_core_runtime_resume);
 
 /*
  * Eager-request BAR resources, and iomap them.  Soft failures are
@@ -575,18 +573,6 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
 	}
 }
 
-/*
- * The pci-driver core runtime PM routines always save the device state
- * before going into suspended state. If the device is going into low power
- * state with only with runtime PM ops, then no explicit handling is needed
- * for the devices which have NoSoftRst-.
- */
-static const struct dev_pm_ops vfio_pci_core_pm_ops = {
-	SET_RUNTIME_PM_OPS(vfio_pci_core_runtime_suspend,
-			   vfio_pci_core_runtime_resume,
-			   NULL)
-};
-
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -2146,22 +2132,25 @@ static void vfio_pci_vf_uninit(struct vfio_pci_core_device *vdev)
 	kfree(vdev->vf_token);
 }
 
-static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
+static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev,
+			     unsigned int (*set_decode)(struct pci_dev *, bool))
 {
 	struct pci_dev *pdev = vdev->pdev;
 	int ret;
 
 	if (!vfio_pci_is_vga(pdev))
 		return 0;
+	if (!set_decode)
+		return -EINVAL;
 
 	ret = aperture_remove_conflicting_pci_devices(pdev, vdev->vdev.ops->name);
 	if (ret)
 		return ret;
 
-	ret = vga_client_register(pdev, vfio_pci_set_decode);
+	ret = vga_client_register(pdev, set_decode);
 	if (ret)
 		return ret;
-	vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
+	vga_set_legacy_decoding(pdev, set_decode(pdev, false));
 	return 0;
 }
 
@@ -2214,16 +2203,13 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_release_dev);
 
-int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
+int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev,
+				  unsigned int (*set_decode)(struct pci_dev *, bool))
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	/* Drivers must set the vfio_pci_core_device to their drvdata */
-	if (WARN_ON(vdev != dev_get_drvdata(dev)))
-		return -EINVAL;
-
 	/* Drivers must set a name.  Required for sequestering SR-IOV VFs */
 	if (WARN_ON(!vdev->vdev.ops->name))
 		return -EINVAL;
@@ -2274,7 +2260,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	ret = vfio_pci_vf_init(vdev);
 	if (ret)
 		return ret;
-	ret = vfio_pci_vga_init(vdev);
+	ret = vfio_pci_vga_init(vdev, set_decode);
 	if (ret)
 		goto out_vf;
 
@@ -2291,7 +2277,6 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
-	dev->driver->pm = &vfio_pci_core_pm_ops;
 	pm_runtime_allow(dev);
 	if (!vdev->disable_idle_d3)
 		pm_runtime_put(dev);
@@ -2332,10 +2317,9 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
 
-pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
+pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev,
 						pci_channel_state_t state)
 {
-	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct vfio_pci_eventfd *eventfd;
 
 	rcu_read_lock();
@@ -2418,11 +2402,6 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
-const struct pci_error_handlers vfio_pci_core_err_handlers = {
-	.error_detected = vfio_pci_core_aer_err_detected,
-};
-EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
-
 static bool vfio_dev_in_groups(struct vfio_device *vdev,
 			       struct vfio_pci_group_info *groups)
 {
diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
index d2e5cbca13c8..69c35e88a983 100644
--- a/drivers/vfio/pci/virtio/main.c
+++ b/drivers/vfio/pci/virtio/main.c
@@ -18,6 +18,8 @@
 
 #include "common.h"
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(virtiovf)
+
 static int virtiovf_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct virtiovf_pci_core_device *virtvdev = container_of(core_vdev,
@@ -175,7 +177,7 @@ static int virtiovf_pci_probe(struct pci_dev *pdev,
 		virtiovf_set_migratable(virtvdev);
 
 	dev_set_drvdata(&pdev->dev, &virtvdev->core_device);
-	ret = vfio_pci_core_register_device(&virtvdev->core_device);
+	ret = vfio_pci_core_register_device(&virtvdev->core_device, NULL);
 	if (ret)
 		goto out;
 	return 0;
@@ -211,7 +213,7 @@ static void virtiovf_pci_aer_reset_done(struct pci_dev *pdev)
 
 static const struct pci_error_handlers virtiovf_err_handlers = {
 	.reset_done = virtiovf_pci_aer_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = virtiovf_aer_err_detected,
 };
 
 static struct pci_driver virtiovf_pci_driver = {
@@ -219,6 +221,7 @@ static struct pci_driver virtiovf_pci_driver = {
 	.id_table = virtiovf_pci_table,
 	.probe = virtiovf_pci_probe,
 	.remove = virtiovf_pci_remove,
+	.driver = { .pm = &virtiovf_pm_ops },
 	.err_handler = &virtiovf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index cbff5af385ef..11a7234cc9c8 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -16,6 +16,8 @@
 #include <drm/intel/xe_sriov_vfio.h>
 #include <drm/intel/pciids.h>
 
+VFIO_PCI_CORE_DEFINE_CALLBACKS(xe_vfio)
+
 struct xe_vfio_pci_migration_file {
 	struct file *filp;
 	/* serializes accesses to migration data */
@@ -140,7 +142,7 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
 static const struct pci_error_handlers xe_vfio_pci_err_handlers = {
 	.reset_prepare = xe_vfio_pci_reset_prepare,
 	.reset_done = xe_vfio_pci_reset_done,
-	.error_detected = vfio_pci_core_aer_err_detected,
+	.error_detected = xe_vfio_aer_err_detected,
 };
 
 static int xe_vfio_pci_open_device(struct vfio_device *core_vdev)
@@ -540,6 +542,12 @@ static const struct vfio_device_ops xe_vfio_pci_ops = {
 	.detach_ioas = vfio_iommufd_physical_detach_ioas,
 };
 
+static unsigned int xe_vfio_vga_set_decode(struct pci_dev *pdev, bool single_vga)
+{
+	return vfio_pci_core_vga_set_decode(dev_get_drvdata(&pdev->dev),
+					    single_vga);
+}
+
 static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct xe_vfio_pci_core_device *xe_vdev;
@@ -552,13 +560,16 @@ static int xe_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	dev_set_drvdata(&pdev->dev, &xe_vdev->core_device);
 
-	ret = vfio_pci_core_register_device(&xe_vdev->core_device);
-	if (ret) {
-		vfio_put_device(&xe_vdev->core_device.vdev);
-		return ret;
-	}
+	ret = vfio_pci_core_register_device(&xe_vdev->core_device,
+					    xe_vfio_vga_set_decode);
+	if (ret)
+		goto out_put_vdev;
 
 	return 0;
+
+out_put_vdev:
+	vfio_put_device(&xe_vdev->core_device.vdev);
+	return ret;
 }
 
 static void xe_vfio_pci_remove(struct pci_dev *pdev)
@@ -586,6 +597,7 @@ static struct pci_driver xe_vfio_pci_driver = {
 	.id_table = xe_vfio_pci_table,
 	.probe = xe_vfio_pci_probe,
 	.remove = xe_vfio_pci_remove,
+	.driver = { .pm = &xe_vfio_pm_ops },
 	.err_handler = &xe_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..42feada4f1d5 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -8,6 +8,7 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
+#include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/vfio.h>
@@ -16,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
+#include <linux/pm.h>
 
 #ifndef VFIO_PCI_CORE_H
 #define VFIO_PCI_CORE_H
@@ -166,9 +168,9 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
-int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev,
+				  unsigned int (*set_decode)(struct pci_dev *, bool));
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
-extern const struct pci_error_handlers vfio_pci_core_err_handlers;
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn);
 long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
@@ -193,8 +195,6 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
-pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
-						pci_channel_state_t state);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
 			       loff_t off, size_t count, size_t x_start,
@@ -260,4 +260,36 @@ vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
 int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 				 struct phys_vec *phys);
 
+int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev);
+int vfio_pci_core_runtime_resume(struct vfio_pci_core_device *vdev);
+pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev,
+						pci_channel_state_t state);
+unsigned int vfio_pci_core_vga_set_decode(struct vfio_pci_core_device *vdev,
+					 bool single_vga);
+
+/*
+ * Per-driver PM/AER trampolines.  The generated callbacks recover vdev via
+ * dev_get_drvdata(), so driver_data must point to the embedded core device.
+ *
+ * @name: prefix for <name>_pm_ops and <name>_aer_err_detected
+ */
+#define VFIO_PCI_CORE_DEFINE_CALLBACKS(name)                                  \
+static int __maybe_unused name##_pm_suspend(struct device *dev)               \
+{                                                                             \
+	return vfio_pci_core_runtime_suspend(dev_get_drvdata(dev));           \
+}                                                                             \
+static int __maybe_unused name##_pm_resume(struct device *dev)                \
+{                                                                             \
+	return vfio_pci_core_runtime_resume(dev_get_drvdata(dev));            \
+}                                                                             \
+static const struct dev_pm_ops name##_pm_ops = {                              \
+	SET_RUNTIME_PM_OPS(name##_pm_suspend, name##_pm_resume, NULL)         \
+};                                                                            \
+static pci_ers_result_t name##_aer_err_detected(struct pci_dev *pdev,         \
+					      pci_channel_state_t state)      \
+{                                                                             \
+	return vfio_pci_core_aer_err_detected(dev_get_drvdata(&pdev->dev),    \
+					     state);                          \
+}
+
 #endif /* VFIO_PCI_CORE_H */
-- 
2.43.7

