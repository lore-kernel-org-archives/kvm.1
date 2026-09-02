Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053AE3B2D1A
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332866; cv=none; b=McIfRh9AN6/ny2oM3Gf5vkNfrmiCfB41+PCJN+5clBUW2KTQqExL+ZPu1Km6GFs8CphvX3LNerMGXRAXUrbmPmEmMe3biHfAxjlg4NDGk4K9N3eeO5MFEtF7gJe275tjGksSrbLHoc40hQuLvi0iRGGQKevYqF4+7C/s9VTpb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332866; c=relaxed/simple;
	bh=E8kneu2xkHnm37YD035uh928QAzihNqmk/fd94fujuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK6aQIaki4x+nFIrPQGyU6JwTIjf43F+TUyRhJuSe/x1sPVXZyKs8ocdmwUsut75Wdy0BC3cch8XbIiuquUbo9xE5QqZL8UDDqg6YsYF5p1wTwzVFQncWmrqSLsopZ0uQIN3weqeVbezRZv8K/Qao8XkfqQBlSxlsLUaq9opwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNWZom/V; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNWZom/V"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39647184c73so1889825a91.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788332864; x=1788937664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjw7Yj8C+EGcBYthQYN8Kf9YjAONN+Q724TMv0sxgAw=;
        b=ZNWZom/V/0BwPLynEOF8C438L+CQsBpw0GFQVsSSgw5wUIvQKrwH73MlosJRA4IpqD
         weVIpuUUzZRIGdOVHmM1aURHLDUnY/sD1kAvLi4wwPTp97XgrZp3BmiX1TFxCO1ATKp3
         8wRfiRxZF/YpEG7kvRgUtyX3TxU1a27dK5fjFJpsFMnT4/c5sDq2kbN4IIWwnjMEO4UW
         NqIhyRp2j/OyZ716HwUSBE2xPSF0hfYdLOXoPipq26PYEC9p1k7WmbanSruQzxKM2NXJ
         uVoNmiaQ4EWgz5BOUjehUHhf1aPVmyQt8kdTOFfzjnu4V/QWVa6NYFZA2KB/hJlgp0N8
         70lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332864; x=1788937664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjw7Yj8C+EGcBYthQYN8Kf9YjAONN+Q724TMv0sxgAw=;
        b=BSJW+Y30fvF2py5GykIUABEXzWnG8LJssUEGOIjScD/pfceLgfCmrzzkiv9d5+k6h6
         Sw3+FtlQUH2L1T5/YI+2jvoq9xNSVEij3CKQLlhWUreTwQ2aYzj/RXrJLWWeD6UnhqAT
         Oh1OE8jU9DEGIp9t2/ilVvYA/rKS2AW4spepoH5vJgFDX/+9k5kAR2joWjrx7WV9Coew
         4M3i/kuxoZcswMq+MY06kQeMkux6Y4CZs5SRJaxa+zR6gjWaSNZu9VywIFn/h2VE3AQB
         eq6Jpc/fpC6lPYantewKh1us+kBq3Hth4WJWla0aSJNVf0EDQXYuNVINNC17CYTdjAlj
         EfYA==
X-Forwarded-Encrypted: i=1; AKwUvBxeLXc/O9fQNWnLJgr2OItJM3khKeZ04aITFGD9U6hobIvNSXVO+bO4cvdQ4U6lxQmvGoo=@vger.kernel.org
X-Gm-Message-State: AFuF++kz4dUx/0KookQqRaV8+XCQSUUipoW3n93+IAv+v4/44DCQ1op1
	+9teebUgE6SjlL4c8iX44TfSkWXC6ypxPs3z14p7mXRQwwqrZMvduFVw
X-Gm-Gg: AYBFou3+AZQyLURneYSqPWOLs1kwnxG6X+/uO5BZw2MTqzgPalLx/CZty/6DFuCSheB
	tgYmCEQ6Z6XrDnOdznYy+CkhVBonSBeJHLppdUI1i3Qo1kdTUwLq0v85nO2n2l6U2vMN/j9fWMD
	tWtc0rcfkAY+W0AHDJ7vq9/PM2ZzbaWQFG7tKM19d05yE+igXD8+5zLWN6DvR0z+PvmdijkKcY9
	EzFfj1eZmfw05pxv0BeBS2Pt0iHBD8qMdY3QxH9g/U+OjK5RMIzUr8ly+VlSjZ0tl/V3aY7Va7w
	YFSo22tdXa6P18wl7dSgz7jfpPYfKbV3KhryVYtzdRp717rYL5uhsgMlj7LzkWDCgBsqD3kYs+r
	amHqltQ7c0xw0hA4/dgGWaEv1YcrRAjaZ1Wa4iBu/5Xt/HG0hjx0pMbY5+h5o2j9nWKx9HQVGXs
	phC5R/8eMUz/IaurEhjATCQuls1HqkH/iMqdzBzS4vO1dk03OBmAFndqvhhFbbXUvh1ZAPZduXE
	g==
X-Received: by 2002:a17:90b:3c09:b0:398:c0a2:8f8e with SMTP id 98e67ed59e1d1-39af64f9205mr1192783a91.26.1788332864187;
        Wed, 02 Sep 2026 00:07:44 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c33f4sm4173256eec.1.2026.09.02.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:07:43 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	lixianglai@loongson.cn,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Subject: [PATCH v2 0/2] LoongArch: KVM: Fix kvm_loongarch_env_init() error path
Date: Wed,  2 Sep 2026 07:07:21 +0000
Message-ID: <20260902070724.3459457-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
References: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_loongarch_env_init() leaves everything it has already acquired behind
when one of the IPI/EIOINTC/PCH-PIC/DMSINTC device registrations fails, and
kvm_loongarch_init() does not call kvm_loongarch_env_exit() on that error,
so nothing else cleans up either.

v1 unwound only the memory and the perf callbacks. Bibo Mao pointed out
that the device registrations should be undone through wrapped unregister
helpers, so patch 1 adds those and patch 2 uses them to unwind the error
path in reverse order of registration. Patch 2 also uses them in
kvm_loongarch_env_exit(), so that the device ops are unregistered on normal
teardown as well.

Link: https://lore.kernel.org/all/20260817115847.2705791-1-nagachaithanya9911@gmail.com/ [v1]

v2:
 - Add unregister helpers as suggested by Bibo Mao
 - Unwind device registrations in reverse order
 - Use unregister helpers in kvm_loongarch_env_exit()
 - Split into two patches, so the fix only uses the helpers
 - Reword commit message to avoid implementation-specific details, and
   retitle from "memory leak" to "resource leak"

Compile-tested only, no LoongArch hardware: loongson64_defconfig with
CONFIG_KVM=m and CONFIG_KVM=y, W=1, each patch built individually, no new
warnings.

Chaithanya Lagisetty (2):
  LoongArch: KVM: Add unregister helpers for the KVM interrupt devices
  LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init() error
    path

 arch/loongarch/include/asm/kvm_dmsintc.h |  1 +
 arch/loongarch/include/asm/kvm_eiointc.h |  1 +
 arch/loongarch/include/asm/kvm_ipi.h     |  1 +
 arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
 arch/loongarch/kvm/intc/dmsintc.c        |  5 ++++
 arch/loongarch/kvm/intc/eiointc.c        |  5 ++++
 arch/loongarch/kvm/intc/ipi.c            |  5 ++++
 arch/loongarch/kvm/intc/pch_pic.c        |  5 ++++
 arch/loongarch/kvm/main.c                | 32 +++++++++++++++++++++---
 9 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.43.0

