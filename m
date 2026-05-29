Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E2441022
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079796; cv=none; b=YbBUEH1cefZWt7DqfPKzgL+iHYIqajS0rtpzDhydiWQYDYCyRqj0o9keVK+5yjd/pHPNOu68H7hAR+f67wXbXA7WYTIyGiEOULBjWHpNKSqlR2+5QmRI5lFMazl0ZolN8pzMsJ60oSG2gpZ5ffXdPZCaH4I1qORYTRmKLEy08XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079796; c=relaxed/simple;
	bh=ulXu0NlgwaVVwx3zWk7XuRF/3f9bu/79QRsDBDGWEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ0C+COyBPFLC+eGccxE9pX9LXvxbjdP++h+oWhTYJ/pL+El2g+KcHF+mYudH4OTKVxyEzys8R4d8MW6FkChrBlYV9Emla6V89N/iFTlfDcdS11dA01aO0woKMpnr6L7G+zyaaTHAcgvRPLxlWp/cNKcDubrhIDL2uzk5SZbmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpMYdvI1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT41YxNM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpMYdvI1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT41YxNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/A1VY1s6jcVoa3c05BPgiOhjQWKntgd+9grtxQ/UaE=;
	b=hpMYdvI1rd1LAhmvjOV0+PMxQukzbBtd1AYuQ1fu+C9k4vjLsX8tZcMSKSAHTKqIwX6xJl
	Z9uEa1WrNKJZ6lvpTEiSL1F2SkyaxJ/FgJfouR+dlhAZ2zX3ozRc4PAalh2sIRW/UQ0ugc
	vR7x/vkrUyuI6epBqrCPwIaSvkwSyIA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-ScUjCUT-MMimkO0pzrVX_g-1; Fri, 29 May 2026 14:36:29 -0400
X-MC-Unique: ScUjCUT-MMimkO0pzrVX_g-1
X-Mimecast-MFC-AGG-ID: ScUjCUT-MMimkO0pzrVX_g_1780079788
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef6b407b4so115820f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079788; x=1780684588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/A1VY1s6jcVoa3c05BPgiOhjQWKntgd+9grtxQ/UaE=;
        b=XT41YxNMUCIAu7hgtAXY7IT66gfTWDAbjEbeSqaIADMqFcV08Awt5YUyfl8apmCNZA
         wRcGK6jQiAWeGH9XC3bGYwgDzWaHumTivIvjASA/C9X8ebEWBlaErnszrHGn3Ukp0vSu
         qMEEA3tTVnJ3+fWnRr4gTg4ysDVUl3bu2OdsuLCkefIYUZj6q95mkTLqK+0FfX2UoDMX
         YS7vkR8Pt/O0jbJ0K9bNTkE+hKn9Siel7/ggsrvnrdSh6tn1bEEUxAf7M+Lx6eNQqHGz
         nxRI0Y6ZwPXIhAcJYV/G9uH0cBQ1byEttzdw1AG1DQbVxBWEB99kmo+1UkOX+8ALxM5T
         m5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079788; x=1780684588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/A1VY1s6jcVoa3c05BPgiOhjQWKntgd+9grtxQ/UaE=;
        b=SRqTtF69qyEVe3Yo4MmZrDI8TlbESxofDn3RNpxvM0kL/GFnkwyFJy676NJQcWrF0y
         ia4uUF5D91JMF3oqwklLl6EWLwH5kOEsI2Jo2zVThiTOmKRdZjGuAV4tQfePt7Mdbmfu
         rlHBTiQbu6lb/QDBLfYBCEKCRJ7pG19sjRi5Lcmmi15srcs4qPGwZFLE+5rV0HlJIW5k
         sqJALFq0wXJd6X2jFsdH09bqB1xrutlf6vOwflck9wo5DFG7B/iKAFWcmGrxXbq2aiKe
         FC0DBwGgabSq6ZdZr8AXsaHRed6K91m32QUCQQryiF5wDkI669JGSAY70OQIq+fbsW2h
         Tikw==
