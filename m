Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00C23AE87;
	Mon, 13 Apr 2026 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079439; cv=fail; b=LNCiY9JMXZMe6TPBPLuBKH8030Zxu8fiPBrSIo4aJkKt5gmZaO3k6LO5hReZJJGlH+x5Aoy1JNjNCXRbyq1tF4yLjc/YIvQnK2ID1sAdtY2CTKMEK2T/uVLJ6nTQ7zBjVeFaNUJbepldLmpT48dfDYF1dFzNCHyzInMxmO9ZeiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079439; c=relaxed/simple;
	bh=IWX3D3i2HG3VGsHkytdFlWQf6NAT4foDrN7qzVRtnLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUOoMCzOM5SyPVR33kYwLBt/qF0GF2YVH434CVO3xKq+1ZozBkyPxLxmc7YLLfLXQeerxlhyMRfv+5rOzh3vHNpWs6dz3IyKh2/vNoR/iHDeBzQSH0F+YEHkv4tgMORPM0NwtjbdrTPt6xh1QsJCNbnGPC3mLiBlUqUajSHySCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6nRVrJ2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6nRVrJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079437; x=1807615437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IWX3D3i2HG3VGsHkytdFlWQf6NAT4foDrN7qzVRtnLU=;
  b=m6nRVrJ2vt9Uhv5B4PDMI0bxEhCabnt6uUwMmGcAm2Y8SEt9pLK3zNLF
   OGOAqSxWwBWO7D4IvktrzBU4H3nURZ0zHt+06GZyp36B5R+KEwzC3Otsg
   GEra39AAyvk4gVU266pnzVYf55+sJvA+fXFrDB9afaJNyThjlMs8nIGXh
   K+vyYPa8Tesc7qqNE6GPciY/uirodS/erQO9+bKNF2FpdelLcL4Nu5R1i
   Y9iHkefHCTViwq7BrjD9t2tJ2vmcxxkJiACZL3fUqHo6P6gs5mFke3G4O
   GxDJlPQafLyqrjd7i28xSTxO0X9JLX5ULpAJMC+CQJcXNz35N2MyMPIk6
   A==;
X-CSE-ConnectionGUID: AV03N7LBR8qgmxwkINYMLw==
X-CSE-MsgGUID: js35G9hATxOg3+hC65AtPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="102470676"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="102470676"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:23:57 -0700
X-CSE-ConnectionGUID: tcj+Cd8fTnKv41l8RQFQfg==
X-CSE-MsgGUID: hJtqtBm6S267U8JR5TjhdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="225479090"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:23:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:23:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 04:23:56 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZrx0/Kj3dOZs/3DCcagxK1EKBq0DMpoaeT/RqdsDFSOM1SXdaHmtF1FzAjRUbAsKZD3AAreMW3xRgmYhpM0LJzJnzJqWgcLEyCcaX9dOdwMowiYvPn0RDcrbGBtL5dPoUspIBc5vinsP1LAhE7axhlfgxC0tjcWOKrDX1kZED9nSrtpqR48n0ftnZfr8tw2e6PSt3aYnf5tbsdPdjO6Gwc+DpfmRFM8EEeV6JXZjzW6ZmcsjslCFHKO/37T/z+Pdx0ubeddeTSxjJMZP+yTatJZ5yhMoiQq3o68WqarQr1KEO9XJWTW8NP5hsfk8bTMF6z97pmOfNWsceg9FEuszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWX3D3i2HG3VGsHkytdFlWQf6NAT4foDrN7qzVRtnLU=;
 b=WnTVs1392MxdmebTIeuVLqn/vlzf2TmDMtlyXgYyQqDCsy3mCWnvJfFTXKqHqP0l+Sj36Pt6AGHjmdEQMjYHVxsV3XabLLcsarWjyjEmgVYLwRsczu2cMs6/fJ/JwfuCNRQyVBXzU49B+JyagZ5TLgB3P3ucu3Bmy7xsd0zandZpHY3Va3moGAibwqVB+hJ3ZJAI6jYjV1Bws5NiYVjsW5pEIQw2km8n6sYvreGaz2kzBSUJ5F8S3hSD8gsb8wO/sJXxImKmgw0rCS+zD6aO/uu/W8dtAvBabzc0huho5YVU9GEEb3qjsyGLlowJei6JrPacwyuDDtrqrjN8CrJFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 11:23:45 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 11:23:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/6] KVM: x86: Drop the "EX" part of "EXREG" to avoid
 collision with APX
