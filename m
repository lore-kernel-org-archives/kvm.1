Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011832;
	b=RGERwpjCW2MfyYIGxcmUEHwiwbjhWs/W4MnsewDNVRmF7s++Cafr8C8T53YkhV+ltSv3
	 yWKXWpAue7Ukl2/2pHyIbbxEJmkBqZ+TrX8MN4yUhMRHIOAmy0T/8JlbnSZV2xa7GNcqI
	 1fC5ZtN7x2P4RgxwkblexkNIdkSWcFs6agEjm72gll1ze9ukAwXHQrWTqkXX9LA9/8Bzs
	 /ahjy6Nti6dkQJ7wBoHNbTpiJ96WxDOTd8/hlf/561Bfx/4xiIOQBBa0kflYCQQS9UWTH
	 tht+Lm8IFTyx0V3CqtfnRXrZj0ygYO0wd+HKHMa/zuY0QCglCUE1Zmgfu/bDpDqSY3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011832;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S1VeQt4eeGIXDkcfneZT3UM35I4Mo6EWsujW5a+4lpA=;
	b=MrWfV6y5vrdQ20bRNJ9CL0z8UHuOTOyY+b2QeLVMdToi4QwmzFW1vrIMls+hjESKa8MY
	 knyzU89BaaEsKYAsHjC1qWm/lKlauVe02CFkVr+1oqRolkJptrUmyXqJiaRiZbitBYdWo
	 ++RVgdmHEBupQ9gAkar/2udUlhwg2nMUxop+LBKcIeCWKNcsSB0WhuslWnw6maexeSull
	 L0DsXKN30JcIhDSOTaJJGp9QKjehnkhkgY5swk2CS5KQ/4sBf3/XMOPpynzPH1V1CZV15
	 PZDxIUEs4mnOcVtUgRtDLORSv1yWj+kYTtTxEY5h5KwZIOmDDKae/PLQCdZkf6vO9MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSImQPJL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC2606D82A;
	Sat,  7 Nov 2026 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSImQPJL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011831;
	b=nlK8gBR7K2hvsAwNnVXGVAPDl/sTzzIGYraJ03hS3G/32/N8X1Yuk7wHvEAAJqEMZ2l2
	 xFXnEcjoZKNsnnf6idKtzrdiHxa72oU7d78oCQwNHwu/tGsdAtTcddLeJT938PqFmXQ95
	 Mm0GGK5zt2ziq+TOsZkEhBWOOrGwswKL1ISwZCZZtqVD79Dtxqx8LfYOfYn7SnuWCdk0G
	 IpK25VdJFdYYsmkjWVulvzYQHuahKEe5kY1UebO0x/z7Wus4yboqfQg+y/xnkXk/O9ZG4
	 nL4OkKy3Z2NWlQypYqvA6pUA+ft7tYVxF0AhBTtaPqxohOHxwSMHv+HmHKthPMSwnNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011831;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S1VeQt4eeGIXDkcfneZT3UM35I4Mo6EWsujW5a+4lpA=;
	b=HNioULsevLhci2bx6v/QOTtiDg0YAgmlQRTHuF7X2wbsShQ03MWl0nfXKuF4MqIc8rrB
	 PizRwKXTnSWyPGdvQJlp1zXvd08jNOAXkGtjfI5Ne4FlbuDfanv7vH4pGBxtYKXNe+Klm
	 39FmsXAnbLkO5ZICNcSaFTUSyLqy3XntMLvyc6LapLCbTxvyKhwc5OH2QODwWiMP06vp6
	 VqfBM3iwW8ivoxwj2iGz2NWXI0Z0KV9ved5jzOudkNJz1ZmW+GjWquX91KWiZEE5j0VYH
	 XVEHdGIY2qDzwIuvQ9h2O9Z+XMW8/PE8OqTFxry87V9utaUfKV+OvdgkiVnCsgVsSZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 852E21F00AD1;
	Sat,  7 Nov 2026 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011831;
	bh=S1VeQt4eeGIXDkcfneZT3UM35I4Mo6EWsujW5a+4lpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YSImQPJLVctRWA9uk5of//u47z47vnJGGof9RAJmUHprZd7MtBhM1UoJJcxaNIgl2
	 3uvZXMb/uXKQi2nJEjG/2CdcyUhmZdsX0Pdg/n5VeqIerV6nzcxyZGh3Lg4uhb9edA
	 58c2ZGuQfhbjwWPxCf9UV01NdeDeNgZDfOPPJbFnhtYsnPAY1G8N6EhsGjQDEfZDFg
	 qIi/JMELX8Pb1QwUv5xWiKf5HX13Tsv7IQTejgLNyQHjtaIuwUC6h2j4pxTudSU57Q
	 iOvjJejWhDhjBfD7B1zrBXVcI9OTWwtMlUyGoQgdogE2CE5zN6ZCrOFZGeGNOcjNXl
	 L0Lit6heGxopA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 45B68479D2;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:23 -0800
Subject: [PATCH RFC v3 49/88] samples/kvm: Implement lookup_pfn_range
 provider operation
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
Message-Id: <20261106-gmem-alternative-providers-v3-49-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=1753;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zF6/NHZXYKv9L/HYCXHQCrJDAKRuC7sUwZ4mNyf3Ilw=;
 b=ahCkSRHzo9omVJZMhhE6rfmRR1w5YCbKaLV2veN+koHtwyTZEPMuUJDWA4vp4xnnxkooZ1qco
 erjm1pX+7bACC1WV18Q1Je2NRoYM1uyGK8yLYYA8TUwGIp3C8gOY06l
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement .lookup_pfn_range to allow looking up index -> pfn mappings to
satisfy guest_memfd requirements and make this sample memory provider a
valid PFN mode provider.

This sample memory provider performs allocations upfront, so
.lookup_pfn_range doesn't do any allocations anyway and is only slightly
different from .get_pfn.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/memory_provider.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index 926f3cf68ed49..7fb7365b65940 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -249,10 +249,34 @@ static int mp_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 	return 0;
 }
 
+static int mp_gmem_lookup_pfn_range(void *provider, pgoff_t index,
+				     unsigned long *pfn, size_t *nr_pages)
+{
+	struct file *resource_file = provider;
+	struct mp_info *info = resource_file->private_data;
+
+	if (index >= info->npages)
+		return -EINVAL;
+
+	if (test_bit(index, info->absent)) {
+		unsigned long next_present;
+
+		next_present = find_next_zero_bit(info->absent, info->npages,
+						  index + 1);
+		*nr_pages = next_present - index;
+		return -ENOENT;
+	}
+
+	*pfn = info->base_pfn + index;
+	*nr_pages = find_next_bit(info->absent, info->npages, index + 1) - index;
+	return 0;
+}
+
 static const struct guest_memfd_provider_operations mp_gmem_provider_ops = {
 	.attach		= mp_gmem_attach,
 	.release	= mp_gmem_release,
 	.get_pfn	= mp_gmem_get_pfn,
+	.lookup_pfn_range = mp_gmem_lookup_pfn_range,
 	.put_pfn_range	= mp_gmem_put_pfn_range,
 };
 

-- 
2.56.0.455.g6c5a503b38-goog


