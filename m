Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794383881;
	b=H/HdoIA9l0W9fgrCHimDzGTUnY3/WINJRtlXN1PNBCjuk0jDGl8Wxs9BsFNZKP8vP9ov
	 N92GHL52W4KwZf2cx/aBs7Xx1hKAaXTYfru175iLd/5HXbepv7a9Ecm9hySH3NY28cxaM
	 EN7iyWesU2os/voXh0IWEpAa4Fsfc/HffmkFgne4ZgsuH7smmlEp5CBmIH4OWsPNkMUrO
	 zL3ceLLaOVX4T3sBcEDHCXRn3pzH7Ojl3qDTUyPyv29FOfNEQjKGvXA5sdOV6gvYrLUA/
	 SKKfOdxXdpbADe/fGG+SKzWXfB1BStbIj8DySi+bEf1oQUbUF+Lm6kiYinC+ID2z/Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383881;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=K5n/FQvKhipajNUNAc44zdwaemBJbMHgCBPfhAJsjTE=;
	b=DV7/lYhV4RH8p9mrXYGnfwmXNanwn84gezO3dESsvSwG2rc6UOaLZz7VFIvTZyMBiCq9
	 QF5xx5ISbWsRdxkqgamlOsNhI/LJvu/qXC0gpUkNBtgRSYuqboaMHbuVeKjxF383IgsS/
	 PSw4q5ptur0P75D5PrOrXVHqSjI3GM4ukQfPUdjRPIwUxTNmyEDojLtWyIeGa5HFojIzv
	 w3+aymUgwjqBdmvzgSm7/LPS9e+Kk+qNx/u+3loPs+0CjbxWBG7bzDLZzZgfsJ5HJB5cO
	 BdZLGIFJlFRJ6X4PWMwSB99P9FbIy72mkrgMfK/oTaxXIRmIKzZUICojGC2LyuUXcPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hratg650;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE5606A321;
	Wed, 11 Nov 2026 07:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1CE5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hratg650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794383881; x=1825919881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XQIWPlJOggAchJCUyuilIbvP46JemBDdgqNuZi1ZbwQ=;
  b=Hratg650Gw4YYcgR0cVLBhJ2kp+93A9o1BFMXbnVh52d5K6gTR4jez0d
   8xnjY4tksTmN7JSENRtkO2aMseON+eHzzg0Po/fHxS4x8Un+7CxK0VWA9
   OcTTaYA1VFNoPJrUINyhP8m6SXYDyCxbTI7RsepsKcReCYt487nNhLhR3
   CTgYfX56VNGCFoft1udOORSnos20C5YACIILo8eFKUTCn3qNfGFqHlEG7
   eIGyD/x7Gt1EgT9ZG01FIpzIIBMBQmW7in89Ee31XxR09dMmoTrA+uyJX
   tlHUSw4WxKjv/xozdBssiSuSftYpU+r7lTgk5Bkmuw3LlVxZhHSSnkayE
   w==;
