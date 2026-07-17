Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5253A7F60;
	Fri, 17 Jul 2026 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.64.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291909; cv=fail; b=Y+T1+h5v2/g8uK8J7a8Waw/1k12cEnQ1Cwu1HyvMk9hSFvvHjQmTbUN7Vf0nTaV0H/enNh86f73axeE/q7yb1awBCh2Cua4OflV+6AbmqRVF+UjqYAdx0mSIxpwLPbGI+Kg55fKn2hkkkYjsmpTm4/h9PpKWyNtemlV0ixHu36w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291909; c=relaxed/simple;
	bh=6J94fC8JYI/GJ67YNkUCzSbQaX6m/byAmJKsEZQ/rRQ=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RV2ckYBEMZ0rgFdBjU6BWKwxYhM/90uVM4o/NmVrU8T1OevgG4ySja1RjmhXx2bayQ03QF6gD5MnZ/QI7G3cVyXvOwP2tuLLG5Q9Ns670ZRcqWp84swYfeadf87wgY7I9mPWnIYqAjUabNfEq5Iwcufu8E1TlmvffIYqmJcpKrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=J4TQZbnX; arc=fail smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="J4TQZbnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1784291908; x=1815827908;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=6J94fC8JYI/GJ67YNkUCzSbQaX6m/byAmJKsEZQ/rRQ=;
  b=J4TQZbnXsYJF4o5IamYD+J5Tscp3ltcxVLiakDD7jeSvo1S9wWMtY4BX
   K2XeMhLGdQrl4D7C5loj4abSgN0m2if7vOWLQnSemU27+DKD5vtM4SLD+
   dvbjkHGm2bkQmajXaRuVoSR0cdLWOAD1K4x2DELO5HvIyUhzoByj6AgMT
   jjmVTwafze8ZHWtqFKYBVMzzGiBQ8AROGB9wuPJhCQ+/oNHXzJiTrMdjb
   giNZ9BN7IPgiJPg1rD7SVn0/6pv2Hp3y8LDjaqtXxVKzqEdI6TSAcUtUh
   x6Y4IC2QEqzY6OacbTKNGATDx4Z2LL1WxQhtUM2684Lnvihz0+7iUSX51
   w==;
X-CSE-ConnectionGUID: tuW5OoSPRlGSpuKghU+mEQ==
X-CSE-MsgGUID: Js877UeWQxKCC7ItTe3JpA==
X-IronPort-AV: E=Sophos;i="6.25,169,1779148800"; 
   d="scan'208";a="16523118"
Subject: Re: [RFC PATCH 00/24] KVM: x86: Introduce memory protection attributes
Thread-Topic: [RFC PATCH 00/24] KVM: x86: Introduce memory protection attributes
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 12:38:23 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:18664]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.38.207:2525] with esmtp (Farcaster)
 id 513ce515-a260-4982-8cda-0e9c1403bc85; Fri, 17 Jul 2026 12:38:23 +0000 (UTC)
X-Farcaster-Flow-ID: 513ce515-a260-4982-8cda-0e9c1403bc85
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 17 Jul 2026 12:38:20 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Fri, 17 Jul 2026 12:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY8WiHPH3qGK/rtel1RmZSxxUs5OoC7c0rloNMbbtZw3C18dVppwbqEoS/+usg/2QWBM31TlheQT1iqtLog83u457ROF0R3ELohLSx8asytVoqxRAFN6L23vYOqzjn+/+4FiISyP9KlhilCv0HPxath2sz59wKHoBM9a+eyAsArLvQbbEmOX+khJ7UG0TPaN5XzIwGGjo4yxdFTeWKAIrwsJ8U467o8M7vVZQQ3fEhXSNitQFvhTz+I7X4//jzjTgBQ/mWckzfPVDHFLaPS6OJMWvThXuXXw/Mn5vBqN3lKbJASOU5z56jcAF8ArLtVQu4DNaviw0hBoEibndPvwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J94fC8JYI/GJ67YNkUCzSbQaX6m/byAmJKsEZQ/rRQ=;
 b=PjLSXGbBufpaOhy7NIIZPRfXJm9Ykgo6lZxeZt8B+u5N4bKEOy9XdK/VfKwnTJnhzhBMy0N000qxLrO94lzZT1xikAoen3WkFENdGhiz/b8Zo3BwAfveq04f1QO+uSsqdMLc7MCyf8vWZp6X91vwYegi/wX28v69oWo+lQBUMjv/R9qVHAHQvQ6Wgz3wt4hJPDqIzpYLB7EaNoytqucVW4uuPJwykmKJkRxDLJRe5NWE4OOBrrhDDOGnecz1cz5leTEhDoVATxTJX+/ude09iWdLWvg68v1p7Qhx5TnzhhPfFI05foJJLAoa0vL6KPdkoiYrBkXOoY34AXTz+l193w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.es; dmarc=pass action=none header.from=amazon.es;
 dkim=pass header.d=amazon.es; arc=none
