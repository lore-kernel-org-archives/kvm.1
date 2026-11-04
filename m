Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793798072;
	b=nAElC+g+b9+yWuTkaUPzMNvlsH0k//xk+MNcUZdpt27yZ0MzRriKmyXGUNenD9uzIABp
	 9aKyOtOHoAiPDv7MVTTA99tcxDeMhp/M20vW4kQqThhrK8ozvm0KdspD+JPouL2eQs8XI
	 wDl24Z2/Of8wjh9149lZlMkfGDDis0jAwdojUbBduhrjt+hTD4hYL3ICgvU/3CtZuJEUb
	 zApNdT41uO252VLTkvxTWGteRnWdyvvpdbFz8zYLRuB6qk3To8DSzCnVwEa0X+XsQCM41
	 1ICAXosx2a3LPswd7oLxLx7zIQBNM5zq8ZM7dXk9lxuHjPfy+JdjmQcGCyfwBfUB7kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798072;
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
	bh=irA0fOOtzcsl9SNo83KmQaJNaa+NjGkrhdkXZTgEE2w=;
	b=opda4wCNviNTanbrb5tbJZ4Wiy89rozWNdmaqyBpq3FvrAdZ3A+XpAOHw2Ye9mO7B3h9
	 lcLEIC50MBSBG3zpo7IV0oaIwPIEKIa3ddK9jHZlH9UexRiw9woffx86d8GUpeXawTmW1
	 EWHJW7pxwBHSMskMhQGn0BH2vABAUCfEUTQ9t5VykpilR/KXSPajeh5vm9BH2RcemYS70
	 GS+kzP6+WXffk27SpVyTajBfpYWQmzBYFHUBOu9VZLoB2JVgtHlWMjioGFVM5Bs/WlgqW
	 HP8vVr8PH+/1NwJACC2W4+UX9pkV0dzkpEIpbBWeBWZwgKjIi/oiR2w7MhRdMGYUrLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ANDYa0i1;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3CE606A326;
	Wed,  4 Nov 2026 13:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3CE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ANDYa0i1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793798070; x=1825334070;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M2Gr9zQ3qDkrSl1aSV9V9KCRE4CBNEM3hd41hmHPusg=;
  b=ANDYa0i1A4gIKmN+Y9YYKWvp7hgdZJG1CMyXMJOLaRytfjOAY5ROnq+P
   HqP0IrnCfZ+905HvjSR0Bxe3n/gLHRGCPWmjvjYOQ1QL4jck8TXAzXj2U
   91WfYnKN3A6AIwD4lR0GdQat1u4O7qeLUUJVwTTzs7utSnfDTMLr0D6Fl
   Lyd2xvVMTzmHlikwkj45Eb9Vc3PjGa/SakGLelBX/b0yTnAEe541X7iET
   1LYnMd1D//McFHvWs1+yolMyOzGME+KwF0JICnJCyg4yf6/zuAodWLeGw
   T15XsNzN43Mfm4OsOAF13FK520ln587srfZpI58P7MtLD93d5U/9ZbHnU
   w==;
