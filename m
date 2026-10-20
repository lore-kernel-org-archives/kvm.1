Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499226;
	b=0UxQoESjLQjrw7+TCw5esCsrZ//nHeBcOMbCsqHgowD0zUMGFsSq1rhXIKagnrQm2j40
	 2s0expTSXrFqyrZyfrcee6f6AAujYTA+Kujm8p+nQVbFv6W6b+MCzzPCI/9kcMq4NQncB
	 3WFAevGcghtW0gPGZ5MVXF39Vbfbo3mCifmPDQRJdp0gAciy3xQ7uXGZPik35YwOdkis5
	 x0CBWr5BOp2lHiYTp8dQCypQ+V1tT3N2b6YM5/qyFZqpiYGVeUNCSfhz2MidBD0Kz1Q3i
	 3rZMRZ2T1rGkwQRBcpV0KVuUTL54bMIiBQXBnxCgZAWW/klKrbivDyz0Ir2RXTC+uTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=r+JXJ7/RizMzNWpQZbCi3pXUDD6ZYso7OnyQ+kdiZlM=;
	b=JwgYSpWKpJJhpAdxr53FmHADg0R2PKf6gmE1B9wdLF31uwKkMOFPxqsRB6zCucHQCSa+
	 v8ijR4MIkBdv+hUnR/Q2lQmEMnQZwmz2kcsT0UuMoR9pksSfnK4rDXx8klEALjRBZqUEC
	 LD/uTGEEccVILrJmSrnDwlacQbcUlN8UA8jaU+sE+FlUOpyXJFR1p+fwxeBz5tE9blEEi
	 P4g+qCKIB61LEma9PIjV5EhBV7eoG9Y7/ZKkBnulEKIjAZmZI5e2w61pRlgJGr90E7Day
	 9FMeAAr2Wi3Ts6ODKDIuUWkUan0sJwXsKvWDJsQGgmBSfUZerIIdNVY8gmWjRydSwuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=resnulli.us;
	spf=none smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hFWwiKZY;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C76606A31C
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 12:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C76606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hFWwiKZY
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so22222415e9.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1792499217; x=1793104017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+JXJ7/RizMzNWpQZbCi3pXUDD6ZYso7OnyQ+kdiZlM=;
        b=hFWwiKZYM9mL6E9PjvXPJ3WGnS6fCoA5M4DIXCiZ7QxzFi2/LcC4qvf+KiToBx11vf
         GRItbzTNaPMrrqtIFRswHSZ98neyu90Uq5IfSu4sQ36KzvEhbpjmB1UwNwd7qYf4BWxN
         bDz3iEsnC7hCleu9A1kqlb5Rzg4kdPeLjcGlV31/IXxUBLh7w3J02q1/tfvUIz81uOS/
         UEM6+101n2rlxfRua/iUXIXttcSlcn3JJy+8PQ0VU6ITRl8uQjt14rR220smlHCvOj+l
         C6Q2+TncSYuWzfBvITAgECC4jVu0YXsBeECg75adzeCZE0pz4lYpLhgty1FCkfWqLh1e
         sotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499217; x=1793104017;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+JXJ7/RizMzNWpQZbCi3pXUDD6ZYso7OnyQ+kdiZlM=;
        b=vRMOujS6AC+t5SY7dvfcgTFqxmmHKn7aBN7ZfiO4mS3LOh/hT+MbmuV5S3NwIDNieP
         j7Kz//pI08wBiC8U6tGFlMGs5plseWpY1fGGn1169fOncDkH/glvgH6e/x4ZF2pFlGDz
         HaDlxJwfET5lrJkoy3o0wBLcMO+613FqlLPMun3/+Pb7rSO4IlTzZfoqe5tYsh69Gm4f
         //TZH9Od5N4z4+zvTKqYSoaiFRaUkhRoCsgT0zXTq48y3n0U/R8mC8tsTIadLLhp7klY
         Aqk60k4vlrl4+VbBgLGjlyRC3L2dQlHolW50VkWdwAk5CmdowLknR4Te5zxMHoch7gxI
         0ueg==
X-Forwarded-Encrypted: i=1; AKwUvBzhoIONUfGRd8Epw4S9/OAhoiWDmi4EpkbbztTn0+SfGvZ2ZKs6sKw5QY7PgRjJOEXxwFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4VZOxbboa6J0Pw3MEBbUtHnDtYT9MZpHVDdi5Sc3OKT6kXDrv
	bQgSokbMnQ+PitsrpkAPwkwGPtXV8cAqP1PhQKjFS55aAalBc9jYkRUWj2Xt9md2BOE=
