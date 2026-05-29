Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF873769EB
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084197; cv=none; b=IImFrPirwX6ssYzgGQ7eBD7iHXkoL6hIZrWE1CvMV+zwi9ZgNm0iEbgXX8T4ehalDqcCCfnvCj2uQXZyzjhPUEqOoTGvwKwYywdbInWIjk8EXUioaiUPtsIIVWx13MVEmU/VXBvzmHlobGE3aovBjAeFai0RolRjfSp7MamG//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084197; c=relaxed/simple;
	bh=IpmgLDp9A+PqXyCDZOTUnAdh4EPTPNPHedOJIYB47OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8/Yx1ApMn9ZrwZmFtgqIkV3T4+4bmqYOgXId1WX/ORm17QtFNyZWdNzYQGBxhtahqpe06Lo39R56p7DIF/H0abcye8McFIOFUIf94kzBJgbzLgVFCd9Ug/pRGUZnDW1ISz6LiYiI/2g51EMO6f2F9dwPg3C0HP35KCZ5aKAQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnfMDwuR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnfMDwuR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef1198766so654053f8f.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084192; x=1780688992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gToO07btHAw940X+sVMcM9/aOH/ZnEfIGi+vwCzDH2o=;
        b=BnfMDwuRYRc9nlQuplG5+8sknOeZ0mRPnjzNaAocC1kgpet9BY0/xe9VtyrTa5Beiw
         VDI3+QvI+MNbKTvaw8N9YP9cuGFeC5bb/KqEFXCcUad2JlInLvMVM1iLf/JP6dhOxAZ6
         1/EA7hOsqeXIvJb8esd54Jc90czZFQweywVVPHly0L3/pJybZY66QJFsoIf/qvo3aBhS
         QbRR1OvBqXPHWPRU+McB871+ysMhQQnBLqqhQdZiYaUJZ6ZNZYu1qIcoxZI/cKIYqBaO
         R/XhcAYKiT7N+ZxGXV987+KePQEmT3ocytmN5QuLSQAPQqS8+YN0JnS4/6NJG/a9Z+CT
         2cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084192; x=1780688992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gToO07btHAw940X+sVMcM9/aOH/ZnEfIGi+vwCzDH2o=;
        b=n7conSudkXgnaQR6kGytNQTLUYLo0GReWfZbOq9TqzidwPpYbCTA+i3EC88ZzzkZ5O
         gXgNt5iSlhteXD0ElQRAqQVYeHWbHUgUgDApWo3Z2585zoPCZCfUjhp6ziVKLSTR6JHW
         CjR5MOrr8i7UGNrzGGmSOBt6+ZU6HTdyIZOR6nYDY33wVUzocAp47m//1zTuPckrNGke
         Wm+YBBRI12D9KGYziLZ5ElJGCe6U9bpapavU+yIyh0hqgBpzYwnbC0Ls0xBfz8Hzf6SK
         3638kDC8VOGVVhwxVr5AcCCC1UwmY0nsJsURDpooFQ1RW72QwtqR39sNgTyibujvH8tl
         sm2Q==
X-Forwarded-Encrypted: i=1; AFNElJ957WmLYrKVWHwD7ruTGqBSchnIfOEsSHQKgevp08J3Duotq6ZWpwIOp0WKE7sbAlThlLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5ZA0GPH2Cq3VqXNs3xcenUKyuPJBtV8uBrw+zf/5hZXIMXDn
	j0ZE9WkL1JGTFpEHEAay4a0uC5zHWz+BYCbSezTqSoOjQKkmhacLvUrk4RWAF72qMXM=
X-Gm-Gg: Acq92OHSf8/daQc8vkrst0XELYczUpj4RPUVCjW5Dfs1I5YIKTBBb9BzSkN3U0N45xx
	knadZHRoERymn16mbXNci0F/fsE4WDAoL4jzqcWDA8nfcDAk52AU5JG8tJKg7e/dQbf2LeRdIMB
	Xzi8Ksxguxt1nNBpc10W7zbf0oPz4wYokDbxBkX5BrKtlagnGVLcOq8CNZDN7LE0ddHgccxr8Do
	Qh1UBD+l/xa3IJpT7TwOoogrTIRTIwpKz+cnq9ldlozMU76AaThNpvvJzN1K7/NAf4fr7JTGWS9
	uj5x66eHJMMdP5pvYLlbpMOKkpAEBb6DFAEkl4QPyGIcg4HRAcp7qrnnZcj5235p2MwsObr6eJG
	nIdyUVirUthUt2FbAwQmYj/7bZXhuMcWQ8KVkDWU2zSVV35mW266Y1xnTlU5bsuH/q+KsBAsooF
	sXmi42bbj7j1o51Xecy+qJnegdh5sS3EwDZcATw42e4LBG6xeIMFPRdYsn9IOvXM8GuA==
X-Received: by 2002:a05:6000:11d2:b0:45e:f295:33cd with SMTP id ffacd0b85a97d-45ef6ea9417mr918738f8f.11.1780084192037;
        Fri, 29 May 2026 12:49:52 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c50f6sm6471508f8f.16.2026.05.29.12.49.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:49:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anton Johansson <anjo@rev.ng>,
	Claudio Fontana <cfontana@suse.de>,
	Eric Farman <farman@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	qemu-riscv@nongnu.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/17] target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
Date: Fri, 29 May 2026 21:49:23 +0200
Message-ID: <20260529194940.97143-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

