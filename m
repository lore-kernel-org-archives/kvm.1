Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D233F5B3;
	Wed, 11 Mar 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199223; cv=none; b=MkWXPpr4xc0bLdHo1I8ZCLfPZvZmAm7MvRpnbTK31HPPdrbkcC7X0w0Ig0kaVnroaw49wkDHRIWCntx1kcvotZmy19LFL3uaGcSE6IIC3igZz+EydMi2X+42c4SZJUVGSHhh2QNrDST4IzTAEEoF9xoUYeNyxwq2qoJPgab126Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199223; c=relaxed/simple;
	bh=HBf+mYwsk9ruK8UkUYpLimPhjAMVpTgEXbk72xE6S64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S5hzWqKBNDo4ccAohsVzqde3FPnUtgKH6/bjuID3IdRzBvNzJmoqanjRqeifAfkw82vfnrI/vOQhDG7hSy/xeNxKsFe+rznrFEvXv967EvBrpVr7YAVELKvCFkTSL1W7MmuFNCObmiSAnx7ovH0zDuFj4mnJ5CrE+sHcD/H+svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxNMFg37BpocgZAA--.28431S3;
	Wed, 11 Mar 2026 11:20:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxWeAj37BpH69SAA--.26923S2;
	Wed, 11 Mar 2026 11:18:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/3] LoongArch: KVM: Some small enhanments
Date: Wed, 11 Mar 2026 11:18:54 +0800
Message-Id: <20260311031857.3591470-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeAj37BpH69SAA--.26923S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There are some small enhancements about LoongArch KVM. There is
improvement about VM entry path in patch 1 and patch, add pending
request checking in advance and it is empty at most time.

Also change vcpu_is_preempted() from function to macro method, by actual
benchmark test such as unixbench. It is affected on physical machine
with function method. With the macro method, only one nop instruction
is added and there is no parameter parsing, there is no obvious
performance influence with physical machine.

Bibo Mao (3):
  LoongArch: KVM: Add kvm_request_pending checking in
    kvm_late_check_requests()
  LoongArch: KVM: Move host CSR_EENTRY save in context switch
  LoongArch: KVM: Set vcpu_is_preempted() macro rather than function

 arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++-----
 arch/loongarch/kernel/paravirt.c       | 15 ++------------
 arch/loongarch/kvm/vcpu.c              | 24 +++++++++++------------
 3 files changed, 36 insertions(+), 30 deletions(-)


base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.39.3

