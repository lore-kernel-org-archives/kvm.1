Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114350;
	b=HZwezaBoXm9Mfwu0gtYRg3/KnvodP4UYVTVxkgkvjXvyUXaF/4JQlvE+rX7LED1Gsxmp
	 4ub9EH/VuIZNrFJE4C3c8p5FEfkJ4XlSEwrZ3iJXIFI6uIoAI2ohLyPfnM6NEtUBoW4IC
	 WL4gSFsTaPUhgAObuR2E07JwCl9/SohNWQnMovLK0vQMo50aAfHyxWFUZoz0x71XoQbkC
	 tQLvvVd+w8pl5gOCjtm9kejyl0cH39MXKJGPaWV81WKF0hF/vXdqXDLxYpPF7mFTmRebf
	 ZMs6s+aRBJIvg8IFiabAOA4uf8naZaMl8T1vTyZqKUqJ346uWMDndKVE4aW38rXYTbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Dri93dGf86JD2a4x55noboCN1Q6q179kTQsK767li90=;
	b=hnGIGD0an8EG+qKBNvfwm0lg81ae61/vL5A3xhDg0r6jbZIJbNAUAHlAU/OuIN2MC+nQ
	 2v3DQLzsdUzTC2RFAypotQTbnUvYaC08iPyhnRoRpOApJQkTvs9+YFngWe202XoVmeAaM
	 fCM4VDrX5qOk0g0jcGGDNXwFolBWZZX6WJLEycq5EBQTCEzDCFni0p5AmBvm9N8mlSg2S
	 eOi8gUojUwgQyLLWfzKCzflE8ewJ++vhJSBj+ZSDkbFaU/LWlyvoJ2jaNv/z2rNK8fvHF
	 /UwI8zHlSlpG0UbZVVQLqQ57kF8UMiqroYo56t0qYX2+/GrtzQkoU9FiAmdp3Guf35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=istjwH1u;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955A606B53B
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B955A606B53B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=istjwH1u
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-5735cd94235so171456b6e.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114349; x=1795719149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dri93dGf86JD2a4x55noboCN1Q6q179kTQsK767li90=;
        b=istjwH1uDtIuP/hVh9STL+elAXD+Md4rxfVCQ5xDwA4uMSRilEvwlspwj8AzFZeLdl
         G978XmYe0mQRFfhlnOesU+fCAzp+QZ3FO9/PewFgKIz1u1WKgYh7WPG8Vjf0gOttzYoD
         NBOF9g4VbnMqKLPK7GeFgLN9SJowLI+oCYGaW9vZGYsamZJH0tvKRhELL20EhHTTZ6Pc
         h4jrX5sBM74Elcyi9TsU3tNcTnpEsGxL0RYYJW0Lipzyyr4LJQWztXNR3ezqYZ96degl
         Ylt/s++522lJwdrDmW3ytIGAfl8gqmzBVNsp+CoIDdQCovlZBn3Pd/BEmvcOEk+j0M3E
         6TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114349; x=1795719149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dri93dGf86JD2a4x55noboCN1Q6q179kTQsK767li90=;
        b=nS98FFkN7ByTU+NNIFmLJPIBoKW4gMVodej9DFBIn4AEZOAsusQYCndrueJj3AVsCi
         y+54LMClf6c5OL1y1h0b+TlZBDcQLOGGkKgyaMaZ4uaCZs/SF/sa8No3jSYF66Cr9aH8
         Y6syQx2NQGFLjTMaztjyZpf+rUAsZH0V1cXqDQboVFQR0lgCmVRF/dOAAYBG9VwHZfwL
         AdvVyI4KZPl91w2ncTIdbL4OLyRs8X+3vYdqNiabizgWWv4jFIkkV7LcUVCX1hSmoydD
         ZOdOfN2pAxH4wbm2Gpt5W7cqw3gz1ZJNNOaBvhoQDGbwBi5I16O8i9UnU3bOTCEBfZxp
         xlBQ==
X-Forwarded-Encrypted: i=1; AL+hErFuLm7f9bauxtFVNGlQVG9swFJmnHwMjZYlUuBninL/0sqgLAFwMLLZZHx22Ma4r7wBB9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9geqbh1PizzQ2I3EEHn9qDqvh/Ivn8PEbRcGbM2WDQAZw0bKYt
	OoIYYhJAaXmdUb0GEKyTnd6ycqfM9fbwL6lPjdP+l8Anx2f3fXH8ZKjraYlrw9elVuKTg4rZrQr
	nXMWiRWlrxlL9kQGLdabUakJDqQ==
X-Received: from iok4-n1.prod.google.com ([2002:a05:6602:c604:10b0:9cb:3bd8:aa36])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1805:b0:549:572c:fd42 with SMTP id 5614622812f47-57a0bb85010mr976405b6e.47.1795114348499;
 Thu, 19 Nov 2026 10:52:28 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:55 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-14-coltonlewis@google.com>
Subject: [PATCH v10 13/33] KVM: arm64: Make __vcpu_rmw_sys_reg() atomic
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use try_cmpxchg_local() in __vcpu_rmw_sys_reg() so read-modify-write
updates to vCPU system registers are atomic with respect to local
interrupts and GICv3 pseudo-NMIs. This prevents lost updates when a PMU
overflow handler (which may run as a pseudo-NMI that is not masked by
local_irq_save()) updates PMOVSSET_EL0 concurrently with vCPU register
accesses.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 89683a690828e..103c25001c0d2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1313,12 +1313,14 @@ u64 kvm_vcpu_apply_reg_masks(const struct kvm_vcpu *, enum vcpu_sysreg, u64);
 #define __vcpu_rmw_sys_reg(v, r, op, val)				\
 	do {								\
 		const struct kvm_cpu_context *ctxt = &(v)->arch.ctxt;	\
-		u64 __v = ctxt_sys_reg(ctxt, (r));			\
-		__v op (val);						\
-		if (vcpu_has_nv((v)) && (r) >= __SANITISED_REG_START__)	\
-			__v = kvm_vcpu_apply_reg_masks((v), (r), __v);	\
-									\
-		ctxt_sys_reg(ctxt, (r)) = __v;				\
+		u64 __old = READ_ONCE(ctxt_sys_reg(ctxt, (r)));		\
+		u64 __new;						\
+		do {							\
+			__new = __old;					\
+			__new op (val);					\
+			if (vcpu_has_nv((v)) && (r) >= __SANITISED_REG_START__)	\
+				__new = kvm_vcpu_apply_reg_masks((v), (r), __new); \
+		} while (!try_cmpxchg_local(__ctxt_sys_reg(ctxt, (r)), &__old, __new)); \
 	} while (0)
 
 #define __vcpu_sys_reg(v,r)						\
-- 
2.56.1.708.g77570a6a1d-goog

