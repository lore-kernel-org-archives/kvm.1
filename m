Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF1405F7
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789949601; cv=fail; b=odK0RSc5Ah2MuR53q+y/n7mrZUOmUaIFJ/17qMiRRxgnqAMI8x0zs90FSuZKcIopfPkJ314KVoKYC+sns8eC/cvy5uHBsEi+YATLs/DMrcFMOWZ+NNgkzn5Az9CKh67k5Ywa3b0+zaMmm/NEF5LwFLYfwYd07dFfQF5ieOtYnx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789949601; c=relaxed/simple;
	bh=pCZEG3nu/kupSHGmjlF4duFzXorkCkJX9JJ9tSReh2A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MBzir1J5Z/Iy89seZKkYvGlX7d7iY/wmMfiahZrYT2dXIIt5KMWy+j7QtPHmaHzTBKN895bfw5Ez9sLzIBE2xNgE00a+7vIWIm7NM/z5TMiqKafKcRVkGRSEFV/y4ysWDbHM9eayRJUUmR3hQt+Ntc2m4BHbNF5X2VDVCG1kIuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtfWdjO+; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtfWdjO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789949599; x=1821485599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pCZEG3nu/kupSHGmjlF4duFzXorkCkJX9JJ9tSReh2A=;
  b=jtfWdjO+lPGclAbzvsUR30wFNmU1oD75zPIsljGtkVhnrSTh0ydgOiR3
   cF+28S8NgosSwtqHIeDzdmmSc+PqYPGB5ynMHCjo5dHWNwcQ60YC91o3x
   I72akdYRpvb55/SWrnbepOABdHWVct6LLvhXydhmS3zEuBOU9qXyXvTdL
   lsF7Ya77HjNSy7ErDwatD80GThAOwVuVkxeIN0PrNAyEcaMeq1HzyjqJx
   GNO4czBq1aWLRJoY5d0lgRLDP6rB5HdOPaujcJYiTzH0WxiOkLbNRzC0E
   OS3X33ZPufciqF4a86jt3FW/68qHme6SOFHcLCJ7aiqp7ZKdFzzFJgA/s
   g==;
X-CSE-ConnectionGUID: jry6bAhATL2RERzJXyowRg==
X-CSE-MsgGUID: 9LKCT5prQjGL9cyIiRZz3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90455443"
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; 
   d="scan'208";a="90455443"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 17:13:18 -0700
X-CSE-ConnectionGUID: RN2ryj+8SeO2LtboVc+G+Q==
X-CSE-MsgGUID: Vik0voPaR4OFpaqsE6VZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,112,1787036400"; 
   d="scan'208";a="280479181"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 17:13:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 17:13:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 20 Sep 2026 17:13:16 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 17:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYRkxqfgsnN/WHlsqHW7c7j29ODdl99my4hW15MuytIguCa6xBwxPA8pwaPqvmhhZ5P+AtEG0R7OMIUvEmKkCWWF0y4YVf/9AihCXc6u6zewI2RDeUKfuHkyneZbIXpA6CHyWjzpOvqaRIWwtRdtJHTrslAPS5sgZxyphzsvV3moKTL9ZrJXDZ0nLflbyF9DrycEeWN3xFxVbhbn30Q0Y7TCy4mjhNdv9dXHHMk1w5ZCdy03nGowsWnQMnb2SucazD8GTUaI1qFQhefHFEJCkhX/NiDWggoFyXeHefyYdVzzpflWPEg/udFGbjdmwy1Tr6ZiD4lVgLy7pbXpSBEFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViyH6Bo1Ozufdxah+2k74eofUIoXqGkfsfPbMjdFKxQ=;
 b=JjfcRkYVqsJm1D5U8z0URnjQSGFDKv3WMSrds4cfXFa/gbVdJ5GSeqzZse1JAHYQhWJqw16jc5BEqIXSu+qZ7FWb0J5sGANePFFAi+2wL7ZAijzGcFNeJS0R8sJxaVWLLjAIDD9eSo6BkAnyMTNCf1nYQ72DT6svuKJjYfmExV2X2F9LPAtauwhu4Vp8TYTsaRMmFbcesjlz+JppNQx9CHul0eEz8c3Ar21bBKdfPbnj77o/dzuyzu4zFuIf+e3faTIJiRX1Lrea40QinrzNx1x/N3SocsqMy3BH28HG/A3ZxulVEiw1ARVH5p30CD32VnUjkNMDp8y44pvxaV70DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 00:13:13 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 00:13:12 +0000
