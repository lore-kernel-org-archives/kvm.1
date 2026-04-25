Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A081724;
	Sat, 25 Apr 2026 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777091150; cv=fail; b=ey7BlfGg0HlZ7Jfhd3aTPAdL/mhiA991+/EFYsdg0/TTMjjbYuwpQvxKW9jeNyO82HJaHNj/lPUfsn/OjoItoKSzVqt+kB/oZncErYIWHcmJXaBhavoFjKAUMsscS3BREBAK5z9qnIPt+69ElfZhbNeHOrcIFSfFXRNdfZF2n5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777091150; c=relaxed/simple;
	bh=eK5V0pc+6hxVP1G3dCPoGY6uwp09QnogSnLuovaAYQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TSNq527DopHww5Zt5AZDELz8g1eJdVz7vHjlGPE4Mf7kIGmet4ceGOzFN4hNc0Wycu/9dsi229E5aZOJLNLo3NNgy2IthPKHDj0tO1WM0Lm5MdiHnJliaxJOHazwY35zEF7Y1Gm+Dt/rc2wyWpFn0UmWXmnJnMgM9QspzJT0Di0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZl+xmSM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZl+xmSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777091149; x=1808627149;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eK5V0pc+6hxVP1G3dCPoGY6uwp09QnogSnLuovaAYQo=;
  b=dZl+xmSMgH0yjGQkxKMHaSQTAojwo7Bh9EhxYGXz3f+oMvNp01VX4p+1
   unHOXkf5bd2uPkChprTiB3fRWciJu+OiGYtpThaNJAI6Hvqmb3dm2N5kM
   0jCZDPc+3DkXznmUzrvDV5eA1hNLxytZ9Kdu7iW3Ey4zO80JOW6fWv6mF
   SnKRdfkGr3Kp9dE40MNIdwMmQr2DpH6BzRDR94WpqEtdhAR0a6+Z8Eq1k
   C6T0xKEFFWr+rzQFF/nOKdx2lYi+525GyaGEvlk5ciKVPqgJjnIVLoYT0
   CG38iG2yxE21+5blDwtcClUx7sgEMjpXy39AHqXzuKIEjvzjx5/2U9yu9
   w==;
