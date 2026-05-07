Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B73C9ED9
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171558; cv=pass; b=rvn0Cnb7smqYZ5nYoXOBMP7LF9Iaf24V3KEiMbRGTLVyhphSWuYTR2v4Nsb4fz1I4EqAGxIyp4U6AsqeCUsJDrFff9NboNi35YbH1c7halr/z9yq+qOy6JkzjFvjw8dLmsVU9pNK90YyUolSMb7CJFdRm+JTQALiiXAAgOKfaXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171558; c=relaxed/simple;
	bh=8VRBFuEjBtdNxMc+0CLtM7mNvR9Ak+SZIaiiqsTAXjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fs0zzyLwXN8yFGTYVeldlAqKLT90V+19uoYP+rfNiWTZAf8RzhpgSAyrNWdv0JV/BPxnjLERT3zokxZ0UnbsIad8QC7dwoGr6HFES9g91/ZjCQ48npbCt/V/giH1lQLXjR6xGbTJmilcLAI/xaNM8gplFcQk4vQaIYisSgrKEwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgmDunZI; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgmDunZI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e5b55062fso7528331cf.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 09:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778171556; cv=none;
        d=google.com; s=arc-20240605;
        b=ZsLmDpvl4F+L0N6PWoMK7aX7UA/aODznXCvnCspCrc8U8yIEYi1YPjB7u8Vzf3ATI1
         n1ZQyOE1slSjtAVSQNlF8FOFucfZl6Hoa116xOiqnuS4BTmlotRFU9vfiDaMEOm/sD+K
         PUgW/TSGsXYrlK6B4HylhnIaGj+t22GtnKSX5ZM5ycJnrfaZ8xo/tGL1dlsXjnMdlhnE
         R2zj5lP/+s+xBQj9ka8rx6Y4jq2uYyoHaulZp03sntkFxSR+EBjr6AsZ08yWyYBgVA5p
         OCO8XdcLnmq9cEw5aW7D9+FR22GhnExD/r2T5ztsYdjZO0osXrFm3gkQIdYwJM6xY164
         RtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        fh=nyzwAVTK5xAxUaSCA8krEpc+k2K2rXtmykiSHM1e6/M=;
        b=IcnnSvAlNLUwk2F6PtaWYiCKs/CUXFPQiuEuQDDVf4bnU11n4KgL3MFzEcWrG7vjcj
         za1oD5SAvGdJE6wmR/jO6xoArDV3IT21WesxlUo5pTv2ComWwKewaC3HC7gdQ64epwnB
         kkFz6o3YAYDqhHqa9q9h3ZckXrJX4lmkiqILB0pUHcl2WrgIQm/sLF4obGa3o69EEq7K
         26g9rgDKUXZ62vrnrqDgLKCWeZntb8kdFCR6aKcZPgbCWPDrj+Pz+/WNWKUG7RilrRBA
         SFHdTr8/H8tGi1luuvxaeeW2h3KWKUobfFDICcQk7uh8qetNspvKcEqUb0LzyrdvCgiE
         oaOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778171556; x=1778776356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        b=AgmDunZIeLxTvkfSftkJV1MA1H5hfDJybGp7pUaJOtM1cja7LqZa4CE86yykJLa1hT
         hhU96IW63o8S4v/q/qYz1lilge6PSccenNx459D26SvbyVqaIAQAxKjODmeEecsPDUe2
         oFFkivASQ2ACt0BrzC4oGidF8gpg77RRI2odqmlCLW9/a+H7Jm17cEmNVbJ8c9pYIbR1
         Rhc/24tSHuYZRdcpO6GG6ppgi9Bcymb/QQMW+02Jbf9RjkCoe0ALt3Vr3qRsoBWJjPMl
         NvZbe0fhgkQJHnsPin1ZRivJSq42rKmgDnudgIaJsmDg5PUZavlhfMALZ7Cgfo+OVQTk
         XK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778171556; x=1778776356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        b=fV7ZOFOkOqRea3eP27HRjODFqOdSHXVxcNNpCYW1R8wfn+lJwtsXnFazs5hy95JgVZ
         1nVjBgqIjeBRaZDXXiOtAkoz+Y/V4EMl4F39G5493gDGqVtj+tB7cTrn3eJEVF0XAEBy
         k2LFNiahBviyZfABPGByfI2hp9LerOzFR7HQk8BRQlr2DGjh+7HtplOMo3qLJ+h01iyF
         F8cPrYzHbmsK6rQv1H8zsGvS9oHFn6rReSDOotEAYJx8x9vZA9q3NsuwoVzrFk4/D16Q
         LPD1zAE1XpwJvWmA214nSDULHr3WJBFPdoS5mvHuTqSOTm7Kme5rtM7DMrkZcufw9ZMA
         oi6w==
