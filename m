Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680227CCF0;
	Fri, 24 Jul 2026 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859586; cv=fail; b=MvJq++Fdf1lEnb2xZsGe2FG+T9dqYIbBubFDRm63eSj9/r584ldOz41ksVHxrG+NhmCiGFlCmp5YmvefhATdYom1w1yKBoFEsxfVJYFkmtDmCytfU4lbRwq1RBB77CdetD/4XrCPphCblxKPnzaTZdDlULbMH6L6V873hymkfTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859586; c=relaxed/simple;
	bh=DJJj/imHEyKoD+0LJ+mw+Xu3cTjrlusEFUQkjVSfflg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPB5BAx77JdOPSTcbggIR/6/HyoQvtTT1LccJv75SEe5+f/bxmfAwE8GiY6mnotCwjwd9nwhNKqqlufKed1Yr6bm0Jr+Y55cHFVXeORJlxitDZ0A8tkVMsTPsP9QKFfk8Rwl/gguZcU1188MvUmjxLUbo38eMYh+XW6zYH8IQpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU0IE9z2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU0IE9z2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784859584; x=1816395584;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=DJJj/imHEyKoD+0LJ+mw+Xu3cTjrlusEFUQkjVSfflg=;
  b=nU0IE9z2nm1pGQ6LtiEQmtq4eFCCHf2OMvfYapiADALu6rLJ4Cf8JZNC
   9OmomJu/Fz2Fibb3GW/gh+xgCvsev0pAlTa6z38bWIatpDuDiPvYck6Xm
   Crxg7Oe3zo356zvBrw6xS+GBEFgSgaKI2GAOMxNx8rasfib7SE5bnzYaY
   tzg++R6O6FrV16wg3HJls2BS/vVRCkjL3lnEQrWvMl2ejFLJjXe7+jA89
   TdgvGwWo0BlBdvqh2l7M5eiNW3B4Y2Vpw8261xKTTvu880EnUSigSxfj7
   KUP/ZWN87B5ZWlHDfl2Sf0XmDv2BMqXFGNWHA3dEsFlGtc/+zbxyTicn9
   A==;
X-CSE-ConnectionGUID: kKoQ5jhdRgeJORWE/jQGcQ==
X-CSE-MsgGUID: Gf0+idCxTGSdRZphaFhaYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84503303"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="84503303"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 19:19:39 -0700
X-CSE-ConnectionGUID: Q5Sq3mxJSeKY8wsGCqngNw==
X-CSE-MsgGUID: n/USiLQMRf6JiLCCni3Awg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="263557533"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 19:19:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 19:19:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 19:19:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 19:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRSi5pIAFIlLB8+d/4+vroc/cG4sYJ8RjDAIJCHfmnzJWhylfZzcjRFHQSP1wK0hkoHYE+dtwGnXxHMEg6JESc/asA9z6T90GVNoGcG0R7hzGF+5a5o2c8DrWx3GwYzhQLoyuJMF6D7yGDHcSsGnR+3n3EISlGeCMKhXlPshh/J86WpVCGO/H+puJVEYvgJi1HYtw1HSnAZIWt9V7r2T0/WuJv8vLUhgOD8IJm+kWEglNCGusFghWQRL67F9ZUEpiAIhKKg4jiAGsXwFnkDzCSEd06ldLZGaJN3mWeLfOXS5WB3R1DfjsUCiH48mLqaAbJfaWwDTdaOalatZydv/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4dOrym+xtGa85/+JeFPPHcSh2w4+xMq8Yt/cBNw+0A=;
 b=pKD30aFCf03HGKArwRh/Sh1dN1yADlYbjcGPF4pfJLoRvrvhQhSVKYo8nTsshkOIniBIHi5YZmuDiWv0iSnLG33fJ2nG6N43GA7vVqZPSv9JYDWZi9uP/PfOBb3QkVKVAqbYri0zvIdrJfN6n/+QBC8l+LzB81bee4Qirk4C7om21WzT//2fF7dM6m3N/FUxbVqp+xzr2s1ZRDb+0yCDNOd2+ISlANAyOf3MJM15yEXLUFYSaspNFRHy0M5j07xQ0yA/8+glXmHWCG8pm3dicb6EoADG4kqkMAYU8L7zwb4CKtFhGLAEygI8RLQHlatwZdZAR2gBBm79yqKLyl0Ccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 02:19:29 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:19:28 +0000
Date: Fri, 24 Jul 2026 10:19:13 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michael Roth <michael.roth@amd.com>, "Hyunwoo
 Kim" <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, Fuad Tabba
	<tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine
 .gmem_prepare()+.gmem_invalidate() into .gmem_convert()