X-CSE-ConnectionGUID: HepWzNUcSAK9yed9Whf21A==
X-CSE-MsgGUID: t8eH912MQYO+5o5lMG7jVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="89534793"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="89534793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 21:25:48 -0700
X-CSE-ConnectionGUID: UFd6IUAfSGW7dnp3qEfJIQ==
X-CSE-MsgGUID: xfxMjvCcTnaFgbIKxVKu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="238188629"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 21:25:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 21:25:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 21:25:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 21:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgH0PezcE6+XhSceD2trchpPG7iqq47dh5thAxs9Av2aFDR31+CRAoRNzXq3SsE7DGv2oGwUkSovdxNU4Xhz9MzYdrxHDdQ2i8PT9x9kM9YRSh1J9xt2E8WWY3CeEZ4kzSHFb1NPdhTVuRR/rXsFq2bPSrb2Mk7o/AU+XH7MrYHWO3632TqZxdrzNEkOWkjKQFnwCsLegFLVW1q7+EoVyZmhhdFTj7kV/tYwMBWWcxrvWAj9+6kE4svNQl9dAC5GIuC1Itva19RK/YX/1vGBaw30DvJ3EXuzLgKJ1grFCRPC+l8nIIVMAQLpWrc4KybfcDDtQzHGOwtn6tMHUX8+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a3jA56npBU3kNWBjDm7D/v3fJGeLeT8imDvA1ssnYM=;
 b=SqcwjcVAoHK5t5xNsK/GgG1yHkv6ZAOGB81Y6pJapi8GA/Ew8T9fiygL2+uRX0EU2aHQk87kAJe++J1vbzGVWV16dcC8+YUrH1ba1PdD9Gx2qFY0uz6C7oi6mAjBhIL7/5kjCe5eFHIxVbxLZdmA6E7tAICcMc/JAwZkxcvj++rRMziUb/Z7YGKBHLMTuKJo1BElsQ9RBfcj60JyIJYkj8PIuWpHyPsFMPymFgfdF7ZQE+4JPNyLrRQKiGUTC10Z++U/y5Fz0OQyDdlIiinvC3BydlodNy/2TOU7JaFvy7DzdORhuo4IkZs5J2SL4UAAlFPqvmFBy8GMsmnKkkSlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DM4PR11MB6312.namprd11.prod.outlook.com (2603:10b6:8:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 04:25:36 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 04:25:35 +0000
Date: Fri, 24 Apr 2026 21:25:34 -0700
From: Peter Fang <peter.fang@intel.com>
To: Gautam Menghani <gautam@linux.ibm.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>, Yosry Ahmed <yosry@kernel.org>, Ritesh Harjani
	<ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <20260425042534.GC1733452@pedri>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
 <aeso7lRjzDhIKEXV@Gautams-MacBook-Pro.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aeso7lRjzDhIKEXV@Gautams-MacBook-Pro.local>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DM4PR11MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 755477ce-b073-49c7-55af-08dea282b20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: GvP5PhvOXa9yxFkjLLPsGA0c23V7HyZIUTYLyBt5gkZWNuAbJgWtIWcoZnvXLX7E+OcNyoJkmSjkyz4KWlvn/k/fsOJrEIR8E04NDwhfzEuX9zPd0czsJ3WsI9ecaKKHAzxx2J0fszIwgCMC2SosBd+BjVUG8WhkvAz/NDFDtpd5RGismIzmz56s2FttV4laCIWkxk5YpO4+u25FXMZjxUCtqScVFp2SOd0G9yWqN0vLZ8+7/w7yjVqdhNVXtQGriTtp2OltKz6+29cGnMkzbQHJf5T11LJOc7qG3o4Ct/IMZtjGmyVG1l+OveRVy1H2OU6zmoRgjsLLQGSL9naSvmejiK3bryzwf3YOnKsofaF8GTbfM/T90OsIK8r4dj7CRTs2EBbJm3Bjq56j9b8pZfLxnz72pgBppqmoWt3B6JdBbW58vVzphYKgGnGgjaq7pdMIJOAht2VeY6PT/mfr/vynrdPlhU34sg/+jWnWDEJeeir/IbTaron/720pz6AfkBJ7C07h9/VqWA/OC3znSofHLsVfI0W7hR3RzVjiMVbjuFomaYRdWJFdo2Z91vUq4F/PnRIZc6iOheTFAP7TYyphccj+0UotgJ/1R6MW6mEZ7FCq6yRJe//fVSCYGGsFy6RXxDwhBviUlKDzM1NOcqditEvdZzpzn+86JNoRRH7A61QgJgSrL4mDubVJYHym2KnaINFisOCnPhkwghLLr7JQ3GRxEoSBgembtkXeWOlIzYZXvFGwr6MqT34Kd3Bn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upGl5Oh+84gH8YwIeYXCqS194PFJ5LNOetAHJ9TRNu8A0Ffxln9wHmZxF2JK?=
 =?us-ascii?Q?1zWOH1z7+HcjqHcr7zDO3Vi0nNXbw/Qq2xeFNd9DxoB/9Zb9inmMEz5MAb7L?=
 =?us-ascii?Q?vs1jJKriGXxJPkQnfjBJ+pBVTRGwoltPwO+Rg78WdOvgg4n6TDreMA1Rio+M?=
 =?us-ascii?Q?0wvbhAw4zFcXiDK2B75aiFemk0Oizth+GzIJAnawUhBOOsq3vAjhHmDmd86H?=
 =?us-ascii?Q?XRbOF2bk26OuzgTcM0aypFqJm8mSON0AseM8dTOQwEwag4DQm+0F+062B4//?=
 =?us-ascii?Q?RbBuhe6/E4gGjH9/ZMNWB0X9REcPnmqh6J5+nY+r1ta4pUxj/B/lJ+n/9DYz?=
 =?us-ascii?Q?3B6MNxhUf0hjR3AcCiBOtWZ99SxEygE9UoLfuhkp9qHtK0E/O9624c2ZnK1U?=
 =?us-ascii?Q?U0iB4G334596mGqbcoAffHoAVOY7/N1jMflLnqWn1lHWRmyHgJRXb1E4X6a9?=
 =?us-ascii?Q?H1Vd0X5r3PFLiPY9YMw1Q8ePkWvkS11s3tDPGvHfy0L8qNhGR7gQ8tuGgTE3?=
 =?us-ascii?Q?Ahp2FD8PcCZpu+1sd/4yIbq6ytmOvlkbB4A19gMgW9agfIuyJl42Arrr/YGj?=
 =?us-ascii?Q?04Pvo+6IaXuBAL51/4CkDNrZ8NDw0KJBj6tTVeohzR8OgxVdTAWRnjN9xeGV?=
 =?us-ascii?Q?CKWL72eGLvRnGIE7+GeFQAR3RRcaxvL0nD5GgG9u+iG5eXs/e5dEbg5ueFfo?=
 =?us-ascii?Q?p0g2GJtZDW3/CWJUD15Q+WZBPNajspLaovObNM8MWxE5hRF/ggIKHg5+uAqf?=
 =?us-ascii?Q?Jep1UATHePykapiNU3IoXywxaNj6j9eM7r7THhuy33C9jkCdL8iPfO5QiJ7p?=
 =?us-ascii?Q?jfry3JFQVVXqh67WhW9mgceRoBS8lb9qAvPh6Duko2CCsb2+PzGzFZkB6vVV?=
 =?us-ascii?Q?z5z5Wx1nSHld/KX/v4XZ6s6TqLFC/eWdZe6B5irO+PJAVdk0+LwQWRrk2oV2?=
 =?us-ascii?Q?iHrHDUIQbovO683RgvzaqfSiGbpGZvgAMwzQvDAosfiK0IRbJlTQiYJValX2?=
 =?us-ascii?Q?qMoExVSq65zIWuH/1Qi1R+ygKn1ODI6F+oGkbLIx0eAlS+AzU+nvWDiocYnm?=
 =?us-ascii?Q?PgaM1bTIfBp8vFFVbSVLPP97iw+bUL6bvVMcD0bNr0zsHMYnITz+wknolBcW?=
 =?us-ascii?Q?NqkozazB6YLkGQx4aFzCva8ERcm8i81AKtO5JYaVWlxCyUCL33a0qJzRN3v2?=
 =?us-ascii?Q?J62FVUczaNsW9qZ4LHRIaApTYsJNoTPGpmCOeD6RE8bReON1LqUicde7L0Ud?=
 =?us-ascii?Q?OzYpqwtMp+SM2t/zlWwE/2TVHj1oxZFBhn75crVncOM6VHyv8MIaSerqbS4I?=
 =?us-ascii?Q?LiDOZBfoVTyWx29fJdfZ/gTininfRSejSjTbiINjzOlnx/2WV7VxnFNLTKE5?=
 =?us-ascii?Q?U/+K9y2xY7V6RSekvPokWu8jGbB3ol1jAANiBJIErkdPlD3fXifsws4N3ccL?=
 =?us-ascii?Q?CUOZexlmkLatCMFQShXIT6skeWL0hwy/ybyLiursG9QwO+e9TaM0guTa9twz?=
 =?us-ascii?Q?NGbsEVFu1cKxuwHRYrWZ5bSTJKYh0V6qMDYftiJWpdHsy0+r9g5V+MP+1FBC?=
 =?us-ascii?Q?mfE07itxzLqh8jXJ2Xfa8a/ltJMT6VVFE4TkWOigfM1E+l6keFDzIZW4Gl0U?=
 =?us-ascii?Q?hrBbE3sOU6d+m8WQCYu9EzvuqVHZ8r/WPqOM+AbdTpdxQ/I+6WtQkV1/ia9E?=
 =?us-ascii?Q?tBxDnakir1sko+p5O5hShOHHThoFc7cCEmlp2E5O8UPUpyuoB0hIpVcNTcPJ?=
 =?us-ascii?Q?CePAEhDjmA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ADoV+WosM/x61SeGxszLm5L/+B8OWPLfzf1WQauyNrpJ4gCNNPB6t7l56AGCbYwmsM20CbMrQ3O+IAMz3FHO2BTxwmkWzhG2OjWJqM0V6hNnN+l8xHZd5GR8XRHzshYWwkyD8gGLM2Oh1wVuBvG1mCgs5SjzZoVZPRu/F+wBJHQbCgy2VLRmMXoZljw9a0zrg56GF6oR+TIoXGrPLWCgNVVSAgAQ94m0VIOy0eNV79+p8u5SDs5U8H6e3JqzODWaKNIf0l1KYkDkmZk9pcCfh3/OpdAiVfd/y00cE20S0iF6tlOiVsBfbbEUH1D0sW31pAfPW//RBsrUO+FaHSvruQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 755477ce-b073-49c7-55af-08dea282b20e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 04:25:35.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXcLtORB5LzZR0FBh9PlJ2MdIuK8niM4VUBfktuhxJx3X8eTobNIAtt16/yjY8p1aSDxji7zQWS11MsgU4ULag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6312
X-OriginatorOrg: intel.com

On Fri, Apr 24, 2026 at 01:55:18PM +0530, Gautam Menghani wrote:
> On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> > boilerplate at call sites.
> 
> For this refactor, shouldn't the prototypes continue to take in gpa? I
> think this was agreed in v1? [1]
> 
> Am I missing something?

Patch 1 first does the "quick fix" of changing the prototypes to take
gfn_t, and then patch 3 changes the prototypes back to taking gpa_t so
that callers don't need to use gpa_to_gfn(). Hope that clarifies the
series.

> 
> [1] : https://lore.kernel.org/kvm/ac8BOGXIPMnJ7kIg@google.com/
> 
> Thanks,
> Gautam
