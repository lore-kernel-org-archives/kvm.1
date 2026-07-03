Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC482318B96;
	Fri,  3 Jul 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057780; cv=fail; b=sVtM7dRbm0RJMJ7FqzTZ7XH06egYG8PUgx2BzIj18HB35cV1JN/PL5fMHUAOFxgyF1Vxw6QiJF298B31HAOVv+GwSEkHcYiYH4HY5VLjwzdPNbsKo4lpK1SXMEMz7iDiyl1XWWt7OzR4sCyj4qm07QDu4f5mx0gNQR46/YxjDgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057780; c=relaxed/simple;
	bh=jjKKjBM5wyprS2xIju38UPQGg2oCSBC4NSPE7pruwe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MvhSFnEpShtgje8UCKxXOESAxmKRHB5idk7UqP6cw4JTPdcpC0URJPQ+DUedn547fWbptlVHFHoLah3GZOhL8j4Aeh5TUOnkaM12YdIeM3VEaIkE0EZbgsN0I8WR7eo0jW9Hp3c5+IjUmRZ5sZ3VL+1hAcM+CPTX7OTJRv/joYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEg2yjdY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEg2yjdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783057773; x=1814593773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jjKKjBM5wyprS2xIju38UPQGg2oCSBC4NSPE7pruwe0=;
  b=MEg2yjdYxZdE+txBjhq/mBHdFAiKYbCBkoqOCm38KceAWdDETcBgA1tU
   kAXxJkCpJSWbtsxqIAgfpSRXcF6xwhy9gY1HtBHbBCA+GKwbZwrGi8O4g
   GZ0CF4r/oNDLSebzj3FCBy9VVr9up7MUzSG/2jmMq3mgM6CX1rxOM1cM3
   KPY3PJIfPyci20aNMQpZ/TSVXNJUvHrUvFw2+4SBcOsJ/xYn0rFTtrCcX
   m1xsn8nv1eZg7jZH8DS1k5TR3n/ASaCPvElrX5ESxfahwH3LZ4Q8fmFwQ
   eBrt1HadEE5yD/UZ4WXAH4Rne2L8+waPwyjGfrKsUEzoyulv3VzA/7/z2
   w==;
X-CSE-ConnectionGUID: pMMBmv9DTXy61H7ii1b5pw==
X-CSE-MsgGUID: 0KA3D37LR1GsXT7+c6OZMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83839484"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83839484"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 22:49:26 -0700
X-CSE-ConnectionGUID: eqodrN42QAuwjnYiWsfCCA==
X-CSE-MsgGUID: AnHvDcFGSsKqyQ+2ZH4v0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253678239"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 22:49:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 22:49:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 22:49:24 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 22:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncCG20Iy6tJRzHlNTrQ8uV6Ks2pMKz3pcqbmx0nFAs1ae0XsFRkITlnttN4Cjfv56ch1+fMm7udV7B0tfLGzsSuVKm6QAYJX+ZGM2jhMaCfwlcCcqTXOOlrlgd7slUu6IzkkKqLQuvoHcRAAkttGp4QHrd57lNqpZ9WjHo9pfUD88P5YrGbkuvqKvbzBVz5JZ6YdrYzHSQzMv80JeQ7xzt3gFpDtJFDdL7h+/irf8gD6P+2n5lftIBBEstPD7ocPUrUZHFKKWaamhkKBK22m2lcshPFJGqUlO4DpDw17hko1v8M6YrQjhgisrUiK5+D1IlYXkl/mfn0hl+LTPWEdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjKKjBM5wyprS2xIju38UPQGg2oCSBC4NSPE7pruwe0=;
 b=UgPkHfe4xScAcUqTlkr93QPDGIlP58KHptvy5xojWpxrqj3i4T1eDQHBcqmRBbA7Bojf2GeXxzBDKxe60TPEVMlLSatLE1M7pnrMKlyqYVwWeTaxlQAigQU4HOhxiQOZNv6HdrMcW/DAEy1bHSVFBkSYHKL9/EjnMp1RKTLEzayMXlsjIQSqiaNRgnplz5xr9bQTXhe3apslLooYPtHQIRe+7FsDIH8E7qj3ezHbT2Q11VFu81klebrRE/2stYMmElUHLNozcUtrMR62B+GUgPzU0jxdn0dFTDOGzpchAj7a6WGUAHTZSO8K2tUK7g+z2ArdLbaEmZ9P/f65FlkTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 05:49:11 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 05:49:11 +0000
