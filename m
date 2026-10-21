Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596334;
	b=CS5NA7Pb3ZQcxlEk14zPd9TnanFiByfc1UWN+blWcrtL+BQHrzuGTRxgkegsfSsQ9FYL
	 J6VvsihjRMVqIgidfwGBp8+f6BxQipzgdS1uhhGgD/pcs3sbDpZA61C7y2En253hIMgP6
	 +8uWx6L9rKCgrx70hkRBWHMMMkEuFEzWOExPuPHD/eYxMPaZg61LbYRZu3kBGLgKRtHTC
	 fi0/azoCog5Q0j7yJQygCdQcXl5UaHqiZUrmu23p/cTuCHAayfK51ePK9jIXn6fxZQdjj
	 P59mUu06gxsQeTw3Uflc/c7sfqfyb6AuITp5l2SgUAFDvl0Qo7uz7eF3PQiqgocnwSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
	b=uVz2mIG8Y54rvIQtFvhu8YbX1/m7CAcciomMjERD7vDWX5rPvRULLETgziWV+52Jmk6j
	 kOg7Dva5q17Fh8jmGRcK4Niv1+4oWwBzhaMCO1nkAhbtB88r/1nfUVuCFuvQKtkvc/NJZ
	 ZrepJxGL1cvyxg/eYnMXKlytPwxYk4zLyQfvCUUW1gjyfA31XbPY2lpDNZlfu554i4q4m
	 CWB92VfoLVeqaduF3OWZFY88BKnW0Fk1pFhK1i++dod7MwLGlRHWBZHDA2jaqmdkPNcQB
	 s3roNDhgQIMZ2NJaBUQJDgjWUbGW+OUWlulNONPZbzE+VkBrlFfmYwW5b9HFYFu32LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dkqpyNqp;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07060A2613
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 15:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F07060A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dkqpyNqp
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2dd399f761so78614866b.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596332; x=1793201132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
        b=dkqpyNqp41yY7/oxMCemumRID+Op7bhjYa83BNB22tRP/ttHyCTy9bq6BK2iKbrgr6
         TxeyBGCA7iVLdQfRFMqPXYT5vmRhkcWMpZ7lMXpYn6qNa4xyXZqNrkICHgMmcQHgUALV
         +4qnks/hU3ZiFuTSid9pYkwc8rQXgwxtGwedi6BhtTmXVUk22QcSzoXuCSek4paD0wAi
         EHCuEfSmg0+YnU3NH5fFmWFCNNjovUZtr9hjdHdQtLcyQ2uxcUIGZrf1mIXmWSyi9wTS
         oMSjyFfhmhSQaSfLVXRHf3xpSO7mo/tAzB0bzuifh5SAi+7hqXuyBhSEQ771B9bjI2Zb
         D7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596332; x=1793201132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
        b=zLBJzG3hKJ/K3A2PpaZ6Ebg0Tvmq3Rod2gSHduXFTJ0GT/GptKohuvpaOkAlNwRb2Q
         7FtqH6FoTS62pbSHr2xHv9NqlH5seCTlVfnYyruMKV/nEuoF8ywE5+MBT8/2H3jYgdYL
         poVeoVc4JpOaYR0pZfgtof6CI/dItzwNPrGL9tS7+Uhn5mrAoPIg9vX9kj3p9Negszte
         ZHDOnLDgMBY7AsYK4GMqKNHrHSCA76OoTb+ynZgYoZEuwCUHbBEDls/7IzwB6U3dV03g
         3974U0h8lNxHD3QUPqhkZn2GR4UZh3DoLY5yFgsTfQL6AcxcLwTYKUdj1GDl4q5/Aqn/
         LBDg==
X-Forwarded-Encrypted: i=1; AKwUvByxyrxVyBHPNkjCMdDkqDrOd6JmYtvY7VjNhMf83gHCt/KHxYnhGde9Ke0Wx79d4iHmKV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc/PV2YmAg1a/w7k8wy8u2szOylAvoWZVhecsX7jfeKMVKeWUy
	T2yk5p4bE5Z1FwQcSXg7ANkHTEJHs0aj5Rx7Cx2z+dN7xP9xUMhqd1nLuTeKco3SUjYMSIqJCnt
	c8vE/+6LnQt4d/RqzTg==
X-Received: from ejbgw26.prod.google.com ([2002:a17:906:f15a:b0:c3f:b33c:8124])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d40a:b0:c45:d8aa:6ae5 with SMTP id a640c23a62f3a-c46799bdbb7mr204058966b.42.1792596331473;
 Wed, 21 Oct 2026 08:25:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:25:25 +0000
