Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77635AC03;
	Tue, 14 Jul 2026 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069026; cv=fail; b=uotcCIhTOjSWmmmyQKpTwkuJmXweMWmYswPKEfXfZBZcP5KzMtvEdQ6Kjw3A/JaLv+4qIzoRgRN1irDHtM3rutx3Wzy3sbrhmZ1sENkT1rxP8tn5ltYiHS1QumX9B6lKZgzR8DZCkUf1b8GUZvav9sgFakPGwgtaS3AvBfNUcIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069026; c=relaxed/simple;
	bh=WSjBGs6s/eIVkhnJ8iHEVwiwg/2MQ4TMqGLms5CzBDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShdUmBGSMyE+VJorm9wmnCLLdQaW8FKgcgiwyFMcobiRiHVR31+NkwBEyfiCod1YDtSEOj0WMRQjUrDlBuhSV+iLeU/BkABYEVrAWotJ6azVJz/A8BZTWfXzKq9z6LMxVIBTvc5u5tOM0lxep0hcOqF4ikZNQqgCFZD54hjdN5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKYq85Lc; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKYq85Lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784069021; x=1815605021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WSjBGs6s/eIVkhnJ8iHEVwiwg/2MQ4TMqGLms5CzBDg=;
  b=GKYq85LcGtrCoyl5zs8oKdiQKdKIVTyTivDH3OQiU72VvaCHpF2Ogm+E
   J0+ruMT3y1rk0M9+DurBXXcJw81G1i4p8QodyFzbCH446uiQjFNQ55m4p
   r6Ju7OQTIcfKU5QdOVVzoWfMgHVuuAsDbRDnSgC77My3bXi6QrDTO72/F
   L6ImPHV5tQEZAVrrSFYvrXXBbCja18WtuT3r++es/t2tHNB34tqqU18bs
   bh+7VadmGo/PzG5QfKyGFikgUdIzQtpNvXkDJNdfTI/BqxozTKCn3ZGdg
   2Ypm1Q1OQRPQofe5ewoWJbps19sKQYnwZFNF/g1oGAhubvgeDecoLKX3n
   A==;
X-CSE-ConnectionGUID: B0AIWIH+SCyP4BnepA496g==
X-CSE-MsgGUID: HZ4LQvE9QuW/b7mCKR0+Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96212330"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="96212330"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 15:43:41 -0700
X-CSE-ConnectionGUID: bFvWBFKZQna7wQfu4bjYuA==
X-CSE-MsgGUID: dFnRVuesRx2OlWo74YjzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252602741"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 15:43:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 15:43:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 15:43:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 15:43:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+TiVIpkT53TxTqHEYrZskfkfIcFupYkvfY/TmhmHrCRpVOg8ZV7kyhTR3rvatuutYePy+yeIbEGGr0dy0bLdj8azNKhvRK3Vi5G4fn/c8dbryzJp/xQEJ/xgjiAs4l7+FeBsaHbjWWxNQjYU9U13wOiJLiKhrjdtOTeYxFnot485gzpIP5oPvKlL66si89SgXDXQEk5LpHjLmAze6cvhUvQHLC3H28OHdQOuqPSCekUceqMI6vPuBzzUOIdkpucAKuu4BSacUA0poPYXMyt4Z3zMxXZuhh4xX4wqwWVkgoRvMYzZ0UtP0GEY0dz+UL3S4/2Dui/+/vHGj+cwKrywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSjBGs6s/eIVkhnJ8iHEVwiwg/2MQ4TMqGLms5CzBDg=;
 b=B+e4Lr26cuxfOeDrwmbGeBQdAKbhJ1IbXl22ijefoq2euRIhbwTW2Gs4VkU+kFZtodsb01JjMjjHhtw6zeA4JU+lBBshzVt0H4V/QNVdbAmgABC4x3Wnm1cl4uWCLUO9BKtYZit6q5RoA+d8PMoYFUEHly0ZCcP5gwCWi0Y6ThsLw3+VSZNDwy2ummRh7Nf86GqpPv0bCqVxBWQriSMyXJCFvmixUbcDFGCpXgoWRE32yc0QWFl9L67cRlyHkR0UEBlFgelDJfVpG2WdMGBseKCpo408cVefnukZ5yU84UiCyVtnllJIwIzi1mDp8ORoCGCOYup2lC1zeFrYfY2csA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN0PR11MB5710.namprd11.prod.outlook.com (2603:10b6:408:14a::15)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 22:43:36 +0000
