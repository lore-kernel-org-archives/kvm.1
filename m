Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657680;
	b=vhNtHVbVTd6gYDXxi+VAYocHm1NTM6zQ2jQNOtnpg5mpFJdhTvHumKQ8bQrA4nAt+qO7
	 3gnksn2x9EpMOsnh+6CizJaV+EUfc6ekLsNglxAeN9oaX9LW1LfDAIK2Cc5xr6OqtewYh
	 1cx0y4l/CoWM0qA4oBipQd42sishww8wGXlbtnEWgHCWkneKnFfy9Q4xphKpqr7ITvYgM
	 LyO9ApycIfPMIxQ/VIMfDSIFZOXh6nx+U8Qkl/PYV7RNDNHv0z3A5Mjd09hliqTWiwXa0
	 /UAgPiAIqqH8jLD4whbt9DXNvkfzJz0YumcSHAQLxZ6yO5CPeo6a2WNj734jpT8ebAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=asTQwS3Q/pIZmKtVtb/ZZcYojtRdxCAchkNTDOljnRg=;
	b=zMEXVTlXRRowOTTA6B//yFjgU/49lnrvg3wBu+TYkR9t6C0KzcgcDDnDFNonhG8LouDe
	 uAlcAyYTG2094PY9Hw7CauHZSkj/C3BCemSNyBEvMT3XlGB3vxRfW46C9jeQozQsSTTxv
	 pdhKYU0InQXHrZ3UMw4xJTeWP77POwerwF4yDppdWrjWJxVhurnTMVEhtkdmlgKiuBcf5
	 BhVNxt5kwdb0NUl62xLbB0kPLqAVKj/VwWeOxNTHWRRWAlS3PcT4dZYP82qqqK5nNTfQw
	 mUQu6jQ65/MdPVTBhkG222V/hV1gSUPym6sYNfKZVnFKM2VdJn1OJzBvEI8T+gX9UdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b="Xqn/2yUi";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1A606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 08:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=Xqn/2yUi
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a208d93758so3485485e9.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792657677; x=1793262477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=asTQwS3Q/pIZmKtVtb/ZZcYojtRdxCAchkNTDOljnRg=;
        b=Xqn/2yUifSYwd1lLkvjTelhwbh1/fDxIkgCiTBzt6jpzF2b6Jtj1W+vx0Bue+MUy58
         9u42cvxmjlsJRbnQR2g3CWbj4u0rkL/k1ULnZYHkA6SYgBSLjiaJLKo7XUYZtC7tNenJ
         rsFukD01VvOvzDd3SE4W8Oqv/En+hGSOb1IleVA+BPtjYtldui+qaj/eFrGXDbDTs6Zh
         HQUgjRlg+/mxJFoLyy6ZYJH45n5kbvVwK0xr1YtKjqBE0q6RxnBXsMTT0TqpvW3YuGgS
         6xjeAh+dj5PSGSU8D18ZjCN3TeNPZns36H6lwwUccK2iJaoVhrAUeKBlAglwvy3XGzs4
         TAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792657677; x=1793262477;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asTQwS3Q/pIZmKtVtb/ZZcYojtRdxCAchkNTDOljnRg=;
        b=lqOjE51IU1rnXvFhFNrrH/BwRfGcZS4Ac0vQCu81pcXDpb80yp41cPfcn+MdMmebmw
         j1udaQ6ByabT4ScnLWNLAGv1shOBYDeO3JLEFxcay6QABPqcBkQDX7QLdSypBS7cxcKf
         pX/KMfOY2kxb63SiYUUd72U44tAgUlvoCiaPu3km4B4I+MlLNPITInUlEpghClZJzFct
         xFD5pCKhlEOtJv8G4SGqQZ4/qhZKaH8iIrNUpHZAtFf/MXwPfFNOtig5HUigsRCFgAn6
         LVXKP/wDFapkVCIVptlAK7FJonRHKCkb6m+O7Gx8cdcltFvB4iA7Rv/fSdZtgpUO4lqL
         1tNw==
