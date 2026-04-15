Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75F1A9F85;
	Wed, 15 Apr 2026 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251082; cv=fail; b=ujhPZEONAAzErikT6fC3JRb53+HdP+qBXCKeCNfQy1y+Bmn5PFyDjSezUhW/NWsuQnLhaqjBp3zw7sBWu7vedYFw+6mvgS5ZwpHFsuQ80SlbzuHTYur09x+2HmMzoP0BP7Pa7wafZTE5x8+aWryaU+ICnULhlNGcEJKeA0LGbDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251082; c=relaxed/simple;
	bh=5pH7B/1PaarONHKzdqXpMDecHmsbsmZgsew/NVJ+7yY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ITKKxcHj8KZKezQMh8GQgu0r2r/ig6r/Ba1OwHyNsP2UvRbwyk3MNPOfeyyavu89JTGvG+8M0u5q8ZzO6XBYFxlnXNMUxj5C4eFLd44UCSOCSZHMLkRu5noYWQRbdZMKZFCeb8UDNUEb/9mAS4YcBHoxXz55SiCNiGKedI/ZLaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIXqN1TW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIXqN1TW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776251081; x=1807787081;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5pH7B/1PaarONHKzdqXpMDecHmsbsmZgsew/NVJ+7yY=;
  b=gIXqN1TWzEn7F5rtkH8tCWuypbkSwnqUWCBTAI7aBE5IYdms6uwTmPNH
   soR+3LsYumCqA0tLSM91HcRTwtj1fVJBRmXPlzIupLmz3+tU5D4jSWB9o
   OFqtzBnHYO9zGFycAgjg4oLSgX55eLltvWU+vVAVCQ8t4Q/cYvSlxkOwe
   81m/dqeZdYEauSPgNFHX6mXQp0fCBNaVPCf2O6bPxgytUcDDCjymfyW8Z
   vwFxBdiFd22FXqv1VML1O+1aafbAOBSzeoR+nZQRoYJIaPtS37rNcJfsA
   98opo2JlP89iZcrRirLNL6g4U/qEvPyV52RTgpOws2APfBF9kdvRXJ27S
   A==;
X-CSE-ConnectionGUID: NqbwMnosTgC1W6cJEBouEQ==
X-CSE-MsgGUID: DF6r0AdTSAuFXUA6OL+gHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77403562"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77403562"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:04:40 -0700
X-CSE-ConnectionGUID: AZaFCu8DR/qTIJSXtp8Vog==
X-CSE-MsgGUID: Tik8HhhcQ6KvbU5pH+uZcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234424235"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:04:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 04:04:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 04:04:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 04:04:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMsvpwbadsUEa8HkH6OIgVO9970kARuP4TiWg5xh0qrat/aYVE7w2/dfpxYmbBvRWpUskT29uuB6ao/3dsu0lvySQFf2xL8cBH5xMyGPN9BiHJHlb6ji8y/lqJizIbV3rpm2g2haSFddda6R/yFaPQgaAv4H/EiijxuIe+RQTopn9DGpj5Kl/4XzDN9781RGsgfUvLhi6EZkbAKBBHZVHskid9szjB2rhanC+ByRXBocZimfnkv57HYUIkyaZMRrdlpmL2ZzvC7+iX0SeDtCurbLU4u+MoIZ/jjWpq0aZDdpVanZyYJsYod8W63UWeLCCAYigcU09JJNzgrmoKGPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hueJGaqdJ2kBkVaJBd5kNK6J4SLjj4LWSPP5EqblUa0=;
 b=TYY8UrXiah7eSaATpsUxcdSjpkHZKEGCmcYUo0yt4PL9RZ6+KP/jfGxo/sayZ/TquSOj0jCeLm4QelhXafEKu/24PgPhbIzLmDpSFZp8d9BHWyZQwSuwNdxI+IUhIiN5fVu9l+EzAxgLOXPfBsH0DMI45ioyTZlRvWNJtvirwc4zmJTObG1mEkn2TD/VZGhauFBPXc/0WIbLMxUFPD6fy27qSvFUneC5gyBVCE4qbPmvkczFJVVo+rpbMpMmODy0JqXHrGXPmSbdD164R3n6SX/z0ICcGV6P0kK8mJz8a4B9a5W/OqRmxylVViZEsshUwDEyq4HrdtPScmR8ipPLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 11:04:37 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 11:04:36 +0000
