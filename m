Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC083ADB9A
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661064; cv=none; b=WeiN/y3D6nkqU/MoFGAiCJ/Oy7jbheveY5cYVfUUYy2Q3zboj3PWJDqruztK7Qjz8ZlXYfuc7q84bBz7IeH/pqrbFer3Y84PHQ7S9dX7yV/EiCiFPM2npV812nT3s/snKsPCzZYAI0enAAW1f/OIeAXGLs0LvlEtp2cZUBtdKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661064; c=relaxed/simple;
	bh=AZ1ikMwyaaTaaqOtAn2oOqrAeABoVsLddBVwl1CNqkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzDktem8cD05kfqdPzVL6FsVzZRBdzfHz+MKfu8wdQN99oWGjLomGOKJ5gG2EgRWGXAqJjfc88V/KwuM8sDU9o07DwikvzuMRpKeUFBWw3l1Q0MPP9zKD+uTgWRX7YH+fE5ljwqjLf7UxXHoPvZrBpO2U8on1InA8LotZUliq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1778661048-1eb14e680f4ed60001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id 1lbHaqfvQxU383Rq; Wed, 13 May 2026 16:30:48 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
X-ASG-Whitelist: Client
X-Append-Disclaimer: 1
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPb45e85816a678713972ec7008c8f506a
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
Subject: [PATCH 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Date: Wed, 13 May 2026 16:30:42 +0800
X-ASG-Orig-Subj: [PATCH 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Message-Id: <20260513083042.1603237-6-ewanhai-oc@zhaoxin.com>
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
X-Barracuda-Start-Time: 1778661048
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2555
X-Barracuda-BRTS-Status: 1

QWR2ZXJ0aXNlIHRoZSBaaGFveGluIGJpZy1udW1iZXIgYXJpdGhtZXRpYyBlbmdpbmUg
dG8gZ3Vlc3RzIHZpYUNQVUlEIDB4QzAwMDAwMDEgRURYIGJpdHMgMjcgKFJTQSkgYW5k
IDI4IChSU0FfRU4pLiBUaGUgUlNBIGZlYXR1cmVwcm92aWRlcyB0d28gdXNlci1tb2Rl
IGluc3RydWN0aW9ucyBmb3IgbW9kdWxhciBhcml0aG1ldGljIG9uIGJpZ2ludGVnZXJz
LCBkb2N1bWVudGVkIGluIHRoZSBaaGFveGluIFBhZExvY2sgSW5zdHJ1Y3Rpb24gUmVm
ZXJlbmNlLGNoYXB0ZXIgNCAoIk1vZHVsYXIgTXVsdGlwbGljYXRpb24gYW5kIEV4cG9u
ZW50aWF0aW9uIEVuZ2luZSIpLiBCb3Roc3VwcG9ydCBvcGVyYW5kIHNpemVzIGZyb20g
MjU2IHRvIDMyNzY4IGJpdHMgKGluIDEyOC1iaXQgaW5jcmVtZW50cyk6ICAtIFJFUCBY
TU9ERVhQICAoZW5jb2RpbmcgRjMgMEYgQTYgRjgsIHN1YnNlY3Rpb24gNC4xKSBjb21w
dXRlcyAgICBBXkIgbW9kIE0gIC0gUkVQIE1PTlRNVUwyIChlbmNvZGluZyBGMyAwRiBB
NiBGMCwgc3Vic2VjdGlvbiA0LjIpIGNvbXB1dGVzICAgIEEqQiBtb2QgTVJFUCBNT05U
TVVMMiBpcyB0aGUgbG9uZy1tb2RlIHJlcGxhY2VtZW50IG9mIGxlZ2FjeSBSRVAgTU9O
VE1VTCwgd2hpY2hpcyByZXN0cmljdGVkIHRvIGNvbXBhdGliaWxpdHkgYW5kIDMyLWJp
dCBwcm90ZWN0ZWQgbW9kZXMuIFRoZXNlcHJpbWl0aXZlcyBhY2NlbGVyYXRlIFJTQSBh
bmQgcmVsYXRlZCBwdWJsaWMta2V5IG9wZXJhdGlvbnMuQm90aCBpbnN0cnVjdGlvbnMg
YXJlIHVzZXItbW9kZSBhbmQgYXZhaWxhYmxlIGluIGFsbCBDUFUgbW9kZXMsIHdpdGgg
bm9hc3NvY2lhdGVkIE1TUiBjb250cm9sLiBUaGUgUlNBIGFuZCBSU0FfRU4gYml0cyBh
cmUgcmVkdW5kYW50IGJ5aGFyZHdhcmUgZGVzaWduIChzZXQgb3IgY2xlYXJlZCB0b2dl
dGhlcikgYW5kIGJvdGggc2VydmUgcHVyZWx5IGFzQ1BVSUQtbGV2ZWwgZmVhdHVyZS1w
cmVzZW5jZSByZXBvcnRpbmcgZmxhZ3MgcmVxdWlyaW5nIG5vIEtWTWVtdWxhdGlvbi4g
Qm90aCBiaXRzIGFyZSBhZHZlcnRpc2VkIGJlY2F1c2UgZGlmZmVyZW50IHNvZnR3YXJl
IG1heXByb2JlIGVpdGhlciBvbmUgd2hlbiBjaGVja2luZyBmb3IgUlNBIGF2YWlsYWJp
bGl0eS5TaWduZWQtb2ZmLWJ5OiBFd2FuIEhhaSA8ZXdhbmhhaS1vY0B6aGFveGluLmNv
bT4tLS0gYXJjaC94ODYva3ZtL2NwdWlkLmMgICAgICAgICB8IDIgKysgYXJjaC94ODYv
a3ZtL3JldmVyc2VfY3B1aWQuaCB8IDIgKysgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKylkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL2NwdWlkLmMgYi9hcmNoL3g4
Ni9rdm0vY3B1aWQuY2luZGV4IDNmYjgxZjdhNjEwNy4uOTRlYTlhYmFlNTY2IDEwMDY0
NC0tLSBhL2FyY2gveDg2L2t2bS9jcHVpZC5jKysrIGIvYXJjaC94ODYva3ZtL2NwdWlk
LmNAQCAtMTI5MCw2ICsxMjkwLDggQEAgdm9pZCBrdm1faW5pdGlhbGl6ZV9jcHVfY2Fw
cyh2b2lkKSAJCUYoUk5HMl9FTiksIAkJRihQSEUyKSwgCQlGKFBIRTJfRU4pLCsJCUYo
UlNBKSwrCQlGKFJTQV9FTiksIAkpOyAgCS8qZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2
bS9yZXZlcnNlX2NwdWlkLmggYi9hcmNoL3g4Ni9rdm0vcmV2ZXJzZV9jcHVpZC5oaW5k
ZXggZjI4MzAwYzJkNWUwLi4wZGY5NmZmOTUxNWMgMTAwNjQ0LS0tIGEvYXJjaC94ODYv
a3ZtL3JldmVyc2VfY3B1aWQuaCsrKyBiL2FyY2gveDg2L2t2bS9yZXZlcnNlX2NwdWlk
LmhAQCAtODUsNiArODUsOCBAQCAjZGVmaW5lIFg4Nl9GRUFUVVJFX1JORzJfRU4JCUtW
TV9YODZfRkVBVFVSRShDUFVJRF9DMDAwXzAwMDFfRURYLCAyMykgI2RlZmluZSBYODZf
RkVBVFVSRV9QSEUyCQlLVk1fWDg2X0ZFQVRVUkUoQ1BVSURfQzAwMF8wMDAxX0VEWCwg
MjUpICNkZWZpbmUgWDg2X0ZFQVRVUkVfUEhFMl9FTgkJS1ZNX1g4Nl9GRUFUVVJFKENQ
VUlEX0MwMDBfMDAwMV9FRFgsIDI2KSsjZGVmaW5lIFg4Nl9GRUFUVVJFX1JTQQkJCUtW
TV9YODZfRkVBVFVSRShDUFVJRF9DMDAwXzAwMDFfRURYLCAyNykrI2RlZmluZSBYODZf
RkVBVFVSRV9SU0FfRU4JCUtWTV9YODZfRkVBVFVSRShDUFVJRF9DMDAwXzAwMDFfRURY
LCAyOCkgIHN0cnVjdCBjcHVpZF9yZWcgeyAJdTMyIGZ1bmN0aW9uOy0tIDIuMzQuMQoK
CgoK5L+d5a+G5aOw5piOCuacrOmCruS7tuWQq+acieS/neWvhuaIluS4k+acieS/oeaB
r++8jOS7heS+m+aMh+WumuaUtuS7tuS6uuS9v+eUqOOAguS4peemgeWvueacrOmCruS7
tuaIluWFtuWGheWuueWBmuS7u+S9leacque7j+aOiOadg+eahOafpemYheOAgeS9v+eU
qOOAgeWkjeWItuaIlui9rOWPkeOAggoKVGhpcyBlbWFpbCBjb250YWlucyBjb25maWRl
bnRpYWwgb3IgbGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIGFuZCBpcyBmb3Ig
dGhlIHNvbGUgdXNlIG9mIGl0cyBpbnRlbmRlZCByZWNpcGllbnQuIEFueSB1bmF1dGhv
cml6ZWQgcmV2aWV3LCB1c2UsIGNvcHlpbmcgb3IgZm9yd2FyZGluZyBvZiB0aGlzIGVt
YWlsIG9yIHRoZSBjb250ZW50IG9mIHRoaXMgZW1haWwgaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4=

