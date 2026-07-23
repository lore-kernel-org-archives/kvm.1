Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2212931D2
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841194; cv=none; b=bVglogc0dL5IUJbNS1fXW2kfYwOT4+GwaPF6JeCrIyEwb/nJDtHPipuhYmWlJYoJ84wxLs3kwUCrt3CoSpMkEWYEit8bsnoChmNaVlCjBkkfF1A3mSvHGwc/IRjNr9f+RM+m5rMX8cy8rYj22PPiWpBJCkPTE+Ol1sutkcWm/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841194; c=relaxed/simple;
	bh=1hWFHI4JRAs2hc0cg9v1/a4IQrHF/pLOqVLIAa8AbXE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tOroM5RVgxkiZUVI/1Shk3DqngYA69Vujwv8htpLGaIYl/4iF0BzQl5VReJsYQ4Yz3Cqhsaquk3W7DHR982FLpChlGS0/iEd6vhlPDp9hUAfxbBCTb29dQ3jts6iMcnUJ5yug1LA9xfik/j2aPEaNqdxaD3OMzz7NRo5UHc+9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkfNJMKE; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkfNJMKE"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e04598adeso954149b3a.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784841188; x=1785445988; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHl5tfP5m5/e8XYPelSgAqtF3SsvtJLfy9mGWsHBD80=;
        b=gkfNJMKEo6uJiRdWYBz8f0aBrOFCFY42yuxSMiCuik5Sx+3eeylsbShPPCd9YQGEfC
         LqqWw7QZ3lKiVsZVDNOiDmMPjJ0w4hxW4AFl5FoxUaHEJ59lCQg4X+vPcGG3ECM3r/6b
         zXFSbsWtvhB0SwXmh41wsaJCLzMzTT7uCslx0MJ1LfKGfQzaAjuARdoDvXRZlZ2r2dET
         xCc9eKOmI2UTiMk+XIXkYwrdTN34Np9u9ptkZeaCEJqSwr/4SL91eYfzTCojqUXALZjo
         zMkj1dn0LGZQR6Izx6mOyZvuDp0kMOCkZelRV73iu/1VR+p8tClns4kImLQ9j2wHDRgj
         bwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784841188; x=1785445988;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xHl5tfP5m5/e8XYPelSgAqtF3SsvtJLfy9mGWsHBD80=;
        b=J7Mu7MwU3vvq8399ap0cFY1HgwQs8S4AwNVfwuB/sfYKdQAxrB3Qv3S+JxKtjU/7AP
         LcQtFNJYwonJqyHN0HkrWmL7yIQF4G2xO7ZivGKFTB9TkEqG39ewFQrmfrJ4OKU66k9g
         65oBHr+gEBtZZMTxzQ6ZhRD/NnqnJFZSnTOfPvxbowrVfdEQ3djoZGJi/+uxrJB+0jo1
         accbI9B4GDLuuKoakbBmMyPoCawZFUYylTFf6FclPHejHNm+g4iI6bL7bydvw2pD9sEw
         gpVbX5ZJuiAl4OSz41szu7/1wolUTJwW/YKOqh0eGmPArVV/JEyjwgYnHJhJmMWpDqJK
         1BzQ==
X-Gm-Message-State: AOJu0YxHc673t6yY65mLAQp+Rq8XvUAI/X7Pa5NE2gauoAyxpuZ1Z7Fw
	6Z2LnJsu0mI3PbHBtuJXKh/HFp82SY0UuunK//A2G1tAI0Or32q+L6Nblrh/tkkcvPVvdw2iNcx
	TN372sQ==
X-Received: from pfwz7.prod.google.com ([2002:a05:6a00:1d87:b0:847:87ec:2a9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d82:b0:848:5935:2e11
 with SMTP id d2e1a72fcca58-84e2bb1e85amr5266272b3a.48.1784841187864; Thu, 23
 Jul 2026 14:13:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:13:06 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723211306.75397-1-seanjc@google.com>
Subject: [PATCH v2] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on
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

v2: Use __get_free_page() to ensure it really is a full page. [Sashiko]

v1: https://lore.kernel.org/all/20260723002547.7BF971F000E9@smtp.kernel.org

 arch/x86/kvm/svm/sev.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..803bd39695fd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1280,9 +1280,28 @@ static void *sev_dbg_crypt_slow_alloc(struct page *page, unsigned long __va,
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
+		return (void *)__get_free_page(GFP_KERNEL);
+
 	return kmalloc(*nr_bytes, GFP_KERNEL);
 }
 
+static void sev_dbg_crypt_slow_free(void *buf)
+{
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		free_page((unsigned long)buf);
+	else
+		kfree(buf);
+}
+
 static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
 				struct page *src_p, unsigned long dst,
 				unsigned int len, int *err)
@@ -1304,7 +1323,7 @@ static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
 	if (copy_to_user((void __user *)dst, buf + (src & 15), len))
 		r = -EFAULT;
 out:
-	kfree(buf);
+	sev_dbg_crypt_slow_free(buf);
 	return r;
 }
 
@@ -1337,7 +1356,7 @@ static int sev_dbg_encrypt_slow(struct kvm *kvm, unsigned long src,
 		r = sev_issue_dbg_cmd(kvm, __sme_set(__pa(buf)), dst_pa,
 				      nr_bytes, KVM_SEV_DBG_ENCRYPT, err);
 out:
-	kfree(buf);
+	sev_dbg_crypt_slow_free(buf);
 	return r;
 }
 

base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.229.g6434b31f56-goog

