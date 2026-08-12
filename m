Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8721D5B0
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497782; cv=fail; b=u3VygIedcvK60IAjnhfwi8xUHLxGqoWH0ZLAk2IniFPsSFSVNmPD4M988KEAS8cjPaqV65bPSeV029k6+R0mvLZjpp678xY84bfUpEGbIsEQVLHHNfDmFvpchFZBL/oB7NY2jUW6XDmCbbusXYHuNBEQVHucVgVl1mvPQoAFlY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497782; c=relaxed/simple;
	bh=rvRF03jX2kn+IkgPNJf+0ymm3gzqQHRb9lQRXrzceM0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxKvIbnU+DKGiqUVQzQxWVU/YrpowjIKvFPpq2iI0eCqI41KcGv+M1OYzCP9xmMQYE0wgcDgCic/nctMrcY2q+t10AtAC92jWECx/5VZAc+uvgFlV+ts1RB7oABf3Exd/chXTbW5WBlkbqoZfTGqahRn0iJWVXR7lRXcH2e43qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gcw4WbWR; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gcw4WbWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786497781; x=1818033781;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rvRF03jX2kn+IkgPNJf+0ymm3gzqQHRb9lQRXrzceM0=;
  b=Gcw4WbWR9ZAMLTGEALLnk7hYWiB2ac39V/jxg/INxTetJVQRp8lMUxFS
   NYSrhddJ6jr6dwdH3Peug100qoP+UDX6i8JQ1glgny3J0HDWAOZjX4S7t
   0XVV1c7ed8wN/k/kwgBUQVrdikqs7ADDrahdDKtKtA7gpNZphbRwgxqUw
   Ys33ONSa0C2vdN3f8yBvv5yJvIH+eDjtimwo9pbhNQqY/veY3GdzTW5MS
   QJ/kjja1R+Sml9RBLiXxBZiOjIzsHOSxcuWiluiukNEMIP+TE9+HIXkLD
   rv7dAhYAOyIFL1h9EznkbpyJN0/mOVaR1KytM2Rwi3pK8IQPewMggpDa8
   A==;
