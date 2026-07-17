Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB03EB0FE
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306577; cv=none; b=M7X9PI8mPx2xUGz/KOI3NbeLgS2RpsqRKPx92S3ItSspz/INSgpv8uyhsLTNxeNZkc3XBjmPMBrTkDZVUxoMeXcFivqKIoISydzec6eVb4xNcsS73bGwRnoGVKcSnsc3scEczmwFUKFH6T9FDoUMOOj46gK+6bjcGnPL4/vGDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306577; c=relaxed/simple;
	bh=b4h/3lJgzRH57MMe6fFpjc94WasnosnTFzGtQ4QeaIA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RCwC6zDFVmfoEZoR4m2doE5AIuYrkL/VbF5d9acXlWH5FOdwZ92cKKmHTYrTLn8Ex9UDiXvk9ffYywFEl9eUEjz11HiyfGFo2/4r2sP+9n+bVcpcdNV2HBzm/rz4R8BfiobDxxGatcxnQpFpCFMyO5V6rIQDv4zxyqmOOj98N0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=none smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=Vw7jwplO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="Vw7jwplO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cca0c5799eso56251965ad.0
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1784306575; x=1784911375; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QC+n+EJ2UpdBE53WiVqkFtqwQlqlsxDuXStZpPkZEEk=;
        b=Vw7jwplOF6qhhvSUQc3lrfuwE544POAKZ+GeCtoP0ZgLu3k+rUFDobXRSppS/Ifk+c
         zmZL8JUN1bk0P14gpscsqmbS0aX9LhhRYi5CoHCrRNae0v5lQ+tvTiB1v5jHJfRlUMzj
         6p+5jTPEWjpWCXsCM1lG9Os5vxwJBBOQPKGdHe8HGukADhIcgXiQt41XAcJvYIWIX/TU
         NZlo/e/HrRC1FgHrr2Yz/OiVExhSqA8Giv8G5D3wId5hvtUzrnBhjE/Wm6/CRnF5lpt4
         SVq5PYRMN9S8tsqt8O1eZsGhOu0VrTapbaPaTzIh2Dr28eniYQr+k+yd4rQ+vroff+s8
         y7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306575; x=1784911375;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QC+n+EJ2UpdBE53WiVqkFtqwQlqlsxDuXStZpPkZEEk=;
        b=O9ITx2TEIgvirD5LDb15W8OkGzUOb9bUpfeEhFvSoqSnMYpd+dUhCmIse2G0NirRva
         DE2baTT4oc8GFVDGe9DBWNQk9kNal5Iv1/OLYYtbOnBNIN2pLsyXf3X2TNij/GGpgrtB
         kmnoBK71h7Gctf0RiTq4wTlxJAJYacZfsI0FDxdfzwc1OCUa7nBA7PNaW3ua9qg6YhnT
         UIW7WnL9QTGs66Lb/oO+iB7XzsN17VEOA+KRvZL5CxUfK+aMv3C8L7mMBh09+/E0822p
         4gRAOCCedppU+0vz5zXRns1N5YL9fBNxdqF89zg9y8b8D3vCd66Yc0cX326xOsG73T3x
         Zt7Q==
X-Gm-Message-State: AOJu0YxC3KQbbg360etDRtj9/PrlcgMitJKmjLYlSZQq2pK26z04DF2V
	nfR7vQMUXT5DCWIbQAu5IiUK96WZPuBH1r7i6XOcV/tOphLqitmFQFq8FvN1CcBpLw/LTKCRYbx
	LUbd0Ilau
X-Gm-Gg: AfdE7cm8rmtdOGmacUfoNKxAVR2K6mGqwY+QgnBSYAK7wZXgUtvuhTR5SElpgtkdc2M
	V0QR5lovXc8mdyPD1Eywfkb2/dk4SVL3+NST0qkiF10wjhgF2Gvc8yDToWyx8uPcNJH84tFB9g3
	8RZJzBRWwGJLX/sV5SE8LSFoIR3lM+g6sStCEn3RoCjeQMvpTDiCGJlgZOKorDC70VWSsdq8N/w
	UAFPvX0GV2e9i8hymknLjMxXNBRxtUbMHBpDLkBJN1apqPTRO5G2B+vbvHRZL4OR6YSLsLfZM1a
	FSHHj5wkLWtMyCjBhnLVwweCoVhMNivE9UqYkwiNEML81Ucy70jdaz+AALEFK6p1xD1xQy1eyQz
	Am6+D+VM59XhjpFmrBIxJmuSIxXdjTfQh2H3C50QRTmO0V5Gr4O6teAk12iKaSN+7C2K6tSP57U
	TI9BCWdpTXsgs3NST/1Pai8r5sxfB31sHkqSKNW++2W7jD0nqsxbj5gqJhRDXz53HP6kXkU5TRA
	PKHkIUNJpxVKdfRvmSF+4RpdGd5YM/6P5tNpPfmDx1gSPJ1bRHZGOwjou62lVLsdUzm2c4AYMIg
	0Xz7hAM=
X-Received: by 2002:a17:903:440c:b0:2ca:1594:451e with SMTP id d9443c01a7336-2cf3496b583mr39682645ad.31.1784306574730;
        Fri, 17 Jul 2026 09:42:54 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([81.17.122.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448dac2sm14434255ad.3.2026.07.17.09.42.53
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:42:54 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: kvm@vger.kernel.org
Subject:
 [PATCH] LoongArch: KVM: Initialize vector array in dmsintc_inject_irq()
Date: Fri, 17 Jul 2026 22:12:50 +0530
Message-ID: <178430657065.19695.6391637564764566917@digiscrypt.com>
X-CodeOps-Marker: fe2013c4e57a43cdafc770bff6cd6205
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

dmsintc_inject_irq() declares the on-stack array 'vector[4]' without an
initializer and only assigns an element when the corresponding
ds->vector_map[] word is non-zero:

	unsigned long vector[4], old;
	...
	for (i = 0; i < 4; i++) {
		old = atomic64_read(&(ds->vector_map[i]));
		if (old)
			vector[i] = atomic64_xchg(&(ds->vector_map[i]), 0);
	}

It then reads all four elements unconditionally to decide whether to OR
them into the guest CSR registers LOONGARCH_CSR_ISR0..ISR3:

	if (vector[0]) { ... }
	if (vector[1]) { ... }
	...

When a vector_map word is zero, the matching vector[] element is left
uninitialized. Its stale stack contents are then written into the
guest-visible ISR registers, both leaking kernel stack data to the guest
(which can read the ISR CSRs) and injecting spurious interrupt vectors.

The path is guest reachable: a guest-directed MSI sets bits in
vector_map via dmsintc_deliver_msi_to_vcpu(), and AVEC delivery
(kvm_irq_deliver() -> dmsintc_inject_irq()) then consumes the
partially-initialized array. In the common case where the guest only
uses low vectors, only vector_map[0] is set and vector[1..3] are read
uninitialized on every injection.

Zero-initialize the array so that words with no pending vectors are
skipped as intended.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index de25735ce0..ef6c064e52 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -11,7 +11,7 @@
 void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 {
 	unsigned int i;
-	unsigned long vector[4], old;
+	unsigned long vector[4] = {}, old;
 	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
 
 	if (!ds)
-- 
2.52.0
