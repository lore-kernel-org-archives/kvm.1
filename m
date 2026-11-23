Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452520;
	b=AfMPfMtu83VOyU3ForUulDQSmdqjh1mUvJRSd3/YYNfnxPnIBHytLz9yVNu2wPNRE2g+
	 wKrGReZq89XwnZrGRvSft1j44O3LzEmXeApe00KSeSsj1H+ziiCOSzs+WcAU2Z+0f0hEZ
	 2JhuLr8KXzauBQsVNvNUD2T2OhPwVk64fwrKhC8QeQ9bgF0wslGsQaoNpFHG4IPyF3eN5
	 HcGLA9Uu0XBYnrY4zGHiheSLFDsxuSZsnU7OWq6DA83GYgwcoIC5kvICjFWZaTh868f5i
	 pEJkDeUVg+gpr3ZMuVGJKps1oQY2mjZhdgjB5PJN5EpwfNmG8my716i57EabP+IcaDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QTHxkjwnWdi0Sg67/NbYoTIjq9LWwP65YaigHl4xtvM=;
	b=aejYB1BLDAoLweyJLCauFO5x1Z1AsKcQQNaHwZRzBWDfcnKRYcyWTEswkziJgrt96g6Z
	 1RMj6v80QfKpi7NHgM7xGFq49BFDAQugQVM7l24xo5t19/mCbo8rnrDSPe4Qsjo/OOT6d
	 QgnP7En7Jk7u1554I03i3XXFsDAHrh5DP///TmdC0Ee2OaE+vSWaDbrGRt3p+hZuDqJA0
	 SdetFMK9RpbMGg6Dg7gjr9UITiKI7uU5EbIKHF4dFm+rbP4tsDtrea3DOFy3zTs22iEIH
	 cVMeyKtnrc2tS+5UMvu/h6N/N1Q4XkCz9wZsHqaTMnJo+2gQyjbGtYgr8LGPdvN4wJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWsuP7zJ;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250C606A33D
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 16:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5250C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWsuP7zJ
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a07078200fso1771451b3a.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452520; x=1796057320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTHxkjwnWdi0Sg67/NbYoTIjq9LWwP65YaigHl4xtvM=;
        b=EWsuP7zJJNvbfMPNG7SLHEF3yL+QlEtMOmwu3by8A/WNpiRSTgAdB++0K9EZ63MAyy
         GH/dq6DxwptKu20HOnCL709zeFibKErwDUJ31x2cknJd4fyN/snaHcQZfAwyzZ7yh7Uk
         BAukFuqFnE2UP7n0BRfkKl8mvELW8MPhSm0MFsHS0iPEnAERpzScvrIcCwoT+sO9f6T+
         VSqQ1de51OHqXLQT4UXz6dUD25pV6axh9dJhq1X56+pbxs/zElSZ8gf62GpCsQpHQhtK
         4VyxmcuYiel5SCFACJZlWnEXUlLsGRSxqRA2YKsm7toBb/R8Ho9MJQnbZwdc5+6GdhCa
         bcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452520; x=1796057320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QTHxkjwnWdi0Sg67/NbYoTIjq9LWwP65YaigHl4xtvM=;
        b=1jGT0y14CbwocQC4ab+KsoUrW4i7eHeLGrPFrA5crzChO3j/w70UxLNZ/9O9oxPSxe
         r9I9pfU/l0TNf1mEkZVsAERt+3HVYwDgizn6rOSWlcydTyt0bmdoKHJCuqzittdg4uyh
         p5xxQuTJ/Of4CtlNO9Fqtb3fsHKPmgjQ2tUKmRI4Ve4M8Yom/VUOOR05UEGfLftrSzyJ
         BUG0SJaaxh+SsDhb1K6o7yMG1SH7xL6u4F9Wi4n9t3IIMObcD7YHzdDaHv6xssH04MV+
         DAZ0USZiHzWWyi2i66O/02DM63ViH1Y3FnbFkHF9SlXyKpp6NHGqc/lG+k2Lp0aFKXRs
         SVdQ==
X-Forwarded-Encrypted: i=1; AL+hErGTm8FA4mU/A02c6U7MQI/AgxhbmFw9Jreyw9RwW1yd/bNyFpFhxuw/Z1Acm/Ii+WtXfBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SzxXmEd3bsfX7YZNesnDz/4uCpsnQ+gSafGUULq601rXej52o
	CofiJexLguvlIylRtizt9JY8zlN9hYx0ADqR3An3eQvTj9yPONq8jQKI
