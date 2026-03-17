Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9833F54C6;
	Tue, 17 Mar 2026 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767080; cv=fail; b=sRzmyqltRBp1RC87i98pIHxNP06ZmXtCsCJ7VbG4ekb8+Nj7SW0aGvZqwCulDf1m7z2NEiYnLBDcmFfsjz2pNLeXrEzhdDt9huRluNr+Qf85yPm+zPNRMk9nLsvBWHu9Oi9sS+/rRLKiuseAVHGftlCFphyM5+NuzBcdkTmbjZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767080; c=relaxed/simple;
	bh=Uc+aCEeoEgct2eNDjEWdXz7LBWQmu5L7tO0KfJ6zK/M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWlHtnwTmgv69U+hbIOmCPW8amjFp6rtzF1vzoyyWXGsTgL9LwboggYdkOy2pBsIN7R6aBVTLQOSDu6tCgLIJvGUMeHYwSREB1cUUVOinSmoLU16ue/bDQje34yyL0jCr+ql6XBf+L7dG/RY8y8HH1qdGnQk50EGw+anpzYOfwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1XgukhK; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1XgukhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773767080; x=1805303080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uc+aCEeoEgct2eNDjEWdXz7LBWQmu5L7tO0KfJ6zK/M=;
  b=T1XgukhKurne9c5zFJxGDyyUN9udGuW6ttZVilC9Pz3HuDP++StmKZeY
   AbgnQCHgxETQt8WEtUvwfgPIGRmvPD7Y+C2M4r9cFjIQ69pkwGLRpxP+n
   Ym8dzFy8Kr4pA/4SVokkREg02iPyBAOatg+jEmzIp81tz4Hk+6VB886ub
   NAgzW5raTboeq/cMr6wcKOikPBcvPOQCw74nbQMigKJ8pGAbu/CvnVI5w
   ChESdtSWhmanIdLNKN6yUlaDDigkfz37FhT6fH3347LEo+R8AHyPO75is
   CRhyHg3BkqP2oFT1a8MltTRjn0KZTYe5mFam+doGooEgWLGVQNOS6qJC4
   Q==;
X-CSE-ConnectionGUID: iigaKWr7QnCmsJURKiOtlw==
X-CSE-MsgGUID: KO8/BgnzRDCzZZfBRFCN/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85884884"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85884884"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:04:35 -0700
X-CSE-ConnectionGUID: SQQv+V7CRMmViLs1intqlQ==
X-CSE-MsgGUID: glfCfPhBSC6c1xpUbaKAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222383595"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:04:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:04:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 10:04:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2o2BnDtsZt56RGJgT+KzEhwMSb2f0wv2TtSs4OaOYV9HHspK7eZpql5SOD908hOLLNAdfuf9hdr/Iwu6OpuDdiOg9SpP+5qzmd9wV7JnW8Echw5bF9lJKO4U/FjtQ3ucUm55RypJBzChagXk3r5FuXniBEnTXH3RWx3+nllCGLc+MoLEtkEsIa5YNQNeZgpu/EYLd2wKYdnNB4hpFqSn6ZVvrwo5AMMcVZNJtQJbjA05wbdzN6ZTIYas8bk7jfqIF8F1bpd7qXyL0sTzJ4htX1xLzdtgm/GSc9w1B+u4b3WtN6yP6LUgeyecbM4TAZqS7fPobcj1JLQxREEQEYNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWrKgV8EJppnaeMbhP7ODRuWPYfVFtOuKs4Z0zuOmYo=;
 b=Mc2gTruxKxowA4cfxB131ESwmAx4JrVl29gR0cUCkUgPfNDkDYIdKCB3gCMGZaDNgdTwU7onntQBbZC7LF4xyn2ZfnPoVZr8Ox8iSrMfX2Rgi9RJooisCljjrmn2Oyt1Hya2D3mCIoMGH+PXYqDFqOUhP8lbe2sL6OnIke/MOaOJYdwFQvWjBBJHqBbyS7Wb/lhH8fFDRIQv3Bx1pqd+zESDUUprqHIXwvpiEZet+wpWixBuMyq3JCxYGFoFMwfE4DA5W8G3Jq6zzkQIEfZdRkLpioWVExF8w6JY9S5yM4PRrzIdZ63Iqlkt3Sm/upzPKqgAhyCIxYbEoSafeTw7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 17:04:29 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:04:27 +0000
