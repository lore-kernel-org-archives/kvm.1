Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48E51E451;
	Wed, 16 Sep 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568755; cv=fail; b=SvrFrvKZ9QcmayGNJ/q+m2H2ukRyafmqJMz+TK/z7oO2crePvByT15c2M38lPSmiqeMeLAcHaPEDnyPEatNIEsUPBjjEZL6/azEhexnoriULwFAcRXE9TzA9FwYS8NWs6gyz18f19LRKOPzy+3YoHrSe2DX1DIewi7z5OCXcaJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568755; c=relaxed/simple;
	bh=Q8NToYwaSk+CklKDBr2eeC7oOo63+CmG3/B0NuVaszs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jl9bGoRK3TNlRBA6yFtGwgJ0txOJKKw68KL9e2qzHFgLPxqott3JWge3jxIs2yxMMiOONsjpIhqPEjL4UJPVU2vXcOStSXG3o+B7rGf6Gth7WH3y4fCYkDYQRDIEeqaBP/PhFRLFsUftuZCqMyXv0Dql5aGTB5wIlWXmFxRzoLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KncWGc6Z; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KncWGc6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLQbFtL/RHOCnd1NSjtHlyIhbWnyNaaUN3LilytVUDWormbnEJ84bHt5FecNolMpApFh9sGX7WgwBRA3vHQLuAqjGXsUVPcc2XtJJGE8ZgLS9L+MYzmiCuhV4ByZZwdj2vfkb9cl1NDtQGjUU9mByR/IAEpYXdAYlKUW4WdcWtUPQkJidLqBT7guTuI5tpUjQswlS7HQ8jq7blwvtinNU3CJc5c4+IpdBuhZUNNLtCVgnkWo60b8bZmse4Q+b9IMfIKG11rAJjq5wNErRQcUFORDb3FF1Ko5IfJuPonoQRxjEwKgwt5rgRQv9r0Stg7bhEG4l4hJdNt2v3RfGhpqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlP9gIWboaLYe9nUUvQt9lVbsGLvJhmaR05ebLfIMic=;
 b=QmZJ1tZKfQYLtbk5NqGOO5n8NVECtaLSnk1Cl99LD79Oo+3A5pgYTjU6/z/uUnWF4OlcihO0vUop+hgspNdbyWq9+Yh3BHKGhSrvBib1UOBjOS43VlOg8sOgJuTIIAx+iSi3h+SJjyBltuxM1Omxiu/j6yRNRwv4zzeltkGIpZAHwlYlBb+hBSLzdoe3LcUrJDO4+iaqfE1iWyMt8Hw6jJdoV3/SfVNIpt7tuUhRbdcg4GwwRukkpMWJFWEb1Aurg+zpbukSwrGi+e1Q1oRz2Bjsqug0hSw0asGPmo702bOPMNqZLF2RcQHQ0iUBccbaEL83l28qj/Yr/SrDiy3HLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlP9gIWboaLYe9nUUvQt9lVbsGLvJhmaR05ebLfIMic=;
 b=KncWGc6Z29nowVJC7cAUTmQdZlJJwGRmmVFl7e9IinQjQjK+Q2gxB2sPIHbFdxKmV2KFfF9pcdsOVOyogSrz3gS6o9KQEzFdKD1e1YtFZy2d9RVOrfYhffDLwo8AjmKe3Y7XTscZngefOB31taRZvZGWvCjVepcMYIMXjNV92r8GNNk1N7O/id7iFOZblg9Y4s0taBsk4yvJ1RTUr1KM5szBrN+oQrlCMNN+TUiT6hZvCrzXxXXfQ/Gim28/xRNWNYPa8HH6zZ7zbkm46X0idpUxCmAJb0DtFUf0pcOrhaHah1DqRJHTswtMrsj57pa2bS1++2mAQz4FKC7pJDjd8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS0PR12MB7925.namprd12.prod.outlook.com
 (2603:10b6:8:14b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 14:25:44 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 14:25:44 +0000
Date: Wed, 16 Sep 2026 11:25:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>, Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <20260916142543.GV3968357@nvidia.com>
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <CAPM=9tzwkNniadSABL-EfLn1hKyw3Am=seX7vJjJbXci_5vSUA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzwkNniadSABL-EfLn1hKyw3Am=seX7vJjJbXci_5vSUA@mail.gmail.com>
X-ClientProxiedBy: BN0PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:408:ed::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c5e1db-e4b6-4ef1-bae1-08df13fe649b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0YRidlklJXNxGCjNMvblXbupJVNey8541I0IhyAgGzSeUPo7459kR0lDYmO8HjvWBaU11akKZZMTDWiLgNmLrNd66FKagCfqAgvzgd2sA82YetQF+lCNqdfanJBXaS6u9/v0pKm/nS1W3e8FvzdS3ZYJiBZtRkjzeB/u2khyTy/9W4v4Y14CLB0osZTP8Gd4z8I6qC2WUrbMvsEp3mjioAq0C9BDv9LfOl9wxKngUjT6RPeqoPcUqIlpoY1fW5srKppqVetvQN9MSVbw4E7IZY9biv79HRp3C9ZgCAaCRANP+k8/bs/zz9sv8h14bY74QMbYwzNv0AHiwoZ4189rYPXY1CUL+uu92Hv7bFe77cx1EcwvLJDPuedZCK7Q1qFKtp6MEPvZ6jjUSB38J/1+cgSzizF3VYlKcYaVISrUwCM2MbcKVmqYj3QhnLYsTiBes4rhJOjgxqUxV99cTsN8t3kw7WTXm6vEocHrF9Ok1WK0XQZP0Z8cC/jQrzB73lKrixGZ1Kj8lcem7bdrTsCmpJZHob5O7q5+XEK8EVw5R/G3xKbjQpGuLJU30DpaPvPWsnrXZUEs+E+2Dtq9X+V1+sGdYB55sXuuSlCZWQ6Gir0YpviydrzOy+dQesqloTfD7/h6bb26/1JRnOz19Welaa+fvlfLRDW383vZmS6ocPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?voNiX42zfM1jrImJQetxNQqPMWb5jgPFHzV6KiBs6bgMUQ7B/jYH8FCJjfP5?=
 =?us-ascii?Q?xFcwMH1nNYNz5f9mTQ01gONLdAFpKu9//d/ce3GG1Hg6t9GmP02qFuKKh8xv?=
 =?us-ascii?Q?XLN7y7EfQzFTgdL0dazAY7Ju0iHwSgLr3pbTiRGctx6UeYv8MuWtM1aXgJdY?=
 =?us-ascii?Q?Q9Fy+CSooaWV0fOsBJp2fp214KEpFb0fsAdvMUkZuCxrbLWQ7Dgfj6HAfsYP?=
 =?us-ascii?Q?MAvitEbgpFT07ERaekYKyrR16ydhy2M3em0k46Q/O3MUTqcwzvSJlW//L4mb?=
 =?us-ascii?Q?5H5mb2deDp8EI8SleCgxeAbhgzQ1MG5H1cV5rZyGN1qgxe+y9+g2iNFOJ3OE?=
 =?us-ascii?Q?docNLgbYok00Tgx2O+N96XVixvouEx5JeAKdWxHv2LpDNAoU8z7F53Q7R0BX?=
 =?us-ascii?Q?APXH0d2Jbi8HsbJcsm89hl7tR9hvxM+X4u0D8BXY5rZFSJNHmAXV3RIf1PdY?=
 =?us-ascii?Q?CzgU0KJFLNZAH54VFwJsIP8jJbqDv//QHh8FKPloJ/LX9qWp57jP+K30djrC?=
 =?us-ascii?Q?bCk5p3W8mkf+wBLqXVsj4sxABirUD0PYdQOOkW8FXCHLVN5eT8z54GXd5Ws2?=
 =?us-ascii?Q?sihQvsVhG58s0gX6Uz81NaWpSnw3cSF2m3UpGODQc/3CNul2eug3U09tzVo8?=
 =?us-ascii?Q?Ax3JMhmW2tiSNP4h7GJF4RmF20FTSTF5S79Uvs84kGKskvfEL9f6CeJTJc3v?=
 =?us-ascii?Q?oMvEDFFyWXF8mKI1Vgw02sS29DjinkA1XXL0PYuZJftlRXx3ufEra1cMbMNS?=
 =?us-ascii?Q?FUKR0yjROGYcPbiROVBnb10/0H/HUHElWaamivLenwFZJJrizoS8wOPXCWPQ?=
 =?us-ascii?Q?eepPdiahZexzckRFELnBGqgXdnfBNScW8wn2IXLqNcJNIb6P48+8SevH1To0?=
 =?us-ascii?Q?ddkmjaQ7L8bm+J5ri+4IoAfNPhCVmzvkbo/IanFigrb8MaYbwnX/W2WjJzOt?=
 =?us-ascii?Q?elae6CJDDdIFGS5we1a7hTlmNoeU2qTV2I7jd8qrCfM9RSkhhrWE3FTawdtg?=
 =?us-ascii?Q?OwejyLwPtLCQlnY3jwFbMQE/3VqmFyCEi2cdaD32sAjlz1oqghx8he4aq4Wc?=
 =?us-ascii?Q?I4SA0bDEnBwqMQB3+o0yy/asqDB/FzauX7QAEUo4AitHPWNb5kUf799ud5on?=
 =?us-ascii?Q?t1kmPfOE3xZoLwYXWAf7XJC/0/stGRiEPKt0WDHF1PWbPktvSRKEwiP6vqDt?=
 =?us-ascii?Q?EOnr6qeY2OCvwFDDhq0CoGxFOdPeRKE9SFJWC9NqmOqOmvWBAttnbfS5rqyN?=
 =?us-ascii?Q?hCQQIdEmweSn3VqM04w9YWN/jJ1XllvJyqrsF+mOTu3pA9mtaEYZo1c90xwI?=
 =?us-ascii?Q?V0dBrebyBoyNcVgAbnfscmu+sggqe1MOqnXA/RfaiOSl1/TdfahEK/b2BEY1?=
 =?us-ascii?Q?F2oLvuXEbt7cxo0ofw10d2D6P18AZbcHRXv0L9PlI0ZHF1/4NGAtKkJbq3r2?=
 =?us-ascii?Q?lZXiW6zDJkfnXkDh4D3xjeqIbljEk9BHH7QmACDIlI16mri0npsT2vPDfU96?=
 =?us-ascii?Q?gFiw4EkrCa3dqrpO4ddnJTEy9cVRuJzqgB1IoMlvPYTwocG6EgM9PU/injvo?=
 =?us-ascii?Q?6Lt9B1DmnJO3uMpRq/WNa/7/TCdqbMMyEyNRoWcCcc+NVKgFGlA2nFGFLJdh?=
 =?us-ascii?Q?xrdDvalzr8g+sVitDpJR5jO2NvqjQlR8a+mVWT4FbwtwrwTUYaAUbj6DV/he?=
 =?us-ascii?Q?cG6KM8K4wgW3JQEuIa/Dz0VGLvJdIvfjkejsXJ2E0VeapKdh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c5e1db-e4b6-4ef1-bae1-08df13fe649b
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:25:44.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4DpqfnsQoh4rfGLwZmoh5iFKiUJcIdIhFBtG+XJr5Rb2oqjgBykpIi50HMkU1ms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925

On Wed, Sep 16, 2026 at 09:44:35AM +1000, Dave Airlie wrote:
> As for the rust stuff, I think for vfio your drivers are just not that
> much of a horror show or refactoring often enough that rust will be
> anything but a blip on your radar, 

Uh? I've been sending a couple whole subsystem refactorings touching
every driver a couple times a year for what, 5 years now?

There are still more that are needed, like trying to redo the drvdata
apparently. As well as stuff on the ops side, and more and more.

Granted you are looking at it after all this work, but there are still
problematic areas. drvdata, some of the ops, some of the locking, I
think there will be alot of C work to fix things up enough rust
bindings can happen sanely.

It is not so easy, your LLM looks like it put PM trampolines in every
driver, which I would not like to see.. Not sure how it solved vga
without touching drm..

Jason
