Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510029;
	b=2niGFtL1LTNPSFWEGDt6RCZuBSu24BkWps1ZXE1LBqh6l/jXL3Gm7QvuToDBqAdgT2WP
	 vOB4FM4j/HgMSfOM3GarnZ4spcPX+jeQ2yGerI4wKC0XSINETSeTbWjSo2/8s+NSqhiVU
	 Inxc8He2zElB+o3JL7A8KHqBxBU/hgv6q7Kkb9X80thshQv3wnpseZaK3zWEkD3i/Y0HV
	 9W3QMasImRe1L+HF532zX8yntt1V9KQM46fq9nTtbcVIpCApFdB7XS1yyBVUhEqn7sJ9g
	 a6e2cwoU/zOlAQ4UQwlH6JPz/j4/cDh3EIN0tSwY2sD9O/zTHnmD02WKPKGOJlPgE+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510029;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=B2jzQr3iPsKxk7cHVvoiiPad3+1ISlYD6B8rH+qTzA8=;
	b=kQBLeC8xiGuySBYw5LGWQ69k4ysI5rzDtLZmqIr9qodlXxrqjMXE4zm2OIMPO5ljAeeJ
	 5a1iJABrFf4UVSZO4D6ACFfNH55FlN4vZZYYzafe5KZ7C3vxJMKnXYRjLueFcxKJNVR/L
	 ZPEuSsA+q5xJXvEvYrvj1ofcoMMomYHYiDYZ6HgT2dYpGAo/fxT24FvC5No0xrDFvX4Lp
	 q8miZbxPSz4XmBAsmraLYW+u99xSHP2QTqgLC55N3jnFld+YYytd2ok4n/AN1ms4ZDaCv
	 4VA/LUMXjhHKqV9pUreQrjSa98UWxvYngLwfcx93ae1Nys6th3Bpz5qBCV7IT0UOQqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=hdiWAlTM;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3B606A31C
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FB3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=hdiWAlTM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792510029; x=1824046029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B2jzQr3iPsKxk7cHVvoiiPad3+1ISlYD6B8rH+qTzA8=;
  b=hdiWAlTMq5kQOsS0Sr2VsgvHB2b2M0boGJ/q//gsJUkM9bbbQsytZ6r7
   eKPJAmtaywHY85gQTz9pUkVrcQe95pQS5ns0QVZ/OCsffr9wdUqxSAINP
   Wa66Cor5kwhgt4R64HDl63QhfVbr7eToFRI1UjTi/5hsvXCmEc52Sfceg
   btuyXs06E1D/NU2lxLhHJEID+TxqQJs2ZBLqLbw0qR/RQnMm3EVG8pzT4
   21HhvW5Gn+JBMeSVh52+Jexg/RS88ZjifAh8fl4iICEs7gzsY8mfJhyRi
   PBM4OpLgxoZU2dojbevCxwBRCuK/yrVwGGP1/pkvZ+Wq4hAJlKnlNr0vB
   A==;
X-CSE-ConnectionGUID: neIJXHw8QRqArsDlZ32ESQ==
X-CSE-MsgGUID: 3dOJhRGmT/ClcHP2VJ94xA==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31788493"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:27:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:1364]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.5:2525] with esmtp (Farcaster)
 id b7cabadf-ecb9-46e8-b1e1-d73dd29ff72b; Tue, 20 Oct 2026 15:27:06 +0000 (UTC)
X-Farcaster-Flow-ID: b7cabadf-ecb9-46e8-b1e1-d73dd29ff72b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:27:06 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:27:05 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 4/8] x86: fix ISR thunk to use absolute indirect jump
Date: Tue, 20 Oct 2026 15:25:21 +0000
Message-ID: <20261020152525.57694-5-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020152525.57694-1-gmazz@amazon.de>
References: <20261020152525.57694-1-gmazz@amazon.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the relative jmp (e9 rel32) with an absolute indirect
jmp *0(%rip) (ff 25 00000000 + addr64).  The rel32 displacement
is sign-extended to 64 bits, so when the displacement between
the thunk and isr_entry_point exceeds 2 GiB the sign extension
corrupts the target address.

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
 lib/x86/isr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/x86/isr.c b/lib/x86/isr.c
index 53c0c2b3..4f474931 100644
--- a/lib/x86/isr.c
+++ b/lib/x86/isr.c
@@ -79,9 +79,11 @@ void handle_irq(unsigned vec, void (*func)(isr_regs_t *regs))
     /* mov $func_high, %(rsp+4) */
     *thunk++ = 0xc7; *thunk++ = 0x44; *thunk++ = 0x24; *thunk++ = 0x04;
     *(u32 *)thunk = (ulong)func >> 32; thunk += 4;
-    /* jmp isr_entry_point */
-    *thunk ++ = 0xe9;
-    *(u32 *)thunk = (ulong)isr_entry_point - (ulong)(thunk + 4);
+    /* jmp *0(%rip): absolute indirect jump to isr_entry_point */
+    *thunk++ = 0xff; *thunk++ = 0x25;
+    /* disp32 = 0: address follows */
+    *(u32 *)thunk = 0; thunk += 4;
+    *(u64 *)thunk = (ulong)isr_entry_point;
 #else
     /* push $func */
     *thunk++ = 0x68;
-- 
2.47.3

