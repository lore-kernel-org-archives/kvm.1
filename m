Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917F3CCFB8
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792712; cv=none; b=eBCM5KPnVVE87yv4h/2b+zMDLDq98CA/TVLiKufH+RdPM4+Yux6MBsBFmScnIDRiiAuMg2qPuoQgtRKnZD4uQlwkDQy8UkK5gjbTLVRxU2iJosAYlwS9w6nxMtGcKR+74ZZbQtj9HNVtiZNtQ1YZa5jtHznO3yUto4A5np7sVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792712; c=relaxed/simple;
	bh=uu/eVGmY4jszIdxUVV78nE/gAar9lsAWbDPkpKmZx6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YCEob2WjRXR6L7+p7uMuiadLjdxqwj7+xvMHS4ux5ET28yHl21VWBKdXU1JSsyu5hgmJxgg7w9aytll83N647CGWr9kmOK4KNwXgVSBF+hB2dGI87zPdRejSnIQnO0dwn+3SmSjgcd6z7ETeGeGbUeVU1/wybF8lxURawXz2rY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTiCGj5S; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTiCGj5S"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4678c6171so89649195ad.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792711; x=1779397511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4R31mhB9LPzZ6lGiM/hPWTIkSVZqZJa1zBm1MUkecPI=;
        b=rTiCGj5SPSYgfWbPbW7zSGMPFz2aYhNvqtzNgt1kNWXJZpxagNMUx+bCjNzdXwzg1h
         ZmKDrr6J1JGMSUJKMkAftpWNCDcm6WRoAQIJa5zP1tlPi6NOSfk5Necv/iborZB8Mscc
         FzUSeV7DsC8zKKQpoCndgftb1g/Oo7m2nrLWZxV/XByhQdM9ksVmbyhEYUzi06bq4l6m
         V4un+BudyoGkxlsilRcWTr48whcJF7CcgT2sHIhCPgh8Csc8iCxYREJF9tVi8td1aPaV
         I6l36LBBsvaIGNfxuJlNmY6G5CFowoGG4YbguAR097VePmBB645K5eEpc3CiaLRPVZHL
         uXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792711; x=1779397511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4R31mhB9LPzZ6lGiM/hPWTIkSVZqZJa1zBm1MUkecPI=;
        b=JV7ZtaJw+KrEjOjT9WtcnQ5MtQrdFS4VnKGlcWriI/a7kR+usXLzQuW0dkn7RdNGo5
         YC4Pb4VDS9Jgy8UByyW7yJuu8haNCs3xtJNRMrhQ8DZ52mxdzNOnZnqfoPQtAoEK4SzI
         n7ZY9/MpAyqoWG7ktbf3MUbOuPFq4VpgiiQX5Oc1VlURCRxcKp9ktQCUEY593y5fkEN7
         aB9hwUlN6Y6xwYpwMAHTY6c8xTYwfTgkKMpe/T0oCfS+I7sUf+x6miaHiB/s75mT5mrX
         vRgVQ9TTtBkons1WimrTrirnCygruQrDpLCqBdQwmk1K93pAHbtlRP5O+SO8T6KaJumL
         n/+g==
X-Gm-Message-State: AOJu0YxCgq54qe8nmYsnOE8TCpTMyK2MwM18WZZlexRFdi/h7sMhOPCU
	c+PHV0NOJ07i7FQ8jML5w6rF3AhX9nLiaLEjN6gE5iOZZsY7JBxEgLs9xKUZE4cyimU79zzKQdP
	cv4iADA==
X-Received: from plsq22.prod.google.com ([2002:a17:902:bd96:b0:2bc:ae06:63be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a618:b0:2bd:5026:ca11
 with SMTP id d9443c01a7336-2bd7e782af5mr9414365ad.2.1778792710450; Thu, 14
 May 2026 14:05:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:47 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-8-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 07/20] x86/svm: Don't VMLOAD/VMSAVE "guest"
 state around VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Drop the completely asinine and *extremely* confusing VMLOAD and VMSAVE
usage around VMRUN, as loading and saving _just_ guest state is both
unnecessary and dangerous.  E.g. GS.base, which KUT uses for per-CPU data,
is handled by VMLOAD/VMSAVE, and so loading guest state before VMRUN
without loading host state after #VMEXIT is wildly broken.  The only
reason the code "works" is because all relevant host state is copied
verbatim into the guest's save area, i.e. the host and guest use the same
state.  Double-down on sharing state between host and guest as a proper
fix is much more involved and delicate, e.g. would require ensuring
GS.base is loaded with the host's value prior to swapping GPRs (which are
per-CPU).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/svm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/x86/svm.h b/x86/svm.h
index 4e7e9e7a..21b3ac99 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -435,7 +435,6 @@ static inline void clgi(void)
 }
 
 #define ASM_PRE_VMRUN_CMD                       \
-                "vmload %%rax\n\t"              \
                 "mov " GUEST_REG(rflags) ", %%r15\n\t" \
                 "mov %%r15, 0x170(%%rax)\n\t"   \
                 "mov " GUEST_REG(rax) ", %%r15\n\t" \
@@ -448,9 +447,6 @@ static inline void clgi(void)
                 "mov %%r15, " GUEST_REG(rflags) "\n\t" \
                 "mov 0x1f8(%%rax), %%r15\n\t"   \
                 "mov %%r15, " GUEST_REG(rax)"\n\t" \
-                "vmsave %%rax\n\t"              \
-
-
 
 #define SVM_BARE_VMRUN \
 	asm volatile ( \
-- 
2.54.0.563.g4f69b47b94-goog

