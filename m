Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305712;
	b=i0N9QGsJ/M908x7MpQZC9xP0nPnB6nujtJXsPCJApV4IzXvaJJ4QZEKTcsbNo2bKt6BT
	 2tEie9qtLrgnFq+95Cfbgo84jdXWbve/3XdxGcMUMRwBDV4PfA5jW8UKoESvURfMrR1nQ
	 AT/bBZVym5xdpCpwgoO7QJN7U2GI344KKm+igWweiHa1eJFkrScAtFgy11zVGqFwGKAvM
	 DUc4D5twotir6ij9CWCZpc4mT7bmto02WL1KqW0cJzRxS4+xtVEPuZeJA4r3p/9iYKKCa
	 G+EtQkXjTDd05kaSAcqP+pTQTWpUKiufuUUpdSlu7ohV3uFWc5rsk7APCqq6Agqguzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=cZzrCOWTd2fbBwQmagh5NJOE4ckRSGpMrV8yJJh7s5c=;
	b=bwzm4fMbgoqPssVt8M8kDq200L79yDNjxMmIzEqKSq0yVSYzM/+4KTXoyIRlKWtvoSgb
	 zVCJaabKLQ+UP5cDf0wHgTa//ehriut8+nMkiiq5yRE1VcCLg/hTMyZLAju5Wcr462VEa
	 y/BSVydkWdSrVWwZjPMD/D0AQAEUVgwByAiIabtnIVCpK4LVi8RL/hFGBVcXQ60moicv+
	 rfeXT5MCLH+lYz0dxs+gT5jqm7/RCK49m++cLuLvoOlcmw+oTsGuHiZ4PYQuNGhxU8Sgz
	 wH/mP5MpDORWc9QxAov/y6x67TvIo8kETpw6c5MXV6Gh5PmXXWyJYF69A0fC/GbyHtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GkIJG07d;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A1606A321
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 665A1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GkIJG07d
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-887c99013edso1597624b3a.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793305711; x=1793910511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZzrCOWTd2fbBwQmagh5NJOE4ckRSGpMrV8yJJh7s5c=;
        b=GkIJG07dYY2I4Zo1h+fLgM7rJMxTsUZGXOkw5/HTO/H0iP6g9a2wid0vb49fwBh5gO
         LpRm8fPajjcPl0kZuDgM8M1+q0ZcMSikTeVQU9En4l6napt4g8yCV9NvB5wN0lI+1j2y
         1tHCn4ALUZh8r4f2rQX5N99rLaRP0hkbxpj6ykZAHDDCrMsT8M16h13GwoAmfzMv9syP
         I54PGEyOiXdkZ44ciSjmB8r/LF5puRt2vDlpw59ZhEXt258i4vSIb2JzpD/sSto1KYAV
         ZswYr19Z4qrdX5aJW47j5xxB5IsKND2Tpz3X8++nf+woe9WBNkLJFxlQgshuZkURVF4f
         yTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305711; x=1793910511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZzrCOWTd2fbBwQmagh5NJOE4ckRSGpMrV8yJJh7s5c=;
        b=vCOKyUO22LauJVXyKJDDHTZZ12Mvp5mw89kA8u3YP7s9d6BbwBEyrRgqFyc3zSN031
         Vdi5fF2AdA3OQYrOiXQNr9BEvzyWsLtG7lqHD0fUllnHeO7m5kZv1DJvhMcwLtqGAmFs
         kv3kgFOqdoHaT1WUrCKFmlDvwluI4AaIbsp4fq30ol+xhZmSWyIjd+AaBEuCLy4al1xG
         rkvaLRaGYXh92MBIPMM2CVozyq5M+I5ZemLviTDx1hkC2BRcPC6QUL8QOdeLdureyZ5x
         L3HMuE5M1F+1yEcqRaIbxrEFGnK1hAHRI0q4JCCSk4w+a6Xj1f21SKMHlUWPLR11lsnA
         PRrg==
X-Forwarded-Encrypted: i=1; AKwUvByxs3zWRlTFanHHdw0XI0gpFoLDR3J68CRF+FGULzjJcYoOn56pb4pk3IY6MZKo2sYq8UY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmrEz0dfXHVtINzqBDOfFR0Aes+XMSu/BdTe9TCMUWHg2H81lf
	Q7wKJqs15Iby16V7JStpiEvkucF+NdC7jH/imCzI10YGYQA80oozzsJhNdU7/FUppry7dxLmGXl
	pSBzhdR1kAXhMEQ==
X-Received: from pgbx22-n1.prod.google.com ([2002:a05:6a02:63d6:10b0:cd8:5a84:95f])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c98d:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3e928d4684bmr325145637.13.1793305710592;
 Thu, 29 Oct 2026 13:28:30 -0700 (PDT)
Date: Thu, 29 Oct 2026 13:28:15 -0700
In-Reply-To: <20261029202817.901145-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029202817.901145-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029202817.901145-2-jmattson@google.com>
Subject: [PATCH 2/3] KVM: selftests: Rename svm_nested_efer_test to svm_msrs_test
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename svm_nested_efer_test.c to svm_msrs_test.c (matching
vmx_msrs_test.c), in preparation for testing other SVM MSRs.

No functional change intended.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm                        | 2 +-
 .../kvm/x86/{svm_nested_efer_test.c => svm_msrs_test.c}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/x86/{svm_nested_efer_test.c => svm_msrs_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 888a7530a280..d1ddce584efe 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -122,7 +122,7 @@ TEST_GEN_PROGS_x86 += x86/state_test
 TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
-TEST_GEN_PROGS_x86 += x86/svm_nested_efer_test
+TEST_GEN_PROGS_x86 += x86/svm_msrs_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/tools/testing/selftests/kvm/x86/svm_msrs_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
rename to tools/testing/selftests/kvm/x86/svm_msrs_test.c
-- 
2.56.0.317.g454f8302e1-goog

