Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011833;
	b=i2csoX0fFpUN3/2pmB5dmKOMvWmFOUMhk2iQrR8/Din70BeU/dIz5C6y6TmjL4CJRCma
	 Vhiht9+43Ud9GcuPcbCFeFh9Z1lLjIPjlVnzrI58l6n8Z2AtMq7KE/hi2dDBA/Z5CPEEN
	 dJZfqsZpXDSleNmzNYGBpl/NT7msIlMUlf8Qfc0l3hBX8l9My9NXyYRsLDHEt5mxXUryG
	 8p06/Q1TpLGqrSaKK+6c845j4AlrJwkKtpmGHCSj5SJb5C4Kk/1pxXBuoet2uybYFfBRv
	 IcS8VxEdiEIictlWeSGA3XA/VKNcy45JpJ7L302F1HS0LJP3S603vYhCmzuCk5V6ruQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011833;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uLW8bdur/8fUhk+KhilH/kFhEA9n5PcjU8DdUabDklc=;
	b=rXondS5X+92WQwV1DO8rBq08M1npRxYmpP4130O2IMQFU/Eydgf1WBxnlCy7SsnFoeVI
	 4IF7FiA4cAKsMvV48zjD9Ypv8DNpHsBWrgt76mIxta/enYmxxihqDEcl+3mLrguI6y2yM
	 /MiBC3FHS+rIyysheqalbPcR0ruV+RxS0SP1BLl5pZ1528H5rHX70GrnvHm5+XF6axkYV
	 7vQCqMeToaQMR/nsH+GpJz2zC3lQbg/lyjmbwIDFX+G0KfKbLRYBe+9mNKGEFqoLKvCT4
	 BXkL/NhCyGs2Es0vAFnAt4VHLh2W0pEsQB2qPgCqmvdN7ZnlbdjsPpO/Gm8gYN3FhSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCa2AMHt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9D60A5BCB;
	Sat,  7 Nov 2026 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCa2AMHt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011832;
	b=Uapo4BuavcXxzV4g5lql8qbC/4xVmhLxQO9V84U7z8U3WGAKII07vSd88ScQXnOEK6pT
	 dyYnjDpXDVhC/hMJ6U+gCNnfBZqGUSHuYb/8LWfznZ8uQ0VhnNGLMOSmZe0cpB3xyoyJR
	 ALXD0COSmIzOEh/O39VpRDHp64aUJ7gzlw/FCIBaMgh4WZeJZ3HcYvNhZWE54PwGat+tv
	 yB5ZI/lVKKmxDFcyyEPi1mEndWYeMzQ/HZtDiZlVbpdF+CSoC9UYKB67mDZ1yPAY78rTU
	 ghidlgCPdNnj/n3aGw1kUS7odGN7ME+SYKpc7fDAUPEMURYrNk3l5Vl3afftlV//PrQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011832;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uLW8bdur/8fUhk+KhilH/kFhEA9n5PcjU8DdUabDklc=;
	b=DWl30cbsuHhs8edx4V6Piyc7uyeCCSBVKzifKFK/u9yyYQ2cTNn6pEPbAwcyAftOF0qH
	 Ugfr2Um592gRpptrdSQXcv5BlS+it8o0aR5lPL8qVsFctd5U2dt8xhTS6xEJcRnxblbPd
	 qBJzgEQy2nHlGZTIVHF3OhuBi3xnD6JN7zNbrruIjl5lJmKpTCByw85E/vmUw0HhD7BCD
	 5ZLp778TNO4pU1/vjH0++R8jms76Q65IAc0FMCmBcBNB4fvF21bfWhckOagqFEpDUA75h
	 /XCAWPsdHxkI+65oTxGZg11YjUj9OZ0DYvkk7jnf9Pd5tPHMVdpExlTYWOwS297u0+A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AA1DD1F00927;
	Sat,  7 Nov 2026 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011832;
	bh=uLW8bdur/8fUhk+KhilH/kFhEA9n5PcjU8DdUabDklc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bCa2AMHttKeIEbK/uAy3HZ31RCBFfqe/qpCMW3pNkvhn+8zJpKcS43a3icuzHF+Bm
	 vW3kv6erFIpvmOmOciklx/zZGh/rL7uRsvz2jxQF2XvbGg8NhqfzLIfzE/eAP0zVd4
	 6shAdr/IuP9fZfbrr4PfPhsZ2zWinPl6X6tLLYyjmm+gnBO21BKX+ELpnNRZ0zRVts
	 JOyvnXw03BBIwzEsTatyRARV2qDmB/S6FBB2ZxfYWbUMJ/fIwNq0sH5u0yHd7Onj6N
	 8uvKy6H3jSA3G3Czo39KA5dIZcOre9vXRlxaBDS3yLzoIAHLelTumOyEztSIKStqOp
	 C5+z5p7yZ7H+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 86BB8479E1;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:27 -0800
