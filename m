Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D7344DA0;
	Thu, 24 Sep 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234931; cv=fail; b=COmIV8Ffn31nwJovekIO4/g1zTxizdVYcYEUDV3YDEfDNcz9sshWCmY3DNkKUymy80vsJYlZZH/RghpkzbErTJoswgUqSChi3hlP2zwWJGfGlsBS2aYudidLot0fAScrvXzhFC9QqEKJsNtC0RXUuCHvMOG7+rpYqA2B0HH1PAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234931; c=relaxed/simple;
	bh=jwyjfhgvnOVG936gmtTewCf7s55PYHeLy/KyjSLskUU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=enyRRSFfoZ3qJCbiXPIlGugMkYuPEa9VnL2yXGJn0Bwfu3OL+/DK/IJD1WgQPAPxaVlR5LCnSOQLk4g8zOKc093xQpsb1cPp0hvvE7zDgsPxXUxDfaLTqhU72SW2rtTNaDM59QOZDTtBznRv16R6q9gWE0Ku6yqMGSHNzlCHvZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcBBHLBW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcBBHLBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790234931; x=1821770931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jwyjfhgvnOVG936gmtTewCf7s55PYHeLy/KyjSLskUU=;
  b=EcBBHLBWUA98xvRJOQodK2F8+zzy38RxRh4vk26V3OSeFvB1J/q27w6p
   O09UGsLhg1r36Os+LliPq13WCRZ/FxokQYF2W5hob6xl+WxKlzCl7dul9
   puCLSqhoaMOUc6DhMkvfEWLryaJTOMlEwbH7QoK6Uds+OondJtQzOIIyb
   5/jYJLOKbuJddDsNVal4y0bmZpZf3K/1/EXGC8BRyT1kJ/7X0PAukF43q
   N9FkiPTZZA0UF91WqQ+xbHrR35mdQ9sQwaRSjEHCLqqWeuLhdCDY0sm1a
   y/JvikU4gWCfgwgN9suSyNNCY+fGOaXaEyFTAb6qmEh/2waLEnzlWQwXT
   g==;
X-CSE-ConnectionGUID: 90E95nH4S7SaBHRoGR2caw==
X-CSE-MsgGUID: ne15/bJ5TuqwIHeYUgmA7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90035804"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90035804"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:28:49 -0700
X-CSE-ConnectionGUID: IzJ7IXfGSYys9vLlpJneQw==
X-CSE-MsgGUID: dyU0PmSnSdmi7SrqX3noVA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:28:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:28:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 00:28:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:28:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyAJ2nvUV1twB7/txQa5fjyF4aVePNKJHiG2GepE7ttubm0IxoIFCGuy89JA2xMZ2GmXAJSkMv5X2IqCiKfW4Pir26p/k6EpjRbomMhuzK6h8ZnFX67qYTyL+KbM+Lv9YNP4zxYsd8DLExr0nJvUvft7OuVn58VkspUgUpQj6GxBN6P5wNT4JtcqELpazHZyO5hBTvfg5gF77Bis5UnsHFl/631w5RUNaAqYIWnu6GadOqbkILdelPz2D/XAcDqrXhYjUuEtStw4EBV5GJ6rq0hdPBPxiuplpq9walGVwq4txwbTnxNmKiSkksY9Iv/TyGalqib1z8hEqeNDKep/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAthdr7qmhj+17dLRLx9vZQmn++8gJVT65WgoL6e394=;
 b=rEyCQp7lufo3QUf5dZSwtXR8XOXjMfMweOHjwZ8Pa32keHQS09/sSBzpwl4bWVTUOfiLbtXsWbhxW/iJd+0DLeLPzpKrc+6ctTpVbW/Olzh17asQ+iIUVw7FgoUrZ16rZBFYNgoFpAqU1Xu5hzaP4LlCnp1O+AHx79+MMehYfBEHOgHrsk10YrwtBfbW5WZEB+BcuRSv6xNzc0c6uZ6k+T0v02b2ozYaEo4vZfyRLkMPYIThF4TqUH1gj0GuQQSE0ndpRtVA+RlpMNzsB5o96ESFYpljYOW7+vakQAZHFmDX+QLO7yZszpuA2nPN3vj993nfTTuV7f75WIVbFYZ/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:28:44 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:28:44 +0000
Date: Thu, 24 Sep 2026 15:28:33 +0800
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
Subject: Re: [RFC PATCH v2 09/10] x86/virt/tdx: Use early returns in
 get_tdx_sys_info()
Message-ID: <arTRIZSqjlmVr5Lu@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <20260918132946.76533-10-chao.gao@intel.com>
 <f3332010d452fa3466ec4fa4f6f69e0ad3ca06d4.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3332010d452fa3466ec4fa4f6f69e0ad3ca06d4.camel@intel.com>
