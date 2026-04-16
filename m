Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CE253B73
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360708; cv=fail; b=oubbUg8uB9tr9p7eQq1WYOBu2+ITQ6drq4/imIc1mFSNiI5gmoMgTxAUgbf9aCaeyY54XPXpzNXPJoF2eK+9xmgcYwoexYbegoSJtqsvfcwaNFjSNblmAapd7oDZGkx7hDDgKsxnJsq3mjSXwh2QtufVjk0hNnSz9FCgsk4luHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360708; c=relaxed/simple;
	bh=BPNhq9QUlsOnbzIhhdo/E8pka6zfK05ZK9W68OQkOD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YvVdl6tbRr3aPG3aTFesXBVuXp2z4/iYqRgH+qJvq6u0p6WcWLLAD+S1YQrzIPMhLbZJ1GeDwEG6gJ0VSjgozW/RKegFJHhrhWQta5UEYBb8UcrZdFPEFXSlz4X5yCERd/q3RQmWZXLbvbj8TYXc+s94jYlKRFnlEAxo0n+xC6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt5swUdS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt5swUdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776360707; x=1807896707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BPNhq9QUlsOnbzIhhdo/E8pka6zfK05ZK9W68OQkOD8=;
  b=Rt5swUdSKhgJU/0+l3LpXzaJRVoui4L78QZkH+PcYJ5U9GH5R3mUFxEP
   Ts1n3nQNaygXr6HmzslSolZOu+X+WsLsKphju8yDXP1TKzkXIhb9+3ZpJ
   PKW4MU7nQ41RivLG1Tfe4lrkXhqmWF3UdfcOeQrOfAOYas99J2dbAchl6
   MZDM3BS83XSQf8m1Dh3EjO5NPU+BCHI85YAcc8VEXr8ghiM+R9c8c/3eB
   X+OLnheIeTfNpZu/KONFnntPUTiKTmyCI9zN+QU6fMmHPIKsSIMlaPjoG
   WoTgywCbr43hFj16MbkqS0Ah2SaXA0UkbBX0AWa1xCOwPMWWVt7adoazv
   g==;
