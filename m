Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B83EF66D;
	Thu, 26 Mar 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528556; cv=fail; b=Y3cuZ34ZgrbhEm4p+6HXRT/kcM542GKBVGw9W1xrj88+U4lO6HMJoGPa1oaAtx2GUmxaD1emvfY40VYiUb+Ddq2Fft5hV7Opm6cRUS0TrLWTCkaEQWFzIwESPC9FcJWtTOszapkxuZHOTyaKVlOIwf6iLBQ32l9iPSph2MnB7a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528556; c=relaxed/simple;
	bh=AZY2S5A2fYoSiK0df5X1Wg5/ZRT+xC5rEJfXgqWKNWo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCK/tAPk8vzVWBYkUOP/PeuPFpxQNMgAgPpLucxZ6GGGU91ETucH0JiBmZNHM7q7YcCLJ9HPYSaaICAm7FjVjU1dePsyDfEoPy25JvG4eOxBOX9Hd8J0Y9smPhxR/GDdc+1fvdopNhUZz0CwI2meFF6VAzEMmP/qKGFnQ4RnOvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzeahdXa; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzeahdXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774528553; x=1806064553;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AZY2S5A2fYoSiK0df5X1Wg5/ZRT+xC5rEJfXgqWKNWo=;
  b=MzeahdXaJszYLDGIP1lmrRmS11xlKNtQFEziKA1MW47S9OYBzZvlk4c8
   GWUeBIbyhr+3zLALPdMp6aUOnvSy8Sj1SEvUMkrWXJ2qA+n3BdTSL9z24
   2bZF3dy/Cu3GL0vKaEj2yVGOj6B+gn2g6idfiuL0c58CdUUFgylTVqe5F
   fjjqnI8Gw/sF60JP8r5O3VQu6JgOljvMR4WHUsM67LOGulvNZgNEvlgNi
   bBHPxU1pYGosSE5Z0ll06bMHxfBbx34SKiklzp4WgIhxzdj6RzruElXlK
   Gv89go5J7f4pafscE2Pzrpd0RNWBbfnydGpavmsH10kjpKnTzo04bWVGb
   g==;
X-CSE-ConnectionGUID: PQcOJB6ETuSY6ErV1Dg/Cw==
X-CSE-MsgGUID: D1d3t2GyS9OajFK2Cqs0LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="101039676"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="101039676"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 05:35:52 -0700
X-CSE-ConnectionGUID: s28/StKfSmOMQhnAHOsjhA==
X-CSE-MsgGUID: kiA3hO9CT3W5LDpPfbiOnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="229061828"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 05:35:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 05:35:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 05:35:50 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 05:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj+Ih6J8P20DQ8TRuByZAefkyVQSKRbG5geOS1UqKW6osPUnfTFBJhEnmeLd9X2eDSi42ay9gTZWXhBRm/12JMDMWBqIUts8y5W5kAM5QFUbMVRPTINC/lymeTzGj1XITUDRmbO92tLoHKnOxhauxRwuOrLPxhcT1nqR+xqN02ybp7n2xycKFxU3xcsuxbO1d06BLopvOr7YXGl9LhxdZW7jmhHdPDO84+edyPrgebn1GkivdxbIpo4fllN7rnybH/MeY/ZtFXRJ4BqkTcpb3k0S2HEc1PxvpTiZHQ3HTRL+4+xEqSv1x5OHM4VYhVvaSp0NQwg7tMCQ6D33xPo5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJdul1oZDiz79b7de5OL4jBXt9bcLP3QAhWnZaSJMAQ=;
 b=atAmK9UgqVCJtiUYdluVSCwMfqvmDOpKrT38UmcR1jPixex6AXqOk6gry1dZiDCcO3WuVR9bQlJkN5dTSbXXPMgalI4XD/AQAHEbOUesCnyel7yyz/DpoOEoixRfRCqn5OrgoZ6i9X23cLGYyKOhY4TWlfOt1viTzWIgY3iLSyiL/GRYokVe5ujt4IDXS0GRMDjxRZ5yA2rBTktQOOhiyvhCa8iL+iBSa9PqlOroNaOzcDPQSEKoJsbFd8WFqcimZF2ZEUtY63nBwp8rCvoDfUgbbZWMWw05W0rdjlcyJgFBfgd+2j7i1Ie34v5i4kOnt3mg2Pf2cgSno69jo3RaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 12:35:46 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 12:35:45 +0000
