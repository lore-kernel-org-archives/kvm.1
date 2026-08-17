Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36C41D133
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970372; cv=none; b=leW+hSvguTjxhoFFYJtMyUYwH+ih9eWa29wWgEh3xZRKiyDzf6lVXEDoSLs9Unc1Hvmpxh3sDH16o41I85WFGyEABpN6J6X9P4X8H1LUr1NPNSJ/OrqT5HiAAhgdWVelVs0nGnRwk5usu+SMlu2XSa1BsM5rJMoh5HnnBzFpAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970372; c=relaxed/simple;
	bh=cj6p/BHDbLVfEGwDzLrVQ3P1JMoZztkK5jYHejQUPRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIuwz3q1mFAOQlFDEDY4TtySlRVjVo16qlLpiyHMdo1T1JgzQgznmjnYFgplbsfMkNDBcF/Qt5UhqrER2dYRYXvRL9uLfC1EZd53Izbmc5g9xuTNr6amFuYm31mcyNNXM3YUElj5jbvrCRki0ORyMaN5l3g4DwWdr9LxCDjSxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onVj7U96; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onVj7U96"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902fc790cd5so19863576d6.1
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786970370; x=1787575170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xA7SAQunaLLiokSRFDeBuiD3UWcIa3/acCMrG/dMDdE=;
        b=onVj7U969iEYzQktKmY5FGozzmInGg4uvg5EkuUGdheX9hmAgFPtoDq4rkdqfDR/O9
         Hts9TR+M7j21youAfOhbxNd+unrmA3bS1Hxe9fjwtsBUGbpzNMLAjf/w06vzrJ8lepgE
         hTjS9jwDws6TlPiSFaJG5Ns+wg8t6ZEJy/PpZ/nC2VLXoZ4+zGy3rUAC8PobkNp0dT9a
         rNVOLqZWut8FkiVrjv+iqsRH0H3iRkEu4DAFDIVs2QRvY2UtN6/UAQOI1gCUYNbhScGX
         UUGdhqZ/s54AnfxrZ4SAOd3jXFLNwpybqw+QS9j9Pd7jWBPn9O9ug2QAC7zoXJPFZvhL
         5jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970370; x=1787575170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xA7SAQunaLLiokSRFDeBuiD3UWcIa3/acCMrG/dMDdE=;
        b=F6BPZItr4EwZj+LeSAWzKURzZNwgB7jGgilvOCetdyPDX6AgOgCI/vUHheaOPb1pMd
         3E+ATaARGeyTJ6FOiDUMLfOR0LfN/WRrvxQGLtuL4zc6pcceLoaLV0pTJ4JA1WyYxLH+
         1zU+CF7Wo7dbIHqM2H/GY5/4lQofhnLMJblE3mzLkCnNwwkaOy4RoJXyzKZY67+0GGli
         b1Mwd95cqSOV1531ebzn1diVj6XZLHgFDn94xkssIFnvKnziD3Yk6Bvh3OhB7vmC3nkA
         oBfFDuvBICuP2nbuqypo0xJc1xwr3gyxsipphmI7pIIuDUFP0Wh9lnC34c0t0RpCK1KK
         eDzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAKYs74hEyj6m60mlQT4viH9fXm13fcsda15KDwb+isVoBHkQc07tDJpfT9OeMOoY3EL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8bF7bCKe12SOyVtgsjMpk9ngHkivW/Iwqt5IdyMsYAVEjz02e
	Ke90U1E4KkFhPLg3WK60DwyUt/STYENg0Nf3tQgZXThzrRVmnolAnmwJ
X-Gm-Gg: AR+sD11sJSNpm6QM1KmJiAmFUX0yqv8aX4FmLss/Mxh3GB5sptDl/gWwX2rKtinI3ur
	8suM7N56+bLBsp18Vz9fIAeCm58W7TUPu496GeARWRQDNRuCwCAFBbZHs/CNhgR7zggQYE/Ysg6
	/AGkjC2e11cYu5iRYEWRzocJZo/bvzgnoBGb340JMH/KHc3W5uYx8GIiaJ0eA3LPQBlr3DbLEk+
	+adpxcEVZTXR3lgNwQkOlfxuOl0rp0UKBnLfgM0OutOZcGsOrL2G4RxHzh5WY0qdNyoGtFwGbMg
	7Ju9dcZMQAm11g94HsAwibSQncbUHUNYXV80L5knLcFJr3kRtj205cBEWNXjKUCfwSRHpgzy2zv
	5S7VxMZXY+2A+yuMyQq7n3rd9Gg8pi6kzhaymkoHVl9T/PhZwHrC47iEBcqGYyKQtoyAxv0E7k2
	cols8z1leY/2a3QWeFquTqSRgjVCxO80HW8c3I+pNdxcQUmdR7qwU/2snOicBJ+P4tK7NRvVdRL
	g==
X-Received: by 2002:a05:6214:4808:b0:908:a729:73a4 with SMTP id 6a1803df08f44-90c4b2d8589mr2651306d6.5.1786970369756;
        Mon, 17 Aug 2026 05:39:29 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45936c3csm8079496d6.32.2026.08.17.05.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:39:29 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nagachaithanya9911@gmail.com
Subject: [PATCH] LoongArch: KVM: Free init resources if kvm_init() fails
Date: Mon, 17 Aug 2026 12:39:18 +0000
Message-ID: <20260817123918.2738447-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_loongarch_init() calls kvm_loongarch_env_init() to allocate the
per-CPU kvm_context (vmcs) and kvm_loongarch_ops and to register the
perf callbacks, and then calls kvm_init(). If kvm_init() fails its
result is returned directly, but since module_init() does not run
module_exit() on failure, kvm_loongarch_env_exit() is never called and
those resources are leaked.

Call kvm_loongarch_env_exit() when kvm_init() fails, matching the
teardown-on-failure pattern used by riscv_kvm_init().

Fixes: 2bd6ac687261 ("LoongArch: KVM: Implement kvm module related interface")
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 arch/loongarch/kvm/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 3e1005526f4b..b6ddf5827c03 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -428,7 +428,11 @@ static int kvm_loongarch_init(void)
 	if (r)
 		return r;
 
-	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	r = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (r)
+		kvm_loongarch_env_exit();
+
+	return r;
 }
 
 static void kvm_loongarch_exit(void)
-- 
2.43.0

