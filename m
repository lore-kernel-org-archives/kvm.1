Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F202576E
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043525; cv=none; b=cSUyU3IsMUpREKEfuawKD3MYjF14xieox6lx7n9FMowqDhRNF9vDstlC9q4XmVt97kTK0G3L+LaP/7NA2BayaWDu6Gk2Sxa77S/g3C0krAwsSxt9NbTbENonr9E30l1nIxuAuaUF1sbanksINTlGR+4DbGEoRM1/SXKxLeVAYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043525; c=relaxed/simple;
	bh=cLOAfuodSXvKhZPtEvK2P01F4GvXWZUsUCQ4tbLvm5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAZCdmWJTX8OERzIiMcLydbMzWA3FpwZxcmMOE4lBcigoTARu1tHkr6BqFOiH8pzzSHmy1jDhcHgoVSPq+xtv6RgUfU8FPqZyXvhj92/RbwFaYt6rsVvtZQKuXNzlCbOsLcSDHuvgmN+ip2e1PdLezHPPNfTn7WZaJf9FQeYvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FtYYgo64; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FtYYgo64"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso2506836a91.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 19:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790043523; x=1790648323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5WQok9u00TIs2XVurEer//vmyvUbX92gGWOe15d0Bq0=;
        b=FtYYgo645P619XnUC0cf7k3Bom+tbVit8UWbuykQn6m6yEAhhngoz5E95W8wXnk3Tv
         fwmhBgLaEf2XooGjODiE6mH8QHcs8F36s9Ai2Ekpalzt5cyFOiD2UJ5+9HtAZX1He7Ha
         DMOjDRUtCK3gHXzqrphPzEWdojwt/bnm6i2W4Go3O/LjmDKn+77TJbFHk+HJ4t027k1u
         qQeDiHgNt4QHNHpFmxUm+r13qpcyBH0w8rhp4lFrySMzhAzjRaLNg8J7uG/ulqQe7rKC
         kX4d/iQiVpDuMf2VO+EIxepEdxMnqjsbAP1yIldkSrHGfAUVky/+IiZa0cI4kl7vOdyl
         yGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043523; x=1790648323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5WQok9u00TIs2XVurEer//vmyvUbX92gGWOe15d0Bq0=;
        b=ZKqqn7hDHbUFx0MlImne7yYLrP6OqA+5US3XYxrVOickC/hp2rRg4pjJryvfKH1W4C
         wx2tMzzxadqq469z8+urpULmKz5RGxYIpYrjJhBsfxMmEUYdUCYn8Y8bVid4bMamxGjP
         xw4LKNXkaAElEw6rjrvwJwiof5f052+MqVAT5Q8PYyajYPluQ+W263O1wCsvBovIY2D/
         Kx/gt3C0jSVoONH8u7Oo3vCejvPZxQsswDKHeQ1wPDxzH/intrG20MEEJj3P1BplDPnu
         DdvF2rmRMq01smPUrUw8a9wqyUYZz9rA0cmhMyclMO8Bp9HTJkVhnipJgmwW/QoyBmGW
         kBzg==
X-Forwarded-Encrypted: i=1; AKwUvBwqbjoCgbuZdlDQEskOSNIkIc+VHVfauQVrAfSfCya+XQ+GgUWK7p4f1jExXcglydjJARo=@vger.kernel.org
X-Gm-Message-State: AFuF++krfYHgHsvpMmdcoV3WSjAVtDPzckiEpSVNooUKsjC1ltyAY/FW
	I6ejdDtW099d81PS0Du+UeJN6jLVTowkrdygK4tkmhKt4N3uW2B+9jfVJcvzQef9VZy0PBbH/FK
	xF1NF
X-Gm-Gg: AYBFou2+KHcpcl8Sc9SQ5aoehWIPJTtaESroTY0FjcaYuOsSBZiWS++o7RDwJK6qX5/
	y2nX0Fgg4CmM7bgTBkBE4OG77GIgvtwYhVLZ5qqNMNo91nvcIl+Nm3XT9pXpejpV3M4Lr5fwoom
	lrw+KLHmJ+waZ03rkS+sn5Aw5qSCJKz5PmhqTljrRhaXwgszSVtNa7vVBvGvsY6omTa9Tmqy9NX
	G7uOnygEKUmzc9s9vvxF3V3ebtms1YKOvZm2ViIPy4M0JcFs9KJSsaArB95aP+9Hizeb3qHjcPc
	f82PmbuKDM3C8TILFPhSL7QUbzkn7wdLAaG06RFRtP5DbKMNHyT27LAm3AFYyS33Q9wSU5Ypopi
	EeFmeRU39Z9gJ2rKfQMbdB9MGCDR/Waav8MD19hzKy7/BnYkKJGHuNJHiVfQ7BrZ8QDcy1yEYg6
	aWUt/VSVGK9qWmAV+ioNqeoZDP1S6YEp43vbpMFynqtjPj1qXJCHIC20F5yaxCjga77aKeqrf9G
	VmCDvJMOC2rvSmGVP6DjwrhwQlDr7BNau4Y2fdBqPsQoWptEclg8Kg2GqpLVQ==
X-Received: by 2002:a17:90b:590e:b0:39e:5166:df84 with SMTP id 98e67ed59e1d1-39e54d1121bmr18157424a91.16.1790043522580;
        Mon, 21 Sep 2026 19:18:42 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06747204csm1823793a91.11.2026.09.21.19.18.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 19:18:40 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Andy Chiu <tchiu@tenstorrent.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH] RISC-V: KVM: Fix build with vector support disabled
Date: Tue, 22 Sep 2026 10:18:24 +0800
Message-ID: <20260922021823.44251-2-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-mode vector context handling added unconditional calls to
get_cpu_vector_context(), put_cpu_vector_context() and
__kvm_riscv_vector_restore() in vcpu.c. With CONFIG_RISCV_ISA_V=n, these
calls fail to build due to missing declarations.

The get/put helpers already have no-op definitions in asm/vector.h, but
kvm_vcpu_vector.h only includes that header when CONFIG_RISCV_ISA_V is
enabled. Include it unconditionally and provide a no-op implementation
of __kvm_riscv_vector_restore() for the disabled configuration, matching
the other vector context helpers.

The paths that set RISCV_V_VCPU_NEED_RESTORE are compiled out when vector
support is disabled, so the restore stub does not discard any live
vector state. Keep it __always_inline for its noinstr caller. The vector
enabled implementation is unchanged.

Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector")
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/include/asm/kvm_vcpu_vector.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
index 6371d5ea5392..50d4789b9cac 100644
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
@@ -55,6 +55,10 @@ static inline void kvm_riscv_v_exit(void)
 
 struct kvm_cpu_context;
 
+static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *context)
+{
+}
+
 static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
 {
 }

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.50.1 (Apple Git-155)

