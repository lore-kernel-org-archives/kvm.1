Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670783;
	b=kk/hR8pMlgfU8iS49y+/qKhKVeUIOlW2hm3xWlbA1oKh8oWi1bFgPm/z/d7tm5LzT8Ap
	 NF1EN8QaG6rcRCLsylmAYYlDVow7AZqFqlKR1Ih/qWkeyI5FcU2LrZHDZ7MXG4qNuUob+
	 FI8PDxRB0+lBMuLSRayRzUHFMvnywc5P212E8UKDuFDjFZt8fQYM6rzeeif91gzVpsg4f
	 EIG0XYzB8N9uTaJY+O9UY46F0qxwsnO4HojVOktllziYu5rvicXRRxjzEQ1cRKJDAwHXz
	 0sS6KZ49Vf/W8BkTmOvdiyCzakxgySZyR08E/Zj7TgeFG/RJvOqBq/75aFhPytgwxvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670783;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UkBaLAlMUwHRb5nWDne6IbjsAhmk89ydx5e4BpR6msI=;
	b=sRMsdEmRYc1VV1lsXd6EFTbAo/TwuWavIaOKwD2Nlz+1yNoFiq4JFib6gDHDgcgzzwp9
	 qedt2ubte5NbpIY/Kp865RJ47GwACcCx6PGLTIHoPCDvUoXblhhEG/J2HGWtQqu09zI2y
	 I6G+xxAMPPo7WIsIpdE69tj4ns/q5Q60tdCL/L2GDCYQ7UGb8Z5+wBcCfbSayiEm2IF3r
	 R38XzhZh59/cuBZr0Sqh5hQhEoPsZa6is2Mk2o8lxAamEwXsgb4wcWSOMun50dQ92iQ9g
	 K71nwDSRCFuRcBR+277au27HeuxU+U9SW/hqEqUiRXUMNMl/8hO8sFt+rKjR6tcoXvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6cf0Y1a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E3606D81D;
	Tue,  3 Nov 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6cf0Y1a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D8E1F000C1;
	Tue,  3 Nov 2026 01:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670782;
	bh=UkBaLAlMUwHRb5nWDne6IbjsAhmk89ydx5e4BpR6msI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e6cf0Y1aUCvZ2jJrmWiTnpvORsJpqM2kUEGebn00tyA8NeK/bTiiEHBb7zw62KbUf
	 VTiPW91J0Rbf9Lm6LIbtW4uPbl4mzeuuaW/xh3E4y021RHvdmx23cxglsUCh4ujmV3
	 10LCxb68ff4KDtEjDvsTy2t0asfcGqExSOTyDGNAzt4VdBBrHZQPNjX1hWsvDnX/z9
	 UyvhqukAya979uOMY9sQFPSemPcMRNhCNgZ5QOzNIGgtcUvfSSQ7NGh1KJrPPD25xl
	 NvW3mNb6Wyzw4ICvFp+tiKcM4Qo9gMj81o1hXbP5YJphRrXxh3lak20IOSeJvtjNWI
	 u+t79AfFSX+MQ==
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
Subject: [PATCH v2 10/20] x86/sev: Use non-instrumented bitops in the GHCB accessors
Date: Mon,  2 Nov 2026 20:52:28 -0500
Message-ID: <20261103015238.3780910-11-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103015238.3780910-1-sashal@kernel.org>
References: <20261103015238.3780910-1-sashal@kernel.org>
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

