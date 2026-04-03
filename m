Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C436E498;
	Fri,  3 Apr 2026 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244619; cv=fail; b=AfyUUrIAHTQFnIJB5AQxE/VvS3NfMPlYLVIfB05iadcfeumUaEUyrvIgiYvtxcbsFDYiIL8cnQt9Mh9TyRByvLkEq+I32YOfAAhN4co6o6QVT15P6lCrPloH/yq3ej2zaO764CwMImufC5OR5MFsyLRiGNMFScTACKQG3BGxXvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244619; c=relaxed/simple;
	bh=2zQK5926ZaCJI0xEUs4RA/d02gVJrUePTK8jIiJIj9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMA54nlaWQebCtaIVQDtcCQBK/zihRGkoBvb0k8jw6edeAR13WoF5AeEGvTKZfOAV/tRdlFEVgINjSySzSrktXrilxtFPe0wSwGtJrQYbRdI9au8RnnYh0oND679SddvKaNL/AT4Xdo0+ckYvzIl4sq38HSs/cuZJno/K8Lzq1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6AQdMnq; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6AQdMnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775244618; x=1806780618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2zQK5926ZaCJI0xEUs4RA/d02gVJrUePTK8jIiJIj9w=;
  b=L6AQdMnqD96BowhOXcYKUZ+BkOyTouTV7JpOR+AiZHLIRSeElrjkRYcM
   eAebjysbsVimWNE2F5zIHjLBtpQondLc5sRSz/l+MmZysKxBn7WdfJPNt
   gVouSQjm9JRlg+BtpqPPRL3fV66TNBB5FcYSD+Qu/Xsg1RLQ28aSiHpO7
   N/5QfR+vNzF49Iu33TeMoUg+akG/9fmLrSWuHA+qMzCIDY4wwxy0a+/uN
   G+Rx4W+XMB7ALETv5UVO6jgI5kgdCzQ4llbMGPqQfMnLsHNPjmXeG3S0W
   mmtPyuZl95cslhSIi9+SHXDaoCkCvTRh2hoPB0ylnER6VBBPrCkyiHHUz
   A==;