X-Forwarded-Encrypted: i=1; AFNElJ+wm1plUzoerVU1o9GlI2QgJ/ak+jSldF+tc44y2ZJaRotu03WgnuN4LUzwvjPrQyMV4cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvU3Hy49tUENesc7LU8Y9LbptwbRarOqoQQCCc6EEJROsyi5cy
	hKFX/Uln4KiEOw37SbX6kbwfe45yNsdNyger1wzuKo+9y4PeAdc126Uu4PMnwYGACx4iD2y5fY8
	Blw+7i3Wi0BIKArSmYMUNQ730ZPF6GIIelvxeZ4p9w2UhX7HNLpRWZA==
X-Gm-Gg: Acq92OEkUCaH9wRa1BoRSScDdwpjkB4K2qbIlSMfzX0lidnfpsFb2sdvnAU7urBrede
	7mVsDjof867S+sUH9tOTjnklEcQoMvdipadSktvrwEpvv1QavCvLBbjpvtS3ElezrFC45cq5Zzq
	XAcA3luHxjVpvJXhBQ2Oy8yueTAsNF8mRSA+vFKYfmfdHkC3EQ5KyJEPwldV8jGBOO9xkJC69q8
	xeTBE+QWqsFBubKmKDaDXAytAmKsfNLoz6WHMSJw1di68Ezos6lmP1f7yLEJRNLpiq1fdfge4/Y
	XQZ4ljjLU2ERNhKHFVbdDgR27vkaq8z27D2ziG2bs1w7FyqvXC1z/jNUHPit26StDsA1mUgQEqT
	rmi7D/GdNsvP6oSWDQhaCieOieoeXrevRnz5b20iPtmBC2Li+lCHYS3+TV6cxOPfEPXC9nTqqVQ
	ZLeHQGi6H4pYoRiIxEuWNQKUFkVCCxxbGAZWeNCw==
X-Received: by 2002:a05:6000:1376:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-45ef6b20038mr1460685f8f.17.1780079787897;
        Fri, 29 May 2026 11:36:27 -0700 (PDT)
X-Received: by 2002:a05:6000:1376:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-45ef6b20038mr1460639f8f.17.1780079787478;
        Fri, 29 May 2026 11:36:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm6889251f8f.32.2026.05.29.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 14/24] KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
Date: Fri, 29 May 2026 20:35:39 +0200
Message-ID: <20260529183549.1104619-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

When marking a page dirty, complain about not having a running/loaded vCPU
if and only if the VM is still alive, i.e. its refcount is non-zero.  This
will allow fixing a memory leak for x86 SEV-ES guests without hitting what
is effectively a false positive on the WARN.

For some SEV-ES VM-Exits, KVM keeps a writable mapping of a guest page
across an exit to userspace, and typically unmaps the page on the next
KVM_RUN.  But if userspace never calls KVM_RUN after such an exit, then KVM
needs to unmap the page when the vCPU is destroyed, which in turn triggers
the WARN about not having a running vCPU.

Alternatively, SEV-ES could temporarily load the vCPU to suppress the WARN,
as is done in nested_vmx_free_vcpu() (but for completely unrelated reasons;
suppressing WARN from nested_put_vmcs12_pages() is pure happenstance).  But
loading a vCPU during destruction is gross (ideally nVMX code would be
cleaned up), risks complicating the SEV-ES code (KVM would need to ensure
the temporarily load()+put() only runs when the vCPU isn't already loaded),
and is ultimately pointless.

The motivation for the WARN is to guard against KVM dirtying guest memory
without pushing the corresponding GFN to the active vCPU's dirty ring, e.g.
to ensure userspace doesn't miss a dirty page.  But for the VM's refcount
to reach zero, there can't be _any_ userspace mappings to the dirty ring,
as mapping the dirty ring requires doing mmap() on the vCPU FD.  I.e. if
userspace had a valid mapping for the dirty ring, then the vCPU file and
thus the owning VM would still be alive.  And so since userspace can't
possibly reach the dirty ring, whether or not KVM technically "misses" a
push to the dirty ring is irrelevant.

Reported-by: Michael Roth <michael.roth@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-15-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 89489996fbc1..881f92d7a469 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3520,7 +3520,8 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 	if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
 		return;
 
-	WARN_ON_ONCE(!vcpu && !kvm_arch_allow_write_without_running_vcpu(kvm));
+	WARN_ON_ONCE(!vcpu && refcount_read(&kvm->users_count) &&
+		     !kvm_arch_allow_write_without_running_vcpu(kvm));
 #endif
 
 	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
-- 
2.54.0

