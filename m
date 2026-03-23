Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85DA59
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272492; cv=fail; b=EivIur10Fji6TXxOL/2IALqNMHTvehfIg4nZxWiPU1Y818opoBLZ2a+8/dJynRzb9kH4U+xcNsTEk+rJWMnheVv/qm4ve54Z+mdj8CzU3Cd0Svd7rIfUyqz2GUHFDXOw5OT3G9HQNjLH9Um8xzzG+a0P+88ibWbkS4UHB/af/Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272492; c=relaxed/simple;
	bh=DQ3sepH+OFEJD4EjlDTwnC0HU7Z9PXmUW+1l9azjgi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DeMx3/fLwL60/pil0298T5r8hFIYTpGhMjj4UxNsRXE57SumaFi+I97cYQZyb/JT4HibSQ3nQq7KZTjFUuoI2sEHgF2U0rFsdHc1pvpif4Z9MPkQskMn/IVreY5X0Q7tCo6rQQRgH8sE99l4VIdp/Bb1TNwgkJ1A47FKNt1LEuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCHbbo1q; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCHbbo1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774272492; x=1805808492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DQ3sepH+OFEJD4EjlDTwnC0HU7Z9PXmUW+1l9azjgi8=;
  b=RCHbbo1qG3WbWneU1Ygx/OWyVqCxz+14deyGjz8rShI3iEc7kkSw09Fa
   OSv7Lvj8CwOMn6PzDvKi9xz6Yjmj1tlaVTkVolwye23FWXOce4Zfa8dfc
   zwuPtBvzZBB1tHe4xzoK48FaIHLEo3RBqUyz1QfM9YAQIfnwS+6iMlDJP
   smah/H/pvHCVBOk5RJGVDRURwgPlCGRe9lZzriWuqlTKEB2G5y75/7+4U
   D+aZ4MN/k81yfGYLO1/84unQyTo+xIWl+jhxbx3E3drwfajRSDkdaFv9c
   +jKM4o/SfDXuYaQrJL3rcpb4NOhCUZnf2ZXdKXq6Ev4Yc6zprTd0+QyRw
   A==;
X-CSE-ConnectionGUID: OwRkAKS8SceEUYZoN8bfLQ==
X-CSE-MsgGUID: u6wVWakDRM2iBQHuP8AzSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="86743328"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="86743328"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:28:11 -0700
X-CSE-ConnectionGUID: WWGcqbmBSj2Ooatly+7FCA==
X-CSE-MsgGUID: wYoYZOZ3QmCESTPpAX9+EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223216411"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:28:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 06:28:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 06:28:09 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 06:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoZMqtk61fCpdFUszSHPnK8WQvHQMNSNm6XqL94tHVms1J/rEtaPMOvK7n/ZKc0BOZ0GTmbzbK1+XuJ/7C4Riezinr/FdnPL1Fl5Gvyv1H0d7RtWSkD9LlekTXkXYjEUE2IzRx3LxpeB36+cDdtSD8DW0flKd3IurHkhBG6iGMieHKiF2FnNNJcVzqcqB1ALQvKZIXjrkJzOJSrZ4DEZs3hOl57drSVhGECQHez+IvioA1TDkVYEXtBj87plhAbwquxuhE4Bs0oFjYMIi+gUQOa1dzTm1YuXEwVIff9eb7DBsYvEsipcaY5ah31yPDUi8pmc135ueJW0a9YdLqb2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19Uvef4tnl/rhfceFWFe4swSLN5DwaCjn7XEsJZNxKg=;
 b=jEcI79EOhrxhXC7eceORHi90hVzTNmjWJi5OgvNnIkd9vwYILw7sQ/VbTH41zY0VLGcVVjnBSFYNUczr9n01FOLAMguKOWxFGciJFw3onEGP6rAKEPtV9s0MzVnuGGoKw3H+TEyQs5fZ194FWgU+26XeSOWqKXngRs7WvImdH23KgP8lrPQueILF95IeWn8BXIpoCoB6dwcSWvACtkKz520QWXvyY3YRDguDbNwQsjvim8HjQ/B72mtiIYd63FOqHvxv/JqgwDFcfOk1QliiFb29DYtyOG+nVpCHOS3duNWswnX9DmauGvhSom3GlUcZZnt8AKUDlV+mMkH5nSbpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:28:06 +0000
