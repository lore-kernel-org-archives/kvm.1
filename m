Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B8391E54;
	Fri,  3 Apr 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209667; cv=fail; b=fW7XkGyQ055hK4D0nJBekUOWKrogdM8dh/tU/T5vvuqmCe/8YJkt0Dkd90847z2as+XwSPD0VFeiUBLNpJvGgOGdXJl7NxhTLJN1gU4q6w8V1NQ1ddm9BJEsK8rXaREo0DaaVIJqOhqlx3/1EJBP7cbNaYZaxi3Gmk7Yj16MwlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209667; c=relaxed/simple;
	bh=7xqJ1VC+K7eucwHkBWmVhbTi8GUPf7bfAzpbu7CT9/g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J3pJcAxd9d/oBN2A/zwMCd2C9byWxBoqyHYy9BeqV8rMeic4aKxiT7MhAO0eTcFzrC3hcc6SL794eO3cz7U/yrgbpHzoEtJcTbt4MVy4lDsLISESc/Mi74KbgcNnOcy99e2Kb6djfy3ktYRjExspEKdRjsbi6//mExX8UPxEHyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5HD6STS; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5HD6STS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775209666; x=1806745666;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=7xqJ1VC+K7eucwHkBWmVhbTi8GUPf7bfAzpbu7CT9/g=;
  b=k5HD6STSx537AlvC1yNV3oU4AXuC1WOf3pR722fmyhof/X+w1sIWqix9
   +aYZWQpESSObZR9FAo6d8SIG8sAWD7+8FoN15rBUlcMU22AcIr97PJpDQ
   WMqWayOAi19c2iGMqDjIj5HJM6s1vh5mdIIcowuyjKlTKxHT73/CtubAZ
   W00i0XmKhwt0Ljq4W7MiNobf46HmJFMdvSfFs9to1Yl6VkP0FfMx2vpTZ
   2Fda25gDwOnd1Cd//zENKqzfeilFXu6tTD03haKjy1Dc175TjIWHhnek7
   LS8W21IqemFRGNwwH5DNkWz3gjC+PtM4W3OkwWtLn9O8KoJIXEmK8tfdd
   Q==;
X-CSE-ConnectionGUID: MS+pEWudQ5yuqvhBW2BfUA==
X-CSE-MsgGUID: sohvjH5OSPqBFDuamca7eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76157712"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76157712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 02:47:45 -0700
X-CSE-ConnectionGUID: rdDamUR/TcSUY3DgHPvI9w==
X-CSE-MsgGUID: MuI3RaOBSjyXE+kb5VpZjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="227465103"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 02:47:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 02:47:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 02:47:45 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 02:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3YN2OzQItMmPShgXV66Tuu0e6/lkwSyUZOTU3RoeKH/ESfwV75gjf+xUOgZjyBV70909Cggg+gpX1IF9BJPsTAKqVfKA481Ky9ZuwieqdQDSf7yExyVEd4Jip8JG2Bv//ream+8e3FGh7qzBcApZsCXtmhZQ5IEIxoL4aiU2YVM/6F7UITi75wowUkiSk3+TmjCbyvYa15YeV5Eja7jEyRD/CzVU9xWX7FL8miROfZwQ8lASoJ2CPGXvMW+XJME1VuhFwncrVpwo3M1VmlkRDtUAW/6Rt8+XAHm87BpwxCkkjSxZCC5GbzqqJLsZNFbnxyrEWyvocFDJkY4380GaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xqJ1VC+K7eucwHkBWmVhbTi8GUPf7bfAzpbu7CT9/g=;
 b=lqmKDVUkvGedVDSIpfHMm9QqaNNIpDuAWETLBC7zWep4AlsmZWkWS0U6pj3fgnC1b9e9AUeooj7zdZgnwaMO5vY8bIiI3y4bDqPH6tbY1t+QX4Oa1R3xXp62tVywPHFJPfBBIIvM9kan6fOZVBgpyHXhjbAPq8zKW0Dv2FYUrhBm53xh2+Eg7dFW1hwHtCA8QusKWxKmVAdCSYnEoYdwJp46HSdlvwtORAbHBHBhM/PFYdxYdUdi2oh3txTCm+nRtMP77DsS34LXERmo9DXRnJCeGRmqTHpW+slN91HczMyJyQrfyDTHVWuf900T3LRaGn0/NUZag+oP0hELlLMmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:47:36 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 09:47:36 +0000
