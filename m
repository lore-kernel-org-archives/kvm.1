Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679FD1A317D
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792540; cv=none; b=AH2AK/MBNB1MYB3G3qyDkh6feZvObhQ8yVFSz7e0AzwjHiCcYotWwSjr6oHiuOs+C6x5yv209fmwEXuIsSYzxdZI5bZ7qqsS+VTjBOwKbpq2AXPPxY0aYm6nl4T20Z1vYfOu+uKXinPgdK6a6y5jg3i2mLmDaxEUN4CsUR1y6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792540; c=relaxed/simple;
	bh=qq1VbnX7+kKmSmHgF89KknczUl189NZt0ovFZK6e3P4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OyBOx64ECDBMjSQNqbZEXcA9jkr52hoG0bAJ31uv43VGT14N5DZh3cv9L4ERxJzLiIW5FceOG3Z4TBQPaLAbkgxqYgVHMiELwKP0MvhffMaeoOXkNw7+/SDPMOGxDBo3ALY9XeFbOiVLgSleskTUo8d67/clWHT69E/83yoPjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTVH4EMZ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTVH4EMZ"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bf5ea9d140eso25855166b.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 17:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780792537; x=1781397337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nufJSt5jy4ZHePo5cxkV3VuIDe3pE4bQw98uSuP49B0=;
        b=NTVH4EMZCN1HIMDif0h/ulbqcZKfq3OuZ9HwVN3KKPaXHbBj3aSur4q1+b3sGwyIpy
         NpSlqYiFGezJpAFCmxl/FX9+JClQFN0/VtASZGkCXlev9pHONRkizy2S4CipY4ZHiW8/
         17A7UujytSkEWIM5bVzd9EsDrTfEARJnYmytcebridRnahqYZvdTcm3W9iOlG/Rhe4P6
         cqeX38waCk+x6ukgqjvtQ21+hdGKmtcCoscblAPS+XzuDQuFIJYRhYEXVWsR5lLpSKtq
         7EST2Bl7eXfftxFW9g2BH1s5OBJO1ajghRkGHhLGuNaBVOSx384mcmSN7jAGoBiUBFmO
         ZueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792537; x=1781397337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nufJSt5jy4ZHePo5cxkV3VuIDe3pE4bQw98uSuP49B0=;
        b=UUgCcXIYf+cHS227BMVGAgQlSAWapqlt0sd4ED0GuCQ9WMJAin5odo7mfbNPBHPzyh
         avcbhbRkGsAf5BkL+ZSta3iBrZTBj0oj3WrjApqIWhA28Bdg0Mg2gqimKzYdLIzZ4rWU
         M0K64PmfV4vpL6obtN1Ia/54yYb8d9Ke6nQYcz8cE8MgKKUI8bJdpdqNJTSnCG4rFnya
         ApcIFP7P7bi/Aw/dFFoE5GqNjueFpIEbo8QNdUrS3l82vEsH4PV5cYqXjQ8s4Ivdt2sQ
         uLE5BylNgwoBfCnnT5QvxBKMs0D+Pl0XCU3yVQ74tfYp63vtnEGMYUoxbHZTlqzCZVf4
         +ICQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bZiSwlzKwukSbkIACoNAjk/wepfvXB4c93srVguwovrFPnJE2njehlI1Ih8U8rsSAw1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxptkey5M93Fi4dR8d4Simz+bgFpCQSkUAIQyE8lJM1fRmCcPqm
	gCibWkV8oRCRshVrMV8r1NCl630tof3sasoLUpO4uAdEZDkJ6J4If4iRw6uwWZGKXRV9tZgGxT9
	xVrZ1U3tBc7vnFePtWA==
X-Received: from ejbuz29.prod.google.com ([2002:a17:907:119d:b0:bcb:78f9:cf78])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:75ed:b0:bec:a1b4:1bb4 with SMTP id a640c23a62f3a-bf3a7302f33mr285294566b.10.1780792536653;
 Sat, 06 Jun 2026 17:35:36 -0700 (PDT)
Date: Sun, 07 Jun 2026 00:35:35 +0000
In-Reply-To: <c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com>
Message-ID: <9huzik7vxk4o.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 01/10] liveupdate: luo_file: Add internal APIs for
 file preservation
From: tarunsahu@google.com
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"


Hi,

I am sorry for incorrect layout of this series. After copy-pasting
I forgot to change the message id in header and the cover letter is not
attached to the same thread.

Please find the V2 cover letter here:
https://lore.kernel.org/all/cover.1780667929.git.tarunsahu@google.com/

Also for latest discussion related to scope:
https://lore.kernel.org/all/9huzldcrxkch.fsf@tarunix.c.googlers.com/

Thankyou

