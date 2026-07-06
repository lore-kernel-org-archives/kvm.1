Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B494378D7F;
	Mon,  6 Jul 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329491; cv=fail; b=HNZxGnXlnSAQi1Dmv2Y2/CF56XQyz7F1EBBeiZtKoj3dTBafMx/UK/ZFkY26Aa/E9uMDsG99OhKzzlYjJNifmJuJmSnW29mif0BokWmQUkREnA9f90SXEz4e6Yyl9L/k5tqve9B7bi2GUjtaBuYE7hPfyVyF8TrqL4aUmA/luKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329491; c=relaxed/simple;
	bh=oI3AezEfq/LXkz2l95ySAOqWmS0wS0/zkHqD8aBn964=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Eq/AfD1LMFIGs+Wp0BNQ4Edyb2TyLYr+kqmeRhWx5ljJeSZGY+OrilC1OO2SHQYewEG9sGfLNji5YjT66vwmU1/uZxLod3BdlXUMUGyO7yhrUH5cHSwmXqXtINaAhtERKpTcr465C6Jr+eEcYmsxyqSMPst0G76VUf/V7ZkRpMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oz7vq2xM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oz7vq2xM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783329489; x=1814865489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oI3AezEfq/LXkz2l95ySAOqWmS0wS0/zkHqD8aBn964=;
  b=Oz7vq2xMq0uQiA8bfoYLmrkBDSsDMq8CwHd4vcOdkx8FsZghaXm5QiC3
   DTX7+OuF4dzddVk3LENyUB8IcPyeCRfQT9jzDjsHRWO4IW+BDR4qxqudu
   +wCGkeJiC2lbQEKdRi7/KOLVpBLBqH7akVqEXJo8l/cxijESM2sVtfrdn
   jmvDG5TPhk2qcJmawngMRG9Xeh1U4ClsisQKaQ8ZvZg0PZbsjztrjdqJU
   Itm4T2YLG3nTQ9qVBAWKRIxlctc5lXkXY6WIkTTRxc3YDmD4YGTR9p+NH
   4dF7bfPbexhC/v45/gg+tvMpwO3f9SHAJhd+jzQNS1nzbk5lXMaivchju
   Q==;
