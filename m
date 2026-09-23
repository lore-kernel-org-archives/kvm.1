Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C295372DC;
	Wed, 23 Sep 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180824; cv=fail; b=JLdHv2ZdvGDbqVIbRQuHBSyG9x7jdKbScWGHCADWxC7TTa/9ZA55hbLwrQXeGcAfLdnsjTL6A+WxlylPAcur43JhmwIXoTAlPUN9ameOpQqYDx42Vru2U5TYCUFrPEWiFQ1kMpiP7MnkFc8VZUMwWPwydVF/LVqMFsW0OPA+zNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180824; c=relaxed/simple;
	bh=LYGoVafFkGVJY/ll4so7lSZavJHCghV/6J7Dzs0/GHk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OT3n/HPu7wnTmyenJg3lF9qDQz7kshgxSIqZpQQGom0i6hd0vCNUHtvJ/9P+OcKLSgZMVKxdNracwTBEFaPP7zgQp34PYmdtfEke5XrrFqfSDJgaj8uLLYN+qxh9T6UdnTeE+ub43Z2r1mO7dbkkhsh0JY2JgGwxKyKek/jhHN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Civ28C1m; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Civ28C1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790180823; x=1821716823;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LYGoVafFkGVJY/ll4so7lSZavJHCghV/6J7Dzs0/GHk=;
  b=Civ28C1m8TTeKHTVbZ3pM6dAJmgJgfHPVQU/MIYrZPNbcmzwbA4SMtPs
   TnWaWPVGIU+h7mTBGjSuwT4AEElf5BQj8ET+oid+LpPLxABIMgR1+tC/S
   S43/GHufD56LrsV5jCMrsSXlXhyx/WpYRNGsGpfDQowZ43z4UIrGhcGOZ
   LFxlbbWFgK8+Q3J3q5OW+0DgEguJZMHvUiI9LitmVIXAsKDHKDNFkAJ+p
   e0hqvZURZfcA88EOebcc8J75a+SpVdc9pfF8IOM7g37DSe0Bdtoq0ymxY
   L/C28tCfvuIc22UcSGWK1nZ8aywwnoNMrLSGqrX+VE5BUQsKELTfueCMy
   w==;
X-CSE-ConnectionGUID: hgxf1celTv+reKowPCrBAQ==
X-CSE-MsgGUID: 2u0EN60JTx2HEGzKrSVbJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="102255907"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="102255907"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:27:02 -0700
X-CSE-ConnectionGUID: Px/rXJ5YQRK69EnHAq5Qmg==
X-CSE-MsgGUID: ZqohnmrwRJ+N98ml1OQwvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4943780"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:27:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:27:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 09:27:01 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS5e3JSVnaOCJJQWWMNEBBIdtZjmNlThcXvnzbxHQwLATlgHnT+oIT8rcfNHHep3USH8Tp8LWeE44pfzVCY7aAHUyuzACzc9ObLITzC9bYLhMXXToofZVS4S/H4A/oXpFQONtD35j/rOHxKl+TTh+T7w4C/NYhzfcdBQyTiHWnO5pI3SL9gsMY1Iu259C0wvIgwRa4gEjNGgb941wGMAp+b/GDDB9qaurelN/WLOd8N5ToaljXwef34vhT4miQU5APZhVO0rzFNAzzcFuj82HRH/1Dpr1tw5MR+yZGvNE72S5bziRn/i7nkOimisFrKVa5szfgj3ufhKHN/DK0AwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYGoVafFkGVJY/ll4so7lSZavJHCghV/6J7Dzs0/GHk=;
 b=gtqvHKPldbUPHKl8hp7JmkfRMB3Fey5yaOlfcJwXobC9m/toeSAqRA62AHNthDZutlHwUmLVp/dSi2iMEAq2FUSkrHkPULeeDHH1QufJUZn8vKFNdaKbQxQujwxh1XjpkNyUs8jBEsJbQ8ivH3tTqgxr/SjJ67ncfaH/tOkUgF52V9Cz6QKbQm2RbfvhyDIG4h4J1VqpVIYZZijp9NlTIz7mnBq0IUscFkup4I1zNbuSm6VjHZIYq0lR7oRRvfNEUdr+penr89REL5qP6Tm9uBMqQmLehkKaObVfxJmmFRYIzHtTfeDTXeY38Na+EQVGZoF7yJlPR1wcr0d9w8uoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 16:26:57 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:26:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Thread-Index: AQHdStRVsWarOe4Dj0yp8Uw84+65B7bcEAUAgABLAgA=
