Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711679;
	b=ErAPkVOCRzd41TiMx9Gg93lIBEcCfmyoVTWKPBy/C1Jhw6+c8sxQiCa9Gp8DmgHJMywA
	 WVXLhqPRNjuyN2991ME/c8OKjCOwLFwDkO/2m0jfInv7FsGTX59fGMKkJwtUsIoS9RFIL
	 AsUhpQrn3NPos5vQgKq5JwdtBOKK0aToR75bXvFMo+uPOm4CxZW7RlHAxtxVPES0SF6JA
	 g++hBjg/H+4TY+LlYn3yn+BVTG8S52JL4Ohf8KF4GepgajNMB0dC8nRhyK70CDaU6B0nM
	 GC2Ld3aGLrPv1Ngj577ObfC4OUMGABEYmfNddb/bjlmq3kA5Jdgwd8/KygTw2s6n+0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711679;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xKkND232ckYcsr4WYPfohBQYeZlI+ZatIYYh6FT4f8I=;
	b=dqQ6Y3QEbkZxiPBeUH1b2gJkOEx/lFJAVNHym3s1hVNUBUeSpSgtmqPjd596g6j3g1og
	 WD6sSno3SZz5l+bdGsuj1jNbmQtz6zqRISFGsOtYQkoQPTtMtUcemeCOSxLv7L7kKrWiP
	 V0crLtehP2NZw0YtGyANbQGe0mqmeFyA1nwy7YUuHpoPieQ2rqPDIlApeqJQAhOjzwrEP
	 q3pmkcWzzuvwHESwIvDTAH7+kfhFBSHtbheDTCQLkdct39nfZxk1OvcvwAXnFSqkV164I
	 RNZBZA+6HsrwVPnhBLM1lqoYYPx8h5kwAsLvMlzQAx8IBen9NuNmjFBZSf0PmNrKuKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WZu/L6g0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C660A2611;
	Thu, 22 Oct 2026 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZu/L6g0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711679;
	b=jlQ8FeHcIrZg3i14t+feFv4jBI24vp+P5Xu40zZzGFcM8k61AXVMtf9TobM1rh+/Q4BG
	 0G0CAjtjUu55+sQOosc2VssRNqr0mltTg21K+VpTPW39Q8NYn6q62NI5PA5IdvwRfb/91
	 pb+kDBR67hS0kOopbu1yRPSXodRQLFMSUAgN76eVF+M3SvQ60o1PRvy6t3U5SfouyqDvf
	 17uAe8gYFcaxWHr81QY2WPlUQaoTUVrKwnCNBwYsKRLRsl1/hMdx9jemhWXkeRW3Pcoa1
	 vrMcxj3bZz6w3724FNFUZZ+R9k402XftEFUdo9YZry3/EzCDNm+3WXTmkPCT4gW9KpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711679;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xKkND232ckYcsr4WYPfohBQYeZlI+ZatIYYh6FT4f8I=;
	b=aJAEIZuJjFop2LcsyeuzR02LJ8MLyB6teZRNRl1IMOsHePWZlrLPNM4q1/2heRA3JTro
	 kJGkpY22a/cpBK2BxSXZwLwXeiioxX2A3/LGekXpsVYIThXpX4g/cVkTS5ujJ2Ig8nwr1
	 I73gaWuc7ykFSuquhvPE97LqGF1J2o5C1fGASTm46HRnEj83VXHZwSCZBhlGqDEv1OdIT
	 GkxhBXLejbhTWHagzTle2IemRb4/I+plk+Q4M1i9cYbexDwzcseYIZk2j5vzBb4UYfxJy
	 Mu+16J8y/iR9Ho4Fi/6/0aAWeOJoZCuuOSR8+86VtNGmeGQOhYNyc+mnORnLVNknzxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D1AC31F01193;
	Thu, 22 Oct 2026 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711679;
	bh=xKkND232ckYcsr4WYPfohBQYeZlI+ZatIYYh6FT4f8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WZu/L6g04B0x88eXUkp7uzabGEqZ8zfhUjLixw+q8uZEwCEM83PfjSwdf9/FzKGF0
	 utQKhWHOykrBKC6IVrLwSc3gEnSuC5k7gcb22BtC07nH1wbYUIyv4g0WS/hBaQurCz
	 /D7xH73k03uv926siiqQFWspyahQm+zUEBpgVRPsLNgwtqVUvO1biQe2rwow/TdqNd
	 OX/HN9NTaPjwG9F4LqREodnNiBFrpJE52J/1uLEnCyynwHjeAmeaNIJGF7bIKuu4uW
	 gM/xz813h4bnRqVQGv8tPUVU5U/5raUqs1QrwcPa2z2fKUplUdEg86mb+WYL4VfujZ
	 9wY8UPX4YK28Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CDE3542073;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:44 -0700
Subject: [PATCH RFC v2 12/50] KVM: selftests: Test rejection of regular
 file in tmpfs mount
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
Message-Id: <20261022-gmem-alternative-providers-v2-12-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1842;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=pDE4OVnGboOSGiy8/kldBMjQFbPdRMO9/IEWat+ioPU=;
 b=GgWocXsPVabq+HYGkSW3vHTi6dWLrVAKmjkzMiyD2mhGGJyKDlTt8oY3GVzXJAo2KuFBE2fM7
 Q4c0wDndunDA0ktzQqq9tCeTM2LcnZf8TC0DtQkts4wTJuKL9cmRODO
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that creating a regular file inside an
actual tmpfs mount and passing that file descriptor as resource_fd
fails with EOPNOTSUPP, because tmpfs regular files do not have
gmem_provider_ops defined on their file_operations.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 541d8cdd0bbf7..bef1acead4a6d 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -613,6 +613,25 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 	gmem_test_vm(invalid_binding, vm, flags);
 }
 
+static void test_resource_fd_tmpfs_regular_file(struct kvm_vm *vm)
+{
+	int pool_fd, file_fd, fd;
+
+	pool_fd = create_tmpfs_pool_fd("never", true, page_size);
+
+	file_fd = openat(pool_fd, "regular_file", O_CREAT | O_RDWR | O_CLOEXEC, 0644);
+	TEST_ASSERT(file_fd >= 0, "openat regular_file in tmpfs pool failed");
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      file_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with tmpfs regular file should fail");
+	TEST_ASSERT_EQ(errno, EOPNOTSUPP);
+
+	close(file_fd);
+	close(pool_fd);
+}
+
 static void test_guest_memfd(unsigned long vm_type)
 {
 	struct kvm_vm *vm = vm_create_barebones_type(vm_type);
@@ -625,6 +644,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_memfd(vm);
 	test_resource_fd_tmpfs_swap(vm);
 	test_resource_fd_tmpfs_huge(vm);
+	test_resource_fd_tmpfs_regular_file(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.257.gf7497c7d27-goog


