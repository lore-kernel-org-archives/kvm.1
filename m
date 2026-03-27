Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CF3CF697;
	Fri, 27 Mar 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602486; cv=fail; b=LXF9sMrhrel8JaXaAmSFE+YWbxVlWtFRkiVA9pZu+8GkhP2nq2FEUUe2k9/Wd/0kUcnIqBfL46Jm3RC+NaNmmKXjqqbviol8zb+AgfY4S/NEOTMlHuxUlZBF7iEdmRcw4rcdHh3E4rNul5uYAZSTpyD44vXb0mU3zuKF8s0Wbio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602486; c=relaxed/simple;
	bh=tlFRNiNXBeDt2ZWOqodYAjpAYCFfOr0ogTN76q70ebI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vr3WJurRKHq8jLg73tg4Sbja/YJ1eRSru9Nc/wPg2nbyQo91H1wLEiygTc3LR+hdOyMVuYPGatzvYI37qXq7gPjTTzuWwRvUwzARSX7vrnwr1H6lJYV+z8ABBY3iEac5lCodQLDCGO4+0lxFOuO6OfPi63ANe4QG+nV/KoBsZUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTUr6V9+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTUr6V9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774602486; x=1806138486;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tlFRNiNXBeDt2ZWOqodYAjpAYCFfOr0ogTN76q70ebI=;
  b=lTUr6V9+D/qSywk4Myihb5FbOjT+rcJWzJHlxKV/CIfpRa91NBlrbBVM
   V7nbK/zVaSD6UM7nw5csK1/fsJ5miGOQRvOnZyvZtGblA1Yo7cGwxED1N
   Pak6S1znIhljePOBQAVkkfmmzq1ozIWVAs4ItkNah2nsryb27AS9yKZg4
   No41EL7smAPUhj8JmchZFr0JxDEmIOgRNwg+J4mnv2qtmYqmUclYC9Lg+
   pZseuq8OTUB04fqSWCEvUWy/e6zMfe/mdJ5+h7uf7qqRs7hyrS+Ja94NI
   NveLDIDmwuGsWdBYlIku8ISZ+B5OCx60gCqR1F1CoARRaZBPDxolFZNnJ
   A==;
X-CSE-ConnectionGUID: JZaHuxnaRAKkI9jtoFUJTw==
X-CSE-MsgGUID: 8vCcngB8RYulCN4KUnxHgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75554931"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75554931"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:08:05 -0700
X-CSE-ConnectionGUID: 9llpriz+S0GdTtDT4+igtQ==
X-CSE-MsgGUID: upNYgZ5DR8qqANo9w2F2Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="263202245"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:08:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 02:08:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 02:08:04 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 02:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt0JHYO6VehuVGvXNkwOpcGE4ul7+m02fQWeJLpoh+SEtCtsdB5V+BTqExt29APXYKQAbbI51F4rERfWCCvydwKN3VpE3IurbFk+JxI8pay91077yNPOYMtyNqA0gvKvGAhFU/0Lph87JFs7VANXDPNcFvSwT5PW2L+T48xoA65Ph1oNWVVhK2b04MMmCp0iJuSniUcU1c84C4VvTsQ3ZzVkB38NlsORWrrvhvlmofuyPCNtmXrSx/3y+yl11CGBZ2qRWkVmn4yydqN6ZLlH8pZvpaDGAwUY64amJMGNWXVttFeOHWWQjHdZiCgUXSueYBS0XAuuBmiZ8pZVi4VH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl1BxBznnrw3mDIeBSM5Q1gimQD2oEPymyQC3KuwN14=;
 b=QWmoOTBbup/DQiRCSyqwlH4yHSoR/TY34rxR0P//oaY6iRZ/VxGPmD3lCmDtchcVRpw4d9JCFUbYHbwqgE6A5RvHiN/ysSVDglLFLCUgW8lpMkx1KTBUbdasgxGr/Da5EX/6P965uWy4439AoNwj4avpvIda1HKGo57oJ8QmkiPoAAYX/Du8KStjPY5DxIOmEDhuWB6im8GU7u3ElIiOrnkRJ63EXQbdRstnR4UjCIcYaTfsbv5wYzJH9e+O28kwFTkYnulapyEnLtb3Pqe9eyLfK30vU7ROJBJDgKCzgAHKfvglBkjeXhjmtIRwE05pk6eSqp+gfSwEeqMRxOP7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SA3PR11MB7416.namprd11.prod.outlook.com (2603:10b6:806:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 09:08:01 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 09:08:00 +0000
