Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353A4B2034;
	Tue,  8 Sep 2026 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868507; cv=none; b=nr39MeW/UEUxex8qRG3qFJwVLnnSRtmB2+LMiWNljlLgdFwb1QRyLldf5m3uPG9wvS79GgF7SHfW8C9MWef/JL7VuZoWepka3WkXp20xoTQ2duPTwuGd/0DIRaNmi321BtqjIx7BqpjwIQnjPbs/Aj1ifd9T+3aE5iQwkwAZtnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868507; c=relaxed/simple;
	bh=GlchHilSuYxihqu+rx5of6L1xCdUFMil/SQAFnKfeso=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=ZSAJYg0a84isMhD5qSbJLNWkYsvh6SsOlQUfxz+znX91Hir6QWPp+pPrjW4Eab6/J8AmqI8LwjAFC0qPiSxaQOEAOClak2gBZbV2x5qTkqPawzbNxcXMrJrcePnerjFW+C04GxY1OQkrA0X8lLsDmIkjnKNMtMVvGw5wYH2lSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eJXPGR+1; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eJXPGR+1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788868496; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=GlchHilSuYxihqu+rx5of6L1xCdUFMil/SQAFnKfeso=;
	b=eJXPGR+1WbMRb+2+0nQ8iVFiMPfiweOrmHnPRbGkHcxxi+vc8mDoxOJjDh7Z35arJqFJQ4+5JUVcJSx8dPS6O1l8i/TROYDABuEsmapCkPBqPJ7ZtlxXx3MRHebvKFYk7+gF4sSJJtnFk2vmW/YhnmZsGFWET1GhCCYyD/qStxs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hao.xiang@linux.alibaba.com;NM=1;PH=DW;RN=7;SR=0;TI=alimail_imapd_hao.xiang@linux.alibaba.com-33.37.18.4-3193-1788866799;
Received: from WS-web (hao.xiang@linux.alibaba.com[alimail_imapd_hao.xiang@linux.alibaba.com-33.37.18.4-3193-1788866799] cluster:ay36) at Tue, 08 Sep 2026 19:54:51 +0800
Date: Tue, 08 Sep 2026 19:54:51 +0800
From: "Hao Xiang" <hao.xiang@linux.alibaba.com>
To: "kvm" <kvm@vger.kernel.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "zhao1.liu" <zhao1.liu@intel.com>,
  "seanjc" <seanjc@google.com>,
  "pbonzini" <pbonzini@redhat.com>,
  "shannon.zhao" <shannon.zhao@linux.alibaba.com>,
  "hao.xiang" <hao.xiang@linux.alibaba.com>
