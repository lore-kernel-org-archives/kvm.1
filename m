Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858824;
	b=s7G2g4KufY0Er6GMY3efzeRXhazLRrU4pBJ+A79MzjIxkCoxVY2LDIdys17W/Ao6zSHn
	 qrMVxzgWGuyc78Ybdfzxgv8euVLUZzje+WraEp++ZprIM/iw/2QYzdrj2Aeaeqtw9epji
	 acxd2fca/CYDrYZ6eYXLNUp7Bhgj6WFz6YMxLtNEq0uVIpF0rdtKi9v6utdoIfDZU3w+D
	 V/ZlsgF6lWpy/EMJHoAv/ueBat5qQghjwHLMsTZ9V1yhfZUNHwuweVOlhhpLaTGQfML9v
	 zcvRH+gfMpT3KKlyeYusoNn8z/lZkr0CH5qi/5JoHNn9vwllWB1AUdhRTBHg7wBhWoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8oZDobfqony+xf0RC905KQrpyePTZE2mdASr1hL3L6M=;
	b=KoN1gBYHZ6m5XzbHew1rSM54fVpGVfAkyGIgRiCcgP8U2N44OKrayjj+tKRpXEBcAxn7
	 97A4/FEDjpGtBSrxU1gWYCtcFDaLtlz5TY7Y7VEDANHHqYaYTUZWUOnvLP6JwVe05fcEc
	 j7aN1gULDCFor1R/3uiU5G1T6hTTX3pDEjAUDHvT4Bydoq3iDVji+JnvSRZ4IWNOpaduZ
	 UuIVn+3jNvNqBN6i720UxGHb6P6LD6zSG0FZMh/xutLy0Kkf/0U50RUwchA7wWBeO0v2u
	 n5q3PCuIu7tdXaAg+aijBieKiX2BMLKMk2VafH86GbSu8BCuo3NLA17IesFum3q9Yeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=orwA0Pal;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C8606A32D
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79C8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=orwA0Pal
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dff112181so1775398f8f.3
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858822; x=1793463622; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oZDobfqony+xf0RC905KQrpyePTZE2mdASr1hL3L6M=;
        b=orwA0PalbdHp0DyUV8klebfR0tmWs8neSNZDpTOFY7o+SSf4+vxn/zAqh6HxrIcp5c
         RfO80l1EQ7HoZRXp7fdXTWy0BOII9+SpTe2GivS2qssWvRicmdOR1pruUx/pMqG5kmDC
         pBGEO5fN7kpQN1pNRwqFmdpVL6yzHYvss8xrrHJTWI20l8bWOlh8pkHJfGS3gIQ7HEGa
         ACW6Tabu1JoVc+yMhh9edGTKJTRofzpcJhicStCQwR8tlVGsqEfMl3mIfP52cbcPYI0Z
         zbrIrKUwW9464QZijM8ooFKq7u40nqtUWxoz5MhhC9zExdrUH8EPgbzgPO4FAGQTTxaL
         xxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858822; x=1793463622;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8oZDobfqony+xf0RC905KQrpyePTZE2mdASr1hL3L6M=;
        b=cZ6UgvDd22YGdO4M6vQuYpHkQi92h02JbpsJSt8oZ32nVVtqnOxYboW/3Ibd0gO4ok
         Z8+cEcby069eotuqR9LHJRZQmVFPPlyIZMergM5O2qHnjkeiJoUgeY6TJ0QKhSEejyMq
         pxykx8DG8faQ95aFEAuHJI/B2090eCQ5n0LIOucMPcXsEKztxpH/eW1gejXBn8ZATvOn
         z8agtZNKjG/O2MHigEO6RfRr4fNTBoTFcYeL/7mnBKNcGxhTElSKx7Cf0jj26BjEEdDw
         AMl9QmVZjwBQwgq4Tq6nc9pzu8QHULiSpwIVt6OVypZwUZqykXPc4N4m6/oa3xk33JyN
         7cpw==
X-Gm-Message-State: AFq9FYJXKLjJ878rHYxXkX+q2wnQOm6kQZKjomBbtbWcSS5VDESshxZA
	Sq9uPnv8QbROmbS4EOzmhuzbbnQo6vFc2ep5Rae5brV0gYBmsNI+Uw7WeyJ9lnleXOUoTCqiVvW
	Uct9XeD5zsYkJegh9KegPjqM1siqsVRZA+gHsJArVaxvYt6kMiQYAUA5Wco7RdRHljwS6xlILq1
	uUMoZDi2y/XDy1TTQ8RSDcDHlxv8Rs1IekG115Z11qadc=
X-Received: from wrxr5.prod.google.com ([2002:a05:6000:145:b0:48a:f605:97c1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26d0:b0:48d:f3a4:610b with SMTP id ffacd0b85a97d-48e3eb82efbmr3348473f8f.25.1792858822012;
 Sat, 24 Oct 2026 09:20:22 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:18:58 +0000
In-Reply-To: <20261024161902.2093581-1-smostafa@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261024161902.2093581-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261024161902.2093581-6-smostafa@google.com>
Subject: [PATCH kvmtool 5/9] fdt: Add helper to copy an FDT node
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add fdt__copy_node() to recursively copy all properties and subnodes of
a source FDT node into a destination FDT.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/kvm/fdt.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/kvm/fdt.h b/include/kvm/fdt.h
index e84c5c1..e7b65e8 100644
--- a/include/kvm/fdt.h
+++ b/include/kvm/fdt.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 
 #include "kvm/fdt-arch.h"
+#include "kvm/util.h"
 
 #define FDT_MAX_SIZE	0x10000
 
@@ -41,4 +42,31 @@ extern char *fdt_stdout_path;
 		}							\
 	} while (0)
 
+#ifdef CONFIG_HAS_LIBFDT
+static inline void fdt__copy_node(void *fdt_dest, const void *fdt_src,
+				  int offset)
+{
+	int prop_offset, subnode_offset, len;
+	const char *name;
+	const void *prop;
+
+	fdt_for_each_property_offset(prop_offset, fdt_src, offset) {
+		prop = fdt_getprop_by_offset(fdt_src, prop_offset, &name, &len);
+		if (!prop)
+			continue;
+
+		_FDT(fdt_property(fdt_dest, name, prop, len));
+	}
+
+	fdt_for_each_subnode(subnode_offset, fdt_src, offset) {
+		name = fdt_get_name(fdt_src, subnode_offset, NULL);
+		if (!name)
+			continue;
+		_FDT(fdt_begin_node(fdt_dest, name));
+		fdt__copy_node(fdt_dest, fdt_src, subnode_offset);
+		_FDT(fdt_end_node(fdt_dest));
+	}
+}
+#endif
+
 #endif /* KVM__FDT_H */
-- 
2.56.0.307.g5fe7bd680c-goog

