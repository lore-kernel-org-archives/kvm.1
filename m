Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A045041C;
	Tue, 29 Sep 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711011; cv=fail; b=ZVJ6hGeklDlzNyVoNZtdwn2uefB7Vgan01J6Q59r0LSGLyE1KhgGQ7lEaNBvvnl4L+ozapGIAsVF88/M3inJjSTqUNqK1L6JOR52iV9dXUlnHbCDeicHMmrOS+wgYIaJ1IDa5yEPnMfcx/99dGJxgo0dqPwRxCwhcKy2kRKexAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711011; c=relaxed/simple;
	bh=lX4/k0x9BDA7K7teuXw+LLBfmlkF0SVhVaE2IIhnvR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XyZiFlV+2BnHl9EtqQHQSj9u+n/HmQf6I1m+HXSjnlSZaig5QwGlcw3M9PNLYAkmHROGP1C1AC3H9/NGgd2rj0RLR+WnnZxOhs0dq4+Tf9W1g+daTdIX6OK2cXNAspgxgJ27CRHIkgUb4XEV3WJoxRQ1bfPHLAT0+iX8Cv2uVQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q0qvWt9n; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q0qvWt9n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBnCG60xhGucyOPQ27GYmQJxib+0RMeGsWr4IK79nKvrueZc3SvnJoAMvDxz/01+LKcWCb1m5gZCGI4vZ5p4iNXMnTPyFiLcuSk/HBbXG1wetAqnaSE5jSRJZVDow9cFI2tyvoqd2Tt/OK4ZnLvsFa+km/hQ6NHcyZ5rj1a+yGDKHvdj7xkW0iJFggxoRkfhLifos5xdPQdoOP8yQg6EllCsugEwtDtT6IPDBD3cchrI0l/sMeewpZo4912HcrwVJzgED2SHRj6+7VqN3TTBMcEAJ8Eh8tCmVfyFmByxvFwW/brkVRdZL+7lV5Z/qOIz9IDfxy8sZx7te5DrOF25JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBoM0q8bBddJa83jzosV2kv4Fzd9zo/RxwqZuwumfAU=;
 b=X/Jk2HAjucqLwGsDluV8ri41hBmTLFKRFnZ3oDT8iiph+1NSAr1UWRPyv98WhYMx/kofWWi6f/OfHfL1Cp3aSDWbxpMsdXXRv9f8uSkkeH8QhGaNCgMrBsVaLq3Hg8APT6aqFBwDJtwWKPh4S62ibJOu2El3g34Dosd6rKRj3jIoWjyvuAx4CiWrm9lZRZ8+ymz+pKwgvZJeViWC+eR+FD/vWUZp5GL9UibeFSmA/PS3ZQxhK1F6g2B/Q86dSyOfBorMoDsYWJlhsSx8qLYVj0+dNvFb6bdvafvHNDUqHCaXKKnmMysMceAkm2xjTGKX040msa4JMLrmwoa6ixYILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBoM0q8bBddJa83jzosV2kv4Fzd9zo/RxwqZuwumfAU=;
 b=q0qvWt9n9TdgZ2vY7qL9tj/bJ30osOHx3KrJdbIfh5//12hPqf4ETJyAk9JyJa405hZSek98LHxq+e/4I+QiQDaDq6N3KR1g9x2EBesAhTsvBiuAZOTnjLnr5Be9k1HB0iZgDYXslmx3iZgQXOI6pQazjN2mhf0YZaNGCDUD4IQAG8OjLZT0N0K0lb+48MnMDwFTgBrVRbMsHjgVM1pjHG3LdNDsyijwNlz8UyzXuBbczkLa6b4ythMQA2J2OIGcgXgI8EiDZxiZIqagkewsYrFZUtBkW7lFyBbCODFAJTW8JCqYQmG4UZ38HpgvKLmPcBgYZdZJeegjLa5KvqNRlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV8PR12MB9716.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 19:43:26 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 19:43:26 +0000
