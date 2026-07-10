Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196037AA97;
	Fri, 10 Jul 2026 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724428; cv=fail; b=thAfZzA3MmCZ6Ac0MfqVRdfEybPJLLM4CQ2AcJb8c3dxpsgRznBpdVZFTkv87VpeSaebGiFq9ly1Ihk2wLn/m6QrVqbFqujsPZunC/W/bHakXPsMICtdAX3Averbxk4dHBtg2vD06lvhIfXXxO1jph9QYYSJqFXdIkSxHbHvYk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724428; c=relaxed/simple;
	bh=xDqFTvdw+FBinYvVY+DAuabzAv8EP2clvA2XqP2ifJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pPXaLbLwnzb8n9RGT53Nb8XF05OKdvt4iaMNK9+GJsV8FW8B8ZWiYPk8CmOVGEyKOhn2fUkUlYOt4mORKXUov0RwpgZ3YAIPiM0ygLO947LaD+c0i0wmhguiuoauQwDrlfJsUpuV+3ODqp+rRr7hr4e3HlW3a+2PA1hrZc1236c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiIHRdF+; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiIHRdF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783724426; x=1815260426;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xDqFTvdw+FBinYvVY+DAuabzAv8EP2clvA2XqP2ifJ0=;
  b=XiIHRdF+NEdtpb9h5lpdaLZPrTv3qtn7zy3obk3IuJgIr9DD86c4HHPX
   Xy+x04hOT6nH4saq51qDJ+7gzUHYi+NKI4Z1tcsPo0UVbJEaFtTQ4ENlA
   7CMGCdofdQuBmL1NifdgErByJN37vb+gPb70dzXYxupTI+dAOYquKJUgO
   7ZCVtoPGFi+CirRkUvgLQi/rTX2ZvtorMT0LG/Yx3IrzmX6W7a0RH79B3
   mtdDf3G00oXx2kN4/LVqQwXBjOEC/svWFc4A4O0FyPLHFQX+IglG2HeC8
   7JIsIwxGTsVBmdheYou+l6/8nIhvzKypAikcbFnsnC+daq9xtFLClbduX
   Q==;
X-CSE-ConnectionGUID: PvsnNPGIRyGLPU647mjHFg==
X-CSE-MsgGUID: KEToMWWFQHa/GLNp6wdOXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84477890"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84477890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 16:00:25 -0700
X-CSE-ConnectionGUID: 1uHQVhapSlWQn966d4vWSQ==
X-CSE-MsgGUID: 5m5hUsxjTVibldD7q5moig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253267913"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 16:00:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 16:00:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 16:00:10 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 16:00:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM5KjptMM5RxVB2PiN3wjS1lUqsS3wn5bl8FDIJ2btamTu7Jlsnpwkiq8gJoMwq/x9sza98dSSv9jOKokwl99ZjlRK5/hIbwOPf1kHdU62VtZAs38alh2FJq+cRtl41K89mE/KSKjd+aDFc5N3a69NAq+KGFQsPku8uXdZ0VgKGUqVxI0c86+gd3+sNz6wW9x8Loy2H6RSVqHvS5DCWgPqRP1XHR4xquOwNgQDES8BFJ1wAr5V/qcCg/yc0PAURqBHrQtdAEuIKrSfjP2/Z0v5JnvUINqeBxRQHTQOBBWgJwH/vHaflxLGEAmr4l93/iCJlQxySqhsTA559Y+shKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGm7ZHuImdVhX4IVDwPAgxLlz6xLKKNv1LOdq60mks4=;
 b=j83LA70rZsX4Es+gMm64gpC+KDe9GKwDSQnFA9YzpesEKYsjH8d8QziD4qWmMIsmYv+0NdMEOb5RHnekLxytbROME9ivWQIjuTVhqnViOSYT8sooYbv5W3JVXIPDaYjkePOSQsGZMro0re2xvRAtrTMscz6Cxop44wq3KeFJTKe0pqigkQjX4mHcJJLwB8YnsN/z9yi3Ltm2LXlv3p9LkW4YnktwZb+j9SBSJoRd2pcp6N01VoVDftDjQ6vWJhym4k6hFl9X4W1Uj4iua+s5L44QpWtI67gUd8C2IGHot21E++a+dHIV480nfCkMKD8VeJ7DD0o1UE3nknoRKbu79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 23:00:01 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.017; Fri, 10 Jul 2026
 22:59:58 +0000
