Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396653BED32;
	Sat, 10 Oct 2026 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609265; cv=fail; b=I+6yrBMXNadIpu3OONIdh6CAfsZr4FXxqiP/BNppBN2hDwLZnMzqdAMS7Nlkf8+sSRtHDjOzuDrhvVWkEpZrRgcaxOPZJBwah3lGIkd/rgJYMLSZgclJCgKqJUcjnXjzlkD8ZPrOdxYtQYQYmOBW5jCPNzAmlte7zZZndsQjekM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609265; c=relaxed/simple;
	bh=ac34U44tVIyIbzs1mO2wlx/kBVW0x39FVzsaMfY/+hA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DdtHtntuDke40F/deospSCM+940ZLirpTONidHo9QzNbmAYrA0lcRgukQoUOfVq+CyzuqUlbl0hYe+PQRQz+jzFuKoDIA/W4iNf+mf0Gi9XHKAtgWK4WffRlUWh44rV+TdtFAkAbgNAMuxItwy3P3MnJCWpC9leJzk/TYFcc0ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQrtZnZh; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQrtZnZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791609264; x=1823145264;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ac34U44tVIyIbzs1mO2wlx/kBVW0x39FVzsaMfY/+hA=;
  b=OQrtZnZhZLo8O1cKdpB9IIMkJTM0zQ4B1qhi+AZS8U99gDuoBCjRHoDD
   /kINv56kfIrYG/9L6vL2TdbyVLVScOl4+iq1Zt6+Ch7hkDV8vZiY7687N
   f/kUimrP56oCdNc/fDjmXXlALKmQJuifeVxQqzkbsl2hxTS1WqPeMNRqu
   9vkQ6qQiguGR8zg+0i+cJsh3T7RbJ67a1GowCqERDAyG8Z1n564iagfMF
   4vpfur3oho/rKPJVgwUbrLN/onieEV5F1ahpoWiY5RgSumhYthVhmw2KS
   XWyknO49FqrmsJmHChcOEdEocrwiyhuQEVZ6t3YHhsXiWad67GSWpMWPQ
   w==;
X-CSE-ConnectionGUID: uOuGn+E+T/6pRiIj07a/Dw==
X-CSE-MsgGUID: 2RjQmtTwRbKSDKom9VFq9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="398928"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="398928"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:14:23 -0700
X-CSE-ConnectionGUID: lbkkj7mYS4+86U9WWvzNqw==
X-CSE-MsgGUID: s2dAuFqvSj+fCtnY5aXaqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="474238"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:14:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 22:14:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 22:14:21 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 22:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9XXI5Igj9vkr8ajV+weNcoLafrgEpRGHtQn44L/wiS/9Nh63Del6+vl1i7C82KgZ9/o60JWI/N5GHt0a/GPdojYNpamjbEo9QbsimESgMw6QwAFRlKZrWCqle6xc8RVC0YXNerioRZ3iprVrC0KYX6eAFEAL7AglQwN4sZgJyoC4AljnKJ+yGH28eiY81SofTFKbNArrZ61COV+eBFeojDOLbBbAh00X2feltI4wFujSnb2SGuDdnEoUzrNkPNFrOzi9kg1sgaJwFKe/N+I44t1hYJZ2o28vjlLX13h/5rVk46efXTC8YvZ/gI/IJ0IeogLPgblgn+oYWQPkHilFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IxXoIhIgRkGnDNY2cNMztXgI/+wupGMYQFzUx/5UdQ=;
 b=UkBupSi8S34uIwe7ZVZZvmE/cwgZHIh+mRg1KDZPoMsOrSDn7Lu6R5T1zIeEkHfl3Hlhdvj49BV6ih49Px9530TxtrcFRfHmZLKZrHkwSmaE01VqF1Pf8moENgC4Sw45LPKuNRFiY0h67zd3wdzJgYI135uFJtrB6MieKQ6gnVmyENpklyRvlG8aYva2P6H/BqcN7kZr5iPk2js8aiiDpQAv6rC8vjeqaLVlSBBEtptBSQqN0+scBiLBpv7BBYCH9l0/RuBDdHz9q94bjgq87ewNliaXSjdPhlAxBNLytumLz/OoUeAVn9mGQqcN3kWiGAKFfXQB/VcYdWnjYlWZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.18; Sat, 10 Oct 2026 05:14:11 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 05:14:11 +0000
