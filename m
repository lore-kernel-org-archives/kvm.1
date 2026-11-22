Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348713;
	b=wABgHNEwEzXBboYbwIKC3ex/w20P5JwjUeX2Qx3KoTavSEujoFpLaMzfLtP/qDl13w9V
	 sfOv7EzCqAjgTRFW61mDjiB118uaXA1mWftTUO25+vMKKpX9q/U4QU3SOZh2Dluryvg7Q
	 WG1I2UiRTbL31f03mnA0onWXuFcyD4q1+VudkwtPN+DiEnkDQdzGdcoqfgRZYvImVq4sQ
	 1goPNFxyfnbAVe5Ct4aF+l6zBBa9hLphEogu8Xr0vavr323jQhUfctDkUMntva/0m0nqB
	 dn2TTumZp9fDmY6sSj0FnL+XwlOm36hJ6W9Z3j7wmiJhjeG9PNSJs8PBVMnkQTxxoGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348713;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z9K9IZBt5MAY684Cqjn2Izqd4gS3HamCoT0TbCByh+g=;
	b=ye/aY8dYcVjFStuhclfTX/ioTYlIktT8FO6c5It+/we7MKJiEO6EbSAOh150R88tjCia
	 +Oiu3ghkDU619Kfx1L/98cw/n/lsl5DvAS/NOm3gj4gXoyj6UaDxhBmF/JWTRTaBR6+1B
	 7CqIaEOOsPofbxROd76yEcxToVIxDjThGgOqQtR5I/6EyprtJ9BwZV3elvgkArnMwfscq
	 9Xjgs2e2/vVQycDOJVROWKvY0AwZkV76EuhgCqt2kYLdt33DlT9XCBJIfz8GxTvTskjVF
	 g7ezHjdSsIxpwRJnp7shQVDMKvF/UPLWatcHEHtAQrNG47GtosZGB4qnYgLuIcBMteQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YbGWDTbk;
	arc=none smtp.remote-ip=91.218.175.12
Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD59606A320
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 11:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD59606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YbGWDTbk
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GX6LAbg/e50bucZW+XNw4XX6G67RFU3kH3Pv9OsHvu0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795348709; v=1; x=1795953509;
 b=YbGWDTbkOCijWwbs3t5GPdmyVv24aG8wNGRrCs/EWCGkMHD9ExPWZNOo1M0yQIJrfzx6CWsi
 zJ1xryC8AJlrIOLB1MOx7AKos1sVB+Zg+dFrj9gWfN1oGv96Jm7Q2V8UwRPNiK8QEB1zL96mqwL
 svEtjP65v4bR7X0jdgo1HXjg=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e1cc464e81a4892c;
	Sun, 22 Nov 2026 11:58:29 +0000
X-Mizu-Trace-ID: e1cc464e81a4892c
X-Migadu-Flow: FLOW_OUT
Date: Sun, 22 Nov 2026 12:57:54 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Koichiro Den <den@valinux.co.jp>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Bingyu Xian <shanbeeyoo@gmail.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] RISC-V: KVM: Order writes to the SBI STA shared
 structure
Message-ID: <awLYsnfgGQqNnL7q@orel>
References: <20261121173526.892344-1-den@valinux.co.jp>
 <20261121173526.892344-2-den@valinux.co.jp>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121173526.892344-2-den@valinux.co.jp>

On Sun, Nov 22, 2026 at 02:35:24AM +0900, Koichiro Den wrote:
> The guest checks the sequence before and after reading steal time. If
> the final even sequence becomes visible before the updated steal time,
> the guest can accept a stale value. CSR accesses are weakly ordered;
> toggling sstatus.SUM in get_user() and put_user() does not guarantee
> that the guest observes those stores in order.
> 
> Pair the read barriers in pv_time_steal_clock() with write barriers.
> 
> Fixes: e9f12b5fff8a ("RISC-V: KVM: Implement SBI STA extension")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v1:
>   - New patch. Split the write barriers out of v1 patch #1 into a
>     separate fix. (Andrew)
> 
>  arch/riscv/kvm/vcpu_sbi_sta.c | 5 +++++
>  1 file changed, 5 insertions(+)
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
