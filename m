Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4030567E;
	Thu, 28 May 2026 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007444; cv=fail; b=NWXKZ2AsmmbgOzipfGQ/0pWI3UMasmmXMfoGtKUzqBMtzGXztkDUlCCMrB7Ckj+C/rvEApsOH3WP8FU2OVIEJpcHdnR/w8VQUCsrJ151FIsOnKeJNFtqOZMAus8nFuExxNd+auEkRTN+HsXVLrgMK4NYPI9CqgOgy7zWH6ofXsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007444; c=relaxed/simple;
	bh=CAx5Z4JhW+Ue7s7R1pJ46O/G7ol7UaM+TqaDhs9lHxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCsKlu6vg2FGOYCf8VKkJVsx3t4BeSu9VQGlgqg2zhlE0LGldAecxrwqdWwOio5piOKa/Kqo5g7+hgF1owLQFw5DeuIvoMIcw+JOF5Khx7hvzRhFoiVhkltd1NrwkWp3kxKrrfmbswIu4HkqoM/G2hZ9d0dzgOP11yigsKA+dZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2nLT21P; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2nLT21P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780007443; x=1811543443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CAx5Z4JhW+Ue7s7R1pJ46O/G7ol7UaM+TqaDhs9lHxM=;
  b=J2nLT21PVBfcVtvzTqzf+H2EIfWul5uiehlgaAJYT9XZEWYmAa4AGiRG
   w6HPPQD4zNMTFhoqh2t+bwl7/tNnei3LqPUx+JF9PMvu1ECobhmWysVS/
   /ZQFa7kmRk1NL4fDDSnqXSSZp2kfpKeRsCCGXD7wjdbUqzZ/qGt0rbPn6
   SMmZ7a+DjA0yKiNIcaLy9Fs1x9K583mv8REDMb4P0AfZli03i2yyNOUGf
   q1mE26xXlTZdC2vbEac3sT8wzHQnBh2EBo6pnw+FFwDoVYsby96kekN6C
   p8jxKy/HmOGEs4gyx5ESw4fK3BVZY/2ERk97E5s6qo/YpJ9O6j0m063ME
   A==;
X-CSE-ConnectionGUID: uEvu9bNwRiGuBneEAeys2w==
X-CSE-MsgGUID: SxNOVzUCTByrbeWht4Xhng==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80006256"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="80006256"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 15:30:42 -0700
X-CSE-ConnectionGUID: LkP0b0ziRhGULq4959TXWg==
X-CSE-MsgGUID: A9eKWj5MT82tfMIyYKKCOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="244494964"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 15:30:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 15:30:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 15:30:40 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 15:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byrR9fr8hsuor//wSv7YXOc0OgDtGdKBjhEP1kYubgFjsw0ISSlBh3m3C6ATmKBIAwEkNBGU1JTis7LRmhcf/z0PhgZoQNYkYY+2/zfxPiskHtG4vdpYNGZ0H/BmQUBdIZVXeKYOkH0qyF6BBA3dM+RSupUS0BfD6vnUTFQ5TF3Zj3B05iDfc3jNyrStst2eV6bbjzRQ3kVwOkMjfQWOn3PFdWAMw6pyWr3lGSqD/oyUzMAkt/K06Q9VAUYlJUkIlXRx9SmsVNIt1RmnCJb7YufwNv1lrdSwuaD8LW9rzA2vc2vBLxJJQ7eizPNqhVVMXcrnK8QpPRuLBdNzGmvMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAx5Z4JhW+Ue7s7R1pJ46O/G7ol7UaM+TqaDhs9lHxM=;
 b=D9YB4aKQXoS1zOOSQTDwqhRtnvxf9fNcExcVZDXiLe3gtczKNeAbJR5dxO1c9mCoMGMZIu6RlVZe6RNwLnQijZrtCFMy8OTOTYHFN6OZ6PQDJRNCEn9c+vDljdn9aqp8+4SeJ6WJYJqs8bSWuxScDJArYnY3Sj/i5FW3wu1c3NwoDbeAoRMt/mpD52lvPxehJ3EzuDbkmLBcbHFgB2VjswAF0RcDBAcnRp8zfi8M8HXIeHMlykjqu11B08Pkv6DBals60rBaRUVDLgIsBRgdhUbun1cVtBHFjoFrSO+xjYmDKUrO65ppKnnIlw+lQV/EtBLJNCJmj90zwszkpWAgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:30:36 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:30:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"djbw@kernel.org" <djbw@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 07/15] x86/virt/tdx: Prepare Quote buffer during
 extension bringup
