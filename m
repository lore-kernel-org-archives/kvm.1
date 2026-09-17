Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4F370AFB;
	Thu, 17 Sep 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669618; cv=fail; b=C4CeO3pyrrke01GC9ciQdo5twkBnkFcntuQtaI0KMxCORjQuitl5sFs2OZ5H8tbwRIXLgYr7MdOdJTWtlRxczQotbxy1hEuM84r7BIR4Kf0VjgBQkpLKVcQe89onVrpfc7qiq5L/EATZXkvB5bKqPBnxLKjv9MsZASo7ArbcrcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669618; c=relaxed/simple;
	bh=kdz5oC1fUXC+q9so7nTIOoDK9PPYa5LRf/Jj1Cb9HJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O2M/L2AOatzgjzKeN4dh/IHYqiHtFIOt3ni+siRY942GROyha9lqwvKn2U91tfZhSx1WZ5dKauMjHQkGiRWx0A4sb/cx3wrZ15K42zd/5ahErUHKICl9eCNXJaDWRM7OCNtuGQ4OtOG9xGfFR/K3ieTAhGooN3POncDh5iLo5R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neyB3KZL; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neyB3KZL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/NBBrsA07E9K8JFz1zhUR+RZ1RAyfuRtjf8wP5WEgh/uDVPIJH8xE1NHST6Wdn3RI7inmQe/pv+obGGJBSbC/mUsSP1w/A8TWYXK/8Y7xmpbV6HIHUvB5WoALELlM+93ordF9lfjW6d6paVnH0MixYlzkyNGEl8QgHT1siYovHKlq8/pgyrxY8+V3Yp2nI2/fIm+CQfUSochq/82f1IfuyahXDkC9qHfs1zBRDednCMJ377L/wreDORKvhdAvexzpGNK3bgcT7nO+DOxHPQ7Jar3hhRODakRXkTRnL7CKLAlsA3Mn1ce7yVIICCajGl2H+dlhdtR27Mqiqw7WsVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhjICdduYnGsnXLaQEioNFx0GnKLT3SZilYpLWhyQrw=;
 b=NszfkqgXPFjGVSm8RLkLVIKmwUm9lLQMQyQ5jmreN/4wcetHRrTyr10362oSfcaKjB0sixR/YvJ+PE/Sdibvk7Lo2KrDw4mJdOtzYVwVGrRRhiWEEGVgsS6MjwXk/LTvE4HfpEuG827zAe8uflJxFMeD4PgEbETEMStUoyxFd3tuplRLup1mHjrOLmgYn5Py9PbCj5D0rsDRZqVkExqoA0DbKLBtkW3hKcmBHilWx2sXnJ1VxR0pDjzWAaW3dS78MEZ2h6vZqSHWOHCBis9645owNTAYKml/7WIqc2BOLX1QIOUo08uHQcdl/R73eu2IEGhtcYeZjrLbmjucTbFvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhjICdduYnGsnXLaQEioNFx0GnKLT3SZilYpLWhyQrw=;
 b=neyB3KZLXO1nx7L+GUUN0Av21/VxxIH85+PsFQN7/lpwE68YpbXcBNKT3yg5QZO+fqo+p0jvTf9EEerppQh4DP11LBhjjYJVdMb1Yzbu/hC7unAbTBCFMReiTY+WMJ0649WfwSQ7t0iE4HgQvDPJcId16JKjsD/yJZ8jpXZmsCGiZjbRphk7CjvD2L9zBZ/ahkjL07jYErsf2Hng8ouTAaO6z/XB1VemZsqGR9w/txT2UkM1hfVolcZrkChW/u6rAMUUdlwmIUYSbpfQU8Mz10CgDPwVW6Cv2NWpnmyC2dMe2Y7C5jXk50IwhSblGrYCRUnS/zzLAAxpb+abP3Xsgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB7716.namprd12.prod.outlook.com
 (2603:10b6:610:145::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 18:26:49 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:26:49 +0000
Date: Thu, 17 Sep 2026 14:10:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>,
	acourbot@nvidia.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, airlied@gmail.com, simona@ffwll.ch,
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
Message-ID: <20260917171056.GF3968357@nvidia.com>
References: <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
 <20260916162817.GW3968357@nvidia.com>
 <DLGXS4SCP3VT.28XXX09BL963U@kernel.org>
 <20260917132829.GA3968357@nvidia.com>
 <DLHOBJB1NYJA.3FCP9OLPBVRZA@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLHOBJB1NYJA.3FCP9OLPBVRZA@kernel.org>
X-ClientProxiedBy: SCXP298CA0159.CHLP298.PROD.OUTLOOK.COM
 (2603:10d6:300:14d::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d78b44-c958-49ed-2805-08df14e93d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	81HXB8ho9IokFZvXNFeful+kz/KeJcnhacHodPHqf0fihmR1esv59j+z6dB9QC6coZQKdiTKuiDtuyxY4lYdb1Cg339aJ89UFzxNgGYXARGZJOL4y7zLieDN0XDtWpoBl7iabxDHZslH6WlTcoJNgvU0RV+BRSdzYIrEzMQ6YBXjblcnu4D/YrSHghUNNQoWgaPuB76FACYRJ/RggJJ17BuQMx34Tau2dKz+6vOqm33++r/0CJr8nHaHnxA5IZWcSvNnTmS3uJs2vUFwlIbJ9MkNaOCMn2v9vmXK7g/KXUGuszeeqcHvV04yaWzAXgpfBJp2v24mfwUsnmMyJa0+bL42+lTsNceJZK0EsqEL34GWoWaoebp0IfCRvsGfXyW8D8/2VEV+9krIKYaeR5rpIt5Tkh82KSg92LBjh9/WW2zqUhKJB1FKuGV+A+VRXMp5cjpZO48ouxGU4/cF0BFCo/cZdF+MyQ9I3dS3x6Bks8fMrQWMmx39fJc0RDoDaTwR+2L49xp7EEnrSfqNeyfMh6IydxFjT+4xjvFHK5rIY9A/KClob3CZLOQnMxx/mfAfdE5V2mh0/Pvp344p8uTFdmYSnXu8KYhGcNt1v6nIiGmrpCNjoKiI/SvpeYV45Q5C2b/BWEZRDDaue+/GihupTE7TxRs38G/gXk/ZVIibTqQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AqTG/W0Mnc5GbSMDG5QhK3J7mcu5vE/NTm/XHC+Jw0sk7W/upBtTpfo6Nr26?=
 =?us-ascii?Q?QBQRiE778o8DMwNQC05pWhHJHcJCVMowDHsrPnZR1PXmCv/rPawjC9xN9/SN?=
 =?us-ascii?Q?uf0OUZ8Yy260e3oao3JEaToCVJ4e99xf0LQKhaRBDgrrBTPvD+yUatqp0QxT?=
 =?us-ascii?Q?chb8AglDF4z2SPF3SyEuQ2BOe8sFATry1EWk4l/BRgGRYARdnoKQyrCAXT1r?=
 =?us-ascii?Q?Nn86jRJrtdW2EyaXsGHa306aDmKySsGsPbH3ule+pgHGETxwnPD+KykeoaFz?=
 =?us-ascii?Q?fX2xzYsd8+S4MO8Wga2uhZBrFxffs36CcDQgRO32ZOm0W3pdn40OgiWe+YQA?=
 =?us-ascii?Q?PYmcO31lHQ+fnK1tLlotfGZIvEo8/qVPyLCP0uMM4/6KRIQFy7X53DioFXhn?=
 =?us-ascii?Q?5TZ0WLIXC6yrW0ebIb0n+6DORkPMPmTUnHsR4CAKTIFpCMFO9v5axYjye46g?=
 =?us-ascii?Q?i7Uu3pvv/P8GtUiTICZJl0CRX9khhtGLrN9DGJ7qnE5PJNhWHKGmH1Mar9eF?=
 =?us-ascii?Q?XUJOFiznpM3BhD5+lRiEHPkFhOxJ3P6eBX9E5sBxH2H5F54Gs6G3ux2kVOmW?=
 =?us-ascii?Q?SeA48ySPWfASv8WCxC1AoI3FqH/NjGKSw/eK9Bn/lHBTJG8pWcx8bhwuERGR?=
 =?us-ascii?Q?iGpjUGlqtUr2l0HBRT96Oaz/ALiHcGCw2+jWyANpRrUWaS6uEBEItoH7jgLO?=
 =?us-ascii?Q?ncBAVPT/4pgYz0TIwLvZb8/GQI8/GYbN7ffXAtnZZ8RwHfRCBWUNHDWfBqOl?=
 =?us-ascii?Q?RfD6sAmJBM9vbRDh9d03Y57eeI218WBZ/scvmEnQabP3ibyp4cCk5KhyeZ4+?=
 =?us-ascii?Q?AM4wHdbj/HJ9jYIx/Y5nJylT8bxxRCIsWBmsVZ1za+05CD6RVDGU9G+J33C2?=
 =?us-ascii?Q?lQnzFg9aDrOeJSUyt3joEmtwVv/WPjZM4ZU5MJyURwb01WFwjNveufle7PKf?=
 =?us-ascii?Q?yKq8cWwIjtgRPectf0otZv061Hg37m3+2050shc9sGcCq89U69KPqxGDcwth?=
 =?us-ascii?Q?DtxDFucGtXOyo5EjqDKgwa+hhNds1BASyuS5AcHAurwMXyF3VW5GGy+l79tl?=
 =?us-ascii?Q?epnaUBvFhPYntvLz/9TEu7SWNSMDrS1fpsGuNICjdH7VCR2Kir8y+Vp3RXnJ?=
 =?us-ascii?Q?m7JaVh6JRWaT3Xl7cqeSOrf2+3E66mETaZnEJ7O+oVwviXML3muCQshIUJ4g?=
 =?us-ascii?Q?1l7uTBSKNqvVVb0lp0LumoZt51tjUWKCg7qcZTuLZE/kJbT/Bin5iWwiEM6L?=
 =?us-ascii?Q?DQvtY6jf9KC+hJgPFyKhI5ce4/JdxSsnLXrilKrVTi7Bzl1JEHj3jgrXcMRw?=
 =?us-ascii?Q?axNvS7CAgwMYOy2QwDfWja3H+Tl9KA2lAE7coSVlN7xGEARm7j5Tu27OBAgn?=
 =?us-ascii?Q?7NyYQr3/GD+LcDYNbGCcdD9TGh9bPrvntWRg3xxQ8uaFGRaXGSu3OKbSooWt?=
 =?us-ascii?Q?0M1n8xvQJ03UqZDVjGApU/TB+CzcDYoDzI4Ha90D7Xz/6F4vxmVJgp4Aht2k?=
 =?us-ascii?Q?iXI+4b15Z5yYBGXmjNxirTDzC9ln/p+TzmmlaGmlYp6/Dro7BsYBYoEBPf92?=
 =?us-ascii?Q?vBH7qMoWIC/b+i/uJ684olkX9uMLaFGxk1PsqeNHEQZf+et0S1owd+Sx+Qqk?=
 =?us-ascii?Q?vVtnfDOIr30jkYH1v++lUiUJfCFe+1Ac0/gf7qVC9ZY23P4JpDxigUreNhlV?=
 =?us-ascii?Q?ezugFj6LFJrMR6zlRPOTHLEi3imWlQCAx2f1h8Y7aas326wB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d78b44-c958-49ed-2805-08df14e93d06
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:26:49.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfL7PvgXTSWJ62SgJA5C2idyEiGd9WmpsfEa4rEBJhOz/MVBHPtkOT7b5v9y6OvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

On Thu, Sep 17, 2026 at 04:50:07PM +0200, Danilo Krummrich wrote:
> On Thu Sep 17, 2026 at 3:28 PM CEST, Jason Gunthorpe wrote:
> > On Wed, Sep 16, 2026 at 08:02:17PM +0200, Danilo Krummrich wrote:
> >> >> TBH, I don't think it makes a difference; having Rust abstractions is pretty
> >> >> much the same as having another driver. I.e. it would be equivalent to saying
> >> >> "before we accept another pci-vfio driver we need to do some rework".
> >> >
> >> > Well, it is, but thats the point when judging effort..
> >> 
> >> So it seems that we agree that there isn't really a difference between adding a
> >> new C or Rust driver in this regard.
> >
> > To be clear I was trying to say I think you are are underestimating
> > how much work this is and how long it will take. Including all the
> > preconditon C reworks has to be included when considering how much
> > work is involved.
> 
> I'm not sure I follow what you mean by "preconditon C reworks".

Rust bindings often seem to need C code rework for Rust, drvdata here
is an example.

> Or do you refer to other C core reworks people are working on? If so, they are
> only relevant if they affect the drivers. And if they affect the drivers,
> there's not really a difference between adding a new C driver and adding a Rust
> abstraction.

A new C driver should not need reworks?

> > I cannot forsee rust bindings for vfio until sometime in 2027.
> 
> What is different in 2027 than is now?

I mean I think that is how long it will take to merge something like
that, given how many other vfio series there are, the lack of
expertise, and some general expectations. There are already lots of
series for vfio that are in front of something like this in the queue.

And then we end up with what will be one of the most complex drivers
in a form nobody familiar with vfio can review.

It just seems like a much bigger thing to me than whatever the ffi
problem is..

Jason