Subject: [PATCH RFC v3 53/88] KVM: guest_memfd: Support
 check_set_attributes provider operation
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
Message-Id: <20261106-gmem-alternative-providers-v3-53-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3677;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=4/4nca6vwG0g+Wn7pJHbmNNbLNupPdnyAc+KxS+ZWuk=;
 b=4XLQVntDynKX6Hg61os4N4mZ/7bH7llDByPzeK1+3F1ZkrFt6ryuxsC2lG0iwgffcbuQmL9lt
 ubm7if6Rr/sAdM97hG/ER6jDIEJ3FeCcV39rg4Ept71S/oiS0BHnOZR
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Allow memory providers to validate or reject attribute changes on a
range of memory offsets before they are committed.

Add an optional .check_set_attributes callback to struct
guest_memfd_provider_operations returning an int error code, and invoke
it via gmem_provider_check_set_attributes() under the exclusive filemap
invalidation lock before preallocating maple tree entries or unmapping
userspace mappings. If the provider rejects the attribute change with an
error, fail the ioctl with that error code and report the error index
back to userspace.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/guest_memfd.h | 12 ++++++++++++
 virt/kvm/guest_memfd.c      | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index a2af279cd3c34..cd634576c9af8 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -88,6 +88,16 @@ static inline bool kvm_gmem_pfn_is_cacheable(u64 pfn_attrs)
  * @mmap: Optional callback to set up user mappings. Called when userspace calls
  *        mmap() on guest_memfd. The provider can customize VMA flags, or reject
  *        the mapping.
+ * @check_set_attributes: Optional callback to validate attribute changes on a
+ *                        range of indices before they are committed. Called
+ *                        with the exclusive filemap invalidate lock held. The
+ *                        provider can inspect the requested attributes and
+ *                        offset range and return 0 to allow the transition or
+ *                        a negative error code (e.g. -EINVAL or -EPERM) to
+ *                        reject it. Once @check_set_attributes succeeds, the
+ *                        provider must ensure this result stays valid and
+ *                        constant until guest_memfd stops using the range. Do
+ *                        not take locks held across kvm_gmem_revoke().
  *
  * Used by filesystems and device drivers that provide memory for guest_memfd.
  */
@@ -103,6 +113,8 @@ struct guest_memfd_provider_operations {
 				unsigned long *pfn, size_t *nr_pages);
 	void (*put_pfn_range)(void *provider, pgoff_t index, size_t nr_pages);
 	int (*mmap)(void *provider, struct vm_area_struct *vma);
+	int (*check_set_attributes)(void *provider, pgoff_t index,
+				    size_t nr_pages, u64 attributes);
 };
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ec908419e5faa..61a3ff7fcd84c 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -210,6 +210,16 @@ static int gmem_provider_mmap(struct gmem_inode *gi, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int gmem_provider_check_set_attributes(struct gmem_inode *gi, pgoff_t index,
+					      size_t nr_pages, u64 attributes)
+{
+	if (gi->provider_ops && gi->provider_ops->check_set_attributes)
+		return gi->provider_ops->check_set_attributes(gi->provider, index,
+							      nr_pages, attributes);
+
+	return 0;
+}
+
 #define kvm_gmem_for_each_file(f, inode) \
 	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
 
@@ -1083,6 +1093,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 	if (kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs))
 		goto out;
 
+	r = gmem_provider_check_set_attributes(gi, start, nr_pages, attrs);
+	if (r) {
+		*err_index = start;
+		goto out;
+	}
+
 	mas_init(&mas, mt, start);
 	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
 	if (r) {

-- 
2.56.0.455.g6c5a503b38-goog


