Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521D39280C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131289; cv=none; b=klyWTRZrFXzutdoR1tSNENqaA2H/VOht9/AcQ6MT5/gvuwrbG88pTM4S1+X1nb+rSg/9irM10ZSPSnj6STbBbR9iL4XQJy+6N/nqggNS3JjJotgjAY+q4RnHgzbe0UwtIIFC5+lc2m7Pvw0LuIzVmFXYiiqScIi9GTGM4z9ht5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131289; c=relaxed/simple;
	bh=E3Kryer03O2/9Oyd1Uw9KKyE+KASGqSz2vSPV4e+764=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp/d7qoP2K97LKI1u8LTGki003l6LoT5UVcsgETGEou4KXyGqIUYygKB17MiXMoP9GALiHJo3eaUbign9L4sOqJlo9mFgvhhBojjFizIPCjOwALW9bHR44qNVUAYQcUCku9vgf+2ZZVRrPZnfMyQHQNdPD2NGDmGBassd0oAHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6qI5u9s; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6qI5u9s"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1085ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779131286; x=1779736086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZU0H6rmWmp4oi8XbArQtxOYDJ2GP70DX/0QfuCGiOE=;
        b=p6qI5u9sMGK+mVgPNudq7z300tibNdUYHgyHqBnst0NPLl3/b6Wp8K5FYPp8BzysEg
         gEBVYDwmFjiBtGU/hUNgo/j936wGicRlR2sxXm48+BdP3bd+i+1nHfJWVzgJwffzmfho
         Q7s1kaK/xLD288kdnTFVniOGByxEZh9KuUZOEj3bsTurhEmuyumNBF62aiMmSxSik2yG
         LVJyneu3LrKca915ix0jVRY/QqEFOQARaxB5omFiG5JjvLYbazjClJ5+fkFlowprKq2K
         wmS98Ibiu9BoQ7gloY9qzulK1fzc6+LE+UVLxt4KEJ4zH07/l4PxL4QQOhMb1xc2PB79
         T4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131286; x=1779736086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZU0H6rmWmp4oi8XbArQtxOYDJ2GP70DX/0QfuCGiOE=;
        b=pKckOudUWSYCP1KQrmgw/dqh2tBrV+SqeI37J+pkXQrNeijWXjzZRU9MDlpyHzljLX
         lOcHC1Bv3qmH1myWBF4fjXhQ5TpjajZYIpy2Gmbe4yzkKd8Y0gzuMCj+8lrAUEFbHXne
         JveV82r0Ez1q55lEte63BPayonusxGt7ZgaEftTNV7h7xXMGjjf+Y548KEXHD775H94H
         Rp0djbTR8C5StCtB5xLG7PkdQmisMRMyfTVRPp9nq54WvtQDHlLKh3WlbrBmIoF/QXe1
         tNpCmigdeVbn3OpSuWu5MOfJ0RCYP0MNUS9xaAguEoon3njXKGM5JFQ62NaEzUPnKFJG
         PRYg==
X-Forwarded-Encrypted: i=1; AFNElJ99Ig0ucD9M7S3ueOrWE0hoGnj4SaIgLVoQ8JmHwFSRFm0zY54y5JNg7ZCp2FdDwxpDMFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydw4UbvzwRKyynAI39dbUBSllkWlavC3NeUmv169oJEUM1zccG
	VmSk2gnBmd23nbXcKRi6esLefV5LnIu5nyA+H+VpvMj4c0Ve/iGPnYi/8GPbfksMQw==
X-Gm-Gg: Acq92OEFQkhuYWBD4LBfxqh8YGkZWqEjc09rxobNfLgJ6IDRWaNQc3/KqmRGu+TM3Am
	f4LJ6CAl1KOCHyeSKOD6FDUA/mtpFe0iVReyXNNjvlPU6IxJaXAMCsTujGmPMwfWJJ6bdJidTMn
	qwleMfHDAHc8+CLgRTY0XjpwK/l4V4HUqwP7rirLMv49LQgvdWIWskKPfw3716/UEyQxo0tn+jO
	i7CEyIQ0OCf+QvhQPVvsRZM2z8V1CCIiG/LyXEM+UFdxR96FzVaajleJQ/dIndkg3SvdSyx3OYn
	NekfY50mFUNWZCzIuxPQQxmLpwnec08rI2mwDUqB4M8n+ihdR5TdjCq0zUBvMkfGU+J0B1Kymfp
	5e6gSudHjVkHfoTUgsQmL299uZmz1fm+aae52qzzmOVTW3/oVy0P6SQun+WT+UdgByks8iq6IsA
	awSlyfdNVBAjNXPLnLOfVgUbactgH0ixQsK4qIoCdgezOT3UOPwJ0jlPmsESRRdnAmKK7iHQ==
