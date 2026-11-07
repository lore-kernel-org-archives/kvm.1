Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011828;
	b=fTLfK3In4d+Fb2AhgDhAwYTMjLHBzfNzhDgS52qmQkoCHsdmUZQ6SAT4joZZlsTjt9J1
	 u8XtIzt6INAccntNIFDzV1PZmSdQ6AODbTqTnPML/QFZtlU+n9D42ZKpLQFbhYEk8V2mV
	 WLYi8x0ptZKEmHsxsZ/IHiBIh4EzJqOvTgaswyyLi7iNQAUJjq/QVHzA4pyW+Uhlrwfph
	 LUx4U04N/n+1rSDCziMmXchuFdc1rQxjUyuKjyqVja1wGAuMisjdH3jFDQHQjNWbokq8n
	 M7TM109//TordPtVVaneJugTO8415q7XzT/CpJMCEKg65M/mYboYCz0Yci542j0aabA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011828;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OqpfAUM6RL3PzGZLar4gOeRZzwpcSnfwgpXmVVFrLVI=;
	b=UkI/YiSqq4kgqLLKqs03m/Qe14t6RKTeoqzTuO9E6Z3rTopU6xvCEtJf02qyGYvgQDp4
	 N3C6gTD2lgDQC9EIDW7U7zAFhJvgzyp69Y4K5NxACbaLRbKQJ5XSKdrb5gwBOjmUtxhcV
	 XuHIRVTAXNcOSJ56a2QCNPMiUVGt6t1wkNabsEFedQJIjutpI9eoTT3d3KwIrS8Y8+nU0
	 73YMLieTeU2WPTI/AtCwwzaLZNbWt5DmBiPmLRzGXKbu6DGoXv25UmTQPegGPvoO3PCxw
	 ZEF5HU3kg6KkeCJl5xIjsmA5jG5nda/g9DMfQZk7rq7Yi1KeOir6qpyyIk0Z1Oqd1pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQdelZVy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203660A2608;
	Sat,  7 Nov 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQdelZVy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011827;
	b=WkxG3IA3IISjlhi0ComCYAO8s6CeWT9ZWCppuZF18hv1+K8NmvpTFD4pADpVPAnf509f
	 06aVK/g4mUG6p9xAQje3IA80lMQ2g2QEKOjRNHwe2WGlqh0TCIGSt5mo9YerLB1qAoYb/
	 JtU8vT+8PBdaPvVOq9SrESQau4tAkgB6KzvXSXjdT2bMCL8uW7c+O+yR/6l12ie1ujVbH
	 KtMStZa8+PNC+/c7VW79xpq1B9sY2rq+jl+X0CrbiFQ0D5IvxOFywHs0T8fzTKS4XU4jG
	 IcUxpNy4IJHDUN7EQ2tx+UQ2Rh0LRm9fQ+S3QZCanK2U+jDjOnsmizEt/dNevgmzH/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011827;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OqpfAUM6RL3PzGZLar4gOeRZzwpcSnfwgpXmVVFrLVI=;
	b=r7AoIT6+Z2WvlaE3VNXpVkjkkEuUA0pe5wlHBHKhzCh/YIzRkEe4PLhju9ZeG+F4sEug
	 /cUKCSicCSjgEa23B6CIR4eLZ9f5BZ51jClCpP97UqneuCiz1hCmeNfWCoxJpumIaFFGo
	 RzKERZqNeskkWFrSsJmV2jFFH87g4pPzlDrImFyFN01FJXaCibbS4oRjvWWjIsZZCuQkl
	 hfOUtigTJlqs5C6uLfr+bXnd85TTBxPafJMKNdGtPGrpB4BVxMnszni9IKINvld79z7Lz
	 Fb2w+QjHaSFM/0x3uE8Dp1xU/3pzD3gVhIGIREBhCwCKbCv2pKCYoCJgGWD0hDpWM2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 780D01F00A06;
	Sat,  7 Nov 2026 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011827;
	bh=OqpfAUM6RL3PzGZLar4gOeRZzwpcSnfwgpXmVVFrLVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bQdelZVyvzyp0I9s6V40CthXVoMUSiMzwHxGzMwnNOBznLtjQvzWXksuo24o22ihX
	 c4bv2xr9a5IQZxeKi8cMiPD/nD6XbFgVtjhNTL083D9A3VfoRMFPUMSxLG/Dqdv88g
	 R6XWVqyOvR4ZMXEg3zT+TRidcazQ5QdsAadBAGNkgDJaTAb2IbLTBL07HqahiF4Xtp
	 CsfOs3VNi18WszhLERoXJaU5bD5Nu4UWJ5WVlcSvFyDQLdqX94yr9GYl9WZI78Y4oT
	 THA9RJOSDt/2kUwc65o9uPYoip3OYNdpIy0Nooxa06Yr4/DIY9NZoxpLkIA2whlJ/O
	 15BxURqzsFJug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A9569479B1;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:14 -0800
Subject: [PATCH RFC v3 40/88] KVM: guest_memfd: Add TODO for memory failure
 handling in PFN mode
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
Message-Id: <20261106-gmem-alternative-providers-v3-40-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=995;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=RMoXxdr7unZnobL7R1i/MK8zqw1q/jitBNuF2OvUGw8=;
 b=hjk6HdU81k97DczNhIQxswAsxYsu4tIqPkDlpmZd+T6wio0f6skkcsf8gsFCP0CMvMeZH6Uiq
 yEe+MejhQ7bCc8jLcDgoJYyK2pebq3F6/hjkDqs/RM2tzA/djMSle1h
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add a TODO comment noting that PFN mode does not use page-cache folios, so
->error_remove_folio() will not be called by the core memory failure
infrastructure when physical memory errors occur.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 501c3e250fc98..ffe1508985d61 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1127,6 +1127,11 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
 	return -EINVAL;
 }
 
+/*
+ * TODO: Support memory failure notification for PFN mode. In PFN mode, memory
+ * is not backed by page cache folios, so ->error_remove_folio() will not be
+ * invoked by the core memory failure handler.
+ */
 static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
 {
 	struct inode *inode = mapping->host;

-- 
2.56.0.455.g6c5a503b38-goog


