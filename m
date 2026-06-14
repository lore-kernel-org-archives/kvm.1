Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD3171BB;
	Sun, 14 Jun 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781420438; cv=fail; b=aCQMcsQhIZB93kDtUlBQmYov3XbB4F/qHvP1BMsIxo+kLb2LXnqp2ppfEYAllyost/BlN1YtdSlTNrUW8hGIh4ISh0LOReBl6PY0mgHf0Fqla9kqeB9wrlglma7NpTKa0FvQcLXI4TZmeoOhCszpu2w/xBvihYePjin6e/cpVIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781420438; c=relaxed/simple;
	bh=KZAmL5QKPdTIBtjtqBzKk2j4RBig7xxkKLZyXPXJhFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fGpqipgg9i40saHoeyffSyxyWMIgSDpGKI3VFUYjcuOr/P5bgE2bwr993clsAZm3G0IzYqouaFlLuLVasD/hWxD6obOtGr0mGwfL9hnwVyx8nexSeqEJDKunSbtaIlmDyxYqoFTBDZfTxsvjnmYzzSDak3GyE/jUGPAAFC+ZJF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0BWFttr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0BWFttr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781420437; x=1812956437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KZAmL5QKPdTIBtjtqBzKk2j4RBig7xxkKLZyXPXJhFw=;
  b=Q0BWFttraY9i4i56FhyuN1+YxDvjxS7BCv9gygg30NJ3XcTIRpK/hdua
   EYT36RvfPIVIH3RLci/qJMH5S2qtNjZTaTxwFkklndp60HXbh0HHymGOZ
   E84cUQkJJjUCywQ1eClHoa09ED1RXCOIbc/5AH6eW+O3t1rnr2F6B18GU
   74bhUw3FHXlTN3PKxppz/IEAXk3SMsZXiwESY3D1ysgLnWTZ6/P8Bmgok
   nIX5N8Y+bw/hWk58dLUNfnZYB5Tx7NSzeKnIuJxwhzDtnPTGrHwnr1/bx
   jDpXzUrp20V5tjCRvR2MFm0jn06lhn7HlNG01Tkue3h86RbcClwfx8vpb
   A==;
X-CSE-ConnectionGUID: rFiQyLDLRWyfhxeduTFVqg==
X-CSE-MsgGUID: lWCw9f23S5KJvtdIp5Pq6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="81211175"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="81211175"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:00:36 -0700
X-CSE-ConnectionGUID: 7fso4wsrQrG7ccztAe8Ecg==
X-CSE-MsgGUID: 3d8SiM0oSRO5qQVIMmKSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="271251825"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:00:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:00:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 00:00:35 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nekB9IQRbslwel+TMr5DmL+Ck1auV+E5lCF/La/xQX73/VkV4DbenHc6wo7xdp6qcSf0uTgbM783xdYoNuItEPn1tJyR9pnuEnU1YhCjA8iglK2367TuEegH/UjNNfi5TtbprOMzEMa8fs4e8Xmto8nESxrhDYpagZWG6lLt6Vfs3eeHXSTOo4RdUjDbAD/NXFRI5K8K791P4zWVbs2AXsnd8iJGEgmnCaJjMFrG9e+o4wZiou2s4BBnf7EUaHkA0bsCNv8fctIISHmvsTkOASattwHCFOblOwEP4wtvkw3sbMIysku+9IaWd70B84sDbM0aYAw4XvcxE7xi4maxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF4F6w/NTv3c/laI1S0LKm94z2dAf4YhEw2VvtfG9SI=;
 b=H/wKliSqnpUl1pvCC4b9lIFF19CEfDg1wvoC0Uo8PjUYN72FIuPfm2Ls2sH2uKvm/2MaBV58IgXEq/3ECsiHwP0qryMFtSUmqVBD/bB7dMvTkWsr7rI4NOkb61YxUj5eOM/eIssWioZppxrAlNuPwEnYoF/NCVNOJ0wCa6TkcKfVvfZGZUAInnVEsdJGNvt82zBPXEY/9XDzb/icAIt0oqXpL+qrzJFbZySNXAyUmg/04eg28A3I0zbgJ7tzlFkaetAFMKxj8Kq6VHYAHOEbP9PFysSP2JSsEo9aIIFAe4zhK0bEwo+GOP8goaf5FWIHNumPWNiJ5F9yorYb3UoNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by IA0PR11MB7936.namprd11.prod.outlook.com (2603:10b6:208:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 07:00:32 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 07:00:31 +0000
Date: Sun, 14 Jun 2026 00:00:21 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: Kishen Maloor <kishen.maloor@intel.com>, <kas@kernel.org>,
	<djbw@kernel.org>, <rick.p.edgecombe@intel.com>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
Message-ID: <20260614070021.GA3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
 <f8b7aea2-228c-4e51-b79e-094da656f4c9@intel.com>
 <aiaVk9Lx7iakgd4g@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiaVk9Lx7iakgd4g@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|IA0PR11MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ba268b-7779-46f3-98a1-08dec9e29fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qa8zj7IIMfs4dnpSRbMdrPFBmCsf2bMXY97CVFJ+DrXf/m5fOs747yqjiRJ7pccK+22zXMN5x4mewtERFIr3pd0O4DuBHKRonPZzUZGAtQ+8HTlMCf8VRoRe7YQG4O0FBewwTWpjK0YSHrq9SfzrEvDQbM7vHhd36xzoUqnjvO19wWjDhjTZrJau6G+cXC6/NhzoS5MkxJWKEv4ubNI4duLY/olgPkJWO9jjXuS3AMLFze7+CqXqumxJPC17bpDhxTzYbtuEqVoZhkXkMr+Hw4cdhM5osd/5Gz8db+4ZAthpo+nCyV/WdoOdL39v8N2oSXd1MU7bRG40r8/TJvuYu9sORqUrD2o+u5K5gL9HtxBw31AjC7YQQoWvqVd4yhwsZOBoz9URcXE5Ps7n5LbM2lqZmmGH/4cxJBDhHG/hjbYVj56W9NFjryqfsk9f/CZ3S5MJ9+fmqTLKPv0noiKrwndEvibob1oXQSaog1LX2fknhPhMw9X1rdvrWNS1RnasOW8/M5xom6Dmj+WFhflTvGjZ6RH6gf19gBvT/9qzWqGgsken4aU7NRXPBhw5Q8hxnzFmJ0pF/75+GeSq0QJLWHwqZ5Ze8OnkL8cbY2NGBHdHruSTtGnTOgcg5aKCxHYGhYmDyxP0S79cUnvn7HbwhISAgOO9blO9IPyrpkP2gKc4875DWyu8djsL1U41KTJQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sk25AAWIBOGZSlKUh2XzNvcQSCk6X3vzG2a1iS2qF5hxU7iyaEnIn6ZDh+uQ?=
 =?us-ascii?Q?SdFyIPNQlfqqWDN+uuwEuVBaYqQoIN/YloimqF1y2HAcqTyTpgQuoiRrqL8F?=
 =?us-ascii?Q?3u+AOpPolXtmCVlUWXWBdUoWQGwV2SHRsQTehja4VJnwVsviLI6jQtNrGNj6?=
 =?us-ascii?Q?u4j0DOTIRwGdxVFdIUaC3l9ENmpYeH+pang9DO3N2PX0DY05lHSebLpLjSMF?=
 =?us-ascii?Q?RzvDxqRKLr07viUw0hw+tntK8gcCzTxjH/nMtU4/R3f05Yhr9mcjKWuATUSF?=
 =?us-ascii?Q?SAJZlvsu0dxK7NL1HZFMntqpMXKjex1XnTZqrFlw1MgxOK0Zsh6SGnfFtBAn?=
 =?us-ascii?Q?NKmtEeBv5xslBu0DdodsPcVG65YU1BHHOjZWuCZDUx1m6drWb3BB7R9JkDOF?=
 =?us-ascii?Q?+zpHLB+0xvTb93CIJkjaWakicUJM3IvCZLK4DE5gG3beIIovNtaa9Xpq+ndA?=
 =?us-ascii?Q?aAuxIepkQpbsfjpK6+8lI8OArhHC/G/C+AZEhvzqBjtdbpJ0N1PMNjLN/Ti/?=
 =?us-ascii?Q?5ghMSZYHsxhQBzWHa3mdODfku62WLMgxPBZFw7o3Q9XI5ZlavY9HxE6UgihX?=
 =?us-ascii?Q?z71yUCRDbqEyLmHPlxRBJfIrRdVbxXBYT9cl5JX3oPTUftBiGhVozGT0/m5G?=
 =?us-ascii?Q?C3E5775bQq3V7wYs2L2Ci0oW+kfVaGhcHvYog37x1dCFViG8gScaUVqx3kc+?=
 =?us-ascii?Q?dTV6SIHJ7STVHfhlrdw7twB8MRz+YvrJo4j58ncuLB7ff9kTOxD4a+EDLy8b?=
 =?us-ascii?Q?TG3oiDwj5v4dFzYVFxqjvwBwcK3QxzsWNdo8WuS3zEKrZ6O3vBF+j90gzyHq?=
 =?us-ascii?Q?XVwkrBqlBzq799OJxBqtu7D+e8td9BMUKZeOP6MaH6l6xb6nDMKROBEJn2f9?=
 =?us-ascii?Q?l5HcwEQ62UgC+Y0fPNqCh7rCeY+IIa/au8dHObaxYg4K2fJF0RKI2uC2xwT3?=
 =?us-ascii?Q?BhnIXyYRlxFUVX+XePqKGIE/kuiiCDMb1vHp2OAzJLKWujTHYB/Us78w0Bh1?=
 =?us-ascii?Q?DnaAJo5n6qyWMnec3WQITkMp75hI026nj0p4hBY9NLIupuwBZuTgQ5/9slQv?=
 =?us-ascii?Q?VIYayEHi4k1MXxnnaPiCQr+0rsvDJwzHZO/QaGFR0nEBGfoXvb0NQBlpibik?=
 =?us-ascii?Q?Q7NdVs3ftVkYApn69qR3L/iUYlMQ6nfgw+iAeHfcKkDIsKxLBuioBfZyCInG?=
 =?us-ascii?Q?7Q5h8ab8bDlnWVqZriQ17jT5QQZpiiKOKr3OGFc8tDen5BFW8Y13F/4H6cRL?=
 =?us-ascii?Q?3r4Tc7jJiR0xgd0xNt3Idhq7Tc78Qa9OEYiWCTNY3ejL3LFep665Huo0yjhM?=
 =?us-ascii?Q?Qwkik858G6aTp0g45gembVX3T4cJP+objC5ftXUWvYQUnfAxttr20D/MgrXN?=
 =?us-ascii?Q?Q9W0GfL5jzSwK1TvFv60eZgxM5yJ051/jGe/uf7hSh4g4AkexzjQiA1x3+nb?=
 =?us-ascii?Q?hjcMfZomO8HcB4ZmEoiz6mdT6wz1OVr5sNALSdHbCv9ogA/LUkLq4lzJBh+v?=
 =?us-ascii?Q?nu9NC+Ie6ZsJCQRbh+LWqHXmlr65NBZosSIKldtxEWbZjonM/CvdqZNovZV5?=
 =?us-ascii?Q?/poCnrRDzEoOE0N25O6xN9pLRzqEWjgXdW8rHsH6kdph4Plbc4PfDOWKTiYo?=
 =?us-ascii?Q?Xt3B2Ifqf/o1jAl9AvfROq5FYc/2F8IBK9+w8Z6ow/rtGgXNp1NozW40sRgK?=
 =?us-ascii?Q?/5Sebh2WR3RjHhdw+wMkmnY4iOt6UXxo73IuDcS9s64/0tK4alRZ/98HG9mU?=
 =?us-ascii?Q?rJdXDftC3g=3D=3D?=
X-Exchange-RoutingPolicyChecked: jhiE5I7rCikVjRUDUEXItSE/ZM/XkuCHj2K+4beb7YopqAEtS/2Dto+JzcUaY4gHcqX3+6X6weB2jb1Q/UEiPIGeGlv6RlpO5X6LjyYSWSm8skQAJRYIBGq9YJO3Ly74hFIFLEzVCZx3jyTviJ6wSn+vcfuc6YLLboBuXIspM3+MpXuUCOgs/swghCS/bnaPyXEQnMJwS/KKwmCeUW3HhU/ebJu4Nl60M648DrH8nK+5/mb2mHTnty2qouMNfK/QudPoK5gZFxqivsaGWxZOpPXCrzO1g7znZPpIamWgnbO/jIYl5S1EGSqtsw5/X7+lhCajsT2TQGf+d6fGm5VP1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ba268b-7779-46f3-98a1-08dec9e29fcd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:00:31.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7y0EuyiNbIQDgjuAku8ynEfv7DiTsMYDCuKknhejKheP4L3QCmy87OY1cMD5b1J5sPMxBCly788DKRP2pNxgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7936
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 06:12:35PM +0800, Xu Yilun wrote:
> 
> > 
> > The handling of tdx_quote_init() in Patch 6 suggests a more
> > best-effort approach.
> 
> TDX Quoting is however a clear self-contained add-on feature from OS POV.
> Though I'm not sure if a TDX platform is still a safe TCB with DICE
> available but failed, and good for "best-effort" policy? Maybe Peter
> could answer.

The DICE extension is just one of the ways to generate a Quote for the
guest. If DICE is not available, TDX can fall back to the existing
userspace SGX Quoting flow. So I think a best-effort approach makes
sense here.

> > 
