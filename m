Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011827;
	b=eYQk5NSWeMi2aRQMWys0K38+SSLmtPrfy9uuJeyKa6rAFdcrCoG0uWH8KIXDX0QIzuJT
	 aUEHwiV0pcd2w5Fnq1C5G53AfboYcLERF73/u9LEBRvFFbqCOOIDvwAHPcTJRHxg5Y8+A
	 dwTaeT1QkmxHhY36c7/BV4T7cln5yyWIoxvtlxdEHunQa0axt1n7rb4Oi0kUoFWUPg3wj
	 Gqi+So3VVIF0aLFpJOgAFMun19VA1H88KKcKGi1hdqjsEKesmFFs+SHZDMDi6yNzjbJQW
	 yYmC1sKw/A9ACuCwK8Q9zc1pcyO6DHT4/n2Al9AKEJy6bC4ZjG3ajLdLbiK/GJoPP7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gk2cfa76K7no8CMo3L+lgNXbKBncI0WegUISZ77kabk=;
	b=RCQxcVfMvgl4l+bKdJ7mieR6owf7MmbfaOLqmacfTqMEC4ZuV3GVtlyA0wv7JH4+CHo4
	 /HIbZ5aJrZr3Yi5/N/EKJrhhnnXT0vy1+8AvJpJDFc1bVhWRvCp1H7K2LRsp+1sxm3/C7
	 MlY9eYV02pM8puqF16pDnq93/khWAkxIoEgGw/xA9+DWuXrXTkRtKY2dmMew6AFUu6p50
	 QjtDi0MWnRapQJpwqPFa2SPcz/dZ4SZ0XrZDCdevWJh0HPCv4Bu7F11xcZpXt4RSUKrJ9
	 VDb2zYRQVkSf0dDlCddcvyh01qXf7w2RjwrMm4rGnShfXqkSMep4/+8mvjVk/32SJIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH3WWfas;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79445606A330;
	Sat,  7 Nov 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH3WWfas
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011827;
	b=mcEZurotoTGb64iRyoCWiMi4CMxhAn5e10H4rLOnEn4TicyDhmvmzAkEufymJgPxxJZm
	 xM32x+4V3wD+DxrLNcchy95aLgtHEPDN7+w0KRqdtWe6V3YvAt0E5gNOr4GosGJE9w2GW
	 4K2LMEQpQxdWJzrHnzwxJIeCkNRQfqI9OHBYKLWHLEhGM5XHtRcFdVLQYnTja6gPTk5qd
	 4E0HQO6d8Pfmy8wMHcMmY58b8LKkGpMJDb9Q8l7D985B4Uj5V1lX5FfHtf1RBGnM+QS5a
	 d7V6UIoc9FVxpLK+EQPeH1oie2XoG7GzGLwjk8XIKK7DxDCFfofDaMc9x1NZhnDFvew==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011827;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gk2cfa76K7no8CMo3L+lgNXbKBncI0WegUISZ77kabk=;
	b=2ACsTiQ/ldUoSvf48j02V48Gv/bGaBUy6OwZF8Qj3WRNbUBTMnFUAnmVmYgdnTa4QRFI
	 jTZsr5vXDB+PoyDB9ct1QCYLaBTU9y7DFl5owd+fcrToJATt0ae9t6g6Vjtt5CmltsbVf
	 JJUS4V39w1H3JDNSyC5p2kgbEFYE4DBgWKIbCuzMNp3TdAbxtMIkGLDC55nk3K9b4wWfX
	 M3PI9+PiIm4wHX9lpPdvurXZf4hHw+VfJ9CgAhm47H8w1RQSu/ckvOhP7lVPA9g0lDUha
	 Zi2FHsNbdYfFFS716qYpvc1sL8uxgC9+RClBwf/1F61lmomHxpItyal+WfgO74UMaUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 23DB31F008BE;
	Sat,  7 Nov 2026 00:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011827;
	bh=Gk2cfa76K7no8CMo3L+lgNXbKBncI0WegUISZ77kabk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DH3WWfasNX9pU6d7+5nZbKIKlHITxk4F1lol8+uHbsv3C4SeAQTKuwC4NSxr1hkwC
	 WOPzLbe8hS9k3ohbvrSJKemeUSrj6WGBMZtkeg3dpbOiClVc7LIhhnm+M/3qkQwqLf
	 ucGG8JcSCBpmEG85PCxbw+bh0J9iJgon90Lfbemsa2/2zYhyrNHAEIKVJEe/gZhQrI
	 FDltKnrLOBDnc15SXXwssyEB4hQBKM+ZMW27G0iFs70QcZag980Sv3fUD6ur2OvUmC
	 5BSp0svcy57z6USNpl9t+7UGDnRR+xFnFdeQqzHbjjfMEyG4nKC0h9BIi/ZQ0z+hTv
	 jKNNjUaHCN0NA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 774AB479A5;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:11 -0800
