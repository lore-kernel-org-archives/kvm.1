Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446337FF50;
	Mon, 24 Aug 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594297; cv=fail; b=M63bl7MRL6+h1fCewGTP32eGwNCr+WllOKV5RLfOE9fzogYYgqiJxISW2qi5J54Xe2TfCwjZgfO4+Na1DM9InoddhQeiljwRWbobHGNWjVabY/52VZ5mzvP+23K3xwbu+X41BkX0OU7eDfeAlc6bVzy59p2T5Upu4wBYmPM8G70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594297; c=relaxed/simple;
	bh=ab3+mbn0MuFCQV6Bzewb74CnfIV9faFnlC+nClF/I+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odZzHq2/Avdy+p9oDVHJFX7b913w6QSB9vbvzuNbxxtRADn+ceplmXL6h+bv55MVlQbj7kJMnXwbuqvm1q/VHQY8pQHrzN/LSRmwbi8M1yW0TvT2ubwRLdIMzquApV8eeZ9gn4pplFn6lZXt58qTbVmoTzSR62eo3ovtBolKf4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xd0MXCaU; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xd0MXCaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787594295; x=1819130295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ab3+mbn0MuFCQV6Bzewb74CnfIV9faFnlC+nClF/I+s=;
  b=Xd0MXCaUjx5rUpe0AdCpdqPsMGMbsMwAnSkN5zPWrQsH+WpaQGqZM4g3
   ycss7RXXOy/y0jQpigWyK4drGG/ITputLEQ4bH23WidMZM9WdjBilhcZk
   G86IzA7P2BHsyKVNS66jmLmD5N6v8EMJuGWQZKVCWFvJy119sDmv2vw85
   O9UifK9P8OxDKZlgcr/ZddGWV4KkGhrFoinxK8z1LSkcQa/r07r6lzg9K
   KFeRuIEhnK66LpkrT91T6+92MtjHylNY3PyPZ38I+36M+CwdC71BRC/3t
   xXkpb0L/UOkjCkmcNe7u/lf9r7ZBwDrTumX6YKCEsy3QpkqcuvL0N+AnP
   g==;
X-CSE-ConnectionGUID: ccJmIMwwSguZgpcBeTZx3A==
X-CSE-MsgGUID: 5CyEVm90R8W8KUft5yQIQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91925485"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91925485"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 10:58:14 -0700
X-CSE-ConnectionGUID: 848Bz7tbS/CRm9doigR46w==
X-CSE-MsgGUID: VrsPS/jJRjSABrb+5T80ug==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 10:58:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:58:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 10:58:12 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWz8GOkrzS/XUDewADcHV4+hBysGegHxlH7NC8ub8t/6/f8SV8TvQLFvc0GmZiDEXO2a/R03mZ7DYdXZ81JCSguqfz3omTAdkOpBG/voh7QEq4FLx35OVmrzaBdhjW2Pw64S5rH3JVtrJsMnOXIVz/ZQHnXFTdFfTpnXtTsX+Op7eKIuOklAGaedwNTXhGFtOWy61uzVqbDzabHBRSxYsA68mFGIdQ1mSGtNx+MtJdlcPRcXmruB7Q4MvUUw6Ch6KxsUgLuNMjAXAlMQa1KCSwwAt3b2uvcRclyI2eyAMuF+Hon5hjTZglop7YSteiHoG3imHoiubrepdaWaFJdVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab3+mbn0MuFCQV6Bzewb74CnfIV9faFnlC+nClF/I+s=;
 b=ol0iqJbqiqOWaTZjsv4Wm4DUKowRVi2W2dHXsenRZOlMwuiRP5EqwGDPvlUjcJ9WnT3T/Uc6WApb6p1UjlC3l2G8aXZAMXHnkmGvwQ85i0H9xBGibJN3+zXMFz2W7FsiCn8x6pFAWgfVVrPxqXWyH3t5Q8ePp06043oHjdLNAo7UpdBL+LtKYWgM4FrTRccoZB4USgIgTTMjC3TYRQQXObPFxBx66tbulD3nukBUMUGQiRpandE9B35fglVRK39GTl9YabVRcs+OlNKJw38mgoDuOMKZLtMgU3qeo00IA9eVRfKG/qQKsoWTv/XFsIEJloNIcQhk1Y8xyvARicWkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:58:07 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:58:07 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Topic: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Index: AQHdMR1VKsXmvQZJwk6q+Ulq286OyrapLs+AgARHHwCAAAz7AA==
