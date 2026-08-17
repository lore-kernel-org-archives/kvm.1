Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B663F4100
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967944; cv=none; b=DAAUCeruu4TG6tcQ7G6htobjRAcTrVkugwOYlsjR1Zn6+3o17mlU3nsV8GkbQ0ArDIaSd7k+kotdXmMot7zYBr8EWPGtyQxFvvadHP1TOwI2Dlc71trYasdzPMD533BW00klcsBjyO3n/SY1OJt3WDF/xbPN8aWBrgg5flfBd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967944; c=relaxed/simple;
	bh=pPYiH65+N685rGNJJ16GtG0J6xDm4OpdInIOSAG6ZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzCkr6FMsQQC+8vsmHat4O/jQicDGWfwL7nSG9o427mQhr8wk/1PE1HWcsvlmS/vqB8mbsqP0HtELZ9OcxicYTyYBfXmPB21E6bp7StvPCsOnhiOwFcSniohb/z8Q9q7pyILzHtdGhE9bdlRlsMNu+GMR6pZiESN7z3WtGG5iZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owMjzPZG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owMjzPZG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52cd38ddcdfso13989101cf.3
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967942; x=1787572742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AeJCLg2QU4dj3yR0M1UHRgHzRf38a6+0JGJIT48x0Gg=;
        b=owMjzPZGAl5sEb0ao09wxHvfep3pRIOsk+HoOtYWjFPzK4IKKGzBd61IXJ6Ej6JMAa
         G/Lu/dpRXs/Xnke9pCx9E2V5Z8vtElWlMBOG04foSrm7GU6ZDLXHJYZ9EadMQ8iYvMus
         icjrRkIB98BdnLLwZw4CnhA2TXYrCpzjjRWt6osw/ahwm9ybLwqyRPGrAB9gbpVC9YqF
         30kRH0wFxfrgJ4CS+LyO1nVq+30+yc7Bp9tuAkxZIrLOJWc96BwLS+TdpjyjGOrOnw8L
         uvfXdGA79SE8XIteY7ui5sJ/bc67VFSXed+I06uYY3IBQzyjEHqObHF0wWgViZZN8G/m
         5r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967942; x=1787572742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AeJCLg2QU4dj3yR0M1UHRgHzRf38a6+0JGJIT48x0Gg=;
        b=Zcr0IzWjEINTonYkzwtWMZ78wUcF5q9Aj4LsMu4JJmYwo3FtMwJQBdEg87fnexL8KL
         yGToNRZkYMFOAugIkqW+heZOA1LWfo4jF6qZS4lmB69hvmiv4F8m52v6CJwlXzG0vBwP
         kVN+vpfGAnTvJ7vDRL66wkXdWJ1k8PGGH9l1dExHi/lTp5U0ejFD1gbCIhsheVusIYNK
         Ls9OjX9HX3NM2HDHilygaf7sDxjv119Bw51VEWhe9VBmeoLzfgaT/8GYWGJ8sxGJYPxE
         M0tJZc6dqNIO0LwdPs/70C9nYCaEOweYbNCyxx2H1diG3a5O0bUrTYVzkXvSgJaRUJS0
         PGzA==
X-Forwarded-Encrypted: i=1; AHgh+Rpdfs0AYZpWVlFXSrke8+oopIhT1dFlMRujNMXHBATxCcJfgf3Vb6wVi1wf8HIF3jHRb7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTa0f+DILFaI78I8ZElo9t+coYJ8bDI871A7wJyQlwQKrHgp4e
	RjCRrZhdQBZ0AjDZ1Sw8DyxCJh1xADLXLScwDsFwRLgdEl8UE/vh6FiP
X-Gm-Gg: AR+sD109yPOgt0CfrGfk8iNjGsaZj4OTxiXFTRompamz7dl54ubuB7Chbc64o3+MI4e
	q2ryH2bEc008QzcEWebl5mT0mHsNU+AQ/akTiP1Z0aJ0MsPDCGJWEqYRjEiQ9dkAefObePzoJPT
	WAePhHtNAB9ZADL/Mbr35Jp9IgrWKuDHuWXY1vF93CKG8L+SGizphuLnA4fmP+LfQMXttEkP/Ss
	rZVuE7aK0CXWeFQevxgjTtDDmCDDY4QoqEuvvePRQ7xf1EVxQFUpLaQjOG0YykgU0ExDC7H6yjE
	WWrSXH1dqc745oGTCeXzyBIcNHcwQnsvJoGrwAfX3R5RjnkXvnCDK8h30y7DZy18MTwKuWwEPoP
	MkABixW7opynCjcHBDoZVv/P083oclysZ/9dtlzmLoRENYIwlfaVsqCW3aqUMJDfnGJiS70Q9Ee
	ncXd6s1gArb3RU5+Ez+zWn3t68d8pUAhq26H33MRBHsD77qnVlxAv83SQ7wy0c1f7xrf9xIK9g5
	g==
X-Received: by 2002:ac8:7e93:0:b0:51c:1c2c:a8bf with SMTP id d75a77b69052e-52d85584629mr242449191cf.43.1786967942289;
        Mon, 17 Aug 2026 04:59:02 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db6239ea7sm12681721cf.21.2026.08.17.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:59:02 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	lixianglai@loongson.cn,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nagachaithanya9911@gmail.com
Subject: [PATCH] LoongArch: KVM: Fix memory leak in kvm_loongarch_env_init() error path
Date: Mon, 17 Aug 2026 11:58:47 +0000
Message-ID: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_loongarch_env_init() allocates the per-CPU kvm_context (vmcs) and
kvm_loongarch_ops, and registers the perf callbacks, before registering
the IPI/EIOINTC/PCH-PIC/DMSINTC KVM devices. If any of those device
registrations fails, the function returned the error directly without
freeing vmcs and kvm_loongarch_ops or unregistering the perf callbacks.
kvm_loongarch_init() propagates the error without calling
kvm_loongarch_env_exit(), so these resources are leaked.

Unwind the already-acquired resources on the error path, mirroring
kvm_loongarch_env_exit().

Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 arch/loongarch/kvm/main.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 3e1005526f4b..685d334cf957 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -385,22 +385,33 @@ static int kvm_loongarch_env_init(void)
 	/* Register LoongArch IPI interrupt controller interface. */
 	ret = kvm_loongarch_register_ipi_device();
 	if (ret)
-		return ret;
+		goto err;
 
 	/* Register LoongArch EIOINTC interrupt controller interface. */
 	ret = kvm_loongarch_register_eiointc_device();
 	if (ret)
-		return ret;
+		goto err;
 
 	/* Register LoongArch PCH-PIC interrupt controller interface. */
 	ret = kvm_loongarch_register_pch_pic_device();
 	if (ret)
-		return ret;
+		goto err;
 
 	/* Register LoongArch DMSINTC interrupt contrroller interface */
-	if (cpu_has_msgint)
+	if (cpu_has_msgint) {
 		ret = kvm_loongarch_register_dmsintc_device();
+		if (ret)
+			goto err;
+	}
 
+	return 0;
+
+err:
+	kvm_unregister_perf_callbacks();
+	kfree(kvm_loongarch_ops);
+	kvm_loongarch_ops = NULL;
+	free_percpu(vmcs);
+	vmcs = NULL;
 	return ret;
 }
 
-- 
2.43.0