Date: Wed, 15 Apr 2026 19:04:24 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v7 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <ad9wuJPdluqJrcBM@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-9-chao.gao@intel.com>
 <a6a3426ba9b84ea25f3653e33a181dab0096b35f.camel@intel.com>
 <ad4MWR0DyOaI0C50@intel.com>
 <1016261178d32a5c6f20d1507f28388dd01a15df.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1016261178d32a5c6f20d1507f28388dd01a15df.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: dcea32ba-e6e8-41f7-5fdf-08de9adec836
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: d5t0PPuWtkckiKokHw1ktlA3IVQk2KmYOaNgbTbu18p0D7WDxPt1kRo2pCQgEwIUSroH9PkMyTuBFEoK89NYMYeW+fH5oSALnXy9CPS6X3jTLIL0LtIuFAnHnM1NKmyM7Be596wLTPw0FZrTgq/Mh4jIRtMdzt2sS3Dalgfplb67eZp4fqkgER5HWSUCne3qeUmZdeqWxQUN76JIyLV6ZXswDSRiCYJ1dCOCe9GgIlVdmSrDdhP91KcDv6bid2tw4d3MKaAGC7vlpCv1iGzBZdg9S8k+T8cyvIZcEtlRshGXsRTGm3Sl37IbvuBM1q5MwP60LQDdR+WD8Dyb+G6BxQbJtOSindZpTIOIKLGk8rjnCzWYys1eifV8vEA37jo5cftg7uZAw2a3mAvEzocxXTtDFY65YD0IVdbN+3ErNkPWtK84qEXsWa/NDF1auaLWLBkh+PDhfQwHNeYFK1/sEQcL2+F9qO5E1xsk9fqhOc5Fzh/lazZhrhIN+xw4g+aIG39Hw6xyQU8UlHJX6jkswMhryxVqM4mNJn/dzqY8FFGenic+2ztO+KK+wYL1gzAd5I1LtDbgZy9BfRjm8j2TO8R5gZtgYdbuFV1URdmDCAMr9Co80uVkBinxecU+3ZA6FuTbnxHOjVRKaJjjvqOesFHpr4rHyfQb/2d5IPEoz87qgTndwPPUqswjfP9jNoi3IP4yMc+2tErbDozWnwYPWuIhe6LKaNPi/bB7KMa8tbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?k9ygPfA7gJdWkmJgPp9FQuoFyNvC+Ym7fD14wfyd3Ro/2YGlWEFNZrIgiE?=
 =?iso-8859-1?Q?OeceM/zC47vjlmo39UKvpoadXY3s8nK3eOp9Ijcr2J2Cz1FADJ/PySpTtV?=
 =?iso-8859-1?Q?AjdWvu0lNUaqP8uevGlAKVdOUGXVWKHYKRV9mCJ8G0Sn0LxM22XX4Y2XhB?=
 =?iso-8859-1?Q?+RxRfkt+y+g6c2X2lGSIGNIy1lF/K/Etpoga8FPWCrxFQTpsfzxX71jMaR?=
 =?iso-8859-1?Q?kiWe0EEc1/VRA4KsQDQ4bs+k+QYKeEiYKsZc7TJ4y0gJ/rcQ+wOZxcnewa?=
 =?iso-8859-1?Q?P/zZLCk8LGP7Kdbaw81IHNqtj5tAPsN3a+pOou5WTYthCSs08rxnW4pSI2?=
 =?iso-8859-1?Q?twFqLs/37c+gP9TkErfUa4UucLduevWJ0vL+8FCWYXYG5UtTnA+i00853d?=
 =?iso-8859-1?Q?beomU4KF5abhyP2SeVU9PPLzniNTPJmP+WjnRb5hk+j24yiLoZKDOuQ3k4?=
 =?iso-8859-1?Q?pNs9yR7A6BgBKxNdJh8rH8byKyw6sz89CMDWH3DNVN3dIM5tizN17lrGPr?=
 =?iso-8859-1?Q?msBPfkrSnp/E13AcpFKiKi12J+kfR8ksIZn2bss3bfPz9GSG6MZT90cmSn?=
 =?iso-8859-1?Q?U/FK2GAy/t5rd3udmtzKHQEtk6vW5B/pUodCgg9DBfaOoccpQexmMjQ/vH?=
 =?iso-8859-1?Q?FEt21p5vZQFSnxh59uSJC3rK2UNjQNKJ/faJLVh3KMGpFF8idbuD+iDddC?=
 =?iso-8859-1?Q?A0UayWdWx6LB8kmYEF0BljYYAr5lRDyzBnCNTxuDJyMGf024dkA6r3ZDlB?=
 =?iso-8859-1?Q?CDnxqcceTTtpxuhkp/jEJCu5VMTNkVxE0SZtZFQ0Td2Huoi5MtKTLll0vd?=
 =?iso-8859-1?Q?YZ531wJiYrP7IWgWnsnkM3MINao5tbBPZa4WrBjiMIknhk1IwhRKT35dcG?=
 =?iso-8859-1?Q?/t4fG5Zt3x4xTSac/jf46X4a7y+Ij1KSCYS8Ss2BvDLdhZNHxzfFmJUtAq?=
 =?iso-8859-1?Q?AxZHAmHBGOIduDurWtuUZObBKSA7Vc7Aa33uJJqVmUpcKGLObhbCMz7ryW?=
 =?iso-8859-1?Q?X3uKeJX4I5V0s4fmYnvcbM8xgHtyr2BQ3S1OT/E54B3+kHzyXZsVMoT9Yj?=
 =?iso-8859-1?Q?IvT60HKV4VutoXRrIFumCh8DeosSc9tjfVqZr67k3ej1uBKmgfTtiz74+Z?=
 =?iso-8859-1?Q?pL3CNEcLZ6PosDWrnZp2PoSCsGeG9FHue7PAapgsQfftkm5QI4YT+XHS2c?=
 =?iso-8859-1?Q?xEkZVwe8nT2yPI+LQ86x6IDATw/tWyNesp12Nw4uJBH7JEP0UnVT2RFnoH?=
 =?iso-8859-1?Q?4zEjuGPIDQchNAnENHTUf53ByDppOexkIaoaZxJUegn1GHRoZknaVO5c/8?=
 =?iso-8859-1?Q?GS/EBM6q4iZJm+x3/nRwtCQ4091rqRBqrN8nC7ssBGLkXrQJThubgMEvMR?=
 =?iso-8859-1?Q?y6Gp5Yhvm9bntPBab7GMCv+Zjs4LRFC3RTmX2edBni0+fOhi53+E0J9dwG?=
 =?iso-8859-1?Q?sKjwjkUkSNTgv0l0tZm0YjQ+1UYHz2CWIB8eA/z45CuWr12jz0vVR+2A6f?=
 =?iso-8859-1?Q?Uhf1lWqviz9YrCHUy8RU0u3oGmyzNMF6biagPoL1arJgDNXarPnETzGFIZ?=
 =?iso-8859-1?Q?U5k8h6NtPSCfUc9Qy/7GIFRnYpb996FA/I0GU0Y2MvjPBzDeQuZObzfJRH?=
 =?iso-8859-1?Q?kKpRv2qdNSUAbObOLhBMi6snStfQWDu6XN6Kfb/9ferxGfOvz6IpWwwazz?=
 =?iso-8859-1?Q?iVe937C5/Csu/gd2YP1nZrvPF6swHZI/FSDui09TaKb1SRx1v/YjFhyPBN?=
 =?iso-8859-1?Q?Lhcf9muM4qoZJZNoI/Hkr1ZkJtO2JqMG5tZc/C5eQ/xH761EUjGO+xQW88?=
 =?iso-8859-1?Q?xPnr079j6Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: bYyhJ/DH47dBXliHhULQSJw0PtLtj6j94xYgn60vxwEVZE6BSd4RVZoZNI1JeCIJb62CtP673cJCH+L3qhzNPl01h59EYybg12z7i6g2G+4eEq+FU+BhzBx2aeY8StIScaByUxN7mmEIDAU2nDIJuKBf5q2lVEGvpRN4v99WVNBYVWwF1HvZkMUYzeWfxeW4vtF1Nf0i1vLS+VgKw8iBYw4cTh5vkmtEKyT24XX0tPicIoWNKwfc5galRYKnV7AxsrQ+HaHHvhmyfnJzrHkHHgmWOtDLWbD2LSevcVUV35R/H7iMMP11+KoZG5dkQSUkOQSxcyRT3/AjLuTSNbKIXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dcea32ba-e6e8-41f7-5fdf-08de9adec836
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 11:04:36.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7ctqVDM+ps1SCp6MARaSj2pO3jWGkKklcjQhE31xqq44WCJoN16zaD06wsv3kfayKo9l5jpUQBfrp99ryBAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com

