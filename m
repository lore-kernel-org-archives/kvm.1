Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037F3DF008;
	Tue, 29 Sep 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676562; cv=fail; b=jBcqLX6FBOhF+6hpwDksW8ig+wI7Q+rQwsqtYViKv/Y9kaOWoUHclbh0N1+MOjla1Q2lIjGivcPUY4q95fwh2gm99/kULrmeKPhTOrZQncgLqm/TpcodXwHRpC56Fzk7UnaMpXUcRs/PEY9XgBqyBbJcdnVK2PIsLuyHOidVo+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676562; c=relaxed/simple;
	bh=7F9OxtTwXEk/C8N4MoisH9GqHkUlzosnFD2Q9zdCg9A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NelCm4m2VerB5JbDUOiYl17OV88Ws5Notn6LFM0GNd9206/RE0NYGiTXfH7AfiHPUSZWy4D3Hb0l0BmTfk6PloN78gmHFOd3bIiXzOa6vbpmwm6m0QXddJ3hnU1Zfb3sFDr2lQu4FOiW5MVHc9zuJ/JSiVONoQowk9snF7J/UlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBnWQ+z/; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBnWQ+z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790676540; x=1822212540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7F9OxtTwXEk/C8N4MoisH9GqHkUlzosnFD2Q9zdCg9A=;
  b=PBnWQ+z/q3d4zUYasCuADT5ab4921jwAJzfu/oWTgEVQOGcByb5B6wO8
   sb5w5mcqG8jZhfQ7TbR2GD7m84Ppemr7VYGL34p7jmrLP8D4W4CSTK1+1
   Nq0qY5L8GSJLteBmKrp0eR8McSZwT5lQ35l43BWK/JunRpUrynKG6lHm9
   nb0gZkdyqBKebT7OaujERurCtoImdEzwZPgXKCnk31zS9hs8G0l/XWEsv
   IQaF0inphHKm/M6G082yBNxOyp3WDzTS0tsaH2Mqc0kD5rDX1KZOB64dS
   vP/9n+FVe0imSXG0U2Ciyo9xq/Cf2yEQ0an3ygyuPHLYhLxD50XjO7HYI
   w==;
