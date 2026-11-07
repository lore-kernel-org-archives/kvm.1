Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794011828;
	b=CQvhbSAvWLchNUrsSygp4MjLzGLNpV+ni1/4EXhViCXtyA6pFjyqipf8fJD2RS3oK8zC
	 d/bVTDaeJFS/DA9yiQXScYwCbZ4Fn7gfPPui3Fm3pZxPUhmHjkdDXsifz20EMseXRRmoa
	 Ijg9u3crG7Tq1P8SX+pfHzEogriioIXCuIKDsSO6AKAu5VXYitY56H4gG4h28HFi74U+d
	 Zmh4HtWatHZptFW6Od0C6+kf+Ebfmo/cOr39cqqzMxHaoNbuMH3SsNsv+ugryAl7TCyh/
	 Il6WymskpfWHl6iOvVv000EIoseWbTt7Vk6HugOclZ615TGos9yoQOR0Jl7baIUh49w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011828;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GUz/9/mzTQxdlLDonugfv3iNeHSXtbV/yXh8/jks3ro=;
	b=tWa5gI4JE8tIZG5jF4axGYyyIngvCckXDDnvVcE1dkAkf7yaB7lWSHov83Ux4550SmoO
	 Jo6fhy/PzNZ0lD18qKmFpU3HelZLKxlxb9fu6qId4Y5As8rqRv6LSkiU7b8zHyTmlW+/b
	 WBDu5Uw0eOO4yxNG0eF4FSHH5fZLGUCQH68kQyfqq/U0xOS5jY6b+wJIV5n8NDNm5jdlv
	 StjYYMsX/SNsNBeYgtJQ1R0ktHQi5wX0KLzNTrWB1Fc0/+AEHrwDhLdN4Kmb7gMTsJUid
	 cywY82Az1Ui4Ytt7nQH1SRfza5y6vACNTfU6f38gYbLofaWQlwaQvvE1sVa0rnNqO7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KRq/YxWq";
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABBC606EEA1;
	Sat,  7 Nov 2026 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRq/YxWq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011828;
	b=dV4FWwyl+0Vq+Wu/eBzRC0Ibq9+BROc8wa3Odl6K8YHl6aCSeh93m9pClo5hDpG0DYhW
	 HZ4QEjw8Nw3+G/eMc9rU1cBKzIn1Bwku4+1RcJA3oFN/b8+KR+yZhglN/zY2DSNxfD8/5
	 EPkduY9Xp/hC0Xqstm3riyTyHZKexsS4F2HRRR4CWDbAAD/usq3hyCKnoDBz4j/MTYhLI
	 6zTMQUqAxDfJ1wLCPxwXB/20rfwFqDWRjm+gNdBvTUF/r0oZRWSC8pM9NaNkB5m79/BST
	 SmPwcS4Z6cgsMLAR0oKgftu//h24VAtHcL9P6ZfCzP1Dch0s2jB6vHC4gk1eK3PZC/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011828;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GUz/9/mzTQxdlLDonugfv3iNeHSXtbV/yXh8/jks3ro=;
	b=b/LEMy9QK2pS/AWbk3BsoPZQJAZtGIt/puD1beexrwd1mPo7nE0gNohY3bImwkHEbHrc
	 UlOw1/A7+9rcgBw5T5ar8X20hm6sXUElLD5eV/0Wx9oUp5qnG9C1i1VHWCEQQHndWvNVr
	 SNUOXpWuQPoUS3pNZ+ooYxuhXGrh2pYo17Ms08nvJid5ASK94Np5aFh+yxNwM2N5Pj8Ek
	 FuAYPNYmcgzGioyg81IaFMeWzhfIcOdoFGyG48tY4LJq+7D8wY6CgaFvpABhju/DvGriP
	 eki2MulVxnliHSS8bpeD7OTD8fskofvD+C6HZQ+fh5JM8QbTTsgmbezTaBSB9JZPZJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D70701F00ACD;
	Sat,  7 Nov 2026 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011828;
	bh=GUz/9/mzTQxdlLDonugfv3iNeHSXtbV/yXh8/jks3ro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KRq/YxWqhzVfhoEeV4pTcwbmxTbXaS8qOIqIjlpPgO9zlIAxX9K65hVrIst7qdEYK
	 ULvQIv5FoWsVzI/7yaErAsNDx5y6f42kHfcfbFl5O1R0aNB+85auducp1nN4iBTs2b
	 LbD/9QDiZeI6JTobHnDWzHTbxLRKxnpQ3qRQixK9kAHMdJTTgKM2c4JyC5xU23P5Ry
	 z6vXsLMKlnSMciuH9cQCyiRVW349zJR075vNNano7TxUbhS+po9zV5lfJMRHZzrAMF
	 h/xtHRrlxCQ9LvyO9xE/FX29RlcQWnAMkEsdQxVAAWkmXGv/vNBmTAkdNdhl+0cUew
	 qGmuQf3YFmuiA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA07D479B4;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:15 -0800
