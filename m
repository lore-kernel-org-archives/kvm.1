Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F35427F8F
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153434; cv=fail; b=NdAPCrQYW4uOeKJ3V9eV4sEP5vliuDiCHV7xx+DkJhrTTpDiDBdc7lmDb8U1mSuX7T4FaqcSgjlEOYSG9ENBHm7EdC/dd7k52Pbmjt4l7bFoiSmLGwUpGR/pcxsUQWSqj2elfRZ8qJToYwQ4eDOU8Ypj3qwaxqFG4+UvvPItt5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153434; c=relaxed/simple;
	bh=8LR5i8fC7CR3idtJSwjniTNOXeyqzBPfAzm6njBQ2eA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=klZSaoJL9pj5PwDCzOck8MQMqbO38ksLfoOZfze9bieCG6Lv5Ymv80UlKYpeKFiHXY5fdzjNbY0F6tpYSRJWtUd7zqV5rmX3NNeVQfRikLp9x3WgU8jdswCawmc01V2FQZEVrpLw3M97IlGecL1p0OYpKXuyyPOF5j+Zbb4b9A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8VaWgYi; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8VaWgYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790153432; x=1821689432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8LR5i8fC7CR3idtJSwjniTNOXeyqzBPfAzm6njBQ2eA=;
  b=F8VaWgYip5TK8qcfoUWCrTRwgMB6vt60/UFcXMIf3qUCGAeeBTkXJNQB
   Su6wnu1RrjbHmsDqznnZiz7BYJSqpuGP7Jczegd6jDAihePmOLjcj9X/b
   uoLIpDvZvi97MjdHRMRr6eXtbZwhZMBo+QMueHUIqQwfsywcNLMAhxy1E
   LzBsbbxN3LUpDIvodgZnMbOEOPBPASyJm1h4Sq2buGjTxDkKsEyTT2AmG
   TPg4ur3VG0tFXXg3ZiVcFo0zBQkLAU83MuasqQF2iO8dGfGeYHrSwh7b8
   pqoTZADtE0rpIDvmC+5BxxA+pb37FZlXGzWU2Q/4TdSNJ13UE7YXc9TyS
   w==;
X-CSE-ConnectionGUID: oCjUpe7STIenFqEDhfAnOw==
X-CSE-MsgGUID: E9fixLa0Rm656KPIlIbIrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89744660"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="89744660"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:50:32 -0700
X-CSE-ConnectionGUID: ku0WVdEeQJO0Zds5cvWoCw==
X-CSE-MsgGUID: +ynkBbF4SKum+KXsGzJrlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4596227"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:50:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:50:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 01:50:31 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:50:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAA4kgnMK5PtlWlUx82muIGlTJvXTuInS3JztmDSmWxo741ypI0tfKraZiFLUFkQ3vydANDTslB1Fv0rZNCTth3tzw/+hDutkN/uApEzfO97Yjdq1rGHLSMUWyAGf+gmnKz0m/NBooZescMB6qkJ2+NqnnZtKcGaE0iarBEDzNuNrzk+KZdaSCZ7VX0cx45O52FBfOwzvOVYAIamQfb45YMrFfh99QdTryjxSAZZP0VT9ISCcP/8jN2U1YV9qVVIs7xgEB8QYwyHOxKg6tls9YMck3HeSorPZE1gTUoXx+2JP0vFw84tGewZspFwNX4qeGXUwx6Ec+g2euAW0JGMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LR5i8fC7CR3idtJSwjniTNOXeyqzBPfAzm6njBQ2eA=;
 b=w+8LDcdV8LYYlRzWkqsfkm6pD1Mc5ocVsnA7P9O+JsPdCwXqO9It5lWs5F10OQZnXbwaY1c/qrz0XvBUMuIUC8+HyACg2ShMm45sWWhe/+vT0Say0TADUvkckJW1ssEVZ3cxeRSJqvRLAp6W5vPjjSRnqngTQuQ5EpuVdsFeVkg/ENmEYx8BPlhWQNkmZo01ECgJbxc4BSLZOB88ka9OZjwPqDx/tEquSes+qyjcrltrb8dpBXAbSGBPmh6TLH1bRH2Ey3NwvLPBtf0BqWSFb3KOWfAQ+05XI9KcO6JWjhM/RALUW6BAE8zu17ywqdNrgIT+wxAh3CjHG5KIyXZvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFA84FA90FC.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::43) by MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 08:50:17 +0000
