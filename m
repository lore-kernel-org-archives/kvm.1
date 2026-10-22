Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792711695;
	b=EBz2xQkTHnI+178WnI8yBZXZtipQO+r1VXcIDBhEce2aWSMoZ0b6o8Gld2kHSs+N6Me7
	 o5MsnE8+k/MUZLjaeuFj1gVT5znT+XjNHBQHIYpRZSCvKYMJFns0qzi8H5He9ASQBiTWj
	 94m/WZTMlChtCl7LoMSlQhDywBuWr8mDityazzpHwXEa1IEKvo2XC63MB0b+GdcL27eps
	 OLzFrEkQqpus6xzJIT4qStZIdkpqDdJPYV5JxFsk+jX0/FGtWIQ/LfVdpNRQsIq+NY4cN
	 t8SgeJEx6Ha8NOVrF0dgkjZROdztTP3W+4C7SbStuy+Uf391nVjjTcYRL2WsVUqCJXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711695;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CvOLW2fSJ2C2vG6YEjhLKjKbPXkKrQ5EAznzQPiJfT4=;
	b=Isq7MsrV2JYsmOJMS7zWwPHlEoSPjCnEJ0ZqWEeTloAgFm5JJ872hvhelUXTjTMqFovW
	 HIV6Q6KsUO5RVj2HxJbsnzrqAdn5wQ5MNWU/Emnib08NtaQb1SaPLFmX3C2osTkjbie3u
	 SWypX2p5xbKAgcs2UyAe/mMdJVVoOyC5EFc022MX0dwCm8XC15bD9DatoFxmPBxE9VA6Q
	 qmmLmBKtnzTILgc64U4alyLZ5k1wipU5rRO8Sl78rcv0OAmD9mg4yuKHJ2Qh1qjoQ3T7u
	 kCrguqqi+qZqfLysqzqde19NijirzE22jqGKA4ngkz/eNfjXSAaq8s42wkikrdaAqaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsQa+DbI;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7460A3830;
	Thu, 22 Oct 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsQa+DbI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711694;
	b=1Af3wpdU206uJnzbMxtyC5vRgycWWBqGtvKcYNFHEZYss4vUifDUfYMbmn1UaFbdZNFT
	 Hna01PEhAK0u5awexYkbOsf6rZr1j7DEzge1r0zPi5/C929P6WPNTa9Ulzhqv0RVH4Os4
	 i4eXihPdoG0zfmWeiEp3Ovq+vxkZSi4s0Ln4YuNuOeYBoYu93Iaf2qxY3c+w+cWL3LQY4
	 gc5zbWlcicrHckOMKuHk/LgAK/E9g00hz3hc1d8oKqnBX6cEyEppE02Aj0+jCrK2CtM2a
	 5e5wKw2QXTmc5q/dcbgIAzN19CnyhFRjlMkBK5e8y6bkw0JL/dvmhPJQwowZR8tW3Iw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711694;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CvOLW2fSJ2C2vG6YEjhLKjKbPXkKrQ5EAznzQPiJfT4=;
	b=na0LeahH0gdIJhZwCBuSsC7WCyrjTr1zX8DRAgp7befQxf5nNQLSprd+6l1bTgCpfh5z
	 NldWatrjzgphgYwvjTkS3KPDCfbz/M9A2/hezPT8Cqb/gYwU1k7ycUYJ4Xfyl8cZRYxcD
	 XHDsLOXoE5nBVqCRBuRkhKENmRytUJrk3gnWLl8QFF/OY5uUCBmZxFI7fVFb4O4bFMjWu
	 4DNoiydErET2MtbrYtfBWJMp6bBse/pPFu5aPpFcgI+3g2bQ8MzosnBtvq2wL64p00xxk
	 oPJHtq8ZVsfnvZhEPLQFATUzBdIZFLFS57gbghBye/jKqvGBgwqmhXsCd7KcApTbBww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CA50F1F01186;
	Thu, 22 Oct 2026 23:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711694;
	bh=CvOLW2fSJ2C2vG6YEjhLKjKbPXkKrQ5EAznzQPiJfT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GsQa+DbI7f42zzME0w3iPpwnStQOjn/DBK8vN/wM7ly88F5p3LEwKPeJGmmz71daI
	 0oSzUrqpGiZtCEzVXc3aKQoCum0vgfH7CdrYrtjsijmvy4Kosb799gXrYzZhErVSVC
	 ypXghTBFoNGiONAfe44u5Mr2C2My1wcbYGNC8MdpvPojVW/1ztipza8zIoQEMVSAL+
	 FCjBUF8cmH2RhxIXqsZg+1KHDDtTiuWym+UeIW9PKgCC+QRKmsTgRrLcAa63XhV1/P
	 7R++CPg1uq6W9DDWYHDZwcM8dpMGe7WtPncW485jbZahrPUQ7p5IUShSgT5L/v4/k6
	 WjS2hOoHxOW1g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A5D27420B8;
	Thu, 22 Oct 2026 23:27:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:01 -0700
