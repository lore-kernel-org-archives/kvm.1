Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF83379EF0;
	Mon, 28 Sep 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629236; cv=fail; b=FVqTxEwptR+xOcSadSCYyMlhZiNkk9Zo/L8CTuIH4YQAQNj1f5zcoqRl4ATk3xPW0Evng0aZ6pf5HNlpDmPIBxAC0whikHUCq6EZLm9jlfkUj+lSQPXi/QwHmY+S+AulDLFLL2T9JBiV3hE5mHf0FnGv+tRVpefmOXibTz3A8Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629236; c=relaxed/simple;
	bh=UZxkA6ZMyfLG1iLEbDfgvi7fhnGugMrQMmZ0TiNSGbw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EqITXgkvO0BwXZJv45cev+HxjDtz54N7o+O721PBYgwNF060QD7UbO7Z3kFdcw35rIcB6DdflbsTUGtU8lYetLSsvRphn28n5Wvi6ZV5MmOqSQatWPOYZ+hbuscZ8imrGgJ8cd20bj8I9j1TeYvmMdhEwBswZhEEQy9TbYVz5fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjrIKRaU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjrIKRaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790629234; x=1822165234;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UZxkA6ZMyfLG1iLEbDfgvi7fhnGugMrQMmZ0TiNSGbw=;
  b=WjrIKRaUidZDoYSPKCiaCiI30JhiYOAIbYA+/kK3KjKTCDQaq9xtv8gd
   91pBtDh5ScD/DvGG6E5mRNrXqwIKMVHGhK0abnuImVDmREDg6WmgxFnTf
   VmnJRb9RXcFRaH0IU442Cd7FgPxal6Y41LUJORtGPu85KZXfAiPaNBFJs
   5cCpoAsW1vUsC4hIZVNFNXY2erid/oe/0e+p3PjzRe9UmGArdCeCHfkVw
   kNLDX7qKIorpf2P0y+U2fOdDh2gMQkhejkozU1Cbz4EpsMopYgXuocAGc
   hdHSmLQrySmwLLXeiweMBGSf+9XJPtXCPM+QrhW5STpX4uB9Sk+THns76
   g==;
