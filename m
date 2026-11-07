Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011831;
	b=aL8TdAzMKDS+Y3B6zYKFjyxzYlE5PlqwPppMPvHkF1gNigsZNBbbWTKZsdrRPeTSL7sE
	 az5xPAcDoWULlDh34QgRPEFR0IZ7hOZ8Ru9tKaEuxmhnDhkpeVtir9o4/qXy7encvshF3
	 L5BNBFJQ/dEfyAdryUuGJDkwocYsXBFe4U304C6wTEOXU55UDebKyQe8tkut+nG+syqCc
	 i36IxuRA0PHx4p7RzsE3rzNi9YySdBvahQnZGLxHY87y/7PaaEF5YxfRyO7J5aqR3Nio1
	 Ltm9ertTBqYp4Ms77X9vF3LqdCEdrN6NykUx24R94JMTTagHt3lMhR5vwcHic9Pc/pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011831;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3GnmpH7dsegBwAqwdCVeM7wi/vP60xMNTkwELMScKI4=;
	b=mWVM8i6TcfTOf0mVT7D630tZ/ijTruTXsXF4QZeDsCI+aSwdxrdDSMGCDDWLZpECg6ay
	 +29kDoX0RgxTlW7Wk9kxtSA4+r3yYg6f74FMNzDoLvRWM9kHSAKz7lCDK1BcY0knRqSbw
	 yNGqCGWYrRokUgO5lAOfNTqnkce4/gy2f1LmQLJH9A12fB2N7jQbKNHnE7fXoK2od/B/C
	 7ywF3tmIW+mkTG3VyyBi54B9g8uLAdix5qnrX6LJRs3qAHkwK7bDKMe0PXV+3J9IpbaSc
	 rB4WPt9MhRAEi3DuUdEjAyTn0LSsgc5XIhg7J6HXh0/qqV8pW2TMblrbjREWDqmQWog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMhP82yy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFA60A383F;
	Sat,  7 Nov 2026 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMhP82yy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011830;
	b=iRwjCTMB2xPEsm10Ult5vAL/NYGPDVXYJGfMOInsWQhTTGWOjue9Txh7c4x7SURVzzLF
	 fphrSezG0ZX9YY0wsXFYbgKj5PmEB9b6rkuJFtcolB5VwwsvwoODNT6i+DdfXd2QRk6Ha
	 /hMJdHD/waio8CFNigCgPw00ggOKhQ4Bxg3ld3duDD/QN4/i6oTz/MXzbZFGk0Nj+kICc
	 E1WTwEEBd4+JDhmqECA0+2EtSBfeF0hOOr0Oa7flGt31OvmiatHQiN1SAhZYhCR3NdErD
	 eriDhqEYzKOhlarJJVn/OgvKr9uPMyAR5pbpjE+kBlSclJ0IDl/uUt72AVBivgcVg/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011830;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3GnmpH7dsegBwAqwdCVeM7wi/vP60xMNTkwELMScKI4=;
	b=JoqKwrnf1UWuwpUBAKVhVQDUPFjoGw5FG1GVTfMg7/PK1EtR60UOKw6JnSAP/lNKRVn4
	 0UqSPleQuXm55X0f5JdIZTWtrVMMiKEcbI54rHDUWnPVIAB4rIhl48NfEyD0M/+FCGV9p
	 UHWBHJFtk9NQkgZhLQ4iXaCqFjiDI5YR2tcqq+93xOTM6cS2VCcGxbzBxb/lEbeSXO6YF
	 yKSLxwXIqrlcah5TYlfUYGpvyOVGGEfQEjQY+ygmU5cuoFWchHjz7rH2Q2qWCrggn+8im
	 nvJp5dfqA85OAAKEcrgc2vBUF/uZAFdXnPHzDwREr+U/hUZKEpKAIFZiRYNsbRS+F8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ED7F01F00AD2;
	Sat,  7 Nov 2026 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011830;
	bh=3GnmpH7dsegBwAqwdCVeM7wi/vP60xMNTkwELMScKI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nMhP82yyFkz5GzVdaCsbtel2d/04RF/m8GXflbi8q4zs3xPDZd39sECI0f/vrEZC7
	 2W+fXe7iSCC6ebG9vp6D+MpIvb9UasyH2ZJCnFZOLYDJsNXdio7OOVAN94gts9MzA6
	 TD9xBL2nXmZPXrmnLF+6eJLieIipRspCGQ0Xdy742y9Trl4U7HUlI/ancwOB9TmVKO
	 2lL3Py0MhRC1pzEBqB3C3mMrOTHcm2ET6N+mWHMVE18ZgeaZ9D17t1LI3Kh47qk8vj
	 JDTHdXxXBQk2d3r8kSOjkWEnfGgBBPCiL2j5nbQddOHWJqaGt2crCALGPPWPin9j9y
	 0QBRnFu+qWM8w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 15924479C7;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:20 -0800
