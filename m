Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAE49DB9F;
	Fri,  9 Oct 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536974; cv=fail; b=FAkKXv4bsaLxhSM+xYt3XaeK++iCUONWDyrKm4+8w1aU5mh8IkRFRvblKWhX15kGLCsgr4BQxUO7Gy2cR/ov48CCrIZrJFBvmMqPawimxJvonui2KjxqsPuSHdneYzGMCR002QOJc8voWuyCBHVsxy7uUhTBCxt5O4mAxJlD878=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536974; c=relaxed/simple;
	bh=/cNk/YNqeurJiQRhdE5FkqW6vEtqoMLt7p+Zvxt/OIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3zqbYYU/aSUEL/LuSyrrSkPC3qKmH5kdCBbSk6++58xUiMbyfa4+zR+80D0qDmKnvZl0HUDSuMHX16wwJ4eFekKVFPtcIX154iPDILYXvZ80APCzVIwdni8sHlFU9q1PBFdq4wpq5zbcdRqpnG553RmLr75qEuEO6Ha8x42qX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOlLsZOE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOlLsZOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791536971; x=1823072971;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=/cNk/YNqeurJiQRhdE5FkqW6vEtqoMLt7p+Zvxt/OIM=;
  b=dOlLsZOEaHeUIaqSYYbJ0yQ6Q4jinF6X8RI88iN6aPwiBlwZXQmFeB0v
   6N59m+1YS+I+r7GSIF/Y80ADB1EigRafB1X2nwTfbdgCjbmk2jLCd4qwj
   5NMGKWi/npIUqt5t5o1PSOB0O76s2KUYJ8UcNOMqZTO/FIVplZmClJ/x4
   9gNhF33bpcL+f6biStSZibxfEfYpfMvI1fgWVg8twDrawJKWhRX/Vy7l5
   wOBeTQCbL7jdreAly6MlaIZBbQOBe6cvugL4JMhZRKXsM1qsJJVdL7pnM
   lk3kOEKrjMNKL7rL/eQV0kER0CwDTzMLf/w4dUYeHcd9L4l92/Rsilk35
   w==;
