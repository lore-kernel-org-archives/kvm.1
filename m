Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470549;
	b=dWDRS+2LQGc9LNuRvgKijPY7H4y3btlX77XIIpC2Sfe4qYSmclGz6T9cqBAZE5XQ6DUl
	 TfiT2EIG7Nd8g1zKXQky+kWNJtNfLXEF0ZQQgGLSquqN2ZY9n/QVD/1+J01JbETwOxI3+
	 U/zHrMXxtB1yjjYZJXfDlXGB4W1rClNhDy+TnhC4MXnqE1ejyuFBW0TkA8eqIf3zy4VcO
	 M70zk4WooCh7/APoICH2QDy9becP+1HyNTD0TsP/BIF32y5WSRAUrdXGV0zxue2RlW8+z
	 VSXquMy8bOgRS1ZZOOMiKy8e9agIPrO3mEwCtDII75ZY8aBElx6pWtULTATsgpj/V8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470549;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
	b=4sfaHOijkIzJlaWu4UTSfwDOKrE9EGbK4MPLt6WADdk/juNUdmi7+3NILTJprvydQp55
	 3kyCqPVpIpEv82cqrfyWxTO3xpTW8EpjmDvsKWDeYqzkiPCPg0fuKtt70G4mIkGVmM89e
	 Sk7k/+NuOw6stPFDRMSMXLokvqyeJiPJsvqC+LI7hxSwBIzGJfVhAZK0EnYEEGtN5m9Cd
	 808IK6/fIarksDwVmGSwCIxvz9zQS201qpIg1mhxLGnwgnKTWqdqhEK7vkfx6KcL3JVdS
	 Z5Suc+5nZQ+k3j9sofq+RnosAcbpibaJ2kvA/OLCFpgsSIvJZHiybUPMA0PL/A+gscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIAM12Ao;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="H/fq+Ykn";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F784606A31E
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 18:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F784606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIAM12Ao;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=H/fq+Ykn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793470547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
	b=SIAM12AolSq6pTkL141wKgFIS/iF3deL2c3a2tQ5ExQ7nw2lBKmzMbRv7ikb1UZ3CWPo7y
	nApaKKJLMKYkLGv/xEKs8mdJXUqEdhuoajglzgiVVF2f9x+NrBzacxbDuagmB+WOyh66RI
	pqwr577MZwTtT2Nioe6QlS0Az3luPJo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-lqga2DpFPL-HkMfqj-5cWA-1; Sat, 31 Oct 2026 14:15:45 -0400
X-MC-Unique: lqga2DpFPL-HkMfqj-5cWA-1
X-Mimecast-MFC-AGG-ID: lqga2DpFPL-HkMfqj-5cWA_1793470545
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dff112181so1514118f8f.3
        for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793470545; x=1794075345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
        b=H/fq+Ykn4OXvibmZ58WSymPH6UkvtK1toNLmfG9r7MHqEuGHzGt0A9ihKTFdMqNtlk
         YDRv1FERKM2oU5FWRr17AhGkbTcViLFILRYTnz2NxuUJqpnvbBL5Pfzm3nxluOBozULg
         IzVt9RaX6KRRqmvWhNmfGrnDYzRlSs6MrU9VyeEweL91zR0TZByaJQiPILB1r7e5TdKc
         7KRPrCNbJPgCi0Ng0pxNBh0v7VU4PcwyTnKM6KmVOsCj5/2gcQyENkZWptsRZhv2QVt9
         WK7nYhlkE6QQcUslLMMBUCcTfFltq8wTNPC98Ak2pfkh5B7aS+BS1XYMZHje1/Nw2rQ+
         Q9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793470545; x=1794075345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
        b=h3QAk8zn4ntApW4Trs4wIqzAzQRgjRkkQPHtQDO4ZPJhUkkRRsHwq+RUARZfgkawYp
         4aZxK/03GJHaA9h0gvOeCG4H+eD2QUZJ/Iq3irQixMvXkRtzBoqHEYNMZ+aLZ0t2mhMj
         xCh28l4l9jz8o8MBauV5nh5vnrwOQHcBc8cSFNlS7H9OaZsfR5D+cERZLRcc1rcSgv4u
         GWagxaGwciN6Rnrb/PuP65LroxCR5Ym0HqPPozA5+G6PQbR3cCeQmozC/gwR/ACD3Kfy
         khMUPsXdJQ0MwmWSrTXOHqYg78rkSKaGc9RIIgg1IbYJ4Wbat48rMOLmYkqSMc5CnxYd
         nVzw==
X-Forwarded-Encrypted: i=1; AKwUvBy36EnaNlFHqP0U2KysX07OLOzAyzgfwMPC9aaEwzZwFWYzFqDUhRVh6wtIogpZChHCmYM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnIRuQOLovC5Su4SXQGGWV/YQekPvQiJec1LA3BmKHm0pca0rR
	Xsb+vbIi2zxaV94Fbadh1F1WfauOZoSaUCf783XE9/DtiF7iYGnUMoFgTvWmpM+tdWNJ9v8qwYX
	46msL0If8CcJPmcQ4PnhF8GPjzzRJBYRJsjWG8grLK1JHVDYjmlyeGg==
