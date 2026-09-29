Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0D3AE19D;
	Tue, 29 Sep 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673519; cv=fail; b=UCzALxTmhYVH4TGwdHeohS5Fd8GJ5Inu2i355vQSMwbSerzEgXNX94Z8X/m+E3DEz0DRpbhWGHHoRZAh9zdEYV/lL9eJz2Pz7vBJpRWYC+bKoGgtyxjMwlelkkxIGfYYIExNv8nnaMR0uwWN7lL1KrmqNj5vlYW9f6O+6GhFAOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673519; c=relaxed/simple;
	bh=ipD+pvH1T9ilDZpKvSzBg4xMLSNiY/Bdrcflp5/qIgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=crlHItMUKh1uGS73F5CinqAA67UmOjVGErR6gfzXNPO6C94PkObBHoByFtDx9hyRb6+xkqSJnxIf6qHbwKU7LU1ZwHlm5ihCYWKDrhsHRQnXCkgaZ1E6dBMUe8TAEXaWASGL8Mmp2FFFuoIzcJ1rnI/ga5+jXMOHn1fWoOHRhpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFqAafwO; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFqAafwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790673504; x=1822209504;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ipD+pvH1T9ilDZpKvSzBg4xMLSNiY/Bdrcflp5/qIgk=;
  b=SFqAafwOqlflGZhFo/vSjXUd0UBCSPS+Nf2/NUpn/xEj24BwsU/9zzn4
   oCXcHo2hIGIwd/zPIQvAW46nvxlN+mjXInX5rG14kmlBT7BJ2GcgaRBAJ
   ZD67oFNE0fj4zDwWMjOfTNoOvWcQs8WnU9KeRIph7Hee3MOTNftyjNSEk
   mlsR1Iz2SZ1hUE5jZXY5dyxOO3nwWFKC8xKoZK5oJV8Hn9n4RQQd1aPNP
   tTvHiIpvmy9veR1e1eGS+pVEiwPeDW56h8ZuNBxsOEECy6meDSdyAevr/
   hkT0gi+3en5GLhM4HVfBX4+LT7gr+NGiRUJBBy7Sz0X/Pv3ZuWCqEvAnB
   Q==;
X-CSE-ConnectionGUID: yJqHIjkMTzG86trzhYCpHw==
X-CSE-MsgGUID: PZ2+y2psQsGWMYnkjgEHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="102048972"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="102048972"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:18:18 -0700
X-CSE-ConnectionGUID: BdNMsZYQQNGfu3Mq2H27UQ==
X-CSE-MsgGUID: QbBXhMEiQuaxaeDpANaYxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274850728"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:18:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 02:18:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 02:18:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 02:18:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2uIZvs7O8kmFH0/XMswHN1VeKBhOTkqjPebNLHtCqlzgpBAYSax+IfqVE5DpGpmSDLPPWPKB2f6ftmwQS/ko9JRkjByRQqIMxdF8g9pXoTyA87Eb8oNLLzY+vDeOZhprqRVoYc4/T4Y+BodWW36pUU3xZQ6fTbdzaTIO6VZcbO2rHKAGsNabieo/HVPhsbT+yLkO9eR8L8V0mhbHhazHekwEOWLOTQy7oXy4yrlko7y8cu/FqxtrVnAwnynbeZhbvtH32xQ6xzffIhyz2lZ2rPxVphSNSkE0uFHuPZHNK/kdOaaOFnq5sOtX2Ql8rpKONzLSVDG9RKRAEZDVa4k3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNnSEzlpE7Y0vloa4sydeCVYyhiK1qxrxnsxAOlhwuI=;
 b=eUoEYW+d0Ox87eIs+WwI+ISfOcAYuFO5XLNQYiJH+CLpOBKyINAs6A1sYuOSECAkJrTZ4BjI2arAgK8ksfczIgiMAXbXqZsQG/FpxvG5fkt8E2okGbClq7A1fB6nenltIDaGMbqbGGwQ+pf3FiUlmoDez9mEbT+gTPkFD7PDD4nGG6uFniFDA1sUZXLawfMZHQ8iOon9v1V08nhSYk9lFoZYYwulqb3vs/8mxz8v3U2SywkRCjZaBUhQmzc9iwGwGu5EJpquwxmCZlUE60bLDT4wDM8BUlUcQHUHf4BLqxcMy9aYrrjvSwGuvOprtoH6KnrascaekyjQa822gdSzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS4PPFCAADA7A6C.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::4d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 09:18:10 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 09:18:10 +0000
