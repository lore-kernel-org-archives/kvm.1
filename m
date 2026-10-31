Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473552;
	b=dqQhvRnvs00Q9HR464WnThtgY42ZtOszSELsRgdBC8gOTUHy6Ri5waESAakjcOsGaO30
	 TLPa2ZIXp7nsGwLh6xZTgC4roZMZ+kHCdWw63/XpVp/QJmqhviFOkvb7tvshv4q/icF6F
	 BRrCLUOYD8c8sKHZJE+bqQJumr0BfqS1l5+634gVdkYz0SE7eImoKmEeYrkQ8h0B3jAa6
	 VCvEfWhy8IhyW8aXKL7SOZZ24qtUwbwVWkHtD+YyXB1GLZQlzhfcAT8GgEyd++xqs7RaZ
	 zJs7AmEOpeIAG7hLPSh4nINT+8D/1mCWZ2HNC2xTBiSSBaPCQ0gyr9scZi2hLLubaGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473552;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gF9FP3okBGaulujfi92bns4Xp8Ex+d3QT0+PXv65Qbc=;
	b=sFxxweXV8DksoPDRAH03XgwfX5a4uV1rQm5Vc2h0suAfvIgRoFhSNIJIfqz4vCrg8yYL
	 TE9eatcj1+pVFA4DGWhmxtyOHO4TlRBRwQpcO+OCZ5AveP3b4tMQmAPRKpjSFy2/ohZP6
	 QbaDTrjNGcL9YW3NmAa9OhKg+9+EK9STDAJG2ExS2MmzF24hdt++2FBBSrTZXtDg10YPL
	 uefy7wjdX3Y8oAlsthn9mPN1ZtB7/g5V9Z6f04GEOrM4gGABv3JqKkhEzzuxBNapDRUTc
	 HjdQdy0WpZnFshBVu0K9lNlKd9zUc/ua31KkWkhr6/OvZc/pJ7L5OYbZ/aLyyPg3D+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L+kUzswU;
	arc=none smtp.remote-ip=91.218.175.123
Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864EC606A31C
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 19:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L+kUzswU
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CbfwumJvnyRc/dDe61N2E5Z8vQbZC6EGlE3DNJg/ZIY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793473548; v=1; x=1794078348;
 b=L+kUzswUjTbrCAF3gBbUSurdKdsKj8MZEDq3pv1MtmxPfnmkV6eaP7fpicoaaCg99i7IM0+4
 7sw4Vg89mBBHSl+qpwa5wyK2IaKINMjmI/qcBAaEpIdAZSjndcegit7olkOzgokYC3dsc1jAwIQ
 F0jRYA0WvxGfcvP7innvIAF8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 801ab3a65b468602;
	Sat, 31 Oct 2026 19:05:48 +0000
X-Mizu-Trace-ID: 801ab3a65b468602
X-Migadu-Flow: FLOW_OUT
Date: Sat, 31 Oct 2026 12:05:43 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Aaron Lu <ziqianlu@bytedance.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Message-ID: <auY6zHDao6R6bFNz@linux.dev>
References: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
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
In-Reply-To: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Oct 31, 2026 at 01:33:13AM +0000, Aamir Ahmed wrote:
> Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
> model"), a throttled task is only dequeued when TWA_RESUME task_work
> runs on its way back to user mode.
> 
> vhost workers never return to user mode, and vhost_task_fn() only runs
> task_work via get_signal() when a signal is pending. A busy vhost worker
> therefore ignores its cgroup's cpu.max, while its runtime is still
> charged to the group, throttling the group's other tasks (typically the
> VM's vCPUs) harder.
> 
> Run pending notify-resume work at the top of the worker loop, as io-wq
> does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
> generic xfer to guest work function") fixed the same problem for KVM.
> 
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Cc: stable@vger.kernel.org # 6.18+
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

I have this (almost) same patch but for different reasons i.e. memory.high and
block throtlling. 

http://lore.kernel.org/20261031181004.4193627-1-shakeel.butt@linux.dev

If you don't mind, can you update the commit message to also include that it
will fix memory.high and cgroup block throttling as well?

You can add:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: Shakeel Butt <shakeel.butt@linux.dev>


BTW there is a similar issue with io_uring SQPOLL thread which I am fixing
(testing at the moment), you might be interested.

thanks,
Shakeel
