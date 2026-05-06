Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F22D0C79;
	Wed,  6 May 2026 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034973; cv=fail; b=pl16JnMD9IND48Kaa/taHQdvoynMZCWI88OndEcfJbMXEJY9ZjFLgIOPfIWRI+mOKtNMaiDFCmyCYXNCTsiJOgfr3cUC5JCd3TPFMpnrGSVN43OuoJzKEHFDwoHR8empsQRVkUBNlcsf1duBIDqQp1Ho8RzERIn8CuRUOFaac2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034973; c=relaxed/simple;
	bh=A1GEGC1PNRAi4AgT1sysgzsYu1fp1rjw7yZ5r0O3r3E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W0s9grRTUbYySJTTjv4FLMnn7i0g1iGWuRzfNIbliMhOZ2oYASM4Z1cf9VorRihp+unXvcx3+4lsvSUXqbVLmqPuUImPl0oE+Cza7t8cW0B0Djjtnem3oR8sKig2T9fPDEMjRUc6bwMHMfdaxWSzKrIeJN2ssziky+6GNvQt04w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSTQ2dsn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSTQ2dsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778034971; x=1809570971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A1GEGC1PNRAi4AgT1sysgzsYu1fp1rjw7yZ5r0O3r3E=;
  b=XSTQ2dsnP/5mbeMNK3VIUcUOkN43sigc/xhg1YsbX00bNSbeEpL/r1L/
   Kzrh6rDjP/lukbWBF5q/n07awdMGR4XvQahkG64cIvfJQ+gZDK/+9Oj2l
   koalBm4AjUYY/QujBxXVwxeF1bTfFwcmpbKt7yhVzVBwOeR8zy60k/L99
   JMHsaF0GfFqUThl+aMUOSYmXsF7uMVPfQG/JNJFTcTEtGikvSiW5OoLHf
   tqLzCXmLNgrN8X02E6a0YsLlSaX+U/GnKJqYI0gXHakCmp2euxmq/JH0r
   Dha+1YY0q6jCrAfSel1M+q6fTHKBFTej6GOhi2kqk/hTpgiJrTWbsYzYg
   A==;
X-CSE-ConnectionGUID: S6XEtCZsR26JgXKeJ7PE+g==
X-CSE-MsgGUID: DNEthE9hRpOHost2S/0Q+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78913805"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78913805"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 19:36:11 -0700
X-CSE-ConnectionGUID: lccPVzu5S/GuWbCa92HUUQ==
X-CSE-MsgGUID: +aoUMIscRdinfrlN3eYOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="233330841"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 19:36:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:36:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 19:36:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ1IFt5OzXIOg3XHFEkS4VNTO5b/R7DJXFrXNVMLdYMAumkC3B6fVie381/fSAof0Ww3VFfwbOolXEUeptBknN4w9xWbQl9wSq535jMKnQ71mRWBLbpaJ/tqVU9nEOO8SAGMaU2PgZXjTZKyl9F87sKwZktfSsDDeFYK7Ea3Zh4xA8pdvoOqvrOyzM2u+q2cEChHQxmJjm9HckSXXgQXyIcznajFg3Kxfj8YlVbH7xM9F7H3QbRGK28aCmU+AtG150lV0dpoJcoBWCAAreqOxQIkIfqzve/vxOkqeifXMLqQqpHGJti03HQxsu0srVfomVMzvkLQt3ULEWoTaY6Q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RepEsCogFEOIT1V0Qnh8qulO2uxzbxu8Fvp96aK/ND0=;
 b=YIkH+EZQOpA85OerQhsyk9nbPbskWkBqXiCbpnALDrxtDnkT52SBpVe2DB45msGXGmsPk6WtaazZc1jsTwI44cmXrYeJBl2jdwjebsxfBgZFFs8ERACvvkUQ+io1A3olidxEn+4OIO57SEx8TkF+jL+wHoalGCQEe0FypvLo71bS41N/k3CpXgt6byVwO2/BDZIOPQYUy+Y8xhzErf9jW2loXzOtpiaA56eJmfweeJt5K5uD0aZCGY5dGdebuB9MYtvbxvva0wVlU5wbm5MvNFjOo1WN8A3wk+5VtGLCwcPrM+olCUB4+hq7gcIQHZI013xiiiF6+q/ZOD+PSqWMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 02:36:00 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 02:36:00 +0000
