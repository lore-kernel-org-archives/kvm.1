Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF23A9633
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042815; cv=fail; b=f7vKb/k+EQFF5lEBSYTmzCa5h6K2nVtRqK1qHcTUbzCnaGAkFP8E+earfKCKSr6Bls73nd4gnOg52m/71Bm+vQgtEivaWL4OTFYPG9ViXBsWtbIttUgTcTU32ageUcmWKGJfE0QcvoHWebGQoeevLokP/2VgUiAFUgZZ4GscIWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042815; c=relaxed/simple;
	bh=z+D2pVI+kMmiopaSeJdpBzSxNQFBqQbbRc96Eo4/a/g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lT6DBhIss3rGI4Ef8ThGeJXvccYBpzeCr+pU6W4WpAjsgeN8IfxfBKciHWhFwlaaronLNpXBefMZyJvgR2RKAcOgSp8mSHbjK60BRIrVUYlTNdZmmqUKOJLlSTQpqo/CeQzUfh90zBvwb5VKZEcKwYb+qkFEmAb7PQdfB14MClw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UStWguXs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UStWguXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774042815; x=1805578815;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z+D2pVI+kMmiopaSeJdpBzSxNQFBqQbbRc96Eo4/a/g=;
  b=UStWguXs8XH4VaS3lNec8FaEyIVDDwM+KiF5ZlsuiEevNX3c0tYQoPSh
   vdSmrrZjKmyY08W0Segd1tpOnXK1weVgwHFntpJFKuIqZP1yf7LUGOV69
   7MdNUGvx8UNq1bk/jSLGPOzcPaLkywyL9XfU4P/VZSiMUneMERsSXtTOU
   HF9rzuBr8meB39WrB0GEv8q+rbYVueCnvsvcoBcstfee6tc/LfoXGKLMX
   Ds6hFR0tlkQ1OfP4HPdixck0FJPmoNtqPWR31aUvEetqsiP46WI759/IV
   peMlk591SRidM3yBb1Lq/gJ72mQXNaqE7l+nIlk1eBgTCYqQkCTzrqWg5
   Q==;
X-CSE-ConnectionGUID: AmM+4YyyQO+/694plruPQg==
X-CSE-MsgGUID: aV3/6gE3SYqIp0HyS2XgRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75027352"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="75027352"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 14:40:14 -0700
X-CSE-ConnectionGUID: 6jnpLMC0SCqO9ac1foj8lw==
X-CSE-MsgGUID: QchWva1rTlOUzOYONbLVkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="223619373"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 14:40:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 14:40:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 14:40:13 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 14:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqFDAt3bIEoZvnVeyed3o/2/aN2Wal/aLUHjDnJdRKwbbavIEas/mejwFLTdTieXe0YJfeKc6j3H+U+K9+cZX4n1a3k1c6FQ26kqTHNNHlI/vPf6pEA7qxE0wBBiqwgWuI5okrkQmu9f7wU2LFTpU/nuzfW36X2co4tFAv5QAX/qFy7it6XEMZ6tDB+4CsbSbIexCXTq/rUCb1Nw1BAKxhzGWY75BT7RfLoyvoHhw+rNAxSO5u+GhIFfinPGdZnTCQsK0hAV0iv1xTwfI8YMhrS8RIuqf5CVRpQIiCnK8Z3aKUbHAJouq/n/E9oPEfFXizyeAmZFZbIB718hHGg3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q4ZlJ/Ko3OFLJzNpdx7i+OC5MF1GOrnV/jIHNl0FKc=;
 b=kZelWcwXun0Qr2Br3WALg5bOG+zpRhiP08eWEMPvPzJxf0Zt/gU7tKK/2Sy0GEls3jdsefA5oMQiKRztZv7+25xXR11ItcuMAIqKgiVHB2TPffQCynTuNMfhkYUp2pSFJKgDf/iRI+Km5CxrtRcSqC/+hwfqO/TggJUysalgwN3F2qXIUv9oUUQJmeen7jE2DQ9TOHT8RgHg4bcAo9KovdSm/BU39iO8TScOBxbqJWtnrsPZzjb+n2mwquYiKIVRVMgWt+HZ8/JcPl3W+9DnGtQrrjL4w9ztOZyj+K67rM8o2BQ+NTBFWhzb2OpJxXhvPN4+tjtTwrjbjqQSCCQ/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) by
 PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Fri, 20 Mar 2026 21:40:06 +0000
