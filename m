Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585333;
	b=c1jSOZs2f8xqzQXF/uptaWQJNOKRxEyJTWzRkG4WBhdWcU8sakK1PIaxbjRDtjZpPtOj
	 GKXbygHrdloLrBdLyqbseFsPPRABU69RyuJD4MA/k/sZbNlisRRIN+dLQX29JfJvJUGL7
	 mnqEDu3BnD3LDwQCX1KDbdSAEClTF8sSRyI5EKsMGp/d//gKHZ0EspNPNNa4Xqd8ZNS3k
	 Iookhf7NUaOm5TXruqd94c+G4lOmQlbUzBVFb0c83bevwY7ZxxlYB8ISHe3PGMFHnnErq
	 W9q+AMMj8DF3pBZ8wBKWBtYJXrVoi/h2aooMX055vE05Bkx6VeP7p0TAwQ5w6hB/IaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rm3hBAvfv4/5KEdYkc8Srdi1WtJlI4rAIKZdjj9oa5w=;
	b=vJ41zN8Kvrcg2Kgyic6ECo23cwwu7a9GmYXfVpVjFAdegv+X3gpPxXzvjy4S9Q5Q3WbM
	 SRePQCO6RDuYI7x/cW5fV6AJ5jIC1vXxYEk26yAw3gw+IZe7erbnZLwO0Qd8cIdJsM7yI
	 tRozjCL2Z4mCoZY6UrovBN6KKMRkiw5XAsd/OnM+euASjfkNUsPjek786Pfvm2+f+kDzq
	 EJ2KrC4VntfvB5PC0W/6UfuYGreLruy3zWhjmhdKPFjj/HrEXhUuGHX8WwjMK9HMnPQlB
	 F3ItxSlR8rHw1NovljrKCx3HySmzmmQrtTHcbTu3uX8GcXixrOQ0ThZnYRRcsvu7B+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=nwRCC2JX;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD2606A33E
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 15:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47AD2606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=nwRCC2JX
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso196375766b.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1794585330; x=1795190130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rm3hBAvfv4/5KEdYkc8Srdi1WtJlI4rAIKZdjj9oa5w=;
        b=nwRCC2JXB0AbR3hfjrMA1EiAP3NIDIZlwqdfCT3C/t87/F329qLJknDBoWmj7yDZLE
         MfkOJwsUKYpO9fDzOu9Gop8wPGQaXotXwNaAD6bzdRcfLg+oVuCqGeX7EUYMmmJHuyKj
         E7i8awBX72pt3bHPq2nZ87dyI/YToffIqO0AGzFAPBbjR3aMcTiehe1hMSTswGNUScU7
         qDJkI2t0tNu57c+TGXkRRaSsCKHCFSHu/UBpKrxVs/VwUxk/GFv3sZqad97AQ+cThkjJ
         RiXiSph3wF4Mf2fyvSR6hQ8o+wE+CbVWky0N8tF86oTo9s8yOBgVr+Q0yV0ImiPh4h1O
         1TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585330; x=1795190130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rm3hBAvfv4/5KEdYkc8Srdi1WtJlI4rAIKZdjj9oa5w=;
        b=eYBJecA687V94/yIhsDg7mCVQtv7gSEW6acF/rCdCRwV7eOOYp6z2eIdY/jgRpVT7x
         T9nEHrGALy6xgN0zkZSv9hVu2F6eg8kDzuNM6Usb3WpJKCzefFi+uv7JtqEkO9Zc5KUC
         Oawry/KxBD2AZ0MBLITXhzwp324N9IVgJDHKvfMbrbWIY3HqFxXwrMp7g48DYHgtfvMO
         GejnUvown02OAJOfsgA/hdqXSUwdoH7DC1VM/6n8JOk4yOkCpyHkmteX6Qi+EwWUdnZ3
         S2kw5xH9ko9t09naYbyaFHA+VLZUKvTo36kwvgo27edi+lmyxjwDpIXSZ8xuiCUBZOPr
         GGCw==
X-Forwarded-Encrypted: i=1; AL+hErELmzvhLtq1hW6tVkkalFbJAcjdO6yG2HgRHExSIZQTuruziNQ8jwtYxgoHrrr6cPUp/vQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eLHPOjmcwyA9EpeyVNZL3QD/Z86metZvaqIPwNjgWAaBcSAUP
	4xRpC/fK/8qk8+iphL53HUVP/0i44dm5/MRShASNwDud6EEPiuTUaQMAqRyIUreDoDQ=
