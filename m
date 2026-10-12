Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30C30D41E;
	Mon, 12 Oct 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797557; cv=fail; b=MMZu5owyW8+qQAy3mFLPc0J5gFi+hjjnSU6uC2zyYnlVn+n64xgwCT10Z/9oV8qEJkftfaOilGIBH9p5+qOXS2tu60+QJLMzNtckASD8VUNEYRauMoeDHsicXkHTIQwHvpzsNDifoZw7oU2p5m4L4Tq4eNCsU7qTU/0BMEUYyfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797557; c=relaxed/simple;
	bh=V00mG1agYrbje6XnGYnMUlgTVkWKN1vDnCSLW6AA/BQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mK/OhUDVWLLiYAUZHHKjlG91/SzaS7266ZlqTT3CbSn/CFspOfpNxGYZGGeYvcc41lowYB2gZAAo8VMRDnkboRZrvf/VyrJYsmq0nVr0WIwzUOW0I4b0j2FwvWY4MANNkJ3yg9w+sImosfWMYxxyQY7SO5pmvnix0+x9QLhB4mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUlyOh0H; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUlyOh0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791797556; x=1823333556;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=V00mG1agYrbje6XnGYnMUlgTVkWKN1vDnCSLW6AA/BQ=;
  b=lUlyOh0HxtdwjDLDnqIJrd4sRG3MqkIZ8pa9bbuyqU7GD/JEVxtTQxSo
   xnt9m4Rt2hxMY334C0Ae1qdqbedo/I3udzTVYQpBXWHK/MnHmMlMr/7BO
   PFMifqYJNCaLU01kaFXoiLw2+t6w4fQIkR8yjPiSwvZoEU1g9F3aHizE5
   1ovHe4InpmEVFRIJ+yqO8dpQ9124cujK0BEGsfRqgm072BnB2alhYOZBg
   3HJgA6PvOiHI8DQAWn4Dp3H4B+Q8f/OU7uy/sqQu4NvEt3vpa90uuuKsi
   Xl3clY8MEF4A7c/ZIHfPtsYBRbeeMzDEH+yv03lxFRH8eUNzdcKuOIKl+
   A==;
X-CSE-ConnectionGUID: zjJVCigKTWmWua73uSmaCQ==
X-CSE-MsgGUID: YI4XxrTIT16KnILsD9pPTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="490922"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="490922"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:32:35 -0700
X-CSE-ConnectionGUID: +ho8gHxGQZCgdJagtsvZzA==
X-CSE-MsgGUID: JosmJva2S1meGd7Wq7Iv3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1155676"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:32:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:32:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 02:32:32 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow7DuiH01SC76mcaccomk85rWF9JadQ3C8cIGbzM2EpyMeNV2uf6VAjA18cVUJiJ/AwGch6+rI6rj8JmS2gpYVYupJTi+GqrYRKA/fv5nrqPdNz2ykVWT7061/XwPLjzUw61shx11NfV9aY207SIJT+8pn6apnPl1CpfqUCD8P3TtC0IeSwFc6EXOKCJJlXWLKfu8oeNXDbuu9sv1gfDpSl/7x9KiGVtsXtEBiT/SwMGr+wRnitqdknW0zhtXGOhpDPV3j8vT5QAVPkMxW1RHSZXvXk4PV2eAEi/xQT5MUOX1a6hKwHIp2Cru3J5zpT/Fl+UBKAwLdvrE05tVgXunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRbF1K3bGsvfpBW2zp8W2XNnDgCHgc/NcyWy7cGaPPE=;
 b=xc4qH34I5m+8GMYUJeII3xGYq2KKE+SZjgb64ZXQ+xCZ3H9JS6lJRusNxJ8zE92985wobAge/trAKvYiew1MOVzR+VMXHduY7U2Iafky1BsPAxpQAcsJXZYZaqK50NBtEzBTpuvtGP8fV697oTtK78u5KoRgk8smMOXY0OdjFApq9iBuq1chN++DtZGtGjTpfGg/QjtahJkc3/egEF+Tdz5piPzC96sYtWiuQFvtZPVDF2o5c2ORvqFFv83VQkncSm/wdaNTP4FFOJIPM5PRxoJVQ6D4FqKHfAsqnWFdeRdIY4hxOejr2LjDSMgirxDxnHnDCxeuG6q5Doq26rx/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 09:32:29 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.019; Mon, 12 Oct 2026
 09:32:29 +0000
