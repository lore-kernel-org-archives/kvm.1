Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DD412BF6;
	Wed, 14 Oct 2026 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956462; cv=fail; b=G3udOEEQ5AlofjhnmBE8SgZac4YJTwQGOKBv9TTJXdeFw6JVQXwwEUmAdai/LlbuvEL8RZPWTsF5PUaVsCTHVh4XyObhKISEvVIXYGZhUCwmAGIBpikUz3x3gRRDA6JjV/cHXMN988sIaFkeofEDoZ6MHtJOXFeV7MRiDLGu9eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956462; c=relaxed/simple;
	bh=TGAaCUJKATkpZLYd6Ai9Lal6YEZ+QpMPPQf3Jm+j8Ag=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BCF+39HptPQFTx3DOlmFD4om7tegDYW2jr5hUmqKt3Or0ZZXUmxnN7cn3c7uEzR3CW9og9rEWzhP2bs7pzh0D3GxM7fOIJfjSNYmVqVheM33EC5KodAgiXNMewUXrr/yspOVbWkHn0fCK0e2INi+/qi6bdy/H2YEMYnspNtkfNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dozo/qny; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dozo/qny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791956460; x=1823492460;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=TGAaCUJKATkpZLYd6Ai9Lal6YEZ+QpMPPQf3Jm+j8Ag=;
  b=dozo/qny7dJdE5lJcdZhCYokSKBBy0me4Qm7tKafutVE/BB1+GSWCY5I
   jlQqNhBM5/L6OzemZ/KuUXmR5km0rXxeSSsR/zUCqUKPbZWqpgwRd7uTP
   SaaRZqrpjgEgEwiVMQt9+z6AK3TqJAI4KvO9YOeMZbOQI+eGEhvIxDW8e
   s0TNg7ZVony4t+vHS2scgW4iPrnzFUmBEci/Uw+N9BeTFXdFYNSR1e8N4
   UprOv2TLVRMHL00WhCWHzrcXK1mWa22feMPCzDXK89gtbgssi+OVVPjJt
   1DGJmk5b1FQCVDzKZrJ9ovngQuzG4KQJvZB0sHZN+/w9+j0C+rMWVPGoB
   w==;
X-CSE-ConnectionGUID: vGYklNHrQd66iaAD+3jrEw==
X-CSE-MsgGUID: UJJYgd4uQKGMV7139uftzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="584591"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="584591"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 22:41:00 -0700
X-CSE-ConnectionGUID: 2SaHP+5OQdiKjg1AdRQ8dw==
X-CSE-MsgGUID: iL2LYulfTASGFLlc6kjD7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1416865"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 22:41:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 22:40:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 22:40:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 22:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR6qi8ZSDqMSlIXF8RI97fHgat3acA2IQuYCbKHQL2IkmPeP3YDY+9CnY4AnOftYp0lhWmKKvq0fFNKecAKqNLTfv1VgvhvOvvYRex4zXjCurrMALl7mfXeFarZFGSqpocpSmwZDjUf1Pkha64qaKCsioA062uKAvQM9EkpzPYb/ieEMYUQiS1pDfjIcjxXJWR+jIGz5rDngByt0w/LQ+gIWNHgnM87WAm4XFlV5EVvy7+D46eMj15p4WowsxTgvxJTVMSMaqGuvzAVoVrbqAaQFYHmiQ8Fa4LHOtbYOyy64R3D+fgYiemxQQ4OsMPvHKgDiMwtzYaUqsoRxrZh9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcYxDG0pdWH6hv9WWTpqBuJa1L9zsfWCEPbqAAub4wk=;
 b=EAgu43XYZDfuZosaGJG0dFG6cpp2Zv9Sa/WsDzDlknBsprIiPpD0oYhR/ze7RSuF8KWMhG24OBABXXMj7E1ErMUlVqdi3UDNG/Y2SNm63UmayoyobrtVwVwd3z1HU/sx3LknrhqHJOSsPIl3VPfOIrxwLWYrriw9yrm0tUttljtZ9gOpbxAH9uuR+CcZ7SB1mBdRNLbu6mGIhdC7YGbpqb2yK/ZFQ3GKQwy0WCOVHu+XtEZzRMAFug09JmOjRSHof0xLFlK8VVeIc4zpJlyqeilgyeFYwxrkKNVFfk4n2rTADiB4uSZqtaFu0pHqDdzEZEMuNc+eYyEOZGZv1/dFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3245.namprd11.prod.outlook.com (2603:10b6:805:be::32)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 05:40:51 +0000
Received: from SN6PR11MB3245.namprd11.prod.outlook.com
 ([fe80::9a60:375d:1803:4312]) by SN6PR11MB3245.namprd11.prod.outlook.com
 ([fe80::9a60:375d:1803:4312%2]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 05:40:51 +0000
Date: Wed, 14 Oct 2026 13:39:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 07/17] KVM: TDX: Add core support for
 splitting/demoting 2MB S-EPT mappings to 4KB
