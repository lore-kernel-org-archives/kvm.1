Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793799155;
	b=UFSiz60laA7Thr4icbYS56dQvlVgmMEnlX9NfdjlZUtoWzY/1ST8x4F3S5m0ET+ldqr5
	 u911v0M/0Wx3HYyNOaF8bn7MOkHOe/+qe0Zvp+skgukYRVWX/rQ1axbdNBvdsTOaXRn4n
	 dR2V36yVcYTcUNfpXHbnq2tppDcXOUoo8iRbH14TucNsYaJDIsid8fv/2lFzUqWCbVBPU
	 1bmXa6m+RqixDMJKiHmY3uj8IyJmTir5dfPVqFBWfWlNJVKffqEQ0neeUb561Lb33s5nV
	 R7MtAfHcdIHK7ktJZJl9e4i06WC3PEqv00xRNLPehE7xrHkD5nuk5Hx3PKwqbVBsvBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799155;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=EKRS5HnW6jSHNu1KMTPRSu47Nql6k1iwHUmHHN/UExY=;
	b=QNXzN7PM8lOapDJGOs6ZzRgzc98am49iDasFwO7BRvLUAB8e1qqHTxSDWU5BpFA22Tty
	 lgjE8B5E7gqaPi7d5VKpSCuwVbnH9Yp2yyBHceSGKuup2n3FVcR5zRfh6vkjbLVzYX0JA
	 BvZSTavD2sfc/jWj9FjDzdgZUXIyYPk4pguvCP3Bn3ylFsceL5Sxvz/RdWRoZSmveBZVh
	 X42JyQub715V08aHPknePhsroVeptZlLpmMGTeG0LeL1v+cMOMsOijBG7O9mFv43yJ+13
	 lm8fDOsaE6DTcL4hpCvrusADgEDXJ/ev+mQlszumU6zlZs6GkRwZj9BtnBqs5BJeU8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="D/3X5nYs";
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EBE606D804;
	Wed,  4 Nov 2026 13:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22EBE606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D/3X5nYs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793799148; x=1825335148;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/ecpNVClnNfyCIer48O1zd57f5PKyJT+hrZRMkyBr7k=;
  b=D/3X5nYsbeBP+ovmbgelXcli479ECnLA05Ky4P541mDJvnnLIqTBb6hj
   VSXrmtKAXyuY2ptz6I3CKSB7g6F1S3CNG7vqcL11ThSt+HIIwdnSu2Izz
   UgEp5ZOSU6BR3wO6DDW7DN8MsTVtr/aZp5bt/ywllKB1uuVrib+3LI3BE
   NeVWQDmlU/ePTLd9ClWFXnJSfz1K63VKlrBIbAVZkS1PcoU6Q3XlI+L9/
   6xrhvRfUNueRpUIB1GlaGs2HphthvQ2p5da2qEr/PuGBxlu6oWLlrIOl7
   +6ulOnR8C+Or9AyeQb67qCpPl0igMvykR7YRNoyZu0FvZd2UPtdEbp/Yr
   A==;
