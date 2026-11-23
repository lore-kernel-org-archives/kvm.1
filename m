Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795458900;
	b=qFyIV1tt7JEeuQfi+UQ6BmqlrhImFwPTK8xQU7TX2KMbPULn9xJQ7Kn6WEY9P9Ngx/Ux
	 4TMcdk9XEqodWlfBz8DiyhZxlRb1y3cGrTA/BAxCn+osPSevHsUNvcoCOcllVbMTalwqC
	 IoiFFuNFOVBW61HfS74UQSvGZyFRVWFLJ8WfJwMUnJhdJlmhxTnpvpILI+c0vXMoNI1sR
	 LfyptZBqrT/Zn6OmZJ05vzUX7Q+kyptMV/0JG0J5Os6JI9gSrIAzlDqK97H8Fx03QT9Rr
	 OeUyYZk4xarzh4tG2uqHZ3mLwCtn3t81P6oK4e88nvMb/TVBt3jigL/2bX0jNL07SOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458900;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=+MlKR+VpGEdnJJ+CN8PRMzGEiabrfObGJYRtOmJO+N4=;
	b=YE7+cxhjgFXRuBlX3kCrvh2xnTm+m2SjHigdK/ZMiWUApYuhErrEI4fhplzG0Au02BCP
	 658RUuyore12FGvmSi7M+c7356W+Ist2zVvt94pnR8FH0MuMe0OMgcpCYsATsj3Lg0tzZ
	 u4yZP4RDXXcJLwVGm/x+RyklRMl5LypxWXJOiw1Jtjz+WTcnL38cD8Ps9FA9xhyG2K3D+
	 0R0J27HFPTKQQujjvSliaCDg6v92Bq3McwGEpN9hrPjq+Iz2/SHhbiIl5pXw5WlU5dChu
	 hKZC16YUS1D2vYk7WPNOFyql24D5zQbj1vSrXNlsbC07rBC3RCOcNyfmEetbeUtIEJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bnzeWpK8;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=MqGYeCxf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A3606A321;
	Mon, 23 Nov 2026 18:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 213A3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bnzeWpK8;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=MqGYeCxf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795458900; x=1826994900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HWFV9LVoMvcZp5792xDsp64C4rhCJkd9iT3LJIoqUxE=;
  b=bnzeWpK8Yh71OF1CemP1nnt6BU9rAnYyQIQhKRHVZOq43oeJ0dZTvViR
   3XE+iR4BiGVSuzT6K900phJy9K6qXXl98buxJNbuGsmBCxfO1mr+gpNTh
   mNYFjrlYwUftzzzwzghTI14qoME2U+i1bTDTbF0a3F7FX7GvkL3w4WkQm
   LFV2JR68xp3WADE2rhZxNA1JFdqHfdHXLdw3u6Jmq1Fq3bi+Dqcf/iSRy
   hTP4dYaf678NbIAhWSLi53T65V1iSfeAgCi4Ps7/HzL5HB3ifPQG713AH
   bGdm300mvE/7v7344IY0UnziOctxw6eu5/nOLynthJmL/wZMXetETzbSy
   w==;
