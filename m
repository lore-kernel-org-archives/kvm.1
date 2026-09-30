Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EF525A77;
	Wed, 30 Sep 2026 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808899; cv=fail; b=YZML6UNApD4yz4tmkPg3bf3mlSE3lZhi41vaZtqFYyOzg4u02Nd1mTOiJAbeyd3Iq0IO2OJtwaIF+xrWhg9uTBbRp66dxu2YiefB/q2BSJBO9ZPlRmbpnKtep1rJSWrWHFuUUN4v4zzjiWIBcxQGKpTL1XM8OUjqnm4ZNRcc3NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808899; c=relaxed/simple;
	bh=xhKPKyhG1szMgs2NooLZiOhtX43kvmz1PyWSIppyEeo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Is13ptUsYtWrTrpgI97W6Ly7McKXvPnVcOv7LGb10umBHE8cR5ZScFNyLOaE1xsSWL9QbD3Cj3w7aXdL8OkhfXFD0HJODaNbmtN5IC1sZKX8HfYunuglnUskYk06F95NYQyCwq+7mkCZrgGYVol1CR/H9eBwxHKgGd7TUj5byQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzuNcn7E; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzuNcn7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790808894; x=1822344894;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xhKPKyhG1szMgs2NooLZiOhtX43kvmz1PyWSIppyEeo=;
  b=jzuNcn7EPplmwFFezIWK92Iz7TVHeZOiLLxHacxcpSSYG9bIWv58flmI
   0a8uZleIrWR5JCGxOoCS4jWrlQCAUrrO/uPQA3wntbenpnKLJFIA/56GN
   w8RebKHB0h1CscNV5pR6xoL2qJP6FtxbJ3CCkJDa36uC7PC0aVQ/dN/fj
   juBcPqcpl84zRD+0CsHuvR4jOnDd57OCn6powAh0Mi8jQSrkzTe21RR7d
   5DoWICegudSTeiAU8jqUg/N8rkCBa9KvU+7AB1HawOfjM0RaEc8IIKOr4
   UTBTUPMtKl0uiVmCW80z7W1V5Q6ShfguA4++9H+vqbVl9nyx7vegyo/kn
   w==;
