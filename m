Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CE36AB57;
	Fri,  9 Oct 2026 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573611; cv=fail; b=fYMv9P6TJWU5CETiGt2e/G/9lRZ4G4NTk6qEt/PuafQxWTL2VYkK0mc+qIB9/0o8G4OdzVG+tySIpi+zGX5qhyDj8DompbRnW/bkepELbkFNyWVyE1sak5XHonSYVhBn5rKjEbY/tdHcvU/C8fc3m3vUsUTtNW/oY9YaGMAwv1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573611; c=relaxed/simple;
	bh=nyMrdqiS8hPlwe02AGcrEB0RJ715upZXDQZKoiUbSt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJJ3WfE6p8VUpoWsEwQR6GEkP0cd5Wyn6rybxOOQOTMNnECNuly/jmxM7G/wA1IzKoCxlFe7rEusAqHKIAIr02GY9/774t7+vNUg2LQrMv0N1ghG2Zey08qdSHxqBMrmsLazqZ9G8/FB6SRiZHje4Po474doloLxgAbGJl94jI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPSx5tB4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPSx5tB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791573610; x=1823109610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nyMrdqiS8hPlwe02AGcrEB0RJ715upZXDQZKoiUbSt8=;
  b=aPSx5tB4xMh4N+glc3dZNufexbi8yUdfCmuq0yhhM0KvKCxK7x4aF+H2
   v276CS64wh+z9d97KN8gvTPv9AZ8pMq2ZIfkirWvz1U+w5bAUwHpbKOHd
   ykYG9HHprPV5U+PhWlKqttYRI4Py6joHPX4NPAWr/xaay4bCIm93WXuS0
   QUFwiCLuwWa4VVRkzkbpXVcM4cdAQo/Q9GHQ1/b05zC4nK9BMKruU3cBJ
   4jlxqLi1wcAYPXVL/Vsn1p4emFbVgtHOBkXIc9RlH74pOnN57UrXHQlnX
   CNuxnprroD1IGInlrdrNGMlFde8prM2wJBuEm30qTGKDXWIYIL71v/nao
   Q==;
X-CSE-ConnectionGUID: x6KBwItzRQaocG0WM7TiOA==
X-CSE-MsgGUID: HfQEzHhFT5mMQo3zxpCdDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="389354"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="389354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:20:10 -0700
X-CSE-ConnectionGUID: KhyGz1qNQ2WMH/J49trmtg==
X-CSE-MsgGUID: eIwXoXpNQz+O8qzuxkTwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="576091"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:20:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:20:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 12:20:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftC+HE7kg1uMsfQzdRnX2q9w0/luQoBwFCzygQ9qpAIfPD5HXiI8z580zuyLlwL35iGOAT5iFZIhtSjfoveLU9msbzTNzs2/R5yUF6mvQiXg34+Lm12gsVjwz0eD6tZDvvk6DXjrLrDNhI4RaCwQwgKnVAAN47cfwLp8D0EwjBexxNgR6U0DKI8GG7tdr91PWRpqzgEFHPkX7Ks1avjBFYz4M+gTAr0e4XX2Zq/LV854IWqZv1QPsn5e22/0Q0RPOKkQHg7QdeSFLFO3twVIa89FrmKiiN7sR837NH2mMpd64kPzOfcv1PRGsh2bUhJI2INUG7zz6GnKgicjJlvRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyMrdqiS8hPlwe02AGcrEB0RJ715upZXDQZKoiUbSt8=;
 b=MqGcLuPC+ZZHRMmlv28fjNRB0rLYlfysjN1lz/Lp4fpCKGIQl1TgBD1ZS/AMipiWaQUExJ1xseVP1yNEvsHZHYgOeTPn4BCpeP34RXQ6/Sip9Qn1NpK5Kg66MVh+FE39OyCwvxWqTfd1ZO52S1Ee218gS/yGIY/Nq4GEVb/ZtAbi1L+ECoyDrSettEKYIt3x3/Y7eCAShMYmZznaBL45MNRZapfWrD8Bs+1LJxXo0HNDl7oY5iQ31HhyxNA+1Ka2CrZb9GdDsTKdy+sWKybQcQZ5T46P+78gY7AGrJTLhuP70VZ6h9poPpLwMLR3T4fa2T5IxSWEuJVkoUvpNM1EBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 19:20:05 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:20:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Topic: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Index: AQHdVPFz0zR0HzzweEaT4mqBwwRpsbb1nHuA