Subject: [PATCH RFC v3 41/88] KVM: guest_memfd: Allow attaching PFN-backed
 providers
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
Message-Id: <20261106-gmem-alternative-providers-v3-41-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=4433;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Zyei1BsCtk1SKBl4SzbsXS5lXr+1x+5G2OuzpP6di+4=;
 b=5boitYkkCw52klJJrXhH/jnyR3Ns54W1YY+lNGd0RYbvbVCX0Kz6fAJI1mx39EqN/pgBUwFAP
 mYtcc7lB6lgB2ZqDJNxeET7odVTl6gVkAsT/2Te9XBbMqdo690wRtvz
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Expose GUEST_MEMFD_FLAG_PFN_MODE in supported flags to allow userspace
to explicitly request PFN mode when creating a guest_memfd instance with
GUEST_MEMFD_FLAG_USE_RESOURCE.

PFN mode is only valid when backed by an external resource provider, as
native guest_memfd relies on the page cache and manages memory as folios.
Reject creation if PFN mode is requested without an external resource.

While guest_memfd could try to infer PFN mode from whether PFN lookup
callbacks exist, an explicit creation flag ensures userspace selects the
operating mode directly, allowing providers to support both modes.

Validate the requested operating mode against the provider operations
when attaching a resource:
- In PFN mode, the provider must implement both .get_pfn and
  .lookup_pfn_range.
- In folio mode, the provider must implement .alloc_folio.

Document the new flag and its requirements in the KVM API documentation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst |  6 ++++++
 include/linux/kvm_host.h       |  3 ++-
 virt/kvm/guest_memfd.c         | 18 +++++++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 9f5313d405d9c..bb550e4f11cd8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6524,6 +6524,12 @@ specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
                                 must be a supported resource (e.g. tmpfs mount
                                 root directory). Currently, tmpfs resource pools
                                 require noswap and huge=never mount options.
+  GUEST_MEMFD_FLAG_PFN_MODE     Request PFN mode for guest_memfd backed
+                                by an external resource provider. When set,
+                                GUEST_MEMFD_FLAG_USE_RESOURCE must also be set,
+                                and the provider must support PFN lookup
+                                (.get_pfn and .lookup_pfn_range) rather than
+                                folio allocation (.alloc_folio).
   ============================= ================================================
 
 When the KVM MMU performs a PFN lookup to service a guest fault, the fault will
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cf679efcf3260..980ce85cf7239 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2619,7 +2619,8 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
 
 static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 {
-	u64 flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_USE_RESOURCE;
+	u64 flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_USE_RESOURCE |
+		    GUEST_MEMFD_FLAG_PFN_MODE;
 
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
 		flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ffe1508985d61..1b6fc44ba00bb 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -85,6 +85,18 @@ static const struct guest_memfd_provider_operations gmem_native_provider_ops = {
 	.alloc_folio = gmem_native_alloc_folio,
 };
 
+static bool gmem_provider_ops_valid(struct gmem_inode *gi,
+				     const struct guest_memfd_provider_operations *ops)
+{
+	if (!ops || !ops->attach)
+		return false;
+
+	if (kvm_gmem_is_pfn_mode(gi))
+		return ops->get_pfn && ops->lookup_pfn_range;
+
+	return ops->alloc_folio != NULL;
+}
+
 #define GMEM_RESOURCE_FD_NATIVE (-1)
 
 static int kvm_gmem_attach_resource(struct inode *inode, int resource_fd)
@@ -104,7 +116,7 @@ static int kvm_gmem_attach_resource(struct inode *inode, int resource_fd)
 			ops = resource_file->f_op->gmem_provider_ops;
 	}
 
-	if (ops && ops->attach && ops->alloc_folio)
+	if (gmem_provider_ops_valid(GMEM_I(inode), ops))
 		provider = ops->attach(inode, resource_file);
 
 	if (resource_file)
@@ -1350,6 +1362,10 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (size <= 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
+	if (flags & GUEST_MEMFD_FLAG_PFN_MODE &&
+	    !(flags & GUEST_MEMFD_FLAG_USE_RESOURCE))
+		return -EINVAL;
+
 	if (flags & GUEST_MEMFD_FLAG_USE_RESOURCE) {
 		if (args->resource_fd < 0)
 			return -EBADF;

-- 
2.56.0.455.g6c5a503b38-goog


