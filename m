Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F9212542;
	Tue, 15 Sep 2026 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442568; cv=fail; b=qadliyDkSknDqwzcUcjCwxG9IysHVrIGhvkKnrXm0eTn4pckftYxGsAxi42wVJ7CSz7LMJpTf7yOX4N2iQ+4ERWFg4/KHzxqribGNwr1HJoyOEsTYCf65yjGxi/D1fYdxFT6MCR1Qg286+jDVoM0K1wkR224SR54XTwe1hen8SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442568; c=relaxed/simple;
	bh=zXwQzk+ygXlfuQ6gINXyDQsCVZNW6EY+11FV7T/dfPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XiYZf6Vrj+KCSUZt5wlZDFAVP6bwvcqmkkuI7yTH/1u1vTOBx1jYBULj3l0ec8xBDse1UTgZAQxZk21ERf2PKGtuxDeSqBdPuYesZoVKf+tk9mNW6bz6FE65tX9aXUhtYBPHfGyjrVgeefBwS3Vzy6Li/ntrnfwi5TppA2LN3gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2TkqCMG; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2TkqCMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789442566; x=1820978566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zXwQzk+ygXlfuQ6gINXyDQsCVZNW6EY+11FV7T/dfPA=;
  b=C2TkqCMG1TcTWRGkxrze5a0oo2Ok+Rs9lwtNSFNbwSGPrHeK0IztZVIL
   ymVCY5PNdIrFqb8xaXXJrctqXW9+Gvgy4qZxDVYz/j1NPx4qnl3NQiura
   kHDqKC7UzRvLOxVnvwB2m+AGTihovB6BtduQp0zdg8bjIZDSLUdrx8MB6
   hyIO9hoUr78bScPSwJNfQdQYqGeLupA1pVdcnnRXSjGW4mH0ZOm/9UDcG
   h6nAL+fXBgbylYg/6iGwJaxxRSXC7u2Ol4slB8P0yjUhHn1W6wySeEu2z
   LtmF8kZqqV7eKvOd6Yhb5GCu9PAV+LZWuRfTTmAA/CVSqwF0rIPk+t0JY
   g==;
