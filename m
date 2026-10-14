Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1654E0B63;
	Wed, 14 Oct 2026 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970908; cv=fail; b=IcaiH34sXg+9ZbgnqyJp5LpzNHFFXK8iWtxNW8DajrjC7bxH4JE2GXO+IvhhWZu5buqQArLiytelS4gwKWYDUIhBqzh5LQgEEM0L6fxZ2AOwYK0dLI5USJ4ms+jRyhSIrjkv17hPr0lKn8U3GtqPwKgYF4AY05miKohLE1RX3Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970908; c=relaxed/simple;
	bh=dZ4a0GQm0Hkjpe+NT2MhKZxtuezcB4vxYp3ecHHE1ZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aCqL/9woJYOC+nHNeFC13DTbbxr1JgQrLcicOZryvjdJOn7BZADzGsWwGFEzywMm3IYnQdI5Uu48oQ3jSsGOPJ0tLOxtnpMo1tm2b8CzsJKpO2XpY1i49VV+DBHQJ+zw0SFw4iyYDcvJTFhdxB57z6jEnx5OCheW58pwYLMGiTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUmqpMLD; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUmqpMLD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791970906; x=1823506906;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dZ4a0GQm0Hkjpe+NT2MhKZxtuezcB4vxYp3ecHHE1ZI=;
  b=UUmqpMLDQ3tuPMTgPiWOA+Cl3IhRNlzDmhbvoUZJ4OvoYk3E0ciDpdnq
   8jrg5v+AEgUgeDyCD7jWtucnfNa2gBB8syCq4GGazdGKsD7iOzEglwzrP
   ZO0v4L9GFoK6cNjSTftNG3MSBsxVgD2Q0nj6mOCaQVqh9pcYGqGoqZEXT
   jRAAQcQOCtenGfHOFZreF6Cyg08iqE+lk+qkqJkNW3BHRHZ7PpvHkkAwc
   7FWhJBcDoWf5mvYRX7oWlxVw7lin3T8CMn8a2mXoY+ZKjcFCUGxkUPhTH
   GVZhfznSAj7Fz3RubPUoItYIuVgtwxhO4U2/npLMs3DVHiAssbNa7WU5O
   w==;
X-CSE-ConnectionGUID: FUPg5tphTfym0QJuqjp8IA==
X-CSE-MsgGUID: DPJuKz/4Qkm6T7TNdZ2E6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="722798"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="722798"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 02:41:45 -0700
X-CSE-ConnectionGUID: xMiyg2QQRXmvKWqJhq5UDg==
X-CSE-MsgGUID: 0Sv6BBNNSAKAfJmZaJH/Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1327085"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 02:41:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 02:41:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 02:41:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 02:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjyCoBk6NyCQdlwZi2r2Pb7Kzi4lZf8YsfJExNg1hC09V4N0fL4ydmQ7vfA7Wp0h1Asf358dwaVGY83clh2AeSTVrW0IY/Z2YkuKSIMk4bi9IljbJtsXu8zfsB0Dy7esPur9CQjh8YF0pKyX9z7iGOT2SsScgfwHxL/mS+RP+KDVr+jAVKSwhuhUUe2clPjXdxkDIP9NcrZhUzLiOzNEHOByZK8krQCx+6Id5IUFYcC1FE8zE88t100MbyrfKgcOUoXIkyYlUnzsv6KSKY5lN8WIoCUyPTAfaXPHDnLVPmHRY+LLIBythuYj7n6F8MhUHlJ0BC2g5KruB9D2Hfeffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ4zeytAMBRSDEkSBddZ1oCwc3S3F55BgGGUDiMwESU=;
 b=g5DjfYq7+b8E1JaCFg8zNFq+Gjoax84oZLMrpsCou+657hk7tHanl68wQPFz9CFjUu7XyoFnJXZVMmkF/B/ADuDSDFizeqcmUHpnLjpBdhYVCG8fhI7k/StWz2gSHEv9yGv0oZ2aRoHO4dHppf+V53tJw3V+J8nGKL2gUssYX6s2MTCHQN2EKiLgea0dYFfg+U6GzZZ4s+BeRYqAqatB+WaYZnCDZw6uLNzQZFYkOHymQrhYSyOz4kkjnJvqNZv8ceRkefKmxEzVLj6nB73lMO93gJ1fuXfNOGSX2EnjMzefM0G3YpEu/reRP59DzRIX3+MzI9DQTLcxYZISe+1ZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 09:41:41 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:41:40 +0000
