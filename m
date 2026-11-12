Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518792;
	b=rVFvWzyyqqoJe57/qioxPrEo6sgDti7qU6fcwky9srJyX/EevhYxEs2EHx5diIgp4/BB
	 4X3iIxTMNc7+p9FEFWtjVIQiWFRuXU4wiL514CFrrVbIgj41+WLvqkvqPh1KpurKDH8U4
	 P5GFjubu6PJpJne4cnshfjFpksNcUb0xD97204SmcbbSLI3J1ScQxLEAT0rak8pCX9mkg
	 xUlUSTO9yiMiOIF9YNnjCBQTPLYJjvDuD9EkEEuUBHntPtkb5GHn0AhuEaDj7w7jC2ET+
	 u7N6HWXbWkHRrDXzXChBjAxXGdtQ1cEkLTHIF5yzD3zM9WmP65nsG+RhqE2QZD+Flbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TESmgCxUPr1Vm2wbKzVzpf5OFlB+4n+j8+LrMnvA4m0=;
	b=MJADMAL+CCy7ey3A8iw5keRStTuA9qGyzjiaovO6HvGjnwxSXvvtwYcN1usSEHsr5xCo
	 YG4ny7tnMWPvbFwhe8iDCL7dSN+9D2jjyWrPNyk1brOhnljcCAykEkKSFrnwAJTQNp6L6
	 AYkM1/HvPrGPppgIx/jU8BswhmjqWXqonFhTg61g0neKZkImtXzJjiyeH7DIavFDIr8DK
	 Oq1+j9cfyF9siNNDQRVeiaNmt1ts7FlCYrD0NLhR11MLQ8bJvnX91DmYxI5ULeE38sD2D
	 RjVkSQHShHivCJ5csTc1ky2M+XCzWDogToczfoNJEnrOjww0DU4GEVwAwHypXSpI3Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QopOShDW;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA37606A323
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA37606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QopOShDW
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a41f46d629so342573b6e.3
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 13:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794518791; x=1795123591; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TESmgCxUPr1Vm2wbKzVzpf5OFlB+4n+j8+LrMnvA4m0=;
        b=QopOShDWxI1E9RX0pzFGc+2f6Yy/h/7mxtYw/URNk09ek9vnzDdKKHqbOQOLYYr107
         W3c4GBMYzAq3EZQDEFB46+KF7OUH7hhj7YXrqJFdfWod/vmoz3E5GLU/DOd54WPRQXZP
         Vv9I4/KLG0tqV61NjaimWDUhruut1Ko1g9y9QtVRNjqmLPyJB+kiLEcwIOawzTS6r5DJ
         EBsPkkwES+VIt5PIsVZNt2/cuxYbrpfAS5xsfkA3jv77Sk9gschHDf1nIeaC4lknV/dO
         4Q3x2lWbtwuApUZKD2lGdOvgDf1AxVdPnpEvyWl3jbfRkl1lLcF0s486KNAQ010czhRe
         o8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794518791; x=1795123591;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TESmgCxUPr1Vm2wbKzVzpf5OFlB+4n+j8+LrMnvA4m0=;
        b=oGQZQxvFhaqw0hmeY6p4tIbnCKhiohilZS/trcpymFgvl9nquo+4nNQKWZews89D+X
         B2/bMyL/Qm46017acCzve2GWsad9Z7Cb9COFe8YP2fB/uhDkl9SkTpr2kabK/gh/TVQl
         4LBK2BNXwCgzKiCFKNjWivsOA5udgiNm43ghfjhrNvkdwiIO5OSruQ5kyJjuNeNBRKaA
         Ox00um5DOcRr6XeYN+7SgpPahEtV2fSkz87SC3fpySXelZj+8T65lvz5GV4uMvT4FnCr
         7olEaY9S6RGk3CiXdb3FnIyCB2Hcf4y97+k88j2SkClkwG9J0fkiQ8HDc8fCDxGP7csj
         ftZQ==
X-Forwarded-Encrypted: i=1; AL+hErFsx9S5YWvr5CYY+UVkLqvXh/gqA46ImjImvOgO6nQt40OlBInUzAhXgB2t6IjzTUEV4AQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Dy7kQ+7QCk9nslKUGBX/dnzH5tdjVnXCh3rAXilZgrHxXuxq/
	+CBW9DL2qId/EN+T9i+Se7CfL6T6axxwB2rExvhRzaVEUa2wvtC6xKDKv7rq3oFX4fyRnPApM/d
	Lu6XQCQaRibAXAg==
X-Received: from iofe23.prod.google.com ([2002:a05:6602:82d7:b0:9c7:9256:112a])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:250d:b0:4ec:4c7e:37b5 with SMTP id 5614622812f47-56e641d6157mr456217b6e.29.1794518791076;
 Thu, 12 Nov 2026 13:26:31 -0800 (PST)
Date: Thu, 12 Nov 2026 13:26:28 -0800
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
Message-ID: <20261112212628.265262-1-jmattson@google.com>
Subject: [PATCH] KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state() on
 guest SHSTK
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Like nested_vmcb02_prepare_save() and nested_svm_vmexit_update_vmcb12(),
svm_copy_vmrun_state() should gate copying s_cet, isst_addr, and ssp on
guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) (i.e. the feature is advertised
to the guest). Instead, copying is gated on
kvm_cpu_cap_has(X86_FEATURE_SHSTK) (i.e. the host supports shadow stacks).

Check guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) instead of
kvm_cpu_cap_has(X86_FEATURE_SHSTK) in svm_copy_vmrun_state().

Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/from vmcb12/vmcb02")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
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
-- 
2.56.1.703.gf848ed807c-goog

