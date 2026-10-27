Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116045;
	b=Tiu4Gz1KGbpwab8Kg93ttHo85TMx+Jv2HziLT6S0CUBAErcWMODnN159lDTrndrW51Zo
	 mbq5EeMzIufUKjArHf6LttmP3E+xSC8aNqHuz2AWkXaXIEjUPep8dKm3a3nIT7rDTxC32
	 hA7dLT9wehCG6vmaJJZcjKEXH2lrz8LzSGP/koZ6UPO+f4eKeBH+DHgNjpXHrt3UBIKW4
	 r0QobZRPwFaBTRUAkbcGDMFgfMzA0AC0DDOXfzZdQpxmKRf5LybJFvlNd6fzAYLf5Ahym
	 9PQTuYbtC03NWn8j+bGcPSrEyaaY5P56lzfDVwH48sZMEG3uNLvoSDgU8j24L4nM63w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0HiXSaw8ZLiMKT3XuSDklH+uJG7cgDM9jgjpZ0euyso=;
	b=LSgjOJz0uEbJvt+O/Ko2MG+1MuD+ZkCnYO8ZTMGwUgvuWsuYuof3G/tyl4HcTklqe+dD
	 mbJq6z5woGOVbYAR4Bz/6krk4VFq4Yg0RKAhpylhC0obH2R0yjT23smuLywYVTg79rAKG
	 u7i7dWIIzSYALbRqFTh34lifKixIGJhys1ZFiLE4dzc6QERH12oXr3Fpo5SF6fUpXDsro
	 GhqvnJlJayz8Lxy84lsrYyU2fquMYU07LzPDOsw8wj1186K3EtT7buZcGTefQe2y31ANt
	 SpZKHfgXgzCJq9P//u+4f89k0HXaDmaPBGO08uyP4fQkNmCWiVeR268hf3m1bGQJvww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gJnuhoDm;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A5606E6FF
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 541A5606E6FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gJnuhoDm
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48bbb06e746so2303983f8f.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116043; x=1793720843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HiXSaw8ZLiMKT3XuSDklH+uJG7cgDM9jgjpZ0euyso=;
        b=gJnuhoDm5wJtOiU9sFXK6ThmZCW+nn8wbe94uliJXxaE35cwKLly1ieXjLKE854Jxz
         Gmw4ITGRvNvDZGoTn6FPhghncfZVSmNFF7J/hcXSX4of3zxzkidhzba+BaSwVLNhd4uT
         rNl4zIEwGsRih2D8o4TzNE/1VpjouAyyfcLtplEw0jZWvgOYAyIG9E2q4OYXE7GgrNoZ
         ok+a4LKgA+/pRoEMGfePAs0AQyE6MAu4wqlGlw/DO/htRFcOq5tOt2+DAMRu3PDuT5/b
         dmCUnQwq/IoHZzvOBwtIrBtdHTHyCWOVxAkZyJlyPkRC9myAtUzReUZQMXh4Td1SHOIr
         kztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116043; x=1793720843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HiXSaw8ZLiMKT3XuSDklH+uJG7cgDM9jgjpZ0euyso=;
        b=PehG3KlmXTEoCf+MdL7A5F8YOMDYN9aVH8FYT7QSI6ysPDQXJeoCsBUQkfGtzGP3Ys
         I02PQnN0XLraG+lY/Izd5PFsqZH1vZNKfJA24ZqRwBr1Fwsvf169N2AnUNpQRv7fdN1h
         16ABf/HxHnGa/h1pnaH/0eynsh3nHROtsfHlxexJNOJJjoIwNfPpTuwBOIzGFvVauEQK
         skrhGgYyrXXpb8byUag/nOCM8FloGrKLc3j4YyYnLoy5nVmqR17DXdOFsRsoHVo23VBV
         7X1US3PSfNc746yDxBwx7ihmqVSPiEPNLmKiZ3HZ49l8Wt7WnNaKAwMUhLezzci5TQc9
         z1vw==
X-Forwarded-Encrypted: i=1; AKwUvBztN2+UhnYy847TxEt2XkFl2nuVQh2bnsdLjphyCqxrGPHRiKyQH0WX17zDQSs3p98zpsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJek3ivjFXqKmI41SfR5eI6MScqet0CbKzSPwhxw0cna/jcvu3h
	OkhpGehodV6n+jk8Ygo8aHaqb/p1pwLJ3FdzSWeD1ZjDIhy3DIgFVUJ1
