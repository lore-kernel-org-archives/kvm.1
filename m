Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E38242D6A;
	Tue, 31 Mar 2026 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774924469; cv=fail; b=n05DL/Fn6rmOLu+HM66H8Ikns12j7c3ytRXVwnSodZ3hhOG9h3o60tEjL73g7qL12nPEOJKvHB3Qk9KnvCWox73eFTj+ZfpY/ho/ovKYS61emcpboNzd/BuCJapiWINIHFVM73ML4ipI+EYH2jbJukm7lpYsOhIKXVJ28XKS0bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774924469; c=relaxed/simple;
	bh=sSYRUI0JlCKgCKbq1VUVBnimq5jH7611QL8oWKSqJM8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gh8IbGOSPH/4HeWl+jz7zBTq3Y+SN0kfwvMPquN83aZrtJsk8HhI16F+zpYE1EKn4NOWeNQfJWM9ckKOb/vsfK6j3Edk7jzu7/xunh8xG1B7PWyg/1l9h7VtLYWo8hi1/HdFZ6vKe5Yf2wWd3qCNy39Tek3fJ6W02AqgrJUX+e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ycorxaqf; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ycorxaqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774924468; x=1806460468;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sSYRUI0JlCKgCKbq1VUVBnimq5jH7611QL8oWKSqJM8=;
  b=Ycorxaqf4Qmo7ceo4NmiLC2/qtVP1znIDHvdzmixAzjj/il80zwX5I3F
   +ecm/u/HmE3OcHGJglj69+7ZuXhyoc10ageIaCgC1IZLZshT0R0Z2aDG1
   846Z7253oeKWjSJFFU4QAOI50JVYUup4EOHc4vzk3SXaVdtVtXmZ4rtWy
   r4vs8dWnaxql5Xorhis/hGzh7l20/UxFqJKyN7rhD+S/jzazqXgJtb2MP
   AsLgWauxcZOQSG7Kg7V1wlySeVHmh2LYyFLqPDw8qdnLk9JllDooTKLBK
   93EKUQ/w/pbQs95CZ1QZ89sCEyTBxWuqVny93WIuhKXOdfUFxCZncfhYE
   A==;
X-CSE-ConnectionGUID: bN9wpD/OSD6GLhfecsz1BA==
X-CSE-MsgGUID: 1AmH0wtJS46n6PgsVLGy9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78520839"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="78520839"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 19:34:24 -0700
X-CSE-ConnectionGUID: fbsWTGL6RUa+DQP/HFtwXw==
X-CSE-MsgGUID: 0ZY2M4F2TC+NUm39+1QraA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231153495"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 19:34:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 19:34:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 19:34:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 19:34:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeI9lHPEOg+a+s1G87IrEHgXoEKGLzCG90T94VWFx+316JBuFadqEZ24CEJYi0HiXCy9dXlAQzYeqeWKtYdel1yc6OT3MxXU11LUiSKwEGL13DX+skBvpDdHCvGRwHD/1tzXQYTTPnIxopvfSRgwxH3ofmADUWeMltpUs692Zu8bRAWZ/OaNWuu2C3Rrv4E+g4HbypqiEqbjskYfDzQtmULaye5PYJ77gvLPrb+l15HQG5Jve3JkBiPo8emmrLYOwpF61hCh9gN99xbK24uO/pWeq4jzGU/oJQa5tAkQe4U5rj3afLFYJkiE6AIW+cw2ZS4jjBRbXJkVFGgUXHw/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTSVrnqN2SRzsFQeDnk1tsI2ZxxauTsBQl7qPx21Glo=;
 b=RDF8mI6MiJ1vCS7l1I3iBBjcvG56HJx0mmidqLGEuGeSAvAq+uVLz8GUygx+ffrKuZUdFHMKwRhM2GUF+vMC10xMRjL7zdHS4qagyElxFsJ7WttohpCZ8p/+c9BLI2qT1bOsPYRRgtYcB5WJd4Fm2gLDMV1mvfFWghTCXM9Zkk8bS4EwswMsHyUbd7j9gqwqA70pW0CI2ErbZPHtsh+iT2yyk1EPhoO0Ib51AYn9lmqCuYyorNY5zRCKUZTT7ME8LtHXN9Ex/4LT1Bc8nKG6hMQSVr5OEHT74K/2dq9UYLPWlWszNhlrD0aA/ACUwWNzXA6qxanANGOEiCe74kJhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 02:34:19 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:34:19 +0000