X-CSE-ConnectionGUID: qNfUn+roQ9WrGj2Pw+3vYw==
X-CSE-MsgGUID: eJwo7CUJQoqr/gTAhVj2uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89669393"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89669393"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 20:22:45 -0700
X-CSE-ConnectionGUID: aThE39ShRN2a826x7DRXKQ==
X-CSE-MsgGUID: A7pv0oYKTfqT5jb4s2zbkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271008187"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 20:22:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 20:22:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 20:22:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 20:22:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgcNYEte9+4pWUFVyWnBqbju8jvBnJq5QvkpyVHj/Qz1gyZJhk6dwRXqVURCDgy2wQG9yL6jP7Wnw5wJ5y7E8KQx/u3aYhKKJA7Tkb9I4vCW7cW51uibmgk04olAdeZ6HA04ToiV1cGvD8yx1ZjRrKypsKpGQic+bY1LWlEIFkgZVg+Pg0iTiIMWOCdJg7WILoXfnjBKABNQESU82NH1XhRhlal2QrRkMEQTFUmUb09148Rpv5gDXpeCvKt56p9Z/nLWOkDKSWvRPpQ8UngX47O7qCi4cFMR1E0/O8YNLAkb8GkfVHcL3IYk9CXTjn9xr+mPhXC4ldKCeRacmOm1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrVRYLT0y9UG508ttRHSRzw4T6JXmcAiOR8cBjXIhAs=;
 b=LI7JqeouNDJjrBIliHwiQiB0gd7xTx1OgY4BcnmUiRVJExhjBnElPEbKmT3GWnONzBcXFT4VK4HaDOT0y/04+5OZh77ST3D+rYpuhYPDE+oPQWs0+8808391684qsNPLDlXH+gTfHsfDpfegz7oS41BH+x04MSGkZNCwLhF5JwDbZHNxEfKT3aJ6Y/2FjlEvBf9MpMPaCMcym8GRWsdn4sPNl8HayYgznl76kjustweyw+uHsJa7pMvU9zjf7rUWR6Zp461QhEZh3zRTWRXVZLKEJCyBLHpIkYed/uEY3KkF+X2uBU5WLtSwdBOVlCDIuQPyNhHHZ5e33OAXVrE44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5)
 by CH4PR11MB335913.namprd11.prod.outlook.com (2603:10b6:610:50e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:22:39 +0000
Received: from PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e]) by PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:22:32 +0000
Message-ID: <c77b9400-f896-4582-98af-fd3399a39443@intel.com>
Date: Mon, 14 Sep 2026 20:22:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests/x86: Add a userspace test for LASS
 enforcement
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Chang S . Bae" <chang.seok.bae@intel.com>, Kai Huang
	<kai.huang@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao
	<chao.gao@intel.com>, Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Kishen Maloor
	<kishen.maloor@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-8-sohil.mehta@intel.com>
 <e6f853c7-ec9f-4e1a-bf7a-3b97ff84d3aa@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <e6f853c7-ec9f-4e1a-bf7a-3b97ff84d3aa@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To PH7PR11MB6932.namprd11.prod.outlook.com
 (2603:10b6:510:207::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6932:EE_|CH4PR11MB335913:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e3d1f2-eb6e-4677-2ff3-08df12d8948f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|6133799003|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HB3oi3L+Pz8etwUSRKk491GsSc/gEByw575Y7e7jONO37x056yVuAN9W8OI5AgrmM83zb3JVWXlbl3t/J2VsWwTje1Vz9r6w63BJVQHrGbyhflQM4dFQMtdXRQCXBzN8HV0QTYam1J0IVIwLk8SHs67vaGMP29lrHUvKZKSWvDEAbupHIC3xJCTbq35/lIM2oshq3nrwUoOopojeFLZG+3GrfzWOh381e/zsStnxJlsFHA4JUSqBlCxZ/8qVKpWFNr5JWGV4RvifInzZ0xQkdXTJsSxCnYqH6HOKUskqGEPtASQMeXvxYXZq9e2HrP3ue8HGf6xHVF15d8RVm0tMW4P1N2/KA+Nn+GZ8YbndNdu5BIjHHcgbSyUUCyTCeavXzpFme2hsAqmOdfaXQV/PZ1Km3wvPoKJXtEacqiMeNwvnhRUlDGEHq6Xyw3X2yPOgBGx7fk4FBAOynVfTbWLOuayB64pG6aQGb0NlyOJP88YhAxQv+XERadBcw+LdLD7f5ho6Sk7PRnSYeIcoOUwg0v6J1BJl97MHjA9THzQMvL7y+kwJjGaKKDPZkiVKeg4/NJN4pLxvUq5KufnxKA8OezY0Bvo3C5QxnIggOgukg1R8Q6+Ml6y3w5B6AD+BflxDHjWGCRB/zR5jxw+a8+Kr1vgH3drseYdwIDpvmbhNK7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdwUytSSUp1OGJFdTZrL3RsOHZUSDBTV1Npcnd3UjE3Y2tVTCtZbkl1dEty?=
 =?utf-8?B?U1RSS0M3VjVJSEdPMVo0Uis3OTE1YnpMZ011cGxTOXZCZ3dHYWs4SVRSZ1Fa?=
 =?utf-8?B?Q09CNTRkRzBBTTRxOWRzSmFwTFUvM3puUk9ZRGVUQVpaeGJEalRkMjN6QSs3?=
 =?utf-8?B?K2d1NEVqNXpXMHFsZmZQY251WlBWbzRneEtZMnc3K2lSRjBtRlcrbHFaME9l?=
 =?utf-8?B?V0sycUJIWnZSdjhYM3FsaE51dmN0bkVubHpPS2VNSVkrVGlTUUgvQ2NxQlB3?=
 =?utf-8?B?bkdWdFJtODhWK1lyS3A3c3NaSHN5VzQvTUFjVGNVY1pkSXNCb0toRzNJODJl?=
 =?utf-8?B?cm5MQURKWXBlUzB3ODRjaGhPTEZXQ2ZHemtmUUVSK2VBcmg1YzMrTnUrMHMx?=
 =?utf-8?B?NFV6U3l2NTJ0Y21QWU5zTjlnSnJXVlQ5aWtoU2VUS0t6ak1nS3RXVU9vNlVk?=
 =?utf-8?B?bHlocCtvd0xCRjBmd2x6TEJZbUFLZzJOYUxTaW5pNzVrc0FXMFBqbVdPNkh2?=
 =?utf-8?B?VTgxdWNocHlVWWxKcXJOdU51L0grY3lSOFF6VG4wdmJkeE4zSXFNd0ZYRE9s?=
 =?utf-8?B?aVBlaWhwTlpnNFJWUm93YTRhb3k4am90dWREQ1J2aFM5YjdXSTRaeGU1M0lC?=
 =?utf-8?B?S0IycEx5bitNbEF3UzNsMTVKd29ZZmVHaDlFbGpMeWRJbDg1a0w3bUcrNG5u?=
 =?utf-8?B?dmpEOXdiS0RRTmVLZGloQ2dPR1JRSk4xK05TVll0UnJhRG03eXpYdDBQSzJ2?=
 =?utf-8?B?YTAxLzluTG54ZzNtaitKY3JoOENsSmhZTzBkd3YvZnVCaEd5M0orcCs4Z3hD?=
 =?utf-8?B?cnVMYWdVQ3ZMdENHZE1uWWQyWHltNmdjU1djeWNscTJsak9IVVV0bFFWSlNJ?=
 =?utf-8?B?WGg0aFBkNGwxRW12S0JkU1hSUk9pZGFONGJka2pDY3k0R0o0Y04zNGFmNmpE?=
 =?utf-8?B?ZXpxN1JSM2pTR1RnNG81dEZaZ3U4QzRvRHpJTUthLzFvelVmUzBtSnFjRE96?=
 =?utf-8?B?QmxQNXMzVmtrOTVLWFlaNUpvVDhtaExENllxTWlhazNtTjBiUStxa1VzVE5y?=
 =?utf-8?B?c0hyQllZRE85U0RpUFcwNkJpZGpQTUYrY1NaYm5JTTZvcmhNNk9pQ0J6aFFE?=
 =?utf-8?B?VFUweUpTWjIwakJHeVpzYU1MZ2d6Y0EwUHg3TVVONTE5TnAzTG1pZUJVVkVO?=
 =?utf-8?B?NkR3TVlKL3VYbytPS2s3aEc2eURSYjFwYUc4bkE3UkZVZ2tUeGlnbWU5ejEv?=
 =?utf-8?B?MG11TDdPRFIyYWRVL3lBcDRsTzhlOHFuakdyc1lTVVVDSkxyUHYrbi9MbFh6?=
 =?utf-8?B?VXhqZ05LMytiVkprTkdQUHI2d1c3WDN3VzFaVDNhclpwOFRzYVlqcE0xdVVr?=
 =?utf-8?B?QW9TbWFTZDVWUTlLalhtMnlsaldrMHVFSDJUbksrdlFSck90NmlxM1Q4NlZh?=
 =?utf-8?B?UDhBSXk2MGJjQWczdHozVGs3YkRtRjBZR1czWE5HL2FpbVJhQjdZalJLMFJy?=
 =?utf-8?B?dVRXbTBscXZoc3dTYXIwb2VaNVB1ZWVoUHNBdWhrTGhyTisrbVpTd0t6VHdH?=
 =?utf-8?B?SXU1MWI3aUxjRFd4bmlxK0JvTWhyUGlFTGVjeTBLbDVSdGtObUk5SkdISE5M?=
 =?utf-8?B?MURMNnVhczVwampNQ3M3d1hvYjllRThoVUlFMGtIVUc2VGczdGJvTmdCVDY3?=
 =?utf-8?B?UnJLY050Rmg5OFg5Yjl4Ris0WnlpSTFFenQyWFhKcmZyM2t0N0ZIbzVnNTBB?=
 =?utf-8?B?MGQrbHQ3c0NWZHo5T2hnMkxaeVpzaStSaFlPM2ZvTGhKMUFCaTZhVHZ3dnN1?=
 =?utf-8?B?RnRZMXlJNlN0ZlFGcWNibWJpTWs0bDdXMmdieWxseWlVUzFoNjE2bWhMVmND?=
 =?utf-8?B?Vzk0alRDNENvUDVDWGc3aEx0clV5T253MzQ4SUtFa0pBRDVlbHJOZHhqVm8y?=
 =?utf-8?B?dHJlZFh1YjJtQmh1TkxERFFENkRQOEJXTXRmNWhGWlpWQXh6QllCRFVnSitL?=
 =?utf-8?B?OC96ZytkZ0VLYUUrUmVyTGJDcGdpVmxPU3k3ckN3KzhkT0NWOU5JVTM5MC81?=
 =?utf-8?B?azNydng0ZVdJbFJyU1dzcnZTWHRuQm5tRWFZaGhVaVM0Y283Z0pqbW5GMkgv?=
 =?utf-8?B?VTRLaStFNVljOXFTakhRR1RQaTZma1VvRkFCekV4WVZnRnl5MnJaTHN3SWVP?=
 =?utf-8?B?RDBjcnRNUmtLaGI0QnNzV2QwenNJTjNnbUZzdmRLSW92b29ualNTdWY0N0pY?=
 =?utf-8?B?ZlBNZVFBc2FFc09WUC9GdXpheHYvZDhGRDRocjRTbzAyV1J0SWxRcDNKMmtC?=
 =?utf-8?B?MXovVlF4dGZrV0ZPZkV2aDV2RnpDb1NxU3labm9PclZ4bERtS1JaUT09?=
X-Exchange-RoutingPolicyChecked: hmtsxGePQBH8fpJ/m/oEkwE8MWW3uD5apvgGsJ7d7zfOn5cAo9apmzAOp6owVaCNMhK0RePpuO86rWSvzoYsIz8wps1lq1bPxxRLk+MzguUfIaYqfTns21xKWcDDkvwYA587Phl0ptr54HRxN8dZBs288SuPLTS3kYKXmkSrwlKzI+RCKMT44N+HUnxnnH/KonCyP4mU41pN/DcvrBrpOpdK6VZbliIdjVNXIas6qCpJiV9efz9xtLpntJG8N6WJT2huvMXErvcgZlu/+j3w1FfFIbhONt+A1a+A+M6/3sFa+sIwFcMQGOQjjy9ncLt+BBxgRYE3fvRxY1za2LfPQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e3d1f2-eb6e-4677-2ff3-08df12d8948f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:22:32.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMrZ6y+zqPSE4eYFyFiBTP2vfHYx+FWm85dqFOwZW6uygKTSd7dVx9Xgt85bS1aH+ph6C1sqps3XQRk38k81yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB335913
X-OriginatorOrg: intel.com


> 
>> +int main(void)
>> +{
>> +	ksft_print_header();
>> +
>> +	if (!is_lass_active())
>> +		ksft_exit_skip("LASS is not enabled\n");
>> +
>> +	ksft_set_plan(TOTAL_TESTS);
>> +
>> +	sethandler(SIGSEGV, fault_handler, 0);
>> +	/* Only to report a #SS; LASS shouldn't cause one here. */
>> +	sethandler(SIGBUS, fault_handler, 0);
> 
> So the purpose is that if there is an unexpected #SS, fails the test instead of
> killing it, right?
> 

Sorry, I missed this question earlier. Yes, the goal is to catch the
SIGBUS and report a failure.

I think it isn't worth keeping in the first place. My initial plan was
to trigger an LASS violation #SS. But, it turned out to be much harder
to trigger. I'll probably remove it because it creates a distraction.

>> +
>> +	ksft_print_msg("Accessing the kernel address 0x%lx from userspace\n",
>> +		       (unsigned long)KERNEL_ADDR);
>> +	test_kernel_read();
>> +	test_kernel_write();
>> +	test_kernel_fetch();
>> +
>> +	clearhandler(SIGBUS);
>> +	clearhandler(SIGSEGV);
>> +
>> +	ksft_finished();
>> +}
> 