X-CSE-ConnectionGUID: 3LsSGRGYTvuIg7G/ciTyvQ==
X-CSE-MsgGUID: bXpBuVd0S1q+QvOVqkGQUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="79912224"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="79912224"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:30:17 -0700
X-CSE-ConnectionGUID: ET9fEruFSGeUh91rmeHzUg==
X-CSE-MsgGUID: IQYN1SN1Q0yl3Etw9XMPcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="228952694"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:30:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:30:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 12:30:16 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:30:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnzCQWpJPPd+3uZySZ/36lnoWdUKTInLokXEVYTSBF3a+r0NWPLuBTUmPyqeTVAdOj4XPeiVagFJ6QACQWIT+4LcV2jo9oIMr1E2FnAICtW6h+H0OU2NAgboE3r4lTu7voLCr2OBrx1a4YsREG5wY4NR7wgmPMQOissCpw2nveOdqcun1HmelJ511m7L482gC+V+TjIrfw1pZGS+pRFmzjijIGbZcApGcRu+EORg+fk63fo+jfVeeB6wkNeZ7WpgLQVT/r9Pu3nmqMgbr6wux+9ZS39nhGT3CAg5HpBDxSGC/TOiRrwNrDI4qS6aFtjIXcTtVVVxh6MgmEvp1LjYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zQK5926ZaCJI0xEUs4RA/d02gVJrUePTK8jIiJIj9w=;
 b=W4no9CbbaXmg807dj1BQM3SYIQAPQzKKHsQvdVHrCrGZOOUThDZatxR4C34vz5eUCF4OKZmi/88fWKTwv6KwTXIp4vQzaSe4jH0DZcZBt0h+/U7BPTq0b751oKIGnlGeYEB7IPnR7ghyMrtX7fSCVuKJZEUbZzX5XGkMPhopmN0+7Pxdvw8uEbS8F5Vf5wD9YgVbqkCiZXy7g8mp2Dpx8ShR9YY0zlyI2ZEDZD0nUt81jjnbMmCVxzw54vvd/cT0RNViRbFlkGfp+qB9gwoTGRNQsr9GZGgBjloZRahcDh/ka2dPPBqnYq11lNSvaFJEVwAxaVUo7JCFbzRpZFz7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB8176.namprd11.prod.outlook.com (2603:10b6:208:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 19:30:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 19:30:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dmaluka@chromium.org" <dmaluka@chromium.org>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Topic: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Index: AQHctwnFo9ayO2gQokudL8i/bTewfbW0sMWAgABcswCAAAmDAIAAYmaAgADG/ICAF2AAgIAAJEgAgAAHn4CAAAY9gA==
Date: Fri, 3 Apr 2026 19:30:13 +0000
Message-ID: <ec581571ab4141ed77e6979b3e03773e301a62c1.camel@intel.com>
References: <20260318190111.1041924-1-dmaluka@chromium.org>
	 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
	 <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
	 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com>
	 <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
	 <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
	 <ac_rNT69TdocrMYc@google.com>
	 <401db97a254b356ad8539a5d637d68ee826179a5.camel@intel.com>
	 <adAQCXI-7Yj0wcKA@google.com>
In-Reply-To: <adAQCXI-7Yj0wcKA@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB8176:EE_
x-ms-office365-filtering-correlation-id: a2c99a95-d8d2-4afd-f02c-08de91b76da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: uCd2FtzAWwsjI8A+gwohdk7Hmj7AluNyoW4zSdrEhPFv8CRjr7BpDs1uaj0NO73+x1sNR59kCwYhf1tOT/ph0EVQbRN9IZbgAjygz+wC1OhD+kIA6nFCysUtiv7BomqW0dJVvMK+dxP3pSNcq8CvOAdq6ATaG2qVPoIY0mu/2+uB1Cm13KG8IX3jo8ARE7A/M8qkjNlMvxiq+c3JEybsLRjdc0JfD5nQo0XJYsFpkWHEef/KH1yVWDqXO3sy1sgCT/Zp1V76+nerdUW2QoEuH4QGehVb5Vdo8GnvKhSy6H1NoZuOv8ckPEvKM57ynM+IFWWi3/ltKXT/Z65NP2WPFJ9LBU6xanhvyQ9FlEtxJX3U9a4eNVTa6KvZcJT8BkGEC8QhXVh+ENmEVaMtRmlcLcJGTTC5QNwgFtCdcKY0JpqprARuwBrmkxV0wmuHoDt9rryOgOhF7Ju/7heshWxVUI2zuWY0vNWdrK5kbLnmN3p9urd22r4Y7et8gfA4dhSyAx1v7hU2gXid6yTBM+DmDen2rBGNC95j/1PMVb9rS0m1KqLTug/HH1bWO76v61IAx0QMFrFFd1OXoTXLuL9th065SDBC4F4/ZcxIKopOoN5NNkxly4h8dBFuUOLG6NpBHayZ9SenoG6PPx2KBfy8wtfvk7QQyUOp7m0089eZU+65jrn2QymogV1+dRoqTEfQJ5ESHWQIEPQ14dc3I25LZg/+OdUKvP0qnCaXVcya5Yy1Vzw/HSff5TUioHWTvsC+DfiGmTcLW0OWIy0Z6ZpKg36hbDCr0vvI4+gRydE7Kzw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3phaFViYUlSNnh4d0RycFB6djlFWG50L0dJT3NzNmFxSU4zWkZZR3ZJd3M0?=
 =?utf-8?B?ZlBZdm1lMlhQaHova3QrNkZ2ajk2WVhtbGZVTmNsbTc1aUxOMEVHVlk3QldR?=
 =?utf-8?B?S1M1aVBlSCt5c3gyYXRYV0thU2hTVEZmcHhIVFBnamFyUGp1MXFVSkdZTC9s?=
 =?utf-8?B?TWJxVmFSS2g4cnpER3QwR2tTNXdGK0FUMDJsK3RxR3UzdkJUcXZ0VnVhWTEr?=
 =?utf-8?B?d3BOTXUrYUhGRnM4Q1ozRnF1R0VoSUJmWFk2TmVvSlRVcWMvNmhYNDZGemxh?=
 =?utf-8?B?YTBSc2tFaC9zQTc1U1ZjTWJLZG9SdHVxRHNwYWpDTnNnQXdDckRDaEIrd1Zo?=
 =?utf-8?B?TFlYWnVMMFEzN2lBVHpleGNhdXdHSUg1eDg5RUg5L09LVk1GaWl2MmpVdm9m?=
 =?utf-8?B?VXd6MERIU3lORVUyODlJaENzY0FjNWlQRlpvdUR1NzJRZGlQMzJ5d0RuUjZu?=
 =?utf-8?B?UmkzTzk3R2NmQjNGWVNnMUc1S1M4L1R1N1hqZEJMZ2MwQXdyT3FTVnJkQ21h?=
 =?utf-8?B?MWZkbkxOWWx1T1FtZWJtRzRaVTA4czhGeWE0SC9pVG9PdXViTHhiS2czWVRO?=
 =?utf-8?B?S1ZUQ3BCODVWbE0yd21SMU1LeElHNnd0TW1PZEw2L0puWG1rVHJqaEpxUE5R?=
 =?utf-8?B?RU9LTzlZcEVzODBOYzFFbXZla25YUVZTK3duS3RjSmszRDdQZ0RCR1hERHVY?=
 =?utf-8?B?eWlZK0lHYXYrZlcrNzNsd2ZZY3V3em9KL2xnNkRXV1dvUWRkWXUrS0QydVg0?=
 =?utf-8?B?b0ZEUStpall2bEFZTmdUSlRpKzJsZ1pNK1UvNHdXV0p2ajZIbmpaOFhjd2Vn?=
 =?utf-8?B?eitjTzlSSFJjMmg5OEtjalNQTU1IWkRDZFJ1QXd3bktZc3VwM2h6QTdkTk5E?=
 =?utf-8?B?dHh4NVFWNncwdythNUwyOWVmUjlMMmhBN0VXNk0wSVpsQlFjUDdFR0M1aXlS?=
 =?utf-8?B?T1VoK2h1V3BPUHFTN2thN2JJM09SV2xBbDlXSnJyQUJ0SThwN0JPaHo1c2do?=
 =?utf-8?B?djIyNXhWSmgwdFRoZDFhdEpmTEIzRERubnpPOW9qUlUrWnhMKzZzSUhGNVZ6?=
 =?utf-8?B?NTRYV3JiWGFlaHJhT3RYNUlXbGx6YTREV0R4WTg1bjNmbWhhMVY2am9XWDl4?=
 =?utf-8?B?UFpXMjVwTExJdUZGOHlwb0RHSHFmM2hCZ0xNVWp3T3pqbnBYL05mNVpPc1Ry?=
 =?utf-8?B?eVZjMHUraG84V2E5WGhpdjBYUlFWdWk4VURGNUt1RHBoNGI4L1dZNWV1dk5s?=
 =?utf-8?B?MlZQOWt1dTdLOU9YWHBPVy9JYUNjUFNZZzNocnc1WkpHQVJIbVFKSEl5Nk9T?=
 =?utf-8?B?NkkrSTFTL1dYOEZhUFViNk1POXhmY0crd3drWkRKbjlpVVg1MWVHdzFYY2xV?=
 =?utf-8?B?NWlOQ2xwY1JwYU1CTGloSlR4ZGh4VGpSZVRmcWRKZ2NHb2xxb3BrWVBYeGtn?=
 =?utf-8?B?NzNZeXQ5ZXVvbCtVakFPVnlDMCs1N2pNSmZhNStWL3l2R21mR3NPby81SU1k?=
 =?utf-8?B?WGRjODdGbGhpQStweFRHNUxsaHJSQjBvYWlGczV3NzRaVHJiZm1nWUd0eGpl?=
 =?utf-8?B?cXppY0VVLzVEa2dZcFZCZnN6aXJYODl2R3FDMDRNYmtlOXVKb1l2YkpETDZQ?=
 =?utf-8?B?WTBhbElsWktxYXVrb1dVUENlMTV6eVZqK3g1RXVsRFZ2VDZZclk5cFl4eG1y?=
 =?utf-8?B?UEluN0lxVlpqVXV4VHAwZWdhUmVyYmZCTDdjWmpOL0RlNG0rM1ZCZ0NneTlF?=
 =?utf-8?B?cGJoODVPaDNyWk8yRUtpcjJGM2M1K0c4WHh5R2xOaE5aa3JpU1RRaGcrdVFK?=
 =?utf-8?B?ZHpRNkNHVng3OXRvd1NoZ1R4OGpoV3RGVmprZWhCZ2thUEZodHErSkZmei94?=
 =?utf-8?B?eEV4eDQvT0RINUtJeStid2J6ekVoaTJyODk1VG5WdG1McWdkMDFCOW1RT0gw?=
 =?utf-8?B?YXJqdmxUUzFISXl0TGlLVitWanE4RnNGcitwUldyckJYSnMwMFh1b3RpVWlS?=
 =?utf-8?B?YjNCUktiVmtjY3VCd05qYURGd2dMRlkvaTA5NXFZVFVpQUtqL05UdmNQUVpG?=
 =?utf-8?B?RXFkM0ltV0tDejBqcTFSTkZndUVYUUV1Y3lWRG9YaXBtYVF5QW5QQ1NCaUJH?=
 =?utf-8?B?ckJRNkJMaXlSL0IvWjFSSGErWTI1MlJmcEd3Qi9XanRSdTVVSjAzbWwxUzZR?=
 =?utf-8?B?bEhWT1Q3cUpwUzBpV0R5elVLUUl5VVhPSitMaU9uVVYxTWRtUmgzZ0R5aGpD?=
 =?utf-8?B?cGtLZHZvSDFUY3N0SmRuVElmMVhHTktmajR1ZnoyY1NWYzhrZ3VLQWMxdEgz?=
 =?utf-8?B?VXJld2o0Y05MQ1cxRTIyS2lna3p5Rld0djErdDdjYitNdXArd0tjZkhvdjdv?=
 =?utf-8?Q?GlIcBDl9C4hQzBdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F8FD25B312D6C4E9933061CFE6B9FFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y+7TUxey7uhgybsxS7xzD4CGJ8jVtlTnJxY57MEkzl9hG3cNp00AXMOslF4aaSK3Vzi+2ahepqMseiSga5d5zmuMEjnOysyROKVPxbgFsmz8fpq4fcbALtax+TqkO4NNUPj3HvK2pypIZ3WXXRH10HkcejQWjtfi9lu+MF0PtbBv3emDJaTSuulXAfKeGklgv/74hsa5BYzCQP5i9azSkyO+eGvhmVWHF8/8S8KRYsMVk0dspdCq50wLeL0jBiBvbX9cGz8glfIymKAHMom18eREkHJHO36vdGZ9DQXwy3JrCc5TdtGMPtSW0l37tjjaog93pk3zxAqtBhiI0c0nwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c99a95-d8d2-4afd-f02c-08de91b76da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 19:30:13.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnF8+hQAf0r9luDwcbqk+mijk2KwRVAYElb42TQgjrTaKem684ur4k/FIRaGDFn/0x36CJVZiQrV6taSl3O27N+RaQJ3pZd1GIf2HB8sOgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8176
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTAzIGF0IDEyOjA3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+ID4gTm8/wqAgRG9uJ3Qgd2UganVzdCB3YW50IHRvIGFsbG93IGFjY2VzcyB0byBN
U1JzIHRoYXQgYXJlbid0IGFjY2VsZXJhdGVkP8KgDQo+ID4gPiBXaGF0IHRoZSBURFgtTW9kdWxl
IHN1cHBvcnRzIGlzIGxhcmdlbHkgaXJyZWxldmFudCwgSSB0aGluay4NCj4gPiANCj4gPiBOb3Qg
c3VyZSBpZiBJIG1pZ2h0IGJlIG1pc3NpbmcgdGhlIHBvaW50IGhlcmUuIEFzIGFib3ZlLCB3ZSBk
b24ndCBoYXZlDQo+ID4gZW5vdWdoIGluZm8gdG/CoGtub3cgd2hpY2ggTVNScyBhcmUgYWNjZWxl
cmF0ZWQuIElmIHRoZSBndWVzdCBlbmFibGVkICNWRQ0KPiA+IHJlZHVjdGlvbiwgaXQgY2hhbmdl
cyB3aGljaCBvbmVzIGFyZSBhY2NlbGVyYXRlZCBhbmQgdGhlIFZNTSBpcyBub3QNCj4gPiBub3Rp
ZmllZC4NCj4gDQo+IFdoYXQgZG9lcyB0aGUgImFjY2xlcmF0aW9uIiBpbiB0aGF0IGNhc2U/wqAg
T3IgZG9lcyBpdCByZWR1Y2Ugd2hpY2ggb25lcyBhcmUNCj4gYWNjZWxlcmF0ZWQ/DQoNCkkgbWVh
biBvbmVzIHdoZXJlIHdybXNyIGlzIGhhbmRsZWQgYnkgdGhlIFREWCBtb2R1bGUgaW5zdGVhZCBv
ZiBnZW5lcmF0aW5nIGEgI1ZFDQp0aGF0IGdldHMgbW9ycGhlZCBpbnRvIFREVk1DQUxMIGJ5IHRo
ZSBndWVzdC4gQWN0dWFsbHkgdXN1YWxseSBjYWxsZWQgIm5hdGl2ZSIsDQpidXQgSSBqdXN0IHJl
dXNlZCB5b3VyICJhY2NlbGVyYXRlZCIgdGVybSBmcm9tIHRoZSBtYWlsLg0KDQpTby4uLiAiUmVk
dWNlZCAjVkUiIChhbHNvIGNhbGxlZCAiVkUgcmVkdWN0aW9uIikgcmVkdWNlcyB3aGljaCB0aGlu
Z3MgY2F1c2UgYQ0KI1ZFLiBUaGUgZ3Vlc3Qgb3B0cyBpbnRvIGl0IGFuZCB0aGUgVERYIG1vZHVs
ZSBzdGFydHMgYmVoYXZpbmcgZGlmZmVyZW50bHkuIEl0J3MNCmtpbmQgb2YgZ3JhYiBiYWcgb2Yg
Y2hhbmdlcyBpbmNsdWRpbmcgY2hhbmdpbmcgQ1BVSUQgYmVoYXZpb3IsIHdoaWNoIGlzIGFub3Ro
ZXINCndyaW5rbGUuIEl0IHdhcyBpbnRlbmRlZCB0byBmaXh1cCBndWVzdCBzaWRlIFREWCBhcmNo
IGlzc3Vlcy4NCg==
