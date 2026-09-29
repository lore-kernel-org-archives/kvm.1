Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F352E046;
	Tue, 29 Sep 2026 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699921; cv=fail; b=TJbGBWPTQ1F4Z2M7+ZYKXN03gGQ8vTlR2hXoaSz9+01EEIaqUeCdtugC8iN0UL0YaX+ORhP+NL9KHB3CNgS/dcCUkfFV21uLj/PIk/14+wSaG7VTrHAKKcN5chLCad1zXUllug/NBQIHkqwa/KpSrF3hJ+Htq9ZvtXmjphIkem0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699921; c=relaxed/simple;
	bh=LqwBT9Pmjk7ZgPVe16TvnyhCvukJv1n7B4Iw7twJ9cI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JycrVtjJGNf9SEgxntFAp2RHjgBq2WG8NfcbZExMIRFAx/225LCYN0tQyznMA3tOIilpQYKQJ03l42zRx1cCxeYwhCByGOWQiofC82WDOgKnq4RFgEIX2bBzfLnah8iiSpKgsD/DMZzeN5/vCFS2gpXrr0hvWfjIka7D/vpw6zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbcHHRSt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbcHHRSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790699920; x=1822235920;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LqwBT9Pmjk7ZgPVe16TvnyhCvukJv1n7B4Iw7twJ9cI=;
  b=cbcHHRSt8eifcMOC722Ko8jVRek5lJVqr3XRPnhct3qb7eMmi5QyisSa
   B7acmW5tL0vqNXPrNr+0dTKg3VMulWUovW2Yb3eQkdRSVKcQo2cJxe7rn
   oqfLgi6oopmS2b7s8Z/w6BxF6Piji0gAyzPBm/ckReOixYVuvImoV17q4
   7Ko2ZLnWHxp6Ewd1IJ/yQg32FWbh9BAsxhkUUQbgqE+X3/7CAaN2VZunD
   2/YbGZdP7zSK+MTJ6tLhTzYuov6VYAEcT1TGfex3BHGVU7igAAGGdXg11
   kWaJt3emq6WZT73MbGXNXYpKuE8KdMorO4RnYVJNoESKH/gFk1r+lQa4i
   A==;
