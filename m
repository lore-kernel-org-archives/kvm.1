Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07743E4A1;
	Wed,  6 May 2026 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071964; cv=fail; b=kr/RIaIh9d9hLKm/+u9kro6f6dLlgHQjsyjszZtVtI+v3HbZphlbqzTF1HnuzwONBssCk0zZXHxDsLIFF3EGtHiMMEjYMulnYV2Ahy+arHCJ6XE20nBmqtJIBVmY21Pn5BuqmoT6ymO000Va+tNF4uL9bCRUloU19DergD1QhK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071964; c=relaxed/simple;
	bh=M1h74Xmrav3JolnVIfhJBPYQOOTb3j/vc8arRgHYJC8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tQjbAcq0kBfqG4mDakOZySojcJG6ILYr6tN9eNfMwOhvYTqNfQm7D3qdaC+CVeF/0bURk1OxLCuFCn/cS9rpfdmTO7c5BULqBOIwvEgnJ29keCZhytKOVQquZn4JHltW/YZI2/TERcfR5zLmMTbkuQzlgZpCacIMNKnr84RcHKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHUiodL3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHUiodL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778071963; x=1809607963;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M1h74Xmrav3JolnVIfhJBPYQOOTb3j/vc8arRgHYJC8=;
  b=bHUiodL3uuI3n1t7++mKazhAkkshjvooRdyyToOnpqWlCd9/StD9i+Ot
   TC7toMDH6wzBnt3w8qUv5YNE4C2PuEy2xrtbji/kWpIauNo4LNSMw2p5k
   n7/ZBG85OjRe2xBzdkzA5rMMScY8QJ9zQ4U/2zEJ5scfTtcQyov6v6E1K
   awW3rV2F0HkDhidTY2sJRavmjyNvtPjBL78oA6OjT0qKDw/f0s0cFNmTc
   cnO8Jj2rnEwmppcF7qaA4g4gbG+SyVo1eF7xJtQ7LJj91+ekSGdL0lGBF
   XqyS2ohLh6/4BemO91pPrOaOYFM+HmPO8PcnpttRvsvvmsXQgq2QpyArP
   A==;
X-CSE-ConnectionGUID: QfdKDquiRJuY8DitFG0Kxw==
X-CSE-MsgGUID: fBQGbLynRhW2nuFNKSVj7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90456422"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="90456422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:52:43 -0700
X-CSE-ConnectionGUID: jRQcosU5RYSjBULFkrc1IQ==
X-CSE-MsgGUID: x0zu1bxzSLyO16jzq3UEIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="241109957"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:52:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 05:52:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 05:52:41 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 05:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fqjzh9gLi+BGKtvksfQEsFVMU3CJF6hnYWK0XzqzcpkYxAheQa2TQQN8iAxgDLI9V2NWOvKah5lG6LtmggJyexDfcfhVcG5ZPqBJXSvHfO4ZUjsHTONxrV+x/EGbgbGUhCDoM0DDqlBDmFg1TW0kDA07sha32258R2eWILyIWykwoIGah6bS2g04WWmjtaITmalXHeL0XrtBLrpMdHW8QpJCZp3dStFObQQIVNkQ9VMYockCY0LOBgRrOObfKSeSTDD6g4PAOaJ3uqBGbVHIBRTh4BNuVPS8WMCz3svWub3OUrhcijzi4AsSV9xpaqezaXijc2rj8PiXuQgxyzWwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSEa/xUCwKJzjq3ggZDR+kqG2UByazbIUMnmTnJtC04=;
 b=BknqqcoZYStkCqqxeFTNkgd0qcZJQa3IHXPLJstTMYwy+pB8GzBK1AfIYy4r/wtijtLW03kYqoAG1mXckdlnrKxoXoUmSmjAejr5qeq5kyes5u9aCqDBuEsLHnZW9rOw7MLgu4lHX1MuLos9b6xhcfq7zozKD81zM6WXd6MGVlhQOwcXInZM+NHn6+jBE0IypZbCw/eqHjMb+0aB/28C75kEmagYDqIEqZGFdZXVqU6cfXQGl/FOqOgwsCzfv+AjYHRUcyUakJnwxK+D+FSBhPsfeEvB2qWGeee92Ou3fIfImq50LjrDhsFw+l8BFhKnwC5l+BwhwZvqC1JwggbsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 12:52:30 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 12:52:29 +0000
Date: Wed, 6 May 2026 20:51:51 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 15/21] x86/virt/tdx: Refresh TDX module version after
 update
Message-ID: <afs5Z4746bZhS+Tp@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-16-chao.gao@intel.com>
 <28be5180-ff74-4e4d-b392-7ba7a9b4c1c0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28be5180-ff74-4e4d-b392-7ba7a9b4c1c0@intel.com>