Message-ID: <amLLoRkCCaK1EHuM@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-19-seanjc@google.com>
 <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com>
 <al_BAjCNRQUvuX2c@google.com>
 <amAoijqis2Gn/K2Z@yzhao56-desk.sh.intel.com>
 <amJhzgyQMVNVD1S3@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amJhzgyQMVNVD1S3@google.com>
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SA1PR11MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4a164f-ec43-4604-793c-08dee929fd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|6133799003|56012099006|10067099003|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A0/OVZlCjMKGfY/pHewCtdVBLIrnBMvvHbvIR9+IZA/GFk6cYGfjx5R5hI7yX+1opA6E3KqKrfjxbf+E5skSBosJukXCHjH4mGCzuqcdCjZV8DXK++suUZSwoNKBxS+n8Czh/9zZGAhv47rqRfuRbaFckaNweEKdwMwp+FN3D3mTddsAJuWWlboGSS+TLa8LLb386NVncn+5i5AO5KLnefEHgaMBOC9qqyhqCXz9SiEffGqosRInH+KZq1DCO6C34IECtWJXvPHpLGf182/5LPIq3A3hjC6TAxz3fjMW+1StOJshMEEQnMdKCz/TBPZylv8YDhMyeKWuFMpIND9fn07Xar6xe4qelmtu7YNWVTx8DnTVnsbSRgWODbC6A6qckx5A7TJjXeIkVDse9G+bTZSaxafeznLKobzWI9AU8n6FibTJnwxXFJl0p6etob/MHsQACi0n6/QxAhXwQOXHlS0+y+4lastX5g6ylo7e9NLgIum/83xQo5xUS0nBABqSXT+heFXbh2Soc6032WibC+sYitW/k7bOqSq2VYAr91NNd4RRmQMW56OxMRUzwUZhXKMRKhIuLFUkfhE5nhje84FfvrZOdzW6nV++RqX0Bp8tpvFGJA7D69wZIyuMpWpPlaFeO3jhMHDQ5bdf3MIvl4TpPKrY7krLNKkRTesjMlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IMC3sde/a/yMWf6fcM9E/dyxoOm/4cJGQ93QIIHMsYqTtI5+4ENkCqAo5war?=
 =?us-ascii?Q?gEYDQ4XjjVlR1tDM7mepNqaF/eJXffCuuCtDafnV9QJaQA/RkrJFPClLNOMN?=
 =?us-ascii?Q?1n3N7HPQZiVqj16SdRpuqIG/yyjMlsRciXEsxDCJxIZw/MH3Pcyc19CZOfMX?=
 =?us-ascii?Q?TAZcx88kTI0/mvFsdhlb43HwVDk0GfsRSW0Ml3/FQLY3s9iEpxYUNKaGnNf0?=
 =?us-ascii?Q?IimA5tyYASeDDnDzbtgyjPVlRoSijubVNzmi/3EY6GNI+Fpv+L6RL0+bNuue?=
 =?us-ascii?Q?SkytWMoEYxAHK09F6BXg54cfWPsjFdItFeQX9Cd1nq9I066cC7t5Fk9UD2F8?=
 =?us-ascii?Q?r5YyO7/uPcZjVnBdyxbzoXOvoKR5DQ0UjuhJFFoaZJshGmUvymt5W/Z5/Mw1?=
 =?us-ascii?Q?uqwncqsPIa189/c+ZbX7IFSlU1DHecRVDoNOZ+YIaFU+yVWhTnB0ibGkb/VL?=
 =?us-ascii?Q?MSTISf+0Uk0DwXnf44mD70kqMjF2bPHKUihTHL1baAunzigf62VlceA2sCC2?=
 =?us-ascii?Q?ub4QcFmGwtQynL78Esq6SXdacVYuL9CXDMjc6mouFbXzErfcTquHPhAt5mEi?=
 =?us-ascii?Q?lVZhydSlEzSgLSCpqEopFmvpshDkOlQ+e8W4tCsDt/b2Yxa71PGLy1HMEb+k?=
 =?us-ascii?Q?oVe9dUQCjknZYbb1ytAErALTwVQdmWhgy4EWs4uPu61+8+VplER/0U11trpx?=
 =?us-ascii?Q?VvwK5IIDK3lm+Q04Wm1h/eB6j3J+jxXy08xoUWPTlt5icvcogB/OWNnm0Wja?=
 =?us-ascii?Q?q1t1gfcs44GUHQVXrHWIssQseroCAQ1M4VhC+p8QWquMOPAzi5hwhIydhRSa?=
 =?us-ascii?Q?q/HEga4h/raHagFkEY+dZYXlFBGnWbt1jMVfDBNXhKxx/MZE8+59byyfq3G2?=
 =?us-ascii?Q?R/wasOP8GLlrdmKGKpImF8obu4TMWHgnrtR/p1qoEFa1GFsCOme2dsM9AS4s?=
 =?us-ascii?Q?dq5iXcH+fvB4/GkD1cYcakCuvab8G3clNmvg9yTvVLQUgbNHT3Uwrvk2fJJI?=
 =?us-ascii?Q?wdQ6FV8M2YaOh60yP/4AU7+fkQ6uReRKrISvVWzTIQ5pe/zKpdSivw/SJCek?=
 =?us-ascii?Q?XmSxX2iKaQELaJ/wfKur7bcLqm1rUhHG687EgAJ2jhebZbjmgePulMPmuSBr?=
 =?us-ascii?Q?TkdhUEJhWketSn3RdsywPmYAw0srsi+HNKIjyCGJJjDCrHIRcoZh9P3uhnsz?=
 =?us-ascii?Q?pQ6FKYA1BL2b5wvv8aGIM7Jo4HllTw0GqjFNE1YseuL97fPcaOH71gZ0sT1Q?=
 =?us-ascii?Q?iePyQh+xZj/d6+j5/ZsncJLFGywshE1K8uC0krIgtTq9st+gtZp0r+HiD38W?=
 =?us-ascii?Q?qKLok1OeNW3rb7LnBhvwX53kQKS7TeIYWJX6auZdW4yFhI4VT8ifZ6BMAPya?=
 =?us-ascii?Q?e/CxiEshuBnldpGbwmiPmxIh0RLwlbnJHYu5fRbO47XSb07/ymaWS0K+4ng2?=
 =?us-ascii?Q?LVEkJ2XbKXhPBQYhw3pa0f+bK2m+4z7vKOu5QZE3v7CLDNfFzIUhUAhaSUJm?=
 =?us-ascii?Q?scvUpyCJLTHIV5N76qUfJ9SzMrCm+xGZ4zwRO3DkLu3BMBVU6271LIPlo6lQ?=
 =?us-ascii?Q?NZ5WRuULyFFaWawf0nyvq1oncWu2aKRIo2at6zoQLrE72PsoynoVwrenHu7S?=
 =?us-ascii?Q?3luIrVuVn9Lglsq0omo9sl8bNiPBJrFnk8YwVdoZo6Qevd5IzV4/Ak+kBG4P?=
 =?us-ascii?Q?5A0v+vemWpKnLDBA2o2HAZJHJF5wWPtHn/fU9GBCbC0wcYWMOdRKxhLV4rhm?=
 =?us-ascii?Q?F9+YYugKsw=3D=3D?=
