Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD764D17BF;
	Mon, 28 Sep 2026 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636885; cv=fail; b=DvYWW1HOqS5QDkcUyehm7RbuvBNx4L+Veaz4JWxkFv28Sam86tVwezaMDkwTQhBUrLa41HyhwtmWuuEjxUQebtB+XdsLmt+QCKPiWDQhdFvmUgFoDTqe14SlLis4nYGZmr2A0zILXu0P8mCyfA/6Y6iI5cgL1gXRD4kjzHPVDJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636885; c=relaxed/simple;
	bh=FghO3QH2uZbtLuDWlCxyOonqWfeMSlCej0TGmnt8mTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jSpo/iZUKHGdZQR/Silh8f1GfffO43n+qQZ+L4lypwGbNQF1BIwq94i2fZANHp50cx/63g+NDPlImYLcPSVl6e2/OLev+JMMvWaYVtWU8NtEZJCo7P6ERmk752MBqnEqHTmNkRDqff+wxTt3rIEHNgfQXpmxZ9X2C58wD8Ep2SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieyPbq78; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieyPbq78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636884; x=1822172884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FghO3QH2uZbtLuDWlCxyOonqWfeMSlCej0TGmnt8mTw=;
  b=ieyPbq78SQoi6rvKuYCSaMtluO7xl5Z2Z411W//C5iACl6uibPf4Iwok
   SSa6iLCQL18M4wzoW1iQxK3ELlZ/cJkgmleXaI1mY0wj7aSKLd7PNwDuQ
   UD1e3K/vDWHUHZPjdtFXrrWAKtG/L1Ywy0vAWuIhmAq00op1dHDdqim3Z
   rrWaeGs0UC8QVPI8f6TjywDRSkaQ28ynmEBc+pLONiDXuSb41MHXDmiQk
   oEGsHM4h2a9c991DFxjoK+Hj87UzSE68rTfYS0Xys31L3OBhBFcilwPXo
   tyr5kBkaVQiN7h3WtxQPX3eErg1MLQfbXaSftG2o6uX9MRdF/D6i+CDO5
   A==;
