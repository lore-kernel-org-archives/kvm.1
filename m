Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9C3E3D93
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064688; cv=none; b=c8S3+y+dn7Ic56O8tBMUyhL5Zfyd33EQK+S4GXUWJcsdRkgKQHlLuAGn76oQwMvftDQI7yFAWzdML7VzJVIDPh2R+++j7ZoVgwKbpT4Y+VLIoiH7+2lXxEyv1/2L7lPymsK/hFRFMHdeEeHWFt+YZTLRWCRrsrnt/EllW1tOy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064688; c=relaxed/simple;
	bh=JHei1dyBjzHcEofaW34Gfp27snP5AGwjNQ3Ae6VtGNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsKcROHOe4Hc6eghi4XuWoRXjdYOCk4JMmquQi9DJEXbvK9K7MbMYBKR0AY6dkEIn1yFE6Z4uODS9xZTR8TTS/MwoqOY5fEOukpc5FhZ/wttKbOgrqNQD4zQpvmvquxAjSgagknXBCQOJAPzKHr8lHV6ppI5paX63wSERgZfqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OPgXlCCI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPgXlCCI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49048e043e5so61733975e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064686; x=1780669486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VZ/i6ZvNqvmU5zUZzrSJBDpAWD/Cx5iX+bh+R6LBuQ=;
        b=OPgXlCCIhQX3DuAP3VhdlXwNAcjGgMn2d5TLQlrgrmGgVdOq8vA6GpfrcmnNLWg76V
         oDhLJ17FpVmsET4G+L3C76lnpHqaWfGDPD0sRkTDQpjmaBnXgWS+ZUzFdPicZ2qv9zAt
         MG9ty10chmWL243J4O9k45wcX3phdG6+BWzgdMKQvAqi+/U1gXXW3K6j/rk+SNZzlKJq
         XFqS8OcM2RlxO/ioaonjTqeDa9i1uP7c/fccj3KOuMAXMpa9XpFEvmTBQa8fJ0tI/tmd
         snTYl6WGSxioliy/HcNG+507yqiXeWMAKMy5LYhzDnVZj40l1Fo7VL+tHfjISNx8VcTL
         e3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064686; x=1780669486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6VZ/i6ZvNqvmU5zUZzrSJBDpAWD/Cx5iX+bh+R6LBuQ=;
        b=lqIB96+zsQLH18lVPCCpxNyDHaMYDoU15xvBYpHkqi2HBHYlT9rWBSmeguKMSD5jXI
         yxP1ISKk+6cKIue0RnOfZtBWY9U8egV2Wkh5iTgExUyEeh0shYBdo8MR1q4HMrMc1AWu
         i6mTfWr4GHcccfBaYJM3rdkuosFW71w/m8NegDrXbqHQ5w8PQuV9KkSVqoPlbM37jlOx
         p9vwDzBRDlNjFc4bVhEfWEfeBcx+hmr83FnEDsbiAa2v8madqnvh0FWKrqFlHd2neZwO
         VH6hsV+A4cm7v4AK0H42IUmP3jj6VJGRG7bKUbs//MIyT4PP4utUEdaaNQ2xmPMR9MKC
         uCTg==
X-Forwarded-Encrypted: i=1; AFNElJ+CSDDPL4gF0E0HpJVurW8vo2EGhEPOdSdL7RP8bGTFEz+ZqmPk1kpakn1Gkg+0QrU3LnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBp4xA0WD5An2dXSfj1n1XuRfeo2bmu2BDb5n9gR67OIA7FcK5
	4Bus4CVrnaUiDF8DA5H5H0KARAb+6I5n8Ft0psMQRNRegWz9sl/ndpWzxiws1sGHCzM=
X-Gm-Gg: Acq92OFnHrZfzOW6u+YTc7xXExau12TKPVWfz0An8OrW+VMhtOhsBJMsPk1tjAJb20J
	DruKcdmD82PVs3Ypkb6aAkPwvBoA49oAqRkmHcIxDerFEr4nOcOZM1KCz/WUE8EOaqLD0WXa0ci
	RrDlGQUJE3fNTpmu1OuVltJoJq67nV+5Pxue3FhbVcVGE8fpVROFs/tIG5JUJs+M3VRR3WElQwK
	F8rufKk8UMI7t8uAFjKD6tHA3AZjCE+fxsfZH4TkOSO22fHb6lrcgJaYrJW9aumSf2fWuxG773o
	kWjKV3HT4259Zcy55Pn9LeL1AZLpova6k4OPPb6SvSX4LCURI6QWMafL2flrArGSsxG4qNUhTk2
	VzYUXqtFWgAFdj8FokQu8EPOlmPuE+0T7SLAGvFFzI0gEKyw544rA7JO7a4mqYtJOGLyh2685xv
	NKObFK3jIkIcLR5+Ib5Y57dHVjC/tAUlFHuGK+X2k5a3/6znCweDgF37bpxHFwiM2A9g==
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-4909c0bb2e7mr47068875e9.27.1780064685579;
        Fri, 29 May 2026 07:24:45 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7e17sm52805175e9.9.2026.05.29.07.24.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:24:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Song Gao <gaosong@loongson.cn>,
	qemu-riscv@nongnu.org,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Alistair Francis <alistair.francis@wdc.com>,
	qemu-ppc@nongnu.org,
	Weiwei Li <liwei1518@gmail.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	kvm@vger.kernel.org,
	Claudio Fontana <cfontana@suse.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/17] target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
Date: Fri, 29 May 2026 16:24:17 +0200
Message-ID: <20260529142434.87880-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"accel/accel-cpu-target.h" is to register accelerator target
specific hooks via TypeInfo::ACCEL_CPU_NAME(), which LoongArch
TCG frontend does not. Remove as unused header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 31d3db6e8e1..2bb1feaa66f 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -9,7 +9,6 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/plugin.h"
-#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
-- 
2.53.0

