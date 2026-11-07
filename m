Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011827;
	b=AdbSHTfW5lodWiZHmcKvB4R0JEVjx+hdtZQhNMcnV/4o9fuuvtNIgQypisgGNcK8OdQd
	 xXhXmmWJRAz+gNnBksEFLt2DxUiszPXcXV+xGOU9syy8ah/TTs18fqgP4gZR4ZJnYJ3Nf
	 cQsYOYqU9qptvqZX8rAm7lJB+jPsrdbay3emtZVNEykR/Xbh3iEA40HkzumHlOejfckiO
	 Ii82PQ8OjSxy0mvOU0g5UW6N9ovZPhQtYFxj88PEe0JQtYFNlVOTW+/s0qv8VrDJmwIhw
	 Gg9aXZ8yaJqVhIxTzG+dyMHx9GFibXSWR+nI8inMbGzJG1xGcaAtlWFPtlyxhTiqRfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DaJbX9K47MPESvUexensq7JxY5C8QjJ+zVBZZpcUPTs=;
	b=vGbp9M90IXMi1lSX6yN1afQIxjSqFigRH4Tjoupe1IUZBwBlVEHjsZMEFpYaHS8VCJ1a
	 zBjMSnNxgrrH+q6Jp+ZZOIJlx59kbn5p1FtEUcWGZnDCr5equQdbVkiW29CYyXII+1olc
	 EPYx6ggulmt+ZXUlc5CdvlLHz46fTst+v/JRK7OMH89VKN5ZlCWhKdErRk4OIQPjqzsPn
	 PGr2Rd4MKE7ggtvYUhOWAGCt7yLcDmyyO9DUG/fcPs+jzZmONiEzr2pIY3zEcjho95OCJ
	 /ffFS8bXk5o3wI//XG+HVtV9yr7L0l7jfwgOmiVg1J6e19K0J+ywMzozjb2yq3BSOcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVuFSelh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88E606D81F;
	Sat,  7 Nov 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVuFSelh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011826;
	b=01mHq1atVZc0f0vWEi2r4ZRQzEE699AClKhM6BPeVp4OlSW9MsF1eYd4jlSLbkUSJa5q
	 30r4raq1LROomzfHxNcQ1WtvRykAn3Y1jRDLpUFJ3Zyq3cBQ8L7f6rIOvODTjDvnGkkPa
	 qkiILmwTR2m5tdlLyG/jCKse53F/czHPf7/RoHSOShukxU4uFadWdQiOroLxKACi6rsD3
	 w4oUigvARZNi8f+ma8Yk+KUkkan33ZM/OEDlJ1aW2L+bXe7Sg1WgfotHhZek7QZWc7sUc
	 jOodTigjFrxybsVZvd4tApMe3l70ky8fhBjlGyHH28IfIBpCDJzmX1+uc/CEjr9aWow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011826;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DaJbX9K47MPESvUexensq7JxY5C8QjJ+zVBZZpcUPTs=;
	b=NSqxf44OICTCE99rKU24QRVrnUfVu50jG8+MFsAKuxmmJd6ifxompgEJtC2/RP2EOlbH
	 A1NjDMfvaZ0c1yEv0JIu9fdpQTEoI+leD3+Z0vmLaU5N7/qeRvceAAdxwk/dcyFlY3jC6
	 Rkdfds46ag7kT3lEiaO1COMVWGGWilS7vHETMxDVLFPR9OC3d2Kd5PkQgCRKHz8fgLIu7
	 QfwNRQAXz06UF+4bA6y9MZo+qB4YfqRBjp9Qg0I6Msgq+e6y65Cx3U9UgCUxr4jn5WkfZ
	 S+aUT8epuzYUyRcMd+pCuSuIXXEYcjbsCvUOCsfhgEa2QzxF+PBbSMC35iwZ4X2yCmg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AB5171F00930;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011826;
	bh=DaJbX9K47MPESvUexensq7JxY5C8QjJ+zVBZZpcUPTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PVuFSelhrY8X2bDFgWb305cgCe+sfCI0wgiSp9B2Bv/jGanu75mGp4fJuwAW6M3NV
	 4+tkzRnQaBu4DlYkCetufjeglvMhauEyYmPNNOs7JVhzSOjDlOzZ7JHTY6nK3XNvj3
	 lKnbMTz3xn+dixlZxMCX2v0jFEB4XTJFFDSrMeHil8Ianq+37kCEQDpG9XU6JOWe0t
	 dlFxClvgSuKJKgk8qRT5agK12cfj1LCtfa7iuHqBD1P3zTfjgokEl3LV7Y6MmxN1UA
	 FSyS4fn/JIjLV0OBi/CKXQ+HIvUSqawsnfDyccI4Xkx//alyLJwJsGrJCmBe+m2Mf+
	 O89+wH/8jIcVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 35CF247996;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:07 -0800
Subject: [PATCH RFC v3 33/88] KVM: guest_memfd: Skip checking outstanding
 references in PFN mode
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
Message-Id: <20261106-gmem-alternative-providers-v3-33-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1241;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=SnLBT6Q6uhpsf6Q3iw5E3T1UAAmiNXk2AxpRgy0J7g8=;
 b=m9e+oS/Q1dzTtHUoLjbiCU3McBzID8fswXgaOQ6OOb/+PCv1AALy1hietTiTiQekA2K0+q5jS
 PfF/iF2VW0uDRQyYKZTqF9IoXUfn0S6L2V5tqYieTA37ALBQJUJWn8L
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When converting memory attributes to private, guest_memfd verifies that
there are no outstanding references to folios in the page cache.

For PFN mode, retain the part where memory is unmapped from userspace,
since userspace should not be able to map private memory.

Since memory was not mapped into userspace using pages, there will not be
any other users that had GUP-ed the memory and there is no need to check
for outstanding references (that indicate other users of the memory).

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e94f2359b7c9a..ceef61cb63a0d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -901,7 +901,8 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 		 */
 		unmap_mapping_pages(mapping, start, nr_pages, false);
 
-		if (kvm_gmem_has_outstanding_references(inode, start, nr_pages,
+		if (!kvm_gmem_is_pfn_mode(gi) &&
+		    kvm_gmem_has_outstanding_references(inode, start, nr_pages,
 							err_index)) {
 			mas_destroy(&mas);
 			r = -EAGAIN;

-- 
2.56.0.455.g6c5a503b38-goog


