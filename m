Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5B21D5B0
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498422; cv=fail; b=fDdumZ1k0F7tMrjszqsKSNVaVNvJIaIlr+pQp/XhXbtGDh7kyLcDzdm5pqrN5Gfh2VZR5iphoKc66KYpCuG4VRDXUC2TTHTnY1VTGPbtvbNCG+DIc+U0wHPc89ca1G94VGtjqsCoxhXQnWFVK7iBhrUQ/RMiXw66Et5LnNWW+SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498422; c=relaxed/simple;
	bh=MbBslOJbSd2iCoBlfC8UR0qi/MbRWoLt7h4IUANtLP0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d4BDXz01S530ldLy/9gOEDL9rkp9vswOScVOYdN16kWgPIBwsmH7KZaG/kELUckYFImijo4lSKLwRKdNwhIfw5DmMSL3XaLlMUFzusGTtxVQ7LOBkbgUTjdlMoEIVBZbMGX4NOfVpvPSTV2AACbmsjgXY1koC6XTE2kv52NLO6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ae3BGgLG; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ae3BGgLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786498421; x=1818034421;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MbBslOJbSd2iCoBlfC8UR0qi/MbRWoLt7h4IUANtLP0=;
  b=Ae3BGgLGt/QYqxTA9qjx4XKv77RnhJ576K+v6dgq1pAup/XVfW007iM9
   Hk0XnffgVi4bHZ1zN+PB7qcyGb2ZUjg/qJv0FdZi3uKE7psUx/ar/0GvY
   pDOzwp2ifAN6FhiU4TcYTJjA1v1Rfu1Mlgr03DmeYQYdVW/FjvtCvUG9j
   VgWp7jGAT0jYfhZ8v0U2eU4CT2XqBGRoOokYwaeh/b6Sm3Cjy6SzGTu1K
   wfXxxkad/XISQeeU7W5QA7R52pwpKCGKTRYunK8IoFBbZpDIJhwqypg4X
   1QKqPJOFoCgh+MxDeWh9Q3UXlNgFp/P1CavgDX4AgyY1HGkOxo4tbFdSG
   Q==;
X-CSE-ConnectionGUID: J5w/GvJhSQae/Lebjq/1tA==
X-CSE-MsgGUID: 58WHSqEIROSa4zsc8ohQCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98188292"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="98188292"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 18:33:41 -0700
X-CSE-ConnectionGUID: xxySV0w9Sy+wS90npoxdVQ==
X-CSE-MsgGUID: 0KtalRe7R8WdOL3tbBtUtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="263535102"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 18:33:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 18:33:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 18:33:40 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 18:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8lPKsHciR2PugGaZZkp+QQwqsO6utimjghBLc9gL5Ttfxs1u72v3945Fd46GCOyayhkSSex7KQZQssEO7NyFUJNr2hI/2YhCwR2d/kzByhlo/7vaIKDZ/iQkMhlkXrR7d+rnQElrpQiJ/KvI9c36RsQn20FBM2Gi7I7z98g2H1IejJozkiKye2PoGBZ0labN68CQDSSmYXb1ucKFC6Fx2c7Y2qQAIzJkFBQQHBFDAgYkbnUJsrvS5Ma2tq1+lYCWjb3Q/EACKEj90mm8Le7ofr4Fi23rpnoz6Vhld15FbecZNfxaV9ueZ+VPQp0wZDzM2tOXq7RYqOoJb/J8k27BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnKeUPUgzYoFPS0SZ7J6BQZxGyXz/zRmvTCbeO8CXQg=;
 b=qJbGu2gT8nBCAOYWLLbYP1ubxEVO3uE35eOLV7ZFswv8pgP+uwonEsWRThLADJBOZOfC0tVufmIwWoXODhmKHMdOpdr2uiMnmx8PU9+i94VA+QvF6RMxSBstxsPnTI4G00sKwpkf/Qu3jFE4cebjBkIUc2BizSw+ALnhMP0sv8Bypwyd4f6nDA8sHu3pMP7DfoTLpayZgvCPX+emcw9jzISNXVXE8vLWgEDbu02loW5QPcyUJJDI0VAQeWf1Ry8vDUJnDCiwi1oLN5DsRs7jWKAogdBDlWs6E9LsiK66cpLWQAhs/bWqKslqsdlATJt1ieheMyeSeLVuMY2yM14GAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 01:33:36 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 01:33:36 +0000
