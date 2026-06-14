Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3E3932CA;
	Sun, 14 Jun 2026 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421651; cv=fail; b=tde8zg/LU5uia9WGor/aW8r/TiDFhUiZPDks1+/ycSmZCDa79lYkOmiHouI3ovULKGcK4PtZZRnl8hMqEg1jnAk1OTbkieeoI+aFUWDaKek7qJovCVgKNuLwps7a1KLUJ3zXbplNUNr0E/bEXw/1JRRwu/9gwA8HRFbvF4ZeHwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421651; c=relaxed/simple;
	bh=xCr3qwS8dHMWSxdvDTTdEUS2MkmonuUcT4Bfwo6Lko8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iAT/IuNYbpaa8RTC3+SvQnJ4icpQAmnP458oI1XMH8eZFQrRxICTsHmcm4NbLNgsM+R+F6qPTTa5b5PTB30xanAG2b5onapHGkUuJtvAlNiaowEMYKT1TZsaP48Wf/kpnyoYl1W1WxdaVAtHEWDly/9+5pb5YN8xHFFqWewhBSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biCs2E7v; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biCs2E7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781421650; x=1812957650;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xCr3qwS8dHMWSxdvDTTdEUS2MkmonuUcT4Bfwo6Lko8=;
  b=biCs2E7vMsNNWnOquhzH1GRqyH4Hc8ecZtaNkSdxNa+6Y8BkhHQLSODk
   SCVggyRpC2JGP8vE/PVVc0imt9zfaj+BVzDzXQSA67KAmlb9tdXEXTZUX
   vPO2E5qES/DAQZUHBsi39xQACOFpiUk9WGXf4mWpqVuaJEXBXk9eidLfq
   Rhy/2otDcPMbHP6wYzhsOvfg0vz2lpvayvFJ+BbTSnHYeN5R1X6T8LepR
   dcHQcluoHfyMLW8kgMMOUGY0jwiRzL5V3U2OEAHl17BF9/ZU6LKMcWEhI
   i9SZ14Afk9agdLfl1bfDtNqWB/ujhA8iVoaWvc51STcA3xJonpsMxTnG/
   Q==;
X-CSE-ConnectionGUID: Uv3FuMlqQtiToazANwANkw==
X-CSE-MsgGUID: GHNYt8SrS/+c3oT5RQdaew==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="107627099"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="107627099"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:20:49 -0700
X-CSE-ConnectionGUID: X75tlhG5RwK3HnBFKjviIw==
X-CSE-MsgGUID: /jCW/OcNRo2FgbtAGhXeog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="249080293"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:20:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:20:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 00:20:48 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQP9XrJJMSrD2Gu1gfzwgKguTN2Vi4G8bH1jGo/9WC4+pFrJz7dzK/QqWSp9tRSUXUu09DI5fYO0jdnZ7C0hQTU9mWpbBbHg9JbDyCdXxG8dBQQ8qj93e166XwTHwhSxNybtCt+roNjvx+vwmFj1x/GV5uBvFy3/FmeTYcDmjaFtymCTnEHl6mGLOcQSqDiDSlWOSmSvF1ktGI125OSXBh3tyTD2Ccs8qqod1PI4XDe1k6pG1X97wb7nyCsCtvrKcdKag+EiZ6DcN4iglDEAGdXrcTbsWZv0exZjwqOY3/LmTq2R4NdbcXTvZfHsPunVMBMq/s2YKzjmqtojUCeo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrCCd+vSAEyDwe+NkSOQ1lckBLeid0X1YoOEXF63KDA=;
 b=nAzwOf/JViuasNG/r2ZyRMKW3mjtM7nraOtrYUjUtbZdFcQ01V19e6XglqXV2BsfHpulXg+Ld42eFM5CgaltDOtZE/NdC4I7jCEClpMkuHiGBpxqK9vZWOoePbsdzYuafIK/8bXJpLSlprJnIA3OVn6wTFTuFV0LL/bBcdqU+wuIP8w7x26fxjeVJ7oX3FdD4/zDv7zTiNMZ+B0ABYmH8q/8Gu/lISrmpiPAzQIpb4FleycHKzuB+IIbvAl0WIsPRLFS+VdpqdbQOsqrplwVqXj6m3tb78znhy0NIgILQmP6qJaXyVPnGEcM368hI/oRGI9iAOyvWFLPkysww5bn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 07:20:45 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 07:20:45 +0000
