Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D4385D61;
	Mon, 14 Sep 2026 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410103; cv=fail; b=pQKXtNAFpSsz4aV8qFhITEr/0zVkvrD8EPZB3V+14AmOSv/s6xHhlUvu/XLvuwFxvZzJiqmFkYiwYeYOUSEFlc/rvlSIsj1pda4JmT5vVMMI7I+LEKmJicu9J6St6jrOXMcjUI491YTN6ZQFYhyNkLmMs4zaGsVW30kqxOi7DsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410103; c=relaxed/simple;
	bh=DWH6wkWk9TUoQRUtaNakx+wejVSPgpuogTDOf8m0jP0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XmQt1nYGeiq/+2GpZW4QR4yH4Wn2G9wVPLIYP2dYTlKWb1h45XGYVj5PpMSzmbwXtTggg6GTP7k7PBCccicbmDJQzkTnJNvI+a2UlY6J34z3xxB/u0Ob+GKv/UJim9TNLHEOxAofQyt5kt6XfssFke7bj+A+nJk+byHHXgqfqoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPZJxH7U; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPZJxH7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789410101; x=1820946101;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DWH6wkWk9TUoQRUtaNakx+wejVSPgpuogTDOf8m0jP0=;
  b=lPZJxH7Ubk0ApYPJotjE2I80rjekpWU2alTXI/d6V23qvmc+CJCk75d6
   3KOY9tISD873uLO4rYHg7+m65u29P2bGcXsbJsqDxSLwbTVYHDNSLFCy7
   rU3twxfivcFitiZh3Md2281T/S+Vsm/+7S5coMs4IQp13Jbj/UIPYmnnN
   xo8cmEdXRWSp3iShTzkJV5C0ae5raanvTHsI4XMuC2AdAzYg+yzNm3ohE
   Fat+KdFe+RtxZE/l1KmqXiYtzkTPjlRBvDjJNmOWUb+IZifmg+SizOnHn
   b7Gn2O4C9ACcKz9m18MmAE+8QmqHBvBVq9jdTuZpO6YCXABCqVVrWCsKG
   w==;
X-CSE-ConnectionGUID: eQ39VyDeTzShXIcXE/DJ1Q==
X-CSE-MsgGUID: qL0Lh+tCTPe8B6Gd5D98zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101117453"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101117453"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 11:21:39 -0700
X-CSE-ConnectionGUID: d42y76aTScmWL9P3zqqGbQ==
X-CSE-MsgGUID: OY3jDdf4SnKJDx40JPgN6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271296212"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 11:21:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 11:21:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 11:21:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 11:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbbbiTp8JH9bdsvXryaNaMvgLDaPtKrl87euqQVF6OkFw33PEGF4NKGYNXfubJOxvcFjP7vZDCbPhHwon7cmpfB9pdexK3ixfBCy1Fee5vtIpTU88v2SgJj1H7kRhdcd4BGZJQCpCY8+mRE72BuQdsCnrksKtdS5eBqu9wFN1PtRd551nPKbklW50V+iSS8NQ6GXT9Szg4HpiGmoHpkbWPYoc8fnnZShAuhbisQ4wOLHThLbCi4gIBDOZoOCiPCxJdCZwsdTqrdAhKg5K1XARSOFtF1eHA9/7vmH38upbJa2hOUyuOgjBeRo8IsE9DLjvsjSY5S5sAUsNW2wo5tD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je1u8XZGvYeCV3hJ2L19bt8MRqKCRpkQ0L+oCJFiSos=;
 b=lDG9JcUnahQUjIkT4xRjYhAcR2tQQgDP3V5QGjK2KnM5m2jGmx0n1TXiqZxTdPEgI8l2nfwKDQPIAyPWRjdLEvIPFTBFGY8qtyfVgxg8gSY7at1lU9+rfrYk1VCnpq5wun4RIRvCs1LvqyI3U0wMggYDKyEDw87DIDjvKLmCiwJmfJAODK8Ibt24yYIIYy4fNmonTQQZmtfsghUjzvrL84WNSNbfV1CR1it1Dq2ZbZIyX5hs4e8ggRvhqef0iDh7yFhrA9xjnh4EvpZM9Vi1Asvl/wX3TjRCYVmDA9f8Po+W9C8y+fwDULhqsZiSYHOH73Z64bUdJvjanFnKwZ8O4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:21:30 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:21:30 +0000
Message-ID: <2ae0a300-49eb-432f-8627-4c786c840755@intel.com>
Date: Mon, 14 Sep 2026 11:21:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests/x86: Add a userspace test for LASS
 enforcement
