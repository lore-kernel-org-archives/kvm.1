Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011834;
	b=kf6lWuZufWjY71BQV7CLJxfI9FgfukiVIynpyOcENyUNJLo26k3AGnvG/UhU+79LVx+v
	 iFcwNhNkgMw6vXKJPyTC8WfEJaaEE88NI0WdwdNDPVsZaWjIiMOKBhLC4dPuDpTsPiB04
	 HMi7f5uUTIzd6IBo549/90H0KSZ6n9D6rlH7zFyYFYckaWHB2q1uetlFClcEEF8wnp955
	 d+/Jc39CEBhzvjnT2jENORN9h4vuX6k+AZkrnJ2erRztXri2Hyf/3KUvNL7O+GJZ2Y2DB
	 odYSiZ7aekUpED5m6OedHYEXqswFJxHOvoyqkIZ89byFEI3sRfxgYk/tHMakrMaGfpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011834;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=013TE8/H9UfaaULLHpe/0PdW6Dc40kZ+W5jg572a6sw=;
	b=H3z1im/NorGDZauXviXu72/8zVLnV9L5GmqNH9dJ73kJGmuUE8WA6uzePw6K7qUEXFau
	 WB9M64D4Zv5MEEankDMIK+kF9BnNTJ+UfJkw0ufIBvj9lhGFvA/SGkO5F5xNODA1i1uIE
	 8nvvu6yI/bTCwcocJQkJ/7m/xILwvvmH1rN9WWix8EwUyPVpkNfcTSRwi8kOH6nQfckY6
	 pqeG4ZC3sMlieTB1ngP2S0maL0ECet5rHwqWmO/Lm4CZpHNdlZlpvEViXXfiWYpoK667r
	 /zB51LrfUGjgsdMuMcQ+iJFaNFivFfwDvaM10nakxpktVoGbXKrkQ8/qPA+KwpAuoww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlPbt3WL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286E606D814;
	Sat,  7 Nov 2026 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlPbt3WL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011831;
	b=uGhXxcCXbpeIV628k+aMbOMdTYZyovKeux7m1rogOjRvELZQfrkTHPt0OkXUpWWGs3W1
	 5kYFGC+uVqv+/f+a6qmXedIIXKt7INeklFG77NNf7nzpB7USDZp7pei1cu6lyWqkCUdh3
	 7X8oMfThHPvllZHOjz7TXublQrY1ZdKEGErcQ4DwTlbB3z5WIBRAW4Sgy1joBt/tOQnt9
	 SIiesW+FSZi7XwKruB2V62wj9onAo9hfhA6gu9XfITzU1HrFaG2rwwnCGuZIr9tt6rcWF
	 qeTAVmHGXlq52K6pMpuq8lwsbqwQp9XrtFcjOd63CI3nYUmrqh+EddXl4vz4oo/8OZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011831;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=013TE8/H9UfaaULLHpe/0PdW6Dc40kZ+W5jg572a6sw=;
	b=Dts+GmX3FEaWJCsd3zZAut3EZPmLk0HqA5zJ+dN+zl0akI4SfIah1sdBNjJjLu8kjCNB
	 0FYdF1oUa0jrn99be86jgdcbcsIDWIolqbv/SrmfMjDbsgbMTY5xKLt0wCicUf9ZcRWok
	 WI5QP/fG0mF2001o+f8roxQxMNxgarjU8eiVtnxsfL/qdbc7S6MfHbwkh1h73git5YiBh
	 PVRkeLP00ZKOKDcAIKjbXuZxMWWLiqxKofHrYzkAjDmFqs2nAn3UlnJ0P5yf87luT0/JU
	 tGEsVdIZHXR0dmI+Xbd1YGAOuTBIwhFL0xpU3+MekxAQhz7i2wd5jiZTQBQTLTjH2MA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 30E171F008A4;
	Sat,  7 Nov 2026 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011830;
	bh=013TE8/H9UfaaULLHpe/0PdW6Dc40kZ+W5jg572a6sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QlPbt3WLbH1wZg22MADFhgD53xHwV7Qp9/U/C0kT3bpOISuLnRSqcXmVL1BOjkFOY
	 fhULOZm/YmyDzuqWNqYMv2IJiptkG9RUxa1vCpIQhG+uEiP6Qim8wJTXvWGdCCqhZp
	 pTlWWgXQCd8fW76zIqmb1o13n5isj5l2s2QeQOi59JhdmMoWq7XWFp6ufeIiB3DDcA
	 VHaoFXaFbVxT5TaAGQJ9u0tQJN5CHFE6ICBLva+GNDGHEOTACD48pdZe7+PbR6KvwD
	 9TMOhZE4v3qKT1vzGn/xZ0h8U/ZpNvA7usdT1INjXwfetZz+o34mnNzTbeJlnG3jRy
	 Fup5I9P6pDgFw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 25249479CB;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:21 -0800
Subject: [PATCH RFC v3 47/88] samples/kvm: Implement put_pfn_range provider
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
Message-Id: <20261106-gmem-alternative-providers-v3-47-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2017;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=EQ1vkfs4Fq6dVy8Tnqa73wtDRnEOHzF5D2kx/MOFQjw=;
 b=qfpeXyJrdfzBNnklBH6lKmbtKPRh5QoMQFABGup6qT5nifmvAegwKuVsurgtDqdWAfCwzbars
 NPUayoqo7OoB5MiAYyY6K29oiVQj15R/7ZFXTkTxKp16tREgjIDIaTq
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When guest_memfd hole punches or destroys an instance backed by a PFN
provider, it invokes .put_pfn_range to release the physical memory back
to the provider.

Implement the .put_pfn_range callback in mps_gmem_provider_ops to clear
the CMA pages across the released range via clear_highpage(). This
ensures that subsequent accesses to punched ranges observe zeroed memory,
matching POSIX fallocate hole-punching semantics and preventing stale data
from being observed when pages are reused.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/memory_provider.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index 1db69a8f58758..0a03623492f4c 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -17,6 +17,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/guest_memfd.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -198,6 +199,21 @@ static void mp_gmem_release(void *provider)
 	fput(resource_file);
 }
 
+static void mp_gmem_put_pfn_range(void *provider, pgoff_t index,
+				   size_t nr_pages)
+{
+	struct file *resource_file = provider;
+	struct mp_info *info = resource_file->private_data;
+	size_t i;
+
+	if (index >= info->npages)
+		return;
+
+	nr_pages = min_t(size_t, nr_pages, info->npages - index);
+	for (i = 0; i < nr_pages; i++)
+		clear_highpage(info->cma_pages + index + i);
+}
+
 static int mp_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 			   int *max_order, u64 *pfn_attrs)
 {
@@ -226,6 +242,7 @@ static const struct guest_memfd_provider_operations mp_gmem_provider_ops = {
 	.attach		= mp_gmem_attach,
 	.release	= mp_gmem_release,
 	.get_pfn	= mp_gmem_get_pfn,
+	.put_pfn_range	= mp_gmem_put_pfn_range,
 };
 
 static const struct file_operations mp_file_fops = {

-- 
2.56.0.455.g6c5a503b38-goog