Date: Mon, 12 Oct 2026 17:31:36 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Message-ID: <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090831.15502-1-yan.y.zhao@intel.com>
 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::13) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cfa62f-e3bc-427e-caa6-08df2843bbe5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|13003099007|3023799007|261009223027099003|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: jt2jKMupucQYo4h76/yMel78UBHNVjXHGgAGMSb8h9iILTqF289dAdt/cbgRvxxgQItX95xXYXUsWlgEkt2KYdwdygKd1BqQDO+P45o/xFD8oKjQ0HxuhjD9KCkK44DfFSwfDbVj0Sk1RyAr7Eh6wNHKvUKpSLxBtcu7LEQqPsI5bJkUDWEi9p/S5rCbVSYVq+07B873UqqSGupLA8Sn0AklrNTWo+pnZGrEsw0osAhE/gOVzQSqdMSgJSzyi8CtU3Fb1QvtHmLCJFxjwDutMIB6vtU3IXCk2fQdl8aGIARvvQTWISxKTLB+kuV+uymTVJQdHKgrVnF/+kdyWt6NagHC15u6GbUvL7UoB0P2ImQfQ+TZ/xE7d9tz/AMDJPOdWTql1ZIBGuwUPQPfi2d/Frw/1mTgJjyjGYTPCKZvv5NjQyJiL9XbjyX/Q1V1vRu98swxsPcIpgK0Vgw99KE/Q3VnGqnKSo5F3FH20KTFPcWshh2gBZcaNpe4UOZbegAUNafnYWxF3IL4506HuUWzZNCPpySc+94nfkAryBm2zUj5yxJjLn5tVuwbGU1K/dNlo/sPlF3EP7VDS1DsRS9kPBKrMu6bvuPCG/oeKFj0TSZJSFav+IW1KDboE/nLd7lw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(13003099007)(3023799007)(261009223027099003)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dc3WKkrW2liJHCneeoGg4pd4of2i8InQKKrbsKVLLwalbguwthLCkqKdcaBD?=
 =?us-ascii?Q?hvAzN4dFG4AHQFiQgryXDKd1VG/jIwgRqD2XZZ89n+PVejilD+dId8+f+WZB?=
 =?us-ascii?Q?iLcw43ZcOk5oTl/Y9flk3arzHa73Y2GcHORVlVlmU2xGFNUD9ZHWXH1ipU+b?=
 =?us-ascii?Q?pEL6ssvHSyDKlxLuiE47kcovy44rEyLxcevnb+M1+NvEf20o7UDXUnXyH7eq?=
 =?us-ascii?Q?ej1mtFcvbJlVqKwNIsSpMwl95g6aWktdXdGM6svLKNeq5xKOvkga/4Cprwf5?=
 =?us-ascii?Q?hYkFuXW04iWSd0R4D2pXEidLP+g5VWTRkUiH+q1PKmkhZN8uai+Y1Kk3yCVc?=
 =?us-ascii?Q?ZhEz9IZxrStR8v9C64AqZRNnf70PUwZmKx4ShHg71VbaIfaJa+9VaorxlFSD?=
 =?us-ascii?Q?TEo9qlJ6lvnXGI3qbwrnZ2hrlgKmJ+oKY7L1vw/PggdHL6cMQ00smsqQErfG?=
 =?us-ascii?Q?TCD39WZeT4zrLTYAJplrxdY//V/1W7QWUmBmaH9KXXBSMxC/jq+FLuA3O8/u?=
 =?us-ascii?Q?Tml6BQMgOsqX9Dve4hLmj5eI637eXscZGnWiE3khUzRCoYzaKgLbG/u/SWZ5?=
 =?us-ascii?Q?uPsnSiv6M/iZirzzQBczlkyH0CriCho8cbu3d3iXWH6DkPTBVUdzm4NicQEs?=
 =?us-ascii?Q?uOzXtxpV7aDg9kY4UlIy+j8ISj0mVgYROUigoPaxNOXpZBdZfL9kzYfQ0iIU?=
 =?us-ascii?Q?n/RFyPXkfMw8tEmwJyXoTDh3ppiJw8odz+5UgIglaOFL3DGXd1nw8W/zBhgE?=
 =?us-ascii?Q?GKVBD2O1ZhgXE78KRy9ESOAynKW8TZahL7nPujEprxZmQpvN42rV0ptR9UEt?=
 =?us-ascii?Q?tkol8dv6VMOZzF4yaZJ8AWC1Mbg8I2ndFy/d+EnGW9eto+SqvCOcL14q6lWh?=
 =?us-ascii?Q?1+ZJhNuePIznvEmkrz8WvSoaaFwxQl1bF6Ly2y8zQpVXb/YgxauD35udCoZJ?=
 =?us-ascii?Q?nFFVo4WkSZIcKfTucJDG2n3HnmeJ6q2H/MGyqVSlHGrqg9EOJQgXY2l2i3C7?=
 =?us-ascii?Q?hYGnMueHig7cg/PnBZgQC5auw6XdD2BHpJTbzxBdWMXJWjcKRhXQzFYkg3Je?=
 =?us-ascii?Q?U6iTYZia6oNeR9vs63RoijJA2BUgY+9N9UPQYj+yGR//HwKhDedeVAjdOpV7?=
 =?us-ascii?Q?IOAan/1IOQ1qXtpbJdGpaTy44TKhfs10eFlmHxBLcdUg9HOIjO6BGwZLkqQB?=
 =?us-ascii?Q?/SPdgID7EwdPt2mVEMYYDpLSNRXWb/3wgIMn28nkptPlXemUQe/8y7WNoRdl?=
 =?us-ascii?Q?tdxtA1J2uG9c1FyPaq0ctJkeBNJTgT9LI2C3Y0XZuVvmpR/+BIxwpZ5PXyzS?=
 =?us-ascii?Q?RazyHsZda9l9ze1YF26BqYBhTSUDoEFT4pNEJHP0tCHbDtHLEhH9gPiriezg?=
 =?us-ascii?Q?hjeSLgJu/lzaqA7utBO2ScCIR1xh42VHO95eolQdrQb/q3Gk5XaMUEF9JN90?=
 =?us-ascii?Q?6F8LmFlPgEZOawa4jz0I5h06oLXABvUYUlk9ZRoYkyGH9h9XL9f6rkjJ94rX?=
 =?us-ascii?Q?R7Ls0CjQ/c6wfdVidbyYWVr0ohpWLqFqewDTLC0nXSUmrgr+vZF50LdVdOfs?=
 =?us-ascii?Q?l7KhTsMykMg6ViI/VUhnNTmgsYSwP/H98jtWGtgutvFZjd2/Byd4O+7Q5uQY?=
 =?us-ascii?Q?DPKb/HzoIQTc21h1nuGxgAgSsFAeXGIB82MqwJCMNP9W09/3K4mMwCZKZJN5?=
 =?us-ascii?Q?+qYBB7dU3GSU+h4Caj9vpE30eTweorc2HvAm7R8/fuMJGRpFWMh0JfB6RDA/?=
 =?us-ascii?Q?vgozT5pLVQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: L62boLmUpAscSqh9C/VCH/otzzITStTr5rAebDkgspCHyu643JyT04c2jPlpDGmR7TLt82PCOS2MCfNQV2MMoxK8VgZ4MW/CPxioBLnJzPXxNJwZDWMPqN3vEC6RAOZBRiHRLP7HmunQ4P5Uf9iuC128j8opbPhUVvrAXAvDyQ/8l2KNFmyHI2yqMMj6J1stoU8k/mh5rDrudFpAcxT6dcJTnUcFOAunfj6VA7uJYPJuElYqe6O8t6c+pKfWvQwBJbhk5blCfcQ/WdVLdU1a67H+KSWq1lywK+6GFOTeIBpgpdstqriE/0Ht3Z1txzd+0GQ1RMYAw+L1oMI+LMyKog==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cfa62f-e3bc-427e-caa6-08df2843bbe5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:32:29.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmOw1e7SV9ziXGLeir7YCXfGtke8QZjT1jr4V5+MU7DHCvZ/QzgjnQs6rL/m9vRLqXuyKb3ADbrQ5Ll2z+hUcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

