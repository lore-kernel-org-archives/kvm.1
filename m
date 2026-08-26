Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2B4266A0;
	Wed, 26 Aug 2026 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751375; cv=fail; b=qmtVXW0OZIf2ZJiX58bGykiTZBmqopqnzYkpKTAMsURDzVTJweX9PFK1QWxkttTEdVViqdjO6GhfSZlCsjJQt03C7qEScpMfPD1iJxQnz2BTjIkrjROyOAUpp4x4li5pc5zQCqTE2Bu7gyhxDnibiBCTb3/PfAostwYSak14qWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751375; c=relaxed/simple;
	bh=f81aQANMSjnm1qhe8pnZEdNmvqr+CqI0YeSQhD90OOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ivqFjZyjyp4jP4cvO8ght4E7Ho9N6I+1iPYsRzWru3EEaZDZaxCvPdpWc9r34CzAXSfxfA/M3LX6MvgR70Vl8XF/fK7VKZEx71UF1LtA6BsZYDSqiNsDmFVWctTDb7hDW9P9alq0DP3AqO06lcq5USgWXSiH5Z6QnnqLdrZhYAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBYxtyx+; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBYxtyx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787751372; x=1819287372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f81aQANMSjnm1qhe8pnZEdNmvqr+CqI0YeSQhD90OOc=;
  b=KBYxtyx++22aDWhoXr07FprnZYMOzAZCeP0zR+5Oiqn+skg40cEHP33C
   vvp7uM2onF3BecnHWYL05fdyxaw/Q1zvtRT8RNWJNdbC/cM0PU5wyoHd/
   D3je8l0f5kWLi+b4LTJ/KyFR/B0+Q9la3IdUstUe8VD9AyuY/AEbnYUH9
   ZYnXX+kpfSIwkYWHis7hB4mAX3Xe0yNzcltl0FWxjqJR/IgBG+SF3xa+r
   UB6eqN4BEtr0w0by6wKRW3aLzro2cq9Hfc726J/M7m4Saw5VVcaaO3L71
   bIEkPqQx3mO8r98Des0MnD7oh6D55/6G4pQ6/4FIvWsUXcHiBI2OFp4OL
   g==;
