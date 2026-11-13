Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586138;
	b=m9ukXW7QW0HIm7mSNgz35v435XxvELBR69DmDMXFfi8zLOvzLGB5wxiFHSBulMjrA0xP
	 fbHOekiRgn2Jb2xswJ7mM0mnQwzNdWHtyu0RkuOHFMW/9fEwyJs4+tCVyHAWOSd8gWlZM
	 kxsNYeIBuzvVjuJJpoLt55v8XSD5Mr1HA1wxKWbhL2l7KCKfMLTzz3YKXXOMIgeoG6R04
	 DSq6t7UakKO+z5ssGFQNQ4LRGTytV4sdraii8IOwyzuIQTz67mlwmMUdkSGdBxrjcvRCW
	 57OT067VU+a2hTA4MNo6W34OX9wNXCxlXEAXc2ca5n+bbn36AeFCo92PyYWPik4sHmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CR01M3l2+XdlJgIMFqnjdm+KWucPPsA6W4AAPFE8TbU=;
	b=0ZBDFchUmDfW+lFGOiIyCTHcTCV9FOAVGgYnEnRM+uUebDiBqCWjuXRkWu+OeLqeZrnx
	 NV/iTNhQ9EL1jnklJOy6KSGlNkFoR6sQn26OmD0EzYaOohZqq9WU2/JtZsxDMNVEz3UbC
	 9xIQNhxk5ORJPiLE/s0HiVXpjMwK+CpF7ZF6/VO6ZsbRqx4wz2XJGZ4LGQ64pnkfcakpK
	 PhV4WjGoxtuKSB7MC1CmzFnUNvxWG4yATv/GmTUHnaFMcefJFHJrBTgQz2K+MsN53lWxk
	 0rQaSa+/G4lul5T1Gdd5fAVmPFrtL+ee3X64uVqCYAKu4CK0G8c4VCA1O3SbR48KF0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=UGQHklYD;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AA60A5BCA
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E8AA60A5BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=UGQHklYD
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso16621085e9.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1794586137; x=1795190937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CR01M3l2+XdlJgIMFqnjdm+KWucPPsA6W4AAPFE8TbU=;
        b=UGQHklYDSzvPSNGEWzPMjIY8U1mfIOUygXuI2b4PdJIbBHPcsdmFcUGBe7cVxizxEy
         E/dUBqQ21jfJvF6pAWstuH5inKuRBJqiIT5U1Se/LpvBeckx6CYvzlsqqGah65TL/UHA
         DfGKmTwX2gdPzmEuaG4olwTmTlmeSNJ7eT71VayXJ6U0LX1/KXjFdwqeiDLQfTKcyRBd
         PHmPdtM4bIs5I9bXMJDVwIs7jQZwNYeB018n0kLfjehpKceES2y7CFYG9qGorDpLcI1z
         ci4/sx2z5etxpu4NIcUGz1rfkHwOo2ZUiVLq7NXFt3rbFGf7cCw/Pqb9XnMTdD8oUrBJ
         KqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586137; x=1795190937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CR01M3l2+XdlJgIMFqnjdm+KWucPPsA6W4AAPFE8TbU=;
        b=PdJOYipnufKRtCaGezxMHneYv51GqfgYI4rF91+DAqjL6v6mYlAo7KAO7iqcgoqR/G
         JulyU/vIqYmWifSRcgnX4kKubjEzauuQzLHUKAV8sBwnqAX2PBQ6eFcJMctpWcmf/zsZ
         P9nsghT/I7lrlWOCQyEc8MSCw4yRWxT5RQg9XbDCOiISXmZiU9fKQ63rIh1qFuvCCTUw
         EDtoCs2osoTq4F2Ir5TpNk8oCfxDbMgjcZR6aVAy0z9G4B0iPJDa1VWH/ojhkpVs6W+I
         NzXq9gUMx/AuIRrtFOPposvWEIfaob+3R+Z0jhSeTRLq9EZGXGGGxShrNqC1YxPi+ypB
         06Xw==
