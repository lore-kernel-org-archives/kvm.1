Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42413373BE6;
	Wed,  8 Jul 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502737; cv=fail; b=U6nStqAZ6jKkWfrBztOoU8BgesZgfbOjZ01V1e1Kehzil0v7nOzvWd4bMvvtw7LzlAsTjpKTci1JvjYZGGpXO1WLYuEAuh0Wp9xjy/gVEDAdw2UXpOEn1GFFGstvq/l4fa7D4l5G1ggPwRXRVycjHEP7YW3WFTGRlPLkNfRAzSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502737; c=relaxed/simple;
	bh=ahtDkrB32uZe13+Pf2RA8Iv2w4Mqp3Xa2we6vgFJh4E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UKJONOw1Vnq6TMEUz0IrJRuAaTQwozy24y2KEC9MVTd6IEsSjHFQE+EhpdSUCfo2DLlYMFIyF3xY3KgRcMLkTSGnwNcyATjF7UFBAKFZiT6mVrotVR4N121QYf4xcsHkLcLQbgA4XPb1phrE+a9Jv/795hGmIhB0YbcQggVTkCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgzuCL8o; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgzuCL8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783502735; x=1815038735;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ahtDkrB32uZe13+Pf2RA8Iv2w4Mqp3Xa2we6vgFJh4E=;
  b=jgzuCL8omJ8s3+F75mQcgIztKgyzf8J4uaH3tLiFaoEQ285erMeAr4rl
   L/MEIJ0TyCDCCizL3AdsAnw4iNReAMdxap99Ud76Ic61S7vx5nJe/gmMJ
   gXaq3rf2uXlIg7YbKpPuMIUqRc6evkqKjORyKsbDIKDcaqKBiY5d9wTXN
   gblzjFb357KcQqtysSyuzb6vAHStfACMNwgbjgQy1zrIy1RO+YGw+XBDe
   fPAHqDz3MQJSCTJSoPGRH7i1xUNTtgtNpQXd1BXfJgseR9hUuRheKk/Sg
   YU0FBj//NQpnO2rMlIc5Q2sfxOJ/X+2nCppTMRo9tyj26E+0ZPE/D8Iun
   g==;
X-CSE-ConnectionGUID: XYo90zNPQJSMiAThODjhFw==
X-CSE-MsgGUID: OZYXgH19SIe6QWZD5owlcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84134068"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84134068"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:25:34 -0700
X-CSE-ConnectionGUID: c1iDb+N1SsOba2aJRLX/+Q==
X-CSE-MsgGUID: wzkYKflRRU2FW7RAodk9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250885879"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:25:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 02:25:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 02:25:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 02:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9+6m7u3f3ozFK7pJX5IboPha7r4aMdK+JxQXLAvVifxAT93wGrfQtpAfM8fP7026a7+vUPc/wWn8rOPGsiq83KKaVFav7q4ttC5+ZKjfUXwl0eKz6Qpdnrj+38rtNVveJjWoNV2q/7qZzmCSj62kwP2dD97A12yFLD5q8/moHGwGCa06Pg6jljLir8D+Fe7hScvPAKb/vGsS6z6YvGHmQTznJHsoPs1N3cUV4a0fMJB3zK/rpoSLK2v59wW+AyY6fgq/21Ds2RapaYBUGKVeoNXczy2cxFiiHFmlsaGH6YoUrUYaDbAzdoh4ipiE8kHfRgPo+iJgOYvyAv+Wpqhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgIw4ftArl646mY9qvhGkbf/f14nJFM98RuB9BSG18M=;
 b=BJSadL0NUEKBOxQ4o50tVD5CxciRMBrOfrC05EgniMcmsfWNDCrR6N/vJucplufVoNTLK9kwEuYmtW6180a+KFKBE8KbTnKHw9pucNHpjNcPAdq2YMyNhGatriGUyQnRHCBQCz8Dv42n7KHGeDbJsX8gWzafpFGFVX4K4nQnHlCLdDhD3irlp5FTzUMinX/sRpAL4yuLMzFoDMsleDMuv1fEuquZmIWMR0QKSBqFbfcRPScJWzOvNCsuz2nEksI6iDerye+zrdP2Z9FP98gjqOb+oeCHcD/82kpGNjVa7q/+0xeKZ/NA7q5i/6BUrmBCqwC8vesY2jk6ldSMnPitCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 09:25:30 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 09:25:30 +0000
