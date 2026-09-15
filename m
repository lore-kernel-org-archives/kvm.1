Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BF43B3E6;
	Tue, 15 Sep 2026 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513464; cv=fail; b=i6BICLtfDHadYCWm710LFVwNzjAuIcBoBPT+gQKaAl0uyVYVHbQGYao5oFox9USEuYiamiWGyEWYEKtfH3U4zQD2Xd1dYM1Tk+sP7oOcfexXxYnioLxymC0lHNtmF0G4EaUmUGKhMnxoDQWRAEDc+w+C4ZJKiIb14haW3ruRglM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513464; c=relaxed/simple;
	bh=5460S1K/BpC+5Nsqp2Ga70kJ5IJLVayVMUE7eKSK2SY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=In2ODfMzPUVHJVy5Te5nhyTkDu0fyyaDg6EqWLi5iTJb80oHES6JOhZGEU0XvIQ3w1wZFZBR60q3KsmIsjmaDAN++lqRQH+cVVcqryrig7ktEhwajkQWvq1+6rhAAj6M45bya0IyYV3VzESQXncY3qTEpe5UEj9DA5XSSx7CBzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AD+D0kLV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AD+D0kLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789513462; x=1821049462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5460S1K/BpC+5Nsqp2Ga70kJ5IJLVayVMUE7eKSK2SY=;
  b=AD+D0kLV4Bj0eQNfig+W4W47dDTqApxTLoEoqJLMmJEldR7osQUSmO39
   Cuto/9QI5OgrIp7GTTxpG53umdW+ZK/6sIolQEH7LLI5NTk23TTTYQrm/
   gyh5yCeSR7cIsD74IlTyPfgvQrKf2DLiEnyp4+Dd6qU8hmrONk146WONQ
   fNZtQgzenDFfOMYkCFxvoiX87H33K5Mtv+NM1CzcCJtEnhqULc0nZld33
   zGDL/ohcT0MfOz6gNYZ33dZZZloKCzccXmHv/98n/LTTlph43+b/yaTIH
   RWHPyWafH0lUyd3XuNkTYaRUcZ7MaKgmIJ0DzKY+kJK3R+B0aO1b/FeD1
   g==;
