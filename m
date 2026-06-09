Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB933175A75
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014250; cv=none; b=d+YReNLX2VzuI7PP6wvJJVlneR+U+4PdPv0stq77M1mO3/+Pxoi/WnuufEL04ZaavaBHUErUSsFVqWTwqyS1Zy9Kx655xEq3i2XN6oaq+Cc0pcKgyxov2rbphDe0lFj12qL1Z65LHFsBCpn3fPNCNLrzgIe48A9Wi7KcCXTbVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014250; c=relaxed/simple;
	bh=LCDGPTQXLAH6Ll4rNj7X6AztU8HG6Z+uGI7hBmtdoOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOR9qpiPj69KBfkihl40G+eMnv6g8tLVknd4gyBE3oKGIJ5938zd0e+mADor1XnoOyBax3HdGXVuJgTpQZvhsVP9BZXfLsOCnm50PGlTiybs6blXuJsuvNQJnVnVVD5nxQDZGU02TNlq2HDmBzUmITjvpmm3myWFqFNlSscKE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=kPkmZKsM; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="kPkmZKsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014249; x=1812550249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCDGPTQXLAH6Ll4rNj7X6AztU8HG6Z+uGI7hBmtdoOM=;
  b=kPkmZKsMU0eHe7CfHVSk5OXDyEXl33HQKvSeRkL7JudBSvh4DyN8tnxc
   ccVH5Wi2ezqHK3ZaGzux6Go7/75EmPvQKhr6Gf4tsBiXhCQObewJWTQEc
   /Rh358kMeC74Fz1pShhNYzK7Xt95rPT8KnJ7L2rmILc4IYifGLEKk8gLN
   xcfEpBrURP5E/VNKXCrclHZLxOuQmc0j4w5mvw2Vrqt6omVLxB2teVjg2
   ywMeM/iNBH3EayQaXNrXQsL5JbSIeBwlI+5KFndHHhJBFnvgQCZw8NOuu
   lb+NZgxs1UcWKjLle87RgL07njNQxK0rdGRi3+B3uOowht1htDhzP5MpO
   A==;
X-CSE-ConnectionGUID: DRrugFSySLuX4gsWGutI1Q==
X-CSE-MsgGUID: mbavzsO0S1O7P72YAk6ckQ==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21425773"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:10:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:3136]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.192:2525] with esmtp (Farcaster)
 id 9cf28b82-35c5-41be-9442-a034d571e26d; Tue, 9 Jun 2026 14:10:42 +0000 (UTC)
X-Farcaster-Flow-ID: 9cf28b82-35c5-41be-9442-a034d571e26d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:10:42 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:10:41 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 2/8] x86: fix EFI memory allocator to clamp regions to 4 GiB
Date: Tue, 9 Jun 2026 14:08:54 +0000
Message-ID: <20260609140901.95727-3-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

