Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376840;
	b=IEshVuZdalQX+6tkGECgmk2bOX43DALApecIB3R2NI+a8T8FFszFjXwFZU8pbuTOUt3X
	 tgoIxImuvLAUkCG9AM35LHIAGIh7pBeg2PWEEnk1zPPUI+WfoHa7pPzpCYu37fX9xCxWr
	 zpGU9bQX60f8/waGHCbUErWB4i1XyQZ13bCrAoVQCrNZIwRR9Jo8w1WsPEu/HMTRhoX/P
	 EUw79DL8AXnCnWX1i87jLUXLp0eODfhwzpAr7c3F1EtIeCqYEJUndWBgjVvDVN3G6lNW9
	 pz3m410A+/++PFRP1fi++ZYVKZ4FC9/GIyR+UXDPwlE7ZUMaB5r5yWcgJFNSwgrGNDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376840;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Xinb0q2RhrG3aZtWkosSNECDDlqXXXklCJemB2uKTO0=;
	b=j4gLlI1Gce+R44zxOQihJc+mWRm6qLS58DwDicvWGOBHiyUS7nJfF4vXJ3R8QeWa7HJQ
	 HmKK6xcC2jFTrkczxwSOIoWa09gz9OeKcjFG4ytAyh6z9D9hh694bTtm2TakalNcxTqI6
	 JGI8ufi+Mu3Y8bsmGJVQ9t0//4pTUFMtdyOdee4b08VLVsm1lSCpGHu6mK/m2ez3siix/
	 jImx1hkbjQO/3CStTCyTi8aSFKf6mB3DFCniXg6KVCRNRh6xaEQHzfknn2npRcNuThPOP
	 dHP629jSPgVZJ53Bb5FkYDJyRDMPq1XhOPWR7/PxNH43Jo8cLbCF1y/m+gpqSgHASrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aJv5ozIY;
	arc=none smtp.remote-ip=209.85.222.100
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB360A382A
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFB360A382A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aJv5ozIY
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-998d151f441so735295241.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376839; x=1794981639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xinb0q2RhrG3aZtWkosSNECDDlqXXXklCJemB2uKTO0=;
        b=2ZucUydLOyMpo02PYRBEPeaIVDXLpUEgzzUhDKwZuca959l0ARzrmS2l/iZwnz9BtL
         19lgxMJUo1ZYsz0Ws7F1PQWtxfXYbi9sUBopO3wysWU0175aqkjaxfyXoojjPdlHqOmF
         Mq6tBdhJlinTIkcgkBbwhZ4YGpjH+8oZ4fYQzf7r9UUQBzg0ZJVFZ/NlELoOhXH+dn/H
         pgf78F/y4+w9fmiHzW7uGD2q8VrxbWvGCr0Y4VG5mJZnE2nlmfzl2qYTLW8PQ9TvqQWo
         /XcOXnvYihAC9ynDAgQzdaYb7YGF69x1FkCQgCrFPwIAoz1mglge6+fFRzDIFxhjFg7a
         gmDQ==
X-Forwarded-Encrypted: i=1; AL+hErESJSmi1aZ/e9KcnNrH83sKIqwTmyKAmG5BnZ9V1aXjnyZSm50UpHcpqpfYXxwSpp6opPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+viTFdDEqP2Ofmme+xuLXh0iiw9RSpt4TVclVEHMdk0JpMpoM3
	VvpjlKCnkWbLf8B6JtA+FLJALRBCkQ6spGiA5qDYC93v9nhttl1obN4jcqZsBh/s/hNg6K1ModC
	gyDzjwijJPk2QC4qciIGtkIsFD0XOdqtnGs4qv3UBKx3pssC0qJn/e0r2A/C+N/K2huW4UwV6qL
	HCgnPoLXTLTJqeT+DrWAaD1KeoiEtm/jkj21wRzxudFuyS4u7qrrLGqCUtnZsO12/L2+1dxbtkF
	etW
