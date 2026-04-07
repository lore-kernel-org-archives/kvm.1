Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4A3A4F3D;
	Tue,  7 Apr 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562690; cv=fail; b=BcqD7IMw9tdTILK0VPOO4PsQhDcZSIadmnzeSEsH64EzHKxEICXxhalHgq26w/hxVzYS1gyCxtLu2PV7fr5D7074ycqboacFOWQz8P8iwXP45rSXzi/DG7jzxI5GwdpHR6NDWOKZDs5mF4gntmVFP4QOmScNMLpRFM3vjP/AxUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562690; c=relaxed/simple;
	bh=G7qp+/Qw7bhto4kSABvu96AobdDqndYuo6iuYHCbNwY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qppwjVcoi8P+lYSxdyB/0JdkV87r+h7A5rLuuY/ciBlMF/LlPF3FFfED+1/j/Kvb2JLy3W8nMVr92dvBX9UyhBDoGpZmEmmUzK5LTaQGFc6k3a5Brme6lir4Y+wt1RxeZbONwQhWll/YMKt6h+p9UP3DuKRdan5brTXTH07LhSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4HKFGyn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4HKFGyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775562689; x=1807098689;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G7qp+/Qw7bhto4kSABvu96AobdDqndYuo6iuYHCbNwY=;
  b=O4HKFGynM2KkXBcdAeomx2caWcQIx6kT/99tuqlEsu5BlhTha8jzZblg
   8i3F0Z0CIBdrDQwlzdU8o2I3whG92YS0ilUumgMSZOH7ZELOtOWHoRAvP
   fHdEJHhO3zt5YpZp9nVqu89e1waNPmwJRSSQyeFA7MfsZyxPzrFsYDdOx
   B/P949EYVyducAoFNWkENCiHDukxCohQ7WRyiC/8aK5RglzfLRBewuZGq
   8OLsXCJ29MfeBtCAwVRsSx3yh5MDLqtbnVgR0hf9MUnuwLcRhhw25d0+X
   9ybI1aPV+unW3Pq2Wz9NiphPGvGDH/EUqvsoFuY9wNB56qa1drgP2b2yu
   A==;
X-CSE-ConnectionGUID: 5nRtGVhCTe2iq8NISPSMtg==
X-CSE-MsgGUID: Y/YoecJoRZCTbRlKmYGXhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76417875"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76417875"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 04:51:29 -0700
X-CSE-ConnectionGUID: mMrqFbUcQsu3ct5QtDzsRA==
X-CSE-MsgGUID: 4l4T9WP3TUaAADw42oA7Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="224962768"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 04:51:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 04:51:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 04:51:27 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 04:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk/42p1ogajoUIPG5IooqAFAR7U4vvAn8AAEHas/4Gr9A769OR55Q4NGFnZSgg7DuJe0t6WboiEvdlpABAa1UcLv0AYAI0ZcLn+ArgmL3AuaQlVsFZYJEDohkXvuFEJ2CDTqWKH1nGW3Ti+zdrWvl9XjX7rWJwzEi1SHQJjDh/vGqCAHiWjjoCYfJdaIZMdbw7Le7m0w12bMryMhomIk4Ey3ydJnwZ336Qhs/u4it9OkYMvJTXMHddN3UbqL5TBPypWV0Mp8TiHkETLg9nwTDPw9l+9XjLfOljAIn96hUvIe6kjlHVZHbo4A/8vE/PaWdoT1O1wZqwf4kSMR3oXPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujYOB+xvTdIvBliHlzkPLhH/+GHH38ZpLvMYSoDhw2Y=;
 b=PCjiFP5/uY2kroTM/lyvzYNSDI07hVSDGVpJOAvi+GVnN/delrLLEcLrf5LtdTZhp4gBfS3dE4G3+el9kg+rx7PnGhwxN1ZY6MldFqNVdxhY8NLzAKDQRw7CotsaWa2yJTmnRRGTevXIMAmgywj8jKzwbXTWFyi79x5xmRTD3eXh8f1dhD2DLjQsAv/ZF7pAvrFtX1Zu+ZPxE8FQu1MC2af2fiGKJG6ZWLEWvAFDqPekCDsyQtxyogycC4mTTDpaekU+Mwn/7dbWUcOTixDzPyym0pP+aFPTCCe42taMyYmhZPdortaw5cPE1mtwmTWhggH+8eIQtX+yqUK2MQjpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 11:51:24 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:51:24 +0000
