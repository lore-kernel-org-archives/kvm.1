Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544397;
	b=jYQB5RlP2/TYE+jULsQ6n2ZzEJC0I3UfCA6m/jrBu7vA/pB0JLoMlJDb3McZV6j7/PjO
	 mhuIPu9PGBgoGyRAEZYBYQek0dYpWdGskBizQihA5mo398L64RJ8AN5RmvueaMci4m118
	 HZzsnggpCsLhCYV49oK1t0+BtScsZOKSmD4ZJ0m3/R6J00wnvm+bvyar8gpKV2SjZOxnR
	 uyMNvzM9OXoqy+dgEtFeemCtQURRnW3omPVCuwrYqyPZGd45jZ1GbGeiy7OXFV5LndUAj
	 PXGRUU+JiiXsRVY7LSPl9yvLZF+RZsX6qM5ANvZf+zRIHP5jKLP9+wKpKqX1ycRw95Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544397;
	h=DMARC-Filter:Received:Received:Message-Id:Received:Received:
	 X-Zmail-TransId:X-Mailer:Date:Mime-Version:From:To:Cc:Subject:
	 Content-Type:X-MAIL:X-MSS:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=PXHozQagEJBA1ns8T90M1EXOSvUI54qTtRszB1T9xqU=;
	b=FZpYfxKV/BI0Gn+V2iZE9W0f1vP2f3y92xnhtPxHXj+pd8p+2LfX8lEpc5SrQ8JaQ7Jw
	 CR8cIjob+QyxDGSj732J8Q/WDdJIc7nc1bX2sD42H559U+mE7iSVDKAl0+2nzCLiXhNQN
	 Y9YZ3RrEpxOUJ5xMuWbktucMnbiy28CH5xKuJRD+BzxcahxoKUzhCvRU1A/L3yGKityoO
	 9Yx/Pmn7FCYK12+ORSd7Mxr1jc60BR02y122mnd7sRfkIDiX18Y99Hu3be0yaXjBGnBlR
	 urXYUCQ3Kp+NIKF8lVWiBQfR6c99kgK7McfVOl7idT80/nj7MAwthKN9W0Xs2rnr0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9C606A31C
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 00:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD9C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j8WCY38Kjz5BNS0;
	Wed, 21 Oct 2026 08:59:53 +0800 (CST)
Received: (from root@localhost)
	by mse-fl1.zte.com.cn id 69L0xqLO033882;
	Wed, 21 Oct 2026 08:59:52 +0800 (+08)
	(envelope-from ye.zhihao1@zte.com.cn)
Message-Id: <202610210059.69L0xqLO033882@mse-fl1.zte.com.cn>
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 69KBdBD4088046;
	Tue, 20 Oct 2026 19:39:11 +0800 (+08)
	(envelope-from ye.zhihao1@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid12;
	Tue, 20 Oct 2026 19:39:13 +0800 (CST)
X-Zmail-TransId: 2b036ad752e1cc2-4bbb4
X-Mailer: Zmail v1.0
Date: Tue, 20 Oct 2026 19:39:13 +0800 (CST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <ye.zhihao1@zte.com.cn>
To: <atishp@rivosinc.com>
Cc: <eric.lin@sifive.com>, <will@kernel.org>, <kvm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <mark.rutland@arm.com>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <sergey.matyukevich@syntacore.com>, <kvm-riscv@lists.infradead.org>,
        <guoren@kernel.org>, <ajones@ventanamicro.com>, <anup@brainfault.org>
Subject: =?UTF-8?B?UmU6ICBbUEFUQ0ggdjIgMDgvMTFdIFJJU0MtVjogS1ZNOiBEaXNhYmxlIGFsbCBocG1jb3VudGVyIGFjY2VzcyBmb3IgVlMvVlUgbW9kZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69L0xqLO033882
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: ye.zhihao1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 21 Oct 2026 08:59:53 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD80E89.001/4j8WCY38Kjz5BNS0

Questions on KVM PMU Counter Numbering, Hcounteren Setting, and Migration/Conflict Handling

Dear Atish Patra,

I noticed your relevant patches and comments regarding the KVM module in your virtualization work. During my virtualization validation, I have the following questions:

I found that the hardware counter numbers actually used on the host are inconsistent with the virtualized numbers returned after KVM emulation. Is this because you want to ensure that the VM can work properly in migration scenarios and avoid the conflict scenario where the host and guest count simultaneously on the same CPU and share the same hardware counter? Also, why are all virtualized events disguised as sampling events? Is it because SBI PMU does not support the passing of this flag, so KVM cannot distinguish between stat and record events?

In addition, I noticed that in your main.c, Hcounteren is set to 0x02. Is this also because there is no correlation between the logical hardware counters and the virtual counters? Have you considered enabling Hcounteren to reduce the overhead caused by CSR traps? In KVM, is it mandatory to modify the logical hardware counter numbers and the virtual counter numbers so that they match and are consistent, and would it be necessary to reconsider how to solve the migration and conflict issues encountered in the previous scenarios?

Best regards,
ZHIHAO YE
