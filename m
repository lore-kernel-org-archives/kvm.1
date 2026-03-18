Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49E36E470;
	Wed, 18 Mar 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822522; cv=fail; b=nlb1gMe7T4Xq2pKDn6L6x3OHb12Y8ke3sZWcwxcKjzN0rMb3H3rrD1D+St3svqHDhE9BZF/QntMjwN3N3LLkmHRF/JVaZ5xrDDwd+TPsWhbDnHr4IMN2Pbeyapyhrllq+50vho2K/OQr3athIQ+4HYo+vnAnX5zOoWkYhe29dU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822522; c=relaxed/simple;
	bh=8JQKBVlzozc2gLK16QZEKFrvcDSZyjOzmAjjZZPqqrE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gPdOunQr+NCS3itMJy4dvexDnIIA6QEZ/6mdp6BuKWv6yjUkbtIfZPvCVhamBHmZbLWKA9JprfkpGp2I/9KnbQsTT+DwDZKkAVPl0zmbtOXmErXVGAZNrMXu6foo1EPYBunfQGkdGejLnomp4+z2BjISrVpAXmjgQv8tF4dayfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bALi55OY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bALi55OY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773822520; x=1805358520;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8JQKBVlzozc2gLK16QZEKFrvcDSZyjOzmAjjZZPqqrE=;
  b=bALi55OY88wHa7lMuk4vluMWsF4CVXta6AlpEzk/yukR85KjsZyiPTCo
   YQuNbJynMoYZHZxux+xozebYhHYK3iWGc4wqtbiEfpaCzGSDdmp7qC003
   G8sMno/T/BguJX3Ke612pE0aIIKGEbeEanGnomRGDJs1k7DKjkMN+Wmx7
   Rp48lfxb/Kp1Br4NR/oLjvUTq+wk0otHjM+YBpz4tRir0dB7OPmKvMIJh
   vC8b8D5lAnpT70CMZZxeNfcHGnbcMzkowK7lcoTEqzs908Tenxw3eXdeR
   P9Vt98nZvTuOsc7aTXbbsDvWACdUVlg4MHDVomJCzlVtZGQkYU42jV21k
   g==;
X-CSE-ConnectionGUID: 1PMTrqb2Qpq8SIjYR7QsQA==
X-CSE-MsgGUID: oHOkHvXGRgSXt/hBzBIJ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="75052641"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75052641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:28:40 -0700
X-CSE-ConnectionGUID: Foprg9qHRxm77oagcqOnpQ==
X-CSE-MsgGUID: 2w1ByxCnQYuW4MnIBNz9xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="253030573"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:28:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:28:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 01:28:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfwL3F1CAhK7FDygQv9KHeCfmFquKzJILVOgvy7F91MtZ7pTD0pluI+tjjfDDkrzfDvKvDMkGMu5VALjEZDBrdfVCnCNXkRbYhC9Rz/CtiS5AWdMFBflKOOwkNi/yb4wo47jEoUxNNpOA7v0uqNDr12bQ7NOOvHJTWG3zp/iWqhQE3ad5fmKXOhxCepKF91+H+BMMjNYTx7QoOTtgaDDffsbbqPbMB7PTG3Dao+CM1HPL6eTpt1vsQ6sDY1pkFNfJXFWLO040MrPv2mNM8ha2EcWCWQ9Xg675oj0GE2k1CVOJCzj3UqLrIXVx7imglzjPuM6z65iUW89fKkNFfobrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3Le/1Lyy9RBs9sfo+6pito8yX/esQV/alL8HIkev3M=;
 b=EedXseRGBS9RWUh3nlVrKo2LIDkgccZ+aQQAkzqAIhRYKShJ9Q7Ut8SjUnelnQcBlj19CiGxECanuMVzgZKD3ELNpYLShterhQudl8+N1IPSKOuZnCm+5Q4ujqw3mTJlLps1A6+m/EtxadgbPQvXrmT2UNHucaR2N1VgOCIusFbFncEJYOshAM8wuB4V0YViZVlwH4rCVHyJai32ldt8DU0WnVfuTScbZBQAp4hN03HIwdkPfjMRTAroh+9jMJzJqXHK/0JJpq8jhBfZLXgG3MH8UvUP8JKsN1QNHTzHMfNofeo2WOEDlWHaAvQXGcO2BVexeeqr1Ud9V1GdFroCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Wed, 18 Mar 2026 08:28:26 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:28:26 +0000
