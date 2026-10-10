Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99D39934C;
	Sat, 10 Oct 2026 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599455; cv=fail; b=Addwhb5gyYP670AAlhkdlUO7n2jF0UqnsTyqoIbGfXAaVGc1iE9c4qk/f7j1Sm99SA3UQ09XD09g9IM59QTclSZ/Kpt6hWl6tW2tEdM58qrmBf+FYp4/Wa0gCAMAUgtXQWOwQfRXn6uue2KcCur9ebyC9JM2z6vne2NqRZprDmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599455; c=relaxed/simple;
	bh=lqOu/ygZgwrzIcQm9PoBfUBd2NTFs6kp/Nh5ZYf6TL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=COBGJxfpJ9Ojz0t8rylqhylaYYbFm/6ZM0jRE1b8eryqANuXtl3NZ7xp1G5sxNoBrwUiBcQVHFDhD0aOYlmdmh+UGED/ggWepbME02eWi3SScxWVsWvgqCyBl5MMxYcD1tP58CIkdCCUktychKBp34FUL0TXA2U7liMMBV67gzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GI/olUQ3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GI/olUQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791599453; x=1823135453;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lqOu/ygZgwrzIcQm9PoBfUBd2NTFs6kp/Nh5ZYf6TL4=;
  b=GI/olUQ3g+O7un1ROvaF/x9s5CwMHzAEZPPTDmZPC97vfDtL3C0V/VNb
   raRwZBf1UF0JcX4Dwfzkxh7ktcuUgG5UUVK3fFydnn7WsilKPSVL081AR
   ZJaLp3c79eFkqZTl0ejwDUs7M8Hm3dwYUPVjq74kcboXoJkXnZROjjZ3S
   6IQpNDE/KyDVtj0PQfEh6f38OItf9vByiw4T6ivHBrKhq2g6Hh1TqZ+zc
   U8th5SMKDyZoUqERqSwTtT8/Gh3Y90W9Cb5352swtOcUpwvslcp39lyRL
   VgAg2MOQ197zOzeFLvYxfWJi5L8SvgSEyZA3enxTSOKiPRRRFEjkwXBac
   w==;
X-CSE-ConnectionGUID: V/xs4cirQzeftTysga7L1w==
X-CSE-MsgGUID: jEhJwSkGTLWWbJOEdkCpFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="393127"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="393127"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:30:53 -0700
X-CSE-ConnectionGUID: A3A/co7wR+isgEqO192cVw==
X-CSE-MsgGUID: wctOWa9GRsacr0oPVuOmqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="901983"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:30:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 19:30:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 19:30:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 19:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5LMmjvEmmLtE8wII2WN4ms+C+PB4SAWmakdFozRW3UXHsa/1VIMCxEIG9+t14fXsMusS1JtcfpoU2RZgLR/+gjEqnYrC3jYZwwrqfTJCUFYM3S61IcTZOwnGmjPzccqvoPE++mcOT5QvlLB23xNi+EO4Dy5EBZwoonfS4BltyB8JJLK+pRRtSYm34rKcQtXotOW5ZToFTHGGQxN+2Lf0m8qKCJS44YEUnTIGzMevp8ghOmF3wzfI9ceG/DGIBdQ12oi7aOFwRxPOvT47RVDjKK71aOHHWwZ7sJTnijDCq2aszabhem2MlgysmR5hZc9z5M+71tZwVlH8kBeNMP0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdU9rnC9dDn46kG1gmCuYGVi8fYqMr95ULeSLaZcTCo=;
 b=eR/Z2JEmw7wkVWE2nIdmZb4pPT9vLPfmMmWa7Bm85f14W8OTHWasEAy8iY4QNmAaWcOI0o9V58HJ5AHPj2NStsvGnXVYNR9jR2dQrxUrewW6/iQ9Z4o78bOh9Elyp0HSyR9+ejuVnX6h+LgzR1cn5509AWj6kq6I4/dXPACQVsPKTQSGJRKOEE7mcEL89+kq0Yi6YncjBTVv5/5E+dIdjkbGe3Z+2s5tIvoY9pX298mjvCHl6lbyWHFRiavkB/IeGU9qjjbLl+kJED/MrGHZVdOUtw1eyu+20Atg+kyaaIvSv2r2klZyX/2dXOhxl6+oPWtki1ywOUYx8KAyudl9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sat, 10 Oct
 2026 02:30:42 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.017; Sat, 10 Oct 2026
 02:30:42 +0000
Date: Sat, 10 Oct 2026 10:29:54 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ackerleytng@google.com" <ackerleytng@google.com>, Vishal Annapurve
	<vannapurve@google.com>
