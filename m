Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701849;
	b=kBxk/yFqkGaQqwju8CaOvLPuYDvMxX4iClfvUDKHYZYGIGc7d6Gci7KWpMowekVk9ouQ
	 2hpxXWXeJSmuukbYYg573OyT4whklXQ9hmzsjGhUG0FXcg0EGHmJ0xzEH0y2aHKCfff5z
	 INKNwC8BcmvoSH+3I0odmTBcEqXSSxp+jvz9aSQQVRIQaHo7abEm3TxgiFLHcrtKIMauh
	 axhJA+pjmRBmdd6f0DaRDY5L1n6HyvXHWlJ8RonB2fKbdVvXwuzeU8TBChteTX9CrcAcb
	 vGLsd/1zcmiNP0p45OSR+ltMay/4c2fFWx9bKCP2ot7IuNrY2k2YkiYtxeOJEVO6uCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rUKedcpVkiNEfx49bKB2qoAIuRwcwKKFeuE1z3r00s0=;
	b=NQb7pTVRGG8jnX2hhT7yl7VvRFfdhh/6JQ52uJDp2k/legc0YZVfkWzVwqBPtbhFtLdq
	 aWWorK5kVLPHjdUwoTYVWHrJ5pR2C4iQ4lnMiWVmESpcb+VfOI0dggmgF7pH0fikMocMy
	 n5smb2jOv+8KcKjQmWhHxKrvAYkB8pmm+CKJmD74+6DIlxG2vX/O3Dv/bVriD5qjYrWdh
	 N/caTBqgPydCI/xFNrWLWiftffZ/eAq7TBX901iYc13K9XLiDHxfmE6RKrjgi1WkR7ml8
	 HUmBVZz+Vz+AnhlLD0XenpzURs4/ZyB+VgNuWXWe4Mofc2c/q5RhR8BNuD/2cXVQOaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b="lGHJ2/7A";
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE791606A335
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 10:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE791606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=lGHJ2/7A
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5ba328513b9so3750871e87.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793701846; x=1794306646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUKedcpVkiNEfx49bKB2qoAIuRwcwKKFeuE1z3r00s0=;
        b=lGHJ2/7A+c8PAoafyItHPUKePCeXbliM9fGrD5xJcz3JpBqpvmtWUxQjud4v3HS62O
         o56E7Kb9SRzktK6NhMfa+6ZtWZSbmJt5LWEKR7WrQ7rUzzjWF1A7JanQ/LBl9m+BcH5b
         Hzj2p5p+gNiDVEYaUnNESbOXtEC6L+gDN07LWsuh2VkoM20HAjPss5X+ikBTBh7+8MSb
         fRowcjM7MMC/xob+HTP4ofXA99I7jUj/tlGctRB3e4cl8CR6CwYX4+wvJ9ZFiDNJ6clq
         hOUOuJC6Bn7TKlqDLYFX4IfP9cuODLqnkxgxEbNnyzV5lAWIst7n/Yu3jEY4/fh8qwN6
         4tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701846; x=1794306646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUKedcpVkiNEfx49bKB2qoAIuRwcwKKFeuE1z3r00s0=;
        b=dizTRxQQ/tZaMWo/TwaVRUlyIb0sc2+NXbmmFAALixlHkqb9Jf7qgBcR//ASj/xu7J
         uzPtfcsqDNDh1Dg+VdF/1gVqqvmbLJDLKD2fDf3L0UKm2l6ZDnvzQ+fa7QtqMC//tTd0
         bJkXRNyb3eiavJ5byukM3w1SOezowlHHC4w8Cn7PeXu6PdleMU6ZgltFn+14XyNULszW
         t/OCbqOm/gcoH99L1TgqZfCACF+9B4fNvkNbXBuWIhCVlFoT4SYq72p0YLjKMpLvVb1l
         QvLBgF9p/yLKiGMiLHn+VRXgb3gp/wL4hQFEbwa9a36kxARHZaSa11xr04vm8hGZslG+
         7bxg==
X-Forwarded-Encrypted: i=1; AKwUvBxCbirr8LoxlUVuxZD/14PGRhP57HeCqz1ji21R0NiTf/fJSPhlqfVayElywDBGyV4ak8c=@vger.kernel.org
X-Gm-Message-State: APuU4Z86UwGk18gOOlhc5jWyJf6W3Y7m0aIA43OgS4CWMh7Flg/xCAGE
	ZmskP1+DVTJMhxQjJ67LTu5ckXnwLkp430pgHQbzXBTFPySNUWisP7dy1qevVMdNqBQ=