X-CSE-ConnectionGUID: DHngkDMvRbiMbzeb5sVFAQ==
X-CSE-MsgGUID: h1DOsOLMQZi/CQoTyGePVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90157480"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90157480"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:08:53 -0700
X-CSE-ConnectionGUID: KjkY35CtRIGTHKU3XqI+nA==
X-CSE-MsgGUID: LEnnkVn0Qwu/I54U3r5qLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="273941988"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:08:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:08:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 03:08:52 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 03:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP/lp5nKKj9yqXpbVbfUWExVUvU6hQx8pE4v77yW0TdbxQ/fvKU+QMOExBqpqdH8alMGlweepwWh9nwmP2c+1DFmfsuyjjweEMDz5UhQPYIVk5AtapZxneezBSNX8lqMOyz0IsEkzt9+4El/vebIpprX+gT0TqRBf0TRHAEq44741q6Pt5czU7UPR3BI5KcJbfj4+r9HIHE9QvxdmlyJCYpiq2Uyi1tGSBHaDIkIqE6ch6REmylkbspDBi3cKZGh4EzTx+bg3XMvufIqXImipIuZKqo0B2tER/kbnW7lcS6byUEnZydsRKzZLG3x2t6qtl08W48FQjuVky4xAYqdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9uKerd0pwC3VE8US6XS0yCBBnwEBrbGXsGv+/fwung=;
 b=lR1SXBH4BDvTtRRZimUtzLP7pXXZmnKySnKEYGAgvR3241nwfdc8Anntxlu8+fnTv6bXIyC0jdAjHXYBmVP84vvhvh9CbjHe/N0GYGICMDIxliyR3gUAD7ZdOQKn4W34NfRe50vU+iAmwasfrFpurqtPTzzmhZAvBH98mQC+2oxfoFJXECDWEbN0NIN6iPWd9HHGfMgMSc2jO1RD2ApsELD0lQNFA/mqxx1xUV5KdvDeZKwJ9BIYK3p2r7wpkwiSDWXKG2FHrrIYyMC/+A7i+R2WVJ64WfqWu1EGTNDp1imE18MnfMuN6gyPUCvB08mAcHblo8rUv/D9KsmQcZLxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SJ0PR11MB4927.namprd11.prod.outlook.com
 (2603:10b6:a03:2d6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 10:08:49 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 10:08:49 +0000
Date: Tue, 29 Sep 2026 03:08:47 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Message-ID: <aruOL74zX3lNEJqD@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-5-peter.fang@intel.com>
 <0c6bc71f-53fb-4240-83a3-c52d090044d3@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c6bc71f-53fb-4240-83a3-c52d090044d3@intel.com>
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e93e32-4922-4e2d-1f4f-08df1e11a838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gQfGT+g4I0vsKcjGCrkvjQCVC57tj4VIAeBP+Ulqh69VdMNRAUSkHVkwbL/KMARRWZCQRe6dQHCbUghnGKJ9WQEv2krLj5p5i3A8dYA5h5eOo9NhWx1WseRYPQExc5+hSpfuzLWg4dabPD6BnMLu82dxJchK96hBuh1Qf+zTib5pWC8Mjq+97ikBAeWrymN0RBZfIki48QWZdzRFYlSLwp80Qs+6VtO1mkCvi37lDmXHXBfXD/VtKvrivwMImUv22HNJwpe9o/dS8zhyx9sp4xWxCndkGDLf/D2rnRh9eMv1PjKhfafBbte6e5VWoVfb8uIjEWhlSDaBawV8TT13EA2ELexuifgLVQGwm8epueyHAGihorDG5R2OV02aUo3Q+/Z4JQ3SrtcKp2ypgSGk2rImOmtlLUdej9b7Ha21I473zCcH+4C0IAcuczs+CpTimN/ThVy8n3x/+JJ4HBf9THHQ/N1ahgbCfMAyL+4laulayT6feJ1yZTNCv8DaYbBUfeYG1nyu/Y6yWevHFofZ8G75b8fuWDhZ7mb5ZbEgAqEpNNe8Xazwvc+VzqGimM4bNaS8T4oajgzUJLUqpffDlVWo0hKu0L1WgbwwQ8yFDWBo0vwmzlUpum7ggnVspy6FLmGp2YengRZDamS3xgZLc3OLX4sUoeHy8mwxc/6jg7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pTwq7CZjZ9UP4tUYMCgw4WOdy0fWwTn7K63npL3N7XGRs5Tef7msmp8HEkwU?=
 =?us-ascii?Q?0Aq/TnPOSA/pkxgQDi8QHPJgdQ/cQc12ep26iAlS+6J4XLXVDDXUOU4TCu7t?=
 =?us-ascii?Q?6d2PraPcoH6fjmRKcY7iP+W/2lpZnsDyMsmDeOK+cE+eqBRVeXI8BjcIOEZs?=
 =?us-ascii?Q?fY3iSlUeQz60py9mthAtkEwO/tc8FCv2B6T1zp2BynpRyFogEhJ28JLXttNO?=
 =?us-ascii?Q?ZKQyyGiQVjMhEaPEK6f+s3G/isXThYGSx2f/0fra4UprvNjTT1sGz3Ioc8dB?=
 =?us-ascii?Q?2D/ugnG7iy8EzooypJViFjl75659LZOPAhloRKZ8HoziUcEJau8uxaKqDGK4?=
 =?us-ascii?Q?81NIH1TyygTq63z6Li4sSxD/sUlEc2WnRRJYJgDYquz43W/C6Pu4USpdhoul?=
 =?us-ascii?Q?C8M2aDaorIK22wRJr8XtaIlF9LlN8U0KkaL8TwsWNYfDKE5TMv/9IfecBRso?=
 =?us-ascii?Q?RuKmdMiMEVq9yP/TvUPRB72dJYOsBb8KR7R8CBbFGSJnQIWk+HyRwQfR3guE?=
 =?us-ascii?Q?aqRoeK/9U34TaULBh8qTaMr1PYzdNN6U29CBYJcPWfFOvdUgxp6Vq0xI42J7?=
 =?us-ascii?Q?1j44KW1ahCWknIa8a3iiB3qz02J5ETWYNGf88dplWBKpbxGF4h1oa56ngSNs?=
 =?us-ascii?Q?X2ngn8wzOwkvW35hB/HQseLWiZ0RHQike8u9djqYVQS3jNIT/oT07sarq7cO?=
 =?us-ascii?Q?03EKI6DRZFu20/nzolmMxf1JbVM3jvVlV3uCQoUMFSkW4lsLg608HGxDMv8G?=
 =?us-ascii?Q?CeplE0rh1tuVn7U0+p0L3BM5+NQUiIUE9Xydgw5LjU9uMhYdVWMweOVad1QF?=
 =?us-ascii?Q?bCAFPI3sIRE2KA9tA/HHoKsOn5WJY9z4rxpBY4t/9i53dHr0HvsiJ4d15+U4?=
 =?us-ascii?Q?Tcr2ciph28iAwL5H9zf74k/elUbaJiR0lob0PFH+te0VAQb4WxUUaTI7gapM?=
 =?us-ascii?Q?Mi/LQ6AKize0L3CYsaoqhzUyszD3+10VyLVzt9LMTSZQ5jwbPsnpRHUMSfHc?=
 =?us-ascii?Q?GOlwfgbEsFClVq3vnt2rcT+Fd72SZXXBvFBKaE424sgiVXKzKzxT525ens2V?=
 =?us-ascii?Q?Gk5PceDmrRhVSnQLuFPEj7a3f1A6V5xcIDudIqWle57EWX3qu6HebL7F8JVv?=
 =?us-ascii?Q?Y1QXzm8Jc8Z96DaR4LWtufBHlVbDzbysa8LpLjgpW+vZUMFUhoWpg6WWJWI7?=
 =?us-ascii?Q?11QEw1Sh/gsHGzFqYKL0g12LZIQk5GcKTrWOnzdCjRoGDzEJUHGJZ9mOgKYM?=
 =?us-ascii?Q?lL6Zmkl8wAZqvqa5nCmgl4ktSNkqdN2iPHYPGjpO8n/bEIVDUV8TiNUCHlGe?=
 =?us-ascii?Q?YS7OVvJv3+uzYTAix95wBV1WhttrWWCA7vycAfxKCF5qwB3lsF/LeIcavi/E?=
 =?us-ascii?Q?eS9PdRcSl9xBWVGsaAVunts6hKCAKjoEy+XaPiH8XfnmRl1fAYo7sUNfysre?=
 =?us-ascii?Q?QIWo+xP7MXB2trY0fwwiFw1/+5Nm48iRAU8Rwsr9/45BI9J6z/p1+YFjPG3U?=
 =?us-ascii?Q?hvC3A41UlzNmOiT9Eo8CDSvU44PVQ5ttVgdG5ZpaU8NmClgLQD6c8Cv+Gcvp?=
 =?us-ascii?Q?OxHUl1YmbLoF9qinE7bb9liGafXL2UBmqhvw5fR6ErHBFF78Ds47vgWv1KnA?=
 =?us-ascii?Q?bKNOHkQrmVSVdIj7Sv8b17Rp359jt+Ao1h1DU5lUH4kurLXWnBF7FcyjVRnK?=
 =?us-ascii?Q?tjK2uCWsuJKpUVZF5DxhBnc8lNbZBybQ9NrM/mA6hvKx03BMBZlmFeKGbMe2?=
 =?us-ascii?Q?sR3d3bZnzg=3D=3D?=
X-Exchange-RoutingPolicyChecked: hNRLqsVvLuGq7dtOe9OerSXxF0bF28vGqlRIay9L5k4/qxvApMOyyXkUo14ryf0WJe/t5CDA7DRYd80wAnEjtVZEkzUvvShcyipuSwGLLIenWrjqSwMelIPuIisG5JhKzVjTwHragv1MOK2st3QvCm/I8iZOhgsMZP58/9rhYzOLrbxmsK87Q+9w7eVnfV+Mb15dOLLEooPe2ILA5WA71GJJeKiXksQfqg9gP1zP17HQ9frvriX8iPI0EkezmAvlsRc/nVvYPQy+srHUDrUkkpUQ2Y8yXN3ku/nAtf10V2meJUOv2PZrsPwatkR34tqRnTtEGKWX4Ar2DoMqzh9Ipg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e93e32-4922-4e2d-1f4f-08df1e11a838
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:08:49.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdrK6eoOf+HHqkYq8+Wmd8n3GplEwKCMGNH8d+ccMkDrH/QbdYESqAIhULeN3mcfmsKIyakxMUeV6BVzHH5awQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 09:13:11AM -0700, Dave Hansen wrote:
> On 9/28/26 03:08, Peter Fang wrote:
> > +static size_t get_quote_buf_size(void)
> > +{
> > +	static size_t quote_buf_size;
> > +
> > +	if (quote_buf_size)
> > +		return quote_buf_size;
> > +
> > +	quote_buf_size = PAGE_ALIGN(TDX_DEFAULT_QUOTE_SIZE);
> > +
> > +	return quote_buf_size;
> > +}
> 
> <sarcasm>
> This is gloriously unencumbered by unwieldy comments!
> </sarcasm>
> 
> Please explain the goal of this function. Why is it doing what it is
> doing? This should also explain why it is page-aligning and caching things.

Ugh sorry, this is a miss on my part. I will add comments to explain
this, especially the caching part.

> 
> Which also reminds me, it really isn't calculating the size of the quote
> "buf". It's calculating the size of the allocation required to transport
> it around, no?
> 
> Because, there are three sizes here:
> 
>  1. The actual data of the quote
>  2. The size of #1 with the metadata added in
>  3. The size of #2 with page padding
> 
> Which one of those three is "buf_size", eh?

I think what Rick said makes sense. A more limited change would be to
choose 2 and let alloc/free deal with the page alignment. None of this
is explained until patch 6. I'll add a comment for this. Thanks.
