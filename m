Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81004224D6
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074725; cv=none; b=Vq4C0Kfvq2wwWSUnWqFfS2XBzz6bxYZY9/VZDALNUk8tun2o9ykFQgRyb3OBQoIzlmHNR1wLd909/+VcMlvtwNPREwqnPwLLfG6dJf9p4g/Vqvf8ZlXqwdK8bCiwDF6dgWVwzALpUEElBIcFvEk6lIMjwCHnmQ/UtMDKKINIggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074725; c=relaxed/simple;
	bh=Y6DZPHVHTvDRx6ymkkZP/6CdFsDq2JjCferlt4s9aXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAnPVh/fm7E6PCEruwX7XPzaz5wDkLhWxwkSdC+WvOXdxBuFzPNXK5Lm0h3pB3091N/kaULZBOk9DbTGuOaB15ZHyrnSgoeQgAByj/2nYOfVbeVfmERJpgK/PrK6POrnT5lpXYdtnWIAPvV89tjVLgd/0RLRCPYpaEAgj/+ueWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YbrFZxvq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbrFZxvq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so1239605e9.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074723; x=1775679523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyOQuMfSmwVXZQAsXLr0uzFcWkRrczcFtO2oxCssQ7s=;
        b=YbrFZxvqyTwgHDCTOHf3wpSg8FjDLgAXB2THIG8Ka+pG3blWLyCpbRb60/9ifVoYLr
         OW5athHO2I3yssnnIXv61vWRigx7cVr1RtfBEBFfDbopF7Sk39m2odOcc+9jRNOfmVPg
         lPD89kmoxlA13Sa5vW/wkNCwAqFLN09djNH771uPrD0uTVXF5kHBjtP2bN8sGQSL9neY
         Md5c4ohO/XwxOwHOcRJXxB3TaN4ltRDzvVZDRywfPYIw8eQqObfNSzuO6kKgMkvKE1+o
         OandxpogtGrwTuv9wBdqiVvJpKiUdhEdwXnNPKir9FmB9DR5PzHCRWjqwK6a61nQ/Bzq
         uvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074723; x=1775679523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FyOQuMfSmwVXZQAsXLr0uzFcWkRrczcFtO2oxCssQ7s=;
        b=KdIPhlNLWjIWe9ReDuKeYtbDRYKREimWXbUd+fqPRN/Yx7KuAcSrSdtnjrf4yNPZtK
         PDk10ITx16i/wvGIHz9MQA+ObIi8m4t6QGimUg4mw1/wyLWMifH9PSqpLO7zVfQZCfLy
         8474ok5pIDedAj5kFr0mi2//EjCp6RVBqsNoy4VkjZiSjnmyyOjtDxayv+w8/YTzLCpe
         YMpteNkTE6NDU89CaDecwwQArfeRJWF25zu70KjUmL9qrdqdFF2X1WuGfmdev+i1uxX4
         MZp5vak0z0+eP6U7wzxUTuPe6MVeL9zf1+kUwX1LdJ4gcGtA7I6Q8V6MRfPQZtsWCKhg
         l+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVj1vv+jL5e+cHiyCCWFDsNanuXYaE9a+1qqCjDFWmXP54lsQz7K/2kFDqSCrlBNN2gX8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUM1UUNFT7v4NWZvn9BV1Lve6Yxl6vbonPeC2qWJXlGZiuV0l
	FsQ0DJDTRDy/Bve7pDZzn9Ksf9enjh8BCz5W1qgnSsptAqfsEtABmd2fiJuCCz8Vczs=
X-Gm-Gg: ATEYQzxUhmO8IpI13kQhR0p2q9e/MaC4qwvV4VQBnwlbtcQMlaitpHZRuSssUE2oSE7
	R76Z0qZoEKHLUglCx45GXlxAoSIWu2C2j2Y9x+YAdBy70TZwmIqfqPjrjfivzF+H3eQn31quZ93
	NlOj2aCXs4/8MALT5xv10nlywyeMKAhXrfT+oXC72FQr1pOZ1jjwQ9mHMHMupBGiZUEUKZOiKTR
	EOZ1dTjZ9zSjedE6DEz+jWhLG2RJ/GKba/DKgY3vSpB9MyovGRRMfqsB0IpWGgPK2h8p1AZTM4f
	XB6xFiM+oVHLpySHP1qlqtqwgnNso/7/+Nqxl1NPR/MH6sFuOBlgCfYG8bKHleOwWT6eE7+qPSY
	r/FJcIYSOKiawTH0HIKLFcq3/eZtFOPS6si0TknDAljSGjpPnSeHTCXgqsWPDcgVTICP5kazGDK
	EXPOxKGC4vZ4KalUyk9RqY7mSRc0Pe6sbAVovSYi8f2KLP5au68wq0DVJlGE7AQFC0+kVO5O4a
X-Received: by 2002:a05:600c:a30a:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-4888b7a0601mr7873765e9.28.1775074722838;
        Wed, 01 Apr 2026 13:18:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d58e5sm2930563f8f.23.2026.04.01.13.18.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:18:42 -0700 (PDT)
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
Subject: [PATCH-for-11.1 6/8] target/arm: Compile HVF as common object
Date: Wed,  1 Apr 2026 22:17:50 +0200
Message-ID: <20260401201753.92290-7-philmd@linaro.org>
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

Neither of hvf.c nor hyp_gdbstub.c use target-specific code.
Move them from arm_system_ss[] to arm_common_system_ss[] to
compile them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/meson.build | 2 +-
 target/arm/meson.build     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/meson.build b/target/arm/hvf/meson.build
index afc509a470e..ccb0d338af6 100644
--- a/target/arm/hvf/meson.build
+++ b/target/arm/hvf/meson.build
@@ -1,3 +1,3 @@
-arm_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
+arm_common_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'hvf.c',
 ))
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0e504a403..f14debc6a2f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -20,7 +20,6 @@ arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
-arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
@@ -41,6 +40,7 @@ arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+arm_common_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
 arm_common_system_ss.add(files(
-- 
2.53.0

