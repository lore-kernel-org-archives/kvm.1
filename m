Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CCD1E0E14
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690909; cv=none; b=oe8ueZ3ZcepE22sSY/B0pnCMfjVSLFL/tK0ZxulwbNwjowDrKGhUX9iDJRNh+EKJC3j1G2IC5vuEiC01nU+xHSbFSBgHZaUHmorUcHbZTeKgVtc47nVwXvhExMVmEOI7ZTukGPBubuTyJBmkpBc0/iI4iVduuiXtQisYflGP6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690909; c=relaxed/simple;
	bh=R1tmYU4DXwUaYNRIS2ITaY7bEA0QNeDNVMefmnOlu7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apbDqevTuQaWa8afuHn+dKf3MfexaJPoyPKw3vAhRL4fTU+ZkDxdKzWA+YJWbKb6hfAGv4wLO4+CYDqN0xhZpwb9G2RLawoaV/5DDxup/vxPmd+amLD+eopk8iRhBaptYbutEFOm3ET0QB+2nHRpnO+OIlWFZQVqunKV+676BgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pc+GgHyx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc+GgHyx"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c2c7770bso574235e9.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783690907; x=1784295707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SAfw2XLSvgndVDo3hUQeQr3dLbpgg8qNv+9M2JCbKc=;
        b=pc+GgHyxUIH8HQjnQY442iJt8dRQZ6v3B6NIJXGorYKR+7yeshA9vQ8pOwN5NPnkxB
         jthUnMMGMOI8YMjzZZblJ8CAg0zhclmXQl7GtoWRPZv1Qc3f77Qgz6/MIO4A1eNbvO/8
         yPTFswOCNIs8XbYgYKUgZL1BN+Er8NKCxlryG4Tmeo46V1VzpRBsrHyv99oSAcebQ7ix
         TlIFiaJpsfQLdXAMGuFo7qRVGtOI5+aEarY7ayC5I8jxkLc71u/GH/0wEQxmmKoXjRX3
         dKs2574NET+Ug/YKpMdUwP2eQxSJjbgPNifC5KBSWoiy/48gVANOg54jti06xk4Hmhgh
         3zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783690907; x=1784295707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SAfw2XLSvgndVDo3hUQeQr3dLbpgg8qNv+9M2JCbKc=;
        b=ZGQgrHd4wkIztWg+uf5Yh1ytsR2ovHAEfXFBqGrjKnpLP4NFAoOL9SibVTgbamjhGh
         JdGdXB0jNNg/3KjWgj3UpHD765cnClFnuokqhRlUlWgM7gcgQRHTtaZ/wU8C/QtoumeD
         4520iJr9JFA3An7xm2PVz9tdClko3U3uQYH1Fcr4Wcp+2YZr3gotK0EopND6JWKAu5TJ
         Dw8//d8Y+ZO3187xw0Ih8X96oE0hsRATKljTnDxtkUv8x2RP8nHO5F1CwnxWU/I8Dfff
         cjRtZo+WrJLqrND3nbUXEvKFn3/IaIe7Df0NLG/LVJuoQC9PxpbQA8dGUvWewc82sKLd
         1KQA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8Eed+44ETFzMXOQB4Pfo7i/LHCjK//GfaQnSPjEqBtvQ7aLhV5XuBgMvekLTeIYv9EwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXBsKlJ4hDAfwZ8pnoXudYT38kzkX6z29BojIW7pTpxjzjYdw
	bM+rEkL0LrrhpMaqVfyI4pL47cV390GIqKPsFo1jCJXpcq/m5URIz7NM
X-Gm-Gg: AfdE7ck+pUmoX40CNoIvLxZR6dIe2FHJL2jQDZ7zclCjpoHfpXMssdjhG5h+p0VLIr2
	50Td1uebxHFsnOd4/qhUCSQPyO4DnRe1dOmLAZLesbFgtbwJx+Uv1bgIA0As4U6SONTVXvimQlD
	wkDv0LNlJJ8BXASjp1CvpIGH62BD/enGSbulJuaO2vFHk3TqxV2espkCIAOx3L7yYRJuYNRVMV7
	3yfyFybSse5S+F74c5FO+z1ViWUfnahEdy68cECpMu+3Bda+V+GST5E80Z+ssjU9Hn8i9BWBqJO
	zUViIS65jpNe7140VQ6evkoPP8WKU/8P+/4ldVFGfqmdLHVrT9AbUltdjgXWLzTWGdPIUai3YOw
	hj8CgokJTvji+ZwQXmxCuyv1FQXzlSLKu0srJ714SrJ9P72bBzaJ+sKW4C8/OW8q4pn/kqv0XKR
	x1pEFbXmmYMw==
X-Received: by 2002:a05:600c:548d:b0:492:506a:f48c with SMTP id 5b1f17b1804b1-493e684ea1bmr71597275e9.4.1783690906328;
        Fri, 10 Jul 2026 06:41:46 -0700 (PDT)
Received: from AtiePC ([79.117.54.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm228006715e9.2.2026.07.10.06.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:41:45 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Daniel Paziyski <danielpaziyski@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Fix null pointer dereference in trace_kvm_inj_exception
Date: Fri, 10 Jul 2026 15:40:54 +0200
Message-ID: <20260710134055.16432-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trace_kvm_inj_exception tracepoint takes as arguments the exception
vector, whether the exception has an error code (and subsequently, the
error code), and whether it is being reinjected. The error code is
formatted to the trace log as a string using __print_symbolic,
which takes an integer value and an array of structs containing a mask
value and a string. An empty struct is being passed, which makes the
kernel derefence a NULL pointer when the error code is 0. Remove this
stray struct in the invocation of __print_symbolic.

Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 arch/x86/kvm/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 0db25bba1..93de876c3 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -490,7 +490,7 @@ TRACE_EVENT(kvm_inj_exception,
 	TP_printk("%s%s%s%s%s",
 		  __print_symbolic(__entry->exception, kvm_trace_sym_exc),
 		  !__entry->has_error ? "" : " (",
-		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code, { }),
+		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code),
 		  !__entry->has_error ? "" : ")",
 		  __entry->reinjected ? " [reinjected]" : "")
 );
-- 
2.55.0

