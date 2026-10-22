Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659686;
	b=W2YFrRns+oniXqHHWYtn4W+Jqbo54Cz2FRRxG7bFUr00mes21Jl7KwJrB8/El8Y3w2Yj
	 wq29NlEjOlOzNB3cLiyTPj8fipAWeCRe4Le/vr9gihC07LBX6eo3oBYFbjgmHwxWKiPih
	 33rq34+OGRAKMachp7z/2WDcrJueR65Gyrxie/UOAk+XTUztgMxEWGJM6eIV1mhrNQJIy
	 EtCfNuCfj0N+lc9+BsYk6GU0hdE1JTK+3oleP4xJOztbvvLe9M9JZPSCvPn2/WdUMRs2P
	 tGvdKeVt6Y4V7MHBGJDjgmzzvxNzLg0d+DLD1OqGMTQ5YfuQISG6MwOQbGCiJRSJ/cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1M91N4x2jkXM5IsJ1QyquMgQ5eQNEUvnCoLpXjporvk=;
	b=Sl9UX7qXaAaTZqTXWhLpukOheAK6DfGG38iktF6WOpAjXDf7sF7d62AekEIe8LA9Apdx
	 vCdm7KGfPC+nMfd0QKO9H+o3TAKGtVdW9vH9oQfxiMidcfFR79SVd0EErKAsNA8yt6Txz
	 R7ju/n12h0F3MiUJpM8iUQLWEPdm802V9MgsVExSFftzv68rr+qychp1DXHqZJ1FQA3Wk
	 hyKBegy4RqdKzzF3ZTFM0jjXFfKb5/Nhteb4szAPVwM8yEqgWh3b7GgCPoAQnkA+BtDqR
	 2y9Ip9FXyQsg5nFK1jcVPr5lcQOHia0bCINPHnRfhpkhd2nUc1JlrTExQRWEeKRRYZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=Xm48qF+c;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D993606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 09:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D993606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=Xm48qF+c
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48bbb06e746so956956f8f.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792659682; x=1793264482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1M91N4x2jkXM5IsJ1QyquMgQ5eQNEUvnCoLpXjporvk=;
        b=Xm48qF+cavnI98CF+FEn/aOxyHWgeA3QXlxnHWpH3APrUrU8fL5Hv7ngylFDNiVRFf
         KLRVlNPYWp5uQRbptpw7dmjARCTX6hyvPjudnH1BR9vJkURRrYYlYsQ4xIGz3EY4nmtx
         DNKCGAE6z/pV56Q1SmnhXJGfaqt3IIO14tP+14apQIkSbLbaI0Lc9wrxsBqDX4YZSZbo
         YAWQMfGUijXDz9xbZO0Hp5w2IX3uQnKAZOqRiKKnJcMMWeJUVV9CbO/7a9ZhwP8I3ntm
         v/lg6DzpLwRLx620WELZZ4owoq2j/v8lkWWZCgphvLuUOyAH4G/QMGpqypk/XZtDnUf9
         Ixxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659682; x=1793264482;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1M91N4x2jkXM5IsJ1QyquMgQ5eQNEUvnCoLpXjporvk=;
        b=ivEcwmZh4fSJp3m/jI5jNuPSTDZRfH0RXEXxEC7m8GGW+kFI8bgYKDPG8hA8csbLds
         cMLWbdufrSApiYnlnLKpzqmfmKkbZJoryQG5A0S5yZn/gPjPtQdjwQQWDLVsBmc4e2JD
         vUPJjDVExDzF0FvrtdX5Z7cVbdeBrU/BCve2D8iV5LaOYADjMKhJMyJ9Qz7BkaKr+u4q
         u+dOsrCHFHQiE9hdDtnYAXfF0qx9m56fcr5NjO3L3OrSqHuAtGTOdq3f3Bff23vtzEwj
         BiCzcpAUF/CEKd1Elq/csCP1YbLKgHwNG5QPbhB721f1eo0i3Jz7BcZtu8Ryr8kvYbN1
         ejQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXnzRPp2QmfRgAGM+YMLOYk3XtfVTqPSjN8wGRAE9g0fNcc7MLaEwvd5187MsDXLLAwjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbmnLZs7Z/02h8BCoXeEKRWgKkGIqSM31qHlDzUOnBBKF/f7j5
	8HNk0yQF43lKR3excahl4+KYChdufxMND0D9Id0484emq9+klNuO9+7UYS35EMzwiWU=
