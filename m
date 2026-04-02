Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31133CE9A;
	Thu,  2 Apr 2026 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097888; cv=fail; b=mUaR6I4pB9zGFZkcJy2165hj6kNNRs1Rtp9ddwE3+PkZz1jKXQ12DbkgYWeUGKlfcsRjD54FXxBuvDiZJSoLwiUrbAAtRGFQF9ymrYZC0zUNZsa9wyYC+mkiiI/2AP/TJ+r7eloOWjDokQ3VwEBAERo555ttLbRI1n+9MJ5cgeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097888; c=relaxed/simple;
	bh=qivl4L77taN80wZTyXm+ye8kDaa1xGxiw6zlZtFn6io=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VGcxZDjga3UgOXgyd2hykbR+tqF4s+rMXZCvNEMo899wsaPZL/ydwfp6lyv94em/HPr222rVsv1m5GlDfbEqD/6wFt4KfzuyH8mqmqHvSPcAK/muneIBQdw5ZdKbB2mw6rOgHVX+2zX66orDQdITe0CWpCEhh2anFuT5ScfJsXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLdF1tVO; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLdF1tVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775097886; x=1806633886;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qivl4L77taN80wZTyXm+ye8kDaa1xGxiw6zlZtFn6io=;
  b=eLdF1tVOCrNVExvwjnEDgJHi3dEIxxIpNCS8PQHMWiox1Ei1c05Nn+Yf
   yNJ7uBiiuej5vovfTAN0TJzq7GvoPz961F9SrNFTQYh6b3KJvc8x0/1zO
   ulET/l1lGeCxSBWrfyw3SXLIWKY1PViidoLbEy0x8Fvhu4F1Tx+maD8aB
   rC442SLbOVjFLcPrT4jI8CFlTY3Jf3TlnWiBzzrgLmOKo8AknG8G+21Rn
   1qShAqlSYcbZtq1uJM+3sXvb4ElR/juhc/F0xDYqi2lwpV1cUP4fvtbJC
   nh6C2T3+LQu5pmmcHh6duRvBpEbbKOOoAtgTPHIGzJUx1obytQ1Ecjras
   w==;
