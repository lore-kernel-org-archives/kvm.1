Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376831;
	b=h4bvAzHu3hhH8Ga1HL2zNS5++cTFbG5YmezxiIjcLntGtIpiDBpovVHI1A2U7NO6lf8h
	 RwodupzGjK0ZGvybkAakjhqsLj7JNxW2D1RyWKWMN1vaVfYDI2tl/hoLGvpeoVKUmBLDW
	 icCttXKRWsZ4SWR5dfKNFk3oG//N1BXvqPFL/gyLBNZm9xJDf8/IgFDmmw01vaBYEvQ99
	 BTX5CrKwKoUfroKrC4mXgcxEyHkvutbLj4KHUM1wSb9nyd5wl4uge9Xq2m+pX7kvezVom
	 +WmcQ8XU4k0S+oKSeqdRecGU71MWonKffV+ocDZnDwzFR7DPId/Iv1jDzJgZqa3DNJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376831;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=3Egu0aarvyKFqIJa8pv1i54wDTcaz/g4zz3JqRd/Qbs=;
	b=sMFD+QDthNw/uMrJacQqXKhVGf90VPbaPc7RkkILYuHknY7ad9t1ErejbX193LxJkOju
	 D65I3DkP7WC7S5c/HiZSsxxN062XneAVKlICSr1PqCEuOevJ5hkpXRvO2aCWq9T0RBYC9
	 fdcm5I3AMcVvOi6UyL7wziiw6QYtPIpdHmtJDvEiAR2+4W8YdIF1eaqBjUt/wBdVIQC8s
	 LYxZ39F8tfdHHHk9+n5Oegpw2EVPf+NlqDS6zBxBcDrwfoUXXfX1SNq2ebS0vqwwAxNNe
	 fA2mtctAgm+4jl3JRAqdhlRkneVDOef0cKF0fWxCJ9gsH523ma/GE/nvl7eqqB4z3ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HQj3Sb3N;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795FE60A3814
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795FE60A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HQj3Sb3N
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so1702674a91.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376831; x=1794981631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Egu0aarvyKFqIJa8pv1i54wDTcaz/g4zz3JqRd/Qbs=;
        b=gUi84+YUfdpePcpjUJ05qxXbY+5twkNBC98oqw2kQGQMrWfxQgrA70/8vv6AsZ8Ug+
         miX3eNh7ISiS+K1T4GHVW+hUHq5z9UQcS9XX+Wj7ZqIBDFJQMYLwCvB2sDx3IJfMGB7i
         GvyxcOCN+Oxm002wHlrSaVbDhmmkuKvslg47TS3hQfVUBUxYExzMn7XGUJxtAOaJacjH
         EGbnT9NX9Ff9zZROf8DNPl93oD1nVsZZ6d7dDnEFUAG0NMPXzDkknFgBFS1j/I5Ge4ww
         u4oB52Y8XXomgCOqO5brMbweSfPiRB+SgfxDCfoUU9akU/4LtiyvdKN92PuGTXe0RJ9r
         AKuA==
X-Forwarded-Encrypted: i=1; AL+hErH1IVamwF3+9UWqwGxRWKHio0hs54Pm0k4ZGr2ZBP7JIfLFcgOet4WrLmjEmFXNRnTIcL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hW4TXZimscwOLw9PuF/6pQurw5kradEWFwxohcZ8HIVm169AM
	zSfUdCbHTv3wTEnEGcMojqUS+n3wqiqmmMAgfi3cOyQt+PJMR4U33fPCdoG0OZFjVum65w4xtoz
	F/24+5oGhyrXKxHaRqBRI3otPIB9Z18yTHgxvlJpJ1EEGNOtUn6LhbJeB9iFp8QqNmY1r+SfTOW
	RTIW3VSq1dRE1WpVv321JMYLcLOKg3v0U8aQs2uuuazWgxPW5TXm13RtUy8YFp+vXmM6zAFYfTf
	M6R
