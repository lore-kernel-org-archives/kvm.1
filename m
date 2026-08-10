Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A797397E75
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344746; cv=none; b=ckeWYtGsS0KATra4YFOdA7pu7H/v1G0sLfis6BFA9lBxoYZCLup4jQax9iVwDDvEgqOxfw4c87cmpsj0xw9RGXFKPQY0RjSNOiK1abIih6a9CIt7oUOtUpU3AWbdpQEjYroi0VTLqGnNxiKtYxSojar7fz4tQPozNLimamRYoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344746; c=relaxed/simple;
	bh=sNuukcM3D83y3AGrAcmDVUJWOr4AK1wbJYGoX6MXcZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qHgXiUev2O/gcV1/hfCpjIFh7VfYZa5f2Uj5x8L2iyAYbogEC63xCwEYw3Co7Byv4pOV5it0zOW/hyZbd1aHzlUYLmErHW9G0AE1VwMvp/Rw1S6JFo0sYDeesr0G8QryjYOABZiRmv77zwZcKRHQLv4cM+UAYzIU6iiVnSfM6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V50/Kz63; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V50/Kz63"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so10199815e9.0
        for <kvm@vger.kernel.org>; Sun, 09 Aug 2026 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786344744; x=1786949544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8eGCU7QsDbQICJdJbOzdpd9Veffbk4TEd4ih/oR0Bp4=;
        b=V50/Kz63TK0ROdwOYNGasFz539ZDlTcqYJrmTMVfgytWNLLsGgPE8DYzZx4IzxPGMf
         cvj4Wgm3HK2zKsKzXgtjSBbmFx7QjVgN7SauUfxYnTtFowjn+1QhrUB71GwVl1I91TEs
         JK9qcgOSM2aUwIRqXvEhqi+nSEwg9DGV4L62reYxCO+kjANt8m+YTcWvuAXj3rTMg4Q4
         rtje9h+nDIRimjS8w+lp4Z+oL3vxOSVOjYxRz25QaTWAuLkb2hhxd6+IxsrXQPDvOi5r
         1PnOwKl5wZJ1eVqP0cey18YOlmZJcHZYMPuLyVB8wKt1GaQBkpsfOp48JaFsM71lLq9t
         gu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786344744; x=1786949544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eGCU7QsDbQICJdJbOzdpd9Veffbk4TEd4ih/oR0Bp4=;
        b=o4yGhBRvmyOJLYtwYCk7cqZEaX24QYQcAXbXFyTc3j5YREzzU0e1VSoejZ/Odq09bh
         P5bq9/pRZZoX+MbD9aQY69a7amaEhQCXxgzPrBKVKL/4Rrvr6O20J1tNI8J1rQJN81F9
         VdR/LvVbc65kKKEm1l7jwvMiCOVkpT/Hp45GW5e6kVr6rrfLw9yjR4/b3fZQHvOz5/Ft
         vmRryfVHb+1zfqoQWJz4P8bOcDMap9sQTWLSpZP7AryewcypLg+v60H2trFPnEJrdnZm
         hx0V6GgpH9MqNXezOZZCh+kCGo3SRH9Q2V83oMPOZpORBme1c2zqTdyPdsEeCIcFgXa7
         v2lA==
X-Forwarded-Encrypted: i=1; AHgh+RomQwC7wC7aAe5dg9Ou00S+ml/pF0xi1+i0noojd6giPGTuShm00iG9fNRXozIEYB+e2og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcuLV7mAd7vPEUlL1QmcALB+Pu4HjJ79eR57oJzQw6lm+UEHg
	pVZbDR5yPKMkaaYOw+HSMPg82CgJhENQEIChBtdqblEEw6ZCSMp1psecSUQ+r6Qr
X-Gm-Gg: AR+sD12oyn5ve5bzEW7LPovlcRqxHsp04RwtRL0509RFqydiS3yqyKT5PpaD3Vpl0Yo
	Z74hjqs5HKZmkGVMLT7hSUaXgC1dzbqq3nrs82NG7y+fp/g51pQWAJsTFB0GjB8cru8AyrIoOi+
	nXtvvXDNOcL0OFf0wgG3r0U4kvlke1i6EQ6KxdGaoi/G+fSaCJxOFHVEqFTD/SKaMh8U9HCod5w
	l+MPbfIUTTKKrbfhBH5ohMh/bBRqhlvlDphOn5ZfX4T/a590rTs6p1TImHVffVVF44shSBBHioC
	ahRjzkio2hisKpu5euiWD8Ar6Fu37nGi80U29dd5d7rnLxSnCqH97GTmMx3p2yOVND9xdN73kXV
	jGDf57gctS3kvUqiWy30TJJU5+Q2er6wQ1CfkDcsRfHcJU+ZimiG6gIMGlYpbtsj1JsLwIo1ZXq
	J7647vDfPeahKeq21Js9F0Q2miyXAw/iAihr/QFeFxM12d7drsgrKuDG4AwK1mmoAxMJQvyR0UK
	H+t7L6EhfAoENwbLvjI4tAw0+baWMOvBkzNl/Q9QIb1lkxXpIlO78fW2n53KGwf3uJi6j8oC1+B
	RnT9IF1zMGvyPNvb5F3o9C42qiq9LVnThBtxXmMl/Qk+YWlf9Ow4eLuiaxb/xx4HEI3QgjeFoDP
	GAQ==
X-Received: by 2002:a05:600c:4595:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4994e79e377mr389497355e9.8.1786344743398;
        Sun, 09 Aug 2026 23:52:23 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-a1e8-7401-78b1-a175-5d13-e92e.310.pool.telefonica.de. [2a02:3100:a1e8:7401:78b1:a175:5d13:e92e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420c68fsm358800705e9.1.2026.08.09.23.52.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 23:52:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/2] KVM: arm64: fix VGICv3 redistributor rollback
Date: Mon, 10 Aug 2026 08:52:15 +0200
Message-Id: <cover.1786344511.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed REDIST_REGION update can unregister redistributor iodevs
belonging to earlier regions without clearing their cached base
addresses. A corrected retry then succeeds without restoring the missing
iodevs.

Limit rollback to vCPUs assigned to the newly added region. Extend
vgic_init to access an earlier redistributor after a failed update and
retry.

Commits 8542a8f95a67, 59112e9c390b, and 0d92e4a7ffd5 progressively fixed
cleanup after a failed region update. Preserving earlier regions follows
that model.

Built with GCC 15.2.0 and tested under QEMU 10.2.1 TCG with
-machine virt,virtualization=on,gic-version=3 and -cpu max. Both runs
reached the VGICv3 tests. The patched kernel passed; the same selftest
against the unpatched base failed with:

  Unexpected MMIO exit at 0x8050008

Karl Mehltretter (2):
  KVM: arm64: vgic-v3: Roll back failed redistributor region setup
  KVM: arm64: selftests: Test VGICv3 redistributor region retry

 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  42 ++++---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 115 +++++++++++++-----
 2 files changed, 112 insertions(+), 45 deletions(-)


base-commit: b9b3e33b70b71e516930117e21de3ad2a7723747
-- 
2.53.0