On Fri, Oct 02, 2026 at 08:54:11AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:08 +0800, Yan Zhao wrote:
> > tl;dr: Introduce a SEAMCALL wrapper to invoke the TDH_MEM_PAGE_DEMOTE
> > SEAMCALL for splitting a 2MB page mapped in S-EPT, and export it as an API.
> > 
> > The following assumptions are made by this wrapper:
> > 1. The huge page is mapped at 2MB level in the S-EPT before invoking this
> >    wrapper.
> > 2. DPAMT is enabled.
> > 3. The TDX module supports uninterruptible demote.
> > 
> > The only expected error returned from this wrapper is TDX_OPERAND_BUSY.
> > Callers may need to kick vCPUs out of guest mode to avoid this error.
> > Callers must provide a pamt_cache for drawing DPAMT pages for guest memory
> > and ensure that pages can be drawn from the pamt_cache locklessly in this
> > wrapper.
> > Callers must ensure no concurrent invocations of this wrapper on the same
> > GPA.
> > 
> > Long version:
> > 
> > Huge pages offer improved TLB efficiency, faster page walks, better memory
> > contiguity, and reduced page fault and memory overhead (fewer intermediate
> > page table structures, and no 4KB DPAMT pages). However, splitting/demoting
> > a huge page is required in the following cases:
> > - when the guest accepts the private memory at a lower level,
> > - when part of the huge page is converted from private to shared, or
> > 
> > 
> 
> > - when VMM wants to reclaim part of the huge page.
> 
> ^ what exactly is this case? You mean like calling hole punch because VMM
> decided guest is done with that memory?
"Yes, by reclaiming I was referring to operations causing specific folios to be
removed from the gmem inode's filemap cache. e.g., the ones triggering hole
punch.

