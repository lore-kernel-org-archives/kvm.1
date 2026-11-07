Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011833;
	b=VgNPe9Nvl+RsPCBeq43Wqf7Fp2VxIvRHrd18yJmBfKxJfNxfDQwp7pirG3BgQDuk6eo6
	 akWk1DaRysGf9hXsw7MGskHAYbcETEt8l3aMpFmpWgu8UehFppe3WzOVVLfLwLTbDPDsR
	 psPB6RQruPf5/MIbVfWyJzZ1LAVCWCPTC82Tnn2+TGj169raR1qX+/cVr4kcE3sgTOLnZ
	 fpoFYOm4EbODxtjjS0nTO6wKsT2a856dkgcmicAUbM60+vAfv30PR2dOJqORp0Kdr3caJ
	 hlu4YGkP/pLxtCWqfHsVBh2G2tyglaGCIWpCr+6wxD7sM3gjnrtD/Uoa/5mM11q3klg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011833;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=i3jEAdvwI3ks0oSL48zLhTdHFjgHRg6VA0pyd/R7u2U=;
	b=lG0ddYpgSer+zKTx2DmDlOVjDwE/PPOcdBW4tXdiLY8KHcx4NCtqahKKTzzucCF1wrFY
	 tsrFO78wP8Sx4/6zTcWCxy+vcbbS5PErdN9OfHEVEzsSATcIvwENubaFad4YhIyQQ7mgU
	 2gWJzhwwqnQdQfBUJx2W8S+y0bhxkjW57mY6Uf4yp6By1dnezZPhfQ1aCgsUIML/BYkNC
	 Fnd5zAhsQJp1SLSuBJwef1Eb+F6sWPt50UwbpgOvmSO534z9AId0utG3ICa+btLDfRmNj
	 gdjEtP2B88Vpj5YI/TU8M8O1xzM9BxOgWTkbWMBe8UhhqDOX2UZmmi/xmDFNe6M/vfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QD/dJNr7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902E60A5BD5;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QD/dJNr7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011833;
	b=JMn1gzRgTw/4HI8psS33dICBLxgvxT+EWFLAEghb/sb43SyN/uyWF041aTySo7HKumPQ
	 WKQSUnmBeFzimfPASr0ibzB9sYKFYLsaD4c6AmkcNagptExqOAFTZrY4GN/H99Otrp6Ra
	 l8U/LbqHQWH1VW4v57OYPpavic1obLtt7G/Mz+ttI1vjs89AVXwpFAWkohUKZYgDGabtA
	 lgGzg5FlLhbNhmpnt8tRSG5dxJBh0bTH7wFDocmIlviCU2ZxP/egouBFfT8GJ2YDmyk1C
	 CnvuDNJr0s6OTDwoqtwW8PhzX8gcNzNNE7oAgcKC7Vx5jmNXXxYuWxzHsIHV/YNhcLQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011833;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=i3jEAdvwI3ks0oSL48zLhTdHFjgHRg6VA0pyd/R7u2U=;
	b=fl9Wz0CuViuu7avX7xYh4s+QHhUm9liPyU9SSHSPtK6SUiCZ06dZKBPnGyqpMhFW/q5S
	 cQihzaVmVLa3RS1H63RHvus1c8gPelQ6k41HRvh9vgR6qxqsHzBP/tunQFHcY6yAK8TyP
	 kBSIp4Qgq2CxUXJ6l2zC6HbIzr4UgNHgZOkqW49oxdMyVGgaOKu8/XLtvqH6jYRL1Yjdf
	 WbRPZYBGAKjhjKI3gi8mRZjRjf1sbZSrv+60rVdWCvbpgdLUXq6tl+9zclK+qICcP7veI
	 ptuPgHBiNU2joNHFlRTH3ey0FQDKIyS0i9A8EQS3jeTLw+TZ9sqN58zg1EZN3o4Rwqg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B45F31F00925;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011833;
	bh=i3jEAdvwI3ks0oSL48zLhTdHFjgHRg6VA0pyd/R7u2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QD/dJNr7zcXziOQvAV2ogtcZNBIsfFvfu2z/NxcbPsv3FtFJFZt3Fzjylrdy3OhvQ
	 prAn8Oo9stdPQ52xT4Bv5fXFlJFvsO25Va6r9qHxX/XNrznBKr4sLC/htqWJM8hba0
	 Sq0yETMZc+1I5vwrU7h0pC5nqjegtPqAsJsENLOZh3AvugUqIvpGEACLEM9lEonkBA
	 bF6tqtY2/2vIKt8GoZDfunqWynkyxXse/PGpzZqP/pI4n1/sL75qYK4n951REp4vDS
	 uWZpGpZ9nNQVjMrBnDFOtBsrliUbXOxCjxaKSrdrH99SrNmG9lz8W9W78XMCOU4PFh
	 XKXAcITFwCZ9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 943E647973;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:58 -0800