X-Forwarded-Encrypted: i=1; AL+hErELmAKw+JqGzpM9cbiJ6SXnyW/gNKPcvT7rDO9aoVag23YEzpjsoP73oBuj4ka1sCX2yKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8HQn9eys6f/oOhjdg9lpKn6jQs+gYX2OpVMrUeFEQBHEglD/o
	0CUbB3xxbm3eBpkxX4cHhngyq0W92epJAnaO7OS/SJXpWJ37TZ5pogA8K/2WIq9zBms=
X-Gm-Gg: AYBFou1gI2ZL4Y8KRl90yqc9n3ynRhJeqWaplLe6lSKwmusL4U5pUzjVGRyLOM83n9d
	r5XhqkXn9fjfpkyFs+ws9nZClVtJPAWptSL3cLhIP/ZBso/06oEi0yX4GiMbGwjXrwBecReQDK0
	tWkz5l5oUqge2PyDKB27cimNKKkRUC1YguScFlIocwqCqk61SKT0yXoXjusVLX8qP8maKZnMYYd
	xajjbGJ8Jhq4qvItDa6XD1orJVsYHFpBoKea+Qqrb/3PgEHOkwayp3zUBvfrmXV1/O4V4NAKYOb
	m/ZbvFaUCmaVRaTFfgJCvxrwZ7n9qnmp33yDEXpUJCtFQvp+bHlwEn8i+l7umqmhPW3Fjy8pGyO
	VV7XI6UIg5qlIla4RKNykV870mpiEC5+nW/nWmS94QjpqtnyuRbIUZCEgQNETf2kIzPgNt0DKBf
	p3J5BjDOgr58sKjx5hguMCQ+WqUqn5ymRvdfwIqYELu/QngwVWj9X6m3V9c1mgw5Apa9RfdRgFx
	W2XVYLL9c04bQNUEDLWfqZjaTtCc9nD9jZwXznib2CuMok33PakxceyCChG26A+c6ZOsb5sc17j
	kdygGPmxraJ0DFQhhMOZ9sjZDrJAibuxVOicb2eC
X-Received: by 2002:a05:600c:4313:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4bb55a83305mr42502405e9.34.1794586136644;
        Fri, 13 Nov 2026 08:08:56 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm68962095e9.13.2026.11.13.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:08:56 -0800 (PST)
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
Subject: [PATCH RFC v2 4/9] attestation: Prepare measurement registers
Date: Fri, 13 Nov 2026 17:08:33 +0100
Message-ID: <20261113160838.2512652-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113160838.2512652-1-jiri@resnulli.us>
References: <20261113160838.2512652-1-jiri@resnulli.us>
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

Add the fixed MRs from the provider descriptor, their lookup and MR
extension, which advances an instance-wide MR generation.

The MR objects can be compile-checked here. CONFIG_ATTESTATION remains
unwired until the CTLV operation handlers complete the module.

Assisted-by: Cursor: GPT-5.6 Sol
Assisted-by: Cursor: Claude Opus 5.5
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
RFC->RFCv2:
- kept the MR state in struct attestation_dev, which providers embed
- dropped the MR journal and its notifications
- counted MR changes in a plain MR generation
- retitled from "Prepare measurement register journal"
- used the helpers generated for the rewritten spec
- let an extend carry values for some of an MR's banks
- always provided mr-read with MRs
---
 drivers/attestation/Makefile        |  2 +-
 drivers/attestation/core/core.c     | 71 +++++++++++++++++++++++++++++
 drivers/attestation/core/internal.h | 13 ++++++
 drivers/attestation/core/mr.c       | 64 ++++++++++++++++++++++++++
 include/linux/attestation.h         |  5 +-
 5 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 drivers/attestation/core/mr.c

diff --git a/drivers/attestation/Makefile b/drivers/attestation/Makefile
index 8a75558a7013..28036586f5d8 100644
--- a/drivers/attestation/Makefile
+++ b/drivers/attestation/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ATTESTATION) += attestation.o
 
-attestation-y := core/core.o
+attestation-y := core/core.o core/mr.o
diff --git a/drivers/attestation/core/core.c b/drivers/attestation/core/core.c
index 587a0a9616b6..24abe0923306 100644
--- a/drivers/attestation/core/core.c
+++ b/drivers/attestation/core/core.c
@@ -213,6 +213,12 @@ bool attestation_registered(struct attestation_dev *att)
 	return registered;
 }
 