X-Gm-Gg: AYBFou24+mCat+ZYtPoepsfu5WSrIZ1a8HkXnx54k256xbSgJpzlu2S2Q/6CoAVtR+S
	A180tdTBw/oELsduxQzGzC2js7RIdMppWzKKh8stoQpwjWsVBY/Ga+pgGkX2HxBoV1t12hzZi65
	8QrIfxt2Xc90JrqZ05YiWCVnPk99TjFGF8D7kVRq0sGHBx7+e8GU3PLDbRurBtMgJpsJUBEp1e4
	I0rqrsng+LckExPSlTnV052mbRJFbkDFT/UR3YYS4fzS4jOpMshx2uKlI4OD7A0UvgVhtYDByDX
	KXOEOit2oBEyvUJOrHB+AEMjWyN4nbrp6pTKxPNC6QAJngZ5LP7ebxqCga+ll15+7yBonj37HuW
	b/qNsU1BcdZ0Gf5jW73+9wo4jfcY7AKIwr8htVyBxoCw0c5x+Iv3dQIInXGlHc/UZ+I5Nl7xhhy
	QXlcXUnB+M9Ndfaoht3Q1v5tYoVTCk8OLz
X-Received: by 2002:a05:6102:2927:b0:7c5:4da3:aefb with SMTP id ada2fe7eead31-7d50611c6f1mr353306137.34.1794376839096;
        Tue, 10 Nov 2026 22:00:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99c1fe74c03sm296888241.0.2026.11.10.22.00.38
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2373e9b4so346490185a.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376837; x=1794981637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xinb0q2RhrG3aZtWkosSNECDDlqXXXklCJemB2uKTO0=;
        b=aJv5ozIYRvdfCr8jUG6VH7DecLbe7I8ddpxe9bdPR+nDo3863D2cUY7UZtAQkDaQbF
         Pov+NfzK1lHUpg8Y2HRCXyyqb3ncq7zbIeRJqrdgEdKr2+fSf7intJguoPVE8SnlcXrw
         HysvVrdlRtFxca71lOH9M7TbE+U2jNwXgp6ME=
X-Forwarded-Encrypted: i=1; AL+hErGKDH0xfZb2luHr2TecQkgT4x1LbyI65EEd+4TfJl4qHX38q439RKiOggxJk+svi9p6S7A=@vger.kernel.org
X-Received: by 2002:a05:620a:1b94:b0:93b:d7a2:dd2b with SMTP id af79cd13be357-947b00082bfmr202737785a.59.1794376837347;
        Tue, 10 Nov 2026 22:00:37 -0800 (PST)
X-Received: by 2002:a05:620a:1b94:b0:93b:d7a2:dd2b with SMTP id af79cd13be357-947b00082bfmr202720285a.59.1794376836004;
        Tue, 10 Nov 2026 22:00:36 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:30 -0800 (PST)
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
Subject: [PATCH v3 08/12] KVM: selftests: Add helpers to run x86 guest code in user mode
Date: Wed, 11 Nov 2026 00:59:57 -0500
Message-ID: <e2a6f09d80b30aa2ab14f013f5b344156a7f89cb.1794374897.git.zack.rusin@broadcom.com>
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

Add vm_init_user_mode() and vcpu_enter_user_mode().  The former installs
flat 64-bit user code and data segments, makes the guest memory mapped
so far accessible to user mode, and gives the TSS a kernel stack and no
I/O permission bitmap; the latter switches a vCPU to CPL3.

The selftest infrastructure only sets up CPL0, but testing the VMware
backdoor requires guest code at CPL3, where the I/O permission checks
and CR4.PCE apply.  Provide the setup once instead of open coding it in
each test.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 .../selftests/kvm/include/x86/processor.h     |  7 ++
 .../testing/selftests/kvm/lib/x86/processor.c | 87 +++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 3e4351ccb359..f7fd4aafccae 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1310,6 +1310,13 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 
 gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages);
 
