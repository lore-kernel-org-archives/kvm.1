Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935F287268
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014413; cv=none; b=ZR/9WsbKUhLoYR0+SfnIiUEFjc8cQJPQ8W8hPwKLBI1JuD/r4dURZsIZphI6ypKCpP83KSxNlInq30Qo2CaA9PTEKrEWlhgqY31s73b6zzdbD2zT7/axH/jzTmTP+kAYYx+HDwtFbaoZ9lBpgcIA4r+zMHymxUxldxT213n/bVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014413; c=relaxed/simple;
	bh=DZnAMrw3PPBlBcqzvCH/Myvvjva2TowaJpIWEjZ47+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSeDdSq3o58JPPdN/iVfr+grRdDwl92lRZ57zvqU8nxUCklL14Ti5RsN2/1gRpkMFcqEcIN343dIAyfUkLh7nnVcTu00wlKnh0jP6+oe24bjdwkLTXm5WaarVZzok/5yOMqDxsm0X+p0iWVn2sitEVIYGYKuHJ+UIz7DshK+rJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=JyuIi+GE; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="JyuIi+GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014412; x=1812550412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DZnAMrw3PPBlBcqzvCH/Myvvjva2TowaJpIWEjZ47+A=;
  b=JyuIi+GEvJMkPhoKoibmadDuH6GFJHIuik+5uO2votY6Bnn1jYcevQmL
   KemQV50QNtEThLddem7mLSuQHDhc78JruVZEMkY4VKwHGKosPNVXw3mqg
   sofrIdY/LdrzcWQq37D8cflpYIdIAXzu7sTsrLuzAsisurLhk/kaWcoGg
   MJCvLwnyMDcsv8OvQ14MtqxLedMybVXsgJSHFUrU66LlTrjsqXRlzANxs
   aSg1sOIILqSEWVF/OuzJbmem2gwG0P4yUSNf8YP0S+tktuamUK+askxvz
   PhvzubCR07Z7MwzSSlFjqlF29vMmHucIK9FRVez35b70MsUaMO5FOT26J
   g==;
X-CSE-ConnectionGUID: TsvhufpWReCD7FokxQgfHA==
X-CSE-MsgGUID: JQWrlIgVR+GEU7QY3WdFSw==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21275573"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:13:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:12265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.151:2525] with esmtp (Farcaster)
 id 25ae78e1-deca-4924-a2d5-0857d8c8e1ee; Tue, 9 Jun 2026 14:13:29 +0000 (UTC)