Reply-To: "Hao Xiang" <hao.xiang@linux.alibaba.com>
Message-ID: <047d5e3a-b64d-434c-9a40-140468441de2.hao.xiang@linux.alibaba.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBLVk06IHg4NjogUmVuYW1lIENQVUlEIGZlYXR1cmUgYml0IEFWWDEwX1ZO?=
  =?UTF-8?B?TklfSU5UIHRvIEFWWDEwX1YxX0FVWA==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1Mi4wLjAuMCBTYWZhcmkvNTM3LjM2La
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Q1BVSUQgZmVhdHVyZSBiaXQgQVZYMTBfVk5OSV9JTlQgaXMgcmVuYW1lZCB0byBBVlgxMF9WMV9B
VVggdG8gYWNjb3VudApmb3IgYWRkaXRpb25hbCBBVlgxMC4yIGluc3RydWN0aW9ucyBzZXBhcmF0
ZWQgdG8gaGF2ZSDigJ1PUuKAnSBzZW5zaXRpdml0eQpmb3IgcGxhdGZvcm1zIHdoaWNoIG1heSBu
b3Qgc3VwcG9ydCBhbGwgb2YgQVZYMTAuMlsqXS4gVGhpcyBDUFVJRCBiaXQgbm93CmFwcGxpZXMg
dG8gdGhlIGZvbGxvd2luZyBWTk5JIGluc3RydWN0aW9uczogVlBEUEJbU1UsVVUsU1NdRFssU10K
VlBEUFdbU1UsVVMsVVVdRFssU10sIGFzIHdlbGwgYXMgdGhlIGZvbGxvd2luZyBjb252ZXJ0IGlu
c3RydWN0aW9uczoKVkNWVFssMl1QSDJbQixIXUY4WyxTXSwgVkNWVDJQUzJQSFgsIFZDVlQtQklB
U1BIMltCLEhdRjhbLFNdLApWQ1ZUSEY4MlBILgoKWypdOiBJbnRlbMKuIEFkdmFuY2VkIFZlY3Rv
ciBFeHRlbnNpb25zIDEwLjIgQXJjaGl0ZWN0dXJlIFNwZWNpZmljYXRpb24KIMKgIMKgIMKgKHJl
diA3LjApLgoKU2lnbmVkLW9mZi1ieTogSGFvIFhpYW5nIDxoYW8ueGlhbmdAbGludXguYWxpYmFi
YS5jb20+ClJldmlld2VkLWJ5OiBaaGFvIExpdSA8emhhbzEubGl1QGludGVsLmNvbT4KLS0tCnYx
IC0+IHYyOgogwqAtIEZpeCB0eXBvcyBpbiBjb21taXQgbWVzc2FnZS4KIMKgLSBDaGFuZ2Ugc3Vi
amVjdCBwcmVmaXggZnJvbSAiaTM4Ni9jcHU6IiB0byAiS1ZNOiB4ODY6IiBwZXIKIMKgIMKgRG9j
dW1lbnRhdGlvbi9wcm9jZXNzL21haW50YWluZXIta3ZtLXg4Ni5yc3QuCiDCoC0gQWRkIFJldmll
d2VkLWJ5IGZyb20gWmhhbyBMaXUuCgogwqBhcmNoL3g4Ni9rdm0vY3B1aWQuY8KgIMKgIMKgIMKg
IMKgfCAyICstCiDCoGFyY2gveDg2L2t2bS9yZXZlcnNlX2NwdWlkLmggfCAyICstCiDCoDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2t2bS9jcHVpZC5jIGIvYXJjaC94ODYva3ZtL2NwdWlkLmMKaW5kZXggODUxZjE1
MWVmYjM1Li4xZTViZjZmZmY5YzkgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9jcHVpZC5jCisr
KyBiL2FyY2gveDg2L2t2bS9jcHVpZC5jCkBAIC0xMDk1LDcgKzEwOTUsNyBAQCB2b2lkIGt2bV9p
bml0aWFsaXplX2NwdV9jYXBzKHZvaWQpCiDCoCDCoCDCoCk7CgogwqAgwqAgwqBrdm1fY3B1X2Nh
cF9pbml0KENQVUlEXzI0XzFfRUNYLAotwqAgwqAgwqAgwqAgRihBVlgxMF9WTk5JX0lOVCksCivC
oCDCoCDCoCDCoCBGKEFWWDEwX1YxX0FVWCksCiDCoCDCoCDCoCk7CgogwqAgwqAgwqBrdm1fY3B1
X2NhcF9pbml0KENQVUlEXzgwMDBfMDAwMV9FQ1gsCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
cmV2ZXJzZV9jcHVpZC5oIGIvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaAppbmRleCAyYWQy
NTc4MWNlZmIuLjg5MzQ1YWYwZjdhZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3JldmVyc2Vf
Y3B1aWQuaAorKysgYi9hcmNoL3g4Ni9rdm0vcmV2ZXJzZV9jcHVpZC5oCkBAIC02Niw3ICs2Niw3
IEBACiDCoCNkZWZpbmUgWDg2X0ZFQVRVUkVfQVZYMTBfNTEyIEtWTV9YODZfRkVBVFVSRShDUFVJ
RF8yNF8wX0VCWCwgMTgpCgogwqAvKiBJbnRlbC1kZWZpbmVkIHN1Yi1mZWF0dXJlcywgQ1BVSUQg
bGV2ZWwgMHgwMDAwMDAyNDoxIChFQ1gpICovCi0jZGVmaW5lIFg4Nl9GRUFUVVJFX0FWWDEwX1ZO
TklfSU5UIEtWTV9YODZfRkVBVFVSRShDUFVJRF8yNF8xX0VDWCwgMikKKyNkZWZpbmUgWDg2X0ZF
QVRVUkVfQVZYMTBfVjFfQVVYIEtWTV9YODZfRkVBVFVSRShDUFVJRF8yNF8xX0VDWCwgMikKCiDC
oC8qIENQVUlEIGxldmVsIDB4ODAwMDAwMDcgKEVEWCkuICovCiDCoCNkZWZpbmUgS1ZNX1g4Nl9G
RUFUVVJFX0NPTlNUQU5UX1RTQyAKS1ZNX1g4Nl9GRUFUVVJFKENQVUlEXzgwMDBfMDAwN19FRFgs
IDgpCi0tCjIuMzIuMC4zLmcwMTE5NWNmOWYK