X-Gm-Gg: AYBFou1h+FMah6y+tczWWacvGgeCOoJJqxbFxAG5NFvdWNRpa9DELEjG68VMBBz2xCc
	p+U1DV1JaX99C7QQ8dqLDyPy1m4Gc2edpOjEl9u9MLwOnl9FUVPdUaVEWBoLOakIYbD6lyto424
	fXeTdhmwsWLzN7sTBgLC0ecD0ZAFTCdzhZPU1CoppH0Q7clNwsEisNOBkekfQodEF1xhIQqG1xR
	g8cEyDabV7FpGuzjHiRG7G/WfUWXO89WO8SfNptB4C0acygZ/6e6WyvFbfWOwHnI8cCYTensnw6
	G8uwALl8lZoo4ZCIsTaXATjlltmwDiJJjEWc3OJaTTOuaKdhai01/FevGQpQKAh4lmtWHk1/nvW
	/cVFg6P20QNkvsECObb9VqQiIUU4y7i02pQInW3Mm7Gns
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4ac17d19777mr127328215e9.28.1793470544598;
        Sat, 31 Oct 2026 11:15:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4ac17d19777mr127327715e9.28.1793470543790;
        Sat, 31 Oct 2026 11:15:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm210425925e9.1.2026.10.31.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:15:43 -0700 (PDT)
Date: Sat, 31 Oct 2026 14:15:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	linux-mmc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost_task: do the return-to-userspace work between work
 items
Message-ID: <20261031141506-mutt-send-email-mst@kernel.org>
References: <20261031181004.4193627-1-shakeel.butt@linux.dev>
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
In-Reply-To: <20261031181004.4193627-1-shakeel.butt@linux.dev>

On Sat, Oct 31, 2026 at 11:10:04AM -0700, Shakeel Butt wrote:
> A vhost task is a user worker: a thread of a user process that runs only
> kernel code. It never returns to userspace, so it never runs the work
> that is queued for the way back. resume_user_mode_work() does that work
> when TIF_NOTIFY_RESUME is set. For a vhost task this means:
> 
> - memory.high is handled at the wrong time. When a charge goes over
>   memory.high, the task counts the pages, and should reclaim, and sleep
>   if needed, on its way back to userspace. A vhost task only reclaims
>   when more than a batch of pages has built up and the charge can block.
>   Then it reclaims and sleeps in the middle of the charge, maybe while
>   it holds a lock. vhost-scsi, for example, can fault in guest memory
>   while it holds vq->mutex. If the charges can't block, nothing is done
>   at all, and the count keeps growing.
> 
> - Block cgroup throttling never runs. blkcg_schedule_throttle() asks for
>   it, but only resume_user_mode_work() acts on it.
> 
> - Task work queued with TWA_RESUME, like a deferred fput() or a NUMA
>   balancing scan, waits until the task gets a signal or exits.
> 
> io_uring workers had the same problem, and io_run_task_work() calls
> resume_user_mode_work() for them. Do the same in vhost_task_fn(): if
> TIF_NOTIFY_RESUME is set, call resume_user_mode_work() at the top of the
> loop. That is between work items, no locks are held there, and the task
> is running. Passing a NULL regs is fine, io_uring and KVM already do it.
> 
> This covers every user of vhost_task_create(): the vhost workers and
> KVM's NX huge page recovery thread.
> 
> Tested in a VM with a version of tools/virtio/vhost_net_test that puts
> each RX buffer on a new page, so the vhost worker faults in, and
> charges, 256M while its cgroup has memory.high=64M. Before, all 285
> calls to __mem_cgroup_handle_over_high() came from try_charge_memcg(),
> inside handle_rx() with vq->mutex held. After, all 589 came from
> vhost_task_fn(). memory.peak stayed at 64M, and the run took about the
> same time (0.66s before, 0.67s after). A lockdep kernel showed no
> warnings.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Is this different from:

Message-ID: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>


> ---
>  kernel/vhost_task.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 3717885a5992..f0ab21aa2a1c 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -7,6 +7,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/vhost_task.h>
>  #include <linux/sched/signal.h>
> +#include <linux/resume_user_mode.h>
>  
>  enum vhost_task_flags {
>  	VHOST_TASK_FLAGS_STOP,
> @@ -38,6 +39,14 @@ static int vhost_task_fn(void *data)
>  				break;
>  		}
>  
> +		/*
> +		 * A vhost task never returns to userspace. Do the work that
> +		 * would run on the way back, like memory.high reclaim, here
> +		 * between work items, while no locks are held.
> +		 */
> +		if (test_thread_flag(TIF_NOTIFY_RESUME))
> +			resume_user_mode_work(NULL);
> +
>  		/* mb paired w/ vhost_task_stop */
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> -- 
> 2.53.0-Meta

