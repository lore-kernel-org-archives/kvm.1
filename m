Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FB358D00;
	Thu, 27 Aug 2026 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800723; cv=fail; b=Q42zMNLUb9RB7H7vhLEYjwrsW14DxGASMCtHOhWMDe8gDeMVUVHvlyv3x/v7nTaSD9QOdDRUaXWEk8twCwiYfXnC2g7wRNXQs7D2HxAtpxGhDoob065I6o93ztpFPp2RuF4/0osTkR+O/P72eSfjPDe7qymQw1yiDVPKgBmBi/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800723; c=relaxed/simple;
	bh=xvPvDN2s3Pm3HDG24CAhJNAIh7AKi/fAiYi2tOICKZg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2WkOSOxpm2s9dgW4hncmlR2SnKPmuakBL0eJNWzUNHTUdhaOZ+mbnghaIw2qe1RFFTby6BHEDqTToLH87Ggf05r1P8eXafpdCh7QK1ebu8Pm9oHFtz3q2kTgMi0ljJcE5OQDORJeZZvbBQaUMX/1kAd/dY3FQiJSLOL2drkY1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCHEvEbn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCHEvEbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787800721; x=1819336721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xvPvDN2s3Pm3HDG24CAhJNAIh7AKi/fAiYi2tOICKZg=;
  b=bCHEvEbntN9t6NCWfdaCSyG4xBodbxfjHlYgBxNi2tCgE1k8+irHjhiQ
   7ralYb6SukErYDHmOXagm0Dqp90Y0IAW9Yr8b6DDlKmfQfL5KU++J9QjF
   yw1Zpo11OUfwoLuqXPuuDCBmhC7rCamR5g6l/fEPojK7eygEgMLfD6cGX
   ENs2ZdS8MH7D83YIi3FjosyqpSmtQUvhC7nbMl5Ckzn3K5WtTJvgMiaY3
   Kt6xeWRewAAUddQncMBHG9BJrZtRD925vwQAdmXiZzadTsW9RuCmGS5wj
   JueLlHv+BNQgkt1XuMrV3DFtpzLU39GkquhBs8Bjm5Xl0uXi9m8cxHfCR
   w==;
X-CSE-ConnectionGUID: 6h1Vh4ScRLS+P2RckEhAwg==
X-CSE-MsgGUID: plrsPLHnSw+7OWAbV4/CHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87430453"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="87430453"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:18:40 -0700
X-CSE-ConnectionGUID: ot7Be57ARea51CQPM4OHJw==
X-CSE-MsgGUID: esEB0K9QRbCGZRObXDDycQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="268321875"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:18:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 20:18:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 20:18:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 20:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/tV2G84oY0rpYkMnwbVPSzDiDl6rUuy4n3EHwTgLWMIeAAOb99W9Gof+RdfkeVGIRtvSldMMsMyg2E65b1J1AB8jFoHPGC71IGDWFTeK2QCHoMJcvyaFKCLLex/rnudz278/NApYRYE3JvVJFsgv/IRQ6DK6u39/ZgKh3pjmZMpjOkNygkHrtvEPbSz85h0Q34IySY5/U0NQFIHhTPabHkWFyqKWeQo3iSSgVIZJWzdOM8yS0Jh/cdXwx/+xledCCQmbmTg2QDoWXybNpys/2e5MrKQsQJWC32EamJgHo88bHkw949/wkqioo8wXIiMzmYLLjh0u/hQja5VnLlOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBXbfzDExRWDdGJ3opkk0xvn9MaISLriKkKHfpS0RJI=;
 b=UbnsFitIZoabVsE3zRjKrLQn0QC67I3nbW+zD4DXmAyuyVy6PbS/3TvSvUDOkuZQGHRN9xFJTuLjjQIG/Hdb8L3hUhl6vh/qh2PSRnxBWVnL/aDlZwd7U2OOABygfGU9xgks3n04lWBYIXbLVOXSnsC4mGSLP4Ai3TuWWnXunuLntj3afT4+UwkdsfabPybvvHKUnWKSSQpXn9p3enm3dlZY2MFOmuIjQnX/M2hHyemaawfbqRICstMplJv5CrstphocIO3H8GW4Q0iP7RHg14143fh6OgY0Z4hGjTDyyfyZQ2zFWDJdsYJDroDsU7unrdUuui0Z4NQHMjlMXeVjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by SA3PR11MB8117.namprd11.prod.outlook.com (2603:10b6:806:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 03:18:25 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 03:18:25 +0000
Message-ID: <e22a20e2-381f-4fb9-a9eb-bd1aaa55fd27@intel.com>
Date: Thu, 27 Aug 2026 11:18:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] KVM: x86: Add LASS virtualization support
To: Sohil Mehta <sohil.mehta@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, "Chang S . Bae" <chang.seok.bae@intel.com>, Kai Huang
	<kai.huang@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao
	<chao.gao@intel.com>, Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Kishen Maloor
	<kishen.maloor@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
