Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D1642A7BA;
	Wed,  5 Aug 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931630; cv=fail; b=PVfIfDm7dQjr0yyRPshRzuBsEx5od4JFhd3CH6KMYZkmZ78melYYXT7VIpNRFV7ppp38yDEuGajoA+5olrzxxm/WhR/SCZu7KGub51P8G6Xlxjbskd3RP33vJmHzQ+FAgzZxSSvmUg2I6mp1B04xRB9IFIM87WKL1sEuNi65gMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931630; c=relaxed/simple;
	bh=eTi4DDCsw6N3uHoxUr9dKNfwWd6UF1oU31zeS4v6J1Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L77ga38LgRuejqQFm4Efii5ZkpXg82src93o1pG/4ljXfyg9NaT/JwSBNbWvSifBDCqJlwQP+lW1dzB8qez0VJs7zLJt6iP+hLuZMVLQ758jbmcoEuQCZz4GKrw6mUvU9BxsnIIzljiHLHJ/mm1V1vmZTplNzcIkp3Hrb3mDyf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Obc1QOtP; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Obc1QOtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785931630; x=1817467630;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eTi4DDCsw6N3uHoxUr9dKNfwWd6UF1oU31zeS4v6J1Y=;
  b=Obc1QOtPpfDfQJkiUz1JRmofdKarCLBIeGbdAVxpOrMP3XcO2Ucnb7D4
   YdtQHa0ICp8XJlUtkcmr8GZC32/64Dsp0+ovAHCKC66U9MLNTrqmTdGyM
   b3DYMsAHGnVgg/eRV8STlOILt91G48og28+oGH8HT0XX77biX9tv18wkN
   GryljmHO5IEE3FOcur+lWDMB6kasC+tZk2De6ZbflrPxTJa5caNJCYNJu
   hLIhYW+l7GfLlgAglh5GT62hAv7x8ml4n+fG5G0KvDasTXH6+Jn4OiUCg
   FY4XEiYR9ZU9oX0DXAMi0AyCJT4BWJBV7vcGQTByJt6vfghEKUKCouRYF
   g==;
X-CSE-ConnectionGUID: 4FIJELEISxS6Y412jTU8gg==
X-CSE-MsgGUID: XPYjSGheSpqi5aVD5FfXTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86704762"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86704762"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:07:09 -0700
X-CSE-ConnectionGUID: 64FI/2njTXCcaCsFzauZeg==
X-CSE-MsgGUID: URKYFHOqS++8H//78XvAkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="262396798"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:07:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 05:07:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 05:07:08 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 05:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysmzfk3t29HwVnVBrjidKoVfeLfV/M1undF32AEiblrlRHdvR12Lr8SCwrgoiohPCweE4LLwGHfSCulad6BnwlMxjVUWWQ2axPFrtqu8mkTb6mwnrjk7CRmUFzVzp7S/CgssGPlXVhF2zEN8ag9So+Xj+Gi8Lsz2iDY+U+1qfXJLFu9DI2mjb+4AGMje6dVjCm39QMt2iMX1eCTNrx3nEdfXdBnm0qtfJYaFadIqNJriUZOmknWCvkHKFu4ZSptCMPXyCIaLxKa9+TfbyfqXLsWpqhrrie7EKa38SUC4fZt3E5Gwz8/W2ceUaVz5IpHmLSDtVW/BlX983ZaOD0UGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4U02Rd05YUvYEQ2sVlrokER0YBKKhAFBVnMguMaj2M=;
 b=prZjDVnJStydo44F3OfgDjE/eGEXWCh6cCnZ+por89OPjoMnDCXZHV7vIUREFEH+oXBsYAbAxNp2//5FLOPusSwTrWq9cmpx+Wj4v8FHIcoigq43HsmjQOSatgOPfkWuvi/Wz+zwnOOLy6V8CFRsZwDqwh/noUZVySSUGOtB4SgMVi1Nu5bxiHPLLTFIwnhmXcFh3OuCeidv/HnBo0lDIllrM/7YrfBhCta8uAZgoDxUsNxWLolBwnsQiaz09Nwsvq37doZmLqZ27XN12cqyS+B45VrM4bge1iWqIgJyBf0T7ciLGUkuiVtMotw9Cd/Itwo7BbDKfgktipiFW8e8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by SJ2PR11MB7474.namprd11.prod.outlook.com (2603:10b6:a03:4ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Wed, 5 Aug
 2026 12:07:04 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 12:07:04 +0000
Date: Wed, 5 Aug 2026 20:06:55 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 1/8] x86/virt/tdx: Stop treating tdx_global_metadata.h
 as auto-generated
