Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415B38550C;
	Wed, 18 Mar 2026 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824267; cv=fail; b=ERCluAmc5uLeoIJknNFI/UtL3tUFB+CirD7nRxQltR55QE+r1kUBjCKbeo5/+KPT2TLviDoKp6IebJ+XFDuSRLuviDx9E/imC0F/RgJ3/x7Drvdcp7jtxZHid+mN5hV5iCJI+JqU+f+OhIuixIdaKJNrT2O2Swv0/m7QrF2h6HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824267; c=relaxed/simple;
	bh=gZjj6Ju5eYta5Le0c9YtsgirKLTWQIAPNRxabUB463w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=llgIGk8FiwznsCMezfiptXbiEic1L01pVnbaCdRF83NisoY8fvjwhnjieIs1jR9qGREHVMLEifJuZz/u1n/JSJPRSNOMpU+PEH+FGpdMHPMtzbHAcKd9W9q0GK1a8gka/MWKDk/db7ERnAiVL1K+WHqVJvh9KZItsO/FA40PXk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBqqEoUn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBqqEoUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773824265; x=1805360265;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gZjj6Ju5eYta5Le0c9YtsgirKLTWQIAPNRxabUB463w=;
  b=QBqqEoUn4cQQzJk8NT/ijcQ1E9x9cej+D7yv3aNxCraIwc75RLrjFZdr
   RoshkSp2NL7S9BJf1NyGHWPHLPIetZzT/x3DXrZM1xCcgBSLwFMhZmvc+
   fYngmTPH4OhMHDmLfr8xaCVWdufxum7cTMMV6RwKDzOeuQ+5ieq2e/Iw/
   ZuI+SeQjcHdLUkWNxaSZE+Mi2TVrwQSv7+IAMWLQyUTvzH7U1JHKerfEZ
   dcbmbFsoAcdhU9orrtnWFKbej/5gGxbeKK8G1ktAiGpy5sk77SzaRfKf/
   ebZjYM2RNtThu2xsRbP/FjDaUhKI+RTMaVRh5SwCEx8JXDOxlsRbdOnl0
   w==;
X-CSE-ConnectionGUID: Q1E8CdMYRvGZwMRIQXvIyA==
X-CSE-MsgGUID: E/DIpj4fSSm7cet0hgB7PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92442314"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92442314"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:57:38 -0700
X-CSE-ConnectionGUID: sQVxdHj7SuO3GeOTLoFIqg==
X-CSE-MsgGUID: WRRtJQGoS6yvwhV0682tHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227027527"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:57:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:57:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 01:57:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:57:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEUvpv4H08VzCvAEAXIVFsBQ8GupTZREf323/8DBeFnBYW7BKw2QL481yYo8ROzmRvWyfPCYDsMkJPiOvp8jS7to5mJvDnhGL97hspXCTFA8O98m2USlxMOMSchqbUoRcZwsJTrhc1WeMOiB1xXCvOWHHlKs0+6W1Qgtgrxrg08A8uVpflKp+ceEBHadnUjzPWRxxACMZxnltLOV9gobkrstUMmOo1ZrH4R2NLhdPaY1JtG77gYZ4zccXMVZkwvpQosl/YjlStACAfNPK8PyH/HhJ8+xcUBS40XamufqpkUFuQdrNg83t0Wwrf9b0gUjgTfM+DW9zU22CFQR2FbuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmwhnkemvo198sLN5L6J0AXk/qUY9rGsz16OEXfTAwg=;
 b=cijKabZgQDpPBI/p+J8M7eLLAoRV2TBnmdqMLUjOz0pDZHE7tZPEss13zT7JYdvszpCOBtCtQ4MJFA8nCadQrfB3Rc7IwAeUPuGQZdK46MZj4r1If53K/XAecrr4vY9TJ4f9Vs3y7wLNYDthJGqfHZWbdiDNoxYrH6R7Sn2i3qAw2vwwDTfjjLNkzxX2BaWks4bANGE2uSPwAL4XEUuFz+maGJH4p6aPd8fS6Ep/hWZa4axUuImO/xeep43cx2r3+DcL4/R3NE7IzJbWos5GRKkHjaSrLRqrnvI7pHZijEV3a3Li8SRMR+yz5xE2M8P6regsZjdJcJXXSrvBe8+jDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB7960.namprd11.prod.outlook.com (2603:10b6:8:fe::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 08:57:27 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:57:27 +0000
Date: Wed, 18 Mar 2026 16:57:11 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, Farrah Chen <farrah.chen@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 05/22] x86/virt/seamldr: Retrieve P-SEAMLDR information
Message-ID: <abpo50gmCs6SePDr@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-6-chao.gao@intel.com>
 <0f5fe0ba-1699-4762-90b0-60fd8bb9c869@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f5fe0ba-1699-4762-90b0-60fd8bb9c869@intel.com>