X-Gm-Gg: AYBFou3Qzf3rFq4RzPbkoz353DIOQUizVJ0q1Jgh/ZivYBF2AE2EaNr276SU2bK6vaU
	Vi2z5eGRSWj3ZmtYBNQS4FafkVX9KW5OyfGKwJIy5l6dgGvwoUJZYkaM3kywUJRTtVnwvIMpa0W
	D0OfToTPxXt8BAPIVRIAVbr68Pwvc7ANiolIKq6F1iiOaCqs2vkPmtOHewZehk7xMfa3rTBafTd
	MsBFqlQsgcMBZRd33CCZnzSrZwwONjkYH+qGfjKuEPoIzBJE26GpnY4f+KbAEasEQmrkDQ1J3VH
	IeYWBIyPWvdC2iqBqmHw6haDWKLpaH4x9uExOuwf/ir2C6fIx9iXP0cengKi6VSJHoM9mNCZHL+
	+rms1qxnnG674sdnZtRM/dD8qjmqTeUaDT1sSphhClA0eeRo8Eyz94eX2UKSOKPOxFehKemnrIa
	D/P5ZLgrgILIg++DRzanVKBYbmu16qbFfxuisZgRQYCAh6joLXuGNEYRCVB5hTqMsDHqv+NV0yp
	T/F2FLd3605LuR+PCi4lMr575jqhQYl64DJNU4keLFEscAQoC6k1wSO9INEOb+aqe+mQp7GUUrv
	OiBiPqm4bA99j6DmoIVFzv8Nncb9sVHMvm6z
X-Received: by 2002:a05:6512:3da9:b0:5be:41a1:d2c3 with SMTP id 2adb3069b0e04-5bfd958d569mr4093510e87.49.1793701845873;
        Tue, 03 Nov 2026 02:30:45 -0800 (PST)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe074aad9sm2132213e87.75.2026.11.03.02.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:30:45 -0800 (PST)
Date: Tue, 3 Nov 2026 11:30:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 04/20] Documentation: ctlv: Add userspace ABI
Message-ID: <aum3xbO4lbiBWUtL@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-5-jiri@resnulli.us>
 <auOWFzX5N7HBbcH3@MjU3Nj>
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
In-Reply-To: <auOWFzX5N7HBbcH3@MjU3Nj>

Thu, Oct 29, 2026 at 07:53:11PM +0100, sergii.dmytruk@3mdeb.com wrote:
>On Thu, Oct 15, 2026 at 04:50:37PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Describe the CTLV transport, discovery, wire format and userspace
>> compatibility rules.
>>
>> Assisted-by: Cursor: GPT-5.6 Sol
>> Assisted-by: Cursor: Claude Opus 5.5
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
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
>[...]
>
>> +Errors
>> +------
>> +
>> +A failed operation returns a negative errno. Where the failure is a rule the
>> +message broke and the caller offered a reply buffer, CTLV also writes
>> +error information there in TLV form: a ``validation-reason`` value, a
>> +human-readable message, the offset of the offending attribute, the offset of
>> +the nest it was in, the ID of a missing attribute, and for a stale query the
>> +expected and the current generation. A buffer too small leaves it unwritten;
>> +the errno is authoritative either way.
>> +
>> +What the transport answers with, as against a family's own callback:
>
>It seems like this mixes results of several syscalls (e.g., `open()` and
>`ioctl()`).  Does it?

Right, will split.


>
>> +
>> +``ENOTTY``
>> +    Not ``CTLV_IOC_OP_EXEC``; this transport has one ioctl.
>> +
>> +``EINVAL``
>> +    A reserved field was not zero, ``op_id`` was zero, ``generation`` or
>> +    ``cursor`` was set on something that is not a query, or the message broke
>> +    a rule of the format or of the schema.
>> +
>> +``EFAULT``
>> +    The structure, the request or the reply was not accessible.
>> +
>> +``EOPNOTSUPP``
>> +    The device does not publish the operation, publishes it but has it
>> +    disabled, or the operation is an event, which is read rather than executed.
>> +
>> +``EACCES``
>> +    The fd lacks the operation's declared authority, or an ``O_WRONLY`` open
>> +    was attempted.
>> +
>> +``EMSGSIZE``
>> +    ``reply_len`` is smaller than the smallest fragment the operation can
>> +    answer with. Nothing was executed.
>> +
>> +``ESTALE``
>> +    A continuation whose ``generation`` no longer matches. Start the query
>> +    again.
>> +
>> +``ENODEV``
>> +    The device was unregistered. Descriptors stay open and every operation on
>> +    them fails this way.
>> +
>> +``EBADF``, ``EIO``
>> +    A blob descriptor named something that is not a file, or the file refused
>> +    the transfer.
>> +
>> +``ENOMEM``
>> +    The kernel could not allocate what the operation needed.
>> +
>> +``read()`` answers ``EAGAIN`` when no record is queued on a non-blocking
>> +description, ``EINTR`` when a blocking read was interrupted, ``EMSGSIZE`` when
>> +the buffer cannot hold the record at the head of the queue, and ``ENODEV``
>> +once a removed device's queue has been drained.
>
>[...]
