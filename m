Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA13ADBA4;
	Fri, 28 Aug 2026 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890860; cv=fail; b=EuVJmCI82eqbguoJDUR7lXQCbdlDfrcmm5nAcQzPdoHHdL8M2UOJPg8YJXae5ot8gqOLw56YYAt0KUeQ1kV4+DhzNjy3J+QLJzfTjzKdR7lcogifFIMKWw++f2PhH3jSisr1X0OKRbA+lhDZVYUMVfYRVOJEdjThJ27GpJ+S2R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890860; c=relaxed/simple;
	bh=EAhQYtWPw659mhLS11GyJurEL8KJVYWqEELtAG56tSs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cSehtwhByk67c87bz4lPUTW5f0nPtaex9jhP/vLMTJej1bB7dyJNTfi4drST4cll2KxgPSXL1rbsW6bGuN8QgrMMWRl9bGfa/pTW4lbiVuBCxjgcj2JD9LgtyBHhbRBJlbMwe4DuGNZlUJFDPRrSphYN5QOcVdd3ef4gGNKJqjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQmLM2ep; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQmLM2ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787890858; x=1819426858;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EAhQYtWPw659mhLS11GyJurEL8KJVYWqEELtAG56tSs=;
  b=fQmLM2epxgcfXUHKR0N19hU1d64aTsQDj+lDmJ8jQETnfjjSaG7lLVwj
   9U6t8k2P8Y0mm41+iejwlxOYGwEcy4Du6NE64AjGs5wl7H8b2wL1GACRc
   m8eV60FQbbBm0cWaEjRFuxwiAgiP+spbR2AU8WSNBhEZaBlRswHR85Mk3
   cs8/3wngQ100Y8uRN0MlWPvSNClHkoTE6qo57XiKlQI9FxkSwH79yTdG6
   wiKC2istcq5vNk01YojELUS4xDummZG9pynJEehOEJSTlCnwI5b4+YPkM
   xNSYD3TbjUomEaAS3bemCJAmyj1soGNYT/XIxH3cm767Jyft+R61UZSlS
   A==;