Date: Fri, 3 Jul 2026 13:48:46 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Message-ID: <akdNPjf3zt6jPX1m@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-2-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KL1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:820:d::17) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9e96b9-d11d-4c04-c8be-08ded8c6ce25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|56012099006|4143699003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: KOFDbW+a5JHjwAj0z2umAwuJu85+oarZuu9Tf6KI3xCWyTCfeRXJmoHQtVSof7ixNUthk8nQ2FKPlYJTco4NqN3YgTVa34cEsHfklo9T41LMXf+zhOrvq5zUXv/FHPx+nbkPvpCsSJApvs1nkL0HXqHELVAX/lyADc6+QO4QfBiAmfEc1HbTWsS94MLOhKFdnwrsNz9jGj3H9r6IIK4bjyKtVlJlg+FrK5fPlf6VLhik6oLgGW8cFtEdfQzfNZEOhizgX46/V3+DVr0F6k3aq6aTI8DOVzu/4/BnHgRGbuqUobV/DTBPY3BBSw35Cff19gIi0UhZx5KzoadHsC8TsCewOQ/aFyv//0pwCl7MoOTUk/7SKVQmUJRbTjYJ7AX1jshK+hc4yA0cTZf3VKUSSG+zUdsSc18hUp6V5/l541hvtpj8kPJWBIyF9oEAniecz+d3hH/HG0WtNhdl/TTLTGcQOi7avKTSmpd0NUnf3PT9fE1iVx0Rt2qEcGi485lbLotFXulwyH/0bHZ4EsoOygznjFdj6tl1PBPuw4+l4hxPYy1+yS5W0AKTdptYotSX8CMKQuDAOCRdj/4oOru1p1PXiSpZun/ntgbiXImnnuO6hqof+xgJd0uw+ZW15xjy8eK7JnWX14ebTyzAIuwJuVwzzsDpzt1I5PvatXg5QzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099006)(4143699003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoSCXV+LiuKKiZhoCUwcGeKmnMq+XeFHnV6XLkwd6dZ3cxlHh+3yw6RK5fmF?=
 =?us-ascii?Q?TPZAWqyQaf00MYAlx7wJDCv7S4+hcsPE2HkXr6ZNV19afHrX1OPgFMeRtAi0?=
 =?us-ascii?Q?h0Gu3vAsni7+Sh4L6GxmdQuZiUBZzoOi5uB2F+bw+SzMVD0IN6DH2XtbF1Gp?=
 =?us-ascii?Q?pCJPukaos8tNQd4QfkPt5HF28MFaWln9+1FXEtCZ8KA+x1OozbCLJH9omZ8p?=
 =?us-ascii?Q?XxFmIArEoimpJiS1/Asru49LtokxlCx2nMaVKBxCSzLnD8Kijsvxxobs79W/?=
 =?us-ascii?Q?aHILXrMR2YCaH/CTDlIEs0Qk4weSHCntrV762Vj3Ml0Q40jWVMFGZIfB79mo?=
 =?us-ascii?Q?r19SYGANnem8HwNp778mJPEl9v2vQ9bI9r6zk/v2PsuS5zbP2hI5OGSmOPHr?=
 =?us-ascii?Q?xZhPmJKzE6fpaHsb9OLuuqcCVFO2D2sKj12LU6yW1urrD8xg0IegR/9hwfHp?=
 =?us-ascii?Q?FR5gKU59NUD1l9KP7rhz89OZ1Fc8x4aeYsgUievngYFrj+7Kuv7Oxq5OR3bG?=
 =?us-ascii?Q?eeyxUH4H10X3Irr7/3v7/QT+jMhDkMG5tDmQo3BoJ1RILSHmN5oBdCR7XRHF?=
 =?us-ascii?Q?Dy/LvLrJJAinDvXEB748vLSLFSQsXTu6u9cU77WXTscj+FAniobmUG/HBZlW?=
 =?us-ascii?Q?b9wzfCnpU+ROdgqOZ4StfJuz9jghNFkx2oYDcRWMCj9arrcpKuCF7OVwQxKL?=
 =?us-ascii?Q?0zoytVmcbaX0G8FcK7K8Y40UOFHMhrVKR62eo8rvZEHac5ixxTv8Fz2c0DlC?=
 =?us-ascii?Q?0cdbGyuMseEKi2wRsXV9sX2bDNIa9fL5owzQQ8FTN9sS+hiBwN4op6jjeXpq?=
 =?us-ascii?Q?qKFV9CxTykf+plYZejmwzR1NemZuiaIYzZ7StZtylfIas32R9cgLezaVtBpm?=
 =?us-ascii?Q?U+NH822OtyPgcZXJYD50itIqH/7JbkLQ9QGOMOGL/UGzZheXEOzOMkz3Xdzx?=
 =?us-ascii?Q?homlbn2R3nZTTz4cM/AdxAYAFqd6Nbf0MIJ/k7pYbHjZ4L7jmPv1FuerXI/z?=
 =?us-ascii?Q?zohhuGWEO1EvpbRLdo+pwriOcSabdSGzDkN6+gKWlSDDMUrZLVXM9AVTuO5u?=
 =?us-ascii?Q?Q8B6VJBKZWBviaTloS/qtKv3xW66ilmZ+Rcdvkrm16VGuerAXyvTu3rlBuAj?=
 =?us-ascii?Q?fY53tdexhZ9GBb8MzXa2Wl4tLR1ud3y6nWsPEEZB6mmG8Bq+3q7XCQNH/+Cm?=
 =?us-ascii?Q?eEawtgb6SEMPi85qXrx7ipBbArVdjO/37KkYt2hH8tstNlVfXGLYVwki8dFK?=
 =?us-ascii?Q?/wWsiw8VFwRv5QhuNdQDX3z24PGKIBWiOeIINJVpkHVt6B8zjpCKyfxFFRCF?=
 =?us-ascii?Q?EX+bwAu3UIK5ixyQxKXmFbtKibOpItoKPoOupQFxRjY6XVd90vteLFpPHsSm?=
 =?us-ascii?Q?iV5npx6eIv5l2xqkCgTYm38EeIy7w86n/QjdGdWQiiN5+7gwzP6eKlSYzNYJ?=
 =?us-ascii?Q?C/e1EZsstegGYkx1p0uNoxfLKdl5L5CRQ4cswnWHbTfG4wj7m0GWEIVCxtl0?=
 =?us-ascii?Q?FNXp3NZKNTbuOaC6c7jSaR5dpkKL2oKdbRn0ufcA4ORIFFySjJ6s+92D011L?=
 =?us-ascii?Q?rlKb1JcPNJ2hnWANHtA1S6fV7hZBPO/t3woMVhb2uM0dZhOzRE8fRNZFENBa?=
 =?us-ascii?Q?vYCyT2t0SuERIK9DOKIL1yP9vtCz5aJwr6yAJy1gVjoyFhUPBqkMxunVfn42?=
 =?us-ascii?Q?mjK1WJhT3tFL4r0OS/cFVCyGqOIkZGhEomiJyMAqeXY8CVN/H6j7L4EkIzA/?=
 =?us-ascii?Q?aJB0EexwWA=3D=3D?=
