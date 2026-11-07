Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011842;
	b=nX7xgXOpJsKmkJlpniehIOwQGGfjcdGXutxby39SYWTwWTQ9mofROjR7AKu6s8KM+/Ly
	 /z8Cssdaoy1lYMLdtWdNJTCIb1eM2saVbjq9wAEg6b1rmxFyl8aiEz6OfTacnaya76HgN
	 d+qvCZO1R2N5BSTrnE6ZEwsZDArX7vBO56ZygGQSYDcxdwB1/vMMBiOwYZ8ZSMIaN7AfL
	 oW0HFOkAj62BUh1wqJRPd7mXJECwGg3SY6FOvajRGHqMgcYnH3Vpcz6fJgM1wj4sRWszw
	 6Byfv0Rnol9hHC3IDV4BL6IAitB3tJ4TjBrSotCDlPA1puvC9+ceh7UIzj3hr9Dzqeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011842;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j6n9yIIcfnOcnGVEaQqxGzHzdc6SyqXvU+1WBCgMQDc=;
	b=nKSXcMLhQkQu9OSxJVqHcDIGqj73LyNqCoSMYsbX0G03cQwIvoNF0MotYNOePRifWkxt
	 J6FVMYhj72fjot1yvoAkTLzHgUl3GlVR8M4y9lxgZzIF5LhI4VajVlKTSTJxENkuSWSIx
	 frAUP5D908MLkMHjDDsbJzm4KmdJyzdDAXvVaU5utvBHDaL/ppRLkYi86qomH0xGk80r/
	 5l3zLIcT3euX+PMDn5YSjAbyNOVvSib/nHHDPeyZjL34aCQU22Qq7xGfVtanp4ysvf2jI
	 A0M06ZdwOMl/NymehMFTdpp1qD/L/z815E36FVcjs10k+KVTpWbkCs5/12QfIPShYOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkGXBUKw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F4606B768;
	Sat,  7 Nov 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkGXBUKw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011841;
	b=eb/vDVAKeECthiSwyI5qhxqUrowDLJpSM5ZwSeC41x/IhjM7aE+DtDB20ff4ODrWYYsC
	 kmFbrM37IpmEZlg10dSiY3WVW3Iy4LGmcSMFsQ/yZgcg44wGhZQ2ibMuj6OJynR56Gdqn
	 k7DVqRnIk/I9dUrSjrJzkFJOsPp9XmH1nMBJYXtsY+7HxLNgmnQqpz+SP4q2D1DaJ3s0a
	 nH4Ws04Wg61Mjja8PWpbBe57QiAcbw0qg+GnEq4hEk68fvRrgweaZpTG6b6SOPs+AUlEJ
	 eNhCJRY2iQoLsfapXSoeZrnlDi4dkA04j9BJpGHlTd9VyO30y88m9eo6PyH0kX+7SPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011841;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j6n9yIIcfnOcnGVEaQqxGzHzdc6SyqXvU+1WBCgMQDc=;
	b=ro78RZlwZHTVYCnzFJZgdtqsHg3U5WN+pLQL2pe2S9BB/te/oEL8gxa8WvJUR6HJK1S1
	 sAtBKO4qQEzeYj5mkPsKteLS8XqLeKnGRluf5CP3Zv3TmjG032koPohnG7Q7/OjsSsXuU
	 bMjIaXS+FkJglhH8HJTEMVNR1tlQ6upM5L7VlZtgL90Q3BKbgoRGx5Kup+6MOH9J48NbS
	 NaLTnDe9iar/6ejMz3MOxY4kLm8x2k9lr46XjB31SdOI1xiYiMWXJgVup1NZpHUyt3a6/
	 NHw0/kcsIdWV7kN33IFCxQquAkUCrB/8nJYg1CKCaEe3vppihGQflhlQYxfmHmSm5FA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D86FD1F008BC;
	Sat,  7 Nov 2026 00:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011841;
	bh=j6n9yIIcfnOcnGVEaQqxGzHzdc6SyqXvU+1WBCgMQDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kkGXBUKwR12OgLfL4wVSOZxLefx+VZHXQSIzpBVvnHzH/Jum7n/D20WJf32yzuE7h
	 bx8PQSe7qL0Bl9kgQZwNFgzRERPfOnvtfuCCmYAztkgyAFmZdFL7Q0OatKNYJ+a/Oj
	 p3wkoK3WcA7gm9TUSZ1zdUVei/vbtS+fiN/F9+06Be9GIIdlUNsFajFHQZXM9K9C2T
	 WuBHw6Vo6e5N3aRNyVVkWkMSeN7dVfaOCicIgaSUkUgIrRjijkp6QtgJtG2+YLNQTd
	 4fU83rNOiV5k5koUOnopmBTljpoFrikgBfSZH5PxM24y4ENrkhLzNq4394OViPIFs5
	 0FMmwKZVNlctw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9BA8E47A60;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:38:00 -0800
Subject: [PATCH RFC v3 86/88] KVM: selftests: Expect successful conversion
 on MSI-X BARs in VFIO test
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
Message-Id: <20261106-gmem-alternative-providers-v3-86-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2135;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=VzsQCzajxaq4+sy1dgFu+2FHBF/aQtRmKeEX0OOIiWI=;
 b=S4xYrV5byO8s3TboxsOXiZx6GDu3T8GX8FRcNDg51wlr8/L7ZZOzal2WSfJanjxA8BGU7KO+2
 Iju/+vhbIDtBPvAbcjUo+0kvLnJoyMJvy/myX3jkaxwU9LK9VGetSTJ
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Disallowing private mappings of MSI-X vector tables is now enforced
lazily by rejecting private fault resolution when backends report
shared-only physical frames, rather than eagerly rejecting software
attribute conversions.

Update the conversions subtest to expect successful attribute conversion
on BAR3 containing the MSI-X table, matching the lazy rejection model.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index a520cf45fccb8..325d5e0c66026 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -798,17 +798,19 @@ TEST_F(guest_memfd_vfio, conversions)
 	ASSERT_EQ(0, ret);
 
 	/*
-	 * BAR3 contains the MSI-X vector table and PBA. Private conversion
-	 * must be rejected by check_set_attributes to prevent host kernel
-	 * writes to interrupt tables from triggering fatal protection faults.
+	 * BAR3 contains the MSI-X vector table and PBA. Disallowing private
+	 * mappings of the MSI-X table is enforced lazily via NO_PRIVATE PFN
+	 * attributes rather than eagerly rejecting software attribute conversion.
+	 * Converting BAR3 attributes to private in guest_memfd succeeds, but
+	 * attempting to fault the MSI-X page into the guest as private is
+	 * rejected with -EFAULT in kvm_gmem_get_pfn(), causing KVM to exit with
+	 * KVM_EXIT_MEMORY_FAULT.
 	 */
 	ret = __gmem_set_private(self->gmem_fd, bar3_info.offset,
 				 bar3_info.size, &err_offset);
-	ASSERT_LT(ret, 0);
-	ASSERT_EQ(EINVAL, errno);
-	ASSERT_EQ(bar3_info.offset, err_offset);
+	ASSERT_EQ(0, ret);
 
-	/* Shared conversion on BAR3 should be permitted. */
+	/* Shared conversion on BAR3 should also succeed. */
 	ret = __gmem_set_shared(self->gmem_fd, bar3_info.offset,
 				bar3_info.size, &err_offset);
 	ASSERT_EQ(0, ret);

-- 
2.56.0.455.g6c5a503b38-goog


