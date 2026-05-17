Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2521ADB7;
	Sun, 17 May 2026 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021578; cv=none; b=P8R/RJtXmTaIVHy2TsjXHC+Gq8/+pGbowQw2Gx+rp08cqPxBm45eL+e6IxXAM4aPRmYXj4epQfHf9la5/CatyGgslMvqQIimq/05VDwWf9MVVfIvpWFL11x/dWdRqPuUGyokevy5FZJNKKCVN6dr73py1UL/gSbyj7dcNkUNsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021578; c=relaxed/simple;
	bh=ZUhvOhvm2JheqfS0aNVMHbF32eIjwF9Yefvpf7b7w4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Boox4hQ17qygbxrJw2XSdkxE3sUkRap3ptuU98xQF2GBa+Emp0ng2Ljt/I4PquwXDY/FAShT9eGop3YD1D8Jy7H/8AoU3Na0x7Os+rnu3Q0FrS5Ob+VzJLDrlkcQHnyAyaT7FUZ4tF5Gse99cuzpTcGlfbPI8AtDz+2h1VlGyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADXaw_jtglq5ZqHEA--.31390S2;
	Sun, 17 May 2026 20:38:59 +0800 (CST)
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
	pjw@kernel.org,
	xujiakai2025@iscas.ac.cn
Subject: Re: [PATCH] RISC-V: KVM: Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
Date: Sun, 17 May 2026 12:38:59 +0000
Message-Id: <20260517123859.409709-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAAhSdy08enoCH83begksrSA4strPG5n5Wd4i+ext0Z+Wmz_OAA@mail.gmail.com>
References: <CAAhSdy08enoCH83begksrSA4strPG5n5Wd4i+ext0Z+Wmz_OAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXaw_jtglq5ZqHEA--.31390S2
X-Coremail-Antispam: 1UD129KBjvdXoWrCr4DXr47Jw4UGF4UWr15urg_yoWxXFc_Gw
	s7Aay5WrW8ZF1FvF1DKwn3WFnxJw4kX3yktrnxAr95C34kArW7Kws3WF1DXr15Jrn8Ja93
	CrnYv34fJ3909jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAgKCWoJMy-L8wAAsA

Hi, Anup!

Thanks for your review!

> > diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
> > index 188d5ea5b3b85..98ecfcb2469e6 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> > @@ -55,6 +55,8 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >
> >                 for_each_set_bit(i, &hmask, BITS_PER_LONG) {
> >                         rvcpu = kvm_get_vcpu_by_id(vcpu->kvm, i);
> > +                       if (!rvcpu)
> > +                               break;
> 
> Instead of break it is better to continue here so that non-existent
> VCPUs are ignored.

You are right. I'll send the v2 patch later.

Jiakai

