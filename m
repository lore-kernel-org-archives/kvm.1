Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D7218821
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852866; cv=none; b=KBKTgpIUImpE7BOtVTq7eEtMyr22Y3KXa4JqGS5ThXKKbQPPazzfjnXvp7c00WlPBDAPfwCre4GCnDfJymZBWO1lNdU637HiWWGbzCUDSLW/sG3v1IcPPmdbpcL+L0nIZ3kyLjPPrBdcZYzx/jqO3IlayfbyGoqdVvdG6OxZrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852866; c=relaxed/simple;
	bh=5VBV/A5uYC0jGc3viP6Xi9yTNYCk7D9ZKDvsyPHOlcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG0UpVhBCuRRfZC+bZzgL5If62vTK3/+6On03SbHscMiMNj9JXwKoXh5wLIxELcH6TUyV3oVcK+qZh8swtArqNiBLvndXKojRB8I/lP6jD+pUWy3a3YvwzNrkNmjeOZQDG7FrlUMRqu/cn6YliiKLKnXELFdL3TKdw2Ah9iEzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTjb9qBu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTjb9qBu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so1265ad.0
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773852864; x=1774457664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JEhMqYUt8uX7RNOVC4nIPLjZyTL3AlX18iCN9fMlH8=;
        b=bTjb9qBuaZ9tBDmVAkTrAY1gakC8Qf8fy6XHYtp6uDdSDbps+mD6xBO+oi6Zm8UI/7
         YkjPlBDhw024PR1TXTMMshjbAFkSQcTz+yCmQ8mQG0qFvPjBUXsTPe1P2h9UT1x70O/2
         M6nM70yTLDco6yOwK++XW9F43XYDAj+DApHNk/L+/m3nb6SHTMrhPtmAPWpgXJDjHm8p
         vAF1knUMsIIjr3kQ8TqmJrB/ZrgPFW1WBKo/kBQRydioNruiufK+tOtmp7jcVKKb5B1/
         wjB7wJuuN46mVeCHqV3YcRpOs//LEcrcn9+yCpb7ICM7+r/N1bKI6fEXiuaQ1DIHX/61
         WTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852864; x=1774457664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JEhMqYUt8uX7RNOVC4nIPLjZyTL3AlX18iCN9fMlH8=;
        b=HMRReDoBj5tqTZqi79ujzLW0Pmbw2jk9hiPJZoeQSYyBI3KRsoUSJHJT6gHcYHV4Zq
         r+Z6OwyW3fpMukDjb7NAcKmBo7YJGudVEXgftY6fDnvK/RE4w1E6ghvq58LNDT8f7GFG
         /tiDOypPJd/PU+reCM1W39PVmSwjwbsOiIFv42A7EkhHBo6W5K/R1H1VxFfqUQ5xqcTc
         rSPU0MlnRGNKYU5jUY/pVVInrQRSmHmpl6jfHzZTrMDIqUoU6ag/zgh6oUoj1rpPAjiS
         LIICl9soecB0gS95IPD97DJKMxyEM8NbQEtbF4FVTCGxnC+SVvB/4s8KOGlOhXEx7Zmc
         WQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCW65Iqsa+gsbmm83tgIUIXLrtjFACnDCa6maB1e9v/v9dZXQYQ5PSyBR7aKadgom1hlT/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspnYPzWEN/0OEnPBcjkQ6jzG6RTZvriPRmsZvroh6HR1qFIR2
	OX3inJlPI0jvX46Hcvt1wDXVRXcC0TwGAj5SgtFr95viJSmXV7iCSD1qheAbvrEaZg==
X-Gm-Gg: ATEYQzzXkv7JExffPnxE51aLkWGCc++rQg8WQYaF24HkSVNRJgJNFhvB19qIlGeKoLA
	Eq3GbJi71JYlxZqq8Wubiq8oENZo/roqY8V0iQJ8PsHsZYYBuASG6DU/g25c1uKTjWXOR0xoprr
	D8abSCB+qFXTV+OC7HBCkoiZw1BNPH5xYD0rOY7LzmkpQGlsmGSocsjl1FNx+868U91cvetq00U
	8VG6eZ9Uugo8POz/5SCXxqiynhySLfAsClRZ3u/S7Os3I5U7nlFs92DmPeV8KjlO0CdrV2n6MW9
	UHx8vaP3+lqeCh0Tafn+7yHv0XjsRiyfyh8HpncCTslW5WOFfayb26k2wIqo4UVJNewk51bZfHq
	pWGmGbx/0nXnrzIk6ZDPPifWwpw2Rfl5uEL80C05x4xukrfL395qmY6QK8RHe7KC7Srb4kV3reX
	uaYo2qLfDKJnWrgPIfcWgVPAFiIiMRa3ynAhY/Rqc/65pq0t+bqWYBVMjYUC579g==