X-Exchange-RoutingPolicyChecked: pRISPXPmT3VmBAap819mhgxiBMsfJAD27tB33FkV7mNbK5Qu0EBotRqI9eM5T9YJ4tAnayu9OutDwjJgiZZ2HVEAU3fF5TDhL+E/2J3gWOLAuAlgE62dVFa2qiFx2MKQrFOZkFYWQxJOZqo94unzC1B1JPIXzFiwdegf2xz190KTbGYqL7rcppJdXP4oGhj1XFHGNHjtvyy8S0+2b2CqMxgR5ikrzz8RNnZP5IGSb+xEUFqysU81Aj2cN0cHa8l7obs4RAaXmW51Se5WB7iuaANQKrYuYh6F1Evy1td+Js1ttvRy2CMZqBcTGeENdZDL0idMgFhLDAHOq8anwfPUjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9e96b9-d11d-4c04-c8be-08ded8c6ce25
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:49:11.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcA884FAhGM9PQ7JJztTVaxGyg6OnhIXnadEiIIpDmSp5HU8g7AomhiFR/AYGteu8aLAhU3zFVaAsjJ2WUa5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:05PM -0700, Rick Edgecombe wrote:
>Since the loop that iterates over it is gone, further simplify the code by
>dropping the array of intermediate size and base storage. Just store the
>values to their final locations.

>Accept the small complication of having
>to clear tdmr->pamt_4k_base in the error path, so that tdmr_do_pamt_func()
>will not try to operate on the TDMR struct when attempting to free it.

The clearing of tdmr->pamt_4k_base was dropped, so this section is a bit
stale. Apart from this nit,

Reviewed-by: Chao Gao <chao.gao@intel.com>