Date: Fri, 9 Oct 2026 19:20:05 +0000
Message-ID: <98326b43a055030bfa4671df5c00a78dfc16322a.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: 0a0e002f-e17a-4b69-6cfb-08df263a5306
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: 1kQmtziP/VavH0n0voqLnMuVnTwn6BQkpGvHIfHgBUIWFbMLlJtttyC4NOZ5g+xgO3AcHZqhbHOL/eO3hXjXsLzcCzhii2luS9G0I2AnKfOPsy9asjwnSV5D8DlVcoyJ0p2W6sx4VYQohD0PK6sBFeCeC9245i0TIzObS+Gh3oo1LjyMWmM2wBBTt4uiF6W+0lVLxsgE9R0cvgAspEeux9kh5A80gkE5KIvMjotiWuTi/z0f4ApVE62eOXf6H+czkKBqZJvRrEzIqnDEWGo8ognPY2KK5Dl3oxXUUf6rDZhdMF9nhyMQ2mXHU5RRgumfrhjNHZ3dpF6j34bX9ddzZ9/P0npl9LI80IXs+EzLGAwv246cLukluXp7KS4P13czMJLYW65iUXOfcdmEht8V9FFoiAtJMc/PCsmxyRzwzVt68f8fkHh1V8T4cO5CEHpvpTi7mk7jHlD6dai/SCryldx+Qrq68qpz4S+QFl0NlXogdHJqpkUVaehQbxVPcRdh630rkHQhoy2aZMqrb5Vs2zvekfVWT9gm/89GwaHwpnI2LYS1PgjtbT/v00wAtHKtj3YRlPJ9Lh5W+ei3fTFozpiHTIhtg7dVKpbg/eA/5Cm+zXEtloo6RJj02cqSyx2iV42JXsyuDq1osoAkOYxCGXMGbsH31LjtvkGDfMyseWYerBrMms11PtSJmOoTf4XORji1jVVh/vmGrIUP2IFhz8vLDnVUfOi7kOaIeN1OCwI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkJBM2RnUlFBMkxlaHFmMTNhUHhEbDNmd1F1a0x6THJkRlQrNWVJVHhlK1hB?=
 =?utf-8?B?Tk9BNHJ2eU56WGdURSt5R2Y1ZjRnaDZHVVBJRHYrYXQ0NEV3YzlLbHludG1Z?=
 =?utf-8?B?M243cGs5MzVYRnFxNjEzMFF3R3NkN1dnSXBCNHRvZ0U0K1NaQUtOeEVGMytJ?=
 =?utf-8?B?MTN3WjdBakZYZkRrUDFaNjVHOEZDbUdMTEFRRVV4QkhlNXdaWnlTSUV6eThr?=
 =?utf-8?B?WmQwVFM0ZmlrZ21iVjZpa0JlTWtEQWZSdmZyMG9aMGRwUXpOWDRERUtqU2ZS?=
 =?utf-8?B?R0YvQzlWMVh5SXh0cVNpUWRUQ0k5d0lveW9VVko1bnV6MVY4T21kSkNwMENo?=
 =?utf-8?B?QTh4aDdwSDJqcUNYWFNEVENkZTFtUldRRzdFR0M2MTdSZWZMUHNVZlVQZ1Vu?=
 =?utf-8?B?NzlJanJyZmVIRkpvSTF5U2Y2Z1FNYmk0QjZTelVMODIzZjJFMHF2bnFhSmps?=
 =?utf-8?B?SGZEZUo2V1F5TlpUam90SmQ1dUQ1N1lNVW84aTJHVEtGSGpyQVFKNEZseWo4?=
 =?utf-8?B?S0RWSUt5enFkSEdtR25rcWtmSU56SVBGMEs0bkcxaTlzbDRoN2VQbUNFWkd5?=
 =?utf-8?B?MEdVcGY0blVpRThOZ1EyVzBLOU0vT0llc3dEb0pGVUtlUHd0L3MrQ2tPYXhw?=
 =?utf-8?B?b2daa3B0Q3FDdjY2eEo0dXpvdGpPblVXSXY4RnlVQW9SRVduTmg0WVhVUVhG?=
 =?utf-8?B?SmpTeGJrZEZwVE9MUGNyMHo3RFpqZDdNSDJnZko5enFEWFRtZ2JCbzQ2Qlpn?=
 =?utf-8?B?NWxiZDdLUXVMcnhlaE1qYzY1VHJ2WkpjenI0dHRGYWd0QUF3eHJPU3VudWtz?=
 =?utf-8?B?UFJBcUR4RzJOZVF6L1l5VTlQbzNuTlVnMVVjQjRSN21LM3h1dTZMUlNZMU9C?=
 =?utf-8?B?MWhHT2dMQytSSVVLMjZvUkFtWVdWNGhvT0R6Qjk3b2p2UE1sQmw3QXYzMlFR?=
 =?utf-8?B?U2lrTkxrMGNjam1IT0djRUhnTUg1eTFVSEFhYXAyaCtVa0Q0R3JBbm4ya05z?=
 =?utf-8?B?eVN5RFBWMTRNSXFMVjVucEttWVR1UnVlckhnbjhTeXVtWVEyQlZXNkRmM1BC?=
 =?utf-8?B?RHQ3cmpaa0ZOY3VLMm9kOWt4Uytxd09jRE84Nm5uczNVZnhaVi9JWGw1Mm85?=
 =?utf-8?B?U00xUFBWWHlaSHpFZTkwQktmWklJZ2hpc29IakhzNTM3NzBsWnV3MWs3aTFO?=
 =?utf-8?B?Nm8wWGpxOEJaNE9jM1ZtMHQ3dVJ4UnpZNEhUd292M053ZkZEblRIaFpSbGJn?=
 =?utf-8?B?byt0biszdlM1Tnduc0dDWVo3cnh1L3VwRTBpeUtZQ01zbUtxcnZQNC96dGV1?=
 =?utf-8?B?bStZUUlOVFNtNnIreGlPT1FIaDBmeWd5djB6MXY5bC9lcE9PV1NVMTc3RnRh?=
 =?utf-8?B?Q1RNRnUxT1BMK2QzRGRnTm95WmpRa1FyZXhOTUdWZmdUSEZsWUJ2eGpwdDFI?=
 =?utf-8?B?aG8xOVRXbENUS0FlRndDK0FXNjI1YkhiaW9lbjJTY2NjdUtjTTVMQk42R3VM?=
 =?utf-8?B?MnNQcWsvbE43YVZPNVoycDNMd3dtY3JFa1JZWWFuQzYzQVIzWWI4Y3FaWnZF?=
 =?utf-8?B?eE5TNFFlazhuL1J5VFRxSTRtNzh6eG9selM0ak1hZ1llRXdyL0hUYWhxQTdN?=
 =?utf-8?B?c29qaXRGaHo0MDhUV2VNTE0zeHNIQ1ZGQWp6UUdiZGVmR3R0dDRhQ2F2alVF?=
 =?utf-8?B?TkYyWjdsTkY2NytKSGdUZlorNWlIMXRwTWNPOHJBcEYzbThsSGFOdFFlKzI3?=
 =?utf-8?B?dm11MDNKbmk1RUZGdXZpeUxHbWJScWxwYXRYOFYzVEVmMzRST1hHTUdJUVY4?=
 =?utf-8?B?dUV6NTBqbGhpR2Zmdm5NUTlyUFJUQ3JzenloL0ZDMVhsOE9xMUhPNnBCMkpr?=
 =?utf-8?B?UkFhbUJzNmlIellTRHA5T0R6Nlp2ZWxPb0xZVWVpa1k1TDlIZUFVbVMxU3Rp?=
 =?utf-8?B?V0s1b1JyZk5VRDFaRXFpb0pnR2xDNTI3bkNQQU43Yi9FQ1FPSGpkSDFuWUNz?=
 =?utf-8?B?anZKeXJPL1R6ditSR08zZDFKV3RDSjQ5N0g5VlgrM1A4ejY2c1pCb0hXU1Fq?=
 =?utf-8?B?bkM0RGhTeWQxQ1B4V2swOXZHWk1nYXhVMHlUMUlUS2FYUVBrMTF0V3hWalhT?=
 =?utf-8?B?bGpIQzFGbVovNjA1SHlZaC9WdmFiNVlFSnlVVytjdFc0M0tZcGIxMWxKTi9h?=
 =?utf-8?B?bkhxaEE3c0c2ZGJCT2pYekxlS2N5K2ExUzlzcFpuY29mY25hY3NFYm41bGZW?=
 =?utf-8?B?Uys3blZiek12YUdNcEExNXlrVDZrU1U3dnhjZkVSMi8wdlBOaW1YTGxBWnhI?=
 =?utf-8?B?R3lRenlQWTRVZVlPWlk4SzNSODRFMnk2NUN2T0xhM1dnWG1CcDRNSHhEellU?=
 =?utf-8?Q?xidYHw6AS4aLoT9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <680ACDEFEBF2B94284063EBF94D3FB7A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d3NTcutuHXHuMOzedMBf44Wb75LkL8XVltaPld4wx9EglIAU2b5s4g8e/0bjdw+dAd/Gb8XTzqXEuNr+8+QGsdRv9zR+X2tM8wo7tgj4fYX1mIVuYbfrz/ctmyFRRJb6qq3Z9leJ9z4g/WPWHBtkIK/HQPhICGwz8wXd3XK/P8xOyRM6rcKJ/qv288CkQ/Tzkrn2iwux3K78erWCwPwEwF0P1wULVhEW0Xqe8AwDrnDhkZz23YSc4W0GJXwIA9VYvOnGjxLdRZ69/c441+IJBDC5M8mbR2uSbjuYYnHecn9W9BGS6tftxXB9oxz+Kr6rrwx8Hzlt80BqRkFMeeoHzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0e002f-e17a-4b69-6cfb-08df263a5306
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 19:20:05.2454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRcZM+SQfiXFlo2uwU8HCrh52J/ff8rVeup5yDrrkEvI6ENtd0qYSR0LthnC1b+K4cXO27eDRKoSfsZ4v7w1GU/1lwMfZAy9PlvFaF7d5dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTA2IGF0IDAxOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gUnVu
dGltZSBURFggbW9kdWxlIHVwZGF0ZSBpbnRyb2R1Y2VzIGEgbWVjaGFuaXNtIHRvIHVwZGF0ZSB0
aGUgbW9kdWxlDQo+IGZpcm13YXJlIHdoaWxlIHByZXNlcnZpbmcgYW5kIHJlc3RvcmluZyBURFgg
b3BlcmF0aW9ucy4gVGhlIGV4dGVuc2lvbnMNCj4gZnVuY3Rpb25hbGl0aWVzIHNob3VsZCBhbHNv
IGJlIHJlLWluaXRpYWxpemVkIGFzIHBhcnQgb2YgdGhlIHJlc3RvcmF0aW9uDQo+IHByb2Nlc3Mu
DQo+IA0KPiBUaGUgVERYIGFyY2hpdGVjdHVyZSBzdXBwb3J0cyBhbiB1cGRhdGUgZmxvdyB3aGlj
aCBhbGxvd3MgdXBkYXRlZA0KPiBleHRlbnNpb25zIHRvIGNvbnN1bWUgbW9yZSBtZW1vcnkgdGhh
biB0aGVpciBvcmlnaW5hbCBib290LXRpbWUNCj4gcmVxdWlyZW1lbnQuIFNvIHRoZSBhcmNoIGRl
ZmluZXMgdGhlIGV4dGVuc2lvbnMgcmUtaW5pdGlhbGl6YXRpb24gZmxvdw0KPiB0aGUgc2FtZSBh
cyBib290LXVwIGluaXRpYWxpemF0aW9uOiB0aGUgaG9zdCBxdWVyaWVzIFREWCBtb2R1bGUgaG93
IG11Y2gNCj4gYWRkaXRpb25hbCBtZW1vcnkgbmVlZGVkLCBhbGxvY2F0ZXMgaXQsIGFkZHMgaXQg
dG8gdGhlIG1vZHVsZSB2aWENCj4gVERILkVYVC5NRU0uQURELCB0aGVuIHJlLWluaXRpYWxpemVz
IHRoZSBleHRlbnNpb25zIHZpYSBUREguRVhULklOSVQuDQo+IA0KPiBMaW51eCBydW5zIHRoZSB1
cGRhdGVzIGluIHN0b3BfbWFjaGluZSgpIGNvbnRleHQsIHdoaWNoIHByZXZlbnRzIG1lbW9yeQ0K
PiBhbGxvY2F0aW9uLiBTbyBmb3IgTGludXgsIGEgY29tcGF0aWJsZSB1cGRhdGUgbXVzdCBub3Qg
aW5zdGFsbCB1cGRhdGVkDQo+IGV4dGVuc2lvbnMgdGhhdCByZXF1aXJlIGFkZGl0aW9uYWwgbWVt
b3J5Lg0KPiANCj4gR2l2ZW4gdGhhdCB0aGUgbWVtb3J5IGZvciB0aGUgZXh0ZW5zaW9ucyBtdXN0
IG5vdCBpbmNyZWFzZSwgdGhlDQo+IHJlLWluaXRpYWxpemF0aW9uIHNraXBzIHRoZSBtZW1vcnkg
YWRkaW5nIHN0ZXBzLiBJdCBpcyBzaW1wbGlmaWVkIGFzOg0KPiANCj4gwqAgLSBDaGVjayBpZiB0
aGUgZXh0ZW5zaW9ucyBhcmUgc3VwcG9ydGVkIHZpYSBURFhfRkVBVFVSRVMwX0VYVC4gSWYgbm90
LA0KPiDCoMKgwqAgc2tpcCB0aGUgZXh0ZW5zaW9ucyByZS1pbml0aWFsaXphdGlvbi4NCj4gDQo+
IMKgIC0gUmUtaW5pdGlhbGl6ZSB0aGUgZXh0ZW5zaW9ucyB2aWEgVERILkVYVC5JTklULiBUaGUg
U0VBTUNBTEwgbGVhZg0KPiDCoMKgwqAgd2lsbCBmYWlsIGlmIHRoZSB1cGRhdGVkIGV4dGVuc2lv
bnMgcmVxdWlyZSBtb3JlIG1lbW9yeSwgd2hpY2gNCj4gwqDCoMKgIGluZGljYXRlcyB0aGUgdXBk
YXRlIGltYWdlIGlzIG5vdCBjb21wYXRpYmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWls
dW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNv
bWJlIDxyaWNrLnAuZWRnZWNvbWVAaW50ZWwuY29tPg0K
