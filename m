Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8146381EA9
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035968; cv=none; b=N4ME3P131XNykOIfzCeRC8HQSfo9SU7nIg8r74CZwhw/Iji7+oBuUY7DFSwAgZAQdsRCfSiMydDFu/qp/M51CmOtK7sjkWkWDSvv+yTTHURBB+zE3/zGTQ5BGx5lNor/eG04AsxVdIKGc/KUBB+PuLlMHXnaMRJMMy11r+j4kMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035968; c=relaxed/simple;
	bh=9rDKrntgrnlHH0gXwjE3RqLMQFAsGLVHx8ezzG+jCSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lsd7VwmwRDVHb51/DvgE8xwrrz50phhp8MZmI2q3ANtZq6zDv0N/LPVPEBsczov8CgrcVnTa/gqu21TNlfJ0lOzrrACu6VksbS0yuOVVdyXCgoz8T3aEjTaRn6JpTO0mZa3Ka8qGXzGA26kXQ5kE58Q5vfBbFsV9vaXkh54/cdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MencqOwJ; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MencqOwJ"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so4093070a91.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786035966; x=1786640766; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Oa25XPOf9W3WEMkfc/K9a1heGuP5OTgCeX+yey0gIOM=;
        b=MencqOwJMhxlKxmeXCITC7xVe4niCx7pETArh2A5BPz+sM2p2qiATI4IsLaQnQM7qF
         zwZdOVjdKSUMTT/0Q9dvui7acY0oMmJgqFhC1gkFB1dyiIM+nEQmlKnIpAGtqSdZnwSN
         Zt8fQswLPBzoYmCGGr3WbpG+PhwukNXEPWlVaVo0G3m4nhUmhE2VIfW2LPGoabo0jKE3
         Z570gzUpZLp/2voTcphXAAGIjiLguVxl51lYS7gikhc7VU4gvRNFSPDMPVwE6AQ+2Oqu
         KgsJWdvkL6IDWGoNjkkq2sGTDsUZhLpE/e0wT3j2pKgGSn9xhecMIMGC1RpdS/j4QN2+
         aBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035966; x=1786640766;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oa25XPOf9W3WEMkfc/K9a1heGuP5OTgCeX+yey0gIOM=;
        b=htOfO+TPNGTIco2AGRQZI+xROqF29hVCsMFPjZvKqvbL4v7w5nyEZEKGE3GxmFLddt
         p92+aptCom48fAkcOKO1eK/QC+aWb8DL9MuNC3YQFb4yEuUWwMM6IZ121Uvt39um81Oo
         APkyqx70Y48u556GrCfZ8U13rWvz+YzYNNQrIOUPiotPdV9G2pwAdoaYWabeel3YSKW4
         0a8piVCSU1cz2QRgEw4lwmbDn1sxsFsafTH1BVmer3G4FfzmsSGrPgXtjNeUyQQ99g7T
         NWg5FhRfiqn8TU+PMsuPIjDtftOTTEyvWgkVhJh+xAeDfgeYt8dn0aEJjmEB9tXTGzG+
         dnsQ==
X-Gm-Message-State: AOJu0YzoCGJ5thSRGeXaAoigql3ilkDTveuPiZPcm2JqKohpMS4h91N5
	BcipOEwLyozw6bJ7UOQNpfpa/liem5yvRGTpk7m6pdhpQrwk7Qt/es/jpwOO3p8gQYHQSo+f6LD
	M/aBLfQ==
X-Received: from pjbtb8.prod.google.com ([2002:a17:90b:53c8:b0:37f:acb7:9d81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:498b:b0:38e:7268:220d
 with SMTP id 98e67ed59e1d1-3903c628176mr18184487a91.20.1786035965922; Thu, 06
 Aug 2026 10:06:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 10:06:01 -0700
In-Reply-To: <20260806170602.4112602-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806170602.4112602-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806170602.4112602-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: TDX: Reject INIT_MEM_REGION if number of bytes
 would overflow a u64
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>, 
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

The nr_pages field in struct kvm_tdx_init_mem_region is a u64 that comes
directly from userspace via copy_from_user().  The current validation
uses a manual overflow check:

  region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa

When nr_pages >= 2^52, the shift (nr_pages << PAGE_SHIFT) wraps around
to a small value, bypassing the wrap check.  While downstream protections
(gfn_to_memslot() returning NULL for GFNs outside any memslot, and
kvm_slot_has_gmem() checking for NULL) prevent any actual out-of-bounds
access, the overflow itself is a real bug that should be caught at the
validation layer.

Replace the manual overflow check with check_shl_overflow() to correctly
detect the wrap-around.

Note, the manual wrap-around check on the gpa+size technically has a benign
off-by-one bug, and can also use check_add_overflow().  Those flaws will be
addressed shortly.

Opportunistically separate the initial sanity checks from the more involved
checks to try and make the code easier to read.

Fixes: c846b451d3c5 ("KVM: TDX: Add an ioctl to create initial guest memory")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260630214952.98C851F000E9@smtp.kernel.org
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
[sean: use gpa_t, isolate check_shl_overflow() change, tweak changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..929115aeb9ec 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3219,6 +3219,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	struct kvm_tdx_init_mem_region region;
 	struct tdx_gmem_post_populate_arg arg;
+	gpa_t nr_bytes;
 	long gmem_ret;
 	int ret;
 
@@ -3236,10 +3237,13 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 		return -EFAULT;
 
 	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
-	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
-	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
+	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages)
+		return -EINVAL;
+
+	if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||
+	    region.gpa + nr_bytes <= region.gpa ||
 	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
-	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT) - 1))
+	    !vt_is_tdx_private_gpa(kvm, region.gpa + nr_bytes - 1))
 		return -EINVAL;
 
 	ret = 0;
-- 
2.55.0.679.g6767b8d81c-goog