Date: Sun, 14 Jun 2026 00:20:44 -0700
From: Peter Fang <peter.fang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Message-ID: <20260614072044.GD3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
 <55b1972a-bfc9-4229-a7c6-7d46b03d9e6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55b1972a-bfc9-4229-a7c6-7d46b03d9e6c@intel.com>
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|LV3PR11MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 71076491-bfe6-4ba8-d57c-08dec9e5732a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: bYeFyRF3dKllSc1miDJfdHh/cp3GtaMWxNwSHaFlWcBx2VSWMKHTMUlesy+BJakCDERAGb9ufK3CAfuvXWFABKpQoMxRXjsfRj4tVoFMZ7VbZrqFhTz+BtgEEg+c1DIYI4svAO/qm+xGkSyPUPK++Cja1AtY0VrVqpvoA3b6Z0u8BdhDamPBxydCiH4Cpzf747EijmqLW72CkZ6A2Gh7JlnQsVy3NMyQ8HEoIRC9A+9oowNE5rCSQooLHThMc4GRu49zRNPFtzqVxFHYjLGWGN894o0nSNZqgyzIRnUhrSwcnNmaYQRVyetjssOLsxdhmSEyALI1QsJegUj7678xsLLYGTrfeLEMwHPK57ZN7RuaA2KcF+ZcRLzDJsFLk7XqEig58WfnLh0LwrPOpiIkIaD+R8ye8FclZ+0nlouwCe5sf0nVGr5gCdzor+a2/xCHRwIYbXFzfbUQtMOeqCvpOew4bJtiWXWuu/Ez80Y7K0IJKcmsg3InJ9tfKpyWdCl5VAFeEA44vLOJcJ/v6jXP5O8C6shPqsF+zH9O3Q0ykIj5zqKAdCLe7sqvTvh0tzeuCbfKFbd+9ZvE6vxaidOE1PlQOx9NyBwbym3070HW4/ven3WHK7KJgYNFLFgAewxnGSQ2zCKUK1fvAVcWp/5Dg4GKjFX2Jf8p5L3EvkFYCYs8pZd9EEjev6Hz3fJxRD4S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUfO65JEaV7MwlRIWVnQ99TPwk9V/GeLG6IfY7anLGdiYgvhuEUFibo6lg9A?=
 =?us-ascii?Q?+cvWkaiTS/6iCaQpwfu3UbDzI3tjzLexG5s/J+v7O0ucG5JG9DrCBaEKYWkw?=
 =?us-ascii?Q?ijqRscDe5oGW2FWFBMvtUQjBfO+PAxlx+zVYsMRSjp8QWzkTjDWJkPo3jifW?=
 =?us-ascii?Q?s/qmW1RRERTXVahRwbq43nCCvzoiPe3SzHWwtkOo8ePRXzrd792XqnxmydSu?=
 =?us-ascii?Q?X0JiI+C80ornyzpkdNmXpWLRi+/Pt0dQgk0zRIfSMeMQtxgRBZBolg1dAYjf?=
 =?us-ascii?Q?bn8soa0ptQV3SREoFZYjB62I3tBc7Ifozw0Ir3eCrOjWcevMdYOKvVqjA6Gw?=
 =?us-ascii?Q?wtaHcOQbqC0V1uxKoh8KgcUrouOroXU5cfSytMsEFa9B6+EUOQmRQVI9BzrS?=
 =?us-ascii?Q?/3No6nahHUfcX3TRrDy25xo/FM0EDhrvmgOt1XrGAL+JgpVylpwvU1BqqKyd?=
 =?us-ascii?Q?H14CE0BUFBMapgeGfs1xxBZSjZhfngbuAKcAg8Kb5unHc22f6n0M/q1Y8Oha?=
 =?us-ascii?Q?sbxF9Z3EcNtNDaLGAstUoe/lckKQUguccgGBKGb4jbDzi1pINGcSd+6vwMCt?=
 =?us-ascii?Q?dHFlG7Qw+k5YzjVZkVTde3BjGfhNO+w9bUeYq1n6n3p0ZkgF6+b1tKJtyxTW?=
 =?us-ascii?Q?DfmDzcqF4P//qsVGCLFbzcDcXTHvbQiDdNRjyctAlf4PampNB+WsnvkwaBPC?=
 =?us-ascii?Q?yCHemBJ1eXypvVUs77gALNUuA7wwtxqkX6yA154cmt9lrEm95bpl5266mCRc?=
 =?us-ascii?Q?IoLl3FHlhxfvPqsN0lrgHLSc/WzAYhUJJ0+rWbi/Mhdo18P+G/eAkW2dJZr2?=
 =?us-ascii?Q?TENvdbtWuRtFYxt1bCVFLnfjM8IUlg4fwUvdTdHOrxbjHQlBrt6RKQI/mYC6?=
 =?us-ascii?Q?4shPqRIUo8ltIYzPB3DuelHvUais+pGtlAVK6ZNkbE+YXq6x32AhhIobMSyI?=
 =?us-ascii?Q?2GoFipnyVzWwm9PlRtrQQFrSokPqVJ0gMHqb5hx7OOLR48svtjUqlOWoxyU9?=
 =?us-ascii?Q?NigwDoyFnrwSrW1Wih3f3e7MnYrOFKwZjDqY18X2XC3YDZpxe3hj0CERQOFC?=
 =?us-ascii?Q?osc0n3j3MDmsRGoxiER2uMxS7x5nGeR0hRGV6DF1QxDRh0e6T0GUBht0ryxO?=
 =?us-ascii?Q?y2ARoqpREuB9oJiztKA8kDuBwY7GzW1diF+HF/nqq0MiB3QYAGR37pgFQPSF?=
 =?us-ascii?Q?i1fQbYooJd8k7noBphsZBKgobbiu3slXYp5IPfEWvYl3h1gH/irPBYeeNWTG?=
 =?us-ascii?Q?MKBGRLikYenQhgc49vGuDhZqWoxpIRHQsAUryR6lRe9ZuGEyoVTuoM5AnmS+?=
 =?us-ascii?Q?ADU657R88YognwA23WqlXa/7hQzft88jP47o/o4nrONprN/M40Ec6YI0elJA?=
 =?us-ascii?Q?RG9YxBI513ApDoJ7879Gmf3P0K38fk3yno2Emjn8oSHZ5n2TsTACE+GFZqdH?=
 =?us-ascii?Q?Ozv14Da3TIkDEvEsWt6d9K8L58veq4m24QLPzHJCMCN0Rou6QtjGVsQydGmH?=
 =?us-ascii?Q?XiUltG2aGswdpWsExQUmEH9ptQyA8MAPT379wSGV6lejw43vSzhYYrQb9E9U?=
 =?us-ascii?Q?dwGJjrUgpO9k7jhB+2V+9B4u/UskLbD70Nki1KVe9GnfyFfBNeNxz9MGYfiR?=
 =?us-ascii?Q?Mgm6XSxOeROsVYq/abYzKIY0RKAjtxit0u2dNbmGF4i0mWb3Nj1oXAAeVZjB?=
 =?us-ascii?Q?aYVGvFQR2A4xR2VBl0TAEvVtIwefg3s+WnRf6JQtxL7Sdff3OdnjTv9XUq+F?=
 =?us-ascii?Q?PSPAUP059w=3D=3D?=