X-CSE-ConnectionGUID: PFRuRBTNSrGnx6NcZAP0tA==
X-CSE-MsgGUID: D/t+TB0aTyGe9GoX0Mp+Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99066642"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99066642"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:20:57 -0700
X-CSE-ConnectionGUID: mgU5Db4LS32rrYj3pntjLQ==
X-CSE-MsgGUID: N6HMdRO7Qg+UkSCAHLZ0Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="264287932"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:20:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 21:20:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 21:20:57 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 21:20:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzzXeAV5myuzSFFsqslk6/opveX4vAaiuXMDb3eJIDNbXnLpI3YpaWlYh6nvy/vPHV+LeWULAuZowenD4qmYctgPAXBXC5avcBTeOMJB443DPQ3zQJKi7dc7lebuxVwgtSLzG7zZQ+TGtP+xeDNtQtkvd7r9JQqUm4htyfBGZDZjk3BB3656hQd5QPc+nUwqsOFCLeE0z/nEUfhghIwZ9//aWRrcREJfOx/qAi577jjtB6HM2WvhJTupRzSgNrwWIlytBgerF0SPig8lsZ0jOru92GtGfV2LkX19xymXV1xdAUTIZ0r4jfE8fYDtYldB4HsDJL3MlqcC6hPGCsOp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WVxLS6WCFbXCfpoEHy1H/AEsevvHCHnrpgHclLyRUw=;
 b=rjhl5811QwQdm3MVkVON1hPs6J6Kn6Va17fP4rxVXOn+XdNHZjmD2b2qd1NOqx+8GcEnMKVp4Um+porGxP/s7Oq4jUfSjWGsIDs+WbFo4GjMe68IXzi8FpevrC3DBABKcEjMoZUE+TdadpLoncvZaJ9BdUNWmindKl89cIpQNDMNxO3ByFX2urqsZEVmNsPXTro2sc2T4gOAAUo7L8I+/lQf3m8Cb+AMGE3HBIxx6W/Bwu1osD9G/FVDSPbq60KE+Y+cUeGr2reD06pv2rry1o9KMrSUFQei4mtqWXJcTbSShN2BA2/ccTCCTJ1oceGVg4sB5QKsFMeHn82pWKvUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DM4PR11MB5325.namprd11.prod.outlook.com
 (2603:10b6:5:390::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 04:20:47 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 04:20:47 +0000
Date: Thu, 27 Aug 2026 21:20:44 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Ryan Afranji <afranji@google.com>, Sagi Shahar
	<sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
Message-ID: <20260828042044.GG33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
 <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
 <20260828020612.GF33657@pedri>
 <b4cffa34-864d-4fd0-9fc7-a7d4514075b2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b4cffa34-864d-4fd0-9fc7-a7d4514075b2@intel.com>
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DM4PR11MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 87705519-35ee-4e5d-c458-08df04bbbc65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Aj0lnh8U58uep3uBoBPNpI3iCK5SL9ZK9vqU/wGXKxRhXnrzkj65e3AWqBNRVb6Z6q0z+2h6LkEzWNukUtHwze7rt8OsqaEvyB3FJjV30yaXGLU0fWfLWwKIWK22oImeV4RmXEJGDG4zUE3nYfunqkFbXu04wRfa9jEcH08BZzkdcjy00WQXqUotmZB2JqxeAP/Q7lNLFvr3C0iCt/t2C9HMU8NrhODzcAw8XRqrNmiMIbcM41Qu17CxUHIaeXayUg8vbV3lWbVHu590NpIgjDSsddkOiWRicPQ+AfeYtRvTLm/3cv/TM866dw0Ey/9pSSZhy11woaQk0EeyxdNsJ6mnqxoJNqGMXrs879pKI/cTM3ONVSftQGmdYLOi1VIj6rKC9EwtHf2HuIR2WcfE/uby25BAaRWGafQqaPP2Cad3y70X5SymeJgU0WTRraNgpC+75gy1sTMDTI50q6wlZYQkfV9KoiZZrGgLCKl+GDw3WX7qIIGPjoB/HpF29DjHeDpi0XVSJ1AmhGTYnYSIwH0SblXRBF5AhTPCICVmt/zFvL1V2YPOR0lrOUvUFwFdoaLxwD26uNWjC/m876dbIXJi9JgtjNALm3ngaxJikAmjPfaO8U1ddqh+tmP8LCuKOeFg5N1c8xaIqXgKkrcVQffJ1fY74rcDk1B79nYuzF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCuJXO7HS0tipJsw9RH9BxFfh5WGQSC8DtttP3RkdreFlfUVxMJL4OoASxSM?=
 =?us-ascii?Q?PTJ4PX9wNTe73bF9SuFhoMtIWeBGWxLLa6A1jCceW8GUCJk34klKBsReycnx?=
 =?us-ascii?Q?wIIM3MH+PV8gQ1gv0/LKopf92UbjUxmM17dA5iYRz+y5/iBsf92m8j5wpZXE?=
 =?us-ascii?Q?bt5GpKRiNMyTyfYlydLCYghEwc8gzoy04gkc4vJG1u8d1j7nplY+mJKQuZTc?=
 =?us-ascii?Q?v4idKTTEvDQFPHspg1aYr3B/BA2ew2vm5nJkQdG1U0KPw8LnTdUtN9Lx6CZ2?=
 =?us-ascii?Q?NpmdCr491+PoJQQ4iVGiVTlDLWFRhexXp4gycw3M0g7vDeo0XFBoZ+Gfz4kN?=
 =?us-ascii?Q?0CCYSuYKnhPKAoHeH2NR7dsLKGUPnOvgnUrLGaDozrhS6lLDqI4cOn62XizJ?=
 =?us-ascii?Q?TUKv3u1nX4vUX8uEkEu5IruQYeCG3kz/TNvji4PK2rjq/91HREEqeZeMjgpK?=
 =?us-ascii?Q?cuExG1qYxuyeznWNgPGYgPj+9CVD5/dhS6K4EmLoh0B075ikK0gQOBz7qtCx?=
 =?us-ascii?Q?FrvOkiDA0KfmxV1Q8BZ0s887SB2LjdEuALG7N0PzhP8/KA8HZRfIC0H3V9yK?=
 =?us-ascii?Q?uo6aIBoEAMrcmi+T9x6tuPkDi1PcYwBdD3GVrzUw+PpQNxcsioGCD4FCEl6h?=
 =?us-ascii?Q?8D5QUNH+c9OgOvgbIVehGqNqSIArrkuA6dPiRy0o4pcuxLTRWLvTZJFRx8Fp?=
 =?us-ascii?Q?Ev3fUCsv5cfrMLGqDBLPs1hY6M8t7Vkz7hk2sI/XjIIMERVkjklFipy9XzdR?=
 =?us-ascii?Q?JUEuRPqv7o/H306NJSxdBfqrzTnfRws+YVXt/tLxUq+msQUcHTLkHPmeinlk?=
 =?us-ascii?Q?YrrDdywp75Fr+sLadbQ1UrKFaZpW+c+qfREncUNaBcJbIZbeHJ3ZBWN5b3CU?=
 =?us-ascii?Q?SgjwlTZkLEawK8s59reDmWzXQ4X0W+FhLbvmMiHOaQdTdReQGU0N0efpJf8J?=
 =?us-ascii?Q?9nbYGCoES4IB4YE7Af8T7daRdaXBZsQsi+gmIGgFnhdZDKhBLvWwOsAZdVwV?=
 =?us-ascii?Q?SJ41SNB/oIlH7mQMdhqDJ6GIJeYGG+2k5/PaYPw5fhh2mNEi06YM3WcAFASR?=
 =?us-ascii?Q?9eYMI/Z0OQ5B6RG8uFhMA/UF4ABfQyB/5xWoqDSgd5Lks3ScYGRUHumNv0qp?=
 =?us-ascii?Q?K5sHOD5vW2Aowaf6PIP4UCLopM0hlGXEOw/HGqkPa1SlBSjz+JJ6F5CsQy0b?=
 =?us-ascii?Q?oR2/rgPmh6omRtOjuowA1gUp4X3pmM1HvyJ6c5r2DxsVF9cNMTRQpnGpeYSJ?=
 =?us-ascii?Q?yiKFA0MyAvphq3mzBst2vp2r8HqtXNSqBezj/ie1mvsQOWaTZYMmy5dheohs?=
 =?us-ascii?Q?ioCrvgyRHHzmRZuodStohiYEaymd7+6ZGBtkkXN21WOGubB5iI3eB1x4V+3K?=
 =?us-ascii?Q?Vl3cIRmrMXJNM4qOFPURKQaKNAn0ahTjVjwfhdF7QiL+YmvIAkPM746O6a0m?=
 =?us-ascii?Q?hMoGGjpRk0VKM0AWCvqW+ljfbvsTYca1KO3Ul8vxNdsmTbTugJ9hIXhSPBe0?=
 =?us-ascii?Q?h2Oj4IZPJGEVuYFFBK1kzRG6uIA43PmtuCMssIzCw06brmyAaKrDLTQiyCwQ?=
 =?us-ascii?Q?4sZWi3/vP3ciXiWVeERmo/9u8ovCixD/XtCndAZBOAc+dX4ALL+rW2HzK16n?=
 =?us-ascii?Q?rfplPR3LP6gtO0sFUhOzOEk4i0YXkUhsCJ3jkhr7HGlsbtVea9FX9L8Qorpt?=
 =?us-ascii?Q?hjJf/dLGG9/x2j4qwI+L+D6tcoYNqQ3uleHXwXV6qWrL05eTOGAgrBjgLrqW?=
 =?us-ascii?Q?YUplTEyZzw=3D=3D?=
X-Exchange-RoutingPolicyChecked: WFlXz5utCJ7ancyv7VGuXMKdzus0Nic6EQHl8K6WQoKdBCrisCJJOh7LJqQ6KxGoSAmzF9wc0AlibkM/8oJ9fGx2uD3H8DgFj+B1qK8pjvev1KL6kFiowJqoeLDUQyDEuNYN3LNI9MoiWpzf8r0v+CXAJr8VA1anT9Dwug/q97+yOfE15GdBubG+8NZ8ZOaXE9y5nifX4WGcVO4LBPD0iJKBv08yQmJlCXJG60R93fsWjSLZ2rLWJ7XGzqtWYMlypTRR0G7RzZkfwtS2EGWLAsBm/jf09Hgn85nM8+SspmAdK5ydlNswKiLjohiXFajzzIxhZOT44eGZbJRr6Rqgpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87705519-35ee-4e5d-c458-08df04bbbc65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:20:47.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8GnG4e6lyT/gQp7tqaBZ37ym/8UF8JZ+pOSmqkpobB0th3KqP/zQ4FZj1Bf/wFEY3x2XFMkSjAfERgkmDJ1zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com

On Fri, Aug 28, 2026 at 10:31:14AM +0800, Xiaoyao Li wrote:
> > 
> > Hmm... This makes me wonder if vm->arch.s_bit below could be replaced
> > with the same architectural approach. GPAW is available through
> > TDG.VP.INFO or the initial RBX value. This does require a bit more
> > plumbing though.
> 
> I'm afraid not. Because below is host code, and vm->arch.s_bit is not used
> in guest code.
> 
> Or are suggesting something like dropping the
> 
> 	if (is_tdx_vm(vm)) {
> 		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
> 		sync_global_to_guest(vm, ucall_mmio_gpa);
> 	}
> 
> entirely and use below hardcoded value instead in guest code?
> 
> 	UCALL_MMIO_GPA | 1 << (GPAW - 1)

Yeah this is what I meant. Just drop sync_global_to_guest() entirely and
do things like a normal TDX guest would.

> 
> > > 
> > > > +	if (is_tdx_vm(vm)) {
> > > > +		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
> > > 
> > > So the passed-in @mmio_gpa is not used. Why cannot use the mmio_gpa,
> > > 
> > >    slot0->region.guest_phys_addr + slot0->region.memory_size
> > > 
> > > chosen by __vm_create()?
> > 
> > Looks like this was discussed previously [1]. Maybe at least a comment
> > here would help?
> 
> yeah. A comment surely will help.
> 
> > [1] https://lore.kernel.org/all/ajGaMb6Lrk3OS8B4@google.com/
> > 
> > > 
> 
