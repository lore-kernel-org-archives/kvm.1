Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C93D47D0;
	Wed,  3 Jun 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527326; cv=none; b=XM0D/dwDc2UVBarK0aRa25OHpIcwqPHsWbjfYrJPxoTotiwyUf1M8WPA4AFJ0Kg9nXHGpbu4hBkZSqQWXo9NX99RjzZn7/fMihrJ4sEKB3AoU3xy+44L1W7NZs60q+nMKtq4QoSr2duK8+Xc91CPSWNVJgOfPh6QCnY9f+50hhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527326; c=relaxed/simple;
	bh=0i3HKfKAZEXkzt5Zxsa5pJ9oMm/FULATvfyLmZeRLbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q8JqNKtVojZoS1ReSuSo1xvjhbHIgQGI4EdKwnBvweDVpWSJNfL6An53560HhD1oJcbrGeLaqH0xiAO2qAjh7Wsqy2QOt214EUY1/2FQteUk7axs6TJBxBQznb+pgMBwm7piBMgyui1GZOzSIYGSc90ka610LTWpmTAG0WcirEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUy9xq5a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUy9xq5a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8414AC2BCB0;
	Wed,  3 Jun 2026 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780527325;
	bh=0i3HKfKAZEXkzt5Zxsa5pJ9oMm/FULATvfyLmZeRLbI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=JUy9xq5aZdn/uyWq0bBhj/SqczMvCRjvTDqbS7z6HDAxEPapsKhZOBqZ6uUXdAtaV
	 8MG5898fqziJf2FVqpNHODrGVl5kPc8hsneQ+K+0kMKO7PUdUTESSMNHaiWOqX5Qp+
	 LfArQ2H8PClk/Up/Yhyiq7QMDmVB41GCPO4VwZSJ9+LykoRsxvhdnNv5KvCtW4L0ps
	 KGRsOfKXLHh3gkcTyry00twTu/T1nfALFQvVZ7gPfGljwac4HX4N+CXh/Xwd87ZvI6
	 3QUzKgyD8E7TJLt1uP9Ttpp2sdqskgT4IqsqI+wAAHmP7DTqCmjjbKmdIwVgSAnVYg
	 6k6WY52KQ6d/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F2CD6E6B;
	Wed,  3 Jun 2026 22:55:25 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 03 Jun 2026 15:55:24 -0700
Subject: [PATCH] KVM: selftests: Make guest_code_xsave more friendly
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-snp-selftest-cleanup-v1-1-73b29fe31ce6@google.com>
X-B4-Tracking: v=1; b=H4sIANuwIGoC/x3MQQqAIBBA0avErBswC6OuEi3MxhoIE6ciiO6et
 HyL/x8QSkwCffFAoouF95BRlQW41YaFkOds0EobZVSNEiIKbf4gOdBtZMMZcfJd29aNM53SkNO
 YyPP9b4fxfT/B4FE7ZgAAAA==
X-Change-ID: 20260603-snp-selftest-cleanup-bf97734c6902
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, michael.roth@amd.com, jackyli@google.com, 
 liruxin@google.com, darwinguo@google.com, jacobhxu@google.com, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780527325; l=1941;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=/w5y02MR7E1dim1B0Oo2RpreZBil+9LNll44ViP3HBc=;
 b=5CKyYK19jWHUfGp2Y6HXQ0ZQcngpoxvT0Q+7ZVA0QMK5zsvF115Aszm5FtTOW7E/Cmo4FqtD6
 MFsYn64TSngAJhx6TLdgsAr6OVfBIhDMEatBKrRueS/YkG1H93xunlQ
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

The original implementation of guest_code_xsave makes a jmp to
guest_sev_es_code in inline assembly. When code that uses guest_sev_es_code
is removed, guest_sev_es_code will be optimized out, leading to a linking
error since guest_code_xsave still tries to jmp to guest_sev_es_code.

Rewrite guest_code_xsave() to instead make a call, in C, to
guest_sev_es_code(), so that usage of guest_sev_es_code() is made known to
the compiler.

This rewriting also gives a name to the xsave inline assembly, improving
readability.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/x86/sev_smoke_test.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 1a49ee3915864..8b859adf4cf6f 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -80,13 +80,23 @@ static void guest_sev_code(void)
 	GUEST_DONE();
 }
 
-/* Stash state passed via VMSA before any compiled code runs.  */
-extern void guest_code_xsave(void);
-asm("guest_code_xsave:\n"
-    "mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
-    "xor %edx, %edx\n"
-    "xsave (%rdi)\n"
-    "jmp guest_sev_es_code");
+static void xsave_all_registers(void *addr)
+{
+	__asm__ __volatile__(
+		"mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
+		"xor %edx, %edx\n"
+		"xsave (%0)"
+		:
+		: "r"(addr)
+		: "eax", "edx", "memory"
+	 );
+}
+
+static void guest_code_xsave(void *vmsa_gva)
+{
+	xsave_all_registers(vmsa_gva);
+	guest_sev_es_code();
+}
 
 static void compare_xsave(u8 *from_host, u8 *from_guest)
 {

---
base-commit: 0d9b37717aaa4a73362520af5ba4db7febf09123
change-id: 20260603-snp-selftest-cleanup-bf97734c6902

Best regards,
--
Ackerley Tng <ackerleytng@google.com>