X-Gm-Gg: AZFdTZdCq8dEhbCSkrASetP+9rmuWyPN61Ua0upADLuebtO4Cmcfxnve615So+BKd4a
	GmxBAnsdyE47FOCSUYUY5va1IpfiI3GJj/q0iLMuJdPTBswCKNib1j1uEaXsAwtSeuQlXWL5zRx
	9OFCG0XErEfZc0R5HQMUyg31FO00J0nWrcWY/DE/kxDKAzMCcYytyhnI3CJ8NmxHNt4hiOi8vem
	6ywdoNrFUkkIPXdxhgjJ3XkUShcaYkguj52hnFe2dJZW4s1xk6iCVT8NjxNV6K47p9mY1Is0+Lk
	kWGykMdIcxOutm43vle9xhP0wNw470twdCGYZVI8xrzYoX+pRZpGc/UCCvCpSovUNa4lvRpmAaf
	/yYwYAfH+HTt/z+EIhsiBYxv3Ku7RxgbJsFMgpnMx5mpO/THGV8yEgcmSiO0CR6l1zwuXP7Tm93
	2AfdxdkexDe9EDU3sjnLWZCidTA9gH3pxJOzhQcrBkDTljKn3l1Tk/puwQBasI/ELDy061SHSZ+
	pqTNdCwW9QyeT+uBLvSPtpKQAbtWXKpPwO9Eoa2UK8T/kVGnNVJEqrVY/NFN/oPP4YvCPFVPYWY
	L76WICcmFX1G8cDSRY25I+VP0oXyfaEo8BhDf2tOFklntGk=
X-Received: by 2002:a05:6a20:c992:b0:3f9:9114:804f with SMTP id adf61e73a8af0-4014d15937dmr11140810637.27.1795452519544;
        Mon, 23 Nov 2026 08:48:39 -0800 (PST)
Received: from [10.2.0.2] ([159.26.115.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343fe6csm6085691b3a.37.2026.11.23.08.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 08:48:39 -0800 (PST)
Message-ID: <a7752192-b417-4e70-8f39-a3cdc983f447@gmail.com>
Date: Tue, 24 Nov 2026 00:48:34 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Asias He <asias@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117164916.2332953-1-phind.uet@gmail.com>
 <20261118012321-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Nguyen Dinh Phi <phind.uet@gmail.com>
In-Reply-To: <20261118012321-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/2026 2:33 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 18, 2026 at 12:48:43AM +0800, Nguyen Dinh Phi wrote:
>> vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
>> vhost_vsock_mutex, but It is also read without that mutex in
>> vhost_vsock_handle_tx_kick(), and vhost_vsock_get().
>>
>> KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
>> ioctl while the device has TX traffic. For example:
>>
>>  write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
>>    vhost_vsock_dev_ioctl+0x25f/0x720
>>    __x64_sys_ioctl+0xc2/0x110
>>    x64_sys_call+0x299/0x20a0
>>    do_syscall_64+0xc9/0x510
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>   read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
>>    vhost_vsock_handle_tx_kick+0x41b/0x740
>>    vhost_run_work_list+0x97/0xc0
>>    vhost_task_fn+0x98/0x1f0
>>    ret_from_fork+0x2e2/0x3c0
>>    ret_from_fork_asm+0x1a/0x30
>>
>>   value changed: 0x0000004d -> 0x00000032
>>
>> Both readers load the CID once and works correctly with either the
>> old or the new value.
>>
>> Mark the store with WRITE_ONCE() and the two lockless loads with
>> READ_ONCE(), so KCSAN knows the race is intentional.
> 
> You make it sounds like it is just KCSAN false positive.
> Is it?
> if yes, this should be data_race. If no, document why.
>

This is an actual data race, not a false positive. The value of guest_cid
can change while the TX worker or lookup path reads it with plain accesses.
Because each check loads the CID once and either value is valid, the result
is equivalent to the read running just before or just after the ioctl.
Even so, plain concurrent accesses are a data race under the Linux kernel
memory model, and using READ_ONCE()/WRITE_ONCE() also prevents
compiler re-fetching or tearing rather than just silencing KCSAN.

>>
>> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> ---
>>  drivers/vhost/vsock.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 88a310390eb0..f26c59013075 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>>  
>>  	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
>>  				   lockdep_is_held(&vhost_vsock_mutex)) {
>> -		u32 other_cid = vsock->guest_cid;
>> +		u32 other_cid = READ_ONCE(vsock->guest_cid);
>>  
>>  		/* Skip instances that have no CID yet */
>>  		if (other_cid == 0)
>> @@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>>  		hdr = virtio_vsock_hdr(skb);
>>  
>>  		/* Only accept correctly addressed packets */
>> -		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
>> +		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
>>  		    le64_to_cpu(hdr->dst_cid) ==
>>  		    vhost_transport_get_local_cid())
>>  			virtio_transport_recv_pkt(&vhost_transport, skb,
> 
> Will prevent compiler from hoisting the reads out of the loops.
> Does it matter?
> 

Not much in practice: because the loop body calls non-inline functions, the
field needs to be reloaded across calls anyway (and in `vhost_vsock_get()`,
the `vsock` pointer changes on every iteration). I checked with gcc 16.2 and
clang 21, and the compiler does not hoist the load out of the loop even
without the patch.