Date: Tue, 7 Apr 2026 19:51:09 +0800
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
Subject: Re: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <adTvrRcvI2rejKc1@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-12-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331124214.117808-12-chao.gao@intel.com>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b0c2cc-0991-431b-994f-08de949bfe4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kVJLiSEQijRk3jkJ0MYHVgq3piUbEmjSG3wq9Sz2u20wb4q4lHPXViFqKsZBuPZWo5Ubs+C5yTIX51DkeKnb9NOQZRUkCKnhf2r0nV0KJPkfcHiJFWU/EcCPo3xg3KDtOZ/U2ltgQ05jyHCjOQtjkLrSmT2dBbLt53DmTuQMjREV7d9n2qiVJ1uvMce7wbP+rMfB93p1cHtodcQ3KmsI9b0pp48dWzT79L7ZnaWdz/q9IefJ7BsiTqvkiIRrEfz2JLgzdatrJQCJkYQb1uPTteIhxADoLIbVjj8llUJRd959WeDV6mb6WpOKQW6nCBxeWmLwPpa2GieZEIH1svBmnFRBPfs6cIKprx0d76eGzCf698+vBk3PPeav1/IMZkibD9YNJMwHtsWKZdxAlPwpc/x5OOrhxybvdDbdKtr8Nq50wslxekEZeKcR15aA3KSM2zb9q+FUA24TlvECd4g+mZdCDzpr3vLwXlfLo7QKif4xKt3IZOmm4+6CfMBNc4SJnZtNS7+t7yCizCdMAgOH1rVFT7GFNfTsShn7mAgXr5Q9ijSELeYKv6bZHiTTJyfLhUDJnzYxAJPZtIq8sLSAPGZIPhEt2hX4wRhLBeRR5vjhGrikuQvtzx1894yAcdQPW9KrMCVo4/X1chaO15HSf6uFb+xEHa1HrSFj5aVS1uSFIQngr7FoyqRTomQRrwqVSPY1bn4uVqAiSZ8K1NkzQcVvBaw/CJ80wRZCOfzAa6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q754w0zJeWkoFKzFrorS/JK4+NdUjJYm1BPuUncDCvdTmniqOQQU4iYY09Gu?=
 =?us-ascii?Q?mrt8sGpOJzElqHwe7bKcf5EdfCG5TplAwvBHRJvgCL7l58NpOY4LRjx+uYAg?=
 =?us-ascii?Q?S5vHx58LT422v6xEcq66NShOJYo/bgLnR3JIWsqtCtn0XKmykEQIQL1QGX6K?=
 =?us-ascii?Q?ZetGSlGvPnkgKYj7etFUN7hBwsaqI0oWPaixGR+8d5plVu5E7qzfNN00oC7r?=
 =?us-ascii?Q?+hDMwe2iO+05HaS7kWG2ZvYuPANXyFzgROwZPR3fOdy04nQf2Rym2U/Wx9MT?=
 =?us-ascii?Q?GLsr7MJzRUwQdugU4KKCVxSSnPNDpjOSRkma47HgWTLCyHoFV66VikuX6Chc?=
 =?us-ascii?Q?k2c4w3EUYP6+bUJ5JPtkxjI4kvOOvECo2ouHTPKUMEaXPPFklCFuKfMe06Dt?=
 =?us-ascii?Q?IKUjRLqiX+ODzGzJuPVP3R20LC4a9L6FNV6JT6YjO1z2sIkhB6pPoMNcc52S?=
 =?us-ascii?Q?pDUdyrvkYOS7kdy25dY6jbOhbFX2AVadjhm7kbX9TPSJ3ZbKBkU9hS1CB9cc?=
 =?us-ascii?Q?jTNnAAOl5yQ/JWDzwbE4L3l49ajbWyPIdXnKbPeZs7Ih6U9sCkvWNb2lKHG8?=
 =?us-ascii?Q?boVrVXbGZNUrf/OhepYMYDIhPxR+8OeymrkszjcohS4cq18Kms1H5Lr/xy1F?=
 =?us-ascii?Q?qI2+seX+qf/Sr2J1FDL4ckaSLgnknCLpR6FToEfxl88T+ptyfQ/5cFulnORM?=
 =?us-ascii?Q?oO5l3zV32w7zdfe3sTJZzpKKV2tgxiixaIXiqbFYp2Qsa/4mvHCQmkZ+v2TN?=
 =?us-ascii?Q?TsDNs4TVOWejOgp2vlyY7L0D/QzyW394mdOZ5DHh4fHfQmDfOLrUwCg2RYT+?=
 =?us-ascii?Q?QPucCe58Jy24m4HXgiyahF7P9dnrNEEawEvTIebiTsGEwhfGLCByY1zQjBUh?=
 =?us-ascii?Q?880RuEBon2IHTv9kxYu1LmajiSUQiidAxLgR/AXA+ZOwmr0JlommMorwZn5N?=
 =?us-ascii?Q?6XnFYuyz/NAsHWw1yQTegwQaUAQYYJwUCXRao0i3+zHkPRuwANuoKBZcMnWb?=
 =?us-ascii?Q?rl8oPS7F0EK6DzzXOBV3iKzsgaS5fBpdBKuPUBHO96q5ByzAoAd8WeManA77?=
 =?us-ascii?Q?n9NBE0o9HJ1cSBE9S5TQgjkB7GETvei+HEHvDUc60r2/ZnaWBnyzjY4vWDzy?=
 =?us-ascii?Q?YwJO1qt5aOAdW+sHmtUDz58WmupYs5iRCacsypJ26rpLLefGB6wSAm2GmPCp?=
 =?us-ascii?Q?YP7JeRTIkJbydMxh4fjDvpaZB48WQxZU/H/Oiumb6WL01UMxDCbYzBq/LzDa?=
 =?us-ascii?Q?hoQdQsjO4GrYhBE5SzyN+uwGo7urjxTDYkJjF7OYFGRrXOr8wgYFUYmZ+QxK?=
 =?us-ascii?Q?q0kAznk3lofSpTh9wYRkEX0EsFiBMF8M8Fs+MzgzOIYAlrU6sAA73XkGEtcO?=
 =?us-ascii?Q?JE4wCEoNaOas97T11xZdbyLepLYMmxYEy3zGOUpdn327D+C09UA2Rt06GAsS?=
 =?us-ascii?Q?2XQGFRlUZi48AR540V1MrjqviqXB4Qp754Vfw+r3c/rw+BCCOqlR1oT0ABlU?=
 =?us-ascii?Q?rFeZ74VOo+KK4X47hZrINVWZxnP58SwZyEzmgTM8iKYHvAVXX3YsoOmznNCd?=
 =?us-ascii?Q?WMLXc6eIHyYJxQmp42FsENH7F6N4qgtBarMSpZ7rgv0SF2dCD3cSxm5eajVj?=
 =?us-ascii?Q?7OlTD4RenbtAIVZBvHwuAfAhy5gwfsdM/x0nKRBsIztuZo8UmcAs/WGTZaBg?=
 =?us-ascii?Q?4sbvpMrpBEsLalmwcRpt7qDxCcS1UhnV+jZQ9NCyfnEr2xK5GkBqw0oyCgbS?=
 =?us-ascii?Q?IOIJ0qK/ag=3D=3D?=