Date: Fri, 27 Mar 2026 16:28:30 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Message-ID: <acY/rr7g+gJmkXfg@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
X-ClientProxiedBy: TP0P295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::16) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SA3PR11MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: a371d4c6-e994-4177-76f5-08de8be05813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: oFSC4bYOqv+QeYA2xpZf3IwF/IC7VwGBC9obHUeT2JskRmTSjYrBXJX/lB+MfQTTKLYVM2S1ORv3OQgHJvN4Y6X0RTuPTCKJSpOnoxUH64uZY7HCWXerT9xtum2a7v1u87DfUPXQu64lrSd3k5kJHR5+F74Jznk+frqrWXEZmtuaK5DpidkU+OstpbUratSdFZh2SqxdtXUcDUr594nihbi00x10DbqXgBFd7gNx8mNZqkWWoOCeapudqR3sSb7daO/uHe4p9JvCQCaidCDLJsV2L/B3YJyD/taC9KxUuOnp0aZQO/vYThmCql3dJQNLUAtML8L3qIHp2oqCw94oGJ3p9yd2j+CLf4hz68Ammekzx2vohEJTdDCaCNVXfPD8otUZAe4dWdYMbBCGKsgYeynJp9cVX7cG9XBPAMX5IKA4Eo/lalGVO7zT7fDZY23ZXGxhTCMFbqy8pPpB/frJ5gX+OqSSB95vY1rmFExf2awZJGda+rzhVNLz2WClxHcuoGRtSLtX8hnj79C4PFs43yMOgEqezwJjardB0qe8kZtnuhYkOp9yqy/AjkO3gyBeeGSIQRc07pe8cLaXcufV1K6y04eB0r/Sp4ytyheIDEx3GmOz9ek61yMJTnETR34481nuWsifHuYWInM8Ki8RVo4r3zbgOPO3QxDwNJL9iqvtps29WcmuLjKCecusM+nfMRgaSVwJPQ3blKfe1FgmQp+Eos6TRMiIXEibB0npdYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xFHR3DyxQaD7bJp9xIOo/AtG4Vwe2BhE5ggZf824K7pxMfXwbSPN0l4pro?=
 =?iso-8859-1?Q?DczBx8LAea5/mxosd/wcWuJmQf1pvvMFASXmh/ZkSyKj9H9qJXKol+69DB?=
 =?iso-8859-1?Q?Id01UdRPbTxCnFba+U1apLexZYJtMu7KV+YI0V20dLTQrnpm4Cn+ZKxGPa?=
 =?iso-8859-1?Q?jZhv+xeITXUUJuwRPm+ubM6HHXY3wH1FaoC5bb5J7vfJhDNTmv8/ITWJNi?=
 =?iso-8859-1?Q?wVT8E0d32f1Aw9UIye7klmYsRCkswkpyyhuSbH+EyQhWESCOUuD802Zdcv?=
 =?iso-8859-1?Q?pGj2EHdlKgLYDiVJFK9EOuokBfgavqPFJgg0JRjr5ys0IOTggGvBoWUwDs?=
 =?iso-8859-1?Q?a/eeF5fM58zLOK0nrv6ujqibhPaxRugG3tAAD7QOOftgoWnv6hpqNPCGwV?=
 =?iso-8859-1?Q?/ODJBodWEcs46nx9DQ97ZTCuX5sUC02QqWj2mEcY+5shMzleQQWq7O8Rjr?=
 =?iso-8859-1?Q?LBEdxYK1sUND5wclnGmhnoT/IMdojFkEc/sg97wgPTlgEpd+m9NqtD2Mde?=
 =?iso-8859-1?Q?5mKnp4SrBKrgd5Ov/JGpnh/6uOASahvTKHi3DDn9zQsvmIcd4Jhmewn1C7?=
 =?iso-8859-1?Q?mFN3zRTJPpayF4wAAX3RHeTrA2vk7oOkOwjk14+YsSkcfHV2zS6nwGdMkt?=
 =?iso-8859-1?Q?YXf0aaa1ikoV/Gyblj1rRO5dbIgVHgJn3aGNdVM+SBbcYUilv5+aCDw4jq?=
 =?iso-8859-1?Q?3ACXnunLXHRIa43TJ/1FRBmmoyhOiOp2ejRIp5bmEdFAN8qS5B5qyJsD9V?=
 =?iso-8859-1?Q?hB3hKO6Blw2jaUf81CCUWtphDjGRgl4rvt3y9PAsCNpitf8jgNqbB/N+xv?=
 =?iso-8859-1?Q?skST/GGNj2Qr4kB8DgkQvOTKHj40UvJkkzCvVMCC1P1j02yqYDOAnE8ZvL?=
 =?iso-8859-1?Q?+WQHBic/9MKXhUnDsTwMWjzXr1mFo/vePnG034+08zZTVDUIsds4qxJRX+?=
 =?iso-8859-1?Q?MltVf2a/VEvjEuJtdjbdjEf9m5IFoz9TzpFFsYU5vAUhXlQm7kNL5MtZJM?=
 =?iso-8859-1?Q?D3zb2dq6/95SwYeC/AOwtCx1qMB1HGHy12bhRwLK7npbzuig57zDihoHTV?=
 =?iso-8859-1?Q?Wvq6YISYTlFQIPDMxTanJ9SvCwXTnDudi9h5PvCfeSsOh3FOq6b5MMM9lA?=
 =?iso-8859-1?Q?exNRxtqX9w6ll9yx0CsESvGxcZCeZAW+dQISLeoaAf5GDkRm5qn3FBhDCK?=
 =?iso-8859-1?Q?O4gkUsppLeQn6rhy9xOSThNy5c3g1aKvGop3rCYeQ+IuDR2e/+TvRbdAEN?=
 =?iso-8859-1?Q?VhXaDY/xvV2ykYmsJYS6mimOujiuKCWLD4DeEY1hCtaOPeIGFH2NhsAJwx?=
 =?iso-8859-1?Q?0YSUSrmyFP0qrvb0Z2kDNg36CwVjjiOZVnfGBl7nkSJ7lmzQ1d6l7AGvB4?=
 =?iso-8859-1?Q?wYD4ygmo3Pa3drc7dPsJlj/WKdjL9SSj39RTIWxkkgwKYwU82M5I53rucI?=
 =?iso-8859-1?Q?zD6Ig+fi0f48k0Wqqvfqaatw5cxo8QbvDd2q5LQJZbrpfhLdLrx78lUjrI?=
 =?iso-8859-1?Q?+mO/SKoM6R6v1BQMo111jZdZIRUsX4NL8laLMudGOUnukzbI+MSISPJ1bU?=
 =?iso-8859-1?Q?hbeTPliTD/OxeEP1U2tyDfwtwW+cKPU72V3lhQKrAmHTqPJap+qr7p6Sin?=
 =?iso-8859-1?Q?u74DIIzD00i8TL5w16lKKP2ZIgX8CTXo+PUw0ZUNdMDpY0qgL9WkuzCnCg?=
 =?iso-8859-1?Q?Ak2cw2JlO3mVZkP7vwvDgeRQLhHMBP5Z9NboUKffBPvrrS5KGt5W8nfhob?=
 =?iso-8859-1?Q?nOrX5kT0tag26k2Wxh9/4YXyFTRmlv3na2sITJLs9TqoW9i/cD40DRnJGP?=
 =?iso-8859-1?Q?7IlARAzoVQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: NpfW3wse4d2xurdpryweBSd6d/6wx/12rb6sLBzFDogisBfn6qysQx4ME+RpjW+i3WRiAl+/rVXO596RCXQ4lYjzCYk5cw0I8sod5lEb1J3ONVyrl/pYisQS0iNKO020QCCB7Az68j/2s0nE5BHsFlAboz7kcE/eFhLwUx3DkHc7a6w/o/4uEvQEfg1lIfJakN0p5VipNsBKn8lHhoYLpqCGU+LZWNg66Lf5szdJpgf0A5DeujwzNec7PA0h/m58pRpJwukhkDwIRd3g4Mxbx2TE4R1p3ibvis9ruwmn79p0oA6RF3yArb9uN6AgMyLnne6G77oGzK5OmyKp8lY9Ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: a371d4c6-e994-4177-76f5-08de8be05813
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 09:08:00.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgTFpmy0W7PK3TA3vTADMKIAflgUHKWfjnqYyPQEvvzq9OrpGom7ED5IQEfLuLgy7bMh0F3TCy1E40D75sPV7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7416
X-OriginatorOrg: intel.com

