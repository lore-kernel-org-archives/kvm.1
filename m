Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405B3DEAE3;
	Mon, 18 May 2026 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088204; cv=none; b=S7TIWTT6JDtCrBjvMYTypkjwkEorXCsKVaSqb+fBzWXdxdyWsb8a+cAXe0gtnKnw5taJCq9qTxkEp98EYnGZwcDosqsa4qS6N6nGmihvzvUimjjwvi5cKP86MBraTOLDfrrnyMa3TrZv8GM51JcuNf/434q67tI6O58EFd/a3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088204; c=relaxed/simple;
	bh=Gz2L4UQ1widAifOotkrmMVIa7TeFQAy0AXyYN/H8UF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evGy0Ug5tuE1HQZSUELN71vvsv5fvjupqYIh4XgLwo4KS2hbqC34NG5gzx9DvgkOBdKnJqo1c68IUQ665hTW31dakS4Fb//OB0003E5UvgEZHSCpzkW1H8PllBicct34UiAh9caZjP/B97Q8lvYObIzm5YWdE0h2dBqWVnliQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vZmbUDnM; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vZmbUDnM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779088198; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5iZNvof+RdjsqMlKtAD/FqDCIfxi3ZAyT/Wn2CvVtHU=;
	b=vZmbUDnMsAMKBNKDJ9o2ZB6c34gQczCKlGxLcTH5SSEw5FJ4A7GCHwu9TDVpm0a9uvQ5tYGXkKAOarlurV2phvIQlsdc4gLVCuIoc94nZUL78/F4kIiWrh1jdvoCWAR9nmLX1lfL8fh9V97Eh+3qKyurEJ9yT2ipZKLLKz9KWcY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X34onwF_1779088197;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X34onwF_1779088197 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 15:09:57 +0800
From: ZongYao.Chen@linux.alibaba.com
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: guest_memfd: Return -EEXIST for overlapping bindings
Date: Mon, 18 May 2026 15:09:42 +0800
Message-ID: <20260518070943.2091287-2-ZongYao.Chen@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com>
References: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

KVM_SET_USER_MEMORY_REGION2 rejects guest_memfd ranges that overlap an
existing binding, but kvm_gmem_bind() currently reports the failure through
its generic -EINVAL path.  That makes binding conflicts indistinguishable
from malformed guest_memfd parameters.

Return -EEXIST when the target guest_memfd range is already bound, matching
the errno used for overlapping GPA memslots and making the two types of
range conflicts report the same class of error to userspace.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
---
 virt/kvm/guest_memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..46727539d08a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -675,6 +675,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	if (!xa_empty(&f->bindings) &&
 	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
+		r = -EEXIST;
 		filemap_invalidate_unlock(inode->i_mapping);
 		goto err;
 	}
-- 
2.47.3