X-CSE-ConnectionGUID: Ld6v5vIfTJaHvagWM5VPog==
X-CSE-MsgGUID: BZp/MR2XRyWT8K1NcmqKdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87052458"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87052458"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 18:23:01 -0700
X-CSE-ConnectionGUID: ycQt/IzhRQO6vu/NBZozNQ==
X-CSE-MsgGUID: zmDBaO1hTCKfWRySzy/+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="259226098"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 18:23:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 18:23:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 18:23:00 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 18:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu7gslk4d3nbMoI2H1ue+rTbFwM1psfR4fVuVEf09kiYvYlNqstD/CAcafJQvjrSPVNJAQHfCYO0m9Fe4UfqtGmIIX7GPKSt0cOnGfYaa9kJKZfv/3kZaOeThpZsw/iNBYdwHTaDcGejIW/V0/NxJUP5qNu4NTIIKk04hhWzOTMgLs5xSxTgctVH2vavEx5nXq0Pf+r/CLURNQQ0Ce6e/MXzvQ1lqrcXUWrsRrWFum637Ai5qaEhgFoNy2tNewSEdoKUd7IKwP/REc1yvFWIpREhixP/BLU2zaJr9TXBKeImnMmj/yJkfDUdmEvaMKtop1Sm2Gref1cn0569SmKHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lbk9Fa76pb3BLAJHuooReqBqaN0g0w/IBCyd+MBCy4=;
 b=Pyp596wqb5adGqZpkRxz27QaFI8y/VKEDbslkUJ2/A0Ypq0pZXk7SABF0peqYChyHC3txzahJPMkBvYnPDpH+7pR63FoWFgtJd/xD05NDBdY3/Lq+JM1XjYCIgimEZx7bz4n6/lNa/7Jis+A66ThjR2vmymzD75tATiNrJaCCTtt5APUy0dHhLhc56CChcb7PGneDUfna53Tp4fnJmRA2C7X5J0RBGf9GxqPLtcAQCAX4x6C7CFoju6AqctnKoGuAsh9xfQzX1ZjtvlOYZrLpLHT9fITZ6JalNEzMxoiERXHPzLceIntghtagDJqVLmWEow7bWfLOgIvuR5h3XFBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by DM4PR11MB7352.namprd11.prod.outlook.com (2603:10b6:8:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 01:22:50 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 01:22:48 +0000
Date: Wed, 12 Aug 2026 09:22:38 +0800
From: Philip Li <philip.li@intel.com>
To: David Matlack <dmatlack@google.com>
CC: Sean Christopherson <seanjc@google.com>, kernel test robot
	<oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Josh
 Hilke" <jrhilke@google.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-x86:selftests2] [KVM]  a262fc49e0: kselftests.kvm.make.fail
Message-ID: <anvK3qq5K0PabAgQ@rli9-mobl>
References: <202608071656.86e9fd06-lkp@intel.com>
 <anYlguXMOPZD-cfj@google.com>
 <anZag-tsavs8YNUl@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <anZag-tsavs8YNUl@google.com>
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|DM4PR11MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 3062696f-6497-45e8-31db-08def8103859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|4143699003|56012099006|6133799003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: kmRveBEeXJ879JMSsPw/1TPfTL7nSgdWsNrMZRJV/Lye9d4MCxEQYZBY5NhleCslf7ALwGexg3F1YdU/FB9k26WU1++E8SDAFuufq1VIoy04fiyhpTFUl+0BFbr2npVnooEJygc2qEQxi2N1DJQ4NYtITV1FO//5hE9hfnmZz/E3yAPkD6/0o7QfNUbJKajLqoNrbO3Nw+WyzQPDHWg3pu3Xe0eF+FBGbclPZQUVRbK/C2MetO0/D8mOfKEgufQe9P2Ghc1pE7yOzC51f55QNUdQLx2uT2bl9luS4ame+S9lVr/dyTvNV3uoDqyR1mM5G4opSHQBz2Z66yL54vT34oLWqSYAhdnZpHSkWkBbo2hK3r8KUaXa4ylQIy2gmRxbJ/s4yMI2gkTJi8P8s6I+PO6wdLo1Ft4v9ByYEI7Tj/88/Qu2z9enJpDxDSALIv05GDDknYvQk3cr6qM76mTrH+YMeNpmVzNEcZms29GvJCgK5/lQyr/yVS+Xlzlx8ryru+weQTdkAwgFeJLrsjcZ1VVJz/hFqDnFag6HerYocpAvRyFEdxrtKWJEH6AtoarPbg8hFrEV0IjmToUrjm/IjgVtwq7H0JGj2yh0xbUuzD4jSLgZdflu5nLgb1RDaAYjUVdTogtc0dPgW7po87ZmP3mAl1ikvPjOAklZMsdm/EI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CZ89oY5cyVuDgOgIsQO/OKictgCXOEdUrMsxYfUFaI+I4jqosYxteVQOAJnD?=
 =?us-ascii?Q?RkPpA43wMlDjgj3LY1Bli6gbrrqFMGaTAlxagZs5gCmLEYsdBZKywA3cFiWU?=
 =?us-ascii?Q?23oVc2i8Omi/OGHUBNpLNVTo1jJSeRo0O/XquZtvIEVa0Fpj5LeGs+hiNfyP?=
 =?us-ascii?Q?EqU830T3hYtfbYcwG6fma/kX1zmVO9KO3Uz5NI39zK77QCZWZnY8ej6AdVRL?=
 =?us-ascii?Q?npTfcWd5S3xHawA/zt5sLsprzNZ9cvN9NqPLf2VFzmuPa17n+MlA6K9O9ZdJ?=
 =?us-ascii?Q?pmXJWYoe4afkq78EB9aT5IQybyy2lO1T5nJ4pKXb4DVB1YDGJNPSE1We77AM?=
 =?us-ascii?Q?kDbcxo3dMsnINHgPsplOQ8VMxgeEtqSEu0pc1KGULYDIl5zpiT1SGX8q1Vap?=
 =?us-ascii?Q?sNGOrqZyUOFxyR8gdOqor7InS/ishZBmnMI6UuZB066kbRwC2aJbvwhtwT3s?=
 =?us-ascii?Q?FC269KRCN964MLWxv+/Gx72onJtIxyAGWM2d8QxZldAOi7Q/2LBUWbs2lXMn?=
 =?us-ascii?Q?Kw9If46xkOls2wDmYs+GspR4kVSlszjFpyg0sYZK3kRFnNH+89SR4jw9dWBL?=
 =?us-ascii?Q?1sQDdwuYN9MAg52oHrH00mcfMAOcUzgkrx3msV6CQIbDzGZ1GHYddhYJp/zL?=
 =?us-ascii?Q?Gmw9LSvqQ1dXT5mA/OXJw+ob6bsEYh0PUZ8KsuL3T3F7rHpQJ67IIxh9YTYx?=
 =?us-ascii?Q?zwrml80M2/QBh731ydpRhn+khJz0zBCzBcwPMi0kNzVhQVxH1tafu+5Flc2X?=
 =?us-ascii?Q?Sw8i98UndA5Cf2MJR+fNhB7vazoWCUYx886eWziCPn+xleWgNgufRuhaBIgA?=
 =?us-ascii?Q?yTywFdR8yzMMR4Eto9SpQX902wf6vN7hI9aqyxFXcaCvftpiVef/WUK8tdMU?=
 =?us-ascii?Q?RVuG3pdcKccNEAGYD0N98uAEOff2HOgEM7/+QcQrfdNKzfSGPnyN4WoK9+9E?=
 =?us-ascii?Q?t0mKMh/Vnbbp90AWN8cFlqbvnzE9KSzmlaxjGEqYaVilF6rqg9MYSaA0OQ98?=
 =?us-ascii?Q?qEZITSqyGKUe9G/2MfziIylYxhXLX+WztzRFBvEDqUcOPPdqXrkpHAXPOigq?=
 =?us-ascii?Q?i5DtPC/P8QJXyxKLscS1AvkDSbbomg7vNRJ+wVflhW0Y0qOBF73HA6KLOUF/?=
 =?us-ascii?Q?mYi20MSR4+oGIacyYx9s9va30oZ8kpRfvHT8usNJYjFovyXMnYEkJYifi78D?=
 =?us-ascii?Q?uk9lo2PuUTBrzhbV4M8AuwjK3c+yNszNixcv24QahrKZZpocDGjvBNckwpSA?=
 =?us-ascii?Q?c3g6slkd1Z4AZ8vKzHb4Bx+jydfjzFsA0zinogfCcclHdjyN6f+B73o3RNJ6?=
 =?us-ascii?Q?nRdxSUj9cFxw5rrQ/kvHYKyxyAFwpROrqax0TdXe5o1Sn0L3fIoS8msX9vlm?=
 =?us-ascii?Q?ZG6SdMA3C693Yk6Gd2bb+7CjFeR+yB/Xgmi5beKafVut1Veui8xXjreZNzNZ?=
 =?us-ascii?Q?6lB3tp0/o1C8ylbc8iWTmBinWLW7mGAnTMDiyusGPqI8BxyukYeR/pLC3B7P?=
 =?us-ascii?Q?hh0Wg4RWbGrM4DMmH0lokyQ/OxQ7PrHtDozEVbumAS0WsA5SUsOjxB0sI0WJ?=
 =?us-ascii?Q?dMlPn/ts1j6oYYWmZVLW4qEOcnqarztYNV+2dHZUXwZqK1HIgcFrbp8i7FLa?=
 =?us-ascii?Q?dXwhUUiOyzUwcKpRf32aeo0bxr+M74OhokUtheVnkoHTQoDkOhIuf/Oj9JGu?=
 =?us-ascii?Q?prlC0C2W9PQAM+EGguz5124+CGXsaXJ0FvV6gnobirNIhrKL7mbuC2/sbDhD?=
 =?us-ascii?Q?U3w+/3kCHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: J/76WgdVIaWS1P3WtdKVnqbIpCO0UB24BZNlkb+1CoMQQib0EKaUbepHjXmUPRlkFcNYqq59/pbbzY+KOQ+RoJogtknzw3Oss7/kWfdJFqvUOXOzi0d57e4GsCC3nkWR61fVSKoFbiEDQC9t5X/7d2fZdyzqCt85jUnIEuxX1hFlCyvyNTTMPQUGsJtGVEF/ezy/QAd+knuyL8BlbTfjYnHywSE7qpdNLrNygOmIjlExcz3nP1iO9pYATDNzN/793q/AY0K0+K8EU4DXx4LR6SMbgMbVibmA7RiQ4Nwq+BwGwISDHiJbQPPtOoExjCanhLARjmEaw4Rmtf2vzvIsyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3062696f-6497-45e8-31db-08def8103859
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:22:48.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wvh1NqjszpEvsiaAkP36E69Use2Ds2CHn/1EhNgegI7bZcbHuPia/ydwAQ05QJRpnXf7lnf+IvrRjz4gLM0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7352
X-OriginatorOrg: intel.com

On Fri, Aug 07, 2026 at 10:21:55PM +0000, David Matlack wrote:
> On 2026-08-07 11:35 AM, Sean Christopherson wrote:
> > On Fri, Aug 07, 2026, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "kselftests.kvm.make.fail" on:
> > > 
> > > commit: a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757 ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
> > > https://github.com/kvm-x86/linux selftests2
> > > 
> > > [test failed on linux-next/master 78bc8af4affb9a732504eb22eeac7d1e50883853]
> > > 
> > > in testcase: kselftests
> > > version: kselftests-x86_64-848acc8ffe1b-1_20260804
> > > with following parameters:
> > > 
> > > 	group: kvm
> > > 
> > > 
> > > config: x86_64-rhel-9.4-kselftests
> > > compiler: gcc-14
> > > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202608071656.86e9fd06-lkp@intel.com
> > > 
> > > 
> > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c:12:10: fatal error: hw.h: No such file or directory
> > >    12 | #include "hw.h"
> > >       |          ^~~~~~
> > > compilation terminated.
> > > make[1]: *** [../vfio/lib/libvfio.mk:32:
> > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/ioat/ioat.o]
> > > Error 1 make[1]: *** Waiting for unfinished jobs....
> > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:14:10:
> > > fatal error: registers.h: No such file or directory
> > >    14 | #include "registers.h"
> > >       |          ^~~~~~~~~~~~~
> > > compilation terminated.
> > > make[1]: *** [../vfio/lib/libvfio.mk:32:
> > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/dsa/dsa.o]
> > > Error 1 make[1]: Leaving directory
> > > '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm'
> > > make: *** [Makefile:218: all] Error 2
> > 
> > Any chance the file is literally just not there?  Makefile.kvm's -I$(<D) expands
> > to:
> > 
> >  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa
> > 
> > which matches the directory of the input file:
> > 
> >  -c/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> > 
> > so AFAICT the makefile is working as intended?
> 
> I think this is a problem in how the kernel test robot builds selftests.

Sorry for the wrong report. The analysis below is very helpful that the bot
ignores the symlink when packing the related sources.

We had resolved the issue for internal packing logic and we will be more careful
to avoid false positive report in future.

> 
> hw.h and registers.h are symlinks to headers in the kernel source tree.
> The selftests build works fine for me when I check out the entire kernel
> tree at commit a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757 and build the
> KVM selftests.
> 
> But if I delete one of the symlink destinations, I see the same error.
> 
> $ ls -l tools/testing/selftests/vfio/lib/drivers/dsa/registers.h
> [...] tools/testing/selftests/vfio/lib/drivers/dsa/registers.h -> ../../../../../../../drivers/dma/idxd/registers.h
> 
> $ rm drivers/dma/idxd/registers.h
> 
> $ make -C tools/testing/selftests/kvm -s
> /usr/local/google/home/dmatlack/kernel/trees/kvm/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:14:10: fatal error: registers.h: No such file or directory
>    14 | #include "registers.h"
>       |          ^~~~~~~~~~~~~
> compilation terminated.
> make: *** [../vfio/lib/libvfio.mk:32: /usr/local/google/home/dmatlack/kernel/trees/kvm/tools/testing/selftests/kvm/libvfio/drivers/dsa/dsa.o] Error 1
> 
> Maybe the kernel test robot doesn't download the entire kernel tree when
> building selftests?
> 
