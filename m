Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376825;
	b=XBjpnRI38aMKC+wZpIpgcw5Ol049zvwkES9z1Ptmfdj5+wRF86D5J4DjEitgE0H2SXgU
	 0Vw+B557raZsqNiWmpHhTAM2JxyaTPbhsvlRzmZSX/5Y7FO3Bo8jz/YvTx03BHG1fJCid
	 SS48HzZ5crxCXeDlpEXrxg+JOyfoIyKMKGwOXnaMUp+pps/Ne7EFt+2FsqdaX02YPfias
	 LuL7mh7UwmTJ9Cd0pmEWcneDkkgYAzn0yGAY60gqwzCTCiRjzhP4C7tAjnjPiL1MehgTa
	 li1wViTnCl+n40tAS+baAO6u36JgjcNDYhPFqB+n0QUe/zB/1mWsj9iMqv+AhVzksyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376825;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=B1ce/0HX8S5HEpDkr1kWRGR30QWdYXAqQvY9XUkGSaI=;
	b=U7RgT/JCGNCMvd58/QXqDfTTAisds3pTMrYWNjC4TXB6cHNMTuQHb8sF1AKjxHtFVSjy
	 ANPWhnhwkFIrxrGv1bDGvXugAROTGLUHesuQcLnT+qNPXLa6rjO77FdUmc+3QwnDLfmu+
	 ZqOqjMQKKEogWHiT4ZbMrydn8bFqbSnRMLt9rMFfGDkG9NNQpYjcQ1AAGGsGXJPRtRuVb
	 LVxKvtTinHRHP8DEHabcZirHt26MzGyBpjhPyCdEQ1HioB8csDHJThsj4ehGD7rpPrE4D
	 7GKHsVw1yhtC6TAT4tHLa8IYv4SgH0K2I5LpBlMle8OjUjzpKd/oeN2JHOIykbTFsgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=eEXYk31Y;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDFA606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBDFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=eEXYk31Y
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b18717a193so48903a91.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376824; x=1794981624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1ce/0HX8S5HEpDkr1kWRGR30QWdYXAqQvY9XUkGSaI=;
        b=tPa6erlJ0WuKxxNW5C8T6etcG4UdMHfHD8Y4QzoN+GYd6oQLJeHTL74rblRwLHBGzd
         VTWH1lDjbL8J4L24hlYquuMRC8WuwGaOXVSWYXue1rQTUgE+E6BAq3XK/zKy1yCWFol5
         5Zp5YtixEm8w2oclzkqdgFPe/LID0u0pOwF7cKo2EP3/9i09yAyL1W2NDxBK3cgO/ZI6
         fhLn+fW9ZkYwBx4s2fv+KlYfoeJI8mnukKegqgCpu85bNc6GwjEyREoAXcnVw4Y1AysW
         NvtlWilDfVqyP7PvyP4K1bqYP+Jl08yJgNHlcDOgpxYApKmKBYqJKMfIKkTIOZ7LbnkU
         fjTg==
X-Forwarded-Encrypted: i=1; AL+hErGxoK3XZzYEV026oEwDCcegVMRlUd9dSznpTsEl/nSkiQDFpZALz3ZbbTvbhAseUETbRRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KYG/9JNAZWCAqi3iTv82/eY6OQ405Tf3TTWDVGClrTC81q77Y
	PlOkVXlrPaHrDnvEnnZ+4h7/pBr40P8NzpXRQuobejOokrFdSJHUXvV+sRUIpVV/eDa9LgO7MF+
	xpW2aLz3wOnpb5aBixoKlmERgcDVc0BKa45E3ztjk677FeLvegXloCaTA/8mRGng6WzVJxxCRJ3
	VhVA+VD7NO3tdAQOx2GKz1xmy4z/nNe4EmOJtfOcCh4IWs0yJc8N5JlO4+CBhcInlkfbunQaGTz
	a76
X-Gm-Gg: AYBFou2LHY5kJQIlPJguV0O6aOQqf2OjSuQtPE9yq0doEuUAu5N7P7pBN0T5YtS1QLE
	4OIu7h2NbPajyMfbKhfY+pp16K7n+tHKmyFQHVH6XN/11Nph5ef9tlPZn06cJqyq1+1T6RfSLfV
	1xlnARgJlyykazJKTiQZ/qllVCkHx5SnmMJSUTnUeems88phRy1582avrr/jbPVHZtPmNeuHy0Q
	GXu6OKol9AcNYEY8cv+oY8TFV97rqrfH45LRO8ZJOunO9x2iqyq9kbtlh8JV2BsX+QcAzW+/CXt
	0UO9khr2RaCou/YmakX5APnO8ClWDsrCN5+aNhNpLxzppSNltdMsyEymWlNS3l6EdYxv/Y7vDQ6
	+OPzogRphsHtfmSCC5ETnInP8fjHQ9twLa/9wuoFwZKZmWKwwiP4OqX+AgRhuNNtxGn04OxJK2W
	VHJCN9fE84j23Gv7I0aUYGd01JmBNTj3dw
X-Received: by 2002:a17:90a:f944:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3b182df3928mr1635136a91.5.1794376823928;
        Tue, 10 Nov 2026 22:00:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17e0dccfesm1362347a91.4.2026.11.10.22.00.19
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-944138ed63fso504011685a.3
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376819; x=1794981619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1ce/0HX8S5HEpDkr1kWRGR30QWdYXAqQvY9XUkGSaI=;
        b=eEXYk31Y59QvB7FFwA7cpqH+2aYm2BZjEpZL282J/viycgz+4quQqNbSZGuCFevoNZ
         IWgMbXGeaD6/ZEC8oajLb1+phJRuw4vi6elXc7NHejBfNzUYTnZ7Ei/cQd0lRu8C9qRU
         T3hPnziGo4AysJ2pVOBll5blaOs/jf9VbDn/I=