Received: from AM0PR06MB10511.eurprd06.prod.outlook.com (2603:10a6:20b:700::7)
 by DB8PR06MB6554.eurprd06.prod.outlook.com (2603:10a6:10:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 12:38:20 +0000
Received: from AM0PR06MB10511.eurprd06.prod.outlook.com
 ([fe80::9834:3241:1f23:20ed]) by AM0PR06MB10511.eurprd06.prod.outlook.com
 ([fe80::9834:3241:1f23:20ed%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 12:38:20 +0000
From: "Saenz Julienne, Nicolas" <nsaenz@amazon.es>
To: Paolo Bonzini <pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Thread-Index: AQHdFU9lDTpHIu9Io0+yS9KXBVyFzrZxp6yA
Date: Fri, 17 Jul 2026 12:38:20 +0000
Message-ID: <DK0UOUV01IXK.3IRY2XCQZJ6CB@amazon.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.es;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10511:EE_|DB8PR06MB6554:EE_
x-ms-office365-filtering-correlation-id: a68dafc6-3dbc-4feb-6c05-08dee40048e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|6133799003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: zC6Xs2Akda8NRDSUmRfHl1C+9ZmXh+qlZEVcGRLXCu3XTtpceZ9SdU8/y1Y8INTadUF3ahonTvwv7nQ+D+V0tcyyESuQSE4D0sfFKVdMEWHCnI2R4KUQt6LHiEEPrCbIAnkhJXvdMU2fEEmrOJpt3K83/OdM8lH86G6GIacnnY9yq/I9aIP+r2Np+/QZ0KJYuT7U0xWirJKqCRGUVaF27PppdMarQLbGjX5JsUkwDA7nlwNyfLDW3VhIJvFxpNPwuYZ+E0UsWtoT9uOqsrN2WTNN4szz0iDD7MmIkiC7+CY+PRvn1GVLQK3RAcyPNdZOeImhsj7WmwJmTv46lDlKXQ4Q/+oTE+5NQ6F8gfEnUccaobyhXB2i4epV9XAFTlGJor2x6Cz43Xlm0YTMVT/gqRSylZ2CE+G/hm5S1ZSiNMJfvY/aXBlW0X4nXqaLku0q2qwWQjgeCpLHEuCJRZWgpoHroao6Xrqd2o3E9I1dxu4qRpXtJvRBXJ5dN13IEt3h5rAZcjOvHR8W2SncGT/GnkGOAyRr9f6gpromQoGABTrGTB8nULbyElRqLsM+7TrmE3JrCve6/LJf56yCBUdPnqxVxDUJdRFuEdtRefLHhwnujfkglwKJCX4jd6fGsSYvLbsntUawudC6Cv+wA10rP3b9IN/4cAzMCt/NJiMeQQpjhtunQp71RXxMF3aPp0P5C3q5dBgdTkIIcr0BvhS0bJaK4JfyHwwI4msPtszMAa8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10511.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGhlZ2R1K3BOdWp0RmVBQTBxMys2Ym9xL1JneXc2Q2xUZDdqeDIzZDVkdEpy?=
 =?utf-8?B?citoa1FQN1p6NlBzU0EvMmFBSDlJdHBLbUZzVkFhcm5Lb2tERFI2K0ovcjFy?=
 =?utf-8?B?TzJ5SldWR3BDVTVQVElpNUhMWVBYU0w1VFhYcXBsV1BWK3VkeHlwaEtHZEha?=
 =?utf-8?B?K0h6amVaL0crZEQ0WkVzVFpDKytOcUdkNWl5UDYydDc3aFhaZ2tlazI2REdI?=
 =?utf-8?B?MzMwRTNXMGw5c3g2Zy90SW1keGx1djlxQ29GaHNVL0pMTk5xY0RvcHA4NUIx?=
 =?utf-8?B?K2dVY0cvV3djNCt6T2psR1A3MHNlTy9GZ1pwU1J0NDhQZUxPalo0b3VvU3Bi?=
 =?utf-8?B?SkxEbGw4Z3cyMTNPZWhiOEt5WlVWZXBENXc2K0NCU2Z1UFQvL25FUWJlWFZv?=
 =?utf-8?B?Y2p6eWZKRUUzRHVWSG5UdWFFSjRCUmpFenpQTSs0TUJ5SXZFZC9wYWZ2U0RI?=
 =?utf-8?B?RU1yQkl3a21oaExkV2ZIN3ZHRkxmZGZIa2RsYW83b3JkV2dld0dabUFBV1ZS?=
 =?utf-8?B?UWlTQ3drYkt4d1ZZeDV5Tm1pSFpMWnFwakFFWmR6bEpqMnB1K2p3RWQ0UXBx?=
 =?utf-8?B?VGVWa0hmeVFGYU9IRGEyMTdyNmxSMW9YQ01COU5TMWtSYUZPWjZDcDJTeUEw?=
 =?utf-8?B?MEsvSnc4TmpPZFQzTUxBVk5iSUl4RFdVY01UN1RuS0ZMaGZxWXdEc005cjli?=
 =?utf-8?B?UEwxU1N1bmxFWG9vQlVmR2pWeU0vMm93TnJ3L24wTjBzMDZBdnpoY2Npc0lS?=
 =?utf-8?B?T0N5emZQcWg1ODg5alZkOE9uKysyV3N3RVNtTFd6TWI4aWs5cTk3NE1TUEQ4?=
 =?utf-8?B?eWpTMFpJQ3NibmhFeEs2QlA3c1lOVklEemdZUndRRmE2WC9wWHZTbU1MZkhF?=
 =?utf-8?B?ZHovQ2Q2enZ5RWw1cHptcmYwV3lxejAxN3d0NUFyZlBSSEk0Mkh2RXh3UHNP?=
 =?utf-8?B?S0FMMzRlUUdHWlZkQjdBZSsrYzhUcXNiRGZHWEM4R21lWFh3RDdXdVhWR1Nt?=
 =?utf-8?B?K0VnakZ6bFoyT2ZWRUE4R05wS3U0TUJNMGt2UWx2TENiUkxlWjJQd2dBOE43?=
 =?utf-8?B?akFDcFB0eHprRGdjdUhjaDMyM2lSMmNtSXNWb0lRSHN3czNiNWprQU51OVY1?=
 =?utf-8?B?NHQvcXhrbENwZDBzQlBjZzNUSE90UllzYjRkallpMkltbWt4MFhublk1d1Bi?=
 =?utf-8?B?MkhUZ2xYR0lDYXh3eUdjM1QrL3pha3hORjFjbVl3RndsRS9HaGRGWnFkT0ZE?=
 =?utf-8?B?d0o4Y3hTMHlpRlRST0d4a1dHREM3bk1uQ3dpU3V6dmlSVnRTalRiRzdQQS9Q?=
 =?utf-8?B?UEh6cmdrWFFSbzFkbFkwQkFGTmt2T3lwNHJZbHkzbUl4OENuMWFJSWhPNTI1?=
 =?utf-8?B?SU8rNUdWdkRDN3VlUWJDQ1VReUJkeHRNSHNQMjBoK2R3ZlU0dm5yTVcrRVFq?=
 =?utf-8?B?YjJTU0phT1AyZ0RybVNxMzdpbHF0K1g3b3hscUNhUnZ1SEVIRldzN1REUzJ1?=
 =?utf-8?B?b2FzRldRMEZ5SHNaYkY0RnduMjdUR1I1WmNtM2I3SXh4NWtmdTVmZ2RpRkxz?=
 =?utf-8?B?N1l1T0FJTk9ZaElHdFYrTnhjWW1aWDJyZmFNUVpMVFZjbndkYzk4ck0zRFVz?=
 =?utf-8?B?dGRFOTluYll5Z3pXVTFHWFR2MTVjTE15eFdyalEvakFTcUI4R1htUDVqRzJP?=
 =?utf-8?B?RG9rZ2N0WStNbkozMWoxUGJHOWFUZXE4ZjB1SHRxVG1BTjZFT3l0czNPaVNG?=
 =?utf-8?B?WXBEaTIrMFV5WTBIOUZNMlZybUhTUElsc0diYUxKTU5zelJMZW9tb1lQbGw1?=
 =?utf-8?B?RnpFVzJtdUxuVGlZNjdWdGJSY3hiU0xJZVpxb1ZFaE56bjN3MTlWeHczaHg0?=
 =?utf-8?B?NkN6WmdqZCtTUjltcXRHNGNnb3QwNVRPQ2t2OHJZeVZNeGNNeTJWZlExSnRJ?=
 =?utf-8?B?SUV5VHNHL3Q1ZVNhMHZuSmlSS3dLVGpXWkF1R2l0czFNOGN1dVJjZWxpak5P?=
 =?utf-8?B?dEhkalBPQWFzSjVvemVCbkt2d0xsQnQwb2pzaHlpZkxjWE1BTWYvNTBvQ0I2?=
 =?utf-8?B?WmtIT0svVlJoV2FMeGVkazdsaHRxNlk2dGYxNVRhRGJjdytoMHphNGprL1BC?=
 =?utf-8?B?aThpOXBYY1lpNTg2bWthY3RTUWFZKzhTMG1JL1NzV0RZd0FPL3ZNYjZvcEEv?=
 =?utf-8?B?bkNsWHg0K2VDaVVFcUdvQ0N0YXVDc2dzWS9zK1FxaUdLMjdsRm0vT1VaWjJB?=
 =?utf-8?B?Q0U5eTBPMUd3djBwc2QrelI2M1d3Q3cxblJ0clY5SjZCSlZGMk0yMUxGcXFp?=
 =?utf-8?B?QlZrblpVQURZNjhyRXBONno5L1ZTMFZoN0VGYThodmo1elZmY0hCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F9440D57853D47B825B5EAA55828EB@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a1WV7KhI6TnALXl/RIXOrUKQVe2FVwpQ1H82p7FVNPNUnzO+6p3ODaQjCIkFPKhing/CsVDF1U8wWs7udqWoOx7woPn8QnQRVDclHluT82nnSQp9VzbKLPCf7oGluMYr4JxGqPRHWZIsb7OQH9r1UkwxHYyC3bv2cEGCom4vnoeFW4HteTxzI61r4YiPWL741S1c34JsCssgMToiexLxvDg8v43RHNZEaR6DxYGXD+tGSl+Be0b01eqHk3C0d4mc1mwyODcgX+sfWQqwlZRB0Y54x6co3Iu1vpL6+oRieOl3pe0LB9d6nLgC79NQi8G8Mp0IoZADNBmtCc6uNYYLHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10511.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68dafc6-3dbc-4feb-6c05-08dee40048e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 12:38:20.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNyDYIbNpVwLFhw1YG5ojXO8FtZFaM6V+8jFR8dIbkAp3uIz9QdkWfyidHnVUqFYs0R/YQVxXHLi7julJ59Low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6554
X-OriginatorOrg: amazon.es

T24gVGh1IEp1bCAxNiwgMjAyNiBhdCA4OjE0IFBNIENFU1QsIFBhb2xvIEJvbnppbmkgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+DQo+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMgYSBtZWNoYW5pc20gdG8gbGV0IHVzZXJzcGFj
ZSBibG9jayByZWFkLA0KPiB3cml0ZSBvciBleGVjdXRlIGFjY2VzcyB0byBpbmRpdmlkdWFsIEdG
TnMgdmlhIEtWTSdzIG1lbW9yeQ0KPiBhdHRyaWJ1dGUgbWVjaGFuaXNtLCBhbmQgaGF2ZSB0aGVt
IHJlcG9ydGVkIHZpYSBLVk1fRVhJVF9NRU1PUllfRkFVTFQuDQo+IEl0IGlzIG1vc3RseSB0aGUg
d29yayBvZiBOaWNvbGFzIFNhZW56IEp1bGllbm5lLCB3aXRoIGEgYml0IG9mIHBhdGNoDQo+IHJl
b3JnYW5pemF0aW9uIGFuZCBjb2RlIGNsZWFudXAgb24gbXkgc2lkZSAoYW5kIGVzcGVjaWFsbHkg
dXNpbmcgdGhlDQo+IHJldmFtcGVkIEFDQ18qIG1hc2sgaW4gTGludXggNy4yKS4NCj4NCj4gVGhl
IHJlYXNvbiB3aHkgaXQncyBzbyBsYXJnZSBpcyBiZWNhdXNlICBLVk0gbmVlZHMgdG8gc2hvdWxk
IGNoZWNrIHRoZQ0KPiBhdHRyaWJ1dGVzIGFueXRpbWUgS1ZNIHRha2VzIEdQQXMgYXMgaW5wdXQg
Zm9yIGFueSBhY3Rpb24gaW5pdGlhdGVkIGJ5DQo+IHRoZSBndWVzdDsgaWYgdGhlIG1lbW9yeSBh
dHRyaWJ1dGVzIGFyZSBpbmNvbXBhdGlibGUgd2l0aCBzdWNoIGFjdGlvbiwNCj4gaXQgc2hvdWxk
IGJlIHN0b3BwZWQuICBGb3IgbW9yZSBpbmZvcm1hdGlvbiBzZWUNCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcva3ZtL0QzTUpKQ1ROWTdPTS5XT0I1VzhBVkJIOUdAYW1hem9uLmNvbS8uDQo+DQo+
IFRoZXJlIGFyZSBzZXZlcmFsIGJpdHMgbWlzc2luZzoNCj4NCj4gLSBoeXBlcmNhbGwgaGFuZGxp
bmcgZm9yIG5vbi1IeXBlclYgaHlwZXJjYWxscyBpcyB1bnRlc3RlZC4gIFhlbg0KPiAgIGh5cGVy
Y2FsbHMgYXJlIG5vdCBhIGJpZyBkZWFsIChhdCBsZWFzdCBmb3IgbWUuLi4pIGJlY2F1c2UgdXNl
cnNwYWNlDQo+ICAgY2FuIGFsd2F5cyBhdm9pZCB1c2luZyB0aGlzIGZlYXR1cmUgdG9nZXRoZXIg
d2l0aCBYZW4gZW11bGF0aW9uLA0KPiAgIGJ1dCBLVk1fSENfQ0xPQ0tfUEFJUklORyBjYW4gd3Jp
dGUgdG8gbWVtb3J5LiAgSXQgc2hvdWxkIGF0IGxlYXN0DQo+ICAgYmUgdGVzdGVkIQ0KPg0KPiAt
IG5lc3RlZCB2aXJ0dWFsaXphdGlvbiBpcyB1bnRlc3RlZCBhbmQgdGhlcmUgaXMgYSBrbm93biBo
b2xlDQo+ICAgaW4gcGF0Y2ggMjENCj4NCj4gLSBNQkVDL0dNRVQgc3VwcG9ydCBzaG91bGQgYmUg
YWRkZWQgdG9vLCBJIGhhdmUgdGFrZW4gaXQgaW50byBhY2NvdW50DQo+ICAgd2hlbiByZWJhc2lu
ZyBOaWNvbGFzJ3Mgd29yayBidXQgaGF2ZW4ndCB3cml0dGVuIHRoZSBjb2RlIHlldA0KPg0KPiAt
IHRoZSBzcGxpdCBiZXR3ZWVuIGFyY2gtaW5kZXBlbmRlbnQgYW5kIGFyY2gtZGVwZW5kZW50IGNv
ZGUgaW4NCj4gICB0aGUgdGVzdHMgY2FuIGJlIGltcHJvdmVkLg0KPg0KPiAtIHRoZSBwdmNsb2Nr
IHRlc3QgZmFpbHMNCj4NCg0KSGkgUGFvbG8sIHRoYW5rcyBmb3IgaGF2aW5nIGEgZ28gYXQgdGhp
cyEgVHdvIHNtYWxsIGNvbW1tZW50cy4NCg0KSSBuZXZlciBnb3QgdG8gbG9vayBpbnRvIHRoZSBp
bnRlcmFjdGlvbiBiZXR3ZWVuIFJXWCBtZW1hdHRycyBhbmQNCmluc3RydWN0aW9uIGVtdWxhdGlv
bi4gVGhlcmUgaXMgYSBsb3Qgb2Ygb3BlcmF0aW9ucyB0aGF0IGVuZCB1cCByZWFkaW5nDQpndWVz
dCBtZW1vcnkuIEkgZmVhciB3ZSBtaWdodCBoYXZlIHRvIGludGVyY2VwdCBhbGwgdGhlc2UsIGFu
ZCBpdCB3aWxsDQpub3QgYmUgcHJldHR5IGFzIHRoZXkgaGFwcGVuIGRlZXAgd2l0aGluIHRoZSBl
bXVsYXRvciBmcmFtZXdvcmsuDQoNCkRvIHdlIHJlYWxseSB3YW50IHRvIHN1cHBvcnQgdGhpcyBv
biBub24tVERQIGNvbmZpZ3M/IEkgaGFkIGEgaGFyZCB0aW1lDQpmaW5kaW5nIGFuZCBmaXhpbmcg
c2lkZWNoYW5uZWxzIGluIHNoYWRvdy1wYWdpbmcsIGFuZCBJJ20gcHJldHR5IHN1cmUgSQ0KbWlz
c2VkIHNvbWUuIE9uIHRoZSBvdGhlciBoYW5kLCBJIGNhbid0IHBpY3R1cmUgYW55IHJlYWwtd29y
bGQgc2NlbmFyaW8NCndoZXJlIGEgdXNlciB3b3VsZCBuZWVkIHRvIHVzZSBSV1ggbWVtYXR0cnMg
d2l0aCBURFAgZGlzYWJsZWQuDQoNCk5pY29sYXM=