X-CSE-ConnectionGUID: 2xauW7LYR6K0NTVbfxi38w==
X-CSE-MsgGUID: Suzn1Xa6SROH7FFomI+2Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92396846"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92396846"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:04:21 -0700
X-CSE-ConnectionGUID: hocNupgpTCWIi/YpCaPPVg==
X-CSE-MsgGUID: u/M7r+H9SEerpj7fZw7WeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="275110092"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:04:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:04:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 16:04:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4v5NoQW4Hb+u+aJtA93WmqVpJR64jK1wiUviNK6LE+whlY6xbKVNeLyc6/Oj5YIu1mV4xDHyUUJYHMAPjvzgm8NDHLZaduyFfEMbdJQBCGo3NKIS5MExGqEk9rXox6Ts7Ljak3tmfnhrQ5+BNPwzY5llQh2Eez/9ISO/zcs4Qx68VtY06y3SRcAudugzwRcLXU9azuRO01a+KlzjAhmG+4d8JbLsmh0FQG93slNsaX+JaLbDVdiIBlik+vDcCm1mPt/LBiwcqC13sXqLYoOUxd33NYzVhBArMEAycrrTp3Y2GyKvEVFLCutGP4mhPekfneOr9IA7rwYB0kVazfR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub5AUWlL0cvGmNrGNE3Hdcz+e9y2S3gfktMulf6dVwM=;
 b=VhQ2TW0zrDpSmuk1BHR92eN4ByXBcnU7T7Jm8qa19DSaifU4VLpYceJUSxXn3OKWEbH6FNFc4EP0TRAet7AVzGA2xSZp4MjrtiT3gfg1t2DT0cm37AdrYbZLzZGySK+kKWrxCNzSF5i8+DJwSCTauTOFmL73OTJePoD29GrWas5QU2++kQUmN5MOFJ9qGE15Hq2rVUwiwoqGmwwqQxN3HjcIKE0Tjx+jBGdT/pr3+BlFFtwKrl0FspK/3wSkvV1eF8CEdQDv7fyjEoZ7Uo0AZ5ic6KaCFFpE7zmK8CwURjwIi6o6JkZzRyJi5t+T0qKgsz5k30GwjwB/D/urNgJcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB057924.namprd11.prod.outlook.com (2603:10b6:8:508::17)
 by LV1PR11MB8791.namprd11.prod.outlook.com (2603:10b6:408:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 23:04:13 +0000
Received: from DS4PR11MB057924.namprd11.prod.outlook.com
 ([fe80::fbf2:d243:7bca:5080]) by DS4PR11MB057924.namprd11.prod.outlook.com
 ([fe80::fbf2:d243:7bca:5080%5]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 23:04:13 +0000
Date: Tue, 15 Sep 2026 16:04:10 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <aqnO6spgsfN1UsMU@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <aqlRETiO58SWjFLF@google.com>
 <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To DS4PR11MB057924.namprd11.prod.outlook.com
 (2603:10b6:8:508::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB057924:EE_|LV1PR11MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 5823beb2-797c-434c-eb70-08df137da8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rAEGUODbz69FxAoDO/v1CISvrr/VhfoVv88hqFShRMsOZdi7yT+ZSDDi3Rf9RG9eJz68BcpcktD9HaTpUdCSlxPOb6OahHGCvy4/MnmQnBhiC6/ScGYt4pJ2uWcJtZjtJlGHaVap6t9Ztmweq7Ff3ZarHDIabEXstQa2U3phrR0Sz4hmLkfx2PAUGFd3VLk6fHM17YAWmPbZZesaEAH7UZH+QV0Aj/of6wBJrejANhBL8jAiPfKrESiD7auTqxxgJ4ksBdsGu6qeswQMNaHlV8V6vUhaV51+cPvUmp+MlWiEuebFrGUV7++RoGBeFunbzpZL7rwlN3wMyZQFx6maWgZN8sS8ejYvdfOY5r90DVrX65whVn1TJIAmPom+PIdGhTfGXLgSKoa37Nci5um911QfH/EN2rcU/K6bpeZU6RH/STWiV41S6/XWQgDe/i4aUK3w3u/J0NEI84CBt8HV+BrQ6YG61cuZ2nh///r0tbfV5usBbY5p/ePV7Sxw+eohI+DY3wm4Bv12h/ZXJeZDF+FVowHCeR8R2RU3h8i5hN/YmUbKk8uY2Rsb5Vg/02VZDL9bL+bfSZtBDyywvmXG9PijO0A54lp/Iw0zUvt8iRaoY8X4L+kMBBzwu9tBIkLGZVzGBmr56dhkcE4yu6vXhRERsJjq3ZdY2Cy2zhQAwAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR11MB057924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tl1mHzFzDV4QLL0L9DEUNcbCt/nbr1++OFDGpgQk2bu/HnMD+KYqGeEQtpn4?=
 =?us-ascii?Q?41/re6Lg5u6nsQf61hR9gkRsB0UErKLzlBCG/BmLuZXHI/dhYB2XyvMZfonB?=
 =?us-ascii?Q?lN1cEEch215FHWuWrYxwTaeZGktheGrI/MDmq4Sr0AhBdV20JylMtfA9uD6i?=
 =?us-ascii?Q?TVQBBCjcs+sjU6vH/pNWY0+9gGiezzN/oYAiJ047Mnu+UIib7cl5WqTKdbY8?=
 =?us-ascii?Q?zS1Yo111kvqrR0hRAkW8ZOSvXn8jGMjAA8ZDNcDfRT6jA2DX9Xfb/vH6rSbq?=
 =?us-ascii?Q?Pm5AnV06bp+iJIru6imsbhbl5AOMJdtx/WU+YtnrTlf8l2uPj3a7bHoyJw5R?=
 =?us-ascii?Q?ckPPME/b4Ix/5jJAEC3mo0t+k9dL4vwxg8Gf6juy477uB/zecPExyVdBck7I?=
 =?us-ascii?Q?y6dMjlgJh3zYc6XPE2URnD7Qv32hQ2BnzGsIuNISqPnt773A3HYwYf4WDz1N?=
 =?us-ascii?Q?GiH+ioooC0bdVbq1VuUDe1dxE2V0draeVU/FL5bw5Rckl4bJORp9NdvX9YhG?=
 =?us-ascii?Q?1CDZU1tVIVcnTMQ2K0pSu6Ns/M/beYg+yVXazlvh5ITcPscIHCgtviaLbqKe?=
 =?us-ascii?Q?jtp29gYD+dUeDfoWgEsoyA7lWG7UtqwXFwXOFxnwqW+i8a5Gl5fkGVVlWUxl?=
 =?us-ascii?Q?dTX1wBBmaOb5dh2R1P4WgfTRqmfua5rtLHQa3iLXh8YSzeDBrkSH82y+pQy3?=
 =?us-ascii?Q?u4Nl2XNNchQf+xt863YznalKDFcUoayW/yHiJjmKDuFXv3pPzl79p9/gw5xQ?=
 =?us-ascii?Q?RTkp0cer7srJhEWwHq/sgvX61SRaFHnkWgRlzua/V2bm8sF1itkjrq+rrby7?=
 =?us-ascii?Q?txFnjoc7RlByiQfuaJvZqZn3bv362Zpa7W7IoRNrI0+zlfl96g8tslgMguqK?=
 =?us-ascii?Q?L+E/kjWkFueM49nebjsT3VA3JEnF9Qe7zT8qbzj+ElnW5yNGn5NiaCSZUYBm?=
 =?us-ascii?Q?r+ZAaypCJGpIdB1UPOxei0t89tJIJNMxLxiDqO4iJIBQnMGQcJnolZ909Rt/?=
 =?us-ascii?Q?9J+E1byxV5jQ0hZkqbnmvG4hkHNkx5s2EjzNyf4v/I85/ZdhPwRjfduNch3X?=
 =?us-ascii?Q?bnvanLcJKc2kTCZBiosZNQR0v2v/cQBAUIaz751ukp1X7N+k0Z5yWcfeS1Oz?=
 =?us-ascii?Q?63zHtcnHBLQQwcS9xssoW3HNgwozmVQw91Fce9vxzc/Jfs6ORqj5YBWdFt0f?=
 =?us-ascii?Q?UrMDd9+UnGlqUxaV997toV9tChn7u/fqPN8Io4pDY9Wks7hCrBrGYIFRTntk?=
 =?us-ascii?Q?VvvrcGtcIAcx8Tqe2cr9rmQrLzRtMfHTTC747+Ou1WeUtWZRj3L9D17b5Brl?=
 =?us-ascii?Q?q+jO3/YLzWiao3MqfHEgongZB5LoxewIrHH0Ek/IekypTz0hTrLwhWyJEEd0?=
 =?us-ascii?Q?DFudTyukMUkcf/q3/4D8rKLP43PLSc2SsRpRge/DqIJAoOoWmeSk/jW1gxDn?=
 =?us-ascii?Q?clnlc92xtaulbf4+rLrF1E6H3DX/ub75fiDS9qW+m7H4ubtSBFv88pVUdqcW?=
 =?us-ascii?Q?6XzkW0zmqD9llPnv1XjjojTqLuZA7sZawaBivgDoEoxtCJP64bryhpuMhnmC?=
 =?us-ascii?Q?ha0WP7kBld2LQ5Os6jVOc2xJ3/H5HL+rUiMZe8WAqsttae6FR4h3vz/tS94V?=
 =?us-ascii?Q?uwLFklSkmWua6hZuHWRv1M1HiZM63wJl4O8WOar1lKSEnBnwOLEjmiXqkbDi?=
 =?us-ascii?Q?D2oSqCodjlQm01yZwNPA+idWOL4ETURVDLoE2b81x9rjG9SwFtSp+vkKfol/?=
 =?us-ascii?Q?TWbK41YrVw=3D=3D?=
X-Exchange-RoutingPolicyChecked: aIL6ENRJQDI+v/2NAa+4aTYDh2GajzPiCW8401sV4PbxyNfNefow6BNjeCYi3GmgCqucMfkrsTwU+/mQJVmBSfr0DCESaRdZjEIAWZCBmSwDA7dwezchBQeoE/DKFaeLxM8KrkHfuFrvvReNuzVrCJIOHKmWTdm+rrBCdqYcJMGbN6oQQ7w4dJP5RIvc7Tu1lxbG/78Uz2mzKJZt1AUjhpWSYil0Kig/LTygfcYX0iKzjQ89kIWeEPnmLs/CooOzVXzgdASy60yJCRkaFVPxSAaOSdmNWHpsnH0NHXe0a1iNDFl2PkR3F5KHdHelW1AjkIeOV1eqpOYL/JZzRWrcLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5823beb2-797c-434c-eb70-08df137da8ec
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB057924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 23:04:13.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZCYDLylNGK9BqmEsFjWrVQUxP4hsP1YDoFijWFYqegvpot62o2gBLpgDAv8e6AisgLXXA8UGpe+PL8/iB2tuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8791
X-OriginatorOrg: intel.com

On Tue, Sep 15, 2026 at 09:11:31AM -0700, Edgecombe, Rick P wrote:
> On Tue, 2026-09-15 at 07:07 -0700, Sean Christopherson wrote:
> > Where is the breakdown of why "generating quotes entirely within the TDX-
> > Module is too complex" I was promised?
> 
> Several of us have been investigating this. It turns out there was a discussion
> in the past where several complex but solvable problems were discussed. During
> the discussion, a larger problem was identified. But, and you might find this
> funny given your preference for recording everything on the list, the larger
> problem that got identified was not written down. We've been unable to reproduce
> it, so we're currently writing up what we have.
> 
> And in case there is any confusion, this series here is orthogonal to the TDG
> get quote question. The buffer needs to be expanded for PQC stuff in any case.

Just to be extra clear... Patch 4 added this:

        if (quote_size)
                /* The reported size does not include the buffer header */
                len = TDX_QUOTE_BUF_LEN(quote_size);

And it is about adding the GHCI header to the buffer size. So if there
is a design change and this header is no longer needed, this line could
become redundant. The macro might cause the driver to allocate more
memory than needed (up to one page), so things should still work and we
could fix this up later.
