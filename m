Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8E472067
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450043; cv=none; b=MoxhSk9G7q6GFwQuNKPuSPHBgpuJYKFNooarqL9/J0NU0kHc+fECaY1ZkSRaL9OXUvIIX2g/HOEOmx3nKimSFI3Yccm8LHwSeE0EmGOsHj0W+3K/dA6dd3kv3UG7Wq9Z/lY6Chlsu1/9xnua5us+OwdKek8oNJSRqE+FQ4+XWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450043; c=relaxed/simple;
	bh=YFdzv4bC6T//YXOgTaR7n/dAXYJHwLQjaao19n/PsmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUoVlK48lWOWH002TDPZEEzfB/YpZ7lQf5V+ZdVs/pOk5lLINXWrVX/XuIk5RTWDU+Yx7r5N4Dd+YclcSsahbLzlQKg166aZsUutTYDLAXI2kxgZTa5t5f9xOH6+soE03XuHqfhwQHVvQywOA5dFPuoTomypCw2qt6SJ69jAzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXQedEwt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXQedEwt"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ccca948203aso1583978a12.3
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791450042; x=1792054842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHcBfPni8x8Tv4oXNYjFpY3Q1SA1ZNCrWr9wjL7gtu4=;
        b=WXQedEwtE/X1o5WbZ6W2EDeJsk9acXzrNMZQ2QIKS1vJ3qs5O1H4xniYnw1l/5YV2X
         YhJ5KSL7gYOCqcdhkWWgsDDxXx6SUayvV7irzEs7Jm5jPcy3MGJNTirSPRWTKxcoigAP
         +jeMRfhPPIXwWv8PBBNKXEjY9v6rxsdjMzvNF2ecicJw15xRq0wRLegZWQIXJMiD0WYs
         Sv2MzI4bmZI/GgKAq9SVRO3Gok82QNVpvoRon/RUctVm8ie04IcBQpGyaTbOU3rZMttY
         hvMulH0a2+mFrZhsL1fbH8KC30mRi9Qv3jHCm/JczkE9rVrtudnZSsRN4Sl6WDFRATzi
         Kt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791450042; x=1792054842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHcBfPni8x8Tv4oXNYjFpY3Q1SA1ZNCrWr9wjL7gtu4=;
        b=LMPqI7kaoAMMp7cGkwbme2pHhtoE2+SDXRs8QxORa6PI2bxwCswB2KHjZty5ljWddM
         P33+z5Cr1utiWPvF28pp4AF/kSuOvMUBQ4QI+nLcC6KDb1u467awxI395AiN4mFMU/2/
         WVLSfqiW/h098AkvaePXcejVL5i6+ESaJDv46jHNQtPw3KDTLs5/AVpqc8bOvPiAAEx1
         RIstHGZGOBVqO2MuXy8HEAd6j2Q6zzwSB/T/BfVExQuFZvEErkufD0r2MktQ42zFNi+7
         MPFFMYaou4fbGrgEIhOxSuwROl6zzp5gScYUQ5ySaXZ0wBCLefBPOhlxcmDflbJrCwXl
         je8Q==
X-Gm-Message-State: AFq9FYI/XNmKN2B9WuOYv1D3nTnTvUyHWHjcKL7OmbWrTIrKDOrkcLEJ
	TuOz9zSlSvq5xToYHNh3gavuzROOlV/fxnhzELeb5l/kD+3ikEOk7UMp
X-Gm-Gg: AYBFou0ldi5inVFbqA3QHkAFotruWMmJjvfbzS9NENEhSKPuhufsqZ4ryoUlBheaZ6M
	mlivMZMWGJZU5fo4IeWOHQqBvJdI6jftzAPN+Gd2bQU+RSgBY0irNOWXrwY2YRIJMqeKJPZU3d7
	v45iRwulcVoZhiDFukqpaD+Niwyb1coOdPMHb4uxvYcStW6VEaqFFnlpCLS9X/laCQl5TrwYlw6
	dfuvVqKuGnHNW/FynwRM7y7IgfyZfGZvwdedye5n0cYrlZzqpxTsT1heyDiXSUt/v2Vr0Y4c4b5
	p3kHnnW5bP/c6dCXLlKZQiI1/FkkKLIdwJ3+hXQgnYb15x/YROJBVGIDgh9inRJbCq6DYN1NI6B
	w1wRZTAwL5CYwMvnltkfk+5C5OQc65vCroID+0pOyQYDNDg/mmXH1i8fD+zpfDfgL+D6r7TISHJ
	mNQqvkJJP6OOGMll3u1eIZhQxekQdFwmf3ypVePP3mGj7z/hCP8zHWkblit5th4efv2G3oSs20S
	AS2sx3EwXfQN1gBqGjjfbJM1yBj9Ub3ikfnLt8oAA==
X-Received: by 2002:a17:90b:3909:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3a8a0e10db5mr4140869a91.41.1791450041426;
        Thu, 08 Oct 2026 02:00:41 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff5aeef0sm3525661a91.14.2026.10.08.02.00.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:00:40 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: Guard against division by zero in adjust_lapic_timer_advance()
Date: Thu,  8 Oct 2026 17:00:37 +0800
Message-ID: <20261008090037.86931-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TSC calibration fails and userspace never programs a tsc khz,
vcpu->arch.virtual_tsc_khz stays zero, but the lapic timer's
software-mode expiry path still calls adjust_lapic_timer_advance()
unconditionally on every timer expiration (unlike
__wait_lapic_expire(), this path is not gated on tsc_scaling_ratio).
Both the "too early" and "too late" branches do_div() by
virtual_tsc_khz, so a zero khz crashes the host with #DE as soon as
the timer advance drifts outside the adjust window.

Bail out before either division.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/x86/kvm/lapic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 13e32c4915e2..4dcbc66c8e07 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1991,6 +1991,9 @@ static inline void adjust_lapic_timer_advance(struct kvm_vcpu *vcpu,
 	    abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_MIN)
 		return;
 
+	if (unlikely(!vcpu->arch.virtual_tsc_khz))
+		return;
+
 	/* too early */
 	if (advance_expire_delta < 0) {
 		ns = -advance_expire_delta * 1000000ULL;
-- 
2.43.7

