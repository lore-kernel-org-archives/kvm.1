Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9023E8333
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097007; cv=none; b=HOqQNsRRtSXcpFNbKF1yf8hBTrGvcFM/hj2JMAd3koYaGKExt1A71PPE79l4+XLID7h+VmDNYEmNVdNNO139ijpFvIygnau2SYVUNu4MtBdlSqHMvddK/iDKAmP7NNOeIK+TjBwQ5K8YJp+cMQX+4AxpG/ur5BAuXpopCppuH7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097007; c=relaxed/simple;
	bh=L4H1uHql/HJPpc27eILZG0D33tmdJ49HmIaLmZtdcjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dc+KOufR59AZs+DIz76dveRZ1scTc1aCLgq4v0CFrV7P7l13DavKY8f1S1VPRZT3Q36sfKatRGwzp/TFMaA4nDUAPhV+efQNiwO5Ew/J1TyHlvNtno9GTh207dspb5mW2QAP8Ic6+1sqWJrfGypgZ3eyp24MYI6AuDFzOYPl8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBq8N28W; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBq8N28W"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-67c3d3a11ceso1831542a12.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097003; x=1779701803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=as26CSLWhv9riXhwc0+6uzjiz4k1n6M2f5huVsJsy4s=;
        b=DBq8N28We2W6eEsbAqjHuhdrB4CKMcnVQqNw9tpkMdrIw+nYTFJRC+48DpUwFUQ+6F
         PbcV8x2lt7pYkC0tZUU0XG+aidIml1U4bBjIt2fUU2mnG78QJnYe/tpd54fIWkVtOKbT
         yOvc1EoL7Ep8MR8UP0AJFJhoKMgHjRxYfUEcycdM9vkErWsIKppGg3EFhtWn/PP5KmEt
         E601aNr9DmU+fC92hpdoPXZduJ0l2LQUA82rKDUX1nyyE1VSx4886aEAlA8Afef9JYGO
         gtpjHMmwJWrhXNesKmPU3YyUuMmjg2SqgMw+Wft9SuPF9xAexmtG70z+QI476bWaWqeb
         7KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097003; x=1779701803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=as26CSLWhv9riXhwc0+6uzjiz4k1n6M2f5huVsJsy4s=;
        b=D3fDNC3YlyAYMSmNH6sbmQ73aXJ/ch6sWjWX+2eYB8VN7ZQitXA+xxfAusn2qA/elY
         ppiS8RIbYHT/CM8ZfrXC/8fZjlEjfkiflTKwJdIQLf+B1ngWRi6SfDMLSWyUZ4keR2dq
         g1l1hyn8td6NyKHNUHoAuOHWV2QqdOm17gNFXpOfcsJwLnfdWxm4fEKAr4nPGLXIRMwv
         yljW7NlXurhNQumTgCR1Ah3+IPCS492UaPkQuuN9cB71XNgcU6+SLN92lcx+CaHmnf+0
         n/WbhZKJeMt721Ui4x6joqXp3haE/ZfIGk2oRbPHECR8swjcsiykZ1x5VJD9DqGKHgj9
         rkqA==
X-Forwarded-Encrypted: i=1; AFNElJ/saeX60xQyNcw3612o7FZl0UFS4HWVltJRp5S7QqHu5eUgn7SH6nuXguVkUoI+rUGLJRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/tvr1HSVAfYMOHv4eWtORzEFA/l7bjNa0ytVQELsW6nTWgKj
	EJQxCVRXB8Egnt3TMrFw5Akd4qIhi8Revjjx5sunmilCSDCQsxWVKuaz9Z/5WEp6fNgVA/UTww7
	UoIaG77d0AWdIQYX6zg==
X-Received: from edxa5.prod.google.com ([2002:a05:6402:13c5:b0:683:d667:6d6c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:24ce:b0:683:5306:d41b with SMTP id 4fb4d7f45d1cf-683bc5ba630mr6644571a12.7.1779097003267;
 Mon, 18 May 2026 02:36:43 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:31 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <9ff4237649ace8b7eb78f3c3ec9ffaf5ae49ae6a.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 1/9] liveupdate: luo_file: Add internal APIs for file preservation
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pasha Tatashin <pasha.tatashin@soleen.com>

The core liveupdate mechanism allows userspace to preserve file
descriptors. However, kernel subsystems often manage struct file
objects directly and need to participate in the preservation process
programmatically without relying solely on userspace interaction.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/liveupdate.h       | 21 ++++++++++
 kernel/liveupdate/luo_file.c     | 69 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h | 17 ++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 30c5a39ff9e9..de052438eaac 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -24,6 +24,7 @@ struct file;
 /**
  * struct liveupdate_file_op_args - Arguments for file operation callbacks.
  * @handler:          The file handler being called.
+ * @session:          The session this file belongs to.
  * @retrieve_status:  The retrieve status for the 'can_finish / finish'
  *                    operation. A value of 0 means the retrieve has not been
  *                    attempted, a positive value means the retrieve was
@@ -44,6 +45,7 @@ struct file;
  */
 struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
+	struct liveupdate_session *session;
 	int retrieve_status;
 	struct file *file;
 	u64 serialized_data;
@@ -240,6 +242,13 @@ void liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
 
 int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
 int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
+/* kernel can internally retrieve files */
+int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
+				 struct file **filep);
+
+/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
+int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+				  struct file *file, u64 *tokenp);
 
 #else /* CONFIG_LIVEUPDATE */
 