Date: Wed, 8 Jul 2026 02:25:28 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 08/17] x86/virt/tdx: Prepare Quote buffer during
 extension bringup
Message-ID: <20260708092528.GH2169894@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-9-yilun.xu@linux.intel.com>
 <e06806e8-7334-4533-b1a3-e1efbe3fab8a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e06806e8-7334-4533-b1a3-e1efbe3fab8a@intel.com>
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DM4PR11MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: acff8a7a-f80d-473f-1ca3-08dedcd2da2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: uB5rvhn+NE/iypRy8SuVI9FM9amnDa14hy157PPu16jRAnGdI4YCsVLaC27PvGsF5bFfE+hJtYMciEkCbD2hHg3BiDAYEx2jIkYHX7F7rCPFPpDKPHcSGJi/SO5G0tOPDKudXVJL1HS3rJ9UgTDOhLhFQUNz7FxYs+iZ4ibg6LtkvuPeBnbO43xDV3VxB6D1KMM3ld6yIX0IaWbwP+7TmsKdHDNMcZgn0+95u9fP13p3+aINq3vSb/FU3XH/lgq9Cfs7NCqnkvuvIr/lHeSkN1ekuQm+bk29OyuAoEQoa0VCpsy94WJjpUfv458UQADB1zI+aMyIARnXxS4kVV3DN7cwwImSXZITMN7tdFyIO9qLYcl55ABGJhpAxUu0sbk3yqBhgPKQxUdTNg5Epd7gAE6ndjGDoJaKTQCGBeq0aDRJnbDquV9/MLCT2yVOebK51OOFJ9qxunoKBnKTWB1Fs35i+voe+lNmmRPqkbJqQLeSNImwiMD6BkXj+tPY2FaYtURln7SlfO/TO2eI4IiUhMLR5PrhjQGQ9r1zesT0xPJFeuixnxzVxDnxohoHj/rUWSca5tElAyWue2kTfx4UBo3vXmGLt5kr8O6eyJXx4ser2uM96HKZyXAJg5iDO2mQEOGtaZsRAL297/cmxmVFPJSZWhaWLCfw4AHztPUcwnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X27GhkDDWrFgImaUpRKn9qxw9EcwkKU7j1yWMVKNaMCoPxHZi2pq8M5sXzqf?=
 =?us-ascii?Q?TidytbYWnhB8HCrhXrWPTPQ3FpPXSp4yrdkL20jE3n4JeNYzVCihOtSeoHWB?=
 =?us-ascii?Q?Gc4ScIcmI9gY+r2LRuzX2DmL0+zvIw0aRRqjIHhyuDO7K85DyXz6fXN/F3rd?=
 =?us-ascii?Q?2cZz+j/NTgbk5da1Lz5GAscBjOLFoc9L5qKAwFJAXcJRODsjRHx7xv5Pq7gP?=
 =?us-ascii?Q?pSUS7vHr97LnDtPInsW2bLSjhcH2tWkCNbKmf0EMdSletaszLtsnbBz6UAsj?=
 =?us-ascii?Q?eleaIuRPiF81NGfs88epmonemyfUngKHuoF7SG1+eNnQOlO4YqPO+RiYWNoJ?=
 =?us-ascii?Q?8pTavl6oo5DoR+OwOGNve6cCfPj6pyx01GlGWBmzNfsNUFNtwqXoGaTtoxUl?=
 =?us-ascii?Q?58JJ8EIf414suzd4U25Ytj5q2fvc55T0NW1SAJjplWAgtmp8U0XvQ+/ZfK0J?=
 =?us-ascii?Q?7OunSGe20PleWwqRIeRG0o5Z14x5p3e3EqIM/Zedm5PITJxhqcv1TgfzdKgK?=
 =?us-ascii?Q?vmxW6NOnxFDPJJKLH0rNlHT6flQ7KT1ZHiVliCU7L6VBjU204n+ISZkRy2m1?=
 =?us-ascii?Q?aN1gJ3ZoZlzKEGruh2P6JmstJhOFKcFrx2FUUe9JO9wmzk734O1rC6RSH1jq?=
 =?us-ascii?Q?f2pNQ2pPSvQQrY+/x7mOL2yBrb4Nk84mUFB++fJzUXdW1uDtR2hP/egZzf4k?=
 =?us-ascii?Q?rxFUOqb07mfnwRk76mMEc1p2VaYGim2G6EeNWI25kEoNaZypSVayEs7/5WPW?=
 =?us-ascii?Q?zDd1mUHZdGUiZZBgEmIADu1iVvDkgUGM1Wc1P1vI4BKvlZV/vFNePdcVf17M?=
 =?us-ascii?Q?Q3MHxldiE5a0SxS7MOwBjhcv4519bYkRNMwLSsDnVKFPjcP3YB4V/ZeY7BnZ?=
 =?us-ascii?Q?vWu7pl/zAa4bkQjISN4Az3mc/SVRQXAGgtrsptCZoOdtRRJmSSpfRVKWM33O?=
 =?us-ascii?Q?2YgXJoZolz9VCOdTFjK5iKdBEN7ECBnQ7jnWEhlXJGFhD82RhPeotY8N9yc0?=
 =?us-ascii?Q?xELE5fMNuoBpUBWNnETxLVfsfoFDbatOHC/LBxZVMJ4nuynDgCYLhuSWtn3j?=
 =?us-ascii?Q?LQB3JjMPCSdmqCViDAPdczZziYD78fa3gTsn2OtiplXXCfH3+xbT1qrhz87A?=
 =?us-ascii?Q?zstGWikrxV+GLSwu27kNvU2xYwhkqsOgSSSpFMuVXtoOdB23SlMui7p98y/M?=
 =?us-ascii?Q?9Yg97HhHMmQIlV5OCs5jzEtuJVLPSX/B2MT+JvqvcHp+PJJwX21ycvXEvR7S?=
 =?us-ascii?Q?/8x7i4QK8Vybh7urxjx+m7r7AHQY9hhrr5RdnduSrIHSb4awaUBr/MyxBNXM?=
 =?us-ascii?Q?+btux9rDVin1caHwFWm87X9Lfm7HrdFrnC0HuYCAsTnG33R+JQWYI9LWgCvG?=
 =?us-ascii?Q?aCf/6/xFiorlQn0Js+pmWz2uNVb53dOxV6uCfm7IjRI/YmnrDJ5J9UCyj/og?=
 =?us-ascii?Q?2HlaFfenkMlB+14wsiWFo91RZcKU0qZznhg7IP4wZ2VLKuOOwE8REWZZmMYa?=
 =?us-ascii?Q?dPgVAl2DXsz7gg9ACuCw/q4kJJ0Jd6ymUjbBFBE6qrO376SeRrWarhdHwgsT?=
 =?us-ascii?Q?e0/8xRVKM/BaIG1YuWgUxORk9yhT1NJunfsBjIp1aHoXtuIAHiqa1dVgPfTz?=
 =?us-ascii?Q?l9ixn1q0nKJlPZjBqd7kgMaSKSfmrrmO7M0ArIUFBMoYP6QzdCEG4wNevuBb?=
 =?us-ascii?Q?dlDZsZKfE5sB65QmL+gGTzMc0WaePbU7QyYMdeDwRVmeAfZCpvvLyJmhK4LF?=
 =?us-ascii?Q?sV9PRDWWPA=3D=3D?=