Date: Fri, 3 Apr 2026 17:08:02 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <ac+DcoSDuR6cA/ZM@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
 <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: efe52a84-7c82-4852-e010-08de91660966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aFQfANdESFB34LrPeYdfakS/O80iSI5NNxUc4cmmNabRmRYmkXCsFX1iKMByFlfB2ywW6DJZf2E8oWot+cE50GaGHhvYN/K5iNvFx1qbhN74x4GhSNUfyW2jTBB6OTOdrHj36IO+1S2v6QjeyPUDrvtew8yCFg6T1TODH+tQajO5ypiXTvhtBeGJZf2bKF3j7bykI1iEbzOp2Gaux5GfTOqw8aMYfwvCyS9cNu5GJdF/IVtj37T+VQddpx9aNnoGftVQ/VMkDVqglwj1NjYZ/aJKdTZP6OzUQW2QDPmTXROZ3+iNaZJvXrTPliknIsMNX9Tc/4mrypqwucIbOXskjRVyERmXuUldOSRoUmxtUrd/L5kUs7wQPBPD+L9sENEaf+AMFifvsRlBuSR/gxCdVjkdJ5KwwO270kKxb1Lc7j70/EyVITGDqdJnmskuPX8T1fbpsW7ArcjjS0f19mz+QgGgDBnfhekj1TmMBtPjycSyPeUXAjfvLjNYLJHv4UIr9xzRE5DGTa5loltnAyOK5cRB2LWOBJZ0K1Giw58OBtb21mqX4QZ++SvZENFXOgbLZbia64LrR3JAnQ+5SFt+8qeLS3mvHPob89Z/drq5gJcDkYwYWLIMd5l0jBaYgZGYhtgdF1SdwDXG+irCHJVGH8MbNOf/JVc3NYlptxy4XJyhldzUpNgZqSfYUV13fVfzngDf3Vymbeh26cGI2vLTd9hyxcj6a+HFkL88Dtz+f6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UqNZcWHTvDAcPSVPVCJi63vnUbTkwnaZGYsFEIDckrDp5+3BYFrz+/DYK41?=
 =?us-ascii?Q?vJoXQgPMLb/WZ5bcKGhR85kehUmQq5olFdAdCjJwEKoeCvSAXYomm9e/sJlR?=
 =?us-ascii?Q?qBVfbY+4CgsV/95acLHnaAc0udSCeCnQHlnh/XQ6VRC33zxTCiYhW1S+l0r+?=
 =?us-ascii?Q?ohqB8OlQ+Qi2ZDiZaAwXXQzxOLMpQjhHOEwuwqNgOgboKoo2dxfGkfCO8SdJ?=
 =?us-ascii?Q?b20+M3dZODFZJf777az6SX40ftiSlbB75EvC3ZEc3QEvyd5ozEtNgptLPJi9?=
 =?us-ascii?Q?TjnCURkR2qeSWckjkIy4vBvR3ppkwbDvU0UA5HbSGrYtqvb9u2LpGvC63BHU?=
 =?us-ascii?Q?GNw0U3T5TkDQ5/Ps0TLLHs006jbZBXsnaQ+vZw9c8+gaq7BVVy5f7EEh3Dry?=
 =?us-ascii?Q?h0ATJrrcCpzhuloERx3v4/YySGyRwxw7byaBGt6NqTVnAAs/+1SwLMOTHnaF?=
 =?us-ascii?Q?E1TgXmijR2cKYwdaBvl+5UuJVUt1H0VYkvj2OKRYXWSTXO2oge233XI2qbz5?=
 =?us-ascii?Q?jNfvLdQDUSOwsM93sjRi//F9NuNcNNwWyYzWtUx2q/04vqWCFl5C99eZv580?=
 =?us-ascii?Q?6HhRCIm1VzZ7FM7ffKeq5Ew6jzgMLovnXZJFvl+zxjD2OCBUlVbjj1sCO3BZ?=
 =?us-ascii?Q?tcm1pVo3SrFcRKptoHkbWFpOFstMUMUUFpPGCzfPKfFQ1EgoKYxzQcG0d3rQ?=
 =?us-ascii?Q?EMzlkcSIAoH6nmWKh8U4OrMvbsObuu7ZZJ80g40er1PWG7ANO7+7nOw6BQLF?=
 =?us-ascii?Q?lvgYWr1ieN5gwRHPD654Mion20WzrFVZ+lYtiVRnolnNWOHE7/8rCR84DPln?=
 =?us-ascii?Q?MdzaaK7YtcBXDxZ6Ap/blUhyGqrc49y8P5Ptt1mD8N70TH58bZoag6WRKtsJ?=
 =?us-ascii?Q?E7zDLcMU474Jr33X+y53cLgG7mG7mlXSX7PrFCNX0XVkkWU0bw//BBKm1YJq?=
 =?us-ascii?Q?Brth5/yGkV0kbTPneNR/I/PpB96pVokEC4AgRMEZSKmCHj4v8xKNJo+tnC1A?=
 =?us-ascii?Q?VuM2rA8C2+ehl2neK2VW4vi+7HClgTtM+cKWqYQOlHVHBaIXp/IGAVI7EMr+?=
 =?us-ascii?Q?OXH7u4/CJ7nIA09ekcdHU3H6RCmq2j/vHMcvITNPsdrGNfnkc8Expq6Qhh6e?=
 =?us-ascii?Q?Glvp4ux202aMa/erVlZ0s194bPO0ilXShEJO5SlWMYmTUTTOPisoEfR4xRDA?=
 =?us-ascii?Q?8YEwBLs5JGniD1P/4Tzo1lFQW1P1KXz4zcwjZwy7cmPKVlxBoInui19OTkdv?=
 =?us-ascii?Q?SNnTa7JRlcc1eA5HsytK31WDtubd6BXr1hNGr05cKKyvpaQ/s0aDXfvwiIqc?=
 =?us-ascii?Q?m2mk1WIJcn8LKpzpaEXdOM6sIb/nZsy0zDwoxfGQArWsXWza+P9NBgI1D5/q?=
 =?us-ascii?Q?PqztQmO1rkPNJTUxkeOzGP0OS2sdrcAtOH9glpNZBDPjRaEcP+Os3Cuw/JAB?=
 =?us-ascii?Q?nbR/oHcw7akFPqodokczHdEXdz5KnJ6wvWRpfAmT/PnFwgTK2oBkDFA32nTX?=
 =?us-ascii?Q?5i/6UWmTurKPFMKD+2aDFDXuTpqLNhb1B+yMaK8enpFRY7jF3ar/BxVBs6iZ?=
 =?us-ascii?Q?kLENJqH/z246CvVPCmrOiTa6nb+Vj1f/Gj2ZmtvTusdCFhisJxtJlGkVIj1R?=
 =?us-ascii?Q?ZlfF7swzUZMO01tkfBEsGbTqq+R/q3H2T//BXYtQbn3WW2ay3FECT72QvasB?=
 =?us-ascii?Q?Z3d7NENOTVpoqzBdqiPAehtX7ar9KjZxUqUe2R5TPMtPlwc+wj1YHx876DF8?=
 =?us-ascii?Q?ixdUBW3z8w=3D=3D?=
