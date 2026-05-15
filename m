Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01634410D0C
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836014; cv=none; b=gwfF5n0g8TaVSId4esPqgBboLZU9TdS62mKJvcbC/FRjaS4T8mQFvEnNTafDz2JlAcdhud2yagyG3W5gzcv63hvPzD6SOV9WCD6rTjjWZAP+6i+lxA5t8mQS2eMpXumKKOqQj/GA2iurkobyozKgxPb+EXeQg73qoEcDISnOizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836014; c=relaxed/simple;
	bh=rop/GLyLw5UwLPV1c6LCd9Vt3hvwFis3vSiP6iHIntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdPhdQrYHYvsRhAHcFJH/XjhO7f5dwriRZX9LZ9xEzmjud19WnM3ZNLkemveToeY3HmpJbYHDgMeW/tTsDn+EndG08jNmCfsN0YN/ULZMPUu5xjgnhxmNsxt9eXlSsWResLOZvqVlNglPB9yYO0TPIHyeMv7tUO/WFsy7gH21Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuFYrECO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEbpqTKj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuFYrECO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEbpqTKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=An9ccbacNYLYIGlZzu/euJIQhtjW0DZq6UWVHWSx2oI=;
	b=ZuFYrECOpBzDbeoEAm67Bi7/QnWvD0+V2rr2B55saCGZRBHtJeF+iwKhsuxYxMTg8fo2nx
	eCqpkNJ+NuQaV0htiGIpiwWc69ESZEELJi8nP3oN3RB7FunWwjRXGR+4WTL4DqxnfKTDZD
	/E1//GPiHh107gDJc0FIS5wn68dFGRg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-xt4jD5ONMY6ybRJVQqnLZQ-1; Fri, 15 May 2026 05:06:50 -0400
X-MC-Unique: xt4jD5ONMY6ybRJVQqnLZQ-1
X-Mimecast-MFC-AGG-ID: xt4jD5ONMY6ybRJVQqnLZQ_1778836009
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fe44ce385so9844735e9.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778836009; x=1779440809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=An9ccbacNYLYIGlZzu/euJIQhtjW0DZq6UWVHWSx2oI=;
        b=DEbpqTKjQPKkCT8bqopZlRfACKeSA+Y5rR05kxrJnaojaoh3upXtXSn0bwNHJNsHWb
         TgAsAhGUjWTXzbWXUaCF2lJTpEG2ziWQAFtefqVQLoTEncIv2ANWJaUQpq8wM7BwPYIK
         D24DTckNtZFdopU3DHf351er8jMXuhrHc1gEERABtEp6f7sLASrybAM8rjCn9hbaxZkX
         NUWYmwRgxw4CsXy7hpvBZTXZu1+Zd3bwc0gQdhUcq27Vhd1SWT5KylhBW+e7dqrkHS0X
         h3duk282CRIfRQeE21IWv+CIUE9X88E5V/ps3iy56gHNCzCMJjd3PXCPh7oblSWH9X9v
         5BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836009; x=1779440809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An9ccbacNYLYIGlZzu/euJIQhtjW0DZq6UWVHWSx2oI=;
        b=BZQrvPGIVhRNesK+eDJuAG0hRXOw5B8LDrWz32W5Tj7MeFYEQMJQsC/ZIlehLW7Ey5
         KCwJb6xIxhZ8e/2eRVZmN0Bd+DPHyJ9QUhw7qIkIFjsKx/ZNnHEUp5LiGSV1hseu62ur
         N+bR82zPR1B9OW4r2ZF6+nmDMNQXZLP7Vr7CU1I9sbHcu3geVyvFBIxKFRc/H/KOM9Zj
         jW518PBhBL5ety8Tar1SMfVZPoE/VQXjvHQfysZszZuJEZSaE3bfiPC0k5yI8a8U9rET
         0oDNIsxLX9vhvQJlo3HqYsPPKG8ULj9YVpV3hQ//hSCgHjmZm0CuLhC/k2RaQHOAjh7m
         PDPg==