Message-ID: <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
Date: Sun, 20 Sep 2026 17:13:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
	<farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven Price
	<steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel Ortiz
	<sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
	<jakub.ruzicka@matfyz.cz>, Vishal Annapurve <vannapurve@google.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Xiaoyao
 Li" <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kvm@vger.kernel.org>
References: <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SA2PR11MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2830ea-3661-4d13-ece1-08df1775201a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: +K/3sAxLBzmCgTQ/wCKGm+RIuFs4jsvVhTKx2oR2OBRW+5pk4MFPfhNqKmcpHTE4WKY53GMxCbj+cEijfCfkcqeiD+RNUGalQ6yAQpg/W278AHFXs8NDu7tDpRMJL7RAW3QwQVTrKW88dacaOI+3Gs/z+0HPHNAvYibbBOFdO3NTixIirCmfneqUByNLMdgMTg29558wikjrGyHWy1B55519YMVKY/57ivUvnoCkcdXfR8M5FTDBlAnVvB+qPQ9YjG9C6dydX1ubOR5g35oVKjvMGzCGQ110uQ5WktQtIYcU3ft2DfQ6oJGCAHrI+SUQQWet1qRHwUye/R5of/Zgc5XM7buv2BasuGXMuZ4IP4vAbTAUGuOOnkKVWrE2e4c3VwoBdcwfS+H8uyUplx1eOENNhbueaGFbvsI8/HdGzlblstcRLJ3FHIel8JCR4ZYxumr8zwOx8pGK7ALBDj7vSlHZcD1yM26cMFJu4puw3Hzom3FSeNXlF8IsU3m2fiX0Sc2ME431N72TDr+DzpiMuGqI9RfXqCt62Wh7mSoxNDxohlt7Aov2D+19ON3YRzVzOAeQecii7C72aq/yV2hhZ3hoQShFhB7hxodpW2h1m7umxJ00TYpbLK7E+S+U1TP8om/5NkSWiA1Mbmrfps39xHEzQDA/hyd6W+7UJlsjfTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJ2bkpnZ0x2OG1qdWVBZjhSQW5ieUlqeGNydXBRdi9ESVBCbFI1UjRUeFZM?=
 =?utf-8?B?dFZYN21uVDlJdDZSNlFEQ0xKUE0rM05nbnllSGtuVDJIOStyVE4yVnRTTnZ2?=
 =?utf-8?B?WEt3dEFRUFhubllUM1R0VzFMS2JScVRmeG52WjIrK0RvRExqSTFUZ3FwbU8v?=
 =?utf-8?B?c0dKVFluZ202RGR3Zlh1eGF2Y205aWRha2twK3RLSGJSRUo2VS9WcEVtWHh1?=
 =?utf-8?B?eEoyb3BqY0czNjN1dHJQYW1LWDhOWVV5bFl4dzl2QjRtTldlK1YwSkNBMWpJ?=
 =?utf-8?B?YTY1SlhiT0Z5TWxOeXNwNjRBSkZjdlRScmt2VGU4N3lLeHZJc3p3UHU5THl2?=
 =?utf-8?B?UG9kRTBjYzJvZjJON1VLaCtwQ1dZbTZROWIrZmZ0NDZlMFpwVUpUNXVocVdj?=
 =?utf-8?B?K1paeHgwaXN3U21SMW1VZVFoaDEyMmMxQ0JCY3hNRy9NSGlyd0hkd3VkWVJN?=
 =?utf-8?B?RldmMUhrYmFTSzc2SUZ2bW52eXJnZU43VFo4U0xLQVF4ZFB6YlhMNExRTWtL?=
 =?utf-8?B?UUZSS3BTNGdWY3QwVFRJSkd5Z3oyZ3o2eWIrV2YxQTN2aElzdzNwdkNNUVBL?=
 =?utf-8?B?SDhOaFVuT1dudWE0RkdyWDl3dC91V3FES2VwckdyTE51ajczQlpJYkJmUjBi?=
 =?utf-8?B?NUZ3eDN4TUxCU3lRYnF0SndqZXhwYXdRTVhHQXA4SFhQR0ZJT3JWTWhwS09I?=
 =?utf-8?B?bDNRUVNsSkY4enVFbWUzeTQrUnNUeEFkRWtFZ2x4TW01U0VlaUppeFB5bUFR?=
 =?utf-8?B?TFpXejh5d0RwVDdCTHlSbUxIVUJFZkxBTzQwK092bkVWejRFVERtUWVFWG4w?=
 =?utf-8?B?QkNzNmlWU3YrUnIwalpBSmluZjgrT0RhZC9sNTBwTDFqeG1FbzZXYStrd1p4?=
 =?utf-8?B?VmMvTTdVdS9NckNZRnBjQVlOTTlqbW51WVdhaEU2Y0x6c3dDS0I2aFQ4dHc1?=
 =?utf-8?B?RUVzUDJlbjBWUlJYUXFkVlFCdGs0N09neVh6TzdRNTJrWWd1d2loMWRZL3BS?=
 =?utf-8?B?a08ybC9BWnkvM3FMU1l4MzJoVnNtd2pnMXltbGZIRVN2dGRjQkE1dUplQ2Jv?=
 =?utf-8?B?a0hZTXo4L1hDdDhEL2tqYWh2YjlWb25wSXhwMnZtalE4Q3BldHNHOUtDRTVN?=
 =?utf-8?B?ZFZ1Vnh4a2JNNlNXQm0ydDIzakZKQktxaHA3YVNWOXFqZ2FHdVdBdDFRMmdI?=
 =?utf-8?B?eEVUWmd4akNTa2xzWGlxZTlEMnhKVmkrU3BSYW1lZEl2WnRlRHFGTnBzeENa?=
 =?utf-8?B?RE9Xb2dTM2RLcEx5czNlSnFzVCtiZzR0Zk5RMHNuOG1UK3Y1MExVZ2RTRE9v?=
 =?utf-8?B?TVkxNG5GeUZSVzE2VXdXZEdJMFlEaEsrU2VCMk1TeGxKYnFacDZvYmd1bXZz?=
 =?utf-8?B?K01TWWFVYURJUDgxZGFnNHFYamxCWTRWZEJ5VFlVZU9Fd3g3WkpFc01vaXdT?=
 =?utf-8?B?RGIxSENyM3RZanllckdvTmpPNDdGRWRLWjhsclVoMjd4djIxdDkvRG4rY1RI?=
 =?utf-8?B?Y3dEOEw2VHN3MUNkQzd6UjVGMVZSRUwyb3EvSm0wQWxGZStxa0E4dHVWd2xL?=
 =?utf-8?B?cFRRRE95YlNsQjdkdFJvQ3AwU1hxUWVWbjc3NjNxdkRoS3Qyb2grUnkvM01p?=
 =?utf-8?B?dXIyRUFYc29WaURQRkVES0pKamM3N0JRYksxY09CSFFsWTJPOGQ0WW1uUnFj?=
 =?utf-8?B?VmRsRWRNZzJxZEUwalRyeDRTa0c0aGJhUGQyckQ2Z1NjcjA1MndrbUVKcnA2?=
 =?utf-8?B?MlpiRHErNSt4TGdVTzlwWDBPNGY4ZHdtNExKSnVUN2x2N3JtUGQ1VXVzYWc3?=
 =?utf-8?B?azhjTStCcU1XUEpRMVZBR1VlQzdMZjlTNFFyOGFURXk3dVc5M05SUkloa1lt?=
 =?utf-8?B?Qmx3cGVZSmZrV1NxbWNLTnBsa2ViSnAxdHlzRjM3WVJaS0c1Tng1TmNVQ09K?=
 =?utf-8?B?aXBzVHJiVUZ5ZzVteldtWG5iM2I0WHI3eVB1RmRtaTF1UWZLNktkdnFmTS9w?=
 =?utf-8?B?YUFsREJaVSszQTlBbm9hSmxoU0JLSnVnRnNoTG9ReDVQM0VIOFRDbFJWY2Y5?=
 =?utf-8?B?a1JPek9uVVozbFdONEhXaXJPY0VSM000YUQ4bGQ5cm5jRUordERhNStnbit2?=
 =?utf-8?B?YThGS1FaejNuQnRMK3lxRVAvSVZzeHA4bjk3SnhUTDVuK2xHRmxRL0dHOG9m?=
 =?utf-8?B?MzRqbnNqZnRISkR0THlveCs2RnBzaHhHcnNYV01MWVIwdlFKQUZDQnVPeTZu?=
 =?utf-8?B?ZDBWQzZzTWtqc3duWk5DZkViYVUxb2ZMRUtJRFJYNkR6RG1CSjFYRFcyL3lG?=
 =?utf-8?B?VUh4SWlxaHoveDFNY2d3WE1QQ0dvd1B5SU5vcTVCSytXMkVpYlR2QT09?=
