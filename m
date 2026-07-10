Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F61DC98F;
	Fri, 10 Jul 2026 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650310; cv=fail; b=KkaJ/8lkKOBSYBOJs4ZpjF6GfK5nkLmYvN3PEYggxHEr2su1qf8kXGNGWncC4pUdxGcdsV2MJY0JPKPFOQg/8jBMvCMvNym9ZtZ+CreTMKu5c90POcE7ym/GypzEwnIr5ygvwY+gSJtYNbktj5O+Q3TtXAdUkDVfSeQD4wRDLJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650310; c=relaxed/simple;
	bh=bzD1RK6bpulwZU25cGt3W1qq97i3zg1TkL4eMlIEseY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CIRqTwVuunk3Q7ci2RhkUV68zDOE8w8/kx8yvWhsqMG7Aphq//o6ZA1e2WSLGN1rXHZggN4sf8DS7dULuGA/Hg7zx2X+36pK0bGvVzCqP6MW51Y6A+zu1gBVe2JwcMpa9mVAXkHMc/5KcW1RY54JGWRFja/T/UhUc09CkUVx+iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MomVYeux; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MomVYeux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783650308; x=1815186308;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=bzD1RK6bpulwZU25cGt3W1qq97i3zg1TkL4eMlIEseY=;
  b=MomVYeuxX6NZMpNiHnYJVQ0qIP9UwBb7P84vIDIS3vLxakeGDR9hESDZ
   JOdrBMyV9w0K06okh0Bjnl7u2iMMzGi22xujSvHmIAja7CWRpldP1JZha
   ynsISv2+kq8vT2DTe2qm1S1P2PUwtGAalNxhKEMQMFQZx1SjjQTWGjG+y
   346oHQVl8/UrG7O+AO/vvZlqx4wh2vHejejw7muyhB2xj75owuW6Snh1l
   t7rg9WKo1f8qXa1jwznXvOw5bJGdBEzvynGruZHslMZ+G5DJEmkr13isL
   HSGZGLfySlLxaqCTHaS0IhB7+xtr0VlzeKDoR2rqOywolBbTLgp+S4A1/
   A==;
X-CSE-ConnectionGUID: IEt8Ue+gTReIJVgm/2Wbxg==
X-CSE-MsgGUID: lw3SfkHASiGOtdRaHMIGqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71872112"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71872112"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:25:07 -0700
X-CSE-ConnectionGUID: J2gPc/pVTxyxXD+9cQ3p9w==
X-CSE-MsgGUID: GnYR1K4PQ5OQIDez7QyKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253020165"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:25:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 19:25:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 19:25:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 19:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZfWYrDrI81tjAKQBDgOioTp9IdxHuFr4kKmcu3nFRbnNg4Bh2Dg9yVhlBrtsg7e7SXtuQZkCSvA01USAvOwB9QEiNEgzJvVROUPWmwnPSugYebef964xS3/3molIIl8EOJMosMn0yC8xwgJt5SADg4q62D08BO4wYfYjz/B/9JX08+DMKg8BjeN2e6l+UV3jznoUmdbwcqMgbIyN3mRMGiphJjpHOyhDEXLzClHTZArV+EMo/QGh6LCUuQKQtJ7VJou3BJhzD0I+wFmRincfjfFI8SSfZFpRlbrbJPc2DQsDZxVKT6YYCMZRC2sBPO1iUPbZVaeX02Pad/mV/72+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2DNBvqsKMs02AiVuxuGXPcpv2a20Zv9Pst7Q6YAJ6E=;
 b=YRIwxmzsUiUGUGC2LvalsKJJmNSTR/xoQh9Kj5bUiGc9Z6RnXIAb3mB14FbjKU4gbSxe6aptyRRe7Yves/uXr4sfAgXb8zbD+JoKofaXneiE56vLTzs7O54AA0mxPDxh0Rs3qU94FtRYZAevaH5YliAd5vxYEl/lkCnlEBixnhNJXJUgTkssUi15r+HGA256CJ1NG/DlunNTr/nZBRSiuLXFknJ+ixFjBi/CGx2FqtgS9CpHgg5qH5icsu1fYLEbyJ2HYFOOXseS9YG0pjENWlyMBdJ8tBAF6K3MJ2/Sp0QyafkCkUJR0odP5JwyZzz5QEwei9bP0MJSqZSIOP/PQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Fri, 10 Jul
 2026 02:25:02 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 02:25:01 +0000