Subject: Re: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT
 Violation
Message-ID: <asmjItCkW74Z6AV1@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260930001127.3170009-1-seanjc@google.com>
 <3c0ee89f560b0235f293b32019327186785aa795.camel@intel.com>
 <arxd78Pn6WWL6TGq@google.com>
 <asdOF41hqDpycXKU@yzhao56-desk.sh.intel.com>
 <aslVXBSovWuAsNtN@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aslVXBSovWuAsNtN@google.com>
X-ClientProxiedBy: SI3PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::10) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS0PR11MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: d29f53ab-fb0a-4b7a-a5f2-08df26767a51
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|22082099003|18002099003|261009223027099003|4143699003|10067099003|5023799004|56012099006|11063799006|6133799003|20046099003;
X-Microsoft-Antispam-Message-Info: HFOAjQa2zxOyjF26gMYX6fv6x5M5Ehe1cSLw1FP9d28nKyJ7qMeABoiE7j1CTkE0HeHqsgFsAiujAYPOukO7SzoLJgscjumk/pIP6b+UH3Zy1nLM/u3eC3ejObxdd85Vmqfo2y3YiIRMb/Oj49uRTypqkJjG4mmPf2aLbn2gSKP2QrGkfaEcx7HL5snPRYjClU4ShrEi3AoWhqEJIsueksirTjiQTEw5Bo023FVer/YprdmHcFighwnun+a2UGYm7A5XPCVij4a3SJivakJwjVERzcseI2Z1VbC6twbRPJ7WACRoHY8Qsrc1jdbEkzgoT15qYQ+28m3HpYljxMNXzrk3EPP/CcRxxzFugvZWACum0XnghVlh2oucOHAbNi50K6GSGtUjUHLKB/X4MjWlboT4NfddU6HTaED7zaSrDuNiw00+x5PJOw55sXDJ9Tu+/wUR2VRWW9RYRlVJyE9XrpqWFSrwD76gBV5BsBjPMxaAIZ0WkJibDgso+4jRl8yYFooOXCptRok0kg1LEIdgWwT6mKAwKqAc86GHetc22CfCXyoRF59XlUglCISKj4v9hN/W6oolLbwLY/VM55YqRmyEnR5vW1Lwb7DSwaQXxacJPZeW1Y7P5aaTJFEJ0Y+r65oGRsjHdlKbnHexci3h41Ihue9zdyrQUBJZvyje0MQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(261009223027099003)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bgcZFIIb2jmnRNl6yuHMlWRhbUBUOVP9g7Tukrh+tfuYYbeJHspDUzmhcc?=
 =?iso-8859-1?Q?rYbBokgzv+l3LOEqZ37H08JZ9T1/IjMQsrdezq4FeY8vomH85n5viIXyeZ?=
 =?iso-8859-1?Q?ntDaHGfAqKHRvoToUw6eoqMUtWcphM0E2Hz86cEPwRwaXH5e0vYXiUGwh8?=
 =?iso-8859-1?Q?k5KjZA89vnrMQrjNmh/dKS6Lp/0Wl3vm4nqF1TsAuxBPgMVDHmuOxhuNLL?=
 =?iso-8859-1?Q?LWnKm3lfeKwvpCVWTe/IohLGM5fH0Z/w7WgrSy0Oj2CeHmfnUGjrLrSGGK?=
 =?iso-8859-1?Q?r2aen2Q+f6Wlf3EqFmvwJc1a0ZysIpMDf7/XYEp3153Icg8NzGmkwNz8lg?=
 =?iso-8859-1?Q?505dt8CB+BfJ5oDN0N32a4GUz21k+4+KA3AWixyYmeQSIVQnsSw1I8H0LH?=
 =?iso-8859-1?Q?unq9eK3+MEvPikfQjcB5/TV+GexXQsMDsyuNCrKZjaVddjRwfBLbxWQ2q/?=
 =?iso-8859-1?Q?sgk6FssrqeeqknIJ2K1xjzrehz8xTwJ1zvXIcfvUCBFzk6j4YOJ8ufjU6K?=
 =?iso-8859-1?Q?VNPumpv2EnDg/5OhK/4X2scFN7q0jHru5O0wPQNCXt+15t2KoR2xgLPfdh?=
 =?iso-8859-1?Q?dYmccdmmAt3DLuT9vpgNOrLF7MVi/FybXkuQQEaFwTCnJNXmLgcSTnZ5Y4?=
 =?iso-8859-1?Q?7Hs4H5g8dQ00Yzwhy8eZb1PP9tsxphswzGHZ99dC4RFnU9A8dK8rIUyU8B?=
 =?iso-8859-1?Q?ATagPzjZseYdCej8p7dkJf5N71QCj3RPQQlnIjkdfg7s/2qk3dCSsp3LU+?=
 =?iso-8859-1?Q?aygGN3f/cZT3wpTGBNdTyVLwQYhYGG/FO78xH4SLcr4NkA6fm+upe1iWPQ?=
 =?iso-8859-1?Q?epCWM5eKKuzJ+i6OrD9sCANyqm5gk8XTFikb2SZ96s/0icPIy9yngFQBeP?=
 =?iso-8859-1?Q?Ny4zW32ISo3MuU5uWUG7V8HN/8xBsvq0FcwfCrZBJLnpY/UnYotCeJvUai?=
 =?iso-8859-1?Q?I6iLb6wwSAEHOuL5eRtUgTusvIGxS954ydqoW47mqu9mQJCKLdWTmP/xN0?=
 =?iso-8859-1?Q?MpkhkKaAc2qbNLTonkp3QrW3YLkBh/e+gt5I6J57FwifC1PZHYDcrhnQR6?=
 =?iso-8859-1?Q?gIh7F2FDTJlfX75x38lnIvRSK5rWPz7MoyzqXIa18fxrctmyxOPe6R/YR6?=
 =?iso-8859-1?Q?p1cchIV5yKDQkYTrGw4f2l0ki8DirpErk2CpzsPZihqARkm0VqbUtmWYsJ?=
 =?iso-8859-1?Q?Z7O93snpzCcDVQNsBaOpRGwuwlLfa2G9eFS/vH6ViQe2W0jnMsyA7iAN2I?=
 =?iso-8859-1?Q?xXoD2hG2KYk+ov4zWjRenu2I22DD99hAiCoynprbPIIk3ZN9K3zvdJMq6O?=
 =?iso-8859-1?Q?+LFMhoyvlb4M5V4EXN1qyUdrvt7p2qdyFSs1ZqH1UOj+4RDoank/E/4BxG?=
 =?iso-8859-1?Q?ihj3qBYYaL0LHOd74J5mLeZMmU242wA9eBldJKNerN6KVhk1gQU1nZcKH+?=
 =?iso-8859-1?Q?KHQJLsVusQ9IsIVLqyRzhZWPaoZdMsXEj+cX1XnizDYySXS1o+fPzAkUWw?=
 =?iso-8859-1?Q?n/0j+UUowQorBX2+BhSow3PZYAzjj9iQYWIaVjzqk9ZmGSK/4N0Polrs38?=
 =?iso-8859-1?Q?EmgZkemzGj57dVMoNJ5LlTqEhgMZoGhfVnAEkCLGhF+8qNXc7uuZxN46aZ?=
 =?iso-8859-1?Q?1kDoW3HbU5I6bv8y58XVHkwBpCG1WsJNOn9HYxQQkAjNKlxB0LhKJUY9eO?=
 =?iso-8859-1?Q?fi1RKmFyTDINky/UyG1R/ffSXwAREcAXyCoce6sw46BnckurugAGASkTzz?=
 =?iso-8859-1?Q?T8iqFwHduD/7MRyaMVnjUQa29O8bcuOx89LhxQWpel23k3fhA5qftze1Jz?=
 =?iso-8859-1?Q?j791om5mzg=3D=3D?=
