Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EB43DA50
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363277; cv=fail; b=Ed8qYJcBa+RXTCJIMkUdNZK9j9Zy4A5YwaPl6KdtsRnv1p4iqPCGVk0LjlUyX692BtNKzA55nDhUE2IcLoWIXqmSV8axRQ0rnciHWT+fgem/c9S9y5GhLLTNhtY2WP7H98cfp/96oG4MX8h+2GPDPyjbsEvYcW9LcyNKbVzMcFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363277; c=relaxed/simple;
	bh=gZ+xU7EYS5xpVTCz4b8z9pEghKjphwKCWwL+0IRXzFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xo8mcf/DHb9Ku4tIqijMDBYdX/ryo+ahy86ia+4llSwrHomdglGmzgrCARaIOoLBESoSaex3DUzJ4ns6YhUOYHSXqq4CWCVVYcyv6kY8OTjEl1QwMSfMr6r2rzTIIQyEtO8cOA2axQydjlj+OCq26ZjvgfkTA1eroAahdCxR1BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmswq1zk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmswq1zk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785363275; x=1816899275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gZ+xU7EYS5xpVTCz4b8z9pEghKjphwKCWwL+0IRXzFg=;
  b=fmswq1zkkVKfvVlGUjL/pq7I4tVpl1TZIbnpCl5VIycKM/H+ObLCtOvA
   g1wHfLNrco/nrOjkS4WwQ0/WAPu95BVgy6uR9Az2pNoq2b9Rh39l6TiKY
   wFOOuV9JpOqzIwdZcWJiuVJ99T6j24x6XW0mYC+bsiTbgWJDAKIrKiWOz
   SiP9rmG/UQM1dnclxlN09wHiXHaG5bH68NMBzCAOeEVKA2tcTGRSkfPv1
   ELPRsBlNQDP7iyWxW/CT9x/kBD4sKcbNXigqjsdUPbNQyb7Pf7XydgSuj
   C3zB+NV1IUUU6fYzP3gQbdGNyIKIBk+0B4+4ytYnz+YcItN7SIhPKP3B7
   w==;