Subject: [PATCH RFC v3 24/88] samples/kvm: Support querying provider file
 statistics
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-gmem-alternative-providers-v3-24-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2463;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=EXFH+VGzYxLpiOlUm7+SXlMva0hegPehiKidAH67grc=;
 b=7hVXjaGVJOqfQUrfhjyeyzSTfHIZXZzwulk8Vbz7CGvVDPIUBAJOG2RgnAgqms/2SVLnSXQAW
 lqMSMLCfKWxDFL1pj/KHF5J/ocwGPTJlfOisEvzy/H2N3JF6+G9BW47
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Fred Griffoul <fgriffo@amazon.co.uk>

Support the MP_GET_STATS ioctl on provider files so userspace and selftests
can inspect the total capacity, number of absent pages, and number of
read-only pages of a provider file.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/kvm/memory_provider.c | 16 ++++++++++++++++
 samples/kvm/memory_provider.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index 39aeb1a0b93f6..81ac94ae1a4e9 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -81,6 +81,20 @@ static void mp_set_present(struct mp_info *info, unsigned long start,
 	mutex_unlock(&info->lock);
 }
 
+static long mp_get_stats(struct mp_info *info, void __user *uarg)
+{
+	struct mp_stats st = {
+		.size = (u64)info->npages << PAGE_SHIFT,
+	};
+
+	mutex_lock(&info->lock);
+	st.absent_pages = bitmap_weight(info->absent, info->npages);
+	st.readonly_pages = bitmap_weight(info->readonly, info->npages);
+	mutex_unlock(&info->lock);
+
+	return copy_to_user(uarg, &st, sizeof(st)) ? -EFAULT : 0;
+}
+
 static int mp_file_release(struct inode *inode, struct file *file)
 {
 	struct mp_info *info = file->private_data;
@@ -136,6 +150,8 @@ static long mp_file_ioctl(struct file *file, unsigned int cmd,
 	void __user *uarg = (void __user *)arg;
 
 	switch (cmd) {
+	case MP_GET_STATS:
+		return mp_get_stats(info, uarg);
 	case MP_SET_PRESENT:
 		return mp_file_set_present(info, uarg);
 	case MP_SET_READONLY:
diff --git a/samples/kvm/memory_provider.h b/samples/kvm/memory_provider.h
index f3772f57f5bf5..24a201a58e83b 100644
--- a/samples/kvm/memory_provider.h
+++ b/samples/kvm/memory_provider.h
@@ -27,6 +27,16 @@ struct mp_new_file {
 #define MP_NEW_FILE \
 	_IOW(MP_IOCTL_BASE, 5, struct mp_new_file)
 
+/* ioctl on a provider fd: read the file's state, for tests. */
+struct mp_stats {
+	__u64 size;
+	__u64 absent_pages;	/* pages taken away by MP_SET_PRESENT */
+	__u64 readonly_pages;	/* pages marked read-only by MP_SET_READONLY */
+};
+
+#define MP_GET_STATS \
+	_IOR(MP_IOCTL_BASE, 10, struct mp_stats)
+
 /*
  * ioctl on a provider fd: SET_READONLY on [@offset, @offset + @len).
  * @value is the read-only value (1 = read-only, 0 = writable), and @offset

-- 
2.56.0.455.g6c5a503b38-goog


