Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2F3E5EFA;
	Thu, 24 Sep 2026 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235353; cv=fail; b=dKIAxDAh11RXxi7eT+Zh8BBBb4tqhQbPMv/u0HPWpb/J2jjQ+L4AXW2Dj/K+MTiUjeZXVrtDJPFBmwpI0He7R6993lXYqNWASLfwv6ht3x21GLm18BOUTREfPsL9pRsMaFi6bkPEUTy8bpd4Pbc0Wy3fxm0Ks9FATfGu/lTtP+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235353; c=relaxed/simple;
	bh=COCEznq71D4clzISi1HX5TBZ37Ub3HCkYjaGfzDhnN0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eovm7J27YcxQN7WjujCXF9jsPUQqLS3Iy/7r7IkATKHZ1SlOIwWqsWfrYbOuSrAR352sY/2Xq8jvG6QyrDIEF3LMW8UXxY3epEd6QfLhjlwWQCsKCYRbDFZHzPisEhNziC9LAOkfkJOq9/hMj0tdc34LANty3O02fsWknafIfnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPxl3kbs; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPxl3kbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790235351; x=1821771351;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=COCEznq71D4clzISi1HX5TBZ37Ub3HCkYjaGfzDhnN0=;
  b=FPxl3kbs//WQyrGPer9+nX+Rt2BJahofy6Pk3HrLrFbMqwWTNC7kPf73
   IXphGy4A+oJX24nGaLLsmlPzZXBtUVN6iJ7sPVwp/97wCahSsCs4y82rr
   aRxwrVl1PR2VJw+Z5INJ+v03KFo/d7KlkbGTXj6DQOEHHbeHtz3nCbUZA
   jwDpxI4BialMXJNi0nSsqR4QFLIlVR2ilZ9FZapsTfgbBHQLw4M4dtjF8
   Nrp934fUtBqo+VFEcx3UoVdx7A3I3FtSl5KiQvy9Z1pEQRsSKmpHhXrsw
   AIRlfplcnNYnDt9Z3H54f3hgNJcKjT8g9zzW61J7JuslPHXJPwN7Ya/93
   Q==;
X-CSE-ConnectionGUID: PH5rUr58Tn+I8+jA1Cs1LQ==
X-CSE-MsgGUID: FCSLqUk6TiC3T68lADP/rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101170244"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101170244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:35:50 -0700
X-CSE-ConnectionGUID: +SNSmwU8SmStRKn7Nl+Aww==
X-CSE-MsgGUID: YXWrTcZiRjmzQrU3VdmY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="300214681"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:35:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:35:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 00:35:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoE9FY3EBP76Oyrxk/hTyDQZxBfwb1qMKMVEkvHHeANrOyEHYMhDGcU38nsqb6LaTjZQ/ZqtiHdRVhqmEsMf9NjLJOR82Dk5Zmf4PR29nQKTphuijHJJeJCeUqAs9EQS/pT0uUcxQCOgvWpAAzFsU/ZJDIWrLLX4vH4lEkajON8GX6vOYpBHaotzyxbeu3b/ftNqBPe2ig3VI3Zfud6UxVnOiaP9nL7RaAEnnqO/iG6ONMSPeSlDsjqdSPhWaIbcddUFc2YtDMD6M3Rtb4EtfVrsRoPIBPyIXt47GBVdwXrLK71EWLP8NcZ2EyFOo/4dwhPq9ENzXDN3Unjxi7E2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV31gxYponSeK5VjSE0w0bmwiN8lGClF9geHB/dzlr8=;
 b=tQ/tZovrtgmJL5g6z8iltXTaxnWLE6mKy3cLiEmp2rHH2oQPrOOCm2Qz8jp1ByTDYgLC3ggHEU85kt9UDgDf2hWwZqYQCCrl0GeuWes80/nqlPPhssxKVnZ45pSdfl9gvakJK7GPJzp0qj9eXbocmmP7+sip8mwnHUgKWDL8y0gSP8AQYN2NBodv7Fb03RkRImWXWizfPohd8+7INKujBnaAW0agYHy/Z+ZEVy2fRW1HjZlqMvOtuAKE5IDKEHW7H4btCoUwwkHOeFfmQchdq7jeFIHHKESw03H5GrufKs/2ED9EJASepnnMPex+AFif86k6Sh+1TMLOanFqJIJ76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:20:46 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:20:45 +0000