Received: from DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::1ee8:ba94:dde9:5267]) by DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::1ee8:ba94:dde9:5267%3]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:28:06 +0000
From: "Hao, Xudong" <xudong.hao@intel.com>
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
CC: Sourav Poddar <souravpoddar93042@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH for-11.0 v2] hw/hyperv: fix SynIC not initialized for CPUs
 after the first
Thread-Topic: [PATCH for-11.0 v2] hw/hyperv: fix SynIC not initialized for
 CPUs after the first
Thread-Index: AQHcuIEHsk3ggRxo+UK/j6bYZLEjorW8HQ5Q
Date: Mon, 23 Mar 2026 13:28:06 +0000
Message-ID: <DM4PR11MB5278ABAD62281FC367F3E4CD884BA@DM4PR11MB5278.namprd11.prod.outlook.com>
References: <20260320154752.204725-1-anisinha@redhat.com>
In-Reply-To: <20260320154752.204725-1-anisinha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5278:EE_|IA1PR11MB7810:EE_
x-ms-office365-filtering-correlation-id: 1e3ba3ae-4d80-402f-6b23-08de88e00474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Nc6/5QalHR7iQcdj+7KgJOqVxN2PPrGBAC4/+br1Wutma5rRLhEGEdG/pkt3v+PwJzCCELpNLW7RNWoSRz9uOx91rhm8dhdSdlUYCwdianARX/NsOfsIiKTeJajd1nayDM1RG2Dd810TeKV3YAZ/Hz6k230mmYofk8SfbQ/bsDQKg+f5K7vzrtQS0zEF8Nqurp3OhOJW5/4n7p9LjWH/Ntpf4ORU8Zz19ruU98/vEFnBcPOctN+UA1VvwmvFiaLpvBgrdhsTc1CiCkAo7N4bgi/3snPnMrXrh0ILXlN8mlMx/AD5Hcje1PqS6J7bk1tIBnvXifRmYuxcAupTFFsx1MRhoxPtd+XsP8uQtnlIOhPKgjyb2baApgpOu4UGgDu4MYOI1628pzt5NYAVXCo2DZasI/60j/wgBwi6eQgK2l7+6QSVB1qbXFmZnl1NFk+O0rwhCz1dk/oP0D1+3m/a4zbfIpdDmt5v/hpz6qcg+nUzGpH3rJvJQ8hbNEoCm2/WvqSv2oiG5RdvNWjDpp/nRCkxjx+wGNYxK90K0XBwargCirFrmWPq/UTi0zogVJrX+uqCpxBjoAIusNa0oztkl++88fJdSxWoWp6uimvrOM2x8c7EgYnceM139QaBEpDTyzcRCEp87y2aeke1CNLFAxEj4a6kU0oWtBO3fSTz+MINxpZlJC7kdsMry5NFv2Owdgtm6S02gBaMFpMHFKViDjKeRs+nLJY6CSe+wm2IziTh6dYLrsYG8tODg4bgWIyv+ZlZhwNw0YSCxihlszIEwy42h/BGE3qagSamkennGgI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OpR9xY9fpH4cwi1kI1hGhGZeINtt36InoyzHRdzkWonPw2fXIeC0XH4GV6P7?=
 =?us-ascii?Q?XHSvN6ukuOhsK86oY5mNah/Wlw/KfcvnDHG4LYmc8BTPvjNe9L7bgaRIr7/N?=
 =?us-ascii?Q?bT4fX1c6UUiAe6u2g+KFOp6TCuMtb4yB7XJTVPQahktkonoNEAFXKC6KigM2?=
 =?us-ascii?Q?s6meRqh2jCFd0mMcYO3bYz4pI0sSvnIbsTUa0sf9x/qsg4WJqF2pLGwVOiTW?=
 =?us-ascii?Q?uTIutRMtspyzQxOAuKsBrUJDR7cLYIgtwkZJivTaA25NsZY/gJCKRu6z0YLS?=
 =?us-ascii?Q?EgNOgB6Q1ThTitoVG1grLOeuB3mw7gQCHa4wKdrJ2fn8h2ScHisBpXGOm4ur?=
 =?us-ascii?Q?7IIhkTWEgO4HLG26I7A0IeqJkCSJTjsC1C1KbtnV63un5uo44atZJHQMlS90?=
 =?us-ascii?Q?8oeQF0Wu0E2W9X4r55Lf+YNfjDRFdKx/Z7hmCVTvQFe1lliCwRR2FZerNeZc?=
 =?us-ascii?Q?oKrhdGxL5uRrTN8YiIz83a546Ui1wEsJrcDUykJO/AU1tpvfB5YWoFrJpjak?=
 =?us-ascii?Q?/DkMPnf80XycSvy7lxFZwlSmJj1zXabsMYm6nfLddQoJM67Kdgmy5WB8v4my?=
 =?us-ascii?Q?66ua4EZOXCCOhxgH5BQ4UWmvgowZpQy5+dOodAa0WAjWzLmThC+J5bJAsATY?=
 =?us-ascii?Q?Dt82LrZYjYQeUZiBEXlRm2TMgiyCQ/NFOepnLIKLykBuslbtMvD+SjVLs6b1?=
 =?us-ascii?Q?2tozPnDNSDfRSOvEMJIsg6tA0bkMJsOrW0VP+ayXoW3fiRrLYvJn4K4Ee4XZ?=
 =?us-ascii?Q?VBNpHMPDY9LX+t3g7LbWcyYVhrasnACtz/kChEPbJ7ZcRBpYMQuck8OnMFU0?=
 =?us-ascii?Q?o7DzugNilf1UQnx94RWl+BIYjudJwvcUmfJBqeLWqZjCk0IFxmN3QmB52asQ?=
 =?us-ascii?Q?hwx5SdwA/OmxudhvDHhejt+RLD2DituFR8JSqB4cibVUlgf5z/pVl8uPkI08?=
 =?us-ascii?Q?UqBbn+/M8qG94ltZnqTTVnMzE5PLtjqAkQfLT0xad66R6mG1yo/Zlce/Ld42?=
 =?us-ascii?Q?VAvHt4IrQJX54iY8h5TSbYN9TQEQkoU4w9FQBqE6UCHBCcVfHiZoJ+I+AXbE?=
 =?us-ascii?Q?bkOFKd5oL/ru72ALj+8O9vb+Wf7bCfx8vxJLUzaCaLpW8/E9dro7J6I83oZT?=
 =?us-ascii?Q?5u75lB2aHyOg+2WbiYxafSSICXv0TCoAUol7TvAnLotu9zFI7rdMIsgXWDtx?=
 =?us-ascii?Q?6/I7TdMofhyQ9QXQ3ZTBIAIX9NRdim7OhS1CiKOvl0yaTEMbsQD8FOFLYlQg?=
 =?us-ascii?Q?kKAe1X/mQFUjjS71jr+Lw8GI7eHecTc9I2eIrblJ6KyNcDJhzFIxm0gLuVGm?=
 =?us-ascii?Q?cRkSUG9rh8/fL3BViG1tf1uU5mTtYD76K8TjbaJzzcpDD6/vJzYXgPkP8l3C?=
 =?us-ascii?Q?65Mjz275eK8djSYV5leAs6PIPk67XfoF698Y4nnQ+GOMAgxHY7vk++NFlpNi?=
 =?us-ascii?Q?QquqFcesQgwUiNAhztVHMfecjGBbwi7LltOqdm5EOHt/+56PZePrbtsHCtJt?=
 =?us-ascii?Q?N12DeXNACkr85jtdTvsa4JUfzgCFqtfE4hYQ8YOO+rXPPrTexom1rpgN6TBo?=
 =?us-ascii?Q?4Yzvs4gpr3tJ0970ob6Ng931dWXsX1nL6ocB3d22O8pBondSLVlRFpo0+83E?=
 =?us-ascii?Q?SQ7/vItpNzfvrBvqjEaH3snqdVHLRnEOXJFpOtYfM+EAqskN+mmY9q8iz3fF?=
 =?us-ascii?Q?FBoU6ITtHdX9Ltmlw2zOBP341akgmDWZk4wP2BWJmZQbyWo6M95kSBbRYevd?=
 =?us-ascii?Q?t8/MXDN/qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CMszi33ZCEYuj5WLgkRvahpXqTUL44+AcKmJVwTOK8UJkMXt1pdTUB1LeF6en6Lo9pahzyUQ35YxjyM7CSC8W3sg7rMWDdcHVVvvv5RshYCMk4cFEYpuu/3Wm6mlNbpfgrYEsboVAmExcsEWNFWB+kGKTP8+rbPyeWxCvbsZoyiZ9ZsZ5CMBzY2FcYgZX8NwfSyKL1O2UGlCJXS4m4V+V2+kjszQFk69q2gGcbTn7BodQwJW+Ra0bet02zKZS0jEsS8q4464BwSQNHgmIfVBdqU3+m4khXCsjU75Zu/Rwye1j2S5UE3vinCD/dLHbgRgv/ZMHLYaWrYUR/vB70BloQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3ba3ae-4d80-402f-6b23-08de88e00474
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 13:28:06.1694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0Yxgi2+U8fcRxYh8o/kTXgcC7XFMeEuGgqCp+/JL4iR7SHYfYlJ12RGavZrC1jHAhvHkFe+E+PVpzC4wsu5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Ani Sinha <anisinha@redhat.com>
> Sent: Friday, March 20, 2026 11:48 PM
> To: Paolo Bonzini <pbonzini@redhat.com>; Marcelo Tosatti
> <mtosatti@redhat.com>
> Cc: Sourav Poddar <souravpoddar93042@gmail.com>; Hao, Xudong
> <xudong.hao@intel.com>; Ani Sinha <anisinha@redhat.com>; qemu-
> devel@nongnu.org; kvm@vger.kernel.org
> Subject: [PATCH for-11.0 v2] hw/hyperv: fix SynIC not initialized for CPU=
s after
> the first
>=20
> From: Sourav Poddar <souravpoddar93042@gmail.com>
>=20
> hyperv_is_synic_enabled() is a global flag that returns true after the
> first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
> hyperv_x86_synic_add(), leaving them without a synic object. This causes
> get_synic() to return NULL, making hyperv_sint_route_new() fail and
> triggering an assertion crash in hyperv_testdev.
>=20
> Fix by introducing hyperv_is_synic_present() which checks per-CPU
> whether a synic object is already attached instead of using the global
> flag.
>=20
> Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its no=
t
> enabled")
> Reported-by: Xudong Hao <xudong.hao@intel.com>
> Co-authored-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
> ---
>  hw/hyperv/hyperv.c         | 5 +++++
>  include/hw/hyperv/hyperv.h | 1 +
>  target/i386/kvm/hyperv.c   | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 27e323a819..3d6212613e 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
>      return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
>  }
>=20
> +bool hyperv_is_synic_present(CPUState *cs)
> +{
> +    return get_synic(cs);
> +}
> +
>  static void synic_update(SynICState *synic, bool sctl_enable,
>                           hwaddr msg_page_addr, hwaddr event_page_addr)
>  {
> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> index 63a8b65278..23091301d0 100644
> --- a/include/hw/hyperv/hyperv.h
> +++ b/include/hw/hyperv/hyperv.h
> @@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
>  void hyperv_synic_update(CPUState *cs, bool enable,
>                           hwaddr msg_page_addr, hwaddr event_page_addr);
>  bool hyperv_is_synic_enabled(void);
> +bool hyperv_is_synic_present(CPUState *cs);
>=20
>  /*
>   * Process HVCALL_RESET_DEBUG_SESSION hypercall.
> diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
> index bd3c26d02b..420c76b5ff 100644
> --- a/target/i386/kvm/hyperv.c
> +++ b/target/i386/kvm/hyperv.c
> @@ -27,7 +27,7 @@ int hyperv_x86_synic_add(X86CPU *cpu)
>  int hyperv_enable_synic(X86CPU *cpu)
>  {
>      int ret =3D 0;
> -    if (!hyperv_is_synic_enabled()) {
> +    if (!hyperv_is_synic_present(CPU(cpu))) {
>          ret =3D hyperv_x86_synic_add(cpu);
>      }
>      return ret;
> --
> 2.52.0

Tested this patch and patch[1] together, KUT hyperv_connections and hyperv_=
synic test passed on Intel platforms Granite Rapids and Sierra Forest.

[1] i386/hyperv: add stubs for synic enablement https://lists.nongnu.org/ar=
chive/html/qemu-devel/2026-03/msg05955.html

Tested-by: Xudong Hao <xudong.hao@intel.com>

