Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6E3EFFD3
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289121; cv=none; b=lzaS1TReJ10cX4Yd1IZ+4oM2moQg0nuyc80P2xYvP/txVgNAec+2wRVMDCrD3Tj1kUdmBDqgIog5Y9TG0JnzARLV/PoX1qwZTs8ZSpIydrDXXU1GkAMMnudR3841w4w/9Ukl00rEiIg1wUxFYGKvYWb3gaRrhFX9AIVJ5wvmzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289121; c=relaxed/simple;
	bh=d65m3aBdbx0S8CJUVGyt4px76iD9UZTjeqsUvU+wrQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9ADPAC53+yAECWPJ0bwBS48DETIjExwlXQGB0RzZ3yfPvjDmlQSoYPT6rl2t/nmqHlB4z03Srn8RpRvhBjchzpTOSxg0tkB1vw7AfyHFXJRj8RSky7WEBKx2leIBocgherucXCunaMaJhc15TRnGBvfzLgZeueSgyuAI0zVldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjQZ45vu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=haEs1Gcf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjQZ45vu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="haEs1Gcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779289118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zGm0ZA5HO7hxFqkUov2t9cWkl/En7MXxAxFvmMFjoY=;
	b=TjQZ45vuDb/EidZL6vbd+t92uohBBczSFGjjZb2469AKMCEnlnh6nYKXedAGVwlXM/47z6
	OBcP4duBiLM26mXs1EFbgVyOqO1LxZb9VrfI/I6WP9+lqvDw3vS9b0H2+HiWef8Yfid/B3
	W8/zNIWhs3QM/qX2ny+rWpMeY5InRO0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-BE7CAv9-NxKrEPksVDcxWg-1; Wed, 20 May 2026 10:58:33 -0400
X-MC-Unique: BE7CAv9-NxKrEPksVDcxWg-1
X-Mimecast-MFC-AGG-ID: BE7CAv9-NxKrEPksVDcxWg_1779289113
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso4343383f8f.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779289112; x=1779893912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zGm0ZA5HO7hxFqkUov2t9cWkl/En7MXxAxFvmMFjoY=;
        b=haEs1GcfdfiliXOizJFjFTgZXpIIOh3FCf9mSFQdYJZzGsANWxMwtlsy33AeEra+e1
         BC7/M4bpojAQ6m00zzETgVeiDyNNwVAHM5k5BNSHWhZDH2h0lLbPOyfzFGLr26bLDUqB
         nIw4+dWyGDqM/SrkofW++InyX9aQjxxUDIdw8BpUCHOmEbGEo96Bys6x50VMTuA/6Hw3
         exZm35SIgI4UFlSojVEeDGJ3e2geroVbOoFtiTKER2T+4mXHGCTrEnNN83S6/ohjv7ME
         dxf5yhq3WTBBPwdxEQKCvje8FmzDn+HXjB5noWqeZYKjf3qz5Z26Ga0kRqo2R+zavUDY
         azpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289112; x=1779893912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zGm0ZA5HO7hxFqkUov2t9cWkl/En7MXxAxFvmMFjoY=;
        b=Q1HBKy3UTcNf81kJrM0MY+S++Ggoe7dlDUomxsqzUp63R3vCrTS2OF7zLiYIIjMqm0
         M7GIfEkWNz81Q/W6OKouuW4AkBqtQ6ztJ06OpoaHb2GFYXXw2F7g5+0i5ohQ8BeoyvHg
         ySkTqBGoLbV40MV4MB0F5IfbZVb0MXXri/45xxEyD7dXbMd9IA4X5iVDMoGPQ9LrMLx+
         tywuRi9AhByA+cpBGSBQqP987JYFpgGuGSaE86cmwIjxvrq8VKtKxPxNtJi9pZknZTDw
         z8iBQiHG4nywDzqM04cWwkHJM1DOjRAXGbFRt685pNXxxffMm7QVkUQwQHMmLm5L7z8x
         eEFQ==
X-Gm-Message-State: AOJu0YwNMjIdGdoJygxq4i3SQ1Va+v685FCEWedE7hVp13mFOcrP5gj+
	K6CC0P2DY7bMCGVbV2eGIfCdfWgToWvCHFevfcaV3cDIzt8UjXUUUJsUVZyaWrIjzzkqG0k2TWf
	nzf+Uv0rIkpMq+AA1J9r0ObEJ3/4IRqSu/v1TQNpwc2AOtE5wVemMtH5WTNLrWH/TgMbF4pDlQu
	W+NqIZDYq0CZwczssNW+Tj96mCHcriL6bvudunLiUc