Date: Tue, 29 Sep 2026 02:18:08 -0700
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
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Message-ID: <aruCUJObHUV-xt6q@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-6-peter.fang@intel.com>
 <61a63fcb-c40c-4259-b314-9ec63b0bc847@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61a63fcb-c40c-4259-b314-9ec63b0bc847@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS4PPFCAADA7A6C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1442225c-a48d-41c9-6d9e-08df1e0a94c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|10067099003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: MliZ3X+Emw1upUAXhi7cgUORrcg2K892qaUZ+JDfzSDCKAgbJKdJkAggc4CGpKkPsC2AJHcW8VPEdIW29JESLT8HhYpQDO1upgdJ36P7sjtY2teXKlxx38evdbdBfyhDT0FlQLMI8Lyae6/zN7ES9s1SVdMhMfOBXR7QkKMO5pe96yk7oDobg44hPp+HtEbfu5eP48QHVTxbqdjicY5mmKFroRn++BdPlNnDIEknHQAdi9yxUs4N+ub6TKhIyF8SbD01eYf0h1IKyHPxK/4ooFwwV1az6qCTPfpJc8JBoKMitofUV4s058rFwg1hPmixYckAygMwZk1vvIzv7hQqfOFfwrQ6YIcat1qbKnmiandijQlqpFaEdkJ7VEJ7vyRyutD6pdNTo8bvKuHc7FmdQc6FydfqwezRyqLLahNrgJsXScuangkxZ2uZlTzXnjhZUvPKoJKfmMl8eAOFbClHOMNhvog0Sd+FrA69o5MT8jZ3E42qQrfxEUEQumancfac5giRJZpqsnA/cG55rgl+mHCKxHJj+G5xUgw+rec3UGcSFUmzw1K9UbKajL3lc4SnBQ4Ar4m0YgZ7esboOlv2rfxWTrEqEHtTGYK3T5kn/S2WeGXoRlGOxEWOjpdjpwtm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IcjUjHnWHcENOuRBcHJlVyMX1TGQrtVDGDhw6wjvF1DFZYdMm3oQAZ2YVjmf?=
 =?us-ascii?Q?ew8+2hZDljH5BF0eX4ccdwVs7OxjJqL+HKABjd5dBwIKOvwlGLMTflZgByJT?=
 =?us-ascii?Q?BpNDBmHOXOWqFpYbEBWHz1Jaj7pY3z5W03To64I3pNBLWOY0y5Llm/3lJx95?=
 =?us-ascii?Q?Viezc+a3X/CX7HConOP7hMhk/JK0o+bpDfQwOq36UTfNJ80kiztXQmlHgc0A?=
 =?us-ascii?Q?v/gEXMYl7djF9U1vKaySQwJQkFG+8Er2+gC6gFUcar4Eb1hejR9xdQ27eJkI?=
 =?us-ascii?Q?5ndnJW5Wy3wcMg51/eCUhwiJXFH0TE+LFLUee/njBiAjPgZgu2h9GN0tNx2j?=
 =?us-ascii?Q?SOo8/51VYfdxJ4WATqalC7jaDz/nTTQrS+46HKpPotWRPhs8mgoJ0/pRDX1n?=
 =?us-ascii?Q?MVF1kr3/MEpVBMqhHyzkNqeQ7HJM0GCLq1WKh76Wk2e7ttSA73zb8GBYsF0M?=
 =?us-ascii?Q?kxNWl/9LVh1BM5WNcvm8dB4LJ0QdzWxSq02Zeb15PSiSwGznu0JXY4D7s1Fc?=
 =?us-ascii?Q?UIcN7ntgfzX92/4HnikFHGlx37QtUOIeVxKJaS1AdrT83Kw39TWmUGPYaiZ0?=
 =?us-ascii?Q?T8eniEBRZ2zrxYll+jknumezwYqJbM0tqgEZhMp0lCf8M9ZVmZhIkPYyDja1?=
 =?us-ascii?Q?4xTFyn+UTKwvzNU6UYVIxYeGCB1UrkId6hn6Mr7TQqAsYllsQLxkHX05SyW/?=
 =?us-ascii?Q?CRQUvCeFYiH1amRdd5f7Kbtf6rT3Uuf3jRUHU34SKyuDa3RkmiGAWgk/WSfj?=
 =?us-ascii?Q?k03NALtU14Qwsx6HVPkZVF+UvGIs7xhEZcy4pq9x/a4UT14h3dkcG1g33JER?=
 =?us-ascii?Q?0vge6zeQF+t/X4/EBuoGyqYxNFqM+xfT5UlNHBFSuDBJJglnTsnEaxCADJpm?=
 =?us-ascii?Q?6+bVK4cchN4DcbCPnbBJU9W9LM52u6sOAZBAPsdEsQRsz98dJjsSSZcYvsJQ?=
 =?us-ascii?Q?d6uk5NZ02IsaTwRIXAeXLFlr64wHcNofqNLsGgjHS1l07doyRHcUoi5P2DYu?=
 =?us-ascii?Q?WXy+HRVSb7wcBEpeWZY10L7jul6cZSjgdIA3MTIQNnaVLGEZC1Xsw73y2GqK?=
 =?us-ascii?Q?HvhKLjuyvSC66j8P/lkchL4ZFZ2ePu7RT5GG9Whtp9UCjttnPtqzqfIydxGO?=
 =?us-ascii?Q?E800DFcrmTC+nCDQ5kJU/y3oZO7pmpJBhDZXiRjB4sezjsaFTj3w3/wqYZoS?=
 =?us-ascii?Q?2GDamv8/QQR3s0LAl+rqXO4v80SAZRkMteXn7ZupwGyA+dka4phXknSp/Crn?=
 =?us-ascii?Q?kfvk74l6WaXyJZaYmq/bqesvdhy/sOrkJUes1I015kauM9mSlBZLVD48z52R?=
 =?us-ascii?Q?xMa36NH2uRRtwfM2aYXjm898BdZ/j/iW89qLlLZ5C1hQedoMC0WKqzph48MS?=
 =?us-ascii?Q?23O4FcooBUWcNihSc287UeDDcXfFVwsqxz/pKqlzTrid+Q2Cs1yjNPBRlflw?=
 =?us-ascii?Q?BYYhT1YKPxZFKQdH85DrwIi7ChJvrsOaXQGDfBZYhSgk71h5rubjfMHqySi4?=
 =?us-ascii?Q?lbdxmWRNDn+w/y0a37MzgQdgCwpwS3Gt288CVugY0RP7uAXc24NsgdWBcsA9?=
 =?us-ascii?Q?Tzs7B8CwN/w2x7hF+qRLXCHPS6Z7eNg6eNsNz92YWZ9I00n30XRUeDKS0NDK?=
 =?us-ascii?Q?BFShC2FTyJxZz9+Cgi2sVSV1lwHtSxevydGNjJpdqDEVybH5+IMPJOL2b3ou?=
 =?us-ascii?Q?lLzU/TwV0LIULH/cjql0Z3ePkRFMWEJAECIhFzrZ9+N+faj6lkV4/M8iq8dk?=
 =?us-ascii?Q?qEvxS+Wfvw=3D=3D?=