X-Forwarded-Encrypted: i=1; AFNElJ8oUWdKBDgfu0bc0vkF/DWUJ+fPEI4Bey+MIDLdiBoFfaMIb7xHzKp2UAyed+eP4weCFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Iq4/Ko/KlfJe/FwA0+c4YKA0zkPQIWnvCcdVHR4XAYMjs2GH
	PaXP3IcCCzO7KinD6FknGqcZCj4YFvNQZDR1hrxdOKsSmSluRp8ntmYKp4owvabOy7b98vLJfl1
	V79PXOSm/aOg69Kz0jYCveUZbyQ57TbS5LzN5ixTY
X-Gm-Gg: AeBDietF+qQO34YnWE28Pl2kTBivsSwCqIvXI0rQ6vF2tWzKDD2aHQ/fIV3WMXMal4Y
	L1QiCnoTCjjAbN1cnt8Nh70zJEPNcEXvT8dn/ZGk1mHG/Hr5KI+ho6GQkfTlMykMDOc5CqfHR7Y
	HJI53T8EsGNjb0ayZ9gp+sp6e0aelQV98LaqSjdzXtX0unl51Vkv5BW7JPi/22nxCtJ1q8xm4TN
	RWD4n5HFuucl12YtVAQXmUsj/zYCZxjeu9nyp8Cpqg5qt84Tcq/IuWZY2F4C9aCFyfEG4cP98Pq
	5GZXygBd53Jtr8GMHLU7D+SCddAyXe5OT+JRbQWwQ8/ELzXLWilNsV+lb51ejO4tqthHOavHA24
	jf0m6YimDUFUZHDfSz7ugDtFiLuIydo8=
X-Received: by 2002:ac8:5a16:0:b0:50d:9b07:9c46 with SMTP id
 d75a77b69052e-51461fa0213mr115677391cf.33.1778171555577; Thu, 07 May 2026
 09:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat> <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat> <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat> <20260507073340.0604667d@kernel.org> <afyy9CeniTBF3o2I@sgarzare-redhat>
In-Reply-To: <afyy9CeniTBF3o2I@sgarzare-redhat>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 May 2026 09:32:24 -0700
X-Gm-Features: AVHnY4K43sQ5GiXATqMbu7KFCF7zUxmTlewiAWXiJfdc41BJ0Cit2Qu3K7HJSFU
Message-ID: <CANn89iJ+qOFPSUACvda7djOVKGM8t+FfwdA5Ymjxe+g_tJtmnA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 9:05=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
> >On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
> >> >well if you want to support pathological cases such as 1 byte message=
s
> >> >that would mean like 100x reduction no?
> >>
> >> Yep, but since this patch is already merged, IMHO that is better than
> >> losing data in those pathological cases.
> >
> >We can revert if you think that the risk of regression is high..
> >Please LMK soon, we can do it before patch reaches Linus.
> >
>
> Some tests in tools/testing/vsock/vsock_test.c are failing with this
> patch applied.
>
> Test 18 are failing sometime in this way (I guess because we are
> dropping packets):
>
> 18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>
> Test 22 is failing 100% in this way:
>
> 22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> Resource temporarily unavailable
>
>
> With my followup patch adding also advertisement to the other peer
> (still draft locally, waiting for Michael proposal) I saw 22 failing,
> because tests expects that can use the entire buf_alloc, but now we are
> reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and
> double the buffer size, or at least digest an overhead equal to the
> buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah,
> AF_VSOCK has it owns sockopt since the beginning :-().
>
> With that approach tests are passing, but I'd like to stress a bit more
> that patch. I'll send it tomorrow as fixup of this patch, or if you
> prefer to revert, I'll send as standalone.
>

A plain revert is a big issue, now users now how to crash hypervisors.

This vulnerability allows a compromised guest (controlling
virtio_vsock_hdr fields)
to continuously flood the host's vsock receive queue without
triggering any memory
 accounting limits or reader wakeups, resulting in unbounded host
kernel memory consumption (Host DoS via OOM).

A vulnerability where a KVM guest can crash or deadlock its host is
classified as a KVM DoS.

Am I missing something?