Date: Thu, 26 Mar 2026 20:35:33 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Message-ID: <acUoFXtbQGz2Nh2s@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-13-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-13-chao.gao@intel.com>
X-ClientProxiedBy: TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::20) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 104b3296-b85a-4214-489e-08de8b3433d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JifvSvQ3do4QHnzqsFOEGks+yP0+scXM+G7t3Li/WDIM/7hxxOvcWC9jCDueCQBH19ArEoqsSDBR5Xt7bCVyIQ2knuK09qFMIF8x06t5oM/KMOHLJRCHbDOKHBI8qNPLuj+LHP2c9TP7G0YjQXVT9wqDyYMelff3xCsTdy6+xyy7cGTgK1sNmyzw9ZPR5W5KmZSZEsP2kWU+2CXDlGnrJw9afpw732HZhLQiR0be/SSpauKAntSxsifNEYhYAtFwyUxLFdyM2iQCQXzJD5nmrqOrJ4Z+eEu91Yo8G+T+M46Q/YmRzdyRGBnGXHgWDt2RCLyvb1E9R174UurkhXi6foiUAUBMF+TfpLJRrodDWywZ3xct7N/HY+P5ARtUiSw9UaUZ/iqUQABznU9dojD8We7SfSx0XFw+g7tFJ838uFoYAVmsJmZr/Ugr8EClCwq1e9KDffLqtMy+AbuJ/b1rHR86GC8KzPg+DfW8+PenE2p2rWXORNafO6cJF+3gVA/KAqWLkUxCuC6LwY5wG9Xy/WYEGJsfFG+SnXJdbkDW5w0pdqvY3EPHRILf50U0do4/b1hmdjm1NP/dIcUOoKr4Daa5hv4cGZZuwROSCoE2Gs1sCN97Nhg5uPgVH4RMpgRdM+oS2PXEeJWz76fj6VCRNTMDD01P17hZwmAoHDVi86bniKm6awfYQy970fPuNGNYlLzpDFS187mT2e7HeY+mhOw/m4r/dDCYNyMdU2h+PSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tsW+V0Bpnmz0YXf5vNuZm1q+8yVTkbY/q9Z1qo+jIcaHEicYeId8wGnqfpWA?=
 =?us-ascii?Q?nBr23UrWZyDDYZvKsuKStRu22xZHDeCDbQ4afCJzo9xOh9eRUvaTlvHmOBye?=
 =?us-ascii?Q?kui+VReaYuKzJFMzLBklbGz34q78TXm5dSCRtT1HOCGeoo3hgxSD+7tJWj09?=
 =?us-ascii?Q?omTCxaABCutxl/J+r910UuPgfEc8dwjnIg5T/5Xv8yhMZpd7VhJs20S387JP?=
 =?us-ascii?Q?mTQdL5DV2FcnPvDETUt+7+VQrg2j5p38YgW1TgL/cVvGbIneDB6YJOoIdDrE?=
 =?us-ascii?Q?s2mRe3sX7s2kwgNTD0XyvzC6+bp0qQdnaCspgcE8C2Ga93flWjPVXHYPRb4g?=
 =?us-ascii?Q?ytburVjbNuBFtiJHbsyAZ8NfxY/w9RgD3lRxaYYEvoobBwcJqawc7S9FJDut?=
 =?us-ascii?Q?Mx5oLnruKnAwy4Oo0Ug1LXc7V2r8ep+/UarN23u5NUu0L09e907/5bH/LYuI?=
 =?us-ascii?Q?gjvBFp8Zm1VWnpt9CZ+jf4eIqoeA4sKGqAQa9Qrg3V+qaAFBD/rvjYzz5tjP?=
 =?us-ascii?Q?Tm8h/IuhDJy2XuToxzoNpbUGKRReAPNTl6RU/pXPOYmamGVPS30J68flFCIi?=
 =?us-ascii?Q?XiuzmQ+CTKiuMw4hCJDyYBvhrwNmk+yfX7QGoO/EIOZ8OjuSkQ9GPMflkMsG?=
 =?us-ascii?Q?IS2i7Hs0Nibp9ubIIVJP5oKcMGX+5zkLv78LVkD/nsOYYzAZ66O6syeYX0M5?=
 =?us-ascii?Q?uXNwJO9YeemxtpncCdUwfvqnZfOkXzX5otBxvtzKdY0eqKRONHl4Zr4sPwZj?=
 =?us-ascii?Q?vUiUyU/uf1OPlxMaJ3rmd4AsOk0/eh3CDKLsrItlUIaHoqOs8Akj05/2OK1V?=
 =?us-ascii?Q?4pEqGiU68lOb8b7iZp0Y5KlFSTNg7YsvEmAiZNLbeIhX/RDq2Zrq9FF08k/4?=
 =?us-ascii?Q?lVZ4Dvpj+TRo1mdOiPV8TYovHYwRuSoycUV0DcAAmfQSucM41uMoArvpti+r?=
 =?us-ascii?Q?1uNwAjvQwIR8JhpfpOLyG/UKBmSDpKc8OkLlUqQWAoRtQ+CKel9D6pkDHdZN?=
 =?us-ascii?Q?J2XpifUXwX8GVmL38atAEWAfFFD+e0lZGAYRb2xfZssrIdFIJTOyeNVUe+ba?=
 =?us-ascii?Q?bJJKK7YjCFwjqBF2ld2+hxrxPWhO+tqKmLnntNV9CcCQQKMHUYaTKGqTyT4A?=
 =?us-ascii?Q?UiVBIsP2SwgMDr7XWf1iWmxX6Gnp84b1vN4d05hoxQHKAOpIWgKj1tilQmEE?=
 =?us-ascii?Q?BZ16NWiFSbc5bylGNj5mVWkS9EN57PVZsBSWt6Mr/Es/HIjkBYuWDt6+/Y7/?=
 =?us-ascii?Q?v1amCBmUoRXpCGDQ3asXnAmu9Tu6zie+j3SWoNzC+XRgpB4MFcqB12zPVrDV?=
 =?us-ascii?Q?2uzKHabZXhc7tc0yS51Kj9zxwTCj8h0HAj21/BYNwF2cvbnnIrGH3ATUNXQ7?=
 =?us-ascii?Q?Q7SGaVYfo3nRhNty83anlE6BQoPUmGlb92xlSkPhNx8JX78ymdQvj3MhJQDU?=
 =?us-ascii?Q?sqSudGtWHRpnGQuHRLDeNtTlJd6B+FYkTjCbJ4Xptgzs7wpwjcZ6eC3sAyT4?=
 =?us-ascii?Q?caTw480W05YFACZ0m8RqpInIPEB7FDDyNCRXpqWwqCd9QQEeSu2coDiEzjBf?=
 =?us-ascii?Q?qm6y9UFhZEvUYzWY8G1m9p4nE8Afs01r9FnkaWtwtWgOWtK/0w6+n1TuJLAY?=
 =?us-ascii?Q?SkXgKB5MndnyTccZIyNj1YiivxvRgR5QxTeU/+1qpKoqUej3zGk85yLB7Lsv?=
 =?us-ascii?Q?JtR+E8osbw/xJVkY4/SzgypmefSJx5bgak2v+DlT4lDyeRM1n+/A3/6jsgqy?=
 =?us-ascii?Q?Z+huyh8eBA=3D=3D?=
