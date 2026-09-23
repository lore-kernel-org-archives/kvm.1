Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180E531630
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169755; cv=none; b=M1wBfQSYSzh1HGP7ARIFh2ytn4l92r1FZIM8v0wxuCdoyBNyiTco2O3TCWaSej1PerHmiCG/zHibqzxxAh8tr7+gc4YSOkP6RmiLihfvSQUk6Q77TlzLfeZ/T5DAiwI2DYEXQbtJ2Cj8FvBG+iv8CJhgXxQhNIG5isLU8K0xD8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169755; c=relaxed/simple;
	bh=oSYY27c7r1ykEbO9MXrc6PyTl2NBun5EIyZ21ntf3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPg/jgEOzwKdpEaY3yXJj0T76bjmX6u2Xuejok/+aqEsMIziKgGvYN3TNdDsAKiPLInEihmMHyZAshqi9lEnS4JmBvKSy+8+pdhOuaEqh/TYPkdmPjzaj+CO/dT4Q3kkPS/69hc05AZf8X3HYpgb1CsZGAhuVq/TDiMH5VSJFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/jsueJM; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/jsueJM"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664dbe2dso384610eec.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169752; x=1790774552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqXX4SX3rjdHTToJvg98g4i7PWcyKUf7129uvkL7/uk=;
        b=A/jsueJMz4xnwCOlvGVKGENk2qguRmtha+wPawatSW8s3l7lW8RuseuVC/WhYHXNIn
         ii9Gpf/KCnKouT4pu9jhFFEMP9uVQJ4Z4/H2AmbouXRaULZFDLDzQb5RfLvdZ7BcRYq/
         CR5eC6LfhgnYRkDKvI4Gkxi172GjzqS8UN4oGahaAtTSZ9nl49K1HLu6ABNaieYm32nH
         E5Eza1XzREr03kAwJkUASoOyxFUvO5NJcf8xWq16mZvUWDx7Xx8tN3sLD/Tn3zVmBb6r
         knJWzyvfxVvwUbglh6pYjv/7poLQTCGvAYPGH3Xiqot2RsWSgoH+zyzpQDODOAUK0jR+
         N4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169752; x=1790774552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqXX4SX3rjdHTToJvg98g4i7PWcyKUf7129uvkL7/uk=;
        b=qn93+7hg4/jCc9ygWpJjV+Z1U8xopXWJUBv3fO7B/nwHSI0AmmN6rW1Zrl+Ill2NUp
         6xDNZvvwHqQGVDPqjVOw1hYkRrwF1BZGb5XHfYpPLIGDBMt2p5YILdw/X4UDH/ggm237
         55+N4f8qJ9JjuryLXkj1WiATkD1/YZnsylcX8lKFyossB0ejSr4QTckiJwSC9S73UBpT
         UCmEpunFMWrA1T8yfxwZuu6xl9VKdJap4oWQEbitoUNJty/7HQ6IXxq827VPsT89829X
         9G82VV0tHSzjxIkNw1H821eucMK4hEvRUZq7RB+rFhLdt2S/xXcMf0kI4dWww/Kxinj7
         GZJA==
X-Forwarded-Encrypted: i=1; AKwUvBzpyEMjGQ6yOLHKW7eyRj8CBeIbsFTDvGAQZnYGwg3G1SyZX/3ffJ7ybQ0zUSKCYbpRv9w=@vger.kernel.org
X-Gm-Message-State: AFuF++mNnnDEK5/9W6yuhdxjLKhmPuNYuwqI2D/cS7hfe0X2eKs0DDbR
	JCrkivH5P64N7tR9azfFung+tLYbAs6t8a/yA3l4Itvi2cZBP6QAAFpm
X-Gm-Gg: AYBFou0q2m45RNLSSbmmhsGSFDDLTqrQrQCSSYT1owVQxnQYfxtI4UY7s3uk0Vq5i0p
	8PRuC9ovj1YzzNa2R+6KjxF4Kw5mcaLrnG2qKwWrfw6J0lPqa6a0oDVi2iOzJc0sfrqC9dzR286
	hEnTYtvwjUJJWq1uZRTMWvrtZ7V5kieInGUyM44Bwt1HCjtKbkHtIh7y5IO/XSTG1okfPuqJjlX
	GK411IXQXVCCw0hGbpU8NeA/UFb2fzn8N2lUdWRsWdbvnzSiyWmKXhzYGAYSSsuJSmdcp50+SO7
	DVcZE9Hf0KDTeUymPby7gtZsMSaQwL64kQ/5v7ARgo4fzjbLP2UCE0mydPYEleUDKJNvp/xJHSq
	ryWgLVTbFkYRVMHBdHCSj3da+tjiGhe5aImEtP8mvt/d0SMWeXLmxhCAlp44VWgGcu8waVg4HR0
	Cl+K8savUOGJFi+OP46BXh7cj9U+Fvi5cPqcQlHX4DHACflVMdeMZVw3NtW475w6E7MA0gU+b9J
	SmaN+Rn2d2GITl/
X-Received: by 2002:a05:693c:8814:20b0:33e:5e42:e0f9 with SMTP id 5a478bee46e88-33e7a4d6cd5mr2603893eec.6.1790169751387;
        Wed, 23 Sep 2026 06:22:31 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:22:30 -0700 (PDT)
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
Subject: [PATCH v3 034/114] target/riscv: Include migration/vmstate.h instead of migration/cpu.h in machine.c
Date: Wed, 23 Sep 2026 21:15:08 +0800
Message-ID: <20260923131635.1894-35-luoyonggang@gmail.com>
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

already uses fixed-width VMSTATE_* macros and does not need TARGET_LONG_BITS UINTTL helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffcef..00805745fbf 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
-#include "migration/cpu.h"
+#include "migration/vmstate.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
 #ifdef CONFIG_KVM
-- 
2.52.0.windows.1