X-ClientProxiedBy: KUZPR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:d10:33::8) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e986ac-8904-4fe5-0508-08deab6e546d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rg4lDEdEKctZTaVVjNfDAj8D7jDwnRu7Kk0DlakQg8a1Vmc0uk78RhH/h5Gtn+cLy4VehgefOAW3qJTBK7LsDltUKtRzHsr8dPRvmNXkTZhVRCCmpeDbWlvhDzVS/Mx/JJIY7Ic72kXMNBmfDq2MLXNQYbyw6UV0r0JHIlYkkZup+S53LGTCXiqHIHSezVHyH24MsAOSQNraD2gehLbC02LCH5OMDXukmb+x1XH7xsXMviEIQMjM8Spp3WrymnvwafouG0tshoboSuqJHO4ThyYzdeFZoMqi/N6RfDyR4fS5UWXw7KYCz2cRj/dH9PgEglspDRuumuQpHRuU+Q4qxroaFhXaMrPGvvoI1mqLrHhU8Pcat9ChpGisHlOOsVSwbL9pqIp5YSEnAtjptxDWcuNrZ32TIcd2+4YWDjvwtdu5bPCWF4xOSD0s3XOk4DI8okmeOG4xJXtVob7oI8wg2EAkMsYUWL0guYtDySoEgaCOWUxyBT/VLQIOSzHzzlrKB8J3j0Iu9Hmuz0cZdBYjkprruz7A5pte1E7NqI/qqRY+2j/RGJL4lNd/rSqHVZiOPKeOiUnWJ3U1PPyjV7t1e82IAiiROe1P8042ajuqk3rl/ybSGDV0FlUGjIgbw3ap+x7e6hUaYuTgzOyOn10kiLb1i0ybHjSeXLdoHQOFKrRQOQ4dVDkxaCqOb1PIikCS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2oaCxjiaPLwtG4hvdRMffPyAAVJSbhBaijJZzITtjmAO0cG8zMIDkEINIC0P?=
 =?us-ascii?Q?YNd6QASeM4t9bahCWCprYMd/IqrGc6upwci6xOZ40cBQXNJea5bfRp4QU991?=
 =?us-ascii?Q?YC7dhm10c7QSnDMW7/qrCk7cLsjJqAJ+mDq+XiEkzKzFVpq0A8dYvzkd+WOU?=
 =?us-ascii?Q?ZNhIyzPhdJPnvD0CmsY8ESWG+NuKAAe4IatWy8OonJbHXkbHAWqoFsM2MfrE?=
 =?us-ascii?Q?9HpJfX+FFUyYgEFRsjyKEIxr+anUnMX6uU6rsobqDUJsFfRUf5NpO+vUv2Nr?=
 =?us-ascii?Q?1KWmNVjaapWOQigSzwe6s5Us698sOH9uxwmbsbxBb7V9/cBl5b5asVd6E3Y7?=
 =?us-ascii?Q?nizQpAlaNAdoPIcBIaDyInEWudwQFTqp2C8YasoUm2UxwHYW5QTRM5D+Bsr9?=
 =?us-ascii?Q?prK6mwAy2mwohazF+jfk+26W0GeGEckAs2LB7TbnZ46JhqthebwSHIgYD1X/?=
 =?us-ascii?Q?tLPc4DC5N72kncgFLZmgnMoLaDEAtGrevE9gtD7ch9pRNYzwua/Igu473izJ?=
 =?us-ascii?Q?QjRvNFAjP59Gx0Xy9Fc/7t3EGZFWWIlx81DFVNwEvKeYrhq9t0uTVoAfBlxI?=
 =?us-ascii?Q?C3uPuk/lVD2W+H6VnRpzqhczcR1StCp/Vfz1Gcfnt9CfbR/vQzZ6qAM/eIjM?=
 =?us-ascii?Q?1xkwF5/8ScAUmhwkaNz6PXk88HkBdqPiWC8Joc10vHJzK0q+suyyIxABAJwT?=
 =?us-ascii?Q?5rP4EP6hGaCwZMUKEbFR3CfK9tFsqy2e2JlJaEyMg/UfPNrbR8pTSTNntChr?=
 =?us-ascii?Q?TpP2nBiKCadVFlewv/aYhdeZxBIm/p5hszVFmHbURntp5RBp92/0FzbSTuPJ?=
 =?us-ascii?Q?mR5RZ71bh1HPjlYOpHv7CU9i1Iws+APxgwmFhUEjfuslz75CjWGDnzByF+xq?=
 =?us-ascii?Q?T6hrgwW9IPKlUw2xY42M67+YnCZlZt2bRfdYwixoSZ4Ge53C5fzTDeanCk4s?=
 =?us-ascii?Q?5xfkqXgGIiila81IewRiUB7jIHI7FT7+cOD4rATmHjr5bxwz1j1dfV/MdL/w?=
 =?us-ascii?Q?ki7dItAkRHXy/laXmvryhpaIMK1phsoEQeTfRahjwzAg2IjqdnS+QbCReS7m?=
 =?us-ascii?Q?yBhD2AWIASKAKpsWyEOXAkDYi6e6aq1YUc/7WoxHwLU5xyp1aqzit803yq3y?=
 =?us-ascii?Q?tWNsqw1axnM/GjijSxl3P1BrI19ufDgKEFXjK8ynXehUvUQiWv6Z0bo6ZTIs?=
 =?us-ascii?Q?27wy1/8Ye2IA2in+7R/HkgVhIUidA1bON9/XdO5c92xvImHs64DTBh+h9lz0?=
 =?us-ascii?Q?6DX6vGXL2pXGDsUfnDqf6NmeH1OJCSM30tiL6Q9ok2tf7tGAKlEJfK57MgH5?=
 =?us-ascii?Q?7zPohlkF3RR942bCCCaNF28Lc8m82eQ0dWxMQxj846FipjQs8wUxMRif5e+g?=
 =?us-ascii?Q?MEIIUJF/azmlHiufCefiBUVdP5I4YnMOAkG629WgoZ1IBLgNCi6CVUpBb66/?=
 =?us-ascii?Q?dB+U+uExoXJeKPmspwI3lrtBSenK1TjwqSWa76HvCPrNe3V2nHHHcKKidomg?=
 =?us-ascii?Q?fZKSE6WsUgSfBiAIx92vPiDGdWB+2JMdBqqp6iNnQDrRw2kLD80FCuGVwXRT?=
 =?us-ascii?Q?wCv3y5rJ9Zl7clwWYfVhDnOX0I8u1B/TPd/L9uQs9FVgknHyY/oali9wwmXL?=
 =?us-ascii?Q?fvVdfSk3RhfVIwzbYAlNc+FSUryA1bpH763IaH+QTyorkvRjaD3sBcB2LM0X?=
 =?us-ascii?Q?SQR/QeyhWB03jgN/jKdXi2dAoI9mhLbBYmpMXTY858QqDRMUAgc8MasFm3KD?=
 =?us-ascii?Q?zYS1LnZuVA=3D=3D?=