X-CSE-ConnectionGUID: KAypcIpxSUK26bnLtdmX3Q==
X-CSE-MsgGUID: OyThOC5GQ1KfmFE54IP7Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90301173"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90301173"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:08:04 -0700
X-CSE-ConnectionGUID: WUjXVpe/QnWb6jLkvoHXXA==
X-CSE-MsgGUID: cGb6ti4pR6m92kCdWeCF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="303129767"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:08:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:08:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 16:08:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyRQH73GptoYRMIPdcNrlNc0LbVCHRKB5Y6EuDvTK0ZA6l+Pc9t/g+2bYLk2bQUANdR0WLCMgOIqCb1LVlegTnW/yYcO1Mr9S7VIz3rErV2RH3Sxdtqwnh50WHamZARqDIt9whxcqG3CcsX8HLV9YscbMrdXQOCPwcdk95zS/UOQA7ovgaJqau8hZ5YJszOW+Q3DVQLB+NCKFCwkMpl4kAEWK8OEKfAq5qXVeNi66lUVNN+ifyLklx+V4LLhbFx9Ic0HHIwTeD4+601M7CvkydH+TLq4m6OHyXO6TRnBt9R4IxRUqoMQrXXV3ah/Fx8lfqQpF5JeJ0qKL3tM172+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FghO3QH2uZbtLuDWlCxyOonqWfeMSlCej0TGmnt8mTw=;
 b=A9saQZqJTLAb+Dp6HZKK4ei5YIUGTGQLoIy7vS2sJX17Nu9OS+HRuVzZJYKGeW/p+DuP+XDqkyDOysKpdLKwuGBhZiHZCXaPKXGIbf1m+Ph+DsHcuYvG7zoeiYuDlPeSIdpbPufDD/UnrkS6sbU/xfcXQupPBSgBuHS46j3sJpzQU5XvkQDuQzgiNfu+vBcMEtM2RIruAOgIVMaLZ73MYWtQo4pBMzEFmqZL/qFcJR+oq0+3r/jFMLgKXfdlO2t42Vn3d6xD+S8+G8vqbOuTJDlWcFoPR6HE1YKWQ5zgzqIfS2RjWCPpQdKgMWp/gZWkmZn44eP78qP4Fl5DCWW8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 by CH3PR11MB7939.namprd11.prod.outlook.com (2603:10b6:610:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 23:07:52 +0000
Received: from SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c]) by SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 23:07:52 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "rdunlap@infradead.org" <rdunlap@infradead.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Thread-Topic: [PATCH v3 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Thread-Index: AQHdSs/e+z4u5gEWqEeOrpmHmdHPmLbfLPyAgAV5w4A=
Date: Mon, 28 Sep 2026 23:07:52 +0000
Message-ID: <c41ffc542bd677b71bcecbe4e2c2e2a3b605ffcf.camel@intel.com>
References: <20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com>
	 <20260922-b4-tdx_earlyprintk_tdcalls-v3-2-6ebaa599df10@intel.com>
	 <arZbBqArD9NqWPry@thinkstation>
In-Reply-To: <arZbBqArD9NqWPry@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-2.fc44) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB5162:EE_|CH3PR11MB7939:EE_
x-ms-office365-filtering-correlation-id: 85291a60-c198-445b-2dc9-08df1db552fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: TsTpL94SrUjGWppQ75bEyPtFKApUm0o2yDsZq/1R2Gzi/+YCWJdtOe38T868sVjbjNdb7QYep0lzI+bffpBiGfRALTI74vTlgidFY2tbUHFLBEW+HvOc4J8PRaAvGDn3PnoPDi+FH3lMu0Qx7n3yUmNwe9C6thWW3as7IPF8Z+Tmf0eKnhHyqWh8Rlv2yWXREgA3+phpXD5reEAahbzgMpUGVXtabTrI73OL5QYEdwFaYt6XylM//FN7HkvZ7+eFTcIl2lnlIhwbY/c/Vbv/3k99ESKgPPJFRa4OndYjxyM+yxFu19gb8QAFoz+Z13iJwMSXiFl7UYs/EQdwka6XMPWN0NtovPt4b3kUDXX+ezhVMbi7JbMG5efnxrbBNCj/3Bjuei56S3CNCrOZ9idVWmVnyAXgm1nyrZug2fLhfvZg0iyPqBdfI1DzXDlqokA94wpCWU6msHxrLNW1g5LB+zwcT1CiCJqRdGuKRHtkF0vFg5Q4GvDoelQyhnMNXcn+ZDFT5e0DBillkABJorueHj3jj9abVySc8E4yiKEIdLGkV4Z0ALE/SzJD90KqKXdw4CnWPJSpEIA8YJPOlSAxuf6mQaamneyyHuOaKxrDgiNalLaeRIgQkc93W7koP8/hXCofPZTdOzZcL4oy0IIf+zTJ0gPSzN18WweSXYMB7rlGCyIkYCI8ZhWHjhf0/Mdtx1NaJ8r5dhHWC0MfWi9Iug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5162.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnJ3UXVnT3c0S2Y5ajE2YTNhSzBQRmpheXdMcGtqTEhuL3RIemw3dURpRVV3?=
 =?utf-8?B?cHJnVXdEYUxFQWFGcGVrS0dpUHAzaExxQXJyTkg2UXZtZG5GbkxZem84Zi8z?=
 =?utf-8?B?MTN5S3ZydWw0Y254YU9aTm5xeE9SN0FuL0Fja1cxZ3FDZ2NuMU83U1JncExH?=
 =?utf-8?B?NkdzSjNGNFcyRjdjcUhyV2NDWHk4VTFqSlJVTDFHYlhobXR0cXgvWXBacXR0?=
 =?utf-8?B?VVlLd2pidG5qbW9KWnJJTGxRODdjbHY0QXUrbmdyNnU5cjc2dGdYemdScjFX?=
 =?utf-8?B?dGQ0L3VtbTZZQ21SZU1TVFJtYmlDZ2xTZzVGYnF1ZHI1OFZocXBUK0VZcHUw?=
 =?utf-8?B?cUpZQnZCOW1JMmVYMmtTazNwRTNXT2pGdXJUeU8rT3Q2QzhVRVJmeUd5STc0?=
 =?utf-8?B?ZnNlQ050MzZFRzhBd0hlQjlXNmMrUnNFWkhWTzVFelczZ0ZQZ0xQNHFkbExn?=
 =?utf-8?B?YzM0TWs2Q2dKZ1NTQmlUbFFiZHZhUGNjQjhmNVNJTlZmOXVOdDlXUk4rTmkx?=
 =?utf-8?B?MzFRTTg1RWRPK0FOMXBLbkZQT2FLOUpxT3JVOHpleDMyUGdVbWNFam94ek9k?=
 =?utf-8?B?VEd6NitveWhqTTBoajc0V2hhUkt3UEUxS1dYNmh1NDd6S2VXMFBwZkhIdWFh?=
 =?utf-8?B?Mm5TWlpIUVFIS3J4VURDbWUySlZoY0IxMkNYS0NYazJXMzFHczVETEgyekRX?=
 =?utf-8?B?eW5relB2UmFNV09Hd0hwQUNEbGx0SHNyQnJ2OGtuTSsvUDNVcW9qWXhBeUNp?=
 =?utf-8?B?VXNCVVFJcnVRd0p3RVN6azZObmNucURwQjdpTTl5c0FZL0gxSHdLeFpkTkc5?=
 =?utf-8?B?dVk3ZnJWUmx1bTNnRHR3SzY4aEkrY2VyK21lYUpkbDl5cWI0VFBIWDExdGFK?=
 =?utf-8?B?dkpCWnZhNEx6ZThNaTJuM3o4dkt6YmZaRzh4WENac3k2bytLanIzMnk4Y3kx?=
 =?utf-8?B?bVZrdFg2dkMyR1NCcEg0VjJycGNzdmVUOW4xVVJPaXZuNDE1VkswL20xdnV4?=
 =?utf-8?B?UDVVcnNPU21rZzNJV05nNmdRMUZ5NXBxanU4Ym1LcjhJNmRheTBLaVpWQUlp?=
 =?utf-8?B?YlQ0ZGdmdzJyYkZ4SDVvaDZDdVVLNXlXb0FLVm1kcmwwOHA3dGlsVUVFT1lo?=
 =?utf-8?B?SVBROTEyNmNLejZlT2RCRHlqbFZYTDlHaEpqZVo4dXdZSGtaNzA4NmplSUNY?=
 =?utf-8?B?TFFHcVQrZ0NlNXlEUlNZd0VKRFJpZkh3TEVEdVdOdVRlVHIvVm9ndU9lRWlH?=
 =?utf-8?B?clVzTmZ6ODg5N1JiZkxxVmpPaEJ0WFRqVnhoZUxaVm1ha3kyRll4dzlTS1Qy?=
 =?utf-8?B?SjRvRnh3YThtWHhreHFCVEFMY2wzcHhiODR0RkJ5YXdHSTBlVlBacndYYWtS?=
 =?utf-8?B?eXd4Kzh1NnlGOENBSURBMUtPa1FkY01jYXpMb05BaEhIcWRBbVpwTXY4dzFI?=
 =?utf-8?B?Y1p1SkVBaFRSK0ZlQXlJR1pzcFo2ZG5zVWFpeXJwTUN3TVBQVlN5MlZUQ3Vp?=
 =?utf-8?B?RFBJOUFEUTdzODg0NlU0ZHFCQmdNcGtPdEdkcGNPVWw4WEpGRlpjdHdrUnl5?=
 =?utf-8?B?RVRxR3ZOUC91VnhJR1N5dnFaeDNiQVgrVnlDaDVpNlByUW9jTW0rRWtDbUxQ?=
 =?utf-8?B?YWNwSmhSSmpPSEs3dTQ4eDVtVE8rQjROSDRzM0VRNXlJa3MzQ1lTSFM4RTBL?=
 =?utf-8?B?cU40dlFwckR4Wk9tNy9FSndKSWJqbUg5SXI0TjVKVWErM2hBalN1eG5tZWVs?=
 =?utf-8?B?OXlpMXlXKzlCSk1DT0RLRXhCTHJLREZCMElWVlZ3cUcwb1ZCM3JUejgvOEYz?=
 =?utf-8?B?OFJtS3FoOElXSDB1b3RDSkNXencxYStWa29wRUhOaTNuVTB4aFgweHdwelE4?=
 =?utf-8?B?RitPNjJFSlFjUmEzNjd1NXRrYy9CdXJJajR6RFptMkdONTU5RkJQYTBHZmFT?=
 =?utf-8?B?YjhyNnpwb053cDJnNWgzMy94YW9xdHhSaktkVjVlaTRBb2hUS200dkdzaW54?=
 =?utf-8?B?WGlvS0N6R0FGOE5nTEhLaHFZVnVYRFZoNXBseDl0NklCMU1ZNmJZWklMUElY?=
 =?utf-8?B?dExNRXhWd21aUFlhbStWUVZ2d0paQ1lvSFBzTEdKMjJHK2dMMjVZT05sRkZs?=
 =?utf-8?B?Zy9udXM2dEFVLytPSVhWTG9KVzM1ZWQrcCtteVMyTEowU1g4Mnc3NXFBM0M4?=
 =?utf-8?B?cUJjVHd2QmpoOENVZ1AvU1NRK0xoUFdrMVh0NElITHlXYzkrVGpsalVvUFJn?=
 =?utf-8?B?QjIvZ1dMdmM1ZDE1TU55a3R0dzNHd1Uwb1EzVEFxbWFFdElTSjg2aUFqRVls?=
 =?utf-8?B?aExvbkthOVRYUU0reTd3ZkZldFR2WFE0SHp2eHJhYjN5dENMMEhZU1JnYTFy?=
 =?utf-8?Q?nVz22NfJ9HXJ+zhI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A6CB224482B8143B692F7018F2F06AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: leaeTPhKv1p00g9IM+nPSAXhu818dXmyKQhunLRpGg789ljlMNPN/KEDXi0M8T3LtP1MC3scabhiupatPLm3b3xWrHUqJOzIubgAurABkhs9AUB81Z2crcURAyBOB7hncyScw9LMUFvFVYqZrz2sEbrthAPWDLAwBZr2+GYjxfQSqy2HToabJF2o0BfcK9nd4uG0BjsAKgH/I8nCJXBd/bF+fCPC6IvHgt5LfdYL3x3F3v7LPu9YBA4GeAwS/c5UtcNQyspSWC4JcySp110G5pA6oLoHni+jXXf8Dx6kuMwb0nwdjeRkGc14qA/jaYRzJvpxjCLEIuxe65kspjsPbA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85291a60-c198-445b-2dc9-08df1db552fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 23:07:52.8188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iu86GJIKNb6TNlaS9CH7PFc829CAzyb4VThtCPdGIPlPHzgYJ66qT/k9BxW0b15e++wPQBDMrpqeE4zTqj2U+MMuNv3CWHQ6Fx8YhSUNtOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7939
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTI1IGF0IDEyOjMwICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQoNCj4gDQo+IEFsbCB0aGVzZSAjaWZkZWZzIGluIGVhcmx5X3ByaW50ay5jIGNhbiBnby4gWDg2
X0ZFQVRVUkVfVERYX0dVRVNUIGlzIGENCj4gZGlzYWJsZWQgZmVhdHVyZSB3aXRob3V0IENPTkZJ
R19JTlRFTF9URFhfR1VFU1QsIHNvDQo+IGNwdV9mZWF0dXJlX2VuYWJsZWQoKSBmb2xkcyB0byB6
ZXJvIGFuZCB0aGUgY29tcGlsZXIgZHJvcHMgdGhlDQo+IHN0YXRpY19jYWxsX3VwZGF0ZSgpIGNh
bGxzIGFuZCB0aGUgd3JhcHBlcnMgd2l0aCB0aGVtLg0KPiANCj4gQWRkIHN0dWJzIGZvciB0ZHhf
aW5iKCkgYW5kIHRkeF9vdXRiKCkgdG8gdGhlICNlbHNlIGJyYW5jaCBpbg0KPiA8YXNtL3RkeC5o
PiBhbmQgbWFrZSB0aGUgInRkeCIgY2FzZSB1bmNvbmRpdGlvbmFsLg0KDQpUcmllZCB0aGlzIC0g
aXQgY2F1c2VzIGFuIG9ianRvb2wgZXJyb3I6DQoNCiAgICAgQ0MgICAgICBhcmNoL3g4Ni9rZXJu
ZWwvZWFybHlfcHJpbnRrLm8NCiAgIGFyY2gveDg2L2tlcm5lbC9lYXJseV9wcmludGsubzogZXJy
b3I6IG9ianRvb2w6IGJhZCAuZGlzY2FyZC5hbm5vdGF0ZV9pbnNuIGVudHJ5OiA0IG9mIHR5cGUg
MQ0KICAgbWFrZTogKioqIFtNYWtlZmlsZToyNDg6IF9fc3ViLW1ha2VdIEVycm9yIDINCg0KSXQg
Y2FuIGJlIGZpeGVkIGJ5IGFkZGluZyBhIF9fdXNlZCBhbm5vdGF0aW9uIHRvIHRoZSB3cmFwcGVy
cywgYnV0IGlzIHRoYXQNCm9rPw0KDQo=