Message-ID: <anMnX5Zcje0vAxNf@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
 <20260804112941.19894-2-chao.gao@intel.com>
 <43bb043e-8a01-484e-905b-41c73ae835d3@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43bb043e-8a01-484e-905b-41c73ae835d3@intel.com>
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|SJ2PR11MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: fff7a343-c183-42e8-b56d-08def2ea0ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hUeSjf1MOslxq/85NBsWrul49o3oF0AtOIZSmMK8x9aoG2woqGUljct5Fxk9Ojfy9R+4Lvn4q2Hgjerjb7fk6H0SVTYsw05vBGPbI7NEhWbpIYWfHmb5/o7pIGa5iMdidLG0NYE86+Nxccpq0UeJaMKZdcth6bFPc3v9UlhTqDEC+KaEOqHEaqwfNpPnQP2X5YSpgvEmbCp+kfqOod0K4Mhqbt8lfsuuuEh1ihz7egDZjPsN8Yaf/3PuM5WDubjF43OI5fncy4EiZP4c3FU8TIjKthe4PgfS1aTqwCpG714+jOW8bWZ0gyXBq+Rqdw3G/nzf0paPGZGvdKvw4NYP9cUjZV7OWrIzpKqFFjQMOnu+XIRjur2hbtxO0DuCwBb4t2qTfJDUmIpV7aGFEuBYboPrVh9pM7dhSTc6iUvtTwpoyOq8wC/hMWnbcogBALoYFCChqoDSXrlOBtT8MrNS8W1JODNxjQ7yJK/H3Zh7gSf9xpau4G9kfk2v/vNhDjA4i7CxlQNWnc8FPuev0JQSTxabc+57O864mRhQGtUuAflSRCrT2W7f37wJbwEoI5ic/0neVh+0DLvOmnr9JV0Ypt6VByaAKtW/sgRDhZXkhC31FROoIA7yjJRft2+WIQld+51wuMHrwkdVq8mVLIDvzfRGsWl9BgvsThYPk9y/WcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3x1/alrUbft6gjDJQwb1iY9TCc3lwvjaqnuxXzLegu+X4EkvzoEftHaqVr?=
 =?iso-8859-1?Q?/cr6NoSDR+CGPr8InZp9nMhDii7NKZ1ueoODJZ7hGFNd7TcEe7SNrArX+n?=
 =?iso-8859-1?Q?u4TiL9N6CtF6U7rMdeqeUTaB4umbZpPzjLcbc270UWZjHA3EVDugH/IFK0?=
 =?iso-8859-1?Q?5Xt1hfUbcr0aSK1OJaWg4hDi9Uhn0493OSmSzI9cvF1n4uwPrhAdmktNg/?=
 =?iso-8859-1?Q?44qtvWHLAcfA1zV0xKsdWu6U9/N+ADugw5BhBxMgjVLikX4lVKe6KOTYhL?=
 =?iso-8859-1?Q?nGbbyHgcSX9UJtz6dLhsub+D2CivjU4dZpiNcKvqrvtf5GatEhLhntZiAg?=
 =?iso-8859-1?Q?TfuxhWZgWiuVjmtd/P8zh44BK7+neXQ+yWEkCsYGx9iL+LcFwX0Wn+bBYz?=
 =?iso-8859-1?Q?jOaMdtH0jyMYIrLim7U12lXIMeB+J4zWy3+u5p/0SrY5Owsfo8hrqJVCk8?=
 =?iso-8859-1?Q?wdY/gNYrRdAR7UyckuxGovelWh1uNwFpGEwBppwLw+UEXMfZBaBORPVlm8?=
 =?iso-8859-1?Q?pbvluh79Svh7FsS/by+EGDPEFfWZFH1Vsbx8LNeMgPjwzVahDTGqzFUkUN?=
 =?iso-8859-1?Q?fsBv1XDdLRloRBo6YDR83AOR/v+m9r2hOx+Ib4tXAUxXDd8R6TMnwBESVG?=
 =?iso-8859-1?Q?lRYqGy3g++cl9F9W2Ex+EPaK6LZ91Pif/w93YAAuYnQ6z3xyZZ72pauvCY?=
 =?iso-8859-1?Q?AdIUhB8ZpjrIMYCBXGrArRjHZ4uOO5MNfZOQN9bjChkuQnYZ/Twatg+neM?=
 =?iso-8859-1?Q?SOMcMkLioQd5e43FXYS7cfdAdnZpDga6VGAWlAq7B78WyjRM0nM4UW0sDW?=
 =?iso-8859-1?Q?/hgWWC7M0Hdcd+mFmKPO7Oyc8fX/J4icGXNiiBOIh1P5g2B3a52d/+bncz?=
 =?iso-8859-1?Q?YRwBo9XbQ5c3EraOAAE3K6BpzGnAhb8r+/EDbmnFYjQni3ELLbwFz4XzEX?=
 =?iso-8859-1?Q?uUnQArVU1vSmKTZu8/Lw4wvkUMrLVV0S5ZRpDO+7dw1irZbRCQ0CFupPE3?=
 =?iso-8859-1?Q?7z4ZDif7wHIi3xYmihSJ+s0x/+uH9jb+5TXJ+3Psj9Fbtdc1wYj1me7pn3?=
 =?iso-8859-1?Q?ET0/OBlWzFZuwUHiuemtGDBI82zp7lM0nmPszPZGImK6gvYe9v9G1nsxfY?=
 =?iso-8859-1?Q?YGtyBzgyi2NbfEQ65iADQYI6T7e5gMM/kPM071pP0Wr6qEC3dGW9Avluy9?=
 =?iso-8859-1?Q?6ZBqYoVnfcXzz8Ouvtz8MwDxCZmpJ4NKPbjlcXF3cpt9D08Epi1Q0S7ji6?=
 =?iso-8859-1?Q?f1zqN2LhCdco1ilUs17gHFyJZk/tlW1DoI+EpUTZ4n5rRkeYcOLPbqmbQg?=
 =?iso-8859-1?Q?GiS5XVxFtVgZMV8vPWhayvu6Bk7wfjYuPKT7vmT3vhL1TlTsCjODv0+gfH?=
 =?iso-8859-1?Q?QuDUS63r7unDi2q4uk/l5ozjR8vgj+GDAu0Sk4dS2GddgGs/X6I4s3U3d2?=
 =?iso-8859-1?Q?Q77tWb69P/a9ys8CGjTt+Ng0vRLEFu2W3KcpJtcxHqz3XWQPIaCfOQoW3g?=
 =?iso-8859-1?Q?fPmQB0MKlEu1AOLLwjl4hyqh3xIeFZIihPZNZXLdE+OoCtFSV50mvrqfrn?=
 =?iso-8859-1?Q?MQum6uyCjQ5MVHZ5OvvF2zwKQaZuLSFlsCZ36Hm2me1S43A4o1OZQ1BBJm?=
 =?iso-8859-1?Q?sG8H3PHBW1bz6UOOwGFlxySpeavhZPYT9NjPLiVBZLm6j/vH6kHuwHNFw2?=
 =?iso-8859-1?Q?HxxSxEI+tk0YdIDpQb62VXXKmNr0VAZfxTgJueXRxNqLmISQy6FOK1BRg0?=
 =?iso-8859-1?Q?7UD8bz3jl7d/fGK71r0XLo81TTmI56NCzMUx6i/D5ipeGNCHsG/sK1if5u?=
 =?iso-8859-1?Q?UOYaqfVA/g=3D=3D?=
