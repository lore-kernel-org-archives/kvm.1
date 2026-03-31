Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08781732;
	Tue, 31 Mar 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951013; cv=fail; b=i82tNtm6++7G4NsnomNW/+RDoYD1iChFp3+VmB4I3nXRyRbceTZYhFTcqffm825S5EVZfQMf1lfeqaZCj9zbgDkhqvOY4G3fYs1vepN5nbdM7djA8GY+ZFWXZ9OAtlh1nM9NAaT4aPTOvuAN1mHiwM6P5kdZYph0zq9Nq1aj+tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951013; c=relaxed/simple;
	bh=cm8pCyCbzHff1Yc9U7/abboffdqXmNBtVRYxf7mD1v4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S/aICzkHWUtn6la/hWZUmgAUZzzP3xQ1g65PcWH2fvcAleWJ4SLlU0AQCqy0lwyAoYyx4OJoFJZ9tezB4M3SXU+OQyWHG9Fva6r+FixWuyGePk4IZWYxrYCHLp7njqNU0UPBvGLZTMuCDCKjzF8jS7GktMAlUlbmxMITPJWXxAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqbFs+TP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqbFs+TP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774951011; x=1806487011;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cm8pCyCbzHff1Yc9U7/abboffdqXmNBtVRYxf7mD1v4=;
  b=IqbFs+TPfGzbyzT/xdGCfdo5tabC38yduJE/wuQj1DO17/SuxK0lrRC2
   TnvUnsVulbrfDJ1zvXeH9Ov5ZBnctr8AIu3Djk8qk2d54bPn8ZAn6JirF
   xwlIMTaFfwLLH2vH5UONGjAUkZxIOsAWzYnlIYRerH0/zjmc8maiwvpXu
   +/0ZAn0fyFRrtGsshKB1OJ7swbfBkAofr8+SyewNs/W4QhjRXbe4aU0gI
   K6zRt+EXQHOQHw70ZINZq5U4zl9AszlakyGd4SEOc0IAgaoXo2feiQMXN
   +UCGAYWk4okY1lrqs1EEuFn20pXvPMa2n5xqpDlCIvH4VkEMf01zpwFyQ
   w==;
X-CSE-ConnectionGUID: oP8/kXOhSa6lMo749oNGZg==
X-CSE-MsgGUID: pyBRPJ2jToWhONVSouUQCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78551233"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="78551233"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:56:50 -0700
X-CSE-ConnectionGUID: dLw8D68USRO+5ehJaj6BrA==
X-CSE-MsgGUID: 3yUIUVWdQqCOuN/EU5un2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221918351"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:56:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:56:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 02:56:50 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8yWgSg3iX5UvAc9Po3LloQYOLRybxG2hZ7ICRJY1KTJrJ3TK5CYCNAC0Adq8jcTQQZuVPlK7AEbvBMYG+OOg4yazTTxDdnxNtDQ8SG3vuxYKTqhiWDzqQADZ95U9Jffx79Nc2cA1cJXU3fNeD+RRQ4qWGjsoErPzpyHGBGWa/zcotuCE7xpYXmS0A4k4YoI4qXXz3eLQOerf5/vylLuJrAS0f2xdx664RnYdixro+TB4gHP+R82CxyGJhR4qk4tEYRSNBjf9S/czLJZu/u5arYCr64G6W7zmkpU+wwhR185EIeQUdi/wm/D864f1LcAt4Vs7gwocljxoyjL1NbJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnWvAD2NX1jDkmdCO183XXScJOOac54DRA12l+rgnWQ=;
 b=N6USFAPPZPxF0tefRdVKP9LW1j/ECOnrI6GqPbfDPyUydSZnYc58fefcmTVgQ5AYfcyKKXueOfUyQUWkfjuyXfr3uKrPH38/xbt4dmeJDJjCq3HdiRlz7ZQ1pADTBanTD8JWloGFQZkiDznvUbVhPa0gjNP3rizooGZA38MLn1LLnGRxNZyir4gj2bJcz3SJ+uXEsCBcAoFtzV3dNrtnpM2QfpiQ52RUTwdkgB1A3z8AUlEdZxgqA3uwrtwDP5BP/EI8fykh0OzCjkANu3/Nb3uKujJ+ELsypX1lywpz/BxHfRgp2hMLevsGaT55rshy2Z9VHdo63v259UEi4+vY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 09:56:48 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:56:48 +0000
