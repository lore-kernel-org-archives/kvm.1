Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D23769E7;
	Tue,  8 Sep 2026 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848009; cv=none; b=VhK23LybBfn4xfrLtJs8iireIZy4Mr+FeMtasYPdKUiWkon2EIZ0fxFv2rnlrN1vT47TFHq+luCvSmXgtl++Oa/D20KVc3jH9TQfsi6WEFKyrW0n+jV9/TdOXldD5jNkxR0jN/u0BmFuGhK7dMXvefCxKUV428xPDxBSLuhHJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848009; c=relaxed/simple;
	bh=6xfkiSnxJMe13C0cNqDcgAD0WvwPmDl8XXmZekWjLzg=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=e1dqWt2o9xLrk5ytfX/Oabi2n4t4iq/oAtTv5OVqhWJeuInKWtYjzL2UJc67WZav6SphFtl1XpLXIfThm2vmwhSUEaDfeQoyXuqE9i7UwjQWT8KAv0CAA1CpKkrDBc6FY0ha/s4fFLPC5CoFahvTS4MNNfqjZ8zl6HnXLcoDU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tGaDRJUq; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tGaDRJUq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788848003; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=6xfkiSnxJMe13C0cNqDcgAD0WvwPmDl8XXmZekWjLzg=;
	b=tGaDRJUqxgV4STUSlYZZI8f8nOG7pGM5eifpbIXeDrtO1OpOX0EB+OKrBW7TTwjyevqm1o3f2bYQ73HXb12wzUK+rv4L3mGNiCAtHIBKubIXnh9OiMknNsi5iPZTQZeLCMnag/KVH/78BmwlLsbWYlMbvLP1EXIZI13NOX1XW3w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hao.xiang@linux.alibaba.com;NM=1;PH=DW;RN=8;SR=0;TI=alimail_imapd_hao.xiang@linux.alibaba.com-33.40.2.50-1229-1788840263;
Received: from WS-web (hao.xiang@linux.alibaba.com[alimail_imapd_hao.xiang@linux.alibaba.com-33.40.2.50-1229-1788840263] cluster:ay36) at Tue, 08 Sep 2026 14:13:17 +0800
Date: Tue, 08 Sep 2026 14:13:17 +0800
From: "Hao Xiang" <hao.xiang@linux.alibaba.com>
To: "kvm" <kvm@vger.kernel.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "xianghao.xiang" <xianghao.xiang@alibaba-inc.com>,
  "hao.xiang" <hao.xiang@linux.alibaba.com>,
  "zhao1.liu" <zhao1.liu@intel.com>,
  "seanjc" <seanjc@google.com>,
  "pbonzini" <pbonzini@redhat.com>,
  "shannon.zhao" <shannon.zhao@linux.alibaba.com>