X-ClientProxiedBy: TYCP286CA0250.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::14) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ2PR11MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 10269cc2-0ed4-4444-f838-08df1a0d76b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: wlGx73pNTbus4imgEgHByHhQ+/xqQQrtm6U8Ff1DbU1SJjBQKtC3QxqsvnGmlDnzCT1PAykXBgWZ/vnrZa3lN37wDrsFuArWf7Uv+x2mqDmnUYrfqFTY1zq7TPdga43R2C+LtzZEdt1Ct1rBCJqR/iCbu6dsrC/bBsDTAor9Jvpj7WBrdlvBaPpPHDUCmInyrmYRb008iESBzQKgjhLPeCJzj/lWvCrCgGornsO6+Lcs7a7f3yDk8d3iD0JN8J3JAOoFENTItCV/7xYJUQa+Ywpw3XADwqp17yc4ztXSW6LAkK8pRREv25UbIgd7FwgIFzJXqM5StCoYGpgva8xbJ76icBLDPydCvZ3sB/9rVe6UhmsUiye6EBBDxxPtVAjBsHNc6NwE+OPfs0n4YHMtXCUwxHyCPYfBePdWoZHDgra+C5I9gQttx+8FR3f6Ps85RpyHgdVWj57fyVkVIGBfdRbgHQPzv1bgZo86kb+dudjuEB1CJumRxwph3hfVRThWEd5ONlHhtRYrdv7Hk7kUK1Oz13/+PuN8UBNV9LnGGreVQnhPi4CbF6UNI0R7f7AXbX70gTsm1p1iHTUTfTfBj8222MlhoBQmRqJY2CZSVoqIpDacdAv5s5mMbJdOvMkNIyh9+zHEV4BNO82kjXXDM/nlm9Z3WsSVy61dsOaik7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NiypYOZPSjCzTkPmV3+lYMnOK5n/Wv9nKlZ0P7Sn5zLmfl752d1zs1ZWnYun?=
 =?us-ascii?Q?myWIL/5gMltpRvInG+1ETJ2wHdTEvQbYwhzQF9MQyq79JjFzgAaGiT2XXClL?=
 =?us-ascii?Q?yLM3tonApTLBcRyEabPMJZT6ZEaY2oLCulpN54+ajZhSe8ObLeCIocPHVQ8i?=
 =?us-ascii?Q?12hG79PObKwe/TroEEGYZy+wFvzg1RxFAXC8LBL3vkNHPP8h90WJnINBsj+U?=
 =?us-ascii?Q?XD9/KPYy2Pa63NqgdESC+MGUMV5GfxWbGoLeGhJDRDn1JfYLJfCtFjD9CnVU?=
 =?us-ascii?Q?/tpN7pGwAfBPZnqAC2rufe5FwHZqNEWLtpp/YL/Q1RnWV1/+RHqf1PeSltPv?=
 =?us-ascii?Q?W70GrtC+lKdvYdiHbxuuzTHSoHQtk0SpwKNTKUVfhTV4rxSEidTg2pTpOafU?=
 =?us-ascii?Q?6/PaakugjAy4BHgI4V5opBQzFD7mapTA8SD26bepVjS8cMioytf4WJeBrIul?=
 =?us-ascii?Q?xozdwD47l4FajlAqo/9aVFkhNF7sbkhnyD8VpyyqXZ5+QpZknFkDn12+jYfC?=
 =?us-ascii?Q?K+WuP5fOnxrhwAQNApjp0dqy7XCDS93IpHs89snSWX6y91nWHopFc9hbA3Yi?=
 =?us-ascii?Q?3vizrthyH090Fe8rBXpaBO13ckfxr8qFtNB3Q1Ad6dfYOO2ZM9SjDpuY+JUp?=
 =?us-ascii?Q?oVuzFdPsposJ8Ri6sLGd35TjF8/t1Nr27yAkvyI9/Y4URP0n4zoKlyyXwmV8?=
 =?us-ascii?Q?3UIy7Qb1T07hxJwiV1ImmDolUZ8q4ODTjlHqmuP/NCDW1VRg11PxIpHkiaV5?=
 =?us-ascii?Q?9paEtYhxwaWGOL0ztezBiHeA86bbbVHk5zHaAK3fcfgJxXQfNx8OtTZoG7Tf?=
 =?us-ascii?Q?l6k4LMusFqMCqJEhCA+VW0ds8oLJvfXqx3T6/2lZvxsIW2ZAH9tc94JoMIDv?=
 =?us-ascii?Q?9Su1xYGnMHHPLANiLPEAyut+7PuX2X1hC/Wbm7bYmf9Qc90EXRFUHdVkVR4+?=
 =?us-ascii?Q?5Mds8l6BhUHXp6tNqRpriD/KcH/zXxp+6PI0XkElf6NPRl9p+boPywAOQiLZ?=
 =?us-ascii?Q?GtkuMRw+NvHEUX1uh1iSdrOSKW4mu+xWTr1BRBIEPHO8LgYNdOAnovzlLHTh?=
 =?us-ascii?Q?1Of/QU6MFfW2Vqyvj6I7RHv2TAK/UjJ4AAcO1t/gJlG/Zianh6zj3rmsvFWR?=
 =?us-ascii?Q?6wWQEnTMiohvgeQdIAcU1N1g6t2hGuWYBn7vXx+97Ydw5IC9IxwSN2mOoIRm?=
 =?us-ascii?Q?1ieYcOyg5n5hBcvgIxhc1FQ1zArcDSWxSrNYIsLf5pLB9gjgPc5vzKoVkZu+?=
 =?us-ascii?Q?jTajw9g1FFLnMtamNC/gmHt0Mv3LkmAEBu9nfhSicTLu09wStgK193i+mkF4?=
 =?us-ascii?Q?a5K+bgHXP1doV+0OjC+u6XpxrgROr8QPIWnUP7oupT89cxm6w8bVn5iVMU8k?=
 =?us-ascii?Q?M/+Cxs7rHmB3ZTGo4zqLNgSuL2bUpuIiPbBKQJajqC7YbKY1qB/L1mIzX4Hl?=
 =?us-ascii?Q?Dk3BBP7UnS9LvkNoEBZYq32eKBHvtzEaG6FAEYPftdnGp+GpOL3bmvEnrbiR?=
 =?us-ascii?Q?bLfhx08vZ/CGnBL8vQqkmiEUbZ+eIy25Shc8hLqH2de0SVq89rR5coiVpp8k?=
 =?us-ascii?Q?1L71wxxL7DLvZsQdOmVpYoWtj+zPPzQQWCLBwe01yvoSfVcfwVRKSUGndFHd?=
 =?us-ascii?Q?gZvdXocli5YilWp7cIb9dLIGu4fi+ma7IADdhpOZ1bAHkpXnmm3Ind9QwZGl?=
 =?us-ascii?Q?i52LBGedCf9TG6g6mcj/8f2n1YLAlzqiJ8VwdXyRpomt0QucysajwSBjRyfU?=
 =?us-ascii?Q?1iyIZ+prqA=3D=3D?=