Date: Wed, 18 Mar 2026 16:28:14 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Message-ID: <abpiHjAenZWLdOyU@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-8-chao.gao@intel.com>
 <abko0v2bYxNJtegT@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abko0v2bYxNJtegT@thinkstation>
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|CH0PR11MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 4350ffce-2f28-4ae7-4b56-08de84c85338
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: fZOfKmC7ua58Dg7qCGN1HCHgeiCwsrhtks+9ZTW8tpofxKNlAJalhk7raxTHeQb9UelebKpD8E4GMXH4FmYJpCGZMvUAEGCMPQ4sEWi1hPmekm3yuOmT0CUobLXHbz3gAlpqNAie8y/q+B9Pdf80tWnw1aOSlznyAfT68Ld6+3L8Kdj3/fsYr5MF4ZJeOw6bbkRGSX9Pj1m4ww7T/oK2rEWJpdgcFSwCqy39LhsYmjx78JDyR1QwxT5CykjQsApfrVrLmD171EaiSRBUMUBZcf8H1+tVAivQ5zw5h5zbvYsNd7Og18SLpuenYICu6B3jAq7M5qgeJ6MVeW+yOtWGoDhLuUV2R4Bw6tn41d5zhlwU4lEI2hCpdENSgk153hllIhI/SvUpwZdYus1BdV8+kIh0o1cjDW2SqJhtpwOyDvVTX5bc+9cdLh/QLMQEW0ConhUJjsROUQVdJF8M/F6NOeiSFnEWNpKr0v/0uWfQMB35IJsykkk/gWJzdPFOg2XxVUj9w5uVXH0UXBVwZqfcXMVTCXK+3L2rcA1u5789FxERTmi8U/xBkAc/a/HK4fAeEDZIzQ+Gt3UtgF8Ac68cQMffQ0fYSA7klznN5j1K3mKF5+f6AGsz2bn63iSeTmZcE0plUQU2ZfoaBDIQxV6t7KIko2INWIeEkeBwIkGs9tC5WDEygyhCMegjD8DU5pmHPgoIebe34e+OB6EN+Wgw4HRfVMjNQjZQXBJOt1AkAMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iUwOgb2+jhCZ0/pCvC1lQwwrOq1TbUJUvfEoroH49ru6vcQ/s9H1fcAWdb6e?=
 =?us-ascii?Q?D1Q9E0si0bnE3KEjD4EIotF9/mGyfJn/zj533SF261lizS/QZVr4Op+GfFEZ?=
 =?us-ascii?Q?xtqofonN72AqCWMr1+lNPspZSCIsNIpsrYm07BB9HBUreztC6hNT4kZCf/BN?=
 =?us-ascii?Q?ljqsA1l31awkWTxsdB/J5vBvt8qL+BSf+lWXj+/w4MBg38Ih4sajxCqoYp4H?=
 =?us-ascii?Q?FGJYudkOkqdJO+4/M52HaVm9MjhLHPjY4FLRMiRgZYHSOypaHiiIX8jHZXU7?=
 =?us-ascii?Q?seIGRRDfvz8JIbFK9wnmdibj8iNP7K4G8nxI5CgmS1kVwX7aylyhIXwxq+V/?=
 =?us-ascii?Q?rcH8LIi+Szz5HHCpbXMa2s2SpZXKXFc53Qc6WfNkZH07yXoVLcDSnI+wcDWI?=
 =?us-ascii?Q?6BypmRDvQJkzVjjzOWdARnuQZGmTyz5pIu1Ie94pzwXyoeBjTG2CR3UQX/Ud?=
 =?us-ascii?Q?d3NKUdkard1BtuN7kxh5encwGaRhZ0667zC0QA7LaBOX0DzvKylp333lEA8f?=
 =?us-ascii?Q?s8LhtFfjgKoEXA7+EpI9FuT+DGgWnNsdaLViXtvmretCdN8bwhEOtDWEx4Ud?=
 =?us-ascii?Q?7xPWVRMHd8tYusT8zGBfXO9xTMmVDZpwrM8nYrTeDXTnPjxS+QTmR0tlaOqp?=
 =?us-ascii?Q?XBqd9aAyVPuEQQcJDMmcS0QOT+cATcOKcAkjIK79siol+XN9DqY6dKPF34nb?=
 =?us-ascii?Q?XhKH6uO5GDqnHDhs5mkXib7LhwOoGFdm8e3Rt1LYOpMMtv9jPGz0gqhQRGnv?=
 =?us-ascii?Q?2rgWvAtE06sU1ZtpW8h3zVKStGR2uoVr853izUF7ehxI2Cl7Ob73XTou2C8l?=
 =?us-ascii?Q?AMlFZsgqYXWv7jlR1nBIYkx9ROMsAxHqrTCvOHTk0cKnKdevEQ4ti5uT4bKL?=
 =?us-ascii?Q?7wnqX860bTkGc6+U955S5P1p9RcG1g1FNSvOi479l5ORBHfPq/jLG0/l5NzP?=
 =?us-ascii?Q?1DksOo6dAOFhV0/QnjPwoBow/E++OXlCB50YETlZDrUDvO6L+LvN20+02Zul?=
 =?us-ascii?Q?1mP3IqXfe/DMZaPUiMFBuF3E3We083/AAlCKECN5GqdwVvFXI+eweRv1/81D?=
 =?us-ascii?Q?4/ODYZgN4fjcrn0ONxmB9tVRgiA77EHE4sS/rFUP0bCHsjT5zS7gVBIpgPQX?=
 =?us-ascii?Q?R6H9k+4wGvlQBHNbW7s7S9HtiszELZoQ6v/qpOXBNDhMkPXV5XDhbZ3bfjBr?=
 =?us-ascii?Q?GgXEq7fqx2k4RBK0J/8gVHWyzGCUGvBHIq53OUF8W23jguusFUOlyUN222pU?=
 =?us-ascii?Q?4/V+IJzivD8WZ9FaIk0BGxU9MbiJnLJ/skw27O6++YYODEzHNEL4zOWWkmND?=
 =?us-ascii?Q?FgjONcCDkg7qoVaGJjZ81ARmp9DI8U//VAEjYTI2r6TmgQEOeaj66HtmqbzP?=
 =?us-ascii?Q?tzKCg4u/Gu4whlbxxDRYL62WKHMZaiEcz2ZqisAdTBA/nwbmmx7NDb1Qtw8i?=
 =?us-ascii?Q?TBd6CRh66fAdlyke3L5PpJFe6dPBIltNieSWepTZAT4QQ50eJkb5dmPbaG/7?=
 =?us-ascii?Q?pz+naSrKCcIVcCMatU5hj1BT6W4FIceF1fKv8xya6v6XgKgoc9M3OaFiW6Z4?=
 =?us-ascii?Q?B0WWf6ixjaFdY1GpWpML1o7xF4PmBACErVUNvtGjk0xm47nXSfzKhdltzlxY?=
 =?us-ascii?Q?xY+MT3uAN5x+/1k86z2CxGlTgsYsSWUhK+mn95KOjvRN1RvKtjDDwZIbyTys?=
 =?us-ascii?Q?da77WQLHk0KNm9MshcrntaMWuYAaLOMvD1dBQJGytSpUFiF6Tc4/HSt2ko9v?=
 =?us-ascii?Q?B4+QncjbkQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: P70BJIh1jru0vr6Q8h07dthRLkrdbd84tSwN3htFjXh+JpeU2kFLpEfeZU6RDvORlcX17C0XJcDpbM6SlRB7GJmr3jcb+uuq5EquSO5QN5Nw+10fG7ruIvpwp0fQXhkYfM5nrqCdJmJdLYq7i7XI10UT9iXg1t1ZVC/kl3KYPfqmRqNCO2+uvZXZ6EqUB2OaboASWnO3b+/P6tOGcTRLLvY+48vRiduv4WKdXCJRE+oVH/tPolPmpij302rPj9MW6hh4QHW+FNAOcY5HBeFkx4s5F9dV37PeNjITfy4tRyoNGiOCWFcrim5DP4+E7bA45rPxUAa/BlgkRNy/4NBUDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4350ffce-2f28-4ae7-4b56-08de84c85338
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:28:25.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3QdGw7uBdCQh70JPb9qSmgipwIxaV4ajaXasWU7PYAzuXYcjTvkETy8pQ9TYSTGwxRj7NiFXFII9k6FB8Gf5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com

>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
>
>Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks a lot for your reviews.

<snip>

>>  static int seamldr_init(struct device *dev)
>>  {
>> +	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
>> +	struct fw_upload *tdx_fwl;
>> +	int ret;
>> +
>> +	if (WARN_ON_ONCE(!tdx_sysinfo))
>> +		return -EIO;
>> +
>> +	if (!tdx_supports_runtime_update(tdx_sysinfo))
>> +		return 0;
>
>Hm. Do we still want to register seamldr_group for this case?

seamldr_group currently serves only module updates, so registering it when
updates aren't supported seems unnecessary.

>
>Maybe move it up before the check?

If new use cases emerge and need seamldr version etc, we can do the
changes.

FWIW, seamldr_group visibility does matter in one case: it must be
hidden on CPUs with an erratum (see
https://lore.kernel.org/kvm/20260315135920.354657-19-chao.gao@intel.com/)
