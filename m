Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD283B19CA
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845161; cv=none; b=D4Yw2pkI4Yl0mFKoaW+SLVYjppSAZ2KEFhI1nENZwYvyrwYDGKYuYLVQvpACyuCIWBlWooJUztcgW0HPS5vH0YaEJbyX08EyDOnHoBl9BVLoeCRd1MCMhCFKUjpngem0mrMiRBxR8keHqO6aRlC8IZdD9uirpFYQXlGa9yl+RXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845161; c=relaxed/simple;
	bh=Zcn8O1erPuSdDnXyXFymHAYFaLae2f2+vOh43hT0kQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPyC0+Mk7klSzTXjgakz11WVSjtLnEs09O3/qxEYV8wV8eWc7qc1cggGy0owC3cYe4IkL98dulip6yK/ZmCAJ3ADjWgPMuG0fqxF0xNTt4t/3V2YIhLdSMlNIMWQjl5LJsTE+niWvpTVLR0vqgz59MnAB/acFKWYhUrzGaF3M/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDt7huxP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMALMmIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDt7huxP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMALMmIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
	b=ZDt7huxPhM8SmqdeLVyP1TFCFgqUA5v5gPULDxylbfeV9aJX75+k1kKFL/sd9lBzSIKH2v
	AzRbxZlJ61W27bXvu2uN2vBO1ntWIaeqpuQdqWfh2wscj9pJUQPtYS9jrGxxCiN4Vb+DT/
	9+7+hVzx0gm/FspaGzMJ1yqvP9vOTEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-x8UYWGeENv2xmP5Jm-AgxQ-1; Tue, 04 Aug 2026 08:05:53 -0400
X-MC-Unique: x8UYWGeENv2xmP5Jm-AgxQ-1
X-Mimecast-MFC-AGG-ID: x8UYWGeENv2xmP5Jm-AgxQ_1785845152
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso28411085e9.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845152; x=1786449952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
        b=gMALMmIMGhsOWE09Di5u3dFbxkUKvOJmHguRc88lNDsV3F+LtSCWcOj7dt0VMNRM50
         kAbR8X9w1Q1cVGJ0m7rMwgm5GvAIbMfEcnPfB7w07Ak1wG/RZTISnxZyNg3iLsg2XamU
         pB+EqBEXbS8HpDOn8FS+3OjUxYmneC4D0K6eMN6wwxzghh/zlXjqOtGaeK7JdjNeF/+5
         xXuo8k2tWrHNXM4uL+ZxnlxcwHwMT6lt7XX2LY9XUP/VZCRbI117hkDLY+AGHsoKcJ5G
         E0KN+KZf81g0aVO2CvCWVohIuNLWgxw0oT2D+l1DNn0RT+Gc1uK1EMiKru98/xPOUyrl
         zevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845152; x=1786449952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
        b=J7++V4GY7mVEBWah3a+VLIc3heV+HR9iia8CEdDn0o3b2dcCIY4gHWrNQer7ljT3D6
         58+G6TdKtvYbQzseIg5tiVpowMZ9sC/IMMP6sh6xTvRDEXkxFXOHWB21+FnFTtp5ZR3w
         x3fgh7F5MTGscibgxSns81W3CHuSGMgkSDj/aFQPpWxgus4siodbClrmxz4hO9LCX9h9
         8JnGDPZkmSjI6OtUEwVoJ0ikD5GrCtJMnl0vyac9AYyQZ/5QlhQCOJoWvaJrfe1BzTXc
         6r3rv6xtAQ6wx4htydTMT/Ij7CS3K8rOjS8K+xUrKEx6PR2PeLVI7DyTTlJgKUNxQJXH
         72QA==
X-Forwarded-Encrypted: i=1; AHgh+RrGrqQrPq1bblSZEUM1/lv0eC9LXKOz8KpUVzOuRwg0Qy/Sw4e2aETmAXDQhy8FG8mLhrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXL6F1EQSKa0HoJ5HfJE4L05Ps+nNTzGHW2ZwFCzhnXvry8nAX
	7P7MixAJBfbGnQxtfjvh/lA3p/yzeccxD0e2Ix1CCUXMmK5i/huUg0N7zfWngEdLTb6FcfSh9NN
	vCPKUspnrJeEEgwvhqujgdQvEn0fu1PPJGQOqqcG8l10K6rbKoyFgZQ==
X-Gm-Gg: AR+sD10XMbUJeccjFaB6k/yGorMJ4MK5MZ6L8xG3+P9AHJZjmXzo8l7lT9+UrMrcfSj
	eYzsbrjj9Is0MchBGusZFqYjK/GfSX30Dl5AiUnpF27dY7xe5Eg+YFZfrW24xudu0ihVYbp1NsB
	ka1GwX1HOlO2OJu3t6EGC/qAjAxdYIqfRISLmqwb2foekr/gQn+Ycb0TjVKeGWfCoxkikq40uYH
	PRQOn6b1oiXKf2uzXMUiFJhExSSmqtaak2CVHuQlWK84F2sjE559lrl6OTEMBY+TMtplukvnTix
	5XYeam9R7iPF/zKE01yUMLuXU9klwllwwcuwtscWFa1jJBYna9Ve/gr+X1sYElLxj7zRYha6Rpl
	rh5Dhvtt4Y/W35QpIH3Y161gyczsomoYP9i/Q+MgVB0CdHLBRfhG3A/MRwszzDtrKBwU0O+clu2
	UCjGk=
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4980c60705amr298312305e9.0.1785845151899;
        Tue, 04 Aug 2026 05:05:51 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4980c60705amr298311535e9.0.1785845151462;
        Tue, 04 Aug 2026 05:05:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd8df5sm88354535e9.9.2026.08.04.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian Koenig <christian.koenig@amd.com>,
	David Hildenbrand <david@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Fei Li <fei1.li@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Sergio Lopez <slp@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 6/6] kvm: return -EFAULT for writes to !VM_WRITE IO mappings
Date: Tue,  4 Aug 2026 14:05:28 +0200
Message-ID: <20260804120529.1730187-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM's behavior when the guest writes to a non-writable VMA is inconsistent.
For regular, page-backed mappings it returns KVM_PFN_ERR_FAULT and thus
returns -EFAULT to userspace (which is ABI, and relied upon by tests);
for VM_IO/VM_PFNMAP mappings instead it returns KVM_PFN_ERR_RO_FAULT
and thus exits to userspace with KVM_EXIT_MMIO.

This behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM:
do not assume PTE is writable after follow_pfn"), and even if it has been
in place for five years it is unlikely that it is relied upon by userspace,
since it is inconsistent with KVM itself.  Change hva_to_pfn() to return
KVM_PFN_ERR_FAULT for all non-writable VMAs, and restrict KVM_EXIT_MMIO
to the case of an explicitly read-only memslot.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7c21a48a45c..da5b0bb62590 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2999,15 +2999,10 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 	 * or the page might be absent.
 	 */
 
-	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
+	if (vma == NULL ||
+	    unlikely(!(vma->vm_flags & VM_READ)) ||
+	    ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE)))) {
 		pfn = KVM_PFN_ERR_FAULT;
-	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
-		/*
-		 * Exit to userspace for PROT_READ mappings in a writable
-		 * memslot, as this is part of the API.
-		 */
-		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
-			KVM_PFN_ERR_FAULT;
 	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
 		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
-- 
2.55.0