Date: Thu, 24 Sep 2026 15:20:35 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Message-ID: <arTPQwQunIwfHfN1@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <20260918132946.76533-11-chao.gao@intel.com>
 <afe70eaadc0906ec17e6b5522881ae09e9f45579.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afe70eaadc0906ec17e6b5522881ae09e9f45579.camel@intel.com>
X-ClientProxiedBy: TY6P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::17) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ2PR11MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9e5a0b-f7eb-43b8-1ac9-08df1a0c5961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|5023799004|3023799007|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: +u96vZYKCc86ebRGhpVTlrk+4falyRbSNgBdJ3UF5jc4I0bEuEPCuoB+pmjsN9ISyMX61SSiBUxz/TMJLySM+1jN/wkEZt6OEJDZ5h2gQAtMUYzAG2mpxSUn0TuzkauCBCR5bJ+o0k0PEGqhhJCSfe7rElIebKAxWZUtCpxKMqNOnI6yQTyojTlyFlr5raywG6FOTygxV8BiQGMiwVsGWaZ9u061EMh1bEEVppkfDcOMVNEhVEoCCtXTW6f+GUQ/4Vt+EV9R0iHlkd6teJ5Fg8/hDtGA6BWpwOFDcvTsxFT3ZqbQdnhmHt1Km6j/HzoYdPFRrr01A7IunKh9PtDyKmTUzfD5ORfL3W+YyjzfchFoPChwM4XDhrXIDGOCc1RyRtnH/rcYCnmxu/1hBCn20Y4ncL2iELfbjrCggChFlGTT5Uarf9E3sI7sMUde2IJccKkYi34GvekB9pjuWS5k9O4HW4TlMfmarWKiqd/biIpYWmkX8NQPC5wxA6cLUfbr5y46InqDisotURAJz52ar4EIdYhO/9E+6EpG4AQKe9Y+ISYeSVhShO+w0qo3A7xrYDWJlHbFRxptOrtCgRkoPkNt6NG7hkSMH6SkPCumX+JtnKaqocaup4maKOQdlK854iO3OUr09M7Xspo/p/x/hm0VGJ+fVYuyjOZc4IujrU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(5023799004)(3023799007)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LsqL8bPAGSzXMO1ukOvkQly+Xgx0zFYBFZ09vI2rJD3LR4ZfL3OExD+D4dW?=
 =?us-ascii?Q?MPf9FPmLVK4/KgiVKPBkx+gbHM04FHebAnhHzM3ZyG49FRCIQUUS6DwEIAYl?=
 =?us-ascii?Q?PAN5pqOv+0PPGIJVckpZqLFZXwcq+pJEMG/u/4a7zsKA+9Duz/dKQ4ng7iEw?=
 =?us-ascii?Q?UT/SUonkkAjQefAFrm0KQYaZ9zfEk1yks3mNilxZOO1ZthbxzWyA9reNd7G4?=
 =?us-ascii?Q?paxQImRh+hlgL4EaiHO0KLi/FtJTS0jIxC5TagrMknabg3lwyzcOvY0dk0iA?=
 =?us-ascii?Q?gXlUr0W2eowLOKDZ/bXJFIIM942utB9IG7yMThCjKTV6EDCbllZqUqx5Q2J0?=
 =?us-ascii?Q?INbZDZqZjBJK+MGd85kOMju7HxwA/Kw5s6B5kZeykox9KFLjxm3JbciY96o5?=
 =?us-ascii?Q?tTLW8KGXO7HV0DrNnzhWMpMaNvK1O3nuwj9zEKv3y9cQRGy+btuZhpiPMZVs?=
 =?us-ascii?Q?sFLYSn3DSPhPXwcNBwU8kqcmUqkLi+shkictp07gGpCsKuE00CLXtcLeHnah?=
 =?us-ascii?Q?Ze+4KOolIqlx5IZ3CBLVXdF9SFVflywX0hpN+cL28bnvgTPGxPgtelKJNgIS?=
 =?us-ascii?Q?z4B7/D2wB9uHb4W+CqlTTBvt20fYlFkrH2Oof/xWMpt7xmiqsq7lXdvGjufK?=
 =?us-ascii?Q?eGu+SHtBpPKUdkCP1Wb52ZLkVpSHdnMPCkC3NKwCKpN3N48GkddOjXEdK2ms?=
 =?us-ascii?Q?NAgyKrOTvdWhCZ0T0Zds49QHQf5WgVfL0nVDDGxwGN/4LMJuu26L8MLX+7rd?=
 =?us-ascii?Q?NGoVvctC6yr35Gr70pSIKavWqTjQcwD1fPy+hYVDwFdGnCSb23wfDlLqJNub?=
 =?us-ascii?Q?MdpiRobtlZZE7ysyFObUB/dv7JWwy99AO6KYlXlXryduE41SoE2akFMcqALo?=
 =?us-ascii?Q?uyWLMndgIfi8kx5EBuhIBEYEdbcFg8AVeknwmBuA310/E1Pr9mtMlhSIjXj6?=
 =?us-ascii?Q?BIjkP5EVO3pZT0IWK8OqC7YKdFdGmOmPZBPleQrkDYiFhMOZhkD7hPyrtwT7?=
 =?us-ascii?Q?vO1e+NFYKYr4k77SspYWFN/Jn0+rxvdNesF6ZabX1gq3ivHSxicWzl4uNczn?=
 =?us-ascii?Q?NLg4MthT0I/u+Br/BFVwZXsQJqVf8f3KrWee5wOyj8gmH5573p9M3/Us/y2e?=
 =?us-ascii?Q?DnJ4tmLAq+QGjW4p3FUY0d7bsPtzyVrfytXjevOjNb2vcDgaUmfXdF6gUjrP?=
 =?us-ascii?Q?xYjucqEXDNjhm6VaBgnEpBPoYMpi1cgnsBXIDmKuya0ngtYugeiJz9MK5C0p?=
 =?us-ascii?Q?1ChWC8MfUGvXNVafrHQM1IhsP+lQuU6/HaWpsp+Z74WOImiBj0Ksz80cHuC7?=
 =?us-ascii?Q?S7drjR+FPChxukyCOwKkY8gv5KgJ4jPjNhXgWS4b8MMKNGThcfqAvnVcixYH?=
 =?us-ascii?Q?RTuw0EKD5DomgTAVVdSMXbzG91wkNfoISgcVwjMmIfHP9FHPLfXoXc4h93RJ?=
 =?us-ascii?Q?QTjoJVB0kv9dzamXW8g0tsCCOAtZZbjVRWOFUGOYJ1fUrIUwHrf8FUeEuBGv?=
 =?us-ascii?Q?InxDctfX1IgtWRdf8h02m7lxGLq/pbn3OO9ZcxboH4VA1GVAaCCDEjG6QWer?=
 =?us-ascii?Q?bpBDw6LDfzUpgwwv8AbEoKI+oGPXauwRJ2Ax1ZbXGdzhu4oWMxth2SqU9/2f?=
 =?us-ascii?Q?N7idadO3UJXFrnZT6sH1ytagET5bvcjCJ3jvmC93M/8wlVUfgYlVjP7VL5QF?=
 =?us-ascii?Q?y4mNYgIbROVFLoPnxDFOh3nzBxsr+QN5VbSCYSnGJ3j+OlbHBSkn315kM8aw?=
 =?us-ascii?Q?Amj3YBvqpA=3D=3D?=
