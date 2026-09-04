Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA243327C13
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482634; cv=none; b=UsGE9CJ0j9pVxWU8qpaPHoescQ3GFkP+yfvJp5y3S+aCZGCt2qlbEun4Cneq3v6mizNFuV/EBohtl3/Z/4EbxZvzfUkVSBHwKnkMe2XHr5MwJHTEEX+CIYnSRoYIj8n6uZ1kd2cFtFLpg3fH2mmQdZFmpp139qUl3B3B89q8I4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482634; c=relaxed/simple;
	bh=6EXt8N4NB6wdsJJax8tCW8eA4hmgUvS/E4AdZRLfLIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxgNy1Rh6DsG0XcMT7iIhVSa46ppYujowKmWWHifZmUrhS62kL8/mg4wioDrbFsj8sU3qjn4Vx/9J/gIGBh43rEE00SFMwVd5Najh7BAKwxaXy+rwv0moLANkMEZia5RV0dRibSi924RyJVXqxQ+wSgnGReDaXetS+sYClDFF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsPDfhJ/; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsPDfhJ/"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6823efcso5110405ad.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788482629; x=1789087429; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fmFU3kERqueHfMT+w5tRedl69A06EilNg6dxFGGZ7ys=;
        b=VsPDfhJ/SJbIod8bTMSAW68lMosWE+eZ+TBYuHESbG874P87EC5wmJK+lYdlPKzd69
         oqB4Z5zGXFluVoYerNRrBS0dv/yXAT8+EnQd8iROAK7ZkAhOkLIv1schG5KsRR9v6QDm
         tTJnDnp5jqdddpuU0PHtMijlcKKMPIwHtn6cy6nmejieCYMtoGm/RyCU21tKW0qBZA4e
         5698sINJLNaIx5VIT6HDG0g+SQT1s+ijIo6QnwIKG4L0+DUbwcleNgTrc5msoY9riBik
         m/cnSBS4mKflpjt6M2l5Ub7JXGzAKMBUMs+pQZnZU54yq7s9uxDvsl1NPjBJ5nBB+T0p
         zkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482629; x=1789087429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fmFU3kERqueHfMT+w5tRedl69A06EilNg6dxFGGZ7ys=;
        b=A5P+CbpTwrxkTVgPQGg/OxVdABESIPe5evYK4qJqVQfp1J/4ZbcWWo0S+drNFb7zpz
         144ciO3dEnxn9oVKua7+pSJc5xpSjA1POpNqk3OlB2hzp2MI/I9NM+Q0/aq8qvjPHBeR
         XunvNVZ89Of4GGK/skTGe6eOakxcnDgkYYD3ZPhE8mjsRgTG5kThvzikzYWk2/P9jSDY
         Qd4lwAvG4SnhTBM72mvaF8UlhmKMjVo2YrI82goQ17jlEUk1aiPhg7f+fMPG3tCIslzx
         UONo7QInNJxt9vxGP9YiQmhdHUnX6hMprbrasxDF40PiObl7IFhFc9E+ZDAomqhOhzmA
         +7NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlgSI3y0q3w+uuCoxrBuPNW9SCVpcsOgoj9VTcOPCMGfZMpohfND6C6xk0taHb1zT4dFw=@vger.kernel.org
X-Gm-Message-State: AFuF++lTpqO2Lgy1TjGl0VNyGrKXueVhZFL3/k2e35PewiaH4Ht0RwZD
	6Bi09rrvJzv4ArWFpOUwk0MFIZ7q6rAZM6ZJXxutcnLVCbN5z6pcugrONICroAXMjwePiZH/0VV
	hSc147Q==
X-Received: from pltt21.prod.google.com ([2002:a17:902:d155:b0:2cf:afd2:6506])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64b:b0:2da:eccf:751d
 with SMTP id d9443c01a7336-2db126b5ed0mr37542275ad.22.1788482628767; Thu, 03
 Sep 2026 17:43:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:43:42 -0700
In-Reply-To: <20260904004342.3162959-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904004342.3162959-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904004342.3162959-5-seanjc@google.com>
Subject: [PATCH v3 4/4] KVM: guest_memfd: Drop superfluous WRITE_ONCE() when
 binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
during initial binding, as the memslot *must* be inactive and unreachable.
The superfluous WRITE_ONCE() was added by commit 67b43038ce14 ("KVM:
guest_memfd: Remove RCU-protected attribute from slot->gmem.file") to
maintain rough "parity" with the existing rcu_assign_pointer(), not
realizing that the only reason rcu_assign_pointer() was used was to make
sparse and other checkers happy.

Cc: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 0b48e9a775aa..6c8df67382fc 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -653,7 +653,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
 	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
 	 */
-	WRITE_ONCE(slot->gmem.file, file);
+	slot->gmem.file = file;
 	slot->gmem.pgoff = start;
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
-- 
2.55.0.979.g7e5102b832-goog