X-CSE-ConnectionGUID: BdTXNmRETNuFsbBUI9ov4Q==
X-CSE-MsgGUID: xNAqzli8SMexo7X3vEk8VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2548415"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2548415"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 05:32:27 -0800
X-CSE-ConnectionGUID: zbGEq5iMSUatZ6Vg0seeDA==
X-CSE-MsgGUID: J13qpaYgQ+WBqbSvKQn+cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6877197"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 05:32:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:32:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 05:32:26 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:32:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz0nuohvP5C/FGVpghxWZChKG6902dXMVDriOb6PfeTN3Y+FgZ3GxDBQqjD1KieCYHNg0N++t5xBWsyAk31okGEcjms/Z+1b1r03Vj24CvO34Wkg7c/dS0J3uOYTHUH+zTkIzxNLtgs8/leJUOqURN5Y8j8vIWig6WfcAlTNOQmApcGNM/z63+N0ov54JzCl5oXjzFYJvKDnENc+t02Llo72ZzKm8W2OVIT488L+jscK44kohCCZR3wErIUeqgSeHiRdW9MTZpY5l1H4YlOFBqjvnH3Mu17SA5R9IK6C4uxGmdR8zo/LovsBzkleEFA0puuRetOSXdiPXamVoD8DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKRS5HnW6jSHNu1KMTPRSu47Nql6k1iwHUmHHN/UExY=;
 b=dGprp2yT8GLnQQSjRrV/ogjVHEK0ISwFEHTNy2bH9c6Mo53j+yBG/lNuoxzWssFZ4p58ye73ooDQ6UaeZ8AtEuLayKTzvlReYZWdturct1zuHHoIC6cgsJ1nSS21DCActFjV3E8ZuwJaHA+iRqtfHsOAiCmrC1RXXxbSo9R6qy/x0tQkDhLyuSRoCKLVXVIVy4l9uYsPuHXd2CvRYjoiavB8CktXw1kMQkq8IVhUNbabEJu1q8l3nckxzab5Fm0wmJaCcTBlmjU0ForVXqC5S9KUr4wqWO7970fvJPZT2rV0a+Xex4V+4KWC1mSefsFi21zCGl38uTbOaaUfrWzGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DSVPR11MB9693.namprd11.prod.outlook.com (2603:10b6:8:34c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 13:32:24 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 13:32:24 +0000
Date: Wed, 4 Nov 2026 21:32:09 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Sohil Mehta <sohil.mehta@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v10 22/28] KVM: nVMX: Restrict event data VMCS fields to
 FRED-supported hosts