X-Exchange-RoutingPolicyChecked: o6zljmR6OMsgt3rdB1H4KquDJ+vfMtfi4ZeUejbNSfjXDUdMngS4/jN2awB1AEMFUOZRNNLW5zdPI1OrlbCcOxujFg3m7M9lyOcET6n9A+hiFPrNcYcMilDDZZv9ZrQ9e0ZSlYdKX74ypwtMrcpYbV9VObL/t2Mjsxr79kH7dceChJOzt82Y1ZREJXZi2s04N1jpaWjCHXh+k1lN5DtdKLuC53FhQCXLVqtfibeYDiZkfzDfwJWSEHWaSHSm39exgGKUhuc828OUiCtD3ZVldom2DjLZwjahlW1aeA5ISSi14JgD0m041suJq8SVJOaBEd1/5m5Ser4xPz/zJ6G/XA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4a164f-ec43-4604-793c-08dee929fd57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:19:28.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBciXnNXhf14FT+/wOWUlZPs3XqX+52xMyEh0qbp1BR/hKcPFjrhMeWLylNutWwFXMAbyayvGQjfvh/+zENBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-OriginatorOrg: intel.com

On Thu, Jul 23, 2026 at 11:47:42AM -0700, Sean Christopherson wrote:
> On Wed, Jul 22, 2026, Yan Zhao wrote:
> > On Tue, Jul 21, 2026 at 11:57:06AM -0700, Sean Christopherson wrote:
> > > > Asking this also because there is a .gmem_convert() for TDX huge pages [1].
> > > > In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
> > > > kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
> > > > convert may not be shared after the punch hole. Is it acceptable?
> > > > (To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).
> > > 
> > > Ya, these concerns got raised by others.  pKVM on arm64 in particular wants to
> > > hook reclaim but not conversion.  The plan is to keep the reclaim and end up with
> > > this implementation for x86:
> > > 
> > > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> > > 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > > 				kvm_pfn_t nr_pages, int max_order)
> > > 	{
> > > 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
> > > 	}
> > > 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> > > 				bool to_private)
> > > 	{
> > > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > > 		return 0;
> > > 	}
> > For TDX huge pages, if we want to trigger private huge page splitting before
> > converting to shared, should we invoke the hooks like this?
> > 
> > __kvm_gmem_set_attributes(to shared)
> > 	|->kvm_arch_gmem_make_shared
> > 		|->kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > 
> > But TDX needs kvm pointer, and splitting pages may fail.
> 
> Ya, but those are very solvable problems.  They just don't need to be addressed
> today, because SNP is the only user of the conversion APIs.
Ok. I'm ok with the change for today's usages. My concern is regarding future
TDX huge page support, as I am currently preparing TDX huge page v4. :)

