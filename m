Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5A80230D3E8;
	Thu, 10 Sep 2026 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010832; cv=none; b=B97Cds4m30VXszDXpab4m16HXR+Rpp1HJAIecjbCKnsv/M6sQbqc1XatdcSHcbF9F9KrNY0g61t3xQVDX5l7uJN63mx4nXcAtp1zfJBTIBDejJQyMKXOYH1u/PFaLEoMSC1eeD9cFhfHVX9VVT1OoZMu4OKDCr+7ciURaUQuUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010832; c=relaxed/simple;
	bh=/57swxbDPD9CIzmdqxln9B7ejn8OZf1LvKv8n2SX6Ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YIzfXBUMwzDMoqIm0Mmg/7JqqEMi5fOvP3EKJajnrwveU7aIoiU7o+OCSoNoDrhIoHqRsKZzwX5VgofnWAD+03H6Zp5pSfbraQ9sMjzm/tTumCg9CiptPXLcPORFtnj7vv9snoxPB2xWHi3Ju3nSCUyL2PSbWCBuE68s+YjdkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=S+wdeqg/; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="S+wdeqg/"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.12
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIEtWTTogaXJxY2hpcDogYWxsb2Nh?=
 =?gb2312?Q?te_routing_entries_in_chunks?=
Thread-Topic: [????] Re: [PATCH] KVM: irqchip: allocate routing entries in
 chunks
Thread-Index: AQHdP4nPMJSwZhpxoEya8LeDdyKjobbGckGAgACvyzA=
Date: Thu, 10 Sep 2026 03:26:54 +0000
Message-ID: <7d6d2449013a4435b71148177820e26d@baidu.com>
References: <20260908120133.2381-1-lirongqing@baidu.com>
 <aqH6YcHWk_GmJlqF@google.com>
In-Reply-To: <aqH6YcHWk_GmJlqF@google.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1789010816;
	bh=/57swxbDPD9CIzmdqxln9B7ejn8OZf1LvKv8n2SX6Ww=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=S+wdeqg/inVkLnNgRLpIa4ZoK3LYiwIEy1wKTmSG8telaJgDrmKK2F2lJy9D4W8qp
	 f/v9N+Np8+Y7QNotwNr857VTftfivwPGruSK9ZhcwNaNosNyY+mdrie3roFVy3xZMr
	 UEKXcLH9l5EJELeAjwvrAq99PGNJcTB31KXS9Mm7Qa4kMjxuJT2WkaIgkjPJ5Wi9uU
	 OmTNxojvX1/AihSjWETgSZHtnx+PSFES0ZEMe+ZKUEkRI6MIP3FXCbUHBsg+NYfZLn
	 pa9B+nVlBGZhOCjp0zyxLS0xwrTdKUuzmaLb3X7WBEWj/rwSOzAvr3FHsjjWL+sVhF
	 nG/E/zn/c3PQw==

DQoNCj4gUGxlYXNlIGxvb2sgYXQgWWFuZmVpJ3Mgc2VyaWVzIGFuZCBoZWxwIGNvbWUgdG8gYW4g
YWdyZWVtZW50IG9uIGhvdyBiZXN0IHRvIGZpeA0KPiB0aGlzLiAgSSBhbSB0cnlpbmcgdG8gZ2V0
IHRvIFlhbmZlaSdzIHNlcmllcywgYW5kIG5vcm1hbGx5IHdvdWxkIHRha2UgYSBjbG9zZSBsb29r
DQo+IGF0IGJvdGgsIGJ1dCBJIGFtIGV4dHJlbWVseSBzaG9ydCBvbiBjeWNsZXMgYXQgdGhlIG1v
bWVudC4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDUyNTAzNTI0Mi4x
MDcyNjQtMS15YW5mZWkueHVAYnl0ZWRhbmNlLg0KPiBjb20NCj4gDQpIaSBTZWFuLA0KDQpUaGFu
a3MgZm9yIHBvaW50aW5nIG1lIHRvIFlhbmZlaSdzIHNlcmllcy4gSSBhZ3JlZSB0aGF0IGJvdGgg
YXBwcm9hY2hlcw0KYWltIHRvIHJlZHVjZSB0aGUgYWxsb2NhdGlvbiBvdmVyaGVhZCBpbiBLVk1f
U0VUX0dTSV9ST1VUSU5HKCkuDQoNCk9uZSBtYWluIGNvbmNlcm4gd2l0aCB1c2luZyBrdmFsbG9j
KCkgZm9yIHRoZSBlbnRpcmUgcm91dGluZyBlbnRyeSBhcnJheSBpcw0KdGhhdCwgdW5kZXIgc2V2
ZXJlIG1lbW9yeSBmcmFnbWVudGF0aW9uLCBpdCBtYXkgZmFsbCBiYWNrIHRvIHZtYWxsb2MoKS4N
ClRoZSB2bWFsbG9jKCkgcGF0aCBjYW4gaGF2ZSByZWxhdGl2ZWx5IGhpZ2ggYW5kIGxlc3MgcHJl
ZGljdGFibGUgb3ZlcmhlYWQsDQplc3BlY2lhbGx5IHdoZW4gcm91dGluZyB0YWJsZXMgYXJlIHVw
ZGF0ZWQgZnJlcXVlbnRseSB3aGVuIGd1ZXN0IE9TIGlzDQpydW5uaW5nIGlycWJhbGFuY2UuDQoN
ClRoYW5rcw0KW0xpLFJvbmdxaW5nXSANCg==
