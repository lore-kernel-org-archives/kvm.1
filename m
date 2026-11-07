Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011827;
	b=QYUPi52Qy50mqCjuP0yBh9tQc49u+0DC1zfEmDT5Vz5Uu21hTKqBMw9JK5WKpoeecaUW
	 STuPYNus0KfNbckHvB3HZhJqduJGrbi4oSSRpm+lIzlzdpAkb6u5yfqK8ghdORqjg3eXC
	 SpfhFl3AVK8+Zf26l8mVXe8ojALve6/LwI89PxQLWySxroHrTDhR12MZGBBsAekN6eOp9
	 NOxevMd9e8f+5Gqt0GJVi1+KC2rfCheGdrcjVYQqupII+2PVklve6WhED1mBpMpkm/fh0
	 m0wfSDDC7PtwmEuQ2olJU+Zs11kYwkPvEWTb9I1lVsbLlgwAStO7pf0HqpblVnI4V9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JrP6l22VK6AldWxiWhpFsQCv9l0Qgcd3J7DNoznOHbY=;
	b=jP1YVt6qUGUw9ECErBx504zQPtYY/mUzZ0BIcp0jZ9mjyzR6JrXnTlbMM1gUtWSf3LFI
	 wB49+yI+A+FnC8Te6U9hIotZ3iFGGCVyie46FZDYi2cSXnll3ahTFFDmC6+rjmfvX+BCE
	 5mZpnflOgizNF5AYMBH/CR9EDhgvbZpwwiawArjjWdrlvgUvjQwAqoi6iYHnzEkx1kfJS
	 1GRNPekUI+Bm9RB18LisXgiVR/x/kUnimBZMKB7IETXNbVaf7HnVMjADDpKo7extf+SAh
	 Uh18Ag6Zsw/T3PIOKqELW1xPunUWh75+YURmvd1cd4s29htk9slLW8ayjTW5aqJw+sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hx3uuviZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAC606D82D;
	Sat,  7 Nov 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hx3uuviZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011827;
	b=pIOf56ltUFVp8TKwdob/sf3XUAs+kP859hXEEnm3HATr5salmNva4s9ecN+AG1+/dzuk
	 HZC4TxCLDb52v5REw+84eeocIx38cGUDKC4pqmc3ISrnRqvjZnyyBav5CZwtkToZ8fDnj
	 1Y0xsj17LxTpaaX6JfsibOQ24/GVogkfLRMsqT8jQMiLTonHGrP7BeHGlboqSaqJieyWQ
	 eeyyQXRWb9G+UGKytJFLC5hy8N9L/q0UvKLXsCax9l8c1E3Vge//664xxoH/NZefUQzpI
	 YBpWIqxg/RWOpsspqW+d+X7fmvUEtY4QN0uGHl/dQ1HK9njo7BYRdRKtFEpIqHaw3dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011827;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JrP6l22VK6AldWxiWhpFsQCv9l0Qgcd3J7DNoznOHbY=;
	b=bngrH46gRD3bEbiwOoWvBz3tyFeKOKpAVEUR48EtzyF+Fe53B6aqQTf8E1JzVqtF63a0
	 TlgWns/3Gd3zi/uCO+bigQXlWNLpuXxxWJ26p0WVpyJIjK0WHY6ep1qw1y0eANfZybqRk
	 LGB4c0Bn2gDPNohj0VbkAvcTy4ni0X1FUKwDfOkwlIoMbpCqgsYcIM57KhXVtg8p44uTC
	 CWu+Zrb3TkHsxP9WYBO2BvZqOWPrOORsp3mq0IS51Zr9ODPmkIeZGQTtVEAIW0C6EeY3o
	 l2X09eYT7Z5YtsSW6NMRGEUikAh9YjrK5t8OgojaJlBpzgEJj1h6HVE6aGFRXu/Lrvg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 24F781F0092C;
	Sat,  7 Nov 2026 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011827;
	bh=JrP6l22VK6AldWxiWhpFsQCv9l0Qgcd3J7DNoznOHbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hx3uuviZV9dttW2piCRtuIyn3jTtJRrhwB0hi1IIp6523Hpbpx+Mts8ZNhfp/NJBi
	 so5CvAr0GwA7t1HyRTbMnY1r/NYb/CYGAAFRoxKzC5twOsJTyA8SHQZfuYbGTGp5gI
	 pHCUrWFXj2e8g1CU4SEM2qXrjahR0M4Qw3cu0mbjtV3SZtO4VE5TUUTyiiAxR3QI3+
	 Yd0jAjO6a67U26nYAsT3Yh2KOcTmHizCiW/MG6uZWR/9WpD+f2DQTozQXcwHRQng2d
	 Cb1KdUW4OCMJ5j9OXHozuEXe+gmBQBA+cDtk5yM9Bj4syufJ9BVc1rw1CFNPvmIkV9
	 NA9zuB7OHFxqg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 564534799E;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:09 -0800
Subject: [PATCH RFC v3 35/88] KVM: guest_memfd: Support preallocating
 memory via fallocate in PFN mode
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
Message-Id: <20261106-gmem-alternative-providers-v3-35-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2052;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=y5ji1QZXHiuR/oyFz2HLfJNU3wDMuExGaG2bV2F9jH0=;
 b=DW3LHEMrOWHyFBzYbIPFyKM5f6WF7y8psIUQsI0OqS5DAy7Qg1PqfpHwQmy0Y47gdcmY7E2JQ
 Pg5dgsEC+uVDKCSzf51XtagCoDyPmvKfgnkxrFZ8dF0gqS9b+M/7K6r
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

In PFN mode, memory is not backed by page cache folios, so attempting
to allocate folios during fallocate fails.

Support preallocating backing memory in PFN mode by querying the
provider for PFNs across the requested range. Step forward by the
contiguous order reported by the provider so that large contiguous
allocations do not require redundant per-page calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 0e392b8735259..c62e15e05a249 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -411,6 +411,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct address_space *mapping = inode->i_mapping;
+	struct gmem_inode *gi = GMEM_I(inode);
 	pgoff_t start, index, end;
 	int r;
 
@@ -424,6 +425,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 	end = (offset + len) >> PAGE_SHIFT;
 
 	r = 0;
+	if (kvm_gmem_is_pfn_mode(gi)) {
+		for (index = start; index < end; ) {
+			pgoff_t next_boundary;
+			pgoff_t max_nr_pages;
+			int max_order = 0;
+			kvm_pfn_t pfn;
+
+			if (signal_pending(current)) {
+				r = -EINTR;
+				break;
+			}
+
+			r = gmem_provider_get_pfn(gi, index, &pfn, &max_order, NULL);
+			if (r)
+				break;
+
+			max_nr_pages = 1UL << max_order;
+			next_boundary = ALIGN_DOWN(index + max_nr_pages, max_nr_pages);
+			index += min_t(size_t, next_boundary - index, end - index);
+			cond_resched();
+		}
+		goto out_unlock;
+	}
+
 	for (index = start; index < end; ) {
 		struct folio *folio;
 
@@ -450,6 +475,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 		cond_resched();
 	}
 
+out_unlock:
 	filemap_invalidate_unlock_shared(mapping);
 
 	return r;

-- 
2.56.0.455.g6c5a503b38-goog