X-Exchange-RoutingPolicyChecked: A+NH/eYFxnVm5OQ2fI/jBXIwZ8RF4eM+OhxC0HC6B4ksm9O9tELQGHpVG4fWGYKKRrDXj+A743tkGRV/2m+I0MoRaN1SEK/046Uai8+kJ+OCb8Th265CE+4tShKgvKEJsk+4ZyEIUa2OdbP/Ggpz3ZMC7Icbmml0dvp8B1cCxCJBjD3fdv1JUMyh71T+nk/6NiR/tUERTfnsZb4Ya56e6ltm4d4ji+apSPziRV6JxTDz0XDtgPKJVnNpKKQM8J92cki9teemKad9P9YHShFUiq8+VedSRJV22DgWfWTxFzSH6bAU4VWRYrzxYYY16h15H10gM1VEtDpzvhyLQPkP2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d29f53ab-fb0a-4b7a-a5f2-08df26767a51
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:30:42.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLt6tbrvNo1+Ky2cTlnzS4wFl0oUCraTHhPeVMbwx7Wk4X8S4c/a8rjUMjsluzlgO5I68YdWhPELFLJlvALNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 01:58:04PM -0700, Sean Christopherson wrote:
> On Thu, Oct 08, 2026, Yan Zhao wrote:
> > On Tue, Sep 29, 2026 at 05:55:11PM -0700, Sean Christopherson wrote:
> > > On Wed, Sep 30, 2026, Rick P Edgecombe wrote:
> > > > On Tue, 2026-09-29 at 17:11 -0700, Sean Christopherson wrote:
> > > > > Signal SHUTDOWN instead of -EIO if the guest accesses an unaccepted page and
> > > > > has disabled EPT Violation #VEs on such accesses.  Returning -EIO is all but
> > > > > guaranteed to mislead the VMM into thinking KVM (or the VMM) messed up, and
> > > > > will likely result in the VM being terminated instead of rebooted.
> > Hmm, it's by design in my previous implementation to terminate a VM when the
> > guest accesses an unaccepted page and has disabled EPT Violation #VEs on such
> > accesses, according to the TDX module spec:
> > 
> > "This happens if the TD is configured to TD-exit (instead of a #VE) on an EPT
> >  violation due to accessing a PENDING page. It normally indicates an error
> >  condition; the host VMM may decide to tear the TD down."
> > 
> > So, for the initial implementation, we chose to invoke kvm_vm_dead() and print
> > out the exact reason as a hint to the system admin.
> 
> kvm_vm_dead() should only be used when KVM *needs* to prevent userspace from
> running the VM.
Ok. But my previous intention was to kill the VM regardless of whether the
userspace handles KVM_EXIT_SHUTDOWN or not.
Did I use it correctly?
I'm asking because you added the Fixes tag and "Cc: stable@vger.kernel.org" for
patches 1/2 as well.

