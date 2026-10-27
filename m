Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102650;
	b=ZW7QaxN4ryd/UN+mjz7i10fWNWcaZf+b9+jk/u32BC1ugcf/hfK8GzRNSitjUcnCIpsD
	 BLu1rPMjHpL0kDawm3hj1pjKQNo9QaUiHFACTaN8f2Gauc9DxBSXAvqtzBSzGweNuGilu
	 0shUhoXzNx83YNv+zdAMhYAncoxu3c4mBxPL4D4wIa5u6bX5rDRbrYccMNGOcBTtDt+Zu
	 oRAfkwdFMZz3L13EkJuwJ2g2MLvSmof6Gy5R2bVqEcJcuRaNg208ZS0GwM3w7QIs6TyP/
	 LIhh5v61Vgsff+zfWoqhxWvqvFKcNJI28/9l/hJe/ns0CNtTTLceOJazLMs7e8etzYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102650;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-ZMAIL-USEORIGINALEMLTOOUTBOUND:X-Zmail-RealSender:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ZzyR8X29omZLH3YyVdjMxtsYeVFid5qZY3hkmqVGFGM=;
	b=FZoo/sX+1eC2SDsY3BErKXBXjMk0XVIhiS05QKEoCSeQJizfRjuUm3lpfDSy1xSTg5iY
	 Ruu2omBKApKvCe0D9DR6rH1HBaj/tDWkePPd1UwttSCvU0ximDQ9KpUNxbBeIvIMOBx/D
	 EeruRbilItcZ8pIt+Xnr5UWLNDopBDGBdqpJ2AYHpJd9THfyrkp+4i/0p3U9AgaEFrlaj
	 tZgM4PQSn0UMfDwh9oRzZskDW7IUZZR42Nr5Rb1PmI850VhGs7I1IZVpOkUuX6B33UZU/
	 oMUtet40cI9a4rSzQZDKthDseLwZzJJidTITAmjgJUwwT6+bc1LIuSsdxYudFv2IXjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591760A5BE5;
	Tue, 27 Oct 2026 12:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5591760A5BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jDTg55wlQz4yjjH;
	Tue, 27 Oct 2026 20:04:01 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 69RC3m9W064832;
	Tue, 27 Oct 2026 20:03:48 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 27 Oct 2026 20:03:51 +0800
X-Zmail-TransId: 3e816ae09326027-71f2f
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: sashiko-bot@kernel.org
Cc: Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev,
        wang.yechao255@zte.com.cn
Subject: Re: [PATCH] RISC-V: KVM: Fix out-of-bounds index into aia_irq2bitpos[]
Date: Tue, 27 Oct 2026 20:02:08 +0800
Message-ID: <20261027120216.700844-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <sashiko-outbox-186480@kernel.org>
References: <sashiko-outbox-186480@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 69RC3m9W064832
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 27 Oct 2026 20:04:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE09331.000/4jDTg55wlQz4yjjH


> [Severity: Medium]
> Can irq actually reach 64..67 in aia_get_iprio8() or aia_set_iprio8()?
> 
> Both helpers are static and only called from aia_rmw_iprio() via
> kvm_riscv_vcpu_aia_rmw_ireg() when isel is between ISELECT_IPRIO0 (0x30) and
> ISELECT_IPRIO15 (0x3f).
> 
> In arch/riscv/kvm/aia.c, aia_rmw_iprio() rejects odd isel values on RV64
> before computing first_irq:
> 
> arch/riscv/kvm/aia.c:aia_rmw_iprio() {
> #ifndef CONFIG_32BIT
>     if (isel & 0x1)
>         return KVM_INSN_ILLEGAL_TRAP;
> #endif
> 
>     nirqs = 4 * (BITS_PER_LONG / 32);
>     first_irq = (isel - ISELECT_IPRIO0) * 4;
>     ...
> }
> 
> Because ISELECT_IPRIO15 (0x3f) is odd, it returns KVM_INSN_ILLEGAL_TRAP on
> RV64. The largest even isel reaching the loop on RV64 is ISELECT_IPRIO14
> (0x3e), which gives first_irq = (0x3e - 0x30) * 4 = 56 and nirqs = 8, so
> first_irq + i is at most 56 + 7 = 63. On RV32, isel can be ISELECT_IPRIO15
> (0x3f), which gives first_irq = 60 and nirqs = 4, so first_irq + i is also
> at most 60 + 3 = 63.
> 
> Since ARRAY_SIZE(aia_irq2bitpos) is 64, isn't irq already guaranteed to be
> in 0..63, making these bounds checks unreachable?

Right,

I missed the odd-isel check in aia_rmw_iprio(). 
Please drop this patch. 

Thanks,
Yechao