X-Gm-Gg: AYBFou01h0cXwP+sjbxILRQCSq3OhDINTPuYrHWZwTv/fT8IeS/H6MPxuP/1N5ThIyO
	N9LhOaFoxcUnZeO0PyAnLZpf3KT+YxtQ38GDPLVvIxoY71LYZit9NV8fwm9Da83NzUJScRctCzm
	mNB5P/MpCt/gx7OFyxMZWJrBpcEoO1Kpacv+DyN3svrzC5l1TP5sfkjpcuReY1DCx146Qb9cxHy
	oTpAye9oJL+3JQEgViC2henK0xyoEnHNdeNu/fxoCBWw6tQ5JKDmCN2+HFQRMpp8kNwI0soXqA/
	GYtqcPyW0fkCQTfoo0tkmrWsM+do6HpKcLuKSbR1mGpAqsO609yGZ0srpmaBA/ZItyrE0aYbT90
	7ThCy3SUL2nZgnLS/bR9pAIFWuJxHOyfuGD94mKg0eRiKzWZ8eOF/CFLxR7BKc7OmsKp7MuvcOR
	7VJMrnthd/iqWr9kLQw4F6Lzzub6GUYv+jM908ZlZSYAhr1qWTN3yTTKmWjZLQbc1NTjPsN47cb
	0mW7bYVdq22rUJY+Otzr+bE6D/t22JENUohWBu6AYgbrdkh5moa7kCgtELL6GNq
X-Received: by 2002:a05:6000:e46:b0:48d:b940:af7a with SMTP id ffacd0b85a97d-48e26511828mr6746766f8f.55.1792659682008;
        Thu, 22 Oct 2026 02:01:22 -0700 (PDT)
Received: from localhost ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25834086sm11228550f8f.34.2026.10.22.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:01:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:01:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 04/20] Documentation: ctlv: Add userspace ABI
Message-ID: <atnJUfh0_Y3BRKx3@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-5-jiri@resnulli.us>
 <20261021011122.2cd96901@jic23-hlaptop>
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
In-Reply-To: <20261021011122.2cd96901@jic23-hlaptop>

Wed, Oct 21, 2026 at 02:11:22AM +0200, jic23@kernel.org wrote:
>On Thu, 15 Oct 2026 16:50:37 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Describe the CTLV transport, discovery, wire format and userspace
>> compatibility rules.
>> 
>> Assisted-by: Cursor: GPT-5.6 Sol
>> Assisted-by: Cursor: Claude Opus 5.5
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>In general looks good to me - this let me get my head around
>what was going on nicely (I think!).  A few trivial comments.
>> ---
>>  Documentation/userspace-api/ctlv.rst  | 507 ++++++++++++++++++++++++++
>>  Documentation/userspace-api/index.rst |   1 +
>>  MAINTAINERS                           |   1 +
>>  3 files changed, 509 insertions(+)
>>  create mode 100644 Documentation/userspace-api/ctlv.rst
>> 
>> diff --git a/Documentation/userspace-api/ctlv.rst b/Documentation/userspace-api/ctlv.rst
>> new file mode 100644
>> index 000000000000..5ebca3d4d94a
>> --- /dev/null
>> +++ b/Documentation/userspace-api/ctlv.rst
>
>> +Discovery
>> +---------
>> +
>> +Both uevents, addition and removal, carry the family chain as numbered
>> +properties::
>> +
>> +    CTLV_FAMILY=ctlv-accelerator-foo
>> +    CTLV_COMPATIBLE_0=ctlv
>> +    CTLV_COMPATIBLE_1=ctlv-accelerator
>> +    CTLV_COMPATIBLE_2=ctlv-accelerator-foo
>> +    CTLV_COMPATIBLE_N=3
>> +
>> +``CTLV_FAMILY`` is the family the device answers as, the numbered properties
>> +are its ancestry from the root to that family, and
>> +``CTLV_COMPATIBLE_N`` is how many there are. An index never moves: changing a
>> +family's parent is an ABI
>> +break, adding a descendant only appends.
>
>Odd line wrap.

