Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EF3F0772
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149552; cv=none; b=nkl9aFFu4rI2tFye4ypPzjYr4bWxO+Zim+YkrPP974vH9xt+XNfajA1BqHIXbpdfnPazCf8zL2E3LfXIzcRZsCLQp6SkKC98+RtEzBX1D8Bw2OYLta/5Z3gUfaWLFtiZRW5KcWiPlrnDvJ6htQbMuDB9pj7Zl0Cdqbz54KPPvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149552; c=relaxed/simple;
	bh=LR+WaHUNqHICXFWHBlG5H0pex/rIWUOGmQuLickVsJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOznfZmOSKti+eXfIoLvFvl13z9HsUIBmbXAPiAoNA5EdXpiVa0aKEzuwJN4neRZEo0xwUrvnEWZ1Sjtu+tp+rE3NQWZEanEljuM12CBZbHlmmeGuA6q4OXxDCwE6xSaHXnwJufMxjh9wbYTnodEcX8iuPAWR1AwhA4VEaX6nOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dXbypnyF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXbypnyF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fb14227cso15019075e9.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149543; x=1775754343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb+zd90ZS/Btq5gwYIJLAyNUgmi4p8lYTj1rYDPe6wE=;
        b=dXbypnyFNKwilo1HtIUUUT6Z3uL+VidPO2augiS+3w1dGsxt7d0MtoQYGGX7rLJocO
         bpubWqlX8zrUkhwTMg0OXULSa8hH9PiO9PRtKWy7XaC+TyQ52M/HqCzHaYXreDRYpkov
         tE5+5n7nJdAo/8op0rNjjHpLioyVzh8XPd+S0CT+sr/agZHUJXYqq4QjvW5aR1KIIbWH
         Ou5aT6O4PMBFsZ24lbiXuThXjbBHxTNCHsHD1Ody9560Emxk+bFEWCSYKqgHtJ0+SnBt
         z3qggJxdFtilDsmGAFEKCIyJu81kR5e328M/AlWC31wFt95I6tmYI43mvEQtQKbcYEtY
         P2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149543; x=1775754343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qb+zd90ZS/Btq5gwYIJLAyNUgmi4p8lYTj1rYDPe6wE=;
        b=N1k+XpvOayAtrjo8B5N9vmJLlaLA87cKLisGKUfyT3RPfmieW4Krtz3Audc/wEWcaa
         lIBb6GUueU5lFnZv1dHRxxcRNDCGNPMU/XZNwIvRoiB3rt8T+Pdwjg+PUv9Ln4qfU42U
         h2ntSESq8bYuALyLGrR/wCh+WpDkfpdHGcV1XFNFB6AZtdV8nO9r548FwWsssHLkXkx/
         AoidPFRnKM1U8v6rqZKIyGeaULO4KSzQQFltn02hG2yKnJUU2dWnGlmoEo+NtD5k7UBm
         sEvCl6Pe0v61kWNGtFTPLzNBteQXNrNt8m7RVZLgxqawSCze9ow2ynGn9nn1wxMrrNvG
         elNg==
X-Gm-Message-State: AOJu0Yw5Jv26HhJvsgBRu1en6N3v32rACLqnNBN61eKVVdWEsk0OjdPJ
	5jKUcQY9WKS1QWrGKhl/G650Z0Fw3ZOnOL/PqTzidMXDMXtj6u4nud2oIMIPbCMIP6w=
X-Gm-Gg: ATEYQzw/tUIZNTrAHgC4kYp1ZHXnszpdr5SZscdsEy/mvyQ8wprUeScb7/FA2wScsIr
	b7r7eM58VLMTdwXDUyL3r2b8jwFxrs3T7C3eRfU2gb34u26LgYk3cxiOQAO3+3yQQ1uZGo06vhC
	qK9Vi1REVFYg3UErjkjW8tHzwMS87h2fjaOxsKHC/23zcaGUXLrMBWAeJeTu1NPTnBhEkL2mpaq
	OdIe80MrGPERn5d3XldItts42PZn6M0CcbdEa73EKeao400nMN810f5IPc+PBSCbVVXLRFDJs1l
	scuCUiiwi4WP/GzVudvfkwqugavBCpYF7h2eH54vyQ+aZ2+RGqontJEX18pa5WoWafCh/ZhlgHy
	ear5H/sOEb6B28tpYL1wuzFg9NV/Yw2GvHUKfhO6rGP78utt1/DwuWYJUm2eYn0q4WABmyODlS4
	0Pd5pA9Vq3TtyA5K9+OcBE6XljBfOiWa5LSAU8h20J+43geS+pWHBYFjJuxmPuOCVMf5NN3Wny
X-Received: by 2002:a05:600c:3508:b0:488:95d0:ee46 with SMTP id 5b1f17b1804b1-48895d0ef40mr23033475e9.19.1775149543086;
        Thu, 02 Apr 2026 10:05:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c963sm82675175e9.4.2026.04.02.10.05.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:05:42 -0700 (PDT)
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
Subject: [PATCH-for-11.1 v2 9/9] target/arm: Compile KVM as common object
Date: Thu,  2 Apr 2026 19:04:34 +0200
Message-ID: <20260402170434.94783-10-philmd@linaro.org>
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

Neither of kvm.c nor hyp_gdbstub.c use target-specific code.
Move them from arm_system_ss[] to arm_common_system_ss[] to
compile them once. The arm_system_ss[] source set ends up
unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/meson.build | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index f14debc6a2f..1b5d346d474 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
-arm_system_ss = ss.source_set()
 arm_user_ss = ss.source_set()
 
 arm_common_system_ss.add(files('gdbstub.c'))
@@ -19,7 +18,6 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
@@ -39,7 +37,12 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
-arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+arm_common_system_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'kvm.c',
+  'hyp_gdbstub.c',
+), if_false: files(
+  'kvm-stub.c',
+))
 arm_common_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
@@ -67,7 +70,6 @@ else
 endif
 
 target_arch += {'arm': arm_ss}
-target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
 target_common_arch += {'arm': arm_common_ss}
 target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.53.0

