Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976152FE36
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169567; cv=none; b=JLB38YnJsjfepnFmjtBpZZzkTGU+EWG1KNgoX+R9+ljNK9/Mo9gZsK7VqUkYCXjI26duAikiAINmLwXVzKZRg8Es/mK/wpPUaY6Cc1XJmtHgh0u0id66Zyh2rQ6vX1o2+3bfKPvpt/6Lal/b0XcmL35FVbpnXAaxIuHHmYVeHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169567; c=relaxed/simple;
	bh=CiotPCLKfRsZepH8H7CIX6c7VWkbaaGed/EYa/uBBIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfCZeAhtRbpw7wia38MsnrHHhK1sjvrrbMG29zk2D3N+vp5A0SH0MF2H10yCaeqnwUaYEpfd6IAdr2/nhtRYnO7ztxfMeq7xr7bTUjuY1uN2U8JqvqzJ9qXzmVMd8iCJvxX7jXhVv2+GBTS7Z+3LHvjJ7KrWZK6+wquTcZ/lSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz/B5b2e; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz/B5b2e"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef791so585517eec.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169557; x=1790774357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoknbnXiPKVvZXfcQ8PLlr7Gz40KHcVsCzqNeg5MeQU=;
        b=Mz/B5b2eARAXt+5vdW/zx9E2WWIdf6JyvNa0tM6wp1iNMl8kZmaULZmlIkcvV+4Lqu
         dWlqrwUfyNqrAjfO6PjEIvFBpsZ7FcHtUoIjxOyhJD8mw144Rs/iXSetpcvCpBaNFS6g
         JgnZn6hAZA4AOjKT2KtClbP4Woyre/tZEvW7yX6RAAutdAVevdGDYHNTm6JkUr1Dgq4L
         eKs4Lr0HTO+ds8PYCcssm/4AkJ6bK/bjg5jJD3VcDdcs2lufSL9VGOdV5rT2/mpwO+LD
         pEAgGYLbRP+hbvag8ZdKmQWXij0g3kCPg5KUPse/c0Y9Rp3Bn0bD/8Rb2hLiFEZ61OML
         yN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169557; x=1790774357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZoknbnXiPKVvZXfcQ8PLlr7Gz40KHcVsCzqNeg5MeQU=;
        b=2B3fTLH+z6iNzMBk0kZMXY+1QpkSyR6TcsCefQXs/xQnVqcQPGcJmkY6118qhMogTW
         3sq9sh54EUX+0FsIwae+/fBVnDuE2nhKBYg6JOegaOsAi3pI486IIhyxUTOdhG6137Ff
         1OiPlUKd7KAzViP7z6+0va27VpxJaUj0fpno1zMf7mvHVNNTlKJ+aD42hNAxyMrUdUn3
         3dyQgbMy0zabHQB6UyhXwXWps1e/0oG7LmnnDt7Hrok5Knxnfi92c/6dTAmYIQvKc4Wt
         od4i9UmRXfcqQfoTTF6h0YoOsoWJjZYQi4Y642/OqhtdnC2xoOC3d6gtbRB0UBrSVUeK
         nsQw==
X-Forwarded-Encrypted: i=1; AKwUvBwG6RSLArVhZcU4ZVne4o8wT4lw60IM+2vAVj4M+RC0QyI4CunEnOkO4zOxoNsPK9owG7M=@vger.kernel.org
X-Gm-Message-State: AFuF++lvYT4NmtKjjVrk6/Q+n6iS7qY4408QKqu6EecghXLSyBfS8Uys
	3YohDoU8Ulstfloc0vfq2HlQQ6TyKWROusdwHovJgFUxZO6ZHVaWvIfo
X-Gm-Gg: AYBFou0yR9UxaiU/krVK7NEmjTpvgZXaFA663CxLkxlTmawFf551YOK8smZrioUpn9z
	vvNLw26RrXwO2h5fi/S5eglEEujJe/F3hEF2eJcFv+3uf1mE6McCMEH4eP2J2dO+Vip02zU3F6M
	JxLsN5u0x9nt+gCb59v8So2wS/IMINCmm32ENoB2DfetLf2kQMmMYEG8J7AW/4VjPdftXhyx3EW
	k14aDwnqgNyUVrhhg6eO8wKfnL7cX7lN4TLOzXCBB8GbUcXrZ09UR8bML+1Ymm65LZpE40NxWgJ
	wuAoMZv4berpJiwgGw200mqkpTtf9ziYfyY73N8QUAHDNs2FaFnXASJ953MwOoKr4e8Y9+v8ICA
	rjtlL5mitC1WGQZ0pBDHcqrec9opgUQ1CZJpTDXmm/mXRzygRfL3tEzMndLMWYCA6J24oSsBAg5
	kd1/DsBgQ5z99MDHyBE+qkbfvHUqNaJfVuZvO31jS4lu15HMB4ogyun0gwO1l7E7OhPlv9lvtmr
	2SI/o5t0xy2j+8SUuQhFQvCOSxdCC7kFvwbh89YWA==
X-Received: by 2002:a05:7300:dd05:b0:33b:eea2:cbfe with SMTP id 5a478bee46e88-33e8dec5b02mr2370454eec.32.1790169556543;
        Wed, 23 Sep 2026 06:19:16 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:19:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 014/114] target-info: add i386 and x86_64 helpers
Date: Wed, 23 Sep 2026 21:14:48 +0800
Message-ID: <20260923131635.1894-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is added for latter use with is_available.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 45 ++++++++++++++++++++++++++++++++++++++
 target-info.c              | 36 ++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 89656da1ca4..440da63e6cf 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -98,6 +98,51 @@ bool target_is_aarch64(const TargetInfo *ti);
  */
 bool target_aarch64(void);
 
+/**
+ * target_is_base_i386:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is i386 or x86_64.
+ */
+bool target_is_base_i386(const TargetInfo *ti);
+
+/**
+ * target_base_i386:
+ *
+ * Returns whether the target architecture is i386 or x86_64.
+ */
+bool target_base_i386(void);
+
+/**
+ * target_is_i386:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is i386 (32-bit, not x86_64).
+ */
+bool target_is_i386(const TargetInfo *ti);
+
+/**
+ * target_i386:
+ *
+ * Returns whether the target architecture is i386 (32-bit, not x86_64).
+ */
+bool target_i386(void);
+
+/**
+ * target_is_x86_64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is x86_64.
+ */
+bool target_is_x86_64(const TargetInfo *ti);
+
+/**
+ * target_x86_64:
+ *
+ * Returns whether the target architecture is x86_64.
+ */
+bool target_x86_64(void);
+
 /**
  * target_is_base_ppc:
  * @ti: TargetInfo to inspect
diff --git a/target-info.c b/target-info.c
index 6d57cad5d33..36f75ece36f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -132,6 +132,42 @@ bool target_aarch64(void)
     return target_is_aarch64(target_info());
 }
 
+bool target_is_base_i386(const TargetInfo *ti)
+{
+    switch (ti->target_arch) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_base_i386(void)
+{
+    return target_is_base_i386(target_info());
+}
+
+bool target_is_i386(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_I386;
+}
+
+bool target_i386(void)
+{
+    return target_is_i386(target_info());
+}
+
+bool target_is_x86_64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_X86_64;
+}
+
+bool target_x86_64(void)
+{
+    return target_is_x86_64(target_info());
+}
+
 bool target_is_base_ppc(const TargetInfo *ti)
 {
     switch (ti->target_arch) {
-- 
2.52.0.windows.1