X-CSE-ConnectionGUID: myzvqiLxQieHvyW+M4ZLpA==
X-CSE-MsgGUID: I1fzC8/mR+GgeIrJINHM4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90459425"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90459425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:54:51 -0700
X-CSE-ConnectionGUID: zlRamd49QrKukMYT7XtMdw==
X-CSE-MsgGUID: qmKyhS/lQdiKp6nt7/7pJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="274435788"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:54:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 15:54:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 15:54:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 15:54:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXPP7m/XCoj2Dog2+raTD8RtiY39w2YqB0Tkz8JiKJBryiSHXqAccdRmPZZ+P+5YjK9ubo7178yGXiQjUZjO4aRwnfK47Qer2O33Sm1e6c6EMzAblhJEAMG676Ex/qLoEIBaEkKhz9fyZSFhClz9Gmdl7GHqWByawUot/wmLqQ+mrQehy/VfeaAfKKC6Hd0ZyXavJcwDlQbgfFh0fbtunYY8zGbp3hzvFf25L2urzoSL3gKP1tP4R0Fxef0M6C6kClWUZEdgDpyTWrfliVI7EYsdb3G2pgIjWlNJOilK+U7TzR5StwyWSwY7kkzXEQfNe0Jk2DVyPeC1PrMLZdoexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCDK8s1YD5sRoqV9K/FbG+LwS0FzOzniO3UqAKXhAJY=;
 b=pMVtx9r0w0gmjjpiy+R5jpm7gvtg+RTqFbv3u+hCiqWTmUCCf41jLkmniuo/LGxoTBvvl1yjgK1AFIiK8Yf8sSYJ7J67Tb3ZhzWt/11XXCTrRPeeb5Xe7+GmwyTSZu0K6agFGAevGaW4WRPfrDgBq+55soEKb4sXihYzZUVv6pTTv+tEPs3XgegT1tHiALNhLa8BWX7USj5P4PxNElUwLDIcUzrGqDsS8ZMv4cndPQWWKjV38cE1nctHozx5p/OE5Si9MEvVoop1g3aU+8KIj6duNh1/m6OsUzIA92tpTXwt+Rt8J4D8mjq1fbFYte5vN8SPjauBcjP6Ic1GygCLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS0PR11MB8686.namprd11.prod.outlook.com
 (2603:10b6:8:1a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 22:54:48 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 22:54:48 +0000
Date: Wed, 30 Sep 2026 15:54:46 -0700
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
Subject: Re: [PATCH v6 0/6] tdx-guest: Make Quote buffer size dynamic
Message-ID: <ar2TNl7rkKLF3lF-@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
 <b0608ba835890246be2f70b3307e76370a949729.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0608ba835890246be2f70b3307e76370a949729.camel@intel.com>
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS0PR11MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: b54ad457-7f6b-4f30-3106-08df1f45d47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: vzhJIZBFmdSuWwCuJQVQdyjA/rlSg5wst6q1JzWpBZH5snuP8xc74LSwzSt9cdmg+QuzcLpzRP2Ty5K+dw+UPphG8EV049r7PgkSgQEuwSllklX/+GoIok1FMzedkMK9KofSHFG4sf6VUDetW6jw07UG3Wil8qTifafjusUsOpnC482HMEJV5GqKCQ9q8fWRL1ngVkkfsYHK6w4aZ20DWJEIAoWZh2nSLEFaPusatXX36YFMcI70jd5Gmnj5U3DVvXy08TAqPXa3QAh936n8kGaT6/3qcYNZTHq/P7AZxis9u2WU9uvGrG7ZIGUgqM4PLaWS7GLJhzrXATzJcF65hdHl7SuAgDCGO+M0iZMEkVfI6dL67JuoV9lS20QntW6i/PGqZJpt3vNaSuv8OeruZq9HvUkeTwpykWT3kAcJpSpB9k4JsBWcpTL+AOMXz09v7mz66s7RSCPSKx4YePIw+iXe4Vz4rGUnuxPCPqafwnp+A1MDnKDk4UBVPShT0bMxlSD1XN53txhKwIT6eOxDWtG0saL/UaNYONr9Ybgol1dzrIVX0lbLefYZMvDlJuhQ2vzrWvYnW7hDYDbB63gfeHNU+h1gPujSIzKUctgRx/lLLwt7kFHD6tReP9b4qGVjtnqjsdQK9ElE3+fF2RVHZ6ZnZyrIGXzOedrJ3zNtCiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQJveR+ixWPM6UIqJqkESjg6F7FVbqOZiw6/2+aUQ3UkC8YFTSYN14kvlqzZ?=
 =?us-ascii?Q?AEemOhWXqqxAdwswBRTp9RJa3QDmlmeAWNsXTthpQzxDHTwa1sdGmI0F24vm?=
 =?us-ascii?Q?FAD+LoGj9UbP7Onc3MkYzCuykMnNlSyblsbAEyST0WOHZZEe8vzbhzDaRxGz?=
 =?us-ascii?Q?p7k34X6FE82rCHJDfrRGNxkAsWm2MV0R5f9Vr6Xiu6gRP0sIMj9rpohJ4AcX?=
 =?us-ascii?Q?R9+dBVLbu1bPysGW/usBsb9IpNeK9Uxt62S1mwYjJyrpYcsGQQa/60wotEjK?=
 =?us-ascii?Q?bnWmkutkVCIlQhrm9+xcmZqC8EZOl3opTE8uZvdI39rHF98hrLGBBerWqAo2?=
 =?us-ascii?Q?XE33a4A7MtWXLj39O5rWGDlkk5se3/EGUwlS3OgfTsTaMifqymr7DZ7kefiI?=
 =?us-ascii?Q?05TOm03XRnhsPf7gu4ywGeXjt4S7IiIxEIIyW/6+TJI278UZ5mHKdudLpDD2?=
 =?us-ascii?Q?KkKa0nw+wg4EjGVunI4DeE/6S/WrOKbc0ms2LM5lrumKBnPEkOekotW+32kJ?=
 =?us-ascii?Q?jhSeQk9jXKr7rKeofIqA5apvn6q/eMiuK7GgpzzoeqjaIDDnhPaEvPqzsUSZ?=
 =?us-ascii?Q?Bfd+k+F0usZ9HuLhV7HMyP66XvJBJ9g12L6eRCvMLTz7bNt2uxEHjBrt7Eqo?=
 =?us-ascii?Q?PvCMCMHepM0SlN3295FRTTB3dzUbpvb0IovwwePyWueUF52OsNUsgr5Gqh2H?=
 =?us-ascii?Q?BaSTUfGFVSf1cYbO+absnoW5tUOt24crhkY+2FYu7sCBCuXfGDZynaFa8Vdx?=
 =?us-ascii?Q?VaSY8tMF02oXZMK2fYqENDOaq67Ns7mQCX0hSNqBWopGNjTCrgZcCqroE1AS?=
 =?us-ascii?Q?rYLpp7Tlwz9oKuzv9znA5dNs1L3sy2omImjjSJlMc5VM9XdkRgLypmPzm4QF?=
 =?us-ascii?Q?03GGylcqbky/Im8zm8bYaNdQCJ+Do4xDF1mrgAGy50jnOZyOmXxfe/Dd6+xw?=
 =?us-ascii?Q?8uEguNiSDB5Pe+2OIp8eIcxDZ0sCDX8v4FfjIkxw2dnynll4UPfgdhmbgyG/?=
 =?us-ascii?Q?JJ4Zv0+bEuSLmZHBGsx4gaI5lY2uU3P1m1YOAO99dRgrL9BqCTxBTQ+dvz2o?=
 =?us-ascii?Q?pUpNb5NWfDq5/KC+Fb7Xhpn2CADXaALoc/DtNZi8s4MapeUMH3kvXOpNEmnc?=
 =?us-ascii?Q?ZO8v0WZltQcZiVPNoVQ5Chd92xo04WxlpOywldLRl0HnreRNmMcRhy7T99o1?=
 =?us-ascii?Q?ED7GLQXdB0yQGBTi8/C43JOZbvmM3v06POATZgUNNxeQbB6jvn0sv6AJvQLP?=
 =?us-ascii?Q?WIxgt0+fbJWR2CGk1AO0Zis1RIpTclaCOXpuPK/EjqRiitlEJSC1KpVf7fpF?=
 =?us-ascii?Q?5CGyXWUJj7WdbudB36WVt+Nb0wItKqyzGHjfo5Rbn0Qm/saj1MJZMVH49Vh/?=
 =?us-ascii?Q?S8EPhpLJdWyqsfWRy2sN0DB5rdH4V9TW8jtULbeV+dsfg2/p/nRSlC9UZK+n?=
 =?us-ascii?Q?/2WWceKnFk97fffPg2YgReBhpm7Zk4JV0ZapVp+xxu1gm/t1gWPrXWPSWIsq?=
 =?us-ascii?Q?qjoMEAlrz99NK7LHo4KRovqh5ZkEnttmdaKTnQ85B+AqIV1HKtIikWj5rD8w?=
 =?us-ascii?Q?HahDdcbJf9AWnTjx/6He0q6dDfvoEnx4Sh0LTGx3nUG7pv8fVar7BT1FFMfP?=
 =?us-ascii?Q?5tV33rkERgM3XKxDIpNT005TFnhGYDK6cB2Ou60IJBPQuVdi2g98qiEqjyGx?=
 =?us-ascii?Q?F6oH3Di3sUESuhA9p1qO3pIXDbbQnYSkehVlVdBIVxY5IiBXfIEDYxBx9Wwj?=
 =?us-ascii?Q?tVLNr3d1qg=3D=3D?=
X-Exchange-RoutingPolicyChecked: eRGD26QfSQSscRABqAF8fKBUC8BN+3ZDu9jQ8fJQ6Kse4aF6DpvDLHTBxw5OmJhlPxcoqg+Ivq1qFiPMaooxrQB4tlW23Q6yycRifhNuHkBEiApC4DKbAwHq62J8Nbem3iG+MWF4O4diDponBkn/RjzzJQJTTU0wL7KJwtOzhVEkY2fE+wXj09ud9XbqfDWPB5P2ulzws7IkfNPTCYXdLtrimVpcgB/q49SLF9p+pwO/XZ4q9fcnU5Kr2my1SPkDqb77N3KkuFXWBZrR4iEFRhZ3w73OWnvZdqUWLGkXwMHkl0vePNq7Wk22UX8ZF9Dy6+RjbHojMPG4Yp2oLd7Eqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b54ad457-7f6b-4f30-3106-08df1f45d47a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:54:48.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTvSoQHsYyLQZWv95Pc18TanrbipPlDrdr1/SJcB1UUJkz/pX8zbq3tZkCgYwTVoB/h8xijEgXsCqIwrlOIcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8686
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 03:17:20PM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-09-30 at 03:30 -0700, Peter Fang wrote:
> > Patch 1/6: Take the Quote buffer as a generic pointer.
> > Patch 2/6: Give the Quote buffer an explicit type.
> > Patch 3/6: Calculate the Quote buffer size with struct_size().
> > Patch 4/6: Read the Quote buffer size from a helper.
> > Patch 5/6: Add a helper to read the QUOTE_MAX_SIZE metadata field.
> > Patch 6/6: The final s/FIXED_BUF_SIZE/queried_buf_size/, when available.
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>, except for patch 4.
> 
> How about we ask Dave to look at it at this point? He might be willing to just
> fix it up if he agrees with any of my comments there.

Yeah I think it's gotten a lot more mature after the past couple of
iterations. Thanks Rick!
