Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011843;
	b=sjOJgXjICESCxlDikkpekzRdJxuWWEKBuPIHyE7FHGinUNBIN0jU4Y2Vtj4M83PQh8Kh
	 ZQQhkoF66Dc7R1u8/dRJKuBUPVIg7dkm8cAXje8zX8XC950Ppi0v43+ESh8MUkH4vnac7
	 jn+izwKv3t0quCsNsjXX5+JDXbRR2SI2GK1DgYDsOADeM4zN9Zyndj+IxQSUzeH1D4AKE
	 qewhiYKN2hSLrAhfZkdv9VMkWPxKsZNBT8qO1tU1GFPWs7t/QA7jPG2b+ngr7tssB1sDE
	 5mdDkF4Ylne5vMxgGBk3WgawNipnhrcywgtM3qj95MaHQGZxsGbuRScZTqgkNoZ9bTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011843;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Nw+7gH6TQyDm++SEtaBJ9qTZjP0IXilw6YZGdfy/+5c=;
	b=hNwhl2+nhO68959vplCuM/StCnIAsbEUTTGSy+9uroxuR8VzG8b9bW2/4MyPGtiMxGHg
	 jeKpPP85+wiIWxpdTceCr07QsU4S/bH9kd3+WF1dd73uiOCeTvvekPddSLLYtOW/5wIwg
	 U5EsmTPwzuw+qwqduJ0LR4P7Ns+ZQMede/udMutooQRD9e+k4+jKnwFhIjSzb/Ae/4GWS
	 8CctkQkfB8fp6WFxNdVmwbwQRwI3FSNC4g86Smb7ZpzfzN/nkli0dPegu6lqZV6eXKuOl
	 Zcvv9T/3cS2HxZDZaOH8su4lKLMEKf/QlKqJQ8/++8W1ECkRs5P1oNtBJAkoGpXPPOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aShcBXa0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D060A3833;
	Sat,  7 Nov 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aShcBXa0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011825;
	b=G3e7bbwIKSigAnvmAE3ySxyTekfUL94FMcE79ekSs9Sd1Bb3+rTxYqQ6EH7YB5G+zeeC
	 nimu+aS47yNcQhzRy0sw9pc7Za2hrSa7uMXl6le/R0VOFuaSPW3V4hNi2e+bwIKIRv0AU
	 eFsBHb+DdSgfZJlVWanWYJYjX2aqvdgd90gFLjy1DiRUEawogWdQZS8T1n16Zj9/ddGLF
	 5CY3ndxO216oMA3cIs+Qwn+rsZ5aq4GX0sLuBN6mAflwpUloIhjtxSKJtbDO8VDM4b8dZ
	 NGje3FpYinNeTMuRthJWiK0SCigq6M9IXq/x9IW3BOEzTi+9/1l6JAe0fYiLlcF1F6w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011825;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Nw+7gH6TQyDm++SEtaBJ9qTZjP0IXilw6YZGdfy/+5c=;
	b=PGjf+K+Y5dYZyq1RC+f01aFmITwhGZ+5JA2stxPJV2xkAVZfjFFkOQ9oo3Rf5qq4ioqJ
	 YJCvY6/Z4G0/lVU4SKynmF5CB+2/MOmIe/md3X4MlJZRgNzwp06DbYqMqISXE9VZjQJ1P
	 zOGj87IHpdPRgv/rt6Ha0OwiVo5O5Vht4VWJ3nzDLIVXEHUNYBZCULsU49AmmiLz74iiX
	 mdUw/QEU0GDg7lki6INGinAVtDryYPfd1n4ZzP0lnciSBZ9+DqBwHm1nC8mWQgTPxLlvH
	 CyAvlz3WyCggtaeWko4vKlSy2Jf0rDsDF1zp641/baBPlas/3rr3PK05B+NuxaiG2eg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8BD031F00A04;
	Sat,  7 Nov 2026 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011825;
	bh=Nw+7gH6TQyDm++SEtaBJ9qTZjP0IXilw6YZGdfy/+5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aShcBXa0Mol8YafWuNQV7fdFIYFdp7mdpO5ytD+MtPYWHeB+z5LLAFIMlnhdac+mi
	 pCPWjCmvMyyr6Z/wn6hc59Tb4xzLOJZJVjItFi7BvKyX32l+nXGaWr3o/QF/v2Xu41
	 ACDFYMtx52xLwQVGDMALGdZL9JhAcnjQJFt02PhQLtrINhBaVt4/QqPlgs2J0fP1G8
	 QaCf0rdxzyMvElPICGhEs9KaazSw8jfk7nH26Cn9JwQ5tdQkO1OVLs6JwGIruIpkcO
	 pMNMQt3nzTxITUOVq8fudBjn+iQjHWyEFZVwM0FXZSWSLjT/plVjdy/GhRkZYZl8DW
	 tjYsxBOsAkWLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 886E1479A9;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:12 -0800
Subject: [PATCH RFC v3 38/88] KVM: guest_memfd: Support arch reclaim on
 inode destruction in PFN mode
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
Message-Id: <20261106-gmem-alternative-providers-v3-38-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=1330;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=TXq1Q9jBI24peVbPvjCPNkLRxMY1K4Ef0Snx4+ixQ0k=;
 b=NZ3n/EAMYCRX+fSqoFNACF15ZIxG3Bi/dLX6qBEDTgTqkaUaK6OzCVw0u+02oNBki4B329uiy
 2o4HzhyKxyYDdZSUnNDup6ShAhNskz8gXyW1Q2hAjUX3tFCGmC2x4V5
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

In folio mode, folios truncated on inode destruction are reclaimed via
aops->free_folio (kvm_gmem_free_folio), calling kvm_arch_gmem_reclaim()
to reset hardware confidential VM state (e.g. SEV-SNP RMP entries).

In PFN mode, memory is not backed by page cache folios, so
kvm_gmem_free_folio() is never invoked.

Do the reclaim during kvm_gmem_destroy_inode() when in PFN mode across the
entire file range, ensuring that any confidential architecture state on
provider PFNs is reclaimed before releasing the provider.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 567735a564c7a..b46907b480138 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1726,6 +1726,13 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 {
 	struct gmem_inode *gi = GMEM_I(inode);
 
+	/*
+	 * Skip if the provider was not yet set up, as iput() can reach this on
+	 * error paths before provider_ops is initialized.
+	 */
+	if (gi->provider_ops && kvm_gmem_is_pfn_mode(gi))
+		kvm_gmem_pfn_reclaim(gi, 0, i_size_read(inode) >> PAGE_SHIFT);
+
 	gmem_provider_release(gi);
 
 	mpol_free_shared_policy(&gi->policy);

-- 
2.56.0.455.g6c5a503b38-goog