X-CSE-ConnectionGUID: xc0ISoe1RRiILRHcP8FQMA==
X-CSE-MsgGUID: JFHY0KO/QOyCBABLLl2Kog==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="109502392"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="109502392"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:18:08 -0700
X-CSE-ConnectionGUID: kH1lte9AQ72Vw47WDsno3A==
X-CSE-MsgGUID: 6DFK4qdnTE2IbOPpAspElA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="254309184"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:18:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:18:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 02:18:07 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs24BiGAqty0SrU54JK3k7zgH9mxKu843ySXvCVAMZd53LJuHjGBpApTrTN/9bS/WmEnr51/frz2RaZ0jMh8lhUCIa9qpyIVOu8P7EefDTHWGtzgpLsUf9BncTdh7gyTf30JXxtUN/5K5TiJOSuLOepb1ezx8BDTCDAWsX6DHzXeOpkm704+yEVt9KdTqvQmvjVxmnhh+NOW8LmM+UXB7hqqSJjRlmJsefsc012QkoPHSBw8h9ERTyZtHIlbNnSMxMS9qujXOKbUAD4MIPz216FoMN3bl1F+kjpMkAseure34Q0SjtJvasVRn4D4tRsoJmMY2iSJZA8gR51vyKVs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT0R/9nbwUbTyG/X8zv8ar536YSxL80+3fnjs5/Cqtk=;
 b=ilxxgAgN9ellRXut3S2yTSViVYi+PuO9ety55KUPVavujSSufXfrD2QNXLJvln2AcBDamYwx83L3Gu9jnSmUGR5OEZ0AqTsd2RTxMe2apj79hGeegsW5Lvxa88Osd8bsdk1HTJJphNoVDRT1CLDXnEVbjjv/x7ck/tYL4xwBXrfsVJn08XooCF4L55K6Lq2TKQwaaYT0N4HZivBIicf8/9KR1VPdjQOh75nXsYqjhKwP3ieI1ijvFicrsqXZCz8O6oiLVcaNNPhlLVrW5tilgbgB/lWXnCRw01Fvz9qhS2EG42U788ZTlh9/SCYtVmVgFwBGtgThjQ+Ba/J/FUhX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CY8PR11MB6890.namprd11.prod.outlook.com (2603:10b6:930:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 6 Jul
 2026 09:18:05 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 09:18:04 +0000
Date: Mon, 6 Jul 2026 02:18:03 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <20260706091803.GC2169894@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
 <49728a57-a996-470d-92b7-209a010b4761@intel.com>
 <20260623044411.GB923079@pedri>
 <cdb43316-6535-4f11-9fb0-abdf2adf4568@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cdb43316-6535-4f11-9fb0-abdf2adf4568@intel.com>
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CY8PR11MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 827cffd0-85b3-488c-a1a6-08dedb3f7c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: tVWwZnvmsybVXsbx694TFuEfA3o9zzZoiA6b6z8xnj4/OzFyLIwechvf5N+1sX1wc8Kjg/+VVfhmJRFZIBD13/Dhf3Jp0E/WpInNGvgl+nu1zMmbS7/VlIh4Vdw7hvQiWv7BaGz2Jq88ILntY6PqIHi1aQV49DGhvTPEBSv/r4lNruFaE6kHfgWjLF+Oq3tMkW+bIcciw6H0ha0AyFzXqmzI+bUt8dpDckz1txZBFi9yBtWNEl+0F16dGhqFvVqzcBEhN/hjDApskFmqEoyl/8EV/1ERyiePHoF0sfTE753gpmPpGZykzjYLFwTNsEBcovlGhuLBamaSQ+jPjU6rDOFs7P1mCVnyoPBWxoaBzCe/azjTVCmhYieEi78cEAgAwWrXToXM6Y05YKIB8gnvjmkJ9uSrwYWRFaYutlQhvr7bJBfy+1LTH85CbBlX8Cdl2rVqIzOXKWMsTF7Vuqw2Dgfyy7UsjbKOTSyYhk7CDayOUwQRr4ChrMTwg8549KNPvNnwIPZ8GfIjELKEs/8rlc5E+J/rQQW+GxKEmh6dx13vGA1tqFOVbjEKKXARAJxPKnl3LhEFJorKfkJoyd51ZxguAD5HaLuN4heF+a6Yg/Utaxx9KciiiMKlE+fY4PV3p4EX3qKzDMhhgTIRUCiSZyRBa24kMm8UV+taV4n+PAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UluoWg6jrR19Uwivmf1Te8H6gMIXPMitoOA9qQNv0lxSIWLSQHcG79b6t4CT?=
 =?us-ascii?Q?Xnd98B7dXTwO57rHBkIpo1TNo8LcdW4BrjLrRaU37jVhU5YiA0fXs3vZ8HoN?=
 =?us-ascii?Q?lSC8SkKNMB40G51cL8NAE277nZ5Ll1BLYS4XYfVhLPLtt0g6QeCrpkWjvALg?=
 =?us-ascii?Q?YwsvHBPZEttwhUWh/WDMSNCfhF0jEphEsrShsrRFxWGhb0TlGBpkAq1F2m7N?=
 =?us-ascii?Q?mPi6zjC1AxhSDs6VDx5eSakJGaZ8qCdQflCLWy7JO7G69eO6TtM5YIqJ1uEA?=
 =?us-ascii?Q?4xnJpkzCZoMf0hsay/O42mfKVM2rDhYmnyJckbkOWDH5J2T8zjj6BdRQKGZV?=
 =?us-ascii?Q?02V68OOXUy6Uihnr9wt2zfL3eAuHk/s1YOuEnfEep0uYXSu5ObyLtrckU5VH?=
 =?us-ascii?Q?kjvhE8TIrw1fvH8lEg8jzc1wVP3xEA3do9rinW7Ow+scVgyacRWSivkjGMEp?=
 =?us-ascii?Q?iH2CiR+2V61sWv+idKF5fGV93A+NQr17B76OktM2jl06GZxPgV051B/5eJl/?=
 =?us-ascii?Q?8iQWOWDxcjPRUWSWc59+yDXzffz+dXeoRjwvUPcZ0tBhCoF6F2KXgS04XZ74?=
 =?us-ascii?Q?e3D0/4Si+T3CgMkGOOikitS7lE1lqYN8v2B7IEnjOxmahZdr0oiQbuit+WqI?=
 =?us-ascii?Q?wPxW5NERVkhGJv8lhSAI5/Vm9ak/H5/89G2kMmNRWk0o/NXHfmSioHF+8Ahg?=
 =?us-ascii?Q?MnQgafKnoEMDS+etjsjm/1OkaeLhaidP65UUn9xfMNxbG2uCv5mRiH9j4zIU?=
 =?us-ascii?Q?nxAY8VNVKpms+qFsIlBvNyXeR7vC3m96XfOit1qXiAhYYPlmnf8g/AHGxB1G?=
 =?us-ascii?Q?xo2/v+ESoqgxVCPhA8pe9RWiIEag3e5vDns7nwL9bfQM0q14+09zVqFOZjfk?=
 =?us-ascii?Q?Dt8WcMUwj/veVrQ+TXMUL85HqjW50mJxMTqq57svLM+94z0dV/xs4z5fbXCx?=
 =?us-ascii?Q?5I2nEZEhqwfyWeHN4Tl9qQ3ljih8c6PqOdiHHIeLAQ5dt8y9XP+lhAukVGbH?=
 =?us-ascii?Q?C6JyQwNt0W+mDjtoGt55eu9qXv7jGEaPNXjcZrMEW1wBVyodvWnnDmpenS4C?=
 =?us-ascii?Q?d3fSkq9JUadjtsyGlpsXpxI3pq1YS9FS/bK2mpte0ohPHHzbd1jy9l5nxfnc?=
 =?us-ascii?Q?YHRAaFyKNwv9Cv7HpSHZkQPNy1/g4Ei8Nga1KOLidK/Y+yZIlqah9ZcX2E4b?=
 =?us-ascii?Q?T1+/6RAgeh+Xj+L+yRXbTEmN+AgeM1Kp4ShxqLjxxjyBuKbMNKt1iA3bnl3a?=
 =?us-ascii?Q?34Gv2ntc5AQYYzcOPLdkfWvorkLSrlCmu+yzBTCBhba8od4sNBdaufUx62+n?=
 =?us-ascii?Q?Whj2J03eyO2RKYeVEUWqcsOfQdSEdxBw4C42nMfY/jvUSFnfuB07p5WjjyKB?=
 =?us-ascii?Q?CLd11VWCl/nJOXnd2jIP9WGD1lOejP3sO3KjuvsEq37CVZwCppTf7q4kM29Y?=
 =?us-ascii?Q?L1NQMZMUPZRfHilL66vCpz8UD3AyYfJQbc8QBfw528eLCRPtQHN/C6nAuzXS?=
 =?us-ascii?Q?+lxmEvbnLg3oisjYk9owxRtFB2dzgis7C2/jVC/flIM/xqCyaadBKnI+WXKP?=
 =?us-ascii?Q?942d0fJKCSph7R0crA9BTQpMTqSb259PvDa2kjmfC76QCNE7s/B4NgHR25Ab?=
 =?us-ascii?Q?UiRbV8uiYNVGzTfUV+5YtTVjkhpdVPIgXQWxZpumOBv25aqUekKMaOtGwzOX?=
 =?us-ascii?Q?d9SR9OYQMMGDxBOVbvkyjMKw5yyezsuRC2I3xAEhYo/EO1mH8FnvFU8crWcp?=
 =?us-ascii?Q?4NDdIgrnUQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: FoIVa5GRtbE1OQzV1eBD6MVM3s6Md1GvseGZLhK8zoBhyH3L1XxJRft/u4q3P4OYzC+kUeAbhxAQD3oQHe/wZFdjM5yiwbYtmHtAyDZPGegKFoGVwq1cR0cBvs/u7tW0E+24QN8hYFhC8wjiZuEwVylEpf8zLOZVPpCCps0fcF4ln0pA8x/TA0mKaNRCkF0NN/DARzsei4Dw1nI4llaLRMfkSTg31pad/Kh5ucQAGs5SN7b8goM04W5cHOZGbIjPYXexTZw4bugkfkMoqFB5kFfh4yo2eFaRgw02XShdNFWjokphVIKtT7/9EizyfGz7bzEhIZN5nTHRFCmdoqEH4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 827cffd0-85b3-488c-a1a6-08dedb3f7c3c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:18:04.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnrqgFXv7nK7IAwCIRMVgkmI2vfV0ZSADjovnr5LeAmqvKZRR/lx1VehE6tjdpe+w2OVeEyYZpF2VBW5Ro0p/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6890
X-OriginatorOrg: intel.com

On Thu, Jul 02, 2026 at 06:16:21PM +0800, Xiaoyao Li wrote:
> > > 
> > > I have another nit other than Kiryl's
> > > 
> > > > +u32 tdx_get_max_quote_size(void)
> > > > +{
> > > > +	u64 val, ret;
> > > > +
> > > > +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> > > > +
> > > > +	return ret ? 0 : (u32)val;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
> > > 
> > > Do we need to start to use
> > > 
> > > EXPORT_SYMBOL_FOR_MODULES(tdx_get_max_quote_size, "tdx-guest") ?
> > > 
> > 
> > This makes sense. But can we use a follow-up patch to improve this file
> > later? Right now there are only EXPORT_SYMBOL_GPL() usages, so using
> > EXPORT_SYMBOL_FOR_MODULES() here might look inconsistent.
> 
> If maintainers is going to merge the series as-is, then fine.
> 
> If we will have a v2, I don't see why cannot update to use
> EXPORT_SYMBOL_FOR_MODULES().
> 
> The existing ones can be updated in a separate patch before or after.

Thanks. I will respin a v2 to address some review feedback. But I'd like
to hold off on this improvement unless there's a strong push to do it
right now. I'm going to add this to my list of guest-side cleanup items
for after this series, along with the feedback I got in [1].

[1] https://lore.kernel.org/linux-coco/5f9474ed-bacb-44d5-a0fc-5a29a1e79b60@intel.com/