> > (Previously, reboot was also not supported for a TDX guest).
> 
> But QEMU isn't KVM.  While QEMU is the de facto reference VMM, it's important to
> keep in mind that it's not the only VMM (and that's not just about Google's VMM,
> there are plenty of other non-QEMU VMMs that are used in production environments).
Hmm. That was the reason for me to choose forcefully killing the VM inside KVM,
since for the initial implementation, I didn't want to bother updating every
VMM :)

> > Returning -EIO was based on the following considerations:
> > - vcpu_enter_guest() returns -EIO when kvm_test_request(KVM_REQ_VM_DEAD, vcpu)
> >   is true.
> > - A request to handle a specific EPT violation is rejected by the firmware (the
> >   TDX module).
> > 
> > > > I'm pretty sure Yan had a test for this path, and I'd love to see it actually
> > > > exercised. What is the urgency on getting this fix upstream? Can we wait a week?
> > I triggered the EPT violation in the kexec path, and successfully had the TD
> > - killed with error msg: "qemu-system-x86_64: cpus are not resettable,
> >   terminating" on an old QEMU, or
> > - rebooted on a new QEMU with the msg printed:
> >   "qemu-system-x86_64: info: virtual machine state has been rebuilt with new
> >    guest file handle".
> > 
> > The TDX selftests we are using do not handle KVM_EXIT_SHUTDOWN, so if such
> > an error occurs, it's silently ignored by the TDX selftests even with msg
> > "kvm_intel: Guest access before accepting 0x8000c000 on vCPU 1" printed in dmesg.
> 
> If TDX selftests don't fail due to an unexpected KVM_EXIT_SHUTDOWN, then that needs
> to be fixed irrespective of this change.
Ok.

> > > Absolutely.  It can probably wait a month and no one would care.  IIRC, this got
> > > hit by someone (internal to Google) deliberately crashing a guest kernel and doing
> > > funky things with kexec.  It showed up on my radar purely because our automated
> > > madness alerted on the resulting assertion (on -EIO) in the VMM.
> > Though I didn't realize that returning -EIO would mislead the VMM into thinking
> > KVM (or the VMM) messed up, such an error could also be introduced by a VMM bug?
> 
> Yes, but that holds true for literally every guest failure.  It's like saying that
> all observed errors could be due to a CPU bug, e.g. because the CPU corrupted state
> or because a bit flipped in DRAM.  It's technically true, but in practice the vast
> majority of failures (outside of pre-production hardware) are software errors, and
> so absent evidence that a hardware/VMM/KVM bug is at play, KVM shouldn't assume
> anything.  I.e. as above, unless KVM needs to protect itself, KVM should aways try
> to provide semantics that are rooted in the CPU architecture.
> 
> E.g. an analogous failure would for non-TDX guests would be if the host zeroed a
> page that happened to be necessary to handle exceptions in the guest, and as a
> result the guest hit a triple fault shutdown.  KVM doesn't return -EIO instead of
> KVM_EXIT_SHUTDOWN just because the failure could have been introduced by a kernel
> or VMM bug.
Makes sense. Thanks for the explanation!

> > e.g., VMM removes an accepted page without any notification to the TD configured
> > with TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE bit.
