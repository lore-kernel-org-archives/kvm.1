Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1C3E40F3
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194044; cv=none; b=YzbmVg1tCG645dogTRPfj9+lOkX1IYoFsmoBm68rVdSeitqTwMJHrf8zJY1grNjousfsuo5EPcG1lQjwVkCDLlCQtCf8/bdLtGjGC/0JA8tXHC0p+bZAsKRGuyWe20vsOqYkonBffcgLINUetNST9ujgBNK+chmZjVps4vERd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194044; c=relaxed/simple;
	bh=TJMFN44RMWKDel2TE+CQLt0LjDr/PHIeLMqybD8DGk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOT/xoUQEp3ffzOpDlMUHyozXKOjtQMH9Nbg7XpK4qhbmBxg0B6cmPlcJgrWjz7wWgHCwoFNh2Q49cgL0iXh8AyyKuL48hhVWDNYBFlLLN4u4tGYZJFO6QHYUEiEWZrhllVKecZ0dghn2mSYW2NEV7EvqNfBRxth79hS6JNx3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxb6/Wv+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxb6/Wv+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so5528575e9.0
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792194041; x=1792798841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r1UFcyolx2df8n1PgORmj6GbMSmQ7olQG3p8HzmWRdU=;
        b=fxb6/Wv+gKvXDJO5r7z8G82XEQkWzhsMf8qaQiXvLw9Y+1OY9Po3T4RfyZ9cBC7qTe
         Y5mTfT9c9G/oh6xjc6I+BVQYCbkmq5F/BpIPoTDfJkJ15v61waZGjH6oirF02x6dSs+3
         eiDMUCliL/LOfVpibe8AVqbCOuGX8y49Tgus2qB3uWGxRVK+iXrHVDPGWvIXgCOHDxyj
         F6dEQjdpSeu88JIwXK9K3VTncAAk5Zmd5VZHWtXIFnAAbpg6dePwdayMHqFqBzpUX7Oe
         U1+Tb7BJ8qYlljyPMzxU5C38CAMbnEuAbrcXRjcawPSQ7ixuZUsbsW/kO8C3NXKIK5hc
         4eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792194041; x=1792798841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1UFcyolx2df8n1PgORmj6GbMSmQ7olQG3p8HzmWRdU=;
        b=Hy4aASPkFX5Bvw4xLcmsGah/YNb0Vh8u/Jaf1xAqH6Hbjwu533KkAo7obgmaqWuVAy
         gHug8Z5kwLTzoPzH9t0hPfcC6r0OG6VdjCUItUtLHAVSudIquuLxza9Jz/ujdLj8VuOX
         K6ZXIdMfiv2gVPV4txhIWOhgwurmP4cq7+Rl6EZ3rSSmk5qtv4ZFf/+fsKLxFjWx4gpD
         GwnaffTo+kxvF5KU0qMcvWhtebF3ZSaBvJZ9Ml2NQGtizg6BNi1NEH6TKc60ES53cnlv
         OLZ/yaSMVwBmzFe2zBk22M2M0JCu75n3ZhHQpDccQYE8MYggifNiIfQobNnSeGgaXOor
         ATuA==
X-Forwarded-Encrypted: i=1; AKwUvBzTiCOr2CNADChUgpRWZVQw9Qf6c1+7pjJvnexYWF1QiHWxMK9wKsRYORHXk24A+oNc0YU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn90iwGLmjReHU+j7+qIjzv10+sdl/G4qFHMmtrewriLTN2Xtl
	0YcvQij3R2wEZP9bzadYvaJW/G404lLwL5QTFfmRq/Mw/YHOO/pmjEDY
X-Gm-Gg: AYBFou071BLa8mmqWl3c4cTu1kpA0xD0BGSmkCmBXq7D3wmWlgjH7nWhnMA1gA4jQ5a
	O23AfrDPfjSkqm+IsyngJFY3DU28AQtbff9LjMQrXqgQ129iUxsPfncDU57VM8MwZZnsgyYACN4
	1kbmWSpTXE/HV9ELICY4YGGG0v7OOq52HZNyLLfcO1rBDKEhha6207ijXQ58xPJ1awOGFMGvmqJ
	LfOWwT+id6MbB/R5x6Y42FOIfqNCQcrzC0a9W+C6HsP+BNo9wbiIV02RgVb1Xm/YGjpP1SY0sOr
	v4s1DwaiaJiQDx4EeDY7tIZGyPklPcdhdOFSOev9koJSwMYNsA8ggDpQRQrZktsEZwHmse3zQJL
	pQ5K/gq8got5Ou4S8W52JnwyJCVyc6Va5FK7wBpSbchkgvA6f+e56DxwqEAdZ/6Tu/6S/qeBYnY
	b9eOnux21CNFyVYmYNvDLknuHun6F/Jp1El0nP7QC42RLXTTJDt1CftPnreiBRlv5MNvSnR5iEV
	ai8Jsm6OxXQnAxnEhU=
