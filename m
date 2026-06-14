Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAD2C0285;
	Sun, 14 Jun 2026 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781423432; cv=fail; b=s/GsuDT/JluSaDDiADsZXzMzfkGKBys9rzdJRBewDXfywjrdP8YitTJ5ZcMZDlLcy/tyu+fgE3BtC214ilCuFmXn7L4DFqlZ/bxJB7qewuMAjjoMwb2AtGtz4loep8dvwvCIl9VF+sWSN/U5KAI8TpqnH9e+gycr20x8wpLR4ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781423432; c=relaxed/simple;
	bh=8XrsFqxB9LY5OS2u40yXABNipusr4AuKyi8PffuF1LU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OUcnM6vMMmz3asqG5BkWmF5ia59odjSWr0BJGtlyZP0XmC+cQDe7t6mipgX9crduXz0/OBWX9JWx8kUnsrj6SU9FKSsVCK8Zx/CVWro4uFTqN9cLfYSBdRi5aam6izxIdS+cg1hfxZOUJF421rMtO5WNGVmQ2PRSZhYF3XAl1eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3pXwS8Z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3pXwS8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781423431; x=1812959431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8XrsFqxB9LY5OS2u40yXABNipusr4AuKyi8PffuF1LU=;
  b=Z3pXwS8ZUL782xOgmap+qaABnCUqsN/q2MnBDhZzQY7VNj5UPjvPY3VN
   ge2fxLiwJXPpwHaKl7l9MIxgRSPxbsVSyb2wx/RrDQ+ZSR/8e/594awU5
   1Fo64RP3UTvWl2XGLJuXkhBMIMsmJVPKIJcb/V0DEuJErqvhnGAmd4mnB
   TNWgPowqLj/T4NSmwMV/9ehHSuvTqFXqdlrszrD8OZjg+AXMP+K7ckLJA
   PSaDRhkmzV0eEondBjBKk6+CwsYMPINxv7h2cVlh8+Fhhq1DWhV6wcXjB
   Tdh5/tDL6RlW3oeQU+h/4xdN8aEWrEqRWKpySWxaSTF2sasOk5VdxWfuK
   w==;
X-CSE-ConnectionGUID: bhs+Kw06TeCi14zmmAiizA==
X-CSE-MsgGUID: KXEj29FOTPiuhm6IIYBQiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="69738870"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="69738870"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:50:31 -0700
X-CSE-ConnectionGUID: A0wv64+HS2+rYvRGAMsgbw==
X-CSE-MsgGUID: AhsLNEIgRuqZddXxLAWJyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="252290737"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:50:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:50:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 00:50:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DArIXz4EdCq4AX0B+X+d81Oq9aGqtkfnfRiStzruBB9m3gHxSdICSyEtyeFWDcvTKGy7g11nyeTXY7yJ+Z2s//j8PRJey1OZBS+ITkWt/90MGkF+b47hxrPcqM3WGvcQB1i9O+yiiOxOTJAWCjnbJ0KtDLkUg3SI7IhSgBxcXaFEsGJxCfbBAYswxmt9qIR9FUao16gy1WDnh/Y4FrwbOXyeLcJCSzgc0ElPPNn6TbyYoESdfYaL4BQl4VnsiM8Z8d5UF2JRTTIAqhMHcaF3GktlDcrEWE1weHVpUMwcJ7SocrdP5rA053B4xDI1luQVOlaboRz/4KaqpM8D17aCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdzTprKpRZxCRpqCFBZjNixhCHb3MQGPPx70HfgXmxs=;
 b=t3jXk+E/Kpfoq5Jnvpo6wT/Z0WDj5a8OA08j61BHssYEER/iu/fCh+LdMrbCWTamlGWM3dqm4hP6S2UfyFEmMcB8fCP0pcVezGuNwEn5o25VWTatu4N2CAi58tfsR1r6fwvZcHZT7t2JHE/ZnBWHuvXumnjlmtlIMha61AqF5mOO8G/y7sN2dums3QfPoQQpNglzK/FvaZia0PGS3/TlUuSMkjmc/YDhA+bRKxbk3fZa4ChiJdHZs+2cm+/LtJh00GBddQbpftiuMHEUwBMuUZUxQ4AnZZ3bHkD2OoKkrTW5iMMUkB4eSuol7BLNHR4q3uh1qwpZjuMbNFLVAAlgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 07:50:27 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 07:50:27 +0000
