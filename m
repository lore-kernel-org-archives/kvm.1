Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011817;
	b=SnNME9QMBnQEm348AO1w3xQLGP1E36kVIJXDdSHWxu8U5D/jiY+J4QC5JxBB5ivRuS8l
	 O+Qvb2jcW78QeFMCREJzkaRBMwKgtd8+CwmOU5SZQ+OEISA8odc1PQf917thOkTKCuv34
	 7g8IPUMfTNJ/YylPEAqFswEYSDWVydq0k7rfsk8iejbjNjNFMRztsW2VTHdFBKc4Pd4KC
	 7H7vvikYa+KSlTwk/iM0drgIvzdgKBQcpA8zpFbgROMOBzEW5646x+7u4maMVbN/eOoBr
	 tz//21bCHvtkNGGWWcl+zbkvLgOUbGmvIBJFfAW1TFxAlhpBsOupSfJ1pU0EzZ8sGSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011817;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wzMjOKIzu33g7FJKvimMpae1iK2TD3Ag5YmcsJozb+4=;
	b=JUkk7fv4iRmIcRgFxCgu6CMUrloBC4aKubx45ORoHZ4Y+889Wvkk+omdpZThGqtiOx4/
	 /pb7CkgSbhjS91StjXmupt8pHKckVufKJeYmT2/EwzWRVbclgScZsuSITNZgPxG0kx/f2
	 Hw7q0KHQrmzEixNvC8QAOD0jxs5zEs/at+wjUdaURODphslNcF2bIxxcPy47faveAuvni
	 VZ/XJSvaC1Bpz6IcDJc2sQDWO+807ZSOg7CWjM4U8AMwcZVJZnhtFw0VrUU7uIa67jYnm
	 IfXJYJlU921see0woSjEnLe/0TE+okx5N5hFVcI2x0PTE9IzI+HU8BzvkuIDHffuhqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECd6EWlw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3140606D82B;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECd6EWlw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011816;
	b=vOtosl5U7F+S1ku04Cmwj3N515jdS1XahrZcC+S1GocfB/tU9oh/72zMSEZtl7iQKGFA
	 5BzNygVvkvv5NjVeDXg4s8dK4hj2LdFhtQR1lMyqcJQtFQMExOTXZjwLyUzS9D8Yimbje
	 I1H97Tp+jmBl6FS+HcZY9mdKjbaDVt1k3ZsB7bI7ycJaRR2qzsnWpA7UOg6RVb00RuotI
	 UNCJy9tVf4+7mvU/5MOneVmJ3/rdPuDJSXeFbr/V+jCeH9ZKeHH0pYXka87211Jkibg2b
	 Vfm5vJem10dfPe+3RprKhtiapA7AQ/YfMNbdxtvbBSQ/cU56g6qIeTztnCBL4sVubcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011816;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wzMjOKIzu33g7FJKvimMpae1iK2TD3Ag5YmcsJozb+4=;
	b=yaVww1pg1RUNUgCGHkvymom8G12jze5okkinEDoWLL2GfbDKDJAWlSbS1j59WvuXoC6f
	 ErTqVFAce67h7jsW2YzK1iZbeJAQmrW3c4KJBmx62GGRCOpbeqUndpkXP7xVcCvxPXfW1
	 o++XlcXFDT+XYQBcF29r7FGJPA7nRhX9UGPrCHuahtyDDTDcSmCN7oFxNJ38jk+/W6ZPr
	 0DnyXdGflbO+3Lz3gsbprm0hX9cRAWFzACoJd1CnioCwg/MDAzyiQZoeDTpukCgd/d6XX
	 ZSH6vkMr3SQzNLYYSC7GSNz+tQblPm4rk2LNoE8FyZav6RU5fwnhX+CQQu1jpqTa4Kw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8C70B1F008A4;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011816;
	bh=wzMjOKIzu33g7FJKvimMpae1iK2TD3Ag5YmcsJozb+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ECd6EWlwhwpl78kL6NkcmvF/DAUiWoizeIdyyXTZVrmlfJrcgh8BwFJSd5gJ/obKw
	 hvhJjVeCtbebCBsEH5O005mbhWX97RPngzbtE0C/Iz5jGNEjthqHbrm2MqSd4J4EUD
	 SYpis7zleFOf0e4egkB6krTPp++9oN6e59dzp2NjahxhNcd9VMT2bYxFclO77V4CyP
	 QUx3wMDbTOiGPiCa/VAkFtqYakJkWNNHeaYQy7Gp2OEyXHE2ru45BmRuizGv1UiGbr
	 tPENSIoHbPMyowNKspA6FOsPd4X80C10CqiIxzuUPVL+hJKryHdbGTWa8dRC+2D/S0
	 ztEwozxRVs15w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 10A8447925;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:38 -0800
