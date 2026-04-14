Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC962399340;
	Tue, 14 Apr 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161988; cv=fail; b=P+77YlEa4AlAfcZ+CR7yK/WLcZTnafwgnjtCRtQZ9FPCS+tvqVA3gFT0ednJ4UsyVc/+UAqgDC2rBYNNKFBkGDDK8b1yOLvY3n11iSi4ILeffqmWDmG0VpsZpiOYr0c5v9Fp8qa7gsikcux009LMf1T6abvLqPZv9f+ebwATHwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161988; c=relaxed/simple;
	bh=VG2k+dfXEPvBcsdLNIdWGHuEls9yElxCvvHgo5rLAn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AFvOYuP/TwTYQIqOl+ToVHCOY4BLodoY6z+M6bhspAr6vxq4n5NmrCapFYV/Tl4A20Ag/pSWL0jqC/3MhzKkhXanp3/bBdcNLPcoAHene8gy+oV3BGWPfszBC0DF6JUND+U+Js3WxXYg9ckG69ceH8OVhWginkwkn1DmIeOgrE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6FqX7y/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6FqX7y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776161987; x=1807697987;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VG2k+dfXEPvBcsdLNIdWGHuEls9yElxCvvHgo5rLAn4=;
  b=m6FqX7y/4LLQRZWXBJ3y7HTBgnMAxePdEQ6nKvzlQNmHVmUXZLrtAbpl
   4PlKAYPA+ZuuF54wcnKnr8JTFT0PObwyQyhK46g2xR/Oatc9glHS5k3g3
   uOUiLqjJafD+59cE/NNYVyE0feHDzvFqnrtcQyrpF8V60/d2r/9xPQkrL
   1Eck0XRcGKPPiPXHySMp9L7uE79QAX+aQlEWYP5v60MG0Xoz65NShLIp9
   vjJkOKPgd7pkpcRaT1muY+HGUQ8fvbWFB7jyyJu0rvccOdzqtLtDYZoZ5
   84aUe/LJF3FSNYkz1vSx5i9iV3Kka3QCGbF1Y1h6ZoCtt9B8/2jdtCjqC
   g==;
X-CSE-ConnectionGUID: GdWR95UNQU+8wP4K8R6ODw==
X-CSE-MsgGUID: 2uSzHMkGRx+P1jGcQ2n9iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87817069"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87817069"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:19:46 -0700
X-CSE-ConnectionGUID: XzqScAd5StWJrxUcUa3qaA==
X-CSE-MsgGUID: COgWRXMbTSOczRuPmytWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230277679"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:19:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:19:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 03:19:45 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsNWRNHoFqYuOvvd2YGuUtoBLGMr+aI9NJKsMEZZXwP/xUx5YM6SOzJ8R953e6rawUPL9KAzuXiqHONb8lgJurHD9qG9qPbhlFCI8N7BVFGlMDOI6bZW2KWVfvGaSUGcnQfyQzOnB9aHajtzkhL4uMZocUsnFUyWWuKs8iiP5Zno6v5qRDU+BOo5b6FTVyD3cB5tC6nQ9InXQoGlbpV0vhcMJYI86OxNFR0VP5HrGhEsOBx1WXeF5/UEQLtCAXjUTyYTSEVNyh/FvK/pTL8lFvjHvxiDCtGIlLPCO1tLBRbizpfSBFR+TBG4eH5gOcaSyzBMBCi/1cNKeezvzjBQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0b/NzZj8/lYgDRHhf6Nak/LnZ/I5+YQFJ4qub2Gtok=;
 b=KZn5ymXVpbPi9ECfPDJJOfm5nnSsaJxVO9DKpOb1duKnYzdizBKIdVHofiUL0jdBug9udjO2hPOCaH+RWIrrOdc8ZVbvPWU7E+dsM6IEsjCmP//lV3zxRvxk/w+A8fXZG4BcKSiUTc9VR+T/FX43UOQ4Ly43cLkAsqGkFR1AEsc4u8u1sXYQX4rcWyV59j3JJcJBbzUkdt99uw6lPCTUy99+4GoEx3AETLxVCuaWt9aa9yn7xqcw3fAhTe+gwBWgpdJfwL/1rgsTBWy1nVRsIAg8mRXzJDnO1GLmkwNXnjCA+kd/MyV1k+sm6NMjDglqiJaGq7c3i02MDpz8sAFqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 10:19:42 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 10:19:42 +0000