X-Gm-Gg: Acq92OHHD4iry001V/9NrsTEhFnlIxuyS9KqACJvMzMdAClvDrQJgVMqe7WQq8lfbKO
	RKkI8WWXDjwKhZIEW3yly9pSRnzc8ymOUXnb6HLUk8cl95tA8rrP0H3h1TdP3qzGXiZDzjHJuar
	4M6kkXDjMhNS8n1+TJ5toGQJ5Lu45hhlCSyheAVuiRiCx368gNDK6BG7hPrOfsklb0MYCPK7JSX
	CMokXbsNKEhwpKO1dCMqt1KiPLR9fEIXyTykPmmu8bKGw2nshcQck6dOCTQAwHZw0E/4uQHCmMU
	9/vTkD/dxlifX2ttQiJerZcFf60TntbTAV/u3hDEhtS1QnuZOJz6VEu4ICR5KMH+4A3YZtW0Lmq
	TxRy+MbAKDSOsZqCwxaQv0NoAqxgmVNMVI3g0W02r+PRZy4DTbsjP0eqtOMvitVJ4BL3fdDKApc
	Ez6Sf/p6wfHVzRkIhLeWZwLn9cYaqfg3IL/Wf69fYk0hGF
X-Received: by 2002:a05:600c:4685:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-48fe5fd494dmr366717055e9.1.1779289111942;
        Wed, 20 May 2026 07:58:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-48fe5fd494dmr366716555e9.1.1779289111521;
        Wed, 20 May 2026 07:58:31 -0700 (PDT)
Received: from [10.110.4.204] ([87.215.26.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm469288695e9.15.2026.05.20.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:58:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 3/5] svm: cleanup regs handling
Date: Wed, 20 May 2026 16:58:21 +0200
Message-ID: <20260520145823.408884-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520145823.408884-1-pbonzini@redhat.com>
References: <20260520145823.408884-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unnecessary get_regs() indirection so that it is possible
to write to the regs struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm.c       | 8 --------
 x86/svm.h       | 3 ++-
 x86/svm_tests.c | 4 ++--
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/x86/svm.c b/x86/svm.c
index a85da905..1968400a 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -225,14 +225,6 @@ void vmcb_ident(struct vmcb *vmcb)
 
 struct regs regs;
 
-struct regs get_regs(void)
-{
-	return regs;
-}
-
-// rax handled specially below
-
-
 struct svm_test *v2_test;
 
 
diff --git a/x86/svm.h b/x86/svm.h
index c5695b37..ac3b0635 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -436,7 +436,6 @@ int get_test_stage(struct svm_test *test);
 void set_test_stage(struct svm_test *test, int s);
 void inc_test_stage(struct svm_test *test);
 void vmcb_ident(struct vmcb *vmcb);
-struct regs get_regs(void);
 void vmmcall(void);
 void svm_setup_vmrun(u64 rip);
 int __svm_vmrun(u64 rip);
@@ -444,6 +443,7 @@ int svm_vmrun(void);
 void test_set_guest(test_guest_func func);
 
 extern struct vmcb *vmcb;
+extern struct regs regs;
 
 static inline void stgi(void)
 {
@@ -457,6 +457,7 @@ static inline void clgi(void)
 
 
 
+// RAX handled specially in ASM_PRE_VMRUN_CMD/ASM_POST_VMRUN_CMD
 #define SAVE_GPR_C                              \
         "xchg %%rbx, regs+0x8\n\t"              \
         "xchg %%rcx, regs+0x10\n\t"             \
diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 37616476..95d18359 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -649,9 +649,9 @@ static bool msr_intercept_finished(struct svm_test *test)
 	 *      while RAX hold its lower 32 bits.
 	 */
 	if (vmcb->control.exit_info_1)
-		test->scratch = ((get_regs().rdx << 32) | (vmcb->save.rax & 0xffffffff));
+		test->scratch = ((regs.rdx << 32) | (vmcb->save.rax & 0xffffffff));
 	else
-		test->scratch = get_regs().rcx;
+		test->scratch = regs.rcx;
 
 	return false;
 }
-- 
2.54.0