Subject: [PATCH RFC v3 04/88] KVM: guest_memfd: Support provider folio
 invalidation
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
Message-Id: <20261106-gmem-alternative-providers-v3-4-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=3364;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=MGHk6/Cisdy/wpa1a0X1OzKyL7CzzGctRSrQGUJPYjc=;
 b=0KoWPhP/+ANsbW65PxaOZBZqe5dkk4DAuC4v1KLIC4R5Fu5djTD8G+xa3t2kfBvY/9v08lGNw
 rD9zaIwVcAjDsEAFo+Xlsb9U+GXt7PCNBe9Ws2/8FhAQMqClCp2gjaH
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

tmpfs increments the total number of used pages on the mount at allocation
time, so that number has to be decremented when the folio is removed from
tmpfs' ownership.

In this model where guest_memfd allocates from a tmpfs mount, I believe we
should respect the limits set in the mount, hence I require .alloc_folio()
to increment.

.invalidate_folio() is then the counterpart to .alloc_folio(), for undoing
any provider-specific per-folio work during allocations.

.invalidate_folio() requires mapping_set_release_always(). Not sure how odd
it is to use that mapping flag.

Using .free_folio() is hard because folio->mapping is NULL by then, so I
can't reach provider information. The provider information could also be
stuffed in folio->private? What do people think of that?

Another alternative would be to use a custom truncation function in
guest_memfd, just like shmem_truncate_range() or shmem_undo_range(). The
con is that guest_memfd might at some point support more generic mm stuff
like swap/reclaim, of some form? Or maybe never? Shall we go custom now and
unify later? Or just not think too far ahead?

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 545c3e646e9c1..ee823f2ef0368 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -113,6 +113,13 @@ static struct folio *gmem_provider_alloc_folio(struct gmem_inode *gi,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static void gmem_provider_invalidate_folio(struct gmem_inode *gi,
+					   struct folio *folio)
+{
+	if (gi->provider_ops && gi->provider_ops->invalidate_folio)
+		gi->provider_ops->invalidate_folio(gi->provider, folio);
+}
+
 #define kvm_gmem_for_each_file(f, inode) \
 	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
 
@@ -213,6 +220,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 
 	r = filemap_add_folio(inode->i_mapping, folio, index, GFP_KERNEL);
 	if (r) {
+		gmem_provider_invalidate_folio(GMEM_I(inode), folio);
 		folio_put(folio);
 		if (r == -EEXIST)
 			goto retry;
@@ -942,10 +950,24 @@ static void kvm_gmem_free_folio(struct folio *folio)
 }
 #endif
 
+static void kvm_gmem_invalidate_folio(struct folio *folio, size_t offset,
+				      size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	struct gmem_inode *gi = GMEM_I(inode);
+
+	/* guest_memfd only allows truncating full folios. */
+	if (WARN_ON_ONCE(offset != 0 || len != folio_size(folio)))
+		return;
+
+	gmem_provider_invalidate_folio(gi, folio);
+}
+
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
+	.invalidate_folio = kvm_gmem_invalidate_folio,
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 	.free_folio = kvm_gmem_free_folio,
 #endif
@@ -984,6 +1006,7 @@ static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
 	 */
 	mapping_set_inaccessible(inode->i_mapping);
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+	mapping_set_release_always(inode->i_mapping);
 
 	gi->flags = flags;
 

-- 
2.56.0.455.g6c5a503b38-goog


