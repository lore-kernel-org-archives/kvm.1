Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630001A2C0B;
	Sat, 11 Apr 2026 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867634; cv=fail; b=fTACOVMkg6eNO7RyfJ48dvJyWebwWcnrbodXGBAjM9ImqttecTOe61kvH591Q3V8b+1/YNKyQ9dR0HlmvsHdu4WdKQLvt52pGFoI1QpVuaWac9iPYZWhCVEm1+frC7iXnZPYAXtYkgUD5bk3f8ojrziNFHN7mZ7fw304adHgJfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867634; c=relaxed/simple;
	bh=GmhC1oXo9+ASU07fHNxFwnn+OX8i2fNbqgGB8zHTh8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IM4srn2vdnbYbEDbXjHz7K71z2m/bHfN4qcFC55nph+Fsz5cIR4OoWRnv9OCixlNuI3zljcvAlj4ZU/mAidqFePBbkQ93VtBNKz6StXPZb1alRQmDObwcskhHI31zrSZSUuHFLmU2+63906vySgpZptAyvw+gsH34KibP2vf5vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRdILLAB; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRdILLAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775867634; x=1807403634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GmhC1oXo9+ASU07fHNxFwnn+OX8i2fNbqgGB8zHTh8o=;
  b=RRdILLAB0PiDYEn6eRA75RmKxXJqFRsOP1FXaAVBt8FXRDscm95qpzWY
   u2/e5Dq9BO9TVTh1DUND5o0KGkJl//y4jB2Tp0QjXCCkp2L9ah4Dxf581
   dhG/bzh1pHOZ+uB9KytL6eeQQikRcr2Bwgw5chvOJsb6becVxW5iZBQJS
   PrIhGL0Ml66n+N4KQmD84YFewJ5vusM0b8s/YRgnPsfEtwlEs/OuvV23x
   PabVZx4t9PO+3OVwm5gy/ROoQnUXCpZlAOOmOar+yCknt38FVH1yl7MFl
   eyTvGfQCAuiiT/lVMZz8GlfkbcHmp6J1jz5MiRBL9IHHfP6zXVNrQtFty
   A==;
X-CSE-ConnectionGUID: vLecYxVUSJCFYZM5pGkJwA==
X-CSE-MsgGUID: rY9AboZMRGK700+xuPehRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="94468124"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="94468124"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:33:53 -0700
X-CSE-ConnectionGUID: /KknN7AuQHKkzfc+qCVPTw==
X-CSE-MsgGUID: hrcnRdi7RTWU/fKxxqD36A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="234169652"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:33:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 17:33:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 17:33:51 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 17:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avaa9uJokdHLnc+NbvadzT8RiS3P+D7oVvNWaC7y+IBR09GqXdDOrgKbxuF51wa2EyvnKxHMGIJwxP3rIDJsh8N63IfsgaBmgRuPzyuyx3dDiqQDtRnceTj74JjUiNo/V/F5ZzL41Gsr2M3oNE9qc8xt2VxqztG0ZYZSYDEWtNrx345YWMRT4Q8AszGr7w0EfV42X76hM32u0vI0jN/Yc2eKO5LnY7XYw3gn6B9OkKRDBYEFbl2/OoyDLQqn7UYH3Pcafin46wk0CbaThkI4nnXZqeD9imzEpHAiosUgKIfpdSTSpDaou80pIR2jPi7IX4hWz2s01DmAyejSMQ/uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmhC1oXo9+ASU07fHNxFwnn+OX8i2fNbqgGB8zHTh8o=;
 b=WbDEvaHn0Cfcx6HExNX4yGDtu/jAagX0gtRC/L8GgtTwbgtfhZ0Zq7AxwX8wBqSwBnULQ+Y+b2jck+XLVRzy/thIlKBtkUFiUL50KVWeWcOVMQpPOoaz3ucExo5f8r7QNYFDVuI7O1kYjIRM4I9qdOCt1n9dLLYAU8FlFSrguadiPYQ6pKgYlG3ZPTJ4p9eZ1Vj331AEFCxnJbm7oMZWABuOYG9gZmxTyllld50KbEpXtAZAdoCeYFSGiWuJB7bbNR/UxRvFCuefixrRYYouTpYFFMNaFPFXNrkt3DkIl3eAJrq4fPTy+beX/d4aFkUosAFQiF9Ktmvvk8uGLH6fSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA4PR11MB9107.namprd11.prod.outlook.com (2603:10b6:208:562::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Sat, 11 Apr
 2026 00:33:41 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 00:33:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"sagis@google.com" <sagis@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 08/22] x86/virt/seamldr: Allocate and populate a module
 update request