X-ClientProxiedBy: KU2P306CA0020.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::8) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 551c4f38-777e-4a4d-74bf-08de84cc610c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: D/FONhNIrBUgGNUWCgwP9nI1LMuKGo7lCoXquKVmGmCeOOqtZVoKPN9QHK0n3JM9XdtfM8mrfqPPGDDT78gwSpFNz5xzYkjjTkVvUe7IB7tCbdbXwfswhRzyyM2Li5sGJhJF8NKLUZKLI24ga334jUK7EmsdoBGScp3b1YlSgvJroRVskFMkGlinD1JKgCMxZKBRYjHj6PC+BE8/Lh0vEKJgYKkBnmWrSgZyiM7aa1SMuS9Um6E/BUviPpMxu2bl789rM3PZeZpuQGTd3+GTVXjfNGufUGVmdvgL9vdELAFUMBk4lHz8IFBDz0AZNdDwIRwQGRqFV67DHLd/W0ZSysgky/HBvHvhgP7G3KSyQG+n0fUelWayWZefDGtimhj+pj0S4N09GlgY1KiwR7Hc/oLrN+7+vIaij18C/PbT0SIguiWbv8yQVYdGhplxG6Vl4+pA4RTrAq09PY0znBZEraA29HwK5gvQv8gVmq+2+CLJyGjT7ilv7wksU8TOdK/x7rkhl/W9etdse9kxfLTWtdwPehxrErD2WJMc0AEQ8TR98sezog8Lsdt/f2aYIKOsVCphojXVyrhIrkC4biwIss1Cc8HOKSXh84qjsvS1bP/nHm1EuhksHY+anD05+EQP9fxdTzbj+ukT/DpmgFhOLqkKBXhG0VtafcqWReWNlTFoLNLH3WmdRPLEo+/TM/k0pbxy1HfUouqzKea9jzKooXR+sXD6Q5sSvDZWtd5I9F2IRRN1lGlXi330MbtAKhTu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eMXi8bjT6jLJy1Ofcuk2dLRzt5FUw81aOXLamWvxWD5Bukt/ladA28kjhEp8?=
 =?us-ascii?Q?GtPCsUWn6c4VFtpNcG4he82gj+7KKZnvgmyiq6yo13bwpDFGyqqP537scbZd?=
 =?us-ascii?Q?2ZPocJdWS7kelEsZ10wdNbxi6QPCYw3kqw2UHNiUGtkCehYIIQwpuh6SYfI9?=
 =?us-ascii?Q?con2XT3RJxTpvpgqG9dayFYcPXfpnzGaRkDeQBCS4+jNQ8YHGC6prhOa5xGW?=
 =?us-ascii?Q?SGeDQ6ulAAcWiWt8Y0z1DNSxYN7YvbWUlzRr2qrYyR2cVtf+4DISgdgwrC11?=
 =?us-ascii?Q?g6GM8fOiBMkVmcBFi+JODxfs96D7ng7cN7VOCdpEp48Cb1+cy3apwo+u/jU0?=
 =?us-ascii?Q?xLcfrtLFgc1Nra5658xYL+Sr0YsTDGnpJmDKhMwTw2h7cFRahp4mXpVbEdxC?=
 =?us-ascii?Q?WBa2qG5r/9qbK4FZE46De0z3LQfU4Ju1B+uexshz6hXVxbAuQ1CqREhia2pd?=
 =?us-ascii?Q?wRaT2mB9uERZ6PwNZfNeenir5wSCcT73GWxMgExk6jabmli0RZ0Y72EYoBFs?=
 =?us-ascii?Q?I9jlwbPhx+Khu9JWn3ADAsgCTbxjNwszoQKLTjLoM2AH9poEwMB7JQ27+HDq?=
 =?us-ascii?Q?UViGSGX6hQNtct7JcOGO7WL4V7iv7fa3pK5T28orxWQrwR6OttYHpckWSKS2?=
 =?us-ascii?Q?jSq1q5Qo3BJulUwX0j6kHTUEgPFXguTNMOvwnnt3NmzYqPM5JibAHAL99whY?=
 =?us-ascii?Q?yEgDPP0idJQh29lf9zxSalu7AICkwVr1Bl6viCPrEHj7Wbn+kj1qdEes1gYW?=
 =?us-ascii?Q?NFcx5spWtGf8ijFPY1+OZF+C8IeXegNa9PqsRP9USFDNSegJtdz9TC1aTy71?=
 =?us-ascii?Q?fCcLAiQ5Gi+/TTuWz3x9HjzX/jhUxwCL4Tsziu2yeK0K4w+YhICK89H0HSoo?=
 =?us-ascii?Q?nC+qPG76DaXt/NO1wyOIhoiyJnzc/gOT1/211aaOrSPdL3SikiNMWtr37o2D?=
 =?us-ascii?Q?qroeVFkg2odXqzmkdfbIr8VNDC3YJBMeh35OyYRLWb5mjrLPdZj6fLOGTfQp?=
 =?us-ascii?Q?XPRWLM87jyGtFcFyImBnGkTSQX1lLlsnuASkSd40O5oolCFVe9qABCKjz7qE?=
 =?us-ascii?Q?26AtLoKj8UOvMhz4Q4oIrDMoR55mgDF2cjy+4nFvsP5GWO6PykiLvcOjmV4G?=
 =?us-ascii?Q?9ptfWyT641Ll6q/4UpYz/bm7se9GiCv/n+tv9MYAWk2edlebieEHkeXtkLDG?=
 =?us-ascii?Q?BvzPb4Xt3pT/5E1mJNxB5uYnCLmIMWSsYWx+i0sMrv5N9Wb8kgRIEqbv2z7z?=
 =?us-ascii?Q?S35S9VM3fbkGs8ATwutwVUh5zHG2nz4draGYrcAD5Pt6gyk9U4dMAmEDGwJY?=
 =?us-ascii?Q?vJd+/VLgUQ1Dd1ryjb7AfJVaGv7OxFoZmZ1i4ZRxQU/8oP2MwGt0mYN7AvjM?=
 =?us-ascii?Q?TmmX/ARESm7dcLm/WcAB+JoWu3XHEvgF12+dc5i+XfxiIXIkL77GXsTRKCFo?=
 =?us-ascii?Q?IvxPyuAo3UbaQmypF06AFVwmttkB68hzZMhbF0NKN8BT//aHLyFksIOfGN61?=
 =?us-ascii?Q?unIww3c7vJAxIMxArcqdFKb6YGc8eKyo8p4e1WDjvNuRfNJWbgNxtDdqds2S?=
 =?us-ascii?Q?Kib+BZEFareMO+S5T0Jb2oowNYdaPTtbCtdE+coZvqdY8noGDT6LJ3W31+Hu?=
 =?us-ascii?Q?RTQN5lumHYHZc4nlpmn3ci5d2yEEgmXDokZiFev3qobKLtxUYs7Jy8CcxN4U?=
 =?us-ascii?Q?iGP18/Aim9UB2PTv2cxv96EUlVHvqVWB3T3yaKcremDGaG80En/c4doJet4F?=
 =?us-ascii?Q?6t4a3ULf5w=3D=3D?=
