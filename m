Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FF424640
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518974; cv=none; b=fy2VGWJDoCL0Ak7qhyXG8EYhXAGqeLJqgwfaMU+tCRqZ8vLmgfOwnF0TWbBBzngVuRKoXz9PDWIyzA2oLyk9VXI1uW2HKuZRtfVJqNCEc/OpCIyTkEr8/nFm7byDPmNRiiuY0AsrIpuDq+HQqFenFlQv9Qw2G/Zpvqi7cYkVQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518974; c=relaxed/simple;
	bh=siKvIRDo0Y/Ydy26WcZsy+aK7Af8tKFw9dsj7ZyQA2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFaN+o8rBQfs1qrthTKl0Gxu60PtQa3VZIVCusgru/p+HL4d1fkjM9qcC/kWlnhgp0xSZ018z0qMKL4Lo47NMs8D9HkvvMC8K1KQuljTId5WGp4+CQWAw7w1IBeDCvIexyiflawLqccIWmxwRinVL9NsyE2rwHrT33ukDjmdMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqvk15hs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqvk15hs"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso903486a91.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518965; x=1784123765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9GXuiVc8BU2jouaQOtlZOboIae/y18lrkf7oOk1X/0=;
        b=Gqvk15hsG0Cht9er7K4MVpZM2UiL2/0H0dew8DLcL5zhdavoXVSWAdc6OgVMrRIu+B
         C7/P8zJKy3PhAp9AeSQkywPQN7fyGKY3z1lVR31gqRMHRmlYJ6bhGX6gMONGFxwDQ2n0
         ykkSg+RHXvuqnLKMdCpz4Z/XQYzx8wt1UHN7vHTjioDniEO94kTfyalUDCPNlpTcw/oj
         FrsU+AgrVjO4XteKUnx2/CFmeXn7SYo/zbJvq+L6DfxI6C0tMCngy/XSHA2hxEvqA0fo
         cLHURLhKErL/BCVBvMH9FseIM8s6w05niOn4xqib6zoCJvdRIN+1XKpUHzVov03Sx0Sv
         oTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518965; x=1784123765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9GXuiVc8BU2jouaQOtlZOboIae/y18lrkf7oOk1X/0=;
        b=JSsGIsNcWNCVfPeICUww3d49vAqTDePTHglvTZ0HjiVxenBQX2nR6DTBSzNMZHW/qN
         APQxLXswSzkYqxcqUduTEwClWWZ/q9Nf4sSkp+VM8cBapwOh/Dq+K0ETEAzb75OB7oP9
         nmFa3LYhI19WyalzCe71Z24+VOM6zfQ4cb2KTv4mFFrGTL+b2mLsufxhQrczcQfNviqA
         51tGWLzlXziphVu3yp52woNPinHm+dyxCvFJ/WUp0bEEMoOudaDZMfyJ0B2vSVdPeMJO
         3lUGkhaJBO+sjNNNhRwMj5ZtzAbf27ctY1jcxy3qEBIHFkUF5j9Au59uWisTivENZAL6
         4ITg==
X-Forwarded-Encrypted: i=1; AHgh+Rpg37sK1DYTPyOXk49yNag7ZBKlfsd0zi2FSNXmYO8vCS7g0CADkI3NqYJiFF9UiBQ68bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbNABcrNuoC4iGW66uet0OkM+wUH4r8XXF35xJfm302BUZ8NB
	dPP/pZ8cQN4f0ugl0NesEtpaIZbXlWL1eU6NJQZMGGwfGdHvVQ8GiWeX
X-Gm-Gg: AfdE7clWfTUGO/imqHkO4op2iu2mZbEAfwmk8tTac+qEc3lTKIMCqYzIYClE4H9I+Iw
	Q+rYplXidqLpH9/8xUAgHidgfM9VP3Dq5ky9RAcwn2ebxVbIHRCdJqNssvcJFU9X5AORB0k2Lhf
	LvcdUNSFykuVWbcS7qAKS+6i31eIIkL8OJfQGxKmmUd/nCOkS5dEH6OTbam6g/z4aOtQQbv4IkN
	W38rspl5vG6iaUMGDCLXnH4vXaJ9WKfDiYVTc6yUft+BOOZCpdr8eXAoVJ0dwOactOYg/dOWydy
	wTvFTbjMGhkxWXDf3scQkyRQVrCrFGdAXEEk266497GEta1mhdPND/1gDoD6W1CAqneNoenbhD/
	RUtd0PfhH206jptHDy5qIHCUFhsAeR5rjrErnebKX2Qo29779owa8rason6HuTeFDudeYmm+ckk
	QBcwva/PzbSb5gQbdZgm9BlMlgHAdB2LZzTQi9Bg==
X-Received: by 2002:a17:90b:4b81:b0:387:e0db:3d8c with SMTP id 98e67ed59e1d1-38943954dc4mr2403328a91.39.1783518965168;
        Wed, 08 Jul 2026 06:56:05 -0700 (PDT)
Received: from honglab.tailc96cb.ts.net ([140.123.97.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d3c675b1sm2742891a91.15.2026.07.08.06.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:56:04 -0700 (PDT)
From: "WEI-HONG, YE" <1234567weewee457@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: vkuznets@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	thuth@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hank20010209@gmail.com,
	"WEI-HONG, YE" <1234567weewee457@gmail.com>
Subject: [PATCH v2] x86/mtrr: Drop stale linux/kvm_para.h include
Date: Wed,  8 Jul 2026 13:52:32 +0000
Message-ID: <20260708135232.160302-1-1234567weewee457@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/x86/kernel/cpu/mtrr/mtrr.c includes linux/kvm_para.h for
historical reasons. The include was needed for kvm_para_available()
check in mtrr_trim_uncached_memory(), but that usage was removed by
commit bf3647c44bc7 ("x86: tone down mtrr_trim_uncached_memory()
warning").

Drop the stale linux/kvm_para.h include. This also removes the need for
explicit linux/types.h workaround that existed only because kvm_para.h
depended on it.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: WEI-HONG, YE <1234567weewee457@gmail.com>
---
v1...v2: https://lore.kernel.org/all/20260505065849.81691-1-1234567weewee457@gmail.com
 - Drop the stale linux/kvm_para.h include from mtrr.c instead of adding
   linux/types to asm/kvm_para.h, as suggested by Sean.
  
 arch/x86/kernel/cpu/mtrr/mtrr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 4b3d492afe17..db5bf4adfd28 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -18,10 +18,7 @@
     System Programming Guide; Section 9.11. (1997 edition - PPro).
 */
 
-#include <linux/types.h> /* FIXME: kvm_para.h needs this */
-
 #include <linux/stop_machine.h>
-#include <linux/kvm_para.h>
 #include <linux/uaccess.h>
 #include <linux/export.h>
 #include <linux/mutex.h>
-- 
2.48.1

