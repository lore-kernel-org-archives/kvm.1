Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711697;
	b=l3DPKWTB6NgQ9/uBQUsEz0crgwwcv1+lgaiANyZ9rqStN14DI5sqlS+Le2PNFdnT3ccX
	 C1W+TvmMyHNjFAuQVAFv5ijp2pLaAfsEsNxE3syQm6Pi3RkwB/oEnxitkH2jN+L6WsGA7
	 XnY75Dc69fagcwFgG748hRa14hYTDIP6lDytr3M2qgP+v/nWKiEyvz+mycx8yx5TG2bd3
	 ypNoKpse32PXI+ibFLs/wLWhLpjyIHB4oww5MwFyhgEresShAvn1RrHIkQ9Vl3fbjfIJR
	 +muVBvGW+HjeAiRC1oRqKWNCItY8CFuQTcBrBDUn6rxFdk82DK9sVCu62G0rgFM5/VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711697;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IcqB1uG+Z9Yr4Mtabjmy4a0pEzhWKCVSsbVsmsM/71c=;
	b=R3DlIemPFSr58uz6vdj9Y4oFNYOomyCEKkS7NQvkfrx6r0sfYkayUkyOJU0L974b53Bp
	 jKcjAeATBWGJWd9Fum/YEbIZYmDwYU0xr7/Ik1JmZYw28JKNtIWicAIkPl6mhOZ9Are1F
	 3yr2gh0qJxgoSSStWVghlz/5ErWACt8K3TQSPE21fErdKeyf5hPRfOpUl5K3XpYw+EAkW
	 rumlxiIQ4Y69Nb7d4rrt6/uYDme5Rxg/hoaA09s1VuS7VEdlfd4/EM8tTYgvAM3BlFE8a
	 JYPHH4faHEabtu+3MISv1Lp6U7dDkB/f/nI5PTU5Zckgp4LrkfRruLoOUq+4oIymKug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5y4cXdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B7606FF02;
	Thu, 22 Oct 2026 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5y4cXdR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711697;
	b=IfyNIvZEkGg+0DUW92nSXt7Czzjsq1V7HDCWOh08D7jlmt7WXGopeW10/soRcbYlPChs
	 en2soezFnO5yj78fko+CEcNfTA0nq0nZa+EipBzN3NR8ucoTM3PqupNE+muWD1kTh5lI5
	 Z4ZIuGlF3DuspuRSvij6q/Iepqg/qvlYtg3lsw/8teSVbey3Z9gFajfzb3Wiq0nyx0fU/
	 89DL3gj4s2hbz52bDVSYoS60DCFcRCAztLucVEZuGzguTsIQfuvFd3U5yjAQVWot/sv+l
	 fyhgtaX0u83alOj4Lag7Bu/rT4MGKrgUFfH0tnhrUnP2wc/9Gt8pMSr7xQrOPedsjnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711697;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IcqB1uG+Z9Yr4Mtabjmy4a0pEzhWKCVSsbVsmsM/71c=;
	b=A/zn0n3yH/MNqTpbbQzYsWN8uoeAoLdV0pAOaVk8u2p5gZusDaPnQYhJK4w144+HbzMJ
	 uk7zNKn+nLOvbcgZTo7MHLySjFS5HdRtiAy3V3WEpt4BtV7+2VFiqsTrFLRuluCxWVugE
	 UlZYbzE+Bx3CuHGLiEK5vqx0e34VputEDhKBSc+VEeAGOvDHpi66+9GYtrEbqAbjQmvrU
	 K7wH5mmUjod0FUI8cRx7+kGmDXLGxWuEmOObrcmGw9dNXm+ubErIOcf13txiiNiZkhuZH
	 dPiXyfFJgLStaRV3RBm4A9xp8/at4+W8GI3Svckywh3OxMVHk6M922+MPBoyGw63ORQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 707061F0119B;
	Thu, 22 Oct 2026 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711697;
	bh=IcqB1uG+Z9Yr4Mtabjmy4a0pEzhWKCVSsbVsmsM/71c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=i5y4cXdRPEimj4JZcNEZXV/J2NhvGbkV/mrhisM97y2Zf8drjVPs/eSeqgYj48hZP
	 BtXWTqo/R7CdbBSQajef4KiTe2i8hHqiUlSXmC/0hG2rHxNtvIca7B4gytg3yy4f7l
	 h1ZfEbHqnRxSMQctsF2p6TsZl5H+0UUAG8XnHcyiO4NWF/U6i8I/Pct9TSF7KXkmu9
	 MziwZWkeQxnITLxalnlfQhOr6bolNNdJuGkrFI3Ywi3mSqczbfyr4jSAXO+UumoR28
	 HSo79XbZw7BfzcuI7HjzLs085MIUyRX0J9yt1IZNSaePBY6DkH+kZOqa7jwxys7Xyy
	 uOJanmIV0RoLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E3BE3420CC;
	Thu, 22 Oct 2026 23:27:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:06 -0700
Subject: [PATCH RFC v2 34/50] KVM: guest_memfd: Skip checking outstanding
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
Message-Id: <20261022-gmem-alternative-providers-v2-34-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
In-Reply-To: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
To: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Connor Williamson <connordw@amazon.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
 David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
 Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, Fred Griffoul <griffoul@gmail.com>, 
 Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, 
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, 
 James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jianxiong Gao <jxgao@google.com>, 
 Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
 John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
 Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Vishal Annapurve <vannapurve@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1241;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Dxs3RjFnzau2HBrxLaEPNXK3fpyUMAcuvPGogtfNcwM=;
 b=vVJnY7c8iTESjki2sqSSxtlQSZaRRNqdryI2wF8O3+c1q5JAPRkYJnGldQQ7yd6gwYOoJkvvX
 xJ/9Fgt59ysB0Hc7tY0257x9kOgE2MfKosIzomqD9kJCTYEzlVgDH9+
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
index 50031e191968b..daf4541c3dec6 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -854,7 +854,8 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 		 */
 		unmap_mapping_pages(mapping, start, nr_pages, false);
 
-		if (kvm_gmem_has_outstanding_references(inode, start, nr_pages,
+		if (!kvm_gmem_is_pfn_mode(gi) &&
+		    kvm_gmem_has_outstanding_references(inode, start, nr_pages,
 							err_index)) {
 			mas_destroy(&mas);
 			r = -EAGAIN;

-- 
2.56.0.257.gf7497c7d27-goog