X-CSE-ConnectionGUID: ZLzOXp+iRcC4c0JW7J6Bow==
X-CSE-MsgGUID: wOQheD3OTtqnEGu1DhPC/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="86849757"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="86849757"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:44:45 -0700
X-CSE-ConnectionGUID: 3lJaeyMLT7ul+k4gj9eAUA==
X-CSE-MsgGUID: XQuI0hS7R9CwDDM2E3R1lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223567829"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 19:44:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:44:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 19:44:44 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 19:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUFRJO/uxOm2DqBoM6hbQTxeG/43mFnU5/na3V9wyfYd4GsrSXE8oa3x4zSm8a35Ykn7P5RB7ER1/oOtBlY9Wk0nqTfmbz2O7vP2agj+tdKKokgfPu2R/6x4RXH3MXtuJH+MpC+mQgTStVB3J7zuoQc2qwZSKc55TrRk+olqDOUIqtw7doVRZmao5SowsoLU2SBCCnVduijoCr6pDInbC32X6h0nrrYSNR19w6zBP9cfBlTU7aGkwC5cJCxqmdMzU4lnJc40JFzkAlK8igiWG3XCCf+GUTA1WLH1YkG7JrwVpWN9doek0f36BmLyw6WmEoYPscbUjbWkpYRPBMj/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj4hey3sC7MuFdvwzBpHFx/i0JvkEZAwrDz6U6n1OuM=;
 b=PUTETc/L6Wey6W2j5C3msZqtXXO27xsIjg2B0J/QBfEsLiYvuSuH6y8PlLg1t4aw+Tr6lwPQhDxTVUE1OyUK0qfMEDw4NoRcPTQMJdP0ZGq+m/C3xTSdSIbJrEZ7eDuTiaY9A4oL/flV9rzLNR1fRCi83cpyI1t0gW6oD4i1LptIn8ucnmxQZoO7opz9/WNXsge6e+Uyv47Pk656bttE+1a1eJSuvj8cUOjwJ2Fp54eb+Vf8ZZsiZV86YThmlL/jD9zmMA36uHMvAzhGioJO9g61K0GTIFrXfWk7WQQRHpSe7kufLl9x6S6lXYIrWZ9k4z0eC7vj+5nn6zzog6uUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH8PR11MB6706.namprd11.prod.outlook.com (2603:10b6:510:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 02:44:35 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 02:44:34 +0000
Date: Thu, 2 Apr 2026 10:04:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Huang, Kai" <kai.huang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/17] KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock
 when removing PTs
Message-ID: <ac3Oy6nyXrHZwnay@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-15-rick.p.edgecombe@intel.com>
 <acofvYU6zlzeF6wf@yzhao56-desk.sh.intel.com>
 <7c580a45c27440852ddb16465bf8a9acf41381fc.camel@intel.com>
 <82f842d780f9394cd670d10a15a25973cae3d3d4.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82f842d780f9394cd670d10a15a25973cae3d3d4.camel@intel.com>
X-ClientProxiedBy: KL1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:820:c::8) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH8PR11MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: a41913f8-ba10-44d7-cbdc-08de9061c654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Yr1FuS0qKJ1umuAkyzLE9fFyUzVLNq2mrRJyi99TKc0c7rTACS82MjeCkoXhOygqSDu2qutuJcBh4tqG8IhdiYjBGCRlrUcXF20nY7VzrwgjbXxkM8SgnLcqo9soZCSMPOoZ0Wpkc2cM+hlPavxG+b3/KUazhy0cGnJrnzDjsjYKrWrdm2Kx7ADQjDWHjBupSixeYQARosGJJJTAD8cU7mcM60ab99CGny0vOpIJSxVGp4R+0hC0CzuIJgK1ptS/05pMSBn5oISZYWRGmsV/QpsNDo7LQKElKcsBs/XTiacvSewOsAaRjrHkk1y8mbThpPWUHn/P4dF19hwNMMXUPvHjENlCDtzsFev6frDbTlOlibSYyqc48N33Cft/HuzI62HnC+CiwWmiJ5jQgFb3RD8I6Yaqh4wJLFjS/w8N1YOmwbrwwZSxxiFC2o2c+ZIO/Qkgcqr+T46gsLE36Tnza3rAtRvkhZ6f/yzMm9fx+lwEwv6P094fWEGvnkGJs7oyPXJN1+EmLnfTFRQK700LLX7RiZIbQvcVF3tPOpnb2pbQiWigDxO5NZ9hFowWFgyIcxdmjNyniUaLcWH3oDCgdwEfyzEYq71ZMcM9vJfDo7gQmoE2VUHv7f5lzjJqagdWzguY7+D5DUt8bG92LQmqia/LgiUP+x+vKudZ1wJ0HJ/rv7cDrA6elmC6Se5F/LVxPUZ/y/5TFdDYSENJ0J5vo3XgDpVxjpHIrLP4in35Ddc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?95Uu6nUHhItXyNlujnhr7D7W4wEWgk0NG+8g6CDyI02le8uk2xO+8PTE+0?=
 =?iso-8859-1?Q?7uC2uFxEhXLns9Ng8XITgVU6yp5n22ULrbQ0ZA3Xy/S8aHnzP47kbn4dgo?=
 =?iso-8859-1?Q?mO0RAcm37Jv02foepxJw+ZQG21X/SBXWHa+SerqrbYRDR9Ysb3nXz3ABq+?=
 =?iso-8859-1?Q?8Q6bUlTs4pZiU3oAu4E1SreHy8sQYlP0+7r86RXhNcO5F5V9rGMc1RrFF8?=
 =?iso-8859-1?Q?a2CdyL2mKoUhDm7Ii20MTn0OSZ4gn+h9ZBC5+dm2Vcv/cL5b+UW49ZehQ4?=
 =?iso-8859-1?Q?P18abBFH+knQAIUpNvqVm2oi5h9UhSSi7tmE1g80NJPXSc0MJOzrd21heB?=
 =?iso-8859-1?Q?AOmnGGpWW5MZwad97mbmlBYfLA/KhbV0Ao2Uzx7TbAKq+UP20TWYJEiOjY?=
 =?iso-8859-1?Q?H3AIQZ+3pEw6d2M5FYQXvjd48CXX7nCxrRW0w7MAbEeH6ov07iLbdUbz3v?=
 =?iso-8859-1?Q?+sH9/HpNhS0y4pRcpNKil3VYZ5AOXrmR6LnoAmMTCJ2ZMCEykLLLDvVLTJ?=
 =?iso-8859-1?Q?oC+1RU6STBFdqozkbkNfqGFhWOyBQ5vVa3QezH2YSuiSUzVqzi9yRqsvM0?=
 =?iso-8859-1?Q?UVIs1MYCvxj0p1QZEENm+q5yu/94C80JpV9/pfp6sE/ebU+b28UC+KsBoe?=
 =?iso-8859-1?Q?+voqs2cJHMNWh0G0eDIdJRK8pvPijCukpKEzqsh1VUfkx3e+GahRM5vSaK?=
 =?iso-8859-1?Q?GfJviXl8ObIMEywp1IIQfGj+wTWl7bwCLNKBw0IZGi5Qd1h5bwtagHAG2P?=
 =?iso-8859-1?Q?nww5lYMXGkhT1sdbImaSCIpxpeGve/Nx6fSXw8jfUkd44gLKnfyjvNh76D?=
 =?iso-8859-1?Q?i5iuvllyvweKZvKF+03LVNrfg1RWNcCQKGusaOXDdILcI2bMzOPd1el/Ch?=
 =?iso-8859-1?Q?qqjruUEQNqrlN/CBdrAci/jdTkZlXvd52GPkByCxVsqY3qw5cyHbzv7cpq?=
 =?iso-8859-1?Q?JIzdeWr9EMY23Yke/kxf4noLG3lNy1pbqLUyi0fjyflkKfC5p7a1lgRXBd?=
 =?iso-8859-1?Q?mpV35hi+Vfar+hG9v34zpIRBMdu/tu5io4lxh3RbbWX6Varsi5JlKYJpx/?=
 =?iso-8859-1?Q?eshbOdQqa3yrB8Ei0HPaWTQyL6lf5Z8AsS7owTsVfEcIbRTr1XYPbhB0dB?=
 =?iso-8859-1?Q?I3bTxcUCTU36k7tyPcyCQgouHFwEoFdANz5H5ch5ZOQ6KYIxtBM4vqs3nz?=
 =?iso-8859-1?Q?eZ+8Q3v5VtKBmYpWpcyQVAgY/62FuMN/+qQBUQ6TI/YQFwAGI8sP66z2Iq?=
 =?iso-8859-1?Q?ep7/F+onz4wTcm5hRE/LfCqiKaWNvMb2aN3DAJea993XALDRhlkGIILwdD?=
 =?iso-8859-1?Q?yleUbo94WgXQQXlPKQ98LDyy0zxdjxWmjE8E0dUgvMCEtGWOj8biTDOzCX?=
 =?iso-8859-1?Q?6NO7QcHkeRzGz5kTpxrLv017IYIJ6toG+QdVv+KnJs/0nSoIbGtBl3DTio?=
 =?iso-8859-1?Q?Novor5n5ZaER2WHdLZakbTz76MBuYJk6um+aGY+MAVhRQbeKMlIBFgI4Hk?=
 =?iso-8859-1?Q?KpBEQmY2K8hH6YTEZ0qjNEXCxlff+9kDY46l6tM5jCW5yXdgHK/Sutk23U?=
 =?iso-8859-1?Q?WD6nLr0ji67B8D+iUWTz4YVJhOK7aWL2Lho90Ni2DqoD2c5NJJtQD50CIm?=
 =?iso-8859-1?Q?KwG63yWEvgxYODCZp2Vq45mIfDByjnAg6wqjCU9yH9JBwd2h3m3mYqR0lt?=
 =?iso-8859-1?Q?zm1NE2W2yQ5JPN6LfMPK0NKWvVYP4JAlI/nUwXH4zJISaidrcItcS15COX?=
 =?iso-8859-1?Q?JJjKurNjnoVy+k89KJSL+RkeaziTz6Z9ODtRtRdrK+NozWj6KqtWRjwzG1?=
 =?iso-8859-1?Q?PuF+qqLD2w=3D=3D?=