Date: Tue, 29 Sep 2026 16:43:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Simon Song <xinmengs@nvidia.com>
Cc: alex@shazbot.org, dakr@kernel.org, acourbot@nvidia.com,
	yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
	jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
	smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, zhiwang@kernel.org, zhiw@nvidia.com,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 1/1] vfio/pci: Remove the core dependency on driver data
Message-ID: <20260929194325.GP1616761@nvidia.com>
References: <20260929173102.3544151-1-xinmengs@nvidia.com>
 <20260929173102.3544151-2-xinmengs@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929173102.3544151-2-xinmengs@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:408:e8::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: c4711abd-a0bf-4e68-2144-08df1e61ee2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sxDQGOI7x86Rdmtn/MvZQ0E5DlWF4MKVFkqDfRJSkCj3+qfp31a+7D+SY+beko9CB0Ju1OFMdhAdwqIYAQM2zkPcwf39GRNmy5pqEd9OZQ+JDq0y3n8Df6jSwEJQhrzMSKZbGq6u1H1cJLbkHs1TnGB/pOV/S1oWY9AF/iI2fkM6CSGplQggM3v42JTDO5lvv4WklyVibAGxIcKx6/Z0e8lnnLwUoFifAUSetj2wm4RhLhQ7GH3QX5jGeDixclNfxZq5Z134gnCALxk8cwfFTkPyBLWJnKpxeRQOc8bQibr4+2G7B1k407W1jR5Ub3VYqWJD1Oe8LnoZGbQlBx8OUwZDAgEHkJ5Xt1oa5wl653vBt77kslvjMemBvVmOCltzO8k4d7AV/nwgXuO/6MutzugObo//5PQpb1XH0+U5jNwMYmKLHC20HDQJ7NQrcZYr0dBJezmDNAa6kbnsBdcAEYnL+jC83KYSZX9Cwp70xmY3P66qSX/dQGK6wwqJmKJcq3t3+KF4FCxr+VgI+v4V/j1a4E6Pi2TGz57D4WKt3AISZBj0zME/jPhmuTq6pfsdfIYQSFDa5UttK9f196hG74FbyvecHOA0bwc4bGMwx6SnroljODXnIY6Pj3OY3BMEs70usX5qkh49DsSbdDCsQOGe2drwtdNfL5ZcOLWESJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCYTQKZ/OLwSRyjPJ/TQd+VAIyGj/B8mKvaIxbYx0DaogqSnF78eum7WU7k6?=
 =?us-ascii?Q?UULlXER64J5XSJyMSxUqja5aKYQUKC8SbWJQcj8RZSj4SUg52z0CueQDRAGo?=
 =?us-ascii?Q?0uwVv92Up1ZexgOESOxyeVlMk2LO6G6IX9weBG/LLcDQJztSQ3R9SsQD/Cem?=
 =?us-ascii?Q?hzvoJoYk5uv6SrLpotWQUFG8AuFHpvQgyUhzEK+qCdIkUIfd5JaVqoL9vBnG?=
 =?us-ascii?Q?82MYYANSzKzulPxWP4BbEMU9s6wOAufJHxg6tqIghcW1SHr8uF3evFeE9xvQ?=
 =?us-ascii?Q?npmRXS6tTAb9iw379kpj37QLwSq1+sY1KO3LzRA4p8lBpkWMkb6+u9PkaHal?=
 =?us-ascii?Q?vVRgsjC6+2RaNbk7lmhrfQaM2U6HHObfPGBGHokXilg3H+pyLWsmgN5dXjsn?=
 =?us-ascii?Q?LgXTQ8jrMov0mipX5CbP/zDa2zxqt7GrF28+qQzb7ohcmDFu8UNKjAixyj4J?=
 =?us-ascii?Q?DAXo9tuD3BOxyKtpHsb/n1Vpq+hqY77cfkbIyB/pFUnaXzFBLyJE07N2EFUM?=
 =?us-ascii?Q?ccRkOQ+V9ZNV9SO+vdAtd5IOV/c8KLgNPTlo1FKSFfvOfObarVbw7cZ3IELX?=
 =?us-ascii?Q?i2XpO4glFjQFAaSdoeh7c2vEm/Eiu9/aXqjbeFQZZSr+D7d6uTVdTb6uzIi7?=
 =?us-ascii?Q?J6or7SrhJPiyjJzdCGuOippfhQIUroYgO8dJQBlKsoXDoxrTaIM9bmwc+0V5?=
 =?us-ascii?Q?d1PZi65Ehd1VeqRc2kCFmTIGI6lGpZ9qn6su42ap/HYdXwkvz7/+N+gzPcFZ?=
 =?us-ascii?Q?qMG69tezxe9qgWZjuTAE126i2uRiwCuJnkKbcyAmWRoGhmi7grXgLL9zerQc?=
 =?us-ascii?Q?nbmCTznOwCRA79j79qjs9CVbwlHyRZI1brbxKEczVdjNqpW78Z4+aKgQtOgV?=
 =?us-ascii?Q?CpTpNPWaL0Mja+CE4Oe5BySmxyibqAbBxtH16zCIcjb81js85Cg9FvP+gdqz?=
 =?us-ascii?Q?owDC3+OEK3L4MQdxOlwO0GDYNG42BsRmAEvn3thnZHkYsDevTlvkVmiZUnj3?=
 =?us-ascii?Q?iL487XUHE59SJMSi0ZB/uUjp3tX7q8CSA2YMDTZ5AQdt+697hXbSMqAnKurB?=
 =?us-ascii?Q?c7aeOKrvW43yhxf0JuaZjR8AX4mD86HBeez1MWPC+x7vsiskOTGuJCKPGuDi?=
 =?us-ascii?Q?wi+ESRO7l8unBinD0Wk4yHieSQmgKrAtMX5M1MdkmlLua+0NarBCi9xUu016?=
 =?us-ascii?Q?9g+Bk65zUXvY34UK6nSz7fW/0Om9NkbY4WFW/A2xJ090HXWdmqo+4qcmeIkC?=
 =?us-ascii?Q?1rGoTkPjGqjRAr7HZporr0F//iPXcsV3bXxbZ3ujHxtNzmm1D2nOqnx4jrfY?=
 =?us-ascii?Q?OJC3jMixCXeVaeK9kYIDQcpolonhNqigMlm+mWvtRy9Yp2tAXz8p5oWqd2K6?=
 =?us-ascii?Q?4hjKxMgaYb1H0UbGnNFdqCCWa0vbYkjbprOaQZy2AaSgBuVidO1VaZhXKInk?=
 =?us-ascii?Q?wtzsbIwEuRhXPomEvC1EnptKnykh8XVi4KnHg5PMNhs0wn3eyCFXpf0uQ/D2?=
 =?us-ascii?Q?N/b3TC5Yv8ABI0+ht4rabYo3unNgoM2pEYBEIY+u/sgK+xth+HpVOu0oUnND?=
 =?us-ascii?Q?6r1Rvte6k6eeB6TGhGF9STpm3PK/qWAdviqnQ6M/Z3ojuxlEluqveWXrhHUa?=
 =?us-ascii?Q?WAyVEw/89cv0+AC7mGiJ6+F4b49QgkD45gVO4BAB6iR447TuDsh9FvwroHEV?=
 =?us-ascii?Q?5DHoJbYDgFA2FsKeP6wZctnmBivBXoBmxQUiFcQ4l8/GNa6Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4711abd-a0bf-4e68-2144-08df1e61ee2d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:43:26.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ojvovp/LSuugKKR1iLzXaccHV7lsI642LOF1wKzBpT4+se072wkzIX/bokmUGZgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716

On Tue, Sep 29, 2026 at 10:31:01AM -0700, Simon Song wrote:

> +#define VFIO_PCI_CORE_DEFINE_CALLBACKS(name)                                  \
> +static int __maybe_unused name##_pm_suspend(struct device *dev)               \
> +{                                                                             \
> +	return vfio_pci_core_runtime_suspend(dev_get_drvdata(dev));           \

That's completely not the point, these macros need to cast it to the
drivers struct first and then dereference the core struct by member
name.

Jason
