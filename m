Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011824;
	b=IEbuZZTkS85TMFEDxuLFEXLw19K0TLNfrmxvZ5LZ7XHsP7BwdY3OgvH9dTA4r3wzJ9oV
	 1W2Hn8Si2PmIGo+ImqfBjBxnXFZzxTOmCEEVCRnSCAdkimOBs5yMv8pF/CWozv0o1nvnC
	 xw/gcAhWNbQ76y+lYoyax2nHDtrYuoOVFvXI5XzafYJYd2QqejirNRvGgaA20or1vWuaN
	 ngl5nw+vxyg9vl4cqFYwnM5fqlkF3MW9D9Z7leioO+S7PCUbIq7jF0LNkZ8HpGiR4Ez6A
	 jbxaaf47zU0SEj8pfrmvyWyTVNcJQyhpxIppuJdRLUluEcpwHXwj/PlFlKwR3yNQ31w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011824;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=S5U1vBcAvPXEHJyvTPB2rKbaQ5CQjq4wj/QhoPwIRHQ=;
	b=sQQgl+FlJ8YPK5HHNqlDblif0usS+JC+pfSUfLdv5OC/ngddVxokoWaQN/0gTIv8Fw0N
	 bJoFWsmn4bfIe2lP1+SFrq5VSwc2CDLt2xO8fFOlDIg5SxBIDdnSz+8TVzRDl4IbNgCa6
	 tV+yZSp0d99vM6y6FfO5BUHU2eLL9XwoRFxvN6MFu813KB1FyOpSMM/+dTLVdZ0edsKq1
	 SwFad9iagK5jFW0KWe/eF9ZPosRLKxOXeWqHI2+S7Or1likWuKqWmEPFMZJc5/9Ruthjj
	 sXaqOCBpkzMkfCajipTJlbGvlNy1Ekda31bnbWhOjETw/yZxgspMDdsrLYXJtuHeBUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4pVhmIv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B756083612;
	Sat,  7 Nov 2026 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4pVhmIv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011824;
	b=KBArQC/Oq7iLLSMLXrRYmjKQuQ/kji1LwtBAie0YHXbB1mPhM4Hu7ucQnrgqnPSjRiSf
	 F4ddcWwQrhlsyNB1DGWiplZAGQltaoRZgcmrtjmmoWc36wUsup0DyTgsWL9S6VDcXhdQm
	 J6ROWM5m5WpwhhsFr73j8L2zrNt++ly/em4hYeRZBJsTyUEzfzPRws8Quwjcw4XLxq0hd
	 E8HK4FXz/cIYR7d3VHMdJiKsDQGjbGdqPajnDbC4x85E+gbqGFrir5IfLcLQMhLmsZ1E6
	 /xndn63BnsUEbVmFpiSfg4D5tb8014kaEC613XPRacXNZUHwTEAS0j8URHLqk01rz7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011824;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=S5U1vBcAvPXEHJyvTPB2rKbaQ5CQjq4wj/QhoPwIRHQ=;
	b=MrlMwc5rjtTX2YpEjCv1vNZ5/HWCBZC2r+ECMFVwVgeFsubgxRgejBbqkFWkVJqzpCjT
	 oN4tTJUQoe1p+jIj/QebRgzRB/dgLLdX+DI46W5uems3F54t7VLe4ZL+mai7nNj2g0nDu
	 Y7ezKB29cpP5utDhUETFV/0ZAoNGe7iFqfRh1yIgP7ekfNY4l3VgILhR4dxhOLVbiE3vs
	 hvpvXwP8senUDAtISC8JrDA4sVJ5u551tniKqB/82wS5Q6bLsUVn03c/wiM0YlGunWgXY
	 7k+e+KHYDChIatUBQ4yGdFefyg85qBODD8AL48ucKIc8yhox0BR7AVo4EZFDwL3TylQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AEEB71F00926;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011824;
	bh=S5U1vBcAvPXEHJyvTPB2rKbaQ5CQjq4wj/QhoPwIRHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=n4pVhmIvBDq8Zf+8zKLfiav8wA55AQSnfCSjDtKYos4bUck/iWii9OidiUC3PS/P0
	 RCezvxLa0nUuDfnBexAOVJN901gZU0YXfCHw4swK7bF+yLmrYYTPuXMCLxSlXYW737
	 tmPUsIqp4sO6RvYz0xxDPAuBmaVVUDdiKv08XUWoLBjQQUvp1Nhwju1e689cNXN35F
	 PKBTc3FWe4xxeKH7ZqGxxPFcdCPHWFduUiEGyRfrbjeZkGPoXI7c0CtjPIjPwP0Lmc
	 tIGg1oage7ylyjohGW+7FUmVQrUQPPbHVdvdNzw//p47hKimJcrUeuvutRwJNIop0m
	 6QJ5D1B98UdmQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 838704796F;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:57 -0800
