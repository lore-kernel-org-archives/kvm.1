Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCF32B10A;
	Mon,  1 Jun 2026 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297526; cv=none; b=j7x+wmIw0Jw+1xwxbmKnF6LuBqVCgveAbniGZ7Ef5QhwVgTYLDLmRbDXJ7fzyofV2sM783wcJoCMFiUYBpnABSTpOeVvcpSGcUNsuNLfz4WxDKlsZRxl97+vQ/ve3LTv1C4IdcLi7S/P85l/UG2DVYcz9CvAsOn3f+Ck3RtZE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297526; c=relaxed/simple;
	bh=v5zATos3x5c6DyAdC6m5mPUcugo2RTE6XlHwneiDbC8=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=llw5tac4z+2JG7X8JGGj567nxF5xZiHK3DowVHEEP4RQDCNxlXoImJmf3x/POfMbMi6kko/2HI9syzD8dIOCgpERYITMm+nwcDla+9P6ATrGICLFdqcU6VSSEzI58c2YawMShK6gOFw7OKEb4uoUzX7yrIN21CJKApPNQtREsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gTQ2k5x09z57KTr;
	Mon, 01 Jun 2026 15:05:18 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl2.zte.com.cn with SMTP id 65175AlE087119;
	Mon, 1 Jun 2026 15:05:10 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp07[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 1 Jun 2026 15:05:12 +0800 (CST)
X-Zmail-TransId: 2b096a1d2f28ce9-70dc3
X-Mailer: Zmail v1.0
Message-ID: <20260601150512301NeokJXDe2YUikK2-C1yKG@zte.com.cn>
In-Reply-To: <CAAhSdy2qqpZ6qucwsuRZWnKgno03Ok4czv8RTgpjA73i+yFhng@mail.gmail.com>
References: 20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn,20260429173534386Dfz8RALJT73-jMfif0nSb@zte.com.cn,CAAhSdy2qqpZ6qucwsuRZWnKgno03Ok4czv8RTgpjA73i+yFhng@mail.gmail.com
Date: Mon, 1 Jun 2026 15:05:12 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IMKgW1BBVENIIHYyIDIvM10gUklTQy1WOiBLVk06IGFkZCB0cmFjZXBvaW50cyBmb3IgZ3Vlc3QgcGFnZSBmYXVsdHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 65175AlE087119
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 01 Jun 2026 15:05:18 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1D2F2E.001/4gTQ2k5x09z57KTr

> > From: Wang Yechao <wang.yechao255@zte.com.cn>
> >
> >
> > Add the kvm_page_fault event tracepoints to count the number of KVM
> >
> > guest page faults.
> >
> >
> > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> 
> Lot of redundant newlines in this patch. Looks like this patch
> was not sent using "git send-email".
> 
Sorry for the messy formatting. I'll resend the patch properly with git send-email
in the next version.

Best regards,
Yechao

> Regards,
> Anup
