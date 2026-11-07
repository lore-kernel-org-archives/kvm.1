Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011830;
	b=nBt3Z73oIusowLGmk2thZrHZCrL7xNhit6xJHxHCpxEwB3CVkneS7Ce8e768NlMKB8Mf
	 HIv/3avVtlTjGc01T55SJhfobig8yZ1W8HeP94OssooUroKLsdJRj0Icq57mkIiaa2zur
	 4Lq8GumtXCHjMtNPRm0xRrbKD+5i5kN/ED56zB75FQ2jgVw5UL6UOWQjz+tH76WKZnHrM
	 pthlAo5pK67oLhewlu7dP2I4dFXiUe77yEQfY7EUO+XznVltt8gCB5Jo/4lYiWIsD0FLe
	 xx9Obr2tXxrdWUhJ+Sb4I96xDHPQ7pZFRoWj3y89Y1gwaBWDTMX1TcLwYPNReFoFJ8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011830;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Yzu0WztVZO+I42F3GOx4nhxXNzyLzizDuJSmvZVdpqM=;
	b=3bGDc6lUqmF1ohQqNpm3rrAl80sk4zwBOiUjflt4QgFV9Qdo1hII11yTGSB7OCdSg3Jv
	 xXe63uTJ+/kcK/j4R4apSq2BjCOndfdcfh3HbJ422ThoRdGsuMvFCKvGn8nalKY4IBeVt
	 Mt0VudDaRmdnbQTRj0gV3rPcPc9gd5y7F+OKPQ8ED0OgN2mhgAIg3hP7nvd/hKbykDkk0
	 tGQctc8t44/iqdPUecGY727LMj82BrMMa8rgjOyUQikureJXWxueWubrGAQbuvMHdzGcT
	 bgIrrAVUsM73dK6oqm/CfnZRFxFGWXKsdUKbXCkQW81PKOC+tVXoBftJBotc0KKjB7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJioMraV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134BB60A381C;
	Sat,  7 Nov 2026 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJioMraV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011830;
	b=rCRlGsA1YpmmA1FRBvN4SooZ1a6zVr4937AWlbQ11i8e7hQLthx7cnT/m0TY3+rjisBZ
	 HZ5dzuA/amsoq52lEI5Vi94wyCZYuIvc2Z39Q/NC51bj61+lRVpzZs5rqoROCqilQPBpH
	 7VsabId1hBFt4ce6eGcTkuYtCunZn3JSdDQ37lcUZLDuxeT7EBzeCRgOOAxy5mnYVILBq
	 27//4/guiRRi8ZlIJZlcuJMgXXcAV+Q/vn4vf9MvR8sKl/sASkpscgyhpYktJ/hnxLAyW
	 WwNRmKj2/qqeorvh9FZ3LpuICdNOaBU32grC55r0L9v/+LsV1HjV8CeKg1qrML6Kt9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011830;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Yzu0WztVZO+I42F3GOx4nhxXNzyLzizDuJSmvZVdpqM=;
	b=OPkiYx6t+0S1JM3ggmfFju5qqxB8FJGNVVfAMjjQ4D6bUDzkcSPq86p3ifnBnsCM1CBY
	 85so+dPDwfoEjfwGi7dQ+rLHUSiGjjuTtmHgg8srMH5JRVH/RsE6p2HZB5shvipOLTPUN
	 0Z4RFV1uCb55tA7Ad3P4/Y8yhggDiYlL3kO2U7PBbUYm/9fnpWDgjd81qFMYg2U1QKKiG
	 QQDkfL8CMWLVWOHnufQ5RrRFhBLhnTBA7XjfM2qsNKx8ZwzF5veN1OEbSUf+FvrXAKxPb
	 AvXnnnut5LReP8e5wUpRjt6h0hOjKQiyE6JdM7NPhdwJa9jn47IZxQ0o9klPyh2Gsqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7FA7D1F00900;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011829;
	bh=Yzu0WztVZO+I42F3GOx4nhxXNzyLzizDuJSmvZVdpqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DJioMraVOa3WcBIC7iAEv8B5su40kFbIpqHrqJB8T13ICiQ7PCuRGUETY+3hu/IT3
	 GcgEkn/e8EwkD8tXSTSHTWJty7928OwC/dGAmdBxC8OYvWO4Pck2W4BYzv1Y0wLWED
	 dt8eRqgdAfc4rtyfQfdtAEY4bNDa+qCUxdwsf7qaP//wKVviffqmzoOGtNECRIdW7R
	 ZMcqo8o9AFruMoZE5T1n/I0pzyyfwKk3XjUTZULvSz+sAQzxVaFSgEXcclpjWBL1Aj
	 hItMBJL9iHQ4GmfKcUKeO2qK59w/r7tlqUAz0Q0pinsEHU6xzspLs/U8SFXdz+YLzx
	 iX2NltxOIvcpg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 14ADB4798E;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:05 -0800
Subject: [PATCH RFC v3 31/88] KVM: guest_memfd: Set VM_PFNMAP on VMA in PFN
 mode
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
Message-Id: <20261106-gmem-alternative-providers-v3-31-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1105;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=bgDskVh5mQ4qf8kZnnMpcc5wqYuHuhwtZVlrwhGpftw=;
 b=bJSGIHIjI8Dun3pnzzwKMZBEVyIeNKBR6I98tBOsF6T1Tze7EzogHxlnUyHvxeFc6sylwP9tC
 RStTsmb8zUGD1ktql3UfDaKz0Idd1TUrp9o5uPxLSI7y9s4cXsdLKOq
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

In PFN mode, guest_memfd memory is backed by raw PFNs rather than
page-cache folios.

Mark the VMA with VM_PFNMAP when setting up the VMA in PFN mode so that
the core memory management subsystem recognizes the mapping as PFN-backed.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 180418c65a1ae..183e15775523f 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -652,6 +652,8 @@ static const struct vm_operations_struct kvm_gmem_vm_ops = {
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct gmem_inode *gi = GMEM_I(file_inode(file));
+
 	if (!kvm_gmem_supports_mmap(file_inode(file)))
 		return -ENODEV;
 
@@ -660,6 +662,9 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
+	if (kvm_gmem_is_pfn_mode(gi))
+		vm_flags_set(vma, VM_PFNMAP);
+
 	vma->vm_ops = &kvm_gmem_vm_ops;
 
 	return 0;

-- 
2.56.0.455.g6c5a503b38-goog