Date: Sat, 10 Oct 2026 13:13:21 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091035.15599-1-yan.y.zhao@intel.com>
 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To DM6PR11MB3243.namprd11.prod.outlook.com
 (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|MW4PR11MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 686d010f-9add-4934-4079-08df268d5171
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nsZrdw0bDerou8Z+H857QTnCvflKuuwkMJTmqghbxB/zvluxOspjfqDgC3dk5vMbm+Uec15FkV84gJU2qDUO071AscjC6mc1Eq8WHhxu6vIyIFCWmjmX2jGVSQLmGYlEAN+xR1XBtjWR5uc3xgrnHjZYaffFu+S8P/C6vCq2ALAiKGdpFncviBHs0nxVdkSb2Lp5aMHfYn4M8sBHC1FE2PxEBngn+nGC6TehsEEDrQ8ThcFjeu0jMwjCS+Lbt20T8Ngn55T9hOSi7pBvM5tbFivsj1nF18u51LRb4fgzoRziDQqG0C7SvDlV16WxCbPP0n8DFB/huZAhwA152ctrH6YiYpMd+nYbc9v74AXwz/OyB03hQd3awfEDJFnCUm4PocTfMFqZDrx2aBhTe8xHBfrNYzBUWdnaUKHHVxF7vi3zLIawBG5lZ2zk/X60j0p4HbO1kCKmiKMgoha7hd2NtVIWWnVu+bFCTPTamwPr7vLYTdQoO/g7up3RVOleAab/+XyyRasQ1uwg1JuQSde6TC/R64VZEsTtUFWrCcvHcelKjLtut3wA4YnIUuh9akalq7tgcDNiD/8BKIw7Yhpof6FPR+9we5u3vi6yzoXEziIpQq/jUmbr7WPXqGsoqnqD5o18J/v3lQJZONBhMSUpT2kJSNH2R9sWoHdIevVsUIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fvq6B9yXsUMkiRbnXiXGj+R8GELafhSCRYn40obFb+Uaz1AtfyOO/TCWoCOk?=
 =?us-ascii?Q?DmOes8vBhFC5WZW9+zMTpDvHdiJ+DsFOLo6Rs3uRzCSmVu6ftMlt2d+t/SXu?=
 =?us-ascii?Q?hBOYKf19BovseEtKTlEkslq3eHNRdHpgMKPY6/n6yk3BE6PuFz4Tmhw8pKGj?=
 =?us-ascii?Q?YY6yWlauzk6UPIq4fUAcNywc6a7KzhliT0LNhg+Uopr3uQPhPciMX8ueq1KA?=
 =?us-ascii?Q?E84tHqzlLhVopeM2POB3S1Ngeror0owSiE8JGrOV/b1mSlk07fviDFXWdM62?=
 =?us-ascii?Q?RVpUdC3uxiM5nXEM8lGt8nOnkN1oYFeOcq6PIuxvKc3W+jMdpW8xGPvVKMWi?=
 =?us-ascii?Q?/jdugMgLSBBaJiB45Hc4tcj76Vq5jS6zoXgEBOZ97QIPXOZLBIdzHnS1rFPh?=
 =?us-ascii?Q?aVz7NLEYXpWFIFexAVS6+dOn2aP4a+6XrSvP/+qjNbkDzdFetT4BDRZk1lhe?=
 =?us-ascii?Q?yaTCXMe94AXQVDC9whd4pptEbWK+nd3skgeiJgpfECwzY1XVRLjvqnlh/fcd?=
 =?us-ascii?Q?1zF7mA+2icPOsV+ZxaaxQRGcWnXk57VmVlaiuc6hjlHDHvBNGa8c2SuUSArU?=
 =?us-ascii?Q?z1e7u9gZISix6c5tSMYoKxJuAavVMfHjMqNlYeJ/9CXhaYdYhoTshye5Z8PJ?=
 =?us-ascii?Q?eBdBVqKP5548kBu5ED6RcXFzzLyhhAzkr58gBF6/LyWzb/hS4/r0L9ktOFKK?=
 =?us-ascii?Q?UUFOONfGJoSWokgnTfiEUZA2LqV1zwiPPQW+kcd/seItW8nM7MrG5JBfdJXr?=
 =?us-ascii?Q?FN2C3unfCqeYhI+1B4sqWRVBVSSeACKHK5EXOyGj1y5kjJLbU0hNMn7PhNFv?=
 =?us-ascii?Q?DD+Z3KLmmBLc/bFlTarCFY5Q1u9V8JBIgcdKWV2KTRkalzF6tNjORGn0Z9sM?=
 =?us-ascii?Q?uubYtNKzG8MobDJKMYrv39HiWjdjTXpOo+6RTVtvjrdx1FJ/GqNIeZ6JbDY8?=
 =?us-ascii?Q?ttCJwM6bxoNmmo8MfD5hGpR515gRFK+rlpVqW3CAWlSHtTWdAhV8gx/pklR9?=
 =?us-ascii?Q?VWoH4ggsmKY0pWG1Ym1RvcQxL52XJzSX+qIe5KLLI/ZMjwp134wp8eqfeiTk?=
 =?us-ascii?Q?gPRfUQKPfZQYcFmRCXc0iFaCJ9BCpx4CVEr6XmYO4yiQ57ZbUi0NQ0BfkHHe?=
 =?us-ascii?Q?6o9AJI9vrUFyu4G4NrdgQl1h35aAEMFZZHD0RA5l0KD7BwpJvSs1A8Hp/ck8?=
 =?us-ascii?Q?CuqsEl5xXrOMrlfhi+XjGvIJma/7gGbVnKHhzMEV7K6xVfK4kHFAfA88D8MP?=
 =?us-ascii?Q?DKelVthz9Tv+j/VItNWUy2ibU6gl/eUzn6AFTVcM1M2BJYrj5d5rj2UY0483?=
 =?us-ascii?Q?ctDlOu/oYQxKQRhdp4dpcJ+30YMZzUsHGtZACdKbxVc+Edipq5oX+M+Z9z2x?=
 =?us-ascii?Q?jm7kBCcvUeb8UGLYM1L5KDfDVImk7+kNEEidQo7ZcjHT9ULINO2Rl2NcjBo0?=
 =?us-ascii?Q?mzTb3d0sALqU63cJrud11KXQPcOQviWsBWu0krq4lcw0/j9Y/FLY9sAtpw3f?=
 =?us-ascii?Q?hvJ4vCR2IMr5QZPCFtRH68Njgu+OeQcfddhpM0li9MrmcSVfxnPedZ4aq1+t?=
 =?us-ascii?Q?oQot9NxFxpNm4jeuP/rac/fYqRuf4tjq66JmLfeM9udzG+g3D58kVl81vHB7?=
 =?us-ascii?Q?zvrIPc9Jf5oYp/UAHzDZSLDTjrJfYNFqOnp3zJE5i2YYbJugekjaZqOQM5A7?=
 =?us-ascii?Q?jK+TbW6Azw88llbqC4jGq75qMtc7gjJxf5QkbjtQHstZV2v1p1XItYSd/+4/?=
 =?us-ascii?Q?R5wkSko2XA=3D=3D?=
X-Exchange-RoutingPolicyChecked: FhuEyH/QpcJAVVVBhxYOrK2nYDCTLrrTc5pEAMcmLCYD6wRqv1vrx2ZZqbuAplSyNaNlTmIT+Iek0JORKXfev+RuQhpJwgPQAV1Chv5/PJgccESqCU3ksDZ5RPbW7jS9usu47Cv7i3Gccf3oo5w1Z8MbBN74g4okzAWsgQxNkUTKhkDEJbvgrwWnx6tflgBl0lojvU88VVwixuS6AVSrbb95tBwaRRrbi4Lqk25Tb03HPKfojduZd0fnQEfuX+WxowrK/25Nun8CAynJ0ddZYHyEE+5/5F7NdnLIApXXHdV6O6AQHwswDB+VytUPhPcr9CNOWuptd/qS6/0fgmU8jA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 686d010f-9add-4934-4079-08df268d5171
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 05:14:11.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8Afv5ls2OKMcxNZoh+Blqzi9o7qs9QwCt8k+fnfspSZjc08D8yJOYiob0lq8HqnAEHs00q2LSAPjiGvr23yIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com

On Sat, Oct 10, 2026 at 06:12:19AM +0800, Edgecombe, Rick P wrote:
> On Fri, 2026-10-09 at 17:08 +0800, Yan Zhao wrote:
> > On Thu, Oct 08, 2026 at 09:16:12AM +0800, Edgecombe, Rick P wrote:
> > > On Wed, 2026-10-07 at 15:47 -0700, Rick Edgecombe wrote:
> > > > Another idea, change the op to be:
> > > > int topup_external_cache(struct kvm_vcpu *vcpu, bool root, bool private_page,
> > > > int min_nr_spts);
> > > > 
> > > > Normal topup can set:
> > > > root=true
> > > > private_page=true
> > > > min_nr_spts = PT64_ROOT_MAX_LEVEL - 1
> > > > 
> > > > Then we can calculate exactly what we need. And even better, the existing code
> > > > won't nee a comment to explain the weirdness.
> > > 
> > > Actually since this gets a struct kvm arg later in the series, maybe we could
> > > just have two ops. One for topping up from a fault and another for a split.
> > Hmm, no? That would make the min_nr_spts arg meaningless.
> > Reusing the topping up op for the fault also scales better, e.g., it could
> > support splitting under the fault path in the future.
> 
> I don't see how min_nr_spts is meaningless. What do you mean?
> 
> Let me spell it out a bit more. For a fault it would have math like this:
> 
> int topup(bool root, bool private_page, int nr_extra_spts)
> {
> 	add_to_cache(private_page + nr_extra_spts)
> }
> 
> For fault:
> topup(true, true, PT64_ROOT_MAX_LEVEL - 1)
> 
> For split:
> topup(false, false, 1)
Hmm, having the caller perform the -1 calculation gives me some hesitation.
The meaning of nr_extra_spts is not straightforward, though it seems to mean the
number of spts excluding the root.

private_page arg should be unnecessary, since the split path also needs to
allocate DPAMT pages for the guest private page.

> Why have root as a separate arg even though it is never used? Because it makes
> the logic make sense from code KVM.
What about:

int topup(bool has_root, int nr_spts)
{
 	add_to_cache(nr_spts + (has_root ? -1 : 0) + 1);
}

For fault:
topup(true, PT64_ROOT_MAX_LEVEL)

For split:
topup(false, 1)

> > Besides, I actually introduced a separate cache and op for split in v3,
> > https://lore.kernel.org/all/20260106102345.25261-1-yan.y.zhao@intel.com.
> > Sean merged the cache/op for split with the cache/op for fault in
> > DPAMT+Hugepage v5.
> 
> Yea, but he didn't have any big assumptions in it like this. It was way simpler.
Since the re-insertion solution looks good to you, it should be not be too
complex now :)

Given that the fault path theoretically also needs to address the root-only -1
calculation issue, having split and fault share the same op seems reasonable?