X-Exchange-RoutingPolicyChecked: PU3ZoO7jh2gwOshuyu1WayaWa3W/pugzWPDkbL/8oPlXSWntOTe7OjX+5i6qXTaL5k4POeQuw1wvJdfsXX+8pzEEojElLxNv+HQy5cOb8a4vdsWaKk4oGGOvIqVpPcxgezOlhl9dBuT32HavVQGiR10nt5+HxsWWRhi7FiGlocbNq+O/AYJ9Dh5SWbSqzLiOVR88/uevweNR45ElBTQbG1N2Qpe7AYESk/4M0bxQ5Zghx0bmp5h/YfopnJFRchhmtfVdMiIJJqfwsDeWker27h0J1fLOpM+dLP3IpGM5MRab9Nh5NdJXJns70tBH0S3M96EuV5WNNZnZ6iUEKUMeAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10269cc2-0ed4-4444-f838-08df1a0d76b6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:28:44.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4DTydmB8c+5+n+3+MUgA0Vqzvs3ljPzhyJhp3imcEoFnHS1tF2fVr7GBlIfGqog0EctR0d4+oeQNlQoZwnM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-OriginatorOrg: intel.com

>>  static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>>  {
>> -	int ret = 0;
>> +	int ret;
>>  
>> -	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
>> +	ret = get_tdx_sys_info_version(&sysinfo->version);
>>  
>>  	pr_info("Module version: " TDX_VERSION_FMT "\n",
>>  		sysinfo->version.major_version,
>>  		sysinfo->version.minor_version,
>>  		sysinfo->version.update_version);
>>  
>> -	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
>> -	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
>> -	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
>> -	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
>> +	if (ret)
>> +		return ret;
>
>It should not print the module versions if it failed to read them, right? I
>think the reason why it was done this way was to fit into the existing pattern
>and because printing zeros is not a horrible outcome. But that code pattern
>caused problem no longer exists. So I'd think it's ok to fix it in this patch.
>Before it kind of blended in. But now it easily stands out as buggy. 

Right. I'll move the error check before the pr_info() and mention it in
the changelog.
