Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614854;
	b=WjURPlxE0fyQZZTde0rI619fnBfcXrtnrOEpNgdHYMhYH+LWwonGiUSD1GoFodbsna/d
	 35h3BJRZpqjK26Xai4G+sEnj4Cd0Z6ICRi6wyuMGgoGTyE2BbNtX8hycTmiTNJ7ecUbGW
	 M7kkaZLLd6D+o6AMRrL1HEnAiCi8LF9sE/WhQUkvP5qQ4sXHjLRWexpmilzlu9+h4LDAb
	 wIc/AMpx4Y2xDUIuyj45saTesB5ipoN4zXyO+V1nwE+Z4G4qcvRwPU/hk5WSs6W/FarJd
	 1b+wL9cD1g4j3Y855Pk6X/b8Jak1z/8b9ahFIcjvw4386cJJ+pz8aB5WePgBsyKHmLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=M+PGCO0Pq3qqR1GvRzDH1epKC4GMAn77itO8XNRsAfQ=;
	b=YEytMFZh36gz8uAxQbRdESJUDWRKTWRIEZCg3BFA9qA66SXOL74Prxj/SM/T9fbxo2DZ
	 xIyPJqdUTD2fQNq4YZSdzrURqDJDVXWT2zAtc3yF+pT6oXEykXcQLm2WxwdGmbijhAxcR
	 7sJ5O4lc46AUWkQpdDyihoXq8IGhTS+m4rX+XrrCElPlAiQr3aAQQaqQyiJMC5pNGgspz
	 lqAVfx6KEd+HJEs3hayn3iKmrT3h2mPJgZPx4d/y05tcDdKmD3LIqCaB3B9iTON6KNcXt
	 5NZ8/g3qSuX1rU5R2+n/jr4jMgTp0XRjY92ZSRogBZHGNHzuN0qRfjT5H9jmTy5McOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M0DNDEYP;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFC606A338
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 00:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EEFC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M0DNDEYP
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-82315dbce25so975246a34.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794614853; x=1795219653; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+PGCO0Pq3qqR1GvRzDH1epKC4GMAn77itO8XNRsAfQ=;
        b=M0DNDEYPZ5JzN6obfv/I5dMScdA9CRgHDNIOkcwrmlPM32yQJdbv3eqGSkgycgrZo7
         YaJi7xRxuIOXELQ+9zRRU7Mg0G7xGes2SWIQvcCX33Cw4WvYsLnBW0m4DznlsHTZ0bV7
         2tXTrUsMTnResrxAeu6gBWEhZ7/Mt5ui5Onxt0BkPD70S3lPE4rtEiqpC/QZTvtj6dkS
         NYd4Mql3qPC6zBxzJ+x/3e3wU+QRdgUKu3guoZcoAzAk1AYVGoWWYgWA+oAvDWZCcYP0
         Kzf8JDJnLoqtX9OKKOTjo9M9fGWx9aWUxJg3RNXhg7jdOb3gUwJCv7MzfjTd6jwI9bVR
         MrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614853; x=1795219653;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+PGCO0Pq3qqR1GvRzDH1epKC4GMAn77itO8XNRsAfQ=;
        b=lrZRMDcbJzTCxJBSxdpbFyRLkqdhklmW4aym4qMWdZdv4GqWPdAUWLhq3PTtW6LAg8
         NHsEizxFo6krUPhRqwYd9b8I/av6TnF51GHSuhiG/kj5kH5YbIoIWC+g0oXGDndmhDPK
         yS7tsQ2d6JoU7XTo/oJfZf4rCQz5EZfW33fqZWfcfZGKQSOsCClW5Y4Fdy7os4hrNalD
         6cc18uUHlD7qsmUSJ3Z79brdh1QkcaIB6D20ZiooQbHF0sIlSnyzJquA+E+660yTQXug
         M+2Ay6q/beEicSoKJBQhjQa1JE9oY3d6uANvtFXqHa2A4Io0zbk7PPlUyhk+Fy5o8zoI
         yznA==
X-Forwarded-Encrypted: i=1; AL+hErFBh2fsv44UXAw5tUYcVAlJFsAYGRpTQZ0pa8MsKuCHJrAmd1iF3P4MjoDg/VK6ZRSNL5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YHjzINrSg+M1Z/azLEV5NDvjZ3zMsZwXCWP00MXX7CKvEM6pB
	T+FWGf+pMJI/fKAhMGgPwLpQRdG+IBFvk1DO2qdsaDbj7ABs7UsNOx/XRb3dygeM2ujp3evcJNP
	4VatI8xrknp3wLA==
X-Received: from ilki9.prod.google.com ([2002:a05:6e02:ec9:b0:547:a809:712])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3c47:b0:4c3:db9b:3ead with SMTP id 5614622812f47-56e5fd446d1mr3661844b6e.3.1794614853129;
 Fri, 13 Nov 2026 16:07:33 -0800 (PST)
Date: Fri, 13 Nov 2026 16:07:30 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261114000730.2190544-1-jmattson@google.com>
Subject: [PATCH v2] KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state()
 on guest SHSTK
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

svm_copy_vmrun_state() should gate copying s_cet, isst_addr, and ssp on
guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) (i.e. the feature is advertised
to the guest), without which the shadow stack MSRs cannot be set. Instead,
copying is gated on kvm_cpu_cap_has(X86_FEATURE_SHSTK) (i.e. the host
supports shadow stacks).

Check guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) instead of
kvm_cpu_cap_has(X86_FEATURE_SHSTK) in svm_copy_vmrun_state().

Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/from vmcb12/vmcb02")
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
v1 -> v2:
 - Drop confusing nested_vmcb02_prepare_save() and
   nested_svm_vmexit_update_vmcb12() examples and note that the shadow stack
   MSRs cannot be set without guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) [Yosry]

v1: https://lore.kernel.org/all/20261112212628.265262-1-jmattson@google.com/

 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1299fdadeb73..b73bc9c3ebdb 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1248,7 +1248,7 @@ void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 	to_save->rip = from_save->rip;
 	to_save->cpl = 0;
 
-	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
 		to_save->s_cet  = from_save->s_cet;
 		to_save->isst_addr = from_save->isst_addr;
 		to_save->ssp = from_save->ssp;

base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.56.1.703.gf848ed807c-goog

