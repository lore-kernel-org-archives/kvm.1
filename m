Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE4347C6
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074687; cv=none; b=qyPr4+X62aGr2Drds28MTtwuzInlswuxDgpgqcbeu39PyNZ/n648XC3LvsV1ujP24TF2BR6CzNaduE9rDDLuYfzePb0USOydprey0DckVfScaPZRSW6vFIE+TWp3QtEO6yOyG0gJ3iegSYc2L5vE8Ch6wIhA/BhtKa1EKeBQxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074687; c=relaxed/simple;
	bh=NNzXqoY2H15NHT+H16hubBvN/HIaRVRWVP2Nx6uHQcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyikbkYX4aFQq1JlpwodWPkG+eg/WGcRbHmEiSO8z7W7xX71DwpC1xT3tHdNYvf9UK29uy02+ZBmLVqKKoz2V1zSQhiWVYgJq6Y9sfZcGck9n3Xmza8fNz8x7+ry/mhkwo3zCuxUwh02Rz0G14VIIphYzEsEemiop501BT3rjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yb/lfVJa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yb/lfVJa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso1004225e9.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074684; x=1775679484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYDlzgPnnjYZuG+tzOHNfiGffF7GaOFfYwOhZf2SBPc=;
        b=Yb/lfVJaf17nU0xm5q3gP9ibiy9Fe90cLLQma7XWIIouOFu5168/ChJ8GYLI6nytVh
         4nhtUjIOTDD7Y9eCvm7ZLKtEtiw3OJnEb8b2BAkIifRC0mGHM3HFNqw9Aszjnz26E1SI
         PTd3k3BobTFYQwFcwG8XlyypQtd0RR1GC0kvzLFMht+/Xv/X/+R4wIAvOxVbjAGSRGSj
         96l6bNqCKg3L7XiE9JIE+rAThmi5mkPHZjdNbN0YrdxjCjhpYGs0Iz5kWRM/UNZLc3hr
         PQQKvVd2xoCUJ5kpbtlwk5N3OW6KutWpcoiFBwILxrrq98gdczcv2du6LJOCU+IjwYvX
         yZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074684; x=1775679484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYDlzgPnnjYZuG+tzOHNfiGffF7GaOFfYwOhZf2SBPc=;
        b=AihRIkLwRWW1wL5jK78M4wcfCiakEXtVgo3awK92PZNp4snhcnqbVdAHXyihfSTFgV
         /L784kyxlIhDr2Tm6jNwN7/980E18NFQUn+jXX+khfnMzAn5KZBY+A81JtE1MjLeufRJ
         yiKb1SN4fP3uhIcIA5JSV1QwPl0n51V9ABhkr4CpvonUWPZtZ4849+dMS5ChVvq34duE
         IRIDvGJ2cBfd0ik6281OLgJW+XPU8/KM0Uk5d/kb+1UIQcb/mulNIYXSW48DnI58CdSn
         Q4GhDXcwq1B5VA+Ykc6PU4yG5AtAqR/EfUMoNac3lj5pLCEDr+ioc2njVGWa8cskx5eJ
         9qcw==
X-Forwarded-Encrypted: i=1; AJvYcCVwMYXDTx4kGb6felE/3ZYVKGUT0DchMD1Ee1AbV0cEwAr2sWdKjIgsnHMoByhelp2cWVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9JVkzoYTGVgvIEz/J677v/4KObQFCX0YrxgzUpNNmAdWa4tI
	gdiLutMY4B6xgBqDSTMGEvNxidpX64HemsEE2yE1T9je47A52oZb3uSg5h/YnM/2J+o=
X-Gm-Gg: ATEYQzzG+1+bdMFSp5/qqSCfdgGb9BT3TeObIGknAKCfUN54qp93m2QPvH3PIMj1zSR
	RntDsHWM6zg7gDEfO84Dm2kXQ283MJlV1Fq60UbvT79EqDYm89AEMT3XDmN+Aa7DOs/JbXzDGJY
	NzMg0E77WBMtb7B33H9dxhGWtQnMsyHPzkosoMcKSVt/Yhg+XgqfrDLmb/eovFi7//BQiYr11WT
	FqdWpqvst8V3Nhe6kuARFyTSA3qiqb2NkxS4+YWXVRdvlKTm/p/wDbkLNg3Jat8TqA7wVadvsR0
	0AIKYE85K/7fb+DZqWOWWM0KBAaXWdKG0aa/Ar4btueyklr3qw38AvVULUBZdeXMxqEJjdINdg0
	jmMmSN5y4rfOeAwS8/E1iKj6RfTQqlhtPhqfJ2N2uxtk201HS1aX/2vBWpfPsBp2eWNOFrQv05H
	qY+Qd5lWFtHxyu2KHocyQJls8M8JlLakufXK24QHroHtvAmHMyw/Cj1Nk+7ExH1YMArYPbo8C4v
	pi/jX0wwmw=
X-Received: by 2002:a05:600c:41c1:b0:488:8b52:f7de with SMTP id 5b1f17b1804b1-4888b52f8d1mr6554095e9.12.1775074684000;
        Wed, 01 Apr 2026 13:18:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm126418075e9.12.2026.04.01.13.18.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:18:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	qemu-riscv@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Anton Johansson <anjo@rev.ng>,
	Song Gao <gaosong@loongson.cn>,
	Weiwei Li <liwei1518@gmail.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>,
	qemu-arm@nongnu.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 1/8] accel/kvm: Include missing 'exec/vaddr.h' header
Date: Wed,  1 Apr 2026 22:17:45 +0200
Message-ID: <20260401201753.92290-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401201753.92290-1-philmd@linaro.org>
References: <20260401201753.92290-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b67be03e3ac ("accel/kvm: Widen pc/saved_insn for
kvm_sw_breakpoint") used the vaddr type in the kvm_sw_breakpoint
structure but forgot to include the header defining it. Do it
now in order to avoid when refactoring unrelated headers:

  include/system/kvm.h:404:5: error: unknown type name 'vaddr'
    404 |     vaddr pc;
        |     ^~~~~
  include/system/kvm.h:405:5: error: unknown type name 'vaddr'
    405 |     vaddr saved_insn;
        |     ^~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..12f7fc8fb58 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -17,6 +17,7 @@
 #define QEMU_KVM_H
 
 #include "exec/memattrs.h"
+#include "exec/vaddr.h"
 #include "qemu/accel.h"
 #include "qom/object.h"
 
-- 
2.53.0

