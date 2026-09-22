Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A94F391B
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073590; cv=none; b=FpmOHjLjm8iuAmZpdr8NGAyt2LjxqwUw9lJYLLu/XlYkYLhzWiyYMf9xnRGN0twncunKTf6bXT1Sr891r0kf38QBFsTlSLaLJwLIazv5L6h89JKeZ47BBHVe79aA3s1yJLjsj/ddVgu4BZmLvn4G7e4prp0SXzSlKBqbnr14MTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073590; c=relaxed/simple;
	bh=rQa40uWPapC60ioHBAw/KM6gw3RzpNXJjEMK0MR9cNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6oQdaqZioFk6nPZD70lxb81G8DucF48YAZB3xDLBHUhV92q/PtcE9R5KiaOWKnG0Yd54FgsiA2lVDAGkbgW0qCASpErZHMI1pkZceYjkB8y6JokzgkwsApdH4Wyoun6I08Bdv85jLBm4JjlcRiHpy+L3kNExTlClnnGBShgvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQd/boaC; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQd/boaC"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e211a3so3499394b3a.2
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790073588; x=1790678388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=II0vtlBLX3teC8UAtU2N6RuSR3r58GGPZ14MkNA6Dmw=;
        b=bQd/boaCN08Dbd6rn77jhbI9IA7j8bjywTPHvNx5VfaWLn/tFTvOzM9x/yxmq2untT
         Dw7Li2noEsyaPjUJ9RiWBybg5znKAiGPxcpf32YSNbc96yJyeoh2wCY8dCwocSNOc/Jb
         tgI5MZrl00JG+lYCDUcuCdUkwmi2hA+5co2wO1SWM1IqBi8jIitInL8AzPk63uEUR8Fa
         +T9hP22itcKOc3liUn+Ycbr/uo1ll4moqTRfZqUQAMKWDfIdXY6oPzrJ6AaSFy67ewSL
         DonyVUr/T6amxo0jwPqAxixGEHPJ7HthKxzcx2UYDOs9513n87wMu4/O1noKNoBZfVPa
         vzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790073588; x=1790678388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=II0vtlBLX3teC8UAtU2N6RuSR3r58GGPZ14MkNA6Dmw=;
        b=iskb4LL11lzjZhZViabF268JM2Ys9PW4pNZPslD+YYb7YXTJGfwev+smzEHMG6Ndre
         gyyHw6dJoD6zadc9O6I192G2COzSAgOsqU6AE4ctzW96Z0CEGUI7t1d7VLl50nxeXZch
         U1dKyuUczmLHHkOEA/B5tRLE1PNpTaCKOoqGVIPShLAXtPE6f+o7wb0Gsc4K9xvvCJWQ
         vr3VhJVck+EyGTvlewldotWKHwME2oyddQGRO02ChV4bs0WuEYA14j1ZgX7thPHsAv3v
         IfGkwAVSlacX/WIWKVasDG/c3kTMvCPAyZkx8IXCQ+BSnmmr5XO/HK0PhCmiUDdjPF3+
         XDhw==
X-Forwarded-Encrypted: i=1; AKwUvBxZ6bDFvTvcvdO1IqtToi9xQrbGot11RYKlDKQ8GUoHOOcsnrk3jW+EkKjstdzyOsFJ6Us=@vger.kernel.org
X-Gm-Message-State: AFuF++lot7LfhEvKE4rGohbhkFq5y0A9OBXCJewcBJcjpvPYfSLQexI4
	VZSM28bLdwIurMaNH0cyfxI445uNze8e3XLL4SsRsu9S1hCo/LyucEFo
X-Gm-Gg: AYBFou2o2IF3mcnQwTshdRztQ8YCpfMM+OZRWqpN3oB26gVkuRCwKvrm7uBMedsVE7L
	jyGdZfeTLvAmwYbzZOjWonB3vwF07RGXdBPMei0ZPMFgIPz40l5fCcOInetaUr3QPOzIdicjaUt
	iejuAa96ZWG3sBiGQOSAJ6DEfhxQpzEyKNgpwDEecRyxdB2oNEDf8F/NBSeRrqu86SMsyN8dnXP
	ByJdWcGOCwJBRrfxVDdS2CFHjpItJ/IxW4ZJAUe+Q25pF0WAhk0sPtpnzl+Z2gwqeB6Jj1AS9fw
	0P2i4MSMY8sG8m0X+EBkgWRDZnYfmoDGBDB1pGrdSRASQXlYaCHZPda06++CrEwxWl8VVkYg/Vc
	EyFEFb9RaBeltZfIy/aQRu9sCgghUwzBY3Bub0jtFqnLud56XUY7dp3kWyzOQeBvSYwaYkfyqDp
	kx756swhIqC2Ghpem+3bPgOlGuY9pe4tuePc/qeF2x3oWvo1zbcVPP4bgMrFzs1hQWHcMQX7vGK
	8oeZgGPN6Y=
X-Received: by 2002:a05:6a20:e390:b0:3dd:a006:ed9b with SMTP id adf61e73a8af0-3ddec82345bmr811522637.49.1790073587913;
        Tue, 22 Sep 2026 03:39:47 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e61271695sm4397515eec.8.2026.09.22.03.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 03:39:47 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Xianglai Li <lixianglai@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Subject: [PATCH] LoongArch: KVM: Return the actual error code in kvm_ipi_create()
Date: Tue, 22 Sep 2026 10:39:31 +0000
Message-ID: <20260922103931.215091-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_ipi_create() registers the IPI device on the IOCSR bus and jumps to
the error label when that fails. The error path then discards the error
code that kvm_io_bus_register_dev() reported and returns -EFAULT
instead:

	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS, IOCSR_IPI_BASE,
				      IOCSR_IPI_SIZE, device);
	mutex_unlock(&kvm->slots_lock);
	if (ret < 0) {
		kvm_pr_unimpl("%s: Initialize IOCSR dev failed, ret = %d\n",
			      __func__, ret);
		goto err;
	}
	...
err:
	kfree(s);
	return -EFAULT;

kvm_io_bus_register_dev() fails with -ENOMEM or -ENOSPC, so userspace
creating a KVM_DEV_TYPE_LOONGARCH_IPI device is told that it passed a
bad address when the real problem is that the host is out of memory or
out of IOCSR bus slots. -EFAULT is reserved for faulting user addresses,
and the remaining -EFAULT returns in this file are get_user() failures,
where it is correct.

Return ret instead. It is guaranteed to hold a valid negative errno
because the ret < 0 branch above is the only path that reaches the error
label. This also matches kvm_eiointc_create(), which already propagates
the kvm_io_bus_register_dev() error code unchanged.

Only compile-tested; the fix is a straight propagation of an error code
that the adjacent kvm_pr_unimpl() already logs.

Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
Assisted-by: Cursor:claude-opus-5
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 arch/loongarch/kvm/intc/ipi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 7b333a4a0430..672ec053a997 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -431,7 +431,7 @@ static int kvm_ipi_create(struct kvm_device *dev, u32 type)
 
 err:
 	kfree(s);
-	return -EFAULT;
+	return ret;
 }
 
 static void kvm_ipi_destroy(struct kvm_device *dev)
-- 
2.43.0

