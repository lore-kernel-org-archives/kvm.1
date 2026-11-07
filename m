Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794011835;
	b=n+Tly5dO2/BI/VZ7NutHehLIJ75Df8kWer2q9p/IhW6lhcFwU0/CyoEiwelwoIoQ5opD
	 8Vt0UBtf77H0qPDNtZtu8bW06nsBF4MjqoflQT4iPRdHS3eJwih1Y0A1eTPmWlOaP/O0K
	 sg+oym6NLUsDIzp5dPRSln+pY+IezlrGOGWhW5ZTwmZ1uYQpZ1BaTrP3YiMmF5jFgYxkA
	 3HF7xtNYFcNsME9QTDQYGatDLtGPDrIut4+hHvjqjjwLavIyIw672TadnSGiuNe49SPXW
	 uDz5njuodd58Hh35b2dcN7DvfR20dvPU2gQDghB0rd1pOAw1PemQ6anPjDhTcVky6Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011835;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=1pCSunxlZGtDuCXdYB75wFXTfLNCc/lfSGqnGUAN2tc=;
	b=Z2iDCeKoesGqaHh+V2IbWzmt+3n3XL7w2sBJwT1c73dqbaaAI3isn70bgctAAvwi4LzD
	 w+iVtvVSjvMuATDI0aMUoWwtX1k2WbpI0DtWnTo1crCi1IDrb80nJ4jtZ/mQzRlOhwT7N
	 vpzzOIkgonqAWnitjecGzhF8AbTO0KRmD57zgikxWfTc8iog6aPP9lbnrp8VfuedTj3L7
	 DZSXTL5fwxLCNxTWLN2RzXRIyp/LBz4jcLcBXftCusGFamgmSOxS32r7LrnruDVWAQ50Y
	 /EJ8t0pre/Fos1kHFXzHNeHgrBtx3RjxJFWVhuF2c2wRRGZhN3VqSEpj+DqfyDwFbZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpHWLxJK;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73960A382F;
	Sat,  7 Nov 2026 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpHWLxJK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011830;
	b=ZkBb4o1iDukY5E+BLQHTMaXApti41QAnALP36KbWvjpybrv2F0C8GmhS5XPWhJbsZqDw
	 JG419A4C2Jwl6Fn8C72BAcOzHyOZxL+k07rvae/sS79kc79T3O5FAf1yVe7CkII0r2Nhx
	 vaNuMs1n7SB7X5jNT77ErApOPzRUVNv9gyUfylJXUcnO5Fth5cr0xpW1i+F7nymzLLOQn
	 tq4BPqwhZNs8yKuK+LNyYGKVKH26dglKHY5F9BhCkfIAH7NzeQzmUfX+6GBXIStlyk/+k
	 OQO+o/36JHzV3KDBDNgIE3TAi6itva/YTRBYVISlrS/9m4ILgMNy/BBcPp29sxOqAvQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011830;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=1pCSunxlZGtDuCXdYB75wFXTfLNCc/lfSGqnGUAN2tc=;
	b=O6uZcIEiTTqBcu3V56RgohfosHZBNWytQs/76vOiSga+Pmqm6CzBqnrUqGBssA9RT9/y
	 uIlFjuHDJziHxkiuNjBF4OI0RQ/cAzEAI165Nq6qzT+fEBjsVOethtNxXEiHUtFFOswGH
	 +Qxktc1A5V41tTiIV8dSkMHJX+QjWpMv7E4UTZOXb3FOsf8ALxJ2OZdz3A53ZR2atbMTI
	 rSY5EuK8YOgGLP0xw0dLPqNfBt9cxALhs8zR3mgY0qFmTWByuO1dKubE1tx+MH9MCCkUN
	 lNoDfBHHoLcnFC6i8IJ1JDbvLSxjMmpvUK7AicllpnaalxGGCeZLFL/SiKVq1CyJrRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F3E31F00921;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011830;
	bh=1pCSunxlZGtDuCXdYB75wFXTfLNCc/lfSGqnGUAN2tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cpHWLxJKy3/cLvXieHb1nlxWpIcSIVE/RG/jpbZfdbKA4m6D8tG5NnR7LegC64l5k
	 M7m2yZiHxEptu6las5yte/dyHT2buTNqQq8E99sj6BvOLhNr8RvlyA3dRm5STLaIxG
	 xq0ayOTVP4CSeokCFeOAvOKNrrK/Do9BRDpkWbQJTR8iFHyaHfIw8i1uCipQjS/2GN
	 jY47jPMVn06obn3D3ad4RQ0uHCYpWKz4ol2gKzwq69f5Cj+e0twjEwH+fbuHQuGNI6
	 xO08LDIXC8TdBQvEc5MKXc7yDdnLqd6NDz4RydL46VTHirnNTLXhb0YSeHp/w5IFQP
	 B57q4j8XVad+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 55EDF47963;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:54 -0800
