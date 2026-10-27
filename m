Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110849;
	b=aZeiAG4btTsUS+4er/kU4G7BPUhm6b+mTJxVBQU/eoQRrvRMpZeQOyseZ+hcR9h0sjVk
	 +xUzMyCiGyE5zdZHHNoJW4LJZ15T3MmqsUv2zogymKzqYcPlZeGBtIID7L4gb3GbqxiO1
	 TRS4MiwRF0+w+Urw5PTE0SvHULCSTLnXgWji7kkt9ZBePLoJ4M3S6G6IbiDt9XeHrBWgd
	 HmltYCfjNq/zvEIcSNn2TvYf3TMf4ICZvZI3iyyXFUYyA5wSRyi614ORwi8+SOK5UMPvI
	 Q1+Q0K+mTbHro7VbGEz/QOoJCeYGhQ9LBQlj2Rh8gM0vHigcCWxD8iEbmpPo9gT3PJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=WhILi3XJnHViviyKV3fwNSznxplqZWccUJ3k2M3aj98=;
	b=owAoQ0XupVrH6D/2Jlm38vtwb2G1NyGxD1B1X7kolNU7Y8/UjXy0Pv+gX8Le+r8qlV8Z
	 lIvGyud1nJnFp8xP6kVdvXegGhb+s8peR7S+yvfXnOAD3m3lb4nL3YViUSdVjZBXXt/nj
	 kUD5fGfQimflEtgXLgmXv5JgryqUiUVUFqAH+KtE06GHRHRAuJ0O5iARqvWVeFOAZw8CT
	 zhUYU6+LwA7StdMrU06+Vr4g93s/Oia8fClghNAue1yylobTXuapko3gLNTQJG5iflz4H
	 Cfgs9vTuReKbKyMF7yCREpDXH0btrhjTP1SsdO16TNw1OUxS0MrZkefeyfx4jAqqW4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="kDdlq2a/";
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DC606A31B
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8DC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kDdlq2a/
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so3917329a91.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793110848; x=1793715648; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhILi3XJnHViviyKV3fwNSznxplqZWccUJ3k2M3aj98=;
        b=kDdlq2a/3Zw1VPIghXdytTFztMeUz0XLaBEAsBwgWQ8pLGjPg2cgpHvUAceCISHnA0
         OqITu/C41FxA27qGyR43zNnMPO6d6/EoZvQB0iBKZqixLZiiZ9cDhwenJxq4527N0KEe
         99QnOkKgqCQuBn1/Myrtga7JMIn5VG1OFIDSnbnisq7bJnV3FYHCNMdrd8yVmgrP+wN/
         /t1IfhH15unUD4D7XSewwLGYYuU8011EgtQcFBrzCoYMHaLtExz3xICeEjVIFVGGkhtD
         3IPzIcTXXpQ8Zy3rIfuu4HbSXa1imE55MM2jWLL7RKGBTX+YKYfE9mpAIsZxuNn65fg7
         7nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110848; x=1793715648;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhILi3XJnHViviyKV3fwNSznxplqZWccUJ3k2M3aj98=;
        b=BXQqY79F0kJTbMERJRvEIjPpPcd6+pHrFI5Kd7zoWae/CW0x+ULye1p9ddSh9QTgAE
         cHMGvUigdmfHpVwAQGzX/XhC4Q+HpHK3Ylj1WTcM9sfpR76832A9XPFnvCIJlc0oILtQ
         sHeWIeLwBKJJobl48lFs2Bv82kwSEnY3E7IINUSBVtYrfwj/r+5tG3uIk2e9+GJzoecK
         DAxkeG/XZFQJeUUQthOd0tq/Hyx+exOIHm0WroYuNcHRr+FT3XKuumVrQT3+O2PvPkzV
         LNqzgdTOambdcbsGKqxmFp/5PBzfinKPyzwX6bikVcZ9HcwAu0vQEDcofQSQUDN1gVBG
         XXMA==
X-Gm-Message-State: AFq9FYLuaSFCAt2VF9JfVBWxng7dYRNi7f8S7eqqlmOl7d9KLXC9oSa5
	2fTbSCHZJUQm3+QWZTixqC/vLUG6sIo8T5DyCNdgaQitjadoslKfNCbULS8CtnSdiJktxKCTbx2
	UUJNNkg==
