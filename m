Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8F4EBAD0;
	Fri, 16 Oct 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162620; cv=none; b=bzkjL5jFq5bhvPgpgDKwXQEpi/OiBKDbue2nqUhPymx+g5PJyvdX9VaTkDyyS9qnbBIoeHyf6g1RkgMVctUFXVa3UB7ZSIZ3hOo1lDq3AOWYT5DrvI1KW3ln5hvNFYfahYg4HoFce732Kz+VWuHPGZp0De+BOhhQ53wKOssfr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162620; c=relaxed/simple;
	bh=jqsueGaiqY/v1Q9rSeBsNmWSdKhneknu82uJHwEK9NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7K8nFuZNJyw0aK09EzCSImLdwQ8wIbsDCyavExOnt5+5ycQoSUPHHT788bQbSjuGgSSqPIAcqpkJr71K3GxhknK6YWwHqkrHcRvREOkZhxjM85bXb+GAD8fgdSEPdrzh4lBEuyKOIq8FkTstCKR1s8ktmdG0v7zAB6F3UrC66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WVJQUEq6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WVJQUEq6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bjnkFrD5nKcgJn0NoCN01Nlxtzt8gKrUyJe4SHcCb8k=; b=WVJQUEq6/gxWk4uhgRIAPk+bY5
	A7yPKWc+vSbi4n9MeS0J5ViE+DQOapIPWQ/rKfsinGTbMLp3Jk8M6+e7tV7isWStBlnJ5IIfhQspw
	LeOu6cIbi0KK1dGdvparZ8aK3PAHyl/iJdStR2p1Qce7Hkdt1b/HYSOEiOM5MJhvnLwUgTqkVoL8h
	BCWW37+M1v5hLafN7qUzVoPJbZXPsHiVjD94JK36CtxMd5ly4yvWzEUShF4IdFxWDwEbj06Sn8o+i
	PGqsM/y6cs/ns8g1WFAg9nsEpDQQ4OLyAEOQ4M1PAXjsOocms9z58ljrI53aI+nN4f+XisPohMuZo
	pydKZ+aA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMX-00000001dOc-1wpb;
	Fri, 16 Oct 2026 14:56:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMU-00000002QjI-3m3s;
	Fri, 16 Oct 2026 15:56:46 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 08/11] KVM: x86/xen: Don't dirty track "vCPU info" page
Date: Fri, 16 Oct 2026 15:56:42 +0100
Message-ID: <20261016145646.579369-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016145646.579369-1-dwmw2@infradead.org>
References: <20261016145646.579369-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Sean Christopherson <seanjc@google.com>

Give the Xen per-vCPU info page the same treatment as the per-VM shared
info page, and never mark it dirty, as KVM clearly relies on userspace to
assume the page is always dirty.  While the page is marked dirty on writes
via kvm_xen_inject_pending_events(), it's not marked dirty when written by
__kvm_xen_set_evtchn_fast().

Furthermore, as was the case with the shared info page, writes in the event
channel fastpath may be done without an active vCPU, e.g. when called via
timer callback or irqfd injection.  I.e. attempting to fix the fastpath
would run afoul of the same issue that was fixed by
commit 55749769fe60 ("KVM: x86: Fix wall clock writes in Xen shared_info
not to mark page dirty").

This also covers the pvclock writes kvm_guest_time_update() makes
through the same cache; userspace assuming the page is always dirty
covers those equally.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[dwmw2: also update the KVM_GET_DIRTY_LOG note in api.rst, which
 named only the shared_info page]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst | 5 +++--
 arch/x86/kvm/xen.c             | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e0430cc750c9..b24aac070b11 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -385,8 +385,9 @@ The bits in the dirty bitmap are cleared before the ioctl returns, unless
 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is enabled.  For more information,
 see the description of the capability.
 
-Note that the Xen shared_info page, if configured, shall always be assumed
-to be dirty. KVM will not explicitly mark it such.
+Note that the Xen shared_info page and vcpu_info area, if configured,
+shall always be assumed to be dirty. KVM will not explicitly mark them
+such.
 
 
 4.10 KVM_RUN
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 418acf0b02e1..82adc5741f8d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -756,7 +756,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
@@ -2524,7 +2523,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
-- 
2.43.0

