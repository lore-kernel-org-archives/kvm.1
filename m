Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4825392C;
	Mon, 10 Aug 2026 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339032; cv=none; b=blvPHzr7dbuZsAdlkHOEC70aegA4pbj0peynpGTpcNKM62o85K2QtiQUwl1HwZoS+JgUyLWGkVFcvOmYdGGt+ecYG/XKNLJtxNzD+AKVbqeQThdD0nbbR5dAgPdCP0PopROsfPIpLEyLzvPT+WkVxvhukEDmeVNBJYn1r4NYN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339032; c=relaxed/simple;
	bh=m5DbnW6TF3ROLcYYooevwYPMCMYV7/2Sb4qVlli3huc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GEAKR4MxQhZc9DClvhNb4SG09YxnxpdMp7rVpTEWekSJwIuxsC0DZiF8IoSk8kVT4GXhKVGcKSp6if/ypiuahbKGzb5b2BB6QbME8HRf4jj3bE6TMH3l7WprSUkHlFtvCj0AP2xn3NO8NNzUgRQcacb6+wrynnoQmMjW2Hqcjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=XsZHZh/0; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="XsZHZh/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Qohe9NvYIz
	9HaXfgOLxozIyLWqbZILHSQoPxrkrR74s=; b=XsZHZh/0PeIMdPBmP24UfxXBe5
	XZwtrf3k9gRzlQjsLrPuylJXvDvkMPNLYVqEoCKqQn+jA1qiHiBUcgJjywFCCvTG
	ETlADVmbnGZXBcpD+PtG5UJ5ww2Y2UUeI/G106nIRPmZqBv4E7PB0hRn1fn4w8wk
	RyuImQ8de6o3eRdrQ=
Received: from ultrarisc.com (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkOZXnlq2JYWAA--.18693S2;
	Mon, 10 Aug 2026 13:16:18 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>,
	kvm-riscv@lists.infradead.org
Cc: Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xie Bo <xb@ultrarisc.com>
Subject: [RESEND PATCH 0/2] RISC-V: KVM: Fix G-stage fault handling
Date: Mon, 10 Aug 2026 13:15:42 +0800
Message-Id: <20260810051544.3953925-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnEkOZXnlq2JYWAA--.18693S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW7Wry7tFW3tr47CFW3ZFb_yoWfZrg_Wa
	10k3429an5XFW7ta4UKanYyrW0krWrGryfZry0yFZrGa4UursxKay0vw1fXrW8JF4YvFn8
	Cry5Ar93Zw1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgXocUUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2p1VlUAFAAMsO

The original posting did not reach the mailing lists because of a sender
configuration error. There are no code changes in this resend.

Fix two error paths in RISC-V KVM's G-stage fault handler.

The first patch releases a faulted-in page as unused when an MMU
invalidation prevents the page from being installed. The second patch
translates KVM_PFN_ERR_SIGPENDING to -EINTR instead of treating an
interrupted host fault as an invalid mapping.

Both issues were found while wiring pre-fault memory support, but affect
the existing vCPU fault path independently.

Tested with a full RV64 kernel build.

Xie Bo (2):
  RISC-V: KVM: Release unused page after MMU invalidation
  RISC-V: KVM: Propagate interrupted G-stage faults

 arch/riscv/kvm/mmu.c       | 10 ++++++++--
 arch/riscv/kvm/vcpu_exit.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)


base-commit: dfdf1374fdeccb5b7e3d35186228e01ec5ea5f01

