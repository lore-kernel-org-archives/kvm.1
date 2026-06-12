Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1D3D6682
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305281; cv=none; b=FUhY9JC3c0fBV4U5vhjos8U+rZjl+bVb0Rz8vLguQo+x6swIu9KN7C2OCqoVRp+cSys1/j5A7C4+O8ORCi70LfFEP+ii11cTIqCpD7B5O3XZu5vNaI61W1jvHA1zBfbqcsonDV7QNpKtquSH0VM8TnZqolQhoP5UD6g2ZFdQoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305281; c=relaxed/simple;
	bh=DKAqswpPaExUn02wUL+NOxMfuWixP3sOTmVCG3euVIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OZ+qZf7kO9/KVmHj6qb0x3Qzw3jh17f1vYsthN6DxqGbREHjzhc7yInd+X//JpRi62eaDQndsvBjhwJn6iF0b415zPq5GcPWUAZfcL4hTNHgPr5PyjNBDzjuLGyTo0H5muF2Yozi6iVYjN71uwEFoHbpn5zGTX7lnNGHzPd8qF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nh32vvNR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nh32vvNR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8426ed9f24dso1580723b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305280; x=1781910080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J359yHegu9UkwwiKsAhLDZGnRJ5TMvYWdSC1Vkojkx4=;
        b=nh32vvNRDnkBXvEU67+vZlEDQVNqMEaVq23Zuns5gefbqbi3o+EuXBitCkkYs05ZpI
         ziDip4am++2OTjw6+r6bqKa/iYvpbmzHXxN4jUrnm9nhzPboSPEJWbWyIUn3hFo9P2JW
         Ue+Lc1Pl7y9k5W37U8V+SCOPmw7LP1K8UdHNo8rTFIlRB5BPq5yk/UfPreyXtJjDiK2Z
         1b3+3A3MobNo+hw2Z3MCInZ8C6Bh0E2+7EiLdrjnc7rR4qpZO78Ba1J9MULLPs3fLq86
         i1xODl9bXrUSRTty1mDRZ0d4kitANTts2fuW6OMvKBX82S5rEDiAqz840rVU6SpqtLYT
         KDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305280; x=1781910080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J359yHegu9UkwwiKsAhLDZGnRJ5TMvYWdSC1Vkojkx4=;
        b=oXXN/4Hp7lvflrt+GcP/Ej4WQ9dGuxlXIAbPSzgM0SkTAaSLqY4H9j1ZkMFustmdRP
         yKHmpPBM0rByx2fSwxk0J38Vb7X+M2n8641HP7poHfJvKpQ1IOSx/kIDqYnNJhEUFCjw
         He7S4ndvRAxnrEoP/qCQxhxTCJryoegx5t1tHSfe0q8KnPbERFCN0tTeG0lGR+XROjrq
         yk6n8AyTSTAtdd/e4qW61BtZhWOHpGGn3BGjTakJ3VLSJof0BW4ufPpF2UAxEMEAsdhp
         onzW0JlLfg9X5dXOEW/LenVX4MV+IZCFrZP+pCOmrdkW9k2M9pXGoUFN/uHX+QU0EtCF
         fHZA==
X-Gm-Message-State: AOJu0Yzky2j/qnQjQ1WIy36d7KqaOvPWRZiZFhjHLzykohDvz0ui7kks
	f2v5C01PwkL+q15gcTGi/j4Y9ApV/OsUMzz5pAWXi7X+1iuyJQyGr7vw633m8r77Mr7uEaqfVDt
	LpFxsCA==
X-Received: from pfbfb1.prod.google.com ([2002:a05:6a00:2d81:b0:83f:420:c568])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2395:b0:842:499d:450e
 with SMTP id d2e1a72fcca58-843497500b4mr4466895b3a.20.1781305279654; Fri, 12
 Jun 2026 16:01:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:07 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-3-seanjc@google.com>
Subject: [PATCH v3 2/8] KVM: x86: Prioritize DR7.GD #DB over #GP due to
 illegal DR6/7 value
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

When emulating a MOV DR, specifically a write to DR6 or DR7, treat a #DB
due to DR7.GD (General Detect) as higher priority than a #GP due to an
illegal value.  While neither Intel's SDM nor AMD's APM says anything
about the relative priority, empirical testing on Intel and AMD shows that
the #DB has higher priority.  And for VMX, where the instruction intercept
has priority over *all* exceptions, KVM already treats the #DB as having
higher priority.

Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr registers")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 75cd8b6136aa..4484c5fa19e3 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3854,11 +3854,16 @@ static int check_dr_write(struct x86_emulate_ctxt *ctxt)
 {
 	u64 new_val = ctxt->src.val64;
 	int dr = ctxt->modrm_reg;
+	int rc;
+
+	rc = check_dr_read(ctxt);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
 
 	if ((dr == 6 || dr == 7) && (new_val & 0xffffffff00000000ULL))
 		return emulate_gp(ctxt, 0);
 
-	return check_dr_read(ctxt);
+	return X86EMUL_CONTINUE;
 }
 
 static int check_svme(struct x86_emulate_ctxt *ctxt)
-- 
2.54.0.1136.gdb2ca164c4-goog

