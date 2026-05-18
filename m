Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5615A85A;
	Mon, 18 May 2026 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143360; cv=fail; b=jhgFwpR2S6CdMlZMQJzhBPthcNKzbPzGTF6lqc9jYeSWPbK8lwWwz302X5te0LeDaej48T11X6qF/GDfVgFMXqvUxHwIFFbWwoZ/pnsLo1hxLZmviwL5Jx3AiIQwdMtGpYLKhP2gwRhNXjaKgIzT5wntABqikma/vV4j9uwTPeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143360; c=relaxed/simple;
	bh=cJpvTSV/9qB+uJyOBYqdLx2dyXie5tW8V/8nzdXI2ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KiLAJ6AWttGIsUFiiKAv3Jbm0iMJNk5IJxgBYV/lASi9Apw7tFWGqDpWwbXN3212qCRVftPifvCTuqqfm1HLyzo6RGqUF6PAr5TOGySlZfi8Sut+gFOO5ASwzMVsHqS8GNa8O6DNbc+6e1uUWzRVMY97q+ET4SfzKmLNc8y7qeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmHRBv7y; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmHRBv7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779143358; x=1810679358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cJpvTSV/9qB+uJyOBYqdLx2dyXie5tW8V/8nzdXI2ow=;
  b=jmHRBv7yqFfWzV2wrGX6RkDdrwkICNvLSoOCBUqnuQixGeDaZgXvVl4f
   8R5Wph6mwspi4EjuMeaJkQyYT2TyGZNAGvwBblZnwBUfGRUQXJQAowHls
   5dtpI2Jpxt9WAdJT1q9dWUQD5Ob73Kgu9liG/PNfQh0zU3OGX9B82pRU6
   M9aHa58yfTP3d+gaX9guKXUcpV7lDvCNX5IEAh0b/ZkgtvbCqrydQ4f2+
   qaVUyJnRKcU1CoEMgsU11ecMjeovjo8NpiaTmYLpRwUadcNRHZRKPrb82
   NOFSQ1l4dMM9D6KpILbj6+yvAyPcB+C1in0mjT/9kAJG0kEpTOQDCp4Ze
   w==;
X-CSE-ConnectionGUID: DmVjKZKFT/62tPiyg21+Bw==
X-CSE-MsgGUID: IzLMw7brQ+e0yDlvSbObtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82576446"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="82576446"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 15:29:17 -0700
X-CSE-ConnectionGUID: oMiMnUrTTf6E5Pd89j31bA==
X-CSE-MsgGUID: na4mkDAvQpOvjqZ/WU3tpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="235120864"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 15:29:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 15:29:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 15:29:16 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 15:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4uCOMS629DgnV2qrSMASeIFBjCJlni5TO/WfvQqRewMFsBdVeVE+a+mypV01pYRKjXK7zHf+6Hga9erXEoaBcnowSs1lyAOa0QfOwvWpZzghQwmOFW9k6g9aqmX98Bn/XdasL/NKmtl31aosv3XakJpS4lT5ez1xqT7jDyJQEKLYHZCqr8dxoLASHapYRthd0umd1BLaX2+nVS+l75fGgY/f25/hFHzEXeJwM8J4jyo/dC9I6RuBxTSVYLrllZp2X8x1Y5NfBCtOyVqfQF8wU3MFarW5Ky2aQyN16kk9FKm3xhEO9qXEIBwgEU3rvRc00pyynurodxcOkhk8Mmp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJpvTSV/9qB+uJyOBYqdLx2dyXie5tW8V/8nzdXI2ow=;
 b=NU9p3A24gCU6IUPCHN0QtqOjiTJqRCuG0E1eaf1aWJVuPKWwKBkQBUdxEg15k1S0fw+D8qh5FEfLpymok2NOamPHLmNlvNyHM5BOk+neG4MPC1itcmh77kSBx8plc6OeB5gYO175XEpvwuF2mBz9LI5Z2zDLMp2tYu+e6bhAGS7ACWXYYoTw7iwi6C3mRwRnnbaom+1V4YtWKfE5jqkdIC/cvR30QrM/l4gvugMqU5rFvHtiZ3JDtbe1W6pp82W9BKJMV/EHARbrOIw+9rVnyxXoVmvgxMMp2CXKZoyIENfhkUGjZOs1V/G+SfqoCFNDNv+hxp3ClYs61QcUjBU+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Mon, 18 May 2026 22:29:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 22:29:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"paul@xen.org" <paul@xen.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Topic: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Index: AQHc4+w4CBDzoNQQUUKvPHLypz96PbYTq8CAgACchACAABtZgA==
