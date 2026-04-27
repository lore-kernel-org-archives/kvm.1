Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCAC26738D;
	Mon, 27 Apr 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331544; cv=fail; b=sADNSFAcnur0J9+IuH7H80nE7sd1/XwZizQP9oNeU/LccllitubOvIvz0SPzemwwRjhlF+hl0I+L4YbYEwNZxJb20MGLNb0Fv4JCpKTvHgJOVfkww2KM7luJlr4+bS6bx/fWCHbrYSTQtwLwy9OT02k+ei348Zxz6v1JqBWBRko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331544; c=relaxed/simple;
	bh=UMn4FXOXgdtIYz+D46sqwcJ0WIWl4NYfYclsBfjjWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DUOvxezcKPjgoo2ti5x6LgnbpuEazuW9ImDzj5KwaSimRAdGBA0I98gTIO4qO9KV57G3q1ao/IxTa3xeURrI9Yqq1Wzd45EvEl9re4Myd+zAYatZ3RVpIbGnAOrLdO/eilubUQiv0lBR8H7/5ZJZchLHholyX8XOF3+gnZIHQjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gEjek+L5; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gEjek+L5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLtWgBIUljrCN+1spJvBwwv+3Xl0vg7RkFJA8SHN2B8z65G+n7iHEMfBdjzGVhum0hRH3v71eWvUtAXaJydDzb60ElvOAv3lqxvIdZ25wKprREwq4p4I0oSpIUHBrgEPxVQmkVHSwuX5x88HpS1VECIu/n8cm7CkMPoAWiFTaJFJYo0mLNIZkxwgN1JZrNL/k++OS2KtpDAaCImhIgTaxN+3unVCqxVQ7FQeegg0Pag5n0VA2hWqRpcMv1I+/izPoKlOqigOcCuAesdaLu09emDA4Y7V0cqnZijZAhL4hkPnp8G8dUOi4VeYwGOlAamCBL8IiiAQy42QwSqtWcddNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVYV3/Acm5FVBG4N5/WYRtX3xSAMgbc1ac6mRAkadAA=;
 b=jPIiljoOKiTLZoS9ONZQQPLFC27w1L/vrOkR/nOwUTG04LHwZKdW/5rBtlS0KV9jIrGYCETGNtMrYmYzaBQz+Uf1wpX0Vz3+AGrO0jF8Ej/t5waePiCRIBVP/USyGoTs8STw3bsbMcvwhhJ4fzsYHwQMrMFHP1PjHH/MKt5ixWuPKvxIRthhdConpoBx5w/DsLEBdil1tSKUJDshB9Cb0aCnBMx1qmhFJcGET3BZgjBCReop6g329pDprFLKNenFmq1cS+A61Vjj9HFRjYmyHHQ/v/a8SqdV3PNLtegXqP3ykB+XNpw3b3+Bmyp+wxDHoMZPba5qkmircz2C5waQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVYV3/Acm5FVBG4N5/WYRtX3xSAMgbc1ac6mRAkadAA=;
 b=gEjek+L5aYACZAZb71Y2HZVpItGMqpcw7Iq3LDBP6a+Ro3+CW7P/RVlTpJ6gp7vw5hIplPbTUbMg+vDBgQm4hlLixmNS///9RbgLtwbjmqWeNWnnyfuMVOw5smN9GBS7QBDMzuSpZwrroevJTP4s7ycIPxGUwIZ3PJNzP80fOVCg1f70NI8jKvRGezhUowhU/ujhLWiApHnUcVIBoC7Q8+Qa2P7KPAU6XskLiP0hCN/+Nq9vAmrsfYkm3d1zVotUG4LUvPOa5Hxun7diQwKY/7bpvhuxcwsWiiKXBw6uLYipHZXaD1M15XHPk89rQ9B7JuUJ73hFOG4RGXU/jkdQbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Mon, 27 Apr
 2026 23:12:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 23:12:18 +0000
