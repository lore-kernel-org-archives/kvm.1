Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475D363C47
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149548; cv=none; b=egIEr4k3ZM/UrbEFEjxVUURfmSA7Punb6+r9zi8UHvaMc8Iz4Uyw2k+pnf7BP7lDq3dsjSBHJy92CTiOR2ILzoHB2XJip20AWFfBDm+QwL6iIdtyxSDk1U0RB9pzw2wCBN8zOzPX5VkLAKsbMxpiE0f0FLc3GYKy4p4IXjsAYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149548; c=relaxed/simple;
	bh=9VFy0p7UYgj043fYw5lCybsHPTatFfiX9bf3LPCgpos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXyTjeflVtZph1ouV0aJf/L4k+lxfSYgAg42eReuO0d1A5PToo3OGHiDjKQh6HjYrE2zGJaOFTQ1PCsHhUPv6x0F6YtBgb7bjfqcMt0PezaVa6CHDp6071Q0gRK6NISaBCe5d+wSbplwyLh2fctkN+pLzG1MRBwH2Yc5VnvHFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xzVz+/xy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzVz+/xy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486ff201041so11258565e9.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149537; x=1775754337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRPUYAczpQfrNB7NESGbjTZhQXyZHZILb2QpR9Q7LQM=;
        b=xzVz+/xyxIGF+P8Cb66HjBx8u2xCsUH/+ULiQwm0nffryd5SPkbvQyq3EC235fKBGF
         c3W4+4FknHJhSmmi1dIU14N6YHDu3kyWDmw3rzoX2QxFmrI1+Tbz+WAW0RFOqwopl8Xc
         7C0puoeUZKhHWQS8RFLrZlWm7YGib4WDQi9jfawFmDd0OogIBc69LR4301olsMWAF5n9
         xfKcvc3WvNFAz7eDWRfMOUStWC7YddHxMmU3ft7zvzQzKikzMAPORcnhUDF4czGiLz67
         zfJNTHl844wa81SOaY/xFx/AS2/HAGIb9waeVm7jBsysyDYXmHc0ci0QHzWRpFzrfK4v
         wN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149537; x=1775754337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRPUYAczpQfrNB7NESGbjTZhQXyZHZILb2QpR9Q7LQM=;
        b=Iv8sFzSw5NxU29zPQVxi3dhJ3q3aQr7vpgc/obY6pB9NPvfX7Rfiki9P2UOpo3BQU5
         2XvvCkYCeR3kS6mhY6t6lez1CP+EGPCTvx4UkyTiSMbRFlxkUJASL9hviMAYQfDY7Bji
         skfMlsjlErJ5rbnv5axIXShOz7F/qBs7ICldDWknWX6+RWzvJ6VY7rj6ntbePwWrlg4z
         aktlIb9Knr5i/dJw1qSmGAnXqLZcAHUE2dvSObGWxTTXYDmDGTSP/3QoBx8+UvvEikQA
         wHwLHmHLDlkx9BE/n2eQoKwdOuOsbKXhhmOG1NtV2G/ccfcWglggzHHAJswQPzXYFGBJ
         dnww==
X-Gm-Message-State: AOJu0YyFI6NZOFJ9jU8U5YS5gNMoVIUJrC9ObubqqqQI8jjrY6Eg8OYN
	OoSecW4mNaxjPCxdDRcMHHFQr464ufZ8JZxDfrGDMDazSmO/OHncHDIVKIMfk7MqFr0=
X-Gm-Gg: ATEYQzxhb5ORPYLApdePTc8tqlCqVrpximGvymaxAg0qZ8w2HZuxk96wgF66Z9/P/fS
	moXkoeD3Av3vVwvFon9fpc3nN+0ERsQ5eyFR9H/5Yr03pqAUJG5ATjjUqy4aQ87FMGFkWvtLcLg
	+L2TM3sgln0BbH812mv85/Ai+3tvVlvX9emoWmcW7oGp9yuYo6Cngpod2zd+WTUl4TS2Ks/Kjzz
	0R2CmhtBhUEg8Ug6cWsx0lbjRKgcbWVXVXxPIp1q0hLyMeZo9l/3/fqZXZZxg+/CbVUqoBso6tY
	J7TYjzqx6+JftesEZKTMrGw2UVQTt6cqaEQ/+kn1SEKw85QHO0Kz5F8ESTx5RRfUDB04Yeci1AJ
	Trr7osm3QSzxzzVXBDlYu+QVf1INxMLyijuEhKgyVTaUJAMA290pzud/O6PC9M7RPGzTt0FmqpA
	BDCedupY/14K0jxyNVwb76fSjFLGXrgWdqLqVBM9HdRvqjtDW+jVkoY67U3RxJ8+SgHUgwlx3o0
	jNWXIIyvwQ=
X-Received: by 2002:a05:600c:310a:b0:485:3d3e:167b with SMTP id 5b1f17b1804b1-4888b6d4a4fmr70694155e9.5.1775149535919;
        Thu, 02 Apr 2026 10:05:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a705ebdsm94510025e9.10.2026.04.02.10.05.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:05:35 -0700 (PDT)
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
Subject: [PATCH-for-11.1 v2 8/9] target/arm: Remove target_ulong cast in kvm_arm_handle_dabt_nisv()
Date: Thu,  2 Apr 2026 19:04:33 +0200
Message-ID: <20260402170434.94783-9-philmd@linaro.org>
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

kvm_arm_handle_dabt_nisv() uses a uint64_t type for its @fault_ipa
argument since its introduction in commit 694bcaa81f4 ("target/arm:
kvm: Handle DABT with no valid ISS"). Use the proper format and
remove the pointless cast.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b88..c09dc4cb3dc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1453,8 +1453,7 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
         }
     } else {
         error_report("Data abort exception triggered by guest memory access "
-                     "at physical address: 0x"  TARGET_FMT_lx,
-                     (target_ulong)fault_ipa);
+                     "at physical address: 0x%08"  PRIx64, fault_ipa);
         error_printf("KVM unable to emulate faulting instruction.\n");
     }
     return -1;
-- 
2.53.0

