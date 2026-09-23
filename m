Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D18526AA7
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169771; cv=none; b=uRmJYZcedWwyakgZflZxczfW3wfmBAbUS+t0CajLKAJAkV5YWsfad2cCbkFXvC0PPLEbbyHpPQBR1f0sptyAfhmIL7o+mgFnArVQfOmHM/3wnsB8QCFRuJdcS9v4cCZ7hM5JuCWO6rd1bC7ewWp+ZlRTShMgdKiML7fZIZnbomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169771; c=relaxed/simple;
	bh=11p9dF1xutd7yRJXUu+NqYbj1sX3XbSyidNwsHuljeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3mosuuYTbucclZt0WbMJk4QEt/CDxwBMsgTdXh8c1UcV1RnaPR3qi/0n9PLeMWsxtofm7yEblGzZkEKF87ekfVKd2tH7fo50RWe0dHX3XXpyvYPT7jr069jbQI4ArckmmMrdc+Fsta8QrP+OeAP6QJyWOkGV963V1ltYHJ+aOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdiyimCd; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdiyimCd"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32dec843c37so1562333eec.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169768; x=1790774568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qFqvsxy7L8PH7M6DU9x+2jtR9XBAWYnvWHhVICE/SQI=;
        b=IdiyimCdiJ+wPqPZ+iVoITSqMYQ8c2hchaelwvLp+F839/XTsNxoBlRTjIS6pyRgiG
         PQ5hyDOI07NKSGnSPA8VhWpLpSlSYjzwdw5ASIxMJ7yXQP0kloeG1U21d16qZHugLf0O
         dUzRKwNzWdrWSD6ognbW2Ncr3e4UElDwFoYKSkKK7iwJl27iTNe5WwpFMqvgd19DZGyh
         ZtVBf5Vr9WPwVQMJmyDa4RRPoSS11bIOkg8+v/jqEV+hxqHetAnQmb++TfgjDKuXK8GI
         eHO6zMkeLPkL9kLurS90SAJyTQQSPE8HXJ+RAeZOFoFFgNxbgZNdTEWMR6Cqj0rDZHcl
         z0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169768; x=1790774568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFqvsxy7L8PH7M6DU9x+2jtR9XBAWYnvWHhVICE/SQI=;
        b=IrR4ZCttZ067Zcg2kSyT/9FpmixhFPSe43GWFelaxg5cPaOfr3JwKxcMgkJp8Llgd3
         RtjRWS3dhRRy+Ci1p2Iz8toVj1vipeCMXhZa6YuO+3CDeqe/zwKv7un84Q08mAEn08U+
         BBuY/LX6ZgmnCInKdyvrQHA0WVP+DXq1qhB3QaVPK3CY8xMK7oVLmPBlifNW4h0ria/u
         9ewDLjDLZwKdohW20BrTePYW1xzLD/TGL3bDaQpjkev1n9E/rJ/4I4b/VGkxuEyWVFXh
         8t6TOkFXqN6eI2/VK/t0NIwoXcxMyeIUPAyaptx/mSmaqqn04Qh9NEqWhqI6HIKxdYhP
         ugIg==
X-Forwarded-Encrypted: i=1; AKwUvBzjpg+Il7oWoDfP2Bi7vxh528k28PeHyl/t0InKoVdzgp07Yu3BicT6SeTSQv7xVFYBhqA=@vger.kernel.org
X-Gm-Message-State: AFuF++lHmcBIB+pexrpG7bZcO7p3/zJKK7ylh3jmv+TlvEipsK+8UPL7
	T08AYqBU6K7wl3SVOtsTlTtyVqwiKR5spun0+UicdstpqVSyLpaUD/1D
X-Gm-Gg: AYBFou3NGeZnBStwWl9rMjTKV0CSrcfOQYmIAowfRJlO0o5EmsKCTgNTlcPmvVbMzJU
	BMSbA8ThBgsbIZcz+OD0dYMDMh8sU9XTqmRNZULDkVX3wFm/NulSJPUuBb6nYu7YuVjQaxacKQW
	lbritJ7AYlPNi8nG0ZHgJjgUu3U2i3Mu0WzBbiktNyH8h+7VkXQwiT0Eq0C6y9OZrvSCR41KGjw
	+m+EkIgQricqtRgl5BJMg8QWVhEQyxXx88tiWKw0JNSWAIQ1eqR6foOaGlXufRpo1Z3V0dc36gB
	XxqvZ8BeBAl24+l0KixT/x0CM/AMvIpQqXM9qiP8W/73II6E40ilvkGUXDg6P+bHwkrHXVJeLUS
	mqBlmJ8JiTo50fzR2MT7cLfXSUS/9Y4B/6zrPqHlDqP7KKDxZ65mFKsi1WX3q/xWbeKfBRD+Zi8
	v0dPGUziOwyKeFCxYCxMwaqBiD9SU1XS7eRrRaakJDZ/ANOIlTvhTrTQORXzBGmRKhYhAYvBPum
	KxfrVnjis+KyuuEkD6zwWPbPWi2G6I=
X-Received: by 2002:a05:7300:59a1:b0:33b:e842:d272 with SMTP id 5a478bee46e88-33e8be6c06bmr2642017eec.5.1790169767812;
        Wed, 23 Sep 2026 06:22:47 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:22:47 -0700 (PDT)
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
Subject: [PATCH v3 036/114] target/riscv: select ELF dump class from target_riscv64
Date: Wed, 23 Sep 2026 21:15:10 +0800
Message-ID: <20260923131635.1894-37-luoyonggang@gmail.com>
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

- Replace TARGET_RISCV64 with target_riscv64() so dump class still
  follows the QEMU target, not guest MXL.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/arch_dump.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..2704bd8d94e 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -175,11 +175,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 
     info->d_machine = EM_RISCV;
 
-#if defined(TARGET_RISCV64)
-    info->d_class = ELFCLASS64;
-#else
-    info->d_class = ELFCLASS32;
-#endif
+    if (target_riscv64()) {
+        info->d_class = ELFCLASS64;
+    } else {
+        info->d_class = ELFCLASS32;
+    }
 
     info->d_endian = (env->mstatus & MSTATUS_UBE) != 0 ?
                      ELFDATA2MSB : ELFDATA2LSB;
-- 
2.52.0.windows.1

