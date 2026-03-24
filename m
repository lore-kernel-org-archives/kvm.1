Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3590E34F48C;
	Tue, 24 Mar 2026 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346647; cv=fail; b=Qd4z/gg30Ij8wes/OFSEQw/u8v5rD0n+Tee663NQI3ZQjjTEJ6jOjkXtNe8HworHIAwndvSMvW68ehYLSgHRxv+WhS8sK3U2IHKNEcQDJ7n8irDJVlZG7wSQt+BP3z6jIvGY0/dF7pFXUYh/zi38QAb8RCmBghwXNrMxc0FRIu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346647; c=relaxed/simple;
	bh=qWA5wy28m1vUc/7naav6WUv6L+7BDJSDTLryMFefhlk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tlSO133VOXciPrKO7/FdunVI3DBR17KPPFQHssJln1vKotaiI9W0fuPSbXVnIoBNmHoalrPClqZ6AHnTttUHv3kJ/w0Rh5GoKoeapj6bpWSK3bJgTwPhGptNVpPHgU5mZFmlttIOyjYDvUOC3wflTRspCdhNl3Ch0VOHG41Jn2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwCGWoBv; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwCGWoBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774346644; x=1805882644;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qWA5wy28m1vUc/7naav6WUv6L+7BDJSDTLryMFefhlk=;
  b=jwCGWoBvJFnHzW5eu6g9LRsrhkKe5ujKEXJOx2qGYqfdnZrMm3phixiN
   iq5zs6Zbn2XsuyRprz78MkT1HMIZB4WchnmEpkwsa254q4FhZb/JdI/fa
   jyNQsUqljxaxPWKLtIlB+8xpF586LaXelCM/LZ27n9Nb4s7TwalbG2qim
   UdNh35TQGhlA7sDNU7L9n85ABwF+pVMzLpKVJcs0MBVuO6WLzNd+D4U77
   X69cWyAURsHgycHyCTLg3PyjVqBZlwHsXpxOpN3kGUPdsANBUQ8/qjLeA
   pJWN5dpaXqSAPU82MwFRn0osWWrgANgS8CQT8qwhtLsnnLzdwIMw8mngQ
   Q==;
