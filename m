Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011832;
	b=BOhDhn4l2usH9LnFYxRFKnIfhGEOVeNXHsPk3NrbN4l7BvIy8MHSmGSdytkTBYv9LG4S
	 uCSv/yChPrve/l9UZru6IYMUgUD+eDL+1wtglA6fXpmuM+yPV/+TF8mn13bv6brjpKC5j
	 e3kDtg1AsZugyzwei1v6Fb3bE72JBjb2BqHzDtrbSxzJZms/YvPgfL77b8q2MzJDrUj2G
	 kmyP1oEuuRPkPoZBcEHHajcxYx1QMsVnZbrKrgjuXk0QTGOBjq6IqzSipr0VrLhwYRYAQ
	 ZidF+9BiiwnOf5Xkb9AVCnOZvovUlOWuF2PAZ6Q7DkR5leLfBr6pPnfLZPJbG4ZfifA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011832;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FGWsnYqelckA5odB4+LLJtGn5PbqWBoisDGGZYMx9/Y=;
	b=XsNxzy3unVOsAuhSWzJB/qlWWASpEkN0vNE9Pv2AojsMyQhG+2yqHMH9yf65d/UCH0pm
	 wJBIVZxxZ/agCKFJ9R1or7MepCB0eT+mgW46DLdDBTEHI5+KJhPmRpn4KeD9MpBUG1KSq
	 U6eUl3kbnwi2L1JOzGGP/tAkcaGIc5UibrPWgX0iJM3KiD1HdwwwThBlYXa9emzZivZ26
	 doEBPc8kuUU+Hcq2XFVUZyjOietQQzz5EtWG7+EskxYdbwo31iTHXy3pq43qi9py+NMzI
	 eCF0fDo6xpzonAvKSnOcFs0Uo5UpkjY13xph0xZK5JTd0G6PlaWcg0IPMMS0z0O9EUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcnwaiGM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236B606EEB5;
	Sat,  7 Nov 2026 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcnwaiGM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011831;
	b=qOn1fNGq0704KiLx3lCYlu5n/Yc9/q5wUancDecwc3Avhd+aHxdnc2dIRgtWVvsXAF1b
	 auDouWwlaDEvZuJpYzJzTN8IOpslG741XfIHvXWHWXFNEXjhw0NEUBX5XI0eAkWXXTV8t
	 0aB2CK2KBWourXkrWnex7C2mhmEU6LDnTRaV63EPchbcCHOvHC8EX/mB0Gdw6PPlFvUMo
	 NEFmexgPNLgbTEs17pZrFdKBFJbAfrWzj6+Jeln4npTUBMy+8URMEKzwRCMH6dFtDugvw
	 8/7m/Av6S9MEN59queZCRNnvEaSmPf4LCY42O4NwjdMjf38WFOjvEPXdlgYW8ucFHoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011831;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FGWsnYqelckA5odB4+LLJtGn5PbqWBoisDGGZYMx9/Y=;
	b=Q8azgJ0e2dCNjg4tfBx5pbJaLLkcH6WbmS1/idrWRji5HqR4pP0j42aH0nwPtw8RLYBD
	 I8oAWrlKAko+s12+52UZ4GsUpZE1PemOJhfiYTnWaL6sNReS0+0RtJL3M+8svTRPaTg9F
	 kBV2A1RitgN+yR/PggykGi0TRvIPnjfM1Ip6owe4YCzw1TUn0JboVFzbKwD1mwpxrOw9q
	 CzeVAi7JzgGhpD5fZUjvp6KKiS2OZOf095rTwWKYbbi8PHhY2UfAg2eRrzXiohzE1c+qb
	 g/z5/FgWdtb8IZlZ1solbNXZdM71GfPwPP9jvSm0Yc4yKx1vFD6ph8MNuwgC0H1Xarw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E8CC1F00A06;
	Sat,  7 Nov 2026 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011831;
	bh=FGWsnYqelckA5odB4+LLJtGn5PbqWBoisDGGZYMx9/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RcnwaiGMECQc6kht4jjL8l7gHWTkWfvyZu173dA2iVXSLhOfwYdO0JuvLSOxCBJpX
	 a/DjDP+q+aiwFC5LjjXMQ8JbGK+o/ydPU5xAa3+pt/SWFiTP2xkXGMusqtefHXE/pa
	 GUni9bTV0TVIGHCBbHI5n4ZLbOUSUkG/UYYYzmltow0boIEQmh8S7xriyAYbIQzJsK
	 FDt/4y72TEreFc7DKrOYR/PK8Rt4BbfInZwmQNy8TXBkYbciJlLNZ1uJmIWGWQpmhb
	 MBcM2p5CuyzH64nMGS7+RHNJgd7+qxFyfPzXv6OyWHycYK4tLX3Ci4sTFsd8NkJ8Ow
	 Wf0VZha9ElCFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7698D479DD;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:26 -0800