X-Exchange-RoutingPolicyChecked: ugAWqfxuGgtwemHn6uN19XI1UOxnEiqxoOmaMivrXQGfatUQfj2IzRtEgSqXbVm2A6EbTj9AYmdE9zsMDVS7WiXtZZYkCpDkQPT+WIIVX/LXLqofiXEjlAyySwr1dtdvjx+8MVtBeVWf0a7RsOlTGAgBya2u3ALxYzs1gsjUwRz+nQdzm4V0J1OhWPICUQf5VGlmG8nk9KNkOliISEnfCGi8n471V1Q+0ZrFr3M25mPvu9ZjJMG1WU0nltMZrYrc2yRecGw4vM+JDUUmSaLzucjkJuh6iI4Xgvuxl6tHlCowVc/RKdTTwTUHZsphGY/WAWKYhhXEBkzIu0esl3vUaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 551c4f38-777e-4a4d-74bf-08de84cc610c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:57:27.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +supw7PuOAR/FOIOJyVbqAkUjSr4Ut14hLH3whEn+xw02ajO2ZZmk2DpRMlyViI06stzgYKlNe2vI/VAYcvgvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7960
X-OriginatorOrg: intel.com

On Wed, Mar 18, 2026 at 03:53:26PM +0800, Xiaoyao Li wrote:
>On 3/15/2026 9:58 PM, Chao Gao wrote:
>> P-SEAMLDR returns its information such as version number, in response to
>> the SEAMLDR.INFO SEAMCALL.
>> 
>> This information is useful for userspace. For example, the admin can decide
>> which TDX module versions are compatible with the P-SEAMLDR according to
>> the P-SEAMLDR version.
>> 
>> Retrieve P-SEAMLDR information in preparation for exposing P-SEAMLDR
>
>This patch only implements the function but nowhere calls it. Please adjust
>the wording and the PATCH subject.

How about:

	Add a helper to retrieve ...?

>
>...
>
>> +
>> +/*
>> + * This is called the "SEAMLDR_INFO" data structure and is defined
>
>I'm curious why you changed "This called" to "This is called" in this v5. In
>v4[1] you just used what Dave provided to v3[2]

I ran the patches through Copilot before posting, and it flagged "This called"
as a typo, so I fixed it.

>
>[1] https://lore.kernel.org/kvm/20260212143606.534586-6-chao.gao@intel.com/
>[2]
>https://lore.kernel.org/all/b2e2fd5e-8aff-4eda-a648-9ae9f8234d25@intel.com/
