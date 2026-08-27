Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE8355F49;
	Thu, 27 Aug 2026 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830236; cv=none; b=G5Ko5aO1Txk6u0AI1hav7plNH4iQ19wLcA5aYWozVArl84uPf4kkZ1NrX6aNgli3GY6mbbUDkE1JHA/nvTdrNIyA+kEM6Ps/1nOPOknfvOJOPPvoNWtzpJrxMJRMwoGnu8ufCZ5q/pUzfXWT23WwTngvALzDlGts6NKVer4j1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830236; c=relaxed/simple;
	bh=WEHz/S2Re6wpSTX28M5H5ipnsSyyvgMynSzSHMdXlxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aD388W/9/NqdDw7+AGiwlXK5QkzZHfNrzvvRsC9zUf3GFODqjKfnkXHwWAJugvISqjMIo+GldpvX2Q3kEygmqMDyhdMKna7NnHStiXAhCFwf1WVrhnuXtNDXE2lQzV5++XR9kUL9atfE/GkZE0WJUb+MbieElQQOdlYhb+jKUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZfDUg2vQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZfDUg2vQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rs
	/e+g2HCv6CrdUpaTII5v/xb9BTjjNH6rbCwvw5ogw=; b=ZfDUg2vQIpQe2c4PmD
	IFv9CoZ36lq3T5WjmicEgkdcCV7cNeSZVreED+y6d6SAtwhLDrdkcgDKgR1CtSjF
	o+ObkNIg5f0QAnMSYB39t2JglQ1c69SITRVP/lMXVF3PqzItv22CQVRgBTHxBE/6
	/g5KApbLyGWfcaMel6lAQXa+s=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC39gfGH5BqBg0dRw--.2335S2;
	Thu, 27 Aug 2026 19:30:14 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH] KVM: Reject coalesced MMIO zones that don't fit in the I/O bus range
Date: Thu, 27 Aug 2026 19:30:11 +0800
Message-Id: <20260827113011.1075514-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC39gfGH5BqBg0dRw--.2335S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw43Kr48XF47tw15XF1fZwb_yoW8uryrpa
	97W3W8Cr4xursrZ397AFs5Wa4UKws7tFs7AFy0v393CF40gFWvyr1YgrWYgF4DArZYvFWj
	va4Fq3WUCws8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j04E_UUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC5wa3c2qQH8atngAA31

From: Zeng Chi <zengchi@kylinos.cn>

kvm_vm_ioctl_register_coalesced_mmio() passes the userspace-provided
zone->size (a __u32) straight into kvm_io_bus_register_dev(), which
stores the length as an int.  A zone with size >= 2^31 is thus stored
with a negative length, which has two undesirable effects:

  - kvm_io_bus_cmp() sign-extends r->len when computing the end of the
    range, so the zone's computed end either wraps or precedes its
    start.  Depending on registration order, this makes bsearch() miss
    other devices on the bus, e.g. an ioeventfd registered after the
    zone, or spuriously match the zone for accesses far outside it.

  - KVM_UNREGISTER_COALESCED_MMIO passes zone->size as the "len" to
    coalesced_mmio_in_range(), which rejects negative lengths, so the
    zone can never be matched for unregistration, i.e. the zone is
    stuck on the bus until the VM is destroyed, while the ioctl
    silently returns success.

A zone whose addr+size wraps around has the same problems, as both
kvm_io_bus_cmp() and coalesced_mmio_in_range() assume non-wrapping
ranges.

Reject such zones with -EINVAL at registration time, similar to how
ioeventfd rejects a wrapping addr+len.  Note, this tightens the uAPI
slightly, as such zones were previously accepted (and then misbehaved);
no known VMM relies on registering a zone that doesn't fit in an int.

Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 virt/kvm/coalesced_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 6b1d90161099..fcadbf6ee6c9 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -128,6 +128,9 @@ int kvm_vm_ioctl_register_coalesced_mmio(struct kvm *kvm,
 	if (zone->pio != 1 && zone->pio != 0)
 		return -EINVAL;
 
+	if (zone->size > INT_MAX || zone->addr + zone->size < zone->addr)
+		return -EINVAL;
+
 	dev = kzalloc_obj(struct kvm_coalesced_mmio_dev, GFP_KERNEL_ACCOUNT);
 	if (!dev)
 		return -ENOMEM;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