X-Exchange-RoutingPolicyChecked: b5+tY5D/6j6yCXJQ/Y68PYX2Byd7ixtQcg4QxawR2VUuUO899mw4lZtBt+/tVoGkx5wEtGE5Spnacfji+zIWEqp27bNO8XdIt+/hPnpcMXyQV9PBIKHxQPGrJoTtNgN0GZQ9Ou6UiTR9k9IhGpj5mU7I8gZUiKXiSNHKYONBn8yNvP0ZD9WgtbqJg4ZWMfafY9gaVKmwOjs3Hp08kNSqztZpj/QAoapEKxB8WSgLydQKKZcAiMB7oR2Dzj6/SyVElb5TebxTY61jSUOcP8vQkldTFu68iRZTUeBuHa6GZCIEl/LoO4BDjhkB1SnxJQcxxEz37N14sf5vIzcSXuCh2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e986ac-8904-4fe5-0508-08deab6e546d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 12:52:29.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMYXsX53FfFsKpf+nmZUSsKbg7br8H2H90iKZUj5ek/1N6BNqdNp34b+WeVNSldqjZ8h0ld2n1g+zbPtK+puOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com

On Thu, Apr 30, 2026 at 12:14:32PM -0700, Dave Hansen wrote:
>On 4/27/26 08:28, Chao Gao wrote:
>> The kernel exposes the TDX module version through sysfs so userspace can
>> check update compatibility. That information needs to remain accurate
>> across runtime updates.
>> 
>> A runtime update may change the module's update_version, so refresh the
>> cached version after a successful update and emit a log message to show
>> the version change.
>> 
>> Drop __ro_after_init from tdx_sysinfo because it is now updated at runtime.
>> 
>> Perform the refresh outside of stop_machine() since printk() within
>> stop_machine() would add significant latency.
>> 
>> Do not refresh the rest of tdx_sysinfo. Refreshing them at runtime could
>> disrupt running software that relies on the previously reported values.
>
>This needs more explanation. I think the reasoning is quite nuanced.
>
>tdx_sysinfo is just a cache of what the TDX module is and can do. If
>that changes, it means the TDX module changed. So you somehow need to
>argue why it's OK to hide those changes from the tdx_sysinfo users.
>
>Why would they be confused by tdx_sysinfo changes but not by the TDX
>module *itself* changing?