X-Forwarded-Encrypted: i=1; AL+hErENZzBN7LvwAatCnZ5dLqb4eZaSFxHZCbVT8KuglvbI6gG1IGUPjOpNrQ7R7pb2a06uXKI=@vger.kernel.org
X-Received: by 2002:a05:620a:3955:b0:93b:d7a2:83cc with SMTP id af79cd13be357-947b001b12amr197202485a.59.1794376819154;
        Tue, 10 Nov 2026 22:00:19 -0800 (PST)
X-Received: by 2002:a05:620a:3955:b0:93b:d7a2:83cc with SMTP id af79cd13be357-947b001b12amr197197385a.59.1794376818670;
        Tue, 10 Nov 2026 22:00:18 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:14 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Doug Covelli <doug.covelli@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 04/12] KVM: x86: Add CONFIG_KVM_VMWARE
Date: Wed, 11 Nov 2026 00:59:53 -0500
Message-ID: <f58eca0b702b6e57d87ca367a7693793e619d3d1.1794374897.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add CONFIG_KVM_VMWARE, defaulting to "y", to control whether KVM's
VMware emulation is built.  When it is disabled, vmware.o isn't built,
the VMware predicates are compile-time false, and the
enable_vmware_backdoor module parameter doesn't exist: a
kvm.enable_vmware_backdoor setting is ignored, and modprobe warns about
an unknown parameter.

VMware emulation is only useful to VMware-aware guests and to VMMs that
offer VMware compatibility.  Let kernels that don't need it, e.g. to
reduce the attack surface exposed to guests, leave it out, as they can
already do for Hyper-V and Xen emulation.  Default to "y" so that
existing configurations keep the backdoor and its module parameter.

Provide __always_inline stubs for the predicates that gate VMware
behavior, so that callers need no #ifdefs and the compiler drops the
dead branches.  Leave the operations behind the predicates declared but
undefined when the option is disabled: a call that isn't guarded by a
predicate then fails to link instead of silently doing nothing.

Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/Zy0__5YB9F5d0eZn@google.com
Link: https://lore.kernel.org/r/e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com
Link: https://lore.kernel.org/r/aIEmawm9gLflg8zt@google.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/kvm/Kconfig  | 12 ++++++++++++
 arch/x86/kvm/Makefile |  4 ++--
 arch/x86/kvm/vmware.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1719059570fb..b34d6d0e30c9 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -212,6 +212,18 @@ config KVM_HYPERV
 
 	  If unsure, say "Y".
 
+config KVM_VMWARE
+	bool "VMware guest support"
+	depends on KVM_X86
+	default y
+	help
+	  Provides KVM support for emulating VMware interfaces. VMware-aware
+	  guests use these interfaces to communicate with the hypervisor.
+	  Userspace hypervisors can also use them to provide VMware
+	  compatibility to their guests.
+
+	  If unsure, say "Y".
+
 config KVM_XEN
 	bool "Support for Xen hypercall interface"
 	depends on KVM_X86
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 0cb47cfc1162..794c847ccecc 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -6,13 +6,13 @@ ccflags-$(CONFIG_KVM_WERROR) += -Werror
 include $(srctree)/virt/kvm/Makefile.kvm
 
 kvm-y			+= x86.o emulate.o irq.o lapic.o cpuid.o msrs.o pmu.o regs.o \
-			   mtrr.o debugfs.o mmu/mmu.o mmu/page_track.o mmu/spte.o \
-			   vmware.o
+			   mtrr.o debugfs.o mmu/mmu.o mmu/page_track.o mmu/spte.o
 
 kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
 kvm-$(CONFIG_KVM_IOAPIC) += i8259.o i8254.o ioapic.o
 kvm-$(CONFIG_KVM_HYPERV) += hyperv.o
 kvm-$(CONFIG_KVM_XEN)	+= xen.o
+kvm-$(CONFIG_KVM_VMWARE) += vmware.o
 kvm-$(CONFIG_KVM_SMM)	+= smm.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
diff --git a/arch/x86/kvm/vmware.h b/arch/x86/kvm/vmware.h
index bf250cc6e232..5951e419e1a7 100644
--- a/arch/x86/kvm/vmware.h
+++ b/arch/x86/kvm/vmware.h
@@ -4,10 +4,41 @@
 
 #include <linux/kvm_host.h>
 
+#ifdef CONFIG_KVM_VMWARE
+
 bool kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu);
 bool kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port);
 bool kvm_is_vmware_backdoor_pmc(struct kvm_vcpu *vcpu, u32 pmc_idx);
 bool kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode);
+
+#else /* !CONFIG_KVM_VMWARE */
+
+static __always_inline bool
+kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static __always_inline bool
+kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port)
+{
+	return false;
+}
+
+static __always_inline bool
+kvm_is_vmware_backdoor_pmc(struct kvm_vcpu *vcpu, u32 pmc_idx)
+{
+	return false;
+}
+
+static __always_inline bool
+kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode)
+{
+	return false;
+}
+
+#endif /* CONFIG_KVM_VMWARE */
+
 int kvm_vmware_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data);
 
 #endif /* __KVM_X86_VMWARE_H */
-- 
2.53.0

