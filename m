Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF73DD864
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662198; cv=none; b=lPln+NBzwjnjKyxIwcgru+rTwtfnxg8AJ3AwZhk7+QkauNafH5d19bM73pzdRALIKArnr6PfoO+9eIz4gO2N53HHfE4Ait7mk+rSODrPmBx3aUEvr+hnqvL5yyp6myNGPJANepO3ws4I09ONQXfR6IlgBvPEXEaS7RPFF5DvCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662198; c=relaxed/simple;
	bh=V4vKMmSGZ/tuiDmN0Nv5FHmqqKROR/7Q7uP7nUxNEW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M98G4ljD7GNGYxyDTo05Htq9dsbGQqhwpXCzvLoxDfUHzBuwcEr3E/bO8uSaLmdjvqS+uI5tedbFOA10YfXL33S80l7WxmzETL6GzBwpffGdw9qgOAJCjJrDU/Hx4WSTbm0z5F5BELghFPfRg+qYF8WodPCw+n3bSozyZGP+Hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1778661044-1eb14e680b4ed40001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id smm0C6gL2260vf6t; Wed, 13 May 2026 16:30:44 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
X-ASG-Whitelist: Client
X-Append-Disclaimer: 1
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPd1ba5f8d9f4b2c603dd1b3e89954506a
	Wed, 13 May 2026 16:30:43 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.24.2
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Date: Wed, 13 May 2026 16:30:38 +0800
X-ASG-Orig-Subj: [PATCH 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Message-Id: <20260513083042.1603237-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513083042.1603237-1-ewanhai-oc@zhaoxin.com>
References: <20260513083042.1603237-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1778661044
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2722
X-Barracuda-BRTS-Status: 1

QWR2ZXJ0aXNlIHRoZSBaaGFveGluIFNNMiBpbnN0cnVjdGlvbiBzdXBwb3J0IHRvIGd1
ZXN0cyB2aWEgQ1BVSUQweEMwMDAwMDAxIEVEWCBiaXRzIDAgKFNNMikgYW5kIDEgKFNN
Ml9FTikuVGhlIFNNMiBpbnN0cnVjdGlvbiAoZW5jb2RpbmcgRjIgMEYgQTYgQzApIGlt
cGxlbWVudHMgdGhlIFNNMmVsbGlwdGljLWN1cnZlIHB1YmxpYy1rZXkgY3J5cHRvZ3Jh
cGh5IGFsZ29yaXRobSBzcGVjaWZpZWQgaW5HTS9UIDAwMDMtMjAxMjsgdGhlIGhhcmR3
YXJlLWxldmVsIGJlaGF2aW9yIGlzIGRvY3VtZW50ZWQgaW4gdGhlWmhhb3hpbiBHTUkg
SW5zdHJ1Y3Rpb24gU2V0IFJlZmVyZW5jZSwgY2hhcHRlciAxICgiU00yIikuIFRoZWlu
c3RydWN0aW9uIG11bHRpcGxleGVzIGl0cyBzdWItZnVuY3Rpb25zIG9uIHRoZSBSRFhb
NTowXSBjb250cm9sd29yZDogZW5jcnlwdGlvbiAoc3Vic2VjdGlvbiAxLjEpLCBkZWNy
eXB0aW9uICgxLjIpLCBzaWduaW5nICgxLjMpLHNpZ25hdHVyZSB2ZXJpZmljYXRpb24g
KDEuNCksIHRoZSB0aHJlZSBrZXktZXhjaGFuZ2Ugc3ViLW9wZXJhdGlvbnNvZiBzZWN0
aW9uIDEuNSAoMS41LjEgU00yIGtleS1wYWlyIGdlbmVyYXRpb24sIHdoaWNoIHRoZSBz
cGVjIGFsc291c2VzIGZvciB0aGUgaW5pdGlhdG9yJ3MgZXBoZW1lcmFsIGtleTsgMS41
LjIgcmVzcG9uZGVyIHNoYXJlZC1rZXlkZXJpdmF0aW9uOyAxLjUuMyBpbml0aWF0b3Ig
c2hhcmVkLWtleSBkZXJpdmF0aW9uKSwgYW5kIHR3b3ByZXByb2Nlc3Mgc3RlcHMgZm9y
IGlkZW50aXR5IGFuZCBtZXNzYWdlIGhhc2hpbmcgKDEuNi4xIGFuZCAxLjYuMikuVGhl
IGluc3RydWN0aW9uIGlzIHVzZXItbW9kZSBhbmQgYXZhaWxhYmxlIGluIGFsbCBDUFUg
bW9kZXMsIHdpdGggbm9hc3NvY2lhdGVkIE1TUiBjb250cm9sLiBUaGUgU00yIGFuZCBT
TTJfRU4gYml0cyBhcmUgcmVkdW5kYW50IGJ5aGFyZHdhcmUgZGVzaWduIChzZXQgb3Ig
Y2xlYXJlZCB0b2dldGhlcikgYW5kIGJvdGggc2VydmUgcHVyZWx5IGFzQ1BVSUQtbGV2
ZWwgZmVhdHVyZS1wcmVzZW5jZSByZXBvcnRpbmcgZmxhZ3MgcmVxdWlyaW5nIG5vIEtW
TWVtdWxhdGlvbi4gQm90aCBiaXRzIGFyZSBhZHZlcnRpc2VkIGJlY2F1c2UgZGlmZmVy
ZW50IHNvZnR3YXJlIG1heXByb2JlIGVpdGhlciBvbmUgd2hlbiBjaGVja2luZyBmb3Ig
U00yIGF2YWlsYWJpbGl0eS5TaWduZWQtb2ZmLWJ5OiBFd2FuIEhhaSA8ZXdhbmhhaS1v
Y0B6aGFveGluLmNvbT4tLS0gYXJjaC94ODYva3ZtL2NwdWlkLmMgICAgICAgICB8IDIg
KysgYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaCB8IDQgKysrKyAyIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKWRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vY3B1
aWQuYyBiL2FyY2gveDg2L2t2bS9jcHVpZC5jaW5kZXggZTY5MTU2YjU0Y2ZmLi4xZWI0
Yjg4YWFhODAgMTAwNjQ0LS0tIGEvYXJjaC94ODYva3ZtL2NwdWlkLmMrKysgYi9hcmNo
L3g4Ni9rdm0vY3B1aWQuY0BAIC0xMjcyLDYgKzEyNzIsOCBAQCB2b2lkIGt2bV9pbml0
aWFsaXplX2NwdV9jYXBzKHZvaWQpIAkJa3ZtX2NwdV9jYXBfc2V0KFg4Nl9GRUFUVVJF
X05VTExfU0VMX0NMUl9CQVNFKTsgIAlrdm1fY3B1X2NhcF9pbml0KENQVUlEX0MwMDBf
MDAwMV9FRFgsKwkJRihTTTIpLCsJCUYoU00yX0VOKSwgCQlGKFhTVE9SRSksIAkJRihY
U1RPUkVfRU4pLCAJCUYoWENSWVBUKSxkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3Jl
dmVyc2VfY3B1aWQuaCBiL2FyY2gveDg2L2t2bS9yZXZlcnNlX2NwdWlkLmhpbmRleCA2
NTdmNWY3NDNlZDkuLjdiNTUxMTBjYzA0NiAxMDA2NDQtLS0gYS9hcmNoL3g4Ni9rdm0v
cmV2ZXJzZV9jcHVpZC5oKysrIGIvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaEBA
IC03Niw2ICs3NiwxMCBAQCAjZGVmaW5lIEtWTV9YODZfRkVBVFVSRV9UU0FfU1FfTk8J
S1ZNX1g4Nl9GRUFUVVJFKENQVUlEXzgwMDBfMDAyMV9FQ1gsIDEpICNkZWZpbmUgS1ZN
X1g4Nl9GRUFUVVJFX1RTQV9MMV9OTwlLVk1fWDg2X0ZFQVRVUkUoQ1BVSURfODAwMF8w
MDIxX0VDWCwgMikgKy8qIFpoYW94aW4vQ2VudGF1ciBzdWItZmVhdHVyZXMsIENQVUlE
IGxldmVsIDB4QzAwMDAwMDEgKEVEWCkgKi8rI2RlZmluZSBYODZfRkVBVFVSRV9TTTIJ
CQlLVk1fWDg2X0ZFQVRVUkUoQ1BVSURfQzAwMF8wMDAxX0VEWCwgMCkrI2RlZmluZSBY
ODZfRkVBVFVSRV9TTTJfRU4JCUtWTV9YODZfRkVBVFVSRShDUFVJRF9DMDAwXzAwMDFf
RURYLCAxKSsgc3RydWN0IGNwdWlkX3JlZyB7IAl1MzIgZnVuY3Rpb247IAl1MzIgaW5k
ZXg7LS0gMi4zNC4xCgoKCgrkv53lr4blo7DmmI4K5pys6YKu5Lu25ZCr5pyJ5L+d5a+G
5oiW5LiT5pyJ5L+h5oGv77yM5LuF5L6b5oyH5a6a5pS25Lu25Lq65L2/55So44CC5Lil
56aB5a+55pys6YKu5Lu25oiW5YW25YaF5a655YGa5Lu75L2V5pyq57uP5o6I5p2D55qE
5p+l6ZiF44CB5L2/55So44CB5aSN5Yi25oiW6L2s5Y+R44CCCgpUaGlzIGVtYWlsIGNv
bnRhaW5zIGNvbmZpZGVudGlhbCBvciBsZWdhbGx5IHByaXZpbGVnZWQgaW5mb3JtYXRp
b24gYW5kIGlzIGZvciB0aGUgc29sZSB1c2Ugb2YgaXRzIGludGVuZGVkIHJlY2lwaWVu
dC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgY29weWluZyBvciBmb3J3YXJk
aW5nIG9mIHRoaXMgZW1haWwgb3IgdGhlIGNvbnRlbnQgb2YgdGhpcyBlbWFpbCBpcyBz
dHJpY3RseSBwcm9oaWJpdGVkLg==

