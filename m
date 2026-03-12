Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD11A0BE0;
	Thu, 12 Mar 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773278476; cv=none; b=m4RNGlZHg2MaAIOoIyJfjMrFO2a8n9TJjFz3wt7BxU+ZnKLNGkcYOs9GYwxY5jiysJiW2AAgQu9GxVwANgnUwNS76Umt1ehuKPWCFAOTsCCDmDfQwc5BgQwLeinX7gsbo93oJGlIlvlY98EKzEZl1/lZriXO2WQ4CgdxcorXCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773278476; c=relaxed/simple;
	bh=oh1+8b7GuUmvbpFIKFecxxZDxb8D+SH1xP7FVacf9Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=LOgwbodYB58fpkyozd48GEOWd8vcQ2grM98HcwEX9JD2XY8cLJ9PP6NA3jLy2TPPgqnx7642jdM9n7vyxYt5ViAAHMR8VeogIitvCgTeDT/lCr0O62U/BC//Au++Rpfo8pCA2IP99ngKdAPbhg2JB0vgbozTu9yv6eUN2Ii/7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from xujiakai2025$iscas.ac.cn ( [210.73.43.101] ) by
 ajax-webmail-APP-12 (Coremail) ; Thu, 12 Mar 2026 09:20:45 +0800
 (GMT+08:00)
Date: Thu, 12 Mar 2026 09:20:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jiakai Xu" <xujiakai2025@iscas.ac.cn>
To: "Andrew Jones" <andrew.jones@oss.qualcomm.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, "Albert Ou" <aou@eecs.berkeley.edu>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, 
	"Andrew Jones" <ajones@ventanamicro.com>, 
	"Anup Patel" <anup@brainfault.org>, 
	"Atish Patra" <atish.patra@linux.dev>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>, 
	"Paul Walmsley" <pjw@kernel.org>, "Shuah Khan" <shuah@kernel.org>, 
	"Jiakai Xu" <jiakaiPeanut@gmail.com>
Subject: Re: Re: [PATCH v3 1/2] RISC-V: KVM: Fix array out-of-bounds in
 pmu_ctr_read() and pmu_fw_ctr_read_hi()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <2apicvahmomu57i7gjd2cgc5cakq4pxsbphz5xnl4cr2sqvp72@hqud4u6bo53b>
