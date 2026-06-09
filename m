Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1677032470A
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014182; cv=none; b=iBlpawCpchAD6ntzT9VcVzUKVpcDRiSjJ9QEwNTnhBqGw84FDEMjCwu+/fCFrw63gsd4f0Uy3Fgg6eH9hPeMu4r5H5/MzCGTQrADV+NZsHxr3S62x8RFV3ZWm2mTty3ugIJDTOD8ztKrrWQ7NGEgkkvTRoEOPc40/BW0CIR9vNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014182; c=relaxed/simple;
	bh=kywE8Vrmn1O7rebvzvCRtt1xBrCcdah1h6YPJmsM76Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TPKOB4Lgwos2QhAJNF/SljXZw+yplFxmNlZ17qWGz4WH8IoiV6aoUDQCHquAcVv0OzRWzqXAaOSNPGEQEZtCYMF5EWAiLsA2XrCT/DtugW0sr0DxvwwsZqp/eK6I1jTm5va1UC6JqEzs2boqM+iPGJ9SOGqDHkXk1OsbNKRWmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=q0IIhudU; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="q0IIhudU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014181; x=1812550181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kywE8Vrmn1O7rebvzvCRtt1xBrCcdah1h6YPJmsM76Q=;
  b=q0IIhudUKI51xyiTTPDIcY8c5CNejDr3zCHIHEBCW5xKAV7wXNNbAwVZ
   3Lj7lVrMSX2o8DhioEWb+vBokZ3nerBVBXLB00jGziphB0c06cK/WJ1xZ
   CX+qrnce1HaA0y/ei/xcVrBIutqiN18a2fhYXbJePoB+OCWSRV1QlHVDD
   cZlYBfzBsH5pKwOcuq9SyI8Us/NE7xGRs2K6WiHUdTxgRril/aAUoG20I
   mQYeM9v7g2proNDslehThdtM9wKPGgWGiuzIBS6GUJndD5yYQcUlJHqCV
   82s6yj08xOwNFjMjXnh4gJam+i5v9eiikNvqt2xSY0sVT/XwE5RhiEcEt
   g==;
X-CSE-ConnectionGUID: 5cJ/lgEUR1WJZXm0OjEJxg==
X-CSE-MsgGUID: ZFxFExKKTNSCD+wFOuGILQ==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21195001"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:09:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:31569]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.151:2525] with esmtp (Farcaster)
 id e131bc41-7ec2-4c24-a2d5-f9a2b42bf317; Tue, 9 Jun 2026 14:09:37 +0000 (UTC)
