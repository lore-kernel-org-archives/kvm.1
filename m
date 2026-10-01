Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527EF4A92C4;
	Thu,  1 Oct 2026 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856527; cv=fail; b=aH4Noi6E5rvub4S9gbtfeEYzBUL8lh23A3ahd522k/NACl8ProXO8w4mUhnJURWFYjJjB24iGdbKF2M1GCMGWufocDXMESJ/GT2pF55WG3KUy2oC3Q8Nz0ZrsP4Nd2jaIUcjTQ5jmPUFP7cdEeQrxZ7T2Akif+MzpdPd38Ey4ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856527; c=relaxed/simple;
	bh=lSTxvEDnSf+XU0Tw/S1DnDuDwq5mjehNWsTGiyu1J80=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZzU1lqXQV0Yzo0bQjY75C1GZlXU0Rd/1/mgwDA5Er3h+crDUnYtOYdSiOqHAvqhrzGCb2b1p/BDMs4lvf31npgaL6TDQRrgKZ9l+xuuE68h83tYHRIk9zZhGCf3olLOSmmznLeRyKtm6TScbWXcczOJqcs/LuPhy5T5WA31IkFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9e+D29i; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9e+D29i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790856518; x=1822392518;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lSTxvEDnSf+XU0Tw/S1DnDuDwq5mjehNWsTGiyu1J80=;
  b=G9e+D29iD8s9P210vkWGRvNCQrA/WE6JMp256M1+KYYI0pBtCHXBg+3m
   8z8fuy3ifDyr+anznsGsLDKk6q1FNOTYVkk+9IN6GJE2uwliIgYzGDOOI
   sAewY3Za6Ncb6Z21H1xPZn80GWxmnOQVT2OppRnS5jPQLh6qyCIVy7z02
   nAXKR929seVfc9ujcQREr01MVJGpaGrlFaEAPRwpxMnR/pBYjnn5QQykU
   gHNA4ip/olXnzBF4ArtOE4wcY5Z+cEaRVKn4VLJni9+RxVJxgW1qSkU+d
   ccisqtRMyjT96rgvQuMzD8Mhku2vAnFSG52OEInV+MFpPk9eH3g6yehuh
   w==;
X-CSE-ConnectionGUID: bimmIP1ISHuYL+wz8NgWBA==
X-CSE-MsgGUID: AUjBah7pS8ihU9ExnCGijA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="101771250"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="101771250"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 05:08:34 -0700
X-CSE-ConnectionGUID: yVkQO0/nS0ede9mMGHSo9w==
X-CSE-MsgGUID: uVjWOf4MQmmW4D8kqztxDg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 05:08:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:08:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 05:08:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.24)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:08:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWs8VbyMc58y/azFjUEPzr8J1gp8GixHFl22+7fQvGbT/fE0A2irN909zMu67ukTsUSRi/e+Wl89gvikdfHSLIH1s/gQjX95Q8mdS5sBo1CTjIrMo0MpSq6ZetLONj8S4WyCAfEQgZnPc6StIG/4G8vdt2EVjtm1ROpyevt5e5G21OwBJ8rvjrnjaR/0/n4uJk69NdjJZpHthsNfoGIeTlVCJKkgbozcRj8MNCnea7nWpnEhUnN7iAnGXYgJUOJb8IOiDYbw+WfpomCO0bOX7IvSjDpoibClo/n52EPdSYc0TmJC0DY9ngFOpZ6yPPMKIVdj79nFXZfmZHplfGj4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJoiAO2zk1b4BTrDbiyIPLEnsEclQ4b0iRxtQDwcb0I=;
 b=UH8zfFnlza0KfHJ1NbQatc/lUlXtzUcdi+z34QdcTHqjUadZYdvsn1gAsHyQPnJfTNy6qLZTzx/kqCnKpf0UIoHUKundPBRyjFS5HJj3bD3HvVHYA6h3gTqu2JRKGxhi6QlUzDjXefr0/p065JwXFUeSldyReioWLKEtA5aPAJJ/zVTGvGimYo6KiuDN0IMywCoXghneUox+ks5dhlehm/3lhJtYwtbSjt6ZPaD+TpAvvHs/NIS+td207uNw++FlaEodmI5FZO7Nw385T6NlEEiDmykqFgLk4vJxY8BuL8ZFIrKa/cAKhAZXrJlC4z66EqNIXCxIFln2lwBQskNKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 12:08:29 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 12:08:29 +0000