Reply-To: "Hao Xiang" <hao.xiang@linux.alibaba.com>
Message-ID: <45146bc1-0d78-46de-8bd8-cb1ecba49fe2.hao.xiang@linux.alibaba.com>
Subject: =?UTF-8?B?W1BBVENIXSBpMzg2L2NwdTogUmVuYW1lIENQVUlEIGZlYXR1cmUgYml0IEFWWDEwX1ZOTklf?=
  =?UTF-8?B?SU5UIHRvIEFWWDEwX1YxX0FVWA==?=
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
VVggdG8gYWNjb3VudApmb3IgYWRkaXRpb25hbCBBVlgxMC4yIGlzbnRydWN0aW9ucyBzZXAtYXJh
dGVkIHRvIGhhdmUg4oCdT1LigJ0gc2Vuc2l0aXZpdHkKZm9yIHBsYXRmb3JtcyB3aGljaCBtYXkg
bm90IHN1cHBvcnQgYWxsIG9mIEFWWDEwLjJbKl0uIFRoaXMgQ1BVSUQgYml0IG5vdwphcHBsaWVz
IHRvIHRoZSBmb2xsb3dpbmcgVk5OSSBpbnN0cnVjdGlvbnM6IFZQRFBCW1NVLFVVLFNTXURbLFNd
ClZQRFBXW1NVLFVTLFVVXURbLFNdLCBhcyB3ZWxsIGFzIHRoZSBmb2xsb3dpbmcgY29udmVydCBp
bi1zdHJ1Y3Rpb25zOgpWQ1ZUWywyXVBIMltCLEhdRjhbLFNdLCBWQ1ZUMlBTMlBIWCwgVkNWVC1C
SUFTUEgyW0IsSF1GOFssU10sClZDVlRIRjgyUEguCgpbKl06IEludGVswq4gQWR2YW5jZWQgVmVj
dG9yIEV4dGVuc2lvbnMgMTAuMiBBcmNoaXRlY3R1cmUgU3BlY2lmaWNhdGlvbgogICAgICAocmV2
IDcuMCkuCgpTaWduZWQtb2ZmLWJ5OiBIYW8gWGlhbmcgPGhhby54aWFuZ0BsaW51eC5hbGliYWJh
LmNvbT4KLS0tCiAgYXJjaC94ODYva3ZtL2NwdWlkLmMgICAgICAgICB8IDIgKy0KICBhcmNoL3g4
Ni9rdm0vcmV2ZXJzZV9jcHVpZC5oIHwgMiArLQogIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9jcHVpZC5j
IGIvYXJjaC94ODYva3ZtL2NwdWlkLmMKaW5kZXggODUxZjE1MWVmYjM1Li4xZTViZjZmZmY5Yzkg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9jcHVpZC5jCisrKyBiL2FyY2gveDg2L2t2bS9jcHVp
ZC5jCkBAIC0xMDk1LDcgKzEwOTUsNyBAQCB2b2lkIGt2bV9pbml0aWFsaXplX2NwdV9jYXBzKHZv
aWQpCiAgICAgICk7CgogICAgICBrdm1fY3B1X2NhcF9pbml0KENQVUlEXzI0XzFfRUNYLAotICAg
ICAgICBGKEFWWDEwX1ZOTklfSU5UKSwKKyAgICAgICAgRihBVlgxMF9WMV9BVVgpLAogICAgICAp
OwoKICAgICAga3ZtX2NwdV9jYXBfaW5pdChDUFVJRF84MDAwXzAwMDFfRUNYLApkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQuaCBiL2FyY2gveDg2L2t2bS9yZXZlcnNlX2Nw
dWlkLmgKaW5kZXggMmFkMjU3ODFjZWZiLi44OTM0NWFmMGY3YWQgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L2t2bS9yZXZlcnNlX2NwdWlkLmgKKysrIGIvYXJjaC94ODYva3ZtL3JldmVyc2VfY3B1aWQu
aApAQCAtNjYsNyArNjYsNyBAQAogICNkZWZpbmUgWDg2X0ZFQVRVUkVfQVZYMTBfNTEyIEtWTV9Y
ODZfRkVBVFVSRShDUFVJRF8yNF8wX0VCWCwgMTgpCgogIC8qIEludGVsLWRlZmluZWQgc3ViLWZl
YXR1cmVzLCBDUFVJRCBsZXZlbCAweDAwMDAwMDI0OjEgKEVDWCkgKi8KLSNkZWZpbmUgWDg2X0ZF
QVRVUkVfQVZYMTBfVk5OSV9JTlQgS1ZNX1g4Nl9GRUFUVVJFKENQVUlEXzI0XzFfRUNYLCAyKQor
I2RlZmluZSBYODZfRkVBVFVSRV9BVlgxMF9WMV9BVVggICAgS1ZNX1g4Nl9GRUFUVVJFKENQVUlE
XzI0XzFfRUNYLCAyKQoKICAvKiBDUFVJRCBsZXZlbCAweDgwMDAwMDA3IChFRFgpLiAqLwogICNk
ZWZpbmUgS1ZNX1g4Nl9GRUFUVVJFX0NPTlNUQU5UX1RTQyAKS1ZNX1g4Nl9GRUFUVVJFKENQVUlE
XzgwMDBfMDAwN19FRFgsIDgpCi0tCjIuMzIuMC4zLmcwMTE5NWNmOWY=
