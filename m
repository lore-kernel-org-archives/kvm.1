Received: from smarthost1.eviden.com (smarthost1.eviden.com [80.78.11.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323A3C3457
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963388; cv=fail; b=Kk3i/m1JzaRktq9e2rg1aPY3hh8IqXvAqfUVwXYYkimWHZb0R+YcXoGV1lOxjZxniHilCkUBDCRsxVxOOahQmy3X/UV0wRcT2N/MoGHFkf5FFl6pj2zGm/MJQQbfHn9C/MrssvjWtP6l6R4mZ80AsvoTQip7fM/FtGDAGLC/cLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963388; c=relaxed/simple;
	bh=DIZIN0M1treYV42aj/5koBYZ9Zu6JFDbo1eULiYg6qk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nULTR4r9BDpllFjAI7yE5n5/h8Hn/5xwVSr7YaCCOfWYLBxmJ/2WcUqQbdbxw65M2uyARxE53nVdAzmqV2kuYvwB94R293GHps18bmW7H5J71BurRoaMAG8R1Vir6eGFZEPXprJuLe09jYgmanxCYpVb+qagnoZc5F1A4DsBseQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=NqqgaVZl; arc=fail smtp.client-ip=80.78.11.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="NqqgaVZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1777963385; x=1809499385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DIZIN0M1treYV42aj/5koBYZ9Zu6JFDbo1eULiYg6qk=;
  b=NqqgaVZl1Ag573XHzkjmvNwYKGSVxJrOIgrDOIpJC4xP8YXI+FptTUA+
   Oc88uiFihLeXg6uxfBzcNItUWnV0M3zNqfzeIgIBwszrELFOJ+QbSD0GK
   j6OmgsK+P5uGID43rRGH9pM5f7QZaF95o0BoRXohirrigSNIhmOhMucv7
   VHCdNpzeh3kjVxocX/WFPTHNV5LzBU3A2qivB5kFiYEerYdB64/ETaBXv
   ZiwBs6SDFJ2HlVASX0p7AG4Yf5pZNS1EYYgpXmGxLiIlKkGYp8SbzXQQ/
   zi9fVu6WIPcfo+0Ow2c5rzvgyzKkqqXoXRNh0Z9MsjTgM6R5NUzc/IQf2
   A==;
X-CSE-ConnectionGUID: ydn9pTvoQg+gnEFiUXcspA==
X-CSE-MsgGUID: feUUJNiTRgCg3pLv96XXQw==
IronPort-SDR: 69f99040_VvHe8fwJ0gUEM88YzhGEU+V46aomi2UNDklqCBwbk3cJSC0
 QLLgBPSb94p5g5mWipJz+Zw05BmIi+7Zjet3ZIg==
X-IronPort-AV: E=Sophos;i="6.23,217,1770591600"; 
   d="scan'208";a="47863970"
X-MGA-submission: =?us-ascii?q?MDFJAPm5IQPTHvwgmKxmbuB86Fu9dTgkFIW6qi?=
 =?us-ascii?q?fs9Psd5cHbjKCC3+c3aFDhVXwwBj3T4jCZUs2Xg8M/x8uwRR+mJ/01j3?=
 =?us-ascii?q?3Zy27o7wx/eya+e4aTP9BlSEUvQqXCxYI03BxUqJIcRy5av7Dzq7Gt0p?=
 =?us-ascii?q?qSePcaBHArZlg7mr7opj988w=3D=3D?=
Received: from mail-francecentralazon11013016.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.16])
  by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 May 2026 08:37:51 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftsPoaOR/ZRI0TMaCMhy3prTDxazi3Jwe+vuaESPKunQq9CsB4XNhql+2lO3aKU1AEHKz2wwwjbjEfYtLNWlg/taLKFJmkjnpNL05h8uuTf8oyxy92CwrdO6PfxX3+2MAs5ws2vfUtVI2oMIGPvOa3m5iOJjLX7/7VN69x3P1B4wHJFZ/PCDdleAzL27I5sd7N1udbA5DnYE0ZfxB27d8irFn49ikts6WEfVajcQod5Dm9mhvV/L5nj5cttexvrv+5v4OOqKbdodqEExE0dQ5p3Uc8AAHNBKpOSvUn/usX2ZhAaP/JssMEmF1XVy3wqGl+MRD8fy1azafOSPQUiL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIZIN0M1treYV42aj/5koBYZ9Zu6JFDbo1eULiYg6qk=;
 b=aqz2VY3BJJfNRJYmPb2TMm4Tkiy2+f7s7/4MCFdNU0LlgmFbAa2DrVp2qtcyMqlQpJ8uLKjnWQR+GntE94TDIMdjhN+VzhcDe+dD4e+fieZV6II3W7SKqt9iQ4BP2B8/fhvE28rWUc3ID0R8glyG/5I6+C6nPtIqnWpov2YHHJb2t+egA/WCzlPC7KYBxBbNEaVZEnrX0mCPD6cF+dE5LU54YVci0ctBWQzO/iNbm2NnPSiQ+gqrqpelyR0KVZRiebhB/3tzkCiqR5OjE+bs6SkmggnTl+gxOPYQgZpofrRMzi9DS8qFjbFTPo+lUNy963FNWu1jn5DNPPWBg9o/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM9PR07MB7939.eurprd07.prod.outlook.com (2603:10a6:20b:30c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:37:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 06:37:47 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
	<clement.mathieu--drif@bull.com>
To: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
Subject: Re: intel_iommu unit test is also failing (was: Re: [PATCH
 kvm-unit-tests] realmode: load above stack)
Thread-Topic: intel_iommu unit test is also failing (was: Re: [PATCH
 kvm-unit-tests] realmode: load above stack)
Thread-Index: AQHc290Y7pkUzSSxRUCgUdo/bv9aJbX+7g6AgAANYwA=
Date: Tue, 5 May 2026 06:37:47 +0000
Message-ID: <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
References: <20240604143507.1041901-1-pbonzini@redhat.com>
		 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
		 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
		 <afi_HNJoObF10rwz@x1.local>
	 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
In-Reply-To: <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM9PR07MB7939:EE_
x-ms-office365-filtering-correlation-id: 17ac2091-1a1c-4ee9-011b-08deaa70d25f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|13003099007|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 1M6KM9HXETlDPs2zEXfln+mV1oFobFZhgwJn2C3tg9j2uAWgcq/M7/Tb7SeIsXw4vVh8LIgFUBUqgwDZBB8Fk2WXNBLb8MOK92tnjx9FzTsGhvm676fDmdTEIOSOqjf5WsKhcM7sAfJDBH+isxxAyo36r/wUvgBRLWOwl+W+7Q/CqiU5vEGZfvysc+HENe8M7VBR8B2TIuSXIjM2kYbc3hITJHsIHQ7VafvsaSiAckuQC2/xwhKvFsJAFu4OgaNYBm0rzlsMwtEPZyXwtt+MLNa6bML/lznwc2pILunZRq/jv8nDAyAps14bIgW2+1u3MNOoEZSnIlrj6Rpz0VJ9NUVZ4FhgbFAR/6L6QB3EXHTuya1+sF63Y2HiheqYdpMq7eDuCBPnoqRqvc3CERdxeDnqnrGjjgyIPT5qY9x0yHzYvl3n11d6JIRO9whF/yb3uGy/yWIsJ7uJbllccaCBFuNeKSCdfeFVcrBAl/A+T0PEp3YYnH27u9SiNBSsSKtaniLUjIaQUEDJLBsZ7SZtL88RP5BCiOK9SWnWuVXJM4wJ8ThRksWE5vjfxPdd85KRZ7NlbhZCMwlXI5cFfdtyfetWrjXy+d/HIf/6/8696veOPZ9IImXNseQcFChcQeg0IO88OrunxmczVPHYeksvQ5IkLQQt6a5DIpCWshNSy8hnaKmpIWxbyiD6knKLQxo2KI7AbFcDaervUk1gDL69gp9tE3JKyAY2tQVjye+bkvB4c9aaJGY7SMPmVJUiKDr9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7602.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzNvZzhNRndFRFA2U09KbS9kdUF1UDJremN0R0RqY2NHekNHaTcreGpQeTFp?=
 =?utf-8?B?TGlhZ3JNSG5kazUrTWlDaVRrYndqQ2RFTzJ6Qk9ERnhTTVV3N25vcVhiUThW?=
 =?utf-8?B?NURydnFRLzQ4elJJd2JucjBRQ1Y1dDU0TkdLdnZUTW1ndktqRkRLbUZTMWdL?=
 =?utf-8?B?RFh6NjdwY2dlZmU0ZXpYaENTcXc3ZzJiSWJEeEU0ZkRDa0JTNmlhUjRpclpm?=
 =?utf-8?B?N2dKQVJxOUNKUHlpeDZkOGFuTXJnUnBaL2VtQk92Vzhubzl2dThtb1dURXFZ?=
 =?utf-8?B?aWpkMjdRNHk1U0JKRkV1ZGwvRzB4L3R1MXhSKzhIem1OclR3MnpmMURNbCt2?=
 =?utf-8?B?b3BWa29zSWlreUN1RVFIZVp3TTVjU0oyQ1J1UHJXOC9QVEdIQ2gzUy9wSWVj?=
 =?utf-8?B?QnMzeCtEZzZPRW4xWVFkUFk3ajM1ajZCYm5XbHpkNE1TZ0IyMkQ0ZjNqZkhw?=
 =?utf-8?B?U1pHT3BHLzlrc0oyYVJnNUxDZU9DaTc0Z1RjOUdFejB1VTFKejdMMGJDWVJa?=
 =?utf-8?B?WXhSTlpXSHhsc0NVTFRmSVlhaHJnaTJPcTdxb21TWnpzSDJYVzVrYWpneG16?=
 =?utf-8?B?M0QwaUNUWHZIMzZ6c2NaYWtqTWFKcWk0UFNLRWJNdW5RY090MHcvdEtJTlI4?=
 =?utf-8?B?RVJPTWRyZnNuaUJvQkM4SWprTWdLbU5MOHdhSWdjTGxGZ2RwWFNkWmhnMkdW?=
 =?utf-8?B?MC9WajU2aXYvUDZJWndSUXdkRk5tWTZWWUV5NTR5eWRSNnU2UjRQWXhkUkdE?=
 =?utf-8?B?Qk40ZFNhMitqWG5QZzlMK0kyWWx1NDRqZnVXTVJ5RmQvdG51S2dRYUdxSE4w?=
 =?utf-8?B?dk1NOFhMS05FVkRhd3o5bytIRElxS0hQcEthanhuMWhOaHZCWEplK1hqZ1Fr?=
 =?utf-8?B?Zm1heEluK2E0UmNUUDV2OGNqcFpuSEZ2Q0JGdithRWxIQzBCY0xYS2FZK1hU?=
 =?utf-8?B?NDhtV3lRU0YrSWpnak9jd1ROWFVPczB1SVNGcXNjcjcvbmgvcG5VaTRqRVI2?=
 =?utf-8?B?Tm9uQmZJeTBzYVZjMVMzRVFqaEZzbTRkdm5lUS8zekZETkR3SC8wRzJWT3hY?=
 =?utf-8?B?NXF6ZFF2TERYd0l0ZWdHVHpSZTR4R1VmZEJ0Y2dVdFpwVGdFZ3pqSFI3Z2Rz?=
 =?utf-8?B?K0p1T1EybE54YlVMUWtkbDhLZXNzbDNTNlRXa0R4TGNuYnh5bWpabzdiZWM0?=
 =?utf-8?B?Q3prUTh0eFZ2NTVSVmM1dEZQNU0rSy9sZ2h3N21neTc3M1dDL1p0TjR6SkZ5?=
 =?utf-8?B?SHVvK2RCV3FXazNKam8wNko5WWt2OWZHUkdGWk53S2NvdkxrWmszaTRnWGNh?=
 =?utf-8?B?aE5iQ1NOeEc5L09jbVJ0Kzl1bVArUjJQTlZjeWhpdXFTMzZWK0tHZUczZlBX?=
 =?utf-8?B?bmh1enhvRnNYamtqWUZJWm4zeisxYi9JYTlWZ0kxems5RnNCU0Z6OVNuT0lZ?=
 =?utf-8?B?MlNnMjMycWc5c0NxR3I1VElDN3VjMVZDamRnR2hhVDdvbTV3aWhMVEszT3BZ?=
 =?utf-8?B?dEJMTUVZcG1DMmZrakI4c3FrRVhaUU5FbTBpM3BBUGhvUG44algyWWxxK2Vx?=
 =?utf-8?B?UHM3Q0V0T3V5TTZGbUpDR2JwRHplOGtrTTRkeDRtczhsSlRMSkFFWjdhS1ZT?=
 =?utf-8?B?MUtCUGZTTkw1ai9NV3RoT2Z1TjJ4VDljWkF5cTY1WWlMdHM1NjdCbnhlVkJI?=
 =?utf-8?B?b1VRN0NWUFVyUUM3QTllUlFXMzZrcXVRdy9vYmdzNUNRdEkwMkVranJvQzND?=
 =?utf-8?B?SGN1MU40WTMvUE03Y3hVOGNrelpFMnhFN2xTTGJyVTA1UzRFa2JuZyszL0tD?=
 =?utf-8?B?NUdGR1ZJWVhOWnMwUkRPcGxnOHNIVjQ0SEFvMUp4K0h1R2N5M3dJcE5zVEsx?=
 =?utf-8?B?TUgvbHR1QVZkLzhzaDlYS1NFS0J4MGM2N3ZtR3ZrQ0NlTXcyTEdIci9xelE0?=
 =?utf-8?B?U3pQMDlZbjNuekxOb3lFazlvSTBUa0tYR2VJZnJlT1gyZ1FwT3BPVzNUZW1Z?=
 =?utf-8?B?MzF1dVQwM0Q3RWsyUUJlZUM2elJBaFZla05mZXZ1Tk45akdRZThMSTFhMS9v?=
 =?utf-8?B?cUFzOXMxMHBOeVRTWTJGNk9OZmk4L1ZLaStWR24vd2EvTm55SFNYZ01ramlm?=
 =?utf-8?B?aWI3QzhYVmx0QkJvdFlvZk1YN0IwNTVpRGE0VytwN2tTSXBJLy85ZzhOeldL?=
 =?utf-8?B?VC8xd1U0QVI4bkpEQVk1UGk2SkZlUjZXY3orQnRzSXNMbitiNXFmV1BTak9P?=
 =?utf-8?B?ak9iSlFUS1lnT1FZWEdPOHVCZTRNNXdmVnQwSDZNNk5ZM1kwUXNnUmNzWi8x?=
 =?utf-8?B?ekF2aHlWcW5OYmZlMDMxQWsrOHJUSy9zQjBabVdDWUkwY3R4TjZTZHN4Mk4w?=
 =?utf-8?Q?QV58VTey5dmyseJ6XmrA7gp2ik3/R0qy85sFI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA88F5D716B4C240922F917AEBED7DA0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Y2Aazcn+9Dtr9o+hkb1tTuYjdarB/Dt5jddDfEsLfkqkj7Zv6ojp5Ke4PUHKNUFrQjC7QP35aqStDV7gyOChaHyPSm58OJiJaawyvnWpIzUTvVJLbFU73qWd/EgbAHzeJhyIMUxLokqbCbjvo6JBqNW20eTKbPYjlbbPJHPlbrURae0anDe5JyrmrQTJZTDAPy8m1lxEuJcUD3SoYslMg2/8K5PUM3GjZQNyrL1K61gUpGxrQGjaWdlcxXp57bs/fPew1tQYmm/R3HKSlHsR9CpvfwjikEHFMlJUCq3hJuGXot6HVvuz4iVijHoP0nj7DH/PH3GmgFaQ2M7wa0tatQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ac2091-1a1c-4ee9-011b-08deaa70d25f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 06:37:47.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+mBnvOFBTXQY3JcdoFk4igNXg3ZnAeQ6ixkvhYjcjhi2WXPnfLLLmU3uGPKcqqCfF7Nr5a3wAbA07UHPcYQRCjIYhWFx75wb6iuRTZPZ7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7939

SSB3aWxsIHRyeSB0byBpbnZlc3RpZ2F0ZSB0b2RheSwgaXQgc2VlbXMgdGhhdCB0aGUgaG9zdCBk
b2VzIG5vdCB3YWl0IGZvciB0aGUgZG1hIG9wZXJhdGlvbiB0byBjb21wbGV0ZSBiZWZvcmUgcmVh
ZGluZyBiYWNrLg0KDQprZWVwIHlvdSBwb3N0ZWQNCg0KY21kDQoNCk9uIFR1ZSwgMjAyNi0wNS0w
NSBhdCAwNzo0OSArMDIwMCwgQ2xlbWVudCBNYXRoaWV1LS1EcmlmIHdyb3RlOg0KPiBIaSwNCj4N
Cj4gSW5kZWVkLCBpdCBzZWVtcyB0byBzdGFydCBmYWlsaW5nIHdoZW4gc3dpdGNoaW5nIHRvIGdj
YyAxNi4xLg0KPg0KPiBnY2MgMTUuMi4xIC0gUWVtdSAxMSA9PiBwYXNzDQo+IGdjYyAxNi4xIC0g
UWVtdSAxMSA9PiBmYWlsDQo+DQo+IE9uIE1vbiwgMjAyNi0wNS0wNCBhdCAxMTo0NSAtMDQwMCwg
UGV0ZXIgWHUgd3JvdGU6DQo+DQo+ID4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBv
cGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBm
cm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiA+
DQo+ID4NCj4gPiBPbiBNb24sIE1heSAwNCwgMjAyNiBhdCAxMDowNzoyNUFNICswMjAwLCBUaG9t
YXMgSHV0aCB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiBPbiAwNC8wNS8yMDI2IDA5LjU4LCBUaG9t
YXMgSHV0aCB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gPiBPbiAwNC8wNi8yMDI0IDE2LjM1
LCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBi
b3R0b20gMzJLIG9mIG1lbW9yeSBhcmUgZ2VuZXJhbGx5IHJlc2VydmVkIGZvciB1c2UgYnkgdGhl
IEJJT1M7DQo+ID4gPiA+ID4gZm9yIGV4YW1wbGUsIHRyYWRpdGlvbmFsbHkgdGhlIGJvb3QgbG9h
ZGVyIGlzIHBsYWNlZCBhdCAweDdDMDAgYW5kDQo+ID4gPiA+ID4gdGhlIHN0YWNrIGdyb3dzIGJl
bG93IHRoYXQgYWRkcmVzcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEl0IHR1cm5zIG91dCB0aGF0
IHdpdGggc29tZSB2ZXJzaW9ucyBvZiBjbGFuZywgcmVhbG1vZGUuZmxhdCBoYXMNCj4gPiA+ID4g
PiBiZWNvbWUgYmlnIGVub3VnaCB0aGF0IGl0IG92ZXJsYXBzIHRoZSBzdGFjayB1c2VkIGJ5IHRo
ZSBtdWx0aWJvb3QNCj4gPiA+ID4gPiBvcHRpb24gUk9NIGxvYWRlci4gIFRoZSByZXN1bHQgaXMg
dGhhdCBhIGNvdXBsZSBpbnN0cnVjdGlvbnMgYXJlDQo+ID4gPiA+ID4gb3ZlcndyaXR0ZW4uICBU
eXBpY2FsbHkgb25lIG9yIHR3byB0ZXN0cyBmYWlsIGFuZCB0aGF0J3MgaXQuLi4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IE1vdmUgdGhlIGNvZGUgYWJvdmUgdGhlIGZvcmJpZGRlbiByZWdpb24sIGlu
IHJlYWwgOTBzIHN0eWxlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUmVwb3J0ZWQtYnk6IFRob21h
cyBIdXRoIDxbW3RodXRoQHJlZGhhdC5jb21dKG1haWx0bzp0aHV0aEByZWRoYXQuY29tKV0obWFp
bHRvOlt0aHV0aEByZWRoYXQuY29tXShtYWlsdG86dGh1dGhAcmVkaGF0LmNvbSkpPg0KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgPFtbcGJvbnppbmlAcmVkaGF0LmNvbV0o
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb20pXShtYWlsdG86W3Bib256aW5pQHJlZGhhdC5jb21d
KG1haWx0bzpwYm9uemluaUByZWRoYXQuY29tKSk+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
ICB4ODYvcmVhbG1vZGUubGRzIHwgMiArLQ0KPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0t
Z2l0IGEveDg2L3JlYWxtb2RlLmxkcyBiL3g4Ni9yZWFsbW9kZS5sZHMNCj4gPiA+ID4gPiBpbmRl
eCAwZWQzMDYzYi4uZTQ3ODJhOTggMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEveDg2L3JlYWxtb2Rl
Lmxkcw0KPiA+ID4gPiA+ICsrKyBiL3g4Ni9yZWFsbW9kZS5sZHMNCj4gPiA+ID4gPiBAQCAtMSw2
ICsxLDYgQEANCj4gPiA+ID4gPiAgIFNFQ1RJT05TDQo+ID4gPiA+ID4gICB7DQo+ID4gPiA+ID4g
LSAgICAuID0gMTZLOw0KPiA+ID4gPiA+ICsgICAgLiA9IDMySzsNCj4gPiA+ID4gPiAgICAgICBz
dGV4dCA9IC47DQo+ID4gPiA+ID4gICAgICAgLnRleHQgOiB7ICooLmluaXQpICooLnRleHQpIH0N
Cj4gPiA+ID4gPiAgICAgICAuID0gQUxJR04oNEspOw0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4g
Pg0KPiA+ID4gPiAgIEhpIFBhb2xvIQ0KPiA+ID4gPg0KPiA+ID4gPiBGWUksIHRoZSByZWFsbW9k
ZSBrdm0tdW5pdC10ZXN0IG5vdyBhbHNvIGZhaWxzIHdpdGggdGhlIHJlY2VudCB2ZXJzaW9uDQo+
ID4gPiA+IG9mIEdDQyAxNiBmb3IgdGhlIGkzODYgdGFyZ2V0Og0KPiA+ID4gPg0KPiA+ID4gPiAg
IFtbaHR0cHM6Ly9naXRsYWIuY29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0LXRlc3RzLy0vam9i
cy8xNDE5NTE5NTcyN10oaHR0cHM6Ly9naXRsYWIuY29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0
LXRlc3RzLy0vam9icy8xNDE5NTE5NTcyNyldKGh0dHBzOi8vZ2l0bGFiLmNvbS9rdm0tdW5pdC10
ZXN0cy9rdm0tdW5pdC10ZXN0cy8tL2pvYnMvMTQxOTUxOTU3MjddKGh0dHBzOi8vZ2l0bGFiLmNv
bS9rdm0tdW5pdC10ZXN0cy9rdm0tdW5pdC10ZXN0cy8tL2pvYnMvMTQxOTUxOTU3MjcpKQ0KPiA+
ID4gPg0KPiA+ID4gPiBJdCB3YXMgd29ya2luZyBmaW5lIHNvbWUgd2Vla3MgYWdvIHdpdGggR0ND
IDE1LjE6DQo+ID4gPiA+DQo+ID4gPiA+ICAgW1todHRwczovL2dpdGxhYi5jb20va3ZtLXVuaXQt
dGVzdHMva3ZtLXVuaXQtdGVzdHMvLS9qb2JzLzEzOTc3MjYwOTYxXShodHRwczovL2dpdGxhYi5j
b20va3ZtLXVuaXQtdGVzdHMva3ZtLXVuaXQtdGVzdHMvLS9qb2JzLzEzOTc3MjYwOTYxKV0oaHR0
cHM6Ly9naXRsYWIuY29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0LXRlc3RzLy0vam9icy8xMzk3
NzI2MDk2MV0oaHR0cHM6Ly9naXRsYWIuY29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0LXRlc3Rz
Ly0vam9icy8xMzk3NzI2MDk2MSkpDQo+ID4gPiA+DQo+ID4gPiA+IFdoZW4gSSBhcHBseSB5b3Vy
IHBhdGNoLCB0aGUgcHJvYmxlbSBzZWVtcyB0byBiZSBnb25lIGFnYWluIGluIHRoaXMNCj4gPiA+
ID4gY2FzZSwgYnV0IHNpbmNlIHRoZXJlIHdlcmUgc29tZSBvdGhlciBpc3N1ZXMgd2l0aCB0aGlz
ICh3aXRoIG9sZGVyDQo+ID4gPiA+IHZlcnNpb25zIG9mIEdDQywgSSB0aGluayk6DQo+ID4gPiA+
DQo+ID4gPiA+IFtbaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzQ5ZjhhYWRmLTZlM2YtNGQy
Yi1hMzJhLThiYTk0MWEzYTJhMUByZWRoYXQuY29tL10oaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
a3ZtLzQ5ZjhhYWRmLTZlM2YtNGQyYi1hMzJhLThiYTk0MWEzYTJhMUByZWRoYXQuY29tLyldKGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS80OWY4YWFkZi02ZTNmLTRkMmItYTMyYS04YmE5NDFh
M2EyYTFAcmVkaGF0LmNvbS9dKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS80OWY4YWFkZi02
ZTNmLTRkMmItYTMyYS04YmE5NDFhM2EyYTFAcmVkaGF0LmNvbS8pKQ0KPiA+ID4gPg0KPiA+ID4g
PiAuLi4gdGhlcmUgbXVzdCBiZSBhIGJldHRlciB3YXkgdG8gZml4IGl0Pw0KPiA+ID4gPg0KPiA+
ID4gPiBDb3VsZCB5b3UgcGxlYXNlIGhhdmUgYSBsb29rPw0KPiA+ID4NCj4gPiA+DQo+ID4gPg0K
PiA+ID4gQnkgdGhlIHdheSwgdGhlIGludGVsX2lvbW11IHRlc3Qgbm93IGFsc28gc3VkZGVubHkg
c3RhcnRlZCBmYWlsaW5nIChmb3IgdGhlDQo+ID4gPiB4ODZfNjQgdGFyZ2V0KSwgZWl0aGVyIGR1
ZSB0byB1cGRhdGUgb2YgR0NDIG9yIGR1ZSB0byB0aGUgdXBkYXRlIGZyb20gUUVNVQ0KPiA+ID4g
djEwLjIgdG8gMTEuMCA6DQo+ID4gPg0KPiA+ID4gIFtbaHR0cHM6Ly9naXRsYWIuY29tL2t2bS11
bml0LXRlc3RzL2t2bS11bml0LXRlc3RzLy0vam9icy8xNDE5NTE5NTcyOF0oaHR0cHM6Ly9naXRs
YWIuY29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0LXRlc3RzLy0vam9icy8xNDE5NTE5NTcyOCld
KGh0dHBzOi8vZ2l0bGFiLmNvbS9rdm0tdW5pdC10ZXN0cy9rdm0tdW5pdC10ZXN0cy8tL2pvYnMv
MTQxOTUxOTU3MjhdKGh0dHBzOi8vZ2l0bGFiLmNvbS9rdm0tdW5pdC10ZXN0cy9rdm0tdW5pdC10
ZXN0cy8tL2pvYnMvMTQxOTUxOTU3MjgpKQ0KPiA+ID4NCj4gPiA+IFR3byB3ZWVrcyBhZ28sIGl0
IHdhcyBzdGlsbCB3b3JraW5nIGZpbmU6DQo+ID4gPg0KPiA+ID4gIFtbaHR0cHM6Ly9naXRsYWIu
Y29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0LXRlc3RzLy0vam9icy8xMzk3NzI2MDk2Ml0oaHR0
cHM6Ly9naXRsYWIuY29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0LXRlc3RzLy0vam9icy8xMzk3
NzI2MDk2MildKGh0dHBzOi8vZ2l0bGFiLmNvbS9rdm0tdW5pdC10ZXN0cy9rdm0tdW5pdC10ZXN0
cy8tL2pvYnMvMTM5NzcyNjA5NjJdKGh0dHBzOi8vZ2l0bGFiLmNvbS9rdm0tdW5pdC10ZXN0cy9r
dm0tdW5pdC10ZXN0cy8tL2pvYnMvMTM5NzcyNjA5NjIpKQ0KPiA+DQo+ID4NCj4gPg0KPiA+IExv
b3BpbmcgaW4gdGhvc2Ugd2hvIHRha2UgY2FyZSBvZiBxZW11J3MgVlQtRCBub3cgKFlpLCBDbMOp
bWVudCkuLg0KPiA+DQo+ID4gLS0NCj4gPiBQZXRlciBYdQ0KPiA+DQo+DQo=
