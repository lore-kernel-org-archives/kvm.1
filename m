Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F93DCD9D
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288167; cv=none; b=MF/Zc92f8CRIqpZRNUVqEOhNCDdSiCkwCotOOMr8s+UfGqWHFnCwR0xEmMcm9pq6EthgkFlh/4yHTIEoeeDWDMYec394M8aesxeGqHNBKdAJXLrWtip5VrOiELdoq0dEFz293ahgjkl81U/EG6ycA2Ieq74OmgjMkKfDcVMwi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288167; c=relaxed/simple;
	bh=xtqeKnmICqJB3ueaZ9p4moJ2CHs7fD+L0lszT3gz2kc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IilgdME0cJxvv0JEvZ2YsXxqVKZMyQRWsx99tSSDg3F9JFYa2QqzucpFQ3r9Z+JrJJ/7DHWoF1vPYBXbcbbUZV12yjvy2BZP7cdXXa+rmHNLBSRqMELV1NLb0MhBqjzSMokd2zOP8NtJuO96MpXPt174UovZ91kQjaoM/uzBxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOlBBF4E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOlBBF4E"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b0dc7731so2861760a91.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779288165; x=1779892965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acK6gz2En+KV2sCM+L4SO1/kZROCTsWHOVeXPLAkB/8=;
        b=rOlBBF4E3icEXnA1fSdarfVB+SuIi0nyNKj0uC2vM1wMyKbxTRkJHKt9B7VxEsHFw0
         P4LvNvToJh3cHWRyi5un15JG0xO8QHrytkmM1E8DoDvu0UqMC+6rodriJfasYf5K3czn
         sjD0tZc/bHb35Hz41WDeSN6/sFhxNyruimizbYXo7y5RDjJ2gx45Ill8Lr5PLagZ9P9P
         QPa/l1TboBhk3OdOJ1xau1lRU9ar3C1gxffg6xw0y5nlRIiJ5O9iuZo+PC793/Hirx1G
         mgQFX36Ws3aCyI7NJ/gSNFCZyRgH217R9fodCbA1d0LqVEY9fljA9nfJm7Qvv3U2Uh44
         gUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288165; x=1779892965;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acK6gz2En+KV2sCM+L4SO1/kZROCTsWHOVeXPLAkB/8=;
        b=gCZyIWlY/htKMGeyjLCnBRM2OLM21MG+KtblQrmD/jkvGT15jrYItkm3LHgztk4NX0
         6DSr0ck0AJklrAegqtatDgOPa2SngX2WVZSo2LqKCiJ1GvuDG8uPU2zq86VLfVoCelEE
         M4nD1w1FyTY6p4dhsge5329H7Vo4DaYy6/A0yxMTtGz/2LaYbCzXpTK4mpGiPEnYTB4A
         gaxYUWhGhID9wfL8v46Z1hzpemltbA6q6a/V8NJNMCOyV/hLzjGn3muHPpyJrvHjKkLF
         cUpQ1WeK2RpuPZlmwvbX1sl/Qk4a+yvOop4u5apltbko1XczxaEOT2y/vvpz/jlqQSQH
         tk3g==
X-Gm-Message-State: AOJu0Yw9BtWLyVHPmCeTIPvx4+KIXAXJs4wd4f0tDcnZS3bOTv23FWxr
	HRHW1iR/7naL3Jx313pLDd47kakLGyGFIiSvZJXTDuVIT7Ij6w/Svcval1Xmz1C8+kdqnPUWonv
	9Bbqsog==
X-Received: from plom12.prod.google.com ([2002:a17:903:3c0c:b0:2b9:eeb8:3e6c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a23:b0:2bd:4d97:b5bb
 with SMTP id d9443c01a7336-2bd7e8a3c7emr292001825ad.12.1779288165419; Wed, 20
 May 2026 07:42:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 20 May 2026 07:42:43 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520144244.2657106-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Remove unused X86EMUL_MODE_HOST define
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop the emulator's X86EMUL_MODE_HOST #defines, as they have never been
used by KVM (they were likely copy+pasted from Xen's emulator).

No functional change intended.

Fixes: 6aa8b732ca01 ("[PATCH] kvm: userspace interface")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/kvm_emulate.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..09d3154efa35 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -520,13 +520,6 @@ enum x86_intercept {
 	nr_x86_intercepts
 };
 
-/* Host execution mode. */
-#if defined(CONFIG_X86_32)
-#define X86EMUL_MODE_HOST X86EMUL_MODE_PROT32
-#elif defined(CONFIG_X86_64)
-#define X86EMUL_MODE_HOST X86EMUL_MODE_PROT64
-#endif
-
 int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int emulation_type);
 bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_FAILED -1

base-commit: a9512a611bd030088f13477258d1f8103cceaa40
-- 
2.54.0.631.ge1b05301d1-goog

