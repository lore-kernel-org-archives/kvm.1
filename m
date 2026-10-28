Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152803;
	b=fafQ1/XCXuxtDhloysBfcGUQmp0lnDVmXe7iLQcjJT2xZpq8UUaC+5Ns1QKh0tIVfioR
	 dzA4S5S9GjQEC4XhEgulNfd9OOmpdLQnEy+dCr1eQ/Yhpve0Y4isH05O0BOrapanUYa5D
	 HIHRHbjP17KETZWS03aPyvwZyI19H/Fv1qVRvKHY6ZjyB4Zbb6vHWYtDq9zGyw8I/hp/0
	 kif519bI0HQq/Nkxt+8X1ULm7Aa/x96po8CYZG5sx4+ukVAf+Pkf3iENC4kBYjv4g720r
	 Kyl8L/1e6gY6V4JcQspcXUBGIMo1zvqEsK7sYcd6qQhfdbtmXVz/oHsULx8RZ05/dxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152803;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OqTguHw/2H6yU31W8+OM9YESt2jiE6Km/mtjIrXZoEg=;
	b=lZRFqd1uq8fxmpPCxh6ymkRb+3yqZ9go6Zk8Me2STNAjGxliVwdZc+vNUD8Kv08aCZRx
	 85lAO/qyqaLNf0INSYCdwct2xyFzbHMP/T+B+dyrqZooHhB6Nk7Dvdr0yTk5oLWXqBuYh
	 vor5vpBHgjrmSUzgnNOglciY9RZsLz4bIavChZaaG1a2wRmnoNsSd3yC7mW3t+cNOZtgh
	 +an3RhXLiS/uYJCgwBJzAB3ZumyFCKZp3Mum5xUvWG9WyL7dz4loadczxrm0j5tsI8CDt
	 V8+WZRlrdoFsTnN+ki0hxw+wXxL9uw2G72XyJ6msY3lWnD5bMCs4vFaHx/XYw0wV1cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IykLTgF0;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C89606A31A;
	Wed, 28 Oct 2026 02:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C89606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IykLTgF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793152799; bh=OqTguHw/2H6yU31W8+OM9YESt2jiE6Km/mtjIrXZoEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IykLTgF0alAoqQeHDVHR4AucD1wKIa6H3X1jvarG44/6/pv1Mb9WywG2cDNrr1qbc
	 JRXLgnJA135nSlDSU1uApCrq/uQMG8OOPUv7ciVkDXxXB098T27cbnmCaFjrRn2EYI
	 tI7m4dSL4kXkeLWI1MkCM2aFBsLHwJIOPipSHcoI=
Received: from [127.0.0.1] ([2409:8d5c:c30:3b3:1100:5cd8:d3a9:fd5d])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id EF98A233; Wed, 28 Oct 2026 09:59:57 +0800
X-QQ-mid: xmsmtpt1793152797tjj7kw3q2
Message-ID: <tencent_6EE8901CBE1ED363CBBA2E8CEC6D88D19F09@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPnb5/8XQSBhO9yatlQ1tZ8C8poYmggx6zKh5pBHgfsMKFfaesJc
	 JrVqPsAKaJ3vvnPvufkmkchAXyBxZPsag261rrFD/Apn8vriVoeAoulxWH7PlfQ8bUNSAG8tYAgm
	 poyxk6CXQKCYPqlyBKJxlsGGfG73dBDZIjlOWfPQpZ/moHFx+HlIiq3gORicxOAyny+pVnRQtHzm
	 oUh2yIh4APO5wplDyTE+nTp/UDqHQfqYM4rLQnxidsdQU2DTn2+62295+JD3zUGFbbLcGoPyZ3Nm
	 747HISlWPUWJoNRyKnoTFT8dPL+SsUyXS+3kTqiWkWin2nWBN0fJBVuUE3Y1eamZNZ+9adsXjU/t
	 MPJd3xzhKSEQoDtMqG0oAbu+BR2jXbayE+H6XwmZOjvskcSTeWYRwPm93uAPKV6IjG1burNhH3Xe
	 YjOr6fme5wf1Z0x8hpvTyjCn5yOvhgDCRTizE+kJg53KWk9V7iU31makgDmIGCJzcODBh4wZfJbQ
	 Bkvnm5i83cuJblQX1VL6JVxwbCTS6UhQtvv1xeEL4ZnGu/7WmXhFxsO1FtkKA2AxDAC4d0h4tDQa
	 SuKzfuZq1dtrFi0BdJg8Nec2wEgIIbgr0fFpOuTajM//EULcsqbqCjGwGnK0vJ34HRR36rEzJ+Zi
	 T7Blt5eYIcI3ty3lq5z+xQnbZ3qF2OHXhH5KMQYdgkvZjURZG4QG9Xo4niOIKlikB0jJ6/1Z1FTe
	 NYK0ueOI4mSjb7sapx9Pmo4FklO2I1tanqoxoD+S6cZAttNDfTN0QAbGupM/dlBktRrEVV8i7JJU
	 rmfozPBx5Z5qOV5/+pyQe2Kojna8YYYTNl1U7D/FyVzJtmx9rC5ukPP2qmVHI7sOLLZUizqqwnaH
	 hXT9huFq/aFlqIKgsY/lLc6c/f0jXOI8m4P+kNQsTHR2xCrXMYuLVHWEd2M636UCNTZDKPqSMspd
	 3Ple3T/zaV+Mm42Yc+h9gGCtiTWEJzkFyMgH1t7fHfA5n4qoqdztJuMPkfbz35Ho95ZxLIVzZkK8
	 Co6TmDPM7E43vm8Owt7juIDhAFtLGxwge6D8Pr9hVaTPgvaEdR81I+b/03fGoeqdlrMqqOZg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hang Nan <2122295973@qq.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Carlos Llamas <cmllamas@google.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: coalesced_mmio: reject zone sizes that don't fit in an int
