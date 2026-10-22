Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711705;
	b=S+PKTY0h3206Hr2eOB3ha7xLsQnXwAK2PePW30FQoyE77LAUGfcGJt91SgUn5BTANzV4
	 DZWesvN5R8vkc0R5KwVWH6x40vyex97CBr9frrRo0aC6+tqsMmpA6fQJZ06wNEo7ASG7v
	 CZBa6Xx462vq7U4ZKqONyjP9TpPdzqaXyzVRHpyo0+VQ6JzVZGNSobtGd5t9IjJi0JwGb
	 saTrHRXg1kZSAT0OCYU+mNm4FEQVZRzafH85T/NlV2VJgCgUML2SYFl4qEnCsfkO2Wj64
	 R3z0W1hqVGVIa9AZj/qWyoKyly1soBZrXm0KrB6t3Aah5gpn0zrrd+7q2ZDij8vgdiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711705;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GSyw6Ljics0B0SjVoVtEY0jzr9tQ8ltn7Ym8k/iOA0U=;
	b=ANAB5patTfKntdzS9K9NERvcS93jqQ82MpabsI4PVICqvms/wQhBneVoGRF29+d71S53
	 M7Pa0nRmdfctblgdTHFJCCpXA8wDV0wsi0IHwLB+EzjzQrCb3ipn85vMgczBruGDSVhJZ
	 dH/K268GHfPWHfcYY+PNPY51uMoz73IOPYopJbviCQKq13xv6JeDHO51RlTuOS6ailz/8
	 nmZ+H88BIcUM8gI3yIhwVIrwbJv8j1oQGdYMDD8VQuDPH2QqwdunEyaCcSe6pHA2tHJAs
	 yl2T9rqqKMI4wkO1Sdc3pUS8N3WiMEcDY3zxAS6eGoeEN8XlZ8Ig/6PRR4cavIuZvxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFJYFEm9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F16073FD7;
	Thu, 22 Oct 2026 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFJYFEm9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711705;
	b=X9ixk91bXKFYRmardpY49+nfd4BKvfg2Pd/G+kBE5kqIEvUgPlk13M/UsoEl5gI2A0jo
	 yIAz1zbDFZE25o2dvC95O9ns7EPbS/CZhUWgjly2TVniFZrnpFhd23dgBBjlnKOmPmiUE
	 paagw2b19eab3EEDreUaA4yd3clW2WOgAHLKmdrcvTHyvCM87lehF8JJuCxcnAk//9+rM
	 2YOt8R9/rhjlsKOB0qi4emN7VB+OEARHVjOp2/KtVKcXGG+QTJz01UuYQBum8i1kD95Er
	 RddLGHed74sOjLF829mfbBG4bj+pw/Qks0hxQSO1dyk2UntS5xRfOhKrgDeZ0uejkgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GSyw6Ljics0B0SjVoVtEY0jzr9tQ8ltn7Ym8k/iOA0U=;
	b=0y5u8C6lAc1ovphGEpOzYStrbT+SFL7KVRZadS8myc+pxvUrLiKtHHAu66figpIlZZq2
	 PO8qBmTf4wguC7/ScNiyPtJ9VS3VbPmkXo0PeGXSSry2H+zL62c741wQcM3dk/61bp/j7
	 hMncaBDQQnpcaKWnxZSCDoJTeOvFnYbUskAQHSRiZVvhEv+lVIn2vtcEsHWF1CWOlMChU
	 MocuX/3XaFx/D0FuL87/w92Gs0fYKN6O0MfTPacoD6i8Pob13FI5lGMoKylCqn56TaBHC
	 tZ67U4poQUzZaUmg3pPAb3akK+gi+XKA8ahI/67n8H2EIkKcAHo3FHYQtjD6bCwffSQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 853E31F011BF;
	Thu, 22 Oct 2026 23:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711705;
	bh=GSyw6Ljics0B0SjVoVtEY0jzr9tQ8ltn7Ym8k/iOA0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gFJYFEm94cycUDvhjQs84BUNbfD12od55Y9D9SwbKwwrcJONMi/Et+yVvxxbwYWNf
	 nl+1iDhlPGLpD3YbiF3rpCV+KjJU1YFOZxMC31fR3LzlUHbKz/8hK1S18s2BF3vlVf
	 XubnMuC5E3T5MbZdJxR9TNFTgUPHuWpPQnvJdHXl/i/FBaWKiXy6y8KytAwkYsN/Ht
	 anQuVCixaHdCS5ujPhRcRrKG5lQ2Ztbt4Xn2lVC+rvrYy3RoSWoIhDNufjrs4IrsfW
	 t8hNPnL0iAjxhZBBlsGveZaC86+YhHaPDhum+CRxmkfmHnayLsPRhewq0VmJg8WZdO
	 MJ9s2pfctyZiw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6D494420F7;
	Thu, 22 Oct 2026 23:27:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:17 -0700
Subject: [PATCH RFC v2 45/50] samples/kvm: Implement attach and release
 provider ops in sample provider
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
Message-Id: <20261022-gmem-alternative-providers-v2-45-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1898;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=KGuPGvRWcbKGcEsNC27FbqmF987N6l1g/xr1+ZAzxc4=;
 b=Z8JHLu6Ste4p8ZrYRqK06GDhAVo48QV4XZ+VWzhKHyf7aaqsyXhbrwWLtjaRHzGTMt3dr8qvY
 4A+I9EpN32UAecHoaXDspE+Lg0dT9WcHVIl7AcXBRh4n+ovXjEly61w
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement the guest_memfd provider operations in the sample memory
provider module, providing .attach and .release callbacks.

In .attach, take a reference to the provider file (get_file) to keep the
provider context alive while attached. In .release, release the file
reference via fput.

Attach the provider operations to mps_file_fops.gmem_provider_ops so that
provider file descriptors created by the sample module can be passed as
resource_fd to guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/mem_provider_sample.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index 397ebb3773f39..d9e57484c3933 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -17,6 +17,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/guest_memfd.h>
 #include <linux/io.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -118,11 +119,30 @@ static long mps_file_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static void *mps_gmem_attach(struct inode *gmem_inode,
+			     struct file *resource_file)
+{
+	return get_file(resource_file);
+}
+
+static void mps_gmem_release(void *provider)
+{
+	struct file *resource_file = provider;
+
+	fput(resource_file);
+}
+
+static const struct guest_memfd_provider_operations mps_gmem_provider_ops = {
+	.attach		= mps_gmem_attach,
+	.release	= mps_gmem_release,
+};
+
 static const struct file_operations mps_file_fops = {
 	.owner		= THIS_MODULE,
 	.release	= mps_file_release,
 	.unlocked_ioctl	= mps_file_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.gmem_provider_ops = &mps_gmem_provider_ops,
 };
 
 static long mps_ctl_new_file(void __user *uarg)

-- 
2.56.0.257.gf7497c7d27-goog