Date: Fri, 10 Jul 2026 15:59:48 -0700
From: Peter Fang <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<dave.hansen@intel.com>, <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260710225948.GA3092517@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <ak7DMwbF4viiVoO5@google.com>
 <20260710125211.GB2816371@pedri>
 <alEGIrWhQvzf2wAV@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alEGIrWhQvzf2wAV@google.com>
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 992a470c-9ab8-48e3-7917-08deded6f480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: kr1D4XqZRAg+x49pbfiUHM4F23GgXNgRAW/Oem33jRv3pR7uUUProhSaK5yG8SoIJtZyv31VWbifg+s+tZP18+D1aVwaOQgjKT2jJv2oY2W9YLaP+rC3OI+jk7Pz65dz/3m84N4TCAKzRGWfAjDrn3xOJJCNc1RR9w9MRy49Ir0e2p1pR6Va8U3yiFf7Ytgp5OMbgIdaKQFn4IGClmq8AvbBHlP8QtdxaDuTigbDT7F2E2An4uQ7CLO5TWEDFliux+abL/gCdvIM4F0mbze5Bz1Gqw+DVifVKhNze/7XiL3yBYhBhrSXeBcB0Ipkfst5oEcFV4wGvuji/uVuK7SLhvblN3qb9nIYzaO7qYZ93SiJ1EcceEIpwnlv5ZeDBft17igUuSjPL1LgaBdhaZCd4v+tDGMGKc5qI1eyVmcjdntO6DzhlGYQx3iWcUZD39dmHFLrMLWyy6Gx2S9ZztsB/afPHrExISIlMdgKx0XWURFOjwpYu00Tmr8WmhrCZvDIdUr4G1LWuH9S1nIuxcHGPbSJRN+y7vXalgjp8N1xH8EVknhL7ZnkRCyIuJf6ViN3H61mYdPwdh2Y+ccQhpaciZYv80l4Qb51eaHmcw8FWMHGIADqOV+3ob7zsO8KJ93vagSswro7a7isIWR/Dk45+ehpF1aCdI8fW2jsM83ooBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y68EDJXw+F7KDaSGyiS82QrDMKic46T+F4AD9eLzSmuz9TOWmYoXTyo5Jjdq?=
 =?us-ascii?Q?4qKyjn43NmXelLKYuDV81nTo/IYHO9U1UY/HJzYzM2oXGT3HspNFHb+iJ5GU?=
 =?us-ascii?Q?S48cOb5ncLnWf/4qc9RMZIhgW38PEABo8MxtHb0hgPHFRZatjNqtyCJIdEOG?=
 =?us-ascii?Q?SuXnbJCe+RWPmizJUNGAL6kzrREfB18GUuPVwWkE1ognD2miwCS0jXCeycCH?=
 =?us-ascii?Q?jQZBwgxm3TH3Zn0naeBU48/dlzY4mEiGqEb4urHQ4DHWft5cLi710FlisyfT?=
 =?us-ascii?Q?tCEcHKy4/xhLn+t4YyaWUOGf5aj6wqeH+svYclmSI2c6YMnv9oq1WvxCvC2w?=
 =?us-ascii?Q?otYfNTqsMM5haa75jEAHdNKgIuTsFsWNqDwaP2mhxHH4fHgNlhix0x9vl2kZ?=
 =?us-ascii?Q?5h8FO+NxkxEh/B4z9Au8f0s8sHrruc6INzl16Jb2Rr3C+1VqT9TeYIZkmDG2?=
 =?us-ascii?Q?WpZV+zfmT3csyWR2GQjNFdUUwYtAN90McXnUi3gWInJNqVA0yYm4LTlXkJqy?=
 =?us-ascii?Q?AEQ+CqhbblO5qP1QarI6grqj01u1fLfSTkGlXcEngmHTJxWVbjAz8yk86CLS?=
 =?us-ascii?Q?ozV6K6zCSWN0+zjqZj+lBbYkhd7hN28ObMTzlziuottGEqk10L/l+ScF/Agb?=
 =?us-ascii?Q?A4mJ+LJHYSBJ5oFfhnOVI2FaefgAjwgBWJYaPYYnvxRmXMuL8usWI2OnnC1j?=
 =?us-ascii?Q?rrZ/mfQhfQq0XkBUs3GUszFGY6EYsHRWqqGDV38s5CiTdLSaZDD/pB7X5d4a?=
 =?us-ascii?Q?L3jZiLhonkpxg0yrdf7+dhde0kpDf66xrBJ3gwu9aJpLoLTNQXtac2+jWTOf?=
 =?us-ascii?Q?PgZtJ7bWVj4UyTpUj6cbi+CMHxvEELFxs7a+jr6URVABEQbnCbtJWX7ImzcS?=
 =?us-ascii?Q?o/PScp8pNUrTNDcbiLeujZbivhCLngqO/49GhLKMsnJpr6IF+ugd1QM1VEhP?=
 =?us-ascii?Q?EV3da+MQR9rdg3bi8OOrSCuuIPofYTKS1mNIcKLb3h6hbaMPSeYDSKG2tW1Z?=
 =?us-ascii?Q?4qeXlXPI7nva90Cn4aWBiN9BwHb4avw42QKCabo7wBD10CEh6z/Ns0ODHbuQ?=
 =?us-ascii?Q?fWoKRDKHfbO2OFNXDu+p4pEkq69F96sYcCFYbuhkVDkVxYIUqTUbCEJN/siq?=
 =?us-ascii?Q?RXa7xyk3Mq5hfOjnUF4Fk/Bn9NDLgoKr6o2tXMsSVqoUqjV1QbU0hwPuKFXU?=
 =?us-ascii?Q?g4Or+03OW2bgdzoApn6X+RqID1rAoSa3lnywSwo9K7rHBIkH/iyypGiD4s6q?=
 =?us-ascii?Q?4XOjW31w9+vTwC5d5cYt9G5mLtxSgWcW1DOkZDr7WUVDJFs9fBSi7rHrAb2z?=
 =?us-ascii?Q?KfTst/6Kuxq0duPml5wiQBh/Wn7ohsdJ36SPOUmNDlaM8JaNMtMCmVzXOQ9k?=
 =?us-ascii?Q?yWBqBop/vSRFLBa1ZbTXkR9tFUENTI/g6X8EQRBXy+eXhwLgEAIeucCa5yQx?=
 =?us-ascii?Q?cjYwZ09WHamqLD6kOQf52OgSB8PXo/WVs13OLbwGS8MRKnUxldTuXbO14GUW?=
 =?us-ascii?Q?l6esQjqc51y3a99TfJfXD2zxhgDkvpZLKVe3h9FRX5XbWg/m2EQeyhr3FKBx?=
 =?us-ascii?Q?g1OAnfi1E97IRwcYwm83if85ysM5IKtJujogInULYLJaC0mwA/v6sO0srLUR?=
 =?us-ascii?Q?vuhFb2zuD27s5ykiVqMj/MpJsFT85YmmnpIegiRmSCXahhaw3LacWXDdHkvm?=
 =?us-ascii?Q?ytYW4GrzL4nlAzgZsiTEH1VobIoNxCO0FsMvDvuqWIavTEzCL5V/15AKVzGS?=
 =?us-ascii?Q?YZHNVPerJw=3D=3D?=
