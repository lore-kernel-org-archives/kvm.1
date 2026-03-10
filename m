Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64539E6C3;
	Tue, 10 Mar 2026 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110115; cv=fail; b=jF5t3W3Jq6eaGgtMd4vdroRfBtTkZPQgUNtD7WJaKMPTrkl8GruPKu48zIJW4fMClpUIyoeOVsrZK0eXWZIkC7XN2DIFGC8CYp6OYp7VJgMYEQpeWHZMixYhapSUsdMLennQCp+YBv6rdL8fY9XRUhdFdoePf/tQwndLXGNvLA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110115; c=relaxed/simple;
	bh=/jqYqKl42xMrtkaQjn0ZjmJidDrEJuxY43dCcXJMnko=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHYI6ZWBL7fwniPWNrejPCRzArBnBbYxfyzueq5b/LL1R6/zPJQnIZtt8fWtzHnqvUZkJ4vPOUq2sHXkJavkEVOrJCz2hUn2hpixZFPHrK7LG5P7nL8i/2Z+09b55qcaZXbc6C2wkNFeCnssXPnbHF4QPS3eFt6+q/yXYyFmIXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey03bHAp; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey03bHAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773110113; x=1804646113;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=/jqYqKl42xMrtkaQjn0ZjmJidDrEJuxY43dCcXJMnko=;
  b=Ey03bHApeJaOAM2b/gN+2eZ5hkHrFPeah5ZHAUnINHrgVdeyMqiWzywG
   jaXSpi2j7T9NUHdffj87TCOx1IES/uZHM+4J6nLbc9tQRRXQYq/7/7mjG
   erPiPVUGBOgp/jkmSWYHCDcKl+Zi9jKk94f1cU5OGeWoLnn3Zo7ucyZcx
   VOAtYi7rXqTpKCx7+KwO/gcs4W33ZH+hFP7ib9JOO8OFQRVLGDaN1p5ok
   tONnI6+J9xIj2FXYfNoHyk2H4RFKgs70vCELo6ZVDGZZWxgoCDluWwCJt
   DoprgKTF9s2BND/mNYNIj2oc0NITRlYToI2zflZx9SekKwq94xOKKo4cv
   w==;
X-CSE-ConnectionGUID: TKlk1L5xSh2Cs7TKGQECRQ==
X-CSE-MsgGUID: fTsSRA+XRMGqeUvgv1RGfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73846269"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="73846269"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 19:35:12 -0700
X-CSE-ConnectionGUID: ti61P49ATuKa+Luh7r3M6g==
X-CSE-MsgGUID: cyCrisrST+2xHznqQg33cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="217962026"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 19:34:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 19:34:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 19:34:46 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 19:34:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SluO+Fi3bOXzKsO7hL521b5s/F2pyxcD1O01OB/Hx43B/w9YD9Iv8wf0MW1r+x/w/qgxsi0/LHtpuxne7kAV0F4W9V0+whXAtEuqCO8yfMKggHRDSqXuAsTGoZyHHsLECc/IdE0MeRhJD1b7SU3qFmpWq35JybUAXhrGNGqbrMi4SdaIfWKkhqnG0X9Rf7Qjm0IUF3yMqBNwa+DADPgAspB0pmnS4TsCNxtv6tFaQkRY3Hx1EsVJX/RIeryENo6vAVtAbqBrnpq+IG4U11tpRV668ReBbrTedbQF2s6QCJlsDCWy0aiuVyGDARMjwRpQh/C6cGQZX82KpmbpShOepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9QEboOs2W/ttL9NHIT29FzvtvwH1I5y2cXwpFihnfA=;
 b=sIWfBdqqu/q7DnXUSansAJVHW2jWpz688BWRupOE9HusWSJ1I68PHsrd1zdCK9W9YcOZJdSRYgt8bMcrz+duI73hFnWsZKE3u7EJsWcYjqxKKtzgo3+5M23hXORBefPGLJ2YWIvH/fhCih0RwWdKBnHWRJCP1TeD0gOTynGmNfy7ulmKhgGAmP4OdrUodUStv3U983f/1ZazvweeQEgLPjRC8gU5hL7RaPasx7kTAffI/lSxlzQwSa2kXb6nT6CC6Uk8/qGT3KHyFFAH90Oa0PhlTPKJnycMMH3omutXZBOXhlcLbZ8zMPTOgAeZHCsesIYkyfxSylolRZygX8rjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 02:34:37 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9700.003; Tue, 10 Mar 2026
 02:34:37 +0000