On Tue, Mar 24, 2026 at 07:21:48PM +0400, Marc-André Lureau wrote:
> In TDX guests, hotplugged memory (e.g., via virtio-mem) is never
> accepted before use. The first access triggers a fatal "SEPT entry in
> PENDING state" EPT violation and KVM terminates the guest.
> 
> Fix this by registering a MEM_GOING_ONLINE memory hotplug notifier that
> calls tdx_accept_memory() for the range being onlined.
> 
> The notifier returns NOTIFY_BAD on acceptance failure, preventing the
> memory from going online.
> 
> Assisted-by: Claude:claude-opus-4-6
> Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 7b2833705d475..89f90bc303258 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/kexec.h>
> +#include <linux/memory.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -1194,3 +1195,40 @@ void __init tdx_early_init(void)
>  
>  	tdx_announce();
>  }
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static int tdx_guest_memory_notifier(struct notifier_block *nb,
> +				     unsigned long action, void *v)
> +{
> +	struct memory_notify *mn = v;
> +	phys_addr_t start, end;
> +
> +	if (action != MEM_GOING_ONLINE)
> +		return NOTIFY_OK;
> +
> +	start = PFN_PHYS(mn->start_pfn);
> +	end = start + PFN_PHYS(mn->nr_pages);
> +
> +	if (!tdx_accept_memory(start, end)) {
> +		pr_err("Failed to accept memory [0x%llx, 0x%llx)\n",
> +		       (unsigned long long)start,
> +		       (unsigned long long)end);
> +		return NOTIFY_BAD;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block tdx_guest_memory_nb = {
> +	.notifier_call = tdx_guest_memory_notifier,
> +};
> +
> +static int __init tdx_guest_memory_init(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return 0;
> +
> +	return register_memory_notifier(&tdx_guest_memory_nb);
> +}
If I read the code correctly,

online_pages
  1. memory_notify(MEM_GOING_ONLINE, &mem_arg);
  2. online_pages_range(pfn, nr_pages); 
       (*online_page_callback)(page, order);
          generic_online_page
	      __free_pages_core(page, order, MEMINIT_HOTPLUG);

In __free_pages_core(), there's accept_memory() already:

    if (page_contains_unaccepted(page, order)) {
          if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
               return;

         accept_memory(page_to_phys(page), PAGE_SIZE << order);
    }

__free_unaccepted() also adds the pages to the unaccepted_pages list, so
cond_accept_memory() will accept the memory later:

So, is it because the virtio mem sets online_page_callback to
virtio_mem_online_page_cb, which doesn't invoke __free_pages_core() properly?

Or am I missing something that makes the memory notifier approach necessary?

Thanks
Yan

> +core_initcall(tdx_guest_memory_init);
> +#endif
> 
> -- 
> 2.53.0
> 
> 
