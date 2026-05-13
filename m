Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A43A5E7F
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662199; cv=none; b=Ew8V9YQBQ5HQquksBeaomoE6pCZl9GTK1cYpfEDGDX+f1q+WWeEPVbC1CWph88ufqweWb/JxsglY2YATndN5R9gCk4XPnteepdpyojrYufggsecaxLUofV4G99GlET/mDmV6yiFZMyS1aDRr7SY78/EV2v3/TIaxfi6tenBli0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662199; c=relaxed/simple;
	bh=5zv+8+T0KGBlfLZ7eeoPAbaTSypNdTlAKo6hfpF5o+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yp0QgG6SO+zAwlQqYVgqY1VVHkDHU4lt551/0PzQ88UrH/lLKvyra9+ueSGg3iTLgd1JcXngfNbdY3L8KooDJkk3Y+NjVO+Dm+KJWGqHWqg2C9FtcUzaSJ71ZOS36EryWIahqEERAyeMJP/hBZyxGgNw1tj2ArHD8ZjI9GD5hHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1778661044-1eb14e680f4ed50001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id chFQNdHkqjyKw1fL; Wed, 13 May 2026 16:30:44 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
X-ASG-Whitelist: Client
X-Append-Disclaimer: 1
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP72aafc21bcaad602e75775a64a35506a
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
Subject: [PATCH 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Date: Wed, 13 May 2026 16:30:37 +0800
X-ASG-Orig-Subj: [PATCH 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Message-Id: <20260513083042.1603237-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
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
X-Barracuda-Scan-Msg-Size: 2920
X-Barracuda-BRTS-Status: 1

VGhpcyBzZXJpZXMgZXhwb3NlcyBmaXZlIGdyb3VwcyBvZiBaaGFveGluLXNwZWNpZmlj
IENQVUlEIDB4QzAwMDAwMDEgRURYZmVhdHVyZSBiaXRzIHRvIEtWTSBndWVzdHMuIEVh
Y2ggZ3JvdXAgY29ycmVzcG9uZHMgdG8gYSBjYXRlZ29yeSBvZnVzZXItbW9kZSBjcnlw
dG9ncmFwaGljIG9yIFJORyBpbnN0cnVjdGlvbnMgdGhhdCBoYXZlIGJlZW4gcHJlc2Vu
dCBpblpoYW94aW4gcHJvY2Vzc29ycyBidXQgbm90IHlldCBhZHZlcnRpc2VkIGJ5IEtW
TS5BbGwgaW5zdHJ1Y3Rpb25zIGNvdmVyZWQgaGVyZSBhcmUgdXNlci1tb2RlIGFuZCBh
dmFpbGFibGUgaW4gYWxsIENQVW1vZGVzIChyZWFsIC8gVjg2IC8gY29tcGF0IC8gcHJv
dGVjdGVkIC8gbG9uZyksIHdpdGggbm8gYXNzb2NpYXRlZCBNU1Jjb250cm9sLiBFYWNo
IGZlYXR1cmUgaXMgcmVwb3J0ZWQgYXMgYSAoWCwgWF9FTikgcGFpciB3aGVyZSB0aGUg
dHdvYml0cyBhcmUgcmVkdW5kYW50IGJ5IGhhcmR3YXJlIGRlc2lnbiAoc2V0IG9yIGNs
ZWFyZWQgdG9nZXRoZXIpLCBhbmQgYm90aGFyZSBDUFVJRC1sZXZlbCByZXBvcnRpbmcg
Yml0cyByZXF1aXJpbmcgbm8gS1ZNIGVtdWxhdGlvbi5UaGUgZml2ZSBmZWF0dXJlIGdy
b3VwczoxLiBTTTIgKGJpdHMgMCwgMSk6IFNNMiBlbGxpcHRpYy1jdXJ2ZSBwdWJsaWMt
a2V5IGNyeXB0b2dyYXBoeSBhbGdvcml0aG0gICBwZXIgR00vVCAwMDAzLTIwMTIuIFVz
ZWQgZm9yIGtleSBnZW5lcmF0aW9uLCBlbmNyeXB0aW9uL2RlY3J5cHRpb24sICAgZGln
aXRhbCBzaWduYXR1cmVzLCBhbmQga2V5IGV4Y2hhbmdlIGluIENoaW5lc2UgY3J5cHRv
Z3JhcGhpYyAgIHN0YW5kYXJkcy4yLiBDQ1MgKGJpdHMgNCwgNSk6IFNNMyBoYXNoIGFs
Z29yaXRobSBwZXIgR00vVCAwMDA0LTIwMTIgYW5kIFNNNCBibG9jayAgIGNpcGhlciBw
ZXIgR00vVCAwMDAyLTIwMTIgKHN1cHBvcnRzIEVDQiAvIENCQyAvIENGQiAvIE9GQiAv
IENUUiBwbHVzICAgQ0JDLU1BQyAvIENGQi1NQUMpLiBGb3VuZGF0aW9uYWwgcHJpbWl0
aXZlcyBmb3IgQ2hpbmVzZSBjcnlwdG9ncmFwaGljICAgcHJvdG9jb2xzLjMuIFJORzIg
KGJpdHMgMjIsIDIzKTogU2Vjb25kLWdlbmVyYXRpb24gaGFyZHdhcmUgUk5HIGV4cG9z
ZWQgdmlhIHRoZSAgIFJFUCBYUk5HMiBpbnN0cnVjdGlvbi4gVHdvIG9uLWRpZSBSTkcg
c291cmNlcyBzZWxlY3RhYmxlIHBlciBjYWxsLCAgIHdpdGggcmF3IGFuZCBwb3N0LXBy
b2Nlc3NlZCBvdXRwdXQgbW9kZXMuIFByb3ZpZGVzIGhpZ2gtcXVhbGl0eSAgIGVudHJv
cHkgZm9yIGNyeXB0b2dyYXBoaWMgb3BlcmF0aW9ucy40LiBQSEUyIChiaXRzIDI1LCAy
Nik6IFNIQS0zODQgYW5kIFNIQS01MTIgaGFyZHdhcmUgYWNjZWxlcmF0aW9uIHBlciAg
IEZJUFMgMTgwLTMsIGV4cG9zZWQgdmlhIFJFUCBYU0hBMzg0IGFuZCBSRVAgWFNIQTUx
Mi4gVXNlZCBieSBUTFMsICAgU1NILCBmaWxlIGludGVncml0eSwgYW5kIHNpZ25hdHVy
ZSBzY2hlbWVzLjUuIFJTQSAoYml0cyAyNywgMjgpOiBCaWctbnVtYmVyIG1vZHVsYXIg
ZXhwb25lbnRpYXRpb24gKFJFUCBYTU9ERVhQLCAgIEFeQiBtb2QgTSkgYW5kIG1vZHVs
YXIgbXVsdGlwbGljYXRpb24gKFJFUCBNT05UTVVMMiwgQSpCIG1vZCBNKSwgICBzdXBw
b3J0aW5nIG9wZXJhbmQgc2l6ZXMgZnJvbSAyNTYgdG8gMzI3NjggYml0cy4gVXNlZCBm
b3IgUlNBIGFuZCAgIHJlbGF0ZWQgcHVibGljLWtleSBvcGVyYXRpb25zLlJlZmVyZW5j
ZXM6ICBUaGUgaW5zdHJ1Y3Rpb24gZW5jb2RpbmdzLCBjb250cm9sLXdvcmQgZm9ybWF0
cywgYW5kIHBlci1mZWF0dXJlICBzZW1hbnRpY3MgcmVmZXJlbmNlZCBpbiB0aGUgaW5k
aXZpZHVhbCBwYXRjaGVzIGFyZSBkb2N1bWVudGVkIGluOiAgICAtIEdNSSBJbnN0cnVj
dGlvbiBTZXQgUmVmZXJlbmNlIChTTTIgLyBTTTMgLyBTTTQpICAgIC0gUGFkTG9jayBJ
bnN0cnVjdGlvbiBSZWZlcmVuY2UgKFhSTkcyIC8gWFNIQTM4NCAvIFhTSEE1MTIgLyAg
ICAgIFhNT0RFWFAgLyBNT05UTVVMMikgIEJvdGggYXZhaWxhYmxlIGZyb20gaHR0cHM6
Ly9raWIua2lldi51YS94ODZkb2NzL1poYW94aW4vRXdhbmhhaW9jICg1KTogIEtWTTog
eDg2OiBFeHBvc2UgWmhhb3hpbiBTTTIgQ1BVSUQgZmVhdHVyZSAgS1ZNOiB4ODY6IEV4
cG9zZSBaaGFveGluIENDUyAoU00zICsgU000KSBDUFVJRCBmZWF0dXJlICBLVk06IHg4
NjogRXhwb3NlIFpoYW94aW4gUk5HMiBDUFVJRCBmZWF0dXJlICBLVk06IHg4NjogRXhw
b3NlIFpoYW94aW4gUEhFMiBDUFVJRCBmZWF0dXJlICBLVk06IHg4NjogRXhwb3NlIFpo
YW94aW4gUlNBIENQVUlEIGZlYXR1cmUgYXJjaC94ODYva3ZtL2NwdWlkLmMgICAgICAg
ICB8IDEwICsrKysrKysrKysgYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaCB8IDEy
ICsrKysrKysrKysrKyAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyliYXNl
LWNvbW1pdDogNTA4OTdjOTU1OTAyYzkzYWU3MWMzODY5OGFiYjkxMDUyNWViZGM4OS0t
Mi4zNC4xCgoKCgrkv53lr4blo7DmmI4K5pys6YKu5Lu25ZCr5pyJ5L+d5a+G5oiW5LiT
5pyJ5L+h5oGv77yM5LuF5L6b5oyH5a6a5pS25Lu25Lq65L2/55So44CC5Lil56aB5a+5
5pys6YKu5Lu25oiW5YW25YaF5a655YGa5Lu75L2V5pyq57uP5o6I5p2D55qE5p+l6ZiF
44CB5L2/55So44CB5aSN5Yi25oiW6L2s5Y+R44CCCgpUaGlzIGVtYWlsIGNvbnRhaW5z
IGNvbmZpZGVudGlhbCBvciBsZWdhbGx5IHByaXZpbGVnZWQgaW5mb3JtYXRpb24gYW5k
IGlzIGZvciB0aGUgc29sZSB1c2Ugb2YgaXRzIGludGVuZGVkIHJlY2lwaWVudC4gQW55
IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgY29weWluZyBvciBmb3J3YXJkaW5nIG9m
IHRoaXMgZW1haWwgb3IgdGhlIGNvbnRlbnQgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLg==