X-Exchange-RoutingPolicyChecked: t7Lh2YnsCZg2SKGkK7lAR18xKwYwufm0QUl79PLItjl8JdsmB+LIt4b8qyQsKChkXZLNbrxm/aP/sPyG1BStrxUjSfogXMl/ONu2yqR98w1JbbTWH3kQHaLaDf3c2Nt5HkNEypfPuL1XIS9SoAQ9UHGKhQI/3rWh+xWkwJWRb2UAwEF/ryve/qDcrft0+NNlNrwbI8TUjU1prwh2Dygan/uoDFDrAm0WfXEu6CgYMiaM0r2LPpxssV+zb1skM5Wymy/Mz6kgkYnECugU6T0qrraSNxi2WyQaRuimd0uyvjQdVLND6glUeNLsgNzn6CGE6JLqWri5F2JDz9oS/gF6aw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1442225c-a48d-41c9-6d9e-08df1e0a94c9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:18:10.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULwBR1rP24LP6/hwpyuYqEVfHeRtP8/6rS8XA7AR56xXVpd9DE5MVIUmI8p66I+XfUFkNA3N8IyG4onXekwy2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCAADA7A6C
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 01:32:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 9/28/2026 3:08 AM, Peter Fang wrote:
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
> If the patch is suggested by Xu Uilun you can use Suggested-by:

I think tip's preference is to use some prose rather than a tag for
these things [1]. So I'll probably keep the prose unless you have
objections?

[1] https://lore.kernel.org/all/c1c9bddf-1c00-4625-a915-d545acd67fd0@intel.com/

> 
> >  
> > +/*
> > + * Ask the TDX module what the largest possible Quote might be.
> > + */
> > +int tdx_get_max_quote_size(u64 *max_quote_size)
> > +{
> > +	u64 err;
> > +
> > +	err = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, max_quote_size);
> > +
> > +	/* Old modules do not support this. Tell the caller. */
> > +	if (err)
> > +		return -EINVAL;
> 
> I think -ENODEV or -EOPNOTSUPP is more appropriate return value
> for unsupported case.

Hmm, I don't see either one being a common pattern for guest-side TDX
code. -ENODEV is usually used for some basic operation failure.
-EOPNOTSUPP is not used in the guest. But between the two I think
-EOPNOTSUPP probably fits better. Thanks.

> 
> Also tdg_vm_rd() updates max_quote_size on error case as well.
> 
> You can reset it or use local variable to skip passing incorrect
> value on error case.

That's true, but this won't be a widely used function, and the caller
should check the return value first. So I'd think keeping it simpler
would be better?

BTW on error, max_quote_size will be set to 0. So it's also
deterministic behavior.

> 
