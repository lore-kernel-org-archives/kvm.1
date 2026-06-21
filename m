Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD711DF73A
	for <kvm@vger.kernel.org>; Sun, 21 Jun 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049034; cv=none; b=uARm07eE20cuJnDdtB7au8U5Iz5sDD7LlUcr57rgDf0L0ZOqj7m3i+6cURIubV7yeyn8A8qvi11y1YmbUP5Z/1tVEYGpb7KZfMPY+2WelKfwBIR/7/+1PBPC6ADQHtmigU5/THmlV9VLd6VSIoAwflOFQuNyIAkwQTJEOX2VF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049034; c=relaxed/simple;
	bh=NLiqqQbd0nuZHvNIEx/ul0iPC7D1YmexdsrbZf8BXGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6qGAX0W4Rk91TplNqdNg9H7vSjpVWaZBbI6TrFwQokL6PQrEP8tVJUUb3vptWp8qcj3zOPS+85+T1oYAFHzTrw4fIilLMEEI4vvTFhBEj/BYerW+BfrzZFzEUqf6k0Q4+1uOU4FF5YySVr+NxwuSGvvMloRHEWr4l49RikWBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et1C04bS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et1C04bS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4624c1409c9so2590690f8f.3
        for <kvm@vger.kernel.org>; Sun, 21 Jun 2026 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782049032; x=1782653832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP0yqHRYfBJp5yxz19nYmQRd2QACbGiclYFJG1pJklY=;
        b=et1C04bScdfH2HNIJzStUoRd4OQWh8WG67YESmPu03WjQeWg0L0ZAxZLd8yLaFdMVw
         BUUSSna9WjzX2lsn4GI1RwY5/5FUTOFZ04D9S/s/bKP6Owak2EcjWoDU086YFWS0gAfO
         tl7q2B6VN22CMihYcYM94pbdlFkfJNf2aZk9x/Hr3AxylrNyriUs5rB6LHcfbTxNeGtw
         HvrgV/Ou5/Bp5dXcTcVlULUK2mc2TU4apKc20pTnqT6+ShynLsN1dLbN8apF80JORcRB
         n9SvZCY0z3rMjRfd0C2lpRbJmCONKQBOer2DEnUo9DYI85fryYcv735V+HzPkAib9xwL
         DuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782049032; x=1782653832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qP0yqHRYfBJp5yxz19nYmQRd2QACbGiclYFJG1pJklY=;
        b=kGnhkIRCCHH+DIGXTZ2Cw7OOq/UZbp+LgjcvFdQvzphPMlKxLH60TswWGYe0UQfyDr
         kLnO0zZ8B765EHHHWwwVuH2WAPAaEdgLe4KK6sWWJIyAEbVJCRLdS1i/1KZx02i38y0o
         nrc6aNsaPNL488fqiprK5C50E+i7vYw4x3947LaSmIcXoYXqMWKadve6myw2Cnv76qRz
         hoBPOOoisvf84DeEz4l7s+myK9F7To9FpVLwDC/nUqdKq3NdYhxkTrLzSK3+O15fSK5J
         92/JWcH8sjRD+PuY0ElPuzRg0pp68PJOyJEeX3vZuC/XOESfbDtdDZqFr3aR5xxlSLda
         MJsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYhiuo77NZib5h6Er1qUEQNRYPDX8mIQoFJ2zRF4b2EIOXvCL+hUixxuZPs8TAhUV1dG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzJybB4jCJv2dO3gq0lUSSdfljZN+KVTT+KiG/B/GOIHvFRvV
	onYYJZ/j7Lkz0R/R78o9iViYeM7+k55sP0u428dOcFk5ncxaRCqCsS7l
X-Gm-Gg: AfdE7cnsHutAljDTAfshEckpsj4eHGa9KZDs1ZsOk0PrAHU3o7qHNRl5FSHSg6n9ffo
	XCE/OCYgiZYNJ6OO3vuOT7KHxRvEb4mEM+nNgFhGOIz9uAO5EYJ+3IFuuYSGCUis59p57jAu/Sy
	vieIHSdrcM48hYRrKec1v/ksNWQnRNAofRKclY7W1Vp7aOVSCklRGlYsEAK3tC8+JKiF0iB/ohB
	fDALmJUgQTp3ZF/Dlw13eVyQAC6BF/6do6gxZTPzCfuNhjP4wCWrjhm8MqmGTFJUBgxIPv/xKz/
	PoDL5MIGPjVdmi2tugR75okl68Hm/2ED1vtCRiLAZyx6OdbQTWAFnUoLUWZBbnmTlH/uc+ATjxE
	rLaw/DSmeZKmsbAXdsJmFoPfTvMzSA11OWd43SOxmsIa16EH3O+FQNQra5h+X4d5FMQWlf6Fm+m
	YHe0Sik4lL839BCrEC7g==
X-Received: by 2002:a05:6000:5c4:b0:45e:fa7b:a7d2 with SMTP id ffacd0b85a97d-46660744474mr9282911f8f.7.1782049031491;
        Sun, 21 Jun 2026 06:37:11 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5397sm18864155f8f.13.2026.06.21.06.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:37:11 -0700 (PDT)
