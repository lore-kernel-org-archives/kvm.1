Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32630FC26
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149539; cv=none; b=Q3XMWRTgKL7Ol/owVxwbWlUAVOiubyDC7ShuRjjILpUuCwnk3wMA2R9Tg5/30vylWu1B4M7BVOYOIjHGMeTG2aQyGTRko2gRrJz9T2vvdN3jxbfvUCmmDTj9WBM3E4b0nOWtxjvxxJuwi2CNTu1osvawPCiAIfWxNMJEa+VnMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149539; c=relaxed/simple;
	bh=Y6DZPHVHTvDRx6ymkkZP/6CdFsDq2JjCferlt4s9aXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxyT/mxVnD2yeAM0MVOpOr5Mf+2uOAAidfYvsihHyRh302cc3aisCl5OdmzlNeUKuWb2G6ReMhfEGpssltEdf4eASMAfeJQz/u5JeG4w1FuFUdRG/GA1HIj3/HkJL6B96Qje8pCzFZKhOA4Gl55u18qFY9iLMCpuODUbrhQ9kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYh4S6Yg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYh4S6Yg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so10413865e9.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149529; x=1775754329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyOQuMfSmwVXZQAsXLr0uzFcWkRrczcFtO2oxCssQ7s=;
        b=RYh4S6Yg5+j1FIUV53Qkg+1iB7sy2o+pvMyRWcvBz5Hbp8pc4iZuAl1QD6P7rwZz+B
         i9rgdUE3JcGg7FEJ96Jr3GRypJPtHZOJ1XH6W5RI7tvuX/zRk6lMg+ZkR8xZVDuzGT8W
         tv//ZqWocAL4ik8orucErcuSULQI7/vgN4P2kHuTLY8kdGvzn31OdRVgtwDH/KYyNna/
         OEVb6Qbb4PIiNqV54NKAjh1Wsl8UulPv8ofsOpLTYkQ6sUSumKI5m3Di20H+kC2XID8e
         7gQCsSlFNNqXrtVfRf05lzCGpdForixehT74E3wDJUU6XtugQO1f1Mqw80yWdAcp8XW6
         NR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149529; x=1775754329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FyOQuMfSmwVXZQAsXLr0uzFcWkRrczcFtO2oxCssQ7s=;
        b=Tn3RA66v77YncrGaU7L84hjX16gjN+Yak1DMD95b+8HoKc2IZVxh7CRliG6iqlLefT
         y1gg2MpakZztjAcUvysvcz5jfkoqaSPeXaemcnhHaMSDj56wFHS1e+4UA08buGv8rZa2
         UwlKNKQjrQ8+/BObZxmbNFw9qP3dGlmRMhcE4S12+ufgdsQ/kctlA5yjHuu+nCgIEJJX
         RnDMm/yzcIYH7NlT3iPv9wEyTnbI8TgsY14HmCGOlR6Y5p7flglIeceAz0SKFpEdggZ2
         xkBNBBSmXi7loG2xRJz0h7mL6ckcRo+HNp5H4VgBvI0SOE5h9DnBFxFk8Td8+x6W4fZk
         a58g==
X-Gm-Message-State: AOJu0YxMezD1P4e77p8AbOPKRnycKd+LHgY7NBTHHUdgSTok72uXeXac
	bqnnkr0INBVgRIYeMrpqzqvWFz99JWMtwEewGRzmia4zOQixHKxtPE7+03+3McmcGGY=
X-Gm-Gg: ATEYQzzqKeKWSJqW8kGOO3UnlXKjgazu4BjSCjqzZQeUvVH+nfRrskwwem0OAn81JU8
	EDeF7pXU1Ynot1jmjx8W9g8X+VxT7d69tsIX3xybyoQwgNcphsaDo3oLBIQkoruVYvb8Y/UvzA/
	Rzc7+KGh1w+Px35c8ZBednkIRp51OLKlxFooYY9IJSZUYBPWs+K2Yv3Ul3BKJ1mocHMLONp1age
	OoD16IJiVDJ9Q3mWXyoh6FGPRwhK6G1ar1h9VwZ8tOfbKwdZufmQFGJNV8abHLZzHHnmSfCNdXo
	E8zzJkILS/qpkC6jDnWYeDnY+98ZWcE0byWJAETas2xx9ki+Lz+OSSeFB2/IeiOyXFEoV5boD8P
	9VvKLnmx6kLv5mUGNtolrDRk5QvEJWEUp3HNoxsW0FTlUEHOmghyeZC/OR5ML1pfGJ2pJU18HqH
	AOf5wymKRPm3BhkZQD+J7vxHgpt5/qU/lBh4Ir5i1yzE0O8HEG78pvRGU3rLXiEUqTAwZJ4oET
X-Received: by 2002:a05:600c:8708:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-4888b6d502fmr71864155e9.4.1775149528976;
        Thu, 02 Apr 2026 10:05:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm9461416f8f.27.2026.04.02.10.05.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:05:28 -0700 (PDT)
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Alexander Graf <agraf@csgraf.de>
Subject: [PATCH-for-11.1 v2 7/9] target/arm: Compile HVF as common object
Date: Thu,  2 Apr 2026 19:04:32 +0200
Message-ID: <20260402170434.94783-8-philmd@linaro.org>
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