> > The TDH_MEM_PAGE_DEMOTE SEAMCALL demotes a guest private huge page by
> > locating the corresponding leaf huge S-EPT entry and replacing it with a
> > non-leaf S-EPT entry pointing to a new page table page, which holds the
> > split leaf S-EPT entries. When DPAMT is enabled, upon successfully demoting
> > a 2MB page to 4KB pages, the SEAMCALL performs DPAMT pages installation for
> > the 2MB physical memory range, similar to the DPAMT pages installation
> > performed by the TDH_PHYMEM_PAMT_ADD SEAMCALL.
> > 
> > The wrapper args "gpa", "level" specify the original huge leaf S-EPT entry;
> > "new_sept_pt" specifies the newly added page table page; "pamt_cache"
> > provides a pair of pages to gift to the TDX module as DPAMT pages; "pfn" is
> > used to locate the dpamt_refcount; and the output args "ext_err1" and
> > "ext_err2" allow the caller to retrieve SEAMCALL failure information.
> > 
> > Three assumptions are made by this wrapper (as in "tl;dr").
> > Assumption 1 holds because the VMM can only create mappings up to 2MB level
> > in the S-EPT via the TDH_MEM_PAGE_AUG SEAMCALL. 1GB mappings in the S-EPT
> > are only possible via the TDH_MEM_PAGE_PROMOTE SEAMCALL, which is not yet
> > supported.
> > 
> > Assumptions 1 and 2 together simplify the wrapper implementation by
> > eliminating the need to check whether DPAMT-related handling is required.
> > 
> > Assumption 3 is a tradeoff reached after research and discussion: a TDX
> > module that does not support uninterruptible demote returns the error
> > TDX_INTERRUPTED_RESTARTABLE if any pending host interrupts are detected
> > during the TDH_MEM_PAGE_DEMOTE SEAMCALL. Since the TDX module cannot
> > guarantee a maximum retry count to ensure forward progress of the demotion,
> > interrupt storms could result in a DoS if the host retries endlessly.
> > Disabling interrupts before invoking the TDH_MEM_PAGE_DEMOTE SEAMCALL also
> > does not work, as the TDX module also checks for pending NMIs. Therefore,
> > the tradeoff is to disable huge pages when the TDX module does not support
> > uninterruptible demote. This is acceptable for basic TDX huge page
> > enabling, since the SEAMCALL execution time under uninterruptible demote
> > mode remains reasonable [1][2].
> > 
> > Later patches
> > 
> 
> Don't mention "patches". Instead "changes" because the patch is a temporary
> form.
Thanks. Will update it.

> >  in KVM will enforce theses assumptions by setting the maximum
> > mapping level to 2MB, disallowing page merging, and disabling TDX huge
> > pages if assumption 2 or 3 is not met. This wrapper warns and returns
> > TDX_SW_ERROR if any assumption is violated [6].
> 
> If you call it tdh_mem_page_demote_2mb() as below, the assumption is self
> documenting. No need for handling other input.
Good idea!

