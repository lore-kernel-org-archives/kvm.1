Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335095;
	b=i92hiJ2NstKoXGFZ41mNC77O97FOgsFhGsvqs2OnlsiVNRMFGfqoySt4h9Atbc+EIV0e
	 y3NZ8P/36lZrIm6Oqeg1XwPOF8+YAKx6NUen2DLn+RDA4QbUupUf4AWlxXC3zETJtUkIJ
	 WfZO5yq2onH0SZxM9D2+BIn/e3SbS2Le9fkShnM3x0ghVqG83VzPZLXMpkIW4u0y03o/n
	 KZ6TSDvYxQTY9PsBypEjFtbhQINu8dL5c0kx1P2ctFTrgolUAB6tMVaJH8qyjz3lsAZH7
	 qB2CHBgYnBWJ6iuU+pJbWQ37wi3HxzAcnmJdcShuZyQ6rKOPHeGqhy6rnrFwzH2NLlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/AzQ3iEnBkIpUey4zE38dc1wM4bd0UL/nvGwuL/D3Nc=;
	b=tGIhCtmnOCk9z01bddXZ6L9gdzo2R8a6uZzQkYiFAg9O7dG09LzO+g2LCqufoFV5JnVY
	 eVAwNUm/RFmUOXbDni5bEttlgbmHAqnAVy90m+7X1duRvNoNjgyfTsdFpLJ4mJ6+JroxZ
	 4IvjiKl1wnByYIRAIxNg9KU6zG1Ps8CUwBjQPbqE2QmVVJXp5Rj2vEeYNNnyt/EIO8kYH
	 VdAxJSjpYeAscMXzmgK+bVM/TIynjB4VxdIqj54EkXWMtbgW7jNy6E/JZcTFQ7aVDiE9O
	 veiDQ8o4xxAOAz0rICUkJJWE3Ufhy3qf+RtaBVTKrAKJ4r5KH/an3qCi2TEbfo2azDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lxaoF5VK;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FE606A320
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 18:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946FE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lxaoF5VK
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b1755b2f26so380363a91.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335094; x=1794939894; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/AzQ3iEnBkIpUey4zE38dc1wM4bd0UL/nvGwuL/D3Nc=;
        b=lxaoF5VKo9somEPgbUSrZDshbrgLOnCySSz8D0IIENa9qcrBnNSGlYEwCCZQhJdRYr
         exZzuh7uf3ifiTCnhoyw7xUeSdrzdW/TSYhyM8bcJc2r0NBYNw8FgK80iEyLvFnlJ+H0
         UeupZy/j2R3OR+p0/laUaxf0qla9taOGTUDJACW1myRtp5OKzYS438cUIux/L66Y+xrY
         YO/546Hg3EhGYoPZU6NVgsdgUurI3eJ3S/hwMqe4O6kR4vIki9AYkvU0hfyn49ePVPFR
         Zqcjj2jHjFGj4QcQ7x3GadlhHcZEHJvi5mzTm/eLAt6wep9jOZEFRl/9lLJEr2Ai4cCN
         k34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335094; x=1794939894;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/AzQ3iEnBkIpUey4zE38dc1wM4bd0UL/nvGwuL/D3Nc=;
        b=pGLEHlTmxLEmLc14eLaJ8edHiSHOdSomh5WBWop2dIVlK9ZhpSEbx9yvaTiKf5Mtv/
         kO0ODZtexX74n36E2RaH2G931uzfCBGOcX48+1ZRBOasy58UDGjSxWjkYdK1lMARGxAb
         3sorozuwEeeCkw1berTYYbF9A8ByP9bfug/ueDf6SpjsCwOA5R3TatDaoyMHpewnDvmd
         2+UXPymp78Vx0M1hfqPBuG0hraeD/c64VF1XWjYoXkhNHPbjJQcgk+YrX1Q++tu0gqUa
         s4mlKLt3GegqFP5AU7EnEW0nwsdH8fIu77SsxcCyZzDtmQjXBuChoZq59mjMjBQZ0kX3
         /kMw==
X-Gm-Message-State: APuU4Z/JMRoS9/i8spptKQDjqVyP9/ckDjTcPLRicD4pGzQ0Lw3ivK/N
	YXX23je36Ak2s26lGNiw46lPMUshAB1g52F9UK55xLDOPVGLg974ulsSfJsS3XKSVqUZp/Zzj9D
	HVwoPhg==
X-Received: from pjyt9.prod.google.com ([2002:a17:90a:e509:b0:3b1:39e6:9f6c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b85:b0:3b0:9e2c:9b5f
 with SMTP id 98e67ed59e1d1-3b166aef956mr3468515a91.2.1794335093699; Tue, 10
 Nov 2026 10:24:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Nov 2026 10:24:51 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110182451.44207-1-seanjc@google.com>
Subject: [PATCH v2] KVM: selftests: Undef musl's PAGE_SIZE on x86 to avoid
 type differences
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aqib Faruqui <aqibaf@amazon.com>, Hisam Mehboob <hisamshar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Before defining PAGE_SIZE in x86's processor.h, explicitly include the
system's limits.h and #undef PAGE_SIZE to workaround a conflict when using
musl where musl defines PAGE_SIZE as a signed 32-bit value, but KVM expects
it to be (and effectively requires it to be) an unsigned 64-bit value.

Reported-by: Aqib Faruqui <aqibaf@amazon.com>
Link: https://lore.kernel.org/kvm/aL8e0MMa4U2-nstQ@google.com
Cc: Hisam Mehboob <hisamshar@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2:
 - Limit the hackery to KVM x86 selftests.
 - Ensure limits.h is included before PAGE_SIZE can get defined by processor.h

v1: https://lore.kernel.org/all/20260507234854.273536-2-hisamshar@gmail.com

 tools/testing/selftests/kvm/include/x86/processor.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..65fda03ea893 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -6,6 +6,14 @@
 #ifndef SELFTEST_KVM_PROCESSOR_H
 #define SELFTEST_KVM_PROCESSOR_H
 
+/*
+ * Explicitly include the system's limit.h and undefine PAGE_SIZE to workaround
+ * an incompatibility where musl defines PAGE_SIZE as a signed integer, whereas
+ * KVM selftests expect it to be a 64-bit unsigned value.
+ */
+#include <limits.h>
+#undef PAGE_SIZE
+
 #include <assert.h>
 #include <stdint.h>
 #include <syscall.h>

base-commit: cf7fa575900051e489f95944c65f432ea706ed73
-- 
2.56.0.542.g3ef89b7020-goog