c2V0dXBfcGFnZV90YWJsZSgpIGNyZWF0ZXMgYW4gaWRlbnRpdHkgbWFwIGNvdmVyaW5nIG9ubHkg
dGhlIGZpcnN0CjQgR2lCICg0IFBEUFQgZW50cmllcyDDlyA1MTIgUERFIGVudHJpZXMgw5cgMiBN
aUIgcGFnZXMpLiAgSG93ZXZlciwKc2V0dXBfbWVtb3J5X2FsbG9jYXRvcigpIHBpY2tzIHRoZSBs
YXJnZXN0IEVGSV9DT05WRU5USU9OQUxfTUVNT1JZCnJlZ2lvbiB3aXRob3V0IHJlZ2FyZCB0byB0
aGlzIGxpbWl0LgoKT24gbWFjaGluZXMgd2l0aCBtb3JlIHRoYW4gNCBHaUIgb2YgUkFNLCB0aGUg
bGFyZ2VzdCBjb252ZW50aW9uYWwKbWVtb3J5IHJlZ2lvbiBvZnRlbiBzdGFydHMgYmVsb3cgNCBH
aUIgYnV0IGV4dGVuZHMgd2VsbCBhYm92ZSBpdCwKb3IgcmVzaWRlcyBlbnRpcmVseSBhYm92ZSA0
IEdpQi4gIFdoZW4gdGhlIGFsbG9jYXRvciBzZWxlY3RzIHN1Y2ggYQpyZWdpb24sIGFueSBhY2Nl
c3MgdG8gbWVtb3J5IGJleW9uZCB0aGUgbWFwcGVkIHJhbmdlIHRyaWdnZXJzIGEgcGFnZQpmYXVs
dCwgY3Jhc2hpbmcgdGhlIHRlc3QgYmVmb3JlIGl0IGNhbiBydW4uCgpGaXggdGhpcyBieSBjbGFt
cGluZyBldmVyeSBjYW5kaWRhdGUgcmVnaW9uIHRvIHRoZSA0IEdpQiBib3VuZGFyeToKc2tpcCBy
ZWdpb25zIHRoYXQgc3RhcnQgYXQgb3IgYWJvdmUgNCBHaUIgZW50aXJlbHksIGFuZCB0cnVuY2F0
ZQpyZWdpb25zIHRoYXQgc3RyYWRkbGUgdGhlIGJvdW5kYXJ5IHNvIG9ubHkgdGhlIG1hcHBlZCBw
b3J0aW9uIGlzCmNvbnNpZGVyZWQuICBUaGUgYWxsb2NhdG9yIHRoZW4gcGlja3MgdGhlIGxhcmdl
c3QgdXNhYmxlIHJlZ2lvbiB0aGF0CmlzIGZ1bGx5IGNvdmVyZWQgYnkgdGhlIGlkZW50aXR5IG1h
cC4KClNpZ25lZC1vZmYtYnk6IEdpYWNvbW8gTWF6em9sYSA8Z21henpAYW1hem9uLmRlPgotLS0K
IGxpYi94ODYvc2V0dXAuYyB8IDIwICsrKysrKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWIveDg2
L3NldHVwLmMgYi9saWIveDg2L3NldHVwLmMKaW5kZXggYzJmMWM2ZDAuLjA5MjQxYjMzIDEwMDY0
NAotLS0gYS9saWIveDg2L3NldHVwLmMKKysrIGIvbGliL3g4Ni9zZXR1cC5jCkBAIC0yMTUsNiAr
MjE1LDcgQEAgc3RhdGljIGVmaV9zdGF0dXNfdCBzZXR1cF9tZW1vcnlfYWxsb2NhdG9yKGVmaV9i
b290aW5mb190ICplZmlfYm9vdGluZm8pCiAJc3RydWN0IGVmaV9ib290X21lbW1hcCAqbWFwID0g
JihlZmlfYm9vdGluZm8tPm1lbV9tYXApOwogCWVmaV9tZW1vcnlfZGVzY190ICpidWZmZXIgPSAq
bWFwLT5tYXA7CiAJZWZpX21lbW9yeV9kZXNjX3QgKmQgPSBOVUxMOworCXVuc2lnbmVkIGxvbmcg
bWF4X2FkZHIgPSAxVUwgPDwgMzI7CiAKIAkvKgogCSAqIFRoZSAnYnVmZmVyJyBjb250YWlucyBt
dWx0aXBsZSBkZXNjcmlwdG9ycyB0aGF0IGRlc2NyaWJlIG1lbW9yeQpAQCAtMjIyLDEzICsyMjMs
MjYgQEAgc3RhdGljIGVmaV9zdGF0dXNfdCBzZXR1cF9tZW1vcnlfYWxsb2NhdG9yKGVmaV9ib290
aW5mb190ICplZmlfYm9vdGluZm8pCiAJICogRUZJX0NPTlZFTlRJT05BTF9NRU1PUlkgcmVnaW9u
IHdoaWNoIHdpbGwgYmUgdXNlZCB0byBzZXQgdXAgdGhlCiAJICogbWVtb3J5IGFsbG9jYXRvciwg
c28gdGhhdCB0aGUgbWVtb3J5IGFsbG9jYXRvciBjYW4gd29yayBpbiB0aGUKIAkgKiBsYXJnZXN0
IGZyZWUgY29udGludW91cyBtZW1vcnkgcmVnaW9uLgorCSAqCisJICogUmVnaW9ucyBhcmUgY2xh
bXBlZCB0byB0aGUgZmlyc3QgNCBHaUIgYmVjYXVzZSB0aGUgRUZJIHBhZ2UKKwkgKiB0YWJsZXMg
c2V0IHVwIGJ5IHNldHVwX3BhZ2VfdGFibGUoKSBvbmx5IG1hcCB0aGF0IHJhbmdlLgogCSAqLwog
CWZvciAoaSA9IDA7IGkgPCAqKG1hcC0+bWFwX3NpemUpOyBpICs9ICoobWFwLT5kZXNjX3NpemUp
KSB7CiAJCWQgPSAoZWZpX21lbW9yeV9kZXNjX3QgKikoJigodTggKilidWZmZXIpW2ldKTsKIAkJ
aWYgKGQtPnR5cGUgPT0gRUZJX0NPTlZFTlRJT05BTF9NRU1PUlkpIHsKLQkJCWlmIChmcmVlX21l
bV9wYWdlcyA8IGQtPm51bV9wYWdlcykgewotCQkJCWZyZWVfbWVtX3BhZ2VzID0gZC0+bnVtX3Bh
Z2VzOwotCQkJCWZyZWVfbWVtX3N0YXJ0ID0gZC0+cGh5c19hZGRyOworCQkJdW5zaWduZWQgbG9u
ZyBzdGFydCA9IGQtPnBoeXNfYWRkcjsKKwkJCXVuc2lnbmVkIGxvbmcgZW5kID0gc3RhcnQgKyAo
ZC0+bnVtX3BhZ2VzIDw8IEVGSV9QQUdFX1NISUZUKTsKKwkJCXVuc2lnbmVkIGxvbmcgcGFnZXM7
CisKKwkJCWlmIChzdGFydCA+PSBtYXhfYWRkcikKKwkJCQljb250aW51ZTsKKwkJCWlmIChlbmQg
PiBtYXhfYWRkcikKKwkJCQllbmQgPSBtYXhfYWRkcjsKKwkJCXBhZ2VzID0gKGVuZCAtIHN0YXJ0
KSA+PiBFRklfUEFHRV9TSElGVDsKKworCQkJaWYgKGZyZWVfbWVtX3BhZ2VzIDwgcGFnZXMpIHsK
KwkJCQlmcmVlX21lbV9wYWdlcyA9IHBhZ2VzOworCQkJCWZyZWVfbWVtX3N0YXJ0ID0gc3RhcnQ7
CiAJCQl9CiAJCX0KIAl9Ci0tIAoyLjQ3LjMKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxp
bgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK

