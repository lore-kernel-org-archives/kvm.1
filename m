Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599864;
	b=4ug+LHOniNDwAoar2rIM+fBCV9L3hw+viEwXMGXoB/1Y4LKtJc7mRtTfcKq+XZFeEbxV
	 ZBL4zuJl6uC61POYFeE9mwj/GP70wFChmguhYd5RYjcBLbI2DHi4chw7xb2pg1jfejU5N
	 8nDfnXgynibDyKVEycvij5SLomB1PTnUjz0gf90C0GlcT35QzAyOGx+XAefJcgVTQrIEH
	 dQPRrtkaL/wzqiR5TTI+hohIBN8fbb8kCLT8R/IU1SdL+DOU096G+nBRWeSspHJBiCPnZ
	 B6FhPJPHETF4k6B4H3AVhnPoEvcbBinSx077Ond22JeE9PjY5mqntSsVaxkIwEzDPEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=J+d1lI1CTytiZQns3U5FyUF/mcA833hGCvYKT8aAybo=;
	b=ey/PCubZzNtEHS7jntHYHQ7Z5+RaXe4bH5wBuVP9sw804h6l6W/OE/s4d34x/s381LaC
	 Ibfkga/76CZOs0SBjOLP7rpiP4Xtms4JYDfj/k8dZlcNLjTuC0HOwFc/dqYpgIsIu4P1B
	 Qiz4Q+X6FKB94cp8lWWPFW4IY69toPvoF0wCLf0xuOhDmHGtUEWh91f1AMNNnx07dp81R
	 VOnsWCEJsN2vvqXZ2h5XFoMft63aZlOjca8RS79yWxOsbduTncGQieUNNwNCB03AvcaDm
	 0IKgW3rgZlqyQu7fr+fPnYCzIFiw1WbFpAcKvPvxd5KgKT8E0bU/5f7EeW2UPScmJ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=KfWKmqbj;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1D606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F1D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=KfWKmqbj
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c445c95d553so120954366b.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792599857; x=1793204657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+d1lI1CTytiZQns3U5FyUF/mcA833hGCvYKT8aAybo=;
        b=KfWKmqbj3zDsBzMEQs2EJGcF7o7NS9ZfgbRXL4GrmZFdLxk1e6Aqz+pi7ZKx7PIGEp
         8YmiwM9BPf/Yr59s0q24dJ/N73quwbavusg13KHYcw9/w9xU+FXvjiAcFa/lHn3Z49Zw
         FV7Bms/mh/wYuU7d0RjNVuEigbZHFfxaivn9sgjMQqwACVkBuJNRKM7sPwh4L5wHIgKk
         /6ghi+siAw1Yn1g59yXjTmSqfkJ9+76pNkHvmyScGzfxGmpMWDzWPaKZkdwR7dAc6W2K
         BbW+pBWyX9ckAcMZUl4JQcZqN1G3yt3L5v/U8jRM3iEvT2SWj5ZECqZMKk++551+xdue
         IKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599857; x=1793204657;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+d1lI1CTytiZQns3U5FyUF/mcA833hGCvYKT8aAybo=;
        b=ID0NSM2lp9ookoZOYedp0hfjDjvOFlj2ixnkKNSq2uh82lFBqcBck1bMxbjJg91Z6c
         txf/79gobMdRBLfW83BXdE3Qdl2JtG/CX/9WPU2PRjmAeth/BVHZfK8hXVXqEawtC0j+
         h8jPxmpQKl9aHoyWPxHnpXxk/L1XiJAE50oralGkC3U2ekNioQTG48LD/TtkDRl3h2vd
         jKEt2bejchIo8rFhSURoYwkdxwNvRoeeuJhCbUJtlxA4yr3rDzJGLqakiQUXuZTLUtr2
         oYFUs0qYOhpdXOoBHZYzBKgRGp2eHLZpyjgoo2LjOF+CEplZf6lMttX0m+pgyJXdyXxK
         n9Iw==
X-Forwarded-Encrypted: i=1; AKwUvBzZdwGaAa46Lx9hI2J5bR61dIsuU1QrMDYDWSIPc3bkRMtLXxq6Pge8ND7RQury2kC1Eb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoJEmSi4lqEdMuhMdNCvnQPo2tfAFyLLEAtPe1e/pghfUBj3P6
	86l5cFLexHXxMV+jCzN2pRL88EsAmZbdnq4u079ObJlmQlY4YUGVFn9Vs0LuaArl090=
X-Gm-Gg: AYBFou2lWpXtdCpZnkUguSYpzs3gYShMVrFyKNqAl66ZCmxLcnGBqTn5xyWB1+gE1xc
	/rINXo0MIb9uRTZYmFocJ2pDszPZckQVg3yuowsf3nA55Mao1fPhd/IeWvrtkgld/m+s+Z16SpP
	wSZyCbm694RX1V3fBc90H4zv8/GUW6WqXxbqmBFzn0MZU07y/dZTUXZMvw44UNnECvpkSzw6Evo
	pT9hhIfxMx6AC/mSdMcn9eXtwW9ggWXy7gkGm3FXNGJIc90UB7cJfLAMmtWS4EZc9/KkGKewc0M
	BURcoKyi50VUAf9/1yS4JVAHmuwacvWt789t6uoDyaEsMtDRTu050iFnGqywwFYIzw77WpBHE+H
	5PssWAcWSRtNSIEixphnxc+jkQ6kKKXh0lsClkozUCXvvIgwv+FaR3pmwKlhoqtXkaYX0nM49cc
	/HSL2ZUwY5FLdfLTUp7uqZdXvWes/v8r05FcezeD8VwG4ccjXpEocAwzyNcdwcBjYYHSI2eY56I
	zAeFfvSDYpYOTjAWQIj3isIL33Td8iLAY1MQH1UMPyDlqSAvwgS4gshpCKDVryXU+Fg
X-Received: by 2002:a17:907:2d92:b0:c25:afb6:2d91 with SMTP id a640c23a62f3a-c46791a97a9mr240205966b.2.1792599856528;
        Wed, 21 Oct 2026 09:24:16 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a4ffd07sm18747466b.17.2026.10.21.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:24:16 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:24:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 13/20] Documentation: ctlv: Describe how to write a
 family
Message-ID: <atjiW8bnqDZ8zb5t@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-14-jiri@resnulli.us>
 <179245258505.58760.3972297562218204862.b4-review@b4>
 <atjEgLYpgbZNzfkZ@FV6GYCPJ69>
 <20261021144951.GR3008132@nvidia.com>
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
In-Reply-To: <20261021144951.GR3008132@nvidia.com>

Wed, Oct 21, 2026 at 04:49:51PM +0200, jgg@nvidia.com wrote:
>On Wed, Oct 21, 2026 at 04:23:17PM +0200, Jiri Pirko wrote:
>> >> +    attr-sets:
>> >> +      - name: item-request
>> >> +        attrs: item.index
>> >> +        optional-attrs:
>> >> +          - item.label
>> >> +          - item.data
>> >> +      - name: item-reply
>> >> +        attrs: item.index
>> >> +        optional-attrs: item.label
>> >> +      - name: items-reply
>> >> +        optional-attrs: list.item
>> >
>> >I haven't quite figured out what attr-sets is about. I think these
>> >blocks should have some # comments with more guidance what is going on.
>> 
>> "group" defines attrs with all the description once. "set" just puts
>> together multiple atrrs from multiple groups. Will try to document it
>> more clearly.
>
>Maybe also include a explanation why it is like this, how it should be
>used, etc.

Okay.


>
>> >> +
>> >> +    ops:
>> >> +      - name: item-set
>> >> +        type: action
>> >> +        optional: true
>> >> +        request:
>> >> +          attrs: item-request
>> >> +      - name: items-dump
>> >> +        type: query
>> >> +        availability: dynamic
>> >> +        pre-post: true
>> >> +        reply:
>> >> +          attrs: items-reply
>> >> +        suggested-reply-length: 4096
>> >> +      - name: item-changed
>> >> +        type: event
>> >> +        reply:
>> >> +          attrs: item-reply
>> >> +
>> >> +An attribute has one payload form: ``type``, ``enum``, ``flags``, ``attrs``, or
>> >> +``blob``. An attr set names one message level. ``attrs`` are required and
>> >> +``optional-attrs`` are optional. Its bounds and membership are ABI.
>> >
>> >The attribute first point of view is maybe a little too netlinky, I
>> >prefer to think of this as a system call first, with a first class
>> >'query' to get a list of things
>> >
>> >Alot of stuff this is going to deal with won't be the netlink esque
>> >'dump a table, set a table' kind of flow, but a bunch of different
>> >system calls with arguments.
>> 
>> 
>> Can you elaborate a bit more about this please? I'm not clear about what
>> you mean by this. "'query' to get a list of things" sound cryptic to me.
>> Are you talking about doc or about family yaml as well?
>
>Just documentation. Netlink sort of evolved from a table row based API
>concept into something more complete, but here we are starting more
>from a systemcall concept that also has some first class tables too.
>
>Maybe it just isn't clear what the original doc paragraph is trying to
>say.

Okay. Will redo.


>
>> >> +.. code-block:: c
>> >> +
>> >> +    int ctlv_example_vendor_details_extension_fill(
>> >> +                            void *priv, struct ctlv_op_ctx *ctx,
>> >> +                            const struct ctlv_cursor *request,
>> >> +                            struct ctlv_cursor *nest)
>> >> +    {
>> >> +            ctlv_example_vendor_vendor_serial_put(nest,
>> >> +                                                   example_serial(priv));
>> >> +            return 0;
>> >> +    }
>> >
>> >I suppose this like RDMA and each HW driver using this gets its own
>> >full scheme tree that only has its own stuff in it?
>> 
>> It's the "family". Each child inheriting a subsystem family. It fills
>> up the subsystem family defines stubs/extensions. It can add ops too.
>
>I haven't got that far in the patches, but I think it would be good to
>spend more time here explaining the fundamentals of how the extension
>mechanism is expected to be used..
>
>It looks like RDMA to me where you have some 'common' and some
>'driver' parts but at this point in the docs it isn't clear how that
>is reached. Like does each driver gets its own family? What is a

Depends on the consumer/subsystem. But esentially yes. That is what I'm
doing for "attestation". This patchset introduces ctlv-attestation-tdx.
Next we will have ctlv-attestation-tpm, ctlv-attestation-firme,
ctlv-attestation-armcca ctlv-attestation-spdm and others.


>'family chain' etc Where is it reported?

families_dump op of ctlv "root" family. Output is array of {id,name}
tuples.


>
>> >What about userspace, it "knows" somehow what to do?
>> 
>> Userspace sees the family chain. It also has ability to do introspection
>> seeing right away which op supports with attrs in which nests.
>
>I was hoping the introspection would not be essential to use the
>interface..

Depends on the user/subsystem. Either families_dump op could be used of
udev uvevents that also carry family inheritance chain:
    CTLV_FAMILY=ctlv-attestation-tdx
    CTLV_COMPATIBLE_0=ctlv
    CTLV_COMPATIBLE_1=ctlv-attestation
    CTLV_COMPATIBLE_2=ctlv-attestation-tdx
    CTLV_COMPATIBLE_N=3


