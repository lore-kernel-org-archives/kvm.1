Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3F3A59B1;
	Tue, 29 Sep 2026 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666658; cv=fail; b=TVSE2Iv7AqpdNtP/eerrtkwgLFb6hh+/VhE9WrkAy39FcxYKI6f+qiRMA4GY7v7xwuTnLn2ccV+KpcbR3mw6bFqhmM9BoRZMImPHoiTE0oe98ti73pbJ2OLlTRLno6hN+fNhVQjUqVioChkXmgqxK4mBWZ+fhTGG882ENPY3p38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666658; c=relaxed/simple;
	bh=A+nLqGzLJeUYl5xKgslsu1GocXM3wkY4r6o1imsjQqM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOyaBwpHzk/bx8LlG08QBnkihOq0DTeJ+EqWr/rIANE3RHAOuG/+jG5XtdzrlOBU4xFZ9xUO+E8/fGMo3Kfy7EOL0fcqIPMnMPsehMkJUAM2E1wWf7tx7b/q9OMyxUZ+FDEwzbMmoRenhaMAuki95ZchGScFcYBtxnfKbdjSFpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFT6xpz0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFT6xpz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790666656; x=1822202656;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A+nLqGzLJeUYl5xKgslsu1GocXM3wkY4r6o1imsjQqM=;
  b=KFT6xpz0LwhwPU4H3HBfWQEH6K55ex4SJ17kS3YZUR0IZyGfgC55qoSm
   XVdPLJRiTIALWz8uhaDg0/IHRqMdXM5F0PeAwL4kZ06L0fmzJDLySzqtE
   n9igqkvbbfXeWJ/MQPfP44Pz9svnHD7HobQaP6WktiycFL711H2JyeItw
   2fnJRSFoDCG6RgijlUTGihToPwXSkB9eJuTtlwbEDKFt8E/6wNsPr5O5s
   csCYm9FpbIQlP30vWyCvmEjX9rXuMdCpLz+Zaw8sha7RTWqZfZ9wFh/8i
   05AZuxJc3byBxUOjrxZID54qU9i5w4XYRMgdQbEsrdayxjUvsvDwfHndJ
   A==;
X-CSE-ConnectionGUID: DBh/63b6Ti6a6jgUpvn0lw==
X-CSE-MsgGUID: asOQ/UqpSNiycHGh8lBKbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="102750396"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="102750396"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:24:15 -0700
X-CSE-ConnectionGUID: DUcvPpKOSfSF2eAsXsglnQ==
X-CSE-MsgGUID: 2p5DqBCOTvaKOh0BHIdzeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274814695"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:24:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:24:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 00:24:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMBfvuDk6qyqcrz3KygS6msP16yrR2fQioeZc2p/gSCqHVavrFlhUIX4pK3WBeiSGcwQi9S34ADIiiZgfeo5Zeue2Nmb/LBs/IzvAppz6bjEwXaCCAH5+Y0u1pR2+iGoEC/u8v5hOEIT9O3kCK1gFCL/77u9v46K6V3xu5mK8rTpS3nIYuD9xe5OOVKuKR/HhS/bUnQ1pXDPM3+GuHA4Ns6LQ7wN35iVFgzquAh+u1KHJgivSnm1B95L6eH7cRSWUWEOZUvNrTBVHQCrgiqhvt75VnEf586vdg3bt540Ma3emyuggJqFMPpBuCT3fS40yCd/nBDP6OO6uYEY0iDzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj7+pOAgBFZXVQxGVwKGK9v6Tdh549Zs7oFTvYkkQEo=;
 b=uA2JGEqhJgBcaD9wTX5u9fBbV48bWBGNrNAICFCQY5LV/W6KagAXh5lksLRaghaGIBtfPrOz9UUgM/a3zbXnXPBMHMXGRCLJhF0m5dG4zFXd0od4o59E4KVRVt2jmfiBjm3uHRLGUqcusf1RHKgCtaHOvNc7CRO7igCxbDG0YAo9L4DJdEfsuab2ZhYpoobrpNgePv4jXSaTKNAAvwjhDYucE1LQdyDC3re153KRs74pa056gJvrKgHSC9AC1Tu4HYOD17B5d2xEDtDfgqsCCH3ZK5F5n4LSYSSd4+iJGXF4udpGuemgVzNhJoT0FBKalIyn3IXj41K4dwz1H4+eVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SA3PR11MB7556.namprd11.prod.outlook.com
 (2603:10b6:806:31f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:24:12 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 07:24:12 +0000
Date: Tue, 29 Sep 2026 00:23:52 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v5 6/6] virt: tdx-guest: Make the Quote buffer size
 dynamic