X-Exchange-RoutingPolicyChecked: RD/rWrGTh4lGNWraBjMD/2YnRdNJe6tK3Aoneu29C7MrgpGkUW7OqXB0p6laOe7kt93KY/HLfMVN/j0IOsMoNNF9LWZZrufXv6ehttzA513imKmO7FEb5Kcn1PBFsVLd2+/crHNB9Q65VZ/eHIquY5gtjoPDW9XU34uLEFZEoAGEON678GEu8eglSWa+BzItcct7m70T9OU+wHolwUef8VYgZlUnKqDAfxrkVV+bcUaj1Wn/K8igrnAqnikk0wp2sKAWxu5GtRj9SDjaU+ES7fCg0B5cEm2o6aWiIVdrEnQgf+mDPr6xqrlYa946wLsX+y5pR4VnBEaDljz6hilBcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: efe52a84-7c82-4852-e010-08de91660966
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:47:36.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1e5lhf6cTnLh7NIgseecHV1rTnmFSBu+IvZzOnYCDcZXKMuMqlQbXFibuh5lehWv8JMiWR2bXqO8BXzbvoCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com

On Fri, Apr 03, 2026 at 07:10:18AM +0800, Edgecombe, Rick P wrote:
> I don't think we should add warnings for new paths in this patch. Meaning, the
> patch shouldn't increase coverage, just maintain. But it seems reasonable in
> general. How about we add it to the cleanup list.
Adding it to the cleanup list looks good to me.