X-Exchange-RoutingPolicyChecked: tPJddC3I95bp4KNgxtWHBKK1DxZEktQA05rKFLp+TIQ84HxTTCWb93q+5urSH1aFBYlQ1WyLCabPwr/b1ics8YyhzoBueQHu5d+NenxuX7JjAD7+YJLtys6ZfpOrbBBxs9ue2Z0o2ke+D7r66oGsgna+J4mNNq5ZoBt/iJZoIWNwdnRShXuFj0cbAeI+LJB0Ig0Ww87WFCTAY01vaJb7f9hzdF4QsJC4xEgrzX0WlKLQ5mbmpAIjB2/zRBm5jwdcDR21GqapE7hnA88SEn7hNlpxLO8UbzUs9oYVHsTRpEBtOB5BKrlAU2ahWO+N7St0/B6gVql2R5K2lw8l63JDow==
X-MS-Exchange-CrossTenant-Network-Message-Id: a41913f8-ba10-44d7-cbdc-08de9061c654
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 02:44:34.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jya+lmXT5J6ZYIM6yy6JEk7RR9AoJ+Pg/lzSzMvRNDPhwQlAcZYn5SCv4itwY4S8GKMp92C5VSK1AgoPPkJSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6706
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 08:08:54AM +0800, Edgecombe, Rick P wrote:
> On Tue, 2026-03-31 at 10:46 +0000, Huang, Kai wrote:
> > > 
> > > > KVM_BUG_ON() to use in the logics future home.
> > > By "in the logics future home", do you mean "when this logic is moved to its
> > > future location"?
> > > 
> > 
> > Maybe it just meant to be:
> > 
> >   the logic's future home
> 
> Yea that is what I meant. I'll update it. Unless Yan do you find the "future
> home" phrasing confusing?
Yeah, "future home" seems less clear to me. :)