Date: Wed, 14 Oct 2026 17:40:46 +0800
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
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Message-ID: <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090831.15502-1-yan.y.zhao@intel.com>
 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To SN6PR11MB3245.namprd11.prod.outlook.com (2603:10b6:805:be::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d435b7-1b09-49f6-3b4e-08df29d75898
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 9KePg/kciY9oqjpKY1WSOLmmYAXY9i5qTaFxghkIdGEEqg8LP/Jtx+u5MKHBiR4QJa/hPpoD9wUnTGl3edAhzGIqoPkDVSDFOw9I8d9zatiQe3B6f/eEzB0EYPHaYz9/qHweHIHXS32cWIxKmAqWeUSaGm5Ml8FaBIPjc+P6XofSd/r/vdX0y9PUxNpeDwn1RghXBrMAoflB3AXzHuLfrCthVh0X2wh7alLzFHSqCBqwCQKDrgSc86jcNiGLBZ8VsXqUDqWSLumHjeRdg/NyU2S4tqkgFUWq6TqpFnXJkoY1HJcZEFI2r1WTs4nZ2bW0bAaNUpQtZLo3MpA/qAyO0h066XOB/VoU6qPghH47jMOiK3XSLdbcOlKddzEgfTXSID3q36gzC/YnXV5UXmIKebz78wFqWFBmzoT+5SpPqfJDzAEDS2xeP2h+LOKPAmcQPjb4lQbNUU/IWue041kEZF+MLBInncEAXYpSNWg8KZGEGPXrgmch4z9QN/Gei7bzLzK4H9pVyhQ2QaRnD0qLwMm1p/5N1P9ub5AU3zMOy1/cNS29YN7P8ykVCfsD6Fe6rZamJL7qbuN4fZJUv6C5HBz1WQomVSYtQQdovteb+xcw9iZ4JMkA9Ps875+3COcb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6HbrSeVIHkvIgnlcE1r7aw3YOcAbq8C9TKUXJUMjMFDpLNmzuhg8oZN7EG?=
 =?iso-8859-1?Q?RdWafxFf0hBlOZfW/mbBemBDcfwlIh3PXPz67bfa5XNvHb2nY1DukdQmeX?=
 =?iso-8859-1?Q?qpmTsj3BqCw+2p0AuEdeh0vbX7Z3u3x0jgYv8h5neITeSb8qsww9McxQqw?=
 =?iso-8859-1?Q?sDtZ9kGawBBX33/dnA4xtb9aOceFXaZJASCfm8zatYKVY8x80up63G41nA?=
 =?iso-8859-1?Q?tNGiFREVTj2+Q4LY4c/nDNSFsY5pwBk1f+JW1+M8Ggr6HP5N8al1PJYR1d?=
 =?iso-8859-1?Q?1Ugi8pVwzGy99A7DkFFz9CDeO/reLlfsnuolSPA6+ekq5TeSK81t3zCslU?=
 =?iso-8859-1?Q?tAcAOD7hD6Pa2OCYhaaoBI0aby0EuSrSfizjVpr1Q7QvLs4QWkKRJ9ICRu?=
 =?iso-8859-1?Q?5DqBRdr0mblVBjR9gWxTYqeN+jNm97HIASuWbbW1HIhZo3p/uv1CvFdMPq?=
 =?iso-8859-1?Q?a6eGgJvX2W+BcWQS3M0nOMOPKuXMRb6CUKPej6znOwiFTMK5rjU+aXF+G/?=
 =?iso-8859-1?Q?EoQ04ugTPk3cWuwXkGcKJmtkUCTcHUAnjNBLkJVzsglZIaBJnbv7pHNKnd?=
 =?iso-8859-1?Q?XKStN1b9fslvYcjsEqysdR1/7LYxBRmnGKuYxhIhJENYP5Z2ctS+PsZ81c?=
 =?iso-8859-1?Q?Xafyb4xKpSQwTkIVjRzOo3u4pHmlN97bV7TrFbanP364RBwkFm2LNDMgyj?=
 =?iso-8859-1?Q?7y3UcOCYc16Peqty16ZQMNjHMGdFl4TedkAGmOJRT87QcbIpPFkAmB5Wgm?=
 =?iso-8859-1?Q?mGHXMpbNaxZcpN3BAi2qf9kL1zd2Oo/VMjgzNWI5NfuD6yqJgDiUNGaah+?=
 =?iso-8859-1?Q?LQuWqydI27yRxFtb6bPRuyRfqn5p48S6G+LBobJqzctw0CwaQStt716reT?=
 =?iso-8859-1?Q?+DwmRt6HxkXGqes1zEqLnPtsSkf41xcTMvtD3mQGGlpJy3FoTaculJqXJp?=
 =?iso-8859-1?Q?nGv0p3oeG6lr5K6tAMDEuKBS/DYAhS3OkRE5o9t3y0M2s+UvfWjJ7N+4de?=
 =?iso-8859-1?Q?QVqdoEEaJPli5RB5Coig7fl4q2rGpVHOpVSt9J3Oi4cg7VR2TLXVYdx2+z?=
 =?iso-8859-1?Q?m8ZLVcW9W6f4Dou7ZYweGwoJOx76ehukjC64efABQUkboW+qv7iGMpc9MK?=
 =?iso-8859-1?Q?8hLmoy7Y2kK4dWNwUaUxsv4kmS+NOwd75x3llJkirw8zpnwrCygUcm8j9X?=
 =?iso-8859-1?Q?9OQ8+s54hahxuSWNU11trakqAdhdl1CqrLi4VqJm9sB+g0novUWRW4llQW?=
 =?iso-8859-1?Q?91FDZf/mfjCVA9h2uIqnAyiAv2qEgQOxw7lPSymr1AMfL87U09Tz0Xn+UQ?=
 =?iso-8859-1?Q?Yra41OGAtxZJMcm/IcfIb5xU4qj6iCFjA99OG8iecAhaJ49o4WsB6Ugn1M?=
 =?iso-8859-1?Q?ueJIRospcpeKXDGfLwFoUPiAG+Qwrf67HzAw6Q5+rWd2vE5HO1IDxe+pi0?=
 =?iso-8859-1?Q?XU6jN/5B0K+QaNmzeFxUlOmiecybdDW+2+npYpPBKum0nTwV7m4XCoO4aS?=
 =?iso-8859-1?Q?y4vn9s+09x8hxfFbKh4NSXJGXp9Q+O5u1KlTsD7l+FbA4v1l098CHPdgAH?=
 =?iso-8859-1?Q?8PNsR10piC22cf3fzRjGuPl6teVDposlLzk+KS9uNa9VHCkxkhkpAmpFm3?=
 =?iso-8859-1?Q?yAkquadraUdxX/p4VvIBUwXVV+ckYdNcoo5suoU9R4t83RJQnSgEQRELrd?=
 =?iso-8859-1?Q?iBQ32pQYXClCaamK/VB8qMJpaxmAkTNz+ZTzv2sq9YAxCDKZbERBlgYh2a?=
 =?iso-8859-1?Q?IU+V2XMe03xBdvsSb38gIEuXhNUbA4diR1iz1mJJCdXLI10RmTck6Qo4st?=
 =?iso-8859-1?Q?U/RKctSnFA=3D=3D?=
X-Exchange-RoutingPolicyChecked: G+AKAafK4/wDhLoy30oHZzghRycMedUknvJAJFIVBdeREfyyHW4lYrWZCqZgdk29xD/Xm6bTTNI85f82wBk1g1xii3XW1eSCByOepHYmEcSgfBSNaKX/QfQfl0Kbub/3+C6lfMSMArHYD/uuNdOakUXzFtljorsvOD1Zr7mNuKUjoYo87wxkIDQ65lOoBSxXxFJ6G3qUmgzqZBD4AtTNr0yaUv01F3WH6+ezIAoy4zf/B9MBbjpqwQ49z7TBiK/LMTIQ8YgVK7U0GIZqBt9sdiltcJNIzjHBUJWbyAX2IFfgk9OX/xGqb140V3/eOdIbSKFnb4gSEkfaSK6IJt1GNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d435b7-1b09-49f6-3b4e-08df29d75898
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3245.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:41:40.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+nQkKt8r3nVkKEs2fNyRi0bSNpCT9U2CJuaRSBPAcyWW3dWO+ZbpDdSdIXJzSOBdZd0cEjhmBtbBG0Be7o8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 06:16:46AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-10-12 at 17:31 +0800, Yan Zhao wrote:
> > > we don't need to support anything other than 2MB, right?
> > Yeah, with tdh_mem_page_demote_2mb(), I'll hardcode the level to 2MB here.
> 
> Just to be sure... We don't need the level arg anymore, so don't need to warn
> about it.
Got it.

> > > > +	if (WARN_ON_ONCE(alloc_pamt_array(dpamt_pages, pamt_cache)))
> > > > +		return TDX_SW_ERROR;
> > > 
> > > Why handle this differently than other pamt flows? It also looks like this
> > > warning was added since the last version I saw...
> > Right. The warning was added since v4 due to the internal review.
> > 
> > I added this WARN_ON_ONCE() after alloc_pamt_array() fails based on the
> > following internal review comment: 
> > "Hmm, so this makes me wonder, what kind of error do we want to return to KVM.
> > Does KVM ever expect this to fail? We handle PAGE_AUG failing, but can we talk
> > about how KVM will call this. What kind of failures does it want to know about
> > and what kind of failures can it do something about? Otherwise to review this
> > patch you need to look ahead to the code and understand the KVM MMU. Is it
> > possible to give some justification in the log for why the error exposure is
> > the way it is?"
> 
> I don't see the connection to turning that into a warning.
Oh, sorry. I was a bit rushed with the last reply.

Turning it into a warning was because:
1. defensive programming:
   In KVM, kvm_mmu_memory_cache_alloc() triggers BUG_ON() when there's no page
   in a cache. So, I think we can make a warning when there's no page in
   pamt_cache.

2. your previous comment to "level != 2M" checking:
   "Hmm, this could all be a warnings I think. I guess it wades into Sean's new
    tendency to survive MMU errors. But do we think there is special risk here?
    What horrible thing can go wrong? I'd want a justification for why we need
    to handle this bug and not just report it via warning."

3. Sean's previous comments related to "two WARNs". 

> But besides that, please don't silently churn the code like this. Especially
> when you provide a version log, because it kind of implies that nothing else was
> changed.
Ok. Will do.
(I took the easy way out by only listing the major ones, as the changes from v3
to v4 involved Sean's v5,  many internal review versions, and changes due to
rebasing to the latest DPAMT).

> > Should I also add a comment such as "The caller must ensure there are enough
> > pages in the pamt_cache"?
> 
> I think it's obvious. That is the whole point of the cache.
So, are you suggesting just propagating the error to KVM without the warning in
demote()?

> > 
> > Link: https://lore.kernel.org/all/aYoS45AZNY0rUJQD@google.com [5]
> 
> It looks like Sean was saying to warn about subtle contract breaking. He also
No argues. Just want to ensure I can write the code correctly in the future:

If KVM invokes DEMOTE without topup enough pages in cache, is it a subtle
contract breaking?

> says in that thread:
>    Document what exactly?  Most of this should be common sense.  E.g. we don't
>    generally document that pointers must be non-NULL, because that goes without
>    saying 99.9% of the time.
Here are more background:
1. I asked in https://lore.kernel.org/all/aW3G6yZuvclYABzP@yzhao56-desk.sh.intel.com:
   "
   BTW, I have another question about the SEAMCALL wrapper implementation, as Kai
   also pointed out in [2]: since the SEAMCALL wrappers now serve as APIs available
   to callers besides KVM, should the SEAMCALL wrappers return TDX_OPERAND_INVALID
   or WARN_ON() (or WARN_ON_ONCE()) on sanity check failure?

   By returning TDX_OPERAND_INVALID, the caller can check the return code, adjust
   the input or trigger WARN_ON() by itself;
   By triggering WARN_ON() directly in the SEAMCALL wrapper, we need to document
   this requirement for the SEAMCALL wrappers and have the caller invoke the API
   correctly.

   So, it looks that "WARN_ON() directly in the SEAMCALL wrapper" is the preferred
   approach, right?

   [1] https://lore.kernel.org/all/d119c824-4770-41d2-a926-4ab5268ea3a6@intel.com/
   [2] https://lore.kernel.org/all/baf6df2cc63d8e897455168c1bf07180fc9c1db8.camel@intel.com
   ".

2. Sean replied:
   "Why not both?  But maybe TDX_SW_ERROR instead of TDX_OPERAND_INVALID?".

3. I said:
   "The reason for 'not both' is that there's already TDX_BUG_ON_2() in KVM after
   the SEAMCALL wrapper returns a non-BUSY error. I'm not sure if having double
   WARN_ON_ONCE() calls is good, so I intended to let the caller decide whether to
   warn."

4. Sean said "Two WARNs isn't the end of the world.  It might even be helpful in
   some cases, e.g. to more precisely document what went wrong."


> But besides that we are trying to get Dave's ack here. So I don't think
> extrapolating a comment Sean made is going to suffecient for having code that is
> different than the rest without explanation. So let's think about how to get
> that ack. Obviously we should take Sean's input as well. But while we are on the
> maintainer boundary, we can't call it settled.
Hmm, yes.
Not sure if Dave likes "two WARNs" or not as Sean suggested in
https://lore.kernel.org/all/aXzPIO2qZwuwaeLi@google.com.
He was in that thread, but maybe he didn't see Sean's mails.

To avoid extrapolating, what about suppressing most WARN_ON_ONCE() in demote()
in the next version? (see the code at tail of this mail).
 
> > Patch 2: - PTRS_PER_PMD to PMD_SIZE / PAGE_SIZE,
> >          - atomic_cmpxchg_release() to atomic_set() due to the spinlock
> > 	   protection.
> 
> Can you explain more on this one? I missed it.
There was no spin lock to protect DEMOTE SEAMCALL execution, so
atomic_cmpxchg_release() was used to ensure the original refcount is 0 while
updating new refcount to 512.

Now, with the dpamt_lock protection, atomic_set() is used to align with the way
of updating refcount in tdx_pamt_get() and tdx_pamt_put(), though the atomic_*()
version is actually unnecessary.

Or since the atomic_*() version is anyway unnecessary, what about adding the
asserting of 0 like this?
	WARN_ON_ONCE(atomic_cmpxchg_release(dpamt_refcount, 0,
					    PTRS_PER_PMD));

> >          - added a helper __tdh_mem_page_demote().
> 
> why?
To make the helper focused on invoking the DEMOTE SEAMCALL, without dealing with
locks, refcounts, page retrieval, etc.  similar to how tdh_phymem_pamt_add()
relates to tdx_pamt_get().
Do you think the helper is unnecessary?

Does the following implementation look good to you?
changes from v4:
- dropped __tdh_mem_page_demote() helper
- dropped "if (WARN_ON_ONCE(atomic_read(dpamt_refcount)". Used
  atomic_cmpxchg_release() and WARN_ON_ONCE() on 0 original refcount.
- used PTRS_PER_PMD.
- invoke reinsert_pamt_array() on failure.
- renamed to tdh_mem_page_demote_2mb() and dropped 2MB checking.
- dropped WARN_ON_ONCE() for DPAMT is not supported, alloc_pamt_array() failure
  and SEAMCALL failure.

u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
                            struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
{
        struct tdx_module_args args = {
                .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
                .rdx = tdx_tdr_pa(td),
                .r8 = page_to_phys(new_sept_pt),
        };
        atomic_t *dpamt_refcount = tdx_find_dpamt_refcount(pfn);
        struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
        *ext_err1 = 0;
        *ext_err2 = 0;
        u64 ret;

        if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
                return TDX_SW_ERROR;

        ret = alloc_pamt_array(dpamt_pages, pamt_cache);
        if (ret)
                return ret;

        args.r12 = page_to_phys(dpamt_pages[0]),
        args.r13 = page_to_phys(dpamt_pages[1]),

        /*
         * The dpamt_lock is used to avoid contention between the
         * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
         */
        spin_lock(&dpamt_lock);

        ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);

        *ext_err1 = args.rcx;
        *ext_err2 = args.rdx;

        if (ret != TDX_SUCCESS)
                goto out_free;

        atomic_set(dpamt_refcount, PTRS_PER_PMD);
        WARN_ON_ONCE(atomic_cmpxchg_release(dpamt_refcount, 0,
                                            PTRS_PER_PMD));
        spin_unlock(&dpamt_lock);

        return TDX_SUCCESS;

out_free:
        spin_unlock(&dpamt_lock);
        reinsert_pamt_array(pamt_cache, dpamt_pages);

        return ret;
}
EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);

