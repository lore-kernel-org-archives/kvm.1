Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0C3BBFC9
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735894; cv=none; b=SSM/nZPiqrQyuhlX+omvNLh32ZW3PiIXlfsatwLbxmwGkkImT63wfjgqg5qV2Qor93pmFR4KvdWpnxnObgj5l+dYvoky8TDspJZqI2z+/on7yn08M/yRTyz3ci8TsSuUVSAtMe2CsrajxLbW5jTIn6+FPZ5/ChpjxWOu/1Op0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735894; c=relaxed/simple;
	bh=G1Oe3vHwLnwNUEYSyDQugighaFv0EtGtjgMjuieTH7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ENZxDVXxlBHzhUR9/hHVoD88HwuCpxeOsiHodNE+XN3W9K78KfrfnRNE2ezEeqt4Lyhq4HjxR7dgT9A6XcquIdR/fp7TNzViXy7T0QFKoHyw/WK2g2/VmbYQrPpZDW8pzHqcR4RwbG/IUAnK9+QIqg/t+8QSN8mAawv4wjvMJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azdOw6Ro; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azdOw6Ro"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc640dfde3so12087245ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735891; x=1788340691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XDSSI9/m82E8oEwBtVX/wDbyuOojUfBfVTSxkje5Co=;
        b=azdOw6RoBNJyiFoUKQ2uaMAo1v5ndrSG7BhE42wIKTUdfH4gsbSDGkc9p755kjYL/5
         Rs5EuxBO8Se91par9Q7R+lk0Ib9WJdNBOGQHqs87BzdMQboOj3Y/uq13fA1kDsySXMnU
         WH48x3RTjTckoxf0IrPYwsEO/hM6IqTG1+cG9FIwuDwe1ZGriPiNfL+d0Df49JWpKUHF
         aUfDw38tBvN1QwRSh1dPQyOx8E5p/Ad1bLwaY7v5nV8s4C960d0yiw+G1/P8AYPQmo+H
         N17HFvRNng8wYhYvBQgFUpTbmg/HOejOHbhyZ9os0rt9W4VjgrBfgj7cjx7fmP66K+7C
         fG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735891; x=1788340691;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XDSSI9/m82E8oEwBtVX/wDbyuOojUfBfVTSxkje5Co=;
        b=MQCls8XnDZzVJOlhexPUxSal9My2Qa1nu3WSQP7W6CuSGDolZ0wRLvxTB06nSc2nd4
         7rHFzGSanlZJrXYgB6PLYd+uvibEQgjC6Ha3L19MTwlLYdAZ46wR1GXKxjahBCVBV29O
         2jhRsBYMDICpzkKPfoR+7sl0STDtDaf3D6AeJtEAwl9x7folIq53MCTTtDtgkoj+DD1o
         KuUAyGEkGbRV73LW+9us93woP0k0wzjAeWcL/votMowjgWpLHARxL0Yjy54JNJdS+jGu
         zB+YwezFCWgDSbtTurZsgo7LU7ReahRA02JgoXMHEy8cGggvE+LvgnWUHpHmvKEEe9gm
         GzxA==
X-Gm-Message-State: AFuF++kBZ7VZ36vYegQByVQk3fCgBWcWcFQEukLARj1v6fZFU5yhdufD
	Ht0U9WvrGJlRDF+IlZc9yhNkbgwSF8gdUEIji53MkXcjlX3tQdqiMseBqilYVfG02K+cBlZzTkW
	j0JJ2wV1BJLhxIMDx107LaDTGoQ==
X-Received: from pldb5.prod.google.com ([2002:a17:902:ed05:b0:2cf:b7f5:bad5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70f:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2d707b7f68emr92673465ad.9.1787735890408;
 Wed, 26 Aug 2026 02:18:10 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:00 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=1236;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=x4GiehEvwthbo+pCvL6V9adeW5xOS5C7xTsIhL+6Zek=; b=s+IQgM8B+Ybq43NAJgLoaKZkS9bVwFm6R6sUMh7Ta7t1ZqeXaVdBjvNLlZzPswTgV7Us8uM7H
 f7uNAG5zSptDljo14pDwFoYLa2yBFAGT9eOULI9I1qN+OBHVWQBkK3T
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-2-0a15d8a799aa@google.com>
Subject: [PATCH v11 02/46] KVM: guest_memfd: Use kvm_mem_is_private() when
 populating guest_memfd memory
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Use kvm_mem_is_private() when populating guest_memfd instead of using an
open coded equivalent.  In addition to simplifying the populate code *now*,
this avoids the need to provide a range-based gmem lookup API in the future
as well.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8f8e5b6b70134..2c5857a73ec94 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -805,9 +805,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	folio_unlock(folio);
 
-	if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
-					     KVM_MEMORY_ATTRIBUTE_PRIVATE,
-					     KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+	if (!kvm_mem_is_private(kvm, gfn)) {
 		ret = -EINVAL;
 		goto out_put_folio;
 	}

-- 
2.55.0.887.g758fc8c411-goog

