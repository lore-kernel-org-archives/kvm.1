Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAF1EE01A
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114193; cv=none; b=V4NcfNo2ck5f4Yn+1dxKN34u3O9tOMQtcHBUGPUTL9hM0KYjAZlmOBkq7wIsx7bl5qfO56sRkRUDL/9+V4U0m/mM4CJwREyZ07nuyUJmASiBHRue5WoesNv36TreL61ffUWDqJJAjefX9me6O4ozNeogiOQMaHZEXAacbbZcBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114193; c=relaxed/simple;
	bh=+5AU8rGamF1vecRbKjxWr/lQvmf6a9JLKGAu8xKx96A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lJD7vFXuW2aSk6GeP4ZTrfGwApcTUouItqNCvrVWExIcVr/6Sjt+6BOmEDK74nN5KKwvd5p62OIsTWxMGwizozXEWv550NCpN1op/wpaBD+KhDnDHo1UZhVSYj72iZ2nWBONSi6dLvTLssamiQMEvClQYLcIcZ4KerEOO8msBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJeO8H1f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJeO8H1f"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso7074055ad.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778114192; x=1778718992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYLKMfHFK1vymHGUXjRxxaujfJ3noxRqbCY5RNLKMH8=;
        b=fJeO8H1fSh6e4jWF26rByFHywRlXUaa3ZwoO6muRo8lbN/gZxEA+ephaXoQ8urUAsh
         krGbD85k5OxZuJXy3uffU/d8KqmXE5C7dRhBA93teTB9pwb5JTjetv80sprrf0nLBDBx
         FO/ymmYmvQ/HFeoBXtagn0VOSFZ6P50tn4oh3diUg1E5zx3wN2KN23JaD5dC0NbnvHDe
         z4UySFTaP1q4YvXFJ/ZQxZCwcfmFyv2dVdmeSuQgpnZCat2ZiuIpbkqRx0vwkhl/x2No
         NhM/3MyV/pghsjrT1/F21eXByhMqCrcBLMgVTsw8EDZ+kWReR6fd2gnmY8F0ioaEAXB6
         4Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114192; x=1778718992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYLKMfHFK1vymHGUXjRxxaujfJ3noxRqbCY5RNLKMH8=;
        b=SJ5p0y6/H8djmYz+H2nrjmH2YfSzWt+JRo+BpFe2LVjFd4iL++G84iZvyLwGitzDkG
         P75B+vM+8UuGR6xq/DftqTZITM7BBKfoop21PI5Se7JwK8KBJc02Zq+BJKDDH/A3b643
         cIVtB/p4tvqY+z5qYYQiOV9WDSuEp7YcVQ+9k87xLIyVSswzNvUjVWS8vXkMlp/cHlXi
         JST0R7CkEYvw/cc5xlOz4iQGdwt9cS9oDeofji5Al87Ufcs5yVr0nZfIuApYfmHxyZCD
         4E4y/AzcMrmp6Ql7dpT1nL91yNq5B566qr/ALV6Is5A4ZmPpKOEQVaJenF8FOOJwJtn3
         VD4A==
X-Forwarded-Encrypted: i=1; AFNElJ/UjzRWNLHiFUeiqv7k03hT8JYsBfFJVV7kbES/TD0lZlmZDDpBjWhHa7weqoZMVZI1OQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcPNgbEIJUibvW008KA57qPaNo4+p/cJby63g+HjxoGLuFAiJ
	Vt0TsrDiGtRhKQUPvKCvmb9XEn68ZdrcD+R2hzaUMwk98knivlfta54E+IiPfojeatMfcqAO35c
	8TgBy47w44SbkKj8+tJAgCQ==
X-Received: from plmk4.prod.google.com ([2002:a17:903:1804:b0:2ba:1011:efb7])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2bcb:b0:2ba:924b:3948 with SMTP id d9443c01a7336-2ba924b3b5bmr38996695ad.15.1778114191481;
 Wed, 06 May 2026 17:36:31 -0700 (PDT)
Date: Thu,  7 May 2026 00:36:13 +0000
In-Reply-To: <20260507003613.1784851-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507003613.1784851-1-vannapurve@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507003613.1784851-3-vannapurve@google.com>
Subject: [PATCH v2 2/2] KVM: TDX: Set the has_protected_pmu flag for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

TDX module virtualizes PMU for TDX VMs[1]. Host has following
toggles to control the PMU functionality exposed to TDX VMs:
1) Configure TD_PARAMS to allow guests to use performance monitoring.
2) Restrict the TD to a subset of the PEBS counters if supported.
3) Limit the TD to setup a certain perfmon events using basic/enhanced
   event filtering.

KVM will need to be enlightened to support these toggles.

Explicitly set the hast_protected_pmu flag to avoid KVM trying to manage
PMU state for TDX VMs using existing PMU virtualization framework.

[1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..eb4b4518e6f0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -638,6 +638,12 @@ int tdx_vm_init(struct kvm *kvm)
 	kvm->arch.has_private_mem = true;
 	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
+	/*
+	 * PMU support is provided by the TDX-Module (if enabled for the VM).
+	 * From KVM's perspective, the VM doesn't have a virtual PMU.
+	 */
+	kvm->arch.has_protected_pmu = true;
+
 	/*
 	 * Because guest TD is protected, VMM can't parse the instruction in TD.
 	 * Instead, guest uses MMIO hypercall.  For unmodified device driver,
-- 
2.54.0.563.g4f69b47b94-goog

