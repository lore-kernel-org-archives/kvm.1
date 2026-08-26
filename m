Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CDE42C4F0
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763140; cv=none; b=d6zcoh8AeqUYYQFmB7Wwz/S/KypIphCkRX8ZRqQThSmYE1uHxm9itEbAJ7LErySUhn4vJFqMj7NzTUhiDyxgn8FlKRjH5TR5A1O0ST+MMWmn7KZ1qFbq85n8YC8+f9bSqdMnV2ucYVJL20fdfW5KgqQnFmdg7PVJMKexz4JfXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763140; c=relaxed/simple;
	bh=iqbnxW81PVZ4JrYasvYkpNsH6AAm6QU/fKSXBKEPVe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJ75x6hxwOPpAuVJ7J20A9vSx9DlB/qhNRHIhBPSi+xIeQu++esqC7/V/4AK2q0l9TfUAyjjgyO2uDvou1NKuylON21cjUc1WoDHKfHCMbkYBVOZ8ZMJxpYMyBrkQBzuM4MVRhr7QRACxmbK3WxTIVdWVjGdCKKxPjE7MCEC/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNOy833R; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNOy833R"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8544b721ce9so654213b3a.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787763119; x=1788367919; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3KxgdA9C3Q2gUzH0EONwpXAO6HVPxwiye0akeJiAgZM=;
        b=KNOy833Rl39bZ5UcNb2FEd8yrlC7sivTNJXlFgwDBN70iodGd/QBWp7OtJvxbPuJdS
         TT6dKdYUxR/ta3Ahvi6KaCUikuAoxNSmg+ECDXT8tNfw03AAGgWOcEsDizBrNMW4Zwel
         tAQs/+6aGUGVUOUxRfkjtJA1TZP55bNGsgVF4F9Lw53hgwjSj4q4JBzlJaGG+a4TE2ud
         Nb8pXdvRlkikVY55fIqkzSrf2PG2zOywP7KPmsN/3eGwptzh5Vz62lzkzbnwYXrKOgFN
         X7Jt6RmDpa3PZlNsbX3ZU5OKwDQ9cgG4wDRNtCWhqJthMu7vi365IYe3x9BpfdJBQ/Sz
         ShIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763119; x=1788367919;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3KxgdA9C3Q2gUzH0EONwpXAO6HVPxwiye0akeJiAgZM=;
        b=LaHk7Ch2wJRUrvUeGeiyi9vfKglwIIKecAV9HIj1Gml2v7vQqfBf9aeu8fkFQJjS6h
         tryg5O7pKqj0LtPG+Cq68axJ44bEES0ZV2Tv6IRfFWozOrkKCCfPXE+v+xXOX1i4XBMh
         RfmOMLSLErJbmYfimqTdndQGA/ISlLrjJC7lwJ0Ggh96zgUzVRpw5TPgXwEn18qEvq4g
         mvX2BusZWsV1tW4soE6s8L87PO/Af+cj5gyisTej86wvH6zpynZhuRWSX+E0t1UV8vNO
         GcdIUm4H7l2KGKHIB43lvp7j/j5hUWeU/vNNEpLYIAVLltFQTmgW6ZthU89YKmH453wz
         TpOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVH8Z65DBmB4JYT9e6cYO20eraXetZjTDLgvjkxBUe82hHN/YNqDh7EU4U00TWUKKhrp8=@vger.kernel.org
X-Gm-Message-State: AFuF++nr40sWbVNhD2D0T3eHlJnjW9PmlexnaVRMpKlVzs5Xmhhj7WEz
	81WH2/JjUyXXiddCIeBqre4hmJgEVjg+FpknRgwdGHEtknUNxizR6yahq2EWiHKlBq6furs38aQ
	Yer92Wg==
X-Received: from pfbfw4.prod.google.com ([2002:a05:6a00:61c4:b0:848:487e:d23c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e08:b0:853:6571:9567
 with SMTP id d2e1a72fcca58-853720af96dmr14899043b3a.4.1787763118618; Wed, 26
 Aug 2026 09:51:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:51:54 -0700
In-Reply-To: <20260826165154.766699-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165154.766699-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826165154.766699-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: guest_memfd: Drop superfluous WRITE_ONCE() when
 binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
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
index 1ef9e2916423..1d2de9a1bc3f 100644
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
2.55.0.887.g758fc8c411-goog

