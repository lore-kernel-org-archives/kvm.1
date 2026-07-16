Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E141F5CB
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214734; cv=none; b=bpzhQJTNbAgqcPsqtVm6BAYQ3PsxQiJ6/5VSH4e1hdZ91z3iHuRC31mJOrb+zJlB8JzlC+jyeaaWhssO19LeHntCQJtfrLB9ZehsR5dCS4Pdj+nQZQ3mTfyJiesdKYJmF8wYxlMeUNDUahAkD4qE4rCQKMpS+2th6H5EH5yPtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214734; c=relaxed/simple;
	bh=GLp+juEsDrHE2elzXTCgtE3pWsJmhXsNM8FsKwMAwIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWHW62N+IfWUqAYrGiVUs6jS7PpTGisqYbObKSg3UqxRZNveE7em0wAmfQpwekfErzgeTTEyiH9KSxeIHqGQ14KusuwzivV84MkvBF3Zy0EUmBaamrRCzpkvlZrnwhxQsTIU8rF/nCX6rFa1wYULyqzwVVsMJvEERaFRGhxmckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHpSh/pZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHpSh/pZ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1601d552a8so707847066b.2
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784214731; x=1784819531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gG+g7cvO60t9OK2852iCKFbaTdC0A88G603w2VBtTG4=;
        b=dHpSh/pZNB8atMItYiZo+fDpuf1ZirdSMwAg403dTdmvn+AnqNlPZ8H/w4ekneM8xY
         c/sTs4xyR9BgvXdhyLcPk0h4GlnEK5AOkmIhI52684XFeHTZsjRag8LhvL9/LGsueKPg
         ntKjoPaaIZ3kpUfBu3xNLHmp7GD82m+DixW59YRqDdnQlW9FkWyY/yxvcZEU3wH0Aeiq
         q4c55i+IpS6EL1kEz7XoksEn2WYfsJRnri0xhAipJpfDXKpcrdsFtBu5iHxER0t0ahHV
         QZgfcwGoH/KK8FXUH8d2HWTguZqqQkJXeYwvEO7/UgllCjb5Fd0Yucjtc/jh1D0EBTTC
         a2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784214731; x=1784819531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gG+g7cvO60t9OK2852iCKFbaTdC0A88G603w2VBtTG4=;
        b=KyEPNKPvpvsFYQuGjcvJIEHIXy3xQNr6R7oCXmpcOcJV/yKw5gxDBdFO0r+uDFZEke
         yJDrZ7GtHLPId4ooBjRKr5XRxFh8QPOgFL3mtBozvtKS2zb8O3EouamZGJ0KRWnGnQst
         bq+Tv8K24zotuJjksHPbB7z4V8nce+F2GmrKQmt/nmvDnBBrBSl7zik6+gWcHL7NjE0U
         /w68j638sjZJUtjdhZlMX4c43+C2TG6z5pnFXWGydE012EidgrFo/4dkq90DwvMv9ZmN
         kv4ILSVjtbf6Gh1/RK4fgTR77bScS15mSvwCBcAU1SLfLZTJHMMrzTBWIraGNt+TtcJr
         kNHA==
X-Gm-Message-State: AOJu0Yy7SBo4EEmAViCNDGzWwgt9Hkb7Xq9FG4g/f9xUvX3cLLw/T+Eg
	k2NbbyNPVm4MWJTZClOfhj4K5a9Vv08U0FFIKUIKkkmlsN/AE+TC3cHqzFSZwFm5YY8=
X-Gm-Gg: AfdE7ckfqlFejxMtO1tTK/WEwOD/nbgwORGkxuijQBj/Ke48lBCt5cpBmeJgg91GJfD
	fyTfLHXWsEChyXctxNetisWIgJ0QD26X0esIKobg+QJp4BSVExM7pI/r4xZXLWI+4A0uwF9ErZy
	u28KRkKV+m+P7MCKEIe4WjkyHKrM6PE/ow7PjoCwHJsUagM5fMfRt+S3u0G0+AvVK5uAgO1GbT2
	gNAsorpQ8xe5MmI0+wve6acfZyMoK+oAqkV/PWE1B34+qgR0FUn39NhNkV3pFbwLK1C5Aq+q5Z1
	RaXdMQj17GuibkKMfGfIA6zXIiQbSS9/ZUu0AdiQPoQMDobJDtKGHj1x21M/O5Lf7D74euO0VxB
	bpYtzofvaKVt5wNaLGqa3o7BYFgvvatvnEJIcOgc6LCgwOczI0sOxn1mhSsAnf1Z7xeUQ0pJ8dW
	nL28JS3J0FbpCUKv+wDFcfN02O0iGuVz00UvzvdLJL+jCTKLWlzS1Vy5FDPLbaGpV9XWNuOuOXP
	sZofA==
X-Received: by 2002:a17:907:3f12:b0:c16:13c3:b1ef with SMTP id a640c23a62f3a-c1667a0cd22mr638712366b.24.1784214730734;
        Thu, 16 Jul 2026 08:12:10 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871262casm236607466b.6.2026.07.16.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:12:10 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH v4] selftests: add swap() macro to kselftest.h
Date: Thu, 16 Jul 2026 17:11:51 +0200
Message-ID: <20260716151151.697403-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260528154003.3594107-1-piotr.zarycki@gmail.com>
References: <20260528154003.3594107-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add swap() to tools/testing/selftests/kselftest.h with an #ifndef guard.

Remove the local swap() definition from mm/uffd-stress.c; kselftest.h is
already included via uffd-common.h, so the local definition is redundant.

Use swap() in hyperv_tlb_flush.c to replace the open-coded PTE swap and
remove the TODO comment.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
Changes in v4:
- Drop uffd-stress.c's local swap() entirely instead of guarding it;
  kselftest.h is already included via uffd-common.h.

Changes in v3:
- Add #ifndef guard to mm/uffd-stress.c to fix a redefinition warning;
  uffd-stress.c defines its own swap() without a guard, which conflicts
  when kselftest.h is included first via uffd-common.h.

Changes in v2:
- Move swap() from tools/include/linux/kernel.h to kselftest.h; kernel.h
  breaks perf (swap is used there as a function pointer call).

 tools/testing/selftests/kselftest.h                | 4 ++++
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 6 +-----
 tools/testing/selftests/mm/uffd-stress.c           | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

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
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 700fbaa18d44..3a85a29203f4 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -56,8 +56,6 @@ static uffd_global_test_opts_t *gopts;
 static char *zeropage;
 pthread_attr_t attr;
 
-#define swap(a, b) \
-	do { __auto_type __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
 const char *examples =
 	"# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
-- 
2.55.0

