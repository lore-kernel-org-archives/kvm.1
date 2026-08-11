Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736483AC0EB;
	Tue, 11 Aug 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461652; cv=fail; b=gXX0iEqkZtdqy9WOmbk7KCdnf/U+EwNMUgHOLKZqFETGBiSejYJnJ+Ike5JFQDrk22hcGjAbRhMy8HjrRKZSbSNf4DcxNxeYH7MlxI2nLrr7MJkvhqpY45reAaCsLozTSQBgFcifMVXS0eLrCmrfFgNL1aBfHSXqwe3OkDXiLhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461652; c=relaxed/simple;
	bh=iWK0GJD1WJpdZBS1CHklXdYqOrV3c20+AgFmzla6b+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Swo5ck9UIxlPBajHp3dZb0qX4/e4MvedKtKtZHm6VNLJtzsRErxdbDHgGxhBI9gMTqAyim4EzepqgUJZ7W52VoL0wrqd3mBO8ZfiPn3vAYSIsPJFRPQksRes1UpSCenJFYQrqR1WzXu4UUHi2IIw5Vna7iwOrFMrVDyJtxMPVHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLw6wqRC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLw6wqRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786461650; x=1817997650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iWK0GJD1WJpdZBS1CHklXdYqOrV3c20+AgFmzla6b+M=;
  b=iLw6wqRCTglWm46rrxQZM9NYEVmIh48VR5HDLZGeyHo24d8nyG4v7jHn
   9pJbzEGMIpFMbt1Fv1lNrT4ago5uphcxJ9JSSRd37KRBrWBGRvvz0kvZN
   lv5SJ53HpmBr6ZcgwMG8ElzrS0uG3dnJ0DkQc0Wq3Y8Dg+qjvbK3JKB2Y
   I/xzgNG6EleHKe+IonbTdPWOFsRCMCzKsfVeUwNLYfWbUmcunsUbL3mul
   vxVuQCS5qGPD+pjllOBJhGJUjXcvML6hQHEedBqy3Pn5iEkuv+hQyT92y
   +g+a07sQKvU+80ukrI8Oarz4v1PirppdWOOTVtvpPVpT+XHuOg+rWdG6o
   A==;