X-Forwarded-Encrypted: i=1; AFNElJ8to0pBUjRpMaE+vsdZDH0o0Z9w57vU5QAZMk9q1j6WmWusTZ3ICiPrJ/1dX28dJJQxmc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5K9oXbSMhclQJsJu6upI8qiFDDLjXDuox37ap1NtLi9l/oQ52
	bNuxkdXOSxHXFOV+XQEQvGs1y5mfteu5L9SVgEdxaTstJM7pX3qo7kZDSqh92uGYs2UUBB7bo2z
	SuVTzWNO2ATgkgnoDDqPpcLUKAmDAZZSXZbiwrymm/9Q79H9/gY1nQA==
X-Gm-Gg: Acq92OFjpt84+65NHGKgWWuH0ZrdpMZjGa2LY6C1Z9qsV8OeUPaFimTiNJmioO53omA
	ENKEcwF3E5sB7uD1Q67MCEjc3Qjr8+QbEaFrfZuFZNY44uSaCDAty68w0edEN3N/FaFLmZbWdBs
	o8KSCkUJGXENTLZSgLEO4q2EESKb/SsevduJHyiDcsF2i/jjfBWYG+mykXKviQwluWU9s7/18kk
	bjfzTntUxyYylItqFyRx+bZMKNHoCIid1QUgMIC8LooVm0Eu2CG1NcBhsMiP+jP3FHAJ2kZalsr
	zlyTyVqe/8fbwLEMbs6gYJP4dX7NWKMzbYGtYzwxYdgBtQu83v6WijO/PE4UQgdS2tj7/ctv0Ex
	QOAX+SpmQHmU1LlZKYVaFOrb+Aam76yKWxgqVpS1fTSda58MbwU/9rg7mCfxIt1XfkdIGUXs1Mw
	==
X-Received: by 2002:a05:600c:848c:b0:48f:d0f1:ed28 with SMTP id 5b1f17b1804b1-48fe60e4e32mr37803915e9.1.1778836009474;
        Fri, 15 May 2026 02:06:49 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:48f:d0f1:ed28 with SMTP id 5b1f17b1804b1-48fe60e4e32mr37803145e9.1.1778836008891;
        Fri, 15 May 2026 02:06:48 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab52a6sm45218425e9.10.2026.05.15.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:06:48 -0700 (PDT)
Date: Fri, 15 May 2026 11:06:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <agbg-pUhBRB89aEX@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
 <20260515043940-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260515043940-mutt-send-email-mst@kernel.org>

On Fri, May 15, 2026 at 04:57:41AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
>> On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
>> > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
>> > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:

[...]

>> > > >
>> > > >
>> > > > And so the bag of hacks grows. I feel this is energy not well spent.
>> > > > Please, let us fix this properly *first*. And then worry about how to
>> > > > backport.  Maybe it will not be so terrible to backport after all.
>> > > >
>> > >
>> > > TBH I don't think this is an hack, but an issue we should fix in any case.
>> > > Regarding the second patch, I see your point, but it's a big change
>> > > that worries me. I'd like some more time to fix it properly without
>> > > rushing. Staying calm without realizing that userspace is broken like
>> > > we are now without this series :-(
>> > >
>> > > That said, evaluating further, I think we have a similar issue also
>> > > with STREAM on the host side where the skb usually doesn't free space,
>> > > so we need a merge strategy also there.
>> > >
>> > > So, I'd like to have time to fix both definitely. If you have time and
>> > > want to go ahead, please do.
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Well my patch was a start, we just need a strategy how to avoid copying
>> > everything, right?
>>
>> Yep, and then there's the question of how to handle EOM without a payload,
>> but I think that's a special case. In theory, we don't support sending it,
>> but I'm not sure if POSIX allows it or not.
>
>It seems to, but given we didn't allow it in the past, we probably
>should not start now without a good solution.

Agree.

>Really we should add a feature bit for EOM to steal a byte from
>buf_alloc. Or several bytes)

Yes, I agree. At this point, though, could we define a new protocol that 
also takes overhead into account, or would it be too complicated to 
synchronize both?

>
>> That said, is it okay if I send a v4 of this series?
>>
>> (I'm not sure if I'll be able to work on the merging next week)
>>
>> Stefano
>
>
>I do worry we are piling up hacks and we'll end up with races
>for all our troubles. That said, up to you.
>

I see it differently; Patch 1 should have been there from the start.
Patch 2, unless we completely remove the overhead, we should keep it, or 
use it to trigger merging (e.g., when the overhead reaches a threshold 
that depends on `buf_alloc`).

I prefer to send a v4.

Thanks,
Stefano

