Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33744CAF5
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626418; cv=none; b=ZhqtfAgNm7fIBvuPU+xo/0KJVsvenLqUCGfiTpJ9w4ciRP4sJU7hy9/9yRcBx5SfNeTc/XVbjQVwo4iEJu7wlMeBqEcaxoqLdqFyScoKSJayJiTFPRpJV3/GFhL59QoS8eXqc8C+KFdWasVb36Nl8d+C9SxERYReJlO6bfZAuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626418; c=relaxed/simple;
	bh=I6hDshcql7hu2jZUKkXZROC4LwQYUnvoGKyBIzxyt6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6GkTWxEq3JGfD9JCbSNF3g4C/LweABwQ4PTkUVSK0jLZntUCmZdYWcVLeBmliSDP+VoAnnxIvx4Qy1SW2SPtCdggml9fddCzI3stB+IHUC7O7Vph+Fjbleu7Prq4UWLDUyIHT/3Z4b8rOwSvVEzVaR9n+ovzbE4W1klzv9QTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbQvVnK5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOMP4+Xq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbQvVnK5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOMP4+Xq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781626416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
	b=AbQvVnK5cY2LTlymMYQeFgYoMgDAkKyiwR4aqbjmZaOpioJBcwqy8AcPTho4ijC0kA5mYO
	mmd6oFdmMhe5od/qYkhAaQtqsGC1hjbkiMGgifmuT+xs3uyCk4F069MQWedlrtXue3y988
	LbRsAG9JpSCl6wzOzheh4ctawxzcSI4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-etQ9yKjSOYGE6IvhqBJQVg-1; Tue, 16 Jun 2026 12:13:34 -0400
X-MC-Unique: etQ9yKjSOYGE6IvhqBJQVg-1
X-Mimecast-MFC-AGG-ID: etQ9yKjSOYGE6IvhqBJQVg_1781626414
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef4931de5so7296f8f.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781626413; x=1782231213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
        b=JOMP4+Xqppz7SBR63V9fZVBS6J3VxD32DpcR2+8areH2Z1zYuTS4w2hbgxE5V3ebxc
         AvrWAtrF0hN6Xt6uoy+AyBxriFJwSNYP8arO56Bg71tJfotuVCLLVdIHa7Hp9tKO0R2C
         ra/xYA0PFXZrN069fi0+r/mrhIf0hZpf7mx4pdrP9o3njN1jGCjDsR/AFLBwrcdTRpFG
         SomjjSIfsEAg8PMcPqEu5qzS/Az7v5vz5DZBN4nuu3mXjRtNbfuubjhhdMu0qrTTAd1S
         9aK0LuuYm5eKIZzDBNDGUlQRZoTu6okTIi9LNRPlACVdhqlDgJvHyoHVnOBtfEVRP8/q
         dklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626413; x=1782231213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
        b=OtcxyuyTAbxmcq/ZbViofC1UzIYSHMr5cH4i+LnIr+S2O6MiZsUFpNmyoIFXWY7u9P
         Vwhvejsz3MvTQUSDFukHEJ4ZHeu/PQy5Pfs7zm+Ye3apsTq9wbQkXd6kZKPHsh8tCEK0
         MJr76pOyRsYvMbatE+eoVHdD5rA4BKqYMfg7NDeNPG2seS5Med93/bvDGDK6/UUN/xNL
         /hfUTxOtUnZflYnwcU8yu/sSRTXK7eAMXQKLkdsZpAgh94bqcS65xdiChcXzBplERgwS
         6n3wEblJkwrD/XBYB7RLPHeTx7l7kwYs/0bgtq41nFUmO6ErEZhgp5371Fp4lJJ45ls7
         4HTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s0wBo1oZ71FggqYR8rLaMRHaZWmHRygMdd+iJ+JpiG/kDF8KD2vfGUt8pUzhu+s+iJ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lHJ2FzgsbLWsJ5/wWeJbg3eGaQBVACSkiPJ3c0sc787ng1H/
	7y9mUdz3MByIR258zRTJczEfoxSkDf/6293hdwykN3CiyhdlgSdLhtTUafENX9Ky8naIdhNwJk+
	0ZjF1NX6ExGtFTO2kb1Qyt8MBQvACaDmr3BethDgg1vKMGX2PHnRoow==
X-Gm-Gg: Acq92OEH7QCMCvXCrfuAgIsluiSZiphj5sTxHUrKm4PpgpS75DBCZ4rxructGKXtsQk
	D0IXr4r8ZW9RTrkZ1VWzr6DOCFc+pvH8qFJEe627wmeCD0aKZHNgNhHEd8GVUV+pq309tjPQyZU
	Q/RNI1ir0M89s66Vx/dOqNg+AYAkQ/YWBfJJVVrU2ug8lwAhNxjc+16YaEnAKo8y9mGI5Y+JJH3
	g/rQkUYF+Jku8EkkB9Hlb6pxv9mxnVCX2Av5nv4zAmk06RWt2Jm+fLseFv4MB5KBUKc6ofRDvw+
	t/vGehSntm8phQ7M0gjiDXE+59JZQ+RwwGN8pjwS3RO28VDsfD5AXNh9zGl0mERzCbrFHEd6Xz/
	TO5zHl4zq3mgFCPA+7GCrCrpMnVwQz+GbtJvU4SMFHv4GNzScSPB29M11J6FO0tP7LHbKUnQ=
X-Received: by 2002:a05:600c:19cc:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-492332c11dfmr4760585e9.2.1781626413344;
        Tue, 16 Jun 2026 09:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:19cc:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-492332c11dfmr4759895e9.2.1781626412794;
        Tue, 16 Jun 2026 09:13:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm41852524f8f.27.2026.06.16.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:13:31 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:13:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