X-Gm-Gg: AYBFou0ABOjVzlit5k4j7H9OllProcSHVeTJwdBOf1W8UxeCZwiA4gxhFJES1ZazLvp
	RDVV+vZZMexkT70R6zo4OS9kjhywe8q8J4S3lyy5vWPEThy7dox3ZNFyQ2LKY3aeEKqHR7gANcp
	gk8DTlo8a/SUHr5ATDAIJDMTqm7Ch3ZQBWxhb4EkEx8hi2D537bDVuYoVy+LWsn4JXvdmXZRt4J
	0AydK0zsxj/WXj9uz9QPq3Tt1DeFWKs0cqHwE8UcPmF1S1eAN4hFqiNHEk0sO6bKHfiRfJnon2f
	3QH+r4zTO+IsspXrpZljGMS9lQ+s7I/LpoHq0Hvm5TS3pcWiYfJC3jqjfNx41krp3qnGxVJ+uIA
	6oQiM1fUVV06PlF0ComsgcCXBpPziyoeA5kW7/ZQeJGltRHJ7fq91sVt9kfLhkxt4PbwDFIZJ3e
	FZUzSpdEwdIhtXl7MbpE8sEHM0I9YcI3RUPNZRObCY2kUuECQ28IF0z1XKZtqlY70iwJ6tCUM/p
	FWU
X-Received: by 2002:a05:600c:34c5:b0:4a1:dc8e:edc1 with SMTP id 5b1f17b1804b1-4a1dc8eee6dmr208638065e9.0.1792499217319;
        Tue, 20 Oct 2026 05:26:57 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm69425855e9.14.2026.10.20.05.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:26:56 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:26:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 02/20] ctlv: Add the UAPI wire format and family API
Message-ID: <atddoIx-sA2eheSu@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-3-jiri@resnulli.us>
 <179245258504.58760.15790996354033644110.b4-review@b4>
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
In-Reply-To: <179245258504.58760.15790996354033644110.b4-review@b4>

Tue, Oct 20, 2026 at 01:29:45AM +0200, jgg@nvidia.com wrote:
>> [ ... 159 lines skipped ... ]
>> +#define CTLV_NODE_SCHEMA_UNLIMITED 0
>> +
>> +#define __CTLV_NODE_SCHEMA(_attr, _kind, _occurrences, ...)	\
>> +	{ .attr_id = (_attr), .kind = (_kind),			\
>> +	  .max_occurrences = (_occurrences), __VA_ARGS__ }
>
>This reads alot better without the extra macro layer. The point of
>this is to allow the codegen output to be concise it is worth being a
>bit more verbose here so the exact form is easier to see.
>
>> +
>> +#define __CTLV_NODE_SCHEMA_CHILDREN(_first, _count, _required)	\
>> +	.first_child = (_first), .children_count = (_count),	\
>> +	.required_children_count = (_required)
>> +
>> +#define CTLV_NODE_SCHEMA_ROOT(_first, _count, _required)	\
>> +	__CTLV_NODE_SCHEMA(CTLV_ATTR_ROOT, CTLV_SCHEMA_NEST, 1,	\
>> +			   __CTLV_NODE_SCHEMA_CHILDREN(_first, _count, _required))
>
>For instance this is much more directly readable:
>
>#define CTLV_NODE_SCHEMA_ROOT(_first, _count, _required) \
>	((struct ctlv_node_schema){                      \
>		.attr_id = CTLV_ATTR_ROOT,               \
>		.kind = CTLV_SCHEMA_NEST,                \
>		.max_occurrences = 1,                    \
>		.first_child = _first,                   \
>		.children_count = _count,                \
>		.required_children_count = _required,    \
>	})
>
>Even if it is longer, and and clangd can now jump to the struct members
>
>I also think each of these should have a one line comment explaining
>when it is used.

Okay, makes sense.


>
>> [ ... 61 lines skipped ... ]
>> +#define __CTLV_STUB_SCHEMA(_family, _set, _node, _optional)	\
>> +	{ .family_id = (_family), .set_id = (_set),		\
>> +	  .node = (_node), .optional = (_optional) }
>
>Same here

Ok.


