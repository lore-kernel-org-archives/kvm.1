Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56573AF64D;
	Thu,  8 Oct 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478698; cv=fail; b=byUyUdQjkhyXxW/nHFA756IiznLlOg9SJIkdXnD0/1ztrTrFs2jUzZgdOlpf9TKftIpZ18KKs5z+JBrcL3iKIsjZl42N+QhK4lVD4uHx4ET5SoFXWD6vIb3lDu4dFIn5YQdo9jvjgWzI1gQSiO/q3oaY6+QWZuSl3qAJbaqoDOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478698; c=relaxed/simple;
	bh=1Q1erSQh/NhiNyDP4IMWSIXwUX/icHvjzyrp1V4lOqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikDPMQZlCeCtqaHI1oqIAr9IVugk3XShzFlenjTlu+uukc5c4uygjqF/RzdkjP7FmcaVnYNEBYekPIJBjYVJuTGvscrRkWZZFRnc5lzh+tIuUe5a1Eq8COAaLilPaGHujHNrymJZpyATElPOd5mMKfEY30NsqZBOTi4188TB+Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtKyZb+I; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtKyZb+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791478697; x=1823014697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Q1erSQh/NhiNyDP4IMWSIXwUX/icHvjzyrp1V4lOqQ=;
  b=HtKyZb+I1l8YJfWDKVmf6TPJqb7FMtp6iFbb+mmBJkEvIK8OIBKkzqYc
   M8P2yDqS2A3X8btS56zdN5927kkyHhBcDhhIG3n1ZQGey6RedoSMFq670
   Uyw4Iti1JPRc+dIzleXzbQ/UNLowUMw1QMX0Vc+yg8qediesFxAjLXDJk
   C0o+fiYG67ELBr371IyC+LfTx9CP7zZddAIert9Q1mrmdQf+bmMJwDTOE
   Ir7VtMMBdN638gGKsCyevCVj0ZOneguZudp77ZxHnT0fxOZ8M1OXXYr0d
   jxPfxPzrQfDD8er/XGUcqn0ZtLIE05+WgqK9yMwZ2BzwbM1wmpWm/UgFQ
   g==;
X-CSE-ConnectionGUID: RpwnHP8LTOW6rZ5UvbPFVA==
X-CSE-MsgGUID: eY2fnQBZShqTeMhdS2X6jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="151946"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="151946"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:58:16 -0700
X-CSE-ConnectionGUID: CwdtkybATNWxN6f57X4uZg==
X-CSE-MsgGUID: HMUq0+B0Tv6LCt4qkRngMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="90865"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:58:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:58:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 09:58:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:58:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0Jpz92ZUaluWe74QULm0lXMJzIyVHEzK8lMkkCYUzBa6pYLicaepefsJ5wFskZ1yt2W2htQKUU9l0M/SE3dacuNtxYXw5saM42opqwCEoyzpzQaaSE66ZOe66gbMuYA7DuW86fbIeN7R1D6sZNWz2mJqbQl5QBgIHO+kuunTdlEn8VWTSY98ZG35nAidqpmvtIaiXXR5J86Mm8zoR/TcP3DL20J0eTjIyKDbiMrdRHIJii3pqSlRmPp811NCxKfKfZVAX9wLmXrLQHqd50f88al9/vliKeU7yjrbMh3FRtrAJoWK6mKHlSr+kuUF+tlE7XNlgEZjmRhHbESI1r1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q1erSQh/NhiNyDP4IMWSIXwUX/icHvjzyrp1V4lOqQ=;
 b=i0vSdFXOHYFontv9tgubv53rNZbypEEQshlvRSIqgC6eGpx3ZyLlPRGrwhR+r/PKA8GaPdUBi4RU6KalXuAYZVUwF1hPm1HSYdel8+GMxk3MAGY/zhpOpxCNzPz0WPp4GTUcVPDJ4V2+9//amWledU17ApZyyby1UdbGFNohfLEpEwGgBg1SzmSQBOfhLp8NJAwi4VXh9eVqYzm84e5t7QoPmcT4MmhNCXcyJxZ3Q8CWcMvRXuxG0waRyl1fjq/PlLy91U8QT15aqokIKvkbycVP9yDWJycZTeu1HFdZjdu7LMhNFuKpvhiaOqAaM6B2s0uhyqQFhNE0O1/bvaz3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 16:58:06 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 16:58:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Gao, Chao"
	<chao.gao@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Topic: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Index: AQHdUJ5NzYgwfL+kLEuoLMeKgwDC67bz6C6AgAAC9IA=