Will fix.


>
>> +
>> +A program that wants every device, including ones appearing while it starts,
>> +must listen before it looks, which closes the window between enumerating and
>> +subscribing::
>
>> +A whole message with every offset, for a request of one integer and one nest
>> +carrying a string and a further nest::
>> +
>> +    offset  attribute                       len  flags   contents
>> +    ------  ------------------------------  ---  ------  ----------------
>> +         0  root                            120  NESTED  attr_id = 0
>> +        16  .. chunks                        24  -       8-byte integer
>> +        40  .. chunk                         80  NESTED
>> +        56     .. label                      19  -       "ab" and its NUL
>> +        80     .. item                       40  NESTED
>> +        96        .. value                   24  -       8-byte integer
>> +       120  end of message
>> +
>> +    +--------------------------------------------------------------+ 0
>> +    | root: len = 120, flags = NESTED, attr_id = 0                 |
>> +    +--------------------------------------------------------------+ 16
>
>Diagram wise, should chunks and chunk be shown nested inside root like your
>.. above is indicating?

Oh sure. Missed that.


>
>> +    | chunks: len = 24 | payload: 8 bytes                          |
>> +    +--------------------------------------------------------------+ 40
>> +    | chunk: len = 80, flags = NESTED                              |
>> +    |   +--------------------------------------------------------+ | 56
>> +    |   | label: len = 19 | payload: 'a' 'b' 0 | 5 bytes padding | |
>> +    |   +--------------------------------------------------------+ | 80
>> +    |   | item: len = 40, flags = NESTED                         | |
>> +    |   |   +--------------------------------------------------+ | | 96
>> +    |   |   | value: len = 24 | payload: 8 bytes               | | |
>> +    |   |   +--------------------------------------------------+ | | 120
>> +    +--------------------------------------------------------------+
>> +
>> +``label.len`` is 19: its header and three payload bytes, not the five bytes of
>> +padding after it. ``chunk`` counts those five, its ``len`` of 80 being its
>> +header plus ``CTLV_ALIGN(19)`` plus ``CTLV_ALIGN(40)``. A walk over a nest's
>> +children advances by ``CTLV_ALIGN(child.len)``, a walk of one payload by
>> +``child.len``.
>
>...
>
>> +
>> +Request occurrence order
>> +------------------------
>> +
>> +Occurrences of one attribute ID must be contiguous within each request root or
>> +nest. ``A A B`` is valid, while ``A B A`` is not. An ignored unknown attribute
>> +is not an occurrence of any known attribute, but it ends the preceding run, so
>
>An ignored unknown attribute, whilst not understood, ends the preceding run, so ..
>
>(or something like that to avoid saying unknown is not known ;))

True, this is already subject to reword anyway :)