X-Received: from pjbee5.prod.google.com ([2002:a17:90a:fc45:b0:3ad:f864:f94f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d09:b0:3ac:8dfe:8ec9
 with SMTP id 98e67ed59e1d1-3adeb0fbe41mr7413149a91.47.1793110847734; Tue, 27
 Oct 2026 07:20:47 -0700 (PDT)
Date: Tue, 27 Oct 2026 07:20:47 -0700
In-Reply-To: <tencent_293D1F71F29317D2FD1758BA4419D205A606@qq.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <tencent_293D1F71F29317D2FD1758BA4419D205A606@qq.com>
Message-ID: <auCzPy_Q-h3c88iE@google.com>
Subject: Re: [PATCH] KVM: coalesced_mmio: reject zone sizes that don't fit in
 an int
From: Sean Christopherson <seanjc@google.com>
To: Hang Nan <2122295973@qq.com>
Cc: kvm@vger.kernel.org, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="us-ascii"

In the future, please use scripts/get_maintainer.pl.

On Sun, Oct 25, 2026, Hang Nan wrote:
> kvm_vm_ioctl_register_coalesced_mmio() validates @zone->pio but not
> @zone->size.  The u32 size is handed to kvm_io_bus_register_dev() as an
> "int len", so any size >= 0x80000000 silently becomes negative.
> 
> coalesced_mmio_in_range() bails out immediately for len < 0, so such a
> zone never matches its own range:
> 
>   - coalesced MMIO writes for the zone are no longer coalesced and are
>     forwarded to userspace instead;
>   - KVM_UNREGISTER_COALESCED_MMIO returns 0 but does not remove the zone,
>     because the unregister path uses coalesced_mmio_in_range() for matching
>     too, leaving the kvm_io_device permanently registered;
>   - the leaked device occupies a slot on the MMIO/PIO bus.  After
>     NR_IOBUS_DEVS - 1 (998) such zones every further
>     kvm_io_bus_register_dev() on that bus fails with -ENOSPC, including
>     ioeventfds and valid coalesced zones, effectively killing the VM's
>     device model until the VM is destroyed.
> 
> A negative len additionally breaks the sorted-interval invariant used by
> kvm_io_bus_cmp(), which computes the end of an interval as "addr + len".
> 
> ioeventfd rejects lengths outside {0, 1, 2, 4, 8}, so the same ioctl
> family cannot be abused this way; coalesced MMIO has no equivalent check.
> 
> Reject the ioctl with -EINVAL instead.  The check has never existed
> (git log -S 'INT_MAX' -- virt/kvm/coalesced_mmio.c is empty), so there is
> no Fixes: tag; this is not a regression.
> 
> Reproducer, unprivileged on /dev/kvm (x86_64, v7.3-rc):
> 
>   - KVM_CREATE_VM
>   - KVM_REGISTER_COALESCED_MMIO { addr = 0x1000, size = 0x80000000,
>                                   pio = 0 }            -> 0 (accepted)
>   - KVM_UNREGISTER_COALESCED_MMIO { same }             -> 0 (zone stays)
>   - repeat 998 times, then register a valid zone       -> -ENOSPC

Fixes: 743eeb0b01d2 ("KVM: Intelligent device lookup on I/O bus")
Cc: stable@vger.kernel.org

> Signed-off-by: Hang Nan <2122295973@qq.com>
> 
> A PoC plus the serial log from a KASAN kernel built from

LOL, the above pretty much spills the beans...

> v7.3-11778-g5b0764a53235 is available on request (it is ~150 lines of
> static C that only uses /dev/kvm).
> ---
>  virt/kvm/coalesced_mmio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 000000000000..000000000000 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -14,6 +14,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/slab.h>
>  #include <linux/kvm.h>
> +#include <linux/limits.h>
>  
>  #ifndef __KVM_NO_MMIO
>  
> @@ -130,6 +131,10 @@
>  	if (zone->pio != 1 && zone->pio != 0)
>  		return -EINVAL;
>  
> +	/* kvm_io_bus_register_dev() takes an int, don't let the u32 wrap */

Eh, I'd omit the comment, the code is self-explanatory.  And it's not just
kvm_io_bus_register_dev() that's problematic, e.g. we can't simply change that
code to take a u32, because "struct kvm_io_range" also tracks a signed int, and
I'm sure there's code spread throughout KVM that compares against signed values.

Actually, kvm_vm_ioctl_unregister_coalesced_mmio() has the same validation issue,
it just gets papered over by coalesced_mmio_in_range() thanks to commit 1a214246cbb4
("KVM: make checks stricter in coalesced_mmio_in_range()").  We should take the
opportunity to clean that up as well.

E.g. this?

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 3b5430036cae..4afa86b72cf6 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -121,13 +121,24 @@ void kvm_coalesced_mmio_free(struct kvm *kvm)
 		free_page((unsigned long)kvm->coalesced_mmio_ring);
 }
 
+static bool kvm_is_valid_io_zone(struct kvm_coalesced_mmio_zone *zone)
+{
+	if (zone->pio != 1 && zone->pio != 0)
+		return false;
+
+	if (zone->size > INT_MAX)
+		return false;
+
+	return true;
+}
+
 int kvm_vm_ioctl_register_coalesced_mmio(struct kvm *kvm,
 					 struct kvm_coalesced_mmio_zone *zone)
 {
 	int ret;
 	struct kvm_coalesced_mmio_dev *dev;
 
-	if (zone->pio != 1 && zone->pio != 0)
+	if (!kvm_is_valid_io_zone(zone))
 		return -EINVAL;
 
 	dev = kzalloc_obj(struct kvm_coalesced_mmio_dev, GFP_KERNEL_ACCOUNT);
@@ -162,7 +173,7 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 	struct kvm_coalesced_mmio_dev *dev, *tmp;
 	int r;
 
-	if (zone->pio != 1 && zone->pio != 0)
+	if (!kvm_is_valid_io_zone(zone))
 		return -EINVAL;
 
 	mutex_lock(&kvm->slots_lock);

