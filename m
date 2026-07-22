Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74145BD4E;
	Wed, 22 Jul 2026 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763792; cv=fail; b=VGfE7IgxuhssawRFBrmh8YsNVzMFncVPWsicTFWaeH9MN32GxgsyEU7le3FuO9rFkBVSKnwy68Wq9Wj9uS4nonutoPPWsgubRgH7rdYEl8NfAUzK9pmlaXXi69dGANl1dHsDxzHwGyvU0F8+wh8ABszg3vBtlwlAMFmCOtparsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763792; c=relaxed/simple;
	bh=QLzvIAHikRjyfWkRrcsDY2XOXnnH+N8w11Gub1ULxnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y64q0Cvp2ZxzD2VZgzF7zARsDvDG2GCboLey0NGdXblgg0VXEorxW6Y7DYoFPaNth/5xT6BWwljG078cD8XRb34l8JTLh8ukgPDDpnG0WWcgLkBP0CHrWhydHMnVDxbDXHHVusNzUOVKgqs9JqEwKuypXtK/hp3xUfbjwi82CQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqYdePXz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqYdePXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784763790; x=1816299790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QLzvIAHikRjyfWkRrcsDY2XOXnnH+N8w11Gub1ULxnw=;
  b=MqYdePXz5IQA65AreZObAeUN3x38JBGV5aej3d9aW2EYbbape5thhWUh
   BdOnaaq5yRc+s8TQ1h3JRXE6qaCL11RaauOpeTsBPxbsVq2aQN9I54IRK
   oAWzzDvInVdE99p3GDoOj3cN1qI/6uwbZY74GSdxBxnX4ldnOOxoAJsLw
   OdDUCREX5AhjAtY0uJM4EcWyMQy0gnX7NRqN4SYbRHj1LPinmMozIzpLG
   iLrV9TC8ACMn4yYAJ3Nfa0es2nkfSBVa9qM1faEzMVZ9UkfZ9zLLaJmQL
   /dmw9kYHxKEl7D/LLMIyL/2ceHLcxTq2LOm0iQUXz0PDzQ6JrLRW81b77
   g==;
X-CSE-ConnectionGUID: 408qRe3tRgqezJkanh4PwQ==
X-CSE-MsgGUID: BA2OWAbnTI+yILT9N58UKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="108203744"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="108203744"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 16:43:09 -0700
X-CSE-ConnectionGUID: NF9FYuqhSX6bRurlqZ+JPg==
X-CSE-MsgGUID: 9QC8qjgNSbOcpyfsed+EdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="254315228"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 16:43:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 16:43:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 16:43:08 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 16:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEvaPIHxAxUQ85QHwHSI39QMT03HxxcC1mXm+ksR8XDXvGkWKjgl8DTbFvR6r0zkaqre/dG5xdWHWFDn6liY7GsnukScMCwqG+ugONtOGYmYdS6oQq1QsVCzeLD/AWcrfzkAyLbcBKC4rWfcDuH9zREt82uxidaS3vFAGDSEKeZfsfX4M6KiYiTREbe+8TmJg7Qg/2lvbPKg7J5enhsHamyRG0lyyOXCGaypQMMeBroaDU4ZIsL4L8X2zeF0en9qzMe6RQGJFuAooWFwv1N6n92VanrWILNglc4gF9fRcxZEN4KPRV4pdMiRn6BXy16EaPJIe/4XRgpamlbqhrWNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLzvIAHikRjyfWkRrcsDY2XOXnnH+N8w11Gub1ULxnw=;
 b=V9qFRVNEClGzb9Rs7Xg0o6nEyhKLT0efXAKlqbI9pT6OM+VddfQXIg2Q2dWSWgX2foYA30b24ghncjWdoeonyRxNl9nLVd2N+27HlzJ6sovW2pxKjPYuo9H00WI0IWb9iqMr0qytH9jCaNgc58bql8NVQddYLRiw3xmYSrR7TfJmp1kbPTM11P/ewNLPLCM5JatIAsHKcifIwJHl8bYJfKgneqmsHi4E21/48Z83uNov75cnj/hGLaZ5D+EEBfuJ3D2gXvce9I/0STjYv2JcI0hQE/rTWIf8/8zwjElmzwC+gJ6+2q4yfvCQW/qhAtwzQpBkTw6xhDxRfb18aDjCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 23:43:06 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 23:43:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"djbw@kernel.org" <djbw@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