+void attestation_mr_changed(struct attestation_dev *att)
+{
+	lockdep_assert_held(&att->lock);
+	att->mr_generation++;
+}
+
 void attestation_stop(struct attestation_dev *att)
 {
 	lockdep_assert_held(&att->lock);
@@ -221,6 +227,38 @@ void attestation_stop(struct attestation_dev *att)
 	xa_unlock(&attestation_instances);
 }
 
+static struct attestation_mr *attestation_mr_alloc(struct attestation_dev *att,
+						   const struct attestation_mr_props *props)
+{
+	struct attestation_mr *mr;
+	int ret;
+
+	ret = attestation_mr_props_validate(att->provider, props);
+	if (ret)
+		return ERR_PTR(ret);
+	if (xa_load(&att->mrs, props->id))
+		return ERR_PTR(-EEXIST);
+	mr = kzalloc_obj(*mr, GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+	mr->props = props;
+	ret = xa_insert(&att->mrs, props->id, mr, GFP_KERNEL);
+	if (ret) {
+		kfree(mr);
+		return ERR_PTR(ret);
+	}
+	return mr;
+}
+
+struct attestation_mr *attestation_mr_lookup_live(struct attestation_dev *att, unsigned int mr_id)
+{
+	struct attestation_mr *mr;
+
+	lockdep_assert_held(&att->lock);
+	mr = xa_load(&att->mrs, mr_id);
+	return mr ? mr : ERR_PTR(-ENOENT);
+}
+
 /**
  * attestation_evidence_write - Write an evidence object to its blob.
  * @object: the requested object
@@ -252,11 +290,41 @@ void attestation_provide_ops(struct attestation_dev *att)
 		ctlv_attestation_evidence_get_provide(ctlv);
 		ctlv_attestation_evidence_get_enable(ctlv);
 	}
+
+	if (provider->mrs_count) {
+		ctlv_attestation_mr_get_provide(ctlv);
+		ctlv_attestation_mr_read_provide(ctlv);
+		if (provider->mr_extend)
+			ctlv_attestation_mr_extend_provide(ctlv);
+	}
+}
+
+static int attestation_mrs_create(struct attestation_dev *att)
+{
+	const struct attestation_provider *provider = att->provider;
+	size_t index;
+
+	for (index = 0; index < provider->mrs_count; index++) {
+		struct attestation_mr *mr;
+
+		mr = attestation_mr_alloc(att, &provider->mrs[index]);
+		if (IS_ERR(mr))
+			return PTR_ERR(mr);
+	}
+	return 0;
 }
 
 /* Runs from the release, so it must not reach the provider's module. */
 static void attestation_state_free(struct attestation_dev *att)
 {
+	struct attestation_mr *mr;
+	unsigned long index;
+
+	xa_for_each(&att->mrs, index, mr) {
+		xa_erase(&att->mrs, index);
+		kfree(mr);
+	}
+	xa_destroy(&att->mrs);
 	mutex_destroy(&att->lock);
 }
 
@@ -338,11 +406,14 @@ struct attestation_dev *_attestation_alloc(struct device *parent,
 		return ERR_PTR(-ENOMEM);
 	att->provider = provider;
 	mutex_init(&att->lock);
+	xa_init(&att->mrs);
 
 	/* From here on, the release frees whatever was set up. */
 	ret = ctlv_device_init(&att->node, &attestation_class, parent, &att->ctlv);
 	if (!ret)
 		ret = ctlv_init(&att->ctlv, &att->node.dev, family, &attestation_ctlv_hooks);
+	if (!ret)
+		ret = attestation_mrs_create(att);
 	if (ret) {
 		put_device(&att->node.dev);
 		return ERR_PTR(ret);
diff --git a/drivers/attestation/core/internal.h b/drivers/attestation/core/internal.h
index f42bc3cd9a35..19c2ade5e6db 100644
--- a/drivers/attestation/core/internal.h
+++ b/drivers/attestation/core/internal.h
@@ -11,11 +11,24 @@
 
 #define ATTESTATION_REGISTERED XA_MARK_1
 
+struct attestation_mr {
+	const struct attestation_mr_props *props;
+};
+
 bool attestation_registered(struct attestation_dev *att);
 void attestation_stop(struct attestation_dev *att);
+void attestation_mr_changed(struct attestation_dev *att);
 
 int attestation_provider_validate(const struct attestation_provider *provider,
 				  const struct ctlv_family *family);
 void attestation_provide_ops(struct attestation_dev *att);
 
+struct attestation_mr *attestation_mr_lookup_live(struct attestation_dev *att, unsigned int mr_id);
+int attestation_mr_values_validate(const struct attestation_mr_props *props,
+				   const struct attestation_digest_set *values, bool all_banks);
+int attestation_mr_extend_locked(struct attestation_dev *att, struct attestation_mr *mr,
+				 const struct attestation_digest_set *values);
+
+int attestation_mr_props_encode(struct ctlv_cursor *reply, const struct attestation_mr *mr);
+
 #endif /* _ATTESTATION_INTERNAL_H */
diff --git a/drivers/attestation/core/mr.c b/drivers/attestation/core/mr.c
new file mode 100644
index 000000000000..44a8c06df0c6
--- /dev/null
+++ b/drivers/attestation/core/mr.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/limits.h>
+
+#include "internal.h"
+
+/* @values follow the banks' order, so each bank comes once at most. */
+int attestation_mr_values_validate(const struct attestation_mr_props *props,
+				   const struct attestation_digest_set *values, bool all_banks)
+{
+	size_t bank = 0, index;
+
+	if (!values || !values->values || !values->values_count ||
+	    (all_banks && values->values_count != props->algorithms_count))
+		return -EINVAL;
+	for (index = 0; index < values->values_count; index++, bank++) {
+		while (bank < props->algorithms_count &&
+		       props->algorithms[bank] != values->values[index].algorithm)
+			bank++;
+		if (bank == props->algorithms_count)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+int attestation_mr_extend_locked(struct attestation_dev *att, struct attestation_mr *mr,
+				 const struct attestation_digest_set *values)
+{
+	int ret;
+
+	lockdep_assert_held(&att->lock);
+	if (att->mr_generation == UINT_MAX) {
+		dev_warn(att->node.dev.parent,
+			 "attestation instance %u stopped: mr generation exhausted\n",
+			 att->index);
+		attestation_stop(att);
+		return -EOVERFLOW;
+	}
+	ret = att->provider->mr_extend(att, mr->props->id, values);
+	if (ret)
+		return ret;
+	attestation_mr_changed(att);
+	return 0;
+}
+
+int attestation_mr_props_encode(struct ctlv_cursor *reply, const struct attestation_mr *mr)
+{
+	u64 caps = 0;
+	size_t index;
+	bool ok = true;
+
+	ok &= ctlv_attestation_mr_get_items_id_put(reply, mr->props->id);
+	ok &= ctlv_attestation_mr_desc_name_put(reply, mr->props->name);
+	for (index = 0; index < mr->props->algorithms_count; index++)
+		ok &= ctlv_attestation_mr_desc_supported_hash_algorithms_put(
+			reply, mr->props->algorithms[index]);
+	if (mr->props->has_register_index)
+		ok &= ctlv_attestation_mr_desc_register_index_put(reply, mr->props->register_index);
+	if (mr->props->extendable)
+		caps |= CTLV_ATTESTATION_MR_CAPS_EXTEND;
+	ok &= ctlv_attestation_mr_desc_caps_put(reply, caps);
+	return ok ? 0 : -EMSGSIZE;
+}
diff --git a/include/linux/attestation.h b/include/linux/attestation.h
index 29bb776bfb41..7745938092c7 100644
--- a/include/linux/attestation.h
+++ b/include/linux/attestation.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include <uapi/ctlv/ctlv_attestation_gen.h>
 #include <uapi/linux/hash_info.h>
@@ -200,9 +201,11 @@ struct attestation_dev {
 	const struct attestation_provider *provider;
 	unsigned int index;
 
-	/* Mutable instance state. */
+	/* Mutable instance and MR state. */
 	struct mutex lock;
+	unsigned int mr_generation;
 
+	struct xarray mrs;
 };
 
 /* What a CTLV callback of a family inheriting ctlv-attestation was handed. */
-- 
2.56.0