X-CSE-ConnectionGUID: Okk78SkdSY6XSZb6QhDq1w==
X-CSE-MsgGUID: INZS/XGnQYeJEIOBeI+R0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97135310"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="97135310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:14:34 -0700
X-CSE-ConnectionGUID: K+8UkqwSTNyviKTBRYh6eA==
X-CSE-MsgGUID: zwfWSQTXTAuXXSpA0+xL7w==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:14:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:14:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 15:14:34 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhtbW4RBRfpo10vEZZdY6SYoROP9ue5AIQ73umyHwIk4NtCL+6Bc/+JlZ59XlsUINGFrB40LPrk/qBJuTF1aIEaFSrjVL4OYtF1gLSYwg3pcOG2Iv8nZkN533bbieoKpIeT4O0qNEGsIb9yAbl85IyEYaqKQ/eVZOwNrixSu4MWFRGBN86IGGXJbwWhugg1jhjAgGztMfIoEIIFg+nx7wOWj5OYypkXaJlb4kIekdinZdD9mINMxPKIrjzgG66MdGOB8y2M73QNYR2tAv0twJ60Akf9jGa5SGoEZZgqhaOCe/M5Yr+tB0/neEEsi7C5aPxQKqDcmSCDh0DWYGVW47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ+xU7EYS5xpVTCz4b8z9pEghKjphwKCWwL+0IRXzFg=;
 b=ozLiGG73LcBNKu1pC4d3/8Lmejj0mOPRa7+sx7Om3sDUMJm+loqUk2s8YM9cxhsstILck/z0lSel9Ho8w2i+66Z5W/jLDpgVZq1ECg4Ch+i4uhumxAD0uXghctZifByXvcnxbK50P1jH0a5AbmOz3kcd66ihQe6JrJ1i847DVSB9aYh9Z0PsIIX1CXkO7waE3XTgjco5kwinsoWxIbWdGLkazn85GcHq0c+qWSW71W7ie/HNrCElB1bv/xF/JLjA42uMi3GqkPRqNIMMGvAFQGHhhCeOEAfCLPXW02jCSib8wt7oSgz4wYv9nlLj/kBQLOoHMCqTSDz1yYKrOTPLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4608.namprd11.prod.outlook.com (2603:10b6:806:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 22:14:32 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 22:14:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v8 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Topic: [PATCH v8 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Index: AQHdG8vQOqWpb0STrE+eSMo2WEimzbZ9YuaAgAe0wYA=
Date: Wed, 29 Jul 2026 22:14:31 +0000
Message-ID: <c1db916496c52b76eade934df73e65288067cea8.camel@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
	 <20260725002302.3337017-3-rick.p.edgecombe@intel.com>
	 <20260725003343.65E951F000E9@smtp.kernel.org>
In-Reply-To: <20260725003343.65E951F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4608:EE_
x-ms-office365-filtering-correlation-id: 3ed078ee-bd6d-41c4-ffcd-08deedbec3f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: ZY1tssTYxtUU8Eu9r+ny1guCZxZjViyLE63ObLZMKZO/7nOie7Qojv9vWATlF7m8ykQAXm73WEjES8bxmBnQ8UF6P41Ayfu1Cr5vt0y/UWiUvtuHJeuLTVRkq8PMw3DFJA0WLRP7VscUZkJO9H3guuTYaDfNNKEdFr4nunWNvOut/EPBBKSCnrGooK5Tp9g8CmUw5thm66KtuK4IvYeZ9AJkpfed0NAsAEwoLGBjNuiUJ/QPR72TWjPmSqThaz4MSMVE9E52yFUGdoUJNFG3Q0jNSDX9dQK7UyAhn0RToV0RuqTb6uk11RbxcqOiH7MvUsZKy/LPQ5t3IKx9+llc4DLo14MY1Hl5e6cZ12nALFNwCyCLqFG6I4lm7e+74JwD1Zacr46tNn2JgFaPYef+SMjZtWX/sKq0+zcFX5AsPSTsazm/5JmFVx7iJ0B4WEztSPx33aFxBIGHb5HBGexmPhdUHhyDbEJOyqt9RwaC3+h6lpysIbFE/YBFrBkYxmM79YOshPYqOVm9BVO4r1VPOQO6CLrYNwdAMD8DNmbGN3VuTzItxehQiNCowj3a89dDWxMmhuEexN8kepVXtuRFIA2dzYdfIE7JfcXjoBVLh8n7CmFWRwYJWYofzDqdDgoODc3SuPrCMawakvXx+wGJbR4uebyyI8jLNTVJAPIHtQNuty6pJEj+LhlTAo+PHizoB04/YRxbW54aoMsw0Bf3AhPsf7MdwnAxbLHsd2kDCwI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC8xbGxDcG8wOXdqUy9TeXNRWk5NcFJ1S0l0Q1pGKzEzZ01HZG1SQkw0WFdP?=
 =?utf-8?B?TVhFTDZuZmN1S3hMZkpIWXhlYTkvV0M1R0JDVitqU3Q4SEZSWWtwZU9qdk52?=
 =?utf-8?B?VkM1aG1LKzYyb0s2elRFZXdXbDJVYXlKZmxmdGdFdjdxZlNwd3FiM0JJSUtK?=
 =?utf-8?B?NXVtWFhacGQ3aWdmWk4vL3U0aC9mMDBOV281a3NrRm04NVhpbk52T0huSnY1?=
 =?utf-8?B?UmtyU0pTRW1ITklJWWVmWTJkK1VmSWxOdm9TTEcxUUpzaWU0SmVQblUxT3ZU?=
 =?utf-8?B?VzJPbjg3bTVPenlyVjdSVzZpNTI0T2I4WCtmV1pudWZYMTE5OVRWSVpJVnlS?=
 =?utf-8?B?STR5dmdGVmRBZGxRa3RKMHJyRFc2K3YvNkF6MW51TXVtMTA2YldRZDYyZWgz?=
 =?utf-8?B?VWt1UlY2OXRBZEhUcXE3OCtwZ1BnQmRhNFBQR0hMa2syZEdsOEtLV3kzMlRj?=
 =?utf-8?B?Q0Q0Q01XemlVZTl4Vk1aOXpkQnZhS3ZJSzZzQnZ0cXBZNWRZU2lQTzFVWGFJ?=
 =?utf-8?B?WjB3ZUo0UldZM0x4bWZ3d2VNL0dkY1lzUmxuZ3REL0V5bjZRU2RyS2NySEU2?=
 =?utf-8?B?YzhwTmYwTmE1enA0MEpWRjBoakVJOWE4Wk91NXhsTFAvclRWZ01UYjc1L0lS?=
 =?utf-8?B?cjg2MmdpcStBeGc4SlpjdWw5SXNTMkVHaStDbGxPMjYyNlhad0ozUUQ3UGRl?=
 =?utf-8?B?YWR6eUtkT1pwcWlJRjdodlUwQnNoVXB2ZHJHdC9LKzFXT2dkUmRkckZqSEJZ?=
 =?utf-8?B?dnlHZ1RNd0ZTMjNEZlVWOGcrZy9yZGczVm9tOEU0QXV6dUNGTWVoa1Ezd21Z?=
 =?utf-8?B?QS9vTldtd3A1NHZKQjVaandJdEVKcmE0K20xRlArUWdQeVhxS01ZbU5QdjRm?=
 =?utf-8?B?L0hpNTZEeE1jZi9wVVppbzFmeFV1MnZ5RmdDeURrd0NqOWlCVklzcjFZV3Mr?=
 =?utf-8?B?NW5IWGV6U0JRa2Nvc29VMDlOTkthLy9BWXdBNGpoV1VYYmFLaHVkcGdCVU52?=
 =?utf-8?B?azA4eHNKdk56TFZ3RjRYRFVJT0Nza05mVXNBN0dweFc4d2NXaUlUZ0U2L3d3?=
 =?utf-8?B?SmY4UmlWZnZkcWNsL0diZ1J5bVFVejB3eU1WaFJ4bWM2K21HWTJmUCtrdHFM?=
 =?utf-8?B?QkVJT2R0TGpVbXpNbUdHYm0vclJ0MnROR3c0RFFhblJtc1VOS1h5RFJUdlNm?=
 =?utf-8?B?UWRKSklqTTdhaG9OdnlWNWNaQWhyZEZoQ2pIZEo2dzF1UCtvczJNZ3JHd1cx?=
 =?utf-8?B?YUlyU3lKRnBKdXl4L2ZZdkNMQzJBdnhrVUdVRDdWcGdvS3hTUXBBa0M5Kzcx?=
 =?utf-8?B?dDNyTGlJNWk2QWZLT3pRTjlNS0xsWWFKMElNZlZBWDc0Y3JvYjNFdHp0UWFL?=
 =?utf-8?B?QmJGVWtSeG9DZzJWamxlTjAvd0U2NWRNSmIvR29Pd1hjSndUTjJTL0NzWEZW?=
 =?utf-8?B?ci9JcU1UbGRSSnE1a01ZM2RSWkJCTDRCT0UyOXBVWjhpNUhGcno1YUZ1Zmc2?=
 =?utf-8?B?TjlCZEk0cmk2R0gvRFY5S2tuWWZLVjZkNCtiTlQ1NkpkVXUzQjdkdWRUNVBO?=
 =?utf-8?B?Ly9ObjJKd1dDQVBTRGlLZGpXRi9qNGlOVlBHdWdBL3BhOVh4NkhqZlN4c3Bj?=
 =?utf-8?B?aVpYanZwWVNQeDBXcGNuVTBHSlEzbFJrUGtyK0kzSy9FUGEydEt5TUYwcUJy?=
 =?utf-8?B?b2NuclY5OGUrUlBzSGhOc1dLTDdqdjU3aEU4WFdGZUNVNDVTeDFhTXBjZkx3?=
 =?utf-8?B?a1laMUN5K3BhNW10Q0ZMN2tBa0xGOTQ2bkxDRDFxdVJwU2ZhYTRhSDA4N0Uz?=
 =?utf-8?B?VEduRmxhSVR4V0w5c1k1KzN0cW1XTE9GeWpTcjJGV29FRXEzUmpoc09ORXM0?=
 =?utf-8?B?c1BKMFF5dC94ZzFLVDFzUWlvQlFMaThSZjJDM043cyt6cXV0VXFNSXoyY0cv?=
 =?utf-8?B?d0dDejlXYk1zT0tHc2xQZ3JoMkRrYU8vcUVPcC9Kb0JIK3BLaGJzcWxmVFBy?=
 =?utf-8?B?WTloTzRUck9vM1BodXlyQlB1R1R4MmJydUFFQ0hrZHBiQjZMWUtSS2N3RnpZ?=
 =?utf-8?B?cnM0L3dBb0NlRWtkbitNYk5pS2pZbHdTd2cwMlRhZDB4cUxMRTV2STJiSTcy?=
 =?utf-8?B?ZTlwUUI3QnVSbFhlSlRiRStEcnhtUFNVbVRPOGVhZ2hiRk45K05VZ2l4eGZR?=
 =?utf-8?B?VEQyNUVNeS9EeHZkN20wUnF4VEh1eWdEYXd4c21CUXpjcXdSWmJ3RGJCbUlo?=
 =?utf-8?B?M2crYmxtTVM5Tm5ZbUcyRUVseTNMUHB6bTNjVzJlQ0QyaktnbWplREZ4eTlq?=
 =?utf-8?B?ZTBDWllLSVc4RnNjWnJZOWdrSkNiMXYyc09MMklVMFhXS21tbUF1TUtabGRU?=
 =?utf-8?Q?+6tRXoErw3jE1M6k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1F38AF14DC7014899A5481A22C926DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iKa+1nKuZjiHQwpkHHdTgqk6zPYK+F78vgknuov5K9bT0QS5XiRPdhU3OkHO3+kpxStXVSoDYJE6y206Vxf8OB+JYa35wTu7ZuJLEeyRSJEh+gMhGgqKruo7rW4CBi/amgbGfmkpv+g22/JlyMhC2808Anh9Gv0vWer7ptMtPwX3AYfsk9FaMrMnrWRd5BxaU/7Jb4GXEslMMBIb3ZuENUjIxuEyExv5lKA9M90Tx8ETe78Sl7rmHUdmgHnglw0poa4xi1HbYKPr5/nZgvFxurmAA7WWmGwILGRO7A9wXnMgs2Cpn7pBp7eYRA/K/owYnR4v//2FstpL3LOpcgiMmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed078ee-bd6d-41c4-ffcd-08deedbec3f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 22:14:31.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbcR9eK1Us1pJEYUM2mOm+qdd2I5TX7kl15W6FBsN7o4E2G5CpfMVJ+FO1Vt078OuTNkCETrSr+gTovXEi7/em2UIdt+aDCv2D/c3ehVYgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4608
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA3LTI1IGF0IDAwOjMzICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gRG9lcyBhc3NpZ25pbmcgdmFsIHRvIHBh
bXRfcGFnZV9iaXRtYXBfZW50cnlfYml0cyByZXN1bHQgaW4gYW4gdW5zYWZlDQo+IHRydW5jYXRp
b24/DQo+IA0KPiBTaW5jZSBwYW10X3BhZ2VfYml0bWFwX2VudHJ5X2JpdHMgaXMgZGVjbGFyZWQg
YXMgYSB1OCBpbg0KPiBzdHJ1Y3QgdGR4X3N5c19pbmZvX3RkbXIsIGFuZCB0aGUgbWV0YWRhdGEg
ZmllbGQgSUQgMHg5MTAwMDAwMTAwMDAwMDEzDQo+IHNwZWNpZmllcyBhIDE2LWJpdCB2YWx1ZSBh
Y2NvcmRpbmcgdG8gdGhlIFREWCBBQkkgKGJpdHMgMzM6MzIgYXJlICcwMScpLA0KPiBhIHZhbHVl
IGZyb20gdGhlIGhhcmR3YXJlIG1pZ2h0IGJlIHNpbGVudGx5IHRydW5jYXRlZC4NCj4gDQo+IElm
IGEgZnV0dXJlIFREWCBtb2R1bGUgaW5jcmVhc2VzIHRoZSByZXF1aXJlZCBiaXRtYXAgZW50cnkg
c2l6ZSB0byAyNTYgYml0cw0KPiBvciBtb3JlLCB3b3VsZG4ndCB0aGlzIHRydW5jYXRpb24gY2F1
c2Ugc2V2ZXJlIG1lbW9yeSB1bmRlci1hbGxvY2F0aW9uIGZvcg0KPiB0aGUgcGh5c2ljYWxseSBj
b250aWd1b3VzIFBBTVQgbWVtb3J5Pw0KDQpJbXByZXNzZWQgdGhhdCBTYXNoaWtvIGlzIHNvIGtu
b3dsZWRnZWFibGUgYWJvdXQgVERYLg0KDQpUaGUgc3BlYyBsaXN0cyBwYW10X3BhZ2VfYml0bWFw
X2VudHJ5X2JpdHMgYXMgYnl0ZSBzaXplZCBzbyB0aGVyZSB3aWxsIGJlIG5vDQp0cnVuY2F0aW9u
LiBCdXQgMzM6MzIgY291bGQgYmUgMDAgYW5kIHN0aWxsIHdvcmsuIFRoZSBkb2NzIHNheToNCiAg
IEFsbCBtZXRhZGF0YSByZWFkIGFuZCB3cml0ZSBpbnRlcmZhY2UgZnVuY3Rpb25zIChlLmcuLA0K
ICAgVERILk1ORy5SRCwgVERILk1ORy5XUiwgVERILlZQLlJELCBUREcuU1lTLlJEQUxMIGV0Yy4p
DQogICBpZ25vcmUgdGhpcyBmaWVsZCB3aGVuIHVzZWQgYXMgYW4gaW5wdXQ7IHRoZXkgdXNlIGFu
IGltcGxpY2l0IHZhbHVlLg0KDQpIbW0uLi4gQm90aCB3aWxsIHdvcmssIGJ1dCAwMCBmb3IgMzM6
MzIgd291bGQgYXJndWFibHkgYmUgbW9yZSBjb3JyZWN0IGV2ZW4gaWYNCml0IGlzIGlnbm9yZWQu
IEhhdGUgdG8gc3BpbiBhbm90aGVyIHZlcnNpb24gZm9yIHRoaXMgdGlueSBub24tZnVuY3Rpb25h
bCB0aGluZy4NCkhtbS4uLg0K
