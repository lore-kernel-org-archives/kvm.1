Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828523A7F69;
	Tue, 31 Mar 2026 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953772; cv=fail; b=kTKj0PLQQUtkFgNY7N2cR8OZaUP4eq5dLciIneyt/fCFL4yEQayyt32gqfLmJSBUipwyTXMy0jGS2f+Mu/aZLDrQO9RikWM9QGD+kOls32ETn70bA3nWRNVQvHrIQYX9vrr/byhTLlpIzWiNXOiAFTISl67ktU19a9dtICK4TEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953772; c=relaxed/simple;
	bh=ffHcfbGgLKBpupLjetwfxlJR2gTJ6pFpgYT/DXOY5xY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jS6QBW9XkKfYZKXlDGabaJn7FvmSBqmPBK0qWm3yDzQ3HFFUUAi7O7vlodaZ2cLBcJyz53+yelyqczlPYsNqKdecEMmdy0nb2VwMEKaceZefcDQbmdyaUWJ4PI84C9yzdv3Sm80lT+tKJeXPCyqG23QB+QVpYbTCy3JiQ7PXwuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9vBenYo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9vBenYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774953771; x=1806489771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ffHcfbGgLKBpupLjetwfxlJR2gTJ6pFpgYT/DXOY5xY=;
  b=B9vBenYo0HqC/1Qj9WxMkj5XjsSXhv0YeAqhV+FseFQrHUbmF4OZtPTX
   VHMOdVijMxArSPmuEnzVt9rduySIwQyjCvnwPcPz5S2qkvc4P7L2y0zPi
   yV4UZ3SxxgfWmloXrAEH3Gfs2aR3X7urWbXU78SjPu0NmgOL6evevyHdS
   xR2Cri2zXRbQLoR6u6duDLb4gNsLA8ewkaBgBxzep7RFNtGFwQaCKhaqb
   2YzO4EY3tiRFUreWnZ6+OGc+Z84xOArO7Bhro8tKYh3Y+6GWHfAzet/dg
   OrPF8frsiUHjcaiJdDGDY6q112dfp4n0DvvFJDXftbWS22QhNU9M9CIif
   A==;
X-CSE-ConnectionGUID: U9zrCrc/QCWh+6zUp98GXw==
X-CSE-MsgGUID: CfOlgsRwR2i2JBR5mVqE5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76154116"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76154116"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:42:50 -0700
X-CSE-ConnectionGUID: hslJ5wniQo2eYGvJlJVRPA==
X-CSE-MsgGUID: DgdrRFBSRyqnGkYuz1Rn8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221465491"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:42:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:42:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:42:43 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMNXrM5IUeEVySVtJwWeH+N5/cHR3rHvq1a4Y6HWfL6WxWA8Ocd22Y7NYvlDWt6xZHJUf/RCSEVw60Cn3gx1uZVd6NLzr6/ksJoZKxWEPJa4I0ZydDUyTNFPCsobI5APTrTOyBDsoZdHkWewRGXSweCt6nGV2ms/sQEB9pQFUPReT2hcpXxmpNj7Ef3Eank1ebPR1pMWAABtjyr30mq+o1zj1+6yFQqEx3id8pG7za/wARwzdkJjhmoiNmuS33gfHrP/5BX9Z5uQGwgQaP9mnNpJl2LxKVSV1OPmngZlKNG0JLK4XV81chwN48n+y1iYCM0FauU3uB+M5IraTZOi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffHcfbGgLKBpupLjetwfxlJR2gTJ6pFpgYT/DXOY5xY=;
 b=nIBffYyGwBVK10WVS5ZLi5dDtDvPtcRWLorOuaiDlZzZzmfnWZF1eYc5xrDTLE9ifvAmcitoIOTeppwa1Hu2xPZWfGh1LiKdVqJD+c+n3AQI/oHIIlgCI1YOLcvA803q7u0wvS7W9BDbbVff9lMdgZE+0WKvKLp3qug+2zCc+tmw3NSxchjcEsimeLhqMXSIrnNiEQoTWaLTjYZK6CRKAiXMWRjELOUooFCmLRQl+Ck3l+YzjliAJSGzdNN3fCWwxO9kU1hX5CjhPsvQpcpkuq88F7s0UaBaiDDa4EBjdrfKkWJkDK5R5AARicqfAMLuRtyi9rCqB9eSYBPQcl9ipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPF25FF87461.namprd11.prod.outlook.com (2603:10b6:518:1::d10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 31 Mar
 2026 10:42:40 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 10:42:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 13/17] KVM: TDX: Hoist tdx_sept_remove_private_spte()
 above set_private_spte()