X-Gm-Gg: AYBFou3yUW0E/kD09YoNNu9Wq7wajg5RhxR3fjlC7Akz2OuQyDFsm5dDYe5iXwr47td
	OKc/qgp8vWSxitOTfhyZdel0+oFN9KQd0jkZZ1jT0w73vbnDjf0HUHwwWVQrcHj8J44yl98DZEy
	r6PUSeoyxrL7uoWVpZrDPF14fgTavX2Z/MeF+nQ/ITtA54cJflxMKS2nU/pMGwBF9ghkvS4Ksjm
	AJnDjQ9KZ2bCo9y14nzIzyECFco5ls8RtzP5tqfO/paRASDU6fRNhQJ0aYr8AWCd3nI4XJBvpDi
	HBLobHJRuHUNP7MhCsAbGPVFX8fKsnLkNjaFrV2H9VW3gg0Mqd3wVNbcnJLmlxQPoFprTPF7EZk
	bL4MyYnQR7gzemA0KMzm6lVYqTEdrUBzxLNPDw55NVVtvuVsQhHV/FH3v+5imeeJ9RcR2+nnJ/t
	TFW8xEN/EBmHCLJii/NdWEMP0GWMHWUrQ9
X-Received: by 2002:a17:90b:3ec1:b0:3ac:74b3:a8f3 with SMTP id 98e67ed59e1d1-3b182efb251mr1386542a91.44.1794376830613;
        Tue, 10 Nov 2026 22:00:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17e0dcaf8sm1370898a91.3.2026.11.10.22.00.30
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94607500fb0so467933085a.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376829; x=1794981629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Egu0aarvyKFqIJa8pv1i54wDTcaz/g4zz3JqRd/Qbs=;
        b=HQj3Sb3NjqIVmRPCKouHOUYEl9PVWg8h83b0bWyL7WFcFr2y2ExFiqckDrCvbByX9l
         e/7dUVQF6PM1wZPK7z10fTxOys0ELygJaY2/fu9ZvpJ1KoI3Nevlne9PJaVnjjwlGwO7
         HgIekqA6uO+VhddzPvUVOQ+GlKrJaZ6UnGKd4=
X-Forwarded-Encrypted: i=1; AL+hErGgbM7CZ9vBw4a4IN3gKvkeMwIhXWIjtJOQfdE8QqSF5PksWSScAJmedx/xg1UjdpEl3IQ=@vger.kernel.org
X-Received: by 2002:a05:620a:6cc3:b0:93e:c12c:f11e with SMTP id af79cd13be357-947b00a6dacmr229303985a.74.1794376824110;
        Tue, 10 Nov 2026 22:00:24 -0800 (PST)
X-Received: by 2002:a05:620a:6cc3:b0:93e:c12c:f11e with SMTP id af79cd13be357-947b00a6dacmr229299085a.74.1794376823652;
        Tue, 10 Nov 2026 22:00:23 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:19 -0800 (PST)
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
Subject: [PATCH v3 05/12] KVM: x86: Add a unified VMware capability
Date: Wed, 11 Nov 2026 00:59:54 -0500
Message-ID: <80b2f51ddabc3824b83da48fc0def984cf808965.1794374897.git.zack.rusin@broadcom.com>
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

Add KVM_CAP_X86_VMWARE, a VM capability that takes a mask of VMware
interfaces to enable, with KVM_VMWARE_ENABLE_BACKDOOR enabling the
I/O-port and pseudo-PMC backdoor.  KVM_CHECK_EXTENSION returns the
supported flags.  Track the flags per VM, and keep
enable_vmware_backdoor as the initial value of the backdoor flag.

The module parameter enables the backdoor for every VM on the host,
whichever VMM created it.  A per-VM flag lets VMMs enable it only where
it is wanted, and the module parameter keeps existing VMMs working.

Use one capability, so that the hypercall and nested-backdoor flags
added next share its validation and rules.  Accept flags only before
the first vCPU is created, because vCPU setup configures #GP and RDPMC
interception from them, and don't allow clearing them.  Limit the flags
to bits 0-30, as KVM_CHECK_EXTENSION returns an int.

