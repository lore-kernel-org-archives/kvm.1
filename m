Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793148305;
	b=yyrxVzuTyo98IcayX42b/XJsJbkXwV47zQYkHKobSc3f3a6DZ+cdFsInaLENTLPVWvw7
	 p2j6ReOou6YhluRMKlm07zMyPkBuS74usmpBy/qW03PsqWhNvdv81IHrGzBIqisO0GXzs
	 aLOE6WKO6SPGaN/U+obS4FAucu8ggLUc4E12N5u4OqD8v+y61cZRF5Q7tLf+jWCAcUSq9
	 P+8YgSb3khDSGIPak5pFcGcHp7+3F+viFxc/3aHmr14F3cFJJgLknRjRQfDFEiKqOY7w1
	 RTw1qCwDYGt4D8TeOxsLzeI2AlkGQDG+R3TzfgDyvq7NHPMj1fyrpd0oGHLV8uAGYfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148305;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=KFXi96rM0ECIhyBiJtaA7Ev9rFZU6Ic+AqWke7iadB8=;
	b=c4cwu/Ylce/R+GiO4J0OnzyJlU/EHsjnulqzftQbKOPh4nQCKc9vmpq6Fix8vHGQDXwM
	 fJ0+iHRO5PfPhvJ7kLH8ZCLbLSlQbzRGkhjqOUlZUwU+Fs2fFfU5Ea2xcnN/CAOzt+SsY
	 9A4fI4RsNDogQK+x2fUg6UVFmhhgXyrywjQz1OZiMFlHchq7glOKSFmqEbxz5XJ/3/qJx
	 gozx1A42Af+zPo3e0reuLPYuhFDeLu3O82bexH4ppXn8IO98CGQ6cPJrJiraJpBBObnTQ
	 rZ1rqaLs0fvDKGt6Op97z3r9fgTRqRSFsW25C+ttmDJJFzCgxnuMvudyGSL+khTo4aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="nnvWBJl/";
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BA606A31F;
	Wed, 28 Oct 2026 00:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E8BA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nnvWBJl/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793148304; x=1824684304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dr0i+hJoPJ3wsMCL20n1sUYHF/szhk45/oz99CXZlZc=;
  b=nnvWBJl/82mFPn9KCIF9Fa3aoeJ7WHAvWR7TPReBbZiXk+kKLJxs+0q4
   3BaH+7AvDEbUOvMj0RjRKACTVsnx9z3LXXtxkYDE8zIaVCrvgnSGh/neq
   4AS1DDU2Z6Cv4TNULRXyLJFa/YinrtsnNVeBlkVp7SGV3Dn3VHUQ7BN3T
   t0iXoKXVe9mjiYwZH41R2VvmnJHrh9FhfYIFJV0/DEEW+YU1bO7NZ9Kt/
   zqkczPyLtZGuIABZ0Yoil7McY/J3LbveRoS3BXfHhhmhq4m+FeSdn7GS+
   EB+j1h/6EEIZN/o//kc36dfdlMDCMKWusrH//jnTZJpJ/gPLBI9YrUcpO
   A==;
X-CSE-ConnectionGUID: m1d73uoASGqimK87EhGczw==
X-CSE-MsgGUID: IFAq8RlyQbqmnO/Itm2oig==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1874193"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1874193"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:45:03 -0700
X-CSE-ConnectionGUID: 5lnirFxHR62KtM/IfZMKNw==
X-CSE-MsgGUID: tFq+34AtR8+1iT2Vv9nKPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6524354"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:45:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 17:45:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 17:45:02 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 17:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w49kXFKta9SM9lqrvkLYBgupa7z92d+did8TbMrC1C/4KhfdxgyrT9mFQlcOcFkN8MmIZSq9UGXZQgGOY3qHUA6OfV2CiWeh1RgI7tKx58yjhLUrJIcrMX14ugTBM9vmJGtoUnpK95KyZATmdX/gUK7AXJ1mDpdu0U1HXEY0GX9Ey5PL0bgzPbhFIo8SZDAYlgu6wHoYNeXOyKWYmLHALGvDrYeV09FbXPPLJ2H2lcTGjQMg5aOLZCAJreXqfxrnKpBRnKkfPANrbQEXMQ8dns8zx43QnUODfvuxFCp/pmGD3BNnsJE3KjlEtIb8DVf8+VBK8Q3cui8xxb69e5oYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFXi96rM0ECIhyBiJtaA7Ev9rFZU6Ic+AqWke7iadB8=;
 b=Eisa7xv4b9IbNT3tnvH+8ZFJfveQ77XZ2b6VU07qeCOp7VeAUIZcD9rb1o5oHPIgv6a7FnEPmC+j0bLTGpD/TG/DJNm8dTBSIpB3EBObX6E65IAvl5XHI6AfugPEnYvQD4IZDMWcrKvdJbSJCvm/OQDTgo2VnwzLvAE+s9HElxzoFoAFFSUuws3mZVQbCcGWrOsrm/NKzBCAvK3cEpQ6bV8k6Av7v3hGREWHt+2hsuQ0pH3gQ3vSz4lm127IAjWA24R1wkoPEruFGuU41TX6t6CWstCK+MrZDMNX/o8AhfWJ/aeQtBLU4Os9WAEaNwtA0RobmsZHtKg4j7h8oiGjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 00:44:59 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 00:44:59 +0000
