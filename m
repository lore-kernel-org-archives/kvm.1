Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C51344046
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406251; cv=none; b=eODdCZO6sI7/8pOmtEhae36J/OHC+cgKGyrHvs6lNSmyXxNQ9kh3xUO8GZoCvE2lC1PHwI4ZHNNNw2HFOjb42hF/kHS8vkhRXjaI3vElXu75JvxtpB8/2WlO7nXM0gNloDRZLYI+aCyQn0Ia/aU7X9yyHRkT0t10matxLmid2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406251; c=relaxed/simple;
	bh=DR8VjmQLqySSuZ3VqShd5B2GMsBQoN9xfwFiazETnRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS9zkn5v0VT81snhqtN0O9PdhQKGW67QZguhGNwuMUxznsHSQ4/9QCuirmA6L6qlFcCnrTYPZPbeLSvxOoBM+nzhVu/eMkRxYXnEIQ4KWEqhIPuMKLwAbxYPG4PBtHX8lpevXSs3gr7rLVNpaO1s6chKZmw+BAULuquHn78s/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdiP54QQ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdiP54QQ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so1847317eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406249; x=1791011049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNlqCeZxxjHAxzDk9z7qImwINCBhWsreM3aP9qjpGBI=;
        b=hdiP54QQU0jiCtlu1W9aQSgc1mVeaqDFQVwzD1KWMVvSLJ2WagcTy6OgIsVMLhx3Jb
         Fr+RSGth9to3IPA9LL4xUFPq+JbSAUsVL90SksKuZA92snbNlt7Do7+KHDN3UQe1HZHi
         OXrOHO/HWGPn4BPwV/4KY+juLWXRo4xr0VhaOup26j8ozF/vBv6hKqOFapzIxMNuJG+g
         NurIcDuxqUyYPnzIAFBfO1dXMdbBHuyP+M7RMLGWZVVbPVLgcS6PcM2eYzuj93uS/Vtg
         GiN9TmT/auxKqVFYObJb+le/9mw1VDp9B5HL5/mDpdvnH6TwWyw48g9aRH2FiFuswNYz
         RzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406249; x=1791011049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNlqCeZxxjHAxzDk9z7qImwINCBhWsreM3aP9qjpGBI=;
        b=TNt4RYF2f8GKtsjoVEPrAz/zApw3+AK/hal7WZNcjKPnXkMwtLrxFtaPThN/U0FxG9
         3E7FY7LxGhgh/UWW3vRPw00UvLCbTlDy9C41w4hovQTTxrw3e/R3S3mbaQpssqxvx8Ao
         NXgqXtlgY49bIwMx7+qgGPUWZLXyAnoX2+tbNRhhZbSmIaM0X3AFNNszHxjNgjC7qeVx
         i3Gv2NdL623h+CsGujCtwBNUbN7oUJQ3uaU/OxHWjD687jJe070E5HrZ6N6u5CBMgYC9
         3P4JHNNWdsXGsNnu3joSZ+uVqb0FvXVStn7Fx13ex05+dzEshWspw5lemTX4y7xU2Ibl
         pwLw==
X-Forwarded-Encrypted: i=1; AKwUvBy1/734qLxAsfPWhN5HPtF5xCbpFnYkqa1wuJscVoP+nOorJYZvMbPHk+oZqIBiYRO5gTU=@vger.kernel.org
X-Gm-Message-State: AFuF++nFkSd8DbPzuIwvOIRuf/p17gZE1rBSTNF+ApDk4oJSzTPHpPNF
	snFXt/WfC9IQDVLXcW+9yrpuOuCoM9cskbSTbheh6jGkARvf+VdRI2kGSIM1V23K
X-Gm-Gg: AYBFou1LowqGvHc7hGM+2eUnF5TRYVclmD1DPrePKrc7Jk/8zcza5+slQDYsGcNI3cu
	jPai3q05j1l1OwGDyGLQGaLizjCbAdYLJBB+ZsDRfWH2+jmQA8et3vKws5J0mffVn3D6xABxoaG
	3ofXUQKowQV1YUAQRVL9I7GRhKjwxjDFMGcbMaEGWR14LugKS6PuO0ol8wRbdb4B4cJg7N7qQtr
	y2RsDMDAzNHwajE1Z56OKViFr9CRN4A3a2QH6g5qFeXAFzPChlhJQ/ChuprMQQxcheYuanx2zIp
	Bbp7BD6uDGgjaanCSw2Gs8aKmNBTdPjR7ZmPkv46m8WSyi29T9Mz7Tp9wUKrat4ghfRsN94Hdvw
	wrSo9EXdYvIfuSUvPGGwj4m5klqtKNtCFAdPRrwssp9esKYxdxI8Tb//g2PWo/FoCKpWNteNH59
	5v0UghHGRHNI0hJTpn/f4h097vxXpm3O30NkiItvcchPNSyJVPfnD0ACCoIFXxHU2mNSyIsTnPV
	APbRB2yN77fcr1AkggeMe7XLvyTrvI=
X-Received: by 2002:a05:7300:a987:b0:333:fe81:85dd with SMTP id 5a478bee46e88-3426fbbe744mr3025019eec.3.1790406249289;
        Sat, 26 Sep 2026 00:04:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 47/55] target-info: add target_is_microblaze
Date: Sat, 26 Sep 2026 15:00:46 +0800
Message-ID: <20260926070057.1234-48-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add target_is_microblaze() and target_microblaze(). The first
reports SYS_EMU_TARGET_MICROBLAZE. The second checks the current
TargetInfo.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 15 +++++++++++++++
 target-info.c              | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 812e4b04a7b..17fafa0888e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -210,6 +210,21 @@ bool target_is_s390x(const TargetInfo *ti);
  */
 bool target_s390x(void);
 
+/**
+ * target_is_microblaze:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is Microblaze.
+ */
+bool target_is_microblaze(const TargetInfo *ti);
+
+/**
+ * target_microblaze:
+ *
+ * Returns whether the target architecture is Microblaze.
+ */
+bool target_microblaze(void);
+
 /**
  * target_is_base_riscv:
  * @ti: TargetInfo to inspect
diff --git a/target-info.c b/target-info.c
index b25e2ada438..0716e2021b8 100644
--- a/target-info.c
+++ b/target-info.c
@@ -204,6 +204,16 @@ bool target_s390x(void)
     return target_is_s390x(target_info());
 }
 
+bool target_is_microblaze(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_MICROBLAZE;
+}
+
+bool target_microblaze(void)
+{
+    return target_is_microblaze(target_info());
+}
+
 bool target_is_base_riscv(const TargetInfo *ti)
 {
     switch (ti->target_arch) {
-- 
2.52.0.windows.1