X-Exchange-RoutingPolicyChecked: hE0Fkepf9qp8+ZRMzbPEUvtoMdBv3wfkA4TQ+UQAiORsMHEeWtaj82G6cwBmp4rmu4XoUoCk005Re02BT6tgShC67y8Qil7SetZ/zlOQzVdgf1yTqi8MMVZfg4c4nzU1sGmMEtdkC1xvKEDDS1yoV6FvIGrEybR735IeyBUyBCwZNfeNHJw+oks7lkYdgMNHClNCpXFCJPGGoBTFgfqo4i8CUMUNPovUvpDI+YDvYdnShc9ZTDupRvEuUZPl7R15NWkzQ+YieipZYk+X8Od7DTAx7Yjiji9icliUrJWtroXYOW9a1JDv2OSbCxGVmeZY9nuFGlnJcPwEu4m58Eq5pQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 992a470c-9ab8-48e3-7917-08deded6f480
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 22:59:57.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coAJ5FizfeF3O3Vv07zpFdMEfLKOW0B6U/nsK6FPfWrPsgW+rLEj9nmoGBGmRsdQmXQknX+MQZUN4EfT3MU70Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 07:48:02AM -0700, Sean Christopherson wrote:
> On Fri, Jul 10, 2026, Peter Fang wrote:
> > On Wed, Jul 08, 2026 at 02:37:55PM -0700, Sean Christopherson wrote:
> > > On Thu, Jun 18, 2026, Xu Yilun wrote:
> > > And is keying off tdx_quote_enabled() and only tdx_quote_enabled() backwards
> > > compatible?  How do we know that cutting userspace out of the loop wont' break
> > > anything?
> > 
> > Yeah this needs explaining:
> > 
> > The guest-observable difference between the two paths is that it sees
> > quotes in different formats (the TDX module uses newer formats of
> > course). And an old guest must be able to continue using its
> > TDVMCALL<GetQuote> interface for quotes. The guest sends the quote to an
> > external verifier to authenticate itself. The verifier (part of the
> > cloud infrastructure) must know how to parse this format. So in other
> > words, it's the verifier that must maintain backward compatibility if it
> > wants to continue accepting old quotes. And it needs to be updated to
> > support newer formats as well.
> 
> Uh, no, that's not how KVM's guest/host ABI works.  Updating the host kernel and
> breaking existing guest is not acceptable.

