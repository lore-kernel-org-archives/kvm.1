Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0048.outbound.protection.office365.us [23.103.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A963F1ACE;
	Mon, 29 Jun 2026 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749106; cv=fail; b=AKiNCX4xtUOJ/Gbm1jCAbh8kWmloZ3hTwaEOD3UFzKWYm+zxw9bTYml/9KHEeymxYELOErQ3Ao2wFqit70nSzR55vx26qm2vRSq9bfnPbLP+P8/z6i9XFhfiooGOQ12t9Tarovvszxhoa8p7EEIGpVVe0TlYMc4ERVhb6LEH8KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749106; c=relaxed/simple;
	bh=7VvvVHgqtG3iNqbuDdVPQ03mC2VEAa648CGEgqFsBbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dD/jJSptBzQSUgnTh61rgXwcm3Bx/EFJjsLIP6gmaVDjLe59plyhiFouc82I7ypFoxcRgfozEcAXqlXZ2B0MBLQh8Hq6yAh2jWqAUP4KjBI3+3KlsjRXQBSaD8gZGvDg8xeMyzF1MWkza7lWbufldefkFrCcG5CBXk2TTQpo/mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ga.com; spf=pass smtp.mailfrom=ga.com; dkim=pass (2048-bit key) header.d=ga.com header.i=@ga.com header.b=K32uW/dn; arc=fail smtp.client-ip=23.103.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ga.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ga.com header.i=@ga.com header.b="K32uW/dn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=TPqctZfWoXfZUYMJdqSXspazDTSzuiDiDkDlmGL/NVO5gwcrVVA0SC0qSziFpUyittugiN5mRXjrRt4W/WFOWB/QUoXulzjyB7X/AjmXhqJEk2XOSme5qzlls5flwDKZrttCC59So5Q3cn5fPbL+HfjpT75/NsBGqYNWpzsZ5O+vHf3Bv6XXxDIk6buuR2iiOf7fAgmS6AshGCZLpPSR/nH1AwcJKu4Pu/URz0AkTdR+IyLvQ7dGeCy4FpMQvBAC3I5vJ9xO0haMgGD9H/Ftcw5r1Vseqb/VHtBaN/R9gfctr3TLj/dUyraY+h72C4unPbvw8V8IL6dB3fT3abu9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VvvVHgqtG3iNqbuDdVPQ03mC2VEAa648CGEgqFsBbQ=;
 b=shtlVDDpRKgzyCxT88CIvZOz5XwcZbvRvDnJGxYSTn7svz1ML1DE9mLbRvcAfupBtWi1Bhdl8G+/9G+C2HhG3fQRL2SdYXQ5Ep/Ea4YH+gH/AL4xCGN22fVb9L75TcizDSqyLumK3dQZp5ULDCZcmoeK7XwY3UT5+8ociur+DRdwg7k+lzwpYz6y5+gZXRdtPIYlDpaRuc2CY2i2GDqwK72NGcL58MkxSut4Tira5fDFj9caA8kFPR03jL7isdRFRsvTWzQyDfgVSRVLmh/ZUcWT7IEWtgb3Wt+YUydi6RqN6E73rv7puldxlLoCYkxRIoCqUhBb6CB7P6xCKo9ePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ga.com; dmarc=pass action=none header.from=ga.com; dkim=pass
 header.d=ga.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ga.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VvvVHgqtG3iNqbuDdVPQ03mC2VEAa648CGEgqFsBbQ=;
 b=K32uW/dnR7kPRYKvAQhbto8+2ILi9Ns7s7zp5ept42PK9vohUeWz8OIPYuCTJGRIWiXhg+EjnLnJ1eKPXfuwLuniea5t3U/+amQw6W3rdq8xpUri24YO4jOZtJsBmehNFMwfftFX8rVW9u+sw6qR6kOX6hJbzVOk0Id8GcxuuX+ip1Vm/42PFFvSj/JlGFt++PepmUdPvfosscrn8HrMAN7wloxrlhyxbpO7uxyfmbFgqm/geeL1PJqDxIAhWXWlkT0wRoRGW++gAzruoYz4bNlB0bOI2Sen49ey3lgkgw3bJsJrVpvT0IHSisRcwv++9FnsqbtZt1KsPQa/wBwKIg==
Received: from SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:429::17)
 by BNAP110MB2029.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.24; Mon, 29 Jun
 2026 15:31:03 +0000
