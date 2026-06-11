Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654D376A11
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165944; cv=none; b=QxBFGPq3ZckZvSPqlD3l0eGozzzr0nQ2S/i9Vn3NO1l126JKtN6RRWgUvFy9browvMeW4NjV8uXJkPXG+C3oY7YtD+kSepfp1uOC1LzM0Xm7SBXUyO2poK9jnoj8A2Eyj2G6kWjA0jiLTltXk3y1S9RaqjdiYMG2zfFl///slhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165944; c=relaxed/simple;
	bh=8LHfh1bCF4FU3ybo3nRz6D3bAk9AO+Blx224P0Mle50=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=cqqHsu+vqHnPahB+pT6iMPJZr6MUnB/lILYZnlLqEU2JXgRXOQfjSZJzexMKMzGwKjyV+tGSEM0aijpxitvBLExPGwCYlfplNuEXmU0scauTSbciENX0YvxdZ6FLX721Scl3fW3WHzfSSsYokp/9G+PPgDXolIrO+YqU+SH8fCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zJGENx7T; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zJGENx7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781165938; bh=SX3AgLIkUIpUB8Qfe8e7IKLkbDcXHdQnv9yz5btgsBc=;
	h=Date:From:To:Cc:Subject;
	b=zJGENx7T4zZJPMwbgwhTPS0zlJDvX/6Wk3F6tIbsKrc9wQRbFyGXQ721CvM4FWQz7
	 pp19Ej51u2f87XAyjGU3dwcqjuwe5vnCMjj+l8lhUljQHBF36hd7lowTeP80xdSP9X
	 BqfKK3386Gg1od4vdUCCjHSDzsKJEYT1vHYc4p6U=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 4B80A488; Thu, 11 Jun 2026 16:18:56 +0800
X-QQ-mid: xmsmtpt1781165936t0racm4ax
Message-ID: <tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com>
X-QQ-XMAILINFO: M8dwXi9nz8r07RofxSKP3fT2Qyywu2TxSFomWp7ZIQiseLAa1JVmzprurOK02W
	 uiXU7P4DbZBu98rRh9LPDlacEXVuTF+sEy6eofaUyI43X8InMrPsCf9rrTo8tlYmUAjkfruTK9IB
	 tKkrqvzaQy0lnTwsQhIAfD7gD/TWo9qoYYFBUVZ2nBH3fEfoDxlaHgRvC8+79AK8nBHX9UCmbrgL
	 G0tRJYGO1sTNTmGsCjJFrDCEupKezKlL8Qsm+KK5a5aubL7wO/rwhv3JAoWbplMT/VlTpttLzXUa
	 RGegCqMPDM+2JeCQrl+MmGfX/XNQKj4sMJ2fAtXZOakalneAeUK1GHeM7wnAIi71swo7f0rqHTXf
	 JAt85Txy0cB6KJ5/RI7QI1SlzLa1lLKUakjr2rMrbpaxKyBoNPMXZLHDtfJz6XXwTgr1Olw8q6dl
	 fk36SaxSr/48xCqwuDuZdjGplEX9k86e4LuA3lIDr8qqPgCe44DQ2LjPSbcCHNy8AtxKUcB4GcyF
	 ScwOSRRwYAH4nf36e1/E+ihb7CvpL3UAkLHxGlohGWZYhpyJRgGcsfTbF3iOxFVuR+oJqFo466jr
	 tVS8FS2xVI3dEOP4AxSUFPB5gucSIoU3k3bAxd8WPSS7CKq7CInaE4H97GwA0vU/uXVD2ChIvNZv
	 4IRpXxshVJVFl01iLGOZ95j7b5i/z/Y16/7a6NX2Yrts4/QkyuDGr9LOi4kCOcgdTKSIDkYBjVgs
	 PmeaKaiHMQacHeyssELbJI+CQPbfDM4lzW5i6JOCh6Y0cnO0fz9Qd1ovXvlM+lPj1aobG1BivqiH
	 J+D8fi21XSLC2iOK5y/2SHkCgsDchftNDoQsDfuiYmtgBGuCIA4Go3D1QcIgUsDi2heTpMDhEVTG
	 QZMfYwLwyseKr8k2CvDXe9W6dEsDWA5QPcyZNlcS8IEHtPrXR52i1HFGwtHPsA3KydjJ+18fPFmg
	 VMTtHy5V2eMoo06rqb+/Rj/ooBZ0yKoDquiVvLfIeeB5T8Z2Faxbi23aOyzn1/55fKeCIqL61+SV
	 fWLgVA8Xke0mGvjhZ1c/a+KHpfSVf7gNWqdek/7XGR9E8BXB8bg8u+r4JGUSGIlCvPf/hKhEeVd+
	 aTa45f9Mi/4IcvKTk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Date: Thu, 11 Jun 2026 16:18:55 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH] KVM: guest_memfd: Fix ABBA deadlock in error_remove_folio
X-OQ-MSGID: <20260611081855.GA119546@zh-pc>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From b164e59d4068226dfb33babe49292c7a685cacd9 Mon Sep 17 00:00:00 2001
From: Hao Zhang <zhanghao1@kylinos.cn>
Date: Thu, 11 Jun 2026 15:27:27 +0800

memory_failure() calls ->error_remove_folio() while holding the global
mf_mutex and the poisoned folio lock. guest_memfd's implementation takes
mapping.invalidate_lock for read before zapping KVM mappings.

That lock ordering can deadlock against guest_memfd punch-hole, which
holds mapping.invalidate_lock for write and can then wait on the same
folio lock in truncate_inode_pages_range().

Use a trylock in kvm_gmem_error_folio(). If mapping.invalidate_lock is
contended, fail recovery instead of blocking in the memory-failure path,
and instead of reporting MF_DELAYED without actually zapping KVM mappings.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 virt/kvm/guest_memfd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..9417be3049cf 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -499,7 +499,16 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 {
 	pgoff_t start, end;
 
-	filemap_invalidate_lock_shared(mapping);
+	/*
+	 * memory_failure() holds mf_mutex globally.  We must not block
+	 * on filemap_invalidate_lock here, as it can be held exclusive
+	 * by kvm_gmem_fallocate() (MADV_REMOVE/FALLOC_FL_PUNCH_HOLE
+	 * path), creating an ABBA deadlock with the poisoned folio lock.
+	 * If the invalidation lock is contended, fail the recovery instead
+	 * of reporting MF_DELAYED without zapping KVM mappings.
+	 */
+	if (!filemap_invalidate_trylock_shared(mapping))
+		return -EBUSY;
 
 	start = folio->index;
 	end = start + folio_nr_pages(folio);

base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
-- 
2.15.0