X-Exchange-RoutingPolicyChecked: PKFeLYbd/gB4cFfsAKcbNuDhIlTqDpKJ/bc7oY3NeFkk2yISazoLShXZUjC7Gy90qreRKGdmhyYWRCqb+U+p1NIGnOeb0Rd7ZZFAaM4IRPU5OWT7VAcMLBvqs7ukOUjGsYdDF+2MUFzNxumYhSxua0ByhN2vMKqHDmktnpDfuJ/4sVQ4/KrOOh3NEPSnHDAkejC0NNhAnzOAq44jpyd0CFOcUx9OnjkyTZEqB19VDdSsJl7NRkU+a3m1H+YgyHe6pBnBHenSv4vjTTHaAyF2dkCElXB8u6gVcz2i3fURzBUlXKUUv2BGoTdRFMMXn0or2RdJRBw5bbZ0XLYj2MIfxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b0c2cc-0991-431b-994f-08de949bfe4d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:51:24.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqXsjJKJRpYGe8tnhtGDBZYmFLbmgvItJ7hAAYdl0k/YtsdNXselwC7fOdcb0dtu0PLyOo4ehoRX6xHUfgomzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-OriginatorOrg: intel.com

>+int tdx_module_shutdown(void)
>+{
>+	struct tdx_module_args args = {};
>+
>+	/*
>+	 * Shut down the TDX module and prepare handoff data for the next
>+	 * TDX module. This SEAMCALL requires a handoff version. Use the
>+	 * module's handoff version, as it is the highest version the
>+	 * module can produce and is more likely to be supported by new
>+	 * modules as new modules likely have higher handoff version.
>+	 */

Will change this comment to:
	/*
	 * Use the module's handoff version as it is the highest the
	 * module can produce and most likely supported by newer modules.
	 */

>+	args.rcx = tdx_sysinfo.handoff.module_hv;
>+	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>+}