Enabling the backdoor for an SEV guest still doesn't bypass the guest's
I/O permissions: KVM doesn't intercept #GP for SEV guests.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/c60b32a3-e699-4a8c-8d52-09b34c4d5269@redhat.com
Link: https://lore.kernel.org/r/aAjrOgsooR4RYIJr@google.com
Link: https://lore.kernel.org/r/aAkgV3ja9NbDsrju@google.com
Link: https://lore.kernel.org/r/aIEkrc7Mdf2ia1Mm@google.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 Documentation/virt/kvm/api.rst  | 26 ++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h | 11 +++++++++++
 arch/x86/include/uapi/asm/kvm.h |  2 ++
 arch/x86/kvm/vmware.c           | 20 +++++++++++++++++---
 arch/x86/kvm/vmware.h           | 31 ++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c              | 17 +++++++++++++++++
 include/uapi/linux/kvm.h        |  1 +
 7 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index afd4fcac6ecd..57517ebd4340 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9185,6 +9185,32 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
+7.48 KVM_CAP_X86_VMWARE
+-----------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: args[0] contains a mask of ``KVM_VMWARE_*`` flags
+:Returns: 0 on success, -EINVAL if unsupported or after vCPU creation
+
+``KVM_CHECK_EXTENSION`` returns the mask of supported flags.  Userspace can
+enable one or more supported VMware paravirtual interfaces by setting the
+corresponding bits in ``args[0]``.  Userspace must ignore supported bits that
+it does not recognize.  Flags may be enabled only before creating the first
+vCPU and cannot subsequently be disabled.  Because ``KVM_CHECK_EXTENSION``
+returns an ``int``, VMware flags are limited to bits 0 through 30.  Advertising
+additional flags would require a new query interface.
+
+``KVM_VMWARE_ENABLE_BACKDOOR`` enables KVM's emulation of VMware's legacy I/O
+port and pseudo-PMC backdoor interfaces.  The ``enable_vmware_backdoor``
+module parameter remains a compatibility default that enables this flag for
+all newly created VMs.
+
+For SEV guests, KVM cannot intercept #GP to decode and emulate a backdoor I/O
+instruction.  Enabling this flag therefore does not bypass the guest's I/O
+permission checks.  Privileged backdoor I/O and pseudo-PMC accesses remain
+available.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3efef3415f8e..4b8b1498be80 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1116,6 +1116,13 @@ struct kvm_xen {
 };
 #endif
 
