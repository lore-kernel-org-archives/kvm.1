Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31B3955FF;
	Thu, 24 Sep 2026 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228200; cv=fail; b=reJAm80seQFkBVjURRkKXXwKm6M0n7HThF3t+Jzw09lqmgI60MpMdP0Uw6LXsSr/HJEZGC4sdPe0r3RcxYp5dXtt4U5PiC4XNDuzyQ2CtHHSZl+dkAq2vbvVXq2vS5hboklfcPctc09hrCnuEV9CEFZ3/MUbBVKFh98tkFBl3L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228200; c=relaxed/simple;
	bh=fPv3k6p2ef0GppcOU1FFw7oDtmabALCG+5NUMGxibJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZY9CQey+0Uc30WiI/cXd6zKb0KOwV96sZFlhq6uM0nVMQnTY91wh04uy+RtPujQkJXC74BEFW7+bvrEfs981uwMoXicPM1CxwfOrHm/5mswwKg8A5Fbx0KPU3hXcW2rj1fKbK3AX9ZWpLg72pKG9RD4KD6vJNi3k8xdhWo/ZkRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nv9GSLrk; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nv9GSLrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790228199; x=1821764199;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fPv3k6p2ef0GppcOU1FFw7oDtmabALCG+5NUMGxibJI=;
  b=nv9GSLrkBgS0PNkAUnIS2IDwIKH5v0Ych/vdvxjDOiqJ0AVe3Up0fsKu
   v7IfIqDOeVL1g6stfUY2fBVnrnXRy0ZjukjUmabHwtTbUb/caglpi+6vD
   HgMFSFZCuGKeZsVcy0Q5MtCxV5RX3gAf5suFoOlkoLTHEz5aPJEunNUBC
   vXASoXBFesjTCbYAd8Sddwy17UiH1EJDjKQ4ZuNiQxqc34hDS22xZc5fX
   8SAsqpUyebLebID0Lq4Jcv859dvcudrpMFxFaW9rvXTmgnz6Y2tJKTcq5
   lHo3Lgfre5pkzYeloV3LRlgLUbb85xm/EvoBZTBgQQ7FrP+CgSsHI9rIO
   Q==;
X-CSE-ConnectionGUID: XxqF/MRpT+uQv91eY7ohPg==
X-CSE-MsgGUID: AwWNXfpORZ2RiFsE6bVVsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89761184"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89761184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:36:37 -0700
X-CSE-ConnectionGUID: UOqMajaMQHGzmuYTXpbRcw==
X-CSE-MsgGUID: PHbqJL90T3y0YbDi09IL5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="301866671"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:36:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:36:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 22:36:36 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:36:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQAV7RDjpPrqrFECE8o75ijZimm0gFhXz5Z6sHAS2E6ce5ZGfHbSMKtep1BhvIzmxyT8ldGDMwYibTOce5agD0cDrZQP98C4DsFReMgJyXFrW12vvwOc0+ag2jXehF1DZooymmpj/TAn+Y+24Z/EAFdDPqlm3iMWVpYnQTeRUn8fdR8UXaKQfDnf3OxHFXRll/6PKQleExYZ8dsbQdbSqQpDHWLi9agnCoRoIK1C1q5cpZugX+4+4KpQAqR7BAvGpwU4rxGQe4FRIoiTyWcop1If+9wrmJvbyHPomopij4hOr98jFJge8kc/jauKTw2g2Yg2/FVRcUUQKm4+stmwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bb9XcUPf0TLMINZA99RW78whINUc8lus0Ihwm7/26w=;
 b=WbCmAW+7Frh1F4wL1j3JJ3NQoEKFEGliecNHPQU4gqD6Rz6B1VB7vfW06eZ2udlVTCOUJb1eVORHHQHy5OPTSLRfAO2YNz4LrtR7sqcNxMYUiSiziFpsuVM8CVTmr1oGdYF/4RAC+6SEXRr+JCGCwW+L1/twrY8UsUnqhJhA5yY+53pXQZy1u4HcHvHz5idgXO9XU9oa86//71tkTJHG25QW1SEDOdgF2iVfBSWU/zz7cUiaQ55LeST5Dl5x51F55UIkmq9IhY4wZ+rEjgaoRZtzEsLzHqSkhNyHFRjf1qEhtEBY4qaqaKVxyA3I2mSd4RlRjb5gxG0GQz+icaU3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 05:36:34 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 05:36:34 +0000
Date: Thu, 24 Sep 2026 13:36:25 +0800
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
Subject: Re: [RFC PATCH v2 01/10] x86/virt/tdx: Add a helper to read a table
 of metadata fields
