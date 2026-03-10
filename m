Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4E26FDAC;
	Tue, 10 Mar 2026 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106668; cv=none; b=Sm3yDCFIOG2zxt4lUwsh+WpsCEBCIlZUJO+ByGIWYyHaiq8+JuuoS5oGGyWWK2GpDF4nlVJWtYO8s9De81dJ30vFCSNBGg2Jprm4AGjWZ2XhKwy8XZeXew+96xpwGwUNSwLOBH7sCh+zpVgsZv0JIIGIVxus7G7k4CguCsZmrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106668; c=relaxed/simple;
	bh=uvDgQiLNiNjmGEBXHptOL7Zhg0JUjNaSyZU1tHU4U2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fyDWYuC8coVNtFLNGS8tskL0ZCqKnqFIkEROKvNF0ffmXO/O6ZBsMrSPOUkGXVFmSuzy42Y6zDbKEg8giqSFREBGtbas/fEd0bLG2DtTRc+jkvyWQ/vCM0lQH0NXir/6t6rpDkMUZUgh9UuGkZp9HEt+9yx6yCUoMcPepzzluzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: Sean Christopherson <seanjc@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIEtWTTogZXZlbnRmZDogUmVtb3Zl?=
 =?gb2312?B?IHJlZHVuZGFudCBzeW5jaHJvbml6ZV9zcmN1X2V4cGVkaXRlZCBmcm9tIGly?=
 =?gb2312?Q?qfd_assignment?=
Thread-Topic: [????] Re: [PATCH] KVM: eventfd: Remove redundant
 synchronize_srcu_expedited from irqfd assignment
Thread-Index: AQHcr6YlGDhal6Hk7kiUw9vrnbMY3rWlz5OAgAEs+GA=
Date: Tue, 10 Mar 2026 01:37:26 +0000
Message-ID: <b9a1319e93b6445f87ae87a6c419a07f@baidu.com>
References: <20260309092132.2484-1-lirongqing@baidu.com>
 <aa7o-4eHAfTikGec@google.com>
In-Reply-To: <aa7o-4eHAfTikGec@google.com>
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
X-FEAS-Client-IP: 172.31.50.48
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gT24gTW9uLCBNYXIgMDksIDIwMjYsIGxpcm9uZ3Fpbmcgd3JvdGU6DQo+ID4gRnJvbTog
TGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+DQo+ID4gVGhlIHN5bmNocm9u
aXplX3NyY3VfZXhwZWRpdGVkKCkgY2FsbCBpbiBrdm1faXJxZmRfYXNzaWduKCkgaXMNCj4gPiB1
bm5lY2Vzc2FyeSB3aGVuIGFkZGluZyBhIG5ldyBpcnFmZCB0byB0aGUgcmVzYW1wbGVyIGxpc3Qu
IFRoZSBsaXN0DQo+ID4gaW5zZXJ0aW9uIGlzIGFscmVhZHkgUkNVLXNhZmUsIGFuZCBleGlzdGlu
ZyByZWFkZXJzIHdpbGwgZWl0aGVyIHNlZQ0KPiA+IHRoZSBvbGQgb3IgdGhlIHVwZGF0ZWQgbGlz
dCB3aXRob3V0IGluY29uc2lzdGVuY3kuDQo+IA0KPiBJdCdzIG5vdCByZXF1aXJlZCBmb3Iga2Vy
bmVsIHNhZmV0eSwgYnV0IEkgZG8gdGhpbmsgaXQncyByZXF1aXJlZCBmb3IgS1ZNJ3MgQUJJLCBl
LmcuDQo+IHRvIGVuc3VyZSB0aGUgcmVzYW1wbGVyIGlzIHZpc2libGUgdG8gcmVhZGVycyBiZWZv
cmUgS1ZNX0lSUUZEIHJldHVybnMgdG8NCj4gdXNlcnNwYWNlLg0KPiANCg0KVGhhbmtzIGZvciBl
eHBsYW5hdGlvbiwgSXQgd291bGQgYmUgYmVzdCBpZiBhIGNvbW1lbnQgY291bGQgYmUgYWRkZWQu
DQoNCj4gPiBSZW1vdmluZyB0aGlzIGNhbGwgcmVkdWNlcyBsYXRlbmN5IGR1cmluZyByZXNhbXBs
aW5nIGlycWZkIHNldHVwLg0KPiANCj4gTWF5IEkgYXNrIHdoeSB5b3UncmUgbWljcm8tb3B0aW1p
emluZyBWTXN0IHdpdGggYW4gaW4ta2VybmVsIEkvTyBBUElDPw0KDQpGZXcgZGV2aWNlcyB1c2Ug
aXQgYW55bW9yZTsgSSBqdXN0IHRoaW5rIHRoZSBrZXJuZWwgQUJJIHNob3VsZG4ndCByZXF1aXJl
IHN5bmNocm9uaXplX3NyY3VfZXhwZWRpdGVkLg0KDQpUaGFua3MNCg0KW0xpLFJvbmdxaW5nXSAN
Cg==