Thread-Topic: [RFC PATCH 07/15] x86/virt/tdx: Prepare Quote buffer during
 extension bringup
Thread-Index: AQHc6aBE3MoVcktHgUml4yc7eqNR+rYkD/OA
Date: Thu, 28 May 2026 22:30:36 +0000
Message-ID: <1a4d1126d6fe86e94fa8e1de6764656853e61106.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-8-yilun.xu@linux.intel.com>
In-Reply-To: <20260522034128.3144354-8-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY5PR11MB6163:EE_
x-ms-office365-filtering-correlation-id: d6063160-d825-4824-a75c-08debd08bcfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099006|6133799003|5023799004|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: oCshcX67qnGZL610wLOAkwT6O+J0YRFf4BL4Kkz5DUqUuIE5TLmHxK2G6ZD9MfW/UyGSqqcgIZUcjogEOTf+fEEIi+zDq5y+xOKpdb4KBnUph5W1ko76OQng4+81LO6fWFfk37KzOu5/+N0cPUpubYG+a/4gDB8SFGFpvkO0Z66AtwJtUIccOBMUwUatSpv3FStyDxW5OpK6Ji4tlnidwH2oTSds91q40ttMAlDXA70QmA8fLhiETZCG75zEdI2rBIzQ6/W3s+Jw2T04Cww0Wu/UhCahZasGphKWjtn6bwZSSTZqH3cfi2FVsp3g7x+QunE3YbaOJ8F+mZZRSJ6Th87vua5b/gArPOxiAMO3UiLG934IrpjJBWLidSKcNJ4HjmEG2zzstQ0VpYUBb/zDA6sVPJlmXu+w44I0bgSe0x3glBeggvRbzVzSlPrArcSI7+0BeRF0muJM/FwOVPr7kmSkcsES71OaQVMMZXQDBFbRcX8R0KEwKkTmvIBFU3D199Ta2YDiLQPsDnY3oLtt2wIOkX/ovuPQkwRlLtHxqF3OvDv6g7POQDcTxi0eH05PsF+xnbK8/icv6/Gx4sPUBbV3hLVBsCjfhNh4X/GU0H9HrV5YBsAenj0x1hWIYLGbP53ssFckp3dq862DXjOOmr8PEK4Ah9hyclbauIi4HgdM7WZgAOb1fWf/o5FOhIrGgZEbSjxjhnhXPozU3IJ2htnwbxd9UgQ2hWG+7xC+EQH5Xmu6VAYbBxii0kLRFhmU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(6133799003)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVpQcFphQjRobnpCWm55L3ZHeGRHVkFMNTZPM0hVaHBIQXVlTEJKUDhQUFZL?=
 =?utf-8?B?RGVJSDlTK2F2Vk8weWR0a2JtRC82ZkRPaU1tR0tmSVdPaXRpMFhRdFB0ODBC?=
 =?utf-8?B?TlV4YnNGVENPUldrVUhka084UUI1MU5YNkVwR0FacjlyZENTOHV6WWpEbzYr?=
 =?utf-8?B?Y1BVeTUrRmNwdGZoTk5mWEJaWW40WWg2RXF1WTZDNitpQWpFcklkNkhXOHVy?=
 =?utf-8?B?aC9qeHhrd1ZZeCtiU3llLzNmWlJ6Zlo2REJ3S0w1dStUTzdXaWY1NGVTdzk4?=
 =?utf-8?B?VmVTTVJ2YlM5ZmJGVUptOXdHMTk5T3ZzMTU2R3ZBNmhXSjdHMkNOcXp1R3lO?=
 =?utf-8?B?bW5ZcHNwZ0NKd05jRVp3UWd1Wk9qeitXR0VtN0RoZE4zUU1HSEpSOWt5TDl5?=
 =?utf-8?B?QVRjVnI4bTY2MG1CZ0V5WlF4OHZmNFRCYkc5L3Nia3BHblVRN1IwUjFabnRr?=
 =?utf-8?B?aFlSNTEwNUF1eklnYW1sWjN6cCs2RGk0TUt0VFhiSHp5Yi9uN0tJL0hsRDl2?=
 =?utf-8?B?Wm9keUVINDY5MGdBc3VSQXZLT3RteXovTlR2SFZ0U0xvV3V5Ylo3RWlBTXFo?=
 =?utf-8?B?OU5GOUcva2NtS1FmWjNldDBhSXR1UWVEbTdLQXNySUM1UmpFQ1JHRU84M2lI?=
 =?utf-8?B?dFYxUHZNbFNIUndRNnpFUzcvTmk3NHkyYWZEbmRFaS9sRVJhYTM3dlhxUTNw?=
 =?utf-8?B?NWJ2cmphZjhHTjUzdDl0SjNmdy9JQ1UvNjQrUDBoVC9EeERyUHdGSzZIaGJX?=
 =?utf-8?B?ZXIvejIva2dDbndVaktZZFRnY3V3YU5wZUF1YU5IZUd6UURraUM0aWs1WjNW?=
 =?utf-8?B?NWVrTFhFYU9EYlNqT0l4ZTVXS3JFWDFZaW9oanJmQVErU3dNNkk5NjEvODYx?=
 =?utf-8?B?azh1Q3Y1N0lkdXprN2NmTUhUcDVDZ1pIRVY2MXJuKzJvSVRaODJFY2J2THRD?=
 =?utf-8?B?bElXQ005aCtYVFhFeUNvVUVjZk01N215UVNlZUNNVEI3OWdtWm9nNzBBSFoy?=
 =?utf-8?B?MjJyeEVxbHQxRTU3UGxFS1dkWGtaZkRnUW1aeXNiZ0l5cDZRUmdyNXJWaXpm?=
 =?utf-8?B?VXJYKzh6a3BpemFBcTIrY1lsdXJBaFVjV290S09TZGxxV1pucXRXQTZKNWZT?=
 =?utf-8?B?ZHpoUkNWMTRuVjZWc2ZFLzh0SmlONnNITXk5Vm9ZTzlFaHI4c09VYWY2ZnJB?=
 =?utf-8?B?dVR1QXk2ZThBVVVIak5aVzQ5L1UxcWVIQ0o4eDJwYVZQMWd4MklDd1NlYi9o?=
 =?utf-8?B?ODdxcUtLb2FxSVMvSDM2ZWdSNHFaUUhDenZlUXFHN0ZyRDBnVFJsRUpFektw?=
 =?utf-8?B?NHhIbzRraG9NN1ZtdThmcUhscUVZd1VSY2VwMy9pU1RaMjVkd0pMUnR5blJF?=
 =?utf-8?B?QXV4WUVLT2tZSG5lNVRBeWg0T0Jqc1A4UUZ5VnZ4NEdQamJBdDVwKzczOVYz?=
 =?utf-8?B?aXE3SjBSZ05Lb05OU2dRQ0RReXZ1bWNlS2F1ZnVvdGRvTnU5ZmMvUGxSQ1l2?=
 =?utf-8?B?cExiUnU1amJtTDNQK0RPSjJGK2c0U3FGd0NKMVdPOWlqdVBPRkxFWEZMRTln?=
 =?utf-8?B?S0VpdGVzMzhQcll5OElHcUY5Ti9DS1cxclp4RzRUVEZ4UDlMRG03S0pUQ28w?=
 =?utf-8?B?WXkvejZHdU11czJndVdlazN3RnREQ0FKTk8wNENuN0RGM3RKUnQwd0tYMklN?=
 =?utf-8?B?Ry8zdENuU1JQaTJrbkdZTEtkcllFOVMrb0JES2ZtYi9jSXFWZEN4elNqSTNX?=
 =?utf-8?B?dVdrS3JmazczUkwzMUh1YmlpWlJ0bXpPVWE0cm4yeDVBVVBId2JoSkVqN1Fw?=
 =?utf-8?B?U2E0KzRhMVpGYTE0Z0pRdzdqa0ZVcDZyMXNBcG5XNzJYWHZVM2dOdUFUSHY5?=
 =?utf-8?B?UzI5dXBCWU5XbEVhK0NEeTlOaXBEaGVERm11ZWNEdjBRVzZEZTdUdFdYSHZV?=
 =?utf-8?B?U0JtQndzQmREbVhqSWprUWlWWE5iVFUwVFNieDZlVVFyUURGZXV3L2kzZERl?=
 =?utf-8?B?L21HWXlrRjBRZDlkZStwaHRaM0R0bWhrOVhhNE1TejVOYjlJOWVTU01jcEls?=
 =?utf-8?B?S2R3eVV6ZGtWcjExTGs5RlFnRWk4Q1pVNFZBWkh5eXR6cmhKay9wbkhJSlpI?=
 =?utf-8?B?Z0dDVEdTa2VKL0JyZU1NMVZkZzg1dC9XZm56WFhKQVpZU0FZbE1VYnlyTzlC?=
 =?utf-8?B?U1RidmsxbDhyNnFXOWFKRHZGOTZwUW9qNzl5b3hXNmhpeFpLL0RGeUMwRHZB?=
 =?utf-8?B?bTFHRk8rYkpEZkEyL0lXMi8wQ0lEbUVlUkZoVlF6bjNyNzRMcEE5N1BhSkUv?=
 =?utf-8?B?VHM5dGRWSXNpTnBJTTlzY1liVi9tM0p1SDl0WkppaEFLbXJObHlwQ3Nsalgz?=
 =?utf-8?Q?E70Ekm9H8yQYFkLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <171D50B8C4B8EE47A564FF533754FB03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O4gvEUSF/mr4Qs94iWbdhc3OpKL/qNPxKjSyVvVgycwOmCuZoNK+mnMxt99ix4queChtJKm8wMSIrgR/HM5phJxfYen6ANkGT2n/Sxr7i0TiDCNB5eh3PkrJwriiTLW/og+TT2h7Shah1zuICNDnjHrtcsGuSTDf1B1H7rV652ZIPMG+1pEjMICA3pPBMccnnbQKpMJ97EW2BzmuL49CIoYkCo42gJwo5b1kgvOYskw4AYKzL0MpitkX+f2a6ST4BP2S9frmOcc6bBCl5GA1KW42/zXN4oS5jurceko+5XFSpUNadbS5TMCi8XvaGP3vdOY+EgZ/8Yp0WcAjqpbOlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6063160-d825-4824-a75c-08debd08bcfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 22:30:36.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qgzZgkDdKEz8eg+8G930akMpa2duJyVxhaIqOCnsICECkN/Olr9VWJjk0j0IOcolF5po6IuIoJGTsw11/8jwiu2ad5Fk1Z+nGPaf4PY9+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gRnJv