Thread-Topic: [PATCH v7 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Thread-Index: AQHcwQv/4R8odDpJ1EmXBBfIkPnQIrXIyHUAgAEYLgCADzLzgA==
Date: Sat, 11 Apr 2026 00:33:40 +0000
Message-ID: <7457912fb397fac3c0f213c316660c6bca0e9a62.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-9-chao.gao@intel.com>
	 <6bec316e-3216-425c-89e2-fcf32fd4e15a@intel.com>
	 <aczW7MZBqsCXw4gk@intel.com>
In-Reply-To: <aczW7MZBqsCXw4gk@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA4PR11MB9107:EE_
x-ms-office365-filtering-correlation-id: ffb285af-118e-4cdf-b841-08de9761fabf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: DR1hV+eTHxOhULiAibVTMNwlhvCa6jqT34mfR7nZ8leQ5FWA1qlX/9FukTLDKTiS8A7yVFe9WPwpsx7ZaCbAGlzJdeICZgbFz4HnjmprZzgrRJZvvbvjmixyoP0g1TXYVs8EJp+v6RVuce4VLLV31JzixKtSpqNJtFS8aG8jbFSbyNCpLzclttFyYUXW4UDPl57zIXoayV1TR+p5MB4RwpHU1pTFT9WyMzJk71VaB/l9DV48rfN6asID91mwn/HBFlX9HcIbrDWwym9tkGrOFz8O5NRbUBS3yZ8qGDsthXKwxM8cH8ycLhmjGg2VeX1Qik/8cd1beUbu2Y0OLy6WJzuKi1F73c7y2XxZ/qB4Rl/YxFcVADj8NMth7jiyPzfYY2zxmxvOXavVwL4bGJ95Ff8dv4tPWHD4uH0eA9X9oKhNK/oh/ouIF80b3BRJ5kFd/a8elNQQP7o7Ftf4o8yBqMHzE9BgwX5shrtKwKtsMM3EQ/2Kesmple8wW6Wep6ataNeYdFyS4a/hoFBaNprH3VOmgUT932c8NVPYaxUMHvl1C2y9GQC2lzQ8xL1oiS/7Cl2fzWkxtZvQoj8BrlSuSBcMhawxV5623zYUy66lHLwbB6OVfIoSdISogsmm6bmPN3RamHe3vsHVne5V7g8m000Ttb0ZnCcM7M9TOZ7BhiswpAiG2+pgHAAqzJQQ/Mshwo1KXl5FPQCR7PpjNq9pvylqXzA13t8pFHsWATk4nvorG7W3Nk3QpABQvOX2OIoj1wkK3RmlcTAqpPUVC9L2ICy4CWccBaAevYkSunEqPfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d29vMy84TU5pMS82NVhoa0tMbWFYS2g2VzRwSW9MdUVEMi9QdzNPVURjdFRj?=
 =?utf-8?B?d3ozcU9zMllDWGtPaCtuOGhaM1dJZjVSdHZ0cTZlbXdNZzBjRkMreEliNXVv?=
 =?utf-8?B?eXFSUzZicndDYTR2SGtZaytTblFEYkRKT0NPVVk4bjBSUzVkbkUxMmVKTDV2?=
 =?utf-8?B?b1p1YXRSdmwrUkEwbEJPWlg3NTFRWHd1aGdXQ2NrQ0p5Wnk5RlUrUlE4VlFQ?=
 =?utf-8?B?R3dQbGZMbUJFZ1dQeS9tNk85TzkvN0xxWFFuK2tOd2dTZUp6U1dLdUgyaHNj?=
 =?utf-8?B?YndlTG1NRDlyY0JkbTR5b1BoeEpVYSt6cEloUjBROXo0MFVaT1A2MitWTjFZ?=
 =?utf-8?B?QTdKaGc4aTBCWDk4QlF4S05iWSsxZjR6WDF1a0hWcGdGUytKcnB6c3cvcEI4?=
 =?utf-8?B?aHN4b3hXSmt6TTZVMXR6Z0xzZStObnR0OEhvbHRXOUxZTUFPZ0JaKzU2UjBr?=
 =?utf-8?B?WnpuNTVuNWsvZXdRZHdBeFBUTU9JbDliamxvUXY2eThkZ1lFUHRXbms4RUVR?=
 =?utf-8?B?cTE5eWd1a0FBR1JzU0lLVlowTkQxb1BGVVJlYWpESG1sS2Yrc2UwdjU2RmQw?=
 =?utf-8?B?eVppclRXWUVoSXdGS25IZ0c5SUNoSHNsWkVuRGtJOERUZ0ZjRmNzaEt5N1pB?=
 =?utf-8?B?ZkI5eDhPRHNYUFFTSkVJNGdGb25oeXNpRnk4RU9ZdWUxcytmVWRNajhpU2lO?=
 =?utf-8?B?WkNENFp5VENTSVFnTFRkcmRiaTZValdJaDRWNTFaTUh6WFIrVEpLOTBxaFBq?=
 =?utf-8?B?b1hGUkRWRmpZMmVnUHpFdytaV1BDVUlCRUpQYURnVEZXbzFnRGZ0dStYTW9w?=
 =?utf-8?B?Z2x6dE5RUm1ZZytjUVZEQlVkejllV1M5dWQyQjBCc3ZyUThadW0rT0xXY1oy?=
 =?utf-8?B?Tys4bXBta0wySUhvNlhWbkZMQmE1a2pqV0FTWXJaSjI0NWRpZzZQRXRRR2JF?=
 =?utf-8?B?eE1FOHRvTENBN1NYN2hydEhpVmJpWlpnN1Z1VEhoLzZ4OWhMRjdVWGltRXI2?=
 =?utf-8?B?WTY4VEpwQzlNeTJLNnhtTTByQ1pJWENoVTRnMk52dEZ3K2VmZk1jYlp2UnFh?=
 =?utf-8?B?a2JkZGVxdVh5N1RrZjdUVGxlL2RyMGdOcmp2S2VjN1E1dVlxUEE4MmtVWWFn?=
 =?utf-8?B?RCtrV1FvNUgwMWpEQm1JczlVYjNkU0h1blhTaElZb1Iyalpzak90Tm5ubWwr?=
 =?utf-8?B?L21qQVB3dnczUXdiTnVtbyt1WTRxcGFMeXZOY1hSSTd6Q2NaLy9WRk5MamZ4?=
 =?utf-8?B?NUtHMlUzODU2ZFdXWXVkbmxCUFZ3WUJiVFpvWjMvajhieHZuRVB2aXNJSG9Y?=
 =?utf-8?B?YjVQT08zTHg2dHhWK2pUaElXejg0WFAwbThQdEJ6YnVNT004UFRweUdzdW12?=
 =?utf-8?B?UWU4SElzNWpXZkJxeG1pVkVBRFo1UHlaTTRmNlE3UXVQSXpPa2FDdnN5dnZS?=
 =?utf-8?B?K2ozY1EwMlZ4ZVBPOVhzRDA0QWM0LzNOK2kwekV4R0FwcGZXZDBnQUxPUjk2?=
 =?utf-8?B?bHNsMUk3VjMxemFyckd0cmRLYndVV0s4UUZ4YUJMVnhGVmVveEc5VnBlS0xI?=
 =?utf-8?B?dVB0UXEya1ZTN1RRVkJKNDA2L29iQk4wNDZ1RG8rRUxOblNmTUgyQ2YwZ2pN?=
 =?utf-8?B?cDRGeG1DbnBjRFlHZW8wYUxxd0NWUE5WTXlVVllBSEZ6Ris1MTYyTmNhb2Rm?=
 =?utf-8?B?TlZ1Q0lUWGM4YUdFbXdibWpnWGd1NXF3cmdnQTE0eGFxYkRFUnd1ais2bzRl?=
 =?utf-8?B?SEtBS0dLbXdIaVlWNE1XM2h6L0ZTZ1hGMnlFMGQwNjBsVjVZa0c5bHBtZkJD?=
 =?utf-8?B?S05VT0pFenFaTks0RzR3YmNFNlUyNTkxNkJKV1NablhrQVV3czE4ZXJETFM1?=
 =?utf-8?B?YWFnV0VZTGpwK2xPR1FkZ2tFN0NrVjlZeWRzdEpaVzNIUldMOXROb2dUaFB1?=
 =?utf-8?B?S1I5bEh5ZWE5bWFoNzlCRTUxR1NYUTgrVGZHN3BvRHpIM3lYeGRDT2szazBW?=
 =?utf-8?B?NGQya3g1ZmFwcFloaFF3TGwvajJkRlNyYnlOOFduSE5EcE56a3NHYllCSkhm?=
 =?utf-8?B?UzZKeWlhMUs1MGVFamUvZy9sZFFIeVAvcFJYYy9QaldsMnhDMXdLWkxUdU5l?=
 =?utf-8?B?Y1o0NlRSWjRBTnZNdFc2Sk55YzZqdXFlc3FFaW5qWmlSNXFQcHpTbTk2MkRI?=
 =?utf-8?B?ZGtuVlpyWWpkeFl5N0ZLQUx1czZFbjJHTWVId04yLzQ3cWFRL0x0U3I3VVdx?=
 =?utf-8?B?alhuVUt4TjA5RGhqNlUxM0pnMzQ3R01HYkJONzUzWkZLU0xxYUFHWFV6TVBU?=
 =?utf-8?B?NW0zNFl5bVFDMWpORGhxb2E4cy95UnpiTHVYSnovRGd3WGJHYzFOMUlJK3BB?=
 =?utf-8?Q?tB3FpCxIDi8UgsnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48B9A2FB2EB5CA46833C73B9D6648ADD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YvNa16t3FJSTNZlXsxSLwrwhzVjI80vcC6FyfswDFP1v1JYTL1D9eHXs6h8s02/0shrcrFHbz4hXljl+RcnvZnlR62ngjPvk7ZnMxTDuN2SGohlV4BbltwEbZ+mYOcVZjFfuYxP6WlDKCrUju0hPoZdbQeEKZCgR1Dd5GcpMYN79ln35MwL+TSfSQFc3AabXCZJ3ePUs8M33KPicQEk7INrTnvkINV/aJt5GHhcwYIyjq8ZtIR7Azu+p7Z4zePm0i6N1oAfFHQMK8R24jBNrR5ezo1uAK4MOi/w1aKSDhWsOfD3ePGPsht5twtYParjs6sElYOdaf7g0uIDffwfe5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb285af-118e-4cdf-b841-08de9761fabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 00:33:40.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCvBQnzbp2KJ5phHoUGrRzWFxGjwCLUmi8WvZKUCXfoavwdYlOhIFYZ3xY0K2dhB1ZAT15AFbYj6v7LYzlJvp1VzCGACKSObKbbKD2wWzZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9107
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDE2OjI3ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQW5k
IEkgYXNzdW1lIHdlIGRvbid0IG5lZWQgV0FSTl9PTl9PTkNFKFBBR0VfU0laRSAhPSBTWl80Sykg
c2luY2UgdGhpcyBpcw0KPiB1bmxpa2VseSB0byBicmVhayBzb29uIGFuZCBzaG91bGRuJ3QgYmUg
dmVyeSBoYXJkIHRvIGRlYnVnIGFuZCBmaXggaWYgaXQNCj4gZG9lcy4NCg0KKzENCg==
