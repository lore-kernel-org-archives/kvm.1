Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC353163A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169722; cv=none; b=JJsK7A3U6w3MNRxNeO71R05hkZ/0eNWj0kSQv/snAdGH5hFjQNDwn/OS3xeZQ4SFa1+ms9waBH/xk5L0jHzUSHnwxzhgDj3FbAOUTz09iI2+Na4KLdwF/v4gEJ27bg+4kTir9AZLPvhQ9n3j65QAWuoJy2bPOkJZfsGVWtoU5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169722; c=relaxed/simple;
	bh=B462ZaQo0ZeE8aJMOaTMRgAY4B01fFCOo13iwssI4bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhWwYwFS0Nzt+pAWRj9wF/aEoeGMpjGJ7GTDLyiDbSjLtZN6X9EHAmu20UEDlTbvZFQsa8xkg8LEvyPKXl2rEIZXiQNU6jKaDTVQxty7raBtte9ItY9NO1JJ0TA/JeEIAJgd3o3ETm313Kt91ldpAPx6StOHtnZ6M+24MPHg8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTkf/g7Y; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTkf/g7Y"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c3735125bso410779eec.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169718; x=1790774518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=20fmaOno77HQJxryAkVKJDwkjIsA6lPsyx3HFEs6GYM=;
        b=jTkf/g7YrCmVYvQwjUQZyLuH2LBA1jEp4I7VIhDT4RGuTjEUP/Zx8IEvw27BC7gEwy
         5B89lI5FjIxBPXhEtTsZtWMRSMH+kSVJEk1FJyMdVoNrxpnMCOfaPavAuRlCWSsnvoks
         sMqBUO7iWnRlNLC9HsYX4va5TKcZmyFqlaSD8ABF+bLaPnNzzOXmrjmfyd++L5zWrQI+
         3XgArv/UcXYJboOc7lo9NpauaWaMVco/9YK5888g3u1hQ2bEWSHyuo4b6lSsfJyf6jJH
         jfpDKnEceQXHlO6RDhEE/+RRvQ/FlH0sQ8iD4px7QcRZDt4FKY8XLqN8NSe8MJw0t8k6
         x0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169718; x=1790774518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=20fmaOno77HQJxryAkVKJDwkjIsA6lPsyx3HFEs6GYM=;
        b=bAiScNeny/3clQvxlH0vD/ho1qRZKqVLy1QSQKaBHcXTWiBPM3MJ8JGoCNgUySGOUu
         K3LbHfbO7gI3j74W2Vz8+6VbjCtVtHpXbMloowybISfhaOG/trgJEvMwXaiIu4XZyc7/
         ouePX4aOpj+hmy2GW8aAektyC4+cKyIJi4WLh/Bd9fgir3LBw66+pwdHQbJSwoL5txT4
         4FObK2fynIhWNXTAQw6i54X2OOPjhV4IGuJpTlBJJB8nM5BsPzzJPZmmwQTtaI21LGBq
         /YHmD6XBBvZ3acJXp5W5ezUWueEHBRH3rCRD4J3FFKql5M2JTflJKSYYAZCRQQvK5ZhD
         7dhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkZyScRhZJk0Tu3gS0cfVuuoT8YFza5l7UvGBu58tDtVv/T767UzMDq5oMmBhFRbV3zHA=@vger.kernel.org
X-Gm-Message-State: AFuF++mbgLtvYg/CrcPyeFIviYVhkWaoqPIU7v3yGWPKO4uyPKj3gsPw
	d4YYDV5iglBHVxJbpOnw7th4NRWS4KoSAbREMJqkHTLUgiqYB3l4hh6f
X-Gm-Gg: AYBFou0RTWAxk1xwLazbM+R8wlTPyiGVLGNpaWC/39JBxrJDHXZ5FJVu1Gk9psMWodK
	/OHKQtlvqi67ubuyPytPfInFvfz4Oi61wOs4o/cKaabRKMzdaCwvsVJNa4Mx+k1QwOIjw+FcAoG
	84F+xkfdk3xzXiIb1DKCM9/4KJ6z0vLJ9snzxf346yzosVovVqzuN9RhqTG1YjV2KZWTXV2W8JC
	oGzzzyeGobwwTl1vKhVCcS0mah2++cc5H3KNLKrYppB4bjEeUKgcGbKGkY/JeMwY3jEePm+Cn5K
	25MaU7RonbgV3YdYMcHoR3Td1B7U30gUpK5aYm8nMOAE3X0EfwX1qkkNxZ3/JnajpgyEKLIUqE8
	ZVkKvjg+SFz4EWtEoqi2o4p0sQdaEQkyZWF9TgRPzrewjcA1efmSnzyvNM4rTFbEP96r2g8gpZE
	WMMAuZrItpi5cZZfYIJQx+9BthKBTH82ikrMATlup2uHrZtcDFWOizbGaGuM3RvuvlxgvqG8b9N
	gm3HJf41BlyD4A3B9Q2rO3BrWKcCgz4aSE0MADOjg==
X-Received: by 2002:a05:7301:db0c:b0:33b:96b8:3818 with SMTP id 5a478bee46e88-33e8ddbe14cmr1962518eec.32.1790169717553;
        Wed, 23 Sep 2026 06:21:57 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:56 -0700 (PDT)
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
Subject: [PATCH v3 030/114] target/riscv: add kvm stubs source set
Date: Wed, 23 Sep 2026 21:15:04 +0800
Message-ID: <20260923131635.1894-31-luoyonggang@gmail.com>
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

- Add riscv_stubs_ss and kvm-stub.c, matching the ARM target_stubs_arch
  pattern (has_mp_state returns false; other entry points are
  g_assert_not_reached).
- Register target_stubs_arch += {'riscv': riscv_stubs_ss}.
- Leave target_arch / target_system_arch in place; next change can
  move RISC-V onto target_common_system_arch.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/kvm/kvm-stub.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
index 64e39c96d89..1c8c324cd44 100644
--- a/target/riscv/kvm/kvm-stub.c
+++ b/target/riscv/kvm/kvm-stub.c
@@ -9,6 +9,37 @@
 #include "qemu/osdep.h"
 #include "target/riscv/kvm/kvm_riscv.h"
 
+/*
+ * Safe to call without KVM. Return "not supported".
+ */
+bool kvm_riscv_has_mp_state(void)
+{
+    return false;
+}
+
+/*
+ * These functions should never actually be called without KVM support.
+ */
+void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
+{
+    g_assert_not_reached();
+}
+
+void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
@@ -17,7 +48,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     g_assert_not_reached();
 }
 
-uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
+void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 {
     g_assert_not_reached();
 }
-- 
2.52.0.windows.1