Sorry for the confusion -- I should have stated my intention more clearly.

Previously, for TDX huge pages, you suggested introducing .gmem_convert() to
trigger splitting before zapping S-EPT.
With this new direction, should TDX huge pages instead leverage the
.gmem_make_shared() op for that purpose?

If so, should we introduce a CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP guard around the
.gmem_make_shared() invocation to serve TDX's splitting purpose, in order to
keep the two use cases (SNP and TDX) clearly separated?

> > > 	#endif
> > > 
> > > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> > > 	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> > > 	{
> > > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > > 	}
> > > 	#endif
> > Is this kvm_arch_gmem_reclaim() invoked by kvm_gmem_free_folio(), and should TDX
> > not define CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM?
> 
> Correct.
If TDX also provides a .gmem_make_shared() callback for the pre-zap (splitting)
step during private-to-shared conversions, my concern is that TDX could be
inadvertently affected if CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM is unintentionally
selected.
Should we provide a way to prevent TDX from accidentally enabling
CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM?

> > As in [1], for TDX huge pages, you suggested pretending a to-shared conversion
> > in kvm_gmem_punch_hole(). In that case, should we provide a new CONFIG_xxx to
> > prevent it from being invoked by SNP?
> 
> No?  That code was purely for demonstration purpose, I there was zero intent to
> ever land it.  The patch was tagged *** DO NOT MERGE *** for a reason :-)
Understood, I noted that it is tagged as *** DO NOT MERGE ***.

However, for TDX huge page v4, should I continue tagging the patch as
*** DO NOT MERGE *** and keep it in the series? The reason I ask is that patch
[2], which immediately follows the *** DO NOT MERGE *** patch, depends on it, as
patch [2] adds the following line in kvm_arch_gmem_convert():
	return kvm_x86_call(gmem_convert)(kvm, start, end, to_private);

[2]https://lore.kernel.org/all/aXt_L6QKB9CSTZcW@google.com/

> > @@ -253,13 +294,18 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > 
> >  	kvm_gmem_invalidate_begin(inode, start, end);
> > 
> > -	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> > +	/*
> > +	 * For demonstration purposes, pretend this is a private=>shared conversion.
> > +	 */
> > +	r = kvm_gmem_convert(inode, start, end, false);
> > +	if (!r)
> > +		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> > 
> >  	kvm_gmem_invalidate_end(inode, start, end);
> > 
> >  	filemap_invalidate_unlock(inode->i_mapping);
> > 
> > -	return 0;
> > +	return r;
> >  }
> > [1] https://lore.kernel.org/all/20260129011517.3545883-44-seanjc@google.com/
> > 
> > Or would the following approach acceptable to you ? It renames .gmem_convert()
> > to .gmem_prezap() and invokes it before each kvm_gmem_zap(), so TDX can hook it
> > to perform page splitting before the actual zaps on private pages.
> > Per my understanding, this op servers a different purpose from
> > .gmem_make_private()/.gmem_make_shared() in this patch.
> 
> Isn't that just kvm_arch_gmem_invalidate_range()?  Which was added to fix the
> SNP VMSA mess.  The only thing that's missing is graceful handling of failure.
Hmm, if .gmem_make_shared() will be used by both SNP and TDX in the future, then
it will be invoked:
- in __kvm_gmem_set_attributes() before kvm_gmem_zap() (which can fail) for TDX.
- in __kvm_gmem_set_attributes() after kvm_gmem_zap() (where can't fail) for SNP.
- in kvm_gmem_punch_hole() before kvm_gmem_zap() for TDX.
- in kvm_gmem_free_folio() for SNP.

Since both TDX and SNP would provide callbacks for the .gmem_make_shared() op
but invoke it at different points with different failure semantics, we need to
provide different CONFIGs and prevent them from being inadvertently selected by
an unintended user.

So for simplicity, could I just rename .gmem_convert() to .gmem_prezap()
(instead of to .gmem_make_shared()) for TDX in TDX huge page v4?

