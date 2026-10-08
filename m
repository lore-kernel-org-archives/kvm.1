Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B11DA57
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442766; cv=none; b=VhZjmLYTarepxTavNUsQXLSbOr1ZeZYoK9SEz6y3jCahswFM9uT/hczelf77pG07gSihplEAPFQueLF+iRyU38Q7/t6FHvwDShqX+mf5JdcZYr5r7KooHxGOlZVw921q0k68mEpLkw/hlvAvwNk2GQ49dRR0dsOg1uJsJBIW1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442766; c=relaxed/simple;
	bh=w1q0ULCtDyQw8+eXPiAmYxWUeuFomhdI8BMyijb+1Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbFnzscodVnGZSeYe/UTiDo6l9dixFtHud86rBxno+I06nZRP3q11GL+QdSbTi0FwmW43SlxkNv8WGYXm50r/vN4SGEvqKIt7ma0EgEg8RD+5J8tRv/Qbvegc+sjdOIUNbYlnZXRmepiE/Mz/c+S+qiL9owvoV7N3NZ/ueQCl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INh+BFnX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INh+BFnX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d6d28aa26cso24101445ad.2
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791442765; x=1792047565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSPZZkGHrp5CxODDPaVZCr0pX8ohqduvnvKbHP0JWiI=;
        b=INh+BFnXMuBTG0d/zoBQjiF/QevpVNwwxIQpVoFlZIBOsm+t0pcu8tHTuIu5vMs6Lh
         bJFrrEm5rRq8XWQlntBlRU8w9Vtp+bKfOo7Dgb6daV001LFuidSwsFhMnuupjSt0buXW
         QLZ6/h0Sbuf4kYaPnUki0rtdfF2boDt20D8FR5098kzBSCCJVG9SaMT+WLjkOLYjOxpq
         P8TmiEVmXbhSicmTjSxYjvsqdz9MDY33CdZF2dIUMVV/88V9+ExT44bYDu7dAOlUxZSb
         0aWT3P6lOVTdcZgeYRYoK/dm7LAcS5pWHy/k//PdN/ljXHBk6iP7Nd0atLBfgHyFdjbC
         9J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442765; x=1792047565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSPZZkGHrp5CxODDPaVZCr0pX8ohqduvnvKbHP0JWiI=;
        b=XRvNyuhUlcfWsxXDt0K9VhHmXzq/QilDRD/YgYAnw/UsxIxMKMEYyiqR+lA3tQkTAF
         2qLbu+Pi6QFt/NcsYkn6zB8tUifmiNbCVrCPUo41kjx/3PAcwzbwHlQNp7ywNAC6He3b
         1nu9iXkrH/DX/Gb1XhxD3Dlm8mwNLX8P59KfSjNeoFFZrjF7zvsJx5o3dp2heS1YLtH2
         FxVA7X7IP0E2oNYIASjxj+dmXm/kW82uyDivzwz7jv0wkGsLJ98iL1ztz6V16fqD0CTk
         j8txP+m9QtxQjLw0Gjw+Q+UWEICiqcJrtgA74INQzqDpkwTaqEjPM+72GxaEX9dLn7s4
         WPPA==
X-Gm-Message-State: AFq9FYKFnYVuK/RX7ZjY6PIXXLo3Ky9X13ANykFUPYRQ15HeQcBIqg2a
	1udbjprUHwq7n4dlXAmD2nDi/oHpcaHqLacyWPaLUjXodUFNaZd7KLkD
X-Gm-Gg: AYBFou2me2BG4kwy9eq2GrJOdQIlwIw4YP99znjGxggtJ75Lhe5xCpfP5I5E9B15k3H
	p6/xNQLHIXsSwInnv9XZmvbgtZlGxuPOIUePnhDDjUnxLrcvNnagLDc+YRrKEvUiPCF27CXYMSJ
	SdFoOnmzN/FeLWZz3u4obiXi682gApkJQkIrN+RYJmx3iwrjRXO1aGaY8qtflEfnRaPo/8MKaQP
	zWUP1l8ubjEB1JSzspR25NFr60Zdhjk8xmm+g8ljwzr4rtfrGYOIklg011sBsWKlNCM7UWWeZr5
	nDdFFlvtH+X0/S2mStVWtDF+TjQq/pdvb4AXszCo/MeCAeog+YrTIenfy9Em/7z4uCmaRGDqyfe
	acsXFffjozXsGogPNiUWCwLQ2l7YH4wCxk7MGDyooIXCpiWRk03xM+WxRLLoRVqJ10in4MrXWT/
	X2H3UcH8rN0TG46zQ+402jKos592chk3cFSbjSmmKxni0K/UzHaaksJ/9zkw8T1K4LLaevPe8Zm
	qZGrNouolqhSKSAoeLG6Id+bVS5viSlqwWLhk9Z5g==
X-Received: by 2002:a17:902:d481:b0:2e4:b218:f6a3 with SMTP id d9443c01a7336-2e600570c3fmr38415345ad.51.1791442764825;
        Wed, 07 Oct 2026 23:59:24 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604a573c5sm20116425ad.76.2026.10.07.23.59.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 23:59:24 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH] KVM: VMX: Remove redundant CPU_BASED_TPR_SHADOW check in nested_vmx_check_tpr_shadow_controls()
Date: Thu,  8 Oct 2026 14:59:20 +0800
Message-ID: <20261008065920.56705-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function returns early at the top if CPU_BASED_TPR_SHADOW is not set
in vmcs12, so any code that reaches the warn_on_missed_cc block is
guaranteed to have CPU_BASED_TPR_SHADOW set.  The repeated check in the
if condition is always true and can be dropped.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/x86/kvm/vmx/nested.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..a1f8adefbe35 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -619,7 +619,6 @@ static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 	 * if userspace hasn't yet configured memslots during state restore.
 	 */
 	if (warn_on_missed_cc && vcpu->wants_to_run &&
-	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
 	    !nested_cpu_has_vid(vmcs12) &&
 	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES) &&
 	    !kvm_read_guest(vcpu->kvm, vtpr_gpa, &vtpr, sizeof(vtpr)) &&
-- 
2.43.7