Date: Fri, 10 Jul 2026 10:24:55 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Message-ID: <alBX92THA2nZSVFh@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
 <ak3ySL89u5+1oCZB@yzhao56-desk.sh.intel.com>
 <9aa0694b9f0e2057808ed7c69ba6796a1d629bf7.camel@intel.com>
 <ak8MghJ4OKmsXAWE@yzhao56-desk.sh.intel.com>
 <ad840587305878d544f3c1dd44ba6947498c167b.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad840587305878d544f3c1dd44ba6947498c167b.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SJ5PPF2F7FC4EE6:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f78840-ae57-4c42-fa70-08dede2a71f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CXrTLnh9h2GrlOYYGZ9G5dBtMkJnupiiF62Na5RIZu/PAUxZVGgP3Pyi2DsQnnFv158uGVK/W9PXxKxupGf5UCDQyBWUJGxFzmiWQAu0OczsFjf6NSSrbp0lKzZnN88C2X/f6hKTEKSyKuCllbxHQH1/KqSqH1axhS3sBgi7UK1/FMiKfAL6TITZtZpNXffHTsopJMMaZbhxNeGfTtjg6BBtOkVwfITRewYlO2PWGpJSYykZv3slEtHUhhkmz/u9rHrqbp1dPOz/XfCSoKm3g6OLqL7AAbVXve3mgT2+XrQX3GoiVDTe7zrxz8j+MHPi9q0kDi+tINW4KABlBIS1SQkrVpWNmK5TM214CTMXt6iV0+mDzbkAM+BMEELX6MTREAqdONBUlMt+zz0ELMgbEfzU+jWP4T/IXXFBHoYxfyYq0nvLBNHqAh2AxJjYNSiFARbpPuSDdT+u8piz1Yp1NvPseStor/hfWJ0DofF8V3bzVq2NnBZzbCuo/+it2w9fntQcY37rg0BwSqHPH097mENOv3YjgNLX8hcik+gCJQMVZVgTeOsi3XL1+r8sCShjYWK1HcmWmkWj3A1GU3Im09hzUNvkjSV53ueFM5Y3/La0TZUnjZSGxT57jh4R7xG2QOv9PybuWz/jlkiHe5Nuz5wvMaNQFcy+5U19hYh/HN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvtYjM9tb1yfKQFyewmCAYR4c/Qf/n0hmUTFo+lq67yuRzjJtCx17Sg7BSh5?=
 =?us-ascii?Q?8Hr5PbQHnht+UAXn9DMCpkJY3qq6pDtlR9nKMNXzeHC9rAL5LQyDgynwXH8a?=
 =?us-ascii?Q?MSUJQvT7XEJSYuLkaKj8aPdhp8xcM8yPXy5aVM7tN3VS30J9vzuFRgfUzCPi?=
 =?us-ascii?Q?BDEEhmNOxOv0s01VbzPatQg3rGBeAYDU6VP5UgDbYYa6WklFGh3CXW7iEG88?=
 =?us-ascii?Q?s3dpNKsdixHxAzekFYPtKuxxiqibbKI9qYHFCTWQ01N9x3ILN6kdMGXepuJH?=
 =?us-ascii?Q?POuIjFYTBPiZxdHAUwhAkStmoSiyW+vWcS8JZkdIXOV/KRuwy2Jph3wz0NHY?=
 =?us-ascii?Q?PcLylYUEdnn7uuH/JKa9nbny8sa3gwi6TbIumMpN9y9WX7FNsTureRpNKo7O?=
 =?us-ascii?Q?y9+WDTrApbSDQwwwlpOM7CvpEkpf3HunnT1Qkl/319ASLky4l3LrPC7ip2uT?=
 =?us-ascii?Q?8nfm1sKdiE86h6MmgUvw8kZGsEFyRoOg0HABub3K5kguO8eWzrwAlBZQFCmU?=
 =?us-ascii?Q?FeO4JdqngSSlat7jqQHwud0nTpN3zsGgGnyAsGJTnfOF/38hqRnhYBJoZKg9?=
 =?us-ascii?Q?15Jm1qyXlS2ja27lQ1nFcGEuwxODJl5OHXf1gjv4a72LQsBH95owiNTCxQAp?=
 =?us-ascii?Q?Un0zjpkAy1gRKiMkFtlXldHBzFkygM11PcxEQIRbTBKI+oRNQ0RgDosnVmf0?=
 =?us-ascii?Q?dwprYzqS/YRBmR7/pAPI8FWie5FBbInOqVReOdbfp25kqfsm571cEg0nKus9?=
 =?us-ascii?Q?JB2Wm21ESDEl0G/FVKSt0e972ipGl4e5uJytIYXcpE+UN5t+Mkegqy6COxQZ?=
 =?us-ascii?Q?ObHka0mfyah/5mRxsYrlwyOHCd//5BmG8dnajwn++vWjKQrzWGyWTLM4iJOi?=
 =?us-ascii?Q?YEnAthhvGVlLdtZQvs6LvVl0bkiK3u0TpNxCIS7u6CGQP4enV69wAX5xbeDW?=
 =?us-ascii?Q?VCjRtCZIiAlu/V0QaBEVnBQsjk5E8oLCq7TXygFXs1BUXiI8VDXVC4mEbja1?=
 =?us-ascii?Q?dd0hUySjqUfN8x2xY9rTAcZhh4v62mW3KjXRP+stzwEySivmlm0uKD1A08cS?=
 =?us-ascii?Q?gq8wO4hXmjZ3MAAIbwuCQvcxueRkv01DU0YGjJfGUkLGDe2xS7ZLhxfhlsJx?=
 =?us-ascii?Q?QIQEB2LxzdJd+YxQK9/s1INvsYIAGFMOJ9VzmzQnuGsbemm+07qnMu4NKIy+?=
 =?us-ascii?Q?M6bsL2dnX7wlM6ZOAKQMiK3fkH0cjvTm0TrKJCWEb/D7crZLGWeAoonjmb5O?=
 =?us-ascii?Q?eWEzu4rWiJfVETD4Dzk3IQ4fjjJQK3kk1AxWW+2/HSid+BpyQr54rR2SAkX7?=
 =?us-ascii?Q?WQ+4tN7Gsz+ZVAaVJ3YoILEA+MQRNYwR6kkdu0j4tLAB39DIfjBz40rqibsX?=
 =?us-ascii?Q?s7g2g8g4T8INSu2s1+PeMObDA9Exu3YCUjX3vkuEErT0z+mN1knoy9rh0UME?=
 =?us-ascii?Q?OaIqwRtiLWnu87661hFVGDfsZtcFqa3nqNHln0g17TSJTlde8z60haGTxGON?=
 =?us-ascii?Q?I5hZD+JX8Fca/y1Uo3Xrnece6Enx8QC5COzqNJviRQC9d6m5S7g/Tv/Kgnq6?=
 =?us-ascii?Q?a+lIOUty5btMXuxbIWDv5TLVVBWaFIRIUK+rm2XD0f9tyu8I5CTeT2AjdUKk?=
 =?us-ascii?Q?jiwcl6wlt3ol7mcquLiJwnEdrwRlj5GRUGC/gXUoPj3kXrUYUzttwm0574YC?=
 =?us-ascii?Q?V/8Dq27kyzlQiYPRFENj4wA371UAXrogvD4f2xECLNg4N7WdGnNLJejZQRBo?=
 =?us-ascii?Q?9sHeFJsmTw=3D=3D?=