To: Sohil Mehta <sohil.mehta@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Kai Huang <kai.huang@intel.com>, Fuad Tabba
	<fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, David Matlack
	<dmatlack@google.com>, Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-8-sohil.mehta@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260806011536.4172258-8-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 415483c2-2d34-4dd1-089a-08df128cff9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TRI9J38tm0BZ7yjd+vdHzgZn989c9cGw4C6htNwwOP4UNbROlH0UdpjehAANk5+gZZ2ImqIKmGMZuYvvSpAhcFdG54wS3MlFxx3xvXdhfZtGdfVB21TTyixumt9BRGyGhGZqdqK9fYhd98j5+6cXep4QyZeDCHK8cNORUvEmUX9xpgm2XO1EtNk8VQkdF/zE1UROy7IRvd8GWyaERAyndRxXjm3rwRllZYyvvRKMAcVHDPeVP4NPDOnsa8xLMUghCDdIQB1uEiTxmmq2moUNi39TWX0/2qN3/G3NJ0zSLIdA/WhX8D4pNGfVqcIVKkcETeDzoFLeXS01epBiJ/nIZ9awBK0PKINiXxQ2bgj3GUdiJzOi2x27HhurKORURW2xmAlKDYP2lKoX2q51ZtjZ/G0UxitDOZG5UktcqJ6/EdAAHlAAbXdbea0oJT3CBZ6FG25HdB6B8esy5k3Tc4N+tjcGEp5B2E+Y1fDv1YCP6sH4ZkZT34BfixETuN8qZzggq7XjseleFb+xnhjoK2RqKa+Qcq/CpnSyAhU2GlNHj9cBhPSu+6RJrQJxFkZT/6uIhbFrlBOUPSo/okPFlR7W1ieFYKGLm46GewnqPFK4THy/eRoTs9E6UwPOnIL/Ni8egcG+roxt2t0hQIrNx+izRHMNxL2140uysiEJ4jUEaMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzczZE02YUg2d3FFaEp1eWNDRm9VcWlHeUoyaXpOdEczb1dWN1ZiU283NFRT?=
 =?utf-8?B?SHdrcHBGRk1FbERJNEVwNFpLS0hOWTBRcGQxODl6RDVDZ1NWNzdnMC82Um1m?=
 =?utf-8?B?eC9hTzJYWHk4d3lJR0RjbFJuUzZnTUttUDJHaEF6M2JkVVhUMDR4elVlYlRQ?=
 =?utf-8?B?US8raGtwaUFiMmNBbmlXK29TaDczT0FYQXJvcnZrWnRaZzNwM3RHMVZiZFhT?=
 =?utf-8?B?N25IcGNRQTVTd0pBL2k4NjJqemRQcmlRUzhOTkFYRHRzYmJhdy8zTHkyYmpG?=
 =?utf-8?B?QmR1VUhwcnl3ZnBKVlRlKzBQeFYzSENIMkM5TnU4b3lZemRVSTNOUGtjMzVm?=
 =?utf-8?B?TkZxNThIZ3JBTnFUWmxGTHl5ZVpKRTFqaVBuNStBYVJmQWlhR25DY0FtQVV5?=
 =?utf-8?B?UWdwL0lIaEJ1SXQ4YTJEdEZjWVBCQVdTMkFpVmFlZWdNRytnalpyL2o2RzFW?=
 =?utf-8?B?TnQ2TmgzeHhXbHd1MWlOQWxIUjZHRHhWWGg4RGxJbG5IeklrMnpWVFg1VTFa?=
 =?utf-8?B?eEt4OHN2amErRlNIZ083YzlqNWhFS2tCbzR6Y2dhdFlpMmhEelVRMnRSMk9m?=
 =?utf-8?B?M2RIaWhRYXAwc09xKzl0TjhVeWpnUERrU1V5ZjBVazZpMEVmMUpLaUV3UDJk?=
 =?utf-8?B?bHkrcGtTMVZZeUtHZDFTYmcyVDIwZk9iWkp3a0h1UkNmdzVqSjdoTjEydmZZ?=
 =?utf-8?B?cGJGSlBCK201eDB1ZmtWVUdVZUVKUVJFQk95dTgzS3hNYjczVC9pRkd1aWRl?=
 =?utf-8?B?cmJvSzJoYnZpejZpck5xc0d1TW1MRlVMOWpMTGswZTZDSkR2UXREeHJmTWph?=
 =?utf-8?B?RjM3ZkNHd2JkdHgxYnJwdWRVOTB3cHBEOXozalI0Y3BGYThMZG1XUmsvOUxR?=
 =?utf-8?B?UHJVRW90NHBoZmcrUUtPUGFPUExYMXFvNWFGenBTOW9Tcm4wTVowNXhoNEN1?=
 =?utf-8?B?OGltTDdNanp2eG5JbnFmNTlBNEx3cmhpejNIeVEwSjZycWkzRkU5Ty9jWVpQ?=
 =?utf-8?B?OGU4VkJJRHI5TW1USHVFeVBWbFVzQnYxakJER1ZOQ21zQlBFM2J6V0pZejNj?=
 =?utf-8?B?aHRIWWFlQUxWOGthTDRQRldMWnIwaGlzak5LZlZ1WnkwSFJBN2g4M2x4bThC?=
 =?utf-8?B?NGdpdHdTQVhmSVlUSmt6cFBIUmp3aEZ5TmFnNTZZV0hTTTFuYzF5RmUxR1NP?=
 =?utf-8?B?MmlTVU5DQWxiQ2d6MXBDY1NCb25qblRmMjJvTGdQL1ArVnNZSnVwM1pLZ2dl?=
 =?utf-8?B?dWhKUDQxeTUzcGpMZFVkQ1pDaWd1Q2VKQlZKOThIdTBTZHdRR3BwUzZrTGhm?=
 =?utf-8?B?eGlXK3N0R3RZdVFkY21mdHc2eW1uaFhBUDdFWDJiS3pSR0VQTzhUNkVKSTZW?=
 =?utf-8?B?R2l0cjR2Y2pMUWdEempvOHdKWlhWWnFqeFJFK2xLVnR4M2lLeEswMFF3b0Fj?=
 =?utf-8?B?OWpoa2hhenA4cWxKVzcvWkJmaitLSVVWaFBlRFJOeDl3a0RIa2FnWWFDaW9k?=
 =?utf-8?B?TWgwT0luVXZURU9EV2o1a2M1akxzaktrcFNkazhBUXBZYmhtaER3OHk2cTV6?=
 =?utf-8?B?NTdkWWs0d2FSZ3crRVI5K05iS3BYOUJWSHFWWkxFNVFmOVlyQlpqcnh4cHhL?=
 =?utf-8?B?bFNlVXBpQjIrM1dPWUt2K3pIL3dCUy9IS3hYM0xtWVJNN1JLdUFjaTBWTVZD?=
 =?utf-8?B?N05JSlh5WTJnWlJtaFhvbzlyUGVUa21SSitVUzczcXBrVVV3WjNoUFdFbVdv?=
 =?utf-8?B?Rk9mZ2lmK3E1VWtJOWtJRUtuUkdUOTIzS0o5dE5zdDRGditFVDEwSlZpMng4?=
 =?utf-8?B?MnBzcFpiRFdZckZxK0RST0xNS1grS0xRMWVVKzVNUmkxaWU0UUlOK21ITXd4?=
 =?utf-8?B?anRwVWlzUktieTl5OVdGTUdBWTAxZmoyd3FwRVhCZjVkQXc3K2ptZHRmdGNW?=
 =?utf-8?B?alBnZzZnOVZKUXJEQnlBVWd1Z1B1YWxBVy9wQXg1N0ZHVWpsL0ZuV0hVSTYx?=
 =?utf-8?B?UWVmdW13U1pJS1lTcHFabTBodHlJWHhBaVhhc0NNSlZSWlBybnZNekM1bVo5?=
 =?utf-8?B?QmtPNy9ZODNIWHQra1hyVEZEOUh3TlBMSExadE9uVmpaRlh0Ylp5NE5LbWkr?=
 =?utf-8?B?ZCsreS9LanZ6aUg2TEd2VUxVb081Y3RKeGhLS25tTE9GOHZXMDczTE1RUEFM?=
 =?utf-8?B?dmhDcDdnL09XOStuREY1U0lTMFFnL1RGSzdtdGdPaHVoS0dXRGZzWlN0NitE?=
 =?utf-8?B?a0FZTHl5Z2JyaW9NN3pZcVlkQXNFZGdUTWtwUUpsRzJ3US83dUk5MTlabWJI?=
 =?utf-8?B?d3dXRVJFQUNuUGtFdXBHdG82SUZvNDFBWDExM0RFZ0o4NXE0eFJVUT09?=
