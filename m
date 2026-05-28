Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACE377009
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977487; cv=none; b=JsXI5Xtm4jEq83suvfm88cf8eT6I9YrUc/GZ5S7zRgi2+7yusPvrhSOohdkGhAqKry18f73E65Uq/PBzjxLY7Nxc8WxDkdzNVfQGRNvrf4EjezxFT1hIcwwvKvGrTzqL29SJ6y0cr22GHDNezB6dTqAmRk/v3UEgMco//qA/C9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977487; c=relaxed/simple;
	bh=8yW7u0NaUnOs3S0TV95C8l/QQjTZEIeeRcV2PpBhZ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7sR3I/IKpzwU6M69cQL0+WPvqcdO7ndnVqMQNcoG62Y+VhqRssQzOigfmhOqp15luFo+VFeNly9prbfWR8cqBglVyrlv0LFwUPUJa4js1la9Hey6OvYRNX6qhqEepeTg1k9mYYXrvWmXWn71dQ4flIMATqQP8nDKtob8wZ4Ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk4veXiZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk4veXiZ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd8f9725b30so1482153666b.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779977484; x=1780582284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3aVziPKj5NycIaj4MEaOwtQnoFKY4U5moNnftAA/xU=;
        b=Zk4veXiZYoyECGyJkSiFmW/NGFshP2oGvsUMuUvkcIuhoKLDG5HV81akMj7zZF0UMY
         r6rzeL1fD0ZQj1afW1iP8pc4RirtiaRpcsqDu9n5nh+YucgCs3fdKPWr3FwNcA33zt4P
         O5OABeAw42RXGZbnDusHhSmraqTVJ6uR2hWxF0EgAHHx1ha+6zDHS4g1Ii1uGSyC2Wrv
         Yoi844EemssUQJeUgbv/pM6T3FgC/G9t3xijtxBbULH8RcaVEQbAQWuvhFZ+Cuwlae6O
         k2+d0xOQ1s1BETkUlM8N3RxqrCHuksF5P6bo7r8AIw2sgkSi2432U70AssX+JCtwdI3L
         qBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779977484; x=1780582284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h3aVziPKj5NycIaj4MEaOwtQnoFKY4U5moNnftAA/xU=;
        b=hL0o7oRY6D/UBffshTTFEr3z6BY47WAdAeP71vocu/vsaet695Buu/kFlDOrSYzQxO
         fes9btpy5N+ah+mAo1XPNTubTSQG2ULKhjOub0JGB5p78G5GIEhrkfkK5gAY9lCcW+xz
         cpfDEelVePRy3k9mZqfu7jJyTYuuqywMSVkZZJ+DD9e01FWpNZuPg1TxeVJ4GeicKS9z
         xKvvigP4F570FNwudG9qyTWizshWD88onEWhCJcOT81Ok6MNT7Et6Nn66R27yiui6mmn
         qSLXfmwcOYtYP3yHiZWgmTIsYCEdJMyGYprTpdRzg9/WbAUHCvv0AM9qhh6lMl26Mbn3
         5R3g==
X-Forwarded-Encrypted: i=1; AFNElJ9SbL1QkFe5Lq0yk0voqbOisdKzTUUkr5TYX3H5RN/HGToche5MW6TiyB5UJWtH2p3O6+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoY1A4vb6ZkmPY2lVhFyyAAfqfGyVJnnrEjgFRZAGcLELtrv5X
	FFYGbtEMV7CyW82r3ee2ESPiy43+lq4aFBoWzFsdM2xQJdmIR1wx9y+q
X-Gm-Gg: Acq92OGQfrlSFlrwAvDC/ScGbAnpDcICOEBk7zVLyvBClbnhzAHnthQ84WlNAyH6vNj
	3IDBSc7Ypt3ySLDK97GVILWw8XIX+k7HZ+cdoYfHZfm7mpdzKPwDYKGSCcJY723yN4zeZ/HRxPs
	vSaVszseuIKXs176aDH1lzSbrJuhiSgp4VTrOKMKtfo9dghp7owuC9H5WKh+ccRsGwSl1yV0DjI
	bx6u1rYMjZCZuyyIjUJfyfd6gZxENnQt6h+NJkVMZ0jNSqoniPwJaFOj8W8Naz5Z2tusRS+0+wa
	XdsssJGrVd5N5TszowQTX9M1R+Q+1a7Mddj1OCR4R8esMZdDkn1n7QqGXpQWbIT85CeJMKZt9W2
	Z84/ObhIvxZ4eLj60NU8LHzb0idkpFP16Sf9cd+vGHLBg+N1MkUq18x/TYV8FQCcF1lJ2bkT10w
	sXjgRPY1fvpQ4N7LTt482lGgBG02GVktp3xbnfOXYyHiU3tSZ4S52cFupeHa8yQIJLQ+i6y1pHx
	iBuOD5g/1nbfAo+2WIrHb9PHcAC3Y0G4HLOYw==
X-Received: by 2002:a17:906:845a:b0:bd3:5e5d:f895 with SMTP id a640c23a62f3a-bdd2aada464mr1171338566b.35.1779977483477;
        Thu, 28 May 2026 07:11:23 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc61de4c4sm737796466b.42.2026.05.28.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:11:23 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: shuah@kernel.org,
	dmatlack@google.com,
	vkuznets@redhat.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH v2] KVM: selftests: hyperv_tlb_flush: use swap() to swap PTEs
Date: Thu, 28 May 2026 16:10:59 +0200
Message-ID: <20260528141059.3337431-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ahg_bNoktd0XOKV8@google.com>
References: <ahg_bNoktd0XOKV8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded swap with the swap() macro.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
 tools/include/linux/kernel.h                       | 4 ++++
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index c8c18d3908a9..381e457960dc 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -46,6 +46,10 @@
 #define min_t(type, x, y)	min((type)x, (type)y)
 #define clamp(val, lo, hi)	min((typeof(val))max(val, lo), hi)
 
+#ifndef swap
+#define swap(a, b)  do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+#endif
+
 #ifndef BUG_ON
 #ifdef NDEBUG
 #define BUG_ON(cond) do { if (cond) {} } while (0)
diff --git a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
index 15ee8b7bfc11..514d41f00714 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
@@ -131,14 +131,10 @@ static void set_expected_val(void *addr, u64 val, int vcpu_id)
 
 /*
  * Update PTEs swapping two test pages.
- * TODO: use swap()/xchg() when these are provided.
  */
 static void swap_two_test_pages(gpa_t pte_gva1, gpa_t pte_gva2)
 {
-	u64 tmp = *(u64 *)pte_gva1;
-
-	*(u64 *)pte_gva1 = *(u64 *)pte_gva2;
-	*(u64 *)pte_gva2 = tmp;
+	swap(*(u64 *)pte_gva1, *(u64 *)pte_gva2);
 }
 
 /*
-- 
2.54.0