X-Received: by 2002:a05:600c:4ec8:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a1d76001acmr30283065e9.6.1792194040695;
        Fri, 16 Oct 2026 16:40:40 -0700 (PDT)
Received: from rio (145.176.116.78.rev.sfr.net. [78.116.176.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c0894sm7172224f8f.12.2026.10.16.16.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 16:40:40 -0700 (PDT)
From: Andrea Oliveri <oliveriandrea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	kvm@vger.kernel.org,
	Andrea Oliveri <oliveriandrea@gmail.com>
Subject: [PATCH] i386: Hyper-V nested sleep states enlightenment
Date: Sat, 17 Oct 2026 01:40:27 +0200
Message-ID: <20261016234027.1002275-1-oliveriandrea@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hyper-V running nested on KVM (e.g. Windows with Virtualization-Based
Security) allows hibernation of its root partition only if the parent
hypervisor sets bit 20 of HV_CPUID_ENLIGHTMENT_INFO.EAX. KVM never sets
it, so such guests report "The hypervisor does not support hibernation".

Add a "hv-nested-sleep" property that sets the bit. It is a hint
only and needs no KVM support. With it, Windows 11 26H2 with VBS,
HVCI and Credential Guard hibernates and resumes.

The nested hypervisor uses the bit for one more thing, on resume:
instead of writing IA32_TSC itself, it issues hypercall 0x103 with the
TSC and the parent reference time saved at suspend, asking the parent
to restore its TSC. KVM returns HV_STATUS_INVALID_HYPERCALL_CODE;
the nested hypervisor ignores the status and already compensates the
TSC jump in software, so the guest clock stays correct.

Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
---
 docs/system/i386/hyperv.rst    | 10 ++++++++++
 target/i386/cpu.c              |  1 +
 target/i386/cpu.h              |  1 +
 target/i386/kvm/hyperv-proto.h |  1 +
 target/i386/kvm/kvm.c          |  5 +++++
 5 files changed, 18 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index e1babffb0f..4b37d5536b 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -187,6 +187,16 @@ Existing enlightenments
   Note: enabling this feature on old hardware (without APICv/AVIC support) may
   have negative effect on guest's performance.
 
+``hv-nested-sleep``
+  Tells a guest that runs its own Hyper-V (Windows with Virtualization-Based
+  Security, or with the Hyper-V role) that sleep states are supported for a
+  nested hypervisor (CPUID 0x40000004.EAX bit 20). Without it, Hyper-V running
+  on top of KVM disables hibernation (S4) for its root partition: Windows
+  reports "The hypervisor does not support hibernation", and an S4 attempt
+  makes the nested hypervisor reset the machine. No KVM support is needed: the
+  bit is a hint only. On resume the nested hypervisor issues a hypercall that
+  KVM does not implement; the nested hypervisor ignores the failure.
+
 ``hv-no-nonarch-coresharing`` = on/off/auto
   This enlightenment tells guest OS that virtual processors will never share a
   physical core unless they are reported as sibling SMT threads. This information
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5da80ade70..9df628ed2a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10797,6 +10797,7 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_BOOL("hv-nested-sleep", X86CPU, hyperv_nested_sleep, false),
 #ifdef CONFIG_SYNDBG
     DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
                       HYPERV_FEAT_SYNDBG, 0),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7a88074c0..bff8b1d192 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2374,6 +2374,7 @@ struct ArchCPU {
     uint64_t hyperv_features;
     bool hyperv_passthrough;
     OnOffAuto hyperv_no_nonarch_cs;
+    bool hyperv_nested_sleep;
     uint32_t hyperv_vendor_id[3];
     uint32_t hyperv_interface_id[4];
     uint32_t hyperv_limits[3];
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index a9f056f2f3..df6ce6ae42 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -81,6 +81,7 @@
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
 #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
 #define HV_NO_NONARCH_CORESHARING           (1u << 18)
+#define HV_NESTED_SLEEP_SUPPORTED           (1u << 20)
 
 /*
  * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d7..76f1a37ea5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1630,6 +1630,11 @@ static int hyperv_fill_cpuids(CPUState *cs,
             HV_NO_NONARCH_CORESHARING;
     }
 
+    /* Only a hint for a nested Hyper-V: no KVM support is needed */
+    if (cpu->hyperv_nested_sleep) {
+        c->eax |= HV_NESTED_SLEEP_SUPPORTED;
+    }
+
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_IMPLEMENT_LIMITS;
     c->eax = cpu->hv_max_vps;
-- 
2.56.0