X-Farcaster-Flow-ID: 25ae78e1-deca-4924-a2d5-0857d8c8e1ee
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:13:29 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:13:28 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 8/8] efi: parse KUT_ENV= from load options into environ
Date: Tue, 9 Jun 2026 14:09:00 +0000
Message-ID: <20260609140901.95727-9-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWxsb3cgRUZJIGFwcGxpY2F0aW9ucyB0byByZWNlaXZlIGVudmlyb25tZW50IHZhcmlhYmxlcyB2
aWEgdGhlIFVFRkkKbG9hZCBvcHRpb25zIHN0cmluZy4gIElmIGFueSBhcmd2IGVsZW1lbnQgY29u
dGFpbnMgJ0tVVF9FTlY9JywgdGhlCnZhbHVlIGFmdGVyIHRoZSAnPScgaXMgcGFyc2VkIGFzIGEg
Y29tbWEtc2VwYXJhdGVkIGxpc3Qgb2YgS0VZPVZBTApwYWlycyBhbmQgZmVkIHRvIHNldHVwX2Vu
digpLiAgVGhlIEtVVF9FTlY9IGFyZ3VtZW50IGlzIHRoZW4gcmVtb3ZlZApmcm9tIGFyZ3Ygc28g
dGVzdHMgZG8gbm90IHNlZSBpdCBhcyBhIHNwdXJpb3VzIHBvc2l0aW9uYWwgYXJndW1lbnQuCgpU
aGlzIGxldHMgYSBVRUZJIGJvb3QgbWFuYWdlciBwYXNzIHJ1bnRpbWUgY29uZmlndXJhdGlvbiAo
ZS5nLgpLVVRfRU5WPVBBUkFNXzE9VkFMVUVfMSxQQVJBTV8yPVZBTFVFXzIpIHdpdGhvdXQgbmVl
ZGluZyBhbiBpbml0cmQKZW52aXJvbiBmaWxlIOKAlCB1c2VmdWwgaW4gRUZJIGVudmlyb25tZW50
cyB3aGVyZSBubyBmaWxlc3lzdGVtIGlzCmF2YWlsYWJsZSB0byB0aGUgdGVzdC4KClNpZ25lZC1v
ZmYtYnk6IEdpYWNvbW8gTWF6em9sYSA8Z21henpAYW1hem9uLmRlPgotLS0KIGxpYi9lZmkuYyB8
IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbGliL2VmaS5j
IGIvbGliL2VmaS5jCmluZGV4IGQxYmUyYmZjLi42NTA2NzFlOSAxMDA2NDQKLS0tIGEvbGliL2Vm
aS5jCisrKyBiL2xpYi9lZmkuYwpAQCAtMTMsNiArMTMsOCBAQAogI2luY2x1ZGUgPGFzbS9zZXR1
cC5oPgogI2luY2x1ZGUgImVmaS5oIgogCisjZGVmaW5lIENPTU1BTkRfTElORV9TSVpFICAyMDQ4
CisKIC8qIEZyb20gZWFjaCBhcmNoICovCiBleHRlcm4gY2hhciAqaW5pdHJkOwogZXh0ZXJuIHUz
MiBpbml0cmRfc2l6ZTsKQEAgLTEzOSw3ICsxNDEsNiBAQCBzdGF0aWMgY2hhciAqZWZpX2NvbnZl
cnRfY21kbGluZShzdHJ1Y3QgZWZpX2xvYWRlZF9pbWFnZV82NCAqaW1hZ2UsIGludCAqY21kX2xp
bgogCWludCBvcHRpb25zX2J5dGVzID0gMCwgc2FmZV9vcHRpb25zX2J5dGVzID0gMDsgIC8qIFVU
Ri04IGJ5dGVzICovCiAJYm9vbCBpbl9xdW90ZSA9IGZhbHNlOwogCWVmaV9zdGF0dXNfdCBzdGF0
dXM7Ci0JY29uc3QgaW50IENPTU1BTkRfTElORV9TSVpFID0gMjA0ODsKIAogCWlmIChvcHRpb25z
KSB7CiAJCXMyID0gb3B0aW9uczsKQEAgLTM5Nyw2ICszOTgsMzkgQEAgc3RhdGljIHZvaWQgZWZp
X2xvYWRfaW5pdHJkKHZvaWQpCiAJfQogfQogCisjZGVmaW5lIEVOVl9TVFIgIktVVF9FTlYiCisK
K3N0YXRpYyB2b2lkIGVmaV9zZXR1cF9lbnYodm9pZCkKK3sKKwljaGFyICplbnYgPSBOVUxMLCAq
cDsKKwlpbnQgaSwgc2l6ZSA9IDA7CisKKwlmb3IgKGkgPSAwOyBpIDwgX19hcmdjICYmICFlbnY7
IGkrKykKKwkJZW52ID0gc3Ryc3RyKF9fYXJndltpXSwgRU5WX1NUUiAiPSIpOworCisJaWYgKCFl
bnYpCisJCXJldHVybjsKKworCS8qIFJlbW92ZSB0aGUgS1VUX0VOVj0gYXJndW1lbnQgZnJvbSBh
cmd2LiAqLworCV9fYXJndltpIC0gMV0gPSBfX2FyZ3ZbX19hcmdjIC0gMV07CisJX19hcmd2W19f
YXJnYyAtIDFdID0gTlVMTDsKKwlfX2FyZ2MgLT0gMTsKKworCWVudiArPSBzdHJsZW4oRU5WX1NU
UikgKyAxOyAvKiBza2lwIHBhc3QgJ0tVVF9FTlY9JyAqLworCXAgPSBlbnY7CisJd2hpbGUgKCpw
ICYmICFpc3NwYWNlKCpwKSAmJiBzaXplIDwgQ09NTUFORF9MSU5FX1NJWkUpIHsKKwkJaWYgKCpw
ID09ICcsJykKKwkJCSpwID0gJ1xuJzsKKwkJc2l6ZSsrOworCQlwKys7CisJfQorCisJaWYgKHNp
emUgPj0gQ09NTUFORF9MSU5FX1NJWkUpCisJCXJlcG9ydF9hYm9ydCgiQ21kbGluZSBhcmd1bWVu
dHMgdG9vIGxvbmcsIG9yIGJhZCBmb3JtYXQiKTsKKworCXNldHVwX2VudihlbnYsIHNpemUpOwor
fQorCiBlZmlfc3RhdHVzX3QgZWZpX21haW4oZWZpX2hhbmRsZV90IGhhbmRsZSwgZWZpX3N5c3Rl
bV90YWJsZV90ICpzeXNfdGFiKQogewogCWludCByZXQ7CkBAIC00MzQsNiArNDY4LDcgQEAgZWZp
X3N0YXR1c190IGVmaV9tYWluKGVmaV9oYW5kbGVfdCBoYW5kbGUsIGVmaV9zeXN0ZW1fdGFibGVf
dCAqc3lzX3RhYikKIAkJZ290byBlZmlfbWFpbl9lcnJvcjsKIAl9CiAJc2V0dXBfYXJncyhjbWRs
aW5lX3B0cik7CisJZWZpX3NldHVwX2VudigpOwogCiAJZWZpX2xvYWRfaW5pdHJkKCk7CiAKLS0g
CjIuNDcuMwoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFu
eSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVu
ZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBTdGllZ2VyCkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0
LUlEOiBERSAzNjUgNTM4IDU5Nwo=