Message-ID: <arS22QlRhb3nLUzm@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <20260918132946.76533-2-chao.gao@intel.com>
 <073407d07707e1fd083f238674560c5b7eb1c4c6.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <073407d07707e1fd083f238674560c5b7eb1c4c6.camel@intel.com>
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 72941fd0-ecd9-47bf-8ec2-08df19fdcb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mkvfgIR/aOeTZewzMhOc+dmY20pJoWyqSFNK9FOJ9haOxotOm5XEZlIL8J8E3nAVxzsYZ0XwnRE8WgzwoCNIORt3BpsR0F0GKQFbfbXMr9sWsKUOwMzQ+kW2dQgHLE+QP+lFjUw3spAXpl3DYdN8OBIro7x51FDRWTb8NJEIW7taYCOFHdIKYT88sSheVCjhjlFzuy8vndEWZKZWS2mxKeasezBKUzYc/u/KD/XVLa4ysLN8To7YAPkZpHnUmirohWlrPLti+YgnuRS650RZ9UheZIn890Y/FSrnbbmQH3ZlFVeMf76A9fLnWDAQvahfRCDBGXfHsWQWUln51MtTkNvtJp4n1RtGTLgAF5sf/oDSdaz7O6TUxBUTXb47mWhp5D5iqVq9+dD3YzRcd0du5gAUQT76hBJGZUZep4Wbb1bnNYw/6nKO/kocoTMiMjw9VfMWnBC1nUQzliGTirHcSJ/OdvdKagPSxnng8gigWerkKpYnPKjkY3LZZOWrtwYvJcwvjboz0QVM67MoV2/116ayGB6xNfuWcnKsFsNnO+t4ScKJJUzlIOxHyZBGI8vV+uhWQidb6T2exMJanBKuDQ08psIbnUnakUO0lBddn1TFvpzTO9uKUh2aPW3dJEsXLpvkJo530tSU31/C3jLnHHez+HkWDg//ndbE5+of6pA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhglcfs89AUYvKhqgBRTCPJ3Z164TBpcKKLUR3AwAgr/PK8MBT1M33eP2/Wj?=
 =?us-ascii?Q?J7J1HhdJWce/2zNWXeAqsY6LJjag8iIBlWKs0nj3lJfZtu6c3TVVFkvQeoeh?=
 =?us-ascii?Q?GKaAO/3LD1ITomHpqc+aVPNK/BnCc94qAYnc0oULJs59KuMoySJT8HqaBawl?=
 =?us-ascii?Q?7ig5oEoAQkvTRF7rM7afVxexQMKjUXWpVWZPp5XSttQ5qYnSUwl56e9egsMz?=
 =?us-ascii?Q?oOydCHTOk544lVQwxYzlgI4fuf2APKdso+ES5YLvOyCtIZIm+kLEJAw6HpQl?=
 =?us-ascii?Q?EbvhZh46ubJBlL3FqhDSk8Cj0CT5DBH2M6uVdamHkeZGcqLvlGb67d1ggyk4?=
 =?us-ascii?Q?aj+nlDgrALiLqYs0omU6Tc9PUENueTMSUjG7ojtU7+eS1n2FHU6QBY8LfqAY?=
 =?us-ascii?Q?Sbkl/Ki+E0/idrBYuDGRqVzU9vch3g00DrZ0g6jtWxVnsGAktHGKS+45z8f8?=
 =?us-ascii?Q?BkzRIxwBnUcqL/WZJWdiVihgqIFLCcFq9VOLUHqLK71CLv0WeywFc/McawTM?=
 =?us-ascii?Q?ug9q+X/NRB6ykqQSL+0UkS52lV1ghZxlkM3/WWZH+vtK4gLyyaC0cAxD7TBy?=
 =?us-ascii?Q?Sh0M8alcZC7c9YzcKhAhAJw5OfbnqYb6b7oI63thxgF/6tWSkmQ3CsPv0Ltb?=
 =?us-ascii?Q?4dS1Apo4m6Wx61F4tocBEJ8K0RbAuoizBJzHWCPBXJ2MT0KfX/DTTXg/dMKX?=
 =?us-ascii?Q?v56rc2Tj3C4cW4+uUn15juBIAub0VbTXesiRyaDUWxU+XDtxLV5IcuBhlNHv?=
 =?us-ascii?Q?1VKDD/sia5W0X1ZnmojoChS3K+WfOC0vwBeFtBHYHZkOURrW6viOtaPhmgNk?=
 =?us-ascii?Q?PUgCYK7plZIicOF5UgNh5fiU61AMt2iz2wzFJi+DhbPazIhVY2cA7RcOYaqG?=
 =?us-ascii?Q?TC/qCkuuAZKFxagypkcV8VjxnPUHtxMqLQDqyG7++5r/uF4lnbwtg1Xux8Kq?=
 =?us-ascii?Q?YYM1h2ScaDA6jEYursDhW1UY0Hx2UfLoYqZpna9TCHe8pc54JP5Ny3BXU2gf?=
 =?us-ascii?Q?97FDfl+xD5iInFZ+ICgPHyZ4RTE8BOP4eD1kfPNaJ4f71mKVPtWoNmjmKp9S?=
 =?us-ascii?Q?4N5zLxCjysRZdgfuhXbhBJfz4JRyyElhyQtuqplnA1mYZaRmyuriBNG3hxlA?=
 =?us-ascii?Q?ARDr7z4hChXiM7ooIjr+7JIdTMA00fyimoBpXOhXOyOSL2bK6MpmVMtUvXWf?=
 =?us-ascii?Q?Ru5NDN+vT3nlFEb9SG/EafLVHAKBenc/VuOdB93s5htfcTlbYqI2JKNiUJxt?=
 =?us-ascii?Q?ifOlKNz07xkA3s/K2J03BXBpUB3M7OWpDo4VUrM5GeMcbOvmlqT8YFClk/HH?=
 =?us-ascii?Q?f/oSpzh7zYkC5wPKn9joWOWZpbM6SFVUH0cUAhWa5j355DH5HdpkdHDnq2OV?=
 =?us-ascii?Q?QWDODCUnvucVUW+8/9SD7l+CqasTByZCNY8C4lHYJK9YQpFHeLuAnW5qaqst?=
 =?us-ascii?Q?HmywzWHk/9BxtuOZdmALyZ7kA+1bvr23PNWMB687bE+7gpKigW6CN4Y/gVp7?=
 =?us-ascii?Q?/Cgf3wmRDvxnK6/ezNR+WmbMiA6JN1R6/UmkfljmGoss382KXxfcpmwnMGYl?=
 =?us-ascii?Q?x7qMPbCKVtg/YsNnM+1E2SVIraGUrU1EvNGBtJlge+zrrjA9oFIMe1rRWj1w?=
 =?us-ascii?Q?eRfdFgkJpbWHOPi0bMjEr9fWodP6fOqSSTKwxAcgr71tqes4Fi5mM+wz2KPz?=
 =?us-ascii?Q?BrryB84IAxZz9rry4RMAnBxVfMB1rcDdGnV7fSPTMmfvjduD+vs5Iy+ABk+D?=
 =?us-ascii?Q?1ocXC3x+Bw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4um0oXH7o5j+r9Gl8UyDqqXvCc8ywZkxUjdINfizenDMPzK69pjNkcqrQs6ktx/ifVGG6GiA6BAYTkEoDKToPQdj1jXxYF77EVYZtZaG6FtNeiHvphP5Oat3QVOfGhX+pjFrDK95Psw1Eq9jZ4WWaze8BEr/A96RHnSB98LspUr+yCZu4krt+xRJl/lEwmGja5VPIM6XLp1r8A/jDeszQA0gC778pCkxT5jaI6yXgSxbV21uzUaeRILJddcvbduU9B76syv4Ktj0/Y6A7vP27VlK2bKUCS8neIqyh0EE5eYicJNzNQuVNbFB6snsPkuofX6GpO+ZT6uaNlPpZyVmdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72941fd0-ecd9-47bf-8ec2-08df19fdcb8c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:36:34.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMzPGJyJMDq4igpoV9+IiwUAEWJfvlON39XmmA7d4waWl02eOhvOj+HL85hMDw2kPpvfeKBlaHaStWkf0bXphA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