X-Exchange-RoutingPolicyChecked: Hvfzis/7LVI6j3AzvbF3ByewrNgl8SobFVcE31dKwCwHz7HzCgNUjJ8RirzUGww6UzxwAlgCQqy4qa9/95ZUGo0tlNdbwd0nJiJa5wDD55psOlOruok7H1PseqjV1Jajc/KsrDu/yj+GhC4laf1/ugYSXAXF8/b1iDd4ZAegsX4aKcoZNK2oCjpXYToWsBs2IQm0AW1pS7R1BWNwb3H7aHiKPgR4j/pYgJHJwkdsN6i2KH7A/+kgVPc+LPx3Ap1rcPX59WRSw8UrdEfeinsTWVERK2uY4ZkZFaJfZ2a6ISoF9U/eGtluhuQLuhCQgpd5XpzIYgRgMUAzkO97hGPJhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71076491-bfe6-4ba8-d57c-08dec9e5732a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:20:45.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUHXTLobR8N8VAtb7/Xxo+7TvaSmnABpqGLf8E6kgPLpLrJSCQRMIPUWShNGg6AUBF0teCGatlfy7FKVez58UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 07:22:18PM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Initialize the Quoting extension and fetch its metadata during TDX
> > bringup.
> > 
> > Because Quoting is an optional TDX feature, do not let its
> > initialization failures cause TDX bringup to fail.
> 
> Is there a reason Linux needs to support TDX with failed Quote
> extension initialization?

The Quoting extension is not the only way to get TD Quotes. If this
extension fails, the host can still fall back to the legacy SGX-based
Quoting in userspace. I think the decision to actually fall back can be
left to userspace at that point.

> 
> > +static void tdx_quote_init(void)
> > +{
> > +	struct tdx_module_args args = {};
> > +	u64 r;
> > +
> > +	do {
> > +		r = seamcall(TDH_QUOTE_INIT, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> > +
> > +	if (r)
> 
> Elsewhere it tends to be:
> 
> 	if (r != TDX_SUCCESS)

Good catch. I'll fix this. Thanks!

> 