Since now the demote() implementation only works when DPAMT is enabled
(due to your previous suggestion to get rid of "if/else" code for DPAMT), is it
necessary to futher rename it to tdh_mem_page_demote_2mb_dpamt_enabled() ?

> > Due to assumptions 1 and 2, the wrapper always performs DPAMT-related
> > handling before and after invoking the core helper __tdh_mem_page_demote():
> > - Draw a pair of pages from pamt_cache and gift them to the TDX module for
> >   DPAMT pages installation. The pamt_cache is a list of pre-allocated pages
> >   provided by the caller. The caller ensures that drawing pages from the
> >   list is contention-free, either by using a per-vCPU thread-local list or
> >   by holding a per-VM lock. If the SEAMCALL fails, the pair of pages is
> >   freed directly rather than being re-inserted into the list, for
> >   simplicity.
> 
> pamt_cache is pretty straightforward. Could be a sentence or two of why.
Got it.

> > - Use the global spinlock dpamt_lock to avoid potential contention between
> >   the TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs [3].
> >   The contention here can be cross-VM, similar to that between
> >   TDH_PHYMEM_PAMT_ADD and TDH_PHYMEM_PAMT_{ADD/REMOVE} [4]. dpamt_lock is
> >   acquired directly without any pre-testing, since a 2MB huge page mapped
> >   at the 2MB level in the S-EPT must have no existing dpamt_refcount before
> >   demotion unless there is a bug. For defensive programming, warn and
> >   return an error if dpamt_refcount is non-zero after acquiring dpamt_lock.
> 
> Im not on board with the reasoning of defensive programming in these. It is not
> enough to say to add something to be defensive. It needs to explain the likely
> or nasty possible bug case, and why nothing else will catch it. And a lot of
> these seem at odds with the existing code. Like demote path gets extra checks
> that regular paths don't have.
Please check the explanation of "defensive programming" below.
 
> > - Set dpamt_refcount to 512 upon successful demotion so that future
> >   invocations of tdx_pamt_put() when removing the split 4KB pages work
> >   correctly.
> > 
> > Note: The new_sept_pt page, which will be added as the S-EPT page table
> >       page upon successful demotion, also requires DPAMT pages installation
> >       before invoking the TDH_MEM_PAGE_DEMOTE SEAMCALL. This wrapper relies
> >       on the caller to invoke tdx_pamt_get() separately for the new_sept_pt
> >       page prior to calling this wrapper.
> 
> Maybe organize it like explaining the two types of memory involved in the
> operation. The private mem and the page tables, and which ones are handled by
> this operation. Rather than putting it in a note. Start with a short description
> of the problem being solved by the why.
Will do.
 
