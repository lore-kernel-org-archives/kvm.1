Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632E3CCFCC;
	Thu, 27 Aug 2026 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869384; cv=fail; b=bYE3HBZMx0onVrwcwSVfR6pMC/WETo5Np1eyuIgpHO4J4QW11RuCDZQz1QT66JkJFyX0wxSJ1cAcwp01zDtdZsWcekO3bjgmKviDT1Pj71OoM3aIg9NlVppMLrSvN8l4ONQtfDNnkQASKDHEgfHvbZYtg1XiV+As+NbRzm/21Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869384; c=relaxed/simple;
	bh=MlFwumFV1FIFxlvVoXG+WcFslJGyklFZJdUFmqywgFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xn0/yuRmA0chPxrOO0YOyjNtI2Slfdqzql/D9FnTLjrcH2z+Lc7v71NCxAapYgyYedpJXFCt2XgVYKyAOF+J9mbVLaR0/l8vKbJNZi+Bu1G869ixzPUfPNhM2Yi1X6GbB043l3FQbG+/TEVF6GB6iVZQvSEJwFJ0TDtnTShvTZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsDG1JvU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsDG1JvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787869379; x=1819405379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MlFwumFV1FIFxlvVoXG+WcFslJGyklFZJdUFmqywgFk=;
  b=dsDG1JvU+K3/3jX6p1eZpZ3P4S1gPWRDXpCviyMIg58YHzDcumlthmpU
   tesqFNsy63OFaz+pb0S2tW3iLNprm7IjAy9R5IUd0c+rrGufrTi6AYLHQ
   bwRQVlfts35dU0RUAuzXAXuFw97QTNMTR2YDwpDo+ApZsBQE/bCF1JH8W
   738hEnfxmQEbRim152mOWoASZ2TeYyRuOV10bNOImkwOFtXPt/2+wBE9t
   CMhpKzmadGJyxb4av/j87J75csJLmrgLT8WktVhL1bxrT2KRCCHHYM5yU
   2BimHhqZt2ZJHfRZfaWewNkc/Ztlc08devL52lZpeQuIbf4Ba1apDKAwj
   A==;