On Thu, Sep 24, 2026 at 06:20:09AM +0800, Edgecombe, Rick P wrote:
>On Fri, 2026-09-18 at 06:29 -0700, Chao Gao wrote:
>> The metadata field readers get_tdx_sys_info_<class>() in
>> tdx_global_metadata.c were generated by an out-of-tree script. That has
>> not worked out: the JSON file they were generated from is neither stable
>> nor authoritative enough [1].  The goal now is to maintain the readers by
>> hand and to establish one standard way of adding a metadata field.
>> 
>> Take get_tdx_sys_info_version() as an example:
>> 
>>       if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
>>               sysinfo_version->minor_version = val;
>>       if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
>>               sysinfo_version->major_version = val;
>>       if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
>>               sysinfo_version->update_version = val;
>> 
>> Two patterns stand out: the read-check-store sequence repeats once per
>> field, and the error of each read is chained into the reads that follow.
>> Neither is common in hand-written code.
>> 
>> Eliminate both with a loop that reads each field, stores the value into
>> its structure member, and returns on the first error.
>
>"Prepare to eliminate both..."?

Yes, that makes sense since this patch doesn't convert any readers.

>> +#define TDX_SYSINFO_MAP(_field, _type, _member)			\
>> +{								\
>> +	.field_id	= TDX_MD_FIELD_ID_##_field,		\
>
>I find it a bit hard to search the code when it constructs the
>"TDX_MD_FIELD_ID_" part of the define inside the macro. And since they are all
>named "TDX_MD_FIELD_ID_FOO" it seems a bit verbose and repetitive. Can we have a
>smaller pattern such that we can use the exact macro name in TDX_SYSINFO_MAP()?
>Maybe like this:
>
>#define TDX_FIELD_MODULE_HV 0x8900000100000000ULL
>
>static const struct field_mapping handoff_mappings[] = {
>	TDX_SYSINFO_MAP_HANDOFF(TDX_FIELD_MODULE_HV, module_hv),
>};

Looks good. Being greppable is a good property. Will do in v3.