Thread-Topic: [PATCH 13/17] KVM: TDX: Hoist tdx_sept_remove_private_spte()
 above set_private_spte()
Thread-Index: AQHcviZZF0bwifdwMUylhxiRlKRfe7XIeeGA
Date: Tue, 31 Mar 2026 10:42:39 +0000
Message-ID: <80fab8bdb1ed559850623e55efe6de8b836e9cfa.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-14-rick.p.edgecombe@intel.com>
In-Reply-To: <20260327201421.2824383-14-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPF25FF87461:EE_
x-ms-office365-filtering-correlation-id: 31813eca-aaaa-4b1e-2be3-08de8f123b39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: XFLAMd/JgxstaFCgJA+UuqDynIWhIvLvgxQtDC5sePKtJ5E6yTM7FEuBdavUYjt9AhnkqMGWdZDycyVl14DU3BjIscm0f3s5q1V9wEK3ojP2OpjRHlpgapGCuzomNpMZq3c2OE4cKAXB2dRgpWvNSyeWm6mn3IyOfttdBW4hsedmM8mss/c1fOaLx8DiO9XvkJC4IiugRZHJBVVC6/f1MtimTw09Ntr0wfp+4kT95ZkGcz+E5o+2seOWJLwoH4DZ1KHubSrTZR/20IryBQBl6Ncakg6imuHZ5jpzGljDSZRHrPDQRKl6mqRj9p1Pdqgf8LqDu3cVnx55rek8B5pfWXYoG6TlqHP+CNgS3szFA0t+NsZxrjgjIIthajZqHrA7JWtVc3COuq3mRe8gU2vieWsw7uS9TdCaiWHqxuJNqaNFSVTUiBTHdngskX8L6KelJlzlHKItHOvO8GxWuymY7UGG4/34wy0B6YZuuhXdZHj8rpal+t+kQCMnwhHYophmbGJJsYXxTSP+is7XLfMpJ0BeqTV32RXHAg626bf4a9L5n1Sj63GoYRw+0x7crDWoNdWXe8aiwY/MG89FENkadQ/fynw+RA1GNG01CWVng9JEmZeMjxAKk/R2D5gycmhIUTGQD4ArmA9zl70sH9IzGPZdb3xfVxOe+dgwWdWULLMXZh09CVN1liXq3sIWo6bU7B8Yq1DqywEvvzuAiGXaxDRyHvRRTAth4RkvMeRqw5IlSyIP8ZISQwHv0mMAV6hD5E7XibNB0GS1E8CRdtX89A9T7RbI4AWcbbDx6IlP/pA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2p5ZE8ySDVNTjdBSXludW94QlkyL2M2bkRVejdTRnY3a1JMek13NmlMelE2?=
 =?utf-8?B?STkrYUtKcXo2dVgvRytTMGdTbDNKUXdvRWFZSzlKL1BwcE85ckZnVW5zWHhm?=
 =?utf-8?B?clRxajRXTnI1dW1qTzZKODdxcUpmNU1ydWZIdmF6TzI3U3dBclYvV0R0Rjho?=
 =?utf-8?B?OVRMNjJ2VVlwMU9VWXIxUHZ2WkVwRVpPaHQweUJFdjFnZENzVmhvb2p2bjFh?=
 =?utf-8?B?dHB0Y2pPc3g4QUhJMG9ZdU9aRVVUUUJyN25FZ3k4VmFqdm00TGovSS9VUjJX?=
 =?utf-8?B?azFhTDdESVNLdTNBNW1tRVM1ZTJhMkJLNnVjWEZCeFZQbGgzeHZBZ3ZWV0dZ?=
 =?utf-8?B?ZEtDWnRiek52ZExtOHUrQkdUSzB2dDdKMXhlT0FuYTVkNGJrQ2gxQjZhWTVk?=
 =?utf-8?B?L0Q2eXZZRlZsN0ZJTCt0Y2E3RzE3WXhOb2kwSXRPVnVWeGdRVXFKeS9JQ3hj?=
 =?utf-8?B?Y1NNMFZUQm84TitWUDQyVm1rdUJ0Wjk3ZHROQStoTmllS3BTSkVXUzV6dGM1?=
 =?utf-8?B?b3doekZVRFdVczF2dFJJNElrQ3NKNmFOaStCeHdaVkQ3alo4UVdKSi92N05a?=
 =?utf-8?B?WmZ1aUI1OFpaQkpuNm9wbDF2YjI1YkRMTjdRUXlkcVVoZlBoWnhSRGl0ZzdB?=
 =?utf-8?B?aWJFdVZVK2RkcUN4YzdUY2hROHF2WVRBbWdTMkpGU0VZcFRRVDg1dEQ5eHJF?=
 =?utf-8?B?SDAxRW1KMGNJWGJEbnQzWEIyM09RclNLOXFQOEtDdmNoWnB4bE5LTVg3bGl1?=
 =?utf-8?B?K2VxaWE4TElBeFlvTWluM0ZwWGlpaE1ONnhqdGpDdFoyczhOOVFWSHFScndV?=
 =?utf-8?B?V05odEZJUEt0WFVnZTNZZVRSNzluVTQ0eXpIdU9XemY2bmVteXp3RzBnWnVh?=
 =?utf-8?B?QVFvUXF0QU9hWXBIVDFiQ2NaZUZEQVlZRWZVaEJtMEFsRjcrL0x3M2tINzJR?=
 =?utf-8?B?TFRrNE5yRGhsR2FxeDlkVW5Jd2FOOWpsU3F6dStDSDV3ODVWTXIvYkxvTHRF?=
 =?utf-8?B?d3dTQnBTSDRDSktEcWVZRmtLVmY3dzRoMlNtOGpvRjFBNWRTSWVDWm9vNk5s?=
 =?utf-8?B?QmZsWlkzZDFVOGFkSldxSlgvT2pmWlJGRUFIa2E5N2R2cTBJb3NjMW85dWsx?=
 =?utf-8?B?THlONG93NlllMWxFMXNrSCtQQjMxOWNTRzdBRktXdVNmdERQQTRtcmRWRG8y?=
 =?utf-8?B?MXVPNGpOYnNnZUl2NU04S3B0NCt4cU1XSk84dTV2bWNtUUZSMmJDUzV0RVlv?=
 =?utf-8?B?NWR5RlhBK0xhS01Jc25OcmMyYUxZcVNubDB3eWdVcktnUjhoaTZBZ0tvNTFF?=
 =?utf-8?B?T2kvQk9SNCtzNVpTUVlwOHpMVFFBaGxjakEwZkFMUmNxV2IyQ2dvOFdqeFpp?=
 =?utf-8?B?TU9paUZXTEIyMnhkTndpeExTVnlab3UyQlgvUjlROENpREVtNDdCRkpDeHZj?=
 =?utf-8?B?OFhZYkhlRWczZG1aVEpTVmw1SWJDWFo0SlVFMXcrNmNCWml4bGFUK0FnUXUr?=
 =?utf-8?B?MWx0cDhCTFBDNWZwTVM1RUQ0ZHRWVTRrMWczQlgwSTVUbk9DNEdLbEprVGIv?=
 =?utf-8?B?MW9PTW05UmlZckZQbDJpdGVmZlduRVB5cXZVbkl5Y1hzT2w0Wm5VeFVSbEJk?=
 =?utf-8?B?RjRPUzNvbzBxY0NPNXh2dm13VC96L2pjeTZmb3ArZGRsTFIxQXFKUktWclkr?=
 =?utf-8?B?YzZ3WEc5dFFtM3NvQk5wRkpaeTV6bU5IVE83b1hFY1dwZVBWbWsxL3Y1dGgz?=
 =?utf-8?B?YWlPWks5V2ZFUWxNRXRSY2JGRHFBc0FUTEUzMFBEWkpWbVV5ekl6UnQ2amJ0?=
 =?utf-8?B?d2VQaXl0OXZSeVJXVmp1bmQyM2xWZDZaRnN4MTZkQkhrcHUzQlhtYXZtcmd1?=
 =?utf-8?B?a2dGUEhmQVVTN3BxanNkRWJzMldYdkluS29qRkJtUzN1RkRnRXdXWWdlSmhN?=
 =?utf-8?B?aVcrdm1kV3lzMlFKZ0Ixd3R2WjM3Q245ZXpaZFRhMUoxallRZlNCb1d5RFMy?=
 =?utf-8?B?cXp6eXZxYkYrRkFDcnZmZ3hZby8xRnpBaXk2R2JaY0U5ZFQwUnM3L1ZQVmw2?=
 =?utf-8?B?ZERjSkxRMWptVDVZbXpxNEJVdUozcGxiUzI0aEtZWWQ3UFcwaUh1NVNaQ0lB?=
 =?utf-8?B?NmtYTGdheVJKK0MwajhnQmlSZ3k0T1hXMmNWdkZZa0N0endQaitGYkpWVWJ3?=
 =?utf-8?B?L2ZScFJZNHFVd1hUekdxVzAvL3FleGFUa1Frb0xMTmVTUzdBVkpWbW5KTnlL?=
 =?utf-8?B?ZzJYV1hvcGpSTzBBOFVyc3lDOFhLSFBjRlNuZ1gvV0pNZGFXc3JSazZmcWhC?=
 =?utf-8?B?UENJeUl3M3AzSFVQd3VGM0hRQXRGamdpSExKNGZLRTRLd1ZCSE1Rdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C2ABE1D716D544FB2DD45EF8ECB3B40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MiZ918a0hc41aYwy4MTZ/3eghrWWh+yDg3UHMeL6x9e1NZ17roX6i3FV/T5XJF+8rv0Zt1fm+HJvS0/BpwTwvWWjQbOPRv0zK//f5CH7wWbZLIXwSU8eEY4pA9bTpq4VdpuB4vsbz9YJV0M28JE5jp7eZ8saAQ+/LzGs3AxFUepo2s5o46N6UOVU4DZUFFVjp+gMszD8iuIzq9GiL5A3wlp8FCmGmZTqOsUz399QFd4IB0E31jpJdrFPQyN2cu6P6wPRV86yYovQjAy2jrgZGkMNs3Tpfdrw/u+wBZYNCRwE+IFGioJDCsMSR8WdX1cPxkI/azDNqpuiz9kJnV+wBw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31813eca-aaaa-4b1e-2be3-08de8f123b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:42:39.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjga4qpw+mjxkJnn40A7LDc9aChYNh8gRFIbkyLM90bEbt5SjCReqIOYPpHSyLCNNYZJVq44gXiFBz9H5hTs7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF25FF87461
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDEzOjE0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gRnJvbTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPiBN
b3ZlIHRkeF9zZXB0X3JlbW92ZV9wcml2YXRlX3NwdGUoKSAoYW5kIGl0cyB0ZHhfdHJhY2soKSBo
ZWxwZXIpIGFib3ZlDQo+IHRkeF9zZXB0X3NldF9wcml2YXRlX3NwdGUoKSBpbiBhbnRpY2lwYXRp
b24gb2Ygcm91dGluZyBhbGwgbm9uLWF0b21pYw0KPiBTLUVQVCB3cml0ZXMgKHdpdGggdGhlIGV4
Y2VwdGlvbiBvZiByZWNsYWltaW5nIG5vbi1sZWFmIHBhZ2VzKSB0aHJvdWdoDQo+IHRoZSAic2V0
IiBBUEkuDQoNClRoZSBkaWZmIHJlYWRzIG1vcmUgbGlrZSBtb3ZpbmcgdGR4X3NlcHRfc2V0X3By
aXZhdGVfc3B0ZSgpIGRvd24sIHRob3VnaC4NCg==
