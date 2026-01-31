Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C2C145
	for <kvm@vger.kernel.org>; Sat, 31 Jan 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769862318; cv=none; b=E+9mqTF6qAHImLqu53jORqfaskhJ9ilnAnuwnhrkmhTFQTTGJzPkXjRx4o7Uxm+5wQpXCWhQkDinAJO2HQPX2pGCL2XM1hydLsGFIPVpsLPsv1KppvrdSVf68vbn/xhpBsdHjPyvvGYPD0am5MNnwSRhvjBU4Mcoq6BjQInb6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769862318; c=relaxed/simple;
	bh=4ctMkL/gSAgW5WvV404JjvicxVQg/XOMmAPQeLMR5do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wei3kvO7INiKLrHa7nNIq8qqi96CqJS1BGh2wJTJJ0019Bkfg8QkFaFbs0V03IslmxI5LLxdtnpT7XaXl+eovsYaSL8ZBTh3mLOVqIZNyXzVU9pYH7BXIhXfBkSje+E8zPyMxYORR/va5Z0i1psDuu1hcnh6LUmiZaEI1nczufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIEtWTTogU1ZNOiBBZGQgX19yZWFk?=
 =?gb2312?Q?=5Fmostly_to_frequently_read_module_parameters?=
Thread-Topic: [????] Re: [PATCH] KVM: SVM: Add __read_mostly to frequently
 read module parameters
Thread-Index: AQHckik//SzTiR5R9UKGyqy9HU4trLVqq8KAgAGIy/A=
Date: Sat, 31 Jan 2026 12:24:15 +0000
Message-ID: <3f6524d3104843baad92c1741f6c061e@baidu.com>
References: <20260130204424.1867-1-lirongqing@baidu.com>
 <aX0bT-sKOSEVHHC8@google.com>
In-Reply-To: <aX0bT-sKOSEVHHC8@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.3.12
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IE9uIEZyaSwgSmFuIDMwLCAyMDI2LCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+IEZyb206IExp
IFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPg0KPiA+IE1hcmsgc3RhdGljIGds
b2JhbCB2YXJpYWJsZXMgdGhhdCBhcmUgcHJpbWFyaWx5IHJlYWQtb25seSB3aXRoDQo+ID4gX19y
ZWFkX21vc3RseSB0byBvcHRpbWl6ZSBjYWNoZSB1dGlsaXphdGlvbiBhbmQgcGVyZm9ybWFuY2Uu
DQo+ID4NCj4gPiBUaGUgbW9kaWZpZWQgdmFyaWFibGVzIGFyZSBtb2R1bGUgcGFyYW1ldGVycyBh
bmQgY29uZmlndXJhdGlvbiBmbGFncw0KPiA+IHRoYXQgYXJlOg0KPiA+IC0gSW5pdGlhbGl6ZWQg
YXQgYm9vdCB0aW1lDQo+IA0KPiBQbGVhc2UgbWFrZSB0aGVzZSBfX3JvX2FmdGVyX2luaXQgd2hl
cmUgcG9zc2libGUsIG5vdCBfX3JlYWRfbW9zdGx5LiAgRS5nLg0KPiBmb3JjZV9hdmljIGlzIGRl
ZmluaXRlbHkgcmVhZC1vbmx5IGFmdGVyIGluaXQuDQoNCk9rLCBJIHdpbGwgc2VuZCB2Mg0KDQpU
aGFua3MNCg0KDQpbTGksUm9uZ3FpbmddIA0K