Date: Thu, 1 Oct 2026 20:08:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
Message-ID: <ar5NMlJ3KYKuC7y2@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-8-chao.gao@intel.com>
 <763dcf982570e0ffcc69a6e1922fd2cc266539aa.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <763dcf982570e0ffcc69a6e1922fd2cc266539aa.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a13f112-095d-40c5-2eb9-08df1fb4b48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KKh+N/G2bEOcdxvJVjmpr/P0CqfCWjWjg4VNSzJ20+/KacwerFCKA147GM69OIefVnXoTS6VWznORBUg2sR2IeAMqugY12YaPjK5MQZyg9nRkI8kHC/cWSMbyFL70seR/fKwtXnCv2RRLbm4TQLasdnmr3KQuL7iVCGjb8zVD76VIOneT/OX2sR00UpN2b/5OJK3Is05e/9XIvkEXZxI8FNuTUrOE/IE8ajqG805DmnjEhei+rBGotjzeS8KQ7g02m5MOdAPk13nrngZBDCEglA3Wr/dy5DyZTxunWVw5+jOckB88G2Wu5EQly42YaH6s5R3f2YnT4hB0e6Mvglc5XSmlYWrB8vGjaWoolg7Wvi4gQz1Bqlt0Q6B2WeZ0KegpV973fLk43KDmKerWCUF4rBDKyVoHOz3Q29dY0wAsiD6sknwgYBYLRjapIDYXJvthpSoq0erDVxVJ/aYIJsctC3EPsZK8hZ1Aay9ng9npaBA4ua9yvfjmdrRMRscPlVOeueXFuIcWLqcGoF1ByDpEZiJax8lYNtmhsdY1ufcT9j3AYh+4vm4+/kGi9gix7Vr4xIlUmZMpMMsj2wx1qiLiEEzNQIiQrC2qwNyntBb/Bx8FTTzKRSVxuwwjWWz6FXkxdvrRhM9WIIZE9d/0SEbyYGX1PHeSlNXpSipSJf0WS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vuO1ZUZqP56pgbrHvqll+4Mpr1FKDd4V60hrPB2/ggULyzmEEpd5r88uOI?=
 =?iso-8859-1?Q?q2sxlRCdaf7AsyXwHddz3vjaq05jlsg6lR/gBNKfxreaN6MO0mVimGXo6W?=
 =?iso-8859-1?Q?wnB6tLukhnb72CNYwo/hM4LjoR0Gnuylz4iRs1onuTQNkxDSBVNiG8X5E8?=
 =?iso-8859-1?Q?DCaQdCXGOPopWt/qf3l9DnzgoCwejzrVKqmOgR/CEY3MwnGwI7XW4n57DE?=
 =?iso-8859-1?Q?V6nKlQtvqqO1yhc1TUKxVKmI168hEUcwhiXoS3J2pnAoVSE040B2Vvo3mL?=
 =?iso-8859-1?Q?vgQZp9b9+3RHAgfIW68oOSk0kJdBGL1iZ7NZ2y2qWw+rSkXEBQ2bJFHi8S?=
 =?iso-8859-1?Q?MdW4ehHXad4FA7SOQnf7jc60MGUi4+odyfFU29b8yKnFFnqXKY4X7vlCY/?=
 =?iso-8859-1?Q?OLYCkCVsqv0wML4fwMYG54v3QzYAoBu8y5q3sDcUMjF2F0LWZ1N2Ft1yxZ?=
 =?iso-8859-1?Q?8xUMvmSil31TovT884WoDGwB7THSH5Uqw1XNmW94rtkJSEVU0PRwMbbuM8?=
 =?iso-8859-1?Q?aRagZ9GpwIhVmEpKqdmjYa5xRCcDWh7iy+628xHmSFa5PyzBdcMDPXiZSl?=
 =?iso-8859-1?Q?ukOU7NRDUrOEdZnKhprI8s4wyUV+qWkJX3JhL19xkh8IpDSooPNw7EurbZ?=
 =?iso-8859-1?Q?6XlUOyn89EpcynxhB/FroBRpVfoBrL+CwlY1bzR53w2LzUzrykC+Wq7Ymb?=
 =?iso-8859-1?Q?2zTPeqszjrqy/Gt1z2IQaDE83mdPcwIOA/j2GuZl62IDCHPo3C1Bi7l0oF?=
 =?iso-8859-1?Q?c+1DD8P/s82z5mDVQdNeA4W22w02Cc4CPwM5nFRz2p4o3bMeOjLkaCuaeq?=
 =?iso-8859-1?Q?7mBoNZmAoQfWZitOsaAc4pjAboWyNEOc0bRj/vTL4qe4HRgGG3aunJvzvd?=
 =?iso-8859-1?Q?kOEoDbmMPcOiL3qQdUOgyITCuaVM0Tub/jWIDyQIeb0UHQvhRoCSnCLsCe?=
 =?iso-8859-1?Q?YDhS1qaL1iEWqSWFt5QCzCLJaCdmtqVc2PIkON9cZL+bfFa2K3oOHom/4d?=
 =?iso-8859-1?Q?KD3cVw/2cQY7Sxdn7E7M57F7uqL2B+/Ju+6GaFR4BLXL5Cl/3tjPPgOcn5?=
 =?iso-8859-1?Q?XUanNbziRByin77AI0V5kJKCMY/WzPMInPBxLogkT9i3hvEO+gcc/THrAL?=
 =?iso-8859-1?Q?g0RBiILN7UmejkvcWyCQZr5VqeHZe4vonIY7P30aXTn8WeyYaXEmvW5ldY?=
 =?iso-8859-1?Q?N9W5LDWRLet3cgl4Mf12MSRexuJMAIfPMMmLZQEFqRdwHsXOi9Y4IP4hJ2?=
 =?iso-8859-1?Q?FL4aF/HnQCakglPdJ0jVQH9HhjgVI4T/J2Gq+j27TqqCjEFBnC8mUuhpXx?=
 =?iso-8859-1?Q?3tpvFt7C7sCroF7yYKOYvxsUvc1N3AhFzRSTS1NfHmGT/lNO+/w6q9Bh/M?=
 =?iso-8859-1?Q?ZUneNigRgmrNL/5pqHFGMzmlEeVXg6olLc29abEPHBfcwa/i2/IwNwXVDZ?=
 =?iso-8859-1?Q?PYxeiATSS8SMUJylsnKw9Otyc2Os0Qw4rgizzVWLD/hd8aMJA4KjhC5Ikm?=
 =?iso-8859-1?Q?9ZAqRBysKDKb8AUVw2X7zpIoj5ifrbkXhpBqjCrPFX329yGCsnr+qL4sIJ?=
 =?iso-8859-1?Q?ZwmMuVGm6ar2HAkSL6TIa+S3u6TNIo0savebcWq2g+j4+NYOGLOaW/PxT6?=
 =?iso-8859-1?Q?mZjKS3A3KmKKdyA60/LAwHc1mfc2GiMosNTT2FdO5+g2NuBsWEfmZoL3+J?=
 =?iso-8859-1?Q?iYtc7JT6HyBRL1feuDW5mhMA3/f4vVguKZxDQ0HfUS7D5+nZd90BTszSfj?=
 =?iso-8859-1?Q?OstykKj4a9DQnkdI1A7AvpB41ByRw6ovu1vcaJzZw9h2hK4qE0bdKYOiEs?=
 =?iso-8859-1?Q?4htiByS+qg=3D=3D?=
