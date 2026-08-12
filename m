Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFC3438A9
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523322; cv=none; b=Z22oRw/evb6+VlM/qJWgAyJDCROB+z2Ev2KIupEx/DX0YZB7NIRpvv+AGdLepYPzTpmsmmFQoShXxVqDIhbIDYnWHQwfwX9Qbjn7rRxpgeYV6g0Q9364xvbpHlzSr5mzvKZhJW/9fmu17VplvVsSl00NjAtxEEVcZWT4WaqS9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523322; c=relaxed/simple;
	bh=AjvbeieSbVzjFXQlC7kHcJawmibQsCqwj/dCI/b7tvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dcmCkyaojquitAoCKKZa1YCafO5EZx7LfJvNDfRkqwWymMtUebaQyqMb056WGJ0CeEZyIGlSDEjlUsCOp56FuEG4/GcRP+EuR9wn2AoySiRgfSKUir2NGcp2CHouhqPd1BdybWavKJQmMCKu0f6ch6lN8SHVenBz3J/a7xAGdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fTXT+YU1; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fTXT+YU1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3Kz2Td1gdi2LNTQ/iJiWt/52JcRQ7i7XMMeO7mdeoEU=;
	b=fTXT+YU1zkOFXoNjWIiLomasxCa1i0Tv0iFU9fVtWCmrP8m3vDUAihJUupSk8+
	4NnzJ+LcyTjgQvw8bB3ruOIeirbXONIfzDAPO18ks/GlsTz+3rKGhfcDmcLpM4xa
	Q9LxPn3M28o8sUHlNC4RkybFwZzFxsikUmhqzCHfG1BGM=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAH7u2FLnxq0_p4Lw--.54951S2;
	Wed, 12 Aug 2026 16:27:49 +0800 (CST)
Date: Wed, 12 Aug 2026 16:27:46 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v5 0/6] KVM: x86: Fix IOAPIC remote_irr and irr_delivered
 handling
Message-ID: <anwugm-oU0v1VM-t@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:QCgvCgAH7u2FLnxq0_p4Lw--.54951S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1Dtw4UWF4xGr1fKFWxZwb_yoW8XFy7p3
	ykGanYg3ykJr1xKF97Jws2qF95G3Z5AFW5J343Xw4UXa15tas2qrZ7KrW0gay5WrWfZrWY
	y3Wft3W3Wa1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR78nrUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3QVmWWp8LoUfEgAA3X

From: Hao Zhang <zhanghao1@kylinos.cn>

Fix several cases where KVM updates IOAPIC interrupt state incorrectly.

The first fix avoids setting remote_irr when level-triggered interrupt
delivery fails, which can leave the pin blocked waiting for an EOI that
will never arrive.  The remaining fixes clean up irr_delivered handling
for edge-triggered interrupts, which affects the IOAPIC state exposed to
userspace through KVM_GET_IRQCHIP.

Changes in v5:
- Updated patch 1 changelog to explain the Fixes tag history and added
  Kai's Reviewed-by.
- Split selftest changes for the irr_delivered fixes into separate
  patches.
- Dropped the Fixes tag from the duplicate-edge patch, as the exact
  historical commit is unclear.

Hao Zhang (6):
  KVM: x86: ioapic: Update remote_irr only after successful delivery
  KVM: selftests: Verify failed IOAPIC delivery preserves state
  KVM: x86: ioapic: Preserve irr_delivered for duplicate edge interrupts
  KVM: selftests: Verify duplicate edge preserves IOAPIC state
  KVM: x86: ioapic: Clear irr_delivered on level-triggered RTE
  KVM: selftests: Verify edge-to-level clears IOAPIC state

 arch/x86/kvm/ioapic.c                              |  15 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 190 +++++++++++++++++++++
 3 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/ioapic_state_test.c


base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86

-- 
2.15.0