bTogUGV0ZXIgRmFuZyA8cGV0ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IA0KPiBUaGUgaG9zdCB1c2Vz
IGEgUXVvdGUgYnVmZmVyIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIFREWCBtb2R1bGUgd2hlbg0K
PiBnZW5lcmF0aW5nIFF1b3Rlcy4NCj4gDQoNCkNhbiB0aGlzIGJlIHB1dCBpbiBjb21tb24gdGVy
bXMuIFRoaXMgaXMgZ29pbmcgdG8gbWVhbiBub3RoaW5nIHRvIHNvbWVvbmUNCnJlYWRpbmcgdGhp
cyB0aGF0IGRvZXNuJ3QgYWxyZWFkeSBrbm93IHRoZSBmZWF0dXJlLg0KDQo+ICBCZWNhdXNlIHRo
ZSBRdW90ZSBidWZmZXIgaXMgc2hhcmVkIHdpdGggVERYIGd1ZXN0cywNCg0KV2h5IGNhcGl0YWxp
emUgIlF1b3RlIj8NCg0KPiBwcmVwYXJlIHRoZSByZXF1aXJlZCBtZXRhZGF0YSBkdXJpbmcgUXVv
dGluZyBleHRlbnNpb24gYnJpbmd1cC4NCg0KV2hhdCBkb2VzIHByZXBhcmUgdGhlIHJlcXVpcmVk
IG1ldGFkYXRhIG1lYW4/DQoNCkhvdyBkb2VzIGl0IGJlaW5nIHNoYXJlZCB3aXRoIFREWCBndWVz
dCBzdWdnZXN0IHRoaXM/IEp1c3QgdGhhdCBURFggZ3Vlc3RzIHdpbGwNCm5lZWQgdGhlbT8gSXMg
dGhlIHJlYXNvbiBqdXN0IHRoYXQgb25seSBvbmUgaXMgbmVlZGVkLCBzbyBkbyBpdCBkdXJpbmcg
Z2xvYmFsDQppbml0PyANCg0KPiANCj4gVGhpcyBtb3N0bHkgaW52b2x2ZXMgZGV0ZXJtaW5pbmcg
dGhlIHBoeXNpY2FsIGFkZHJlc3NlcyBvZiB0aGUgUXVvdGUNCj4gYnVmZmVyIHBhZ2VzIGFuZCBh
cnJhbmdpbmcgdGhlbSBpbiB0aGUgSFBBX0xJTktFRF9MSVNUIGZvcm1hdCBkZWZpbmVkIGJ5DQo+
IHRoZSBJbnRlbCBURFggTW9kdWxlIEFCSSBzcGVjaWZpY2F0aW9uLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUGV0ZXIgRmFuZyA8cGV0ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFh1IFlpbHVuIDx5aWx1bi54dUBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5jIHwgODUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4
Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gaW5kZXggZmI4NGZiNmQ5NTJiLi45ZDA0MjkzMzk0ZDcg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9hcmNo
L3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTMyLDYgKzMyLDcgQEANCj4gICNpbmNsdWRl
IDxsaW51eC9pZHIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9rdm1fdHlwZXMuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4NCj4g
ICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9zcGVjaWFsX2luc25zLmg+
DQo+ICAjaW5jbHVkZSA8YXNtL21zci1pbmRleC5oPg0KPiBAQCAtNjEsNiArNjIsMTMgQEAgc3Rh
dGljIExJU1RfSEVBRCh0ZHhfbWVtbGlzdCk7DQo+ICBzdGF0aWMgc3RydWN0IHRkeF9zeXNfaW5m
byB0ZHhfc3lzaW5mbyBfX3JvX2FmdGVyX2luaXQ7DQo+ICBzdGF0aWMgYm9vbCB0ZHhfbW9kdWxl
X2luaXRpYWxpemVkIF9fcm9fYWZ0ZXJfaW5pdDsNCj4gIA0KPiArc3RhdGljIHN0cnVjdCBxdW90
ZV9kYXRhIHsNCj4gKwl2b2lkICpidWY7DQo+ICsJdTY0IGJ1Zl9sZW47DQo+ICsJdTY0ICpocGFf
bGlzdDsNCj4gKwlwaHlzX2FkZHJfdCBocGFfbGlzdF9wYTsNCj4gK30gcXVvdGVfZGF0YTsNCg0K
SG1tLCBJIHRoaW5rIHRoaXMgc2hvdWxkIHNlcGFyYXRlIHRoZSB0eXBlIGFuZCB2YXJpYWJsZSBk
ZWNsYXJhdGlvbi4gSXQncyBub3QgYQ0KY29tbW9uIHBhdHRlcm4uIEkgZG9uJ3QgdGhpbmsgdGhl
cmUgaXMgYW4gb2ZmaWNpYWwgcnVsZS4NCg0KPiArDQo+ICB0eXBlZGVmIHZvaWQgKCpzY19lcnJf
ZnVuY190KSh1NjQgZm4sIHU2NCBlcnIsIHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgKmFyZ3MpOw0K
PiAgDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgc2VhbWNhbGxfZXJyKHU2NCBmbiwgdTY0IGVyciwg
c3RydWN0IHRkeF9tb2R1bGVfYXJncyAqYXJncykNCj4gQEAgLTEyMDUsOSArMTIxMyw3OCBAQCBz
dGF0aWMgaW5saW5lIHU2NCB0ZHhfdGRyX3BhKHN0cnVjdCB0ZHhfdGQgKnRkKQ0KPiAgCXJldHVy
biBwYWdlX3RvX3BoeXModGQtPnRkcl9wYWdlKTsNCj4gIH0NCj4gIA0KPiArI2RlZmluZSBIUEFT
X1BFUl9QQUdFCQkJKFBBR0VfU0laRSAvIHNpemVvZih1NjQpKQ0KPiArDQo+ICtzdGF0aWMgaW50
IHRkeF9xdW90ZV9jcmVhdGVfYnVmKHVuc2lnbmVkIGludCBucl9wYWdlcywgc3RydWN0IHF1b3Rl
X2RhdGEgKnFkYXRhKQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcgcGZuOw0KPiArCXU2NCBxbGlz
dF9ucGFnZXM7DQo+ICsJaW50IGVyciwgaSwgajsNCj4gKwl1NjQgKnFsaXN0Ow0KPiArCXZvaWQg
KnFidWY7DQo+ICsNCj4gKwlpZiAoIW5yX3BhZ2VzKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4g
Kw0KPiArCS8qIFRoZSBsYXN0IGVudHJ5IG9mIGEgbGlua2VkIGxpc3QgcGFnZSBwb2ludHMgdG8g
dGhlIG5leHQgcGFnZQkqLw0KPiArCXFsaXN0X25wYWdlcyA9ICh1NjQpRElWX1JPVU5EX1VQKG5y
X3BhZ2VzLCBIUEFTX1BFUl9QQUdFIC0gMSk7DQo+ICsNCj4gKwlxbGlzdCA9IHZtYWxsb2NfYXJy
YXkocWxpc3RfbnBhZ2VzLCBQQUdFX1NJWkUpOw0KPiArCWlmICghcWxpc3QpIHsNCj4gKwkJZXJy
ID0gLUVOT01FTTsNCj4gKwkJZ290byBvdXRfZXJyOw0KDQpKdXN0IHJldHVybiBFTk9NRU0gaGVy
ZS4gdmZyZWUoKSBkb2Vzbid0IGRvIGFueSB3b3JrIGlmIHBhc3NlZCBOVUxMLCBidXQgaXQncw0K
d2VpcmQgZmxvdy4NCg0KPiArCX0NCj4gKw0KPiArCS8qDQo+ICsJICogTWFrZSBzdXJlIHVuZmls
bGVkIGVudHJpZXMgYXJlIGFsd2F5cyAtMSwgd2hpY2ggbWVhbnMgTlVMTCBpbiBURFguDQoNCkh1
aD8NCg0KPiArCSAqIE9ubHkgdGhlIGxhc3QgcGFnZSBuZWVkcyB0byBiZSBmaWxsZWQuIEFsbCB0
aGUgb3RoZXIgcGFnZXMgd2lsbCBiZQ0KPiArCSAqIGZ1bGx5IHBvcHVsYXRlZC4NCj4gKwkgKi8N
Cj4gKwltZW1zZXQoKHU4ICopcWxpc3QgKyAocWxpc3RfbnBhZ2VzIC0gMSkgKiBQQUdFX1NJWkUs
IDB4ZmYsIFBBR0VfU0laRSk7DQoNCldoYXQgYXJlIHRoZSBlbnRyaWVzPyBBbmQgd2hhdCBpcyBh
IC0xIGluIHU4PyBPciBpcyBpdCBzdXBwb3NlZCB0byBiZSB1NjQ/DQpQbGVhc2UgbWFrZSB0aGlz
IGEgbG90IGNsZWFyZXIuDQoNCj4gKw0KPiArCXFidWYgPSB2Y2FsbG9jKG5yX3BhZ2VzLCBQQUdF
X1NJWkUpOw0KPiArCWlmICghcWJ1Zikgew0KPiArCQllcnIgPSAtRU5PTUVNOw0KPiArCQlnb3Rv
IG91dF9lcnI7DQo+ICsJfQ0KPiArDQo+ICsJLyogUG9wdWxhdGUgSFBBX0xJTktFRF9MSVNUIGFz
IHBlciBURFggQUJJIHNwZWMgKi8NCj4gKwlmb3IgKGkgPSAwLCBqID0gMDsgaiA8IG5yX3BhZ2Vz
OyBpKyspIHsNCj4gKwkJaWYgKChpICUgSFBBU19QRVJfUEFHRSkgPT0gSFBBU19QRVJfUEFHRSAt
IDEpIHsNCj4gKwkJCS8qDQo+ICsJCQkgKiBUaGUgbGFzdCBlbnRyeSBhbHdheXMgcG9pbnRzIHRv
IHRoZSBuZXh0IHBhZ2UuIFRoZQ0KPiArCQkJICogYWRkcmVzcyBvZiB0aGUgZm9sbG93aW5nIGVu
dHJ5IG11c3QgYmUgb24gbmV4dCBwYWdlJ3MNCj4gKwkJCSAqIGJvdW5kYXJ5Lg0KPiArCQkJICov
DQoNCkNhbiB5b3UgbWF5YmUganVzdCBleHBsYWluIHRoaXMgZm9ybWF0IHRoYXQgeW91IGFyZSBi
dWlsZGluZyBpbiBsaWtlIG9uZQ0Kc2VudGVuY2UgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZnVu
Y3Rpb24/ICJUaGUgcXVvdGUgYnVmZmVyIGlzIHBhc3NlZCB0byB0aGUNCnRkeCBtb2R1bGUgaW4g
YSBmb3JtYXQgdGhhdCBsaWtlLi4uIChzb21lIGNvbW1vbiB0ZXJtcyB0aGF0IGhhdmUgbm8gVERY
DQpqYXJnb24pLiINCg0KPiArCQkJcGZuID0gdm1hbGxvY190b19wZm4oJnFsaXN0W2kgKyAxXSk7
DQo+ICsJCQlxbGlzdFtpXSA9IFBGTl9QSFlTKHBmbik7DQo+ICsJCQljb250aW51ZTsNCj4gKwkJ
fQ0KPiArDQo+ICsJCXBmbiA9IHZtYWxsb2NfdG9fcGZuKCh1OCAqKXFidWYgKyBqICogUEFHRV9T
SVpFKTsNCj4gKwkJcWxpc3RbaV0gPSBQRk5fUEhZUyhwZm4pOw0KPiArCQlqKys7DQo+ICsJfQ0K
PiArDQo+ICsJcWRhdGEtPmJ1ZiA9IHFidWY7DQo+ICsJcWRhdGEtPmJ1Zl9sZW4gPSAodTY0KW5y
X3BhZ2VzICogUEFHRV9TSVpFOw0KPiArCXFkYXRhLT5ocGFfbGlzdCA9IHFsaXN0Ow0KPiArDQo+
ICsJcGZuID0gdm1hbGxvY190b19wZm4ocWxpc3QpOw0KDQpEbyB3ZSBuZWVkIGEgdm1hbGxvY190
b19wYSgpIGhlbHBlcj8gTWF5YmUgcHV0IGl0IGluIHRlcm1zIG9mIHRkeCBmb3JtYXQuIExpa2UN
CnZtYWxsb2NfcGZuX3RvX3RkeHBhKCkgYW5kIGtlZXAgaXQgaGVyZT8gVGhlIHRkeCB1cGRhdGUg
c3R1ZmYgZG9lcyB0aGlzIGEgYnVuY2gNCnRvby4NCg0KPiArCXFkYXRhLT5ocGFfbGlzdF9wYSA9
IFBGTl9QSFlTKHBmbik7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArb3V0X2VycjoNCj4g
Kwl2ZnJlZShxbGlzdCk7DQo+ICsNCj4gKwlyZXR1cm4gZXJyOw0KDQpJdCBvbmx5IHJldHVybnMg
LUVOT01FTSwgc28gZG8gd2UgbmVlZCB0aGUgZXJyIHZhcj8NCg0KPiArfQ0KPiArDQo+ICBzdGF0
aWMgdm9pZCB0ZHhfcXVvdGVfaW5pdCh2b2lkKQ0KPiAgew0KPiAgCXN0cnVjdCB0ZHhfbW9kdWxl
X2FyZ3MgYXJncyA9IHt9Ow0KPiArCXVuc2lnbmVkIGludCBucl9xdW90ZV9wYWdlczsNCj4gIAl1
NjQgcjsNCj4gIA0KPiAgCWRvIHsNCj4gQEAgLTEyMTgsNyArMTI5NSwxMyBAQCBzdGF0aWMgdm9p
ZCB0ZHhfcXVvdGVfaW5pdCh2b2lkKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAkvKiBRdW90aW5n
IG1ldGFkYXRhIGlzIHZhbGlkIG9ubHkgYWZ0ZXIgaW5pdGlhbGl6YXRpb24gKi8NCj4gLQlnZXRf
dGR4X3N5c19pbmZvX3F1b3RlKCZ0ZHhfc3lzaW5mby5xdW90ZSk7DQo+ICsJaWYgKGdldF90ZHhf
c3lzX2luZm9fcXVvdGUoJnRkeF9zeXNpbmZvLnF1b3RlKSkNCj4gKwkJcmV0dXJuOw0KDQpIb3cg
Y29tZSB0aGlzIHBhdGNoIGdldHMgZXJyb3IgaGFuZGxpbmc/IFdoeSBpcyBpdCBuZWVkZWQgbm93
IHdoZW4gaXQgd2Fzbid0DQpiZWZvcmU/DQoNCj4gKw0KPiArCW5yX3F1b3RlX3BhZ2VzID0gUEFH
RV9BTElHTih0ZHhfc3lzaW5mby5xdW90ZS5tYXhfcXVvdGVfc2l6ZSkgLw0KPiArCQkJIFBBR0Vf
U0laRTsNCj4gKwlpZiAodGR4X3F1b3RlX2NyZWF0ZV9idWYobnJfcXVvdGVfcGFnZXMsICZxdW90
ZV9kYXRhKSkNCj4gKwkJcHJfZXJyKCJGYWlsZWQgdG8gY3JlYXRlIHF1b3RlIGJ1ZmZlclxuIik7
DQoNCkVyci4uLiB3aGF0IGhhcHBlbnMgaW4gRU5PTUVNIHNjZW5hcmlvPyBOVUxMIHBvaW50ZXIg
bGF0ZXI/DQoNCj4gIH0NCj4gIA0KPiAgLyogSW5pdGlhbGl6ZSB0aGUgVERYIE1vZHVsZSBFeHRl
bnNpb25zIHRoZW4gRXh0ZW5zaW9uLVNFQU1DQUxMcyBjYW4gYmUgdXNlZCAqLw0KDQo=