X-Exchange-RoutingPolicyChecked: TXAo9cnaFZ0EFM12H4TsVFiSvY3jG6EQurCdUSJXUOgPFhuje1qcmLKR4wb3Io/HvSfEySxYEJ9TqmRm8G70MQjPggrOSapszoc8Rbs25MtohnqDXdXRdWI1XNLK6b1ezscjKJR4KsU4GETCuO/92alJB1Fwnqzcil71SrTdMXcmrtMBz1AUmo/Mj77ZMAIPw+2Kkl25u92ZEacXRjL06ck2Xm0DU/mj6z1I7a+cuQzbMUzSu4NXMwFjHS5aqm8PK4q99cR4SERmSRqOZnSBiFq7JskLd1ygADpUDorKkTtRL6/eRIlmAmNhdSe00w0W9EHQFb7djx0bYivb+CeoNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a13f112-095d-40c5-2eb9-08df1fb4b48b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:08:29.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7BsmNjGCnqrLzIvcIT6juwkUUWDYzyfpFxxaTYSD69P8vgQhxtgJthgb9/hVYcSfVlDqOZqJpz9Jhbx/QlqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 07:54:43AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-09-29 at 22:38 -0700, Chao Gao wrote:
>> +	/*
>> +	 * TDX_FIELD_CPUID_CONFIG_LEAVES and TDX_FIELD_CPUID_CONFIG_VALUES
>> +	 * give the field ID of each array's first element. The remaining
>> +	 * elements follow consecutively, in the order they appear in the
>> +	 * structure.
>> +	 */
>> +	for (i = 0; i < td_conf->num_cpuid_config; i++) {
>> +		ret = read_sys_metadata_field(TDX_FIELD_CPUID_CONFIG_LEAVES + i,
>> +					      &td_conf->cpuid_config_leaves[i]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Each config has two u64s of CPUID values. */
>> +		for (j = 0; j < 2; j++) {
>> +			ret = read_sys_metadata_field(
>> +				TDX_FIELD_CPUID_CONFIG_VALUES + i * 2 + j,
>> +				&td_conf->cpuid_config_values[i][j]);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>
>The comments are not strictly required, but probably fit into turning this thing
>into "hand coding". I think it's a nice addition. I wonder if we should make the
>"i * 2 + j" a bit clearer though?
>

How about:

	/*
	 * cpuid_config_leaves[i] holds a CPUID leaf and sub-leaf number,
	 * and the two u64s of cpuid_config_values[i] mark which bits of
	 * that leaf's EAX/EBX/ECX/EDX the host can set to 0 or 1 for a TD.
	 *
	 * TDX_FIELD_CPUID_CONFIG_LEAVES and TDX_FIELD_CPUID_CONFIG_VALUES
	 * give the field ID of each array's first element, and the rest
	 * follow in order.
	 */