Date: Wed, 12 Aug 2026 09:33:26 +0800
From: Philip Li <philip.li@intel.com>
To: David Matlack <dmatlack@google.com>
CC: Sean Christopherson <seanjc@google.com>, kernel test robot
	<oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Josh
 Hilke" <jrhilke@google.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-x86:selftests2] [KVM]  a262fc49e0: kselftests.kvm.make.fail
Message-ID: <anvNZohisTxmNKOT@rli9-mobl>
References: <202608071656.86e9fd06-lkp@intel.com>
 <anYlguXMOPZD-cfj@google.com>
 <anZag-tsavs8YNUl@google.com>
 <anuXCiFnJEugZb0m@google.com>
 <anuaWC4c49JK4poE@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <anuaWC4c49JK4poE@google.com>
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 535d1991-1433-4f0c-850d-08def811ba71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GDSD9tPTo2vFez64ZfUCQk1Z3cAEW7GtThyCxmn63Y09WF81B9D8WzvAgYLk6PhDq+b3U2CvkpjIKPDquBCLAjdu5XhSViAZM5RTQExAAl+0vjs/jVr3kw76YxqHFf9OBeZc5BHHf2/nUm+XDhMR1DtJ708Ue5UK6a18/wgoHBCWa+8U1MptVet1eKFHVluZK2ujkWy/AAFy8vpIivFYSUt3i0MMgLuN3gf4hGg/FMCNjENnZrhHDr2MlYOZpuqhYSVCo0f7fo5fvccYOukUNqU28n1MPeM8yyXjVntaP7cfLMstm4M7rofA3ZggK1RnRucbkmRijNkE0Jhu9/O/atSfnP5nfdNco6lT2eVy7IGz/6Z1EqhWyexRgvZLRdsQs+Tmurn3gkdCoHEQwrVZfxl/IbNat6VFCO/Ovcb+AyNw++Gb6cctKXUPCQ5RF+0QffLNu8ac23PHTCX5KQQ6ocNRPLZ/pXJ0JZv/U6NBJQfbTYn5foJFWbRLZWUhDs9b7fHDTGQC6pLBN5mmsSGSsaf0VfSnjnzDGwzNXUtY2s6T2rUguA8/FzZpiztAfQh+Bn+JJRiDME9D41kTGpH3Of+kL5crcQZ2wLD1Dg3HTZiOe218GsIDnh35XGYTNdCueRzcfQ28KPxuoVlG3A9sVdB1LGZKg5nxKiuzD9E3m8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6iiGRTcWd2DK2Wpkav6i1poNSKRujtAgYgkKnlLT7FihWY153ztShIlU9Pm?=
 =?us-ascii?Q?RIS6LsXcFI5QiCc5XLA6I78wb9vM01MZ1ynS3PKMEsDcjj9sRgIzYLkLYRuc?=
 =?us-ascii?Q?pEs1C6cXE3MTXOAPRs098MzmKxvviRPgCIGokpYMrolkr872uHQ5i+dgFo5F?=
 =?us-ascii?Q?CVDuagM9dOQsZx88Ugv2Xlei8hzKfb5W+lyoBSdhMFIZlEMp5BQISctYqJrI?=
 =?us-ascii?Q?JGexPCc5fyFWfAN7PCmZsW0M+6jhGvP9+dWTzkGf8+gatFqlmbMDOliwHDZ1?=
 =?us-ascii?Q?uHdblVZ5x8R5RI+R3wJXQR8cR7a+IUL3c2caB1fRYto3Ay9qLj9HNtEQvenR?=
 =?us-ascii?Q?ZCmuqMLfPwkVJPPwmfME8OeY+K0G/a09SziwL+Cxo+CnmYyJuR3CWw7HYbmL?=
 =?us-ascii?Q?15DVfAUbd2eMgg7hMu12gPXDGwNTHH0f/elQtK+MHHaZR2P17J+7VCoEnOkz?=
 =?us-ascii?Q?Y5cDas3ps5skaeltRfCiCcUNtbIl9O65xG/PrmebeiN/nMcOxjpZ2cq7sQc7?=
 =?us-ascii?Q?0h2pRNmQjEx72D5VJhj8CQzcDegsG6czu66Gib9PIyh999JBzj9voOlYoocF?=
 =?us-ascii?Q?aPDDh2D5cUBQKxh2mJ8QXwD2N/entngtqpEeyHErRJETwiL0dru7xGhC0tSC?=
 =?us-ascii?Q?rkDoYuhrGE+TCIJWlrP+zkkfjo9jiKT1/PDZYcJoNlfIwsmIeL7gKGGh6gQp?=
 =?us-ascii?Q?tmFEDDtDHrbf3StLmu0zAP1uLYQpl06roS3TwIWxxtQZxxnyvAY0+A3UKSJ4?=
 =?us-ascii?Q?PZxULrhsywU9L/ZDrJvzYtR1PNFX7SVbpXN7i1aDXlye5h19rSuAeZMD8uHm?=
 =?us-ascii?Q?r276XU5CVW9OYk2+00HMFUH209THqWjWTOcg5BIFUkZ+S5I9UNojXgEmYLrK?=
 =?us-ascii?Q?Tg6NePdV6bXvGoqJBO2zxUdCATO8Wd5Gf05G5kC+yQGM8IWH/8Yx83eOrvqP?=
 =?us-ascii?Q?uvhn6ZVr1lyindO5yTDorM5oXiUifYjw7SkPGFcNyjxWQgkNRA8jrkcA1ao9?=
 =?us-ascii?Q?FppNSDRK//b/1RnR8PEq2isER2fpWjmTU+8ofaxeh1nj/GaXHvVf8VhploUH?=
 =?us-ascii?Q?4cSEFJ864G0LHPDSUpxpEH/SSGrSK89GUdzTPq4iJGClVNicrzAZg5sQdkQj?=
 =?us-ascii?Q?eOXkjqit6xp4OPWzK4cO32pUSpmD/58/kkgyJ1NvofrCFQ8bnSFosPfgSP3y?=
 =?us-ascii?Q?EmlX5Uo5VtUqltRP4A6s16NqSybCNVrN6qF8246t7CiVozMf8HLl4FO2MQw3?=
 =?us-ascii?Q?/5d3v8mPn7otIeU7zyUq1cyzUTp4vWBWsR6fAsJGx7S20mCHFM+pISuQbDcs?=
 =?us-ascii?Q?DPE36F7vHRk5PtOr06lJjlhPj2IoByYm0yL4yE58+Bjz6kXT6w5No4GTxw8b?=
 =?us-ascii?Q?n7RRk1MAFQUPj4Q1BJGIhg0cBBMLFp4gWDH1+iIsLDcg5qxx0NMOqw7QKa17?=
 =?us-ascii?Q?HYC9ylik+t/Ep6VDa5kISqZ/Q9z6yijsCgymMjxWQFL8KkKmkgqec9QL9CVv?=
 =?us-ascii?Q?9CoLW4WyOq8/tzy/h1bLQcVGOxG5qOEa25z6Y8IANGJVzdfxW0TMp5zx8++F?=
 =?us-ascii?Q?g/wOlQj8YJcY/K5Dd8JCWMLbJuKls8Yqg5x/cGTgdIDQDvaQgkkV6g5l+LA9?=
 =?us-ascii?Q?p4cKYOGN9e06Um8V9W4nWHN2ne1gd2+2LI0ydRSDJ3zwrNfz6OoUKrxjWZ/k?=
 =?us-ascii?Q?LsbQaa13x7tUk2J6sDzFtQQYN5HeGLTrURjB/H1dMcjlbU/YGKlBWGG08neC?=
 =?us-ascii?Q?uqDHEOjkIA=3D=3D?=