Received: from SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c749:21f3:32bf:8d22]) by SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c749:21f3:32bf:8d22%6]) with mapi id 15.21.0139.024; Mon, 29 Jun 2026
 15:31:03 +0000
From: "Soderlund, David" <David.Soderlund@ga.com>
To: Brendan Jackman <jackmanb@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, Matthew Brost
	<matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
	<rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Ying Huang
	<ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, Hao Li
	<hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes
	<rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price
	<gourry@gourry.net>, Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov
	<ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, Hao Ge
	<hao.ge@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, Sean
 Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: -EXT-[PATCH v3 09/16] KVM: VMX: Use higher-level allocator API
Thread-Topic: -EXT-[PATCH v3 09/16] KVM: VMX: Use higher-level allocator API
Thread-Index: AQHdB8wrgTVJBiFXx0yMbz5SVd1kJLZVqNDQ
Date: Mon, 29 Jun 2026 15:31:03 +0000
Message-ID:
 <SN5P110MB084894A01DF36A3CF4E6B35A9FE8A@SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-9-57bef0eadbc2@google.com>
In-Reply-To: <20260629-alloc-trylock-v3-9-57bef0eadbc2@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ga.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN5P110MB0848:EE_|BNAP110MB2029:EE_
x-ms-office365-filtering-correlation-id: af7998d9-0691-4f0d-ca04-08ded5f36ded
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|18002099003|22082099003|56012099006|4143699003|38070700021|921020;
x-microsoft-antispam-message-info:
 ZZMVs3Q4vZqCg5bly6SA/C/eod/SQEyIs5XSZj+6biZ1OWp1aj3w60g1zhi4ikVRVkhvQTkoweOKTccQSkPNkddtw+NuptzxSVySgEDPySSYVUrK7d4jO4MflQDeE157tG1p82aGQS5YKyqcF3jMij4ooVsGkDK7sV/30b4FoBOW63cXuN+PQ3gxUY6t7/Tq2exDLey2D6lYXRGOYoxQXGub3x1l2djIgOYZZUSxr1aM5WoMXcU5xvihKBwz4RInuHtNmD5i4vh4XfUtRJk+aeQms7q/6dIvV3K6fTBigsfFX115V5L6bE7Y32ygZDrYN8efM0AFlzU5XYwvGg8ZGUUFpgs2OAYu3BqIarNY53nfliLTfkSj0wn9fnZGpNc2UtHWyYD6x0eWwSZTzYUyGRuJfXn7i2Bl9jpjCeCQlx2aEOAhNVKvR6NXNa9leslxz1DylZ8yvuKzxRVzoz6OSbSSMF1gKJErostviyERNPY4NOtFfIart6BAkL5+fU+/XAC96kvozoWKU3M5zZ7eXDJxtp2ZjVw8WHKYBUHVs/zlUAnDxvKAlzXrlmUJ9rTYEOkucFwBzCO81q3y65kxZYXetDkX/7dRS4/zOa+7YzqJuyvi664Q7hitwN9reeFy9kenACL1HFITiJk38+AGCpdmQMWyUuUNMcWpPLcKLWdBRBAoFG09BoY09rPl22FnghgHgV1Ed0hwLsCkFHHsh0Irasy7jb+AdS0NC/6dyLv4yGfTYHo2GsApnlOxhF05
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWtpbzlTRFJoTXd0MWRET0ZqQWIwY0FnMWowMTZmZzdQQ2VnWjlpVXFBYm0y?=
 =?utf-8?B?cUtIWkR4Z0ZGUGxONjB2N0NYckxaaEdvVUZkWUdvbldXajB0MjVESHlnQTIv?=
 =?utf-8?B?TnNMY0d0Uk5pTG5mclBUQkxQNGJWSThITXp1amVyM1VWT3B3ODZzcjB4Tjll?=
 =?utf-8?B?L0M3T3A0STllT3MvZ2JIeUsyOFZjS0ZIRzNRNHB0NWZkQVk4SnJwQ2Mxdi9x?=
 =?utf-8?B?L0oyRkVwL0t5dHk2OVdUbUJKNTlEdzFEOGNoYm5xYnNCQkdZbi80dWIwLzdX?=
 =?utf-8?B?WUwxSG5jcTNnaUQ2UENuaVoyMjNKYnkrRTI5bkFoUFFabkl5blRSdmFucWt6?=
 =?utf-8?B?SHd1em1nNXlTL2prUG43N3c5NjR3Z1lsNjE5ekhtUDVORVpzTkxXLzRMayt3?=
 =?utf-8?B?RWYrRHY2aGl2bkZTR2htekNGUFRleTNuaWdCakVxeEZ0Z3ZTWHRYUnhsSlBX?=
 =?utf-8?B?QjJlYmJNcElEODk5M1lDMElNUzljNTdEV0RjejVJbEpSUC9vbFNGRDhyckNF?=
 =?utf-8?B?MG5UYmdyV2FGWWtOOFJRTFAvU1ZwMXVXdm5qenNvMUN5KzBvZDBoQXovY2Vj?=
 =?utf-8?B?bnc1bjdyYWxQQXVjakVGVXorcVk3dGxkL2VhdjZaQ25Lb3hCQi9uVnYxVUF6?=
 =?utf-8?B?c0NSVzQzbWdidzk4ZVFUdDBBc1ZrWUJtMHVheVdCT0dQUHBDMWpWOFhydHJS?=
 =?utf-8?B?a0MyamEvdUFObkRtVS93NXVCSThpOXJteStmTWJ6WnNKSU41WnRKcFpGVi8x?=
 =?utf-8?B?dDlvSXRXS1pBbHJKU285QzlzMENmMlJUT0xMTjBmUWY4UEk5VDd2QytnZHdG?=
 =?utf-8?B?NndzZmwzeEJaMVNSbnR0dTAweXVQWDdCZVRTZklmdWN0R3laWnc2UCtQeVY2?=
 =?utf-8?B?UzFMWkVCblZvNnJTMVBuV09JeDRPRDlHUUIzb0pPeGxqK1RwVTdmVkxPdmRw?=
 =?utf-8?B?U3FKMGlEVU83YWdDVDlQSUE1UE1IUDVIU0ZLcEtkY1FWNVhsdExUckUxWktI?=
 =?utf-8?B?aGJLK09hOHlUWGZQTnBSNmZJQ2RjWlVKNG1KWHF1VDhXRFNDZTJNR0dwN3Ar?=
 =?utf-8?B?c3dpei8yLzZqNFZBd0NJNlp4WWJjMFdueSs0dGN4MytKMGZvSVAzSVV3NnhX?=
 =?utf-8?B?STVLalVOZmpGams4RHRZdmE3L3RpdW4xVng0ckpxaUlqaktleEJrSDBSQU9E?=
 =?utf-8?B?MUZieGRzTXdDSnhZdjM4MVdsaFZRVUhUUXJGUGNLNGNaeEUwNkgzVFEvdmdH?=
 =?utf-8?B?dHVhUEU4bm4xZjVEby90KzJ0UCtab1NrdXpqZzNWWVJEV0o5WTRBMHJ5Y2JI?=
 =?utf-8?B?ZVAxdVhWSEZSaGFXWmc3bUp4dzFkb0NPM0tRdVRKREM3Uituc015YzdjaGYr?=
 =?utf-8?B?a28zbC9UbG5TL1JOMWw0U3ZKL3J5Y2tJcjFwMWhTeDJHMjhRRi91T25CaFB2?=
 =?utf-8?B?ZSsySll4dTZZemhWOGNCRlB1VndoQ3VvSnJVTGpidGNXdHhwa0JvVHYyWmtG?=
 =?utf-8?B?NUxBUGNHZE1udnYxQUNYVUM1Tlh2ZzF0R1VIeVhvY082MjNOZzdUbXU4dHYv?=
 =?utf-8?B?bWhVbk9lMFBCL0lUMXVIUWxNZ2NEaEpxZ3J0WkpPc2xKcnFsSFlIblo3b1BV?=
 =?utf-8?B?UkpZTDVadTkxcURRTzFzbWhmYnNyb3dEcVJsVjBmNjh5MnBJWDBlampRTU1G?=
 =?utf-8?B?WW9QT0tHTnpVKy9wRHArRFBJK045eUcxMjhNeEQybWVtYlJONEx2Y1VTVUtU?=
 =?utf-8?B?WWl5bEhiUHRTL3BnVHdUQk04azdxWTdPcDFwWmJjSHZJMzF1TjFrUjV5djZZ?=
 =?utf-8?B?YUgwL2FBd2xwdEEwS3ZVVm9ncnBRbDQvTXJMNElBUEU3aXNVZUt1VWFNUVVr?=
 =?utf-8?B?dGJ1MkVudTRaTWw1YjUwUWpqOXZJOWVqait2ZFhGdEJFRzlvS3J0VjhSSjNi?=
 =?utf-8?B?cjJ3cWZTc1h1QWpEUlJGVm9FOW5nVUMxM3dKdER6L21XZTVURTlYTkluMTNJ?=
 =?utf-8?B?QWJCZWtrZGtuRVExYzNJaWNSMlp6TUJIR1lKVXR0UDdYQ0w3WVBIU0RnWTNi?=
 =?utf-8?B?QldUdjVhQ1p2VXZQaFVyTEhKSGtvQlBPaFVPRGdIbTNmNzVuRDBxbXN1bGE2?=
 =?utf-8?B?ZXVTL0dBc2REd2tuK2dzSDZDNGR5ZnpFbE1vbm8yZDJIOWIvUThhaGJHYlV1?=
 =?utf-8?Q?yeFaezZkZMgUL66C/4PS8hUwZruuGzh026KH2TbezA2j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ga.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af7998d9-0691-4f0d-ca04-08ded5f36ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 15:31:03.1028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05e53887-e4b3-4595-87f7-3ae79f0e723e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BNAP110MB2029

