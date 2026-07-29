Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45543C7DC
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362786; cv=fail; b=sDCfOexakZ9mCSbb6GEtIzFg9LNcK5LhKUXjmKiTR9n7/8S5tvhKq6F3G6w/y1S28kPDl9MqMY2hB4jXh558LybbxwEQt+7/o7OTb2SqKhFN2FSZyIhMmDtJLT2swRseg1TKFLl7+kLYYub91aw9dDbSJQFdUFKdmjMxIrBPPf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362786; c=relaxed/simple;
	bh=u+5mvx+vaVx5Wcua9KCfVrYRl6KtMzFGh8C7Ucs4F+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttbWYzvRajfx1nsvPVUVadpDbt1hc+ty5o8q4CPVQHRMswFrLFo00FHFKBp7dqrkIQMrpQK+hzW3X5ErqObaEsqRgZSca1238F3CRWV7cxgRU58rT8V3sqJ3Sb0mxFtUujo7JnyQyvFNH6S3KsIYGUJZwPvsHIJxJ5vFhOzwTpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQrjs3sj; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQrjs3sj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785362782; x=1816898782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u+5mvx+vaVx5Wcua9KCfVrYRl6KtMzFGh8C7Ucs4F+I=;
  b=eQrjs3sjKH6q9LPdA6//qj4o2c1ZUmOZQobJyBclNzf6q6z7fxzuH8oQ
   hIIGw1TdQ2gL2D5lXXtmSuOXowT6F90G6jhIT9TLk1s4zmIVi9SZZrpxH
   MREc2L11rKthDBU++4jeDMlgH2ncndzlHj/xBMYwTzHu7JQeKJLQn2b6C
   4M7T9fpmcRA1FiOyyNkiKpTbzeThWwMcXhYI8wiJ7m6xOMl7F2AO+9oSS
   AaMkt9uG/CwaV3IhJOaT72/pJj+OUqlt6C4YQl1PDM7PH38x6EYGsc7ue
   ASqC7sfcE46zCFWIln35QLud2WmwFggJuRR0TGAiZaonKE7d0qZfkFY6E
   g==;
