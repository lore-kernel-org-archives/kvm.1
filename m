Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68F363C74;
	Fri, 31 Jul 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478699; cv=none; b=hs4JJ2LwL2/5s5V6+YhdI1G1OK7rGaj0GxZ2Fc2pueVnO10Y8h9oflBDju/0EVHKn+n647LmEHLbLD8auKrsB+7sE0hQlRBZhL6kZlCzSw3VFa+fMcQHsKkFca9GJgT1pt4iNZAkwUsRlwgh9ansjo3n6JMP7d667QY5SNR4H6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478699; c=relaxed/simple;
	bh=zjeon/Kaips5jmPFYgLK4A3ds0kAVcvd3U06TABiPGA=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=iGMdNUlA21bw24Io3yI5FB41/s+gKogFNKiS0V7tu/SXTfVfXG7bB/eyp+bK0gLxk1X0yl9d6wew08BmxspFi2Hp+yB9FFu9X4rPDs1SCzW68WCQoFHlHbL36KsUh46pDZ5WGP8+XoDzDtp/Wo3Cv3a66kzceL1Q+3rM+Ji3/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hBG8j3Bc7z8Xrkn;
	Fri, 31 Jul 2026 14:18:13 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl2.zte.com.cn with SMTP id 66V6I0Io068098;
	Fri, 31 Jul 2026 14:18:00 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid12;
	Fri, 31 Jul 2026 14:18:01 +0800 (CST)
X-Zmail-TransId: 2b056a6c3e19e16-710d0
X-Mailer: Zmail v1.0
Message-ID: <20260731141801793hQfTkkNj5hVzU1qUKbRQY@zte.com.cn>
In-Reply-To: <CAAhSdy3bBQTwj80cmBvWYfqWgO1e8_Y85x=QG46UamGEbYy+UQ@mail.gmail.com>
References: 20260707125034.416521-1-wang.yechao255@zte.com.cn,CAAhSdy3bBQTwj80cmBvWYfqWgO1e8_Y85x=QG46UamGEbYy+UQ@mail.gmail.com
Date: Fri, 31 Jul 2026 14:18:01 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atish.patra@linux.dev>, <alex@ghiti.fr>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAwLzJdIFJJU0MtVjogS1ZNOiBPcHRpbWl6ZSBoZmVuY2UgcmVxdWVzdCBoYW5kbGluZyBmb3IgU01QIGd1ZXN0cw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66V6I0Io068098
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 31 Jul 2026 14:18:13 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6C3E25.000/4hBG8j3Bc7z8Xrkn

> >
> > This series improves the hfence request handling in RISC-V KVM,
> > targeting scenarios where multiple VCPUs are running an SMP guest.
> >
> > The first patch Introduce make_xfence_request_nodata for FENCE.I
> > requests and moves the hfence data/type validation out of the
> > VCPU loop to avoid redundant checks on every iteration.
> >
> > The second patch fixes a more subtle performance issue: when one
> > VCPU's hfence queue becomes full and triggers a fallback, the
> > current code applies the fallback to all VCPUs indiscriminately.
> > This unnecessarily degrades healthy VCPUs and can cause their
> > queues to fill up prematurely due to lack of processing it.
> >
> > With these changes, fallback is applied only to the VCPUs that
> > actually need it, preserving the efficiency of the normal path
> > for others.
> >
> > Changes in v2:
> >  - Fix the patch01 broken the KVM_REQ_FENCE_I request(Sashiko AI review).
> >
> >  - Link to v1:
> >  https://lore.kernel.org/linux-riscv/20260707113715.413265-1-wang.yechao255@zte.com.cn/
> >
> > Wang Yechao (2):
> >   RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
> >   RISC-V: KVM: Separate req and fallback_req masks in
> >     make_xfence_request
> >
> >  arch/riscv/kvm/tlb.c | 46 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> >
> > --
> > 2.43.5
> >
>
> The PATCH2 is a fix independent of PATCH1 so re-order
> and make PATCH2 as first patch which can be applied
> independent of PATCH1
>
> Regards,
> Anup

Thanks for the review.  I will reorder the patches in v3 so that PATCH2 comes first.

Regards,
Yechao