X-Exchange-RoutingPolicyChecked: TScof4NMl+WnnSOxQlgv6KuoONm7/OJqoYsSFNCr+npLlKtaBaT/8DNapF/Ap7aW7LtrB9JtVukeeaHZ+e3OVYQoOKRHj7z0F4/eN/3NvVDs4DwywrnXuHNvbl5zDgcXCEanzNQJ6hCCN4X/9dZF9alie27FlVPAWO5FPUSDb+YK00h7r0RmiHt3s5w3zaeXNGxVhkb+sSuBGxrxK/o6MN/EePtBK2AngOdaJiyJ3EcFOJBjW7+EuL9Bgds1U0SHltQ2rKM41fBYf/zben0THFBIqLN/drV9yE07WW+OWAGuobN//ip8NBZYqf71rt2xJfm2I0fWT7tenfIcNKHe1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: acff8a7a-f80d-473f-1ca3-08dedcd2da2e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:25:30.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2uPVJ6V229E3k8Bg0g3HL9Hv3N7cwgHyhMHWHYBforPvnrUstADmTDvCdT4VPdBzk8RbI0GEe/9Q8kSHpIqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 12:56:19PM -0700, Dave Hansen wrote:
> On 6/18/26 01:13, Xu Yilun wrote:
> > For simplicity, let all guests share a global buffer. Build the buffer's
> > HPA_LINKED_LIST at Quoting extension bringup. This saves a bunch of
> > va-to-pa conversions at runtime.
> 
> va-to-pa conversions are not expensive. Even for vmalloc() memory.If
> 
> I don't like the global buffer. It just generally seems like a bad idea.
> It needs locking, it wastes memory when nobody is doing quotes, etc..
> 
> Is there a way to do this without vmalloc()?
> 
> Could userspace provide the memory and then the kernel just does a gup
> to keep it in place while the TDX module is writing to it? Or, could it
> just be allocated:

Hi Dave,

The GUP idea makes a lot of sense at a high level I think. However, the
shared buffer used by the GHCI call is not 4K-aligned because it has a
header in front of it, while the SEAMCALL expects 4K-aligned HPAs
(lesson learned...). This memory does come from userspace though:

        struct tdx_quote_req {  <-- 4K-aligned
                u64 version;
                u64 status;
                u32 in_len;
                u32 out_len;
                u8 data[];      <-- shared buffer
        };


So perhaps the simplest thing here is to just allocate a kernel buffer
before the SEAMCALL. There's also another subtle wrinkle here: KVM is
shifting from a FOLL_PIN-based API to an MMU-notifier-based API for
guest page accesses [1], so I think that means more complex code to talk
to the TDX module.

> 
> 	void *buffer = vmalloc(size);
> 	mutex_lock();
> 	// talk to TDX module
> 	mutex_unlock();
> 	vfree(buffer);
> 
> 	return ret;
> 
> That actually has some nice properties. It doesn't require locking for
> the buffer. It also penalizes folks doing lots of quotes. If you hammer
> on quoting, you hammer on the memory allocator and TLB flushing code and
> slow yourself down more. If you hammer on it from multiple threads, it
> gets even worse.
> 
> That seems like a feature not a bug.

This is a really good point... I'm a bit worried about the global impact
of vfree() though. IIUC it eventually triggers an all-CPU TLB shootdown,
so a guest abusing this path would not only throttle itself, but could
also hurt everyone else. This might be more useful if the buffer was
allocated in userspace? A free() in userspace usually triggers a more
limited TLB shootdown.

I think I can use alloc_pages_bulk() instead to avoid the TLB shootdown
cost altogether. It's a bit more work in KVM, but maybe worth it...

Thanks,
Peter

[1] https://lore.kernel.org/kvm/20211115165030.7422-8-dwmw2@infradead.org/