X-Exchange-RoutingPolicyChecked: RPNVc1ZvFPoU9RL3EXP2MxjWzgemC855JOKSRgCD/puuasnHMn1Mrp4jgqacqiEwRxqKjAdK2gX244FvJyqggaFG8Mbj6s1d51g4TTTCHPpe3vm4CYLienN7iBTCaTWl0HIePPvlaSAKX1Oi45CE/U8eoYYDW4ETA9zFvK7R3rjCsoQkK8GYrvkc+cnA0ffFI1zT4CP5Ilw/EkX9iEW6VdlWSNLVZ4G648al6e8ciw8IrUL0CNR05U/Xz6O1ghOHb8cX6dbApf2NeaEZEqjkDoSq8l9CUtbGPQFzSSziRwhU7QKOq6IdXKAyBD24SwnSXP20iOGDl611xas1GIVqUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2830ea-3661-4d13-ece1-08df1775201a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 00:13:12.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+Jl4u30V1Wnt/i6WzsMjs1qkGz1PGlp94M7eiya49rOOFiAffaAu5bzlvucH+MA+V1GrZDzv2ola9smVQeuzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com

On 9/17/26 10:58 PM, Tony Lindgren wrote:
> On Thu, Sep 17, 2026 at 09:32:23PM -0700, Kishen Maloor wrote:
>> On 9/16/26 11:42 PM, Tony Lindgren wrote:
>>> On Wed, Sep 16, 2026 at 08:31:32PM -0700, Kishen Maloor wrote:
>>>> On 9/15/26 10:09 PM, Tony Lindgren wrote:
>>>>> So trying to summarize the common flags for the role and separate vendor
>>>>> flags:
>>>>>
>>>>> struct kvm_migrate_cmd {
>>>>> 	__u16 command;
>>>>> 	__u16 flags;
>>>>> 	__u16 vflags;
>>>>> 	__u16 reserved;
>>>>> 	__u32 reserved;
>>>>> 	struct kvm_transfer_buffer buf;
>>>>> };
>>>>>
>>>>> Is the above along the lines what you were thinking?
>>>>
>>>> No, I was suggesting a 'role' field carved out of the 'reserved' space,
>>>> like this:
>>>>
>>>> struct kvm_migrate_cmd {
>>>>       __u16 command;
>>>>       __u16 flags;
>>>>       __u8  role;     /* 0 = unset, 1 = source, 2 = destination */
>>>>       __u8  reserved[3];
>>>>       struct kvm_transfer_buffer buf;
>>>> };
>>>
>>> OK yes thanks for clarifying, that works for me.
>>>  
>>>>> Ah OK, yes that would also tell "the hardware has been initialized to a
>>>>> certain migration role". That seems like a usable common feature.
>>>>
>>>> Not quite. It tells us that userspace asserted a role for this VM's migration
>>>> session. Whether a TD was created for import is a separate, vendor-level detail.
>>>> The generic layer only needs the role to reject a session that never stated one,
>>>> and to pick the export or import callback. That callback then knows which side
>>>> it's on and can reject an incorrect role (e.g., if SETUP asserted dst for a src TD).
>>>
>>> That's a good point, the hardware role may not be set yet.
>>>
>>> I'm still wondering if there is a need to stash the userspace set role in
>>> KVM though. Likely only the hardware specific code can properly track the
>>> state of the hardware and adjust to the userspace requests. Seems just
>>> being able to pass the role in struct kvm_migrate_cmd should be enough?
>>
>> Passing it in kvm_migrate_cmd is enough for SETUP itself, but the commands
>> after SETUP like memory/vcpu transfers still have to reach the right
>> callback. So KVM would need to remember what was asserted so that the
>> generic layer can dispatch to the export or import facing callbacks.
>> We've been sketching (on this thread) an alternative UAPI set
>> (3 vs 5 ioctls) for consideration which this stored role enables:
>>
>> Proposed in the RFC              Alternative
>> KVM_MIGRATE_CMD                  KVM_MIGRATE_CMD
>> KVM_EXPORT_MEMORY                 
>> KVM_IMPORT_MEMORY                KVM_TRANSFER_MEMORY       
>> KVM_EXPORT_VCPU
>> KVM_IMPORT_VCPU                  KVM_TRANSFER_VCPU
>>
>> It's just a record (1 byte) of what userspace asserted for the current session 
>> at SETUP. Vendor code still owns the hardware state and remains free to reject a 
>> role that doesn't match it. It is also what lets the generic layer reject a 
>> command to a VM that never set up a session.
> 
> For the TRANSFER style operations, I would assume the direction is passed
> for each transfer, just like the Linux does for the dmaengine. It's
> possible that there may be transfers going both directions without the
> role changing.
> 
> So looks like we have tree things to consider: userspace set migration
> role, the hardware state, and transfer direction.

Two of those three I agree with: userspace passes the role at SETUP, and
the vendor implementation tracks the hardware state. It's the per-transfer
direction I don't think we need.

> What if userspace always passes the role and transfer direction where it
> makes sense? And then the hardware specific implementation tracks the
> hardware state?

Unless there's another meaning, direction would indicate that an operation
must produce or consume a blob into/from a buffer. Such an indication would be
necessary if the layer below the API cannot know what to do with a buffer,
which may well be the case in your dmaengine analogy. However, in this case a
vendor implementation sits below the generic layer and could derive what it
needs to do from the role, command, and any session state it maintains. The
TDH.EXPORT.ABORT example I cited upthread expects a token only once the
session has left its pre-copy phase, so what to do with the buffer follows
from state the vendor layer already holds.

The gap I do see is in how the buffer itself is described: we have no way to
express a command that takes an input and produces an output. A direction flag
doesn't help there either, since it can only say one thing. My comments on patch 2
suggest a new 'capacity' field alongside a reframing of 'size' in kvm_transfer_buffer,
where capacity bounds what the kernel may write and size reports what is actually
there. That covers the both-ways case, and it also leaves nothing for a direction
field to convey. Maybe that addresses your concern?