References: <20260310055557.835531-1-xujiakai2025@iscas.ac.cn>
 <20260310055557.835531-2-xujiakai2025@iscas.ac.cn>
 <2apicvahmomu57i7gjd2cgc5cakq4pxsbphz5xnl4cr2sqvp72@hqud4u6bo53b>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <70069435.611f3.19cdfa1bfed.Coremail.xujiakai2025@iscas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:tgCowAC3wtLtFLJpJeEVAA--.7213W
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBg0ECWmx5lWRSAABs1
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgZHJldywKClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4gCkknbGwgZml4
IHRoZSBhbGlnbm1lbnQgYW5kIHNlbmQgdjQgc2hvcnRseS4KCkJlc3QsCkppYWthaQoKJnF1b3Q7
QW5kcmV3IEpvbmVzJnF1b3Q7ICZsdDthbmRyZXcuam9uZXNAb3NzLnF1YWxjb21tLmNvbSZndDt3
cm90ZToKPiBPbiBUdWUsIE1hciAxMCwgMjAyNiBhdCAwNTo1NTo1NkFNICswMDAwLCBKaWFrYWkg
WHUgd3JvdGU6Cj4gPiBXaGVuIGEgZ3Vlc3QgaW52b2tlcyBTQklfRVhUX1BNVV9DT1VOVEVSX0ZX
X1JFQUQgb3IKPiA+IFNCSV9FWFRfUE1VX0NPVU5URVJfRldfUkVBRF9ISSBvbiBhIGZpcm13YXJl
IGNvdW50ZXIgdGhhdCBoYXMgbm90IGJlZW4KPiA+IGNvbmZpZ3VyZWQgdmlhIFNCSV9FWFRfUE1V
X0NPVU5URVJfQ0ZHX01BVENILCB0aGUgcG1jLT5ldmVudF9pZHggcmVtYWlucwo+ID4gU0JJX1BN
VV9FVkVOVF9JRFhfSU5WQUxJRCAoMHhGRkZGRkZGRikuIGdldF9ldmVudF9jb2RlKCkgZXh0cmFj
dHMgdGhlCj4gPiBsb3dlciAxNiBiaXRzLCB5aWVsZGluZyAweEZGRkYgKDY1NTM1KSwgd2hpY2gg
aXMgdGhlbiB1c2VkIHRvIGluZGV4IGludG8KPiA+IGt2cG11LT5md19ldmVudFtdLiBTaW5jZSBm
d19ldmVudCBpcyBvbmx5IFJJU0NWX0tWTV9NQVhfRldfQ1RSUyAoMzIpCj4gPiBlbnRyaWVzLCB0
aGlzIHRyaWdnZXJzIGFuIGFycmF5LWluZGV4LW91dC1vZi1ib3VuZHM6Cj4gPiAKPiA+ICAgVUJT
QU46IGFycmF5LWluZGV4LW91dC1vZi1ib3VuZHMgaW4gYXJjaC9yaXNjdi9rdm0vdmNwdV9wbXUu
YzoyNTU6MzcKPiA+ICAgaW5kZXggNjU1MzUgaXMgb3V0IG9mIHJhbmdlIGZvciB0eXBlICdrdm1f
ZndfZXZlbnQgWzMyXScKPiA+IAo+ID4gQWRkIGEgY2hlY2sgZm9yIHRoZSBrbm93biB1bmNvbmZp
Z3VyZWQgY2FzZSAoU0JJX1BNVV9FVkVOVF9JRFhfSU5WQUxJRCkKPiA+IGFuZCBhIFdBUk5fT05D
RSBndWFyZCBmb3IgYW55IHVuZXhwZWN0ZWQgb3V0LW9mLWJvdW5kcyBldmVudCBjb2RlcywKPiA+
IHJldHVybmluZyAtRUlOVkFMIGluIGJvdGggY2FzZXMuCj4gPiAKPiA+IEZpeGVzOiBiYWRjMzg2
ODY5ZTJjICgiUklTQy1WOiBLVk06IFN1cHBvcnQgZmlybXdhcmUgZXZlbnRzIikKPiA+IEZpeGVz
OiAwOGZiMDdkNmRjZjcxICgiUklTQy1WOiBLVk06IFN1cHBvcnQgNjQgYml0IGZpcm13YXJlIGNv
dW50ZXJzIG9uIFJWMzIiKQo+ID4gU2lnbmVkLW9mZi1ieTogSmlha2FpIFh1IDx4dWppYWthaTIw
MjVAaXNjYXMuYWMuY24+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFrYWkgWHUgPGppYWthaVBlYW51
dEBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+IFYyIC0+IFYzOgo+ID4gLSBBZGRlZCBjaGVjayBmb3Ig
U0JJX1BNVV9FVkVOVF9JRFhfSU5WQUxJRC4KPiA+IC0gQWRkZWQgV0FSTl9PTkNFIGZvciB1bmV4
cGVjdGVkIG91dC1vZi1ib3VuZHMgZXZlbnQgY29kZXMuCj4gPiBWMSAtPiBWMjoKPiA+IC0gTWVy
Z2VkIHRoZSBmaXhlcyBmb3IgcG11X2N0cl9yZWFkKCkgYW5kIHBtdV9md19jdHJfcmVhZF9oaSgp
IGludG8gYSBzaW5nbGUKPiA+IGNvbW1pdC4KPiA+IC0gUmVtb3ZlZCB0aGUgcHJfd2Fybiwgc2lt
cGx5IHJldHVybmluZyAtRUlOVkFMIGluc3RlYWQuCj4gPiAtLS0KPiA+ICBhcmNoL3Jpc2N2L2t2
bS92Y3B1X3BtdS5jIHwgMTQgKysrKysrKysrKysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rdm0vdmNwdV9w
bXUuYyBiL2FyY2gvcmlzY3Yva3ZtL3ZjcHVfcG11LmMKPiA+IGluZGV4IGU4NzM0MzBlNTk2Yi4u
Yzg3YTdiMDAzN2NmIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9yaXNjdi9rdm0vdmNwdV9wbXUuYwo+
ID4gKysrIGIvYXJjaC9yaXNjdi9rdm0vdmNwdV9wbXUuYwo+ID4gQEAgLTIyNiw3ICsyMjYsMTQg
QEAgc3RhdGljIGludCBwbXVfZndfY3RyX3JlYWRfaGkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1
bnNpZ25lZCBsb25nIGNpZHgsCj4gPiAgCWlmIChwbWMtPmNpbmZvLnR5cGUgIT0gU0JJX1BNVV9D
VFJfVFlQRV9GVykKPiA+ICAJCXJldHVybiAtRUlOVkFMOwo+ID4gIAo+ID4gKwlpZiAocG1jLT5l
dmVudF9pZHggPT0gU0JJX1BNVV9FVkVOVF9JRFhfSU5WQUxJRCkKPiA+ICsJCXJldHVybiAtRUlO
VkFMOwo+ID4gKwo+ID4gIAlmZXZlbnRfY29kZSA9IGdldF9ldmVudF9jb2RlKHBtYy0+ZXZlbnRf
aWR4KTsKPiA+ICsJaWYgKFdBUk5fT05DRShmZXZlbnRfY29kZSA+PSBTQklfUE1VX0ZXX01BWCwK
PiA+ICsJCQkJICAiSW52YWxpZCBmaXJtd2FyZSBldmVudCBjb2RlOiAlZFxuIiwgZmV2ZW50X2Nv
ZGUpKQo+IAo+IEFsaWduIHVuZGVyIHByZXZpb3VzIHBhcmFtZXRlciwgbm90IHRoZSA+PSBvcGVy
YXRvcgo+IAo+ICBpZiAoV0FSTl9PTkNFKGZldmVudF9jb2RlID49IFNCSV9QTVVfRldfTUFYLAo+
ICAgICAgIkludmFsaWQgZmlybXdhcmUgZXZlbnQgY29kZTogJWRcbiIsIGZldmVudF9jb2RlKSkK
PiAKPiA+ICsJCXJldHVybiAtRUlOVkFMOwo+ID4gKwo+ID4gIAlwbWMtPmNvdW50ZXJfdmFsID0g
a3ZwbXUtPmZ3X2V2ZW50W2ZldmVudF9jb2RlXS52YWx1ZTsKPiA+ICAKPiA+ICAJKm91dF92YWwg
PSBwbWMtPmNvdW50ZXJfdmFsID4+IDMyOwo+ID4gQEAgLTI1MSw3ICsyNTgsMTQgQEAgc3RhdGlj
IGludCBwbXVfY3RyX3JlYWQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBsb25nIGNp
ZHgsCj4gPiAgCXBtYyA9ICZrdnBtdS0+cG1jW2NpZHhdOwo+ID4gIAo+ID4gIAlpZiAocG1jLT5j
aW5mby50eXBlID09IFNCSV9QTVVfQ1RSX1RZUEVfRlcpIHsKPiA+ICsJCWlmIChwbWMtPmV2ZW50
X2lkeCA9PSBTQklfUE1VX0VWRU5UX0lEWF9JTlZBTElEKQo+ID4gKwkJCXJldHVybiAtRUlOVkFM
Owo+ID4gKwo+ID4gIAkJZmV2ZW50X2NvZGUgPSBnZXRfZXZlbnRfY29kZShwbWMtPmV2ZW50X2lk
eCk7Cj4gPiArCQlpZiAoV0FSTl9PTkNFKGZldmVudF9jb2RlID49IFNCSV9QTVVfRldfTUFYLAo+
ID4gKwkJCQkJICAiSW52YWxpZCBmaXJtd2FyZSBldmVudCBjb2RlOiAlZFxuIiwgZmV2ZW50X2Nv
ZGUpKQo+ID4gKwkJCXJldHVybiAtRUlOVkFMOwo+ID4gKwo+ID4gIAkJcG1jLT5jb3VudGVyX3Zh
bCA9IGt2cG11LT5md19ldmVudFtmZXZlbnRfY29kZV0udmFsdWU7Cj4gPiAgCX0gZWxzZSBpZiAo
cG1jLT5wZXJmX2V2ZW50KSB7Cj4gPiAgCQlwbWMtPmNvdW50ZXJfdmFsICs9IHBlcmZfZXZlbnRf
cmVhZF92YWx1ZShwbWMtPnBlcmZfZXZlbnQsICZlbmFibGVkLCAmcnVubmluZyk7Cj4gPiAtLSAK
PiA+IDIuMzQuMQo+ID4KPiAKPiBPdGhlcndpc2UsCj4gCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBK
b25lcyA8YW5kcmV3LmpvbmVzQG9zcy5xdWFsY29tbS5jb20+Cg==
