Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120040;
	b=TFGRZNXAD7MQhNhg76uThkZLaiQm3cYdXEaqvO+ZDYFJeiOUXIfdGqHsPkhIHSZvLsTc
	 ZzomM3lWXqlZD8QLZukxXXtZ35VbKuBTdvi+9MmV6nBMBu/tAnz1BmF4+vvwsoatPf7kv
	 qYTCXxx8/u3JEhvMkgzgsFiF+SPFfDTAJR5VsFOlH/j2L95uRGMNKbdTB9KWa6R0MyPPg
	 J1mDheLZv6WNvL2/7SRcGBWafSMAdcIfyIvZt3Fj73EFgjfOreba3YrXPfLKiBCUb+NTv
	 TtUolPbbHbhP4n7L6tyJub1ipfrrswYkPPxpxmN15TcW9gvHSql/rVE7g6lpzJP4L5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120040;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pzGx4mZDkhoBlIEVO63ehSIF03akHbu0RYHS+FQIgBw=;
	b=EtsOZ4iSR5qoevsNVAPEfysuouZzTAOcZZ8il8WOZYrDJyWmfnZOF3C26+uTPJVjTFVa
	 qqi3IPX3DzhEx11sbAm1OfUSG2i9y3f50eZ9SRaHy2j3q1/LIvh5a7iDqJHRzG2ZxU3Zp
	 SFHYSqoRyNA3jzkr3jvaH8rZ53K2rhgLwBTFFT7hdPF65vL7Hr1xSlYq6X8GPSqd6YiFH
	 acbYPOAD751ePmQsrj9pHtcOn/L7WJwchFZMONDvP9BjTGrYC4mjaudnFgGLsn7dWYO1t
	 1IK68KswfTX8N2mY/A1mUejFFPAo8HMRitgkVg8mXqh5u1Plb7Q93nfHPVh6dUN9TsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X0kHLVSd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.31
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1E606A33D
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 20:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B1E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X0kHLVSd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw5NSr8Skjj1RoS0H/sf8icQZH/gBuUZqkv5WgqCNcLffovykzlaQ/XPV3+wkoWM2j7UYfPVULkb3qn0Mucv6taMCdAH5v5Xc2lmOLp0sKn4/4IF+TeU/rdg0jRAPmhOvPujUGisIPTQprIc61hfOKh5C3kqlQcG5lAB8It6S8SH2COEX7GQSjpI1vvWaIxUzLiDBouE64kIMR1tcbJLoN8vphgYyZWfBijw2H5N2bU7jfxKrq+nwSvzeOsFoghzQtfFFeircnLFXNbfmwJHENPKnaju0gWLgIeUDvddP8IN+onN61L/BjLTiRR7vipV6miDZk5CCl75cu2nMvlq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzGx4mZDkhoBlIEVO63ehSIF03akHbu0RYHS+FQIgBw=;
 b=NNiFkZpCwI0cZhebh3c7b15i/ndjdUj3+4G1i9TMzEmaKQkMgETK9g12El7yxs/0lYPw9ptx2A7ybD7m/MzhocRPOQIsheR2BJcTdg6CD7i+/nbjErRwPT5noxXQ97DTx3ciAIb/G4ZDVQTdlS2r5IHTaMjTdrmdrEeDYS3/PNilpctKI//wFr/Sexe+de/Su1pzrh/GKaNr6+9lnnH/B+NBrCnV5cU5OBA1YCGCQaVW/0+kqjD8fLCe9G2wh+NcLq6/qreAotXoD/DTPqpHzSu0ak480aVr7ogldvp/taNcrYKbzgq5e0bpKW3ob7baDdHJpBW3pxEWIQaEZcK48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzGx4mZDkhoBlIEVO63ehSIF03akHbu0RYHS+FQIgBw=;
 b=X0kHLVSdIbhH3vEh7mFVYi7X1lekkIEwWmSqKZOkojdY701ZAzQ0LNgkbhgaCh3IYtZG16SomF5m+PMiAzWcD/Enj3868O+dpNkY3qYWnav2yTiOUPOavK3XWluzGF+jNJYv3l47Y99r5S2RC/xaqGO6y/hDaUoTR8AGyvbvAJ5psfxFI7lGdDMP6c2ha5YSIwPp1twSmQjCbPPLXVxLod4OAY6BWIWAP4/w52aULTcJXu55LrD+LKyyEk434ixIFtGn+540zRuvQQ8+mbtL+e5btKod4L8MrJtVtYncJLsvzdNNkCNkJ4WnCIOzBiV6bRuWpG9ck2q+6TaCgdxnyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV0PR12MB162361.namprd12.prod.outlook.com
 (2603:10b6:408:3ef::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:27:15 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 20:27:14 +0000
Date: Thu, 19 Nov 2026 16:27:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, dmatlack@google.com
Subject: Re: [PATCH 0/3] vfio/type1: Fix pin leaks for reserved GUP-pinned
 pages
Message-ID: <20261119202713.GU2245175@nvidia.com>
References: <20261119185659.889654-1-aaronlewis@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119185659.889654-1-aaronlewis@google.com>
X-ClientProxiedBy: CH5PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::19) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV0PR12MB162361:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ad217d-36cb-43b7-b3d3-08df467b7f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|261026121527099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	8MnKHrzfVOTFZtIjCo+vqaHbbBl3KXDVz2Bn1wZ8wJ5VdUfFdneXPEO3WNm7chSBPhEopIG8jAwWcKmj0ry0IBWqY/KpZtb71OrTPOh2FQt2nE2S64xYAtS383kHsdb8O+ASyO+5E/C1DEHN7W+vhgSJIaJkQQvBdDGoztKjVwlh5EFKtZdhM90tIJ9+L4gv0Rs6qIE8JcNiufufyN/bLj66A3UvKQlsFMfZEadOH3SeaIB/iCUMbdmvS69Ezjz7x/xSu/B8v+q7nozqfYHywC2wbKj/OzZ+LcZu9uJ9y4qH+XDukZK/qlZ6UrthmvP/KWYrAPzMhyaBuOj0i6MdwE+4KGYifiybfaa4Np40Y3alc1QuhmwAGeGNtsqtTQFgmDyNJq+7heCvOAFV+fpIcTUd+St6db9WdjYBVKdh01sCHdPiE5OL1yQUK6SXO4KBPP59etRR/MHvlg1Y3/rQpv8dF7q8U5muygEDfM9v5dU+FKH8gX31Rx5UKQhJWQZFjg6ehiE0c8KQ4ARrgLS3+jsH8+gotcixCGy8p9B9/M9aE/cm44Rc7C+6pNA1exx/Q16DavMwk9xSghmCUxcouHTbcSdMavrqdVE2hj7Q9T38w13HDO7xyJBYL/5yCc5c7gOm+gvH/5sKNqi/GTZsPKO0z4glWqKLdNUb4XLpQIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(261026121527099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?afDwOo4ZVlsQbPKKcuQnxyEBq68k7CvJQysozNqLI7ffJs0tQ7x+WASxjdeV?=
 =?us-ascii?Q?wCiZv7VnIczQM3H7uIX4PkGCTkscDfMQ9o51S8hkD+YSWOx1DZm/KvuRGwCJ?=
 =?us-ascii?Q?JmRJqX4BjBFG6Ji4MO86hX5hMEBQTgACyb+Tb1dU3doYp935vz4tW3p3e09b?=
 =?us-ascii?Q?7B/ir/sAZjFSIdg7oHVpbtG2OsPg/zZ9jKiOZbqZanwHo/SNE7IxW+wFFZ2q?=
 =?us-ascii?Q?rM9GXq6W5+KZkn6A9B21+c0FSKXiz8h2YFo0kk7VeFuKEvGZCs1lqrs98saF?=
 =?us-ascii?Q?18o5xeXayeI68nQ9887WYg2H/Pwhl2XUQ+QwgbkbihG8ozcoSheD0Tg0BtUU?=
 =?us-ascii?Q?gNJAAQ2yBtdpVOF8zkyZP4k/X2hAp87y5q7qNTngtp3ia1x6HT18yrpR88or?=
 =?us-ascii?Q?500qpd1LIRF+Bq6wFS4zUnLmcX89qepYKf960jVNVw9lggQOMG80xkAZpNaA?=
 =?us-ascii?Q?bEdNiqyKpzI5Vr1zxyn6SKPDOUU07h0YlCGrfe56qFMWLfX7WnjmG/b0lgh8?=
 =?us-ascii?Q?hNqVP3SEY7K5jT/l/1oNISsEMvCQleNhsrP+XZ+vS40KWfGvxl84rmIXkc+T?=
 =?us-ascii?Q?+40qD1XmUVQJhKTEGLTs/tMngBVt1X7sJyzNjaGy8O3TbE7A9YvktIygPcLK?=
 =?us-ascii?Q?9ZA2F+5B9raRDssqNhUGeadLmB2pSTDJIJFun7hUFQgMjq4yG5yzEdv9SFMC?=
 =?us-ascii?Q?7KANZhDwmR/WJeakJXBSEEyLCb84mfwLsHf7ub2yyXSSuj2N9tK6uVTxHEwR?=
 =?us-ascii?Q?3Jz/GdOzS0yNRP5XNtv4RozKAZNrL6TT/HKb6dFmy7JHjigg3Sjuio0AqtCs?=
 =?us-ascii?Q?gislze4jnm41VxxOpllwnX7FoiJlJaUOZ56hoyplyrTbFKX6Bu/pQq0Db86e?=
 =?us-ascii?Q?h8lNzjmzORaX5KTex/w0qhbW3UPiIrp3TCFB3SClyCpVsSCGnfEVAaNlpVJb?=
 =?us-ascii?Q?FxDU8NSPoNS3bxcY1GM1ajiynZH7BoJ+ousC+XH2PWzwI+Z9eCR/Ddz6xYRU?=
 =?us-ascii?Q?S/T7oPYwORawJ4smhPuAImMXvFKNFqBwgYLOEV+srJb2e4ZjlnoKPgUcNx/N?=
 =?us-ascii?Q?V9tMXWMEKyaGatw5m4j3qyRXU0PCyLm8fUB+/oBsDc3qxcohEwomELyWXfQ1?=
 =?us-ascii?Q?iDCGEAWWw6avL+NNe/Kg9mC9BQdqrba1QymrClV6S9ggu/XDKbnydrUhG/h1?=
 =?us-ascii?Q?FI6hR6tFu0VjfwTFXrH+awil2HjJwSiXeSmmL9vRq4VcuFpMuI7HTnkMMWWm?=
 =?us-ascii?Q?rbQw3eng2wBjREZz347K8ljLrYiTV0FvSWkkRu12tqoeIINwRYdpXPbFaku0?=
 =?us-ascii?Q?pUaeaHESg9CbxhrgAJYOV/WR5p/hQgQ1IZCu3fhgCvQyBffafqGsL35IHtze?=
 =?us-ascii?Q?JK+A6dhAD0mIY/9gpP3EpE6nlx0z3WQXqS2OnW84juEj8N/NnNmDP8/iQxRZ?=
 =?us-ascii?Q?qYRGa2s0mAispymt4hx4DpRb/3tCfamyy7x56JeC+yyzTIh58ldPoT3/BDJ3?=
 =?us-ascii?Q?JNwf8gFvymCSa0lXa5HKkVRsh9demBg5EfGjyrRQn0ssSCOc8TBQcYjMbDzD?=
 =?us-ascii?Q?f0smhI4oengZhSbQm5JeddTki+YWK0HM3QA35sMVex8yriEmF0ILo9XdgY3r?=
 =?us-ascii?Q?5rxD/qNEA84JwnDAoT2x9ZkHkGFboRn2RDj4vd26u9OxhbjF5g7u1p1z0DF7?=
 =?us-ascii?Q?+qovxqM2STpbmpSi2AZDiPMx7V381Cudc/RSY8t3PiGkvNBoxQ+04Clh/lS3?=
 =?us-ascii?Q?JS2Qcv5KyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ad217d-36cb-43b7-b3d3-08df467b7f7f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:27:14.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYwM0XfCghV2iypdiiZ5wdKcQUZxY+3uKcgyLyx5pTBn4M9wPzPt1wFbyBXe65rH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB162361

On Thu, Nov 19, 2026 at 06:56:56PM +0000, Aaron Lewis wrote:
> vfio/type1 uses PageReserved(), via is_invalid_reserved_pfn(), to guess
> whether a pfn was GUP-pinned or came from a VM_PFNMAP mapping. Reserved
> pfns are assumed to be PFNMAP, so they are not accounted in locked_vm
> and are never unpinned.

Please just use iommufd if you are running into real cases where this
doesn't work right :\

Jason