Subject: [PATCH RFC v3 37/88] KVM: guest_memfd: Support reclaim during hole
 punch in PFN mode
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-37-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2960;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=A+lPi/p3Z1v064hQ39rLQoc0mJDvEqRw5dAJ/Tf0TGA=;
 b=6VCGlYPnFECRKbsAYmAxaDdiQTXZkKjRUn6KFTvTXc0TY/u+JgD3lmHTmh8qRzAJPogSJ8NYY
 STV4EajIPm+BAO+vnnyua9N/mlAtLGXUkAoZ9GqrdKnUInexv9GyoVd
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

In PFN mode, guest_memfd does not allocate or insert folios into the page
cache (inode->i_mapping). Calling truncate_inode_pages_range() is therefore
unnecessary.

Instead, call unmap_mapping_range() when in PFN mode to unmap any host
userspace PTEs over the punched range, while retaining
kvm_gmem_invalidate_start() and kvm_gmem_invalidate_end() to zap stage-2
KVM SPTEs.

Reclaim any confidential architecture state (e.g. SEV-SNP RMP) on provider
PFNs across the punched range via kvm_gmem_pfn_reclaim(), querying
.lookup_pfn_range() to skip unallocated holes without allocating memory.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 9e8204f5c2588..567735a564c7a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -149,7 +149,7 @@ static int gmem_provider_get_pfn(struct gmem_inode *gi, pgoff_t index,
 	return 0;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
 static int gmem_provider_lookup_pfn_range(struct gmem_inode *gi, pgoff_t index,
 					  kvm_pfn_t *pfn, size_t *nr_pages)
 {
@@ -385,6 +385,35 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 		__kvm_gmem_invalidate_end(f, start, end);
 }
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+static void kvm_gmem_pfn_reclaim(struct gmem_inode *gi, pgoff_t start, pgoff_t end)
+{
+	pgoff_t index;
+
+	for (index = start; index < end; ) {
+		size_t step = 1;
+		size_t nr_pages;
+		kvm_pfn_t pfn;
+		int r;
+
+		r = gmem_provider_lookup_pfn_range(gi, index, &pfn, &nr_pages);
+		if (!r || r == -ENOENT) {
+			step = min_t(size_t, nr_pages, end - index);
+			if (!r)
+				kvm_arch_gmem_reclaim(pfn, step);
+		} else {
+			WARN_ONCE(1, "unexpected lookup_pfn_range error %d at index 0x%lx\n",
+				  r, index);
+		}
+
+		index += step;
+		cond_resched();
+	}
+}
+#else
+static void kvm_gmem_pfn_reclaim(struct gmem_inode *gi, pgoff_t start, pgoff_t end) {}
+#endif
+
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	enum kvm_gfn_range_filter filter = kvm_gmem_get_all_gfns_filter(inode);
@@ -406,7 +435,12 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	kvm_gmem_invalidate_start(inode, start, end, filter);
 
-	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+	if (kvm_gmem_is_pfn_mode(GMEM_I(inode))) {
+		unmap_mapping_range(inode->i_mapping, offset, len, 0);
+		kvm_gmem_pfn_reclaim(GMEM_I(inode), start, end);
+	} else {
+		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+	}
 
 	kvm_gmem_invalidate_end(inode, start, end);
 

-- 
2.56.0.455.g6c5a503b38-goog