From: mike.malyshev@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mikhail Malyshev <mike.malyshev@gmail.com>
Subject: [PATCH 1/1] KVM: x86/mmu: Emulate, don't kill the VM, on access to a disabled passthrough BAR
Date: Sun, 21 Jun 2026 13:37:08 +0000
Message-ID: <20260621133708.3454718-2-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621133708.3454718-1-mike.malyshev@gmail.com>
References: <20260621133708.3454718-1-mike.malyshev@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Malyshev <mike.malyshev@gmail.com>

A passed-through PCI device's BAR is mapped into the guest through a
VM_IO/VM_PFNMAP VMA whose fault handler (e.g. vfio_pci_mmap_fault())
declines to install a PTE while the device's memory space is disabled,
such as immediately after the guest clears PCI_COMMAND.MEM. If another
vCPU accesses that BAR during the window, hva_to_pfn_remapped() fails and
the gfn resolves to an error pfn even though the memslot is still valid.
kvm_handle_error_pfn() then returns -EFAULT and KVM_RUN exits to userspace,
which typically treats this as fatal and kills the VM.

This is guest-triggerable: a guest that toggles PCI_COMMAND.MEM on an
assigned device while another vCPU touches the BAR can take down its own
VM (observed in production with an assigned Intel iGPU; the guest's display
driver clears PCI_COMMAND.MEM on one vCPU while another is mid-MMIO to the
BAR).

On bare metal an access to a BAR whose memory decoding is disabled simply
completes as an Unsupported Request: reads return all ones, writes are
dropped. KVM can present the same behaviour by treating the access as MMIO
and emulating it, which is exactly what the noslot path already does for a
gfn that has no memslot.

Distinguish the VM_IO/VM_PFNMAP fault-handler failure from other error
pfns with a new KVM_PFN_ERR_PFNMAP value (in range of KVM_PFN_ERR_MASK, so
existing is_error_pfn() checks are unaffected) and route it to
kvm_handle_noslot_fault() in the x86 TDP fault path. Genuine,
non-pfnmap faults, e.g. a vanished anonymous backing, still take the fatal
-EFAULT path, consistent with what mmu_stress_test already expects. The
MMIO mapping self-heals when the device's memory space is re-enabled and
the memslot is updated, bumping the MMIO generation.

Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---
 arch/x86/kvm/mmu/mmu.c   | 16 +++++++++++++++-
 include/linux/kvm_host.h |  8 ++++++++
 virt/kvm/kvm_main.c      |  9 ++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 91843e9224d04..115e2c4db5fa0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4759,8 +4759,22 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	if (ret != RET_PF_CONTINUE)
 		return ret;
 
-	if (unlikely(is_error_pfn(fault->pfn)))
+	if (unlikely(is_error_pfn(fault->pfn))) {
+		/*
+		 * A passed-through PCI BAR is backed by a VM_IO/VM_PFNMAP
+		 * mapping whose fault handler refuses to install a PTE while the
+		 * device's memory space is disabled (e.g. the guest cleared
+		 * PCI_COMMAND.MEM). The fault then fails even though the memslot
+		 * is still valid. Treat such an access as MMIO and emulate it so
+		 * the guest observes Unsupported Request semantics, matching
+		 * bare metal, instead of killing the VM with -EFAULT. Genuine,
+		 * non-pfnmap errors still take the fatal path.
+		 */
+		if (fault->pfn == KVM_PFN_ERR_PFNMAP)
+			return kvm_handle_noslot_fault(vcpu, fault, access);
+
 		return kvm_handle_error_pfn(vcpu, fault);
+	}
 
 	if (WARN_ON_ONCE(!fault->slot || is_noslot_pfn(fault->pfn)))
 		return kvm_handle_noslot_fault(vcpu, fault, access);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb063..dc5973e400721 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -99,6 +99,14 @@
 #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
 #define KVM_PFN_ERR_SIGPENDING	(KVM_PFN_ERR_MASK + 3)
 #define KVM_PFN_ERR_NEEDS_IO	(KVM_PFN_ERR_MASK + 4)
+/*
+ * Faulting in a VM_IO/VM_PFNMAP mapping failed because the owner's fault
+ * handler declined to install a PTE, e.g. a passed-through PCI BAR whose
+ * device memory is currently disabled (the guest cleared PCI_COMMAND.MEM).
+ * The memslot is valid; the access should be treated as MMIO rather than a
+ * fatal -EFAULT.
+ */
+#define KVM_PFN_ERR_PFNMAP	(KVM_PFN_ERR_MASK + 5)
 
 /*
  * error pfns indicate that the gfn is in slot but faild to
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 881f92d7a469e..f232fc2f42380 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3015,7 +3015,14 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 		if (r == -EAGAIN)
 			goto retry;
 		if (r < 0)
-			pfn = KVM_PFN_ERR_FAULT;
+			/*
+			 * The owner's fault handler declined to install a PTE
+			 * (e.g. a passed-through PCI BAR with device memory
+			 * disabled). Flag it distinctly so the arch fault
+			 * handler can treat the access as MMIO instead of a
+			 * fatal -EFAULT.
+			 */
+			pfn = KVM_PFN_ERR_PFNMAP;
 	} else {
 		if ((kfp->flags & FOLL_NOWAIT) &&
 		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
-- 
2.43.0