Date: Tue, 31 Mar 2026 17:17:14 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64
 on mirror SPTE "fails"
Message-ID: <acuRGgIEeXZ6ng0h@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-3-rick.p.edgecombe@intel.com>
 <49cdf35c32e064ef5d6ca24bd4bb9d8b26bc2202.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49cdf35c32e064ef5d6ca24bd4bb9d8b26bc2202.camel@intel.com>
X-ClientProxiedBy: KUZPR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::9) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: aece7055-c093-47f3-9940-08de8f0bd316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wqsvOLcYaHKRgSupyVh0NS5IvgdLfFFUZmCCxTGhb6K5EfNaJxiM0QY0HXMk8M+3ZMOB1XhGPsSZvsPMHspoxat9R55EcU84yrkMbCZf6jNfWoLCgQi8nlU18b+d4lQz/1tj5pJ9VHVs/ba6YURSV5FD2HtKhb6jQPyAuDvE4TxJy7IkNHkJ29U0dgMJvrbnz/5zvhhyZQUaf+5FsREvKctf9azLaNskZXVxPpTDzN8V2fwfzxzmxEy65g/vOEGq3F8K72zTXvJWf6EcQN8G0P30ZQ+MWXKGvsc8mX8UJ7Tz4Wanv7yiqSpcwiOr4BWVTU0xuzLOEAvgV7Axkrop/EqyRE2ORffZPWzWuFptC9MUgdBKDBE6rWZQXY7P4JJU9UrGGoAO0NyPuEymEkENVSbYaEcP3P6v+uL3i3vt5uW9mWCyl3h+RSQKloQEij49tyXZ8ClxmDJQwlRG6Z8XJIrHEeQ52OYupm+Ut/7QLH7SGLHjb0EU/qFVjXd3Xe+ZL94Xj0HqxvnsNM6Hu/zY9JcVvRdzE/jhlSkXpuPPz5Yn8cpA7VkVL1TcEpe5dEeWsws/qNv0j/MR8sqJAMJJIm5d8te0DchVlgMwDuVGZZ4AhbvZHQKeF5t12duLsJOwLAbAMqScUa++HOlW4ME9s4SH8VdncuFnBI3rplKsxhSl9/LnzhtQWOvFjMlpTfZSIBVxqU3kV4SlmhQ9TR1bvLvFTvO83nWcg0vPUASbpzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x7BMHwrCWgXXkshmfNmH/owNrJK3fBIo740Q+2Epengx0sj230qCZE6h5K?=
 =?iso-8859-1?Q?PUlIVkY55xJq9DhkmticvdEZJ2E3t42SpEoiMqAhNbIa2o0EBNt2bnnA85?=
 =?iso-8859-1?Q?XfbTam+SD8dOILwiXHxctsvGv8lDu2B0WTij/KF+o5OqZhS1TZncAFZI2O?=
 =?iso-8859-1?Q?KBuoj3UkwAzwbxn/L9SorsHBxFAAeVOCNVD3HyrhZFPt47Kw2ZnHwX/aj0?=
 =?iso-8859-1?Q?dlX12q+MB6YbPntB1GqFnENSt45XS2wWGVaL7d13SCQcnEUJRciaugnKO+?=
 =?iso-8859-1?Q?RgeCoV0T2r41CPbs4oR5wZp28objzrs4R9IhfA0z0okNyElzok4pPrHGqX?=
 =?iso-8859-1?Q?1CNj1JrllmCA12mo+blP0Ky4wpDPKvgWdPUg6UrMduHI//0PdgXkZCMelv?=
 =?iso-8859-1?Q?NIJ7V+GpwSSl7Cps2v8U2+chCVWKJEqEs2dkL3gDd5T3pXFpcMrsrPQCMb?=
 =?iso-8859-1?Q?hH9lrItMQpPcyFt5e2VapwEvbixFZnIOFst6bK/fGG1HDVTk4J5y3OvsZ4?=
 =?iso-8859-1?Q?ipFUYAcgjzOXcGhhi/2GccJaL0Ys6X43eTmYf9EwDQ//p1i8hZTj+tjXv0?=
 =?iso-8859-1?Q?oe5+XpXubxFZIeyCZmfJiQSegUB4PSbqgiSP7zt2yyA3/tmyR4qoLoxUn8?=
 =?iso-8859-1?Q?BvmPh1GeKp4uQjdQlsoVOljEVCeYTWVTWw7zbxVwFDi1HZzmAeDh2GXj3K?=
 =?iso-8859-1?Q?nFxi/N26zDzSk3YwoenjxEgV5l/DBb0x7TL3tx/8ZmgqK+5BBxYI8/bf4w?=
 =?iso-8859-1?Q?4eMTg0+xVs/hDV+h4c4vcpu6UYV4qB3xrq980gOO5fviGBAUo+/Vuc0vqN?=
 =?iso-8859-1?Q?0Xy0h2fEc6rXiU5LjEXlCqSVaEacAwBK5wHALjBR2e4bt/LFLScglrDDHU?=
 =?iso-8859-1?Q?mP+o+oW+CRCuHwZxfzrrWac1DDDKMBkR90mijplBZoUnCu+N8rmvqr4uEq?=
 =?iso-8859-1?Q?4tUm4JWKNCP2vzCeiSiZjJZ38jp458vtwGdblTczxg1xuIAbd5vdZT9cNN?=
 =?iso-8859-1?Q?L13P2ERf2zcFJAPi2dINVvDQfxYWqeqJPCzwhpZQRuwKNdt0qD2Em83LtR?=
 =?iso-8859-1?Q?rqoV/XmQf396f8cypfArlQ9/C3ecY7HA4vxtNTEL+hLnABhKhJ+wNUPZm4?=
 =?iso-8859-1?Q?cjjk2PfAT1b3+Ri8SrvX/DJ1ZqPRW/Bn7GtU55HyHmUNWUCJEpVQTNLKgt?=
 =?iso-8859-1?Q?n+KjP1Ys+5QCqNUAQRF1uPjs3U9i2JplnSF9b1vHDjtlyw9EIZmfuWmwWv?=
 =?iso-8859-1?Q?+eW77j3PzGmOe+Jf2zWsCYYUF4IpvviSzViNXysJo4AUOpq4BioEGErxkP?=
 =?iso-8859-1?Q?WdiaXFuq9QB/jl2mmIQYEV30AfjeVXv7Z21sQ1r97Y/ycnGahbyJQx4bxX?=
 =?iso-8859-1?Q?4UxtIx5Ts7BCB4JQCfMX3QMuxSQ+cy3YqQOKqZRplHFWTyEICFkaoH8F0+?=
 =?iso-8859-1?Q?gf1/bjEO/AbGZ6/8+jaLmk97t4JgKjiCpo4bVUqjH0PKOdh61OkM6QP8Ag?=
 =?iso-8859-1?Q?SBxBC4EXbMiqMPsnOXkNSU2OtBNsY0P98sHGOyjPw/xXJrVpwwfPCx8RH3?=
 =?iso-8859-1?Q?/tO42vCOAFDGGQY/O6WQOWHwJUpV8ti/gulY7q/4Qywdbi+xo9fp9qUzEO?=
 =?iso-8859-1?Q?snpupMAcqU0GcyX8DDxKr4/ZbxySaHrmw3FNeyGqu4JbosKUh6UYuNnKI6?=
 =?iso-8859-1?Q?D6ht7gJOiVtiOUb17BINu/lmhLmHr3i9wHZBOgDQsnqUNfVJG1ifRvJ8k6?=
 =?iso-8859-1?Q?/ZrL9sOs2VxnHuaV/yllSwgD6DS/tfV2E9mM9auPFyrtzaZJ1nHYTlzHTL?=
 =?iso-8859-1?Q?ut0DngCszQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: hX+JfBb2pIH4d5PzPHjGDJ+W/QVx6Le3w7Bv26sDJzHh6FzxKo9heFVp0xaJvfF+jj5BfhQL5t/wzrk5SSvr86tw7K5OOLUONBzKWI8aJK9iHJfVCOv0EwLm9HejAhgdLPGXN1FOnXIF1fyNRuJVc6DnZAIW64GSmB7TVlX2Gps53x+Ty6SbxLoCWbvt4ti+w0hr0x6tHJSHLlwdLnRvsUc+6pKHy/DR1OZ7Yqr0nP5t3cic6+MJD0Ivsar1v0TTVk2I888TMZeWYRbjZ19F9Q5abCKnHjOAED/bESFF5gS1kd286zpqoesBeMQZRAU80rmsXDoNg31XiYJ06k21mA==
