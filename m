Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3941379C48;
	Fri,  7 Aug 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093132; cv=fail; b=LvTJdtCITNZXQdhe6csGIJ9pSv3Zzhw+sEO2BVtalBQx3fiO+1+PQfIFQWZf0Eu/FcZFwSje1jZ4gb/0f2ymoWNzsex5xu35Igb1TJ5iY7XNPAnswHWKodvNrafF4a7xsXD+QAA+u+wV6YR2OswV8w1U7TGUdUqEZJo6g94xybc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093132; c=relaxed/simple;
	bh=xcFXxqZ5IEYLAnLD7GLa/XzKG5V1+TjdIffVRWrSZbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0TcG6r89iJCJOKiO5z2aRo2vQMYuQ0zt5FDtGBwdYKLeJPOycmTr6xTtfMtYUVHCkxbEgrxyRZ6N0YWpAMqvuHxvSccNnK4uBmgj8zwiLs0gukZIA/xECFM5QhMH7LTGgiRlnOYobVyd+2u1HuL1LM0Xc96Q4gVarxgDiUyzSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RONen9f1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RONen9f1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786093130; x=1817629130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xcFXxqZ5IEYLAnLD7GLa/XzKG5V1+TjdIffVRWrSZbE=;
  b=RONen9f18A7deafErZfiWtDxD0koKslgaj2TG/FFZpLLHWuH8DTMhyu7
   UhDjcunsESJIsiU/lghpIuqcOk+catSO0pmSaYDgsx5kKlQ8AMxBJYfjF
   S7fK44YSb8WPf+P7DsKzyM7or7LzOorU+RlhetGfKI90LqXzCcwbDcTOt
   YPdIGlq1Ujrwh92tk6diu8YpADVuIEU2KCu6K4ViRbydX5pS1WHBEaGkQ
   XrH/jzCXqylscvewS24wS20On0IzRZqAvvawUSMb2t9e7vr/cnmICMIYQ
   wtsaJ70/QJvHUta0Sw5eUQyrbaa03RT7I/QowPuIZ0KpkhXeUS4KLJbU5
   A==;
