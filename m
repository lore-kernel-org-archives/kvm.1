Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641F4C9010;
	Tue, 19 May 2026 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192346; cv=fail; b=bL+iXoPJFOuGbhXW5GfAz/9y0HnSnJ41FIB0GBPecC6WFntm2Tqnr25/2yrFFm+NBhVaZNZivx1SYg5LDH17Sbfv5y+umtIGMy4oAurmCtAb20XanSqLMQOc7/I6lHVFNQltZ5WvV0w8Y1t0BeM3AIW0G6XI/b79wsluFFECfz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192346; c=relaxed/simple;
	bh=EMXf3F7Dm4shnz7tG9sTCBOX0DSnW19Bh1mqpjiruFE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I9yJzFjp4q1OrV7R37VfPM8oJ12fm5+0HqdwVHpL8vTpgt14wtXr2UFTG9h+RN4s8rzDXo8AHPDMLX2cAv5tZWEDjph62PfVSjbocjrFKRR7rIi8DcjKeSu526USddmstPZgbWN83ny+OXitU2bKJv/1cvjl2y2MDjKw5MfomC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYdII4dD; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYdII4dD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779192345; x=1810728345;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EMXf3F7Dm4shnz7tG9sTCBOX0DSnW19Bh1mqpjiruFE=;
  b=OYdII4dDJoQ8lWb+m97PCXnQEB0OVIepiZU89WWE8DBqcIQX0SpgsOBg
   Pj96hCeRDBeFYKBRcIJZ4kHYu6sv6jYnA+CfFjlqE9X1VaeKom7U22RFj
   gzQZMevK/khOfXqyFFy3+jSMRMZkbiK9Xw5/gjzaEw1rPUDe0Sa3E/kwl
   aB+ZfhUxN2py8WUhl2+Hf4wzhCDG2Z5j2HWD59qArMPZLNVJL7dAd5QjN
   PsNWu94eYcfz7dNcAdu8efl+HfB7souBQ+WbSeMEwPCytjMVQBzXTr8BP
   boQ3NiscgVaKUWiTujUaJJghhCtIymmjJE8Jn88Qys2Pnmgol8UFUsrFP
   w==;
X-CSE-ConnectionGUID: ZfY3Lyc4Q4We5afoNQsS5Q==
X-CSE-MsgGUID: VlRkPUJaQA21sogAMTRoTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80046973"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80046973"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:05:44 -0700
X-CSE-ConnectionGUID: RJBe5A5yR8mlnerasx0Dog==
X-CSE-MsgGUID: ZL5VUbpLTJOfZLqsxmLmDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263531785"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:05:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 05:05:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 05:05:42 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 05:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxXSpb0ea2/SWmolKi+UnXOCbK9S2RaKBDXFhyOdptGdxtbvde9SIiCopfSq5hfzGFAv2GSjtLSG3P4FwHRB+P7eClHqo/RoSIQmYocvrlOFgiRwQ6UPmCVHZXU49BzHn/dWNbnr6AGOr2jOHbKmraf8G6uyBKAuWI//CSaYwzIB7i1+9qkf2AYrUz7G5zD2P/CZIvqRG7uJwZlfqEtr7SPRKOzVKXUcU+an4qOclkMMTMga0B+FreMeQgGBJE4/IvFRGplfREnKnScP4D/VOhMBUETbBmjIbfkFkfoTVJ764P/xuUK2mxuaUVMuYioMvwvPSY88bbT2NqutoXp7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCgFikBPE9wk/1S0KbJsHwlgwsSayiqPtZRTpn+nLqU=;
 b=d40f5SV6gCeioO1LWdivbK3OA46h3+iJ/D/apcFZBXal8GBTqOhEL8UiPX7DfG741dW9Pe1uzqOZAv0Wl2hVH3/8O7vA6bcfVzg1vvke6vrH2OZlbivpCYkOB9+R+gakjYJT2mpLznD0NDwoPYBAKRb3MqKYfkz6kJze3d7dGGbTHXlrJ2jsXmzSfsX+CJBeF0UxC9QxqwfHXxQHO8ORq94gaA8qqLIw8uOmGl1sfHtvpLDV7jM9PpUP+bE/uagzhvLIyYkajaQhTX1kf38a0NS53jaf44ki6cqRSPF2hA4+sPQZtE8XfhTYPsFCkviOwUPSGFvmmTDVK+2wHMP5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by DM3PPF607052E81.namprd11.prod.outlook.com (2603:10b6:f:fc00::f26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 12:05:35 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 12:05:35 +0000
Date: Tue, 19 May 2026 20:05:22 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 14/23] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <agxSAsUvgcHj/Ywl@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-15-chao.gao@intel.com>
 <329d3811e8acbfc2ecdb1c7ba443f23161329e2a.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <329d3811e8acbfc2ecdb1c7ba443f23161329e2a.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|DM3PPF607052E81:EE_
