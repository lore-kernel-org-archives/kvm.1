Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D7364933
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074741; cv=none; b=RAEcpJwZ3pe4rcJpRsRX0hH5gbySFLR07MR8HI42OXIO0oRVc5u7M3JQcck0ZUyTGB11kfrde2rcFk5KKohRk4w0SyAePeBDgfdnTlccdhi24qRtyiiW2mbRFtyNUBLwTEGRvwWlNoVwBfRZkuIOgoYSFFfpTQi8mgyggOoJtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074741; c=relaxed/simple;
	bh=LR+WaHUNqHICXFWHBlG5H0pex/rIWUOGmQuLickVsJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG6ALGgU4WJgPdbr+n1m1c9r61RCCJJBwm6WdfCZuDhPcjKTf542ZyHkDT/C2AqSJOYVkGQ6ONc3xr8yhabDxMAVqi5uC9JLvCHhKcm1YHw6Hjl5QAUMktyXbsUvzA1fLbKdbGVwegRc5IqEn8bA2rLEhWSHAI0uGSsJaWALY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hiS/grjk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiS/grjk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso956375e9.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074738; x=1775679538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb+zd90ZS/Btq5gwYIJLAyNUgmi4p8lYTj1rYDPe6wE=;
        b=hiS/grjk/0HlOkPv5LYWxBbbxuQWiZilUO3tBvnd0USjQPI7JnBowRogQQbTonsx55
         LiIR2nQe28yshw976pixjeo4IHDkbAhX+FaZOJjjRMRl3qq0qdRGm6VRt+PpPV3N/NRW
         I1cvFI7CGJvFgXYd7YxzWG8XwqtlyRgkUODHYp0WOOPG1Sn/IqvlnPA+kZd+n1PpUPtW
         46euVZReR6YfcgPueefA7az/c4rdYGPOPDKULuLCPMrbyxmrnYuEhKdTnn81+Ufovdia
         KfPKPsIdZgH5Gx2Gh6V45JFmx+0zD0RiC3/fAwo5VtCLzc6Eo+YtMhWvrbAQZZ5USfpX
         QejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074738; x=1775679538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qb+zd90ZS/Btq5gwYIJLAyNUgmi4p8lYTj1rYDPe6wE=;
        b=hfczZSoi75+Q3bugXHMOSRRmDgUkwZgt7IGEmp+kLVouWxetQ/KupzuJU10K39hymk
         m6ZWDjUM6hmtJE4q20LzYIR4xdTX6KwnJE/ieJXS9c0Rftsh6MV6CygDQkvqc+xzJuOa
         C/VLhlrnwq1z55pjdAnpTdzPoNJYeY7WPXQueYv6xV/ktVwdpjD37O7l3dA7s/uUS0Rl
         3zQ9+azQonzUufSpQcd9MdywO+1nf4DmK4T/HaacFbNjlZN8e2ifa0nV2X9adRoilZ57
         3DdxpdJVyGbToNZZvkPNwn2IHkczNNOSe41c/7+JN1ZKSPL5WFRF2S/Pae66KFank/bQ
         VCWw==
X-Forwarded-Encrypted: i=1; AJvYcCXszMmh8r/fvlmpajz+gz+tq8qklYni1xl/8CZZan/x0IqaZuxEE/sjWyNP7K6szHz2smk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVCOnp7mBGrDOV57nLZOuh4F/Tf/w3vHCC8UYtHSOowr/xwFTF
	oHRL2bAbLYZW8pVdsyFNpdNJrQnPpZOSniir0D8uN5MoVzeCK2dknzMefOrIH5oSVTWHeqikuV4
	uNd2ZCyw=
X-Gm-Gg: ATEYQzw4JeHeuzzGfz6uePCGGJ9mqMuKkSSuQ/B41iaR0Ry4ccL8HBFTU1sBS+RF+sb
	rDhvw1Olrcnex8aJMsJxcvhK7AHj+qoax8JbiNxIFSCerkXHb/eSjOcZtE0aO76CHVUwoXDl81L
	tVyZ+Q9dWfyNcUx4wKbUFt2p2nudLkDmLAICVUlUCWr8+v+RsQWsDkeICuNUvkfXUTe3MiqQAxO
	KpQtRpuRv7ctt6bFRl+FUeEArNeI7ZzFruuUMuXpbNKXK0h3VgPOXHGiuQvAHJId6Rg8XwQa3IZ
	wjwD0QA7bn4ff2W0BTCoBy6UySmXN47zslMwZUDtFAEUphi9JtPKQXxqQvGbtK+Af+HJiq932FQ
	q0N/QwpEWaa8/UvuckItoyad+YjEPapO1+N4eP01WeFAbd5XUiKlsIfD2jcS8xJYjMGDO2jnDQJ
	0rzMSzwr6iu54v5HIrp/2DheCxgl3VMGpr707yyZlLhXGv77NqBp2Yzp4HaHfrvaTCP8Z1cSUl
X-Received: by 2002:a05:600c:4707:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-48883597cfamr88074825e9.17.1775074738181;
        Wed, 01 Apr 2026 13:18:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c963sm20790425e9.4.2026.04.01.13.18.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:18:57 -0700 (PDT)
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
Subject: [PATCH-for-11.1 8/8] target/arm: Compile KVM as common object
Date: Wed,  1 Apr 2026 22:17:52 +0200
Message-ID: <20260401201753.92290-9-philmd@linaro.org>
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