Thread-Topic: [PATCH v2 2/6] KVM: x86: Drop the "EX" part of "EXREG" to avoid
 collision with APX
Thread-Index: AQHcyHJMCiAfQubgRk6VCjpjCHLe7bXc3xIA
Date: Mon, 13 Apr 2026 11:23:45 +0000
Message-ID: <d26930e6f04c41faec4a321a63ed8fef02ae2903.camel@intel.com>
References: <20260409224236.2021562-1-seanjc@google.com>
	 <20260409224236.2021562-3-seanjc@google.com>
In-Reply-To: <20260409224236.2021562-3-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2647:EE_|SA0PR11MB4671:EE_
x-ms-office365-filtering-correlation-id: 81be1a76-5cbf-4b99-0e96-08de994f2003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 2VkgXzeNusJRpAfopI+q6oqeVBHpoMbxSARVUkSh/M8FBaq4lEDrPFBiJRDCYzcJcWhPJxROmwoMN2TwS6xCmUMor33AegUoCdwChRaLgdcV6E5bcKIlXtdkfYi3rmG4TnGh/AFJNP0XeBOlhDSWCogoQSVDHCZG+AlCtPGNZxWegVEdSXRHxY08Ok8ggycMfnvPxRhPE0a2gcXZZE3c6ytUzzWOJ2HJJ94sCbYI0VEA/QBZyovn6fxG3s/TxLmpIhArf+CZfXpz1bLO9pCkdyKN/qwXje3BENZoJS50kaI859acYp/BUqkPILjvEVmZdaZ0O1w2IF0TCx677bKu/UXX5GcqawsA95PjZhEN7CCdGSv2LkgVTdgaU/Pz3lzu0tm5RLT4y1cv32MRoXdw5WOQzNu3h1dYFrnlCP+JEAehGq9x0ea1dX2dqBY5HNYPBWXbnjv09dLGPtGs5jtFIWCpdWJ5MbMUhtIR4I+QiZPqj0q4JmxFnKSETbA9r4BaWN4i7S4xrlyNiYO40jFThMYQAB3HLsEzjJ0Ys5OYA+EVgKFRwoaNRHYMXtqX1vjzGJQqrOKBSTUiwhccB8UJdpRr5A9hSrzuT4ZnpGXYfRMK3jZGRT4KAkit0AkyrK151OVGG6YaDuQCVFf7h9OoJ0oDtjb39v379A0DYbKen8zqH2g3vOktTWCX4DH/xDvAv8heKR2C2qYmuFnJaIkhOIrYHs0CeeqBwAW4Rbp8X0rDueJ+dh7XV92k2qrzMPCbjclLU1yAssMvUAijyKBdbayQL1eRsziS0W9brHx1VHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2kvWGJNTnBESVl3MTl2YTVUbnVvUytBcFM5UFpoNXR5VjZBZm80V0sxbyti?=
 =?utf-8?B?cmdLeFhQUXJnak5XY3ZKTEhCL2VMdDZnU0duUTNpMGhnUXo0ZVJ2QldML1gx?=
 =?utf-8?B?V2Z5R1g3SkswaTNuWDY0U1BVVzRrS3NydWVMNEZUbUlnakVTYkw3QUZwSnNq?=
 =?utf-8?B?UlR4encrTzhZTEQwYXcyaHg4QXExSmlkRXdVN0E1VWtJVE44QkpVanR4NWpY?=
 =?utf-8?B?M1dkR0dGSCt2R01pTHphTVJwb3pNb3lYYk9KK0ZpUnkvd1BmNmZiSi96em9Q?=
 =?utf-8?B?Zjh0RHFWQzJVL2lVR1Nid2NnaGxPYldoOGpUVFhVT0pQeDl5SG1WSUxWS0gy?=
 =?utf-8?B?OXdnUjVkU3JpV21xczk1NUhBbk1WNUxIK0ptY3k3eXBNYlVnaTJnb3JTTXVj?=
 =?utf-8?B?ZWh6SmdoRkJTWUhIbzROdkkwbDZrTFZWL1lEdnpCZnMzUStXQlJaRkhUZno1?=
 =?utf-8?B?aEVadENuc0dqUmdWNnU4ZjhHUHJnTlFEUS9tVHhqWC9tYnRmQi94L2s5cFBZ?=
 =?utf-8?B?Y1NRY2t3YVpubjhFeVY0QUJBMUhjMGFiN1dtSnQ5V21OK3JhRGc3NEdoNUgx?=
 =?utf-8?B?bXE3QzM0WHRiMm4zWm5ZNHQ3V0FnalpQcHF4ZTVPNERsQjB3RDhXaFc0SkRC?=
 =?utf-8?B?TEkvS3hVQURYMnorMzJDWUhTSjJrZTdsVDVZb0RsN1M4N2RqdW1mdmRHZWk2?=
 =?utf-8?B?T2ZHcjd0V29zUXZjcjE3dk5wd2tiV3FZSFZld0p1ZkpwZ0czallwcjdIK1Zh?=
 =?utf-8?B?K1dyN0N0Mml3T2ZiYjZ6ZUtFVDJEZXNuT1ZWbGVVL0dJTVd5WTJEcWROQWMw?=
 =?utf-8?B?NjR5c2NjTlVBYVc1QWZPL2dqc0ZzeGFOYkJUNllMcHMvLzVVM1JhY044a1dF?=
 =?utf-8?B?SjE5Vlp4TFZHdFZiRkl2c0pKZGNGY2I3QlpOTVhKVDR3cjIwTDZXOGJWT2lr?=
 =?utf-8?B?UTY2TUdtazdlcmNJSW1vMzFRd3FIeFZOV3dZd2N3L0NwOGFvYTN5dEFOOWUy?=
 =?utf-8?B?Qi9Wakt5cHQxV2Z2am9rVXJ2VzVCYjJyWElVUHBGWnFNVE5lVHAwQ3oyN2dQ?=
 =?utf-8?B?MXJyWkViVC9RYUVlaGJ0MUdDUzloTGxYaThqVllmQkVrUWlrT2EwR040NWNP?=
 =?utf-8?B?NVNzT2xVTzc1ckQ2QyszaWpabTZQTytMaVRiemhOZmV5V0NkMVozbE5BSTFz?=
 =?utf-8?B?SE1nejdDcm1rQkhDZHBZd1ZOQnZITXZQbUJjc0ZEWXl5WUgzSmFGZGJXb0gv?=
 =?utf-8?B?TjE5TWxyR2ZSblRrMUpJR1dmbVhuOG9waTU0NDRQZEg1T3VPa0pMQ0FCdE1t?=
 =?utf-8?B?b0xVem9GNFFXOEQyZ0dyMTluQkxSS2theWVoOXp5Z3VhbEZQTUNyUUxsWHVO?=
 =?utf-8?B?bEJIb1cwcUhuTGZNdEUyeGlIMVQvdmFRaWR6d3diZjRyOEJlaUoxcU56VXFl?=
 =?utf-8?B?dElqQXpwYmxSaHRPRWZpc1F6UzhGdlprRUtWTnJoUDZaWmZyb2xGTC84Zmk3?=
 =?utf-8?B?SXIrSFBHS1QrbjhJMXFHZXlHVktnR3NzTmhyS2pPK1VESWtlSWNlVEZydUEv?=
 =?utf-8?B?L2hwbTB2YUcvY2JPbDQrektDSkw0ZmlsMVg1Slo4UHhuZWp2amJWVy85UW51?=
 =?utf-8?B?NjQ4YzhBQjgwcEZ6Y3VuMFllN1ZCblFWc2szdEl5RkpiaUp0RSs0WTJidVZU?=
 =?utf-8?B?Ry9zM2RJVkRYWnJJRUhyR0pBMHZJSjduOVhrRVpPOWw3SUlsTlZLbzhuRCtQ?=
 =?utf-8?B?L24zazBudzE2Y21BZ0V0RlhGT2UrSEN6ZjJ3bEEvcDQzRngwRy8zZUtXeEZI?=
 =?utf-8?B?Ly9zampVM1dlaFd3aHhLR1dQME1rNkZzeStxOEJvRGxiNkdCK1FSRUdsaG81?=
 =?utf-8?B?Nisvc3daS1BVMy9DbWl6Q2NrQ1djMEg0d2pRVS9ZZU5hMmF5L0s4QlFMdkpt?=
 =?utf-8?B?djNweHRMa2RITFlRanhYVTZDelo5VFhHeTIwUEp3d01jcVpFWVF1WXRQRkcz?=
 =?utf-8?B?L2RGT1hRU3l5MnpIL3MzSVQyY1VtTU5LT2plV1FYK3hBZXowOStMV3NhUjJ2?=
 =?utf-8?B?Rmp0TzIwbkpaVmFnRDZBQ05qUEg1YjFjWnVXWkxMQisxUGhFQkJsTWlwajJZ?=
 =?utf-8?B?bnE3UDhsdjFsR1RwSGlUVFVWNmRBUEd3VmdvUFY4enNUZmg2UkcrYkJ1SmdZ?=
 =?utf-8?B?Vm50ak9NWDhnb1ppR09ZcW9iS21ad0pUbCtXazdOb1VLWVVNSVE1bldYcVBL?=
 =?utf-8?B?RXhVVHhxQUhxa0lFZE9HQlJCMFFHVlNsYmpJMnk4ZW1DSGZXdi8wY0YvNFNo?=
 =?utf-8?B?UlN6KzJFcFR5TGd0U2NveXlTT0t3dHFqTkxtcklXa3ZXdWZIcTl0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33B20A52A896A54B8C8B49C1CEB173E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BpzX+XLAhKW5BgxNfLxmqNN6TIYzcofAwBQ95kCJWZ8BV/F2w8eGpXCZyS6wXeuh4rrLYUQ7q4/p91Tzheanz8+cv68fA4voOcuYqiDxtUNUzXjMmwb6bljFxzncIYONgRHmQppPpDgemkIrGj126HBOIQXFP2sGBEqoOX/8lto8grLwBWN4MtB5BckvhMMk1lMye9otrgPjBvAdb/cTDBFWbe3cVWRCrk9UQCuL7tlBHUR31zSih36Gj4CMAY7mepF+hWtpjerZTBcRh2DdNbsFJJ0TP0wn4NcGrwg9c/CqgcxmrQDFQzU1tWHe9KeseiDuIY5yPeWQUajRlDReqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81be1a76-5cbf-4b99-0e96-08de994f2003
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 11:23:45.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCPCHHiCZvbrAqhX5kCE1NfVCOsvTgGaa9+mFZBIiLy2O5ez/iw9SUpmTdlq7A45LFfbytPhZoakHFR29kx9EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE1OjQyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBOb3cgdGhhdCBOUl9WQ1BVX1JFR1MgaXMgbm8gbG9uZ2VyIGEgdGhpbmcsIGFuZCBu
b3cgdGhhdCBub3cgdGhhdCBSSVAgaXMNCg0KTml0OiBkb3VibGUgIm5vdyB0aGF0Ii4NCg==