X-CSE-ConnectionGUID: wAJ05v3pRJ6oB0SXkUbjWw==
X-CSE-MsgGUID: mthrRlGBTI+F33fgx1QkaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90381822"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90381822"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:00:34 -0700
X-CSE-ConnectionGUID: iGRgyUHpQCWM/dhiNgGziA==
X-CSE-MsgGUID: Pmv8jHAYS9OaoAOmaXbKvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274697493"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:00:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:00:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 14:00:33 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:00:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiPEh/67Z2JP5kaRdBfSNyyO+/SXrPSq2NkvtanPDdSf7FtI4VsP4B7NFxVs8eOV3r8CIQ89g1kzhOVHqnpomQKBqJXUszGtgub/7HQFWfGYMRCns5imsXoWccEfiiz7bNQ6AXwrHH0R/cyXzic3zMc0+SyqR7XATrf3DedquWP1W3E3IJ4nrRiPXJqudDh/ngIuPHbjR0TCWTtH2MbHMvLsyvdNz80y8BYVcMt9Hx/qU/taIDv1Jg18q3iuUAbe5cyd98AS9Pv+hdofClUthSmmPh8/CTTYK7Y/hiRS+kETQbQFr/x915BNbzMh3B8A3MH7WQeFBChy0w8QSII6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUmoMixMZJ/s/LvirIdyWxL7AVdrLyS86ODHn7WbxvE=;
 b=fQmjg+aVuks89P1gmW744oOMTXIM/xO1rRhSsC6yJw5SjnA1QlCh/xulSwTNLI+0gO4nQFx4WAVceyF5RWwa+FwlIen9IRI241HoqBeYh55lK7vDcHksCNzdxvQRV43Z8B9buxUn69VszGKbIGTYe/3mYEPgrke+8JPaDPgffD4lh8QS08immBCWEBTB67IY5xvXhbKhWWox8SqfOpa/MhWAOdlEHk0+SEY1fxQcD6Y86sAFTa0L24EYyrSJDMchBQmTKZS4guLC3Zd2Uleb6RTcu9R/mia7JbA7O7xGaGBHQWoYZXx9E+mxxsLvwGSz+za2HyTo4Q9b+cVS42UJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by LV3PR11MB8553.namprd11.prod.outlook.com
 (2603:10b6:408:1b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 21:00:30 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 21:00:30 +0000
Date: Mon, 28 Sep 2026 14:00:27 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Message-ID: <arrVa1hvvTwxe0ml@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-6-peter.fang@intel.com>
 <8c573cf624eab4c76098f1ccc21afc3e9e40849c.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c573cf624eab4c76098f1ccc21afc3e9e40849c.camel@intel.com>
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|LV3PR11MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aea1505-4d8c-4902-22d3-08df1da38767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|10067099003|11063799006|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: lork548MJGTU6+OH2LQGbDj1fcq07kVqkwnI02jFEV/NRSSBZiQiNO0mmBL80aEPc5maGEuX6AlFDZC5Is4UQO5MSF1qwg1ZgL+XEFtR+CfyuShYy3sCgsFeXts7TIrVtqAXBfp/5wDMGg6JqXBglPq+VVwT62W9mjeWllsjckrgUYWLl76yqmgymXKzse6b2CMSPOFy9/yjKQTwD1m1RkwaeBTFyyLLiuEKLSfzIhqqbJZHmpX3BP8hKntLMbMFHJVel422r3cQj9YX584j7rIJMNyAaZuX+9KUbwFN35aiq+52fs1tH/7ilfM+QdI7NfYix7Gjio/rjfeD0a139Ci3lmWTB/OyYS3/dypNFGjMwLOf+zw/VZeZxiSYrFXJym5H33WCaId5bFqYcV0FziwwMoIg4YYHhqWvm+RA6m8jaEb68BGOkKJzjCqB4xVB8VQzejl5uvZcKnijNmHgvH3HehoPEYdDM8VHzS+a0VgvbRUEKMdezI5y0H7bYvN4HZ2cSwiMnVETk2s5CJ3cucdhR11XVJpZCLSKdUzEo+65AB3vezixCcCSdhNQt6iu8BqrND4PewPZKsh6fRNo3xLYMTzO/+82sp2jkn2UXuHaFuSm1yV+SQkwMJPYthaoPEYlFcgb5Co2gv+OSwXlteBixxYtghvvNSHCH+erWaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yi2cFRmo4WDqSjuFCrNu4mSqJJ1ELpuqqMHxUJd+H+QPWCkhkHv6K1q2PBrY?=
 =?us-ascii?Q?VcFhb/SxV/5gTc0jMNN5aYPppBAZZqx9Yec6XzRlNrR+yfz5Y6VTFV6uIYyQ?=
 =?us-ascii?Q?mNLnDuPxa+v0KPDt2p+8A3It8lgWlMy1+xBP6hd4JXvjamy+dMgkTHRWeP9A?=
 =?us-ascii?Q?9vSrBmfSI5q0xedT17p1cqM8VDnyvpaiioXkjn8KWo/EIeafgycOj1KzgV2g?=
 =?us-ascii?Q?QgoL1UJjR+bi7PJIuHxBgZyKjkVfwWj8mYhdlDOnyQ2dw3RGB5rB8oWjSAJJ?=
 =?us-ascii?Q?qmmvK5dBzP7FwVm4/k5iz+pRRYRtEV09pO0QXUeaf/yrzfAZAEFMGmJI0H66?=
 =?us-ascii?Q?qHzrF5Y4ltFUwEScvmD/TDPHDKZ0MGhuzJpwh5/s0QBMMQ0Cw7Aeic/8udcW?=
 =?us-ascii?Q?PZZveasyyKIRmttYXL1CfcDTiXyPLQXLWViBEO+mR/Quup1PEvwFM6llYx/5?=
 =?us-ascii?Q?8LFyx67d4xVo2DBF1BunCz330cD1iDk8GohjKSkmnCEaRrQ4OBjm4RK7X2OM?=
 =?us-ascii?Q?cy3yY5O4xCblkw1SA6gsUsjCWcEA5BwNjhxHDNgP8bZcOgwqCuCQgrdQE9xy?=
 =?us-ascii?Q?gBN8Twikoqg+WbE7iVrXpYj1B2d6JSlAwFZov7rJtnAgwkmmWHKA8RKbtt+y?=
 =?us-ascii?Q?hCHpT6RTa0lMkXU7NkJjY4JZ3svFBC6ZNRcCTmtXf7iXdV7zhgtsId/RcxD7?=
 =?us-ascii?Q?jsC9mJ7QMgCszYK/FTH02yrjxLhXb9ILdSzBsikYLmfObXCSbLiICLqXcX8X?=
 =?us-ascii?Q?z4jtyQ5l8gPosEQmIUh/CUyAeZCKOOq+xUTNmHfdUakboBGP/NDuhAq0hYlK?=
 =?us-ascii?Q?1R2Gd2mZPWPKrj7KJ/h6DfMAbRA2jeShz/hhheIQFfaLDjfDTD87X0nDX8Tu?=
 =?us-ascii?Q?uDQYWnt9VNADKXvWZmAGxKz0qYBQOinv52+iQVprrt5vpdoDwtMZgou1FfkG?=
 =?us-ascii?Q?9wVKeYaVal1jtLAFPYmhVlg5JOmyLIdpFZijU7VGDHI0reY5zOuV466G0sco?=
 =?us-ascii?Q?xOUA7YSu2CNlcaGYVArONRMWtz0Sr5srIzwcsyaDbxEX4cyO3Kker+mrvnM2?=
 =?us-ascii?Q?MEuzB1w/xyadgHpV0eU9SqS8t9M7le53RTI4GILh0CuvLUrkjYxEKwfDkq6E?=
 =?us-ascii?Q?MfqrSu7CvU5S12JOwBAae1UdeQCypMAH44Fr9/d7R3vNBfAmLZg14I+tv4uY?=
 =?us-ascii?Q?ro0fMkdI1qI3K6u6weeYTrcly26qCInGhkPZHDTVRhE0Nb2kIqVF81m3vu/u?=
 =?us-ascii?Q?S5Fvx2cYP6jt7J+ekXHBu6rM3n6slx/j7tyLsL5TXK37pNm/eKVZXbQCvFBu?=
 =?us-ascii?Q?3+0Ei/iZXB+Y6F9JL3GlqMY1kEjetSOMWwS751yKNbsyNx/UsTHom0Jq05W7?=
 =?us-ascii?Q?cWygNFkq6ZWb+ZKhOmGCwAGESxl5sRth42RuDxNS4PdTYFv0cJJRBS2h23Zb?=
 =?us-ascii?Q?ZG8L443mHhwtlPpIc9HYhEfYuFcJDJ4z4ZdND6iGxo+bY0vabkTHoFHxQn3B?=
 =?us-ascii?Q?g0IOHY1kpAhVrfGwhte4VG3TxSbjhUz4/cSQh0itPEyVE7KQfqb/fJXBL7l4?=
 =?us-ascii?Q?UkTjjcVpuH2SiW1kkwD63TMpcNqd7nqLidAoCRp9MjMp4ndjqhGHJE0MnxzP?=
 =?us-ascii?Q?9+muqlTQw6cp9ZEtc/JdQxuk50W0wf5ei3fmOfk8NqR8dRKLoYbKbbrpXbgo?=
 =?us-ascii?Q?JCnF3g0yNK21mzBHH+akMRxISMITAobNirGhRje4qM5Rc2geHUqOkDq7kRdc?=
 =?us-ascii?Q?utFYrUoshg=3D=3D?=
X-Exchange-RoutingPolicyChecked: KcrSEc2+T6UYjB5U8GX+bDgEsUYLg8ETOVIMgW+ml7/CueCRHAvVacR6SevQEagmcSWAgIVNUpxgDGuXT3Op7PL26uc8oC8bwbtQUdDLgFCgdNnE2Ox86/fNh5s9QPaxLy7B9Sxh4lysaqjZ5Ki+QGvSHnwsBhSE+rhqc8ch4AcpA1fLkSB5co9cSeFkY0lcXB4co4FfOduawp0GGLikWjiJ9jv1zYarBiw4iOBHTY6GVhfuhaqo/SitGHrpyJEDqjh3XBhfJMWq9cKGsXlB7YYvvyyrdEVekS4u/4+3IpMCqw1851e7oJwchi700Xn7S8q3a81QRCmVUawIIUWPTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aea1505-4d8c-4902-22d3-08df1da38767
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 21:00:29.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoTTzfufkIsPISNJDTR//R5tCyMzrKGSBcf+Wu9wOx757dNmaoZoLghxDr+NiF90wRemRH3ECmOhnJFnKywjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8553
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 11:35:11AM -0700, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 03:08 -0700, Peter Fang wrote:
> > TDX attestation report ("Quote") sizes can grow with newer crypto
> > algorithms, so guests can no longer rely on a fixed-size buffer for the
> > Quote.
> > 
> > The TDX module added a new ABI that reports the largest possible Quote
> > size via a metadata field [1]. Add a helper to query the size instead of
> > exposing tdg_vm_rd() directly, as it can read arbitrary metadata fields.
> > 
> > The reported size covers every Quote type the platform can produce,
> > including SGX-based Quotes.
> > 
> > Thanks to Xu Yilun for suggesting this in an off-list discussion.
> 
> Suggesting what?

Suggesting using another helper instead of exposing tdg_vm_rd()
directly. I'll clarify it in the next version.

> 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index bcaf4180a8db..323e1efc78ea 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -198,6 +198,22 @@ u64 tdx_hcall_get_quote(void *buf, size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
> >  
> > +/*
> > + * Ask the TDX module what the largest possible Quote might be.
> 
> How about adding the "largest on the host platform" detail to this comment.

I'll do that. Thanks.

> 
