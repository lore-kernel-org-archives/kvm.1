Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB513DB635
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662199; cv=none; b=lDJuf0jQSbBKR1Hg0+OJiwIbhVN+H43LRnzcHTyAxRVOuTmrpB1jQ0ok4NwIBWtXVXXJwY2Sjr90UUyAan9ovDIjB1MXOMjAvLlhgXw0tvqiIVTy4JltKpe2VqxvuGSiTyekpJNng4dF3c2cCX/BNlGzIXY8xWBrewG+x4BCE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662199; c=relaxed/simple;
	bh=OZNuWXWlbutPNPbKLRIJrGJukzVDSPYvvDL556CUy4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+GDKq/LUrYAm4EJnSu8ahUD4/rHLNcd7/n1LyIwGeX2Um92n7Wr91ZYwyKikcWZU2L8wElQJFO3c3yTmGE9/4lXOee2AuCPcJH7R3GIG/eIGsLsJQvjdU3PONj/cynx5HTJgGeHMJyFBfBLcizPfPC1/veOFaz3ox8GzpNAPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1778661046-1eb14e680c4ed50001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id XUAdSAhcwHnmKkCm; Wed, 13 May 2026 16:30:46 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
X-ASG-Whitelist: Client
X-Append-Disclaimer: 1
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP8525cb638cc764a26b251058e90e506a
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
Subject: [PATCH 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
Date: Wed, 13 May 2026 16:30:39 +0800
X-ASG-Orig-Subj: [PATCH 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
Message-Id: <20260513083042.1603237-3-ewanhai-oc@zhaoxin.com>
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
X-Barracuda-Scan-Msg-Size: 2597
X-Barracuda-BRTS-Status: 1

QWR2ZXJ0aXNlIHRoZSBaaGFveGluIENDUyAoQ2hpbmVzZSBDcnlwdG9ncmFwaHkgU3Rh
bmRhcmQpIGZlYXR1cmUgdG9ndWVzdHMgdmlhIENQVUlEIDB4QzAwMDAwMDEgRURYIGJp
dHMgNCAoQ0NTKSBhbmQgNSAoQ0NTX0VOKS4gQ0NTIGdyb3Vwc3R3byB1c2VyLW1vZGUg
aW5zdHJ1Y3Rpb25zIGZvciBDaGluZXNlIG5hdGlvbmFsIGNyeXB0b2dyYXBoaWNwcmlt
aXRpdmVzLCBkb2N1bWVudGVkIGluIHRoZSBaaGFveGluIEdNSSBJbnN0cnVjdGlvbiBT
ZXQgUmVmZXJlbmNlLGNoYXB0ZXIgMiAoIkNDUyBpbnN0cnVjdGlvbiBncm91cCIpOiAg
LSBTTTMgKGVuY29kaW5nIEYzIDBGIEE2IEU4LCBzdWJzZWN0aW9uIDIuMSkgaW1wbGVt
ZW50cyB0aGUgU00zIGhhc2ggICAgYWxnb3JpdGhtIHNwZWNpZmllZCBpbiBHTS9UIDAw
MDQtMjAxMi4gSXQgc3VwcG9ydHMgdHdvIG1vZGVzICAgIHNlbGVjdGVkIGJ5IFJBWDog
YXV0by1wYWRkaW5nIHN0cmVhbSBtb2RlIChSQVg9MCkgYW5kIHByZS1wYWRkZWQgICAg
YmxvY2sgbW9kZSAoUkFYPS0xKS4gIC0gU000IChlbmNvZGluZyBGMyAwRiBBNyBGMCwg
c3Vic2VjdGlvbiAyLjIpIGltcGxlbWVudHMgdGhlIFNNNCBibG9jayAgICBjaXBoZXIg
c3BlY2lmaWVkIGluIEdNL1QgMDAwMi0yMDEyLCBzdXBwb3J0aW5nIEVDQiAvIENCQyAv
IENGQiAvICAgIE9GQiAvIENUUiBtb2RlcyB2aWEgYSBjb250cm9sIHdvcmQgaW4gUkFY
LCBhbmQgQ0JDLU1BQyAvIENGQi1NQUMgICAgd2hlbiBSQVggYml0WzExXSBpcyBzZXQu
Qm90aCBpbnN0cnVjdGlvbnMgYXJlIHVzZXItbW9kZSBhbmQgYXZhaWxhYmxlIGluIGFs
bCBDUFUgbW9kZXMsIHdpdGggbm9hc3NvY2lhdGVkIE1TUiBjb250cm9sLiBUaGUgQ0NT
IGFuZCBDQ1NfRU4gYml0cyBhcmUgcmVkdW5kYW50IGJ5aGFyZHdhcmUgZGVzaWduIChz
ZXQgb3IgY2xlYXJlZCB0b2dldGhlcikgYW5kIGJvdGggc2VydmUgcHVyZWx5IGFzQ1BV
SUQtbGV2ZWwgZmVhdHVyZS1wcmVzZW5jZSByZXBvcnRpbmcgZmxhZ3MgcmVxdWlyaW5n
IG5vIEtWTWVtdWxhdGlvbi4gQm90aCBiaXRzIGFyZSBhZHZlcnRpc2VkIGJlY2F1c2Ug
ZGlmZmVyZW50IHNvZnR3YXJlIG1heXByb2JlIGVpdGhlciBvbmUgd2hlbiBjaGVja2lu
ZyBmb3IgQ0NTIGF2YWlsYWJpbGl0eS5TaWduZWQtb2ZmLWJ5OiBFd2FuIEhhaSA8ZXdh
bmhhaS1vY0B6aGFveGluLmNvbT4tLS0gYXJjaC94ODYva3ZtL2NwdWlkLmMgICAgICAg
ICB8IDIgKysgYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaCB8IDIgKysgMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKylkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3Zt
L2NwdWlkLmMgYi9hcmNoL3g4Ni9rdm0vY3B1aWQuY2luZGV4IDFlYjRiODhhYWE4MC4u
OGFhYTNmMjA2NzBlIDEwMDY0NC0tLSBhL2FyY2gveDg2L2t2bS9jcHVpZC5jKysrIGIv
YXJjaC94ODYva3ZtL2NwdWlkLmNAQCAtMTI3Niw2ICsxMjc2LDggQEAgdm9pZCBrdm1f
aW5pdGlhbGl6ZV9jcHVfY2Fwcyh2b2lkKSAJCUYoU00yX0VOKSwgCQlGKFhTVE9SRSks
IAkJRihYU1RPUkVfRU4pLCsJCUYoQ0NTKSwrCQlGKENDU19FTiksIAkJRihYQ1JZUFQp
LCAJCUYoWENSWVBUX0VOKSwgCQlGKEFDRTIpLGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
dm0vcmV2ZXJzZV9jcHVpZC5oIGIvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaGlu
ZGV4IDdiNTUxMTBjYzA0Ni4uYTFjZDkxMTZlZjYzIDEwMDY0NC0tLSBhL2FyY2gveDg2
L2t2bS9yZXZlcnNlX2NwdWlkLmgrKysgYi9hcmNoL3g4Ni9rdm0vcmV2ZXJzZV9jcHVp
ZC5oQEAgLTc5LDYgKzc5LDggQEAgLyogWmhhb3hpbi9DZW50YXVyIHN1Yi1mZWF0dXJl
cywgQ1BVSUQgbGV2ZWwgMHhDMDAwMDAwMSAoRURYKSAqLyAjZGVmaW5lIFg4Nl9GRUFU
VVJFX1NNMgkJCUtWTV9YODZfRkVBVFVSRShDUFVJRF9DMDAwXzAwMDFfRURYLCAwKSAj
ZGVmaW5lIFg4Nl9GRUFUVVJFX1NNMl9FTgkJS1ZNX1g4Nl9GRUFUVVJFKENQVUlEX0Mw
MDBfMDAwMV9FRFgsIDEpKyNkZWZpbmUgWDg2X0ZFQVRVUkVfQ0NTCQkJS1ZNX1g4Nl9G
RUFUVVJFKENQVUlEX0MwMDBfMDAwMV9FRFgsIDQpKyNkZWZpbmUgWDg2X0ZFQVRVUkVf
Q0NTX0VOCQlLVk1fWDg2X0ZFQVRVUkUoQ1BVSURfQzAwMF8wMDAxX0VEWCwgNSkgIHN0
cnVjdCBjcHVpZF9yZWcgeyAJdTMyIGZ1bmN0aW9uOy0tIDIuMzQuMQoKCgoK5L+d5a+G
5aOw5piOCuacrOmCruS7tuWQq+acieS/neWvhuaIluS4k+acieS/oeaBr++8jOS7heS+
m+aMh+WumuaUtuS7tuS6uuS9v+eUqOOAguS4peemgeWvueacrOmCruS7tuaIluWFtuWG
heWuueWBmuS7u+S9leacque7j+aOiOadg+eahOafpemYheOAgeS9v+eUqOOAgeWkjeWI
tuaIlui9rOWPkeOAggoKVGhpcyBlbWFpbCBjb250YWlucyBjb25maWRlbnRpYWwgb3Ig
bGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIGFuZCBpcyBmb3IgdGhlIHNvbGUg
dXNlIG9mIGl0cyBpbnRlbmRlZCByZWNpcGllbnQuIEFueSB1bmF1dGhvcml6ZWQgcmV2
aWV3LCB1c2UsIGNvcHlpbmcgb3IgZm9yd2FyZGluZyBvZiB0aGlzIGVtYWlsIG9yIHRo
ZSBjb250ZW50IG9mIHRoaXMgZW1haWwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4=