X-Exchange-RoutingPolicyChecked: qu0A2DNgb2Qixq4xayk6po4+baePbLPOWliz73CgPDg2/gdtFWw1kgLrdIWzx/kiMYdUP4qUc0f7D4wEVyMi/66QXHhNpufFGQeHCoXAIkfNljtPi0BldPaGwZicuxWQ3QooWZMmaUtO3hg5cGMUMoDpK4LboZvMPuIFfXrRpyHnWRoOlKvW3ZADoAzRdBiEC8DNFwWLH+6V/D5bqrG01uLkJQox06x3Rp6yda7q4SrgtQ7pV2sjPzWFYPcEHVexJbbOHGHK3cflhBpWBZKa+nFxrwcMqB+tZ7ZRxWrvas4EYHji+xoSj5estBj9Tl5LAgt3osCVbPnPkAoKcVRj/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 535d1991-1433-4f0c-850d-08def811ba71
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:33:36.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZc/2wmWu+vswgncU9muWJYhObzEGfz2JdWCX3d9qsyRDJMMScKdMgBORS80qLvNpjAezcrY1RVbjUpjgS4PKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com

On Tue, Aug 11, 2026 at 09:55:36PM +0000, David Matlack wrote:
> 
> Here's my proposed fix, in case anyone wants to follow along:
> 
>   https://github.com/intel/lkp-tests/pull/567

Thanks again, I will follow up this PR.

> 