X-CSE-ConnectionGUID: BiHaCBGwQqiz5Bo+9gLvWg==
X-CSE-MsgGUID: lNLY9rR8SmGq6ALq9RXGqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99540636"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99540636"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:22:53 -0700
X-CSE-ConnectionGUID: tcKUyRbFTxOFprmvwDJdhg==
X-CSE-MsgGUID: +84URCjAQZ2aBF8haEaZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="268009511"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:22:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 15:22:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 15:22:52 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 15:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXznPHMwLQ+SNt7u4WmWx5/nY7gFSle8w8ALKpZEDIecaPO7zWY87nYLPjNEfGCA3B0c2yAc4CoMuecybkVNmbvfxsH0LeD0djcINADdnbmmEFOrS03uu6lpWjOnjA1LYoWqT5gIgsl9QiJdsAQ9/1RKCpxDTCvGRVH//ekxBxen158hRcUIZW2yaCI+gTEwAMC+WNvSBMaK4ZZTGgH9mn0qBYEcLSLeSKB2Mc/TQxeCC6G51vsU55q2vbfzMIMGD+iqtJHh8ztF6jQuDqbHCpRVrlJ0JFgRm88ZZHSxZNWgXQepZpKEp5guOFLP1o4Pd2quuRr5ufdeSnuxiYxUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tglikUSYmgzux8/yk4ot8L069vd7daGyywTle5vzngQ=;
 b=UEd4ar7cobnB0SrM6WQPqwzGXjo13DiSaUI9FNs4Obv62nOiAnluiYpPtmwnb224DDNhIBMQQPsvE6nLwXEKXC2xOmVPX2u2G4MF+LZLPoy4LfZGnLMsYC4Kysk5opZsi8+eooO05XZTKJgWgK6gFFG8QpF+V+L/gdtMdHRObLbImv3osDINjBKLYcqOWQQoPtlDoOe6c0WXwhtqoiXQiJh8ER55ols9mhijc8/0y9S308fUIle5uWRZbkXNobQztCwKjBcSWi3e+gGlbcimynoFXZ2qcKZzS+jZML9ODMkA3d0erZ8QuyhCEQ7yIHOyqr6NkU8j2JnGrS7LVYMxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB4885.namprd11.prod.outlook.com
 (2603:10b6:510:35::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 22:22:49 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 22:22:49 +0000
Date: Thu, 27 Aug 2026 15:22:46 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <20260827222246.GE33657@pedri>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbf7191-000e-4b40-a263-08df0489ba16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|22082099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: c1A4s2kyRje0Pej9AskgjZVCcms+gJnWYmZopY4O6m24yYIbr3wVQ7/miy8BQmtQWJlWAfLfJSXejVE/NAVu7VwJDTsKTYGlCU0PIThXoDsASvD+VcQ41ZZ9kVIkebAh8Us1Wyvgtr3luX2JFyJXuw7OshJM/wiuj3SGtEMRre+X8PJKXw+7mHHlLrguNG4lBwSZJKiw0GTcCGYn5k5dQ+zXKJ62wwOrninuPHnTjyRtfHkZHV8C9M7FyLxIUe+dFpinPDf4ELJj7guEeGhVGgh0mCoS70d1knu1O3tosMGa+IUlNkFlqGnU9Y48L5w4QSUbG1q1//THKB5ouKMY+89/pCnaZqWK+TQ1+ktJPKfRIji2D3J27cDS9priMm0uvGjkPpHMVUJ2TJWvWh3ZjJtkGcg0geXpokDydmwZLJpw7WlOCW1sMXuLeVa1M8yj/Wjxq1imiwaoUTKdiK0p4hAulURw0i6mlnoCBXMEqsKVLIV0zikAazSyDdr19KX9Yb6bkeMdfiwPp/Oi2/oyAeT+hmpp3MoVyJoES/Mk2ZV1D8LOVEkUu8a4g4qAOmmcA3bj6ifF/ZNy+iCUe8OsZraqM/wvGvA6teLoo3iKnVM0mm4dDjmf6wGVtdPfdvP8ExhMBNIRa1dG7562XS5Io9LV46gAHCn2rBhGs1bijrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(22082099003)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GAk2h0hqQUTKClDDERnID67zJNHM+HERX+brIAYY+0IRn9xOKy9LIABTKtf?=
 =?us-ascii?Q?fbRfjcgijFwuZKFWcWdJ2wvFdRlVNdtvEKiX+Dvs5/wwj3pKp9kTQI/uY2im?=
 =?us-ascii?Q?pk6rcyVGBqlQMamWRB5jABmTYiMEA+rfPd1xnn4gsveRWivdJe1jOBuIrY/1?=
 =?us-ascii?Q?h8BqS0N39njKdENUPdVvs4/D40lBYFRFQ4NDlZ8D8Aa5YTn7K7WTx0bBM/vI?=
 =?us-ascii?Q?V5rTow6xFmyHYaIxUjdLCm+nl5Ia2y9Jzj3KNTxt7g55hYSFXVXaNlmQcRht?=
 =?us-ascii?Q?OQ6ehf1hLcDLzYS3oXkueeVYqEwvaYMo6Aq63X+XYmDfebbuX48R75dVCMvJ?=
 =?us-ascii?Q?0bHGZ2Qqaz7jxcIUO9pu8XMLaM8mA2ixOP9rU+F1nJ3JNp8TEA4EJcBE7MhD?=
 =?us-ascii?Q?6Qlo9u5SVvKQAXt2t3C+bZ381mOHq+oI4yxYITDb6U+RWEVs8mA6Q6cLiinI?=
 =?us-ascii?Q?jNZc9Ka6xptwFNM+sX9jiHxrEcI9hIzzOQG8VXioZ/VuAYsBSDYCtWueYSF1?=
 =?us-ascii?Q?2HOp6WzELn/Kc1GRQQYmn5XYIx3nw6MO86bKbBDbCYYTt4sZq1hLIihbOwmV?=
 =?us-ascii?Q?mc9fTbIlVs4NHCORA+r/jPiRFIiKHfvfm6vNAcVz36jahHqGxbgt8NAeSiXb?=
 =?us-ascii?Q?Lx4UxdVNySB6wBeihGArk7yzbWPK/WQywtvp/LauqfuMSNa8HCSQ08170KOe?=
 =?us-ascii?Q?2AHt6v5dUGBxhBhpo6QprHdUt4wkoCd/t+zXrt1Ce0EFgyjiTI7cbosLXZIW?=
 =?us-ascii?Q?9GyI2Ayb0+BJW+L4N/RjwxmsJ6XJYDXsKDG5T8eBK44WISzNbP5KbKBBhbYe?=
 =?us-ascii?Q?HxV283/Ngvifs2u7WpTiR41VdW/qR4QtEFqc1JtpEFHQ1+z2RRG9wKJvxjET?=
 =?us-ascii?Q?jbmIKHjSLEUsN+BB/7WFSzsUo80yfUgfDP9Fjv/moeKA39a4fOdLOv/W5VxW?=
 =?us-ascii?Q?loFx9hE6JfcIlZ6CZ1O4QyXyo2YabPNEhj8WJ9aF/JnJZKaevu+7Ykd93sYV?=
 =?us-ascii?Q?0tGNxcZsbOItC1XIc4aEKrkL+009j6KQC9IXY709iwMwMTqjihm3hTOMkbLF?=
 =?us-ascii?Q?hHpi4BvV03p/V96JdF9b7CmT++6AypIfNhE8YAsYU0pUbXEvWrbS/M5Amuw6?=
 =?us-ascii?Q?ZSETNbLHnOWJtlD6XvVXk8rzKpaHgDv02naCjAc031p7i5QVuZy52l9ZDNHO?=
 =?us-ascii?Q?aCfsuywkeFnRg/SocsznnxwSjyamd6WA4LsHKBFlX8+mmH04oxycOmuPkTY7?=
 =?us-ascii?Q?6DP+RZQz0RigF30+nPnHStQzE3Lx0OH4jrNlfVrDZY74OYoJC0Dpbgs+qDAY?=
 =?us-ascii?Q?ekI9gbKW+TWR8Jzm8ku5rEIB6fpT5GoArAMe0VTXE6uwS0CqEZAop7iaBWXk?=
 =?us-ascii?Q?aSLf2ctzKnKBbWCQSPBU1OkX5YV68hrIajYPsg426pQQhOnSvmPx8F1bK/um?=
 =?us-ascii?Q?gU6Wnfqe7tq3lCg7jpjulD1rxtN2+e7hxCyWrr+CwRJ9IBpHZILsXVdunZ2Q?=
 =?us-ascii?Q?Z6pvnHH/n4K9SgXlJWNc2DD1u1s49gCbsQC6OIYbrl+fudVoi2j01gTlvSgO?=
 =?us-ascii?Q?WG64IZ0iJpZOfdf9IkYm3KNviJ/q4kF53q7EnmtqpF1XHYD1Akx/O/GGkeak?=
 =?us-ascii?Q?RvBxORl6oAT7uii3/GCAMAzpG7CSmoX5myzhNeB8u3JsimPANUYbK/7vDUAZ?=
 =?us-ascii?Q?PP57xR17CoOg47tHmO83zLepksyeDYWMoL7FzHuNRWlXrFa037SyNMdJD1h9?=
 =?us-ascii?Q?w8LwY8nCSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tmxfZR2Lt59QlAeyhWdRwVo44byLQvGO9bhcMmPREjXCshg4qJ96krFS7jERqIsPutzhkgt91FlwjaWodCs4v7tn4uL/pxF1sFrNmxTXRQ4qRPtgSN1dH6fYfa5ExY28KZnMGQc5y4n+g2fFVl7Ti60b8wCXWGXLdFo7enF9i+PiAjw2szzBN1aVWrdO8jADpldbVzk7BP913NFJZZoq1+5/haKpzLZ67DGw6fHVGqMJJruLObLTRwqx8deLWmGFPhIA6WZAS6rA8LG6j94lQPgVhkPqBI+y0Zduqo5NAugkeGaCmUgWzbeR0es+cGl1F8O8MBdPLRawVLbg4Js6IA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbf7191-000e-4b40-a263-08df0489ba16
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 22:22:48.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OF0hRi8oXXb20UVz8AVYiiPH+rytktkM0CFjzQDEGH6WS3n7vjIPvDVoR1FoiRtnZ3B0rtHmVwylBPisdYvPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com

On Wed, Jul 29, 2026 at 02:21:12PM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-07-29 at 05:29 -0700, Peter Fang wrote:
> > Problem
> > =======
> > 
> > The fixed-size Quote buffer approach is not sustainable. As
> > cryptographic algorithms evolve, TD Quote sizes also grow. A previous
> > commit [2] increased the guest driver's fixed-size Quote buffer to 128
> > KB to accommodate DICE Quotes, but it may still be insufficient when
> > those Quotes use post-quantum cryptography (PQC). PQC certificate chains
> > are roughly 10x-15x larger than conventional ones, which can increase
> > Quote sizes significantly.
> 
> For the DICE host changes, the reason given for why the host side quote
> operation is TD scoped was to avoid changing the guest by increasing the report
> size. But actually, as this coverletter points out, the guest buffer sizes do
> get changed. So I think we should pause this series until we sort out the

This thread has led to a lot of great discussion, and I think perhaps we
can resume reviewing this series? The main open topics now seem to be
the guest report and potential alternatives to GetQuote, but none of
them change the fact that the quote size is growing as crypto stuff
evolves... So this series applies to all the options on the table right
now.

> inconsistencies in the reasoning. Depending, we may want to circle back with KVM
> folks on what the options actually are for the DICE quote operation.