X-MS-Office365-Filtering-Correlation-Id: 039ecc48-6277-46a5-0428-08deb59eef04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|3023799003|4143699003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9bAOJ3/M57M+ey4dBz91zwPh5Xoh4qt7wNkt/SD/bIJf5GPiOjehEvB6xVZv9V68wAkQdCqKA9t8+5RrY9nyYv92sAskRMuZfgsatt+SAuY+b3xUgTpE3dcpbkayf6m8iThp0FnGTi9bb8p5jvuY19ig89TSnjXOCPobTAixaa3heKiBHZS7pp8Oa5oJ7bIkp0jpVOrJkzajtS5pH2fvbsu8Vq+s0FHaDKUC4bYgLDex7K2KFbqSaWjY2uxp17Je8Djgo++RT8ktlEYV/FxFT7JcTseRbVIVPpn6ls83Nd1bjYO9NpTp9KSiTRaw682xZ1h4lwlqqEoViBSVGDlxOaPectJwxsUVaU3/mfzA4iGTzSRQOLRiRnovntOQ40bASTCB29dNJlzRv+ySMpWrFau2ouGF/zIqMsPj39yXUeIzqkC5aFHAmoDO2JTznKpCbdNWbDTE+SWxfrty5yt77bPC07VpByP3Sc/kPpAlEvyU7aONg3F7S/9itjSofUMtXESeFnFra9MExwSlAKjfZZN2iOq34Zr+cFFlXdy0s1b5EhSk7ktf9Ndt+5owBGIhLhV/32+AG8bCJQd+Glvp/ZpnGzmH1MIlvzO4RM9L50PnN/2/NQVQ0oZ9yhWS/iBoSawb49a7G2khFpyq05joYnB/ntJ3SeAwwNIxanxyKtN9+OWs2cLDQ0JUKcrQA2Lgt2XLSbgOfTztSCg5qazz1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(3023799003)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RnNb35HKt6Kn/epZLQbMpYWnsu1oJU5MEbYLBnUDknf8ATjTER0+9e7fgn?=
 =?iso-8859-1?Q?mBonpBjfBKn9h3+0HQL/naoiDAFVBAdGdTS6NccVbErNIkFdaG/Y2Lc+so?=
 =?iso-8859-1?Q?8k+w5Tb0jYGP2nEKpUSxZtLq4pW6wZ9WCG6nYTNFjHEp23HocQrOfxsOao?=
 =?iso-8859-1?Q?uGv8gICPaq8SsDhf0DIoNBxD+qe4Cv4sfwO6Ym8HoJTA6SUJRgFglnOcgt?=
 =?iso-8859-1?Q?o0T4eobGT5yBfTYMCm87iGn+peOES+crYQwJ2dxILsTzZpQa9/wVJSMfw6?=
 =?iso-8859-1?Q?JauOQ/gpc22ZWJb7D9SnIADZIqdZelaB+r3I3wjui8KVE+ryNlEWmGzlwW?=
 =?iso-8859-1?Q?RGiGLx1Cf19R8fy9t59WgcdsOSR8x92Ew5scPobPDrthu6MJsfyUyiGFCW?=
 =?iso-8859-1?Q?1VlhX311195DMWhf+v5haB4bgkllMOD4UzfBKwH/3nUW56Xn3tt7Wt28/I?=
 =?iso-8859-1?Q?+lhMrfSNbcGrsekbnNxKN2DyfgpQAD9eKaa0pjYU1WhWtLnEZ932a2UUsT?=
 =?iso-8859-1?Q?Y9pvlJXAjNqp8MacviAPKMl8tW0nnxTBRLOh9JCA1DUY5Dv3KKsc+bpWjf?=
 =?iso-8859-1?Q?n2lnTa1I2iRE8N/fvEhvpT//cg/Zc9P59MjfDrkZ6WzEsgj0reCIwi8N9Q?=
 =?iso-8859-1?Q?yKnnFRZWCVdAuZjXTpqUn9ZBvFU0yqfY79u7a+u+0BdQR2hRyXw49QyWOH?=
 =?iso-8859-1?Q?/xWUEqgzws4CJb9BRNLfW/MzpMDuqa8DLGp7wAgrg1On25PtslUSQ6i7yq?=
 =?iso-8859-1?Q?rOkBsAQuhJDu2z9sKfXlLcbc2HPvpSxq/9ZTpAPzJ4mSrk9CRFy0aWiDMM?=
 =?iso-8859-1?Q?qeq7cmhepHI9vMgApVmpJTHsEL97fRhYJWxRl18UP71LcATpZi+IQ+REvx?=
 =?iso-8859-1?Q?npE4kc17mPoiur3vaLLjmqiD7Sv+pOLr+hZz5JoXH9IU4CMsTs1m2BkPIg?=
 =?iso-8859-1?Q?kHl3sjJlG4joad1cxjWctPdlXH8MU+1Q6X2PzRq0fGRNeomr+jsU/wDCK8?=
 =?iso-8859-1?Q?ZdW+jB0v2iZjiTlVR6y+6p+tO4C/Iemn/WjS7C4M/fvGhgu475tYp+soLu?=
 =?iso-8859-1?Q?pHagbpKe1fIZYN9LFMvoBFLv51kk3AkBkJlCb17PyXN9KG9h8spzY/WnIp?=
 =?iso-8859-1?Q?rKHBSBZerxhQXVwLOK7GUwRl6S17cc990oy6Zql9LOEh0gnQw3ahEtVR3+?=
 =?iso-8859-1?Q?RTSADZVCQXTzT6V0C/KxerFahlivCc123b+hz4d3pgllOHnS5HhZrvq512?=
 =?iso-8859-1?Q?gAHVg84hsxe8PO/xFkl4hTYuMXp10gFb2kLbwVDCVXlFSa+4LlQfkJ0/xF?=
 =?iso-8859-1?Q?ZZZuvp7WqO+jflNxfAg9x71SB7g5oGnCtqjWknLGP2O0puDSusZ8W52e90?=
 =?iso-8859-1?Q?WFqhMqZPrWZ/n4CwVF3ksQljIWrjxTgybp36lMV2uXCb/25RQFdaZy1zeg?=
 =?iso-8859-1?Q?5f5Gdrz34jOHN81IaFPp9FBStiYOUqPhFXLKZuhVtbiEUq61n3Q2nuNNMe?=
 =?iso-8859-1?Q?rL57yVcMO9cnKNHmzKMXaVT+hJzsFUF6TaDxPc5xGnVEG5uoaKLE73Ua7E?=
 =?iso-8859-1?Q?rizQcAme0KDf7t7MgHSZ/DTAndOl7Qw++aiUGGP5sfqrk0Fp2EvvMRAxkL?=
 =?iso-8859-1?Q?G0xGF/ecuU4q7t+dLtq8SeWafNo1cHBx0YVkCFCHYcZxYAOK1CkNqRPadI?=
 =?iso-8859-1?Q?cjS+ZS/Cvz5yz0ktLPbInV1OO4ZHyEbTBb0kvBg/o7sJ5YKVsqWxx39u3b?=
 =?iso-8859-1?Q?Y/HDh2tzSZ5HA7YlO7/VDMEKTIhoUWKC6mA217hwvW6AUGcQL9wR2PqS4L?=
 =?iso-8859-1?Q?RHQkka98LQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: N+uoLEimeVoA9evCB4kVBqlVzmV93Q4zCuMgSHqVdD1bpKqXgmowoUQ0e09HOcuwBlNip7EGNvg4MV2oCRS2+c/h0hBAlTgziDQUGVLls+Vvt6froEH1eVVI6A99bdBCOmPt5Bu5vjgaIpfxR5Sw9MnIl59s/jR98eVyyLw8L0S5BcPLu4WRQYZ0SElcaxKb/GOcFT9xr2R/SrmO+Hk8NzdyfoiQm6G9aI0Z+0wVkC3NveK3r7vajjeyl80xh6CHCDleN2WOf7DtbCCVHlPXTHbYGByN0QllsHWOjjcelSVKUxfX0lLotcdYAl3ouTg3Hf5j5muhlKirCUCl1QvFGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 039ecc48-6277-46a5-0428-08deb59eef04
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:05:35.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmxLeVjmgX2QSiYdBvadvdKqMc5N1lwxbWypZkzBTlZZJsZ52vMtLd1TGvQ5Q8kxyoNEsulqYBto6nRSLsXh5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF607052E81
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 11:00:54AM +0800, Edgecombe, Rick P wrote:
>On Wed, 2026-05-13 at 08:09 -0700, Chao Gao wrote:
>> The first step of TDX module updates is shutting down the current TDX
>> module. This step also packs state information that needs to be
>> preserved across updates as handoff data, 
>> 
>
>kinda reads like handoff data is an existing term, but its the first reference
>in this series.
>
>Maybe packs state information that needs to be preserved across updates, called
>"handoff data". This handoff data is consumed...