X-Exchange-RoutingPolicyChecked: PPTcAHifid9zWcLl6N8OtDauz4CivDOvu55Jj2isLhs240MOo+BLu6v4ebTvMohbdLHr5qY1+ZJTlWDKt4sbqP7Hb9tipdshyy/069Nv3+Og5R99ibTFGCGAekD/xSU/Pg43xXSgFxYu2hJ5xPNs3bY1vh+0mOtVq6nY3VbKZOvoC4/ZoJgGlmZ/HTDB5MnsjMoKMxvJ3kyv/2wwmlAlDn+pPy6NsJAYkNM/J3kkwXYjnvlbZOJljdMdxPv7wQTQfbTfAgmqPcq8dg+MMCuUWoZsKKPryu4FsqNhqRNlP5E+7pHGH7W6wzsHEJ7lL/qNOUilX91w6RD2AtpVxd8opQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9e5a0b-f7eb-43b8-1ac9-08df1a0c5961
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:20:45.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KTue71uCtm12ZIcmaGAG5H1+/nbkR1junKoS6Wdgp9lWjislOPo96xHYncyPztS2ydmhauMrhcYZ9yelbaoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-OriginatorOrg: intel.com

On Thu, Sep 24, 2026 at 06:47:19AM +0800, Edgecombe, Rick P wrote:
>On Fri, 2026-09-18 at 06:29 -0700, Chao Gao wrote:
>> A metadata field ID encodes the size of a single element. TDX_SYSINFO_MAP()
>> instead derives the copy size from the destination member, and nothing
>> verifies that the two sizes agree.
>> 
>> A wrongly typed member is a kernel bug: declaring a u32 for an 8-byte
>> metadata field would silently store only its low 4 bytes.
>> 
>> Add macros to extract the element size encoded in a field ID and verify it
>> against the destination member size at build time.
>
>The two things we could do are extract the field code and check it, or add it
>into the field automatically from the struct size. In the later case the field
>id's would be specified without the size bits already filled in. But since the
>metadata docs have the field code already embedded when they are listed in the
>docs, that is the most natural and easy thing to add to the field id code. It
>makes it easy to search the docs too. So the checking design gives us some extra
>safety, make it easier to add the code and search the docs.