Date: Mon, 24 Aug 2026 17:58:07 +0000
Message-ID: <e05f49c28a78de961130655a76f415b01774016e.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-6-yilun.xu@linux.intel.com>
	 <f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com>
	 <aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050>
In-Reply-To: <aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7733:EE_
x-ms-office365-filtering-correlation-id: a865a4a9-8a49-46f9-cec5-08df020940d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: jT/W8TsDRTeUDmduZHQQX+tCsrMbMquGayAfQ4P5zQMkB6T081qU2BvZlzzEQyGTYNGXQPjbKziohs99UnpPVTTEM++ALcqDNdFEe/XbJLom/ojVEosa+K56LrE6JjKTE6PurJje3eGaRT/kY1fpsq3COzzg1F3q/Oo0xwMiGoKdoIlYc7uLNdV9tdjgwr6dNjducb56F8+9C4/HwvbpDxOVn0xdJxtVO+JcYWcY9b+nFxAfLDwG8SrTdlf6O9qEhqHPknVtJoQwpU6jP8Oy4G0oVjv8LXnHauzcZNxfMa2S7GjIOtdpkTFGHZJ9xQENVgZ/QWcXt5chsavhNSAsG9HtfF9DzmRKWHzmx3GFqyWm4UZqu1EZezp8KFDbOl+Nfd1KhBu5dfMVYf/AltAHrItJzMp2OS/KVKSOZlxut4WSVqH96NZ8qHWjUUy/jUJuACA3SqAnIZ3YF4y3UR0lZIMzaC+i6c+oZfLR4a15/mVoWok8QS8HU3EXcPJBYWHXxkf0l6zT9Cy7MsCW+JkL7mioUOuv5FrSYZSAI+dcQAb4jf/3wverrMEyyRrmZDSLd8Pr3uFqbDO7Yl91wF6v7lB2QCBl/pJhzgSYjfBKDjBv7pVXTh3tY83bTiWYyg7mE6DykYa+dDkxiWsiKY1FmqkmIaVuu2s2kIrt2USSXgepjkeFDImubJ8o8qSEwckcoUfADlRYIgCMy9/EmmprLZIZw4eLYU2ic31LfMPIMBU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlQ4cyt2bHNwV0plTms5Q1FRK2hyVEczelVHbXNOL01kN25tWStPbUp3c0lJ?=
 =?utf-8?B?enlkS0trUVMyOXVGdUdKVlpUbitCWWhrNm0rSzV4bEFFaGVBTUxOR2Rndmha?=
 =?utf-8?B?cStMSnhBYkhObXFndDdMZmZVWXRLVzVvSFFzUUZxQ2ZsWUZxV0hVSVIxV2RB?=
 =?utf-8?B?dm1lYzdkNkw3Q01OdDhjQnlJeThGaUtvSXE0cGUrTHJiK2NYNDZVdks3bUNS?=
 =?utf-8?B?QUJEK1lSa2J6Mi9TRWIzZFVGVUtDeDBKMjRtT2NWcmcyVEhsTFZNZXZqaDBM?=
 =?utf-8?B?VHRpUlg4S0p0aS9KbjdWZStBSTEweWNpK3N4cW9mSnF4aWFPZWlJUHlPWE1p?=
 =?utf-8?B?OWRqWHZKOFdNZEwyVW5aR2pPSHNOM29sUGVnS1hFNVBBckFCOUFaN2EveHpL?=
 =?utf-8?B?RmNvdCtBQWZxT09vd2tOZzYxekpGQ2lyVmMya2YxbWtyU0JndW9OT25QTHhN?=
 =?utf-8?B?VkxzdnNmOElPSVZmTnBHc3pDU0JPeUZOZEwzVm9GOEJ1Z0E4Z1o5ZEdaQnZh?=
 =?utf-8?B?cEoyYnhSdDlrVkxIdEYrVmZQVmVvWWZOMzZJM3htRngvcjBEVmlZNlgrbHdp?=
 =?utf-8?B?YlJ2YWk4OGJsWjN3NzFUelJNMVRSb0RZc3hkWWtHYTF1N01PMUhYcGV2Rkdw?=
 =?utf-8?B?ZFFaNmo1d2dpM2dqRkFDMXpCb2ZwK1hRSTZnVzJyNGZCQUM0MXZvbm5tQk01?=
 =?utf-8?B?TFpvUXV4eHhGMnZHUXdUSGpsRUVwVzIrYnBMMWRkOXlqNmh6RjgxZjEyUXov?=
 =?utf-8?B?SHdQdVJkRnlBMlRFVmZ3Zy91Tmg1M2tMZ0gxeHJhcXZRMkdKYlFTdmE0dW5z?=
 =?utf-8?B?NU5Kd1NPM1pnRjZ6WEZHSlUxN1YxTW55dktjQzVNS0x3bk9GbHdzOG9CWDBU?=
 =?utf-8?B?SzF5a2l6N1doVU5OQU9hRGJsR3d4VEtvRlQ2VmUzTld4RksvVlo3clZ3K2VT?=
 =?utf-8?B?TG5lSnd3VDlNUEo2dEoxZG44dDJvR3FrY1BsbUlVOWpXVEl5ZmUvd3llcmVL?=
 =?utf-8?B?VGgyZExqRkJlTWR5a3prV2FhVUFZMm80TU5KVFVsK0Z1S1hyZ0hMN1FLSk5F?=
 =?utf-8?B?c29XVURLNUdpMW1UeDFGWW42UWM3cUk2VE9jWFhCWUR3UFBNc09uRlNIN1Nq?=
 =?utf-8?B?WitGS29jZ1BKSldva2FLMkt3dmlVRVhkSTZLdC9VS1VXSGRZUGpBQ0lyb0ZS?=
 =?utf-8?B?QnFDV3RKTDBwcFBwRER4L2FFSHVmMFp6cnJtY1Vlb3RXUFNoOHN5blp0VHRS?=
 =?utf-8?B?bTdpMzhUMEVEaGFTdk9oaE5ZSnVITHN2Z1JQNldZcUtnbXByemRDc0NkY2U4?=
 =?utf-8?B?ZnBrUStUQU9IYzdQaW1sYllmUldHVnlabVVEZkE5bGFQcTdnbUFoVXc5bmkz?=
 =?utf-8?B?ZkNIQ0E0cDk1R1AwNDdXaVB5Tm9FN1krTFNlVnZkZVlqOEdxT2dmckZvcnhN?=
 =?utf-8?B?aGJ4Zm0xZlVURW1WTUJxdDl4N1VGakxYbW1ZcldCcVd4cnE0bDBhYVpiWTlv?=
 =?utf-8?B?bUZDODQzZUNXOVlaOThvSUlDOE44T2hpTmorK0FmaVl4RHpTYUU0enFPclV3?=
 =?utf-8?B?dXhIK1JNcnQxRm5SbDRGMjF2NjVaRmpmbHBHTVEvVnl3akJIbEhzWGxIQWdV?=
 =?utf-8?B?d0FoQVNBZHNQYVAySkd5SXB0Vi9qK2x4bWRzRGkwTGF1ZHNFVHBiM3hTU3dq?=
 =?utf-8?B?c1JuVWZycnkweWYyYWplSEtZOVF2b2RtTTNyOWtkQ2VDV1RVOVBMek42ckxn?=
 =?utf-8?B?WXdtZU9HNlBpYmI2aW5KU1Y1Wmk3NzEyVGd1Z3hqYjJkaXg2cmlmQjJZekVQ?=
 =?utf-8?B?MGE4THRHNngwUm1pVGpxMkJralBXL0tFOHRjSnVPQStRYlBIWVB2bzRkRzJL?=
 =?utf-8?B?bXhwdHpncTFHV052QTh0T2xSRTJKdWFaOHB5WDFPZ1BMTFN1RWJvaXY4Skxy?=
 =?utf-8?B?bXNKV0VCcG81aXhFYUVvSHBlc1dSL0tSU1MyWVhDcCtQZjRnaGg4UHNYSlJy?=
 =?utf-8?B?WDVNenYxd051UHkxYThMV2d4V3NvYjY2ZERpSXhjUEVhcUVWQkplWTVZQmti?=
 =?utf-8?B?MjRjbXN0L3RCVGU0REIxb3VMeGw5Sm05YldQL2llYjg4WVBrVTczTkRTdW9U?=
 =?utf-8?B?SXpOL2dxL2t0c2R4UldVYlFGZTNSRy9EaXJjZHB5RzhmU0dpa1VWREdwTXF2?=
 =?utf-8?B?U1Y2bFRrNWFjL0M4WTBxOHlWSHIvclV1dE9EMnN2VFlHMTVTS0UvNytWTFI3?=
 =?utf-8?B?Y1dWcEVsTFMxa2FVd2p2dFhqbTR1K3kzczlPSlBNYWFZTnJ0ZmRDN2FtTHc1?=
 =?utf-8?B?OTJUbGY5U2FSaUE3Y3U3amVOSmZwWHg5TlZ1b1FndFdGc2Zid0lYWHpOWERK?=
 =?utf-8?Q?k52krSYQkwGEVYcI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE0A49983C07B04C80145C448E96376F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qG+/ZwofwTIqd4wS3dh1m/wFYTFO94lCQfx21gbSYZeubVm/zFhTbELt15EN4dAuLsKkyOvbR5cX72KBVM47xiWdodk0W2QOzGDm0nVFih4mALSMKJ+lQkhvt9moxEbEt2aZ9q8jTuMcmSG41AtHaotuU6YbCpI5Lg2H4DI5C4A/rg2U+3iHo8exg39AJxZMTWf3OaUbIQnFaujEP3kHjr79a9b95oKKArfji/Rwf3iIimHn3IJmIGKzkEtHu/v8NvZ8nN+ZWsug6xBoePMoT5XN0HliBtMZlD8g4wd2dKhcPwk439sXs++k7ooCZis/Pj4ZQ/oAyLxRggV+ciq5+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a865a4a9-8a49-46f9-cec5-08df020940d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 17:58:07.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmwsyGsweA+BMmeoRMvkC+OBPsP0CyanxkF65ut7LQFd1c0bfulU3+iKbKOE3POKGev7KtODnY6lOecvLkjKjrmG7v3RxBeor7M1diO2XCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7733
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDAxOjE0ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBJ
ZiB0aGF0IGNvdWxkIHRlY2huaWNhbGx5IHdvcmssIEkgZ3Vlc3MgdGhlIGJlbmVmaXQgb2YgdGhl
IGN1cnJlbnQgYXBwcm9hY2gNCj4gPiBpcyB0aGF0IGl0IGFsbG93cyB0byB1c2UgY29udGlndW91
cyBwaHlzaWNhbCBhbGxvY2F0aW9ucy4gTm90IHN1cmUgaWYgeW91DQo+ID4gdGhpbmsgdGhhdCBz
aW1wbGVyIHNuaXBwZXQgd291bGQgYWN0dWFsbHkgYmUgdGhhdCBzaW1wbGUgaW4gdGhlIHJlYWwg
d29ybGQuDQo+IA0KPiBJIHRoaW5rIHRoZXJlIGFyZSBzZXZlcmFsIHNpbXBsaWZpY2F0aW9ucyBo
ZXJlLCBsZXQncyBicmVhayBkb3duOg0KPiANCj4gwqAxLiBGb3JnZXQgYWJvdXQgdGhlIDUxMi1w
YWdlIGxpbWl0YXRpb24gZm9yIGhwYV9saXN0X2luZm8sIGFsd2F5cyBhZGQgMSBwYWdlDQo+IMKg
wqDCoCBhdCBhIHRpbWUuDQo+IMKgwqDCoCBUaGlzIGNhbiBhbHNvIGJlIGFwcGxpZWQgdG8gY3Vy
cmVudCBmbG93LiBTbyBwdXQgaXQgYXNpZGUuDQo+IA0KPiDCoDIuIFRoZSBsb29wIHN0cmF0ZWd5
Og0KPiDCoMKgwqAgLSByZWFkIHRvdGFsIG1lbW9yeSBzaXplCXZzLgktIGxvb3Agb24gZXJyb3Ig
Y29kZQ0KPiDCoMKgwqAgLSBwcmVhbGxvYyBhbGwgbWVtb3J5CQnCoCAtIGFsbG9jIGEgcGFnZQ0K
PiDCoMKgwqAgLSBsb29wIG9uIHNpemUJCQnCoCAtIG1lbW9yeSBhZGQNCj4gwqDCoMKgwqDCoCAt
IG1lbW9yeSBhZGQNCj4gDQo+IMKgwqDCoCBUaGUgbWFpbiBzYXZpbmcgaXMgdGhhdCB3ZSBkb24n
dCByZWFkIG1lbW9yeV9wb29sX3JlcXVpcmVkX3BhZ2VzIGFueSBtb3JlLg0KPiDCoMKgwqAgT3Ro
ZXJzIGFyZSBzaW1pbGFyIGxpbmVzIG9mIGNvZGUuDQoNCklmIHdlIGRvbid0IHJlYWQgbWVtb3J5
X3Bvb2xfcmVxdWlyZWRfcGFnZXMsIHRoZW4gdGhlIG9ubHkgcmVhbCBvcHRpb24gaXMgdG8gYWRk
DQoxIHBhZ2UgYXQgYSB0aW1lLiBPciBJJ2QgdGhpbmsgeW91IGVuZCB1cCBnaXZpbmcgZXh0cmEg
bWVtb3J5LiBVbmxlc3MNCm1lbW9yeV9wb29sX3JlcXVpcmVkX3BhZ2VzIGlzIHJvdW5kZWQgdXAg
dG8gc29tZSBoaWdoZXIgcGFnZSBvcmRlcj8gSSB0aGluayBuby4NCg0KQnV0IG90aGVyd2lzZSwg
aWYgeW91IGFyZSBnb2luZyB0byBhZGQgcGFnZXMgbWFueSBhdCBhdCB0aW1lLCB5b3UgbmVlZCB0
byByZWFkDQptZW1vcnlfcG9vbF9yZXF1aXJlZF9wYWdlcyB0byBtYWtlIHN1cmUgeW91IGFyZSBu
b3QgZ29pbmcgdG8gZ2l2ZSBleHRyYSBtZW1vcnkuDQpBdCB0aGF0IHBvaW50IGRvaW5nIHRoZSBh
bGxvY2F0aW9uIHVwZnJvbnQgKGJlZm9yZSB0aGUgZXJyb3IgY29kZSkgaXMgc2ltcGxlci4NCkhl
bmNlLCB0aGUgZGVzaWduIGluIHRoaXMgcGF0Y2guDQoNClNvIEknbSBub3Qgc3VnZ2VzdGluZyB0
byBjaGFuZ2UgdGhlIGRlc2lnbiBpbiB0aGUgcGF0Y2guIEp1c3QgdGhhdCBpZiAxIGFuZCAyDQph
cmUgcmVhbGx5IHNsaWdodGx5IHNpbXBsZXIsIGl0J3Mgd29ydGgganVzdGlmeWluZyB0aGUgZGVz
aWduIGluIHRoaXMgcGF0Y2ggYXMNCmZvciB0aGUgcHVycG9zZSBvZiByZWR1Y2luZyBmcmFnbWVu
dGF0aW9uLiBPdGhlcndpc2UgaXQgbG9va3MgdW5uZWNlc3NhcmlseQ0KY29tcGxpY2F0ZWQuDQoN
Cj4gDQo+IMKgMy4gQnV0IHdlJ2QgYmV0dGVyIGtlZXAgcmVhZGluZyBleHRfcmVxdWlyZWQuIEkg
dGVzdGVkIHdoZW4gZXh0X3JlcXVpcmVkID09DQo+IDA6DQo+IMKgwqDCoMKgwqAgLSB0ZGhfc3lz
X2luaXQoKSByZXR1cm5zIFREWF9FWFRfTUVNT1JZX1BPT0xfUkVRVUlSRUQsDQoNCklmIHdlIGRv
bid0IGNvbmZpZyBhbnkgZXh0ZW5zaW9ucywgdGRoX3N5c19pbml0KCkgcmV0dXJucw0KVERYX0VY
VF9NRU1PUllfUE9PTF9SRVFVSVJFRD8gU2VlbXMgbGlrZSBhIGJ1Zy4NCg0KPiDCoMKgwqDCoMKg
IC0gdGRoX2V4dF9tZW1fYWRkKCkgcmV0dXJucyBURFhfRVhUX01FTU9SWV9QT09MX05PVF9QRU5E
SU5HLA0KPiDCoMKgwqAgU28gd2UgbmVlZCBhIHdlaXJkIHJldHVybiBjb2RlIGNvbWJpbmF0aW9u
IHRvIGlkZW50aWZ5ICJleHRlbnNpb25zIG5vdA0KPiDCoMKgwqAgcmVxdWlyZWQiIHRoZW4gc2tp
cC4gQW5kIEkgZG9uJ3Qga25vdyBpZiB0aGUgY29tYmluYXRpb24gaXMgc3RhYmxlLA0KPiDCoMKg
wqAgaXQgaXMgbm90IHNwZWNpZmllZCBpbiBTUEVDLg0KPiANCj4gwqA0LiBJZiB3ZSBzdGlsbCBu
ZWVkIHRvIHJlYWQgYXQgbGVhc3Qgb25lIGV4dGVuc2lvbnMgbWV0YWRhdGENCj4gwqDCoMKgIChl
eHRfcmVxdWlyZWQpLCBzYXZpbmcgYSBtZW1vcnlfcG9vbF9yZXF1aXJlZF9wYWdlcyByZWFkIGlz
IG5vdA0KPiDCoMKgwqAgc2lnbmlmaWNhbnQuDQo+IA0KPiBTbyBnZW5lcmFsbHkgSSBkb24ndCB0
aGluayB0aGUgc25pcHBldCB3b3VsZCBiZSB0aGF0IHNpbXBsZS4NCg0K
