Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346663C1F
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765245; cv=none; b=c3DJwVZ36fU4ZBJZRwIhbjLSUGu8I4xFhR7YDqKlehilggBBBkYJmVXApSNwXtz9oH+uJ95KV+xAIxfFmEIrE1MWU7ZUvtkPi9XpXhW3f0g9Prh167FCxp0kwyRbTkjfOd/tkdp0UFZuyCh4mOSw5vVWqfzTrMFvnAQMCQwxSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765245; c=relaxed/simple;
	bh=w/QQ2EgdS+kkbSJ5WMln5SmFQH3uOap/K3wH9l6o4Ro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GgAt0N2Yc2xFjrD/U5hPjuV1q0Fq1toiqR280HySljBNYgTmmCVV6TV3Y7PyQRpmUnto7CFPsOwnanwyuFRB/YHcrp/Rwzg64xMTAOQiQye6xKgAtoaxmGaZhnNaas8mbv0HvpIdlmts+jpzZhicZ3YrMJmIWhebzuIp6Psxtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6BlNkyJ; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6BlNkyJ"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso2047515ad.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784765243; x=1785370043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MMi+Oay8WsD73HvcDpt08WjuOhmqdSMQdHZX29sq964=;
        b=e6BlNkyJ/Fh4q/xBkZTl1U0UhoWKmL/v0d+ECYEW0PkHNOo9AlB5PMaM/qI/b4WehU
         qKPV+v1ykjRzEvNdhn7fEUOfcH+c6zjKrBqQiGbezZo/QHWmGuJgBN0zGQ4HEzl0szas
         u8LS8pXrGmvdPQOsOcrz94b9xyhhBxquANAKwsMDrqPhKoP39rQVGGDecaVscbCjK9bv
         dLgSYnc0xWys08bu8u5gmhGbRtl3Ty5GvRmIfuA2X0DFQBFOCIj0+eCKQYDFF9xIbk20
         WNgS8Sd2Gb2zI/rfOthNCNSBrJwvZYe8O5n8yAe1vtcST1wZyjRM4+uawdLR/a9B3+Et
         HlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784765243; x=1785370043;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MMi+Oay8WsD73HvcDpt08WjuOhmqdSMQdHZX29sq964=;
        b=rstkw2aMJKpMZ1GMl670QdPTfOIZfvnpVx15J2i1PFe8pF43L3i9gm9hWmMM/2M/sw
         V8HGtCWW0xkl6on+10jxGyoZu8ktne8/ivsmWz8Vd6qMk6CgCEtS9J9nIHjtPFFB4/An
         KZq1DGF1z6q4mZcIWkjetiOlMGGYub9Y76RRnddSt6jkmB00V8FKc8Eqf/J+wWyCLoMs
         sYRz9XSriWSoDS7o7F9UuuzDPXASSbW66O04/K0jyn5XlJi1H4SXRW6EQjju5UBlFv/u
         ElMDmnqJ89wt6dIBB35OueAK5OSoKvPXjcI6b9CwJZ7CjJyIYEtzDF3DAZ6bi+tuqKf1
         /pyQ==
X-Gm-Message-State: AOJu0Yz3z13ch2Itx+kPCSe8xU3meFgffTj9Y0hJGK0WulxKT4pP/Kbj
	68KmMNjPd0sNkZbQRgcowNTqukGrMO6DwEwBqTOB3FeZeeFeA8icISUk5Orq7QKgubX8Oahwoqx
	4t8YBcg==
X-Received: from plnw13.prod.google.com ([2002:a17:902:da4d:b0:2c7:ebed:f6e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a6f:b0:2cc:9a86:9c42
 with SMTP id d9443c01a7336-2cfa753472fmr9933695ad.45.1784765243190; Wed, 22
 Jul 2026 17:07:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 22 Jul 2026 17:07:15 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723000715.1235773-1-seanjc@google.com>
Subject: [PATCH] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on
 SNP-enabled hosts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

When {de,en}crypting memory of an SEV or SEV-ES guest on an SNP-enabled
host via a temporary buffer, allocate a full 4KiB page for the buffer to
ensure the page containing the buffer is wholly owned by KVM, i.e. won't
be concurrently allocated and accessed by other kernel code while KVM is
using the buffer to {de,en}crypt memory.  On SNP-enabled platforms, when
sending SEV/SEV-ES commands that trigger firmware writes to memory, the
to-be-written page(s) must be (temporarily) assigned to Firmware (as
required by the SNP architecture, to guard against using such commands as
gadgets to attack SNP guests).  See snp_map_cmd_buf_desc() and friends.

Unfortunately, transferring ownership of a page to Firmware makes the page
inaccessible to software, and thus writes generate RMP #PF violations.  If
KVM uses a sub-page allocation for its temporary buffer, some other actor
in the kernel can allocate and use the other portions of the page, and thus
trigger unexpected (and seemingly spurious) RMP #PF violations due to
software attempting to access a Firmware-owned page.

  BUG: unable to handle page fault for address: ffff906ae30f0300
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x80000003) - RMP violation
  PGD 6b1b80d067 P4D 6b1b80d067 PUD 100231e2063 PMD 10055a88063 PTE 80000100630f0163
  SEV-SNP: PFN 0x100630f0 unassigned, dumping non-zero entries in 2M PFN region: [0x10063000 - 0x10063200]
  Oops: Oops: 0003 [#1] SMP
  CPU: 70 UID: 0 PID: 10658 Comm: svw_WaiterThrea Tainted: G     U  W  O        7.1.0-smp--c22293789940-seanjc-next #1 PREEMPTLAZY
  Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
  Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
  RIP: 0010:memset+0xf/0x20
  Call Trace:
   <TASK>
   __kvmalloc_node_noprof+0x2a4/0x710
   do_getxattr+0x4e/0x130
   path_getxattrat+0x125/0x1b0
   do_syscall_64+0x10a/0x480
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f3a22cb6daa
   </TASK>
  Modules linked in: kvm_amd kvm irqbypass vfat fat ccp k10temp sha3 libsha3 i2c_piix4 gq(O) cdc_acm xhci_pci xhci_hcd
  gsmi: Log Shutdown Reason 0x03
  CR2: ffff906ae30f0300
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:memset+0xf/0x20
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: 0x39e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
  gsmi: Log Shutdown Reason 0x02

Fixes: 4c735bf1bc22 ("KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers")
Cc: stable@vger.kernel.org
Cc: Michael Roth <michael.roth@amd.com>
Debugged-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..e3733ed9d588 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1280,6 +1280,17 @@ static void *sev_dbg_crypt_slow_alloc(struct page *page, unsigned long __va,
 	if (WARN_ON_ONCE((*pa & PAGE_MASK) != ((*pa + *nr_bytes - 1) & PAGE_MASK)))
 		return NULL;
 
+	/*
+	 * If SNP is enabled, i.e. the RMP is active, allocate a full page to
+	 * prevent concurrent accesses to the page.  As required by firmware,
+	 * the PSP driver updates the RMP to temporarily transfer ownership of
+	 * the page to Firmware while the {DE,EN}CRYPT operation is in-progress,
+	 * and so concurrent software accesses to the page will encounter
+	 * seemingly spurious RMP #PF violations
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return kmalloc(PAGE_SIZE, GFP_KERNEL);
+
 	return kmalloc(*nr_bytes, GFP_KERNEL);
 }
 

base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.229.g6434b31f56-goog