Date: Mon, 27 Apr 2026 20:12:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <mattev@meta.com>
Cc: Ted Logan <tedlogan@fb.com>, David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
Message-ID: <20260427231217.GA1670652@nvidia.com>
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
X-ClientProxiedBy: BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: f2879c89-a2ba-4687-2edf-08dea4b26dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	L+awKt+hpl9GtvZoDoA80TpXaSl0ErlNOmMu4GhogzQU6tq7+1G2gBYQNBDSGU2UPun/N+Qrf3OKJRgehaT2pWrmxeONOHm7IHcohMEJbG1iBFwX20CPh5nDeAoFB5WFT/+Q0jd6f2mBySgDrhdovjQCIoTscfKeN/MMyoL4qVwDUiscaA45BL49IBa6SN7VrkthhWndkS3NxheDeZ/wgVA7QsORCNsF4s1LeixukRP/YxHxxE7WDYKIUiJwbYpJhw6k5MyM+sTacVZj8Flg/g/qxQPVQa0HwDMHQISWFUuFsOkKdgZsWSlhqoaILNiHsCN7W6d6Dp/XKhV+HKU0i3mATUW0hw0U4khL4hLwXrzhL37Jbl6G+Cx4vE1V89P8af9Uctsyg7DWuYe+ajYMwU/uYhW/0+pqNuh2ZenZP6hsTPIKzQgH7umKltr6Wge9INAfhl6au1N9tHVIKJs+rFXr7sOP0RnqllqKDLMZXKdGzCZ4IEAagIW8ZmfexTXuY8O5qh1EmuuqT0yOl7GSSNZ6QL+BfF8ao0qRVv4yNHOThty+xjrNc8R8tfp5cdDk/F8Ay/8ZwIzhA/OchIKXLvHZoW1BYbSNvXetEcyoJjitecDej6QXZquv5nWKhWdg4X7bxwy1TdZ2jKAQN0oNnFv6N/WUiGt0fYPH+1xHZ9Wz9Lp54Tg+t3HhvIvwZt6QXy5tIz4x0cJ8cx6ZhOKPQQ0nVMp/RaYBDK6mNtZgiO+L2mkNIM/0+6a8aNUih72u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8KLnfh1AB4fvTPoOD2z5AsZYTpAcr3e0y7Dnle3r1f/hEXsjKgvZC4SgEjq?=
 =?us-ascii?Q?pe7mVgxx54m+XGggLlD3KUcWuqIyUcJfUlV3pSQjQajfHLHxienS2XpQMA0I?=
 =?us-ascii?Q?4qgiscP1fmF/c+VnVQnZ5VNlddyfmp647ql9+ueIzzdWcOIHpY4BL5i1Ul09?=
 =?us-ascii?Q?69ILBV4+m4R3GJ5WAZfyBTmR08DHf+kKNeND9WXoIZwUR2lC/STNEwg8gCH/?=
 =?us-ascii?Q?VvgTUUvnm7Zz5GoqADXBbG73ScAKzx9HoMw30SY6yf53lJfxiye1yLj5gL+k?=
 =?us-ascii?Q?4vjLZBBHHLcnYEY2fLZ9VPGYa6R4e3XQOKHX21ws3zRf5ryL6CdTFh5yU1T2?=
 =?us-ascii?Q?H0kRwuLT/6KvE9GJ7V4y+te70DjiWi6EFbtQJs9ro0E+BrpQHGRXpatIRM3G?=
 =?us-ascii?Q?Di/SlStj51XfJ7WxYZyA6DMPziy1a8Cm12y7yBO/UDw26tFmvetZvCfIU+S4?=
 =?us-ascii?Q?xu3VbxbxI+MBRl4+y2ENyJ13q05BdB8OnrnKXR5PCUP7Sm+Hfx4Bw+ksb3le?=
 =?us-ascii?Q?AjVxm/Mn5Ke96tY0omGLc+WYcGiEBDAP4dg9I7WD83/vz2Tdmc3bWTDUm5dR?=
 =?us-ascii?Q?v3vzRu1117Sl9ZU19bjSZbt54mGlLWD6LzbCRke+UwYtykpUNGRLoRCMUAyv?=
 =?us-ascii?Q?tTCIyECiOrYkyk8Jxf6c7FWarBfaB/0j5CGpXhLoYJh+0txxZyqcPGi+1e85?=
 =?us-ascii?Q?3VR2ETWhPGMtYM9IS0ZoRIo1gArDHJYiMICPNxQValo5iLo2myeCk5VzkZcO?=
 =?us-ascii?Q?JXtsd5l/kI1kmY4PULaHtoAXsUd9p+BuR1eyBueDUYQ4jnAradl53H58vEJT?=
 =?us-ascii?Q?4BfBPYtMboBrhoTIqXcoN2xqOnJyQXNkGbeAknTGAS927jcY5MFxypu/F8xo?=
 =?us-ascii?Q?v4zFcfDnziR4gp0YTvVaIFpKnhXnzquFCNbW/1z0J/MQj6DGebWsYegLcwPt?=
 =?us-ascii?Q?vk9jbkL7+GTfoSTKmWH2d2gwhUGQSST60Gm6RxXFepLq/jEjWEUZ0UNzI1I9?=
 =?us-ascii?Q?mHoqwbvvFsgcILEj/fj4R+b2WcSHgmHIBPb936a1qh5D8C0E3AzwcdFG35CV?=
 =?us-ascii?Q?m+F267YYqNYmgHMnk6ZrSTSb8P8a0B/zrdF4bGeVdR5FwaN4dOxOJ3Rcw8/E?=
 =?us-ascii?Q?l85vLJalHb8rh/gkKiGHJH2uvu7HyvjS1U7gbZJhlY8ylFUpl2cG0vEPKHi1?=
 =?us-ascii?Q?FukrxrwWAw18GxkkzP+3U6asDBYdWTda+r7no/jIi4yFYGxmKQ0a1yA9YD9Y?=
 =?us-ascii?Q?pI4lg6e/CSba4Rq7xb452igNIc7HFPAbuniJK3Jmvl20o+3lMuyLVJAQGuEl?=
 =?us-ascii?Q?hpe5Rxkzh2eiP/BYfAnnGy4hB8mLwmwNHxVKucfagl3y8MYvzkTeF093nMKx?=
 =?us-ascii?Q?tryRRlQGi8hegg/X5tg1cqY3KUVhvqDHZn3ZB0shg721CSJ5nwmmO1uY5s2q?=
 =?us-ascii?Q?IIcVpSc7qCVMe4Aq5AuSQ7jJGMtKxW9t+i7W4Cu+ZZpLPc85sE0G28ygkc+F?=
 =?us-ascii?Q?zXH6vys0qM2N9YodQEyRehpnwFM2kIGwNVK2zO9TKDJF4jNITTr380JJhcYC?=
 =?us-ascii?Q?hdNo1H8Thkm4FICx0QviMpT3kQXbDilI9K4ZIndqNWTdR0euHP9F4S8wEA61?=
 =?us-ascii?Q?I3U9of/G5P/FTJVUjs6/CHrRrILI4xZ/8gbenLvxWAqGDEbXmQknv2p2sV0b?=
 =?us-ascii?Q?4NYdD68qCLf4rF+Xi/6jeTkG/RyVbjR7r02J1PwUomMn4zSj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2879c89-a2ba-4687-2edf-08dea4b26dcf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 23:12:18.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtWmV8Cq9bAShXOeGF/R+dCaWsmsvnegSx2HEvVOjOReNmEEx2eUedcowVtSMdRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