X-CSE-ConnectionGUID: ngROMAmDRr6P7pNns2eOVQ==
X-CSE-MsgGUID: sMv+JFbiS7mVCZcSmiD92g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85742733"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85742733"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:06:21 -0700
X-CSE-ConnectionGUID: ATH4J3ZaTFyX314iG6L9Kg==
X-CSE-MsgGUID: BJcpoao2Tm23+mC90el8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="257450833"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:06:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:06:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 15:06:20 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:06:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEq7R9NAfr6a4y0LsQa4vjPNHBbtmAZrHj+b5wn34+Q9LhwWexmcodKKLx0/NQTMr3m/Rn0AAG4XWZKpX+H1vwJOyxjk7xGLWmOyClAxXe9AeCSg+WNtx9QlZVvfc3ulxYOgvbe8tKyONw6pNkfwACS1hdGVkfmiC5rhV5uUWZlbZjJWd959rJiR7m7Na14oL9xJzhKtWAnf/C06QCDfRioieOJ2L8RQ+lX65VJmDOjrw57P9Cgra5suNsYAVLBTCdOzuv1NNA5+c1y4A5pqnAvsowZ4sm4iovBRKFKPnauGnk+ntJy9cxhPqYppI4YaMahgPzcEUh282s4wEkqO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+5mvx+vaVx5Wcua9KCfVrYRl6KtMzFGh8C7Ucs4F+I=;
 b=b9NmHlS9MxCWajt9Nf6O4jI9CCpdBqLsMo23TfetloXYNxsQNZv6BhDGi8RQDW3PDh5XZXgvAOY7XC09qmeVT8dPHjpIIK/1FZ6sm0rtHi4Yxn5sH4bhP1N/0Pehog8VJjULSaT+viaaTJqkaKFYt8sY8yGx95oWB4lU1UPTUi4TjCRiC96O1PNXIH+2m+d9SSjyHMfgI6ReEdhgTb5C5QWszdjAwTiKy3htWHAsAp4027RICfz2WmO0QauSNtPSSZGhKSfBFg+Xy5SC3C9+PNQALjnkSMC+ZxRAHOx36HsvcYiBq08Sj8cL63saxrI8G1iSu2CpzDsbcmrEyudhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB7146.namprd11.prod.outlook.com (2603:10b6:510:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 22:06:17 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 22:06:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v8 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v8 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdG8vP+P1Jc1q+0UyBvmgxYcxyxLZ9ZpiAgAeuxAA=
Date: Wed, 29 Jul 2026 22:06:16 +0000
Message-ID: <17487a0f7a2067c010a9659e149b385d40a9eccc.camel@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
	 <20260725002302.3337017-9-rick.p.edgecombe@intel.com>
	 <20260725004658.3154F1F000E9@smtp.kernel.org>
In-Reply-To: <20260725004658.3154F1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB7146:EE_
x-ms-office365-filtering-correlation-id: df9def3b-ca2d-4ac7-f3be-08deedbd9cd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: NVJXN/aybhIgH2RUz/C6Hid/ouS6Qa7n3E6Dkug/+h4Iu2D0QIZ6ClDSlIpTP0u+raxHX4fI/RGsRzjwK3Ox52mIpMR8Zzhin4SpP9mGukKHx99Z/aFeA/mDjTrHwSQX3pb79GI7XwOl2JQC5AGtO87TCDJ/fW94mA8iLckrLbGx684xEyF2qq+nr5abyB9k8xv6zMPgqDN+JMwsjUhVn24cATRTo970Z1uvM6D3jwIwA6JIIZhNnbjEF8lzt/GoAYZs9dmkX9tGmHYV43jay+B2ocDSFPuCVjvk2s5v5Pbkk3ceh/50jqKxfqX/0DoIQScM7JOMr/vPDkgWUT2L3bIhrEVwru0HqRgOoFDxxyC/2rCYP8ZpoJbnMIvGyBeGk/RDvDfy6Ky4YLIBHm4X28c8RFXWHOpS8giCSujS/z6bkMj4UTB+QTF1MWLAEbEU87F/PsTtsYWUTgS07QSS6I1hP5Ip0ePXx6e7yads3k235VRv4IyDFeKTarJSqhEk5kAQGdKiqCxjB/ZinoHKiTyuzRQq1Qiuvl7CB31LLR+9ALHvZLviy+aNyOXxRFpq3YoiYdbsuw7CI4rsEMzWFDRjs7yIkuKrre5/5xzZxUJo+05WJp9ZMKJy1i+FXAOpe8PRvREGwKRaMWH5KvvmiSv2tyqBNn/yW/h6EhzuJdk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUFFSU9iWlhMcWQvU1BVVDhydlJYU3VLQ2ZsUVd5OGU0elNJeVR0enJGazEx?=
 =?utf-8?B?cm52U0I1aU41L1p1OWhkU0U0UHgzcFhGRjhqQ1NuWUc3V2cvNi9SRzNHSFdC?=
 =?utf-8?B?OXRXSWFxQWV2elBtRHltczNBeDZNUjUrVFZETnNtaldSUFNyOXZSa2ViUStZ?=
 =?utf-8?B?VExIRUEwWTVsbW8zQnJlYnhMVm82WFE1OUQ2TU5mUi9ybjFQa1VWUHQ1ZjNi?=
 =?utf-8?B?LzdZbHpGbFkvTFduc2FGTU81cUIvdmg0YkVKdEhjWjJFSWVkZjNMV2RaOTgy?=
 =?utf-8?B?OElVeVVUY3g1Ym9SblB6RHJPZkFsUkliYkJUZlo0U2FQbmZRSmx6NzloWkY3?=
 =?utf-8?B?WXVKTTJUZzV5K2pOVWNQTmRCak12RElMOGwzMmphTkw5bVBpQUg0Z0FzMnBZ?=
 =?utf-8?B?RnEwME1VckxPbG9id1huNXo1Y01YT3lrK2d6Y0RVVUNPNlE0VlhISENKY0tk?=
 =?utf-8?B?ejlYSEhqZkw1QlR6bE0wMUd5cDhGdDNrc01NU0xROG83U05nalh3bzg5blNn?=
 =?utf-8?B?cHRtYlB3YzN5aSs2MXhXZXo2ZXBLU1hzSVk2cTdiVUlWM0pjSHVGT1VINTcv?=
 =?utf-8?B?UTVZUW9EOUkrVmFza3d0amR5S3ZLUWI2L3lCS1N6cm5aQk0rYWd1aTdaKzVK?=
 =?utf-8?B?ZDlQRml6T3p2VGR6VS91YVlCV3hXdFRQejN5WmpTbHcwOSt6aEtjVGZJS0JX?=
 =?utf-8?B?blNIa0pBTVBJdFZoeUlYeXYwRU1ZaVIvTDRJYzFCUXAyV0c4cSs1Q0d2clRh?=
 =?utf-8?B?YjdmNmxYSkh4OWh6NlFuNVVLZllzcElGZHVjNWxyWUFjZGxQMnRoQS9WVXNO?=
 =?utf-8?B?MDIzRWlJaWVaK0RsaEJmY0VYbTRZRHcyZEFHSzB5MGdENk4yN1puMHlRbHpZ?=
 =?utf-8?B?Vko5c1dOSWUyd1phUnlDRFhBRW40VWdLM3ZwOGFwcmhTQy9mQnJpSm15TlY3?=
 =?utf-8?B?bXc2ZjdRcmp1ZCtLaVZNV0ZpWFlsWW1mN3FxamM3ZzV3bkh6N25CeUtyeXMy?=
 =?utf-8?B?aDU5Z2EwYjE5UTMyRW1rUUlGVU9FT1RFaitqZ20vSDlzUkVPeVZoUFJrb2FY?=
 =?utf-8?B?VmZNTytFdUVCaXZzQnhDNEJ1aEVDemt4Sm41QkE4MzQrYVpYK0l6alMybis1?=
 =?utf-8?B?TTB6d2tNVUs5S2tiUGxSaklKNTFEeTZMRzE5Z0R2Z2NkT3JWaVZkTlFJdWJi?=
 =?utf-8?B?S1J2L1QveG11b3N0Y1hVRkdiM1p0OG9LOGtHNW1KZFloWXZ0N3VNSk5EVExQ?=
 =?utf-8?B?TUdzZzVGV1RQNFQ2bHhCcmdVZnhLa3gxK0Q4SFJqNXowUlN0NWNYSFUwcWNG?=
 =?utf-8?B?RDh3WW9aMFdtRU5UK1N4dW5Bd0RSZHdFdFRFdXRMTDNBYmdzNC9LV2VNNXVj?=
 =?utf-8?B?aGh1SW00Q3FQVW5YcFZGSnNSQWxRNFJrRmhJWlNFM2NaNjR0NVhjMlNmTmtu?=
 =?utf-8?B?aU1YSEFYMW1GTWdGczFQUmI2UzU0ZjM5bnpXUVRnNnM1UVJMQVE4U3I3RDFV?=
 =?utf-8?B?N1ZNd0VJZ1NzK0ZvVmdMYjh2b1lIbGhRbmkxVm1GdjBVdmM4dnB5akVvZjZW?=
 =?utf-8?B?dFNVQStnMVA5NmhwTEtreHJYR1ozRnZsM0tKZGZUOFF5aXlmS2ZjQUNNSzN0?=
 =?utf-8?B?ZDFvMnJ0UGxJZU5qcGkvT2JlTEJQZHJJT0dld2JUZytBMGdKam13TFpRa3lI?=
 =?utf-8?B?TnZvVzF6VHdwYzlqWW5LMTgrbmFRT2hLQTNBUVhhemdpS0lSMmJZOWR4SkZP?=
 =?utf-8?B?MEpOcHUxVkJ5dEcyakdzakZKeUNXMnlMSGFHTzJtL05ObHcvRlQxcTdmV0I2?=
 =?utf-8?B?K1pUeEdLRGVSN0ZHUVZwcUpMeDdvaGFCNnpVN3ZyWEVZd293dVBzVkJGYU1h?=
 =?utf-8?B?UnQwOEJNRkc0eVZyWnlXYitWR01VQlMyZ3FHOE9QelpQVlJVeXdvMU82Nzl5?=
 =?utf-8?B?TzFheWNaOHpQdWVKdDVPVndTbHpmREpLWmtOeDV3VFV4V0hmUDhYYUkxTEZm?=
 =?utf-8?B?TXFWWVBHdERoaEh6Z2VDSGxid0V0R3VuQTdLQW5JWmZtbGJEM0FOcWpwdVgv?=
 =?utf-8?B?cHU0Y0kvUS9NN3YyS1RVMDQ0b3IrOWFFM0NIaTQ5M0pycERJOUorZ2VNT0kz?=
 =?utf-8?B?T1pHMWhIcVdHNkpUcFAySW5WZXlmL09yRTRac3BJeHNzRkdIaXVrb21DOFVB?=
 =?utf-8?B?TFJYWWx2NSswanlGUURWWlVrZDlvNVh0WU9IR296b292bmdEQVFVTitWVTI2?=
 =?utf-8?B?aHl4dWhEOW82SGJTMDBHY1BRL0hYSWY5RUVoYURUVVR1cTZiZXdBZVlEc3Zs?=
 =?utf-8?B?cHFackw4SmdUYWJUTHdUVlllRlNjQy9xdXZhS3FVa2U2TDRaQ21hblNqS01X?=
 =?utf-8?Q?g3i0TR6udPHxkNnI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA3F15B4A149444BF501202B6D90D35@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WjO5CqMyGtBnSCVDkD72lQNiUV8S1LLz05pp8kKlV2itMXFniq2o+tlpesA5HJtD1KYi18tixkhhMe/N6c8lyhoZkE30gJGFxoFvBgBQ4gL+cezAOoDTmA1dhJgk1l4P1OGw3adiLv65ExTM8lI7YzglmFpsksonQ+A3Hk3C4OeGIkJ3PJRPTemWt7kT9hwyZjey8U9kWHgmWCAH2bMv/OwcFCfzVarFm+WjDDQubT8YBUHbFXVif08KIRVNBJVPz09MmC+T4X2GOfn2YMSPPKQZlIYfurv5LNeJmXK9w4Vp3kB3iDSHh1MLMbS1DoXnBVrhoo9qsQSOKZUI9Ww15Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9def3b-ca2d-4ac7-f3be-08deedbd9cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 22:06:16.7847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXLDxX9Ct7pOTyW/RCEeQVaVLulskssvjPUTAKaDXu/6gxaREsAGBfmcBkK0p8YYPxRni8nGuquRL5XOcjABmPyQ7FHsM7I9EAvtXiOlcEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA3LTI1IGF0IDAwOjQ2ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbSGlnaF0g
UEFNVCBhbmQgS1ZNIE1NVSBtZW1vcnkgY2FjaGVzIGFyZSBkZXBsZXRlZCBkdXJpbmcgdHJhbnNp
ZW50IGhhcmR3YXJlIGNvbnRlbnRpb24gaW4gS1ZNX1REWF9JTklUX01FTV9SRUdJT04sIGxlYWRp
bmcgdG8gYSBmYXRhbCBWTSBjcmFzaC4NCj4gLS0NCg0KSXQncyBhIGZhbHNlIHBvc2l0aXZlIGZ1
bmN0aW9uYWxseSwgYW5kIHRoZSBjb25mdXNpbmcgYXNwZWN0cyBhcmUgcHJlLWV4aXN0aW5nLg0K
U2VhbiBzYWlkIGhlIHdvdWxkIHNlbmQgYSBjbGVhbnVwLCBhbmQgdG8gbm90IGhvbGQgdXAgdGhl
IHNlcmllczoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9hbURkMUlwM1hUdktTVGNiQGdv
b2dsZS5jb20vDQo=