Message-ID: <a91b5d2c-c152-4a11-b4e5-93e64d0e8958@intel.com>
Date: Tue, 17 Mar 2026 10:04:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Dave Hansen <dave.hansen@intel.com>, "Nikunj A. Dadhania"
	<nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov
	<bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
 <c13736a1-3151-476b-a91c-035383d2a29e@intel.com>
 <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c208b7-9eca-4580-dea5-08de84473f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YOCGSg6XI7hruKxn7PH2GBRpTYcUZ3/Juh4ZrM05yfiqBVWuFko6aXWXTDbHDr6FWNYgraSLhvqBbQcg6Zbl4o7PKA8RlTuAYM3itkNZUbqEMl3c/IFkL76k6z00TLIDQ4cgcBQVOiOjRGlwVXrHvfX1CDlE6QTHJIvu1GXuHZCsbW7cGBoI9KmeNAzuYvPjNuBVFK6CY6EU5UjvwmuExzZEnMryEXOuqqf4LkkZ2Ax2H0JmD5QLVPwHHSBVdNFvtwfPLK/Eq7GsTp9RFHckxioEhuDHBAIM9a0fgAjfTMwINSnymafJriPFtCgAglZCzax4JlLcmuZX9sZlshSg4D7f90QVUatV8NYcjJ+3wKndOEpLKZCX0hppRl/VWfqJ456vOkZ0gZtjA+rXn+sc+ALwmfYThbKVoefgwzn070R8os6hvXSBbgb91BDYaGIeVUDlU6jw3mO5bswnpFA782uPbsR7Q+JS/uOq7ULxppFBeCGkYf0tAvus/izlgqTX7xk7idmb3mvLTtJ8K3x12Q2uTI/VJixq03PQ0JsPj6SnO2JbsUeuz3vE+UHEfbIIgHy7dwjWFdavnGhy4afWeVaZEolD1xFLXZerG+syuQfm7MIodI8DDbLf4j50YWaOr5Laf+uXPGy7uAjr6XkXMMW7w+hVw+hsDgSAIU+Ky7SwLIp6lhcODeAIdZxROjLzfxt9CbTdW+oaHVNuEwCVDL8+k8SHDHUrQCPWmd1h6e0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJoTEQxZnJ0MG9QSTBpd1lJRS9MYXpkcDEzS2lROWsyZyt1OHdLNGI3Smgw?=
 =?utf-8?B?Z1c0anZZSy8ycUp6d3B6ZnZja1lPbDVFbENRQ0g2dTYwdXZaVmhNZlQwM2Zu?=
 =?utf-8?B?NXhUak9Oc1NNSENObmZXNnozMnRVaUMzWEEveWtlMzFhVWdiQ3BHcFM2YU00?=
 =?utf-8?B?YlNiUk1yQldnbXVDZDRyaFgwTG9VRkhqemZBWW5YcnF4Y0hudFFzS1VnN2lu?=
 =?utf-8?B?bFFPcCtsUHhINHdXRk55TGNVUzFwN0dQNVNveDZ4RW5sTkIvT0dCUmlDbGVY?=
 =?utf-8?B?RVpmSFQ2RHpTM2JScnV5T0VsalhVZTNCN1QrMEs0UGpJQVl4eXdjbUVZZmRx?=
 =?utf-8?B?YzljM2s0OEZ1dFdvemJBdCtLQ24yRjZCWm90TS9JQ21nOXc0Q3I2L3NKK3l6?=
 =?utf-8?B?Z0gwR05SbGRQb2VhQ09oMk14QktJd3ZSSzZobmwyT01qWmtyclIzNmpWM0Mx?=
 =?utf-8?B?TCtmYWdWQ3R2MFA1MkxUbVVnajVFZ2lWNnVhbFE4dFp6dk52eXhFMmozU2NY?=
 =?utf-8?B?RVpNNUlJKzExZ05uakRtNUFFRktIcUpWR1NlUnZXL042bHgzRytzc3d5TW5n?=
 =?utf-8?B?N3Y2MzlQemtHbjZ3ZVFSTWxtMnlDNHRvcTNLOEI3Z3RQNlE1NVJFbm9VaGNU?=
 =?utf-8?B?Rkpld05RVGZINzlJWk10eEhDVWxXK3BDQXNib2NQNy9hcFcra1lHellsaXRD?=
 =?utf-8?B?L0J1RGR5TVBMeVZyMFJGYWxuV21WSWJpQ1EybHFsSGs0V0pTNWJvR2FwSmwz?=
 =?utf-8?B?VnhXdjRidDBraVlQRWVQcVY5TUZwcG5OcHJqbFpPV0tBME5Vb3hHM2VqL2Fr?=
 =?utf-8?B?aXJPU29yQlJiS1VsdDAvcWpFamdYVTdQZHl5MHZCRk5uV2xETXhPTkdXRE5z?=
 =?utf-8?B?VFFCNzJkZ2tGcUxBZTlxemJPdkNYeVEzVCtIT1p5bHdtS2liUytKN1BHYnJu?=
 =?utf-8?B?OHVWVk96TEhzUk9NamFDOGovY3kwcHBhR1BiQ2xzYXVjTUtBVmxKcUtlUCt3?=
 =?utf-8?B?ZWhIL29Yc1k5MEJBYVdBM0trckhUdmNUeTY3aytEOStZOGZleDBmbkl2SjdB?=
 =?utf-8?B?MmhENXMxSjI4UnhJMzJLbEVjQys5Zk04b0ljS1paRUdJR0NSMnk0eUtVN0p4?=
 =?utf-8?B?RmtneEdtQ3JUTXFlRmNYUlNOM1VmdXpQa2JzRmloTm4wa2pKV0ZqcjkvZWt5?=
 =?utf-8?B?TEQxeldrVU5PZEhzTERwZ2VCOEVEVzRpcW15bG1GQ3VsRHAvekZNNStPSk5K?=
 =?utf-8?B?eEU3dGNZLzUvQ0pHRU9FNFNIUURQY25OdUlHMjNCTjdScWFDUkowKzdBQlUw?=
 =?utf-8?B?NC9WbkVPSW5BZC81TlkxZytQK2FNdmR0Y1NnV0ZpZkRYQW9Wc01RZTdZR0cw?=
 =?utf-8?B?MiswQ2xYUEtDQUVUSi9XYjRPVVFHR1lnWUhCSTJpTzNJWE80Q25KTGtwV1pN?=
 =?utf-8?B?eTRHMHM1ZFloMUw5L2tvUEIvczVsTDRYYlRIQWNZU2pnUFpreThpWnhMVFl6?=
 =?utf-8?B?R0szVk5lYWI5SUJrYmRRN0hZTGJDcWd6dFI0S3F3bjd0VmJ2M0pBd0NYTHRL?=
 =?utf-8?B?aGtOZkt2eDYwcUcvMWZ0TStvaUtxTFFQSG93RkVoNGZtL1BkUUxzTmZSNXBV?=
 =?utf-8?B?OXRIUDhXeUcrN0QzQjRhOWxteEswNTF5dENjSm1qYzljTzZzUitFWWdTajRq?=
 =?utf-8?B?eFlWRE8zakx4Z1NLOC94WlBHT3NMdmozUFd6eXFHbHB1RnpNZk0rcHJDazYz?=
 =?utf-8?B?M1ZEaUhuVW5hcDJhbzJWbVJMcndJMlU5Y240blRkVVBWdmRuTi85VU1rdzZD?=
 =?utf-8?B?dVdNUllBOVhJNFJDYXV1VXplamJjOFBMd1JFZG1lR1IxdTlFMDJmcFU0N2dW?=
 =?utf-8?B?SUhtWGpXR1ROT0g5RzF0eUJwTzE4aFdOTmNLSjQweDI1eEdxbEo2eDFUWkE5?=
 =?utf-8?B?bk9zQVNSVzdGSEo3R2tKSVZrS3pDdDVRRXoyUnk4NnB2dC95Vlp2YVVMQzUw?=
 =?utf-8?B?LzlGYXd3aCtEbFNzODFSWWl2UmtqeGY4RHZUZlNueXkrdWNmYkdkTmw4WUtH?=
 =?utf-8?B?aVZmVnRLZ1NhYS9leVdoellLR3R0eHc2UVo4akE5cEc3bFFMNXNuOWwvSlpm?=
 =?utf-8?B?czBtZXpraTdIUUxwNFdQa3lTdDl6aWRLV200L3p4TUZvU1ZlclhVajhUNmQr?=
 =?utf-8?B?MTRBb1FyOVBaKzErQlVGVkpJWERLOTdLOS9oTDV5bmhOaUZZVzFQQk90OHV5?=
 =?utf-8?B?VmJMaW9vbFpCa2hId3B3K2NFTk5sRG05S1dPb3BhLzcvb0h1cC9paFNmcHJm?=
 =?utf-8?B?THc2QllzVUNwRUsreUNBblVKRG9leWcvdmJJNS9vUG1ONDdhT3VpUT09?=