Date: Thu, 8 Oct 2026 16:58:05 +0000
Message-ID: <794c12ff2f3759163bcb27465ce03e507e2910f0.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-3-chao.gao@intel.com>
	 <asfJI+15tQivvy95@yilunxu-OptiPlex-7050>
In-Reply-To: <asfJI+15tQivvy95@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB7856:EE_
x-ms-office365-filtering-correlation-id: cc960fb0-ee09-4031-379b-08df255d52b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tGrZoW2Gqvoc2VM8uPcNyhciq20C1roYRiSoavqEqBF0ZZjXjHPD9ATaVOjiZpGc3OUDGO/B1om9R1YWGwGWfeJ5A9OhLsJ3698uxb78PRgMkszM8Z6s1b+QG2ruEoGI71SkYZdVNrZelov03w6TaF3DVNU7blVWZEQCmiOnu8o1CHoYoixIxVthaPI0GWByD1pNVFFY5Bu7yla/6D+nxqYRnGUNaWukS422fR2AQPLRbfCHndnH8YyMMBnO3bGuof1DWBA0aFD9BayK8OFXci2z44y+f93EH1JV/UZBeJmpMfxMzWiYrRHBJ/4wn46sn5iNtR6Cefo8xCik4JSM8bpZBoQiyOY4wyukwcB5eANi3Rbm9J1cRShtNPl5HbTCF8acRjwf5TFZew1iFP+EZzOdhKV0UTXSi2CxjaTzx4hVMp191+6HaR0eLhOb2sBlSsP3xo9zxPESqD6eXgp+rnV4Dp6EfmFD/BWnYZAlCvIlAMZoW7l38R6t8bDWsku4GJrqOxpkDpaz/oSoW6ACVMYXhGkLpmkZgNK48G7Kdx3SYMjOtHrOJ4YRZtJ9Z7VGpg9KWxEIdUc44xB6bzx9k2ixyjJmve2EDLRlty/l6A6esjjNZTGVD9w0fWZx2a+pCCXftSURGi99LOeUuP8oQkgJiBs4AoyDoVLFmr87iUHynhO8wVRx70P+XV1nV8dV9X4j/ER4R/vqQqH9Zd5kF+G7pdSS7YloVBI9GDVwb8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUZiOWhiQVNSbzVjMU5WR1JiTG82b3NtU2tZUXR2d1FzSGgxaXZ2cXB6dTkz?=
 =?utf-8?B?RlFrWGRPSTE3TjYvU2xVODF6bnFQY0FXeHhPaWJYbnVvTDQydlBDeTl4cHE3?=
 =?utf-8?B?NlZDbUdqa2MramVPVjBhNTR3UmpLRE5NcG1PSFJSRmFmL1YwRHVZVGxraXp3?=
 =?utf-8?B?ZXlLRE5wOElhZUg3S2FJWFNxdDVNUnNEU2tZVmQ3dmxENGF3aUFadFZ0bCt0?=
 =?utf-8?B?VmhiV1ZqdndoNm03NEMwM3R5SFFZQ3NlNHZuZTdZWkYrQmlsUTdMdnVjVm16?=
 =?utf-8?B?VXptZ1duSzJodWRrazNkSzhhNWJTU1dIdnhkK29tWU9ZQm8xTWh6am1ub2J1?=
 =?utf-8?B?ZzAzK3Y2NzAwRmxmc2tTbGptblJLbXpPL3Rqc1dOYnhPY1FPNEY3cERqZk1E?=
 =?utf-8?B?WUtxeXRtdWF0WDI0Vy9rZk9LRmZRM2NrK2w3OUxuUHRwdmhlQVhQc2V6QkJJ?=
 =?utf-8?B?WTdobFJocmVMWHk3OThwRWFnZ2pVTVBIYnE1dHhHVm5ZYXdjKzVTMlN4VlNh?=
 =?utf-8?B?N3RTbndoN3RjSHNvYUFXQWZKRXlodDF3LzJXbXRSVlpsR2xMbkROL0NxeU53?=
 =?utf-8?B?ZzRKbFllbUhrd3dOZW50QTlia2kxcDBlOTJxMEVvNkFiMWtIUE5vTzBVUE5a?=
 =?utf-8?B?d2J5MkZ3ZDdsTWRZMEhDWXpTZmJxcVViaDltbE9iVUVsZkVqUTViN29jdUt1?=
 =?utf-8?B?ODZOOUZCNWJBR2RnYnc5TFZQcjEwd3FMeVRlQzYxYmpsM3dWQlhDTXluaWwv?=
 =?utf-8?B?UTQzVzRwa1dUODA2YW01VlEzbE8wdU9tMWFuZDdpNkFSYmdHc2R3QzE5eWdj?=
 =?utf-8?B?WGNwQjJMZ0l1ZktJNHA3WmdkY2V5UklqNXlQWnE0SGdieklIaTl1VmRuWjB3?=
 =?utf-8?B?U3hsT0NubUpNdjNTellYYXhNOVlMMnhSaDg2NDUzVW1lOGFlN1VjZXRJVjNz?=
 =?utf-8?B?OVVuVk53bGZNNGduR1g3V2F1dWd3UDdxdWM5WnNTMS9aQm5DVjA1VGdtZEY4?=
 =?utf-8?B?MFIycW1zTzVXMHZQbGxpRi9jZi9nbXJxTy9OWVFkUUdrVDlHeFFmWE8rSlZx?=
 =?utf-8?B?eHE0TFljaUZSUks5UFZPemtYT3Z2VUswWDQrRURaMmJ4UjlTRlNzQTdtZ2JC?=
 =?utf-8?B?VDZ4cXROWEY3QmF0M0RDZ3dGdXhDL0Y4YmhzaERsU2VCQU9xS0RjeGVhZngz?=
 =?utf-8?B?Q2RWWDd4dVFVVkVCaDNWbUJsQkJDcGZ2L2ludTcydHdRT1loc0FPM3k0NkpL?=
 =?utf-8?B?UzlzYTVoQ292MUt4bnVneUFlK3JFVDNrOURkajZpeVJzYmczcHBWby83ajg0?=
 =?utf-8?B?WDBEWHBQMDUyUys4NWxHcHBNampxRGQ1SUk2U3RrZko5WngwdzQyWmkya0Fr?=
 =?utf-8?B?bEkzODdVMDdQNFp5ZEV2RDk0ZXdYTSt1TUsvUVpnRm8rVU5aSmFZcHVtaVpY?=
 =?utf-8?B?NnVuc2VUQmIzU1MwazYwMmNpS29hK2w3RzFMcElhaEtSaWppU2ZQSHRqRitQ?=
 =?utf-8?B?amRLWUlGN2xaTGU1aFBSSEl6ZFQ5WU9RSUFnU0dOTzdGdVI3a1c0VHZEcjNZ?=
 =?utf-8?B?VGFOS2xHZHY1V29zM1k5aXc3VTd0RkN1MWRheUpIRTcvVGEzYzZENWhqOEJv?=
 =?utf-8?B?RzhYbWg0SmdlUkw2cnptUWJJR3JESllobU5pd1lIcHlYb2lqYkRGVGcxbGhY?=
 =?utf-8?B?Nzd5U3BuV1R1Tit0UjIxQlJNTExUTEtFMlQrdkhaamtyTFhIaGNnaVliM2Q3?=
 =?utf-8?B?d0hDK2djSmZFVFVLZ0VEeUdzV0diMVlKSSt6UURZZWVYSTRNckZTSUJqam9W?=
 =?utf-8?B?ZGt0cjl1a2hpRklDWlhTTzJuWGFnUzh4NDJOc0tHbXBDbWZPV1pFeFZnZzll?=
 =?utf-8?B?RC8rU3dVNm5UVnBaZHluLzk1WW9PdlUwWDVxOXBNUmZZdGNYNWpkcFdYOUFp?=
 =?utf-8?B?Y2VzeDB1VklLSktwcllUaHQ1NE4vYkJKTWFOcCt0RWNMeWttOFMrZ0czbzNG?=
 =?utf-8?B?SE5sNzBTTEFNNXd4NkRHb2lKc0VackJUVEoyWFN3RXgzdlFPOVh2MjB6UmVy?=
 =?utf-8?B?WWpYcDJrc2pPbEg4NVQzSFVIeXNmaS9hb1NSdFJWbkFNSzdzaGlsVmd5b0Mw?=
 =?utf-8?B?UkI1bVBSb0NLd2pLOFJkeUNmdE1Ed3ZvWVFXWWttb2VyMTNHMUdpVnhPaUtj?=
 =?utf-8?B?bC94OTg5NUtjdFlBaVRCYVdidlczZmpvY2dGQ3NPTG5UZVlqN3BxV292QUlv?=
 =?utf-8?B?azN1ZnlEOXpuU1NkdnRZaElrVy9wUkc3WCt3SlBGaVgxOWxyUi8vTElYN3B4?=
 =?utf-8?B?RkIwTlpGKzNIdmc4TVhWRUZXQUJlZU9FTm5UeWFyRHFqaSthcHFzeGV4U0hx?=
 =?utf-8?Q?j+bESLITtJtQJF2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5C4F72E5B6D7441BF7E32C57E57198B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fc6U8bPEDZfXLgvk7a1perxEKd2aQkuG7yaveOI4R5jXHVKgOguet9ojfYF1cmSwnYtiMraz8NHDgFGX1iUWPTEvZdA8GwaNBujkbEI8VJo89u4wZV9Cbfe53czWR4pwbY/23HH6qt3YXOuE3tEhW1Iqgt2++k/3VVlxKqA9va0IjfSxb6XvtdEXtrbBSKeJJdjPPdbmx6+QvUrhyTuAzUZveL+Uof1dRSfHQtTNJYk/5DjWy+OzFG5EICFmEmMps6FvrSmvqqUfJJwdvf7A6P/wxfyJus1zA9rNm0zDBo6QAAwM6iACFiN4wAwZ8C0rOr9i0JoC9jYHlRInsPjwyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc960fb0-ee09-4031-379b-08df255d52b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 16:58:05.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZXZYuBlPIcAJariGii/V/yhYJ6KmRtOBGFxmJLZQZuQFpPNFn3MCDDfKpDYG7lbgO5JH3ZVESZCDxFHJHiVDNVE4c14NYb33dSFAGteHfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTA5IGF0IDAwOjQ3ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSSB0
aGluayBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nIGlzIHF1aXRlIGNsZWFyIHRvIG1lOg0K
PiANCj4gwqAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWVsZF9tYXBwaW5nIHZlcnNpb25fbWFwcGlu
Z3NbXSA9IHsNCj4gCUZJRUxEX01BUCgweDA4MDAwMDAxMDAwMDAwMDNVTEwsIHN0cnVjdCB0ZHhf
c3lzX2luZm9fdmVyc2lvbiwgbWlub3JfdmVyc2lvbiksDQo+IAkuLi4NCj4gwqAgfQ0KPiANCj4g
wqAgb3IgZXZlbjoNCj4gDQo+IAlGSUVMRF9NQVAoMHgwODAwMDAwMTAwMDAwMDAzVUxMLCB2ZXJz
aW9uLCBtaW5vcl92ZXJzaW9uKSwNCj4gDQo+IEl0IGNsZWFybHkgdGVsbHMgdGhlIG1hcHBpbmcg
Zm9yIHRoZSBjbGFzcywgdGhlIGZpZWxkLCBhbmQgdGhlIGZpZWxkX2lkLg0KPiANCj4gU28gSSdt
IG5vdCBzdXJlIHdoYXQncyB0aGUgZG93bnNpZGUgb2YgYSBsaXRlcmFsIGhleCBoZXJlLiBUbyBt
ZSwgYQ0KPiBURFhfRklFTERfWFggTUFDUk8gb25seSBjcmVhdGVzIGR1cGxpY2F0ZWQgbmFtZXMg
aW4gb25lIGxpbmUgYW5kDQo+IHVubmVjZXNzYXJ5IHRvdWNoIHBvaW50cyB3aGVuIHdlIGFkZCBh
IG5ldyBmaWVsZC4NCg0KSG1tLCB5ZWEgdGhhdCBpcyBhbiBpbnRlcmVzdGluZyBwb2ludC4NCg0K
QSBwb2ludCBhZ2FpbnN0IGlzIHRoYXQgdGhlIGRlZmluZSBuYW1lcyBtYXRjaCB0aGUgIkZpZWxk
IiBjb2x1bW4gaW4gdGhlIGRvY3MuDQpTbyB0aGVyZSBpcyBzb21lIGV4dHJhIHJvYnVzdG5lc3Mg
dGhlcmUuIEJ1dCBJIGNhbiBzZWUgeW91ciB3YXkgdG9vLiBIbW0uLi4NCg==
