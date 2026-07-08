Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789933E4C87;
	Wed,  8 Jul 2026 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543780; cv=fail; b=PyZat1gvkzeZyZVWM2nSgYwTjwS4j2AgMWwU/CmllKYlDB/0LWAhgqHSWrZuMen+eJ6afhnlu0tPA1u9VFucuYjyhBf6itplWFqhtKPunkgmSmGdg2XvSL4BE+jWOVOAJ2L1SEPE4/JI5NM8mC26BPoPc3v/C8RlLJ4RYeolMUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543780; c=relaxed/simple;
	bh=zv1mbIYuNTAiaj2e4Kl9pL8S88z0UV3L1lWqN6/Zupc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rCrnXcKxs18EtecsJ8YoWgpXZ5VjwdB/BdPQvmDE9TiYRxIuHHPYu6zAubn3Z6hovxfnw0EGLqrfQlpKG0i5IUkqN5eIOQZpdE7egqW85groquA4ZcbhrntLsB+WEhtYyWdWTSsARQbexW2vAMi4Cdr/wS1av5MwGA2BSyxRCpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apxdFLxo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apxdFLxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783543780; x=1815079780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zv1mbIYuNTAiaj2e4Kl9pL8S88z0UV3L1lWqN6/Zupc=;
  b=apxdFLxoisfKb8JOwtdLDSHh2y/ckAAMHrzgkYu9DPuRX7/l6cyBxbWr
   i8tk8XtAY4RXKlh9n5DRtVS6ynFr3jmcKwE6at2Y8lA4eQQA+uEfWyn5M
   mIYOcbe1GhUtohAtxW/FcOFriRKfXS9nwtr1ZHh7zzN/lIuUtA5ET0CWM
   QXMFD4xjkaRpX7QTlpLC+XvTP6OEoL2hkxalB+pB5xtmqMQBq+qm59bnj
   +p1chCTAJ+aLwsZ8AsjO5XBeYmFRAKFvBjiP2jStf33fFVn3Y57+RujOA
   l+NhXmKN4bT3CVWTTkfdACFKc/hkvAg+Tnll3azzHHGUk//9vP0ZDFLok
   Q==;
X-CSE-ConnectionGUID: jLGjmHlWQ3eYuXxsC2MySg==
X-CSE-MsgGUID: FttJCXNgQgK34tN0oR6sMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95594763"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95594763"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:49:23 -0700
X-CSE-ConnectionGUID: KpHwmi/CQI+dppjnlQGF/w==
X-CSE-MsgGUID: fseodDtqR96bmeMUxBXeqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249971653"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:49:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:49:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 13:49:22 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avtQa6MnxXApr5J5Ae9L/sasbsK/+/KqoUg+rQONaO0HbhAJMKlxgLsJA7lcdxyQ+PBiAef19qHLhiiK2fu+Y76NxdIsfYwil57IWgdM37QU67Qz9X5TGBU8Sj9Sx00jV9I/+6oPCFVFX0H/kl+XxOnQFX2nFWlpbMuLhglxzeBxsfSLZowUlgwEaH19T7VTCXnfLVntj/ksdntqaV25k341d+4Hf/8pNjd0XwHYAOR6p5XiKZsUWBhG4RDy9AkUVvR7lZwbFnOR3qmPeYFTdNWOqif9rt53XkmLZ7ZLOnPmmoKzb9hHBn/HRwTgdV3Pz+I/e7dWqXCO1QktEkNJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miBZNke0gw+52OO3k+zi1nDao+G1JOs6auZq9W9fnko=;
 b=eOQlFymOF1dSvtdly/T0zu6DTYeNK6rb3r/SCGhkFd5ruvRIwtjDwOi6DyregPjXBvcSQIsv/VOeR6Nqxj5s8mXPWQMAvdrqMDBD3dBgN+WdoFF7RfAXuEZFajFO4A2OxQewn/ciJFpOG/bOOTjAWtAhQOsRXAG9mjWiA3yzKxUcHH6iR1YfvXSzNsjBDWZiJ/RD7pKOxB9NlhjioWd/fguCOHCsvhpwCBimgS/p+bmhf9b2OTtmli144C3vtGzYe3oHl8+XopkkAr8ptUC+lKTwjs5MfF67MIEMJwOFFN/pghMvouvdx7q9Ys1nWmtwa6sPNUg366Z3YftiSSd4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:49:15 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 20:49:15 +0000