Subject: [PATCH RFC v3 52/88] KVM: guest_memfd: Support mmap provider
 operation
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
Message-Id: <20261106-gmem-alternative-providers-v3-52-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3134;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=S8Nn9NlzC19FEsDW/4vv5XCK3el09MMI9122tikd9N0=;
 b=qFWCP9ocy+CJAo1wAx8I62v4m4/bwjbD4jcoXy8lKZE5NFzAeR2EgcdTl2MSl1EOSgIt9Z528
 Mu3iaaYc/xFBJic9zQXSjuIt0XgQbALEABnfwb9x54IpphtX+CXdJLk
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Allow memory providers to customize VMA setup when userspace creates a
shared mapping on a guest_memfd file.

Add an optional .mmap callback to struct guest_memfd_provider_operations
and invoke it via gmem_provider_mmap() during mmap handling on
guest_memfd descriptors. If the provider does not define .mmap,
gmem_provider_mmap() simply returns 0.

Invoke the provider callback before setting VM_PFNMAP and guest_memfd
VMA operations so that PFN mode mappings always have VM_PFNMAP set and
remain mediated by guest_memfd fault handling even if the provider omits
the callback or configures its own VMA flags and operations.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/guest_memfd.h |  4 ++++
 virt/kvm/guest_memfd.c      | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index 8cdc334d1c9aa..a2af279cd3c34 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -85,6 +85,9 @@ static inline bool kvm_gmem_pfn_is_cacheable(u64 pfn_attrs)
  *                 available, the provider should skip the unbacked range. Not
  *                 called on kvm_gmem_revoke(). Do not take locks held across
  *                 kvm_gmem_revoke().
+ * @mmap: Optional callback to set up user mappings. Called when userspace calls
+ *        mmap() on guest_memfd. The provider can customize VMA flags, or reject
+ *        the mapping.
  *
  * Used by filesystems and device drivers that provide memory for guest_memfd.
  */
@@ -99,6 +102,7 @@ struct guest_memfd_provider_operations {
 	int (*lookup_pfn_range)(void *provider, pgoff_t index,
 				unsigned long *pfn, size_t *nr_pages);
 	void (*put_pfn_range)(void *provider, pgoff_t index, size_t nr_pages);
+	int (*mmap)(void *provider, struct vm_area_struct *vma);
 };
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1fbb719f0e31f..ec908419e5faa 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -202,6 +202,14 @@ static void gmem_provider_release(struct gmem_inode *gi)
 		gi->provider_ops->release(gi->provider);
 }
 
+static int gmem_provider_mmap(struct gmem_inode *gi, struct vm_area_struct *vma)
+{
+	if (gi->provider_ops && gi->provider_ops->mmap)
+		return gi->provider_ops->mmap(gi->provider, vma);
+
+	return 0;
+}
+
 #define kvm_gmem_for_each_file(f, inode) \
 	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
 
@@ -860,6 +868,7 @@ static const struct vm_operations_struct kvm_gmem_pfn_vm_ops = {
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct gmem_inode *gi = GMEM_I(file_inode(file));
+	int ret;
 
 	if (!kvm_gmem_supports_mmap(file_inode(file)))
 		return -ENODEV;
@@ -869,6 +878,10 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
+	ret = gmem_provider_mmap(gi, vma);
+	if (ret)
+		return ret;
+
 	if (kvm_gmem_is_pfn_mode(gi))
 		vm_flags_set(vma, VM_PFNMAP);
 

-- 
2.56.0.455.g6c5a503b38-goog


