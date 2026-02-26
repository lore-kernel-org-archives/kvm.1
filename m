Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050C37474B;
	Thu, 26 Feb 2026 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116657; cv=none; b=TgB5g/XX/amsHv7J5D0JAbLwBlLcd8REN+B93hNgIoy14CdGj8LBDt+iMDQeRATQo4ayh4/fZdm0/QcZbs3sL26yea4SQITZZQlJqXinQ5UJOVMu2eMsXMyH2qx0FB76gggXGBo0NzgCsCIyCNPlU7OZJGDv1xwQiZ3Sxx8RwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116657; c=relaxed/simple;
	bh=Vz58WHttVcNQG/3Jcd9G0PXWP0L7ogtzIBHgWQI8H8k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=tDO2EYepAbjXC1O0m948bteKr1XqQnJy9v73U6+Yb38x+djTbfd/qMsaTwpjJ+1r8HyiTwgcIqeX6b1r6ibmt7S5vBSbcylBtJXSf1ZQhTQsy6kp1q23ogxIQ5kawXz8MNisFiTbv8SGuc1H38SwsUkBklhCcqCtm3o1jgPLh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=escqfQNJ; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="escqfQNJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=CC:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yfLVFM+oU/NWcIIH45tixxiV4mTmdtkw+rbkH4ApJwE=; b=escqfQNJFPMIlXL3vrUb8dEfo5
	X+GRTkPUpTHVk8PD/UbNdrYubrjlEeBHtbWGGRjRHcLK8QkYw5fTMVlWHWBR4p6y5tDvigyxhOahN
	x4rPH1zTXxmwfuVx9j6S1q+AsKukd1XRJO5R8wbLCd3lV+e5urIk4IO/Mp4xivjf2ChMiUl5ZRI60
	WZSdkj5ussdfy7woOwm7j8q1d57zLH6yQ7fTz1QsaIssYt9RNN2KxbayVYexfRhzBrw/bCYun8hlP
	5OTYp5uE0puOOlxVRa4W1+Z1ZFiCcO3qrqLTy4HohDxYaAdx/mgOgt6QaO++e/ryhxO33ymCc8cXD
	s5saVNww==;
Received: from mailer.gwdg.de ([134.76.10.26]:38446)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vvcD5-006EFl-0Q;
	Thu, 26 Feb 2026 15:19:23 +0100
Received: from mbx19-sub-05.um.gwdg.de ([10.108.142.70] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vvcD5-0009uO-28;
	Thu, 26 Feb 2026 15:19:23 +0100
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (10.250.9.200) by MBX19-SUB-05.um.gwdg.de (10.108.142.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 26 Feb 2026 15:19:12 +0100
From: Lukas Gerlach <lukas.gerlach@cispa.de>
Subject: [PATCH 0/4] KVM: riscv: Fix Spectre-v1 vulnerabilities in register
 access
Date: Thu, 26 Feb 2026 15:18:57 +0100
Message-ID: <20260226-kvm-riscv-spectre-v1-v1-0-5f930ea16691@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G6hFivgV8SBp1CAuJFIE6d8tH
 gdm5gVjFTboqxeUk5icR4GmroDW6VgYJRYG73xw3gfc0o4qRgntYrqVMTXYRtdGCh0VA0p6Kc/
 y/NthzPkDOosoY2YAAAA=
X-Change-ID: 20260226-kvm-riscv-spectre-v1-4d04dc68c226
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones
	<ajones@ventanamicro.com>
CC: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Daniel
 Weber <daniel.weber@cispa.de>, Michael Schwarz <michael.schwarz@cispa.de>,
	Marton Bognar <marton.bognar@kuleuven.be>, Jo Van Bulck
	<jo.vanbulck@kuleuven.be>, Lukas Gerlach <lukas.gerlach@cispa.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=lukas.gerlach@cispa.de;
 h=from:subject:message-id; bh=Vz58WHttVcNQG/3Jcd9G0PXWP0L7ogtzIBHgWQI8H8k=;
 b=owGbwMvMwCGWoTIjqP/42kTG02pJDJkLwuLbsoSz4hZar4j8WX7Uckm50Llp622yPnpOm6Q21
 3rF0tmdHaUsDGIcDLJiiixTBV8z9u1x4EnKPHwOZg4rE8gQBi5OAZjInwKGv/KG3F0zchdXaFpG
 6cyt4DS9nLYjjft8cdvZewWCZd3J/gz/a7qUey7kaMbKHH3G4jOjIfy6RdZL9TVGCwQKnNhVOk1
 YAA==
X-Developer-Key: i=lukas.gerlach@cispa.de; a=openpgp;
 fpr=9511EB018EBC400C6269C3CE682498528FC7AD61
X-ClientProxiedBy: mbx19-sub-02.um.gwdg.de (10.108.142.55) To
 MBX19-SUB-05.um.gwdg.de (10.108.142.70)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

This series adds array_index_nospec() to RISC-V KVM to prevent
speculative out-of-bounds access to kernel memory.

Similar fixes exist for x86 (ioapic, lapic, PMU) and arm64 (vgic).

Signed-off-by: Lukas Gerlach <lukas.gerlach@cispa.de>
---
Lukas Gerlach (4):
      KVM: riscv: Fix Spectre-v1 in ONE_REG register access
      KVM: riscv: Fix Spectre-v1 in AIA CSR access
      KVM: riscv: Fix Spectre-v1 in floating-point register access
      KVM: riscv: Fix Spectre-v1 in PMU counter access

 arch/riscv/kvm/aia.c         | 11 +++++++++--
 arch/riscv/kvm/vcpu_fp.c     | 17 +++++++++++++----
 arch/riscv/kvm/vcpu_onereg.c | 36 ++++++++++++++++++++++++++++--------
 arch/riscv/kvm/vcpu_pmu.c    |  4 ++++
 4 files changed, 54 insertions(+), 14 deletions(-)
---
base-commit: f4d0ec0aa20d49f09dc01d82894ce80d72de0560
change-id: 20260226-kvm-riscv-spectre-v1-4d04dc68c226

Best regards,
-- 
Lukas Gerlach <lukas.gerlach@cispa.de>

