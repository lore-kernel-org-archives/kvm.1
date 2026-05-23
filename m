Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7184C92;
	Sat, 23 May 2026 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499983; cv=none; b=HF2ywHG3vSwf5oWIgBt+inbIM18oZeWl0VHKlBs82SEFm7lB7Qacs3lx/yh8kvyEy0yIDf95gQaGNf59zcFZJkyzSsp1qM3osdmaJC5gOOe24IWNChwKanSoGO4/TuFBlvcIZeND2HQmRVGY5fGLGOLIPGtQw8yru/YbFBniyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499983; c=relaxed/simple;
	bh=USzteu6vxSfeGsmy9qldgN8ockyYHMmZQR8ZFyAitpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbyGZeUq/t9asERDjQ8yyCRKaQ0W29fUDKX42Hmaez/JbpDN9kXbS0qHNeNADcJ8Jlh8qu5w+7lJruWzz4EeL1J9J6kpg+z/Lct9g7gMFjtG3bh4r/YMsz7gTDpuyualIXMQpa5/Y25gcsiBfn4XcnHxPU5agNk/WkkA2x1/eGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3UNewAxFqKen_EQ--.44375S2;
	Sat, 23 May 2026 09:32:32 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: andrew.jones@oss.qualcomm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	anup@brainfault.org,
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
Subject: Re: [PATCH] RISC-V: KVM: Fix TOCTOU race in SBI system suspend handler
Date: Sat, 23 May 2026 01:32:32 +0000
Message-Id: <20260523013232.2352161-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <rqpv3mrcsxxdlaedbckb26bf5vfkj3xgd6m26me24nf4tbcqtb@jh62r2df3ur7>
References: <rqpv3mrcsxxdlaedbckb26bf5vfkj3xgd6m26me24nf4tbcqtb@jh62r2df3ur7>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3UNewAxFqKen_EQ--.44375S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY_7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
	jI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUOlksUUUUU
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAUPCWoQSVgglQABsQ

> But... before we get too carried away. Unless I'm missing something, this
> race really looks too theoretical to justify any change at all. Do you
> have a test case in mind that could force it?

Unfortunately, I don't have a reproducer or test case that can reliably
trigger this race. 

But as we saw earlier, this is a real bug, and we can tell that just by 
analyzing the code.

The real environment is complex and unpredictable, and such races are 
possible. Wouldn't it be nice if we found it and fixed it now?

Regards,
Jiakai