Sure. Will do.

>
>> which will be consumed by the
>> updated module. The handoff data is stored internally in the SEAM range
>> and is hidden from the kernel.
>> 
>> To ensure a successful update, the new module must be able to consume
>> the handoff data generated by the old module.
>> 
>
>Is it too obvious thing to state? Above you already say it's needed.

Ok. Let me drop it.

>
>>  Since handoff data layout
>> may change between modules, the handoff data is versioned. Each module
>> has a native handoff version and provides backward support for several
>> older versions.
>> 
>> The complete handoff versioning protocol is complex as it supports both
>> module upgrades and downgrades. See details in Intel® Trust Domain
>> Extensions (Intel® TDX) Module Base Architecture Specification, Chapter
>> "Handoff Versioning".
>> 
>> Ideally, the kernel needs to retrieve the handoff versions supported by
>> the current module and the new module and select a version supported by
>> both. But, since this implementation chooses to only support module
>> upgrades, simply request the current module to generate handoff data
>> using its highest supported version, expecting that the new module will
>> likely support it.
>
>Hmm, "likely"? Is this trying to justify the kernel's policy? Dunno, stands out
>as weird to me. Like "this will mostly work". Sounds incomplete, rather than a
>reason of "this policy is the optimal initial implementation" or something like
>that.

