Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011822;
	b=L7/b7lhtcOyjH2/o0jS1QkL9Pb+Rcin0SljOyZD4RoP83tcOjskFUPrYQeAtoIyiqwl5
	 qVLCZNAeXzRTawlP+nkEkJtHVDW8a1s+geiZwwQedpe8n9kSM7BOYTxOtGH9vGc78dmdS
	 hZaeor6v0eB8BtLJX53dBVkAI6VNTD5i7y6y9CC7tfCJ22bWc8g0UZceio5QsrsbRv9q4
	 VCFuwCzFaXJd3AymfAMU3ws1pr8J3iV0tPK0cLFxvDjPG0dskCl8BRX78sb6a72ArGlNm
	 zggD2TQARv+bfiyRlmiDt3baZ1Hfgj9Toauu3fYDRJHqgAOVUiZdlsA6+CoxtTREgbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011822;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KYQcoPoT+TiTChq9S734+r6sv2Rvv/KnvU2FGo7SPLo=;
	b=4AXbGAR9TkuxGF6SlqgYvxidu/d7YkNE3ARIYmi1w0FqFMSU2wAHNGtasRYZOel/ryeW
	 RH1PZVGB0bZRuidSTYlOPuSVzT58miY50XYG7bXUyv+KNg5nLRhxTNLgP5g6C6i9cxpRy
	 uuJTRriaRs9Fe5KyXjLaw9wyXeNX//sNTEyeAUaJic4NMjFe+/IiEQ7UrX0V8f+1SiML8
	 kdPfOLXQ/2CXkXk6eLdfZuC7HndRviDK1Sw3ZA3Yuy3hjyJyWFEtwx3ncHjVwdOpD2rrP
	 Ndwp7pxHyvUkOqAdCFINvlDh7QuS6U/ixVlju+gyEBXXk+NANcIOTq0L2POhFjVFwuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZR44uLX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D21606EE96;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZR44uLX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011818;
	b=HRMiDfQ8ajIuCkQf+NqqMN+Nzxr/LBlZeEHUIvomvANEuQz2jo/dCI5nU+Fy2gCFQ6HJ
	 8bN/41fe09u8TtAWOwKTGzIjwLi/oNKPwuxIVdr9WY/eJ8+FN92vNGSrP1HLZkmP5g/wm
	 f9X9MxB06L183kgAruErsAdEve3IxyiXGxHohYva/JoqUnCBesEmD8ctNRDX9aRFHPIHM
	 NszHcX0Uc2PN8Bsw3xhG//834K+oSfKspPKJJpv7/3qqoqOILGh+K10jSTCRokvX6rXRg
	 TLqrYgoU6Kt/3tkTqc3hScRcmthgtD84HOUE2YBAcv/9VvHP0w6zbqv9WfX/10mYzow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011818;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KYQcoPoT+TiTChq9S734+r6sv2Rvv/KnvU2FGo7SPLo=;
	b=BgPp4xXKDhsbCSLSm5QfmSLOzIBPN/G3uvdE3ATK4iYWbuuv81WzNzbDMJINbYH9e/or
	 UJmC9Ko8ILfnwlxgp1hW+qasvHhbI+PFQF0qK6FeQvED0qfCQQQMqQu2cvZ4DKSAsYkb+
	 08oBHWc5N+RPx/0l8yeIse0zrhc6haOBG5QwcqpBDdaDudcHt5OJ9DoWaDeYk0XMfnESc
	 ilLngQ3pt6YVldZ8OSYM3wrn91Sx8pHtmQemQKBcA6J/zWp/iWi8QHroKcMT2f57gm2PT
	 tLsGVWuAR+OtKl0e+N5FLUQbFDZYyKZimuKQFF4kXaCVDD1Lu6o45tZxXT7NOj+GunQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 269641F00907;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011818;
	bh=KYQcoPoT+TiTChq9S734+r6sv2Rvv/KnvU2FGo7SPLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AZR44uLXAkzv9LkdZplwoYbYql1WdkWmMI3bK6jtFx9Nl3IHsg2IqgbZlzTjIXLqj
	 1ImkTjdYth0pcfyGQVeHKKlzpOijNOkeB2hg4aV4kkyQJS5gxvJLhY+0uLoF7jC39a
	 Mg/emigBmh7clPr/Tvv15ddcSnyw0rdZMHF1t2x7hQAHxKtvb4ptuQBVMUAq2qAAMh
	 Y0zyt5tTsH3M/tg8N5HDkAqj1uOgmSb+xzOnbiM9TRYmgfMGc5jXH8HsWWIcjEZhRd
	 J9TfFKMq0S5NyixMCz32mV//I99BNRJT+1JioVVmaJOb9W0A5TnI2v4M6/8s4kW05z
	 ggxbxZ10yvf9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 36FF84795B;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:52 -0800
Subject: [PATCH RFC v3 18/88] KVM: selftests: Document testing TODOs
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
Message-Id: <20261106-gmem-alternative-providers-v3-18-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1090;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=r1ZmFiR1qPCCBxX8ciGCFcsvJLc5HDkv8vhs7vVOKUw=;
 b=6pZvfbTvHbGzO6Z9YIneIq3T90JrEFZL7fDyOhT8/iiNQMcWLUJ/EJt5W2PPBe1GU4JzzYZmE
 4L1rjvsT8X5BB33CyQAYR6oIMcuTNN3d2fOXsyT2kk5AxXVOgIZJjzF
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Remind myself about all the tests (A)I did not write.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 8e9261db23354..fd249445ce3cc 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -701,6 +701,16 @@ static void test_guest_memfd(unsigned long vm_type)
 
 	test_guest_memfd_flags(vm);
 
+	/*
+	 * TODO: Test that guest_memfd creation rejects a read-only tmpfs mount
+	 * (e.g. MOUNT_ATTR_RDONLY) with EROFS.
+	 *
+	 * TODO: Test that guest_memfd creation rejects an ID-mapped tmpfs mount
+	 * (e.g. MOUNT_ATTR_IDMAP) lacking write or execute/search permissions
+	 * with EACCES.
+	 *
+	 * TODO: Test mpol fallback to mount config.
+	 */
 	test_resource_fd_invalid(vm);
 	test_resource_fd_unsupported_fs(vm);
 	test_resource_fd_memfd(vm);

-- 
2.56.0.455.g6c5a503b38-goog


