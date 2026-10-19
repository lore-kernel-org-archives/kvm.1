Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427097;
	b=x3uyj/CvCtpiiHUKiIs4f7k1+q03oVLhax7i6XcPIR1Q0QBGOLSx7h6cu7+Q8XeFbFad
	 jYAxvksZcmLjKr4BIJVke6oqNmaOYNsBt0Pr5EevfBSM9v3qTLQM9YC+x4oDjXbKvcQ3R
	 obbj7zHBwGXJ30ntxPO+zJwMRMO322Ksc4yXHFGlNF46syr/8RUYDgTO9wC9hiHYTHlPB
	 6Ft88bmfcLc94zqZRJLN48DjZJFKBkdxv4E6UbGbr7pQszMr4EsjIs13TdkznwayrZzvC
	 JV/E/glTewmx+XfgoLF8dmFrLOJ+5qMPdcpCB99bEoZ7lbG+ZpigF7lSCXxIXceC6VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427097;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=lsIBRDyGsUxhmxU8cMvjJEMNTpeEAej86qkXKTSOoyY=;
	b=5Hk1DwEC8pOoQzA0EABGRsROsn+xYwZfQHKKE/USeiWQtbCpqUk41eiN1J/z3Gwsyy3U
	 zjLqCsWkfkqf9F8/lWfkncs2qHlRBFaplzOSNBzZPCrJzlsYPpwXjnkw+U6ds89fIO3U9
	 EHlUgc6Y0B9Ly8ZBpEBFBbEfUXx78S6vL+Sjmq6f1hJ1XyNg0nJEoODgZE9rgAYMhFABd
	 7r90UbQHH+yZPTyo03kWPcqLEfYtF+jZMr8gvSsKeBU/UqQQT7iK5ud6rdGQy1jSoy6ot
	 W2o5IZx3vG2ocfhyaBgO88bvWMNKbl1B9CFCU4LplrHn0UD/sS3oTWL3jtmokn9XDMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ii4IKZk2;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFB606A31E;
	Mon, 19 Oct 2026 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ECFB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ii4IKZk2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lsIBRDyGsUxhmxU8cMvjJEMNTpeEAej86qkXKTSOoyY=; b=ii4IKZk26l8tad8TNRc9zAqP4y
	ShMFpHuRFZR/5GCDoovI/VVnW97+8dGXQay1WQeaCeMXkkI23BospBqZ9Ls4oc/qmBU1gXe7EzUxD
	Wn5fO2B1G7Hn4msJxyMc9zfhNAtdKQuCOAtN7rJ0pWtzOqTKnVsQXKBLzUpvgWRRR27DL4QukT3ao
	ne8+WzIVFmBYfNcG3byumJzXIPh+HH0yqP4r9kYAAK7sFDeYiKBEOUGRa+1/Za50kbT07UGX/ZY79
	q54MsbHR6kFRSjlaAizOa+t6VgrKAISL3ke7HU6TyAU7sWT2dsxcASFQYjximoGeL0LX5TBp9CEE7
	r4v44+1Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqAH-00000009VGP-3riH;
	Mon, 19 Oct 2026 16:24:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009h3-2pta;
	Mon, 19 Oct 2026 17:24:45 +0100
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
Subject: [PATCH v4 09/12] KVM: x86/xen: Don't dirty track "vCPU info" page
Date: Mon, 19 Oct 2026 17:24:40 +0100
Message-ID: <20261019162445.37219-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
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
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
index 0ba684bf01d3..94eb55a6d702 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -778,7 +778,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
@@ -2556,7 +2555,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
-- 
2.43.0

