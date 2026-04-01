Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA92FD68B;
	Wed,  1 Apr 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040566; cv=none; b=f5jEAzOuwNEDBx3ZXa6t/zgo25JSTA9aHkRkdvqpNPiaRhHffTwZq5llq0eVIUBifD4QqczfUHrc9ltjQK0tDX9NlvadRU5GRIE23/Wqj5fYQUSBJK8kuLXRTsxBiAEDICDPEElvDXLv0VEHBtVkPgs7DQCSwLK0lW0J5xayoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040566; c=relaxed/simple;
	bh=pgu/xrikS1EicywTi3slsCZAGoYeoupdv3txZcIG3fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkRNAbj0mBm/9WEqeQrgoJeQSwsrWyemvczSOMYpxj94dHutFv5b5Cj661WOkpxgp7vgvs4hDC6qbRTdU4oz1D4LThlx/p/DGNyqZSSk14FKmEhx17/RkK06jMSYZlzIL/lCh27mwHPHJLYMVISwYZb8IrcMTkn4767xqMf3zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABng9oe+Mxp7D+IDA--.28909S2;
	Wed, 01 Apr 2026 18:49:03 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: anup@brainfault.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	jiakaiPeanut@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	xujiakai2025@iscas.ac.cn
Subject: Re: [PATCH v2] RISC-V: KVM: Fix use-after-free in kvm_riscv_gstage_get_leaf()
Date: Wed,  1 Apr 2026 10:49:02 +0000
Message-Id: <20260401104902.716329-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAAhSdy3V2kipH8sPzXkmnXP=Sh=7wwqhHaAWDyucJnytbL+qtw@mail.gmail.com>
References: <CAAhSdy3V2kipH8sPzXkmnXP=Sh=7wwqhHaAWDyucJnytbL+qtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABng9oe+Mxp7D+IDA--.28909S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZryDJr47CF17Ar13JryDtrb_yoW8JF1Upr
	Z5K3y3uFn8Ww4UZrs7J3WkArW5u3yxWr15Ga4DG3Z3Cw45XrW3Wr4I9ryqv3Z8Cr1SvFZI
	vF1Ut34DZw48Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjEoGDUUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwsECWnM0NKVfQAAsO

Hi Anup,

I've been fuzzing the latest kvm-riscv with the spin_trylock() fix 
applied, and I can still reproduce the use-after-free bug in 
kvm_riscv_gstage_get_leaf(). This indicates the current fix is 
insufficient.

The current code does:
    mmu_locked = spin_trylock(&kvm->mmu_lock);
    kvm_riscv_gstage_unmap_range(...);
    if (mmu_locked)
        spin_unlock(&kvm->mmu_lock);
When spin_trylock() fails (lock held by another CPU), the code still 
proceeds to access the gstage page table without any protection, 
leading to UAF when concurrent with kvm_riscv_mmu_free_pgd().

The fundamental issue is that spin_trylock() returns false in two 
different cases:
1. Lock held by current thread (we should continue)
2. Lock held by another thread (we should NOT continue)
But the current code doesn't distinguish between them.

My proposed fix:
Use lock_is_held_type() to check if current thread already holds the 
lock:
    bool need_unlock = false;
    if (!lock_is_held_type(&kvm->mmu_lock, LOCK_STATE_HELD)) {
        spin_lock(&kvm->mmu_lock);
        need_unlock = true;
    }
    kvm_riscv_gstage_unmap_range(...);
    if (need_unlock)
        spin_unlock(&kvm->mmu_lock);

However, I'm not sure if this is the best approach. What do you think?

Thanks,
Jiakai

