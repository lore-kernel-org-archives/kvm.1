Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7D3DF006
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661066; cv=none; b=HRjaktIMaFZykHLL4H0AYoRpOdYNbm1fWjdV3t+dDzhsdfxpsNhk8r3VIMO4LAmv8Y4mjR4wpsGIQIIJ7YIIzuSWr1SmFLUnySX10l0jNmZWeNdAtrrZM1tAH+PJ+py4i/QX8Hixh4TQ2Mt9EFzdDmzmnFJ86XbrmR+O3RFo2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661066; c=relaxed/simple;
	bh=p+cNLSjbwp092zyO479Hl/hrwX4G6yk0xCYee/3OJBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzflR5zOB+cvznoEvP6SguicRZ9GsW1+yxVd3Glw4DSq3wOO44Zrq1/psaYV8a+FKC5WLksu8O28RWLuBzVnVq4tANgEhLv+rAN1YKmWuIprldqMIrb1DGO3b+Auo9/jcmU+H0cZH4MXXLy7JMEKyMQC/ADvLabGTVqlt48eETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1778661047-1eb14e680b4ed50001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id QhJrmHjDn4q1ON1h; Wed, 13 May 2026 16:30:47 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
X-ASG-Whitelist: Client
X-Append-Disclaimer: 1
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPc2acda0cc2d45d9823ea4c32b395506a
	Wed, 13 May 2026 16:30:45 +0800
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
Subject: [PATCH 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Date: Wed, 13 May 2026 16:30:41 +0800
X-ASG-Orig-Subj: [PATCH 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Message-Id: <20260513083042.1603237-5-ewanhai-oc@zhaoxin.com>
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
X-Barracuda-Start-Time: 1778661047
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2430
X-Barracuda-BRTS-Status: 1

QWR2ZXJ0aXNlIHRoZSBaaGFveGluIFBhZExvY2sgSGFzaCBFbmdpbmUgdjIgdG8gZ3Vl
c3RzIHZpYSBDUFVJRDB4QzAwMDAwMDEgRURYIGJpdHMgMjUgKFBIRTIpIGFuZCAyNiAo
UEhFMl9FTikuIFBIRTIgZXh0ZW5kcyB0aGVQYWRMb2NrIGhhc2ggZmFtaWx5IHdpdGgg
U0hBLTM4NCBhbmQgU0hBLTUxMiBzdXBwb3J0IHBlciBGSVBTIDE4MC0zLGNvbXBsZW1l
bnRpbmcgdGhlIGV4aXN0aW5nIFBIRSBmZWF0dXJlIChTSEEtMSBhbmQgU0hBLTI1Niku
VHdvIHVzZXItbW9kZSBpbnN0cnVjdGlvbnMgYXJlIGV4cG9zZWQsIGRvY3VtZW50ZWQg
aW4gdGhlIFpoYW94aW5QYWRMb2NrIEluc3RydWN0aW9uIFJlZmVyZW5jZSwgY2hhcHRl
ciAzICgiSGFzaCBFbmdpbmUiKTogIC0gUkVQIFhTSEEzODQgKGVuY29kaW5nIEYzIDBG
IEE2IEQ4LCBzdWJzZWN0aW9uIDMuMykgIC0gUkVQIFhTSEE1MTIgKGVuY29kaW5nIEYz
IDBGIEE2IEUwLCBzdWJzZWN0aW9uIDMuNClCb3RoIGNvbnN1bWUgc29mdHdhcmUtcGFk
ZGVkIDEyOC1ieXRlIGJsb2NrcyAoUkNYID0gYmxvY2sgY291bnQsIFJTSSA9aW5wdXQs
IFJESSA9IHN0YXRlKSBhbmQgcHJvZHVjZSBoYXNoIG91dHB1dCBpbiB0aGUgc3RhdGUg
YnVmZmVyLkJvdGggaW5zdHJ1Y3Rpb25zIGFyZSB1c2VyLW1vZGUgYW5kIGF2YWlsYWJs
ZSBpbiBhbGwgQ1BVIG1vZGVzLCB3aXRoIG5vYXNzb2NpYXRlZCBNU1IgY29udHJvbC4g
VGhlIFBIRTIgYW5kIFBIRTJfRU4gYml0cyBhcmUgcmVkdW5kYW50IGJ5aGFyZHdhcmUg
ZGVzaWduIChzZXQgb3IgY2xlYXJlZCB0b2dldGhlcikgYW5kIGJvdGggc2VydmUgcHVy
ZWx5IGFzQ1BVSUQtbGV2ZWwgZmVhdHVyZS1wcmVzZW5jZSByZXBvcnRpbmcgZmxhZ3Mg
cmVxdWlyaW5nIG5vIEtWTWVtdWxhdGlvbi4gQm90aCBiaXRzIGFyZSBhZHZlcnRpc2Vk
IGJlY2F1c2UgZGlmZmVyZW50IHNvZnR3YXJlIG1heXByb2JlIGVpdGhlciBvbmUgd2hl
biBjaGVja2luZyBmb3IgUEhFMiBhdmFpbGFiaWxpdHkuU2lnbmVkLW9mZi1ieTogRXdh
biBIYWkgPGV3YW5oYWktb2NAemhhb3hpbi5jb20+LS0tIGFyY2gveDg2L2t2bS9jcHVp
ZC5jICAgICAgICAgfCAyICsrIGFyY2gveDg2L2t2bS9yZXZlcnNlX2NwdWlkLmggfCAy
ICsrIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2t2bS9jcHVpZC5jIGIvYXJjaC94ODYva3ZtL2NwdWlkLmNpbmRleCAwODdj
NDEzNDEyNDAuLjNmYjgxZjdhNjEwNyAxMDA2NDQtLS0gYS9hcmNoL3g4Ni9rdm0vY3B1
aWQuYysrKyBiL2FyY2gveDg2L2t2bS9jcHVpZC5jQEAgLTEyODgsNiArMTI4OCw4IEBA
IHZvaWQga3ZtX2luaXRpYWxpemVfY3B1X2NhcHModm9pZCkgCQlGKFBNTV9FTiksIAkJ
RihSTkcyKSwgCQlGKFJORzJfRU4pLCsJCUYoUEhFMiksKwkJRihQSEUyX0VOKSwgCSk7
ICAJLypkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaCBiL2Fy
Y2gveDg2L2t2bS9yZXZlcnNlX2NwdWlkLmhpbmRleCA4NTliYTQzMTI2ZDguLmYyODMw
MGMyZDVlMCAxMDA2NDQtLS0gYS9hcmNoL3g4Ni9rdm0vcmV2ZXJzZV9jcHVpZC5oKysr
IGIvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaEBAIC04Myw2ICs4Myw4IEBAICNk
ZWZpbmUgWDg2X0ZFQVRVUkVfQ0NTX0VOCQlLVk1fWDg2X0ZFQVRVUkUoQ1BVSURfQzAw
MF8wMDAxX0VEWCwgNSkgI2RlZmluZSBYODZfRkVBVFVSRV9STkcyCQlLVk1fWDg2X0ZF
QVRVUkUoQ1BVSURfQzAwMF8wMDAxX0VEWCwgMjIpICNkZWZpbmUgWDg2X0ZFQVRVUkVf
Uk5HMl9FTgkJS1ZNX1g4Nl9GRUFUVVJFKENQVUlEX0MwMDBfMDAwMV9FRFgsIDIzKSsj
ZGVmaW5lIFg4Nl9GRUFUVVJFX1BIRTIJCUtWTV9YODZfRkVBVFVSRShDUFVJRF9DMDAw
XzAwMDFfRURYLCAyNSkrI2RlZmluZSBYODZfRkVBVFVSRV9QSEUyX0VOCQlLVk1fWDg2
X0ZFQVRVUkUoQ1BVSURfQzAwMF8wMDAxX0VEWCwgMjYpICBzdHJ1Y3QgY3B1aWRfcmVn
IHsgCXUzMiBmdW5jdGlvbjstLSAyLjM0LjEKCgoKCuS/neWvhuWjsOaYjgrmnKzpgq7k
u7blkKvmnInkv53lr4bmiJbkuJPmnInkv6Hmga/vvIzku4XkvpvmjIflrprmlLbku7bk
urrkvb/nlKjjgILkuKXnpoHlr7nmnKzpgq7ku7bmiJblhbblhoXlrrnlgZrku7vkvZXm
nKrnu4/mjojmnYPnmoTmn6XpmIXjgIHkvb/nlKjjgIHlpI3liLbmiJbovazlj5HjgIIK
ClRoaXMgZW1haWwgY29udGFpbnMgY29uZmlkZW50aWFsIG9yIGxlZ2FsbHkgcHJpdmls
ZWdlZCBpbmZvcm1hdGlvbiBhbmQgaXMgZm9yIHRoZSBzb2xlIHVzZSBvZiBpdHMgaW50
ZW5kZWQgcmVjaXBpZW50LiBBbnkgdW5hdXRob3JpemVkIHJldmlldywgdXNlLCBjb3B5
aW5nIG9yIGZvcndhcmRpbmcgb2YgdGhpcyBlbWFpbCBvciB0aGUgY29udGVudCBvZiB0
aGlzIGVtYWlsIGlzIHN0cmljdGx5IHByb2hpYml0ZWQu