Message-ID: <e5abf4df-d091-41ca-be78-27d7a4a04ff6@intel.com>
Date: Tue, 27 Oct 2026 17:44:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/28] x86/fred: Export this_cpu_fred_rsp() for KVM
 usage
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-7-sohil.mehta@intel.com>
 <85872794-1868-406e-8ac0-5d9de522a8cb@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <85872794-1868-406e-8ac0-5d9de522a8cb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|LV3PR11MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 688f4371-e11e-444d-f466-08df348cb173
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|18002099003|22082099003|261026121527099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: v/X6IWp9dcdSFSAocLOa59bDeFiNlQaxaS2Th1jtWYEjw/Y7Yjgiuoa4uYxjVNvixDUyMvXM/t6e4FZ0G8vJ9TxjJpS+rH117AeyVYyAm0KW7aX8hh1gf+uW4QiuJiQdigLrLxrkr2den26WhSXrll9mJspK2lr9kXsQNGJz2Dk+DdkMC5XQLhuS+ud1n2uPKI2cCcl3ZL4CsJJBuaYD6EXuojq2G7NEGwqwZ9ees2G9WFFlWH7Oy4zXaUhJgQKvM7t2Wr6MaRutqrZIQxko+EYSR88l9Yl0d6oZn+DMlWGepQ4UPdNcyPnlu5melnykhf6LSqdvJRFtVVEWxl4aVZFjSgRi/5d/h4Rh1Nkp9t0PPeniszxNqvOsOHWXwK/8LSrHrcX3NbaksW2pwwONChL9jiewy7HIvHnjYKngYFZ01ogr/K2oB9VLmuKxbZ5kSE74+nN2EvWRtVxTHc6s8ebVlvBQ9jrYtdike5C9Hw44n4QEWmKZ7cIJVUSx7ReANIJKt2tIVBaTaQZPaXDTdhmUk9xsuLgDCgfSC0LL/MZfHJGxDhP72UX389dMeaBWpOdp1pcRFeFbEB5tkDMMAe2I1xW0n48IxOVjAQ86v5x6ysgxUePVjDGF6AyBOt+QI8DzKZr7OyPKq+iVedAVwGbA0sxE77fKIJuJaRENxKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(261026121527099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zng4eDFzYy9uQnl2Q1NVeVJPWFVacDFKRk5semxKKzRKMi8xVE81eElISC9v?=
 =?utf-8?B?dnlpVXdWcC9RYVdkY0lTbStNanBmdnlQWmErOEF4cXJyaTFlT1JxaFJJQXB6?=
 =?utf-8?B?WEpxRnFQSG1pSnhsNDJ3YkM3ZjkvRWNRdG5UWHI5WGwrM0xnL1p4WEFaN1NM?=
 =?utf-8?B?TVMxK0xmMXlRUEs3L3F4cFJTZlZ4ZkkvMitCS2xUdUVJUG81UnBNTkNTVkZx?=
 =?utf-8?B?SmppbG1MQS93U2lOOGxEcC9zcGtSZHk1N2g5eDBhMlp2S1YzdTUzOEpTMzFs?=
 =?utf-8?B?cEJvTjB4VDhlWnhjdGR2QnZsNXcyMndvWmJwM3hRMWduUzR0WmFvMVIySVB6?=
 =?utf-8?B?VnFqV1h6UzlXbm4zOXlTUmtXRXdJajFQa1BOZCt4TEZEOVpscWNraWZRWGd6?=
 =?utf-8?B?dlQ0Q1VzcW9LMDkxYzFhWUhhK3ZKMUhuTDZmSmF5dGRKelBGYnNxeDUzQllI?=
 =?utf-8?B?UzF2SE5zbmZPenlPR3l6R1BtRW5HM2N2Tm1XMVV4QU9NVmZGbUNpYVU1Qkx5?=
 =?utf-8?B?R29HMHRDRzEyWGVPUlowRFI3YkRUeVBxOFhmSnlpR1dYWmdTTzNxeTB1OGFB?=
 =?utf-8?B?NEhaYlRRYjVWNHMvclR3cmQ1V08wVkNySHV2cEFLNi9Ed1pzc0NkempDakp1?=
 =?utf-8?B?YkM0S3I0d2F1eDhva1N1czdWcWxtNzl6d0g4M2tCRDQ2amhCU09OblZLb2Fv?=
 =?utf-8?B?UG04TGo3ZE10QWVEK3ROUVQ2S09iYWFudU5oVFdwaDJ3R1BjcDhrMEFxaDNQ?=
 =?utf-8?B?ajdTSnRCYVlFZDZEZXZTODlkY3gvQTZ1UStBc0l0dVlrTFFRMjZPdStka2xq?=
 =?utf-8?B?bmErQmlFZTlqempBMy9HVjVGaFc1TUppVUpyN2xMQjJLRmY4ZzN2NFhiLy9C?=
 =?utf-8?B?L3dLczlrbk5NcGRpL3dyekxscUt3TDBFR0ppZnBMYkxVWUZxZlBmWlhpK2xa?=
 =?utf-8?B?VFlMNEtjaTUzMWVkZjdHNWEzSGhxQkhPMVJIbGMzT1lSY3Y5ZkR2Z3ZHS0JF?=
 =?utf-8?B?S1c0SXR6S0M4VXpEOXJuNzR0aVNjMlppejdyNUxhU2JKMlZTenVMT0EyamFJ?=
 =?utf-8?B?eUVSSVNVd01sRVErTGVtQlZyaFdzNXRFMVhqdXlMaWJmS3h2aWYyZ0tIU3VL?=
 =?utf-8?B?ODZiYm5XOWZjTVFsalgwaDAzQjlyRzZGeEZVWitvdHRnNUszRnlCSjlINVNW?=
 =?utf-8?B?WnRrM3BpR01KZzVHT0VCYkJLU0tsM2NtdDVyWWtXeWkxOVR5dm95MUtCMmNv?=
 =?utf-8?B?WVJlMjZ1VkdwWDN2TmhjR0ZGV2M3elVRZTFtOWJ5dGdYQkpIbmRlQ1Ezc3Y0?=
 =?utf-8?B?UGhYMkRPZEZUM3lINTRXUjZPSTRvQjU2ZXl4TFZqTVdvWk0wV3Nnd2UyTkRI?=
 =?utf-8?B?NmRhdytFQzJEU2lzWUt1N0xMNThmRlpjUnN5TnUrSGh1QUp4Z0dLbFpqYVoz?=
 =?utf-8?B?N1FJMllBMlNXczFiRGtpcmYrWnZxYlZVOUR6OHpZaGRPN1Y0Z3JIU0ZhTUtO?=
 =?utf-8?B?WDhUOEIvd1ZUazVjZEplYjRFbDNkMmZpMGVFWktMUTdBMWRDWHg5RWRxd3U2?=
 =?utf-8?B?cUMyUXhKTHByZ3ZLRmZVMFBxeU13WkcwSzc2NlZLY2NiNjg5Z24wbTlOOHlG?=
 =?utf-8?B?WGhrVWl3bmdEbkEvSzZtdkpMUjdHeHJlei9wRkhQcUFCVnRaVUdEaWFYY3gw?=
 =?utf-8?B?UURRd2hxNGJpYml1SWZLZDJBaFRKWnc3dVBJLzRhdGJtK1hKdVcrUk5FaTVV?=
 =?utf-8?B?RkZtUDYrRTM0cXQ4Yno3cEU5WmlxQ3FTeXpFMEIzclZHekVnODBtcjM2K2V5?=
 =?utf-8?B?MEQyWnRabG9FeW9Ga3M1MHVnNlhOMVJSV0JtUDdlV3FSK0N0QlduVy9UT2cz?=
 =?utf-8?B?OGI1VEIzbWxtOTNDS0dDMG01WDhFOFc3Y3Q1SVBqNDBCNUQ3UDRHbE1ENjFU?=
 =?utf-8?B?ZmQvaUdIZThWMGlzSlROL0QvNmJNbFFOY2ZscXNITFBYQ1pFUnJkUTF5d2Y4?=
 =?utf-8?B?bXVtRU5EV1FLeFkxRzExYVhSQWpudVBZRXorYVIvanBhQ2RVZ3JBaHpRRmxJ?=
 =?utf-8?B?MGZNTncvQ3ZaYVFWN3g2b25XN2VtK0xoRCtLaEdEVmU4aTNlQm1pN2x1OUV1?=
 =?utf-8?B?M0ZJdHliN0diMkM5RjVRankvSVhmZ01GSEMwMGNralZVeE1WS0NJdUNzUTdp?=
 =?utf-8?B?SmE2dzlTQmViR2U2anR1YmpzZW9CbjRoeS9jTFZqc2JSYkxuYW9hQmxjOEJx?=
 =?utf-8?B?dmJRWUN0UjRWQ1BEc1BiNjZFT0JJNUt6QjEzUkpNNHI4ZUtyMnA5R3M4OU9j?=
 =?utf-8?B?R2R5TVZmYnpOTFY4ZFBxbHlvZ0dTTGJLRkZGOXEzUFVjNXg5LzA1UT09?=
X-Exchange-RoutingPolicyChecked: qH6zSa/b9NYwHj2PvuhFHckwYunBlgRKDKx3b4ylQ2ghtPmHfbS2SWCbPlRZnMU2HocVteKMrtdFYXM/pCiv5R4EOnLIIYrjxlesHRxEF0hfiAFg/kZBWJwzRTw7DABaz5NypnJHxrgR+RMU4ZEFpIp8MP0WJv+9iY6sPUmLV00iByPN1z+nA9JymygbGosihWsbJyHZ9SfFlVgPgoIvIy5lLD8VZNSgxq0F2d9GQz/Xj8LD5MXnyLxIc2yUaafnbc878vNDGSUy5fM6AR/hDtP2D8DxbLKZVfeSw8YRJ8AxOlR8A4w7N6qcNBD/XFksm4fKFhGxUEs0APrXTrKvOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 688f4371-e11e-444d-f466-08df348cb173
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 00:44:58.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MM7RajxnOJe6SWffO+jL583lA817t392SiTo3JXWgB1kx0MmNa4TdeyI2J9l7XeMfwsO0v/24QcdIMTB9b5h5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com

> 
> Two nits below.
> 
> [...]
> 
>>  
>> +enum fred_stack_level {
>> +	FRED_STACK_LEVEL_0,
>> +	FRED_STACK_LEVEL_1,
>> +	FRED_STACK_LEVEL_2,
>> +	FRED_STACK_LEVEL_3
>> +};
>> +
> 
> [...]
> 
>>  
>> +unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl)
>> +{
>> +	switch (lvl) {
>> +	case FRED_STACK_LEVEL_0:
>> +		return __this_cpu_read(fred_rsp0);
>> +	case FRED_STACK_LEVEL_1:
>> +		return __this_cpu_ist_top_va(ESTACK_DB);
>> +	case FRED_STACK_LEVEL_2:
>> +		return __this_cpu_ist_top_va(ESTACK_NMI);
> 
> Nit:
> How about adding a comment to state NMI and MC share this one? 
> 

Sure, I'll add one.

> 
> Also, currently, FRED_{DB,NMI,MC,DF}_STACK_LEVEL are defined as
> number, may be it can be defined using the new added 
> FRED_STACK_LEVEL_{1,2,3}
> 

Good point. Something like this?

#define FRED_DB_STACK_LEVEL	FRED_STACK_LEVEL_1
#define FRED_NMI_STACK_LEVEL	FRED_STACK_LEVEL_2
#define FRED_MC_STACK_LEVEL	FRED_STACK_LEVEL_2
#define FRED_DF_STACK_LEVEL	FRED_STACK_LEVEL_3

By itself that leads to a compile issue with the macro FRED_STKLVL()
which needs the following change.

-#define FRED_STKLVL(vector, lvl)	((lvl) << (2 * (vector)))
+#define FRED_STKLVL(vector, lvl)	(_AT(unsigned long, lvl) << (2 *
(vector)))

It seems reasonable to me.

>> +	case FRED_STACK_LEVEL_3:
>> +		return __this_cpu_ist_top_va(ESTACK_DF);
>> +	default:
>> +		BUG();
>> +	}
>> +}
>> +EXPORT_SYMBOL_FOR_KVM(this_cpu_fred_rsp);
>> +
>>  /* Must be called after setup_cpu_entry_areas() */
>>  void cpu_init_fred_rsps(void)
>>  {
>> @@ -84,7 +102,7 @@ void cpu_init_fred_rsps(void)
>>  	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
>>  
>>  	/* The FRED equivalents to IST stacks... */
>> -	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
>> -	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
>> -	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
>> +	wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_1));
>> +	wrmsrq(MSR_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_2));
>> +	wrmsrq(MSR_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_3));
>>  }
> 