Date: Wed, 23 Sep 2026 16:26:57 +0000
Message-ID: <4527da9ddff360149bbc6ed8aadfc44dfc40c53b.camel@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
	 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
	 <86d0237e-80a5-4592-8e34-67960de70d8f@suse.com>
In-Reply-To: <86d0237e-80a5-4592-8e34-67960de70d8f@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB8519:EE_
x-ms-office365-filtering-correlation-id: 07a84f84-52a2-4a59-e4bf-08df198f7cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|921020|56012099006|11063799006|5023799004|10067099003|38070700021|4143699003;
x-microsoft-antispam-message-info: 0T5UPXwyNjtCmh5S3RZA8E4RM2Px5nKzkFDaWMSxsG36oqEoyD6wFBYiQU1/tUC3FcfyMW6Y55mUPvbe/3hOSaMVzLVbkvUUWlrJ6mYEpsSHrrB5EQw+O0LjpZfKuSKttbK9OtLSlSn0qjQJp+WrFr4Ui7ZP8vNT/zrHUckCVGFs3PDT5NAluwdpZ2CdgM7tfJAQgTKih3moLFUfb+LeOjcGVmDIeXXsaLSfLOc/MYCp0Inl18AbLohCcsBmEIWbYPsoiKpWZl9SHnplIz8SsnXh7IRzD5MPMcKU0QwNfl5BdzlXqzfx75vr/O6ON3/mAmyT0zK2PJ2xoKJfYMsmVbkxQ3oAB4Yhe7MhvYi45TRlIFpGiRlaXy1wQ6QA9GJBEof9JjxaUhyGH0O5zUDOX8LTHgR9sIhVCqlnq4oUSNUnFGzZeZAoS6ZP3B2ni4JNLpbtxJz7zvL3Mob04ZP6tcLcwYbm8CX3dfXJLpdMWpLaKEsx5s1o0mDEw9id8Q1kAgCm6HTvrkgBCyHj/rAl9QalwI8j9vCNIW9fT0+D0tiiemIG/oD+7EKzgFK+8a1EgVvmJNB0CSN9iivA4lJFvz7C/zOvJjEJJI8iOKqUI9BmPKKe4nZv9dcq0O+DqVGtVMFLFHCw2/UowM9Kba7QtuceuRaA3o1CeW7MGozVgQGqrhtb39j1EFWdwvkcThzgLcL/4Zc4DrX5BkdPdmrPeMVbWbXf3ZoOK93pY6yEWg9OWmLEgmB5eGxIZqzii++R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(5023799004)(10067099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejA3d0g0d1o2S2ZmSEVTd1llaU5jcUJRRDhoMmZBS3ltWHgyaEJzWjJxelhM?=
 =?utf-8?B?Y3JkS2Q4VHhOUHZBTXF3dnhVNmJEMnFKSTZkUmMrd0R0Zjh5WGNlZ1hmZStt?=
 =?utf-8?B?bDA2N1BnS2VGTDUwYktNMmlRSHZoVnBqQ3p2QTVQcm1JaWdLdXlyb0Z6TElX?=
 =?utf-8?B?SDBLVFVGOGtjWFdnQzIveHpFZE50WXJLU0xuZHBvbkhFeHdHenpyNlZKR2c5?=
 =?utf-8?B?Rk9pVHJ3Q2VtL3lwRnM4dDNNNm5IcEhLbW8zRUVEelU2M3ltZ3l0dVN6VFBz?=
 =?utf-8?B?TkxYL3VSTW9CUEpzU2JsZEk5NDFxM0xVU3Y2UzgyUm5MeU5iRTgvbXRFc0pR?=
 =?utf-8?B?NEpmazJERVQxbEdZeG5LUFZYeVBtbkZkZFBvd2l3aUtROFZXa0llWGNUS3B5?=
 =?utf-8?B?ZlNMalhXd0tOaDZKUTBuVFowOUxjWDVTeW55UE9ZTGJUaWVJc0tlbWY4ZURS?=
 =?utf-8?B?ZzVNSy80MXNwY0xYRk12NzlBRUNTQmFrVGY1dDZmaWVIc0Z1K3QwZUdJbVdP?=
 =?utf-8?B?ZVozaElncXdiNWhabGpwUWhmWnRWRFg1bnFtd0hpSk1jQmVxcTJTSTJCVGJZ?=
 =?utf-8?B?VjNKSWZVUkw5UWxjY0ljT3NlNHJFOE5OMVVUREtIV21Xa1FxTFFrQWJmSCtq?=
 =?utf-8?B?eXpTSExiUGx0eXBtSUxXMXhrY0pjT2djOW9VeUlxK20weFlvTE1NUFpHbzFK?=
 =?utf-8?B?NTFaOFpRTytDc1hPYW41YWEvSWh1bms5MnVyNksyUXZMZEYyNDgySjFGTzRw?=
 =?utf-8?B?MzRDYVBmWUVGMWsxaTcrUFZRRjM2UXdQUWNVbTdaMGdvei81YnlhVEcxQXls?=
 =?utf-8?B?WTZscHZPeEpOK0hZTU5ia2tEZnFVbFVhakdscm8rT1lERW1DWVltRktGSEh6?=
 =?utf-8?B?TlJ0aG55M3c3b1ZqWXJoRlRwOHFpVlRnVndmdC9YcjlDdUg5bnNOY3RUOFVz?=
 =?utf-8?B?UU90VGE5aXByNjVNUkJyTjlPSEh1elpEbSsyd04rRFdWby9ZZTdWajlyMnRS?=
 =?utf-8?B?V3d2NGZucTZGSWh4bDVKem8weDFkQ01zbWJOQ3EvaGFNdVBMTjZ4YnRRVkpO?=
 =?utf-8?B?Y0xweUM2Zk1aWE9YcWlHYStQWUlLbi9rWTlIQmFRMTkrS2g5SURkVnF1SGNM?=
 =?utf-8?B?cDJhdGRqR0YxYW4zb0NVYkcrdmJRU1NCeGk0RWovY0FEdzBCRVl3REM5c2ln?=
 =?utf-8?B?d1IxQ2NMN3hFVEc1Z1hyK0QrZEc4R2lOalhrT281ejBMY1FGWU43c1FYZUoz?=
 =?utf-8?B?NElobkVWQ2phbGRpNnkxcmkzZ2luRzhIelE4REt0QkFscFp4aU9GcmNCeEdV?=
 =?utf-8?B?NnY5YjR6S2hNRXdkMk01MWtrTHlzWnhubDNOblNmNmhwMXJGMWM1a2xpOGcx?=
 =?utf-8?B?Y0FMM0Q1OGQvanBmTFNVRDU5U0lZUTBjdEJzYVRhNE4yTXNIaXpLODNPR1Vt?=
 =?utf-8?B?eHQ3T1BzVGhzenNPdlR4QWo2cGp3Q3hTMFMyYjFWOEdmdEdjbmFjMHpTVDR1?=
 =?utf-8?B?amRyV3RISTgwRXRkblN1MnBQLzFEOGdYS1p0MDVUWW9ZaTRSVHhOK0VON3Jm?=
 =?utf-8?B?aU16bUFTYkI1bXpvNlNveWNkRkl6NFhQZ3BOaXVIa01hZFFsQWVQTlEvUDRI?=
 =?utf-8?B?K2M0Qkx3KytkeHViY05WV3BFS1VOUmV4R2dPcDRsQW5adEZ1VTFNbUhuM3l6?=
 =?utf-8?B?dm00eFZJYlMzR053ODFkSmt6dkRCK203MjJQWXJuSWxLSHpxSEx4WlMzRTJR?=
 =?utf-8?B?a1hXRHNFTWwxSUtGSFlyM013WkxlOFhOVkFDcDJHQURIZlFTbnBpUjJZNzJV?=
 =?utf-8?B?TjRjUkxtWjNZQkFUWlVNSi82M1NZaWx0RmZlNUsxSFlpU3l2MjdvNGJBYjJw?=
 =?utf-8?B?ZWJwVDlEajhCZml0aFZ1OW8xU0FzODBUT3pQRTg1RTRIdXdJR3dFVXZJVStx?=
 =?utf-8?B?YjVSQlVML01ZRDlOMlhxcWtOQ3hlVi8xK2c4SFNGbEh0YVJyQTFQUVpqSnhG?=
 =?utf-8?B?VnZaUUtYbVowUE9qT3ZTOUtsYWxJVDhLV24wdnRBOG5wUTlSRWRzbmdOMnRK?=
 =?utf-8?B?aVZmMkJGaWd2WjlQODJGTjMrQW9XYUhjVDhJYk9mUzZZLy8wT1l3WGJOU0dQ?=
 =?utf-8?B?eUhDT3M1ZGFCYzBMclRUOUFpa2RmZWMvNW9nN2U0N0ZKbExtSXJOVm5OZnRL?=
 =?utf-8?B?a3ZJZFZUNEN0aFQ1SFVEZlFLWFhMYU95RFl0bkdOeEhSd2xScHU2cGZwQVBZ?=
 =?utf-8?B?U1l3VmdlanNnVFROZmpwSG9SK09mSUFpM0t2U2JTUENLZW96UXhUQUF4cFN5?=
 =?utf-8?B?UE9Vclk4MWpIRE15NTRqdys4NHorQlZHNHhQeXVPeHU2RGM2OVMyeTNoMlNZ?=
 =?utf-8?Q?TkRBwffIIXVl0HgA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D15F91602DAD484081F000D5927D3E36@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N4rFRz1fYMlsmbSHUuB7eELp6Y+hcAZy/ykWc0IfNlNL1WsvKexDmWkLuENn8UdpWw+eTjT4drasg3itINvL9K2M4UfnYZAiT3f092TE9EvnQ7Q7shOs1jCuxEquTgYXrPPsEwhTxlnuFI7g4CPhZHS3LFEVlQIu1wlSegjAfw1sWMkC4TrT+5KptHfZynwlgv+YVDJK5cYK49+WTm3DUs8KIs/RYDm/LaWx7GKfnNXWqxeo0ZEqUdzuAQJTM4b3njlwrvyPC+EWQrXALSch+PwXHkljNmSPuOtFU1FHqChy+PAsXhyGvl301OMQmiCxjI492XhsPk2eBQutNvv3FA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a84f84-52a2-4a59-e4bf-08df198f7cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 16:26:57.2907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQSjYB52gktmbMlY8UPkBao1mR6C4kNaQ3DolHTSGyFBsxDOtBX/u4RQSKRKA8rKKbL7127inPkm7BD3LgFvQuVkENH2bG65+xInw32xcQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDE0OjU4ICswMzAwLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6
DQo+IFRoZSBjb2RlIGNoYW5nZSBpdHNlbGYgaXMgdHJpdmlhbCwgaG93ZXZlciBub3RoaW5nIGlu
IHRoZSBjb2RlIGJlaW5nIA0KPiByZW1vdmVkIGlzIHRpZWQgdG8gQ0xGTFVTSF9CRUZPUkVfQUxM
T0MgZGlyZWN0bHkuIEFuZCBmcm9tIHRoZSBjaGFuZ2Vsb2cgDQo+IGl0J3Mgbm90IGVudGlyZWx5
IGNsZWFyIHdoaWNoIHRob3NlIG9wZXJhdGlvbnMgYXJlIChhcyBwZXIgb3RoZXIgDQo+IHJldmll
d2VycyBmZWVkYmFjaykuIExvb2tpbmcgYXQgdGhlIFREWCBtb2R1bGUgc3BlYyB0aGF0IGZsYWcg
aXMgDQo+IG1lbnRpb25lZCBpbiByZWxhdGlvbiB0byB0aGUgZm9sbG93aW5nIDMgb3BlcmF0aW9u
czoNCj4gDQo+IFRESC5NRU0uU0VQVC5BREQNCj4gVERILk1FTS5QQUdFLkFERA0KPiBUREguTUVN
LlBBR0UuQVVHDQo+IA0KPiBXaGVyZWFzIHRoZSBwYXRjaCBhbHNvIHJlbW92ZXMgZmx1c2hpbmcg
ZnJvbSBNTkdfQ1JFQVRFL1ZQX0FERENYL01OR19BRERDWA0KDQpUaGUgZG9jcyBhcmUgYSBiaXQg
dG9vIGFtYmlndW91cyBmb3IgbXkgcHJlZmVyZW5jZSwgYnV0IGluIHRoZSAiQUJJIHNwZWMiIGl0
IGhhcw0KdGhpcyBibHVyYjoNCiAgIFdoZW4gYWxsb2NhdGluZyBhIG1lbW9yeSBwYWdlIHRvIGJl
IHVzZWQgYXMgVEQgcHJpdmF0ZSBtZW1vcnkgb3IgVEQgY29udHJvbA0KICAgc3RydWN0dXJlIHBh
Z2UsIHRoZSBob3N0IFZNTSBpcyByZXF1aXJlZCB0byBlbnN1cmUgdGhhdCBub25lIG9mIHRoZSBj
YWNoZQ0KICAgbGluZXMgYXNzb2NpYXRlZCB3aXRoIHRoZSBwYWdlIGlzIGluIGEgTU9ESUZJRUQg
c3RhdGUuDQoNClNvIHRob3NlIG90aGVycyBzaG91bGQgYmUgY292ZXJlZCBieSAiVEQgY29udHJv
bCBzdHJ1Y3R1cmVzIi4gSXQgd291bGQgaGF2ZSBiZWVuDQpuaWNlIGlmIHRoZXNlIGJpdHMgd2Vy
ZSBpbmNsdWRlZCBpbiB0aGUgYmFzZSBzcGVjIGZsb3dzIHRvby4gQnV0IEkgdGhpbmsgaXQncyBh
DQpzeW1wdG9tIG9mIHRoYXQgdGhpcyBhcmNoIHdhcyBuZXZlciByZWFsbHkgbmVlZGVkLg0KDQpT
aW1pbGFybHksIGZvciB0aGUgc3lzdGVtIHNjb3BlZCBtZW1vcnkgdGhhdCBjYW4gaGF2ZSByZWNs
YWltLCBJIHdvdWxkIGhhdmUNCmV4cGVjdGVkIHRoYXQgdGhlIEhXIGxpbWl0YXRpb24gcmVhc29u
aW5nIHdvdWxkIGJlIHRoZSBzYW1lIGFzIHRoZSBURCBzY29wZWQNCm1lbW9yeS4gQnV0IHRoZSBk
b2NzIGFyZSBldmVuIGxlc3MgY2xlYXIgb24gdGhhdCBwb2ludC4gU28gdGhlIGRvY3Mgd2VyZSBu
ZXZlcg0Kc3VwZXIgY2xlYXIgb24gaG93IHRoaXMgc2hvdWxkIHdvcmsgaW4gZ2VuZXJhbC4NCg0K
SW5zdGVhZCB3ZSBoYXZlIHRoZSBvcmlnaW5hbCBpbnRlbnRpb24gb2YgdGhlIExpbnV4IGNvZGUs
IGFuZCBzb21lIHJlY2VudA0KcHJvbWlzZXMgZnJvbSBURFggYXJjaCBmb2xrczoNCiAtIENMRkxV
U0hfQkVGT1JFX0FMTE9DIHdpbGwgbm90IGJlIHNldCBpbiB0aGUgZnV0dXJlDQogLSBWTU0gaXMg
bm90IHJlcXVpcmVkIHRvIGNhbGwgVERILlBIWU1FTS5QQUdFLldCSU5EIG9uIHBhZ2UgcmVjbGFp
bSBvbiBhbnnCoA0KICAgcGxhdGZvcm1zIHN1cHBvcnRpbmcgVERYLg0KDQpEb2VzIGl0IHNlZW0g
c3VmZmljaWVudD8NCg0KPiANCj4gDQo+IFNvIGNvbmNyZXRlIHJlZmVyZW5jZXMgaW4gdGhlIGNo
YW5nZWxvZyB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkIGkuZSANCj4gd2hldGhlciBmbHVzaGlu
ZyBmb3IgdGhvc2UgMyBhZGRpdGlvbmFsIGZ1bmN0aW9ucyB3YXMgYmVjYXVzZSBwZW9wbGUgDQo+
IHdlcmUgb3ZlcnplYWxvdXMsIG9yIHRoZXkgc2ltcGx5IGhhdmUgYmVlbiBvbWl0dGVkIGZyb20g
dGhlIHB1YmxpYyANCj4gZG9jdW1lbnRhdGlvbi4NCg0KSSdsbCB0cnkgdG8gYWRkIHNvbWV0aGlu
ZyB0byB0aGUgZWZmZWN0IG9mIHRoZSBhYm92ZSwgaWYgaXQgZXhwbGFpbnMgaXQgZW5vdWdoLg0K