>
>> +``A ignored-unknown A`` is also invalid. Different IDs otherwise have no
>> +required numeric or schema order.
>> +
>
>> +
>> +Executing an operation
>> +======================
>> +
>> +One ioctl executes every operation::
>> +
>> +    struct ctlv_op_exec {
>> +            __aligned_u64 op_id;
>> +            __aligned_u64 request;      /* struct ctlv_attr __user * */
>> +            __aligned_u64 reply;        /* struct ctlv_attr __user * */
>> +            __u32 request_len;
>> +            __u32 reply_len;
>> +            __aligned_u64 generation;   /* queries only */
>> +            __aligned_u64 cursor;       /* queries only */
>> +            __aligned_u64 reserved[2];  /* must be zero */
>> +    };
>> +
>> +    #define CTLV_IOC_OP_EXEC _IOWR(0xBB, 0x00, struct ctlv_op_exec)
>> +
>> +``request_len`` is how many bytes the kernel may read at ``request`` and
>> +``reply_len`` how many it may write at ``reply``. They are copy boundaries, not
>> +message lengths: a root's ``len`` may be shorter than ``request_len``, the
>> +bytes after it being ignored, and may not be longer. 
>
>I don't really mind this but why have this relaxed? Whatever sent this request
>just filled in the root len so why wouldn't it use the same value for this structure?

Yeah, I was thinking about having it relaxed or not. I did eventually go
with "why not". Makes userspace live perhaps a *bit* more easier having
one buffer and buffer_size for multiple op calls.


>
>
>>``reply_len`` is never
>> +overwritten; the length written is the reply root's ``len``. The pointers are
>> +fixed-width so a 32-bit and a 64-bit process pass the same structure, and in
>> +place of a size field the ioctl number encodes the size and ``reserved``, which
>> +must be zero, covers compatible growth.
>> +
>> +Every action and query carries a physical request root, including an empty
>> +request. ``request_len`` is therefore at least one attr header and at most the
>> +1 MiB transport limit.
>
>Why this particular limit?  Any thought to making that discoverable rather
>than fixed? (with a minimum to allow the operation for the length to be discovered).

OPS_DUMP exposes max size per op already. This limit serves different
purpose. It is a safeguard againt insane family yaml author. If he would
try to fit in ridiculously long binary attr, it would provide a clue to
use blob attr instead. I think that 1M is too big. I would perhaps go
with 64k initially. As it is kernel internal limit, could be changed in
any time. Makes sense?


>
>Maybe it is better to just have fixed size.  I wonder if ultimately we
>may end up with cases where the tlv is just passed on to firmware / device
>(because it is nice and convenient!) and having to split or marshall
>multiple messages would be a pain.

hmm. tlvs passed to device would work, you would just have to take care
of the blobs inside.


>
>> The ``request-max-len`` reported by ``ops-dump`` is the
>> +maximum request composed from the known schema; a newer caller may exceed it
>> +with well-formed unknown attrs marked ``IGNORE_IF_UNKNOWN``, up to the
>> +transport limit.
>
>> +
>> +Events
>> +======
>> +
>> +An event reaches a file description that asked for it, and only that one:
>> +
>> +1. subscribe with the ``subscriptions-add`` action, naming operation IDs;
>> +2. read records with ``read()``, one complete record per call;
>> +3. unsubscribe with ``subscriptions-remove``.
>> +
>> +``poll()`` reports readability when a record is queued. Each record is a
>> +header followed by exactly one root attribute::
>> +
>> +    struct ctlv_event_hdr {
>> +            __u32 length;             /* header + aligned root */
>> +            __u32 flags;              /* zero */
>> +            __aligned_u64 op_id;      /* the event op that produced it */
>> +            __aligned_u64 sequence;   /* per file description */
>> +    };
>> +
>> +One ``read()`` returns one record, the header and the aligned root::
>> +
>> +    +---------------------------------------------------------------+ 0
>> +    | length = 24 + CTLV_ALIGN(root.len)     | flags = 0            |
>> +    +---------------------------------------------------------------+ 8
>> +    | op_id: the event operation that produced this record          |
>> +    +---------------------------------------------------------------+ 16
>> +    | sequence: counted per file description                        |
>> +    +---------------------------------------------------------------+ 24
>> +    | root: len, flags = NESTED, attr_id = 0                        |
>> +    |   the event's attributes, exactly as a reply carries them      |
>
>stray space.

Will fix.


Thanks!


>
>> +    +---------------------------------------------------------------+ length
>
>