+/* Flat 64-bit code and data segments for user mode, see vm_init_user_mode(). */
+#define USER_CS_SELECTOR	0x28
+#define USER_DS_SELECTOR	0x30
+
+void vm_init_user_mode(struct kvm_vm *vm);
+void vcpu_enter_user_mode(struct kvm_vcpu *vcpu);
+
 /*
  * Exception fixup morphs #DE to an arbitrary magic vector so that '0' can be
  * used to signal "no expcetion".
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index ee8a1715d844..6099d386abe9 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -768,6 +768,93 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 	handlers[vector] = (gva_t)handler;
 }
 
+struct tss64 {
+	u32 reserved0;
+	u64 rsp0;
+	u64 rsp1;
+	u64 rsp2;
+	u64 reserved1;
+	u64 ist[7];
+	u64 reserved2;
+	u16 reserved3;
+	u16 iomap_base;
+} __packed;
+
+static void kvm_seg_set_user_code_64bit(struct kvm_segment *segp)
+{
+	kvm_seg_set_kernel_code_64bit(segp);
+	segp->selector = USER_CS_SELECTOR | 3;
+	segp->dpl = 3;
+}
+
+static void kvm_seg_set_user_data_64bit(struct kvm_segment *segp)
+{
+	kvm_seg_set_kernel_data_64bit(segp);
+	segp->selector = USER_DS_SELECTOR | 3;
+	segp->dpl = 3;
+}
+
+static void virt_set_user_pte(struct kvm_vm *vm, gva_t gva)
+{
+	struct kvm_mmu *mmu = &vm->mmu;
+	u64 *pte = &mmu->pgd;
+	int level;
+
+	for (level = mmu->pgtable_levels; level >= PG_LEVEL_4K; level--) {
+		pte = virt_get_pte(vm, mmu, pte, gva, level);
+		TEST_ASSERT(is_present_pte(mmu, pte),
+			    "PTE not PRESENT at level %d for gva: 0x%lx",
+			    level, gva);
+		*pte |= PTE_USER_MASK(mmu);
+		if (is_huge_pte(mmu, pte))
+			break;
+	}
+}
+
+/*
+ * Prepare @vm for running guest code at CPL3: install flat user-mode code and
+ * data segments, make all memory that is currently mapped accessible to user
+ * mode, and give the TSS a kernel stack so that exceptions from user mode can
+ * be delivered.  The TSS has no I/O permission bitmap, i.e. user mode can't
+ * access I/O ports unless IOPL allows it.  Call this after allocating all
+ * memory, vCPUs included, that user mode needs.  All vCPUs share the kernel
+ * stack.
+ */
+void vm_init_user_mode(struct kvm_vm *vm)
+{
+	struct tss64 *tss = addr_gva2hva(vm, vm->arch.tss);
+	sparsebit_idx_t begin, end, page;
+	struct kvm_segment seg;
+
+	kvm_seg_set_user_code_64bit(&seg);
+	kvm_seg_fill_gdt_64bit(vm, &seg);
+	kvm_seg_set_user_data_64bit(&seg);
+	kvm_seg_fill_gdt_64bit(vm, &seg);
+
+	tss->rsp0 = vm_alloc_stack(vm, 1);
+	tss->iomap_base = sizeof(*tss);
+
+	sparsebit_for_each_set_range(vm->vpages_mapped, begin, end) {
+		for (page = begin; page <= end; page++)
+			virt_set_user_pte(vm, page << vm->page_shift);
+	}
+}
+
+/* Run @vcpu at CPL3 using the segments installed by vm_init_user_mode(). */
+void vcpu_enter_user_mode(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sregs sregs;
+
+	vcpu_sregs_get(vcpu, &sregs);
+	kvm_seg_set_user_code_64bit(&sregs.cs);
+	kvm_seg_set_user_data_64bit(&sregs.ds);
+	sregs.es = sregs.ds;
+	sregs.fs = sregs.ds;
+	sregs.gs = sregs.ds;
+	sregs.ss = sregs.ds;
+	vcpu_sregs_set(vcpu, &sregs);
+}
+
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
-- 
2.53.0