Message-ID: <ausz2bKMJQ92ZsPR@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-23-sohil.mehta@intel.com>
 <f5a4c1d5-cb66-4efa-80c6-92b7d8f543d4@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5a4c1d5-cb66-4efa-80c6-92b7d8f543d4@linux.intel.com>
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DSVPR11MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c6f5d8-7851-4d09-6379-08df3a780f9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|4143699003|11063799006|56012099006|261009223027099003|261021121427099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k3ElRDJkEIFQ1iNmKt0W89Jmuo/HmVFijOXj9w7f6u7Ns6tlEFUv8RBUke4CQFPiBRAVggymsZd7av/WhL33aqfUWWWLVb4jOg+9XnLIXm5H9C3Nr2BGRBt8gnQoKVeTeOMBnq40mjXvgVCqIJ7lfjn45cQGLFRgq2pqxCiQLfpWnWf9k3Gd7kJnV5ClFR13cCTCRlUOToDCdFJ8t9PNzBdcQ1E5HMi2wOgFYbJZrIUMySqtRyfGz31tM7hikeI0yfdcBX6/JJIH5afcaXm2/vUiCwsOICdzr3VHEDiEKrSD+lvwsklPom0JPk3uJ+Dwiry0p+qUMe1LTWpaODUAKL/HLuGgvYup/5m1Fo9ClnOmp+vwRnTthvwZB/sWiShoV3/knMY9rx9IsuHNBGKGrBF9q1HyKFUjoeNlC8X+H1v54cKjHhq6mOAptSNhn4ySHAjHMMp86NHqzCBX2PWooLkWC9jwBvuuNDgiYQN72X7oORPWlRh8OFw9aguw+8VZVOEoEOKEwShgIRBoaxUuHdUcMACN5dax7ziStLXe1MqxXYfkGshWQreubRJoTXJS+KPwtdutJE+aImTbBDJWNRAvQlymxnffVC93C8lm6ab9+8cT5mZdXSDc1q4ml6r9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LotvWK/3zGtbVOv1iYJFx2lec9dBad5J04r0S6VL1sUAs+aL5VAAGqgT6p3?=
 =?us-ascii?Q?hCrSQv2prnxrcSauN8vwXadHGvJALcNuGDVfBH/PXyTdh0Nc9nL2oE9R80ID?=
 =?us-ascii?Q?OSXFsbZ0ip5CTJhtq3KGXeV7ElU3E0xP5DEpSVq0+NqlF8FIN1+nc0STIcSJ?=
 =?us-ascii?Q?6TDrCXAWwCX1yA46sNYOxQl9nV0kam9Hw2FtSXElvW13oNwAG0mDBx3LjLt6?=
 =?us-ascii?Q?QRecv8ZmEdfbX+BV3cgmRbVoLbCi++dC0yM7Urp9aucwkExXhMBA9Q4ToBlL?=
 =?us-ascii?Q?JOZ0CsGzpIuJPcQKx1tRLYzTCcBBjzvuvgSwf8d64lajjZfnrBBp+6RpnSiw?=
 =?us-ascii?Q?VMPWY0JNmsNXAoLr9u7SHlU6MNgDccDBeRviyExwoqD87U71fvAldP/I0gmP?=
 =?us-ascii?Q?wbj2hDyrT1V9+OiaxB/2MUe4inEC7UcGGB5Li3gqAgkzQntifFAdPGJDvBeV?=
 =?us-ascii?Q?IDqCoAmnaJIFfnjLXm+0mYIlx6WwGNLlf6HDeP0rxyqkKbITxk63HPMMaPNa?=
 =?us-ascii?Q?NI/JR+eH/LzU54G6xA2+xjm72ggQWgHE7pSzEg/UiVuC6YDb2/+PS+jA/sij?=
 =?us-ascii?Q?Ycl2rh//WlURFgvLrDY7HWQx47xoKM/sDRq8ca2pv9oTR6c08j0f0Icir8NC?=
 =?us-ascii?Q?pld4pPERBUIu7Q+GjHMRrMzyDUDNpC3EwXkcVCGhY33zw5W/whUhII00cgai?=
 =?us-ascii?Q?N12aOw8uIEpvlvRBM3Vg4VBoi+gnG32xyk4Wkxo0vf32DMICXsKV1UiTmR0k?=
 =?us-ascii?Q?Mvk0IXYecWB/IwSH2lrrjv64JIzOAHSvfCQYmJzOWHznzvt/q4pAJy67Uyf2?=
 =?us-ascii?Q?r30BgA+cIweNte5/uCCJSJay3ilMW11Qcwc/jq2jYozt9UOHU3V/sgZ3Pjfy?=
 =?us-ascii?Q?ZETyBmooSmaHcjDeJaMMjzb3qhBza1YjsBBS9NccJ+Ma7cI1ZXp0T+pkTLoU?=
 =?us-ascii?Q?vqxCD9k552lweabFtwrOf4kJfycoA5heCao9sgbvth6lXIyp5lp8ONYoGDPK?=
 =?us-ascii?Q?7bOj4AgFOooQL/IvkJh9Wz5ejvzyUvzbogBHFHcd/ExbLxCqgf3vm+rNYRVu?=
 =?us-ascii?Q?AoW+EB7kf5nlYZLPjKvnktqN2vYRxnD8pD+6QIUKkx/mnmjkdRF5xCmJiMy1?=
 =?us-ascii?Q?PxWShL1GwHBufgNWo5mHA1h7zE51czUZbmwaUK6wgm7EHyGcJdldaBShuIHV?=
 =?us-ascii?Q?6rF1WykuapQXRuANjZ4uS4yg4I7T49c6WbutSKQuACk8OcXQEnRP9wXIXheO?=
 =?us-ascii?Q?cQOwW53TL7Pve73kZXWwwf/T9f0TSXStMmfOybsmaJZWNdlj06b+pNCjcLHX?=
 =?us-ascii?Q?bIRva+uSZB3SANkHLUyHPMZj2gUF6gO9nUBAk2z3Eok4Bj6v+9wzzapY84Yw?=
 =?us-ascii?Q?UOH7+QwupQ9EJ+Lcc1Y7BAHOWbzn325ziQoxt+nwLTiZgkyFpQej2pouTga9?=
 =?us-ascii?Q?AVZkuFG+XUq7uaCfLa5VeP+QBhGKY2KKGHlQ72cRQZZsG7+6ac5agS/M0cyy?=
 =?us-ascii?Q?r1j/SniWTl6q9OL0T/NvjQwsymH7td+x4qdj2q7zPb6NRLW8HudQf5tNhsYv?=
 =?us-ascii?Q?l5zOdyL+hAJEWXLNLpzBK05u7sbBOgZ/4gI3ZkAqcuXR50i9tdIHgOolln7A?=
 =?us-ascii?Q?LTfS1j9DFfJoV2aNpZQxLGYmdOOgc8m4NfTypI0ZI12ULlmwcF0PJuFc5KmN?=
 =?us-ascii?Q?4OaFERp+I+0h4OanChOF9uc+TfMRMupa0pro5CXLzDdqvue3JTX0ehmiYfOC?=
 =?us-ascii?Q?h7aFYNxB8Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: nuk01dn84sa3uwlQnx+IYqvnF1iU1RcjRfo/8uUVEKYkWZC2i8FlGPOUJwdn4SHz45xHK2r0Es5yFp5tVof3+x/HCY+375Vetlmge+NJZY/w2viGpzFOsUJwqjpIhVmMlR5igDGUTJkmQTUVHB95chupWaJa2is0Avh4l4VYPTWH0OsnJuzWGvSx0SVik6SHoSlOrOI6wzNiPTAhHcJEJZL7Fpv1mt3cJIYBKdOxaBYK/CiSAlY8UlOnTScnPBVKnWBEB5fffCyth1Lih/40PmDEaQzNJH6z1NCDoouQMKs1J68l7+cOJFUz828MgcoB7QQoC2rfU6WAiaED9n7V2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c6f5d8-7851-4d09-6379-08df3a780f9d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:32:24.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2si9UJ0AJZXXaDhrRmNej8IAAbfC9oSYEKhGAt2GGUpVEph2xsT+p6dhJFv1OhCKf7wPXH59vMGmw6wWG3COQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9693
