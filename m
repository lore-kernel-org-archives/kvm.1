Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1444A70E;
	Wed,  6 May 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072428; cv=fail; b=ddF/LShIwmW9xBBqnJkvKVfxnMeLkCyRQBmF04+3lSzFVuwvK9QD0iT1QTg4Nuc268p+ofuhukpb2e5fAP3HR1FuiGeF6jtHgjo3QiD8q4aEEPGf4Su+d31AQR0ASR9ZZoJXDFWZPQzAV/FUt2N9X9Ta6dT71f2HjUyA5LgUm5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072428; c=relaxed/simple;
	bh=EzxzTEGRN90mphg9kQLgcqi+EoIEszo4eYgdg6l8/F4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hUrFBkgayXkbumVLD+RZL43Yj1chtTpnoHGGFAyoWK2Xcxc2g5EqLIKEQhhmkmfED1iXhImww2Dd+wDsnNxWyzWcPSc6oNm3NRnRmc+ppxKhCId9fyZYioaJF+Mzfx1qSUJSccBP8/XxkYM85BJ69VJyR88j8sd+rnFOAXeF7B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fi9BBIpL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fi9BBIpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778072425; x=1809608425;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EzxzTEGRN90mphg9kQLgcqi+EoIEszo4eYgdg6l8/F4=;
  b=fi9BBIpLM/rfuWpxChNhIxHrxh9NLTxHJ2kE51yuU3rP7Ka1R9hKPWVU
   JRnX0tOmRpDwa5yQ1hvl9iQE3fruNvEOB1kpPE91zVbLyXSz6+ilHrCwV
   aWFtdxao/t4tXJOGvDN2k/VrZu8BDH2hjqoIz05W2C1NtyY9XcCOfMde7
   yl98ssmQCZ6CzbvihQCvOY8MIUoj47w1AkcLnvz//xG6MWdNcITgZQDHb
   IIhVNWspPcDsNPXnYYq4yQTnjHnvYLC92LpMj6Ar/Fky4U/n44QnStyCE
   vLXKKrwbywxawEWygZSN2pPbAHh7pwb/IoSe3ChnrVHS8aXIgEDs0bQNv
   g==;
X-CSE-ConnectionGUID: vJgANeGlQe21r1S0We81Jg==
X-CSE-MsgGUID: w61crsNGQ3KAyCGpd0mdEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="81567348"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="81567348"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:00:21 -0700
X-CSE-ConnectionGUID: FYmX+YDeRTaEfMUGSr+Vqg==
X-CSE-MsgGUID: XNnz4x5wTwa//oVTTFleww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="233484522"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:00:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 06:00:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 06:00:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 06:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMJFDFXIJmaKSPKLDKQYmK+qM5H2mrRvrwhnnAxhD6NhEwIJqEXaTcI5BwvweOvR5jRGZz90+23IM3SGloNdX6EBtx2E+yJClz8rzjDnFkzfWfWEyH5HnPJ7aoEunBou+ZHCkBBMIVzK/MDpHmlv7kXRZLtri6C4lCGFYt0A/8+atPLPrlobdOWug2esStCttwKcrhM7v4axGLGZZ4ajanbhfXH8SJrRLrd+hkB+ITYGRhkbiOHHk0NwaxEoLGYPe+F1VlVx/tdWQVI6O2zxm/AJy4VhLtELgvDnj+7P2hVcvxBxkCi4yTSY7WEB53Qu7k0yOi0BdN6Jp/sNZ18D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7LROmlZMRtgtz01VI6tEX14OP0+Yqc68eGucHKXKn0=;
 b=YKdghSXO7fVKSQ0O2gwhrzq7A8e+bQy1YZRlc80o+tbRAy/H1IngS/InvsNoPyvEyGDJryuRhpPJQbtUwBV480Bp7+gdlsadfhC0bgztCEze4kFy2zp3pPE14CmY5OsP4kA/t5xEvopSlimX9oeVTCPJVBuNDkEu7wjuhB+MLiMHdk1A5WcEmL9Fny3nq00smPhL7gGj1eF6yjCNiHcZwbTYqQlH+cr/g+MJL5D9kyZU06w8ed9ks4m0vGz2QEeBJhHxLCZcFg+4ifTTnU8+hp/WKdKGcbFk7xOPoiOQlauR6/MaTonmmOMrJFE1uZKhSSYRLdfXjXP2rruSQhsA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:00:14 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:00:13 +0000