Message-ID: <ajF0To9N3yc2NlIr@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
 <ajFUk7quPhbI7Te-@sgarzare-redhat>
 <021a6604-289c-4dd8-a0be-33c7812c0105@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <021a6604-289c-4dd8-a0be-33c7812c0105@virtuozzo.com>

On Tue, Jun 16, 2026 at 06:58:40PM +0300, Andrey Drobyshev wrote:
>On 6/16/26 5:18 PM, Stefano Garzarella wrote:
>> On Fri, Jun 12, 2026 at 07:57:17PM +0300, Andrey Drobyshev wrote:

[...]

>>> static u32 vhost_transport_get_local_cid(void)
>>> @@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>>> 	 * the mutex would be too expensive in this hot path, and we already have
>>> 	 * all the outcomes covered: if the backend becomes NULL right after the check,
>>> 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>>> +	 *
>>> +	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
>>> +	 * The kick in vhost_vsock_start() will drain them on resume.
>>> 	 */
>>> 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>>> -		rcu_read_unlock();
>>> -		kfree_skb(skb);
>>> ]		return -EHOSTUNREACH;
>>> +		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
>>> +		if (!READ_ONCE(vsock->cpr_paused)) {
>>
>> Can we avoid this which is not really readable and maybe add a single
>> variable to control the fast-fail at all?
>>
>> I mean replacing both cpr_paused + backend-pointer with a single
>> `started` flag: set it to false at open, true on start via
>> smp_store_release(), back to false on normal stop, and leave it true
>> during CPR pause.
>>
>> The reader in send_pkt can do just:
>>
>>      if (!smp_load_acquire(&vsock->started))
>>          return -EHOSTUNREACH;
>>
>> WDYT?
>>
>
>I don't think it's gonna work as suggested.  As I understand, the order
>during CPR migration is:
>
>1) SET_RUNNING(0)
>       -> vhost_vsock_stop()
>           -> vhost_vsock_drop_backends()
>2) RESET_OWNER
>       -> vhost_vsock_drop_backends()
>3) SET_OWNER
>4) SET_RUNNING(1)
>       -> vhost_vsock_start
>           -> for (...) vhost_vq_set_backend()
>
>(Btw I just noticed backends are already NULL at step 2), but that's
>just our CPR case, for any potential RESET_OWNER users it might not be
>the case).
>
>So the race windows starts from 1) (not from 2)).  We have no way of
>differentiating whether device is actually being stopped for good, or
>we're in the middle of CPR.  If we set the flag to false on stop as you
>suggested, we'll still hit the -EHOSTUNREACH case eventually, and
>avoiding it is the whole purpose of this patch.
>
>The fast-fail with -EHOSTUNREACH relies on the presence of backends.
>IIUC the backend will only become set after initial SET_RUNNING(1),
>which will only happen once the guest driver writes smth to virtio
>config register, QEMU catches it and calls SET_RUNNING(1).  So we have
>ordering with the guest's actions here, which is logical.  But for our
>issue that means that the only true marker of paused/not paused is the
>presence of backends - and that's why the flag is set in
>vhost_vsock_drop_backends().

Okay, so what about avoiding to set `started` to false in 
SET_RUNNING(0)? I mean use it just to track the first SET_RUNNING(1).
(And maybe changing the name to that variable).

Apart from CPR, when can SET_RUNNING(0) occur?

At the end that was just an optimization, if we queue the packet is not 
a big issue IMO.

>
>>> +			rcu_read_unlock();
>>> +			kfree_skb(skb);
>>> +			return -EHOSTUNREACH;
>>> +		}
>>
>>
>> That said claude here is reporting a potential issue that I think we
>> should consider:
>>      After VHOST_RESET_OWNER, the guest CID stays in the hash, so
>>      vhost_transport_send_pkt() can still find the vsock, skip the
>>      fast-fail (cpr_paused=true), and call vhost_vq_work_queue() while
>>      vhost_workers_free() is freeing workers without a synchronize_rcu()
>>      — risking a use-after-free. Also, any send_pkt_work queued between
>>      the last flush and worker teardown gets its VHOST_WORK_QUEUED 
>>      bit
>>      stuck (the vhost task exits without draining), deadlocking
>>      host→guest traffic after restart.
>>
>>      A synchronize_rcu() in vhost_workers_free() between the
>>      rcu_assign_pointer(NULL) loop and the destroy loop would close the
>>      use-after-free, and reinitializing send_pkt_work via
>>      vhost_work_init() after vhost_dev_reset_owner() returns would clear
>>      the stuck QUEUED bit.
>>
>>
>
>Yes, this looks real indeed.  Though I couldn't hit the UAF issue while
>testing host->guest transfer under KASAN.
>
>>> 	}
>>>
>>> 	if (virtio_vsock_skb_reply(skb))
>>> @@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>>> 		mutex_unlock(&vq->mutex);
>>> 	}
>>>
>>> +	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>>> +	WRITE_ONCE(vsock->cpr_paused, false);
>>> +
>>> 	/* Some packets may have been queued before the device was started,
>>> 	 * let's kick the send worker to send them.
>>> 	 */
>>> @@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
>>>
>>> 	lockdep_assert_held(&vsock->dev.mutex);
>>>
>>> +	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
>>> +		WRITE_ONCE(vsock->cpr_paused, true);
>>> +		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>>> +	}
>>
>> Why here and not in vhost_vsock_reset_owner()?
>>
>> Also having this here will set it to true also with
>> VHOST_VSOCK_SET_RUNNING(0), is that right?
>>
>
>That was added here precisely to cover the vhost_vsock_stop() case (see
>above).

I see now, a comment or something in the commit would have helped.

Thanks,
Stefano