Content-Language: en-US
From: "Chen, Farrah" <farrah.chen@intel.com>
In-Reply-To: <20260806011536.4172258-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To PH0PR11MB7494.namprd11.prod.outlook.com
 (2603:10b6:510:283::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7494:EE_|SA3PR11MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: ab739617-06c3-4b2b-56ab-08df03e9db5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|11063799006|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jmet89Sr/NSRtRrwsVTwqoBw+I2hlgxCk1daE+iGKHTgYeS5VP3kVUDjRtO/O4X1ektTGTJWOJeYUVxG0nJL44qMBiTE6Cr0GBtsRAmfSM5x0MkgoAsukUn2NgTOecfeK8EGgO6T5MQVFgeoqW9NX1W/XzE4UxXumZvAv3U+Y2079bht47vQ+Ts4F6blWx7RqHdnkKEIaWDBZt0cNjoKPvA5HI0n1NeLZYPK4UnxgDy/bMC3ABj95HC2xWRyYBDLZ/2OqC8HBiUnZ45KoB5mGOnbWt1FhdeWJtqsfEjPS4tf3wGOys1H/DFZU8obGJjwekbKAgezXZJ35JaN/0jgwx6NK8wivfZJ3LTnFIRMyhP5vcxGwsVg78EQQRFHdl4tkUewK/KB8p/TUUZbGMPbF3+a7hiE4zmLow+RyvZM7So1Hz9BK+kPjWfTxNqya6JvVykqMDHRi0MaUGToiDH3/1BGJK2yo6soZdK6c3BNe6O3pyjlwybGvN8kVpaiiZUSccIuwedxrwO2ewA5ovAXIgEhD13rdxsfqtjbDWGPCh44lvOKBg88y3JWngSN7B6YTwc4Nc53ukoAS97mzEo4Dl9WWO2ES3dI8wA6KryRdrhTTrxvHykgU3KskMyoAQgjyoUZNtoFQ26TvSAXMff8BZK8Lie4zk3NqBkSbg1pucY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MThHNURNMTQ0a25pUStEQmtyeUNETUF5VVNzL1VvdG55UktyeUpyK29COWN4?=
 =?utf-8?B?WktKWGFNRE4wVWFXTXBrRDk0Z0FqLy9YaTdCcTJzYjk0N0llcDErUURiOCtU?=
 =?utf-8?B?Z3lHZnNQbjE5NTJMSHVocGNVeHBJMkkxVmZpbXhScmxycjdEb3VSTmF2a084?=
 =?utf-8?B?RlJzb04zNWR2SnFySHRFTU92b0dMMHRTR3JlcVIzTVJlRHZOU0s5R04wRnFT?=
 =?utf-8?B?UHFoZWg4cmpBVlpMNU9LaG5VbXJZT1BOdnZGTXF4SGNzQktNdm9vN1JoRjlE?=
 =?utf-8?B?M2NndThva2NTSVkzcEp4aGdUeE5obTU2dkZ1a2d0b1ZTa3FsMUhqaXU5OSs0?=
 =?utf-8?B?ZjZOSnZ3UzBvMVF2Y1hvdi9XWE1RVEhVVFIzNWJzbE9TVUVINW5OL3RITlBx?=
 =?utf-8?B?VjdEVXZxK0N4QVZZUmlyNGpJQXJkU041ejk2YmhFVGc3ZnJZMC8rUklnckwx?=
 =?utf-8?B?N1BDSWtvcmlhY0NzKzZhalhvaUFrczJVY0JtWjBabG0yS0dPN2ZldW5IZGZK?=
 =?utf-8?B?T2tlbzFZR2dtNUpGNlp4QmpubGJ4SnZiL3A3a1BiNUJwOWlnRmNhV21NZkMz?=
 =?utf-8?B?NjdQUURXcmpDMEVmZnFCQ3pyeFdRUkVFaytMY2c5T1g3eS95Q3QyUU9EOVpB?=
 =?utf-8?B?ZW10NlBtNnd3MXc2cUFpc0tLaXd3bTZEZDEzSHVMZzJnNEFsMUV5Wlc0Njdt?=
 =?utf-8?B?TFNoam5MeFAxM29CZXRrdHVGYU9OOTR5VkpOT3lHYzJvZUhKU0lDeWxSN3Br?=
 =?utf-8?B?WVNha0hGeDJzR2ZjaEs4YzBDUnREZjZFSVgxREJlS0VzVmRxOXpBVVN5RC80?=
 =?utf-8?B?WVFkWm1QS1docDY2MDZoQmVza3dmSXJkMGtiSkpGWFJKdXpKU09KMUlaWEQr?=
 =?utf-8?B?djljMmgxVFIxZFRJS29YTnZiV2FKeVhYeElqTEdTaFhJQ3R1Z3BPVjFGSmRY?=
 =?utf-8?B?V0dQSy9hVHFURkZsbXRnRHlBMWpSdlBzM1oyS05oNFVNVkl5WkZ0UEw2SWta?=
 =?utf-8?B?a2pjNzRUY0w1NEM5L3dCVkExcmJ5NVdkVmlzQzVlMEZpcHlZYVRDVEI2cjVG?=
 =?utf-8?B?OUFQVitSZCsvSmhJRWhYMEJJcTVvNHN5c0trS2ZsQ0lUekpEemJOekR4bFJN?=
 =?utf-8?B?dzdWQnN3RENPSndUcVNxbE9DR3JmeUwzWkpTUDdPcjB1L0lkc2U0VWJLV0ZT?=
 =?utf-8?B?a2VnYlpOU0xWa1Q3aHNsMkd2WVRZWUF1ZFBkbVRZQjYxLzlWcnRwTzg0TndT?=
 =?utf-8?B?bXp1ZUtUUXJBbGJBMUlCYldqd01zTTB1eDNSbkJreVlQelRsVGhHVlI4MTBX?=
 =?utf-8?B?MWNXajVkanVxWFkzcEJtaEM5QUNLTGYvOVJqMVpqbmlWNzJjTk5MWFlkcFho?=
 =?utf-8?B?b0ZlYmZZK2NCNUF4eldabTd6N2tOVnp6UXFtRWg4MXlJYjFWNzhMMFpPZmx1?=
 =?utf-8?B?c1djMU5FRGpZV1ArbDhaeWw3R0pVWXVqdHZWaFpqSEs5eC9OenR1SlBSaFdy?=
 =?utf-8?B?TTFSK2N0cklyR29CdE9SSWU1bEppVVlDVWYyUXV4Mk1nRXhnMGVVQzJlbmFC?=
 =?utf-8?B?QXBUNHlFOGVQU2JhNEQ5Y0NyUVlrRWswbkx1OFVRY0RqS2xaWlFIQWpsa2Ry?=
 =?utf-8?B?Y0puenA1bUh4LzdNcHhXQzlCK2MxWWw3bk5UL2I5YjJONkh1OVFjRFhpK2U0?=
 =?utf-8?B?TmRDUHNnUHNxcG9CRFNCVVVLNWlibkZZZ1d1MU1kWTlodEswQTB2emltd1JU?=
 =?utf-8?B?Y042d2dGQlFaWDJXbktWTUtjR1RWeXRiUW84citXNWhXcnl4eXRTOTNKWDdM?=
 =?utf-8?B?WWJlbStabFpNdTIya1F2S3Z5RUgxUmFMWTlIMDJrOTZGNlpOd3Q5WmRzaU1E?=
 =?utf-8?B?bjJIMVhMdWd2QkFDRHdNL1BadnV5T0NTNDJnOGhYdmtqK29XMDhhdnM1a09Y?=
 =?utf-8?B?YXlnNGNZTC9HM0x2TEtyMlNrWnErbHorSzRDeW9yRUdaRnV3WW14bmxGcDl6?=
 =?utf-8?B?QnEzUVhhcVV3K3M4QjczT003d2xQZ25aUEVFaEFMRmRxUW1WRWpVREpueXdq?=
 =?utf-8?B?Q3FqNXg3V0p2eHhNMkoycHhmbjdyUUE1Q281QzVaL2VpVEVoRE9CY0JoUlVR?=
 =?utf-8?B?d2VFcThXZExyci9RVnU4RnBRZVlIWFdVdXVjMExXUzNSeTVjMU1mVy9wZi8x?=
 =?utf-8?B?dDhId1dVaTZZNkw5YVBSR0ZGd0RmYXF2aG45VGxJbUNydllWM0M5c2h5dzBn?=
 =?utf-8?B?clczNG1VOUE1QU5tQjJqQUcrV2pwUmZET3FKYkdFbkM4SkFOU1VxZG8wcmVW?=
 =?utf-8?B?NU5DKzVQa1BBSlJZb3BxZm4wcUxNTmYyTmhlblVPaWxkVG5QV3FhUT09?=
X-Exchange-RoutingPolicyChecked: VpYL+81wNKuwqI4PGYE+O/q6NPW2ifgKlDUhtc11F0d87WsJYTpSi/vsiOnNPndn7mA23fuMrK/zT+T+beXRhPIHEA3wiwKtMUD0Andt8VpnMxZuK/jYTVjx/vComZqyWRGG7d5xMRaOmQkiMAi0HM+fSs5z4rRil7l9+O4AnmvO/oa4AJ+hlv95JftlbHS+FWE3NqOZ//tTFaeSZXjf5XO2y996+AFIB0XtKclC5IuTX+LcNZs94ixNdDnB9O1vPs3FIuR1KYrBM9WPJFModEn06VEfuWOtNb0BkJOt3Qcb9HNuFmTc3IJnZPFgM1pAYkd+Yn4QrBnUak3nQA+Efg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab739617-06c3-4b2b-56ab-08df03e9db5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:18:25.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n21/yMSGDGUFjt1oNjP5X3u2wH0ENtJfDVa9EhinS9EPWng5wb/rNe7VBzqZ9H+VXcbZMUQUdVeLbb+5aAppIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8117
X-OriginatorOrg: intel.com

On 8/6/2026 9:15 AM, Sohil Mehta wrote:
> Linear Address Space Separation (LASS) is a security feature that blocks
> accesses across the user/kernel boundary based on bit 63 of the linear
> address alone, before any page walk is performed. Host support for LASS
> has been merged [1][2]. This series adds the KVM virtualization support.
>  
I tested this series on Clearwater Forest (CWF), running a KVM guest 
with -cpu host. Exposing LASS to the guest also requires the QEMU 
support linked below. With both series applied, LASS is correctly 
enumerated in the guest, and the LASS functional tests pass with 
vsyscall=none/xonly/emulate.

QEMU changes to expose LASS to guests:
https://lore.kernel.org/all/20260826035734.114685-1-kishen.maloor@intel.com/

Tested-by: Farrah Chen <farrah.chen@intel.com>