Received: from BN0PR11MB5710.namprd11.prod.outlook.com
 ([fe80::bbfb:d81a:573b:1d5a]) by BN0PR11MB5710.namprd11.prod.outlook.com
 ([fe80::bbfb:d81a:573b:1d5a%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 22:43:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] KVM: x86: Convert nested ops to static calls
Thread-Topic: [PATCH v2 0/3] KVM: x86: Convert nested ops to static calls
Thread-Index: AQHdCM+Bk1H1yCIDs0KbhH6JEgL/b7ZtbyKAgABDpIA=
Date: Tue, 14 Jul 2026 22:43:36 +0000
Message-ID: <9e79d662c4e2c2e595c776c8fa929ddf89d46fd0.camel@intel.com>
References: <20260630202828.440724-1-seanjc@google.com>
	 <178405258631.3111985.13515439003620338114.b4-ty@google.com>
In-Reply-To: <178405258631.3111985.13515439003620338114.b4-ty@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR11MB5710:EE_|PH0PR11MB4822:EE_
x-ms-office365-filtering-correlation-id: 5068b23d-842a-462d-883a-08dee1f957a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: WanBkiTz2eiJZhj6M4vusG70MHj/cKSRxopTqHtu+dApoAT9jnOvQJvyXvT4PbOHqVE+4WQgtZlmGy5/t9JePpiH6k+692JITzl/qZOt2hryYWTrSKVKR2QamnQuI/jQxNP2e1Id9M+1G7sd5H7tHYE2vZQkJIT+AXxcBoUOpEsGUXgpV2C1AmIl72xjJLm9/zt7guDb+PHsEPiUpxCT/Jq19+g1Lhbbak3owhttzBB1cE9b5lxGG2idV+vMpMayERn+pSmOJud4f1HU9jxZutCqg9L9did9aFYbnbrAT62o0ed7EDA48WPxNK9hL3A3HUy708TGXNZq4u7n3pcKGToUfmHJLxhIhY4d5DnYQQHqWxVa4wFNIt/peIDrNtw5Ppt7UkNskWIoG8XwIQPEEWR+0RbjJCGKpBJfWdtZUSqRYSynLScWgmC53qVLjmng79KUCyPsPn6SkMViSJc5vPeeMSuNoNiPaGY+H47mMaZ9P2MrzuBVWKPynd+4RNtb4oTEuY5Lbflvr3NxgehdkDvRbbGMGaStfSu0yCFWWvMNHfZfuijCsMgHoFChknfsqxcR3xsvq0DsFtoXqr39/vkIMNIeJB245JKzfJv8kKGrRfWonjXzBA7zSwyWFv+k8hoD+X4ZWig2LpdzzbrJET+O791Wu4zB9opV71fCLXBdcA4q74jwboWmJliOOnXFJxs0QzOooRjiBXS+4xmiXnj52LfziHwE6hsWtzxUT8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5710.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MSt0UDhPRkVDZTFHby9PNG1QSkI5YUlVVHVtenZ0Qnd2clRjVGt2aVZobm5l?=
 =?utf-8?B?a2NOWUR1NTNabFQ5NFpLMnNGeFFzRFFXZ1Q5ampscGEwb1JadE1BQ1BuWk1R?=
 =?utf-8?B?c2RlOHFlS0xVaFo2QXI0SGhwR2w4WExOaHB3TmFzWUoza1dBUldaV2xxZ0lv?=
 =?utf-8?B?T0l2S2tYdTlJbWduRkhwcnpzZ3RmSTZCU0FmUkdiWG1BQ1R6VEwvb29qOUlx?=
 =?utf-8?B?OHZ2bGFzeHlPSk5ibnRCNjVOZUpNb2VNK2pNa2ROZjdKVEw0c21SMUJPSXdK?=
 =?utf-8?B?WHl6SWNPNFcxS3hlTExNTWRDdFR6TDdKOFVtdnlkRm9JUDZFaFFCVkpkckdx?=
 =?utf-8?B?OE0vSko3WUhqbEU2eDQvdDVXVHR1bEl6K0RQa2NQd0N0RXkxZW43VzY5V1du?=
 =?utf-8?B?S283SUl0UTg4NE9rRzRqTVNZUm5PU2NLRFEzUUxuU1FEV04wcGhsOGpMbmFw?=
 =?utf-8?B?YlRQV0hJcDhjZzdlSU5zZVhIN2gyUGp3QXFoMWlVdmhnWjJBS1BFN1gxVDJZ?=
 =?utf-8?B?eU0vM3JTSzlzWlBGeVY4a2lFa0tMeXdHa1YyWmZsazJyaWliV1kvNWF3TGlZ?=
 =?utf-8?B?RzF5bkg3K21KSEVqU3VaQ1lZL21WRWZJZndjQ0o2amFhZE1mM3pVeWErbnBD?=
 =?utf-8?B?a3hNaElGTDJBTFVrM3BqdTJFKy9TYnRVWkpuTTh1MkVabTZBVVBvcWMvRXR1?=
 =?utf-8?B?Z2Y0TGZqcm5uODBONUg1dkpPZDlxNWZqNjVQYVpXVkJ6dktSRDV3WEY3Z0pQ?=
 =?utf-8?B?S2d6ZWV1QUFnaWQxUDBKbjJqd3RPL0pmbXFUSURlOERYbXdDajUwcG9uYkZn?=
 =?utf-8?B?K0JZU0FnajRxdEEvMEp3Y0taVWRWL2NvRkpYNHcxZ0pZTUdGMkZiR2cvK3hB?=
 =?utf-8?B?bXpKQm5FdVVXKzRZaDduY2VNOVZLR01WVVM2RytwZXliMHZVNlBUNk5ZcHVv?=
 =?utf-8?B?eURIdkp3Z2dXMXdBQnhLVUZFVmcxcHdRb1lhaVNQTlc0SHRyR3FVWVorLzNQ?=
 =?utf-8?B?TklwSGFvK3ZaU1psS0xITEJ6eVZPQ0dseGxndzJKNjhkUDZZMGJocHQ1NkdF?=
 =?utf-8?B?SStCUmpPN2g5Q1IwZTFUWVBmZTR4QkZpK0dXcHBIY0Rnbi94bWlvNWV2NjE4?=
 =?utf-8?B?c2M4TUNsQ2hBbVVpWFcwSmVMdkNndndDdktRMnU3eXJiQXVEK3ZZWDJNZEx3?=
 =?utf-8?B?STRENysxd0k1bm5kd1hVeEVUZzhzSzZkMVpra0psUmRwRHR3U3lNYVFwVnpB?=
 =?utf-8?B?UFlSVWUxZ2xUMllXYnROV1dhK3Q3QlNnNlh5YkZNWURCaC9wNmZDald5cVJp?=
 =?utf-8?B?Vzk5UVh2L2JIT2c2L3BWMUhtVXRnK1Yydi9sZWQ3L3JGSjdJTW44czZwMUUx?=
 =?utf-8?B?dFRRZzZBTFR3MExDMTh5YU1uTW11NWZrRVIydkNOQjhtUlRMMTE5UU9EZHN0?=
 =?utf-8?B?ZGJiYmh0YmhqSUJVMUl0b2g5UTAyVXg5NStQU2N3NWRCRmowcDIzVjBsTktY?=
 =?utf-8?B?OVJkeStpTmRFSEwwenFGRHF1ck1ZdUlaWW1oT3d4WHJ3SExSN0s3ZXNrNzM3?=
 =?utf-8?B?QjZGNkVDWEhHYThMSjBwbmlneDBla0RvcXdzdmtLaUViaHNvZEY3a2xaQXY4?=
 =?utf-8?B?QncrbURKRTFzOUQ5WUdnd2JBN3k0VFpGSzhBeGlxMzdWUUpQYTNqbGtlbEdY?=
 =?utf-8?B?ZDQ2QUpmK3JJQjVIL001a1VHR283bVJvbjBkSVI1S0NLWFV2djNKVUtRazNZ?=
 =?utf-8?B?Y1AvSitTV2lqUUF6VGJnUXFyNDlHY2RkdHFkMStrU1RnMk5lQUdlbHhzb0pI?=
 =?utf-8?B?R2lHcmxxNzJWMjB5V3RNZm5MUHIyTmkwYldjdUFXMEd0Z0ZhNHYwUGlranQ5?=
 =?utf-8?B?VWtZb0pwTnN0WlZkNE1uT1ZIN1VIa1BhSExYb20vczQvZExOR0NheHVBeUNI?=
 =?utf-8?B?a3dDSlFPWUoxeFprTU9VM2g1S2hqdW9oZVVnaFI1K1VjQ0E3dk5tdVR5MGQz?=
 =?utf-8?B?ZVFEUC94WFBCRkdyQ09YRXlibXB5NTJzcmVEa3Z3eGpHTDIvQ05sYmhsb0E2?=
 =?utf-8?B?UWR1N2dXZkl2RDlKVzRZOXRyUUtpSndhaWtRMFdLUjNsSFNYL0JaaGIxOFFw?=
 =?utf-8?B?OUQyNW4zOFdxaFdUSFRUMVhJSjFWckZBVzhTK0NtL0FWbEthdWJVa3JPSmZN?=
 =?utf-8?B?QkQxZ2hyYkpIY1ZiaXd5VXdFSVRpU3lXRVRHYkVWbVNBNTg1SFVkclh0YkYv?=
 =?utf-8?B?T1FJL3JLd29FcW41MkxpR3BtdXExNEZHck1WaTU3K3hCdjNEQXNFK2hjTWRN?=
 =?utf-8?B?dDVDb0tXb1FBamZ0ZmhkUzl2QkU0cldPZWU2QXV6ZXVHVTdIOVlvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <483E247CD5F9C244ACD358920CD00EA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pzACy7S8b6grJP2H4hX5WDttQ2ll6eD+N3YddQR8CdMtRmKDqqgn9ebF/SS+V+It5UsohOWR0nuHIVbFh9IWiGiEAWApaihwpbFFXeyr11sUfcSNUA7Iw90/RJefHyWiBfy4zP4ngMHxpTJQZz56zkaGzk8DA2YEmm0Gg+vpIh9YQDw71/XLh6Yq7xOVRFhCCyeJcnLaxWjrDHmw52lKlyU0H7IbjEaLJP1C8jNkvDeXLYvRnuFV0vWsGC6kvPLJTY8t1E9stWbmi4QjV95rLAS4BOVUixBIH0OLbCmQhstLK2LOPXPzwfRAROjb3AlZ+UXWuByxbXWw4kCTD8rIKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5710.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5068b23d-842a-462d-883a-08dee1f957a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 22:43:36.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tjmg9/QPK+UjAgQwfpuw9JreFbyszU/KQdkmzRAyCvHYprJx+LhrH3VyeElR00AzU129ZV5lM3Cl7DEmfnuXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDExOjQxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIDMwIEp1biAyMDI2IDEzOjI4OjI1IC0wNzAwLCBTZWFuIENocmlzdG9w
aGVyc29uIHdyb3RlOg0KPiA+IENvbnZlcnQgbmVzdGVkX29wcyB0byB1c2Ugc3RhdGljIGNhbGxz
LCBtYWlubHkgYmVjYXVzZSB0aGUgbmVzdGVkIG9wcyBhcmUNCj4gPiBiaXphcnJlbHkgZGlmZmVy
ZW50IHRoYW4gdGhlIHg4NiBhbmQgUE1VIG9wcywgYW5kIHRoZSBrdm1feDg2X29wcy5uZXN0ZWRf
b3BzLT4NCj4gPiBjb2RlIGlzIGFuIGV5ZXNvcmUgKElNTykuICBJIGhhdmVuJ3QgYm90aGVyZWQg
dG8gZG8gYW55IHBlcmZvcm1hbmNlIHRlc3RpbmcuDQo+ID4gDQo+ID4gdjI6IEluIHBhdGNoIDEs
IGtlZXAgdGhlIGdldF9ldm1jc192ZXJzaW9uICE9IE5VTEwgY2hlY2sgaW4ga3ZtX2dldF9odl9j
cHVpZCgpLA0KPiA+ICAgICB0aGVuIGNvbnZlcnQgaXQgdG8gYSBSRVQwIGNhbGwgaW4gcGF0Y2gg
Mi4gW1Nhc2hpa29dDQo+ID4gDQo+ID4gWy4uLl0NCj4gDQo+IEFwcGxpZWQgdG8ga3ZtLXg4NiBt
aXNjLCB0aGFua3MhDQo+IA0KPiBbMS8zXSBLVk06IHg4NjogUmVqZWN0IG5lc3RlZCBDQVAgZW5h
YmxlbWVudCBpZiBuZXN0ZWQgdmlydHVhbGl6YXRpb24gaXMgZGlzYWJsZWQNCj4gICAgICAgaHR0
cHM6Ly9naXRodWIuY29tL2t2bS14ODYvbGludXgvY29tbWl0L2I2NTY5OWJlMmM2MA0KPiBbMi8z
XSBLVk06IHg4NjogQWRkIHN0YXRpYyBjYWxscyBmb3IgbmVzdGVkIHZpcnR1YWxpemF0aW9uIG9w
cw0KPiAgICAgICBodHRwczovL2dpdGh1Yi5jb20va3ZtLXg4Ni9saW51eC9jb21taXQvNGI5ODE5
YTUwNjc0DQo+IFszLzNdIEtWTTogeDg2OiBNb3ZlIG5lc3RlZF9vcHMgb3V0IG9mIGt2bV94ODZf
b3BzLCB0byBnbG9iYWwga3ZtX25lc3RlZF9vcHMNCj4gICAgICAgaHR0cHM6Ly9naXRodWIuY29t
L2t2bS14ODYvbGludXgvY29tbWl0LzJjNTY3ODBkOGVjNw0KPiANCg0KSSBzYXcgcGF0Y2ggMi8z
IGhhcyBubyB0YWdzIGZyb20gb3RoZXJzLg0KDQpGV0lXLCB0aGlzIHNlcmllcyBMR1RNOg0KDQpS
ZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
