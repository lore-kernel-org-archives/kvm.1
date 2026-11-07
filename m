Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011827;
	b=gSOrd37L4eVfK1IcxXMcboxJVAnDm8g5n9t9PfUZnvqhjXcHmEvmWZzR3kfymOTiwSwY
	 +f2a1ZusPgWz3IqfUBPn5K0qgc9+EgJrxg2jzpr9e81AsFcFotc6H6rgOJKrbh6B0ybGS
	 RmhmbMP43DEOiOTLV/iR5FFb+WKVdWm40MgPySeEvOPO12cDtJNPae3UOorb+shw+Ux2e
	 k7xNPx4H0V3AlQx3PiH5raaYtYm8+LzPZus89jZU6Yt3RkL5YpzD+Adfc5y+6vzrSM/sX
	 AJikAUHBntLPbKj1Hoz+1XhhfQGeNzeo+NReKniIbCnSkTMksFdhhqS8qPotUNSF/uA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ReU0Kd+FdZN68/M0M8cDAR0IDKP7C8zpUFj1mjltVuQ=;
	b=I2tASj0yR38GECyAM2q3K8/TMRl8zGKYnSZN0oN/gu7bT0jf5wLpGH9mpJQJRoW8E1v4
	 AFh5qZmJ9i11noMQQFqx4AJsVg2ZTJhZV9iKDG3hUqML5jlKxSTQrXcm4PkU1EVlKZohp
	 LeViilsCjcyg50EBLYiNWq3nE1jQlwtAXy+fZ05KhZUhQ2t4oqbPXlW+dMdx0QihgLc2J
	 jGIPJ6i2/Jv8IZMLOTZco5idnX/d5L6y4EV++HawvECuTEDxX7ZuXcWlTvbSI7uWZGNsp
	 Kl04pVCfPs32s9iA5oXKl/eCn8c6nPGi7dpegbq/tt3wM8mfj/lZ0BDbhMavwTJqkEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F75uEguT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E2606EE87;
	Sat,  7 Nov 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F75uEguT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011826;
	b=05hxEjhEqo6TvNbe5/8iJxieooxXKUZKhOzJBq23AsnOnI5tSbhzuZ+4sLMXis071Nni
	 fl/NT0mHeIJ1aw4ehxfOmw78CptWMnMEwcPCB1INRIL0SAWY9NxdBEHnyjhiPkxxkPEN3
	 UetotQ275OHDoU/+ncUEAm/ToGVLYHGLP5gjcmOiG/S1xHjgFTcBoJ/LErLm4wYJYD9AK
	 MHUAUKnPadsCWC6rbIlP6UTiafZoXoLFz34ZNygq+dXF2GpJctvTBbi1/6ePZQi+RGMc9
	 gcmaasssLjE6FWe/2Z05kFgIJyz9E43apeS7ZVZ8uqI/zlfEyyhm+MR8bWPi2z2ug/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011826;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ReU0Kd+FdZN68/M0M8cDAR0IDKP7C8zpUFj1mjltVuQ=;
	b=zj+jbU7dzpnKmpF3CZ/l/SkqwmeK76jlYHq6Ubi8oIt9PhR8cSOxY5BUY3sfv0BUenhH
	 1jUOimltu+lTt0xnjbBnmxVR1/8xpX04iUzTQPVXJu+o7iYwmJjLjTY+MsmCRU6IkZxFy
	 xiXI6nruMMqWFDlPVBpImWcZnqsfCCaFslALf4C1/KD+XVQBgaIgUZqUtSZjGcKr3eQVZ
	 cSMC0p8dUbjnivJ5ufvDeD3SSICWL9hTlsSX35716viscDpBNkGSX4CcARCQpOt7UzcUi
	 YNctGat2XxQJPJ5Rc/+dE9MP6CzjmpK+QSwtIdFzeBbxhJmr391TcfBvXEECSEf8VqA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9D7861F008A6;
	Sat,  7 Nov 2026 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011826;
	bh=ReU0Kd+FdZN68/M0M8cDAR0IDKP7C8zpUFj1mjltVuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=F75uEguTQqAJ03WhlACLIRO2diPsETAYhJCo12G2j3JlW1G606YrIicyLAfSJZt3U
	 Wl/AoXCSkF3oJFW+jlylucMvO1VE4eE7Lbqk9lS+6JZnvPIU8LDDic8rN6ByuDwt63
	 oSSgAdSuX0wGgFLuM39z7F5Y+myaYwLJ8kXb4MkwJ5VdzbqgYyLS3eq7ul8NXkX/uT
	 VbhWJwIHCp3hz0rkiDO56coeRdJKpKrT9hA6S3C2bm65TFC2kSgZxpnmUVuEjzPG0G
	 BOP3A3raKASJpxDQDkZIHrA12le/QgD4Jj9yKKAAW2aB2e7bZekyai/BV8nSYQWHVP
	 mFB8tKGBFRUBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 66C09479A2;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:10 -0800
Subject: [PATCH RFC v3 36/88] KVM: guest_memfd: Clamp hole punch range to
 inode size
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
Message-Id: <20261106-gmem-alternative-providers-v3-36-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1715;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=T1L8Nqi+JAoaUb9Yx5e8qDpkaF/OKb1FzBs+jwYeM/M=;
 b=4gV4aRNMilBvg0nqyt8Kg4QHKxmtpIyDoHFAB46oLSBIQhuWagSSLMn6nq9UF/ZLeSvyJZ1eW
 jOa0E0XXB1iAfvQ6IfaTdKRmpQRRW0WZutOkaFwv0I1tgcjtp4U/5YM
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When userspace punches a hole via fallocate, the VFS only validates that
the offset and length do not overflow the superblock maximum file size,
allowing ranges that extend past the end of the guest_memfd inode.

In folio mode, truncating page cache folios past the end of the inode is a
fast no-op because the page cache xarray has no entries beyond the inode
size.

Prepare for PFN mode by clamping the hole punch range to the inode size and
returning early if the starting offset is at or beyond the end of the file.

This avoids, in PFN mode, iterating across a potentially huge punched range
where the provider isn't even providing that memory to guest_memfd.

For folios, no functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index c62e15e05a249..9e8204f5c2588 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -388,8 +388,15 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	enum kvm_gfn_range_filter filter = kvm_gmem_get_all_gfns_filter(inode);
-	pgoff_t start = offset >> PAGE_SHIFT;
-	pgoff_t end = (offset + len) >> PAGE_SHIFT;
+	loff_t size = i_size_read(inode);
+	pgoff_t start, end;
+
+	if (offset >= size)
+		return 0;
+
+	len = min(len, size - offset);
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len) >> PAGE_SHIFT;
 
 	/*
 	 * Bindings must be stable across invalidation to ensure the start+end

-- 
2.56.0.455.g6c5a503b38-goog


