Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB271A0712
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323306; cv=none; b=Fz+4EcdptWwug34s/wHzXUaAbLqTdWQq0dIk/VV08bvkq1TRWJ3ba5GMhGmj6bNw6JQvAmQxK02pfZNKjYKkeznRxXMf3Ve97ImiJ7BKm+PQ+LTY462PB2LaDD7380Bqx52YMeO9QFvLvobCzvPZ8926N5cPXbrdp/10gE+unaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323306; c=relaxed/simple;
	bh=hGyOVcucJQ+6emh9f4kMcpR+qKcT8eW/N7Sl3bHKnnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAUPz+RjQCCAPbCZr246VgZI38KNHu3KManE9LyPt/J6INKK+bgr7gwxkQt8ufy+xqjueBJaoGlPIJm47Mh+nIA5znQeVHP74ks0HsS+Um2zZ0AEImZLeGMB9WxOeAXAyqvPI3nsIMGlWqWiUIkDVn1vSUfXG4TM5eadWq9mvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BE31/LmX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cknpOdOm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BE31/LmX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cknpOdOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAjqsvp3FTb2qvy1Zip4J9H1NlgvRXsWkj7RxsCfbGM=;
	b=BE31/LmX4+Yo1OhDde1LaybhlagXx55kRe4GAZCmm/GCBJVj4LLdTZlrtTRtYI6lH3x097
	EvkqyM/aRhwFIN4sR3XGfeE46DM58B3+0vk+Wsh8nu1mvPaH+W623ONQgrdEOHTYxH8h0e
	wQ8ihe1kNzICevcv5fZwKFZdpawVNPM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-BYMam0ZoM5eCXiOSUOa8tA-1; Thu, 12 Mar 2026 09:48:23 -0400
X-MC-Unique: BYMam0ZoM5eCXiOSUOa8tA-1
X-Mimecast-MFC-AGG-ID: BYMam0ZoM5eCXiOSUOa8tA_1773323302
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b0af42aso13427665e9.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773323302; x=1773928102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aAjqsvp3FTb2qvy1Zip4J9H1NlgvRXsWkj7RxsCfbGM=;
        b=cknpOdOmGACPqzKKOMDkm4tpBV3BHg54+sAklMOSmpgft++0PGmrIMexb4XJxrw3Uk
         /2lun8kGXIADk/Nd2gGTAcEceH7p/rCMI8LpKGITYZiluU6cGInqJCY9IxhKBPw5rqTr
         uaYqPjICYesOB4fHSluxfjKwi7M9RgL4EtU9w1mCSqIbbvg1gAzxY3i+H5xFAqEuIjS5
         wnm8lv34fh8CFjn0d6TTUvvNIZpN1/aDc4bWg9+lR8+O7y6P96eQzGIowbzX+n++k02j
         kb+SrufpS09iAmiJ6Vo70Mme1YZoYFtvmqw4Yg8zUFv0Ydffvg6ptFsd5jhWsrxYVIWT
         najA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323302; x=1773928102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAjqsvp3FTb2qvy1Zip4J9H1NlgvRXsWkj7RxsCfbGM=;
        b=J7jW0gIdrHY8FxtLYHMlBuLc0NHBE8SbQI6xRxOYiaWs/RGYY2xlcG5E+cg5d9Du9D
         jfTcXT0w8NnfuQRtesX1M/yDpiX59mZdgk1aqXNn84mKa+4p/66SUUYjkbEM2j16Wsce
         7uShiEKgxx0k0wDMWFa4Yj6ECBkPOTgWAObfhO2oOljn2wlwyInRAelDYROfcJVjbqiZ
         mzwG0XjSCLuQK+bQ+D0LKrIgrMzbH68CPkkB+qmOi0JwxKIXbfpya1nrpfd+5CAewubt
         NYocqph1Vl0HzJsEmFUvhT5zi+XOXTwSyHVqwulnbQkRuifdDV4v2RC83hTOjuCujQzw
         sRCg==
