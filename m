Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01093009D4;
	Tue,  5 May 2026 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012431; cv=fail; b=MwE0nz5Qasps4vr+rMU6DTLw33mEk9wajFb2ZuPE3/3G00KO7InszegwOnfXsn00VeAVlY3QssBAjgszdhLECbWA/Uia1rWM/slKsJ4WH7avEnwrthkOh3qDEqnNsGjJJdefbt4fTolDQaSkISX4A06nfbciZI0np3nKo2aS8JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012431; c=relaxed/simple;
	bh=5h3re5tRAxHdmDuSREP1DsRkGTjKcXx5sdZfFTL1dbo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D8HD4WebXTqq1NoFOHJxr3L3PA/a5FOPg8QiFoytB6+rH+sWInFFOkjruOQi+7krwICTLsEwAZ3mU/RaFPIXl9B6LCIRWNi3/i7+QzrUdif57cQMOJ/N4DwBVsm84ZTgX33AW0Rjcd2lH5OIfkpS9d4Jx6+sxupzsad78jGt8rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/4fdQSl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/4fdQSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778012428; x=1809548428;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5h3re5tRAxHdmDuSREP1DsRkGTjKcXx5sdZfFTL1dbo=;
  b=m/4fdQSlSSws0aaPfQ6nhQYNrCkS2cqGtxWyw/8em8oKnQ2Is9d1cEih
   cun1gU1hAefeShTQwK71n/jyjT7g0giTtgzLfzI5kHNNcGtqnlxipNI9Q
   CFVa2dTxihBcLNwUUdLVFSrBlVE75RQGXvoGh6qmyqQ+tMl2RAjwfd2Zu
   tWLZzy0M+mZDiAKlcbdaQg5UmJ1sJSbi1r+8SmhWN75lXEd9joTuaeCD9
   lpmPF+RvysYJPOAKZVVvjjoQO4hGMlk0MQm88kNBGvSx/zCXzU+Jz/i4l
   s4gS33fk6GPBdPLMBMHUpRRypEnlfzerXIN1VKLR/NzNdGoRjpCa1pIDu
   A==;
X-CSE-ConnectionGUID: 7IoadwprROOG1/6cE1u9/A==
X-CSE-MsgGUID: FbBYRIE0TzylRADCYv2vLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78756879"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78756879"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 13:20:27 -0700
X-CSE-ConnectionGUID: cp2fDN31QrKSt1Ve8PY02A==
X-CSE-MsgGUID: 50LuChvCTaatZ/xUGNbwGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="240905386"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 13:20:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 13:20:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 13:20:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 13:20:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSvavY5l67+NsIARsczFgYR0Um6UDG76ae2JKsC+dGCsY7vx1jZoOdEuEX3HW5zxjNELtjOW0LsgfZkvqBKm7oDQJUziikzoQ1YZforeChjk4831x9U32krgGUwXStzovH1YTn7xc98cZOuKQWYLqglVbwyfwDkRR9VnIjXcp3cZUmjvV6XfhIzAqTdeI5IT/vMoFemAFIV8y0ODbW/XjEknw3ZGaX1tu+9XaZJgHPpoizrWrqm4s812wYXJGg2x5kW6WZK+K5Zpdo0tJwWIfZNf4zb5kDvaWyIeFu1Fr34M2D0ErWZUKoEhnO9bGeEfceQc9nBoTNU2hnvWd/zjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqP/etolVFz6BCfY8P5u1QVVECWxi+PEzjbTQ9QL3gY=;
 b=Da0zv/r7Pbszq0PZRXREaoF4b754I2Mv61j/pVx3iarsalfHw+Iau99aVylIEcwsSvu4DeocqnzcuH5Vh20UMf9IloeaEByXzz0RMt5MU+7V4ZcDexeq+6BWwzqh1TdFROnNBQf49RDU1jJIm7UBxw+0nRxKxuGvj+bdWniMua0PdcKHDPaykavHqdW55BUamSlG6yVy0Vdc+Cib1v8waWuP5FB2Nk9rYhYRWZkwkyp5owHIBtxd4t/2alXoDG8FXBz/SwKD7LsA0cCXwdf8hCxH86RAktxNPbI7ePuBsqDtXNimUf8WcdwsB4k+edVbm8Ct/okf7/cf8SLAeVMBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 20:20:24 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:20:24 +0000
Date: Tue, 5 May 2026 22:20:15 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Xin Li <xin@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <chao.gao@intel.com>,
	<hch@infradead.org>, <sohil.mehta@intel.com>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Message-ID: <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
