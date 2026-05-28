Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03413FC5A3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982818; cv=none; b=OVJ0hi+13OYDEq5Afi4MLikOMc4FJY15eiQ/1sJDFCsIfKZDDaxu1g9RBLTnUb9AXCCm/Gj6/KairMZIGzPfhiz6FnOpqzoa7+SeDAS1Ms62g+39rg/eXcsSrnS2C6bdNkJ4qPgBYx8vH/G2ki5n4sidoAsSZAQ/pfmkO2NRU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982818; c=relaxed/simple;
	bh=40hTyHTWmWVmnUmkNo8LP8bjo25L69ajUABKztAUmTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSdhYYUCsrp6+n4HeJeJ4r+z9OThqCQ/wpue7SQTvmQrQ3pKab/0YFK6zB5T25enObzypvC/kNrJbcSb6WvbazWcjT0ZdolOl1OzoUZgrA6dWWC+AR2o7QpdA42c76KkFY9vbXmV0SRZJ87Ml3jygsJc7jhLicqxFp+POrPh8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RznfZj3c; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RznfZj3c"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so1956231366b.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779982815; x=1780587615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C03LW7quzGbsenmPANy3Ar0KIVx7KQzxzMMVRcyqs4Y=;
        b=RznfZj3c0K3lD2J00TBCF0OtUm6fcHDIwtuw+xVbF2FeuVLQyuJziax/4o0UgANjl7
         3UYokrosAVH6NGNrL8fiCkzzvWjvVHk5TfwCOndcxH7NucaawWFFL5nzRY3dPkSshAnV
         behOh0UNSyTBDbT4Er+k20t3vyrOXKLNfK2KLjUWiLns7H66jNUNMq5NjzNPx7zmFNz0
         D8xICqz99geRoCYYyJkjZ6x7FV12OP2PJHz+aH8zKY+BP4rTUY2MATdAUpPP+03y7a1A
         7i57hR62VmQJ7jBsBZ2ZjMt5IjNA2XCZ99fGTTKg9l9KxShe9gmn36zS1EV+YEBKiXq8
         eUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982815; x=1780587615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C03LW7quzGbsenmPANy3Ar0KIVx7KQzxzMMVRcyqs4Y=;
        b=hsYLes1opLY9qTwyLuf5GiJPB6eFvL+0eH4c02mxZx9k5uwGsEDoVsxBC8PQ7hM16Y
         eF/C4pz9zfacgoe+7WL7RbbVcuRbJy4dUzXbhdq+0zYQJAklUd5OfgHigjG5CUlDY6K2
         fbmyNdJY3hm+kXNabD4lP6QU1rY/x+wkfzmWImQT6ldW6jI1WXvtGzywbKQbZD+KUS7f
         ForqmdbHIk7lmT/prodM++6KPpHCvq1ahGm2sxIRaehVKxQQRuXLiC2ud6y3sz9L1AC2
         TfQHUaa/01PrgQPgrRkdRDjBBUnj5bZFyB6Q5upIp4wslVmLFDFELrFEIrVPFRJEXjZC
         3gPg==
X-Forwarded-Encrypted: i=1; AFNElJ/ItL/3H8/YOe9t0njihXAHOTl+c73aAxhCt2YZuklmq/8llIEs1Sc2lurzqjq/5Filvrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrXNXtN3taUnDZm/pxdrlXp+VdaetdLXCmlYHq+AocZAORkMW
	ZyG2LS/T1Jzs5hNNL02L+OvouWr9l5wYieHHiR2+v0lmUDkNS7JLVKV+
X-Gm-Gg: Acq92OHXJBBlq9CO7fD0Mf8QidQutyS5MPScmccIZYnaKdKmlnBC3XY2FWMpV0O8M4A
	8ThOk1KXj82kJATubQg/kKH8giNrm2w5uL+VhuDffxq83hwmF2XEZQa8q7sh5i4eWxh6MRopTrv
	wLhrr226oXvruwochIEQx6qeTtib2Zkdny0DK2jvBHhUqWWeJ8NvumpbMdooQ1X/UOkirUaIbqx
	F82VPr3vfJiJ/d+2BKqnaD1hbMrOEeox/maMHECkXW5etLUPw8sdimOaEdGKlWNW9ACxgTCKCSE
	I9AgeQPtI05b3wDqEnMSuTP+foL7h8bT0jCP9wmPpAs1UWKTx56vZOTGdA3/1HzBIZrT3o7zoOR
	6q1Y40PBgVvxw4TR1J6I1FOU36+RZ12aGqJku6zK/lNIJ79N8W7DeyirpPTx9jM++90j0+1D6w2
	41F94mRIDkjVEfHmDuvDkzbtLN8Cd3UFy+Ywn91iMEnHxyBD/FUmVt2gzZvllPGQk1CCdfSdJtz
	Ey1PNaloOKgJi4nL3AgODxWI+QUU+KlvHmcBQ==
X-Received: by 2002:a17:907:b14:b0:bd8:1c88:cfef with SMTP id a640c23a62f3a-bdd2293182amr1257782766b.5.1779982814886;
        Thu, 28 May 2026 08:40:14 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc69d716dsm736438766b.62.2026.05.28.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:40:14 -0700 (PDT)
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
Date: Thu, 28 May 2026 17:35:25 +0200
Message-ID: <20260528154003.3594107-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ahg_bNoktd0XOKV8@google.com>
References: <ahg_bNoktd0XOKV8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the open-coded swap with the swap() macro.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
tools/include/linux/kernel.h breaks perf — swap is used there as a
function pointer call. Using tools/testing/selftests/kselftest.h instead.

 tools/testing/selftests/kselftest.h                | 4 ++++
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 60838b61a2da..7f53751523d8 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -64,6 +64,10 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#ifndef swap
+#define swap(a, b)  do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+#endif
+
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 /*
  * gcc cpuid.h provides __cpuid_count() since v4.4.
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