Message-ID: <6ab50a8c-d502-4d51-b037-3af6c4b4083e@intel.com>
Date: Wed, 8 Jul 2026 13:49:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Content-Language: en-US
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <yan.y.zhao@intel.com>,
	<kai.huang@intel.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-5-rick.p.edgecombe@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260526023515.288829-5-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 300576e8-758c-40bb-531d-08dedd325f22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006|921020|6133799003;
X-Microsoft-Antispam-Message-Info: zZRpjacjlLnaMNOcf4MIuh+lmkiQNOXgei1e7ZU4UeD7DVr7APXeXBHuhTPbfkUnpZldZNiTKYbHmrXShUAjSR8b0HH1ezK8DrJFHoCY+H65+PVCIbgjOAsP/WL7l4R1qibXKPmDDHWPVKh3q1ZZU0o+us3Ke89MUpLo/7n0JaTg+Eul/0Q6hfwvbFqhCSw+oO4tGQtPm2wdGZEhXDvTRd7XSJ4mobpr8cq5KUmW0g7iSMrDFOEZ6ttylFoRmLzy18jOJ1XNNRqlsE5FZ5Ju08Eo5NWMy2va1HypI3EBW8fM7RbWbSH5TNhMnDNyxfcuhcqXl4NX/KwpETTs4b8svzmkA2ZK+cbS7p3NibYUPaQCCLvMnxfbEyqBTG3aofG+DwyeVarsaIOJA4mTyGzOt86eAx632D+zGm+pKpOlcdnUS0Bn68GQnvdA358KrtagmAtsNOt2BB9BT4XU3RXAb4yaSX6jP2eNsRh4aM21q3rUUBxyftpdjiGRy/H8ZX46rReYUOESuLRlmqt9Af5WvQhQfALxgZfoJOiH25IMnZ0YQUl1m2ycM8rRZbVkuY4cQLF5i43BIsU+2tGZkzw3aJyMi5PcIt+gnavTUbVoXfPEJs+T6G7H5AIvhkKb1dPDk5ivJLMGCcF/freuiSNVHO+tRKiZgUcHy3Ts1lbIkdMBzjakYgRs31hxd9RmhMC36ZreepVkgMLMtMwm33s9cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTE2Y25rRlNuY2hZQVVNUkNHYnlXQm5OYm1ldllRWmdGRnByZmJ3VDJLa3dJ?=
 =?utf-8?B?MlhSdi9mWkJZeWNRZ3pyTkVUVm0rNVRhL0Vsd291MnFueWk1N1ZmYUc1TU5i?=
 =?utf-8?B?NHFwME5tL3oyQXYxdDB2Mk16MmNXU2RWT0lPWVh2UHZxLzVVK2VQNGJxdXlu?=
 =?utf-8?B?N2YvdDJpTVk1QkJwc1lwZFhxMXZVR01WQnBwUWh5QmNFa3IyOFQ5R0Q3dlA3?=
 =?utf-8?B?OUVyOXNHemwwR2lLcisxM2diMlhJeWhtcWwzQnA4VUpqWGw3TlZuQ21mcnlx?=
 =?utf-8?B?RisyMTUzVmtmVWtMTzBCMUhWTWNMTEhxeWZGOVBDcmNoT3dWL21oKzgvbEtI?=
 =?utf-8?B?STlEQ3dYaHFTTy9Wbnh0em9vNWNxY2lpQmxaMDdXT1RzcUZpS3A5T3B2TFVU?=
 =?utf-8?B?Z3ZrUTNObWdhdHpoTEgzYksxTUFUV1gzQXFKL3g0VTdSdTBrallsaVFVUSsv?=
 =?utf-8?B?bWk5c2ZPbkpLN2UwZGVzaXY2WXhRbm9aTjRVdWF4M2ErU3pPWkljS0ZaWWs0?=
 =?utf-8?B?U3lWRHc5d3ZNQVYvYTRDejlBU2xvUGNVYUE3SlF2aEFMYUtEaDdpaDVWNTdr?=
 =?utf-8?B?cWpUVEh2dnJtcFg2WW9JVXl4RWtLbkZzY24rNk1DcWxvdzVVeEdNSmxYQlNq?=
 =?utf-8?B?V2ZpNE1tMmM5Tmpab3RrTHJnOHlwck9kNkVOMVBsTHEweER5ZjAvbkdpVW9l?=
 =?utf-8?B?dzlBRmljSUt5MlV0SG5YNGdWdWxtcjc4Z0xkZnVuNm9reDNEdTluNk9SVnNL?=
 =?utf-8?B?cEkxc2I4Uy9rd2lGdVhER05tTWlicm1vVmFQREhMa0ZldzZQMDRuTVcxdk95?=
 =?utf-8?B?aURSYWdYL3JQY1h0K1k3ZUtrTnQwcWdFZlJTZHpYNkF4b0d4aWMweGwwamNF?=
 =?utf-8?B?Tk5zdDgzbHRndm1URlkvR1NXSUFIM1dEeUhPTXNyMVIvak1MZ2tieVdkSGYw?=
 =?utf-8?B?R1hkRVJ1VHlWcTNFaDQwaUs1cnVyditZbEtQbzVzQ0R0R21kdnNlTVM5NUtl?=
 =?utf-8?B?bXkyUnJNd2JHWnFkZHphd1A3NXJFRmVVUnRNYjMyaGJETCtQcDFXaGNvV3Vq?=
 =?utf-8?B?ME16YjdMVmxxSEI4WHBycmZ6OXBBbXAvNHE4UktrM0RqRjNINzllZXlQaE5O?=
 =?utf-8?B?ZXRqcXp5YktsUEtlRkdYWkVhc2NYSFFjTFJkWmc0L1dxRW5qVStpQ216Y0ZS?=
 =?utf-8?B?ZEs4SndkYVNUdG1SRFZOaGJNQzBMOFRuc0VkbmxCaVdKUFpNZWdqRFI2czNo?=
 =?utf-8?B?SVpzR3h0bmE3VXJuTnA3TnlGSDJYbXdZQXlxdmRLLytmL2FPRFZCNTMwa1Bu?=
 =?utf-8?B?VjJITmNScklIaW9jTjh5WkxTbFJ3b0RLVEV4QU5obkFOak1Zbi9EemhmcWZy?=
 =?utf-8?B?T0VoanJhTEVwOWpVT3d1VjVCb3FwcnhhcmJha1VSREFOd0hCUFVZNVU0eFlO?=
 =?utf-8?B?bDRhL2R3VHdZaU9GcGhialhONHJLMzAzZVpUM2JvZk9YYkg1MVZjZ3J1blRQ?=
 =?utf-8?B?dDlLRTd1MEs4dE5FTDFUR05Cc2hkZmdqSjFDcEVEcGRSZHRBOFRWUU42UUpT?=
 =?utf-8?B?QXZJNGU3VHVVTC9Lb3l5K0dBbjdJQzBFYm5GNFYzd1dzRElBWjRiWnMxblVm?=
 =?utf-8?B?RmNNZlhNUGhnRU9hOWdZVEpFVHRhS3R5dG5sSGwrY2lydXRTSTVJd3dReVRZ?=
 =?utf-8?B?Ym4wcmxwQzJIUUVFdm5qczIya2dQK0NvcWdydy9YRlkxaTdkcGNHNHIxY2g0?=
 =?utf-8?B?U205WEpCMTRwN01OM2tMeGNaT0pVQ3RXVXl4eXlwTndWakdCYVJGeHRrU2pU?=
 =?utf-8?B?Z2twQnRNaHp2Ri9CQXkrNHMvbUhWZzJSVi9DOWd1bVZ3aHpldXZoVUZES25v?=
 =?utf-8?B?a0pubUNjc2Z1aGw5WWdseEZ2RjlVVEluVjliVnVMTEZ0cVozYjBTdkZLaW1v?=
 =?utf-8?B?N1laMHRXZDVCUGRPVkVHa0hhbFhldDlPeDJmY1hEMTdYcGc1SlJPamx3WUl1?=
 =?utf-8?B?NGZnNlJvanNVRXVIQjErczBzTTI5YjdHQmtyenFUSXpwQ3gwVitjeDEwMWsw?=
 =?utf-8?B?ZmdsTWpIZk1XbW83QVNmL3BGZ21tRmlQdVlpVXg2V0dpN2R3OTNaWUw2eU9k?=
 =?utf-8?B?SU1aRVV4Vk5CZTNmL2xzTkIxdW5xejEzOHcxSGZGYk5GM1ZQbXFWVDN1NFZo?=
 =?utf-8?B?WU9ZWWhoUi9zWExXNkw0WkxXb0RWTFdtMW1WZnNSKzNiQ3FGM2V5bU5PRGsy?=
 =?utf-8?B?SWlRNzhBY3JXVE1LY09nd2VxUnZpenBNMDdaMWlmSGdVYVY0a3JLcmF5Wk5y?=
 =?utf-8?B?enFGUEpiZUJWcGpWdXQ2TmF5Ly92MUhBL3FUVUlUTzJWRjBiOUZuZz09?=