Subject: [PATCH RFC v3 23/88] samples/kvm: Support marking page ranges
 read-only
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
Message-Id: <20261106-gmem-alternative-providers-v3-23-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=4397;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=uCxFlNpPcP9FnzyIzy9Unrpwvcf5nvJn0X5xwMufqy8=;
 b=j/WL6hlQZXrm+u/S+eSzi3ytYlMwyAapZVonBbyI2r/4jUIzA2DkDcMAADCPlPG59GETbxOk6
 psB+vx5uu7fCus60Olkz15vVkR71H3wp11j9IPvnavrNQKVxAXemkYv
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Fred Griffoul <fgriffo@amazon.co.uk>

Support the MP_SET_READONLY ioctl on provider files to allow userspace to
dynamically mark page-aligned ranges of a provider file as read-only or
writable.

Track read-only pages in a per-file bitmap that starts cleared so all pages
default to writable upon creation.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/kvm/memory_provider.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
 samples/kvm/memory_provider.h | 15 +++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index 6b8364afc5ed9..39aeb1a0b93f6 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -36,6 +36,7 @@ struct mp_info {
 
 	struct mutex lock;		/* the bitmaps */
 	unsigned long *absent;		/* taken away by MP_SET_PRESENT */
+	unsigned long *readonly;	/* marked read-only by MP_SET_READONLY */
 };
 
 /* Byte range [offset, offset + len) of @info as page indices. */
@@ -54,6 +55,19 @@ static int mp_range(struct mp_info *info, u64 offset, u64 len,
 	return 0;
 }
 
+static void mp_set_readonly(struct mp_info *info, unsigned long start,
+			    unsigned long end, bool readonly)
+{
+	mutex_lock(&info->lock);
+
+	if (readonly)
+		bitmap_set(info->readonly, start, end - start);
+	else
+		bitmap_clear(info->readonly, start, end - start);
+
+	mutex_unlock(&info->lock);
+}
+
 static void mp_set_present(struct mp_info *info, unsigned long start,
 			   unsigned long end, bool present)
 {
@@ -73,11 +87,30 @@ static int mp_file_release(struct inode *inode, struct file *file)
 
 	if (info->cma_pages)
 		free_contig_range(info->base_pfn, info->npages);
+	bitmap_free(info->readonly);
 	bitmap_free(info->absent);
 	kfree(info);
 	return 0;
 }
 
+static long mp_file_set_readonly(struct mp_info *info, void __user *uarg)
+{
+	struct mp_set_readonly sr;
+	unsigned long start, end;
+	int ret;
+
+	if (copy_from_user(&sr, uarg, sizeof(sr)))
+		return -EFAULT;
+	if (sr.value > 1 || sr.pad)
+		return -EINVAL;
+
+	ret = mp_range(info, sr.offset, sr.len, &start, &end);
+	if (!ret)
+		mp_set_readonly(info, start, end, sr.value);
+
+	return ret;
+}
+
 static long mp_file_set_present(struct mp_info *info, void __user *uarg)
 {
 	struct mp_set_present sp;
@@ -105,6 +138,8 @@ static long mp_file_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case MP_SET_PRESENT:
 		return mp_file_set_present(info, uarg);
+	case MP_SET_READONLY:
+		return mp_file_set_readonly(info, uarg);
 	default:
 		return -ENOTTY;
 	}
@@ -147,11 +182,17 @@ static long mp_ctl_new_file(void __user *uarg)
 		goto err_free_info;
 	}
 
+	info->readonly = bitmap_zalloc(npages, GFP_KERNEL);
+	if (!info->readonly) {
+		ret = -ENOMEM;
+		goto err_free_absent;
+	}
+
 	pages = alloc_contig_pages(npages, GFP_KERNEL | __GFP_ZERO,
 				   numa_node_id(), NULL);
 	if (!pages) {
 		ret = -ENOMEM;
-		goto err_free_absent;
+		goto err_free_readonly;
 	}
 
 	info->cma_pages = pages;
@@ -178,6 +219,8 @@ static long mp_ctl_new_file(void __user *uarg)
 
 err_free_pages:
 	free_contig_range(page_to_pfn(pages), npages);
+err_free_readonly:
+	bitmap_free(info->readonly);
 err_free_absent:
 	bitmap_free(info->absent);
 err_free_info:
diff --git a/samples/kvm/memory_provider.h b/samples/kvm/memory_provider.h
index de07ffa482283..f3772f57f5bf5 100644
--- a/samples/kvm/memory_provider.h
+++ b/samples/kvm/memory_provider.h
@@ -27,6 +27,21 @@ struct mp_new_file {
 #define MP_NEW_FILE \
 	_IOW(MP_IOCTL_BASE, 5, struct mp_new_file)
 
+/*
+ * ioctl on a provider fd: SET_READONLY on [@offset, @offset + @len).
+ * @value is the read-only value (1 = read-only, 0 = writable), and @offset
+ * and @len are a byte range within the file, page aligned.
+ */
+struct mp_set_readonly {
+	__u32 value;
+	__u32 pad;
+	__u64 offset;	/* bytes into the file, page aligned */
+	__u64 len;	/* bytes, page aligned */
+};
+
+#define MP_SET_READONLY \
+	_IOW(MP_IOCTL_BASE, 11, struct mp_set_readonly)
+
 /*
  * ioctl on a provider fd: SET_PRESENT on [@offset, @offset + @len).
  * @value is the present value (1 = present, 0 = absent), and @offset

-- 
2.56.0.455.g6c5a503b38-goog