X-CSE-ConnectionGUID: s4Z0MpuwS6GualytacojQQ==
X-CSE-MsgGUID: TgUekUWKS7eP/QgY4IPkWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="226106"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="226106"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:09:29 -0700
X-CSE-ConnectionGUID: 7r+Rl1CbSEqJRZQjrYaDTQ==
X-CSE-MsgGUID: IH/48Zk2Riagcnmdk+PMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="224045"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:09:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 02:09:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 02:09:27 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 02:09:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOiQtLL723uB7E4TwmZWdO/Pz8yWQVwcUP/Cz1iI1lCcMR1SFKyoBRzghwgj1jzYKmnF3M7Y7qYmJJRfFSxDwQgJ/FlK1vbJG9siBiPgaASzmTYdY5SPyd2JOJByafef4pduFQuxBFPKeaUhg8uLi/Sn8MA4+rFkOTsSYoU9DNZ40KFlVOwN/2j/E3equE6KUUh9WUBT7VnK077mX4spdVumhgUvr9uh7grxs6BrGcZEunkHu+6MahqMx/cWAA+8RsI2znGZ9d7HtUB+imypC4WB5g88s7r4gIDMDRVqQJ1VyOa+j8ydM5sbJ21H0mX8imV0GLYjfeyONQ68WZY1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC229W/X180IVnNLntIlx3gfxVThl6bRKyBR/TQBGl8=;
 b=AJL2drtNbnVUOJlLrrjPac3Dxqml5Qc6y3trg5rH81D1LrMbYiwzCMZkx76+z/vgBPgGqr5uiHNqrH9svXfOBY2Qx6M9zbFsaLAHoI6yXQuiAuz2heFSDS26Lpm353qg2+gQG/orA/xSon1hSfB+rWCV1f166FGdwVN0YoogsDCCqlsx/yWBOI4z0/QCWZhexEu/ZTTs4rNJx+f7NmHQ+Gnh4YoeODij3efkpXl9xDHHUvJJno21SX2kXUkcwKO/Ig+vNMtxx8pOrNWpyrO6nfrDfe49zYKZrQrWaGauRu7ePqa6jrSDlsn027G5EJ+lce4R4xSLCRfrRYV65hkAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS4PR11MB653178.namprd11.prod.outlook.com (2603:10b6:8:4bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:09:25 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:09:25 +0000
Date: Fri, 9 Oct 2026 17:08:36 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091035.15599-1-yan.y.zhao@intel.com>
 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0033.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::17) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS4PR11MB653178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3d059b-33a2-4b3f-cfda-08df25e503df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yJTdqpop2bp1buUXSD3WimWnRPCuyNTaZ/e5VUA11G5OWGVemFL94RZ+FhYnI1B9mGWzBLcNrMy3uWOiT7urFM3vfykH4j6cJ0sHGIqnPG+1rZ0um9foOBKiePtlY8UTgxq0qL0MOpmshSbqcws3H9jlw3/PTXWSB323XvMqo1UlTJwG83P0oTJi/D8GwoUIiVUE/oHk3WibIw80xWUR2CVUenbqEGw158RfBicHYNOkSX64qO0KEymwzr1FjGgEs0nTU1XTrF8EAPQIz0VRljWgq74RVEJzuohRS2Uymtg1QHVxLaYay453xk8nUYn/0UES1xRcHikhqMJQok5H8m2mz6plTyl0gLRumBX0HUDXIKZwpJRDBgWCiakK9UPIrE1QIK6s4ajvwv0y7kyl//oXeT7vY+DULc/zm8/5HXSHRc7MMjE7eI6nfGZBrWxWbtOF1rhwKrisox5KhFMrAX10idgIjXyfd3orrlrbx/8VTcjvE6KPzlPYo1uiCl6VsOoxAigXAXXjTTWDsQJeOcFxFCcm12eThd85edPgiXRn7Ab7fp1B6R50mArksiuY51KXPmHTqMLsw6PStoow6N+aXAKfvhJx1IFW3JTKZBD6LpP6m+8Jc6mkJGA1KAAgGCZgUqPrAe3zSIcta7rXNoBHZ8lSufYDAK53epXGCwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYW1yCHn46AI0VK49PFIBbRMis8koRp2Sp7RRBoJSG9Z7ILFZ+Uh+vYmIEf/?=
 =?us-ascii?Q?AaVduOsnFoPSdZSimjcxhnXeB9/ycaiY9zpyeh/eKoT744CkyIbuF1Q9SKze?=
 =?us-ascii?Q?mtZh3L9nvZtVn30Ugoo4H3iJFOqnUXYtVOghkkqEpxVmbTani9UDM9WiRnJk?=
 =?us-ascii?Q?8wDobB6oo5qUjYvo8rvgCTtEWwNoE/wtxVaokeqGoi66+A7K7yEdqkkRD6/G?=
 =?us-ascii?Q?e0EI569jMyTl2OH/xBbeRo5vE6O+9psgJpWJYSnsR9dtCDhjgpaVENAfawnR?=
 =?us-ascii?Q?dl2CYQF52YTW34VspPEhB3lZhcZx8DeUA472qyg6MJMEy+vSB96+Evj9GAp+?=
 =?us-ascii?Q?qj0fuNWiLmM5kUu4xqHUZKykJ1a7TvnhJ4koamNLzkpNT84D2LpxL3l9vXWA?=
 =?us-ascii?Q?/eHbdt/4w25iIgd0WMSSwiLF/IEU9QhgONjWGjXC+3xXWveHpDxu6QqOqu5E?=
 =?us-ascii?Q?2I6IjmcfveUd03+BTk252fBsz8IPqN37aXbdwLp5qpcheD7Z5Hmxx03TfATk?=
 =?us-ascii?Q?o8BhoIzXPheXCAINcv3GfiaXdB8h9ASM2rPWTZDNc9FyW6cSPFPSqk2czT2Q?=
 =?us-ascii?Q?jc33PvQFaxUwIMWoyDXGo1qa53VFLLFYfWRqxiz9sPZRvEdc0gNbBDsnB+Jf?=
 =?us-ascii?Q?7GjENTiqhAmpTZy5Nj2F+VKCZA/p7J7fuee/JS7yIBiO+8StbwtCusxnV1SV?=
 =?us-ascii?Q?DofAhMVvQP8yL7s9c9aGGUJKJBKtktX8i36tTBkv5p7aVWFcA/qqiCFlDtTE?=
 =?us-ascii?Q?P9DnvjKCITuPK/SfVG+csg93W05wx+5DNUUP2jxHwVa+CPJUscVDkkF6aPmj?=
 =?us-ascii?Q?yjOSYLJhi/j639p6ZuRhuiaLDPcKEr1BhV5Il2+0ZkmJOCquiGeHgX8kfvt2?=
 =?us-ascii?Q?05gyAxi94BaTAcRimK+vGhh2lGTCzaSTaepKmy6yrOypNTudcDJGPPxVuYeJ?=
 =?us-ascii?Q?HcYlvq8VqY/B7Yu3R16VzBQjZdyFyfP5BzMu0eqSrr75Mp4ZBPiNOL1oFt0/?=
 =?us-ascii?Q?HEvcwtfusTkrw0gJ4vZWAE9docUm82M8ydZ/264NfFDGaAQz/UQT70mTG1bt?=
 =?us-ascii?Q?sBDuzvafAQk90IkweQf8Y/eSMkxmtXeTcQ7Wpy4BIkqZcjlZ6TybKU94jtJU?=
 =?us-ascii?Q?UkuRtQBSpC3uC62kvbs4H0X51YcgY09TIi4dF1SESNyVolCE6aZZ9i+pc7Xx?=
 =?us-ascii?Q?5x4hKLCmRgJos2PGAzMJkt3ehVn4A9o6OlfUtquqHsXzHYr4zfIrZ05jQNti?=
 =?us-ascii?Q?iWfzaJkFRmKy7r4Mdo0TbtplnVmkseZ6vRkSw7rBbOKD79ma7NKRV9eZn9VW?=
 =?us-ascii?Q?zQhEp6MUGI7Ev822LrMPEU61YXSLzbvuKTV5tT6cV5OFCWGm6Caps+h/HsRG?=
 =?us-ascii?Q?zTDE+fv6A4JNda38SvwRUDvCsOt4cIVQIrqJ60mG8uTNE2klAAXX7Nfn+1O/?=
 =?us-ascii?Q?a0UAWiWdbsT6Edl1fz+5B/39YqbJYnDdrk9rOVNUr1nfGvmWCJgvZQ9LATrG?=
 =?us-ascii?Q?ZjkmJK/R6SYz05J5rCKGflKz4NADarS5Ki0dBY4f6YKSK3vN3P2yCSgFFAVn?=
 =?us-ascii?Q?3WpacUvdTLgChNsgWZKl8imhwUiZjdyZtFFmld6POtMSFdRHzG0e4V14n3fO?=
 =?us-ascii?Q?saA4H4hBwh17y1smBba4BjmgCrnyBBsvmYpe4iWBHnbGH22sMcFm3/JcUX69?=
 =?us-ascii?Q?6Eo/l2b96eawt6dRx5cGnG4Q9znjSYpF9px9QLHao0uquIkg9wFVsyPrUCgv?=
 =?us-ascii?Q?qSgOcwlubg=3D=3D?=