Date: Tue, 31 Mar 2026 10:34:04 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Message-ID: <acsynOGSc5FBiI0R@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-18-chao.gao@intel.com>
 <acp1YAMOCiKpcZaz@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acp1YAMOCiKpcZaz@thinkstation>
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM3PR11MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a82694-abe8-4781-1b9a-08de8ece02a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pkJgiS12Q8xlk24/iOk0z0E2onnHGOwT53CG3JyuwKg4hYB/u/I548sEpXsJnmTaG8OYvrwbC2TvPrDlPC/+Cp1nzPkuJTwUab5Tb0hbW0FP1gEMIPvcOgVlGAohveOGALJ02H7UrSEd+y3btTo0hRLiR7ciQe6q7oDDVOkmxvI8tmTQLtvFz17Wdh1mDw1EzbD0vkEYYgFuiUvD6tzeoO2EGdIUe0Pexm1ckEJii/Xrt6NRefROpHyY9gb86C0eaJiz/gyPffbkB0tqGbaY5+hrNvg+Ub+G1vLJOgjCdl/uQD+NxDsB1vMTRIMTYVniPUuvpLvzsbNYpBo+hKLXLNJQb6VfP5gXD00b4+1Z/q+2d8m3ycFj4r5XBb29yFI6/TpYF2KJVnn78gssvJro/Ha6FjiJ7eQ1VkAkb1YzO1vTan7cvmQ6xwdyAgfy0XmtkkufR3JJ23Q4s1i/Tgn25co1jdhpOm2RDHzJIW9DfCIM+3g6KTmDm6kLcT+7r0mkULZ5v+MOnflhZcuOT+6H/BU8l7MxJOeAK/SqXDkTYaCCrr75pNHCzA3z8tKw8e7udi/g4Pibd4lvSYGkhYImmWZgXBWA9UzjPDGpJw1EN4p4elXpuYmkpefz0PUpq1LXKGgx082EmPBSU4T4gwdn7EqM2qR8QhmaA97h+UrGAEtSwaOO/+9FNL+BxlV0UaAKQoS8qzWgvhqnj/D0GVqzp340oGMcOGBH2zLjVpWN3po=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/voYmrV7zqK7JyBI8lpshfCfzlL3G+67LM518TC59zrY4iji31IlQCeJbac?=
 =?us-ascii?Q?d33j0rt5tJOZ+AVaPKJ9cZhqX1uhOt+0BJhNpnF6v0oECcL6550ETnTsrGZ5?=
 =?us-ascii?Q?UYvVFwBzNKVnW2RFAXOhIUHNGoXDQfihR5OI7A7HiCRBco7lCpavreRlhEa5?=
 =?us-ascii?Q?4/OtVkIw5+iXprPJuhtornbdLONC8FlO+OOtvXYmILH1ta1NtYdDmr+7LKNi?=
 =?us-ascii?Q?+1lQJR8vrCpvhW14DVBItcbmVnCnacAxY04X7WQjdL07a3UuheyWgWk0Luz/?=
 =?us-ascii?Q?W0tZEq0FjwxR3XEZ1y7jiyny6G0WUk9W9a+tkq4sM2m9enrkFB32U/Fjp4gG?=
 =?us-ascii?Q?fxUyg3D6HN0Tim7k9Uajy2JIa/kgn3AdzSb6oGzzDsZoe5l7fNBlqtRAOjJp?=
 =?us-ascii?Q?Yyc8O8WqPYUqbHQPf2QpUpxRj0pACGcCAzRwK832zNurDa09YWxGc/G4Xnx8?=
 =?us-ascii?Q?gJHy/oH4A5BN21SuEYl2tzNGGAmf9cuSZMKjnoC8nr6kuBOqkd4gxWE1qSr8?=
 =?us-ascii?Q?bLLWL6lFTrgM565fypWAZIIGLhGfLs84t+mN3Gf8gTewOS11AWQNH2QrXrYC?=
 =?us-ascii?Q?PtN1F5jUfkX2L+SOudk6sZZfeBU8hhBm8JJNVM/XG8vc3iNqbsGvuDSxpYJo?=
 =?us-ascii?Q?Lcyrt0lsX4HXKMikS+HCFUejGkB7oRUpAUrv4mamc4CHYAs6nABpnwpewmtz?=
 =?us-ascii?Q?gHDiz+Ioyp920TloruMzBEkGqsP/pnNAEbCvTntHm1aQGsO3VdsttRxEWG66?=
 =?us-ascii?Q?5Fa/racgsejOnEIyEZ9zaGbzhHx5qHW5jlUAAA8DrfX4sZMtZG9drRbyjbhP?=
 =?us-ascii?Q?OXV0rIVLmdgPQC92TxPmaZmI9RzGIU9x139WWQPXpvJ25tBRa+iu4oHe2yw+?=
 =?us-ascii?Q?QgoGguJrBFzgMB+eJCJC3BUrzU4cZW3KGqi60YXmRmvPSkeEpDASTUF5/E+h?=
 =?us-ascii?Q?GCGmmcKeAci4PuMPBN2JkJX7jcaHddGgodbjfFdDJyRN6POcv4bNI2bwfB8N?=
 =?us-ascii?Q?Jh0URTFHatAWfq//MDkYBe8MC9rcMQ9BSMMmbp3YN1s/UqF+zbvVuax9KbM/?=
 =?us-ascii?Q?FoX7FRrbnrMiPlhBvuSJtawKtrM8Vyao3wQUN9/FFqecT+YKVPsgyIUSOXsA?=
 =?us-ascii?Q?IC1kYrgRZA19s3JkukeOrxqwxGaq2Hz4mae4cxG7/FIppS69fOoO7DgqWigw?=
 =?us-ascii?Q?NKmiXvzOrK7Eaq/xsU6Qp2LPy8U95TFUnbvr2hg6KkLnNvZQuve3cJ7viDb1?=
 =?us-ascii?Q?N59AR5ncuDRzr1zJSuaN7gFY5720quhH5CjSF2RWFAMv0MvlSomHvhBSdLqL?=
 =?us-ascii?Q?y3Xl5l6VoW04rjrnjQeMdR0lZxvufeWMmuZCzcOLKPyVbYaD+QepQzsS8dyB?=
 =?us-ascii?Q?u39SWlyChj5DZlDCKFM3EaGjCD7+gtT5f/Vmz0nJ+BcuoWmwvtvyc0uyYn6a?=
 =?us-ascii?Q?qqJzsNyU5tg2cBcYyYpmjKkVmX1ccXX1jxI7sm7p/YpqYqbJ95y1vP4mRKxq?=
 =?us-ascii?Q?JKGiKvK9gdAlMBYoTkvLlBmQuMSKWdjgNv96zheRrrtzrD2b6tIyr/YQeezs?=
 =?us-ascii?Q?lwElCTndMrcA/lWTVm8QJ0WAp1Bufy3ZoxRz109AVWBKcvbvE58aFFRkk576?=
 =?us-ascii?Q?n7kPHq4WOGpWFYyYIQvtphjbL3AmTOTF5vqVfDBYSmfUHa2NNPppX4B3KREe?=
 =?us-ascii?Q?Ha5f1vXRe4beBwwg8pRlYHSSYtIM8of0u1OcSznBUEarN2lI46VPPELqA6bD?=
 =?us-ascii?Q?SqT8BBR2Cg=3D=3D?=