X-Exchange-RoutingPolicyChecked: fU3ltEl8uH4EJfHNPbl+oe5hca+rrsL9NEDCBBtJd8vREtSejmCamAQNS2FtYmd/M1P5oGFfDUZ5UJ7J/d+i09ldzAZ3dnrWCP55ayAPYvmLZhFAYPxdhpRd8O6TIZJZHKzr5NNN8zvfWrHYVXtMYEPRtv6lfgNyzA6TXR9879SbVb37i5d3wqF6XxGrsMBWGqjmcdzmSytbDz4fDnDHAqPIfEnilBS+gqwQu2MXKdttQRqHSquPG1Y5KwQixAnDsw8FeaSijQMSi9H6e/B3t3TE3Utb6QRWCWppJrtC2bapDKNSOorNY8Tq45UKXNL/wCAk80KkqIwCZSKaDKXrhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f78840-ae57-4c42-fa70-08dede2a71f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 02:25:01.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRWHd1fl0vziuKFhvZA5FCxtXH4+43eENGnd4Z8VUSk+/8OzSPzDyp1yM3LcAnPOlR6fgV0gkeQgdNikPFKeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F7FC4EE6
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 07:09:04AM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-07-09 at 10:50 +0800, Yan Zhao wrote:
> > > > > tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
> > > > > backing for the 2MB region covering the passed pfn. However, multiple
> > > > > callers can concurrently operate on 4KB pages that fall within the same
> > > > > 2MB region. When this happens only one Dynamic PAMT page pair needs to
> > > > > be
> > > > What "this" stands for is not clear and a comma is missing after
> > > > "happens".
> > > 
> > > Really this is not clear? The previous sentence is all about a senario being
> > > possible "multiple callers can concurrently operate on 4KB pages that fall
> > > within the same 2MB region". So I thought this would be clear.
> > Hmm, sorry for nitpicking.
> > But the previous sentence says "multiple callers can concurrently operate on
> > 4KB pages", where "operate" doesn't necessarily imply allocating pages.
> > However, the latter sentence assumes PAMT pages need to be installed. That's
> > why I think "it" is not clear.
> 
> Not sure what you mean by "it", but I guess you are saying that "this" could
Oh, yes, "this"! :D