X-CSE-ConnectionGUID: Gx7r1GApTFmJ85CXZtVO+g==
X-CSE-MsgGUID: m9SkGnfPQpWPRciJs6MkAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="94137971"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="94137971"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:38:39 -0700
X-CSE-ConnectionGUID: wiloYKQMTIiFrfzEqpfx3g==
X-CSE-MsgGUID: V33BXvWcS0+c5RYQHPSq6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313359582"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:38:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:38:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 09:38:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUc+1L4qOSVikrlj6SmM1ux0umO2i4yeVfCIoTbgR0eGqCN4esQ9xZpjv+jXgpqJDuuW1IDWtnzCU2sPwIMhwUv85zYD4jNSppn4o/dcSb5bGVsQPz2a5O+GH2pJoiLgoy+Lo9No7mqIY96KZ/X9k6NtL1BDGBuf93KTITxb90P7MshNjFRVVFcxVoFdEti00lbkP0tWUjz2bM9fQvyGqM9/5nuwwzQbMaMXmnX5rdJ7lAi5tf53yIj9c3XC8p58J4xa61OVIFl0PiAdu/Xoqs7FiVOPQSAHarxrxoQfdTIY/ti7/e/c2sGpaTwBbvJQ3lVVB7FfJo/S/QCcPFr+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBrdKhGAy0L4YJ3zjEjAHd6THPvuxc0/mURHxv6t87U=;
 b=FjqYXaibXGotCs4rPGuONUSLp39h22dVD3gQ4UWVcyppc95k8NHqG+ZzvZl3y/MffisckZCxpge3iF1/jgXfzWw9D6JvkbitlMCms67+Wavtkb1HWZp26Lx/xWKGLgDbGIU9GaJwYAt+NtKV2UoEhJuQhZY2LBYKGfnu1WQIq1nZU/A8VfSir/RM2+O05+gabFGbOIA4+2A2wG8vW6hfNZ9BUT4IofVkXZ528WDvsgomSauOf01pszkj8rk7iqYz26n3TEZKnJmq+c3YIo08kv1+vq6j4eEjvhmjCjmsG0rAe1BUM802eSLQwYox1/daYp8qHAJJ6q4JdAWhMHFioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SJ0PR11MB5770.namprd11.prod.outlook.com
 (2603:10b6:a03:421::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 16:38:36 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 16:38:36 +0000
Date: Tue, 29 Sep 2026 09:38:33 -0700
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
Subject: Re: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Message-ID: <arvpiaIvGWhWNv4E@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-5-peter.fang@intel.com>
 <27febde6bbd1142222f0a21db4e5180e0bd3261c.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27febde6bbd1142222f0a21db4e5180e0bd3261c.camel@intel.com>
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SJ0PR11MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: c48c991a-c32e-4cb5-d594-08df1e481bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: XOj41wCZctdNwGD38iXX5fUQDXitWLZDI2c67NwHTUtQ4o98YW5edjkHDVX8PykSmHvIGr+GGit5/gHH002yufuZMAKTf5c0EeJdrgZXIPV+CknKR97enoTE4juy4Sz8Z8K7Bhv9xfT5hRRjvcjjb/rEV3AkPZ+FOh+Yvr+NRRHVaJxsHsdG3WZv0GyzcKaebhYvWk5BcjjZPsaZ7Hf77mZihFyBg4oMG1LMqpehntE+FUrF03PhzFoNkFBrC6JIroz1C97qDi0B/RTqdVmlhOPYIqbp162V84Z0fcyCYlt3x26RDttv6VDHZSZWi9xqO/JSsTQYwBjY7HpAD0jshWQUaqERp1fE/PihmyIy9lXpCHfrKyMebMnhxIQFzR5Xa+NwLmJVdCMDgsXbwyCILYAfXj4YvbWfdjlgXDpeuaPgA+9OOz2J/Ftml4e2vNNMZgp4mEKkZ//lIWc0feCaVRKyKiLKHfTO7sXwKFl9PyEc1lc+9iKXui/+PAe6W0XmDoyBqrMGlqp0qOeknYFly0ebYE2ExcKVEG1CZj/z35hRoKOROX3S0kuHhPYam6QlgAxTkYoGrd4AL3Ebc7XL90IkzoTnyxDiAlyjdlluml1mNFJWt1u6yzqPxfEvEYWOKAj0y0kvtb2LKMZyZTZO7tYJ05nh1/B8ktXKP8Fecmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/RJj5KsBIhTlsHsPyVdynVgCtvQIiVJLefw5Qv1sD3JCRDrQXHBIvMDMet/S?=
 =?us-ascii?Q?6edCNO/Brny6FSgn8XCIsh6ncRn5b5hzTqQYqolmp9XAjjB4Zc+pHStiMr2D?=
 =?us-ascii?Q?UJaCmoE10shhwNiRryWR5vIwSI6UBBJMiJ8Zy6EuzGIz48KLUwhFW4lmCZyP?=
 =?us-ascii?Q?KD/xRdp962J+j/QwzWl33hrfMz1i9iw45CbuHhQlvmCaBCiBRqBc4wHqzUpj?=
 =?us-ascii?Q?9f/hKvmRz8HKISZffXyaNRxgjqjDCX6JdjpzWYE1zuUspzSIaZg/gkvKqV4x?=
 =?us-ascii?Q?WJIY715sZJv8yUiuKefnaKUwf8jMuqiRVvhV7LGJbzsy5Cp+mYYfQPx6kVz+?=
 =?us-ascii?Q?7GnFuEViGd00DSVTVidK3iIJkySsypHquCjOAA0FgKSmHzzOR6NQm90dyowC?=
 =?us-ascii?Q?gxnyxGKeFWcV7xACT653a2+Ty9WxoZWC6NmZXab+jnjjYk8X9tedn4tpJcy5?=
 =?us-ascii?Q?v6vPC1Lm8BvZM0KClu5GxJFHYJwNagFu5D7k6fZ5c+1B7E76tTfrI4diswSq?=
 =?us-ascii?Q?Q3gVp4llrrREoGpQfQmwjpQFfl+uzEbGcpYFU5XvZXN67YTMssT4iZKhA4mi?=
 =?us-ascii?Q?Im1qJrSEv/om1Z5gOmkd0nMgK3yygMVIBmWcCAszRF2ZiDUhRLVCFuuQdLTB?=
 =?us-ascii?Q?QUzA91brXP252LHi0KHZE96rHVhUJhL0+U9AOR0kGxb5hSRKMiu/sc0Bh8Ry?=
 =?us-ascii?Q?/bse3PuOHluW0KfelDkUx6hNYAOl4LP1GlLUuAIZoIzZXwaZfm5YS+veTN52?=
 =?us-ascii?Q?SLrzXDgtMBbI6K+bnJ6olVhC29rswfSlcp7CMiTADkh0T1d79zU2tyHH0gU6?=
 =?us-ascii?Q?9DtRhhexxqNyI/R4ZJ+BpZVn1bzifCEe1duRuMJUYEcWw+oJP8c63l5/TLfG?=
 =?us-ascii?Q?MoCFnD2kRtFaKFlePZUaOZ9sN6LgcNYJC6WqGZwB6axFohR4SpMsbNQHwo4T?=
 =?us-ascii?Q?yMLDymboNiOaXFubM0Uy3nEfDhKC4KwUBnWc9wNy0/o3Ln6QZ26nAAubz+mw?=
 =?us-ascii?Q?E4SZvmaHfGAjNLnEjTmUMeqLxQfYEFLx9ZrlOrXWrgrGTTy3cNDtjNR1Xv3b?=
 =?us-ascii?Q?Npyjqsje4/K38IbbPr3826NdTINGqS/kYfRzgCJNcRkn3sDUEUZSU81Isl1+?=
 =?us-ascii?Q?9BQv1Z5sQRB0oSkBKlClHF1OPEAO1QF1y5J50f7yGFQ3HJyuH/iMv6LUoW8Y?=
 =?us-ascii?Q?0ZHc3WA1OS82BY3n3C7czQtZw7Ly7BfeF/aWMp8wqxgoWdX7R7+x/TajstmA?=
 =?us-ascii?Q?Yfwq3hvdwJTvoShrjJeiObJDHt3neVySn6znCSHUhHC0/KweKZB+Zpf4LFkl?=
 =?us-ascii?Q?Xdb1UK1uYq3pLYxFunrYCcn/N4+/NqV8cyrRpxdx7daf7yDor5aHtrF+1qLK?=
 =?us-ascii?Q?FK6p0l43ObvizWT5Yo/Evv7+lu/L0TDGIBn12K7Cpj3LM8vNLxbTrn1WZb7p?=
 =?us-ascii?Q?xy9bj71YVyfLGrAQPwddB2pfeXHvTQOuNfOy6kef7mHWLGUZuA4V/cDQpow0?=
 =?us-ascii?Q?+43fs8ZOpM9DL/tEM8Kd7dbBYOdjZWJzmq7vLjjG7QzT+9whTITyCDsU+Sb1?=
 =?us-ascii?Q?w+z0mDYjH1DM9sbCYKm/ml8UrDon/c5ocpU93ANt+fXjv4F6ULd18uf4qj8c?=
 =?us-ascii?Q?W4pAwNt/3440YjogxIL4Rfjr28Jf7Q2vnfdI/nj3WxjTzoYx4YbwMUljIl30?=
 =?us-ascii?Q?b+y2brJ0mD8cX1eUjSToQgYCOcXeklay9+YdIe1DhkmKqV2vcLwAXJsHVab8?=
 =?us-ascii?Q?PCQ0BWjQug=3D=3D?=
X-Exchange-RoutingPolicyChecked: 5wzCLJAt3bG4FfrkAVCHjhIbXzLHMa9w+xlFa2mtDkTuvNsR/TiHuQJDMTVWpj8MbfVUF9wJ63uuYSxp3fp6/nPsB00yCST+uIGcMYfPXgZMcWpRkKtoo5JpS8YI//owVI4hO/phEQfnqULl7UZd9ame8eAwFkXdElXr9GZauLlXe8aDuxB4ZUkSvDOYRfZn+ZdxZ95Dfiv5egLMMeUQyudnCBLB+MDvy5C+XJ8jG5yqpyAAdcGxV4lRygtYUThs75q7X3bLTHC1drXhzB5vvTg1O+c3EKmO4FuMFVGwTBKsk4klxho1CxP3KDtgnGt/+d76SKrJkvAXM0/x/osxTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c48c991a-c32e-4cb5-d594-08df1e481bb3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:38:36.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCut+TXM5IPx3wY1gPWyuFwRuWqsFyn1qOaayKYqvDVaa7KUsmsFuwtKea9kkrPw7ta7WXyBOkSW/hMrbBJWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 11:23:42AM -0700, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 03:08 -0700, Peter Fang wrote:
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
> > +
> 
> This makes no sense, at the point of this patch. It lazily sets a global to a
> constant value. Function scoped static is also weird.
> 
> I think you are doing it this way so that later you can plug in the dynamic
> read. But later it still doesn't make sense why to lazily fetch it. Why not just
> read it in the tdx_guest_init() to a global? If the read fails, set to
> TDX_DEFAULT_QUOTE_SIZE. Then you are done. All callers of tdx_guest_init() just
> refer to the global. Why not?

After some offline discussion with Dave and Rick, the conclusion was
that KISS is better. Just read this metadata field each time and assume
the TDX module won't change it (because it shouldn't). That also gets
rid of the static variable.