>> > > +static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
>> > > +{
>> > > +	const struct tdx_blob *blob = (const void *)data;
>> > > +	int module_size, sig_size;
>> > > +	const void *sig, *module;
>> > > +
>> > > +	/*
>> > > +	 * Ensure the size is valid otherwise reading any field from the
>> > > +	 * blob may overflow.
>> > > +	 */
>> > > +	if (size <= sizeof(struct tdx_blob) || size <= blob->offset_of_module)
>> > > +		return ERR_PTR(-EINVAL);
>> > > +
>> > > +	if (blob->version != TDX_BLOB_VERSION_1)
>> > > +		return ERR_PTR(-EINVAL);
>> > > +
>> > > +	if (blob->reserved0 || memchr_inv(blob->reserved1, 0, sizeof(blob->reserved1)))
>> > > +		return ERR_PTR(-EINVAL);
>> > > +
>> > > +	/* Split the blob into a sigstruct and a module. */
>> > > +	sig		= blob->data;
>> > > +	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
>> > > +	module		= data + blob->offset_of_module;
>> > > +	module_size	= size - blob->offset_of_module;
>> > 
>> > Did you consider just passing the tdx_blob into alloc_seamldr_params()?
>> > Basically, this function checks the blob fields, then alloc_seamldr_params()
>> > turns blob into  struct seamldr_params without checks. The way it is, the work
>> > seems kind of spread around two functions with various checks.
>> 
>> Fine with merging them. 
>> 
>
>I wasn't suggesting to merge them. I was suggesting to have them each do a
>dedicated thing.

Ok. See the code snippet below. Most checks are in init_seamldr_params(),
except the limit checks on module_size and sig_size. Moving them there would
require duplicating the module_size/sig_size calculations. So, I just keep the
checks next to the calculations.

static struct seamldr_params *alloc_seamldr_params(const struct tdx_blob *blob)
{
	struct seamldr_params *params;
	int module_size, sig_size;
	const void *sig, *module;
	const u8 *ptr;
	int i;

	/* Split the blob into a sigstruct and a module. */
	sig		= blob->data;
	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
	module		= (u8 *)blob + blob->offset_of_module;
	module_size	= blob->length - blob->offset_of_module;

	if (module_size > SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K)
		return ERR_PTR(-EINVAL);

	if (sig_size > SEAMLDR_MAX_NR_SIG_4KB_PAGES * SZ_4K)
		return ERR_PTR(-EINVAL);

	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
	if (!params)
		return ERR_PTR(-ENOMEM);

	/*
	 * Only use version 1 when required (sigstruct > 4KB) for backward
	 * compatibility with P-SEAMLDR that lacks version 1 support.
	 */
	params->version = sig_size > SZ_4K;
	params->scenario = SEAMLDR_SCENARIO_UPDATE;

	ptr = sig;
	for (i = 0; i < sig_size / SZ_4K; i++) {
		params->sigstruct_pa[i] = vmalloc_to_pfn(ptr) << PAGE_SHIFT;
		ptr += SZ_4K;
	}

	params->num_module_pages = module_size / SZ_4K;

	ptr = module;
	for (i = 0; i < params->num_module_pages; i++) {
		params->mod_pages_pa_list[i] = vmalloc_to_pfn(ptr) << PAGE_SHIFT;
		ptr += SZ_4K;
	}

	return params;
}

static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
{
	const struct tdx_blob *blob = (const void *)data;

	/*
	 * Ensure the size is valid otherwise reading any field from the
	 * blob may overflow.
	 */
	if (size <= sizeof(struct tdx_blob))
		return ERR_PTR(-EINVAL);

	if (blob->version != TDX_BLOB_VERSION_1)
		return ERR_PTR(-EINVAL);

	if (blob->length != size)
		return ERR_PTR(-EINVAL);

	if (memcmp(blob->signature, "TDX-BLOB", 8))
		return ERR_PTR(-EINVAL);

	if (blob->reserved0 || memchr_inv(blob->reserved1, 0, sizeof(blob->reserved1)))
		return ERR_PTR(-EINVAL);

	/* Ensure the offset_of_module is within valid range and aligned. */
	if (blob->offset_of_module >= size ||
	    blob->offset_of_module <= sizeof(struct tdx_blob))
		return ERR_PTR(-EINVAL);

	if (!IS_ALIGNED(blob->offset_of_module, SZ_4K))
		return ERR_PTR(-EINVAL);

	return alloc_seamldr_params(blob);
}