X-Forwarded-Encrypted: i=1; AKwUvBzMX2wCExIXlP5c93lQKkg1gz0I+uZXS2dUCqi100fEbLN436uNszTb2B4sfXdS1ntIKJQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTF10aba3A0ja1tw29fioeKFaA8FWIdjt3jlvurOCDI/x5bnzF
	r4LOUSJjrx0qyRShh0dXZ4/HGN+WlRk72tYExj7MRxniYCdkJrjrADDeye1nSMhr480=
X-Gm-Gg: AYBFou2ZqV23QrsyF87Q8GDKEHGPbpuX1VitdHvnVI3dIAQkpktZY6IJ56+ZcYt55HD
	WozjzXXgx8DR6I9FrQZLwRsCcz6nxsto0cHLMxY8+/Psho7OnH9jdfYDL+7gzeLfiynf/n9aQMu
	6FaYqaYmiCqsWg0zDcvVxwlh9aLXZFB/V6qGEHqiqXtX5FBJcgTpVniRqJINDQU6TvRRltI3DXd
	slwmyXvuQF0KHAivXyGdSa+DEkydGCCJaZ768RPgttWYvyspy22yi3XuybizRNxpbntXVuBbqsk
	IE8Tg1mIQo56kcTRHgOeiNcYc4+jjfLUDEPE8NWtDf9/UqijaTIAM3LkE6GvsBqyAtUa0CQJN5y
	5jtyUURGOeche60A/VbbxNwcYwzBzini9AoOHRFEunKZBZ9Xk7krRarlQ5Q5ocXjbIw3ck0Xn1u
	T4GmS/8mHEk/eQRt1tpGXoyuv/AMCPZ544P4ZG1gRcH7Tz+L+CR1bn6PiseW0ICCIRU9pzeZ8j8
	RPiTmJvaAx/Ig739f+cLciwMQ9dHzz2ebM/As4vSnKmm7tcUFXj6d/A5fpWCLty
X-Received: by 2002:a05:600c:524a:b0:4a2:994:5750 with SMTP id 5b1f17b1804b1-4a209945818mr14069445e9.32.1792657677030;
        Thu, 22 Oct 2026 01:27:57 -0700 (PDT)
Received: from localhost ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258426f4sm10865456f8f.54.2026.10.22.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:27:56 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:27:52 +0200
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
Subject: Re: [PATCH RFC 05/20] ctlv: Prepare message input handling
Message-ID: <atnIDx6qmLe-geb4@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-6-jiri@resnulli.us>
 <20261021014324.58376589@jic23-hlaptop>
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
In-Reply-To: <20261021014324.58376589@jic23-hlaptop>

Wed, Oct 21, 2026 at 02:43:24AM +0200, jic23@kernel.org wrote:
>On Thu, 15 Oct 2026 16:50:38 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add wire walking, request indexing and validated input accessors for
>> generated family readers.
>> 
>> Keep CONFIG_CTLV unwired until dispatch completes the module.
>> 
>> Assisted-by: Cursor: GPT-5.6 Sol
>> Assisted-by: Cursor: Claude Opus 5.5
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>Trivial stuff only. I didn't attempt (yet) to check
>all the walking code, just get a feeling for what was here. 
>
>
>> diff --git a/drivers/ctlv/Kconfig b/drivers/ctlv/Kconfig
>> new file mode 100644
>> index 000000000000..aed3243c55fd
>> --- /dev/null
>> +++ b/drivers/ctlv/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menuconfig CTLV
>> +	tristate "CTLV character device TLV UAPI"
>> +	help
>> +	  CTLV provides character device UAPIs described by a checked-in YAML
>> +	  specification. It owns the character device lifetime, the strict TLV
>> +	  message format, request validation, reply serialization, the large
>> +	  payloads a request describes rather than carries, per-open event
>> +	  queues and runtime schema introspection, so families only implement
>> +	  semantics.
>> +
>> +	  If you don't know what to do here, say N.
>
>I'd not say that.  Overly cautious for something we expect
>to get fairly extensive use.