Date: Mon, 18 May 2026 22:29:05 +0000
Message-ID: <e7a99198288bf47f457c5b3e550ed8221eddfd06.camel@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
	 <20260514215355.1648463-9-seanjc@google.com>
	 <136d277dba2ac681ed7607a436f55e2fd1975ec5.camel@intel.com>
	 <agt7vnVL5rJJUVzo@google.com>
In-Reply-To: <agt7vnVL5rJJUVzo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ0PR11MB4910:EE_
x-ms-office365-filtering-correlation-id: fbc8e652-1b8c-4582-d412-08deb52cdec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|38070700021|3023799003|11063799003|4143699003;
x-microsoft-antispam-message-info: qUjOoyr93KCOVVIhS0UgvreDhdcfOjIamg3dJ7cnzgKcP1dGuPaRvpJo8nEs0B56Tt8803LAuc2eLSjrMlUXlfmRpypBLbbjsZBoDDx06HwIWh9WW1WOPw9sIrOUh3H2K4L8b1NT8Wa2xXnc9967rpzmzxsYoYvPnqMHD+Ifo2dXIGLgYvqa2YTEUDRFOFG5S4TXwa3mqwmUpZ+Ik3NE/HwylbPm/Y3xxiusivJpUqfCOnbyNo8hucx38y2RYrLlE49nbnlA4gl7R06bYr2DsvwPscOuK7Dn4QyJnrDh8/wUMJYRdt0NII2xw0aEpuC1hid6ZVS7+AeKe3jj7eKVsz88e5vRm9upyhUu5yA0y1DM/Aso13QL0NcpF4PBZWji+hVRlt0C7IZkRN7EtiZDiFs7GWh+u6duEWIjQwzqWmyQF3UO3NeOm6h44yAiRlIDejUM+tb6L43li2+bkQyUYE1rymEyg5ZgCvEhWbIeFCiC6QK1tOK9JbL7udJWJW87Emn1KsRUmwPNPBCbU3eazEkuA93jPJiPGs1fqSZEUZ9PyEGArm0iiAnmSGfdg1W680ahLFeCUYc6UuBlBRW1JD2Ic3Li6vG6/47LZaScI9KTPIIAnzIRJKdACDJyHBhOmScryjf2t039Vx3fJcQyQ79sabwzX7aJ/ldlS96GA81oHj1GhIs83sJ6Fm8hqjr8ZndGOJvKLMc5KK4rkecvSuWOgHzQhFgHLCgKC2YFct+FqxfN8GVodwLTwV9+y5CY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(3023799003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmlPQ0FXZ1Ayb3B4WCtOSUVNbmhpNkhNRGw0bkRDcC92QjYvUXlUc0o2bUVk?=
 =?utf-8?B?cGRoVklDY2JPUUtRQUc0bmhuUU1weThIS1FNOUVjQ2QvckZKMFB3U3JHMlpP?=
 =?utf-8?B?ZTRkdWVRTXFUSzcxRHZHMjlPYkoveVZYRjEwelVuWnBoaTIvMXg0a2RWRGFM?=
 =?utf-8?B?Sk8yVG50KzFYQ3J4djVXN29NYlIzY3F4UWdoSllUMi9CTWNEWDJObVNpMDVt?=
 =?utf-8?B?RkRtY2lBVlIyTWg4RFphWE5IUmM0VWZzcSs3R0lUd2FqYVFseEF1VlFOTXJa?=
 =?utf-8?B?Y3RjL3VzdngxSkxVSkQxNUdCam9JcHFuVUY4azlxai9SMGo4emdHVm14K29P?=
 =?utf-8?B?NWtLazlXeUNZOFpnc2dGVExib2lSYmNpN29abThsSnFtQkFsZGtsQnhmc1lp?=
 =?utf-8?B?Ly9XamdQK1F6enJjNmN5djZYMStZQUk2SlBOb1BGVDhpUnorS1JvYWtVUSsr?=
 =?utf-8?B?T1VCVmxUYk16d3pjd25SQ2l2UmlSSkkzTVA2aFNjaFdXY1hHV0syejdDNm9Y?=
 =?utf-8?B?KytMRFhSNE5hd2pJZ2wvTHFpN3IzKyt2UTJsZFRHTlFoTDZYVTVyNFJyRFZz?=
 =?utf-8?B?ZlAxdnYxaTBTd1Z4cy93eE45MktKK2h3allER2toclVHZFdOWGVYSlQ1Z3Zi?=
 =?utf-8?B?bW5vNzZ4QW5KQTN6MlBvRzZMYTllRjVjc3R3ZGhoYkRQVFhFYmRub1E5cE1E?=
 =?utf-8?B?MFIraXFTdUxMNVFiZ0tDQkdCbjBvYlUwTE9MRzZ5NVlXSXJScXZFamowUVlM?=
 =?utf-8?B?aHM2YnBhT0l3S0gyQkpiRnlvQ05UeUsvakdxbldhdkxkTkVLU0J3alg3bkdr?=
 =?utf-8?B?M2o5ZEZQUnBmcU01VitOa0IwRXR6bWtjZ0VjL0p2TElJSkxGcmhLL2tQejBz?=
 =?utf-8?B?Y0hTUmV1bHY0RXZnenQrOTZHbWtxNDNKYW8rcFJQVkFNeS9oQjd2QTg0NTlm?=
 =?utf-8?B?bG90eTBEUytoWTI1NlVnb3B2aTVydjBwTmk4SGsxWW0wUzBIOVphNndUL2cy?=
 =?utf-8?B?KzY1cTNYWkRhWGdsNzZrT0cyNlBkWW8wUXpNaWZJYjZyTGIrT2hXOGRTNzNj?=
 =?utf-8?B?eDc3ZmtMWjFJVDR6MmMycmZHL05VZlZDS2lvYUZVUFhldjY2alhKWGRtQXo3?=
 =?utf-8?B?MzFBVmNDQVVsTTZBZ2JuMkVja05ib1Y2THhDdjY4V1pETjFiL0VZTFpycmlj?=
 =?utf-8?B?bWdYVHdGUHF2TlpQaXZ0bUd0TXlqNjMyZ2F4aEovL21vOXNYUkpzSm1IMG9t?=
 =?utf-8?B?dVo2VzNJdVNXWGR3ektCWXRqZVFRNDZmZDA2VTd2Z1l4NWZtUjVpZ0grV1lC?=
 =?utf-8?B?eldLQVQ2RlhOOVJ3ZjBZdTBUME95ZnZuYk5CS0d6aEVuRWJZMlprTkxFZnRL?=
 =?utf-8?B?SEU2V052eUwrRXUwWlpKeDZ1YXFrZWhnZ3Y4OXFtcE1JUmwvNEtOYjlBS1A2?=
 =?utf-8?B?WS9BZWRsMVliOGEvbStFdHRVVXFBMDRQbUJNTkF2eUVROURacUhrSGoycUFK?=
 =?utf-8?B?cGwwb0UyMTUvQkRjckdQSlBpVGhiMFp6Ly95TjdCTFBVSVQxWE8wN282aDBP?=
 =?utf-8?B?SzErRUxpNjFxTmxxdUk1RUpJanlMSHlldjhacEJ3aDczZDNWZVhMMWZlbFpv?=
 =?utf-8?B?K2hoSldON29PZTB4NGpINk1XQjNHRkhvMllNSDFTVG9JU2FjRGRLWk1tUU5a?=
 =?utf-8?B?ZFdsQ1Z6VGdMYmwwRTJodGw2a2tIaWJJZk1wazIzNlpIaUtFNGl6WlptaUFq?=
 =?utf-8?B?Q1ZrdXVNOER2V2xoTWMyYmo1dHFpTm5vanRFWld2eVFZQWtvQ1hPZmNDY081?=
 =?utf-8?B?MG55UTUyWFdNRkV4Wk9tSEdhbUR1ZnorM1pLb3l4b2lLRmhwcTY0TWdOSXMr?=
 =?utf-8?B?T3F2NkZVaWUrQitTcEhJb3Q2Q0lHT0JrRk9VQjc2bXlpL3dUbFlTMUg0dExP?=
 =?utf-8?B?TUxPTVpZVldEWFIyMmpwdDJZVEt6Wmh2MnhzWlJHdnNOUzBibjUrcnI0V0Fu?=
 =?utf-8?B?SXZNR3Y5MkhQd1hERlc4VFJEZHAwRjNLa2hDeDA3T2JXbGxjaDZGOUtEaVR6?=
 =?utf-8?B?QytjVkx3aUo2T29rQituU0t4NXFoWVNaWE9XK1dVRzJ0Qzl6UTF3NHhJR2VK?=
 =?utf-8?B?Tk5yTWo5QnU1K1Rwb0hwUGRWVHp5S011MjFjVm5xSjdvNmRTSmsySWp3blpJ?=
 =?utf-8?B?d1cwamtMRmpNaXI1c2pUVnhVL0FGVFIxUmxOTWd2T0Z5OGl1dkkxSE9CRmNx?=
 =?utf-8?B?MmxzbjVjWmJ5akhWL0lRRTY5T3UzM25jZjk2Q0h5MXRjcEFLU3NrOENsd2wx?=
 =?utf-8?B?aVdodzdySTN6elAyVWpXSFM5UStyQm05OU1yTVM5cDNyTDFwSXMyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4209E20142057644BFE4127F9AB8D11B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XO7JS9zp2m9vR7J48HUKlIil0nWw8D9GBwBye53WIbKv77c6CauoH3ioOYOu0UQBQmtAh4+f8nsF5QnJ5+ct5jgp6Iu5yWvYJo/FQLyloCVagFmmhxKk11OviyA9JZCqu1gdkrlbtNS1Xjg1Jj+nnykdbaLJjkeiUa0qRrzSjWJzJTuoaCzog1/EjF7LmvNK5aLwEXDyJc/0yimqtQIo5Evgp/C4Hc2SrWD1+tPeam+Dbr+5gbtv+WDT9235U8f0qAEPCxvT11Gdm9zYvwVTRP6A7JnURc/qYz0NzXtn8Y0iTkeDmd3YCBFMo2R+ZhyMK8JpSGtRJLa2xcXU0x4E2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc8e652-1b8c-4582-d412-08deb52cdec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 22:29:05.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9v6MRAeeUUFXJUdOfPr+DmwoQx9NiFiSmMHT+MN/Y1R1/q2lnr/nR3XaZwTJCxlwXKIUhs2j2IdEdjmPI6uaEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDEzOjUxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIE1heSAxOCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IA0KPiA+
ID4gQEAgLTEwNDEzLDI5ICsxMDQxMywzMCBAQCBzdGF0aWMgaW50IGNvbXBsZXRlX2h5cGVyY2Fs
bF9leGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gPiA+IMKgDQo+ID4gPiDCoAlpZiAoIWlz
XzY0X2JpdF9oeXBlcmNhbGwodmNwdSkpDQo+ID4gPiDCoAkJcmV0ID0gKHUzMilyZXQ7DQo+ID4g
PiAtCWt2bV9yYXhfd3JpdGUodmNwdSwgcmV0KTsNCj4gPiA+ICsJa3ZtX3JheF93cml0ZV9yYXco
dmNwdSwgcmV0KTsNCj4gPiA+IMKgCXJldHVybiBrdm1fc2tpcF9lbXVsYXRlZF9pbnN0cnVjdGlv
bih2Y3B1KTsNCj4gPiA+IMKgfQ0KPiA+ID4gDQo+ID4gDQo+ID4gTml0OiAgQUZBSUNUIGlmIHdl
IHVzZSBrdm1fcmF4X3dyaXRlKHZjcHUsIHJldCkgaW5zdGVhZCBvZiB0aGUgInJhdyIgdmVyc2lv
bg0KPiA+IGhlcmUsIHdlIGNhbiB0aGVuIHJlbW92ZSB0aGUNCj4gPiANCj4gPiAJaWYgKCFpc182
NF9iaXRfaHlwZXJjYWxsKHZjcHUpKQ0KPiA+IAkJcmV0ID0gKHUzMilyZXQ7DQo+IA0KPiBObywg
YmVjYXVzZSBzbmVha2lseSwgaXNfNjRfYml0X2h5cGVyY2FsbCgpICE9IGlzXzY0X2JpdF9tb2Rl
KHZjcHUpLiAgDQoNCk9oIEkgbWlzc2VkIHRoaXMgOi0oICBzb3JyeSBmb3IgdGhlIG5vaXNlLg0K