Date: Sun, 14 Jun 2026 00:50:26 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Message-ID: <20260614075026.GE3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
 <6a2c9d8b8bfe9_9b85510018@djbw-dev.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a2c9d8b8bfe9_9b85510018@djbw-dev.notmuch>
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SN7PR11MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3b97e4-4fd9-4e8b-02bb-08dec9e99983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: bDzbwhM/jZalws8eot23eQys9zPcMCO+56EOJOZ/NR9ikqxouczgIWAZsFQ6M6sftYe3kGq4a51K36LiCOeBaOW5oEmQplROncqiJArQ4O85x8h3ZnCRMCzy6HOqQW8LLWsd3q5bEMRvlsC9nMMKgJWpswgXPx8NRsM10Le0UC6p7QreaAJReWXHV/68IAg4g/wgVvjdzUxwep7VmvtkKZJebIUa4HVW7eDkwPIS/CAVDGChZwS0c/iSUWbiu5R4zSksUijApOJzgQCscqlt0G1/hidZix3uF7M4+urGvXBYruhKoKrPqqjFE0bBQJ2z31raAVUX5a4Ge/xA7OGTqiMT3St/44+5oEDE7MIzDQc1tQ+9iX2ObPUe/3ZG1ud+rZjURuude6LQJvCpyJDsxeObd2jgY6ojoN7pYyKdUByc+LHVsyDn6idEczB/7Z2ReluKOvwIFy11UVEGnTHZoTo4Bq7ewtlcGBRN/NJHXHivLuH2oDbDJilrLqB6BcSwIpP4Tzij/nE8hd6LzdEeZ4v078PxTZJINej4TbfW0ATAd8767DqQqWQg41uNVeoov4m1oGrJ7n4wm78PKzUo2IDzyaFncaGhGE2XCLXCEaXz0VOsFd8oGoL30QDV0f6LRWG1yw0lau5bY3RAUnAF+SXCOFSB8nJD2Y7RqTuYQ5RmSB69mM8chEkAvSEZVpkm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kXR8bX3I85eiDOL913n7a5rUoYb0au3wCaou98/if36O5g7Zo/6hzJbcoTyN?=
 =?us-ascii?Q?5IjvgWyBaYdw5itgc79OQBeQ83W5LI12+tUfp6UOYvE5T0yHLnUY5oRHDRLd?=
 =?us-ascii?Q?fJgWXiwJwDHrcYeONOaFHT7U9Gxdgomq3FkJKAFNLW3tclph7pHTMPVXlxt/?=
 =?us-ascii?Q?QE+IOsRocCpD81hfQkX+hnIE1IOxpa3a6uRiOyekZ8XCpzTdK0UXLHoTeLfS?=
 =?us-ascii?Q?Ukb9dIp/NPYq9/kQbu0hE+nXLrjb7YQkxRK8iWA5QUe++NaZj1rY/3cEHfpO?=
 =?us-ascii?Q?LlkX0q19Ifu9N6mMSY8qyI/hXeNHD3+UHQwWfijvz1l7Mm/YvSbvM+HkTeoU?=
 =?us-ascii?Q?4ZVMFFk8vXtaPEZUl91WuPeuzuTCNmKBjtZc0X5BXrh4tt1Ag9ReQu9mP8gQ?=
 =?us-ascii?Q?Jbah/WSPkcEMbwGRLNayIDoQXWI4lr3uxgyyJCknS/nrqfUBkrJXfj/DrohE?=
 =?us-ascii?Q?8D9Em8moVngj5eGprvKw0OpDwoBV2D011xHbWgj5WqJ60RV/WX+gKP43Lcsz?=
 =?us-ascii?Q?shyh0InCnxYwmq5Teci+y5x1VmpyUXuDXD3aSnL8BM/N3Upp22HqingWkZEg?=
 =?us-ascii?Q?/VChhp1pmHVsfxSoaWYL3FXS6UrDkPmLYPPc4zB7ZUVEaG07xzULqgD2cFLz?=
 =?us-ascii?Q?jWVN0EHdRsa1AamiUVsSDfLi5aOsihMB81AL06lFKNH0X6YW6Au0973b7nVJ?=
 =?us-ascii?Q?qKdACFQtMgUMusLI1M7ZhNt5JPWUaxJtSh/3vvw/aMiK/N5MglnjVUyBzuRE?=
 =?us-ascii?Q?z9eB+LOGf/M4+eCxN9pjdIrRJPeOTXxDGIdUPQIXVD4GyVzoaIcxskD/yB2H?=
 =?us-ascii?Q?yDWCY1kAb7tNc//h0GxgPIt5aGvqOiY+FBkX7hUeTEG9PnzJdQWt+89T1B+y?=
 =?us-ascii?Q?NP7+CztUIk/Mp5jrrfTXdY72KCpOrgU+UWxwYK8lAVL5rr1Dle1SAni+hwca?=
 =?us-ascii?Q?UWPPB7iGocH8kd6Cw+B2zm315kGwXHQF+3UJ/Wmy/rvKgRA186X2m8p3tvGp?=
 =?us-ascii?Q?R78OVIG3of3m2skUd5rsFMUEmclXx9jAHF0atXE5G/GroyAggNbPZQBH57fh?=
 =?us-ascii?Q?bBRiQV4Qh4rqKskiVWE/OSPdvg3j0or40MdqkPxpUsN5Nc0Jbge5dvoizbQ8?=
 =?us-ascii?Q?irXJCLjCTvIxKNLdLfRC9Wz2Ybu4P3GN4+mxTxggchQ2FrIg3THUFiYzwMRs?=
 =?us-ascii?Q?T92rh429leKLIOegJlP3lgKiStxK2pq7OeEELp4JMj5Wz+4fk3FlkYadNaZ8?=
 =?us-ascii?Q?H3Jm4njWJY5HGkZALNXvN/1qGTot1TfEcQpygebieBwjfnHNdiYTEB7coK/D?=
 =?us-ascii?Q?TiWHxomBRA/NVHNS0eH5PG1eBuTEtO0FdVIHuRL2tUQURKe5t1836SjBwLp1?=
 =?us-ascii?Q?gdB5ICUJnqvtU28xVrAQZxauOyTfcs8Gqv/UVSFHgV3XR8pwVVM3d2lrTjYC?=
 =?us-ascii?Q?WnMXbHCESOUe2me/PB2/Y/fJtD9+QWaEOS/pKHB07iSM+LCEe+8RBOzqXrQA?=
 =?us-ascii?Q?Sdw4C4lMoFe1hyxvjo8EBftcyTniAOTTH/NF2tqFYbo81CbEwoSgSEALv+0i?=
 =?us-ascii?Q?FFEow7md8FaJg3FCcV/xEErqdmiSTd0HTbyvRWMgkddlEx4JQ0h4lMHkW/JT?=
 =?us-ascii?Q?ItS0pFZwD/5k82FZWcl04YYh3b0DWa7aK0RJzT+eHMTdy7E6aWtq/odeEw2E?=
 =?us-ascii?Q?h1CDY0tofdmuFdHx1SLGn/qO2CKTf3kqfUzvjQ6j49+1Ax/EOW4hjM9gky83?=
 =?us-ascii?Q?3agO09Zz/A=3D=3D?=