Date: Tue, 10 Mar 2026 10:31:25 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Chao Gao <chao.gao@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 07/24] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX Module updates
Message-ID: <aa+CIDfJZA4zqssy@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-8-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212143606.534586-8-chao.gao@intel.com>
X-ClientProxiedBy: KU2P306CA0042.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::14) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|IA1PR11MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: d072ce58-0663-4a16-f9fa-08de7e4d9293
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 9fQEXGA6d9oQqZbQvMtVBKx9+fIwUb56bPeYeEl6WjCLoOqs7qkM7jWD/h3627bFvUFxbwtcfOBAZmsukJj4fR4CzqOJvRKm/mqsCDLR1tGKl1ebTzmpnaWXM2EXfG6rJgshluD9wL3aaVkaR3fo+eTq4qSadXCBjdfxveKAyVoZxpXm1yCvvdmB4CdyhI6rDDA80n2NLcWXW5VmHvwq3LxpIluXOpNljfthe3+y62mpQcJ9XgN3PTZ6hfidbr5VLa0Z/Xdt7O0YWkWoeBwxuW+FONvGgpcjjOjoPpSemYkhDPEmtRaKx/sfNrSr7eFdxsKKEOy+nvbrX/tit0E05UL2hhQ5yI4izXewMPg+J9bQNNBj1AqGVuR2x6jx4AFbfX2qA4BY7ij5Jt9QI+2wfsqp/PUNHeu7WTMoL9uznXRy7evD5jichk30dHE+Jw0enENk/l4hofEDa/Vapm/0npQi1vd+kHvzd5A/ZsHDUiZ6jscCPPeopJV249tF+RsvmDVjJ2f8ISOFEVqit5OZkSbcCMk6KCf8WFSfGjU9CJkytFcywdcD+qQ1Eyxvxpbkctbl4KlAXFTFTreX3vsolJEetecdQTPgiMTmQalIzF+Uhcu3uuIds4yvbvITXD85PGwQPjNR9URMNQ8ebqFel+n1vYv5rDTOb5US4We7LI/FfOMjjUvgeXjJPCaQsTqrq1sNGmcLoLUYiLrnMZlugmuwvQTh8Q8LePmrNPxGFxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BrVvcVKhmCh1Hb7XRz/pKukM9S5CZHuZ8dtIcM32RdcuOKeNSBQPiS4YWuNP?=
 =?us-ascii?Q?IQXaOaXjn9c6hTVmOJeyERCSFv3ttW09wHTBF2a3khu9CrdP4PI+/Nr/YgxW?=
 =?us-ascii?Q?YDQvvdJXA778H2JjrZBDrG1iQ0DBpj3nvrbnmJE/pazVEDs+fyMfyynwEN5w?=
 =?us-ascii?Q?rQtBY2LfTovAti8pHtZP2Rt6QKcdWzqu9jeVoQNpfJv7gD66IWttnM8UKpn9?=
 =?us-ascii?Q?ArFnU0krx+wQ4rjrJZS4+xpcSRM2VE81S/8mH4NYGoPRSHmY+/ZEj0PkOMjY?=
 =?us-ascii?Q?KD7wPH9t5JJTQVoAJO9SS6olSWjyWd76MCknmMFpgawcGFROuMhz/3AtSPqQ?=
 =?us-ascii?Q?Be4ICk+u1YrbgDLITxEYsMzUNilHFwZHXQwYbAhwxn6ipmh3MWvkBfUQ+yIi?=
 =?us-ascii?Q?yhpdcl6Zu9OpbLBz0Qpq2Q+LZkpAtd5AzSwMT38pQpGNjIUp1vbL5lRnlQuV?=
 =?us-ascii?Q?p7MANP49ojSJ2sLpaJ7AaYmDPlr+N/KTkJdWltV639A8mrbuk00dL79P7vZB?=
 =?us-ascii?Q?wzEL1CPIG6ZLqX8khMC3TFVqL3C15WIEnNgZst/ncN8ud7EL7orqbopKG511?=
 =?us-ascii?Q?Z9lYJKXKm68Hmd7gux4+W4j0jMGCT6WYY+P5byVIb6Gk07G9nCldA68lIgf3?=
 =?us-ascii?Q?zRVMe5UOa4UzvR13SgWj6pc8SzCGqE0xznjJLvVxFlX6J9QqNSd1TKWZwAFg?=
 =?us-ascii?Q?rS1TywJS+9Zw6fKxHAakNczG2HzjRvrBH1u/HsMZcBWY9+ShipASh8PF71Gd?=
 =?us-ascii?Q?Rb2xqoFd+BtO3I2UF+O0smz9sAFmsLj6O+wGfb2uLQvxsmcSwvwbMDzJnr8t?=
 =?us-ascii?Q?V34+oOlQ6ctceZfD4qqYWEB7oH0n4kO0LJ/A3zlAMrQJZIqDUzWz2Jcds80D?=
 =?us-ascii?Q?jCxRahVVCtOgtbaa9Uzaf/QZCREf/4kVr0/TF4Ofem4akHFGO2uDOgTwGcnA?=
 =?us-ascii?Q?3E0gjOSB1MO2lT2pYtGxuYz+by9dYmbHnjdhQILP8Lfx41WahbuhqSJZZ3Lq?=
 =?us-ascii?Q?P/zCrNtMQDzll1dIaZ0e0oyjx80ABUN2hFq9tFYBtvITKnlTSLvbhhxhcVYQ?=
 =?us-ascii?Q?TQEW/5g0mo4BRFn3fhMEOp17KtsZmDV0PCPcbp26szM7bQhg9la1t3/vRhiL?=
 =?us-ascii?Q?Bm3EFoY4fqE0BeUzUUYkH7jQlWFtl2EGIUWAy99ojslJqohd12tLE6R6Gx+3?=
 =?us-ascii?Q?RZDKwwnA8KKECLm8PGZvd9lNLR+F0o1gKyWpkvjmKi3lKkYRWEDGpMs1zTAc?=
 =?us-ascii?Q?PoO9XMp4bfdCLzjLID3WubKMDM4VW03IiAc7NmFc5XDNAPt3wxuriAbQOcgY?=
 =?us-ascii?Q?XuzZECIUPhccg6H/K3idaqu1lzPSuQGK/00kNU4YKMkiAEAelMCABpasZD0V?=
 =?us-ascii?Q?leFHPWuYH/MiimAch3H/GIQDFlr3P47mJwT3CZyVrujvaLGZC76uuWrFKtem?=
 =?us-ascii?Q?v0dyDv2EMNwHEPmDF5+PXZNtfNJbeX+R9yucFZwzrrfEfb7fVUKSu6+O8Neb?=
 =?us-ascii?Q?Lymt9bZGxbxDvC9qHpm+WLHiLwnf7NFfSn7faumTiiP1/TAXZR31z1qIIpMS?=
 =?us-ascii?Q?FM6P5N1oVyrrwmwIOwjgpo5TyjAJ4H4gCZQTCKtFgzvJLvgYNvX3NERSwkxt?=
 =?us-ascii?Q?xU7aSDFK9fylFKIK6kIfosnjwTg5TJvOdkmUtO94I5CfWFyfSRb5aIz8GHcW?=
 =?us-ascii?Q?E87jSZMpTzZwwlqFB8/22lOK+ul0WCWz7wxNbNNmdRM92JAFj41J11J6NeuZ?=
 =?us-ascii?Q?4cnRaZJIwA=3D=3D?=