X-Exchange-RoutingPolicyChecked: dH/XN7YXiODH+YuOBxmKGOzx8e4e74wXw91lBXJeSLKDHZCSrp6Bem6mDb3U4ztj3AXIINtVPP0i9njmb2yEe+g760D6auwHMUL6aofc+KC8X4JKFzqrnY0BRmhgLrqRfhi6++XkJ0OPlCNyIH/s7NRxO4icQjDFKIPvzMZY5nBoGolAEDyxva9ErujqqRJJW9n/S1B3Ojla+1149vn+G/IHKBE9B3KuYjjFv+SX5nop6J2oGS/Qrd+CbLq7y+eymo35VWPxgLNcIKuab5MOk5Zd//AUf8nVoBd1xKQsBjGrHGLQwsfqJoQt6lWUskZKMAMs/0syxY26A4qGhpUfmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c208b7-9eca-4580-dea5-08de84473f02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:04:27.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEuwyCwPGHethobj0+w++EC2muWEyxaAzoaILfgPGc5CqhLjlpcytITyW3IKyxlTrc5A5bEyOUifUtKNcTrMNpi4+iSfrmO0LtJQb78W59I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com

On 3/16/2026 2:43 PM, Dave Hansen wrote:
> 
> Either we change how alternatives patching works, we use some other
> exception code, or we try and get CR4.FSGSBASE established as early as
> possible on the secondaries.

It looks like the last option was sorted out already.

As played out other options a little bit, deferring patching looked a 
bit funky, and either macrofying the entry code or referencing XCR0 on 
the fly appeared a bit overkill. So, yes, nothing stands out than that 
choice.