Subject: [PATCH RFC v3 20/88] samples/kvm: Introduce memory provider module
 skeleton
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
Message-Id: <20261106-gmem-alternative-providers-v3-20-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=3200;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=nt2cs3RpI5IUFgJs4dsgiWZl0HfyGKiOhLkBsycGpfo=;
 b=4cdyeAJ7HccYK8NGv9Q29bFTAR/IcMhIOFe8+7RU78D738bkU/WshB9UbwT/KAILWqam4ykOd
 CO6Tw3GiatGC9mriP8x0CMuJxG1AZn5inkS4uDdxzwnFtZL/sbetXox
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Fred Griffoul <fgriffo@amazon.co.uk>

Introduce the memory provider sample module skeleton under samples/kvm/.

The memory provider module will serve as a sample in-tree memory provider
for guest_memfd and iommufd. Register a miscdevice at /dev/memory_provider
upon module initialization and deregister it upon module exit.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/Kconfig               | 11 +++++++++++
 samples/Makefile              |  1 +
 samples/kvm/Makefile          |  2 ++
 samples/kvm/memory_provider.c | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330da..d4e79e1a9286b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -326,6 +326,17 @@ source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
 
+config SAMPLE_KVM_MEMORY_PROVIDER
+	tristate "Build sample memory provider -- loadable module only"
+	depends on CONTIG_ALLOC && X86_64 && m
+	help
+	  This builds a sample memory provider.
+	  Its files can back a guest_memfd and be mapped by iommufd.
+	  It allocates a contiguous region with alloc_contig_pages()
+	  and carves out child provider files on the fly.
+
+	  If unsure, say N.
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8b..3933ef6a323ed 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SAMPLE_TPS6594_PFSM)	+= pfsm/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
+obj-$(CONFIG_SAMPLE_KVM_MEMORY_PROVIDER)	+= kvm/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
diff --git a/samples/kvm/Makefile b/samples/kvm/Makefile
new file mode 100644
index 0000000000000..9668dc57aa458
--- /dev/null
+++ b/samples/kvm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SAMPLE_KVM_MEMORY_PROVIDER) += memory_provider.o
diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
new file mode 100644
index 0000000000000..d5272cb88b758
--- /dev/null
+++ b/samples/kvm/memory_provider.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * memory_provider - a sample memory provider.
+ *
+ * Confidential VMs are not supported.
+ */
+
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+
+static const struct file_operations mp_ctl_fops = {
+	.owner		= THIS_MODULE,
+};
+
+static struct miscdevice mp_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "memory_provider",
+	.fops	= &mp_ctl_fops,
+};
+
+static int __init mp_init(void)
+{
+	return misc_register(&mp_dev);
+}
+module_init(mp_init);
+
+static void __exit mp_exit(void)
+{
+	misc_deregister(&mp_dev);
+}
+module_exit(mp_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Sample memory provider for guest_memfd and iommufd");

-- 
2.56.0.455.g6c5a503b38-goog