X-Exchange-RoutingPolicyChecked: a2MwV8zATAUrZVI3oSHljzxGXYirTnQ8Bj72J/r/9W61VLg0C8ldVGhkF6iuD95hZdrEkc+0RsoJ/vp+pVJyFrkk2gUCpoxw62MY7LBTN3i3z+zRa4mFf+jaS2vqaUsPk+FXZacyKDnUGb+NHaPbQkD2FzKnXu5XxCQLL1hk0uoX5bk/B8AhoxyAUHq+5Qfn1p3eD8fRHK7b+/e2RNdwZ9GJMQzWAZedgSVp5rwNZw3sI0RxmaabTE5BXWrmlA5hSYIePVvcEd2i/DMnlYYTtiIpsB1tyN5nXegyl+CACzttJbDlY5jDBCrLZNcPovAmutdlSptaOw5t8Hscm7Z4TA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 300576e8-758c-40bb-531d-08dedd325f22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:49:14.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A0gMjv46/7K6w7YYxSOFVSntCYZAg7YAzRluw0sTQQ8bBFEM8qPXPB2p9t/vEUbDzn/v/64xB18g2TjlP8JlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-OriginatorOrg: intel.com

On 5/25/2026 7:35 PM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The PAMT memory holds metadata for all possible TDX protected memory. Each
> physical address range is covered by PAMT entries at three levels (1GB,
> 2MB, 4KB). With Dynamic PAMT, the 4KB range of PAMT is allocated on
> demand. The kernel supplies the TDX module with page pairs to store the
> 4KB entries, which cover 2MB of host physical memory. The kernel must
> provide this page pair before using pages from the range for TDX. If this
> is not done, SEAMCALLs that give the pages to be protected by the TDX module
> will fail.
> 
> Allocate reference counters for every 2MB range to track TDX memory usage.
> This can be used to handle concurrent get/put callers, in order to
> accurately determine when the dynamic 4KB level of Dynamic PAMT needs to
> be allocated and when it can be freed.
> 
> This allocation will currently consume 2 MB for every 1 TB of address
> space from 0 to max_pfn. The allocation size will depend on how the RAM is
> physically laid out. In a worst case scenario where the entire 52-bit
> address space is covered this would be 8GB. Then the DPAMT refcount
> allocations could hypothetically cause the savings from Dynamic PAMT to go
> negative on exotic platforms with sparse, small amounts of memory.
> 