> refer to the first sentence and not the one that immediately preceded the "this"
> reference? That part still reads ok to me, but if you still feel it's unclear
> I'll change it to.
> 
> Actually, another problem with this paragraph is focuses too much on concurrent
> callers, when the main thing this patch does is address get-ing multiple pages.
> The concurrency is added to make the refcounts work. I'd like to address that
> too. How is this to you?
This version looks great!
Thanks!
 
> x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
> 
> tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT 
> backing for the 2MB region covering the passed page. However, multiple 
> callers can add or remove 4KB pages that fall within the same 2MB region
> and in that scenario only a single PAMT entry is required.
> 
> Make the helpers handle only adding/removing Dynamic PAMT backing when 
> required, by refcounting each 2MB range. Gate the actual Dynamic PAMT add
> and remove on refcount transitions (0->1 and 1->0). Serialize the refcount
> check and SEAMCALL with a global spinlock so the read-decide-act sequence
> is atomic. This also avoids TDX module BUSY errors, as the Dynamic PAMT add
> and remove SEAMCALLs take internal TDX module locks for the 2MB ranges of
> the specified PFN and the PAMT page pair PFNs. So simultaneous attempts on
> the same 2MB ranges of the PFNs would otherwise encounter and error, which
> would not be handleable in the put case.
> 
> The lock is global and heavyweight. Use simple conditional logic to keep
> correctness obvious. This will be optimized in a later change.
> 
> The pamt_refcount[]s are atomic_t's. They do not strictly need to be
Nit: Not sure if it's correct.
Just in case it's a typo: pamt_refcounts[].

> because all access is protected by pamt_lock. The overhead of an atomic_t
> in this situation is minuscule compared to the global lock. Leave the
> atomic_t in place to enable future optimization with minimal churn.