I'll explain in the changelog why we extract the size from the field ID
and check it, rather than building the field ID from the member size.

>
>I think probably you need to explain a bit more about what and why the fieldid
>size bits exist, but I agree with the design.

Sure. I will add:

  TDH.SYS.RD returns every field's value as a u64, but metadata fields
  aren't all 64 bits wide. A field ID encodes the size of one field
  (bits 33:32), so the ID alone gives the field's width.

As for why the size bits exist at all, from the TDX module source it
looks like the module itself uses them: it stores array fields packed
in memory and uses the size to locate each element (offset = index * size).
The kernel doesn't need them except for the size check in this patch.

>
>> +/*
>> + * Sub-field definitions of TDX global metadata field IDs.
>> + *
>> + * See "Metadata Field Identifier" in the Intel TDX Module ABI
>> + * Specification.
>> + *
>> + *  - Bit 33:32: ELEMENT_SIZE_CODE -- log2 of a single metadata
>> + *                                    element's size in bytes
>> + */
>> +#define TDX_MD_FIELD_ELE_SIZE_CODE(field_id)	\
>> +	(((field_id) & GENMASK_ULL(33, 32)) >> 32)
>> +
>> +#define TDX_MD_FIELD_ELE_SIZE(field_id)	\
>> +	(1 << TDX_MD_FIELD_ELE_SIZE_CODE(field_id))
>> +
>
>I'd think these could be squashed together since only TDX_MD_FIELD_ELE_SIZE gets
>used anywhere else.

Sure. Will do.
