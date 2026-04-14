Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EC83E5ED2;
	Tue, 14 Apr 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167824; cv=none; b=QjUvsnnWjdgTf5cxrH2eROpVPU9swnKnktaMwCg6pBhg8JLVRj+9WdTXWae5hWsoU4paULRC9pRzSE44Tyqn1y2fGqYB9AQrO75dHQQ1ocUV39BY1BEW4sNiQfj27w2Qagr8QUERSlCrNyLWPTqO7MiMCWpkbxG92hEKeKLN0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167824; c=relaxed/simple;
	bh=Gkde0jxhlfdy4i37YisRdKeGktZ+IoW/1RbokPnjYKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjFUy4oMDvQ0QUJBFyWWOA1sEz81hFzTPxgHZQ4Zzwte3Owd1004WDQm8c7wIkbL29Las9LqQHdrvRHt/xyHj3NUYGWpiPDHQ2lbw3jIMDFVW8s9p50WeqUmZ8F9PeELdVjr5yhzbh1CLeY3zw3CJ3n9aHrkW//omXF+xbqMBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Bxb+uIK95pTHwAAA--.2261S3;
	Tue, 14 Apr 2026 19:56:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJAxGMGGK95pm+RsAA--.62139S2;
	Tue, 14 Apr 2026 19:56:55 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	lixianglai@loongson.cn
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH V4 0/2] LoongArch: KVM: fix "unreliable stack" issue
Date: Tue, 14 Apr 2026 19:31:09 +0800
Message-Id: <20260414113111.2997864-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxGMGGK95pm+RsAA--.62139S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When starting multi-core loongarch virtualization on loongarch physical
machine, loading livepatch on the physical machine will cause an error
similar to the following:
[  411.686289] livepatch: klp_try_switch_task: CPU 31/KVM:3116 has an
unreliable stack

The specific test steps are as follows:
1.Start a multi-core virtual machine on a physical machine

2.Enter the following command on the physical machine to turn on the debug
switch:
  echo "file kernel/livepatch/transition.c +p"  > /sys/kernel/debug/\
dynamic_debug/control 


3.Load livepatch:
 modprobe  livepatch-sample 

Through the above steps, similar prints can be viewed in dmesg.

The reason for this issue is that the code of the kvm_exc_entry function
was copied in the function kvm_loongarch_env_init. When the cpu needs to
execute kvm_exc_entry, it will switch to the copied address for execution.
The new address of the kvm_exc_entry function cannot be recognized in ORC,
which eventually leads to the arch_stack_walk_reliable function returning
an error and printing an exception message.

To solve the above problems, we directly compile the switch.S file into
the kernel instead of the module. In this way, the function kvm_exc_entry
will no longer need to be copied.

changlog:
V4<-V3:
1.Use SYM_CODE_START to modify the kvm_enter_guest function

2.Replace the EXPORT_SYMBOL macro with EXPORT_SYMBOL_FOR_KVM

3.Simplify the modification of the "unreliable stack" issue,At the entry
point of the function kvm_exc_entry, by using the UNWIND_HINT_END_OF_STACK
macro, the subsequent translation of the orc call stack can be terminated.

V3<-V2:
1.Replace the EXPORT_SYMBOL macro declaration symbol with the
EXPORT_SYMBOL_FOR_KVM macro

2.Add some comments in kvm_enter_guest

3.Place the correct pc address in era

4.Move .p2align after .text

V2<-V1:
1.Rollback the modification of function parameter types such as
kvm_save_fpu. In the asm-prototypes.h header file, only the parameter types
it depends on are included

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>

Xianglai Li (2):
  LoongArch: KVM: Compile the switch.S file directly into the kernel
  LoongArch: KVM: fix "unreliable stack" issue

 arch/loongarch/Kbuild                       |  2 +-
 arch/loongarch/include/asm/asm-prototypes.h | 21 +++++++++++++
 arch/loongarch/include/asm/kvm_host.h       |  3 --
 arch/loongarch/kvm/Makefile                 |  2 +-
 arch/loongarch/kvm/main.c                   | 35 ++-------------------
 arch/loongarch/kvm/switch.S                 | 29 ++++++++++++-----
 6 files changed, 47 insertions(+), 45 deletions(-)


base-commit: d60bc140158342716e13ff0f8aa65642f43ba053
-- 
2.39.1