X-Forwarded-Encrypted: i=1; AJvYcCXn/RArrzNxLTJ10uCDx2NzL/PW7Q5OcQlcFbU/RKv/pG6CSKOHoTn/U/UkeNDIbFzUQJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFGF6Sxs3wyUZeZiujivCG2SUDdb6YquaaoD5ouoCZDqRQVA7h
	uMbahxIZ61UKnQacRfXNixSRv5lLQXaako5+KVtdLB6fmS2Bry9Dh5dCdsb4DaK2qcDlOy+kw+L
	tWzfKoF7QxsC4aIXZ9SvVRbNzhWwXSTZjgSOBR6sMRaXgELFbD8rxJ7UjsI4Nzg==
X-Gm-Gg: ATEYQzxRQgta6qnreHxEOe4BORrQCGZ5gHMdFJE9/TtO6xdqovZy7bpsg1I621z4ZiN
	ZMjHn6Zfu5LPfu816A3y8vUdz1GYh2u1KRy9uIfq3CUumVkLsaQJWDwNLz9N3D3k1HI7oEkzRWi
	SfDR+SgHvqHGUuTU+vK1qWIvWZUp/FS8khKpYtdeEUry+efYO6WOVFpQZcQvmlxlSdFZNzK/IoV
	mbPn0JEyx/RqWDNoPQ0xVw5TdcYpkAjd5wlNWLbOYmjdiHVjjgY//CJ0J4tVQP7Y6cNktI0OnEU
	ikmJjBjFuJchiSMlFQZS8E/rIqxt0QObjdri37/omTJxX8QGM7D69dDPv6kn9FTrA+UCXlDzAVJ
	myODOAgSqa7IDQ+Jq4k9Q9ZlZm0eH0lXxHGIifADJpTBpTA==
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id 5b1f17b1804b1-4854b111768mr107604715e9.27.1773323301755;
        Thu, 12 Mar 2026 06:48:21 -0700 (PDT)
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id 5b1f17b1804b1-4854b111768mr107604245e9.27.1773323301167;
        Thu, 12 Mar 2026 06:48:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm326209285e9.11.2026.03.12.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:48:20 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:48:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
Message-ID: <20260312094447-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
 <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>

On Thu, Mar 12, 2026 at 02:17:16PM +0100, Eric Dumazet wrote:
> On Thu, Mar 12, 2026 at 2:06 PM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > This patch moves the check for available free space for a new entry into
> > a separate function. As a result, __ptr_ring_produce() remains logically
> > unchanged, while the new helper allows callers to determine in advance
> > whether subsequent __ptr_ring_produce() calls will succeed. This
> > information can, for example, be used to temporarily stop producing until
> > __ptr_ring_peek() indicates that space is available again.
> >
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  include/linux/ptr_ring.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > index 534531807d95..a5a3fa4916d3 100644
> > --- a/include/linux/ptr_ring.h
> > +++ b/include/linux/ptr_ring.h
> > @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
> >         return ret;
> >  }
> >
> > +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> > +{
> > +       if (unlikely(!r->size) || r->queue[r->producer])
> 
> I think this should be
> 
>        if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))
> 
> And of course:
> 
> @@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
>  static inline bool __ptr_ring_empty(struct ptr_ring *r)
>  {
>         if (likely(r->size))
> -               return !r->queue[READ_ONCE(r->consumer_head)];
> +               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]);
>         return true;
>  }


I don't understand why it's necessary. consumer_head etc are
all lock protected.

queue itself is not but we are only checking it for NULL -
it is fine if compiler reads it in many chunks and not all
at once.

> @@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
> ptr_ring *r, int consumer_head)
>          * besides the first one until we write out all entries.
>          */
>         while (likely(head > r->consumer_tail))
> -               r->queue[--head] = NULL;
> +               WRITE_ONCE(r->queue[--head], NULL);
> 
>         r->consumer_tail = consumer_head;
>  }
> 
> 
> Presumably we should fix this in net tree first.


Maybe this one yes but I am not sure at all - KCSAN is happy.


-- 
MST