Subject: [PATCH RFC v2 29/50] samples/kvm: Move set_present ioctl from
 device to provider file
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
Message-Id: <20261022-gmem-alternative-providers-v2-29-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=5767;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=H/aHfqiQsIGjlkRuZcgzrZG67kHqDrIDRTIsNyoR6Bg=;
 b=SRVh1fisaAFs6F5av7vtWATQWJcgQy1DTGO+tQZj/9hRwxvBUfF76l/qlxY4d03eZsrtDm9lZ
 qso+VjcAhbMD+Y8KkK84sFBWIHRpbZZKhIeu5He2gCzPnW0tg1HlnPv
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Move the MPS_CTL_SET_PRESENT ioctl from the /dev/mem_provider_sample
control device to become MPS_SET_PRESENT directly on the provider file
descriptor itself.

Calling MPS_SET_PRESENT directly on the provider file eliminates the
need to pass a file descriptor in the ioctl argument.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/mem_provider_sample.c | 90 ++++++++++++++-------------------------
 samples/kvm/mem_provider_sample.h | 14 +++---
 2 files changed, 40 insertions(+), 64 deletions(-)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index a8d40f3c631ed..397ebb3773f39 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -36,7 +36,7 @@ struct mps_info {
 	unsigned long npages;
 	struct page *cma_pages;		/* from alloc_contig_pages() */
 
-	unsigned long *absent;		/* taken away by CTL_SET_PRESENT */
+	unsigned long *absent;		/* taken away by MPS_SET_PRESENT */
 };
 
 /* Byte range [offset, offset + len) of @info as page indices. */
@@ -75,21 +75,6 @@ static long mps_get_stats(struct mps_info *info, void __user *uarg)
 	return copy_to_user(uarg, &st, sizeof(st)) ? -EFAULT : 0;
 }
 
