Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BC3090F5;
	Wed,  4 Mar 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616121; cv=none; b=hdDA5nO7w7oGHGa+nRY4LXu8CSIWemwS8VfG/ARehCthmi8L0Ebs7hYEQSkNhAgnAEYD2p02Zuq+sUFkb9GNM9XLkVWmfUeKbPxHb6rMK1g+FDUsA6AamrXGmSw847x7mVN/Hy1K6dbz+/D2WUwO/ayOIRjEaZU+3NIKOmEUSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616121; c=relaxed/simple;
	bh=nzErDn7XbBB7iPUEQuBgB1WvLudKA1xYNN25LjEsIWY=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=Q/xck/FkaU8XPQcniYlJBZkwhM9pMECyLH/0b80dOVsmLTGbvCBFpkrVTe7TRocm3cXQDb86+ogcU3yf3be0abqKFzxZJ+/2/5mi2jthjasfaApSt9oCOV9rfIKNB5WEHB9Th3WpmEPIjkOzg+nqt1S2Nj+cegp6lCK0XRiuEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fQnHG51clz4xQXM;
	Wed, 04 Mar 2026 17:21:46 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl2.zte.com.cn with SMTP id 6249LaoC048377;
	Wed, 4 Mar 2026 17:21:36 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 4 Mar 2026 17:21:39 +0800 (CST)
X-Zmail-TransId: 2b0569a7f9a33a2-214cb
X-Mailer: Zmail v1.0
Message-ID: <20260304172139131ChDubMSpGDUB03lY4UCbK@zte.com.cn>
Date: Wed, 4 Mar 2026 17:21:39 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wang.yechao255@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvM10gUklTQy1WOiBLVk06IEZpeCBodWdlcGFnZSBtYXBwaW5nIGhhbmRsaW5nIGR1cmluZyBkaXJ0eSBsb2dnaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6249LaoC048377
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Mar 2026 17:21:46 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69A7F9AA.000/4fQnHG51clz4xQXM

From: Wang Yechao <wang.yechao255@zte.com.cn>

This series fixes an issue where dirty logging fails to work correctly
with huge pages.

v1 -> v2:
  - fix the lost write protection on huge pages
  - split huge pages before handling the write protection fault.

  - Link to v1:
  https://lore.kernel.org/linux-riscv/20260226172245358qVZavIykLL2QC0KoqTO-I@zte.com.cn/T/#u

Wang Yechao (3):
  RISC-V: KVM: Fix lost write protection on huge pages during dirty
    logging
  RISC-V: KVM: Allow splitting huge pages to arbitrary level
  RISC-V: KVM: Split huge pages during fault handling for dirty logging

 arch/riscv/include/asm/kvm_gstage.h |  4 ++
 arch/riscv/kvm/gstage.c             | 85 +++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 4 deletions(-)

-- 
2.47.3