Message-ID: <as8Vr11BrvZ6Iqc/@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091021.15583-1-yan.y.zhao@intel.com>
 <90ecae2e769c85d5c32a2d31f004dd007f4f6774.camel@intel.com>
 <asncgdZbLRuPAEhu@yzhao56-desk.sh.intel.com>
 <12a1d64dc2f0c05a9130e291e0733f7d7991ad95.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12a1d64dc2f0c05a9130e291e0733f7d7991ad95.camel@intel.com>
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To SN6PR11MB3245.namprd11.prod.outlook.com
 (2603:10b6:805:be::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3245:EE_|MN2PR11MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d63d3b0-1575-4cb1-72d9-08df29b5b53a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|260925022911599003|260925021311599003|260925021911599003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: INujUdSyq6PuJ5PjDcugguX54Le4/KnAKOI2zZzng35qJUD8btb3Z7w1qDkCascBWT8jiko4A8LEfgPmwbUvETZ5ykJSYyjrHD6wDqQ9aeX7YwjEr3aKQO/jXZFtXwR5vws6TDwRL75G+KY4kgnwBhlvo8wqu1PHNUW4v3rc7LF4K6xRZFY7JdxNDmaipR9opOw8gvMjTXI3P8dYhqwdC43+6r4Q0MgMszfacfXu6vKwYhsVYQVY5JbXp5BfkEvfjnJdXJEZfEUnU0sHJ3JcMBG8A1TsrZo69pDzmwBNmVJU7/m1fd75fv6/E8nLEbDT9U0ivh6eB+jd3x5KZJBwvsNnMfx2++VF9o51/iYyOZ/r0qiaAhbwCJmw9DtcwaQouHC13m4sfI13GriupQMXUz8sEh47U1htJiGePiZydDPYrfvm2UWBBSPToyTI76uKUh/Gyp9O+0Tx+Q+uc+VQUeyK7Db37H5CYuNuUOKRHykzudswk6R0XYjG6y0CaC/Q+oRNoCHE7iDiC39OVTRJLl/YrtARCQkmReNnixz/+Y+MXeCXVTO6jMoHIIagQFeEKvJVL8BUxo8cie3Au4e+nb/JlganupoaRE76Fx3oRwjLNNd3llwXenyiUcRkvkDa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3245.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(260925022911599003)(260925021311599003)(260925021911599003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?py+0hb9JfHAbbpediTLpwsQKIQs15FY3i5ViKxGhij9SfUwzv3mDeIGAuZSu?=
 =?us-ascii?Q?Haf2vFId9MNYj3WLThQpnBtDZB6GZGmv8/cK1G0isMCkViHE1nKUkc/85aBB?=
 =?us-ascii?Q?gZCzkUcLJ+78ds9gc+SIJB8GlZ51zbKFiAkGAFTMFt8iZ+5xfuBX4CWFoL4V?=
 =?us-ascii?Q?h9usrm0B/WRJOcpaxlCCqYxO0pJ6OJT0LpyuramYfMYHbQDLD7Te/IOgBXVk?=
 =?us-ascii?Q?03xUQ9brGaekjlpzQUPhlrHaw1eYrJkY0tzNmmVEyw2RdaF7qdsQHBQ2fOOC?=
 =?us-ascii?Q?aVxu9JlKq0pemw6gopaStYETKnL2VWAFCLfM3K5Hc0QD5clHJhoAmE5dQq7U?=
 =?us-ascii?Q?NMcYYUTIDVDELxmbfhqQIcf5I9ej+Lld2f4L4Q/7hknv7sWMggxDOV1ywyGL?=
 =?us-ascii?Q?tEG5tQSyBEOFa9dyicLl7wuRCcN9iNIC5KgiTccnIsD9l0gu3HAsT+89Njp2?=
 =?us-ascii?Q?IrNUHGv5GMqulvxIbG2/0PBjliFGNjgj7ABjNvIHO/A9vH51eCXJNR4rGCNx?=
 =?us-ascii?Q?ev5r04qLJ9Bdfxe0iELk2QGTpO4tS7Z6jiC42qZ3F8dCwMgY8l+SFlMPkpNM?=
 =?us-ascii?Q?nUXTQvnDkOWZKVAIVmqTOUGV8vVV8iuWhzUrGN9yXquSy4cpbeWTVgceTrQh?=
 =?us-ascii?Q?OwvTjLIroJHgsj2KbCR+33FPbQKiT+M0vL3B9nMpt7JM1/vMicNqV+xbEid4?=
 =?us-ascii?Q?ey1WtA0L0a2kfIpMJZS+2zqyxq5oCt66wf2PV5YU6F6OyZjA5UpnUoHpVlFP?=
 =?us-ascii?Q?LurIGEo/RMzJkgohjS3uvhmzESeC4712x+D79pga17bf7TallgSO1eLnpmwu?=
 =?us-ascii?Q?6tjiixGQLJm7tmOSZtbiZczNX0AEIJXd/0S739jf4LqB4LfsivsGO1pPLOYl?=
 =?us-ascii?Q?wWLqiRV3AFhhCvyKXLHMPIpRmKpbOXerx1KTXDYwBZn61AeSRYhE6T0QZZFO?=
 =?us-ascii?Q?AOishCm/fHsyhN/rqTDsWp8SdWaqWS4l9rBGQn3YBh/Oc90oLu/IUOxfoocF?=
 =?us-ascii?Q?jqRiFJVubQE0AMpLVlUTLsTpElp447WD9CIG4RUgspfDjG+DG3DIXUuCIpRC?=
 =?us-ascii?Q?cAL0gKLJzXR6b7LQTszTXMb4KPMCyjEjPUGPuvED/TRNEUukACpTeO2Y9sUr?=
 =?us-ascii?Q?2QQSfJL0Fm4scDmVLEt92cDGMmHoOm11Y4PPCyf8yQJTCJSUcbzYEGBQUTeO?=
 =?us-ascii?Q?JVGDUe3OVpbop49Kt8+tSDvxHM7tpTBXhjg9Q74pGL6euwn0PkF24dtsYjFx?=
 =?us-ascii?Q?x3ZyNgnRK6F8QhJMK4p4huvHHiRiAfCzkSkZg47DhLsCqh/MGoc6BrScKvn2?=
 =?us-ascii?Q?3s4UbYDXqiok18oY/w54hGw+c31KKNEBGCtZnki+Q9fclFfGmhJHTmnlD59P?=
 =?us-ascii?Q?SufWB8D0qlAN+PObPYbQTWR3kxSzrnmCyUMXsgYieyBqiBmZkZUyAeJZqnNI?=
 =?us-ascii?Q?KY0ZrDy9L2QNISrMMeTgKvY0Dt3bFOtlbka5fYTPeudH6gkQLJOOF25Qf9Yc?=
 =?us-ascii?Q?fLghQHItb79ioCmY+2XvgEQVQUBAxZTbX/oHpo2sa1c2CQ7EMEoDHVXJ6MD/?=
 =?us-ascii?Q?+W1/lkbMW/vYDyRIeGoLdvJuyBKEqhXKgSM9FdHmNOC66tRTyB4HMY6ybYbK?=
 =?us-ascii?Q?TRqr0R+uSXCkl+HzKh2vJvrkI3JhOXqUNsQKAM4fSUDz4F6AjIq2l30XuHXc?=
 =?us-ascii?Q?h4W9V4RgVfF6qB5Nez1/p9sgHwskD/SOpH4N5nF1vDuJkZcEvn3VdNXSly1B?=
 =?us-ascii?Q?/RVpNtXlDw=3D=3D?=
X-Exchange-RoutingPolicyChecked: tve2PUmiCXAlNLaJXQU0MMAaUaI4NwJDFBdGNbhjxoACHpInvuXWI+9N6SB/vi0fKOuP9hDoKF7P4f7Gfxlkv6dMvp/TD/h7mCNcyh/rjQx6nbnmQfX71YbN+za0tLfaGDDiUaV5mfuesblNvQ+nQNtBGj9HCH0IHgdt+yM6cKtdnBXzvqc2f4RamfiTzu92I4jJYeJBiJIYTBU1QRkAcfnaxGXasL1pDt1jk/+9LdFjOLX5VkBBKTz/NtAve1fRw9tM0Tjfq4q7byTjko5oyMbxOtVeQbnKab2x+wyYGU1oL6U7Nm0iKLFMtAr8sWpJFkifVB0fdcQ+B2vIxJbLvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d63d3b0-1575-4cb1-72d9-08df29b5b53a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3245.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:40:51.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZT2BynTngLh0OyIoTUMaMCY0ai4Wcg+t+SyYsL69LMTVgCNTJmayAvknsf7RTzDsQyC1LpBzinSCZt+SnBerw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 12:40:47AM +0800, Edgecombe, Rick P wrote:
> On Sat, 2026-10-10 at 14:34 +0800, Yan Zhao wrote:
> > > The SOB seems wrong. You are the the listed author, but these don't have a
> > > Co-
> > > developed-by tag.
> > The current implementation has been substantially reworked from the original
> > one
> > https://lore.kernel.org/all/b387dcfc499d2f17e448cd4574115d1fd2437921.1708933624.git.isaku.yamahata@intel.com/
> > 
> > Should I use Originally-by tag?
> 
> For the tags I don't have a problem with the author change. But the tags need to
> pass checkpatch, tip maintainer docs, etc. Which I expect this doesn't. I would
> have just moved the other contributors to co-developed-by.
Will update according to your suggestion! 

> Comments looked fine to me.
Thanks.
