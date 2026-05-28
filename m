Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB73ACA7E
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961608; cv=none; b=LmVgvW/9C+8dGCV0DQ1Ty+allxqAictFHtfeTOlH3oPyK7VOgHjszOg8A4yCW/sSJHiuE9Q4+sYMOk2uIbAKOn2mu+nLHbfKlGfV0P8aMghWJLdjK+b+36Ic8SlKJrx9gmezESILSdO/+vDLNabNgRLDnFE+PBvnQiaaRqiKLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961608; c=relaxed/simple;
	bh=U45YX1bVE/BPWSzuoqEAH8fpZ7EUwj9Dz2GGIOroZE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlMzcWn2hSHHQ7amL0vBthF3qC14mptFslsJgTQZ5S2veg3kJHaZCpgHUhWmOx9UnGrwOu2rRTopYxBiN9klENv+w4f5gRrj8Vgw1NdexXLRDfKaJlN1ig4ld2cNHwQyhNnJhjdhVFggS905TDhebaEhEC7jV1MiGK2O8THkXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQGMhJdu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQGMhJdu"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so2134960666b.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779961606; x=1780566406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sS27ZkYmmSuo+TQnd/NA6YerqfqF6DQASvsyjFS6nzs=;
        b=GQGMhJdutvXGlDQ9P/fbptppFbMKzswvzYGatrgOXaufiGMM0/LMxtoZO9d1R2U/Yj
         rRlQoUYspW4Bingvp3Anfhg7f+hXQhW+apVSEAJs+jm0SNeqObemgOedYF7wemScjNBs
         BC85QLhxKCoejpnqXyHQWQGBtIY/Y6ythHaSa3JlieMRZatAlfzmqYVrTTLyJPQCzVlj
         XW3K4SN7AnLDoNq2MMWLOIbrC8aK2HsoW5ftnUVh8MoZqOveggl8jI8KuekUuK6gk8A7
         t6VemZa/M0tCpjQj7R2UbtS6EieTm+PPvVOiqhXcuvUFj9t8xQXqYEHBEUQ9gIULRAqP
         yx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779961606; x=1780566406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS27ZkYmmSuo+TQnd/NA6YerqfqF6DQASvsyjFS6nzs=;
        b=MRhmcSbDJ8nps8pA7WH7+tpK+47WlEKKvKPsqRkQKDqbeJK2STAUCpm8Pvi9xNg9Q3
         Erk8AocKcSXnnFL69O6eKD2vMO9vJlJE+9awXHWaaGdQ3D8lprZsfapGUcJvRZs9bNzG
         1uhrI5nhLXirf9xTaUX1OPO+IiysgALAsESMqetzA4h9hlDeiheVHcN2uRnh6e26OmVc
         d3ZhWyRK5mUTiSg9erYlP14n2MlFFF9mZzKWbvXumX5AgVx0V+UTfeQndmWNtS4dQjjw
         VPNYsoGmKkwE3C3TtfvUtJiG6yDfpshWQ3yBOwKgEsUP12yu9QK/DIL0YjM1zOy0dXzM
         L+8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Sp3zazVTsjq/ZZWzJgMnKxLslGRxLQ+Rc6xVAIQS3Xmw0AmfEuoslEEQqUNopTeqUUrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+VwMl8Xbds2a5pyxRvJEp2qmo3UnVr0BryJX2sjKbToaCjN0
	9YMBi35UnGi9ZQgJUypGSgeyaVTd00jP9Q7zn8gCc9xQl6bdsSJh6b3E
X-Gm-Gg: Acq92OFhHa2fVZtWoJdsF/3SVOrk3dQOOMwdEYbJ9zmGS6OxD0jtNjEXtedpXvAdlGh
	qYRhJBcMXRGrdVwdgUp7OCxi70L0a7LC3FdAlww2GUwrQrxEwms7jPZ7f7q9aO+9d5RjLjgryKF
	K6UgKGcdc9n9wMpDCVRiyAK8bDajREk9TKYV0jxWahg84q4lJmKlN3fUpnnYcT0AuQJ1aA1jo8K
	Nh3iphqfoYiGoI/3E2biTMS4PsHfrgPWBTWjY4rRUrx4Yn0X/HtZR3hRenTnCVoMuxcScf7yEpP
	gSB2rBVvY0fkdhtDF+IBqtk3F9+FZ/k/+CrEg460clJ/QYtCdWYX98CG2g1fE4TWc1vqKXBFY9b
	Jvo796foCwaefMJak+d+MNrQTSl997ECTD+G/oSojSKPLBJMRu4mBrf6ErvMcoHCWG8PKSyA5Rx
	98E94CKm1mufYHPnzLgWCVSWxCY/3u4Pa5ck7IHdN0Ktar4Jn5I45y81fkSutaJ63vSFgzNfcHF
	0uIAqFGPTU9FTLWJNEXCzqC8yYaN1PYBBLdhA==
X-Received: by 2002:a17:906:9918:b0:bdd:52ef:73e3 with SMTP id a640c23a62f3a-bdd52ef77c4mr1250022566b.12.1779961605153;
        Thu, 28 May 2026 02:46:45 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdecae32fadsm614281466b.56.2026.05.28.02.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:46:44 -0700 (PDT)
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
Subject: [PATCH] KVM: selftests: hyperv_tlb_flush: use swap() to swap PTEs
Date: Thu, 28 May 2026 11:45:42 +0200
Message-ID: <20260528094542.2529735-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0
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
 tools/testing/selftests/kvm/include/test_util.h    | 2 ++
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 6 +-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index d9b433b834f1..a66bc9ccba65 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -26,6 +26,8 @@
 
 #define msecs_to_usecs(msec)    ((msec) * 1000ULL)
 
+#define swap(a, b)  do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+
 static inline __printf(1, 2) int _no_printf(const char *format, ...) { return 0; }
 
 #ifdef DEBUG
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