X-MS-Exchange-CrossTenant-Network-Message-Id: aece7055-c093-47f3-9940-08de8f0bd316
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:56:48.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDp4SAKKAQxfq/fMRYYGeI0pvZl/LtcJw0Srwd0WU9syO2cKvDMeEJdptobWE2iz41TMEnaECzLQim2vgG7ejw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 05:47:29PM +0800, Huang, Kai wrote:
> On Fri, 2026-03-27 at 13:14 -0700, Rick Edgecombe wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Pass a pointer to iter->old_spte, not simply its value, when setting an
> > external SPTE in __tdp_mmu_set_spte_atomic(), so that the iterator's value
> > will be updated if the cmpxchg64 to freeze the mirror SPTE fails.  The bug
> > is currently benign as TDX is mutualy exclusive with all paths that do
> > "local" retry", e.g. clear_dirty_gfn_range() and wrprot_gfn_range().
> > 
> > Fixes: 77ac7079e66d ("KVM: x86/tdp_mmu: Propagate building mirror page tables")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > ---
> >  arch/x86/kvm/mmu/tdp_mmu.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 7b1102d26f9c..dbaeb80f2b64 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -509,10 +509,10 @@ static void *get_external_spt(gfn_t gfn, u64 new_spte, int level)
> >  }
> >  
> >  static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sptep,
> > -						 gfn_t gfn, u64 old_spte,
> > +						 gfn_t gfn, u64 *old_spte,
> >  						 u64 new_spte, int level)
> >  {
> > -	bool was_present = is_shadow_present_pte(old_spte);
> > +	bool was_present = is_shadow_present_pte(*old_spte);
> >  	bool is_present = is_shadow_present_pte(new_spte);
> >  	bool is_leaf = is_present && is_last_spte(new_spte, level);
> >  	int ret = 0;
> > @@ -525,7 +525,7 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
> >  	 * page table has been modified. Use FROZEN_SPTE similar to
> >  	 * the zapping case.
> >  	 */
> > -	if (!try_cmpxchg64(rcu_dereference(sptep), &old_spte, FROZEN_SPTE))
> > +	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
> >  		return -EBUSY;
> >  
> >  	/*
> > @@ -541,7 +541,7 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
> >  		ret = kvm_x86_call(link_external_spt)(kvm, gfn, level, external_spt);
> >  	}
> >  	if (ret)
> > -		__kvm_tdp_mmu_write_spte(sptep, old_spte);
> > +		__kvm_tdp_mmu_write_spte(sptep, *old_spte);
> >  	else
> >  		__kvm_tdp_mmu_write_spte(sptep, new_spte);
> >  	return ret;
> > @@ -670,7 +670,7 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
> >  			return -EBUSY;
> >  
> >  		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
> > -						iter->old_spte, new_spte, iter->level);
> > +						&iter->old_spte, new_spte, iter->level);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> 
> The __tdp_mmu_set_spte_atomic() has a WARN() at the beginning to check the
> iter->old_spte isn't a frozen SPTE:
> 
>         WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
> 
> Thinking more, I _think_ this patch could potentially trigger this WARNING
> due to now set_external_spte_present() will set iter->old_spte to
> FROZEN_SPTE when try_cmpxchg64() fails.
> 
> Consider there are 3 vCPUs trying to accept the same GFN, and they all reach
> __tdp_mmu_set_spte_atomic() simultaneously.  Assuming vCPU1 does the 
> 
> 	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
>  		return -EBUSY;
> 
> .. successfully in set_external_spte_present(), then vCPU2 will fail on the
> try_cmpxchg64(), but this will cause iter->old_spte to be updated to
> FROZEN_SPTE.
> 
> Then when vCPU3 enters __tdp_mmu_set_spte_atomic(), AFAICT the WARNING will
> be triggered due to is_frozen_spte(iter->old_spte) will now return true.

The failed caller needs to check "if (is_frozen_spte(iter.old_spte))" before
retrying, as in kvm_tdp_mmu_map()?
 
> Or did I miss anything?
> 
> Also, AFAICT this issue doesn't exist for non-TDX case because there's no
> case tdp_mmu_set_spte_atomic() is called to set new_spte as FROZEN_SPTE in
> such case.

