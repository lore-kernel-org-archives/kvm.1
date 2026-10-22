Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711683;
	b=sJ04bBecIbQ8oEPrT9IE0oXMiah3lW5gWZdFpGjo4h0quGSsIDIWbS2rNlzVUOhoIv5V
	 9U7TjqPGZHV8GXrNkVnmoOlFhgZEuTsu9bvBh6x1SWo6VCale5y7J212A56xrQxk5Q8Je
	 Rm6iIo67SuHPRVYFLw0Ss5s7QSo695E20ggx9FJSaWpxhUqLyFElhjWSvgzBd//2+EE6f
	 lRLXo0f9Novbz+EguINL2kZZsiM5mdtvJdI+s5CNDvZXcHD1c85jQpkWWG6BdBDkxHeVy
	 /YDipmC4l/7rfloEnCpVVi35tLEyKm+nkM9SneTDhJWRPvivq2vmqd9sk95Xd75VL/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711683;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SFdMQT7RD1BLjVi7Ab5eCk5xGexiV+/iCJCFEFzCdRM=;
	b=zVcOwspHCwJU963K0zEixSiZ2QpWqII38FbydWboqwhsRCWHLDo7ke3M6ZwOCzcEVt2d
	 GscoSNV4/R0a8MRqqZWjihP/QIb2Yk+e/QiF91JzURidX9kuh1j4UUI4/3MvdtgHJkgXb
	 zO+PnwplKYy0H82aMN5tLTGk9bCcGwDxcInpWgMcotpXGXzH3voMBgt+3EOzz0dkXGk2y
	 gXnPsApeIa7/mcJeh430PChKPSCWm93NHg5FLax54wMYpYLZY5vkZ44AWn+li9Mjt0tzW
	 NjHYSerNSnsR9ocn2A2OLH4jMdVxqzzyqi4/PxaD+xSwa4VFjcwYpAVszVfkShtewYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax7kjaLD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30BE60A6F6C;
	Thu, 22 Oct 2026 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax7kjaLD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711682;
	b=JIBzmE3N9kSkTNa5igaCbfVumYkfGfh8lUc8b2WcdJ19v0GiqVatNhOlqYPE74BfRYRi
	 GXmTfv09VuXnCp+SnQu2/8bto1/py4dKnkfFnIAmDW8fZ8KVF+113wc3Ut+9aIfqZT+HO
	 YquRILnyBSMtb9PNBDJJTp1u34uuSmzsuCYDlDnC2pwvy9k9IEjeMvi6ux4UkU3ZKqT5k
	 LUZ08U0ZhnpLXQF14AP3v+ciMehvZHygfXa89DM51Tc109DdyZtu07VZHIdDfnVIByiRS
	 GeS8ADJsKxs6EbenyxGg7r+t7L1+Dxh0ore1AxtPb9t4XQrSmqClN6IJMfQb9K8cujA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711682;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SFdMQT7RD1BLjVi7Ab5eCk5xGexiV+/iCJCFEFzCdRM=;
	b=Ox8XH9s5eoix5QXKNxQirzguuj51DXZR8JX4YG0wdKht4DVfhvul52I/z+0ecny4Ou0c
	 MiI07fHR92g1HZJkB1djaUNql404THik9CfYAqO0KaqBDWxNamOJYq+BngdMJwDm3X+dJ
	 kXL4k3Wm64wvJlP85k0HmX5teYOpExz/BvAcsHOIOhTAu+W4PXTRqwiWJHBM5fD92dVwo
	 mdTh8R35+Z7WriL40DY7NBCPWCkC6xIGbodCChwRCCL+QaBODooi1m5oRJPs/8rgcFB29
	 s//rO+47TkbwnxwTQtVWOMDnirvwZMPlrDetzREoggx6UQu3MgicRBQ7YNjH6N0YIpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B6D301F0119F;
	Thu, 22 Oct 2026 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711682;
	bh=SFdMQT7RD1BLjVi7Ab5eCk5xGexiV+/iCJCFEFzCdRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ax7kjaLDGnEXjDfPRTML6M4rMu+iY3z/jEBafbjfeMRaQruuj7xhXL71sA25dhKnE
	 KVRjXR/EbDnX1h9WjO8qpkjmDB38FtwzalE/p7MVcIhroTDllJBEVGLiIzFXdXjVSt
	 D2543jpHHjMpIuD0IW2Jew0yXxS6hlUrPvu1BHuDqRYQ8Ci8acG5vlJw/VAhuT62gD
	 BSZpWoMwPdohR1gMt9Rey7M0ihuB5iPW5iql5r9oTe5oDR7tTaheRD7wNHCMpKmNKR
	 bD7qX5pFg3iYe42PIwpKjmm/tWsVEXfJzmAdQ+F1Aq6e3nOgUE0t9UL8iTEYjqSnC2
	 g/lO8i0WgpmzA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 07BC042083;
	Thu, 22 Oct 2026 23:27:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:48 -0700
Subject: [PATCH RFC v2 16/50] KVM: selftests: Test that shared tmpfs
 resource pool size limit is respected
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
Message-Id: <20261022-gmem-alternative-providers-v2-16-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1067;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=AQwSKZXbF8L/tHqgweqYig9l72GDNK/MpFua+P6X8zs=;
 b=Ix5H+hGnyoYH44QhEgu0GyppTZeI87NZ0i8CAhkmNXUohK1DTTmtPG1CNQeel0FhoQmoNccUc
 awsMx9bB7tVBkeyCpQkk3kfTmR1/3L29+gJM1r0yvmt9sTiCVc5Hiwh
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Verify that allocating memory across guest_memfd instances sharing a
tmpfs resource pool fails with ENOSPC when the total allocation exceeds
the pool capacity.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 639b1b0c204ed..20de24ad535f1 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -604,6 +604,10 @@ static void test_resource_fd_tmpfs_shared_pool(struct kvm_vm *vm)
 	TEST_ASSERT(!fstatvfs(pool_fd, &svfs), "fstatvfs on pool_fd should succeed");
 	TEST_ASSERT_EQ(svfs.f_blocks - svfs.f_bfree, 2);
 
+	ret = fallocate(fd2, FALLOC_FL_KEEP_SIZE, page_size, page_size);
+	TEST_ASSERT(ret < 0, "fallocate exceeding pool capacity should fail");
+	TEST_ASSERT_EQ(errno, ENOSPC);
+
 	close(fd2);
 	close(fd1);
 	close(pool_fd);

-- 
2.56.0.257.gf7497c7d27-goog


