Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188870;
	b=TRBthGMgYkSj1ycBg7rM6q3qebq5NDb3bQwEru/sXPdTUTVj/T4SkiWs+/LJATMEH1on
	 8j7u1D9COVuS07T3vAhPiBiU8YzLCm7pscdj4lna6JP01L5zF4R2Hs4w07wcxAheRewyp
	 0qrOpy3aYIc8XsNr6i9yF2oPo05xaLrGk7JbRCCT81fAMvcBKZYj6M44Gn0u64Veou6/V
	 FQhFK6roh1AFBy8Lrmn1kmnM7c0RaXWDybeEDsUwNfBVNm+SwP/XYfIb/++IdXqH476Hz
	 uJmh+ScEhMl6teWvWiMPhJgrbZwyimMSSzSMs33QKWTC4l7sQovS4KO6vkYhUCmjlLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UkBaLAlMUwHRb5nWDne6IbjsAhmk89ydx5e4BpR6msI=;
	b=uY2VAytgfZI83srfzMyW5+5h96h54mLy35vYgvFH7A1ILqF8FH8JWC+8C6HRdO5A1BvP
	 dR7YJGcNLvoQYx8dAEhP0vR2BGADwhe85ZsVIZWOfh8OhjCh7l5CVk+IY/25xvg7145pf
	 AY23oggotQkclvUXQtqpL8yDxRDsz8hn89QmZr8STRi1MY5GqpmSeMJMj4Poj6tFzCaoO
	 g5XHJ6SQe4Zox+saGTcMZMUNlySRVR0NOlX6c4Z/sN7LAjhxv89Bja+wYZQSJrd0sq8IP
	 AgDYB5PwwA1I7gnCMla+YPE9tPb4Tf/HurqAczFQHBvCJQh87Vk2TVJKjPWlrkEZdJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/cTFDs4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233560A2608;
	Wed, 28 Oct 2026 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/cTFDs4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029AA1F031E3;
	Wed, 28 Oct 2026 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188869;
	bh=UkBaLAlMUwHRb5nWDne6IbjsAhmk89ydx5e4BpR6msI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/cTFDs4jT+dpKsQIzPFDJx60GvmWD+qOQT+P4Pywqnu1LRdZSP9mseFWmdoq6jLD
	 j5WWBtWXOQTKO1bOKaiDnEnBOfiCWGIN2QxTSovjrtvh5TkmdpMfWGJnoGdJl/ZIjr
	 od2LocISPA9xjNViolBn0QM4E73z5xAiamQQkinfZp4fD53zCgF0HkMkB9v8p5Fo+A
	 TIS9CH1/tIvVzZZrJbduhC/gGrfL/AfypW27ocC1vcscq0mM4+vsXrofFCJDQ6MsJ7
	 Ex3pcEewgdq423oeTNzIvgh6ddZhTHRPSltcDmqrS27zBNxh2nZiykMPuCIJSSCPih
	 al/Q3yNIcDFDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Chuck Wolber <chuck@wolber.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	kvm@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Subject: [RFC PATCH 10/20] x86/sev: Use non-instrumented bitops in the GHCB accessors
Date: Wed, 28 Oct 2026 07:59:34 -0400
Message-ID: <20261028120034.871983-11-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028120034.871983-1-sashal@kernel.org>
References: <20261028120034.871983-1-sashal@kernel.org>
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

