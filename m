Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B0515996
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024789; cv=none; b=TTw5z+xCRjGV8mxQ55tsL5YR5W8ytk8/wfj0E0MfiYn3sXEevGEj1POWvdbuWUSicOEts0CBiffy6E8yaIhcQJkbDd6OBFq5Efqw56jlPyUm+PRJNKgcjNcV4Cy5RydBgMtn63vmeP8Ap3H3F684bmWS5YrK3jKCd3ztB/BW63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024789; c=relaxed/simple;
	bh=NiYO9u22M0EOKTPmFi+as9af++RPLwF2dk3axMotfZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8NNye/FQVhHTdeyh/NI3SUBlzR0BuMyiRRDwwzMGQjs/yCkCaTY6K6CcvLPhUrzoNss+u+TD9dMk9tjZUMTrzoSvqhEoAY21/tCgfPevQhOA3p3g7DLu7yEB6zCOrHx9Xyi2WfRRnNpr0ZwxOZq5Dx1oDQrX4JsrJ430MRWg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvfM+/tn; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvfM+/tn"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so4901586b3a.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790024788; x=1790629588; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aMnK3YE9JmuSMLmY/xn/2iknwP8QiqPv8uY0jyKuvFE=;
        b=YvfM+/tnxTZvUs5KDVsIEMal2RzJYOJIw38pUHMvYRMDzNJe/hJeK0ioviTJm/Wfso
         XV5nkHVHX9q3MYODgevmXPiF/uo1HcLDq7jadlfipWqyINlPglfrUhJf6qCNdJVICwRV
         o0k7Hl+DLFQBvJf521DGbN+7ZWwx6gwYkI5PKK4Tixrh2P8xrYcQrHt4eZFWFewvUvRF
         5K3mQvQMV1AGh7VBOgScX0bk+gG09+enXDyUUsp+SUETyh1DeezUmMRfuoQrdE9xb3eH
         rDJ7s7A9I2DhYlm8wBOEr4Q9hhQCeyPf7i2O6DsFBnxQN0CrzlCFGrjiURYn7RISBDab
         y5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024788; x=1790629588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aMnK3YE9JmuSMLmY/xn/2iknwP8QiqPv8uY0jyKuvFE=;
        b=y8ytGjjl/SHq+3IQ1FJ6H5ZFKqI8M5Cwtu/AcDpteSmc6mhvk7lhEP/cm5ob9iYs7j
         VcdXBDCYTDPdPrinPtMFW0AZvBfwhLuT7Iz/c/4/82VvAdrP2uMQfzpTR0Ib0k0nTGUp
         NwgFRId6KD7uxjckw/IKtH79qi0AedLK6Rli95SlK8QMo0fX//EFJNfRhZPz5z09KFvD
         aR+NLJmRtGt4nq1v0W6fx84FDwY0z6eSJOsbFm16PMtX/5WHPCTDGqGfhNSkkMe4cThf
         WDrUEhHLMuZQO9mGclHa4h4nfJUiFnPfukT+KoOWMia/nRWVvV8xXptC233Mxc10xoH8
         DNRg==
X-Forwarded-Encrypted: i=1; AKwUvBzt07jvPik3nItMVgZBRSoATNXzguxe/f7swA0ApjYnTTx3X+D6XsZhP7KnhF1RkbMkym0=@vger.kernel.org
X-Gm-Message-State: AFuF++majyc2s4qdj4zF6zlycshiRvHTYiBghGozdr7AVw6/ybbHQpMf
	Ar1vcKiGSQTg6amGmu+p9T+ayZlC09kLsK1M+aTJ/kXd/ru9YQEkPyCZGG7u9G5Z2+kJA9/D1bt
	njiaN9A==
X-Received: from pfbgd4.prod.google.com ([2002:a05:6a00:8304:b0:87a:ea08:6067])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9504:b0:879:56df:91e
 with SMTP id d2e1a72fcca58-87956df0d09mr5762408b3a.41.1790024787615; Mon, 21
 Sep 2026 14:06:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:06:16 -0700
In-Reply-To: <20260921210616.1024168-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921210616.1024168-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921210616.1024168-6-seanjc@google.com>
Subject: [PATCH v4 5/5] KVM: guest_memfd: Drop superfluous WRITE_ONCE() when
 binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
during initial binding, as the memslot *must* be inactive and unreachable.
The superfluous WRITE_ONCE() was added by commit 67b43038ce14 ("KVM:
guest_memfd: Remove RCU-protected attribute from slot->gmem.file") to
maintain rough "parity" with the existing rcu_assign_pointer(), not
realizing that the only reason rcu_assign_pointer() was used was to make
sparse and other checkers happy.

Cc: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index c094611f7c7a..11795ffe5830 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -690,7 +690,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
 	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
 	 */
-	WRITE_ONCE(slot->gmem.file, file);
+	slot->gmem.file = file;
 	slot->gmem.pgoff = start;
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
-- 
2.55.0.1082.g2b9226bbc0-goog