X-OriginatorOrg: intel.com

On Wed, Nov 04, 2026 at 02:57:45PM +0800, Binbin Wu wrote:
>On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>> From: Xin Li <xin@zytor.com>
>> 
>> Prevent L1 from accessing the ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA
>> VMCS fields via VMREAD or VMWRITE when FRED support is disabled or not
>> present in KVM.
>
>I think the change log should tell why the patch only restricts event data
>fields.

Sean preferred an "unconditional" rule for cpu_has_vmcs12_field() [1],
i.e., new fields are added there whether or not they are shadowed.
Following that rule, this patch should cover all FRED VMCS fields.

[1]: https://lore.kernel.org/all/aULATi4uMa-5z08k@google.com/

>
>> 
>> Signed-off-by: Xin Li <xin@zytor.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> ---
>> v10:
>>  - Split out of "KVM: nVMX: Guard SHADOW_FIELD_R[OW] macros with VMX
>>    feature checks" and renamed (Sean).
>> ---
>>  arch/x86/kvm/vmx/vmcs12.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
>> index 837cb3d568c3..67c730e31465 100644
>> --- a/arch/x86/kvm/vmx/vmcs12.c
>> +++ b/arch/x86/kvm/vmx/vmcs12.c
>> @@ -222,6 +222,9 @@ static __init bool cpu_has_vmcs12_field(unsigned int idx)
>>  	case HOST_SSP:
>>  	case HOST_INTR_SSP_TABLE:
>>  		return cpu_has_load_cet_ctrl();
>> +	VMCS12_CASE64(ORIGINAL_EVENT_DATA):
>> +	VMCS12_CASE64(INJECTED_EVENT_DATA):
>> +		return cpu_has_vmx_fred();
>>  
>>  	/* KVM always emulates PML and the VMX preemption timer in software. */
>>  	case GUEST_PML_INDEX:
>
