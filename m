Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756681;
	b=Lp4u4DkllULuztEcLRNQF6nlXmLUhrrFq9fSSKapodW1KrdPCN8MpJmG2nmyU3WoFEGc
	 QR95DExcUH7WsFwUmAXFsXqK9SCLUI3KBf4wN2A0DIRBhukRbZdps5O7IkzVZ8TKLF/Id
	 u91ENq1egHuJvxXbDTSGpUWTLlHcinx2ndWX3hdZLbMJAXSAr/L6Q7rH25Rbwto61EMMR
	 JP0AfTuahM8n8kn5fb9YKxbbd/mDyvBsL9jnfjfjQ4ZvqICwrgZVF6DKs57s1IRlyoVNY
	 z9MGkBz0qoLzjHid0O6OxKKmo5pB1IjzTnqkLIRLwSEdAozKYmFmNANKznRO5waFqWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756681;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ouHno9MQwl9g9I7VXxGGEQRMBGY89m3oWexuYnMaLYg=;
	b=hleYVQ3xfDfleFJAKY2Ruw19NlAF/z7uq8EVCQu5CtQH3HV92p6BK5WTuPZNnQqLH4Wt
	 364lfQ7ebGwGBfQNWt5zWmlYHYILZO+uSDBG9tEsU5oPsh0+BmYt56dqMfBJrrblQ4fig
	 xjwRdLY+9pC4WrShWEO50BI3Xv45axLg3cNW07T5U417InUZbPQsP8W/zAepAZHCKmI2B
	 Y8HkknnOINS7h0G+cBqhNjRJcCZdqf7+qgSkQARYQ2+PF3HQt9dyDrHO69sDRxR3iaWmR
	 USm9RQcYcJR4sVtrxR+f9yiKA+DN3mxGzOCR6q3UOFqsIO2atdQ6dha8YDy6Qr1m5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NfrNZSom;
	arc=none smtp.remote-ip=91.218.175.90
Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097B606A31E
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8097B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NfrNZSom
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZidFtH1/LnObjsGNvMsrIN8j2jFRHd//7zJzoyuXcVg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792756678; v=1; x=1793361478;
 b=NfrNZSomapIGotMnzKQ141Ht8EqMJ7W3EZbPfPMNMiYjh/9bM26MPmLPaOm8MmwQClF71wJf
 MkBDifIoWcI80GYDyDYMxQYFiEBoNboJKcJBvTeZkfeKrkkQEpIKojg1R4Z+hS9N3OdZq3VqK2k
 ITnxZTYLpTFNFUlilk3r0uhU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a40efd914636a4c;
	Fri, 23 Oct 2026 11:57:58 +0000
X-Mizu-Trace-ID: 8a40efd914636a4c
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: anup@brainfault.org,
	atish.patra@linux.dev,
	tjytimi@163.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@linux.dev,
	pbonzini@redhat.com,
	seanjc@google.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on host-writable leaves
Date: Fri, 23 Oct 2026 19:57:47 +0800
Message-ID: <20261023115747.2545223-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017030927.345454-1-suunj1331@gmail.com>
References: <20261017030927.345454-1-suunj1331@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 17, 2026 at 12:09:26PM +0900, SeungJu Cheon wrote:
> +		/* Let the slow path handle host-side write protection and CoW. */
> +		if (!(pte_val(old_pte) & KVM_GSTAGE_PTE_HOST_WRITABLE)) {
> +			ret = false;
> +			break;
> +		}

Thanks for fixing this.
Tested on QEMU 10.2.1 with a private memfd mapping and dirty logging.
A guest read followed by a write corrupts the shared backing without
this fix; and with it, CoW occurs and the backing stays unchanged.

Reviewed-by: Jinyu Tang <jinyu.tang@linux.dev>

Thanks,
Jinyu