Message-ID: <artniA7jmNoK4Y2g@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-7-peter.fang@intel.com>
 <224672fa-8e29-4b0a-b472-6721e057b8a3@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <224672fa-8e29-4b0a-b472-6721e057b8a3@linux.intel.com>
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SA3PR11MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d18dea-07ec-408b-90ed-08df1dfaa8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: eGL/bR9WyBDlOH75yS9NCf8i+VfJoKtMGq1PWaNg3qwcKqgEZHxbCVdV4FSrRDcOH2ZmTIyUBnojiXcJrmWmspCvIEpPs2UmM4D63ZbfTzHkf7bzfnLoxKt9E+CYCaYxDI8FYTTAbMSWWj44PkYuk9+FI/4iVqe+sdt6yXMIAbufzEOE2ggPrw8JzXUHfH0yWNW3OYsmcc5IKiltOiv/7lQpox6OmbZJkeURJO8OyOCVpQWvT2XJTyjNobmtlkFWvcnDr9ce6D5qVRUTN2a2yjbR3fpzDxgTieC0zY9Q54HZzYlRKj6ht2CUm/GtyySOp5WIGIsWu1oPBUgKoQAE9DleMe7EGAeJNmLKcomvIpu1hZgXcSYFaryft8NMY/5gKoXMiSYLtSKJD+W9smRMZahOMN3dbTfgie17JGTTGwDsMqcvzPlFgRAh22EG0LHbElzKgW6bt0uTGWAXF4rXhgsjEElysX/U6lGhhrt1y3EJt+GIPMn1mDbUfeVlmy4CPl8Znu9ZllNXsuuewh2y3x9BCblaT/KMgVVAU3SjnGDV/+m/4OrYZojcAZ4nmvyTKFQeKDNj16bmj0HzsYBcSlaj7pIAJ2Y6Gflz16KSpXYgG+bK/VfgbhqtngqLppcfuccxIDqYF9JG8ltKESB1yR0GrCBH4kOT93YsqO6I83c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Df88VnlK+h1Oej2Ms3e2KY+Cbf8Pqz8rJYDBOLgTmYxbVzxD165aFObrexI0?=
 =?us-ascii?Q?oYQgmJBM1zvxBi3WfKxRVrCMnrxvCYPQiAu2b+YTUjXJ1asjdCkPbzfJrjsD?=
 =?us-ascii?Q?MXZAa5uHIKsv3wVIq5T7dpzNfJlPUF034bBliV3jvw6aWbdjswAAnSxcmEU7?=
 =?us-ascii?Q?tydPNv3Y8hJOzGDTKnaQ0T4nzeXFFAsOj25hW7YrS3KWVHlcsZQZdi2Iqtb5?=
 =?us-ascii?Q?Z5T7Rk7yVl9vd0YLyW4PnXd6wWSqNMDlLDgNJJ2T14dQmwepYiDWeV25Itno?=
 =?us-ascii?Q?QwoAWRpDPXPMpVRCH76kcL+l1kJjfF1H8XLnXNg9k359IRH8mXb9+/llQoqO?=
 =?us-ascii?Q?7iMDsFtjNwiWnr6L+SDpKsOAy2LAAtIvvVGwBJTBR7Yg5d7NW4loxdmzunFI?=
 =?us-ascii?Q?YyFncIB8JVWogVYuc/9F67eXmjTF2ZqovpiBpiVaFbzllwCfGfm9UwS1GF1j?=
 =?us-ascii?Q?3RP955OWTcLX9tyN0AQXQyJjgLl5QJFP2mv1f4Ys+qqF5dnuuq/BflaDI/9o?=
 =?us-ascii?Q?yXw8kcmEQPx7KCNOCFKuH3vr3S3It1v+3e2NshKiV/5iiV64/LZCWLAHWWyW?=
 =?us-ascii?Q?sqYDUhddB5GZSaEx8dE/EA2/49LzBUoRB4CPFKfeZipllKcKfpPdgscFb7wf?=
 =?us-ascii?Q?y1kWYDZ3Lig6B+D2vl4AD5+xIhYZ+tYNtt9Lj1Bevi65oxpWrE5O07HuK69K?=
 =?us-ascii?Q?DKQ/7QNkW8RQdKs0yNNy32JYsfS+CZF6zjwZswFgs5FQGKMBGsMasI3YwK8i?=
 =?us-ascii?Q?kYr+epMcm0Lyov40DbyCyOR/ngvYqEqcetPjillgZQxecjYKIx3CXsHapGdG?=
 =?us-ascii?Q?TiQJ7qgdj1Z4L3czZLn+LwI/4DSYyZihc310Dh4NVypAcBu3z0xJ7Nj8926O?=
 =?us-ascii?Q?rePJzBxr2xnhHwtu1Y15lbsZqsL7QddjeQ7UtRu6ebY9v2AYPjo2p4UmgYbl?=
 =?us-ascii?Q?qPhVoAk6I/uulTASm+aGLodz/4otzPKNMrHdxmL5I8vHQL4nQg8vesp96D4N?=
 =?us-ascii?Q?pSAu1a+tVqRoTNS7ayRvW2buwCsYM4ffddWrpEmshXftCjXK9sEVrgjeu5tu?=
 =?us-ascii?Q?Tm+CjPeAf0O5JeT/vv16QM+yLn0XtzCyidfgX0Rjz75l2Eaopqvafv0ljjcn?=
 =?us-ascii?Q?yAkMHYwKUw9fCOcHOmRircKO/Tq3ffkjTxwnrdgSIiE6UKwV3d+FN8dBcMqo?=
 =?us-ascii?Q?8r5SvPeb2J5o5BcaizrjtJU8wY/x6QqZRdXS7jqNuBI7NWabvlWQ3vhfqL+g?=
 =?us-ascii?Q?TFXlpt8Hagv655COGh7tnSlFo2Lb121IQDTFQndKJYD2mWbycj4ZxJ/Y2ZMN?=
 =?us-ascii?Q?QfRIoRCugMwLBe4yN9rRsoKZXVL8T52LGn2flgKwsQdgFrf31Mw9WjevD2ng?=
 =?us-ascii?Q?Cm4KOt3oQdPIom8p8dtXc2oOQN4QAGrYwhabNd2Nn2yIQmq6IzjJbOJuNzBU?=
 =?us-ascii?Q?lXVcKJ9PWBl2TIYjmwVnpWrbO3Wv3vhcj06ksymkxHIQyOqo9ji2fE6NScsx?=
 =?us-ascii?Q?qa6t8GYWPG1Z1lAEkhOLE9hGc8yC6WWSLI6pxrIKRdSltB9xTusT72z573jF?=
 =?us-ascii?Q?0Qh6pQULZe1QERsRxKnHA33Prw0WGQn5Pq4YqVsm4RE9c1R7kGsQoOO4gdMx?=
 =?us-ascii?Q?aqWPZL6EUFMkHxQrf6f34HlGitUDKL6ljk8mteF3lbv88+M9OM1LICTIMkh0?=
 =?us-ascii?Q?J+22L5+gFtQx8Rqccha289LOsVW5I0qBc4mu4UVq4Y3QzfqInqh9TAWG57RW?=
 =?us-ascii?Q?TXFgCRSuEw=3D=3D?=