X-CSE-ConnectionGUID: LVSi7+mpQhaCd+dm5JtBnw==
X-CSE-MsgGUID: U92Kc24lR/eDUHUKhg4l7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="97976471"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="97976471"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:04:03 -0700
X-CSE-ConnectionGUID: 9femeym0Q/KkhoGhe6mYWw==
X-CSE-MsgGUID: mK/qA8GCRnuzoAnpg/qyqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224281313"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:04:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:04:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 03:04:03 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnVe7A4fydo1qTd0IjGPwqRTlG7Q3giD/TqEQfG4mqebXuUyUg1NHTp93fv6oEgbnfS4/t5awYRBrzOshNNydzUMcCN+On32jZRLP5PrHZjvVK2pPY9Ga64EiKJX+9+RWwy+66zg1moexFbDItPC3ZpANVgvaDNhzsfExwI3MpMSMZq/Hp6w4dNDppmuJmhkSholE/u2MeM1IMGos+UL1wg+msHwvT021UB6KSNMwmf9rH/SeGycTV7yjGZe0fEJckLuOoJFxiXRSf8mpt+wzQ9TO+1EKbID303kkEM4hN5OOGMopNKLuJm9lszHcBnpearspYuFa/4/72yT0koTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWA5wy28m1vUc/7naav6WUv6L+7BDJSDTLryMFefhlk=;
 b=gC7VnyF5yEMoyzQmmprcotuZw329tj+4mopQTzjvT6DPvqN7t50nDJfbCFrDw7YDk+Sq9m8aftM619+OHVMlV38ZrSL0fk3mK6/XzZsvZAjoTTvX9HchvMDqFyyDQnlwi/8REYS8ZzWWKBo65dZvMAUeZeaIbpuaG7enhdjExbV6rmQri8hnIM03+iDU9sYpdyYGTpT3DVsoeRcZ3DeYpIt9GFHkBeIEi/014U1Yd7ypr56QQO0kPz8anCqq5NHxmNXBIBpQxYXRl8djUCbbsBXJXVgXTl5w7/lQiDGrimGf+UolnOUNh7KMHk+lrkWQz2+f9YqTvbJaXqKFkzbIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA0PR11MB7188.namprd11.prod.outlook.com (2603:10b6:208:440::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:04:00 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:04:00 +0000
Date: Tue, 24 Mar 2026 18:03:47 +0800
From: Chao Gao <chao.gao@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Message-ID: <acJhg9iNWaLSZixu@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA0PR11MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: bf85a36f-441c-4a0b-3d81-08de898cabdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: clq6VXIUSRRBCEWU2RGHouISMqqf9XTHvmGgSnh+dX6I9A5Mk2J9IcXT8Uqgu1hU/hbc8s69fiS35oP259zxlwWAyMOebU/0/bWH7nIcYy7oITieHQZjx0tESek1iUtk2kUubaB9QxKfzMCaiOHxiXcmUiEukSzS7UeWXBGANWiVTeJ2mfBmuG7JmZ+jaJYmPK1Cz3W2e8t396AvlkJYFogwNQj8wPMvkOxzh53xoBT6BWMweMLljwfVuly8DBZblWLHerZyyOAzhHTMmCSndI6ZHQsSmxGg7dZEZEJn6aFdhI1bj386n+QyX0rhFubKXKw23OT2kDMWkug0NiRTu2UImOZnnc7CPyBtyoIj4LFvZGuYF5TrCZHZAWUaX0bbUb0f87dAkEq/fcPo9ul5690GeZG/bjxUui2+6urGVEHRNyxpENkKoz4wmfSj7r7xw/gP96seuDXyQ/C4cPKE+dawEEFcS9ZG81havP45ml3HrBU3GWmFACia343JW4qhp1rK9qjUpuz8rVde3IYXVZFDjLTcCpHXwNuMQg7QexbYaTL6EEWszFrkgfsi46/2HtWrkEawfSSCzYxQdr0VdhqlpoxAfoR/AXNVhep7NCrYi4eiY5UgND5LYeSg0xUdcMaUAt38EBmax2Z0IUV/Srin/jLM/m0xGGHex3AuzWiuV0NY1+1DhI5KtDqv6YnKQzJUY/HvlG77ugk5c+6A9lpXTga7pILA/WQQBAIZlJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwhmRjlwGowZOa4Es8xZut17ajbPoiovgJcA9+S9+/vc0nESr1VxjeUzxwL4?=
 =?us-ascii?Q?Vx+QBCzqSeOpeggT/2s6MOQgrjcyckyLa3l3uUPAlDvIc7gUAOu3RKJ0299r?=
 =?us-ascii?Q?DVAauQ27uEI0ZsX+fUK157eiz1bghFnIyvZ/CJN0EcUaoJ5gJqZt+igOtHth?=
 =?us-ascii?Q?nnec+6iKCp6BMEEkhaZPX9hf/3hgJBhxNVhRSO99MCzfa5zOgBgiA8vXJmH1?=
 =?us-ascii?Q?q/c8JIsVJeYhQmEunbSyY5CahzNEI0vw0J8hLxcpm5r2bCUp8p2cdQzb4EPi?=
 =?us-ascii?Q?VRdVc1rcbHww/1z8fy7byUSLCPCaFFN7vL/NZbdnaBKd6+vTAOPVC780czKb?=
 =?us-ascii?Q?0ZG7rf4Vs20aYQlSqyqPTz7e7C/hCKMiDzVCHbh6IuIGSoTCZsY81sqTAUYi?=
 =?us-ascii?Q?7Q4SCPx7LUGbOVGQS/e/UWCpXnGz0hJaSifdmxNQFfJvR5+uhbtlGs75hJUk?=
 =?us-ascii?Q?V53JRts115ShZNUlFTb0cEf8dLCC9mRKuVPkkoADGlDtVR3FcHZJkAiBMlPF?=
 =?us-ascii?Q?IryeFeZ007jBeFDJ+jNPItK3xOBESFQVhaW8mNhw6HRv7xofc8fnC2AwoP7F?=
 =?us-ascii?Q?LToZDiTccW1qlVZwJEvENibA1MkS/XojV4ksYYXJjdOUd9lOYphZTTYZa9kA?=
 =?us-ascii?Q?5m8qK3StGAkSpYH93IEvZIUGkI68zZDBUeO3RrMUqUsi4PXvtnBTlgfjtJwL?=
 =?us-ascii?Q?K4+M4v1jUdJnQ8WLzmAh2fbyxkUoWkAvMuzaeEN8gNs+2BSQRcFi9Zw5swi/?=
 =?us-ascii?Q?ENrsDmf4zrpfiW5Zh3XtPZF91TjYyYDGTalHqouR9+4pJt2/2hE5m4QEe+t4?=
 =?us-ascii?Q?jskC2GF1fOptGZLW2gs7uc+oRGw6wwvYptMw1+lQdo43MbXjQh6Pu0oadC3t?=
 =?us-ascii?Q?AXpN63QmDRcqSkSgqqauilsUoqhqcPeLWbSE2of1dVO0M+8/E+23Go5RZpas?=
 =?us-ascii?Q?1a9zRYEL254SgjvamEHmwEdfx3VzwJGoOv67qPkzkLGFYU2KWNjLckq8SS0v?=
 =?us-ascii?Q?j7Zfd+s7LEq7jiN3cjxQicKvsKF0x+/upO7ABAsBlLXjw58y3RFYKm0Ro2uX?=
 =?us-ascii?Q?jn4iSdIqOjC0EMKMMd462DZNDPZt5C6vYn0nwRdhnzsh9hKq6Zrhqburj3I+?=
 =?us-ascii?Q?Dz0bCYPU4bxak0VLgvfe+ni6ueAo8XoQoFebnCGaKCkcjXCFH63coaaXVlAa?=
 =?us-ascii?Q?zbiVp8qsFR3RNLCbm/ZbpQ6ORhX2hxxWQDacaGrgBGDxeU2B1vIwcEIJ41RL?=
 =?us-ascii?Q?VCM07SYXC9xWfjZDv/XvZQlNkI7+Jji5K84Mbf0Qg6bfyJfaepu3LRD8CqtJ?=
 =?us-ascii?Q?LzBTOb+YFfCIAkG5C2CZuc1QFGEUsO0pjqpuEI4YLBKoxwQPtDmjCBjmMqcQ?=
 =?us-ascii?Q?j866WdFeKDMf5XO09zP8bbw884EP7yTJAJiC/q3dohJwvEStdsOeydYounqd?=
 =?us-ascii?Q?h5KadfanLdcVgfHpONhUzvXdSSMCfTdOAUEi/2uEiVQx+APSXZ92QsJBHhbJ?=
 =?us-ascii?Q?m4W7aq45/dYJqMswbamA09H1cRy4lIHinSyduIX3N/bqYoGYk0rgeX8TvKNv?=
 =?us-ascii?Q?6Jf7otQ6747a0kzI7bxYaBEvmOsxiumGGvcUtJWgRNBi3cFrI0gHWpc8F9Rl?=
 =?us-ascii?Q?heiebw7qE2G47/nXIeo3VNHCqDDi2/Gmei4bpGu2bPlsSTFXDJ2YvjsL7MHp?=
 =?us-ascii?Q?m6wl6guFvjIG2ZCpWzZdGiP/qYck23qXsA1kJsfTT6mVSjn3kHaXtJ0nGfOa?=
 =?us-ascii?Q?H9ZfAX4teA=3D=3D?=
X-Exchange-RoutingPolicyChecked: fS9FpY6oe5CDFpH0Y45en0LR7hcSeYvwtzpcGbssyEeDqWGAhUmS3D9MDHMXyK9p7XZZEJwU8O14ZdEIsBK4mEV/2ScT8WqqlrCCDbMob4A+QEzukUVZtV9puVNF4jHcafQNX8z04SFvJRzOy2VHoxgQykKinjPqN6CrhoZg08m2f4/MgsXJ1bbjrcVNxsV4wnKkodmRJpbCoSTtQW2ZX5ZaRbvn3tDrKCZRU9zZzTmdffWd38WY2oFDS71P08Bc+uPH4blfLSwubilfUfm3v5VK5jDetynujezVlcnVsXTrOtCqW0Nzett3TLgqp7jgE/zxGcTIZJJNJLOMoumPYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf85a36f-441c-4a0b-3d81-08de898cabdd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:04:00.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lszvfTL0dMyDxkH3qqngGdRADB1Msin5J3j2FzZoehL6VepxqVl/rfjhjs1me1+qywDR0TbpZV4u1rCM7S3wKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7188
X-OriginatorOrg: intel.com

On Mon, Mar 23, 2026 at 02:59:05PM -0600, Vishal Verma wrote:
>From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
>KVM tries to take care of some required cache flushing earlier in the
>kexec path in order to be kind to some long standing races that can occur
>later in the operation. Until recently, VMXOFF was handled within KVM.
>Since VMX being enabled is required to make a SEAMCALL, it had the best
>per-cpu scoped operation to plug the flushing into. So it is kicked off
>from there.
>
>This early kexec cache flushing in KVM happens via a syscore shutdown
>callback. Now that VMX enablement control has moved to arch/x86, which has
>grown its own syscore shutdown callback, it no longer make sense for it to
>live in KVM. It fits better with the TDX enablement managing code.
>
>In addition, future changes will add a SEAMCALL that happens immediately
>before VMXOFF, which means the cache flush in KVM will be too late to
>flush the cache before the last SEAMCALL. So move it to the newly added TDX
>arch/x86 syscore shutdown handler.
>
>Since tdx_cpu_flush_cache_for_kexec() is no longer needed by KVM, make it
>static and remove the export. Since it is also not part of an operation
>spread across disparate components, remove the redundant comments and
>verbose naming.
>
>In the existing KVM based code, CPU offline also funnels through
>tdx_cpu_flush_cache_for_kexec(). So the centralization to the arch/x86
>syscore shutdown callback elides this CPU offline time behavior. However,
>WBINVD is already generally done at CPU offline as matter of course. So
>don't bother adding TDX specific logic for this, and rely on the normal
>WBINVD to handle it.
>
>Acked-by: Kai Huang <kai.huang@intel.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