X-CSE-ConnectionGUID: CSPy1lY+SzafYP56fZVlJw==
X-CSE-MsgGUID: oMayovgKRhenlmVw8B5XUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="102831018"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="102831018"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 10:31:46 -0700
X-CSE-ConnectionGUID: MJy2OZ+UTkabp/4VANnEkQ==
X-CSE-MsgGUID: 06mGZSc5Szu2Ab35Ejwzfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="226453482"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 10:31:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 10:31:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 10:31:40 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 10:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnHpJfNIvhZqgUjkamMhUk5JBK2nFbn1QHNCPp/9XSUUGr8m8xd41shrnksYiz6x7zb5FH1wJoPdCeQ+Y8ih1wijylf+QXXxLQ2a7+2nUA4Kgklcy1aXXf5t6f8Xu5mcbSp/SChV15N42TVYYhZUYopwclZ7yVjjhq2p3AnDWMRl/AsJiWrcfZCe1aj5YWEyjW8LQbqQzLC1FSrGJAIbuzr+ipPpIsq3gitFngt6kuuJLsIVpxNc9YePojhB2B7kquo8jv/QPWp19W9rOVxeXgrrIc3qDo2lFdSEwMH8NhuHGIYFjgnQeUYNIbLsslMFgikVs42wtBVDIrYuMX+VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPNhq9QUlsOnbzIhhdo/E8pka6zfK05ZK9W68OQkOD8=;
 b=LhzsEpsmVvoLNDmn347FO1KfJmwEAgjWw6XQbJloAfLllIZi6hWdrFE5yBAmyxtaX31oCEf+8jDmqnAU+Hpf8Rc3FmRSQIN3RqzxLLOeZ+5H4ancTz+0YI99S7ouRtm7BRk/1fZfBWpXA657SSLdb3V1TlcWj1ZPuO5X8DgMEypGnZ45a+wfmG5Qfp7o0VT9w9pL4xtnysNL3Egxc057Ah3O0914CKMRN9jIu3R6wBXMCUa47gpyoNWEoL8xorZtN/NNa3Dp2GgjABVozsrUcM6Fy18zxZjaqGDiqv9SM9eo/JgWhjHMbeJxFhD756rjCcvObV9wqGzWEh7GkHsMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB9723.namprd11.prod.outlook.com (2603:10b6:510:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 17:31:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 17:31:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "Weiny, Ira"
	<ira.weiny@intel.com>
Subject: Re: PUCK follow up: Trusted IO call details
Thread-Topic: PUCK follow up: Trusted IO call details
Thread-Index: AQHczQnudqrpzk3JFECXhnBHj5eLArXhp8GAgABL6wA=
Date: Thu, 16 Apr 2026 17:31:37 +0000
Message-ID: <3de9a2784dba69485bea9f2100677c53fcc11cdd.camel@intel.com>
References: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
	 <CABgObfasYTWmuqkz4TaTprcivwkzKGxAjdYZJVgO66HB1wK-5w@mail.gmail.com>
In-Reply-To: <CABgObfasYTWmuqkz4TaTprcivwkzKGxAjdYZJVgO66HB1wK-5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB9723:EE_
x-ms-office365-filtering-correlation-id: d58fec1c-13ff-4807-30af-08de9bde0368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: qggx4NUxBDfRaeOQRG/gQFu+QjZkIFxDX0mcvkBZnIuxC6t9ieIr/8AStd1b0mxDqEzArt7OfYiwkOe98hm0C5BN47A0bxTMulSdOXjdYNvLuVYZ0NsTG7bL9kSe1kLn+4IzCKvHxeQA+8cszRiePKpu9YrlCe3XBDFvg4rmeAKbi3r6hp6LvZw2mGX6FNcYLA74CI14GMyDpbsYbveuf3lE4guqPMkaULOuxMgDvs7TLOK/WA3TJhj6KrN39EtZyp1HS7I6T7vmEMnTjr7Sj6cQ2Ve65eWiNkcshC8SidiKLdV7P09H2Z8vmQT+dxwlevE4xkyeG8ojKDASVU4CkPdLWFP0PeZB6vaM+UJIwAKqkpCrAEXC9sKlhO1mz+JYeiOWU92Hzls2UsykwzQ9GW0qNhpO4AE3Gnok3ml8gbWxlP6HzZG2DZdXnGuEwjrvNrIVcrrlUAqtzNqkcgXyNFgrbuV4NuaOK3qFIapKRHm0dTN6TF3xKMc9yse7xsfLT3mxSXkV6YqHyaJxowbltljUbSTr1PD0ut/gaSJ9rIpzSg4xsAXFN6K85q7bTpaOa6S4uLMirOOJR8CUISsLuNtKH7sXqsR4eFd0rLd86g1++XFvKu508VhsPh1kA+ZWiuNR5nRx/Tk74Jcbf6Hr7hT185oznIGi1T8jnBzkq+Nz1krEzpr6ukBffwjQj0FGAt+BJMl5dMe51m7n+mADawpa6O3CxB/ji1ZEjIeLAE2F+sLFPJJFfZOFojy7w4V19ogEsedlnC3qzT761tx3nxTpXlQxLjrUU4L5YlcPLkc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VitOdEg3VmNoQkJWSG9qU011MTJVTjBKM2ZBSHFqOFE3MXhTazhKYjNycyti?=
 =?utf-8?B?Q3J3TzN6Ylh0N2RSUWhobE9zRDNDbXk2ZjJBQXVpTUpTQ05RVGx0dnlTV01y?=
 =?utf-8?B?VHhscXFYMERZZnhJSW45cFdFak56c3pFM1p1NERhZ0lweGdOQVVDejhGdXBX?=
 =?utf-8?B?VURPVXRpSVJjRCtrYUJ6dEp2RzVEVHl2bnJJV0hJdTcvYVQ1WSsxdUFSS2NG?=
 =?utf-8?B?MmkzYis2S2dSNTZscklHTGd0MFZORW9GL3RBeXZzY2JSc1Myai9EUjFTdVJU?=
 =?utf-8?B?cWJ0QzFjRWE1V25mK2R4Mkp0Z0RaMktieTgrbzk3NGpXakM4VXZlaVJwTU1v?=
 =?utf-8?B?SFRCWXZTUDVsbFB3WW43dHMvL0hDVEF6MVJUSHBjaE12cXkwamRjbFBiV084?=
 =?utf-8?B?b3ZkeDVpTFU3KzB1VnhYT0lRNTN3UG9VUXVFUkJQS3lyRXlTc3Mvbm1Yampx?=
 =?utf-8?B?Zm9ydU4zK3laUWd0QmFPc04xL2E0d1A0TnBTVzdqbDYwZ1pqMURyN2Rtc25E?=
 =?utf-8?B?ZG5kUm82TVdNOXEya1c4b0JOWk5tV3JDTXB2OGY0b0JBdEgwbmt0Rzk5aEox?=
 =?utf-8?B?VWRjcmJuWTVuUy94Z2MvMnhlZ2ljb2hHT2R6a0Z1ZFdOK1JpNjJTZUxrOW9n?=
 =?utf-8?B?NW5ydTFodnhDR05DVWQ2Zlo2RnpUUVB3YlVUbmV1cWNuZndSRmJXS2E0UW0v?=
 =?utf-8?B?azYvdmo0c05KZ1phVnBjOFdnWWdSZXNtM1J2UkdUSkJmNTZ6MVNrY1Mrdlkz?=
 =?utf-8?B?M2VDb3JhK29yMHJhZEg1a1BpOWZwVm9WMmZDbXRFV1oyRXc0WUYrUG5OZlB1?=
 =?utf-8?B?ZnZMYTd6aUc0VThtZHJBODRRUkp2dzc4a0g4Nmg5cHNPalRBeDE3TjcxaDd0?=
 =?utf-8?B?Nndld244WGNhMkJQeFd3S1dtbHJxZk1MTUFyM2M2ZDdSZm44L3Z2V0llWUp0?=
 =?utf-8?B?V3J5YXk5MjV4L2ZpS0FiU1NkdzBYdVV6cWVDZnVESTEyZElFMFJvemI5SFRr?=
 =?utf-8?B?bU1RVVh5SjN4U21Zci9HY25iMTZRWjU0OWRYc25NS1A0MkZxSnh1OGxrU3or?=
 =?utf-8?B?cTFwMmR5OHVUdzhQNXJWNFBzR0hZdmZTakRqcGtlNXZLOCtuN1JuN1BQRGdl?=
 =?utf-8?B?NGZreS9oZG5OREN5bG52emplYzNLaERhZXRkSkVpRDNmNlgvaEErRlBLM3Bq?=
 =?utf-8?B?ZkdPdUVrRzVVYk1LcjRQamo0ZWFBWVFlcXJNOWN6QjBzdVRuVndacysyK2Nj?=
 =?utf-8?B?STJESnUrdWNGUHd4MVgxZGNBaFF3ZTVjaTRCN25qeEhzRXNQMzh1UjV6MnRl?=
 =?utf-8?B?SjhkdmtMNmtkUnNRVE51MGs4dnVZSSthT0wvSEd1K20xTW1zTUJKV0VvcDcx?=
 =?utf-8?B?TENyRFN2bVdZMHZvbzlIYk9MZU8rcjVzTm5waTdQTkNqWngzN1hBRVgzZGNm?=
 =?utf-8?B?WE82YlE4UUUzNEMrb2F5d1Vwbzk0ei9neDVvV21yTlB5U1RxYm9sMHpOV2xC?=
 =?utf-8?B?WFZjcXpMWmU1eTV3VGRQTDN1KzA5SUV5ZDlrUC9TUUl2WnBFd3RCYnFuczFI?=
 =?utf-8?B?anVJTlJFZ212cmtmRGF6Y1hGNDZCSUtZbUlMdGwzV2dFR2R5UWxUNC9WYUkr?=
 =?utf-8?B?cUZMQ1IzVUFPTUlnS1lxUzNJa09YekJLSmtIL3NRZ0NqQ3ZGTERhQlZSSVd3?=
 =?utf-8?B?cllaN05GZ1hHckd5NmpFZCtpRm9kTXptWkF6RGxuQ0FmclVSdVdJVUh1TnFx?=
 =?utf-8?B?a29MbWxMbTlad0VGT0tqMUxlN1BjNzdWdG95L1VJTUtmaWJHNHNuRXVVR2VE?=
 =?utf-8?B?anY1TFg0dDdkNTNuM0ZHSW9rMWpENFVjTTV4YnQ3dy9tc2xMYzhNaDM2VWtO?=
 =?utf-8?B?dk11YkdCV0pTSEY4MlM2SEVTN2h4RjRCY2NvandxRzd5a05xVVF2NS9lQXgv?=
 =?utf-8?B?Q0liYmphUXkvbWNXdjE3R2xhdVlCZ3Bmd1U4cVdmSUtRTlB5WURXUklZWlBt?=
 =?utf-8?B?S0ZsSEZJYXkwdjVqekV0RGlCZEd4WGp0bzE0TzhVN1NWS3N3YlRSOHlIdDdC?=
 =?utf-8?B?NmlTOWFwc01iMFJrUUdaYmhXQStUS0RBUjI4ZVAvUGN6R21TS0hEa29CeUtD?=
 =?utf-8?B?aUV0Q094N0IyTWtReXFwYkNEK3F1UFRXTEZqS2VjT0t0SGU2NkxjNXVpVzJn?=
 =?utf-8?B?ZzcyTWdOVGh0emVrZlVEK3NBU0lVUTBacjdVZ2ZKaVUxWityRHlIbTdreWR3?=
 =?utf-8?B?dGVPdDZKY0dOcXJRWTBoRVNLU1lIZ0Mxc3Z1MHVoVGVuMHEvRWtGcnNCTUoy?=
 =?utf-8?B?U2pUZnJmRGxQbURkRDhDWHgvaFprM0xDOE9qR05GOVVxamtmRlBQRVFaTXVk?=
 =?utf-8?Q?mnIZB0D6QxQZ/2Sg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B15D08F1A217D419584AD50795A5FDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dN0v94kyf16uW+5RddBTLW84pMFrniRMPCGRbMKS745py5dwL1kl54Zvfq2YRi5Ca3VScWa9ISxVVXfhrV/aCDmMZHJ7HyRXw9wRdf9z1KtyflNwdBppa3yR0MsyqNlUtSyPAklnpwY3ab/sEBsrNWzWicP57z4lBe8zAPV3rbsecWFFL+nJ3OZr556gGR2xbziyTDfhiml8JblG/x9X2UXdUb2VNcOzjqy5OKK0jT29gU4Jtba3qKZEJBierTx6m2M0C+lgiaGvw92QRzBc4jr/KROaPC4DlLNu7qaq9Pxv7F6YYyRFwOMDriK4vumd/pUZB66JfIFmv3T0HxObiQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58fec1c-13ff-4807-30af-08de9bde0368
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 17:31:37.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNzwKdJQlRyZn37IvI6sOm/BlXI6UlzfDnLyCLKjtud70UiqxBriAuODNQap7eyI3VXY2AukkIIyjpFq3j5y0WqAwV0gA4HCP7l88lMY/1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9723
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTE2IGF0IDE0OjU5ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBUaGlzIG9uZSBpcyBmcmllbmRseSAoOUFNIFBTVCA9IDZQTSBDRVNUKS4gVGhlIHVuZnJpZW5k
bHkgb25lIGlzIHRoZQ0KPiBJT01NVUZEIG9uZSAoNUFNIDopKS4NCg0KSGFoYSwgdGhlIGxpbmsg
WWlsdW4ganVzdCBwb3N0ZWQgc2F5cyA4cG0gUFNULiAiS2VybmVsLVNJRyIgd2FzIHRoZSBvbmUg
SSB3YXMNCnRyeWluZyBwb2ludCBvdXQsIGF0IGxlYXN0Lg0K