X-CSE-ConnectionGUID: Td1iox6yQxKhyrxozoCgXA==
X-CSE-MsgGUID: kFZOBbuEQyu/ko52i8nZWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2546619"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2546619"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 05:14:29 -0800
X-CSE-ConnectionGUID: huHLXrBYS+Cy9DE3uB6Cvw==
X-CSE-MsgGUID: d7Vc+DNLSIuCsiuf52xJTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6580563"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 05:14:29 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:14:27 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 05:14:27 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCh2HwVb51KTL8YurVlPuEVg3FUT9JUz/IxvE4rrqoissBcpUpTjL7nBgGc7ZO7YOgM/ZaqgSL2t6cd+hTTZfUFnjGMuyMGS+Eboq+qzcM1gTbcwM1wkX6ziRTzJ8e8Lf7qwTv1SIFBvtvcVM63ca/wdrpV2TWgsiVAHPsfWXZLexicBpycZ/CJL5TNgWNOpOU4+vr3nUvT87aZAtGBajMLoI9hE4YCH+rR/Rn6/Ob1ue5cCggeObRGyORIwPC3jwfY6uAg0J3UCaz5jN4ABj0UgVTE8xZzsb0Ip+cZ7EWoP/9w2phcFIHN/w+xCOGSz9wKi9pGZSx9U9aj/tiepaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irA0fOOtzcsl9SNo83KmQaJNaa+NjGkrhdkXZTgEE2w=;
 b=HI082XRBnIfxMihFvkPzEj/rLkYosSHp3S34c7nSzDFt43NQZQZud+4LH3RWVEocjnI2kc5VnNPb4VPpksvHF8Z+cbBYvxKuDjXLLAvOoeHOz51Kb4hK28rdkFZHUwJqIWIiu3nT9Qd6YqTCTCYdsVsWZbHkieIy61K2W6688QR2vbImWsj0pPg96ZDsliuXZwIAqJ85LKvs2zp+MoRWeqp7Yz952E/fTo6B658qIF6HPnj+FE/DmsSgEyMJhft8aRe/AIUMJ3OPumjzkedQmpvVlrx9n/hiW6rc31KYhN7OICIWPaLTCa2VbmO2o9/BtYmW8SRnVFpCDLgLkvHXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by LV8PR11MB8512.namprd11.prod.outlook.com (2603:10b6:408:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 13:12:42 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 13:12:42 +0000
Date: Wed, 4 Nov 2026 21:12:31 +0800
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
Subject: Re: [RFC PATCH v1 2/3] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <ausvP4vrZ3PiXFT8@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
 <20261030085304.3886520-3-chao.gao@intel.com>
 <396de152b28fc1be18bfd61fd0ee7501c188e661.camel@intel.com>
 <aumh_q8olQPwH0pe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aumh_q8olQPwH0pe@intel.com>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|LV8PR11MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: d9190896-647f-449a-4339-08df3a754ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261022115727099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: toU9fJh+P7WDK6yeYxrzQanf66GZmB0PYgIrV+wNFNQ0EK794IgObRZKF++lm6rpzCEFPduOqwK0jIY5l/Yulus78J4C0gWnoAsiuTfzSHtUj/wePaCXcyoMcu11m7pAXa3t8004Qz2lBSrWsDmVo7PuzVxDEFwPxlpa3IrQM4zwtYJbR3VEo1vfGir2K2omk8oa097KLgOcoUSQelCq+pnOpWKv6LEUEUO0yVcWJLF2KnIH2NE9LyYxkpE4qra88g7PXAvmmgKwayISW9X/aUru1lfyTONcya9k50AJX2UdMmGgJeFVRN+DMAA6LqhdoQaYdoqDfeioLATt3SAyO5aWCCxo1i3bnIUFijrmqgfr4HPSUCsRliJsHvpzVgnYRpm/71+8Pr7cq3zj5Sy27AzS+QptwL5q5NMn+stoSv45wRRwPNDyosX4FWDDfM4Few+z3agfedgpZNQmDr7npOalH+pW5+Dv4ouCuu2lGO9K9siTsAobWuawqUQGxN4nidU+iqwK29Hp76FWo5kOeSBMGrIzN/vwlEy871IqNKfSOm5ngr3cYiwAUHRm70PvEMXtxAZ93YESlPOTZBOTQBhLgSAc/2pA01a1HCND2UbBaBfCF4LxzWfK9+lGmZj9+jnccXu5b7q9puT+NWHTmiXU5AC0a6vU4lL7x7/Eq+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022115727099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jn5WQ7guiv5rd+JsKwWlTao+hnv0r6LVnXk7+TIfhXAaTZz2h/Jo8f/aXXDG?=
 =?us-ascii?Q?2pZnJUX1Yit9X0kXF/HejYcJddP2kybeFhiAbqgdQPg+LMI3PL2w6Oivj/RR?=
 =?us-ascii?Q?gCZby7swWjAvrb4UBnwZtNQrnMQ21Pwd04ebbOlvRQwxBFlpHwozOa5qh7YT?=
 =?us-ascii?Q?3NPG/hTIAsf8UNmyzNAs0s2JBM2GPvtD6iCDQ0v5XlbdVnxgGgtBDmYc8Ze1?=
 =?us-ascii?Q?yE1Vo9URkBO5MgzaDzgj/K1bt7vsHRWZL3pDJhGl3Q+37EzDpHjwtlvEixZq?=
 =?us-ascii?Q?Il3u7jygdr9AKxEnzG4HNBJQ4DjYSNScQLx9iPzYul4hYDMgyerSVfCReBaK?=
 =?us-ascii?Q?7bHKqppoIR/h6EbQ/nzDM5Th8QoVjl8SAc1rnwYCF4fPtgb3Yb5KJjsowlCn?=
 =?us-ascii?Q?ZQS/+O+U80Vbp185X1NyeTHBULmhOtdg+PocGXKx1k4Nn2dbTFabqhopBQnP?=
 =?us-ascii?Q?TR0pdwMVgVb0v2GS89q9dM8UKTeIOhe/3rQ/+9Fnc7rMQBoRcWYrStbowEh+?=
 =?us-ascii?Q?X8WiCkWETxuCgtDgHHjHNtj2xlyuEAbX5vZkq2S2JRXABVjb5mJa/wyvH+ts?=
 =?us-ascii?Q?ulxhkkdGeTdOGWC2212dgai2OaYzJQ3qXXIpLFJRv+PDIFBWf1pgCUglqvhH?=
 =?us-ascii?Q?HQAniaWCr0/f1yqFrWDV+T3Qu4tjmstjMMKDSonp9ENGh6C72cOO6P5HC09P?=
 =?us-ascii?Q?m/0PiZb75qmbhdTw/TX6x4JYUcfhNqyOTf3KHQC09GbbwNUOTj7KDkkey2ol?=
 =?us-ascii?Q?AbFZHh5OhDg5zGbklopMq96Pm7mk/hpHpZl8x7mlazvmGTcFQ0Ww2zPtoVxb?=
 =?us-ascii?Q?S/Wgd2CL4Tkjlnq+IxwQhYU1cNORvWmxXtu9JYXJUhZTqNKWudawDlQD/4iC?=
 =?us-ascii?Q?ZYmzWkJ/xakMVpydcNDwwiS49o9nWCn1uGjdHQ98ueyBvvjnfW3HKvx2wQqo?=
 =?us-ascii?Q?H4IdegeAXLbcrB4F4NWB50KWKa8S18LPbEkbZJkpiD4ivhHPdMnv8ppvrnSo?=
 =?us-ascii?Q?WiPdv7GNpvhdc6A/2bdyEY7f8dr0Hz+nMzO3ciqXK2Qh415xXBQkr3cQ/s3b?=
 =?us-ascii?Q?2S96Hd5euBa0JdVPVd6dVvL9ZI3GoMijhmnUR7+vCiD2sjXBEgINmG11cGVI?=
 =?us-ascii?Q?gKeEKVyh7mL2ydlokUluSGbwqHTICFVjzdPBLpT8fm1MTMXpVSVE7vxtoECA?=
 =?us-ascii?Q?+9+dgtpQZhR6FUMteS5vlMMiUzdKQMDPjEKtADbQHfVUOsVxy1i6TnkdMS1u?=
 =?us-ascii?Q?91LgNkkzSN43BfeJqC5wIKhpAWtSOzLOAUcmkXK0Y4pN1FBRCQVb0KW2lPqL?=
 =?us-ascii?Q?jIK/r3E7gmE5gAqKxvhNDw1PIbkNGItw9aOoF/gidcLJyIhn/eUfG9n74JG1?=
 =?us-ascii?Q?SC4xwPDJu5qTQvLhfn8H7dH9hzBv4j9GkqTAJDP9xLH4HD07KWODqVTcSJgg?=
 =?us-ascii?Q?/DI+9IAfq9LqXINJCtl0XErxKUBK4yyd8LmQx0jk6ND1xrqzVEgOiEou5DZ6?=
 =?us-ascii?Q?FDeIFsiAXrYggStVOha55sESwQv//jrCZR1ajB3AkdankNh8iVqlTEAtBWet?=
 =?us-ascii?Q?Cw/RobB/+tDM8iixTO2HmbHpjirUnsUYjeEWdFpp4raTmzlt5pN0JYn3uQrp?=
 =?us-ascii?Q?oLOQKJaTV785wK2VAbNxGQgz3XDrLKQu0vWkfl+lCNrcwJM5od0sQFLceljn?=
 =?us-ascii?Q?3gk03MMOXudI/hNmgnqLLa6w0jWDsG1gUCjNJIce1whjYxW3sARX+U+YRo6p?=
 =?us-ascii?Q?KiCzIHTu7Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: DmEc1fqgbPnTjg6MzdX8XYFBik/POushJs4LSmmlsSGrg/aUNN4EgHrQgg2lYxRVH6cgsJ3og7/Tr8SDZW5pD2Z0aY6314eGGWSL3APk028pSsM7X2j9214/Tdby2NWuBYsfkczCtJ8t4eZDRSgnr2yC+Xgz1pzvj55Hc6iOEePgmQFyXklcrITCArBU/PDVc+DNfmYZQCZd8tNiNDyS99PWQlTYOeOZYrdi9pIgjIzFi0TXGawrw85KvV+Nmxvf0cLWZj8ehRYdd0EevMlsxj9cStNnsU34xl8l7UxnONKgPwf7/mFsyg3N5pnR5l3x6N3fkVB/26zdzgd3N/robg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9190896-647f-449a-4339-08df3a754ef1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:12:42.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ll7rZhtjUPDXGiefh8LenCgmLYER//xgJGqMqb7inj/Pr263DkgDLO4vF+4cb2vjf7RpqUb/bfb7wWkhZ1dSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8512
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 04:57:44PM +0800, Chao Gao wrote:
>Most of the complexity came from sizing the allocation exactly. If we
>over-allocate a little instead, the size calculation becomes much
>simpler. Making module_pages_pa_list[] a flexible array also removes
>the need to treat its entries differently from those in the chain
>pages. And linking the pages while filling in the module page addresses
>removes the separate linking loop.

After an offline chat, Rick suggested going one step further. Instead
of sizing the allocation from header->module_nr_pages at all, make
module_pages_pa_list[] a fixed size that fits any module in practice,
and let the existing header check reject anything bigger.

That removes the size calculation entirely, and the prep patch that
moved the allocation after header validation is no longer needed. The
updated patch is below.

commit f7f4359f4106df373449c0cf821f098453e36b9c
Author: Chao Gao <chao.gao@intel.com>
Date:   Tue Sep 29 23:20:35 2026 -0700

    x86/virt/seamldr: Support large TDX module binaries
    
    The module binary is handed to P-SEAMLDR as a list of page physical
    addresses in 'struct seamldr_params'. The list has 496 entries, which
    caps a module at 496 pages.
    
    TDX modules are gaining features and are about to outgrow that limit.
    
    The P-SEAMLDR ABI was extended to chain the list across 4KB pages. For
    a module over 495 pages, the last of the 496 entries points to another
    page of entries instead of to a module page. The last entry of that
    page can point to yet another page, and so on, until every module page
    is listed.
    
    Grow module_pages_pa_list[] so that 'struct seamldr_params' spans
    multiple pages (16 for now), and use the extra pages as the chained
    pages. The last entry of each page then points to the entry right after
    it, which starts the next page. These link entries do not hold module
    pages, so leave them out of the maximum module page count.
    
    The 16-page size is somewhat arbitrary. It fits modules of up to about
    32MB, far above the roughly 2MB of current modules. It wastes 60KB for
    today's modules, which is fine because the memory is freed right after
    the update.
    
    Use a fixed size for module_pages_pa_list[] instead of sizing it to
    each module. Sizing it per module would mean either moving the
    allocation after the image header is validated, or allocating from an
    unvalidated page count. Either way it is more code churn.
    
    Do not query P-SEAMLDR for chaining support. Userspace selects the update
    image and is responsible for ensuring the module is compatible with
    P-SEAMLDR.
    
    Thanks to Yilun for the idea of allocating the chain pages together
    with 'struct seamldr_params'.
    
    AI was used under supervision to review code and workshop logs.
    
    Signed-off-by: Chao Gao <chao.gao@intel.com>
    ---
    v2:
     - Make 'struct seamldr_params' a fixed 16 pages instead of sizing it
       to each module, capping modules at about 32MB. [Rick]
     - Drop the patch that moved the allocation after image validation. [Rick]

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b1137ca6150d..087bdf10a9a7 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -24,7 +24,18 @@
 #define P_SEAMLDR_INFO			0x8000000000000000
 #define P_SEAMLDR_INSTALL		0x8000000000000001
 
-#define SEAMLDR_MAX_NR_MODULE_PAGES	496
+/*
+ * module_pages_pa_list[] spans multiple pages. The last entry of each
+ * page points to the next page and does not hold a module page, so the
+ * maximum number of module pages is the array size minus one entry per
+ * page.
+ *
+ * SEAMLDR_PARAMS_NR_PAGES is somewhat arbitrary. It allows modules of
+ * up to about 32MB. Increase it if modules outgrow that.
+ */
+#define SEAMLDR_PARAMS_NR_PAGES		16
+#define SEAMLDR_NR_MODULE_PA_ENTRIES	(496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))
+#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
 #define SEAMLDR_MAX_NR_SIG_PAGES	1
 
 /*
@@ -48,10 +59,10 @@ struct seamldr_params {
 	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
 	u8	reserved[104];
 	u64	module_nr_pages;
-	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
+	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
 } __packed;
 
-static_assert(sizeof(struct seamldr_params) == 4096);
+static_assert(sizeof(struct seamldr_params) == SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE);
 
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
@@ -129,17 +140,24 @@ struct tdx_image {
 /*
  * Given a vmalloc() allocation, write all of the backing physical
  * addresses to pa_list[]. Caller guarantees that the array is big
- * enough.
+ * enough. If pa_list[] spans multiple pages, point the last entry
+ * of each page to the next page.
  */
 static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_len_pages)
 {
-	int i;
+	int i, j;
 
-	for (i = 0; i < vmalloc_len_pages; i++) {
+	for (i = 0, j = 0; i < vmalloc_len_pages; i++) {
 		unsigned long offset = i * PAGE_SIZE;
 		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
 
-		pa_list[i] = pfn << PAGE_SHIFT;
+		if (PAGE_ALIGNED(&pa_list[j + 1])) {
+			pa_list[j] = __pa(&pa_list[j + 1]);
+			j++;
+		}
+
+		pa_list[j] = pfn << PAGE_SHIFT;
+		j++;
 	}
 }
 

