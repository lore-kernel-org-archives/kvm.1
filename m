Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BAB295DA6
	for <kvm@vger.kernel.org>; Sat, 14 Feb 2026 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032432; cv=none; b=KYuQM6n0jSBfJVIfGo0TRCXRMe5EYeAoMgCs6ArUXw6YglGMSV1OgdQy4T4iPmpuvv/wlxFjYg1SAasiu2z9ez8UGGNBlCIRCNNPdAUbNj5XecJgMX0g7uauzycPwoUR8pR/8WRlbOYaMLMXPYk5rpgNJz2pnaYPDHyp4z04898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032432; c=relaxed/simple;
	bh=uHRBT0xtiTkIZnuHIJP94+r3B3sUuzdcITtjzmdIZxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHRKIatde2p37LezY0i5MNLxz3YvfItLdbHWnzGUkYz5VP6mdm3C0lN9pQPgtyc25RwsR3WLfwy4MF7zEnBIBX18y2X2+ah4viYAyHgjyk1dYPtFJg0J+50xps8gHwbV7iNqv/jprxOjn3A57jHudhPqAafrzveqtsybiwtxmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzbM1kmG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzbM1kmG"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aaeafeadbcso16553095ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 17:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032429; x=1771637229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RDtoclkNp4NWg025cIg81rPLzczzFSfFPqIQKO5nW/E=;
        b=AzbM1kmGvfonESNeM5gf/EkKtK14QmUOulaHH/TuYm86IiW+1usGe5/Qujy/9Z9M/a
         8StGD2vquyv9mlQC7jysNKFrluPX+TknqZFGe1Ia2f8yAmNnxqjOeJJwUBz7NQ3udBta
         u8GMB7uPEfjoH4ZSA2Yef2/TRr30VQdF/JJYwNOWUKF4ySU8JHoAsNdg5bXxq/xsugHv
         qEZS/yaLJUaWelLgwGTqgnBr/6QOeMVaDLw3vT9nZLGiAEQSFg3kyjAICWqhmcO9CiMe
         YB9r27WHLcdMkpTg7hLpP4/3WLt9Mv+jI6lVNxu+ZxvBaqyZC5aZhfO1dtMX3Jos/u9N
         rCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032429; x=1771637229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDtoclkNp4NWg025cIg81rPLzczzFSfFPqIQKO5nW/E=;
        b=FPJn4vtJvSGWkG7NXl5A4hh93ig5V9j6zYxc0NxxxaNGkVdZ/heJq+PHL8c2UKpv6z
         b4qJbaWs/WsJFOYYyHjso4euNjWKNAik29Y9GyIQVJ3gHXPoUUmyLLRM+3Yp7y6eiCHN
         7wdSEen7sT4lf3Z7yh4/1/VFoyyuD31sCl9ibukJRpCm3Izjy7TT1IlYiq5oXOr0y/Um
         g/DXtQMYbLMlWaC4pn4zgD819f0lgOb1sdAtmk9ovHfc5h7VakuY40kTldOnUtBGF76w
         QogPVl+N0JG8hYPsqbO98N45EtgtgHnGz0dTZNQWKRw5QHjrPLReqXn7hpFVcJXjEl3m
         2bNA==
X-Forwarded-Encrypted: i=1; AJvYcCVh0sGN8bEfhpCP861SUCTj7i/ejIucNljI5c2j4jnWhDjPgVHaSXW2C/i6CoEEYLjhvzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxboM6/cD+s//rZAflB7dGpSE4oXqDHmvF1kip7JVgecQlzJFm0
	kjhHy+39BLOZ4tMOdjeUcKdXJI3Ib9q4uxdx3dVjo7Mfb+XKcNv0jCi2qRXftP9KighRVtzj9Xk
	eqpeLMA==
X-Received: from plil7.prod.google.com ([2002:a17:903:17c7:b0:2a1:10fa:4a4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f609:b0:2ab:230d:2d96
 with SMTP id d9443c01a7336-2ab50521f49mr39916555ad.11.1771032429246; Fri, 13
 Feb 2026 17:27:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:48 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-3-seanjc@google.com>
Subject: [PATCH v3 02/16] KVM: VMX: Move architectural "vmcs" and "vmcs_hdr"
 structures to public vmx.h
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move "struct vmcs" and "struct vmcs_hdr" to asm/vmx.h in anticipation of
moving VMXON/VMXOFF to the core kernel (VMXON requires a "root" VMCS with
the appropriate revision ID in its header).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmx.h | 11 +++++++++++
 arch/x86/kvm/vmx/vmcs.h    | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index b92ff87e3560..37080382df54 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -20,6 +20,17 @@
 #include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
+struct vmcs_hdr {
+	u32 revision_id:31;
+	u32 shadow_vmcs:1;
+};
+
+struct vmcs {
+	struct vmcs_hdr hdr;
+	u32 abort;
+	char data[];
+};
+
 #define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
 
 /*
diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 66d747e265b1..1f16ddeae9cb 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -22,17 +22,6 @@
 #define VMCS12_IDX_TO_ENC(idx) ROL16(idx, 10)
 #define ENC_TO_VMCS12_IDX(enc) ROL16(enc, 6)
 
-struct vmcs_hdr {
-	u32 revision_id:31;
-	u32 shadow_vmcs:1;
-};
-
-struct vmcs {
-	struct vmcs_hdr hdr;
-	u32 abort;
-	char data[];
-};
-
 DECLARE_PER_CPU(struct vmcs *, current_vmcs);
 
 /*
-- 
2.53.0.310.g728cabbaf7-goog