X-Gm-Gg: AYBFou201mnRKZWCYDNJTKHY4lEJY5R8onhBNiFDPQC6UDvUNZcGleK5J38nfWisiwL
	j8MIk4dC8dhttu44K09P/DrAypJMxFw+qkmtfU8BJ7GCvcgJyrvPGM96F3eu7+jp+3l3He4EPI+
	IWfLUUQrviaXr3XqSlk17hnM5+iKphXFFv1CuWrkWFr0sstp3JqsVbcY2QHvrK+fKt//DksOe9m
	MOBERuA0JX6Hj/0TS7ekpUFgNBLHhnOegI1SF/ZWrwB+uxFC4CBJyntID6yrJcU0nArD6J3yL58
	KhnWBh8ZSI/8W9WDeF00zPCj+whFI4CU86slfwmB5iFht4EdleqajKohFc3yjFb8h2GnORidCQ0
	sZp8DfMZiLBZQPFc90kkiyB4bALwK1RN4RErJTGyR+6oSJG2J1DBg7onydDPUrh2fwMIsYTS6d0
	N1Uvd1tfMMx/ccjWAeggNxewLISUHeNimqbB5Ojb1/sgheDkSv8JGSL2MljUCCGTuCnzma9BD96
	ep+1CpAuG813/P6to6Lzl2KnpLL890ZhTW8T6nGIBoz3DCIa8gyhE4VjgpGPwLexvWCDFIMVRZJ
	WkoSxnIpevUGLqI5g8AYR5CYowGqN6QsYe5no+vF
X-Received: by 2002:a17:907:3e97:b0:c46:ba33:1f0a with SMTP id a640c23a62f3a-c509634a301mr255739466b.31.1794585329489;
        Fri, 13 Nov 2026 07:55:29 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23708sm114618166b.24.2026.11.13.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:55:29 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	jgg@ziepe.ca,
	david.quigley@intel.com,
	lukas@wunner.de,
	ksinyuk@kernel.org,
	rodrigo.vivi@intel.com,
	cedric.xing@intel.com,
	sameo@meta.com,
	drdeeglaze@gmail.com,
	James.Bottomley@HansenPartnership.com,
	aik@amd.com,
	jpiotrowski@nvidia.com,
	qinkun@google.com,
	pgonda@google.com,
	jic23@kernel.org,
	alistair.francis@wdc.com,
	ankita@nvidia.com,
	suzuki.poulose@arm.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	peter.fang@intel.com,
	jarkko@kernel.org,
	zohar@linux.ibm.com,
	yeoreum.yun@arm.com,
	aneesh.kumar@kernel.org,
	dave.jiang@intel.com,
	nik.borisov@suse.com,
	sergii.dmytruk@3mdeb.com
Subject: [PATCH RFC v2 02/15] ctlv: Add the UAPI message format and family API
Date: Fri, 13 Nov 2026 16:55:01 +0100
Message-ID: <20261113155515.2510194-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113155515.2510194-1-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Define CTLV's common TLV transport, ioctl and identifiers. Add the
in-kernel API used by family implementations and generated code,
including the implementation limits: userspace learns the lengths of
each op from the device, so they stay out of the UAPI.

Assisted-by: Cursor: GPT-5.6 Sol
Assisted-by: Cursor: Claude Opus 5.5
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
RFC->RFCv2:
- handed family callbacks the CTLV instance, and dropped the family
  priv and its lifecycle hooks
- sized struct ctlv_op_exec by a field, not the ioctl number
- moved the implementation limits to <linux/ctlv_family.h>
- lowered the inline message limit to 64 KiB
- lowered the record depth limit to 8
- aligned attrs with __ALIGN_KERNEL()
- defined the attr flags with _BITUL()
- spelled out the callback signatures in the ops structures
- wrote the schema macros as compound literals
- dropped the event record header and CTLV_OP_SCHEMA_EVENT()
- renamed the stub schemas and ops to extension schemas and ops
- let an enum's range start at any value
- said how long a cursor lives and what bounds the record depth
- renamed struct ctlv_attr to struct ctlv_hdr and its attr_id to type
- built a type from the family, a record and a field, in place of an
  attr group and number
- said TLV, type, record and field instead of attr
- said record instead of nest, the root being one
- dropped "physical" from the cursor kernel-doc
- numbered every enum member
- moved the UAPI header to include/uapi/ctlv/, as <ctlv/ctlv.h>
- added the schemas of enum extension points and their fills
- said message instead of wire
- retitled from "Add the UAPI wire format and family API"
- moved the ioctl number registration to the dispatch patch
---
 MAINTAINERS                 |   2 +
 include/linux/ctlv.h        |  57 +++++
 include/linux/ctlv_family.h | 431 ++++++++++++++++++++++++++++++++++++
 include/uapi/ctlv/ctlv.h    | 180 +++++++++++++++
 4 files changed, 670 insertions(+)
 create mode 100644 include/linux/ctlv.h
 create mode 100644 include/linux/ctlv_family.h
 create mode 100644 include/uapi/ctlv/ctlv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c8e7ad9b599..bf6d5bab0da9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7188,6 +7188,8 @@ M:	Jiri Pirko <jiri@resnulli.us>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ctlv/