X-Received: by 2002:a17:903:46ce:b0:2bd:9e75:9e98 with SMTP id d9443c01a7336-2bdb329b484mr3857735ad.9.1779131285670;
        Mon, 18 May 2026 12:08:05 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm14148605a12.11.2026.05.18.12.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:05 -0700 (PDT)
Date: Mon, 18 May 2026 19:08:01 +0000
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
Subject: Re: [PATCH v2 01/16] liveupdate: luo_file: Add internal APIs for
 file preservation
Message-ID: <agth8vZh96TfEYl_@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-2-skhawaja@google.com>
 <agr6yoyYYq2QFxjL@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agr6yoyYYq2QFxjL@google.com>

On Mon, May 18, 2026 at 11:40:58AM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:18PM +0000, Samiullah Khawaja wrote:
>> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> The core liveupdate mechanism allows userspace to preserve file
>> descriptors. However, kernel subsystems often manage struct file
>> objects directly and need to participate in the preservation process
>> programmatically without relying solely on userspace interaction.
>>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>[..]
>
>> @@ -924,3 +931,65 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>>  	luo_flb_unregister_all(fh);
>>  	list_del(&ACCESS_PRIVATE(fh, list));
>>  }
>> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>> +

[snip]
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
>> + * The caller receives a new reference to the file and must call fput() when it
>> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
>> + * file descriptors. If the caller needs to hold a reference to the file beyond
>> + * the immediate scope, it must call get_file() itself.
>
>Thanks for re-wording this and I'm sorry for being a stickler here, I'm
>a bit concerned that the last part here might lead to reference leaks in
>downstream drivers.
>
>Looking at the underlying luo_retrieve_file() implementation [1], it
>explicitly calls get_file() before returning the pointer (both on the
>initial retrieve and on cached ones). This means the caller inherently
>receives a reference that they own & the caller is responsible for
>exactly one fput().
>
>However, that last part of the comment can be misunderstood as the caller
>doesn't hold a lasting reference unless they call get_file() themselves.
>This makes the reader assume that LUO is going to automatically reap
>that initial reference from them.
>
>If a driver author assumes LUO is going to reap it, they will follow that
>last sentence and call get_file() to stash the pointer safely. They might
>end up holding two references (thinking one of them will be reaped), and
>could ultimately leak the struct file when they only call fput() once
>during teardown.
>
>Should we just drop that last sentence to make the lifecycle contract
>unambiguous? (i.e., The caller gets a newly bumped reference, and they
>are responsible for exactly one fput() per call).

I think these are all valid points. I will remove the last sentences for
clarity.
>
>> + *
>> + * Context: It must be called with session mutex acquired of a restored session.
>> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
>> + *         found, or any other negative errno on failure.
>> + */
>> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> +				 struct file **filep)
>> +{
>> +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
>> +				 token, filep);
>> +}
>
>Nit: Shouldn't we export both of these functions via EXPORT_SYMBOL_GPL?
>Since, these new APIs are intended for kernel subsystems to participate
>programmatically, there could be IOMMU drivers (or others) that can be
>compiled as loadable modules. Thus we should export these APIs via
>EXPORT_SYMBOL_GPL(). If they aren't exported, any loadable module
>attempting to use them will compile successfully (due to the header), but
>will fail to load at runtime with an Unknown symbol error.
>
>IIUC, if a function isn't exported with EXPORT_SYMBOL, it remains hidden
>inside vmlinux, (i.e. it isn't in the kernel's global symbol table used
>during modprobe).

Agreed. Will Update this.

I think there are other LUO APIs that are not exported and can be used
by modules. Let me check those also.
>
>Thanks,
>Praan
>
>[1] https://elixir.bootlin.com/linux/v7.0-rc3/source/kernel/liveupdate/luo_file.c#L560
>
