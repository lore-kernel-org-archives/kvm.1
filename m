Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C033A3E6B;
	Thu,  9 Apr 2026 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726905; cv=fail; b=pjBzo/7WEYN15Lz3DMe+FDu8qFLN/DN4SlMm1JsKOxLngyuowBkTDepsa8IAkvXqwwBLh/kqVMpUEIVugeqqjNDmLFdtno0mhGoQZlHjvUCu+7O5TSYblDR3QFISdu2quYDYuEAof1TZY3O+2FHXC2GDkrWZqWOcilivAJCRToU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726905; c=relaxed/simple;
	bh=zQrriIOEas0xXXALfZOBHtvfhEXKDQhsdlUKy1+Uczs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tpQ1byqYHP6MBVdQsDd0X7pEiHo+DJLBbnO0AYan79djUmfpBTLN+fV8pLG3AXmWvCTlCM5BNPxW76akGV7e+O5al5lQItc9JrIX5gM0qJa6AzcIaGd+hitb9z+cZRMS2a+iY1EGp4GcU+teaHbxztkCprEVW7DOIDapqAaHI6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kePJNgM4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kePJNgM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775726903; x=1807262903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zQrriIOEas0xXXALfZOBHtvfhEXKDQhsdlUKy1+Uczs=;
  b=kePJNgM4icbM26cBNP7rI61/BzQMb0nzXYPQtc8WmizcDLTjeeWrwvcQ
   t+L6AVw0ovVC/ayvoBv0cMaZqGGq4pWOT/YvAa0j6n6FGEzabbMlRpanK
   R4vtjUe9JEnGIRiLxc/xXMZl77bBpQ9GPTL/JHTsoya1i6u6vmN71UmTL
   Wac6uuphd80U25vGNHVzkymGyL3T2bBbJw0c8O8Yqe0tFkodIcfBU6GCU
   7te1r+3+sw2M94MqnqFaNgBcYCXJnO1lnm06f7HcWu3EYQnZ36LcFjVeS
   onSGgddfczlyhzw3MR5fvdg9TI+PnLILa7PGZkv/OSj+mup54x4g0T6So
   g==;
X-CSE-ConnectionGUID: ONkEwZrXQxSUosvPxv0ZHg==
X-CSE-MsgGUID: oSlU87txSbKl2WD7H8jDQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75898970"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="75898970"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:28:23 -0700
X-CSE-ConnectionGUID: 9JD8Xux+TJGP0hV6bg/I/w==
X-CSE-MsgGUID: 9Yxg++7IR3urAFFVYMB0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="252052514"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:28:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:28:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 02:28:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYodM68H+Ub2LiW13c7C2Gf/hqatXZX5iMZ4IRLH4AUoti940Nldq7LRZBzJ1xjPsTHSvCH0ipBLct8fpeiwviFLRW42+KemBNAJBYtqE/3cN0yKT90ruX64/XNXQLVuTZeZmNCvi2AdxRjAuGnj7K8GHmeOz1mq5SA6xF4534dWxmSR7WVN0Uh99PjYlWRlrcx//B6ADAXPbl456HI7/shW/Loo0HHtjHA2caRGBlMssT+TTGBj5ZXevCZUBHvkJq7uUAcTwT6t1bLlUI9Adr7Pqe0JWAN0xnVX++VI8NSr0POJXGgwFSMJiGVQW/MsqofwdZ99VQFdUox/tzUfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQrriIOEas0xXXALfZOBHtvfhEXKDQhsdlUKy1+Uczs=;
 b=HlWTD4AUbOBmpzOUDfwCOdm8UimLBfhWFiI4mtc3x3C8MEs8tP5Xm04Wi3u17xVpD4QX778X2NdFJcXHtjJgvR4fTxoM2zAjI6x3Q+AbXJra6yab1zcKjfyBHYFVBYVjBWKlAaJErjx5N2sKYnMkBxmzy4g14kfSMmzhHhYW+JvnD8r+vW4JJj46ciPMBxrv5CfUsZkcvUCtUZCmSpMnOf0S4syiF6cLtPFzda47ZBVBwEbn6oXPB3hnwFRZpbvlaDOqlw8AUii1DpNoSU4H7R7CZCiI6984hUorDD01L48uhqWgVUS/4z3ix3MpHqqtUZsSUH5HJ58YLl6PuWpBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:28:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 09:28:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Winiarski, Michal" <michal.winiarski@intel.com>, Alex Williamson
	<alex@shazbot.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>