X-Exchange-RoutingPolicyChecked: FnKb6eThnRjto8QRYukgg9k4CjSS4YiVVWZWQIxpMym7xnSMYUeIvhyWC7IHNshbX1zzjrtjpPupalZXCJChFmN3DFcfcBDQ9aQ4kiAyneUqc23rJQGPtB6kmg4gVXIu7vev3/1Dv4A6hCUCKpubScgSZHQaoeZTQ58XuIwH3TM0+WODM4eSDeSA+Y+tc5bM/sts+vX4xH+t7uh8mZ9YgFjUpUZ43RZjviUdkHu0/GqzEEmydwHeHQDoMnx7DMO3U1sYLUQkdgWYw1a5sjscpxjBCGGhGnQCCCSzwfKoDEBKRN8pyQfYy7WGLzmKyOYUVTMZp7tn7EXGRQc7KAELTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3b97e4-4fd9-4e8b-02bb-08dec9e99983
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:50:27.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4JCj+yk80fwq2+QHMEzg9yYskr/WhTjrQ3IyTlKpJ/ht12sdap7GPIueL2A0INeumTXaIOea5+geIt/T/Musw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 05:00:11PM -0700, Dan Williams (nvidia) wrote:
> Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Initialize the Quoting extension and fetch its metadata during TDX
> > bringup.
> > 
> > Because Quoting is an optional TDX feature, do not let its
> > initialization failures cause TDX bringup to fail.
> 
> Is this micro-optimization worth it? What are the classes of quote-init
> failures vs just make the policy be anything in the module must init.

Since there is a fallback option to do the Quoting in userspace, I think
it is probably not worth shooting down TDX entirely over quote-init
failures.

The quote-init failures can come from:

  1. Quoting init SEAMCALL failures, which look pretty opaque to the
     kernel and there's not much it can do about it.
  2. Quoting buffer allocation failures, which *are* understood by the
     kernel, and it could maybe try something else. Right now, we just
     treat it the same as 1.

This is helpful because I think the question of "what if the Quoting
extension fails" has come up enough times that it warrants some
explanation in the patch log. Thanks.

> 
> > This patch does not include the opt-in portion of the initialization.
> > It mainly lays the groundwork for TDX Quoting support. Opt-in will be
> > added in a follow-up patch once the feature can be properly used by the
> > system.
> 
> It is unconditionally calling quote init even if the feature is not
> present. Is that not a problem?

Good question... I should reorder the patches so this looks more
straightforward. I enable everything in patch 15 (including the check
for the Quoting feature) and I think that just creates confusion for
folks looking at this patch.

> 
