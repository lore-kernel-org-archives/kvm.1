Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E4361965
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790401952; cv=none; b=o5KfwBefCUbgiTl5LBu25+5wwlpfJY5UZulesLt8Ajw9a36fe74WGglbvRc3Ki8BCsGTl2BqjH1ZjM7OGQSUb44zo+Tg6yhaALCGznqgEZ1/XdK9TVrZ062oNEZGHexeni7pj90aPqV/+PSZXh9REkRQ+HRiVPB+wwt3LH2syIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790401952; c=relaxed/simple;
	bh=eHlJ8EVnBMydYaFnjSwKejZ5CE8/NuKy99Mr7TTxIH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPrf5zpNQXeJMoUvC8hP4zWaLT/jKAr8YWndhQs5dIQPTRXnQNASKmAxWzCRK3310DF2GtIN4XOoPmT7D6sb+EgDQkGLdm2KsT4E4YrLNBISDnm1KNNaYKKePv8N0Z9EF+QGHbmp79dZAxu66v55Px5V8y5oMp+ajt3fHEZl6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+hpXtZj; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+hpXtZj"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b6200eb0so1137139a91.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790401951; x=1791006751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Q+AEMs+1c3HlByet+UhGr0L4v7ZQfIIBKxcOD9TNJ4=;
        b=g+hpXtZjtzRGPMuGe8GyGNoziAMMJlL/KMH3qekvxCA7QqCPHBqfxbXtbL2AWeD4hF
         G9iVrRYd1NxIiM0dYhBuZD6+hZL9pbwqLkohv+FqKxpEAe3V+VsWsChWCPe1IIYdW6IC
         mjq1oY2g8X2EztQzo8W/1F6MbEP59tQluM7I25/Pbiua3ASsgw/rbyTbGRNUmQxANrWv
         NSJtF+WSX5x0a9dlFgc6+0ZB9OSbKY6XtmMi6bykrtM7lkYlx9YccT4Lzw0zc2QkwQng
         u8Ah3Gw0wP900WQmac5znG6sK2tqsKqG8dL7uTIPwKNubHOZ1xDTu9f3H6RSBAPSVMy1
         nioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790401951; x=1791006751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Q+AEMs+1c3HlByet+UhGr0L4v7ZQfIIBKxcOD9TNJ4=;
        b=QcEBTKiu/m+eWwxp9at/9uJZN8Xey4H3lcRLmFfekDHxXGRbRI0lNw5YD+vN51hf4D
         fgXOFsKDUMWUEP45GapsQSo+09oPI0mU3ZIpDG6dzqO9R58/CBhCGDmQ20GzV10qQMtA
         6LpnN8jGfCDjRccL530W6ysUUT1QRqct9ZIyWOz1vBQQGJSMA+t8srbVyvGbjWow9Mq6
         6GhDu3YM516aCd6i22x8pjwbafeeW8Pi7+PLND7Jqm1xXkL0LtZTFCP64JVGl9pKMBfR
         uUOHX8d7B4+VYByzKnLyJhAagH8uMSuG3EXW9g1CLcIoauUx3O9bwgnRGmTdv0J/8ThY
         q3HA==
X-Forwarded-Encrypted: i=1; AKwUvByaaagqXHbghFFT3/fQk8UNvRGSk/IpOnhoZF8kGB3zNDv18G84gR1lpxTS1ID9f7fcAv0=@vger.kernel.org
X-Gm-Message-State: AFuF++kyn118vwQxSZ4lgmTmPq6NdsJ/3dGh56cqeomyRB8S5833zmw0
	GvsxelhdcjGTacGrPzBjp5HTVagODOPZOCV4E7w2QNCSkClrYYuZbR7+
X-Gm-Gg: AYBFou2PFQpRtTW1qDzIL1zMO2VXZUXwi1n77eUChoROkyU049wYtQt0fk6tKJC+Ssp
	OO5PAkx0n7B9s0Z8njS2UyYjSeSfH2idHiUpwiaJUEcfidptUdrcxszaC7zCOcDlqJVe0owla5q
	A52QLTdUX1SxoSQHb1Hz1OznhkWCUq+GKmmp3OR2cvJnUtYFHU5hjO1NSdc4byGj1B97Khhf+td
	i640fQzEFqFin1eNxXRyCDJWiNj8YjjcMHFDGOe7ZEHqOwHSBbkk/vavz2SfdPWjdDVASYpOFXA
	OJCPfKZtc3r8pVOuvkSUfdkynJKPCWqLdLY5geW04zZn25TxiYTAxMSyFZw9n3DAMks9yEXocq5
	Cn+F9DHZ7ke1Vu4xXTxfexlgU13EN/GYn+4e0cCGw3i+QNhNfPQWAIuX9aKjrlnb6iiaCpXzsTv
	tUmhSZPXru2r+47OxBGINXkkOzJ3g+6LwxxOm61IOXsRHZZu6pXVYAVH8asISVXv+TJ5/ifBQFr
	u5ERvFX6zRNJtWDu7gPnF2XDFAh6lnjmgA6DuujFCPMMoYQSP9AMuwjurUIx8DxuAoRrIgZfhwu
	+KuEma3D0RfSy+6jawKyIkcsI14Wvw7vZQcdYXCWXWVvwtZst/vzDnn/h7o=
X-Received: by 2002:a17:90b:570e:b0:39e:6c6a:6580 with SMTP id 98e67ed59e1d1-3a0bb662a35mr2868982a91.67.1790401950853;
        Fri, 25 Sep 2026 22:52:30 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99917besm7897504a91.14.2026.09.25.22.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 22:52:30 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] MAINTAINERS: name the kvm-riscv/linux riscv_kvm_next branch
Date: Sat, 26 Sep 2026 13:52:27 +0800
Message-ID: <20260926055227.3678332-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entry for KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv) names
github.com/kvm-riscv/linux without a branch.  The repository's HEAD
points to branch master, which mainline already contains.  linux-next
merges the riscv_kvm_next branch of this repository (Next/Trees).  Name
that branch in the entry.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..16f6b306adf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14357,7 +14357,7 @@ L:	kvm@vger.kernel.org
 L:	kvm-riscv@lists.infradead.org
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
-T:	git https://github.com/kvm-riscv/linux.git
+T:	git https://github.com/kvm-riscv/linux.git riscv_kvm_next
 F:	arch/riscv/include/asm/kvm*
 F:	arch/riscv/include/uapi/asm/kvm*
 F:	arch/riscv/kvm/

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

