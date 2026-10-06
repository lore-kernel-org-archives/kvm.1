Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BEC3CB2E0
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329953; cv=none; b=YMjLpadp+68yLwPl7yXk6fK7prC2rkCoVG3W8jzxGx0RtQT1YYcvGXijvddZOmgwQXseWW0M2KsaYALvcO6NkoHWnZNQws2tQ4kw0STJJPZYrdhQds3VfBZndCnz5a+vnPC/JkexKX0PSN9s4+5UM+LlRMv/QWGyg+MwoVxYLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329953; c=relaxed/simple;
	bh=BWQi6+OUEp/tu9l1mkI7xW4X2+ly+BWbFk1Zcp5roxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NMl6jtU+atybPoXlCrIC/uMfFXmzyjg4UkFFDVmHLWMga59LiGmyhA4DcHYw5RuxDUDeUD7U86L0KZpxnhzxpnepAqVgPvN20TafLqN88/H/MkMa7gR/9N89wj39HJrCGpPfacM0wqLzdr9Qm8o9v9hiO3CtB7nhhPOzARxCuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiofVYFT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiofVYFT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1995658f8f.1
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 16:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791329951; x=1791934751; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p6vQUbClVDpSCeEbk4enL4LsUUIDighbOrvskTUgMlI=;
        b=PiofVYFTKU/KAwZeWrVD8/JjW97PY4XEAEDQqplcTZMzg+UCIe1Bvjty8JCErVZ4Hf
         lKauDFOt/0tjSicNXJeQJ43YZjpP0QDzw6tWnP2Qtm5o7PTRgZ4+NxzcvDMpJJycyS7G
         cnUkvHz97paXvS+niBBtJPIFOy6Wp9q9elKcDTSi5eF2ZlJbtuatcPPmZp2gtr0rs+rO
         +r6yA27HI2xH4pf2P2FFsosgMCziKvX5w7bQms8pbFzi8piIvpZie28ad23v2wA7cJw2
         rT9GrXkVmW69e0IMRjgbjcYVXiLmTL9lY9rK2tXeqqXiYjYmV3WWTXEp5MscgGnGpf65
         c9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329951; x=1791934751;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p6vQUbClVDpSCeEbk4enL4LsUUIDighbOrvskTUgMlI=;
        b=DgJoSfC2D9eYtusJbed1NG33utQTGvyZ7KNSpXuD/2zfute9Q7OZA2idpx55oRGByH
         CAyOS9e7sxGUCBZ4xTk8SAQsdoSzNrSqVJzyHmFsZTzAstUoMiIM1c0E8Y65JJKAlNlc
         lD3ABgcEyJRpXucOIfzt2P5KGz89UX4YiB5jIY95gUIAHNYWD/wj1ydng1JRpjWT5QSv
         XWzU65G78kjyJiuN6Q7sEL6uBnrKUv7T6Wqu9BeXGnsY+bJatOIOC9dHZLNGR5j64S8x
         S9N5MNUT5YQNv1Rfekf7/9OBTN6KfYGcGDlgNTVPPX7A0jfOG1hbdzKrlLkFItvKm2rl
         SoBg==
X-Gm-Message-State: AFq9FYLgpOeX4qkvll2fxbZBfecF0WxXvRwjv0jBbrIdXk5g3KYGaSD8
	Hh6HQn+M6e4G+rWXrhYbRKqUCWuB1ZOLej9kPjjCcBhanBCZNDzJ/i7q
