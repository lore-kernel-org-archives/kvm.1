Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399785;
	b=IYc04vQpwLqOe9Ab2z7wnyg8Fl5QIGCU0AB9KtBBWtoQulKQ3g2W/OFR6I7qJyuxfi1w
	 oQo5HP0j97ixhWJ4PBTvT4QKdhCmKCh6377nKKnkB7en/sVgPJcER9DUBxl09QXc3LPJV
	 W8fqobdwI84yzbUT3PlppMTZ2BjaCHCVhzeGtt3o+XM0cpRIA3vBrTsCPSEYDZIuRx1Eb
	 LGJlWi8fKwmGZQbncHPySQNEs5nQ51kROCWwcLLOFgvtatE/Mr3lyz2HcULLoo3sBpiky
	 hnydK25RO00WfwgeeRAbYj1VmWfnKPto5xRaTpGhVMC0sURXZvA1dOXpTEZtIhGJizQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399785;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X/bnPSiWobAadhDwQTooCUEGyjWTAoaHPWVEb2n6Bqc=;
	b=3rvljlehWDl4NBbltQtqYPEJIwPs6a4Qc5cr5svFDq/lnNhGAMRGUHgPcjuxu617w1GC
	 qZ7VDPLuFj16wne0Wy3kbXKGKjkvZuDobxpXXSJfwkMZ5UrIsdNEV7ZNzNEhprtKWzDyH
	 XlMWozq7NLovkbFg8pNwM7z4pDlXr9x57fs6G1yPcrJnPN+LEmXrQcPUX8vDPofimoK9V
	 Q0N1I6SSPGyohl0v7es6f57qy9wtocdZXTRcxqnMprvgYNYcPqj9GgjGE001MwQ1d6Bzp
	 DgO7UKeJYvKFAsN3V9hdUOUTT/YzYrRBZMcliugDnzS7tfrwasx8ylyCuIa3Mnr8Kkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=surriel.com;
	spf=pass smtp.mailfrom=surriel.com;
	dkim=pass header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=IH2ET3Ge;
	arc=none smtp.remote-ip=96.67.55.147
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCE606A31A;
	Fri, 30 Oct 2026 22:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDCE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=IH2ET3Ge
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=X/bnPSiWobAadhDwQTooCUEGyjWTAoaHPWVEb2n6Bqc=; b=IH
	2ET3GeQ22DemXezf++PR7qqMAwhqoWhUqk0oiTVOctTeymzB5hCX3xhE9C5AFQOyI+FcNg0U0ADKn
	S0GIFlNN1fj8RUe7wbkM4fjNS6+jWGmVkwGGK9MAHHpFdNf9/jN/sWASr6SV+XncFeoXPIMk8oUlw
	/tNBt6+6w7Py/GOgL5e8+drYGRTQaYniHVxhioE8pyseOZ41Ux1y7HF1p5F14ipILfULCipJxRy3d
	ZI3GV5zjefhmrhUilPVlfx6yW7bmrptLzaYtNP4GU6ETy1xEBmOITNqyS1AtQvB0WQ03uVo3aR1wh
	YNHXwZTM8cKZDiCDR1x21OS74BtWfuSg==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xMvCf-00000000fF9-1heG;
	Fri, 30 Oct 2026 22:36:05 +0000
Date: Fri, 30 Oct 2026 18:36:04 -0400
From: Rik van Riel <riel@surriel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] KVM: reject VMA straddling the dirty ring on mmap
Message-ID: <20261030183604.3e8e373c@fangorn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

kvm_vcpu_mmap only tests the VMA's first and last page against the
dirty-ring interval, in order to prevent a MAP_PRIVATE VMA from
getting mapped into the dirty ring, breaking dirty tracking. 

A VMA that starts before the ring and ends after it has neither 
endpoint inside, so the check passes even though the
mapping covers the ring.

Getting this wrong is observable from host userspace: the VMM
(QEMU) mmaps the vCPU fd to reach the dirty ring, and a MAP_PRIVATE
mapping that spans the ring succeeds even though it covers the ring.
Faulting one instantiates a private CoW copy instead of the shared 
ring page. The guest's dirty-ring writes then land in a page the 
VMM never sees, silently breaking dirty-page tracking.

Fix by testing interval overlap instead of endpoint membership.

Tested by creating a VM with a 16-page dirty ring. Mmap the
VCPU fd covering pgoff 0...199 MAP_PRIVATE, then fault a
page inside the ring. Succeeds before this patch, -EINVAL after.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 virt/kvm/kvm_main.c | 10 +++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4175,9 +4175,15 @@ static const struct vm_operations_struct kvm_vcpu_vm_ops = {
 static int kvm_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct kvm_vcpu *vcpu = file->private_data;
+	struct kvm *kvm = vcpu->kvm;
 	unsigned long pages = vma_pages(vma);
+	unsigned long ring_start = KVM_DIRTY_LOG_PAGE_OFFSET;
+	unsigned long ring_end = ring_start + kvm->dirty_ring_size / PAGE_SIZE;
 
-	if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
-	     kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
+	/*
+	 * An overlapping VMA is rejected when private or executable: a CoW
+	 * fault hides guest writes from the VMM.
+	 */
+	if (vma->vm_pgoff < ring_end && vma->vm_pgoff + pages > ring_start &&
 	    ((vma->vm_flags & VM_EXEC) || !(vma->vm_flags & VM_SHARED)))
 		return -EINVAL;
 