@@ -285,5 +294,17 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
 	return -EOPNOTSUPP;
 }
 
+static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
+					       u64 token, struct file **filep)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+						struct file *file, u64 *tokenp)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a0a419085e28..0aa0b4e5339f 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -323,6 +323,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	mutex_init(&luo_file->mutex);
 
 	args.handler = fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = file;
 	err = fh->ops->preserve(&args);
 	if (err)
@@ -380,6 +381,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 					   struct luo_file, list);
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -411,6 +413,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -432,6 +435,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -621,6 +625,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.serialized_data = luo_file->serialized_data;
 	err = luo_file->fh->ops->retrieve(&args);
 	if (err) {
@@ -654,6 +659,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.retrieve_status = luo_file->retrieve_status;
@@ -671,6 +677,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 	guard(mutex)(&luo_file->mutex);
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
 	args.retrieve_status = luo_file->retrieve_status;
@@ -924,3 +931,65 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
+
+/**
+ * liveupdate_get_token_outgoing - Get the token for a preserved file.
+ * @s:      The outgoing liveupdate session.
+ * @file:   The file object to search for.
+ * @tokenp: Output parameter for the found token.
+ *
+ * Searches the list of preserved files in an outgoing session for a matching
+ * file object. If found, the corresponding user-provided token is returned.
+ *
+ * This function is intended for in-kernel callers that need to correlate a
+ * file with its liveupdate token.
+ *
+ * Context: It must be called with session mutex acquired.
+ * Return: 0 on success, -ENOENT if the file is not preserved in this session.
+ */
+int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+				  struct file *file, u64 *tokenp)
+{
+	struct luo_file_set *file_set = luo_file_set_from_session_locked(s);
+	struct luo_file *luo_file;
+	int err = -ENOENT;
+
+	list_for_each_entry(luo_file, &file_set->files_list, list) {
+		if (luo_file->file == file) {
+			if (tokenp)
+				*tokenp = luo_file->token;
+			err = 0;
+			break;
+		}
+	}
+
+	return err;
+}
+
+/**
+ * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
+ * @s:      The incoming liveupdate session (restored from the previous kernel).
+ * @token:  The unique token identifying the file to retrieve.
+ * @filep:  On success, this will be populated with a pointer to the retrieved
+ *          'struct file'.
+ *
+ * Provides a kernel-internal API for other subsystems to retrieve their
+ * preserved files after a live update. This function is a simple wrapper
+ * around luo_retrieve_file(), allowing callers to find a file by its token.
+ *
+ * The caller receives a new reference to the file and must call fput() when it
+ * is no longer needed. The file's lifetime is managed by LUO and any userspace
+ * file descriptors. If the caller needs to hold a reference to the file beyond
+ * the immediate scope, it must call get_file() itself.
+ *
+ * Context: It must be called with session mutex acquired of a restored session.
+ * Return: 0 on success. Returns -ENOENT if no file with the matching token is
+ *         found, or any other negative errno on failure.
+ */
+int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
+				 struct file **filep)
+{
+	return luo_retrieve_file(luo_file_set_from_session_locked(s),
+				 token, filep);
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 875844d7a41d..08b198802e7f 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -79,6 +79,23 @@ struct luo_session {
 
 extern struct rw_semaphore luo_register_rwlock;
 
+static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
+{
+	struct luo_session *session;
+
+	session = container_of(file_set, struct luo_session, file_set);
+
+	return (struct liveupdate_session *)session;
+}
+
+static inline struct luo_file_set *luo_file_set_from_session_locked(struct liveupdate_session *s)
+{
+	struct luo_session *session = (struct luo_session *)s;
+
+	lockdep_assert_held(&session->mutex);
+	return &session->file_set;
+}
+
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
 int __init luo_session_setup_outgoing(void *fdt);
-- 
2.54.0.563.g4f69b47b94-goog