+F:	include/linux/ctlv*.h
+F:	include/uapi/ctlv/
 F:	tools/ctlv/
 
 CTU CAN FD DRIVER
diff --git a/include/linux/ctlv.h b/include/linux/ctlv.h
new file mode 100644
index 000000000000..e151e32a0ffd
--- /dev/null
+++ b/include/linux/ctlv.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ *
+ * CTLV family API.
+ */
+#ifndef _LINUX_CTLV_H
+#define _LINUX_CTLV_H
+
+#include <linux/types.h>
+
+#include <uapi/ctlv/ctlv.h>
+
+struct ctlv_family;
+struct ctlv;
+struct ctlv_msg;
+struct ctlv_op_ctx;
+struct ctlv_schema_tree;
+
+/**
+ * struct ctlv_cursor - One TLV position in one message.
+ * @msg: the message this position is in, core-private bookkeeping
+ * @hdr: the TLV itself, or NULL when a lookup found nothing
+ * @parent: reading, the record containing @hdr, NULL at the root
+ * @up: writing, cursor of the record containing @hdr, NULL at the root. The
+ *	chain of them is the open-record stack, so a cursor must not outlive the
+ *	cursor of its record
+ * @start: writing, where @hdr begins in the message. An append reaches what
+ *	it lengthens through the buffer rather than through @hdr, that buffer
+ *	being the core's own
+ * @tree: schema tree the node belongs to, which is a fill's own tree for a
+ *	TLV that arrived through one
+ * @node: index of the node within @tree
+ * @depth: record levels above this position, the root being zero
+ * @index_record_scope: schema scope used to read the members of @hdr, a record
+ * @index_scope: core-private schema scope containing this TLV
+ *
+ * Fixed-size, so family code can put a child cursor on the stack.
+ * ctlv_record_start() opens at most CTLV_MAX_RECORD_DEPTH levels, which bounds
+ * that stack. The members belong to the core: a family reaches a message
+ * through what was generated for the op it answers. One direction at a time,
+ * a helper of the other direction refusing the cursor.
+ */
+struct ctlv_cursor {
+	struct ctlv_msg *msg;
+	const struct ctlv_hdr *hdr;
+	const struct ctlv_hdr *parent;
+	struct ctlv_cursor *up;
+	size_t start;
+	const struct ctlv_schema_tree *tree;
+	u32 node;
+	u32 depth;
+	u32 index_record_scope;
+	u32 index_scope;
+};
+
+#endif /* _LINUX_CTLV_H */
diff --git a/include/linux/ctlv_family.h b/include/linux/ctlv_family.h
new file mode 100644
index 000000000000..360eb6e30974
--- /dev/null
+++ b/include/linux/ctlv_family.h
@@ -0,0 +1,431 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ *
+ * CTLV family metadata and generated-code support.
+ */
+#ifndef _LINUX_CTLV_FAMILY_H
+#define _LINUX_CTLV_FAMILY_H
+
+#include <linux/ctlv.h>
+#include <linux/kobject.h>
+#include <linux/types.h>
+
+#include <uapi/ctlv/ctlv.h>
+
+/*
+ * Implementation limits, not maxima of message fields: userspace learns the
+ * lengths of each op from op-get, so raising one is compatible.
+ */
+
+/* Request roots, action replies and query reply fragments. */
+#define CTLV_MAX_INLINE_MESSAGE_LEN	0x10000		/* 64 KiB */
+/* Includes the error information root. */
+#define CTLV_MAX_ERROR_LEN		0x4000		/* 16 KiB */
+/* The root is at depth zero. Validation recurses once per level. */
+#define CTLV_MAX_RECORD_DEPTH		8
+
+/* op-schema-get needs one level to describe the declared schema. */
+#define CTLV_MAX_DECLARED_RECORD_DEPTH (CTLV_MAX_RECORD_DEPTH - 1)
+
+struct ctlv_node_schema {
+	u64 type;
+	u8 kind;
+	u8 unit;
+	s8 scale;
+	bool reenters;
+	/* An enum extension point, which enum_ext names in place of a range. */
+	bool is_enum_ext;
+	u32 max_occurrences;
+	u32 first_child;
+	u32 children_count;
+	u32 required_children_count;
+	union {
+		struct {
+			u64 min;
+			u64 max;
+		} range;
+		u64 flags_mask;
+		struct {
+			u32 min_len;
+			u32 max_len;
+		} length;
+		struct {
+			u64 max_len;
+			u32 alignment;
+			u16 backings;
+			u8 direction;
+		} blob;
+		struct {
+			u16 family_id;
+			u32 ext_id;
+		} enum_ext;
+	};
+};
+
+#define CTLV_NODE_SCHEMA_UNLIMITED 0
+
+/* Node 0 of every tree: the message root, holding the top-level fields. */
+#define CTLV_NODE_SCHEMA_ROOT(_first, _count, _required)		\
+	((struct ctlv_node_schema){					\
+		.type = CTLV_TYPE_ROOT,					\
+		.kind = CTLV_SCHEMA_RECORD,				\
+		.max_occurrences = 1,					\
+		.first_child = (_first),				\
+		.children_count = (_count),				\
+		.required_children_count = (_required),			\
+	})
+
+/* A record whose members are the _count nodes from _first, required first. */
+#define CTLV_NODE_SCHEMA_RECORD(_type, _occurrences, _first, _count, _required) \
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_RECORD,				\
+		.max_occurrences = (_occurrences),			\
+		.first_child = (_first),				\
+		.children_count = (_count),				\
+		.required_children_count = (_required),			\
+	})
+
+/* A recursive record, sharing the members of the one above holding its set. */
+#define CTLV_NODE_SCHEMA_RECORD_REENTERS(_type, _occurrences, _first, _count, _required) \
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_RECORD,				\
+		.reenters = true,					\
+		.max_occurrences = (_occurrences),			\
+		.first_child = (_first),				\
+		.children_count = (_count),				\
+		.required_children_count = (_required),			\
+	})
+
+/* A u64 between _min and _max. */
+#define CTLV_NODE_SCHEMA_UINT(_type, _occurrences, _min, _max)		\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_UINT,				\
+		.max_occurrences = (_occurrences),			\
+		.range = { .min = (_min), .max = (_max) },		\
+	})
+
+/* A u64 between _min and _max that carries a unit and a scale. */
+#define CTLV_NODE_SCHEMA_UINT_UNIT(_type, _occurrences, _min, _max, _unit, _scale) \
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_UINT,				\
+		.max_occurrences = (_occurrences),			\
+		.range = { .min = (_min), .max = (_max) },		\
+		.unit = (_unit),					\
+		.scale = (_scale),					\
+	})
+
+/* An s64 between _min and _max, both stored as u64. */
+#define CTLV_NODE_SCHEMA_SINT(_type, _occurrences, _min, _max)		\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_SINT,				\
+		.max_occurrences = (_occurrences),			\
+		.range = { .min = (_min), .max = (_max) },		\
+	})
+
+/* An s64 between _min and _max that carries a unit and a scale. */
+#define CTLV_NODE_SCHEMA_SINT_UNIT(_type, _occurrences, _min, _max, _unit, _scale) \
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_SINT,				\
+		.max_occurrences = (_occurrences),			\
+		.range = { .min = (_min), .max = (_max) },		\
+		.unit = (_unit),					\
+		.scale = (_scale),					\
+	})
+
+/* An enum taking _min to _max, gaps between a header enum's values included. */
+#define CTLV_NODE_SCHEMA_ENUM_RANGE(_type, _occurrences, _min, _max)	\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_ENUM,				\
+		.max_occurrences = (_occurrences),			\
+		.range = { .min = (_min), .max = (_max) },		\
+	})
+
+/* A family's own enum, whose values are numbered from 1 to _max. */
+#define CTLV_NODE_SCHEMA_ENUM(_type, _occurrences, _max)		\
+	CTLV_NODE_SCHEMA_ENUM_RANGE(_type, _occurrences, 1, _max)
+
+/* Enum extension point _ext of _family, numbered as the device's family fills it. */
+#define CTLV_NODE_SCHEMA_ENUM_EXT(_type, _occurrences, _family, _ext)	\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_ENUM,				\
+		.is_enum_ext = true,					\
+		.max_occurrences = (_occurrences),			\
+		.enum_ext = { .family_id = (_family), .ext_id = (_ext) }, \
+	})
+
+/* A u64 of flags, none of them outside _mask. */
+#define CTLV_NODE_SCHEMA_FLAGS(_type, _occurrences, _mask)		\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_FLAGS,				\
+		.max_occurrences = (_occurrences),			\
+		.flags_mask = (_mask),					\
+	})
+
+/* A u8 that is 0 or 1. */
+#define CTLV_NODE_SCHEMA_BOOL(_type, _occurrences)			\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_BOOL,				\
+		.max_occurrences = (_occurrences),			\
+	})
+
+/* A NUL-terminated string of _min to _max bytes, the NUL excluded. */
+#define CTLV_NODE_SCHEMA_STRING(_type, _occurrences, _min, _max)	\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_STRING,				\
+		.max_occurrences = (_occurrences),			\
+		.length = { .min_len = (_min), .max_len = (_max) },	\
+	})
+
+/* A payload of _min to _max bytes. */
+#define CTLV_NODE_SCHEMA_BINARY(_type, _occurrences, _min, _max)	\
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_BINARY,				\
+		.max_occurrences = (_occurrences),			\
+		.length = { .min_len = (_min), .max_len = (_max) },	\
+	})
+
+/* A blob descriptor, for data passed by reference instead of inline. */
+#define CTLV_NODE_SCHEMA_BLOB(_type, _occurrences, _max, _alignment, _backings, _dir) \
+	((struct ctlv_node_schema){					\
+		.type = (_type),					\
+		.kind = CTLV_SCHEMA_BLOB,				\
+		.max_occurrences = (_occurrences),			\
+		.blob = {						\
+			.max_len = (_max),				\
+			.alignment = (_alignment),			\
+			.backings = (_backings),			\
+			.direction = (_dir),				\
+		},							\
+	})
+
+struct ctlv_ext_schema {
+	u16 family_id;
+	u32 ext_id;
+	u32 node;
+	bool optional;
+};
+
+/* An extension point at _node, which a descendant family fills. */
+#define CTLV_EXT_SCHEMA(_family, _ext, _node)				\
+	((struct ctlv_ext_schema){					\
+		.family_id = (_family),					\
+		.ext_id = (_ext),					\
+		.node = (_node),					\
+	})
+
+/* An optional extension point: what fills it is optional too. */
+#define CTLV_EXT_SCHEMA_OPTIONAL(_family, _ext, _node)			\
+	((struct ctlv_ext_schema){					\
+		.family_id = (_family),					\
+		.ext_id = (_ext),					\
+		.node = (_node),					\
+		.optional = true,					\
+	})
+
+struct ctlv_schema_tree {
+	const struct ctlv_node_schema *node_schemas;
+	u32 node_schemas_count;
+	const struct ctlv_ext_schema *ext_schemas;
+	u32 ext_schemas_count;
+};
+
+/* The tree of one message, from _name##_node_schemas. */
+#define CTLV_SCHEMA_TREE(_name)						\
+	((struct ctlv_schema_tree){					\
+		.node_schemas = _name##_node_schemas,			\
+		.node_schemas_count = ARRAY_SIZE(_name##_node_schemas),	\
+	})
+
+/* The same, for a message with extension points in _name##_ext_schemas. */
+#define CTLV_SCHEMA_TREE_EXTS(_name)					\
+	((struct ctlv_schema_tree){					\
+		.node_schemas = _name##_node_schemas,			\
+		.node_schemas_count = ARRAY_SIZE(_name##_node_schemas),	\
+		.ext_schemas = _name##_ext_schemas,			\
+		.ext_schemas_count = ARRAY_SIZE(_name##_ext_schemas),	\
+	})
+
+/* The tree of a message an op does not have. */
+#define CTLV_SCHEMA_TREE_NONE() ((struct ctlv_schema_tree){})
+
+struct ctlv_ext_fill_schema {
+	u16 family_id;
+	u32 ext_id;
+	struct ctlv_schema_tree members;
+};
+
+/* What a family puts into an ancestor's extension point. */
+#define CTLV_EXT_FILL_SCHEMA(_family, _ext, _name)			\
+	((struct ctlv_ext_fill_schema){					\
+		.family_id = (_family),					\
+		.ext_id = (_ext),					\
+		.members = CTLV_SCHEMA_TREE(_name##_fill),		\
+	})
+
+struct ctlv_enum_fill_schema {
+	u16 family_id;
+	u32 ext_id;
+	u32 max;
+};
+
+/* The values 1 to _max a family gives an ancestor's enum extension point. */
+#define CTLV_ENUM_FILL_SCHEMA(_family, _ext, _max)			\
+	((struct ctlv_enum_fill_schema){				\
+		.family_id = (_family),					\
+		.ext_id = (_ext),					\
+		.max = (_max),						\
+	})
+
+struct ctlv_op_sizes {
+	u32 request_max_len;
+	u32 action_reply_max_len;
+	u32 query_reply_min_len;
+	u32 query_reply_suggested_len;
+};
+
+struct ctlv_op_schema {
+	u64 op_id;
+	u8 type;
+	u8 fd_access;
+	u8 availability;
+	bool optional;
+	bool pre_post;
+	struct ctlv_schema_tree request;
+	struct ctlv_schema_tree reply;
+	struct ctlv_op_sizes sizes;
+};
+
+/* An op run once per call, its reply at most _reply_len bytes. */
+#define CTLV_OP_SCHEMA_ACTION(_op, _access, _availability, _request_len, _reply_len, \
+			      _request, _reply, ...)			\
+	((struct ctlv_op_schema){					\
+		.op_id = (_op),						\
+		.type = CTLV_OP_TYPE_ACTION,				\
+		.fd_access = (_access),					\
+		.availability = (_availability),			\
+		.request = _request,					\
+		.reply = _reply,					\
+		.sizes = {						\
+			.request_max_len = (_request_len),		\
+			.action_reply_max_len = (_reply_len),		\
+		},							\
+		__VA_ARGS__						\
+	})
+
+/* An op answered in fragments, each needing _reply_min bytes of room. */
+#define CTLV_OP_SCHEMA_QUERY(_op, _access, _availability, _request_len, _reply_min, \
+			     _reply_suggested, _request, _reply, ...)	\
+	((struct ctlv_op_schema){					\
+		.op_id = (_op),						\
+		.type = CTLV_OP_TYPE_QUERY,				\
+		.fd_access = (_access),					\
+		.availability = (_availability),			\
+		.request = _request,					\
+		.reply = _reply,					\
+		.sizes = {						\
+			.request_max_len = (_request_len),		\
+			.query_reply_min_len = (_reply_min),		\
+			.query_reply_suggested_len = (_reply_suggested), \
+		},							\
+		__VA_ARGS__						\
+	})
+
+struct ctlv_family_schema {
+	const char *name;
+	u16 family_id;
+	const struct ctlv_op_schema *ops;
+	u32 ops_count;
+	const struct ctlv_ext_fill_schema *ext_fill_schemas;
+	u32 ext_fill_schemas_count;
+	const struct ctlv_enum_fill_schema *enum_fill_schemas;
+	u32 enum_fill_schemas_count;
+};
+
+/* Leave half of a uevent environment to the device model. */
+#define CTLV_UEVENT_MAX_LEN (UEVENT_BUFFER_SIZE / 2)
+#define CTLV_UEVENT_MAX_VARS (UEVENT_NUM_ENVP / 2)
+
+/* A field a reader expects among the children of the record it reads. */
+struct ctlv_input_ref {
+	u64 type;
+	u8 kind;
+};
+
+struct ctlv_op {
+	union {
+		int (*action)(struct ctlv *ctlv, struct ctlv_op_ctx *ctx,
+			      const struct ctlv_cursor *request,
+			      struct ctlv_cursor *reply);
+		int (*query)(struct ctlv *ctlv, struct ctlv_op_ctx *ctx,
+			     const struct ctlv_cursor *request,
+			     struct ctlv_cursor *reply);
+	};
+	int (*pre)(struct ctlv *ctlv, struct ctlv_op_ctx *ctx);
+	void (*post)(struct ctlv *ctlv, struct ctlv_op_ctx *ctx);
+};
+
+/* An action implemented by _name##_action. */
+#define CTLV_OP_ACTION(_name) ((struct ctlv_op){ .action = _name##_action })
+
+/* A query implemented by _name##_query. */
+#define CTLV_OP_QUERY(_name) ((struct ctlv_op){ .query = _name##_query })
+
+/* An action with its own hooks, _name##_pre and _name##_post. */
+#define CTLV_OP_ACTION_PRE_POST(_name)					\
+	((struct ctlv_op){						\
+		.action = _name##_action,				\
+		.pre = _name##_pre,					\
+		.post = _name##_post,					\
+	})
+
+/* A query with its own hooks, _name##_pre and _name##_post. */
+#define CTLV_OP_QUERY_PRE_POST(_name)					\
+	((struct ctlv_op){						\
+		.query = _name##_query,					\
+		.pre = _name##_pre,					\
+		.post = _name##_post,					\
+	})
+
+struct ctlv_ext_ops {
+	u16 family_id;
+	u32 ext_id;
+	int (*fill)(struct ctlv *ctlv, struct ctlv_op_ctx *ctx,
+		    const struct ctlv_cursor *request,
+		    struct ctlv_cursor *record);
+};
+
+/* How a family fills an ancestor's extension point. */
+#define CTLV_EXT_OPS(_family, _ext, _name)				\
+	((struct ctlv_ext_ops){						\
+		.family_id = (_family),					\
+		.ext_id = (_ext),					\
+		.fill = _name##_fill,					\
+	})
+
+struct ctlv_family {
+	const struct ctlv_family_schema *schema;
+	const struct ctlv_family *parent;
+	const struct ctlv_op *ops;
+	u32 ops_count;
+	const struct ctlv_ext_ops *ext_ops;
+	u32 ext_ops_count;
+};
+
+extern const struct ctlv_family ctlv_family;
+
+u32 ctlv_enum_ext_max(const struct ctlv_family *family, u16 family_id, u32 ext_id);
+
+#endif /* _LINUX_CTLV_FAMILY_H */
diff --git a/include/uapi/ctlv/ctlv.h b/include/uapi/ctlv/ctlv.h
new file mode 100644
index 000000000000..654e78bab414
--- /dev/null
+++ b/include/uapi/ctlv/ctlv.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ *
+ * CTLV transport UAPI: the TLV message format and the op-execution ioctl.
+ * Schema-free; a family's constants are generated into <ctlv/<family>_gen.h>,
+ * the root family's into <ctlv/ctlv_gen.h>.
+ */
+#ifndef _UAPI_CTLV_CTLV_H
+#define _UAPI_CTLV_CTLV_H
+
+#include <linux/const.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct ctlv_hdr - TLV header.
+ * @len: this header plus its payload, excluding this TLV's trailing padding
+ * @flags: CTLV_HDR_F_* bits
+ * @type: family, record and field, or CTLV_TYPE_ROOT for a message root
+ *
+ * TLVs are aligned to CTLV_ALIGNTO, which is why @type is __aligned_u64: a
+ * 32-bit ABI would otherwise align this structure to four bytes. A record's
+ * payload is the concatenation of CTLV_ALIGN(child.len) bytes per child, so
+ * child padding counts inside the containing record's @len while a TLV's own
+ * padding does not. Scalar payloads are native-endian. Within each request
+ * root or record, the TLVs of one @type are contiguous; different types
+ * otherwise have no required order.
+ */
+struct ctlv_hdr {
+	__u32 len;
+	__u32 flags;
+	__aligned_u64 type;
+};
+
+#define CTLV_ALIGNTO 8
+#define CTLV_ALIGN(_len) __ALIGN_KERNEL((_len), CTLV_ALIGNTO)
+
+/* Set exactly on the root and on records, clear on scalar TLVs. */
+#define CTLV_HDR_F_RECORD		_BITUL(0)
+/* Query fragments: set on the root and each record still open at the end. */
+#define CTLV_HDR_F_FRAG_MORE		_BITUL(1)
+/*
+ * A request TLV, never the root, that a device whose schema does not declare
+ * its type skips whole instead of refusing the message. A type that schema
+ * does declare is held to it wherever it appears, so this asks to be forgiven
+ * what this kernel has never heard of and nothing else.
+ */
+#define CTLV_HDR_F_IGNORE_IF_UNKNOWN	_BITUL(2)
+
+/* The root: carries CTLV_HDR_F_RECORD, valid only at a message start. */
+#define CTLV_TYPE_ROOT 0ULL
+
+/**
+ * enum ctlv_type_kind - What the record of a type starts from.
+ * @CTLV_TYPE_KIND_NAMED: a named record
+ * @CTLV_TYPE_KIND_RESERVED: reserved, so no type has it
+ * @CTLV_TYPE_KIND_REQUEST: an op's request
+ * @CTLV_TYPE_KIND_REPLY: an op's reply
+ *
+ * Bits 47..46 of a type. The index in 45..32 is the named record's place in
+ * the family's records, or the op's number.
+ */
+enum ctlv_type_kind {
+	CTLV_TYPE_KIND_NAMED = 0,
+	CTLV_TYPE_KIND_RESERVED = 1,
+	CTLV_TYPE_KIND_REQUEST = 2,
+	CTLV_TYPE_KIND_REPLY = 3,
+};
+
+/*
+ * Family in bits 63..48, record in 47..16, field in 15..0. The record is
+ * the type kind, the index, then the path of unnamed records below them, four
+ * bits a level (31..16).
+ */
+#define CTLV_TYPE(_family, _record, _field)	\
+	(((__u64)(_family) << 48) |		\
+	 ((__u64)(_record) << 16) |		\
+	 (__u64)(_field))
+
+#define CTLV_TYPE_FAMILY(_type)	((__u16)((_type) >> 48))
+#define CTLV_TYPE_KIND(_type)	((__u8)(((_type) >> 46) & 3))
+#define CTLV_TYPE_RECORD(_type)	((__u32)((_type) >> 16))
+#define CTLV_TYPE_FIELD(_type)	((__u16)(_type))
+
+/* Complete op: family in bits 63..48, zero in 47..32, op in 31..0. */
+#define CTLV_OP(_family, _op)	\
+	(((__u64)(_family) << 48) | (__u64)(_op))
+
+#define CTLV_OP_FAMILY(_op)		((__u16)((_op) >> 48))
+#define CTLV_OP_NUMBER(_op)		((__u32)(_op))
+
+/**
+ * enum ctlv_unit - CTLV-defined unit of an integer field.
+ * @CTLV_UNIT_NONE: dimensionless
+ * @CTLV_UNIT_SECONDS: seconds
+ * @CTLV_UNIT_HERTZ: hertz
+ * @CTLV_UNIT_BYTES: bytes
+ * @CTLV_UNIT_CELSIUS: degrees Celsius
+ *
+ * A payload is value * 10^scale of this unit, from the decimal scale the field
+ * declares alongside. Changing either is an ABI break.
+ */
+enum ctlv_unit {
+	CTLV_UNIT_NONE = 0,
+	CTLV_UNIT_SECONDS = 1,
+	CTLV_UNIT_HERTZ = 2,
+	CTLV_UNIT_BYTES = 3,
+	CTLV_UNIT_CELSIUS = 4,
+};
+
+/**
+ * enum ctlv_schema_kind - CTLV-defined schema kind of a field.
+ * @CTLV_SCHEMA_UINT: unsigned integer payload bounded by a range
+ * @CTLV_SCHEMA_SINT: signed integer payload bounded by a range
+ * @CTLV_SCHEMA_BOOL: one payload byte holding zero or one
+ * @CTLV_SCHEMA_STRING: NUL-terminated string payload bounded by length
+ * @CTLV_SCHEMA_BINARY: opaque payload bounded by length
+ * @CTLV_SCHEMA_ENUM: unsigned integer payload restricted to a range
+ * @CTLV_SCHEMA_FLAGS: unsigned integer payload restricted to a mask
+ * @CTLV_SCHEMA_RECORD: a record, its fields described by further nodes
+ * @CTLV_SCHEMA_BLOB: blob descriptor record
+ *
+ * Exactly one schema kind applies to a field. These are the values
+ * op-schema-get reports, and the set is append-only.
+ */
+enum ctlv_schema_kind {
+	CTLV_SCHEMA_UINT = 0,
+	CTLV_SCHEMA_SINT = 1,
+	CTLV_SCHEMA_BOOL = 2,
+	CTLV_SCHEMA_STRING = 3,
+	CTLV_SCHEMA_BINARY = 4,
+	CTLV_SCHEMA_ENUM = 5,
+	CTLV_SCHEMA_FLAGS = 6,
+	CTLV_SCHEMA_RECORD = 7,
+	CTLV_SCHEMA_BLOB = 8,
+};
+
+/**
+ * struct ctlv_op_exec - Op-execution ioctl argument.
+ * @size: sizeof(struct ctlv_op_exec) as the caller was built with it
+ * @flags: must be zero
+ * @op_id: complete op ID; zero is invalid
+ * @request: struct ctlv_hdr __user *, the mandatory complete request root
+ * @reply: struct ctlv_hdr __user *, the success reply or the error
+ *	information
+ * @request_len: readable bytes beginning at @request, at least one root header;
+ *	the transport copy boundary, which may exceed the root's own length
+ * @reply_len: writable bytes beginning at @reply; input only, never
+ *	overwritten by the kernel
+ * @generation: query only; zero on a first fragment, the previously returned
+ *	value on continuation, and the query generation on output. Actions must
+ *	set zero.
+ * @cursor: query only; zero starts a query and a nonzero value resumes it. On
+ *	output it is the next cursor when the root carries
+ *	CTLV_HDR_F_FRAG_MORE and zero when no further fragment exists. Actions
+ *	must set zero.
+ *
+ * The structure only grows at its end. The kernel reads @size bytes, at least
+ * the 56 of this first version, refuses a tail it does not know unless it is
+ * zero, and writes back only within @size. @request and @reply are fixed-width
+ * representations of userspace pointers so that the compat layout is identical.
+ */
+struct ctlv_op_exec {
+	__u32 size;
+	__u32 flags;
+	__aligned_u64 op_id;
+	__aligned_u64 request;
+	__aligned_u64 reply;
+	__u32 request_len;
+	__u32 reply_len;
+	__aligned_u64 generation;
+	__aligned_u64 cursor;
+};
+
+#define CTLV_IOC_MAGIC 0xBB
+
+#define CTLV_IOC_OP_EXEC _IO(CTLV_IOC_MAGIC, 0x00)
+
+#endif /* _UAPI_CTLV_CTLV_H */
-- 
2.56.0

