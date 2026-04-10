Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE495345750
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850917; cv=none; b=J1P27f6HT7tXBJyhZxDUOCrOkyr4tmltRZ4vypjgKEF/l0i3Rb1T30gFBg911Xv5Hry100O24JGO1lQA25Hm/yO1C+cftU2YkcDf/NApQQwczAcB8rmMqoGvpOmrQWivfRJzdaqc28K6HTgHGGYeaUqn/It59dskQ+Fsv4eQBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850917; c=relaxed/simple;
	bh=3C9yRjGxxIEZlZcT9l0nQcEszIgjisLm1Yr6NYIQ3Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdfAjPAJAqa4W+6UtJPcnq99c/X0bEMMK/5bsGqeAvofIHdSUTq9k3Q/hw8dGB4ZGlLWAFGxXdLdLGXamOYniFSY8xvhiC2cmw7eX+E0UDh5lgSOV4joipKIFZUKon0th50KTdGu7MAfLDDUoi6qJGOMR2fna+Figf7WX4pcT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8WJkrsR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8WJkrsR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ad135063so22812865e9.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850914; x=1776455714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HAEsPfskfREToikV46U/wzGFh7dU/0uRJHIvrZhc2k=;
        b=K8WJkrsRPHW1G6mhBhHUMBpDFADpuOwuOlu75o8zRIkJRV3Rg8QHSEfeRvK987AFDZ
         TFOaAX3Iyzh95YAvAt3nB4NqQavofgniT1yU9ntNqHROWGrzQ4EA1W3wip+XQRhujNDx
         /hLUh/RrVlDK/HMiwzQxmVeBy//ucvl6vg/qxw3VlcRI02pc+CJBOBDxpzUfc+GIJ+zZ
         v6StQRKGAPY+rMx0JQPyRezYJpBygqQwxTmpEXixnY2UlRaUuDs2P/FquXHtIJ9FOqdK
         MMWMXsNGz5xNap61pfd15qpcoYI+MhNu68eXaL8L9WjRC3hjL61M2bI5qcHsoxW8KSvK
         fgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850914; x=1776455714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HAEsPfskfREToikV46U/wzGFh7dU/0uRJHIvrZhc2k=;
        b=e81CoyUL+sTc48AXiNibuqIDSSepOh31lZA0NL2Y+bg7hR6UBrXvBH/qRb8VVe8Lav
         /yvfq/5zYCfRZbwePzSmAaMF6ZG6iTakkvSYEMoPQojpvFkcKqNoCFFfUT9b+ZFNwZHE
         GLM+m1C+5mYDosAaSUyuDhWCTFrWLNUyAG4w5g7WoH5YaAffZszzjDY3n1bXNrOXX4at
         7S6OioUPp6LUen0oX+PAbocDVwt59uL/Rx/eUSS9AUT+oDOD0b1rf/79FFueTqCHWLy8
         AQA0yqMMZf9df15e4GFkocP0EQUo4NEHZnOtioXJT0/JNYv807EAhT1IwrU1Nys5i5ZV
         2VIA==
X-Forwarded-Encrypted: i=1; AJvYcCUqowdocL2rjFOpgisGaJNtNXmQzyTXfNh2J7dMlKF7Y6kzaFy1HcctoF73GthDY0RNjMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohyZUBgTZ2O9k14jy0ACpiqyL4Ys4cnrF09WLo6YlAb1q0Vv4
	iQZ6E3sCQD5uomGtg4dFw0//OZ3ZP+4DYHCOivxkWYgFBTT/I+eAwSsMYIcsotjapcc=
X-Gm-Gg: AeBDiesPc2DNhm7bT4ENhWEIeV7IZhBLyyDW1wF2m+kXc9xLFxOVtthGQeZaYqRqskw
	RSdLM+9b1+tyJR/ceA3q2gC7WK3ur/ykpW2cwc2JNbTNsjxyShP7an63jUjC2w1H07snlyEj2TI
	cx80vXBs7aReyoy5VB74p9nOgWfPsEx8LVlZmbv5kbErpOAyrUzFtRYySFzEOmQbLtwxepFGiQs
	AGHVSoFBXhC8CkysjggpAlHriEfRs9u7q8pb62DvHkNgIgi910+GniGHvwb3v+/rQWgZ+bUfVBX
	djOOSVTHy5UvHwi6RJCGdhk9cOex7cB8QXsokBYw0i00buidtRLkiO8r/LJHobR+0QAa8EMZkZk
	7tlaM33lz6WdyCtyQG5lLQ5nERm3LaJC5+T+Ufy3ebhOmyR0QXaj5btDN/yvc3DzQnpBeFLngiU
	qr2C6/bgAo0cbP7VPSqo6UU/TrjOsCu22Q0bOjgaRIZPWbtzRQfBVQZXdSWTk7TkJBZGSYq0na
X-Received: by 2002:a05:600c:5397:b0:488:b8bc:6a32 with SMTP id 5b1f17b1804b1-488d68a4765mr64730165e9.23.1775850913981;
        Fri, 10 Apr 2026 12:55:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d80bafsm29702685e9.5.2026.04.10.12.55.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 15/27] stubs: Rename monitor* -> qmp* files