> > Additionally, caller must ensure no concurrent invocations of this wrapper
> > on the same GPA (for example, by holding KVM's write mmu_lock). Otherwise,
> > a second invocation on the same GPA may encounter an incorrect
> > dpamt_refcount or a SEAMCALL error caused by attempting to have the TDX
> > module demote a 4KB page. This not only simplifies the wrapper
> > implementation, but also prevents potential issues in the caller (for
> > example, avoiding a level mismatch between the KVM mirror EPT entry and the
> > corresponding S-EPT entry).
> > 
> > The only expected error returned from this wrapper is TDX_OPERAND_BUSY,
> > caused by potential contention between the TDH_MEM_PAGE_DEMOTE SEAMCALL and
> > TDH_VP_ENTER SEAMALL or guest TDCALLs operating on the S-EPT entry being
> > split, due to lack of lock protection. This error is returned directly to
> > the caller without retrying; the caller may handle it by kicking vCPUs and
> > preventing them from re-entering guest mode to resolve the contention.
> 
> I'd put it that this is pretty much an existing issue, and KVM has the tools to
> handle it already.
Ok. 
 
> > For defensive programming, the wrapper still takes arg "level" (though it's
> > now always expected to be 2MB); a warning is issued before returning any
> > unexpected errors, regardless of whether the caller would issue a similar
> > warning [5][6].
> 
> Or just call it tdh_mem_page_demote_2mb()
With tdh_mem_page_demote_2mb(), are you ok with returning TDX_SW_ERROR due to
level != 2MB?

> In general we should focus on the why here. How it works should be mostly clear
> from the code and comments.
Explanation for "defensive programming":

In our internal review, I originall wrote the code as
    if (!tdx_huge_page_demote_uninterruptible(&tdx_sysinfo) ||
        !tdx_supports_dynamic_pamt(&tdx_sysinfo) || level != PG_LEVEL_2M)
        goto out; // In "out:", *ext_err1/2 are set to 0 and TDX_SW_ERROR is returned.

You commented that
"Hmm, this could all be a warnings I think. I guess it wades into Sean's new
tendency to survive MMU errors. But do we think there is special risk here? What
horrible thing can go wrong? I'd want a justification for why we need to handle
this bug and not just report it via warning.
"
So, in this version, I set *ext_err1/2 to 0 by default and added WARN_ON_ONCE()
to every unexpected error.

> > Link: https://lore.kernel.org/kvm/99f5585d759328db973403be0713f68e492b492a.camel@intel.com [1]
> > Link: https://lore.kernel.org/all/fbf04b09f13bc2ce004ac97ee9c1f2c965f44fdf.camel@intel.com [2]
> > Link: https://lore.kernel.org/kvm/aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com [3]
> > Link: https://lore.kernel.org/kvm/aNX6V6OSIwly1hu4@yzhao56-desk.sh.intel.com [4]
> > Link: https://lore.kernel.org/all/aYoS45AZNY0rUJQD@google.com [5]
> > Link: https://lore.kernel.org/all/aXzPIO2qZwuwaeLi@google.com [6]
...

> > +static u64 __tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level,
> > +				 struct page *new_sept_pt, struct page **dpamt_pages,
> > +				 u64 *ext_err1, u64 *ext_err2)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rcx = gpa | pg_level_to_tdx_sept_level(level),
> 
> we don't need to support anything other than 2MB, right?
Yeah, with tdh_mem_page_demote_2mb(), I'll hardcode the level to 2MB here.

