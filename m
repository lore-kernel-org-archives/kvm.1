Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CC5335BC;
	Thu, 17 Sep 2026 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651264; cv=fail; b=XzCTG4R7m+h0MiU2JKsjGDtvCCp9hpjrPVminxN0oKq0JLuAO4vZNMSheGntyHUR4fBXYTTRPmfBDtbEyiuB0zrkrupH9/GKOObod/QEo60Pe1tObVMMHbp6UuLV/390sd1dDx17D5ZJTxihrwTE81gGzNX7aPUAuJP0TZ5H+oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651264; c=relaxed/simple;
	bh=1hcug/7H/zNG9FHyc4MKYAltt2OZcRXbBIqkAaws4qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=soic8bTC4cnawL49u0uVZRpqDocKplXzZnalhnKwUaPP+A14i/uit0weuuKleSVT3IQT6FMuEAODuBVRtLO+7eo5JtQcPkQ3QgiSyseFOR9eYbnBcI/dJhxqP3szxIm9r8ta3xZ3Ce3EYOtufFmRvoBrBgdLLYPpoOKIqVKXfe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mtfXc4dj; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mtfXc4dj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0JgGmOz3vUgOi18k+7MD1UlJ9LjBpuCnFnWhKMIJlR0WU77hfycqAvEQp6Hnazska/cnF1PkLpGugApeW7K8Ud7V2EQPFZULyi7ocEtgwiAq5kzXv2KbmZomtcEuakZcfWXqbYY2Wms33Gw787ARcLHpuDNZNmaM+d2ySehmeaTnS18G01bnvjJ2v4fErg1MFP15H+l+1aU2hL+3F1cBb0hJ9QxCkI2yxVWCDO4QW/LVFDOfi0rRGR+allk2L+KX0UaluJG2NwCGum7bUO5QzNHltd3NQ+Qt1Tr0089YGtfNELx332Fiz2aCQulUYYpG9I2R78GB1WGlEMjikxK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnmIs3J313ntDJKLU+4mgV+EXenHhEI6LiGnr+Gtzcg=;
 b=l2irLM0pvzHKL9L2s9blI4E9TmAGffJtejTIR9hd8ceQuzHq0SZAPQ8wwn+y96Tn6O0zKp06tAUJftGDjGjEHy2lGWE8FcP6uZdNS3IZnmeSWukGHbMj/8MjSWhdooKq80LkfClmjlHRgTSPJL+rhTMOaN2GvAvg5ezkb4OY/iC81Z8pTLEgQPT0izJ/Z1gmsKWwPIvckXNcXRGaohTh03UkgjVqBi3EK67eVIpwEVBqb/dkVyjpFhV4NgCLsTy/1qQeycwqTT3JXFyEde0fqpA3ahxVtX344TU6Z8/d+lHGUcrWqvFNEe+/tLRCT5I7ZL+TQq69BSkg3cbe1ixcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnmIs3J313ntDJKLU+4mgV+EXenHhEI6LiGnr+Gtzcg=;
 b=mtfXc4dj1BhNhf6+Hr0D37OZ408JOYbCGnmJD5CE8UiYYB/Oma4iuQ5pa/g1lPhCaOkfa7QO6ppl6RqiA90ATBoTPULn777yRTF/iAc7WcrgytSRkpkeIw49CpsJn95OAiNZmQR3tXc1Vmjy8+DWun5i37ONCVLVjorcJhI2Vgq+zGLlgcgRZZX4UU/FVQefkQvJdLQj4a7zD8hjwK/VvxTLe4Vx8oiep+i9aEZ1rAlq7GuJ9VEu8dLt4rMAGoIgn82hQnqyR3xLqcEDJwaFvsVzNHCrlK3nbf8dnfW6pkY8nt1GCbEtXwHi4HI2AHApyk3Hv8cvr70DZbcHOyL+sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB7593.namprd12.prod.outlook.com
 (2603:10b6:610:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 13:20:49 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:20:49 +0000
Date: Thu, 17 Sep 2026 10:20:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Zhi Wang <zhiw@nvidia.com>, acourbot@nvidia.com, yishaih@nvidia.com,
	skolothumtho@nvidia.com, kevin.tian@intel.com, simona@ffwll.ch,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
	smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, nova-gpu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhiwang@kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO variant
 driver
Message-ID: <20260917132048.GZ3968357@nvidia.com>
References: <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
 <20260916162817.GW3968357@nvidia.com>
 <CAPM=9twda0Q9nj9E5AUCi4=en5tDA7ReBv8MV2Ftg-STwNbDLQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twda0Q9nj9E5AUCi4=en5tDA7ReBv8MV2Ftg-STwNbDLQ@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 710f4d25-e8b4-41ec-8cd8-08df14be7d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|5023799004|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lgwTfxr/87zuCrBRlIOCuuV/ui1m/hblrnCtflez8RH45U3vMKOaQ27qwWH5kZJYT8Z0znev8K/3PcCq6qsOB141DpSSc0kspz1YtytEKEUKsu7yd9pY2CL3qPdfpAAoxnRcvD6uPqDSF5WeoVMGAHchTbnPyRqIPvuc91u0fX9Of82RGZI25G3xHpkym0FOZ+d/VYH4vSnOIgEQGd3ZI3/RpnLXrH4O+bvQdTjDlndAFUFpcx3ABH92ABnYbdJOUtDvH0NkDRF5TqFL9JH2XtI7YHd0NNvdd6pw/oYLwTKnTEu6C6EeWOY9lTg61kNTVqfKvFPufdt+TGq233d2kI+UdcfMEySBv7vjz0WOB/HD93PTJPeN6Pwwy4TdgrZirT2cSGySec3h9Zxgqjaw/UD2X6Y8hVlj/rOkQ7zYorEIui5zkr6tHM3uAZDPqGF0AcpL5xAbhwl4Azeia9T0r+NWTUYj9XEJM5F/zsZk9F8cxJRx2Qxmtwp3mVI3/aBrjY2etCYs7p95FwaAFVpVElxKu2g88JKg01pLXMBBqUmMhvbdSNSMjuVaJD2pHtGA9doO40K52s1Uq4k6GtQwmW5Y0lB/khHde50nY8QLgE+pjFjJeWyo4AyKsjaHqNaDwHjHHpGmnbZ1d3r6jhchCI8B7yCujhK9kCa5HJkU6oA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P55fcHTw8LB2ExyzMIsuwvsFEsCtHF/bPy+scEjlI0moEi+APckkuE4c2Lfh?=
 =?us-ascii?Q?Db7nDwBr6gcmz9rFY49e4F8jiteP/5SBQF6EkvMxg8WxmGonKTT/2YBFyW90?=
 =?us-ascii?Q?Qhd2OS79mnmGZuqpncznFn2cCIAfAzAIrdClEKSWuQijCRk656W4bXAORXaj?=
 =?us-ascii?Q?b4S+t+1W5RfGi/zKxmul9+48PbGwZJbSYO2ec8m2ec9YqnSuIjdGM/3gBMqd?=
 =?us-ascii?Q?yt9xvSlJrUhPSA8JD+lqZW61Y3fMUNQXWXh72RB83QHW/hJEObBmHp4QnEYo?=
 =?us-ascii?Q?Yrs9pTTUqIwdqopeIYyAA7D/W4HI/ZEkciRDsgO+g9JUKPuBhTkIzKP2SMD5?=
 =?us-ascii?Q?6ZZTUa2d8uDcHjE8Q4vRfEIciZ6fjKnoxfgMHEpdO2qF5tNNL0QRJcQwAK02?=
 =?us-ascii?Q?tGvVSuER+yf3deaZQds+QNjiseLOeyKZWLdSbeqQiNL2odZx8pDHtq02Cj3A?=
 =?us-ascii?Q?QDM/o1iGo5LnEQlZvLxStapHabTODoT9j3B6Z7x/PAd9TK1KuIpmKnAZxQrH?=
 =?us-ascii?Q?b9amh2dkEM52JVjTOBsg1qnwh1N68VWNFLObouCzQbReOLkYB1zmCbcXg3/p?=
 =?us-ascii?Q?10s1YBtWKq5ab5lUieY6c0htqv7EmXJdct90rNnZk3E+tYYXxwFrObN/KIeN?=
 =?us-ascii?Q?svBf3bSDRnIWNPCllXJ15k4cmD3gNncuDl7kPgBrDM/0ezFKnpEVKtpCjnGz?=
 =?us-ascii?Q?kHQzsSR5HVuZ8fsjp3xa3rS2oDDKwpLjPzV0csv6J1nVrkwZXolk7nzg/DVP?=
 =?us-ascii?Q?Qn4dBev8gQsYP0wJTefznRsbN2itR/icuNjDUqU+PSscXPf+2KAxLXUsS8s4?=
 =?us-ascii?Q?9iFqD0Rofo2LJjoPH3WhnRdQ79OvOzFiICrZTu2J/dlt9pCKs6dqkBysyAQN?=
 =?us-ascii?Q?gZsv1LLb1kN8GbPTRH6c0uy1IUN6TsrnllPZbc1WcV8z9RnJViEDJOScchJd?=
 =?us-ascii?Q?bP2//yBWiqyPBQn70/7cCJo+tKcdaXLCFvCovAPpn6Pkfw2DOClkFPZ40x5R?=
 =?us-ascii?Q?NS8EO9oiLWSm/YHifGyo7xfVWYmsQVvWnUdWFmN9d09iFo/Bm5zY8Pd2BECl?=
 =?us-ascii?Q?uCYx6IzOBd05lauvKXydHU8W7fMr7496iwxIM0omGi/bi/azAE2t048KxTCc?=
 =?us-ascii?Q?lFM+Ee78Rf/8r5yRimwEMyqKaVPmoPISZPUgCFFqwZ2wdpSzEErnrAMytieP?=
 =?us-ascii?Q?UAoFpKzDQAs/kvOdKfAamDCOZLhtBCTAF11qEmXadNrO2THepqWIuAXasbgS?=
 =?us-ascii?Q?OrzczpwqLM/nWSDGOPrICriait6e1zvnwze0uUbhJZahnMs/XPYFgRGJS5Ug?=
 =?us-ascii?Q?U7n6sqj3CqEYZ0E9KNFcIHDtqYbcD1H3thZD9J7oc1Hy6SmoLECYpq72CCCd?=
 =?us-ascii?Q?pB2ARPHubETRbQ1wfs1+dlA+pahHsrDry+wRNYyTI2l5LR7hE9b+eYRH8iPd?=
 =?us-ascii?Q?u7vGY8waJ8QD9n+dBo09mYPZPcvClouj0NDptoIqxVyBX2/pHpirIjY5fnLq?=
 =?us-ascii?Q?vSiArGczPR+fLN7kwvHmrc0OGrtaXqsYYrK9eeo34M39dkCIdvgLsPDVWBaD?=
 =?us-ascii?Q?cM4LB68s2DOZ/wjwuKoGgcV8aetZU6evvxz1YCUnOfMLnK8hBgC1RZ+KGrIF?=
 =?us-ascii?Q?f0Y/HIK8j3KjEZBLFWhu13LEwQWLyYCWfbDUrMdnnYKNPMvwDw1tTHG0Hs6A?=
 =?us-ascii?Q?zhSpYBpsDgy/bY+L0POWGh14jr9Sc9xswpue3s4JWXxq3uuU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710f4d25-e8b4-41ec-8cd8-08df14be7d40
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:20:48.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdaAR9CcVM8Md6nJEGtQihJVqABUiY0EreD5F26sOLpW4hE3AyVFwHtxhr9PgHRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

On Thu, Sep 17, 2026 at 11:49:29AM +1000, Dave Airlie wrote:
> +static pci_ers_result_t hisi_acc_vfio_pci_aer_err_detected(
> +       struct pci_dev *pdev, pci_channel_state_t state)
> +{
> +       struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
> +
> +       return vfio_pci_core_aer_err_detected(&hisi_acc_vdev->core_device,
> state);
> +}
> +
> +static int hisi_acc_vfio_pci_runtime_suspend(struct device *dev)
> +{
> +       struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(dev);
> +
> +       return vfio_pci_core_runtime_suspend(&hisi_acc_vdev->core_device);
> +}
> +
> +static int hisi_acc_vfio_pci_runtime_resume(struct device *dev)
> +{
> +       struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(dev);
> +
> +       return vfio_pci_core_runtime_resume(&hisi_acc_vdev->core_device);
> +}
> +
> +static const struct dev_pm_ops hisi_acc_vfio_pci_pm_ops = {
> +       SET_RUNTIME_PM_OPS(hisi_acc_vfio_pci_runtime_suspend,
> +                          hisi_acc_vfio_pci_runtime_resume, NULL)
> +};
> 
> is how much code it adds to current drivers, this doesn't seem
> excessive for 10 drivers,

Well, I think it is alot, and there it sucks if new ones are added.

> like you could obfuscate it a bit with some macros, but I really don't
> see a lot of value in hiding
> what is effectively just standard driver boilerplate.

This is exactly the kind of boilerplate people have been removing with
macros. I would macro it..

Jason
