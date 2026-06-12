Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7FD35A952;
	Fri, 12 Jun 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273497; cv=fail; b=dPOT5qtNTB1EAe3MzF+BQRt29jrlpOckQP2gwSj4wv0XhR8KseLhLUMha+hT06phZhAkt1dw3uU6Oyq5cxjVDj0SfRLs6YB3gG9fhK0lt0upVzz5Og7yiAwFaC+Z6XLVmkmQ/O85/XmvVbPvHXh0yNbRpSHHGG+2jB0ZkqSpQyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273497; c=relaxed/simple;
	bh=v/syAKZgnbka7RO20OKjWHxDKvy7CIysP4HISZa6M/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IAdOG98l+A9XIa5QL8vYlC8cuHdNtCOZMythaXDr8XFiSkkBP4SQJfomM/F0zn7sgsoOc7h5O3vOvsKRzG07dz30ZHS5WOS/4L8qn9rk9h9/olAaayn/Dg7veR/gTKhra4pSJnUYUaHdeS/813SXZs4Q6YZ0TkU96dWprcFlUc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DG+v+EH5; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DG+v+EH5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCIVY466u0AI4Bzar+lmkBC5USx1P5R+zJUEZlg97L0v1D8irattX4+KQkhDSgxCB3k4saHN17gwUTQ/IpyH8hlqvhVUyWKQNl8AgMCaIpNT1BKTfjM5wVsdo9E5zi6X+wyGHuPC4wSR4yKumNKPz8ChhwbHGwUtl2PzGqLL8lghxb9qaUCQbV9MLHQjwyujRuAT+pt2UBif0QSOrayo24DeAXLgrARRYXw+hg5VSfJ7KwrLUjrspyW4WRbCXeC4Ff5oqTLb4nJD57UeEnWwfIGobYtyWF/XbZ4ZMH5EEwPg0IeGXR+594s3m+opcEavJLPwX1nW8CXl546EISUIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du1qx/geoyLDUIW2/VaiqCDO3mpLwxhax1tfrBlC8ng=;
 b=L/rCm/ey9IOSOvzYatJHkg+Efg8FMBowATdlJ/T+CCCre7D5eCMIqjh46UIMls3k5FPkh0hSUdJI187n9dBMyL3tg11PPePhJMKJXxO83yJQMFkyX955+ONEdhyS8P1S2xu563qmPp9dvI9luo6Kxy5EvChN+n0goQ+z/+9SzSo2BSTqZcHjwWDtXBfxrrH0fMN9zDF+wwtO4B5u9JhjD6r94W+sW88Qvp7bkOB9HzZ280e9+GLkwupevcaSJGVJEeXXXjmg4t/DQ7J+ux+DhkRF1rnF5KU12fAcOFEIdIVXeLmxOGfQ57fMHmgMms8QNFFknbLQDkX7skroBmBxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du1qx/geoyLDUIW2/VaiqCDO3mpLwxhax1tfrBlC8ng=;
 b=DG+v+EH5Dd37t6Vy+/eXtMek62xvzDVE9QcREZpfqc5r3Vy7GgcTmVo/SvLIvG2N8ZWwEbhBseH7LAhP0DQCV6QFhyMsU+ffW68iqMQqCxYNMsdTB/tlsdEHwIij1Eg60bIKRz1x0KHNnrc+m9/xmr/7nIe/1/5tbBR/22qEroqnaoGGjg6m2l4VmWEcCs1PNd3hmJDLG6tJZ+BvaYFvFT5fWZHFHA6SLMW95rDPj/cxKj8iklVOs0aiCrM44ykHkpxQoAM0UEHjlhEhXQtoJBEFLBObkHm17aKWVYPO1NxU46TjlFUQUdcusdgr0hOi4xnfxpbcatEWYevjUvYxyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 14:11:29 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:11:28 +0000