Received: from DS4PPFA84FA90FC.namprd11.prod.outlook.com
 ([fe80::3d16:f788:d216:291f]) by DS4PPFA84FA90FC.namprd11.prod.outlook.com
 ([fe80::3d16:f788:d216:291f%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:50:17 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "Fang,
 Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIAgADUxICAAEy5gIAAHYGAgAAafICAACp6AIAAK0aAgACxHQCAAFN8AIAAN/OAgATQzgCAAAQOgIAABL6AgAAC3ICAAAS0gIAAamdggACz0ICAAQTDkA==
Date: Wed, 23 Sep 2026 08:50:17 +0000
Message-ID: <DS4PPFA84FA90FC61E43D50956C3226AA02E7822@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
References: <aqxGN2Zc8sOl2RKx@google.com>
	 <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
	 <aqyAED5ZK48eEZtq@google.com>
	 <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
	 <aq048KmPN5WPQ4sQ@google.com>
	 <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
	 <aq2t5wJGLtsltMza@google.com>
	 <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
	 <arG7delLjerkKbYQ@google.com>
	 <2df88806-4583-4bf8-b699-43eb6217399b@intel.com>
	 <arHB1SACk4Z9kJq3@google.com>
	 <07297a47-9dc8-4e46-bb5f-fb228ba6447f@intel.com>
	 <DS4PPFA84FA90FC58F88D79B0EF19B34596E7832@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
 <ede520b24753e086dcfe73f11bb93cca7b6e5ad7.camel@intel.com>
In-Reply-To: <ede520b24753e086dcfe73f11bb93cca7b6e5ad7.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFA84FA90FC:EE_|MW4PR11MB8289:EE_
x-ms-office365-filtering-correlation-id: 4b2e501c-3491-4f36-b1f3-08df194fb0ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: cCMAvbu2lAPeygrWC1cxXlPVZidBWt6S09gN6AmAD4ogk5MW8EdShmFS7MPxS4YXWBiVkZ3NEjucdyNqOO04hFxn7uZlaCveVp6+k8xEfyHLH6jKtkvM6Q0/wHLDdmN0wAEbkK8HUKLUS6AW4GsLVU8qcJafR8mFwIISCF7QgnFaI4U/sW82qJVEd4zgti0zQYXk1FdT2HGZhl04XxZ0bBJc114w0tN2TR9AAoCZZDATdwzNkBRTShTbGfVwNt4k9OmAWpxUcuIlwbZdqBHKHcLCTlh4xGmyHiTOXxViLhIBUa7AinIWoFoFfoi9/CupQXroC6ophKo7SIk1N4dWZBXqZ+jIa+89bCubkdM5JefLh+hBp+MqQzN7nI7ncv2q4sJODFDJRlGRaVblNCIDFu22oAN/wQnGMLIjd0k49beBPdRZW2TsZgdtHGulz0CSpABQTdpxYDcHeoXPGKlwzeisDdoS28+C8zxafy4hyOtfJUSb7u9IO48y8+P7Au8uHJ96aDZV7JD68LCGqWrSaz3/sP4I+y5vcJwHsOIo66zISako3gaFFdExf1iYPZQGYwlnKZfhHVJTY6Ne94SA7OraX0oPVF0jEFhH2fLRvk5Q+2F9FcHgCHWAxmH/9dIO/hUFNH1yt69mgyvHQN4UrbPeBOeQaUaxRnjsLyPgJzG5hvKCpcBTUHA6r9cRA2TluRUHphi/seBrAsXWaZX+UxqFMNowp44h+DdM48/qHoY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFA84FA90FC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE1Gb1MzY1czVDdKNysxY01nM3grZnNjT2NIVm5qNUZaRUZLcHp5a1JKV1Bw?=
 =?utf-8?B?U3pSQUR6bTNDOGxldkR3WVUwTVUybitzQlN3dFVCdnU0OWF6MytsUUlRd0x0?=
 =?utf-8?B?bU9TREpSaitxY3NDTUtYQUZka0dtSjhXMmhMQjU3SEhIRm1pbGhCUkNzSm95?=
 =?utf-8?B?OWZrUE9sRE5Nb3RGQWlMdGlXZWVWZjloVWI2cllzdG1XTHhJRWhoM3dIVUlB?=
 =?utf-8?B?KzAwQTlMOXpacDR3aitNMWlWcGlVd3RObmxQT3ViTkFGUEJrRTVCOTdmOTgy?=
 =?utf-8?B?MW9vQjFoMVdDNHhudkVKMmZtcVhYUFpxZ00xaERMZ0pxTERCa0xIbDVJdG5K?=
 =?utf-8?B?U0duVnhQYUp1QXJBL1p3dzdYdlFiaytLZ2JGT1BLc2VCWXdjOC96dW1qK0tx?=
 =?utf-8?B?YnpGNXdkMFBEVEJZMUovNUp1OWRwTzg0ZTZ6bkEyRzFteXh2MGlXNXJqVmFa?=
 =?utf-8?B?b1RxT00yOFBwTG1zeUhpbUFacVZlYjhLNkNkV0MxNE91eitEVjIyZVo1eEFx?=
 =?utf-8?B?K2FNU2ZDRUJYTUcvbGVUWTdhS1o1OFBMaDZYeURaVmRPeW95TCtPMUJ2TXBx?=
 =?utf-8?B?YnkwN0lZWFpwWkV2U2lmWmY5WFJnTGc2VnJJNTdtWjVkcFUxeWMwN3I5Yk01?=
 =?utf-8?B?Y2ZaQ2VmbllDTDlmKytlYUhqc0p1cnJvVmhMZUF0Mm9NZnByTm91SnBUYit1?=
 =?utf-8?B?Zk9HZTRaUFppR3FjQVhUK0lqTWJWSkFHTWx0bEh6cU9QVlExRTBpZmF6T2Fx?=
 =?utf-8?B?OG9JRTBxWXBGMTZ5VUJQMm1mcTJ6a1RJa21melBIWFU3aWlxSVdCM3JKdlhQ?=
 =?utf-8?B?SzVVSWlhVDM1WThjeU9oYkFZUEJPVzlmbWZLQm1HNytoTW0xcEFNS3FaNFhT?=
 =?utf-8?B?Qnp0QTZFYUJjRTJ3RzJKaThMVGROL0NraUQycHFmYXNHUkxEWU93cWgzbzBy?=
 =?utf-8?B?MEFHWTBrVkxpa2RaQnI1bDhCczBIUFJVL0w0bzJwcXNob3k2K216bXpaSjNY?=
 =?utf-8?B?SDlwYktLT2FqdFVBWC81SVFrTGRzWmUvQUFaeFlKQnUvalRHTXM1Z0N0V25T?=
 =?utf-8?B?UUZ5Q1p6alZDNytrWkhiSUREZHlSU1BTMjZXdHZjMHZXMW95cnhhdWpjTXRt?=
 =?utf-8?B?ODRPM1RsSUdhSWJtSFVyQ1JEclF6bVJpT3p2aU1lSDZybE90MDU1dk5abEpi?=
 =?utf-8?B?V0xCcXgveEdMbnFRM1Fuc25reDZUa1lmMXZXczdwN0M1aWMvUWZlL0pzTDhp?=
 =?utf-8?B?TFh2RDJXbXc2d1lVaXhLbUg5SlF5R2dzVDhGeHJFNTcrK1Nvd2U5N2NoUTNT?=
 =?utf-8?B?RHp3SHBsU2xZNnpmemhJWUNKQW1tR1I5TkI0MjdjeERhMEZja2dDZFZWdXZV?=
 =?utf-8?B?Sk1INlFCejFhSzhoSTUwbmRuVkZ0VkdwbUlXbVloamJSTFdHT1JSQnJ3emtE?=
 =?utf-8?B?Q1YxTVJmWXc4aTAyWDVNeGRUUnVldDlBWjNTWG5paHpIUFhKWDg5S0VJWkJj?=
 =?utf-8?B?cFhCSkgzelZEb3QyNEpHQnlaaFBPcXlKOVJnK2RnZFd3UVdjWW1DM1NpZkUx?=
 =?utf-8?B?Z1ZoRm5mZTVWRS9sdjg1RWdXbzNxWVdDb3JEQU5yYlg0ekZJK2FObXRTbGxS?=
 =?utf-8?B?S1hOQlhLTFFzZjdhU2Nia0RxdXNmSU82dno5b0M5SjZNMFAySmpLVlJ6NU5C?=
 =?utf-8?B?TnJOVjRocTJVUzg4azIxTUZpSFo2VjVwUlo3WDArcVhPVlR0Zm9qaTMrN3l6?=
 =?utf-8?B?TzMrbGhyWldMRlhLeUZaZk45U3I3R0ViellDVHBTeHpPNGk1VWU4RUJpVHpk?=
 =?utf-8?B?VldXVjJYU204Yzg5M1Ara0pDSTdmL3ltY2xmSlVtVE53WmJEdDJNYnNmemRn?=
 =?utf-8?B?QW1KRkdvNXlpVjdBK3FzK0RDSmhpSmwybGFJSUVHY2txN2I3dERsM3E0UFF4?=
 =?utf-8?B?WkdFbzhYYW9ZWjNMZkVFdmNXdFgyUEZpSG53alNMWFJZK1FiaWdEKzNoMFEz?=
 =?utf-8?B?OCs5Z3dHd2VTNHUwcGptSEFVTHIyalZUa3p5VTVlK05wU2ZoVDNMdS9GUGIr?=
 =?utf-8?B?WEdDYjRFeWE5dVBvTWJyNjkwYUxvc2VPUlkySzA2cnJrWHRyeVd5ckx5Nmcz?=
 =?utf-8?B?MnErK2lBQWs3VTExQzB6eE9rbGRrRGFZaGh2OFh1QnJnRzRzWVhDamF6SXJN?=
 =?utf-8?B?NXd3MThhMXEzb3d5eUkvMUpTTGlXVUZzb1JKa2Y4cnFaRCtOWXo3cm9ra3BR?=
 =?utf-8?B?VVJZM0ZjWWZCeWRlZ1I5TE0vOEdqWnJtSWNhTlBWWEN4elBrU0d2bGR3SGpu?=
 =?utf-8?B?blhtczFhSW9UR0tOM3BvR0JvYVBSa3ltM05TUWVsT2psdmxUS3V1UWNGUHFi?=
 =?utf-8?Q?vWyLRdXzIADW/UwPuztDRQ8FdP1VE843n9olno9DtJWVE?=
x-ms-exchange-antispam-messagedata-1: TGot5QcFIHjb3g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lhMQo7Z4ailRxHPYGrz4i/sxKWIocCvik2j8GP7xxaHKHsJPtHnQC+wC4JWwzNmnMl5mdOC+tixIL+af0AyCPL1ny/2sTaD5axurFKEq9tHOpTJwiaFIHTuf92849goyyJZJGKjUf2sFudmyMFfajTqUkMMOMCXkdAQ86Mp1WMzfDklbiaEeAwOyfiNYMX60rjMA/0WyF/cq9mzwCg5tF3jYO87lcB0FTEYOn39b6ClyPFS5mGqnYQgLyFsnscC9Fl/952s8DV0jVwcUVUhO9MviwAEBd2OfKHwNMScjV9U6d1peo4xhQ8WMAzUfLd9L/Kx8AjgIudoB2T1oPox/NA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFA84FA90FC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2e501c-3491-4f36-b1f3-08df194fb0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 08:50:17.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8awRq0zJ8tvM0Bt9SA1mcL6y+b5CogBMHs1H2WUjtE8lSDKo3qYdoqCLZp1AZQq4ufcsscXT05FgX1QMDGuZOfIqAx9kS9VHj4++QP9Y7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8289
X-OriginatorOrg: intel.com

DQo+IE9uIFR1ZSwgMjAyNi0wOS0yMiBhdCAwNjo0OCArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYSB3
cm90ZToNCj4gPiBIb3BlIHRoaXMgY2xhcmlmaWVzIGhvdyB0byBjYWxjdWxhdGUgbWVtb3J5IGlt
cGFjdC4NCj4gDQo+IFNlYW4gaXMgc3VnZ2VzdGluZyB0byBoYXZlIHNvbWUgc2F2ZSBzdGF0ZSBh
cmVhIHBlci1URCBzdWNoIHRoYXQgZWFjaCBURCBjYW4NCj4gZ2V0DQo+IGEgcXVvdGUgd2l0aG91
dCBpbnRlcmZlcmluZyB3aXRoIHRoZSBvdGhlci4gSSB0aGluayB0aGlzIGlzIHNheWluZyBpbnNp
ZGUgVERYDQo+IG1vZHVsZSB5b3UgbmVlZCBhICJ2Q1BVIiBhbmQgYSAic2Vzc2lvbiIsIGF0IHdo
aWNoIHBvaW50IHlvdSBjYW4gZXhlY3V0ZQ0KPiBpbmRlcGVuZGVudGx5IGZyb20gdGhlIG90aGVy
IHF1b3Rlcy4gVG9nZXRoZXIgdGhhdCB3b3VsZCB0YWtlOg0KPiANCj4gMiArIDIgKyA2ID0gOCBw
YWdlcyA9IDQwS0I/DQoNCkNvcnJlY3QgZm9yIHRoZSBjdXJyZW50IFF1b3RpbmcgU2VydmljZS4N
Cj4gDQo+IChCVFcgbm90IGZvbGxvd2luZyB0aGUgIiogMiArIDIiIGJpdCwgaG93IGRvZXMgdGhh
dCBzcXVhcmUgd2l0aCAiUXVvdGluZw0KPiBTZXJ2aWNlDQo+IGlzIGx1Y2tpbHkgdGhlIG9uZSB0
aGF0IG5lZWRzIHZlcnkgbGl0dGxlLCBidXQgaXQgZG9lcyBjb25zdW1lIGEgc2luZ2xlIDRLQg0K
PiBwYWdlIj8pDQoNCk11bHRpcGxpY2F0aW9uIGJ5IDIgY3VycmVudGx5IGNvbWVzIGZyb20gaW50
ZXJuYWwgaW1wbGVtZW50YXRpb24gaW5zaWRlIFREWA0KTW9kdWxlIHdoZXJlIGl0IGtlZXBzIHR3
byBjb3BpZXMgb2Ygc2Vzc2lvbiBzdGF0ZTogYWN0aXZlIGFuZCBzYXZlZCBhbmQgcXVpY2tseQ0K
ZmxpcHMgb25lIHRvIGFub3RoZXIgd2hlbiBURFggTW9kdWxlIGV4dGVuc2lvbiAoUXVvdGluZyBz
ZXJ2aWNlIGluIHRoaXMgY2FzZSkNCmZpbmlzaGVzIHdvcmtpbmcgb24gYSBzZXNzaW9uIHN0YXRl
LiBJdCBpcyBnZW5lcmljIG9wdGltaXphdGlvbiBtYWlubHkgdGFyZ2V0ZWQNCmZvciBURFggTW9k
dWxlIGV4dGVuc2lvbnMgdGhhdCBrZWVwIGJpZ2dlciBzdGF0ZSB0byBhdm9pZCBjb3B5aW5nIHRo
aXMgc3RhdGUuDQoNCkEgZml4ZWQgYWRkaXRpb24gYnkgMiBjb21lcyBmcm9tIHRoZSAyIHBhZ2Vz
IHRoYXQgYXJlIHJlcXVpcmVkIHRvIHN0b3JlIHBhZ2luZw0Kc3RydWN0dXJlcyB0byBtYXAgYWN0
aXZlIGFuZCBzYXZlZCBzZXNzaW9uIHN0YXRlIGludG8gUXVvdGluZyBTZXJ2aWNlIGV4dGVuc2lv
bg0Kd2hlbiBpdCBleGVjdXRlcy4NCg0KPiANCj4gQW5kIHRoZW4gdGhlIHF1b3RpbmcgVEQgaXRz
ZWxmIGNvdWxkIGJlLCBJJ2QgZ3Vlc3MgYXQgbGVhc3QgaW4gdGhlIE1CIHJhbmdlPw0KDQpZZXMu
IEFnYWluLCB0aGUgc2l6ZSB3aWxsIGluY3JlYXNlIHdpdGggaW50cm9kdWN0aW9uIG9mIFBRQywg
YnV0IHN0aWxsIGluIHRoaXMgcmFuZ2UuDQo=