>
>> +
>> +#define CTLV_STUB_SCHEMA(_family, _set, _node)			\
>> +	__CTLV_STUB_SCHEMA(_family, _set, _node, false)
>> +
>> +#define CTLV_STUB_SCHEMA_OPTIONAL(_family, _set, _node)		\
>> +	__CTLV_STUB_SCHEMA(_family, _set, _node, true)
>> +
>> +struct ctlv_schema_tree {
>> +	const struct ctlv_node_schema *node_schemas;
>> +	u32 node_schemas_count;
>> +	const struct ctlv_stub_schema *stub_schemas;
>> +	u32 stub_schemas_count;
>> +};
>
>I've been ponding for a while what 'stub' means in this context.
>
>AI suggested "extension_points would be a clearer name here." I guess
>because ctlv.rst calls it "Inheritance and extension points" ?

Will think about rename. Pehaps better documentation&comments would be
enough, IDK.


>
>> +
>> +#define CTLV_SCHEMA_TREE(_name) {				\
>> +	.node_schemas = _name##_node_schemas,			\
>> +	.node_schemas_count = ARRAY_SIZE(_name##_node_schemas),	\
>> +}
>
>It is helpful to put the struct on these macros ((struct X){})
>
>#define CTLV_SCHEMA_TREE(_name)                                         \
>	((struct ctlv_schema_tree){                                     \
>		.node_schemas = _name##_node_schemas,                   \
>		.node_schemas_count = ARRAY_SIZE(_name##_node_schemas), \
>	})

okay.


>
>> [ ... 127 lines skipped ... ]
>> +typedef size_t (*ctlv_family_priv_size_fn)(void);
>> +typedef const void *(*ctlv_family_pre_init_fn)(const void *init_info);
>> +typedef int (*ctlv_family_init_fn)(struct ctlv_device *ctlvdev,
>> +				   const void *init_info, void *priv);
>> +typedef int (*ctlv_family_post_init_fn)(struct ctlv_device *ctlvdev,
>> +					void *priv);
>> +typedef void (*ctlv_family_pre_fini_fn)(struct ctlv_device *ctlvdev,
>> +					void *priv);
>> +typedef void (*ctlv_family_fini_fn)(struct ctlv_device *ctlvdev, void *priv);
>> +
>> +typedef int (*ctlv_stub_fill_fn)(void *priv, struct ctlv_op_ctx *ctx,
>> +				 const struct ctlv_cursor *request,
>> +				 struct ctlv_cursor *nest);
>> +
>> +struct ctlv_stub_ops {
>> +	u16 family_id;
>> +	u32 set_id;
>> +	ctlv_stub_fill_fn fill;
>> +};
>> +
>> +#define CTLV_STUB_OPS(_family, _set, _name) {			\
>> +	.family_id = (_family),					\
>> +	.set_id = (_set),					\
>> +	.fill = _name##_fill,					\
>> +}
>> +
>> +struct ctlv_family {
>> +	const struct ctlv_family_schema *schema;
>> +	const struct ctlv_family *parent;
>> +	const struct ctlv_op *ops;
>> +	u32 ops_count;
>> +	ctlv_op_pre_fn pre;
>> +	ctlv_op_post_fn post;
>> +	ctlv_family_priv_size_fn priv_size;
>> +	ctlv_family_pre_init_fn pre_init;
>> +	ctlv_family_init_fn init;
>> +	ctlv_family_post_init_fn post_init;
>> +	ctlv_family_pre_fini_fn pre_fini;
>> +	ctlv_family_fini_fn fini;
>> +	const struct ctlv_stub_ops *stub_ops;
>> +	u32 stub_ops_count;
>
>Having the function ops in a struct use typedefs instead of just
>coding the signature is unkernelly, I couldn't figure out what this
>was done, it seems there is no user of the typedef

Right, will remove.


>
>> [ ... 182 lines skipped ... ]
>> +/* Implementation limits, not wire-field maxima: raising them is compatible. */
>> +
>> +/* Request roots, action replies, query reply fragments and event roots. */
>> +#define CTLV_MAX_INLINE_MESSAGE_LEN	0x100000	/* 1 MiB */
>> +/* Includes the error information root. */
>> +#define CTLV_MAX_ERROR_LEN		0x4000		/* 16 KiB */
>> +/* The root attr is at depth zero. */
>> +#define CTLV_MAX_NEST_DEPTH		32
>> +#define CTLV_DEFAULT_QUERY_REPLY_LEN	0x10000		/* 64 KiB */
>> +#define CTLV_MAX_EVENT_QUEUE_LEN	0x1000000	/* 16 MiB */
>
>If they are just random kernel limits I'm not sure they should be in
>this uapi header?

True, will move to internal c/h

>
>-- 
>Jason