Subject: RE: [PATCH 1/2] vfio/xe: Reorganize the init to decouple migration
 from reset
Thread-Topic: [PATCH 1/2] vfio/xe: Reorganize the init to decouple migration
 from reset
Thread-Index: AQHcx3FKnWrhzWvRd0a2c+lkyZx0ArXWdsGg
Date: Thu, 9 Apr 2026 09:28:17 +0000
Message-ID: <BN9PR11MB5276B442FDC984D0297D19DD8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260408160340.866784-1-michal.winiarski@intel.com>
In-Reply-To: <20260408160340.866784-1-michal.winiarski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6742:EE_
x-ms-office365-filtering-correlation-id: ba73c726-724f-4c09-6c14-08de961a5519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: p1016LbxvsSNCJ1he9csb2RDPfz9vgVFk3whVaHSZ8X1neuGRjONmrgdFL7EODhN6P2NC99h2dVToKQfMuINgV9Avh03/bn7TX6BbfhzWm180yXRgti2W9HDM1gCUZDtRiOKVzuByVeQ+gFxvLQVkMioMxxwsYHFm9MTEx5tH4t1uG/SjEg5j+Y0clu+Xiq0OEMAmOVy+GCdC3iHVXBtDCLy2yU420HWZ+WW+mJFXhPkXEIq+ysnRQ5LlAcv0527oaXcD09nErxzI+P+SiuTCyeY3c9qWMhLcFShdAlOBmrQShDFA9iiqT8zu7Kx01o9JvD69QLXtwNx7lOQRfKPF78ddv63xkgcS4NwB9kJIx130EC2NKfeu5CVVLgNfIFceKDlhbBNm81DHzSP8Td0+vtsVvuz9BiDQ6522XwZvWWS09Oqwzr6GYN3pKsXCCkdhfi9hQ9d2HfsSdJANThiF579st01jsnOGSqq8qjlytGEs7xjOAN+5r4KK/69L//0ErDYP5S2Ox+jdWSGwI+vEomAEf79ar4/uQVgUDd5nVqExj56Cadv9WgAqsPgxXQdPuVFmijMaYv45x/o60LNXaJ2n3RNnWJas/u0UGS70dHnsQy6lf6x953L6yKKuZ0GkSUSGAMl4ZjTmXKWe2AXpKZSa66NvwedjnylunNETsrhetZOWbaambSV3B3lMjCUhzXwkxznzrknkcZjBDHGrVBvCrArrIE9mDsgOVY4pErGWXKaw5KAmCzdbflX4A5KzP5/BatmTYk4AjQLl4Oegb/uTZWssUiJjBkN9/jiHhY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1A4UHlCcGRocHNRbk43WnVneHRLdzFpb0p0alNLUTltM2dLV3ZKbElGNHZI?=
 =?utf-8?B?YWQ2UVNubTJWaDhyTkRNVjBQZ0hpaEZjeDFNVXVZVWordlhSeE9wT0tRQW4y?=
 =?utf-8?B?RHJzd0tvU1lnRVFQM2gxMkoxZmUrN0RQY1NaSWZWQnVlOFVnWXpqMGhwUzRD?=
 =?utf-8?B?cmlIY3JxZGk4ZFowQTJpU2RqZ2NSb2NiWFFUTWtwYTU5QTNHVUNhbzRDcmVH?=
 =?utf-8?B?Tldab1dHYSsyZTQwUUJ3T2p6dTdRZXl4RHdvVVI4Q0pDVStIbjI4U1pORnpK?=
 =?utf-8?B?WWFIUEZxRmowSEhVVHNiWUZGWlhURkFReG42Y2lJSFRUeUljalhBUkEzaHM4?=
 =?utf-8?B?R1ZPYjlFYjc5aC80Q29Tc2RoNTVtN1BUWlNsQkUweXhzdEZXemxuNUVweVpT?=
 =?utf-8?B?Y1ZaUmVUOWw2Slc4V2dXV3pNK2ZRTThvWk1CajNJUTErbVRqU25qU24vTnp0?=
 =?utf-8?B?eUlhenpzMFhyVzlhTkNVbmFHZHdTMm9UNS9HcjlISVZranVPYmVxSEYvSjEv?=
 =?utf-8?B?blVNek5udEVsaXVwbHJTdGNuUHpmckRxOWRoZ1hhQ3Z3clVDeFFWTmJpR1JB?=
 =?utf-8?B?NW12dldhTXFQU0VXaURKMFdLUlhYbG51Vm5vaEt5ZVBPUkJ6cGpoVVROY0Fj?=
 =?utf-8?B?Rlc0ckVsOGhNcWc0SjJqNlJTeXNDckJzVE5hTmpIb1RzZUFRYmxkQWtnbWxI?=
 =?utf-8?B?OVJ6UmhiZGs0ajc1THc1Znc1aFJDYVN2bUVYK1p3OEtBVDRSSUJBb0Z3akVH?=
 =?utf-8?B?VlN3enZma09BYUpFZ25PQU0rVU5wY2xBV3czNE92cTZyUlVVYlJBcExWdGRI?=
 =?utf-8?B?WHVkWUdCL0pNOXFUSDE0Tnlza2JxV0VYeXMvQkh6ZVIrYmNRdVZzVklVSDFa?=
 =?utf-8?B?R3NlYWNMcW5QOFpnWFEvd2E3VDZFc09oTzUwL0RzZlN0cFViZkJHVEY3ZEJE?=
 =?utf-8?B?SndCZ3NIMnBzeFVjcVZ3Zkp6WDlnUmlYc3M5RXJsZUdJVnU0NzArQm1DTXJC?=
 =?utf-8?B?SThvTkdZajVGZ1VjRlZhMEhOSStaeEpXM3c3K1VPeWF3MXgwdDVUaTJRNFd2?=
 =?utf-8?B?cWQyUTAzN1BQM0pETCtrRWthc2wwMWxaOE1GQjBVYzBybElqMlBVY0RqTnVw?=
 =?utf-8?B?eG1icFZGa0V4cWY3a1Erc3pzNE1MSS9lZlUwa09hYjVjLy9zeC8rM3FwWHZh?=
 =?utf-8?B?MnBQTFhvR2dIbVZlSkZvUDg5K25QT0VqdjdvTHh0ODNVWWFPaHRvaGRCUXFU?=
 =?utf-8?B?cmMxRE1UNVpQYW53Yzk4YUtJYlNya0hLVkJhNjc0VUNmbmRVSks2azFmTWZQ?=
 =?utf-8?B?dUkvNk9kdUR6MGMzc2d2eDFDUVYxZXFieG5GcVN6bkUvT3FqQ3locGkwN205?=
 =?utf-8?B?M3pPeDhxaUNaempDU2JtaGE1ajNCcmpiRzh2dGV0QngxZHh0Y2NEYW4rOXFJ?=
 =?utf-8?B?eFRGZ00zSGRtUDYzQm13Smc0MXJVOWRBaVR5VlhaUmVoa2VNRlVpMmx0SWZv?=
 =?utf-8?B?b21MdEtMRXR1L0FUQ2hXZDNyTU1nRmRCQ0ZEN29XTHc2Ni9PT2lEcmtzNlJp?=
 =?utf-8?B?UXVhUk5oV3hzYjlxaHVOb1NQaEp5VThYUGlFZnlUQ21aQTZZSXF5dFJSbTZs?=
 =?utf-8?B?ZTU1cmlETkJCUFZPcVZjYXd5YXZDWEZnZG00Y1lwMWNiZlNvZ1doeDhIOVor?=
 =?utf-8?B?OHpoamY3VzU1cXQwa3hvZ0JFaW5QVlhNQjhaMk4yZ3dOaHNMWW9HNjRwVU11?=
 =?utf-8?B?WGZoSHFDODhYNzR5UFA0WER5K1UySUJRV284Y0dJQ2RMRzhKK2RzVWo0NVly?=
 =?utf-8?B?a2JNZkFNaDNoTGwrRit3Z1NadXdTeFJUeXdaSkdXaDlURU02em5xQkU5aW5p?=
 =?utf-8?B?NVVYZTFjd0ZjdVBXMFc4aEVNTHc3ZHJQRjZMVUJIVjJRb3k2Z0VkYXRVeTlo?=
 =?utf-8?B?TVhJNytHSU1NdW5DaUxwYXZrejRFemFLazNqR1RxOGQ2dHVwWjZ1NHN4WFFC?=
 =?utf-8?B?dXF6MSt2Z3BjWmlWcE8wd2RNVUpnSHlOSnhxQVFkT09MMTRXblFWZWZNamxj?=
 =?utf-8?B?Lzh2YW1ETnpTM0l4NXFaa2NsWEJ4N0xvOVlETkIzNmJkL2wzRHJjRk90Y2FV?=
 =?utf-8?B?U0R3UVlmSG9Zd0J6WEhkTmtDSFJFZXZlRzRtMmFmcTZlQ0M4SUxsUHB6OFFv?=
 =?utf-8?B?UkdSUHpxbTBBQUNaaHdTMUdRbzlEdDBCUWNQVUowZkVhWjdCZEJSbUQ0cnB4?=
 =?utf-8?B?YS9yMHBmeTVpS3ZTTGFGSDdzUDBpN250b3FOYStVZWJNcmY5cC9ESXB6KzU5?=
 =?utf-8?B?MUN0WkYxaHlWUVpDQzA0UWNxbW03NlM2UWpwUFFKNUMvS1FCTEJKdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F98Xih4cjG5JBt3Z0qzxxWm+1GGVTPM37TMjp3NrKjWcDUWfkF+phroeJ1+2yuQ3Fjh/hrFJc0p5DuWU2hT/OitpDMZa5EybsQvP2esKL5E1wmIzt0+WtDsMEtO01uMgynjrvnHRV22NBy6iLXTQhrC+vprqfNaCFpq6clFpEnDblyMw6Ozt8d1HjcL76jFNi6jonGZ2x47cf6kJbZt79bWHf/ELcFs7US7Ut+gygaJ986O3r/8whGDwAKiicXyt7WIGatnVqQ5YCfA7cVO4jdmJiifVi/GvLBimE9c7FBbV938rxePt50bfeAfHRGZR3bcHV031pF/NRCsaYXbvyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba73c726-724f-4c09-6c14-08de961a5519
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 09:28:17.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoWycSvCwsZXhVZyDI2U/LIhrNSAYB5KmoXl5KkqEW4Jp1exsS0kjoVOMVjF308bxn156i2bU6eQrYYIqWlamA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com