Okay.


>
>
>> diff --git a/drivers/ctlv/message.c b/drivers/ctlv/message.c
>> new file mode 100644
>> index 000000000000..7e5742ba8f70
>> --- /dev/null
>> +++ b/drivers/ctlv/message.c
>
>> +
>> +bool ctlv_message_input_rebind(struct ctlv_cursor *nest, const struct ctlv_schema_tree *tree,
>> +			       u32 node)
>> +{
>> +	const struct ctlv_message_input_scope *bound_scope;
>> +	const struct ctlv_message_input_nest *indexed;
>> +	u32 i;
>> +
>> +	if (WARN_ON_ONCE(!nest->attr || !nest->msg || !nest->msg->index))
>> +		return false;
>> +	if (!ctlv_message_nest_index_ok(nest))
>> +		return false;
>> +	bound_scope = &nest->msg->index->scopes[nest->index_nest_scope];
>> +	indexed = &nest->msg->index->nests[bound_scope->nest];
>> +	for (i = 0; i < indexed->scopes_count; i++) {
>
>	for (u32 i = 0; ...

Okay.


>
>> +		u32 scope_index = indexed->first_scope + i;
>> +		const struct ctlv_message_input_scope *scope =
>> +			&nest->msg->index->scopes[scope_index];
>> +
>> +		if (scope->tree != tree || scope->node != node)
>> +			continue;
>> +		nest->tree = tree;
>> +		nest->node = node;
>> +		nest->index_nest_scope = scope_index;
>> +		return true;
>> +	}
>> +	return false;
>> +}
>
>> +
>> +void ctlv_attr_next(struct ctlv_cursor *cursor)
>> +{
>> +	const struct ctlv_message_input_slot *slot;
>> +	const struct ctlv_message_input_scope *scope;
>> +	const struct ctlv_node_schema *node;
>> +	const struct ctlv_attr *next;
>> +	u32 next_nest;
>> +	u32 next_offset;
>> +
>> +	slot = ctlv_message_cursor_index(cursor);
>> +	if (!slot || WARN_ON_ONCE(!cursor->attr))
>> +		return;
>> +	next = (const void *)((const u8 *)cursor->attr +
>> +			      ALIGN((size_t)cursor->attr->len, CTLV_ALIGNTO));
>
>kernel code is allowed to rely on void * arithmetic, so this can be
>	next = (const void *)cursor->attr +
>	       ALIGN((size_t)cursor->attr->len, CTLV_ALIGNTO);
>
>container_of() for instance makes use of sizeof(void) == 1.

Okay.


> 
>
>
>> +const void *ctlv_attr_binary(const struct ctlv_cursor *cursor, u32 *len)
>> +{
>> +	const void *value;
>> +
>> +	*len = 0;
>> +	value = ctlv_message_cursor_payload(cursor, BIT(CTLV_SCHEMA_BINARY), len);
>> +	if (!value)
>> +		*len = 0;
>
>I'd kind of have assumed that ctlv_message_cursor_payload() would not
>set len to anything if it returns NULL.  Thus the default *len = 0 would
>be intact.  From a quick look that seems to be the case making this
>code a little odd. 
>
>Perhaps overly defensive or keeping an LLM happy?
>Same applies on some other functions.

You are right. Will remove these.


>
>
>
>> +	return value;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(ctlv_attr_binary, "CTLV");
>> +
>> +/*
>> + * The room is measured before anything is written, which is what leaves a
>> + * refused attr's message exactly as it was, padding included.
>> + */
>
>Having a trailing comment in a file rarely adds much or indeed
>even more rarely gets read.

True, will remove.


Thanks!

>
>
>> diff --git a/drivers/ctlv/message.h b/drivers/ctlv/message.h
