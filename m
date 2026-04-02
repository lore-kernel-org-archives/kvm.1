Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026630C637
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149516; cv=none; b=SOT6rktHYWgZTxZZ+ep6eSwToS9ornZYOBQBgui1VNqKKq5iqds3ItR4N3yTVZW5vAJ11T0onvKlZQ+JjSKPDssgOt0WVdVesgfCvwmcb0JagIsoTI9aqAWtds0ygaD/UrPeBfDJCiu4T1LJ4RRW01Vv1DKnmaDcyQSrV82yRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149516; c=relaxed/simple;
	bh=R2in94FmzWQ9yv3XhT7X3IpoXtiy6hYv7I75wxIanaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfeseLjcTkPMcNXYep8DZkgh2ssCCSA5xpp2uj2vdEUHfjH2OEwa/v668GyZ7xVSjjpHcD/vsDmfg2/a40TvgqCED5FHAQ2yz7/FC9ndTocByvlqK/uA9VyuVH4Fn/wy1G20UZoXtsx00+rWeUY+g2wMl3Y6ZlwxUksDnHctIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRQou6Gb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRQou6Gb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so1030250f8f.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149506; x=1775754306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acVMLUbyHF8kLnpilbLd0pGtSfhr3LEsLd1hqYU3gOo=;
        b=gRQou6Gbm+JTn8OMiF+1lKBtYVKiVQBs/6mLZ99uQhJWhHwDLwxn97UQQhnVbcCFxr
         whEkJxr9nkx4SeWdsdmVJGqfHBs+f3dWOmFFlKEdiJUY7NgNLexY9aiub375Uq1IA1ME
         lyc0YU6FhKLz991HCxjFkNd1vlRasYbpgvkk0Js5EjNgaiEhonfSbDGQQ1S9CIx7MeMQ
         Z3O1XglFt0ddNAQ3dmK+Uyc7y1lGk2gcuLPsqkoBxsDqphQFM0mzBpXa+7/uM5SrCw3w
         V3hgKQ74H+/2LOSPqR1/xMZBsj1TX37L0+e6nYBq4cfDb0vHch2DkV6DacCvxSQlwvXV
         brTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149506; x=1775754306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acVMLUbyHF8kLnpilbLd0pGtSfhr3LEsLd1hqYU3gOo=;
        b=IlmVDecmlRUdy4Jf8suCV4ukeZ9Ud4dKKrI2371k/TNuT2x82nH5JqZ6qdXUTmc3eG
         FomAKtw3DV1SWHc0u8Z+smWEhrs/lWn7t3IPlA3x8NPYZJCkBHGUGV0jLdd17NfHKEUE
         buN+h8eYeofB4ZONRbxLI/i6aCxGBuuolKJwFQ1SYrjcN8zZuywdCWo2r36IShPOcvhj
         P1jPQyi20pnXARQOVVsB9VHjmw+OUC/WjJwPxf/KOn4I+4ceaHSTthhVa8LcdqoaaYCF
         bFHtvWDpnLv6/vITj+rYvKggWSSDaShgxcw8AFEv9k5YbeMPFVEt+A6JDh5JGU1BjFuz
         GdnA==
X-Gm-Message-State: AOJu0YyoydRSXf6StWC4qIXaN9IR+M6zhyWHGSwMHCcnlH0RnouzBzYD
	eWL+NXiDMfB1npU4QLzeag0vKGdlhy3Oec8Tjy/0PyNQd89nV0AmsbY2MBt4HPfpOPo=
X-Gm-Gg: AeBDiesgruVu9Ug+2+kmbdRwKOYPZPWGrO4B7WZ9WNfZ9sCMR1qHViJP9+vyHbrLQCn
	Caubayo20QwLD4wDSCd6n4GGMhbpNJDK5P1RZd1hGofkNc4K686rmR3ozT+yY1ZEt8D3vSbxyBx
	2ZHlVsExXcSfyUV0nRXRfK9bJqSVqO5Kn+IYcvPgnoVQBbJJw04i9pqNCh74FKc6BlsXgZQfaWW
	5iOEyJuepPLQUmTGmPaGsq4bnjpNmanSL84j6zkZskAFZASFmFvjwWAyMri3e9o0romi23hLcTH
	hSKrTofFiwYd3Aw+JUD0NDlcSzcajEw58netDF4xIY4uYIa878vvKFsUm6IBva+tyfyozQsiFaZ
	vWuOgzwg8iG5eT43s8rvCt4CkEy7gfDCRmb5lVJ8ppayUsYpci40rm2n4BWcuNwIYImNkpuMvA5
	Nb1jWeNOfyJGkPCGcDx93gqFPgsKJZeH9ggTGl6037v8APOjTw5YlPYp/tIjXHM8umSPWiUdEtm
	sN2qTnaZkk=
X-Received: by 2002:a05:6000:4008:b0:43c:f764:6256 with SMTP id ffacd0b85a97d-43d150f6c7emr16029702f8f.37.1775149506486;
        Thu, 02 Apr 2026 10:05:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm9295799f8f.3.2026.04.02.10.05.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:05:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	Anton Johansson <anjo@rev.ng>,
	qemu-s390x@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 4/9] accel/kvm: Expose all non-target specific declarations
Date: Thu,  2 Apr 2026 19:04:29 +0200
Message-ID: <20260402170434.94783-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

None of the declarations guarded within the COMPILING_PER_TARGET
checks use target-specific declaration. "cpu.h" is not required
since some time (maybe commit 4fb54de823e "meson: build target
libraries with common dependencies"). Remove the restrictions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 9b722ad931a..c33fb160b5b 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -225,9 +225,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
-
 /**
  * kvm_update_guest_debug(): ensure KVM debug structures updated
  * @cs: the CPUState for this cpu
@@ -450,8 +447,6 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
                                        hwaddr *phys_addr);
 
-#endif /* COMPILING_PER_TARGET */
-
 bool kvm_arch_supports_vmfd_change(void);
 int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
 
-- 
2.53.0