X-ClientProxiedBy: DUZPR01CA0294.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::13) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|CH3PR11MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a199d9-7acf-467c-dd41-08deaae3bced
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZqZzBOqXyJyp97WGDLDiqIww8HTrt3LGDjdjzobz5UaUUs5FlHhTWU0GQCX7ktwCmjNplavisw1X5E2vkZdPHj1hC5Sw4YbVDtF4yy8sCw+s+zc65xCINzOvXU2AaUaOBch8c7pbDi1RVCmiUQPAm7tcfAn66cR+3Y/FX3XrmNo92aROmdsqjigtXhRa4bAOJ7uN2ZONSttEdeSyl5RzJP5Cul86dqVsyIYvjCB6PWLXSrQFeLlqlR1kWqw8pk3p/yJqxjXyBSeEXADOEFA/GmdS0ru/Uk6Aw8eRSQqAQ13JNIUdnjix41OoyFmpTrprfVuLoI6WlB67a+FUKbb41KUjnVVcyquBPRvxDJKZyXB7V6HFMYuCJn+6G2SgGOqMgOzakspO3U6SiN4694GsxHEceRd334jkt58pXWANHmRoQR5BtjP07E4BFPlOWbPk011DD6PjZAu1ue6SRa7PoChmU337fEyqqqgwF7Qn3QVcbfKlsEu1pGC+f27Br7Yg/gw3rXYFjwudslvirmP1dNUp2M7P266/taoNGybunfJm9nEicUBYo9zphmtgZNlzw5OEDASpPbTW3K+PmiymUnXaw4xRZreO0V0rRKV5l9U2ZOdTbd2ufQY/80Obxkyd0uB0MVhBWRfQpMcJvavFsrEMJ1HhqrOMcVzXzTlkszbBD8ni/iGcsFolzoirlWc9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlVBVmp5RDJIZXhGUjVsNTRlK3BPcWJ2dGZBQ3RTcG5PQTJLQ28xRkxJTC9N?=
 =?utf-8?B?UnRsZnJGd2ZqZnl6MlVBWGxtQ0lKWVdBQ0gxc1pFWEpWRTVQbEtiOHVDZ1Zl?=
 =?utf-8?B?USs2U1JMS0hmaFpVeS8yelFwVWkrNlp2N1AvNkU1bE1XWXM2S0ErNEVMb2E2?=
 =?utf-8?B?NWpTNndCeGVjdWE1NmlvY3Zub1R6YlVXWm1EWXFaV0lDQU9GTGtIUStUZDMx?=
 =?utf-8?B?R0ZYelZGNmliVVRiVTYrYXdUdkVYTVcyYWIzMGEyY1IxVmNMSm9Ma1U4R1lO?=
 =?utf-8?B?TnRDZVI5d1hiMURBNzdBR083bVNTNSsycDlEbDcrSDZDOVZPeVpRSEVKQ3ZJ?=
 =?utf-8?B?OUQ5MDAzamhkMzd0Qy82V1RDZjROZ1d0aUxxbGVqUklWK3dnZmd3V2w2cWZW?=
 =?utf-8?B?UUpOOWdRSDhhTUcvcCtadXFPajZMNXNmdlpQemhrQkp0b0x6RU9WVUtoaSts?=
 =?utf-8?B?cEU1c3FrOFZNaTk2OUVoVnQ4aVhNS01NdEsvUnZuT1RseFhvVERML09vVGM0?=
 =?utf-8?B?U0lCTE4xRWI0Vm5vU3dPZDRkbVhSNnRnemhEeElDU1RQQ00wNlRkdVRnRkJO?=
 =?utf-8?B?YXhiaWRFQVIvbDd2K1ltTk84bHhxMFpwL0hsU0VFa0M1TEJCaTZiT3NYOC9E?=
 =?utf-8?B?YURnb2RVQWY1YWxSMkdMQ2EvMjFjczVwSWpHcUVpRm05VlJVRjFuaVNBbjB4?=
 =?utf-8?B?dGd3RUFPTHl3dzBXTzdMWnBndkJpKzdXT0gxVVJnb3V6cTV2MXdJV2t4bEJ0?=
 =?utf-8?B?ek51VStkTWJBVW1aOHZWdFgxUXZENDNaemNrTm5jWXFkWU1obGZvM2FhbVBU?=
 =?utf-8?B?S1lINXBnTUNZcEhqNml5WWNlRjVoYTRMS3JUK1hicTErNUgxVFZHeUdndmZ3?=
 =?utf-8?B?MGFkN2g3S0NOMjcxUEllZnpIUkp3UlY0WVJhZ3JSWnRHSWsySUVBV1l0TzBi?=
 =?utf-8?B?eWZXUmE4MTRuN1hyeFNxTy9sa0lOMUJzdklXUzlNek9kSWpGU2lVZnFwYjVs?=
 =?utf-8?B?ZnhZYTRsV2ZVUzBBZWg0NmNwaUZEV2NpdC9TeU9aYklyQXlLR0xqQ0RLVjVH?=
 =?utf-8?B?bDV3ZGVjMWRQNzBndlFERS9kNEdvbnMyL044ZGpCZkUvU2Z2UWFLengvVFNC?=
 =?utf-8?B?SkVNdWI0d2lQK0MxN09rSzV2Q3lyOFZhZytEZk5ZbCsra29YRis2QTdtTkV2?=
 =?utf-8?B?ZFJ0LzZiR0ZrbURxWHJxaEJYdkZSTXArSExuN3RLb05jRkthZnd6bkJVZVJp?=
 =?utf-8?B?YUVRLzZWdUZxS3QzbzhUeElTTjRMYUJEUTlNaUgyTnpwT3dGZzd0cHFiYXgr?=
 =?utf-8?B?VFUvSUE2T0xPK0xqb0c0YjhaL3IvRFl3Lzh6bXI4VlZOMkM3RFA1ZkdNSkQ1?=
 =?utf-8?B?SnFXZjQ4Uk43dUFSKzFvejZ4MTF2S0VCeTF2WnhyaFdEbjJqTkE5WFNSeW16?=
 =?utf-8?B?c1RYY094N3kwUUdiQlVURHluV1IyZUVWRDdMd1BXcjU4aEhBdm9CMVRSekNr?=
 =?utf-8?B?eGNsZllnVmhIVU1KTUF5MFNGS2liV3NNRm1lb2gwVm92bUVMU1NGVkFmaEVU?=
 =?utf-8?B?SXp2QnZOTWR6MU5xMDcvRE1CZFQ1dnBTMEx5SDRWTWlPeGpNWXgxOHpaR001?=
 =?utf-8?B?Q2N4Z1pZVE1KejFCTEV1djRGMlFTQmUwdnhKMk14OGhZQzFwUHVjZ2gxNXd5?=
 =?utf-8?B?ZXVTbEdjTVN0VXNWZExXdkNvcU1SZU05NjRBSWIyWm9pazBxYmpsOHFpd09o?=
 =?utf-8?B?bXE5YjNVS1RqQVROSVJiWU1IMG5jYkhpamV0WWl0eGxEU0FDT2ZaVS8zSzYr?=
 =?utf-8?B?UWsvbkdIUkJVNFdWYnZMSXczS05BZ3c2M0xyUnhZbEdSQS9PSW1MMnhwWHFT?=
 =?utf-8?B?dDdMOVEyd3REaEhzZ1ZsY1A5OEszQnAwcDM5R29WK0lVdmR5dU5ETUZiWXpM?=
 =?utf-8?B?bXU1bEhIbmxaUnU0cSs4anVNeklkZlFHaE1wS0tNUzZHdDMwaFBhSmtPazVU?=
 =?utf-8?B?Y284MVlnR3lUMER2d2VmQkIvcEcrbUhIZzlvOTI4SmNyNDlOcU90SjAxTkVy?=
 =?utf-8?B?b2x4Rjk4SGhYajFKd2JHZDBWTGdvVStUNmJqVlFMUTVneVN0b0lya244M3Zy?=
 =?utf-8?B?aWZ5TlF6RlhXU2xsakRlc1FTMHZEQUkyaUh5dlpIdWFuQ0JYc3RqNldIVjZ5?=
 =?utf-8?B?bktTd2ViNWtmQXpvMjNtSjY5aVhxY2J5dS9Vb1dIU2Qwdlp0QytIdWo1T3A4?=
 =?utf-8?B?blFzSG1USTl0L2lPREt1TGNNR25YRjlyR3VwUmk3c0VlWEJHd3M4Z3ZNMkt3?=
 =?utf-8?B?K3F6Y2JrUkxGWUFpZjd6VHJVc3UvdjlsR3o1N29xSnRmb3I0MkM4cng4Qk84?=
 =?utf-8?Q?thd3OuJlbyM/1WXBVHQdvqdw6mzXV0DNG6OVu?=