X-Exchange-RoutingPolicyChecked: EK+WC1nQZGR91Sk2U9PDJiKWlJrsgDaFxCFivq4yN8ijKJqTc8xkpeByFB148d/hOH19G6F1khLv63eZybqaZInNMhzhjW+NIy14lU9BVvGLHQ023YXJrudimNXBQVvygR/NCwzPhneE9uNuK+SgGKm6Tv4xrkZ6IgE//qoESBDdwZbosYECQLrOmSY/C6Wrx4pVLb7IiC8vjE1c7Cvh05HQCpqNZ1sclRgD/OthKyxYZseWbH/Lg2K4CnDzeP3Pt9+yh7FkSOSm476Lxfy3LQsUuL7ONU3pZnY+77rJ450GY9yRlyjvDtC6lil7xb3bKkvf9fDGnupTyBwgKMgicQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d072ce58-0663-4a16-f9fa-08de7e4d9293
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 02:34:37.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEWC1N5lOjvMBtqg0ClrPCE7Q+HYmfOZcl4dOzxTvc8BNlVCoc+Sn/oZVmdjmf7C3uUqsv1U2g02x8zJV1qbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 06:35:10AM -0800, Chao Gao wrote:
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index cb2219302dfc..ffadbf64d0c1 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -103,6 +103,11 @@ int tdx_enable(void);
>  const char *tdx_dump_mce_info(struct mce *m);
>  const struct tdx_sys_info *tdx_get_sysinfo(void);
>  
> +static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
> +{
> +	return false; /* To be enabled when kernel is ready */
> +}
Nit: Tail comments are not preferred.
