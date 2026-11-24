Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.149.156.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537978;
	b=sJgSC9YPTtfHapPwqc027n/dkoJ6ztAWK3oQqcwUl8wFugk12YilQWtp5wjrayd5h9a3
	 oCtX1VRIfR3rTmvUSeTVFLixJakDexVrXqJh9Vsa3YZ2WuW99UPLoI9UGq5jwXCr3v5b9
	 xO0tPa5gI5J/G3rdLCEfdQwC3gttVNYRkBeKr4Od5wM/4GMRNpdruY1c4GX+9rVFo94Wq
	 YrKiDGKy8LJ2OMjaedgfevdLUPtjbCzFKKM3ELdjd9fGYwBnfxWSNigNzO1YNexl7F2A9
	 2WiJHX4+nOr6GTApz5n290iDfTB/kaNlnlbZlg8HmYTx0l7a4IkyGtESJM4u0WMpy8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537978;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CMAE-Envelope;
	bh=uS+bRpEbxEsggVpK5uFXQCtUpYq84Y6T8SvP6ntxLfg=;
	b=XuFsTwmWWrqB4MSVZerun38ptLuh6WFXss3H1cGrHGkU+qJmlkGU3SYqHG3FldRj1iW5
	 KzVnTMtXAf6FM7agU1+PoNKWWBx0ZkMyysfZlcainr74KG+sRJgeA+UKuSIK3kxaiUAI3
	 kF7OsnYy9g/5KNHmNlHrRggeObdmrQZ+wxIB/NA3HsVQ3XtenmWQBPVV5F2nnvh91doHW
	 DtqS71/wSDcjgznCEjunrMMVeFylN6nd2L6LM8Ffitqet0yq1/3VdhGaFVI6GzQYdnlOb
	 e/+OVJyUulgGlS7s+t1uj8qaXOoTAQti+pRtQkRozPWt0vvY8vJwWNbCGr/rqmsTuUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=benettiengineering.com;
	spf=pass smtp.mailfrom=benettiengineering.com;
	dkim=pass header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=Udotyj8S;
	arc=none smtp.remote-ip=62.149.156.131
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D3606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=Udotyj8S
Received: from localhost.localdomain ([95.249.82.110])
	by Aruba SMTP with ESMTPSA
	id VtRoxIzMNV5J9VtRpx20vm; Tue, 24 Nov 2026 17:32:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1795537969; bh=68lMnJp0S4dK6r1Gvabx+dFUaMwgYpnMIeEfzQ6FMn0=;
	h=From:To:Subject:Date:MIME-Version;
	b=Udotyj8SxpmD3n8b+p/O0dV05RM1PiEi8qplF6rVyhqJG7lOxaxd/mS1selO6jdIn
	 O6HZLNRSKZr2x/1W7LRzbWCDYWMvRiOqeiNQm4QXO4jlm5Xig/EOsiUstvvmFWcbE+
	 9NAVUaP1QPCikRQ+8vel7yA3MphYe9ZzxcA4KHx7fbEe+NBOBOqeZ1TxUhPYlomDrr
	 a16AMSI784T+pow1hXwsFWYEdPvUg0gueXA1kYVIvGhb8nYSvvVIXhkyQR3OkQJz2U
	 zZPPWgT1raz+5qWZEfhbjnkp2UlmBKSFt1b3CKWr098sm1X0s7LdnT+vj2W5PBWrUT
	 dtMU+QfB18Ilg==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH kvmtool] include/linux/types.h: add __s128 and __u128 types
Date: Tue, 24 Nov 2026 17:32:48 +0100
Message-ID: <20261124163248.782815-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.47.3
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
X-CMAE-Envelope: MS4xfAPKvsoYArB7bWL4fqwDB3icNhs/kACu3GPBm7VZ6edBKVpVuQ+WRlX1M4lp7MIisQyRC9GOp+rP/YtBLa+VCXrERdGlUAsV94szfv/qvB/EGQSpB7mZ
 em92V+lAqCI0R/EjPmN8Ris6RR0zKpMzOfrMuB5k3oXKnmN+julYR1SSUBQbBHN0ST74iqU3OFvdokrJxi4TcMQKGvkZ6KMYI+r0lHRPEnogMc1eYu1RU9y4
 WkL4v6jLijNNkO3A0do+Ye5zOvDKSCnK2jXoK/VfrIXvmDJlChaCVZMTqlI8Arlsm8AKSaSqcfjOX+0p6aACP751CEbs7a7gUWTDv54fyNEh5rvXyE/SoF78
 lHwW/d6G

kvmtool's include/linux/types.h shadows the kernel UAPI <linux/types.h>,
so the __s128/__u128 types it provides are missing. Starting with Linux
7.x headers, arm64 <asm/sigcontext.h> and <asm/ptrace.h> use __u128
instead of __uint128_t, so building kvmtool against them, where
<signal.h> pulls <asm/sigcontext.h> in, fails with:

.../sysroot/usr/include/asm/sigcontext.h:81:9: error: unknown type name '__u128'; did you mean '__u32'?
   81 |         __u128 vregs[32];
      |         ^~~~~~

So let's add the __s128 and __u128 types the same way the kernel UAPI
<linux/types.h> does.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 include/linux/types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/types.h b/include/linux/types.h
index 5e20f10..039174c 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -17,6 +17,11 @@ typedef __s16 s16;
 typedef __u8  u8;
 typedef __s8  s8;
 
+#ifdef __SIZEOF_INT128__
+typedef __signed__ __int128 __s128 __attribute__((aligned(16)));
+typedef unsigned __int128 __u128 __attribute__((aligned(16)));
+#endif
+
 #ifdef __CHECKER__
 #define __bitwise__ __attribute__((bitwise))
 #else
-- 
2.47.3