Good point. The key assumption here is that module updates are fully backward
compatible, so running software can continue to work without seeing the new
tdx_sysinfo. I will revise the changelog. See below.

>
>> Note that major and minor versions are not refreshed because runtime updates
>> are supported only between releases with identical major and minor versions.
>
>I'd rather have this in code than a changelog comment.
>
>If they can't change then warn if they do.

Maybe I can just drop the note as I don't want to add code to preemptively
catch theoretical module bugs.

I added it because Sashiko pointed out that assigning the whole version struct
outside stop_machine() could allow sysfs readers to observe a partially updated
version. As we don't need to print new module version, I will move that
assignment into stop_machine(), which addresses that issue. After that, there
is no need to mention that major/minor versions are identical across updates.

>
>> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
>> index 98a8d9d3ae25..c81b26c4bac1 100644
>> --- a/arch/x86/virt/vmx/tdx/seamldr.c
>> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
>> @@ -306,6 +306,8 @@ DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
>>   */
>>  int seamldr_install_module(const u8 *data, u32 size)
>>  {
>> +	int ret;
>> +
>>  	struct seamldr_params *params __free(free_seamldr_params) =
>>  						init_seamldr_params(data, size);
>>  	if (IS_ERR(params))
>> @@ -314,6 +316,10 @@ int seamldr_install_module(const u8 *data, u32 size)
>>  	/* Ensure a stable set of online CPUs for the update process. */
>>  	guard(cpus_read_lock)();
>>  	set_target_state(MODULE_UPDATE_START + 1);
>> -	return stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
>> +	ret = stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return tdx_module_refresh_version();
>>  }
>
>This is one reason I rather dislike guard().
>
>Does tdx_module_refresh_version() need to be guarded by 'cpus_read_lock'?

No. It can be moved out of 'cpus_read_lock'.

>
>?
>
>
>> +	/* Major/minor versions should not change across updates. */
>> +	tdx_sysinfo.version.update_version	= new.update_version;
>
>					   ^ very odd tab
>
>Also, how much of this do you *NEED*? You don't need to print the old
>version. You don't really need to _print_ the new version either.
>
>Isn't this arguably all fluff?

I initially kept tdx module update similar to the microcode update. But yes,
printing the new version is not strictly needed. Once the unnecessary
complexity is dropped, the patch becomes quite small:

commit 90e5a66b3f54af96d5895f6707ecdeef4bc4a3ed
Author: Chao Gao <chao.gao@intel.com>
Date:   Tue Mar 31 05:41:29 2026 -0700

    x86/virt/tdx: Refresh TDX module version after update
    
    The kernel exposes the TDX module version through sysfs so userspace can
    check update compatibility. That information needs to remain accurate
    across runtime updates.
    
    A runtime update may change the module's update_version, so refresh the
    cached version after a successful update.
    
    Drop __ro_after_init from tdx_sysinfo because it is now updated at runtime.
    
    Do not refresh the rest of tdx_sysinfo even if those values change. Current
    tdx_sysinfo users (e.g., KVM) can continue to work across module updates
    without seeing the new values because module updates are required to be
    backward compatible. And those users are not written to re-validate
    tdx_sysinfo values after an update, so refreshing them could be risky.
    
    For example, a user may decide both setup and teardown behavior purely
    based on the reported capabilities. If refreshed tdx_sysinfo starts
    reporting a newly gained capability, later code may assume the
    corresponding setup exists and try to use or tear it down, even though no
    such setup was done before the update.
    
    Signed-off-by: Chao Gao <chao.gao@intel.com>
    ---
    v9:
    - don't print old and new version [Dave]
    - explain why it's OK to hide changes from the tdx_sysinfo users [Dave]
    - update versions in stop_machine context
    - don't mention major/minor versions are idential across updates. That fact is
      not relevant here.

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index deb1470185ce..ab350b705910 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -66,7 +66,7 @@ static struct tdmr_info_list tdx_tdmr_list;
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
-static struct tdx_sys_info tdx_sysinfo __ro_after_init;
+static struct tdx_sys_info tdx_sysinfo;
 
 /*
  * Do the module global initialization once and return its result.
@@ -1305,6 +1305,10 @@ int tdx_module_run_update(void)
	if (ret)
		return ret;
 
+	/* Shouldn't fail as the update has succeeded. */
+	ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
+	WARN_ON_ONCE(ret);
+
	tdx_module_state.initialized = true;
	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e793dec688ab..e49c300f23d4 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,7 +7,7 @@
  * Include this file to other C file instead.
  */
 
-static __init int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
+static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
 {
	int ret = 0;
	u64 val;