Date: Wed, 6 May 2026 21:00:00 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 09/21] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Message-ID: <afs7UATlAuDehCCB@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-10-chao.gao@intel.com>
 <5dc70847-332d-496f-b0ab-03323eff7118@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5dc70847-332d-496f-b0ab-03323eff7118@intel.com>
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ca560e-75ef-4cdc-91c6-08deab6f691d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /B7CpyUf8fiVhKOZ043WvwLg/Kz0nxw/BFxklrPavi8chfokHgSJYkaVXpaHu8tGAts/KJnBR9sWPceWYuf9Xb9eIiJBIBzhB+XGjPMMDNuw3JF4OarEZMWJgNG4LuJQnunqP2NZ+0U4fzA/WbtefR9y5/Y15hKmduTEx/0jxzcbPAItYFeNvx4QG9dgiEtfM5IysitJHckAxJxRuUi7JSdp71T7sfaLFjxWogRsKkRAWDL6dJfvwJtaPaAv/aoeYMeFj7TmKts4frnLqVrD4ZKRlKvF/qQXWfHHZYqv/qh/N7MwX9d4iIz7qTDzu1jzL+wKHQ4tCWXUmaqS130MPkix22Os8QX5rQvhT3WqEf92G0wSAe+A13VSwJPdYxFL8XZ2ddAEURUHcc+Q47QGP/Xb7LSdwrafitHNIy41UC3HQy7+bYTNMfzC9+9fZIEeY+wTNygwBsXDrDnAq7jB51d86dPNqIMWg/NbUWLqNSpG5GMryq3eLG+4Efswr85FwgaTwuPpZoQLGz1xCFUyhl5PRJc07VmGUkFz3cJtIOBARGXQv3xDfLZYULoHN1PgQRAG7CJjTSoKCp6mQSOf+tdUlce+67phT3Eemb3oM9QcuFExsSndpree/Rj0t5vpZLJHCTKUSdPsV0D6ir2QNaePWmdUDdRUMAQ80yx9OTyu8hXIwLVcIpnpduHaWdrBr/epFbI8KiqcMeUrVSPRHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?695m5RIhQ3cWnUEZCjO/f3Ggms2bfuN5yitrD+NbnlUjzS+/7e/hjIG8eJZ+?=
 =?us-ascii?Q?J3S/d9t8fRBkB1/jM6Uo5WDCAzTfTqVbZvB0iOK4I1TayoGGTLuX1kN0SJ/O?=
 =?us-ascii?Q?MgSBAYmskPbpPP9tr4BPYD40Yt32f1IQOrhSEGvZd4ah+7BZW/ur2aMMNTaY?=
 =?us-ascii?Q?VSnVRed78Qr1KlToiVIw2PLx3xdUDqSitfeuj9MCqW7rkit3sh819948bR8u?=
 =?us-ascii?Q?naUgH/uZ/riG1wQuCMFACTG/1v8SQnF3j61V83mk3PflNh6Yg0o3TXszulpm?=
 =?us-ascii?Q?JcnYvYw30nOvViZbUgYL9jje9PMhQ06APiywqdfh0BP1S/dkd9AfQwa/T8K4?=
 =?us-ascii?Q?C/oP1YEym3yVGI6iRZRaAMp1GDhl9hqvEV2pA1KPpH1TwOsubf0UMJWhIULK?=
 =?us-ascii?Q?d333CZKWmKZZtPLAE5kqzys4GDA1PW9DD79xk0p1gVUBzcoMK/5wPIJ+fvGs?=
 =?us-ascii?Q?vE+J588cL2r19gwyOnaknVdzTaneSH5pgs8W3ytmOpGOQF2bnzfNTPGuceeN?=
 =?us-ascii?Q?JpCEuLTkFQYgz8bICpyAWW+b1i8oC6CibQsecZEzyQsQ406+nhu5kw0LshlN?=
 =?us-ascii?Q?SJdVx/+cO//3LTcoLx5e2Ud5eh5vMGT+kOQATZTKIqVOg+ykHd+Pqp1FQ8mb?=
 =?us-ascii?Q?RsnN/WkOhJULl3i9enLyBvWbrCvyCU/c2DrSPMcHMjhUIhbFBx6vEHVrx8Pb?=
 =?us-ascii?Q?4Yrswso0e010fVAa7JgYnkms1dWQPdtv3JkrUXsTPidmMBKRzk1Sue10R3nC?=
 =?us-ascii?Q?KGdzDx/P/4svYbFIq++0bTp7zUGASWKg1W4H9Vga1a81DnnoFQZeQLJ2Gm3e?=
 =?us-ascii?Q?QDsswYeiT9twz8gKfykMxJFgSwkzIM8NqsJlB4/mJdgxyz4K4TSldcvFbe+9?=
 =?us-ascii?Q?7YgvDPXd/S6gDET4c1PyEEatlnph0ExaTTvyNaBhLIDYwIBVF3OXAqoG28cP?=
 =?us-ascii?Q?jcrIE+IuSQI+VPa2nNY/ilFJXmdSTnB664JmkrJorAXsDdsjrw7TYkzLgy8a?=
 =?us-ascii?Q?wXH8DrmUI7dwmDWQ4cVqf8Xc9jRAlLWpH/N5q71WJmP5UWd04PLtjR5pJiR6?=
 =?us-ascii?Q?wSdnY0FNse5WU11nUHOfjz/maHbd8+SOr/tuG55EYnKblP866hyDTAw2J1zq?=
 =?us-ascii?Q?Ju3lhWdiaroypABjRpZki8BZlC/D905jN5YayqvPeFMTPZirNMCy2c0gDGzT?=
 =?us-ascii?Q?yeoNTORvP1fBN7DkMv7cELmTMLimRi3miQkGmEGzZOgziWagAbieL85hT47L?=
 =?us-ascii?Q?WS9hyEh4My94ngfTcIhsiKzqGtouA22Aqnqx+CyiXGIhybXJkc67/zS2D3WB?=
 =?us-ascii?Q?yjjR1oypKi6ng27uptjDEfDBrUxbRo+NQU+3+WsC5hcs98uAQ/WkEsIueN9I?=
 =?us-ascii?Q?dh3/pq1JCkw6oK6EE7/b7xmgpEeZoJkK/B0mGBljwC4hRIQYv9O2k1Yaj/Gg?=
 =?us-ascii?Q?VJT6niHZt19K79DuTgw/fG3T2O6aTzMsSoX8A66FCNa49XwOzS3R9jopBQbz?=
 =?us-ascii?Q?9TtH+C6PPyNJMuEjHcmFqUod0MxUMhp8ymUokCGt6VdOVNcKLZEaPCr3L//s?=
 =?us-ascii?Q?r2qO50W/IbQnIMAp28KjAu6bvJHHjJ2gTU2D5TASQABEGew+KGQddhOJBzKs?=
 =?us-ascii?Q?VuOIEQQGc5yP1v4E8oWvf2INmrQ1Iyq+RLhjcf7Pakm4P1x3EFrEqxTUA7vH?=
 =?us-ascii?Q?ZRwpp5HGTkQkg1FD2Z7n49Yiqn07QNd3byRRHGQV0qjma9HtV9sYafmOT/vP?=
 =?us-ascii?Q?JjCYeR7mpw=3D=3D?=