X-Exchange-RoutingPolicyChecked: m0TjWEPz1RHZP6wDVZF/f/q9yCtGgOQazS58xwGJmjgExllY/+BjsCdKtReAsyskBle2PnTWk8oQfrx1Rxx02oq+TrH5tD+DCjjZrE2UPegjBJrgcK95UNGg7hrMx6x/uzFs4Ls145OQF+v5HpZNrFev343mTQNsewoz5+EWddug4dmISUSyuhpq+nwzFKTstMnpeFefqmRMlXUmGoZsgl2RPaNGqR9ssAMlCnIdhqNrkM1XdPyKwvX72tV/JDvij9QinrxsPeT3kam6d+QSjp7wn134W6/jx8CXIPG/81/dfti67GsYBG+SEYAuRlbpXDwZeVT1gyYmzoZ6JKQKmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 104b3296-b85a-4214-489e-08de8b3433d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:35:45.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfLS1GHAxskvBdDC4+CBZqzXXIg0C64y1vLtj8ioo8ITMYSXqoe4p+RMlktwJ/Sa/KbMSuHpkYn5cVekU9dIqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com

> int tdx_module_shutdown(void)
> {
> 	struct tdx_module_args args = {};
>+	int ret, cpu;
> 
> 	/*
> 	 * Shut down the TDX module and prepare handoff data for the next
>@@ -1188,7 +1189,23 @@ int tdx_module_shutdown(void)
> 	 * modules as new modules likely have higher handoff version.
> 	 */
> 	args.rcx = tdx_sysinfo.handoff.module_hv;
>-	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>+	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>+	if (ret)
>+		return ret;
>+
>+	tdx_module_status = TDX_MODULE_UNINITIALIZED;

Sashiko commented:
"""
If a TDX module update fails after this shutdown completes, does this leave
the system in an unrecoverable state?
Since tdx_module_status is left as TDX_MODULE_UNINITIALIZED, if KVM is
later reloaded, it appears it will call tdx_enable(), observe the
uninitialized status, and invoke init_tdx_module() again.
Because init_tdx_module() is not re-entrant, won't it blindly append
duplicate memory regions to the global tdx_memlist and allocate new TDMR
arrays and PAMT memory?
This seems like it would permanently leak the previous allocations and
eventually fail when construct_tdmrs() rejects overlapping TDMRs. Is there
a mechanism to prevent re-initialization if the subsequent update steps fail?
"""

This is a valid issue.

A fix is: set tdx_module_status to TDX_MODULE_ERROR here. Failures preserve
ERROR state; success explicitly transitions to INITIALIZED (patch 15).
Alternatively, we could introduce a dedicated shutdown state.

Note that the VMXON series moves TDX initialization to boot time, eliminating
runtime re-initialization (init_tdx_module() calls) entirely.
