Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572390;
	b=yfyAd3kdrrxpymi6eepdo3OrFxPLnoutPBaKCa/lnJMtrXCELP2F+s1fmtTr1zawz62i
	 8P6LPXrN1dx5HsqJ+j5kiN+KVp5DMrwWrRuW+Is3JZUGH3HscrMWuLs7UUDiAckldE2mL
	 J+NRi25BWIbAh+iRqebDrDjX4n148Go8FQDYhp6wMm7208XML1KQVE2KzpjU+YdReHsaH
	 hgOv8s91KwtM/xTUtYAXe39prCKwg6Ww6abb0SbYDY7HwmBadkNjN4eGg6m8JkfNqgLL4
	 RPgmLhuTUIAzR/9o6soR9DPpat+opFRxHf9RHQBebA2MjJ0DZ8/6sKRWlXhhWiTL5Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572390;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MWk8IrwWlUIzQYJNwSN70Fa00rFJF0H71xGIa0whMlo=;
	b=DlAaS6qhhGuaqGEnRtdMyr6S7gufG+b4LPiceYPIEvdW7ItEmXJoB+CJC1S2rvsSy22p
	 ies3OmQsTW0RCHlqHwrQ2ygmEoPLQO7LFdTjpJ1PpBoI5MbmsBO8SuWIpsa/IW0yWbb5R
	 HaY9giv8kfjK9onVA2eWJd2VemWSe97AzeDMwNNIKnANGFzSH3mn+s8f+3K21eJILotKf
	 cjPVzV7NQTQZoM0zq5+deS3i8RhrtG7SqJxhset0zf+Q/SzRYAI+kpGPBRygYaOiAsG88
	 Pm2wmoKz+1DuE97UbgkdUUpS6PFpri4wqi0fS15IXIqaIRR3FDqOWRM/ioiC6qRKKdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqpllX0u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDB606A68F;
	Wed, 25 Nov 2026 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqpllX0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89D81F000D4;
	Wed, 25 Nov 2026 02:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795572390;
	bh=MWk8IrwWlUIzQYJNwSN70Fa00rFJF0H71xGIa0whMlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqpllX0uZOqpdY879oaZc926aet6KIdHLMv6wTGtgJ44XESzXniis7BaGlZW+azkn
	 Qp1QprKUSm2RBrITwrglx98hvgtgmUJVYuXmST0mf8y5vrJwv84nt+/pN6T/djKSup
	 7U76PSt28xjUaa61DPgcHRGaiTTt40l7TbEsSAUu0MjO9hj9fQVkc/BPpx8KoQ/pqR
	 x+UhM3tYCE53P674qEiM0lRmMZzPJOdXIDi7kozW2+8XwzmloSGsDdeCcRx0OQZds6
	 jvqOa/8A59keZUHYtPRKRlV+ZYXldnUlPdKVGchkEfEEhF2eJ3Fv/KDXZNTIjba6ji
	 wCI64KAKZD94A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Chuck Wolber <chuck@wolber.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	kvm@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Subject: [PATCH v3 09/19] x86/sev: Use non-instrumented bitops in the GHCB accessors
Date: Tue, 24 Nov 2026 21:05:53 -0500
Message-ID: <20261125020603.3934222-10-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125020603.3934222-1-sashal@kernel.org>
References: <20261125020603.3934222-1-sashal@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GHCB accessors are used from noinstr code, such as
__sev_es_nmi_complete(), but use test_bit() and __set_bit(), which
call the KASAN and KCSAN checks. arch/x86/coco/sev/Makefile disables
KASAN and KCSAN for noinstr.o, which turns those checks into empty
stubs, but they still have to be inlined. Instrumentation such as gcov
can prevent that and leave calls to kasan_check_write() behind in
noinstr code.

Use the arch_ bitops, which aren't instrumented, as is done elsewhere
for noinstr code.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 83fd49b26a4b1..9881c702a8f01 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -674,8 +674,8 @@ static inline void __unused_size_checks(void)
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static __always_inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb) \
 	{									\
-		return test_bit(GHCB_BITMAP_IDX(field),				\
-				(unsigned long *)&ghcb->save.valid_bitmap);	\
+		return arch_test_bit(GHCB_BITMAP_IDX(field),			\
+				     (unsigned long *)&ghcb->save.valid_bitmap); \
 	}									\
 										\
 	static __always_inline u64 ghcb_get_##field(struct ghcb *ghcb)		\
@@ -690,8 +690,8 @@ static inline void __unused_size_checks(void)
 										\
 	static __always_inline void ghcb_set_##field(struct ghcb *ghcb, u64 value) \
 	{									\
-		__set_bit(GHCB_BITMAP_IDX(field),				\
-			  (unsigned long *)&ghcb->save.valid_bitmap);		\
+		arch___set_bit(GHCB_BITMAP_IDX(field),				\
+			       (unsigned long *)&ghcb->save.valid_bitmap);	\
 		ghcb->save.field = value;					\
 	}
 
-- 
2.53.0