X-Exchange-RoutingPolicyChecked: vgRGTO1DrnUze30+zXhyj82uPDzVnM1Rl/vsoNjkyA8useew9EqghZCVq2XxOWxDV7JXGq6gNVevwXvnsxVnfqHZPJeuWUqq5w0GtUuyx8+MdPV4E4VJqovxY7gWvs1pzFQc7lHveqhhrm4tiooSi3U7vZaenSPWrqyjvsDopr3+uZJvRkI7t/oZnJmVUlgoQUwLCZBu5+VaDKOWeLzqZ0+zonBcgLjiy2h49Ti9qhAGy2+JOj3gCRFlxkG4LgTSzTMtAoHQHC2swHUz5tm4ZqkwhTlK5Wo7xRXCThEt62LrTQlTaJqpuXr58Avlo6OSLG/kniTDJ/eevtsWdGfBWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a199d9-7acf-467c-dd41-08deaae3bced
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:20:24.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dlR5FVAxIxZqvrcmsC3WAuamFSkOu27Rd8GQrjbm2c17X38PNtKQlw3xZxoP9NPkmGjYMTjT6za9CYFpQs95rgxRKPgGTZ0k18sZ8cTtDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com

On 2026-05-05 at 19:30:21 +0100, Andrew Cooper wrote:
>On 05/05/2026 7:04 pm, Maciej Wieczor-Retman wrote:
>> Hello!
>>
>>
>> On 2026-04-23 at 15:56:54 -0700, Xin Li wrote:
>>>> On Apr 23, 2026, at 7:35 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>>>> Here's one to get you started (untested as I haven't found suitable
>>>> hardware to test it on).
>>> Same here for me now :(
>> I ran David's selftest on a PTL laptop and ran into a couple of issues.
>>
>> ...
>>>> +
>>>> + /* Test 1: ICEBP (INT1) — should be EVENT_TYPE_PRIV_SWEXC (5) */
>>>> + fred_handler_called = false;
>>>> + asm volatile("lea 1f(%%rip), %0\n\t"
>>>> +     ".byte 0xf1\n\t"
>>>> +     "1:" : "=r"(expected_rip) :: "memory");
>>>> + check_fred_event(expected_rip, DB_VECTOR, EVENT_TYPE_PRIV_SWEXC,
>>>> + "ICEBP");
>>>> + GUEST_SYNC(0);
>> The above event type test seems to fail and return 0x3 instead of 0x5:
>>
>> Random seed: 0x6b8b4567
>> Testing FRED event types with EPT fault on stack
>> ==== Test Assertion Failure ====
>>   x86/int1_fred_test.c:120: event_type == expected_type
>>   pid=16646 tid=16646 errno=4 - Interrupted system call
>>      1  0x0000000000413349: assert_on_unhandled_exception at processor.c:659
>>      2  0x0000000000407d36: _vcpu_run at kvm_util.c:1703
>>      3   (inlined by) vcpu_run at kvm_util.c:1714
>>      4  0x0000000000403104: main at int1_fred_test.c:207
>>      5  0x00007ff8d4c2a1c9: ?? ??:0
>>      6  0x00007ff8d4c2a28a: ?? ??:0
>>      7  0x0000000000403314: _start at ??:?
>>   0x3 != 0x5 (event_type != expected_type)
>>
>> after a little digging I think the issue could be this in arch/x86/kvm/x86.h:
>>
>> 	static inline bool kvm_exception_is_soft(unsigned int nr)
>> 	{
>> 		return (nr == BP_VECTOR) || (nr == OF_VECTOR);
>> 	}
>>
>> Since ICEBP(INT1) results in a DB_VECTOR it's not take into account and the
>> check fails. Then in vmx_inject_exception() INTR_TYPE_HARD_EXCEPTION is picked
>> which is 0x3 when decoded.
>
>That's a real bug then.
>
>> I think you'd need to add another check in vmx_inject_exception() to handle that
>> DB_VECTOR too. Simply changing the event type if the vector is of DB_VECTOR type
>> fixes that problem but then the selftest fails in other places (assert
>> fred_handler_called and saved rip vs expected_rip). I didn't yet have the time
>> to figure out what could be wrong there, maybe you would have more of an idea :)
>
>#DB is intercepted to mitigate CVE-2015-8104 (systemwide DoS).  But, to
>start with, check that the test passes when #DB is not intercepted. 
>That's the basecase for architectural behaviour.

I take it you mean dropping the ICEBP selftest test case and just checking INT3
and INT $0x20? In that case the other two tests pass after a minor change -
namely in guest_code() the expected_rip needs to be volatile as well. Otherwise
there is a RIP mismatch.

Or did you mean I should check something else?

>When #DB is intercepted, the type in EXIT_INTR_INFO needs preserving and
>forwarding into ENTRY_INTR_INFO, because that is what distinguishes an
>ICEBP #DB from other #DBs.  There's no way of recovering this detail
>after the fact.
>
>On the injection side, some #DB's are traps and some are faults.  ICEBP
>will have a fault-like VMExit but need trap semantics, so like other
>soft interrupts, need INSN_LEN adding to %rip.  But, type=3 #DBs need to
>leave %rip unchanged.
>
>~Andrew

-- 
Kind regards
Maciej Wieczór-Retman
