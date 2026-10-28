Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793211124;
	b=dVatwpEgWewLoNkEJXimJrOIMSfLP5J2skr4zfgnJsG/tm0Fr0FNf1HqjFmdQnBA8CfQ
	 43vy7F2DnrAv5icLhM3h1YhvAxHR8bVRWLbKX8ZRCOdvhym1rW3X4VPLX+LGvmOqfyZPc
	 hRqtKuiuTBhozYgyVIO3QW5AD9KuZtfcjZfXXExEPhjr5sGL6qDjlwPyG2PLCO2pwQ8sy
	 flu7E6DHJl/NJnRkh2aodFTioqd+wEF5n6foEHw/FobyG9kz3K/yYl/YVonWW9FSDcFYy
	 0446xu/VDHr2VzpTGJMmPOPC/p5eOqZcpXGbRfBO/uB1MEmUB0JIWqpFmxupl22nzGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211124;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=gcTBoDoZodNeEIG1NJv/Cf9hQ2tDZQXR8IELFFZ5LJg=;
	b=kjgvc8GSMkJj8ZtfWyvhyMIaTnW8+n0BJ77G29QXA+mR/emEz5jTog7t76rNyamf/XJx
	 OtV+hsXsf05HodrwfV3pZk1yioaHHzMeYWwaq8Ohb5HC8yCcx+o5a4nqyg9rXpeX8tBCS
	 BTsSdQo4jcmvenJfsaFVg2JaoiAQiliqFn8VydT3WTXAF3y+vLGlQydNgwdwwHxr0QQX6
	 ROhV5Ul+R5cX1PaN8rTj8vmJg1Ges9b5ZFAIyTT3ma4c39XKv7+brZJ8ZKJXd3nMM1tWZ
	 TIp8G0mIEG+6h11I4QWQ9tDV25pqczixjVMeWXajLgAMFoKLxx2aQneJU3dnIhqrxKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=nMYwWowe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.170
Received: from mail-200170.simplelogin.co (mail-200170.simplelogin.co [176.119.200.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2360A6F62
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B2360A6F62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=nMYwWowe
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793211121;
	cv=none; b=BzG0lB8P4zva5dAFDcBP+oC74Bj5FI4S0vz8Exbm9fognNCIp0i44ovzsAMrbyegfCjprDKnWYcG2OgEYb+ipD8ITje4d+lktTWXMZJGozgnXfIV6HBtBg2/DA35FDyz5c8ZQDpgirojpgtGlvWtZzG15JD6fYO6cpYILhsL+96CpfaJUpSyQhM10ZNx+Fg4paMchKrTh2c5GVuH14Y4xpWZHI5p/vww7xuG0l9Pw8DSPeMkFpZLwCOnucTM3S+EPlFsbuO0vxVMWCUc3lXgJCH7zWe46539gN0ym8BWgqBgxm9isE6i/OqWbOaWaC0VgQImbSqIzFHnqsbwY2AnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793211121; c=relaxed/simple;
	bh=gcTBoDoZodNeEIG1NJv/Cf9hQ2tDZQXR8IELFFZ5LJg=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=2EiSOJHJF7wPWN19/b2/NO73fwlhIlaarJDH7BZKyCThGF92u+rV6qjDWW69mgiU8FMMUy7xR4QpMDBe0rI66getPwTvVHhe5MBO0qGrSUgWlQCrX5ci9u18mDBPM3p5ejBqMDsbT9uIwNvChoCtIdeIK/Tw1B+sEHQqY+Zgd1Pf6LV2af9A7UQW/aFub2HfoNpdwmc/McDm7YoRnErHm6vzVZucvRCl9ArqPkBpa7LQTuvycQgNtrTonghocu0FJJAvyCAXi5fzamvvDB80+8f2XNxUp1KD2YCMBIB+1agnTcBdE0FQs5VCkkbhopUNNRLiIvAR18/VYicvsJ/RaA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793211121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcTBoDoZodNeEIG1NJv/Cf9hQ2tDZQXR8IELFFZ5LJg=;
	b=nMYwWoweV5C8iF5Ujdap//+3tlKAtTL3Ld/Aor3RClh5/JuBn9vLAlyJvlRwRakfL8F7lu
	Gjal9LiExFhPSVT3KwMngG5iyA1JXh9tt+5OuQq10b+0wzV9sVMcJuzWdpw7f62Jsw6sgl
	goPdLFeotMzo+1OkshnM8VriX+aYAxw=
Date: Wed, 28 Oct 2026 18:11:53 +0000
Subject: Re: [PATCH net] vsock/virtio: clear vqs[] to avoid a UAF on a failed
 PM restore
In-Reply-To: <179122121054.434549.15763347362425052652@kernel.org>
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
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: netdev-bot+sashiko@kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,Jason Wang
 <jasowangio@gmail.com>,=?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,Xuan Zhuo <xuanzhuo@linux.alibaba.com>,Stefan Hajnoczi
 <stefanha@redhat.com>,Stefano Garzarella <sgarzare@redhat.com>,"David S.
 Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub
 Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,kvm@vger.kernel.org,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179321112009.7.11441275993569600318.1728181970@eldare.de>
References: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
 <179122121054.434549.15763347362425052652@kernel.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1728182025
X-SimpleLogin-Want-Signing: yes

On Mon, 05 Oct 2026 17:26:50 +0000, netdev-bot+sashiko@kernel.org wrote:
> The detach loops now handle NULL vqs, but del_vqs() still runs
> unconditionally. Is a second del_vqs() safe on every transport?
[...]
> Won't __free_irq() hit WARN(1, "Trying to free already-free IRQ %d") here=
?

Yes. I reproduced it with a virtio-mmio vsock device (QEMU microvm): after
the failed restore, both an unbind and a second freeze warn "Trying to free
already-free IRQ" from vm_del_vqs(). v2 treats an empty vqs[] as "no
virtqueues are live" and then skips the detach loops and del_vqs(), while
still resetting the device.

> Are the virtio_rtc and virtio_console references accurate?

They are not, thanks. v2 cites only the virtio_blk commit and keeps the
commit ID out of the code comment.

I'll send v2 as a new thread.

pw-bot: cr