how about:

... But since this implementation only supports module upgrades, simply request
handoff data from the current module using its highest supported version.
That is sufficient for this upgrade-only implementation.

>
>> 
>> Retrieve the module's handoff version from TDX global metadata and add an
>> update step to shut down the module.
>> 
>
>This is small patch with both things, but it's almost two changes.
>
>>  Module shutdown has global effect, so
>> it only needs to run on one CPU.
>
>I wouldn't think having some global effect would necessarily exclude having to
>run on multiple CPUs. Or at least I don't follow. Is it a TDX arch thing? I
>guess it's ok.

Yes. This comes from the TDX architecture. I will just say in the changelog
that module shutdown only needs to run on one CPU.

>
>> 
>> Note that the handoff information isn't cached in tdx_sysinfo. It is used
>> only for module shutdown, and is present only when the TDX module supports
>> updates. Caching it in get_tdx_sys_info() would require extra update-support
>> guards and refreshing the cached value across module updates.
>
>Instead of being a "note", could this be just an imperative: Don't cache the
>handoff information in tdx_sysinfo...

Sure. Will do.

>
>> @@ -214,8 +216,16 @@ static void init_state(struct update_ctrl *ctrl)
>>  static int do_seamldr_install_module(void *seamldr_params)
>>  {
>>  	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
>> +	int cpu = smp_processor_id();
>> +	bool primary;
>>  	int ret = 0;
>>  
>> +	/*
>> +	 * Use CPU 0 to execute update steps that must run exactly once.
>> +	 * Note CPU 0 is always online.
>> +	 */
>> +	primary = cpu == 0;
>> +
>
>Where does the term 'primary' come from?
>I'm guessing that the global steps must
>each be run on the same CPU? Is that right? And we just pick the cpu that we
>know much be online? Or can the global steps be run on different CPUs? Or they
>*have* to be run on cpu 0? It might be worth some comments explaining, depending
>on the answers to those questions.

"primary" is just my name for the CPU that runs the global steps. There is
nothing special about CPU 0 beyond the fact that it is guaranteed to be
online, so it is a convenient choice.

I can rename it to something like 'is_primary_cpu' or 'is_global_step_cpu'
for clarity.

how about:

/*
 * Some steps must be run on exactly one CPU. Pick CPU 0 to execute those
 * steps because CPU 0 is always online.
 */

>
>>  	do {
>>  		newstate = READ_ONCE(update_ctrl.state);
>>  
>> @@ -226,7 +236,10 @@ static int do_seamldr_install_module(void *seamldr_params)
>>  
>>  		curstate = newstate;
>>  		switch (curstate) {
>> -		/* TODO: add the update steps. */
>> +		case MODULE_UPDATE_SHUTDOWN:
>> +			if (primary)
>> +				ret = tdx_module_shutdown();
>> +			break;
>>  		default:
>>  			break;
>>  		}
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 1621695d7561..da3c1e857b26 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -321,7 +321,7 @@ static __init int build_tdx_memlist(struct list_head *tmb_list)
>>  	return ret;
>>  }
>>  
>> -static __init int read_sys_metadata_field(u64 field_id, u64 *data)
>> +static int read_sys_metadata_field(u64 field_id, u64 *data)
>>  {
>>  	struct tdx_module_args args = {};
>>  	int ret;
>> @@ -1267,6 +1267,23 @@ static __init int tdx_enable(void)
>>  }
>>  subsys_initcall(tdx_enable);
>>  
>> +int tdx_module_shutdown(void)
>> +{
>> +	struct tdx_sys_info_handoff handoff = {};
>> +	struct tdx_module_args args = {};
>> +	int ret;
>> +
>> +	ret = get_tdx_sys_info_handoff(&handoff);
>> +	WARN_ON_ONCE(ret);
>
>Take or leave it:
>
>  Why not just WARN_ON_ONCE(get_tdx_sys_info_handoff(&handoff));
>  And we can drop the ret var. Save 2 LOC.

Dave had a different preference here:

https://lore.kernel.org/kvm/8b9d7fa7-6534-48e7-a4fa-c21260b1c762@intel.com/
