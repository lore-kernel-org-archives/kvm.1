Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBE2222D0
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908773; cv=none; b=H4TlFjjMW1nRiLgqV2SdwWTO3On6H3+gTutaDwoOr/gq3eVo/RoZzwm4rd40bBVlq0klfIFAPtGonPtwzr6CTNph/856QB/z/ArrgEzvcLcItTYuUgLYlyDaKT9MhSj8BtQTgy3yqDL1EQoxkkyno6PXiafY1SphL6nM2gqJgdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908773; c=relaxed/simple;
	bh=HQAF0TXVQayoSiNpW8Ou8TZDEsJ2+HLI+wcR8LBrGac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FZZGHGutvinFegLPIoua6f64d8BnQJkgBH6dvdZq+c13pnaEbRi8ho93I3uHxa6KsOdfEKnY4osM2M4Au22GB9EI2qlosDutABygTgiGnmU4R3PXfzQsSxfLL8KaD9PRx7x/r7vqxGWGluDi6GbuCpxQp43MLN2cpCilPjD0RtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kCmpSPd3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kCmpSPd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=X2tSQMb5g+pDzxBWNSJVxOAYA14Ll3kCqiuVgRV6WA4=;
	b=kCmpSPd3GQKdEs5hl430k7sjUZbQT7Y3irfSvgkZg7jPkKI7ozRI5aj8dDS8Gy
	VKWkkJj5MRq46XHG8J6pRmUYLvXVQxE4Rj3onaI7PU68XuGAgUtC/r8WKAKW7Sic
	qD6dkoj+FDMFF4yTRQlgNTInjIelIHzzzd85uEqtwY5lA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC39KKTUpFqEosASg--.52362S2;
	Fri, 28 Aug 2026 17:19:15 +0800 (CST)
Date: Fri, 28 Aug 2026 17:19:14 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 2/2] KVM: Return dirty ring reset errors if no entries were
 reset
Message-ID: <apFSkpRoxhDMJwRr@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apFQtIs9SLEobo04@192.168.1.215>
X-CM-TRANSID:_____wC39KKTUpFqEosASg--.52362S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1UCw1kCrW8Ar1DWr15Jwb_yoW8Cw45pF
	s3K34kKrW5tr18GFWxt3ZYvas0vrZ3Kr4rAFWDKw43JFn8tF95XF18trWjvr9xG3ykZFyS
	vryjvF1Uuw15uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhTmDUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3hO3qmqRUpOc4QAA3X

From: Hao Zhang <zhanghao1@kylinos.cn>

KVM_RESET_DIRTY_RINGS returns the number of entries that were reset.
Commit 530a8ba71b4c ("KVM: Bound the number of dirty ring entries in a
single reset at INT_MAX") converted kvm_dirty_ring_reset() to return a
standard 0/-errno, and commit 49005a2a3d2a ("KVM: Bail from the dirty
ring reset flow if a signal is pending") introduced an actual -EINTR path
by bailing out when a signal is pending.

kvm_vm_ioctl_reset_dirty_pages() currently breaks out of the vCPU loop on
error, but always returns the number of entries that were reset.  As a
result, KVM reports success with a return value of 0 if a signal is
already pending before any entries are reset.

Preserve the existing partial-success behavior by returning the number of
reset entries after forward progress, but propagate the error if no
entries were reset.

Fixes: 49005a2a3d2a ("KVM: Bail from the dirty ring reset flow if a signal is pending")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 virt/kvm/kvm_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..ad472c577a7a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4999,7 +4999,7 @@ static int kvm_vm_ioctl_reset_dirty_pages(struct kvm *kvm)
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
-	int cleared = 0, r;
+	int cleared = 0, r = 0;
 
 	if (!kvm->dirty_ring_size)
 		return -EINVAL;
@@ -5017,7 +5017,12 @@ static int kvm_vm_ioctl_reset_dirty_pages(struct kvm *kvm)
 	if (cleared)
 		kvm_flush_remote_tlbs(kvm);
 
-	return cleared;
+	/*
+	 * Preserve partial-success semantics if KVM made forward progress, but
+	 * don't squash errors when nothing was reset, e.g. if a signal was
+	 * already pending.
+	 */
+	return cleared ? cleared : r;
 }
 
 int __attribute__((weak)) kvm_vm_ioctl_enable_cap(struct kvm *kvm,
-- 
2.15.0

