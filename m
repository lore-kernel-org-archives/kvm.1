Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701868;
	b=c2v0FKYJ7DE4eIJQ7/rYYeL5oL9TKd+CgDiXHe+U7yBLaSV3mhVGo7tQZ7mP9UfgUZbM
	 dvRACxpYaEmuWX8xYwz5UB+WHvbzciEvkPWmzwEjneWaA5ryrMwto0me7ADRmLf+lz+JB
	 jlIcrfivUP6IXwbD5/sJzA0R0FZDM95S1Zp4KneZvVr58r9VKySlM/waI4bdOQGI/TxTm
	 CT5LIbboVUtfC514OvKOiiQVvGKYTxViU2nGu8v5opQmyEPh8ZRi+wXe6d98T4LNxG0PE
	 UyR/Y0D2MCXKuEd8Ssx8rJJ2RdlJGhZf8Gl9u6OfTfjbMP9FUOPR86ko0RNcS9AoJjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/l/7JoyeacGBgIPjFlRkqbvwAzLS3Ix6u2ILbtfwTHs=;
	b=NneirSMtqcfDqteSB+85M4fub0Q6vz3rktWyx/sEmAv51AWhH8k01YbuwOP7JO6Z2rZ2
	 dkOnKdU+4MCeNjz6DVEuC0Q49Tvy6RyiLms3jBP/0jo4OSKbJk9II8ylC4smjffnf/hqx
	 CPbwgaksiHHLn8i9wrTISE0RseFPuoOqNN9jOR8ZxICfSeFo+n+n/N2WoMsNnUFoPyKL0
	 3DTacCDah784giJID53vU4yI+jT8AW712KWBBcoIDYPhkGJFZYtXWQ3S2LdDFhVZ/I4UE
	 V1AWhruVxE8qtrRzDH4MKGev5X+We1Rmk4XGXI464AyyU9mZl1ajrF9nCYo8bIuzWFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OD0V9w9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77F606A31F
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OD0V9w9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0705E1F01829;
	Thu, 22 Oct 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701868;
	bh=/l/7JoyeacGBgIPjFlRkqbvwAzLS3Ix6u2ILbtfwTHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OD0V9w9wiwgrjXBmfggOWbs32/yBxp6jnppWN/CmZzpYCdbtznk1LhBMHOeEEKTct
	 CkuCFB6Xhi7q7O11QLKyiNbgjeGCZIN4rK4z/JHiYufTjkywSHwJkNYGyU4C5F7P78
	 ZZ5FoP34s+nSqXmM6aJjdu4ciO8eEfMhY/7JY7NgNVzJsYRPc59H1ANfajXuIsqw9+
	 cv5adC29EDSilm7hj+WL/ANbc1IvPHCqUrO9Cz6X10enpOBHG0mHD+5/wSGb6VO+qR
	 cWLqqDXB/gx3DihGNmb2CgNrS01EivUc1kczzgkX/Uw1SPh7+KaYsGkmoqiZv+6SQk
	 scI/1W63Lh92g==
From: Yosry Ahmed <yosry@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Greg Thelen <gthelen@google.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH 2/2] x86/desc: Remove unused exception flag
Date: Thu, 22 Oct 2026 20:44:13 +0000
Message-ID: <20261022204413.856786-3-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261022204413.856786-1-yosry@kernel.org>
References: <20261022204413.856786-1-yosry@kernel.org>
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

exception is set to true in exception_handler() but is never read
because exception recovery redirects regs->rip to
exception_handler_longjmp(). Clang 24 warns on this with
-Wunused-but-set-global:

  lib/x86/desc.c:483:13: error: variable 'exception' set but not used
  [-Werror,-Wunused-but-set-global]

Remove the unused variable.

Fixes: 932ba2d2f530 ("x86: simplify test_for_exception trigger functions")
Co-developed-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 lib/x86/desc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/x86/desc.c b/lib/x86/desc.c
index f4cdfbc92c560..b5d4056260a1d 100644
--- a/lib/x86/desc.c
+++ b/lib/x86/desc.c
@@ -480,7 +480,6 @@ void setup_alt_stack(void)
 }
 #endif
 
-static bool exception;
 static jmp_buf *exception_jmpbuf;
 
 static void exception_handler_longjmp(void)
@@ -491,7 +490,6 @@ static void exception_handler_longjmp(void)
 static void exception_handler(struct ex_regs *regs)
 {
 	/* longjmp must happen after iret, so do not do it now.  */
-	exception = true;
 	regs->rip = (unsigned long)&exception_handler_longjmp;
 	regs->cs = read_cs();
 }
-- 
2.56.0.257.gf7497c7d27-goog