Thread-Topic: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
Thread-Index: AQHc6aBTjWoWMnuoLUCVq8+BE7F3eLZ6lGwA
Date: Wed, 22 Jul 2026 23:43:05 +0000
Message-ID: <bf4d5f6c62cc4298b886e75059990e87e3f3df8f.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-13-yilun.xu@linux.intel.com>
In-Reply-To: <20260522034128.3144354-13-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB8152:EE_
x-ms-office365-filtering-correlation-id: cbc7fd92-cc0c-4332-e153-08dee84afa50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: PV7FSiWZK2purObQtPQk2e4onzN+YDJ1ZOcnggcWLQTPJh+ZCCTFvh+zeERfJGa22YF1VQ3TwF0Gq6LJ9a/uOac+VPoIQlh5sCvGMr+mW+xcqpXiHZafIFTspSHUnDlXSz9WCifiV+U9+d0o0FniBp1EGl5o83yvrB/LHWBXGMha8daDOOtyiuKnn58X0Mqp0T3EulnAJcq+DL8BZvkxycxcIHaae/pfwNbS8lOifYwg2uvpdRXhKd48pkfeGh/349+WRLYfPzLcgE8aG0lZwlMWV5FTmJLLoCBiSPywh5Ckp4p+JbmprIeIJXApW1MXQKhHFFQSd0TWwLBZlK8cAlYPjwtw4TPCTgnF3vbU0DvPjP1d98SCYAePEKfb5Of3A0Or4l0uAgyxzGs+TLudsHx15YOVoloCtaLFQzUEM/nkHku0ZRzkgE0T637oTqOYwr+nPC2btF4lI6ocg4iEP6y3FWdoaz9qMfyW2IHiGJ0qJdEbwKF6aJW7CFtp1qqQiPvWCXOp5hDwIum6r3S3YA/B3RiC4zZe1u4umBoz7zAQB2lSL4nlOOw1Z4NPeNBDxz7IiXjxNmnFmBXIssDFPspre/a+560KXMxuMWk3/bx3oh13Acpeaai+eeOFCebekz/5r5b/uCL9ebK6tCG0J/USQFSVJ8cUtzFRYo4vwP/5NP4UuxiuAiFZgw9PQ/D2ILOzlvlkI3UUqVNQBsiIPMoosDZMzYd6vmtuukHYWLg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25zcW1rV3FxWlBVQzVyUGJ6bmtHK3huZzlicmJwTFpOZFBsRXNCQlRvZEpy?=
 =?utf-8?B?OXFWNW1Qc2Q2TlVLclBTa0NKUFZGYko4WFFBRWRIdU1xbEtncW1KKzRVQ0tW?=
 =?utf-8?B?UW0vdzVWM21uZC9LK1JCcTBRRW5EUDRGcGFHQng2TGtSeHBMNXR0dXlXeTVM?=
 =?utf-8?B?d2VEV1o5M1NNRDJFWmM4RXZsS1M5aFBuSFZpNE1iT2tqSlc3OGg3YzJkcjZE?=
 =?utf-8?B?YnFERWZZZWtLa0xJK2QyN0doalFmcUFteEk2UEY3TmhCbmZ6cnhya0VOdzdW?=
 =?utf-8?B?b1JiV3JEZjFkYUUxcmlyOWpKeVBSb1R3ZmplRW9hck5ONnQ1eGxtaEtTT0NE?=
 =?utf-8?B?emM2YnRMT21rOG1RMWl0Q1lpYXFKZCtsczVrRFlscUtiQ2k2cENsdnltQVJt?=
 =?utf-8?B?UDAzcHlBaFU2WDJzL25iZXVaOGYyRXVRNUdGV0E2WUR1T01TbDk0RUh2Uk5a?=
 =?utf-8?B?WUlQazVDcURlZ0FqVjZibTRyWU9kYjBQeVh2TkZmVmpTQk11NmRaNjZBL2pR?=
 =?utf-8?B?dThLUEpwK0U2dS9lYjBmdmJLVm90dUZ2VHFqRDBXK3c3MkUxK2dwWGRzOUNX?=
 =?utf-8?B?YTBsaVRUY1FvR1MvbHo1UitoK2ZkMUc5V1NpRFdiVXVVM1J5Q2ZvdTNOWDl6?=
 =?utf-8?B?Z2d3VXNxbGdJcUJCT1ZwcXJHUTkvWlpscHBMVm9vOWhWSUVHNEZScnYrOVEx?=
 =?utf-8?B?VUg2eFdRMTFnUWhDandDRzJHcnNYYm1jSEVVMVE4NHUrMWxqYnRBSHBrQzJn?=
 =?utf-8?B?Y0lsU0JFK2U3N3A3WUcyZHF3eEpET0F3M21QakN0amhrb2k2ZG1LMkNFS282?=
 =?utf-8?B?d1duZTExMVp5bE5SR3FvalJXNEh6SHBsV3ZIeFY4dnlXV2JEU2ljYTgwaVlO?=
 =?utf-8?B?eHdKT0NPTkFyNG5KNnFmM0k2aTRqL3Z4bTFlM3Z2QVJaZllnV2pHNVIyTmFS?=
 =?utf-8?B?RjVCSVhwUnhieHRUZC9mc3BZSlFua3BmbEZ0Wms4cmlUN3FrbG9OcUgzcEdR?=
 =?utf-8?B?alArWDVXczIyeUhPUHdBcWRqWFZ5aXk0QnRkSGZiY3VROXFwT0lNV3E3S2s2?=
 =?utf-8?B?YUpNSVBZaE5tSXNFOCtFWkh3WTRycU1CckxBSWx4Ri9Wa25XUUhlUk92ckpX?=
 =?utf-8?B?OE1zM3ExWndpaklpOFhFY0hjWlRxOHVvTmZkNWVkeW5sbWJEOFZaVDNtaWJI?=
 =?utf-8?B?elN1cTVSME53ZFYrMC82bkhGYTY0MUhGL3AxNVc5SHg1YWdJVVRIeUs1L1dS?=
 =?utf-8?B?bHlLb1J5R01wZ21YY0ZIV0F0dGtmWkl0WUR6dVBZUTErOG9INWRYbVdlUmsv?=
 =?utf-8?B?VVRkUk9DZW9SZW5CQWowcFY5eVp4K3psTG15cFN4c0d3MHgxOHJLVkl0VnFM?=
 =?utf-8?B?OEkzVmlTVmNBZ0NlN3JpUWlzbGJyYjZaVVdhaFp1dWN5QU5ORjhuWGI4VnJq?=
 =?utf-8?B?Y25iYlJ1bmpIbkk3ckE5di9wWkYvTHZMeUVFODcxdis4T0Uxam9HcVAxZGtl?=
 =?utf-8?B?T1lJQWZ2OXZFWWRFbm1IazA5dWlIM0FHS0hVdTNaM29sODdFcUt5OGs5bnRz?=
 =?utf-8?B?eGxKamNhck1FQmo3MDFBVHA1YjhWcm1VR0JoUVp6dUphL1puOXJkaHY0M0E0?=
 =?utf-8?B?Q0QraGVSajBybnRJUk5CaTIwK0xWZXg0Ukk3a243V0NmWkdwZDhkOGFxVG52?=
 =?utf-8?B?dXNYMWFVV2pxQ3RySyt2b3VSM1RobElLdy9rRGtLbStuSjFoRkxVTWhTZjhE?=
 =?utf-8?B?S2Q4dlBFTXdtam5jMERpRVNKUDUzVkdEMHU5dWNmK0xLY3d0V2l4YUI4bDJt?=
 =?utf-8?B?TEg4UFNpcDJKQTR1WEVRSGlleDNqRVlvbk91cCt1NG90UmQwMFZyQ1VRaXkz?=
 =?utf-8?B?YVF4ZXF5QzBvbTdaN3Z6cmpOdDlzaGQ3YWhHcVhnWkZYYzhIc2syZWhOSGZm?=
 =?utf-8?B?RmpSc3hBdHMrcFRSZzgzS3p1RWkzYXVGNzNRNkp5UWFnWGZGeVlSUFFmNXhq?=
 =?utf-8?B?dU9KcXJ4S0pLVDNpSkVhb0d6QWNTeStaM055VmJ0UVk3VVN4dURhVzAwUUtM?=
 =?utf-8?B?NlBoMHdoQ25TQlgzM0xtVHVkY2taenR5Rmx5VDJpMVZWWFVoN1VYM21JMnAx?=
 =?utf-8?B?MTEwbnBuZm1lYUlTc1AwR3pNeVQzdklYNFNrS2MzT0ExczdweGtCaTJOSEZw?=
 =?utf-8?B?b0lhNE16alZxaStnczFvMzlsc1FVOWREUVYrQmVjQkdmaVI2QVdqaW9IU2tm?=
 =?utf-8?B?R3h4aE5xaFRRUFNxZnpXZGZsdUY0STd6M21CSThwNkFDUXg2QllrVmdFMWpE?=
 =?utf-8?B?Sk9NaFNNaVJsMUhqSVFzNVkrcENqL24zM2ptY05CUnR2aWhBWWs1b1FOS1lK?=
 =?utf-8?Q?ENpcxjsSAwTG36Bw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <191545DFF4662E48AB124F7A17E02259@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nd+eloDkiple2oH43iXVmf9nqjhK/amlAlbC2AxB2wY4wfEEi9Uua3AHq0kzge/ZItR+ODOMPHe9gXXC2p9ugBo9VL/BUejlHttDqBwcJ4Woe3sK+0UI/ykRTT3fbKYSRsNG1PJAgLw6klaz1vhlGrV5LdwNzU8mgBdxeO/1HnZpIT4dHUYjrvjOnSzW7uPP7oSMbx9tiZkxLXp8Xxm/mDZ+YmTLc+gGv8eNTL05Fe+uj4RaFs1MFq3IjGBOlubU3DkdTF7BEVG3R4tZ3NEIdEnhsBtTpu6eAtM9iw7PMQPl/yqNkH0S4qKVaXmeMPkNWBSaBC28bYxUlETlwEx1ig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc7fd92-cc0c-4332-e153-08dee84afa50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 23:43:05.7818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyrJB+AB+R+U2yCRU1g0Kpqry2liyUNCkWweQhgJmtXxyib7hYhINbLzQV6XG1jZdSoFmkXRfNDxaBJ3VBWPexeLro3cxCo5xbPMeB1bYsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gK3N0