Date: Wed, 6 May 2026 10:35:45 +0800
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
Subject: Re: [PATCH v8 07/21] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Message-ID: <afqogYgOL8GkMQG5@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-8-chao.gao@intel.com>
 <06682111-2b63-444e-a431-b8dd0db2b0ab@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <06682111-2b63-444e-a431-b8dd0db2b0ab@intel.com>
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb7a372-7e2e-477e-8c1b-08deab183597
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: v9cT/4g1c6Xa6oZmCkZcVKlnr2KEnf/Ei/vesU3DlBZU9LW0z+awUqEq1TOhES0KrV1UtfbkRdtivHdj0wIvK43dkW14+LGTEVwrx+C8j/7m/V9ht4dCDX9OcYkZc+/fFbk7VYrDqwUSEJvTfvVDuHNeL5WL0pWAPPoraOGVa4ZcOvrkE8N9DyWOzWTW1zaWnjBNk66BtUq7TlXfAwkCEvsDAa13yhEAy+ppFN2Tj73lEgFFcJP1TlPS/tr+fw7/vkxa6GmfKaGESoZbNvcc2M5dXY/ldfHAP82f742CDwAykYex9Ir5+r/Jqv1o+t4OqjxZXh19j+dT/UmJRVftNgkF80MPbpxeQT2N4qNG7M2uiHS6HFVjHOsq+MBCQkGJ3Mj6jT4hn5Ph3rYyxstXGr4DnaifZ4gSxPhFyF0zhVkQFAoHoVGoqBrFyAI2Oek6HNK6vBnr+732UIDM7UgYs2eeXufQEShgwA088/gFZX4aImeF4h95pkytz/uffEuUYhc76QKYp0HpzlTbCWwegrTgU2TAu83XmKQikZXjJdVgI266KJInvSaJyysINj1125xsquhkpH0Bti97esF1DXt8yZi+Tup1c27DYR/S+MZFZXxlGZp2DjhTX8HLOajEy90td95Gp1q1iZ5G/r4/JosgL1xYD8zfJI53Z4DMWbNwUrUw/DcNnXBbS1fSaHOl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiu+BOqSa323aokJ3s0dZSt4zwI7S3jnrnQiqCWpCfUSjHyO9deo0Zdyxzyq?=
 =?us-ascii?Q?2AvrKtjmtvJPe/qI2XIoprn8eKISg8XDSGC7mbyw3q0yLDJ//KBYvYPImBH7?=
 =?us-ascii?Q?oresKA3ppafVdyH57q2UeZUjGULpXhvhPTplveER1g877jx9t8ywMxYrzZbo?=
 =?us-ascii?Q?SyHDaizMryZCbj+oD0NvQr1uB3TPe+sgdVH5ngK7VDJ0oXFXGGpjr12XuNgc?=
 =?us-ascii?Q?vZRHu8soqvXxXYknORfH5Vxczl2NUZhF7l05dE0YM9GN70FrGDEPQ8qYCfqC?=
 =?us-ascii?Q?uJSRu3np56zt5r2vONIDHvZ+zmT4NIchkQL4k57n7x/Q24mbgT3C4GQxM+vQ?=
 =?us-ascii?Q?Fk9A26AbkfuHdJgsqbGXsM5Gj0ujNFybZvqWdYW2Lzuh7766K/Pny1d/M35+?=
 =?us-ascii?Q?robPeYSndHDXpkKbxXEgRnotMsLDbllgVDnDB3Y/ZMxzTywfaXmnJzU+ak2R?=
 =?us-ascii?Q?sMgaivBpN0kq5X9lrhWIZWXrx0Rp6KAcQJqos8fsiV+ap45Si+NDpNd3tXUb?=
 =?us-ascii?Q?mV3shGuYS+Y3vYUtmmGFAKLqTGIf/kMsYWTeTo5bJZ8UESs/YpKlKTO+tzCP?=
 =?us-ascii?Q?fVG8l+y1daAav7oediAcyg5d59tWTFvhhSiuccLYyHNzO6dj8g0kc7hMxLam?=
 =?us-ascii?Q?1G/5Q5DdwTT9yQRSXoBxsTUhKhOe6nPviWwHNyfBi5FzQdCHmffAie4n/gKq?=
 =?us-ascii?Q?LetQW58xNV4vI6mw4kfoLFAtSLUObfwg0nK6imeOjp+QBRL/SdZbsOF8javc?=
 =?us-ascii?Q?Cxm3PxVYG0RbCxH/fWbXSoNML/5TCbZJfcfvyrIm6dENC7r2VMuKc3siMjcE?=
 =?us-ascii?Q?e3ZWaYS1ZP7Gf05hPH3WUdjfkxlZ9QEN4kGClsJ1hzHKEQsi9c9mSrryhWdc?=
 =?us-ascii?Q?KfU8Sb7FrJ83Y6XjfUTtNpPR0jTRGpxgBby5W/SgdIrfIOqG19nx9qrJkae7?=
 =?us-ascii?Q?k56B6qipc5YuvoSvtof32/0Tysf4h9R8IDz/7zPh3jqaeBWBFzTBIU3qMIhN?=
 =?us-ascii?Q?rriVLeWJ1XftkygykGoWDSz4rVqmgAmIEQGqd1Z2P23OmNnlDXvHuto9WH7S?=
 =?us-ascii?Q?ZfXLlgxFzEduMvSgTI5oRDEAcKhAS/Tv10ntNHJyflcIt9n3Qdmin62FYKAs?=
 =?us-ascii?Q?9voCGDCkPRxaU6liygzI4MI2yvKBIiyGdcWp/AuDOVsuNIiW6WPRDY9TlQsJ?=
 =?us-ascii?Q?+BPxU7/yqxQPEqaTklYKDH3mY59ng0M4vmlQ6WMbHRsx6SLb10AGHNz6hr+p?=
 =?us-ascii?Q?OVsgCgtkTjzhuCMuKmq0MIYEQmZFone735yqWEm7V8joKfSvfMCT6jIoJzYo?=
 =?us-ascii?Q?embCdVKGTc/DrmL+iAUJuLGSUNGzS9CArPztGZyt7YikZV8oa38NklESfl3k?=
 =?us-ascii?Q?Qh2NcRX79b9WM6g+BNqA8t4JTpmZlsCkRzMobhM4w+Bp8sMcfi9jgBa7EPg3?=
 =?us-ascii?Q?KHhuH09x+V1t73kVpFEMMbjx6wdtjDsUnBXaIKVoL4k76fTWt0HTaefDQo3k?=
 =?us-ascii?Q?14AWvo7v9+YuHAqk/Qi5rWwQ2qSGSNFPZp6rICRM+8ZM/piOBLqYg5CLSAaP?=
 =?us-ascii?Q?Yy4SrGRa7imrB8Nn5BPX/XZj3sCrfkiCuE4p71D7VVBIiTmAm2FqP/008cv0?=
 =?us-ascii?Q?sDNUuV56y8Y7X2QC9w/Y/haNfS8IO0lYoUe9M1gV1UznkzV/zeLB2/ZCTamP?=
 =?us-ascii?Q?WHiUkI7hYKD7l5FmVcPILUIcpZHLkmtUgi3XycEO430bqrUysGB4CmG18eGk?=
 =?us-ascii?Q?KmLgzreJrQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: N6GxHLzm3bouHQs0Jxse9paVGiNaTd3S+mU7zXZuje4C+Knzkcxtbo/FD+PjciwDdnopg9NPJ69DcAmfmuj3BOMBXNcCPMRULOAtlmkhuywIEliWJmdI7tUSXFoYNZxZzyiHWK8MPWOpeEGVWk7G3o0vHAWf8VmU5JSmTzVEGvvR7t2PyHKVnMX0VDGxHfCjCcXXZzNzuD1sQJtx2plVrNxpiLg1uQdG9VYoJqUpgGOGeZ+nhnfriNTXRduWHqc+rCXUKWgEPmFCh5uhtIvjSd9G/HmNEH5ahewKIhc6AHQfXMcUWGo1DgpzeiPhbLRsOxBefIdrErMBsMjv9eH2gg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb7a372-7e2e-477e-8c1b-08deab183597
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 02:36:00.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhXm4FSSqoCSrh08wPZn4OJ9ZQQMJiT0mru1bvZ0zhhjX9zFFdhpcn/Zi8PMjW6U0zWkjdNm0SuVjHkCKVDDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

On Wed, Apr 29, 2026 at 04:17:10PM -0700, Dave Hansen wrote:
>On 4/27/26 08:28, Chao Gao wrote:
>> Linux kernel supports two primary firmware update mechanisms:
>>   - request_firmware()
>>   - firmware upload (or fw_upload)
>
>All the stuff here is good info, but it was hard to extract the
>implementation information from the background.
>
>I think this would do:
>
>	Select fw_upload for doing TDX module updates. The process of
>	selecting among available update images is complicated and
>	nuanced. Punt the selection policy out to userspace.

Agreed. I'll add that as a TL;DR.

>
>...
>> +static int seamldr_init(struct device *dev)
>> +{
>> +	struct fw_upload *tdx_fwl;
>> +
>> +	if (!can_expose_seamldr())
>> +		return 0;
>
>can_expose_seamldr() has a not great name.
>
>Why not just have naming that says:
>
>	if (supports_runtime_update())
>		...
>
>Why abstract this out to what can or can't be exposed?

Sure, I'll use supports_runtime_update().

I originally used can_expose_seamldr() because I was focused on the
VMCS-clobbering erratum, where SEAMLDR sysfs cannot be exposed to
userspace.