PiBGcm9tOiBXaW5pYXJza2ksIE1pY2hhbCA8bWljaGFsLndpbmlhcnNraUBpbnRlbC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCA5LCAyMDI2IDEyOjA0IEFNDQo+IA0KPiB4ZV92ZmlvX3Bj
aV9taWdyYXRpb25fb3BzID0gew0KPiAgc3RhdGljIHZvaWQgeGVfdmZpb19wY2lfbWlncmF0aW9u
X2luaXQoc3RydWN0IHhlX3ZmaW9fcGNpX2NvcmVfZGV2aWNlDQo+ICp4ZV92ZGV2KQ0KPiAgew0K
PiAgCXN0cnVjdCB2ZmlvX2RldmljZSAqY29yZV92ZGV2ID0gJnhlX3ZkZXYtPmNvcmVfZGV2aWNl
LnZkZXY7DQo+IC0Jc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGNvcmVfdmRldi0+
ZGV2KTsNCj4gLQlzdHJ1Y3QgeGVfZGV2aWNlICp4ZSA9IHhlX3NyaW92X3ZmaW9fZ2V0X3BmKHBk
ZXYpOw0KPiANCj4gLQlpZiAoIXhlKQ0KPiAtCQlyZXR1cm47DQo+IC0JaWYgKCF4ZV9zcmlvdl92
ZmlvX21pZ3JhdGlvbl9zdXBwb3J0ZWQoeGUpKQ0KPiArCWlmICgheGVfc3Jpb3ZfdmZpb19taWdy
YXRpb25fc3VwcG9ydGVkKHhlX3ZkZXYtPnhlKSkNCj4gIAkJcmV0dXJuOw0KPiANCj4gIAltdXRl
eF9pbml0KCZ4ZV92ZGV2LT5zdGF0ZV9tdXRleCk7DQo+ICAJc3Bpbl9sb2NrX2luaXQoJnhlX3Zk
ZXYtPnJlc2V0X2xvY2spOw0KPiANCg0KdGhvc2UgdHdvIGJlbG9uZ3MgdG8geGVfdmZpb19wY2lf
dmZfaW5pdCgpIGFzIGEgbm9uLW1pZ3JhdGFibGUNCnZmIHN0aWxsIHJlcXVpcmVzIHRoZW0sIGUu
Zy4gaW4geGVfdmZpb19wY2lfcmVzZXRfZG9uZSgpPw0K