...

> +/*
> + * On a machine with Dynamic PAMT, the kernel maintains a reference counter
> + * for every 2M range. 

Commit log says every 2MB range.

The counter indicates how many users there are for
> + * the PAMT memory of the 2M range. The kernel allocates PAMT refcounts at
> + * initialization.
> + */
> +static atomic_t *pamt_refcounts;
> +
>  /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
>  static LIST_HEAD(tdx_memlist);
>  
> @@ -254,6 +263,43 @@ static struct syscore tdx_syscore = {
>  	.ops = &tdx_syscore_ops,
>  };
>  
> +/*
> + * Allocate PAMT reference counters for all physical memory.
> + *
> + * It consumes 2MiB for every 1TiB of physical memory.

Commit log says 2MB and 1TB. I would make both consistent.

> + */
> +static int init_pamt_refcounts(void)
> +{
> +	size_t size = DIV_ROUND_UP(max_pfn, PTRS_PER_PTE) * sizeof(*pamt_refcounts);
> +
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return 0;
> +
> +	pamt_refcounts = __vmalloc(size, GFP_KERNEL | __GFP_ZERO);

vzalloc()?

> +	if (!pamt_refcounts)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void free_pamt_refcounts(void)
> +{
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return;
> +
> +	vfree(pamt_refcounts);
> +	pamt_refcounts = NULL;
> +}
> +
> +/* Find PAMT refcount for a given physical address */

This comment is probably not that useful. The function name is
descriptive by itself.

> +static atomic_t * __maybe_unused tdx_find_pamt_refcount(unsigned long pfn)
> +{
> +	/* Find which PMD a PFN is in. */
> +	unsigned long index = pfn >> (PMD_SHIFT - PAGE_SHIFT);
> +
> +	return &pamt_refcounts[index];
> +}
> +