X-Exchange-RoutingPolicyChecked: ckPmelK0kyefS10NEKZjVEBiCrd6bYeOvOEq26zdnsc5kmPIEeZCoinzTPZk6RtTkOfM5Wo8ZKTVM2UhY/ZYdqDIzTxsASFgQF5rKenWphnb3VtZ9b9o1y7+P5LxLNP9naDvS5IwMOigkpIm/oqUKLMWKVaaUCsRZYxkx1WS3UjI09tmQEGq8p+nVu9uc7ilEbIIaWkZeRNPUGAegbQJmOZl0Kym+AhNcPE2Gqf3MAh8olE7AIz+BmN9MzYpy8W/core7ANK2XSk/94q17JdWBAe5SDI0Gs6LT5U8F5dRNEMdQIk2W4V0aiugrY1u2AUBXZ6OptCDQvW7fzLtM4NJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 415483c2-2d34-4dd1-089a-08df128cff9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:21:30.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0gPiW+JdmWRO9oagW6HRdq73ChgHTODVcX30nSZVlmkuE9EHwlFv2VJjr/5o6KUxKxnt7N7ZfFAWc32iSWjSa2aJtx2iShJaa4HgCrcgP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
X-OriginatorOrg: intel.com

On 8/5/2026 6:15 PM, Sohil Mehta wrote:
>   tools/testing/selftests/x86/Makefile |   3 +-
>   tools/testing/selftests/x86/lass.c   | 196 +++++++++++++++++++++++++++
>   2 files changed, 198 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/x86/lass.c
In MAINTAINERS,
   X86 ARCHITECTURE (32-BIT AND 64-BIT)
   ...
   F:      tools/testing/selftests/x86

Hmm... Curious what's the expectation from the KVM maintainers for this 
patch. Couldn't be directly sent out to the x86 maintainer?

Thanks,
Chang