X-Gm-Gg: AYBFou3XYAnKCoro7ydx1v1Hzd2VWhNi2ZCmDTMNuXo4dlhN5UwgQyiChE+M/qoCVQe
	MPmfV5c9YihAW5gbnsodr8hhRwMA2WpzhYGeQz5fl1Z8FB3LxrhlfZUni/1Hj7Cfi4O+OvlYX1a
	gOnvUrnUZRWgL18Rixpo/ihdOmIwUsfAfWvmtmnpi+y4lco4VEPDAxHyg4U4YWQtC9PFqG+LDGz
	+2yOvFUB6rduCUeCQsBQgk9d/iSIk23D9EakdxCWL8j8z2RSX0S9488xXmyxIt3WI5kjjIpszX3
	UOUFfDP6CQRJ+uuprkXXgYhyWBx9rvuLk1FO8zsoAukNXZIhd5Gx3PLpRgFnOP0w5lD0biboLVp
	2faLCYwzFvEshJPAI2mVP8nvO+q8ahs81NWp7z5dzAe9VuH2xRhq15H+1UAKM/jbyi6flFNgiCB
	4FH+uIZUvTyjynObOMuN6zA+7C8yeoo+aSsYyMD/LJ5GcixtfRmS1D94Tw6q1IapLGEbqPN5Q45
	vDUMZdhT4e/Xn30RcbUi69vrj1YVwKaVbA43aARUcVIMKcPxCDSR6Uk
X-Received: by 2002:a05:6000:2585:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-48c72889ca6mr1289357f8f.22.1791329950735;
        Tue, 06 Oct 2026 16:39:10 -0700 (PDT)
Received: from [192.168.221.223] ([81.0.216.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d10216sm1881368f8f.20.2026.10.06.16.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 16:39:10 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 06 Oct 2026 16:39:03 -0700
Subject: [PATCH] riscv: KVM: Fix compilation when CONFIG_RISCV_ISA_V=n
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-vector_off_fix-v1-1-9e48e654d445@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QpAMBRAf0X32WqjFn5FEtsd14NpYyn5dxeP5
 9Q5F0QMhBGa7IKAiSL5lUHlGZh5WCcUZJmhkIVWUmqR0Ow+9N653tEp6rKyWo3K1VIDR1tA1t+
 w7X6Ox7hw9F7gvh+hxdj4cgAAAA==
X-Change-ID: 20261006-vector_off_fix-938d61b1f906
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andy Chiu <tchiu@tenstorrent.com>, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791329949; l=1885;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=BWQi6+OUEp/tu9l1mkI7xW4X2+ly+BWbFk1Zcp5roxc=;
 b=fIJD49rfeAewk1vKo3AGACkBEa31o13TCmZF61L5MsBbstc43N/TbELEyoRMR0rhStTq2fWGD
 hT5PT2sRkL+B6oSNnlTW2Mo4/PGgShIdVRbZ3Yn5vuC3tmu1dzV+Rzw
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Fix the KVM code to use stubbed out versions of vector functions when
vector is not enabled instead of failing to compile. An alternative
approach would be to ifdef out the vector code but since a handful of
the vector code already just uses stubbed functions to tell the compiler
to drop the implementation, follow the same pattern.

Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector")
Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
I was reviewing [1] and noticed that when I disabled FPU and tried to
compile that vector got disabled and the kernel failed to compile.

[1] https://lore.kernel.org/all/20261006075303.205216-1-radim.krcmar@oss.qualcomm.com/
---
 arch/riscv/include/asm/kvm_vcpu_vector.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index 6371d5ea5392..1c9efc6048bb 100644
--- a/arch/riscv/include/asm/kvm_vcpu_vector.h
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -11,9 +11,9 @@
 #define __KVM_VCPU_RISCV_VECTOR_H
 
 #include <linux/types.h>
+#include <asm/vector.h>
 
 #ifdef CONFIG_RISCV_ISA_V
-#include <asm/vector.h>
 #include <asm/kvm_host.h>
 
 static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_context *context)
@@ -55,6 +55,14 @@ static inline void kvm_riscv_v_exit(void)
 
 struct kvm_cpu_context;
 
+static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_context *context)
+{
+}
+
+static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *context)
+{
+}
+
 static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
 {
 }

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261006-vector_off_fix-938d61b1f906

Best regards,
--  
- Charlie