Q2FuIHNvbWVvbmUgcGxlYXNlIHJlbW92ZSBtZSBmcm9tIHRoaXMgbGlzdC4gIEkndmUgcmVxdWVz
dGVkIGEgY291cGxlIG9mIHRpbWVzLg0KDQogIFRoYW5rcywNCiAgICAgRGF2aWQNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJyZW5kYW4gSmFja21hbiA8amFja21hbmJAZ29v
Z2xlLmNvbT4gDQpTZW50OiBNb25kYXksIEp1bmUgMjksIDIwMjYgNzoxMiBBTQ0KVG86IEFuZHJl
dyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBWbGFzdGltaWwgQmFia2EgPHZi
YWJrYUBrZXJuZWwub3JnPjsgU3VyZW4gQmFnaGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT47
IE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPjsgSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNA
Y21weGNoZy5vcmc+OyBaaSBZYW4gPHppeUBudmlkaWEuY29tPjsgTXVjaHVuIFNvbmcgPG11Y2h1
bi5zb25nQGxpbnV4LmRldj47IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT47IERh
dmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBrZXJuZWwub3JnPjsgTG9yZW56byBTdG9ha2VzIDxsanNA
a2VybmVsLm9yZz47IExpYW0gUi4gSG93bGV0dCA8bGlhbUBpbmZyYWRlYWQub3JnPjsgTWlrZSBS
YXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPjsgTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBp
bnRlbC5jb20+OyBKb3NodWEgSGFobiA8am9zaHVhLmhhaG5qeUBnbWFpbC5jb20+OyBSYWtpZSBL
aW0gPHJha2llLmtpbUBzay5jb20+OyBCeXVuZ2NodWwgUGFyayA8Ynl1bmdjaHVsQHNrLmNvbT47
IFlpbmcgSHVhbmcgPHlpbmcuaHVhbmdAbGludXguYWxpYmFiYS5jb20+OyBBbGlzdGFpciBQb3Bw
bGUgPGFwb3BwbGVAbnZpZGlhLmNvbT47IEhhbyBMaSA8aGFvLmxpQGxpbnV4LmRldj47IENocmlz
dG9waCBMYW1ldGVyIDxjbEBnZW50d28ub3JnPjsgRGF2aWQgUmllbnRqZXMgPHJpZW50amVzQGdv
b2dsZS5jb20+OyBSb21hbiBHdXNoY2hpbiA8cm9tYW4uZ3VzaGNoaW5AbGludXguZGV2PjsgU2Vi
YXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgQ2xhcmsgV2ls
bGlhbXMgPGNscmt3bGxtc0BrZXJuZWwub3JnPjsgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29v
ZG1pcy5vcmc+DQpDYzogSGFycnkgWW9vIChPcmFjbGUpIDxoYXJyeUBrZXJuZWwub3JnPjsgR3Jl
Z29yeSBQcmljZSA8Z291cnJ5QGdvdXJyeS5uZXQ+OyBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0Bj
bXB4Y2hnLm9yZz47IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBNYXR0aGV3
IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEhhbyBHZSA8aGFvLmdlQGxpbnV4LmRldj47
IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
cnQtZGV2ZWxAbGlzdHMubGludXguZGV2OyBCcmVuZGFuIEphY2ttYW4gPGphY2ttYW5iQGdvb2ds
ZS5jb20+OyBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT47IFBhb2xvIEJv
bnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBrdm1Admdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiAtRVhULVtQQVRDSCB2MyAwOS8xNl0gS1ZNOiBWTVg6IFVzZSBoaWdoZXItbGV2ZWwgYWxsb2Nh
dG9yIEFQSQ0KDQpXQVJOSU5HOiAgVGhpcyBtZXNzYWdlIGlzIGZyb20gYW4gZXh0ZXJuYWwgc291
cmNlLiAgRXZhbHVhdGUgdGhlIG1lc3NhZ2UgY2FyZWZ1bGx5IEJFRk9SRSBjbGlja2luZyBvbiBs
aW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLg0KDQpUaGUgZGlmZmVyZW5jZSBiZXR3ZWVuIF9f
YWxsb2NfcGFnZXNfbm9kZSgpIGFuZCBhbGxvY19wYWdlc19ub2RlKCkgaXMgdGhhdCB0aGUgbGF0
dGVyIGFsbG93cyB5b3UgdG8gcGFzcyBOVU1BX05PX05PREUuDQoNClRoZSBmb3JtZXIgaXMgZ29p
bmcgYXdheSBhbmQgdGhlIGxhdHRlciB3b3JrcyBmaW5lIGhlcmUgc28gc3dpdGNoIG92ZXIuDQoN
Ck5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KDQpDYzogU2VhbiBDaHJpc3RvcGhlcnNv
biA8c2VhbmpjQGdvb2dsZS5jb20+DQpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCkNjOiBrdm1Admdlci5rZXJuZWwub3JnDQpBc3Npc3RlZC1ieTogR2VtaW5pOnVua25v
d24tdmVyc2lvbg0KUmV2aWV3ZWQtYnk6IFN1cmVuIEJhZ2hkYXNhcnlhbiA8c3VyZW5iQGdvb2ds
ZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBCcmVuZGFuIEphY2ttYW4gPGphY2ttYW5iQGdvb2dsZS5j
b20+DQotLS0NCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3ZteC92bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMgaW5kZXggMjMyNWJlNTdkM2Q3
NS4uYWQ2YTdmYzZhNTRkYSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCisr
KyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCkBAIC0zMDI4LDcgKzMwMjgsNyBAQCBzdHJ1Y3Qg
dm1jcyAqYWxsb2Nfdm1jc19jcHUoYm9vbCBzaGFkb3csIGludCBjcHUsIGdmcF90IGZsYWdzKQ0K
ICAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZXM7DQogICAgICAgIHN0cnVjdCB2bWNzICp2bWNzOw0K
DQotICAgICAgIHBhZ2VzID0gX19hbGxvY19wYWdlc19ub2RlKG5vZGUsIGZsYWdzLCAwKTsNCisg
ICAgICAgcGFnZXMgPSBhbGxvY19wYWdlc19ub2RlKG5vZGUsIGZsYWdzLCAwKTsNCiAgICAgICAg
aWYgKCFwYWdlcykNCiAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCiAgICAgICAgdm1jcyA9
IHBhZ2VfYWRkcmVzcyhwYWdlcyk7DQoNCi0tDQoyLjU0LjANCg0KDQo=