X-CSE-ConnectionGUID: KjW5PotDSPe5W4uRUb84zg==
X-CSE-MsgGUID: wOI/1nSJRCq6ah7rzeMs4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98210078"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98210078"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 01:58:49 -0700
X-CSE-ConnectionGUID: IKgdM0V6RbynOfhi1WOJdg==
X-CSE-MsgGUID: hEJ5x64uQiWzR/jdTWf8/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259017913"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 01:58:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 01:58:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 01:58:48 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 01:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3KreKzoI0V0GuxVHU4dSAbn276PjT+/yN8yk1YJer4AoSwCya0tavuzJQqQSzAZV0sr2JzYUJtFjm9gBKPSnKje3WERj0BeoC8nrfLs+ZOr9KRUNJGvQId/fRdYEHyGxpnkOFTE02XWAxjasbH1MpFRL+xfECRE9jidQ4Lgr0flIAN1/ZHqZPoDvJMv97W36ZtVCmi/6rll9JrUUWoH40j4wWmK3tijYF97pvVRQR7JeYzQRMpWbyfgJt1yXZculrBmS/BIINjv4pGzOYZ4okRM7uw8yvsG8Fza7a6akd8XgfhgTibBeeGluuyOi+OHjJ/NYZY6by5ghYzA0HK2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcFXxqZ5IEYLAnLD7GLa/XzKG5V1+TjdIffVRWrSZbE=;
 b=J3JIXn09pR+gvWZbDprOt4XBL0RY+nVfMSY84D0RuDEwRRMTXnivoRlnSZV0g+erVKCKYak4CSPz53Y+LegjJxvcKRbgpFpF742wqNq8sY7gphJv7N1xxbN9KFUf3sn3SWzA4h+8DJKH7+NfcmyA7Fw49NCVCmvIxD0tc/WAhcrlmIgyZcuWkxpn6eEMHpM0/Gm7B9diqErp6T5jywVHpZEhVyECTQJkWHgcKUOVEwkgneuSNA2S5I84QwWl6wt1I6tP4Vj6uoF8XwH3VV84pJdTx1UnRhdalNpghjfaKVtrSN51MbkFNl48Dbyjp+Akv9sWFwJRzCXZxN50CPoKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 SA0PR11MB4702.namprd11.prod.outlook.com (2603:10b6:806:92::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.19; Fri, 7 Aug 2026 08:58:47 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 08:58:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault
 attempt/iteration
Thread-Topic: [PATCH 1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault
 attempt/iteration
Thread-Index: AQHdJexNDjIt6vwiUUaBrgN8NvgL4raSSg0A
Date: Fri, 7 Aug 2026 08:58:46 +0000
Message-ID: <194146f62e9f3871008c66e45f94c2677d401eb8.camel@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
	 <20260806214050.78058-2-seanjc@google.com>
In-Reply-To: <20260806214050.78058-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: 8ad28237-2bf9-4e51-955c-08def462174e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|3023799007|6133799003|4143699003|10067099003|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: p5LuNth42Y5tQcpTZx3UiZUJCnG5yljECSPZU32wcfx8ep4XFIwHJn3UtUPwp4otOgU3e4iIbW2vKvNlEDlYQYzvy/FP0V2YOvvwFy9xBiLzPSZjIkrhVrkYf9BolYD1jbJjoYsXE+Mfo6pstpVUAstkOiw3imo1SMeuamphG5ylmXBTnM5dtVqbJbioGTMJ8D38aWv1D4c+L21YnAZSow4/WLHhBM2hcI65NLmMUeFKvOoX2ebwRgtHmqEmTqsJY2KEGOVSUK68tTtreJNyhBVcLuk8DhvOJ9TZX52way2LD+Vcw5v5H8MqgwH0zBV+DljghGy3u4TBoKaxhFA7AtlCQfk5xk8nFbKSuw7/XDIXgadV3RQcdqi9xHWAbbNOTQSW/gZmd92C4ZTh3La/yckA79OjolrVEwotZKskWb3Hg52ccpnEy28wdjvvVsDLgOSS4OJfEJdg2ChePgnO8STT7iNhTnYEpshGRHeJY4Pyzg43xod3wK4nzc8hubPlAPKueHhR3nrNx+88fsom+FpCozIOeYHNvufaf87kr5hCthP1hHvryXz+kAsWl4NLhJAmzsyEMa6zQzZVVmzwj2hHpacYBlP4s+8JCjL1w3TSK+XOwi/xJC1LUzw517KALfz/IPgs1M7E6e5BFxEFv22+kBEzpB2P7QCHZPtKvdhP6RWfLjhm+MWFO25HzuIAq0Tt3YpUK3uUTbwwgQle8AyD66ET9GrzieQBiKsAFhk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(3023799007)(6133799003)(4143699003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1pkbW9tVW1LQlVUTmhRRXZJQ2trcG00ZGcyM2RNeUZTK0VUMUtsQUpHNlZu?=
 =?utf-8?B?cHVUcVZ2ejVkaUxFdWNNVFdNM0JqelBXR3Z6S0JuOEp5V25rWXQ3R0pubnp2?=
 =?utf-8?B?eDZmcEY2aWZlOVVDZ2pwOWZhK2I1WXQycEVQaWZWMk9xV0dYOVUxdDNtRU1U?=
 =?utf-8?B?MU9YYk9LeWNQWWpPSk9qRFphM05HbmtGN3RwcXIySU9QM3I3MSt6cVA5cFRW?=
 =?utf-8?B?UWpGZEYvR0lnTHBLbVhUTnFnd01yK0hQWW53SjVPb216K2FldktaK2RIeUN3?=
 =?utf-8?B?UHZQb1k5dmZmekVHRjMrcWFjWXFsOFJxL25zcVJrcEdoMEJ3c0VZLzliNXpj?=
 =?utf-8?B?Y2tldDl0K1pML3c2b1VGSmFZSXRHMm9ObkJEVk05aHovNzh5MlhkdnJUNVkz?=
 =?utf-8?B?czkyTTViYzRUYkJYQ3pUdStEZ2gvS1A2Q1N5THdVbzJGK1F5eFN5VVFxQkhy?=
 =?utf-8?B?RTJwWGxZRHdYanZ2bnNwVW5wVmNjRXZZUUZMdGlFelA2MnpscW9uSGFHbGpF?=
 =?utf-8?B?TlRMdWRZOThlSmZJQUtoU05QLytIVmltOTA0RVlhWFpaWW1pbEYwNytBWFhp?=
 =?utf-8?B?SlR4VFFCT1c4a3piMGpsZzZaR0s2WnVwL2g3WC80dEk1MDhmZld3UG5GKzAz?=
 =?utf-8?B?THU1emdZSmdudmU5K1BwTG8vVEVnYzRoRTVuMFRqOVFiaThXY3JkYiswV0hR?=
 =?utf-8?B?OEFaNVRoWXFld2NBMWN4OFlCbVVyN3ZCZksvellDR1hYclE4ODJDQ0p6UTJJ?=
 =?utf-8?B?WC9kUmZUZC9PSTVGa2pRQkVrNGVqck5tVGVtdkN2VFdoUUk0dXFnZFZmbU5s?=
 =?utf-8?B?d3cvWUt1SExnT09Ia2wycUUxN0JHb1I3OFE0a0MxanA0NXRTNzZHWHZDd0Mx?=
 =?utf-8?B?RzNDMys4ckJLQXBBS0hRbmI1TnM3WHgwNEpzMDVWTjZQV1lJV0tiTWFVa2Fn?=
 =?utf-8?B?VXI2aEVSVnhPVDhNREFtTjY5cEtpMm5vRVFWSFdNcm9JZW1xcEs0dFY4V0F5?=
 =?utf-8?B?c2FZaFB6K2ViWmx3R2ZqckFscjljUGVkei9TZy9odXRsQ1JNbStaa3FzTjE2?=
 =?utf-8?B?THlrTlBTNmt1U2ZaenRrb2FIOEhqM2xpckNuVkgwY3ErNDVMNkxkRmVqU1JC?=
 =?utf-8?B?OHZrZHNXb0EyQzhIMG1uWHczd01QN2RCTFZLZzhGTmFtZGYwcEVPcHRubFVi?=
 =?utf-8?B?cnJIWHdYYmZUYkRsNDk4M3MxZGsvNFIvR0RTazU4dGlxOTJ3UWhMenVYaGFH?=
 =?utf-8?B?MXprK1hEZXBYTitmVTE5NWVMWHdEVm9UaEkxYUVPNVQzTU8zU0FKTE5uQlN4?=
 =?utf-8?B?eFZieU1uWlljNlVpekdhNUF4VTh0eWNiNXh2a2orUitpcWYvM1V5ZnVCQW1r?=
 =?utf-8?B?RGRKSnRzWHdlTkwvQzViYWVKTVg3czVjcStUM3lpZzNxZk9UODU2Q3hKRUJp?=
 =?utf-8?B?Z2JMWjFXbnZYWkpyRGFGNmxMU3hZaEl5NjF1ZGMrUHVXUEhvYWJNbnFoaURh?=
 =?utf-8?B?WjQrM0xqUVNhN0dvdkdCWkU5NFFxMXRqaTJMZzd0SXJsWit3Z21iejdLR3N5?=
 =?utf-8?B?M3ZQeHg2M2VjdytRNnExOU5FVmREdWF6UHA0dC9mNllrdUJWVVJZcUVNbXF2?=
 =?utf-8?B?aEduWDR2NGlzaHpUcnZJdXVyd0U0bkh0REVJbDNHaFc4ditYc0ZVdDlVV05K?=
 =?utf-8?B?Mi9QUjJXaEJxY01sSnRkTG1sOThBMWJncGJ6eGZvTkJuNk1vM3YyNTBWZXFx?=
 =?utf-8?B?T0daMENLU2oyRk5lT1kycEF1QjN1aFRoMDdOK2k5eTBHMlBoc1dLaVJSYS9C?=
 =?utf-8?B?VzVMbE01cjNFL1J0UGErOXlvd3JTZFI0MGJPWDIybkJrM3JVTVZQa2NSeHBS?=
 =?utf-8?B?RjFzZmZrWEloNk1KeW91OFVOZHZYd2FhY3djRWRyZUF0ZFdGbGtEUk41SE5W?=
 =?utf-8?B?ZWF0WGJRbnZLWFFNZUQyV25ld1JXZnZrS1FHMjZTR2dIQkRUdFJLa2laZXhh?=
 =?utf-8?B?SVRhb0xLcFRndzFyZ2wwNDNwWEV5ZDVxZ29HMlM0dVRCcHM4elBqa29McFl0?=
 =?utf-8?B?ODUwdllBZ2V5NmhtY0JCTVMyazBqWmVQYW5Cbk42d1JyZUkvbk1Ja1htTUps?=
 =?utf-8?B?RjdoS202M1dTOER3MkNIQVcydmI2eThaVkUyWjVvL2N0YzhtenAzNXFNS3FD?=
 =?utf-8?B?UTFvOXBUZ0xUekJDblg0OEYwRjVVbmVUa0J5SHFFeERkSGx3TDF4K0toKzRQ?=
 =?utf-8?B?aERVUDR4VUNvS2tYR0I4MEozYTU0emJyblhzeTVjaWs0cFdJeVY3U0RnWlht?=
 =?utf-8?B?aG42RUd4aXZPZERtYlU0WitZa0o3cDVOODVWeVRIRUl2Z1I0NXZSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13F62E85DFA09E4D8DD81537795E8273@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jxv0ig9qEeY8fAneXsZ9PgT39ZraAGsh62Y9j4xEuXLcu23WlObC1PsQWDA9WU8yNR555log61VLWKYWbPzjwa8CMlqkH9C6Uk8/QVF+xIdPCN3JxuJ6NXMARpiVt0r4os2y+DLyOQxio06vnvuRL6VPa9y3O73W0SHDZoXgBK5JNYlfiAHBrRpE4ZkwznxxXUHlNCHGTpyWHJVGr9PwJOx424wVFBQGfwjw0ZVt1CzwL/CaOOB7DokBzPhOWJXpDtOy5cdOgzxnXDvo7/5zdBCy+ieqxLhDRH1irnwa4RAG4redhMHhKW3N2vothkuELEkeyjqP2kGG+zHzK7/9gA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad28237-2bf9-4e51-955c-08def462174e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:58:46.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfcY6ZuQuYd99a6FJDsRsyWnTlBaavo4H52sLkN4pv2X/VfwFi/dCCu1iwmPbtRdC6ycmT6vQCZKEjDAvnVt2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDE0OjQwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvYWQgdGhlIE1NVSAod2hpY2ggaXMgYSBub3AgaWYgdGhlIE1NVSBkb2Vzbid0
IG5lZWQgdG8gYmUgcmVsb2FkZWQpIG9uDQo+IGV2ZXJ5IGF0dGVtcHQgdG8gcHJlLWZhdWx0IGEg
Z3Vlc3QgcGFnZSwgaS5lLiB3aGVuIHRoZSBwYWdlIGZhdWx0IHBhdGgNCj4gc2lnbmFscyB0aGF0
IHRoZSBjYWxsZXIgc2hvdWxkIHJldHJ5LiAgSWYgdGhlIHN5bmNocm9uaXplX3NyY3VfZXhwZWRp
dGVkKCkNCj4gaW4ga3ZtX2ludmFsaWRhdGVfbWVtc2xvdCgpIGNvbXBsZXRlcyBiZWZvcmUga3Zt
X3ZjcHVfcHJlX2ZhdWx0X21lbW9yeSgpDQo+IGdyYWJzIFNSQ1UsIGJ1dCBrdm1fbW11X3JlbG9h
ZCgpIGluIHRoZSBwcmUtZmF1bHQgcGF0aCBjb21wbGV0ZXMgYmVmb3JlDQo+IGt2bV9pbnZhbGlk
YXRlX21lbXNsb3QoKSB0cmlnZ2VycyB4ODYncyAiZmFzdCB6YXAgYWxsIiwgdGhlbiB0aGUgcHJl
LWZhdWx0DQo+IHRhc2sgd2lsbCByZWFjaCBrdm1fdGRwX3BhZ2VfcHJlZmF1bHQoKSB3aXRoIGFu
IGludmFsaWQgcm9vdC4NCj4gDQo+IEF0dGVtcHRpbmcgdG8gZmF1bHQtaW4gbWVtb3J5IHdpdGgg
YW4gaW52YWxpZCByb290IHVsdGltYXRlbHkgcHV0cw0KPiBrdm1fdGRwX3BhZ2VfcHJlZmF1bHQo
KSBpbnRvIGFuIGluZmluaXRlIChicmVha2FibGUpIHJldHJ5IGxvb3AsIHdoaWNoDQo+IG1hbmlm
ZXN0cyBtb3N0IG9idmlvdXNseSBhcyBhIGhhbmcgaW4gdGhlIHByZV9mYXVsdF9tZW1vcnlfdGVz
dCBzZWxmdGVzdCwNCj4gYnV0IGFsc28gZXZlbnR1YWxseSBjYXVzZXMgUkNVIChTUkNVPykgdG8g
Y29tcGxhaW4uDQo+IA0KPiAgIElORk86IHJjdV90YXNrcyBkZXRlY3RlZCBzdGFsbHMgb24gdGFz
a3M6DQo+ICAgMDAwMDAwMDAwY2RhNDdiZDogLi4gbnZjc3c6IDYvNiBob2xkb3V0OiAxIGlkbGVf
Y3B1OiAtMS8yNQ0KPiAgIHRhc2s6cHJlX2ZhdWx0X21lbW9yIHN0YXRlOlIgIHJ1bm5pbmcgdGFz
ayAgICAgc3RhY2s6MTI2OTYNCj4gICBwaWQ6OTU1ODggdGdpZDo5NTU4OCBwcGlkOjk1NTg0ICB0
YXNrX2ZsYWdzOjB4NDAwMDAwIGZsYWdzOjB4MDAwODA4MDENCj4gICBDYWxsIFRyYWNlOg0KPiAg
ICA8VEFTSz4NCj4gICAgbG9ja19yZWxlYXNlKzB4NGUvMHgzMjANCj4gICAgX19nZXRfdXNlcl9w
YWdlcysweDU0Ni8weGNkMA0KPiAgICB1cF9yZWFkKzB4MWIvMHgzMA0KPiAgICBnZXRfdXNlcl9w
YWdlc191bmxvY2tlZCsweGVlLzB4MzUwDQo+ICAgIGh2YV90b19wZm4rMHhkMy8weDNkMCBba3Zt
XQ0KPiAgICBsb2NrX3JlbGVhc2UrMHg0ZS8weDMyMA0KPiAgICB4YV9sb2FkKzB4NWMvMHgxNzAN
Cj4gICAgeGFfbG9hZCsweDE0Yy8weDE3MA0KPiAgICBfX2t2bV9mYXVsdGluX3BmbisweGQ5LzB4
MTMwIFtrdm1dDQo+ICAgIGxvY2tfYWNxdWlyZSsweDY1LzB4MmIwDQo+ICAgIGxvY2tfcmVsZWFz
ZSsweDRlLzB4MzIwDQo+ICAgIGt2bV9tbXVfZmF1bHRpbl9wZm4rMHgxZTEvMHg2OTAgW2t2bV0N
Cj4gICAgZ3VwX2Zhc3RfZmFsbGJhY2srMHg2M2UvMHhkZjANCj4gICAga3ZtX3RkcF9wYWdlX2Zh
dWx0KzB4ZWIvMHgxNDAgW2t2bV0NCj4gICAga3ZtX21tdV9kb19wYWdlX2ZhdWx0KzB4MTJlLzB4
MjAwIFtrdm1dDQo+ICAgIGt2bV9hcmNoX3ZjcHVfcHJlX2ZhdWx0X21lbW9yeSsweDE2ZS8weDIw
MCBba3ZtXQ0KPiAgICBrdm1fdmNwdV9wcmVfZmF1bHRfbWVtb3J5KzB4YzEvMHgxZjAgW2t2bV0N
Cj4gICAga3ZtX3ZjcHVfcHJlX2ZhdWx0X21lbW9yeSsweDExNi8weDFmMCBba3ZtXQ0KPiAgICBr
dm1fdmNwdV9pb2N0bCsweDNhNC8weDZiMCBba3ZtXQ0KPiAgICBjbG9ja2V2ZW50c19wcm9ncmFt
X2V2ZW50KzB4NWQvMHgxNzANCj4gICAgX19zZV9zeXNfaW9jdGwrMHg2ZC8weGIwDQo+ICAgIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDRiLzB4NTMNCj4gICAgZG9fc3lzY2FsbF82
NCsweDEwYS8weDQ4MA0KPiAgICBfX2lycV9leGl0X3JjdSsweDhlLzB4MTQwDQo+ICAgIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDRiLzB4NTMNCj4gICAgPC9UQVNLPg0KPiANCj4g
Rml4ZXM6IDZlMDFiNzYwMWRmZSAoIktWTTogeDg2OiBJbXBsZW1lbnQga3ZtX2FyY2hfdmNwdV9w
cmVfZmF1bHRfbWVtb3J5KCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQo=
