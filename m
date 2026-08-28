Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671A1E47CC;
	Fri, 28 Aug 2026 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891599; cv=fail; b=Q1r6tkxEM5WWqmdn7pBHYKFdqO5SzCtgrCaHj+9wrNM77apvY54nqb5HntoxTQ/e9hTA3V2hU8BGaznSHe2Q36kwhLsJpuWwAIo/W2jB0SdENPhOeIhcGaPVmgUTqUmP2FXle4hIoCsrpwG/IOAY27cXbHWhgLyLkOLWG8UCGGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891599; c=relaxed/simple;
	bh=7pYal9wQaykKclGyxSlIJPU2Z6Gwr9UvxTNUhEYMdbg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M8JCoOKf4FMBUkhue7DfQWOOHKfgFSWLzrn7zTyXh7LTkqR/df7VKZGW1GUrskarEb31p8ZsKkIMOd684dsibmyg03RhFDuI8zV6ik5iCod1EeJYiWj8I/Sin7sRqYP3wj9Bl6S4BvOS8XWc2qEOZV6CRUQ24w6NUszPiYC9PxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0qJ08BC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0qJ08BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787891597; x=1819427597;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7pYal9wQaykKclGyxSlIJPU2Z6Gwr9UvxTNUhEYMdbg=;
  b=B0qJ08BCBG3EY4OMH4MkFTZXKO0la/IlB9TZ6ntLf0NhlX2R+6z2NFVF
   7hKY1W0+osmGKBLUgLNN4ctSViChAUQ5w52UJX18aRuhGMus2J8U+oRHr
   PJ5sF/9C4O3mMNnwfmMNMk85kRUdig9/fz5EbuMTJkvBOqxt6y82dZxWs
   KIJj92Ru+68DTkySlzbm5idjwFMtWYjPTHbM/3WUPBorqEkqblUWY87c8
   yhtbeZECzAUZ1+cdOGbNnU7ZTPpL2PbqMI0Rij2m0suoTsEOul11y2F7P
   Rf296m6tX3n/EACIwPEBgTn0q7YR2aLHaE5Gn5ogdT/yvvkUbmt/1irSk
   g==;