Subject: [PATCH RFC v3 46/88] samples/kvm: Implement get_pfn provider
 operation
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
Message-Id: <20261106-gmem-alternative-providers-v3-46-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2542;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=tCKXiyHtpuefvmYVDpsKn5DHw0pcR3E0UpVIb8EHbec=;
 b=XcS77Ehs2dDxmkzR+K+/PQQXHnS5i/ylsKXkNTcKFJYWNqfe/67XQ4asLhBTtPVhKbokfrsMk
 9fTuOHWRmeiB9cV4r08Y2XGxaZrDeKXDmooUisiB2STC9cUFglVZQI2
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement the .get_pfn callback in mp_gmem_provider_ops to operate as a
direct PFN provider for guest_memfd.

Implementing .get_pfn satisfies guest_memfd's provider operations
requirement, enabling memory_provider files to be attached as
resource_fd memory providers for guest_memfd.

In mp_gmem_get_pfn(), return the physical frame number corresponding to
the requested index from the CMA reservation, returning -EFAULT if the
page was marked absent via MP_SET_PRESENT. Also report
GUEST_MEMFD_PFN_ATTRS_READONLY in pfn_attrs if the page was marked
read-only via MP_SET_READONLY.

Checking test_bit(index, info->absent) and info->read_only is done
locklessly without holding info->lock:
- test_bit() is an atomic memory read.
- Locklessness prevents lock inversion and deadlocks. In guest_memfd,
  the guest page fault path (kvm_gmem_get_pfn()) holds
  filemap_invalidate_lock_shared while calling .get_pfn(). Avoiding
  info->lock in .get_pfn() ensures no lock inversions exist between
  filemap_invalidate_lock and info->lock.
- Similarly, while kvm_gmem_revoke() now takes an explicit pfn and avoids
  calling back into .get_pfn(), avoiding info->lock in .get_pfn() keeps
  the lookup path completely lock-free and robust.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/memory_provider.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index 168c1d90edacd..1db69a8f58758 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -198,9 +198,34 @@ static void mp_gmem_release(void *provider)
 	fput(resource_file);
 }
 
+static int mp_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
+			   int *max_order, u64 *pfn_attrs)
+{
+	struct file *resource_file = provider;
+	struct mp_info *info = resource_file->private_data;
+
+	if (index >= info->npages)
+		return -EINVAL;
+
+	if (test_bit(index, info->absent))
+		return -EFAULT;
+
+	*pfn = info->base_pfn + index;
+	if (max_order)
+		*max_order = 0;
+	if (pfn_attrs) {
+		*pfn_attrs = 0;
+		if (test_bit(index, info->readonly))
+			*pfn_attrs |= GUEST_MEMFD_PFN_ATTRS_READONLY;
+	}
+
+	return 0;
+}
+
 static const struct guest_memfd_provider_operations mp_gmem_provider_ops = {
 	.attach		= mp_gmem_attach,
 	.release	= mp_gmem_release,
+	.get_pfn	= mp_gmem_get_pfn,
 };
 
 static const struct file_operations mp_file_fops = {

-- 
2.56.0.455.g6c5a503b38-goog


