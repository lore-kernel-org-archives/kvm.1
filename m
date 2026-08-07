Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2E12D1F1;
	Fri,  7 Aug 2026 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062446; cv=fail; b=X3/mulbAUPc68ys3nhhxpO18moeZDxqLUIodHpuIo/5X6oysNkILUo95yZQ7oFPKLd4fokWe2hREyTOsyVQRfFifgKZADP4nja8rTCueUZYPzJ5yHbG0MomAgOZV8MKric8AdzaLEQiriEu0CfJFLFDQw6vaHiBGMZaiGmWB2H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062446; c=relaxed/simple;
	bh=15h7S716axMmBa9O2IRm2Uh9x34QB7wiRP4CcaOt9Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YcIvnlALx1f4GI6lvQIz8EseLPkAQE9Z3oRllEE2eu5m5urrm1qSmGYVrCHZS1Hb8dN3rvKAT/QDU5VWhD3ec+3G/RcY814Ibvq/rPR2zBwmngtBM9SKHe/2F9qsKwK7LklQD+ZtmUXj75JSf/YrCkWzluklKXDvqEIDnxtgECQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr6ZvxF6; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr6ZvxF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786062444; x=1817598444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=15h7S716axMmBa9O2IRm2Uh9x34QB7wiRP4CcaOt9Jc=;
  b=mr6ZvxF6Yql9pa9hN3453z2QdxEpBohcF3wLX7EZ/DndVkT1APasnbAz
   pp3Fj8Kw5F55IO8yIh/tvXh4Z8oEtgfeeb1FcWLQrTs4fjqu1em36ymDA
   VHCxVMzoBZvsLcPn1bgJHtIP9MQy8/VaR+9fqNivpjstzzE+tR/ABMBWN
   cdrM4s2y+OCEWKMhcEX1Ry8bB4Xmj1ohZ7CyoOj/AzgiI9y8nmzWFXcpy
   TZei8MtBP3WOP7VdcuGBHe6Dnx5ojSyNX8R3YWhbw+q5IYFI1SVeuTHte
   OnP3rqHLkgK9p3mKn+QRJrWlmxnER9vn9SNVQjuuBQxrCk6c7dCj1zqye
   A==;
