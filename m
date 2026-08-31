Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1F3AB272;
	Mon, 31 Aug 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212242; cv=none; b=QAd3wVwRx4n8NPbHG5wSb38YrCZHuHgZRfpxZ0O5eW/yhf3D6zAfiJUSIf0Iy4EX3XXCMfOaUxhvIR0ESNk8S6jobs0GQ2ssdBuJY3uydEqO1hi/WLdCP535lkxhxlStrzMexP1GMtcM6BNzxzUNPd5NWfa8HUwY9TchvFDYhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212242; c=relaxed/simple;
	bh=Szq0CrgNrypm6C3U9uCvaU/XuksxHNihqBlG4ZHDxNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2Ex2LjVSaaY8AyAnAuTFOEoYwjTKbXQJSanhwyvUmM1XVY7eHgwm159zcu5Fo0RermkwRAfoNRMiUODZRhRGlloK98hP6MqX733Rb5pq8CeuT7M1ti+xS0QJDausy25iQVYL77LiWC+P9LLm14ONSM7toKs/UJEb7T5L+1Vs7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gs0G1f0u; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gs0G1f0u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=m0WJDQzp0L5LRsaTNB+24YMdZSYX+LKwXvZ418llJ4A=; b=gs0G1f0u6rR+XVch5cavJv24GF
	ix48bXgXjv2S9kov7cTAHKGIaKu+9LbDaLZ69E6ZSZeWCEszY8t7k8SndwLrLaiVGnd2XLvczIOPl
	wSKXy5jNzcOenG3/0IfkkOWfs5okKwhS1/o76bENj5ZFWHlfUExwGi3N71DGkj7IpXG1cQu9vsFDT
	LumcJLj+z9/biEOoMa7uQbLw3+aFDOy/tl4ph91PBsLCPIckX75GsQtJl/efYM0gVhOBk8+l2dMuF
	HZGC59ni8J52++ojRwY7NS3GJr5ZHMK3Ogmzp3HMUE2NTZKNRiqa0SbGn88/Y5Ccq68oFIpMrX0lU
	IuxwwfGQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x19gG-0000000AKc6-33dj;
	Mon, 31 Aug 2026 21:36:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gD-00000000LCb-3R19;
	Mon, 31 Aug 2026 22:36:37 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	suryasaimadhu369@gmail.com,
	lkp@intel.com,
	nicoyip.dev@gmail.com,
	frn1furkan10@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 0/13] KVM: x86/xen: Bug fixes and long_mode cleanup
Date: Mon, 31 Aug 2026 22:26:31 +0100
Message-ID: <20260831213632.81023-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

Clean up the handling of vcpu->arch.xen.long_mode to be consistent and
correctly handle 32-bit/64-bit alignment. And various other bug fixes
that have accumulated over the months since v1.

v3:
 - Rebase onto kvm/next (7.3 merge window).
 - Add poll_evtchn READ_ONCE/WRITE_ONCE annotation (Chengfeng Ye).
 - Add evtchn_ports IDR to XArray conversion (Furkan Caliskan).

v2: https://lore.kernel.org/all/20260811094829.98794-1-dwmw2@infradead.org/
 - Take kvm->srcu in __kvm_xen_has_interrupt().
 - Add dedicated invalidation sequence for HVA-based caches.
 - Take Sean's version of the 32-bit atomics patch, and his follow-up
   replacing the remaining asm blobs with atomic*() APIs.
 - Use GEN_BINARY_RMWcc() rather than open-coding the btsl.
 - Explain why the pending_bits access in kvm_xen_set_evtchn_fast() does
   not need the same treatment as the vcpu_info one (it is in the page
   aligned per-VM shared_info).
 - Don't require 8-byte alignment of vcpu_info in 64-bit mode; always
   accept 4-byte alignment, so as not to break migration of guests which
   registered while in 32-bit mode.
 - Add Closes: links for the reported issues.
 - Cast to u64 before the >> 32 in the unaligned evtchn_pending_sel
   handling; evtchn_pending_sel is unsigned long, so the shift was
   undefined on 32-bit even though the branch is unreachable there
   (kernel test robot).
 - Rebase onto kvm-x86/next; the mode-aware kvm_<reg>_read() helpers which
   landed in the meantime subsume most of what patch 1 was doing by hand.

v1: https://lore.kernel.org/all/20260605143034.3603-1-dwmw2@infradead.org/

Chengfeng Ye (1):
      KVM: x86/xen: Mark poll_evtchn accesses with READ_ONCE()/WRITE_ONCE()

David Woodhouse (8):
      KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
      KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo() macro
      KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
      KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
      KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
      KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
      KVM: pfncache: use a dedicated invalidation sequence for cache refresh

Furkan Caliskan (1):
      KVM: x86/xen: Convert evtchn_ports from IDR to XArray

Hyunwoo Kim (1):
      KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()

Sean Christopherson (2):
      KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't aligned
      KVM: x86/xen: Use atomic*() APIs instead of open coded equivalents

 arch/x86/include/asm/kvm_host.h |   3 +-
 arch/x86/kvm/xen.c              | 212 ++++++++++++++++++++++++----------------
 arch/x86/kvm/xen.h              |   5 +
 include/linux/kvm_host.h        |   2 +
 virt/kvm/kvm_main.c             |  10 ++
 virt/kvm/pfncache.c             |  18 ++--
 6 files changed, 157 insertions(+), 93 deletions(-)