Date: Fri, 10 Apr 2026 21:53:09 +0200
Message-ID: <20260410195323.17937-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We use 'HMP' for Human monitor and 'QMP' for 'Machine protocol'.
These files aren't about human monitor but QMP, so rename them
for clarity using the 'qmp-' prefix instead of 'monitor-'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                      |  6 ++++++
 stubs/{monitor-arm-gic.c => qmp-arm-gic.c}       |  0
 ...nitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |  0
 stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c}   |  0
 stubs/{monitor-cpu.c => qmp-cpu.c}               |  0
 stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}     |  0
 stubs/{monitor-i386-sev.c => qmp-i386-sev.c}     |  0
 stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}     |  0
 stubs/{monitor-i386-xen.c => qmp-i386-xen.c}     |  0
 stubs/meson.build                                | 16 ++++++++--------
 10 files changed, 14 insertions(+), 8 deletions(-)
 rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
 rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
 rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
 rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
 rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
 rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
 rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
 rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index edbbd544d62..932d6aee507 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -121,6 +121,7 @@ F: include/hw/s390x/
 F: include/hw/watchdog/wdt_diag288.h
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
+F: stubs/qmp-cpu-s390x.c
 F: target/s390x/
 F: docs/system/target-s390x.rst
 F: docs/system/s390x/
@@ -496,6 +497,7 @@ M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Eric Farman <farman@linux.ibm.com>
 R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
+F: stubs/qmp-cpu-s390x-kvm.c
 F: target/s390x/kvm/
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
@@ -510,6 +512,8 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: stubs/qmp-i386-sev.c
+F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
 F: target/i386/sev*
 F: scripts/kvm/vmxcap
@@ -522,6 +526,7 @@ S: Supported
 F: include/system/kvm_xen.h
 F: target/i386/kvm/xen*
 F: hw/i386/kvm/xen*
+F: stubs/qmp-i386-xen.c
 F: tests/functional/x86_64/test_kvm_xen.py
 
 Guest CPU Cores (other accelerators)
@@ -800,6 +805,7 @@ F: include/hw/timer/a9gtimer.h
 F: include/hw/timer/arm_mptimer.h
 F: include/hw/timer/armv7m_systick.h
 F: include/hw/misc/armv7m_ras.h
+F: stubs/qmp-arm-gic.c
 F: tests/qtest/test-arm-mptimer.c
 
 Bananapi M2U
diff --git a/stubs/monitor-arm-gic.c b/stubs/qmp-arm-gic.c
similarity index 100%
rename from stubs/monitor-arm-gic.c
rename to stubs/qmp-arm-gic.c
diff --git a/stubs/monitor-cpu-s390x-kvm.c b/stubs/qmp-cpu-s390x-kvm.c
similarity index 100%
rename from stubs/monitor-cpu-s390x-kvm.c
rename to stubs/qmp-cpu-s390x-kvm.c
diff --git a/stubs/monitor-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
similarity index 100%
rename from stubs/monitor-cpu-s390x.c
rename to stubs/qmp-cpu-s390x.c
diff --git a/stubs/monitor-cpu.c b/stubs/qmp-cpu.c
similarity index 100%
rename from stubs/monitor-cpu.c
rename to stubs/qmp-cpu.c
diff --git a/stubs/monitor-i386-rtc.c b/stubs/qmp-i386-rtc.c
similarity index 100%
rename from stubs/monitor-i386-rtc.c
rename to stubs/qmp-i386-rtc.c
diff --git a/stubs/monitor-i386-sev.c b/stubs/qmp-i386-sev.c
similarity index 100%
rename from stubs/monitor-i386-sev.c
rename to stubs/qmp-i386-sev.c
diff --git a/stubs/monitor-i386-sgx.c b/stubs/qmp-i386-sgx.c
similarity index 100%
rename from stubs/monitor-i386-sgx.c
rename to stubs/qmp-i386-sgx.c
diff --git a/stubs/monitor-i386-xen.c b/stubs/qmp-i386-xen.c
similarity index 100%
rename from stubs/monitor-i386-xen.c
rename to stubs/qmp-i386-xen.c
diff --git a/stubs/meson.build b/stubs/meson.build
index 85f9e3a4f23..356d7800760 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -76,14 +76,14 @@ if have_system
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-  stub_ss.add(files('monitor-arm-gic.c'))
-  stub_ss.add(files('monitor-i386-rtc.c'))
-  stub_ss.add(files('monitor-i386-sev.c'))
-  stub_ss.add(files('monitor-i386-sgx.c'))
-  stub_ss.add(files('monitor-i386-xen.c'))
-  stub_ss.add(files('monitor-cpu.c'))
-  stub_ss.add(files('monitor-cpu-s390x.c'))
-  stub_ss.add(files('monitor-cpu-s390x-kvm.c'))
+  stub_ss.add(files('qmp-arm-gic.c'))
+  stub_ss.add(files('qmp-i386-rtc.c'))
+  stub_ss.add(files('qmp-i386-sev.c'))
+  stub_ss.add(files('qmp-i386-sgx.c'))
+  stub_ss.add(files('qmp-i386-xen.c'))
+  stub_ss.add(files('qmp-cpu.c'))
+  stub_ss.add(files('qmp-cpu-s390x.c'))
+  stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0