On Tue, Mar 17, 2026 at 01:55:17PM +0000, Matt Evans wrote:
> Hi Ted,
> 
> On 03/02/2026 01:23, Ted Logan wrote:
> > Only build vfio self-tests on arm64 and x86_64; these are the only
> > architectures where the vfio self-tests are run. Addresses compiler
> > warnings for format and conversions on i386.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202601211830.aBEjmEFD-lkp@intel.com/
> > Signed-off-by: Ted Logan <tedlogan@fb.com>
> > ---
> > Do not build vfio self-tests for 32-bit architectures, where they're
> > untested and unmaintained. Only build these tests for arm64 and x86_64,
> > where they're regularly tested.
> > 
> > Compiler warning fixed by patch:
> > 
> >    In file included from tools/testing/selftests/vfio/lib/include/libvfio.h:6:
> >    tools/testing/selftests/vfio/lib/include/libvfio/iommu.h:49:2: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
> >       49 |         VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:32:37: note: expanded from macro 'VFIO_ASSERT_EQ'
> >       32 | #define VFIO_ASSERT_EQ(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, ==, ##__VA_ARGS__)
> >          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:27:22: note: expanded from macro 'VFIO_ASSERT_OP'
> >       26 |         fprintf(stderr, "  Observed: %#lx %s %#lx\n",                           \
> >          |                                              ~~~~
> >       27 |                         (u64)__lhs, #_op, (u64)__rhs);                          \
> >          |                                           ^~~~~~~~~~
> > ---
> > Changes in v2:
> > - Add white space around arch checks
> > - Clean up uname command
> > - Link to v1: https://lore.kernel.org/r/20260130-vfio-selftest-only-64bit-v1-1-d89ac0944c01@fb.com
> > ---
> >  tools/testing/selftests/vfio/Makefile | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> > index ead27892ab65..8e90e409e91d 100644
> > --- a/tools/testing/selftests/vfio/Makefile
> > +++ b/tools/testing/selftests/vfio/Makefile
> > @@ -1,3 +1,10 @@
> > +ARCH ?= $(shell uname -m)
> > +
> > +ifeq (,$(filter $(ARCH),arm64 x86_64))
> 
> This fails to build (i.e. elides the build) on my local arm64 machine,
> because uname -m returns 'aarch64', not 'arm64'.

I have the same issue on x86! The kernel uses x86 is the ARCH when you
run it straight from the top level make

make[4]: Entering directory '/home/jgg/oss/wip/mlx5st/tools/testing/selftests/vfio'
Makefile:1: "Saw ARCH=x86"

Even though this is a 64 bit build.

Jason