YXRpYyB1NjQgX19nZXRfcXVvdGVfa2VybmVsKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0
IHRkeF9xdW90ZV9yZXEgKnJlcSwNCj4gKwkJCcKgwqDCoMKgwqAgc2l6ZV90IHJlcV9sZW4sIGdw
YV90IHJlcV9ncGEsIHNpemVfdCB0b3RhbF9sZW4pDQo+ICt7DQo+ICsJc3RydWN0IHRkeF90ZCAq
dGQgPSAmdG9fa3ZtX3RkeCh2Y3B1LT5rdm0pLT50ZDsNCj4gKw0KPiArCS8qIE9ubHkgc3VwcG9y
dCB2ZXJzaW9uIDEgYXMgZGVmaW5lZCBpbiB0aGUgR0hDSSBzcGVjICovDQo+ICsJaWYgKHJlcS0+
dmVyc2lvbiAhPSAxKQ0KPiArCQlyZXR1cm4gVERYX1FVT1RFX1NUQVRVU19FUlJPUjsNCj4gKw0K
PiArCWlmICgoc2l6ZV90KXJlcS0+aW5fbGVuICsgVERYX1FVT1RFX1JFUV9IRFJfU0laRSA+IHJl
cV9sZW4pDQo+ICsJCXJldHVybiBURFhfUVVPVEVfU1RBVFVTX0VSUk9SOw0KPiArDQo+ICsJLyog
VGhlIGNhbGxlciBmcmVlcyB0aGUgcXVvdGUgZGF0YSAqLw0KPiArCXZvaWQgKnF1b3RlX2RhdGEg
X19mcmVlKGt2ZnJlZSkgPQ0KPiArCQl0ZHhfcXVvdGVfZ2VuZXJhdGUodGQsIHJlcS0+ZGF0YSwg
cmVxLT5pbl9sZW4sICZyZXEtPm91dF9sZW4pOw0KPiArDQo+ICsJaWYgKCFxdW90ZV9kYXRhKQ0K
PiArCQlyZXR1cm4gVERYX1FVT1RFX1NUQVRVU19VTkFWQUlMQUJMRTsNCj4gKw0KPiArCWlmICgo
c2l6ZV90KXJlcS0+b3V0X2xlbiArIFREWF9RVU9URV9SRVFfSERSX1NJWkUgPiB0b3RhbF9sZW4p
DQo+ICsJCXJldHVybiBURFhfUVVPVEVfU1RBVFVTX0VSUk9SOw0KPiArDQo+ICsJaWYgKCF3cml0
ZV9xdW90ZV90b19ndWVzdCh2Y3B1LCBxdW90ZV9kYXRhLCByZXEtPm91dF9sZW4sIHJlcV9ncGEp
KQ0KPiArCQlyZXR1cm4gVERYX1FVT1RFX1NUQVRVU19FUlJPUjsNCj4gKw0KPiArCXJldHVybiBU
RFhfUVVPVEVfU1RBVFVTX1NVQ0NFU1M7DQo+ICt9DQo+ICsNCg0KS2FpLCBQZXRlciBhbmQgSSBq
dXN0IGhhZCBhbiBvZmZsaXN0IGNoYXQgYWJvdXQgd2hhdCBpbnRlcm5hbCBURFggbG9ja3MNClRE
SC5RVU9URS5HRVQgdGFrZXMuDQoNClRoZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBzZXJpZXMgbmVl
ZHMgdG8gY29tZSB3aXRoIGFuIGFuYWx5c2lzIG9mIHdoaWNoIG9uZXMgaXQNCmNvbnRlbmRzIHdp
dGggYW5kIGhvdyB1bmhhbmRsZWFibGUgQlVTWSBlcnJvciBjb2RlcyBhcmUgYXZvaWRlZCB3aXRo
IGtlcm5lbCBzaWRlDQpsb2NraW5nLg0KDQpPbiBpbml0aWFsIGludmVzdGlnYXRpb24gdGhlIGNh
bGxlcnMgbWF5IG5lZWQgdG8gaG9sZA0KdGR4X2FjcXVpcmVfdm1fc3RhdGVfbG9ja3MoKSB0byBh
dm9pZCBjb250ZW50aW9uIGFyb3VuZCBURFIgbG9jay4gVERILlFVT1RFLkdFVA0KYWxzbyB0YWtl
cyAiVERDUy5PUF9TVEFURSIgYXMgZXhjbHVzaXZlLCB3aGVyZSBUREguTUVNLlBBR0UuUkVNT1ZF
IHRha2VzIGl0IGZvcg0Kc2hhcmVkLg0K