X-Exchange-RoutingPolicyChecked: c+wRO+oTomtXU2dyS/eqT7U81HwX7RvPxEzh+z6UCFPSDEPc5mz0ekwO14ccD2/9c2g0fpycTq05iiJE5TvB4knxthoCbe5ikKc3QOX21ACWatV8K3tP0C4qwzhDAixEGqwHoR1Vbww3WpnJw02hAM01NrAXp/F9B49JWXVggxbN4khQYVjQiTFpyhU+ipwTqlaceEZGT12GdUN0wA4pAffnDYYgfMpVTJ9qOIJSP9lmtfJZAxhs5WwqdsLVT35lO0oKGXhRwiiLJ00+cBPDwKmc21UjJvJMaPuS+uDLXwD/LXEbN9lNS7rcNO7sFxy3C0aKcEpqHeN2GHEeoF6/cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca560e-75ef-4cdc-91c6-08deab6f691d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:00:12.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prWuhseGzAkyOeSn0zIEQCz42ZUqy223wXVlpbl/fr3Bx7F2+AgelUWuMY4pxWQmgG80WPpF2Ws+yJi6FabLOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

On Thu, Apr 30, 2026 at 01:03:53PM -0700, Dave Hansen wrote:
>On 4/27/26 08:28, Chao Gao wrote:
>> +static struct {
>> +	enum module_update_state state;
>> +	int thread_ack;
>
>multi_stop_data has an atomic_t for this.
>
>You have an int.
>
>Which one is right?

You pointed out that using atomic_t and memory barriers for synchronization was
overly complicated. So, I switched to use a spinlock, and thread_ack can now be
a plain int.

See https://lore.kernel.org/kvm/31936a20-929f-489a-9dc6-0f8fcb9307f1@intel.com/