X-Exchange-RoutingPolicyChecked: biXCuejR+LdFTQn15spyyMqqO+tOGenuHje6Z4faTIsaUNZMKwaKvbxFMdt5mgnyjllE116cHFbAA7YhvP511Xep7wZlXnhHQ4XXr64ENCvmxtcHAEPYomdeSZfflZd458gotxtiXnTFlJiIXuPyZBcHd6ZodusgfCWp31Q/S7kp1MtHQDWlLNqWA4Td/FkUhLA61g5BPsMJGER+XQ3M192OGhlIu9QITS72LI7h0qJjBSkBmwIrjzuaePf/5Wd971j2BZbMhYjjE2lKQlyOjFZofzvBmvk81RB1MDM9XLDBOMoi/xAHipZ6NUBK9r4CHfrVjS7dAYRiqzZDniACuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d18dea-07ec-408b-90ed-08df1dfaa8a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:24:11.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKX5jsWZPBawBqEBb3S6VCDgC9Yb23rwROcSgmLiNva66e2hjL18NJ3+5RCwkitCnfr0eZKL9txxaHQHdcCbOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 01:37:11PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 323e1efc78ea..847430fc639f 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -213,6 +213,7 @@ int tdx_get_max_quote_size(u64 *max_quote_size)
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_FOR_MODULES(tdx_get_max_quote_size, "tdx-guest");
> 
> I think you can cleanup other exports consumed by tdx-guest driver
> to use the same format (in a prep patch).
> 
> tdx_hcall_get_quote(), tdx_mcall_get_report0() and tdx_mcall_extend_rtmr(0.

There's another patch on the list doing exactly that [1] (and queued),
so I mentioned in the cover letter that perhaps these changes will
eventually fit together.

[1] https://lore.kernel.org/all/20260925131808.2415177-1-nik.borisov@suse.com/

> 