Date: Fri, 12 Jun 2026 08:11:24 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: fengchengwen <fengchengwen@huawei.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 <kanie@linux.alibaba.com>
Subject: Re: [PATCH v2 5/5] vfio/pci: Latch all module parameters per device
Message-ID: <20260612081124.6228fdb8@nvidia.com>
In-Reply-To: <06ade652-fc43-451e-a3ef-a8b6051e5c9a@huawei.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
	<20260611213539.4100590-6-alex.williamson@nvidia.com>
	<06ade652-fc43-451e-a3ef-a8b6051e5c9a@huawei.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::13) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6731cda6-5191-4bc5-6466-08dec88c7f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FM4iWilcrGI4BRGlXSxU0NGnSl7mtSlhhRYRIx0KilkDmZmGadVKw2tSSxfwdjANxJXlZXgFoI17hcTMLwLkMO8Pj9GXaTUwNDKzUEprGDro7+KbudjqyuCR44B7UOHbm+689nhok+XvaIxNvN4th5XJ5eWvQ2H0ImJn/1w425KHJe9KoW1JX/o0xF+43ohNGM3kgsicJ3TTelAa2qfUZoOBNZg/c2oO3kILcqUB71XioMY990QLg9sco+B6CRE8uaidpOqBmbK56bbAA5iYh5f+uGve/0x4SlnSgtVYfvWYTB1yTGFOtjpaHg01VizjmAiSnfTl3foLzMJYvPJatY8HzPM+2x17jgA90atZMAujhMZYD+KR0JCoTrclw8EnPz5fgG+oaKjMDFvHDbvdXbReMiK5MJ14MItA4uG1L994nPbWR8CGBkIYpHMu1OgDT5+1Wdtcbx+Sw7HcCBn3scrKxAiqxkmLSUf1Eo765se7BQwWpJLypKm/Zyrwa0GYb60Vl2Uj+BVmRxga5P2ahCzdd2d3aeIjpZw7w/j3/ImynGl5FYS0jGYBcTLAmf+HwHWu7E+j4hzGA0mJNGQNloO0OwoSSWKgAACHztafxqaliufyNMJfgJgSG3nsT/Y5uk83usZeI2fz/6ingIWUZ4H7MKdcAZRhze5kZjAu7aOns9KERSybf+MQUzmWDHRt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Yc4SY4T16JeKYSGrdy20W+kwWULTGDqB+hTwL6CM0bYFgwIbHJMIQq2pFwN?=
 =?us-ascii?Q?Iri3Ov4DvbWY7fttkDd+HV8Jbom4J8YSAnOWgya+OfPVlHQlrPmlG4bRiXAM?=
 =?us-ascii?Q?VaMjiUUrQ40Vb/2/5FLabX+JEqV6B70Jozrgq0agsT/vhLsuC/JMd/uhWV6R?=
 =?us-ascii?Q?s+fkEf3WJCnbxaPZUOHCg4Qt6945FSxrBZJjaEiMldw8LTs70QdrReBoZ6AF?=
 =?us-ascii?Q?IY7v6uWbL8j+4G01ec4U9tBfsi/HP+WU1RPnZt6gKc2ixt+tdKfI9ZNDIjLt?=
 =?us-ascii?Q?pMpkQL0+7cH3PQJRsIONAvTtsGOh8DIhRECuxrPvmEr3Ex90QLh0s8Jknx9J?=
 =?us-ascii?Q?LrgqM+CXPFE0b2xOm9e6UhbfGmTMGbUjRATQ5PJ3VYoylTYOcYa/StqbRHq+?=
 =?us-ascii?Q?NWhVD0sPoxqJf9oXKuSncdxOPnR7jPOSp1M+rWKVeUNvsblicnSCuCZDSWHK?=
 =?us-ascii?Q?UPQRa+B9tQRRMWBlm+sqsMUGenyEIpoVx3FaKRouiDCiD4H5HBsr4Mxxn06j?=
 =?us-ascii?Q?xAc7WUNIYUl15VPNfdSnBsgg5rzw7D3e1OG0XoLzqiLUGir+L65/zRbNnB9l?=
 =?us-ascii?Q?HzZXjV24GqSKaoGQHHvRF+ZsX8tL+kdGY2uYS+Ax7RBVpfCIq+pB5TRd9c2Q?=
 =?us-ascii?Q?Ru3ALNUFWCW24NqDDKkLotmuqfA6qfIWXyNj/LfgU3JFXFK38YKz0AMj2PvF?=
 =?us-ascii?Q?QZ/bMuH/RRgfqAxQoYTJEWetpwj8Xs2DizdF2QDkVGHLoeGYmKAe9ID1aiuw?=
 =?us-ascii?Q?7cUkhvhdEBBTJrBthrTD0gcL4bgJMQD3kcFjkgWC/Vsz0tGhw8Xk0ulB+ANg?=
 =?us-ascii?Q?vKQvGg37c7XkvJbZkCoGQaQRCIGZEp50QPgXdIiukyKaHTG8qhiaIYglC78y?=
 =?us-ascii?Q?s/fMC7n/3C61UirgBqVINCqFFQxXQEOpdNQKwwxtLW7YefyEXPbkhIB0BijA?=
 =?us-ascii?Q?c1c+NdYKRP6ydjuQSCFLAxYzM0ooEdtyw6U5HcfIAtcBLm0xo0VpZI4JKKEe?=
 =?us-ascii?Q?gmg6rS/7jPJL+CUa8n/KpyNWRXCNS9eXMJuY/A2lBZayECE2i1D3pxMkK2Bu?=
 =?us-ascii?Q?GBu8zc39VtsDJusOX/gYLnHLtykX5lNG51EtDr41mXl7sX4+22QrazJc5Q0L?=
 =?us-ascii?Q?bKt/F8uYyJ7XTGqkZ6oX4HOPmfYWt6kWsNyGjDevji0F/cYsM3ck0o/zgv91?=
 =?us-ascii?Q?7ZZunPiKIPhGFHMYxCfsH0Wf59D9FgCf5lyLFMXILsFuqhCrGVSjL3PhjE/K?=
 =?us-ascii?Q?v4Nh3kViES9eZhxHmd/DXmwL0mn+7kQ5nduZOSj1fCiUz9mAgX4Bnu/yAnuV?=
 =?us-ascii?Q?lT4t5bR9Jg17TWuvbrgppiOjsgOv1/vzfPXkBJo0qpBgETvAwgGpnjqNxO9h?=
 =?us-ascii?Q?bwznx5x/I7mEFpeGlVy0Jovg9frBFZACZ4GBGHw1T27F+lJgQOiB2gZsYM72?=
 =?us-ascii?Q?1BRNa3UiCI7ztrN0THuspON2I7OF8iJQusqdfcIvUYdDGtzNI4K8ozmrhSzP?=
 =?us-ascii?Q?1Ymg7ERdA/zIysGxw5Mhd2XqSEuMFzXlw82U+V/mPNxqtnaXzob58+c6qhqz?=
 =?us-ascii?Q?txfEKUTwU/f9QH1mUh0HlPEhIq4Yy6QCPi91ovhMiGqiGA1g6+pyxE/EzcG2?=
 =?us-ascii?Q?eHfj7fZ1LPaQtYyCJ5tXanqGqO9bqreH1XkeU4nmT+CKCX556cjm3cHDpNzB?=
 =?us-ascii?Q?/1igsXhTJ4nf/WuNus0P5oIlnDjlkqB9aNai+QsGsO6KKOdcKJ9IF25vvF4N?=
 =?us-ascii?Q?+fjBbzo/rQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6731cda6-5191-4bc5-6466-08dec88c7f1a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:11:28.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WG+nCzv0ftZWXoLBIyg0UMOWmfhlb1EmRz/v91FVY6A+CvKCnMh+K/kmifn/IalZQ9Vt9Ej7yP2zY/VtwfksNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

On Fri, 12 Jun 2026 16:40:37 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
> 
> Since nointxmask and disable_idle_d3 already have S_IWUSR and share the same
> "latch per device at init" behavior, it would be better to also add S_IWUSR
> to disable_vga for permission and behavior consistency.
> 
> Runtime writes will only affect future devices, existing devices keep their
> latched value, so no extra risk.

The difference is that notintxmask and disable_idle_d3 are typically
diagnostic measures while disable_vga is a feature mask.  disable_vga
has never supported runtime modification.  So, while I agree it's
possible, this would expand the scope of this series from bug fixes and
behavior restoration into feature enablement, which should have some
actual use case in mind.  Therefore I don't intend to pursue it in this
series.  Thanks,

Alex