+#ifdef CONFIG_KVM_VMWARE
+/* VMware emulation context */
+struct kvm_vmware {
+	u64 enabled_caps;
+};
+#endif
+
 enum kvm_irqchip_mode {
 	KVM_IRQCHIP_NONE,
 #ifdef CONFIG_KVM_IOAPIC
@@ -1257,6 +1264,10 @@ struct kvm_arch {
 	struct kvm_hv hyperv;
 #endif
 
+#ifdef CONFIG_KVM_VMWARE
+	struct kvm_vmware vmware;
+#endif
+
 #ifdef CONFIG_KVM_XEN
 	struct kvm_xen xen;
 #endif
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 00ce265391e1..57167683692b 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -965,6 +965,8 @@ struct kvm_hyperv_eventfd {
 /* x86-specific KVM_EXIT_HYPERCALL flags. */
 #define KVM_EXIT_HYPERCALL_LONG_MODE	_BITULL(0)
 
+#define KVM_VMWARE_ENABLE_BACKDOOR	_BITULL(0)
+
 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_SW_PROTECTED_VM	1
 #define KVM_X86_SEV_VM		2
diff --git a/arch/x86/kvm/vmware.c b/arch/x86/kvm/vmware.c
index e1062144b750..3136e2971afe 100644
--- a/arch/x86/kvm/vmware.c
+++ b/arch/x86/kvm/vmware.c
@@ -19,11 +19,25 @@ module_param(enable_vmware_backdoor, bool, 0444);
 #define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
 #define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
 
-bool kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
+void kvm_vmware_init_vm(struct kvm *kvm)
 {
-	return enable_vmware_backdoor;
+	if (enable_vmware_backdoor)
+		kvm->arch.vmware.enabled_caps |= KVM_VMWARE_ENABLE_BACKDOOR;
+}
+
+int kvm_vmware_enable_cap(struct kvm *kvm, u64 flags)
+{
+	int r = -EINVAL;
+
+	mutex_lock(&kvm->lock);
+	if (!kvm->created_vcpus) {
+		kvm->arch.vmware.enabled_caps |= flags;
+		r = 0;
+	}
+	mutex_unlock(&kvm->lock);
+
+	return r;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_is_vmware_backdoor_enabled);
 
 bool kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port)
 {
diff --git a/arch/x86/kvm/vmware.h b/arch/x86/kvm/vmware.h
index 5951e419e1a7..c4ad1958a4da 100644
--- a/arch/x86/kvm/vmware.h
+++ b/arch/x86/kvm/vmware.h
@@ -6,13 +6,40 @@
 
 #ifdef CONFIG_KVM_VMWARE
 
-bool kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu);
+static __always_inline bool kvm_is_vmware_supported(void)
+{
+	return true;
+}
+
+static __always_inline bool
+kvm_is_vmware_cap_enabled(struct kvm *kvm, u64 cap)
+{
+	return kvm->arch.vmware.enabled_caps & cap;
+}
+
+static __always_inline bool
+kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
+{
+	return kvm_is_vmware_cap_enabled(vcpu->kvm, KVM_VMWARE_ENABLE_BACKDOOR);
+}
+
 bool kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port);
 bool kvm_is_vmware_backdoor_pmc(struct kvm_vcpu *vcpu, u32 pmc_idx);
 bool kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode);
 
 #else /* !CONFIG_KVM_VMWARE */
 
+static __always_inline bool kvm_is_vmware_supported(void)
+{
+	return false;
+}
+
+static __always_inline bool
+kvm_is_vmware_cap_enabled(struct kvm *kvm, u64 cap)
+{
+	return false;
+}
+
 static __always_inline bool
 kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
 {
@@ -39,6 +66,8 @@ kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode)
 
 #endif /* CONFIG_KVM_VMWARE */
 
+void kvm_vmware_init_vm(struct kvm *kvm);
+int kvm_vmware_enable_cap(struct kvm *kvm, u64 flags);
 int kvm_vmware_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data);
 
 #endif /* __KVM_X86_VMWARE_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0548e34bf634..1425376b4f0e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -118,6 +118,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
+#define KVM_CAP_VMWARE_VALID_MASK KVM_VMWARE_ENABLE_BACKDOOR
+
 #define KVM_GUESTDBG_VALID_MASK \
 	(KVM_GUESTDBG_ENABLE | \
 	KVM_GUESTDBG_SINGLESTEP | \
@@ -2428,6 +2430,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_READONLY_MEM:
 		r = kvm ? kvm_arch_has_readonly_mem(kvm) : 1;
 		break;
+	case KVM_CAP_X86_VMWARE:
+		BUILD_BUG_ON(KVM_CAP_VMWARE_VALID_MASK > INT_MAX);
+		if (kvm_is_vmware_supported())
+			r = KVM_CAP_VMWARE_VALID_MASK;
+		break;
 	default:
 		break;
 	}
@@ -4262,6 +4269,14 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+	case KVM_CAP_X86_VMWARE:
+		r = -EINVAL;
+		if (!kvm_is_vmware_supported() ||
+		    (cap->args[0] & ~KVM_CAP_VMWARE_VALID_MASK))
+			break;
+
+		r = kvm_vmware_enable_cap(kvm, cap->args[0]);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -9936,6 +9951,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm_apicv_init(kvm);
 	kvm_hv_init_vm(kvm);
+	if (kvm_is_vmware_supported())
+		kvm_vmware_init_vm(kvm);
 	kvm_xen_init_vm(kvm);
 
 	if (ignore_msrs && !report_ignored_msrs) {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8dff2fc1972e..e43c15c6e5cc 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1000,6 +1000,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_X86_VMWARE 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.53.0