> > +		.rdx = tdx_tdr_pa(td),
> > +		.r8 = page_to_phys(new_sept_pt),
> > +		.r12 = page_to_phys(dpamt_pages[0]),
> > +		.r13 = page_to_phys(dpamt_pages[1]),
> > +	};
> > +	u64 ret;
> > +
> > +	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
> > +
> > +	*ext_err1 = args.rcx;
> > +	*ext_err2 = args.rdx;
> > +	return ret;
> > +}
> > +
> > +u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, kvm_pfn_t pfn,
> > +			struct page *new_sept_pt, struct tdx_pamt_cache *pamt_cache,
> > +			u64 *ext_err1, u64 *ext_err2)
> > +{
> > +	atomic_t *dpamt_refcount = tdx_find_dpamt_refcount(pfn);
> > +	struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> > +	u64 ret;
> > +
> > +	*ext_err1 = 0;
> > +	*ext_err2 = 0;
> > +
> > +	if (WARN_ON_ONCE(!tdx_huge_page_demote_uninterruptible(&tdx_sysinfo) ||
> > +			 !tdx_supports_dynamic_pamt(&tdx_sysinfo) ||
> > +			 level != PG_LEVEL_2M))
> > +		return TDX_SW_ERROR;
> > +
> > +	if (WARN_ON_ONCE(alloc_pamt_array(dpamt_pages, pamt_cache)))
> > +		return TDX_SW_ERROR;
> 
> Why handle this differently than other pamt flows? It also looks like this
> warning was added since the last version I saw...
Right. The warning was added since v4 due to the internal review.

I added this WARN_ON_ONCE() after alloc_pamt_array() fails based on the
following internal review comment: 
"Hmm, so this makes me wonder, what kind of error do we want to return to KVM.
Does KVM ever expect this to fail? We handle PAGE_AUG failing, but can we talk
about how KVM will call this. What kind of failures does it want to know about
and what kind of failures can it do something about? Otherwise to review this
patch you need to look ahead to the code and understand the KVM MMU. Is it
possible to give some justification in the log for why the error exposure is the
way it is?"

I also noticed in the tdx_pamt_get() path, the return value of alloc_pamt_array()
is passed back to KVM directly, triggering KVM_BUG_ON(). However, since Sean
previously pointed out double warnings (i.e., both in demote() and KVM are
acceptable): "Two WARNs isn't the end of the world. It might even be helpful in
some cases, e.g. to more precisely document what went wrong." [5], I finally
added WARN_ON_ONCE() in this case.

Should I also add a comment such as "The caller must ensure there are enough
pages in the pamt_cache"?

Link: https://lore.kernel.org/all/aYoS45AZNY0rUJQD@google.com [5]


> > +
> > +	/*
> > +	 * The dpamt_lock is used to avoid contention between the
> > +	 * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
> > +	 */
> > +	spin_lock(&dpamt_lock);
> > +
> > +	/*
> > +	 * The caller ensures that DEMOTE is only invoked on a 2MB mapping, so
> > +	 * dpamt_refcount must be 0.
> > +	 */
> > +	if (WARN_ON_ONCE(atomic_read(dpamt_refcount))) {
> > +		ret = TDX_SW_ERROR;
> > +		goto out_free;
> 
> What if we don't handle this case? It won't get caught by the (ret !=
> TDX_SUCCESS) check below? I'm getting deja vu about all the defensive
It should be caught due to DEMOTE seamcall failure.
However, it makes me uncomfortable to set dpamt_refcount to 512 without first
asserting that it's 0.

> programming. I swear made this comment before.
You are right. Re-reading your comment made me realize I had missed that, as the
error handling in the previous internal version was convoluted.

> > +	}
> > +
> > +	ret = __tdh_mem_page_demote(td, gpa, level, new_sept_pt, dpamt_pages,
> > +				    ext_err1, ext_err2);
> > +	if (ret != TDX_SUCCESS) {
> > +		WARN_ON_ONCE((ret & TDX_SEAMCALL_STATUS_MASK) != TDX_OPERAND_BUSY);
> > +		goto out_free;
> > +	}
> > +
> > +	atomic_set(dpamt_refcount, PMD_SIZE / PAGE_SIZE);
> 
> This used to be PTRS_PER_PMD and we talked about setting it to 512 per the spec.
> in an internal review:
>    Decrementing PTRS_PER_PMD but the comment explicitly says 512. The TDX spec
>    explicitly says 512, so I'd just do atomic_set(pamt_refcount, 512);
I did replace PTRS_PER_PMD with 512 after your comment. Then internally, Sashiko
suggested:

"This isn't a bug, but would it be worth expressing the 512 symbolically
rather than as a bare literal here?

The seed value has to match the granularity used elsewhere in this file.
tdx_find_dpamt_refcount() indexes with:

	pfn >> (PMD_SHIFT - PAGE_SHIFT)

and the array is sized with PTRS_PER_PTE. Each later tdx_pamt_put() on a
4KB page decrements this refcount one-by-one, and only the final 1->0
transition fires TDH_PHYMEM_PAMT_REMOVE, so this seed represents the count
of 4KB sub-pages in the 2MB region.

On x86-64 PTRS_PER_PTE == 512 == PMD_SIZE/PAGE_SIZE, so the value is
correct today. Using PTRS_PER_PTE (or a named define) instead of the
literal 512 would keep this seed in lockstep with the indexing logic if
the PMD/page geometry ever changes. Was a bare literal preferred here for a
reason?"

Given that the TDX spec refers to 512 as: "The host VMM can split the mapping of
a single 2MB or 1GB page to 512 consecutive 4KB or 2MB pages...", I think using
PMD_SIZE / PAGE_SIZE would be more appropriate here (though personally I think
PTRS_PER_PMD is also fine).

I didn't consider it as a big issue so I didn't mention it in the chagnelog.

> Now it has changed to PMD_SIZE / PAGE_SIZE. There seems to have been at least a
> few changes that missed the version log. What happened? AI review? We need to
> make sure we are not rolling back previous decisions silently...
Will mark this kind of change next time.

> Can you share more widely if there are new unmentioned changes in the rest of
> the series?
Besides the main changes listed in the "Main changes from v3" section of the
changelog, and those already documented in the changelog of each patch, the
following changes vs v3 are undocumented:

Patch 1: added a level arg and have the callee to decide whether to skip PAMT
         add/put.
Patch 2: - PTRS_PER_PMD to PMD_SIZE / PAGE_SIZE,
         - atomic_cmpxchg_release() to atomic_set() due to the spinlock
	   protection.
         - added a helper __tdh_mem_page_demote().
Patch 3: implementation is much simpler due to the the base code changes
         introduced by the previous MMU refactor and folio/page to pfn series.
Patch 4: - Moved is_mirror_sp() immediately above disallowed_hugepage_adjust()
           instead of saving it in a local variable.
	 - added a comment explaining the disallowing reason.