Received: from DM4PR11MB6407.namprd11.prod.outlook.com
 ([fe80::26bd:1704:645f:7fd4]) by DM4PR11MB6407.namprd11.prod.outlook.com
 ([fe80::26bd:1704:645f:7fd4%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 21:40:06 +0000
Date: Fri, 20 Mar 2026 21:40:02 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Alex Williamson <alex@shazbot.org>
CC: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <kvm@vger.kernel.org>, <qat-linux@intel.com>
Subject: Re: [PATCH] vfio/qat: extend Kconfig dependencies for 420xx and 6xxx
 devices
Message-ID: <ab2+su0o/nzH7p1m@gcabiddu-mobl.ger.corp.intel.com>
References: <20260213091403.72338-1-suman.kumar.chakraborty@intel.com>
 <20260320151835.02563c91@shazbot.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260320151835.02563c91@shazbot.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) To DM4PR11MB6407.namprd11.prod.outlook.com
 (2603:10b6:8:b4::11)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6407:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aa0c96-c80b-4ae7-a1de-08de86c94060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: D1m+Lg9siap7wP0YvvVzkCs0D+LsxjKTgYkcMvkZrENf21J3eHXRIpUao0GLvzrwrKhKiuoqfbeNubmYz/w++HTYBcUd83iGoIaGIbYrXxxKPzNkwg5kcFGjLK68c3BVTTI162JRth0FjbGuU3s5ZOXSWEL2KO6yvk7UftS54HP/d/9WXaM6lsqwneRa0ba0RGfyhomDBqTTHpiIsAqPmlbn52rDg0RR1wPw/r6XJTb7RcgCYZeDgeNOZWShQ9jI2LJmhq0AnSqQLYl5t0d1KAZaLcOVcCbImG5HPS4PF1D0FwNaqKpQXgbF2EXv0xVmLcP/2eT/X3k8bLkGCtespJU63s0e6zCDsTmZOzPPWHjKaSQyDpyBrrprWDudvtHnezqBO3102FX28ov3LcTEji1l2wPHiKD5m50LYZGwMU0xeVdDMLTu/r75T2xjStTjqvyRH4Dfib5eokZJUCIVwU5DhSkzZljkXoe9Lqhmo/HXbmrfDSV1fqOpNJ2dxHKoVGKcedlXrvaLaNHh+My0hSeVhvcly8ucJcGcH4K47CdGkQOWFRL3e+COv+FvxfuawjUHOga07Bpy5ECNY9aELX9ntC/iM8XaOIL6NDlA5mizqwTxWv5PwQKpeXqwVdzB9QxFn7sty1qN4RawYHpg9PIfV3Qx0ONdx8eSH+XmTXwr70SU9vlrPfhRs7Zgz65Jc/hGtXYDmhZOMUek8LUdqAyRdgogbbv8IEBUVLLEoUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6407.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GluV0hrLRNYu5nlpbO1SctRnxm1/a5A0p7S5/2Qfp8ltzcnknyWGPHHTDN/S?=
 =?us-ascii?Q?o2tXOWWTdnUl0rX0gPHW2z4M9ENlvJBwwAnj954dGqdW/hKXpGVrJ7z7GlEw?=
 =?us-ascii?Q?4E65zTybg80TCapGrKXxxo7nXLuxIia9j8i3VGbsH6JhIond9yEaW8dTUOEU?=
 =?us-ascii?Q?Z29vh/13yKzmMA2gyWnNW6/Zr8J6DP1ZGaxvhkdgADW3jc1gBz6D+8c4asZl?=
 =?us-ascii?Q?uLdOTMjWmt+OAElLi35lZ7Vn97xXBS8N3tqvBbAxGlzdd8zTBU6iYm8uGLzR?=
 =?us-ascii?Q?41+TY8pbV0RYlk8+3HffKnQv6voS772m5nnJjk8y/NzHYiQQKf0T9PwgEI5H?=
 =?us-ascii?Q?t7pUIh4412P0aMu8fQCD6/wemrn3Vj8EotExr5kEvty3mEV9HOY6vhfj6BGI?=
 =?us-ascii?Q?1HbnjvJFGurTA2bb7AHQBP245SyTMqq631Yhgbwqfb5H9s1+LClEUxFNlrmh?=
 =?us-ascii?Q?5GQIgwsrQTMLtdYpHXfFbxNHLNxxG8D8WcX93JNwNDrkFr5nEdlGeCs40L3C?=
 =?us-ascii?Q?oi/cmyS/oz005MLEdXZh2VUIuYOnclf8GB0Sm3VKSk+x/7u2jN5xCm3fUlj0?=
 =?us-ascii?Q?epNGuyea+FpkN8fWxxjauvFIWKTGOmxkdYAMDj9nIDbVqjJ0tRtdvIPCpe0C?=
 =?us-ascii?Q?nK/pQwYLO7kzak1///cYcCBcUn3zOis7jJIPXGtoRP+iuZdM3H4XyG34+ZPt?=
 =?us-ascii?Q?WKeGdRlZWdqva85fvS7QtFjElqXrWVGrZnKbfwwSYwhYyhQb4u6s2cuCXcyr?=
 =?us-ascii?Q?b6j8obj/D/2S8pJQz7e/V0YA7Vc/M8YBkQXkm3vcqVsv9qGVwyJZRxyJ/VTD?=
 =?us-ascii?Q?tA5y91CuHSQEG9byU8JRmt5mDSJQv+nBxeXkOmQ8OnCCTYOiDou6cz9abFh/?=
 =?us-ascii?Q?OsQ8yulIvxWn4SUU4Ziok8Y8FOanTiik1K6T13ISc+5LXbXJrAcaQiHWlpOt?=
 =?us-ascii?Q?6ruXmFSpO2V5Nlm+JQOngDWM5ZGb01UYvF6g+onc1rZl0fVLykVH/AV2tYMC?=
 =?us-ascii?Q?TDG7dL472+tsZHzL2gDIIO6c67kpza9miuf1xJn54mSSe2YURf2DcD/NaMCR?=
 =?us-ascii?Q?SHNaAjwiKPJkgCJ9d3Vol8U/vZfcZCZL18ppaeSG0bDrCSCd4ulb3K5uwygq?=
 =?us-ascii?Q?fld5/mqud0Cp9VSjnUGEUH+tH8a6xCy8nR5vpGD4V2qXsC5qA3HzvitOdmeS?=
 =?us-ascii?Q?CgGdAl4nvsnbVOeLI2Ju8gpdcKQM4SUChbOdriOUNsuJZEXFjkWbWfAyDwMk?=
 =?us-ascii?Q?Qmptdrbw2KQS9dN14KnubZe4SSPXAQv11HlknH5UcCO+4WFxvEZpRHEZFcG1?=
 =?us-ascii?Q?Hdu7XNOkfxboM6h9NRffsOTMQIsbeu/RuaVCJriAbgknSDsLtKUuqSPk0jzX?=
 =?us-ascii?Q?Rfo5IYNsxChEZH7DdLDupeD+tSakZMIgDezgn8sz9JZrJo4ovEVZ0RGTRhai?=
 =?us-ascii?Q?xKUnnzU5vLbhNt06GPRrXFAwNbL7HTOh7dZIYxkh4UTR4txP3ANDb/ufADnQ?=
 =?us-ascii?Q?3HQKjtBLLP07jOUuEQ8iShHPf7iXZiUEf7HSSHjJiaL6qbBp/C/B5q4/vRU9?=
 =?us-ascii?Q?h2epPTvJK4s8PFvGHvJvhan62fR3K8qMpKJZzf6XWObqur/mVfyHtlCpQa9A?=
 =?us-ascii?Q?tylxQwTUb4lWj/kxBj5ItWJk8WuaFK8cvSuRVTOOBxCZI/DSX3H2wOIeKvAE?=
 =?us-ascii?Q?6jmuoIu/g4EWU1qkbNptSL3bVaoXEmY8XjyNk6+5kphvICKa7eLZWQafpSHY?=
 =?us-ascii?Q?lFbhAvsZtmYQ2x1zyHLkpcw4CScjdQk=3D?=
X-Exchange-RoutingPolicyChecked: M2kPgMqj0EXagKxxXg+x/+Q3VetSe/3ottMl1G8IYdSX2qa+E+cK+/mq89MGj9O6RJnW4VAd1Z84GWdfwaRnKq3fA4opou97HmrXrpxB80aYR2svFW+CITqHramDn6/w7vQXY4/Q7XRWMY2USUsx+HLqTQt6S6oVcu0hGBimJDdI+XpPTMdxe55pnk+vSv0GUFGZ1g5gXgbPYAqbfl6gof76M3LMLgqvpoUx3B/DtP8d2vkOPLPxe6wDm9npaWftjZflFjJMz06IPWBuQo8z7tOzOztuNA951tdQr9JRneXTe47U1l40iWpPz/4hT5ByJFUKUT1azdQXYnI8DJ7zbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa0c96-c80b-4ae7-a1de-08de86c94060
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6407.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:40:06.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqY+jLJIB9EaW1b84Cj9plUKlcT6hP+ZxwILjlO6W6RwebDzT97kudDCoz3+0JDUY8tZYT6zdkSuZhGup901QFsElQqH6mn/W7d+7EOURl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

On Fri, Mar 20, 2026 at 03:18:35PM -0600, Alex Williamson wrote:
> On Fri, 13 Feb 2026 09:14:03 +0000
> Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com> wrote:
> 
> > From: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> > 
> > Currently, the QAT VFIO PCI driver can only be configured when the 4xxx
> > QAT driver (CRYPTO_DEV_QAT_4XXX) is enabled. This is too restrictive as
> > the VFIO driver also supports VFs from the 420xx and 6xxx device
> > families, which share a compatible migration interface.
> > 
> > Extends the Kconfig dependencies to allow configuration when any of the
> > supported QAT device families (4xxx, 420xx, or 6xxx) are enabled.
> > 
> > Signed-off-by: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> > Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
> > Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > ---
> >  drivers/vfio/pci/qat/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vfio/pci/qat/Kconfig b/drivers/vfio/pci/qat/Kconfig
> > index bf52cfa4b595..83f037d7e9a4 100644
> > --- a/drivers/vfio/pci/qat/Kconfig
> > +++ b/drivers/vfio/pci/qat/Kconfig
> > @@ -2,7 +2,7 @@
> >  config QAT_VFIO_PCI
> >  	tristate "VFIO support for QAT VF PCI devices"
> >  	select VFIO_PCI_CORE
> > -	depends on CRYPTO_DEV_QAT_4XXX
> > +	depends on CRYPTO_DEV_QAT_4XXX || CRYPTO_DEV_QAT_420XX || CRYPTO_DEV_QAT_6XXX
> >  	help
> >  	  This provides migration support for Intel(R) QAT Virtual Function
> >  	  using the VFIO framework.
> > 
> > base-commit: b10c62483b324e60e45fb27d7fdc09c9198993d7
> 
> Applied to vfio next branch for v7.1, still waiting on a patch that
> actually adds support for for 420xx to the variant driver.  Thanks,
Submitted. Apologies for the delay.

Regards,

-- 
Giovanni
