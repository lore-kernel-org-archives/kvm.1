Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D23DD875
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661069; cv=none; b=dzdjiPbgDMpYYMRHOqNMm5WHnS7HTxaxQevOMPcw7386fd+bAHgvPzSrmUZz7PAdYitdfBYa6GxLi5vhAJJIM+UBbxbyVjyLqPkHhfx/GrnNQNeWI7oem3bqo8d95y6vrKB9u8FcL+vebu3wSOUeGNkxgh93sw5zt+0Ae5x3J2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661069; c=relaxed/simple;
	bh=/waIIIsjq8g/MUjfpLKmXB00LLmuI6/AQGdTYfZ8tls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r00YvaqNuepb/S5NbLW9cNRgLj+br4RyjdKjjVYIv/wrQQrAvfKr/nwKqC1ADrp3oTOCn4Rc6B/aP19BJrFAgvvaWxQ/7w4bvfLMBP5J8s8f6WoVNLUinlyKNxbCmpC6BQitgyRexQmRT5UOnAU9F4mvoUzc49ogudMi20/TZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1778661046-1eb14e680e4ed50001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id Ad2iV1DTkmBi8Biw; Wed, 13 May 2026 16:30:46 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
X-ASG-Whitelist: Client
X-Append-Disclaimer: 1
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPbe14398a55643a9a3105e5d3c4d0506a
	Wed, 13 May 2026 16:30:44 +0800
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
Subject: [PATCH 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
Date: Wed, 13 May 2026 16:30:40 +0800
X-ASG-Orig-Subj: [PATCH 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
Message-Id: <20260513083042.1603237-4-ewanhai-oc@zhaoxin.com>
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
X-Barracuda-Start-Time: 1778661046
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2291
X-Barracuda-BRTS-Status: 1

QWR2ZXJ0aXNlIHRoZSBaaGFveGluIHNlY29uZC1nZW5lcmF0aW9uIGhhcmR3YXJlIFJO
RyB0byBndWVzdHMgdmlhQ1BVSUQgMHhDMDAwMDAwMSBFRFggYml0cyAyMiAoUk5HMikg
YW5kIDIzIChSTkcyX0VOKS5STkcyIGlzIGV4cG9zZWQgYnkgdGhlIFJFUCBYUk5HMiBp
bnN0cnVjdGlvbiAoZW5jb2RpbmcgRjMgMEYgQTcgRjgpLGRvY3VtZW50ZWQgaW4gdGhl
IFpoYW94aW4gUGFkTG9jayBJbnN0cnVjdGlvbiBSZWZlcmVuY2UsIHN1YnNlY3Rpb24g
MS4zKCJSRVAgWFJORzIiKS4gSXQgcHJvZHVjZXMgcmFuZG9tIGJ5dGVzIGZyb20gdHdv
IG9uLWRpZSBSTkcgc291cmNlc3NlbGVjdGFibGUgdmlhIFJBWCBiaXRzWzEwOjldIGFu
ZCBhbiBvdXRwdXQgbW9kZSAocmF3IHZzIHBvc3QtcHJvY2Vzc2VkKWNvbnRyb2xsZWQg
YnkgUkRYIGJpdHNbMTowXSwgcHJvdmlkaW5nIGhpZ2gtcXVhbGl0eSBlbnRyb3B5IGlu
dGVuZGVkZm9yIGNyeXB0b2dyYXBoaWMgb3BlcmF0aW9ucy5SRVAgWFJORzIgaXMgdXNl
ci1tb2RlIGFuZCBhdmFpbGFibGUgaW4gYWxsIENQVSBtb2Rlcywgd2l0aCBub2Fzc29j
aWF0ZWQgTVNSIGNvbnRyb2wuIFRoZSBSTkcyIGFuZCBSTkcyX0VOIGJpdHMgYXJlIHJl
ZHVuZGFudCBieWhhcmR3YXJlIGRlc2lnbiAoc2V0IG9yIGNsZWFyZWQgdG9nZXRoZXIp
IGFuZCBib3RoIHNlcnZlIHB1cmVseSBhc0NQVUlELWxldmVsIGZlYXR1cmUtcHJlc2Vu
Y2UgcmVwb3J0aW5nIGZsYWdzIHJlcXVpcmluZyBubyBLVk1lbXVsYXRpb24uIEJvdGgg
Yml0cyBhcmUgYWR2ZXJ0aXNlZCBiZWNhdXNlIGRpZmZlcmVudCBzb2Z0d2FyZSBtYXlw
cm9iZSBlaXRoZXIgb25lIHdoZW4gY2hlY2tpbmcgZm9yIFJORzIgYXZhaWxhYmlsaXR5
LlNpZ25lZC1vZmYtYnk6IEV3YW4gSGFpIDxld2FuaGFpLW9jQHpoYW94aW4uY29tPi0t
LSBhcmNoL3g4Ni9rdm0vY3B1aWQuYyAgICAgICAgIHwgMiArKyBhcmNoL3g4Ni9rdm0v
cmV2ZXJzZV9jcHVpZC5oIHwgMiArKyAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKWRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vY3B1aWQuYyBiL2FyY2gveDg2L2t2
bS9jcHVpZC5jaW5kZXggOGFhYTNmMjA2NzBlLi4wODdjNDEzNDEyNDAgMTAwNjQ0LS0t
IGEvYXJjaC94ODYva3ZtL2NwdWlkLmMrKysgYi9hcmNoL3g4Ni9rdm0vY3B1aWQuY0BA
IC0xMjg2LDYgKzEyODYsOCBAQCB2b2lkIGt2bV9pbml0aWFsaXplX2NwdV9jYXBzKHZv
aWQpIAkJRihQSEVfRU4pLCAJCUYoUE1NKSwgCQlGKFBNTV9FTiksKwkJRihSTkcyKSwr
CQlGKFJORzJfRU4pLCAJKTsgIAkvKmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vcmV2
ZXJzZV9jcHVpZC5oIGIvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaGluZGV4IGEx
Y2Q5MTE2ZWY2My4uODU5YmE0MzEyNmQ4IDEwMDY0NC0tLSBhL2FyY2gveDg2L2t2bS9y
ZXZlcnNlX2NwdWlkLmgrKysgYi9hcmNoL3g4Ni9rdm0vcmV2ZXJzZV9jcHVpZC5oQEAg
LTgxLDYgKzgxLDggQEAgI2RlZmluZSBYODZfRkVBVFVSRV9TTTJfRU4JCUtWTV9YODZf
RkVBVFVSRShDUFVJRF9DMDAwXzAwMDFfRURYLCAxKSAjZGVmaW5lIFg4Nl9GRUFUVVJF
X0NDUwkJCUtWTV9YODZfRkVBVFVSRShDUFVJRF9DMDAwXzAwMDFfRURYLCA0KSAjZGVm
aW5lIFg4Nl9GRUFUVVJFX0NDU19FTgkJS1ZNX1g4Nl9GRUFUVVJFKENQVUlEX0MwMDBf
MDAwMV9FRFgsIDUpKyNkZWZpbmUgWDg2X0ZFQVRVUkVfUk5HMgkJS1ZNX1g4Nl9GRUFU
VVJFKENQVUlEX0MwMDBfMDAwMV9FRFgsIDIyKSsjZGVmaW5lIFg4Nl9GRUFUVVJFX1JO
RzJfRU4JCUtWTV9YODZfRkVBVFVSRShDUFVJRF9DMDAwXzAwMDFfRURYLCAyMykgIHN0
cnVjdCBjcHVpZF9yZWcgeyAJdTMyIGZ1bmN0aW9uOy0tIDIuMzQuMQoKCgoK5L+d5a+G
5aOw5piOCuacrOmCruS7tuWQq+acieS/neWvhuaIluS4k+acieS/oeaBr++8jOS7heS+
m+aMh+WumuaUtuS7tuS6uuS9v+eUqOOAguS4peemgeWvueacrOmCruS7tuaIluWFtuWG
heWuueWBmuS7u+S9leacque7j+aOiOadg+eahOafpemYheOAgeS9v+eUqOOAgeWkjeWI
tuaIlui9rOWPkeOAggoKVGhpcyBlbWFpbCBjb250YWlucyBjb25maWRlbnRpYWwgb3Ig
bGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIGFuZCBpcyBmb3IgdGhlIHNvbGUg
dXNlIG9mIGl0cyBpbnRlbmRlZCByZWNpcGllbnQuIEFueSB1bmF1dGhvcml6ZWQgcmV2
aWV3LCB1c2UsIGNvcHlpbmcgb3IgZm9yd2FyZGluZyBvZiB0aGlzIGVtYWlsIG9yIHRo
ZSBjb250ZW50IG9mIHRoaXMgZW1haWwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4=