X-CSE-ConnectionGUID: 1EkcbcH6S7eec8OPSm1Q4A==
X-CSE-MsgGUID: 0lZ8nxSoRE6R1DU8/iFOrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4292377"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4292377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:34:59 -0800
X-CSE-ConnectionGUID: YuV1tijzQNqY9UxEEs7Sdg==
X-CSE-MsgGUID: A9iJgX5aR22LNxWdiPw5Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11393831"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:34:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:34:58 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 10:34:58 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 10:34:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgaPQxmx3dxQOfmnltwBOjgsBsZcv4aq4qL4U7u6JWNGZR4LPdHPwjckBH+7q8R08Z9m9ZzG/ZOD5gtoUiM/wP1K8eqDu7b0yCOKdKgtBFp9l0svomKhJdQUd8SJcnnuVUPLA54wNymrqO0vgn3Ec31h+JZFxLJGIgScmaK7q+TsczzPNl+BigheWiaovvogTvQWKt73418rKeUN29ZuxfMjeFhw6AbM5XIbWdupDyQLsyuLr8p8e2BxcRQlB3wlcZ99WlLIjvjOiA9qqOtUZmXth1HSqRJuhHQVBIlJ05ZzJ8kGcEJFEuFasSMaz1Auz3Ax2YkA6G4hNGxdILskFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MlKR+VpGEdnJJ+CN8PRMzGEiabrfObGJYRtOmJO+N4=;
 b=fZvFb91rx9FfS1fsYIxrfffw3duL7oIpNtLKi7yxuhuSQzXcEmLn/i719V6ubCNvstoWeFukt6c620LyLbE7RC4EP3BnQn3HQa3uoVW6HmXZin9dKvAYOAd3JCtMpTo9zgrOF1aDblxzdle7ob194BT/z0QrKtEKnhTa1NYtH5b7IyGUGOxW8MKNKr9bYYh5DDF3ehhpuABjgZ8hjSitO+eKtC6YqKvbonKmECo+5LQKGgK3HXxQ3Cs/uaoB+pKaFkxM7/s2wVwu8Z8C37PIff3zaH4r+Xwq1BISFcWMBesenNswqwmdTy/czyWg7LX8FP796BuPkUK6xbbJgbidTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MlKR+VpGEdnJJ+CN8PRMzGEiabrfObGJYRtOmJO+N4=;
 b=MqGYeCxfnavXn+ZD+RlVpYuOS+2F31BnRRzix+mNYWIMfGX6LM4Sfv50YsoMXoZn8VN6pK1BuAyHvt/f97kqW8Fv6OnVv7MkcBf5bueT4fEEYTajc2+o/9ZQM9MekV8gQHLzI7vyHJd0p1kEKg3JaQ11SXs5WJGrewISln/wfnc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by DSVPR11MB9936.namprd11.prod.outlook.com (2603:10b6:8:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 18:34:55 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 18:34:55 +0000
Message-ID: <5cb0a2d8-d9bb-4464-848b-4e83d1ae2eda@intel.com>
Date: Mon, 23 Nov 2026 10:34:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/cea: Index exception stacks by the ordering enum
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Binbin Wu <binbin.wu@linux.intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Chang S . Bae" <chang.seok.bae@intel.com>, "Chao
 Gao" <chao.gao@intel.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261120235025.2809042-1-sohil.mehta@intel.com>
 <20261120235025.2809042-3-sohil.mehta@intel.com>
 <4c51d4e3-2628-4b51-94ef-60c941c09dd4@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <4c51d4e3-2628-4b51-94ef-60c941c09dd4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|DSVPR11MB9936:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d67366d-7de0-43ca-3da4-08df499077f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|4143699003|11063799006|56012099006|261021121427099003|261102123227099003|261009223027099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: i6KEDDuiSPhwTJ+MvU2SRphNEe+WIEVtSI3/uPkWGqcrOwTSRKXLn4HgD4MCpGcQjrxrHQLXdJ/7xDTzEQ395AjiL38a3FLgIyVgkbNblfmC+zoXilDq03cwWSGeubACeCqHeC13o9/Nq+cAwMWG1gR4/NFmk4+nCudAYiXHv3SP1nehA9Y1scJjFBXXxYT2wl4kXQoFLnS1VvEfTLY/ib8y9qD9+rilyLe9vDttikL/7nIicmtGJUzt5t2AOutIIXacEvsNfzQ1WjsyJV8noC4ebexSAmaCfI6l6csMxVW+y6s02yUn1KPvia5gNZ9/rr+z5oS1pM6PE/oG3TSP4UnYvtp2xftZzwoLTJ81pXPdIqq618/8x+ZZiNObVwJ2ioohRPSh9KDGN2HmCp3oRm8OfzUaC4uB+dtWjarcjp7ptY6HCMrq9bwDkcwjQmFPFuq3HVMoi3NH64izEEBy6UiEHC1PyA4alroU77M9ji3NTSnKEvZCezGI2Ptjb1JUQ6e8vfyetCrnWiRc0Sd9SFa8YDdelg71AOJiLx8YKNWsJMiP261/IUrPBrQfBwau1SXkua3Sf2S5MfDzBwPwS/gTb3jF/7icHL0UlbkUJFuf6H9zZ8DTLkiez5UmN+BR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXAvMFVVaVdRc25RbHlNTXN1dlpTSDV0dUs0WmpCb2dOaEFTY0lCMndsb1VS?=
 =?utf-8?B?bEF1RXVkNEs1VEcvWHlnRmxMK1NHSTlieFpEYmx4RzNOUFZZa29RbzhMTGxG?=
 =?utf-8?B?TC9XZFU4bHhuN1EzQTJ4TXlCWnJsUnFwM2NQUHA3aGxtQWZySWZ0YnNFb3Bx?=
 =?utf-8?B?eUZkaVRWay9BRkVKcVl0WFplUy81aE1RRldmbHhlNHdIMWplYllQdDZjODlN?=
 =?utf-8?B?OS9NaTNNczBvblJlcENwTitjanp1S2dWSUY2WUsrUFZuT3NMUndxOEQ0Z2pL?=
 =?utf-8?B?QVc0eUtpTGJWd1hSeHM2K0VlQitzTmdyZDNobEQ5UXBJWlFaUzZ3UldQUmh2?=
 =?utf-8?B?NkJSMmNoNTVVUW9JWHlHaXhhU3JsUC9uU3M2YVZqNmxCejZ5WE5KVHljMXFx?=
 =?utf-8?B?ZDlVd2gwK2NFZGIvajRhZHArK25wek5CK0tERFJmVkpDQ2RDSmFqNWprdDZP?=
 =?utf-8?B?QlN6S056SlZxbEZUSW0yaHRDQVBqa0hsMkhjUkp3TWNZNXBkaE00Tm52SE93?=
 =?utf-8?B?cy9TUmZ3b1dxdDZGM3VPMHBXS2Z2azVwOEtsZVl2eTRwMmxzUkozWWRmYW5P?=
 =?utf-8?B?Y1ZHVjhyRFlIS2I3QTBJYklPZW9wY0VXRFBaT2QyS1U1Mm9sRmFicE4zL0c4?=
 =?utf-8?B?Y3Y1UEI1dmJlVnZHNS9WMm9WR1hUYjgvdHUyVERsaFEyRkd3SVNOWStVR1ky?=
 =?utf-8?B?a09VNFNMcmlRTG1nUlFHblhiOXZuVCt5bGN4bjNuL1hnTTkxK2lsMzFORTMx?=
 =?utf-8?B?c2lXMzFKRHRtS1YvMzFmWEltcEYvNGkyMTRKenB1WTlJNFI0TGx6T29Dbi90?=
 =?utf-8?B?dHY5eUw5UkRqWTliZXBhTEsvdXBJSWxrOHhJUTlJaGZHRXI5SEZFY1NLSVQw?=
 =?utf-8?B?M0IvSTFuYzBNcTJpclNMa1BDZGtxbzFRaUR4ZlVLSFRUWnc5VWE5K3dsdjJL?=
 =?utf-8?B?Nk5wbHB0R0x0Tlg0YlpXbDBKalRwV3BHZnZOQUUwa3hNMjIvTFpySC9aVFpj?=
 =?utf-8?B?dVVKYXdNODJiSXJNY1dTcjFERVd3a05WZy9DQ0F3c0RHM1VBSVc3Y29JOFlK?=
 =?utf-8?B?dWpnUHhabU0rNzJnT1A0eFhYdm8wVnR0N0dSTXo1TStaS2dubXNTVnpvMFVa?=
 =?utf-8?B?ejJwdjkxbmFRUnJoVm9WRU14eVNpbFZnd0FSZlM1WHFGNkU4WHpTQ0FZbTdQ?=
 =?utf-8?B?UFhEdDNZUTl3a055UElUSjh5NjkraGVFcUVhUnhMWkY1dlF1czBOTmpWRlhU?=
 =?utf-8?B?M2pxTWN3OUFBb1NlWVN4bjdxSUZubWpmR1BxRzdvZGRHUEZ3UWtnVXBub0RZ?=
 =?utf-8?B?V3BGdmtIcGdqOE9GYzRCUFJTSFBMbEgvVmx4bDFFcURoZWNIQnR5NEhxWmNX?=
 =?utf-8?B?b2pKdlRTaUV5d1RRRXBiODBRZkRYMmRydFVWMG1ENzkyNU1RMTRmK09LeDN4?=
 =?utf-8?B?THR6anAvSkJwN2RJZytTajRuVFVOaWJ5L2NuTzFSdGVENlp3cHd2dFkyQXJj?=
 =?utf-8?B?OWhzZTB5N3NDUm1vdU9EdHNqYjNIZWVBYlFUU2RpQ2EwU1Ywc0VhQXJ6QkQz?=
 =?utf-8?B?TXgyWG53T2JLT0Q4Vm1MWDJyYmpSckxLczZEQkJZUFhCM0ZBOFJXRXBSOXpN?=
 =?utf-8?B?N2xEWDV2dTkveWxHUmRwMW9SOGVka0xoUFVReVk5eWVNenNqQ2VVOHJ5RExZ?=
 =?utf-8?B?eDRuN3B2YVhkOXJaK0ZZVkIyUUIza01XY29kcGZrdnQyendnMXMzemFpMm44?=
 =?utf-8?B?UmtXWm1ybDNubTFFRC9SQnBwYnhMV0I4N1RlQzAvSGszcFdPRHVBYVRQTmpV?=
 =?utf-8?B?U0FxVTFqRlVFNmpFdThHc2V1RU9IQnZMcjNuMDNSUGZBNTFsT2RkL1Q5ci9C?=
 =?utf-8?B?V2wxZXNHaE5udnlWS3RHM3hsSUdGVFNSSkNnTEpWZGxJWVdhWElTRTRUUVBS?=
 =?utf-8?B?dmNNMmM3MTRXUU1Eam1saFdqWGtVaGtSdE93dUZEb1lYL09XMC9xbmxHMEI5?=
 =?utf-8?B?ZlJkWEFRRVhmTVZUNzNQVnFIZit1WSszNmhTSHBlOG1mY1htOHZYRUREb256?=
 =?utf-8?B?NnU2b2lCdFozZ2tRbjRJeEZ0c1p1eThVaE5JTXVkeXBQVnkwNDczenVmSFMr?=
 =?utf-8?B?TURZSHJSd0RJcHhzMnVSNUJZMnhZVjlSbzNLWVMzRC9rdENGdk5uWEQzaUhu?=
 =?utf-8?B?UnNTbTNuTlpOOXlWQVFvTFlTaHROR0FiMmpMSjRnMjEyL1Qvb3lZV3JMMXoz?=
 =?utf-8?B?OFJXMEhpWlp3ODJkeUdYY29zMUViYjJuWFI0V1lVUkpsRlQrbUNucVJ5bmdz?=
 =?utf-8?B?UTVocFNvWVEvQmp3QmNWbWoxZVM3ZGgvelZGcWdCOEFDNUVuZC8zZz09?=
X-Exchange-RoutingPolicyChecked: YiI3MuT+04CRgtDHNjh40KSCQx83XupWwnvsFqY9fOgHxGzyDZXQbeSZSPcZkJIUsYeyeOiog8IS24OZEQ6Nx05bDprZbNQQ95zrTC38hDtjNknIzlax9hG6EskSjWWYnYRO25VoLQoD3lC/RuIN27Df/yqVCnOuF7Den/ZMtJjTThTVRrSpdlwCP6IqC/0BuWqPF3QnRC4U00zjFQo7Mtw7/1m/SVVIHBES+ZyeQbH0+3Yi40SzdAn/NYAfmYf8dHzU+oD591eBKfH4TBWdEN+82wulW0jn1YwkH3MUkN1AVQ92hO6N9mte3ElPc2oBOEmNt+wcAgY7Jda8ekyxbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d67366d-7de0-43ca-3da4-08df499077f3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:34:54.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSgNWOOzspFi7F95a2wMKOtQKzN996NEY3JuXyZRaYFSwuTCKPClY8RvYb7KDmt++t4OWjYuRp9xfgrn4kForg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9936
X-OriginatorOrg: intel.com

On 11/23/2026 8:19 AM, Dave Hansen wrote:
> On 11/20/26 15:50, Sohil Mehta wrote:
>> +/* The exception stacks' physical storage. No guard pages required */
>> +struct exception_stacks {
>> +	char ESTACK_DF_stack [EXCEPTION_STKSZ];
>> +	char ESTACK_NMI_stack[EXCEPTION_STKSZ];
>> +	char ESTACK_DB_stack [EXCEPTION_STKSZ];
>> +	char ESTACK_MCE_stack[EXCEPTION_STKSZ];
> 	/* The #VC stack storage is conditionally compiled out: */
>> +	char ESTACK_VC_stack [VC_EXCEPTION_STKSZ];
>> +	char ESTACK_VC2_stack[VC_EXCEPTION_STKSZ];
>> +};
> 
> Please vertically align the [EXCEPTION_STKSZ] like I did ^. 

Sure, will do.

> Also, please add some kind of comment about why the VC stacks need to
> be different.
> 
> Honestly, though, looking at this, two #ifdefs would be perfectly
> readable here.
> 

I think commit 541ac97186d9 ("x86/sev: Make the #VC exception stacks
part of the default stacks storage") added the #ifdefs in the header
file to avoid the #ifdefs in percpu_setup_exception_stacks().

> struct exception_stacks {
> 	char ESTACK_DF_stack [EXCEPTION_STKSZ];
> 	char ESTACK_NMI_stack[EXCEPTION_STKSZ];
> 	char ESTACK_DB_stack [EXCEPTION_STKSZ];
> 	char ESTACK_MCE_stack[EXCEPTION_STKSZ];
> #ifdef CONFIG_AMD_MEM_ENCRYPT
> 	char ESTACK_VC_stack [EXCEPTION_STKSZ];
> 	char ESTACK_VC2_stack[EXCEPTION_STKSZ];
> #endif
> };
> 
> Because, without it, we have to explain VC_EXCEPTION_STKSZ anyway.
> 


I tried a few variations to get rid of VC_EXCEPTION_STKSZ but they all
make the C files uglier. C code refers ESTACK_VC/VC2 unconditionally or
under IS_ENABLED(). I am inclined to add the comment instead because it
keeps those C functions cleaner.

>> +/* The effective cpu entry area mapping with guard pages. */
>> +struct cea_exception_stacks {
>> +	struct {
>> +		char stack_guard[PAGE_SIZE];
>> +		char stack[EXCEPTION_STKSZ];
>> +	} stacks[N_EXCEPTION_STACKS];
>> +	char IST_top_guard[PAGE_SIZE];
>> +};
> 
> I dislike the asymmetry here. I'd rather just have two explicit lists of
> stacks. 

This request seems to have originated from you to simplify the accessors :)

https://lore.kernel.org/all/720bc7ac-7e81-4ad9-8cc5-29ac540be283@intel.com/

It would have been ideal if we could move everything over to the enum as
you requested below. But I can't figure out a clean way to do it without
making other code worse.

https://lore.kernel.org/all/ba8434fb-8bbd-4d4a-bd01-1bdb2219979b@intel.com/

It is a trade-off between using name pasting vs array indexing. If we
want to keep the symmetry then keeping the existing ESTACKS_MEMBERS()
macro seems better. Should I drop this patch and create another one to
fix the comments and add the VC_EXCEPTION_STKSZ explanation?


> This also begs the question but doesn't offer an answer about
> why it's OK to have EXCEPTION_STKSZ vs. VC_EXCEPTION_STKSZ in the
> "exception_stacks" but have EXCEPTION_STKSZ for all in
> "cea_exception_stacks".


The exception_stacks tracks to real storage so it uses
VC_EXCEPTION_STKSZ to save space in case CONFIG_AMD_MEM_ENCRYPT isn't
enabled. The cea_exception_stacks only reserve a slot with no PTEs so
they are using EXCEPTION_STKSZ for simplicity.

Though, I agree, this should be explained properly if we decide to go
ahead with this patch.