X-Exchange-RoutingPolicyChecked: LwbIuM6oDxJgNmeONI8ITBefdcIVSJ2PyVjWBzY+CQAoWLLeEbL1BaclAlZDvYJpo0XoIi+k9XUmTdpXdjJyxQ6SYu25ObVvo7/BvU6z6LQOSF/xdpYxhAkm6qgfrgml+i9vtisMIF1e9aa33cXJ/IfLTH4TCEEqUNZCBK5Lja7WmSmtXknTWLoDTdSnt/T9KVZovmB+tx8WQnDXBJQvJyTZ17vMQr1Bri+ujDKLMCgYV6KaWOSxlj8whpyIsQYbNSsYJHvtz71yV+c671TaMu8xG4tRl/LIDysS0bv3BX5cJ7IBtn9ldVw/EmHgpR/JsWtOSuQOx2PHT9sMaAlhNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3d059b-33a2-4b3f-cfda-08df25e503df
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:09:25.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 728kQ8m/HD56sumdQeN4/9t1iYQREZbmU+QG3ZGxQitaRJhfnhi1UTmkfcVc1m+doF0yzLrifWmXbLjPzzxVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB653178
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 09:16:12AM +0800, Edgecombe, Rick P wrote:
> On Wed, 2026-10-07 at 15:47 -0700, Rick Edgecombe wrote:
> > Another idea, change the op to be:
> > int topup_external_cache(struct kvm_vcpu *vcpu, bool root, bool private_page,
> > int min_nr_spts);
> > 
> > Normal topup can set:
> > root=true
> > private_page=true
> > min_nr_spts = PT64_ROOT_MAX_LEVEL - 1
> > 
> > Then we can calculate exactly what we need. And even better, the existing code
> > won't nee a comment to explain the weirdness.
> 
> Actually since this gets a struct kvm arg later in the series, maybe we could
> just have two ops. One for topping up from a fault and another for a split.
Hmm, no? That would make the min_nr_spts arg meaningless.
Reusing the topping up op for the fault also scales better, e.g., it could
support splitting under the fault path in the future.

Besides, I actually introduced a separate cache and op for split in v3,
https://lore.kernel.org/all/20260106102345.25261-1-yan.y.zhao@intel.com.
Sean merged the cache/op for split with the cache/op for fault in
DPAMT+Hugepage v5.