X-Farcaster-Flow-ID: e131bc41-7ec2-4c24-a2d5-f9a2b42bf317
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:09:37 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:09:36 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 0/8] x86: fixes for running KUT as EFI on non-QEMU KVM hosts
Date: Tue, 9 Jun 2026 14:08:52 +0000
Message-ID: <20260609140901.95727-1-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhpcyBzZXJpZXMgZml4ZXMgc2V2ZXJhbCBpc3N1ZXMgZW5jb3VudGVyZWQgd2hlbiBydW5uaW5n
IEtVVCB4ODYgdGVzdHMKYXMgRUZJIGFwcGxpY2F0aW9ucyBvbiBhIEtWTS1iYXNlZCBoeXBlcnZp
c29yIHRoYXQgbGFja3MgYW55IGFkLWhvYwpwYXJhLXZpcnR1YWxpemVkIGludGVyZmFjZSAoZS5n
LiBmd19jZmcpLCBvbiBhcmJpdHJhcnkgVk0gc2hhcGVzCih2YXJpYWJsZSBDUFUgY291bnQgYW5k
IG1lbW9yeSBzaXplKS4KClBhdGNoZXMgMS00IGZpeCBjcmFzaGVzIGFuZCBmYXVsdHM6CiAgLSBT
dGFjayBzaXplIG1pc21hdGNoIGJldHdlZW4gRUZJIGFuZCBub24tRUZJIHBhdGhzCiAgLSBNZW1v
cnkgYWxsb2NhdG9yIHNlbGVjdGluZyByZWdpb25zIGFib3ZlIHRoZSA0IEdpQiBpZGVudGl0eSBt
YXAKICAtICNHUCBvbiBzeXN0ZW1zIHdpdGhvdXQgYSBQTVUKICAtIElTUiB0aHVua3MgdXNpbmcg
cmVsMzIganVtcHMgdGhhdCBvdmVyZmxvdyBiZXlvbmQgMiBHaUIKClBhdGNoZXMgNS02IGZpeCBT
TVAgYnJpbmd1cDoKICAtIFJlcGxhY2UgcGVyLUFQIHNlcmlhbCBwcmludHMgdGhhdCBjYXVzZSB3
YXRjaGRvZyB0aW1lb3V0cyBvbgogICAgbGFyZ2Ugc3lzdGVtcwogIC0gQWRkIHRpbWVvdXQtYmFz
ZWQgQVAgZGV0ZWN0aW9uIHdoZW4gZndfY2ZnIGlzIHVuYXZhaWxhYmxlCgpQYXRjaGVzIDctOCBm
aXggRUZJIGNvbW1hbmQgbGluZSBoYW5kbGluZzoKICAtIENvcnJlY3QgdGhlIGxvYWRfb3B0aW9u
c19zaXplIGJ5dGUtdG8tY2hhcmFjdGVyIGNvbnZlcnNpb24KICAtIEFkZCBLVVRfRU5WPSBwYXJz
aW5nIGZvciBwYXNzaW5nIGVudmlyb25tZW50IHZhcmlhYmxlcyB2aWEKICAgIFVFRkkgbG9hZCBv
cHRpb25zCgpUaGUgdGFyZ2V0IGVudmlyb25tZW50IGlzIHJ1bm5pbmcgS1VUIGFzIFVFRkkgYXBw
bGljYXRpb25zIG9uIGEKS1ZNLWJhc2VkIGh5cGVydmlzb3Igd2l0aG91dCBhZC1ob2MgUFYgaW50
ZXJmYWNlcywgb24gYXJiaXRyYXJ5IFZNCnNoYXBlcy4KClJlZ3Jlc3Npb24tdGVzdGVkIGJ5IHJ1
bm5pbmcgdGhlIGZ1bGwgS1VUIHN1aXRlIHVuZGVyIFFFTVUrS1ZNK09WTUYsCmluIGJvdGggLi9j
b25maWd1cmUgYW5kIC4vY29uZmlndXJlIC0tZW5hYmxlLWVmaS4gUmVzdWx0cyBhcmUKaWRlbnRp
Y2FsIHdpdGggYW5kIHdpdGhvdXQgdGhpcyBzZXJpZXMuCgpHaWFjb21vIE1henpvbGEgKDgpOgog
IHg4NjogZWZpOiB1c2UgUEVSX0NQVV9TSVpFIGZvciBwZXItQ1BVIHN0YWNrIGFsbG9jYXRpb24K
ICB4ODY6IGZpeCBFRkkgbWVtb3J5IGFsbG9jYXRvciB0byBjbGFtcCByZWdpb25zIHRvIDQgR2lC
CiAgeDg2OiBza2lwIFBNVSBpbml0IHdoZW4gbm8gUE1VIGlzIGFkdmVydGlzZWQKICB4ODY6IGZp
eCBJU1IgdGh1bmsgdG8gdXNlIGFic29sdXRlIGluZGlyZWN0IGp1bXAKICB4ODY6IHJlcGxhY2Ug
cGVyLUFQIGJyaW5ndXAgcHJpbnRzIHdpdGggYSBzaW5nbGUgc3VtbWFyeSBsaW5lCiAgeDg2OiBh
ZGQgdGltZW91dC1iYXNlZCBTTVAgYnJpbmd1cCB3aGVuIGZ3X2NmZyBpcyB1bmF2YWlsYWJsZQog
IGVmaTogZml4IGxvYWRfb3B0aW9uc19zaXplIGNvbnZlcnNpb24gdG8gY2hhcmFjdGVyIGNvdW50
CiAgZWZpOiBwYXJzZSBLVVRfRU5WPSBmcm9tIGxvYWQgb3B0aW9ucyBpbnRvIGVudmlyb24KCiBs
aWIvZWZpLmMgICAgICAgICAgICB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQogbGliL3g4Ni9hcGljLmMgICAgICAgfCAgMSAtCiBsaWIveDg2L2lzci5jICAgICAg
ICB8ICA4ICsrKysrLS0tCiBsaWIveDg2L3NldHVwLmMgICAgICB8IDI0ICsrKysrKysrKysrKysr
KysrKysrLS0tLQogbGliL3g4Ni9zbXAuYyAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tCiB4ODYvZWZpL2VmaXN0YXJ0NjQuUyB8ICAyICstCiA2IGZpbGVzIGNoYW5n
ZWQsIDkwIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKLS0gCjIuNDcuMwoKCgoKQW1h
em9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1E
YW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0b2YgSGVs
bG1pcywgQW5kcmVhcyBTdGllZ2VyCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0
ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4
IDU5Nwo=