Date: Tue, 14 Apr 2026 18:19:30 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 13/22] x86/virt/seamldr: Install a new TDX module
Message-ID: <ad4UsiCjY6V+Ox5D@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-14-chao.gao@intel.com>
 <2eec98d012b85113b4e6876d07eb6513618e2404.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2eec98d012b85113b4e6876d07eb6513618e2404.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MW3PR11MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: d031d556-e2e3-45e3-75eb-08de9a0f57c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nx+NyrAVGqJi574U8aknomNLhvz0jDVYfyi0duez3AWZxD+GWYDFIlJholkzZ9oS7kVzQNunl/fh3+1jowA7dkbxpPPBViEoj5mDNwCoIhfME6fEbJrb2hsE5OfMksr+z4ApE/sTG3RagkVRTe6rhN7N1xZnwfOeSjVtAgcL7c9yNsB/aamCHw6dbLKu1brd2ZpuZzruhH7mp8QmkXLLWblbCRBG+grnR8zb5XILolnEaENNE6+x/wQWZbHwr76w/i/kp1w3DnWEueGoz9/kVyFxQTuewFMkL5fhWzSoz/dwiOLPtfXFRycAtg6GL3Z7FiIUDKCjoMJUjWotEBgyMO8BVqRQzp3pewRVWbv1VzTZMJgglcijqO4znBDk5SkvofvFf2Lq92mHt8sTd4nOG2IL0U3YdjF6bgqgR5YR5NCunHCBiLp4IJOc6/lze8LNo1MkuxmLIyBrLJqbU9qkPcziDWJh1ixeyWy13Pb8DwpDeskeqNPhtz4YJ4e3QCPe6Ul+henugVFILtCzy7w62QmZ44PUE85CNZCH9f9zWzWBYMrgnt6GlHnvQkrt6boQ4XsP8FKB1+BdnxyIbspXe6N8nGHQzVZySHVrSjT/+1cQCBcbrsd76ib13a3SvdtAUGhe1pXo9dqLkcZREbSeD+esVOgdp50RhiPDEq1xKrCpvhGHK2Di7IcpWBhYOfZORx2lISFfd3iJZwi/WEh9FbNAkECHmxt2+QD8iXyGjew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/aAsq3fGE5um8ThW+uOqldbNm9IUmaJNTlpMMshy2V2YOdp6o+urhLRdOso?=
 =?us-ascii?Q?8CH1PBZTss4c2+yCh30j5gknCHyxRSwwV2q90dWFMMJpV5XtcfkHkeQyYU6F?=
 =?us-ascii?Q?2tHuc+Rk14cLyjERGNu2uDjY96muPoK7NC9jLahSaHtJrD5trS9Spm94Iwkq?=
 =?us-ascii?Q?BVg+3rhyMFeX7oVlE7WTmIIHooq4ojmTjvuENEM+JV+SzF/l2aJAcm5Zwnfl?=
 =?us-ascii?Q?/vHpLMIl4Svp9jWNC0xvytxX+mnuwQyjAO7yyh/bFKgimAycQr/tWTNFeJnB?=
 =?us-ascii?Q?OltVLbhXWDNOXVjBwvllRc4Jz0M0thdMlugoVul2aP1GHBooSBBS4g8sP5DP?=
 =?us-ascii?Q?J+8nviaAsXL7HPoP140zC3Hi57wL6jr0acJ40E35jLC4dS6bOsWNQeAkGwKv?=
 =?us-ascii?Q?H0XMrTMPl1OyxOm5VC2R99lPb5aqow9X5uwQJk+yO7LdghUK6Ucex/mkpv53?=
 =?us-ascii?Q?bfuSHEY/9+gK8qnMSAupP0L5CZWUjZMl2KcrN/hYrqw/1+MpLxG6cLJL6ruF?=
 =?us-ascii?Q?e/EFUj/AU5dSTlkZWqkZNOvScCirrtsOPtP+iBn+/JtR/rV7kjNbVm1zpa1G?=
 =?us-ascii?Q?XxGNCrN3AAutWz9iwXFdPZKDLXKQ1217lJQsjhFhY6F4jKn1fcjvY3lSk+Da?=
 =?us-ascii?Q?34QUJonKEVWx80BsNzZpNm/7VYCnLW0OypDElCXKwDF0MsFv5V3pvPrVVE00?=
 =?us-ascii?Q?epVGMwn8Os64FZFBdw0MfES9pZxF7o66VNpx2lhfehksfqgT7ywu8M1X7w6K?=
 =?us-ascii?Q?wyu8KXT2mcFcv9PYy053WuxirGMRFU5baFOy3j5yqX6kT4NWxmKyb2X1HUnG?=
 =?us-ascii?Q?LIDM7lySMsRHWcg2ZYpuZos5gjz2AhDdD7aBFnE78NbVzoUd0jRZHcgs2VW5?=
 =?us-ascii?Q?X+f4hu70R3zTHjHR3qlWzkMZOALBd2LEAWgtuQYGntStOt7nXajj5UuIRpa6?=
 =?us-ascii?Q?IBMDxPxivmvEUKmUKxbVN+94ij6EVdiflaMabrwESBw1KH24ti+UWP4ONAFm?=
 =?us-ascii?Q?35XtYaJHyVPmEewWA8nXmcgrWYJjYMB0Co4Q5ZooZOzpUMv9cDFcAvr8jOyt?=
 =?us-ascii?Q?fl+qFt0zl+E7Ek9Yhjx+W7Vis00/BuWs8bLXiRwWs8ejJBa4y+0KjmYbwfVo?=
 =?us-ascii?Q?JRl9RNK3E6rETUnlJSpiDomvaoGatKn16tXq74qYhv6edc4Lyq9Rq3/CNX3Q?=
 =?us-ascii?Q?L6S7Em9+q1Tm8GSDANpqi38j3O049YsZuOeMAbbXjk9gSWZYOwbWC4TDQEGh?=
 =?us-ascii?Q?i3jnc5uuDDSKPUzF5jIbOzwyzXw+SebD8Y4785FKt54thghqtZAfNW0tlFYA?=
 =?us-ascii?Q?hpe7FpEYkqnhLt/p6MVHkT8+sI0OCqffWszTzeJ2/uoo3qx3F/WJaOS3qtYZ?=
 =?us-ascii?Q?AXnOzB9HrzvKyYlFRiO2Ipk/d1j4hg8c2XrLQ2lCL+Tmxy0RUleNQJmr/0go?=
 =?us-ascii?Q?ibXvL9fN5gifgIlBmP5vnlI1OEeJ6Mb2odPQgVn0ZfrVhoJw75610y1BOKty?=
 =?us-ascii?Q?6unWVxmOwL86bfNjiTJgz6EJsvEZD95VWRvMOVi9eWbphe7ZLyREnhPiojeQ?=
 =?us-ascii?Q?7nSKCRxW6STkD4IMuHJtA6LsTnHQ+gO3pltWh9UlZaWtSk9aslPDe7nuW8zu?=
 =?us-ascii?Q?vYiWzMN7yuFVv5f0a83g6tt7vQWZ4ar4y9sVqxPD+QTYI4EEgqTop6Cbf3yA?=
 =?us-ascii?Q?iMkEZbTp7L4Hki6TLXNWfR31s2EqmbFuBLIulN451K5Pl0odJ0c+CbE6PMyj?=
 =?us-ascii?Q?JAp1Rnb4VQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: khncapzHpCYZc/kElEk7+qDX1rr0UlRvJDUmiZchS/Tp1nfceSa6OL6miv4T4EO52Ut+clhFWG3Qd09etkh9111LmhwQBEsuEkKuqyutJyNwrh8f8RORgtmy/FnjdTkNZZuHUPtajtL74c3lNOEld6/ww5NJT+h/wcsgbP/4UhfIH5MzVPVeWxizWDo/GzLdxVPIiza6aAxyweT/9HkOmsMaYtuFEagzYhRnosjWH+xUZ1IQmKF9Y6V/mDpznGlzRKWsqHsen8P1vC439TIl9WPsumr7Ei01LZXWZLc4zJ0PR3qhapfqtlwMT/RGgP51OrQjhOU60Y9OOog4kCQzBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d031d556-e2e3-45e3-75eb-08de9a0f57c2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 10:19:42.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhXC2jpQm2uXvp26Xu0N8Hug3CYBkfbZroDSWYmmt8VDtJ1Q+rMpcrIXc+78jz1VtRwl3lQo0mQyyNAVeLB3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com

>> +static int seamldr_install(const struct seamldr_params *params)
>> +{
>> +	struct tdx_module_args args = { .rcx = __pa(params) };
>
>In an earlier patch you have a wrapper as:
>struct tdx_module_args args = = {};
>args.rxx = foo;
>
>Why the style difference? It would be good to standardize, but the existing code
>isn't standardized. What do you think about going with this style through the
>series for the one arg ones?

Sure, happy to standardize. To confirm, you prefer this style?

	struct tdx_module_args args = { .rcx = __pa(params) };

it looks more common than the other way.