In-Reply-To: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021152527.375070-3-tarunsahu@google.com>
Subject: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently luo_preserve_file() iterates over luo_file_handler_list and
picks the first registered handler whose .can_preserve() callback
returns true. When a subsystem introduces a new, backwards-incompatible
file handler alongside an existing one for the same file type, userspace
has no way to choose which handler preserves a file descriptor, nor can
the kernel keep the existing rollback-safe handler as the default while
allowing callers to opt into the new handler.

Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
liveupdate_session_preserve_fd immediately after token, keeping
IOCTL_OP min_size at offsetofend(..., token) so callers passing the
original 16-byte structure continue to work:
- When handler is empty (all-zero, or zero-filled when userspace
  passes the 16-byte structure), luo_preserve_file() selects the first
  registered handler whose .can_preserve() callback accepts the fd.
- When handler is non-empty, it must be null-terminated within
  LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
  luo_preserve_file() looks up the registered handler with that exact
  name (returning -ENOENT if unknown) and verifies that its
  .can_preserve() callback accepts the fd (returning -EINVAL if not).

The retrieve ioctl is unchanged because the handler is identified by the
name stored in the serialized payload from the source kernel.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/uapi/linux/liveupdate.h  | 12 +++++++++---
 kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
 kernel/liveupdate/luo_internal.h |  3 ++-
 kernel/liveupdate/luo_session.c  |  7 ++++++-
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 509c6236720d..2413b19dabc1 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
 
 /**
  * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)
- * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
- * @fd:    Input; The user-space file descriptor to be preserved.
- * @token: Input; An opaque, unique token for preserved resource.
+ * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
+ * @fd:      Input; The user-space file descriptor to be preserved.
+ * @token:   Input; An opaque, unique token for preserved resource.
+ * @handler: Input; Optional null-terminated file handler name (max length
+ *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) selecting
+ *           which registered handler preserves @fd. If empty (all-zero, or
+ *           omitted when passing the 16-byte structure), the kernel selects
+ *           the first registered handler whose .can_preserve() accepts @fd.
  *
  * Holds parameters for preserving a file descriptor.
  *
@@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
 	__u32		size;
 	__s32		fd;
 	__aligned_u64	token;
+	char		handler[LIVEUPDATE_HNDL_NAME_LENGTH];
 };
 
 #define LIVEUPDATE_SESSION_PRESERVE_FD					\
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index fb81239bedf3..be20e0f1e0aa 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  * @file_set: The file_set to which the preserved file will be added.
  * @token:    A unique, user-provided identifier for the file.
  * @fd:       The file descriptor to be preserved.
+ * @handler:  Optional NUL-terminated handler name. If NULL or empty, the first
+ *            registered handler whose .can_preserve() accepts @fd is selected.
  *
  * This function orchestrates the first phase of preserving a file. Upon entry,
  * it takes a reference to the 'struct file' via fget(), effectively making LUO
@@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  *         -EBUSY if the file descriptor is already preserved by another session.
  *         -EBADF if the file descriptor is invalid.
  *         -ENOSPC if the file_set is full.
- *         -ENOENT if no compatible handler is found for the file type.
+ *         -ENOENT if no matching handler is registered or accepts @fd.
+ *         -EINVAL if the named handler cannot preserve @fd.
  *         -ENOMEM on memory allocation failure.
  *         Other erros might be returned by .preserve().
  */
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const char *handler)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct liveupdate_file_handler *fh;
@@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	err = -ENOENT;
 	down_read(&luo_register_rwlock);
 	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
+		if (handler && handler[0]) {
+			if (strcmp(fh->name, handler))
+				continue;
+			if (!fh->ops->can_preserve(fh, file)) {
+				err = -EINVAL;
+				break;
+			}
+			if (try_module_get(fh->ops->owner))
+				err = 0;
+			break;
+		}
+
 		if (fh->ops->can_preserve(fh, file)) {
 			if (try_module_get(fh->ops->owner))
 				err = 0;
@@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	}
 	up_read(&luo_register_rwlock);
 
-	/* err is still -ENOENT if no handler was found */
 	if (err)
 		goto err_fput;
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..911ffedec9f3 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions_pa);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
 
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const char *handler);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set,
 		    struct luo_file_set_ser *file_set_ser);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..194ef45907c1 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
 	int err;
 
+	if (strnlen(argp->handler, sizeof(argp->handler)) ==
+	    sizeof(argp->handler))
+		return -EINVAL;
+
 	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	err = luo_preserve_file(&session->file_set, argp->token, argp->fd,
+				argp->handler);
 	if (err)
 		return err;
 
-- 
2.56.0.212.g129ede20d9-goog