X-CSE-ConnectionGUID: 7ZQOxjwTQ5mfzVYnnhdQGA==
X-CSE-MsgGUID: 8OYXVKkrTgWd+n+Olz8IbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3194283"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3194283"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:57:58 -0800
X-CSE-ConnectionGUID: lzHQiXHzTAyJ1Up+0hvNVg==
X-CSE-MsgGUID: AoloGWjzQUiggKNsNZSsrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8704032"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:57:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:57:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 23:57:57 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:57:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv+8XUlqKTYM5KMTe3ojZtNrnc1q3x6goBvzxx1LbBe3fWXHZahRi7SXT64ZhaUCNauFShqraYgYQJnpGwmDfSxi9RtbNOAAWdk/0ZEvUXOkoLkux3XDjsdqbz+WwZSOuL5V88lg/6TS26QaGa8PgexMLCY6umpcHV5r7e6fQESQYQbFOO6jvGxT31gV3ovpdDQsN2z7LVpfXE+oWYX0Z5JOnSZqv03usuOB+dItNglZpi7p9tJ0xJGbH5G16MdZE/tTWu3c3kUueKEXVfSGQKIYBPTPddEWBwK0BOX6TEpoVFtH4ay0ASHhAekqjrhvpP8T4aMYNzgs7F0axvWvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5n/FQvKhipajNUNAc44zdwaemBJbMHgCBPfhAJsjTE=;
 b=bfkB0d9XCDcloQrgAOr3J2EUvDe4fIJo6yUqSY8WnER/5UI5gBSUhyzK+S73lLoo3EV5a1Hu0wReWP7XztVImpZvrMbujuZXtasILymOVgNEGTs+C3VWqv27rmN+AxiTcbfjNk78HPOVNWukXonYZTRwgt6Nr/lEKNNhBm9un/ATCYJG0K1xK4q2drXw1eX57GZlyxF9QCORd7bBl3uyTuSJq+zNMUJwi7QAIxB+zk/NwJR5JBV1aNd1+KIEmxMi7rhCwosC1LybuDdVqFjFNx5gZgsVcbbJL8o4HwISZGOkzrCx88AEmgZIwHzjCmD7KcqfFVAMhB7Syw4L/Q9jVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DS0PR11MB7261.namprd11.prod.outlook.com (2603:10b6:8:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 07:57:54 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 07:57:54 +0000
Date: Wed, 11 Nov 2026 15:57:40 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Van De Ven, Arjan"
	<arjan.van.de.ven@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <avQf9L0CYU0LfgJh@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
 <20261106132159.1551365-2-chao.gao@intel.com>
 <0ee3d9592e4e73bd0e5bedafc836033fdfc9f120.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ee3d9592e4e73bd0e5bedafc836033fdfc9f120.camel@intel.com>
X-ClientProxiedBy: JH0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:990:57::8) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DS0PR11MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: ec785bd9-b0d8-497b-25b9-08df3fc97d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|10067099003|261022105027099003|56012099006|11063799006|261102123227099003|261026121527099003|261022115727099003|261028144727099003|261026140227099003|261021121427099003|261009223027099003|4143699003|261022075727099003;
X-Microsoft-Antispam-Message-Info: qGT/M/1c4rBx7A/qyPXtTUwtBSILrksN0vUNggyKQsRTNdq9X6D4PzUd9Af+hqk3Un4eCpcz4C/2XkVDqQe/qxPvnNWVhMN+AhlwYzSEgVhHXhuRw1izGRPGKL3J/erQ2FGUJ8sqA0+4DHMseIqZ8MRaQ3uInl97ud/nSOTABunYtuwuvGPRI2l04CuwKwIaHb+Cc6WLv13Jy6/Rf83xD1WaDguGlAbmUBNcQkR+JzVFooq7zYjZk5lrWNOlVm503BX8C559cnWNMmFWB2ljVndEvhrhcfTCqig05SvooZ/KalD8lE0euCfluZNFEuc4mcSVS9puX6tH8mNPZULx7v5F/Z22ntGkkXbJniQHk2X1UCBRaSaf4QF19TR8J+euu738sVE8vOklr02teQeyL47Hi26Uycnuh6aaZOT2fzN/Libx6EW2PEz6qVKq2Lu754kZsKuMNcYTxwPo/yi1ybUn9TR9ykwf5j36voBoofVhtW1ojs2EWN+iRSKf/DNZ/sgDszUCr9Ld2LigmUH5O6xVgAZXwC4jZYFtkePEejxkqLfTCZvZqhZ9qhvFivm8BhGAnDTt11p7jcpmmmsD99wNH50lMTYtEuCC5EIl3LKAxFDyrg6KpnrJnE4S8VYiQ9vZsN+KpFjupP2OP2vhWLVBOsawIR5NEUkEqlMlevQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(10067099003)(261022105027099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261022115727099003)(261028144727099003)(261026140227099003)(261021121427099003)(261009223027099003)(4143699003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F/H3cr9LTAQN06EkP+8UcREq4bTPu50zvsI1WgwjdDYgqEN/CjdLvxvSQ8sS?=
 =?us-ascii?Q?V2HWZiOPpGCHclH1KdEgAfZko5c2ylixtp1zFOMZGYKOu7zF+S3QeQeasZZE?=
 =?us-ascii?Q?gt2OKlSRHbaoOLMgSEgrD32Iuu12ef9QdTX67Kjm7LKQYIMpTOtYhH810mUY?=
 =?us-ascii?Q?TS2OsnV+Rt1zDnhxvRPKTl1h1FaaTHFFfVn9NHgCbzTOeBIdN55QrqMEM8u3?=
 =?us-ascii?Q?eUH3XRccBlS6UpfFRuK1KciUx61AxpGZIMG/1vkZDtAh2aDKHQWbV/6L06kE?=
 =?us-ascii?Q?IZwIKFOMjoY6cqfWmBCtAP1linpLvfubw2YUgvQql+16vUOGvkzJ46ZEnnOa?=
 =?us-ascii?Q?YJU2A7cgIF/1oHGvmImQuDh48sckwdmP8gRbI8CqfvJmieyGhbkoQEBHPDVA?=
 =?us-ascii?Q?d0QtUuySOxb+9i0lKM3WvGt4M7AAO8MIlKkpyLZ4iPklIgqCTRrywFrIar9y?=
 =?us-ascii?Q?hkBGRB74OlVH0a6zMndKu2TZXpsGRkHPwO3s0r+WOf3YHAZmrfoAqf1Cavvx?=
 =?us-ascii?Q?4orjjdOY5LUJK8yB1OCrHpS0qSV8amGRyDosq2GHYW2pkSI91tGVztp1zmHW?=
 =?us-ascii?Q?qBIWhs8et6AFaTSse8aQc7jZen2vdGfq+yP1HPkTnFKsk+mkndPl9eIz0FCI?=
 =?us-ascii?Q?4+6M3zpIUgbs5guRzGRD9fkgWkLfTr7Dufwa4rvXqrwawmjyW2R0GNFCJm/t?=
 =?us-ascii?Q?GwNfUBdUHcaEfxm4ZhLQVQUwwbZMKimoljBwadooBK0/kDQ9kA7DSf32Tp0q?=
 =?us-ascii?Q?bLGpdOJ6bdabIzSa3w4k4JMsVX+I6K5jc2t1rVHbCxOrO/nMb7g6eBzPQojv?=
 =?us-ascii?Q?juIL7/WdH790/OxWGHorDtL+z8wgqg13WaCVD7LX2OajFhPqBOqyV8MmcAm/?=
 =?us-ascii?Q?k+mK89bQL0CyO+Ge1nE2larrCXc92UMC2aROjRRQqLu2wifoG0gAtmvPQPP1?=
 =?us-ascii?Q?pZuoAFkhZO22spzq8nIZ1ySpI1Yf5rqEytMQtxWSqWYFf7RUkLj9I8bciqK3?=
 =?us-ascii?Q?7TukobRWnFGqs34GRlrxlhxdg7LzjKn2S1NxOWj6gqq+ZxMDq0Fqpx7R986g?=
 =?us-ascii?Q?wpWIp8+r72Jk/fmiS4KHAPY8dSp33LLDEJ73px1rAQ+myLyBu1RHe085IvQa?=
 =?us-ascii?Q?mvqbXzN8skWWA0RFT5fUjJVaYW902ahF1DEI6QOjyzWdjxqIeXhnckpGI1d4?=
 =?us-ascii?Q?Xo2jX7mcEjRl3veVNN50l0WZ/pdEThcVfiApmaPMSLJgrJLR1q8Eqtv4PxxX?=
 =?us-ascii?Q?nV7FQLhFsuOA8TBbxzRLYlYs5xzbS0QZltGrKMIJtYkiTwo1kdWhws1etFx+?=
 =?us-ascii?Q?/PQ76It9shUhbqnqSpA0TYfe/fdbYNxUV0g7qClNVvWOchCWX2QpYvdUrjuy?=
 =?us-ascii?Q?gu4D6DvsmO7bLcWky1iSMqYsBr+oJh186xAxuDMFPPtHszi7N6hNqazbRXNa?=
 =?us-ascii?Q?rOEh8TP5qu+KSNmkdps6OEvSwbakY+qP1TyqCaONsMHNLDWXYFjUqPUhF0AD?=
 =?us-ascii?Q?N3cXFiLYnFIduJqvWCLzvqZzBT2sKJI+3RCYkLA1EpN9EyoPruBIc4j0g+6n?=
 =?us-ascii?Q?TnSjC2AqTLCm884mzrZKGmRiZZUfB1wDRT55jL3E/83VEDusNRy+YnJExR7E?=
 =?us-ascii?Q?bYa1dX+aYRhU9ueyIxJxHJGqa/n6R6Y5WaZKgRf6e1XTuMs8AwwkHFcTKX26?=
 =?us-ascii?Q?Sphh4OLGzv0noIQl085e7d8sYtL4hHExRwQA4kGpZCbGVf7pZnQSB8NsyJ6i?=
 =?us-ascii?Q?aFCY61gjKg=3D=3D?=
X-Exchange-RoutingPolicyChecked: xJRfsfErWAvpDGhwdp9CbHnFvv7fUNZc/v80TOgjYmDSn+ftrG0EwS8sHqw8tQMReKAeCpdwsNqkyGc8JEdURYRKVcMAghBYn6aNE7u2unqpuxrS7f4ndlOqplqhNjwbGAc1EHuUM8NYNhBOu78WGQ5ABqp12HIJQwvJPswycQn+zHi5ObW+CIwukctI124Pm+EOHrowoHhzw1+DtlYFSJaTmOw8UHa6dNxsc16vThys0cfKTQ6A6CIV3RPpqAn2j+NBF+XRIUz631NaAiIy8sVXJV0WJlotS8ZAZTYb7chWAvhqNEWxZmaU2kJ0Xtp2SY5W6gXWXCgunye05txFHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec785bd9-b0d8-497b-25b9-08df3fc97d4e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:57:54.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uAMyH0FBre56TV1wgZ3VXt6gJi1CCWQdxVHxBdzIW4KtbJAdApg3qbCvp0kwORCq2irS14DflkBmAXW7IntQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7261
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 06:34:29AM +0800, Edgecombe, Rick P wrote:
>On Fri, 2026-11-06 at 05:21 -0800, Chao Gao wrote:
>> The module binary is handed to P-SEAMLDR as a list of page physical
>> addresses in 'struct seamldr_params'. The list has 496 entries, which
>> caps a module at 496 pages.
>
>nit. change it to "...caps a module at the same number of pages".

Ack.

>
>> 
>> TDX modules are gaining features and are about to outgrow that limit.
>> 
>> The P-SEAMLDR ABI was extended to chain the list across 4KB pages. For
>> a module over 495 pages, the last of the 496 entries points to another
>> page of entries instead of to a module page. The last entry of that
>> page can point to yet another page, and so on, until every module page
>> is listed.
>> 
>> Grow module_pages_pa_list[] so that 'struct seamldr_params' spans
>> multiple pages (16 for now), and use the extra pages as the chained
>> pages. The last entry of each page then points to the entry right after
>> it, which starts the next page. These link entries do not hold module
>> pages, so leave them out of the maximum module page count.
>> 
>> The 16-page size is somewhat arbitrary. It fits modules of up to about
>> 32MB, far above the roughly 2MB of current modules. It wastes 60KB for
>> today's modules, which is fine because the memory is freed right after
>> the update. Sizing module_pages_pa_list[] per module would mean either
>> moving the allocation after the image header is validated, or allocating
>> from an unvalidated page count. Either way it is more code churn.
>> 
>> Do not query P-SEAMLDR for chaining support. Userspace selects the update
>> image and is responsible for ensuring the module is compatible with
>> P-SEAMLDR.
>> 
>> Thanks to Yilun for the idea of allocating the chain pages together
>> with 'struct seamldr_params'.
>
>I'm not sure what this means.

I previously allocated the chained pages separately, as many as the module
needed, and linked them from 'struct seamldr_params'. Yilun suggested
growing 'struct seamldr_params' to include the chained pages, so a single
allocation covers both.

I will credit Yilun with a Suggested-by tag.

>> -#define SEAMLDR_MAX_NR_MODULE_PAGES	496
>> +/*
>> + * module_pages_pa_list[] spans multiple pages. The last entry of each
>> + * page points to the next page and does not hold a module page, so the
>> + * maximum number of module pages is the array size minus one entry per
>> + * page.
>> + *
>> + * SEAMLDR_PARAMS_NR_PAGES is somewhat arbitrary. It allows modules of
>> + * up to about 32MB. Increase it if modules outgrow that.
>> + */
>> +#define SEAMLDR_PARAMS_NR_PAGES		16
>> +#define SEAMLDR_NR_MODULE_PA_ENTRIES	(496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))
>
>I think you should describe the math a little bit here. 496 is the space in the
>original format, but the last one is now a pa pointer, right? So can't be used
>as a page of module data. And then each successive page is 511 entries and then
>a pa pointer? So is the math actually right?

As Binbin explained, SEAMLDR_NR_MODULE_PA_ENTRIES counts all entries,
including the ones that point to the next page. That is 496 in the first
page and 512 in each following page ...

>
>> +#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)

... this subtracts one pointer entry per page.

How about:

/*
 * 'struct seamldr_params' spans this many pages. The number is somewhat
 * arbitrary. Increase it if modules outgrow it.
 */
#define SEAMLDR_PARAMS_NR_PAGES         16

/*
 * module_pages_pa_list[] has 496 entries in the first page and 512 in
 * each following page. The last entry of each page is reserved to point
 * to the next page and cannot hold a module page.
 */
#define SEAMLDR_NR_MODULE_PA_ENTRIES    (496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))
#define SEAMLDR_MAX_NR_MODULE_PAGES     (SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)

>>  #define SEAMLDR_MAX_NR_SIG_PAGES	1
>>  
>>  /*
>> @@ -48,10 +59,10 @@ struct seamldr_params {
>>  	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
>>  	u8	reserved[104];
>>  	u64	module_nr_pages;
>> -	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
>> +	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
>>  } __packed;
>>  
>> -static_assert(sizeof(struct seamldr_params) == 4096);
>> +static_assert(sizeof(struct seamldr_params) == SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE);
>>  
>>  /*
>>   * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>> @@ -129,17 +140,24 @@ struct tdx_image {
>>  /*
>>   * Given a vmalloc() allocation, write all of the backing physical
>>   * addresses to pa_list[]. Caller guarantees that the array is big
>> - * enough.
>> + * enough. If pa_list[] spans multiple pages, point the last entry
>> + * of each page to the next page.
>>   */
>>  static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_len_pages)
>>  {
>> -	int i;
>> +	int i, j;
>>  
>> -	for (i = 0; i < vmalloc_len_pages; i++) {
>> +	for (i = 0, j = 0; i < vmalloc_len_pages; i++) {
>>  		unsigned long offset = i * PAGE_SIZE;
>>  		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
>>  
>> -		pa_list[i] = pfn << PAGE_SHIFT;
>
>How about a little:
>/* If the current entry is the last in the page. */

Sure. I reworded it slightly to also say what the hunk does:

		/* Point the last entry of a page to the next page. */

>
>> +		if (PAGE_ALIGNED(&pa_list[j + 1])) {
>> +			pa_list[j] = __pa(&pa_list[j + 1]);
>> +			j++;
>> +		}
>> +
>> +		pa_list[j] = pfn << PAGE_SHIFT;
>> +		j++;
>>  	}
>>  }
>>  
>