X-CSE-ConnectionGUID: LPnShJEDQASiaPQIqmc2tg==
X-CSE-MsgGUID: lUdqaGoWQ9Scm3O/fNjPsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99748940"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99748940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:33:16 -0700
X-CSE-ConnectionGUID: 4jdVsmoXQ+GvmNJEieK4/w==
X-CSE-MsgGUID: NznKjhT5QWGhj3m5M7Ha/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="291550881"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:33:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 21:33:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 21:33:12 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 21:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHoGiJOB327vO8IeSHRXKFkX3Yx/GdOg644uYwPHxIp5CKsPVt0lUXsgxrhlP4LEcOwFfAEy2Uic9FHuu86XnD0OYg1mHHPZUy6UtHnPitBATnoGczM79nuvb8bQP81ZFLIULQ0ZKD5qxHJ+znz/hULRb6Y7PD9ZqD6g9TkuOD22Ob/tFjD/oCldmQpRT41ndm4/k+EECCsEyYKIIK2wMIJDHARqkyXENfmO+iI88ylPenFzWspODC9K3SUGn4KEejvQ6bAUwTqh5ozUMGkw+nRsGpXEai5GxglcXmShQuqbUg2AMk/PwlKNEFhYny8dot19FA18gu/Jevp91NkfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFW4zBVAdqNdqNEmI4ZIShui0YbDRrxl76fgbEcM9nU=;
 b=h330thN54KzET8MJspA0aMafk3lF4lPGuxQVHoedbYO89gx/S1mqmYn77HFCdehZvsSS0UEpRhuMuB5GbZZ6sxcgdPfhv1Cq5UHHB1EXQH9zZw9j3L/2qjhlO99ORtdzqxeyKs1IHt13IsI/1NBdFwDrq/XXPoJnnOGMtSFjQOpj/CBbO1EjDoZ6cN1wUPNy8acQDuJRkqSNT3z/mAUsGlbIjpzBp/pRWHJ5gdQKWapWNLGhuf25mxp7QQ10pnl0txIl3Cc7mUVdrX+TJuH378m9UNTbwBVhtHmpzyoewZgMcngzaySYHObZirppBkaWZ88YP2x8JX+Hg+SEeKg9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SAWPR11MB9758.namprd11.prod.outlook.com
 (2603:10b6:806:4c9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:33:10 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 04:33:10 +0000
Date: Thu, 27 Aug 2026 21:33:07 -0700
From: Peter Fang <peter.fang@intel.com>
To: Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 22/22] KVM: selftests: Add TDX lifecycle test
Message-ID: <20260828043307.GH33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-22-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-22-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SAWPR11MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 78aa78f8-af57-4e74-58af-08df04bd76f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: CCiYBtQJKh0Mp+Isbw+z22Z0MTp11q73QjzP0DdmgSlkQ8kmfI8dm0BXL0kAVrjrxbBratAf5DMzx2G/u2PAuWk1qrUF3e+Tf0nE5tXV7BESeAkDcEaebl/SCQAnp6MWLSWSLZCBWR5Epq7WCSgwfqTgohC1g6kokWKYP6aEFKbaB7J5ViM8yYTGnd0QuH5D6CeauyzWy89Xyt6mme8rGGsA2IN1w/1pTp5ZV7Lq30VWWQh3xMGW7RDg1FR80ApfD2bytGpDQLTg/5BSnBRGdMCgr8DvD8p5FTjWGVWoKWj1FAehxUsS6pVrwiIiNfqx11FbG+0Mv3HNhzrsNV4A27Lm7GyrVW0TjTaGAc0QWwbLWHaDmVbRVMpY5koIE7ANoBLuRHRTTEqNxLoHvDg9aaBPq1NiR7ZVjjukn/icps5kAZEoiU1OoDaqWSgXHOq0Sr/AeUN9rCszPRlhiTNe9HdtF2Vd/rNlIM0iG+fHJ2DT1LxAdBDjEJvUfYNRkGuuNrs0kivnsf/Vn71WHfHycUGnothELiNDlr+v7/uRO2y8JvPfIwEiaHxNP+oCqqqiivH61tSbn4Y9KxV3xA3H2MDNv6z95QgyqBPsxh+DqudAVZKagdDwLlhnzK6pLv9f1vqPVyNQtzaE+GxW92yV133cOzzMtcRfivQauXND4kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4mfdsjGBiUrqfrDS3BW32B7PeAbh49C3e3/rSYvCExBy20CehDgk9p3AwKrO?=
 =?us-ascii?Q?k6gO7I37wKclILyRnZ+4EKxMGof6r/bIntUOSMlbJTEBiOaYtBk+u+r1mFL+?=
 =?us-ascii?Q?EZ0/a0mIIAuJcJuPKqcCpvbgY0Yb0YatBqSOMunYcnltZ1+u6luqNCriw9gU?=
 =?us-ascii?Q?onK5JRDPg7x0/z2h5q69ZJsolZF87rpC24Z+aT9uwNre/YQGvGMFM8F+mIUn?=
 =?us-ascii?Q?TaTwOPy/0efqdPqCydmlhx22nET4FAemehZdCEs758Y+2DFtZNYsrGShEQNP?=
 =?us-ascii?Q?P92czRz2LiwmrPm9sI6n7Z8iNCTC7gESKs0cJQtwn65erXqSLs9r0AXp6OK3?=
 =?us-ascii?Q?fjArUhrBo0Q+Ifwo9QlA0OjbpChIy2NNwa3X8VFNME5VUMCw9waOkdZmj4SF?=
 =?us-ascii?Q?8DMoV6Rcvz86xxkG0hPU5+oSAceOPiqoZtBsVyLZhTOalYQ61VTVM7r7bRih?=
 =?us-ascii?Q?fgPhcaiAidDjXn8+eksVznkIcoxcF0d0t4EpfIn7cuefkMpCVfbOC4sZIUEK?=
 =?us-ascii?Q?vUUZnVMIdCG/8RxGEc2LacQiSS67/xpl+JoUigGjDfOw0fc3wrokpvH6GMK3?=
 =?us-ascii?Q?dIMQOeT8IwzFhTEpF7WU03y6Ezb4NpiJClJvwKaQ10KTiPJ1C3U/8nYm7Qaq?=
 =?us-ascii?Q?dSlRxomL8U58355m/nxVhAg9pKF0D0SGamk2P3vtNVe03noIC38sPCRPYEBz?=
 =?us-ascii?Q?zTMlW9Ow4GapZVWKvSvq80e6GDEuz9fI20+WnKKhFH5EdJ1UW3ieiSnrLofB?=
 =?us-ascii?Q?GQimY8X2+oosEoHyVVzHyQU7bkg2zNNcbmaJuNp8ZF1lwf2RwY+wnheP10iG?=
 =?us-ascii?Q?6i0VzR/wkJDRDwBkTWc9PicTWVzW62pjTd2L/IXYdPX1PB/ZCZZ8cFlSybcW?=
 =?us-ascii?Q?BfH638Uo3IYc3eZ03uboICEPkOry//raWxkbUAQIfpT+CGGbqd3hA+G2VqU7?=
 =?us-ascii?Q?42Ti6YaK5zxa1VqhXR3VOsDsdWcxdVSDgzuAfAseGo5myqRtxW4CAhcWG+e7?=
 =?us-ascii?Q?devk7JmSPgmVT3BhjavbrL4Iipz/SV/tmArgR1ASXPOGi5Wmm2ejZEwI2Ra4?=
 =?us-ascii?Q?lJVlg98IRDIAzBg2V8Nr2c61RyfskHCHkw1BEU4ZEPedgGn3h/LTRvjJrJqA?=
 =?us-ascii?Q?2PIRf3/RsDZFhSpqyEHC3ZzQTko8lQGENsTQx1PxsdnQ1QYNF6vjcMCWpT8Z?=
 =?us-ascii?Q?hhr+X2kk74JDrYtsHAg8kkY3jy/+0jcvxGctHATcCgTk5VdxNSLXEa09gFIX?=
 =?us-ascii?Q?QToaSG4C7RXJxl+Aa4YRxW1e4q3KowgPHG8Ki8VIcU2p/y/ZtdKTwSbHZJxM?=
 =?us-ascii?Q?KXCxHFGawBqgyuzSzPocvno12NDm4JG+IJnjmJFY4h4+ofPVR3D+Q9oQUlp0?=
 =?us-ascii?Q?puyv+9TVmJpIlO7XFbmQ8FWZ6K0tOdA5IejkK0JwgA5GVvE1K21aADebHOBG?=
 =?us-ascii?Q?K5qD6K8/lrHS/wgcNrG9M+Ci6gmJABFBW+ryAnX7kQ4/ISVOn2ckPRUJfjdF?=
 =?us-ascii?Q?7bGNPRGxLstnmA+Yv+NE+mlgqhTfY/AJgf3y1JkaV50KgBetjiLl1VG8SRqh?=
 =?us-ascii?Q?v8RFOExKXxOQjUiF/s9wU0kiijNX7h7OIZh+fg60xu+l3DJTvYLmh+dJEOF5?=
 =?us-ascii?Q?PbusgP6zHMekGIrQwE5qJZeefJ9jeelNfMrCBLMsXIZGOA3aJG1FB4KY3lZ8?=
 =?us-ascii?Q?ZglG35SENZYcUVfQn8RPFNGIjTprgOs1TPNGIfScu7mpEU7eQEM+VymhxT/1?=
 =?us-ascii?Q?JY6UzoDpUQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: CaHQvhthqsv9Uf+FwYuVRI4XRfEGv599FfSpUSxBaf5FboD2rj1vhQJsOdALU5E3PW9YcUCTIhGBNYI357XGYg7Wyz+ySNDBRNBqw9zq7gDhDCsAz9qamhCTayNGJoCWRT/AKuzYQgdRiJ2yvlk25Aj/eSLMtCRe4+1aOPErCr23nWZbiAWObKc5dfbYTRWiNXi7csAhuRZkKo11XzxQXuAQSBiOHP6umWDeRMqt9todtQxgXd6l6RxbYZnvGboCc3zAHTC/EaglEJHWvio//pJXV8a7CBav/Ra0Kx6+2ukEjT1WTvOVqjJjYRj9X9UWo8vmif+/OXpqz6HwGyig7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aa78f8-af57-4e74-58af-08df04bd76f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:33:10.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inx4Ka+Hz+8dxP5OJGLVS0FSxT+QEboKNoPHq7L9/Sk876TY7XlvI4ZKs8/ub/D2G5ZnoId+csSTtcuCm8xDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9758
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:27PM +0000, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Adding a test to verify TDX lifecycle by creating a simple TDX VM.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm           |  1 +
>  .../testing/selftests/kvm/include/x86/processor.h  |  1 +
>  .../selftests/kvm/include/x86/tdx/tdx_util.h       |  5 ++++
>  tools/testing/selftests/kvm/x86/tdx_vm_test.c      | 33 ++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 28b33ed8c2e6..3561f9284e6f 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -167,6 +167,7 @@ TEST_GEN_PROGS_x86 += rseq_test
>  TEST_GEN_PROGS_x86 += steal_time
>  TEST_GEN_PROGS_x86 += system_counter_offset_test
>  TEST_GEN_PROGS_x86 += pre_fault_memory_test
> +TEST_GEN_PROGS_x86 += x86/tdx_vm_test

Nit: move this up to keep the x86/* grouping

>  
>  # Compiled outputs used by test targets
>  TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