Tarun Sahu <tarunsahu@google.com> writes:

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> The core liveupdate mechanism allows userspace to preserve file
> descriptors. However, kernel subsystems often manage struct file
> objects directly and need to participate in the preservation process
> programmatically without relying solely on userspace interaction.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/liveupdate.h       | 21 ++++++++++
>  kernel/liveupdate/luo_file.c     | 69 ++++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h | 17 ++++++++
>  3 files changed, 107 insertions(+)
>
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 30c5a39ff9e9..de052438eaac 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -24,6 +24,7 @@ struct file;
>  /**
>   * struct liveupdate_file_op_args - Arguments for file operation callbacks.
>   * @handler:          The file handler being called.
> + * @session:          The session this file belongs to.
>   * @retrieve_status:  The retrieve status for the 'can_finish / finish'
>   *                    operation. A value of 0 means the retrieve has not been
>   *                    attempted, a positive value means the retrieve was
> @@ -44,6 +45,7 @@ struct file;
>   */
>  struct liveupdate_file_op_args {
>  	struct liveupdate_file_handler *handler;
> +	struct liveupdate_session *session;
>  	int retrieve_status;
>  	struct file *file;
>  	u64 serialized_data;
> @@ -240,6 +242,13 @@ void liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
>  
>  int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
>  int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
> +/* kernel can internally retrieve files */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep);
> +
> +/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp);
>  
>  #else /* CONFIG_LIVEUPDATE */
>  
> @@ -285,5 +294,17 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
> +					       u64 token, struct file **filep)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +						struct file *file, u64 *tokenp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_LIVEUPDATE */
>  #endif /* _LINUX_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index a0a419085e28..0aa0b4e5339f 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -323,6 +323,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
>  	mutex_init(&luo_file->mutex);
>  
>  	args.handler = fh;
> +	args.session = luo_session_from_file_set(file_set);
>  	args.file = file;
>  	err = fh->ops->preserve(&args);
>  	if (err)
> @@ -380,6 +381,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
>  					   struct luo_file, list);
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.private_data = luo_file->private_data;
> @@ -411,6 +413,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
>  		struct liveupdate_file_op_args args = {0};
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.private_data = luo_file->private_data;
> @@ -432,6 +435,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
>  		struct liveupdate_file_op_args args = {0};
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.private_data = luo_file->private_data;
> @@ -621,6 +625,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
>  	}
>  
>  	args.handler = luo_file->fh;
> +	args.session = luo_session_from_file_set(file_set);
>  	args.serialized_data = luo_file->serialized_data;
>  	err = luo_file->fh->ops->retrieve(&args);
>  	if (err) {
> @@ -654,6 +659,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
>  		struct liveupdate_file_op_args args = {0};
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.retrieve_status = luo_file->retrieve_status;
> @@ -671,6 +677,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
>  	guard(mutex)(&luo_file->mutex);
>  
>  	args.handler = luo_file->fh;
> +	args.session = luo_session_from_file_set(file_set);
>  	args.file = luo_file->file;
>  	args.serialized_data = luo_file->serialized_data;
>  	args.retrieve_status = luo_file->retrieve_status;
> @@ -924,3 +931,65 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>  	luo_flb_unregister_all(fh);
>  	list_del(&ACCESS_PRIVATE(fh, list));
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
> +
> +/**
> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
> + * @s:      The outgoing liveupdate session.
> + * @file:   The file object to search for.
> + * @tokenp: Output parameter for the found token.
> + *
> + * Searches the list of preserved files in an outgoing session for a matching
> + * file object. If found, the corresponding user-provided token is returned.
> + *
> + * This function is intended for in-kernel callers that need to correlate a
> + * file with its liveupdate token.
> + *
> + * Context: It must be called with session mutex acquired.
> + * Return: 0 on success, -ENOENT if the file is not preserved in this session.
> + */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp)
> +{
> +	struct luo_file_set *file_set = luo_file_set_from_session_locked(s);
> +	struct luo_file *luo_file;
> +	int err = -ENOENT;
> +
> +	list_for_each_entry(luo_file, &file_set->files_list, list) {
> +		if (luo_file->file == file) {
> +			if (tokenp)
> +				*tokenp = luo_file->token;
> +			err = 0;
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
> + * @s:      The incoming liveupdate session (restored from the previous kernel).
> + * @token:  The unique token identifying the file to retrieve.
> + * @filep:  On success, this will be populated with a pointer to the retrieved
> + *          'struct file'.
> + *
> + * Provides a kernel-internal API for other subsystems to retrieve their
> + * preserved files after a live update. This function is a simple wrapper
> + * around luo_retrieve_file(), allowing callers to find a file by its token.
> + *
> + * The caller receives a new reference to the file and must call fput() when it
> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
> + * file descriptors. If the caller needs to hold a reference to the file beyond
> + * the immediate scope, it must call get_file() itself.
> + *
> + * Context: It must be called with session mutex acquired of a restored session.
> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
> + *         found, or any other negative errno on failure.
> + */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep)
> +{
> +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
> +				 token, filep);
> +}
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 875844d7a41d..08b198802e7f 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -79,6 +79,23 @@ struct luo_session {
>  
>  extern struct rw_semaphore luo_register_rwlock;
>  
> +static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
> +{
> +	struct luo_session *session;
> +
> +	session = container_of(file_set, struct luo_session, file_set);
> +
> +	return (struct liveupdate_session *)session;
> +}
> +
> +static inline struct luo_file_set *luo_file_set_from_session_locked(struct liveupdate_session *s)
> +{
> +	struct luo_session *session = (struct luo_session *)s;
> +
> +	lockdep_assert_held(&session->mutex);
> +	return &session->file_set;
> +}
> +
>  int luo_session_create(const char *name, struct file **filep);
>  int luo_session_retrieve(const char *name, struct file **filep);
>  int __init luo_session_setup_outgoing(void *fdt);
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