X-CSE-ConnectionGUID: jsLHy03ISGaxM5IX0ILjZw==
X-CSE-MsgGUID: 4hiSo2HOQfmAW74NL2Ltzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="104071721"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="104071721"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:27:22 -0700
X-CSE-ConnectionGUID: NyHPTqFHS8OAXYY1bg42hQ==
X-CSE-MsgGUID: l9GVZNmJQ/icpHn1YGbFRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="292141477"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:27:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 17:27:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 17:27:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 17:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epXnVfykJGnwex5AnqS0NLOOKSSEq6MoMm7dOFLpcEMp1BQQjlF6eskYfj9a5CgAJ+Qh7O2HPS3TPOOcXaqCkWuaknYFMdYqRbiX2N/7Qq6h/pHKhNng60LzDc49kLSZmZSRCRFYAFu86XQL6gvXYee/DYXbdDXzkO8jVjWU33+gRucSA+woKh+xRUWu9AaNAm8zGj8012C3s0JQonmkwWUIBC3j5A0ZohPHBj3uJMp+RLLA3W5iaEwmLB+9P+yF+diTCqzEYPafNKWv2uiLJn5xnePxaeGIMnN8ZtO3dmNN7NOFowL4AwQJLRZdQxgNwz/satuso+6AXGEQpKOReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15h7S716axMmBa9O2IRm2Uh9x34QB7wiRP4CcaOt9Jc=;
 b=HUQQ0HsOACr9OikouJsJgRKv5TS+kbdCfsAOozawwcIbWx4qJhTw9VjqCagLlHGqMLbX60WcWV6yfBy0RY5q4wJzmPBejLHXAr7je1yclD8GfZ8ziXPXc4pU8L6ns7iuOYI3BXSnLEjUoc/wrHr7VZp28ogrwWLYKUZE6D+1/3WOiQIXK3RZZwg56xK8oMWOUWozvD2AQuUl5nLsoByUP/EMx7xe/vTG38ce+U3gtPZgqLDltOzCf4MHXpSe5OcpYj97f2QAeDgyMTdNwWgpv6s0uZd0HRbfcXWs8Ltdj5fGyMuajMfNxkifGdzBQrbOUZTUWnj6p09/DzDdlYv6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB5877.namprd11.prod.outlook.com (2603:10b6:510:141::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 00:27:18 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 00:27:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "nik.borisov@suse.com" <nik.borisov@suse.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
Thread-Topic: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
Thread-Index: AQHdJIkOa1ZQm2mEZ0CRXwnmzUqn/baRBzgAgAAEqACAALIOgA==
Date: Fri, 7 Aug 2026 00:27:18 +0000
Message-ID: <5ab71720460d268e3336e521209c796ca04b0012.camel@intel.com>
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
	 <20260805031257.1844914-2-xiaoyao.li@intel.com>
	 <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
	 <anSRCBhWi2BK9kYB@google.com>
In-Reply-To: <anSRCBhWi2BK9kYB@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB5877:EE_
x-ms-office365-filtering-correlation-id: 9114cd1f-8999-4dd6-6c98-08def41aa3bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|5023799004|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007|4143699003|38070700021;
x-microsoft-antispam-message-info: v6UOl/leMNYdYmcdUTWHAb9BeQzp+Vh9XZsmDYwawZGAATuE2M+dedVK+8NZH5O++SK3sjDMHFLD7BhntRlGa7cnvwIij594ot1XMjngR5tp9LFGI3fcClaeAb4LeDnrk9MxW9Ot2s1NzL0ElQGviIBHOsuo0aaJE98eUr297HHW15sa/ZyAbgk6zH+LNEkC310sBVEPy1TrfeLjSWs32w8kUciB6+4Hs9YdSYRoP8gE56l+/KQol+S1YJK7wqNkEAisDrUcP1aZ/qBed1WAbRvP9McdakL4l79ESkvtZ+WQe2MTW+I7AQtVaAF4fx+ZGwKF/b9meA3RyZvVL1zYiwXljLwl0EsXIbeMrv3xoAj21ekts1qtCDmvurNeckBFZd+3cn7FaHB8xcCo2s6X4WL0jlVIOOyF1qmus413Qc9jK7UPgCWdGmL2AH/4qFpcwFdKfiuBo3tn52qsY3vtIOOdwZCiS9FveqVK72OEqPvGxettDLbt8bsrkuH5H1StgyrlsNLKQmigOiPmJ95PpwdXB8pmbEdPBVzJbD7V1jLWhA3hmr1US88HGzZBVuCCr7/I3ExD8ucvQlrfWVjqFm76o9NQCETC3jLwU5yXT1THVgXiyToUDJMAIPx6KBs1nPBmc08U3PgUbqbl/fNOZSDTRoX8Dz8mdRi/c55sn8xnVAliMhnvnONIQYzhwtzQvCw5njqFaHXidClKI+NHc93DdMe0kFtzzBykdParyK8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUlMRktMZUcvMTQrbC9vbEtZNlMyZVJYZzhnL21DZGorV25EOG94S0hPUld1?=
 =?utf-8?B?M082eUFXWWN3M0V1RFk0UzVRZThjSmdzckkvYU5rQTcvODk0bFZxL2s1RGdW?=
 =?utf-8?B?VlJ1UE4zQVkzMVB2N0hlVEhGUXNsaUhQYVRVR2p3cGpCMmpGWllrZ20rQkYw?=
 =?utf-8?B?b21nTGlEQ1BaVE1jVElPdndmZE5TS1lnUWoxUVhKcDdERytKRDQyM25uTnhy?=
 =?utf-8?B?a2hNbnBnSTYrd2RkaU1KTWs4QXZrbUFBY2phM2xORldKalRZWGpEVUE3UDBE?=
 =?utf-8?B?KzFrUVNrRU9yZkdJVWFmYWswQnA4Q3B4ZHJSdVlFblFKa1ZkTWZYQ01MVUV4?=
 =?utf-8?B?NG9BMGQrbmFSby9jS1ZYM3pnVERtbUJjNjR2bnlkemlqb05wRzNJS2ZOZlRF?=
 =?utf-8?B?OWtqUEZPMVk2cHNNTTdEM0FQdHZPQW8xQm95V3h0U3k5UUU5Z1lUR1hpazVJ?=
 =?utf-8?B?MEVvZGEzM3g0TWJWRlphbks3dE1vcEZjd082bThLd2hCSnY3MExNb0xWeHhU?=
 =?utf-8?B?UmxISDlYWHN2eGRYUTdQNXhxZnM4NW9QZ1FEMGthZFZBTlo0L256VTNTWEhQ?=
 =?utf-8?B?azA2ek9zU2hGZUthaUZvZUlwZGs5QlBsZEVpNDk4Z3hWQjlSTlVKa2xtYmRV?=
 =?utf-8?B?eDI2Wi9nTFlBT09PWEtrYkNpN3dPV1dyUitPWndaaWR1OS9JQXdiVzk0ZkFu?=
 =?utf-8?B?NlFvc0lsa0pmRGtmNnIxc2dvcUp0NjlYNDF1SUJXcVovODlsU0RqVnN3NzNo?=
 =?utf-8?B?MUd0TzNwMUJNNktmQTFHVGNTcTFMV05Qdk1FMVErVStUREhPK3NjMjhybmdT?=
 =?utf-8?B?M1pnUXYycmRSUEM1WDFyV0lJM3pnRUkzcHlZWU1IdW8zRlhudGY2cjVPUWNR?=
 =?utf-8?B?aDRmRXQ4VGRUTlVIeW5rMVI1d3p2Ri9LeklyYnNUam5hOEpJb04rQXBFYmVF?=
 =?utf-8?B?S1lKRnZjNjQ5bU9hM1pPVERhSmtISEVzajIzNzk5MW94R0FSS0xZTitRK1o5?=
 =?utf-8?B?RnZRY1VRMDJIVTJ3VStwSExGZFlvNVgwUnNqM0RKK0VXQW5lOUR0RXBzVlNL?=
 =?utf-8?B?VWIwL21Hb1JPQjAxNGVaajA0eGlzNnFpQzA0ZWJGVzltaVZrMjBqTkFNYWlT?=
 =?utf-8?B?MnFNcGZ2TjFXb2NTK1NTMVFPdFBNR1kxdWZGMS9meFhiZTBWc1EyK1cxenlk?=
 =?utf-8?B?STg1Y1VFUUhMYks5QnNFdHJiWDBBMmZ5aDZjOS9Fa1hZNUZySjhVZGR0SlBv?=
 =?utf-8?B?ZTBndjhNOFQwWWFOSjVGL2Vob3YrUnQvWFZnK09RaGVWT1l1ZW4yRWVNaHp6?=
 =?utf-8?B?a1ByUVQ0Rk1ET0tIa1NZMUZ5WjUzSFpTTTlVZTZWY3hieG9ZRFlSdXFOQkd6?=
 =?utf-8?B?UDVEV0tta2E2R0NYbFh1NnlIVlZ4aGNBMk1zQnM4RSs5NUZTb0h1dURobzBQ?=
 =?utf-8?B?dHZsaDRYeWNRVUhlbGY3eUM2NnVYWjJoTm5jZ1NGOC8rZWZzL3Q5eTR1aDZi?=
 =?utf-8?B?d05wYk5WalJsQ0VPYTE4TkN3WDJacW82a0VsVzV3MEZScVNrMTlyaGN4eWJQ?=
 =?utf-8?B?ZjVVQ2tlNGpSaFVJUnpOSlFIVGZoKzE1Y2U5bHA1aUlHbFVGZGZlWHFmSjlQ?=
 =?utf-8?B?MEZPL1ltbGVRVjVSNkVKamZyTDZ5aXd3WS9mQWpoUUViVDNaZllqRG5xemt1?=
 =?utf-8?B?VnUzQ3NsSFRRZlUrUFhSRXMrK1VIYU5tR0VuVnhaNUExMXRCR2ltQzZ0aUpJ?=
 =?utf-8?B?NEJIbDZZQ3RKL2ZMbS9rbjhHamVtZ1Z5amxEandKK0E3aFFUNm9lUWtsUnB3?=
 =?utf-8?B?S0t5ZFJFWkxQQkVXVG9ZdDhENTVvdzEvaWFVYjdNSVYvendCbzVaZ2drMlFy?=
 =?utf-8?B?WldySXZnZlg1TnJjRjNRTUR1L1ZJaDdPUFhXTy83cFlReG9uK25vZUNJclF2?=
 =?utf-8?B?USs2MUFxSitnSFYyUG5xejAySzEyTmRtcTkrRS9yclZwV2dlalhsUG9MYUQ5?=
 =?utf-8?B?YkRVcFR1R1R1VVg3SXVQbFk1RFdqMkt5ZUZVQ0QwMUhZTzJ1VTV2UmNwYURn?=
 =?utf-8?B?TytPaC82M1pGOE5tWWlQUE1jNmpCa0pOS1d2OCsrVDM2T2czdkVmeE1lS255?=
 =?utf-8?B?TjJ2TnhwT0JnTTFwUVppNTVMNWhQVjhIVW1qTGpJOGt5djNMSUd1U0xSOWlX?=
 =?utf-8?B?N3FKNlRDaTdaSEVVOW1rUEpwbVZXQ0tIZXhEdWR0YmpzdVczUUJNaDUvMTdo?=
 =?utf-8?B?ZGxLSVBvOXVjNFVQVFZ3WjhqZEhsZ1NMUjg0UE9BVW90enZzU1gzb2p0SVRi?=
 =?utf-8?B?MUllL2F6ZzN1Z29pbU12TEYxV2lZWHNjQlp3ZCtDY1JVVXVyMy9rWU9BYWVt?=
 =?utf-8?Q?P+wQfGCs7DAsHgsg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA368399EB092943B25D1D69C1F84996@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HXqa5SOyuxrmRv47eBj0cLAVinIKff5+jv8QM1X5RSwkre2eXIUm+E5fc9fZfiOU7v+sEGeMIjxyQ6QEzZ2kK6C+kO1+juA6MbgSuopKN/wgqugYZmVM/mpJ7YNw0t9v+qqL4iZq1SS73/mbBk5NB+TKctHgBosOAvURJ11pPGffnp7ptBAr/iNqrXJH0Th4OzdFqo8XNvhsnkPR5h0M+EBB1AFzboD1F6fcf68hSjHwSqjALDXFJHp0QQagD9Ibau0JyY4nRYyQ6c32R+mQGzMC5P6XUIMMWRXEqjcmSPLvfS8V/x3igXzCLo1W2ZsZps3YDTq4pfMMQNHpjJ8CUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9114cd1f-8999-4dd6-6c98-08def41aa3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 00:27:18.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbETg/edmFUFKtn25XN39ntkYYXv4qzKrf4c0oCT2OmkD9h0ypmrBvWGjhO5HQOUIpwZ13FfXnueb5sphZxolCzqFHimfcgLj+4QlgeytyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5877
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDA2OjUwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEl0IHNob3VsZCBiZSBpbnN0cnVjdGlvbiB0aW1lb3V0IChhcyBpcyBpbiB0aGUg
U0RNKS4gUGxlYXNlIHJld29yZCB0aGUNCj4gPiBjaGFuZ2Vsb2cgdG8gcmVmZXIgdG8gdGhlIG5h
bWUgb2YgdGhlIGZlYXR1cmVzIGFzIHRoZXkgYXJlIGluIHRoZSBTRE0uIEkuZQ0KPiA+IGlmIHlv
dSBzZWFyY2ggZm9yIE5PVElGWV9WTUVYSVQgb3IgTk9USUZZX1dJTkRPVyBhYnNvbHV0ZWx5IG5v
dGhpbmcgY2FuIGJlDQo+ID4gZm91bmQgaW4gdGhlIFNETS7CoCBUaGUgY2hhbmdlbG9nIHNob3Vs
ZCBpZGVhbGx5IG1lbnRpb24gYm90aCAtIFNETSdzDQo+ID4gbm9tZW5jbGF0dXJlIGFuZCBsaW51
eCdzIG5vbWVuY2xhdHVyZS4NCj4gDQo+IE5vLCBsZXQncyBjaGFuZ2UgTGludXgncyBub21lbmNs
YXR1cmUgYmVmb3JlIG1lcmdpbmcgdGhpcywgIk5vdGlmeSIgd2FzIGFsd2F5cw0KPiB2YWd1ZSBh
bmQgY29uZnVzaW5nLsKgIEl0J3MgdW5mb3J0dW5hdGUgdGhhdCB3ZSBsZXQgdGhhdCBibGVlZCBp
bnRvIHVBUEkNCj4gaGVhZGVycywgYnV0IHdlIGNhbiBzaW1wbHkgI2RlZmluZSBhbGlhc2VzIChv
ciBqdXN0IGZvcmNlIHVzZXJzcGFjZSB0byB1cGRhdGUNCj4gYXMgd2VsbCwgaWYgdGhleSB1c2Ug
a2VybmVsIGhlYWRlcnMgZGlyZWN0bHkpLg0KDQpIbW0sIG9rLiBXZSB3ZXJlIHRyeWluZyB0byBn
byB3aXRoIGEgbWluaW1hbCBiYWNrcG9ydCBmcmllbmRseSBmaXguDQoNClhpYW95YW8sIGlmIHdl
IGFyZSBnb2luZyB0byBjYXJ2ZSBpdCB1cCwgSSBndWVzcyB3ZSBtaWdodCBhcyB3ZWxsIGRvIHRo
ZQ0KY29uc29saWRhdGlvbiBvZiB0aGUgZXhpdCBoYW5kbGVycyB0b28gb24gdGhpcyB2ZXJzaW9u
LiAoYSBjbGVhbnVwIHBhdGNoIHRoYXQNCmdvdCBsZWZ0IG9mZiBvZiB0aGlzKS4NCg==