X-CSE-ConnectionGUID: fCGin/F8T+yjaHzMgWyCSA==
X-CSE-MsgGUID: f6kY6cpQQEGVX5wPqOOdMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90809308"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="90809308"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:20:49 -0700
X-CSE-ConnectionGUID: 0jKi9swCS9WZ9zcyaU4qlg==
X-CSE-MsgGUID: kYve6RiiQTuR8BnxDGR33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="288083979"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:20:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 08:20:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 08:20:48 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 08:20:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce3EHFbZhn0wqtTKA0QhaToQogMKKjHXjg7mOsRp8K79nEOVj3drpbP6Wqp8/erCR+1stttSkTZfHYdoCSnK/cn+dRpWmLL1M3ZFa6FCtQIAHO1afv9hoAAx8OA0lNyeweT5ULcwT/sIothaj+RatW83JV8b7Bk5LhiP7hCIQd6tNT3aIfPp/GwIzmiV4rJMdh4x55TRSJc4RGx7T7HVxCSFzJpQrcq5CbeSbhGLKV5Bzj9oH8g82y6GeuOUMYy465jM3NEwpuG0jRjx+wUmogvq2iZREZtR09jZJH8r+XrYeOxpqWOnJIRkqNJ2AoI5JKe5mrHQn6rDfSJx2ynm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWK0GJD1WJpdZBS1CHklXdYqOrV3c20+AgFmzla6b+M=;
 b=yCLq3XDLJJhYCAuhcM1hBF27+Qz8uJhVH2Wmky6khh+D505dmVN6wbbcaozoEIhlQgPhMIKvJDdRhCujTfe8sPG3dzWkrMEwQ0C06TuUkxUiQtaEj7kgpcc4vwUdjYHJNw02c1HwxYzddATJ9uEUk1TUSB6N993wXnMQ5gFk8cH5kYf51llPH1AhvQcjw7EYlVB1EgbYi2z0e0A5x8ndyMqeL3Bc4eM63L+C7qoxHkwz5pGGHhtcamuEgyakil+PlK8ZoqlFUXUGuvxNIlM1bkizHWmXXz5eObZNj8kl056xUjKkyBdrihldrH/tnuhmCqyfjVB9Wqtvd61OW1Yvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB9725.namprd11.prod.outlook.com (2603:10b6:510:396::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:20:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 15:20:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Topic: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Index: AQHdKLszJKJ95KF+vUOi4YjlC1BNl7aYAh4AgAAO8ACAAOhgAA==
Date: Tue, 11 Aug 2026 15:20:40 +0000
Message-ID: <0a458dd822e5469068d5dea6aea3dd935b69e963.camel@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
	 <20260810112200.2326727-3-xiaoyao.li@intel.com>
	 <5dfed336a46329ba39922dcb3a8723116dae9ae4.camel@intel.com>
	 <6bb1328d-e995-4ad7-9744-3ab01d2ae591@intel.com>
In-Reply-To: <6bb1328d-e995-4ad7-9744-3ab01d2ae591@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB9725:EE_
x-ms-office365-filtering-correlation-id: 5aad54a2-e107-4ef9-d0cb-08def7bc1ae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: bYFzbc+tqAjA7u7fIFGUrSjEqJntWMkOv5E3J/CEVGWRFgdsa+GlObkZCWWNG9iwd6tf6hVOjmBkp7OIXRdw9V5EdApnTSDekXhapeNFDj6dvEzQtJxNfrRKNclaqcoGGHivGfi9Qa2OzQdwQ8quDBuhMQsL3J+DXI3Uj99UGSPfK6rRIfatJeIh+h/FLxw/oDpgZvTrq6aVtlvdT9RfcFFon/ywcDbFCJNSJZUrIDJd3pRqGfwX6ySmreb/ebOwIfcW8CiIFZ0UJTQon7OHrx20LRVsl4YeRjcPpvoDvAK/a6IRdSHaoznAEiFA+pBmSDn+vgfu8A95V9N4HzT4LdJgY8HDS/vhT7E9knyWkaGpTPst9U2f8mGeR1MMGMxxzhXshyQuoVI9LSMHjRxpqqkOwaZd8chbKbxTpnylRW7ZCUQZceVWnWKskiwqsPCQruBvP6ztX1FIINOWbEBDekSczNjVaomovQBU9VSGH43oZcRHXa0q3g56Icvn2V0GYMCzKDHxJagq8Xp6udTEZI5Dd1OdHIz4XuOM2Jvw1kAq0DDUgqBh5pbkwUfxywcGBwYiDZ3+XVJ83CmUYNhfTzKuHh+5cVIwogeip2FysiI2scAH+x+z5quKKprgfgtF4r9bvY2fNkEEQF2hMGt2nYAYpgdba0vFQPNy36YIALXkla6A1lbHsqZ0uT3HzJZguGc1OjQDN3/4KCtDwbpMnK60SoUR5vTFXVwpXj7DcJg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUw5bUMxM1pOaGNXbmZNYW5tK2kxU1NNRGlFbmt5MTIxVWpySFI5bFE0bjdM?=
 =?utf-8?B?ekVST3pxZWpTNzZOVFY4dS9qNjJsTGF0RGR1L0c0MDJXMmxacDJlVFdjYVE2?=
 =?utf-8?B?cWVKZ21xK1N5b0tjU0d3cUhQRThLUjBTTXo1US9pZ2xoVTZpM2xtckR5UG5j?=
 =?utf-8?B?bzhFN3ZkZGtBQWRzTG1QdmxNRDFoUW5MR1JNdE1ESS9HUXlocmVpbUNmWjg2?=
 =?utf-8?B?b3pXUk43OXJmUXV3WXptdUtOUGpEdnRCeEtGR3NHdGFReTByS0EwbnZNVExp?=
 =?utf-8?B?WXVrS3VGNWhKN1A5RlZzV0RjWGdnK3Z1QWduZ0VxUEl6RzRDOUQwSDZ6TFVM?=
 =?utf-8?B?Rmw3MjlOdjJhZXEwM21oajJUcVdCcXZpbjdaQk80Q3ZzZ2ZYcEdUZUQ5TGc3?=
 =?utf-8?B?NUhRRWVYbElJV21PM0MwTWxieURaOTE5a29KWjk3YlVqamZDS2p5V0cyOXpy?=
 =?utf-8?B?R0dlVFh5VjQ0WUdkT0ErWWgycSszMlRUeWF3SmM4U0RESFh5Nm0xOUJsTG9H?=
 =?utf-8?B?V29Dekd3R01iKzFvSjFUL1hZL3ltMlBubXlTcFRTRzlYVnIwMjVWWTdvY3RX?=
 =?utf-8?B?NS9WSnBrSGZ1a000QjNTVUMyci9pWkh5ekd2a040YWJJVk0vUXBHWnFvdTFZ?=
 =?utf-8?B?LzZEelpWeTc4Zi9ObE93enQ2bW5qRU9hSGJ1YkMyMWZMdEdIdThUTGJOVFEy?=
 =?utf-8?B?eC94MEd2dng4dHJTblh1YWEvTDRmbHFuQ0JjT05ER1UwOUdUM00yMEh4cytC?=
 =?utf-8?B?MXpVNUxSSEZMRzczUEhCUFhHb1kxdXJzRFBMNGxhZDNlYk1UbW50NUFiRStn?=
 =?utf-8?B?Nnd1cU1Db1dzUUVUazJQeVU5SnF3L0FYNkhyblBwMzdHQ0kxZW8rT25jUkNa?=
 =?utf-8?B?alVIYUhSWHFCcXdKb0tnWSt6cFhCN2RHbE40TGwwOXhTMng5cWFROU9WSTVa?=
 =?utf-8?B?a3QxQXVTZUZIK3BHME5VRGU4aXUyZWl1L2ZNdjhDVVNVUEVXNHc0MHFrM1ZZ?=
 =?utf-8?B?SHcrTkJiTjM2bjlnQ3ZIaWxwSERpN3M4OERLakdabUhRemxaR2V0WlhnaGFu?=
 =?utf-8?B?Z1dCcHZONndLQ0w2MnlvaGpUSlNzQ1FlRE1nQ0YrVGlwcUFUTUZoRFJYdXhV?=
 =?utf-8?B?VXZNWTdCNjAyV1g0b2ZETUhEMUdVTmd4eWtSZU5vNjZicllRMjY0akZpQmhZ?=
 =?utf-8?B?Si9sNjVCem41THE4NGZqdGlpdUpiMjc1Wk9JcngrNGljM09VYmpFWm85QW45?=
 =?utf-8?B?SUU2YVBZTGFSMkxqUjNwREFhb2lvS0xBMC8zU0t3THhISWhQWjRpSFp1WExW?=
 =?utf-8?B?SmFoNklYbkI0SHBEZ2F1ekV0VTJpMldHYUZYRTNRKzMvNERsNE5SUDdPOHJ5?=
 =?utf-8?B?ZkhsVnB3eTg5eTVTdDJRUnFRWDk2bjNMaXpnRmV4S0RVdUZLQXRlN1Rqc1Fm?=
 =?utf-8?B?cnhZQnpKREdyYjRmWk1uamtuaWlvdmdrOGxtYjZqV3RUMUdGQ1g3NWtkUDln?=
 =?utf-8?B?aklzdjNObDBDdWRVYnIzVS8yZkFqN01mZ2pOTW5PbUpCdUNLRWlWVTZkZXQr?=
 =?utf-8?B?eGlxU2Qzd09vL0NXZjBvUktqQlFGNkxqc3J5eE5uT3RSQmhTUHc3dExpbk44?=
 =?utf-8?B?UGI1SWJYNWoxN0haTVlDNklLSHlnSFdsMTlma1ZXY0tRL0xoNWUvRm1CVmhL?=
 =?utf-8?B?Qktib2IxT04wZ3phcGRGcHJsY2xWcnZIR2dFMXN5NDJ1MkUzenF3L1g1MW14?=
 =?utf-8?B?eGRJL1FqTDBUbklmMVpFRVc3czIrK0g1ajJITWhMVGRsSE13SnNJcUEvb0Jm?=
 =?utf-8?B?cVFlUm1Pcmk1RERnSnc2Y090dDlGeEZ1T0I1ZXhaWWg4TnVXK1hqZkNxY1V5?=
 =?utf-8?B?MmRwWDlMcnNRVHRLR2Nna0NjUzlCRkU4Ukg3VHFwS29DdlpXalB5NUpuRllK?=
 =?utf-8?B?UFlEYjRTL3lkNkJDdmdSNi9LSFZVUTBtNjU3WXE0WVZ4aGZRdjdSK0dlNC9a?=
 =?utf-8?B?Z25iOEN6VWh2d243c2RZZE5ZZWxHUXMrZHhPWEQvVklWUThxSDF1RlNRVU5P?=
 =?utf-8?B?cm13bHRkT1o3c1JnT2NVTTNMRTk4TjFkeWxFbkhDQlUzTXB0ZCtYT0IyU0tK?=
 =?utf-8?B?dTJjRWhucVp2SlozRVpsSGJPa1R4OUtnVFp5ZE9qTXA2R1RSWUcxeUdZb3Jn?=
 =?utf-8?B?VWNSbGVDNjAwcGE2THQ0WjRvYzA0UG12TFB3KzQrZkhPdHNqTDZFU2t0TVpp?=
 =?utf-8?B?TWRFcnh2L1BUZGVhTUNGTklNbDhxYUUwMko5L244N2tObUlxQzd4Rm9UYUF3?=
 =?utf-8?B?T0NjRWFYT0VwUTJYSXNuZ04zdy9xbmwxaVhrR2JvMXFiQzViOEpTK3dNVnNL?=
 =?utf-8?Q?lyJAzIbz0ZexD9DU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE7DEE163F715C4E8560C7744D85597F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DldP87Wqjrv6eOlrSzstQEzCwzKqpn4srMS0rwwxu1ggB6Lyoqdrz6ZROmHykQ4t2xpTcVnb1isOSWGGUyIe0EnlibdgGc+enFhTmubUtoasLOiCk4ucvMcDXeZltayE7MvdocINbjLVO22egygkD5vfXGfIKNCh9ZoUsC/IoDshdScZOVxU+/v67CltMA2oPnnoepyKSWsF7Fc7mqxVeU0LHk5JenbLCPIXAgXVXZ/Vmnhqv5hMDYz3iQIc67MM+yoajCnYjTYm+N6kMfcfL7CrvDXpRRRPkh/Gp2yZCJqguXnyiIa7b+H4hmLJ5YYT20E1Pu4az8a5vr0WiSuHog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aad54a2-e107-4ef9-d0cb-08def7bc1ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 15:20:40.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XskkEy2lkZT0wyWyR/27R79Zk4CX/MloVAWrH5j3C26GgkV20bBBeonl1tEOdJPux+Xxo0ZSsbf859fW+l6RjXz5MRJDyjry816LygArFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9725
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTExIGF0IDA5OjMyICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IFdlIGNvdWxkIG1ha2UgdGhpcyByZXR1cm4gaW5zdGVhZCBiZSBhIGdvdG8gZXJyOyB0aGF0IHJl
dHVybnMgdGhpcy4gQm9udXMgaXMNCj4gPiB0aGUNCj4gPiBjb21tZW50IG9uIHRoZSBvdGhlciBv
bmUgY2FuIGNvdmVyIHRoZW0gYm90aC4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBHaXZlbiAx
KSB0aGlzIHBhdGNoIGlzIGhlcmUgbWFpbmx5IHRvIGF2b2lkIHRoZSBmYWxzZS1wb3NpdGl2ZSBv
biANCj4gYnVzX2xvY2tfZGV0ZWN0ZWQgYWZ0ZXIgdGhlIG5leHQgcGF0Y2gswqANCg0KSG1tLiBC
ZWZvcmUgdGhpcyBwYXRjaCB0aGVzZSBhcmUganVzdCBvbmUgbGluZSByZXR1cm5zLiBTbyBhICJn
b3RvIGVyciIgd291bGQgYmUNCnVubmVlZGVkLiBBZnRlciB0aGlzIHNpbmdsZSBsaW5lIGlzIGV4
cGFuZGVkIHRvIGJlIHNvbWV0aGluZyBtb3JlIGVsYWJvcmF0ZSwgYW5kDQphIGNvbW1lbnQgaXMg
YWRkZWQgYXJvdW5kIG9uZSBvZiB0aGVzZSBtb3JlIGVsYWJvcmF0ZSByZXR1cm5zLCBidXQgbm90
IHRoZQ0Kb3RoZXIuIFNvIEkgY29uc2lkZXIgaXQgYSBiaXQgb2YgYSBzdHlsZSByZWdyZXNzaW9u
LiBXaGljaCBtYWtlcyBpdCBhcHByb3ByaWF0ZQ0KdG8gYWRqdXN0IGl0IGluIHRoZSBwYXRjaCBJ
TU8uDQoNCj4gMikgdGhlIHdob2xlIHNlcmllcyBpcyB0YXJnZXRlZCANCj4gZm9yIHN0YWJsZSBr
ZXJuZWxzLCBhbmQgMykgdGhpcyBwYXJ0IHdpbGwgY2hhbmdlIGFzIHN1Z2dlc3RlZCBieSBbMV0N
Cg0KVGhpcyBpcyB0cnVlLg0KDQo+IA0KPiBJIHRoaW5rIHdlIGNhbiBqdXN0IGxlYXZlIGl0IGFz
LWlzIHRvIG1ha2UgdGhlIGNoYW5nZSBhcyBzaW1wbGUgYXMgcG9zc2libGUuDQo+IA0KPiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FuWHhCek80MV81ZWFhT0lAZ29vZ2xlLmNvbS8N
Cg0KDQo=
