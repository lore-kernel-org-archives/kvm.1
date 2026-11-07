Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011824;
	b=fY8wGG/FmrkjypTvCl/XnbmH4WM5ula6fMQ/wtPzzG7KWFZ75DqbQdxPS8D0YTqPVR2O
	 nTMM2TrsNkhhcQ7EowcDdZI1l2Hnqun+SZDKK3P2xF6txEDk8zOmthplYh1aFA1MjsfVp
	 Yqczsq55tNnQaM5SSqrCmaYxaCmbmPuxyo4BWTV1krpn9bYyQkWxmMuCB/j2z7sRzY7cT
	 J387QsnD5IFck4uIfCd6W1hzqjH1xAahTxrFPVnpD6fHoUMs8AKO+hD2t7fyhmleRtnvV
	 ERykLMt0TbasFTOCO0tOYUSKEmMr82lfsnYOuMLr6zadyDYBsKMkhyjmefnD2pYMeTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011824;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+XUHsmZeTE+/d6Lf6AimXu/HQocGY6bYgFl0PE10MLE=;
	b=KvUXyM3wTgabO2hNO/dekZixAobsqAE7/wn8M0CyWHum8D4f0d9Ioxa+/Jn0XxrVjsYE
	 Ny3YibBkagx97NC8FuZM2VUuh9m9lIjTeeGnifpZ7dLm2U6QXJoPzPN0Vu2NwZsV+OKdR
	 M8cKbTUHh5dZaVsAVG5/yNNhVZDakV2n5mnSsYT0llkMh8XQc/t1s3wiLvvt72/nQ5r0e
	 3CoGhLfAl0hrS3dFOJ0akH7TDJTIawa0As/aTqUGfOrhs/N9YW27xqR0xN7Soexdxrbj6
	 BcdqQKGZMxC8n1mDiDm3GAYDmYsG3up3DoEmtkj9F4h/ytdZ1fJkqpxifAImOUyzzAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fP1ulBq5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37515606D816;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fP1ulBq5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011818;
	b=r9zoGIUuYLOthhJjcZmYCrZl4WpPrnP8G/dzienPCnYpe3EGLeA/InkLE8aiJQ7RVsMl
	 vRnbaz2z0EU49PP7orF9+PEzIBk8NCdkDnlLyqHnvBRo4KJI3/1AjBdxqTXQjCwxuFa6m
	 bzC6CnY4cQ48NNJ9PUlixAkDAWwGe46oJdQAiVjNozzmLNX9BFe71wlEdMxoTdbBHc7Rp
	 jpXt9f20Iz1l/TncPoqM0R0DbtNQAZYasB9DDQaV4kVAPpdfg68jWbNRPI4Tv5mgw7pWe
	 gGmnQc7IiCHA+yPnSpCX0gu00RKWRDdDdpp1ylKUlcU7gZYhincJE7de6/B3NQ+S/LA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011818;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+XUHsmZeTE+/d6Lf6AimXu/HQocGY6bYgFl0PE10MLE=;
	b=ofZiw1Z2GN8vWclmOs21GgnB+d0+dREUmewc60DsOqHnRHIrL57LGIia6SKoV7EMwUdU
	 rWXQ4Wp89QgkqcyCQkYIj8QlXJTPgUzqVAyk6XF1vXe5mqEyX5o2uYsW5Ddq54I2tL4sr
	 ahTAPa6paBzv7AO05F0zfBxGbSi7o9C9K6z4b/Ia24v/y/nNkS+9nbxU2ap6Ej2745Pu1
	 CQ6V3oqPCMj12f5OOGPlHSa7N0Z6hs7T56mVcfKTuBC1RDs8d9WD/Rqo922wgvSP9KKFA
	 roz+icR6I/mnzog2sdJrG4XgBtJRog+ITr1+KZqVWeCv+XFQ91UHFGZjC9kE4Hu/A/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9993E1F00901;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011818;
	bh=+XUHsmZeTE+/d6Lf6AimXu/HQocGY6bYgFl0PE10MLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fP1ulBq5oX6YZqsr2uTDb80dsrutYpVmZrOwSLqZUNVYjl0qGSHpxcZC2vyktS06t
	 FwJ5qt5enRvISsblVjhWnYzqf8XRmaARe3mZHDP79Xxw47+xnQhidaDztq9fTHTJxV
	 4ooiv0Pc5Ioay4UHy8S3J2+bNHZJ4sCSOys2Jtvj8laS0h6Lxz2OZujiEfn0rPGIsL
	 B58U9Vs1Q/Jd3cRurL76RSRs90QMs8J8a9IjlMF1/nXpuvi3RAWs6zX05CSCm1NPXC
	 2YAdwj7phB0aDnUE0NI3HiYFC7CBotJ7uihH4dP6sx+s+cCc9EROeBlzuYFP71gSVh
	 BHGFAX8rJsviQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 139FA47954;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:50 -0800
Subject: [PATCH RFC v3 16/88] KVM: selftests: Test that shared tmpfs
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
Message-Id: <20261106-gmem-alternative-providers-v3-16-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1067;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=NSNZp2TvUElTKQXMVaHgiSKEMn4WansSyP3qnP7lAE4=;
 b=TzAIr6cJe10IhPRtWsxgFp+NaYLpK7zef9IbjbEjVnmlhCYeSKRyS2vMmwoTfTHH/N/TeLBqI
 KF1EnJPBXCABQ4b8FSTXK49EUlCJHblKHNv0GHCSAiZkoYJ+Zw2o9za
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
2.56.0.455.g6c5a503b38-goog


