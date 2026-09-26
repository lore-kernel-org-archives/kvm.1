Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBB33CE80;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383852; cv=none; b=jh72Oxi3KV110DZLtyzqcHGlN9imcLunYS+50jCCcXNE/jp+EWpvxVrhpYjJ/WuT+wZLRcgPAfoAFYe5+JZMGBp+u6g2PbUbK+K4XUOByFgjaiVkH4dJjdwOMLA0M1H6IlOpx7UfOqsw7JVxfddpX4mc4YdDNG0ee41DNzxBE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383852; c=relaxed/simple;
	bh=CucdfZJ5/85W8a22Su/Z2GlUAjLT1OZjtxKxL9yuu3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/kdnYLiNA1vdvQPqK5vtHo7u4PHPUcYCN6Urx8pfOZh00CRLJrKfDA4Y/SKCs+NtdFOnEkGsrnDNbBe1Qu+sWvesravtHh3ztwVqZDld+GGOr3Z/28o14kXAoIJKAnoGOtCEZNcoBwW179/+KZCR8kr41DYiJi7WcHJcwYda9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne5o860R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne5o860R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B592C2BD00;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383852;
	bh=CucdfZJ5/85W8a22Su/Z2GlUAjLT1OZjtxKxL9yuu3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ne5o860RKYhFrnwbDUH++4v069HuXzs0E3w1k7y/IyEMOCV4Xi8QBpKUCkFlDd/xI
	 WlV3FIXeEI9cIM+ILxgEzL23nrSB65be6AWlCBrEeMKyfZ3m8XVFmZDQkuQgjmii6S
	 9YfENZj3n+jExUgPXaFeUWpuUjP+AYaFdMyj41qCny93zxMoNRq40ZMPfbQhDNDMZD
	 QyxUCoNlti6pGNYuyTkhOjEsWzsUz68xsDzZVy/42SMsYu2RtURk1mkS7V+dJQW2a/
	 LdlHd6DE8ZU4IbwrB62+eRmZlr+5IRsgbGGOr8nXpzWPakdgVuRnHiibn1XorTqLCb
	 RIgPKaN2rJ8YQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E6C9830E;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:51:04 -0700
Subject: [PATCH RFC 17/17] KVM: selftests: Document testing TODOs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-17-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>, 
 vannapurve@google.com, erdemaktas@google.com, jxgao@google.com, 
 rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
 tarunsahu@google.com, pratyush@kernel.org, fuad.tabba@linux.dev, 
 Gregory Price <gourry@gourry.net>, David Woodhouse <dwmw2@infradead.org>, 
 yan.y.zhao@intel.com, michael.roth@amd.com, suzuki.poulose@arm.com, 
 Christian Brauner <brauner@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Nicolin Chen <nicolinc@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
 aik@amd.com, aneesh.kumar@kernel.org, Vlastimil Babka <vbabka@kernel.org>
Cc: kernel-team@android.com, kernel-team@meta.com, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=1099;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zKFuTq3Amq3TlVl+Ae6LwDfBtexGkdVicUSVbrDs3Rw=;
 b=D5SgQu2KvK/CN8bmAnbeQJqiDr8hZKAUtYrBjvO7ze+1Wl1dU9raEmcyKScXL3hs51t3QYlt9
 k3mic0lnyeeA1v9aJ7kZuFyx/opXA3gFDc8InOKEYvCNEcaPlQDJKRu
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Remind myself about all the tests (A)I did not write.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index bf369874f2647..4e5d00df899a6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -721,6 +721,16 @@ static void test_guest_memfd(unsigned long vm_type)
 
 	test_guest_memfd_flags(vm);
 
+	/*
+	 * TODO: Test that guest_memfd creation rejects a read-only tmpfs mount
+	 * (e.g. MOUNT_ATTR_RDONLY) with EROFS.
+	 *
+	 * TODO: Test that guest_memfd creation rejects an ID-mapped tmpfs mount
+	 * (e.g. MOUNT_ATTR_IDMAP) lacking write or execute/search permissions
+	 * with EACCES.
+	 *
+	 * TODO: Test mpol fallback to mount config.
+	 */
 	test_resource_fd_invalid(vm);
 	test_resource_fd_unsupported_fs(vm);
 	test_resource_fd_tmpfs_file(vm);

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