X-Exchange-RoutingPolicyChecked: DvpjgaKeYh5bmamPVeg/lSzSDlfKlDJkfmDKx7Sgtso/NChd5tWcZ2I+3kDUMG+CyMDJg/PKb6fjgor35ZMhSQDxQd4PankL+QHRc2ERKtvCYiBoNlLXa8qQSLPGizDHHKX3F0uF9/S0jnjuMgCV26jyepnVqpIfhIf0g5o8KMDM38CjqITGDPw5vCWAkQbLH4TCxWh7xh+uPvvHMc6R6y19XaJ6g6tr9k8KNc9JGbgA2vfMfxwadyUEvTh14xRGUiQeNbiECx6AZfyRl8vUCVlKlYnLXrTDQYgaOdSPDsVe0sgJIy5DMU1Kz5FRKP7DKaoOdNZs4/DAgWZO418xkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fff7a343-c183-42e8-b56d-08def2ea0ffc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 12:07:04.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vTq+LNWSTQ5GAJ99Q/1R+IvDpV0UsC2ra0MqEy8Rdnc0I8g1t3V6JldjMJd7br/B9eOOy9YR7kX/QhXv/vtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7474
X-OriginatorOrg: intel.com

>> Today the header that holds these structures is generated by an
>> out-of-tree script from a JSON file listing all of the TDX module's
>> metadata.  That made it trivial to add a new field, but everything
>> else suffered for it:
>> 
>>   - The header is opaque to anyone who doesn't have the script and
>>     the JSON file handy, and the "Automatically generated" tag tells
>>     reviewers their edits will be clobbered.
>>   - The script ships outside the tree, so reproducing changes
>>     requires fetching it from a mailing list link.
>>   - The structures are short and stable; the script's value over
>>     a hand-edited header is small.
>
>Well, and the big one: after we started doing this, the "ABI Definitions
>for Intel® TDX" was declared to be not an ABI. So, even if we code to
>the JSON, there's no guarantee the JSON will be stable.
>
><sigh>
>
>Honestly that's what matters. The script and all the other fluff is just
>noise.

Thanks for this. So the key point is that auto-generating rests on a
premise: the JSON is the ABI and stays stable. Then regenerating gives
you something you can trust without re-checking. That premise isn't true
now, so we should stop auto-generating.

One thing I'd like to confirm: is the concern that the JSON could be wrong
about what modules actually implement, or just that there's no commitment
to keep the JSON stable? or both?

>
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>
>So, I'm curious: What made you feel OK to sign-off on this? I'm not
>judging. I'm open-minded on this. All I know is *I* wasn't ready to
>sign-off on this.
>
>I really want to know what your thought process was.

The idea and the implementation looks good to me, and I thought they were
ready for on-list review.  As the person who modified and posted the
series, my reading of submitting-patches.rst is that I need to sign off
_any_ patches I posted.