X-Gm-Gg: AYBFou1NAktvLoeJsMlCJwOoqaBjCq7nLQ5a/6nbYf9B3rKoG0xQZLxVDmE9nm7k3Gn
	1VSaZi7F0RzyTqUresd7A6WkFYU+5KaEKXDYw83pdNRT+bJgGYaKc+C/o4qXyBeUC/2BvPw2K5F
	bs6k77YzAZxvqOuSwy22pLidXRCd2PxokO7a4Vk6YIkYsnoHru8zkPyt55782D6jk/b/APgUX4c
	cG0aoOzrhN9z8Ez0AfXYT20ONWv6W+545i19+rNtTw/asHQlkb+VYCzKRvcyNwYrYJAGyLP0Iqv
	ncLx/WvYkt4ktvj+AVQoZj5yK5+yfz6PQXUNmu9r+JWhSzOTKFHYeMTFqSWiPkXmeOqHKL6GHWx
	6QyGph/by0ksAxc9D/PDH2EKahRaQOG81Wd4+H659Knio3p5UWASCWjsKF1rbyTA+Hyk88PUn/k
	JZNYOofxWbik9AAj7SavBB36TsFVAInFCXluXTzB05lak86xsyjIVn3kf77IpguL1oOmA/oVac2
	wroHyjLVHFXHZuOKRGV+qt0uQvRHErt+hI4x6hcNdbS4EfqbzJpGp/Pv5RqZ8GMuCut+wfN85YA
	3bWsXqyStIkehy5mM6/i/wXVSKgOUjcaOvWRTa2TtRI9I+SdLyIevGJv3hVCyYaQ4T1gD4Ps3/D
	SN5u6Zxj3C32RGO8A
X-Received: by 2002:adf:e00e:0:10b0:487:40d:af29 with SMTP id ffacd0b85a97d-48e3eb975c0mr15293194f8f.36.1793116042581;
        Tue, 27 Oct 2026 08:47:22 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:22 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 12/14] samples/kvm: Add read-only pages and large blocks to the sample provider
Date: Tue, 27 Oct 2026 15:46:47 +0000
Message-ID: <20261027154649.91571-13-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

The sample provider reports every page as writable and of order 0, and
does nothing when a page comes back, so tests cannot exercise read-only
frames, large mappings, or a device mapping that follows a page made
present again.

Add MPS_SET_READONLY, report the largest aligned block of pages in the
same state, and call kvm_gmem_restore() when pages become present or
writable again; making pages read only revokes them.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/kvm/mem_provider_sample.c | 89 +++++++++++++++++++++++++++----
 samples/kvm/mem_provider_sample.h |  9 ++++
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index f30654a60dd8..670e36207e59 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -6,7 +6,8 @@
  *
  * The control device /dev/mem_provider_sample creates provider files.
  * Each file allocates its own contiguous memory from alloc_contig_pages().
- * Pages can be dynamically marked present or absent.
+ * Pages can be dynamically marked present or absent, and read only (for
+ * tests).
  * See mem_provider_sample.h.
  *
  * Confidential VMs are not supported.
@@ -39,6 +40,7 @@ struct mps_info {
 	struct page *cma_pages;		/* from alloc_contig_pages() */
 
 	unsigned long *absent;		/* taken away by MPS_SET_PRESENT */
+	unsigned long *readonly;	/* set by MPS_SET_READONLY */
 
 	struct inode *gmem_inode;
 };