Yeah I agree there's ABI sensitivity here. I can provide a bit more
context here:

- When you get a quote you don't check it yourself. You pass it to a
  verifier service which does the check. The verifier checks if the
  platform is genuine. It has platform specific knowledge for each new
  platform. So with a new platform these services need to be updated to
  know about the new platform's quote, or attestation will fail for
  these guests.
- There may be platforms that support TDX but have SGX off for various
  reasons. Meaning SGX based attestation won't work and they will only
  support this new type of quote.
- SGX based attestation is very complicated for users. It will likely be
  deprecated long term. This new type of quote simplifies a lot of
  steps.


A risk could be that someone makes a quote verifying service that
supports a new DICE capable platform halfway (SGX only), then the user
does a kernel upgrade and sees their verifications start failing. But
these halfway services would probably come to life after the kernel
support is upstream since DICE capable platforms are not available yet.
So not sure if that's a major concern for regression.

I should call out this is not a zero-risk ABI change and the risks
should have been enumerated. The approach this revision takes is to have
less uABI on the assumption that it will not impact any real users. So
we need to consider whether the simplicity is worth it vs going to
userspace and back. Is it worth considering to have less uABI?  Or would
you rather punt to userspace?  BTW, the quote SEAMCALL does it for a
specifc TD. So putting this new ABI in the TDX host service would
require adding KVM's TD life cycle knowledge. So the "and back" part
probably would fit best as a new KVM TDX ioctl.

> 
> > > > +{
> > > > +	gfn_t gfn_start, gfn_end;
> > > > +	u64 end;
> > > > +
> > > > +	if (!size)
> > > > +		return TDVMCALL_STATUS_INVALID_OPERAND;
> > > > +
> > > > +	if (!PAGE_ALIGNED(gpa) || !PAGE_ALIGNED(size))
> > > > +		return TDVMCALL_STATUS_ALIGN_ERROR;
> > > > +
> > > > +	if (check_add_overflow(gpa, size, &end))
> > > > +		return TDVMCALL_STATUS_INVALID_OPERAND;
> > > > +
> > > > +	gfn_start = gpa_to_gfn(gpa);
> > > > +	gfn_end = gpa_to_gfn(end);
> > > > +
> > > > +	/*
> > > > +	 * Reject if the guest didn't explicitly convert its quote pages to
> > > > +	 * shared.
> > > > +	 */
> > > > +	if (!kvm_range_has_memory_attributes(vcpu->kvm, gfn_start, gfn_end,
> > > > +					     KVM_MEMORY_ATTRIBUTE_PRIVATE, 0))
> > > 
> > > TOCTOU?
> > 
> > I struggled a bit with this actually... I can't just grab
> > kvm->slots_lock here, and dropping kvm->srcu seems bad because the quote
> > will be written to guest memory later. I settled on the idea that the
> > guest should make sure these pages are converted to shared first. If it
> > tries to convert them back to private after this check, before this
> > TDVMCALL returns, then it's kind of a self-inflicted race and I don't
> > see KVM doing any self damage in this case. Not sure if this makes sense
> > to you? Or maybe I should just drop this check and go straight to
> > kvm_vcpu_read_guest()?
> 
> Yes, drop it and rely on uaccess to do the right thing.

Got it, thanks Sean.