-/*
- * A provider fd is read-only to its holder: only GET_STATS. The owner changes
- * a file's pages through the control device (MPS_CTL_SET_PRESENT).
- */
-static long mps_file_ioctl(struct file *file, unsigned int cmd,
-			   unsigned long arg)
-{
-	struct mps_info *info = file->private_data;
-	void __user *uarg = (void __user *)arg;
-
-	if (cmd == MPS_GET_STATS)
-		return mps_get_stats(info, uarg);
-	return -ENOTTY;
-}
-
 static int mps_file_release(struct inode *inode, struct file *file)
 {
 	struct mps_info *info = file->private_data;
@@ -101,6 +86,38 @@ static int mps_file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static long mps_file_set_present(struct mps_info *info, void __user *uarg)
+{
+	struct mps_set_present sp;
+	unsigned long start, end;
+	int ret;
+
+	if (copy_from_user(&sp, uarg, sizeof(sp)))
+		return -EFAULT;
+	if (sp.value > 1 || sp.pad)
+		return -EINVAL;
+	ret = mps_range(info, sp.offset, sp.len, &start, &end);
+	if (!ret)
+		mps_set_present(info, start, end, sp.value);
+	return ret;
+}
+
+static long mps_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct mps_info *info = file->private_data;
+	void __user *uarg = (void __user *)arg;
+
+	switch (cmd) {
+	case MPS_GET_STATS:
+		return mps_get_stats(info, uarg);
+	case MPS_SET_PRESENT:
+		return mps_file_set_present(info, uarg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static const struct file_operations mps_file_fops = {
 	.owner		= THIS_MODULE,
 	.release	= mps_file_release,
@@ -108,20 +125,6 @@ static const struct file_operations mps_file_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 };
 
-static struct file *mps_get_file(int fd, struct mps_info **infop)
-{
-	struct file *file = fget(fd);
-
-	if (!file)
-		return ERR_PTR(-EBADF);
-	if (file->f_op != &mps_file_fops) {
-		fput(file);
-		return ERR_PTR(-EINVAL);
-	}
-	*infop = file->private_data;
-	return file;
-}
-
 static long mps_ctl_new_file(void __user *uarg)
 {
 	struct mps_new_file nf;
@@ -190,31 +193,6 @@ static long mps_ctl_new_file(void __user *uarg)
 	return ret;
 }
 
-/*
- * CTL_SET_PRESENT changes a file's pages, by the owner on the control device.
- */
-static long mps_ctl_set_present(void __user *uarg)
-{
-	struct mps_ctl_range cr;
-	unsigned long start, end;
-	struct mps_info *info;
-	struct file *file;
-	int ret;
-
-	if (copy_from_user(&cr, uarg, sizeof(cr)))
-		return -EFAULT;
-	if (cr.value > 1)
-		return -EINVAL;
-	file = mps_get_file(cr.fd, &info);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-	ret = mps_range(info, cr.offset, cr.len, &start, &end);
-	if (!ret)
-		mps_set_present(info, start, end, cr.value);
-	fput(file);
-	return ret;
-}
-
 static long mps_ctl_ioctl(struct file *file, unsigned int cmd,
 			  unsigned long arg)
 {
@@ -223,8 +201,6 @@ static long mps_ctl_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case MPS_NEW_FILE:
 		return mps_ctl_new_file(uarg);
-	case MPS_CTL_SET_PRESENT:
-		return mps_ctl_set_present(uarg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/samples/kvm/mem_provider_sample.h b/samples/kvm/mem_provider_sample.h
index c4cb10b4aadeb..b9f10286cb30e 100644
--- a/samples/kvm/mem_provider_sample.h
+++ b/samples/kvm/mem_provider_sample.h
@@ -30,25 +30,25 @@ struct mps_new_file {
 /* ioctl on a provider fd: read the file's state, for tests. */
 struct mps_stats {
 	__u64 size;
-	__u64 absent_pages;	/* pages taken away by CTL_SET_PRESENT */
+	__u64 absent_pages;	/* pages taken away by MPS_SET_PRESENT */
 };
 
 #define MPS_GET_STATS \
 	_IOR(MPS_IOCTL_BASE, 10, struct mps_stats)
 
 /*
- * ioctl on /dev/mem_provider_sample: CTL_SET_PRESENT on file @fd, by the
- * owner. @value is the present value (1 = present, 0 = absent), and @offset
+ * ioctl on a provider fd: SET_PRESENT on [@offset, @offset + @len).
+ * @value is the present value (1 = present, 0 = absent), and @offset
  * and @len are a byte range within the file, page aligned.
  */
-struct mps_ctl_range {
-	__s32 fd;
+struct mps_set_present {
 	__u32 value;
+	__u32 pad;
 	__u64 offset;	/* bytes into the file, page aligned */
 	__u64 len;	/* bytes, page aligned */
 };
 
-#define MPS_CTL_SET_PRESENT \
-	_IOW(MPS_IOCTL_BASE, 12, struct mps_ctl_range)
+#define MPS_SET_PRESENT \
+	_IOW(MPS_IOCTL_BASE, 12, struct mps_set_present)
 
 #endif /* _SAMPLES_KVM_MEM_PROVIDER_SAMPLE_H */

-- 
2.56.0.257.gf7497c7d27-goog