@@ -83,6 +85,9 @@ static void mps_set_present(struct mps_info *info, unsigned long start,
 	mutex_lock(&info->lock);
 	if (present) {
 		bitmap_clear(info->absent, start, end - start);
+		/* Tell the users of guest_memfd that cannot fault. */
+		if (info->gmem_inode)
+			kvm_gmem_restore(info->gmem_inode, start, end - start);
 	} else {
 		bitmap_set(info->absent, start, end - start);
 		if (info->gmem_inode) {
@@ -95,6 +100,31 @@ static void mps_set_present(struct mps_info *info, unsigned long start,
 	mutex_unlock(&info->lock);
 }
 
+/*
+ * Change what get_pfn() reports for [start, end).  Making it read only takes
+ * write access away, so revoke it: the users of the guest_memfd map it again
+ * read only.  Making it writable takes nothing away, so only tell the users
+ * that cannot fault.  The pages keep their contents.
+ */
+static void mps_set_readonly(struct mps_info *info, unsigned long start,
+			     unsigned long end, bool value)
+{
+	unsigned long pfn = info->base_pfn + start;
+
+	mutex_lock(&info->lock);
+	if (value) {
+		bitmap_set(info->readonly, start, end - start);
+		if (info->gmem_inode)
+			kvm_gmem_revoke(info->gmem_inode, start, end - start,
+					&pfn);
+	} else {
+		bitmap_clear(info->readonly, start, end - start);
+		if (info->gmem_inode)
+			kvm_gmem_restore(info->gmem_inode, start, end - start);
+	}
+	mutex_unlock(&info->lock);
+}
+
 static long mps_get_stats(struct mps_info *info, void __user *uarg)
 {
 	struct mps_stats st = {};
@@ -114,11 +144,13 @@ static int mps_file_release(struct inode *inode, struct file *file)
 	if (info->cma_pages)
 		free_contig_range(info->base_pfn, info->npages);
 	bitmap_free(info->absent);
+	bitmap_free(info->readonly);
 	kfree(info);
 	return 0;
 }
 
-static long mps_file_set_present(struct mps_info *info, void __user *uarg)
+static long mps_file_set_range(struct mps_info *info, void __user *uarg,
+			       unsigned int cmd)
 {
 	struct mps_set_present sp;
 	unsigned long start, end;
@@ -129,9 +161,13 @@ static long mps_file_set_present(struct mps_info *info, void __user *uarg)
 	if (sp.value > 1 || sp.pad)
 		return -EINVAL;
 	ret = mps_range(info, sp.offset, sp.len, &start, &end);
-	if (!ret)
+	if (ret)
+		return ret;
+	if (cmd == MPS_SET_PRESENT)
 		mps_set_present(info, start, end, sp.value);
-	return ret;
+	else
+		mps_set_readonly(info, start, end, sp.value);
+	return 0;
 }
 
 static long mps_file_ioctl(struct file *file, unsigned int cmd,
@@ -144,7 +180,8 @@ static long mps_file_ioctl(struct file *file, unsigned int cmd,
 	case MPS_GET_STATS:
 		return mps_get_stats(info, uarg);
 	case MPS_SET_PRESENT:
-		return mps_file_set_present(info, uarg);
+	case MPS_SET_READONLY:
+		return mps_file_set_range(info, uarg, cmd);
 	default:
 		return -ENOTTY;
 	}
@@ -178,11 +215,28 @@ static void mps_gmem_release(void *provider)
 	fput(resource_file);
 }
 
+/* Is every bit of @bitmap in [first, first + n) equal to @value? */
+static bool mps_bits_are(unsigned long *bitmap, unsigned long first,
+			 unsigned long n, bool value)
+{
+	unsigned long end = first + n;
+
+	return (value ? find_next_zero_bit(bitmap, end, first) :
+			find_next_bit(bitmap, end, first)) >= end;
+}
+
+/*
+ * The frame behind @index, and the largest aligned block around it that is
+ * present and has the same attributes: the file's frames are contiguous.
+ * Lockless: a change is followed by kvm_gmem_revoke() or kvm_gmem_restore().
+ */
 static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 			    int *max_order, u32 *attrs)
 {
 	struct file *resource_file = provider;
 	struct mps_info *info = resource_file->private_data;
+	bool ro;
+	int order;
 
 	if (index >= info->npages)
 		return -EINVAL;
@@ -190,10 +244,22 @@ static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 	if (test_bit(index, info->absent))
 		return -EFAULT;
 
+	ro = test_bit(index, info->readonly);
 	*pfn = info->base_pfn + index;
-	if (max_order)
-		*max_order = 0;
-
+	*attrs = ro ? GUEST_MEMFD_PFN_READONLY : 0;
+
+	if (!max_order)
+		return 0;
+	for (order = PUD_ORDER; order; order--) {
+		unsigned long first = ALIGN_DOWN(index, 1UL << order);
+		unsigned long n = 1UL << order;
+
+		if (first + n <= info->npages &&
+		    mps_bits_are(info->absent, first, n, false) &&
+		    mps_bits_are(info->readonly, first, n, ro))
+			break;
+	}
+	*max_order = order;
 	return 0;
 }
 
@@ -255,9 +321,10 @@ static long mps_ctl_new_file(void __user *uarg)
 		return -ENOMEM;
 
 	info->absent = bitmap_zalloc(npages, GFP_KERNEL);
-	if (!info->absent) {
+	info->readonly = bitmap_zalloc(npages, GFP_KERNEL);
+	if (!info->absent || !info->readonly) {
 		ret = -ENOMEM;
-		goto err_free_info;
+		goto err_free_absent;
 	}
 
 	pages = alloc_contig_pages(npages, GFP_KERNEL | __GFP_ZERO,
@@ -293,7 +360,7 @@ static long mps_ctl_new_file(void __user *uarg)
 	free_contig_range(page_to_pfn(pages), npages);
 err_free_absent:
 	bitmap_free(info->absent);
-err_free_info:
+	bitmap_free(info->readonly);
 	kfree(info);
 	return ret;
 }
diff --git a/samples/kvm/mem_provider_sample.h b/samples/kvm/mem_provider_sample.h
index b9f10286cb30..57f494dc46fa 100644
--- a/samples/kvm/mem_provider_sample.h
+++ b/samples/kvm/mem_provider_sample.h
@@ -51,4 +51,13 @@ struct mps_set_present {
 #define MPS_SET_PRESENT \
 	_IOW(MPS_IOCTL_BASE, 12, struct mps_set_present)
 
+/*
+ * ioctl on a provider fd, with the same argument as MPS_SET_PRESENT: report
+ * [@offset, @offset + @len) as read only (GUEST_MEMFD_PFN_READONLY, @value 1)
+ * or writable again (@value 0).  Every mapping follows.  For tests: the
+ * sample does not really share the pages.
+ */
+#define MPS_SET_READONLY \
+	_IOW(MPS_IOCTL_BASE, 13, struct mps_set_present)
+
 #endif /* _SAMPLES_KVM_MEM_PROVIDER_SAMPLE_H */
-- 
2.47.3