X-CSE-ConnectionGUID: gQFTcxsLSUaqb6c0d7dapw==
X-CSE-MsgGUID: lKPLu7/gT4a3fpowuphcwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99578666"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="99578666"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:36:11 -0700
X-CSE-ConnectionGUID: djhsohK+QlOOnHwjQmEhIg==
X-CSE-MsgGUID: zC2488YRSayV547DrUVcfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="305805907"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:36:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 06:36:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 06:36:10 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 06:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGbR4kuGg3o16CfhOysDzcxuHkVLvAHzF1hYt1b1mGDtR1KIdYjqtlGczYeRqlKsc18+iQ+NDoMu49MEmFwipIgcRhvB7mQ+Y4/sevoRy2e883AEiuNfZE/soKmlKqzTfTqdVdP7UrjLvW4aFDMGR6RejXpVaSEIx4G++fCzoUxbTrPH4xnLswMLTXOWqRrilXCHT+QW35tVETlcAl9GdrLQhWIFYR8EABY4uDbGcqq31Mh48UmX1Nxxjvaz0F+WWmuDjEokLBHdjrL/gwn8wH6hhPFtc0V9KWiGcmveHvcdyaZMBn1x5M0GjysA5aR+AwIAIy2qUu0DdOYX8qy0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f81aQANMSjnm1qhe8pnZEdNmvqr+CqI0YeSQhD90OOc=;
 b=gHABNJ2lJco4H01zubLuEYgdZQevBpX+odQWXOKomhbzoeBNjqTXQN1gacDd/nHQIVpnLtqjgiHlORFgrBzZZAUMM19CvwL23iQCXO0gn3Kzb00pMHX4wlrFXEMxcZhGEzC61AP9zwXS1SG84TUmYuDH8eSi9mTwFn966JNYkyVYmEL6XqmGjcKW1t2LlezFSeki5j32TdA21P2YLqdqhrA4KdLUJCGoFzDBwsPWY9DybGiOHDXfV6eELEHcvz3I4LHZE/hCsUJWxx7IZ6ed6+kBQddaNXZIzzBadedYl8Q3+CFz1z9cwzTM3SLNNCMJtdtjC4T7xXBr6MC0FUEjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV3PR11MB8577.namprd11.prod.outlook.com (2603:10b6:408:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 13:36:03 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 13:36:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "sagis@google.com"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Topic: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Index: AQHdND1FpRR2p2rutEOa7iAk6ZY7/rauw4GAgAEreICAAGHigIAABlWA
Date: Wed, 26 Aug 2026 13:36:03 +0000
Message-ID: <26df3b906110c060d996ae8e79c4c1857f16f187.camel@intel.com>
References: <20260825025533.25663-1-yan.y.zhao@intel.com>
	 <ao2ZH8dmkPfBDnGv@google.com> <ao6UVdWNbhQaAFsm@yzhao56-desk.sh.intel.com>
	 <1e77b1f6-0491-464b-b79f-ca756a73e7ea@intel.com>
In-Reply-To: <1e77b1f6-0491-464b-b79f-ca756a73e7ea@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV3PR11MB8577:EE_
x-ms-office365-filtering-correlation-id: 6ed5d042-e791-4c1b-a3d3-08df0376f93d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|38070700021|10067099003|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003|10063799003;
x-microsoft-antispam-message-info: 3EBbgcetAMdqPZWauwxKyeHRXVz3oAj7AzA1bF/A62RFc3hAp1vD9GUQovBimiaR1xrad1vB6S8prhct1OJt4gLufNkAxzvuafvlM1eHB5p7gKicJPHRPXOlfygjrNsIhHs+oSkPode21CiF+nd1vY7OOfyuxNfDZ9/h/BHUyyn/V3JsCAH+AfUjfYUyQV/bnFlcGpB+r3r6JF90em7tWJHbx7E+/7/bFFcxhBjIEtkwz/ZbykSXFtMl8RLCq1u2IBkc9Py21I6Gv5ShgDYJzYW2tkSy+hHo5gpaBo/vlYTvATLBVUdkz5iO1dl80LvbydivKCJS0ufa5PmaIwEZTKMqNCbRGLT0vY70UlJCL0SSleNqFKTToR/uiQ+YJ+DNoI0/jiFk98qHqOR8KMqjmlTEhPlBIC267EQZ/Ysm3czJ8Meof3ehRdzJCyhIycgeKlqwQkLXNMG/+zNVkwnjo4wn/G4GqwW14nplOJRYX68ZQoVCDHrHyDZqgqD8hcnl+z0IhbQB+sirFIFk7kUPdZyoV8Zbgb+MIvBxwlh0BRqYl1cCk/8fwiX6EXEnHF2apBVYt7i3mttkjwmWwFb8lH2ZDT2fYTSsQNdbLo8To1SQ2sRsIjHnFWzr9lxdeTtIcp+RBwqWqsjk5pNfeFT2nJOsImPCeYkNmh2Su2sHU+FmgGRmZsgjdmSoXxrxYUPpx74ooZgFs6lPau+mwFNWtbXxYfVdKwVEwlfUskJj0S0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(10063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk9ZcnIvMTlMZ0pxZTJVU3V0cFAwQWVKRGczVnhxcWc4Uy91MTlpZHJkR0Rx?=
 =?utf-8?B?ZWdwOXRpRE1SUm40UG1VaUNkVUlIbzFOd0YvYzNuYVdHNlA1L2V6dk92ZWE4?=
 =?utf-8?B?NXVKZ3BMWWIrandTSE5WeHUwc3hZcEFYZXM5aUlvUUQ5dUc5eFJPWWUvUUFz?=
 =?utf-8?B?cDgzYytxQ2tHbWY4Z0ZENW50aHowUDZSUTJyR2t4N0l6OVVvUFZ6dFplTERl?=
 =?utf-8?B?VG1rNWJRTmxMNUVtRDYzelE3QTF5Z1N6cC9pWlhZeU5YRGVacGVoVExpMTRZ?=
 =?utf-8?B?SkJibnZaYWpqdHdsQ0NZUDNjcm5iRUpYYWtxMmF5RGJzL1A4eG9PRmhGanZl?=
 =?utf-8?B?bnNOL1JDMzZLamhSRVdXZklpRUUrajVnR2VGNmViRFVZOWpPR0x0WDlBcU9y?=
 =?utf-8?B?SmI2cHdjWkN0SGoyNmNLMmVTTFFGTGJQS1lic1ZuVE1RWE9vOEJjcy9acHhr?=
 =?utf-8?B?ejVMNS9vUVhpcjVGblB5WmNBd09sZDMrQWwrYlFZbFhqcTJLL2JQNG1yN1VD?=
 =?utf-8?B?ZmdkV1p2N3JLRTNHU09VUXl4NCtoY2Z6K2drK2ZHZVFwTWdQbDJFSTh0RUlY?=
 =?utf-8?B?U0dQazNuTS90ZW1wajNTd2NOZnV3c0ZyalFhYzlUY3pyc1NlWHBqaVdBQnRs?=
 =?utf-8?B?bGVYZzZoRVBZS1Qzc1JwWHdqTDF3b0JCaVVqWEc1Z0k5MS8wRjhpZDJBQUM3?=
 =?utf-8?B?dmxkT1JuRjNjdlVrZEFKR2djaWoxd1VsS1NPUDNkZnVVak16dzdpL3BMWlB6?=
 =?utf-8?B?eUhOaGtOb2ZBMGJ1d1dzVWJONUhIYXlVRy93aC8vQTNwK0FuN2QzR0o4NmRU?=
 =?utf-8?B?WHh3VUxzYVU5U0dra0RFU0J0UEUySENxUWRxTkVxV2EwdGt4WkgzZlYyYWxW?=
 =?utf-8?B?emFUQU9PWEJhZTZmUHp0Vm4vam5xTG9uREtMYVZKVWhzK28yWXRMSjlCTDRU?=
 =?utf-8?B?SjRPWFArRHpZdGRXU1VNNUdGc2orS2pYZ1BLRFJ3UHdUclIrcnV4YXdJc1Rs?=
 =?utf-8?B?Z0VWVk14dElNUHU5aTk3T1FxVDdwa0dvY05mVUsrclpmVFY1L2F2bG5yNHpr?=
 =?utf-8?B?MUEwUXlEc2p6Q0t0ZUR6MDhMSDZTc05IbU9TZU9ZcHR1c2dsajhIVDk2S0Q0?=
 =?utf-8?B?aGF5UEJLZkVRV1ZLWEZuWTZhUm9wdFptcGJnYThINllwN0J3ZHFwOURHejJW?=
 =?utf-8?B?ekhYOG1Vc0MxUzF3aHlIek8renNheFlrWHN2T0NMazBhQm1zVk5BUGdJd2tv?=
 =?utf-8?B?Mk8xb1pSd0NhaWJBM1FhQlFUV3l4b0JlYUEzaXV6RXZUV095c3czbzNXcEYz?=
 =?utf-8?B?cDFSYWttSjRxNndFdFRwTGMvbzVmczJHOWU1RXRPSncvZVh5eDl5bXBEcDJu?=
 =?utf-8?B?QkhIN05ONUhIT1FyVXBxZjhNMWh3NlprcTRoK3ZTM0tTWWVNL3dXelkyMkZw?=
 =?utf-8?B?YU9ZQk1xVEZQSGlqOUNXZmtUcUZlNUwwOGdKMDdkajYxeHV2WUZ4dTJVU1E5?=
 =?utf-8?B?S28zK3cxMWNkd3o4L0dCaHdvc2dMODIvbW12MDFhakVocFh6Q21xNnVGbC9j?=
 =?utf-8?B?aG1wb29oU1pUc2xlQ01YL3VTTlVDb0sxanV1RDZFeVNwUEY0VFVtM1Z4MVA3?=
 =?utf-8?B?ZXpMV2RPS21mK2J5Z1Y1RkR1WG82ZDVwcDZtajJKK0xLOUltVG1TQUZGNllC?=
 =?utf-8?B?RllIdjZhaUpmNWJZaHI2MGRHN3lKUjByd0tqL0FNcHZTanJ1bGFISVFMUzFC?=
 =?utf-8?B?eHB2ZjFWOXRhTjBJTzdRM20vSWhjVzdKZzJ6VGFhUHdXRGcxM2hUV0s3ZzdH?=
 =?utf-8?B?bEVsR1FpSmtQTDRlc2E4ZDZjZ2JaRWo3TUdjZExlWXlwYnUwNnRYb3BrM3Fi?=
 =?utf-8?B?OFZucEVNTE5tOVo1KzJ4QjVvWnA1S3k1WVpqR2dMUjdEdTE2QTJPdDVSb2th?=
 =?utf-8?B?ZDBjUGpQN1BpTHFmMENWeDVCbWhGUGJhN3lockJQM0crUzB1Q3lDT2lwemZq?=
 =?utf-8?B?bzg3OTFMMmJ5Q1orbmszcUNwTXVJbThlNGJ5NkRTQkt5R2M1RnAvMmlFV2k0?=
 =?utf-8?B?V3ZsekdweEpKWXBpZHczQTlDRDBPWnhUcC83cDBkVHFRVjlsaGV4Y1NEQjFC?=
 =?utf-8?B?UG5JbEtZdHJHQmwxci8wc29UdVRYUlhYTFRyZy9BTTgrelZnTGZubmQ3MVYr?=
 =?utf-8?B?Q2QzWms2Q1BIRzFWREpjYnAwVm9xRHF4bWMyY3VTZGlsTktHcDV1bmVRdFJm?=
 =?utf-8?B?c3EyTjRqWmV2dXVwWGMvKzhOQXZtV2hYNzIvYkt0WnBlazF1bm9jemUxcGN5?=
 =?utf-8?B?aERJK1NIb3JqcHIvTXhFVWpxOGZLTW0rUVR4ZkNOa1dLaUV2ZUdOaUNGVGRN?=
 =?utf-8?Q?xBYLCS+ZGADqPjMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7930DC22118B7842A95EC4C4AC2B2B5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0fG9Ryz6M73i8GzrnGvMW2HieGhYtWN0V5SEpmbByA983g08FQZTfcYs1617mbyHYHBzaERLDY94I98WOJwaoWihmT1koBkbje7ah23hK/qTNjAbrPtHkeaRskzuU8TiNGStHCFWABWXbCQ9ejRJFK6HJ5vAMbiI6QyRlzlaaDOUzz8GjsEPa9+CrdoXIyGHGAQTdr6VEpmTAvjn7NC2ln/lDdyWWCJSerd37JnDOPA3fQp6w1rcViudHJOAhaiykDnDqEDgR4+4gtxgYqSR1i2qjWNTJnXQj7rZhQDbJoPTKt2INhvHybnFL5dOxtTucF6bHW2mMPA2cqqtR8fGfw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed5d042-e791-4c1b-a3d3-08df0376f93d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 13:36:03.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcT54Yv2nxSDPVZHx7oFVL/aqwvwNLVpySLNs2Qvlx7OoMVwCC+CYRtxEkLpbBEXVzecfAb+fPk+yLzXXs++8nJQzg65AzgK89wjT4tWaYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8577
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDA2OjEzIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOC8yNi8yNiAwMDoyMywgWWFuIFpoYW8gd3JvdGU6DQo+ID4gRG8gbm90IGV4dGVuZCB0aGUg
Q0xGTFVTSCBjb3ZlcmFnZSB0byBtYWtlIHRkaF9tZW1fcGFnZV9hdWcoKSB3b3JrIHdpdGgNCj4g
PiBodWdlIHBhZ2VzLiBOb3Qgb25seSB3b3VsZCB0aGlzIHNjYXR0ZXIgaHVnZSBwYWdlIHJlbGF0
ZWQgY2hhbmdlcyBhY3Jvc3MNCj4gPiBtdWx0aXBsZSBzZXJpZXMsIGJ1dCBpdCBhbHNvIG1ha2Vz
IGxpdHRsZSBzZW5zZSB0byBoYXZlIHRkaF9tZW1fcGFnZV9hdWcoKQ0KPiA+IGFsb25lIHdvcmsg
Zm9yIGh1Z2UgcGFnZXMgd2l0aG91dCBpbXBsZW1lbnRpbmcgaXRzIGNvdW50ZXJwYXJ0cyBpbiB0
aGUNCj4gPiB1bm1hcHBpbmcgYW5kIHNwbGl0dGluZyBwYXRocy4NCj4gDQo+IEZvciBtZSwgaXQn
cyBhbGwgYWJvdXQgc2ltcGxpY2l0eS4gSXQncyBiYWQgdG8gYWRkICpjb21wbGV4aXR5KiBmb3IN
Cj4gZnV0dXJlIGZ1bmN0aW9uYWxpdHkgYmVjYXVzZSBpdCBtaWdodCBub3QgZXZlciBnZXQgdXNl
ZC4gQnV0IGluIHRoaXMNCj4gY2FzZSwgdGhlIChTZWFuLXN1Z2dlc3RlZCkgY2hhbmdlIGlzIHBy
ZXR0eSBzaW1wbGUuIEl0J3MgbW9yZQ0KPiBjb21wbGljYXRlZCB0byAqbm90KiBmaXggdGhlIGJ1
ZyBhbmQgKmV4cGxhaW4qIHdoeSBpdCdzIG5vdCBiZWluZyBmaXhlZA0KPiB0aGFuIHRvIGp1c3Qg
Zml4IHRoZSBkYW5nIHRoaW5nLg0KDQpXZSBhcmUgd2FpdGluZyBmb3Igc29tZSBmaW5hbCBjb25m
aXJtYXRpb24gdGhhdCB0aGUgVERYIG1vZHVsZSB3aWxsIG5ldmVyIHNldA0KQ0xGTFVTSF9CRUZP
UkVfQUxMT0MuIEFuZCB0aGF0IG1lYW5zIGFsbCB0aGUgY2xmbHVzaGluZyBpcyBub3QgbmVlZGVk
LiBTbyBJDQp3b3VsZCBwcm9iYWJseSBzaG9ydGx5ICh3ZWVrcykgc2VuZCBhIHBhdGNoIHRvIHJp
cCBvdXQgYW55IGV4dHJhIGZsdXNoaW5nIGFkZGVkDQphbG9uZyB3aXRoIHRoZSByZXN0IG9mIGl0
Lg0KDQpJIHRoaW5rIGFub3RoZXIgdmFsaWQgY291cnNlIG9mIGFjdGlvbiBoZXJlIGlzIHRvIGRv
IG5vdGhpbmcgZm9yIG5vdy4NCg==