X-Received: by 2002:a17:903:1a06:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2b06e871446mr3657205ad.12.1773852863842;
        Wed, 18 Mar 2026 09:54:23 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e603937sm33038865ad.57.2026.03.18.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:54:23 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:54:19 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 03/14] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <abrUcJ__lv0N_fvp@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-4-skhawaja@google.com>
 <abp32cJgCUEWK6u-@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abp32cJgCUEWK6u-@google.com>

On Wed, Mar 18, 2026 at 10:00:57AM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:37PM +0000, Samiullah Khawaja wrote:
>> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> The core liveupdate mechanism allows userspace to preserve file
>> descriptors. However, kernel subsystems often manage struct file
>> objects directly and need to participate in the preservation process
>> programmatically without relying solely on userspace interaction.
>>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  include/linux/liveupdate.h       | 21 ++++++++++
>>  kernel/liveupdate/luo_file.c     | 71 ++++++++++++++++++++++++++++++++
>>  kernel/liveupdate/luo_internal.h | 16 +++++++
>>  3 files changed, 108 insertions(+)
>>
>> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
>> index fe82a6c3005f..8e47504ba01e 100644
>> --- a/include/linux/liveupdate.h
>> +++ b/include/linux/liveupdate.h
>> @@ -23,6 +23,7 @@ struct file;
>>  /**
>>   * struct liveupdate_file_op_args - Arguments for file operation callbacks.
>>   * @handler:          The file handler being called.
>> + * @session:          The session this file belongs to.
>>   * @retrieved:        The retrieve status for the 'can_finish / finish'
>>   *                    operation.
>>   * @file:             The file object. For retrieve: [OUT] The callback sets
>> @@ -40,6 +41,7 @@ struct file;
>>   */
>>  struct liveupdate_file_op_args {
>>  	struct liveupdate_file_handler *handler;
>> +	struct liveupdate_session *session;
>>  	bool retrieved;
>
>Nit: I don't think this is on the latest tree. I see `int retrieved` [1]
>in the latest tree. I guess we'd need to rebase it on the latest?

Will rebase this.
>
>https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/liveupdate.h#n46
>
>>  	struct file *file;
>>  	u64 serialized_data;
>> @@ -234,6 +236,13 @@ int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
>>
>>  int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
>>  int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
>> +/* kernel can internally retrieve files */
>> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> +				 struct file **filep);
>> +
>> +/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
>> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> +				  struct file *file, u64 *tokenp);
>>
>>  #else /* CONFIG_LIVEUPDATE */
>>
>> @@ -281,5 +290,17 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
>>  	return -EOPNOTSUPP;
>>  }
>>
>> +static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
>> +					       u64 token, struct file **filep)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> +						struct file *file, u64 *tokenp)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>  #endif /* CONFIG_LIVEUPDATE */
>>  #endif /* _LINUX_LIVEUPDATE_H */
>> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>> index 32759e846bc9..7ac591542059 100644
>> --- a/kernel/liveupdate/luo_file.c
>> +++ b/kernel/liveupdate/luo_file.c
>> @@ -302,6 +302,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
>>  	mutex_init(&luo_file->mutex);
>>
>>  	args.handler = fh;
>> +	args.session = luo_session_from_file_set(file_set);
>>  	args.file = file;
>>  	err = fh->ops->preserve(&args);
>>  	if (err)
>> @@ -355,6 +356,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
>>  					   struct luo_file, list);
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.private_data = luo_file->private_data;
>> @@ -383,6 +385,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
>>  		struct liveupdate_file_op_args args = {0};
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.private_data = luo_file->private_data;
>> @@ -404,6 +407,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
>>  		struct liveupdate_file_op_args args = {0};
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.private_data = luo_file->private_data;
>> @@ -590,6 +594,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
>>  	}
>>
>>  	args.handler = luo_file->fh;
>> +	args.session = luo_session_from_file_set(file_set);
>>  	args.serialized_data = luo_file->serialized_data;
>>  	err = luo_file->fh->ops->retrieve(&args);
>>  	if (!err) {
>> @@ -615,6 +620,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
>>  		struct liveupdate_file_op_args args = {0};
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.retrieved = luo_file->retrieved;
>> @@ -632,6 +638,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
>>  	guard(mutex)(&luo_file->mutex);
>>
>>  	args.handler = luo_file->fh;
>> +	args.session = luo_session_from_file_set(file_set);
>>  	args.file = luo_file->file;
>>  	args.serialized_data = luo_file->serialized_data;
>>  	args.retrieved = luo_file->retrieved;
>> @@ -919,3 +926,67 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>>  	return err;
>>  }
>>  EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>> +
>> +/**
>> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
>> + * @s:      The outgoing liveupdate session.
>> + * @file:   The file object to search for.
>> + * @tokenp: Output parameter for the found token.
>> + *
>> + * Searches the list of preserved files in an outgoing session for a matching
>> + * file object. If found, the corresponding user-provided token is returned.
>> + *
>> + * This function is intended for in-kernel callers that need to correlate a
>> + * file with its liveupdate token.
>> + *
>> + * Context: Can be called from any context that can acquire the session mutex.

I will reword this to convey that the session mutex should be acquired.
>> + * Return: 0 on success, -ENOENT if the file is not preserved in this session.
>> + */
>> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> +				  struct file *file, u64 *tokenp)
>> +{
>> +	struct luo_file_set *file_set = luo_file_set_from_session(s);
>> +	struct luo_file *luo_file;
>> +	int err = -ENOENT;
>> +
>> +	list_for_each_entry(luo_file, &file_set->files_list, list) {
>
>Shouldn't we hold a lock while traversing the file_set? Couldn't this
>race with an unpreserve? If a concurrent unpreserve (writer) calls
>list_del while this reader is mid-iteration, we'll likely follow a stale
>pointer..

The session mutex is supposed to be acquired when this function is
called. I will add a lockdep in this function to enforce that.

Also, we call this in preserve() of vfio-cdev and the session mutex is
already acquired by luo in that context.
>
>I noticed that luo_preserve_file / upreserve and retrieve also don't
>take locks while manipulating / iterating  over file_set->files_list..
>
>Shouldn't we protect these with a lock? Otherwise, how do we avoid
>races in situations like:
>
>1. CPU 0 (reader) is iterating the list A->B->C ..
>2. CPU 1 (writer) is handling an unpreserve which remove file B
>
>Am I missing something? If we're expecting the callers to hold a lock,
>we should have a lockdep_assert in these functions..

The LUO acquires session mutex before calling preserve/unpreserve to
protect agains race conditions. See luo_session.c for details.
>
>> +		if (luo_file->file == file) {
>> +			if (tokenp)
>> +				*tokenp = luo_file->token;
>> +			err = 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
>> + * @s:      The incoming liveupdate session (restored from the previous kernel).
>> + * @token:  The unique token identifying the file to retrieve.
>> + * @filep:  On success, this will be populated with a pointer to the retrieved
>> + *          'struct file'.
>> + *
>> + * Provides a kernel-internal API for other subsystems to retrieve their
>> + * preserved files after a live update. This function is a simple wrapper
>> + * around luo_retrieve_file(), allowing callers to find a file by its token.
>> + *
>> + * The operation is idempotent; subsequent calls for the same token will return
>> + * a pointer to the same 'struct file' object.
>> + *
>> + * The caller receives a new reference to the file and must call fput() when it
>> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
>> + * file descriptors. If the caller needs to hold a reference to the file beyond
>> + * the immediate scope, it must call get_file() itself.
>> + *
>
>I'm little confused here, we say the op is idempotent, but also mention
>that the caller receives a new reference. I'm wondering of a situation
>where a driver calls this multiple times, incrementing the refcount with
>each call. Do we rely on flb_file_finish to drop all the refcounts?
>
>We should clarify the lifecycle requirements here: is the driver
>expected to call fput() for every single call to
>liveupdate_get_file_incoming(), or is the flb_finish callback intended
>to be a 'catch-all' that reaps these?

The user is supposed to call fput to release the reference as mentioned
in the kernel-doc above.

But I agree it is a little confusing with the idempotent. I will reword
the text.
>
>> + * Context: Can be called from any context in the new kernel that has a handle
>> + *          to a restored session.
>> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
>> + *         found, or any other negative errno on failure.
>> + */
>> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> +				 struct file **filep)
>> +{
>> +	return luo_retrieve_file(luo_file_set_from_session(s), token, filep);
>> +}
>> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
>> index 8083d8739b09..a24933d24fd9 100644
>> --- a/kernel/liveupdate/luo_internal.h
>> +++ b/kernel/liveupdate/luo_internal.h
>> @@ -77,6 +77,22 @@ struct luo_session {
>>  	struct mutex mutex;
>>  };
>>
>> +static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
>> +{
>> +	struct luo_session *session;
>> +
>> +	session = container_of(file_set, struct luo_session, file_set);
>> +
>> +	return (struct liveupdate_session *)session;
>> +}
>> +
>> +static inline struct luo_file_set *luo_file_set_from_session(struct liveupdate_session *s)
>> +{
>> +	struct luo_session *session = (struct luo_session *)s;
>> +
>> +	return &session->file_set;
>> +}
>> +
>>  int luo_session_create(const char *name, struct file **filep);
>>  int luo_session_retrieve(const char *name, struct file **filep);
>>  int __init luo_session_setup_outgoing(void *fdt);
>> --
>>
>
>Thanks,
>Praan