X-Exchange-RoutingPolicyChecked: G2f+GjO5DVgEZN+VaAESTY9g3SdFhcXSAxb9B0L4MeWsko40l2YIU7bEDfuFqrj9eLQeH0sBUSebeBU61Pg22qsgiMTQ5tZic8dLD9UjWUUuLlrf2M7uRmRnra2hE+hfanDATr92Wh0mtGmSzZXhs78nLwtBuiA1Jg0sIssjg7Oii1zBWph6tAPkrlYgdIxuvFCqlVbqaHfIdS6h27juK+GDQ5WtvJGL9LbGBz6LedH0xztksWDeChHJenVygLPVuCl6FQ5y87gEHHP6+uwpRmQfgnXvmg7oODR7HMx3nH9+xtcmdcp8JR9H/B9sP4GtZZqyXohOm9rbTXds+l5hWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a82694-abe8-4781-1b9a-08de8ece02a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:34:19.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GVe9E6BNEtRoVEJzK7gTKtZugSS3172wZPbGcaG9Wbv7NZinYPXuZTudOlP0DpjRfyXA+Lddgx3jOGI0LTr0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com

On Mon, Mar 30, 2026 at 01:07:27PM +0000, Kiryl Shutsemau wrote:
>On Thu, Mar 26, 2026 at 01:44:08AM -0700, Chao Gao wrote:
>> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT)
>> +		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
>
>I think you need to explain what would happen if the feature is not
>supported.

I included this explanation in the changelog:

  When the "avoid update-sensitive" feature isn't supported by the TDX
  module, proceed with updates and let userspace update at their own risk.
  ...
  
Do you mean making it more explicit:

  When the "avoid update-sensitive" feature isn't supported, proceed with
  updates. If a race occurs between module update and update-sensitive
  operations, failures happen at a later stage (e.g., incorrect TD
  measurements in attestation reports for TD build). Effectively, this
  means "let userspace update at their own risk." ...
