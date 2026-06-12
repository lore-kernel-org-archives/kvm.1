Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5D3D9DD3
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305286; cv=none; b=X554qIstBmaZHIFqGOGgut1XlKCamCnqxCfZYnEMhhsetMZ9Wu6jD1TqdJ24lFIE/xzquUwPMr4u1mVBZhY8Lesy3qT0SkuPTfTdi/I/PeYD30BWGqBeD1r7DE1/SKRlaXFQ8AxPrc/F6aQvGC5aT5dARD1A7Ig6llQLS8ozGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305286; c=relaxed/simple;
	bh=5C6qf+WMZTSamBGHJJJLCSrn6+uyn9X9x8vozOPXT0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f1S3ulHtWBUk2mf2156vkr920UFNCHtsZyaAGKlzT7g1pQuM6GJFt0sl9BdrR3unxbGBVQG5yvtCZT4Zd9NznqZw+8kCaA15CnPX7Rk/LxotlUlUUvLEEyMldwqYaL34wRupqO440xdlpOWUs8OTOWzIhj8WgDaP6hM2wPgcLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxhiPU2c; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxhiPU2c"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84238e83851so1004729b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305285; x=1781910085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oI8IdoZyF0d9Qscw9XaRoJ18jXQcaaF2K+3AKSglB24=;
        b=pxhiPU2cWbSeDCtWidVjXMLA7wSl8QqPevrFif38pkM1wR9XR9luK58mhq7aXvxVsR
         RFVmxguSbKzoKwnjZtIq5e0eCxmDw55Gk9kIBrud0m9QMym4HBVvsdZYbLKdQeqvYH6P
         2PqZZSsVMzqh7NQoGcBZKixwC1DsdskrGqUi0df7+bKsTbQ/xSgi8Ufh8D13c6xwmd+P
         ZT3MtM6vmRl6YSEtanROEvq/OhwEk8RiRzRH1GB2OuaB3VRvI/8ShgSVIfuZkPhfmbT5
         W8cQJxC68qFk5FYVaY/rbfvXJZYVaDcplUTu51AtZJuwbbtBDnNgqjMIf3dNqZnQZcWM
         yGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305285; x=1781910085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oI8IdoZyF0d9Qscw9XaRoJ18jXQcaaF2K+3AKSglB24=;
        b=fItFWfHYbYuRFncMeD91fOLkdqHlbuy98sAaPKRpPCG4GiNJzVwEympSWJznry8aWV
         5OcLWovEDjTuPy6A3vAMRJarsJSP6ITBKKhQCh3gmYxktUne7JSDyCyEf/Mlv7tQdg5i
         hDLfDTYRNIJKY/U8GJxV3fyxo3gxjAzNeTJ5fJVRGr36M8HCejHTaQDdrVq7jHorkwnf
         I7Cp1piv0c7af0Uj2DcmIm9KpA392FnxZSLga58fr4GTxn68ocrspl4FHQaD0cQOWkT/
         tTBbtvFHXZ2GxIyWBk9im9w/5mN2Ky0avNkik43F2MTjChSmjCylLktWK5wkIngGAayx
         BwGA==
X-Gm-Message-State: AOJu0YxktuD+hNpIaOI3FDgWrWG7+AOBTzT3qKk/vH+8Eq6p8ab0V2i5
	Qm4mSoO1cltFHgDbHJhTGmUHP8fG+A+SFCkDnHYyqwCpudbZuRUjVmOyAHxqxLXsVlvanx0tMTM
	Fnq6olA==
X-Received: from pfnj4.prod.google.com ([2002:aa7:83c4:0:b0:842:4a9c:2fd3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:450c:b0:839:12a7:70f7
 with SMTP id d2e1a72fcca58-844e1a59f93mr1723734b3a.31.1781305284425; Fri, 12
 Jun 2026 16:01:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:11 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-7-seanjc@google.com>
Subject: [PATCH v3 6/8] KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7}
 write values in emulator
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

Use kvm_dr{6,7}_valid() to validate the incoming DR{4,5,6,7} value in the
emulator instead of open coding an equivalent check.  In the unlikely event
that the behavior of DR6/7 (and their aliases) changes in the future, using
common helpers will hopefully make it less likely the emulator logic will
be overlooked.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b4dc57fe0bc9..b1799ed01939 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3869,10 +3869,13 @@ static int check_dr_write(struct x86_emulate_ctxt *ctxt)
 
 	switch (ctxt->modrm_reg) {
 	case 4:
-	case 5:
 	case 6:
+		if (!kvm_dr6_valid(new_val))
+			return emulate_gp(ctxt, 0);
+		break;
+	case 5:
 	case 7:
-		if (new_val & 0xffffffff00000000ULL)
+		if (!kvm_dr7_valid(new_val))
 			return emulate_gp(ctxt, 0);
 		break;
 	default:
-- 
2.54.0.1136.gdb2ca164c4-goog