Date: Wed, 28 Oct 2026 09:59:56 +0800
X-OQ-MSGID: <1793152796.776305.v2@qq.com>
In-Reply-To: <1792859391.770388.v1@qq.com>
References: <1792859391.770388.v1@qq.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kvm_vm_ioctl_register_coalesced_mmio() validates @zone->pio but not
@zone->size.  The u32 size is handed to kvm_io_bus_register_dev() as an
"int len", so any size >= 0x80000000 silently becomes negative.

coalesced_mmio_in_range() bails out immediately for len < 0, so such a
zone never matches its own range:

  - coalesced MMIO writes for the zone are no longer coalesced and are
    forwarded to userspace instead;
  - KVM_UNREGISTER_COALESCED_MMIO returns 0 but does not remove the zone,
    because the unregister path uses coalesced_mmio_in_range() for matching
    too, leaving the kvm_io_device permanently registered;
  - the leaked device occupies a slot on the MMIO/PIO bus.  After
    NR_IOBUS_DEVS - 1 (998) such zones every further
    kvm_io_bus_register_dev() on that bus fails with -ENOSPC, including
    ioeventfds and valid coalesced zones, effectively killing the VM's
    device model until the VM is destroyed.

A negative len additionally breaks the sorted-interval invariant used by
kvm_io_bus_cmp(), which computes the end of an interval as "addr + len".

ioeventfd rejects lengths outside {0, 1, 2, 4, 8}, so the same ioctl
family cannot be abused this way; coalesced MMIO has no equivalent check.

Validate the zone in kvm_vm_ioctl_unregister_coalesced_mmio() as well: it
has the same gap today and is only saved by coalesced_mmio_in_range()
rejecting negative lengths (commit 1a214246cbb4).  Factor both checks into
kvm_is_valid_io_zone() and reject with -EINVAL.

Note that this makes KVM_UNREGISTER_COALESCED_MMIO return -EINVAL for a
zone that could never have been registered, instead of the old "0 but the
zone stays" behaviour.  QEMU never registers a zone larger than the
coalesced ring window, so no in-tree user is affected.

Fixes: 743eeb0b01d2 ("KVM: Intelligent device lookup on I/O bus")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
v2:
 - recipients taken from scripts/get_maintainer.pl (Paolo and the list in To:,
   you and Carlos in Cc:), sorry about that
 - dropped the comment
 - folded the validation into kvm_is_valid_io_zone() and used it from
   kvm_vm_ioctl_unregister_coalesced_mmio() as well

On the unregister side: agreed, it only survives today because
coalesced_mmio_in_range() rejects negative lengths (1a214246cbb4).  Validating
there does change the return value for a zone that can no longer be registered
at all, from 0 to -EINVAL, so I called it out in the changelog -- it is an
ABI-visible difference for anyone who relied on the old behaviour.

Verified before and after the patch on v7.3-11778-g5b0764a53235, same .config,
unprivileged /dev/kvm, same initrd:

  before: REGISTER {addr=0x1000, size=0x80000000}          -> 0
          UNREGISTER {same}                                -> 0 (zone stays)
          998 bad zones accepted, then
          REGISTER {addr=0x900000, size=0x1000}            -> -ENOSPC
  after:  REGISTER {addr=0x1000, size=0x80000000}          -> -EINVAL
          UNREGISTER {same}                                -> -EINVAL
          1200 attempts, 0 accepted
          REGISTER {addr=0x900000, size=0x1000}            -> 0
          UNREGISTER {same}                                -> 0

The reproducer is ~150 lines of static C that only opens /dev/kvm; happy to
post it if it is useful.

Hang


virt/kvm/coalesced_mmio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

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

