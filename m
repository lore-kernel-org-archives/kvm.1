Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF35328C5
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169746; cv=none; b=jVvLf6jgB9anTTvzQP6UJMsNS3m7RJf5LqdjKkUiQ6LNATMoQdIPVsxU8JyPFGB57cxrmPOCkz8RQlFQF8uQSo9goEUkzQ4GaBzEF/cvZ3gOKLt+jd24NAp6p9I22cxEumYfd5CF6I1sPYFZMzrDd8CyhPGudwTa48GXZ4ZuOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169746; c=relaxed/simple;
	bh=u5SQazvSZYG6DNPdDdW/qfbNX5hpingPPYclU8CLUkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQfmJctnGGDO/tYZnkndS2GfxC/12Bdb6sFdqqxv8vFdKs1PfvWCOGE083Z/Emk7HLxVEDMnjkcrjU+5O6+cdIQq6lkwofduWmg8sLWbPWixeN00czYotUQfC+FghoPHpR4Qg+UEVNRhhfOG8D2Ak3I/pOwHA/cbiHctPCoIAuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnTTlNZK; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnTTlNZK"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664b7528so679060eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169743; x=1790774543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZLlHjgFKGd97ZAl0jDOPJ4J/L8M7/uJxBZfNAi1MwY=;
        b=WnTTlNZKpf1CGzgEFkyrfgBwEMABnrMVw4om6dyWjltSk7GHSF7qCHnj3zmhqc8Lvv
         iMH8/2CK1Yh6Y8jBrsjSTA3Pv71q27qT6hXUgGQGzaoG/J9JQUAZgluQrIjlBMOD/jvd
         fzXM9R/dtDzqr0d6mFAY8qz/tmcz9cDQ2n916gOJq81agNHocBNPcJZ+Ykpho9pmz/fo
         GDW8UzV3GefoTZqfHki3Fm0FGSIwMLaBnc3AodhBW58/Kh006AepVPzr9qvR8Serdh+r
         XRCw2m7Z2PbkO/0+U84w53xsKxJ81IrEoP8j7BTEXFrXQRKFC7P0Fw1SJJSho++1QZfl
         B1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169743; x=1790774543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZLlHjgFKGd97ZAl0jDOPJ4J/L8M7/uJxBZfNAi1MwY=;
        b=VpEjHeiiTZt2tDBGQKlSspM/tTaHhpwUVtiIIE74QPmf850SL76Cdz0m2Mj4SotsvU
         IbmklwKqQYbWNEGGH8I91F6esSNYKTD0pi/jeJa0M+soAFprChIYfGfTomGkWFukeUhm
         5AOhuOWDH6cnvjxO4B42KJLDXES+SdUjkK26XwLn7/U6OhakgP6rPaRj5u7o44bFBZtb
         HOb20ozwowOiq5OSGhOZzboT8WF7uNa5YIkNyiGOPHJwMeXu7D49BDgwbByu1XeRdYUZ
         gd2JP11bQwio80WDZiss9C8GS1oA7Fx+xYWYZAlUP5G24//34NlvEYRP0VPHCVktYDf7
         x6Qw==
X-Forwarded-Encrypted: i=1; AKwUvBywIYj48iRUKRwrZGJS403G6VHcfDWWORc2yTvVbEI5IR/rXTwaR+DqJ5kZlmYSHkz7Nzw=@vger.kernel.org
X-Gm-Message-State: AFuF++kiXMquKsMmyowhSLP7AhqQgr2j/Mfu6BfM55o8AyBx0eycVXs4
	eL7jfHNCfmwuw8Iq6wIcipOknu54syRQouhBmyBVjmV+KPtVpOdnbAGI
X-Gm-Gg: AYBFou2njZAOhhMHY6Ba2uvI9Fwy+NK+P/CaZ4ZOfNZxY6EQIdLSxx2lPBjlNon0pP1
	1AgmjURHrX74idebpW9zoncUb9PJhv7eus7hYVYE80hF6KClZfGm252xoUpcPKWmLJkKEBIch67
	z6qlHs/Q+rQVqCTDacrtWknf6KYcDlCsji5Nf4lJJtfix2krZxLd4RbefNnNu3xiQM8fu4lZ9W2
	e5HnqIjL98X5JeaVmL/XdqHkqqJ27+3/uQvXEcWTdGAcgcJPYLM52uZ7PHdQmea+sM2rWdXqnV3
	qB4khIfGSaQdaci6BLek2vomCE5nvMT3P97niVQ0Mvoceny4tdVorg5bo3HvaNcfJsCNnoTbwOc
	hnXNxN+gibCD+NiDxIlJwL7Mg3erNRs1zINVtEmgO3M6q4HlcBSfwDXuXsNYCqKk/EESLsJDYiH
	PZVeKdERYR/lQGSDbIrReZHEDb+0Pm38Vd1aICbR7JO8oQ5cWgc2lCE2P7klekmekxYVNlRL11M
	UJNg/hqqMG/Fk3wlKR72rAwYgalXq1jVqwMEFwjUg==
X-Received: by 2002:a05:7301:c016:b0:33b:d4c9:561f with SMTP id 5a478bee46e88-33e8bb7c1ffmr2536095eec.5.1790169742689;
        Wed, 23 Sep 2026 06:22:22 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:22:21 -0700 (PDT)
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
Subject: [PATCH v3 033/114] hw/riscv: expand boston-aia and microblaze-v-generic to TypeInfo
Date: Wed, 23 Sep 2026 21:15:07 +0800
Message-ID: <20260923131635.1894-34-luoyonggang@gmail.com>
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

Replace DEFINE_MACHINE with TypeInfo on boston-aia and
amd-microblaze-v-generic. Set is_available to target_is_base_riscv.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/riscv/microblaze-v-generic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 3f07ab21328..9b60a955152 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qemu/target-info.h"
 #include "qapi/error.h"
@@ -177,8 +178,10 @@ static void mb_v_generic_init(MachineState *machine)
     create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
 }
 
-static void mb_v_generic_machine_init(MachineClass *mc)
+static void mb_v_generic_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "AMD Microblaze-V generic platform";
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
@@ -188,4 +191,16 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
+static const TypeInfo mb_v_generic_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("amd-microblaze-v-generic"),
+    .parent = TYPE_MACHINE,
+    .class_init = mb_v_generic_machine_class_init,
+    .is_available = target_is_base_riscv,
+};
+
+static void mb_v_generic_machine_class_init_register_types(void)
+{
+    type_register_static(&mb_v_generic_machine_class_init_typeinfo);
+}
+
+type_init(mb_v_generic_machine_class_init_register_types)
-- 
2.52.0.windows.1

